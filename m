Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6834AC388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 04:23:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF59D207BC
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 04:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RnHgwXgP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF59D207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXczq-0005N9-OL
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 00:23:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43360)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1kXcum-0000gZ-W7
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 00:18:25 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:43375)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1kXcuk-0007L2-Q4
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 00:18:24 -0400
Received: by mail-pl1-x644.google.com with SMTP id o9so1850191plx.10
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 21:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=okNvxuAD4d5IMa05SWDW8OhBnvNEk3BfByl9gvP1iWs=;
 b=RnHgwXgPUGIqkxyALcSNGrMKGzBi1SMDZVb1sjPucfrCU/W/5aKm/4xVyf0kzxIqJq
 digUPmksDi9BZuGgYzQL+zm8R30X7B2QnKl43Bmy7jLlzV08lG78BXWCBpfU6a9wiqtC
 jM9fJFYsEMmSMVV1V8b3xK0NQjegTKo+n0xTsDlEFmQ0s5JtGwU67AAGasP7c37iNxbt
 G/I3LLrMZTrxz1SqhQCpM3c2P2ewiEcMb4L32tkpg01m4QToE8wTUxX4ci9CQM2x9ka8
 PnIYFWCq/3W6HN6ZhuEzmQGWRwWOD/mwMOG5duVMsD8Nx3R/X2Yz9UBhcbD2jiA36dp+
 GErQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=okNvxuAD4d5IMa05SWDW8OhBnvNEk3BfByl9gvP1iWs=;
 b=jTtbusxmNpq/sGRpstgJdX1Akg351WMgUY78w85ggVQIXClL1CkSbOBUcSbhh0XF9z
 u8C93iMO3XujOY4pAQRDp8In2DqOySpumWBiEh5G2p3N6VLw8macjkKuxGcXaeE6nP0J
 G+PqkRN9yquaTR4H2KNuBNaK5kYoloARStHLclft9FC47vnx0VVWmtXIugh16MQCLO+h
 J2E5zj97PTiDW7szCz7vGBzp868Dh2MvZbjOAaVErSxeKXUoOHuo3qkU2XSIzPR8Z4VH
 lBwOWr/LHRUntjsf4LAMPVhVGFYQO4hGxUvXwHZY6f2JExr2jg/Pe0dE7lnF4/4OV1xs
 6NOA==
X-Gm-Message-State: AOAM533Qs9nBonFMlO25dB28r3a459CrA6rvvKTXyQeR1oCg5EUX7knR
 q8xV1G7uKQRYn0fK3I+3ZIY=
X-Google-Smtp-Source: ABdhPJwvafHUpfZQ8MVG6Y8EJ8fb34juWsfAoXwbDjLEQNwKJwr1vl0jt6IYv4F25/sZrC9kgPyUEA==
X-Received: by 2002:a17:90a:bf05:: with SMTP id
 c5mr5126492pjs.11.1603858701214; 
 Tue, 27 Oct 2020 21:18:21 -0700 (PDT)
Received: from software.domain.org ([45.77.13.216])
 by smtp.gmail.com with ESMTPSA id x10sm3882040pfc.88.2020.10.27.21.18.17
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 27 Oct 2020 21:18:20 -0700 (PDT)
From: Huacai Chen <zltjiangshi@gmail.com>
X-Google-Original-From: Huacai Chen <chenhc@lemote.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Subject: [PATCH V15 2/6] target/mips: Add unaligned access support for
 MIPS64R6 and Loongson-3
Date: Wed, 28 Oct 2020 12:18:00 +0800
Message-Id: <1603858685-30701-3-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1603858685-30701-1-git-send-email-chenhc@lemote.com>
References: <1603858685-30701-1-git-send-email-chenhc@lemote.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=zltjiangshi@gmail.com; helo=mail-pl1-x644.google.com
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


