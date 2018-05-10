Received: from eggs.gnu.org ([2001:4830:134:3::10]:57152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fGsOB-0005Pa-94
	for qemu-devel@nongnu.org; Thu, 10 May 2018 16:42:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fGsO7-0004Wi-MV
	for qemu-devel@nongnu.org; Thu, 10 May 2018 16:42:11 -0400
Received: from mail-sn1nam01on0041.outbound.protection.outlook.com
	([104.47.32.41]:36736
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1fGsO7-0004Vg-HD
	for qemu-devel@nongnu.org; Thu, 10 May 2018 16:42:07 -0400
From: Babu Moger <babu.moger@amd.com>
Date: Thu, 10 May 2018 15:41:42 -0500
Message-Id: <20180510204148.11687-3-babu.moger@amd.com>
In-Reply-To: <20180510204148.11687-1-babu.moger@amd.com>
References: <20180510204148.11687-1-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v8 2/8] i386: Add cache information in
 X86CPUDefinition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, geoff@hostfission.com, kash@tripleback.net, babu.moger@amd.com

Add cache information in X86CPUDefinition and CPUX86State.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Tested-by: Geoffrey McRae <geoff@hostfission.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 1 +
 target/i386/cpu.h | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 18835400f1..3a74c4b1e4 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1105,6 +1105,7 @@ struct X86CPUDefinition {
     int stepping;
     FeatureWordArray features;
     const char *model_id;
+    CPUCaches *cache_info;
 };
 
 static X86CPUDefinition builtin_x86_defs[] = {
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index fa03e2ced4..372f8b7ef5 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1096,6 +1096,12 @@ typedef struct CPUCacheInfo {
 } CPUCacheInfo;
 
 
+typedef struct CPUCaches {
+        CPUCacheInfo l1d_cache;
+        CPUCacheInfo l1i_cache;
+        CPUCacheInfo l2_cache;
+        CPUCacheInfo l3_cache;
+} CPUCaches;
 
 typedef struct CPUX86State {
     /* standard registers */
@@ -1282,6 +1288,7 @@ typedef struct CPUX86State {
     /* Features that were explicitly enabled/disabled */
     FeatureWordArray user_features;
     uint32_t cpuid_model[12];
+    CPUCaches *cache_info;
 
     /* MTRRs */
     uint64_t mtrr_fixed[11];
-- 
2.17.0
