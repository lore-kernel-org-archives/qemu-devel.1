Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B24ACC5ACC4
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 22:08:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74CD724656
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 22:08:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74CD724656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4XVf-0001Ik-Jt
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 17:07:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34156)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j4XSF-0004eo-1T
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 17:04:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j4XSD-0001Xp-1S
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 17:04:27 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:48739)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1j4XSC-0001XU-Na; Wed, 19 Feb 2020 17:04:24 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MidPj-1jhAB046lz-00fiqy; Wed, 19 Feb 2020 23:03:42 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 00/20] linux-user: generate syscall_nr.sh
Date: Wed, 19 Feb 2020 23:03:13 +0100
Message-Id: <20200219220333.1411905-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:FkqYgY6xod4YfFctr/yAEgXUbl0njW75N/KYL3htDyf+0G+LE5B
 BGpT8ut0cnh18kOx3xvzcn/pAcSfq8brpRrOqVT+CXkBrH9FUMuIXe16Lze3HylXXr9PuXh
 4qTs1hhucQJZgi5PVqiEpBW07Ep15LHstoETGuG2qG0IW6h8Y4KQBoNW6O3WHlg9D6JtDs6
 d5RuyDEwdO9RSWDfYyt8g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:717+hVGPOOA=:/TP/PYfauDdFup8CeewTM6
 3SALon6J6WqXuWbsmVmb4xUEApZLAPIGJbl1dFoMsI2DxfX4rIjaheWkatXkNVxvEtiLizbDE
 iJqxAAik1REvxMNOPVTA9bF+HIk0UJthU498Ymo715qo9aPxT28+Zs7KsoxI38Z3MNEKsDLVe
 rJLXFbJkSI7qY10TeWjqUki668icKiou8IhrGjuDRY0EK+O9b206TftY4a3KHhuPOkv7tFazf
 b/yjKu0kQrFan5YAjxU7oAyTMoXawg82ZGms4efeBzc/BSkMS5ur8If89ginW/f1/NUec+uD/
 S69jV1I0EvAEUv7g6E2vQZkM1rkJ1t3QnJ85oKE6PUPbOrrz+qGQ21f52eKCp7DgOhwHfastl
 RtiX+71LxioysRpiaIXCZay8jlsMZZqWVKxgZtKp4wcJ4tCSRcogkri7zjagIfT29ErkU1byC
 ozQQYg8avhBm91jgpDNTd+MeyxkfE+F+eWGS4lmwFAA4nsfl2RNpcANtvx1ptzCvQCjgK7q0F
 0fWY0NOE2sCQlcI77dbDKZIpq2QNC7X5wLiI1gJZzU5hBeZtNnIorCu9S0oZNtxbot1LNimj8
 5Dyg6GGu0VAoFNWu1JnD/lxghEuN0ffRoanEIf8KXlPRNbViuFGotoR/XOzTJgf+khCPH4P81
 I9yAw/gHN6TqJBUnlJM+0pPE1zFAchyo1/J5V1VPvJSvPKJZ/CquvUSS3xoqyBShzHuoPQEvE
 xknLL0Q/A2suAh+u1Kb9vEmBB1l6vMIpj6OU+cm1RlI2a76eGl+EJCjfyR8946/kAl8mUh7a0
 bNX/94ULfVJg1ilhvTHoeYd81OQsbAn1UOIIZRNsY2T+nYLLZ0qBaL4XEefk72WW5OLl7cn
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
Cc: Cornelia Huck <cohuck@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>, qemu-s390x@nongnu.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series copies the files syscall.tbl from linux v5.5 and generates
the file syscall_nr.h from them.

This is done for all the QEMU targets that have a syscall.tbl
in the linux source tree: mips, mips64, i386, x86_64, sparc, s390x,
ppc, arm, microblaze, sh4, xtensa, m68k, hppa and alpha.

tilegx and cris are depecrated in linux (tilegx has no maintainer in QEMU)

aarch64, nios2, openrisc and riscv have no syscall.tbl in linux.

It seems there is a bug in QEMU that forces to disable manually arch_prctl
with i386 target: do_arch_prctl() is only defined with TARGET_ABI32 but
TARGET_ABI32 is never defined with TARGET_I386 (nor TARGET_X86_64).

