Return-Path: <SRS0=MBD3=C4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E79DC43463
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 18:47:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82A4720874
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 18:47:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82A4720874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJhtD-0007su-Af
	for qemu-devel@archiver.kernel.org; Sat, 19 Sep 2020 14:47:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51750)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kJhrB-0005vk-MY; Sat, 19 Sep 2020 14:45:09 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:60065)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kJhr8-0001Ir-Ob; Sat, 19 Sep 2020 14:45:09 -0400
Received: from localhost.localdomain ([82.252.129.222]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mm9NA-1kkHAC46Zk-00iCiO; Sat, 19 Sep 2020 20:45:01 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 00/17] Trivial branch for 5.2 patches
Date: Sat, 19 Sep 2020 20:44:34 +0200
Message-Id: <20200919184451.2129349-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FYiDGj/X5eqDMnuI8MhBv3ReGc03TyFcO6EspACXJdrL4LHtla9
 AYdcBf2G3ArtDLyghK+lEBZzflgf8seFooR8KprdTrwOlki3BqCCLto6WuRkTEt8F2iKlF2
 3CiMbfpW0nwSLoQGa89sY9g0uTaKdYZyvusBUnRHwbKWUqDK2HAvrsCm3vODljD3aD9ryq/
 F46MeK73bpbh4tOQkLksw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:T4BaOkVEYvU=:NdJNE+Qfrh29p40Q8Ex3Kw
 AMHr4NhnDGzSgHZ9n+TRIYFi7FHDjm+XWlWhNJEwZMiWfy5QERK33xlA4kl29rSvLke861Fed
 qPyZud+sZ3hMCv5DK8mINdLmtlP4TVYip6RiGVaASaAoJZTNgUJpd6BvOIHGX0rj9+z2pKFEw
 +e0lQ4dt8f4LsKNVLaT7jIG/v/FT5z3BJlqO68J3YFraRJkF/njw5SYs0UY1d9eHNKQpUT2gG
 Zwk7HHDe7lLazbXQn0kJNXE42nriOVU9PJxp6mzvv4NipSpwIHMH0qh69KpEmqJLRRW6yLUxb
 xJLeBw1B4cDThXnEwEVBGbUrgyn6JOVRzqFFjQfRs7zOhF6ZrGW4rMmtqJW/5+2/IaEgpqH0L
 CKORvSHsFMr7SAMsZKSJ3pHO99Mqkjs3urEwgi8iRqbaLdG6fx2FPBGqsVw9BiRG7LvMA42AY
 SD+wuODc7LRohtmhYxC0GYgAu1kydP6lxI1UHG6Zz+aiz7BAFZfTlQhYn9f+gsAOKiv0wmGwa
 yDh6WS9eI0SBb/IWOPhJ5l4SpYpExlEDJguAuOrmLAHQkwCC2lyicdzjBzrynLVzr2hUExlC1
 056yqsjchoXZmkxcRcstPEX52Xd8+zrFnR5Qj+fKLNGF3muoPkVoux4q9ctj48TxE8gbKAC1P
 DaYdmf/chZLrS4Z//dWvd/MQ6dTrAT6E6isp61cFbcA6SxMPQthC80Y8LESe7KLtGszll5rMd
 SVEGMN8MrmBJfP6PewvWIdHTB+ZTeO2vnkevn0V9xsMFLhtjNh07p6E+aZbSfOPGo2RxFZd/K
 3cefvvyXFV7EPvc3+UtV5E1K/pjSfP2Vo32NZUDacdxe7foVlxb5t7SB9R7pNOFVgskDjok
Received-SPF: none client-ip=212.227.126.130; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/19 14:45:03
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
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit de39a045bd8d2b49e4f3d07976622c29d58e0bac=
:=0D
=0D
  Merge remote-tracking branch 'remotes/kraxel/tags/vga-20200915-pull-reque=
st=3D=0D
' into staging (2020-09-15 14:25:05 +0100)=0D
=0D
are available in the Git repository at:=0D
=0D
  git://github.com/vivier/qemu.git tags/trivial-branch-for-5.2-pull-request=
=0D
=0D
for you to fetch changes up to 639b090df52a4952262615328a3fdfae81234ea8:=0D
=0D
  contrib/: fix some comment spelling errors (2020-09-17 20:41:44 +0200)=0D
=0D
----------------------------------------------------------------=0D
Pull request trivial patches 20200919=0D
=0D
----------------------------------------------------------------=0D
=0D
Dov Murik (2):=0D
  hw/timer/hpet: Remove unused functions hpet_ram_readb, hpet_ram_readw=0D
  hw/timer/hpet: Fix debug format strings=0D
=0D
Laszlo Ersek (1):=0D
  manual: escape backslashes in "parsed-literal" blocks=0D
=0D
Philippe Mathieu-Daud=3DC3=3DA9 (4):=0D
  hw/gpio/max7310: Remove impossible check=0D
  hw/ppc/ppc4xx_pci: Replace magic value by the PCI_NUM_PINS definition=0D
  ui/spice-input: Remove superfluous forward declaration=0D
  scripts/git.orderfile: Display meson files along with buildsys ones=0D
