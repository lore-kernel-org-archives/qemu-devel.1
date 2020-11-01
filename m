Return-Path: <SRS0=Dm/C=EH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B63F3C2D0A3
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 21:13:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F34D22254
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 21:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AAHqeai5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F34D22254
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZKff-0006Zq-8r
	for qemu-devel@archiver.kernel.org; Sun, 01 Nov 2020 16:13:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60538)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kZKUF-0007Jv-4s
 for qemu-devel@nongnu.org; Sun, 01 Nov 2020 16:02:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20136)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kZKUA-0005Wf-UR
 for qemu-devel@nongnu.org; Sun, 01 Nov 2020 16:02:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604264518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9ILV0aMl7yk3MRJoNUGrwvw03rtqSiUTmVrgUzr/bTI=;
 b=AAHqeai56r+XwQwb6p8axEpzsxQzmlti4MPaCMcIDjgV3ujbIiKY6ikxEarkjDDJAQnncu
 NFkyNs7ZN7y8t6BPqUudcYKMlj9ytuvfxcxD8DpzDhEcsgMQiy2wiqXkIko9IVZWZ8Xezn
 HTdHkwpEQKfn5QVwLrFGgDEBTeSyos0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-1mX_DGssOs6CUWm1Fvq41A-1; Sun, 01 Nov 2020 16:01:53 -0500
X-MC-Unique: 1mX_DGssOs6CUWm1Fvq41A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 836D0425F2;
 Sun,  1 Nov 2020 21:01:52 +0000 (UTC)
