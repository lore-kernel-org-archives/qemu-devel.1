Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 346E5C388F7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 17:35:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD07621D91
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 17:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J490b6sP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD07621D91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka0DX-0006g2-R7
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 12:35:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60654)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ka0A9-0001xF-P0; Tue, 03 Nov 2020 12:32:05 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54139)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ka0A7-0007fC-QS; Tue, 03 Nov 2020 12:32:05 -0500
Received: by mail-wm1-x343.google.com with SMTP id p22so121474wmg.3;
 Tue, 03 Nov 2020 09:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xtn9UpLprZQgb3hjVTkUMy618Qe7q31gcHcVvA1M52o=;
 b=J490b6sPrOWXOcHMEgOlaCgBonTqhzKczJwva6bXlcBqa11a2VFlhPigpuAJds9bEU
 cwNaLbAZ4RcslQ/Juwbb3z3q9ozypzW20qaUMuiKw3gF4Q9NVnBMVi5BukhOP2vN4MiU
 v5iImSTwn9830SNGRCWbKhwMWh3r+igo7NC6j2cph9XoCh3hh4t1UgXN97wwzV3A47ci
 SCNA/rtnhUjb5iMFVgm1WBnxQzQ4q7IS0e1CG+6uO2YYZLKQPwiPFgiDFkdPm+vCFhtq
 nzlmLaMp9ihap2c1DU66R/Ck1Z6db73YXOFf4K8DRvCeuuvtA0uebsoNJwGYM8sHGv6Z
 glWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=xtn9UpLprZQgb3hjVTkUMy618Qe7q31gcHcVvA1M52o=;
 b=em606iQudrs3qTSyMo3tfU6tJHSxxU1zrZXnf01ooIp6SWnL+ce9bg/jWv4tOt2UPe
 sBcXgib1ylAZOpMZucAm8aaQ1V5Bb2WO93BADtG/ExA2QTQmf4Cz7oCpp27OmnBsY7xR
 GVRmtp5AWXucQWbiKxeQabaZYKy2se/JFMAwtAL+8OOkru39h7n57eQnw0C/x9JuMoFp
 pQjjmEzGw5gtIJ0YqPB7j4JjRpR2pxAaigJ12BYX2PXBfx6qs8O515SS6Nhe+zIKjKNt
 4xTYnL7GTLXwIhJgVWgFGp/GpvPY47QKZ0062ePvagmnPxWXjXipe6dsHui4jiByDXmP
 KZEA==
X-Gm-Message-State: AOAM530zb5iMEHBRF8MTUdaKId7WZ8tyZoqJ4/ICdDb6j/fJZOhPna2w
 DxCeb8IOtCWrKngkhpcA+178YXOPkx4=
X-Google-Smtp-Source: ABdhPJypUzW1ind7JILAg1GrFsSMfeUCwZif68g5FsFrEJBl+M+ugxb9nY8RG5N8HXJyjezA3Lf4uA==
X-Received: by 2002:a7b:c04a:: with SMTP id u10mr226031wmc.83.1604424721805;
 Tue, 03 Nov 2020 09:32:01 -0800 (PST)
Received: from x1w.redhat.com (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id d16sm22910wrw.17.2020.11.03.09.32.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 09:32:01 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 6/6] target/mips: Add unaligned access support for MIPS64R6 and
 Loongson-3
Date: Tue,  3 Nov 2020 18:31:27 +0100
Message-Id: <20201103173127.2704256-7-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201103173127.2704256-1-f4bug@amsat.org>
References: <20201103173127.2704256-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, Huacai Chen <zltjiangshi@gmail.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 Paul Burton <paulburton@kernel.org>, libvir-list@redhat.com,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhc@lemote.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Huacai Chen <zltjiangshi@gmail.com>

MIPSR6 (not only MIPS32R6) processors support unaligned access in
hardware, so set MO_UNALN in their default_tcg_memop_mask. Btw, new
Loongson-3 (such as Loongson-3A4000) also support unaligned access,
since both old and new Loongson-3 use the same binaries, we can simply
set MO_UNALN for all Loongson-3 processors.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <1604053541-27822-3-git-send-email-chenhc@lemote.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/mips/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 3197a692c45..c64a1bc42e1 100644
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
2.26.2


