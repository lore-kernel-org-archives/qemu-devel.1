Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A638C33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 10:17:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67F27207FF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 10:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="dSuK0nCk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67F27207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irJG7-0000FG-Fy
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 05:17:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39287)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <shihpo.hung@sifive.com>) id 1irJDv-0006ZF-Il
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 05:15:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shihpo.hung@sifive.com>) id 1irJDu-0003lF-Em
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 05:14:59 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:43014)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <shihpo.hung@sifive.com>)
 id 1irJDu-0003kw-9G
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 05:14:58 -0500
Received: by mail-pf1-x442.google.com with SMTP id x6so6347722pfo.10
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 02:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=HAzIVuP0bmBD8pCxZRV0faJXmCFnhedWNqbSK2+xQQE=;
 b=dSuK0nCkduYNrO3mW4esWh3FMlCq9BcXxSC0BifAw96dhAiX3z/7STZAzghRVtxp4u
 6nT6FwhwaE0dgAy3xU3b63iH3iEtX3QNsy1zACgVP8rkMM4uro5+k/01SdckE5r1c1dn
 MjGy33FU8iSdvnIL+mD+nW7MopYNLesppcRP8CFHmeIK6MMWQTwldMEtwhRDDDvtfzug
 7DSAiZNE61HpiUSPbv/ugSmC/+GhWcfNOuTG417ebEzy+lMBQdJy/lcOCWx2RiCHOyeX
 DJcRHPJFPj7KrLIAB9y3nsHuymDFhwJHrol0orveLLYjGh0erVw+08MTJRWNRrabcT//
 U9Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=HAzIVuP0bmBD8pCxZRV0faJXmCFnhedWNqbSK2+xQQE=;
 b=bFtKff/5eA+S5a4f4jGfM5MPEyhcz4uAqKhKRj0EDkxtSX8IYjjMntzQ9hd7jhRNB3
 nvEkzwzSYexqVoH74T0pWNAogG9vSirSyGkU1QknPLS86UyxSOng0hnKZrGqoC/aRknN
 V8GPgMYxlbeUJx8CcFe/uu7yF45BxZaGObehTh6a63A1uGJql19ugJ7rVZL4TeCRe+Op
 NUq6WLQAcsrgQMayIWPTnh1AilbjbYfOfwCEG6cs5fKZgJTxph4G8W5lqiNc1sYqoO9T
 /FTAA89yVY7EjuVmJWRcn6LY7dTIOywraKMAtotUBvV4j8fow8x7sa3vDU7/bs/JNmPS
 Pnag==
X-Gm-Message-State: APjAAAUVm7pPrY3C0uN2v2eG1LDbIrmOwHJF7UCfKAq/NSGtiJMNttoA
 RmZZaw4YZ7bfxUChhOkonmDQQQ==
X-Google-Smtp-Source: APXvYqxezoIsj/9TH+Evy5DJDgOYpfevoZjjywpPyjhPL3lzDuRpfqIRHleEvjoN1lMDkVfEr7BP7A==
X-Received: by 2002:aa7:90c5:: with SMTP id k5mr24639714pfk.143.1578996897445; 
 Tue, 14 Jan 2020 02:14:57 -0800 (PST)
Received: from gamma04.internal.sifive.com ([64.62.193.194])
 by smtp.gmail.com with ESMTPSA id k23sm16158583pgg.7.2020.01.14.02.14.56
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 14 Jan 2020 02:14:56 -0800 (PST)
From: shihpo.hung@sifive.com
To: qemu-riscv@nongnu.org
Subject: [PATCH v2 3/3] target/riscv: update mstatus.SD when FS is set dirty
Date: Tue, 14 Jan 2020 02:14:00 -0800
Message-Id: <1578996840-14863-3-git-send-email-shihpo.hung@sifive.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1578996840-14863-1-git-send-email-shihpo.hung@sifive.com>
References: <1578996840-14863-1-git-send-email-shihpo.hung@sifive.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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
---
 target/riscv/csr.c       | 3 +--
 target/riscv/translate.c | 1 +
 2 files changed, 2 insertions(+), 2 deletions(-)

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
index ab6a891..e825ee6 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -395,6 +395,7 @@ static void mark_fs_dirty(DisasContext *ctx)
     tmp = tcg_temp_new();
     tcg_gen_ld_tl(tmp, cpu_env, offsetof(CPURISCVState, mstatus));
     tcg_gen_ori_tl(tmp, tmp, MSTATUS_FS);
+    tcg_gen_ori_tl(tmp, tmp, MSTATUS_SD);
     tcg_gen_st_tl(tmp, cpu_env, offsetof(CPURISCVState, mstatus));
     tcg_temp_free(tmp);
 }
-- 
2.7.4


