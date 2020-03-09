Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27840C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:17:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3B45222C3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:17:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3B45222C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBKA9-0003RQ-Uv
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 11:17:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33281)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jBK2P-0007ea-L3
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:09:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jBK2O-0007eV-Ci
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:09:49 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:55997)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1jBK2H-0007ZW-NY; Mon, 09 Mar 2020 11:09:41 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MBDvU-1j36H63dRW-00CkKu; Mon, 09 Mar 2020 16:08:43 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 00/33] Trivial branch patches
Date: Mon,  9 Mar 2020 16:08:04 +0100
Message-Id: <20200309150837.3193387-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:SApzpcpsmSfYibdb12MFYd1QAcw82t9w97GzLJeXDPb/WJsBOB8
 zZUEbwiC/d8fSglVHMz/fCsVgBhbDSq1I9QbdgMSXZ0MaDdYyJmYVLm0HyJ4pkdpbjBJZzG
 pywRwjJXcw4HWEXQBpaNmg7JLeySPbNrbZvOx1Wo6vn1+eEDzYOIq3v4NlFCOLtxn+EKqhV
 2v1pwrOgQgpHPQFnRhdHw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lcXOGMhUGlc=:kZ/DjWtgceH3kkelzqPL7P
 bkqCjNXTeDZdHd9A7rlKvvyM6ExUIvub/tImaEzlC3h8/uzb7+ETM1W/AAW+pwvu2vHV76x+I
 TYmpbBK6LwSIRwrqfp+3Uc15ky9DD9evBV66+RF1/AnrdwYHXTQzYoY/l0F8hO1iLEBzJZthT
 XXAC9gZlYCqwUDWpq7uu3Bg8ktFxPmEQ9JBLCx0ewSAbwEj12SnonmGIOsEZOrUhOjCeeL0aR
 lbm8b9RGejL72IWQw66vz3qUmS1FYZHVa80faQrFaL9LQ6T/ShtQLsvGETh4Rf31bwFIgnd0M
 9O2849cmO/FmPfkT8JDB/BrDJDI+2w/7hn/90kapL09fntqOSgp6PuC98LpaE6dxjRWTOZc1T
 knr9pKck/JbnmQga/gC7t+ZfjdLOpLSIm/qLyr/5HSIdpLNV/3SIFL/uoKpamzvLNKFK9ae3S
 B2R/DkQE1ABklRfiypKjm/oyCQvwyiLJx5qlio3Pts7OWV2MOf4kbznDeo5lb3qAqYVPSxSVN
 3y9MUx75QkU3DhBEz1uzaIjoSX3uWghh9VtQAi/XbfDU4yK5ibIsJzoIz7Wu2pXHUYH4TfXtN
 sLtDbRKxwK5gZ0c/QdjtJW76AufweNjCH6HZggU2bAicJBIV/Fo2kuQtnhL+E25HoL7jzRikc
 GM2pY+nQc+8zfl8XFAgeZ1pZbs6eCNEg4SsH+Y3HyrpokKDYeSoZHHq0QqxJUmGKSwNP8Y2kK
 7vHyaV3WEQ+71rEALxFJ91W4T97mYcustMBGd1ZSA8Bb8UiVcQCGr69tT+gC41IjrUsarTFNv
 Dfb0btiPnpYgJn2KXaGGV4F9o6OMCRDu9+KB08e92kyywBvQkJJtGxLZWRmKFeU3ZnQYhPY
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.74
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
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Alistair Francis <alistair@alistair23.me>, Greg Kurz <groug@kaod.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Max Reitz <mreitz@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 7a5853cec479a448edae0fb2aaf4e2f78c9c774d:

  Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2020-03-09 10:32:53 +0000)

are available in the Git repository at:

  git://github.com/vivier/qemu.git tags/trivial-branch-pull-request

for you to fetch changes up to 916c92503bd5348a33e561db600d8894bde636bb:

  monitor/hmp-cmds: Remove redundant statement in hmp_rocker_of_dpa_groups() (2020-03-09 15:59:31 +0100)

----------------------------------------------------------------
- includes cleanup
- reduce .data footprint
- fix warnings reported by Clang static code analyzer
- fix dp8393x part lost in merge
- update git.orderfile and rules.mak

----------------------------------------------------------------

