Received: from eggs.gnu.org ([2001:4830:134:3::10]:47387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cWf3S-0005jo-32
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 03:05:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cWf3N-0003eJ-Su
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 03:05:14 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:64789)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cWf3N-0003dT-J1
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 03:05:09 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu, 26 Jan 2017 09:04:47 +0100
Message-Id: <20170126080449.28255-2-laurent@vivier.eu>
In-Reply-To: <20170126080449.28255-1-laurent@vivier.eu>
References: <20170126080449.28255-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH v3 1/3] linux-user: add hppa magic numbers in
 qemu-binfmt-conf.sh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Richard Henderson <rth@twiddle.net>, Laurent Vivier <laurent@vivier.eu>

As we have now a linux-user HPPA target, we can add it to the list of
supported targets in qemu-binfmt-conf.sh

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <rth@twiddle.net>
---
 scripts/qemu-binfmt-conf.sh | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
index de4d1c1..0f1aa63 100755
--- a/scripts/qemu-binfmt-conf.sh
+++ b/scripts/qemu-binfmt-conf.sh
@@ -1,9 +1,10 @@
 #!/bin/sh
-# enable automatic i386/ARM/M68K/MIPS/SPARC/PPC/s390 program execution by the kernel
+# enable automatic i386/ARM/M68K/MIPS/SPARC/PPC/s390/HPPA
+# program execution by the kernel
 
 qemu_target_list="i386 i486 alpha arm sparc32plus ppc ppc64 ppc64le m68k \
 mips mipsel mipsn32 mipsn32el mips64 mips64el \
-sh4 sh4eb s390x aarch64"
+sh4 sh4eb s390x aarch64 hppa"
 
 i386_magic='\x7fELF\x01\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x03\x00'
 i386_mask='\xff\xff\xff\xff\xff\xfe\xfe\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff'
@@ -91,6 +92,10 @@ aarch64_magic='\x7fELF\x02\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x
 aarch64_mask='\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff'
 aarch64_family=arm
 
+hppa_magic='\x7f\x45\x4c\x46\x01\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x0f'
+hppa_mask='\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff'
+hppa_family=hppa
+
 qemu_get_family() {
     cpu=${HOST_ARCH:-$(uname -m)}
     case "$cpu" in
-- 
2.9.3
