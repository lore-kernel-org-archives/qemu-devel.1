Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F37C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 10:08:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0A4B20882
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 10:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MiBDZ6vl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0A4B20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itqSp-0007ES-0d
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 05:08:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33927)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ianjiang.ict@gmail.com>) id 1itqSE-0006nl-MD
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 05:08:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ianjiang.ict@gmail.com>) id 1itqSD-00048o-P2
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 05:08:14 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:35732)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <ianjiang.ict@gmail.com>)
 id 1itqSD-00048F-Jj
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 05:08:13 -0500
Received: by mail-pg1-x542.google.com with SMTP id l24so1225483pgk.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 02:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=Q6qYUohRwx8EujRbuLbJRYdsULwfqLy4yF0jRZ7O0o4=;
 b=MiBDZ6vlECRY5J5h9pfAsDExq/pRnYZNLPwZR0e6orfzpmmPNdEkRLHXFthVdxwrib
 tioeTn/MWRzNJMKo1ptfq4+s6zyl8gOC/6c6N9rbxPXVgHvEpj7io6S+/ehgEoCyDsc5
 408yCxLW+cUmcBVQhmHwJMMzgCr9aYIqcgpU2l7Vsy0A3tJcYQuRmRlXact99fzLFqzw
 NqSNPwUHBDFUstEHGtJc6wWLsYKWYVfvUS7X4thhPhViAf7Rz4xYsSpwe1ftE4HbcmLi
 74A1pQ5ECF22epSUIsfrPTcTbCgYEKpYHwu76pRDI9A/fvpsDzTk11w4Gss85/FPGWum
 RQ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=Q6qYUohRwx8EujRbuLbJRYdsULwfqLy4yF0jRZ7O0o4=;
 b=AER8zmbwJx7Q2xK3L3p47BdQ+skk/H0kLSfiufzNQT+Zbg2xr1qxLKfqJDck92DHyd
 uEWv0ij1pSw+deglxX9lhDsDqpVaJtNxQRxvFu2Sma8NRXGD6dBQ1kUkLgy0PAE/fKbQ
 fC70aKTc9aX5wQYMuhEvLKHXjZsXsJzZ2iV2iGkHA98q2iR+nGJzRQYkDNRduuTsB/UO
 jfYyPbGZnAHwxiDS4JVeUDPvOSGDJVFjfd5mGgstvWYF10KWXti/QPcFJY4SbuYkwuR7
 Y6QVqirLrYCjWDmhRtlJWxJMh6OlpTUHHMXD/1KPctA1voxCR+AlQO3b6Oh+KWtqFOBG
 U8cA==
X-Gm-Message-State: APjAAAW4PJxVs+cb16ZxtYuLi1QNdARrk9JcqAMsnwUR5eQAPZtHrM3S
 edFWZVryOXwrGdKSsyZ/YUP627MPOZ9yhw==
X-Google-Smtp-Source: APXvYqw8YU98dCCA+4DGY9ulxfdv1As8FAaTsG9VddIy59ZM13gGwu06t3Wi0DFu2oRyFzlp5AtuRw==
X-Received: by 2002:aa7:8f33:: with SMTP id y19mr3619284pfr.47.1579601286688; 
 Tue, 21 Jan 2020 02:08:06 -0800 (PST)
Received: from localhost.localdomain ([111.196.189.80])
 by smtp.googlemail.com with ESMTPSA id w3sm38929353pgj.48.2020.01.21.02.07.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2020 02:08:06 -0800 (PST)
From: Ian Jiang <ianjiang.ict@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] riscv: Fix bug in setting xPIE of CSR for MRET and SRET
 instructions
Date: Tue, 21 Jan 2020 18:07:32 +0800
Message-Id: <20200121100732.28734-1-ianjiang.ict@gmail.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
Cc: Alistair.Francis@wdc.com, palmer@dabbelt.com,
 Ian Jiang <ianjiang.ict@gmail.com>, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

According to the RISC-V specification, when executing an MRET or SRET
instruction, xPIE in mstatus or sstatus should be set to 1. The orginal
QEMU does not give the right operations.
This patch fix the problem.

Signed-off-by: Ian Jiang <ianjiang.ict@gmail.com>
---
 target/riscv/op_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 331cc36232..e87c9115bc 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -93,7 +93,7 @@ target_ulong helper_sret(CPURISCVState *env, target_ulong cpu_pc_deb)
         env->priv_ver >= PRIV_VERSION_1_10_0 ?
         MSTATUS_SIE : MSTATUS_UIE << prev_priv,
         get_field(mstatus, MSTATUS_SPIE));
-    mstatus = set_field(mstatus, MSTATUS_SPIE, 0);
+    mstatus = set_field(mstatus, MSTATUS_SPIE, 1);
     mstatus = set_field(mstatus, MSTATUS_SPP, PRV_U);
     riscv_cpu_set_mode(env, prev_priv);
     env->mstatus = mstatus;
@@ -118,7 +118,7 @@ target_ulong helper_mret(CPURISCVState *env, target_ulong cpu_pc_deb)
         env->priv_ver >= PRIV_VERSION_1_10_0 ?
         MSTATUS_MIE : MSTATUS_UIE << prev_priv,
         get_field(mstatus, MSTATUS_MPIE));
-    mstatus = set_field(mstatus, MSTATUS_MPIE, 0);
+    mstatus = set_field(mstatus, MSTATUS_MPIE, 1);
     mstatus = set_field(mstatus, MSTATUS_MPP, PRV_U);
     riscv_cpu_set_mode(env, prev_priv);
     env->mstatus = mstatus;
-- 
2.17.1


