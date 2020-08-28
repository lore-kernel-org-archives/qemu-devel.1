Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD74C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 13:38:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B312F207DF
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 13:38:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B312F207DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBeaf-0004wb-0k
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 09:38:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36640)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kBeZs-0003RT-Gx
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 09:38:00 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:58793)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kBeZp-0007FD-Pq
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 09:38:00 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N2BQM-1kbjw52Ez0-013axg; Fri, 28 Aug 2020 15:37:55 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 00/18] Linux user for 5.2 patches
Date: Fri, 28 Aug 2020 15:37:35 +0200
Message-Id: <20200828133753.2622286-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yqeCiRcW7DqHOJE6el+IHZbQ/mRzr2HNbdjvaoxBsi+hMtBtx/n
 St85CXi+XPZnH5oYnj6EaENVJMoXeJWNS1OwbM3rI1B68+yX9N8N+iq8DKu26t0d5o9GjZs
 /7Jet8+zy+MX4w8LfL7ZhsLvCHJSqOf5R2AtXDETv8lX6uQ1qkdsIzwRnc2hjqn3sry1JCI
 4ccYEWv8a57qAhlpD68eA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MyLrvw2nvtk=:2+SqERQ00sTgthSxyia0RL
 er3fbPpIZ7BB205y/PSAmYZ3WI6nNsdkNBin9a0G/Vlu5DrnzDGjmW5aSWjH+I2PzLXx8cTnV
 aZetP8ODcKGDB01xbpsC3Uq6EL1Bibwb38st6YKLl5q/UlaYselb8yPOHcAGJztYDnVbz1NSs
 eJ9ZyMZkpMORZ3BOvZNtrKcKg8iLU9I7yHF/81HFPKrrkVYHGeEzSQVbuf0MigoQ2XLlC31zy
 qgO9le2MuzmHB863WOIDT3EF5kC2nH1J1xiBOqbRS1M4DH6PgQaoWb1r+SHsZbURgq15oWm+r
 8wzN2uP+6btmurTGDb5v+0UsW1RtzFI/aSJa7Ghg8C5Sz7xiabQNVTdzzwqbFrBxoSkwWyMOQ
 iKGpyBbjeAHu5C8Bg7kD/Z2nIcsDkfPQrOTTpS1RqnwEnDgEWyuFCSeLxN4HrroMvmizG0iXs
 CaH6tgIBIGiBzo7ZUrLWZg1vjGo2YvOKobG6StL6Gzb6fLiH6vcY/Bm9PnIXCHybKeWNSG5Bm
 bLBvydVAYNNupVxJgf7X5+S61PbZ9xc1A2jtULLmvJf439umMzNm/51w+mqVRUW2i0qCU3KK/
 Tf1REfp0d44qI1qw3SXnEykOdbedaDcVPGzgaz8CRurrr8Y44B7cL6DkAs065wq3VULoCbDoh
 q5NFFwV9eWbRNuIr+0H0Dzke3FLh5LOZxZHM2UysAPooabdshMW5wUiOifHvJjB29G2c5k8Hi
 dXi2aoYTOM0zHvSi57wegbjJkO9hfel0/MNcujIvK946+XDKZAT6aWbFx0Y+STKlo6GIT6age
 MbM7/neoFcEgEsh3RjFy3GYOAEx53RrHKC3U1rzilT82f2w/dYDbbs5h5YSsWyfca8MUXsp
Received-SPF: none client-ip=212.227.126.130; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/28 09:36:25
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
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
for you to fetch changes up to cac46eb021fbbac77f1f98223b19608f31fc2236:=0D
=0D
  linux-user: Add support for utimensat_time64() and semtimedop_time64() (2=
02=3D=0D
0-08-28 15:24:42 +0200)=0D
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
 linux-user/syscall.c                   |  473 +++++++++--=0D
 linux-user/syscall_defs.h              |   41 +=0D
 linux-user/syscall_types.h             |    4 +=0D
 linux-user/tilegx/target_syscall.h     |    5 +-=0D
 linux-user/tilegx/termbits.h           |  276 +-----=0D
 linux-user/x86_64/target_syscall.h     |    5 +-=0D
 linux-user/x86_64/termbits.h           |  254 +-----=0D
 linux-user/xtensa/target_syscall.h     |    5 +-=0D
 linux-user/xtensa/termbits.h           |   55 +-=0D
 thunk.c                                |   23 +-=0D
 52 files changed, 1792 insertions(+), 3223 deletions(-)=0D
 create mode 100644 linux-user/generic/termbits.h=0D
=0D
--=3D20=0D
2.26.2=0D
=0D

