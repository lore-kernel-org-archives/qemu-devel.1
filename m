Received: from eggs.gnu.org ([2001:4830:134:3::10]:48501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9Yvg-0000Il-Ez
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 12:30:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9Yvd-0005Zo-B7
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 12:30:32 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:45248)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9Yvd-0005ZX-7c
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 12:30:29 -0400
Received: by mail-qt0-x241.google.com with SMTP id b13-v6so10432650qtp.12
	for <qemu-devel@nongnu.org>; Fri, 20 Apr 2018 09:30:29 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180420145249.32435-1-peter.maydell@linaro.org>
	<20180420145249.32435-5-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9ed50905-faeb-7268-14bf-ee6c5b120af1@amsat.org>
Date: Fri, 20 Apr 2018 13:30:24 -0300
MIME-Version: 1.0
In-Reply-To: <20180420145249.32435-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 04/13] hw/mips/mips_malta: Don't create
 "null" chardevs for serial devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 04/20/2018 11:52 AM, Peter Maydell wrote:
> Following commit 12051d82f004024, UART devices should handle
> being passed a NULL pointer chardev, so we don't need to
> create "null" backends in board code. Remove the code that
> does this and updates serial_hds[].
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/mips/mips_malta.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> index f6513a4fd5..49fe7a0a72 100644
> --- a/hw/mips/mips_malta.c
> +++ b/hw/mips/mips_malta.c
> @@ -1056,11 +1056,6 @@ void mips_malta_init(MachineState *machine)
>  
>      /* FPGA */
>  
> -    /* Make sure the second serial port is associated with a device. */
> -    if (!serial_hds[2]) {
> -        serial_hds[2] = qemu_chr_new("fpga-uart", "null");
> -    }
> -
>      /* The CBUS UART is attached to the MIPS CPU INT2 pin, ie interrupt 4 */
>      malta_fpga_init(system_memory, FPGA_ADDRESS, cbus_irq, serial_hds[2]);
>  
> 
