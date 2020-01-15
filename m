Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FFCC33CB1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 06:18:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E6F724671
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 06:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Ykx0DH9i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E6F724671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irc0y-0007J4-KZ
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 01:18:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58919)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <shihpo.hung@sifive.com>) id 1irbzx-000643-JO
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 01:17:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shihpo.hung@sifive.com>) id 1irbzw-0003Xm-KP
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 01:17:49 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430]:38763)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <shihpo.hung@sifive.com>)
 id 1irbzw-0003XM-F9
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 01:17:48 -0500
Received: by mail-pf1-x430.google.com with SMTP id x185so8008625pfc.5
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 22:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=C7rZrXWGvUQilz0cFhEieglVy8N0UYyJSI47SoBpqAc=;
 b=Ykx0DH9iYvkunRwc8+XQ/oDMrt2MF/fNHWFBbnKBsyk9i/bvp8b9F8thN7mms3yhiF
 MX3L7zgWK1wBuArTW14GhQ7O2+X+pr6UGTSewBf4moA9spVfi5t9RPMDKXu+JA2s2AMA
 ogvJqKn8vFS3AkGspyr+T2qlKQsJldwXUcI7Qc1WKdoS7gDPgmpCebmEdnWPJ10iJNHG
 HFnxuFSjHVol1Hu7Y2PDkO+Dd6vYiHCATb24fCzFt7gQs1oZa5JcvbHrFmGFjKQ4qMwp
 YsV5MUD0LUtM1p0EV/LkMvpFr6aHWQZEPat44XzX/JO/gNQ27X5IBqr78GKa1zGYo1eS
 Gb4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=C7rZrXWGvUQilz0cFhEieglVy8N0UYyJSI47SoBpqAc=;
 b=FbkKK1WR5pUGJO3sU1bi3Baj7MF/SkHoQy2MyeEykO35P/+N+zt0Q9jRthgZSU+0oz
 xWlBPVmFFgc/aGYaPO9IrTI0bCJ9VBL/VQJEAQwI3J/YaI+xadgi2h1jMrdutuKMv9Xg
 uLezbuk/L5bFv8GiILUO6ZB40K5r2WZUQwol17jeSMvzz/1fivZ2Tiu5qW0K5JY38whp
 mjXyX4mSygUCUDIvTLYJfYG650xc0lCv9hgr2jLegQZ39Epv4J1kBtzumLbq8agqV7ai
 YTVuDFE9SSCQVyicCzjIHtU4TBGdFcHJzfjWgieKaTnGwUNruTfJEE9smKUkKsn3gquh
 ungA==
X-Gm-Message-State: APjAAAXMXQqYzm/QyMZcJr69DO2AwEVvMOUQVOmAgj1Dngqrx+uUipO1
 y/FrCvpajNSahKfAOgVjaN43qw==
X-Google-Smtp-Source: APXvYqzcNarjWaN8TCrnEYQPUeQ2fGj8zVdXfhDMsE2DqmJdBFWNsmYzaWzkio6u2yx78gkoLN4D1w==
X-Received: by 2002:aa7:84c6:: with SMTP id x6mr28507213pfn.181.1579069067627; 
 Tue, 14 Jan 2020 22:17:47 -0800 (PST)
Received: from gamma04.internal.sifive.com ([64.62.193.194])
 by smtp.gmail.com with ESMTPSA id w123sm20633601pfb.167.2020.01.14.22.17.46
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 14 Jan 2020 22:17:47 -0800 (PST)
From: shihpo.hung@sifive.com
To: qemu-riscv@nongnu.org
Subject: [PATCH v3 2/3] target/riscv: fsd/fsw doesn't dirty FP state
Date: Tue, 14 Jan 2020 22:17:32 -0800
Message-Id: <1579069053-22190-2-git-send-email-shihpo.hung@sifive.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1579069053-22190-1-git-send-email-shihpo.hung@sifive.com>
References: <1579069053-22190-1-git-send-email-shihpo.hung@sifive.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::430
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
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, ShihPo Hung <shihpo.hung@sifive.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: ShihPo Hung <shihpo.hung@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/insn_trans/trans_rvd.inc.c | 1 -
 target/riscv/insn_trans/trans_rvf.inc.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvd.inc.c b/target/riscv/insn_trans/trans_rvd.inc.c
index 393fa02..ea1044f 100644
--- a/target/riscv/insn_trans/trans_rvd.inc.c
+++ b/target/riscv/insn_trans/trans_rvd.inc.c
@@ -43,7 +43,6 @@ static bool trans_fsd(DisasContext *ctx, arg_fsd *a)
 
     tcg_gen_qemu_st_i64(cpu_fpr[a->rs2], t0, ctx->mem_idx, MO_TEQ);
 
-    mark_fs_dirty(ctx);
     tcg_temp_free(t0);
     return true;
 }
diff --git a/target/riscv/insn_trans/trans_rvf.inc.c b/target/riscv/insn_trans/trans_rvf.inc.c
index 172dbfa..e23cd63 100644
--- a/target/riscv/insn_trans/trans_rvf.inc.c
+++ b/target/riscv/insn_trans/trans_rvf.inc.c
@@ -52,7 +52,6 @@ static bool trans_fsw(DisasContext *ctx, arg_fsw *a)
     tcg_gen_qemu_st_i64(cpu_fpr[a->rs2], t0, ctx->mem_idx, MO_TEUL);
 
     tcg_temp_free(t0);
-    mark_fs_dirty(ctx);
     return true;
 }
 
-- 
2.7.4


