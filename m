Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15667C06513
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 15:29:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5529206A3
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 15:29:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5529206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiKiS-0003TH-5I
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 11:29:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58182)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hiKMY-0005Kt-Sm
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:06:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hiKMW-0007zu-P6
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:06:30 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:57517)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hiKMU-0007sG-P9
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:06:28 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MUobv-1i8LfH1FLN-00Qmpe; Tue, 02 Jul 2019 17:05:54 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Tue,  2 Jul 2019 17:05:39 +0200
Message-Id: <20190702150545.1872-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:YQw7hNLXUMgykzDKxcXR6ctB9IzpmKZ6YNTy0sE6ghpCIDB3bSC
 FTBZ22XQ87O4A2zB41vW5R1ARmL74rVNPGItO6/XD41kSlgdW2KIBhScwEHgUVI79ZWUtsz
 tZD+E4aNR445OHytDZd9wIE2yXEtqRCcZutOywvCQP6xWKJx8Ni3luPd7y147sgwjcvIVLQ
 VYUqsSzhyi9fLsXxjff+Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+DS28hWfJC0=:eznqPSwE3rFFG2B/Dz70q/
 QXGBrs1V1EGIXTcpLZIEId+k44XanqYhqoGiVo5Z5ZRcYsFwENC0J5LI9rwhafCFfCIMbJHLr
 RLr1tBgWd4nToHnTNYilPNaLNYQdp6VLL7NIkdfuywDywRjRAZg6YqvxzbmrKdz46VbhVUwed
 SdEU/EygMGvQm1HoR1QWIGuaVVxEMep2sY/BRkUDBtswk6gXLoYSrRmsN/c6cUyuN4VUyp55P
 O6yG5AHuHSYDNKHVhHIdUquod6QMsRkQB3Pit25tngU0mFJyhcA6WwXIiSf0ukp0/vqp11UTU
 7X2ukGZ8ofHAruiJrltZH2UxnPAoiDKUeI0kD/E8uy+EcNSJcvuFasYYHvgVApT2HPJ+ah7Va
 zVBsZwV409WKI6svSPXN6bfJw3eurNDX3n5OzC15ei70LOmi7VYshXN1DsYrympZx8HCvco30
 2mNePy8dsbIo+c6eFeDeUhIZzt5k/4+KbQoOO6b9Vmyrto+xkrUuyTJ06yEcVTsNilZa0dwF8
 QRzSqBkR6XPWuhcuY3gDyKqyBqDmWzwkFiMo0wNVfltHiVvJHA+FMLli4In42WbpbSgNWCxi0
 Xu01BzVemdfL5goGsd3JA+vHtItbFSyprteSCUFw2zVuIRYNWqhLixR7TYTiQ531GNSlqVl9k
 8O0fwLs0phSpVs3PCBUSogoMLD/KmIlHQGOD1LgxkMcOHJbt8Y4NKQyJVwJwnxiTGZWhI4h2L
 e1wE4Rz1RKeMOQ+uCfNpV3V4qpMX+1S8GsFgdw==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.74
Subject: [Qemu-devel] [PULL 0/6] Linux user for 4.1 patches
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 7d0e02405fc02a181319b1ab8681d2f72246b7c6:

  Merge remote-tracking branch 'remotes/vivier2/tags/trivial-patches-pull-request' into staging (2019-07-01 17:40:32 +0100)

are available in the Git repository at:

  git://github.com/vivier/qemu.git tags/linux-user-for-4.1-pull-request

for you to fetch changes up to 01154f792d254ae60a8a7ed6b363f1ed9a511204:

  linux-user: move QEMU_IFLA_BR_MULTI_BOOLOPT to the good function (2019-07-02 16:56:46 +0200)

----------------------------------------------------------------
Add statx
Fix netlink with IFLA_BR_MULTI_BOOLOPT
Fix mips (EXCP_FPE, struct flock)

----------------------------------------------------------------

Aleksandar Markovic (3):
  linux-user: Fix target_flock structure for MIPS O64 ABI
  linux-user: Introduce TARGET_HAVE_ARCH_STRUCT_FLOCK
  linux-user: Handle EXCP_FPE properly for MIPS

Aleksandar Rikalo (1):
  linux-user: Add support for translation of statx() syscall

Jim Wilson (1):
  linux-user: Add support for strace for statx() syscall

Laurent Vivier (1):
  linux-user: move QEMU_IFLA_BR_MULTI_BOOLOPT to the good function

 linux-user/fd-trans.c          |  12 ++--
 linux-user/generic/fcntl.h     |   8 ++-
 linux-user/mips/cpu_loop.c     |  17 +++++
 linux-user/mips/target_fcntl.h |  17 ++++-
 linux-user/strace.c            |  86 ++++++++++++++++++++++++
 linux-user/strace.list         |   3 +
 linux-user/syscall.c           | 115 ++++++++++++++++++++++++++++++++-
 linux-user/syscall_defs.h      |  37 +++++++++++
 8 files changed, 283 insertions(+), 12 deletions(-)

-- 
2.21.0


