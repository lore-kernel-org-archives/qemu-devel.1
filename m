Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B10A1C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 09:02:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7692D20772
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 09:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="j76pdoOd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7692D20772
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5QB4-000800-Lh
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 05:02:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chihmin.chao@sifive.com>)
 id 1k5Q8Q-0003wy-JG
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 04:59:54 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:36715)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chihmin.chao@sifive.com>)
 id 1k5Q8O-0005TN-FD
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 04:59:54 -0400
Received: by mail-pg1-x542.google.com with SMTP id p37so2237445pgl.3
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2020 01:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=r5VyTkVLYpF3phTVGF7Kd2M8aWZEyprVmGzZRT5UTRI=;
 b=j76pdoOdk+VvI4MffC6WcL5H6d+Pi954WGnmj17UEhQQvh5u1S69IIA1vWDToCiuy1
 7SRaxg1dNtyrKmv5v/EauAHUHtfxX5jZTm5ifmDwELXcKAEGt/R3V0XwQHKbfX6JLvdf
 rxi9+QquADVkUsEuwbWjiw1Z22bELQ3XVklqrmnvClY+NCGnePhLXS+AcTkoHRaZN6S4
 Ib6tIpxQfTPt/I6r6ekd/I2opMjxoBPTiYuCiUjSr1AUOWtSEeYhKGr67Lu+oF5fvspd
 mxySHOKgAVKiIRGHD/BHNa0rSEZY/xvR2gSUN9+GxPkkUxKjG9o3UZfQqYyVRlnA4ySA
 afZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=r5VyTkVLYpF3phTVGF7Kd2M8aWZEyprVmGzZRT5UTRI=;
 b=Rbv3pTmN2EmlSF0/N08fjpFIfDKqbQxPKajgx84t0Vwu55BRQYks3rwmpiRT4G8PI6
 99ZyXdvRbWYEScTyzxRYQDFS4rXRCeMTHcJLgELh4Viiktrj1Xx6PEcVdk5omVyJ24Ej
 KT4jnTuLaVg6B41WG+uY90XQYmh6Bvy7GStK1RnN0+/0KskN0K/WtpWxXHV/wYygIrx/
 c1U9NHSICvP/K/GfTcUUkv5Lt4sQYOeuoSIqdy0OfXGWHyzphusE7XYzjBCSa2eMq8xm
 MLqFVKHkfQ3om05tar7UssEE6/37QEygomD2gUebYHOxBrhjtvv822482BwjDClJXqgU
 yPng==
X-Gm-Message-State: AOAM530lRsF/dbNsZNsUUA4GIaxgWD6NimGD23dwJ9x7WMFIiN8V/XZ+
 E4gkt9NSWl7/HPKQwkeXbz1nBpzl+PRKrw==
X-Google-Smtp-Source: ABdhPJyYde/QqfZhqtwD84HSkE8A0pQvchWhZDRf16feJS2AaaWl/suc9pgUcWET434Yh+REhZkhAQ==
X-Received: by 2002:aa7:8d95:: with SMTP id i21mr4957266pfr.240.1597136391078; 
 Tue, 11 Aug 2020 01:59:51 -0700 (PDT)
Received: from gamma11.internal.sifive.com ([64.62.193.194])
 by smtp.gmail.com with ESMTPSA id w10sm1282499pjq.46.2020.08.11.01.59.50
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 11 Aug 2020 01:59:50 -0700 (PDT)
From: Chih-Min Chao <chihmin.chao@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH 1/3] target/riscv: add NaN-Boxing helper for half-float
Date: Tue, 11 Aug 2020 01:59:24 -0700
Message-Id: <1597136381-17296-2-git-send-email-chihmin.chao@sifive.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597136381-17296-1-git-send-email-chihmin.chao@sifive.com>
References: <1597136381-17296-1-git-send-email-chihmin.chao@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=chihmin.chao@sifive.com; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: Chih-Min Chao <chihmin.chao@sifive.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When writing, box the 16bit value with all ones in high part[63:16]
When reading, unbox the 16bit value from 64bit storage and validate it

Signed-off-by: Chih-Min Chao <chihmin.chao@sifive.com>
---
 target/riscv/internals.h | 16 ++++++++++++++++
 target/riscv/translate.c | 15 +++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index f1a546d..522c306 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -54,4 +54,20 @@ static inline float32 check_nanbox_s(uint64_t f)
     }
 }
 
+static inline uint64_t nanbox_h(float16 f)
+{
+    return f | MAKE_64BIT_MASK(16, 48);
+}
+
+static inline float16 check_nanbox_h(uint64_t f)
+{
+    uint64_t mask = MAKE_64BIT_MASK(16, 48);
+
+    if (likely((f & mask) == mask)) {
+        return (uint16_t)f;
+    } else {
+        return 0x7E00u; /* default qnan */
+    }
+}
+
 #endif
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index bf35182..e227534 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -119,6 +119,21 @@ static void gen_check_nanbox_s(TCGv_i64 out, TCGv_i64 in)
     tcg_temp_free_i64(t_nan);
 }
 
+static void gen_nanbox_h(TCGv_i64 out, TCGv_i64 in)
+{
+    tcg_gen_ori_i64(out, in, MAKE_64BIT_MASK(16, 48));
+}
+
+static void gen_check_nanbox_h(TCGv_i64 out, TCGv_i64 in)
+{
+    TCGv_i64 t_max = tcg_const_i64(0xffffffffffff0000ull);
+    TCGv_i64 t_nan = tcg_const_i64(0xffffffffffff7e00ull);
+
+    tcg_gen_movcond_i64(TCG_COND_GEU, out, in, t_max, in, t_nan);
+    tcg_temp_free_i64(t_max);
+    tcg_temp_free_i64(t_nan);
+}
+
 static void generate_exception(DisasContext *ctx, int excp)
 {
     tcg_gen_movi_tl(cpu_pc, ctx->base.pc_next);
-- 
2.7.4


