Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA1BCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 08:41:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A726121929
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 08:41:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A726121929
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNv9y-0007dT-6W
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 04:41:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49600)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iNv4p-0000TL-Mh
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 04:36:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iNv4l-0007gW-N1
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 04:36:05 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:58099)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iNv4j-0007de-Ij; Fri, 25 Oct 2019 04:36:03 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MlfGs-1hfCKK4BIw-00ilT4; Fri, 25 Oct 2019 10:35:19 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 00/19] Trivial branch patches
Date: Fri, 25 Oct 2019 10:34:52 +0200
Message-Id: <20191025083511.11463-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:RwtqkjHdNARmJISc3Rzs9W/wGRmACyboV+Evky/xDoOxUn0HMWN
 jZ0NoyA2ecJQGFtauKS4oQ3PMhGmlD1D2zodmWXdLcIpmxqvz/yJ+6k/6P10YM2as2+Ts64
 nhHprYP/CNUWGzQCEBGRiSTT+AseJXhltW0DMb/lypW//rlTmleXarjNrid3h4TZoYM4qQY
 6wbX6lWskIv5NRfxeuOmA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:c8U04DEJ+mc=:NQxWj56HMsCx6Aum6yxrbp
 o6vgU6PqeNxF7y3w6zREYi7+Gn+sTx4kAyytboJTlvtdPD7uGkPk7XrIR/wYRPVvoPtg7QEcX
 mNkoAY2EKJC5TQAdBRO1PlMOQw7vpxhzbZyFYy9m6+kIjjQ5ZFYLyo+Azg0/dW+fZC2X5sPQp
 18W2vodRRsiy1rsw98c40mOCRmRm3NmUE5U5/ZOrxyGNZFssj2WEKxSSGxU2Fz95FKJwMcsAA
 WZL6M/A3bZ+8uERegZ+kY0X7K5Nul+nA67NFNmF7IleTwStJUKbHTSfgxGTybad57UbAu27Ee
 y6BMdB5Z9yZmMZm74nJFdkbvCqm/ZohEx95E6UTMwa4SgAHq1+rkPqVCg2210M6ffttP0K6X+
 8UOK9aw1QkHzDXdWyiqtiyUpdt+JkV4wH1VpTUgRp6vtvt+rxLAOMn0EW6RsmeMgfrJnrRjgz
 Dgw8MQW0N9RbSxcgzghUrJtH9/FGW+rmbWOr2jOBmqt1WL8TkoAkS+OYW+8/KshhX44HUKSly
 EpEOyJb74zAQy/KQklBp2+tmGqBYWEGebDbpnTC3EipRrWW8FJXMPHYq0BXEWbVJVGAD4JX8N
 T1lC63fiOe3qF9HS+3I8oqfSNSIplykUBvU6rePW1Xgu08xVoqUDZzmFJoUiApPAn5ZU46BQv
 Soawo419NIKCDjBlKwew9LqRABJgeHS0T1l3EmrTBJet6YOUmMLgHMjidZ2Mn/MEC/BbJsSjk
 iQ/p9vpSGNdxf/zR+/Kdd+ngNHmLdqtWB3HnUvy89hijhH9K12dx5x6whB6ivG04nGQgWxRsB
 hH4MiqY1df5SSr9/YDG97gC7fe4xhK/OZ1fWPV/yE8bBzrzUYdLMiAfoedQmpqe2lPpTjnOLn
 4TSbBCFAnALiuJRqPHP5xcITgWmLXYdKLUgMCuRuQ=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.133
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
 "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>, David Gibson <david@gibson.dropbear.id.au>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Andrew Jeffery <andrew@aj.id.au>,
 Laurent Vivier <laurent@vivier.eu>, Aleksandar Rikalo <arikalo@wavecomp.com>,
 qemu-ppc@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 58560ad254fbda71d4daa6622d71683190070ee2:

  Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-4.2-20191024' into staging (2019-10-24 16:22:58 +0100)

are available in the Git repository at:

  git://github.com/vivier/qemu.git tags/trivial-branch-pull-request

for you to fetch changes up to fabb862f76f093cdd1610571de9ba714d3333c1c:

  hw/rtc/aspeed_rtc: Remove unused includes (2019-10-24 20:35:28 +0200)

----------------------------------------------------------------
Fix typos and docs, trivial changes and RTC devices split

----------------------------------------------------------------

Frediano Ziglio (3):
  util/async: avoid useless cast
  event_notifier: avoid dandling file descriptor in
    event_notifier_cleanup
  qemu-timer: reuse MIN macro in qemu_timeout_ns_to_ms

Han Han (1):
  qemu-options.hx: Update for reboot-timeout parameter

Mao Zhongyi (1):
  pci_bridge: fix a typo in comment

