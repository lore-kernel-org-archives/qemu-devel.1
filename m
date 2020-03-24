Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 208C5C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 10:08:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA59720775
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 10:08:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA59720775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGgUI-000457-4U
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 06:08:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49434)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jGgP7-00061n-In
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 06:03:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jGgP6-0000cT-Ft
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 06:03:25 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:48227)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jGgP6-0000bi-6r
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 06:03:24 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MirfG-1jmQir2Mom-00ewQ6; Tue, 24 Mar 2020 11:03:13 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 0/5] Linux user for 5.0 patches
Date: Tue, 24 Mar 2020 11:03:06 +0100
Message-Id: <20200324100311.588288-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:bjuSqbtGItlidPKyowqFXtdu8MYmyM6HP3FYropXWkea31RkKBb
 4Pq5O+sP5wEq9h4WqPtW8oHSr5dXUmDPCOhkae2g/QO+861p4LRa63pfAI02sKL35BxjYpW
 ECsJ/JpG0zCTjTqnNuDACxesM/hKgJmInidmagcKRovX81qOWcP85CvkcpQQ2bnAmX+dEsZ
 U1t2yqa4coSPfheWDuKOQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7+qcXct3tzc=:CCGw2W0l7TBPU6y9GcdpyB
 frv3plfpb7w+8hUydXOJQQM7JeWKy8s7Kf+p/ajCpeSf3sJbQJPb8UEHfcp3b3e0cGQz4ggot
 zHr4RSJSLtucG0Szvni4/zJPeWRXOGu53NuUsz0//SHaKa4b6qQGmrcuKNgAsF8xWt+dMJVvF
 4UepFlamSJQ4lTJNMISFNSvshI7e4jEsv7pwnFgMU/O+Pm9eNMNk+lTbIpNlE/HT97Ztq35XQ
 bQcofahH1VXK3tzdTT61YpL3iQ1wxjfZKhNvX4uuX03OGHXJkTpRle90d11U7Wv95xFLR14+V
 dea65hzWxnQhdmixPENfr9xCn9GkFMkV6WUeyMS5MyjasAXGaNQ59ImKJrvFlYDC/U3dx8UNN
 itX6xVVRUHqk/35DmkeyYbw/DDeMogAs7RRuaBVeV2CRBz5ykYrlxn3miwTBbsFVNzmcnel6H
 TYJhT6C7adjggxe1mKu2UpUqripuKNqKxAPrwVKLAF1jJYcjv54GpuR0WJagIEa1BOVHny/n/
 oRm0YndRYhk/ygZdLaD4PYujDQQeSU26CFHF3YGplgUS1JlF72kZ8qrgeZFaSKBa3Pd3+PUpR
 vVtR4CvyQxWlBMYZnQ9f3qi1DGShqthzFcvA9EVr2Wjnr3wE6jPIXWfYzV5Palk5HnJTGd4rW
 NRVlq247y+khXCqSqUmK+OUViUKzNRVRTAstRZ4ZxjONNgZfKp3Gu7X6Zf+YmzJdm8NTEUk+V
 xphiqioJJ89ElWdoNPGklHYzXQQi1yJzRwYuEslZDpdcreesOYz92s/N4nBa+ogXXqXuMhXe6
 C/UtmEI2ub2LsJPV30DZBhjbKe1u8VFDE1mNjnbjIgaxgS5Rob2jxHXioCGcELpbiP+rOuv
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 29e0855c5af62bbb0b0b6fed792e004dad92ba95:

  Merge remote-tracking branch 'remotes/elmarco/tags/slirp-pull-request' into staging (2020-03-22 21:00:38 +0000)

are available in the Git repository at:

  git://github.com/vivier/qemu.git tags/linux-user-for-5.0-pull-request

for you to fetch changes up to 2582e3016c674c61abe38503c51fd8adffc0d0b3:

  linux-user: Flush out implementation of gettimeofday (2020-03-23 16:12:36 +0100)

----------------------------------------------------------------
Emulate x86_64 vsyscall

----------------------------------------------------------------

Richard Henderson (5):
  target/i386: Renumber EXCP_SYSCALL
  linux-user/i386: Split out gen_signal
  linux-user/i386: Emulate x86_64 vsyscalls
  linux-user: Add x86_64 vsyscall page to /proc/self/maps
  linux-user: Flush out implementation of gettimeofday

 linux-user/i386/cpu_loop.c | 201 ++++++++++++++++++++++++++-----------
 linux-user/syscall.c       |  39 ++++++-
 target/i386/cpu.h          |  12 ++-
 target/i386/translate.c    |  14 ++-
 4 files changed, 200 insertions(+), 66 deletions(-)

-- 
2.25.1


