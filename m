Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D19EC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 19:23:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E979F207CD
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 19:23:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E979F207CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBNUZ-0000Ox-4N
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 15:23:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33324)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kBNRs-0003kw-4y
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 15:20:36 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:45197)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kBNRq-00009L-6F
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 15:20:35 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MV6G0-1k4K8n3AM2-00S5h2; Thu, 27 Aug 2020 21:20:23 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 00/18] Linux user for 5.2 patches
Date: Thu, 27 Aug 2020 21:20:00 +0200
Message-Id: <20200827192018.2442099-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eF0OzeniPApHj7BXEfG1wWY10/FA5TDwVEaiYKH18qGxjIDhkaO
 SSymseN+Deyg/A20vFCn90nemxjhUM1XvrjMAD8wXQuU/nY8fxZkP34ps/u0ECSzge0Lz8d
 NGAK7uyma7Zg6W2yjijl7iffzDDp/wdatbh+ddwEfVvshlJ9yHBSgj1J+TXLRlEEjrd71Ic
 RtbM3oeMe5/R7ksOf31dw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EtK/8wOqKH0=:LO/lLICnfnmYxySXyJlOTK
 onjQLL2Eq1OCOnQcSffDYRm4sTZDcGOx/hMYMKRUJvPnYyoQj1NzDLsDnzd159Dr9iQ3/adDH
 5yuDMlRFQnqTwJ2B67nt3Tm7tIDTmc2fBa1nVAuLe2hH2uo+d8LQPPlcEnvrjWxoYdaSvEXAI
 OZyCH6+zSQs0R82b03/4hYm5cMAVp28GGc7Ik0WamqbvMnk02AxJRkaTTs4IeJ8x7+aQDQRW4
 kkCUjfduYysqf5H8U+dqVudm3Ts/mdGL0WqN/UU3+ezZovT8IXPbM/Sp7gVO3FkruAT7oEZ6d
 rcPj95ixdPggOuHjlxo/yEnLLrS/i2V739tncN/wIF1NI6JaVVMH2/oHsytR+rZfNfieZtsBi
 FSPyI+2U+G3aLpW3MAKTjEjwnwEDqwMjaEheYEiI3xrVghbbjS0idogfF6koc/DLpI2zkrM1Q
 FnTAP+vl4DCAmAh9r+r4GvTh/fS1FC658fjpBL6j1AKyee6KMrkUuoV+xClkhGcx1bqaILnOT
 IoIyIn4UjBHJ8Q9Yffthx/n05JQCxlReKL+SxiAuxH0WVAX06rpCNlWoqZv2mGuuCwnDYh5QL
 8Rw8OgYficXCX9LbB+XUbIEsbgnQA3RZ1P5zMpKvaANnOeUTFpq3k4qnRfE5BJP4V0xonsDMV
 qeEhcMO0OeVi1pN2lQqoUC55l6pF4UwaFJS9LvBwNozeOH9ktkhXGEbIb3f/6WT0/zcOVFMqZ
 bFocgh0uGQzlhYtpb4fCORsYq3iKv5UqYaAvQlwUQGziHjZy9+AZv/T52D24o0UuWm/w/6i3f
 urzvWj709NPC5BHF5YQO3Vg8Q0iPZLwkqJLzJDq+vdUS13mCViiPLO0Z+83x7Ay4LqsPkvH
Received-SPF: none client-ip=212.227.17.10; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 15:20:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 25f6dc28a3a8dd231c2c092a0e65bd796353c769=
:=0D
=0D
  Merge remote-tracking branch 'remotes/maxreitz/tags/pull-block-2020-08-26=
' =3D=0D
into staging (2020-08-26 10:28:36 +0100)=0D
=0D
are available in the Git repository at:=0D
=0D
  git://github.com/vivier/qemu.git tags/linux-user-for-5.2-pull-request=0D
=0D
for you to fetch changes up to aa26eb42f5eaec54257aaceaeda50b9aa98756a5:=0D
=0D
  linux-user: Add support for utimensat_time64() and semtimedop_time64() (2=
02=3D=0D
0-08-27 12:29:51 +0200)=0D
=0D
----------------------------------------------------------------=0D
add utimensat_time64, semtimedop_time64, rt_sigtimedwait_time64,=0D
    sched_rr_get_interval_time64, clock_nanosleep_time64, clock_adjtime64,=
=0D
    mq_timedsend_time64, mq_timedreceive_time64=0D
fix semop, semtimedop, clock_nanosleep, mq_timedsend, target_to_host_timesp=
ec=3D=0D
64=0D
fix tembits.h=0D
add more strace function=0D
Add upport DRM_IOCTL_I915_GETPARAM=0D
detect mismatched ELF ABI in qemu-mips[n32][el]=0D
=0D
----------------------------------------------------------------=0D
=0D
Carlo Marcelo Arenas Bel=3DC3=3DB3n (1):=0D
  linux-user: detect mismatched ELF ABI in qemu-mips[n32][el]=0D
=0D
Chen Gang (1):=0D
  linux-user: syscall: ioctls: support DRM_IOCTL_I915_GETPARAM=0D
