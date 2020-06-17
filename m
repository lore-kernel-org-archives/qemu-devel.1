Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9331C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 14:29:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC86F2083B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 14:29:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC86F2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlZ4T-0003VG-UB
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 10:29:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.vnet.ibm.com>)
 id 1jlYzC-0003wr-Aw
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 10:24:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3278)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.vnet.ibm.com>)
 id 1jlYzA-0005ZC-Hw
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 10:24:18 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05HE2VQY175489
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 10:24:15 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31q6hk18a9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 10:24:15 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05HEGI3d026493
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 10:24:14 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31q6hk189u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jun 2020 10:24:14 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05HEExSj029901;
 Wed, 17 Jun 2020 14:24:13 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by ppma03dal.us.ibm.com with ESMTP id 31q6c5ke1w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jun 2020 14:24:13 +0000
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 05HENCXQ44564744
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jun 2020 14:23:12 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4B2FD7805F;
 Wed, 17 Jun 2020 14:23:12 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 90F1E7805C;
 Wed, 17 Jun 2020 14:23:11 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed, 17 Jun 2020 14:23:11 +0000 (GMT)
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 5/8] acpi: Enable TPM IRQ
Date: Wed, 17 Jun 2020 10:23:02 -0400
Message-Id: <20200617142305.1198672-6-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200617142305.1198672-1-stefanb@linux.vnet.ibm.com>
References: <20200617142305.1198672-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-17_04:2020-06-17,
 2020-06-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=1 spamscore=0 phishscore=0 impostorscore=0
 cotscore=-2147483648 priorityscore=1501 clxscore=1015 malwarescore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006170105
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=stefanb@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 10:23:11
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
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
Cc: "Michael S . Tsirkin" <mst@redhat.com>, eric.auger@redhat.com,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, philmd@redhat.com,
 mkedzier@redhat.com, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Berger <stefanb@linux.ibm.com>

Move the TPM TIS IRQ to unused IRQ 13, which is the only one accepted by
Windows. Query for the TPM's irq number and enable the TPM IRQ unless
TPM_IRQ_DISABLED is returned.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-id: 20200616205721.1191408-6-stefanb@linux.vnet.ibm.com
CC: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/acpi-build.c  | 11 +++++------
 include/hw/acpi/tpm.h |  2 +-
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 900f786d08..bb9a7f8497 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2021,6 +2021,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
             build_append_pci_bus_devices(scope, bus, pm->pcihp_bridge_en);
 
             if (TPM_IS_TIS_ISA(tpm)) {
+                int8_t irq = tpm_get_irqnum(tpm);
                 if (misc->tpm_version == TPM_VERSION_2_0) {
                     dev = aml_device("TPM");
                     aml_append(dev, aml_name_decl("_HID",
@@ -2035,12 +2036,10 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
                 crs = aml_resource_template();
                 aml_append(crs, aml_memory32_fixed(TPM_TIS_ADDR_BASE,
                            TPM_TIS_ADDR_SIZE, AML_READ_WRITE));
-                /*
-                    FIXME: TPM_TIS_IRQ=5 conflicts with PNP0C0F irqs,
-                    Rewrite to take IRQ from TPM device model and
-                    fix default IRQ value there to use some unused IRQ
-                 */
-                /* aml_append(crs, aml_irq_no_flags(TPM_TIS_IRQ)); */
+
+                if (irq != TPM_IRQ_DISABLED) {
+                    aml_append(crs, aml_irq_no_flags(irq));
+                }
                 aml_append(dev, aml_name_decl("_CRS", crs));
 
                 tpm_build_ppi_acpi(tpm, dev);
diff --git a/include/hw/acpi/tpm.h b/include/hw/acpi/tpm.h
index d5caee9771..d356f2e06e 100644
--- a/include/hw/acpi/tpm.h
+++ b/include/hw/acpi/tpm.h
@@ -24,7 +24,7 @@
 #define TPM_TIS_ADDR_BASE           0xFED40000
 #define TPM_TIS_ADDR_SIZE           0x5000
 
-#define TPM_TIS_ISA_IRQ             5
+#define TPM_TIS_ISA_IRQ             13    /* only one possible */
 #define TPM_TIS_SYSBUS_IRQ          5
 
 #define TPM_TIS_NUM_LOCALITIES      5     /* per spec */
-- 
2.24.1


