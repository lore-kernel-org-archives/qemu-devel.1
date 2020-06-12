Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C2EC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 16:15:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 729CA20801
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 16:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ebv7NWYB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 729CA20801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjmLK-0005Ws-Lj
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 12:15:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60418)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjmKh-00056E-91
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 12:15:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35122
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjmKe-0002gu-IA
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 12:15:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591978503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7U1BQCzJR+OvRN7i4AWbk+G7QzZalmOt34EdX7HznFo=;
 b=ebv7NWYBNHgF8QsFTNcOYSOmd+6UE/XDWrCNszNyVNVWiSpyf07gS0pvQKvYnUDdt7sTwr
 gcT9WewVzwynTXub5Hbp8zst0APil5M4mXNwb02ZqDwHq1J/HrhSdgoyhwizyI7FBBdv7e
 BOXu6AZkLFgJHcrLIjlB6IzgFFHJvQ4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-Lx2ng53qN66mTRRYVSM6aQ-1; Fri, 12 Jun 2020 12:11:38 -0400
X-MC-Unique: Lx2ng53qN66mTRRYVSM6aQ-1
Received: by mail-wr1-f71.google.com with SMTP id l18so4096854wrm.0
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 09:11:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=7U1BQCzJR+OvRN7i4AWbk+G7QzZalmOt34EdX7HznFo=;
 b=t3zlZF25j8XH0vno7OYDiQlE6ufsEdfhCwfQXOnQFSURcmf5NJSMpNqkQK03elQmAJ
 WM57RglxaUt/TTwGXYynIVMfoQ/yfxO4+13kJOgYNY3G28YsoZKLDTwoU1L8PnOi8Knc
 ovEs2bICAjH7438nMXcE0GJ7KeAijBZqFfzJu8AExNdEYB3AMbiFfpAVK5YlQZPx4sjd
 Bct4OnXxu/hLO2yW+9oqAH3D0XQ+pB9v1QeBg0uiTDUd5pXFhoCvLBGewq20iBGB+8ve
 IUJaEDMtymezfXU8NYscqMbm1AIeT465veS+7HU8zW+BvmeYE1X2TZJ6Gh205bmV8REK
 yNSw==
X-Gm-Message-State: AOAM530Dgs/4+HBBBSfqewolO6RXhqf90HCUJSsks1y1BtKQkSdFvnHA
 SRDMtanEGzSsZGj9OZjP01brb8B9L7PnENvBhWdKxVZbK1wc555QfTorz2xXp6UY9nIH4dpinyY
 PAI5IxiJ91CVdnho=
X-Received: by 2002:a1c:544d:: with SMTP id p13mr14952582wmi.25.1591978296850; 
 Fri, 12 Jun 2020 09:11:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz5qT7utu9k1msJTpvOP+WHuvGSNn/lKxo05YOmJwGujH50iDsh8w6+AwFQdDaCGTaKlPQ7bg==
X-Received: by 2002:a1c:544d:: with SMTP id p13mr14952558wmi.25.1591978296538; 
 Fri, 12 Jun 2020 09:11:36 -0700 (PDT)
Received: from redhat.com (bzq-79-178-18-124.red.bezeqint.net. [79.178.18.124])
 by smtp.gmail.com with ESMTPSA id r5sm10677655wrq.0.2020.06.12.09.11.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2020 09:11:35 -0700 (PDT)
Date: Fri, 12 Jun 2020 12:11:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PULL v2 00/58] virtio, acpi, pci: features, fixes, cleanups,
 tests
Message-ID: <20200612120750-mutt-send-email-mst@kernel.org>
References: <20200612141917.9446-1-mst@redhat.com>
 <159197710509.1247.17471146455948380339@45ef0f9c86ae>
