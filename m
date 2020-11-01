Return-Path: <SRS0=Dm/C=EH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0689C2D0A3
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 21:58:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7B1622260
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 21:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uywipnOE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7B1622260
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZLMz-000864-PV
	for qemu-devel@archiver.kernel.org; Sun, 01 Nov 2020 16:58:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kZLMP-0007al-FK
 for qemu-devel@nongnu.org; Sun, 01 Nov 2020 16:58:01 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51550)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kZLMN-00041I-Ma
 for qemu-devel@nongnu.org; Sun, 01 Nov 2020 16:58:01 -0500
Received: by mail-wm1-x341.google.com with SMTP id v5so7616727wmh.1
 for <qemu-devel@nongnu.org>; Sun, 01 Nov 2020 13:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JIbIS5UYgadRW7dH7fGMNKuMnx0ji6qCG/NIkbv4yjE=;
 b=uywipnOEOB1tMpu+cUShzuNu1H0OOcxE8e3N+KbirTvaa2DG7w2u3Iu/Ka7REKMePX
 6L/SLrBSoM74ivj2+VMVVcGWisKasPQ9zwsWaIu0fRXYDSul+M4yDBr++WkA6vcujkkC
 Ce0U/JdpOvg2c5W4YYCScPYzZ3E/vJDbWFt23gzqZgaZvm0vzki4QrnFve4bd03v10Wr
 t+vWARgGdZosLnSkEOVrbJbw27FH0sjwd2uaCtrwQZNIAKo5JEob4SLQDDO7sKQejaDn
 H/evq1MLdxrYa29wdWQC92Eb/3xJVUs+joQQYHYwZWSl0Hl1AZiKCVdRSGb6ehMCpKy4
 h7sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=JIbIS5UYgadRW7dH7fGMNKuMnx0ji6qCG/NIkbv4yjE=;
 b=tv7cT4KfpjtRl6NJ4K8nrWWhgK5oW7mmgd9KpXmmtkrdBacDyfb2NwaSkbLJg4GQIk
 R4IWj42+QRAilIsCTk5js4NizmPRYxYg3qdvSqxOmf4JhsACzppMkUbTnaeA910LsnyX
 NufZf/mNPR+Pmk6WTRuxBMvYf+rv60wBK9jaLiUIrhzLOPh8YwrDNgXMzki0OmjeFJG1
 9+/ZS8uS6IrIZBwn6i9nZq9XntJlXJWliDxHcF4qrD6VD2X9ffFK9QEmR8cWKsMNYf4L
 nEmbG6JvyfvcXWcXdwtgrQmdcqM5EoojssgESQr/PjYxJeCvzGMwSWExgevllnyPbMT6
 EF3Q==
X-Gm-Message-State: AOAM533FMAmhtGAmJmdC5ignavo6XKI6YR4HR4ZbVbsvOMY7pQm8oadO
 lEj/pjnZSsij9unVblvkZCleX34Fm/E=
X-Google-Smtp-Source: ABdhPJy5YA0ljbIEnKc4nys9tn23GAM1xIhdjaG17N4q2izgLT4BTN7g9ID7+XuaNz7hyQoKrvdY1Q==
X-Received: by 2002:a1c:448:: with SMTP id 69mr3993668wme.12.1604267878037;
 Sun, 01 Nov 2020 13:57:58 -0800 (PST)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id f5sm12535167wmh.16.2020.11.01.13.57.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2020 13:57:57 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 v3] util/cutils: Fix Coverity array overrun in
 freq_to_str()
Date: Sun,  1 Nov 2020 22:57:55 +0100
Message-Id: <20201101215755.2021421-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Luc Michel <luc@lmichel.fr>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix Coverity CID 1435957:  Memory - illegal accesses (OVERRUN):

>>> Overrunning array "suffixes" of 7 8-byte elements at element
    index 7 (byte offset 63) using index "idx" (which evaluates to 7).

Note, the biggest input value freq_to_str() can accept is UINT64_MAX,
which is ~18.446 EHz, less than 1000 EHz.

Reported-by: Eduardo Habkost <ehabkost@redhat.com>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v3: Follow Peter's suggestion
---
 util/cutils.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/util/cutils.c b/util/cutils.c
index c395974fab4..2f869a843a5 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -891,10 +891,11 @@ char *freq_to_str(uint64_t freq_hz)
     double freq = freq_hz;
     size_t idx = 0;
 
-    while (freq >= 1000.0 && idx < ARRAY_SIZE(suffixes)) {
+    while (freq >= 1000.0) {
         freq /= 1000.0;
         idx++;
     }
+    assert(idx < ARRAY_SIZE(suffixes));
 
     return g_strdup_printf("%0.3g %sHz", freq, suffixes[idx]);
 }
-- 
2.26.2


