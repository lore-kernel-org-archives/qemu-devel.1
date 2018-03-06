Received: from eggs.gnu.org ([2001:4830:134:3::10]:49236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1et3nq-0001QE-Bi
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 23:02:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1et3np-0004Pu-55
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 23:02:14 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue,  6 Mar 2018 15:01:28 +1100
Message-Id: <20180306040154.3669-5-david@gibson.dropbear.id.au>
In-Reply-To: <20180306040154.3669-1-david@gibson.dropbear.id.au>
References: <20180306040154.3669-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 04/30] roms: Added git submodule for
 u-boot-sam460 (firmware for sam460ex)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, groug@kaod.org
Cc: agraf@suse.de, surajjs@au1.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>, David Gibson <david@gibson.dropbear.id.au>

From: BALATON Zoltan <balaton@eik.bme.hu>

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 .gitmodules          | 3 +++
 roms/Makefile        | 7 +++++++
 roms/u-boot-sam460ex | 1 +
 3 files changed, 11 insertions(+)
 create mode 160000 roms/u-boot-sam460ex

diff --git a/.gitmodules b/.gitmodules
index 7a8282df46..b76fb450a4 100644
--- a/.gitmodules
+++ b/.gitmodules
@@ -43,3 +43,6 @@
 [submodule "roms/seabios-hppa"]
 	path = roms/seabios-hppa
 	url = git://github.com/hdeller/seabios-hppa.git
+[submodule "roms/u-boot-sam460ex"]
+	path = roms/u-boot-sam460ex
+	url = git://github.com/zbalaton/u-boot-sam460ex
diff --git a/roms/Makefile b/roms/Makefile
index b5e5a69e91..02b69fbac8 100644
--- a/roms/Makefile
+++ b/roms/Makefile
@@ -65,6 +65,7 @@ default:
 	@echo "  slof           -- update slof.bin"
 	@echo "  skiboot        -- update skiboot.lid"
 	@echo "  u-boot.e500    -- update u-boot.e500"
+	@echo "  u-boot.sam460  -- update u-boot.sam460"
 
 bios: build-seabios-config-seabios-128k build-seabios-config-seabios-256k
 	cp seabios/builds/seabios-128k/bios.bin ../pc-bios/bios.bin
@@ -147,6 +148,11 @@ u-boot.e500:
 	$(powerpc_cross_prefix)strip u-boot/build.e500/u-boot -o \
 		../pc-bios/u-boot.e500
 
+u-boot.sam460:
+	$(MAKE) -C u-boot-sam460ex Sam460ex_config
+	$(MAKE) -C u-boot-sam460ex CROSS_COMPILE=$(powerpc_cross_prefix)
+	cp u-boot-sam460ex/u-boot.bin ../pc-bios/u-boot-sam460-20100605.bin
+
 skiboot:
 	$(MAKE) -C skiboot CROSS=$(powerpc64_cross_prefix)
 	cp skiboot/skiboot.lid ../pc-bios/skiboot.lid
@@ -160,4 +166,5 @@ clean:
 	$(MAKE) -C ipxe/src veryclean
 	$(MAKE) -C SLOF clean
 	rm -rf u-boot/build.e500
+	$(MAKE) -C u-boot-sam460ex distclean
 	$(MAKE) -C skiboot clean
diff --git a/roms/u-boot-sam460ex b/roms/u-boot-sam460ex
new file mode 160000
index 0000000000..119aa277f7
--- /dev/null
+++ b/roms/u-boot-sam460ex
@@ -0,0 +1 @@
+Subproject commit 119aa277f74a4a2d3f7ab6c9471292308eba14e4
-- 
2.14.3
