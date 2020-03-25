Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C9EC54FCF
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 15:18:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E99A82076A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 15:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bLHUNzZz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E99A82076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH7nw-0008Tn-1r
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 11:18:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41439)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jH7l0-0003U8-Ur
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:15:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jH7kz-0007xt-Rs
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:15:50 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:46369)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jH7kz-0007xH-Lb
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:15:49 -0400
Received: by mail-wr1-x434.google.com with SMTP id j17so3521891wru.13
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 08:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=bT+O2ozwAgkvLW9gR/+Xf0vUVInPPvZ9IQRO4pMfn0o=;
 b=bLHUNzZzLtCEbNToiqcxlsrTI/VS7LMokprbZ7l+FIVBr9/THLnBa2x7D5lHAhshgB
 0+ceOuIcJ0ndGvqNH55LlgeWUdQ8XSSWsNlyfqyJpVQ/zBNUW0WZg/n3K0Kyr//Upjqx
 nk/uDef3dA1ychfuauJL8iYSDkKGybb6BSJvYwtYR/PXJicAWSpeoOKiHyCStoLiLmDV
 9//NcuY+LvH6DW76y1NLp6QBj5DNgTqAV7EnJWY6Ow6vMqzhAo/kSg07+T5NNOp2aPZV
 MkKghgeG/Zskk4V3ApUyzQ7ppfq+oRvg3D5+b9GroAiRPMUB0i+UBINhxumCbkGSpeon
 4BuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=bT+O2ozwAgkvLW9gR/+Xf0vUVInPPvZ9IQRO4pMfn0o=;
 b=rXaFHSPGYAdSa1KGlMDqthGRUrwQXLRkvZ5LjjzafzzaxUD7UWDDcUtBcQmN/xrZer
 ri6817IDcccD4eeON7126K/nebsTNO1yMAYzzT1NzR6xfFxqpDBE9LNZH2Y5oSbP3Wx8
 /btNxMctmWWwwm71S2OYrp5PmfuhcLib4a7AT+zI8Z2vUWnwzx7SKKkgzOmuXUMb5xYL
 rwgjlwDP3xYIAcis+R/iPjpmg4PZIM0KUYrGbZCTHik0ToggfXgcJPmTdfq1OX97jmeY
 LgaIKmAJf69Idd25MMpJjcZrMUdSQtBbWTlXDxOEnPMIqFIiN+ZAy77t8PRrxe8jZbL/
 4Vxg==
X-Gm-Message-State: ANhLgQ3iV2dsx3DM9OKJjsYcHQnE5SWBqXHHU+tFsnEOLgXm6PtJkNuY
 SG7CkoQsKgQgGY/dVVGxaT3JvFzZqaY=
X-Google-Smtp-Source: ADFU+vu+Kqep3W40sK+eIdEIlS2kDL8249lLn8hDOd9U1bYZGUGygQyBrGCquqn1dakIYLdyx3JRmw==
X-Received: by 2002:a5d:640e:: with SMTP id z14mr4268342wru.204.1585149348639; 
 Wed, 25 Mar 2020 08:15:48 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b6sm18805180wrp.59.2020.03.25.08.15.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2020 08:15:44 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3D1B11FF7E;
 Wed, 25 Mar 2020 15:15:43 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL for 5.0-rc1 00/11] testing updates (+ one mttcg change)
Date: Wed, 25 Mar 2020 15:15:32 +0000
Message-Id: <20200325151543.32478-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::434
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 736cf607e40674776d752acc201f565723e86045:

  Update version for v5.0.0-rc0 release (2020-03-24 17:50:00 +0000)

are available in the Git repository at:

  https://github.com/stsquad/qemu.git tags/pull-testing-250320-1

for you to fetch changes up to 6a5970988e7c9ce7f9fa9747397b63e8455144c6:

  .travis.yml: Add a KVM-only s390x job (2020-03-25 14:40:14 +0000)

----------------------------------------------------------------
Testing updates:

  - docker updates (various dependencies)
  - travis updates (s390x KVM build)
  - test/vm updates (NetBSD -> 9.0, FreeBSD -> 12.1)
  - disable MTTCG for mips64/mips64el

----------------------------------------------------------------
Alex Bennée (2):
      tests/vm: fix basevm config
      configure: disable MTTCG for MIPS guests

Gerd Hoffmann (4):
      tests/vm: write raw console log
      tests/vm: move vga setup
      tests/vm: update FreeBSD to 12.1
      tests/vm: update NetBSD to 9.0

Philippe Mathieu-Daudé (5):
      tests/docker: Keep package list sorted
      tests/docker: Install gcrypt devel package in Debian image
      tests/docker: Use Python3 PyYAML in the Fedora image
      tests/docker: Add libepoxy and libudev packages to the Fedora image
      .travis.yml: Add a KVM-only s390x job

 configure                                    |  2 +-
 .travis.yml                                  | 42 ++++++++++++++++++++++++++++
 tests/docker/dockerfiles/centos7.docker      |  6 ++--
 tests/docker/dockerfiles/debian-amd64.docker |  1 +
 tests/docker/dockerfiles/fedora.docker       | 10 +++++--
 tests/vm/basevm.py                           | 23 +++++++++------
 tests/vm/fedora                              |  1 +
 tests/vm/freebsd                             |  5 ++--
 tests/vm/netbsd                              | 24 +++++-----------
 tests/vm/openbsd                             |  1 +
 tests/vm/ubuntu.i386                         |  5 +++-
 11 files changed, 85 insertions(+), 35 deletions(-)

-- 
2.20.1


