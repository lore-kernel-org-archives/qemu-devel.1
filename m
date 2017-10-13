Received: from eggs.gnu.org ([2001:4830:134:3::10]:35269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e2vlc-0005Ye-Pe
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 04:56:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e2vlY-0002FZ-Tc
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 04:56:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33272)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1e2vlY-0002FJ-NB
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 04:56:24 -0400
Date: Fri, 13 Oct 2017 10:56:18 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20171013105618.22999596@nial.brq.redhat.com>
In-Reply-To: <58ffc3cdc439a23cbfbd36f313770eef150efba4.1507852977.git.alistair.francis@xilinx.com>
References: <cover.1507852977.git.alistair.francis@xilinx.com>
	<58ffc3cdc439a23cbfbd36f313770eef150efba4.1507852977.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/5] bcm2836: Use the Cortex-A7 instead
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
Cc: qemu-devel@nongnu.org, alistair23@gmail.com, ehabkost@redhat.com, marcel@redhat.com, f4bug@amsat.org

On Thu, 12 Oct 2017 17:07:28 -0700
Alistair Francis <alistair.francis@xilinx.com> wrote:

> The BCM2836 uses a Cortex-A7 not a Cortex-A15. Update the device to use
> the correct CPU.
> https://www.raspberrypi.org/documentation/hardware/raspberrypi/bcm2836/QA7_rev3.4.pdf
> 
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> ---
> V2:
>  - Fix the BCM2836 CPU
> 
>  hw/arm/bcm2836.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
> index 8c43291112..931795a878 100644
> --- a/hw/arm/bcm2836.c
> +++ b/hw/arm/bcm2836.c
> @@ -30,7 +30,7 @@ static void bcm2836_init(Object *obj)
>  
>      for (n = 0; n < BCM2836_NCPUS; n++) {
>          object_initialize(&s->cpus[n], sizeof(s->cpus[n]),
> -                          "cortex-a15-" TYPE_ARM_CPU);
> +                          "cortex-a7-" TYPE_ARM_CPU);
ARM_CPU_TYPE_NAME("cortex-a7")

>          object_property_add_child(obj, "cpu[*]", OBJECT(&s->cpus[n]),
>                                    &error_abort);
>      }
