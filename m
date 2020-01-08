Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D3F9C00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 05:30:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEF5420705
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 05:30:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="EqK9/tD1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEF5420705
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip3uy-00050E-6c
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 00:30:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47519)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ip3ob-0003rj-Du
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 00:23:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ip3oY-0002gz-Ra
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 00:23:33 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:44117 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ip3oY-0002dN-E0; Wed, 08 Jan 2020 00:23:30 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47syMB1lrZz9sRs; Wed,  8 Jan 2020 16:23:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1578460998;
 bh=wvmmCejjwLYNoz6F2LRrWGMGLlrhnilquUTgCO2HW8A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=EqK9/tD1qJWDbu05Mtdw2ldRl6wTyR7bqvz+S1Ly59q1QkmI9zXM8ckHNli4usgyF
 U06gPznTRrTVuIgZaYMHiINQGBmcksuu3CSeviUvSdYcQA80TnPETzwkJ6lFGTlq35
 fe482EJEoqz72m2euqj7QdxnMjojoB1U1mmokqds=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 03/26] linux-headers: Update
Date: Wed,  8 Jan 2020 16:22:49 +1100
Message-Id: <20200108052312.238710-4-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200108052312.238710-1-david@gibson.dropbear.id.au>
References: <20200108052312.238710-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: lvivier@redhat.com, qemu-devel@nongnu.org,
 Bharata B Rao <bharata@linux.ibm.com>, groug@kaod.org, qemu-ppc@nongnu.org,
 clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bharata B Rao <bharata@linux.ibm.com>

Update to mainline commit: d1eef1c61974 ("Linux 5.5-rc2")

Signed-off-by: Bharata B Rao <bharata@linux.ibm.com>
Message-Id: <20191219031445.8949-2-bharata@linux.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 include/standard-headers/asm-x86/bootparam.h  |  7 +-
 .../infiniband/hw/vmw_pvrdma/pvrdma_dev_api.h | 15 +++-
 include/standard-headers/drm/drm_fourcc.h     | 28 ++++++-
 .../linux/input-event-codes.h                 | 77 +++++++++++++++++++
 include/standard-headers/linux/pci_regs.h     |  3 +
 .../standard-headers/rdma/vmw_pvrdma-abi.h    |  5 ++
 linux-headers/linux/kvm.h                     |  1 +
 7 files changed, 132 insertions(+), 4 deletions(-)

diff --git a/include/standard-headers/asm-x86/bootparam.h b/include/stand=
ard-headers/asm-x86/bootparam.h
index a6f7cf535e..072e2ed546 100644
--- a/include/standard-headers/asm-x86/bootparam.h
+++ b/include/standard-headers/asm-x86/bootparam.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_X86_BOOTPARAM_H
 #define _ASM_X86_BOOTPARAM_H
=20
-/* setup_data types */
+/* setup_data/setup_indirect types */
 #define SETUP_NONE			0
 #define SETUP_E820_EXT			1
 #define SETUP_DTB			2
@@ -11,6 +11,11 @@
 #define SETUP_APPLE_PROPERTIES		5
 #define SETUP_JAILHOUSE			6
=20
+#define SETUP_INDIRECT			(1<<31)
+
+/* SETUP_INDIRECT | max(SETUP_*) */
+#define SETUP_TYPE_MAX			(SETUP_INDIRECT | SETUP_JAILHOUSE)
+
 /* ram_size flags */
 #define RAMDISK_IMAGE_START_MASK	0x07FF
 #define RAMDISK_PROMPT_FLAG		0x8000
diff --git a/include/standard-headers/drivers/infiniband/hw/vmw_pvrdma/pv=
rdma_dev_api.h b/include/standard-headers/drivers/infiniband/hw/vmw_pvrdm=
a/pvrdma_dev_api.h
index d019872608..a5a1c8234e 100644
--- a/include/standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_de=
v_api.h
+++ b/include/standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_de=
v_api.h
@@ -58,7 +58,8 @@
 #define PVRDMA_ROCEV1_VERSION		17
 #define PVRDMA_ROCEV2_VERSION		18
 #define PVRDMA_PPN64_VERSION		19
