Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93704C11D05
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 09:22:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6741720801
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 09:22:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6741720801
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4i2h-0005wO-IL
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 04:22:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51851)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j4i1a-0004CP-4a
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 04:21:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j4i1Z-0008BE-2u
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 04:21:38 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:56091)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1j4i1Y-0008AK-PE
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 04:21:37 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N1PLB-1jSiw719z9-012mF7; Thu, 20 Feb 2020 10:20:56 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 00/13] Linux user for 5.0 patches
Date: Thu, 20 Feb 2020 10:20:40 +0100
Message-Id: <20200220092053.1510215-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:08T70wEGxAgWTX2bD7kTnBFkT/wr0NtjfiuWvGRT+akwKkqrzh3
 r7N0bs4+pGujl+KJ3ouvVS4R6WiWk+ZqSZLlddMSe7k9Fl/aTp0qbBLuSZWQ9gyVD666wqt
 HRbqkEU1dAlspG4HFyb+zYCW7NUuCXdM5hw+h33Ol2YRd27vRiG6FBVn6KcVIty1diFKw37
 m4pX4TQr5KTgDCDoMCEBw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qyxhE3iSE2E=:oB+MHEdEkR16mzweyS5gI4
 u5OGz2FUNte1/BDI0pOkDmFxfqrrvFZqEoW6t7fBBrRqm103gBvdvF/2iE0tXiCpdPaSkjCMe
 6UjQULLan1vd/sjkCpSQUpIoaOdo50+6hUK931yyIHckYnc/tqq567jFMlOdt7CzMTX12nSaD
 8Ig2sMNlfqqtz6L1Xqy2YsnOog74eCkYke8aq3oL+j1bIOTC9P5TYi0ZOZBdbQJCiTvZZqLSe
 8fvKHDI5dp2DpRsuXTCwLmBz5AmIME/EGITIjFSFGBk+4HFVmpLYTyn56WWX4WFgKLW0Edyp7
 W5nKxzfcSFoXIo3Dr7s77oYDCLLwaKsQ+IzQ3ECjwGuWH9N9WyD0o3Pme3ajK5fMizY2YjRAu
 p+7+iQWIqKK0Ynx1C6L1KRJPKVrsQSotO9AFrgl40bj0LN2T9aj3c0FmPrwMX4KEMxe6yOrZo
 XmyQY77Vew/waTgp6551tF+spnbhVZSeDcREW71aw0ReF+b9iRfml54pCTLSVSmkA7akW2pQr
 JWuW0kp5hToX/lrhHUIh7CkVRRRNew6+QedsTr/XF/pUb1W0HkvVQxaOgrG4hXHX69dNvTnDi
 8A3NvZmaJ1LrsP09yEC4A21v76LPDIBhLmqFrgbvCs/kXDlWvcRWQJ1vNPBKmoO61caGkUs4D
 sw6L26NAxoUJB2XA8/7MixyoeTWW4HzRVkHW2EcmkbgmNFoSEpfm4tSwcVZyQNKyqxnBStVad
 sySjAqUxe5uT3PNefBSp/hsNWl+oBs3V+/SbZQvJQmanprvUy4esP972FVUhDgHs4uB06YEWj
 32lPWaDF6knP/rHauJFAeLtTD7CKLKp+R+UpDjlET4P+wSA4lpU/O19QDwMZFyCMPt+qzRa
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.75
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
Cc: Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 6c599282f8ab382fe59f03a6cae755b89561a7b3:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-monitor-2020-02-15-v2' into staging (2020-02-17 13:32:25 +0000)

are available in the Git repository at:

  git://github.com/vivier/qemu.git tags/linux-user-for-5.0-pull-request

for you to fetch changes up to 045823a98c30fbcafa6d6b61a28b284de7038f07:

  linux-user: Add support for selected alsa timer instructions using ioctls (2020-02-19 11:17:40 +0100)

----------------------------------------------------------------
Implement membarrier, SO_RCVTIMEO and SO_SNDTIMEO
Disable by default build of fdt, slirp and tools with linux-user
Improve strace and use qemu_log to send trace to a file
Add partial ALSA ioctl supports

----------------------------------------------------------------

Andreas Schwab (2):
  linux-user: Implement membarrier syscall
  linux-user: implement getsockopt SO_RCVTIMEO and SO_SNDTIMEO

Filip Bozuta (5):
  linux-user: Add support for getting alsa timer version and id
  linux-user: Add support for getting/setting specified alsa timer
    parameters using ioctls
  linux-user: Add support for selecting alsa timer using ioctl
  linux-user: Add support for getting/setting selected alsa timer
    parameters using ioctls
  linux-user: Add support for selected alsa timer instructions using
    ioctls

Helge Deller (1):
  linux-user/strace: Improve output of various syscalls

Josh Kunz (3):
  linux-user: Use `qemu_log' for non-strace logging
  linux-user: Use `qemu_log' for strace
  linux-user: remove gemu_log from the linux-user tree

Laurent Vivier (1):
  configure: linux-user doesn't need neither fdt nor slirp

Philippe Mathieu-Daudé (1):
  configure: Avoid compiling system tools on user build by default

 configure                  |  22 +-
 include/qemu/log.h         |   2 +
 linux-user/arm/cpu_loop.c  |   5 +-
 linux-user/fd-trans.c      |  55 +++--
 linux-user/ioctls.h        |  21 ++
 linux-user/main.c          |  39 +--
 linux-user/qemu.h          |   2 -
 linux-user/signal.c        |   2 +-
 linux-user/strace.c        | 479 +++++++++++++++++++------------------
 linux-user/strace.list     |  52 ++--
 linux-user/syscall.c       |  92 +++++--
 linux-user/syscall_defs.h  |  84 +++++++
 linux-user/syscall_types.h |  66 +++++
 linux-user/vm86.c          |   3 +-
 util/log.c                 |   2 +
 15 files changed, 600 insertions(+), 326 deletions(-)

-- 
2.24.1


