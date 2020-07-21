Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12242C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 08:58:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0E5020720
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 08:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7xg4qBB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0E5020720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxo6q-0007Ug-3b
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 04:58:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53740)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jxo67-0006eu-AK
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 04:58:03 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35834)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jxo65-0004Zy-Mk
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 04:58:03 -0400
Received: by mail-wm1-x344.google.com with SMTP id 184so2093451wmb.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 01:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+ZM5rFnLIv7XX6JCDu6MU2+dcdw1FuRLMox2ftXigb8=;
 b=K7xg4qBBUYLL2e/lOIpvoUo/5oEJNM8DO0dqf+1E3IXr7xs00DkVH+tw+x9N8Gz/mk
 d9PZOdMw1nFYHaq09KmgpFdUs7WIXes3eS0xUcTGtBERMREFLZrYqAVyCsFgCVDQaONz
 hPAZV2YYa4EfHrJAs0n2U35i4eGX1hz/ub3ydRkA25BuPnFXcdFP4eHtrGZOWgVEItWw
 doqcmziDtXcvTKyrFpl3NM+0kkFeDW6kOxPRMXUvCt9QAZTIIJEWWb5gRQBYtlDYfxZg
 6rx21YqFb2UVVygo3bBMAzxxARpYTnr4z+wCbeLiPqrUghxR85p29nGEcDuKiM7Ql1qF
 udSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=+ZM5rFnLIv7XX6JCDu6MU2+dcdw1FuRLMox2ftXigb8=;
 b=nG0h5eLX6asYHepM1kYz+1ACURH05SvJ8mZLZDWtJeunJuOVsL8+3ugkyGMChKHTsT
 RoYBXQ46wDNJUO5Lj+MlFcbCzgNYe54NXKKyOWGHfDNEMhIyjHfMHUZd6r7GiwK5TS/G
 5TzSMRYEDJGf0cUOK8fGTMc/okxwXu13ndGB6yKWjmV3LPS+nutseff0NjmxH6fesPGD
 mvmhkdu23OFrv+0ffHDVV4vUpq4ZPmb028n9XD4tbDtvt91Zeb1GqF/3SHHqZjBmUKW2
 gof5JeQGZbUSNGgQSarK5MU/y05h2cRzhOTJhRbOqGyNOWLkLsqb5QENV8CcdHh/GCV7
 cysg==
X-Gm-Message-State: AOAM533LmHj5K2bsyN0hmjvEUnpFwtE9nX7ht2MftK6dlGZteeliHI9H
 A6ppCooSxJg+2+infNxDq9KNpavcFOM=
X-Google-Smtp-Source: ABdhPJyCAktV5ppT9DBt2zbruEohvR6q0W9qQwSe2zFxwabTf8vPiEgn73VWaht8fuZ87IfxvOifmQ==
X-Received: by 2002:a7b:cb47:: with SMTP id v7mr2911682wmj.57.1595321879108;
 Tue, 21 Jul 2020 01:57:59 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id s203sm2650269wms.32.2020.07.21.01.57.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2020 01:57:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH-for-5.1?] tests/tcg/multiarch/linux-test: Skip test if
 nanosleep missing (Travis)
Date: Tue, 21 Jul 2020 10:57:57 +0200
Message-Id: <20200721085757.14358-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The time test sometimes fails on Travis-CI [*]:

    TEST    linux-test on aarch64
  tests/tcg/multiarch/linux-test.c:237: nanosleep
  make[2]: *** [run-linux-test] Error 1
  make: *** [run-tcg-tests-aarch64-linux-user] Error 2

As this seems due to a container limitation on Travis-CI,
simply skip the test there.

[*] https://travis-ci.org/github/qemu/qemu/jobs/710005078#L3706

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
RFC because per Laurent Vivier we are not using the correct libc
    while cross-linking the test (maybe change in the container
    packages?)
---
 tests/tcg/multiarch/linux-test.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/multiarch/linux-test.c b/tests/tcg/multiarch/linux-test.c
index 8a7c15cd31..c7dfdec9ec 100644
--- a/tests/tcg/multiarch/linux-test.c
+++ b/tests/tcg/multiarch/linux-test.c
@@ -233,8 +233,13 @@ static void test_time(void)
     ts.tv_sec = 0;
     ts.tv_nsec = 20 * 1000000;
     chk_error(nanosleep(&ts, &rem));
-    if (rem.tv_sec != 1)
+    if (rem.tv_sec != 1) {
+        if (getenv("TRAVIS_ARCH")) {
+            printf("nanosleep missing? skipping 'time' test\n");
+            return;
+        }
         error("nanosleep");
+    }
     chk_error(gettimeofday(&tv2, NULL));
     ti = tv2.tv_sec - tv.tv_sec;
     if (ti >= 2)
-- 
2.21.3


