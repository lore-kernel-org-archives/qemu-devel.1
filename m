Received: from eggs.gnu.org ([2001:4830:134:3::10]:54610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <r.bolshakov@yadro.com>) id 1gPZFz-00050r-R7
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 15:37:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <r.bolshakov@yadro.com>) id 1gPZFw-0005cm-Mj
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 15:37:55 -0500
From: Roman Bolshakov <r.bolshakov@yadro.com>
Date: Wed, 21 Nov 2018 23:37:21 +0300
Message-ID: <20181121203720.75916-1-r.bolshakov@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] roms: seabios: Rename CROSS_COMPILE to
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
Cc: Roman Bolshakov <r.bolshakov@yadro.com>, qemu-trivial@nongnu.org

SeaBIOS introduced CROSS_PREFIX in 2013 but it's not set in roms
Makefile.

With the change it's possible to cross-compile SeaBIOS on macOS,
if acpica/iasl is installed:
  cd roms
  export PATH=3D/path/to/cross/x86_64-unknown-linux-gnu/bin:$PATH
  make bios system=3Dunknown-linux-gnu

Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
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
 		EXTRAVERSION=3D$(SEABIOS_EXTRAVERSION) \
-		CROSS_COMPILE=3D$(x86_64_cross_prefix) \
+		CROSS_PREFIX=3D$(x86_64_cross_prefix) \
 		KCONFIG_CONFIG=3D$(CURDIR)/seabios/builds/$*/.config \
 		OUT=3D$(CURDIR)/seabios/builds/$*/ oldnoconfig
 	$(MAKE) -C seabios \
 		EXTRAVERSION=3D$(SEABIOS_EXTRAVERSION) \
-		CROSS_COMPILE=3D$(x86_64_cross_prefix) \
+		CROSS_PREFIX=3D$(x86_64_cross_prefix) \
 		KCONFIG_CONFIG=3D$(CURDIR)/seabios/builds/$*/.config \
 		OUT=3D$(CURDIR)/seabios/builds/$*/ all
=20
--=20
2.19.1