=0D
Yonggang Luo (1):=0D
  meson: remove empty else and duplicated gio deps=0D
=0D
zhaolichang (9):=0D
  qemu/: fix some comment spelling errors=0D
  migration/: fix some comment spelling errors=0D
  docs/: fix some comment spelling errors=0D
  scripts/: fix some comment spelling errors=0D
  util/: fix some comment spelling errors=0D
  linux-user/: fix some comment spelling errors=0D
  disas/: fix some comment spelling errors=0D
  qapi/: fix some comment spelling errors=0D
  contrib/: fix some comment spelling errors=0D
=0D
 Changelog                                |   2 +-=0D
 accel/tcg/user-exec.c                    |   2 +-=0D
 audio/audio.c                            |   2 +-=0D
 block.c                                  |   2 +-=0D
 configure                                |   2 +-=0D
 contrib/gitdm/filetypes.txt              |   6 +-=0D
 contrib/ivshmem-client/ivshmem-client.h  |   2 +-=0D
 contrib/libvhost-user/libvhost-user.c    |   4 +-=0D
 contrib/libvhost-user/libvhost-user.h    |   2 +-=0D
 disas/hppa.c                             |   2 +-=0D
 disas/m68k.c                             |   8 +-=0D
 disas/ppc.c                              |   2 +-=0D
 docs/COLO-FT.txt                         |   6 +-=0D
 docs/devel/blkdebug.txt                  |   2 +-=0D
 docs/devel/migration.rst                 |   2 +-=0D
 docs/devel/testing.rst                   |   2 +-=0D
 docs/devel/tracing.txt                   |   2 +-=0D
 docs/interop/bitmaps.rst                 |   2 +-=0D
 docs/interop/dbus.rst                    |   4 +-=0D
 docs/interop/nbd.txt                     |   2 +-=0D
 docs/interop/vhost-user-gpu.rst          |   2 +-=0D
 docs/interop/vhost-user.rst              |   4 +-=0D
 docs/rdma.txt                            |   2 +-=0D
 docs/specs/ppc-spapr-hotplug.txt         |   4 +-=0D
 docs/specs/ppc-spapr-xive.rst            |   4 +-=0D
 docs/system/arm/aspeed.rst               |   2 +-=0D
 docs/system/deprecated.rst               |   8 +-=0D
 docs/system/device-url-syntax.rst.inc    |   8 +-=0D
 docs/system/target-avr.rst               |   4 +-=0D
 docs/tools/virtiofsd.rst                 |   2 +-=0D
 fsdev/virtfs-proxy-helper.c              |   2 +-=0D
 hmp-commands.hx                          |   2 +-=0D
 hw/gpio/max7310.c                        |   5 +-=0D
 hw/ppc/ppc4xx_pci.c                      |   2 +-=0D
 hw/timer/hpet.c                          |  27 ++----=0D
 libdecnumber/decNumber.c                 |   2 +-=0D
 linux-user/aarch64/signal.c              |   2 +-=0D
 linux-user/cris/target_syscall.h         |   4 +-=0D
 linux-user/flat.h                        |   2 +-=0D
 linux-user/flatload.c                    |   4 +-=0D
 linux-user/host/ppc64/safe-syscall.inc.S |   2 +-=0D
 linux-user/syscall.c                     |   4 +-=0D
 meson.build                              |   6 --=0D
 migration/colo-failover.c                |   2 +-=0D
 migration/colo.c                         |   2 +-=0D
 migration/multifd.c                      |   4 +-=0D
 migration/postcopy-ram.c                 |   4 +-=0D
 migration/postcopy-ram.h                 |   2 +-=0D
 migration/ram.c                          |  10 +--=0D
 migration/rdma.c                         |   8 +-=0D
 migration/savevm.c                       |   4 +-=0D
 qapi/block-core.json                     |   4 +-=0D
 qapi/crypto.json                         |   4 +-=0D
 qemu-img.c                               |   2 +-=0D
 qemu-options.hx                          | 108 +++++++++++------------=0D
 qobject/qdict.c                          |   2 +-=0D
 scripts/checkpatch.pl                    |   2 +-=0D
 scripts/clean-header-guards.pl           |   2 +-=0D
 scripts/decodetree.py                    |   6 +-=0D
 scripts/git.orderfile                    |   1 +=0D
 scripts/oss-fuzz/build.sh                |   2 +-=0D
 scripts/tracetool/__init__.py            |   2 +-=0D
 scsi/pr-manager-helper.c                 |   2 +-=0D
 ui/spice-input.c                         |   1 -=0D
 util/osdep.c                             |   2 +-=0D
 util/qemu-progress.c                     |   2 +-=0D
 util/qemu-sockets.c                      |   2 +-=0D
 util/qemu-thread-win32.c                 |   2 +-=0D
 util/qht.c                               |   2 +-=0D
 util/trace-events                        |   2 +-=0D
 70 files changed, 163 insertions(+), 185 deletions(-)=0D
=0D
--=3D20=0D
2.26.2=0D
=0D

