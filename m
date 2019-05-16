Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B969C04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 12:19:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5233220833
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 12:19:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5233220833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53705 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRFM4-0000C9-Fn
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 08:19:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hRFKY-0007nA-R8
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:17:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hRFKU-0000rf-Rn
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:17:50 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:32789)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hRFKT-0000pt-7C
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:17:45 -0400
Received: by mail-qt1-f193.google.com with SMTP id m32so3607659qtf.0
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 05:17:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
	:content-disposition:content-transfer-encoding;
	bh=dAR8KJDd8ShibLuleWbM4A00yOc9z/Z/kU/9tuxjweU=;
	b=iIadjMsn7KOTqPFTBtvMnevkA4m5LkWISgomX5jmHrccELGHsU8y/ooGLxI3967OEX
	h6VUTUd8HTa+fUBnxSXf+uwBUAyXelf3Y4MW7hkpIOPefgTR73cH8Mrha0HY/awx+10D
	O0e/yJEjEBf5cPcn4CzsfXViz1dpIt1YyR/2GtCz2q/DyMhGMqM1i4YDP+vXquyWa+j1
	j+DfCwlKbDxcgv5PZddcEAicAclJLzIUd456EQEga400HFIJ99KP6ic/Tz3cxVWjQ/Rt
	LmL3DnOl6SrdoG6p/2gTSsKJ8NqJtqipP5Fd0m6EryEo5a3Jkqqzkk+iKO0qwI1EVSPj
	evuQ==
X-Gm-Message-State: APjAAAX9Hm2NT4/Vw2dEogrmtaW57xS4xW1zQQO1nviIgi19swUdTo4B
	yocLRDlf++KnEB54VfmBGmq1YtuuXbc=
X-Google-Smtp-Source: APXvYqzFWzKYc82Fc05EaxLMFKlz1w34tsikEgYHuunLmKvA3oymp2x5VepDlTMtFmgIW9nGkln1iA==
X-Received: by 2002:aed:2471:: with SMTP id s46mr41902053qtc.144.1558009062989;
	Thu, 16 May 2019 05:17:42 -0700 (PDT)
Received: from redhat.com ([185.54.206.10]) by smtp.gmail.com with ESMTPSA id
	l40sm3701572qtc.32.2019.05.16.05.17.41
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 16 May 2019 05:17:41 -0700 (PDT)
Date: Thu, 16 May 2019 08:17:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190515121146.7248-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.193
Subject: [Qemu-devel] [PULL 00/37] pci, pc, virtio: features, fixes
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit efb4f3b62c69383a7308d7b739a3193e7c0ccae8:

  Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2019-05-10 14:49:36 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 0534d255dae78450d90d59db0f3a9a46b32ebd73:

  tests: acpi: print error unable to dump ACPI table during rebuild (2019-05-14 21:19:14 -0400)

----------------------------------------------------------------
pci, pc, virtio: features, fixes

reconnect for vhost blk
tests for UEFI
misc other stuff

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Dan Streetman (1):
      do not call vhost_net_cleanup() on running net from char user event

Daniel P. Berrangé (2):
      hw: report invalid disable-legacy|modern usage for virtio-1-only devs
      Revert "globals: Allow global properties to be optional"

David Gibson (2):
      pcie: Remove redundant test in pcie_mmcfg_data_{read,write}()
      pci: Simplify pci_bus_is_root()

Igor Mammedov (16):
      q35: acpi: do not create dummy MCFG table
      tests: acpi: rename acpi_parse_rsdp_table() into acpi_fetch_rsdp_table()
      tests: acpi: make acpi_fetch_table() take size of fetched table pointer
      tests: acpi: make RSDT test routine handle XSDT
      tests: acpi: make pointer to RSDP 64bit
      tests: acpi: fetch X_DSDT if pointer to DSDT is 0
      tests: acpi: skip FACS table if board uses hw reduced ACPI profile
      tests: acpi: move boot_sector_init() into x86 tests branch
      tests: acpi: add acpi_find_rsdp_address_uefi() helper
      tests: acpi: add a way to start tests with UEFI firmware
      tests: acpi: ignore SMBIOS tests when UEFI firmware is used
      tests: acpi: allow to override default accelerator
      tests: add expected ACPI tables for arm/virt board
      tests: acpi: add simple arm/virt testcase
      tests: acpi: refactor rebuild-expected-aml.sh to dump ACPI tables for a specified list of targets
      tests: acpi: print error unable to dump ACPI table during rebuild

Li Feng (1):
      libvhost-user: fix bad vu_log_write

Marc-André Lureau (1):
      docs: reST-ify vhost-user documentation

