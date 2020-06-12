Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E86EC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 14:52:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08AAC20835
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 14:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LaJhwpUY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08AAC20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjl2d-0006m3-8b
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 10:52:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49442)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjl1V-0005An-1w
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 10:51:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50756
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjl1Q-0001LW-3v
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 10:51:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591973466;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=eKTYxwayLNpkXF060tZh/cGwLkgo5rSi8JCr99cNP+8=;
 b=LaJhwpUYNZvjtjIxtVbrKjIZKFzGg6adLKN1YSXq/oVARdAHg6uUYeGUq1Ct5OA3hW6agL
 H5kgg4+3yEnPwd1bf1dFMxEnyRekkLQeB0fZnoXddQj2gYBBcxZy54vGnn7DT06XYjNPvv
 pGjxnl69KASudNO0OeNblxmO5LD0uAI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-Sro_S3DZPbq9I51p23dL7Q-1; Fri, 12 Jun 2020 10:51:04 -0400
X-MC-Unique: Sro_S3DZPbq9I51p23dL7Q-1
Received: by mail-wr1-f71.google.com with SMTP id t5so3973548wro.20
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 07:51:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:content-transfer-encoding;
 bh=eKTYxwayLNpkXF060tZh/cGwLkgo5rSi8JCr99cNP+8=;
 b=Pvlo4uN5cBDKhgDqTXzDjDrE3i/nP4aH+rXZ8hvemcJHh94qvREIkvHgOw2V8PzZ6t
 znSJdZ43cBFPsCkUFALtNw5HI6/+Rf0R3fUUYPd58zEFXXvftW8zxu395T5lyr8D7qgq
 5X9tl/QywWI+0uzR1eFs2dfzvgEUX7De0m4ZJWNyHdGK+6BeukfZO7CRqIIP6oskyq9a
 YATeYytqktYvYzNsK8H/HqAS7ZaJZE7Dh/F9GNPhy+kO8YFmbxHplUi5smtqzfIqhUwF
 ROrzeFyEDEyhrPY9bLnj5CVtbCoYhS7w7i0fdNciH29PKdWM7EZQ6dM56gdSxJmHKoxU
 QtVw==
X-Gm-Message-State: AOAM530LkgGPXmAroRdVP3GZ/huhPMgZHyj2XFXC8KUJLr5LPY9DEwIS
 msrvBaEE6x+X36g/htmkxk6F72BzKh4Nh6EkGWWxQUKmJAf0tghUxOFjP69H5pxcoosl8SxpWh/
 yw93D7cuFB3/l7b8=
X-Received: by 2002:a5d:5449:: with SMTP id w9mr15699963wrv.106.1591973462463; 
 Fri, 12 Jun 2020 07:51:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxgm6sDchqUmSHZYbJq+1FRRasKBel4Foaw7+38EUG9J+s/Lz160rr5e7p/IAX8rNgdxh+D7g==
X-Received: by 2002:a5d:5449:: with SMTP id w9mr15699933wrv.106.1591973462088; 
 Fri, 12 Jun 2020 07:51:02 -0700 (PDT)
Received: from redhat.com (bzq-79-178-18-124.red.bezeqint.net. [79.178.18.124])
 by smtp.gmail.com with ESMTPSA id x205sm8878775wmx.21.2020.06.12.07.51.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2020 07:51:01 -0700 (PDT)
Date: Fri, 12 Jun 2020 10:51:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 00/58] virtio,acpi,pci: features, fixes, cleanups, tests
Message-ID: <20200612141917.9446-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/12 08:00:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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

changes from v1:
- printf format fixed for 32 bit hosts
- a couple of bugfixes added

The following changes since commit 49ee11555262a256afec592dfed7c5902d5eefd2:

  Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-5.1-pull-request' into staging (2020-06-08 11:04:57 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 10d35e581901c09ee3817ac7cddd296d05291a9d:

  virtio-pci: fix queue_enable write (2020-06-12 10:17:06 -0400)

----------------------------------------------------------------
virtio,acpi,pci: features, fixes, cleanups, tests

Max slots negotiation for vhost-user.
Free page reporting for balloon.
Partial TPM2 ACPI support for ARM.
Support for NVDIMMs having their own proximity domains.
New vhost-user-vsock device.

Fixes, cleanups in ACPI, PCI, virtio.
New tests for TPM ACPI.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Alexander Duyck (2):
      virtio-balloon: Implement support for page poison reporting feature
      virtio-balloon: Provide an interface for free page reporting

David Hildenbrand (3):
      virtio-balloon: fix free page hinting without an iothread
      virtio-balloon: fix free page hinting check on unrealize
      virtio-balloon: unref the iothread when unrealizing

