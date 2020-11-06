Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D009C4741F
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 15:30:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98D8C22202
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 15:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MTA/9uMD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98D8C22202
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb3hU-000818-JS
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 10:30:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38102)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kb3eW-0003QQ-07
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 10:27:48 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42545)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kb3eU-0001HT-A1
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 10:27:47 -0500
Received: by mail-wr1-x441.google.com with SMTP id w14so1721542wrs.9
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2020 07:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3Ni7G05pYt+LDiFpxH3YOkSYrcyuPHp1dU/RFuicYYM=;
 b=MTA/9uMDNy6n54NxO4HhuW6vGMh09HVoT21yeMuELxCYc9sSRijJpwqLOBPqFG9YdK
 7jSGQ9UzGQFngD09+5n7cKH3VT7WsN2VxReqUGKM69dNMjT80/FGivjDvflP9lhw7QGa
 BLMp5RDEAYHn7E8w1RbbkM0Q7bT/DpkVyNSgPNOi2659SgYYL3+sKjWymaQDG7WHQsvl
 vBkSEYBjHj3LRXdsd74qpjgpjkBkW/QlysMjzLABv2aQ1hft+kqBV05P7JISiAdKjF9L
 X996zvdNFImEG/cEcHryeYg/OBn4dgTQTcOjCWVkc6iPOCz4BhYFAY5x0muOEn38JVnW
 NvTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3Ni7G05pYt+LDiFpxH3YOkSYrcyuPHp1dU/RFuicYYM=;
 b=Fhf4ZJ66dzRbLbrh45tJOMTPrdlWFUBvHr3NTPAucu+YlFoKJXIuTUm9SslGNnb59c
 OX4pUmq7Eoj1mdE8/VSeLsHh18s3iR8qNeDOEMqwk2tDLx1aQ1whl9+HARFXFn3SRR78
 s0K7QFFbO8AcmMdJK/vifcF/yEOpIr+3wm9qofYwJd67k9Rwjs+dzmfvsfv59GhwGeDz
 fbqPwPbxrGX5jCco5TCvX6vYR27m0ul5NV6ZP1mwPModzBzrfcCsfaZhEgdYb6B8Iff6
 5z3QJdOAmgJw8dY975uXUbeolFFaoZrRIA2gfOYFFwpurFGlzWqcsaTbnejWAYDWur44
 gPDA==
X-Gm-Message-State: AOAM530kF3ZumitMuH04F0EAEk5wm1QjMXyh/tyVt74as4igHIOZl4F9
 oTQmA0C0lmLr2Wd4fCb29emAzkZyb/V3pw==
X-Google-Smtp-Source: ABdhPJwcRR1PUyzN7pLI8m5qKO67y5khiRt/RgTsjiS7cSahFAIJPWJ9+6h5qMDD28mzMx0suCjYoA==
X-Received: by 2002:adf:9e08:: with SMTP id u8mr3206856wre.282.1604676464540; 
 Fri, 06 Nov 2020 07:27:44 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 109sm2723462wra.29.2020.11.06.07.27.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2020 07:27:43 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/4] linux-user/sparc: Don't restore %g7 in
 sparc64_set_context()
Date: Fri,  6 Nov 2020 15:27:37 +0000
Message-Id: <20201106152738.26026-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201106152738.26026-1-peter.maydell@linaro.org>
References: <20201106152738.26026-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Giuseppe Musacchio <thatlemon@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The kernel does not restore the g7 register in sparc64_set_context();
neither should we. (We still save it in sparc64_get_context().)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/sparc/signal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/sparc/signal.c b/linux-user/sparc/signal.c
index 43dcd137f51..ed32c7abd17 100644
--- a/linux-user/sparc/signal.c
+++ b/linux-user/sparc/signal.c
@@ -447,7 +447,7 @@ void sparc64_set_context(CPUSPARCState *env)
     __get_user(env->gregs[4], (&(*grp)[SPARC_MC_G4]));
     __get_user(env->gregs[5], (&(*grp)[SPARC_MC_G5]));
     __get_user(env->gregs[6], (&(*grp)[SPARC_MC_G6]));
-    __get_user(env->gregs[7], (&(*grp)[SPARC_MC_G7]));
+    /* Skip g7 as that's the thread register in userspace */
 
     /*
      * Note that unlike the kernel, we didn't need to mess with the
-- 
2.20.1


