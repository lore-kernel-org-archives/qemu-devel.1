Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 018B8C48BD6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 16:42:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB7C020644
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 16:42:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB7C020644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgB0N-0006a6-VP
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 12:42:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58918)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hgAsL-0006MZ-5w
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 12:34:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hgAsK-0001R1-4W
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 12:34:25 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:51123)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hgAsJ-0001HA-RS
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 12:34:24 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MjjGX-1iPQdj2wmp-00lCGs; Wed, 26 Jun 2019 18:21:08 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Wed, 26 Jun 2019 18:20:57 +0200
Message-Id: <20190626162100.24774-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:vY8bPVBxri4FZS7L7dVW7hjI91XFPsMeDZ4jOM9qxD+st9JGaij
 G/AkRLIK8JIloinotAjLbRhmQQ989Mo1C5IcB0huLxRk9SLVo9PCgvIS/aQui8irhV7p818
 8s8Npd0T8RqaXuFbgmpDcfgroaQ34rWW8k9oYpXtFUxLdU082IkIyvnr9DdS8wokxWz+6Zi
 Kuu8Jo8bQtrlq5crzXZ2A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NsQp4/UU/Go=:1Kyd1iDgd3HvfRbOT2Vg2Q
 YRMGRMthseo1sAkrgtLy9o1RUD/V+9tdV5MeNkDzhC7RtKsZ6k/iY7y4Dc5BvjjTXk3Qr7Rw8
 Rb/ux4cjigKj15TmgvzVzUfkYJn5L8saUaq2u5bseWnhaSwshRlfMY2jO7B2dBZthmF1ampZN
 gs8MnfS9O8aGoOCQJPZEA/aeCrIawJ/90pIXj9wcfrp27qk3QP+U2UpAKdWJbg4SNSCYxUQ8r
 ncrCOvDwb6/pEkEaFR1jdbjSPL89pbpDuDbrSY4CjHyQVpwkb+qErblTZ/xTqvIsuBntEpLVp
 W+Ih415L0up3Q2xCBhP+lQj+GZ74qfZvdPzmEVxYYwEmFM/EJVVX4jYpUbOgSNnBfYWohf756
 WDG5wemk5YB1yOu/5RuYX1RwVk6GR34VXaHxge7bv7xDkDJFCD3pDpZYVh8T+pf4wu7tVyGjP
 oOhvAVFbJfz4ae6FreHb7E2UcZFG4aBraF7NldX0DT4tjHUGJvj9FTn9ll6/ifpQJVyHfXg8p
 J4OaT+lX4N2Vlp2eCwc/oQmZ8kA0JL1czL0GKXssDjDm5/HBvDb/Y+9Gmt8lzOUlJUgzGGAwr
 rTB/mMHegHQW6nzh35cwiq0DzGhLo6zzfHe21oZoXzirRnxLBINAfrZE1IYG0KGnHqxy0JX3C
 KAVO/dlKQ6CtQR1kkMoGkXMsTBbtr79yC0mhXyNpcYX90u8yFzBbHk/Sw5qDDqDGruz/TgUiI
 o3bcELENmrltqdoKsZXQJtLG4gWGt5TkxLVbYw==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.75
Subject: [Qemu-devel] [PULL 0/3] M68k next patches
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 474f3938d79ab36b9231c9ad3b5a9314c2aeacde:

  Merge remote-tracking branch 'remotes/amarkovic/tags/mips-queue-jun-21-2019' into staging (2019-06-21 15:40:50 +0100)

are available in the Git repository at:

  git://github.com/vivier/qemu-m68k.git tags/m68k-next-pull-request

for you to fetch changes up to c6d0700f57b2c50229a27e31b9f99056a011215f:

  linux-user/m68k: remove simulator syscall interface (2019-06-26 17:14:41 +0200)

----------------------------------------------------------------
remove m68k simulator syscall interface
Fix comments format
Fix gdbstub

----------------------------------------------------------------

Laurent Vivier (1):
  linux-user/m68k: remove simulator syscall interface

Lucien Murray-Pitts (2):
  The m68k gdbstub SR reg request doesnt include Condition-Codes
  m68k comments break patch submission due to being incorrectly
    formatted

 linux-user/Makefile.objs            |   1 -
 linux-user/m68k-sim.c               | 163 ------------------
 linux-user/m68k/cpu_loop.c          |  17 +-
 linux-user/m68k/target_syscall.h    |   2 -
 linux-user/qemu.h                   |   1 -
 target/m68k/cpu-qom.h               |   2 +-
 target/m68k/cpu.c                   |   6 +-
 target/m68k/cpu.h                   |  29 ++--
 target/m68k/fpu_helper.c            |   6 +-
 target/m68k/gdbstub.c               |   9 +-
 target/m68k/helper.c                |  16 +-
 target/m68k/m68k-semi.c             |  24 ++-
 target/m68k/op_helper.c             |  58 ++++---
 target/m68k/softfloat.c             | 181 ++++++++++----------
 target/m68k/softfloat.h             |   3 +-
 target/m68k/softfloat_fpsp_tables.h |   3 +-
 target/m68k/translate.c             | 246 ++++++++++++++++++----------
 17 files changed, 356 insertions(+), 411 deletions(-)
 delete mode 100644 linux-user/m68k-sim.c

-- 
2.21.0