=0D
Filip Bozuta (15):=0D
  linux-user: Fix 'semop()' and 'semtimedop()' implementation=0D
  linux-user: Fix 'clock_nanosleep()' implementation=0D
  linux-user: Make cpu_env accessible in strace.c=0D
  linux-user: Add strace support for printing arguments of=0D
    truncate()/ftruncate() and getsid()=0D
  linux-user: Add strace support for printing arguments of syscalls used=0D
    to lock and unlock memory=0D
  linux-user: Add an api to print enumareted argument values with strace=0D
  linux-user: Add strace support for printing arguments of some clock=0D
    and time functions=0D
  linux-user: Add generic 'termbits.h' for some archs=0D
  linux-user: Add missing termbits types and values definitions=0D
  linux-user: Add strace support for printing arguments for ioctls used=0D
    for terminals and serial lines=0D
  linux-user: Fix 'mq_timedsend()' and 'mq_timedreceive()'=0D
  linux-user: Add support for 'mq_timedsend_time64()' and=0D
    'mq_timedreceive_time64()'=0D
  linux-user: Add support for 'clock_nanosleep_time64()' and=0D
    'clock_adjtime64()'=0D
  linux-user: Add support for 'rt_sigtimedwait_time64()' and=0D
    'sched_rr_get_interval_time64()'=0D
  linux-user: Add support for utimensat_time64() and semtimedop_time64()=0D
=0D
Laurent Vivier (1):=0D
  linux-user: fix target_to_host_timespec64()=0D
=0D
 include/exec/user/thunk.h              |    1 +=0D
 linux-user/aarch64/target_syscall.h    |    5 +-=0D
 linux-user/aarch64/termbits.h          |  228 +----=0D
 linux-user/alpha/target_syscall.h      |    5 +-=0D
 linux-user/alpha/termbits.h            |    1 +=0D
 linux-user/arm/target_syscall.h        |    6 +-=0D
 linux-user/arm/termbits.h              |  223 +----=0D
 linux-user/cris/target_syscall.h       |    5 +-=0D
 linux-user/cris/termbits.h             |   18 +-=0D
 linux-user/elfload.c                   |   11 +=0D
 linux-user/generic/termbits.h          |  318 +++++++=0D
 linux-user/hppa/target_syscall.h       |    5 +-=0D
 linux-user/hppa/termbits.h             |   17 +-=0D
 linux-user/i386/target_syscall.h       |    5 +-=0D
 linux-user/i386/termbits.h             |  233 +-----=0D
 linux-user/ioctls.h                    |    3 +=0D
 linux-user/m68k/target_syscall.h       |    6 +-=0D
 linux-user/m68k/termbits.h             |  234 +-----=0D
 linux-user/microblaze/target_syscall.h |    5 +-=0D
 linux-user/microblaze/termbits.h       |  220 +----=0D
 linux-user/mips/target_syscall.h       |    5 +-=0D
 linux-user/mips/termbits.h             |   17 +-=0D
 linux-user/mips64/target_syscall.h     |    5 +-=0D
 linux-user/nios2/target_syscall.h      |    5 +-=0D
 linux-user/nios2/termbits.h            |  228 +----=0D
 linux-user/openrisc/target_syscall.h   |    5 +-=0D
 linux-user/openrisc/termbits.h         |  302 +------=0D
 linux-user/ppc/target_syscall.h        |    5 +-=0D
 linux-user/ppc/termbits.h              |   21 +-=0D
 linux-user/qemu.h                      |   40 +-=0D
 linux-user/riscv/target_syscall.h      |    5 +-=0D
 linux-user/riscv/termbits.h            |  228 +----=0D
 linux-user/s390x/target_syscall.h      |    5 +-=0D
 linux-user/s390x/termbits.h            |  289 +------=0D
 linux-user/sh4/target_syscall.h        |    5 +-=0D
 linux-user/sh4/termbits.h              |   19 +-=0D
 linux-user/sparc/target_syscall.h      |    5 +-=0D
 linux-user/sparc/termbits.h            |   18 +-=0D
 linux-user/sparc64/target_syscall.h    |    5 +-=0D
 linux-user/sparc64/termbits.h          |   18 +-=0D
 linux-user/strace.c                    | 1060 +++++++++++++++++-------=0D
 linux-user/strace.list                 |   35 +-=0D
 linux-user/syscall.c                   |  471 +++++++++--=0D
 linux-user/syscall_defs.h              |   41 +=0D
 linux-user/syscall_types.h             |    4 +=0D
 linux-user/tilegx/target_syscall.h     |    5 +-=0D
 linux-user/tilegx/termbits.h           |  276 +-----=0D
 linux-user/x86_64/target_syscall.h     |    5 +-=0D
 linux-user/x86_64/termbits.h           |  254 +-----=0D
 linux-user/xtensa/target_syscall.h     |    5 +-=0D
 linux-user/xtensa/termbits.h           |   55 +-=0D
 thunk.c                                |   23 +-=0D
 52 files changed, 1790 insertions(+), 3223 deletions(-)=0D
 create mode 100644 linux-user/generic/termbits.h=0D
=0D
--=3D20=0D
2.26.2=0D
=0D

