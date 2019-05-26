Return-Path: <SRS0=5YAC=T2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04FB0C07542
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 01:38:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8576C20815
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 01:38:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8576C20815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49252 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUi7e-0004Ca-Mu
	for qemu-devel@archiver.kernel.org; Sat, 25 May 2019 21:38:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@dabbelt.com>) id 1hUhxG-0003GC-Qf
	for qemu-devel@nongnu.org; Sat, 25 May 2019 21:28:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@dabbelt.com>) id 1hUhgG-0006PU-Nw
	for qemu-devel@nongnu.org; Sat, 25 May 2019 21:10:33 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43834)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hUhgG-0006Ov-Ip
	for qemu-devel@nongnu.org; Sat, 25 May 2019 21:10:32 -0400
Received: by mail-pg1-f194.google.com with SMTP id f25so7077887pgv.10
	for <qemu-devel@nongnu.org>; Sat, 25 May 2019 18:10:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:cc:from:to;
	bh=lgmEqxyiwMV1Ti/O3OydvGHQpr3dTuAGNT7RYvHKmXU=;
	b=ttbHPniB+jbHUO+eMXE9KHPXDisVoeYTp4nRYrRWjHgCNU5ZKIitEK0IXfC8DRHTjE
	VpK8fA9prNqUJHYF80zRWkxgC8z0ckcjspUGXz7miDgoiuH13Hw5/ZqGluWc0sykC4Qw
	QL01wttqrgR3scSai/K3avcRR/RFMC4ET9iWh5Mk8lNI70WiUOm5JWtmthBnWohuOdZg
	kLtg1uM9fYX0EdhTnGf9Jygi2vhHn4bTol4CgJQNpbDhkFxb++Xbc3+131oGUoeyHzbL
	2LNlAZQ6dFT+AbyRbBMzIh6wVJfrogtJ3HBnZyJP/2Yie+nj0NT2NJ+2OKMsPowm7P9N
	XURA==
X-Gm-Message-State: APjAAAULfR6MIBFXrt2EWO+hXHn2mK1+g2gNAa/ZYMU350+zalzIx/MJ
	VUcT0M1F00q/5g/rm1rH6BLlCg==
X-Google-Smtp-Source: APXvYqxdqUW5vrXTFgqdFuWPM0Md4nZfvb/ye6xN3/Z5tOWFGK8yKhPbkkYl2JeXiMfG4AeOQ0ACCQ==
X-Received: by 2002:a63:1c4:: with SMTP id 187mr89182910pgb.317.1558833031392; 
	Sat, 25 May 2019 18:10:31 -0700 (PDT)
Received: from localhost ([12.206.222.5]) by smtp.gmail.com with ESMTPSA id
	r71sm14305215pjb.2.2019.05.25.18.10.30
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 25 May 2019 18:10:30 -0700 (PDT)
Date: Sat, 25 May 2019 18:09:40 -0700
Message-Id: <20190526010948.3923-22-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190526010948.3923-1-palmer@sifive.com>
References: <20190526010948.3923-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.215.194
Subject: [Qemu-devel] [PULL 21/29] target/riscv: Improve the scause logic
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
	Palmer Dabbelt <palmer@sifive.com>, qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alistair Francis <Alistair.Francis@wdc.com>

No functional change, just making the code easier to read.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/cpu_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 7318da289f6e..c577a262b8b4 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -515,7 +515,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         s = set_field(s, MSTATUS_SPP, env->priv);
         s = set_field(s, MSTATUS_SIE, 0);
         env->mstatus = s;
-        env->scause = cause | ~(((target_ulong)-1) >> async);
+        env->scause = cause | ((target_ulong)async << (TARGET_LONG_BITS - 1));
         env->sepc = env->pc;
         env->sbadaddr = tval;
         env->pc = (env->stvec >> 2 << 2) +
-- 
2.21.0


