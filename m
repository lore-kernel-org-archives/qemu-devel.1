Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FUZZY_XPILL,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B35C8300C
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 09:48:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 196122082E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 09:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CveAW25e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 196122082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU5nu-000454-7p
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 05:48:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48760)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jU5kg-0005dH-CP
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 05:45:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jU5ke-0002sy-Qh
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 05:45:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53396
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jU5ke-0002sj-9v
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 05:45:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588239903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s6YU3FokAn9UczW+IP3uAnPSyDUSbEhylqHPTvp+r7w=;
 b=CveAW25ex0mCXQ4/deeQKvJNU21WNXhmrvk5MtY/gooOoYrP849/z/6q4yJe5HydDpoF20
 KZDYXKT1jnnIf3pm5CEyqh1hQf747Hwm7INGPTamEQUXsOuxYOFj7YCnzwoqGwCZrVt4bg
 iHkaGvJSsVkYOeGuXt2gvqL3BJn8iJc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-wqlGCy3rNCaJVFb7t2q0ow-1; Thu, 30 Apr 2020 05:45:00 -0400
X-MC-Unique: wqlGCy3rNCaJVFb7t2q0ow-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E8677835B46;
 Thu, 30 Apr 2020 09:44:59 +0000 (UTC)
Received: from localhost (ovpn-112-226.ams2.redhat.com [10.36.112.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B5C875117E;
 Thu, 30 Apr 2020 09:44:56 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 02/20] linux-headers: update against Linux 5.7-rc3
Date: Thu, 30 Apr 2020 11:44:27 +0200
Message-Id: <20200430094445.25943-3-cohuck@redhat.com>
In-Reply-To: <20200430094445.25943-1-cohuck@redhat.com>
References: <20200430094445.25943-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 01:24:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

commit 6a8b55ed4056ea5559ebe4f6a4b247f627870d4c

Reviewed-by: Michael S. Tsirkin <mst@redhat.com> # virtio/vhost parts
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <20200427102415.10915-3-cohuck@redhat.com>
---
 include/standard-headers/linux/ethtool.h      |  10 +-
 .../linux/input-event-codes.h                 |   5 +-
 include/standard-headers/linux/pci_regs.h     |   2 +
 include/standard-headers/linux/vhost_types.h  |   8 ++
 .../standard-headers/linux/virtio_balloon.h   |  12 ++-
 include/standard-headers/linux/virtio_ids.h   |   1 +
 include/standard-headers/linux/virtio_net.h   | 102 +++++++++++++++++-
 linux-headers/COPYING                         |   2 +
 linux-headers/asm-x86/kvm.h                   |   1 +
 linux-headers/asm-x86/unistd_32.h             |   1 +
 linux-headers/asm-x86/unistd_64.h             |   1 +
 linux-headers/asm-x86/unistd_x32.h            |   1 +
 linux-headers/linux/kvm.h                     |  47 +++++++-
 linux-headers/linux/mman.h                    |   5 +-
 linux-headers/linux/userfaultfd.h             |  40 +++++--
 linux-headers/linux/vfio.h                    |  37 +++++++
 linux-headers/linux/vhost.h                   |  24 +++++
 17 files changed, 280 insertions(+), 19 deletions(-)

diff --git a/include/standard-headers/linux/ethtool.h b/include/standard-he=
aders/linux/ethtool.h
index 8adf3b018b95..1200890c8608 100644
--- a/include/standard-headers/linux/ethtool.h
+++ b/include/standard-headers/linux/ethtool.h
@@ -596,6 +596,9 @@ struct ethtool_pauseparam {
  * @ETH_SS_LINK_MODES: link mode names
  * @ETH_SS_MSG_CLASSES: debug message class names
  * @ETH_SS_WOL_MODES: wake-on-lan modes
+ * @ETH_SS_SOF_TIMESTAMPING: SOF_TIMESTAMPING_* flags
+ * @ETH_SS_TS_TX_TYPES: timestamping Tx types
+ * @ETH_SS_TS_RX_FILTERS: timestamping Rx filters
  */
 enum ethtool_stringset {
 =09ETH_SS_TEST=09=09=3D 0,
@@ -610,6 +613,9 @@ enum ethtool_stringset {
 =09ETH_SS_LINK_MODES,
 =09ETH_SS_MSG_CLASSES,
 =09ETH_SS_WOL_MODES,
+=09ETH_SS_SOF_TIMESTAMPING,
+=09ETH_SS_TS_TX_TYPES,
+=09ETH_SS_TS_RX_FILTERS,
=20
 =09/* add new constants above here */
 =09ETH_SS_COUNT
@@ -1330,6 +1336,7 @@ enum ethtool_fec_config_bits {
 =09ETHTOOL_FEC_OFF_BIT,
 =09ETHTOOL_FEC_RS_BIT,
 =09ETHTOOL_FEC_BASER_BIT,
+=09ETHTOOL_FEC_LLRS_BIT,
 };
=20
 #define ETHTOOL_FEC_NONE=09=09(1 << ETHTOOL_FEC_NONE_BIT)
@@ -1337,6 +1344,7 @@ enum ethtool_fec_config_bits {
 #define ETHTOOL_FEC_OFF=09=09=09(1 << ETHTOOL_FEC_OFF_BIT)
 #define ETHTOOL_FEC_RS=09=09=09(1 << ETHTOOL_FEC_RS_BIT)
 #define ETHTOOL_FEC_BASER=09=09(1 << ETHTOOL_FEC_BASER_BIT)
+#define ETHTOOL_FEC_LLRS=09=09(1 << ETHTOOL_FEC_LLRS_BIT)
=20
 /* CMDs currently supported */
 #define ETHTOOL_GSET=09=090x00000001 /* DEPRECATED, Get settings.
@@ -1521,7 +1529,7 @@ enum ethtool_link_mode_bit_indices {
 =09ETHTOOL_LINK_MODE_400000baseLR8_ER8_FR8_Full_BIT =3D 71,
 =09ETHTOOL_LINK_MODE_400000baseDR8_Full_BIT=09 =3D 72,
 =09ETHTOOL_LINK_MODE_400000baseCR8_Full_BIT=09 =3D 73,
-
+=09ETHTOOL_LINK_MODE_FEC_LLRS_BIT=09=09=09 =3D 74,
 =09/* must be last entry */
 =09__ETHTOOL_LINK_MODE_MASK_NBITS
 };
diff --git a/include/standard-headers/linux/input-event-codes.h b/include/s=
tandard-headers/linux/input-event-codes.h
index b484c252897f..ebf72c10317b 100644
--- a/include/standard-headers/linux/input-event-codes.h
+++ b/include/standard-headers/linux/input-event-codes.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
 /*
  * Input event codes
  *
@@ -652,6 +652,9 @@
 /* Electronic privacy screen control */
 #define KEY_PRIVACY_SCREEN_TOGGLE=090x279
=20
+/* Select an area of screen to be copied */
+#define KEY_SELECTIVE_SCREENSHOT=090x27a
+
 /*
  * Some keyboards have keys which do not have a defined meaning, these key=
s
  * are intended to be programmed / bound to macros by the user. For most
diff --git a/include/standard-headers/linux/pci_regs.h b/include/standard-h=
eaders/linux/pci_regs.h
index 5437690483cd..f9701410d3b5 100644
--- a/include/standard-headers/linux/pci_regs.h
+++ b/include/standard-headers/linux/pci_regs.h
@@ -605,6 +605,7 @@
 #define  PCI_EXP_SLTCTL_PWR_OFF        0x0400 /* Power Off */
 #define  PCI_EXP_SLTCTL_EIC=090x0800=09/* Electromechanical Interlock Cont=
rol */
 #define  PCI_EXP_SLTCTL_DLLSCE=090x1000=09/* Data Link Layer State Changed=
 Enable */
+#define  PCI_EXP_SLTCTL_IBPD_DISABLE=090x4000 /* In-band PD disable */
 #define PCI_EXP_SLTSTA=09=0926=09/* Slot Status */
 #define  PCI_EXP_SLTSTA_ABP=090x0001=09/* Attention Button Pressed */
 #define  PCI_EXP_SLTSTA_PFD=090x0002=09/* Power Fault Detected */
@@ -680,6 +681,7 @@
 #define PCI_EXP_LNKSTA2=09=0950=09/* Link Status 2 */
 #define PCI_CAP_EXP_ENDPOINT_SIZEOF_V2=0952=09/* v2 endpoints with link en=
d here */
 #define PCI_EXP_SLTCAP2=09=0952=09/* Slot Capabilities 2 */
+#define  PCI_EXP_SLTCAP2_IBPD=090x00000001 /* In-band PD Disable Supported=
 */
 #define PCI_EXP_SLTCTL2=09=0956=09/* Slot Control 2 */
 #define PCI_EXP_SLTSTA2=09=0958=09/* Slot Status 2 */
=20
diff --git a/include/standard-headers/linux/vhost_types.h b/include/standar=
d-headers/linux/vhost_types.h
index 5351fe172d7e..a678d8fbaa92 100644
--- a/include/standard-headers/linux/vhost_types.h
+++ b/include/standard-headers/linux/vhost_types.h
@@ -119,6 +119,14 @@ struct vhost_scsi_target {
 =09unsigned short reserved;
 };
=20
+/* VHOST_VDPA specific definitions */
+
+struct vhost_vdpa_config {
+=09uint32_t off;
+=09uint32_t len;
+=09uint8_t buf[0];
+};
+
 /* Feature bits */
 /* Log all write descriptors. Can be changed while device is active. */
 #define VHOST_F_LOG_ALL 26
diff --git a/include/standard-headers/linux/virtio_balloon.h b/include/stan=
dard-headers/linux/virtio_balloon.h
index 9375ca2a70de..f343bfefd82c 100644
--- a/include/standard-headers/linux/virtio_balloon.h
+++ b/include/standard-headers/linux/virtio_balloon.h
@@ -36,6 +36,7 @@
 #define VIRTIO_BALLOON_F_DEFLATE_ON_OOM=092 /* Deflate balloon on OOM */
 #define VIRTIO_BALLOON_F_FREE_PAGE_HINT=093 /* VQ to report free pages */
 #define VIRTIO_BALLOON_F_PAGE_POISON=094 /* Guest is using page poisoning =
*/
+#define VIRTIO_BALLOON_F_REPORTING=095 /* Page reporting virtqueue */
=20
 /* Size of a PFN in the balloon interface. */
 #define VIRTIO_BALLOON_PFN_SHIFT 12
@@ -47,8 +48,15 @@ struct virtio_balloon_config {
 =09uint32_t num_pages;
 =09/* Number of pages we've actually got in balloon. */
 =09uint32_t actual;
-=09/* Free page report command id, readonly by guest */
-=09uint32_t free_page_report_cmd_id;
+=09/*
+=09 * Free page hint command id, readonly by guest.
+=09 * Was previously named free_page_report_cmd_id so we
+=09 * need to carry that name for legacy support.
+=09 */
+=09union {
+=09=09uint32_t free_page_hint_cmd_id;
+=09=09uint32_t free_page_report_cmd_id;=09/* deprecated */
+=09};
 =09/* Stores PAGE_POISON if page poisoning is in use */
 =09uint32_t poison_val;
 };
diff --git a/include/standard-headers/linux/virtio_ids.h b/include/standard=
-headers/linux/virtio_ids.h
index 585e07b27333..ecc27a17401a 100644
--- a/include/standard-headers/linux/virtio_ids.h
+++ b/include/standard-headers/linux/virtio_ids.h
@@ -46,5 +46,6 @@
 #define VIRTIO_ID_IOMMU        23 /* virtio IOMMU */
 #define VIRTIO_ID_FS           26 /* virtio filesystem */
 #define VIRTIO_ID_PMEM         27 /* virtio pmem */
+#define VIRTIO_ID_MAC80211_HWSIM 29 /* virtio mac80211-hwsim */
=20
 #endif /* _LINUX_VIRTIO_IDS_H */
diff --git a/include/standard-headers/linux/virtio_net.h b/include/standard=
-headers/linux/virtio_net.h
index 260c3681d70d..a90f79e1b17a 100644
--- a/include/standard-headers/linux/virtio_net.h
+++ b/include/standard-headers/linux/virtio_net.h
@@ -57,6 +57,9 @@
 =09=09=09=09=09 * Steering */
 #define VIRTIO_NET_F_CTRL_MAC_ADDR 23=09/* Set MAC address */
=20
+#define VIRTIO_NET_F_HASH_REPORT  57=09/* Supports hash report */
+#define VIRTIO_NET_F_RSS=09  60=09/* Supports RSS RX steering */
+#define VIRTIO_NET_F_RSC_EXT=09  61=09/* extended coalescing info */
 #define VIRTIO_NET_F_STANDBY=09  62=09/* Act as standby for another device
 =09=09=09=09=09 * with the same MAC.
 =09=09=09=09=09 */
@@ -69,6 +72,17 @@
 #define VIRTIO_NET_S_LINK_UP=091=09/* Link is up */
 #define VIRTIO_NET_S_ANNOUNCE=092=09/* Announcement is needed */
=20
+/* supported/enabled hash types */
+#define VIRTIO_NET_RSS_HASH_TYPE_IPv4          (1 << 0)
+#define VIRTIO_NET_RSS_HASH_TYPE_TCPv4         (1 << 1)
+#define VIRTIO_NET_RSS_HASH_TYPE_UDPv4         (1 << 2)
+#define VIRTIO_NET_RSS_HASH_TYPE_IPv6          (1 << 3)
+#define VIRTIO_NET_RSS_HASH_TYPE_TCPv6         (1 << 4)
+#define VIRTIO_NET_RSS_HASH_TYPE_UDPv6         (1 << 5)
+#define VIRTIO_NET_RSS_HASH_TYPE_IP_EX         (1 << 6)
+#define VIRTIO_NET_RSS_HASH_TYPE_TCP_EX        (1 << 7)
+#define VIRTIO_NET_RSS_HASH_TYPE_UDP_EX        (1 << 8)
+
 struct virtio_net_config {
 =09/* The config defining mac address (if VIRTIO_NET_F_MAC) */
 =09uint8_t mac[ETH_ALEN];
@@ -92,6 +106,12 @@ struct virtio_net_config {
 =09 * Any other value stands for unknown.
 =09 */
 =09uint8_t duplex;
+=09/* maximum size of RSS key */
+=09uint8_t rss_max_key_size;
+=09/* maximum number of indirection table entries */
+=09uint16_t rss_max_indirection_table_length;
+=09/* bitmask of supported VIRTIO_NET_RSS_HASH_ types */
+=09uint32_t supported_hash_types;
 } QEMU_PACKED;
=20
 /*
@@ -104,6 +124,7 @@ struct virtio_net_config {
 struct virtio_net_hdr_v1 {
 #define VIRTIO_NET_HDR_F_NEEDS_CSUM=091=09/* Use csum_start, csum_offset *=
/
 #define VIRTIO_NET_HDR_F_DATA_VALID=092=09/* Csum is valid */
+#define VIRTIO_NET_HDR_F_RSC_INFO=094=09/* rsc info in csum_ fields */
 =09uint8_t flags;
 #define VIRTIO_NET_HDR_GSO_NONE=09=090=09/* Not a GSO frame */
 #define VIRTIO_NET_HDR_GSO_TCPV4=091=09/* GSO frame, IPv4 TCP (TSO) */
@@ -113,11 +134,46 @@ struct virtio_net_hdr_v1 {
 =09uint8_t gso_type;
 =09__virtio16 hdr_len;=09/* Ethernet + IP + tcp/udp hdrs */
 =09__virtio16 gso_size;=09/* Bytes to append to hdr_len per frame */
-=09__virtio16 csum_start;=09/* Position to start checksumming from */
-=09__virtio16 csum_offset;=09/* Offset after that to place checksum */
+=09union {
+=09=09struct {
+=09=09=09__virtio16 csum_start;
+=09=09=09__virtio16 csum_offset;
+=09=09};
+=09=09/* Checksum calculation */
+=09=09struct {
+=09=09=09/* Position to start checksumming from */
+=09=09=09__virtio16 start;
+=09=09=09/* Offset after that to place checksum */
+=09=09=09__virtio16 offset;
+=09=09} csum;
+=09=09/* Receive Segment Coalescing */
+=09=09struct {
+=09=09=09/* Number of coalesced segments */
+=09=09=09uint16_t segments;
+=09=09=09/* Number of duplicated acks */
+=09=09=09uint16_t dup_acks;
+=09=09} rsc;
+=09};
 =09__virtio16 num_buffers;=09/* Number of merged rx buffers */
 };
=20
+struct virtio_net_hdr_v1_hash {
+=09struct virtio_net_hdr_v1 hdr;
+=09uint32_t hash_value;
+#define VIRTIO_NET_HASH_REPORT_NONE            0
+#define VIRTIO_NET_HASH_REPORT_IPv4            1
+#define VIRTIO_NET_HASH_REPORT_TCPv4           2
+#define VIRTIO_NET_HASH_REPORT_UDPv4           3
+#define VIRTIO_NET_HASH_REPORT_IPv6            4
+#define VIRTIO_NET_HASH_REPORT_TCPv6           5
+#define VIRTIO_NET_HASH_REPORT_UDPv6           6
+#define VIRTIO_NET_HASH_REPORT_IPv6_EX         7
+#define VIRTIO_NET_HASH_REPORT_TCPv6_EX        8
+#define VIRTIO_NET_HASH_REPORT_UDPv6_EX        9
+=09uint16_t hash_report;
+=09uint16_t padding;
+};
+
 #ifndef VIRTIO_NET_NO_LEGACY
 /* This header comes first in the scatter-gather list.
  * For legacy virtio, if VIRTIO_F_ANY_LAYOUT is not negotiated, it must
@@ -228,7 +284,9 @@ struct virtio_net_ctrl_mac {
=20
 /*
  * Control Receive Flow Steering
- *
+ */
+#define VIRTIO_NET_CTRL_MQ   4
+/*
  * The command VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET
  * enables Receive Flow Steering, specifying the number of the transmit an=
d
  * receive queues that will be used. After the command is consumed and ack=
ed by
@@ -241,11 +299,47 @@ struct virtio_net_ctrl_mq {
 =09__virtio16 virtqueue_pairs;
 };
=20
-#define VIRTIO_NET_CTRL_MQ   4
  #define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET        0
  #define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MIN        1
  #define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MAX        0x8000
=20
+/*
+ * The command VIRTIO_NET_CTRL_MQ_RSS_CONFIG has the same effect as
+ * VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET does and additionally configures
+ * the receive steering to use a hash calculated for incoming packet
+ * to decide on receive virtqueue to place the packet. The command
+ * also provides parameters to calculate a hash and receive virtqueue.
+ */
+struct virtio_net_rss_config {
+=09uint32_t hash_types;
+=09uint16_t indirection_table_mask;
+=09uint16_t unclassified_queue;
+=09uint16_t indirection_table[1/* + indirection_table_mask */];
+=09uint16_t max_tx_vq;
+=09uint8_t hash_key_length;
+=09uint8_t hash_key_data[/* hash_key_length */];
+};
+
+ #define VIRTIO_NET_CTRL_MQ_RSS_CONFIG          1
+
+/*
+ * The command VIRTIO_NET_CTRL_MQ_HASH_CONFIG requests the device
+ * to include in the virtio header of the packet the value of the
+ * calculated hash and the report type of hash. It also provides
+ * parameters for hash calculation. The command requires feature
+ * VIRTIO_NET_F_HASH_REPORT to be negotiated to extend the
+ * layout of virtio header as defined in virtio_net_hdr_v1_hash.
+ */
+struct virtio_net_hash_config {
+=09uint32_t hash_types;
+=09/* for compatibility with virtio_net_rss_config */
+=09uint16_t reserved[4];
+=09uint8_t hash_key_length;
+=09uint8_t hash_key_data[/* hash_key_length */];
+};
+
+ #define VIRTIO_NET_CTRL_MQ_HASH_CONFIG         2
+
 /*
  * Control network offloads
  *
diff --git a/linux-headers/COPYING b/linux-headers/COPYING
index da4cb28febe6..a635a38ef940 100644
--- a/linux-headers/COPYING
+++ b/linux-headers/COPYING
@@ -16,3 +16,5 @@ In addition, other licenses may also apply. Please see:
 =09Documentation/process/license-rules.rst
=20
 for more details.
+
+All contributions to the Linux Kernel are subject to this COPYING file.
diff --git a/linux-headers/asm-x86/kvm.h b/linux-headers/asm-x86/kvm.h
index 503d3f42da16..3f3f780c8c65 100644
--- a/linux-headers/asm-x86/kvm.h
+++ b/linux-headers/asm-x86/kvm.h
@@ -390,6 +390,7 @@ struct kvm_sync_regs {
 #define KVM_STATE_NESTED_GUEST_MODE=090x00000001
 #define KVM_STATE_NESTED_RUN_PENDING=090x00000002
 #define KVM_STATE_NESTED_EVMCS=09=090x00000004
+#define KVM_STATE_NESTED_MTF_PENDING=090x00000008
=20
 #define KVM_STATE_NESTED_SMM_GUEST_MODE=090x00000001
 #define KVM_STATE_NESTED_SMM_VMXON=090x00000002
diff --git a/linux-headers/asm-x86/unistd_32.h b/linux-headers/asm-x86/unis=
td_32.h
index f6e06fcfbdcf..1e6c1a586776 100644
--- a/linux-headers/asm-x86/unistd_32.h
+++ b/linux-headers/asm-x86/unistd_32.h
@@ -429,4 +429,5 @@
 #define __NR_openat2 437
 #define __NR_pidfd_getfd 438
=20
+
 #endif /* _ASM_X86_UNISTD_32_H */
diff --git a/linux-headers/asm-x86/unistd_64.h b/linux-headers/asm-x86/unis=
td_64.h
index 924f826d2d48..6daf0aecb298 100644
--- a/linux-headers/asm-x86/unistd_64.h
+++ b/linux-headers/asm-x86/unistd_64.h
@@ -351,4 +351,5 @@
 #define __NR_openat2 437
 #define __NR_pidfd_getfd 438
=20
+
 #endif /* _ASM_X86_UNISTD_64_H */
diff --git a/linux-headers/asm-x86/unistd_x32.h b/linux-headers/asm-x86/uni=
std_x32.h
index 010307757b1b..e3f17ef370fc 100644
--- a/linux-headers/asm-x86/unistd_x32.h
+++ b/linux-headers/asm-x86/unistd_x32.h
@@ -340,4 +340,5 @@
 #define __NR_preadv2 (__X32_SYSCALL_BIT + 546)
 #define __NR_pwritev2 (__X32_SYSCALL_BIT + 547)
=20
+
 #endif /* _ASM_X86_UNISTD_X32_H */
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index 265099100e65..9804495a46c5 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -474,12 +474,17 @@ struct kvm_s390_mem_op {
 =09__u32 size;=09=09/* amount of bytes */
 =09__u32 op;=09=09/* type of operation */
 =09__u64 buf;=09=09/* buffer in userspace */
-=09__u8 ar;=09=09/* the access register number */
-=09__u8 reserved[31];=09/* should be set to 0 */
+=09union {
+=09=09__u8 ar;=09/* the access register number */
+=09=09__u32 sida_offset; /* offset into the sida */
+=09=09__u8 reserved[32]; /* should be set to 0 */
+=09};
 };
 /* types for kvm_s390_mem_op->op */
 #define KVM_S390_MEMOP_LOGICAL_READ=090
 #define KVM_S390_MEMOP_LOGICAL_WRITE=091
+#define KVM_S390_MEMOP_SIDA_READ=092
+#define KVM_S390_MEMOP_SIDA_WRITE=093
 /* flags for kvm_s390_mem_op->flags */
 #define KVM_S390_MEMOP_F_CHECK_ONLY=09=09(1ULL << 0)
 #define KVM_S390_MEMOP_F_INJECT_EXCEPTION=09(1ULL << 1)
@@ -1010,6 +1015,8 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_ARM_NISV_TO_USER 177
 #define KVM_CAP_ARM_INJECT_EXT_DABT 178
 #define KVM_CAP_S390_VCPU_RESETS 179
+#define KVM_CAP_S390_PROTECTED 180
+#define KVM_CAP_PPC_SECURE_GUEST 181
=20
 #ifdef KVM_CAP_IRQ_ROUTING
=20
@@ -1478,6 +1485,39 @@ struct kvm_enc_region {
 #define KVM_S390_NORMAL_RESET=09_IO(KVMIO,   0xc3)
 #define KVM_S390_CLEAR_RESET=09_IO(KVMIO,   0xc4)
=20
+struct kvm_s390_pv_sec_parm {
+=09__u64 origin;
+=09__u64 length;
+};
+
+struct kvm_s390_pv_unp {
+=09__u64 addr;
+=09__u64 size;
+=09__u64 tweak;
+};
+
+enum pv_cmd_id {
+=09KVM_PV_ENABLE,
+=09KVM_PV_DISABLE,
+=09KVM_PV_SET_SEC_PARMS,
+=09KVM_PV_UNPACK,
+=09KVM_PV_VERIFY,
+=09KVM_PV_PREP_RESET,
+=09KVM_PV_UNSHARE_ALL,
+};
+
+struct kvm_pv_cmd {
+=09__u32 cmd;=09/* Command to be executed */
+=09__u16 rc;=09/* Ultravisor return code */
+=09__u16 rrc;=09/* Ultravisor return reason code */
+=09__u64 data;=09/* Data or address */
+=09__u32 flags;    /* flags for future extensions. Must be 0 for now */
+=09__u32 reserved[3];
+};
+
+/* Available with KVM_CAP_S390_PROTECTED */
+#define KVM_S390_PV_COMMAND=09=09_IOWR(KVMIO, 0xc5, struct kvm_pv_cmd)
+
 /* Secure Encrypted Virtualization command */
 enum sev_cmd_id {
 =09/* Guest initialization commands */
@@ -1628,4 +1668,7 @@ struct kvm_hyperv_eventfd {
 #define KVM_HYPERV_CONN_ID_MASK=09=090x00ffffff
 #define KVM_HYPERV_EVENTFD_DEASSIGN=09(1 << 0)
=20
+#define KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE    (1 << 0)
+#define KVM_DIRTY_LOG_INITIALLY_SET            (1 << 1)
+
 #endif /* __LINUX_KVM_H */
diff --git a/linux-headers/linux/mman.h b/linux-headers/linux/mman.h
index 1f6e2cd89ccb..51ea363759f0 100644
--- a/linux-headers/linux/mman.h
+++ b/linux-headers/linux/mman.h
@@ -5,8 +5,9 @@
 #include <asm/mman.h>
 #include <asm-generic/hugetlb_encode.h>
=20
-#define MREMAP_MAYMOVE=091
-#define MREMAP_FIXED=092
+#define MREMAP_MAYMOVE=09=091
+#define MREMAP_FIXED=09=092
+#define MREMAP_DONTUNMAP=094
=20
 #define OVERCOMMIT_GUESS=09=090
 #define OVERCOMMIT_ALWAYS=09=091
diff --git a/linux-headers/linux/userfaultfd.h b/linux-headers/linux/userfa=
ultfd.h
index ce78878d127e..8d3996eb8285 100644
--- a/linux-headers/linux/userfaultfd.h
+++ b/linux-headers/linux/userfaultfd.h
@@ -19,7 +19,8 @@
  * means the userland is reading).
  */
 #define UFFD_API ((__u64)0xAA)
-#define UFFD_API_FEATURES (UFFD_FEATURE_EVENT_FORK |=09=09\
+#define UFFD_API_FEATURES (UFFD_FEATURE_PAGEFAULT_FLAG_WP |=09\
+=09=09=09   UFFD_FEATURE_EVENT_FORK |=09=09\
 =09=09=09   UFFD_FEATURE_EVENT_REMAP |=09=09\
 =09=09=09   UFFD_FEATURE_EVENT_REMOVE |=09\
 =09=09=09   UFFD_FEATURE_EVENT_UNMAP |=09=09\
@@ -34,7 +35,8 @@
 #define UFFD_API_RANGE_IOCTLS=09=09=09\
 =09((__u64)1 << _UFFDIO_WAKE |=09=09\
 =09 (__u64)1 << _UFFDIO_COPY |=09=09\
-=09 (__u64)1 << _UFFDIO_ZEROPAGE)
+=09 (__u64)1 << _UFFDIO_ZEROPAGE |=09=09\
+=09 (__u64)1 << _UFFDIO_WRITEPROTECT)
 #define UFFD_API_RANGE_IOCTLS_BASIC=09=09\
 =09((__u64)1 << _UFFDIO_WAKE |=09=09\
 =09 (__u64)1 << _UFFDIO_COPY)
@@ -52,6 +54,7 @@
 #define _UFFDIO_WAKE=09=09=09(0x02)
 #define _UFFDIO_COPY=09=09=09(0x03)
 #define _UFFDIO_ZEROPAGE=09=09(0x04)
+#define _UFFDIO_WRITEPROTECT=09=09(0x06)
 #define _UFFDIO_API=09=09=09(0x3F)
=20
 /* userfaultfd ioctl ids */
@@ -68,6 +71,8 @@
 =09=09=09=09      struct uffdio_copy)
 #define UFFDIO_ZEROPAGE=09=09_IOWR(UFFDIO, _UFFDIO_ZEROPAGE,=09\
 =09=09=09=09      struct uffdio_zeropage)
+#define UFFDIO_WRITEPROTECT=09_IOWR(UFFDIO, _UFFDIO_WRITEPROTECT, \
+=09=09=09=09      struct uffdio_writeprotect)
=20
 /* read() structure */
 struct uffd_msg {
@@ -203,13 +208,14 @@ struct uffdio_copy {
 =09__u64 dst;
 =09__u64 src;
 =09__u64 len;
+#define UFFDIO_COPY_MODE_DONTWAKE=09=09((__u64)1<<0)
 =09/*
-=09 * There will be a wrprotection flag later that allows to map
-=09 * pages wrprotected on the fly. And such a flag will be
-=09 * available if the wrprotection ioctl are implemented for the
-=09 * range according to the uffdio_register.ioctls.
+=09 * UFFDIO_COPY_MODE_WP will map the page write protected on
+=09 * the fly.  UFFDIO_COPY_MODE_WP is available only if the
+=09 * write protected ioctl is implemented for the range
+=09 * according to the uffdio_register.ioctls.
 =09 */
-#define UFFDIO_COPY_MODE_DONTWAKE=09=09((__u64)1<<0)
+#define UFFDIO_COPY_MODE_WP=09=09=09((__u64)1<<1)
 =09__u64 mode;
=20
 =09/*
@@ -231,4 +237,24 @@ struct uffdio_zeropage {
 =09__s64 zeropage;
 };
=20
+struct uffdio_writeprotect {
+=09struct uffdio_range range;
+/*
+ * UFFDIO_WRITEPROTECT_MODE_WP: set the flag to write protect a range,
+ * unset the flag to undo protection of a range which was previously
+ * write protected.
+ *
+ * UFFDIO_WRITEPROTECT_MODE_DONTWAKE: set the flag to avoid waking up
+ * any wait thread after the operation succeeds.
+ *
+ * NOTE: Write protecting a region (WP=3D1) is unrelated to page faults,
+ * therefore DONTWAKE flag is meaningless with WP=3D1.  Removing write
+ * protection (WP=3D0) in response to a page fault wakes the faulting
+ * task unless DONTWAKE is set.
+ */
+#define UFFDIO_WRITEPROTECT_MODE_WP=09=09((__u64)1<<0)
+#define UFFDIO_WRITEPROTECT_MODE_DONTWAKE=09((__u64)1<<1)
+=09__u64 mode;
+};
+
 #endif /* _LINUX_USERFAULTFD_H */
diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
index fb10370d2928..a41c45286511 100644
--- a/linux-headers/linux/vfio.h
+++ b/linux-headers/linux/vfio.h
@@ -707,6 +707,43 @@ struct vfio_device_ioeventfd {
=20
 #define VFIO_DEVICE_IOEVENTFD=09=09_IO(VFIO_TYPE, VFIO_BASE + 16)
=20
+/**
+ * VFIO_DEVICE_FEATURE - _IORW(VFIO_TYPE, VFIO_BASE + 17,
+ *=09=09=09       struct vfio_device_feature)
+ *
+ * Get, set, or probe feature data of the device.  The feature is selected
+ * using the FEATURE_MASK portion of the flags field.  Support for a featu=
re
+ * can be probed by setting both the FEATURE_MASK and PROBE bits.  A probe
+ * may optionally include the GET and/or SET bits to determine read vs wri=
te
+ * access of the feature respectively.  Probing a feature will return succ=
ess
+ * if the feature is supported and all of the optionally indicated GET/SET
+ * methods are supported.  The format of the data portion of the structure=
 is
+ * specific to the given feature.  The data portion is not required for
+ * probing.  GET and SET are mutually exclusive, except for use with PROBE=
.
+ *
+ * Return 0 on success, -errno on failure.
+ */
+struct vfio_device_feature {
+=09__u32=09argsz;
+=09__u32=09flags;
+#define VFIO_DEVICE_FEATURE_MASK=09(0xffff) /* 16-bit feature index */
+#define VFIO_DEVICE_FEATURE_GET=09=09(1 << 16) /* Get feature into data[] =
*/
+#define VFIO_DEVICE_FEATURE_SET=09=09(1 << 17) /* Set feature from data[] =
*/
+#define VFIO_DEVICE_FEATURE_PROBE=09(1 << 18) /* Probe feature support */
+=09__u8=09data[];
+};
+
+#define VFIO_DEVICE_FEATURE=09=09_IO(VFIO_TYPE, VFIO_BASE + 17)
+
+/*
+ * Provide support for setting a PCI VF Token, which is used as a shared
+ * secret between PF and VF drivers.  This feature may only be set on a
+ * PCI SR-IOV PF when SR-IOV is enabled on the PF and there are no existin=
g
+ * open VFs.  Data provided when setting this feature is a 16-byte array
+ * (__u8 b[16]), representing a UUID.
+ */
+#define VFIO_DEVICE_FEATURE_PCI_VF_TOKEN=09(0)
+
 /* -------- API for Type1 VFIO IOMMU -------- */
=20
 /**
diff --git a/linux-headers/linux/vhost.h b/linux-headers/linux/vhost.h
index 40d028eed645..9fe72e4b1373 100644
--- a/linux-headers/linux/vhost.h
+++ b/linux-headers/linux/vhost.h
@@ -116,4 +116,28 @@
 #define VHOST_VSOCK_SET_GUEST_CID=09_IOW(VHOST_VIRTIO, 0x60, __u64)
 #define VHOST_VSOCK_SET_RUNNING=09=09_IOW(VHOST_VIRTIO, 0x61, int)
=20
+/* VHOST_VDPA specific defines */
+
+/* Get the device id. The device ids follow the same definition of
+ * the device id defined in virtio-spec.
+ */
+#define VHOST_VDPA_GET_DEVICE_ID=09_IOR(VHOST_VIRTIO, 0x70, __u32)
+/* Get and set the status. The status bits follow the same definition
+ * of the device status defined in virtio-spec.
+ */
+#define VHOST_VDPA_GET_STATUS=09=09_IOR(VHOST_VIRTIO, 0x71, __u8)
+#define VHOST_VDPA_SET_STATUS=09=09_IOW(VHOST_VIRTIO, 0x72, __u8)
+/* Get and set the device config. The device config follows the same
+ * definition of the device config defined in virtio-spec.
+ */
+#define VHOST_VDPA_GET_CONFIG=09=09_IOR(VHOST_VIRTIO, 0x73, \
+=09=09=09=09=09     struct vhost_vdpa_config)
+#define VHOST_VDPA_SET_CONFIG=09=09_IOW(VHOST_VIRTIO, 0x74, \
+=09=09=09=09=09     struct vhost_vdpa_config)
+/* Enable/disable the ring. */
+#define VHOST_VDPA_SET_VRING_ENABLE=09_IOW(VHOST_VIRTIO, 0x75, \
+=09=09=09=09=09     struct vhost_vring_state)
+/* Get the max ring size. */
+#define VHOST_VDPA_GET_VRING_NUM=09_IOR(VHOST_VIRTIO, 0x76, __u16)
+
 #endif
--=20
2.21.1


