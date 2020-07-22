Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86FE0C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 06:36:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AA5E20787
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 06:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="djW38PXf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AA5E20787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jy8Mv-0001j8-Je
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 02:36:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41412)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jy8Fn-0007Vm-Qt
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 02:29:23 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:41131)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jy8Fm-0006wB-3n
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 02:29:23 -0400
Received: by mail-wr1-x442.google.com with SMTP id z15so694852wrl.8
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 23:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=R6W72fqt6nZhVleVWEEALghgISIRTfZPOqJF2eNqmeg=;
 b=djW38PXfbv4y5Pi/E/iIqcdlGNZBd61zyjKfvdfLkjS6oWNidlQjl+KNL0Y7GJjIgJ
 a1AVzJHUyv6MwBgLWgmOITMVPGk62xNuVjNEckZ06cxI9x/RzU+HDOAI+mmxCIGEzW69
 jSDON5w2S3fSg0pfwmxYBjOQbg/DQuwIdakTUAyhutRxkQB8PCpPo7YsoqG94XPtpJ4K
 02WeKyVzOa7tzHpx0aF2UQ1L4J2QICUkVxjniNfnWKiBVqZTOZ5Ckco0sd+nfMK8onaA
 IIQ7SInSIxEj2RWumB0m4VPSFH9g7XhmNb74P8Osf0WMVf89JmYbSch/uW2Hnhock60j
 NEXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=R6W72fqt6nZhVleVWEEALghgISIRTfZPOqJF2eNqmeg=;
 b=X0kGfDqPUhQkoOyLjWxFxC2mzx87fJGVGinyg/rzf47qGDP7JZ1oU6eOSj/WK0bqmr
 ap2UP0kZILCHbpN/+ZfDWzPoPXln5Bd+BWYiyaGWvow+DEYd497yfYOuy3Y7Y+r+q/ht
 g+CvlonXqSqmS3ZFxv98/QYq4eCAiBLL52O1q+uqg7uiEShl3aU21+rbvna69Ps5MGEM
 cfIQQ3MBw7EoF7gjm7w0sntNk4PgKEm/SXOQ9Extrjb+i81B9U93dQ3qTiBVQuI7mgKb
 XGpqdOSz5YTQTJKIwDBsFKqnGUjVc+WupbBq2PpM9+u9s21+mlcZVX0b/8Z5fJLIwqay
 Pt5w==
X-Gm-Message-State: AOAM530zVQ8+iFVYvsnAnIu/XATahlpY9xROWtl1elKxcJoz5eZyhja1
 0kemPPev5Hm5p7CURHQNH82jAhz2gG0=
X-Google-Smtp-Source: ABdhPJyAwMi2CGgO08mtkeA5VcxXdxeqMG40u5ly0UsGfJwoQyVXHpU7AEfpCR00bzO1w4wdFYnR5A==
X-Received: by 2002:adf:f0ce:: with SMTP id x14mr28337613wro.137.1595399360719; 
 Tue, 21 Jul 2020 23:29:20 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h14sm39361088wrt.36.2020.07.21.23.29.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2020 23:29:13 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 215F01FF9B;
 Wed, 22 Jul 2020 07:29:04 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 12/12] linux-user: fix clock_nanosleep()
Date: Wed, 22 Jul 2020 07:29:02 +0100
Message-Id: <20200722062902.24509-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200722062902.24509-1-alex.bennee@linaro.org>
References: <20200722062902.24509-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
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
Cc: fam@euphon.net, berrange@redhat.com, richard.henderson@linaro.org,
 f4bug@amsat.org, Laurent Vivier <laurent@vivier.eu>, cota@braap.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Laurent Vivier <laurent@vivier.eu>

If clock_nanosleep() encounters an error, it returns one of the positive
error number.

If the call is interrupted by a signal handler, it fails with error EINTR
and if "remain" is not NULL and "flags" is not TIMER_ABSTIME, it returns
the remaining unslept time in "remain".

Update linux-user to not overwrite the "remain" structure if there is no
error.

Found with "make check-tcg", linux-test fails on nanosleep test:

  TEST    linux-test on x86_64
.../tests/tcg/multiarch/linux-test.c:242: nanosleep
make[2]: *** [../Makefile.target:153: run-linux-test] Error 1
make[1]: *** [.../tests/tcg/Makefile.qemu:76: run-guest-tests] Error 2
make: *** [.../tests/Makefile.include:857: run-tcg-tests-x86_64-linux-user] Error 2

Reported-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200721201754.2731479-1-laurent@vivier.eu>
---
 linux-user/syscall.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 1211e759c26..caa7cd3cab9 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -11829,10 +11829,19 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     {
         struct timespec ts;
         target_to_host_timespec(&ts, arg3);
-        ret = get_errno(safe_clock_nanosleep(arg1, arg2,
-                                             &ts, arg4 ? &ts : NULL));
-        if (arg4)
+        /*
+         * clock_nanosleep() returns 0 or one of the *positive* error number.
+         */
+        ret = host_to_target_errno(safe_clock_nanosleep(arg1, arg2, &ts,
+                                                        arg4 ? &ts : NULL));
+        /*
+         * if the call is interrupted by a signal handler, it fails
+         * with error TARGET_EINTR and if arg4 is not NULL and arg2 is not
+         * TIMER_ABSTIME, it returns the remaining unslept time in arg4.
+         */
+        if (ret == TARGET_EINTR && arg4 && arg2 != TIMER_ABSTIME) {
             host_to_target_timespec(arg4, &ts);
+        }
 
 #if defined(TARGET_PPC)
         /* clock_nanosleep is odd in that it returns positive errno values.
-- 
2.20.1


