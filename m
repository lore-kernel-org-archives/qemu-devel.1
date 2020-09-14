Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6ADBC2BC11
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 14:07:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 172EC2074B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 14:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dtpOork2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 172EC2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHp8u-0003jf-6O
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 10:07:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45742)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHp86-00020t-9Y
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 10:06:50 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:47055)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHp84-0007Wn-JJ
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 10:06:50 -0400
Received: by mail-wr1-x42b.google.com with SMTP id o5so18847866wrn.13
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 07:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=aRJ9Ctg8nu6Xf2XlWQqq0q3Iaknb86w8CHVdR6KxCHE=;
 b=dtpOork2t3bZhN3xMU+Qhef5vABHCpss+O8g6ALeGbd0AIkJBYL/V/G9RuSD+45y+K
 Sz6y6fQCjYns6+uHgcdpnrpMdRRGg5H4gdDpHVzoYEuvn34E3ir2nnCtMTKRoNQ+qwP7
 X+s51QCAln2irHfb0+yNUP/2zLOQrgQULHIaiGeZJUgIgTvTTa6cNIXH5K8YvPKem1b2
 Q3ORHZ1ee9R6fx61H4n4/TV4sZtNXtg8l2nzJW61SRt7zR5mowx51azDkzg0OXSr0WV3
 cks+fhjXLSUh8RlfYlYXksLmYvEbEmf8xwlQ16B2+KmLOt/9edM4+fmyH+/v1q5MRgVL
 CGmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aRJ9Ctg8nu6Xf2XlWQqq0q3Iaknb86w8CHVdR6KxCHE=;
 b=OsqbJpZ+clUIyp9FaDcWBNeZmi04j1JSp+sZkafTS38dgmu6xe3827xHOwWMCOkOLI
 DqOgBu/qag1gsfM5jMZLuj6P8HfUQGeKwfN6dbKvzaPHPT04bWJD6v8iHekxbJu7heHg
 rvm05cmBwcm+N+05ZfUfxIPO/VONjU90dtqz5pVrpTHezvLgODtOuaGYGfvWFpuZ97Vv
 2WorIl3609cIjg1A6ivkSVoeJLMPDmOH9Y6WWOoffH505R8lXpcubJkxGgQuphKUbgmJ
 lBt64iZ1id0QrlD8sS4fMEc7bGiMTcBXULQ/uJWfElT0qrJDvhInlmnSiTPbMtQo3ecE
 laug==
X-Gm-Message-State: AOAM530L+QRHPipbj/E0weolEEzeT7qmWBN2P3MbjtoWXDY+zg7MoSwV
 w8008NbkSt2RmH3V4pJgY1Omlp2MbJBmi+XX
X-Google-Smtp-Source: ABdhPJwBfJV5h4ZcT0Vkly8BmgoKCItdP+ABDoRn35Tfi6+GGSwMjbZN5LjXW6oPCbWcAoGxYDlOJA==
X-Received: by 2002:adf:ec4d:: with SMTP id w13mr16680493wrn.334.1600092406819; 
 Mon, 14 Sep 2020 07:06:46 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id x16sm20834041wrq.62.2020.09.14.07.06.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 07:06:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/36] hw/misc/a9scu: Simplify setting MemoryRegionOps::impl
 fields
Date: Mon, 14 Sep 2020 15:06:08 +0100
Message-Id: <20200914140641.21369-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200914140641.21369-1-peter.maydell@linaro.org>
References: <20200914140641.21369-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

This model implementation is designed for 32-bit accesses.
We can simplify setting the MemoryRegionOps::impl min/max
fields to 32-bit (memory::access_with_adjusted_size() will
take care of the 8/16-bit accesses).

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200901144100.116742-4-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/a9scu.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/hw/misc/a9scu.c b/hw/misc/a9scu.c
index 3f3dcc414fe..47f948341f7 100644
--- a/hw/misc/a9scu.c
+++ b/hw/misc/a9scu.c
@@ -28,12 +28,6 @@ static uint64_t a9_scu_read(void *opaque, hwaddr offset,
         return (((1 << s->num_cpu) - 1) << 4) | (s->num_cpu - 1);
     case 0x08: /* CPU Power Status */
         return s->status;
-    case 0x09: /* CPU status.  */
-        return s->status >> 8;
-    case 0x0a: /* CPU status.  */
-        return s->status >> 16;
-    case 0x0b: /* CPU status.  */
-        return s->status >> 24;
     case 0x0c: /* Invalidate All Registers In Secure State */
         return 0;
     case 0x40: /* Filtering Start Address Register */
@@ -52,8 +46,6 @@ static void a9_scu_write(void *opaque, hwaddr offset,
                          uint64_t value, unsigned size)
 {
     A9SCUState *s = (A9SCUState *)opaque;
-    uint32_t mask = MAKE_64BIT_MASK(0, size * 8);
-    uint32_t shift;
 
     switch (offset) {
     case 0x00: /* Control */
@@ -62,9 +54,7 @@ static void a9_scu_write(void *opaque, hwaddr offset,
     case 0x4: /* Configuration: RO */
         break;
     case 0x08: case 0x09: case 0x0A: case 0x0B: /* Power Control */
-        shift = (offset - 0x8) * 8;
-        s->status &= ~(mask << shift);
-        s->status |= ((value & mask) << shift);
+        s->status = value;
         break;
     case 0x0c: /* Invalidate All Registers In Secure State */
         /* no-op as we do not implement caches */
@@ -84,6 +74,10 @@ static void a9_scu_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps a9_scu_ops = {
     .read = a9_scu_read,
     .write = a9_scu_write,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
     .valid = {
         .min_access_size = 1,
         .max_access_size = 4,
-- 
2.20.1


