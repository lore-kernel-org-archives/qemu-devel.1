Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8392C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 00:50:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F1A52065D
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 00:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="gAo0QoD3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F1A52065D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpi0E-0005cp-8r
	for qemu-devel@archiver.kernel.org; Sun, 28 Jun 2020 20:50:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60132)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1jphyw-0004m9-BK
 for qemu-devel@nongnu.org; Sun, 28 Jun 2020 20:49:10 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:43843)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1jphyu-0007FG-7A
 for qemu-devel@nongnu.org; Sun, 28 Jun 2020 20:49:10 -0400
Received: by mail-lj1-x244.google.com with SMTP id f5so248381ljj.10
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2020 17:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jqJZeEeODTZpGezAbssGAbOQs8PcxVkd2UIqFtiZtjM=;
 b=gAo0QoD3EXUbhmzDobVvRlXOjDk515bf7W4ZNSY8w37yo2jzQFKgDJ2kpAV3l5EUeu
 VKEoL4F6V2OtvmasGO2tcvYgP0utAD5XQd/l+ly6rGc0QJEsCeYZPf3hVdM+FiO/Dn5x
 Jy/0D6yUhwCkIWERZvUxP8lKUBXyW9I6DmhPoLJ06mGPSHevRmJiNgQdWIqemHleiIFr
 5ga6XyIUq+m04w2iS5sA/jx7ctiIFMeQlckVIHQpOhMlHceQKq8dYcXLvkP+RcUF9vVo
 YIssonl6egxKXgXWI2qRps4xYVzGsiUoIOT3u5ZFoPe03eZtXyVYeH84f72s4OhCsAYT
 tEDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jqJZeEeODTZpGezAbssGAbOQs8PcxVkd2UIqFtiZtjM=;
 b=PfgQ4dRVA4en7mJBAKhDUBXSYNWwRXSEdujrRs96PHv2jvHhMoWTrkjePXaQFsGjD2
 MgYaqcEBWcOw45vSAl9VzsQA8np7gHD/OpcNFwq99Q4wwFEpTf1fREkIKDea4mBka5nW
 OJpHGBhfkY3HtC97R4L3f2sv4iF6csGNZ5J8v8XyHLiD7cq03dr1v+WO7VcHC2F40Y2U
 0ooewWTHyuu53fvK1NpxtcJMlprb138z1hRzs6aDDHaQcksk6kpV1NkNhzpS1Yl1I/7M
 CKpcTkym77J4wxQzfkIxWo8N+x5Mm6A/b5KNCg36d8Fow4I097lW75mDxmh1OEpAT8Xq
 z2qw==
X-Gm-Message-State: AOAM530AZ6ewOvWw3lR5NlXs1sNvHRUEIt/JU3xm6Mp87o7yPCVtpKMa
 IsKFfzMAb6iCG2N1lEPpSZelksvra2N+Qw==
X-Google-Smtp-Source: ABdhPJw46oHajh/C4O2v62x5QSz5Y/OtbpXyfVjccbyPHDygSaciCoycDk2R5lT/qXXejQROA0MUdw==
X-Received: by 2002:a2e:b0d0:: with SMTP id g16mr7136456ljl.130.1593391746213; 
 Sun, 28 Jun 2020 17:49:06 -0700 (PDT)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
 by smtp.gmail.com with ESMTPSA id i197sm5096429lfi.58.2020.06.28.17.49.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2020 17:49:05 -0700 (PDT)
From: andrew@daynix.com
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/2] hw/net: Added basic IPv6 fragmentation
Date: Mon, 29 Jun 2020 04:18:00 +0300
Message-Id: <20200629011800.374914-2-andrew@daynix.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200629011800.374914-1-andrew@daynix.com>
References: <20200629011800.374914-1-andrew@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::244;
 envelope-from=andrew@daynix.com; helo=mail-lj1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=_AUTOLEARN
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
Cc: jasowang@redhat.com, dmitry.fleytman@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Andrew <andrew@daynix.com>

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1708065
Overall, there was an issue that big frames of IPv6 doesn't sent.
With network backend with 'virtual header' - there was an issue
in 'plen' field. Overall, during TSO, 'plen' would be changed,
but with 'vheader' this field should be set to the size of the
payload itself instead of '0'.
For software offload - there is added basic IPv6 fragmentation.
The basic IPv6 fragmentation - adding 'frag' extension to
the packet, overall shares some logic with IPv4. It works,
but there are still issues with a combination of
extensions - in the future, it would require refactoring
work to implement workflow with IPv6 and extension.
e1000e driver doesn't set the 'plen' field for IPv6 for big packets
if TSO is enabled. "Jumbo option" isn't added yet, until
qemu supports packets greater than 64K.

Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 hw/net/net_tx_pkt.c | 30 ++++++++++++--
 hw/net/net_tx_pkt.h | 14 +++++++
 include/net/eth.h   | 15 +++++--
 net/eth.c           | 99 ++++++++++++++++++++++++++++++++++++++++++---
 4 files changed, 147 insertions(+), 11 deletions(-)

diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c
index 331c73cfc0..74044c6618 100644
--- a/hw/net/net_tx_pkt.c
+++ b/hw/net/net_tx_pkt.c
@@ -589,10 +589,11 @@ static bool net_tx_pkt_do_sw_fragmentation(struct NetTxPkt *pkt,
 
         more_frags = (fragment_offset + fragment_len < pkt->payload_len);
 
-        eth_setup_ip4_fragmentation(l2_iov_base, l2_iov_len, l3_iov_base,
-            l3_iov_len, fragment_len, fragment_offset, more_frags);
+        eth_setup_ip_fragmentation(l2_iov_base, l2_iov_len, l3_iov_base,
+            &l3_iov_len, ETH_MAX_IP_DGRAM_LEN,
+            fragment_len, fragment_offset, more_frags);
 
-        eth_fix_ip4_checksum(l3_iov_base, l3_iov_len);
+        fragment[NET_TX_PKT_FRAGMENT_L3_HDR_POS].iov_len = l3_iov_len;
 
         net_tx_pkt_sendv(pkt, nc, fragment, dst_idx);
 
@@ -626,6 +627,7 @@ bool net_tx_pkt_send(struct NetTxPkt *pkt, NetClientState *nc)
 
     if (pkt->has_virt_hdr ||
         pkt->virt_hdr.gso_type == VIRTIO_NET_HDR_GSO_NONE) {
+        net_tx_pkt_fix_ip6_payload_len(pkt);
         net_tx_pkt_sendv(pkt, nc, pkt->vec,
             pkt->payload_frags + NET_TX_PKT_PL_START_FRAG);
         return true;
@@ -644,3 +646,25 @@ bool net_tx_pkt_send_loopback(struct NetTxPkt *pkt, NetClientState *nc)
 
     return res;
 }
+
+void net_tx_pkt_fix_ip6_payload_len(struct NetTxPkt *pkt)
+{
+    struct iovec *l2 = &pkt->vec[NET_TX_PKT_L2HDR_FRAG];
+    if (eth_get_l3_proto(l2, 1, l2->iov_len) == ETH_P_IPV6) {
+        struct ip6_header *ip6 = (struct ip6_header *) pkt->l3_hdr;
+        /*
+         * TODO: if qemu would support >64K packets - add jumbo option check
+         * something like that:
+         * 'if (ip6->ip6_plen == 0 && !has_jumbo_option(ip6)) {'
+         */
+        if (ip6->ip6_plen == 0) {
+            if (pkt->payload_len <= ETH_MAX_IP_DGRAM_LEN) {
+                ip6->ip6_plen = htons(pkt->payload_len);
+            }
+            /*
+             * TODO: if qemu would support >64K packets
+             * add jumbo option for packets greater then 65,535 bytes
+             */
+        }
+    }
+}
diff --git a/hw/net/net_tx_pkt.h b/hw/net/net_tx_pkt.h
index 212ecc62fc..4ec8bbe9bd 100644
--- a/hw/net/net_tx_pkt.h
+++ b/hw/net/net_tx_pkt.h
@@ -187,4 +187,18 @@ bool net_tx_pkt_parse(struct NetTxPkt *pkt);
 */
 bool net_tx_pkt_has_fragments(struct NetTxPkt *pkt);
 
+/**
+ * Fix IPv6 'plen' field.
+ * If ipv6 payload length field is 0 - then there should be Hop-by-Hop
+ * option for packets greater than 65,535.
+ * For packets with a payload less than 65,535: fix 'plen' field.
+ * For backends with vheader, we need just one packet with proper
+ * payload size. For now, qemu drops every packet with size greater 64K
+ * (see net_tx_pkt_send()) so, there is no reason to add jumbo option to ip6
+ * hop-by-hop extension if it's missed
+ *
+ * @pkt            packet
+ */
+void net_tx_pkt_fix_ip6_payload_len(struct NetTxPkt *pkt);
+
 #endif
diff --git a/include/net/eth.h b/include/net/eth.h
index 7f45c678e7..05c75ac9fc 100644
--- a/include/net/eth.h
+++ b/include/net/eth.h
@@ -139,6 +139,14 @@ struct ip6_ext_hdr_routing {
     uint8_t     rsvd[4];
 };
 
+struct ip6_ext_hdr_fragment {
+    uint8_t     nxt;
+    uint8_t     res0;
+    uint16_t    off;
+    uint32_t    id;
+};
+
+
 struct ip6_option_hdr {
 #define IP6_OPT_PAD1   (0x00)
 #define IP6_OPT_HOME   (0xC9)
@@ -186,6 +194,7 @@ struct tcp_hdr {
 
 #define ip6_nxt      ip6_ctlun.ip6_un1.ip6_un1_nxt
 #define ip6_ecn_acc  ip6_ctlun.ip6_un3.ip6_un3_ecn
+#define ip6_plen     ip6_ctlun.ip6_un1.ip6_un1_plen
 
 #define PKT_GET_ETH_HDR(p)        \
     ((struct eth_header *)(p))
@@ -398,9 +407,9 @@ void eth_get_protocols(const struct iovec *iov, int iovcnt,
                        eth_ip4_hdr_info *ip4hdr_info,
                        eth_l4_hdr_info  *l4hdr_info);
 
-void eth_setup_ip4_fragmentation(const void *l2hdr, size_t l2hdr_len,
-                                 void *l3hdr, size_t l3hdr_len,
-                                 size_t l3payload_len,
+void eth_setup_ip_fragmentation(const void *l2hdr, size_t l2hdr_len,
+                                 void *l3hdr, size_t *l3hdr_len,
+                                 size_t l3hdr_max_len, size_t l3payload_len,
                                  size_t frag_offset, bool more_frags);
 
 void
diff --git a/net/eth.c b/net/eth.c
index 0c1d413ee2..067111526d 100644
--- a/net/eth.c
+++ b/net/eth.c
@@ -314,10 +314,65 @@ eth_strip_vlan_ex(const struct iovec *iov, int iovcnt, size_t iovoff,
     return 0;
 }
 
+static bool eth_is_ip6_extension_header_type(uint8_t hdr_type);
+
+static void *eth_ip6_find_ext(struct ip6_header *ip6, uint8_t ext_type)
+{
+    uint8_t curr_ext_hdr_type = ip6->ip6_nxt;
+    struct ip6_ext_hdr *ext_hdr = (struct ip6_ext_hdr *)(ip6 + 1);
+    for (; eth_is_ip6_extension_header_type(curr_ext_hdr_type);) {
+        if (curr_ext_hdr_type == ext_type) {
+            return ext_hdr;
+        }
+        curr_ext_hdr_type = ext_hdr->ip6r_nxt;
+        ext_hdr = (struct ip6_ext_hdr *)(((uint8_t *)ext_hdr)
+                + (ext_hdr->ip6r_len + 1) * IP6_EXT_GRANULARITY);
+    }
+
+    return NULL;
+}
+
+/*
+ * To add an extension - there is should be
+ * enough memory 'behind' the ip6 header.
+ */
+static void *eth_ip6_add_ext_nonsafe(struct ip6_header *ip6, uint8_t ext_type)
+{
+    uint8_t curr_ext_hdr_type = ip6->ip6_nxt;
+    struct ip6_ext_hdr *ext_hdr = (struct ip6_ext_hdr *)(ip6 + 1);
+    struct ip6_ext_hdr *ext_hdr_prev = NULL;
+
+    if (!eth_is_ip6_extension_header_type(curr_ext_hdr_type)) {
+        ext_hdr->ip6r_nxt = ip6->ip6_nxt;
+        ip6->ip6_nxt = ext_type;
+        return ext_hdr;
+    }
+
+    ext_hdr_prev = ext_hdr;
+    curr_ext_hdr_type = ext_hdr->ip6r_nxt;
+    ext_hdr = (struct ip6_ext_hdr *)(((uint8_t *)ext_hdr)
+            + (ext_hdr->ip6r_len + 1) * IP6_EXT_GRANULARITY);
+
+    for (; eth_is_ip6_extension_header_type(curr_ext_hdr_type);) {
+        ext_hdr_prev = ext_hdr;
+        curr_ext_hdr_type = ext_hdr->ip6r_nxt;
+        ext_hdr = (struct ip6_ext_hdr *)(((uint8_t *)ext_hdr)
+                + (ext_hdr->ip6r_len + 1) * IP6_EXT_GRANULARITY);
+    }
+
+    ext_hdr->ip6r_nxt = ext_hdr_prev->ip6r_nxt;
+    ext_hdr_prev->ip6r_nxt = ext_type;
+
+    return ext_hdr;
+}
+
+/* When IP6_FRAGMENT added, first 'id' would be 0x71656d75 */
+static const uint32_t s_first_fragment_identificator = 0x71656d75; /* 'qemu' */
+
 void
-eth_setup_ip4_fragmentation(const void *l2hdr, size_t l2hdr_len,
-                            void *l3hdr, size_t l3hdr_len,
-                            size_t l3payload_len,
+eth_setup_ip_fragmentation(const void *l2hdr, size_t l2hdr_len,
+                            void *l3hdr, size_t *l3hdr_len,
+                            size_t l3hdr_max_len, size_t l3payload_len,
                             size_t frag_offset, bool more_frags)
 {
     const struct iovec l2vec = {
@@ -325,7 +380,9 @@ eth_setup_ip4_fragmentation(const void *l2hdr, size_t l2hdr_len,
         .iov_len = l2hdr_len
     };
 
-    if (eth_get_l3_proto(&l2vec, 1, l2hdr_len) == ETH_P_IP) {
+    uint16_t l3_proto = eth_get_l3_proto(&l2vec, 1, l2hdr_len);
+
+    if (l3_proto == ETH_P_IP) {
         uint16_t orig_flags;
         struct ip_header *iphdr = (struct ip_header *) l3hdr;
         uint16_t frag_off_units = frag_offset / IP_FRAG_UNIT_SIZE;
@@ -337,7 +394,39 @@ eth_setup_ip4_fragmentation(const void *l2hdr, size_t l2hdr_len,
         orig_flags = be16_to_cpu(iphdr->ip_off) & ~(IP_OFFMASK|IP_MF);
         new_ip_off = frag_off_units | orig_flags  | (more_frags ? IP_MF : 0);
         iphdr->ip_off = cpu_to_be16(new_ip_off);
-        iphdr->ip_len = cpu_to_be16(l3payload_len + l3hdr_len);
+        iphdr->ip_len = cpu_to_be16(l3payload_len + *l3hdr_len);
+
+        eth_fix_ip4_checksum(l3hdr, *l3hdr_len);
+    } else if (l3_proto == ETH_P_IPV6) {
+        struct ip6_header *ip6 = (struct ip6_header *) l3hdr;
+
+        struct ip6_ext_hdr_fragment *frag_ext = NULL;
+
+        /* Find frag extension */
+        frag_ext = eth_ip6_find_ext(ip6, IP6_FRAGMENT);
+        if (frag_ext == NULL) {
+            /* No frag extension? Add one */
+            if (*l3hdr_len + sizeof(*frag_ext) > l3hdr_max_len) {
+                /*
+                 * TODO:
+                 * For now, qemu's L3 buffer allocated with NetTxPkt
+                 * and have enough memory(buffer allocated with 65K bytes
+                 * ETH_MAX_IP_DGRAM_LEN = 0xFFFF)
+                 * for additional extensions.
+                 */
+                return; /* TODO: request to reallocate l3hdr */
+            }
+            frag_ext = eth_ip6_add_ext_nonsafe(ip6, IP6_FRAGMENT);
+            *l3hdr_len += sizeof(*frag_ext);
+            static uint32_t s_id = s_first_fragment_identificator;
+            frag_ext->id = cpu_to_be32(s_id);
+            ++s_id;
+        }
+
+        frag_ext->off = cpu_to_be16((frag_offset / IP_FRAG_UNIT_SIZE) << 3
+                | (uint16_t)!!more_frags);
+
+        ip6->ip6_plen = cpu_to_be16(l3payload_len + *l3hdr_len - sizeof(*ip6));
     }
 }
 
-- 
2.27.0


