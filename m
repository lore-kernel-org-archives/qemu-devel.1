Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D990DC35254
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 09:32:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF99020726
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 09:32:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF99020726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3clg-0000QC-SL
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 04:32:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52171)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j3ckE-0007ZJ-9U
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 04:31:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j3ckD-0001sF-9Y
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 04:31:14 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:41613)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1j3ckD-0001pr-0b
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 04:31:13 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M8yU2-1j8YPb1Heg-0064nL; Mon, 17 Feb 2020 10:30:37 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 0/9] Linux user for 5.0 patches
Date: Mon, 17 Feb 2020 10:30:22 +0100
Message-Id: <20200217093031.678348-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:X7kyJ6dfYdY0ItrL21GpmAPa68tCsJIlFytU4IU0CmSMiYMgqjn
 NuC9sxvFfW1S0fbHf5jRLB8mCoZNAy+dv7M+jMGCa/2Qej5e5siJm79Fyx+tHEGCPawIyzp
 pzi+IaXExlZ9i8RJ1DhgKPSS5MjMWWavo1lD4dRml9XcadQbjCkTi6eXXXbDCsIcT8VDLKU
 e7VJ+RGa1sszXTzbLMHbw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JnvIpKIumvk=:WK+0a/yHXz7jmdG0VmHzKN
 9vZlZRP7tZrPT8VrsxfZmCB63/P2Q4Javw8cKEIaImVWVnLaP4FxOGz25LdXmYaruh0TbKGy8
 zr4QlKK9gpW/mhlhXhLrpbZ8a5/70xCjfhuf6pKf9PR9Ld68pt+q6dpqVYoyoGcuySVyD+tTx
 bHzmpAYWsZF0lYum8Pv3T8kZ5sfqXC3UnKaXAUCavom+8oe40/fi3lGvjhJudrCRkoGpo+GN9
 XDAX+JIIRgreZZ6devGgXOt2so4uJFvyb+L0PvkQdEFa1glDfxCXzs+An6mSwouqQO0VCZGX2
 NpboTUc9mUaZdtXwJGPKsHD8DOWD9AvqX39/Sv4nV3tO0IuoI+ah97D3lMXgyylvls08oWvXM
 fPi0bUvfzKARtGxJGTiZVdD+ql1GxTZY6IABK3lLI7nvqFBCvN19uvC35JYEFBMks58QCWcQ1
 q0+6iQXmrXmkC0sN92ZH0r9Bqb0JwPmT1uoHlWJIqc4DodbYmf+LqFz+z0ANuAxEhqWcXw8B+
 L4N3pEoYhG4Nrw36pOK+VSY1vBfriL8bdyzkd98s/8DXFrxk0SaBWL9qVk+Yx8PIglqSGD4TL
 vgGKD4qaGeQh9Rwrd0IJTJ3IUUYcWK3BMAUmCb7GsciT5OsN1Wcojo/r7H8kckbuL/R99SwBO
 tek7qeoVGVZqg40kZdB1Zwo72WXmJHTkxQXllBCf3XxeKQ7ceB5CZx8jlRIg0p7Sql1ez01vu
 Ro0A2u5oNXshhlfQC64mcsHTe+DkhD1nfNsguiYDOgyzKRjTvnX9eZP2a9PZvDLx/zss3qyUw
 EreGNPk0+hXnZRzwl35EOrDvyjEcwBnIvmVxSMKnrYbTi2dzYhNA1cU6ARtbnuXHJhfJZC4
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.134
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Riku Voipio <riku.voipio@iki.fi>, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 971b2a1e5b1a8cc8f597ac5d7016908f9fa880de:

  Merge remote-tracking branch 'remotes/palmer/tags/riscv-for-master-5.0-sf2' into staging (2020-02-14 18:37:11 +0000)

are available in the Git repository at:

  git://github.com/vivier/qemu.git tags/linux-user-for-5.0-pull-request

for you to fetch changes up to 0a80aa55f4485d102567e1db7ab0532ef96d1b96:

  linux-user: xtensa: Remove unused constant TARGET_NR_syscall_count (2020-02-17 10:28:50 +0100)

----------------------------------------------------------------
Update syscall numbers to kernel 5.5 level

----------------------------------------------------------------

Aleksandar Markovic (9):
  linux-user: alpha: Update syscall numbers to kernel 5.5 level
  linux-user: arm: Update syscall numbers to kernel 5.5 level
  linux-user: m68k: Update syscall numbers to kernel 5.5 level
  linux-user: microblaze: Update syscall numbers to kernel 5.5 level
  linux-user: mips: Update syscall numbers to kernel 5.5 level
  linux-user: sh4: Update syscall numbers to kernel 5.5 level
  linux-user: x86_64: Update syscall numbers to kernel 5.5 level
  linux-user: xtensa: Update syscall numbers to kernel 5.5 level
  linux-user: xtensa: Remove unused constant TARGET_NR_syscall_count

 linux-user/alpha/syscall_nr.h      | 35 +++++++++++++
 linux-user/arm/syscall_nr.h        | 44 ++++++++++++++++
 linux-user/m68k/syscall_nr.h       | 50 +++++++++++++++++-
 linux-user/microblaze/syscall_nr.h | 45 ++++++++++++++++
 linux-user/mips/cpu_loop.c         | 83 +++++++++++++++++++++++++++++-
 linux-user/mips/syscall_nr.h       | 45 ++++++++++++++++
 linux-user/mips64/syscall_nr.h     | 50 +++++++++++++++++-
 linux-user/sh4/syscall_nr.h        | 48 +++++++++++++++++
 linux-user/x86_64/syscall_nr.h     | 24 +++++++++
 linux-user/xtensa/syscall_nr.h     | 36 ++++++++++++-
 10 files changed, 454 insertions(+), 6 deletions(-)

-- 
2.24.1


