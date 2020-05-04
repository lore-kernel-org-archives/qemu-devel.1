Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C946CC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:30:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 911AE20721
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R/SD9wOs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 911AE20721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVc6v-0006Br-MF
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 10:30:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47240)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jVc5w-0004Tv-GY
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:29:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35447
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jVc5u-0005lR-0y
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:29:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588602557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=kPPBIuLCXkXKwdxbJ9SWELJxTe/D10vY9gM/YUIe4dk=;
 b=R/SD9wOs36f1YcdJV2MRNATNEtw+RpaE3svqyKhJzFmQII0vR45AtOKrlDRjYR8IK1fvJb
 koUJzNGeF02YP3jnB6+XY2DYMMLiDTNIClms5ZHQ68kSk3rDalYLOGc6QVaF2YlNMRQU+1
 skFIp4Wm9irn5Bk9MiYIHJHbP0lQ6m4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-vEkMhuufOgqfiYFmr3o1Lw-1; Mon, 04 May 2020 10:29:15 -0400
X-MC-Unique: vEkMhuufOgqfiYFmr3o1Lw-1
Received: by mail-wr1-f72.google.com with SMTP id o8so10801990wrm.11
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 07:29:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:content-transfer-encoding;
 bh=NaTSn1n2vggpZpDpRVHNAFyEltcOMKsFILvtJ+PZhp4=;
 b=lrXmsFM2lS2J3U6eH3PV5xFx03aSzuJJynVYFYM4Xsj6yKfRilBi592Za4BrMkYn1p
 g82ttXYHLugSUsZU97enKy4FORlb7PlFY2uRuxcwGeU7+wO7oMCfTSTjtrZC4sfdk+lT
 x6ul3KBMDx38KqxdEgRzLDj1TtWcYuHEYyesyKa0EABb3W5EKE1LtVltJEuwAScJw1WN
 wn+amofSFDA51p3Otb+bxDCic2C+hCJ/2s6tmVOC7PPkUEA6ENZhDB53WfAM1M0W9sIU
 aydqPtBtVrxbWxR6BLu/E+RCaCtvcCxldu1PaybGts+i5yZmy8VJSHCm2zdrAeeEkyY5
 cI/A==
X-Gm-Message-State: AGi0PubNg1waXdw5AoncWSRYDSOziLoWsVWb3IYsp/4rBUCfE22qsJKM
 sWoLVv5Sl7XqJkdbyiiDXuBIJT0KZG7iLxhLKDFSCVIT+pj6cqD3iIqnEKl4gRtqKkqe+oc+Jse
 kvKzX+zC/DELtQdo=
X-Received: by 2002:a1c:8141:: with SMTP id c62mr14886263wmd.87.1588602554237; 
 Mon, 04 May 2020 07:29:14 -0700 (PDT)
X-Google-Smtp-Source: APiQypJJNTHqk6xVrSsLPnv2meubJQlZjs222ZTWYc0saKIw4mXDvWRnpp9AI8E3dEtB+YCQ+TkjyA==
X-Received: by 2002:a1c:8141:: with SMTP id c62mr14886253wmd.87.1588602554015; 
 Mon, 04 May 2020 07:29:14 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
 by smtp.gmail.com with ESMTPSA id
 i129sm14548786wmi.20.2020.05.04.07.29.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 07:29:13 -0700 (PDT)
Date: Mon, 4 May 2020 10:29:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/29] virtio,acpi,pci,pc: backlog from pre-5.0
Message-ID: <20200504142814.157589-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 05:09:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

The following changes since commit 9af638cc1f665712522608c5d6b8c03d8fa67666=
:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200=
504' into staging (2020-05-04 13:37:17 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to d8a05995bd64117bf5219d3ba7956277e608e3ca:

  hw/i386: Make vmmouse helpers static (2020-05-04 10:25:03 -0400)

----------------------------------------------------------------
virtio,acpi,pci,pc: backlog from pre-5.0

Mostly fixes, cleanups, but also new features for arm/virt and pc acpi.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Anthoine Bourgeois (2):
      virtio-vga: fix virtio-vga bar ordering
      virtio-pci: update virtio pci bar layout documentation

Gerd Hoffmann (6):
      move 'typedef Aml' to qemu/types.h
      acpi: add aml builder stubs
      qtest: allow DSDT acpi table changes
      acpi: drop pointless _STA method
      acpi: add ISADeviceClass->build_aml()
      rtc: add RTC_ISA_BASE

Julia Suvorova (2):
      hw/pci/pcie: Forbid hot-plug if it's disabled on the slot
      hw/pci/pcie: Replace PCI_DEVICE() casts with existing variable

Kwangwoo Lee (2):
      nvdimm: Use configurable ACPI IO base and size
      hw/arm/virt: Add nvdimm hot-plug infrastructure

Li Feng (1):
      vhost-user-blk: fix invalid memory access

Liran Alon (3):
      acpi: unit-test: Ignore diff in WAET ACPI table
      acpi: Add Windows ACPI Emulated Device Table (WAET)
      acpi: unit-test: Update WAET ACPI Table expected binaries

Michael S. Tsirkin (3):
      checkpatch: fix acpi check with multiple file name
      checkpatch: ignore allowed diff list
      acpi: DSDT without _STA

Philippe Mathieu-Daud=C3=A9 (4):
      hw/i386/pc: Create 'vmport' device in place
      hw/i386/vmport: Remove unused 'hw/input/i8042.h' include
      hw/i386: Add 'vmport.h' local header
      hw/i386: Make vmmouse helpers static

