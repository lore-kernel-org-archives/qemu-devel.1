Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC15C10F0E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 11:38:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51CF2217FA
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 11:38:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51CF2217FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39893 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hH5NU-0008BB-Iv
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 07:38:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1hH5GJ-0002mC-Es
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 07:31:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1hH5GF-0004XK-UV
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 07:31:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45196
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1hH5GF-0004Om-FF
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 07:31:23 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x3IBTTh3033227
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 07:31:18 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rxq86368w-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 07:31:17 -0400
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 18 Apr 2019 12:31:15 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
	by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Thu, 18 Apr 2019 12:31:13 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
	[9.149.105.60])
	by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x3IBVC0x46465146
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Thu, 18 Apr 2019 11:31:12 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 210EA4204D;
	Thu, 18 Apr 2019 11:31:12 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0CF9D42045;
	Thu, 18 Apr 2019 11:31:12 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
	Thu, 18 Apr 2019 11:31:12 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 25651)
	id B2B2920F639; Thu, 18 Apr 2019 13:31:11 +0200 (CEST)
From: Christian Borntraeger <borntraeger@de.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>
Date: Thu, 18 Apr 2019 13:31:02 +0200
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190418113110.160664-1-borntraeger@de.ibm.com>
References: <20190418113110.160664-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19041811-0016-0000-0000-0000027035EA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041811-0017-0000-0000-000032CC8CE9
Message-Id: <20190418113110.160664-3-borntraeger@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-04-18_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1904180082
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: [Qemu-devel] [PATCH 02/10] s390x/cpumodel: remove CSSKE from base
 model
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
	Halil Pasic <pasic@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	qemu-s390x <qemu-s390x@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190418113102.KrdmCiawYvLVeYdg0TFhzse364yfh4WCP5gWQHnKHmA@z>

conditional sske is deprecated and a distant future machine (will be one
where the IBC will not allow to fully go back to z14) will remove this
feature. To prepare for this and allow for the z14 and older cpu model
to still run on systems without csske, remove csske from the base (and
thus the default models for z10..z14). For compat machines we have to
add those back.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 hw/s390x/s390-virtio-ccw.c  |  2 ++
 target/s390x/cpu_models.c   | 21 +++++++++++++++++++++
 target/s390x/cpu_models.h   |  1 +
 target/s390x/gen-features.c |  1 -
 4 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index d11069b860..3415948b2c 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -648,6 +648,8 @@ bool css_migration_enabled(void)
 
 static void ccw_machine_4_0_instance_options(MachineState *machine)
 {
+    /* re-enable csske for compat machines in the base model */
+    s390_cpumodel_fixup_csske();
 }
 
 static void ccw_machine_4_0_class_options(MachineClass *mc)
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index eb125d4d0d..4e5aa879f3 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -93,6 +93,27 @@ static S390FeatBitmap qemu_max_cpu_feat;
 /* features part of a base model but not relevant for finding a base model */
 S390FeatBitmap ignored_base_feat;
 
+/*
+ * We removed CSSKE from the base features. This is a hook for compat machines
+ * to put this back for gen10..gen14. As the base model is also part of the
+ * default model to have to fixup both bitfields
+ */
+void s390_cpumodel_fixup_csske(void)
+{
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(s390_cpu_defs); i++) {
+        const S390CPUDef *def = &s390_cpu_defs[i];
+
+        if (def->gen < 10 || def->gen > 14) {
+            continue;
+        }
+
+        set_bit(S390_FEAT_CONDITIONAL_SSKE, (unsigned long *)&def->base_feat);
+        set_bit(S390_FEAT_CONDITIONAL_SSKE, (unsigned long *)&def->default_feat);
+    }
+}
+
 void s390_cpudef_featoff(uint8_t gen, uint8_t ec_ga, S390Feat feat)
 {
     const S390CPUDef *def;
diff --git a/target/s390x/cpu_models.h b/target/s390x/cpu_models.h
index 174a99e561..b2e37bc8cf 100644
--- a/target/s390x/cpu_models.h
+++ b/target/s390x/cpu_models.h
@@ -73,6 +73,7 @@ struct S390CPUModel {
 #define ibc_gen(x)        (x == 0 ? 0 : ((x >> 4) + S390_GEN_Z10))
 #define ibc_ec_ga(x)      (x & 0xf)
 
+void s390_cpumodel_fixup_csske(void);
 void s390_cpudef_featoff(uint8_t gen, uint8_t ec_ga, S390Feat feat);
 void s390_cpudef_featoff_greater(uint8_t gen, uint8_t ec_ga, S390Feat feat);
 void s390_cpudef_group_featoff_greater(uint8_t gen, uint8_t ec_ga,
diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index e4739a6b9f..bea2f80c49 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -301,7 +301,6 @@ static uint16_t base_GEN9_GA1[] = {
 #define base_GEN9_GA3 EmptyFeat
 
 static uint16_t base_GEN10_GA1[] = {
-    S390_FEAT_CONDITIONAL_SSKE,
     S390_FEAT_PARSING_ENH,
     S390_FEAT_MOVE_WITH_OPTIONAL_SPEC,
     S390_FEAT_EXTRACT_CPU_TIME,
-- 
2.19.1


