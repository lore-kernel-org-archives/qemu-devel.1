Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0980C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 20:59:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94770207DD
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 20:59:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94770207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlIg6-0007HD-Ty
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 16:59:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33894)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.vnet.ibm.com>)
 id 1jlIfB-0005e6-8K
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 16:58:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64940)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.vnet.ibm.com>)
 id 1jlIf9-0003JA-Is
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 16:58:32 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05GKmBSK085859
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 16:58:30 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31q4wcs35v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 16:58:30 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05GKuHSW118478
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 16:58:29 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31q4wcs35j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jun 2020 16:58:29 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05GKt6Hg025367;
 Tue, 16 Jun 2020 20:58:29 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by ppma02dal.us.ibm.com with ESMTP id 31q2qv1v9b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jun 2020 20:58:29 +0000
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 05GKvQTM32768306
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Jun 2020 20:57:26 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E34CDC605B;
 Tue, 16 Jun 2020 20:57:27 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 387D9C6057;
 Tue, 16 Jun 2020 20:57:27 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
 Tue, 16 Jun 2020 20:57:27 +0000 (GMT)
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 4/8] tpm: Split TPM_TIS_IRQ into TPM_TIS_ISA_IRQ and
 TPM_TIS_SYSBUS_IRQ
Date: Tue, 16 Jun 2020 16:57:17 -0400
Message-Id: <20200616205721.1191408-5-stefanb@linux.vnet.ibm.com>
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
 mlxscore=0 phishscore=0
 clxscore=1015 cotscore=-2147483648 malwarescore=0 priorityscore=1501
 spamscore=0 suspectscore=1 adultscore=0 mlxlogscore=995 bulkscore=0
 lowpriorityscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006160140
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=stefanb@linux.vnet.ibm.com; helo=mx0b-001b2d01.pphosted.com
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
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>, eric.auger@redhat.com,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, philmd@redhat.com,
 mkedzier@redhat.com, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Before the enablement of interrupts on PCs, split the TPM_TIS_IRQ
into TPM_TIS_ISA_IRQ for PCs and TPM_TIS_SYSBUS_IRQ for ARM.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 hw/tpm/tpm_tis_isa.c    | 2 +-
 hw/tpm/tpm_tis_sysbus.c | 3 ++-
 include/hw/acpi/tpm.h   | 3 ++-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/tpm/tpm_tis_isa.c b/hw/tpm/tpm_tis_isa.c
index ed6d422f05..27222a9a49 100644
--- a/hw/tpm/tpm_tis_isa.c
+++ b/hw/tpm/tpm_tis_isa.c
@@ -97,7 +97,7 @@ static void tpm_tis_isa_reset(DeviceState *dev)
 }
 
 static Property tpm_tis_isa_properties[] = {
-    DEFINE_PROP_UINT32("irq", TPMStateISA, state.irq_num, TPM_TIS_IRQ),
+    DEFINE_PROP_UINT32("irq", TPMStateISA, state.irq_num, TPM_TIS_ISA_IRQ),
     DEFINE_PROP_TPMBE("tpmdev", TPMStateISA, state.be_driver),
     DEFINE_PROP_BOOL("ppi", TPMStateISA, state.ppi_enabled, true),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/tpm/tpm_tis_sysbus.c b/hw/tpm/tpm_tis_sysbus.c
index 86b3988be5..bf4583c3f6 100644
--- a/hw/tpm/tpm_tis_sysbus.c
+++ b/hw/tpm/tpm_tis_sysbus.c
@@ -97,7 +97,8 @@ static void tpm_tis_sysbus_reset(DeviceState *dev)
 }
 
 static Property tpm_tis_sysbus_properties[] = {
-    DEFINE_PROP_UINT32("irq", TPMStateSysBus, state.irq_num, TPM_TIS_IRQ),
+    DEFINE_PROP_UINT32("irq", TPMStateSysBus, state.irq_num,
+                       TPM_TIS_SYSBUS_IRQ),
     DEFINE_PROP_TPMBE("tpmdev", TPMStateSysBus, state.be_driver),
     DEFINE_PROP_BOOL("ppi", TPMStateSysBus, state.ppi_enabled, false),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/include/hw/acpi/tpm.h b/include/hw/acpi/tpm.h
index 1a2a57a21f..d5caee9771 100644
--- a/include/hw/acpi/tpm.h
+++ b/include/hw/acpi/tpm.h
@@ -24,7 +24,8 @@
 #define TPM_TIS_ADDR_BASE           0xFED40000
 #define TPM_TIS_ADDR_SIZE           0x5000
 
-#define TPM_TIS_IRQ                 5
+#define TPM_TIS_ISA_IRQ             5
+#define TPM_TIS_SYSBUS_IRQ          5
 
 #define TPM_TIS_NUM_LOCALITIES      5     /* per spec */
 #define TPM_TIS_LOCALITY_SHIFT      12
-- 
2.24.1