Dima Stepanov (2):
      char-socket: return -1 in case of disconnect during tcp_chr_write
      vhost-user-blk: delay vhost_user_blk_disconnect

Eric Auger (8):
      acpi: Convert build_tpm2() to build_append* API
      acpi: Move build_tpm2() in the generic part
      arm/acpi: TPM2 ACPI table support
      test/tpm-emu: include sockets and channel headers in tpm-emu header
      tests/acpi: Add void tables for Q35/TPM-TIS bios-tables-test
      tests: tpm-emu: Remove assert on TPM2_ST_NO_SESSIONS
      bios-tables-test: Add Q35/TPM-TIS test
      bios-tables-test: Generate reference tables for Q35/TPM-TIS

Gerd Hoffmann (12):
      qtest: allow DSDT acpi table changes
      acpi: move aml builder code for rtc device
      acpi: rtc: use a single crs range
      acpi: serial: don't use _STA method
      acpi: move aml builder code for serial device
      acpi: parallel: don't use _STA method
      acpi: move aml builder code for parallel device
      acpi: make build_madt() more generic.
      acpi: create acpi-common.c and move madt code
      acpi: madt: skip pci override on pci-less systems.
      acpi: fadt: add hw-reduced sleep register support
      acpi: ged: rename event memory region

Jason Wang (1):
      virtio-pci: fix queue_enable write

Julia Suvorova (1):
      hw/pci/pcie: Move hot plug capability check to pre_plug callback

Michael S. Tsirkin (2):
      msix: allow qword MSI-X table accesses
      tests/acpi: update DSDT expected files

Peter Xu (1):
      pci: Display PCI IRQ pin in "info pci"

Philippe Mathieu-Daudé (4):
      hw/pci-host/prep: Correct RAVEN bus bridge memory region size
      hw/pci/pci_bridge: Correct pci_bridge_io memory region size
      hw/pci/pci_bridge: Use the IEC binary prefix definitions
      hw/pci-host: Use the IEC binary prefix definitions

Prasad J Pandit (1):
      pci: assert configuration access is within bounds

Raphael Norwitz (11):
      Add helper to populate vhost-user message regions
      Add vhost-user helper to get MemoryRegion data
      Add VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS
      Transmit vhost-user memory regions individually
      Lift max memory slots limit imposed by vhost-user
      Refactor out libvhost-user fault generation logic
      Support ram slot configuration in libvhost-user
      Support adding individual regions in libvhost-user
      Support individual region unmap in libvhost-user
      Lift max ram slots limit in libvhost-user
      Fix parameter type in vhost migration log path

Stefan Berger (1):
      acpi: tpm: Do not build TCPA table for TPM 2

Stefan Hajnoczi (1):
      libvhost-user: advertise vring features

Stefano Garzarella (3):
      vhost-vsock: add vhost-vsock-common abstraction
      virtio: add vhost-user-vsock base device
      virtio: add vhost-user-vsock-pci device

Thomas Huth (2):
      MAINTAINERS: Fix the classification of bios-tables-test-allowed-diff.h
      hw/pci: Fix crash when running QEMU with "-nic model=rocker"

