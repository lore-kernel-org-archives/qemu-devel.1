Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A14A0C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 13:25:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BEE720702
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 13:25:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BEE720702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joRt1-00072l-Jm
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 09:25:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59414)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.vnet.ibm.com>)
 id 1joRqq-0002l1-CB
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 09:23:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:26372
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.vnet.ibm.com>)
 id 1joRqo-0002zP-Hd
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 09:23:36 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05PD44i0193282; Thu, 25 Jun 2020 09:23:33 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 31uwymr9yu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Jun 2020 09:23:33 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05PDCIim017565;
 Thu, 25 Jun 2020 09:23:33 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.26])
 by mx0b-001b2d01.pphosted.com with ESMTP id 31uwymr9yj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Jun 2020 09:23:33 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
 by ppma04wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05PDKC8o020943;
 Thu, 25 Jun 2020 13:23:32 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by ppma04wdc.us.ibm.com with ESMTP id 31uuryc7g3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Jun 2020 13:23:32 +0000
Received: from b03ledav001.gho.boulder.ibm.com
 (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 05PDNT0n23986514
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Jun 2020 13:23:29 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 59EF56E04E;
 Thu, 25 Jun 2020 13:23:31 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B4D396E04C;
 Thu, 25 Jun 2020 13:23:30 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
 Thu, 25 Jun 2020 13:23:30 +0000 (GMT)
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PULL v1 5/8] acpi: Enable TPM IRQ
Date: Thu, 25 Jun 2020 09:23:22 -0400
Message-Id: <20200625132325.2025245-6-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200625132325.2025245-1-stefanb@linux.vnet.ibm.com>
References: <20200625132325.2025245-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-25_08:2020-06-25,
 2020-06-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015
 bulkscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 suspectscore=1 impostorscore=0 cotscore=-2147483648 adultscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006250083
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=stefanb@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 08:13:37
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
Cc: peter.maydell@linaro.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Berger <stefanb@linux.ibm.com>

Move the TPM TIS IRQ to unused IRQ 13, which is the only one accepted by
Windows. Query for the TPM's irq number and enable the TPM IRQ unless
TPM_IRQ_DISABLED is returned.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Message-id: 20200617142305.1198672-6-stefanb@linux.vnet.ibm.com
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
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


