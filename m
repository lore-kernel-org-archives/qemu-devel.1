Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F8BEC33CAA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 08:25:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E7D124125
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 08:25:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E7D124125
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuXne-0003j5-Sv
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 03:25:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55889)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iuXlG-00010h-BG
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 03:22:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iuXlE-0002nl-S1
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 03:22:46 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:48123)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iuXlD-0002e1-5d
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 03:22:44 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MGzI3-1iqQtx429T-00E66U; Thu, 23 Jan 2020 09:22:31 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 00/17] Linux user for 5.0 patches
Date: Thu, 23 Jan 2020 09:22:10 +0100
Message-Id: <20200123082227.2037994-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:S90B/Zx5VE0kp1RMh+5FqltpV9iTwUKPQgfx4dp0E+iyMiEIZlz
 aQ/4RstKTErLG3zi6Bls/bSgUXw5H2W8aA0qq4KM0hSxRc1+jdvGk0d393NOjSz6enqzHrm
 /zaAAZiVMPxqAUjS0hgmFAebNm3TF0xQMChjPRWJssmPKMvCktG4KKc9R505Lls1z13nA4H
 6zKFV6XY26kDoBtxegA0g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zn9JmtC6FoA=:d4p2lcuh7/FQs15c7sWvmI
 dxcXZOod++szeKlhXy1RDDqXJvGHHumpEpeSvu0QnRSkzNZ2KTozCupYgbiA2kKmbREW04mou
 9poFDVmYamBfrUXbfcxOPTyWZBIjGrCdQ4U5NiziNPHzw3BnWOANRwrUxazo/2Iq4fJY4kg2K
 C5/fREDEvv8iek6PXLG4nJ6xdHmJNt04qbcL8hFqTNClcnVc9gmxwz8IwDlgDUqbBOEVUC41G
 rJUnwHCBq8+cdyc4a9uv2O8Px3Tye8SwsfcwjXAGZYGzPz0oWLW+eE0AUFSLebUe9e8OCm3fj
 4mSlb2HAf9hrmJQSy15vVvFQTVB4MAJOiW30ukX+LpXUhfyIZs6tGzxWmnYcWADlZBsnqtydO
 uEc9lD92Lu6dcD4CLJs9lUOlqnAO8zJpwgobl6KC0HLy+s50as7QvT+OWRG0eETA5mmfi5yMc
 lMtTekpIhmGfDYX78bShQYbnW8rRcbV0JtAdImqEpA1grrZIVf95kxzawM8OX23ugBs5uh1q8
 VUON4g3QEaPwPLErypmznXNkxV2/QRF+U7tRTSCjg60XPQtH5xTamjXN7sPL9L6zPv1sKSe/W
 BNjJn5luFapaUCadOWIfVTwFBnearWphJF4W5RXjnI/WdxWyDVvgPb7kZtzwipHZmSLj0u5Bm
 LogYiaDFB3qnAsdxz5mzl5qY5Enlzf5kiQUDgtlfEKUgnycyjkYFOt8iLcbE0WRMXt7EjZ3T3
 KBQhnY2ozw7nBXI8qovDuR7OLorw/VHqb+vhcQEg5n+1046TpLym/MrtOxw24Ic9kGo296msP
 0i+4FC8k6q6WB6vyEag/wvfTcqu0JSueTwcd6sBMbz3eaBxs1Q=
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

The following changes since commit 3e08b2b9cb64bff2b73fa9128c0e49bfcde0dd40:

  Merge remote-tracking branch 'remotes/philmd-gitlab/tags/edk2-next-20200121' into staging (2020-01-21 15:29:25 +0000)

are available in the Git repository at:

  git://github.com/vivier/qemu.git tags/linux-user-for-5.0-pull-request

for you to fetch changes up to a7b09746679c1815115249ec69197e454efdfb15:

  linux-user: Add support for read/clear RTC voltage low detector using ioctls (2020-01-22 15:21:37 +0100)

----------------------------------------------------------------
Fix mmap guest space and brk
Add FS/FD/RTC/KCOV ioctls

----------------------------------------------------------------

Aleksandar Markovic (8):
  linux-user: Add support for FS_IOC_<GET|SET>VERSION ioctls
  linux-user: Add support for FS_IOC32_<GET|SET>FLAGS ioctls
  linux-user: Add support for FS_IOC32_<GET|SET>VERSION ioctls
  linux-user: Add support for FD<SETEMSGTRESH|SETMAXERRS|GETMAXERRS>
    ioctls
  linux-user: Add support for FDFMT<BEG|TRK|END> ioctls
  configure: Detect kcov support and introduce CONFIG_KCOV
  linux-user: Add support for KCOV_<ENABLE|DISABLE> ioctls
  linux-user: Add support for KCOV_INIT_TRACE ioctl

Filip Bozuta (7):
  linux-user: Add support for TYPE_LONG and TYPE_ULONG in do_ioctl()
  linux-user: Add support for enabling/disabling RTC features using
    ioctls
  linux-user: Add support for getting/setting RTC time and alarm using
    ioctls
  linux-user: Add support for getting/setting RTC periodic interrupt and
    epoch using ioctls
  linux-user: Add support for getting/setting RTC wakeup alarm using
    ioctls
  linux-user: Add support for getting/setting RTC PLL correction using
    ioctls
  linux-user: Add support for read/clear RTC voltage low detector using
    ioctls

Richard Henderson (1):
  linux-user: Reserve space for brk

Xinyu Li (1):
  linux-user:Fix align mistake when mmap guest space

 configure                  |  9 +++++
 linux-user/elfload.c       | 75 +++++++++++++++++++++++++++++---------
 linux-user/ioctls.h        | 41 +++++++++++++++++++++
 linux-user/qemu.h          |  1 +
 linux-user/syscall.c       |  6 +++
 linux-user/syscall_defs.h  | 59 ++++++++++++++++++++++++++++--
 linux-user/syscall_types.h | 37 +++++++++++++++++++
 7 files changed, 207 insertions(+), 21 deletions(-)

-- 
2.24.1


