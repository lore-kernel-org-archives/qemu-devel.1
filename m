Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B12CC5B579
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 17:42:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A20720828
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 17:42:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A20720828
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgutS-0005zW-NY
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 13:42:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54536)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hgukY-0008GT-Ch
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 13:33:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hgukV-0000Ek-D0
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 13:33:26 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39912)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hgukV-0000Bz-3j
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 13:33:23 -0400
Received: by mail-pg1-f195.google.com with SMTP id 196so2889728pgc.6
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2019 10:33:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=q9V5gld9xQfQQn0CcvhnGApawq1VurFWRjo628pvYuM=;
 b=e91SAsCCe6XsoV4OKl0fzqjmgj5qz0R0Ov3zDEDT2sKPkwpadt8b1IPKxJzXN7nZ//
 f7zjYIdMMyQAce7ZYNBvkShh6zfjrT4PEylNKWlvDmE58zLd3upcx39uR4McSw1TL8G+
 gr3KKSG34O912Mq4mqjmoXPl+qpUwNkrfU065w+ja9zX+dTzoxOWMi/PnPAFh1/CvcZV
 5utGtns/cXg+FzJDpiENC1pTpAGSiswaKeN7GFv7uMH3wlHVZFETqArdrCpDs9XmFkwp
 VQadxq2T0kT7kUvWh6iMIyYMiM55/npc5OrYfCmNJjOO5KUW/q/pOoMNC5HUSuJsTEj5
 xMag==
X-Gm-Message-State: APjAAAXTJQHZMF49H7fK6IT4mvYXG3clKoHVsTGmrmUuporMSnnVJNMR
 /aD+QTl2iZT6wHfFrZoslt9mRFxHGOdipLZG
X-Google-Smtp-Source: APXvYqx5kDN7G91ArNH9tP6uusSNJfjHpPZchw8hc4S0zj9v6bZ6ubJxn5iIJv7r/ALQKSPfxw7mfg==
X-Received: by 2002:a17:90a:1ac5:: with SMTP id
 p63mr14267263pjp.25.1561743199313; 
 Fri, 28 Jun 2019 10:33:19 -0700 (PDT)
Received: from localhost (220-132-236-182.HINET-IP.hinet.net.
 [220.132.236.182])
 by smtp.gmail.com with ESMTPSA id i36sm2355306pgl.70.2019.06.28.10.33.18
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 28 Jun 2019 10:33:18 -0700 (PDT)
Date: Fri, 28 Jun 2019 10:32:07 -0700
Message-Id: <20190628173227.31925-15-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190628173227.31925-1-palmer@sifive.com>
References: <20190628173227.31925-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.215.195
Subject: [Qemu-devel] [PULL 14/34] target/riscv: Add the privledge spec
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


