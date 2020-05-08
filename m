Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C7BC38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 13:09:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A84724970
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 13:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="VHqHdCsX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A84724970
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX2lI-00016g-Oy
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 09:09:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53886)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1jX2X1-0007Zc-Jj
 for qemu-devel@nongnu.org; Fri, 08 May 2020 08:55:11 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:40196)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1jX2X0-0003mD-PJ
 for qemu-devel@nongnu.org; Fri, 08 May 2020 08:55:11 -0400
Received: by mail-wr1-x443.google.com with SMTP id e16so1717256wra.7
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 05:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=/hmWHO6d7/G558em/hObj2NusDs/d8TWPYPLgPOejdI=;
 b=VHqHdCsXsWwK9GVzrfW/O6tznjR6I3uF04yXtT+oEdybe91qHsx0QcYw82/duS4G2G
 /w3m+ttQroKp4YSaphGSVf2zWFT/fe7YJouZztz8qtVLiPULHWS2whqY3R8G3Ux0rvyU
 u8SiwngO0NS04C1o+pMwvbYqGGMjYf3Ognsig3hntgozWSagpERhhSFRymc9g5Y1mrUw
 I74t3it7G4ZekXJeetLnWidU9Ob9ZLieDLalQqbdrI7KgzIoWt9ZFVxInmiOmDxAvWP9
 bfMkMbPvLd+2P3hspmMnGhOYU19zMDBpuMrCLNk82i++iBpai0U61yIQb3r+H1tRlsZN
 fNHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=/hmWHO6d7/G558em/hObj2NusDs/d8TWPYPLgPOejdI=;
 b=sC5r+CAsGyD3HgNPRFS2iMB8k4Un06C6/1TBYkSWkM53qXwwxg4U9wE2IZgugQBtoi
 qOaXkqSoWppNjfm0BlIXyi6TpnZZY/7yMv5OAnc9zqng8nQdtrqdfRHx9Y4HdEiJMYU7
 ut1tdrVJeRRvkm5WYOYeRrs9aD4P4YtBPd3dftOnCaQmMmVsYNApnCOQ4YRNWDRHldOU
 LyuKEd4EFK2KRWNsbYstjRMMOpuXTmy+sKAE18Mp4YXxdPRWf8TPz4XTLTB1Qty89myt
 Dz8NC75L/a1b6BiLDZj60UOYLuCAdJ25uvwU1glhP8aBYlBDtXWh0qgl2mqT/6ROg39P
 QOXA==
X-Gm-Message-State: AGi0PuZY8EBbd1h26z2cG6d/BXn+Xd6UpvHqt6BxcId+teFPOqXc7ZZC
 IVQX/8VIgOXx4DRWCG5YU6WE5HWfHVLaUg==
X-Google-Smtp-Source: APiQypLiO+cg10X08BMNDGKyHzEKQO1Nxap5HLqnuE/19vW/GqbqXbYYe2QNzW7hT3A7gzxQijl5SQ==
X-Received: by 2002:adf:e64c:: with SMTP id b12mr2762220wrn.131.1588942509339; 
 Fri, 08 May 2020 05:55:09 -0700 (PDT)
Received: from f2.redhat.com (bzq-79-183-19-16.red.bezeqint.net.
 [79.183.19.16])
 by smtp.gmail.com with ESMTPSA id a8sm2852375wrg.85.2020.05.08.05.55.08
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 08 May 2020 05:55:08 -0700 (PDT)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
To: qemu-devel@nongnu.org, mst@redhat.com, jasowang@redhat.com,
 quintela@redhat.com, dgilbert@redhat.com
Subject: [PATCH 7/7] virtio-net: align RSC fields with updated virtio-net
 header
Date: Fri,  8 May 2020 15:54:52 +0300
Message-Id: <20200508125452.7802-8-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200508125452.7802-1-yuri.benditovich@daynix.com>
References: <20200508125452.7802-1-yuri.benditovich@daynix.com>
Received-SPF: none client-ip=2a00:1450:4864:20::443;
 envelope-from=yuri.benditovich@daynix.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: yan@daynix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Removal of duplicated RSC definitions. Changing names of the
fields to ones defined in the Linux header.

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
---
 hw/net/virtio-net.c | 28 ++++------------------------
 1 file changed, 4 insertions(+), 24 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index c263b1511d..10b4ba50ad 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -88,26 +88,6 @@
                                          VIRTIO_NET_RSS_HASH_TYPE_TCP_EX | \
                                          VIRTIO_NET_RSS_HASH_TYPE_UDP_EX)
 
-/* temporary until standard header include it */
-#if !defined(VIRTIO_NET_HDR_F_RSC_INFO)
-
-#define VIRTIO_NET_HDR_F_RSC_INFO  4 /* rsc_ext data in csum_ fields */
-#define VIRTIO_NET_F_RSC_EXT       61
-
-#endif
-
-static inline __virtio16 *virtio_net_rsc_ext_num_packets(
-    struct virtio_net_hdr *hdr)
-{
-    return &hdr->csum_start;
-}
-
-static inline __virtio16 *virtio_net_rsc_ext_num_dupacks(
-    struct virtio_net_hdr *hdr)
-{
-    return &hdr->csum_offset;
-}
-
 static VirtIOFeature feature_sizes[] = {
     {.flags = 1ULL << VIRTIO_NET_F_MAC,
      .end = endof(struct virtio_net_config, mac)},
@@ -1821,15 +1801,15 @@ static size_t virtio_net_rsc_drain_seg(VirtioNetRscChain *chain,
                                        VirtioNetRscSeg *seg)
 {
     int ret;
-    struct virtio_net_hdr *h;
+    struct virtio_net_hdr_v1 *h;
 
-    h = (struct virtio_net_hdr *)seg->buf;
+    h = (struct virtio_net_hdr_v1 *)seg->buf;
     h->flags = 0;
     h->gso_type = VIRTIO_NET_HDR_GSO_NONE;
 
     if (seg->is_coalesced) {
-        *virtio_net_rsc_ext_num_packets(h) = seg->packets;
-        *virtio_net_rsc_ext_num_dupacks(h) = seg->dup_ack;
+        h->rsc.segments = seg->packets;
+        h->rsc.dup_acks = seg->dup_ack;
         h->flags = VIRTIO_NET_HDR_F_RSC_INFO;
         if (chain->proto == ETH_P_IP) {
             h->gso_type = VIRTIO_NET_HDR_GSO_TCPV4;
-- 
2.17.1


