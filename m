Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CA9C433E7
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:05:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BA0620BED
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u/VemtCj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BA0620BED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD7qu-00036f-LK
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 11:05:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36758)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kD7TC-0004Fo-Ot; Tue, 01 Sep 2020 10:41:10 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:51179)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kD7TA-0008S7-E9; Tue, 01 Sep 2020 10:41:09 -0400
Received: by mail-wm1-x344.google.com with SMTP id e17so1425422wme.0;
 Tue, 01 Sep 2020 07:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pHNAYrNieu1B/5GPFduULWjxl/G5it3aeYsEpJLKzAg=;
 b=u/VemtCjA72ycMPJGwnhrVInkqeGfOL1kePfJtx7FgMOpP245ld2tOqRqkNzz3YSRC
 q/bzmZipjQP/p3GauRf3IsbEuQj/+9o9z+taZop4xwR29HjByzwPhrrrTtqhBYogeuNX
 6i/9nHaJgs81Wi5ILVJ31wMMqcQYVdTlcfmQrFfavl7yJ0H0j6HqvhI8e2yMCgYaEnrM
 1JCrL6c64tERQCAor935U5JGUI/hcAkcB0w8c7j+GzNYsBicyG3O0zJ89Lh+kPjUhb7I
 D0WZaTDwKhqeI9HEmBcMmhLMrrx0w2gsFc5BOVxEvFgHAfQNFrLA+JRMMwuzxHRGUmSG
 ob2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=pHNAYrNieu1B/5GPFduULWjxl/G5it3aeYsEpJLKzAg=;
 b=QhcLh9ikpIf1yJcoyw6t5n79Z0sGhG2YWSxSKfsQMnTbXh8jhW2lO4qZFO98e/2njg
 RCre6kVP+GfulCt0e8qD7445Z8nJVkyaJ3e2D4txMY/b6EHdG+ThLc43WRpmt/mQ1g/g
 SJkMeO/nggA7BNx1zNBtP2VvpsyAYbjmKDYlkDHsd042IiDYanbY1P4Nr1z3jQgUQk1S
 qpf6wjcXsu0bpJjF2MlPJ5VjNxCXJr5eGMNCzRmIytpKaOlkwTNMrHsZ773V7C4qA4HS
 e72H3dJmYhbPaObYZzi+z/GyfdWwqTTbn3E7EYYUthaw072d+6rzAsuAlsvYuV+fx2Nu
 0W8w==
X-Gm-Message-State: AOAM530DRtqKbG1HM/uCv2paTeQPMFDBa+RZwv3zKk7qLpdL3+ePr2AS
 n9MR1LMwq46stPjq8SrmKOFPH9g93lg=
X-Google-Smtp-Source: ABdhPJw6oWec4iF2ldZ49pXjCurt3QO6RRa5U5qQQZAhrKvuedgTBnuKiU0l/ZO922hg0FHzBB9t0Q==
X-Received: by 2002:a1c:2cd7:: with SMTP id s206mr2174171wms.165.1598971266604; 
 Tue, 01 Sep 2020 07:41:06 -0700 (PDT)
Received: from localhost.localdomain (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id a82sm2213204wmc.45.2020.09.01.07.41.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 07:41:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/4] hw/misc/a9scu: Simplify setting MemoryRegionOps::impl
 fields
Date: Tue,  1 Sep 2020 16:40:59 +0200
Message-Id: <20200901144100.116742-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901144100.116742-1-f4bug@amsat.org>
References: <20200901144100.116742-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This model implementation is designed for 32-bit accesses.
We can simplify setting the MemoryRegionOps::impl min/max
fields to 32-bit (memory::access_with_adjusted_size() will
take care of the 8/16-bit accesses).

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
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
2.26.2


