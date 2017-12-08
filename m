Received: from eggs.gnu.org ([2001:4830:134:3::10]:39326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eNL70-0003BM-Vz
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 11:02:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eNL70-0005cW-3l
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 11:02:55 -0500
From: David Hildenbrand <david@redhat.com>
Date: Fri,  8 Dec 2017 17:02:06 +0100
Message-Id: <20171208160207.26494-14-david@redhat.com>
In-Reply-To: <20171208160207.26494-1-david@redhat.com>
References: <20171208160207.26494-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v3 for-2.12 13/14] s390x/tcg: we already
 implement the Set-Program-Parameter facility
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>

The Set-Program-Parameter facility (also known as Load-Program-Parameter
facility) provides the LPP instruction used to load the program
parameter. We already implement that instruction in TCG, so add it to our
list.

Note: Not documented in the PoP but in "The Load-Program-Parameter and
CPU-Measurement Facilities) - SA23-2260-05 document.

While at it, make the whole list ordered (according to cpu_features_def.h).

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu_models.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 0be037eac1..edac7fdecf 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -824,12 +824,12 @@ static void add_qemu_cpu_model_features(S390FeatBitmap fbm)
         S390_FEAT_IDTE_SEGMENT,
         S390_FEAT_STFLE,
         S390_FEAT_SENSE_RUNNING_STATUS,
-        S390_FEAT_EXTENDED_IMMEDIATE,
         S390_FEAT_EXTENDED_TRANSLATION_2,
         S390_FEAT_MSA,
-        S390_FEAT_EXTENDED_TRANSLATION_3,
         S390_FEAT_LONG_DISPLACEMENT,
         S390_FEAT_LONG_DISPLACEMENT_FAST,
+        S390_FEAT_EXTENDED_IMMEDIATE,
+        S390_FEAT_EXTENDED_TRANSLATION_3,
         S390_FEAT_ETF2_ENH,
         S390_FEAT_STORE_CLOCK_FAST,
         S390_FEAT_MOVE_WITH_OPTIONAL_SPEC,
@@ -839,6 +839,7 @@ static void add_qemu_cpu_model_features(S390FeatBitmap fbm)
         S390_FEAT_COMPARE_AND_SWAP_AND_STORE_2,
         S390_FEAT_GENERAL_INSTRUCTIONS_EXT,
         S390_FEAT_EXECUTE_EXT,
+        S390_FEAT_SET_PROGRAM_PARAMETERS,
         S390_FEAT_FLOATING_POINT_SUPPPORT_ENH,
         S390_FEAT_STFLE_45,
         S390_FEAT_STFLE_49,
-- 
2.14.3
