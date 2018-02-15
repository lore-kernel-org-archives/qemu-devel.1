Received: from eggs.gnu.org ([2001:4830:134:3::10]:41045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emJVI-00033D-KS
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:23:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emJVE-0005V6-FA
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:23:12 -0500
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:44058)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emJVE-0005Ur-AF
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:23:08 -0500
Received: by mail-qk0-x241.google.com with SMTP id l23so7054681qkk.11
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 05:23:08 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1517532021.git.alistair.francis@xilinx.com>
	<e394130fdcf7e19abfc584db75720546980075bf.1517532021.git.alistair.francis@xilinx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a704b7e6-7a50-5826-c45c-376b33f36608@amsat.org>
Date: Thu, 15 Feb 2018 10:23:04 -0300
MIME-Version: 1.0
In-Reply-To: <e394130fdcf7e19abfc584db75720546980075bf.1517532021.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 3/6] bcm2836: Use the Cortex-A7 instead
 of Cortex-A15
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org, alistair23@gmail.com, ehabkost@redhat.com, marcel@redhat.com, imammedo@redhat.com

Hi Peter,

On 02/01/2018 09:42 PM, Alistair Francis wrote:
> The BCM2836 uses a Cortex-A7 not a Cortex-A15. Update the device to use
> the correct CPU.
> https://www.raspberrypi.org/documentation/hardware/raspberrypi/bcm2836/QA7_rev3.4.pdf

Can you add these lines with reference to the commits?

  When the BCM2836 was introduced (bad5623690b) the Cortex-A7 was not
  available, so the very similar Cortex-A15 was used.

  Since dcf578ed8ce we can model the correct core.

Thanks!

Phil.

> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> ---
> V3:
>  - Use ARM_CPU_TYPE_NAME() macro
> V2:
>  - Fix the BCM2836 CPU
> 
>  hw/arm/bcm2836.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
> index 8c43291112..c477772484 100644
> --- a/hw/arm/bcm2836.c
> +++ b/hw/arm/bcm2836.c
> @@ -30,7 +30,7 @@ static void bcm2836_init(Object *obj)
>  
>      for (n = 0; n < BCM2836_NCPUS; n++) {
>          object_initialize(&s->cpus[n], sizeof(s->cpus[n]),
> -                          "cortex-a15-" TYPE_ARM_CPU);
> +                          ARM_CPU_TYPE_NAME("cortex-a7"));
>          object_property_add_child(obj, "cpu[*]", OBJECT(&s->cpus[n]),
>                                    &error_abort);
>      }
> 
