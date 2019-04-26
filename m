Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E89C43219
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 11:18:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15735206C1
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 11:18:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15735206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45039 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJyrl-00011u-4K
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 07:18:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1hJykv-0002Ww-VC
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 07:11:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1hJyku-0003Q8-3T
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 07:11:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46506
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1hJykt-0003MN-Uq
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 07:11:00 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x3QB9ieZ009639
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 07:10:57 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2s3y27dm2k-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 07:10:55 -0400
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 26 Apr 2019 12:10:22 +0100
Received: from b03cxnp08025.gho.boulder.ibm.com (9.17.130.17)
	by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Fri, 26 Apr 2019 12:10:10 +0100
Received: from b03ledav006.gho.boulder.ibm.com
	(b03ledav006.gho.boulder.ibm.com [9.17.130.237])
	by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x3QBA80H52232264
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Fri, 26 Apr 2019 11:10:08 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C657CC6055;
	Fri, 26 Apr 2019 11:10:08 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 000B7C605A;
	Fri, 26 Apr 2019 11:10:07 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.114.17.106])
	by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
	Fri, 26 Apr 2019 11:10:07 +0000 (GMT)
From: Christian Borntraeger <borntraeger@de.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>
Date: Fri, 26 Apr 2019 07:09:57 -0400
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190426111003.21246-1-borntraeger@de.ibm.com>
References: <20190426111003.21246-1-borntraeger@de.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19042611-0012-0000-0000-0000172C49ED
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010998; HX=3.00000242; KW=3.00000007;
	PH=3.00000004; SC=3.00000285; SDB=6.01194611; UDB=6.00626339;
	IPR=6.00975446; 
	MB=3.00026607; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-26 11:10:20
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042611-0013-0000-0000-000057047BB8
Message-Id: <20190426111003.21246-5-borntraeger@de.ibm.com>
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
Subject: [Qemu-devel] [PATCH v2 04/10] s390x/cpumodel: msa9 facility
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
Message-ID: <20190426110957.Qru_lGRyh8azIKJP1Cm_R5Dm2QDw4-_F7rTZa06mmJ8@z>

Provide the MSA9 facility (stfle.155).
This also contains pckmo functions for key wrapping. Keep them in a
separate group to disable those as a block if necessary.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 target/s390x/cpu_features.c     | 32 +++++++++++++++++++++++++
 target/s390x/cpu_features.h     |  1 +
 target/s390x/cpu_features_def.h | 31 ++++++++++++++++++++++++
 target/s390x/cpu_models.c       |  2 ++
 target/s390x/gen-features.c     | 42 +++++++++++++++++++++++++++++++++
 target/s390x/kvm.c              |  6 +++++
 6 files changed, 114 insertions(+)

diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
index bbd8902087..154e2bb354 100644
--- a/target/s390x/cpu_features.c
+++ b/target/s390x/cpu_features.c
@@ -108,6 +108,7 @@ static const S390FeatDef s390_features[] = {
     FEAT_INIT("irbm", S390_FEAT_TYPE_STFL, 145, "Insert-reference-bits-multiple facility"),
     FEAT_INIT("msa8-base", S390_FEAT_TYPE_STFL, 146, "Message-security-assist-extension-8 facility (excluding subfunctions)"),
     FEAT_INIT("cmmnt", S390_FEAT_TYPE_STFL, 147, "CMM: ESSA-enhancement (no translate) facility"),
+    FEAT_INIT("msa9-base", S390_FEAT_TYPE_STFL, 155, "Message-security-assist-extension-9 facility (excluding subfunctions)"),
     FEAT_INIT("etoken", S390_FEAT_TYPE_STFL, 156, "Etoken facility"),
 
     /* SCLP SCCB Byte 80 - 98  (bit numbers relative to byte-80) */
@@ -242,6 +243,11 @@ static const S390FeatDef s390_features[] = {
     FEAT_INIT("pckmo-aes-128", S390_FEAT_TYPE_PCKMO, 18, "PCKMO Encrypted-AES-128-Key"),
     FEAT_INIT("pckmo-aes-192", S390_FEAT_TYPE_PCKMO, 19, "PCKMO Encrypted-AES-192-Key"),
     FEAT_INIT("pckmo-aes-256", S390_FEAT_TYPE_PCKMO, 20, "PCKMO Encrypted-AES-256-Key"),
+    FEAT_INIT("pckmo-ecc-p256", S390_FEAT_TYPE_PCKMO, 32, "PCKMO Encrypt-ECC-P256-Key"),
+    FEAT_INIT("pckmo-ecc-p384", S390_FEAT_TYPE_PCKMO, 33, "PCKMO Encrypt-ECC-P384-Key"),
+    FEAT_INIT("pckmo-ecc-p521", S390_FEAT_TYPE_PCKMO, 34, "PCKMO Encrypt-ECC-P521-Key"),
+    FEAT_INIT("pckmo-ecc-ed25519", S390_FEAT_TYPE_PCKMO, 40 , "PCKMO Encrypt-ECC-Ed25519-Key"),
+    FEAT_INIT("pckmo-ecc-ed448", S390_FEAT_TYPE_PCKMO, 41 , "PCKMO Encrypt-ECC-Ed448-Key"),
 
     FEAT_INIT("kmctr-dea", S390_FEAT_TYPE_KMCTR, 1, "KMCTR DEA"),
     FEAT_INIT("kmctr-tdea-128", S390_FEAT_TYPE_KMCTR, 2, "KMCTR TDEA-128"),
@@ -298,6 +304,13 @@ static const S390FeatDef s390_features[] = {
     FEAT_INIT("pcc-xts-aes-256", S390_FEAT_TYPE_PCC, 52, "PCC Compute-XTS-Parameter-Using-AES-256"),
     FEAT_INIT("pcc-xts-eaes-128", S390_FEAT_TYPE_PCC, 58, "PCC Compute-XTS-Parameter-Using-Encrypted-AES-128"),
     FEAT_INIT("pcc-xts-eaes-256", S390_FEAT_TYPE_PCC, 60, "PCC Compute-XTS-Parameter-Using-Encrypted-AES-256"),
+    FEAT_INIT("pcc-scalar-mult-p256", S390_FEAT_TYPE_PCC, 64, "PCC Scalar-Multiply-P256"),
+    FEAT_INIT("pcc-scalar-mult-p384", S390_FEAT_TYPE_PCC, 65, "PCC Scalar-Multiply-P384"),
+    FEAT_INIT("pcc-scalar-mult-p521", S390_FEAT_TYPE_PCC, 66, "PCC Scalar-Multiply-P521"),
+    FEAT_INIT("pcc-scalar-mult-ed25519", S390_FEAT_TYPE_PCC, 72, "PCC Scalar-Multiply-Ed25519"),
+    FEAT_INIT("pcc-scalar-mult-ed448", S390_FEAT_TYPE_PCC, 73, "PCC Scalar-Multiply-Ed448"),
+    FEAT_INIT("pcc-scalar-mult-x25519", S390_FEAT_TYPE_PCC, 80, "PCC Scalar-Multiply-X25519"),
+    FEAT_INIT("pcc-scalar-mult-x448", S390_FEAT_TYPE_PCC, 81, "PCC Scalar-Multiply-X448"),
 
     FEAT_INIT("ppno-sha-512-drng", S390_FEAT_TYPE_PPNO, 3, "PPNO SHA-512-DRNG"),
     FEAT_INIT("prno-trng-qrtcr", S390_FEAT_TYPE_PPNO, 112, "PRNO TRNG-Query-Raw-to-Conditioned-Ratio"),
@@ -309,6 +322,22 @@ static const S390FeatDef s390_features[] = {
     FEAT_INIT("kma-gcm-eaes-128", S390_FEAT_TYPE_KMA, 26, "KMA GCM-Encrypted-AES-128"),
     FEAT_INIT("kma-gcm-eaes-192", S390_FEAT_TYPE_KMA, 27, "KMA GCM-Encrypted-AES-192"),
     FEAT_INIT("kma-gcm-eaes-256", S390_FEAT_TYPE_KMA, 28, "KMA GCM-Encrypted-AES-256"),
+
+    FEAT_INIT("kdsa-ecdsa-verify-p256", S390_FEAT_TYPE_KDSA, 1, "KDSA ECDSA-Verify-P256"),
+    FEAT_INIT("kdsa-ecdsa-verify-p384", S390_FEAT_TYPE_KDSA, 2, "KDSA ECDSA-Verify-P384"),
+    FEAT_INIT("kdsa-ecdsa-verify-p521", S390_FEAT_TYPE_KDSA, 3, "KDSA ECDSA-Verify-P521"),
+    FEAT_INIT("kdsa-ecdsa-sign-p256", S390_FEAT_TYPE_KDSA, 9, "KDSA ECDSA-Sign-P256"),
+    FEAT_INIT("kdsa-ecdsa-sign-p384", S390_FEAT_TYPE_KDSA, 10, "KDSA ECDSA-Sign-P384"),
+    FEAT_INIT("kdsa-ecdsa-sign-p521", S390_FEAT_TYPE_KDSA, 11, "KDSA ECDSA-Sign-P521"),
+    FEAT_INIT("kdsa-eecdsa-sign-p256", S390_FEAT_TYPE_KDSA, 17, "KDSA Encrypted-ECDSA-Sign-P256"),
+    FEAT_INIT("kdsa-eecdsa-sign-p384", S390_FEAT_TYPE_KDSA, 18, "KDSA Encrypted-ECDSA-Sign-P384"),
+    FEAT_INIT("kdsa-eecdsa-sign-p521", S390_FEAT_TYPE_KDSA, 19, "KDSA Encrypted-ECDSA-Sign-P521"),
+    FEAT_INIT("kdsa-eddsa-verify-ed25519", S390_FEAT_TYPE_KDSA, 32, "KDSA EdDSA-Verify-Ed25519"),
+    FEAT_INIT("kdsa-eddsa-verify-ed448", S390_FEAT_TYPE_KDSA, 36, "KDSA EdDSA-Verify-Ed448"),
+    FEAT_INIT("kdsa-eddsa-sign-ed25519", S390_FEAT_TYPE_KDSA, 40, "KDSA EdDSA-Sign-Ed25519"),
+    FEAT_INIT("kdsa-eddsa-sign-ed448", S390_FEAT_TYPE_KDSA, 44, "KDSA EdDSA-Sign-Ed448"),
+    FEAT_INIT("kdsa-eeddsa-sign-ed25519", S390_FEAT_TYPE_KDSA, 48, "KDSA Encrypted-EdDSA-Sign-Ed25519"),
+    FEAT_INIT("kdsa-eeddsa-sign-ed448", S390_FEAT_TYPE_KDSA, 52, "KDSA Encrypted-EdDSA-Sign-Ed448"),
 };
 
 const S390FeatDef *s390_feat_def(S390Feat feat)
@@ -371,6 +400,7 @@ void s390_fill_feat_block(const S390FeatBitmap features, S390FeatType type,
     case S390_FEAT_TYPE_PCC:
     case S390_FEAT_TYPE_PPNO:
     case S390_FEAT_TYPE_KMA:
+    case S390_FEAT_TYPE_KDSA:
         set_be_bit(0, data); /* query is always available */
         break;
     default:
@@ -466,6 +496,8 @@ static S390FeatGroupDef s390_feature_groups[] = {
     FEAT_GROUP_INIT("msa6", MSA_EXT_6, "Message-security-assist-extension 6 facility"),
     FEAT_GROUP_INIT("msa7", MSA_EXT_7, "Message-security-assist-extension 7 facility"),
     FEAT_GROUP_INIT("msa8", MSA_EXT_8, "Message-security-assist-extension 8 facility"),
+    FEAT_GROUP_INIT("msa9", MSA_EXT_9, "Message-security-assist-extension 9 facility"),
+    FEAT_GROUP_INIT("msa9_pckmo", MSA_EXT_9_PCKMO, "Message-security-assist-extension 9 PCKMO subfunctions"),
     FEAT_GROUP_INIT("mepochptff", MULTIPLE_EPOCH_PTFF, "PTFF enhancements introduced with Multiple-epoch facility"),
 };
 
diff --git a/target/s390x/cpu_features.h b/target/s390x/cpu_features.h
index effe790271..5ffd3db083 100644
--- a/target/s390x/cpu_features.h
+++ b/target/s390x/cpu_features.h
@@ -39,6 +39,7 @@ typedef enum {
     S390_FEAT_TYPE_PCC,
     S390_FEAT_TYPE_PPNO,
     S390_FEAT_TYPE_KMA,
+    S390_FEAT_TYPE_KDSA,
 } S390FeatType;
 
 /* Definition of a CPU feature */
diff --git a/target/s390x/cpu_features_def.h b/target/s390x/cpu_features_def.h
index 31dd678301..030784811b 100644
--- a/target/s390x/cpu_features_def.h
+++ b/target/s390x/cpu_features_def.h
@@ -96,6 +96,7 @@ typedef enum {
     S390_FEAT_INSERT_REFERENCE_BITS_MULT,
     S390_FEAT_MSA_EXT_8,
     S390_FEAT_CMM_NT,
+    S390_FEAT_MSA_EXT_9,
     S390_FEAT_ETOKEN,
 
     /* Sclp Conf Char */
@@ -240,6 +241,11 @@ typedef enum {
     S390_FEAT_PCKMO_AES_128,
     S390_FEAT_PCKMO_AES_192,
     S390_FEAT_PCKMO_AES_256,
+    S390_FEAT_PCKMO_ECC_P256,
+    S390_FEAT_PCKMO_ECC_P384,
+    S390_FEAT_PCKMO_ECC_P521,
+    S390_FEAT_PCKMO_ECC_ED25519,
+    S390_FEAT_PCKMO_ECC_ED448,
 
     /* KMCTR */
     S390_FEAT_KMCTR_DEA,
@@ -300,6 +306,13 @@ typedef enum {
     S390_FEAT_PCC_XTS_AES_256,
     S390_FEAT_PCC_XTS_EAES_128,
     S390_FEAT_PCC_XTS_EAES_256,
+    S390_FEAT_PCC_SCALAR_MULT_P256,
+    S390_FEAT_PCC_SCALAR_MULT_P384,
+    S390_FEAT_PCC_SCALAR_MULT_P512,
+    S390_FEAT_PCC_SCALAR_MULT_ED25519,
+    S390_FEAT_PCC_SCALAR_MULT_ED448,
+    S390_FEAT_PCC_SCALAR_MULT_X25519,
+    S390_FEAT_PCC_SCALAR_MULT_X448,
 
     /* PPNO/PRNO */
     S390_FEAT_PPNO_SHA_512_DRNG,
@@ -313,6 +326,24 @@ typedef enum {
     S390_FEAT_KMA_GCM_EAES_128,
     S390_FEAT_KMA_GCM_EAES_192,
     S390_FEAT_KMA_GCM_EAES_256,
+
+    /* KDSA */
+    S390_FEAT_ECDSA_VERIFY_P256,
+    S390_FEAT_ECDSA_VERIFY_P384,
+    S390_FEAT_ECDSA_VERIFY_P512,
+    S390_FEAT_ECDSA_SIGN_P256,
+    S390_FEAT_ECDSA_SIGN_P384,
+    S390_FEAT_ECDSA_SIGN_P512,
+    S390_FEAT_EECDSA_SIGN_P256,
+    S390_FEAT_EECDSA_SIGN_P384,
+    S390_FEAT_EECDSA_SIGN_P512,
+    S390_FEAT_EDDSA_VERIFY_ED25519,
+    S390_FEAT_EDDSA_VERIFY_ED448,
+    S390_FEAT_EDDSA_SIGN_ED25519,
+    S390_FEAT_EDDSA_SIGN_ED448,
+    S390_FEAT_EEDDSA_SIGN_ED25519,
+    S390_FEAT_EEDDSA_SIGN_ED448,
+
     S390_FEAT_MAX,
 } S390Feat;
 
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index b4bb5de635..d683635eb5 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -782,6 +782,8 @@ static void check_consistency(const S390CPUModel *model)
         { S390_FEAT_SIE_CMMA, S390_FEAT_SIE_GSLS },
         { S390_FEAT_SIE_PFMFI, S390_FEAT_EDAT },
         { S390_FEAT_MSA_EXT_8, S390_FEAT_MSA_EXT_3 },
+        { S390_FEAT_MSA_EXT_9, S390_FEAT_MSA_EXT_3 },
+        { S390_FEAT_MSA_EXT_9, S390_FEAT_MSA_EXT_4 },
         { S390_FEAT_MULTIPLE_EPOCH, S390_FEAT_TOD_CLOCK_STEERING },
         { S390_FEAT_VECTOR_PACKED_DECIMAL, S390_FEAT_VECTOR },
         { S390_FEAT_VECTOR_ENH, S390_FEAT_VECTOR },
diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index e4739a6b9f..a2f9e2b43f 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -213,6 +213,38 @@
     S390_FEAT_KMA_GCM_EAES_192, \
     S390_FEAT_KMA_GCM_EAES_256
 
+#define S390_FEAT_GROUP_MSA_EXT_9 \
+    S390_FEAT_MSA_EXT_9, \
+    S390_FEAT_ECDSA_VERIFY_P256, \
+    S390_FEAT_ECDSA_VERIFY_P384, \
+    S390_FEAT_ECDSA_VERIFY_P512, \
+    S390_FEAT_ECDSA_SIGN_P256, \
+    S390_FEAT_ECDSA_SIGN_P384, \
+    S390_FEAT_ECDSA_SIGN_P512, \
+    S390_FEAT_EECDSA_SIGN_P256, \
+    S390_FEAT_EECDSA_SIGN_P384, \
+    S390_FEAT_EECDSA_SIGN_P512, \
+    S390_FEAT_EDDSA_VERIFY_ED25519, \
+    S390_FEAT_EDDSA_VERIFY_ED448, \
+    S390_FEAT_EDDSA_SIGN_ED25519, \
+    S390_FEAT_EDDSA_SIGN_ED448, \
+    S390_FEAT_EEDDSA_SIGN_ED25519, \
+    S390_FEAT_EEDDSA_SIGN_ED448, \
+    S390_FEAT_PCC_SCALAR_MULT_P256, \
+    S390_FEAT_PCC_SCALAR_MULT_P384, \
+    S390_FEAT_PCC_SCALAR_MULT_P512, \
+    S390_FEAT_PCC_SCALAR_MULT_ED25519, \
+    S390_FEAT_PCC_SCALAR_MULT_ED448, \
+    S390_FEAT_PCC_SCALAR_MULT_X25519, \
+    S390_FEAT_PCC_SCALAR_MULT_X448
+
+#define S390_FEAT_GROUP_MSA_EXT_9_PCKMO \
+    S390_FEAT_PCKMO_ECC_P256, \
+    S390_FEAT_PCKMO_ECC_P384, \
+    S390_FEAT_PCKMO_ECC_P521, \
+    S390_FEAT_PCKMO_ECC_ED25519, \
+    S390_FEAT_PCKMO_ECC_ED448
+
 /* cpu feature groups */
 static uint16_t group_PLO[] = {
     S390_FEAT_GROUP_PLO,
@@ -254,6 +286,14 @@ static uint16_t group_MSA_EXT_8[] = {
     S390_FEAT_GROUP_MSA_EXT_8,
 };
 
+static uint16_t group_MSA_EXT_9[] = {
+    S390_FEAT_GROUP_MSA_EXT_9,
+};
+
+static uint16_t group_MSA_EXT_9_PCKMO[] = {
+    S390_FEAT_GROUP_MSA_EXT_9_PCKMO,
+};
+
 /* Base features (in order of release)
  * Only non-hypervisor managed features belong here.
  * Base feature sets are static meaning they do not change in future QEMU
@@ -709,6 +749,8 @@ static FeatGroupDefSpec FeatGroupDef[] = {
     FEAT_GROUP_INITIALIZER(MSA_EXT_6),
     FEAT_GROUP_INITIALIZER(MSA_EXT_7),
     FEAT_GROUP_INITIALIZER(MSA_EXT_8),
+    FEAT_GROUP_INITIALIZER(MSA_EXT_9),
+    FEAT_GROUP_INITIALIZER(MSA_EXT_9_PCKMO),
     FEAT_GROUP_INITIALIZER(MULTIPLE_EPOCH_PTFF),
 };
 
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 7df7be4a1b..de0b984b68 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -2073,6 +2073,9 @@ static int query_cpu_subfunc(S390FeatBitmap features)
     if (test_bit(S390_FEAT_MSA_EXT_8, features)) {
         s390_add_from_feat_block(features, S390_FEAT_TYPE_KMA, prop.kma);
     }
+    if (test_bit(S390_FEAT_MSA_EXT_9, features)) {
+        s390_add_from_feat_block(features, S390_FEAT_TYPE_KDSA, prop.kdsa);
+    }
     return 0;
 }
 
@@ -2117,6 +2120,9 @@ static int configure_cpu_subfunc(const S390FeatBitmap features)
     if (test_bit(S390_FEAT_MSA_EXT_8, features)) {
         s390_fill_feat_block(features, S390_FEAT_TYPE_KMA, prop.kma);
     }
+    if (test_bit(S390_FEAT_MSA_EXT_9, features)) {
+        s390_fill_feat_block(features, S390_FEAT_TYPE_KDSA, prop.kdsa);
+    }
     return kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, &attr);
 }
 
-- 
2.17.1


