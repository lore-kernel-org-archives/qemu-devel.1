Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 270E3C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 17:14:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9648722202
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 17:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X5nO/VDO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9648722202
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb5Jx-0005FK-JN
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 12:14:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34730)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kb5HR-0001Gs-9N
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 12:12:06 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:56185)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kb5HM-0003Mr-7Z
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 12:12:04 -0500
Received: by mail-wm1-x341.google.com with SMTP id c9so2157211wml.5
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2020 09:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QhdTsNE656tCSH0NDovdU3as+214FeSLljyeY/SGz5M=;
 b=X5nO/VDOGnJSTvMSrC9dJNpaAAh5GvemOQF6NG2wwUF6rcGcXDaY33lp+Lsnta0HI9
 ttoDZnr4m/W0O9U8CiPmMTSW3OtzrJXiNRZiMhvOthGWoz6g9SMrIXuXaamg6hhCCB+F
 OBwIIPaqefmxEGwJHXPTrO9gQIQuo1/9PzdQtQku+uEWOG9dd5vel3mXj/AuqDKBG7aY
 nkRS+e9Hq8VT7TK1l/xPU7CybaylTFoIZvYM9+mGbiAhydlTbHGGy+ixMbb85sovPh+d
 H2Yt1eTKRmcc1iu5pGdiXpnUjKlLQ1z9CEhtrjqtUYp6jjpvJBnV+Hl1bwjIV8wZO14B
 P33g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QhdTsNE656tCSH0NDovdU3as+214FeSLljyeY/SGz5M=;
 b=b94fZei8BtwB7vcg10LA6gAJNWIYqEjU4v5fKUvsbicgFEPD7CSrnwOUiyVBmiGK1U
 U/ScRN9+84rlCksrSJD2NlRgL1zJTGyaEO1hibb1+/5vS+5KcmOBxpLLnhckafR/X4tV
 bUTN4Q8ihSzDRCEzRq/75TLzHt1LUbWXQurpTKzsXW6pSOlBJ19rmkJvnG8OqbExqG50
 zKcP8biDwLFpJGWIHV8Llv6BOtLNdw5+nG+op/qpHaxbwCjEyuiWj4lwja9hyzqjd7E7
 FbYei9F2ZmAIWRomHkBxE5TakTLd506HCTGxYQ1yoxeyINa0IeqstJTw3fUy5k7oT9g7
 E7Ng==
X-Gm-Message-State: AOAM532/gjHPV7Xz8y4/69iMboggzZDjxTI9eNwKbeEAQDmNOWbPNSpX
 xHo6BnjdZNHpNs56XnWHqXIs3jA61BmUvg==
X-Google-Smtp-Source: ABdhPJx6W0XmIxaopniDiBl5L3OD0tuUdW0BkeGt71ef2/tXefEfZ6kLSdIsKVacBRYfonC24ufROA==
X-Received: by 2002:a05:600c:2048:: with SMTP id
 p8mr574200wmg.165.1604682718310; 
 Fri, 06 Nov 2020 09:11:58 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id l1sm3162649wrb.1.2020.11.06.09.11.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2020 09:11:57 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.2 2/4] hw/net/can/ctucan: Avoid unused value in
 ctucan_send_ready_buffers()
Date: Fri,  6 Nov 2020 17:11:51 +0000
Message-Id: <20201106171153.32673-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201106171153.32673-1-peter.maydell@linaro.org>
References: <20201106171153.32673-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Jason Wang <jasowang@redhat.com>, Vikram Garhwal <fnu.vikram@xilinx.com>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Coverity points out that in ctucan_send_ready_buffers() we
set buff_st_mask = 0xf << (i * 4) inside the loop, but then
we never use it before overwriting it later.

The only thing we use the mask for is as part of the code that is
inserting the new buff_st field into tx_status.  That is more
comprehensibly written using deposit32(), so do that and drop the
mask variable entirely.

We also update the buff_st local variable at multiple points
during this function, but nothing can ever see these
intermediate values, so just drop those, write the final
TXT_TOK as a fixed constant value, and collapse the only
remaining set/use of buff_st down into an extract32().

Fixes: Coverity CID 1432869
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/can/ctucan_core.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/hw/net/can/ctucan_core.c b/hw/net/can/ctucan_core.c
index ea09bf71a0c..f2ce978e5ec 100644
--- a/hw/net/can/ctucan_core.c
+++ b/hw/net/can/ctucan_core.c
@@ -240,8 +240,6 @@ static void ctucan_send_ready_buffers(CtuCanCoreState *s)
     uint8_t *pf;
     int buff2tx_idx;
     uint32_t tx_prio_max;
-    unsigned int buff_st;
-    uint32_t buff_st_mask;
 
     if (!s->mode_settings.s.ena) {
         return;
@@ -256,10 +254,7 @@ static void ctucan_send_ready_buffers(CtuCanCoreState *s)
         for (i = 0; i < CTUCAN_CORE_TXBUF_NUM; i++) {
             uint32_t prio;
 
-            buff_st_mask = 0xf << (i * 4);
-            buff_st = (s->tx_status.u32 >> (i * 4)) & 0xf;
-
-            if (buff_st != TXT_RDY) {
+            if (extract32(s->tx_status.u32, i * 4, 4) != TXT_RDY) {
                 continue;
             }
             prio = (s->tx_priority.u32 >> (i * 4)) & 0x7;
@@ -271,10 +266,7 @@ static void ctucan_send_ready_buffers(CtuCanCoreState *s)
         if (buff2tx_idx == -1) {
             break;
         }
-        buff_st_mask = 0xf << (buff2tx_idx * 4);
-        buff_st = (s->tx_status.u32 >> (buff2tx_idx * 4)) & 0xf;
         int_stat.u32 = 0;
-        buff_st = TXT_RDY;
         pf = s->tx_buffer[buff2tx_idx].data;
         ctucan_buff2frame(pf, &frame);
         s->status.s.idle = 0;
@@ -283,12 +275,11 @@ static void ctucan_send_ready_buffers(CtuCanCoreState *s)
         s->status.s.idle = 1;
         s->status.s.txs = 0;
         s->tx_fr_ctr.s.tx_fr_ctr_val++;
-        buff_st = TXT_TOK;
         int_stat.s.txi = 1;
         int_stat.s.txbhci = 1;
         s->int_stat.u32 |= int_stat.u32 & ~s->int_mask.u32;
-        s->tx_status.u32 = (s->tx_status.u32 & ~buff_st_mask) |
-                        (buff_st << (buff2tx_idx * 4));
+        s->tx_status.u32 = deposit32(s->tx_status.u32,
+                                     buff2tx_idx * 4, 4, TXT_TOK);
     } while (1);
 }
 
-- 
2.20.1


