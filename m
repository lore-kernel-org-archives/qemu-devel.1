Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D950C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 10:03:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 677032071E
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 10:03:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OaJXk2AB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 677032071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kA9Jz-0000UN-NC
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 06:03:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50184)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1kA9Hb-0004Ex-2l
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 06:00:55 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:38870)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1kA9HV-0006V7-Mt
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 06:00:54 -0400
Received: by mail-lj1-x244.google.com with SMTP id m22so8911653ljj.5
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 03:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=t3L8Z1SmwEHzDQ0NMcpyNGKg+ERouypWp63Pju5T3RM=;
 b=OaJXk2ABkNrW6C4cUnqZXT0Xti2ZPCQPAqouRQAmtbFOStRqwlpmmU1M7vvj14U68c
 PxAOsPtHtuoZQEfqShfeK75dGLxuNn1l8l8P8fACnxUVKqFkAnZfdipFcAiC0Zegub6t
 msxFKGbrAYU9MGobwYZx9Ak2x1Zo6pbz5MlfN37aNCBYvrhMX32yT25GJX7UsjEHcO6K
 EQPi9eeF5AZ9yUE9CedLfDoiXpTO10jDpKYIeHWn7aV22ealo0ooE8XHcvtBN+beQMnd
 RBFZ7wm6RwxTc327GqbuXBeQ84M01r0//lTih24Qe62dhegJEW3xWQNAs4ds+kwzrp8O
 GNog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=t3L8Z1SmwEHzDQ0NMcpyNGKg+ERouypWp63Pju5T3RM=;
 b=NFVhRGyn58y2eOBUGc/O45XIMkrGMlGCtpWcnv9qidhoIV0HemrApL+xbzd1NTMfGh
 W17WPT23j2ANc03x0yL4E4QUWYFAI6C3NFZQO4WSbL9vS7y4GgVg56kOhb1S8AlSfiyW
 e+43Vs0y8orKOjVNHK4Y1avWD+3ZzglEXP0YxzbfsLp7VJ6UYAoCHlR3NcOdtD3RRngH
 J0qFuqcj2lAeVTGGW09v2vMobkC+jQyb+T3z0EgJsq0l3vNgN93FmghHjl4f0cwh3Xav
 7T1Pet+p9nFC0JX89NRnu6qboL+WNrJFdBCKjOVqngbH3hjIv7N0VS16Vd7dtE8Y5YOt
 wh8g==
X-Gm-Message-State: AOAM53245ExW3YU+hOpMASPw6zKIU83ek3rSZfvS2k9zEJUU0jZgPQZt
 h85Ik53XKW2fl3EOHnzlZtq67nWJGYM=
X-Google-Smtp-Source: ABdhPJzHgYsSqpDSAOZqrJuW6MujRYaMEswvlMgkx94rnJwpmT1T0a8vA44i/MyLBKeusPnE064QeA==
X-Received: by 2002:a2e:2f16:: with SMTP id v22mr2256890ljv.39.1598263246241; 
 Mon, 24 Aug 2020 03:00:46 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id j4sm2075000ljc.116.2020.08.24.03.00.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2020 03:00:45 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PULL v1 3/8] target/microblaze: mbar: Add support for data-access
 barriers
Date: Mon, 24 Aug 2020 12:00:36 +0200
Message-Id: <20200824100041.1864420-4-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200824100041.1864420-1-edgar.iglesias@gmail.com>
References: <20200824100041.1864420-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::244;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 16
X-Spam_score: 1.6
X-Spam_bar: +
X-Spam_report: (1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_HELO_FAKE=3.724, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: edgar.iglesias@xilinx.com, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Add support for data-access barriers.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/translate.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index c1be76d4c8..c58f334a0f 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1233,6 +1233,11 @@ static void dec_br(DisasContext *dc)
 
         LOG_DIS("mbar %d\n", mbar_imm);
 
+        /* Data access memory barrier.  */
+        if ((mbar_imm & 2) == 0) {
+            tcg_gen_mb(TCG_BAR_SC | TCG_MO_ALL);
+        }
+
         /* mbar IMM & 16 decodes to sleep.  */
         if (mbar_imm & 16) {
             TCGv_i32 tmp_hlt = tcg_const_i32(EXCP_HLT);
-- 
2.25.1


