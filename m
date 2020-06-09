Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3D8C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 07:44:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C857A2074B
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 07:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W36hHERf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C857A2074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiYwB-0006M4-4v
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 03:44:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40360)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiYkN-0004Hf-V9
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 03:32:35 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:39490)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiYkN-0007YE-4X
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 03:32:35 -0400
Received: by mail-wr1-x42e.google.com with SMTP id t18so20073094wru.6
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 00:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=P/mKxtHL0UxIRvwcZTV/zvAsg90s7x/j5V+O3iTow44=;
 b=W36hHERfCfDWWt1sq5dxY5LL6DlTu7P82yLIpAU4SenJ/pocvmhjz98MYSP2sVFoxW
 jufy9jf2tJiq72dPWvkWCUdL/vjyRrxEYKDe2/8/ETxUbQutYfpHnzOjCj/KmXCDVUNZ
 tjz4hYEPwdp1RfF+hMy/Upcw3at0T4ZRmJo4CcK0YHkeeZU1PtozQK164K/LxOJT8NI2
 CZsqD3DLHhGjrsZYmzk2d90Csl7oBZXFhbIyxQRP4eKGWTgeNxdwi+I8gnSyHdnNpQgN
 CRt1wyseVg/c0eRBpqT3sAZQ/kj2E5wbnoR2lkumyukb1QzkMaralkvJVQjLfJBMdl3V
 XIBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=P/mKxtHL0UxIRvwcZTV/zvAsg90s7x/j5V+O3iTow44=;
 b=tZDzY++QT1shf85Bg1BtLMunyVxgRNR5wLBzhNfklndyvewIGERDfaLf+2rSE789RM
 Vx7XZMVgCBqRM8YEhfLwQ4P+QJrgfXbG8zCfy13F3nVvNJviO9D0SUaszZIkq7VDy6sO
 y/0i5WapG0IDdfxWAkkHNbQMNopc0mv/OlNp0SwJKzgeWnnozuTlEwOujMfIpYkWLxNT
 Y44KtN2XKeG4Ko/iFdU5CwmjYSReW+hzYKemRqQkYT65564kL8EoR4ALydTY2vD7HGLx
 XAux4+MtRhKWpcIDqv/h3Tz+V4fn+ZpOWH76mhsSvvByqcArA3YSlekOV7VNhroARf/L
 2RQg==
X-Gm-Message-State: AOAM532gxvPjaDyfRlX+iJm9LbaXws1Y5j4ENl2ARG/PRU1XIAWGAOi3
 zE5t4KLIRiuljzWsbTU0YbJPU4Av
X-Google-Smtp-Source: ABdhPJxV6BT3PE+jmGctOwa//GP20bP8SyRTOlj7B8RaAU9l2+CImuPhKdfotkn9G+eRgNluhJ5bRA==
X-Received: by 2002:a5d:4bcb:: with SMTP id l11mr3065533wrt.363.1591687953481; 
 Tue, 09 Jun 2020 00:32:33 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id m3sm2036192wmc.0.2020.06.09.00.32.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 00:32:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/16] target/sparc/int32_helper: Remove DEBUG_PCALL definition
Date: Tue,  9 Jun 2020 09:32:13 +0200
Message-Id: <20200609073214.14079-16-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200609073214.14079-1-f4bug@amsat.org>
References: <20200609073214.14079-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x42e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Fabien Chouteau <chouteau@adacore.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We define DEBUG_PCALL since b884fc5e (2012-10-06).
7.5 years later it is safe to assume we can remove it :)

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: KONRAD Frederic <frederic.konrad@adacore.com>
Message-Id: <20200331105048.27989-7-f4bug@amsat.org>
---
 target/sparc/int32_helper.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/target/sparc/int32_helper.c b/target/sparc/int32_helper.c
index 813b47dbb2..c56dd3df18 100644
--- a/target/sparc/int32_helper.c
+++ b/target/sparc/int32_helper.c
@@ -23,9 +23,7 @@
 #include "exec/log.h"
 #include "sysemu/runstate.h"
 
-#define DEBUG_PCALL
 
-#ifdef DEBUG_PCALL
 static const char * const excp_names[0x80] = {
     [TT_TFAULT] = "Instruction Access Fault",
     [TT_ILL_INSN] = "Illegal Instruction",
@@ -58,7 +56,6 @@ static const char * const excp_names[0x80] = {
     [TT_DIV_ZERO] = "Division By Zero",
     [TT_NCP_INSN] = "Coprocessor Disabled",
 };
-#endif
 
 void sparc_cpu_do_interrupt(CPUState *cs)
 {
@@ -71,7 +68,6 @@ void sparc_cpu_do_interrupt(CPUState *cs)
         cpu_get_psr(env);
     }
 
-#ifdef DEBUG_PCALL
     if (qemu_loglevel_mask(CPU_LOG_INT)) {
         static int count;
         const char *name;
@@ -104,7 +100,6 @@ void sparc_cpu_do_interrupt(CPUState *cs)
 #endif
         count++;
     }
-#endif
 #if !defined(CONFIG_USER_ONLY)
     if (env->psret == 0) {
         if (cs->exception_index == 0x80 &&
-- 
2.21.3


