Return-Path: <SRS0=AgAn=2N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05FF3C2D0C0
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 17:00:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C29FC20709
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 17:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EBMo0dGq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C29FC20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ijR4h-0001Uw-E0
	for qemu-devel@archiver.kernel.org; Mon, 23 Dec 2019 12:00:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41750)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1ijQnX-0005n3-KG
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 11:43:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1ijQnW-0005uL-65
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 11:43:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38193
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1ijQnW-0005uD-23
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 11:43:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577119389;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=k9+gzlx294oW9w4JOk3CBVAZ2rl3jEfAGRzU1EfTm6U=;
 b=EBMo0dGqOLBCfEWIbMomAkmnZgm0YTvsuJl991s78czrP+VZ6XvHx02HNRs4iJAedSfPcD
 b2TFtg0i1Bm7mlqRO3Euxg4uuRiJAWD6okzzMjW/xm3Ut7Bua/mVztuxv/K/B/GX9bklMm
 qpZsqOUVpChsFNu7XycLBrU4UMAu+MM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-VWjQlXQdPcmxfKHeV6Mg6g-1; Mon, 23 Dec 2019 11:43:08 -0500
Received: by mail-qk1-f198.google.com with SMTP id 143so11436815qkg.12
 for <qemu-devel@nongnu.org>; Mon, 23 Dec 2019 08:43:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:content-transfer-encoding;
 bh=mef0O+8v+v2QwTMkvtiYxZXIRG7/ZbAgvOePkaVbC0s=;
 b=hqvemc4WamAfqS/J0wJU9KzS0UegXktGkdOyWe12fmbkUb205K6G58Kt0dDBZHB64Y
 4qkFPLooK71RgrNDfKWwmqVs7GaAqlbC0HfxPRAFZRQAd1+wdgzHRjG/rIizds9bam3e
 QUpXypbkxudh+hyiiqPxa3JmOhvC6jP835n46/NgDR6UdB84HcyNf8Zp5bAiuVhPGuqA
 rGMjFvwl+OjoohRjumFpTOiCFAINfIfvgzoRRcFV/LLoQfyJhc90L5gL2sIad4C5Ox/w
 pa+kpehbqSx4qo89eWtH3uIeoX9EBuBbxNKeiwXh3F05G/urmHVITqNyKYv3npxQShE/
 +ddw==
X-Gm-Message-State: APjAAAU8q6d8ELx9dgJcmcMFlXoQ0iOLrZonXo6lVxKUDccnf0jG2OUB
 cg/w4U8V1y0q195q3AxfBxFR3iEyrPeEvKgrzM+9Om026sVcquJc3PajprUvn1U3GZrOgq1ka52
 DYvFiNn2pO47d2iM=
X-Received: by 2002:a0c:edc2:: with SMTP id i2mr25438652qvr.62.1577119386478; 
 Mon, 23 Dec 2019 08:43:06 -0800 (PST)
X-Google-Smtp-Source: APXvYqyFcNEBNaORtAkh1Cz2IWvCrJjjBlj1H9dLsKfxg6EL4aLTT0MPJglWG/L0CWegTxKYBBDRGw==
X-Received: by 2002:a0c:edc2:: with SMTP id i2mr25438541qvr.62.1577119384724; 
 Mon, 23 Dec 2019 08:43:04 -0800 (PST)
Received: from redhat.com (bzq-109-64-31-13.red.bezeqint.net. [109.64.31.13])
 by smtp.gmail.com with ESMTPSA id
 q5sm5873521qkf.14.2019.12.23.08.43.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Dec 2019 08:43:03 -0800 (PST)
Date: Mon, 23 Dec 2019 11:43:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 00/27] virtio, pci, pc: fixes, features
Message-ID: <20191223141536.72682-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: VWjQlXQdPcmxfKHeV6Mg6g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit dd5b0f95490883cd8bc7d070db8de70d5c979cbc=
:

  Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20191219' into st=
