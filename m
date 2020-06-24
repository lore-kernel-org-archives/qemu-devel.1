Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F48C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 23:08:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4835820738
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 23:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FqileQ3N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4835820738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joEUt-0001jh-HP
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 19:08:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42066)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1joETZ-0008Fc-U8
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 19:06:42 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45880
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1joETV-0001FZ-LS
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 19:06:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593039996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=yTRuaYf8iqP5WOLzbdNiPS5eyyGtRjkUVHVJyF4SYRM=;
 b=FqileQ3NyEU5nV33VTii1Tw3hnVvmM9IAWZbmUe/5vumVZBBeQXVIFBHLgIH1Pe7AXVO8G
 3QWVFVrnSEVqJp3xyCOwqdfta2jVFPOyN3GqxeMi2/kos4vEBDTRBdTNnfR10D1gV3fAQs
 lYmioHC0fB2cj+S5FoaUKAbtYEipkcM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-rlu6pR0YMvODNc6jtseycw-1; Wed, 24 Jun 2020 19:06:31 -0400
X-MC-Unique: rlu6pR0YMvODNc6jtseycw-1
Received: by mail-wm1-f69.google.com with SMTP id h6so4605590wmb.7
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 16:06:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=yTRuaYf8iqP5WOLzbdNiPS5eyyGtRjkUVHVJyF4SYRM=;
 b=GlhPtg13wqYz7gOLIY251g0y/ah3g0BAxBvR2M5Ruc6dk4+ahF6/0tpFgYx+1YZZ+5
 pDvnx59NjNhm2GB2+LwHpxPhJ6ed5lttNRS2A6YAq2UFu8yclI+QgS2L8xOnLdgJAKOn
 7cO3YOTZ+PNvx3p7Tb3B0coy+4r+uZcjCEHwIllNutTRnTINX1/AUivHMqCEzcUF8Jrn
 oU/+KRFOEioh29geYOtBqy78kUq5iiNiYobAsvxt9wglwcu5h2GQ8gR8qsQBXQOqTP5u
 mXF+9lhhDASENwyGsJjxhiTBrEAMWGIpiUKxeweG32UTcN6wPf1aP+ZNtPkZRzigXw+l
 tMiQ==
X-Gm-Message-State: AOAM533tBNjH6VGKWApdJSPcIrioSz//javo8IA5EoqtgLB7wqFFSC7/
 f6CMmokhzSjNKXxNAOwDlUA9vrcPK4Lgix56thvrViH/+paH/36uTmqppbbuFQYTt9oSvPK+pUY
 sEngJHnAsPmc01uE=
X-Received: by 2002:a7b:c345:: with SMTP id l5mr110697wmj.31.1593039990111;
 Wed, 24 Jun 2020 16:06:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz43Hkw3BzYhzIXJC1vqSMlk5BS8VPVQawynuCi6PReJwGzadhSqBduEa+sol4yhIRF0O3EkA==
X-Received: by 2002:a7b:c345:: with SMTP id l5mr110671wmj.31.1593039989825;
 Wed, 24 Jun 2020 16:06:29 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 o9sm28527804wrs.1.2020.06.24.16.06.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2020 16:06:28 -0700 (PDT)
Date: Wed, 24 Jun 2020 19:06:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/19] virtio,acpi,pci: fixes, cleanups, tools.
Message-ID: <20200624230609.703104-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 00:34:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

The following changes since commit d4b78317b7cf8c0c635b70086503813f79ff21ec:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200623' into staging (2020-06-23 18:57:05 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to f6f746db6bae1ba74967fd7bea2bb5e169502948:

  tests: disassemble-asm.sh: generate AML in readable format (2020-06-24 19:03:57 -0400)

----------------------------------------------------------------
virtio,acpi,pci: fixes, cleanups, tools.

Fixes, cleanups in ACPI, PCI, virtio.
A handy script for testing ACPI.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Ani Sinha (1):
      Rename use_acpi_pci_hotplug to more appropriate use_acpi_hotplug_bridge

Eric Auger (3):
      acpi: Some build_tpm2() code reshape
      arm/acpi: Add the TPM2.0 device under the DSDT
      docs/specs/tpm: ACPI boot now supported for TPM/ARM

