Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB5EC33CB1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 06:20:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B85F824671
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 06:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Iy6XAh2z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B85F824671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irc2F-0000y3-TL
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 01:20:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58949)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <shihpo.hung@sifive.com>) id 1irbzz-00064O-0n
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 01:17:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shihpo.hung@sifive.com>) id 1irbzy-0003Yo-03
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 01:17:50 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:33946)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <shihpo.hung@sifive.com>)
 id 1irbzx-0003YI-Qc
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 01:17:49 -0500
Received: by mail-pg1-x544.google.com with SMTP id r11so7716298pgf.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 22:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=XvfKywIyN+RwyR3E6jjNNc/Bw1GozEvyfw9ydD7+K7k=;
 b=Iy6XAh2zvz8Q8EdA/L9Hi5CTh987KwkItfDHuwsZqZ19as5S4d8fjPGb2lGF6GCYWO
 Pzqv56mDo9fH9KROvn9I8qh+Q1R5dwMZYng5SI4VO7fB/ak33JrxdlJmNwAF+VgXwhNt
 GJOpzWo1TGles3KpXQMK/Pua/468yORq9ye9SFet7/q6Ft9lRnnpaX6k5N0l865DzY+8
 OXZeObAmpHHwB6XdyXVsqGEqpSgvv1ajAVsZpNk6ri+pnctJFMjn7Ktto8Ku4UsP+YF0
 qs87b1lhRsi3cRSMSsk9pIwxsdwll+0gW7Q1b9pzKT+QoNJUVd+x/soGEraI5zVqoyx4
 c/Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=XvfKywIyN+RwyR3E6jjNNc/Bw1GozEvyfw9ydD7+K7k=;
 b=ZxBvK/qCfW8RjJcuH+Pl9QJgoZR+bU9aMoqjdecAneD9UQ3n8i7u+WlH+BsWw5jnfQ
 HdCeP8HK5svOo9SdkeOzsbWW0PyIuEcCtcz+wpLD1M9VxDAv7sl4/FETKsm1rLw+m1Km
 K0x9zJuTvmmey1i6GpnnI/FpDeMcnwE2dJ3x3urt3a12/xbJeMOp0ANpP8rUCCGISfZt
 ZmFnOfQgfAAaFUOh2Dq9e4WBcKNlJdP/MGBKDvtu+QxwBxPCje/ZzRlPxN+8O/YAwAT0
 Wx0lxKRi0vS1Meg7JtAaAg9ZQCqtDnvsuUq9Zpe7durbzfy9f8tqRNe5eoxAbNduo7HC
 FCIA==
X-Gm-Message-State: APjAAAVfjOpEWGQnN3JaqOQWIHYuSmfZsFRJIjPnLW+jLSs/QO+a0OHU
 s8eS71cpBtv2dFsyngdqxdJcVg==
X-Google-Smtp-Source: APXvYqxOkmWgD0XBT8SxjkB/S8mPFZyWbuBg5P/Hvb1crQ0RTw5MItzyQhPIR+xALPsRwfbTP5dFeQ==
X-Received: by 2002:a63:9d8f:: with SMTP id i137mr31033690pgd.33.1579069068917; 
 Tue, 14 Jan 2020 22:17:48 -0800 (PST)
Received: from gamma04.internal.sifive.com ([64.62.193.194])
 by smtp.gmail.com with ESMTPSA id w123sm20633601pfb.167.2020.01.14.22.17.47
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 14 Jan 2020 22:17:48 -0800 (PST)
From: shihpo.hung@sifive.com
To: qemu-riscv@nongnu.org
Subject: [PATCH v3 3/3] target/riscv: update mstatus.SD when FS is set dirty
Date: Tue, 14 Jan 2020 22:17:33 -0800
Message-Id: <1579069053-22190-3-git-send-email-shihpo.hung@sifive.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1579069053-22190-1-git-send-email-shihpo.hung@sifive.com>
References: <1579069053-22190-1-git-send-email-shihpo.hung@sifive.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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

remove the check becuase SD bit should summarize FS and XS fields
unconditionally.

Signed-off-by: ShihPo Hung <shihpo.hung@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/csr.c       | 3 +--
 target/riscv/translate.c | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index da02f9f..0e34c29 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -341,8 +341,7 @@ static int write_mstatus(CPURISCVState *env, int csrno, target_ulong val)
 
     mstatus = (mstatus & ~mask) | (val & mask);
 
-    dirty = (riscv_cpu_fp_enabled(env) &&
-             ((mstatus & MSTATUS_FS) == MSTATUS_FS)) |
+    dirty = ((mstatus & MSTATUS_FS) == MSTATUS_FS) |
             ((mstatus & MSTATUS_XS) == MSTATUS_XS);
     mstatus = set_field(mstatus, MSTATUS_SD, dirty);
     env->mstatus = mstatus;
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index ab6a891..8e40ed3 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -394,7 +394,7 @@ static void mark_fs_dirty(DisasContext *ctx)
 
     tmp = tcg_temp_new();
     tcg_gen_ld_tl(tmp, cpu_env, offsetof(CPURISCVState, mstatus));
-    tcg_gen_ori_tl(tmp, tmp, MSTATUS_FS);
+    tcg_gen_ori_tl(tmp, tmp, MSTATUS_FS | MSTATUS_SD);
     tcg_gen_st_tl(tmp, cpu_env, offsetof(CPURISCVState, mstatus));
     tcg_temp_free(tmp);
 }
-- 
2.7.4


