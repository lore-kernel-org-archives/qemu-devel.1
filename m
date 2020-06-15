Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1560AC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 14:24:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0321206B7
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 14:24:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0321206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkq2P-0000C0-3w
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 10:24:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48278)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.vnet.ibm.com>)
 id 1jkq1U-0007Mi-Af
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 10:23:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36256
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.vnet.ibm.com>)
 id 1jkq1S-0005JZ-O7
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 10:23:40 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05FE4jb1103245
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 10:23:37 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 31p8v5ux4s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 10:23:37 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05FE5CDA104179
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 10:23:37 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0b-001b2d01.pphosted.com with ESMTP id 31p8v5ux3w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jun 2020 10:23:37 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05FEKlbi010166;
 Mon, 15 Jun 2020 14:23:35 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by ppma04dal.us.ibm.com with ESMTP id 31mpe8wsyt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jun 2020 14:23:35 +0000
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 05FENWIJ10486168
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 15 Jun 2020 14:23:32 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B6BD2C6066;
 Mon, 15 Jun 2020 14:23:33 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2090AC6062;
 Mon, 15 Jun 2020 14:23:33 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
 Mon, 15 Jun 2020 14:23:32 +0000 (GMT)
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/5] tpm: Extend TPMIfClass with get_irqnum() function
Date: Mon, 15 Jun 2020 10:23:24 -0400
Message-Id: <20200615142327.671546-3-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200615142327.671546-1-stefanb@linux.vnet.ibm.com>
References: <20200615142327.671546-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-15_03:2020-06-15,
 2020-06-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 cotscore=-2147483648
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0 adultscore=0
 clxscore=1015 mlxlogscore=999 spamscore=0 mlxscore=0 malwarescore=0
 suspectscore=1 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006150111
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=stefanb@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 08:37:04
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

Implement get_irqnum() as part of the TPMIfClass to be get the assigned
IRQ number.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 hw/tpm/tpm_tis_isa.c    |  9 +++++++++
 hw/tpm/tpm_tis_sysbus.c |  9 +++++++++
 include/sysemu/tpm.h    | 10 ++++++++++
 3 files changed, 28 insertions(+)

diff --git a/hw/tpm/tpm_tis_isa.c b/hw/tpm/tpm_tis_isa.c
index 30ba37079d..63b62f4c21 100644
--- a/hw/tpm/tpm_tis_isa.c
+++ b/hw/tpm/tpm_tis_isa.c
@@ -80,6 +80,14 @@ static enum TPMVersion tpm_tis_isa_get_tpm_version(TPMIf *ti)
     return tpm_tis_get_tpm_version(s);
 }
 
+static uint8_t tpm_tis_isa_get_irqnum(TPMIf *ti)
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
index eced1fc843..6cf45e5057 100644
--- a/hw/tpm/tpm_tis_sysbus.c
+++ b/hw/tpm/tpm_tis_sysbus.c
@@ -80,6 +80,14 @@ static enum TPMVersion tpm_tis_sysbus_get_tpm_version(TPMIf *ti)
     return tpm_tis_get_tpm_version(s);
 }
 
+static uint8_t tpm_tis_sysbus_get_irqnum(TPMIf *ti)
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
index 03fb25941c..b94a8a2b16 100644
--- a/include/sysemu/tpm.h
+++ b/include/sysemu/tpm.h
@@ -41,6 +41,7 @@ typedef struct TPMIfClass {
     enum TpmModel model;
     void (*request_completed)(TPMIf *obj, int ret);
     enum TPMVersion (*get_version)(TPMIf *obj);
+    uint8_t (*get_irqnum)(TPMIf *obj);
 } TPMIfClass;
 
 #define TYPE_TPM_TIS_ISA            "tpm-tis"
@@ -74,4 +75,13 @@ static inline TPMVersion tpm_get_version(TPMIf *ti)
     return TPM_IF_GET_CLASS(ti)->get_version(ti);
 }
 
+static inline uint8_t tpm_get_irqnum(TPMIf *ti)
+{
+    if (!ti || !TPM_IF_GET_CLASS(ti)->get_irqnum) {
+        return 0;
+    }
+
+    return TPM_IF_GET_CLASS(ti)->get_irqnum(ti);
+}
+
 #endif /* QEMU_TPM_H */
-- 
2.24.1


