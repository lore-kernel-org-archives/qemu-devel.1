Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53BDAC31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 18:29:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21D3A2177E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 18:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LT8cYFML"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21D3A2177E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54112 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbqwh-00073D-7M
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 14:29:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39245)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hbqJZ-0004Ty-Nf
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:48:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hbqJX-0003WH-OR
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:48:37 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:53607)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hbqJT-0003RZ-R2
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:48:35 -0400
Received: by mail-wm1-x344.google.com with SMTP id x15so3209805wmj.3
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 10:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HqBVQy6B4RYG2ErzndHduRIrrPjVT1ZXYEPUu/ciMz8=;
 b=LT8cYFMLNKMTk3dEokm1wL2vbJqCrB5gtaglpgbLMpSqwJHrP752/Bl+w3pA29KTlQ
 /Aoc0f+RnMt3mjFkspoJdgea0iTDqUlbX72lj6FB+Ir5grgAoY0ov8N0j6Z8g9LPku4G
 +X1CXB9dj2ogOH1q4OwftL9yi2VI9j/nuAxEawMx13T2irMt90UhXwOLzHjMbf4xhX7d
 vBfoYALwOunYlTkBCkjKCga6aqqIezKzwXD2ooYjaF8Yn/jmfsiC5atso6pfvbo1/A+d
 fqilNBYxBMpyU4fiNPhWC+oXN2tK8ovwLydpXdjktev2J51RNOH8bycUoHwfHH4BdpGF
 WChw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HqBVQy6B4RYG2ErzndHduRIrrPjVT1ZXYEPUu/ciMz8=;
 b=n5tdzU1vBxKLugnkmpGCoMs6wFU8B1x0aamro0pe6FSKs+WSjBow+dZ4XBMfA8Xna5
 3QB77q6i+p4liHob7+uv3UISu7xip1wf34+sRisELPe55rllcvMsnjsRarSZXGmV8gGj
 Ip1N4FbgI3POHAfu1DoIjRCwABoBlOzIZtj5hQvWxri3HGieQo/hQ03gIk4IgDcgx8g1
 bOOOOc7wF+Bw/7pMRA4WHU+wioXwthMxAo9vkNN8ShtmytSSji/OCFidNV8SGhK92V+X
 GG8Su+2BkRLF8TiIZbvyWBqaXAnLZa3DBMDGEm1VrGpQJ354o5T5hFaolBa6jbfLuaPu
 3WJA==
X-Gm-Message-State: APjAAAW8Lv68dLydkb2S9arbnQJnMPE1sm5Ngc/rouzbA1sCgI3q2c2v
 5WqugwWG6CJ4HtfViFF67c3HDsNODI8=
X-Google-Smtp-Source: APXvYqw3oLvR6oVr3vcjA0xVXdU0dy0o8hSs9B5kenQCGyk2LKrqxObs2NVsprv/Ucd00P7ogb+5jA==
X-Received: by 2002:a1c:cc02:: with SMTP id h2mr8679411wmb.13.1560534508257;
 Fri, 14 Jun 2019 10:48:28 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id o1sm4604546wre.76.2019.06.14.10.48.27
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 14 Jun 2019 10:48:27 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7E5861FFBA;
 Fri, 14 Jun 2019 18:12:03 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 14 Jun 2019 18:11:44 +0100
Message-Id: <20190614171200.21078-35-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190614171200.21078-1-alex.bennee@linaro.org>
References: <20190614171200.21078-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH v3 34/50] target/sparc: fetch code with
 translator_ld
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
Cc: "Emilio G. Cota" <cota@braap.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/sparc/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 091bab53af..c91ff11809 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -5900,7 +5900,7 @@ static void sparc_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
     CPUSPARCState *env = cs->env_ptr;
     unsigned int insn;
 
-    insn = cpu_ldl_code(env, dc->pc);
+    insn = translator_ldl(env, dc->pc);
     dc->base.pc_next += 4;
     disas_sparc_insn(dc, insn);
 
-- 
2.20.1


