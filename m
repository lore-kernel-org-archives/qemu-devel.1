Received: from eggs.gnu.org ([209.51.188.92]:38792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ghvHI-0003FW-3n
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 06:47:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ghvHH-0004yN-6D
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 06:47:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54050)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ghvHG-0004xC-Sv
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 06:47:07 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 11 Jan 2019 12:47:01 +0100
Message-Id: <20190111114701.6195-2-kraxel@redhat.com>
In-Reply-To: <20190111114701.6195-1-kraxel@redhat.com>
References: <20190111114701.6195-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 1/1] roms: seabios: Rename CROSS_COMPILE to
 CROSS_PREFIX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <r.bolshakov@yadro.com>, Gerd Hoffmann <kraxel@redhat.com>

From: Roman Bolshakov <r.bolshakov@yadro.com>

SeaBIOS introduced CROSS_PREFIX in 2013 but it's not set in roms
Makefile.

With the change it's possible to cross-compile SeaBIOS on macOS,
if acpica/iasl is installed:
  cd roms
  export PATH=/path/to/cross/x86_64-unknown-linux-gnu/bin:$PATH
  make bios system=unknown-linux-gnu

Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
Message-id: 20181121203720.75916-1-r.bolshakov@yadro.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 roms/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/roms/Makefile b/roms/Makefile
index f4141e1d96..a6043eff37 100644
--- a/roms/Makefile
+++ b/roms/Makefile
@@ -83,12 +83,12 @@ build-seabios-config-%: config.%
 	cp $< seabios/builds/$*/.config
 	$(MAKE) -C seabios \
 		EXTRAVERSION=$(SEABIOS_EXTRAVERSION) \
-		CROSS_COMPILE=$(x86_64_cross_prefix) \
+		CROSS_PREFIX=$(x86_64_cross_prefix) \
 		KCONFIG_CONFIG=$(CURDIR)/seabios/builds/$*/.config \
 		OUT=$(CURDIR)/seabios/builds/$*/ oldnoconfig
 	$(MAKE) -C seabios \
 		EXTRAVERSION=$(SEABIOS_EXTRAVERSION) \
-		CROSS_COMPILE=$(x86_64_cross_prefix) \
+		CROSS_PREFIX=$(x86_64_cross_prefix) \
 		KCONFIG_CONFIG=$(CURDIR)/seabios/builds/$*/.config \
 		OUT=$(CURDIR)/seabios/builds/$*/ all
 
-- 
2.9.3
