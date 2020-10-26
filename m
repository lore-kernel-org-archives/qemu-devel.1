Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D68CC4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 22:11:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D76120878
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 22:11:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D76120878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXAiU-0006zQ-Cr
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 18:11:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39146)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kXAag-0005YV-6V
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 18:03:46 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:43167)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kXAad-0005E9-Hy
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 18:03:45 -0400
Received: from localhost.localdomain ([82.252.139.38]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MirSu-1jscdV0XfY-00ey5x; Mon, 26 Oct 2020 23:03:41 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 0/8] Linux user for 5.2 patches
Date: Mon, 26 Oct 2020 23:03:31 +0100
Message-Id: <20201026220339.195790-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6tZPfkYQztyG0YrePdMF4G47Pzo2A6e7ykYFUmTJVZO+825kfLe
 bHsU+jVzzmWQIz7eHfXSAgoMJgMmQZFTji1WgCtQGZHj0Mcr0YYo886Yopa7/Gq4GOLDSLH
 w5I0GFV5lD0js4HSexd5j+ulCV4dp0Xp5NJuXt2espfYqOnR4zOWbMjL2YSB08x5e1EDv8d
 T02QSuUSVvfKqAIIokvAA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HiX0G50riI8=:ML0H2sXrzPU5uBgvVH6rxg
 OiaGsz8mpzfU1t7yWKpyUA4WXfnLtpTtafERRcUQNY5bmYc5RbuNZ7d23w6led5ciMY5cYJ2J
 NEQ2NrqyT2aOIqjgQI5vg2gUCn2oEu1wXQOei7TIu40s1StyRxNm9y5TQxaDYX3d8uTjF/i/x
 9UyFIMLm5Zfv4NESCLzyc7malpXMFI0v08uJShibIja/Kj93jLRbQUzl3kolkQy6JOFDr5nOy
 z72BMYTjCQCrjRs1OCrGisAWnQ1LoRLq6TdMX9BFE+pyn/9ZHrFLN3EwOj8TMvHEojqzV+kmV
 PatTqzo7T6kXn6daMCWaCHPCoqGO2b2woQXubMxMJY3eJctKap0fBNUwh3BK3UfitL7DpxyiG
 OPg7u029NUy8vHjq3WmkuwR2oLWVZPc9dPlLOokFZV8txg3ebhL8E4cfi3yQOTKdkVk2cwQmO
 13USbOo/tg==
Received-SPF: none client-ip=212.227.126.133; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 18:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 4c5b97bfd0dd54dc27717ae8d1cd10e14eef1430=
:=0D
=0D
  Merge remote-tracking branch 'remotes/kraxel/tags/modules-20201022-pull-r=
eq=3D=0D
uest' into staging (2020-10-22 12:33:21 +0100)=0D
=0D
are available in the Git repository at:=0D
=0D
  git://github.com/vivier/qemu.git tags/linux-user-for-5.2-pull-request=0D
=0D
for you to fetch changes up to ab97f0505bec6280c5455009b7678daf5c9278bc:=0D
=0D
  target/xtensa: enable all coprocessors for linux-user (2020-10-26 12:07:1=
9 =3D=0D
+0100)=0D
=0D
----------------------------------------------------------------=0D
Update syscall numbers to 5.9-rc7=0D
Fixes for prctl(), accept4() and xtensa=0D
=0D
----------------------------------------------------------------=0D
=0D
Frajo (1):=0D
  linux-user: Support f_flags in statfs64 when available.=0D
=0D
Laurent Vivier (4):=0D
  linux-user: update syscall_nr.h to Linux 5.9-rc7=0D
  linux-user: update mips/syscall-args-o32.c.inc to Linux 5.9-rc7=0D
  linux-user: update syscall.tbl to Linux 5.9-rc7=0D
  linux-user: remove _sysctl=0D
=0D
Matus Kysel (1):=0D
  linux-user: correct errno returned from accept4() syscall=0D
=0D
Max Filippov (1):=0D
  target/xtensa: enable all coprocessors for linux-user=0D
=0D
Stephen Long (1):=0D
  Fix stack smashing when handling PR_GET_PDEATHSIG=0D
=0D
 linux-user/aarch64/syscall_nr.h        |   7 +-=0D
 linux-user/alpha/syscall.tbl           |   4 +-=0D
 linux-user/arm/syscall.tbl             |   4 +-=0D
 linux-user/hppa/syscall.tbl            |   8 +-=0D
 linux-user/i386/syscall_32.tbl         | 820 +++++++++++++------------=0D
 linux-user/m68k/syscall.tbl            |   4 +-=0D
 linux-user/microblaze/syscall.tbl      |   4 +-=0D
 linux-user/mips/syscall-args-o32.c.inc |   4 +=0D
 linux-user/mips/syscall_o32.tbl        |   8 +-=0D
 linux-user/mips64/syscall_n32.tbl      |   8 +-=0D
 linux-user/mips64/syscall_n64.tbl      |   4 +-=0D
 linux-user/nios2/syscall_nr.h          |   7 +-=0D
 linux-user/openrisc/syscall_nr.h       |   8 +-=0D
 linux-user/ppc/syscall.tbl             |  30 +-=0D
 linux-user/riscv/syscall32_nr.h        |   8 +-=0D
 linux-user/riscv/syscall64_nr.h        |   8 +-=0D
 linux-user/s390x/syscall.tbl           |   8 +-=0D
 linux-user/sh4/syscall.tbl             |   4 +-=0D
 linux-user/sparc/syscall.tbl           |   8 +-=0D
 linux-user/sparc64/syscall.tbl         |   8 +-=0D
 linux-user/syscall.c                   |  19 +-=0D
 linux-user/x86_64/syscall_64.tbl       | 742 +++++++++++-----------=0D
 linux-user/xtensa/syscall.tbl          |   4 +-=0D
 scripts/gensyscalls.sh                 |   3 +-=0D
 target/xtensa/cpu.c                    |   1 +=0D
 25 files changed, 899 insertions(+), 834 deletions(-)=0D
=0D
--=3D20=0D
2.26.2=0D
=0D