Vishal Verma (3):
      diffs-allowed: add the SRAT AML to diffs-allowed
      hw/acpi/nvdimm: add a helper to augment SRAT generation
      tests/acpi: update expected SRAT files

 configure                               |   3 +
 qapi/misc.json                          |   6 +-
 contrib/libvhost-user/libvhost-user.h   |  24 +-
 hw/i386/acpi-common.h                   |  15 +
 include/hw/acpi/acpi-defs.h             |   2 +
 include/hw/acpi/aml-build.h             |   2 +
 include/hw/acpi/generic_event_device.h  |   2 +-
 include/hw/mem/nvdimm.h                 |   1 +
 include/hw/virtio/vhost-user-vsock.h    |  36 ++
 include/hw/virtio/vhost-user.h          |   1 +
 include/hw/virtio/vhost-vsock-common.h  |  47 +++
 include/hw/virtio/vhost-vsock.h         |  11 +-
 include/hw/virtio/virtio-balloon.h      |   3 +-
 include/sysemu/tpm.h                    |   2 +
 tests/qtest/tpm-emu.h                   |   3 +
 chardev/char-socket.c                   |   7 +-
 contrib/libvhost-user/libvhost-user.c   | 351 +++++++++++++----
 contrib/vhost-user-blk/vhost-user-blk.c |   4 +-
 hw/acpi/aml-build.c                     |  49 ++-
 hw/acpi/generic_event_device.c          |  16 +-
 hw/acpi/nvdimm.c                        |  23 ++
 hw/arm/virt-acpi-build.c                |  11 +
 hw/block/vhost-user-blk.c               |  38 +-
 hw/char/parallel.c                      |  22 ++
 hw/char/serial-isa.c                    |  22 ++
 hw/core/machine.c                       |   4 +-
 hw/i386/acpi-build.c                    | 270 +------------
 hw/i386/acpi-common.c                   | 156 ++++++++
 hw/pci-host/i440fx.c                    |   3 +-
 hw/pci-host/prep.c                      |   2 +-
 hw/pci-host/q35.c                       |   2 +-
 hw/pci-host/versatile.c                 |   5 +-
 hw/pci/msix.c                           |   6 +
 hw/pci/pci.c                            |  18 +-
 hw/pci/pci_bridge.c                     |   7 +-
 hw/pci/pcie.c                           |  19 +-
 hw/rtc/mc146818rtc.c                    |  24 ++
 hw/virtio/vhost-user-vsock-pci.c        |  84 +++++
 hw/virtio/vhost-user-vsock.c            | 181 +++++++++
 hw/virtio/vhost-user.c                  | 646 +++++++++++++++++++++++++++-----
 hw/virtio/vhost-vsock-common.c          | 258 +++++++++++++
 hw/virtio/vhost-vsock.c                 | 283 +++-----------
 hw/virtio/vhost.c                       |   4 +-
 hw/virtio/virtio-balloon.c              | 137 ++++++-
 hw/virtio/virtio-pci.c                  |  12 +-
 monitor/hmp-cmds.c                      |   3 +-
 tests/qtest/bios-tables-test.c          |  58 +++
 tests/qtest/tpm-emu.c                   |   1 -
 MAINTAINERS                             |   3 +-
 docs/interop/vhost-user.rst             |  44 +++
 hw/i386/Makefile.objs                   |   1 +
 hw/virtio/Makefile.objs                 |   4 +-
 tests/data/acpi/pc/DSDT                 | Bin 5125 -> 5014 bytes
 tests/data/acpi/pc/DSDT.acpihmat        | Bin 6449 -> 6338 bytes
 tests/data/acpi/pc/DSDT.bridge          | Bin 6984 -> 6873 bytes
 tests/data/acpi/pc/DSDT.cphp            | Bin 5588 -> 5477 bytes
 tests/data/acpi/pc/DSDT.dimmpxm         | Bin 6778 -> 6667 bytes
 tests/data/acpi/pc/DSDT.ipmikcs         | Bin 5197 -> 5086 bytes
 tests/data/acpi/pc/DSDT.memhp           | Bin 6484 -> 6373 bytes
 tests/data/acpi/pc/DSDT.numamem         | Bin 5131 -> 5020 bytes
 tests/data/acpi/pc/SRAT.dimmpxm         | Bin 392 -> 392 bytes
 tests/data/acpi/q35/DSDT                | Bin 7863 -> 7752 bytes
 tests/data/acpi/q35/DSDT.acpihmat       | Bin 9187 -> 9076 bytes
 tests/data/acpi/q35/DSDT.bridge         | Bin 7880 -> 7769 bytes
 tests/data/acpi/q35/DSDT.cphp           | Bin 8326 -> 8215 bytes
 tests/data/acpi/q35/DSDT.dimmpxm        | Bin 9516 -> 9405 bytes
 tests/data/acpi/q35/DSDT.ipmibt         | Bin 7938 -> 7827 bytes
 tests/data/acpi/q35/DSDT.memhp          | Bin 9222 -> 9111 bytes
 tests/data/acpi/q35/DSDT.mmio64         | Bin 8993 -> 8882 bytes
 tests/data/acpi/q35/DSDT.numamem        | Bin 7869 -> 7758 bytes
 tests/data/acpi/q35/DSDT.tis            | Bin 0 -> 8357 bytes
 tests/data/acpi/q35/SRAT.dimmpxm        | Bin 392 -> 392 bytes
 tests/data/acpi/q35/TPM2.tis            | Bin 0 -> 76 bytes
 tests/data/acpi/virt/SRAT.memhp         | Bin 186 -> 226 bytes
 tests/qtest/Makefile.include            |   1 +
 75 files changed, 2183 insertions(+), 754 deletions(-)
 create mode 100644 hw/i386/acpi-common.h
 create mode 100644 include/hw/virtio/vhost-user-vsock.h
 create mode 100644 include/hw/virtio/vhost-vsock-common.h
 create mode 100644 hw/i386/acpi-common.c
 create mode 100644 hw/virtio/vhost-user-vsock-pci.c
 create mode 100644 hw/virtio/vhost-user-vsock.c
 create mode 100644 hw/virtio/vhost-vsock-common.c
 create mode 100644 tests/data/acpi/q35/DSDT.tis
 create mode 100644 tests/data/acpi/q35/TPM2.tis