-#define PVRDMA_VERSION			PVRDMA_PPN64_VERSION
+#define PVRDMA_QPHANDLE_VERSION		20
+#define PVRDMA_VERSION			PVRDMA_QPHANDLE_VERSION
=20
 #define PVRDMA_BOARD_ID			1
 #define PVRDMA_REV_ID			1
@@ -581,6 +582,17 @@ struct pvrdma_cmd_create_qp_resp {
 	uint32_t max_inline_data;
 };
=20
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
diff --git a/include/standard-headers/drm/drm_fourcc.h b/include/standard=
-headers/drm/drm_fourcc.h
index a308c91b4f..46d279f515 100644
--- a/include/standard-headers/drm/drm_fourcc.h
+++ b/include/standard-headers/drm/drm_fourcc.h
@@ -68,7 +68,7 @@ extern "C" {
 #define fourcc_code(a, b, c, d) ((uint32_t)(a) | ((uint32_t)(b) << 8) | =
\
 				 ((uint32_t)(c) << 16) | ((uint32_t)(d) << 24))
=20
-#define DRM_FORMAT_BIG_ENDIAN (1<<31) /* format is big endian instead of=
 little endian */
+#define DRM_FORMAT_BIG_ENDIAN (1U<<31) /* format is big endian instead o=
f little endian */
=20
 /* Reserve 0 for the invalid format specifier */
 #define DRM_FORMAT_INVALID	0
@@ -647,7 +647,21 @@ extern "C" {
  * Further information on the use of AFBC modifiers can be found in
  * Documentation/gpu/afbc.rst
  */
-#define DRM_FORMAT_MOD_ARM_AFBC(__afbc_mode)	fourcc_mod_code(ARM, __afbc=
_mode)
+
+/*
+ * The top 4 bits (out of the 56 bits alloted for specifying vendor spec=
ific
+ * modifiers) denote the category for modifiers. Currently we have only =
two
+ * categories of modifiers ie AFBC and MISC. We can have a maximum of si=
xteen
+ * different categories.
+ */
+#define DRM_FORMAT_MOD_ARM_CODE(__type, __val) \
+	fourcc_mod_code(ARM, ((uint64_t)(__type) << 52) | ((__val) & 0x000fffff=
ffffffffULL))
+
+#define DRM_FORMAT_MOD_ARM_TYPE_AFBC 0x00
+#define DRM_FORMAT_MOD_ARM_TYPE_MISC 0x01
+
+#define DRM_FORMAT_MOD_ARM_AFBC(__afbc_mode) \
+	DRM_FORMAT_MOD_ARM_CODE(DRM_FORMAT_MOD_ARM_TYPE_AFBC, __afbc_mode)
=20
 /*
  * AFBC superblock size
@@ -741,6 +755,16 @@ extern "C" {
  */
 #define AFBC_FORMAT_MOD_BCH     (1ULL << 11)
