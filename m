Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC7A5C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 10:21:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D60C20708
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 10:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="seP3ffOW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D60C20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSHQV-0005Ak-4B
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 06:21:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52618)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSHMt-0001xS-HN
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 06:17:19 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34682)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSHMq-0001Yg-LW
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 06:17:19 -0400
Received: by mail-wr1-x441.google.com with SMTP id i1so17198872wro.1
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 03:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eaRuah3IQkCoghHDAmYYklRLXzqbVIln28FjMwcwuUc=;
 b=seP3ffOWsKgaDfOxDY8hpxbxy6J4xnE4Cu9FyKC2HJq5DSaU94q2MF8QWgxYQn/Ca/
 EoXI3GJy6UNKCRNA9xM6wpviVS93LByU1UNZqEiRBVAPHQAuNJHBXtX3vE8aV9sXdTmt
 JbvDZFqbQYwSkDVdgEKNuvDEaPA6RxMpC96I/wG3OqaW3zt2uRZduoABj6TXXmhFomgM
 WtJRYJV1zzispbfwiMvr3CNORC5R8dyN2rweeUxanwqGf+pj1KfF9h9dyFn95iDjsdOK
 wkvYnga4rw3Rxryp4xYyhA+8dojtRr/5jVWLRfaq4bzuG4MzAi8Y6gPm3Y58qQy72Xul
 IAog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=eaRuah3IQkCoghHDAmYYklRLXzqbVIln28FjMwcwuUc=;
 b=TEdIIu2T+bx9ane4SG+eYxnGaPbRVD92qEgOqJNXmdlr4NQmK+W5erYOQw4iEZXD0U
 Nyuv1sEyQMv4Yx8KD9FXPzBEcLkzm/U32zHbUt4gty2LLprmPkBpusmwSLQX9zNSnutB
 rwbGLWg1Ab0Pfx04a9eU5p2BCmgKw2hqkeSSEn152ODhTev7D6ElnZZF+ziDh86Gm/zu
 NWf42/VEpqmbY3AjXFoTz1Kc1Funud+zWHsdPGFKueYeuUl/9+4TWNipDCat2SHlHkvr
 xZ4YK49jC2hdVf0en2kPXSn3PAYCqdII2Xvb4eb4vdKXMeK4dls3nA3CP+7MahCImVhl
 PPzQ==
X-Gm-Message-State: AOAM530x01nVog54s5P4t0agg8l180X9RJV3Am7Wf01Lo6i7eI+Jaa7v
 0Tlbfo6mUESqOJbAk77sjhVp1Suy20g=
X-Google-Smtp-Source: ABdhPJwANdbbQxvjKsMIZyRQvlJgMreyzLHKuu+7BFACK6bL8KgZJIDDNcvlmZN3J+xB9t9zST8EcQ==
X-Received: by 2002:adf:c3c2:: with SMTP id d2mr35997308wrg.191.1602584235148; 
 Tue, 13 Oct 2020 03:17:15 -0700 (PDT)
Received: from x1w.redhat.com (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id x4sm2897603wrt.93.2020.10.13.03.17.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2020 03:17:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/4] MAINTAINERS: Downgrade MIPS Boston to 'Odd Fixes',
 fix Paul Burton mail
Date: Tue, 13 Oct 2020 12:16:58 +0200
Message-Id: <20201013101659.3557154-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201013101659.3557154-1-f4bug@amsat.org>
References: <20201013101659.3557154-1-f4bug@amsat.org>
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

Paul's Wavecomp email has been bouncing for months. He told us
he "no longer has access to modern MIPS CPUs or Boston hardware,
and wouldn't currently have time to spend on them if he did." [1]
but "perhaps that might change in the future." [2].
Be fair and downgrade the status of the Boston board to "Odd Fixes"
(has a maintainer but they don't have time to do much other).
Similarly to commit 2b107c2c1c (".mailmap: Update Paul Burton email
address"), update his email address here too.

[1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg718739.html
[1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg728605.html

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v2: Squashed email address change (Thomas Huth)
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2de5943e388..702f73823fc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1161,9 +1161,9 @@ S: Maintained
 F: hw/intc/loongson_liointc.c
 
 Boston
-M: Paul Burton <pburton@wavecomp.com>
+M: Paul Burton <paulburton@kernel.org>
 R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
-S: Maintained
+S: Odd Fixes
 F: hw/core/loader-fit.c
 F: hw/mips/boston.c
 F: hw/pci-host/xilinx-pcie.c
-- 
2.26.2


