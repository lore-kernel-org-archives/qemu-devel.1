Received: from eggs.gnu.org ([209.51.188.92]:43461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gxgbR-0006dH-PB
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 18:21:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gxgbR-0003A0-0S
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 18:21:05 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44613)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gxgbQ-000377-ON
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 18:21:04 -0500
Received: by mail-wr1-x443.google.com with SMTP id w2so6039106wrt.11
	for <qemu-devel@nongnu.org>; Sat, 23 Feb 2019 15:21:04 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1550863578-30859-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1550863578-30859-6-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <013acca0-8b26-9301-302e-4cff6100503a@amsat.org>
Date: Sun, 24 Feb 2019 00:21:01 +0100
MIME-Version: 1.0
In-Reply-To: <1550863578-30859-6-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 5/8] qemu-doc: Add section on MIPS'
 Fulong 2E board
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
> Add section on MIPS' Fulong 2E board in QEMU user documentation.
> 
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  qemu-doc.texi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/qemu-doc.texi b/qemu-doc.texi
> index 4c5577f..18e383c 100644
> --- a/qemu-doc.texi
> +++ b/qemu-doc.texi
> @@ -2077,6 +2077,19 @@ SCSI controller
>  G364 framebuffer
>  @end itemize
>  
> +The Fulong 2E emulation supports:
> +
> +@itemize @minus
> +@item
> +Loongson 2E CPU
> +@item
> +Bonito64 system controller as North Bridge
> +@item
> +VT82C686 chipset as South Bridge
> +@item
> +RTL8139D as a network card chipset
> +@end itemize
> +
>  The mipssim pseudo board emulation provides an environment similar
>  to what the proprietary MIPS emulator uses for running Linux.
>  It supports:
> 
