Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649A0C4727F
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 11:10:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC1AD21941
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 11:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ezDEDht2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC1AD21941
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNDWt-0005kT-Ku
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 07:10:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57542)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kNDRF-0006zH-0E
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 07:04:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24700)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kNDRA-0002xe-Jf
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 07:04:52 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601377487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RL6pz0/TH4it4YsOTr+YRAsiseAC9hoDVXMau660dhA=;
 b=ezDEDht2KF6CV4sHeZUnl7EqBLk8JYVmKiKvUwiOXuQxf+plI7I2g0nRGoGwbLuxyucFUD
 pn1t/3nd0/QTh8kqe771t5DZKZn0+tw1dzrpEhs9Y1QaIpRBMq/K8vKWxXMZT2Vov2HGRy
 nx0z7dGj+mXY1WF6jFVc/5cfKS46C7w=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-577-R0h07s2vMH-xSCeioTvWBA-1; Tue, 29 Sep 2020 07:04:43 -0400
X-MC-Unique: R0h07s2vMH-xSCeioTvWBA-1
Received: by mail-wr1-f69.google.com with SMTP id g6so1615117wrv.3
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 04:04:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=RL6pz0/TH4it4YsOTr+YRAsiseAC9hoDVXMau660dhA=;
 b=nwqv5kIIOJnhYVCcWh+5eGrDUe3K8X6srh6HLAHO5SZuNF1kQmVltEKAkjnAQY6BOg
 6R8tfbdLn/9CM00fd7RvB170zriUambkbxxKNgYOzQ0yhyAMGNTq7fz7W0j51XkqcLS4
 LLKxCkpvtz3T/h3DHi2fogFLVRLrrfuDZLfC2pbaFmzkod4LNad148imx/I4B0xCdgkD
 iDrJ5EVnfcdLP/UWfAX1Zr0d2Y1f+Offq4fNpvpWR0DK2Xj8L6llmjk6e5ZjyN9Md+R3
 h8HAmKOlo6vA4PeKBErb42nEegv5d2UjRKauw4GM5f9h/BaNBmk8RUA7Qylk1nNNHX1z
 UdYQ==
X-Gm-Message-State: AOAM5314Uav0m04Sp8mjQ30kSs6jfWjoB8lSUT2kXNIsP2AKRsZTlGP7
 eY6vwioQDz49SgGHKAdTM9AoCjQBUSfmVfGgb5mvCHcMk/StzobswuM+KPLQXbav6R8Sx075KhR
 5dG0oOR5rYu6CyQM=
X-Received: by 2002:a1c:5a86:: with SMTP id o128mr3739067wmb.129.1601377481814; 
 Tue, 29 Sep 2020 04:04:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJySbAZYzjbLOn6IBiJqzs5O1uvZwN/c4knG/2jM5YEb6PBoKu1Z2FdycUfQDZ1hsGZY23idlQ==
X-Received: by 2002:a1c:5a86:: with SMTP id o128mr3739017wmb.129.1601377481250; 
 Tue, 29 Sep 2020 04:04:41 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id u66sm4962310wmg.44.2020.09.29.04.04.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 04:04:40 -0700 (PDT)