Raphael Norwitz (1):
      Refactor vhost_user_set_mem_table functions

Shameer Kolothum (5):
      hw/acpi/nvdimm: Fix for NVDIMM incorrect DSM output buffer length
      hw/arm/virt: Add nvdimm hotplug support
      tests: Update ACPI tables list for upcoming arm/virt test changes
      bios-tables-test: test pc-dimm and nvdimm coldplug for arm/virt
      tests/acpi: add expected tables for bios-tables-test

 hw/i386/acpi-build.h                   |   3 +
 hw/i386/vmport.h                       |  34 ++++++++
 include/hw/acpi/aml-build.h            |   1 -
 include/hw/acpi/generic_event_device.h |   1 +
 include/hw/arm/virt.h                  |   1 +
 include/hw/i386/pc.h                   |  13 ---
 include/hw/isa/isa.h                   |   2 +
 include/hw/mem/nvdimm.h                |   3 +
 include/hw/rtc/mc146818rtc.h           |   1 +
 include/qemu/typedefs.h                |   1 +
 hw/acpi/aml-build-stub.c               |  79 ++++++++++++++++++
 hw/acpi/generic_event_device.c         |  15 +++-
 hw/acpi/nvdimm.c                       |  72 ++++++++++++++---
 hw/arm/virt-acpi-build.c               |   6 ++
 hw/arm/virt.c                          |  35 ++++++--
 hw/block/vhost-user-blk.c              |   4 +
 hw/display/virtio-vga.c                |   1 +
 hw/i386/acpi-build.c                   |  52 +++++++++---
 hw/i386/pc.c                           |   3 +-
 hw/i386/pc_piix.c                      |   2 +
 hw/i386/pc_q35.c                       |   2 +
 hw/i386/vmmouse.c                      |  23 +++++-
 hw/i386/vmport.c                       |  25 +-----
 hw/isa/isa-bus.c                       |  15 ++++
 hw/pci/pcie.c                          |  25 +++++-
 hw/rtc/mc146818rtc.c                   |   5 +-
 hw/virtio/vhost-user.c                 | 143 +++++++++++++++--------------=
----
 hw/virtio/vhost.c                      |   2 +-
 hw/virtio/virtio-pci.c                 |   1 +
 tests/qtest/bios-tables-test.c         |   9 ++-
 docs/specs/acpi_hw_reduced_hotplug.rst |   3 +-
 hw/acpi/Makefile.objs                  |   4 +-
 hw/arm/Kconfig                         |   1 +
 hw/mem/Kconfig                         |   2 +-
 scripts/checkpatch.pl                  |  33 ++++----
 tests/data/acpi/pc/DSDT                | Bin 5131 -> 5125 bytes
 tests/data/acpi/pc/DSDT.acpihmat       | Bin 6455 -> 6449 bytes
 tests/data/acpi/pc/DSDT.bridge         | Bin 6990 -> 6984 bytes
 tests/data/acpi/pc/DSDT.cphp           | Bin 5594 -> 5588 bytes
 tests/data/acpi/pc/DSDT.dimmpxm        | Bin 6784 -> 6778 bytes
 tests/data/acpi/pc/DSDT.ipmikcs        | Bin 5203 -> 5197 bytes
 tests/data/acpi/pc/DSDT.memhp          | Bin 6490 -> 6484 bytes
 tests/data/acpi/pc/DSDT.numamem        | Bin 5137 -> 5131 bytes
 tests/data/acpi/pc/SSDT.dimmpxm        | Bin 685 -> 734 bytes
 tests/data/acpi/pc/WAET                | Bin 0 -> 40 bytes
 tests/data/acpi/q35/DSDT               | Bin 7869 -> 7863 bytes
 tests/data/acpi/q35/DSDT.acpihmat      | Bin 9193 -> 9187 bytes
 tests/data/acpi/q35/DSDT.bridge        | Bin 7886 -> 7880 bytes
 tests/data/acpi/q35/DSDT.cphp          | Bin 8332 -> 8326 bytes
 tests/data/acpi/q35/DSDT.dimmpxm       | Bin 9522 -> 9516 bytes
 tests/data/acpi/q35/DSDT.ipmibt        | Bin 7944 -> 7938 bytes
 tests/data/acpi/q35/DSDT.memhp         | Bin 9228 -> 9222 bytes
 tests/data/acpi/q35/DSDT.mmio64        | Bin 8999 -> 8993 bytes
 tests/data/acpi/q35/DSDT.numamem       | Bin 7875 -> 7869 bytes
 tests/data/acpi/q35/SSDT.dimmpxm       | Bin 685 -> 734 bytes
 tests/data/acpi/q35/WAET               | Bin 0 -> 40 bytes
 tests/data/acpi/virt/DSDT.memhp        | Bin 6644 -> 6668 bytes
 tests/data/acpi/virt/NFIT.memhp        | Bin 0 -> 224 bytes
 tests/data/acpi/virt/SSDT.memhp        | Bin 0 -> 736 bytes
 59 files changed, 449 insertions(+), 173 deletions(-)
 create mode 100644 hw/i386/vmport.h
 create mode 100644 hw/acpi/aml-build-stub.c
 create mode 100644 tests/data/acpi/pc/WAET
 create mode 100644 tests/data/acpi/q35/WAET
 create mode 100644 tests/data/acpi/virt/NFIT.memhp
 create mode 100644 tests/data/acpi/virt/SSDT.memhp


