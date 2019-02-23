Received: from eggs.gnu.org ([209.51.188.92]:43458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gxgbR-0006dG-MJ
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 18:21:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gxgbQ-00039M-Lz
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 18:21:05 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41040)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gxgbQ-000226-Bc
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 18:21:04 -0500
Received: by mail-wr1-x444.google.com with SMTP id n2so6049714wrw.8
	for <qemu-devel@nongnu.org>; Sat, 23 Feb 2019 15:20:30 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1550863578-30859-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1550863578-30859-5-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <211b9471-7f27-12f8-bfb1-db56dcc28df4@amsat.org>
Date: Sun, 24 Feb 2019 00:20:26 +0100
MIME-Version: 1.0
In-Reply-To: <1550863578-30859-5-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 4/8] qemu-doc: Move section on MIPS'
 mipssim pseudo board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: arikalo@wavecomp.com, amarkovic@wavecomp.com, aurelien@aurel32.net

On 2/22/19 8:26 PM, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> Move section on MIPS' mipssim pseudo board to the more
> appropriate place.
> 
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  qemu-doc.texi | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/qemu-doc.texi b/qemu-doc.texi
> index 83be010..4c5577f 100644
> --- a/qemu-doc.texi
> +++ b/qemu-doc.texi
> @@ -2062,19 +2062,6 @@ PC Keyboard
>  IDE controller
>  @end itemize
>  
> -The mipssim pseudo board emulation provides an environment similar
> -to what the proprietary MIPS emulator uses for running Linux.
> -It supports:
> -
> -@itemize @minus
> -@item
> -A range of MIPS CPUs, default is the 24Kf
> -@item
> -PC style serial port
> -@item
> -MIPSnet network emulation
> -@end itemize
> -
>  The MIPS Magnum R4000 emulation supports:
>  
>  @itemize @minus
> @@ -2090,6 +2077,19 @@ SCSI controller
>  G364 framebuffer
>  @end itemize
>  
> +The mipssim pseudo board emulation provides an environment similar
> +to what the proprietary MIPS emulator uses for running Linux.
> +It supports:
> +
> +@itemize @minus
> +@item
> +A range of MIPS CPUs, default is the 24Kf
> +@item
> +PC style serial port
> +@item
> +MIPSnet network emulation
> +@end itemize
> +
>  @node nanoMIPS System emulator
>  @subsection nanoMIPS System emulator
>  @cindex system emulation (nanoMIPS)
> 
