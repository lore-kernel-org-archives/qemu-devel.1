Received: from eggs.gnu.org ([2001:4830:134:3::10]:40953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f5VM8-0004ie-Rk
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 07:53:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f5VM3-0007Ib-WB
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 07:53:04 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:53247)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1f5VM3-0007Hl-MP
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 07:52:59 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon,  9 Apr 2018 13:52:12 +0200
Message-Id: <20180409115212.875-2-laurent@vivier.eu>
In-Reply-To: <20180409115212.875-1-laurent@vivier.eu>
References: <20180409115212.875-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH 2/2] linux-user: add microblaze/microblazeel
 magic numbers in qemu-binfmt-conf.sh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Laurent Vivier <laurent@vivier.eu>

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 scripts/qemu-binfmt-conf.sh | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
index f39ad344fc..7ab7435fbd 100755
--- a/scripts/qemu-binfmt-conf.sh
+++ b/scripts/qemu-binfmt-conf.sh
@@ -1,10 +1,10 @@
 #!/bin/sh
-# enable automatic i386/ARM/M68K/MIPS/SPARC/PPC/s390/HPPA/Xtensa
+# enable automatic i386/ARM/M68K/MIPS/SPARC/PPC/s390/HPPA/Xtensa/microblaze
 # program execution by the kernel
 
 qemu_target_list="i386 i486 alpha arm armeb sparc32plus ppc ppc64 ppc64le m68k \
 mips mipsel mipsn32 mipsn32el mips64 mips64el \
-sh4 sh4eb s390x aarch64 aarch64_be hppa riscv32 riscv64 xtensa xtensaeb"
+sh4 sh4eb s390x aarch64 aarch64_be hppa riscv32 riscv64 xtensa xtensaeb microblaze microblazeel"
 
 i386_magic='\x7fELF\x01\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x03\x00'
 i386_mask='\xff\xff\xff\xff\xff\xfe\xfe\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff'
@@ -116,6 +116,14 @@ xtensaeb_magic='\x7fELF\x01\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\
 xtensaeb_mask='\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff'
 xtensaeb_family=xtensaeb
 
+microblaze_magic='\x7fELF\x01\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\xba\xab'
+microblaze_mask='\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff'
+microblaze_family=microblaze
+
+microblazeel_magic='\x7fELF\x01\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\xab\xba'
+microblazeel_mask='\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff'
+microblazeel_family=microblazeel
+
 qemu_get_family() {
     cpu=${HOST_ARCH:-$(uname -m)}
     case "$cpu" in
-- 
2.14.3
