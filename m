Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD8CCA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 18:48:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4DE620862
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 18:48:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4DE620862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPA3e-0006yH-PR
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 14:48:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56543)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iP9Zl-0002dP-Tk
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 14:17:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iP9Zk-0003zx-AL
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 14:17:09 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:60413)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iP9Zh-0003w1-A1; Mon, 28 Oct 2019 14:17:05 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MbBUc-1hsIjC3cKm-00bZ7P; Mon, 28 Oct 2019 19:16:51 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 00/11] Q800 branch patches
Date: Mon, 28 Oct 2019 19:16:32 +0100
Message-Id: <20191028181643.5143-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:mMMU4cXoEHN5TnzjANB+/dSImJ6IEK3aAIawCdrqNq1s8KFjJJD
 OIS8tIC+I9fD8NmeRhA4d+DNXtOagaF4DSLjAAR2hXX9hqLSAeQSODadhINnwoHiTNHGCPb
 6VE1dAecBv4Vet5PK22pM8mdXjjmK0Qs8NOuEwOH+sc9fIZPnZircVMB4XfAiCAI1VHo7/M
 sy+WzZeR7pOeT1oGen9LQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nDwjzI0WGB8=:lAzhoercHctGbMSz2w86GP
 dMQoYX0XU2uPvLX96E7j7xyHL8xu+gGb8VRZmTzR5M0w843+hDXirDFkCrHCkXA75+0YWrhZf
 Rqwtb3m+LB82GiX3jFpkkhLFqaZNekz78zBrXuMZaqhJV0oonVSx5mzbtd7CsbD7Qk7NibTW+
 pcvtjJ+SdiZCNe0ZRslszjDko2DByPtLOGP1nxJhGdQMOQwKPnJz7Vy1aoBYT5xIFECtc6eZR
 Jrt15Dq5nbloI/X5qiIVXOKhGMM6O9N9Sazhc+1qeC6zvsgetkB4LU6N8waBDXbxAr4A5W3EX
 GbUbAw/C84Pmz3F330ZPF5tInPUi07qMAaAQteXl8/4A0j7tZQUDiML9Ew+68OihyBPULGsM9
 NbLdgJ9Ff6YYJ0vZUqk0HE5gqgz0wsWCm2+Wawb2TYPdhioA26n7b+5suMEMjKJc0MfoxYMmA
 y+oeGNILKy696QtlD0DmzF7q8OitVX0hX01XUvMa8l3tPbXLtt3R/9/+8W3F+J4bMDpOpFWqP
 A+QhXzImj5lmEV2ccXjvK1rmO/TEgTPCsPIfEBUFzlwx531CI3hOSlWNiUltIBc8X/lwAyRxE
 b5xFKMVGgx6UMzRCtFRPa/XZDM4CyTwq/U1t/kfs1g585d0KQYyhEZhN3h7cgcp5Nhf+vS996
 NjeqD59tv5OD6FIpKqYi4oBWDlPgjarfCmNGvDR9vx5Em0ksd1PttLxPBIB41feEJe4lkIhMQ
 H4r+CPicOhlnJZz9zGXGJeJCXDHgnjoT0D4DrJ1xPLfCtzbjRzXdWpTz7cKJIUTJMuodzQmRA
 tG/AZuiGfO+0M0da4p+L+rvhtk7+RClBUpxUEvrUf06+p+7u5iR2QUjxL4io1zKYPfdQuEEOG
 s/45nk35x7KsOlD/EQlJc5o8JNmRK7WRc1libwzGo=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 217.72.192.73
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 7bc8f9734213b76e76631a483be13d6737c2adbc:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20191025' into staging (2019-10-25 13:12:16 +0100)

are available in the Git repository at:

  git://github.com/vivier/qemu-m68k.git tags/q800-branch-pull-request

