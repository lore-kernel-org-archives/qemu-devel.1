Received: from eggs.gnu.org ([2001:4830:134:3::10]:48992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gPp15-0003e0-Gk
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 08:27:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gPp12-0007V5-Ak
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 08:27:35 -0500
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Thu, 22 Nov 2018 13:27:10 +0000
Message-ID: <BN6PR2201MB12510FB3F495AE15BD4E006CC6DB0@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1542891760-13937-1-git-send-email-thuth@redhat.com>
In-Reply-To: <1542891760-13937-1-git-send-email-thuth@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: Add missing hw/pci-host
 entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>
Cc: Stefan Markovic <smarkovic@wavecomp.com>, Paul Burton <pburton@wavecomp.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, David Gibson <david@gibson.dropbear.id.au>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>

Thomas wrote:

> Bonito belongs to Fulong-2E, Sabre belongs to Sun4u, and Mac-Newworld
> and Mips-Boston were missing the header files.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  MAINTAINERS | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

For MIPS bits and pieces (Fulong-2E and Boston boards):

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

For others:

Acked-by: Aleksandar Markovic <amarkovic@wavecomp.com>

THANKS!

________________________________________
From: Thomas Huth <thuth@redhat.com>
Sent: Thursday, November 22, 2018 2:02:40 PM
To: qemu-devel@nongnu.org; qemu-trivial@nongnu.org
Cc: Aleksandar Markovic; Stefan Markovic; Paul Burton; Mark Cave-Ayland; Da=
vid Gibson; qemu-ppc@nongnu.org
Subject: [PATCH] MAINTAINERS: Add missing hw/pci-host entries

Bonito belongs to Fulong-2E, Sabre belongs to Sun4u, and Mac-Newworld
and Mips-Boston were missing the header files.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6522621..46a5581 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -876,7 +876,7 @@ R: Stefan Markovic <smarkovic@wavecomp.com>
 S: Odd Fixes
 F: hw/mips/mips_fulong2e.c
 F: hw/isa/vt82c686.c
-
+F: hw/pci-host/bonito.c
 F: include/hw/isa/vt82c686.h

 Boston
@@ -886,6 +886,7 @@ S: Maintained
 F: hw/core/loader-fit.c
 F: hw/mips/boston.c
 F: hw/pci-host/xilinx-pcie.c
+F: include/hw/pci-host/xilinx-pcie.h

 OpenRISC Machines
 -----------------
@@ -938,6 +939,7 @@ F: hw/nvram/mac_nvram.c
 F: include/hw/misc/macio/
 F: include/hw/misc/mos6522.h
 F: include/hw/ppc/mac_dbdma.h
+F: include/hw/pci-host/uninorth.h

 Old World
 M: David Gibson <david@gibson.dropbear.id.au>
@@ -1029,6 +1031,8 @@ M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
 S: Maintained
 F: hw/sparc64/sun4u.c
 F: pc-bios/openbios-sparc64
+F: hw/pci-host/sabre.c
+F: include/hw/pci-host/sabre.h

 Sun4v
 M: Artyom Tarasenko <atar4qemu@gmail.com>
--
1.8.3.1
