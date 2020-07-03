Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1BCC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:04:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDC78207DA
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SxKus9Gp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDC78207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrHcj-00085M-Sb
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 05:04:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59528)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrHbg-0006S2-KM
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 05:03:40 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51667
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrHbd-0004MM-K2
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 05:03:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593767016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=aH2DIigSB0j728qBhH8ourT7/lBs8+H5zwVsEnwerCw=;
 b=SxKus9GpUlQ7wFzabET9irjGad+rU3ZQgtn1RjbX/x/KYckA73JmpOsI3Fljx2qM37FAAo
 yQjMvj1BuRlG815t2+bb+dIu9kSSXXigAy25qsK0KzFGVqIGt5jPTq1QFDmyL3RGBadn9z
 wS+g90b2gvCiUAea1P1Ajuven5ZAqLE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-ncs_A5UUM4KGv-baOEZPCw-1; Fri, 03 Jul 2020 05:03:33 -0400
X-MC-Unique: ncs_A5UUM4KGv-baOEZPCw-1
Received: by mail-wr1-f72.google.com with SMTP id d11so13663135wrw.12
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 02:03:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=aH2DIigSB0j728qBhH8ourT7/lBs8+H5zwVsEnwerCw=;
 b=prKANa5AwqMv7i4+gwAOMPTaLKfL3TqqZoFICobOG7AQCMtGHCKyj6Aon9b0xVxBTB
 lTvOjslOoL85gilK3i7djuCOs9LyXWagRjc28ADxipKUnZEr5tPqSUkkCx8bx+VzU5hR
 3sHsgDzSMAeVeDGVvgWu3NwG96Dr120HZPji05skOWmaUPRO8UiLeBJhkVe1YGwFmlrC
 SI9aDAvvFfqQrsymcFeW6fk+97sjv3QyYhuVNhY/dJo4k7cKg38SkfQ1UuHuGC9qtwGK
 uYs2USMSFR63CH1puAj9Obeoy+pghDsr6R1HKU96hS6MvNM1ISULFUqyPZJ1UJa0bVjL
 eDGA==
X-Gm-Message-State: AOAM531QVeheyL7Gd4ZUdDzLV0pupiJrlXtr8yF0u2PL307DItLjGOKf
 Ld3cXUQ+J70ul4bPI40gM+tTgcOt6Ll1NV64S3/fm6iI6tX6i+gm6bUUCptV8NZhWTidDrYuxPU
 G11Ay0cmxCfhbgCk=
X-Received: by 2002:a5d:4e8e:: with SMTP id e14mr33933629wru.134.1593767011808; 
 Fri, 03 Jul 2020 02:03:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwcsNHRcRGTPoa0Oa6BJRYN9VAwe1GBAm4frIspaSTlJltHheg8kcwZAeqSKZG6GZKx9A+xFQ==
X-Received: by 2002:a5d:4e8e:: with SMTP id e14mr33933620wru.134.1593767011521; 
 Fri, 03 Jul 2020 02:03:31 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 c206sm13593243wmf.36.2020.07.03.02.03.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 02:03:30 -0700 (PDT)
Date: Fri, 3 Jul 2020 05:03:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/41] virtio,acpi: features, fixes, cleanups.
Message-ID: <20200703090252.368694-1-mst@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 03:17:33
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

