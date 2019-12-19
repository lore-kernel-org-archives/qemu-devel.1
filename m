Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E637C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 13:28:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 296472082E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 13:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YX9HdqNE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 296472082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihvqk-0001ff-Vy
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 08:28:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47748)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1ihvpY-0000Qc-Ss
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:27:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1ihvpV-0000iO-BU
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:27:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23929
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1ihvpU-0000bI-VG
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:27:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576762019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=IcwZF0QtWV86KcwXCV3cG//AYJLYIsKy266gGlXTyFE=;
 b=YX9HdqNEsMaGJCySPw9UEGAyZ54IzE69ABoUNrylmKd4rWV1uqkZV3xc85aKK13JSHOw/R
 K5+Ex+8yuhtED6FAKeGKPahwThfg1AWxtTvSMNdxXZwQxffcJVBE45ibbWhmsoW6VaPYFT
 VJUE4+hd78cM7qzOVOW07RIiuzhsEXk=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-2BP3XsR9PsCN-2nElraNsw-1; Thu, 19 Dec 2019 08:26:58 -0500
Received: by mail-qk1-f197.google.com with SMTP id m13so1260304qka.9
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 05:26:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:content-transfer-encoding;
 bh=QEtM1YSF08IkspTR+p6BEKPx2BZs1ZgvOdf43fGyXbA=;
 b=imZFWSfsGYPN6pEyqQ0XlwPmT+Z7p8Z24HyYhMttkIYi1AvMbh7X+gNCOUwG9PYBx8
 6kY4HS3x/cSLzCGqKvKNJ/ywqXGFzGh9haxXeECxCFW0E01KQ4JYPOhPJkJ06K/JKZKs
 AEjl1w+6oXSnqEWkAMZqE9gvAfrU9MyjYSHW/vGQW1CaGVPHYX8W95ny5+C3St/sF81V
 lLU/vOLaV6Dxb0Bd8Xy2b7+8eVgh4FNx4ctL/6pmmFdPrUju35Oy0Nr3pUEJfu2QNaYc
 Up35V8QR8wovnnYG13aoqWR/tOcbTJLIFQAkAv4eq5rs2l7Bnwp0BomzfTd5Kor87NNG
 i93Q==
X-Gm-Message-State: APjAAAX9DaUpIf6ZXwei9g4ojJGWinCQ0uWO8OLrkYg49zYX+Fsk+MlW
 H/lhcB24DBsQ/szhkC/X2CzcA+cOAqbRj6dXdYTi92lmaMqh5cK7vIJFv5CfNvRZcOFJd65JnVH
 pNRVc+81UWt9vhnI=
X-Received: by 2002:a37:a042:: with SMTP id j63mr8074162qke.156.1576762017415; 
 Thu, 19 Dec 2019 05:26:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqzaqRClnoL3yozE5yKtPkjuKh9/bufGqGDVRQtuC/PNHHfOmM6CXJz+4fuyi6SDFRYOPyw9gQ==
X-Received: by 2002:a37:a042:: with SMTP id j63mr8074138qke.156.1576762017082; 
 Thu, 19 Dec 2019 05:26:57 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
 by smtp.gmail.com with ESMTPSA id m68sm1253489qke.17.2019.12.19.05.26.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2019 05:26:56 -0800 (PST)
Date: Thu, 19 Dec 2019 08:26:52 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/24] virtio, pci, pc: fixes, features
Message-ID: <20191219132621.16595-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: 2BP3XsR9PsCN-2nElraNsw-1
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

The following changes since commit b0ca999a43a22b38158a222233d3f5881648bb4f=
:

  Update version for v4.2.0 release (2019-12-12 16:45:57 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to d4fbea918a37c0586f1a0e15ac6ef04c9fc7b96b:

  vhost-user-scsi: reset the device if supported (2019-12-19 08:25:35 -0500=
)

----------------------------------------------------------------
virtio, pci, pc: fixes, features

Bugfixes all over the place.
HMAT support.
New flags for vhost-user-blk utility.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
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

 docs/interop/vhost-user.json            |  31 ++++
 qapi/machine.json                       | 180 ++++++++++++++++++-
 hw/acpi/hmat.h                          |  42 +++++
 include/hw/pci/pci_host.h               |   4 +-
 include/hw/virtio/virtio.h              |  18 ++
 include/sysemu/numa.h                   |  63 +++++++
 contrib/vhost-user-blk/vhost-user-blk.c | 108 +++++++-----
 hw/acpi/hmat.c                          | 268 ++++++++++++++++++++++++++++
 hw/block/virtio-blk.c                   |   9 +-
 hw/char/virtio-serial-bus.c             |   8 +
 hw/core/machine.c                       |  65 +++++++
 hw/core/numa.c                          | 297 ++++++++++++++++++++++++++++=
++++
 hw/i386/acpi-build.c                    |   5 +
 hw/i386/intel_iommu.c                   |   7 +-
 hw/input/virtio-input.c                 |   5 +-
 hw/pci/pci_host.c                       |  25 +--
 hw/scsi/vhost-user-scsi.c               |  24 +++
 hw/scsi/virtio-scsi.c                   |   9 +-
 hw/virtio/vhost-user.c                  |   8 +-
 hw/virtio/virtio-balloon.c              |   7 +
 hw/virtio/virtio-mmio.c                 |  14 ++
 hw/virtio/virtio-pci.c                  |  14 +-
 hw/virtio/virtio.c                      |  63 +++++--
 tests/bios-tables-test.c                |  44 +++++
 tests/numa-test.c                       | 213 +++++++++++++++++++++++
 docs/interop/vhost-user.rst             |  32 ++++
 hw/acpi/Kconfig                         |   7 +-
 hw/acpi/Makefile.objs                   |   1 +
 qemu-options.hx                         |  95 +++++++++-
 tests/data/acpi/pc/APIC.acpihmat        | Bin 0 -> 128 bytes
 tests/data/acpi/pc/DSDT.acpihmat        | Bin 0 -> 6455 bytes
 tests/data/acpi/pc/HMAT.acpihmat        | Bin 0 -> 280 bytes
 tests/data/acpi/pc/SRAT.acpihmat        | Bin 0 -> 280 bytes
 tests/data/acpi/q35/APIC.acpihmat       | Bin 0 -> 128 bytes
 tests/data/acpi/q35/DSDT.acpihmat       | Bin 0 -> 9203 bytes
 tests/data/acpi/q35/HMAT.acpihmat       | Bin 0 -> 280 bytes
 tests/data/acpi/q35/SRAT.acpihmat       | Bin 0 -> 280 bytes
 37 files changed, 1558 insertions(+), 108 deletions(-)
 create mode 100644 hw/acpi/hmat.h
 create mode 100644 hw/acpi/hmat.c
 create mode 100644 tests/data/acpi/pc/APIC.acpihmat
 create mode 100644 tests/data/acpi/pc/DSDT.acpihmat
 create mode 100644 tests/data/acpi/pc/HMAT.acpihmat
 create mode 100644 tests/data/acpi/pc/SRAT.acpihmat
 create mode 100644 tests/data/acpi/q35/APIC.acpihmat
 create mode 100644 tests/data/acpi/q35/DSDT.acpihmat
 create mode 100644 tests/data/acpi/q35/HMAT.acpihmat
 create mode 100644 tests/data/acpi/q35/SRAT.acpihmat