Gerd Hoffmann (12):
      qtest: allow DSDT acpi table changes
      acpi: bios-tables-test: show more context on asl diffs
      acpi: move aml builder code for floppy device
      floppy: make isa_fdc_get_drive_max_chs static
      floppy: move cmos_get_fd_drive_type() from pc
      acpi: move aml builder code for i8042 (kbd+mouse) device
      acpi: factor out fw_cfg_add_acpi_dsdt()
      acpi: simplify build_isa_devices_aml()
      acpi: drop serial/parallel enable bits from dsdt
      acpi: drop build_piix4_pm()
      acpi: q35: drop _SB.PCI0.ISA.LPCD opregion.
      tests/acpi: update expected data files

Michael S. Tsirkin (1):
      tests: disassemble-asm.sh: generate AML in readable format

Raphael Norwitz (1):
      Stop vhost-user sending uninitialized mmap_offsets

Thomas Huth (1):
      tests/qtest/bios-tables: Only run the TPM test with CONFIG_TPM enabled

 hw/i386/fw_cfg.h                            |   1 +
 include/hw/acpi/acpi-defs.h                 |  18 ---
 include/hw/block/fdc.h                      |   3 +-
 include/hw/i386/pc.h                        |   1 -
 tests/qtest/bios-tables-test-allowed-diff.h |  18 +++
 hw/acpi/aml-build.c                         |  51 ++++---
 hw/acpi/piix4.c                             |  21 +--
 hw/arm/virt-acpi-build.c                    |  34 +++++
 hw/block/fdc.c                              | 111 ++++++++++++++-
 hw/i386/acpi-build.c                        | 210 +---------------------------
 hw/i386/fw_cfg.c                            |  28 ++++
 hw/i386/pc.c                                |  25 ----
 hw/input/pckbd.c                            |  31 ++++
 hw/virtio/vhost-user.c                      |  12 +-
 stubs/cmos.c                                |   7 +
 tests/qtest/bios-tables-test.c              |   8 +-
 docs/specs/tpm.rst                          |   2 -
 stubs/Makefile.objs                         |   1 +
 tests/data/acpi/disassemle-aml.sh           |  52 +++++++
 tests/data/acpi/pc/DSDT                     | Bin 5014 -> 4934 bytes
 tests/data/acpi/pc/DSDT.acpihmat            | Bin 6338 -> 6258 bytes
 tests/data/acpi/pc/DSDT.bridge              | Bin 6873 -> 6793 bytes
 tests/data/acpi/pc/DSDT.cphp                | Bin 5477 -> 5397 bytes
 tests/data/acpi/pc/DSDT.dimmpxm             | Bin 6667 -> 6587 bytes
 tests/data/acpi/pc/DSDT.ipmikcs             | Bin 5086 -> 5006 bytes
 tests/data/acpi/pc/DSDT.memhp               | Bin 6373 -> 6293 bytes
 tests/data/acpi/pc/DSDT.numamem             | Bin 5020 -> 4940 bytes
 tests/data/acpi/q35/DSDT                    | Bin 7752 -> 7678 bytes
 tests/data/acpi/q35/DSDT.acpihmat           | Bin 9076 -> 9002 bytes
 tests/data/acpi/q35/DSDT.bridge             | Bin 7769 -> 7695 bytes
 tests/data/acpi/q35/DSDT.cphp               | Bin 8215 -> 8141 bytes
 tests/data/acpi/q35/DSDT.dimmpxm            | Bin 9405 -> 9331 bytes
 tests/data/acpi/q35/DSDT.ipmibt             | Bin 7827 -> 7753 bytes
 tests/data/acpi/q35/DSDT.memhp              | Bin 9111 -> 9037 bytes
 tests/data/acpi/q35/DSDT.mmio64             | Bin 8882 -> 8808 bytes
 tests/data/acpi/q35/DSDT.numamem            | Bin 7758 -> 7684 bytes
 tests/data/acpi/q35/DSDT.tis                | Bin 8357 -> 8283 bytes
 37 files changed, 344 insertions(+), 290 deletions(-)
 create mode 100644 stubs/cmos.c
 create mode 100755 tests/data/acpi/disassemle-aml.sh


