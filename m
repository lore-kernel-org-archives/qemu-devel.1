Received: from eggs.gnu.org ([2001:4830:134:3::10]:57908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fMwQr-0000J0-Ii
	for qemu-devel@nongnu.org; Sun, 27 May 2018 10:14:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fMwQq-0004Vx-Lm
	for qemu-devel@nongnu.org; Sun, 27 May 2018 10:14:01 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:46533)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fMwQq-0004VM-G3
	for qemu-devel@nongnu.org; Sun, 27 May 2018 10:14:00 -0400
Received: by mail-pl0-x242.google.com with SMTP id 30-v6so5727074pld.13
	for <qemu-devel@nongnu.org>; Sun, 27 May 2018 07:14:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sun, 27 May 2018 09:13:24 -0500
Message-Id: <20180527141324.11937-21-richard.henderson@linaro.org>
In-Reply-To: <20180527141324.11937-1-richard.henderson@linaro.org>
References: <20180527141324.11937-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 20/20] target/or1k: Add support in
 scripts/qemu-binfmt-conf.sh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 scripts/qemu-binfmt-conf.sh | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
index 7ab7435fbd..75ed7c6b65 100755
--- a/scripts/qemu-binfmt-conf.sh
+++ b/scripts/qemu-binfmt-conf.sh
@@ -1,10 +1,10 @@
 #!/bin/sh
-# enable automatic i386/ARM/M68K/MIPS/SPARC/PPC/s390/HPPA/Xtensa/microblaze
-# program execution by the kernel
+# Enable automatic program execution by the kernel.
 
 qemu_target_list="i386 i486 alpha arm armeb sparc32plus ppc ppc64 ppc64le m68k \
 mips mipsel mipsn32 mipsn32el mips64 mips64el \
-sh4 sh4eb s390x aarch64 aarch64_be hppa riscv32 riscv64 xtensa xtensaeb microblaze microblazeel"
+sh4 sh4eb s390x aarch64 aarch64_be hppa riscv32 riscv64 xtensa xtensaeb \
+microblaze microblazeel or1k"
 
 i386_magic='\x7fELF\x01\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x03\x00'
 i386_mask='\xff\xff\xff\xff\xff\xfe\xfe\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff'
@@ -124,6 +124,10 @@ microblazeel_magic='\x7fELF\x01\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\
 microblazeel_mask='\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff'
 microblazeel_family=microblazeel
 
+or1k_magic='\x7fELF\x01\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x5c'
+or1k_mask='\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff'
+or1k_family=or1k
+
 qemu_get_family() {
     cpu=${HOST_ARCH:-$(uname -m)}
     case "$cpu" in
-- 
2.17.0
