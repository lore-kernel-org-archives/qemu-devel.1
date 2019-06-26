Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE1EC48BD6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 12:19:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02C2A20663
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 12:18:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02C2A20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hg6t9-0002kg-4q
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 08:18:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49914)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hg6mV-0005bR-Gp
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 08:12:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hg6mT-0000pF-LD
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 08:12:07 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:38831)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hg6mT-0000ks-2q
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 08:12:05 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mwwhx-1iTybx303v-00yRfb; Wed, 26 Jun 2019 14:11:46 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Wed, 26 Jun 2019 14:11:33 +0200
Message-Id: <20190626121139.19114-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:QH7l5DQX0fRO2l5URhQSbZhxFdREoysWzCQeqAYZ171CyitzLL4
 vc3OMBEGZRduZUHj+MRcXXucsbuA06A1MCbnCd0o67pwIcOTnAWOK6iQlVq2+8p8N7QvhR0
 TPNT+BVcAS/3E24AZPkv2zLAzI8EJ2pydapZcgUnN++h45wfc6lkvvbM2L/3TW17aFtKcPc
 iKTS8EVNOOZ5AeT+sczgw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FDDWkivlT7s=:SeCdwTPdgYWsQVr4MYtD4D
 XCLwmKv+xiyMPXhF5c0EZZAHH+hSdXR3TetWCId7eT9W1cZfy54emfaocCpy0XYiOOdGD0GtX
 IfpYGXeSBbJ/KdKr4jcWCHZfttxEXTGI6coBjFUewCG+MgOYxPQy+Vx9ludKYSmXe+nT9FHJ5
 fIUo3iJ0H83yv0ZK5OOn9XMWQgy5f/XnmawdmS6sCOohQHIn1C5kscpaBtFhIXvsMzq3Q5oLt
 XkBSgpz/4VmBfdVfVSOytp0fB+lvKeWDOusjuiYNlrY3b0VQhAnQV8xTZGdWerXcNOsDiy9lL
 mAoi+Xo1gg/WNuLT275g9J3LgcTHohvoILNSJftmud2U38lkV8drqagUU0O2LDysa5cbEmEEI
 /COmBCxdakq/zgwjqLo58f/Cz+kejBjwo73xYviGVR/pS7bbcZbYOconHYiaCw7ls1Cipg2kZ
 FqUPpD7V+wmpDiK8QnX8NTuJAqRAxl97yGBVrJf9cacnVbv6P7B0RRdx4vWxfmBsL5hcW+dhn
 LDmUq1vyl1dHzTGYKPe0NZfHnVJDMzJMtislGxgoOc1t4J2ri/fyKIhxjaFdVhaMeB+nBCMi7
 OiIdX6nbwlkdWlOVTl5uqCrygKNY9h1qHXedfKWEkQ5NL3QeQaVyontyQCXHNNtN9ahXyAh9+
 iopKYQlYf1TRtnE5yQRggTw/FUD0IIqxD554kU5Ec8ToREerVQ2E06Yf9WVIVTH6KVobA8gyC
 CDufNGj64OJ2sJIhtYzci6a269ml285t82nOSCqN7zbqzVO0uY/FSSr3w04=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.73
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 474f3938d79ab36b9231c9ad3b5a9314c2aeacde:

  Merge remote-tracking branch 'remotes/amarkovic/tags/mips-queue-jun-21-2019' into staging (2019-06-21 15:40:50 +0100)

are available in the Git repository at:

  git://github.com/vivier/qemu.git tags/linux-user-for-4.1-pull-request

for you to fetch changes up to b50d1e42a4a7dc746ecd42c34c386d81a997759c:

  linux-user: set default PPC64 CPU (2019-06-24 23:10:36 +0200)

----------------------------------------------------------------
Update ppc64 feature and default CPU
next setsockops() options
Improve "-L" option
Another fix for 5.2-rc1 headers

----------------------------------------------------------------

Laurent Vivier (3):
  linux-user: emulate msgsnd(), msgrcv() and semtimedop()
  linux-user: update PPC64 HWCAP2 feature list
  linux-user: set default PPC64 CPU

Neng Chen (1):
  linux-user: Add support for setsockopt() options
    IPV6_<ADD|DROP>_MEMBERSHIP

Richard Henderson (1):
  util/path: Do not cache all filenames at startup

Yunqiang Su (1):
  linux-user: Add support for setsockopt() option SOL_ALG

 linux-user/elfload.c        |  12 ++-
 linux-user/ppc/target_elf.h |   2 +-
 linux-user/syscall.c        | 111 +++++++++++++++------
 linux-user/syscall_defs.h   |   1 +
 util/path.c                 | 193 ++++++++----------------------------
 5 files changed, 135 insertions(+), 184 deletions(-)

-- 
2.21.0


