Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2406FC5ACAE
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 16:52:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E73A420838
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 16:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OmbjRmx0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E73A420838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i85qd-0008NK-ET
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 12:52:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43456)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i85oi-0006UY-8x
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 12:50:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i85og-00047c-Tz
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 12:50:03 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33662)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i85og-00046y-KI
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 12:50:02 -0400
Received: by mail-wr1-x443.google.com with SMTP id u16so25409879wrr.0
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 09:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=s1vPcTwJkdcbFJYXRlbSHHNB5ZlopLObSX2zy00+/xk=;
 b=OmbjRmx0mcElgohFBUpUZ+JvvVYw39mKnuFdMq3K4FXuEWd0Z8D1iDUyPwxmvQSRhp
 tZV9ganSsMyp1O2PgTqcSrpP4Jr7IkCap8Sc/uY7KLhhLgMo4F0afUhMO4UEHI0rW88X
 QotpAmNA5fPkpcrKe+EoFG/iyCKX5Liro+yU08RE4XJwXPyDF/9Xfv5y6Bvs9ts7o63A
 /oPQlakBLczUZxsHG+wy+kDiVRA0h60H7fWn0/UNosyaPIbBv61KYom4daSVYtdnXeuX
 KUQ7KX2eqF8HHTgZlqGcZyuQ7i0FTXssQ806SnmgmGhSGCvwWGj41u3xv7gwEu4SETfj
 bf8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=s1vPcTwJkdcbFJYXRlbSHHNB5ZlopLObSX2zy00+/xk=;
 b=JsF4Ew1bPKGHVhuGgYC7uIEmD7ijnenBTA/xgVgsiETbtJwjw4X5jQP9n2/DKBPZZm
 43kDvD4yT1MogWi2xLv9mLwgh3rE+HMr6KSBnM3D8dDAk32rhaeHQCqvaHGhHxWlzdpE
 sll70LAwOjiXIJuia0gu20GmgjeobjtdOQyUZA/5GdMEs0uS+KhvRNiQS59HvZmb2JnH
 +Nyxi7JJ6wz4j661vEyBAM4qUhbvzTtu6UGUc5AWRrsCkXrk7Vvu4nRxXkqbT4ajOWPa
 75F5Ggry39FOYIyputYauyMZoCEXboCgc/DpVtwYYyG1oniuadh7OWbhkAP3X5ud+tRD
 Xy2A==
X-Gm-Message-State: APjAAAXyVI14MuZ0gpVWfFscXdYasi6oNzWCAiWQ9xoHev0SO2snVcTj
 3paisvqLjS3KQN5lFx7hCTsCAA==
X-Google-Smtp-Source: APXvYqzHvwrwKECpsVoT3hU8ISFC6ugQNcQLpPfdVarh1ofw8/E7lK3w/+t/Dbzx0ecag5tDQU02JQ==
X-Received: by 2002:a5d:6951:: with SMTP id r17mr2216549wrw.208.1568220601242; 
 Wed, 11 Sep 2019 09:50:01 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id p85sm7632122wme.23.2019.09.11.09.50.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2019 09:50:00 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E031C1FF87;
 Wed, 11 Sep 2019 17:49:59 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Wed, 11 Sep 2019 17:49:54 +0100
Message-Id: <20190911164959.11003-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH v5 0/5] semihosting cleanups (plus minor
 tests/tcg tweak)
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
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

I've restored the #ifndef CONFIG_USER_ONLY to ensure A-profile
linux-user still works. I've cleaned up the now unused linux-user code
and added a simple smoke test to make sure we don't break it my
accident. There is a tests/tcg patch at the beginning of the series
which was just fixing some obvious errors in the tests/tcg comments
which I couldn't leave untouched while I was adding the smoke test. I
can put it in my next testing PR but I'm happy enough for you to take
it through your tree if you want.

Alex Bennée (5):
  tests/tcg: clean-up some comments after the de-tangling
  target/arm: handle M-profile semihosting at translate time
  target/arm: handle A-profile semihosting at translate time
  target/arm: remove run time semihosting checks
  target/arm: remove run-time semihosting checks for linux-user

 linux-user/arm/cpu_loop.c         |  3 -
 linux-user/arm/target_syscall.h   |  3 -
 target/arm/helper.c               | 96 +++++++------------------------
 target/arm/m_helper.c             | 18 ++----
 target/arm/translate.c            | 27 +++++++--
 tests/tcg/Makefile.target         |  7 ++-
 tests/tcg/aarch64/Makefile.target |  8 ++-
 tests/tcg/arm/Makefile.target     | 20 ++++---
 tests/tcg/arm/semihosting.c       | 45 +++++++++++++++
 9 files changed, 120 insertions(+), 107 deletions(-)
 create mode 100644 tests/tcg/arm/semihosting.c

-- 
2.20.1


