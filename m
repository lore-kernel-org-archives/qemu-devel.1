Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45364C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:23:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14259208E3
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tLN/i8cr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14259208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42579 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsrNm-0007Oh-Bs
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 12:23:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42462)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hsrG9-00062U-4v
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:15:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hsrG8-0004By-5a
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:15:25 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36278)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hsrG7-0004BH-Ut
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:15:24 -0400
Received: by mail-wm1-x343.google.com with SMTP id g67so56258810wme.1
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 09:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jB7W3FnB4bnhencvSWp2/0bfRyouD1FARGQ5v7psx1U=;
 b=tLN/i8crKQj7EKMJUlE3vyW8kdZW+EFbyYA6oT/h30aGTqZcQHySyzP9d+1+YtwIe0
 4Cdc+bY24k0svWVv4sHHcJ4Q4nv/ovyxiIwCo+ir3DG4gHBhIaieNKY7FZVm9jz8YhhX
 YI7FGjsu0Q0ucs8N/Pl/Fn9UoPeGRcShsYVR/DJtx7dTwm+ZgUH6EqeCjBioYj8OkTuC
 6XaVnM+gdV2wPtBfpMjeqJYCHYrVe4V2/4Ai63VCoeZXoPfGxYq+LcTaTCd0MNckQoFP
 OEkEEPCQwSsY3vEdabHplEFc3V4HvZZCqjCMB8+DEb3d3nz/7hzUonUpLfkWJo687BHW
 Sx8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jB7W3FnB4bnhencvSWp2/0bfRyouD1FARGQ5v7psx1U=;
 b=nK6eBUbeMv7YjSW/KRTxcf0vofcsX3X3C5hXf81RzeU/vLqGS4mWbM0QdRa73yXURh
 4MXkEzFwtdD0ZeO8/bwAmyL+6K4qBWcrfKAJpEdFBe2dwPQ/7XqA8PiUzDJ0b06Owg9p
 iMFlc2WihsNLMP2dWEI2ShrYSUHuxz/J1NAZmP+XeW3HTtxGaAlBQMNRQCdckezOBFwp
 4+Vxccs7AZ1bFsa0AyHhe/t8ILlfFM7IpPty3mBdWlGILrHiP0tf7PUl6q1TpkP4QyS0
 7e1uNV7zzpjM5QUTlG4zsftiq3W4SbdkDeXrPHK0K/IKT73gGV9NOtqJX548ZNeDVqMG
 AqkQ==
X-Gm-Message-State: APjAAAUT+0KMR5jqQ2giiEojnRv5l2r6LRA3nKuFuB4ztvgtxVV2LawJ
 9tkLZR4zyqaUTtpFBssaALZ2cA==
X-Google-Smtp-Source: APXvYqxE+mrvkBZo4zbsGfnX4ypyJYo3glke8K0nik+skrWxrzZJj9jqOep1j0iaEaazp7r2Ibmb1g==
X-Received: by 2002:a1c:7f08:: with SMTP id a8mr63599005wmd.1.1564589722735;
 Wed, 31 Jul 2019 09:15:22 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id n9sm114528509wrp.54.2019.07.31.09.15.16
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 09:15:18 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1E1B91FFBD;
 Wed, 31 Jul 2019 17:07:23 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 17:07:04 +0100
Message-Id: <20190731160719.11396-40-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190731160719.11396-1-alex.bennee@linaro.org>
References: <20190731160719.11396-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH v4 39/54] target/sparc: fetch code with
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, aaron@os.amperecomputing.com,
 cota@braap.org, bobby.prani@gmail.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Signed-off-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/sparc/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 091bab53af3..c91ff118099 100644
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


