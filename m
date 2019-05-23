Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3194C282E1
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 10:27:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99D9E2133D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 10:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G5To9fk1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99D9E2133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33074 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTkwn-0006nK-Qc
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 06:27:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hTkut-0005Qa-Dq
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:25:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hTkuo-0000uc-0a
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:25:41 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:40274)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hTkul-0000qf-Sd
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:25:36 -0400
Received: by mail-wr1-x443.google.com with SMTP id f10so5657604wre.7
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 03:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=o9QeVVaANSkRPVE/lzeP8GOR0UaOCl88SpmnTYfV1Iw=;
	b=G5To9fk1/h4mMwOJ4mcXNjFUZl+rfqzXwViIX9MnMo5D//wXjFQUN1yc1BsRD78gEG
	GYf1AeT4vMVnIJHeQRUKXAiUyY8MgFstMKxIuYp2biUY0XSvn6fwrQDvqKb0ZW7bjb7v
	qwieNQujjeVsmyJVtbsV/JpR7bcHCbEu0SRWwCnyWx+Kb0IKIzWcBcGadoAUP8HY25qg
	T0FGLpTJdwtf5YFwNzeqU+uTIt09sGH0fRGb/VLZTNOu63h7XKJzQCsr30RWh7TXsLo7
	gywCUS+OBbSu60UnMuGGlirCUFiVI7d93VnDlRSg9za9bxP9T2p/7iuU1ffR0KxCGN+0
	HIhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=o9QeVVaANSkRPVE/lzeP8GOR0UaOCl88SpmnTYfV1Iw=;
	b=PPtLoeQd5g1nTJuR3LLFwyEQ/FBi2otMQnIHeOu0HGqwrOB9rZQZLTh7B0+/SPVOg9
	V0yfV8lAGDA4Zt3PA7UVSLpjyPFqnyQtWsuswJV9d22uDuDtQjzs/2eJVkX2/lC4rtZ9
	/HEySEl/0OTNhj7CnJou9YqGZOMbtIwu7AWSCGYGy3KMSfrKm6pDl5Qjt4UikLWF6WBN
	Kd/Y52X7ZhkY7WTYc/WLCaqAdig2K5DoMsKdJXpQa4/aaw2pmzKR0tWXKB17OnXYKUSW
	ZzfdNnMwUZnWY1k5ZNxSnEzdcx6tTInMLw4q3dAgjNasvKrzL5Bxeskjygd3bzeq3T7g
	vGaw==
X-Gm-Message-State: APjAAAXBoTdZmcGiZtYWO9KBKZt0zxZLCs5CHp0PNtZW4huakY6l0Tko
	GBwIoI/63SBzSM45ocYNJtjeI530mXw=
X-Google-Smtp-Source: APXvYqyuvDwwgvCwg7F36MI6ajc981jD8RK7NrCGvxdrLPIleH66JxHK9aGJwqN85eb8dpe6LCyA1w==
X-Received: by 2002:a5d:618b:: with SMTP id j11mr14908470wru.36.1558607133172; 
	Thu, 23 May 2019 03:25:33 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	t6sm16729133wmt.34.2019.05.23.03.25.32
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 23 May 2019 03:25:32 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 439631FF87;
	Thu, 23 May 2019 11:25:32 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 11:25:04 +0100
Message-Id: <20190523102532.10486-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH  v2 00/28] current testing/next queue
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

This is the current status of my testing/next tree. I had to delay
sending a PR as I refactored the semihosting changes (used by softmmu
tests) to be more generic. I've also addressed comments and merged in
Kevin's tweaks to the iotest check script.

The following patches still need review
 patch 0003/semihosting implement a semihosting console.patch
 patch 0004/semihosting enable chardev backed output for cons.patch
 patch 0006/target arm use the common interface for WRITE0 WR.patch
 patch 0017/tests tcg aarch64 add system boot.S.patch
 patch 0027/tests qemu iotests re format output to for make c.patch

Alex Bennée (23):
  semihosting: move semihosting configuration into its own directory
  semihosting: introduce CONFIG_SEMIHOSTING
  semihosting: implement a semihosting console
  semihosting: enable chardev backed output for console
  target/arm: fixup some of the commentary for arm-semi
  target/arm: use the common interface for WRITE0/WRITEC in arm-semi
  target/arm: add LOG_UNIMP messages to arm-semi
  target/arm: correct return values for WRITE/READ in arm-semi
  target/mips: only build mips-semi for softmmu
  target/mips: convert UHI_plog to use common semihosting code
  MAINTAINERS: update for semihostings new home
  tests/tcg/multiarch: add support for multiarch system tests
  tests/tcg/multiarch: add hello world system test
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

