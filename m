Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEEBEC433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:42:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84C02208B8
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g7FNTgPF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84C02208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlCnP-0004Tr-Np
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 10:42:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57664)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCPv-0002UU-TW; Tue, 16 Jun 2020 10:18:23 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:39890)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCPu-0006j9-Av; Tue, 16 Jun 2020 10:18:23 -0400
Received: by mail-ot1-x343.google.com with SMTP id g5so16041684otg.6;
 Tue, 16 Jun 2020 07:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2PAYIiO9sA4fG4g3Wu3Wl38xdQ9Zdsb+MLvf0b3D2Wo=;
 b=g7FNTgPFv4/Y5UcicqvAI+fAkUZwdEIukRE3Mw0maZKBjcEpV8HSjhTmR8EOzsuD1N
 FvgntdECt95W9F90X2+2oK1zg55kW17cIzqeR10BMHtwEVXVgG9nohSh7V/1qbsUDHEB
 nSqduJqHGKVjziNbGCj6tpQw2vNL5rfo2UMEI+OXsOTZFw6ug08qChxYtGkc7Vc/906u
 Wqp8w6IcHzVcUHH9rSxNKLKseRpj/hbqYU4yEAvVc0SN93HoNZltf7VaGu1IuQyAx3Pb
 ABBloVEwJ83394tnUtAwvN6tR1/lYQ0HiRiaJ03FRvingizsgox190O1DqwBiqzlmIVB
 wB/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=2PAYIiO9sA4fG4g3Wu3Wl38xdQ9Zdsb+MLvf0b3D2Wo=;
 b=aF+CFkTMy3O37ngIO8jXJF0QrhgiYa4XohVM0pr5xPFnJSkOgNMr2o/SSh+yGoF5ED
 6Hcsu5R8M9il0BpNxAV3hGoiB6P8VU7bCrqmNW1mtp90PvaOtczRha7tLAXky9zHuaRD
 i6K2HGeDkzHqlrKd4e92YUIhBGmzsflIzFI0wHOctq7rr+Xp9m7qID9yzHwxjyBatSu8
 miXHmQ6+q2+kc1p5+srPqxTINksi4J01VzJ+Ei4uIyN9F2iePhn7uyNUKF5cY03esh35
 gf7UnnN895t4419DrGar+VogGkYWkyvWvGceOTf/cmtP8TtO9OjhuPV8aSrJxL5XxJyF
 pykw==
X-Gm-Message-State: AOAM533oG/QNwlAtK6wmCtGHn9uLZepXYLhJsYHQhBjqW8LbIdxinaun
 wgdXPOC7zg2vW2mSKmpBC+QItu7o
X-Google-Smtp-Source: ABdhPJwYSh11X0vLxrhUFIdVYhsAfxeWEuoto5UrLkPdRy8UgB8xEJ9RAN+s2dWwxX/f0bMJSYGQTw==
X-Received: by 2002:a9d:6c03:: with SMTP id f3mr2511324otq.291.1592317100308; 
 Tue, 16 Jun 2020 07:18:20 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id l24sm4073415otf.79.2020.06.16.07.18.18
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 16 Jun 2020 07:18:19 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 36/78] dp8393x: Pad frames to word or long word boundary
Date: Tue, 16 Jun 2020 09:15:05 -0500
Message-Id: <20200616141547.24664-37-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
References: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=flukshun@gmail.com; helo=mail-ot1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Jason Wang <jasowang@redhat.com>, qemu-stable@nongnu.org,
 Finn Thain <fthain@telegraphics.com.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Finn Thain <fthain@telegraphics.com.au>

The existing code has a bug where the Remaining Buffer Word Count (RBWC)
is calculated with a truncating division, which gives the wrong result
for odd-sized packets.

Section 1.4.1 of the datasheet says,

    Once the end of the packet has been reached, the serializer will
    fill out the last word (16-bit mode) or long word (32-bit mode)
    if the last byte did not end on a word or long word boundary
    respectively. The fill byte will be 0FFh.

