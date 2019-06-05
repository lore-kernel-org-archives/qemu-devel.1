Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D15C2C28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 20:04:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63088207E0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 20:04:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63088207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49102 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYc9a-00062T-Im
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 16:04:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hYc5K-00031Y-7J
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 16:00:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hYc5H-0005Rg-9Y
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 16:00:33 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45117)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hYc55-0004e1-KF
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 16:00:23 -0400
Received: by mail-qt1-f193.google.com with SMTP id j19so15793634qtr.12
	for <qemu-devel@nongnu.org>; Wed, 05 Jun 2019 13:00:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
	:content-disposition;
	bh=ldbJ3yVur27BPk7Rjn88rZYMMv0OSSP4AG5eTN2aFs8=;
	b=aBWroLAnwi37L5/S/9HVpG42iNDBRZhzSBKp7fvwAndDQ2xuxA0G8KWTFRx02sWicx
	4DqOPZMgp3Mek7/X1bW1RDmjZDBk2jhtJPmE0hgnTXxAcyCbDpz/UKwcDWwCFLrO+yQk
	X1A7bt16j1YIIPMekXF1Gdl/2k1kPnqbpcNZvhFj3VIlWrzX3fnvdot50DHoldT/ntmN
	6JGICOgnPrYpoTO4TGH8WM/l/4qvrL/2oaqzz+IbhLfNeI9xfF2b7a4ZZeyqartv4A2L
	MW0BtTcHQPC2W7YfA0AQgzG4FdHSj4baWX0dXUXVJ6eJKlElYBtlyJUR2UDLLn5N92B0
	Y3+A==
X-Gm-Message-State: APjAAAUAj+i30ZMnXmriM/ubvUuMRHQxGOgmUSP5ioync3t+xpgrsfeF
	CYosxxNmpYn4wQmJXL8UgHMdHw34kCw=
X-Google-Smtp-Source: APXvYqzDAdwAintmmssqFBrw7ShpxroirbC/Mgy8H8Yk2VsBBQD+9jnmseWmoY9nUDOX1mP5yVFl4A==
X-Received: by 2002:a05:6214:206:: with SMTP id
	i6mr7663520qvt.169.1559764806682; 
	Wed, 05 Jun 2019 13:00:06 -0700 (PDT)
Received: from redhat.com (pool-100-0-197-103.bstnma.fios.verizon.net.
	[100.0.197.103]) by smtp.gmail.com with ESMTPSA id
	x55sm11445622qtx.33.2019.06.05.13.00.04
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Wed, 05 Jun 2019 13:00:05 -0700 (PDT)
Date: Wed, 5 Jun 2019 16:00:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190605195913.12243-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.193
Subject: [Qemu-devel] [PULL v3 00/17] virtio, pci, pc: cleanups, features
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

The following changes since commit 8c1ecb590497b0349c550607db923972b37f6963:

  Merge remote-tracking branch 'remotes/stsquad/tags/pull-testing-next-280519-2' into staging (2019-05-28 17:38:32 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 7f36f0930ffec11a551844c0452dbce33f80a525:

  bios-tables-test: ignore identical binaries (2019-06-05 15:54:15 -0400)

----------------------------------------------------------------
virtio, pci, pc: cleanups, features

stricter rules for acpi tables: we now fail
on any difference that isn't whitelisted.

vhost-scsi migration.

some cleanups all over the place

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
David Gibson (3):
      pcie: Simplify pci_adjust_config_limit()
      pci: Make is_bridge a bool
      pci: Fold pci_get_bus_devfn() into its sole caller

Igor Mammedov (3):
      docs: smbios: remove family=x from type2 entry description
      tests: add expected ACPI tables for arm/virt board
      tests: acpi: add simple arm/virt testcase

Jie Wang (3):
      vhost: remove the dead code
      vhost: fix incorrect print type
      vhost: fix memory leak in vhost_user_scsi_realize

Liran Alon (1):
      vhost-scsi: Allow user to enable migration

Michael S. Tsirkin (3):
      bios-tables-test: add diff allowed list
      bios-tables-test: list all tables that differ
      bios-tables-test: ignore identical binaries

Nir Weiner (2):
      vhost-scsi: The vhost backend should be stopped when the VM is not running
      vhost-scsi: Add VMState descriptor

Wei Yang (2):
      hw/acpi: Consolidate build_mcfg to pci.c
      acpi: pci: use build_append_foo() API to construct MCFG

 default-configs/i386-softmmu.mak        |   1 +
 include/hw/acpi/acpi-defs.h             |  18 ------
 include/hw/acpi/pci.h                   |   1 +
 include/hw/pci/pci.h                    |   3 +-
 include/hw/pci/pci_bus.h                |   8 ++-
 include/hw/virtio/vhost-scsi-common.h   |   1 +
 tests/bios-tables-test-allowed-diff.h   |   1 +
 hw/acpi/pci.c                           |  61 +++++++++++++++++++
 hw/arm/virt-acpi-build.c                |  17 ------
 hw/i386/acpi-build.c                    |  18 +-----
 hw/pci-bridge/dec.c                     |   4 +-
 hw/pci-bridge/i82801b11.c               |   2 +-
 hw/pci-bridge/pci_bridge_dev.c          |   2 +-
 hw/pci-bridge/pcie_pci_bridge.c         |   2 +-
 hw/pci-bridge/pcie_root_port.c          |   2 +-
 hw/pci-bridge/simba.c                   |   2 +-
 hw/pci-bridge/xio3130_downstream.c      |   2 +-
 hw/pci-bridge/xio3130_upstream.c        |   2 +-
 hw/pci/pci.c                            | 101 ++++++++++++++++----------------
 hw/pci/pci_host.c                       |  13 +---
 hw/ppc/spapr_pci.c                      |  34 ++++-------
 hw/scsi/vhost-scsi.c                    |  57 ++++++++++++++----
 hw/scsi/vhost-user-scsi.c               |   3 +
 hw/virtio/vhost.c                       |   3 +-
 tests/bios-tables-test.c                |  53 ++++++++++++++++-
 hw/acpi/Kconfig                         |   4 ++
 hw/acpi/Makefile.objs                   |   1 +
 hw/arm/Kconfig                          |   1 +
 qemu-options.hx                         |   2 +-
 tests/Makefile.include                  |   4 ++
 tests/data/acpi/rebuild-expected-aml.sh |   2 +-
 tests/data/acpi/virt/APIC               | Bin 0 -> 168 bytes
 tests/data/acpi/virt/DSDT               | Bin 0 -> 18476 bytes
 tests/data/acpi/virt/FACP               | Bin 0 -> 268 bytes
 tests/data/acpi/virt/GTDT               | Bin 0 -> 96 bytes
 tests/data/acpi/virt/MCFG               | Bin 0 -> 60 bytes
 tests/data/acpi/virt/SPCR               | Bin 0 -> 80 bytes
 37 files changed, 261 insertions(+), 164 deletions(-)
 create mode 100644 tests/bios-tables-test-allowed-diff.h
 create mode 100644 hw/acpi/pci.c
 create mode 100644 tests/data/acpi/virt/APIC
 create mode 100644 tests/data/acpi/virt/DSDT
 create mode 100644 tests/data/acpi/virt/FACP
 create mode 100644 tests/data/acpi/virt/GTDT
 create mode 100644 tests/data/acpi/virt/MCFG
 create mode 100644 tests/data/acpi/virt/SPCR