Thomas Huth (2):
  tests/qemu-iotests/group: Re-use the "auto" group for tests that can
    always run
  tests: Run the iotests during "make check" again

 .editorconfig                                 |   5 +
 .travis.yml                                   |   2 +-
 MAINTAINERS                                   |   8 +
 Makefile                                      |   4 +-
 Makefile.target                               |  16 +
 default-configs/arm-softmmu.mak               |   1 +
 default-configs/lm32-softmmu.mak              |   2 +
 default-configs/m68k-softmmu.mak              |   2 +
 default-configs/mips-softmmu-common.mak       |   1 +
 default-configs/nios2-softmmu.mak             |   2 +
 default-configs/xtensa-softmmu.mak            |   2 +
 gdbstub.c                                     |   7 +-
 hw/Kconfig                                    |   1 +
 hw/Makefile.objs                              |   1 +
 hw/mips/mips_malta.c                          |   2 +-
 hw/semihosting/Kconfig                        |   3 +
 hw/semihosting/Makefile.objs                  |   2 +
 hw/semihosting/config.c                       | 186 +++++++
 hw/semihosting/console.c                      |  77 +++
 include/exec/gdbstub.h                        |  11 +
 include/hw/semihosting/console.h              |  38 ++
 include/{exec => hw/semihosting}/semihost.h   |  17 +-
 include/sysemu/sysemu.h                       |   1 +
 linux-user/Makefile.objs                      |   2 +
 linux-user/arm/semihost.c                     |  24 +
 qemu-options.hx                               |   6 +-
 stubs/Makefile.objs                           |   1 +
 stubs/semihost.c                              |  70 +++
 target/arm/arm-semi.c                         |  98 ++--
 target/arm/helper.c                           |   2 +-
 target/arm/translate-a64.c                    |   2 +-
 target/arm/translate.c                        |   2 +-
 target/lm32/helper.c                          |   2 +-
 target/m68k/op_helper.c                       |   2 +-
 target/mips/Makefile.objs                     |   3 +-
 target/mips/helper.h                          |   2 +
 target/mips/mips-semi.c                       |  14 +-
 target/mips/translate.c                       |  10 +-
 target/nios2/helper.c                         |   2 +-
 target/xtensa/translate.c                     |   2 +-
 target/xtensa/xtensa-semi.c                   |   2 +-
 tests/Makefile.include                        |   8 +-
 tests/check-block.sh                          |  44 +-
 tests/docker/dockerfiles/fedora.docker        |   7 +
 tests/docker/dockerfiles/ubuntu1804.docker    |  57 ++
 tests/qemu-iotests-quick.sh                   |   8 -
 tests/qemu-iotests/check                      | 179 +++---
 tests/qemu-iotests/group                      | 177 +++---
 tests/tcg/Makefile                            |   1 +
 tests/tcg/aarch64/Makefile.softmmu-target     |  34 ++
 tests/tcg/aarch64/system/boot.S               | 239 ++++++++
 tests/tcg/aarch64/system/kernel.ld            |  24 +
 tests/tcg/alpha/Makefile.softmmu-target       |  34 ++
 tests/tcg/alpha/system/boot.S                 | 511 ++++++++++++++++++
 tests/tcg/alpha/system/kernel.ld              |  30 +
 tests/tcg/i386/Makefile.softmmu-target        |   4 +-
 tests/tcg/i386/system/memory.c                | 243 ---------
 tests/tcg/minilib/printf.c                    |   3 +
 .../multiarch/system/Makefile.softmmu-target  |  14 +
 tests/tcg/{i386 => multiarch}/system/hello.c  |   0
 tests/tcg/multiarch/system/memory.c           | 449 +++++++++++++++
 vl.c                                          | 128 +----
 62 files changed, 2226 insertions(+), 605 deletions(-)
 create mode 100644 hw/semihosting/Kconfig
 create mode 100644 hw/semihosting/Makefile.objs
 create mode 100644 hw/semihosting/config.c
 create mode 100644 hw/semihosting/console.c
 create mode 100644 include/hw/semihosting/console.h
 rename include/{exec => hw/semihosting}/semihost.h (78%)
 create mode 100644 linux-user/arm/semihost.c
 create mode 100644 stubs/semihost.c
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


