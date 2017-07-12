Received: from eggs.gnu.org ([2001:4830:134:3::10]:44899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVHDN-0006ZX-F4
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 08:58:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVHDG-00010D-Ql
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 08:58:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52518)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dVHDG-0000zF-GF
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 08:57:54 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6CCs7AS127297
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 08:57:53 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bncj5hqjx-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 08:57:52 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 12 Jul 2017 13:57:50 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 12 Jul 2017 14:57:39 +0200
In-Reply-To: <1499864265-144136-1-git-send-email-borntraeger@de.ibm.com>
References: <1499864265-144136-1-git-send-email-borntraeger@de.ibm.com>
Message-Id: <1499864265-144136-6-git-send-email-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PATCH 05/11] s390x/cpumodel: clean up spacing and
 comments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Cornelia Huck <cohuck@redhat.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

From: "Jason J. Herne" <jjherne@linux.vnet.ibm.com>

Clean up spacing and add comments to clarify difference between base, full and
default models.

Not having spacing around the model definitions in gen-features.c is
particularly frustrating as the reader tends to misinterpret which model they
are looking at or editing.

Signed-off-by: Jason J. Herne <jjherne@linux.vnet.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 target/s390x/cpu_features.c     |  3 +++
 target/s390x/cpu_features_def.h | 35 +++++++++++++++++++++++++
 target/s390x/gen-features.c     | 58 ++++++++++++++++++++++++++++++++++++++---
 3 files changed, 93 insertions(+), 3 deletions(-)

diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
index 42fd9d7..0436dc2 100644
--- a/target/s390x/cpu_features.c
+++ b/target/s390x/cpu_features.c
@@ -83,9 +83,11 @@ static const S390FeatDef s390_features[] = {
     FEAT_INIT("dfppc", S390_FEAT_TYPE_STFL, 80, "Decimal-floating-point packed-conversion facility"),
     FEAT_INIT("vx", S390_FEAT_TYPE_STFL, 129, "Vector facility"),
 
+    /* SCLP SCCB Byte 80 - 98  (bit numbers relative to byte-80) */
     FEAT_INIT("gsls", S390_FEAT_TYPE_SCLP_CONF_CHAR, 40, "SIE: Guest-storage-limit-suppression facility"),
     FEAT_INIT("esop", S390_FEAT_TYPE_SCLP_CONF_CHAR, 46, "Enhanced-suppression-on-protection facility"),
 
+    /* SCLP SCCB Byte 116 - 119 (bit numbers relative to byte-116) */
     FEAT_INIT("64bscao", S390_FEAT_TYPE_SCLP_CONF_CHAR_EXT, 0, "SIE: 64-bit-SCAO facility"),
     FEAT_INIT("cmma", S390_FEAT_TYPE_SCLP_CONF_CHAR_EXT, 1, "SIE: Collaborative-memory-management assist"),
     FEAT_INIT("pfmfi", S390_FEAT_TYPE_SCLP_CONF_CHAR_EXT, 9, "SIE: PFMF interpretation facility"),
@@ -183,6 +185,7 @@ static const S390FeatDef s390_features[] = {
     FEAT_INIT("kimd-sha-256", S390_FEAT_TYPE_KIMD, 2, "KIMD SHA-256"),
     FEAT_INIT("kimd-sha-512", S390_FEAT_TYPE_KIMD, 3, "KIMD SHA-512"),
     FEAT_INIT("kimd-ghash", S390_FEAT_TYPE_KIMD, 65, "KIMD GHASH"),
+
     FEAT_INIT("klmd-sha-1", S390_FEAT_TYPE_KLMD, 1, "KLMD SHA-1"),
     FEAT_INIT("klmd-sha-256", S390_FEAT_TYPE_KLMD, 2, "KLMD SHA-256"),
     FEAT_INIT("klmd-sha-512", S390_FEAT_TYPE_KLMD, 3, "KLMD SHA-512"),
diff --git a/target/s390x/cpu_features_def.h b/target/s390x/cpu_features_def.h
index aa5ab8d..f5bb7ed 100644
--- a/target/s390x/cpu_features_def.h
+++ b/target/s390x/cpu_features_def.h
@@ -15,6 +15,7 @@
 #define TARGET_S390X_CPU_FEATURES_DEF_H
 
 typedef enum {
+    /* Stfle */
     S390_FEAT_ESAN3 = 0,
     S390_FEAT_ZARCH,
     S390_FEAT_DAT_ENH,
@@ -72,12 +73,18 @@ typedef enum {
     S390_FEAT_EDAT_2,
     S390_FEAT_DFP_PACKED_CONVERSION,
     S390_FEAT_VECTOR,
+
+    /* Sclp Conf Char */
     S390_FEAT_SIE_GSLS,
     S390_FEAT_ESOP,
+
+    /* Sclp Conf Char Ext */
     S390_FEAT_SIE_64BSCAO,
     S390_FEAT_SIE_CMMA,
     S390_FEAT_SIE_PFMFI,
     S390_FEAT_SIE_IBS,
+
+    /* Sclp Cpu */
     S390_FEAT_SIE_F2,
     S390_FEAT_SIE_SKEY,
     S390_FEAT_SIE_GPERE,
@@ -85,8 +92,12 @@ typedef enum {
     S390_FEAT_SIE_SIGPIF,
     S390_FEAT_SIE_IB,
     S390_FEAT_SIE_CEI,
+
+    /* Misc */
     S390_FEAT_DAT_ENH_2,
     S390_FEAT_CMM,
+
+    /* PLO */
     S390_FEAT_PLO_CL,
     S390_FEAT_PLO_CLG,
     S390_FEAT_PLO_CLGR,
@@ -111,6 +122,8 @@ typedef enum {
     S390_FEAT_PLO_CSTSTG,
     S390_FEAT_PLO_CSTSTGR,
     S390_FEAT_PLO_CSTSTX,
+
+    /* PTFF */
     S390_FEAT_PTFF_QTO,
     S390_FEAT_PTFF_QSI,
     S390_FEAT_PTFF_QPT,
@@ -118,6 +131,8 @@ typedef enum {
     S390_FEAT_PTFF_QTOU,
     S390_FEAT_PTFF_STO,
     S390_FEAT_PTFF_STOU,
+
+    /* KMAC */
     S390_FEAT_KMAC_DEA,
     S390_FEAT_KMAC_TDEA_128,
     S390_FEAT_KMAC_TDEA_192,
@@ -130,6 +145,8 @@ typedef enum {
     S390_FEAT_KMAC_EAES_128,
     S390_FEAT_KMAC_EAES_192,
     S390_FEAT_KMAC_EAES_256,
+
+    /* KMC */
     S390_FEAT_KMC_DEA,
     S390_FEAT_KMC_TDEA_128,
     S390_FEAT_KMC_TDEA_192,
@@ -143,6 +160,8 @@ typedef enum {
     S390_FEAT_KMC_EAES_192,
     S390_FEAT_KMC_EAES_256,
     S390_FEAT_KMC_PRNG,
+
+    /* KM */
     S390_FEAT_KM_DEA,
     S390_FEAT_KM_TDEA_128,
     S390_FEAT_KM_TDEA_192,
@@ -159,19 +178,27 @@ typedef enum {
     S390_FEAT_KM_XTS_AES_256,
     S390_FEAT_KM_XTS_EAES_128,
     S390_FEAT_KM_XTS_EAES_256,
+
+    /* KIMD */
     S390_FEAT_KIMD_SHA_1,
     S390_FEAT_KIMD_SHA_256,
     S390_FEAT_KIMD_SHA_512,
     S390_FEAT_KIMD_GHASH,
+
+    /* KLMD */
     S390_FEAT_KLMD_SHA_1,
     S390_FEAT_KLMD_SHA_256,
     S390_FEAT_KLMD_SHA_512,
+
+    /* PCKMO */
     S390_FEAT_PCKMO_EDEA,
     S390_FEAT_PCKMO_ETDEA_128,
     S390_FEAT_PCKMO_ETDEA_256,
     S390_FEAT_PCKMO_AES_128,
     S390_FEAT_PCKMO_AES_192,
     S390_FEAT_PCKMO_AES_256,
+
+    /* KMCTR */
     S390_FEAT_KMCTR_DEA,
     S390_FEAT_KMCTR_TDEA_128,
     S390_FEAT_KMCTR_TDEA_192,
@@ -184,6 +211,8 @@ typedef enum {
     S390_FEAT_KMCTR_EAES_128,
     S390_FEAT_KMCTR_EAES_192,
     S390_FEAT_KMCTR_EAES_256,
+
+    /* KMF */
     S390_FEAT_KMF_DEA,
     S390_FEAT_KMF_TDEA_128,
     S390_FEAT_KMF_TDEA_192,
@@ -196,6 +225,8 @@ typedef enum {
     S390_FEAT_KMF_EAES_128,
     S390_FEAT_KMF_EAES_192,
     S390_FEAT_KMF_EAES_256,
+
+    /* KMO */
     S390_FEAT_KMO_DEA,
     S390_FEAT_KMO_TDEA_128,
     S390_FEAT_KMO_TDEA_192,
@@ -208,6 +239,8 @@ typedef enum {
     S390_FEAT_KMO_EAES_128,
     S390_FEAT_KMO_EAES_192,
     S390_FEAT_KMO_EAES_256,
+
+    /* PCC */
     S390_FEAT_PCC_CMAC_DEA,
     S390_FEAT_PCC_CMAC_TDEA_128,
     S390_FEAT_PCC_CMAC_TDEA_192,
@@ -224,6 +257,8 @@ typedef enum {
     S390_FEAT_PCC_XTS_AES_256,
     S390_FEAT_PCC_XTS_EAES_128,
     S390_FEAT_PCC_XTS_EAES_256,
+
+    /* PPNO */
     S390_FEAT_PPNO_SHA_512_DRNG,
     S390_FEAT_MAX,
 } S390Feat;
diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index e674738..8ca2b47 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -211,14 +211,20 @@ static uint16_t group_MSA_EXT_5[] = {
     S390_FEAT_GROUP_MSA_EXT_5,
 };
 
-/* base features in order of release */
+/* Base features (in order of release)
+ * Only non-hypervisor managed features belong here.
+ * Base feature sets are static meaning they do not change in future QEMU
+ * releases.
+ */
 static uint16_t base_GEN7_GA1[] = {
     S390_FEAT_GROUP_PLO,
     S390_FEAT_ESAN3,
     S390_FEAT_ZARCH,
 };
+
 #define base_GEN7_GA2 EmptyFeat
 #define base_GEN7_GA3 EmptyFeat
+
 static uint16_t base_GEN8_GA1[] = {
     S390_FEAT_DAT_ENH,
     S390_FEAT_EXTENDED_TRANSLATION_2,
@@ -227,10 +233,12 @@ static uint16_t base_GEN8_GA1[] = {
     S390_FEAT_LONG_DISPLACEMENT_FAST,
     S390_FEAT_HFP_MADDSUB,
 };
+
 #define base_GEN8_GA2 EmptyFeat
 #define base_GEN8_GA3 EmptyFeat
 #define base_GEN8_GA4 EmptyFeat
 #define base_GEN8_GA5 EmptyFeat
+
 static uint16_t base_GEN9_GA1[] = {
     S390_FEAT_IDTE_SEGMENT,
     S390_FEAT_ASN_LX_REUSE,
@@ -245,8 +253,10 @@ static uint16_t base_GEN9_GA1[] = {
     S390_FEAT_ETF3_ENH,
     S390_FEAT_DAT_ENH_2,
 };
+
 #define base_GEN9_GA2 EmptyFeat
 #define base_GEN9_GA3 EmptyFeat
+
 static uint16_t base_GEN10_GA1[] = {
     S390_FEAT_CONDITIONAL_SSKE,
     S390_FEAT_PARSING_ENH,
@@ -263,6 +273,7 @@ static uint16_t base_GEN10_GA1[] = {
 };
 #define base_GEN10_GA2 EmptyFeat
 #define base_GEN10_GA3 EmptyFeat
+
 static uint16_t base_GEN11_GA1[] = {
     S390_FEAT_NONQ_KEY_SETTING,
     S390_FEAT_ENHANCED_MONITOR,
@@ -272,21 +283,30 @@ static uint16_t base_GEN11_GA1[] = {
     S390_FEAT_CMPSC_ENH,
     S390_FEAT_INTERLOCKED_ACCESS_2,
 };
+
 #define base_GEN11_GA2 EmptyFeat
+
 static uint16_t base_GEN12_GA1[] = {
     S390_FEAT_DFP_ZONED_CONVERSION,
     S390_FEAT_STFLE_49,
     S390_FEAT_LOCAL_TLB_CLEARING,
 };
+
 #define base_GEN12_GA2 EmptyFeat
+
 static uint16_t base_GEN13_GA1[] = {
     S390_FEAT_STFLE_53,
     S390_FEAT_DFP_PACKED_CONVERSION,
     S390_FEAT_GROUP_GEN13_PTFF,
 };
+
 #define base_GEN13_GA2 EmptyFeat
 
-/* full features differing to the base in order of release */
+/* Full features (in order of release)
+ * Automatically includes corresponding base features.
+ * Full features are all features this hardware supports even if kvm/QEMU do not
+ * support these features yet.
+ */
 static uint16_t full_GEN7_GA1[] = {
     S390_FEAT_SIE_F2,
     S390_FEAT_SIE_SKEY,
@@ -294,30 +314,38 @@ static uint16_t full_GEN7_GA1[] = {
     S390_FEAT_SIE_IB,
     S390_FEAT_SIE_CEI,
 };
+
 static uint16_t full_GEN7_GA2[] = {
     S390_FEAT_EXTENDED_TRANSLATION_2,
 };
+
 static uint16_t full_GEN7_GA3[] = {
     S390_FEAT_LONG_DISPLACEMENT,
     S390_FEAT_SIE_SIIF,
 };
+
 static uint16_t full_GEN8_GA1[] = {
     S390_FEAT_SIE_GSLS,
     S390_FEAT_SIE_64BSCAO,
 };
+
 #define full_GEN8_GA2 EmptyFeat
+
 static uint16_t full_GEN8_GA3[] = {
     S390_FEAT_ASN_LX_REUSE,
     S390_FEAT_EXTENDED_TRANSLATION_3,
 };
+
 #define full_GEN8_GA4 EmptyFeat
 #define full_GEN8_GA5 EmptyFeat
+
 static uint16_t full_GEN9_GA1[] = {
     S390_FEAT_STORE_HYPERVISOR_INFO,
     S390_FEAT_GROUP_MSA_EXT_1,
     S390_FEAT_CMM,
     S390_FEAT_SIE_CMMA,
 };
+
 static uint16_t full_GEN9_GA2[] = {
     S390_FEAT_MOVE_WITH_OPTIONAL_SPEC,
     S390_FEAT_EXTRACT_CPU_TIME,
@@ -325,10 +353,12 @@ static uint16_t full_GEN9_GA2[] = {
     S390_FEAT_FLOATING_POINT_SUPPPORT_ENH,
     S390_FEAT_DFP,
 };
+
 static uint16_t full_GEN9_GA3[] = {
     S390_FEAT_CONDITIONAL_SSKE,
     S390_FEAT_PFPO,
 };
+
 static uint16_t full_GEN10_GA1[] = {
     S390_FEAT_EDAT,
     S390_FEAT_CONFIGURATION_TOPOLOGY,
@@ -337,34 +367,46 @@ static uint16_t full_GEN10_GA1[] = {
     S390_FEAT_SIE_PFMFI,
     S390_FEAT_SIE_SIGPIF,
 };
+
 static uint16_t full_GEN10_GA2[] = {
     S390_FEAT_SET_PROGRAM_PARAMETERS,
     S390_FEAT_SIE_IBS,
 };
+
 static uint16_t full_GEN10_GA3[] = {
     S390_FEAT_GROUP_MSA_EXT_3,
 };
+
 static uint16_t full_GEN11_GA1[] = {
     S390_FEAT_IPTE_RANGE,
     S390_FEAT_ACCESS_EXCEPTION_FS_INDICATION,
     S390_FEAT_GROUP_MSA_EXT_4,
 };
+
 #define full_GEN11_GA2 EmptyFeat
+
 static uint16_t full_GEN12_GA1[] = {
     S390_FEAT_CONSTRAINT_TRANSACTIONAL_EXE,
     S390_FEAT_TRANSACTIONAL_EXE,
     S390_FEAT_RUNTIME_INSTRUMENTATION,
     S390_FEAT_EDAT_2,
 };
+
 static uint16_t full_GEN12_GA2[] = {
     S390_FEAT_GROUP_MSA_EXT_5,
 };
+
 static uint16_t full_GEN13_GA1[] = {
     S390_FEAT_VECTOR,
 };
+
 #define full_GEN13_GA2 EmptyFeat
 
-/* default features differing to the base in order of release */
+/* Default features (in order of release)
+ * Automatically includes corresponding base features.
+ * Default features are all features this version of QEMU supports for this
+ * hardware model. Default feature sets can grow with new QEMU releases.
+ */
 #define default_GEN7_GA1 EmptyFeat
 #define default_GEN7_GA2 EmptyFeat
 #define default_GEN7_GA3 EmptyFeat
@@ -373,37 +415,47 @@ static uint16_t full_GEN13_GA1[] = {
 #define default_GEN8_GA3 EmptyFeat
 #define default_GEN8_GA4 EmptyFeat
 #define default_GEN8_GA5 EmptyFeat
+
 static uint16_t default_GEN9_GA1[] = {
     S390_FEAT_STORE_HYPERVISOR_INFO,
     S390_FEAT_GROUP_MSA_EXT_1,
     S390_FEAT_CMM,
 };
+
 #define default_GEN9_GA2 EmptyFeat
 #define default_GEN9_GA3 EmptyFeat
+
 static uint16_t default_GEN10_GA1[] = {
     S390_FEAT_EDAT,
     S390_FEAT_GROUP_MSA_EXT_2,
 };
+
 #define default_GEN10_GA2 EmptyFeat
 #define default_GEN10_GA3 EmptyFeat
+
 static uint16_t default_GEN11_GA1[] = {
     S390_FEAT_GROUP_MSA_EXT_3,
     S390_FEAT_IPTE_RANGE,
     S390_FEAT_ACCESS_EXCEPTION_FS_INDICATION,
     S390_FEAT_GROUP_MSA_EXT_4,
 };
+
 #define default_GEN11_GA2 EmptyFeat
+
 static uint16_t default_GEN12_GA1[] = {
     S390_FEAT_CONSTRAINT_TRANSACTIONAL_EXE,
     S390_FEAT_TRANSACTIONAL_EXE,
     S390_FEAT_RUNTIME_INSTRUMENTATION,
     S390_FEAT_EDAT_2,
 };
+
 #define default_GEN12_GA2 EmptyFeat
+
 static uint16_t default_GEN13_GA1[] = {
     S390_FEAT_GROUP_MSA_EXT_5,
     S390_FEAT_VECTOR,
 };
+
 #define default_GEN13_GA2 EmptyFeat
 
 /****** END FEATURE DEFS ******/
-- 
2.7.4
