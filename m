Received: from eggs.gnu.org ([2001:4830:134:3::10]:60148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dp4PG-0000WM-RB
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 23:20:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dp4PC-00029c-3y
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 23:20:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54924)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dp4PB-00029I-VT
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 23:20:02 -0400
Date: Tue, 5 Sep 2017 11:19:57 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170905031957.GO22515@lemon.lan>
References: <20170901112829.2571-1-apahim@redhat.com>
	<20170901112829.2571-13-apahim@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170901112829.2571-13-apahim@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v8 12/13] qemu.py: launch vm only if it's
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
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, ldoktor@redhat.com, ehabkost@redhat.com, stefanha@gmail.com, armbru@redhat.com, mreitz@redhat.com, crosa@redhat.com

On Fri, 09/01 13:28, Amador Pahim wrote:
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
> index 03e4cc34b7..363f649a7e 100644
> --- a/scripts/qemu.py
> +++ b/scripts/qemu.py
> @@ -165,6 +165,9 @@ class QEMUMachine(object):
>          Try to launch the VM and make sure we cleanup and expose the
>          command line/output in case of exception.
>          '''
> +        if self.is_running():
> +            raise QEMUMachineError('VM already running')
> +
>          self._iolog = None
>          self._qemu_full_args = None
>          try:
> -- 
> 2.13.5
> 
> 

Reviewed-by: Fam Zheng <famz@redhat.com>
