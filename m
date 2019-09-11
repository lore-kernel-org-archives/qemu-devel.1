Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C3AECDE20
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 06:53:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 806DB21928
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 06:53:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 806DB21928
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7wVZ-0002MZ-21
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 02:53:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40779)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i7wRc-0005yA-6V
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 02:49:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i7wRb-0004LC-1m
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 02:49:36 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:57001)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1i7wRa-0004Kk-Ou
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 02:49:34 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M7am5-1i2hFB474f-0083eo; Wed, 11 Sep 2019 08:49:25 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Wed, 11 Sep 2019 08:49:05 +0200
Message-Id: <20190911064920.1718-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ET9Fhf23hWWQG05jzQq9tPboWcu/KmUT7+0EIsSMFdIrGd3RN40
 D8uLSzQqbI9zf5S782oF2LQ4W23fb0aHzSO4JNWewiZKgWVvR1iDvOgMUdmHvoCjMCBti37
 YFlFhQDof5fj1C2K8uriYFVdmI84ZXC0whsAELIdei7anpn7A/uLUBk9yEG3Apn+Cf2hvJz
 FpeSqytPH6w8xaT6GjXwg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ubbs7Yovh4w=:/6nZ3+PkpxvJDz64iBPl5p
 55NF9QgeH7i+N09fkw2Ei352BLCXFq75gNpAS7NWMDc1HkkDY1B/IUo7/PJs+aTHUZV/GMYx9
 Ckoo1HePMXewmQBEKit38ayKVu1qXUYpED7dfnVOvE0cl9Vwfh7pm9eMHk5+5AezJMPiB49U8
 zThyxC9o3kjhlou4TKHO20GHh/DzyaeVbkGUZTHgcbJjtqp3gabB3Ia6W94rM1gTtLQRjDPjD
 D+osNV91JKd8zd81YZQeVp9yElugKumDJpGINaZMhn2BafbkXUb4dDywSyXGnl6Sh87md0NY6
 nOP1wZGwH/wfni3y95D+v6YUVEIPNfbO6+Mf53twRHlvgCrnIWyPeXGOq8/Qz5W6IWNzGojit
 fKPo9tOi1cXS0t+iqZ8exYqeJbAdHbhz2GEUzKpL7ir5dDSuxkdk67ur3hJIRrffU/9cEF3cj
 +tTuBE3YHy2jesJZLPDJIKqfB6rvlaLzAql9TUCz7Rg5zB2Mla6BXfR0HTWCO+FngjJMrc8Os
 cPUy37VgZipwJ7u90AteQlXRk8YObl3VzTV830SHpUg6/r2jTehQGDXjtnHgUt1qZzoVzCw4O
 BL9UnoQZovMk/9sg5Ac0RZsAGp5mlwz23h9xrvlzqBeRx8VtzkXrJUdpi21c7eZVxkQZnIcZl
 RVdW1KzOvVN4oMR8kKTTe11sXUQBlGh1cb2V84hSDQ2CsSJDrSx9p0tOgtPL0Kgxu6my9FQyt
 kgz2xJspDiXAzaPTuZfUJ6/7RJQkFUdL42ba3HahOMyW9IAGU8sROyKt21SCa0G/cdAssZS9v
 szkwQntY63iRkBoqy9PC/x1SXITUwIu+wj8ZHNjb+nj1NqIYaI=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.131
Subject: [Qemu-devel] [PULL v2 00/15] Linux user for 4.2 patches
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
Cc: Max Filippov <jcmvbkbc@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 89ea03a7dc83ca36b670ba7f787802791fcb04b1:

  Merge remote-tracking branch 'remotes/huth-gitlab/tags/m68k-pull-2019-09-07' into staging (2019-09-09 09:48:34 +0100)

are available in the Git repository at:

  git://github.com/vivier/qemu.git tags/linux-user-for-4.2-pull-request

for you to fetch changes up to 5eea942900536b76ad13bef35e1d8f276566ae9e:

  linux-user: Add support for FDRESET, FDRAWCMD, FDTWADDLE, and FDEJECT ioctls (2019-09-11 08:47:06 +0200)

----------------------------------------------------------------
Add several floppy drive ioctl,
xtensa call0 ABI support, arm MAX_RESERVED_VA for M-profile,
aarch64 AT_HWCAP2, qOffsets' query for ELF, memfd_create,
and some code cleanup

----------------------------------------------------------------

Aleksandar Markovic (4):
  linux-user: Add support for RNDRESEEDCRNG ioctl
  linux-user: Add support for FIOGETOWN and FIOSETOWN ioctls
  linux-user: Add support for FDMSGON and FDMSGOFF ioctls
  linux-user: Add support for FDRESET, FDRAWCMD, FDTWADDLE, and FDEJECT
    ioctls

Alex Bennée (1):
  linux-user: fail and report on bad dfilter specs

Josh Kunz (1):
  linux-user: Support gdb 'qOffsets' query for ELF

Laurent Vivier (1):
  linux-user: remove useless variable

Max Filippov (2):
  target/xtensa: linux-user: add call0 ABI support
  linux-user: drop redundant handling of environment variables

Richard Henderson (3):
  linux-user: Add AT_HWCAP2 for aarch64-linux-user
  linux-user: Pass CPUState to MAX_RESERVED_VA
  linux-user/arm: Adjust MAX_RESERVED_VA for M-profile

Shu-Chun Weng (2):
  linux-user: erroneous fd_trans_unregister call
  linux-user: add memfd_create

YunQiang Su (1):
  linux-user: Add support for FDFLUSH ioctl

 include/qemu/memfd.h        |  4 +++
 linux-user/arm/target_cpu.h | 24 +++++++++++--
 linux-user/elfload.c        | 33 +++++++++++++++---
 linux-user/ioctls.h         | 13 +++++++
 linux-user/main.c           | 69 +++++++++++++++++++++----------------
 linux-user/syscall.c        | 14 +++++++-
 linux-user/syscall_defs.h   | 15 ++++++++
 linux-user/xtensa/signal.c  | 25 +++++++++-----
 target/xtensa/cpu.c         | 24 ++++++++++---
 target/xtensa/cpu.h         |  3 ++
 util/memfd.c                |  2 +-
 11 files changed, 175 insertions(+), 51 deletions(-)

-- 
2.21.0