for you to fetch changes up to f7d85525f14b99aaa7bf561c9f3cf11c85a080c9:

  BootLinuxConsoleTest: Test the Quadra 800 (2019-10-28 19:07:22 +0100)

----------------------------------------------------------------
Add Macintosh Quadra 800 machine in hw/m68k

----------------------------------------------------------------

Laurent Vivier (10):
  esp: move handle_ti_cmd() cleanup code to esp_do_dma().
  esp: move get_cmd() post-DMA code to get_cmd_cb()
  esp: add pseudo-DMA as used by Macintosh
  dp8393x: manage big endian bus
  hw/m68k: add VIA support
  hw/m68k: implement ADB bus support for via
  hw/m68k: add Nubus support
  hw/m68k: add Nubus macfb video card
  hw/m68k: add a dummy SWIM floppy controller
  hw/m68k: define Macintosh Quadra 800

Philippe Mathieu-Daudé (1):
  BootLinuxConsoleTest: Test the Quadra 800

 default-configs/m68k-softmmu.mak       |   1 +
 hw/m68k/bootinfo.h                     | 114 +++
 include/hw/block/swim.h                |  76 ++
 include/hw/display/macfb.h             |  64 ++
 include/hw/misc/mac_via.h              | 115 +++
 include/hw/nubus/mac-nubus-bridge.h    |  24 +
 include/hw/nubus/nubus.h               |  69 ++
 include/hw/scsi/esp.h                  |  15 +
 arch_init.c                            |   4 +
 hw/block/swim.c                        | 489 +++++++++++++
 hw/display/macfb.c                     | 477 ++++++++++++
 hw/m68k/q800.c                         | 401 ++++++++++
 hw/misc/mac_via.c                      | 964 +++++++++++++++++++++++++
 hw/net/dp8393x.c                       |  88 ++-
 hw/nubus/mac-nubus-bridge.c            |  45 ++
 hw/nubus/nubus-bridge.c                |  34 +
 hw/nubus/nubus-bus.c                   | 111 +++
 hw/nubus/nubus-device.c                | 215 ++++++
 hw/scsi/esp.c                          | 336 ++++++++-
 vl.c                                   |   3 +-
 MAINTAINERS                            |  14 +
 hw/Kconfig                             |   1 +
 hw/Makefile.objs                       |   1 +
 hw/block/Kconfig                       |   3 +
 hw/block/Makefile.objs                 |   1 +
 hw/display/Kconfig                     |   5 +
 hw/display/Makefile.objs               |   1 +
 hw/m68k/Kconfig                        |  10 +
 hw/m68k/Makefile.objs                  |   1 +
 hw/misc/Kconfig                        |   5 +
 hw/misc/Makefile.objs                  |   1 +
 hw/nubus/Kconfig                       |   2 +
 hw/nubus/Makefile.objs                 |   4 +
 qemu-options.hx                        |   2 +-
 tests/acceptance/boot_linux_console.py |  24 +
 35 files changed, 3659 insertions(+), 61 deletions(-)
 create mode 100644 hw/m68k/bootinfo.h
 create mode 100644 include/hw/block/swim.h
 create mode 100644 include/hw/display/macfb.h
 create mode 100644 include/hw/misc/mac_via.h
 create mode 100644 include/hw/nubus/mac-nubus-bridge.h
 create mode 100644 include/hw/nubus/nubus.h
 create mode 100644 hw/block/swim.c
 create mode 100644 hw/display/macfb.c
 create mode 100644 hw/m68k/q800.c
 create mode 100644 hw/misc/mac_via.c
 create mode 100644 hw/nubus/mac-nubus-bridge.c
 create mode 100644 hw/nubus/nubus-bridge.c
 create mode 100644 hw/nubus/nubus-bus.c
 create mode 100644 hw/nubus/nubus-device.c
 create mode 100644 hw/nubus/Kconfig
 create mode 100644 hw/nubus/Makefile.objs

-- 
2.21.0


