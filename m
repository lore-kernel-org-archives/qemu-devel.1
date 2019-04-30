Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E88C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 17:15:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29A0D2064A
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 17:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fjcWf0JC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29A0D2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50469 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLWLR-0003Z3-Dk
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 13:15:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLW2K-00048d-N7
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:55:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLVzh-0000aG-Jw
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:52:38 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43726)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hLVzh-0000WQ-BQ
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:52:37 -0400
Received: by mail-wr1-x444.google.com with SMTP id a12so21813766wrq.10
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 09:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=ai3FU7j7ml2OSqg2io8dSlQktsIvFJmwS4hwlU31GgE=;
	b=fjcWf0JCIR7SpQmqtbxSZibvFYG6XQpGHVx6eZK3hL2DhF/lpQbGT+sYmJhoXks9xh
	GXSUUJyA2/a0IWSiK3arvRXZaf+62Mso6D2Ak3+cSX2rem3L/vS5NFQSabBFMtiNveJL
	CM6SQrwWGglfAMQfEvDino6aDCQ0hlWMEWKTwr/WKgKb/680G0iGgzlKVvTNYYPVOj0L
	2EBrGeN0F8BbQVFZo0mOQzzTfEN03KyPiBhw13VoD8NCaiRSqYDcXtCsl2xsQFpWH0nt
	jHAqTsjT03b2IL09PfLMknQjsVDsuAO6EK1K1435yJTjW907yolY80D2PbSKTEp0820E
	3uGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=ai3FU7j7ml2OSqg2io8dSlQktsIvFJmwS4hwlU31GgE=;
	b=YXoDl9cCRc4WhXB1mjl3aPVO/KKYc4wEf6ReKDGhCBEyCejQLXED5YvnHxKyD3YDuV
	+c+kjrZPSVXIFm/BZRoyNSgdYv6zEnCiArZGf/NEtrNVLEwg/rJJIWBI4CI7/0qhFg6s
	i3zvXJXhscJdR8O6dADDR0Ozz/ToxeAJZZSrRN6rpop3WrBKcfxlxv2NMabi57wbYsCv
	BGauJ9RgRMIb7anj1ejlPnnYf/f0yjx8Ejuto9Oe1eHSAiT+3NnAtnkzg6OfKexpeOWn
	6N2uH6Bwtt8HLWStkyL6W6X6Te+TeQZ/NiAB+3494wV3kNvWFE90lXQKPAwUnNDu9Rsu
	+nSg==
X-Gm-Message-State: APjAAAUJunH+4TZ/VCE8fhz8SX/oKUIn1pvF8YSAZl2cHjUgB+qCKKeS
	8iuIRkW3mZkezpe2ZZ4T2h16zA==
X-Google-Smtp-Source: APXvYqxPOQKH/rFYBn8FkbhxYSwNpp8bElwxp7sRTm1nXKN7eOTQc3Dpml+N1/BGmnP7+8c9Dq4q4g==
X-Received: by 2002:adf:b646:: with SMTP id i6mr6125322wre.12.1556643155486;
	Tue, 30 Apr 2019 09:52:35 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id q7sm3317414wmc.11.2019.04.30.09.52.34
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 30 Apr 2019 09:52:34 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 80C181FF87;
	Tue, 30 Apr 2019 17:52:34 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 30 Apr 2019 17:52:19 +0100
Message-Id: <20190430165234.32272-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH v5 00/15] demacro softmmu (plus tests/coverage)
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	qemu-arm@nongnu.org, mark.cave-ayland@ilande.co.uk, cota@braap.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430165219.jNQiNRW12Gb3L1rjphbEE6SVBKNZsUbwcDpX3BbaskQ@z>


Hi,

This is the latest iteration of the softmmu demacro series. The main
changes from the last submission are some updates from Richard. Some
are merged into the main demacro patch (mostly casting cleanups) and
then a series of 3 patches to out of line some of the less hot code to
keep the main access functions a reasonable size. For example:

  readelf -s aarch64-softmmu/accel/tcg/cputlb.o | ag helper |\
    ag -v atomic | ag mmu | tr -s ' ' | cut -d ' ' -f 4,9 | sort -n

