Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E9F2C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 21:06:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29A1F20872
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 21:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CDK25Xtu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29A1F20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCs13-0006WC-95
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 17:06:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55500)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iCrw0-0002XS-S5
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:01:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iCrvy-0004Te-AW
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:01:20 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:53492)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iCrvs-0004S2-Nm
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:01:14 -0400
Received: by mail-wm1-x32e.google.com with SMTP id i16so1872257wmd.3
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 14:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ySt7pD/3SmllFAju7l+MsS0NBMMOjjhxPQBaWQ/I4tE=;
 b=CDK25Xtua8Jt8Er6Wea3BjoCq5V6lQuPxctGFturhp5AM/Dw2jxL6E15jwKiW2LFSn
 l1gfb99UCbmPhdlZsy51m94kRrsjzPEDfyyWZ5cWmVsx2Y7Nm5spyc/DoTtSFFda6asl
 VDIyrE4K0LV+w7XvU0hXuoyzVv6O0pSUln0Dv9t4dyuuhfZD6NxFFOIeyX8UCizRr4ff
 nzGSwCBHj9PnPDncUi9iKKZQ+JgFtRUvKtdloBvINKjdtAMRS2FrnPtoaEJ/n2bxBD/Y
 4OEbYGhQhYIxGBIxkHqVIvsy6l5UI/lZg15UIZCbBwGEAFgs/ruq7tpQAsRu3oc41wWU
 HNFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ySt7pD/3SmllFAju7l+MsS0NBMMOjjhxPQBaWQ/I4tE=;
 b=FKUc6qOlT4P1aJ0/vkVGVlChBrHzg2QT7xt3D5Dl8x0lX1gguzE+O3o0MR89hlBmqJ
 ghDfYDvgG9woh3xCyedz9H/jqeB2V0ABU8NfeQTcm5K7lxkX37y+V/7jQE2sixX4E+Wl
 m/8o8XXg6y5rVkUfbDzAEUakh5bmu1mlvSptxJmckX+TIl+t2MQwUJS5xEAg6/qBiZjN
 MzmMGnj2joJb4y/yqT/+2KyTI3mvVk30Uq/Xj9zH9Xcjm8H57kfH653PcfIrwK10MInb
 f27V+91lTsC4jFyHfJJqQBDveF2KJwxm502PcQShpH8c7Dl8TOxFnc9evya2i9kGdcGw
 obiA==
X-Gm-Message-State: APjAAAVhhCvLEVVXe7ieHhgFdT1S2wo+vlrCkWXQDlU1vutjFmDoAQSh
 nQHsmrtWJse0FI/4uhhPBWtoWA==
X-Google-Smtp-Source: APXvYqwWM3zOFp+/bZcxeMHb+7hJ9U+zIFYI8QB4TH5S+F7WycAzv6JvULkYgJWgh4REK1x/Jn4aVg==
X-Received: by 2002:a1c:4e01:: with SMTP id g1mr2381011wmh.134.1569358869404; 
 Tue, 24 Sep 2019 14:01:09 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z6sm2015595wro.16.2019.09.24.14.01.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2019 14:01:07 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DA2B61FF87;
 Tue, 24 Sep 2019 22:01:06 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v3 00/33] testing/next (docker,tcg, alpha ;-)
Date: Tue, 24 Sep 2019 22:00:33 +0100
Message-Id: <20190924210106.27117-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32e
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, jsnow@redhat.com,
 f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

This should be the final iteration of the current testing/next queue
before I send the Pull Request. Currently it contains some fixes from
both David and Richard for migration and alpha respectively. I'm
assuming David will get his PR in before I send mine but Richard is
happy for me to merge the alpha changes.

I've included the latest iteration of Jon's docker cleanups. There is
also another attempt at reducing the warnings from docker due to the
race between inspect and rm. Whilst digging into that I think I've
also fixed another race caused by shared uuids while running very
parallel builds.

I also finally killed the powerpc-user-cross image which was still
causing problems when trying to run all the test builds. I could have
used the PARTIAL_IMAGE hack but then it would only been useful for
testcases and we already have a nice cross compiler for those.

The following patches need review
   15 - tests docker reduce scary warnings by cleaning up
   18 - tests tcg re enable linux test for ppc64abi32
   21 - tests tcg add simple record replay smoke test for
   23 - docs devel add check tcg to testing.rst
   33 - tests docker remove debian powerpc user cross

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

