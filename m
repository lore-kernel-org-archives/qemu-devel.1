Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2789C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 16:02:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6E49206D9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 16:02:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6E49206D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVdXq-0003CV-Ol
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 12:02:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37958)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jVdVj-000166-1E; Mon, 04 May 2020 12:00:03 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:57541)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jVdVh-0005h3-FB; Mon, 04 May 2020 12:00:02 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MFsIZ-1jMVDV3hNP-00HPWS; Mon, 04 May 2020 17:59:59 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 00/19] Trivial branch for 5.1 patches
Date: Mon,  4 May 2020 17:59:37 +0200
Message-Id: <20200504155956.380695-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8X93X9BA8SbCjdCaWf0GAFQQC6rxNOEKPMyjqxs1tRx6tejx0TX
 k87NL/TrrnGM/KscyS5xoDqUpKUb5PCA21kR854svk9kVrC0UKSlPD/RUQzrORpLLxVa1nX
 OoPw77pZq05nYaDzoIJqh7dRXx0rg/QTQJq9nCKSVhmVics8LFNAkLA+xTDRmyoO3+7fR/O
 o4Qu+XsEd+BwNFOpVecZw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IWrzMbkagxA=:1Ei0iSQw5lWbFFpSW1eKyt
 acyucOKFxehtqB7y2Hy5UheidiF1zzOYanjZvR6jYWJTh5ZQsxRUN1fzxV+R61ApxNqCbqh23
 xHZP/Zm7da237vJE8grmW3yy7NEJLvGw7VGbFAcn/T1OdF9QsO/r0bazr5MAw6bvqEzbIouWL
 Wi628UxlU7ewewTkAQWQntT5Ll2NE8T/5/wPaJE18Z3E8CgvRnTISY8Z0xvD8oaT/Z/mb37KQ
 IOtYNvkgskTmX+X0E0ExO0Jz7ms+4Gd0Zy7luMrSnn2vMoBKK/2oz7YQRNQKqvPYHvUOSrDSZ
 udGZjQiZ0AhDeh7BW6XPFiQTBEly+d6I0u8OMidT2mZ/jf0Qu9UT0KY0z48Qy8sBTU+l2Rr7h
 hFtMy99dOvVZKGcp4r4i3ect5V2vL6ps5YoWFwfCNS0GM1JEtUha1qhCewc6NyDj58CVMG+2r
 F8cj49F7xvgxuM/XscAa0rwpR+lF5g4wMPwndtVdKJnXpo2TwCrO8bKW8hz2pTRZgAUCTZzl1
 /IMJ+QxWP8TQ1ATAiZ5RTPSbK/6OgfFOA2HSLfKh89g5rVTLGKAkoqSm5WjpcWodrj364PH/t
 eWQG5iYOEzCFpwZoRxs1r+gP2i8uccCxZyMGSIpHJ0Aki2osAmIjLv2yxKbViwxubJvQ7crak
 j5gHUgsp/sDs5/0BxVl3mKkW3Bx8UjVOOHBs5uersOvIBgPGjSGyKxgzLbnu6FY0M1s7UkeY7
 wBapvoWl2SQ3fIo+3AO3wWFSg4vKQWrN2OIAYdUy1HBMHUoyWizKLcsh3RvdRw9pY4rlCHEe5
 BIePVMRR2FlC/Wn43zLwk++446E7y6xs7Fu6+SN71dXbMWeqk9Vy6tpGdsw0BjjMCLS9XQ9
Received-SPF: none client-ip=212.227.126.135; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 11:59:59
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

The following changes since commit 2ef486e76d64436be90f7359a3071fb2a56ce835=
:=0D
=0D
  Merge remote-tracking branch 'remotes/marcel/tags/rdma-pull-request' into=
 s=3D=0D
taging (2020-05-03 14:12:56 +0100)=0D
=0D
are available in the Git repository at:=0D
=0D
  git://github.com/vivier/qemu.git tags/trivial-branch-for-5.1-pull-request=
