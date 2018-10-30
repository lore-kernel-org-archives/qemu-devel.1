Received: from eggs.gnu.org ([2001:4830:134:3::10]:43737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gHV6p-0007fB-6t
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 10:35:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gHV6o-0000ra-4U
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 10:35:07 -0400
References: <20181030093531.18587-1-agraf@suse.de>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <655b9090-bb99-2255-5020-d2da2a404bfc@ilande.co.uk>
Date: Tue, 30 Oct 2018 14:34:46 +0000
MIME-Version: 1.0
In-Reply-To: <20181030093531.18587-1-agraf@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: PPC: Remove myself
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On 30/10/2018 09:35, Alexander Graf wrote:

> I haven't really been maintaining any PowerPC code for quite a while now,
> so let's reflect reality: David does all the work and embedded PPC is in
> "Odd Fixes" state rather than supported now.

It was a pleasure working with you, but of course life moves on... :)

> Signed-off-by: Alexander Graf <agraf@suse.de>
> ---
>  MAINTAINERS | 30 ++++++++++++++----------------
>  1 file changed, 14 insertions(+), 16 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d794bd7a66..d1a6d3c740 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -230,7 +230,6 @@ F: tests/tcg/openrisc/
>  
>  PowerPC
>  M: David Gibson <david@gibson.dropbear.id.au>
> -M: Alexander Graf <agraf@suse.de>
>  L: qemu-ppc@nongnu.org
>  S: Maintained
>  F: target/ppc/
> @@ -340,7 +339,7 @@ S: Maintained
>  F: target/mips/kvm.c
>  
>  PPC
> -M: Alexander Graf <agraf@suse.de>
> +M: David Gibson <david@gibson.dropbear.id.au>
>  S: Maintained
>  F: target/ppc/kvm.c
>  
> @@ -780,21 +779,21 @@ F: hw/openrisc/openrisc_sim.c
>  PowerPC Machines
>  ----------------
>  405
> -M: Alexander Graf <agraf@suse.de>
> +M: David Gibson <david@gibson.dropbear.id.au>
>  L: qemu-ppc@nongnu.org
>  S: Odd Fixes
>  F: hw/ppc/ppc405_boards.c
>  
>  Bamboo
> -M: Alexander Graf <agraf@suse.de>
> +M: David Gibson <david@gibson.dropbear.id.au>
>  L: qemu-ppc@nongnu.org
>  S: Odd Fixes
>  F: hw/ppc/ppc440_bamboo.c
>  
>  e500
> -M: Alexander Graf <agraf@suse.de>
> +M: David Gibson <david@gibson.dropbear.id.au>
>  L: qemu-ppc@nongnu.org
> -S: Supported
> +S: Odd Fixes
>  F: hw/ppc/e500.[hc]
>  F: hw/ppc/e500plat.c
>  F: include/hw/ppc/ppc_e500.h
> @@ -802,16 +801,16 @@ F: include/hw/pci-host/ppce500.h
>  F: pc-bios/u-boot.e500
>  
>  mpc8544ds
> -M: Alexander Graf <agraf@suse.de>
> +M: David Gibson <david@gibson.dropbear.id.au>
>  L: qemu-ppc@nongnu.org
> -S: Supported
> +S: Odd Fixes
>  F: hw/ppc/mpc8544ds.c
>  F: hw/ppc/mpc8544_guts.c
>  
>  New World
> -M: Alexander Graf <agraf@suse.de>
> +M: David Gibson <david@gibson.dropbear.id.au>
>  L: qemu-ppc@nongnu.org
> -S: Maintained
> +S: Odd Fixes

There was actually a patch floating around to add myself to MAINTAINERS for the New
World and Old World machines, but I think it got lost when trying to set up a
sub-maintainer queue with David. I'm happy to look after these machines for now.

>  F: hw/ppc/mac_newworld.c
>  F: hw/pci-host/uninorth.c
>  F: hw/pci-bridge/dec.[hc]
> @@ -823,9 +822,9 @@ F: include/hw/misc/mos6522.h
>  F: include/hw/ppc/mac_dbdma.h
>  
>  Old World
> -M: Alexander Graf <agraf@suse.de>
> +M: David Gibson <david@gibson.dropbear.id.au>
>  L: qemu-ppc@nongnu.org
> -S: Maintained
> +S: Odd Fixes
>  F: hw/ppc/mac_oldworld.c
>  F: hw/pci-host/grackle.c
>  F: hw/misc/macio/
> @@ -850,7 +849,6 @@ F: pc-bios/ppc_rom.bin
>  
>  sPAPR
>  M: David Gibson <david@gibson.dropbear.id.au>
> -M: Alexander Graf <agraf@suse.de>
>  L: qemu-ppc@nongnu.org
>  S: Supported
>  F: hw/*/spapr*
> @@ -1117,7 +1115,7 @@ F: tests/bios-tables-test.c
>  F: tests/acpi-utils.[hc]
>  
>  ppc4xx
> -M: Alexander Graf <agraf@suse.de>
> +M: David Gibson <david@gibson.dropbear.id.au>
>  L: qemu-ppc@nongnu.org
>  S: Odd Fixes
>  F: hw/ppc/ppc4*.c
> @@ -1126,9 +1124,9 @@ F: include/hw/ppc/ppc4xx.h
>  F: include/hw/i2c/ppc4xx_i2c.h
>  
>  ppce500
> -M: Alexander Graf <agraf@suse.de>
> +M: David Gibson <david@gibson.dropbear.id.au>
>  L: qemu-ppc@nongnu.org
> -S: Supported
> +S: Odd Fixes
>  F: hw/ppc/e500*
>  F: hw/pci-host/ppce500.c
>  F: hw/net/fsl_etsec/


ATB,

Mark.
