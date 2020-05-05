Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E32C47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 10:27:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEC992075A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 10:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F0GeX8xL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEC992075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVunP-0000NV-Ra
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 06:27:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60580)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1jVulF-0005zm-35; Tue, 05 May 2020 06:25:13 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:41479)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1jVulE-0005Ut-6G; Tue, 05 May 2020 06:25:12 -0400
Received: by mail-pf1-x444.google.com with SMTP id 18so677134pfv.8;
 Tue, 05 May 2020 03:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=rzgBdHYiEgbbna1Bn7sV8b2kbFSXeD26jWa2N8NX3KA=;
 b=F0GeX8xL2hM/5ut6WXsT+TZOg3F06WDbtn2QQDevaXeozsX5ikDWFTZ82COM4lBWHk
 ynoaxBZsYCC2dUUVYIntf3B/jwdzVPPlVfbP6Hj5LhmHQamIc4fSy6FMQkKl94AZSVwx
 fxnDZuD7/Dbm8YS0OKv5i8HIYFKYh5aITuC/3Rz78IT7WdAPrV1TeN4ZaGUymgXrg4qF
 2vQ/Ye9uI9mKfeplGbr/KLJdISzf+ICRqArCfARcsQ3V0319onFgO6Wjo9tJCiEXanNb
 gcCZ5ti5IQ8du5syuAkcTNzb9shNrrp7XhmHH+35MPdo2JQUadNPEPd4u7AVeMlJqUS2
 ERFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=rzgBdHYiEgbbna1Bn7sV8b2kbFSXeD26jWa2N8NX3KA=;
 b=UsNK4JV89RvYDl0ADwYdQYPxpx4fYBcb/TYRVkAEsVb71bfuGDwd90oMp+yvRYLOtc
 GoDQQ/rNsPm9+azaUSMSIVPRWmAit3gWrHOx+WHkaubRm+sjU5V8mVWJXgapHJt4Xm17
 WBTDcgWEseZJ8X2cBnj63vIrufoJJzWNBhXO3Kad9A88aKJdrzJldj7hd0Nf9SokVFJg
 oLP3sIyxoLd14u8wMnbSflDUM9at+bzw1h5ceb7XcCMv/78J3i+umSyawKVm94vj9OMj
 O6h0VQjtXulh/xBHplLxMPpU8HzL2uWUvk9PcyG6dVhpSvMXxQlCENvaIiMCgTWvQWiB
 QPeQ==
X-Gm-Message-State: AGi0PuaWSlf7a0eW4sHlgA3MLyBy6yOz3qm0Z5pod05lW3fbZq3tBudV
 EV1bj/XsyhoIx1ee5dkocU8=
X-Google-Smtp-Source: APiQypJH9PLgjV9eO3IMUZiSsip9nam/BMy9d7qLfPsFlhNZuFKE27SHQ/TFDqq04S2LL0It4wbWIQ==
X-Received: by 2002:a62:76c1:: with SMTP id r184mr2508237pfc.155.1588674310393; 
 Tue, 05 May 2020 03:25:10 -0700 (PDT)
Received: from software.domain.org (28.144.92.34.bc.googleusercontent.com.
 [34.92.144.28])
 by smtp.gmail.com with ESMTPSA id v94sm1679937pjb.39.2020.05.05.03.25.06
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 05 May 2020 03:25:09 -0700 (PDT)
From: Huacai Chen <zltjiangshi@gmail.com>
X-Google-Original-From: Huacai Chen <chenhc@lemote.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fam Zheng <fam@euphon.net>, Markus Armbruster <armbru@redhat.com>
Subject: [PATCH V2] tests/Makefile: Fix description of "make check"
Date: Tue,  5 May 2020 18:24:51 +0800
Message-Id: <1588674291-6486-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=zltjiangshi@gmail.com; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: qemu-trivial@nongnu.org, Huacai Chen <chenhuacai@gmail.com>,
 qemu-devel@nongnu.org, Huacai Chen <chenhc@lemote.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The description of "make check" is out-of-date, so fix it by adding
block and softfloat.

Reviewed-by: Claudio Fontana <cfontana@suse.de>
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 tests/Makefile.include | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 03a74b6..5d32239 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -4,7 +4,7 @@
 check-help:
 	@echo "Regression testing targets:"
 	@echo
-	@echo " $(MAKE) check                Run unit, qapi-schema, qtest and decodetree"
+	@echo " $(MAKE) check                Run block, qapi-schema, unit, softfloat, qtest and decodetree tests"
 	@echo
 	@echo " $(MAKE) check-qtest-TARGET   Run qtest tests for given target"
 	@echo " $(MAKE) check-qtest          Run qtest tests"
-- 
2.7.0


