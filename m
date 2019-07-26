Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2819C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 18:06:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E7CE20657
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 18:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wa09kRYm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E7CE20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr4bn-0004l3-HS
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 14:06:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59853)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4Nz-0007fg-4D
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:52:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4Nv-0001SW-8G
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:52:05 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:38257)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hr4Nu-00013K-UG
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:52:03 -0400
Received: by mail-pf1-x442.google.com with SMTP id y15so24861302pfn.5
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 10:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=jvX6d8XTRW2yINP7UUXQMp5wulYHcQa40IZNorojim4=;
 b=Wa09kRYm6m3CF3ttivMMv8u/yQKXirGUlAJVWq4s8hIZCc1gyeFdJCRrNob2zTCJWQ
 lrCwA4+AzRPw+J4AJvZtpquXXt5eFlYD5ol9rVJufp+s+f+oqzyPQkc1kPm0BqF913Vz
 Bww8YS5g8Wsh/rZaM7NhrWOktQRCJBDtXvML3bTNiRUaepVEiDDW0MAF8Ld7ERVo7Oj9
 jrd1+ADjUKBWHNbYP15JpcwL0g1KP7+uH8kVoEAUo15Rn0RAUp3I0+Z8waiX1/DVLkP2
 Ei4TmzmUqskYn3FqJ7JFm0BFIfX22UKjw6dTA3dxK78iyUJacKIKi03qFMcpk0H9iD3d
 eevA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=jvX6d8XTRW2yINP7UUXQMp5wulYHcQa40IZNorojim4=;
 b=pMV2YAywcXWvr543wYMFa7HhCRrGdEkhCpJ4V3X5f4W7/nNT9u6KRGvtBjVvmY/Ytc
 vX4MxC/FOsNPFta/EAvAxtQHeDYPAWdDcmQ3dlKba1eSm5poNvLCr1BvTa+CSumHykDo
 KQp4J92jXAL62THXCgb9N/5AUgNr7imrBWQE/qsLdJQd3pP0HRcOxMxpjPfpI5wWkoWK
 N61OMcqj+w9lR6twSHW9OPnudA1/OaEDQBSVlwHbPjPZNzrvdJTKtFEBGLHWbi7AI/LC
 h9/HYcRzWmM2oATfwuBZ99otbsLbnZc0RfgXon2Fmfdbsx7cLIrKj+L8HkpvgafnGnwI
 H2uA==
X-Gm-Message-State: APjAAAWn0Xplubd68aR6sqp6enIIUH+na8vkfYQwtLDvnyz2qY5MqGtV
 22LzZDj9uMdNwgQgZsRYRpg+T+6CR74=
X-Google-Smtp-Source: APXvYqwtumCJAkOH7kSgFyzr4i+A3ue+GmiEwzCK9gv08RbYUzsV86QfUUoZt0ZzzgKU1JtXyvTJxw==
X-Received: by 2002:a65:5188:: with SMTP id h8mr59842315pgq.294.1564163502521; 
 Fri, 26 Jul 2019 10:51:42 -0700 (PDT)
Received: from localhost.localdomain (97-126-117-207.tukw.qwest.net.
 [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id o24sm104287919pfp.135.2019.07.26.10.51.41
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 10:51:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 26 Jul 2019 10:50:22 -0700
Message-Id: <20190726175032.6769-58-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190726175032.6769-1-richard.henderson@linaro.org>
References: <20190726175032.6769-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH 57/67] target/arm: Convert T16, nop hints
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c |  3 +--
 target/arm/t16.decode  | 17 +++++++++++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index c9386ceefb..55404414a2 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10779,8 +10779,7 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
 
         case 15: /* IT, nop-hint.  */
             if ((insn & 0xf) == 0) {
-                gen_nop_hint(s, (insn >> 4) & 0xf);
-                break;
+                goto illegal_op; /* nop hint, in decodetree */
             }
             /*
              * IT (If-Then)
diff --git a/target/arm/t16.decode b/target/arm/t16.decode
index 8864f89a81..90a4b71a45 100644
--- a/target/arm/t16.decode
+++ b/target/arm/t16.decode
@@ -19,6 +19,7 @@
 # This file is processed by scripts/decodetree.py
 #
 
+&empty           !extern
 &s_rrr_shi       !extern s rd rn rm shim shty
 &s_rrr_shr       !extern s rn rd rm rs shty
 &s_rri_rot       !extern s rn rd imm rot
@@ -204,3 +205,19 @@ SETEND          1011 0110 010 1 E:1 000         &setend
 REV             1011 1010 00 ... ...            @rdm
 REV16           1011 1010 01 ... ...            @rdm
 REVSH           1011 1010 11 ... ...            @rdm
+
+# Hints
+
+{
+  YIELD         1011 1111 0001 0000
+  WFE           1011 1111 0010 0000
+  WFI           1011 1111 0011 0000
+
+  # TODO: Implement SEV, SEVL; may help SMP performance.
+  # SEV         1011 1111 0100 0000
+  # SEVL        1011 1111 0101 0000
+
+  # The canonical nop has the second nibble as 0000, but the whole of the
+  # rest of the space is a reserved hint, behaves as nop.
+  NOP           1011 1111 ---- 0000
+}
-- 
2.17.1


