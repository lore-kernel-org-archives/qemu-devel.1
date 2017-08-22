Received: from eggs.gnu.org ([2001:4830:134:3::10]:40270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1djys2-0003Ne-9F
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 22:24:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1djyrx-0006V6-Bg
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 22:24:46 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:36806)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1djyrx-0006Up-6W
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 22:24:41 -0400
Received: by mail-qt0-x241.google.com with SMTP id c15so15904260qta.3
	for <qemu-devel@nongnu.org>; Mon, 21 Aug 2017 19:24:39 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170731085110.1050-1-apahim@redhat.com>
	<20170731085110.1050-6-apahim@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <620a8751-556a-48d1-d35d-6855faa02eec@amsat.org>
Date: Mon, 21 Aug 2017 23:24:29 -0300
MIME-Version: 1.0
In-Reply-To: <20170731085110.1050-6-apahim@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v6 5/7] qemu.py: use os.path.null instead
 of /dev/null
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Amador Pahim <apahim@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, ldoktor@redhat.com, famz@redhat.com, ehabkost@redhat.com, stefanha@gmail.com, armbru@redhat.com, mreitz@redhat.com, crosa@redhat.com

On 07/31/2017 05:51 AM, Amador Pahim wrote:
> For increased portability, let's use os.path.devnull.
> 
> Signed-off-by: Amador Pahim <apahim@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   scripts/qemu.py | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/qemu.py b/scripts/qemu.py
> index 9434ccc30b..d313c6d4db 100644
> --- a/scripts/qemu.py
> +++ b/scripts/qemu.py
> @@ -80,7 +80,7 @@ class QEMUMachine(object):
>           fd_param = ["%s" % self._socket_scm_helper,
>                       "%d" % self._qmp.get_sock_fd(),
>                       "%s" % fd_file_path]
> -        devnull = open('/dev/null', 'rb')
> +        devnull = open(os.path.devnull, 'rb')
>           p = subprocess.Popen(fd_param, stdin=devnull, stdout=sys.stdout,
>                                stderr=sys.stderr)
>           return p.wait()
> @@ -137,7 +137,7 @@ class QEMUMachine(object):
>   
>       def launch(self):
>           '''Launch the VM and establish a QMP connection'''
> -        devnull = open('/dev/null', 'rb')
> +        devnull = open(os.path.devnull, 'rb')
>           qemulog = open(self._qemu_log_path, 'wb')
>           try:
>               self._pre_launch()
> 
