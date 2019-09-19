Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCCCDC3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 17:58:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85C2B21924
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 17:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ps7p3YIE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85C2B21924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB0ha-0006BY-G5
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 13:58:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50363)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iB07Q-0000JK-1H
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 13:21:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iAzwi-0004LA-1C
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 13:10:21 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:38236)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iAzwh-0004KY-PX
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 13:10:19 -0400
Received: by mail-wr1-x42b.google.com with SMTP id l11so3925235wrx.5
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 10:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=z91Lx/QMZCA2n7FlCOmHIE24eXvnavIFId/Uqa7chVE=;
 b=Ps7p3YIEzQC/uQTDAK87CMfjOjgfHu+NnUIHHht5Eyv2kQzU4CMvuYRRzXx+9BoibE
 XUaaS/ZTFkczdAE3/q75Tm1BlipCd6WthxYNyMxZoquRlgGwTEyYbRWiADrIs2FT0cy6
 iaZmj+OQ3xWxlmAm1PwH/J55TzxriewElmSEq/5+G6z0GSGf3D2r0T4Kc73u1dBL5P4o
 o4tTbIHNf1fCFYGyaUT+QA3GqG3SDZbT4fu2io0zlbGVixAM0PotdXe9bhl5Pr2o8txq
 y4BZYBdoyDHiULyVC6aiu6oa1jh7mZsWxmESDC3MBTA8FyRzXh042av+sk+7Ep40eZfl
 HejA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=z91Lx/QMZCA2n7FlCOmHIE24eXvnavIFId/Uqa7chVE=;
 b=Etp+b+077+TP9Xn/YU7kxJ+f3IWAie3j+ELR/Na2gPv7fgOhLJvHU7e+gw4ZVgTvue
 +1L8kbFg+ym2lH5PAwZNtTn1cNhhlZYdCxc+UPhn/1jK5YtF+2ewS1GRH14jVjUMUurv
 i4smPDfJJ+qQ8hBp6NdoIjoZ6mdgBDjq9GkfzxjDrSeF6Q7UpWebX4QNZA1233FBjpo2
 Y4knlLujuYTElnwm5797LRy3EPl+CNEGu1sEq59PqJsPc2rBGSufHBTgZvQQ+zEug6Cg
 CQUqYFJShyqT+jMDI3nOxY9+Ar/UFNoPLdnNdTj2xZJvTTUrvag+Eb4PsgT8+IYmMdFc
 vIRw==
X-Gm-Message-State: APjAAAUfcsBlqbdj65MO3fIjmiGw8Axhu2UdvicRF+0yGa/GLesyv8lT
 09n8s5gwc8PCCRvr4wQ1xP+Zfg==
X-Google-Smtp-Source: APXvYqwKZzCeIKCYeJpc10iAxFBzCGY1DAGY64tMJyRhnOMtYAJNFVi5duU5ls88B7cH85wknr7nvw==
X-Received: by 2002:a5d:628f:: with SMTP id k15mr7372749wru.124.1568913018598; 
 Thu, 19 Sep 2019 10:10:18 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d78sm8889200wmd.47.2019.09.19.10.10.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2019 10:10:16 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id ABF461FF87;
 Thu, 19 Sep 2019 18:10:15 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 00/16] testing/next (docker/podman, tcg, build fixes)
Date: Thu, 19 Sep 2019 18:09:59 +0100
Message-Id: <20190919171015.12681-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

This is the current status of the testing/next queue. It contains a
number of fixes for docker and podman as well as some additional tests
for floating point under TCG I've been experimenting with. With this
iteration I've also added some documentation for the check-tcg
command.

Since v1 there are some additional docker targets for WHPX builds from
Phillipe and a couple of fixes from me to try and get the CI back to
green. There is still an instability that I think was introduced in
the last set of migration patches which is making Travis very unstable
with lots of cancelled builds due to no output. David and I have been
able to replicate slow migration tests which may be the cause but as
of yet we don't have a fix.

As usual notes for individual fixes bellow the --- in the individual
patches.

The following patches need review
  04 - tests docker reduce scary warnings from failed in
  08 - tests tcg re enable linux test for ppc64abi32
  09 - tests tcg add float_madds test to multiarch
  10 - tests tcg add generic version of float_convs
  11 - tests tcg add simple record replay smoke test for
  14 - configure preserve PKG_CONFIG for subdir builds
  15 - docs devel add check tcg to testing.rst
  16 - Makefile fix up qemu ga.8 paths to take in src bu

Alex Bennée (11):
  tests/docker: fix DOCKER_PARTIAL_IMAGES
  tests/docker: reduce scary warnings from failed inspect
  target/ppc: fix signal delivery for ppc64abi32
  tests/tcg: clean-up some comments after the de-tangling
  tests/tcg: re-enable linux-test for ppc64abi32
  tests/tcg: add float_madds test to multiarch
  tests/tcg: add generic version of float_convs
  tests/tcg: add simple record/replay smoke test for aarch64
  configure: preserve PKG_CONFIG for subdir builds
  docs/devel: add "check-tcg" to testing.rst
  Makefile: fix-up qemu-ga.8 paths to take in-src builds into account

John Snow (3):
  tests/docker: add sanitizers back to clang build
  tests/docker: remove python2.7 from docker9-mxe
  podman: fix command invocation

Philippe Mathieu-Daudé (2):
  tests/docker: Add fedora-win10sdk-cross image
  .shippable.yml: Build WHPX enabled binaries

 .shippable.yml                                |   2 +
 Makefile                                      |  32 +-
 configure                                     |   1 +
 docs/devel/testing.rst                        |  62 ++
 linux-user/ppc/signal.c                       |   4 +-
 tests/docker/Makefile.include                 |   3 +-
 tests/docker/docker.py                        |  34 +-
 tests/docker/dockerfiles/debian9-mxe.docker   |   3 +-
 .../dockerfiles/fedora-win10sdk-cross.docker  |  21 +
 tests/docker/test-clang                       |   6 +-
 tests/tcg/Makefile.target                     |  16 +-
 tests/tcg/aarch64/Makefile.softmmu-target     |  21 +
 tests/tcg/aarch64/Makefile.target             |   3 +-
 tests/tcg/aarch64/float_convs.ref             | 748 +++++++++++++++++
 tests/tcg/aarch64/float_madds.ref             | 768 ++++++++++++++++++
 tests/tcg/arm/Makefile.target                 |  16 +-
 tests/tcg/arm/float_convs.ref                 | 748 +++++++++++++++++
 tests/tcg/arm/float_madds.ref                 | 768 ++++++++++++++++++
 tests/tcg/configure.sh                        |   1 +
 tests/tcg/multiarch/Makefile.target           |  23 +-
 tests/tcg/multiarch/float_convs.c             | 105 +++
 tests/tcg/multiarch/float_helpers.c           | 230 ++++++
 tests/tcg/multiarch/float_helpers.h           |  26 +
 tests/tcg/multiarch/float_madds.c             | 103 +++
 24 files changed, 3688 insertions(+), 56 deletions(-)
 create mode 100644 tests/docker/dockerfiles/fedora-win10sdk-cross.docker
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