Implement buffer padding so that buffer limits are correctly enforced.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Tested-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
(cherry picked from commit 350e7d9a77d3b9ac74d240e4b232db1ebe5c05bc)
*drop context dependencies from b7cbebf2b9d, 1ccda935d4f, and
 19f70347731
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/net/dp8393x.c | 39 ++++++++++++++++++++++++++++-----------
 1 file changed, 28 insertions(+), 11 deletions(-)

diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index 40e3a029b6..0e9061d831 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -766,16 +766,23 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
     dp8393xState *s = qemu_get_nic_opaque(nc);
     int packet_type;
     uint32_t available, address;
-    int width, rx_len = pkt_size;
+    int width, rx_len, padded_len;
     uint32_t checksum;
     int size;
 
-    width = (s->regs[SONIC_DCR] & SONIC_DCR_DW) ? 2 : 1;
-
     s->regs[SONIC_RCR] &= ~(SONIC_RCR_PRX | SONIC_RCR_LBK | SONIC_RCR_FAER |
         SONIC_RCR_CRCR | SONIC_RCR_LPKT | SONIC_RCR_BC | SONIC_RCR_MC);
 
-    if (pkt_size + 4 > dp8393x_rbwc(s) * 2) {
+    rx_len = pkt_size + sizeof(checksum);
+    if (s->regs[SONIC_DCR] & SONIC_DCR_DW) {
+        width = 2;
+        padded_len = ((rx_len - 1) | 3) + 1;
+    } else {
+        width = 1;
+        padded_len = ((rx_len - 1) | 1) + 1;
+    }
+
+    if (padded_len > dp8393x_rbwc(s) * 2) {
         DPRINTF("oversize packet, pkt_size is %d\n", pkt_size);
         s->regs[SONIC_ISR] |= SONIC_ISR_RBAE;
         dp8393x_update_irq(s);
@@ -810,22 +817,32 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
     s->regs[SONIC_TRBA0] = s->regs[SONIC_CRBA0];
 
     /* Calculate the ethernet checksum */
-    checksum = cpu_to_le32(crc32(0, buf, rx_len));
+    checksum = cpu_to_le32(crc32(0, buf, pkt_size));
 
     /* Put packet into RBA */
     DPRINTF("Receive packet at %08x\n", dp8393x_crba(s));
     address = dp8393x_crba(s);
     address_space_rw(&s->as, address,
-        MEMTXATTRS_UNSPECIFIED, (uint8_t *)buf, rx_len, 1);
-    address += rx_len;
+        MEMTXATTRS_UNSPECIFIED, (uint8_t *)buf, pkt_size, 1);
+    address += pkt_size;
+
+    /* Put frame checksum into RBA */
     address_space_rw(&s->as, address,
-        MEMTXATTRS_UNSPECIFIED, (uint8_t *)&checksum, 4, 1);
-    address += 4;
-    rx_len += 4;
+        MEMTXATTRS_UNSPECIFIED, (uint8_t *)&checksum, sizeof(checksum), 1);
+    address += sizeof(checksum);
+
+    /* Pad short packets to keep pointers aligned */
+    if (rx_len < padded_len) {
+        size = padded_len - rx_len;
+        address_space_rw(&s->as, address, MEMTXATTRS_UNSPECIFIED,
+            (uint8_t *)"\xFF\xFF\xFF", size, 1);
+        address += size;
+    }
+
     s->regs[SONIC_CRBA1] = address >> 16;
     s->regs[SONIC_CRBA0] = address & 0xffff;
     available = dp8393x_rbwc(s);
-    available -= rx_len / 2;
+    available -= padded_len >> 1;
     s->regs[SONIC_RBWC1] = available >> 16;
     s->regs[SONIC_RBWC0] = available & 0xffff;
 
-- 
2.17.1


