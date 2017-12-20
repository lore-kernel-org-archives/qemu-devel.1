Received: from eggs.gnu.org ([2001:4830:134:3::10]:50792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1eRloo-0003J7-Hl
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 16:22:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1eRlol-0008Ty-Dw
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 16:22:26 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:43317)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1eRlol-0008Ta-79
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 16:22:23 -0500
Received: by mail-wm0-f67.google.com with SMTP id n138so12409961wmg.2
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 13:22:23 -0800 (PST)
Date: Wed, 20 Dec 2017 22:22:19 +0100
From: Thomas Huth <huth@tuxfamily.org>
Message-ID: <20171220222219.7cdf2a57@thl530>
In-Reply-To: <20171220203528.21334-1-laurent@vivier.eu>
References: <20171220203528.21334-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/m68k: add monitor.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>

Am Wed, 20 Dec 2017 21:35:28 +0100
schrieb Laurent Vivier <laurent@vivier.eu>:

> This allows to use registers content in the monitor.
> 
> Example:
> 
>  BEFORE:
>   (qemu) print $d0
>   unknown register
> 
>  AFTER:
>   (qemu) print $d0
>   0
>   (qemu) print $sr
>   0x2000
>   (qemu) x/10i $pc
>   0x40010a2a:  movew %sr,%d0
>   0x40010a2c:  oril #1792,%d0
>   0x40010a32:  movew %d0,%sr
>   0x40010a34:  movel %a0@,%d0
>   0x40010a36:  btst #3,%d0
>   0x40010a3a:  beqs 0x40010a26
>   0x40010a3c:  movew %sr,%d0
>   0x40010a3e:  andil #63743,%d0
>   0x40010a44:  movew %d0,%sr
>   0x40010a46:  rts
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  target/m68k/Makefile.objs |  1 +
>  target/m68k/monitor.c     | 55
> +++++++++++++++++++++++++++++++++++++++++++++++ 2 files changed, 56
> insertions(+) create mode 100644 target/m68k/monitor.c
> 
> diff --git a/target/m68k/Makefile.objs b/target/m68k/Makefile.objs
> index 39141ab93d..d143f20270 100644
> --- a/target/m68k/Makefile.objs
> +++ b/target/m68k/Makefile.objs
> @@ -1,3 +1,4 @@
>  obj-y += m68k-semi.o
>  obj-y += translate.o op_helper.o helper.o cpu.o fpu_helper.o
>  obj-y += gdbstub.o
> +obj-$(CONFIG_SOFTMMU) += monitor.o
> diff --git a/target/m68k/monitor.c b/target/m68k/monitor.c
> new file mode 100644
> index 0000000000..03d037ccab
> --- /dev/null
> +++ b/target/m68k/monitor.c
> @@ -0,0 +1,55 @@
> +/*
> + * QEMU monitor
> + *
> + * Copyright (c) 2003-2004 Fabrice Bellard

Why this copyright line (and the non-GPL license code)?

Apart from that, the patch looks fine to me.

 Thomas
