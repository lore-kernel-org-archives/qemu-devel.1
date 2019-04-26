Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2751BC43219
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 11:21:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D762F206C1
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 11:21:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D762F206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45108 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJyuk-0003PL-3x
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 07:21:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1hJylG-0002vK-LY
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 07:11:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1hJylE-0003kn-3M
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 07:11:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52760)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1hJylD-0002pu-OM
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 07:11:20 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x3QB8bTG102062
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 07:10:16 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2s40uj035d-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 07:10:16 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 26 Apr 2019 12:10:15 +0100
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
	by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Fri, 26 Apr 2019 12:10:13 +0100
Received: from b03ledav006.gho.boulder.ibm.com
	(b03ledav006.gho.boulder.ibm.com [9.17.130.237])
	by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x3QBABHT66650322
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Fri, 26 Apr 2019 11:10:11 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8DB30C6055;
	Fri, 26 Apr 2019 11:10:11 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C6BEEC6057;
	Fri, 26 Apr 2019 11:10:10 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.114.17.106])
	by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
	Fri, 26 Apr 2019 11:10:10 +0000 (GMT)
From: Christian Borntraeger <borntraeger@de.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>
Date: Fri, 26 Apr 2019 07:10:00 -0400
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190426111003.21246-1-borntraeger@de.ibm.com>
References: <20190426111003.21246-1-borntraeger@de.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19042611-0016-0000-0000-000009A74D06
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010998; HX=3.00000242; KW=3.00000007;
	PH=3.00000004; SC=3.00000285; SDB=6.01194611; UDB=6.00626339;
	IPR=6.00975446; 
	MB=3.00026606; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-26 11:10:14
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042611-0017-0000-0000-000042F775AA
Message-Id: <20190426111003.21246-8-borntraeger@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-04-26_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1904260078
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: [Qemu-devel] [PATCH v2 07/10] s390x/cpumodel: add
 Deflate-conversion facility
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
Message-ID: <20190426111000.zeHenH7Oh4wEZ0CHlaB3PfrGpiI4Jeb7ChCBrTp0kks@z>

add the deflate conversion facility.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 target/s390x/cpu_features.c     |  9 +++++++++
 target/s390x/cpu_features.h     |  1 +
 target/s390x/cpu_features_def.h |  7 +++++++
 target/s390x/gen-features.c     | 12 ++++++++++++
 target/s390x/kvm.c              |  6 ++++++
 5 files changed, 35 insertions(+)

diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
index 1d19b3072e..f64f581c86 100644
--- a/target/s390x/cpu_features.c
+++ b/target/s390x/cpu_features.c
@@ -110,6 +110,7 @@ static const S390FeatDef s390_features[] = {
     FEAT_INIT("cmmnt", S390_FEAT_TYPE_STFL, 147, "CMM: ESSA-enhancement (no translate) facility"),
     FEAT_INIT("vxeh2", S390_FEAT_TYPE_STFL, 148, "Vector Enhancements facility 2"),
     FEAT_INIT("esort-base", S390_FEAT_TYPE_STFL, 150, "Enhanced-sort facility (excluding subfunctions)"),
+    FEAT_INIT("deflate-base", S390_FEAT_TYPE_STFL, 151, "Deflate-conversion facility (excluding subfunctions)"),
     FEAT_INIT("vxbeh", S390_FEAT_TYPE_STFL, 152, "Vector BCD enhancements facility 1"),
     FEAT_INIT("msa9-base", S390_FEAT_TYPE_STFL, 155, "Message-security-assist-extension-9 facility (excluding subfunctions)"),
     FEAT_INIT("etoken", S390_FEAT_TYPE_STFL, 156, "Etoken facility"),
@@ -347,6 +348,11 @@ static const S390FeatDef s390_features[] = {
     FEAT_INIT("sortl-32", S390_FEAT_TYPE_SORTL, 130, "SORTL 32 input lists"),
     FEAT_INIT("sortl-128", S390_FEAT_TYPE_SORTL, 132, "SORTL 128 input lists"),
     FEAT_INIT("sortl-f0", S390_FEAT_TYPE_SORTL, 192, "SORTL format 0 parameter-block"),
+
+    FEAT_INIT("dfltcc-gdht", S390_FEAT_TYPE_DFLTCC, 1, "DFLTCC GDHT"),
+    FEAT_INIT("dfltcc-cmpr", S390_FEAT_TYPE_DFLTCC, 2, "DFLTCC CMPR"),
+    FEAT_INIT("dfltcc-xpnd", S390_FEAT_TYPE_DFLTCC, 4, "DFLTCC XPND"),
+    FEAT_INIT("dfltcc-f0", S390_FEAT_TYPE_DFLTCC, 192, "DFLTCC format 0 parameter-block"),
 };
 
 const S390FeatDef *s390_feat_def(S390Feat feat)
@@ -411,6 +417,7 @@ void s390_fill_feat_block(const S390FeatBitmap features, S390FeatType type,
     case S390_FEAT_TYPE_KMA:
     case S390_FEAT_TYPE_KDSA:
     case S390_FEAT_TYPE_SORTL:
+    case S390_FEAT_TYPE_DFLTCC:
         set_be_bit(0, data); /* query is always available */
         break;
     default:
@@ -439,6 +446,7 @@ void s390_add_from_feat_block(S390FeatBitmap features, S390FeatType type,
        break;
     case S390_FEAT_TYPE_PLO:
     case S390_FEAT_TYPE_SORTL:
+    case S390_FEAT_TYPE_DFLTCC:
        nr_bits = 256;
        break;
     default:
@@ -511,6 +519,7 @@ static S390FeatGroupDef s390_feature_groups[] = {
     FEAT_GROUP_INIT("msa9_pckmo", MSA_EXT_9_PCKMO, "Message-security-assist-extension 9 PCKMO subfunctions"),
     FEAT_GROUP_INIT("mepochptff", MULTIPLE_EPOCH_PTFF, "PTFF enhancements introduced with Multiple-epoch facility"),
     FEAT_GROUP_INIT("esort", ENH_SORT, "Enhanced-sort facility"),
+    FEAT_GROUP_INIT("deflate", DEFLATE_CONVERSION, "Deflate-conversion facility"),
 };
 
 const S390FeatGroupDef *s390_feat_group_def(S390FeatGroup group)
diff --git a/target/s390x/cpu_features.h b/target/s390x/cpu_features.h
index 3b8c5b25dd..da695a8346 100644
--- a/target/s390x/cpu_features.h
+++ b/target/s390x/cpu_features.h
@@ -41,6 +41,7 @@ typedef enum {
     S390_FEAT_TYPE_KMA,
     S390_FEAT_TYPE_KDSA,
     S390_FEAT_TYPE_SORTL,
+    S390_FEAT_TYPE_DFLTCC,
 } S390FeatType;
 
 /* Definition of a CPU feature */
diff --git a/target/s390x/cpu_features_def.h b/target/s390x/cpu_features_def.h
index bb8585847f..292b17b35d 100644
--- a/target/s390x/cpu_features_def.h
+++ b/target/s390x/cpu_features_def.h
@@ -98,6 +98,7 @@ typedef enum {
     S390_FEAT_CMM_NT,
     S390_FEAT_VECTOR_ENH2,
     S390_FEAT_ESORT_BASE,
+    S390_FEAT_DEFLATE_BASE,
     S390_FEAT_VECTOR_BCD_ENH,
     S390_FEAT_MSA_EXT_9,
     S390_FEAT_ETOKEN,
@@ -354,6 +355,12 @@ typedef enum {
     S390_FEAT_SORTL_128,
     S390_FEAT_SORTL_F0,
 
+    /* DEFLATE */
+    S390_FEAT_DEFLATE_GHDT,
+    S390_FEAT_DEFLATE_CMPR,
+    S390_FEAT_DEFLATE_XPND,
+    S390_FEAT_DEFLATE_F0,
+
     S390_FEAT_MAX,
 } S390Feat;
 
diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 0a62cc5631..8fc2e8e72f 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -254,6 +254,13 @@
     S390_FEAT_SORTL_F0
 
 
+#define S390_FEAT_GROUP_DEFLATE_CONVERSION \
+    S390_FEAT_DEFLATE_BASE, \
+    S390_FEAT_DEFLATE_GHDT, \
+    S390_FEAT_DEFLATE_CMPR, \
+    S390_FEAT_DEFLATE_XPND, \
+    S390_FEAT_DEFLATE_F0
+
 /* cpu feature groups */
 static uint16_t group_PLO[] = {
     S390_FEAT_GROUP_PLO,
@@ -307,6 +314,10 @@ static uint16_t group_ENH_SORT[] = {
     S390_FEAT_GROUP_ENH_SORT,
 };
 
+static uint16_t group_DEFLATE_CONVERSION[] = {
+    S390_FEAT_GROUP_DEFLATE_CONVERSION,
+};
+
 /* Base features (in order of release)
  * Only non-hypervisor managed features belong here.
  * Base feature sets are static meaning they do not change in future QEMU
@@ -766,6 +777,7 @@ static FeatGroupDefSpec FeatGroupDef[] = {
     FEAT_GROUP_INITIALIZER(MSA_EXT_9_PCKMO),
     FEAT_GROUP_INITIALIZER(MULTIPLE_EPOCH_PTFF),
     FEAT_GROUP_INITIALIZER(ENH_SORT),
+    FEAT_GROUP_INITIALIZER(DEFLATE_CONVERSION),
 };
 
 #define QEMU_FEAT_INITIALIZER(_name)                   \
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index f91f436a31..e5e2b691f2 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -2079,6 +2079,9 @@ static int query_cpu_subfunc(S390FeatBitmap features)
     if (test_bit(S390_FEAT_ESORT_BASE, features)) {
         s390_add_from_feat_block(features, S390_FEAT_TYPE_SORTL, prop.sortl);
     }
+    if (test_bit(S390_FEAT_DEFLATE_BASE, features)) {
+        s390_add_from_feat_block(features, S390_FEAT_TYPE_DFLTCC, prop.dfltcc);
+    }
     return 0;
 }
 
@@ -2129,6 +2132,9 @@ static int configure_cpu_subfunc(const S390FeatBitmap features)
     if (test_bit(S390_FEAT_ESORT_BASE, features)) {
         s390_fill_feat_block(features, S390_FEAT_TYPE_SORTL, prop.sortl);
     }
+    if (test_bit(S390_FEAT_DEFLATE_BASE, features)) {
+        s390_fill_feat_block(features, S390_FEAT_TYPE_DFLTCC, prop.dfltcc);
+    }
     return kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, &attr);
 }
 
-- 
2.17.1