Before:

  16 helper_be_ldsl_mmu
  16 helper_le_ldsl_mmu
  18 helper_be_ldsw_mmu
  18 helper_le_ldsw_mmu
  18 helper_ret_ldsb_mmu
  535 helper_ret_ldub_mmu
  556 helper_ret_ldb_cmmu
  586 helper_ret_stb_mmu
  679 helper_le_ldul_mmu
  681 helper_be_ldul_mmu
  685 helper_le_ldq_mmu
  688 helper_be_ldq_mmu
  688 helper_le_lduw_mmu
  693 helper_le_ldl_cmmu
  701 helper_le_ldq_cmmu
  701 helper_le_ldw_cmmu
  703 helper_be_ldl_cmmu
  704 helper_be_ldq_cmmu
  708 helper_be_lduw_mmu
  713 helper_be_ldw_cmmu
  943 helper_le_stw_mmu
  944 helper_le_stl_mmu
  952 helper_be_stl_mmu
  952 helper_le_stq_mmu
  959 helper_be_stw_mmu
  960 helper_be_stq_mmu

After:

  5 helper_be_ldul_mmu
  5 helper_be_lduw_mmu
  5 helper_le_ldul_mmu
  5 helper_le_lduw_mmu
  5 helper_ret_ldub_mmu
  14 helper_be_ldl_cmmu
  14 helper_be_ldw_cmmu
  14 helper_le_ldl_cmmu
  14 helper_le_ldw_cmmu
  16 helper_be_ldsl_mmu
  16 helper_le_ldsl_mmu
  18 helper_be_ldsw_mmu
  18 helper_le_ldsw_mmu
  18 helper_ret_ldsb_mmu
  783 helper_ret_stb_mmu
  785 helper_ret_ldb_cmmu
  881 helper_be_ldq_mmu
  881 helper_le_ldq_mmu
  889 helper_le_ldq_cmmu
  897 helper_be_ldq_cmmu
  1150 helper_be_stw_mmu
  1150 helper_le_stw_mmu
  1151 helper_be_stq_mmu
  1151 helper_le_stl_mmu
  1151 helper_le_stq_mmu
  1159 helper_be_stl_mmu

I've also moved the existing system memory test and made it multiarch
and added the bootstrapping for aarch64 system tests. I would like to
add support for Big Endian as well but I didn't want to delay the
posting of the series. It would also be nice to exercise the
ioread/write paths and other handling but I leave this as an exercise
for later.

There are also some minor tweaks for the code coverage reports now I'm
running with out-of-tree builds.

Alex Bennée (11):
  tests/tcg/multiarch: add support for multiarch system tests
  tests/tcg/multiarch: add hello world system test
  tests/tcg/aarch64: add system boot.S
  tests/tcg/multiarch: move the system memory test
  tests/tcg/minilib: support %c format char
  tests/tcg/multiarch: expand system memory test to cover more
  accel/tcg: demacro cputlb
  accel/tcg: remove softmmu_template.h
  Makefile: fix coverage-report reference to BUILD_DIR
  Makefile: include per-target build directories in coverage report
  Makefile.target: support per-target coverage reports

Richard Henderson (4):
  cputlb: Move TLB_RECHECK handling into load/store_helper
  cputlb: Drop attribute flatten
  cputlb: Do unaligned load recursion to outermost function
  cputlb: Do unaligned store recursion to outermost function

 Makefile                                      |   4 +-
 Makefile.target                               |  16 +
 accel/tcg/cputlb.c                            | 626 +++++++++++++++---
 accel/tcg/softmmu_template.h                  | 454 -------------
 tests/tcg/Makefile                            |   1 +
 tests/tcg/aarch64/Makefile.softmmu-target     |  32 +
 tests/tcg/aarch64/system/boot.S               | 200 ++++++
 tests/tcg/aarch64/system/kernel.ld            |  22 +
 tests/tcg/i386/Makefile.softmmu-target        |   2 +-
 tests/tcg/i386/system/memory.c                | 243 -------
 tests/tcg/minilib/printf.c                    |   6 +-
 .../multiarch/system/Makefile.softmmu-target  |  14 +
 tests/tcg/{i386 => multiarch}/system/hello.c  |   0
 tests/tcg/multiarch/system/memory.c           | 427 ++++++++++++
 14 files changed, 1267 insertions(+), 780 deletions(-)
 delete mode 100644 accel/tcg/softmmu_template.h
 create mode 100644 tests/tcg/aarch64/Makefile.softmmu-target
 create mode 100644 tests/tcg/aarch64/system/boot.S
 create mode 100644 tests/tcg/aarch64/system/kernel.ld
 delete mode 100644 tests/tcg/i386/system/memory.c
 create mode 100644 tests/tcg/multiarch/system/Makefile.softmmu-target
 rename tests/tcg/{i386 => multiarch}/system/hello.c (100%)
 create mode 100644 tests/tcg/multiarch/system/memory.c

-- 
2.20.1