=0D
=0D
for you to fetch changes up to e702fba83108519618046a2a09235a62e3a81595:=0D
=0D
  hw/timer/pxa2xx_timer: Add assertion to silent static analyzer warning (2=
02=3D=0D
0-05-04 14:43:24 +0200)=0D
=0D
----------------------------------------------------------------=0D
trivial patches (20200504)=0D
=0D
Silent static analyzer warning=0D
Remove dead assignments=0D
Support -chardev serial on macOS=0D
Update MAINTAINERS=0D
Some cosmetic changes=0D
=0D
----------------------------------------------------------------=0D
=0D
Chen Qun (3):=0D
  scsi/esp-pci: add g_assert() for fix clang analyzer warning in=0D
    esp_pci_io_write()=0D
  display/blizzard: use extract16() for fix clang analyzer warning in=0D
    blizzard_draw_line16_32()=0D
  timer/exynos4210_mct: Remove redundant statement in=0D
    exynos4210_mct_write()=0D
=0D
Mikhail Gusarov (1):=0D
  chardev: Add macOS to list of OSes that support -chardev serial=0D
=0D
Peter Maydell (1):=0D
  elf_ops: Don't try to g_mapped_file_unref(NULL)=0D
=0D
Philippe Mathieu-Daud=3DC3=3DA9 (11):=0D
  MAINTAINERS: Mark the LatticeMico32 target as orphan=0D
  MAINTAINERS: Update Keith Busch's email address=0D
  block: Avoid dead assignment=0D
  blockdev: Remove dead assignment=0D
  hw/i2c/pm_smbus: Remove dead assignment=0D
  hw/input/adb-kbd: Remove dead assignment=0D
  hw/ide/sii3112: Remove dead assignment=0D
  hw/isa/i82378: Remove dead assignment=0D
  hw/gpio/aspeed_gpio: Remove dead assignment=0D
  hw/timer/stm32f2xx_timer: Remove dead assignment=0D
  hw/timer/pxa2xx_timer: Add assertion to silent static analyzer warning=0D
=0D
Simran Singhal (1):=0D
  Compress lines for immediate return=0D
=0D
Wainer dos Santos Moschetta (2):=0D
  hw/mem/pc-dimm: Print slot number on error at pc_dimm_pre_plug()=0D
  hw/mem/pc-dimm: Fix line over 80 characters warning=0D
=0D
 MAINTAINERS                | 14 +++++++-------=0D
 block.c                    |  2 +-=0D
 block/file-posix.c         |  8 +++-----=0D
 block/nfs.c                |  3 +--=0D
 block/nvme.c               |  4 +---=0D
 block/vhdx.c               |  3 +--=0D
 blockdev.c                 |  2 +-=0D
 chardev/char-serial.c      |  2 +-=0D
 hw/audio/ac97.c            |  4 +---=0D
 hw/audio/adlib.c           |  5 +----=0D
 hw/display/blizzard.c      | 10 ++++------=0D
 hw/display/cirrus_vga.c    |  4 +---=0D
 hw/gpio/aspeed_gpio.c      |  2 +-=0D
 hw/i2c/pm_smbus.c          |  1 -=0D
 hw/ide/sii3112.c           |  5 +++--=0D
 hw/input/adb-kbd.c         |  6 +-----=0D
 hw/isa/i82378.c            |  8 ++++----=0D
 hw/mem/pc-dimm.c           |  7 ++++---=0D
 hw/scsi/esp-pci.c          |  1 +=0D
 hw/timer/exynos4210_mct.c  |  4 ----=0D
 hw/timer/pxa2xx_timer.c    |  1 +=0D
 hw/timer/stm32f2xx_timer.c |  1 -=0D
 include/hw/elf_ops.h       |  4 +++-=0D
 include/qemu/osdep.h       |  2 +-=0D
 migration/ram.c            |  4 +---=0D
 ui/gtk.c                   |  3 +--=0D
 util/qemu-sockets.c        |  5 +----=0D
 27 files changed, 45 insertions(+), 70 deletions(-)=0D
=0D
--=3D20=0D
2.26.2=0D
=0D