Philippe Mathieu-Daudé (14):
  hw/timer: Compile devices not target-dependent as common object
  hw: Move PL031 device from hw/timer/ to hw/rtc/ subdirectory
  hw: Move MC146818 device from hw/timer/ to hw/rtc/ subdirectory
  hw: Move M48T59 device from hw/timer/ to hw/rtc/ subdirectory
  hw: Move M41T80 device from hw/timer/ to hw/rtc/ subdirectory
  hw: Move sun4v hypervisor RTC from hw/timer/ to hw/rtc/ subdirectory
  hw: Move TWL92230 device from hw/timer/ to hw/rtc/ subdirectory
  hw: Move DS1338 device from hw/timer/ to hw/rtc/ subdirectory
  hw: Move Xilinx ZynqMP RTC from hw/timer/ to hw/rtc/ subdirectory
  hw: Move Exynos4210 RTC from hw/timer/ to hw/rtc/ subdirectory
  hw: Move Aspeed RTC from hw/timer/ to hw/rtc/ subdirectory
  hw/rtc/mc146818: Include mc146818rtc_regs.h a bit less
  hw/rtc/xlnx-zynqmp-rtc: Remove unused "ptimer.h" include
  hw/rtc/aspeed_rtc: Remove unused includes

 MAINTAINERS                                  | 20 +++----
 Makefile.objs                                |  1 +
 hw/Kconfig                                   |  1 +
 hw/Makefile.objs                             |  1 +
 hw/alpha/dp264.c                             |  2 +-
 hw/arm/musca.c                               |  2 +-
 hw/hppa/machine.c                            |  2 +-
 hw/i386/acpi-build.c                         |  2 +-
 hw/i386/pc.c                                 |  2 +-
 hw/i386/pc_q35.c                             |  2 +-
 hw/mips/mips_fulong2e.c                      |  2 +-
 hw/mips/mips_jazz.c                          |  2 +-
 hw/mips/mips_malta.c                         |  2 +-
 hw/mips/mips_r4k.c                           |  2 +-
 hw/pci/pci_bridge.c                          |  2 +-
 hw/ppc/pnv.c                                 |  2 +-
 hw/ppc/ppc405_boards.c                       |  2 +-
 hw/ppc/prep.c                                |  4 +-
 hw/rtc/Kconfig                               | 23 ++++++++
 hw/rtc/Makefile.objs                         | 13 +++++
 hw/{timer => rtc}/aspeed_rtc.c               |  2 +-
 hw/{timer => rtc}/ds1338.c                   |  0
 hw/{timer => rtc}/exynos4210_rtc.c           |  0
 hw/{timer => rtc}/m41t80.c                   |  0
 hw/{timer => rtc}/m48t59-internal.h          |  0
 hw/{timer => rtc}/m48t59-isa.c               |  4 +-
 hw/{timer => rtc}/m48t59.c                   |  2 +-
 hw/{timer => rtc}/mc146818rtc.c              |  3 +-
 hw/{timer => rtc}/pl031.c                    |  2 +-
 hw/{timer => rtc}/sun4v-rtc.c                |  2 +-
 hw/rtc/trace-events                          | 19 +++++++
 hw/{timer => rtc}/twl92230.c                 |  0
 hw/{timer => rtc}/xlnx-zynqmp-rtc.c          |  3 +-
 hw/sparc/sun4m.c                             |  2 +-
 hw/sparc64/niagara.c                         |  2 +-
 hw/sparc64/sun4u.c                           |  2 +-
 hw/timer/Kconfig                             | 24 ---------
 hw/timer/Makefile.objs                       | 35 ++++--------
 hw/timer/hpet.c                              |  3 +-
 hw/timer/trace-events                        | 18 -------
 include/hw/arm/aspeed_soc.h                  |  2 +-
 include/hw/arm/xlnx-zynqmp.h                 |  2 +-
 include/hw/{timer => rtc}/aspeed_rtc.h       |  9 ++--
 include/hw/rtc/m48t59.h                      | 57 ++++++++++++++++++++
 include/hw/{timer => rtc}/mc146818rtc.h      | 13 +++--
 include/hw/{timer => rtc}/mc146818rtc_regs.h |  5 +-
 include/hw/{timer => rtc}/pl031.h            |  5 +-
 include/hw/rtc/sun4v-rtc.h                   | 19 +++++++
 include/hw/{timer => rtc}/xlnx-zynqmp-rtc.h  |  6 +--
 include/hw/timer/m48t59.h                    | 32 -----------
 include/hw/timer/sun4v-rtc.h                 |  1 -
 qemu-options.hx                              |  4 +-
 tests/rtc-test.c                             |  2 +-
 util/async.c                                 |  1 -
 util/event_notifier-posix.c                  |  2 +-
 util/qemu-timer.c                            |  6 +--
 56 files changed, 213 insertions(+), 165 deletions(-)
 create mode 100644 hw/rtc/Kconfig
 create mode 100644 hw/rtc/Makefile.objs
 rename hw/{timer => rtc}/aspeed_rtc.c (99%)
 rename hw/{timer => rtc}/ds1338.c (100%)
 rename hw/{timer => rtc}/exynos4210_rtc.c (100%)
 rename hw/{timer => rtc}/m41t80.c (100%)
 rename hw/{timer => rtc}/m48t59-internal.h (100%)
 rename hw/{timer => rtc}/m48t59-isa.c (98%)
 rename hw/{timer => rtc}/m48t59.c (99%)
 rename hw/{timer => rtc}/mc146818rtc.c (99%)
 rename hw/{timer => rtc}/pl031.c (99%)
 rename hw/{timer => rtc}/sun4v-rtc.c (98%)
 create mode 100644 hw/rtc/trace-events
 rename hw/{timer => rtc}/twl92230.c (100%)
 rename hw/{timer => rtc}/xlnx-zynqmp-rtc.c (99%)
 rename include/hw/{timer => rtc}/aspeed_rtc.h (80%)
 create mode 100644 include/hw/rtc/m48t59.h
 rename include/hw/{timer => rtc}/mc146818rtc.h (63%)
 rename include/hw/{timer => rtc}/mc146818rtc_regs.h (96%)
 rename include/hw/{timer => rtc}/pl031.h (93%)
 create mode 100644 include/hw/rtc/sun4v-rtc.h
 rename include/hw/{timer => rtc}/xlnx-zynqmp-rtc.h (95%)
 delete mode 100644 include/hw/timer/m48t59.h
 delete mode 100644 include/hw/timer/sun4v-rtc.h

-- 
2.21.0


