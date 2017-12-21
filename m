Received: from eggs.gnu.org ([2001:4830:134:3::10]:52949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1eS0sZ-0006b7-2N
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 08:27:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1eS0sU-0004NZ-Qt
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 08:27:19 -0500
Received: from mail-lf0-f53.google.com ([209.85.215.53]:43561)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1eS0sU-0004LF-JX
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 08:27:14 -0500
Received: by mail-lf0-f53.google.com with SMTP id o26so13675827lfc.10
	for <qemu-devel@nongnu.org>; Thu, 21 Dec 2017 05:27:14 -0800 (PST)
References: <20171221083057.17942-1-laurent@vivier.eu>
From: Thomas Huth <huth@tuxfamily.org>
Message-ID: <7ae031b3-4186-ad35-ff99-2f2e68f99753@tuxfamily.org>
Date: Thu, 21 Dec 2017 14:27:10 +0100
MIME-Version: 1.0
In-Reply-To: <20171221083057.17942-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] target/m68k: add monitor.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 21.12.2017 09:30, Laurent Vivier wrote:
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
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v2: change license to GPL 2 and later
>     add static
> 
>  target/m68k/Makefile.objs |  1 +
>  target/m68k/monitor.c     | 39 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 40 insertions(+)
>  create mode 100644 target/m68k/monitor.c

Reviewed-by: Thomas Huth <huth@tuxfamily.org>
