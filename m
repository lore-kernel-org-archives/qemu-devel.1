Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286B7C4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 12:00:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB0D620836
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 12:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="UKrJ5LW9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB0D620836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFGKI-0003kB-2L
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 08:00:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52610)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jFGHq-0007h1-ND
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 07:58:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jFGHp-0000FD-IZ
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 07:58:02 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34238)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
 id 1jFGHp-0000Es-DO
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 07:58:01 -0400
Received: by mail-wr1-x441.google.com with SMTP id z15so7102203wrl.1
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 04:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=O0gbhhNXKqovD8z2owZu41rSHwkPJ8sCWBwXndaIn/A=;
 b=UKrJ5LW9zQda7WCcSMyzCeaKakrZkcHk4BrznxfZ489EtB8n0b0d+i/3969dZsmemk
 j/TSZrauTDX+gjim/Xiwp1nTrT6w3CQOT3oS3LNIRl4rQ/XOmwh6idzBMpsvOq7WYtOR
 6zGnWS3FhFepRUpcPzHJYQw2j1Ya8+3mddAb+5OYnmr8o9Mlxxuw0IAT9hopGo0fhahI
 Dy3miMDhnSzqyoCKlJVF9hWEHXB6ydLv5T8GKUC/S1Au9iNHzGhErpFLAr4xQfu6nOXX
 LyZLGpvM4jIliTjDFiB/nmOJxVenwSsOXjff0uU+XMmSUHbCqiFWsgP/TZBcwXr847Kz
 OhpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=O0gbhhNXKqovD8z2owZu41rSHwkPJ8sCWBwXndaIn/A=;
 b=PlSdM55cE5syHQpWjHbDmDegpxuVf2LIdw8xVGR60V/151TGr0cB+IdZBIP9Zwin+e
 pNnfzBX44axL0ZI4jxAf11uzaubLnDptOC7TEGdOlkanoshm9X/X82kauZsI0vHlQC9w
 /KN691gXNm8m0BzcrkxW1W1lo9ZMtIlUSFYotBxJkj/boEIMzg6ACFRgU08Nk7P6MRTe
 4LSaonlWgOsnhDJwFvzltyvlzhCtKJAHkbN3yCVz6SzQL2Dbg627wijw35u+KIkw1OOL
 BgtP9ClUf4lqdQ4nRcrXpZlH3/DW9SdcHimG75z5teXMGGYwTwZF4LHgrsEjgn/Mq9Wh
 dCeA==
X-Gm-Message-State: ANhLgQ0pI9Y+2+9vVA0IVEGjNSSrhNUFCUyBmb5+lcmwU746NJ6QaVh4
 rLzHqscp5sFkKUcobzTLbT35sx8GCD4vmw==
X-Google-Smtp-Source: ADFU+vt5bb913x8d1VIh37F6gfPUcpiuDqvcWap0UCMStFUc46J0c01wjmUQQY4ojZLdMzgQvjoF9g==
X-Received: by 2002:adf:a490:: with SMTP id g16mr10543639wrb.42.1584705480116; 
 Fri, 20 Mar 2020 04:58:00 -0700 (PDT)
Received: from f2.redhat.com (bzq-79-179-79-224.red.bezeqint.net.
 [79.179.79.224])
 by smtp.gmail.com with ESMTPSA id c18sm6637645wrx.5.2020.03.20.04.57.58
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 20 Mar 2020 04:57:59 -0700 (PDT)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
To: qemu-devel@nongnu.org, mst@redhat.com, jasowang@redhat.com,
 quintela@redhat.com, dgilbert@redhat.com
Subject: [PATCH v6 1/7] virtio-net: introduce RSS and hash report features
Date: Fri, 20 Mar 2020 13:57:45 +0200
Message-Id: <20200320115751.19446-2-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200320115751.19446-1-yuri.benditovich@daynix.com>
References: <20200320115751.19446-1-yuri.benditovich@daynix.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: yan@daynix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
---
 hw/net/virtio-net.c | 65 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 3627bb1717..90b01221e9 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -71,6 +71,71 @@
 #define VIRTIO_NET_IP6_ADDR_SIZE   32      /* ipv6 saddr + daddr */
 #define VIRTIO_NET_MAX_IP6_PAYLOAD VIRTIO_NET_MAX_TCP_PAYLOAD
 
+/* TODO: remove after virtio-net header update */
+#if !defined(VIRTIO_NET_RSS_HASH_TYPE_IPv4)
+#define VIRTIO_NET_F_HASH_REPORT    57  /* Supports hash report */
+#define VIRTIO_NET_F_RSS            60  /* Supports RSS RX steering */
+
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
+struct virtio_net_config_with_rss {
+    struct virtio_net_config cfg;
+    /* maximum size of RSS key */
+    uint8_t rss_max_key_size;
+    /* maximum number of indirection table entries */
+    uint16_t rss_max_indirection_table_length;
+    /* bitmask of supported VIRTIO_NET_RSS_HASH_ types */
+    uint32_t supported_hash_types;
+} QEMU_PACKED;
+
+struct virtio_net_hdr_v1_hash {
+    struct virtio_net_hdr_v1 hdr;
+    uint32_t hash_value;
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
+    uint16_t hash_report;
+    uint16_t padding;
+};
+
+/*
+ * The command VIRTIO_NET_CTRL_MQ_RSS_CONFIG has the same effect as
+ * VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET does and additionally configures
+ * the receive steering to use a hash calculated for incoming packet
+ * to decide on receive virtqueue to place the packet. The command
+ * also provides parameters to calculate a hash and receive virtqueue.
+ */
+struct virtio_net_rss_config {
+    uint32_t hash_types;
+    uint16_t indirection_table_mask;
+    uint16_t unclassified_queue;
+    uint16_t indirection_table[1/* + indirection_table_mask */];
+    uint16_t max_tx_vq;
+    uint8_t hash_key_length;
+    uint8_t hash_key_data[/* hash_key_length */];
+};
+
+#define VIRTIO_NET_CTRL_MQ_RSS_CONFIG          1
+#define VIRTIO_NET_CTRL_MQ_HASH_CONFIG         2
+
+#endif
+
 /* Purge coalesced packets timer interval, This value affects the performance
    a lot, and should be tuned carefully, '300000'(300us) is the recommended
    value to pass the WHQL test, '50000' can gain 2x netperf throughput with
-- 
2.17.1