Chen Qun (7):
  block/stream: Remove redundant statement in stream_run()
  block/file-posix: Remove redundant statement in raw_handle_perm_lock()
  dma/xlnx-zdma: Remove redundant statement in zdma_write_dst()
  scsi/scsi-disk: Remove redundant statement in
    scsi_disk_emulate_command()
  display/pxa2xx_lcd: Remove redundant statement in
    pxa2xx_palette_parse()
  display/exynos4210_fimd: Remove redundant statement in
    exynos4210_fimd_update()
  monitor/hmp-cmds: Remove redundant statement in
    hmp_rocker_of_dpa_groups()

Eric Blake (1):
  maint: Include top-level *.rst files early in git diff

Finn Thain (1):
  dp8393x: Mask EOL bit from descriptor addresses, take 2

Pan Nengyuan (1):
  core/qdev: fix memleak in qdev_get_gpio_out_connector()

Philippe Mathieu-Daudé (23):
  build-sys: Move the print-variable rule to rules.mak
  hw/audio/fmopl: Fix a typo twice
  hw/net/e1000: Add readops/writeops typedefs
  hw/net/e1000: Move macreg[] arrays to .rodata to save 1MiB of .data
  virtfs-proxy-helper: Make the helper_opts[] array const
  vl: Add missing "hw/boards.h" include
  hw/southbridge/ich9: Removed unused headers
  hw/i386/ioapic_internal: Remove unused "hw/i386/ioapic.h" header
  hw/timer: Remove unused "ui/console.h" header
  hw/usb/dev-storage: Remove unused "ui/console.h" header
  hw/i386/intel_iommu: Remove unused includes
  hw/alpha/alpha_sys: Remove unused "hw/ide.h" header
  hw/alpha/dp264: Include "net/net.h"
  hw/hppa/machine: Include "net/net.h"
  hw/acpi/cpu_hotplug: Include "hw/pci/pci.h"
  hw/timer/hpet: Include "exec/address-spaces.h"
  hw/pci-host/q35: Include "qemu/range.h"
  hw/i2c/smbus_ich9: Include "qemu/range.h"
  hw/pci-host/piix: Include "qemu/range.h"
  hw/acpi: Include "hw/mem/nvdimm.h"
  hw/i386: Include "hw/mem/nvdimm.h"
  hw/pci-host/q35: Remove unused includes
  hw/i386/pc: Clean up includes

 Makefile                          |  3 ---
 block/file-posix.c                |  1 -
 block/stream.c                    |  3 +--
 fsdev/virtfs-proxy-helper.c       |  2 +-
 hw/acpi/cpu_hotplug.c             |  1 +
 hw/acpi/ich9.c                    |  2 +-
 hw/acpi/piix4.c                   |  1 +
 hw/alpha/alpha_sys.h              |  1 -
 hw/alpha/dp264.c                  |  1 +
 hw/audio/fmopl.c                  |  4 ++--
 hw/core/qdev.c                    |  2 +-
 hw/display/exynos4210_fimd.c      |  1 -
 hw/display/pxa2xx_lcd.c           |  1 -
 hw/dma/xlnx-zdma.c                | 10 +++++-----
 hw/hppa/machine.c                 |  1 +
 hw/i2c/smbus_ich9.c               |  1 +
 hw/i386/acpi-build.c              |  1 +
 hw/i386/pc.c                      |  1 +
 hw/i386/pc_piix.c                 |  1 +
 hw/i386/pc_q35.c                  |  1 +
 hw/isa/lpc_ich9.c                 |  1 -
 hw/net/dp8393x.c                  |  4 ++--
 hw/net/e1000.c                    |  6 ++++--
 hw/net/e1000e_core.c              |  6 ++++--
 hw/pci-host/i440fx.c              |  1 +
 hw/pci-host/q35.c                 |  1 +
 hw/rtc/twl92230.c                 |  1 -
 hw/scsi/scsi-disk.c               |  1 -
 hw/timer/hpet.c                   |  2 +-
 hw/usb/dev-storage.c              |  1 -
 include/hw/i386/ich9.h            |  1 -
 include/hw/i386/intel_iommu.h     |  4 ----
 include/hw/i386/ioapic_internal.h |  1 -
 include/hw/i386/pc.h              | 11 +++--------
 include/hw/pci-host/q35.h         |  8 +-------
 monitor/hmp-cmds.c                |  5 +----
 rules.mak                         |  3 +++
 scripts/git.orderfile             |  1 +
 softmmu/vl.c                      |  1 +
 39 files changed, 43 insertions(+), 55 deletions(-)

-- 
2.24.1


