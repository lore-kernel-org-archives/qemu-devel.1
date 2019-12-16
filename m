Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBE4C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:28:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 773A6206D3
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qfBbRMXQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 773A6206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igoYA-0007Lh-4k
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 06:28:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50956)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1igoFg-0007hR-7W
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1igoFf-0007wC-2L
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:24 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44284)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1igoFe-0007rl-Rt
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:23 -0500
Received: by mail-wr1-x443.google.com with SMTP id q10so6693657wrm.11
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 03:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=8rDgs8l8yhYpP9GCvm5KtL7CxF0GTpM1OtN2KNG9tUw=;
 b=qfBbRMXQSQxnwS5albiV/s1zdMXJ6wvpNxV6M7+pKp8wZMtrxmFlUHMy9Ol981Zv65
 NhywM6UrQs2z6L+T7RuVaUVCFQO9UZxV23hRpoDEEHsgVEjmlLxvn6zihiGcuxv3XkWn
 elwG/MVqgqDBrOR+uN9bvOZlBD3ru37CewF75s8pNATs5pDVCgHaGV2U1ARi82+C96xo
 u5RvNd88OVrQrD+piiHm/A3TA9nsWlQaHjn9GoLiVXXFd6LOvL8GN8ZvAxx3EZBs+o+j
 cGLOWLx1XMTD7+Uop62aHk3JJ7b0ZwP0Pu4zS0iRbrdsA+q2EXJyBZxQvr98Pmrw615B
 gwjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8rDgs8l8yhYpP9GCvm5KtL7CxF0GTpM1OtN2KNG9tUw=;
 b=FpGcFANCH1hrWz1yiyuDXyW/3ES7V/sEnpsVdJa25Q8zQhnXl4d8JSgPtCXEe22Pfj
 /ZXzMN/PumLoYnrfi92VxxJqqXNm5N0a0jeEUfozOL+iLIp+eLfv2YVXuy7WaOCRb35p
 AnmXn8oZcQZa6KyBsuQ0Fx5OvWq/d6UhZG5j5gt8HzR/ILOTCSoISBs8hiOj4rtkC9TB
 1PXm2ix1opVQVk4SPLM49B0U8W/qS45VQTb1MeH0f0QT62WNB7gIcbygkYMh4MGeSZau
 y0Xjl6xOUE+SPDSDTjoUNHxQBp+/Kw/tt9ERznRZvQ8TlAjUJEAv52i3jsL2sDVvPJn8
 2g0g==
X-Gm-Message-State: APjAAAUh5QlBVbq8kew86mj29Jr3FCOJ2QmhJDqpTKUJRAI3EhR9q83J
 xS9oAOy7Z9FBX7721Chq0uVmXMWudNIrcA==
X-Google-Smtp-Source: APXvYqxztDoYruacIIrId+8h1MckXe97LibQn4T17AKawD6xYAxu6/WLQ9IGX0IJudhPgFJr6kgklA==
X-Received: by 2002:adf:de84:: with SMTP id w4mr28220192wrl.97.1576494561724; 
 Mon, 16 Dec 2019 03:09:21 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id x10sm20976131wrp.58.2019.12.16.03.09.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 03:09:21 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/34] aspeed/smc: Do not map disabled segment on the AST2600
Date: Mon, 16 Dec 2019 11:08:43 +0000
Message-Id: <20191216110904.30815-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216110904.30815-1-peter.maydell@linaro.org>
References: <20191216110904.30815-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Cédric Le Goater <clg@kaod.org>

The segments can be disabled on the AST2600 (zero register value).
CS0 is open by default but not the other CS. This is closing the
access to the flash device in user mode and forbids scanning.

In the model, check the segment size and disable the associated region
when the value is zero.

Fixes: bcaa8ddd081c ("aspeed/smc: Add AST2600 support")
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Message-id: 20191119141211.25716-12-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/ssi/aspeed_smc.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index 955ec21852a..86cadbe4cc0 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -444,8 +444,13 @@ static void aspeed_2600_smc_reg_to_segment(const AspeedSMCState *s,
     uint32_t start_offset = (reg << 16) & AST2600_SEG_ADDR_MASK;
     uint32_t end_offset = reg & AST2600_SEG_ADDR_MASK;
 
-    seg->addr = s->ctrl->flash_window_base + start_offset;
-    seg->size = end_offset + MiB - start_offset;
+    if (reg) {
+        seg->addr = s->ctrl->flash_window_base + start_offset;
+        seg->size = end_offset + MiB - start_offset;
+    } else {
+        seg->addr = s->ctrl->flash_window_base;
+        seg->size = 0;
+    }
 }
 
 static bool aspeed_smc_flash_overlap(const AspeedSMCState *s,
@@ -486,7 +491,7 @@ static void aspeed_smc_flash_set_segment_region(AspeedSMCState *s, int cs,
     memory_region_transaction_begin();
     memory_region_set_size(&fl->mmio, seg.size);
     memory_region_set_address(&fl->mmio, seg.addr - s->ctrl->flash_window_base);
-    memory_region_set_enabled(&fl->mmio, true);
+    memory_region_set_enabled(&fl->mmio, !!seg.size);
     memory_region_transaction_commit();
 
     s->regs[R_SEG_ADDR0 + cs] = regval;
@@ -526,8 +531,9 @@ static void aspeed_smc_flash_set_segment(AspeedSMCState *s, int cs,
     }
 
     /* Keep the segment in the overall flash window */
-    if (seg.addr + seg.size <= s->ctrl->flash_window_base ||
-        seg.addr > s->ctrl->flash_window_base + s->ctrl->flash_window_size) {
+    if (seg.size &&
+        (seg.addr + seg.size <= s->ctrl->flash_window_base ||
+         seg.addr > s->ctrl->flash_window_base + s->ctrl->flash_window_size)) {
         qemu_log_mask(LOG_GUEST_ERROR, "%s: new segment for CS%d is invalid : "
                       "[ 0x%"HWADDR_PRIx" - 0x%"HWADDR_PRIx" ]\n",
                       s->ctrl->name, cs, seg.addr, seg.addr + seg.size);
-- 
2.20.1


