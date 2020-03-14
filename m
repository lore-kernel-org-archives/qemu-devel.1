Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B10C0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 11:42:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77FF52076E
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 11:42:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77FF52076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jD5BW-0007Tk-E5
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 07:42:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53667)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jD58r-00043b-Db
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 07:39:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jD58q-00059b-4q
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 07:39:45 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:52513)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jD58p-00053A-Rp
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 07:39:44 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Myb8P-1jVsfr0Iu5-00z2QN; Sat, 14 Mar 2020 12:39:26 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/4] linux-user: generate syscall_nr.h from linux unistd.h
Date: Sat, 14 Mar 2020 12:39:18 +0100
Message-Id: <20200314113922.233353-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:sVlwDNYH4MsAz7mLutowi/qy0p1hd95PpvtUxzZ5yUxpU1DVtNj
 7rlV8ZPUf4gP10AdyB49qjFqp0S4Sp81a+GOyPA6IOaCb6NKJ5Fo3P128b1hlJBzqWrvq3S
 Ak3GWQG3Mv5E2JM1L5wZY3DtVOTQFSCBLNukp3yS6LHhWvrUsxqhW5IuKWPR4/rx4CWENRm
 DDdC6L6EfFTHeu/9fT+OQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nKeczkALNUQ=:AhmqT2FttC2dpPC0qKvCrB
 zrYrMPSxvFvND1Y++0LG9wCz+K7d0pqYf19CMPBZ+MuUd+8EJ5L7KHrnjv3iNNSHKetbRMDD/
 z783Y+4+3tPjNyv8vRJ0xvQ9qrGFf+EacAMUt/1EHLX4MRFA0bu86xgFNmjbPC8dHywOXvUV/
 dR2Uxe8mobCJL5I4mRIT8kI3I/u6NdaIQcYN6qtYQLJ/gG0pFPueSaeeGwTpOzPqaw49xsSw7
 k7cWXtHbSfeB0+H4GBvJt47LAkPdD96P+J2BP6IeFtujnt4Nh6KP/bmBDZgo7q4MZK5kh6tUF
 HWSMRs4zLNo2cX/dJWweBXdXU9WGC1aUsHXOy8e0Thf9/hb9eO1FVN3a+NPIgsVileiHWxEWG
 bWXWiVbToKhpqfWDRmQPG5edC7LEH8WEL9aQY8srXabuvbVAhCYcj9PMCy4yBy6S2Iufz+gEm
 aBcOhQRJ3xPKiz/3D6fwR1Juo98meiyLc0xBLG3qocecacdApm98ftbPg+gGYhxVvZ6d3S00J
 5CdZzGftni3xSEAv5Dv4w049QJR4sEwTGt9uXXdODlPUhqg5B91mYgN1pqzlod4gKuZ7/68uA
 c74bpjDAYF1j0DhPOtx2kF4oJdffD/LwSbc4h0FyM4eKw7rvt9L9uXh6IyBvupMm8RNhzqxS1
 F8I/G4vSR40P6iL9rEAcZhYhkOpt36DmIpNWc5f2TG8LT2eUSY4nNkFWzhOiKVyG0mexcfgly
 F3lMZhLYtwHdCQHb3hZRS7yxtpNeac1DQuncjNDsbc2LDkJHwC0yg+xtBLvyYHfxTOkTu68K3
 Qb6qKcjY7NwQn6lCxAdIG7AF9xEy0PepOfJMtYyETMfQD0QCi8DfgWdIjYpBepqc34JTPf6
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.130
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
Cc: Taylor Simpson <tsimpson@quicinc.com>, Riku Voipio <riku.voipio@iki.fi>,
 Alistair Francis <alistair.francis@wdc.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series adds a script to generate syscall_nr.h for
architectures that don't use syscall.tbl but asm-generic/unistd.h

The script uses several cpp passes and filters result with a grep/sed/tr sequence.
The result must be checked before being used, so it's why the script is not
automatically run.

I have run the script, checked and added new files for arm64, nios2, openrisc.

I don't include result for riscv as Alistair is already working on a series
for this architecture and it needs some changes in syscall.c as some
syscalls are not defined.

We also need to add the _time64 variant of syscalls added by the update of the
syscall_nr.h.

Based-on: <20200310103403.3284090-1-laurent@vivier.eu>

v2: add comments suggested by Taylor

Laurent Vivier (4):
  scripts: add a script to generate syscall_nr.h
  linux-user, aarch64: sync syscall numbers with kernel v5.5
  linux-user,nios2: sync syscall numbers with kernel v5.5
  linux-user, openrisc: sync syscall numbers with kernel v5.5

 linux-user/aarch64/syscall_nr.h  |  34 +-
 linux-user/nios2/syscall_nr.h    | 650 +++++++++++++++----------------
 linux-user/openrisc/syscall_nr.h | 309 +++------------
 scripts/gensyscalls.sh           | 102 +++++
 4 files changed, 513 insertions(+), 582 deletions(-)
 create mode 100755 scripts/gensyscalls.sh

-- 
2.24.1


