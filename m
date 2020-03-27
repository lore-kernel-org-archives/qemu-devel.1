Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C99CC43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 18:14:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D89B42072F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 18:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OKoHz4oZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D89B42072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHtUy-0003OC-VP
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 14:14:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40441)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jHtTy-0001j9-Br
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 14:13:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jHtTx-0000eM-8g
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 14:13:26 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:38226)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jHtTx-0000d8-2p
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 14:13:25 -0400
Received: by mail-wm1-x32a.google.com with SMTP id f6so6809504wmj.3
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 11:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=L3Dy1AYTLsgk+g4a1iYXFzel+lLsaoC7Z73sb2fVHxQ=;
 b=OKoHz4oZYcycAFyEeG8uVSO4NMiBnLncj5fQ1aHwIFpdEIUV16CqF4VdtAd3Qg2vPY
 fZ5UnofJXLC2Y3DsS3LV7CYROxrTDdl+Z7yWtkT/0MyA0VwBF7n4EycSCGPb76wk124w
 paRBCzksZtmm7Ea0XCmOHU33cqJRbCZn574UriUMYoO6WZmpZvquFQ36U1RjSXfpVBYx
 A2AGDXkQHqydYCQl4bSnKb20GJ5fZFwT3mYdfU4rRhBK4RJifVjEReT04c5/4vSG4gaA
 cEM5We/FVYITg7yF0D8/FsqrqxDLhHdij//7DPEXOwXzfbn7nwpAMKjrVp2lVf+GnCZT
 cjag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=L3Dy1AYTLsgk+g4a1iYXFzel+lLsaoC7Z73sb2fVHxQ=;
 b=GmAmCYOFQLh7dRoqLcvRS8G1GdAQWF0Wri7CNpaRNM3fHDShRpxr8Fq6t6ekPHXzaf
 UfhyPaJdxAznXgC0aA6BnXqUKYI8jxMcA4mBBIuwmSXRGXYOOsWm9Ziipm+onpNJpVzQ
 Ox90q1UywmVKZgPcou/w41hSMm00Bw5dHnOFyKg5JhHdzSUWk3odrpjobe1q+wxI7WEZ
 eVo16VzWghe13ZCCDA5zBAa4AsX55HHZWoM5h5GLufNBwPbITx4An5RK+w9teNj4JWBK
 0Y68lrn3+5/2OULCuXwDxEzVZyrVDlLGMcBMjTgLm0ZBhNs7wfZnfD2slrIcQCuoPifT
 SdfA==
X-Gm-Message-State: ANhLgQ0dBflrYUaG+1Cmrraz+L07LqVsRhr4hhsDp/1vzWTEiES6RR+Z
 3ed6bkuxAvRVgMhBlemJSYJG0A==
X-Google-Smtp-Source: ADFU+vvisYAhOZvfTaxbgeZUmHIBs9XpU6s6asRAGkuoe1Adpxf4oM5U1xXQfP9MEGIvcmn53fGLnA==
X-Received: by 2002:a1c:b657:: with SMTP id g84mr6562993wmf.107.1585332803919; 
 Fri, 27 Mar 2020 11:13:23 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g14sm9468466wme.32.2020.03.27.11.13.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2020 11:13:21 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 477971FF7E;
 Fri, 27 Mar 2020 18:13:20 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 for 5.0 00/12] testing updates (+ one mttcg change)
Date: Fri, 27 Mar 2020 18:13:08 +0000
Message-Id: <20200327181320.23329-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32a
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

The following changes since commit cfe68ae025f704f336d7dd3d1903ce37b445831d:

  Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-5.0-pull-request' into staging (2020-03-26 20:55:54 +0000)

are available in the Git repository at:

  https://github.com/stsquad/qemu.git tags/pull-testing-270320-2

for you to fetch changes up to 41e1f0e2256e4c21bc5671ecb64191e776477c35:

  .travis.yml: Add a KVM-only s390x job (2020-03-27 13:43:20 +0000)

----------------------------------------------------------------
Testing updates:

  - docker updates (various dependencies)
  - travis updates (s390x KVM build)
  - tweak qemu/atomic.h headers in event of clash
  - test/vm updates (NetBSD -> 9.0, FreeBSD -> 12.1)
  - disable MTTCG for mips64/mips64el

----------------------------------------------------------------
Alex Bennée (3):
      qemu/atomic.h: add #ifdef guards for stdatomic.h
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
 include/qemu/atomic.h                        |  6 ++++
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
 12 files changed, 91 insertions(+), 35 deletions(-)

-- 
2.20.1


