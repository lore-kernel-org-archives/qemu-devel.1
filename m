Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10DC9C34050
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 10:21:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE1F72464E
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 10:21:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE1F72464E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4MUG-0003Po-2R
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 05:21:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53159)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j4MPZ-0003Nm-Me
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 05:16:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j4MPY-0004wj-0y
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 05:16:57 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:47483)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1j4MPO-0004iN-2Z; Wed, 19 Feb 2020 05:16:46 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mofx1-1joSmR1F6H-00p0ta; Wed, 19 Feb 2020 11:16:18 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 00/17] Trivial branch patches
Date: Wed, 19 Feb 2020 11:15:55 +0100
Message-Id: <20200219101612.1033925-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:DWEuROI5o9vosqpwP6BG19STXPZ1c4bZ1l3abFEEupUeGg/SHvn
 U2YGGOh5iF2r+VpvOaCT1Sjrbi0fgTB3746shs+yzKNSymH/BBC8plpl4GOHd2MQ0sFNjUO
 p1AzteCY56soEvXbcQWA3Cx+V/noL4Hf61nWZWA9MQvRm+PQEYLVR4zRnV9inDDdY5j+v0e
 xkZbfp7ArBmH1Vny41sBw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5fVKbgXp3F4=:SDsfwZoehH39+FEyAxja5Q
 7Pd5UseZANsDD0GggysiWrTvsBUVNVrNgdXB2TV81wEgy23tCUJGCG0DPgvfAO9d3zLMIqOJD
 ehzsj7Pi3bWz6tP7sC4dnZPw8FFf8q0510KHVr5KFZ6NVRqVPatPMHIrTTWuE5y4Bolt2EeyB
 AXipSLiXLgQSgBHol0exaXKhCLPTYvaNC75J4BPidwaSySph1hM+7X/orL5cgL4254mBOe9BF
 JcMD4VpxRR5e5brdNZduIs/zY5SW3t370Q6AILpm4m8+0Lar9PRe0FowX/cWKQGIhBdEk+rHm
 hCTNz8DQpIaBTWcIoHI21I55fDpdfzFfUTlrqvFjcvGN7sc+t9kTQ1pra9nyKRWnKeMXcLeWs
 71TuzfpfaJ3qfxOvgAcq3H1jgnfuOkqSzPKAUp6pCpIkUJ8gWWoPXx+ALjrpgh1VPVUbfz0GX
 n1d1qmlwyxxmqDYUA+NSTsRPsCEeKFokLAxeZ78TiZJS0Sg+sppSXN6gPSOTqMJKcz2whC0ua
 i4yIaj+hLEUhM2ZvKoqK9wx8HyEENy5Sz82I3CzWntDxEn/1Q4S7pXmK+TyCDRvD4JFwQSOY2
 JgARlTiSPjsSX+rV0RXLIMncdR5hZYudg/RXnXt0AGYlkT1ald7h/Losnew2DfHEShj5IAzoH
 kJ1/JWNpo4YIMNtqCKHyc9aoKMaVtuTQgBgjhL4/NTpCZj+ON+ZMrsWwhvbkV2E1BFlEBn9G5
 Av3hO0OVIQxHcjY5sKHmuYvgh6lAkQokKlH5hN+iyTjZILxXOpxn60NkasKb2iG1ZTlM1zUM7
 KX2I6w/IjoAgCAtmbWKUDJr6ZgVuUWo0/PI8E4AXRTIHcRD00Wr/HpK/qT16MLiIQhRr4IQ
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.10
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Marek Vasut <marex@denx.de>,
 qemu-block@nongnu.org, qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>, Chris Wulff <crwulff@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 6c599282f8ab382fe59f03a6cae755b89561a7b3:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-monitor-2020-02-15-v2' into staging (2020-02-17 13:32:25 +0000)

are available in the Git repository at:

  git://github.com/vivier/qemu.git tags/trivial-branch-pull-request

for you to fetch changes up to d1cb67841ca213802ee789957188ec87e8b7996d:

  hw/xtensa/xtfpga:fix leak of fdevice tree blob (2020-02-19 10:33:38 +0100)

----------------------------------------------------------------
Fix memory leak with fdt
cosmetic change in code and logs
update mailmap

----------------------------------------------------------------

Chen Qun (2):
  hw/nios2:fix leak of fdevice tree blob
  hw/xtensa/xtfpga:fix leak of fdevice tree blob

Michal Privoznik (1):
  Report stringified errno in VFIO related errors

Philippe Mathieu-Daudé (13):
  scripts/checkpatch.pl: Detect superfluous semicolon in C code
  audio/alsaaudio: Remove superfluous semicolons
  hw/arm/xlnx-versal: Remove superfluous semicolon
  hw/m68k/next-cube: Remove superfluous semicolon
  hw/scsi/esp: Remove superfluous semicolon
  hw/vfio/display: Remove superfluous semicolon
  ui/input-barrier: Remove superfluous semicolon
  target/i386/whpx: Remove superfluous semicolon
  tests/qtest/libqos/qgraph: Remove superfluous semicolons
  contrib/rdmacm-mux: Remove superfluous semicolon
  hw/display/qxl: Remove unneeded variable assignment
  hw/block/pflash_cfi02: Remove unneeded variable assignment
  hw/net/rocker: Report unimplemented feature with qemu_log_mask(UNIMP)

Yu-Chen Lin (1):
  mailmap: Add entry for Yu-Chen Lin

 .mailmap                    |  3 ++-
 audio/alsaaudio.c           |  4 ++--
 contrib/rdmacm-mux/main.c   |  2 +-
 hw/arm/xlnx-versal-virt.c   |  2 +-
 hw/block/pflash_cfi02.c     |  1 -
 hw/display/qxl.c            |  2 +-
 hw/m68k/next-cube.c         |  2 +-
 hw/net/rocker/rocker.c      | 15 +++++++++------
 hw/nios2/boot.c             |  1 +
 hw/scsi/esp.c               |  2 +-
 hw/vfio/common.c            |  4 ++--
 hw/vfio/display.c           |  2 +-
 hw/xtensa/xtfpga.c          |  1 +
 scripts/checkpatch.pl       |  5 +++++
 target/i386/whpx-all.c      |  2 +-
 tests/qtest/libqos/qgraph.c |  4 ++--
 ui/input-barrier.c          |  2 +-
 util/vfio-helpers.c         |  6 +++---
 18 files changed, 35 insertions(+), 25 deletions(-)

-- 
2.24.1


