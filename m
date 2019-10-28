Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2ED9CA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 16:23:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEDAA21721
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 16:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="kTSzec3d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEDAA21721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP7nj-00020X-VR
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 12:23:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34894)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@sifive.com>) id 1iP7Po-0005f9-6t
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 11:58:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@sifive.com>) id 1iP7Pn-00040q-3u
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 11:58:44 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436]:45104)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@sifive.com>) id 1iP7Pm-000404-V2
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 11:58:43 -0400
Received: by mail-pf1-x436.google.com with SMTP id c7so5976658pfo.12
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2019 08:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=EXsNj6jZsB30XB6MiD6tWhEVGfazwqhX650sA5CbspM=;
 b=kTSzec3deeQ+znpySCdUaFjHmsOHPTciHd1teZLlHzVc0RozDMsU1KvyDLogXAhVul
 nes7HT6YBwbhI2lt4a35dy4ETyW4uIjW9CdXAvFKQjEABXJxJr3s7DPgF9vzO9C+s/Ps
 /3gFFGxi4KED3+/K85slC3BJOWjU38A+qCTyUoNyWDQVZJNsdZNnij1IK9AiRK7TO3FD
 FuePB4DBrce9I8cG5EzG0PXEogjL4rbTWIJOm4NedNDHLX0mjiNtGh19Q6l31A5ZRrqr
 qqkhV7cAPYVl4vDZI3HWDtBMY/mLszVWbRbTdYHX0VVjiaRtuGWE5zXjI7hC6BbH6fX/
 /WeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=EXsNj6jZsB30XB6MiD6tWhEVGfazwqhX650sA5CbspM=;
 b=sYAOk6bTEIPN4nb0Dt9TDfAhjlvpBZHaEUonX6wJ2XwN4LC+k73VowIbkq/ja4SROv
 49lrJepKZhJIxMuvRtw+gndKpF6b2FS/UMapxHho3LlFVfJh8NUa2chVJsPgS2cCYnpP
 hRygoFiwiQcuKJl1MmmmT9bYVu0XGzotlf3L5/2cGYxl7n5g+b9LCTfArOdxBZPInjhN
 VlBQrlG7vjL7hw2VdeLnK6i+Xav3SH5/BTa8cMx2CH7PSdMUwZTzFXVL+JnoNJo5KJph
 rRRnopzLQWYe3J+sPVHjxqVIzek/1UwpoSOjRSlnl3xHEQOCSWM9gQq6T4B5dFqpj8ZX
 XGfQ==
X-Gm-Message-State: APjAAAW3y1SZrNGls3Ub3UmQAjHdJJhDjuD0zpJWKiW1EbAymHzB7XZ8
 kET/oSsmSHX1XuisKJILSEjbSs+I8J0LqQ==
X-Google-Smtp-Source: APXvYqxu1f0nOZ+sv2iQGasuO3QyMFl7q1T1dUZSah6XNLCC+tIOTc18nNq/Z7oNB9nfta3k5P2yJA==
X-Received: by 2002:a17:90a:854c:: with SMTP id a12mr17883pjw.2.1572278321633; 
 Mon, 28 Oct 2019 08:58:41 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id r81sm12836029pgr.17.2019.10.28.08.58.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2019 08:58:40 -0700 (PDT)
Subject: [PULL 14/18] target/riscv: Tell gdbstub the correct number of CSRs
Date: Mon, 28 Oct 2019 08:48:58 -0700
Message-Id: <20191028154902.32491-15-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191028154902.32491-1-palmer@sifive.com>
References: <20191028154902.32491-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::436
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
Cc: qemu-riscv@nongnu.org, Jonathan Behrens <jonathan@fintelia.io>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jonathan Behrens <jonathan@fintelia.io>

If the number of registers reported to the gdbstub code does not match the
number in the associated XML file, then the register numbers used by the stub
may get out of sync with a remote GDB instance.

Signed-off-by: Jonathan Behrens <jonathan@fintelia.io>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/gdbstub.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
index ded140e8d8..cb5bfd3d50 100644
--- a/target/riscv/gdbstub.c
+++ b/target/riscv/gdbstub.c
@@ -384,7 +384,7 @@ void riscv_cpu_register_gdb_regs_for_features(CPUState *cs)
     }
 
     gdb_register_coprocessor(cs, riscv_gdb_get_csr, riscv_gdb_set_csr,
-                             4096, "riscv-32bit-csr.xml", 0);
+                             240, "riscv-32bit-csr.xml", 0);
 #elif defined(TARGET_RISCV64)
     if (env->misa & RVF) {
         gdb_register_coprocessor(cs, riscv_gdb_get_fpu, riscv_gdb_set_fpu,
@@ -392,6 +392,6 @@ void riscv_cpu_register_gdb_regs_for_features(CPUState *cs)
     }
 
     gdb_register_coprocessor(cs, riscv_gdb_get_csr, riscv_gdb_set_csr,
-                             4096, "riscv-64bit-csr.xml", 0);
+                             240, "riscv-64bit-csr.xml", 0);
 #endif
 }
-- 
2.21.0


