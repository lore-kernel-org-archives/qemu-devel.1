Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B0AECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:56:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D3E92082C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="da4H6VrM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D3E92082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL6Gw-0005nB-4R
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 09:56:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35485)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iL5mR-0002BS-HD
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:25:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iL5mQ-0001Fx-HD
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:25:27 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:50786)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iL5mQ-0001FW-AO
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:25:26 -0400
Received: by mail-wm1-x341.google.com with SMTP id 5so2580612wmg.0
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 06:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mpf3Fhzk3B9PbwCFqYApvOLgEupxrJceH9hSjq15/sI=;
 b=da4H6VrM+xN7VjkwNt7QKqDGy9JU8gzWON4QiqnPqBOJo+PscTol7hjA6i31qgLbg5
 lNiPqnvb6EtsjBx3IV3sWnUC06IG4UcmdtxZYJv1Xm9mZvqY6EEOYim7X6jmKBTdovbR
 cvqxiv/dc+ajU5+VBHDwAdzjk04MFiwJqLCP51b4R5CZNTrmM38/HYdypQbqSaIdiFbe
 e5ZQOTpD5ix8Yprkj0m2InHw1VrSvUcZiYtyEiNqBkd7ZXvuwP4cCTuAuTGB02AgqNwG
 +7tB9uPJ6eF7FErNQ6RAgcQvaJR1spkUYlncmx8SHn2ejhky8RISISfsj+sI8zEwGYMY
 vwvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mpf3Fhzk3B9PbwCFqYApvOLgEupxrJceH9hSjq15/sI=;
 b=brKgvl1ytGV3XHmLTjePVUfQqWUM058Nx32ZN2gY2XWmvxdtwLfkP0QjyCkdgpKj0G
 2G4RdXqnh5Xr8IOuWN3E5lWJs6jmUSSEMxmfX6U0Ur34mg+qPctOfUnvFuhVgY96dJq/
 Dt3ToO6G4YM4XcGEHuk3ahVahzo3f+tv3PareWlQ27p6LW9KFSiQV0AuYZ3ceWfCDRlD
 irBcSCIlkK1O9eQQvRbKULYVPdaES+1gu4rTp7uGRgR0Iak3gyROj/oITjyv9jwOGdXL
 i4qf/Pt3c/sowCdsebvOq5WrJrNHEx1BirMKP9aLfmOX7EdCjuOeIgmEKjAeBiEp+nHF
 J7gg==
X-Gm-Message-State: APjAAAWdCwhrugqOuq+9j/zgvLGmDp4ecnGXdjKsbeLerU8fPNwlm7Sj
 JjNPu48uLC/65AL56Ffq8DbMTA==
X-Google-Smtp-Source: APXvYqwONkvWxf6NcJ1Vy6licN4W3iKYLoGFUeb33FLhe0k3FpB8iYjvK5tNVGVvAZTD2+j3wQYxbg==
X-Received: by 2002:a1c:2e4c:: with SMTP id u73mr2825847wmu.94.1571318725134; 
 Thu, 17 Oct 2019 06:25:25 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a9sm2964667wmf.14.2019.10.17.06.25.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 06:25:22 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9DEC51FFB3;
 Thu, 17 Oct 2019 14:16:18 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v6 29/54] target/alpha: fetch code with translator_ld
Date: Thu, 17 Oct 2019 14:15:50 +0100
Message-Id: <20191017131615.19660-30-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191017131615.19660-1-alex.bennee@linaro.org>
References: <20191017131615.19660-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: robert.foley@futurewei.com,
 Richard Henderson <richard.henderson@linaro.org>, peter.puhov@futurewei.com,
 aaron@os.amperecomputing.com, cota@braap.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Signed-off-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/alpha/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index a69f58bf65..f7f1ed0f41 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -2987,7 +2987,7 @@ static void alpha_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
     CPUAlphaState *env = cpu->env_ptr;
-    uint32_t insn = cpu_ldl_code(env, ctx->base.pc_next);
+    uint32_t insn = translator_ldl(env, ctx->base.pc_next);
 
     ctx->base.pc_next += 4;
     ctx->base.is_jmp = translate_one(ctx, insn);
-- 
2.20.1