I have also removed all syscalls in s390x/syscall_nr.h defined for
!defined(TARGET_S390X).

I have added a script to copy all these files from linux and updated
them at the end of the series with their latest version for today.

The two last patches manage the special case for mips O32 that needs
to know the number of arguments. We find them in strace sources.

v2:
    fix a typo (double comma) in $(call quiet-command)
    add a script to remove dependencies to syscall_nr.h in source directory

ppc, mips64:

        we don't need to split syscall_nr.h as it is generated
        according TARGET_SYSTBL_ABI to TARGET_ABI_DIR
        and generated values are incorrect according to the file name.

arm:

        manage TARGET_NR_arm_sync_file_range

Once the syscall_nr.h are built in the build directory, the following script
allows to compare them with the original one (first argument is the path
to build directory), it must be run from the source directory:

cat > check_syscall_nr.sh <<EOF
BUILD="$1"

ARCHS="i386 alpha arm hppa i386 m68k microblaze s390x sh4 sparc sparc64 xtensa ppc"

syscall_nr_diff()
{
        arch=$1
        target=$2
        syscall_nr=linux-user/$arch/syscall_nr.h
        offset=$3
        REFERENCE=$(git log -1 --format=format:%h -- $syscall_nr)^
        if [ "$offset" = "" ] ; then
                git show $REFERENCE:$syscall_nr | \
                        sed 's/[[:blank:]]\/\*[^*]*\*\///' | \
                        sed 's/(\([^)]*\))/\1/'  > /tmp/old
        else
                git show $REFERENCE:$syscall_nr | \
                        sed 's/[[:blank:]]\/\*[^*]*\*\///' | \
                        sed "s/TARGET_NR_Linux/$offset/" > /tmp/old
        fi
        diff -wu --color=always /tmp/old \
                                $BUILD/$target/$syscall_nr | less -R
}

for arch in $ARCHS ; do
        syscall_nr_diff $arch $arch-linux-user
done

syscall_nr_diff ppc    ppc64-linux-user

syscall_nr_diff mips   mips-linux-user    4000
syscall_nr_diff mips64 mips64-linux-user  5000
syscall_nr_diff mips64 mipsn32-linux-user 6000
EOF

