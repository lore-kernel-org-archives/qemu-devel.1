Received: from eggs.gnu.org ([2001:4830:134:3::10]:42540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dk6MS-0005h2-B5
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 06:24:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dk6MN-0002Tt-Cs
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 06:24:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43500)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dk6MN-0002RM-5b
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 06:24:35 -0400
Date: Tue, 22 Aug 2017 18:24:27 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170822102427.GA7529@lemon>
References: <20170818170526.13496-1-apahim@redhat.com>
	<20170818170526.13496-4-apahim@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170818170526.13496-4-apahim@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 03/11] qemu.py: use os.path.null instead
 of /dev/null
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Amador Pahim <apahim@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@gmail.com, berrange@redhat.com, ehabkost@redhat.com, mreitz@redhat.com, kwolf@redhat.com, armbru@redhat.com, crosa@redhat.com, ldoktor@redhat.com

On Fri, 08/18 19:05, Amador Pahim wrote:
> For increased portability, let's use os.path.devnull.
> 
> Signed-off-by: Amador Pahim <apahim@redhat.com>
> ---
>  scripts/qemu.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/qemu.py b/scripts/qemu.py
> index ef531bb23b..51545f7f97 100644
> --- a/scripts/qemu.py
> +++ b/scripts/qemu.py
> @@ -78,7 +78,7 @@ class QEMUMachine(object):
>          fd_param = ["%s" % self._socket_scm_helper,
>                      "%d" % self._qmp.get_sock_fd(),
>                      "%s" % fd_file_path]
> -        devnull = open('/dev/null', 'rb')
> +        devnull = open(os.path.devnull, 'rb')
>          p = subprocess.Popen(fd_param, stdin=devnull, stdout=subprocess.PIPE,
>                               stderr=subprocess.STDOUT)
>          output = p.communicate()[0]
> @@ -139,7 +139,7 @@ class QEMUMachine(object):
>  
>      def launch(self):
>          '''Launch the VM and establish a QMP connection'''
> -        devnull = open('/dev/null', 'rb')
> +        devnull = open(os.path.devnull, 'rb')
>          qemulog = open(self._qemu_log_path, 'wb')
>          try:
>              self._pre_launch()
> -- 
> 2.13.5
> 

Reviewed-by: Fam Zheng <famz@redhat.com>
