Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25136C31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 18:53:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7EE021473
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 18:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mfXJqv2i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7EE021473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54320 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbrK9-0001mD-7v
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 14:53:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34263)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hbq0W-0007Gh-Oh
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:29:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hbq0T-0004Is-Ms
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:28:54 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:54877)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hbq0P-0003pL-Rg
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:28:51 -0400
Received: by mail-wm1-x341.google.com with SMTP id g135so3141217wme.4
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 10:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sbV6bhfix9ogursybnzoCKTzFmIQ6JokAy/mT287wFE=;
 b=mfXJqv2iDKtSoCK5JpfLwekLTuzQhzmRoOwcpNsgqBTDsQgz1k0XI/Jy7SyZNsWl7X
 rZ754yFoQDVDymkVwTK6Evf/jnlMn83q+Ha4ZEkChMeU9jF0+HmQ5q/G/FHkjSh19rT5
 VLh3cF4K71sYO0Z83vgRBPJ4kAGsjMNoTWCGECreeAs60Ta1ZMKtfksMDiNjJJ9+RDT6
 pOCWG5DfdIXprdWbBaeFLmPaISOQdor+KcAEMBmsI9Jn4sKFH+3f7/rSp+jEBBJGRx2C
 5k9mllWilp2KJx0jjYBG182A2YaZtZcLj563OlbeitiB+D/2SvTmuJ/45cL1AKoIrmvg
 Wziw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sbV6bhfix9ogursybnzoCKTzFmIQ6JokAy/mT287wFE=;
 b=p5EExkBzhEXte9Hc/FYCLs0k2F5aHOpn6KfaZNAHghO1xDVytv4/VTsDmHZarSFCp3
 ldJAC3hHM12kJCjcPIkoW6U2iIGRvp6rVNJHp+RGJdP3YyrZaHvxSePE7ya+CQD8cOBj
 HUeCt1x/jFUnYtH6ZpEozZS/bTewDenCtnRfhagoT9DkLuri0brBNjJOxnTmCnEfMK3v
 o88tsg5MNwdo6u2jUa4pOUrnyneSOFO18/vmYkJLy1w40l8iwqO+xwxkeA1t2ZP59GsX
 HYAmFqi81U2RWKfKox3MFhn95xbpPmgyr91T49LelNfnd/fv0oREA+qBs0cA3bm/rn89
 k3oA==
X-Gm-Message-State: APjAAAX2njRb8ecQocofLNRyJzc7NwVBULuG7BrP8m3Ud0dtqoElS9iT
 sGGiEBSCWfIifKqGrxSNe5bzJg==
X-Google-Smtp-Source: APXvYqw2mEZdlvTBSoFYPr3sTDIzPskNfUQBwlQteDOGw/Er33YzAaE0fynFyS6QGWQIqO+/fUrMkQ==
X-Received: by 2002:a05:600c:2383:: with SMTP id
 m3mr8616299wma.20.1560533312982; 
 Fri, 14 Jun 2019 10:28:32 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id o1sm4513463wre.76.2019.06.14.10.28.29
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 14 Jun 2019 10:28:30 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A7F481FF90;
 Fri, 14 Jun 2019 18:12:03 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 14 Jun 2019 18:11:46 +0100
Message-Id: <20190614171200.21078-37-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190614171200.21078-1-alex.bennee@linaro.org>
References: <20190614171200.21078-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PATCH v3 36/50] target/openrisc: fetch code with
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
Cc: Stafford Horne <shorne@gmail.com>, "Emilio G. Cota" <cota@braap.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/openrisc/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 4360ce4045..7df4c68d15 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -1305,7 +1305,7 @@ static void openrisc_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
     OpenRISCCPU *cpu = OPENRISC_CPU(cs);
-    uint32_t insn = cpu_ldl_code(&cpu->env, dc->base.pc_next);
+    uint32_t insn = translator_ldl(&cpu->env, dc->base.pc_next);
 
     if (!decode(dc, insn)) {
         gen_illegal_exception(dc);
-- 
2.20.1