Markus Armbruster (3):
      acpi/piix4: Convert debug printf()s to trace events
      acpi/pcihp: Convert debug printf()s to trace events
      acpi/pcihp: Add a few more trace points related to unplug

Wei Yang (4):
      hw/arm/virt-acpi-build: remove unnecessary variable mcfg_start
      i386, acpi: remove mcfg_ prefix in AcpiMcfgInfo members
      hw/arm/virt-acpi-build: pass AcpiMcfgInfo to build_mcfg()
      hw/acpi: Consolidate build_mcfg to pci.c

Xie Yongji (7):
      virtio: Introduce started flag to VirtioDevice
      virtio: Use started flag in virtio_vmstate_change()
      vhost-user-blk: Use started flag in vhost_user_blk_set_status()
      vhost-user-blk: Only start vhost-user backend with the first kick
      vhost-user-blk: Add return value for vhost_user_blk_start()
      vhost-user-blk: Add support to reconnect backend
      contrib/vhost-user-blk: enable inflight I/O tracking

 docs/interop/vhost-user.txt             | 1219 ----------------------------
 default-configs/arm-softmmu.mak         |    1 +
 default-configs/i386-softmmu.mak        |    1 +
 hw/virtio/virtio-pci.h                  |   31 +-
 include/hw/acpi/pci.h                   |   34 +
 include/hw/pci/pci.h                    |    1 -
 include/hw/pci/pci_bus.h                |   12 +-
 include/hw/qdev-core.h                  |    3 -
 include/hw/virtio/vhost-user-blk.h      |    3 +
 include/hw/virtio/virtio.h              |    2 +
 tests/acpi-utils.h                      |    7 +-
 contrib/libvhost-user/libvhost-user.c   |    2 +-
 contrib/vhost-user-blk/vhost-user-blk.c |    3 +-
 hw/acpi/pci.c                           |   46 ++
 hw/acpi/pcihp.c                         |   32 +-
 hw/acpi/piix4.c                         |   14 +-
 hw/arm/virt-acpi-build.c                |   31 +-
 hw/block/vhost-user-blk.c               |  175 +++-
 hw/core/machine.c                       |   23 +-
 hw/display/virtio-gpu-pci.c             |    4 +-
 hw/display/virtio-vga.c                 |    4 +-
 hw/i386/acpi-build.c                    |   44 +-
 hw/pci-bridge/pci_expander_bridge.c     |    6 -
 hw/pci/pci.c                            |   14 +-
 hw/pci/pcie_host.c                      |   10 -
 hw/virtio/virtio-crypto-pci.c           |    4 +-
 hw/virtio/virtio-input-pci.c            |    4 +-
 hw/virtio/virtio-pci.c                  |   27 +-
 hw/virtio/virtio.c                      |   54 +-
 net/vhost-user.c                        |    1 -
 qom/object.c                            |    3 -
 tests/acpi-utils.c                      |   68 +-
 tests/bios-tables-test.c                |  146 +++-
 tests/vmgenid-test.c                    |    6 +-
 MAINTAINERS                             |    2 +-
 docs/interop/index.rst                  |    2 +-
 docs/interop/vhost-user.rst             | 1351 +++++++++++++++++++++++++++++++
 hw/acpi/Kconfig                         |    4 +
 hw/acpi/Makefile.objs                   |    1 +
 hw/acpi/trace-events                    |   16 +
 tests/Makefile.include                  |    1 +
 tests/data/acpi/rebuild-expected-aml.sh |   23 +-
 tests/data/acpi/virt/APIC               |  Bin 0 -> 168 bytes
 tests/data/acpi/virt/DSDT               |  Bin 0 -> 18476 bytes
 tests/data/acpi/virt/FACP               |  Bin 0 -> 268 bytes
 tests/data/acpi/virt/GTDT               |  Bin 0 -> 96 bytes
 tests/data/acpi/virt/MCFG               |  Bin 0 -> 60 bytes
 tests/data/acpi/virt/SPCR               |  Bin 0 -> 80 bytes
 48 files changed, 1956 insertions(+), 1479 deletions(-)
 delete mode 100644 docs/interop/vhost-user.txt
 create mode 100644 include/hw/acpi/pci.h
 create mode 100644 hw/acpi/pci.c
 create mode 100644 docs/interop/vhost-user.rst
 create mode 100644 tests/data/acpi/virt/APIC
 create mode 100644 tests/data/acpi/virt/DSDT
 create mode 100644 tests/data/acpi/virt/FACP
 create mode 100644 tests/data/acpi/virt/GTDT
 create mode 100644 tests/data/acpi/virt/MCFG
 create mode 100644 tests/data/acpi/virt/SPCR