The following changes since commit fc1bff958998910ec8d25db86cd2f53ff125f7ab:

  hw/misc/pca9552: Add missing TypeInfo::class_size field (2020-06-29 21:16:10 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 900ed7043750ae3cdf35c05da66e150a8821c3a0:

  vhost-vdpa: introduce vhost-vdpa net client (2020-07-03 04:59:13 -0400)

----------------------------------------------------------------
virtio,acpi: features, fixes, cleanups.

vdpa support
virtio-mem support
a handy script for disassembling acpi tables
misc fixes and cleanups

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Andrew Jones (1):
      tests/acpi: remove stale allowed tables

Cindy Lu (11):
      net: introduce qemu_get_peer
      vhost_net: use the function qemu_get_peer
      vhost: introduce new VhostOps vhost_dev_start
      vhost: implement vhost_dev_start method
      vhost: introduce new VhostOps vhost_vq_get_addr
      vhost: implement vhost_vq_get_addr method
      vhost: introduce new VhostOps vhost_force_iommu
      vhost: implement vhost_force_iommu method
      vhost_net: introduce set_config & get_config
      vhost-vdpa: introduce vhost-vdpa backend
      vhost-vdpa: introduce vhost-vdpa net client

David Hildenbrand (22):
      virtio-balloon: always indicate S_DONE when migration fails
      pc: Support coldplugging of virtio-pmem-pci devices on all buses
      exec: Introduce ram_block_discard_(disable|require)()
      vfio: Convert to ram_block_discard_disable()
      accel/kvm: Convert to ram_block_discard_disable()
      s390x/pv: Convert to ram_block_discard_disable()
      virtio-balloon: Rip out qemu_balloon_inhibit()
      target/i386: sev: Use ram_block_discard_disable()
      migration/rdma: Use ram_block_discard_disable()
      migration/colo: Use ram_block_discard_disable()
      virtio-mem: Paravirtualized memory hot(un)plug
      virtio-pci: Proxy for virtio-mem
      MAINTAINERS: Add myself as virtio-mem maintainer
      hmp: Handle virtio-mem when printing memory device info
      numa: Handle virtio-mem in NUMA stats
      pc: Support for virtio-mem-pci
      virtio-mem: Allow notifiers for size changes
      virtio-pci: Send qapi events when the virtio-mem size changes
      virtio-mem: Migration sanity checks
      virtio-mem: Add trace events
      virtio-mem: Exclude unplugged memory during migration
      numa: Auto-enable NUMA when any memory devices are possible

Jason Wang (3):
      virtio-bus: introduce queue_enabled method
      virtio-pci: implement queue_enabled method
      vhost: check the existence of vhost_set_iotlb_callback

Maxime Coquelin (1):
      docs: vhost-user: add Virtio status protocol feature

Michael S. Tsirkin (2):
      tests: disassemble-aml.sh: generate AML in readable format
      Revert "tests/migration: Reduce autoconverge initial bandwidth"

Peter Xu (1):
      MAINTAINERS: add VT-d entry

 configure                                   |  21 +
 qapi/misc.json                              |  64 +-
 qapi/net.json                               |  28 +-
 hw/virtio/virtio-mem-pci.h                  |  34 ++
 include/exec/memory.h                       |  41 ++
 include/hw/boards.h                         |   1 +
 include/hw/pci/pci.h                        |   1 +
 include/hw/vfio/vfio-common.h               |   4 +-
 include/hw/virtio/vhost-backend.h           |  19 +-
 include/hw/virtio/vhost-vdpa.h              |  26 +
 include/hw/virtio/vhost.h                   |   7 +
 include/hw/virtio/virtio-bus.h              |   4 +
 include/hw/virtio/virtio-mem.h              |  86 +++
 include/migration/colo.h                    |   2 +-
 include/migration/misc.h                    |   2 +
 include/net/net.h                           |   1 +
 include/net/vhost-vdpa.h                    |  22 +
 include/net/vhost_net.h                     |   5 +
 include/sysemu/balloon.h                    |   2 -
 net/clients.h                               |   2 +
 tests/qtest/bios-tables-test-allowed-diff.h |  18 -
 accel/kvm/kvm-all.c                         |   4 +-
 balloon.c                                   |  17 -
 exec.c                                      |  52 ++
 hw/arm/virt.c                               |   2 +
 hw/core/numa.c                              |  17 +-
 hw/i386/microvm.c                           |   1 +
 hw/i386/pc.c                                |  66 ++-
 hw/i386/pc_piix.c                           |   1 +
 hw/i386/pc_q35.c                            |   1 +
 hw/net/vhost_net-stub.c                     |  11 +
 hw/net/vhost_net.c                          |  45 +-
 hw/net/virtio-net.c                         |  19 +
 hw/s390x/s390-virtio-ccw.c                  |  22 +-
 hw/vfio/ap.c                                |   8 +-
 hw/vfio/ccw.c                               |  11 +-
 hw/vfio/common.c                            |  53 +-
 hw/vfio/pci.c                               |   6 +-
 hw/virtio/vhost-backend.c                   |   6 +
 hw/virtio/vhost-vdpa.c                      | 475 +++++++++++++++
 hw/virtio/vhost.c                           |  52 +-
 hw/virtio/virtio-balloon.c                  |  36 +-
 hw/virtio/virtio-mem-pci.c                  | 157 +++++
 hw/virtio/virtio-mem.c                      | 873 ++++++++++++++++++++++++++++
 hw/virtio/virtio-pci.c                      |  13 +
 hw/virtio/virtio.c                          |   6 +
 migration/migration.c                       |  15 +-
 migration/postcopy-ram.c                    |  23 -
 migration/rdma.c                            |  18 +-
 migration/savevm.c                          |  11 +-
 monitor/hmp-cmds.c                          |  16 +
 monitor/monitor.c                           |   1 +
 net/net.c                                   |  10 +
 net/vhost-vdpa.c                            | 228 ++++++++
 target/i386/sev.c                           |   7 +
 tests/qtest/migration-test.c                |   2 +-
 MAINTAINERS                                 |  18 +
 docs/interop/index.rst                      |   1 +
 docs/interop/vhost-user.rst                 |  24 +
 docs/interop/vhost-vdpa.rst                 |  17 +
 hw/i386/Kconfig                             |   1 +
 hw/virtio/Kconfig                           |  11 +
 hw/virtio/Makefile.objs                     |   3 +
 hw/virtio/trace-events                      |  10 +
 net/Makefile.objs                           |   2 +-
 qemu-options.hx                             |  12 +
 tests/data/acpi/disassemle-aml.sh           |  52 ++
 tests/data/acpi/rebuild-expected-aml.sh     |   1 +
 68 files changed, 2640 insertions(+), 187 deletions(-)
 create mode 100644 hw/virtio/virtio-mem-pci.h
 create mode 100644 include/hw/virtio/vhost-vdpa.h
 create mode 100644 include/hw/virtio/virtio-mem.h
 create mode 100644 include/net/vhost-vdpa.h
 create mode 100644 hw/virtio/vhost-vdpa.c
 create mode 100644 hw/virtio/virtio-mem-pci.c
 create mode 100644 hw/virtio/virtio-mem.c
 create mode 100644 net/vhost-vdpa.c
 create mode 100644 docs/interop/vhost-vdpa.rst
 create mode 100755 tests/data/acpi/disassemle-aml.sh


