Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81DE1ECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 11:24:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C61120673
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 11:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R4IJOT1o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C61120673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJyST-0002kn-2C
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 07:24:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45502)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iJy2B-0006fB-E6
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:57:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iJy29-0005Ac-Pp
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:57:03 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39866)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iJy29-00059f-Im
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:57:01 -0400
Received: by mail-wr1-x441.google.com with SMTP id r3so19173554wrj.6
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 03:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mpf3Fhzk3B9PbwCFqYApvOLgEupxrJceH9hSjq15/sI=;
 b=R4IJOT1o1jOjjGhkIgF9MHKi0M+Qx5IEuXP79ISbqzcuKGRRc7Id8uLJFUnbk6IiRn
 Rl5lG+CJsE0JpeOFc5WTDXc4k5WfDYSPbQfE6XepuGcOkEnTOrFS1P0AqJypA7dTcTuv
 8eQkDsvP6uMCnyukSIMdQAopgjWJa+1tzzdF5IDtGt6jv4jCFSG8AATpRvmLdM+VLFrq
 4/uR7vLdD/Y7YBIpn9yZYiJGevzJLacX5AE5avUL4IjJuaawZOUmSkm2BI7GXpPz/Fq2
 ZPN8+ddRV7m1D5jcVqqoWfKD2Byoc37TDCfdwSF1ZT7eCpYpbY5R9gYiTsHwvr33SyR9
 7nhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mpf3Fhzk3B9PbwCFqYApvOLgEupxrJceH9hSjq15/sI=;
 b=qMIdLZaiKhfI1KQznDUhMpn6CJ48MFe9hre8cDp9eurj03/NqqS6dUSVZZfG1xPa34
 qFF6wyw2tXvrf7AnKlRRqDLHpvLZxKnqNt8jACWTqhTuvIe3ev+KsQ9QqRbuKOGMQx3F
 Tt1AFrmASsD5Gps8q+lV3j3dTWcwKOYFe9cQCqKSVaij+39pKQWnR9lDmTHsAoaizZU4
 wMLs/z1em5XM2Iaz0dkTiXD70xy+zGrvFC0WVINCUbt8XZGCXa00n+sIIfq+6MQLX3vt
 C25wVDzkSGWrKCXoPe80VzpN0legWEkwUq0RxoWpQe38tJVrp+VmMNDtK4GnL43uF16g
 75tw==
X-Gm-Message-State: APjAAAVRVvN1vP7j8cVlueRlT9A4A6ZZk9JJsyFIccv7baz4YAVE5235
 K6n0286rVw8w4ZTmvfXkuYd85Q==
X-Google-Smtp-Source: APXvYqynKJGaKkwnnpic5+zwXjqcPQv/BUIPXWJYkarNMRFy1yQcHD6ZlsmliQiA7+QWhJNNsGA+rQ==
X-Received: by 2002:adf:bd8f:: with SMTP id l15mr24807414wrh.362.1571050620522; 
 Mon, 14 Oct 2019 03:57:00 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u2sm9583732wml.44.2019.10.14.03.56.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 03:56:56 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 067D91FFB8;
 Mon, 14 Oct 2019 11:49:56 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v5 30/55] target/alpha: fetch code with translator_ld
Date: Mon, 14 Oct 2019 11:49:23 +0100
Message-Id: <20191014104948.4291-31-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014104948.4291-1-alex.bennee@linaro.org>
References: <20191014104948.4291-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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


