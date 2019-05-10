Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2868C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 10:47:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB212217D6
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 10:47:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB212217D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40956 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP34F-0000SB-3m
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 06:47:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hP32F-0007Ce-F5
	for qemu-devel@nongnu.org; Fri, 10 May 2019 06:45:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hP32E-0003Y0-K4
	for qemu-devel@nongnu.org; Fri, 10 May 2019 06:45:51 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:44049)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hP32E-0003XI-BD
	for qemu-devel@nongnu.org; Fri, 10 May 2019 06:45:50 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA
	(Nemesis)
	id 1M1rGy-1hRFxV1MJU-002CQV; Fri, 10 May 2019 12:45:41 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 12:45:29 +0200
Message-Id: <20190510104536.17483-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:JYW73IJ+lj+rMHJQvV7ka1Suk2Jv6pUx30fUcLseC9yUmQ9CxH1
	b+6DZc8TioB39W008rtvSZZO0R8jDaunAz5wOv1/x+t/1q24FzpslzPAbhA/fyu1IMPiJ1G
	2bZod33Emh/4x+RZ8z9t5a2x2nIu99KWlusKJL551Fjhl1YSZsCO9Nu6/WZz3TyaFM1PJmX
	+nEHwJkbXZofAWt3PT3Yg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zlFck5dwJSc=:0OwlCVpTtPbY2KawymZo/X
	woSjvk8aNnVxCTqGv1qABOiNQ/raI1gXCSaVKgopCXfUH3OPdqouKLeH6ZFDUubiC0HIaCuQE
	ab4i77VoOftFDozv3JRmCzs6cuB+WsS5ilEAya0VcBc3fGAYJttfGVLoetlZQaDn9fF3elQ0t
	Llt3YqAvGQTNUuS08gN+X52HZvfAPbrSxyibBIBZB30fUYUNCISr6NZ0a9TQQbs5jFw+gcHu+
	jL4T5kmGPESSlCoLjxshSiTRbMNGXvaQe2ljktcUwklbbzt4w/aPJDZqgUu0S5anoX0QLq91u
	Ifa+irCnb9H8Qr/sT93xwDJcOdJ275n4jIZgqKAivbUze2FXYfrNItyb4fIFM2xsza+DmjytN
	PiqcN2AyaZ9IedggeYAr3u3aZGxOmEkMe9nPp5xZrMGnAXfzybHJsgfP5oEZiDdWxdZdYeV2L
	qcPcc3SCrylWtIIMU86wQUFxSj2GPkcx21EeJ0uzcYHmFm/VINyVc91pXPfAGN5mo472BzUlU
	ks1gc6Ppsqitxvhzogr4VT34a5weaJVn1/pz+5muLQnZy1Om/tjkdIq3Bm8giMHHvB9R0CdIA
	LSEnHeHATf5U1RHuS+jmtaNfnNIKwhjgPiVsuJ2lAq3bOTc5/4Grd173CaPq8itL7cdUNkj1j
	VmFTwbmV+dEuQOlp5zRn0vqNpDB1tZFNWThNhmnoLVJAvh/mmiS+nVISA/GgY/ggG8+erk/4W
	AnC3BVsQhxRpLBaQ3+ZLYoRJql8jd4acwd9xYXNIBgf2icxUbz5mjE8r1Mw=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.133
Subject: [Qemu-devel] [PULL v2 0/7] Linux user for 4.1 patches
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

for you to fetch changes up to 9b21a36cd333f3f9a1acb379f5f4f4928ad84a06:

  linux-user: fix GPROF build failure (2019-05-10 12:44:23 +0200)

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

Erik Kline (1):
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


