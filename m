Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D72C47247
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 13:11:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12D5424999
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 13:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="bz2GEL9N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12D5424999
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX2mt-0003ru-9J
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 09:11:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1jX2ba-0001CQ-01
 for qemu-devel@nongnu.org; Fri, 08 May 2020 08:59:54 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:39006)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1jX2bZ-0006hB-7T
 for qemu-devel@nongnu.org; Fri, 08 May 2020 08:59:53 -0400
Received: by mail-wr1-x443.google.com with SMTP id l18so1732272wrn.6
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 05:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=/hmWHO6d7/G558em/hObj2NusDs/d8TWPYPLgPOejdI=;
 b=bz2GEL9NKlKov5U1IR81lsUGdhzQpjNb9u+V4wOER38/VNyrK4diko7P/mcdbi5oeO
 VVDCSOZb+NEEYITyfk/Y6m8naQOYtzGx8Ccgc0ceANV/TVb5npObMr+wiUlJcz5ZSdco
 TRGmD+s+ggSgqC7VIl02CTR5Kopg+UKQjg8WAgOVozTzQ0A2NlqWu4O92tLoCu5wwap2
 a2L9ivjwKiAHHQSQ1pKM1JRaY5KI3ZZaAhY6j1Cad+b0dUxmj9t19Q0gFV3m1D8j4vdB
 TodKS3VB8aO+iS04dfohUwowCnol7eytpRokkD0FMZeQfR/ldKOuj7dLjBMVXJ+usylj
 2FUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=/hmWHO6d7/G558em/hObj2NusDs/d8TWPYPLgPOejdI=;
 b=sQBrFqYwhsIxCiFT5yqusnVL0htInYCo5epE5W7WkJrEuH07BqToNpk31Z8B9CzKAb
 XGJsxUjfQsbzhMQIwcWKHjUHUivDlCIWYP8v8t15zjEi7Ac5umM1pNaqc7cKh329DQU0
 UFYApXEvc9KaE+FxaEVg13cMFJLJOZUKW0HUeuMjut2TfQkLCVTa98LlOoPn8OQ1cVn7
 Re7ejx2M3awsTVrCZ6YqQexdule2ksgKg/eAzaTudTOXFtfJsHIhu8RXzX1O1IqaQHHk
 D75hAT81Mj4l7MNpDzSgC9gSRGORuk1CCobV77kNeIRz1n7RXHT+ixqvjcegXvg7BCJD
 /rxw==
X-Gm-Message-State: AGi0Pub40x1FdQpoRgxPaHNVNVqRVwlDVSPEC44oionfGL01yu/mtS8s
 6D07atxAX671SHF3VifkhC/LFSi0AipowQ==
X-Google-Smtp-Source: APiQypIZ67c/pX1TTu07upMI6r6h0qTOc8pPA05J7U6EEy/whoVCDcwR1BNBty13NBWzSKlSJ9QzAw==
X-Received: by 2002:adf:e2c2:: with SMTP id d2mr3028472wrj.55.1588942791821;
 Fri, 08 May 2020 05:59:51 -0700 (PDT)
Received: from f2.redhat.com (bzq-79-183-19-16.red.bezeqint.net.
 [79.183.19.16])
 by smtp.gmail.com with ESMTPSA id g6sm2915974wrw.34.2020.05.08.05.59.50
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 08 May 2020 05:59:51 -0700 (PDT)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
To: qemu-devel@nongnu.org, mst@redhat.com, jasowang@redhat.com,
 quintela@redhat.com, dgilbert@redhat.com
Subject: [PATCH v8 7/7] virtio-net: align RSC fields with updated virtio-net
 header
Date: Fri,  8 May 2020 15:59:34 +0300
Message-Id: <20200508125934.7861-8-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200508125934.7861-1-yuri.benditovich@daynix.com>
References: <20200508125934.7861-1-yuri.benditovich@daynix.com>
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


