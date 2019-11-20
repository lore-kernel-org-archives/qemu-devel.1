Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8596EC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 11:03:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EF7B2230F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 11:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZEvSkosH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EF7B2230F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXNld-0003JN-Cd
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 06:03:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34192)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iXNga-00070O-LC
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 05:58:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iXNgZ-00072B-9d
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 05:58:12 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:38598)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iXNgY-0006zw-Sp
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 05:58:11 -0500
Received: by mail-wr1-x431.google.com with SMTP id i12so27602461wro.5
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 02:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NY5Huuw32tJm6WEnS0WeU/lG0oOqGgFOecOoWzPIhZo=;
 b=ZEvSkosHC7vUHeaLNNN7RqZlililn2T3fnn78bfdiNfg2sW3OVdvY2T9wf8mDBDtHg
 JiKgyN0RyCJSYgpDcqxA/XZ/FUJFPlpKLVJmtJGoIm0IF4VWGGmZMxLT8wG8r/IuysEN
 kYrc0of9n/3lPNM0Y65PKarqJLnOHu0srpikaLWSlFy3dBHJY01iyLtOntpbdrcrYrpL
 bixs5MaNhl4heP89N41Ak5foapD8Jc515jA+m0SvDa2ZdEpnEIRBRGT9vKwn8nQhV8n5
 i23DhON90gbGMYVKZMs1M3zWb74xkxlcoz4WXGEO3g/e0yQIVquGDIrGJOgNDgkzHsk2
 UfPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NY5Huuw32tJm6WEnS0WeU/lG0oOqGgFOecOoWzPIhZo=;
 b=s6SCTve6o6DvNuJDbDwUKL+t4D+A1m9r1+2puQ3oau7thKC7ROWhWx7XiouKP2BnS6
 X0H3qxJN+OAAQtI5PYwYNprFhAJIQ/57vkF6rdvRmpjAvOUaI4WWXefrSLC6QE7hhESo
 U91jfrwsoL83oaT/dWvL9+AGhGsHcwQ7MRGAqnfHZ9yNi7wWQL1nZRe4P2xHVuaEAL3q
 yVgwrogrwY7csCFwSp05WHzkR0CHC/AK9OPH+OcCbFlaAa+J4IDqrgQmWC8WnCRDZk8i
 XrwqBoxoGqM9X2v+zijyhm9FOi81RAd6BPgmpXh5XlUXWTf7WpJxC8i4pl9Bau47mlT0
 YWXQ==
X-Gm-Message-State: APjAAAVOIgYRsMKH0NDo4a/gtsL9mFFOOCfqbNVfCFPfamFLIf/oA/n5
 Q+91gN5m3ziU33tVNoivm5nx8Q==
X-Google-Smtp-Source: APXvYqxnv/2FgHZt7VA/2JAtfQXJKzJKtd47ErMD70FSydoD6//nmKlDE1JITg/rhnEjo8j0Xy82Kw==
X-Received: by 2002:a5d:6789:: with SMTP id v9mr2428093wru.344.1574247489614; 
 Wed, 20 Nov 2019 02:58:09 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l4sm6198890wml.33.2019.11.20.02.58.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2019 02:58:07 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id AE5021FF92;
 Wed, 20 Nov 2019 10:58:01 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 5/5] tests/tcg: modify multiarch tests to work with clang
Date: Wed, 20 Nov 2019 10:58:01 +0000
Message-Id: <20191120105801.2735-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191120105801.2735-1-alex.bennee@linaro.org>
References: <20191120105801.2735-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::431
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
 Taylor Simpson <tsimpson@quicinc.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Taylor Simpson <tsimpson@quicinc.com>

Signed-off-by: Taylor Simpson <tsimpson@quicinc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1574032465-12186-1-git-send-email-tsimpson@quicinc.com>
[AJB: tweak header line]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/multiarch/float_helpers.c b/tests/tcg/multiarch/float_helpers.c
index 8ee7903c785..bc530e5732d 100644
--- a/tests/tcg/multiarch/float_helpers.c
+++ b/tests/tcg/multiarch/float_helpers.c
@@ -79,11 +79,9 @@ char *fmt_16(uint16_t num)
 
 #ifndef SNANF
 /* Signaling NaN macros, if supported.  */
-# if __GNUC_PREREQ(3, 3)
 #  define SNANF (__builtin_nansf (""))
 #  define SNAN (__builtin_nans (""))
 #  define SNANL (__builtin_nansl (""))
-# endif
 #endif
 
 static float f32_numbers[] = {
diff --git a/tests/tcg/multiarch/linux-test.c b/tests/tcg/multiarch/linux-test.c
index 673d7c8a1c2..8a7c15cd312 100644
--- a/tests/tcg/multiarch/linux-test.c
+++ b/tests/tcg/multiarch/linux-test.c
@@ -485,7 +485,11 @@ static void test_signal(void)
     act.sa_flags = SA_SIGINFO;
     chk_error(sigaction(SIGSEGV, &act, NULL));
     if (setjmp(jmp_env) == 0) {
-        *(uint8_t *)0 = 0;
+        /*
+         * clang requires volatile or it will turn this into a
+         * call to abort() instead of forcing a SIGSEGV.
+         */
+        *(volatile uint8_t *)0 = 0;
     }
 
     act.sa_handler = SIG_DFL;
-- 
2.20.1


