Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC99EC00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 17:20:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 768E620691
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 17:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wr99HUI9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 768E620691
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZdUt-00062Z-GJ
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 12:19:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54130)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZdM4-0001L8-07
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 12:10:52 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:54459)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZdM2-0006dr-2w
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 12:10:51 -0500
Received: by mail-wm1-x341.google.com with SMTP id d142so1522594wmd.4
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 09:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=BTFTRZ0y4CNDARID0tRYWHO8z4mtsdjFARUw5VYJhGg=;
 b=Wr99HUI91YBmxhaZD/2EX1ZtWaK14Lx6lwbNAH6F/B+18ezvp8m1PsDHFf48Gj7PKm
 1FrI3fHb6KYGZtNZj/xd6me8Ak6A1IoHDSh9eVp11yXLmKKVMFsiTutyJQhdYNkAnxKk
 BPNZud1MErGwm34Ak99ov5qmYgP8UOsIR/TF2gn5HijXlvsgPf8ilOTvtTqz5Yi8MdeS
 rDnPwA/tEER5qdGisz43oDitU2zeC2HBliA+Zf1+1fckV9F8ZrBC/i/SLCLjDE50xrsH
 NrKH5/RrGFmE5t1Hc5gmkHCTO4g9+NkQzi3O9zMLmdxRBrnlcfpi4TrRGzK75ZyrV2yd
 THpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BTFTRZ0y4CNDARID0tRYWHO8z4mtsdjFARUw5VYJhGg=;
 b=F/V6Hy7rWuijNj85Q0h7bA35/O5Ig6INCprrZZZjrYSpSbFbaM7BqcODZQzJVeM1vT
 DCJOCpQ6eac0PubdAyuRom/OSnKsgo9YeDPfbDMJVECF9Cs2CHJdxPN50gn36F7iOXJo
 t/KDtwPfXdXrj0Sd2eTnueMiq4gSuRm4+NzIc+xF8FfYvYHSNX8946y3Bb5eW/MRg9qh
 nK73G2puvqDdEE6uDaA2znxhi8Ap8gWTYUZz7KYadVhdrVCWmTG4wda5/Z4+AtWJ8Mez
 RheNottEu45tbl5xMJMIouYCxqA+aoVcb7n2fTlY93pl9/SsRoqZadxm+HnAdiJGx01S
 ODPQ==
X-Gm-Message-State: AOAM531TZZ6A+HCKf66HSX30CoAGfvksr+3lJ+F5+wpo8dttE+bAi65V
 4nDjKqGOrkeEV0C/2vXRAupBkjC8TZ7m7Q==
X-Google-Smtp-Source: ABdhPJyWGJyeQbLvIk2MgCpuXLsRJ8sw2weGSvfCAbWSffG8bsF+cNtw9DbGvFT6l3AWeqVQn/IJsQ==
X-Received: by 2002:a7b:c858:: with SMTP id c24mr18798186wml.176.1604337048338; 
 Mon, 02 Nov 2020 09:10:48 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c18sm22396540wrt.10.2020.11.02.09.10.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 09:10:47 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/26] tests/qtest/npcm7xx_rng-test: Disable randomness tests
Date: Mon,  2 Nov 2020 17:10:05 +0000
Message-Id: <20201102171005.30690-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201102171005.30690-1-peter.maydell@linaro.org>
References: <20201102171005.30690-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x341.google.com
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20201102152454.8287-1-peter.maydell@linaro.org
Reviewed-by: Havard Skinnemoen <hskinnemoen@google.com>
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


