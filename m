Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A0CC33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 16:31:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA31D2081E
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 16:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gTAB9Fjh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA31D2081E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iorla-0007sQ-Lg
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 11:31:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45754)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iorjk-0006Jf-C5
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:29:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iorjh-0004Uo-Ah
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:29:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51367
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iorjg-0004To-OS
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:29:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578414579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=yAgrKhqNgYy4cSlrJWB7CtH85YICbdDZQd1zHnyrxfY=;
 b=gTAB9FjhJRNoRQa0yiaHg5fR2Q1VTdLAlXhhEZbgXOtBfN/329z9PjyFjK3blmLvBPkou2
 pMolozdnq3qaPbGdsIeAdGEc+luQnHO/RFp14o4SIZxZwl8o26+Xk7x3lKzQSd50TEZsKA
 Zc7XTphrUesf6SiWGgpsQOVwTXaQCzc=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-jqttjkECPhmPDy3u8095Ow-1; Tue, 07 Jan 2020 11:29:37 -0500
Received: by mail-qk1-f199.google.com with SMTP id 24so127111qka.16
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 08:29:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:content-transfer-encoding;
 bh=D6krPWu8nfUyCXL/nCIsBXo092/Khn3FDPUCJt/Yoss=;
 b=fV6tYr0ucHKqUa2Qnm7XouKsfoig0M7xbOE+e2XovGG7HrrtfOshZ/f3eeRIn5Sae1
 luFL0uLtHOtc/4S5SrB2+Q2LQ5HMJX8RUsGUCMkbUTnkrU0fRnHR1gKfZLMKfUz0e3zj
 geu01RHHOXoMaXz93TYeuct63NkxKzssWnrB0R6Tm9SXPM/15aGtDyGDqGt1ASDEIjSX
 3T0ZMN1txH4sg3OPHXEBKhP831Wb+nHtBKa9NPpCh2y3qMH9xGQT8FNXrTbgPgGWq9p6
 rsl/hmm+CvMpYlYihrr4k9IBtRHZeqvVjhV0rRgGyRhRBEqB3xBFDnQ77sDqiYPk0lO/
 FoFQ==
X-Gm-Message-State: APjAAAXSN5Lb9Crtii4dVysIiJ3IMHRX9VkzROU5nJFkmkvKihPzpz80
 JYASyspIJIf4nIo0Yt5JYJAl8lj0i0vAwd0th3NDvGrmYBBfUQkCu89wsLFM0aZtM/05ol5iPVd
 90OkaGRkAjviWcTc=
X-Received: by 2002:a0c:f24a:: with SMTP id z10mr218583qvl.33.1578414577011;
 Tue, 07 Jan 2020 08:29:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqyWKj+VTW1HYUoGZMI/ZCJ0zwM0haK/Kc5nFDO+ZJeAdUuTJ7ZCHGnY0vpXc7qpfHChAvZGZQ==
X-Received: by 2002:a0c:f24a:: with SMTP id z10mr218555qvl.33.1578414576641;
 Tue, 07 Jan 2020 08:29:36 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id n4sm97065qti.55.2020.01.07.08.29.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 08:29:35 -0800 (PST)
Date: Tue, 7 Jan 2020 11:29:31 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 00/32] virtio, pci, pc: fixes, features
Message-ID: <20200107162850.411448-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: jqttjkECPhmPDy3u8095Ow-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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

changes from v2
    clang build fix
changes from v1
    clang build fix

The following changes since commit f0dcfddecee8b860e015bb07d67cfcbdfbfd51d9=
:

  Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' i=
nto staging (2020-01-03 17:18:08 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 56fc1e6ac6bde95bc0369d358587f2234d4dddad:

  intel_iommu: add present bit check for pasid table entries (2020-01-06 12=
:04:51 -0500)

----------------------------------------------------------------
virtio, pci, pc: fixes, features

Bugfixes all over the place.
HMAT support.
New flags for vhost-user-blk utility.
Auto-tuning of seg max for virtio storage.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Denis Plotnikov (4):
      hw: fix using 4.2 compat in 5.0 machine types for i440fx/q35
      virtio: make seg_max virtqueue size dependent
      tests: add virtio-scsi and virtio-blk seg_max_adjust test
      virtio-mmio: update queue size on guest write

Jean-Philippe Brucker (1):
      virtio-mmio: Clear v2 transport state on soft reset

Liu Jingqi (5):
      numa: Extend CLI to provide memory latency and bandwidth information
      numa: Extend CLI to provide memory side cache information
      hmat acpi: Build Memory Proximity Domain Attributes Structure(s)
      hmat acpi: Build System Locality Latency and Bandwidth Information St=
ructure(s)
      hmat acpi: Build Memory Side Cache Information Structure(s)

Liu Yi L (2):
      intel_iommu: a fix to vtd_find_as_from_bus_num()
      intel_iommu: add present bit check for pasid table entries

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

Yuri Benditovich (2):
      virtio: reset region cache when on queue deletion
      virtio-net: delete also control queue when TX/RX deleted

 docs/interop/vhost-user.json              |  31 ++++
 qapi/machine.json                         | 180 +++++++++++++++++-
 hw/acpi/hmat.h                            |  42 +++++
 hw/i386/intel_iommu_internal.h            |   1 +
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
 hw/i386/intel_iommu.c                     | 100 +++++++---
 hw/i386/pc_piix.c                         |   1 -
 hw/i386/pc_q35.c                          |   1 -
 hw/input/virtio-input.c                   |   5 +-
 hw/net/virtio-net.c                       |   3 +-
 hw/pci/pci_host.c                         |  25 +--
 hw/scsi/vhost-scsi.c                      |   2 +
 hw/scsi/vhost-user-scsi.c                 |  24 +++
 hw/scsi/virtio-scsi.c                     |  19 +-
 hw/virtio/vhost-user.c                    |   8 +-
 hw/virtio/virtio-balloon.c                |   7 +
 hw/virtio/virtio-mmio.c                   |  17 +-
 hw/virtio/virtio-pci.c                    |  14 +-
 hw/virtio/virtio.c                        |  64 +++++--
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
 45 files changed, 1796 insertions(+), 133 deletions(-)
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


