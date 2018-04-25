Received: from eggs.gnu.org ([2001:4830:134:3::10]:33856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fBLYn-0001fH-KI
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 10:38:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fBLYk-00007T-GT
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 10:38:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45010 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fBLYk-00007I-BV
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 10:38:14 -0400
References: <20180420145249.32435-1-peter.maydell@linaro.org>
	<20180420145249.32435-5-peter.maydell@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <1eccc9b9-accb-acf6-a5e2-d9a6719f631d@redhat.com>
Date: Wed, 25 Apr 2018 16:38:06 +0200
MIME-Version: 1.0
In-Reply-To: <20180420145249.32435-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, patches@linaro.org

On 20.04.2018 16:52, Peter Maydell wrote:
> Following commit 12051d82f004024, UART devices should handle
> being passed a NULL pointer chardev, so we don't need to
> create "null" backends in board code. Remove the code that
> does this and updates serial_hds[].
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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

Reviewed-by: Thomas Huth <thuth@redhat.com>
