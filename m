Return-Path: <SRS0=Dm/C=EH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4168C2D0A3
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 21:55:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6C902074F
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 21:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vZFioILR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6C902074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZLJp-0006Qq-AF
	for qemu-devel@archiver.kernel.org; Sun, 01 Nov 2020 16:55:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44276)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kZLIk-0005y6-Ol
 for qemu-devel@nongnu.org; Sun, 01 Nov 2020 16:54:14 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:35851)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kZLIj-0003a7-7m
 for qemu-devel@nongnu.org; Sun, 01 Nov 2020 16:54:14 -0500
Received: by mail-wr1-x441.google.com with SMTP id x7so12390568wrl.3
 for <qemu-devel@nongnu.org>; Sun, 01 Nov 2020 13:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wU0CMsjyneTK6Sroi2xvnUlYFM1FI2/0Ny5mpCCsVCo=;
 b=vZFioILRZmZe+X/Lt/Nrxc2HoCNY0FJVaNEbq7uc6OAORgtjDU1/O80HRJMGDVBm4R
 Uj/Rs64tq++1tyIV+9W/bkeBMTrcxpaLEa2nELGF06KwN1gwgODb7/dpgFYVrcoAtH5n
 +gwW10P7PvNRbu3sFP3dnJSbTUtSeJEA0vYfV5cBFKDnl4aJ/kMmBQLcMgh5dxXmlreD
 ZqIizTq6mbpmMcArhQG5v7STLrxO27VfvZbO+709qdBOvrXMLy1cFl/KTpi7z8AF3ltW
 0YfGDtwi7UtxRd8ujrpKPJBIA+nfBtHHN/E41asEmd14dgG4qs0pE4muesUBDZbh8HEQ
 cH7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=wU0CMsjyneTK6Sroi2xvnUlYFM1FI2/0Ny5mpCCsVCo=;
 b=WRgnc4JimD6nStL7WSddbujALfr3Tm8zR7fsvBiKa9TKCMkVAq+g/uc9tIGAPb+kB3
 piiZ9UEDSTpqE3d29AE1YQgon4QT2p62hB/8NaJIzayz7fmt8A8M7ZZHmxv1iXV/9cKC
 0aYnkrIU56qxP7kP/RyzbXBlkRmSP/KKJEJwMzbJF5Sgi+QSedSwLnxEZs15HGufcbNo
 GoMVXo+qbb5oNaTPgojS3LYMNJseX9xZTH9SIRaHP3DoKEZkhKjkvr/hT8Hak0s9T2jC
 uXdjap/6LkjfD1bWXQMOEeqrPmlRDESnLmbptDSeCXJdydBrJvMyry8KmRfeMaLm5ehE
 yj+g==
X-Gm-Message-State: AOAM530jW7Q+e9dcJZulb5zrFFaP2l5OhLWDIyAISKtx0mfwN7lj0AOz
 89DdBdF4UUcFNIzAsBGZMz4YoG3/NWU=
X-Google-Smtp-Source: ABdhPJy2Km+Cs5SxTE4VaLEqxVoAFA9tFmS/BL2zWUQZY6Ezus3JySlr00HK1OgHq3diSHvvJXj/dw==
X-Received: by 2002:a5d:6110:: with SMTP id v16mr17712087wrt.219.1604267650876; 
 Sun, 01 Nov 2020 13:54:10 -0800 (PST)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id m12sm12595997wmi.33.2020.11.01.13.54.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2020 13:54:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 v2] util/cutils: Fix Coverity array overrun in
 freq_to_str()
Date: Sun,  1 Nov 2020 22:54:08 +0100
Message-Id: <20201101215408.2019266-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
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

Rewrite the iteration to avoid an array overrun. This fixes
CID 1435957:  Memory - illegal accesses (OVERRUN):

>>> Overrunning array "suffixes" of 7 8-byte elements at element
    index 7 (byte offset 63) using index "idx" (which evaluates to 7).

Note, the biggest input value freq_to_str() can accept is UINT64_MAX,
which is ~18.446 EHz, less than 1000 EHz.

Reported-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Supersedes: <20201029185506.1241912-1-f4bug@amsat.org>
---
 util/cutils.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/util/cutils.c b/util/cutils.c
index c395974fab4..723051da6e8 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -889,11 +889,13 @@ char *freq_to_str(uint64_t freq_hz)
 {
     static const char *const suffixes[] = { "", "K", "M", "G", "T", "P", "E" };
     double freq = freq_hz;
-    size_t idx = 0;
+    size_t idx;
 
-    while (freq >= 1000.0 && idx < ARRAY_SIZE(suffixes)) {
+    for (idx = 0; idx < ARRAY_SIZE(suffixes) - 1; idx++) {
+        if (freq < 1000.0) {
+            break;
+        }
         freq /= 1000.0;
-        idx++;
     }
 
     return g_strdup_printf("%0.3g %sHz", freq, suffixes[idx]);
-- 
2.26.2


