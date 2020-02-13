Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF1DC2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 12:22:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B221F217F4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 12:22:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B221F217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2DVV-0007Ne-60
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 07:22:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39154)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j2DUe-0006Xn-Q0
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 07:21:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j2DUd-0003N1-TP
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 07:21:20 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:44373)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1j2DUd-0003Ml-KS
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 07:21:19 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N5VPe-1jZuQ90tju-016u68; Thu, 13 Feb 2020 13:21:11 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 0/5] Linux user for 5.0 patches
Date: Thu, 13 Feb 2020 13:21:03 +0100
Message-Id: <20200213122108.965455-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:3QvUa7020QDb70ZRgNAQsc/jmZfCgJiLmiksWyoaJZx3FvKAc0C
 42ePORjAuqiY1g4yecJZs8dtqlL3tb/WIWiIxi/sOl41GcbO+UOOu5RFSIYFMfhyFKsvItC
 FWqrEnqvk0EVol6qJjuHD4i/XVNE4NBADf2F3Mphm7nTgNxyCOGB7XipNoumNZAUUzPoH00
 Qx6nArZSZloMbmeKf+whA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aQeriiRiuBY=:vgOm9bcyO7pc4EFA2u03Xm
 Qb7p19apZYGcrjDcgXAzegK5/VM+5GeEHsucIslDHUTzTFqbQPdd099OFerW6n0fLu7guze5A
 gzyfEPoFrkpsCy3FmkVMXIFzI/mCf9qvYTH4PORVWGw2BbhjZnQ4AUCZyTdBXkuAcFkzbpZFX
 ftVmm2KPDpoNfvh9q5gK6WxekrvDXGV8K0zCBDwZd1ziYtphVW5TiDEOe2SgRq1IXZ2i4lUaH
 GLJaM+qTX4I5N4Yg2GFWIGpFCkzhP/hvxZWoTn/991/RRY8xlgXbzYxlzH5MnP7ia6I45JyZo
 f/HbjCJ3TyZXJJot/AxTl1mSlCMWqY11nYVgEYhE5LGHooh5pQ10x+li/WHfYlFuU7vTQCqTZ
 j0fLq6a6WgMYieA6C23PifF5jJJL1vaxx5AmGa0W5XpPirTPq4e2WGzFx7BPq6Q6G7/zCRWIK
 SrE73xO8dN9bVWm+JbY4umxrpnvsvRfZO+PETMfVmyuB1wMNljYKIdJvFKxe97AkSfM5RkoQg
 itiPJX5dNORrp64y0F2oPI4DKivTYjb7gmVXuzkc3InY+31EMzZf1ha801krIMfmuGzg5FHei
 ifEv7fcJDUt4Sdkzt0FTpQyKlaHYZSqWM42yHfoj7CTQ1KAnkvnY/aT57QkuDnbyP9wzbIV8V
 /iypkrNDe5rsyGJm8WQdB4/d2hkD9uJyub0InCInuviDTh6sDtRGlWlDbGzEOAmcfEj60aC0B
 vd7qQS/3gX3BnC5XhbmGWlGSPBKOyeffIVxOSXbr/uxCDhS319ixAoSe+oU/q6UOsIq4fp1Ru
 bjWjrt5w2AIWvyuvycXVfWm/wCOk/2d/gx/Grfu0u9UW7+Ebh6anGLUzxO3a4qF9wdWcd4x
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.135
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

The following changes since commit e18e5501d8ac692d32657a3e1ef545b14e72b730:

  Merge remote-tracking branch 'remotes/dgilbert-gitlab/tags/pull-virtiofs-20200210' into staging (2020-02-10 18:09:14 +0000)

are available in the Git repository at:

  git://github.com/vivier/qemu.git tags/linux-user-for-5.0-pull-request

for you to fetch changes up to 6d485a55d0cd8fbb8b4337b298f79ddb0c2a5511:

  linux-user: implement TARGET_SO_PEERSEC (2020-02-12 18:56:45 +0100)

----------------------------------------------------------------
Implement TARGET_SO_PEERSEC
Fix rt signals management

----------------------------------------------------------------

Laurent Vivier (5):
  linux-user: add missing TARGET_SIGRTMIN for hppa
  linux-user: cleanup signal.c
  linux-user: fix TARGET_NSIG and _NSIG uses
  linux-user: fix use of SIGRTMIN
  linux-user: implement TARGET_SO_PEERSEC

 linux-user/hppa/target_signal.h |   1 +
 linux-user/signal.c             | 134 ++++++++++++++++++++++++--------
 linux-user/syscall.c            |  22 ++++++
 linux-user/trace-events         |   3 +
 4 files changed, 128 insertions(+), 32 deletions(-)

-- 
2.24.1


