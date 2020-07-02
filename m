Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4307C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 13:48:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F413207D4
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 13:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KkSAd3Fe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F413207D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqzZo-0002P8-Rc
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 09:48:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38464)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqzP0-0001iR-CV
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 09:37:22 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:37874)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqzOy-0004J5-Ea
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 09:37:22 -0400
Received: by mail-wm1-x344.google.com with SMTP id o2so27994064wmh.2
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2020 06:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9vFSSsaVq2Fwgo9NyRjo6NBdMt3DH9lnuPKcUS1H1FU=;
 b=KkSAd3FeIssL4fIV4bS8h1ztnGQnJRsEQdsvkaiWfnrdjlRCe8g4xgxY+1h/I0GgxN
 4jw2SMBzjn3SanXveod1tbvlRnuPDJ+TXkLItNizcXjc5EuYraecLJGrPuNktNt+Vjrw
 Mx4WSZpKIwqnRIwBdwhXJQyQM2aYw39IxTb0P4Z+itoJLJ8ICy25djUZicqB+fr1HJYJ
 EEaUFhlulnVTrcocM4MTernx0m/Gi240jMWCdeDPBd6jrNUJae/7GhKx7p48dLJ3wqwH
 4iqc88oRQaUStss/dEvqd3WZfzwi0/wDXLSU4EMKWeu3JXXKpYUAAPCTReLoqQT+g9tM
 vLuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=9vFSSsaVq2Fwgo9NyRjo6NBdMt3DH9lnuPKcUS1H1FU=;
 b=mCUYU78lDcP/7f3kmv+DxcUN777AM/I3gHVg+ov+uaLhgV9s01ZZrx5460xYnlDEeC
 qQzA5C+/VNViErXxfTZXtKAItRsZg/P195MzR4FtBcDeuzjakAS4peDIb4ob2wbO/DZh
 ALJgp0Z2v/5Oc6pHjCXoIhMVfOSUEZ6oOKGySQvJZCF5ni0+pyxQTnjrTeBNn0gWgpNj
 DCIKuw89fODY348J5JmjhdhP5bDnqgR9wzr+84KjwO7lpuowZusl+8eNHLtUMSZHVG7H
 kCVxeQCfU/3sxjrGdIyY1ArAa8T71/b5bf2Bgbx3NZVo3M8l9DN6RzOc3KnkUo3C82xM
 s7eQ==
X-Gm-Message-State: AOAM5328RxmLkDFNkSf71Oznpi/Vo3ds2Txgv1W1K+woVvUPKYVEaNci
 1tRT54xz3t7/9R3LQmGrN7MGAmzBan4=
X-Google-Smtp-Source: ABdhPJxwd6EpsOIt6KirTy4HYnnLfs2RNgBb2bkio1XAkByMARSxTjB5Vfzc9xybO5ZHha/uZPPTqA==
X-Received: by 2002:a1c:4d11:: with SMTP id o17mr31020309wmh.134.1593697038759; 
 Thu, 02 Jul 2020 06:37:18 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id p17sm10190511wma.47.2020.07.02.06.37.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2020 06:37:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/5] MAINTAINERS: Adjust MIPS maintainership (remove Paul
 Burton)
Date: Thu,  2 Jul 2020 15:37:00 +0200
Message-Id: <20200702133701.25237-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200702133701.25237-1-f4bug@amsat.org>
References: <20200702133701.25237-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Paul Wise <pabs@debian.org>, James Hogan <jhogan@kernel.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Adrian Bunk <bunk@debian.org>, Chris Wedgwood <cw@f00f.org>,
 Paul Cercueil <paul@crapouillou.net>, Jonas Gorski <jonas.gorski@gmail.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Paul Burton <paulburton@kernel.org>,
 Helge Deller <deller@gmx.de>, Yunqiang Su <ysu@wavecomp.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Mirko Vogt <mirko-openwrt@nanl.de>, Huacai Chen <chenhc@lemote.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
 Stefan Weil <sw@weilnetz.de>, "Maciej W . Rozycki" <macro@wdc.com>,
 John Crispin <john@phrozen.org>, Lichao Liu <liulichao@loongson.cn>,
 Richard Henderson <rth@twiddle.net>, Mart Raudsepp <leio@gentoo.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>

Paul Burton removed for not being present.

Aleksandar Markovic comment:

  A polite email was sent [2 days ago] to him with question
  whether he intend to actively participate, but there was no
  response.

Paul Burton response [*]:

  It was 2 days ago, not 2 months :)
  I'm fine with being removed though - I no longer have access
  to modern MIPS CPUs or Boston hardware, and wouldn't currently
  have time to spend on them if I did.

Aleksandar Rikalo becomes the new maintainer of the Boston board.

[*] https://www.mail-archive.com/qemu-devel@nongnu.org/msg718739.html

Cc: Paul Burton <paulburton@kernel.org>
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Acked-by: Paul Burton <paulburton@kernel.org>
Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Message-Id: <20200701182559.28841-3-aleksandar.qemu.devel@gmail.com>
[PMD: Split patch in 3, added Paul response]
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
This patch still requires Ack-by from Aleksandar Rikalo

Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Stefan Weil <sw@weilnetz.de>
Cc: Hervé Poussineau <hpoussin@reactos.org>
Cc: Lichao Liu <liulichao@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: James Hogan <jhogan@kernel.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Jonas Gorski <jonas.gorski@gmail.com>
Cc: John Crispin <john@phrozen.org>
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Cc: Huacai Chen <chenhc@lemote.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Edgar E. Iglesias <edgar.iglesias@gmail.com>
Cc: Helge Deller <deller@gmx.de>
Cc: Artyom Tarasenko <atar4qemu@gmail.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Adrian Bunk <bunk@debian.org>
Cc: Yunqiang Su <ysu@wavecomp.com>
Cc: Uwe Kleine-König <uwe@kleine-koenig.org>
Cc: Mirko Vogt <mirko-openwrt@nanl.de>
Cc: Paul Wise <pabs@debian.org>
Cc: Mart Raudsepp <leio@gentoo.org>
Cc: Chris Wedgwood <cw@f00f.org>
Cc: Maciej W. Rozycki <macro@wdc.com>
Cc: Paul Cercueil <paul@crapouillou.net>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 53404a746e..64f54c553c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1099,8 +1099,7 @@ R: Jiaxun Yang <jiaxun.yang@flygoat.com>
 S: Maintained
 
 Boston
-M: Paul Burton <pburton@wavecomp.com>
-R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
+M: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
 S: Maintained
 F: hw/core/loader-fit.c
 F: hw/mips/boston.c
-- 
2.21.3


