Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F35C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:14:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E115E206FA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MhzHMidq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E115E206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD7zh-0002Fs-2p
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 11:14:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kD7TA-0004EA-Pd; Tue, 01 Sep 2020 10:41:08 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39144)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kD7T9-0008Rq-7b; Tue, 01 Sep 2020 10:41:08 -0400
Received: by mail-wm1-x344.google.com with SMTP id b79so1404896wmb.4;
 Tue, 01 Sep 2020 07:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Yw0o3aDHS2ktNtFlFwU+FwiNBr3VIt0o9HwcG9CrL1o=;
 b=MhzHMidqhoXGQZqvzWG9dkGG11BwkkaD68W7LIT4q72sUUaBo+YDQ7IKv15oaJ8qla
 wjbBBrKxZ7yiyq624NNO+zOwMjwmzPXcN2XfdwQ+oICWFbzHQ0KFJ9f/zVkwyez/HU+T
 GvTLsP5163UUxsd5EPPL+t/mHTehlv9gG1Zf81ee4nbXwYuBLbXyNPwSnde/v0DyxlZ+
 IggVGyTeDevj9xbDjXWsYRhmsgT5ejh75A9dM4mJ0ACwWULPoUxJ1Kapfjh1AOa+y82V
 JupWedHRGCG0FxpOJ5bDJNkKnyfC5PWGfhs4zOthvnYr/oGPtf8S8STl618fa8o8SZps
 ef7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Yw0o3aDHS2ktNtFlFwU+FwiNBr3VIt0o9HwcG9CrL1o=;
 b=SFWcQ86VryJQtpyZ2ZWJHSzC42DbtyEBooQ3KDIEksU/5Qkp6yikxUELU47IR/dz8W
 IHmD0vN4ER82GncO9jfJX0SgpiyLPhwU1C4FgLtM96ajWA5BC+6a606AwNt3CQb12aiF
 jrF2F6d+OqAzJVCuellYMf4IBmOF9oAOsQr1TK1rnPZux+wde5qmirKe5FvUXaaHBDtc
 YN6twdVoH67seK2KTjbelwT1gMYEjRVAPGtfruzf5vp+iQCcss50/uO0lJ5nV81jnCtJ
 SpUp/wctTWPm7plg8kpUsEF2S5F55ooZtOmSakEkzRzfnAhcgRAliJEB7hBKL0l0Ejyj
 9hoQ==
X-Gm-Message-State: AOAM530hXEuCjIoNk5SQRtvXDbyuRezUYvGTkasyoSv5/aOG8mGV/q6n
 k2qk/c0LvPh+m5owgq3AetXpdSkMSQU=
X-Google-Smtp-Source: ABdhPJx4JjS4906P0zwy5E9hRQ5IeDMxQktg+ks+CiWeSOvnKXMad5hUY7dLNBrgm9SY6KAvVPOAdA==
X-Received: by 2002:a1c:1f42:: with SMTP id f63mr2044061wmf.1.1598971265339;
 Tue, 01 Sep 2020 07:41:05 -0700 (PDT)
Received: from localhost.localdomain (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id a82sm2213204wmc.45.2020.09.01.07.41.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 07:41:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/4] hw/misc/a9scu: Simplify setting MemoryRegionOps::valid
 fields
Date: Tue,  1 Sep 2020 16:40:58 +0200
Message-Id: <20200901144100.116742-3-f4bug@amsat.org>
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

Per the datasheet (DDI0407 r2p0):

  "All SCU registers are byte accessible" and are 32-bit aligned.

Set MemoryRegionOps::valid min/max fields and simplify the write()
handler.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/misc/a9scu.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/hw/misc/a9scu.c b/hw/misc/a9scu.c
index 915f127761e..3f3dcc414fe 100644
--- a/hw/misc/a9scu.c
+++ b/hw/misc/a9scu.c
@@ -52,23 +52,8 @@ static void a9_scu_write(void *opaque, hwaddr offset,
                          uint64_t value, unsigned size)
 {
     A9SCUState *s = (A9SCUState *)opaque;
-    uint32_t mask;
+    uint32_t mask = MAKE_64BIT_MASK(0, size * 8);
     uint32_t shift;
-    switch (size) {
-    case 1:
-        mask = 0xff;
-        break;
-    case 2:
-        mask = 0xffff;
-        break;
-    case 4:
-        mask = 0xffffffff;
-        break;
-    default:
-        fprintf(stderr, "Invalid size %u in write to a9 scu register %x\n",
-                size, (unsigned)offset);
-        return;
-    }
 
     switch (offset) {
     case 0x00: /* Control */
@@ -99,6 +84,10 @@ static void a9_scu_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps a9_scu_ops = {
     .read = a9_scu_read,
     .write = a9_scu_write,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+    },
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
-- 
2.26.2


