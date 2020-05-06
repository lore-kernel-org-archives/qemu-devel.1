Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE72C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 12:09:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17066206DD
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 12:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TOqCRSAm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17066206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWIrz-0006ET-4J
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 08:09:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56444)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jWIo0-000673-Cj
 for qemu-devel@nongnu.org; Wed, 06 May 2020 08:05:40 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:34191)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jWInz-0008V1-10
 for qemu-devel@nongnu.org; Wed, 06 May 2020 08:05:40 -0400
Received: by mail-wr1-x42f.google.com with SMTP id y3so1915521wrt.1
 for <qemu-devel@nongnu.org>; Wed, 06 May 2020 05:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=l0ckrCQ5spxnPtMLXsVmR+wvBlQLiCiMnLYuS1h+C5Y=;
 b=TOqCRSAmCrEql8RrV+2PZsVlf/9uPc+2OpeS/ne9FajwFAQ9RNxkJ091ChmabyS2G2
 sR0OeB0wD+RqAYZEYlgXvGvP+k3uPRm6fnOD3zq+hG9JawhEfEnY+IiX8WAFNxiiLjE3
 OBgnPwpT0G/H8dTVlW1VmSnW7hSco/756F1GCQ/aBUVcFvR6tFLASAyPJGQe02N+v3Gn
 k1r/w18BKAE/ak7mzU5uY4Q8mkjMHmCSaMR5FfNwlKb8owhak5SF9IhBzyPSRwfACvXi
 xjTlPpLZxMO9BS/29WOYIkTjugmgTZlAxnMMfONte1zzBsCR+BwZwabtNtx1YkzzNJ1I
 O17w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=l0ckrCQ5spxnPtMLXsVmR+wvBlQLiCiMnLYuS1h+C5Y=;
 b=ZI6Bl2OkJi0cjXoBFV1+/v8iSbegz8pH+x863VY589v73IT9qpWi/sm2iUJysbaUuf
 7iWlqu2MjtesxZ/HXnAI2s9BC1K5KwNxkcbm5hejmFAA1UNQG/reTCMoHXUWVUZfPUTl
 vXO2zQfUSR1oTih1ay/Ih1jLQgnKtUtz3rtiEEvA20wcrpiKbg1qjT8wSASKaZax4FPi
 RCNb8grpXRYrQL6BlX9vsdcG2Tvuo2KUcCewT61XcrsNTQ7Q2ZWTFJH2UKLaM3RJrMrM
 DSLoDe5b838G4ibmCImUEBFA63rxBhQX5RzBJqyGUMbN9RwrLmlxxjArkm8rmdQ2gf4Y
 GCSA==
X-Gm-Message-State: AGi0PuY/yBALBWSTMpDu1bXue/sedQexBr5e1wVSDT2PBG6la70aywm9
 CDpsfmqA+qSLNhGf0p1yU87wizlJh28=
X-Google-Smtp-Source: APiQypJkcGx/j7mGDmCQBPn4ix7LbhHpnk+UVV3jSg5VgUffe9hrgafulRM7Dzj7oK5mTZ5F3Q83BQ==
X-Received: by 2002:a5d:6107:: with SMTP id v7mr8712424wrt.270.1588766737270; 
 Wed, 06 May 2020 05:05:37 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v16sm2727775wml.30.2020.05.06.05.05.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2020 05:05:30 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C12A01FF87;
 Wed,  6 May 2020 13:05:29 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 01/14] .travis.yml: show free disk space at end of run
Date: Wed,  6 May 2020 13:05:16 +0100
Message-Id: <20200506120529.18974-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200506120529.18974-1-alex.bennee@linaro.org>
References: <20200506120529.18974-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200501111505.4225-2-alex.bennee@linaro.org>

diff --git a/.travis.yml b/.travis.yml
index 2fd63eceaac..a4c3c6c8058 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -113,6 +113,7 @@ script:
         $(exit $BUILD_RC);
     fi
 after_script:
+  - df -h
   - if command -v ccache ; then ccache --show-stats ; fi
 
 
-- 
2.20.1


