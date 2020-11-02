Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF55C00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 15:26:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B60822258
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 15:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MRQfBfzt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B60822258
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZbj7-0004Io-GY
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 10:26:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52826)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZbhh-00031i-Ce
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 10:25:05 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33417)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZbha-0007za-Pm
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 10:25:04 -0500
Received: by mail-wr1-x442.google.com with SMTP id b8so15110172wrn.0
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 07:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=tOVjHBCUTdpVBGeIO9jNhl1R0X/cU6YKPF5ubl/f53w=;
 b=MRQfBfzts61X2h0olj0xATIoGOjvf2UUVUtcF9cwHL9M/910ZGabOhReW+a8jPG0Uu
 V0ORSBidldCTbp4nQy7fwzRS1HHIT8i/9oNkaVhGamqWNSqLJrijsUF+trAMlulPTkuv
 nsax5Q18vHVouIvKNS2ODrnZuucNy4DY7j2I231B3Is3ICjTJi57W3cXbFeKVqEKJlvm
 5RUd31bBNKWhKAMzqyjxdY2RoQsPuyl2d9l7zUdn2R+O1vjzseHKK2Ni87tymVUL3JW7
 0njtw4IbSqHbjHtAFjfQm3YyqWgVM7LKeUTUJlT1GMPQ6K9+EuvSceQWunx+QR7F7K2K
 paEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=tOVjHBCUTdpVBGeIO9jNhl1R0X/cU6YKPF5ubl/f53w=;
 b=So1dw8vW/PJycZpXrpil0UIFvBbzmSvjsKW/cZlBTNGf9l843pmUi5anBVCN/h6n2s
 iTSueBysm1/SwRnbgdoUiGumLvGvPoN1Nh/NW1XAui3aWtcZVmvW4dOQhaAOjJKn2uq4
 Hcx5q4wo1zRlgvHs9MAe3mc95IFEWG0J7JRwfQUJfwNKIJUlUu4FXOKNEi7U9m83LoPl
 0wY1xWfZZVIItJNyIoBSGacfFJBwI+dIywEFDStG/4xL0Bgqm7L7VYenyDcOIzbaCWMI
 2663h4W4ItR9oNTO588DUz0M0qIMB0we2erpTrnZQuINyob+RzaFbdNWo7J6+RCrWXKz
 OYyg==
X-Gm-Message-State: AOAM533cEg4xhEMKRoF4mWQZ0NWz0gXQGEn9ZozTmrvlp1IuzLSaSQfM
 cRREup0ReA1qb3Ord/tQitw+Jw==
X-Google-Smtp-Source: ABdhPJy3LgJUsGlTNj+jGimxaS7WOT77WIOX8Ho1YSDApvvpLU1enC5Z5gSPXQ0afboyH120y3qjPQ==
X-Received: by 2002:adf:bc0f:: with SMTP id s15mr21065035wrg.83.1604330696935; 
 Mon, 02 Nov 2020 07:24:56 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 9sm12907632wmk.5.2020.11.02.07.24.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 07:24:56 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] tests/qtest/npcm7xx_rng-test: Disable randomness tests
Date: Mon,  2 Nov 2020 15:24:54 +0000
Message-Id: <20201102152454.8287-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x442.google.com
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
Cc: Tyrone Ting <kfting@nuvoton.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Havard Skinnemoen <hskinnemoen@google.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The randomness tests in the NPCM7xx RNG test fail intermittently
but fairly frequently. On my machine running the test in a loop:
 while QTEST_QEMU_BINARY=./qemu-system-aarch64 ./tests/qtest/npcm7xx_rng-test; do true; done

will fail in less than a minute with an error like:
ERROR:../../tests/qtest/npcm7xx_rng-test.c:256:test_first_byte_runs:
assertion failed (calc_runs_p(buf.l, sizeof(buf) * BITS_PER_BYTE) > 0.01): (0.00286205989 > 0.01)

(Failures have been observed on all 4 of the randomness tests,
not just first_byte_runs.)

It's not clear why these tests are failing like this, but intermittent
failures make CI and merge testing awkward, so disable running them
unless a developer specifically sets QEMU_TEST_FLAKY_RNG_TESTS when
running the test suite, until we work out the cause.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/npcm7xx_rng-test.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tests/qtest/npcm7xx_rng-test.c b/tests/qtest/npcm7xx_rng-test.c
index da6e639bf6f..e7cde85fbbc 100644
--- a/tests/qtest/npcm7xx_rng-test.c
+++ b/tests/qtest/npcm7xx_rng-test.c
@@ -265,10 +265,16 @@ int main(int argc, char **argv)
 
     qtest_add_func("npcm7xx_rng/enable_disable", test_enable_disable);
     qtest_add_func("npcm7xx_rng/rosel", test_rosel);
-    qtest_add_func("npcm7xx_rng/continuous/monobit", test_continuous_monobit);
-    qtest_add_func("npcm7xx_rng/continuous/runs", test_continuous_runs);
-    qtest_add_func("npcm7xx_rng/first_byte/monobit", test_first_byte_monobit);
-    qtest_add_func("npcm7xx_rng/first_byte/runs", test_first_byte_runs);
+    /*
+     * These tests fail intermittently; only run them on explicit
+     * request until we figure out why.
+     */
+    if (getenv("QEMU_TEST_FLAKY_RNG_TESTS")) {
+        qtest_add_func("npcm7xx_rng/continuous/monobit", test_continuous_monobit);
+        qtest_add_func("npcm7xx_rng/continuous/runs", test_continuous_runs);
+        qtest_add_func("npcm7xx_rng/first_byte/monobit", test_first_byte_monobit);
+        qtest_add_func("npcm7xx_rng/first_byte/runs", test_first_byte_runs);
+    }
 
     qtest_start("-machine npcm750-evb");
     ret = g_test_run();
-- 
2.20.1


