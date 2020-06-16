Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0ECEC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 20:58:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4CC7207DD
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 20:58:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4CC7207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlIf5-0004z4-2b
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 16:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33708)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.vnet.ibm.com>)
 id 1jlIeC-0003fU-N4
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 16:57:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:62062
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.vnet.ibm.com>)
 id 1jlIeA-0003Dx-Ok
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 16:57:32 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05GKq0IW013479
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 16:57:28 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 31ptqkxdvx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 16:57:28 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05GKvBva033145
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 16:57:28 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0b-001b2d01.pphosted.com with ESMTP id 31ptqkxdvk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jun 2020 16:57:28 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05GKsC56023489;
 Tue, 16 Jun 2020 20:57:27 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by ppma01dal.us.ibm.com with ESMTP id 31q26faaep-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jun 2020 20:57:27 +0000
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 05GKvQ9W51446018
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Jun 2020 20:57:26 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 11F36C605B;
 Tue, 16 Jun 2020 20:57:26 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 58B04C6057;
 Tue, 16 Jun 2020 20:57:25 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
 Tue, 16 Jun 2020 20:57:25 +0000 (GMT)
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/8] tpm: Extend TPMIfClass with get_irqnum() function
Date: Tue, 16 Jun 2020 16:57:15 -0400
Message-Id: <20200616205721.1191408-3-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200616205721.1191408-1-stefanb@linux.vnet.ibm.com>
References: <20200616205721.1191408-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-16_12:2020-06-16,
 2020-06-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0
 cotscore=-2147483648 suspectscore=1 phishscore=0 priorityscore=1501
 mlxlogscore=999 spamscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 mlxscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006160140
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=stefanb@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 16:57:26
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Stefan Berger <stefanb@sbct-2.pok.ibm.com>, eric.auger@redhat.com,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, philmd@redhat.com,
 mkedzier@redhat.com, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Berger <stefanb@sbct-2.pok.ibm.com>

Implement get_irqnum() as part of the TPMIfClass to get the assigned IRQ
number or TPM_IRQ_DISABLED (-1) in case IRQs cannot be used.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 hw/tpm/tpm_tis_isa.c    |  9 +++++++++
 hw/tpm/tpm_tis_sysbus.c |  9 +++++++++
 include/sysemu/tpm.h    | 12 ++++++++++++
 3 files changed, 30 insertions(+)

diff --git a/hw/tpm/tpm_tis_isa.c b/hw/tpm/tpm_tis_isa.c
index 30ba37079d..ed6d422f05 100644
--- a/hw/tpm/tpm_tis_isa.c
+++ b/hw/tpm/tpm_tis_isa.c
@@ -80,6 +80,14 @@ static enum TPMVersion tpm_tis_isa_get_tpm_version(TPMIf *ti)
     return tpm_tis_get_tpm_version(s);
 }
 
+static int8_t tpm_tis_isa_get_irqnum(TPMIf *ti)
+{
+    TPMStateISA *isadev = TPM_TIS_ISA(ti);
+    TPMState *s = &isadev->state;
+
+    return s->irq_num;
+}
+
 static void tpm_tis_isa_reset(DeviceState *dev)
 {
     TPMStateISA *isadev = TPM_TIS_ISA(dev);
@@ -148,6 +156,7 @@ static void tpm_tis_isa_class_init(ObjectClass *klass, void *data)
     dc->reset = tpm_tis_isa_reset;
     tc->request_completed = tpm_tis_isa_request_completed;
     tc->get_version = tpm_tis_isa_get_tpm_version;
+    tc->get_irqnum = tpm_tis_isa_get_irqnum;
 }
 
 static const TypeInfo tpm_tis_isa_info = {
diff --git a/hw/tpm/tpm_tis_sysbus.c b/hw/tpm/tpm_tis_sysbus.c
index eced1fc843..86b3988be5 100644
--- a/hw/tpm/tpm_tis_sysbus.c
+++ b/hw/tpm/tpm_tis_sysbus.c
@@ -80,6 +80,14 @@ static enum TPMVersion tpm_tis_sysbus_get_tpm_version(TPMIf *ti)
     return tpm_tis_get_tpm_version(s);
 }
 
+static int8_t tpm_tis_sysbus_get_irqnum(TPMIf *ti)
+{
+    TPMStateSysBus *sbdev = TPM_TIS_SYSBUS(ti);
+    TPMState *s = &sbdev->state;
+
+    return s->irq_num;
+}
+
 static void tpm_tis_sysbus_reset(DeviceState *dev)
 {
     TPMStateSysBus *sbdev = TPM_TIS_SYSBUS(dev);
@@ -137,6 +145,7 @@ static void tpm_tis_sysbus_class_init(ObjectClass *klass, void *data)
     dc->reset = tpm_tis_sysbus_reset;
     tc->request_completed = tpm_tis_sysbus_request_completed;
     tc->get_version = tpm_tis_sysbus_get_tpm_version;
+    tc->get_irqnum = tpm_tis_sysbus_get_irqnum;
 }
 
 static const TypeInfo tpm_tis_sysbus_info = {
diff --git a/include/sysemu/tpm.h b/include/sysemu/tpm.h
index 03fb25941c..a81fb4e18e 100644
--- a/include/sysemu/tpm.h
+++ b/include/sysemu/tpm.h
@@ -25,6 +25,8 @@ typedef enum TPMVersion {
     TPM_VERSION_2_0 = 2,
 } TPMVersion;
 
+#define TPM_IRQ_DISABLED  -1
+
 #define TYPE_TPM_IF "tpm-if"
 #define TPM_IF_CLASS(klass)                                 \
     OBJECT_CLASS_CHECK(TPMIfClass, (klass), TYPE_TPM_IF)
@@ -41,6 +43,7 @@ typedef struct TPMIfClass {
     enum TpmModel model;
     void (*request_completed)(TPMIf *obj, int ret);
     enum TPMVersion (*get_version)(TPMIf *obj);
+    int8_t (*get_irqnum)(TPMIf *obj);
 } TPMIfClass;
 
 #define TYPE_TPM_TIS_ISA            "tpm-tis"
@@ -74,4 +77,13 @@ static inline TPMVersion tpm_get_version(TPMIf *ti)
     return TPM_IF_GET_CLASS(ti)->get_version(ti);
 }
 
+static inline int8_t tpm_get_irqnum(TPMIf *ti)
+{
+    if (!ti || !TPM_IF_GET_CLASS(ti)->get_irqnum) {
+        return TPM_IRQ_DISABLED;
+    }
+
+    return TPM_IF_GET_CLASS(ti)->get_irqnum(ti);
+}
+
 #endif /* QEMU_TPM_H */
-- 
2.24.1


