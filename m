Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75ED1C5DF64
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 13:09:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46462217F4
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 13:09:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46462217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSL4M-0000Qv-85
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 08:09:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36402)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iSKzq-0003OD-PD
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 08:05:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iSKzp-0002tG-8a
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 08:05:14 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:45289)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iSKzo-0002rD-Ve
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 08:05:13 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MfpGL-1hzu0J1miv-00gG4i; Wed, 06 Nov 2019 14:05:06 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 00/13] Linux user for 4.2 patches
Date: Wed,  6 Nov 2019 14:04:43 +0100
Message-Id: <20191106130456.6176-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:x05mZ29kQ1uuTjcWeAP/byrXEB0ebit0Hryo+2nsEzM3TCo/rUN
 PYKMPfTwcwhh6zGRI1SFTllD5wcHyBD+CF1hCT9/5IJJxl44T0kvzXOMzyhd8nFvCEfhFJq
 j15a6jycJpApeNqrHaYWMe+1C8K/RNlfY1zgz+vVkGKrjpojJHlrO8Kx1OIpC9Qcv2jbpPg
 7o5sGVuqLKvx8mBv0FjWA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0K9CklFNdvI=:wKhFc/tyc1AuS763vAlCd3
 72RGFRDSH8euDSAvvp3VgMbbAUiyf5zt0wDzs8Yq+y6yYU4e63WN/6dzOmpwEd+wwqU5F1fVi
 sacQEK+4Y+qX2+SNjxSstiESNlztvKom3weHUbOq/PcP9zrAFeF8HXVki3lIGxJBdqNInlovT
 krZ5XP3E481uTbUVcZgFOKGh0bmWjta0ojnHvs/Js/aFitDvC007X8hgZLxIBcB/zVu6k9khq
 nOI8SWe/s7bH3vm79iMCF2cIhYCAl5cGka1WKTYVV/bO0PBsddT2FMp/HGpEdyz3vm0YrevKt
 2SVracjbdXU6iIFgVp08G7MXYLSa6yexkGUZy32qG3iqoFJPxxAKaG2jZDzdJCLXfeJGVBbcE
 n7nhutj4YBv+9SfaUSHQaYUA98qrfLkDtcFYJfcBPBrcDAwJs0KpREYCoc+k3+xj3Fvqk/kgI
 Dj8aMLGpbxtuhRZ3/uVLFAqG5VutNTLp8YfFJ56LTyO+ooRopJWnHLyCEdvtwifwg2fxVwVMc
 AV97A4YsQ8aP+i05FeT3zgCO2ZM1aPy2lgMl3u4/Lcdy9hQDJdkk+uDq/4HcQfXCW5lRQL+mt
 TozKqYsDvVeMPEpRFLdSJrjjeA/9ZhrAJRQJqpi1MQZJO8/AFb/tX50oHtQNUNFivBQHOdGFw
 pgG0HQbe2pu2FWi5fQex+fGWdt416U4VY2X7Q/wAhv0tthCY8NaPc/cPd0gMV0wOHMfcl49u8
 loJtmWgOw19/K7sZ1PjfjZd2y94ReAMCP15lmvMB04fD4uc8KsE0hh0S7egzIH0FaBMZSuHW6
 l3zsxPDUMbbFMiXR1BW9MW52mbbB/SoZG04QKlU9t/5NG9XaTkiNhNnBA6y3wzx6KNPrFLlUs
 xrvAv5LLg0k9GrUiB8S+1PUd7UELesY990X1T4R4c=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.131
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 36609b4fa36f0ac934874371874416f7533a5408:

  Merge remote-tracking branch 'remotes/palmer/tags/palmer-for-master-4.2-sf1' into staging (2019-11-02 17:59:03 +0000)

are available in the Git repository at:

  git://github.com/vivier/qemu.git tags/linux-user-for-4.2-pull-request

for you to fetch changes up to 5849dfe410b3fefec7d54a536cda7ccbf809ebea:

  linux-user/alpha: Set r20 secondary return value (2019-11-06 13:45:05 +0100)

----------------------------------------------------------------
sparc/sparc64 fixes: this doesn't fix debian chroot for me
but they are a step in the good direction.
Fix Netlink support.
Trivial fix for alpha

PULL v2: fix checkpatch warnings

----------------------------------------------------------------

Josh Kunz (1):
  linux-user: Support for NETLINK socket options

Richard Henderson (12):
  scripts/qemu-binfmt-conf: Update for sparc64
  tests/tcg/multiarch/linux-test: Fix error check for shmat
  target/sparc: Define an enumeration for accessing env->regwptr
  linux-user/sparc: Use WREG constants in sparc/target_cpu.h
  linux-user/sparc: Begin using WREG constants in sparc/signal.c
  linux-user/sparc: Use WREG_SP constant in sparc/signal.c
  linux-user/sparc: Fix WREG usage in setup_frame
  linux-user/sparc64: Fix target_signal_frame
  linux-user: Rename cpu_clone_regs to cpu_clone_regs_child
  linux-user: Introduce cpu_clone_regs_parent
  linux-user/sparc: Fix cpu_clone_regs_*
  linux-user/alpha: Set r20 secondary return value

 linux-user/aarch64/target_cpu.h    |   7 +-
 linux-user/alpha/target_cpu.h      |  16 ++++-
 linux-user/arm/target_cpu.h        |   7 +-
 linux-user/cris/target_cpu.h       |   7 +-
 linux-user/hppa/target_cpu.h       |   7 +-
 linux-user/i386/target_cpu.h       |   7 +-
 linux-user/m68k/target_cpu.h       |   7 +-
 linux-user/microblaze/target_cpu.h |   7 +-
 linux-user/mips/target_cpu.h       |   7 +-
 linux-user/nios2/target_cpu.h      |   7 +-
 linux-user/openrisc/target_cpu.h   |   8 ++-
 linux-user/ppc/target_cpu.h        |   7 +-
 linux-user/riscv/target_cpu.h      |   7 +-
 linux-user/s390x/target_cpu.h      |   7 +-
 linux-user/sh4/target_cpu.h        |   7 +-
 linux-user/sparc/signal.c          | 102 ++++++++++-----------------
 linux-user/sparc/target_cpu.h      |  60 +++++++++++-----
 linux-user/syscall.c               | 107 ++++++++++++++++++++++++++++-
 linux-user/tilegx/target_cpu.h     |   7 +-
 linux-user/xtensa/target_cpu.h     |   8 ++-
 scripts/qemu-binfmt-conf.sh        |   8 ++-
 target/sparc/cpu.h                 |  33 +++++++++
 tests/tcg/multiarch/linux-test.c   |   3 +-
 23 files changed, 338 insertions(+), 105 deletions(-)

-- 
2.21.0


