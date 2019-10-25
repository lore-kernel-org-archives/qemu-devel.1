Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 180D8CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:36:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D943920867
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hJdUnxpf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D943920867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNu9Q-0006nQ-EP
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 03:36:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40308)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtps-0004S8-Gu
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 03:16:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtpr-00077d-7X
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 03:16:36 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:39309)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNtpr-000772-0R
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 03:16:35 -0400
Received: by mail-wr1-x42f.google.com with SMTP id a11so1027781wra.6
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 00:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xEhoj1zEJpx/eHbcjzF4pAJZUeLviMrjuMQMfk2ktQM=;
 b=hJdUnxpfVzARh68uiyeBFQXhq+SfZO6AlM4JXKZchVWq+pfDS/LHnsILQoERXChkX9
 GzBbzaa3+AmSHWqSTL66K+WTmtgCGS01EgpPmbwwv5rmOlV61sPVJqrRoUIm+dudlg97
 OrTeuRFAf2bYVKtUCBy3O3QrD1Rpm4mLMXh/P7mlhLqRwxmcE8wlX2qJHBQc95+rb/2M
 NPkSlC5HAx/xAy3KqAGT0ainFgBVWtFPzrqjBDfy6CpJmgPy5NPwqx4+TjlbdklpZ5wC
 75KIopEIN5+z2Jusjol+afxJ1XEmL90Fzi3XTjgrNDcT4szOm2LnS9SYEtFPtsOnCdsu
 2UoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xEhoj1zEJpx/eHbcjzF4pAJZUeLviMrjuMQMfk2ktQM=;
 b=YBQzX4ARso4o5GC+hNg1chPlTfYpkmNUazoo+jgyT22NLUWEgxlDc0hSYUGiqd514P
 F4g59tUKg41acT1pwGK4No9yZV7ap2Sb4ACd/NU2o4N8cJ9dc+4bgzCq/FZpkeVXeYxT
 8lhG7E/OvCVnew9FBcoVzd9aCnqqt9F7JVtpS7y3reId08Xxt8oywHf6v9U6clr4XUVH
 VEHttAl+MAQFvrnrAijxo17bX4SAu8eZqKShc66rH6HX9FbXczVHTGrrEW7Cswsly1dg
 jhI39cIaGp+d3IPQm1HPx6Qr2siDP/qUZJsP8iwzb8vlVmLlIhVfEMkU80Ny/JYjdGKT
 3lVQ==
X-Gm-Message-State: APjAAAVtj62ueo8h3KLd25Ti6nI7JHi/qh75Pn+GCFuleLpv40ReG//D
 rIRHCX80iDOkjPONXh6hj3veLg==
X-Google-Smtp-Source: APXvYqz7+81wCg91mfnIhidSyoMjMK/ak2KiHmy5M/aavL1jmOw9DVvIe3y4RFK918MSmJepU63S4A==
X-Received: by 2002:adf:e28f:: with SMTP id v15mr1387314wri.130.1571987793415; 
 Fri, 25 Oct 2019 00:16:33 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id k1sm315914wru.10.2019.10.25.00.16.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2019 00:16:32 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BB3BA1FFC2;
 Fri, 25 Oct 2019 07:37:17 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 42/73] target/sh4: fetch code with translator_ld
Date: Fri, 25 Oct 2019 07:36:42 +0100
Message-Id: <20191025063713.23374-43-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025063713.23374-1-alex.bennee@linaro.org>
References: <20191025063713.23374-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42f
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Emilio G. Cota" <cota@braap.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

There is a small wrinkle with the gUSA instruction. The translator
effectively treats a (known) gUSA sequence as a single instruction.
For the purposes of the plugin we end up with a long multi-instruction
qemu_plugin_insn.

If the known sequence isn't detected we shall never run this
translation anyway.

Signed-off-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 5a7d8c45355..922785e225e 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -1917,7 +1917,7 @@ static void decode_gusa(DisasContext *ctx, CPUSH4State *env)
 
     /* Read all of the insns for the region.  */
     for (i = 0; i < max_insns; ++i) {
-        insns[i] = cpu_lduw_code(env, pc + i * 2);
+        insns[i] = translator_lduw(env, pc + i * 2);
     }
 
     ld_adr = ld_dst = ld_mop = -1;
@@ -2332,7 +2332,7 @@ static void sh4_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
     }
 #endif
 
-    ctx->opcode = cpu_lduw_code(env, ctx->base.pc_next);
+    ctx->opcode = translator_lduw(env, ctx->base.pc_next);
     decode_opc(ctx);
     ctx->base.pc_next += 2;
 }
-- 
2.20.1


