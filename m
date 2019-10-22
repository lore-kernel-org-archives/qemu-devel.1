Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99291CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 08:20:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D5D720684
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 08:20:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D5D720684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMpOp-0003LO-Eq
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 04:20:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44187)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iMpGH-0002kr-PV
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 04:11:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iMpGG-000553-DB
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 04:11:25 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:60857)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iMpGG-00054H-3g
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 04:11:24 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MQMdz-1ij9N41MjR-00MLc3; Tue, 22 Oct 2019 10:11:15 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 00/11] Linux user for 4.2 patches
Date: Tue, 22 Oct 2019 10:10:53 +0200
Message-Id: <20191022081104.11814-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:8Cxv3CfV13NkA0gKoj8HDv1GM7sQTO1C//jIJ1Pedsim07Y+V0+
 RZEvuQclXPtd9rxR+XOmOJIgtbAnc8eBK5rspusRqiUCxJ/YSmMy7yGxTGVTJ/GF1HijCaT
 6kmjHnaPJRHOBsx4vx6Z3THOvhU/sJ0DyjI3QSkEfTVFZSB51e9NVry86ske3oEPC92yUIk
 iXSFEEsTrMb3nUFkQD66A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:N0X7SOwmv3Y=:t36orZf8rOoShxc3QsUkGF
 CNAm1g6IRq4mwDoLLtP1X47cd2CGSBV1nrIrVYcAaxPRDPAaouPstzqICW8LiDUFrebB+HVwg
 fmBgk8oBCni0SnxoegvDWHZ79DvNNdwuFTHSsXxoNPKE3/Jbs7VP7tPMQqdnSRiDo4tbsnlAn
 Q4F2RfmHpoUCA24wWLH0KSFrMKgDL/Fb6X90wF7ZTfloXbI0mb9F5+BxuZSBzTbBOa7rJTw7s
 nLnbTXSblkIrzxvq9pdfdE0MSg57F7A98AvjgI8rzRObcQPajZBwVImHgCV1w4pNXF+rlf1Q2
 q38vVtyAe4RYCM3b5er55/cSbtsuHd89Jy364gRw8DQJhU4yxfa4znL+PUKlkXQNU8djk6oJe
 lWJur85kNaz2aJK8zUp0hLptJlkqKwQ8n6BSju3b8SrKg8y29kkZk+dbmPOK5cio+Gz+yIDLg
 OThJg0k4fXPBkrAmt0Nq2Y98ED3JyTV+KoAigNHK6gt92kZ9XRB/VKwwOjxe9qTwgjSrG4P2k
 VJnPWHVHv7PKroJZZQcSja4V+Y8KNXYqMvOe0spffDGdH1Wcsg+0RzwpU28XhYx9j6WxnPsiy
 gmiFEBvlOpC/k63VIDHzlrc/Sh13iL7OIjjtiXCJllrmYWFF3XIsaww3/msjHdovb61lUkNds
 JQMHBCpdS5xiyTyOIS2nHb2/BGjGxDkoP4/488sn3hDxW0/M8l8oFeohy2ZFIQwsjBarovjLF
 NRkYC+IbWb7hEuqVk55lbogLy50Ds9GI2i1u2kjJW/6VyAxod5OS7q+MhdVtFJ9kCvf7BqWs3
 2Z4HyBUzgD/2SCEKwyFa630Ex0NUBLAqulahVMjQDcH4yAqjzGVzjwlHWkqPynoJSDzRcFdu3
 RCJqwb7W9+yMf//AkBloyf60kgaBVa4rhfM0plVPw=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit e9d42461920f6f40f4d847a5ba18e90d095ed0b9:

  Merge remote-tracking branch 'remotes/kraxel/tags/audio-20191018-pull-request' into staging (2019-10-18 14:13:11 +0100)

are available in the Git repository at:

  git://github.com/vivier/qemu.git tags/linux-user-for-4.2-pull-request

for you to fetch changes up to 9a68960d8e7fdda16c2ea779a70f7f894ed2ce56:

  linux-user/syscall: Align target_sockaddr fields using ABI types (2019-10-21 15:37:04 +0200)

----------------------------------------------------------------
sockaddr alignment fixes, strace update and fd-trans fix.

----------------------------------------------------------------

Andreas Schwab (1):
  linux-user: add strace for dup3

Philippe Mathieu-Daudé (9):
  linux-user/strace: Display invalid pointer in print_timeval()
  linux-user/strace: Add print_timezone()
  linux-user/strace: Improve settimeofday()
  linux-user/syscall: Introduce target_sockaddr_nl
  linux-user/strace: Dump AF_NETLINK sockaddr content
  linux-user/strace: Add print_sockfd()
  linux-user/strace: Improve bind() output
  linux-user/strace: Let print_sockaddr() have a 'last' argument
  linux-user/syscall: Align target_sockaddr fields using ABI types

Shu-Chun Weng (1):
  Fix unsigned integer underflow in fd-trans.c

 linux-user/fd-trans.c     |  51 ++++++++++++----
 linux-user/strace.c       | 120 +++++++++++++++++++++++++++++++++-----
 linux-user/strace.list    |   7 ++-
 linux-user/syscall.c      |   6 +-
 linux-user/syscall_defs.h |  41 +++++++------
 5 files changed, 180 insertions(+), 45 deletions(-)

-- 
2.21.0


