Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875EDC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 04:34:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48A2E2146E
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 04:34:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48A2E2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihR30-0001ms-H3
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 23:34:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56660)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bharata@linux.ibm.com>) id 1ihR0l-0007Yu-Ia
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 23:32:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bharata@linux.ibm.com>) id 1ihR0i-0007mT-1T
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 23:32:34 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32278)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <bharata@linux.ibm.com>)
 id 1ihR0g-0007g9-66
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 23:32:31 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xBI4WK7B016491
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 23:32:26 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wyappky3e-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 23:32:26 -0500
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <bharata@linux.ibm.com>;
 Wed, 18 Dec 2019 04:32:23 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 18 Dec 2019 04:32:21 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xBI4WKuh53739754
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Dec 2019 04:32:20 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4FF9852050;
 Wed, 18 Dec 2019 04:32:20 +0000 (GMT)
Received: from bharata.ibmuc.com (unknown [9.85.89.92])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 21B5252051;
 Wed, 18 Dec 2019 04:32:18 +0000 (GMT)
From: Bharata B Rao <bharata@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 ppc-for-5.0 1/2] linux-headers: Update
Date: Wed, 18 Dec 2019 10:02:07 +0530
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191218043208.28613-1-bharata@linux.ibm.com>
References: <20191218043208.28613-1-bharata@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19121804-0012-0000-0000-0000037606F0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19121804-0013-0000-0000-000021B1F3DB
Message-Id: <20191218043208.28613-2-bharata@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-17_05:2019-12-17,2019-12-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 clxscore=1015 adultscore=0 mlxscore=0
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912180034
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 148.163.156.1
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
Cc: paulus@ozlabs.org, linuxram@us.ibm.com,
 Bharata B Rao <bharata@linux.ibm.com>, qemu-ppc@nongnu.org,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Update to mainline commit: d1eef1c61974 ("Linux 5.5-rc2")

Signed-off-by: Bharata B Rao <bharata@linux.ibm.com>
---
 include/standard-headers/asm-x86/bootparam.h  |  7 +-
 .../infiniband/hw/vmw_pvrdma/pvrdma_dev_api.h | 15 +++-
 include/standard-headers/drm/drm_fourcc.h     | 28 ++++++-
 .../linux/input-event-codes.h                 | 77 +++++++++++++++++++
 include/standard-headers/linux/pci_regs.h     |  3 +
 .../standard-headers/rdma/vmw_pvrdma-abi.h    |  5 ++
 linux-headers/linux/kvm.h                     |  1 +
 7 files changed, 132 insertions(+), 4 deletions(-)

diff --git a/include/standard-headers/asm-x86/bootparam.h b/include/standard-headers/asm-x86/bootparam.h
index a6f7cf535e..072e2ed546 100644
--- a/include/standard-headers/asm-x86/bootparam.h
+++ b/include/standard-headers/asm-x86/bootparam.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_X86_BOOTPARAM_H
 #define _ASM_X86_BOOTPARAM_H
 
-/* setup_data types */
+/* setup_data/setup_indirect types */
 #define SETUP_NONE			0
 #define SETUP_E820_EXT			1
 #define SETUP_DTB			2
@@ -11,6 +11,11 @@
 #define SETUP_APPLE_PROPERTIES		5
 #define SETUP_JAILHOUSE			6
 
+#define SETUP_INDIRECT			(1<<31)
+
+/* SETUP_INDIRECT | max(SETUP_*) */
+#define SETUP_TYPE_MAX			(SETUP_INDIRECT | SETUP_JAILHOUSE)
+
 /* ram_size flags */
 #define RAMDISK_IMAGE_START_MASK	0x07FF
 #define RAMDISK_PROMPT_FLAG		0x8000
diff --git a/include/standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_dev_api.h b/include/standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_dev_api.h
index d019872608..a5a1c8234e 100644
--- a/include/standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_dev_api.h
+++ b/include/standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_dev_api.h
@@ -58,7 +58,8 @@
 #define PVRDMA_ROCEV1_VERSION		17
 #define PVRDMA_ROCEV2_VERSION		18
 #define PVRDMA_PPN64_VERSION		19
