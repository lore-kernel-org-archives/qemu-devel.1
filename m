Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDBEC49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 15:21:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDEFE20717
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 15:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aUGSG+xN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDEFE20717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8nOA-0001AC-Tz
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 11:21:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52043)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i8nLW-0007b9-0p
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:18:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i8nLU-0000It-Pf
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:18:49 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39120)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i8nLU-0000IL-Fi
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:18:48 -0400
Received: by mail-wr1-x441.google.com with SMTP id r3so2349575wrj.6
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2019 08:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8EVBqLZByuLzwkxUcoOgl/asrcDGx/FphM0V2g6QcXM=;
 b=aUGSG+xNJHqtFLFaL6AvYhx5kWlswQ84qZrwa8gWS86CSPPe+4WyO7ADxbARHHR4ap
 4QekwGa/RGpJ1jQCNOAazLKtAofIYfI/83YSC+FvgEqgfAqhAPoNwccnGo2QXC+gTFrx
 ho2qbQrr7DD18lRd6gNQl72Z+Gm8NeCd8RflC59DJhBya57qK+5NPHFso8+g5qbIcZ/n
 SOSQ7sNZSbqdPR2QjN2W7aLXJ9xFi+3+lKm1VIEdqC6cfX95Pb4cVEk7i4/TQsjS1OJp
 vPVy4YJ+u4jffBeKO9ynGsTatrMNDScp8ZHf2vJ8mCI5FRFpOsK7kr1LRFTpM+pXhkRa
 FpKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8EVBqLZByuLzwkxUcoOgl/asrcDGx/FphM0V2g6QcXM=;
 b=DGY20zCrZPQQD72ERKFTlb4e7qEEMtQSYTH5aPHV53gQE5qqUOWjAn5O4YnciKTgSx
 goLE6wRiXILmZtBiTgjeKkpG4J4YGIksdr9gC1JBmer4vPnACUVYF+HVfYFEftEz96kP
 +Gs6seDChREFGdZaTkoQs4ywZ5QNRMxLM/K8mXDa6cjKewra1+/7S/TzphJEUZ2OrfKB
 f5SEIN+2+ChFQrHxIJjFeEHt9uVZ3e8ijVHSxf5hyeGJj4pLvD2gkMBlo1wU2JJU62Ey
 BaEduaibGSQASEkWi/taQLB46I9l/26OSHs60YhF0UqGwcIk7NZJCAlnv8XsoVf6CVWz
 41RQ==
X-Gm-Message-State: APjAAAUbdsPeTORF4RHeqgv2tSqesX+1UZoK1iRSa7jHY2I34k5wNYe3
 Zs7Ho7w7KZp99L6Oex6kCe232A==
X-Google-Smtp-Source: APXvYqx2xndvw9IKBCgqzUe/wyAjBF/HvB7V6IanSGVP4FfxxDH4JKMp6WlRDrmTgYCTeccFBXKjTg==
X-Received: by 2002:a5d:574c:: with SMTP id q12mr40238135wrw.69.1568387926928; 
 Fri, 13 Sep 2019 08:18:46 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 189sm5765440wma.6.2019.09.13.08.18.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2019 08:18:46 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6C9291FF87;
 Fri, 13 Sep 2019 16:18:45 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Fri, 13 Sep 2019 16:18:39 +0100
Message-Id: <20190913151845.12582-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH v6 0/6] semihosting cleanups (plus minor
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

I've restored the #ifndef CONFIG_USER_ONLY check to M-profile as well
and split the linux-user semihosting smoke check into a new commit.

Alex Bennée (6):
  tests/tcg: clean-up some comments after the de-tangling
  target/arm: handle M-profile semihosting at translate time
  target/arm: handle A-profile semihosting at translate time
  target/arm: remove run time semihosting checks
  target/arm: remove run-time semihosting checks for linux-user
  tests/tcg: add linux-user semihosting smoke test for ARM

 linux-user/arm/cpu_loop.c         |  3 -
 linux-user/arm/target_syscall.h   |  3 -
 target/arm/helper.c               | 96 +++++++------------------------
 target/arm/m_helper.c             | 18 ++----
 target/arm/translate.c            | 30 ++++++++--
 tests/tcg/Makefile.target         |  7 ++-
 tests/tcg/aarch64/Makefile.target |  8 ++-
 tests/tcg/arm/Makefile.target     | 20 ++++---
 tests/tcg/arm/semihosting.c       | 45 +++++++++++++++
 9 files changed, 123 insertions(+), 107 deletions(-)
 create mode 100644 tests/tcg/arm/semihosting.c

-- 
2.20.1