MIME-Version: 1.0
In-Reply-To: <159197710509.1247.17471146455948380339@45ef0f9c86ae>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 12, 2020 at 08:51:46AM -0700, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20200612141917.9446-1-mst@redhat.com/
> 
> 
> 
> Hi,
> 
> This series seems to have some coding style problems. See output below for
> more information:
> 
> Message-id: 20200612141917.9446-1-mst@redhat.com
> Subject: [PULL v2 00/58] virtio,acpi,pci: features, fixes, cleanups, tests
> Type: series
> 
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> git rev-parse base > /dev/null || exit 0
> git config --local diff.renamelimit 0
> git config --local diff.renames True
> git config --local diff.algorithm histogram
> ./scripts/checkpatch.pl --mailback base..
> === TEST SCRIPT END ===
> 
> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> Switched to a new branch 'test'
> 46dd9b7 virtio-pci: fix queue_enable write
> d9d64b5 pci: Display PCI IRQ pin in "info pci"
> d784b45 acpi: ged: rename event memory region
> 31f9185 acpi: fadt: add hw-reduced sleep register support
> 7ea0b6d acpi: madt: skip pci override on pci-less systems.
> c105d68 acpi: create acpi-common.c and move madt code
> e5065df acpi: make build_madt() more generic.
> 984d983 virtio: add vhost-user-vsock-pci device
> 9da4528 virtio: add vhost-user-vsock base device
> 65280b9 vhost-vsock: add vhost-vsock-common abstraction
> 938682f hw/pci: Fix crash when running QEMU with "-nic model=rocker"
> dc89e8a libvhost-user: advertise vring features
> 91ccf2f Lift max ram slots limit in libvhost-user
> 2d95eb8 Support individual region unmap in libvhost-user
> 5965847 Support adding individual regions in libvhost-user
> 4cbf181 Support ram slot configuration in libvhost-user
> df71a7d Refactor out libvhost-user fault generation logic
> c26fd6d Lift max memory slots limit imposed by vhost-user
> 2c027ae Transmit vhost-user memory regions individually
> 31f458e Add VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS
> a498834 Add vhost-user helper to get MemoryRegion data
> 0b879bd Add helper to populate vhost-user message regions
> aeb2dd3 vhost-user-blk: delay vhost_user_blk_disconnect
> 2764cfd char-socket: return -1 in case of disconnect during tcp_chr_write
> 8094f71 hw/pci-host: Use the IEC binary prefix definitions
> 2182c70 hw/pci/pci_bridge: Use the IEC binary prefix definitions
> c2a6ce2 hw/pci/pci_bridge: Correct pci_bridge_io memory region size
> 55e9447 hw/pci-host/prep: Correct RAVEN bus bridge memory region size
> 9b4b0a1 pci: assert configuration access is within bounds
> f5161c8 hw/pci/pcie: Move hot plug capability check to pre_plug callback
> 61e916f MAINTAINERS: Fix the classification of bios-tables-test-allowed-diff.h
> 8c4d9bc virtio-balloon: Provide an interface for free page reporting
> 1f62891 virtio-balloon: Implement support for page poison reporting feature
> a186c69 virtio-balloon: unref the iothread when unrealizing
> f995a73 virtio-balloon: fix free page hinting check on unrealize
> 1ae2534 virtio-balloon: fix free page hinting without an iothread
> 23ca28d bios-tables-test: Generate reference tables for Q35/TPM-TIS
> 681761b bios-tables-test: Add Q35/TPM-TIS test
> 55dc15d tests: tpm-emu: Remove assert on TPM2_ST_NO_SESSIONS
> d156ed4 tests/acpi: Add void tables for Q35/TPM-TIS bios-tables-test
> 1f7f0ed test/tpm-emu: include sockets and channel headers in tpm-emu header
> 1d4ccd1 arm/acpi: TPM2 ACPI table support
> 05d06ef acpi: Move build_tpm2() in the generic part
> b3d7639 acpi: Convert build_tpm2() to build_append* API
> c83165b acpi: tpm: Do not build TCPA table for TPM 2
> d5513c9 tests/acpi: update DSDT expected files
> fd8fce1 acpi: move aml builder code for parallel device
> ef1eb92 acpi: parallel: don't use _STA method
> 7dd4ccf acpi: move aml builder code for serial device
> bae880e acpi: serial: don't use _STA method
> 97466cf acpi: rtc: use a single crs range
> 74ad15b acpi: move aml builder code for rtc device
> 7168264 qtest: allow DSDT acpi table changes
> f0b0e85 tests/acpi: update expected SRAT files
> cc03da0 hw/acpi/nvdimm: add a helper to augment SRAT generation
> c864987 diffs-allowed: add the SRAT AML to diffs-allowed
> 2029ad3 msix: allow qword MSI-X table accesses
> 
> === OUTPUT BEGIN ===
> 1/57 Checking commit 2029ad30a9a4 (msix: allow qword MSI-X table accesses)
> 2/57 Checking commit c8649877f7aa (diffs-allowed: add the SRAT AML to diffs-allowed)
> 3/57 Checking commit cc03da0d8b45 (hw/acpi/nvdimm: add a helper to augment SRAT generation)
> 4/57 Checking commit f0b0e85de3ba (tests/acpi: update expected SRAT files)
> ERROR: Do not add expected files together with tests, follow instructions in tests/qtest/bios-tables-test.c: both tests/data/acpi/virt/SRAT.memhp and tests/qtest/bios-tables-test-allowed-diff.h found
> 
> ERROR: Do not add expected files together with tests, follow instructions in tests/qtest/bios-tables-test.c: both tests/data/acpi/virt/SRAT.memhp and tests/qtest/bios-tables-test-allowed-diff.h found

The checkpatch fix isn't merged yet...

-- 
MST