Received: from gimli.home (ovpn-112-213.phx2.redhat.com [10.3.112.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2533F5C1A3;
 Sun,  1 Nov 2020 21:01:49 +0000 (UTC)
Subject: [PULL v3 19/32] linux-headers: update against 5.10-rc1
From: Alex Williamson <alex.williamson@redhat.com>
To: qemu-devel@nongnu.org
Date: Sun, 01 Nov 2020 14:01:48 -0700
Message-ID: <160426450877.24886.15473179182726173354.stgit@gimli.home>
In-Reply-To: <160426371498.24886.12193840637250368669.stgit@gimli.home>
References: <160426371498.24886.12193840637250368669.stgit@gimli.home>
User-Agent: StGit/0.21-dirty
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/01 15:59:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Matthew Rosato <mjrosato@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Matthew Rosato <mjrosato@linux.ibm.com>

commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec

Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
[aw: drop pvrdma_ring.h changes to avoid revert of d73415a31547 ("qemu/atomic.h: rename atomic_ to qatomic_")]
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 .../infiniband/hw/vmw_pvrdma/pvrdma_verbs.h        |    2 -
 include/standard-headers/linux/ethtool.h           |    2 +
 include/standard-headers/linux/fuse.h              |   50 ++++++++++++-
 include/standard-headers/linux/input-event-codes.h |    4 +
 include/standard-headers/linux/pci_regs.h          |    6 +-
 include/standard-headers/linux/virtio_fs.h         |    3 +
 include/standard-headers/linux/virtio_gpu.h        |   19 +++++
 include/standard-headers/linux/virtio_mmio.h       |   11 +++
 include/standard-headers/linux/virtio_pci.h        |   11 +++
 linux-headers/asm-arm64/kvm.h                      |   25 ++++++
 linux-headers/asm-arm64/mman.h                     |    1 
 linux-headers/asm-generic/hugetlb_encode.h         |    1 
 linux-headers/asm-generic/unistd.h                 |   18 ++---
 linux-headers/asm-mips/unistd_n32.h                |    1 
 linux-headers/asm-mips/unistd_n64.h                |    1 
 linux-headers/asm-mips/unistd_o32.h                |    1 
 linux-headers/asm-powerpc/unistd_32.h              |    1 
 linux-headers/asm-powerpc/unistd_64.h              |    1 
 linux-headers/asm-s390/unistd_32.h                 |    1 
 linux-headers/asm-s390/unistd_64.h                 |    1 
 linux-headers/asm-x86/kvm.h                        |   20 +++++
 linux-headers/asm-x86/unistd_32.h                  |    1 
 linux-headers/asm-x86/unistd_64.h                  |    1 
 linux-headers/asm-x86/unistd_x32.h                 |    1 
 linux-headers/linux/kvm.h                          |   19 +++++
 linux-headers/linux/mman.h                         |    1 
 linux-headers/linux/vfio.h                         |   29 +++++++
 linux-headers/linux/vfio_zdev.h                    |   78 ++++++++++++++++++++
 28 files changed, 294 insertions(+), 16 deletions(-)
 create mode 100644 linux-headers/linux/vfio_zdev.h

diff --git a/include/standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h b/include/standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h
index 1677208a411f..0a8c7c931199 100644
--- a/include/standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h
+++ b/include/standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h
@@ -176,7 +176,7 @@ struct pvrdma_port_attr {
 	uint8_t			subnet_timeout;
 	uint8_t			init_type_reply;
 	uint8_t			active_width;
-	uint8_t			active_speed;
+	uint16_t			active_speed;
 	uint8_t			phys_state;
 	uint8_t			reserved[2];
 };
diff --git a/include/standard-headers/linux/ethtool.h b/include/standard-headers/linux/ethtool.h
index e13eff44882d..0df22f7538e3 100644
--- a/include/standard-headers/linux/ethtool.h
+++ b/include/standard-headers/linux/ethtool.h
@@ -1617,6 +1617,8 @@ enum ethtool_link_mode_bit_indices {
 	ETHTOOL_LINK_MODE_400000baseLR4_ER4_FR4_Full_BIT = 87,
 	ETHTOOL_LINK_MODE_400000baseDR4_Full_BIT	 = 88,
 	ETHTOOL_LINK_MODE_400000baseCR4_Full_BIT	 = 89,
+	ETHTOOL_LINK_MODE_100baseFX_Half_BIT		 = 90,
+	ETHTOOL_LINK_MODE_100baseFX_Full_BIT		 = 91,
 	/* must be last entry */
 	__ETHTOOL_LINK_MODE_MASK_NBITS
 };
diff --git a/include/standard-headers/linux/fuse.h b/include/standard-headers/linux/fuse.h
index f4df0a40f604..82c0a38b591e 100644
--- a/include/standard-headers/linux/fuse.h
+++ b/include/standard-headers/linux/fuse.h
@@ -172,6 +172,9 @@
  *  - add FUSE_WRITE_KILL_PRIV flag
  *  - add FUSE_SETUPMAPPING and FUSE_REMOVEMAPPING
  *  - add map_alignment to fuse_init_out, add FUSE_MAP_ALIGNMENT flag
+ *
+ *  7.32
+ *  - add flags to fuse_attr, add FUSE_ATTR_SUBMOUNT, add FUSE_SUBMOUNTS
  */
 
 #ifndef _LINUX_FUSE_H
@@ -203,7 +206,7 @@
 #define FUSE_KERNEL_VERSION 7
 
 /** Minor version number of this interface */
-#define FUSE_KERNEL_MINOR_VERSION 31
+#define FUSE_KERNEL_MINOR_VERSION 32
 
 /** The node ID of the root inode */
 #define FUSE_ROOT_ID 1
@@ -227,7 +230,7 @@ struct fuse_attr {
 	uint32_t	gid;
 	uint32_t	rdev;
 	uint32_t	blksize;
-	uint32_t	padding;
+	uint32_t	flags;
 };
 
 struct fuse_kstatfs {
@@ -309,7 +312,10 @@ struct fuse_file_lock {
  * FUSE_CACHE_SYMLINKS: cache READLINK responses
  * FUSE_NO_OPENDIR_SUPPORT: kernel supports zero-message opendir
  * FUSE_EXPLICIT_INVAL_DATA: only invalidate cached pages on explicit request
- * FUSE_MAP_ALIGNMENT: map_alignment field is valid
+ * FUSE_MAP_ALIGNMENT: init_out.map_alignment contains log2(byte alignment) for
+ *		       foffset and moffset fields in struct
+ *		       fuse_setupmapping_out and fuse_removemapping_one.
+ * FUSE_SUBMOUNTS: kernel supports auto-mounting directory submounts
  */
 #define FUSE_ASYNC_READ		(1 << 0)
 #define FUSE_POSIX_LOCKS	(1 << 1)
@@ -338,6 +344,7 @@ struct fuse_file_lock {
 #define FUSE_NO_OPENDIR_SUPPORT (1 << 24)
 #define FUSE_EXPLICIT_INVAL_DATA (1 << 25)
 #define FUSE_MAP_ALIGNMENT	(1 << 26)
+#define FUSE_SUBMOUNTS		(1 << 27)
 
 /**
  * CUSE INIT request/reply flags
@@ -413,6 +420,13 @@ struct fuse_file_lock {
  */
 #define FUSE_FSYNC_FDATASYNC	(1 << 0)
 
+/**
+ * fuse_attr flags
+ *
+ * FUSE_ATTR_SUBMOUNT: Object is a submount root
+ */
+#define FUSE_ATTR_SUBMOUNT      (1 << 0)
+
 enum fuse_opcode {
 	FUSE_LOOKUP		= 1,
 	FUSE_FORGET		= 2,  /* no reply */
@@ -888,4 +902,34 @@ struct fuse_copy_file_range_in {
 	uint64_t	flags;
 };
 
+#define FUSE_SETUPMAPPING_FLAG_WRITE (1ull << 0)
+#define FUSE_SETUPMAPPING_FLAG_READ (1ull << 1)
+struct fuse_setupmapping_in {
+	/* An already open handle */
+	uint64_t	fh;
+	/* Offset into the file to start the mapping */
+	uint64_t	foffset;
+	/* Length of mapping required */
+	uint64_t	len;
+	/* Flags, FUSE_SETUPMAPPING_FLAG_* */
+	uint64_t	flags;
+	/* Offset in Memory Window */
+	uint64_t	moffset;
+};
+
+struct fuse_removemapping_in {
+	/* number of fuse_removemapping_one follows */
+	uint32_t        count;
+};
+
+struct fuse_removemapping_one {
+	/* Offset into the dax window start the unmapping */
+	uint64_t        moffset;
+	/* Length of mapping required */
+	uint64_t	len;
+};
+
+#define FUSE_REMOVEMAPPING_MAX_ENTRY   \
+		(PAGE_SIZE / sizeof(struct fuse_removemapping_one))
+
 #endif /* _LINUX_FUSE_H */
diff --git a/include/standard-headers/linux/input-event-codes.h b/include/standard-headers/linux/input-event-codes.h
index e740ad9f2e01..c403b9cb0d4e 100644
--- a/include/standard-headers/linux/input-event-codes.h
+++ b/include/standard-headers/linux/input-event-codes.h
@@ -515,6 +515,9 @@
 #define KEY_10CHANNELSUP	0x1b8	/* 10 channels up (10+) */
 #define KEY_10CHANNELSDOWN	0x1b9	/* 10 channels down (10-) */
 #define KEY_IMAGES		0x1ba	/* AL Image Browser */
+#define KEY_NOTIFICATION_CENTER	0x1bc	/* Show/hide the notification center */
+#define KEY_PICKUP_PHONE	0x1bd	/* Answer incoming call */
+#define KEY_HANGUP_PHONE	0x1be	/* Decline incoming call */
 
 #define KEY_DEL_EOL		0x1c0
 #define KEY_DEL_EOS		0x1c1
@@ -542,6 +545,7 @@
 #define KEY_FN_F		0x1e2
 #define KEY_FN_S		0x1e3
 #define KEY_FN_B		0x1e4
+#define KEY_FN_RIGHT_SHIFT	0x1e5
 
 #define KEY_BRL_DOT1		0x1f1
 #define KEY_BRL_DOT2		0x1f2
diff --git a/include/standard-headers/linux/pci_regs.h b/include/standard-headers/linux/pci_regs.h
index f9701410d3b5..a95d55f9f257 100644
--- a/include/standard-headers/linux/pci_regs.h
+++ b/include/standard-headers/linux/pci_regs.h
@@ -76,6 +76,7 @@
 #define PCI_CACHE_LINE_SIZE	0x0c	/* 8 bits */
 #define PCI_LATENCY_TIMER	0x0d	/* 8 bits */
 #define PCI_HEADER_TYPE		0x0e	/* 8 bits */
+#define  PCI_HEADER_TYPE_MASK		0x7f
 #define  PCI_HEADER_TYPE_NORMAL		0
 #define  PCI_HEADER_TYPE_BRIDGE		1
 #define  PCI_HEADER_TYPE_CARDBUS	2
@@ -246,7 +247,7 @@
 #define  PCI_PM_CAP_PME_D0	0x0800	/* PME# from D0 */
 #define  PCI_PM_CAP_PME_D1	0x1000	/* PME# from D1 */
 #define  PCI_PM_CAP_PME_D2	0x2000	/* PME# from D2 */
-#define  PCI_PM_CAP_PME_D3	0x4000	/* PME# from D3 (hot) */
+#define  PCI_PM_CAP_PME_D3hot	0x4000	/* PME# from D3 (hot) */
 #define  PCI_PM_CAP_PME_D3cold	0x8000	/* PME# from D3 (cold) */
 #define  PCI_PM_CAP_PME_SHIFT	11	/* Start of the PME Mask in PMC */
 #define PCI_PM_CTRL		4	/* PM control and status register */
@@ -532,6 +533,8 @@
 #define  PCI_EXP_LNKCAP_SLS_32_0GB 0x00000005 /* LNKCAP2 SLS Vector bit 4 */
 #define  PCI_EXP_LNKCAP_MLW	0x000003f0 /* Maximum Link Width */
 #define  PCI_EXP_LNKCAP_ASPMS	0x00000c00 /* ASPM Support */
+#define  PCI_EXP_LNKCAP_ASPM_L0S 0x00000400 /* ASPM L0s Support */
+#define  PCI_EXP_LNKCAP_ASPM_L1  0x00000800 /* ASPM L1 Support */
 #define  PCI_EXP_LNKCAP_L0SEL	0x00007000 /* L0s Exit Latency */
 #define  PCI_EXP_LNKCAP_L1EL	0x00038000 /* L1 Exit Latency */
 #define  PCI_EXP_LNKCAP_CLKPM	0x00040000 /* Clock Power Management */
@@ -1056,6 +1059,7 @@
 #define  PCI_L1SS_CTL1_PCIPM_L1_1	0x00000002  /* PCI-PM L1.1 Enable */
 #define  PCI_L1SS_CTL1_ASPM_L1_2	0x00000004  /* ASPM L1.2 Enable */
 #define  PCI_L1SS_CTL1_ASPM_L1_1	0x00000008  /* ASPM L1.1 Enable */
+#define  PCI_L1SS_CTL1_L1_2_MASK	0x00000005
 #define  PCI_L1SS_CTL1_L1SS_MASK	0x0000000f
 #define  PCI_L1SS_CTL1_CM_RESTORE_TIME	0x0000ff00  /* Common_Mode_Restore_Time */
 #define  PCI_L1SS_CTL1_LTR_L12_TH_VALUE	0x03ff0000  /* LTR_L1.2_THRESHOLD_Value */
diff --git a/include/standard-headers/linux/virtio_fs.h b/include/standard-headers/linux/virtio_fs.h
index 9d88817a6b66..a32fe8a64c76 100644
--- a/include/standard-headers/linux/virtio_fs.h
+++ b/include/standard-headers/linux/virtio_fs.h
@@ -16,4 +16,7 @@ struct virtio_fs_config {
 	uint32_t num_request_queues;
 } QEMU_PACKED;
 
+/* For the id field in virtio_pci_shm_cap */
+#define VIRTIO_FS_SHMCAP_ID_CACHE 0
+
 #endif /* _LINUX_VIRTIO_FS_H */
diff --git a/include/standard-headers/linux/virtio_gpu.h b/include/standard-headers/linux/virtio_gpu.h
index b8fa15f0ace7..4183cdc74b33 100644
--- a/include/standard-headers/linux/virtio_gpu.h
+++ b/include/standard-headers/linux/virtio_gpu.h
@@ -50,6 +50,10 @@
  * VIRTIO_GPU_CMD_GET_EDID
  */
 #define VIRTIO_GPU_F_EDID                1
+/*
+ * VIRTIO_GPU_CMD_RESOURCE_ASSIGN_UUID
+ */
+#define VIRTIO_GPU_F_RESOURCE_UUID       2
 
 enum virtio_gpu_ctrl_type {
 	VIRTIO_GPU_UNDEFINED = 0,
@@ -66,6 +70,7 @@ enum virtio_gpu_ctrl_type {
 	VIRTIO_GPU_CMD_GET_CAPSET_INFO,
 	VIRTIO_GPU_CMD_GET_CAPSET,
 	VIRTIO_GPU_CMD_GET_EDID,
+	VIRTIO_GPU_CMD_RESOURCE_ASSIGN_UUID,
 
 	/* 3d commands */
 	VIRTIO_GPU_CMD_CTX_CREATE = 0x0200,
@@ -87,6 +92,7 @@ enum virtio_gpu_ctrl_type {
 	VIRTIO_GPU_RESP_OK_CAPSET_INFO,
 	VIRTIO_GPU_RESP_OK_CAPSET,
 	VIRTIO_GPU_RESP_OK_EDID,
+	VIRTIO_GPU_RESP_OK_RESOURCE_UUID,
 
 	/* error responses */
 	VIRTIO_GPU_RESP_ERR_UNSPEC = 0x1200,
@@ -340,4 +346,17 @@ enum virtio_gpu_formats {
 	VIRTIO_GPU_FORMAT_R8G8B8X8_UNORM  = 134,
 };
 
+/* VIRTIO_GPU_CMD_RESOURCE_ASSIGN_UUID */
+struct virtio_gpu_resource_assign_uuid {
+	struct virtio_gpu_ctrl_hdr hdr;
+	uint32_t resource_id;
+	uint32_t padding;
+};
+
+/* VIRTIO_GPU_RESP_OK_RESOURCE_UUID */
+struct virtio_gpu_resp_resource_uuid {
+	struct virtio_gpu_ctrl_hdr hdr;
+	uint8_t uuid[16];
+};
+
 #endif
diff --git a/include/standard-headers/linux/virtio_mmio.h b/include/standard-headers/linux/virtio_mmio.h
index c4b09689ab64..0650f91bea6c 100644
--- a/include/standard-headers/linux/virtio_mmio.h
+++ b/include/standard-headers/linux/virtio_mmio.h
@@ -122,6 +122,17 @@
 #define VIRTIO_MMIO_QUEUE_USED_LOW	0x0a0
 #define VIRTIO_MMIO_QUEUE_USED_HIGH	0x0a4
 
+/* Shared memory region id */
+#define VIRTIO_MMIO_SHM_SEL             0x0ac
+
+/* Shared memory region length, 64 bits in two halves */
+#define VIRTIO_MMIO_SHM_LEN_LOW         0x0b0
+#define VIRTIO_MMIO_SHM_LEN_HIGH        0x0b4
+
+/* Shared memory region base address, 64 bits in two halves */
+#define VIRTIO_MMIO_SHM_BASE_LOW        0x0b8
+#define VIRTIO_MMIO_SHM_BASE_HIGH       0x0bc
+
 /* Configuration atomicity value */
 #define VIRTIO_MMIO_CONFIG_GENERATION	0x0fc
 
diff --git a/include/standard-headers/linux/virtio_pci.h b/include/standard-headers/linux/virtio_pci.h
index 9262acd130c3..db7a8e2fcbf2 100644
--- a/include/standard-headers/linux/virtio_pci.h
+++ b/include/standard-headers/linux/virtio_pci.h
@@ -113,6 +113,8 @@
 #define VIRTIO_PCI_CAP_DEVICE_CFG	4
 /* PCI configuration access */
 #define VIRTIO_PCI_CAP_PCI_CFG		5
+/* Additional shared memory capability */
+#define VIRTIO_PCI_CAP_SHARED_MEMORY_CFG 8
 
 /* This is the PCI capability header: */
 struct virtio_pci_cap {
@@ -121,11 +123,18 @@ struct virtio_pci_cap {
 	uint8_t cap_len;		/* Generic PCI field: capability length */
 	uint8_t cfg_type;		/* Identifies the structure. */
 	uint8_t bar;		/* Where to find it. */
-	uint8_t padding[3];	/* Pad to full dword. */
+	uint8_t id;		/* Multiple capabilities of the same type */
+	uint8_t padding[2];	/* Pad to full dword. */
 	uint32_t offset;		/* Offset within bar. */
 	uint32_t length;		/* Length of the structure, in bytes. */
 };
 
+struct virtio_pci_cap64 {
+	struct virtio_pci_cap cap;
+	uint32_t offset_hi;             /* Most sig 32 bits of offset */
+	uint32_t length_hi;             /* Most sig 32 bits of length */
+};
+
 struct virtio_pci_notify_cap {
 	struct virtio_pci_cap cap;
 	uint32_t notify_off_multiplier;	/* Multiplier for queue_notify_off. */
diff --git a/linux-headers/asm-arm64/kvm.h b/linux-headers/asm-arm64/kvm.h
index 9e34f0f875a6..a72de1ae4cb5 100644
--- a/linux-headers/asm-arm64/kvm.h
+++ b/linux-headers/asm-arm64/kvm.h
@@ -159,6 +159,21 @@ struct kvm_sync_regs {
 struct kvm_arch_memory_slot {
 };
 
+/*
+ * PMU filter structure. Describe a range of events with a particular
+ * action. To be used with KVM_ARM_VCPU_PMU_V3_FILTER.
+ */
+struct kvm_pmu_event_filter {
+	__u16	base_event;
+	__u16	nevents;
+
+#define KVM_PMU_EVENT_ALLOW	0
+#define KVM_PMU_EVENT_DENY	1
+
+	__u8	action;
+	__u8	pad[3];
+};
+
 /* for KVM_GET/SET_VCPU_EVENTS */
 struct kvm_vcpu_events {
 	struct {
@@ -242,6 +257,15 @@ struct kvm_vcpu_events {
 #define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_NOT_AVAIL		0
 #define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_AVAIL		1
 #define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_NOT_REQUIRED	2
+
+/*
+ * Only two states can be presented by the host kernel:
+ * - NOT_REQUIRED: the guest doesn't need to do anything
+ * - NOT_AVAIL: the guest isn't mitigated (it can still use SSBS if available)
+ *
+ * All the other values are deprecated. The host still accepts all
+ * values (they are ABI), but will narrow them to the above two.
+ */
 #define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2	KVM_REG_ARM_FW_REG(2)
 #define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_NOT_AVAIL		0
 #define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_UNKNOWN		1
@@ -329,6 +353,7 @@ struct kvm_vcpu_events {
 #define KVM_ARM_VCPU_PMU_V3_CTRL	0
 #define   KVM_ARM_VCPU_PMU_V3_IRQ	0
 #define   KVM_ARM_VCPU_PMU_V3_INIT	1
+#define   KVM_ARM_VCPU_PMU_V3_FILTER	2
 #define KVM_ARM_VCPU_TIMER_CTRL		1
 #define   KVM_ARM_VCPU_TIMER_IRQ_VTIMER		0
 #define   KVM_ARM_VCPU_TIMER_IRQ_PTIMER		1
diff --git a/linux-headers/asm-arm64/mman.h b/linux-headers/asm-arm64/mman.h
index e94b9af85984..d0dbfe958789 100644
--- a/linux-headers/asm-arm64/mman.h
+++ b/linux-headers/asm-arm64/mman.h
@@ -5,5 +5,6 @@
 #include <asm-generic/mman.h>
 
 #define PROT_BTI	0x10		/* BTI guarded page */
+#define PROT_MTE	0x20		/* Normal Tagged mapping */
 
 #endif /* ! _UAPI__ASM_MMAN_H */
diff --git a/linux-headers/asm-generic/hugetlb_encode.h b/linux-headers/asm-generic/hugetlb_encode.h
index b0f8e87235bd..4f3d5aaa11f5 100644
--- a/linux-headers/asm-generic/hugetlb_encode.h
+++ b/linux-headers/asm-generic/hugetlb_encode.h
@@ -20,6 +20,7 @@
 #define HUGETLB_FLAG_ENCODE_SHIFT	26
 #define HUGETLB_FLAG_ENCODE_MASK	0x3f
 
+#define HUGETLB_FLAG_ENCODE_16KB	(14 << HUGETLB_FLAG_ENCODE_SHIFT)
 #define HUGETLB_FLAG_ENCODE_64KB	(16 << HUGETLB_FLAG_ENCODE_SHIFT)
 #define HUGETLB_FLAG_ENCODE_512KB	(19 << HUGETLB_FLAG_ENCODE_SHIFT)
 #define HUGETLB_FLAG_ENCODE_1MB		(20 << HUGETLB_FLAG_ENCODE_SHIFT)
diff --git a/linux-headers/asm-generic/unistd.h b/linux-headers/asm-generic/unistd.h
index 995b36c2ea7d..2056318988f7 100644
--- a/linux-headers/asm-generic/unistd.h
+++ b/linux-headers/asm-generic/unistd.h
@@ -140,7 +140,7 @@ __SYSCALL(__NR_renameat, sys_renameat)
 #define __NR_umount2 39
 __SYSCALL(__NR_umount2, sys_umount)
 #define __NR_mount 40
-__SC_COMP(__NR_mount, sys_mount, compat_sys_mount)
+__SYSCALL(__NR_mount, sys_mount)
 #define __NR_pivot_root 41
 __SYSCALL(__NR_pivot_root, sys_pivot_root)
 
@@ -207,9 +207,9 @@ __SYSCALL(__NR_read, sys_read)
 #define __NR_write 64
 __SYSCALL(__NR_write, sys_write)
 #define __NR_readv 65
-__SC_COMP(__NR_readv, sys_readv, compat_sys_readv)
+__SC_COMP(__NR_readv, sys_readv, sys_readv)
 #define __NR_writev 66
-__SC_COMP(__NR_writev, sys_writev, compat_sys_writev)
+__SC_COMP(__NR_writev, sys_writev, sys_writev)
 #define __NR_pread64 67
 __SC_COMP(__NR_pread64, sys_pread64, compat_sys_pread64)
 #define __NR_pwrite64 68
@@ -237,7 +237,7 @@ __SC_COMP(__NR_signalfd4, sys_signalfd4, compat_sys_signalfd4)
 
 /* fs/splice.c */
 #define __NR_vmsplice 75
-__SC_COMP(__NR_vmsplice, sys_vmsplice, compat_sys_vmsplice)
+__SYSCALL(__NR_vmsplice, sys_vmsplice)
 #define __NR_splice 76
 __SYSCALL(__NR_splice, sys_splice)
 #define __NR_tee 77
@@ -727,11 +727,9 @@ __SYSCALL(__NR_setns, sys_setns)
 #define __NR_sendmmsg 269
 __SC_COMP(__NR_sendmmsg, sys_sendmmsg, compat_sys_sendmmsg)
 #define __NR_process_vm_readv 270
-__SC_COMP(__NR_process_vm_readv, sys_process_vm_readv, \
-          compat_sys_process_vm_readv)
+__SYSCALL(__NR_process_vm_readv, sys_process_vm_readv)
 #define __NR_process_vm_writev 271
-__SC_COMP(__NR_process_vm_writev, sys_process_vm_writev, \
-          compat_sys_process_vm_writev)
+__SYSCALL(__NR_process_vm_writev, sys_process_vm_writev)
 #define __NR_kcmp 272
 __SYSCALL(__NR_kcmp, sys_kcmp)
 #define __NR_finit_module 273
@@ -859,9 +857,11 @@ __SYSCALL(__NR_openat2, sys_openat2)
 __SYSCALL(__NR_pidfd_getfd, sys_pidfd_getfd)
 #define __NR_faccessat2 439
 __SYSCALL(__NR_faccessat2, sys_faccessat2)
+#define __NR_process_madvise 440
+__SYSCALL(__NR_process_madvise, sys_process_madvise)
 
 #undef __NR_syscalls
-#define __NR_syscalls 440
+#define __NR_syscalls 441
 
 /*
  * 32 bit systems traditionally used different
diff --git a/linux-headers/asm-mips/unistd_n32.h b/linux-headers/asm-mips/unistd_n32.h
index 246fbb6a7885..aba284d190a0 100644
--- a/linux-headers/asm-mips/unistd_n32.h
+++ b/linux-headers/asm-mips/unistd_n32.h
@@ -369,6 +369,7 @@
 #define __NR_openat2	(__NR_Linux + 437)
 #define __NR_pidfd_getfd	(__NR_Linux + 438)
 #define __NR_faccessat2	(__NR_Linux + 439)
+#define __NR_process_madvise	(__NR_Linux + 440)
 
 
 #endif /* _ASM_MIPS_UNISTD_N32_H */
diff --git a/linux-headers/asm-mips/unistd_n64.h b/linux-headers/asm-mips/unistd_n64.h
index 194d777dfd42..0465ab94db89 100644
--- a/linux-headers/asm-mips/unistd_n64.h
+++ b/linux-headers/asm-mips/unistd_n64.h
@@ -345,6 +345,7 @@
 #define __NR_openat2	(__NR_Linux + 437)
 #define __NR_pidfd_getfd	(__NR_Linux + 438)
 #define __NR_faccessat2	(__NR_Linux + 439)
+#define __NR_process_madvise	(__NR_Linux + 440)
 
 
 #endif /* _ASM_MIPS_UNISTD_N64_H */
diff --git a/linux-headers/asm-mips/unistd_o32.h b/linux-headers/asm-mips/unistd_o32.h
index 3e093dd9134d..5222a0dd50e1 100644
--- a/linux-headers/asm-mips/unistd_o32.h
+++ b/linux-headers/asm-mips/unistd_o32.h
@@ -415,6 +415,7 @@
 #define __NR_openat2	(__NR_Linux + 437)
 #define __NR_pidfd_getfd	(__NR_Linux + 438)
 #define __NR_faccessat2	(__NR_Linux + 439)
+#define __NR_process_madvise	(__NR_Linux + 440)
 
 
 #endif /* _ASM_MIPS_UNISTD_O32_H */
diff --git a/linux-headers/asm-powerpc/unistd_32.h b/linux-headers/asm-powerpc/unistd_32.h
index 0db9481d4962..21066a3d5f4a 100644
--- a/linux-headers/asm-powerpc/unistd_32.h
+++ b/linux-headers/asm-powerpc/unistd_32.h
@@ -422,6 +422,7 @@
 #define __NR_openat2	437
 #define __NR_pidfd_getfd	438
 #define __NR_faccessat2	439
+#define __NR_process_madvise	440
 
 
 #endif /* _ASM_POWERPC_UNISTD_32_H */
diff --git a/linux-headers/asm-powerpc/unistd_64.h b/linux-headers/asm-powerpc/unistd_64.h
index 9f74310988e1..c153da29f236 100644
--- a/linux-headers/asm-powerpc/unistd_64.h
+++ b/linux-headers/asm-powerpc/unistd_64.h
@@ -394,6 +394,7 @@
 #define __NR_openat2	437
 #define __NR_pidfd_getfd	438
 #define __NR_faccessat2	439
+#define __NR_process_madvise	440
 
 
 #endif /* _ASM_POWERPC_UNISTD_64_H */
diff --git a/linux-headers/asm-s390/unistd_32.h b/linux-headers/asm-s390/unistd_32.h
index 1803cd0c3ba6..3b4f2dda6049 100644
--- a/linux-headers/asm-s390/unistd_32.h
+++ b/linux-headers/asm-s390/unistd_32.h
@@ -412,5 +412,6 @@
 #define __NR_openat2 437
 #define __NR_pidfd_getfd 438
 #define __NR_faccessat2 439
+#define __NR_process_madvise 440
 
 #endif /* _ASM_S390_UNISTD_32_H */
diff --git a/linux-headers/asm-s390/unistd_64.h b/linux-headers/asm-s390/unistd_64.h
index 228d5004e5a8..030a51fa3828 100644
--- a/linux-headers/asm-s390/unistd_64.h
+++ b/linux-headers/asm-s390/unistd_64.h
@@ -360,5 +360,6 @@
 #define __NR_openat2 437
 #define __NR_pidfd_getfd 438
 #define __NR_faccessat2 439
+#define __NR_process_madvise 440
 
 #endif /* _ASM_S390_UNISTD_64_H */
diff --git a/linux-headers/asm-x86/kvm.h b/linux-headers/asm-x86/kvm.h
index 0780f97c1850..89e5f3d1bba8 100644
--- a/linux-headers/asm-x86/kvm.h
+++ b/linux-headers/asm-x86/kvm.h
@@ -192,6 +192,26 @@ struct kvm_msr_list {
 	__u32 indices[0];
 };
 
+/* Maximum size of any access bitmap in bytes */
+#define KVM_MSR_FILTER_MAX_BITMAP_SIZE 0x600
+
+/* for KVM_X86_SET_MSR_FILTER */
+struct kvm_msr_filter_range {
+#define KVM_MSR_FILTER_READ  (1 << 0)
+#define KVM_MSR_FILTER_WRITE (1 << 1)
+	__u32 flags;
+	__u32 nmsrs; /* number of msrs in bitmap */
+	__u32 base;  /* MSR index the bitmap starts at */
+	__u8 *bitmap; /* a 1 bit allows the operations in flags, 0 denies */
+};
+
+#define KVM_MSR_FILTER_MAX_RANGES 16
+struct kvm_msr_filter {
+#define KVM_MSR_FILTER_DEFAULT_ALLOW (0 << 0)
+#define KVM_MSR_FILTER_DEFAULT_DENY  (1 << 0)
+	__u32 flags;
+	struct kvm_msr_filter_range ranges[KVM_MSR_FILTER_MAX_RANGES];
+};
 
 struct kvm_cpuid_entry {
 	__u32 function;
diff --git a/linux-headers/asm-x86/unistd_32.h b/linux-headers/asm-x86/unistd_32.h
index 356c12c2dbce..cfba368f9dff 100644
--- a/linux-headers/asm-x86/unistd_32.h
+++ b/linux-headers/asm-x86/unistd_32.h
@@ -430,6 +430,7 @@
 #define __NR_openat2 437
 #define __NR_pidfd_getfd 438
 #define __NR_faccessat2 439
+#define __NR_process_madvise 440
 
 
 #endif /* _ASM_X86_UNISTD_32_H */
diff --git a/linux-headers/asm-x86/unistd_64.h b/linux-headers/asm-x86/unistd_64.h
index ef70e1c7c93f..61af7250955f 100644
--- a/linux-headers/asm-x86/unistd_64.h
+++ b/linux-headers/asm-x86/unistd_64.h
@@ -352,6 +352,7 @@
 #define __NR_openat2 437
 #define __NR_pidfd_getfd 438
 #define __NR_faccessat2 439
+#define __NR_process_madvise 440
 
 
 #endif /* _ASM_X86_UNISTD_64_H */
diff --git a/linux-headers/asm-x86/unistd_x32.h b/linux-headers/asm-x86/unistd_x32.h
index 84ae8e9f5fca..a6890cb1f5b5 100644
--- a/linux-headers/asm-x86/unistd_x32.h
+++ b/linux-headers/asm-x86/unistd_x32.h
@@ -305,6 +305,7 @@
 #define __NR_openat2 (__X32_SYSCALL_BIT + 437)
 #define __NR_pidfd_getfd (__X32_SYSCALL_BIT + 438)
 #define __NR_faccessat2 (__X32_SYSCALL_BIT + 439)
+#define __NR_process_madvise (__X32_SYSCALL_BIT + 440)
 #define __NR_rt_sigaction (__X32_SYSCALL_BIT + 512)
 #define __NR_rt_sigreturn (__X32_SYSCALL_BIT + 513)
 #define __NR_ioctl (__X32_SYSCALL_BIT + 514)
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index 43580c767c33..56ce14ad209f 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -248,6 +248,8 @@ struct kvm_hyperv_exit {
 #define KVM_EXIT_IOAPIC_EOI       26
 #define KVM_EXIT_HYPERV           27
 #define KVM_EXIT_ARM_NISV         28
+#define KVM_EXIT_X86_RDMSR        29
+#define KVM_EXIT_X86_WRMSR        30
 
 /* For KVM_EXIT_INTERNAL_ERROR */
 /* Emulate instruction failed. */
@@ -413,6 +415,17 @@ struct kvm_run {
 			__u64 esr_iss;
 			__u64 fault_ipa;
 		} arm_nisv;
+		/* KVM_EXIT_X86_RDMSR / KVM_EXIT_X86_WRMSR */
+		struct {
+			__u8 error; /* user -> kernel */
+			__u8 pad[7];
+#define KVM_MSR_EXIT_REASON_INVAL	(1 << 0)
+#define KVM_MSR_EXIT_REASON_UNKNOWN	(1 << 1)
+#define KVM_MSR_EXIT_REASON_FILTER	(1 << 2)
+			__u32 reason; /* kernel -> user */
+			__u32 index; /* kernel -> user */
+			__u64 data; /* kernel <-> user */
+		} msr;
 		/* Fix the size of the union. */
 		char padding[256];
 	};
@@ -1037,6 +1050,9 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_SMALLER_MAXPHYADDR 185
 #define KVM_CAP_S390_DIAG318 186
 #define KVM_CAP_STEAL_TIME 187
+#define KVM_CAP_X86_USER_SPACE_MSR 188
+#define KVM_CAP_X86_MSR_FILTER 189
+#define KVM_CAP_ENFORCE_PV_FEATURE_CPUID 190
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -1538,6 +1554,9 @@ struct kvm_pv_cmd {
 /* Available with KVM_CAP_S390_PROTECTED */
 #define KVM_S390_PV_COMMAND		_IOWR(KVMIO, 0xc5, struct kvm_pv_cmd)
 
+/* Available with KVM_CAP_X86_MSR_FILTER */
+#define KVM_X86_SET_MSR_FILTER	_IOW(KVMIO,  0xc6, struct kvm_msr_filter)
+
 /* Secure Encrypted Virtualization command */
 enum sev_cmd_id {
 	/* Guest initialization commands */
diff --git a/linux-headers/linux/mman.h b/linux-headers/linux/mman.h
index 51ea363759f0..434986fbe307 100644
--- a/linux-headers/linux/mman.h
+++ b/linux-headers/linux/mman.h
@@ -27,6 +27,7 @@
 #define MAP_HUGE_SHIFT	HUGETLB_FLAG_ENCODE_SHIFT
 #define MAP_HUGE_MASK	HUGETLB_FLAG_ENCODE_MASK
 
+#define MAP_HUGE_16KB	HUGETLB_FLAG_ENCODE_16KB
 #define MAP_HUGE_64KB	HUGETLB_FLAG_ENCODE_64KB
 #define MAP_HUGE_512KB	HUGETLB_FLAG_ENCODE_512KB
 #define MAP_HUGE_1MB	HUGETLB_FLAG_ENCODE_1MB
diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
index a90672494dc5..b92dcc4dafd5 100644
--- a/linux-headers/linux/vfio.h
+++ b/linux-headers/linux/vfio.h
@@ -201,8 +201,11 @@ struct vfio_device_info {
 #define VFIO_DEVICE_FLAGS_AMBA  (1 << 3)	/* vfio-amba device */
 #define VFIO_DEVICE_FLAGS_CCW	(1 << 4)	/* vfio-ccw device */
 #define VFIO_DEVICE_FLAGS_AP	(1 << 5)	/* vfio-ap device */
+#define VFIO_DEVICE_FLAGS_FSL_MC (1 << 6)	/* vfio-fsl-mc device */
+#define VFIO_DEVICE_FLAGS_CAPS	(1 << 7)	/* Info supports caps */
 	__u32	num_regions;	/* Max region index + 1 */
 	__u32	num_irqs;	/* Max IRQ index + 1 */
+	__u32   cap_offset;	/* Offset within info struct of first cap */
 };
 #define VFIO_DEVICE_GET_INFO		_IO(VFIO_TYPE, VFIO_BASE + 7)
 
@@ -218,6 +221,15 @@ struct vfio_device_info {
 #define VFIO_DEVICE_API_CCW_STRING		"vfio-ccw"
 #define VFIO_DEVICE_API_AP_STRING		"vfio-ap"
 
+/*
+ * The following capabilities are unique to s390 zPCI devices.  Their contents
+ * are further-defined in vfio_zdev.h
+ */
+#define VFIO_DEVICE_INFO_CAP_ZPCI_BASE		1
+#define VFIO_DEVICE_INFO_CAP_ZPCI_GROUP		2
+#define VFIO_DEVICE_INFO_CAP_ZPCI_UTIL		3
+#define VFIO_DEVICE_INFO_CAP_ZPCI_PFIP		4
+
 /**
  * VFIO_DEVICE_GET_REGION_INFO - _IOWR(VFIO_TYPE, VFIO_BASE + 8,
  *				       struct vfio_region_info)
@@ -462,7 +474,7 @@ struct vfio_region_gfx_edid {
  * 5. Resumed
  *                  |--------->|
  *
- * 0. Default state of VFIO device is _RUNNNG when the user application starts.
+ * 0. Default state of VFIO device is _RUNNING when the user application starts.
  * 1. During normal shutdown of the user application, the user application may
  *    optionally change the VFIO device state from _RUNNING to _STOP. This
  *    transition is optional. The vendor driver must support this transition but
@@ -1039,6 +1051,21 @@ struct vfio_iommu_type1_info_cap_migration {
 	__u64	max_dirty_bitmap_size;		/* in bytes */
 };
 
+/*
+ * The DMA available capability allows to report the current number of
+ * simultaneously outstanding DMA mappings that are allowed.
+ *
+ * The structure below defines version 1 of this capability.
+ *
+ * avail: specifies the current number of outstanding DMA mappings allowed.
+ */
+#define VFIO_IOMMU_TYPE1_INFO_DMA_AVAIL 3
+
+struct vfio_iommu_type1_info_dma_avail {
+	struct	vfio_info_cap_header header;
+	__u32	avail;
+};
+
 #define VFIO_IOMMU_GET_INFO _IO(VFIO_TYPE, VFIO_BASE + 12)
 
 /**
diff --git a/linux-headers/linux/vfio_zdev.h b/linux-headers/linux/vfio_zdev.h
new file mode 100644
index 000000000000..b4309397b6b2
--- /dev/null
+++ b/linux-headers/linux/vfio_zdev.h
@@ -0,0 +1,78 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * VFIO Region definitions for ZPCI devices
+ *
+ * Copyright IBM Corp. 2020
+ *
+ * Author(s): Pierre Morel <pmorel@linux.ibm.com>
+ *            Matthew Rosato <mjrosato@linux.ibm.com>
+ */
+
+#ifndef _VFIO_ZDEV_H_
+#define _VFIO_ZDEV_H_
+
+#include <linux/types.h>
+#include <linux/vfio.h>
+
+/**
+ * VFIO_DEVICE_INFO_CAP_ZPCI_BASE - Base PCI Function information
+ *
+ * This capability provides a set of descriptive information about the
+ * associated PCI function.
+ */
+struct vfio_device_info_cap_zpci_base {
+	struct vfio_info_cap_header header;
+	__u64 start_dma;	/* Start of available DMA addresses */
+	__u64 end_dma;		/* End of available DMA addresses */
+	__u16 pchid;		/* Physical Channel ID */
+	__u16 vfn;		/* Virtual function number */
+	__u16 fmb_length;	/* Measurement Block Length (in bytes) */
+	__u8 pft;		/* PCI Function Type */
+	__u8 gid;		/* PCI function group ID */
+};
+
+/**
+ * VFIO_DEVICE_INFO_CAP_ZPCI_GROUP - Base PCI Function Group information
+ *
+ * This capability provides a set of descriptive information about the group of
+ * PCI functions that the associated device belongs to.
+ */
+struct vfio_device_info_cap_zpci_group {
+	struct vfio_info_cap_header header;
+	__u64 dasm;		/* DMA Address space mask */
+	__u64 msi_addr;		/* MSI address */
+	__u64 flags;
+#define VFIO_DEVICE_INFO_ZPCI_FLAG_REFRESH 1 /* Program-specified TLB refresh */
+	__u16 mui;		/* Measurement Block Update Interval */
+	__u16 noi;		/* Maximum number of MSIs */
+	__u16 maxstbl;		/* Maximum Store Block Length */
+	__u8 version;		/* Supported PCI Version */
+};
+
+/**
+ * VFIO_DEVICE_INFO_CAP_ZPCI_UTIL - Utility String
+ *
+ * This capability provides the utility string for the associated device, which
+ * is a device identifier string made up of EBCDID characters.  'size' specifies
+ * the length of 'util_str'.
+ */
+struct vfio_device_info_cap_zpci_util {
+	struct vfio_info_cap_header header;
+	__u32 size;
+	__u8 util_str[];
+};
+
+/**
+ * VFIO_DEVICE_INFO_CAP_ZPCI_PFIP - PCI Function Path
+ *
+ * This capability provides the PCI function path string, which is an identifier
+ * that describes the internal hardware path of the device. 'size' specifies
+ * the length of 'pfip'.
+ */
+struct vfio_device_info_cap_zpci_pfip {
+	struct vfio_info_cap_header header;
+	__u32 size;
+	__u8 pfip[];
+};
+
+#endif


