Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1EAC4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 18:43:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD762207FF
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 18:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u2gm+hiR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD762207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDYjU-0005rt-2N
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 14:43:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41909)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iDYcR-0007rw-Md
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 14:36:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iDYcP-0006M8-Lb
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 14:35:59 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:36894)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iDYcP-0006Ko-Cl
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 14:35:57 -0400
Received: by mail-wm1-x333.google.com with SMTP id f22so3635129wmc.2
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 11:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=NU6Z1UPCFOZjXjm4lnhTzfvXddIQ+qF4YX/RL1WrFx8=;
 b=u2gm+hiRlwLdPREvzHv3xSJCU2T7qqWqPG+6xzGkmwyfSpVp/Naldg7d0qwZM2f6q2
 SYjlauqTbhFXtvLeWf1VS24nu4YCbqma/w1ECGk01Sm/2Psx8PHtH/9MTnh+hMeU/ZY5
 h1BWo87Ut0/lqwAvaqYoZaEPUTnKsSQJnqp/AFnRzrd+2kepjeanwwvwW+d9twYL2U5u
 ebXsyPcSGl/6AuOl67cIetswsgAMGg7fUI8edJz/anE3oueqvbfoV/IJrc8iDnWnXAgK
 O6vk4umnz49XBaZDkFnMxTJfSaXOfDfHI3/3Q0sApdUb+lVA3Mx3z+p63pP4LRhCyELu
 nyRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=NU6Z1UPCFOZjXjm4lnhTzfvXddIQ+qF4YX/RL1WrFx8=;
 b=cRPT0fKcFf8VbV3U04jmqQ/UMeInjbe6gJ7UxyFPnrxKTMa7sFlnfPyZYbuACA4Rv9
 LFGgYeMYxV3XMOPFzbI9Zw2F6OC5d61hKB1sReJ5AbmUeUMtqSFQ2KwmpjsLeieZUSlK
 nxtnP+pyNSeDdBD34ARC7uNh4tnzgXMEJ/LyMqjt/CD95tbV8TbCxpeZrOyjeGQre3xm
 siG4+sp7WIOo6Cr76S4xTbLIlEW+BHVaC+t+gkHm6i5cHA1mMytOYs9x+VdKjU042Fas
 9dJdWs1mzBlGHrOefARpBp5yweTrLGPD/nw+cw09YvOgn2Zp567QSNHNpkUOF8truJnl
 8AGA==
X-Gm-Message-State: APjAAAWO2meRVCDYCkLUYXkht4uBTWMFXHfy8OTg2/NSxA37QsTgwByM
 bGOnWnJ/I0LickQHG8tksOaEWQ==
X-Google-Smtp-Source: APXvYqxrlr57/pvzPiLkU4/X3OzNbocdLwnWUaLAgtk26YoQGXaBlbsqw+jjIlK6SyKG1w2tuezRug==
X-Received: by 2002:a7b:caa9:: with SMTP id r9mr4394723wml.14.1569522956118;
 Thu, 26 Sep 2019 11:35:56 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q66sm6666331wme.39.2019.09.26.11.35.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2019 11:35:53 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3BE611FF87;
 Thu, 26 Sep 2019 19:35:53 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 00/28] testing updates (docker,podman,tcg,alpha)
Date: Thu, 26 Sep 2019 19:35:25 +0100
Message-Id: <20190926183553.13895-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::333
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

The following changes since commit eb13d1cf4a0478fc29f80abfbac8209479325f35:

  Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-20190925a' into staging (2019-09-26 14:23:58 +0100)

are available in the Git repository at:

  https://github.com/stsquad/qemu.git tags/pull-testing-next-260919-1

for you to fetch changes up to 80394ccf216da9ff48f23b9b8dab65ef809b7870:

  tests/docker: remove debian-powerpc-user-cross (2019-09-26 19:00:53 +0100)

----------------------------------------------------------------
Testing updates plus alpha FP fixes:

  - fix alpha handling of FtoI overflow
  - various docker cleanups
  - fix docker.py cleanup race
  - fix podman invocation
  - tests/tcg: add float and record/replay tests
  - remove unused docker images
  - expand documentation for check-tcg

----------------------------------------------------------------
Alex Bennée (11):
      target/ppc: fix signal delivery for ppc64abi32
      tests/docker: fix DOCKER_PARTIAL_IMAGES
      tests/docker: reduce scary warnings by cleaning up clean up
      tests/tcg: clean-up some comments after the de-tangling
      tests/tcg: re-enable linux-test for ppc64abi32
      tests/tcg: add float_madds test to multiarch
      tests/tcg: add generic version of float_convs
      tests/tcg: add simple record/replay smoke test for aarch64
      configure: preserve PKG_CONFIG for subdir builds
      docs/devel: add "check-tcg" to testing.rst
      tests/docker: remove debian-powerpc-user-cross

