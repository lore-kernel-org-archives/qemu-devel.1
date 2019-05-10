Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D5BC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 07:18:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F01EF217D6
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 07:18:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F01EF217D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38174 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOznJ-0006yO-4M
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 03:18:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hOzlJ-0005gN-VD
	for qemu-devel@nongnu.org; Fri, 10 May 2019 03:16:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hOzlJ-0001dh-00
	for qemu-devel@nongnu.org; Fri, 10 May 2019 03:16:09 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:45147)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hOzlI-0001bm-N1
	for qemu-devel@nongnu.org; Fri, 10 May 2019 03:16:08 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA
	(Nemesis)
	id 1M1pk6-1hRCge1fYm-002ELL; Fri, 10 May 2019 09:16:04 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 09:15:50 +0200
Message-Id: <20190510071557.30126-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:9WKHpR0hUgsrUeFYUEUqjVVbAz07QbFDY/hvENBTRChxl2hvrPD
	hLjxta9bETVCCXXzDSuiAPo6u48J9ZwbXKcZ1/r9hxc34RwKV1zrgtFwUg32lGLVv7GvM0p
	QhJHtTBy4nXs6XFWH9ezNwLRKzXGCvjwWzKBZiXktNJb8ozUNoRrcwjXkmrtA2TbEdTt5HZ
	jd47MGFJYSSWHo4c/AE1w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:X7BvsSpMMa8=:Tnt1uoJVnmVkONZQ7ztvqr
	+GQvh7FpHWLnFAgTayaDx9nZ42RcgthTRnEsG1vRbD5mgE5br2aj32zOaKbX9YaeWaDl4sdtn
	andHKZPpEdIZTkHxPB+3BG5E7H5vtKn9kojy1pkWRn1LU9xCyfHe9ZaBj1MZoE48Vd23iN42m
	eswR4BqkLzq1jD9RzRiPr++lYX1JWPoTnpRnz2kqyTbUzAoX1hUO7VtQ4yPxDRoovqi81AoD/
	aBzWdVZ5G61c1tIVlta1dxR65XyAT9GYgDvywwqLDBDharnvh+LZnGJBka3QXLKTWqCiI84Sr
	w5CW7rahh4pkRf3je+uSt+bvR24sYSNaDhsgeaQUgjvltS6o3XqCpkthlnYnjineyr5iwO6Fs
	0PKzjvnTHMXwijwya66d2AcFkU0r40t4EnGLSQ2uRg0Hz5TrvQMQVNJ/zqA3gf1VybLCTHOFd
	rEpkoggWckrHdagZu3OPvOLx5O9fH0kP/ehnMpqj94VlIgyyxm9y1kbgSfBP9IKjCbpA8ltGo
	5MbynGUhg0muJUhh7V7tAVccNvQJ14odI4GZSl7Dpfa5b+xsqC+zBPIRUaDUygaZ6gcg48fGe
	9T6JUJEw8ZRFh2I6VVSBbBB8+O8IqBraHEMU+0TyvTvEwvja/xA3VMWez7Syc+WGFk1burjGP
	Hr7AfEtQ0QGxeVxB8Xb4VdKzbZMgWpPNesOYsSa2dJ1eJA0oYnCOVB2fxun/DV8AloBF/Rk84
	zt2bF66s9M7YWG15t2+rFbyqeBBShvvWMrW/R97TN+N1RbNv9llsn1ZbEpM=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.24
Subject: [Qemu-devel] [PULL 0/7] Linux user for 4.1 patches
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 68a7b9724fe80bedb85060bde605213ce3f9baec:

  Merge remote-tracking branch 'remotes/vivier2/tags/trivial-branch-pull-request' into staging (2019-05-09 13:36:10 +0100)

are available in the Git repository at:

  git://github.com/vivier/qemu.git tags/linux-user-for-4.1-pull-request

for you to fetch changes up to 6b333239ab1a4fa98f07f907f6268484a8514d1e:

  linux-user: fix GPROF build failure (2019-05-09 19:08:13 +0200)

----------------------------------------------------------------
GPROF fixes, GCC9 fixes, SIOCGIFNAME fix, new IPV6 sockopts, elf fix

----------------------------------------------------------------

Alex Bennée (2):
  linux-user: avoid treading on gprof's SIGPROF signals
  linux-user: fix GPROF build failure

Alistair Francis (1):
  linux-user/elfload: Fix GCC 9 build warnings

Daniel P. Berrangé (1):
  linux-user: avoid string truncation warnings in uname field copying

Erik Kline via Qemu-devel (1):
  The ioctl(SIOCGIFNAME) call requires a struct ifreq.

Giuseppe Musacchio (1):
  linux-user: elf: Map empty PT_LOAD segments

Helge Deller (1):
  linux-user: Add missing IPV6 sockopts

 linux-user/ioctls.h  |  2 +-
 linux-user/elfload.c | 20 +++++++++++++------
 linux-user/exit.c    |  3 +++
 linux-user/signal.c  |  5 +++++
 linux-user/syscall.c | 47 +++++++++++++++++++++++++++++++++++++++++---
 linux-user/uname.c   |  5 ++---
 6 files changed, 69 insertions(+), 13 deletions(-)

-- 
2.20.1