aging (2019-12-20 16:37:07 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 585c70da17395114e5ec4f6f3f9f5068ae1ff0f3:

  tests: add virtio-scsi and virtio-blk seg_max_adjust test (2019-12-23 09:=
12:30 -0500)

----------------------------------------------------------------
virtio, pci, pc: fixes, features

Bugfixes all over the place.
HMAT support.
New flags for vhost-user-blk utility.
Auto-tuning of seg max for virtio storage.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------

Changes since v1:
    - (hopefully) fix build on Mac OSX
    - fix up 5.0 compat for pc
    - seg_max auto-config

Denis Plotnikov (3):
      hw: fix using 4.2 compat in 5.0 machine types for i440fx/q35
      virtio: make seg_max virtqueue size dependent
      tests: add virtio-scsi and virtio-blk seg_max_adjust test

Jean-Philippe Brucker (1):
      virtio-mmio: Clear v2 transport state on soft reset

Liu Jingqi (5):
      numa: Extend CLI to provide memory latency and bandwidth information
      numa: Extend CLI to provide memory side cache information
      hmat acpi: Build Memory Proximity Domain Attributes Structure(s)
      hmat acpi: Build System Locality Latency and Bandwidth Information St=
ructure(s)
      hmat acpi: Build Memory Side Cache Information Structure(s)

Michael Roth (1):
      virtio-pci: disable vring processing when bus-mastering is disabled

Michael S. Tsirkin (5):
      virtio: add ability to delete vq through a pointer
      virtio: make virtio_delete_queue idempotent
      virtio-input: convert to new virtio_delete_queue
      virtio: update queue size on guest write
      ACPI: add expected files for HMAT tests (acpihmat)

Micky Yun Chan (1):
      Implement backend program convention command for vhost-user-blk

Pan Nengyuan (2):
      virtio-balloon: fix memory leak while attach virtio-balloon device
      virtio-serial-bus: fix memory leak while attach virtio-serial-bus

Philippe Mathieu-Daud=C3=A9 (2):
      hw/pci/pci_host: Remove redundant PCI_DPRINTF()
      hw/pci/pci_host: Let pci_data_[read/write] use unsigned 'size' argume=
nt

Raphael Norwitz (2):
      vhost-user: add VHOST_USER_RESET_DEVICE to reset devices
      vhost-user-scsi: reset the device if supported

Stefan Hajnoczi (1):
      virtio: don't enable notifications during polling

Tao Xu (3):
      numa: Extend CLI to provide initiator information for numa nodes
      tests/numa: Add case for QMP build HMAT
      tests/bios-tables-test: add test cases for ACPI HMAT

Yi Sun (1):
      intel_iommu: fix bug to read DMAR_RTADDR_REG

 docs/interop/vhost-user.json              |  31 ++++
 qapi/machine.json                         | 180 +++++++++++++++++-
 hw/acpi/hmat.h                            |  42 +++++
 include/hw/pci/pci_host.h                 |   4 +-
 include/hw/virtio/virtio-blk.h            |   1 +
 include/hw/virtio/virtio-scsi.h           |   1 +
 include/hw/virtio/virtio.h                |  18 ++
 include/sysemu/numa.h                     |  63 +++++++
 contrib/vhost-user-blk/vhost-user-blk.c   | 108 ++++++-----
 hw/acpi/hmat.c                            | 268 ++++++++++++++++++++++++++=
+
 hw/block/virtio-blk.c                     |  18 +-
 hw/char/virtio-serial-bus.c               |   8 +
 hw/core/machine.c                         |  68 +++++++
 hw/core/numa.c                            | 297 ++++++++++++++++++++++++++=
++++
 hw/i386/acpi-build.c                      |   5 +
 hw/i386/intel_iommu.c                     |   7 +-
 hw/i386/pc_piix.c                         |   1 -
 hw/i386/pc_q35.c                          |   1 -
 hw/input/virtio-input.c                   |   5 +-
 hw/pci/pci_host.c                         |  25 +--
 hw/scsi/vhost-scsi.c                      |   2 +
 hw/scsi/vhost-user-scsi.c                 |  24 +++
 hw/scsi/virtio-scsi.c                     |  19 +-
 hw/virtio/vhost-user.c                    |   8 +-
 hw/virtio/virtio-balloon.c                |   7 +
 hw/virtio/virtio-mmio.c                   |  14 ++
 hw/virtio/virtio-pci.c                    |  14 +-
 hw/virtio/virtio.c                        |  63 +++++--
 tests/bios-tables-test.c                  |  44 +++++
 tests/numa-test.c                         | 213 +++++++++++++++++++++
 docs/interop/vhost-user.rst               |  32 ++++
 hw/acpi/Kconfig                           |   7 +-
 hw/acpi/Makefile.objs                     |   1 +
 qemu-options.hx                           |  95 +++++++++-
 tests/acceptance/virtio_seg_max_adjust.py | 134 ++++++++++++++
 tests/data/acpi/pc/APIC.acpihmat          | Bin 0 -> 128 bytes
 tests/data/acpi/pc/DSDT.acpihmat          | Bin 0 -> 6455 bytes
 tests/data/acpi/pc/HMAT.acpihmat          | Bin 0 -> 280 bytes
 tests/data/acpi/pc/SRAT.acpihmat          | Bin 0 -> 280 bytes
 tests/data/acpi/q35/APIC.acpihmat         | Bin 0 -> 128 bytes
 tests/data/acpi/q35/DSDT.acpihmat         | Bin 0 -> 9203 bytes
 tests/data/acpi/q35/HMAT.acpihmat         | Bin 0 -> 280 bytes
 tests/data/acpi/q35/SRAT.acpihmat         | Bin 0 -> 280 bytes
 43 files changed, 1716 insertions(+), 112 deletions(-)
 create mode 100644 hw/acpi/hmat.h
 create mode 100644 hw/acpi/hmat.c
 create mode 100755 tests/acceptance/virtio_seg_max_adjust.py
 create mode 100644 tests/data/acpi/pc/APIC.acpihmat
 create mode 100644 tests/data/acpi/pc/DSDT.acpihmat
 create mode 100644 tests/data/acpi/pc/HMAT.acpihmat
 create mode 100644 tests/data/acpi/pc/SRAT.acpihmat
 create mode 100644 tests/data/acpi/q35/APIC.acpihmat
 create mode 100644 tests/data/acpi/q35/DSDT.acpihmat
 create mode 100644 tests/data/acpi/q35/HMAT.acpihmat
 create mode 100644 tests/data/acpi/q35/SRAT.acpihmat