John Snow (9):
      tests/docker: add sanitizers back to clang build
      tests/docker: remove python2.7 from debian9-mxe
      podman: fix command invocation
      docker: remove debian8-mxe definitions
      docker: remove unused debian8 partial image
      docker: remove 'deprecated' image definitions
      docker: remove unused debian-ports
      docker: remove unused debian-sid
      docker: move tests from python2 to python3

Philippe Mathieu-Daudé (1):
      target/i386: Fix broken build with WHPX enabled

Richard Henderson (7):
      target/alpha: Use array for FPCR_DYN conversion
      target/alpha: Fix SWCR_MAP_UMZ
      target/alpha: Fix SWCR_TRAP_ENABLE_MASK
      target/alpha: Handle SWCR_MAP_DMZ earlier
      target/alpha: Write to fpcr_flush_to_zero once
      target/alpha: Mask IOV exception with INV for user-only
      target/alpha: Tidy helper_fp_exc_raise_s

 Makefile                                           |   6 +-
 configure                                          |   1 +
 docs/devel/testing.rst                             |  76 ++
 linux-user/ppc/signal.c                            |   4 +-
 target/alpha/fpu_helper.c                          |  15 +-
 target/alpha/helper.c                              |  64 +-
 target/i386/whpx-all.c                             |   1 +
 tests/docker/Makefile.include                      |  18 +-
 tests/docker/docker.py                             |  36 +-
 tests/docker/dockerfiles/centos7.docker            |   2 +-
 tests/docker/dockerfiles/debian-ports.docker       |  36 -
 .../dockerfiles/debian-powerpc-user-cross.docker   |  21 -
 tests/docker/dockerfiles/debian-sid.docker         |  35 -
 .../docker/dockerfiles/debian-xtensa-cross.docker  |   2 +-
 tests/docker/dockerfiles/debian10.docker           |   2 +-
 tests/docker/dockerfiles/debian8.docker            |  34 -
 tests/docker/dockerfiles/debian9-mxe.docker        |   3 +-
 tests/docker/dockerfiles/debian9.docker            |   2 +-
 tests/docker/dockerfiles/travis.docker             |   2 +-
 tests/docker/dockerfiles/ubuntu.docker             |   2 +-
 tests/docker/dockerfiles/ubuntu1804.docker         |   2 +-
 tests/docker/test-clang                            |   6 +-
 tests/tcg/Makefile.target                          |  16 +-
 tests/tcg/aarch64/Makefile.softmmu-target          |  21 +
 tests/tcg/aarch64/Makefile.target                  |   3 +-
 tests/tcg/aarch64/float_convs.ref                  | 748 ++++++++++++++++++++
 tests/tcg/aarch64/float_madds.ref                  | 768 +++++++++++++++++++++
 tests/tcg/arm/Makefile.target                      |  16 +-
 tests/tcg/arm/float_convs.ref                      | 748 ++++++++++++++++++++
 tests/tcg/arm/float_madds.ref                      | 768 +++++++++++++++++++++
 tests/tcg/multiarch/Makefile.target                |  23 +-
 tests/tcg/multiarch/float_convs.c                  | 105 +++
 tests/tcg/multiarch/float_helpers.c                | 230 ++++++
 tests/tcg/multiarch/float_helpers.h                |  26 +
 tests/tcg/multiarch/float_madds.c                  | 103 +++
 35 files changed, 3709 insertions(+), 236 deletions(-)
 delete mode 100644 tests/docker/dockerfiles/debian-ports.docker
 delete mode 100644 tests/docker/dockerfiles/debian-powerpc-user-cross.docker
 delete mode 100644 tests/docker/dockerfiles/debian-sid.docker
 delete mode 100644 tests/docker/dockerfiles/debian8.docker
 create mode 100755 tests/tcg/aarch64/float_convs.ref
 create mode 100644 tests/tcg/aarch64/float_madds.ref
 create mode 100644 tests/tcg/arm/float_convs.ref
 create mode 100644 tests/tcg/arm/float_madds.ref
 create mode 100644 tests/tcg/multiarch/float_convs.c
 create mode 100644 tests/tcg/multiarch/float_helpers.c
 create mode 100644 tests/tcg/multiarch/float_helpers.h
 create mode 100644 tests/tcg/multiarch/float_madds.c

--
2.20.1


