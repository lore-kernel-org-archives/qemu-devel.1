Received: from eggs.gnu.org ([2001:4830:134:3::10]:51749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1edan5-00020K-PT
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 07:01:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1edan4-0006VI-R2
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 07:01:31 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon, 22 Jan 2018 13:00:45 +0100
Message-Id: <20180122120045.13538-10-cohuck@redhat.com>
In-Reply-To: <20180122120045.13538-1-cohuck@redhat.com>
References: <20180122120045.13538-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 9/9] s390x/kvm: provide stfle.81
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, qemu-stable@nongnu.org, Cornelia Huck <cohuck@redhat.com>

From: Christian Borntraeger <borntraeger@de.ibm.com>

stfle.81 (ppa15) is a transparent facility that can be passed to the
guest without the need to implement hypervisor support. As this feature
can be provided by firmware we add it to all full models.

Cc: qemu-stable@nongnu.org
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Message-Id: <20180118085628.40798-4-borntraeger@de.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/cpu_features.c     | 1 +
 target/s390x/cpu_features_def.h | 1 +
 target/s390x/gen-features.c     | 1 +
 3 files changed, 3 insertions(+)

diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
index b45ef09f93..85d10b5710 100644
--- a/target/s390x/cpu_features.c
+++ b/target/s390x/cpu_features.c
@@ -89,6 +89,7 @@ static const S390FeatDef s390_features[] = {
     FEAT_INIT("msa4-base", S390_FEAT_TYPE_STFL, 77, "Message-security-assist-extension-4 facility (excluding subfunctions)"),
     FEAT_INIT("edat2", S390_FEAT_TYPE_STFL, 78, "Enhanced-DAT facility 2"),
     FEAT_INIT("dfppc", S390_FEAT_TYPE_STFL, 80, "Decimal-floating-point packed-conversion facility"),
+    FEAT_INIT("ppa15", S390_FEAT_TYPE_STFL, 81, "PPA15 is installed"),
     FEAT_INIT("bpb", S390_FEAT_TYPE_STFL, 82, "Branch prediction blocking"),
     FEAT_INIT("vx", S390_FEAT_TYPE_STFL, 129, "Vector facility"),
     FEAT_INIT("iep", S390_FEAT_TYPE_STFL, 130, "Instruction-execution-protection facility"),
diff --git a/target/s390x/cpu_features_def.h b/target/s390x/cpu_features_def.h
index 4487cfd53b..4d930871b4 100644
--- a/target/s390x/cpu_features_def.h
+++ b/target/s390x/cpu_features_def.h
@@ -80,6 +80,7 @@ typedef enum {
     S390_FEAT_MSA_EXT_4,
     S390_FEAT_EDAT_2,
     S390_FEAT_DFP_PACKED_CONVERSION,
+    S390_FEAT_PPA15,
     S390_FEAT_BPB,
     S390_FEAT_VECTOR,
     S390_FEAT_INSTRUCTION_EXEC_PROT,
diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 563aced35e..0570f597ec 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -352,6 +352,7 @@ static uint16_t base_GEN14_GA1[] = {
  * support these features yet.
  */
 static uint16_t full_GEN7_GA1[] = {
+    S390_FEAT_PPA15,
     S390_FEAT_BPB,
     S390_FEAT_SIE_F2,
     S390_FEAT_SIE_SKEY,
-- 
2.13.6
