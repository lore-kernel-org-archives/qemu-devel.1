Received: from eggs.gnu.org ([2001:4830:134:3::10]:59571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dsTNS-0007lp-NX
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 08:36:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dsTNN-0004ZG-QN
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 08:36:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52390)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dsTNN-0004X9-LG
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 08:36:13 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu, 14 Sep 2017 13:36:09 +0100
Message-Id: <20170914123609.497-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH] sparc: Fix typedef clash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com, imammedo@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Older compilers (rhel6) don't like redefinition of typedefs

Fixes: 12a6c15ef31c98ecefa63e91ac36955383038384

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 target/sparc/cpu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index b45cfb4708..1598f65927 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -240,7 +240,7 @@ typedef struct trap_state {
 #endif
 #define TARGET_INSN_START_EXTRA_WORDS 1
 
-typedef struct sparc_def_t {
+struct sparc_def_t {
     const char *name;
     target_ulong iu_version;
     uint32_t fpu_version;
@@ -254,7 +254,7 @@ typedef struct sparc_def_t {
     uint32_t features;
     uint32_t nwindows;
     uint32_t maxtl;
-} sparc_def_t;
+};
 
 #define CPU_FEATURE_FLOAT        (1 << 0)
 #define CPU_FEATURE_FLOAT128     (1 << 1)
-- 
2.13.5