Dr. David Alan Gilbert (3):
  tests/migration: Fail on unexpected migration states
  tests/migration/postcopy: trim migration bandwidth
  migration/postcopy: Recognise the recovery states as 'in_postcopy'

John Snow (9):
  tests/docker: add sanitizers back to clang build
  tests/docker: remove python2.7 from debian9-mxe
  podman: fix command invocation
  docker: remove debian8-mxe definitions
  docker: removed unused debian8 partial image
  docker: remove 'deprecated' image definitions
  docker: remove unused debian-ports
  docker: remove unused debian-sid
  docker: move tests from python2 to python3

Philippe Mathieu-Daudé (3):
  target/i386: Fix broken build with WHPX enabled
  tests/docker: Add fedora-win10sdk-cross image
  .shippable.yml: Build WHPX enabled binaries

Richard Henderson (7):
  target/alpha: Use array for FPCR_DYN conversion
  target/alpha: Fix SWCR_MAP_UMZ
  target/alpha: Fix SWCR_TRAP_ENABLE_MASK
  target/alpha: Handle SWCR_MAP_DMZ earlier
  target/alpha: Write to fpcr_flush_to_zero once
  target/alpha: Mask IOV exception with INV for user-only
  target/alpha: Tidy helper_fp_exc_raise_s

 .shippable.yml                                |   2 +
 Makefile                                      |   6 +-
 configure                                     |   1 +
 docs/devel/testing.rst                        |  62 ++
 linux-user/ppc/signal.c                       |   4 +-
 migration/migration.c                         |   9 +-
 target/alpha/fpu_helper.c                     |  15 +-
 target/alpha/helper.c                         |  64 +-
 target/i386/whpx-all.c                        |   1 +
 tests/docker/Makefile.include                 |  20 +-
 tests/docker/docker.py                        |  36 +-
 tests/docker/dockerfiles/centos7.docker       |   2 +-
 tests/docker/dockerfiles/debian-ports.docker  |  36 -
 .../debian-powerpc-user-cross.docker          |  21 -
 tests/docker/dockerfiles/debian-sid.docker    |  35 -
 .../dockerfiles/debian-xtensa-cross.docker    |   2 +-
 tests/docker/dockerfiles/debian10.docker      |   2 +-
 tests/docker/dockerfiles/debian8.docker       |  34 -
 tests/docker/dockerfiles/debian9-mxe.docker   |   3 +-
 tests/docker/dockerfiles/debian9.docker       |   2 +-
 .../dockerfiles/fedora-win10sdk-cross.docker  |  23 +
 tests/docker/dockerfiles/travis.docker        |   2 +-
 tests/docker/dockerfiles/ubuntu.docker        |   2 +-
 tests/docker/dockerfiles/ubuntu1804.docker    |   2 +-
 tests/docker/dockerfiles/win10sdk-dl.sh       |  27 +
 tests/docker/test-clang                       |   6 +-
 tests/migration-test.c                        |  25 +-
 tests/tcg/Makefile.target                     |  16 +-
 tests/tcg/aarch64/Makefile.softmmu-target     |  21 +
 tests/tcg/aarch64/Makefile.target             |   3 +-
 tests/tcg/aarch64/float_convs.ref             | 748 +++++++++++++++++
 tests/tcg/aarch64/float_madds.ref             | 768 ++++++++++++++++++
 tests/tcg/arm/Makefile.target                 |  16 +-
 tests/tcg/arm/float_convs.ref                 | 748 +++++++++++++++++
 tests/tcg/arm/float_madds.ref                 | 768 ++++++++++++++++++
 tests/tcg/multiarch/Makefile.target           |  23 +-
 tests/tcg/multiarch/float_convs.c             | 105 +++
 tests/tcg/multiarch/float_helpers.c           | 230 ++++++
 tests/tcg/multiarch/float_helpers.h           |  26 +
 tests/tcg/multiarch/float_madds.c             | 103 +++
 40 files changed, 3775 insertions(+), 244 deletions(-)
 delete mode 100644 tests/docker/dockerfiles/debian-ports.docker
 delete mode 100644 tests/docker/dockerfiles/debian-powerpc-user-cross.docker
 delete mode 100644 tests/docker/dockerfiles/debian-sid.docker
 delete mode 100644 tests/docker/dockerfiles/debian8.docker
 create mode 100644 tests/docker/dockerfiles/fedora-win10sdk-cross.docker
 create mode 100755 tests/docker/dockerfiles/win10sdk-dl.sh
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


