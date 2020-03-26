Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B836C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 07:24:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71EBC20714
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 07:24:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71EBC20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHMsi-000668-Iy
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 03:24:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57113)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jHMs3-0005Ju-HS
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 03:24:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jHMs2-0007rw-DT
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 03:24:07 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:57415)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jHMs2-0007rb-5a
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 03:24:06 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N4yuK-1jPAt61IAu-010pzm; Thu, 26 Mar 2020 08:23:56 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 0/6] Linux user for 5.0 patches
Date: Thu, 26 Mar 2020 08:23:46 +0100
Message-Id: <20200326072352.2056553-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:q+9N6Ws1lMKgXf83wGqLeqojmG5PHJkth3J5bx+LtcUtjFbqd5Z
 AQWWhmaHCX8Pc25bHGgsKL1zlDIwAg+p1xyIg9Z1WWQow+FBbMAPw5yV0d697NPKtWgk3sD
 9TbRv1DKcayZfCi1vRsZpN1PDXTFuAsgb3Nb9g+8cG203XMaOfQejoGzOiPedpEVoHNqBhj
 wKMWdwoGJSCadVwax0CUg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BmOW5DDAf+c=:doPhIeXQng+l+emWA0V2px
 ixIXpljASNjdF3ygKgQsNN1UEDNRxnKXxxC49kk72Iz1lPLd++Y2VRH5ijHTlY3VvzqAo9pR9
 I0h6n7MgQosv7nK4XJCgF6pG2NQPAa29yd9D/lDDoLnE7abUXPHfrzo5MDdqDLXEqpWR7tR68
 WOBUkAHvs7M4EkSdMLhBk6KTjep2RfDbCbOAl20bykLmh0T+0FCH9bP8bUp/T6cX0wIv+GMyB
 lMlH3b1+9BaeSZeSi5f8silNmM0l9cfgPI/NdCDUPYGIyKhU/GLqUTpEzET5/HP5lgxBxRTFy
 ppPTq6Zm1uHIbf28c6Fa2byWxNXxzwOwgM74+ohQaNcAV+I/QQJhzh2/LDXhNSi0zGES0a76w
 T9GW/TV6UQdrlxEBN9s7QyhMQ3Y2KEe1kvtv/AePAAvhqYD+/c/okeHV61/OjH3rp9Ms778Vb
 DuSHctt54jBo7Sp+4DkI2ZsKcdsYXQk8zNZ2N8GpPduAdvjPFCagJUTIjf1DPFUIhDh8YrYDy
 orsena1N5pLJ51mAOwY77ifJKJ35Xp3g8F4Nc+5FZ8ATQrkwaLZVpIz2ZLrrbAVarU9CgbcFd
 SY8nLjtOsjNd2YutlInpytHrxkRQEg2KYyNG+rVsCleMFyLU4zOfZmT11gwQ4WgjDRP863cY3
 BQUx44CT+ZafZsr4PTQaDXm8QIq6v2v+p47JbmrVtAPoYeEmQPLPMJtdZcKsKD34/tRmHnsDA
 IXMBqxWDRj+q1sLV7OzNHS5RIIzUBsh7ycfPEU8UgkmQXh+eRa4jhLaeTEvpllR0TyXtPAY3/
 P8tdNl9CxwrE+nEBpGNLfuywTTHVC4oL+V9VuT8/7bmnX5aWKBS7ryfKPyJDVs2ZdmZrEIN
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.187
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

The following changes since commit 736cf607e40674776d752acc201f565723e86045:

  Update version for v5.0.0-rc0 release (2020-03-24 17:50:00 +0000)

are available in the Git repository at:

  git://github.com/vivier/qemu.git tags/linux-user-for-5.0-pull-request

for you to fetch changes up to a52f5f87bece827a338d6eb3332e3def86fb9c33:

  linux-user: Flush out implementation of gettimeofday (2020-03-26 08:08:54 +0100)

----------------------------------------------------------------
Emulate x86_64 vsyscalls
Fix syscall_nr.h cleanup

----------------------------------------------------------------

Laurent Vivier (1):
  linux-user, configure: fix (again) syscall_nr.h dependencies cleanup

Richard Henderson (5):
  target/i386: Renumber EXCP_SYSCALL
  linux-user/i386: Split out gen_signal
  linux-user/i386: Emulate x86_64 vsyscalls
  linux-user: Add x86_64 vsyscall page to /proc/self/maps
  linux-user: Flush out implementation of gettimeofday

 configure                  |   8 +-
 linux-user/i386/cpu_loop.c | 201 ++++++++++++++++++++++++++-----------
 linux-user/syscall.c       |  39 ++++++-
 target/i386/cpu.h          |  12 ++-
 target/i386/translate.c    |  14 ++-
 5 files changed, 205 insertions(+), 69 deletions(-)

-- 
2.25.1


