Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 907AAC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:36:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F84220644
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0P1fCs0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F84220644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlChi-0000HW-DT
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 10:36:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57568)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCPi-000245-SS; Tue, 16 Jun 2020 10:18:14 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:39887)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCPh-0006eg-DQ; Tue, 16 Jun 2020 10:18:10 -0400
Received: by mail-ot1-x341.google.com with SMTP id g5so16041041otg.6;
 Tue, 16 Jun 2020 07:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qxAqQFVt+5Z+veIt3jtnU/iIs7pS1pZXvHm2/UIl5LA=;
 b=Z0P1fCs0bIYARh55Bb4MF2ocZsAl8++yrxp6SZfJLGZb9VzrYtF9ZPhCSx8wwVrZ6S
 Fz32GHDnHOtpRNU3zsWc3hCpN4S5LJdt+Pyk3t/1eEegTrRZUuS4VdXCN9e0VMMcnDmE
 L3aGXesVd/GNqsODCJZHKKmDT/g9ttqPOG4c8B0ueZLcrAg0xFC2HUES/6euhDOvZ3rv
 h25I0BcQ7pGdBKOyC4Ey3XQoVHIFj3X96NI8dhDQhYLTVyDMTCbRsC+loXvl/oAsVIZs
 Vg+H2B9sox/wrMRhVjwzD3yTZHCYJRk/qBJq7ItgkYSwt8CujsJ58w8ECVPXPmGNtFV9
 yLHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=qxAqQFVt+5Z+veIt3jtnU/iIs7pS1pZXvHm2/UIl5LA=;
 b=kEG9mfhyyEY6J8K1FDPJkEtQtfTEn9dCSa6bzKaSy7EI9Gyp7vBJfvpYYh9dYj6Cvy
 ASSjZJwC/VwwQw2zwrcUflN4bnOrAEbSMPfYZvVQeLLaCJacbxhX5MWRVm2PH1Grg7Es
 Ln2C8HHMXNXY0Z2y0JD35xOgb4Rw2oe9T+cuDkOQEiRx8yGnfeJVJK7texeZBcdsIBWt
 1/8qsjwzWqdkZTu2QoEPt3+7SDghImIZcM0y6jR+TJJ48eLY5smN6mvfTUXkV8VGeZKK
 lDkwv7+ONNtaEXy6mB9E0E7GQgUSyWqtPY8QL/k47RxIApMvRIlowdfh4NLM/XJ2VJTv
 uXMg==
X-Gm-Message-State: AOAM5323CsWVgiue+mGnnt4djBjBK0W20tmZjqNn0B1HYQI75xvRdZut
 T/BttK5vm5rYyG1zF4rN7PeyweL0
X-Google-Smtp-Source: ABdhPJxkRxGvh/DInT2u0J7dOJCyN/ll805IpZZ+EVAPK42EFze7d8NHgo+s4ABYqRkEmdMxv2LYBA==
X-Received: by 2002:a9d:3a24:: with SMTP id j33mr2508220otc.271.1592317087119; 
 Tue, 16 Jun 2020 07:18:07 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id t10sm154950oij.36.2020.06.16.07.18.05
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 16 Jun 2020 07:18:06 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 30/78] dp8393x: Have dp8393x_receive() return the packet size
Date: Tue, 16 Jun 2020 09:14:59 -0500
Message-Id: <20200616141547.24664-31-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
References: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=flukshun@gmail.com; helo=mail-ot1-x341.google.com
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

This function re-uses its 'size' argument as a scratch variable.
Instead, declare a local 'size' variable for that purpose so that the
function result doesn't get messed up.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Jason Wang <jasowang@redhat.com>
(cherry picked from commit 9e3cd456d85ad45e72bdba99203302342ce29b3b)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/net/dp8393x.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index f89f4c7ba3..a696485a55 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -757,20 +757,21 @@ static int dp8393x_receive_filter(dp8393xState *s, const uint8_t * buf,
 }
 
 static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
-                               size_t size)
+                               size_t pkt_size)
 {
     dp8393xState *s = qemu_get_nic_opaque(nc);
     int packet_type;
     uint32_t available, address;
-    int width, rx_len = size;
+    int width, rx_len = pkt_size;
     uint32_t checksum;
+    int size;
 
     width = (s->regs[SONIC_DCR] & SONIC_DCR_DW) ? 2 : 1;
 
     s->regs[SONIC_RCR] &= ~(SONIC_RCR_PRX | SONIC_RCR_LBK | SONIC_RCR_FAER |
         SONIC_RCR_CRCR | SONIC_RCR_LPKT | SONIC_RCR_BC | SONIC_RCR_MC);
 
-    packet_type = dp8393x_receive_filter(s, buf, size);
+    packet_type = dp8393x_receive_filter(s, buf, pkt_size);
     if (packet_type < 0) {
         DPRINTF("packet not for netcard\n");
         return -1;
@@ -864,7 +865,7 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
     /* Done */
     dp8393x_update_irq(s);
 
-    return size;
+    return pkt_size;
 }
 
 static void dp8393x_reset(DeviceState *dev)
-- 
2.17.1


