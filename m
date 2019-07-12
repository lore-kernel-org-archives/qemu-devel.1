Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D90C742B2
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 11:19:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 958BE20863
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 11:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Afb4J5m6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 958BE20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hltaV-0002nu-F4
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 07:19:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47086)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hltZn-0000Gn-0b
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 07:18:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hltZl-0000KI-Rl
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 07:18:54 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41737)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hltZl-0000H7-HE
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 07:18:53 -0400
Received: by mail-wr1-x441.google.com with SMTP id c2so6379386wrm.8
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2019 04:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+uCpKFxtpwZ33dZKWTNDPHC7WX/EUHFtIcT+09+dr7o=;
 b=Afb4J5m6NLOVN1aNi667CoJYRfZiapuSTRPcPEwzwYUpGhp4EsoXkXDSP4LxC2y/Gz
 uzyPMk610FAeqwx5i8ReANoZZzcsfXm/sGJ/Itvpx+nHDMU8WCCcEtsJIAa95BnzG2S/
 rhv/qQzj7sV7K4MU1+q1zCHVDSJuinH2AdgAJy1wT2bxTVoeerJDu1Y8oll4uoSCxjd8
 Xp6ot9a9rhmSDmWhBC9rbXW7DWDd6bVjq3pYvs8Q44gJqfL8assFiEieRDER0mUnqqWm
 1uwUuLXdqhpaqNSHJsnBXoq7Dj2NYsBA3tyKtE395xv5TyGFXik1zv9C+FQ0FLZGwbWq
 vK6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+uCpKFxtpwZ33dZKWTNDPHC7WX/EUHFtIcT+09+dr7o=;
 b=IyQEQux+ZaWLbYsTzuN7EOs3jyzO2oz0oBd4UrpXOBFr2j9w/SEcT6NetbC8imHHwl
 b9bRVhIxvl/s0Qn/ll5PY2E5cp9sZs1ZWu3j6aaYFrGO8aT/QfJgHteNLsFt8ZH90Pxv
 pO/YmOq+kkoDUBYUVyuBnJtfkh/sc2b/hUUmbkyLdeCaeAds5aAeHSutnZVTRuEUEBd5
 mFWpNuiAui0gw700H+HFriF7r2NsHNveMYeKawprNMhE1WgMk/BwtbKwVQ5xtq7GePhN
 LuZQGtuCbUNidf6IrznQ60vvg2MOyMBrJw7DgH2S+QUHDA1MjbrNtqvZYc6M5n700gqq
 dAGw==
X-Gm-Message-State: APjAAAWCQi2DWVXr7TsqO8T9pcFySEoPvI/ai25PMnRJsmncA7mvDHB4
 BIks9/QStuxaYgV/M7O6m0HKPA==
X-Google-Smtp-Source: APXvYqyFbhrgRPfGvGP9sFdt/qkKw1cgFBMIzeEZqGYSZwJ/1TpNxmpWwPGmApxuYQzwIkHM51lrjQ==
X-Received: by 2002:adf:ca0f:: with SMTP id o15mr11316307wrh.135.1562930330856; 
 Fri, 12 Jul 2019 04:18:50 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id j17sm3684717wrb.35.2019.07.12.04.18.50
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 12 Jul 2019 04:18:50 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D58941FF87;
 Fri, 12 Jul 2019 12:18:49 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 12 Jul 2019 12:18:42 +0100
Message-Id: <20190712111849.9006-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH for 4.1? v1 0/7] testing/next (docker,
 win-cross)
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

This is my current queue for testing/next. I think they are all worth
it for 4.1 but it would be nice to get the Windows cross builds up and
running again.

The following patches need review
 patch 0001/tests docker add test misc for building tools doc.patch
 patch 0005/tests migration test don t spam the logs when we .patch
 patch 0006/tests dockerfiles update the win cross builds to .patch
 patch 0007/shippable re enable the windows cross builds.patch

Alex Bennée (4):
  tests/docker: add test-misc for building tools & docs
  tests/migration-test: don't spam the logs when we fail
  tests/dockerfiles: update the win cross builds to stretch
  shippable: re-enable the windows cross builds

Philippe Mathieu-Daudé (3):
  tests/docker: Install Sphinx in the Ubuntu images
  tests/docker: Install Sphinx in the Fedora image
  tests/docker: Install Ubuntu images noninteractively

 .shippable.yml                                |  9 ++++----
 tests/docker/Makefile.include                 |  6 ++---
 .../dockerfiles/debian-win32-cross.docker     |  4 ++--
 .../dockerfiles/debian-win64-cross.docker     |  4 ++--
 ...{debian8-mxe.docker => debian9-mxe.docker} | 11 ++++++----
 tests/docker/dockerfiles/fedora.docker        |  1 +
 tests/docker/dockerfiles/ubuntu.docker        |  3 ++-
 tests/docker/dockerfiles/ubuntu1804.docker    |  3 ++-
 tests/docker/test-misc                        | 22 +++++++++++++++++++
 tests/migration-test.c                        | 19 ++++++++++------
 10 files changed, 57 insertions(+), 25 deletions(-)
 rename tests/docker/dockerfiles/{debian8-mxe.docker => debian9-mxe.docker} (56%)
 create mode 100755 tests/docker/test-misc

-- 
2.20.1


