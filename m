Received: from eggs.gnu.org ([2001:4830:134:3::10]:45394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dk6Yh-0005Kp-T2
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 06:37:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dk6Ye-0003Rp-PX
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 06:37:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45648)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dk6Ye-0003RU-JE
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 06:37:16 -0400
Date: Tue, 22 Aug 2017 18:37:09 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170822103709.GD3210@lemon>
References: <20170818170526.13496-1-apahim@redhat.com>
	<20170818170526.13496-10-apahim@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170818170526.13496-10-apahim@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 09/11] qemu.py: launch vm only if it's
 not running
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
> A new call to launch() with a running VM will fall in exception and
> consequently call shutdown().
> 
> This patch makes launch() to raise an exception when it's called with VM
> already running.
> 
> Signed-off-by: Amador Pahim <apahim@redhat.com>
> ---
>  scripts/qemu.py | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/scripts/qemu.py b/scripts/qemu.py
> index 9ae65e454e..46e8ff3232 100644
> --- a/scripts/qemu.py
> +++ b/scripts/qemu.py
> @@ -170,6 +170,9 @@ class QEMUMachine(object):
>          self._iolog = None
>          self._qemu_full_args = None
>          devnull = open(os.path.devnull, 'rb')
> +        if self.is_running():
> +            raise QEMULaunchError('VM already running')
> +
>          try:
>              self._pre_launch()
>              self._qemu_full_args = (self._wrapper + [self._binary] +
> -- 
> 2.13.5
> 

Reviewed-by: Fam Zheng <famz@redhat.com>
