Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31561C11D2F
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 17:29:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00A1A20732
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 17:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jmWZBk+g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00A1A20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6HY6-00087R-3I
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 12:29:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50784)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j6HXH-00075Q-DL
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 12:28:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j6HXG-0001SR-D7
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 12:28:51 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39839)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j6HXG-0001RY-5q
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 12:28:50 -0500
Received: by mail-wr1-x442.google.com with SMTP id y17so2564488wrn.6
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 09:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5brZzZlL8zAr210MI+xk/RtI4mcYUOD8ts7Ls8WMhRo=;
 b=jmWZBk+g9mQkShgJTIhGnv8KBAyi4Ix7rs2tzeEnYtm7t+W/CGuBVQo65CVsd/hyXj
 h2VpDRr3QzdofdMeDf/gPHVXzexUEsXddjkHajiSducbSuJN0bMdhUMbe3B7opSMji/U
 0MaKyyY9ulnw0v0p7M94Ek9fdx4BT9Okt/x6FfhPhMaFmoGYxaj3HI1WX3ITZSytzGXj
 0G658bmYJs9EQjS/HiNYaRJV1bvNh1geEyPcgnWjD/0yTf7TCjN68uf+tzfxwP+EPpK5
 D7m6Nj24ywt7sR09FKEV2P0AzL+0cIprJCIixBkG162DAphGcHcx4D6dswIFyHrG6Io9
 Btjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5brZzZlL8zAr210MI+xk/RtI4mcYUOD8ts7Ls8WMhRo=;
 b=COq3tectccKrorGnrzhS/WPJuYNYhrWcHLeJ05bc8yFFnuJFb+2ubzhEZvly7iSJ1V
 Rr018VIPEK5GoJjRd0ARvsc4p6v+4ul1kQWCe0oBhgkdhiQA4OAzAShFU1bkdXgAVpQl
 tr4Yu953xdkA0SXwXC7hZL+/CxcWOyT6XKSELTaJfbSEOEg1wtGnrvnknMSX3pO4inD5
 TeUkiEwAHot9ByMsX07St0Dk0OTG7CK6JfMsvR9J4jatO5T928t1lAIGKaVZILTAxFjB
 Gl4tJ9dTy4qDvVnj9ZA2Yr6tUrwqrmBFheKQEMGkLWcy/SmSW3+m07BOOZ5pCNL9ne03
 tRlQ==
X-Gm-Message-State: APjAAAUD61j1cHthffesnSCO/ZWNrQztgSa1k2SxyQmamJyeRJxUF8p3
 0ZNKx+TC4Rzp9K/7j4BiBEWNfA==
X-Google-Smtp-Source: APXvYqzwggKcNO1+Eq9pwf87r6wookBiaa1lIHAELHyd8bX7KQtpC1kAGOWYSC+e02SgnBAqqO0sHw==
X-Received: by 2002:adf:f692:: with SMTP id v18mr69351961wrp.246.1582565328715; 
 Mon, 24 Feb 2020 09:28:48 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id b10sm60652wmj.48.2020.02.24.09.28.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2020 09:28:48 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 0/3] target/arm: Implement v8.3-RCPC and v8.4-RCPC
Date: Mon, 24 Feb 2020 17:28:43 +0000
Message-Id: <20200224172846.13053-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patchset implements the Arm architectural features
ARMv8.3-RCPC and ARMv8.4-RCPC. These provide a handful of
new load and store instructions which have "LoadAcquirePC"
semantics. These are slightly weaker than standard
"LoadAcquire", so we choose to implement them in QEMU as
LoadAcquire.

Patch 1 is a trivial fix to the PMU isar function which
I managed to cut-n-paste with the wrong FIELD_EX* macro.

I've tested these using risu against an Arm AEM FVP model:
this doesn't do anything to test the memory barrier semantics
but does work as a check that the decode is correct and
that the various signed/unsigned/extend/etc operations
are being done correctly.

thanks
-- PMM

Peter Maydell (3):
  target/arm: Fix wrong use of FIELD_EX32 on ID_AA64DFR0
  target/arm: Implement v8.3-RCPC
  target/arm: Implement v8.4-RCPC

 target/arm/cpu.h           |  14 ++++-
 linux-user/elfload.c       |   2 +
 target/arm/cpu64.c         |   1 +
 target/arm/translate-a64.c | 114 +++++++++++++++++++++++++++++++++++++
 4 files changed, 129 insertions(+), 2 deletions(-)

-- 
2.20.1


