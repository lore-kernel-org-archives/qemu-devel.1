Return-Path: <SRS0=HB7V=X6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE97EC47404
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2019 22:06:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A69F222C5
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2019 22:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DoFGp0EQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A69F222C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGsBt-0001dV-1k
	for qemu-devel@archiver.kernel.org; Sat, 05 Oct 2019 18:06:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47737)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iGs4f-0004eN-Jy
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 17:58:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iGs4d-0003uG-Eu
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 17:58:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55021
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iGs4b-0003s0-HF
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 17:58:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1570312722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/mTXPCod6QOATgWHk4Rn3YPXQgIEkOl+e4o8JQC91fk=;
 b=DoFGp0EQGgS8znR9INyryIH0UOzYKXX19pnIEtHXEKRyzEjAuNuyjmm2xbGVTjfU0yCZLs
 amXQqrYAJoZimyBxWllStS8OvYbctbN3C6I0fJAuqCqdMIL7FIx2sJCKGZZqUKPqx59qhx
 7kw7Ana0tcB6YP7bTTCTEOvhhZrWBIY=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-MGppa5TPMVa_dgBl1AuVbA-1; Sat, 05 Oct 2019 17:58:38 -0400
Received: by mail-qt1-f197.google.com with SMTP id m20so10891883qtq.16
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2019 14:58:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=/zX62959WjftNZ3w8gbnQAVVZ0AftE/oIQrYZqQNvps=;
 b=hE5Yz4kiVfuFCg44hnvRvisZVfasrxDGfEUC+AIDQcddnMEe1yaoVMqFwDRgTNC4Sh
 gb2DBlS/s2uidxcffE7LIIJDsBfysRoZYS3+woFsIFZ/327lDzFIiPez4+9putoScYft
 Ms4oqlXA6e6jMsnsPtYpE5l5C013L+dPJBjyQbNIDAFez515NzW2srbfEDSQoy9i5r0Z
 CNC2c9vtmHWhAWBuryYuVKNqErQb/k+VZ1bksPVW7/3UUcr3x9e/tB/tpIBC3CzcMZmO
 SJJTl+aCrGO/F75jKgbx7+T1U/e/yvZGjvLNtOkYTZPIM2E7HitMg1aBP9bEXccmXS7i
 dexA==
X-Gm-Message-State: APjAAAXgU5CN+F+B/o2wBN+N5DM7VB3V/Ml/hfReaV8xKU9SOWEdvk5b
 KynLo6PUGdq7AB/6NlKvoqXhHBJmCVcVvwUMXog6zW5uRn1sFwtixo78RAGKJf06UE2lueVwpT/
 d9oTIslvicrxIOE4=
X-Received: by 2002:a0c:c15d:: with SMTP id i29mr20683577qvh.5.1570312717356; 
 Sat, 05 Oct 2019 14:58:37 -0700 (PDT)
X-Google-Smtp-Source: APXvYqza76riOyj4ugnisBPzk+lFhHUJJLITOKWFlAJE8fvryYO8Mae+gczdrxJPhfWjEZ4wNyl03w==
X-Received: by 2002:a0c:c15d:: with SMTP id i29mr20683561qvh.5.1570312717009; 
 Sat, 05 Oct 2019 14:58:37 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
 by smtp.gmail.com with ESMTPSA id
 r55sm5479743qtj.86.2019.10.05.14.58.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2019 14:58:36 -0700 (PDT)
Date: Sat, 5 Oct 2019 17:58:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/19] virtio, vhost, acpi: features, fixes, tests
Message-ID: <20191005215508.28754-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-MC-Unique: MGppa5TPMVa_dgBl1AuVbA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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

A couple of tweaks to the bios table test weren't
reviewed yet but as they are really helpful to
the arm tests I'm pushing, and affecting only the
test so fairly benign (dropped assert + a comment),
I cut a corner and pushed them straight away.
Will be easy to tweak with a patch on top or revert.

The following changes since commit 4f59102571fce49af180cfc6d4cdd2b5df7bdb14=
:

  Merge remote-tracking branch 'remotes/amarkovic/tags/mips-queue-oct-01-20=
19' into staging (2019-10-01 16:21:42 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 9d59bed1da5e5815987879346cf708344060ea63:

  virtio: add vhost-user-fs-pci device (2019-10-05 17:43:55 -0400)

----------------------------------------------------------------
virtio, vhost, acpi: features, fixes, tests

Tests for arm/virt ACPI tables.
Virtio fs support (no migration).
A vhost-user reconnect bugfix.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Adrian Moreno (1):
      vhost-user: save features if the char dev is closed

Dr. David Alan Gilbert (3):
      virtio: Add virtio_fs linux headers
      virtio: add vhost-user-fs base device
      virtio: add vhost-user-fs-pci device

Eric Auger (1):
      hw/arm/virt: Add memory hotplug framework

Michael S. Tsirkin (4):
      tests/acpi: add empty files
      tests: allow empty expected files
      tests: document how to update acpi tables
      tests/acpi: add expected tables for arm/virt

Samuel Ortiz (2):
      hw/acpi: Do not create memory hotplug method when handler is not defi=
ned
      hw/acpi: Add ACPI Generic Event Device Support

