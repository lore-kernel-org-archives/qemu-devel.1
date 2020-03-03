Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AADA9C3F2D7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 17:51:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7962120728
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 17:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y5xvjKIX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7962120728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9BhA-0000tv-Ir
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 12:51:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41070)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j9Bg3-0007Um-8a
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 12:49:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j9Bg2-0006Is-7M
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 12:49:54 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:54444)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j9Bg2-0006IU-0U
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 12:49:54 -0500
Received: by mail-wm1-x341.google.com with SMTP id i9so2886511wml.4
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2020 09:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YnwWb0ktjqR6grQ5B0xNv+o0Z5hrJjhALm6SqF5FQYA=;
 b=Y5xvjKIXvEnlCK1SHZJ+0xbdUS+btGLs72KTkHFiNleHZtbTyAtK3xOgFnKkXJizUI
 FInnGxDgRnXNRQM5yc0XarDgx2m6SokVGcKcOYrn41FA4BCjldKVsxKZ5/BsMOZez9nU
 rntphYISW+H42FJRuVoGuokEnXypeeZ2MAHay0NtwnwFZXhmAxg4ZPbZTDAKLvwpviss
 8HlX1m3KKnB4CRKohmQzk+FgOdDDkipT7hFpJ2Ypax0PRFQ0UC9fTPbpkn+DRDkIIyxG
 lfaaWtB/AQIKegsMp4oempmiIwiiuVTgXuwi8fnaH2OJUzNJ14PAJViJuWGFJ2/KlsrS
 mCWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YnwWb0ktjqR6grQ5B0xNv+o0Z5hrJjhALm6SqF5FQYA=;
 b=oeB2O4EjQKJaogatjTTfUYOsY61XFqDtU4m0BvWJSZ6sjsvtr66JPWPu6kBpOW8pXP
 l0ddURhRMUG02V1r/4z/WIGlLc9IfnbDlFpbK1o0xu3c5zkWTo75pIWamcvwwoia4p43
 L5f/aAtnWeKicSdBbRqNHu7xSc+H9pMOXGR06haZMNo8nx4Y+fjtMTlMrf1dUVVNg0Ma
 NtSSaQIrnsombj7HRPjN5BBBtUFDho/8F2Y1pGL0uBm/g2C86zQSTdCnFjtcySrQdTuK
 Yiuzb+X+dhMjNdyz2ccSoVJ4CsWkPw1BtZcXLxQqFCkcr2U7MXMwhKM0Hn+cgnz2RPu3
 zUkw==
X-Gm-Message-State: ANhLgQ2EYNfaffEhZVG7whiS/bCEWvK+sovbV/3lQwOx6/67o5d9UlOW
 E2J3sTpIwZKjjCDFl0U4+w/nOQ==
X-Google-Smtp-Source: ADFU+vue3rdTNKttYOMuYeR7YtcdomYtPW0TNg4Z/nSissfWwO5d4ZME/Eu22nahdi/opF6WxuGScg==
X-Received: by 2002:a05:600c:290:: with SMTP id
 16mr5058101wmk.64.1583257792578; 
 Tue, 03 Mar 2020 09:49:52 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id d63sm4867576wmd.44.2020.03.03.09.49.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2020 09:49:51 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 0/4] target/arm: Fix hflags mismatches for M-profile
Date: Tue,  3 Mar 2020 17:49:46 +0000
Message-Id: <20200303174950.3298-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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

This patchset fixes three hflags-mismatch assertions I ran
into while doing some work on M-profile. The last patch
is just comment typos that I noticed in the process.

thanks
-- PMM

Peter Maydell (4):
  hw/intc/armv7m_nvic: Rebuild hflags on reset
  target/arm: Update hflags in trans_CPS_v7m()
  target/arm: Recalculate hflags correctly after writes to CONTROL
  target/arm: Fix some comment typos

 target/arm/helper.h    |  1 +
 hw/intc/armv7m_nvic.c  |  6 ++++++
 target/arm/helper.c    | 14 +++++++++++++-
 target/arm/translate.c | 14 ++++++++------
 4 files changed, 28 insertions(+), 7 deletions(-)

-- 
2.20.1


