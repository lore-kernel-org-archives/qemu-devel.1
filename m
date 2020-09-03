Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF03FC10DAA
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:58:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 637EB20678
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEoSrUV/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 637EB20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDxFc-0003Pt-9b
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 17:58:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59784)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwMK-0005N5-66; Thu, 03 Sep 2020 17:01:28 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:46537)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwMH-0007va-UX; Thu, 03 Sep 2020 17:01:27 -0400
Received: by mail-ot1-x342.google.com with SMTP id c10so3976922otm.13;
 Thu, 03 Sep 2020 14:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=xAeCy0dkrFXli/MZ20SoEmseBhxRBmTMNlsNI00ND14=;
 b=WEoSrUV/LzAYl33ehfkdIN86+C4rVusYx4wewIllU8ElcV4YrtStVmYiGVvMyC23az
 e9P/8G0Y5Uh2vRXPdvTzjVEzFeR751XcONMtLiOU0NgqWQDU6yaN0wz/7ccBRcouvgs5
 OFLTeq2C1yt8q9bLnNr3yygyi7S3yBRgPdE+HEn1CNe80cC4IviIDqaH3clfP3kpjKEG
 w9X7h63J2wkhcuta2/yLIO2bBf2YAHnGRg3Sqqz8Z2plENrEMLX7Y8bAI4OncGhHaIoB
 Vzqpu0Oks+fB7l9vy8qWB6uyJBUiZyno5Zn/biS0pNo0EC0CNnHEE2vsQBHHEg7s0TXP
 KIvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=xAeCy0dkrFXli/MZ20SoEmseBhxRBmTMNlsNI00ND14=;
 b=W4RUlvkJFlsuqYxKIhgjPaUGj5nOVuYAbS+b6h0WiZwxq01N02L1qIXJ+4/OsT1bAZ
 lmww64aBRo2GQAK+4rFMWgWHrz9zzhweJ2SIEenh9xP58ZSjn/E0BT63m/j1hb7n3BN4
 qbOPjTyzzZdWr2gx3/CuMbmGauf7S27xZXHh+ecqXd/ZO5Y3CltnN1XqIC6meyHSJiyp
 zYc0q/hVNsHDdeGe6CDU99aDps5S0WvO+64xHlrGR6X4ygCiqopR44Z2UOKPhb2g/9a1
 c98JcPk8qlEXO0AZVgkVRHBBy2pGNxe7hZThA4uGJU1srKdir2rhM6D/uZ3oN/jFE439
 z4Ag==
X-Gm-Message-State: AOAM531bL6M1fNBhNxdVLqRWZlFzAmmgpExQUGDqnaIilX7bxWtSv4v6
 ytAT40KbbTFNAs6az2zuwFJutDEsFATsWQ==
X-Google-Smtp-Source: ABdhPJzwTbCsl+Lytgoj2z8kHwkjguW6nV3JVs+HNrcQ/RMCz466MkpnxiQYgkQnz5rRU09YZbXfNg==
X-Received: by 2002:a9d:d35:: with SMTP id 50mr3064963oti.166.1599166884190;
 Thu, 03 Sep 2020 14:01:24 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id m21sm787351otr.36.2020.09.03.14.01.23
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Sep 2020 14:01:23 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 75/77] virtio-net: align RSC fields with updated virtio-net
 header
Date: Thu,  3 Sep 2020 15:59:33 -0500
Message-Id: <20200903205935.27832-76-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
References: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=flukshun@gmail.com; helo=mail-ot1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Yuri Benditovich <yuri.benditovich@daynix.com>,
 Jason Wang <jasowang@redhat.com>, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yuri Benditovich <yuri.benditovich@daynix.com>

Removal of duplicated RSC definitions. Changing names of the
fields to ones defined in the Linux header.

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
(cherry picked from commit dd3d85e89123c907be7628957457af3d03e3b85b)
 Conflicts:
	hw/net/virtio-net.c
*drop context dep. on 590790297c0
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/net/virtio-net.c | 27 ++++-----------------------
 1 file changed, 4 insertions(+), 23 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index e7e2c2acdb..6cb1448310 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -77,25 +77,6 @@
    tso/gso/gro 'off'. */
 #define VIRTIO_NET_RSC_DEFAULT_INTERVAL 300000
 
-/* temporary until standard header include it */
-#if !defined(VIRTIO_NET_HDR_F_RSC_INFO)
-
-#define VIRTIO_NET_HDR_F_RSC_INFO  4 /* rsc_ext data in csum_ fields */
-#define VIRTIO_NET_F_RSC_EXT       61
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
-#endif
 
 static VirtIOFeature feature_sizes[] = {
     {.flags = 1ULL << VIRTIO_NET_F_MAC,
@@ -1539,15 +1520,15 @@ static size_t virtio_net_rsc_drain_seg(VirtioNetRscChain *chain,
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


