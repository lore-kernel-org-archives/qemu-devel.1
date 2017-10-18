Received: from eggs.gnu.org ([2001:4830:134:3::10]:36569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e4j5X-0004DU-2y
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 03:48:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e4j5U-0001HI-0B
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 03:48:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38460)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1e4j5T-0001Fr-Pm
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 03:48:23 -0400
Date: Wed, 18 Oct 2017 09:48:17 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20171018094817.3fef3d8d@nial.brq.redhat.com>
In-Reply-To: <ef4e172df6cdf3d9ee8bb3aa896cacab5efdd1f1.1508279421.git.alistair.francis@xilinx.com>
References: <cover.1508279421.git.alistair.francis@xilinx.com>
	<ef4e172df6cdf3d9ee8bb3aa896cacab5efdd1f1.1508279421.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 2/5] bcm2836: Use the Cortex-A7 instead
 of Cortex-A15
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, f4bug@amsat.org, marcel@redhat.com, alistair23@gmail.com

On Tue, 17 Oct 2017 15:31:14 -0700
Alistair Francis <alistair.francis@xilinx.com> wrote:

> The BCM2836 uses a Cortex-A7 not a Cortex-A15. Update the device to use
> the correct CPU.
> https://www.raspberrypi.org/documentation/hardware/raspberrypi/bcm2836/QA7_rev3.4.pdf
> 
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>

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
