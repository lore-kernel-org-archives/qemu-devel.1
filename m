Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2130C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 17:01:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A908216C4
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 17:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vnDtjFO9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A908216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58003 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOmQU-0000mv-PC
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 13:01:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hOmO5-0006wU-Dc
	for qemu-devel@nongnu.org; Thu, 09 May 2019 12:59:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hOmO3-0004pr-K8
	for qemu-devel@nongnu.org; Thu, 09 May 2019 12:59:17 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44749)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hOmO3-0004p0-AI
	for qemu-devel@nongnu.org; Thu, 09 May 2019 12:59:15 -0400
Received: by mail-wr1-x441.google.com with SMTP id c5so4014760wrs.11
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 09:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=wIGdxVM4yymDwYrmnZx5ewXCM0nJtPOhpRilfHIQPFA=;
	b=vnDtjFO95WVgPmJusmSd5AosVRg8DBhLl2PXlDveLhROlooybaz7FEOpFVC4QQ/twu
	6/x0DMP3Aho1i3Vuccd4yGy2B0gJFPDZYhEQMVELZ2gQ97vUTo9mkmXZnzOth/gIEtdg
	eccsXsE6P9TnGqJ4muEwVT2wrdWb3+MZ76ZKb8azYEcMYxjl4u/waL/6ml30VCevDZ1p
	tKWoMoc9g+addBZ1wz9/ESnpcB7PFKvRUGq8X+GOV0Mg3kt7ZlnbVHY3V1G1L0BUGV6z
	DjNwZkwTRohukRyXeNBFGsea357dJEAZU8v630PMnaQbK2UuSTXNn/IJpE30K03QrNDL
	qt1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=wIGdxVM4yymDwYrmnZx5ewXCM0nJtPOhpRilfHIQPFA=;
	b=q7WLvzpGKxLsW1FuxW9o3Ke5QIHdYzR0LIIiiKGIx+QfNgI2OVG7kPIYsOJccM2N3L
	vPvl6tt3Z/Y08tFPcgmrKFrTdORgB4nitemeyRI5yxAY9qYec1nqsoxCccFuN/wLBsVP
	11GZfN6sftcpMQ/t9JbZUPGbI/vHDe3oRPOCXvpWYvwq9aIgFy16gy9wRA0D+Ku6IvtP
	7CboVyaXhUcmQhWazawD+f2JlvYk/gFv8MI56HHV7n2c3AxRecqHd+2zl76GiXuEnWuU
	jFXtJBIo7q9QX4Chb95O40VpXqNCPGEjUkfqpqOT3pdGZzdFkAOQmEscxQrFSw/z5NHY
	zPeQ==
X-Gm-Message-State: APjAAAX01E/qClmpQxLeELm9pl7PRwvnjQHxsyHjU+aC0a073cTW7FyR
	XiJBcfEwRm0+FjoTvTJhTB0ffw==
X-Google-Smtp-Source: APXvYqwZLsRtU3GuxstJLC+ZTuTGpt+TfMB95Tr54169MMYz6YDFo4CLJK3wz7XpwtvN72wOcRiu1g==
X-Received: by 2002:adf:83c6:: with SMTP id 64mr4164345wre.81.1557421153417;
	Thu, 09 May 2019 09:59:13 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id v1sm1558545wrd.47.2019.05.09.09.59.12
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 09 May 2019 09:59:12 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 0C04D1FF87;
	Thu,  9 May 2019 17:59:12 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  9 May 2019 17:58:48 +0100
Message-Id: <20190509165912.10512-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH v1 00/23] current testing/next queue
 (docker/system & io tests)
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
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

This is the current status of my testing/next tree which I'd like to
send a PR for next week. It contains a few distinct things:

 - Various docker updates
 - More softmmu system tests enablement (inc aarch64/alpha)
 - Thomas' qemu-iotests (with my check output tweaks)

To make the system test experience a little better I've enabled
chardev support for semihosting so the output can be redirected like
other serial devices.

I've included the iotest stuff as its enabled for CI but if the block
guys want to take it through their trees now is the time to shout
about it. The format output patch now attempts to preserve old
behaviour when called directly although it's not exactly the same.

The following patches need review
  patch 0005/semihosting enable chardev backed output.patch
  patch 0006/editorconfig add settings for .s .S files.patch
  patch 0007/tests tcg aarch64 add system boot.S.patch
  patch 0012/.travis.yml enable aarch64 softmmu and alpha soft.patch
  patch 0022/tests qemu iotests re format output to for make c.patch


