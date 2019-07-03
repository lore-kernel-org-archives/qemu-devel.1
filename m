Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04465C0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 15:58:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7FBC2080C
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 15:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hPxR0Dve"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7FBC2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiheA-0005Sr-3I
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 11:58:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53334)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hihZV-0002nz-T5
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 11:53:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hihZT-0007Dn-BM
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 11:53:24 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33366)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hihZT-0006v5-3m
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 11:53:23 -0400
Received: by mail-wr1-x444.google.com with SMTP id n9so3433566wru.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2019 08:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6KzHCzyLzOPViQf+TwLv4dHKSFro0ylJNZ8ZFWOVgQQ=;
 b=hPxR0DveOfz9zLTUts0mRcXdb9BfRSR1U4WzC6BPhPv1PFk+MVvdf13ntjTMRkBS/5
 gjzWyoJki5o2pkdxtWLGdeRSuII3qXYYSEqNWYv99qGrLQH18w1Eh2uZu6SFMi2kDSH3
 vm8Kuk6dkRm/vgM5TRTRfr4JOdpXGUe2m3LeDwZqcw44ZXuPwgmKHMLpw8//xDICFdel
 8Vjqr9J356dbsHdgtrv7ze5mi1s9qAkwvbtj6rtyKQxkz9xlG/2zQAYbxwubYNhW9ezM
 duILYoCOmxL8T8sP8znc7D1B/fGbpNJC7eUAVM7YYj/e/7MOKrHMHJG/ZJVrUc96/jWm
 /DpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6KzHCzyLzOPViQf+TwLv4dHKSFro0ylJNZ8ZFWOVgQQ=;
 b=SGyUDkRSCq8Xrog7kTcSmq7Rp22rDxhaAXn9OL+XmBo0Rg/+kDvTnG/2e+KGaBX1d9
 7UuAQ+ek95kngdpr1Qp/V9WmRwboeeZa+H/MREddDSoyG531RVpHrLi+HshV+N2dNZLc
 qyZNCAU/jTh6rJIZN1bABomPQK3pD1R/N7XNALsuf6pJTdBYmCFA4TrYR4up281vBHCf
 vGeiRXyiCi0ZEzQxejd7mb2xLgs2v6vVn/8HKMbDty16sSZqj11j6LYvMvICTBYEjeyU
 2TjKJnlCLKbB3gw9qL9T1ZhliQeCi6ExXN8urgeWw9Txyul3hIzhTmFkzDvglai6q6i1
 NY3A==
X-Gm-Message-State: APjAAAV+Wm1l6iQHCZGvDErwApP+ImXxIgzLCMj7SjUptrxhYj68YrKd
 8dx79bvGG5uQANUMyNA//3Q/gg==
X-Google-Smtp-Source: APXvYqxP5Ygjr6ReANHcy5iFPzYIBdgh9foXkGIfszQ4z4m+kLEZw6dVbS68nAuKzrjROSj4/h4V2g==
X-Received: by 2002:a5d:43c9:: with SMTP id v9mr29105558wrr.70.1562169165185; 
 Wed, 03 Jul 2019 08:52:45 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id p11sm3338001wrm.53.2019.07.03.08.52.44
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 03 Jul 2019 08:52:44 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 519D71FF87;
 Wed,  3 Jul 2019 16:52:44 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  3 Jul 2019 16:52:40 +0100
Message-Id: <20190703155244.28166-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH  v1 0/4] arm semihosting cleanups
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

One of the comments that came up during the review of the plugin
series was around the clumsiness of tweaking arm_ld*_code. The main
reason was it was being used to "peak" at semihosting instructions at
runtime to decide what to do. This series fixes that up to make all
the semihosting invocation consistent and resolved at translation
time.

Alex Bennée (4):
  target/arm: handle M-profile semihosting at translate time
  target/arm: handle A-profile T32 semihosting at translate time
  target/arm: handle A-profile A32 semihosting at translate time
  target/arm: remove run time semihosting checks

 target/arm/helper.c    | 102 ++++++++++-------------------------------
 target/arm/translate.c |  64 ++++++++++++++++++++++----
 2 files changed, 79 insertions(+), 87 deletions(-)

-- 
2.20.1


