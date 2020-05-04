Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF1A9C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:05:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C9B6206A4
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:05:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C9B6206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVZqQ-0003YO-II
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 08:05:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51970)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jVZjd-0002lb-LQ; Mon, 04 May 2020 07:58:09 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:56681)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jVZjY-0001mN-Sg; Mon, 04 May 2020 07:58:09 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MbBQU-1iyix72864-00bc8I; Mon, 04 May 2020 13:58:01 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 00/20] Trivial branch for 5.1 patches
Date: Mon,  4 May 2020 13:57:38 +0200
Message-Id: <20200504115758.283914-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tBJwOv8bE2eBF0fY88vmkqDjUtbtgnP3SpYz/dhSbso72ASJPkG
 ndE3/gGPxGCWHPUy1gsXcbd9CPcDVnLdfQc34oi/ROVkkcrXmBrC+OVxGwX/9OF/xXVBZmp
 swNSSYWag5NrXw7gxT/IXUFX/Ll6ZMgIx/zT0Ry9qOq/1Up4r4hnn9bACnHlUr8zfoqGdZX
 37gro6HqzmOn9+z/q7ztg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:98VtgozjV6w=:hQeQlZYBUIJK1UMxNxwKyA
 Ykbh1rsPZ40BpSfIRGaF9iINdTlA2oC5fp9ssbv0ck1tuYH9brjqpRMdQLnwUzbRIvjiW4PEU
 CXmJL5FwdIQC1Yc0miRu+7aNsm2aVc77CUDagybL+yRRk7wNu5f795yoQxR9/wsXkHwCru/Jt
 jP+GtrgR9dBxUp0Euq1Yx7/wBZh32edipXooqXHaDK9EtzjcgZmPggbkxlYHp5J116QcLY6wV
 hwRPr8Ifln2mYpcQFzEptgtFS7+KeXe8JWXI/0Fao42kFZKQlKmRG61vxF6pUBCxLWBl3Pcef
 g5YcBnVNcVRoCAG3bBeG/wH3WsfdJ/EKG+x/16UbKzeQ6CVnYX2lEdkI77+Z7ASDF4qX5iRue
 ih7kceKyQ8LTq4WX46Ib6z3K9VdnJwp8qzty9NpfSM8ajUszHhQZ9ePl8pmmAvxtMryc8AkXJ
 3LaFgdLUmyW9QPk4ut7Fj2XfQPiW9+Zmh3deLfDtaYkugXVXtr1ddyyxhFkAymQzh/6AIJ7qX
 Jz8Uyo0yZrpW7HxFSmQ7tAdWLqKgiYArRI0eXhhk3o440lzxJ6dBeo11ChUipvNF2xPaDOzdn
 TKzM5ElW64dQWpcQ1L8QSzhD8fEH0xc0E4/qnxlt/Oi8ypfY7coK8F59rZzKclfAqnl/sJIxf
 U3a9Nsn87/ntps/wJhT7NbggLfFRczkSG80szZRxLDPLjqTd848d69JPXqsavVcLWWcYr8Mmk
 kMJs+QR6ibR4QmRqM8RRpBl+nXp+59HhpQoM4VhavB3Mk4VCKmrlFv13A0cminpYW05uue1Ag
 OvJ10aNGmb3JjKDlA+uN87Jgkbi4Cs4wnvzOIlcSx9ZaGGiS7KHKhI18lva3loP9bOF7bpW
Received-SPF: none client-ip=217.72.192.75; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 07:58:02
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
for you to fetch changes up to 4341a0106781043a708c061b676312e5bb5d4488:=0D
=0D
  hw/timer/pxa2xx_timer: Add assertion to silent static analyzer warning (2=
02=3D=0D
0-05-04 12:06:21 +0200)=0D
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
Chen Qun (4):=0D
  scsi/esp-pci: add g_assert() for fix clang analyzer warning in=0D
    esp_pci_io_write()=0D
  display/blizzard: use extract16() for fix clang analyzer warning in=0D
    blizzard_draw_line16_32()=0D
  timer/exynos4210_mct: Remove redundant statement in=0D
    exynos4210_mct_write()=0D
  crypto: Redundant type conversion for AES_KEY pointer=0D
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
 block/file-posix.c         |  3 +--=0D
 block/nfs.c                |  3 +--=0D
 block/nvme.c               |  4 +---=0D
 block/vhdx.c               |  3 +--=0D
 blockdev.c                 |  2 +-=0D
 chardev/char-serial.c      |  2 +-=0D
 crypto/cipher-builtin.c    |  6 ++----=0D
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
 28 files changed, 45 insertions(+), 71 deletions(-)=0D
=0D
--=3D20=0D
2.26.2=0D
=0D

