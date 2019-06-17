Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D41C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 17:54:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52A4920861
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 17:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZzjyTQ1K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52A4920861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50642 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcvqL-0000xV-5q
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 13:54:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50645)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hcvoq-0007eo-EU
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 13:53:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hcvoo-0000Zg-8j
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 13:53:24 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:39027)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hcvoo-0000Yt-01
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 13:53:22 -0400
Received: by mail-wm1-x332.google.com with SMTP id z23so305337wma.4
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 10:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=bwrup4kLeXvOMHO6drVlshIwfFzLp0o5ivBB3kuYX/A=;
 b=ZzjyTQ1KPHAzjKtq9yamCZ+4dHe0nJ4bFUfWsaU/zXGTHo0WIOlNGN9kw4X1Zx5FtP
 Y9Et/NKhj8SroR5b8+NKAzndOf7MEkPqQji40qYJK6znBCbvCyjm3DE8dKgVCcBzaAii
 2Vt2/PAhuqeg80XrgPJ9uSeGJxjb0dKJSz7BRx+8tIEFTBPPUzTZlNxeTN8Yv5ogig0t
 57q8X5dIGDluXPQdj6jPk3zQ6UKR+z30fmmqcACzVICOCeOXnzhH2wgY5DYzC4bFErGU
 GcSG+GmFavqgO0YKZAvzokSmfg5UIckXuigkaPLXBkdjO0tMkvU/pr+TMCaBks286B5j
 8Wow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=bwrup4kLeXvOMHO6drVlshIwfFzLp0o5ivBB3kuYX/A=;
 b=Bjq6mKIIx88HGFpkHu12hZcz+tYYAXbTi99MHzxnvUWpdmIG8f/FcXIexua8URo1s8
 3U+t1s3VzuKdK17g6eEg2obbeGuuqXPqQJlSEd6r/6KIWINE9rWxjH9ReJZ/tPNfAFMp
 DTKczPhpkbo0Y3nzulyScu1Qiv39YYxQhVfmYaslgg3LGh14RjjdkWyP2ozTaGeDScE5
 1QF6/sRjrUj8e9+/HbE58iqYyrVHG8FJ5yp9OBQpyikbAu6xE3htOK9GjkXVM3GcHU9a
 vbbdzQCVctVzY5fH1XQQhbLvASlfytTGZ3teZC7YaEDh9p5tK3H8xN4TxubmZdkBm7VJ
 4Gsw==
X-Gm-Message-State: APjAAAVhbk2k9U9XhbvkH4pAAtzxJrcyzA4qt9LM+KCs0/MPI7FR+H6X
 9n62F3tgTNxcDcGF5hqNLyzm+w==
X-Google-Smtp-Source: APXvYqzAGEq6pW6XsMaCw0VtipejCDEp7O9ZNNNQjSRYPotXJDA2leZby9rRxoV616JzZGpSxfJcxw==
X-Received: by 2002:a1c:7a15:: with SMTP id v21mr19802236wmc.82.1560793999592; 
 Mon, 17 Jun 2019 10:53:19 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t14sm8713619wrr.33.2019.06.17.10.53.18
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Jun 2019 10:53:18 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Mon, 17 Jun 2019 18:53:11 +0100
Message-Id: <20190617175317.27557-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::332
Subject: [Qemu-devel] [PATCH 0/6] Six minor M-profile bugfixes
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

This series fixes half a dozen miscellaneous minor bugs
in our M-profile emulation. (The condbits fix also affects
A-profile cores.)

thanks
-- PMM

Peter Maydell (6):
  target/arm: NS BusFault on vector table fetch escalates to NS
    HardFault
  arm v8M: Forcibly clear negative-priority exceptions on deactivate
  target/arm: v8M: Check state of exception being returned from
  target/arm: Use _ra versions of cpu_stl_data() in v7M helpers
  hw/timer/armv7m_systick: Forbid non-privileged accesses
  target/arm: Execute Thumb instructions when their condbits are 0xf

 hw/intc/armv7m_nvic.c     | 54 ++++++++++++++++++++++++++++++++++-----
 hw/timer/armv7m_systick.c | 26 ++++++++++++++-----
 target/arm/helper.c       | 45 ++++++++++++++++++++++----------
 target/arm/translate.c    | 15 +++++++++--
 4 files changed, 112 insertions(+), 28 deletions(-)

-- 
2.20.1