-#define PVRDMA_VERSION			PVRDMA_PPN64_VERSION
+#define PVRDMA_QPHANDLE_VERSION		20
+#define PVRDMA_VERSION			PVRDMA_QPHANDLE_VERSION
 
 #define PVRDMA_BOARD_ID			1
 #define PVRDMA_REV_ID			1
@@ -581,6 +582,17 @@ struct pvrdma_cmd_create_qp_resp {
 	uint32_t max_inline_data;
 };
 
+struct pvrdma_cmd_create_qp_resp_v2 {
+	struct pvrdma_cmd_resp_hdr hdr;
+	uint32_t qpn;
+	uint32_t qp_handle;
+	uint32_t max_send_wr;
+	uint32_t max_recv_wr;
+	uint32_t max_send_sge;
+	uint32_t max_recv_sge;
+	uint32_t max_inline_data;
+};
+
 struct pvrdma_cmd_modify_qp {
 	struct pvrdma_cmd_hdr hdr;
 	uint32_t qp_handle;
@@ -663,6 +675,7 @@ union pvrdma_cmd_resp {
 	struct pvrdma_cmd_create_cq_resp create_cq_resp;
 	struct pvrdma_cmd_resize_cq_resp resize_cq_resp;
 	struct pvrdma_cmd_create_qp_resp create_qp_resp;
+	struct pvrdma_cmd_create_qp_resp_v2 create_qp_resp_v2;
 	struct pvrdma_cmd_query_qp_resp query_qp_resp;
 	struct pvrdma_cmd_destroy_qp_resp destroy_qp_resp;
 	struct pvrdma_cmd_create_srq_resp create_srq_resp;
diff --git a/include/standard-headers/drm/drm_fourcc.h b/include/standard-headers/drm/drm_fourcc.h
index a308c91b4f..46d279f515 100644
--- a/include/standard-headers/drm/drm_fourcc.h
+++ b/include/standard-headers/drm/drm_fourcc.h
@@ -68,7 +68,7 @@ extern "C" {
 #define fourcc_code(a, b, c, d) ((uint32_t)(a) | ((uint32_t)(b) << 8) | \
 				 ((uint32_t)(c) << 16) | ((uint32_t)(d) << 24))
 
-#define DRM_FORMAT_BIG_ENDIAN (1<<31) /* format is big endian instead of little endian */
+#define DRM_FORMAT_BIG_ENDIAN (1U<<31) /* format is big endian instead of little endian */
 
 /* Reserve 0 for the invalid format specifier */
 #define DRM_FORMAT_INVALID	0
@@ -647,7 +647,21 @@ extern "C" {
  * Further information on the use of AFBC modifiers can be found in
  * Documentation/gpu/afbc.rst
  */
-#define DRM_FORMAT_MOD_ARM_AFBC(__afbc_mode)	fourcc_mod_code(ARM, __afbc_mode)
+
+/*
+ * The top 4 bits (out of the 56 bits alloted for specifying vendor specific
+ * modifiers) denote the category for modifiers. Currently we have only two
+ * categories of modifiers ie AFBC and MISC. We can have a maximum of sixteen
+ * different categories.
+ */
+#define DRM_FORMAT_MOD_ARM_CODE(__type, __val) \
+	fourcc_mod_code(ARM, ((uint64_t)(__type) << 52) | ((__val) & 0x000fffffffffffffULL))
+
+#define DRM_FORMAT_MOD_ARM_TYPE_AFBC 0x00
+#define DRM_FORMAT_MOD_ARM_TYPE_MISC 0x01
+
+#define DRM_FORMAT_MOD_ARM_AFBC(__afbc_mode) \
+	DRM_FORMAT_MOD_ARM_CODE(DRM_FORMAT_MOD_ARM_TYPE_AFBC, __afbc_mode)
 
 /*
  * AFBC superblock size
@@ -741,6 +755,16 @@ extern "C" {
  */
 #define AFBC_FORMAT_MOD_BCH     (1ULL << 11)
 
+/*
+ * Arm 16x16 Block U-Interleaved modifier
+ *
+ * This is used by Arm Mali Utgard and Midgard GPUs. It divides the image
+ * into 16x16 pixel blocks. Blocks are stored linearly in order, but pixels
+ * in the block are reordered.
+ */
+#define DRM_FORMAT_MOD_ARM_16X16_BLOCK_U_INTERLEAVED \
+	DRM_FORMAT_MOD_ARM_CODE(DRM_FORMAT_MOD_ARM_TYPE_MISC, 1ULL)
+
 /*
  * Allwinner tiled modifier
  *
diff --git a/include/standard-headers/linux/input-event-codes.h b/include/standard-headers/linux/input-event-codes.h
index eb08cb8598..b484c25289 100644
--- a/include/standard-headers/linux/input-event-codes.h
+++ b/include/standard-headers/linux/input-event-codes.h
@@ -649,6 +649,83 @@
  */
 #define KEY_DATA			0x277
 #define KEY_ONSCREEN_KEYBOARD		0x278
+/* Electronic privacy screen control */
+#define KEY_PRIVACY_SCREEN_TOGGLE	0x279
+
+/*
+ * Some keyboards have keys which do not have a defined meaning, these keys
+ * are intended to be programmed / bound to macros by the user. For most
+ * keyboards with these macro-keys the key-sequence to inject, or action to
+ * take, is all handled by software on the host side. So from the kernel's
+ * point of view these are just normal keys.
+ *
+ * The KEY_MACRO# codes below are intended for such keys, which may be labeled
+ * e.g. G1-G18, or S1 - S30. The KEY_MACRO# codes MUST NOT be used for keys
+ * where the marking on the key does indicate a defined meaning / purpose.
+ *
+ * The KEY_MACRO# codes MUST also NOT be used as fallback for when no existing
+ * KEY_FOO define matches the marking / purpose. In this case a new KEY_FOO
+ * define MUST be added.
+ */
+#define KEY_MACRO1			0x290
+#define KEY_MACRO2			0x291
+#define KEY_MACRO3			0x292
+#define KEY_MACRO4			0x293
+#define KEY_MACRO5			0x294
+#define KEY_MACRO6			0x295
+#define KEY_MACRO7			0x296
+#define KEY_MACRO8			0x297
+#define KEY_MACRO9			0x298
+#define KEY_MACRO10			0x299
+#define KEY_MACRO11			0x29a
+#define KEY_MACRO12			0x29b
+#define KEY_MACRO13			0x29c
+#define KEY_MACRO14			0x29d
+#define KEY_MACRO15			0x29e
+#define KEY_MACRO16			0x29f
+#define KEY_MACRO17			0x2a0
+#define KEY_MACRO18			0x2a1
+#define KEY_MACRO19			0x2a2
+#define KEY_MACRO20			0x2a3
+#define KEY_MACRO21			0x2a4
+#define KEY_MACRO22			0x2a5
+#define KEY_MACRO23			0x2a6
+#define KEY_MACRO24			0x2a7
+#define KEY_MACRO25			0x2a8
+#define KEY_MACRO26			0x2a9
+#define KEY_MACRO27			0x2aa
+#define KEY_MACRO28			0x2ab
+#define KEY_MACRO29			0x2ac
+#define KEY_MACRO30			0x2ad
+
+/*
+ * Some keyboards with the macro-keys described above have some extra keys
+ * for controlling the host-side software responsible for the macro handling:
+ * -A macro recording start/stop key. Note that not all keyboards which emit
+ *  KEY_MACRO_RECORD_START will also emit KEY_MACRO_RECORD_STOP if
+ *  KEY_MACRO_RECORD_STOP is not advertised, then KEY_MACRO_RECORD_START
+ *  should be interpreted as a recording start/stop toggle;
+ * -Keys for switching between different macro (pre)sets, either a key for
+ *  cycling through the configured presets or keys to directly select a preset.
+ */
+#define KEY_MACRO_RECORD_START		0x2b0
+#define KEY_MACRO_RECORD_STOP		0x2b1
+#define KEY_MACRO_PRESET_CYCLE		0x2b2
+#define KEY_MACRO_PRESET1		0x2b3
+#define KEY_MACRO_PRESET2		0x2b4
+#define KEY_MACRO_PRESET3		0x2b5
+
+/*
+ * Some keyboards have a buildin LCD panel where the contents are controlled
+ * by the host. Often these have a number of keys directly below the LCD
+ * intended for controlling a menu shown on the LCD. These keys often don't
+ * have any labeling so we just name them KEY_KBD_LCD_MENU#
+ */
+#define KEY_KBD_LCD_MENU1		0x2b8
+#define KEY_KBD_LCD_MENU2		0x2b9
+#define KEY_KBD_LCD_MENU3		0x2ba
+#define KEY_KBD_LCD_MENU4		0x2bb
+#define KEY_KBD_LCD_MENU5		0x2bc
 
 #define BTN_TRIGGER_HAPPY		0x2c0
 #define BTN_TRIGGER_HAPPY1		0x2c0
diff --git a/include/standard-headers/linux/pci_regs.h b/include/standard-headers/linux/pci_regs.h
index 29d6e93fd1..acb7d2bdb4 100644
--- a/include/standard-headers/linux/pci_regs.h
+++ b/include/standard-headers/linux/pci_regs.h
@@ -34,6 +34,7 @@
  * of which the first 64 bytes are standardized as follows:
  */
 #define PCI_STD_HEADER_SIZEOF	64
+#define PCI_STD_NUM_BARS	6	/* Number of standard BARs */
 #define PCI_VENDOR_ID		0x00	/* 16 bits */
 #define PCI_DEVICE_ID		0x02	/* 16 bits */
 #define PCI_COMMAND		0x04	/* 16 bits */
@@ -673,6 +674,8 @@
 #define  PCI_EXP_LNKCTL2_TLS_8_0GT	0x0003 /* Supported Speed 8GT/s */
 #define  PCI_EXP_LNKCTL2_TLS_16_0GT	0x0004 /* Supported Speed 16GT/s */
 #define  PCI_EXP_LNKCTL2_TLS_32_0GT	0x0005 /* Supported Speed 32GT/s */
+#define  PCI_EXP_LNKCTL2_ENTER_COMP	0x0010 /* Enter Compliance */
+#define  PCI_EXP_LNKCTL2_TX_MARGIN	0x0380 /* Transmit Margin */
 #define PCI_EXP_LNKSTA2		50	/* Link Status 2 */
 #define PCI_CAP_EXP_ENDPOINT_SIZEOF_V2	52	/* v2 endpoints with link end here */
 #define PCI_EXP_SLTCAP2		52	/* Slot Capabilities 2 */
diff --git a/include/standard-headers/rdma/vmw_pvrdma-abi.h b/include/standard-headers/rdma/vmw_pvrdma-abi.h
index 336a8d596f..0989426a3f 100644
--- a/include/standard-headers/rdma/vmw_pvrdma-abi.h
+++ b/include/standard-headers/rdma/vmw_pvrdma-abi.h
@@ -179,6 +179,11 @@ struct pvrdma_create_qp {
 	uint64_t __attribute__((aligned(8))) qp_addr;
 };
 
+struct pvrdma_create_qp_resp {
+	uint32_t qpn;
+	uint32_t qp_handle;
+};
+
 /* PVRDMA masked atomic compare and swap */
 struct pvrdma_ex_cmp_swap {
 	uint64_t __attribute__((aligned(8))) swap_val;
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index 3b27a1ae85..9d647fad76 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -1348,6 +1348,7 @@ struct kvm_s390_ucas_mapping {
 #define KVM_PPC_GET_CPU_CHAR	  _IOR(KVMIO,  0xb1, struct kvm_ppc_cpu_char)
 /* Available with KVM_CAP_PMU_EVENT_FILTER */
 #define KVM_SET_PMU_EVENT_FILTER  _IOW(KVMIO,  0xb2, struct kvm_pmu_event_filter)
+#define KVM_PPC_SVM_OFF		  _IO(KVMIO,  0xb3)
 
 /* ioctl for vm fd */
 #define KVM_CREATE_DEVICE	  _IOWR(KVMIO,  0xe0, struct kvm_create_device)
-- 
2.21.0


