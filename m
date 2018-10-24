Received: from eggs.gnu.org ([2001:4830:134:3::10]:38813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gFSQC-0003d1-DW
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 19:18:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gFSQ9-0004qm-32
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 19:18:40 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51471)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gFSQ6-0004l5-TQ
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 19:18:35 -0400
Received: by mail-wm1-f67.google.com with SMTP id 143-v6so6980628wmf.1
	for <qemu-devel@nongnu.org>; Wed, 24 Oct 2018 16:18:33 -0700 (PDT)
References: <1540376314-5727-1-git-send-email-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3a04e8e5-22a7-efe4-2187-aaf5fcc95099@redhat.com>
Date: Thu, 25 Oct 2018 01:18:30 +0200
MIME-Version: 1.0
In-Reply-To: <1540376314-5727-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] configs/alpha: Remove unused
 CONFIG_PARALLEL_ISA switch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 24/10/18 12:18, Thomas Huth wrote:
> We don't use CONFIG_PARALLEL_ISA in any of our Makefiles, so this
> is just a dead config option which can be removed.
> 
> Fixes: a4cb773928e047b137c6998209cf2eec857fac6b

Oops, this slipped while refactoring the series, this is part of a 
further cleanup that I never finished. Hopefully Kconfig will outdate it.

Thanks for cleaning this!

> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>   default-configs/alpha-softmmu.mak | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/default-configs/alpha-softmmu.mak b/default-configs/alpha-softmmu.mak
> index bbe361f..61435cc 100644
> --- a/default-configs/alpha-softmmu.mak
> +++ b/default-configs/alpha-softmmu.mak
> @@ -8,7 +8,6 @@ CONFIG_I82374=y
>   CONFIG_I8254=y
>   CONFIG_I8257=y
>   CONFIG_PARALLEL=y
> -CONFIG_PARALLEL_ISA=y
>   CONFIG_FDC=y
>   CONFIG_PCKBD=y
>   CONFIG_VGA_CIRRUS=y
> 
