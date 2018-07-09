Received: from eggs.gnu.org ([2001:4830:134:3::10]:44283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fcQqA-00054j-8D
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 03:44:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fcQq8-0002EY-80
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 03:44:10 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon,  9 Jul 2018 17:43:47 +1000
Message-Id: <20180709074350.27086-14-david@gibson.dropbear.id.au>
In-Reply-To: <20180709074350.27086-1-david@gibson.dropbear.id.au>
References: <20180709074350.27086-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 13/16] sam460ex: Update u-boot-sam460ex firmware
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, clg@kaod.org, balaton@eik.bme.hu, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

From: BALATON Zoltan <balaton@eik.bme.hu>

Update the submodule and u-boot-sam460-20100605.bin to include
following fixes from Sebastian Bauer:
- Fix build with newer gcc
- Decrease unnecessary delay which fixes slow booting from CD

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 pc-bios/u-boot-sam460-20100605.bin | Bin 524288 -> 524288 bytes
 roms/u-boot-sam460ex               |   2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/pc-bios/u-boot-sam460-20100605.bin b/pc-bios/u-boot-sam460-20100605.bin
index 99408f8e957b26e735e5befa98fa3d51a90d95f6..e17de77c1974382144625632c709c29a1a86edef 100755
GIT binary patch
delta 84
zcmZo@P-tjSm>@3hRhpw<V4+}SU}&MBt6*egWnyY&Y^*tXBiE%S#%+v@Tql?qjHdIP
gWSj-0+gF@q1Y#y2W(HywAZ7((w(ToUvPYN!05~lj7ytkO

delta 84
zcmZo@P-tjSm>@3hpIo9~WTaqZU}&zOt6*quWny4uV5B*DBiE%S#%+v@Tql@>JErrT
gWSj-0+gF@q1Y#y2W(HywAZ7((w(ToUvPYN!08um@+W-In

diff --git a/roms/u-boot-sam460ex b/roms/u-boot-sam460ex
index 8ee007c421..60b3916f33 160000
--- a/roms/u-boot-sam460ex
+++ b/roms/u-boot-sam460ex
@@ -1 +1 @@
-Subproject commit 8ee007c4216fd6a0d760589e8405ce4494497aa0
+Subproject commit 60b3916f33e617a815973c5a6df77055b2e3a588
-- 
2.17.1
