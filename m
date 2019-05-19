Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D36B7C04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 20:21:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93B0020657
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 20:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b4dvoEdb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93B0020657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52862 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSSJg-0006ru-Iz
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 16:21:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSHo-0005PH-99
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:20:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSHn-0007I1-4l
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:20:00 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:43739)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSSHm-0007Fp-Ti
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:19:59 -0400
Received: by mail-pg1-x543.google.com with SMTP id t22so5715966pgi.10
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 13:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id;
	bh=80lnl/T+XgF23R26O4LGwLUsUEXM9hE5duFY1wfldMU=;
	b=b4dvoEdbKlPh/BXaEmL2Y3BOkL7jrjJCQnwNCPlMyvqpflDh68I3TXJ2NE/b5kAIRC
	pqnFrGkSekIGxShzX4mDU/Y0xHR27wJrJTqsBFQHF8AhzIGHe4igfgIX94xQRWXZXeYv
	vYpOvYOkxGe0+nQTkDf7kevNOPU5oOy0MEt5yGGXHPKAwaP2yuPhuyZG+UK4bHUJSAuz
	/RT3hmU8V8oNkwn+LIuPtYxqvYCPb7SCWlpyEqDKObRChDtNIkm0T9ev3XoBfLy2ix9V
	IzciwAO1j8OurbNVZ1U7zukBJn6OpUHCKPf8xddYPTyqsVxiJpl1Zx3MwwXZnM2gDjzY
	408Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=80lnl/T+XgF23R26O4LGwLUsUEXM9hE5duFY1wfldMU=;
	b=hae36SHbliYdiNyXd+8LjXYubpEjwAyuPWeBjF5HhfBGZjlGnHqpHyoNvGqnNHiQua
	a4x7TQdCgng4tgsvZGUpP/B0d92X+SErFZHVZDbZgyLjaYyiphQweDeAzSaAnWbW2oML
	QTQw/tIjApjQzTuJDwh1ew6mTGbR/t/kAPSL2KncevYYMzmsvuopbfX/uvOHA9kSAqAf
	MCtJ9mv0IWxTUb65Cg8NRSclS5OHTWobl393FFDhubFg8pNRKweuaHMGInsKjryAOLRP
	Rt2e2AwMIgobr5Pd03CgJfyHccGzbnfbsCI75kZgWP8ORAMYRaJVVMDziuwZ/RCztQX4
	ffwg==
X-Gm-Message-State: APjAAAVWZvajiVB+GC+Dm5Fb8s9C1jFlfbOEbxnoqvbycNhe1AZHKd4C
	WqsxSLyyeXxBCXBiBMxAv6Cvb600gXs=
X-Google-Smtp-Source: APXvYqwFJw5QfcFv9IcAPoYze6lzaoAyc4LvDjm0+ScsCshnEeBg4ytRf4H3Xa2TxPufnQvtb6sf6A==
X-Received: by 2002:a62:fb18:: with SMTP id x24mr11222582pfm.76.1558297195822; 
	Sun, 19 May 2019 13:19:55 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	e14sm18166264pff.60.2019.05.19.13.19.54
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 13:19:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 19 May 2019 13:19:40 -0700
Message-Id: <20190519201953.20161-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: [Qemu-devel] [PATCH 00/13] linux-user: path, clone, sparc,
 shmat fixes
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
Cc: laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an omnibus patchset of:

  v2: util/path: Do not cache all filenames at startup
  https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg04149.html

  v1: linux-user: Fix shmat emulation by honoring host SHMLBA
  https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg03430.html

And a v3 update of

  v2: linux-user sparc fixes
  https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg02273.html


r~


Richard Henderson (13):
  util/path: Do not cache all filenames at startup
  linux-user: Rename cpu_clone_regs to cpu_clone_regs_child
  linux-user: Introduce cpu_clone_regs_parent
  linux-user/alpha: Set r20 secondary return value
  target/sparc: Define an enumeration for accessing env->regwptr
  linux-user/sparc: Use WREG constants in sparc/target_cpu.h
  linux-user/sparc: Use WREG constants in sparc/signal.c
  linux-user/sparc: Fix cpu_clone_regs
  linux-user/sparc: Flush register windows before clone/fork/vfork
  scripts/qemu-binfmt-conf: Update for sparc64
  tests/tcg/multiarch/linux-test: Fix error check for shmat
  linux-user: Fix shmat emulation by honoring host SHMLBA
  linux-user: Align mmap_find_vma to host page size

 linux-user/aarch64/target_cpu.h    |   6 +-
 linux-user/alpha/target_cpu.h      |   8 +-
 linux-user/arm/target_cpu.h        |   6 +-
 linux-user/cris/target_cpu.h       |   6 +-
 linux-user/hppa/target_cpu.h       |   6 +-
 linux-user/i386/target_cpu.h       |   6 +-
 linux-user/m68k/target_cpu.h       |   6 +-
 linux-user/microblaze/target_cpu.h |   6 +-
 linux-user/mips/target_cpu.h       |   6 +-
 linux-user/nios2/target_cpu.h      |   6 +-
 linux-user/openrisc/target_cpu.h   |   7 +-
 linux-user/ppc/target_cpu.h        |   6 +-
 linux-user/qemu.h                  |   2 +-
 linux-user/riscv/target_cpu.h      |   6 +-
 linux-user/s390x/target_cpu.h      |   6 +-
 linux-user/sh4/target_cpu.h        |   6 +-
 linux-user/sparc/target_cpu.h      |  45 ++++---
 linux-user/tilegx/target_cpu.h     |   6 +-
 linux-user/xtensa/target_cpu.h     |   7 +-
 target/sparc/cpu.h                 |  33 +++++
 linux-user/elfload.c               |  17 ++-
 linux-user/mmap.c                  |  76 ++++++-----
 linux-user/sparc/cpu_loop.c        |  12 ++
 linux-user/sparc/signal.c          |  96 +++++---------
 linux-user/syscall.c               |   9 +-
 tests/tcg/multiarch/linux-test.c   |   3 +-
 util/path.c                        | 201 +++++++----------------------
 scripts/qemu-binfmt-conf.sh        |   8 +-
 28 files changed, 309 insertions(+), 299 deletions(-)

-- 
2.17.1


