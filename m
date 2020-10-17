Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5207BC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:17:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C055120704
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="trlboDlX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C055120704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTn1B-0003vF-S6
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 10:17:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36638)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTmoC-0001kH-Fx
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:03:44 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:36541)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTmoA-0003jT-Mw
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:03:44 -0400
Received: by mail-wm1-x329.google.com with SMTP id e2so8390585wme.1
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2020 07:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RMjis+VK7lDKD3DwbFfzb5usAINbaM2mLX6bmZd7Xrw=;
 b=trlboDlXNf1gimEFX35s1JCnC00DlL6PEhN68ar2a0UBShE3yMlcQjkfhxEpQEwZXP
 0/wr0va5xUbh/vUSm5Duger9jcCgX9ERQo0FnwsMkJJf/kvvqmyP08UCnLHPvj42bZJ6
 YiJOE4xtaVRv3MN+vjDWeQYsVwKIGocWJBauaCde6FkyDsJ/PwrbvRxrrWsTuM7DSpm9
 gIaGjT26nEhUNn93uEWv4n4SWTlR+RLvU8v0++HrKGGJP+RVx4YcEepJlXaB2nU+b/Iy
 Wo5qn7GVe8tBTiKIIfqbhe8GqMBRLMFzM8/1/IvcFiNAEuuagJ2EObNVm4XAYn6ZhzQn
 pCCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=RMjis+VK7lDKD3DwbFfzb5usAINbaM2mLX6bmZd7Xrw=;
 b=KKeVCJ+AwTOxmcp/gViPTaxtbkmje4Q5HmIcWflpk+u+HvLvAsBMtmXjuQaWUh+rd+
 EWMK/xThXF5dw1Xa3qpWZhnWvZO/3K/towbio9n5N2/tlTYn/BcXupmWD7RJDuWyjDmR
 xWApUDsVvDInZ+M1nbiHKAyRmz84Ak38bTbQzer374T8zJIzjDLy9aoF6C3NMbq7PktK
 P7HR/DsbFa9h5lhBh2SxccOIKLNVWKEy7RGQDjGOo8Hu3Y7NHnRUzNgtsl1DKfT9iU7s
 mK8HVJai+RnI+62uALDDRwC2jThYVStBgac9EyCGm0eKuQ3UC8XooejUyJyfauIl/E5r
 Q3ng==
X-Gm-Message-State: AOAM530vNkCxDFQlJGBoFVwwJmH20DzmHRTGTdDQ6TU5EU8g47rbE/pc
 mzVIN3kUA3lHBTiH0DOlKC1pgA4koSY=
X-Google-Smtp-Source: ABdhPJxZy3VhV9SIm4UpA36NSI33mMbQr10eFchqpeNlbiEjRZmAHnnAQkI1+9r83ISXP12/krh19Q==
X-Received: by 2002:a05:600c:2297:: with SMTP id
 23mr9066750wmf.104.1602943417303; 
 Sat, 17 Oct 2020 07:03:37 -0700 (PDT)
Received: from localhost.localdomain
 (117.red-83-52-172.dynamicip.rima-tde.net. [83.52.172.117])
 by smtp.gmail.com with ESMTPSA id x64sm7473502wmg.33.2020.10.17.07.03.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2020 07:03:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/44] target/mips/op_helper: Convert multiple if() to switch
 case
Date: Sat, 17 Oct 2020 16:02:10 +0200
Message-Id: <20201017140243.1078718-12-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201017140243.1078718-1-f4bug@amsat.org>
References: <20201017140243.1078718-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x329.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Paul Burton <paulburton@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Huacai Chen <chenhc@lemote.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The cache operation is encoded in bits [20:18] of the instruction.
The 'op' argument of helper_cache() contains the bits [20:16].
Extract the 3 bits and parse them using a switch case. This allow
us to handle multiple cache types (the cache type is encoded in
bits [17:16]).

Previously the if() block was only checking the D-Cache (Primary
Data or Unified Primary). Now we also handle the I-Cache (Primary
Instruction), S-Cache (Secondary) and T-Cache (Terciary).

Reported-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-Id: <20200813181527.22551-2-f4bug@amsat.org>
---
 target/mips/op_helper.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index 9552b280e07..c15f5c07761 100644
--- a/target/mips/op_helper.c
+++ b/target/mips/op_helper.c
@@ -1574,15 +1574,20 @@ void helper_msa_st_d(CPUMIPSState *env, uint32_t wd,
 void helper_cache(CPUMIPSState *env, target_ulong addr, uint32_t op)
 {
 #ifndef CONFIG_USER_ONLY
+    uint32_t cache_operation = extract32(op, 2, 3);
     target_ulong index = addr & 0x1fffffff;
-    if (op == 9) {
-        /* Index Store Tag */
+
+    switch (cache_operation) {
+    case 0b010: /* Index Store Tag */
         memory_region_dispatch_write(env->itc_tag, index, env->CP0_TagLo,
                                      MO_64, MEMTXATTRS_UNSPECIFIED);
-    } else if (op == 5) {
-        /* Index Load Tag */
+        break;
+    case 0b001: /* Index Load Tag */
         memory_region_dispatch_read(env->itc_tag, index, &env->CP0_TagLo,
                                     MO_64, MEMTXATTRS_UNSPECIFIED);
+        break;
+    default:
+        break;
     }
 #endif
 }
-- 
2.26.2


