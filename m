Return-Path: <SRS0=5YAC=T2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6774C07542
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 01:51:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E26420815
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 01:51:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E26420815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49495 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUiJw-0006Rr-S5
	for qemu-devel@archiver.kernel.org; Sat, 25 May 2019 21:51:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@dabbelt.com>) id 1hUhxV-0003Yx-AQ
	for qemu-devel@nongnu.org; Sat, 25 May 2019 21:28:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@dabbelt.com>) id 1hUhfo-0005kU-Da
	for qemu-devel@nongnu.org; Sat, 25 May 2019 21:10:05 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38211)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hUhfo-0005k4-89
	for qemu-devel@nongnu.org; Sat, 25 May 2019 21:10:04 -0400
Received: by mail-pf1-f196.google.com with SMTP id b76so7496118pfb.5
	for <qemu-devel@nongnu.org>; Sat, 25 May 2019 18:10:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:cc:from:to;
	bh=yDGQ4+HggXB9R3Qtb8ZMANhv1eldTmfa42TH+xr+FjE=;
	b=t9WPaKc61kP2YIhIMZoQaFpx/cZclrB1ucN9H1iPbvS9DTSoUyYtZJxkwLc/JX7bph
	lpmQSIjJvrsMjGPZbrwPeQ7M58A8PEfamYbN7izSzVpw3yx3y7Aq0tkRM5atNOVk0eCt
	qGsUOMty/WFf12oDwO4RTrMCSa/ZzB2kvMVEwe37qjiRvxyic0HLvmvoqVYgWOl4RXZ5
	XRP77SVVPFphhf3MiYjx2I3t/HFot+dZleCW9e02M/1/kq4Rf0QWoxRZLjSSgjLvQ+Pc
	akpu+duxXO5pLo54ksYNmbvQlUqrqRuUNpE6MFts0swQqKIrr/Ir/uC3afLAKP709yKu
	ZfMw==
X-Gm-Message-State: APjAAAUiLYrFVtC3gbkzcPdw0gMabUqZvNZ3hOOJBURKxVmLZezb3142
	KP3kW2f3553O2kVuzXAxlaVz2g==
X-Google-Smtp-Source: APXvYqzLUQo5ik98V6oXKyBUiFNfsoMxHw/pQuVny4qTPZhHWMEfGWsPGhoEHCtjsNeW15F+3FGhuA==
X-Received: by 2002:a63:5c1a:: with SMTP id q26mr5202873pgb.260.1558833003089; 
	Sat, 25 May 2019 18:10:03 -0700 (PDT)
Received: from localhost ([12.206.222.5]) by smtp.gmail.com with ESMTPSA id
	x28sm7331487pfo.78.2019.05.25.18.10.02
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 25 May 2019 18:10:02 -0700 (PDT)
Date: Sat, 25 May 2019 18:09:21 -0700
Message-Id: <20190526010948.3923-3-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190526010948.3923-1-palmer@sifive.com>
References: <20190526010948.3923-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.210.196
Subject: [Qemu-devel] [PULL 02/29] target/riscv: Do not allow sfence.vma
 from user mode
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@sifive.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org, Jonathan Behrens <fintelia@gmail.com>,
	Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jonathan Behrens <fintelia@gmail.com>

The 'sfence.vma' instruction is privileged, and should only ever be allowed
when executing in supervisor mode or higher.

Signed-off-by: Jonathan Behrens <fintelia@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/op_helper.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index b7dc18a41e21..644d0fb35f16 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -145,9 +145,10 @@ void helper_tlb_flush(CPURISCVState *env)
 {
     RISCVCPU *cpu = riscv_env_get_cpu(env);
     CPUState *cs = CPU(cpu);
-    if (env->priv == PRV_S &&
-        env->priv_ver >= PRIV_VERSION_1_10_0 &&
-        get_field(env->mstatus, MSTATUS_TVM)) {
+    if (!(env->priv >= PRV_S) ||
+        (env->priv == PRV_S &&
+         env->priv_ver >= PRIV_VERSION_1_10_0 &&
+         get_field(env->mstatus, MSTATUS_TVM))) {
         riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
     } else {
         tlb_flush(cs);
-- 
2.21.0