Date: Tue, 29 Sep 2020 07:04:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PULL v4 00/48] virtio,pc,acpi: fixes, tests
Message-ID: <20200929070322-mutt-send-email-mst@kernel.org>
References: <20200929071948.281157-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200929071948.281157-1-mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 02:22:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Sep 29, 2020 at 03:20:52AM -0400, Michael S. Tsirkin wrote:
> Changes from v3:
> - dropped reconnect tests
> - added more fixes, an smbios feature
> 
> The following changes since commit 74504514b154ebebdff577d88e4bf5c13074e9ed:
> 
>   Merge remote-tracking branch 'remotes/alistair/tags/pull-register-20200927' into staging (2020-09-28 16:49:10 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> 
> for you to fetch changes up to 8138405528c29af2a850cd672a8f8a0b33b7ab40:

Ani Sinha pointed out that this included unnecessary files, I pushed out
a new commit 192d48b4ae4216f0dc40fba35e8edf3b92713aa7 which should be
ok.


> 
>   libvhost-user: return on error in vu_log_queue_fill() (2020-09-29 03:06:12 -0400)
> 
> ----------------------------------------------------------------
> virtio,pc,acpi: fixes, tests
> 
> Fixes and tests all over the place.
> Batch iommu updates for vdpa.
> Removal of deprecated cpu hotplug commands.
> SMBIOS OEM string support.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ----------------------------------------------------------------
> Ani Sinha (11):
>       tests/acpi: mark addition of table DSDT.roothp for unit testing root pci hotplug
>       tests/acpi: add new unit test to test hotplug off/on feature on the root pci bus
>       tests/acpi: add a new ACPI table in order to test root pci hotplug on/off
>       Fix a gap where acpi_pcihp_find_hotplug_bus() returns a non-hotpluggable bus
>       i440fx/acpi: do not add hotplug related amls for cold plugged bridges
>       tests/acpi: list added acpi table binary file for pci bridge hotplug test
>       tests/acpi: unit test for 'acpi-pci-hotplug-with-bridge-support' bridge flag
>       tests/acpi: add newly added acpi DSDT table blob for pci bridge hotplug flag
>       Add ACPI DSDT tables for q35 that are being updated by the next patch
>       piix4: don't reserve hw resources when hotplug is off globally
>       tests/acpi: update golden master DSDT binary table blobs for q35
> 
> Daniel P. Berrangé (3):
>       hw/smbios: support loading OEM strings values from a file
>       hw/smbios: report error if table size is too large
>       qemu-options: document SMBIOS type 11 settings
> 
> David Hildenbrand (1):
>       pc: fix auto_enable_numa_with_memhp/auto_enable_numa_with_memdev for the 5.0 machine
> 
> Dima Stepanov (3):
>       vhost: recheck dev state in the vhost_migration_log routine
>       vhost: check queue state in the vhost_dev_set_log routine
>       tests/qtest/vhost-user-test: prepare the tests for adding new dev class
> 
> Eric Auger (2):
>       virtio-iommu: Check gtrees are non null before destroying them
>       virtio-iommu-pci: force virtio version 1
> 
> Igor Mammedov (11):
>       cphp: remove deprecated cpu-add command(s)
>       x86: lpc9: let firmware negotiate 'CPU hotplug with SMI' features
>       x86: cpuhp: prevent guest crash on CPU hotplug when broadcast SMI is in use
>       x86: cpuhp: refuse cpu hot-unplug request earlier if not supported
>       acpi: add aml_land() and aml_break() primitives
>       tests: acpi: mark to be changed tables in bios-tables-test-allowed-diff
>       x86: ich9: expose "smi_negotiated_features" as a QOM property
>       x86: acpi: introduce AcpiPmInfo::smi_on_cpuhp
>       x86: acpi: introduce the PCI0.SMI0 ACPI device
>       x68: acpi: trigger SMI before sending hotplug Notify event to OSPM
>       tests: acpi: update acpi blobs with new AML
> 
> Jason Wang (3):
>       linux headers: sync to 5.9-rc4
>       vhost: switch to use IOTLB v2 format
>       vhost-vdpa: batch updating IOTLB mappings
> 
> Laurent Vivier (3):
>       util/hexdump: introduce qemu_hexdump_line()
>       vhost-vdpa: add trace-events
>       configure: Fix build dependencies with vhost-vdpa.
> 
> Li Qiang (3):
>       virtio-mem: detach the element from the virtqueue when error occurs
>       virtio: update MemoryRegionCaches when guest set bad features
>       hw: virtio-pmem: detach the element fromt the virtqueue when error occurs
> 
> Pankaj Gupta (1):
>       virtio-pmem-pci: force virtio version 1
> 
> Stefan Hajnoczi (2):
>       libvhost-user: return early on virtqueue errors
>       libvhost-user: return on error in vu_log_queue_fill()
> 
> Stefano Garzarella (4):
>       virtio: skip legacy support check on machine types less than 5.1
>       vhost-vsock-pci: force virtio version 1
>       vhost-user-vsock-pci: force virtio version 1
>       vhost-vsock-ccw: force virtio version 1
> 
> haibinzhang(张海斌) (1):
>       vhost-user: save features of multiqueues if chardev is closed
> 
>  configure                                          |    3 +-
>  qapi/machine.json                                  |   24 -
>  include/hw/acpi/aml-build.h                        |    2 +
>  include/hw/acpi/cpu.h                              |    1 +
>  include/hw/boards.h                                |    1 -
>  include/hw/i386/ich9.h                             |    4 +
>  include/hw/i386/pc.h                               |    1 -
>  include/hw/virtio/vhost-backend.h                  |    2 +
>  include/hw/virtio/vhost-user-blk.h                 |   10 +
>  include/hw/virtio/vhost-vdpa.h                     |    1 +
>  include/hw/virtio/vhost.h                          |    1 +
>  include/hw/virtio/virtio.h                         |    2 +
>  include/monitor/hmp.h                              |    1 -
>  include/qemu-common.h                              |    8 +
>  include/standard-headers/drm/drm_fourcc.h          |  140 +
>  include/standard-headers/linux/ethtool.h           |   87 +
>  include/standard-headers/linux/input-event-codes.h |    3 +-
>  include/standard-headers/linux/vhost_types.h       |   11 +
>  include/standard-headers/linux/virtio_9p.h         |    4 +-
>  include/standard-headers/linux/virtio_blk.h        |   26 +-
>  include/standard-headers/linux/virtio_config.h     |    8 +-
>  include/standard-headers/linux/virtio_console.h    |    8 +-
>  include/standard-headers/linux/virtio_net.h        |    6 +-
>  include/standard-headers/linux/virtio_scsi.h       |   20 +-
>  linux-headers/asm-generic/unistd.h                 |    6 +-
>  linux-headers/asm-mips/unistd_n32.h                |    1 +
>  linux-headers/asm-mips/unistd_n64.h                |    1 +
>  linux-headers/asm-mips/unistd_o32.h                |    1 +
>  linux-headers/asm-powerpc/kvm.h                    |    5 +
>  linux-headers/asm-powerpc/unistd_32.h              |    1 +
>  linux-headers/asm-powerpc/unistd_64.h              |    1 +
>  linux-headers/asm-s390/kvm.h                       |    7 +-
>  linux-headers/asm-s390/unistd_32.h                 |    1 +
>  linux-headers/asm-s390/unistd_64.h                 |    1 +
>  linux-headers/asm-x86/unistd_32.h                  |    1 +
>  linux-headers/asm-x86/unistd_64.h                  |    1 +
>  linux-headers/asm-x86/unistd_x32.h                 |    1 +
>  linux-headers/linux/kvm.h                          |    4 +
>  linux-headers/linux/vfio.h                         |    2 +-
>  linux-headers/linux/vhost.h                        |    2 +
>  contrib/libvhost-user/libvhost-user.c              |   26 +-
>  hw/acpi/aml-build.c                                |   16 +
>  hw/acpi/cpu.c                                      |  165 +-
>  hw/acpi/ich9.c                                     |   24 +-
>  hw/acpi/pcihp.c                                    |   15 +
>  hw/acpi/piix4.c                                    |    6 +-
>  hw/block/vhost-user-blk.c                          |   19 +-
>  hw/core/machine-hmp-cmds.c                         |   12 -
>  hw/core/machine-qmp-cmds.c                         |   12 -
>  hw/core/machine.c                                  |    1 +
>  hw/i386/acpi-build.c                               |   72 +-
>  hw/i386/pc.c                                       |   31 +-
>  hw/i386/pc_piix.c                                  |    1 -
>  hw/i386/pc_q35.c                                   |    2 +-
>  hw/i386/x86.c                                      |   11 +
>  hw/isa/lpc_ich9.c                                  |   16 +
>  hw/s390x/s390-virtio-ccw.c                         |   12 -
>  hw/s390x/vhost-vsock-ccw.c                         |   12 +
>  hw/s390x/virtio-ccw.c                              |   15 +-
>  hw/smbios/smbios.c                                 |   85 +-
>  hw/virtio/vhost-backend.c                          |   88 +-
>  hw/virtio/vhost-user-vsock-pci.c                   |    4 +-
>  hw/virtio/vhost-vdpa.c                             |  158 +-
>  hw/virtio/vhost-vsock-pci.c                        |   10 +-
>  hw/virtio/vhost.c                                  |   49 +-
>  hw/virtio/virtio-iommu-pci.c                       |    2 +-
>  hw/virtio/virtio-iommu.c                           |    8 +-
>  hw/virtio/virtio-mem.c                             |    3 +
>  hw/virtio/virtio-pci.c                             |   14 +-
>  hw/virtio/virtio-pmem-pci.c                        |    1 +
>  hw/virtio/virtio-pmem.c                            |    1 +
>  hw/virtio/virtio.c                                 |   24 +-
>  net/vhost-user.c                                   |   10 +-
>  tests/qtest/bios-tables-test.c                     |   32 +
>  tests/qtest/cpu-plug-test.c                        |  100 +-
>  tests/qtest/test-hmp.c                             |    1 -
>  tests/qtest/vhost-user-test.c                      |  105 +-
>  tests/test-qapi-event.c                            |  198 ++
>  tests/test-qmp-introspect.c                        |   58 +
>  tests/test-qmp-marshal.c                           |  383 +++
>  util/hexdump.c                                     |   54 +-
>  Kconfig.host                                       |    4 +
>  docs/system/deprecated.rst                         |   25 +-
>  hmp-commands.hx                                    |   15 -
>  hw/virtio/trace-events                             |   31 +
>  meson.build                                        |    1 +
>  qemu-options.hx                                    |   41 +
>  tests/.vhost-user-test.c.swo                       |  Bin 0 -> 16384 bytes
>  tests/Makefile.include.orig                        | 1012 ++++++
>  tests/Makefile.orig                                |  569 ++++
>  tests/bios-tables-test.c.orig                      |  925 +++++
>  tests/data/acpi/diff-aml.sh                        |    0
>  tests/data/acpi/disassemle-aml.py                  |   21 +
>  tests/data/acpi/microvm/APIC.dsl                   |   56 +
>  tests/data/acpi/microvm/DSDT.dsl                   |  121 +
>  tests/data/acpi/microvm/FACP.dsl                   |  196 ++
>  tests/data/acpi/pc/APIC.acpihmat.dsl               |  112 +
>  tests/data/acpi/pc/APIC.bridge                     |  Bin 0 -> 120 bytes
>  tests/data/acpi/pc/APIC.bridge.dsl                 |  104 +
>  tests/data/acpi/pc/APIC.cphp.dsl                   |  146 +
>  tests/data/acpi/pc/APIC.dimmpxm.dsl                |  129 +
>  tests/data/acpi/pc/APIC.dsl                        |  104 +
>  tests/data/acpi/pc/APIC.hpbridge                   |  Bin 0 -> 120 bytes
>  tests/data/acpi/pc/APIC.ipmikcs                    |  Bin 0 -> 120 bytes
>  tests/data/acpi/pc/APIC.ipmikcs.dsl                |  104 +
>  tests/data/acpi/pc/APIC.memhp                      |  Bin 0 -> 120 bytes
>  tests/data/acpi/pc/APIC.memhp.dsl                  |  104 +
>  tests/data/acpi/pc/APIC.numamem                    |  Bin 0 -> 120 bytes
>  tests/data/acpi/pc/APIC.numamem.dsl                |  104 +
>  tests/data/acpi/pc/APIC.roothp                     |  Bin 0 -> 120 bytes
>  tests/data/acpi/pc/DSDT                            |  Bin 4934 -> 5060 bytes
>  tests/data/acpi/pc/DSDT.acpihmat                   |  Bin 6258 -> 6385 bytes
>  tests/data/acpi/pc/DSDT.acpihmat.dsl               | 1619 +++++++++
>  tests/data/acpi/pc/DSDT.bridge                     |  Bin 6793 -> 6919 bytes
>  tests/data/acpi/pc/DSDT.bridge.dsl                 | 1800 ++++++++++
>  tests/data/acpi/pc/DSDT.cphp                       |  Bin 5397 -> 5524 bytes
>  tests/data/acpi/pc/DSDT.cphp.dsl                   | 1466 ++++++++
>  tests/data/acpi/pc/DSDT.dimmpxm                    |  Bin 6587 -> 6714 bytes
>  tests/data/acpi/pc/DSDT.dimmpxm.dsl                | 1719 ++++++++++
>  tests/data/acpi/pc/DSDT.dsl                        | 1407 ++++++++
>  tests/data/acpi/pc/DSDT.hpbridge                   |  Bin 0 -> 5021 bytes
>  tests/data/acpi/pc/DSDT.ipmikcs                    |  Bin 5006 -> 5132 bytes
>  tests/data/acpi/pc/DSDT.ipmikcs.dsl                | 1337 ++++++++
>  tests/data/acpi/pc/DSDT.memhp                      |  Bin 6293 -> 6419 bytes
>  tests/data/acpi/pc/DSDT.memhp.dsl                  | 1625 +++++++++
>  tests/data/acpi/pc/DSDT.numamem                    |  Bin 4940 -> 5066 bytes
>  tests/data/acpi/pc/DSDT.numamem.dsl                | 1321 ++++++++
>  tests/data/acpi/pc/DSDT.roothp                     |  Bin 0 -> 5256 bytes
>  tests/data/acpi/pc/FACP.acpihmat                   |  Bin 0 -> 116 bytes
>  tests/data/acpi/pc/FACP.acpihmat.dsl               |   99 +
>  tests/data/acpi/pc/FACP.bridge                     |  Bin 0 -> 116 bytes
>  tests/data/acpi/pc/FACP.bridge.dsl                 |   99 +
>  tests/data/acpi/pc/FACP.cphp                       |  Bin 0 -> 116 bytes
>  tests/data/acpi/pc/FACP.cphp.dsl                   |   99 +
>  tests/data/acpi/pc/FACP.dimmpxm                    |  Bin 0 -> 116 bytes
>  tests/data/acpi/pc/FACP.dimmpxm.dsl                |   99 +
>  tests/data/acpi/pc/FACP.dsl                        |   99 +
>  tests/data/acpi/pc/FACP.hpbridge                   |  Bin 0 -> 116 bytes
>  tests/data/acpi/pc/FACP.ipmikcs                    |  Bin 0 -> 116 bytes
>  tests/data/acpi/pc/FACP.ipmikcs.dsl                |   99 +
>  tests/data/acpi/pc/FACP.memhp                      |  Bin 0 -> 116 bytes
>  tests/data/acpi/pc/FACP.memhp.dsl                  |   99 +
>  tests/data/acpi/pc/FACP.numamem                    |  Bin 0 -> 116 bytes
>  tests/data/acpi/pc/FACP.numamem.dsl                |   99 +
>  tests/data/acpi/pc/FACP.roothp                     |  Bin 0 -> 116 bytes
>  tests/data/acpi/pc/FACS.acpihmat                   |  Bin 0 -> 64 bytes
>  tests/data/acpi/pc/FACS.acpihmat.dsl               |   32 +
>  tests/data/acpi/pc/FACS.bridge                     |  Bin 0 -> 64 bytes
>  tests/data/acpi/pc/FACS.bridge.dsl                 |   32 +
>  tests/data/acpi/pc/FACS.cphp                       |  Bin 0 -> 64 bytes
>  tests/data/acpi/pc/FACS.cphp.dsl                   |   32 +
>  tests/data/acpi/pc/FACS.dimmpxm                    |  Bin 0 -> 64 bytes
>  tests/data/acpi/pc/FACS.dimmpxm.dsl                |   32 +
>  tests/data/acpi/pc/FACS.dsl                        |   32 +
>  tests/data/acpi/pc/FACS.hpbridge                   |  Bin 0 -> 64 bytes
>  tests/data/acpi/pc/FACS.ipmikcs                    |  Bin 0 -> 64 bytes
>  tests/data/acpi/pc/FACS.ipmikcs.dsl                |   32 +
>  tests/data/acpi/pc/FACS.memhp                      |  Bin 0 -> 64 bytes
>  tests/data/acpi/pc/FACS.memhp.dsl                  |   32 +
>  tests/data/acpi/pc/FACS.numamem                    |  Bin 0 -> 64 bytes
>  tests/data/acpi/pc/FACS.numamem.dsl                |   32 +
>  tests/data/acpi/pc/FACS.roothp                     |  Bin 0 -> 64 bytes
>  tests/data/acpi/pc/HMAT.acpihmat.dsl               |  132 +
>  tests/data/acpi/pc/HMAT.dsl                        |  132 +
>  tests/data/acpi/pc/HPET.acpihmat                   |  Bin 0 -> 56 bytes
>  tests/data/acpi/pc/HPET.acpihmat.dsl               |   43 +
>  tests/data/acpi/pc/HPET.bridge                     |  Bin 0 -> 56 bytes
>  tests/data/acpi/pc/HPET.bridge.dsl                 |   43 +
>  tests/data/acpi/pc/HPET.cphp                       |  Bin 0 -> 56 bytes
>  tests/data/acpi/pc/HPET.cphp.dsl                   |   43 +
>  tests/data/acpi/pc/HPET.dimmpxm                    |  Bin 0 -> 56 bytes
>  tests/data/acpi/pc/HPET.dimmpxm.dsl                |   43 +
>  tests/data/acpi/pc/HPET.dsl                        |   43 +
>  tests/data/acpi/pc/HPET.hpbridge                   |  Bin 0 -> 56 bytes
>  tests/data/acpi/pc/HPET.ipmikcs                    |  Bin 0 -> 56 bytes
>  tests/data/acpi/pc/HPET.ipmikcs.dsl                |   43 +
>  tests/data/acpi/pc/HPET.memhp                      |  Bin 0 -> 56 bytes
>  tests/data/acpi/pc/HPET.memhp.dsl                  |   43 +
>  tests/data/acpi/pc/HPET.numamem                    |  Bin 0 -> 56 bytes
>  tests/data/acpi/pc/HPET.numamem.dsl                |   43 +
>  tests/data/acpi/pc/HPET.roothp                     |  Bin 0 -> 56 bytes
>  tests/data/acpi/pc/NFIT.dimmpxm.dsl                |  115 +
>  tests/data/acpi/pc/NFIT.dsl                        |  115 +
>  tests/data/acpi/pc/SLIT.cphp.dsl                   |   31 +
>  tests/data/acpi/pc/SLIT.dsl                        |   31 +
>  tests/data/acpi/pc/SLIT.memhp.dsl                  |   31 +
>  tests/data/acpi/pc/SRAT.acpihmat.dsl               |  137 +
>  tests/data/acpi/pc/SRAT.cphp.dsl                   |  168 +
>  tests/data/acpi/pc/SRAT.dimmpxm.dsl                |  194 ++
>  tests/data/acpi/pc/SRAT.dsl                        |  108 +
>  tests/data/acpi/pc/SRAT.memhp.dsl                  |  125 +
>  tests/data/acpi/pc/SRAT.numamem.dsl                |  108 +
>  tests/data/acpi/pc/SSDT.dsl                        |  205 ++
>  tests/data/acpi/pc/WAET.acpihmat                   |  Bin 0 -> 40 bytes
>  tests/data/acpi/pc/WAET.acpihmat.dsl               |   31 +
>  tests/data/acpi/pc/WAET.bridge                     |  Bin 0 -> 40 bytes
>  tests/data/acpi/pc/WAET.bridge.dsl                 |   31 +
>  tests/data/acpi/pc/WAET.cphp                       |  Bin 0 -> 40 bytes
>  tests/data/acpi/pc/WAET.cphp.dsl                   |   31 +
>  tests/data/acpi/pc/WAET.dimmpxm                    |  Bin 0 -> 40 bytes
>  tests/data/acpi/pc/WAET.dimmpxm.dsl                |   31 +
>  tests/data/acpi/pc/WAET.dsl                        |   31 +
>  tests/data/acpi/pc/WAET.hpbridge                   |  Bin 0 -> 40 bytes
>  tests/data/acpi/pc/WAET.ipmikcs                    |  Bin 0 -> 40 bytes
>  tests/data/acpi/pc/WAET.ipmikcs.dsl                |   31 +
>  tests/data/acpi/pc/WAET.memhp                      |  Bin 0 -> 40 bytes
>  tests/data/acpi/pc/WAET.memhp.dsl                  |   31 +
>  tests/data/acpi/pc/WAET.numamem                    |  Bin 0 -> 40 bytes
>  tests/data/acpi/pc/WAET.numamem.dsl                |   31 +
>  tests/data/acpi/pc/WAET.roothp                     |  Bin 0 -> 40 bytes
>  tests/data/acpi/q35/APIC.acpihmat.dsl              |  112 +
>  tests/data/acpi/q35/APIC.bridge                    |  Bin 0 -> 120 bytes
>  tests/data/acpi/q35/APIC.bridge.dsl                |  104 +
>  tests/data/acpi/q35/APIC.cphp.dsl                  |  146 +
>  tests/data/acpi/q35/APIC.dimmpxm.dsl               |  129 +
>  tests/data/acpi/q35/APIC.dsl                       |  104 +
>  tests/data/acpi/q35/APIC.ipmibt                    |  Bin 0 -> 120 bytes
>  tests/data/acpi/q35/APIC.ipmibt.dsl                |  104 +
>  tests/data/acpi/q35/APIC.memhp                     |  Bin 0 -> 120 bytes
>  tests/data/acpi/q35/APIC.memhp.dsl                 |  104 +
>  tests/data/acpi/q35/APIC.mmio64                    |  Bin 0 -> 120 bytes
>  tests/data/acpi/q35/APIC.mmio64.dsl                |  104 +
>  tests/data/acpi/q35/APIC.numamem                   |  Bin 0 -> 120 bytes
>  tests/data/acpi/q35/APIC.numamem.dsl               |  104 +
>  tests/data/acpi/q35/APIC.tis                       |  Bin 0 -> 120 bytes
>  tests/data/acpi/q35/APIC.tis.dsl                   |  104 +
>  tests/data/acpi/q35/DSDT                           |  Bin 7678 -> 7796 bytes
>  tests/data/acpi/q35/DSDT.acpihmat                  |  Bin 9002 -> 9121 bytes
>  tests/data/acpi/q35/DSDT.acpihmat.dsl              | 3436 +++++++++++++++++++
>  tests/data/acpi/q35/DSDT.bridge                    |  Bin 7695 -> 7814 bytes
>  tests/data/acpi/q35/DSDT.bridge.dsl                | 3141 +++++++++++++++++
>  tests/data/acpi/q35/DSDT.cphp                      |  Bin 8141 -> 8260 bytes
>  tests/data/acpi/q35/DSDT.cphp.dsl                  | 3283 ++++++++++++++++++
>  tests/data/acpi/q35/DSDT.dimmpxm                   |  Bin 9331 -> 9450 bytes
>  tests/data/acpi/q35/DSDT.dimmpxm.dsl               | 3535 ++++++++++++++++++++
>  tests/data/acpi/q35/DSDT.dsl                       | 3351 +++++++++++++++++++
>  tests/data/acpi/q35/DSDT.ipmibt                    |  Bin 7753 -> 7871 bytes
>  tests/data/acpi/q35/DSDT.ipmibt.dsl                | 3156 +++++++++++++++++
>  tests/data/acpi/q35/DSDT.memhp                     |  Bin 9037 -> 9155 bytes
>  tests/data/acpi/q35/DSDT.memhp.dsl                 | 3442 +++++++++++++++++++
>  tests/data/acpi/q35/DSDT.mmio64                    |  Bin 8808 -> 8927 bytes
>  tests/data/acpi/q35/DSDT.mmio64.dsl                | 3377 +++++++++++++++++++
>  tests/data/acpi/q35/DSDT.numamem                   |  Bin 7684 -> 7802 bytes
>  tests/data/acpi/q35/DSDT.numamem.dsl               | 3138 +++++++++++++++++
>  tests/data/acpi/q35/DSDT.tis                       |  Bin 8283 -> 8402 bytes
>  tests/data/acpi/q35/DSDT.tis.dsl                   | 3321 ++++++++++++++++++
>  tests/data/acpi/q35/FACP.acpihmat                  |  Bin 0 -> 244 bytes
>  tests/data/acpi/q35/FACP.acpihmat.dsl              |  179 +
>  tests/data/acpi/q35/FACP.bridge                    |  Bin 0 -> 244 bytes
>  tests/data/acpi/q35/FACP.bridge.dsl                |  179 +
>  tests/data/acpi/q35/FACP.cphp                      |  Bin 0 -> 244 bytes
>  tests/data/acpi/q35/FACP.cphp.dsl                  |  179 +
>  tests/data/acpi/q35/FACP.dimmpxm                   |  Bin 0 -> 244 bytes
>  tests/data/acpi/q35/FACP.dimmpxm.dsl               |  179 +
>  tests/data/acpi/q35/FACP.dsl                       |  179 +
>  tests/data/acpi/q35/FACP.ipmibt                    |  Bin 0 -> 244 bytes
>  tests/data/acpi/q35/FACP.ipmibt.dsl                |  179 +
>  tests/data/acpi/q35/FACP.memhp                     |  Bin 0 -> 244 bytes
>  tests/data/acpi/q35/FACP.memhp.dsl                 |  179 +
>  tests/data/acpi/q35/FACP.mmio64                    |  Bin 0 -> 244 bytes
>  tests/data/acpi/q35/FACP.mmio64.dsl                |  179 +
>  tests/data/acpi/q35/FACP.numamem                   |  Bin 0 -> 244 bytes
>  tests/data/acpi/q35/FACP.numamem.dsl               |  179 +
>  tests/data/acpi/q35/FACP.tis                       |  Bin 0 -> 244 bytes
>  tests/data/acpi/q35/FACP.tis.dsl                   |  179 +
>  tests/data/acpi/q35/FACS.acpihmat                  |  Bin 0 -> 64 bytes
>  tests/data/acpi/q35/FACS.acpihmat.dsl              |   32 +
>  tests/data/acpi/q35/FACS.bridge                    |  Bin 0 -> 64 bytes
>  tests/data/acpi/q35/FACS.bridge.dsl                |   32 +
>  tests/data/acpi/q35/FACS.cphp                      |  Bin 0 -> 64 bytes
>  tests/data/acpi/q35/FACS.cphp.dsl                  |   32 +
>  tests/data/acpi/q35/FACS.dimmpxm                   |  Bin 0 -> 64 bytes
>  tests/data/acpi/q35/FACS.dimmpxm.dsl               |   32 +
>  tests/data/acpi/q35/FACS.dsl                       |   32 +
>  tests/data/acpi/q35/FACS.ipmibt                    |  Bin 0 -> 64 bytes
>  tests/data/acpi/q35/FACS.ipmibt.dsl                |   32 +
>  tests/data/acpi/q35/FACS.memhp                     |  Bin 0 -> 64 bytes
>  tests/data/acpi/q35/FACS.memhp.dsl                 |   32 +
>  tests/data/acpi/q35/FACS.mmio64                    |  Bin 0 -> 64 bytes
>  tests/data/acpi/q35/FACS.mmio64.dsl                |   32 +
>  tests/data/acpi/q35/FACS.numamem                   |  Bin 0 -> 64 bytes
>  tests/data/acpi/q35/FACS.numamem.dsl               |   32 +
>  tests/data/acpi/q35/FACS.tis                       |  Bin 0 -> 64 bytes
>  tests/data/acpi/q35/FACS.tis.dsl                   |   32 +
>  tests/data/acpi/q35/HMAT.acpihmat.dsl              |  132 +
>  tests/data/acpi/q35/HMAT.dsl                       |  132 +
>  tests/data/acpi/q35/HPET.acpihmat                  |  Bin 0 -> 56 bytes
>  tests/data/acpi/q35/HPET.acpihmat.dsl              |   43 +
>  tests/data/acpi/q35/HPET.bridge                    |  Bin 0 -> 56 bytes
>  tests/data/acpi/q35/HPET.bridge.dsl                |   43 +
>  tests/data/acpi/q35/HPET.cphp                      |  Bin 0 -> 56 bytes
>  tests/data/acpi/q35/HPET.cphp.dsl                  |   43 +
>  tests/data/acpi/q35/HPET.dimmpxm                   |  Bin 0 -> 56 bytes
>  tests/data/acpi/q35/HPET.dimmpxm.dsl               |   43 +
>  tests/data/acpi/q35/HPET.dsl                       |   43 +
>  tests/data/acpi/q35/HPET.ipmibt                    |  Bin 0 -> 56 bytes
>  tests/data/acpi/q35/HPET.ipmibt.dsl                |   43 +
>  tests/data/acpi/q35/HPET.memhp                     |  Bin 0 -> 56 bytes
>  tests/data/acpi/q35/HPET.memhp.dsl                 |   43 +
>  tests/data/acpi/q35/HPET.mmio64                    |  Bin 0 -> 56 bytes
>  tests/data/acpi/q35/HPET.mmio64.dsl                |   43 +
>  tests/data/acpi/q35/HPET.numamem                   |  Bin 0 -> 56 bytes
>  tests/data/acpi/q35/HPET.numamem.dsl               |   43 +
>  tests/data/acpi/q35/HPET.tis                       |  Bin 0 -> 56 bytes
>  tests/data/acpi/q35/HPET.tis.dsl                   |   43 +
>  tests/data/acpi/q35/MCFG.acpihmat                  |  Bin 0 -> 60 bytes
>  tests/data/acpi/q35/MCFG.acpihmat.dsl              |   36 +
>  tests/data/acpi/q35/MCFG.bridge                    |  Bin 0 -> 60 bytes
>  tests/data/acpi/q35/MCFG.bridge.dsl                |   36 +
>  tests/data/acpi/q35/MCFG.cphp                      |  Bin 0 -> 60 bytes
>  tests/data/acpi/q35/MCFG.cphp.dsl                  |   36 +
>  tests/data/acpi/q35/MCFG.dimmpxm                   |  Bin 0 -> 60 bytes
>  tests/data/acpi/q35/MCFG.dimmpxm.dsl               |   36 +
>  tests/data/acpi/q35/MCFG.dsl                       |   36 +
>  tests/data/acpi/q35/MCFG.ipmibt                    |  Bin 0 -> 60 bytes
>  tests/data/acpi/q35/MCFG.ipmibt.dsl                |   36 +
>  tests/data/acpi/q35/MCFG.memhp                     |  Bin 0 -> 60 bytes
>  tests/data/acpi/q35/MCFG.memhp.dsl                 |   36 +
>  tests/data/acpi/q35/MCFG.mmio64                    |  Bin 0 -> 60 bytes
>  tests/data/acpi/q35/MCFG.mmio64.dsl                |   36 +
>  tests/data/acpi/q35/MCFG.numamem                   |  Bin 0 -> 60 bytes
>  tests/data/acpi/q35/MCFG.numamem.dsl               |   36 +
>  tests/data/acpi/q35/MCFG.tis                       |  Bin 0 -> 60 bytes
>  tests/data/acpi/q35/MCFG.tis.dsl                   |   36 +
>  tests/data/acpi/q35/NFIT.dimmpxm.dsl               |  115 +
>  tests/data/acpi/q35/NFIT.dsl                       |  115 +
>  tests/data/acpi/q35/SLIT.cphp.dsl                  |   31 +
>  tests/data/acpi/q35/SLIT.dsl                       |   31 +
>  tests/data/acpi/q35/SLIT.memhp.dsl                 |   31 +
>  tests/data/acpi/q35/SRAT.acpihmat.dsl              |  137 +
>  tests/data/acpi/q35/SRAT.cphp.dsl                  |  168 +
>  tests/data/acpi/q35/SRAT.dimmpxm.dsl               |  194 ++
>  tests/data/acpi/q35/SRAT.dsl                       |  108 +
>  tests/data/acpi/q35/SRAT.memhp.dsl                 |  125 +
>  tests/data/acpi/q35/SRAT.mmio64.dsl                |  108 +
>  tests/data/acpi/q35/SRAT.numamem.dsl               |  108 +
>  tests/data/acpi/q35/SSDT.dsl                       |  205 ++
>  tests/data/acpi/q35/TPM2.dsl                       |   38 +
>  tests/data/acpi/q35/TPM2.tis.dsl                   |   38 +
>  tests/data/acpi/q35/WAET.acpihmat                  |  Bin 0 -> 40 bytes
>  tests/data/acpi/q35/WAET.acpihmat.dsl              |   31 +
>  tests/data/acpi/q35/WAET.bridge                    |  Bin 0 -> 40 bytes
>  tests/data/acpi/q35/WAET.bridge.dsl                |   31 +
>  tests/data/acpi/q35/WAET.cphp                      |  Bin 0 -> 40 bytes
>  tests/data/acpi/q35/WAET.cphp.dsl                  |   31 +
>  tests/data/acpi/q35/WAET.dimmpxm                   |  Bin 0 -> 40 bytes
>  tests/data/acpi/q35/WAET.dimmpxm.dsl               |   31 +
>  tests/data/acpi/q35/WAET.dsl                       |   31 +
>  tests/data/acpi/q35/WAET.ipmibt                    |  Bin 0 -> 40 bytes
>  tests/data/acpi/q35/WAET.ipmibt.dsl                |   31 +
>  tests/data/acpi/q35/WAET.memhp                     |  Bin 0 -> 40 bytes
>  tests/data/acpi/q35/WAET.memhp.dsl                 |   31 +
>  tests/data/acpi/q35/WAET.mmio64                    |  Bin 0 -> 40 bytes
>  tests/data/acpi/q35/WAET.mmio64.dsl                |   31 +
>  tests/data/acpi/q35/WAET.numamem                   |  Bin 0 -> 40 bytes
>  tests/data/acpi/q35/WAET.numamem.dsl               |   31 +
>  tests/data/acpi/q35/WAET.tis                       |  Bin 0 -> 40 bytes
>  tests/data/acpi/q35/WAET.tis.dsl                   |   31 +
>  tests/data/acpi/virt/APIC.dsl                      |   78 +
>  tests/data/acpi/virt/APIC.memhp.dsl                |   78 +
>  tests/data/acpi/virt/APIC.numamem.dsl              |   78 +
>  tests/data/acpi/virt/DSDT.dsl                      | 1906 +++++++++++
>  tests/data/acpi/virt/DSDT.memhp.dsl                | 2215 ++++++++++++
>  tests/data/acpi/virt/DSDT.numamem.dsl              | 1906 +++++++++++
>  tests/data/acpi/virt/FACP.dsl                      |  196 ++
>  tests/data/acpi/virt/FACP.memhp.dsl                |  196 ++
>  tests/data/acpi/virt/FACP.numamem.dsl              |  196 ++
>  tests/data/acpi/virt/GTDT.dsl                      |   61 +
>  tests/data/acpi/virt/GTDT.memhp.dsl                |   61 +
>  tests/data/acpi/virt/GTDT.numamem.dsl              |   61 +
>  tests/data/acpi/virt/MCFG.dsl                      |   36 +
>  tests/data/acpi/virt/MCFG.memhp.dsl                |   36 +
>  tests/data/acpi/virt/MCFG.numamem.dsl              |   36 +
>  tests/data/acpi/virt/NFIT.dsl                      |  103 +
>  tests/data/acpi/virt/NFIT.memhp.dsl                |  103 +
>  tests/data/acpi/virt/SLIT.dsl                      |   31 +
>  tests/data/acpi/virt/SLIT.memhp.dsl                |   31 +
>  tests/data/acpi/virt/SPCR.dsl                      |   57 +
>  tests/data/acpi/virt/SPCR.memhp.dsl                |   57 +
>  tests/data/acpi/virt/SPCR.numamem.dsl              |   57 +
>  tests/data/acpi/virt/SRAT.dsl                      |   57 +
>  tests/data/acpi/virt/SRAT.memhp.dsl                |  107 +
>  tests/data/acpi/virt/SRAT.numamem.dsl              |   57 +
>  tests/data/acpi/virt/SSDT.dsl                      |  205 ++
>  .../bios-tables-test.x86_64.iso.raw                |  Bin 0 -> 425984 bytes
>  tests/libqtest.c.orig                              | 1106 ++++++
>  tests/qemu-iotests/core.12067                      |  Bin 0 -> 22716416 bytes
>  tests/qtest/bios-tables-test-allowed-diff.h.orig   |   18 +
>  tests/qtest/bios-tables-test-allowed-diff.h.rej    |    9 +
>  tests/qtest/bios-tables-test.c.orig                | 1200 +++++++
>  tests/qtest/bios-tables-test.c.rej                 |   22 +
>  tests/vhost-user-bridge                            |  Bin 0 -> 83120 bytes
>  tests/vhost-user-bridge.c.orig                     | 1432 ++++++++
>  tests/vhost-user-test.c.orig                       |  364 ++
>  394 files changed, 72814 insertions(+), 419 deletions(-)
>  create mode 100644 tests/test-qapi-event.c
>  create mode 100644 tests/test-qmp-introspect.c
>  create mode 100644 tests/test-qmp-marshal.c
>  create mode 100644 tests/.vhost-user-test.c.swo
>  create mode 100644 tests/Makefile.include.orig
>  create mode 100644 tests/Makefile.orig
>  create mode 100644 tests/bios-tables-test.c.orig
>  create mode 100644 tests/data/acpi/diff-aml.sh
>  create mode 100644 tests/data/acpi/disassemle-aml.py
>  create mode 100644 tests/data/acpi/microvm/APIC.dsl
>  create mode 100644 tests/data/acpi/microvm/DSDT.dsl
>  create mode 100644 tests/data/acpi/microvm/FACP.dsl
>  create mode 100644 tests/data/acpi/pc/APIC.acpihmat.dsl
>  create mode 100644 tests/data/acpi/pc/APIC.bridge
>  create mode 100644 tests/data/acpi/pc/APIC.bridge.dsl
>  create mode 100644 tests/data/acpi/pc/APIC.cphp.dsl
>  create mode 100644 tests/data/acpi/pc/APIC.dimmpxm.dsl
>  create mode 100644 tests/data/acpi/pc/APIC.dsl
>  create mode 100644 tests/data/acpi/pc/APIC.hpbridge
>  create mode 100644 tests/data/acpi/pc/APIC.ipmikcs
>  create mode 100644 tests/data/acpi/pc/APIC.ipmikcs.dsl
>  create mode 100644 tests/data/acpi/pc/APIC.memhp
>  create mode 100644 tests/data/acpi/pc/APIC.memhp.dsl
>  create mode 100644 tests/data/acpi/pc/APIC.numamem
>  create mode 100644 tests/data/acpi/pc/APIC.numamem.dsl
>  create mode 100644 tests/data/acpi/pc/APIC.roothp
>  create mode 100644 tests/data/acpi/pc/DSDT.acpihmat.dsl
>  create mode 100644 tests/data/acpi/pc/DSDT.bridge.dsl
>  create mode 100644 tests/data/acpi/pc/DSDT.cphp.dsl
>  create mode 100644 tests/data/acpi/pc/DSDT.dimmpxm.dsl
>  create mode 100644 tests/data/acpi/pc/DSDT.dsl
>  create mode 100644 tests/data/acpi/pc/DSDT.hpbridge
>  create mode 100644 tests/data/acpi/pc/DSDT.ipmikcs.dsl
>  create mode 100644 tests/data/acpi/pc/DSDT.memhp.dsl
>  create mode 100644 tests/data/acpi/pc/DSDT.numamem.dsl
>  create mode 100644 tests/data/acpi/pc/DSDT.roothp
>  create mode 100644 tests/data/acpi/pc/FACP.acpihmat
>  create mode 100644 tests/data/acpi/pc/FACP.acpihmat.dsl
>  create mode 100644 tests/data/acpi/pc/FACP.bridge
>  create mode 100644 tests/data/acpi/pc/FACP.bridge.dsl
>  create mode 100644 tests/data/acpi/pc/FACP.cphp
>  create mode 100644 tests/data/acpi/pc/FACP.cphp.dsl
>  create mode 100644 tests/data/acpi/pc/FACP.dimmpxm
>  create mode 100644 tests/data/acpi/pc/FACP.dimmpxm.dsl
>  create mode 100644 tests/data/acpi/pc/FACP.dsl
>  create mode 100644 tests/data/acpi/pc/FACP.hpbridge
>  create mode 100644 tests/data/acpi/pc/FACP.ipmikcs
>  create mode 100644 tests/data/acpi/pc/FACP.ipmikcs.dsl
>  create mode 100644 tests/data/acpi/pc/FACP.memhp
>  create mode 100644 tests/data/acpi/pc/FACP.memhp.dsl
>  create mode 100644 tests/data/acpi/pc/FACP.numamem
>  create mode 100644 tests/data/acpi/pc/FACP.numamem.dsl
>  create mode 100644 tests/data/acpi/pc/FACP.roothp
>  create mode 100644 tests/data/acpi/pc/FACS.acpihmat
>  create mode 100644 tests/data/acpi/pc/FACS.acpihmat.dsl
>  create mode 100644 tests/data/acpi/pc/FACS.bridge
>  create mode 100644 tests/data/acpi/pc/FACS.bridge.dsl
>  create mode 100644 tests/data/acpi/pc/FACS.cphp
>  create mode 100644 tests/data/acpi/pc/FACS.cphp.dsl
>  create mode 100644 tests/data/acpi/pc/FACS.dimmpxm
>  create mode 100644 tests/data/acpi/pc/FACS.dimmpxm.dsl
>  create mode 100644 tests/data/acpi/pc/FACS.dsl
>  create mode 100644 tests/data/acpi/pc/FACS.hpbridge
>  create mode 100644 tests/data/acpi/pc/FACS.ipmikcs
>  create mode 100644 tests/data/acpi/pc/FACS.ipmikcs.dsl
>  create mode 100644 tests/data/acpi/pc/FACS.memhp
>  create mode 100644 tests/data/acpi/pc/FACS.memhp.dsl
>  create mode 100644 tests/data/acpi/pc/FACS.numamem
>  create mode 100644 tests/data/acpi/pc/FACS.numamem.dsl
>  create mode 100644 tests/data/acpi/pc/FACS.roothp
>  create mode 100644 tests/data/acpi/pc/HMAT.acpihmat.dsl
>  create mode 100644 tests/data/acpi/pc/HMAT.dsl
>  create mode 100644 tests/data/acpi/pc/HPET.acpihmat
>  create mode 100644 tests/data/acpi/pc/HPET.acpihmat.dsl
>  create mode 100644 tests/data/acpi/pc/HPET.bridge
>  create mode 100644 tests/data/acpi/pc/HPET.bridge.dsl
>  create mode 100644 tests/data/acpi/pc/HPET.cphp
>  create mode 100644 tests/data/acpi/pc/HPET.cphp.dsl
>  create mode 100644 tests/data/acpi/pc/HPET.dimmpxm
>  create mode 100644 tests/data/acpi/pc/HPET.dimmpxm.dsl
>  create mode 100644 tests/data/acpi/pc/HPET.dsl
>  create mode 100644 tests/data/acpi/pc/HPET.hpbridge
>  create mode 100644 tests/data/acpi/pc/HPET.ipmikcs
>  create mode 100644 tests/data/acpi/pc/HPET.ipmikcs.dsl
>  create mode 100644 tests/data/acpi/pc/HPET.memhp
>  create mode 100644 tests/data/acpi/pc/HPET.memhp.dsl
>  create mode 100644 tests/data/acpi/pc/HPET.numamem
>  create mode 100644 tests/data/acpi/pc/HPET.numamem.dsl
>  create mode 100644 tests/data/acpi/pc/HPET.roothp
>  create mode 100644 tests/data/acpi/pc/NFIT.dimmpxm.dsl
>  create mode 100644 tests/data/acpi/pc/NFIT.dsl
>  create mode 100644 tests/data/acpi/pc/SLIT.cphp.dsl
>  create mode 100644 tests/data/acpi/pc/SLIT.dsl
>  create mode 100644 tests/data/acpi/pc/SLIT.memhp.dsl
>  create mode 100644 tests/data/acpi/pc/SRAT.acpihmat.dsl
>  create mode 100644 tests/data/acpi/pc/SRAT.cphp.dsl
>  create mode 100644 tests/data/acpi/pc/SRAT.dimmpxm.dsl
>  create mode 100644 tests/data/acpi/pc/SRAT.dsl
>  create mode 100644 tests/data/acpi/pc/SRAT.memhp.dsl
>  create mode 100644 tests/data/acpi/pc/SRAT.numamem.dsl
>  create mode 100644 tests/data/acpi/pc/SSDT.dsl
>  create mode 100644 tests/data/acpi/pc/WAET.acpihmat
>  create mode 100644 tests/data/acpi/pc/WAET.acpihmat.dsl
>  create mode 100644 tests/data/acpi/pc/WAET.bridge
>  create mode 100644 tests/data/acpi/pc/WAET.bridge.dsl
>  create mode 100644 tests/data/acpi/pc/WAET.cphp
>  create mode 100644 tests/data/acpi/pc/WAET.cphp.dsl
>  create mode 100644 tests/data/acpi/pc/WAET.dimmpxm
>  create mode 100644 tests/data/acpi/pc/WAET.dimmpxm.dsl
>  create mode 100644 tests/data/acpi/pc/WAET.dsl
>  create mode 100644 tests/data/acpi/pc/WAET.hpbridge
>  create mode 100644 tests/data/acpi/pc/WAET.ipmikcs
>  create mode 100644 tests/data/acpi/pc/WAET.ipmikcs.dsl
>  create mode 100644 tests/data/acpi/pc/WAET.memhp
>  create mode 100644 tests/data/acpi/pc/WAET.memhp.dsl
>  create mode 100644 tests/data/acpi/pc/WAET.numamem
>  create mode 100644 tests/data/acpi/pc/WAET.numamem.dsl
>  create mode 100644 tests/data/acpi/pc/WAET.roothp
>  create mode 100644 tests/data/acpi/q35/APIC.acpihmat.dsl
>  create mode 100644 tests/data/acpi/q35/APIC.bridge
>  create mode 100644 tests/data/acpi/q35/APIC.bridge.dsl
>  create mode 100644 tests/data/acpi/q35/APIC.cphp.dsl
>  create mode 100644 tests/data/acpi/q35/APIC.dimmpxm.dsl
>  create mode 100644 tests/data/acpi/q35/APIC.dsl
>  create mode 100644 tests/data/acpi/q35/APIC.ipmibt
>  create mode 100644 tests/data/acpi/q35/APIC.ipmibt.dsl
>  create mode 100644 tests/data/acpi/q35/APIC.memhp
>  create mode 100644 tests/data/acpi/q35/APIC.memhp.dsl
>  create mode 100644 tests/data/acpi/q35/APIC.mmio64
>  create mode 100644 tests/data/acpi/q35/APIC.mmio64.dsl
>  create mode 100644 tests/data/acpi/q35/APIC.numamem
>  create mode 100644 tests/data/acpi/q35/APIC.numamem.dsl
>  create mode 100644 tests/data/acpi/q35/APIC.tis
>  create mode 100644 tests/data/acpi/q35/APIC.tis.dsl
>  create mode 100644 tests/data/acpi/q35/DSDT.acpihmat.dsl
>  create mode 100644 tests/data/acpi/q35/DSDT.bridge.dsl
>  create mode 100644 tests/data/acpi/q35/DSDT.cphp.dsl
>  create mode 100644 tests/data/acpi/q35/DSDT.dimmpxm.dsl
>  create mode 100644 tests/data/acpi/q35/DSDT.dsl
>  create mode 100644 tests/data/acpi/q35/DSDT.ipmibt.dsl
>  create mode 100644 tests/data/acpi/q35/DSDT.memhp.dsl
>  create mode 100644 tests/data/acpi/q35/DSDT.mmio64.dsl
>  create mode 100644 tests/data/acpi/q35/DSDT.numamem.dsl
>  create mode 100644 tests/data/acpi/q35/DSDT.tis.dsl
>  create mode 100644 tests/data/acpi/q35/FACP.acpihmat
>  create mode 100644 tests/data/acpi/q35/FACP.acpihmat.dsl
>  create mode 100644 tests/data/acpi/q35/FACP.bridge
>  create mode 100644 tests/data/acpi/q35/FACP.bridge.dsl
>  create mode 100644 tests/data/acpi/q35/FACP.cphp
>  create mode 100644 tests/data/acpi/q35/FACP.cphp.dsl
>  create mode 100644 tests/data/acpi/q35/FACP.dimmpxm
>  create mode 100644 tests/data/acpi/q35/FACP.dimmpxm.dsl
>  create mode 100644 tests/data/acpi/q35/FACP.dsl
>  create mode 100644 tests/data/acpi/q35/FACP.ipmibt
>  create mode 100644 tests/data/acpi/q35/FACP.ipmibt.dsl
>  create mode 100644 tests/data/acpi/q35/FACP.memhp
>  create mode 100644 tests/data/acpi/q35/FACP.memhp.dsl
>  create mode 100644 tests/data/acpi/q35/FACP.mmio64
>  create mode 100644 tests/data/acpi/q35/FACP.mmio64.dsl
>  create mode 100644 tests/data/acpi/q35/FACP.numamem
>  create mode 100644 tests/data/acpi/q35/FACP.numamem.dsl
>  create mode 100644 tests/data/acpi/q35/FACP.tis
>  create mode 100644 tests/data/acpi/q35/FACP.tis.dsl
>  create mode 100644 tests/data/acpi/q35/FACS.acpihmat
>  create mode 100644 tests/data/acpi/q35/FACS.acpihmat.dsl
>  create mode 100644 tests/data/acpi/q35/FACS.bridge
>  create mode 100644 tests/data/acpi/q35/FACS.bridge.dsl
>  create mode 100644 tests/data/acpi/q35/FACS.cphp
>  create mode 100644 tests/data/acpi/q35/FACS.cphp.dsl
>  create mode 100644 tests/data/acpi/q35/FACS.dimmpxm
>  create mode 100644 tests/data/acpi/q35/FACS.dimmpxm.dsl
>  create mode 100644 tests/data/acpi/q35/FACS.dsl
>  create mode 100644 tests/data/acpi/q35/FACS.ipmibt
>  create mode 100644 tests/data/acpi/q35/FACS.ipmibt.dsl
>  create mode 100644 tests/data/acpi/q35/FACS.memhp
>  create mode 100644 tests/data/acpi/q35/FACS.memhp.dsl
>  create mode 100644 tests/data/acpi/q35/FACS.mmio64
>  create mode 100644 tests/data/acpi/q35/FACS.mmio64.dsl
>  create mode 100644 tests/data/acpi/q35/FACS.numamem
>  create mode 100644 tests/data/acpi/q35/FACS.numamem.dsl
>  create mode 100644 tests/data/acpi/q35/FACS.tis
>  create mode 100644 tests/data/acpi/q35/FACS.tis.dsl
>  create mode 100644 tests/data/acpi/q35/HMAT.acpihmat.dsl
>  create mode 100644 tests/data/acpi/q35/HMAT.dsl
>  create mode 100644 tests/data/acpi/q35/HPET.acpihmat
>  create mode 100644 tests/data/acpi/q35/HPET.acpihmat.dsl
>  create mode 100644 tests/data/acpi/q35/HPET.bridge
>  create mode 100644 tests/data/acpi/q35/HPET.bridge.dsl
>  create mode 100644 tests/data/acpi/q35/HPET.cphp
>  create mode 100644 tests/data/acpi/q35/HPET.cphp.dsl
>  create mode 100644 tests/data/acpi/q35/HPET.dimmpxm
>  create mode 100644 tests/data/acpi/q35/HPET.dimmpxm.dsl
>  create mode 100644 tests/data/acpi/q35/HPET.dsl
>  create mode 100644 tests/data/acpi/q35/HPET.ipmibt
>  create mode 100644 tests/data/acpi/q35/HPET.ipmibt.dsl
>  create mode 100644 tests/data/acpi/q35/HPET.memhp
>  create mode 100644 tests/data/acpi/q35/HPET.memhp.dsl
>  create mode 100644 tests/data/acpi/q35/HPET.mmio64
>  create mode 100644 tests/data/acpi/q35/HPET.mmio64.dsl
>  create mode 100644 tests/data/acpi/q35/HPET.numamem
>  create mode 100644 tests/data/acpi/q35/HPET.numamem.dsl
>  create mode 100644 tests/data/acpi/q35/HPET.tis
>  create mode 100644 tests/data/acpi/q35/HPET.tis.dsl
>  create mode 100644 tests/data/acpi/q35/MCFG.acpihmat
>  create mode 100644 tests/data/acpi/q35/MCFG.acpihmat.dsl
>  create mode 100644 tests/data/acpi/q35/MCFG.bridge
>  create mode 100644 tests/data/acpi/q35/MCFG.bridge.dsl
>  create mode 100644 tests/data/acpi/q35/MCFG.cphp
>  create mode 100644 tests/data/acpi/q35/MCFG.cphp.dsl
>  create mode 100644 tests/data/acpi/q35/MCFG.dimmpxm
>  create mode 100644 tests/data/acpi/q35/MCFG.dimmpxm.dsl
>  create mode 100644 tests/data/acpi/q35/MCFG.dsl
>  create mode 100644 tests/data/acpi/q35/MCFG.ipmibt
>  create mode 100644 tests/data/acpi/q35/MCFG.ipmibt.dsl
>  create mode 100644 tests/data/acpi/q35/MCFG.memhp
>  create mode 100644 tests/data/acpi/q35/MCFG.memhp.dsl
>  create mode 100644 tests/data/acpi/q35/MCFG.mmio64
>  create mode 100644 tests/data/acpi/q35/MCFG.mmio64.dsl
>  create mode 100644 tests/data/acpi/q35/MCFG.numamem
>  create mode 100644 tests/data/acpi/q35/MCFG.numamem.dsl
>  create mode 100644 tests/data/acpi/q35/MCFG.tis
>  create mode 100644 tests/data/acpi/q35/MCFG.tis.dsl
>  create mode 100644 tests/data/acpi/q35/NFIT.dimmpxm.dsl
>  create mode 100644 tests/data/acpi/q35/NFIT.dsl
>  create mode 100644 tests/data/acpi/q35/SLIT.cphp.dsl
>  create mode 100644 tests/data/acpi/q35/SLIT.dsl
>  create mode 100644 tests/data/acpi/q35/SLIT.memhp.dsl
>  create mode 100644 tests/data/acpi/q35/SRAT.acpihmat.dsl
>  create mode 100644 tests/data/acpi/q35/SRAT.cphp.dsl
>  create mode 100644 tests/data/acpi/q35/SRAT.dimmpxm.dsl
>  create mode 100644 tests/data/acpi/q35/SRAT.dsl
>  create mode 100644 tests/data/acpi/q35/SRAT.memhp.dsl
>  create mode 100644 tests/data/acpi/q35/SRAT.mmio64.dsl
>  create mode 100644 tests/data/acpi/q35/SRAT.numamem.dsl
>  create mode 100644 tests/data/acpi/q35/SSDT.dsl
>  create mode 100644 tests/data/acpi/q35/TPM2.dsl
>  create mode 100644 tests/data/acpi/q35/TPM2.tis.dsl
>  create mode 100644 tests/data/acpi/q35/WAET.acpihmat
>  create mode 100644 tests/data/acpi/q35/WAET.acpihmat.dsl
>  create mode 100644 tests/data/acpi/q35/WAET.bridge
>  create mode 100644 tests/data/acpi/q35/WAET.bridge.dsl
>  create mode 100644 tests/data/acpi/q35/WAET.cphp
>  create mode 100644 tests/data/acpi/q35/WAET.cphp.dsl
>  create mode 100644 tests/data/acpi/q35/WAET.dimmpxm
>  create mode 100644 tests/data/acpi/q35/WAET.dimmpxm.dsl
>  create mode 100644 tests/data/acpi/q35/WAET.dsl
>  create mode 100644 tests/data/acpi/q35/WAET.ipmibt
>  create mode 100644 tests/data/acpi/q35/WAET.ipmibt.dsl
>  create mode 100644 tests/data/acpi/q35/WAET.memhp
>  create mode 100644 tests/data/acpi/q35/WAET.memhp.dsl
>  create mode 100644 tests/data/acpi/q35/WAET.mmio64
>  create mode 100644 tests/data/acpi/q35/WAET.mmio64.dsl
>  create mode 100644 tests/data/acpi/q35/WAET.numamem
>  create mode 100644 tests/data/acpi/q35/WAET.numamem.dsl
>  create mode 100644 tests/data/acpi/q35/WAET.tis
>  create mode 100644 tests/data/acpi/q35/WAET.tis.dsl
>  create mode 100644 tests/data/acpi/virt/APIC.dsl
>  create mode 100644 tests/data/acpi/virt/APIC.memhp.dsl
>  create mode 100644 tests/data/acpi/virt/APIC.numamem.dsl
>  create mode 100644 tests/data/acpi/virt/DSDT.dsl
>  create mode 100644 tests/data/acpi/virt/DSDT.memhp.dsl
>  create mode 100644 tests/data/acpi/virt/DSDT.numamem.dsl
>  create mode 100644 tests/data/acpi/virt/FACP.dsl
>  create mode 100644 tests/data/acpi/virt/FACP.memhp.dsl
>  create mode 100644 tests/data/acpi/virt/FACP.numamem.dsl
>  create mode 100644 tests/data/acpi/virt/GTDT.dsl
>  create mode 100644 tests/data/acpi/virt/GTDT.memhp.dsl
>  create mode 100644 tests/data/acpi/virt/GTDT.numamem.dsl
>  create mode 100644 tests/data/acpi/virt/MCFG.dsl
>  create mode 100644 tests/data/acpi/virt/MCFG.memhp.dsl
>  create mode 100644 tests/data/acpi/virt/MCFG.numamem.dsl
>  create mode 100644 tests/data/acpi/virt/NFIT.dsl
>  create mode 100644 tests/data/acpi/virt/NFIT.memhp.dsl
>  create mode 100644 tests/data/acpi/virt/SLIT.dsl
>  create mode 100644 tests/data/acpi/virt/SLIT.memhp.dsl
>  create mode 100644 tests/data/acpi/virt/SPCR.dsl
>  create mode 100644 tests/data/acpi/virt/SPCR.memhp.dsl
>  create mode 100644 tests/data/acpi/virt/SPCR.numamem.dsl
>  create mode 100644 tests/data/acpi/virt/SRAT.dsl
>  create mode 100644 tests/data/acpi/virt/SRAT.memhp.dsl
>  create mode 100644 tests/data/acpi/virt/SRAT.numamem.dsl
>  create mode 100644 tests/data/acpi/virt/SSDT.dsl
>  create mode 100644 tests/data/uefi-boot-images/bios-tables-test.x86_64.iso.raw
>  create mode 100644 tests/libqtest.c.orig
>  create mode 100644 tests/qemu-iotests/core.12067
>  create mode 100644 tests/qtest/bios-tables-test-allowed-diff.h.orig
>  create mode 100644 tests/qtest/bios-tables-test-allowed-diff.h.rej
>  create mode 100644 tests/qtest/bios-tables-test.c.orig
>  create mode 100644 tests/qtest/bios-tables-test.c.rej
>  create mode 100755 tests/vhost-user-bridge
>  create mode 100644 tests/vhost-user-bridge.c.orig
>  create mode 100644 tests/vhost-user-test.c.orig
> 


