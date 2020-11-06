Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA987C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 17:59:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3815206FA
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 17:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jn1+LWea"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3815206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb60t-0001PY-JT
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 12:59:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48220)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kb60L-0000x7-6N
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 12:58:29 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43630)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kb60J-0001UH-FS
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 12:58:28 -0500
Received: by mail-wr1-x444.google.com with SMTP id g12so2201903wrp.10
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2020 09:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=nI/5gcnCT3HsTfKHFyeC112QzZCXDG18lh1rraNrqw0=;
 b=jn1+LWeaZC+q2WWd+6elW+vJkNbRf5GYnfpWpbpMGSV6YwNG0Wv27wcI/EogKtn78C
 C5YnwbRlNs00wbYwDjhal9o1RSKQgg50t2p+zx/5rv6TUQ/ifm2q18M9Z9Sl60/eoyo5
 sUbpIpGhDWO9l+L3mjr0+fPT10HX+KU7183JUqhvFPuMz5IHkHVp7uJ2jSZW/GSBWWSO
 nDJ6aEVIR3z77fVPYivLsO+qoHhsl1XU2Bn9GP0KpT2vg/xj9/wyi9Q2zvF3nhRNlxsY
 LnY888o76ggkXqNesUNN2s9dc8qSV3SE8XRSuTil2go9NbvtN6Bn080yxKHvm1yjCr1w
 W68w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=nI/5gcnCT3HsTfKHFyeC112QzZCXDG18lh1rraNrqw0=;
 b=A2vnribIcFWPQOKlu60o+T1+AqSC600qT26CUNcBJd3u2wAOsnjFUjAT2IaLuCGI/9
 mvxT4sq9tVNpjImYILOV5JksUH3KVJx1JKzkZthKxLTvf7H+5V3UPnCQmAL9tyyEA9c2
 2t/mc0alWgatW/ofemh4EEjMm3QtvHPA2/Qrc4Lp8RYnFfq1SeajWWzq0I1L4p9gkQFL
 icCxN7oSd15c1RNoKZ+2p/VOEt08/K+P0taPuh+/TcmG3Vm9+kLIKQbwKwQQo/OzF9RI
 2mj011Ujn2rL/K7PGhBkPpFIFZshhozmABwbbX2exf5ausbMht/AxJiQQYs1FTNhqyer
 ZLew==
X-Gm-Message-State: AOAM530IiCZ6IG4HS8qDRi9IZJ0/WBW8L0DqyQdFaHsA4fWVfqBU2J38
 o4CJQ4oxUrF+O+92G11pblcXZivqSGxUSA==
X-Google-Smtp-Source: ABdhPJw3Qx+3BlkcyvTaeKq3xiScfC5Q2Hccu+Dm78tFttwLKzkpIL5Eq0JoQEly7ymLsGIGXQtaxw==
X-Received: by 2002:a5d:694b:: with SMTP id r11mr4036192wrw.104.1604685505525; 
 Fri, 06 Nov 2020 09:58:25 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id l3sm4309731wmg.32.2020.11.06.09.58.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2020 09:58:24 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.2] hw/mips/boston.c: Fix memory leak in
 boston_fdt_filter() error-handling paths
Date: Fri,  6 Nov 2020 17:58:23 +0000
Message-Id: <20201106175823.1650-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x444.google.com
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Paul Burton <paulburton@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Coverity points out that the error-handling paths in the
boston_fdt_filter() function don't free the fdt that was allocated.
Fix the leak by using g_autofree.

Fixes: Coverity CID 1432275

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/mips/boston.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index 3356d7a6814..3d40867dc4c 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -349,11 +349,9 @@ static const void *boston_fdt_filter(void *opaque, const void *fdt_orig,
     MachineState *machine = s->mach;
     const char *cmdline;
     int err;
-    void *fdt;
-    size_t fdt_sz, ram_low_sz, ram_high_sz;
-
-    fdt_sz = fdt_totalsize(fdt_orig) * 2;
-    fdt = g_malloc0(fdt_sz);
+    size_t ram_low_sz, ram_high_sz;
+    size_t fdt_sz = fdt_totalsize(fdt_orig) * 2;
+    g_autofree void *fdt = g_malloc0(fdt_sz);
 
     err = fdt_open_into(fdt_orig, fdt, fdt_sz);
     if (err) {
@@ -380,7 +378,7 @@ static const void *boston_fdt_filter(void *opaque, const void *fdt_orig,
 
     s->fdt_base = *load_addr;
 
-    return fdt;
+    return g_steal_pointer(&fdt);
 }
 
 static const void *boston_kernel_filter(void *opaque, const void *kernel,
-- 
2.20.1