Laurent Vivier (20):
  linux-user: introduce parameters to generate syscall_nr.h
  linux-user,alpha: add syscall table generation support
  linux-user,hppa: add syscall table generation support
  linux-user,m68k: add syscall table generation support
  linux-user,xtensa: add syscall table generation support
  linux-user,sh4: add syscall table generation support
  linux-user,microblaze: add syscall table generation support
  linux-user,arm: add syscall table generation support
  linux-user,ppc: add syscall table generation support
  linux-user,s390x: remove syscall definitions for !TARGET_S390X
  linux-user,s390x: add syscall table generation support
  linux-user,sparc,sparc64: add syscall table generation support
  linux-user,i386: add syscall table generation support
  linux-user,x86_64: add syscall table generation support
  linux-user,mips: add syscall table generation support
  linux-user,mips64: add syscall table generation support
  linux-user,scripts: add a script to update syscall.tbl
  linux-user: update syscall.tbl from linux 0bf999f9c5e7
  linux-user,mips: move content of mips_syscall_args
  linux-user,mips: update syscall-args-o32.c.inc

 MAINTAINERS                            |   1 +
 Makefile.target                        |   3 +-
 configure                              |  35 ++
 linux-user/Makefile.objs               |  19 +-
 linux-user/alpha/Makefile.objs         |   5 +
 linux-user/alpha/syscall.tbl           | 479 ++++++++++++++++
 linux-user/alpha/syscall_nr.h          | 492 -----------------
 linux-user/alpha/syscallhdr.sh         |  32 ++
 linux-user/arm/Makefile.objs           |   8 +
 linux-user/arm/syscall.tbl             | 453 +++++++++++++++
 linux-user/arm/syscall_nr.h            | 447 ---------------
 linux-user/arm/syscallhdr.sh           |  31 ++
 linux-user/hppa/Makefile.objs          |   5 +
 linux-user/hppa/syscall.tbl            | 437 +++++++++++++++
 linux-user/hppa/syscall_nr.h           | 358 ------------
 linux-user/hppa/syscallhdr.sh          |  32 ++
 linux-user/i386/Makefile.objs          |   5 +
 linux-user/i386/syscall_32.tbl         | 444 +++++++++++++++
 linux-user/i386/syscall_nr.h           | 387 -------------
 linux-user/i386/syscallhdr.sh          |  28 +
 linux-user/m68k/Makefile.objs          |   5 +
 linux-user/m68k/syscall.tbl            | 439 +++++++++++++++
 linux-user/m68k/syscall_nr.h           | 434 ---------------
 linux-user/m68k/syscallhdr.sh          |  32 ++
 linux-user/microblaze/Makefile.objs    |   5 +
 linux-user/microblaze/syscall.tbl      | 445 +++++++++++++++
 linux-user/microblaze/syscall_nr.h     | 442 ---------------
 linux-user/microblaze/syscallhdr.sh    |  32 ++
 linux-user/mips/Makefile.objs          |   5 +
 linux-user/mips/cpu_loop.c             | 440 +--------------
 linux-user/mips/syscall-args-o32.c.inc | 436 +++++++++++++++
 linux-user/mips/syscall_nr.h           | 425 ---------------
 linux-user/mips/syscall_o32.tbl        | 427 +++++++++++++++
 linux-user/mips/syscallhdr.sh          |  36 ++
 linux-user/mips64/Makefile.objs        |  12 +
 linux-user/mips64/syscall_n32.tbl      | 378 +++++++++++++
 linux-user/mips64/syscall_n64.tbl      | 354 ++++++++++++
 linux-user/mips64/syscall_nr.h         | 725 -------------------------
 linux-user/mips64/syscallhdr.sh        |  33 ++
 linux-user/ppc/Makefile.objs           |   6 +
 linux-user/ppc/signal.c                |   2 +-
 linux-user/ppc/syscall.tbl             | 521 ++++++++++++++++++
 linux-user/ppc/syscall_nr.h            | 402 --------------
 linux-user/ppc/syscallhdr.sh           |  34 ++
 linux-user/s390x/Makefile.objs         |   5 +
 linux-user/s390x/syscall.tbl           | 442 +++++++++++++++
 linux-user/s390x/syscall_nr.h          | 398 --------------
 linux-user/s390x/syscallhdr.sh         |  32 ++
 linux-user/sh4/Makefile.objs           |   5 +
 linux-user/sh4/syscall.tbl             | 442 +++++++++++++++
 linux-user/sh4/syscall_nr.h            | 441 ---------------
 linux-user/sh4/syscallhdr.sh           |  32 ++
 linux-user/sparc/Makefile.objs         |   5 +
 linux-user/sparc/syscall.tbl           | 485 +++++++++++++++++
 linux-user/sparc/syscall_nr.h          | 363 -------------
 linux-user/sparc/syscallhdr.sh         |  32 ++
 linux-user/sparc64/Makefile.objs       |   5 +
 linux-user/sparc64/syscall.tbl         | 485 +++++++++++++++++
 linux-user/sparc64/syscall_nr.h        | 366 -------------
 linux-user/sparc64/syscallhdr.sh       |  32 ++
 linux-user/syscall.c                   |   6 +
 linux-user/x86_64/Makefile.objs        |   5 +
 linux-user/x86_64/syscall_64.tbl       | 404 ++++++++++++++
 linux-user/x86_64/syscall_nr.h         | 356 ------------
 linux-user/x86_64/syscallhdr.sh        |  28 +
 linux-user/xtensa/Makefile.objs        |   5 +
 linux-user/xtensa/syscall.tbl          | 410 ++++++++++++++
 linux-user/xtensa/syscall_nr.h         | 469 ----------------
 linux-user/xtensa/syscallhdr.sh        |  32 ++
 scripts/update-mips-syscall-args.sh    |  57 ++
 scripts/update-syscalltbl.sh           |  49 ++
 71 files changed, 8214 insertions(+), 6948 deletions(-)
 create mode 100644 linux-user/alpha/Makefile.objs
 create mode 100644 linux-user/alpha/syscall.tbl
 delete mode 100644 linux-user/alpha/syscall_nr.h
 create mode 100644 linux-user/alpha/syscallhdr.sh
 create mode 100644 linux-user/arm/Makefile.objs
 create mode 100644 linux-user/arm/syscall.tbl
 delete mode 100644 linux-user/arm/syscall_nr.h
 create mode 100644 linux-user/arm/syscallhdr.sh
 create mode 100644 linux-user/hppa/Makefile.objs
 create mode 100644 linux-user/hppa/syscall.tbl
 delete mode 100644 linux-user/hppa/syscall_nr.h
 create mode 100644 linux-user/hppa/syscallhdr.sh
 create mode 100644 linux-user/i386/Makefile.objs
 create mode 100644 linux-user/i386/syscall_32.tbl
 delete mode 100644 linux-user/i386/syscall_nr.h
 create mode 100644 linux-user/i386/syscallhdr.sh
 create mode 100644 linux-user/m68k/Makefile.objs
 create mode 100644 linux-user/m68k/syscall.tbl
 delete mode 100644 linux-user/m68k/syscall_nr.h
 create mode 100644 linux-user/m68k/syscallhdr.sh
 create mode 100644 linux-user/microblaze/Makefile.objs
 create mode 100644 linux-user/microblaze/syscall.tbl
 delete mode 100644 linux-user/microblaze/syscall_nr.h
 create mode 100644 linux-user/microblaze/syscallhdr.sh
 create mode 100644 linux-user/mips/Makefile.objs
 create mode 100644 linux-user/mips/syscall-args-o32.c.inc
 delete mode 100644 linux-user/mips/syscall_nr.h
 create mode 100644 linux-user/mips/syscall_o32.tbl
 create mode 100644 linux-user/mips/syscallhdr.sh
 create mode 100644 linux-user/mips64/Makefile.objs
 create mode 100644 linux-user/mips64/syscall_n32.tbl
 create mode 100644 linux-user/mips64/syscall_n64.tbl
 delete mode 100644 linux-user/mips64/syscall_nr.h
 create mode 100644 linux-user/mips64/syscallhdr.sh
 create mode 100644 linux-user/ppc/Makefile.objs
 create mode 100644 linux-user/ppc/syscall.tbl
 delete mode 100644 linux-user/ppc/syscall_nr.h
 create mode 100644 linux-user/ppc/syscallhdr.sh
 create mode 100644 linux-user/s390x/Makefile.objs
 create mode 100644 linux-user/s390x/syscall.tbl
 delete mode 100644 linux-user/s390x/syscall_nr.h
 create mode 100755 linux-user/s390x/syscallhdr.sh
 create mode 100644 linux-user/sh4/Makefile.objs
 create mode 100644 linux-user/sh4/syscall.tbl
 delete mode 100644 linux-user/sh4/syscall_nr.h
 create mode 100644 linux-user/sh4/syscallhdr.sh
 create mode 100644 linux-user/sparc/Makefile.objs
 create mode 100644 linux-user/sparc/syscall.tbl
 delete mode 100644 linux-user/sparc/syscall_nr.h
 create mode 100644 linux-user/sparc/syscallhdr.sh
 create mode 100644 linux-user/sparc64/Makefile.objs
 create mode 100644 linux-user/sparc64/syscall.tbl
 delete mode 100644 linux-user/sparc64/syscall_nr.h
 create mode 100644 linux-user/sparc64/syscallhdr.sh
 create mode 100644 linux-user/x86_64/Makefile.objs
 create mode 100644 linux-user/x86_64/syscall_64.tbl
 delete mode 100644 linux-user/x86_64/syscall_nr.h
 create mode 100644 linux-user/x86_64/syscallhdr.sh
 create mode 100644 linux-user/xtensa/Makefile.objs
 create mode 100644 linux-user/xtensa/syscall.tbl
 delete mode 100644 linux-user/xtensa/syscall_nr.h
 create mode 100644 linux-user/xtensa/syscallhdr.sh
 create mode 100755 scripts/update-mips-syscall-args.sh
 create mode 100755 scripts/update-syscalltbl.sh

-- 
2.24.1