=20
+/*
+ * Arm 16x16 Block U-Interleaved modifier
+ *
+ * This is used by Arm Mali Utgard and Midgard GPUs. It divides the imag=
e
+ * into 16x16 pixel blocks. Blocks are stored linearly in order, but pix=
els
+ * in the block are reordered.
+ */
+#define DRM_FORMAT_MOD_ARM_16X16_BLOCK_U_INTERLEAVED \
+	DRM_FORMAT_MOD_ARM_CODE(DRM_FORMAT_MOD_ARM_TYPE_MISC, 1ULL)
+
 /*
  * Allwinner tiled modifier
  *
diff --git a/include/standard-headers/linux/input-event-codes.h b/include=
/standard-headers/linux/input-event-codes.h
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
+ * Some keyboards have keys which do not have a defined meaning, these k=
eys
+ * are intended to be programmed / bound to macros by the user. For most
+ * keyboards with these macro-keys the key-sequence to inject, or action=
 to
+ * take, is all handled by software on the host side. So from the kernel=
's
+ * point of view these are just normal keys.
+ *
+ * The KEY_MACRO# codes below are intended for such keys, which may be l=
abeled
+ * e.g. G1-G18, or S1 - S30. The KEY_MACRO# codes MUST NOT be used for k=
eys
+ * where the marking on the key does indicate a defined meaning / purpos=
e.
+ *
+ * The KEY_MACRO# codes MUST also NOT be used as fallback for when no ex=
isting
+ * KEY_FOO define matches the marking / purpose. In this case a new KEY_=
FOO
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
+ * Some keyboards with the macro-keys described above have some extra ke=
ys
+ * for controlling the host-side software responsible for the macro hand=
ling:
+ * -A macro recording start/stop key. Note that not all keyboards which =
emit
+ *  KEY_MACRO_RECORD_START will also emit KEY_MACRO_RECORD_STOP if
+ *  KEY_MACRO_RECORD_STOP is not advertised, then KEY_MACRO_RECORD_START
+ *  should be interpreted as a recording start/stop toggle;
+ * -Keys for switching between different macro (pre)sets, either a key f=
or
+ *  cycling through the configured presets or keys to directly select a =
preset.
+ */
+#define KEY_MACRO_RECORD_START		0x2b0
+#define KEY_MACRO_RECORD_STOP		0x2b1
+#define KEY_MACRO_PRESET_CYCLE		0x2b2
+#define KEY_MACRO_PRESET1		0x2b3
+#define KEY_MACRO_PRESET2		0x2b4
+#define KEY_MACRO_PRESET3		0x2b5
+
+/*
+ * Some keyboards have a buildin LCD panel where the contents are contro=
lled
+ * by the host. Often these have a number of keys directly below the LCD
+ * intended for controlling a menu shown on the LCD. These keys often do=
n't
+ * have any labeling so we just name them KEY_KBD_LCD_MENU#
+ */
+#define KEY_KBD_LCD_MENU1		0x2b8
+#define KEY_KBD_LCD_MENU2		0x2b9
+#define KEY_KBD_LCD_MENU3		0x2ba
+#define KEY_KBD_LCD_MENU4		0x2bb
+#define KEY_KBD_LCD_MENU5		0x2bc
=20
 #define BTN_TRIGGER_HAPPY		0x2c0
 #define BTN_TRIGGER_HAPPY1		0x2c0
diff --git a/include/standard-headers/linux/pci_regs.h b/include/standard=
-headers/linux/pci_regs.h
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
 #define PCI_CAP_EXP_ENDPOINT_SIZEOF_V2	52	/* v2 endpoints with link end =
here */
 #define PCI_EXP_SLTCAP2		52	/* Slot Capabilities 2 */
diff --git a/include/standard-headers/rdma/vmw_pvrdma-abi.h b/include/sta=
ndard-headers/rdma/vmw_pvrdma-abi.h
index 336a8d596f..0989426a3f 100644
--- a/include/standard-headers/rdma/vmw_pvrdma-abi.h
+++ b/include/standard-headers/rdma/vmw_pvrdma-abi.h
@@ -179,6 +179,11 @@ struct pvrdma_create_qp {
 	uint64_t __attribute__((aligned(8))) qp_addr;
 };
=20
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
 #define KVM_PPC_GET_CPU_CHAR	  _IOR(KVMIO,  0xb1, struct kvm_ppc_cpu_cha=
r)
 /* Available with KVM_CAP_PMU_EVENT_FILTER */
 #define KVM_SET_PMU_EVENT_FILTER  _IOW(KVMIO,  0xb2, struct kvm_pmu_even=
t_filter)
+#define KVM_PPC_SVM_OFF		  _IO(KVMIO,  0xb3)
=20
 /* ioctl for vm fd */
 #define KVM_CREATE_DEVICE	  _IOWR(KVMIO,  0xe0, struct kvm_create_device=
)
--=20
2.24.1


