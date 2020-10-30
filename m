Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 983E4C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 10:29:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDFAE20704
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 10:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sfAhk4My"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDFAE20704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYReo-0002Mq-PZ
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 06:29:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48556)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1kYRcQ-00089w-RW
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 06:26:50 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:40999)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1kYRcJ-0001LF-9A
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 06:26:48 -0400
Received: by mail-pg1-x542.google.com with SMTP id g12so4815188pgm.8
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 03:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=g815fsiESMKmgDH5cPf9Tkif9Ardfh9VTYbXrHpvFI8=;
 b=sfAhk4Mym36HIdPwDKmfSBDzOMsSj4fbmmo06Ar3T+4L6wIiNSB4xebhmtUy82j89v
 JXp6+GtDCyx+BiNmDXfIgMzAjW4PCL1sgAH1bNbixzqbF0W7iFiU6AliXA0qHlTbCzXs
 nLQLgyh9b/UrcjPusHaXTeavWDGPY161K5+OvkcmPPqCiR/fmtMqPbWwUFGte8XwyMnx
 Cc+ws29W2KnyAdqei1elzIjM7MQc2XRKkYsSUEMAAsdQnwSAp4N79VQkzcDrKSEJuWXE
 m2HGyR8PoE5eCnmRaVxbMaWbHND22ig0OFlwenYb3ixy7T4WrGki2Lc05rtQ3mSxvYHR
 tKDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=g815fsiESMKmgDH5cPf9Tkif9Ardfh9VTYbXrHpvFI8=;
 b=f3FXu1tQBoPxtvXaectteXCL/kvDlpACtjYLEfj1qXIXF6q437M5lbxn/4CCQF6Ejf
 FgzVQk6mqwjlVT/8r1N7GP46DnaMF84a+uoh1k78+fYJH5dXoYgdch15e4/f5HvN/dar
 i56sPdSsnrG6gB2oNUt7MKhTBymYp3nvdfoluk1SkxScgazH2b/l76XiGE16P6UPvqF3
 kLrjvWchlxLcDwpShm+dolx8ZSiOBKapnbNCdbWEucG2YlJv/ovR2dmImDEwD6qYftRM
 1U5b9hLmJ8eVEiw9VVctNfSBIr7Wwl5XhQcJfOfjXsT5Btl42n4s0QMUhpE1TbCOTIo3
 eHFA==
X-Gm-Message-State: AOAM532FMt3JjLD/sxBfc48W+Mm5UXp9TE0RA1KcGyjnKVaLyWgIAiRr
 19GvP9h0j08L4o7DjLjyu9Q=
X-Google-Smtp-Source: ABdhPJwC0dDSxCTqpvZWMxGgO0eLGEHLrfh/mvgEJ48USojhS1YD21GnjjlSsWZmke+7kxzyBElZeQ==
X-Received: by 2002:a17:90a:ab92:: with SMTP id
 n18mr1924985pjq.233.1604053601533; 
 Fri, 30 Oct 2020 03:26:41 -0700 (PDT)
Received: from software.domain.org ([45.77.13.216])
 by smtp.gmail.com with ESMTPSA id v79sm6062146pfc.197.2020.10.30.03.26.38
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 30 Oct 2020 03:26:40 -0700 (PDT)
From: Huacai Chen <zltjiangshi@gmail.com>
X-Google-Original-From: Huacai Chen <chenhc@lemote.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Subject: [PATCH V16 2/6] target/mips: Add unaligned access support for
 MIPS64R6 and Loongson-3
Date: Fri, 30 Oct 2020 18:25:37 +0800
Message-Id: <1604053541-27822-3-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1604053541-27822-1-git-send-email-chenhc@lemote.com>
References: <1604053541-27822-1-git-send-email-chenhc@lemote.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=zltjiangshi@gmail.com; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Huacai Chen <chenhuacai@gmail.com>, qemu-devel@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhc@lemote.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MIPSR6 (not only MIPS32R6) processors support unaligned access in
hardware, so set MO_UNALN in their default_tcg_memop_mask. Btw, new
Loongson-3 (such as Loongson-3A4000) also support unaligned access,
since both old and new Loongson-3 use the same binaries, we can simply
set MO_UNALN for all Loongson-3 processors.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 target/mips/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index f449758..470f59c 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -31442,8 +31442,8 @@ static void mips_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 #else
         ctx->mem_idx = hflags_mmu_index(ctx->hflags);
 #endif
-    ctx->default_tcg_memop_mask = (ctx->insn_flags & ISA_MIPS32R6) ?
-                                  MO_UNALN : MO_ALIGN;
+    ctx->default_tcg_memop_mask = (ctx->insn_flags & (ISA_MIPS32R6 | ISA_MIPS64R6 |
+                                  INSN_LOONGSON3A)) ? MO_UNALN : MO_ALIGN;
 
     LOG_DISAS("\ntb %p idx %d hflags %04x\n", ctx->base.tb, ctx->mem_idx,
               ctx->hflags);
-- 
2.7.0


