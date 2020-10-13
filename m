Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60087C43457
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 10:20:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA06D20708
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 10:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUiJHH9l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA06D20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSHQH-0004mJ-Kb
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 06:20:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52516)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSHMi-0001ql-R1
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 06:17:08 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:52695)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSHMh-0001Xk-Dc
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 06:17:08 -0400
Received: by mail-wm1-x341.google.com with SMTP id e23so13365440wme.2
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 03:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ED9ctdoCK+AGBSvVR1uFGDxKqs1IT3566nbTYT2S4dU=;
 b=gUiJHH9lCnv092JZG1q+DiVMGUUI/yBceAi5fdFwl5AK5nslCepiV5eWId59Z5Qj7j
 V1RDY3gJfGfgDzOlYyq6+LkNz5MWRmnq7lBEPZjy77hQWc4Aecpl9rqUKEjuyq6rJNF5
 4JJmCOu/epPASgU1Gt8G3e8+XKdCZHi4KRFxWIWhNKtr9p7vLND9H9SsWSNc5ip5ob+A
 xFgfXcljMQ/zvVu2Bv2DcwcSwY6T/tEAJhnGV+eBh01Q48ID19fB24cgSV4cR0t0iwMc
 TRQM+Z8C7Ajb7rIfx7NFn4i4oGRJIboUUVuctmyyXx1bhyLKkTSdZ3U3tJJ0PBkY1xjN
 fCbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=ED9ctdoCK+AGBSvVR1uFGDxKqs1IT3566nbTYT2S4dU=;
 b=G7hTMbMQuQTixuNiG95uqypilgyrPWN7yV2L2YDsf+deVwqWor8ikM1581P7crvhH7
 voKcFRC6JUZr1c/fuTk0wqxdgIZscBjKPH8Gf3cuDHqxo+7PmvA3YFCzl/8iEHKOs5+e
 ePWgkFgaTX7yG86v5Zf0wsMwub59cLU/Zug+A9HJOyg2+GMqU1jQKdsMjRc5+jri6f8A
 vy7dm4mwl2+K6LHAsMFf36tSPDHZY2zefr+H434XnAOQe3m09jKpQtGlaF4v0lJEfgI9
 teAtNTReOms59vhbaia3jO9grc6ramIY4KE5uyRBZ/8IQCSsyc/U7vOIk3J+Z6IFQT8c
 0WNg==
X-Gm-Message-State: AOAM531VsVEy+Yeox16SJZdWwm8WclrZ/aIFVlsByv3wZLzQRc2fe2fl
 tc856oqTotdX37l2pxpMsCMTVRe3JaE=
X-Google-Smtp-Source: ABdhPJyvcVBc37GInC53OaSiZxCn/ySPIw8QyFGRg3EXVpt7Rvj0FcfEG8NpZISGCRRFhQoJrdmAtw==
X-Received: by 2002:a1c:7708:: with SMTP id t8mr14554874wmi.6.1602584225769;
 Tue, 13 Oct 2020 03:17:05 -0700 (PDT)
Received: from x1w.redhat.com (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id 4sm29499353wrn.48.2020.10.13.03.17.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2020 03:17:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/4] MAINTAINERS: Put myself forward for MIPS target
Date: Tue, 13 Oct 2020 12:16:56 +0200
Message-Id: <20201013101659.3557154-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201013101659.3557154-1-f4bug@amsat.org>
References: <20201013101659.3557154-1-f4bug@amsat.org>
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
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
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
Cc: Chen Huacai <zltjiangshi@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To avoid the MIPS target being orphan, volunteer to keep an eye
on it and put together pull requests.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 MAINTAINERS | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 426f52c1f63..d59e5c05c10 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -221,10 +221,11 @@ F: hw/microblaze/
 F: disas/microblaze.c
 
 MIPS TCG CPUs
+M: Philippe Mathieu-Daudé <f4bug@amsat.org>
 R: Aurelien Jarno <aurelien@aurel32.net>
 R: Jiaxun Yang <jiaxun.yang@flygoat.com>
 R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
-S: Orphaned
+S: Odd Fixes
 F: target/mips/
 F: default-configs/*mips*
 F: disas/*mips*
@@ -2815,11 +2816,12 @@ F: tcg/i386/
 F: disas/i386.c
 
 MIPS TCG target
+M: Philippe Mathieu-Daudé <f4bug@amsat.org>
 R: Aurelien Jarno <aurelien@aurel32.net>
 R: Huacai Chen <chenhc@lemote.com>
 R: Jiaxun Yang <jiaxun.yang@flygoat.com>
 R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
-S: Orphaned
+S: Odd Fixes
 F: tcg/mips/
 
 PPC TCG target
-- 
2.26.2


