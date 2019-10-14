Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 682D0C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 11:05:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3064D20650
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 11:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v9WBT6g9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3064D20650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJy9v-0004kc-0X
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 07:05:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45362)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iJy23-0006TP-It
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:56:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iJy22-00050T-F2
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:56:55 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:34903)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iJy22-0004za-8Q
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:56:54 -0400
Received: by mail-wm1-x343.google.com with SMTP id y21so16283819wmi.0
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 03:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Ouhbdjwj8mfD0TiFH/h8tXJayT2ifkgem8zqWo4b7jU=;
 b=v9WBT6g9jwv5whm8VpF8ZW63fhYRq2OUCbxJ/bzgG04sSQbzSbQ7uloTcvJ0BCryfY
 3j5f2NT/rX7W7NN1nH81Eex7M1HZt1IWzzqY91Lbq2OT9/1+VP8ge8snLqPK3pWxekCx
 XwlUEwDxsgYP6iJJxraWpXqn1mrop3hWZVnCBFCQUO/ts3JpkF8Sa+AQ5JsGLb9BYpv3
 TUy+jVB5MvnPkiBb0idzqDjKmQzlZJ7ddXFoMg4Nnq9KgNsH1Ee5q6LxzUtz4KzG+Rw5
 x6KHlwR0lhj8zfnDJfOzwa5KNPeODamMd424UbheNtoxXx6Em8TYRLlXCak7T5hgVtcK
 tJgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ouhbdjwj8mfD0TiFH/h8tXJayT2ifkgem8zqWo4b7jU=;
 b=NLhihYkM/gqnrfUJ6gOmMWRnDPpGgRdH1KH9KwNRBS10JMFuaIhCdjMZirGUJ8rsKS
 u+iOqUQyDg7VrqREC0mbvkxxQy0x4HgCC1zqDKxU0XatT1+Bjf9Fpt47n/DwCkndGjOb
 06KREjBzBFdj4r8pZR21WEqqHKe8DmR24PCGNPApjBp1570kqv898ZnsolylsdKobmpc
 xvuDs9Ca8XUS2ExrooOj7CD3B7eGOvpWw6lf2bp3D9CSSH0v9kctG0ewvxAaO13A+2Ml
 l5NPlDQgdotWdFaTM8WIU/KPtKso8keYWRxhlWn/7sC+Ly4cnBBzz9vrdB6GT2kTO6ZU
 QhZQ==
X-Gm-Message-State: APjAAAVOr+Uxp6LGxpvsrels1yvaJT/41mCDlPO/be/akR9i6CZ1/9kC
 YCBIE5RQ4K5hlSuJoiBjKuZRAg==
X-Google-Smtp-Source: APXvYqw+Sy+2GOVxnqGLB+VwMOkIf0a2n785ax5TTMMbu2QiA0Mb8FEE/QeJv+BYH9DZvRX1aFHwyQ==
X-Received: by 2002:a1c:e404:: with SMTP id b4mr15499090wmh.90.1571050613042; 
 Mon, 14 Oct 2019 03:56:53 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id r2sm40163867wma.1.2019.10.14.03.56.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 03:56:52 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 91ABD1FF87;
 Mon, 14 Oct 2019 11:49:56 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v5 33/55] target/xtensa: fetch code with translator_ld
Date: Mon, 14 Oct 2019 11:49:26 +0100
Message-Id: <20191014104948.4291-34-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014104948.4291-1-alex.bennee@linaro.org>
References: <20191014104948.4291-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: robert.foley@futurewei.com,
 Richard Henderson <richard.henderson@linaro.org>, peter.puhov@futurewei.com,
 Max Filippov <jcmvbkbc@gmail.com>, aaron@os.amperecomputing.com,
 cota@braap.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Signed-off-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/xtensa/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index d20e60ce77..a99f5296e2 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -859,7 +859,7 @@ static int arg_copy_compare(const void *a, const void *b)
 static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc)
 {
     xtensa_isa isa = dc->config->isa;
-    unsigned char b[MAX_INSN_LENGTH] = {cpu_ldub_code(env, dc->pc)};
+    unsigned char b[MAX_INSN_LENGTH] = {translator_ldub(env, dc->pc)};
     unsigned len = xtensa_op0_insn_len(dc, b[0]);
     xtensa_format fmt;
     int slot, slots;
@@ -883,7 +883,7 @@ static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc)
 
     dc->base.pc_next = dc->pc + len;
     for (i = 1; i < len; ++i) {
-        b[i] = cpu_ldub_code(env, dc->pc + i);
+        b[i] = translator_ldub(env, dc->pc + i);
     }
     xtensa_insnbuf_from_chars(isa, dc->insnbuf, b, len);
     fmt = xtensa_format_decode(isa, dc->insnbuf);
-- 
2.20.1