Shameer Kolothum (8):
      hw/acpi: Make ACPI IO address space configurable
      hw/arm/virt: Enable device memory cold/hot plug with ACPI boot
      hw/arm/virt-acpi-build: Add PC-DIMM in SRAT
      hw/arm: Factor out powerdown notifier from GPIO
      hw/arm: Use GED for system_powerdown event
      docs/specs: Add ACPI GED documentation
      tests: Update ACPI tables list for upcoming arm/virt tests
      tests: Add bios tests to arm/virt

 configure                                   |  13 ++
 include/hw/acpi/acpi_dev_interface.h        |   1 +
 include/hw/acpi/generic_event_device.h      | 103 +++++++++
 include/hw/acpi/memory_hotplug.h            |   9 +-
 include/hw/arm/virt.h                       |   5 +
 include/hw/i386/pc.h                        |   3 +
 include/hw/virtio/vhost-user-fs.h           |  45 ++++
 include/standard-headers/linux/virtio_fs.h  |  19 ++
 include/standard-headers/linux/virtio_ids.h |   2 +
 hw/acpi/generic_event_device.c              | 311 ++++++++++++++++++++++++=
++++
 hw/acpi/memory_hotplug.c                    |  43 ++--
 hw/arm/virt-acpi-build.c                    |  35 +++-
 hw/arm/virt.c                               | 124 +++++++++--
 hw/i386/acpi-build.c                        |   7 +-
 hw/i386/pc.c                                |   3 +
 hw/virtio/vhost-user-fs-pci.c               |  85 ++++++++
 hw/virtio/vhost-user-fs.c                   | 299 ++++++++++++++++++++++++=
++
 net/vhost-user.c                            |   4 +
 tests/bios-tables-test.c                    |  81 +++++++-
 docs/specs/acpi_hw_reduced_hotplug.rst      |  70 +++++++
 docs/specs/index.rst                        |   1 +
 hw/acpi/Kconfig                             |   4 +
 hw/acpi/Makefile.objs                       |   1 +
 hw/arm/Kconfig                              |   4 +
 hw/virtio/Makefile.objs                     |   2 +
 tests/data/acpi/virt/APIC.memhp             | Bin 0 -> 168 bytes
 tests/data/acpi/virt/APIC.numamem           | Bin 0 -> 168 bytes
 tests/data/acpi/virt/DSDT                   | Bin 18476 -> 18470 bytes
 tests/data/acpi/virt/DSDT.memhp             | Bin 0 -> 19807 bytes
 tests/data/acpi/virt/DSDT.numamem           | Bin 0 -> 18470 bytes
 tests/data/acpi/virt/FACP.memhp             | Bin 0 -> 268 bytes
 tests/data/acpi/virt/FACP.numamem           | Bin 0 -> 268 bytes
 tests/data/acpi/virt/GTDT.memhp             | Bin 0 -> 96 bytes
 tests/data/acpi/virt/GTDT.numamem           | Bin 0 -> 96 bytes
 tests/data/acpi/virt/MCFG.memhp             | Bin 0 -> 60 bytes
 tests/data/acpi/virt/MCFG.numamem           | Bin 0 -> 60 bytes
 tests/data/acpi/virt/SLIT.memhp             | Bin 0 -> 48 bytes
 tests/data/acpi/virt/SPCR.memhp             | Bin 0 -> 80 bytes
 tests/data/acpi/virt/SPCR.numamem           | Bin 0 -> 80 bytes
 tests/data/acpi/virt/SRAT.memhp             | Bin 0 -> 186 bytes
 tests/data/acpi/virt/SRAT.numamem           | Bin 0 -> 106 bytes
 41 files changed, 1232 insertions(+), 42 deletions(-)
 create mode 100644 include/hw/acpi/generic_event_device.h
 create mode 100644 include/hw/virtio/vhost-user-fs.h
 create mode 100644 include/standard-headers/linux/virtio_fs.h
 create mode 100644 hw/acpi/generic_event_device.c
 create mode 100644 hw/virtio/vhost-user-fs-pci.c
 create mode 100644 hw/virtio/vhost-user-fs.c
 create mode 100644 docs/specs/acpi_hw_reduced_hotplug.rst
 create mode 100644 tests/data/acpi/virt/APIC.memhp
 create mode 100644 tests/data/acpi/virt/APIC.numamem
 create mode 100644 tests/data/acpi/virt/DSDT.memhp
 create mode 100644 tests/data/acpi/virt/DSDT.numamem
 create mode 100644 tests/data/acpi/virt/FACP.memhp
 create mode 100644 tests/data/acpi/virt/FACP.numamem
 create mode 100644 tests/data/acpi/virt/GTDT.memhp
 create mode 100644 tests/data/acpi/virt/GTDT.numamem
 create mode 100644 tests/data/acpi/virt/MCFG.memhp
 create mode 100644 tests/data/acpi/virt/MCFG.numamem
 create mode 100644 tests/data/acpi/virt/SLIT.memhp
 create mode 100644 tests/data/acpi/virt/SPCR.memhp
 create mode 100644 tests/data/acpi/virt/SPCR.numamem
 create mode 100644 tests/data/acpi/virt/SRAT.memhp
 create mode 100644 tests/data/acpi/virt/SRAT.numamem


