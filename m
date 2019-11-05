Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37CF4C5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 18:13:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 164412190F
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 18:13:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 164412190F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS3KK-0007az-Mz
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 13:13:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51982)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iS3Il-0005lr-RP
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 13:11:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iS3Ik-0004d0-MN
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 13:11:35 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:45033)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iS3Ik-0004cV-D8
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 13:11:34 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N6bwO-1hsB6m2WAY-0180M3; Tue, 05 Nov 2019 19:11:26 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 00/13] Linux user for 4.2 patches
Date: Tue,  5 Nov 2019 19:11:06 +0100
Message-Id: <20191105181119.26779-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:QKCvYEVXABzYZAZtTYQrsgA/rm3jkTBL6q/9oqkV6b5mv51V9qq
 8odkyL1iP3X66v+bYSddjEcST4we2U1neRJG7nJTMArOi6Jh5Prfsnqp0ht+N5gyXvpQwyn
 CGFh/IPbOdrwCL9jeca0oSUrqWJz9IcaockGWgpQT45OtgkqIM9/y3yocTbB9JrHIp+Vuyp
 1Lmup9VTbx1bjBHwc6h4w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NF3bDRb4/Hk=:/s2WpDKdGSVL+ligjfLMQ4
 5EzgTCYN2oXS02t8I3L8k3k7x6cj3hnW0o+DkOq+zMmnfwEDGIvIb/D9rGRYqm215TifMsMXT
 7rLk7tdMCVauW0OBbvMMWO5lyrptHlgDv9vv7lF/ZwiVhmCoPFd4IiBagA45Edzm4gV4mPw+/
 W1OjdPNCSHb64E3mq1b/dwDl3AaeIFe/Zyf5D5iQujM6vYR6dZM8yQRNzI9vnWECyu2YE0W3P
 wcdFvvjkxLTK2wCn5OEpHTCZheWgouu46NDaaH7Lq5ZOn8v5PDciUwkgMDffAjms1b0wMJ999
 QaFPl2R2hZIOwNTvLDsc533jNKHSLr3RpSf0QxTVVgNPomIZ6gtqiE9d9G68q/lW/DIfXyUp3
 N/1Xo+ut65ZLXijqMyCzugvV5zNovm2MuXox5UftDKMbWt57Ev0KL8HJPAlAH6YAYYwpo5CRE
 aeypQdmn5a5E6fD9ONMLRqzqTSfASmBJ745XWGHwm0oYgZHMAX1MU2N9a/R1vSCSUJoGl3/dp
 /UbmawO/Bk9tpKjGGKK3OI+9VjK8Lakm8VYJkJFRRgtw388rrnZqr04K0QlEUrcEc+FCPWJ1t
 YBB0uaz97FLi628uPkrOVGzWU27Y3wcW4SfwsNcVz5j3ABUGChyBR/6Uv4kTo0aFP4KhKUJ6Q
 aIY842LNwZDIeLNY2XBj/abbSST0yvC+0jzbuJMZ9mzN/BAYRWbsv+OMnZuXFu1N9E5IZt3DV
 zkkfDFO9Q3qFjQkXAzG9bQUedra/80Z3/8sY33NjaJyzTzIGQ6W7TCQjahprPVJP1AjXvTc1G
 F1mZM0+YAOxUZ7gKH6J18S1P6eqvmjANBELKk/XaRlVwSiGg9/M59jqUu1j9aWWLTWPdzLOr9
 7nTUc4RP2GUfsjfUi9iKKSJP2ThKmzbxH5KlmxM0Y=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.17.10
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
 Riku Voipio <riku.voipio@iki.fi>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>, Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 36609b4fa36f0ac934874371874416f7533a5408:

  Merge remote-tracking branch 'remotes/palmer/tags/palmer-for-master-4.2-sf1' into staging (2019-11-02 17:59:03 +0000)

are available in the Git repository at:

  git://github.com/vivier/qemu.git tags/linux-user-for-4.2-pull-request

for you to fetch changes up to bbba2b13799d3220f1f1d84bbaed3f916215fca5:

  linux-user/alpha: Set r20 secondary return value (2019-11-05 10:53:55 +0100)

----------------------------------------------------------------
sparc/sparc64 fixes: this doesn't fix debian chroot for me
but they are a step in the good direction.
Fix Netlink support.
Trivial fix for alpha

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