Alex Bennée (13):
  tests/tcg/multiarch: add support for multiarch system tests
  tests/tcg/multiarch: add hello world system test
  semihosting: enable chardev backed output
  editorconfig: add settings for .s/.S files
  tests/tcg/aarch64: add system boot.S
  tests/tcg/multiarch: move the system memory test
  tests/tcg/minilib: support %c format char
  tests/tcg/multiarch: expand system memory test to cover more
  .travis.yml: enable aarch64-softmmu and alpha-softmmu tcg tests
  Makefile: fix coverage-report reference to BUILD_DIR
  Makefile: include per-target build directories in coverage report
  Makefile.target: support per-target coverage reports
  tests/qemu-iotests: re-format output to for make check-block

Gerd Hoffmann (1):
  tests/docker: add ubuntu 18.04

Philippe Mathieu-Daudé (1):
  tests/docker: Test more components on the Fedora default image

Richard Henderson (1):
  tests/tcg/alpha: add system boot.S

Thomas Huth (7):
  tests/qemu-iotests/005: Add a sanity check for large sparse file
    support
  tests/qemu-iotests/check: Pick a default machine if necessary
  tests/qemu-iotests: Do not hard-code the path to bash
  cirrus / travis: Add gnu-sed and bash for macOS and FreeBSD
  tests/qemu-iotests: Remove the "_supported_os Linux" line from many
    tests
  tests/qemu-iotests/group: Re-use the "auto" group for tests that can
    always run
  tests: Run the iotests during "make check" again

 .cirrus.yml                                   |   4 +-
 .editorconfig                                 |   5 +
 .travis.yml                                   |   3 +-
 MAINTAINERS                                   |   1 +
 Makefile                                      |   4 +-
 Makefile.target                               |  16 +
 include/exec/semihost.h                       |   6 +
 qemu-options.hx                               |   6 +-
 target/arm/arm-semi.c                         |  21 +-
 tests/Makefile.include                        |   8 +-
 tests/check-block.sh                          |  44 +-
 tests/docker/dockerfiles/fedora.docker        |   7 +
 tests/docker/dockerfiles/ubuntu1804.docker    |  57 ++
 tests/qemu-iotests-quick.sh                   |   8 -
 tests/qemu-iotests/001                        |   1 -
 tests/qemu-iotests/002                        |   1 -
 tests/qemu-iotests/003                        |   1 -
 tests/qemu-iotests/004                        |   1 -
 tests/qemu-iotests/005                        |   9 +
 tests/qemu-iotests/007                        |   1 -
 tests/qemu-iotests/008                        |   1 -
 tests/qemu-iotests/009                        |   1 -
 tests/qemu-iotests/010                        |   1 -
 tests/qemu-iotests/011                        |   1 -
 tests/qemu-iotests/012                        |   1 -
 tests/qemu-iotests/015                        |   1 -
 tests/qemu-iotests/017                        |   1 -
 tests/qemu-iotests/020                        |   1 -
 tests/qemu-iotests/021                        |   1 -
 tests/qemu-iotests/022                        |   1 -
 tests/qemu-iotests/025                        |   1 -
 tests/qemu-iotests/026                        |   1 -
 tests/qemu-iotests/027                        |   1 -
 tests/qemu-iotests/029                        |   1 -
 tests/qemu-iotests/031                        |   1 -
 tests/qemu-iotests/032                        |   1 -
 tests/qemu-iotests/033                        |   1 -
 tests/qemu-iotests/035                        |   1 -
 tests/qemu-iotests/036                        |   1 -
 tests/qemu-iotests/037                        |   1 -
 tests/qemu-iotests/042                        |   1 -
 tests/qemu-iotests/043                        |   1 -
 tests/qemu-iotests/046                        |   1 -
 tests/qemu-iotests/047                        |   1 -
 tests/qemu-iotests/049                        |   1 -
 tests/qemu-iotests/050                        |   1 -
 tests/qemu-iotests/051                        |   1 -
 tests/qemu-iotests/052                        |   1 -
 tests/qemu-iotests/053                        |   1 -
 tests/qemu-iotests/054                        |   1 -
 tests/qemu-iotests/062                        |   1 -
 tests/qemu-iotests/063                        |   1 -
 tests/qemu-iotests/066                        |   1 -
 tests/qemu-iotests/067                        |   1 -
 tests/qemu-iotests/068                        |   1 -
 tests/qemu-iotests/069                        |   1 -
 tests/qemu-iotests/071                        |   1 -
 tests/qemu-iotests/072                        |   1 -
 tests/qemu-iotests/073                        |   1 -
 tests/qemu-iotests/079                        |   1 -
 tests/qemu-iotests/082                        |   1 -
 tests/qemu-iotests/085                        |   1 -
 tests/qemu-iotests/089                        |   1 -
 tests/qemu-iotests/090                        |   1 -
 tests/qemu-iotests/094                        |   1 -
 tests/qemu-iotests/095                        |   1 -
 tests/qemu-iotests/098                        |   1 -
 tests/qemu-iotests/102                        |   1 -
 tests/qemu-iotests/103                        |   1 -
 tests/qemu-iotests/104                        |   1 -
 tests/qemu-iotests/105                        |   1 -
 tests/qemu-iotests/107                        |   1 -
 tests/qemu-iotests/110                        |   1 -
 tests/qemu-iotests/111                        |   1 -
 tests/qemu-iotests/112                        |   1 -
 tests/qemu-iotests/114                        |   1 -
 tests/qemu-iotests/115                        |   1 -
 tests/qemu-iotests/117                        |   1 -
 tests/qemu-iotests/120                        |   1 -
 tests/qemu-iotests/125                        |   1 -
 tests/qemu-iotests/126                        |   1 -
 tests/qemu-iotests/127                        |   1 -
 tests/qemu-iotests/133                        |   1 -
 tests/qemu-iotests/134                        |   1 -
 tests/qemu-iotests/142                        |   1 -
 tests/qemu-iotests/143                        |   1 -
 tests/qemu-iotests/144                        |   1 -
 tests/qemu-iotests/145                        |   1 -
 tests/qemu-iotests/153                        |   1 -
 tests/qemu-iotests/156                        |   1 -
 tests/qemu-iotests/157                        |   1 -
 tests/qemu-iotests/158                        |   1 -
 tests/qemu-iotests/159                        |   1 -
 tests/qemu-iotests/162                        |   1 -
 tests/qemu-iotests/170                        |   1 -
 tests/qemu-iotests/173                        |   1 -
 tests/qemu-iotests/182                        |   1 -
 tests/qemu-iotests/183                        |   1 -
 tests/qemu-iotests/186                        |   1 -
 tests/qemu-iotests/187                        |   1 -
 tests/qemu-iotests/190                        |   1 -
 tests/qemu-iotests/191                        |   1 -
 tests/qemu-iotests/192                        |   1 -
 tests/qemu-iotests/195                        |   1 -
 tests/qemu-iotests/197                        |   1 -
 tests/qemu-iotests/200                        |   1 -
 tests/qemu-iotests/214                        |   1 -
 tests/qemu-iotests/215                        |   1 -
 tests/qemu-iotests/217                        |   1 -
 tests/qemu-iotests/227                        |   1 -
 tests/qemu-iotests/231                        |   1 -
 tests/qemu-iotests/233                        |   1 -
 tests/qemu-iotests/239                        |   2 +-
 tests/qemu-iotests/240                        |   3 +-
 tests/qemu-iotests/241                        |   2 +-
 tests/qemu-iotests/243                        |   2 +-
 tests/qemu-iotests/244                        |   2 +-
 tests/qemu-iotests/247                        |   1 -
 tests/qemu-iotests/check                      | 114 ++--
 tests/qemu-iotests/group                      | 177 +++---
 tests/tcg/Makefile                            |   1 +
 tests/tcg/aarch64/Makefile.softmmu-target     |  34 ++
 tests/tcg/aarch64/system/boot.S               | 239 ++++++++
 tests/tcg/aarch64/system/kernel.ld            |  24 +
 tests/tcg/alpha/Makefile.softmmu-target       |  32 ++
 tests/tcg/alpha/system/boot.S                 | 511 ++++++++++++++++++
 tests/tcg/alpha/system/kernel.ld              |  30 +
 tests/tcg/i386/Makefile.softmmu-target        |   4 +-
 tests/tcg/i386/system/memory.c                | 243 ---------
 tests/tcg/minilib/printf.c                    |   3 +
 .../multiarch/system/Makefile.softmmu-target  |  14 +
 tests/tcg/{i386 => multiarch}/system/hello.c  |   0
 tests/tcg/multiarch/system/memory.c           | 445 +++++++++++++++
 vl.c                                          |  23 +
 134 files changed, 1701 insertions(+), 501 deletions(-)
 create mode 100644 tests/docker/dockerfiles/ubuntu1804.docker
 delete mode 100755 tests/qemu-iotests-quick.sh
 create mode 100644 tests/tcg/aarch64/Makefile.softmmu-target
 create mode 100644 tests/tcg/aarch64/system/boot.S
 create mode 100644 tests/tcg/aarch64/system/kernel.ld
 create mode 100644 tests/tcg/alpha/Makefile.softmmu-target
 create mode 100644 tests/tcg/alpha/system/boot.S
 create mode 100644 tests/tcg/alpha/system/kernel.ld
 delete mode 100644 tests/tcg/i386/system/memory.c
 create mode 100644 tests/tcg/multiarch/system/Makefile.softmmu-target
 rename tests/tcg/{i386 => multiarch}/system/hello.c (100%)
 create mode 100644 tests/tcg/multiarch/system/memory.c

-- 
2.20.1


