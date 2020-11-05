Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1FBCC00A89
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 07:10:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 394A52080D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 07:10:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 394A52080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaZPI-0001yH-0H
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 02:10:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kaZO2-0000HU-0L
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 02:08:51 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:33051)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kaZNz-0007Wp-7S
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 02:08:45 -0500
Received: from localhost.localdomain ([82.252.154.198]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MofPt-1jyke93s41-00p90L; Thu, 05 Nov 2020 08:08:41 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 0/4] Linux user for 5.2 patches
Date: Thu,  5 Nov 2020 08:08:33 +0100
Message-Id: <20201105070837.558332-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DX+abNGKfEY7a9P/ZiYuTQKnB+7bHwTzsii7DtXJkMZBJBrf+qT
 ol+ySrWPh4A+FNeJA0rlW552POucziUpdUr6f0xvSeeV7fiayOAXoRj1nFHEpyi5+6cPGmI
 BhNAi2iph4QphO0hozWz1rnIIwGO6Iy9YYk4CK1a02ix8lashh0JAYaROfGzeyeq8vuartz
 kzzrYP0iM3+ky1AmUketA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:S1VvTNoEoCk=:QF7v4iwyCdeHIN3m4LfDNa
 ze7lLzlg8HjQLr63C0b+h6UWfobyHoEKff5VNbrbeRjBKgfms5rEFHgBCq5qINfSGs1aEnrLn
 DaGfCKSXNIYJ2Bfgns9eyxHFvSKS2PeHGJU77PRNkO1w6MoB9VQYktweqaausQ48l5L8JhrLE
 AOKQDukOc+6HFxHmV88XuGW7m0FFicGOEhmG5E0aDi/fPRNLYXkyN99YMe6l936hHHtSgn/no
 dHBHYYrBveAlFMWXAWmXPwcU4Q61GRbs3QKa2w4fCl6fOg9C8vgeSVIukFonJIQ4v20QcG8Ry
 dM6LNlaTdoB1Q8rF1SHd0WPKU+gsF2qmX8DEY4P4uPuVorrfXnvhwZxw6fJXGPK6nNCueI5oR
 03XAhdkWycfX0G01qSxQqPCuCHTFO4YeBVLKaowWD4eb39iqZ5715Nqg0MORJ
Received-SPF: none client-ip=212.227.126.134; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/05 02:08:41
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

The following changes since commit 8680d6e36468f1ca00e2fe749bef50585d632401=
:=0D
=0D
  Merge remote-tracking branch 'remotes/nvme/tags/pull-nvme-20201102' into =
st=3D=0D
aging (2020-11-02 17:17:29 +0000)=0D
=0D
are available in the Git repository at:=0D
=0D
  git://github.com/vivier/qemu.git tags/linux-user-for-5.2-pull-request=0D
=0D
for you to fetch changes up to 022625a8ade3005addb42700a145bae6a1653240:=0D
=0D
  linux-user: Check copy_from_user() return value in vma_dump_size() (2020-=
11=3D=0D
-04 22:28:05 +0100)=0D
=0D
----------------------------------------------------------------=0D
Coverity and compiler warning fixes=0D
=0D
----------------------------------------------------------------=0D
=0D
Alistair Francis (1):=0D
  linux-user/syscall: Fix missing target_to_host_timespec64() check=0D
=0D
Chen Qun (1):=0D
  linux-user/mips/cpu_loop: silence the compiler warnings=0D
=0D
Peter Maydell (2):=0D
  linux-user: Use "!=3D3D 0" when checking if MAP_FIXED_NOREPLACE is=0D
    non-zero=0D
  linux-user: Check copy_from_user() return value in vma_dump_size()=0D
=0D
 linux-user/elfload.c       | 7 +++++--=0D
 linux-user/mips/cpu_loop.c | 4 ++++=0D
 linux-user/syscall.c       | 4 +++-=0D
 3 files changed, 12 insertions(+), 3 deletions(-)=0D
=0D
--=3D20=0D
2.28.0=0D
=0D

