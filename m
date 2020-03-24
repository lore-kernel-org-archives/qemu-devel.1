Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63AA6C4332B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 11:18:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D71C20786
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 11:18:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D71C20786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGhZq-0003WI-Cd
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 07:18:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33413)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jGhYg-0002GE-KB
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 07:17:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jGhYb-0007LK-Q3
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 07:17:21 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:55765)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jGhYb-0007Kt-B9
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 07:17:17 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N2Dks-1jOhTy39ag-013b9l; Tue, 24 Mar 2020 12:17:04 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 0/5] Linux user for 5.0 patches
Date: Tue, 24 Mar 2020 12:16:55 +0100
Message-Id: <20200324111700.595531-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:qznmV2g8YRCcO50jvjcV9ZLIni+BUHhuHGZSEkwGwDz2zuYOZGW
 pxNB3B19Iro7r5SJfOMfreUM8Qlf4HzUxArsUWLff+PO33BaPiMeY5MWMhmxLQR5OzhHSEV
 qyIFBZjjgn3byCibluRT53J+cInksNlgnO7iblF2mkkhjiVC1+tv70E0+nIP/RwZ0uO6o2L
 fFjMvxe9sqx+DsTkSGo9g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FypmRvkL2wY=:qt+qHeBZ4SHOt+7gBqGidP
 NMf1iZ2EwYehHUd/Mg6wZmQTyw5HHSrAdu+whieMkYE8PxbJfx5wsh9hHX17BQah6RrW3lbRU
 zbXdl0k5jRcPc6SiaRKxBBpM510nfJRtg9jZkuUsZ5gy+WvXr7mV5F3/P1O3Xf2YBBrk4hi/x
 DzhqDkoa8Dd6J8k4VS1KFPhAYRbMnA9NhU8MdqQX02NmC/GInVqPJUNRE4m6TkgZUnAlMAvij
 qk6rcY4+gmC8LVWqNfmbw3Fa5slBsjLJDCAZgst2aKb5C054DMxnLPXfYCweGUqjuQqusC2u+
 EwBYoYeW3DY/ANR+iWBfpnrhZO9HBW0dYqWnsF7iqiZu9ubkclIDPQJnf5X4kJALVTv4Bt4kT
 Pauy9W23NcPM/9tBNdBjVOzmvkz503uWSK0Vc6zsYdxPp4sYkMQbOohNQ7p1KWmMCdOHxiEJR
 tdFqnr6ziXlf/V9v9RKfdQfpSf4LJ4UhrvSS/3A3wHKqKWW+uOorLJe2Umz8mKPkC7SHVPWpO
 muCYuQbSEPDG64vX0F6+j7Gty1XgS3OXnTf6xV61YWOtLsYA3d9ipZO69qIz0bF81vErCO9CO
 tLs1sjHdJMGsd8y9VPz3OELC26teAi4fDRpM/7gBQ5ZRjVK1TSvWzgOSwKntFHtp4QB/3FwIg
 rB30pAUZ+YGGE5Mw+rHB1rYiEAhZGMmgtTyLeKpfHbbiTdpDYT1GQsuS5Zl/yEMo24d81aN9k
 hmwWrWBm8lcMn0piPDThQmgq/crg1cfznjFfFgUi08r9TJovBTRYO+kL1hZC1JUwQJUMdWe5D
 XVkRulsrzb+BNrhxJ8a3DrGrGsFN9dciEf6mEfwmXtajptY41AnO0ROwD0B8z6cvnckFp+c
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

The following changes since commit 29e0855c5af62bbb0b0b6fed792e004dad92ba95:

  Merge remote-tracking branch 'remotes/elmarco/tags/slirp-pull-request' into staging (2020-03-22 21:00:38 +0000)

are available in the Git repository at:

  git://github.com/vivier/qemu.git tags/linux-user-for-5.0-pull-request

for you to fetch changes up to eec24827f7e67ead39349bb78597da566f854a4c:

  linux-user: Flush out implementation of gettimeofday (2020-03-24 12:04:14 +0100)

----------------------------------------------------------------
Emulate x86_64 vsyscall

v2: remove trailing space

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


