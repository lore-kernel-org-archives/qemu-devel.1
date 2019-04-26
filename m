Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2062CC43218
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 11:19:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D32F0206C1
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 11:19:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D32F0206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45043 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJysy-0001uR-2j
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 07:19:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1hJyms-0004t3-6w
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 07:13:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1hJymp-0005cW-BN
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 07:13:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56010
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1hJymp-0005af-6x
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 07:12:59 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x3QBCrDd108326
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 07:12:58 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2s3x5grtk1-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 07:12:49 -0400
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 26 Apr 2019 12:10:14 +0100
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
	by e36.co.us.ibm.com (192.168.1.136) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Fri, 26 Apr 2019 12:10:12 +0100
Received: from b03ledav006.gho.boulder.ibm.com
	(b03ledav006.gho.boulder.ibm.com [9.17.130.237])
	by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x3QBAAms34210028
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Fri, 26 Apr 2019 11:10:10 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9FFBDC605A;
	Fri, 26 Apr 2019 11:10:10 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA879C6057;
	Fri, 26 Apr 2019 11:10:09 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.114.17.106])
	by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
	Fri, 26 Apr 2019 11:10:09 +0000 (GMT)
From: Christian Borntraeger <borntraeger@de.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>
Date: Fri, 26 Apr 2019 07:09:59 -0400
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190426111003.21246-1-borntraeger@de.ibm.com>
References: <20190426111003.21246-1-borntraeger@de.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19042611-0020-0000-0000-00000EDD4C78
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010998; HX=3.00000242; KW=3.00000007;
	PH=3.00000004; SC=3.00000285; SDB=6.01194610; UDB=6.00626339;
	IPR=6.00975446; 
	MB=3.00026606; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-26 11:10:14
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042611-0021-0000-0000-000065935DB2
Message-Id: <20190426111003.21246-7-borntraeger@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-04-26_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1904260078
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: [Qemu-devel] [PATCH v2 06/10] s390x/cpumodel: enhanced sort facility
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "Jason J . Herne" <jjherne@linux.ibm.com>,
	Collin Walling <walling@linux.ibm.com>,
	David Hildenbrand <david@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
	Halil Pasic <pasic@linux.ibm.com>, qemu-s390x <qemu-s390x@nongnu.org>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190426110959.Wm_GW0258GwisVOKvRxncNvWJKPdCxW9ZGd3uz8fFto@z>

add the enhanced sort facility.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu_features.c     | 10 ++++++++++
 target/s390x/cpu_features.h     |  1 +
 target/s390x/cpu_features_def.h |  8 ++++++++
 target/s390x/gen-features.c     | 14 ++++++++++++++
 target/s390x/kvm.c              |  6 ++++++
 5 files changed, 39 insertions(+)

diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
index 35873253be..1d19b3072e 100644
--- a/target/s390x/cpu_features.c
+++ b/target/s390x/cpu_features.c
@@ -109,6 +109,7 @@ static const S390FeatDef s390_features[] = {
     FEAT_INIT("msa8-base", S390_FEAT_TYPE_STFL, 146, "Message-security-assist-extension-8 facility (excluding subfunctions)"),
     FEAT_INIT("cmmnt", S390_FEAT_TYPE_STFL, 147, "CMM: ESSA-enhancement (no translate) facility"),
     FEAT_INIT("vxeh2", S390_FEAT_TYPE_STFL, 148, "Vector Enhancements facility 2"),
+    FEAT_INIT("esort-base", S390_FEAT_TYPE_STFL, 150, "Enhanced-sort facility (excluding subfunctions)"),
     FEAT_INIT("vxbeh", S390_FEAT_TYPE_STFL, 152, "Vector BCD enhancements facility 1"),
     FEAT_INIT("msa9-base", S390_FEAT_TYPE_STFL, 155, "Message-security-assist-extension-9 facility (excluding subfunctions)"),
     FEAT_INIT("etoken", S390_FEAT_TYPE_STFL, 156, "Etoken facility"),
@@ -340,6 +341,12 @@ static const S390FeatDef s390_features[] = {
     FEAT_INIT("kdsa-eddsa-sign-ed448", S390_FEAT_TYPE_KDSA, 44, "KDSA EdDSA-Sign-Ed448"),
     FEAT_INIT("kdsa-eeddsa-sign-ed25519", S390_FEAT_TYPE_KDSA, 48, "KDSA Encrypted-EdDSA-Sign-Ed25519"),
     FEAT_INIT("kdsa-eeddsa-sign-ed448", S390_FEAT_TYPE_KDSA, 52, "KDSA Encrypted-EdDSA-Sign-Ed448"),
+
+    FEAT_INIT("sortl-sflr", S390_FEAT_TYPE_SORTL, 1, "SORTL SFLR"),
+    FEAT_INIT("sortl-svlr", S390_FEAT_TYPE_SORTL, 2, "SORTL SVLR"),
+    FEAT_INIT("sortl-32", S390_FEAT_TYPE_SORTL, 130, "SORTL 32 input lists"),
+    FEAT_INIT("sortl-128", S390_FEAT_TYPE_SORTL, 132, "SORTL 128 input lists"),
+    FEAT_INIT("sortl-f0", S390_FEAT_TYPE_SORTL, 192, "SORTL format 0 parameter-block"),
 };
 
 const S390FeatDef *s390_feat_def(S390Feat feat)
@@ -403,6 +410,7 @@ void s390_fill_feat_block(const S390FeatBitmap features, S390FeatType type,
     case S390_FEAT_TYPE_PPNO:
     case S390_FEAT_TYPE_KMA:
     case S390_FEAT_TYPE_KDSA:
+    case S390_FEAT_TYPE_SORTL:
         set_be_bit(0, data); /* query is always available */
         break;
     default:
@@ -430,6 +438,7 @@ void s390_add_from_feat_block(S390FeatBitmap features, S390FeatType type,
        nr_bits = 16384;
        break;
     case S390_FEAT_TYPE_PLO:
+    case S390_FEAT_TYPE_SORTL:
        nr_bits = 256;
        break;
     default:
@@ -501,6 +510,7 @@ static S390FeatGroupDef s390_feature_groups[] = {
     FEAT_GROUP_INIT("msa9", MSA_EXT_9, "Message-security-assist-extension 9 facility"),
     FEAT_GROUP_INIT("msa9_pckmo", MSA_EXT_9_PCKMO, "Message-security-assist-extension 9 PCKMO subfunctions"),
     FEAT_GROUP_INIT("mepochptff", MULTIPLE_EPOCH_PTFF, "PTFF enhancements introduced with Multiple-epoch facility"),
+    FEAT_GROUP_INIT("esort", ENH_SORT, "Enhanced-sort facility"),
 };
 
 const S390FeatGroupDef *s390_feat_group_def(S390FeatGroup group)
diff --git a/target/s390x/cpu_features.h b/target/s390x/cpu_features.h
index 5ffd3db083..3b8c5b25dd 100644
--- a/target/s390x/cpu_features.h
+++ b/target/s390x/cpu_features.h
@@ -40,6 +40,7 @@ typedef enum {
     S390_FEAT_TYPE_PPNO,
     S390_FEAT_TYPE_KMA,
     S390_FEAT_TYPE_KDSA,
+    S390_FEAT_TYPE_SORTL,
 } S390FeatType;
 
 /* Definition of a CPU feature */
diff --git a/target/s390x/cpu_features_def.h b/target/s390x/cpu_features_def.h
index ce2223c9d7..bb8585847f 100644
--- a/target/s390x/cpu_features_def.h
+++ b/target/s390x/cpu_features_def.h
@@ -97,6 +97,7 @@ typedef enum {
     S390_FEAT_MSA_EXT_8,
     S390_FEAT_CMM_NT,
     S390_FEAT_VECTOR_ENH2,
+    S390_FEAT_ESORT_BASE,
     S390_FEAT_VECTOR_BCD_ENH,
     S390_FEAT_MSA_EXT_9,
     S390_FEAT_ETOKEN,
@@ -346,6 +347,13 @@ typedef enum {
     S390_FEAT_EEDDSA_SIGN_ED25519,
     S390_FEAT_EEDDSA_SIGN_ED448,
 
+    /* SORTL */
+    S390_FEAT_SORTL_SFLR,
+    S390_FEAT_SORTL_SVLR,
+    S390_FEAT_SORTL_32,
+    S390_FEAT_SORTL_128,
+    S390_FEAT_SORTL_F0,
+
     S390_FEAT_MAX,
 } S390Feat;
 
diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index a2f9e2b43f..0a62cc5631 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -245,6 +245,15 @@
     S390_FEAT_PCKMO_ECC_ED25519, \
     S390_FEAT_PCKMO_ECC_ED448
 
+#define S390_FEAT_GROUP_ENH_SORT \
+    S390_FEAT_ESORT_BASE, \
+    S390_FEAT_SORTL_SFLR, \
+    S390_FEAT_SORTL_SVLR, \
+    S390_FEAT_SORTL_32, \
+    S390_FEAT_SORTL_128, \
+    S390_FEAT_SORTL_F0
+
+
 /* cpu feature groups */
 static uint16_t group_PLO[] = {
     S390_FEAT_GROUP_PLO,
@@ -294,6 +303,10 @@ static uint16_t group_MSA_EXT_9_PCKMO[] = {
     S390_FEAT_GROUP_MSA_EXT_9_PCKMO,
 };
 
+static uint16_t group_ENH_SORT[] = {
+    S390_FEAT_GROUP_ENH_SORT,
+};
+
 /* Base features (in order of release)
  * Only non-hypervisor managed features belong here.
  * Base feature sets are static meaning they do not change in future QEMU
@@ -752,6 +765,7 @@ static FeatGroupDefSpec FeatGroupDef[] = {
     FEAT_GROUP_INITIALIZER(MSA_EXT_9),
     FEAT_GROUP_INITIALIZER(MSA_EXT_9_PCKMO),
     FEAT_GROUP_INITIALIZER(MULTIPLE_EPOCH_PTFF),
+    FEAT_GROUP_INITIALIZER(ENH_SORT),
 };
 
 #define QEMU_FEAT_INITIALIZER(_name)                   \
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index de0b984b68..f91f436a31 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -2076,6 +2076,9 @@ static int query_cpu_subfunc(S390FeatBitmap features)
     if (test_bit(S390_FEAT_MSA_EXT_9, features)) {
         s390_add_from_feat_block(features, S390_FEAT_TYPE_KDSA, prop.kdsa);
     }
+    if (test_bit(S390_FEAT_ESORT_BASE, features)) {
+        s390_add_from_feat_block(features, S390_FEAT_TYPE_SORTL, prop.sortl);
+    }
     return 0;
 }
 
@@ -2123,6 +2126,9 @@ static int configure_cpu_subfunc(const S390FeatBitmap features)
     if (test_bit(S390_FEAT_MSA_EXT_9, features)) {
         s390_fill_feat_block(features, S390_FEAT_TYPE_KDSA, prop.kdsa);
     }
+    if (test_bit(S390_FEAT_ESORT_BASE, features)) {
+        s390_fill_feat_block(features, S390_FEAT_TYPE_SORTL, prop.sortl);
+    }
     return kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, &attr);
 }
 
-- 
2.17.1


