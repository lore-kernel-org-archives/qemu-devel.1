Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96059C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 03:26:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6007B20663
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 03:26:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="xe1LxlFV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6007B20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvuXK-0004jA-Mv
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 23:26:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47022)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1jvuVQ-0003Hn-7F
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 23:24:20 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:46266)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1jvuVO-0000yX-D4
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 23:24:19 -0400
Received: by mail-lf1-x143.google.com with SMTP id i80so2447780lfi.13
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 20:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ikcxsmybKu75tMrZAbUoPk+Io12iE4UDp+YqxU9KKOI=;
 b=xe1LxlFVd+319Hz3jiiWbhXEM37Y1Uoy1ailwhEGzlWx6d8nv5XgE8FPuqVcIX9gLY
 1l38XgktT9jnHdogmiAF44eoa8lUhfODlLd/JppBxEB7tEslRBMUZ1Aequ8+4UlqchPW
 Xtx7JR8YpbsdVcYENVcuaUqmnsAooTn3IVnCLJ3JESOwz7Lp3DRk9P+kNfqOhR2vcEv2
 YVpL9x+gYhjKC8EQbcoiPqk7N8xY4CY/2Ed0HPVUMopBnhGOarMcfTmFTzwAcSPYUbv8
 OsOunHtTFRlaFlDmLDv/ebdpEfT/dsjnu3nKFr0/PobzMqs4Dr4BZr3+grnVBDoESexW
 x+sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ikcxsmybKu75tMrZAbUoPk+Io12iE4UDp+YqxU9KKOI=;
 b=HbjL6U41Vl7+Jn7HTuoSTCCDehyLWkT1t3L3nV5fSYGEuk03TeKcrCZc3t1lhuAncb
 NeZle7gF/i8UKJz4c7udE2KXbJsqcBrsBCVlCaD+aSE/asLK+O8khmElYSXaBGlJw3u0
 ung/x7IWOA3u3hKIYEBq70+tUMvmSs7SwFy1EVPo34WRvgPiki/q9n2tDPe36FXNFdLz
 zX63bRgF0qm2TsxT8IHMFf1AJ5TIjmjPBHld7IsNSRe1RM0siin5c8TUgYaV26mcmBM7
 ulQDxt06KitaaDAysJ1FR1tgtAU0Wsds47Hx5LmEk8+6aXG/3MFwQgyOZ2mJ8GcyzvsC
 dkAg==
X-Gm-Message-State: AOAM533pNnyPRBw7Rn9z/gH6U7DAZZiefaJOSuXPPQ0IiYwKOwnPaaBq
 nubIuERlyZYsn+4BxTX3OxyDikXkQ6MP2Q==
X-Google-Smtp-Source: ABdhPJxq9YIJVPtMVb+VDaiaAiuIrCoBqLiSS+BZNA0egqR7V833zdtN65L/CVNDjeO3QovoZGJdxA==
X-Received: by 2002:a19:8c09:: with SMTP id o9mr1056974lfd.160.1594869856086; 
 Wed, 15 Jul 2020 20:24:16 -0700 (PDT)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
 by smtp.gmail.com with ESMTPSA id o1sm774772ljj.82.2020.07.15.20.24.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2020 20:24:15 -0700 (PDT)
From: andrew@daynix.com
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/2] hw/net: Added basic IPv6 software fragmentation
Date: Thu, 16 Jul 2020 06:53:25 +0300
Message-Id: <20200716035325.1406919-2-andrew@daynix.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200716035325.1406919-1-andrew@daynix.com>
References: <20200716035325.1406919-1-andrew@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::143;
 envelope-from=andrew@daynix.com; helo=mail-lf1-x143.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

The basic IPv6 fragmentation - adding 'frag' extension to
the packet, overall shares some logic with IPv4. It works,
but there are still issues with a combination of
extensions - in the future, it would require refactoring
work to implement workflow with IPv6 and extension.
"Jumbo option" isn't added yet, until
qemu supports packets greater than 64K.

Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 hw/net/net_tx_pkt.c |  7 ++--
 include/net/eth.h   | 14 +++++--
 net/eth.c           | 99 ++++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 109 insertions(+), 11 deletions(-)

diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c
index 9560e4a49e..74044c6618 100644
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
 
diff --git a/include/net/eth.h b/include/net/eth.h
index 0671be6916..05c75ac9fc 100644
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
@@ -399,9 +407,9 @@ void eth_get_protocols(const struct iovec *iov, int iovcnt,
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


