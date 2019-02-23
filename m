Received: from eggs.gnu.org ([209.51.188.92]:43817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gxgcq-0007QC-MR
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 18:22:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gxgco-0004em-Bo
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 18:22:32 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:39061)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gxgck-0004Zs-M0
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 18:22:26 -0500
Received: by mail-wr1-x443.google.com with SMTP id l5so6066842wrw.6
	for <qemu-devel@nongnu.org>; Sat, 23 Feb 2019 15:22:25 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1550863578-30859-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1550863578-30859-7-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a0a65de4-c206-8cd6-3e8c-db56f503c3bb@amsat.org>
Date: Sun, 24 Feb 2019 00:22:22 +0100
MIME-Version: 1.0
In-Reply-To: <1550863578-30859-7-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 6/8] qemu-doc: Add section on MIPS'
 Boston board
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
> Add section on MIPS' Boston board in QEMU user documentation.
> 
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  qemu-doc.texi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/qemu-doc.texi b/qemu-doc.texi
> index 18e383c..ae3c3f9 100644
> --- a/qemu-doc.texi
> +++ b/qemu-doc.texi
> @@ -2049,6 +2049,15 @@ Malta FPGA serial device
>  Cirrus (default) or any other PCI VGA graphics card
>  @end itemize
>  
> +The Boston board emulation supports the following devices:
> +
> +@itemize @minus
> +@item
> +Xilinx FPGA, which includes a PCIe root port and an UART

and a LCD display?

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> +@item
> +Intel EG20T PCH connects the I/O peripherals, but only the SATA bus is emulated
> +@end itemize
> +
>  The ACER Pica emulation supports:
>  
>  @itemize @minus
> 
