Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 806CFC5B578
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 08:54:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DC1B218A3
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 08:54:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DC1B218A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hib1x-0002E3-KH
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 04:54:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51427)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hiapf-00069j-Jy
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:41:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hiapd-00074x-1L
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:41:38 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37128)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hiapc-00070a-Jn
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:41:36 -0400
Received: by mail-lf1-f66.google.com with SMTP id d11so1168269lfb.4
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2019 01:41:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=q9V5gld9xQfQQn0CcvhnGApawq1VurFWRjo628pvYuM=;
 b=ZLBL4FgG0Oobe5JFYazGYGQhzb1Abf4E3Pj/zEKljDEi9+ze2wO4dErhZJuBJ2clWw
 IV8rBqPkxcSjLGxelPgSxwMOuykNJ6SQXy76FJw1upFBd6/u3tSuQN5NePo1IkWZvuBr
 3DB2/Qvjb4SYLx0iUZ44Ylyhk9sY65FF7pu4TMrt8glNVBdLnLPf+d7khIb1UqMiHIRj
 xUzb7yYCViUhHR3U6PScR5+a5OYTmQSAt1yja8xX3+DtaWEfRKgFq0NKO16N60afofI4
 k/ioesmg/0/lHXhIRXFh8zv88b2Ouv6hs/yGuvgh1uYAsv8p8dQjJlZU4hvqjKIKByYV
 wRlQ==
X-Gm-Message-State: APjAAAUkQncRqVE2+zb0PWJY6+RrQMwpGb33oUEYw/i64ccdQjhycCCa
 4YWCBpCFZZUV4TOvQLX685wECOG83XUADA==
X-Google-Smtp-Source: APXvYqxbN3o+wyiwNNl9d/mFLLfkZg6dSWvYvup4ysqv7Mb66kBM7j6Yo8AEBvsyXXWJaXj4cuLwmg==
X-Received: by 2002:ac2:52b7:: with SMTP id r23mr3720318lfm.120.1562143294604; 
 Wed, 03 Jul 2019 01:41:34 -0700 (PDT)
Received: from localhost ([134.17.27.127])
 by smtp.gmail.com with ESMTPSA id z30sm319292lfj.63.2019.07.03.01.41.33
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 03 Jul 2019 01:41:34 -0700 (PDT)
Date: Wed,  3 Jul 2019 01:40:30 -0700
Message-Id: <20190703084048.6980-15-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190703084048.6980-1-palmer@sifive.com>
References: <20190703084048.6980-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.167.66
Subject: [Qemu-devel] [PULL 14/32] target/riscv: Add the privledge spec
 version 1.11.0
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alistair Francis <alistair.francis@wdc.com>

Add support for the ratified RISC-V privledge spec.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/cpu.h                             | 1 +
 target/riscv/insn_trans/trans_privileged.inc.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 5eb9cab2ad62..d559d28bcda8 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -81,6 +81,7 @@ enum {
 #define USER_VERSION_2_02_0 0x00020200
 #define PRIV_VERSION_1_09_1 0x00010901
 #define PRIV_VERSION_1_10_0 0x00011000
+#define PRIV_VERSION_1_11_0 0x00011100
 
 #define TRANSLATE_PMP_FAIL 2
 #define TRANSLATE_FAIL 1
diff --git a/target/riscv/insn_trans/trans_privileged.inc.c b/target/riscv/insn_trans/trans_privileged.inc.c
index 664d6ba3f2cc..c5e4b3e49a3e 100644
--- a/target/riscv/insn_trans/trans_privileged.inc.c
+++ b/target/riscv/insn_trans/trans_privileged.inc.c
@@ -90,7 +90,7 @@ static bool trans_wfi(DisasContext *ctx, arg_wfi *a)
 static bool trans_sfence_vma(DisasContext *ctx, arg_sfence_vma *a)
 {
 #ifndef CONFIG_USER_ONLY
-    if (ctx->priv_ver == PRIV_VERSION_1_10_0) {
+    if (ctx->priv_ver >= PRIV_VERSION_1_10_0) {
         gen_helper_tlb_flush(cpu_env);
         return true;
     }
-- 
2.21.0


