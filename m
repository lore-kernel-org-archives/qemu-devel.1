Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A86C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 02:26:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 036D4206F6
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 02:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sZo/Skvm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 036D4206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsdJm-0004ph-7s
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 22:26:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56862)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jsdIs-000416-4X; Mon, 06 Jul 2020 22:25:50 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46645)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jsdIq-0008PS-EH; Mon, 06 Jul 2020 22:25:49 -0400
Received: by mail-wr1-x444.google.com with SMTP id r12so43417466wrj.13;
 Mon, 06 Jul 2020 19:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jTeawrZUjrBNs/9CdT5w4j7vQBKK0EvCVYq0F/wq2xM=;
 b=sZo/Skvm3V7/8ya72da5n2LZ4wI1KEWLbQ7Oiu2e7WohY/j2bC5d7MyayCeANKhIpX
 3j23YbBZdfezumYlFy4ZXIE/nm/uMMhZD/BZHgxurLdzYPksS5azsxeKFTaZJU1TT6z8
 HF+IkooROmUya2QrD1Vu+MD7dliTP6DyM/nK00SXPo4bSAerYGqUHTo5a0hyRH/U1Oza
 pZZp61TTHHyQXoQMbEOZiMwKNk14+3iZXo9pfQTmxF+O9HSvRq5n5Ppab+E7DE58doTE
 psfTptxfYLaqs4GjCE9HLHdHloS4dUw8g4CIVTqOtaKTkK5K4Po1Yy+gwvz4n2y3pG2P
 Y3sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=jTeawrZUjrBNs/9CdT5w4j7vQBKK0EvCVYq0F/wq2xM=;
 b=Mrm9wgjsVNY21RbuLOhLKZQMFQV+OSEWty3gsDVo+oPXpw/U7VFfW+nmBt/bbNM8Ey
 FBRZv6SvTH+GoAucRHlOX2rshW7LWoitp+Or0h0fgBq3Lp3gxB2PPl9krY3xZJrmoqVW
 1lmEIesx1KXz3mOmk5qJ3p0Sjl4Anv6C5uWhlh3MFeayp4lxbBM07FZJA8G6oPslEA8/
 Ua3p9k5Fxf8miXzpe9Bs36MIOIXSLsnKKlovSaJmov/NlLFE33l+tM6ipQ6hZPITaqyo
 WWVRGsfRmzqGL0giplgT7ZWdWbRuifpttCIr+z75cV4T5tiacLbfQwHNluEghLJIc1mK
 KtzQ==
X-Gm-Message-State: AOAM533OvPJmQpkwSajH+XqUN8/1m/6XNnUk3zkH0KyIuHlENYczIaTk
 FXXImyBqjQQ6B3PpCnoe7/Lpzf5n
X-Google-Smtp-Source: ABdhPJz17DoUOgInIH6wSKxwmQq3MFw3V0wsZFOvTuTUY6cfIVDtly6c87NDV1734pOGaxdYUDx0Ug==
X-Received: by 2002:adf:ea4f:: with SMTP id j15mr17659750wrn.253.1594088746382; 
 Mon, 06 Jul 2020 19:25:46 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id z6sm1425021wmf.33.2020.07.06.19.25.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2020 19:25:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] .mailmap: Update Paul Burton email address
Date: Tue,  7 Jul 2020 04:25:44 +0200
Message-Id: <20200707022544.24925-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Paul Burton <paulburton@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Following the Linux kernel equivalent patch posted on
linux-mips@vger.kernel.org [*], update Paul Burton email
address to avoid emails bouncing.

[*] 'MAINTAINERS: Use @kernel.org address for Paul Burton'
https://lore.kernel.org/patchwork/patch/1140341/

Cc: Paul Burton <paulburton@kernel.org>
Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .mailmap | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/.mailmap b/.mailmap
index 926cac6bb8..fe4c561338 100644
--- a/.mailmap
+++ b/.mailmap
@@ -49,9 +49,10 @@ Filip Bozuta <filip.bozuta@syrmia.com> <filip.bozuta@rt-rk.com.com>
 Frederic Konrad <konrad@adacore.com> <fred.konrad@greensocs.com>
 James Hogan <jhogan@kernel.org> <james.hogan@imgtec.com>
 Leif Lindholm <leif@nuviainc.com> <leif.lindholm@linaro.org>
-Paul Burton <pburton@wavecomp.com> <paul.burton@mips.com>
-Paul Burton <pburton@wavecomp.com> <paul.burton@imgtec.com>
-Paul Burton <pburton@wavecomp.com> <paul@archlinuxmips.org>
+Paul Burton <paulburton@kernel.org> <paul.burton@mips.com>
+Paul Burton <paulburton@kernel.org> <paul.burton@imgtec.com>
+Paul Burton <paulburton@kernel.org> <paul@archlinuxmips.org>
+Paul Burton <paulburton@kernel.org> <pburton@wavecomp.com>
 Philippe Mathieu-Daudé <philmd@redhat.com> <f4bug@amsat.org>
 Stefan Brankovic <stefan.brankovic@syrmia.com> <stefan.brankovic@rt-rk.com.com>
 Yongbok Kim <yongbok.kim@mips.com> <yongbok.kim@imgtec.com>
-- 
2.21.3


