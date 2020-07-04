Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70042C433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 18:31:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A67920720
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 18:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UzsKl/MU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A67920720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrmwF-0004Mc-Cv
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 14:30:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39442)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrmuu-0002b4-7X
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 14:29:36 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41033
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrmuq-0001Hx-1p
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 14:29:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593887369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=Ys3cEiExXwUkb6xe09iJXimcln5yUs/SqgN1nDc71LQ=;
 b=UzsKl/MUpUqwEf66TtO2uLPBa3J7JQTFOUT6XS0OGsN831h6Mb2bchYeqYGSuizgrESrAn
 nGKKDtL7iU0iGbIA31rbx8rxtumaKvzBApFDKNRRUbxX81g61cwlq3NFjIMch4SbYKKf2O
 ZhwCRvSSNR77DKNBHRgEgJejAh4ad2E=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-KoCcQWEoOqGo4uJUwtptOA-1; Sat, 04 Jul 2020 14:29:26 -0400
X-MC-Unique: KoCcQWEoOqGo4uJUwtptOA-1
Received: by mail-wr1-f71.google.com with SMTP id g14so36340276wrp.8
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 11:29:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=Ys3cEiExXwUkb6xe09iJXimcln5yUs/SqgN1nDc71LQ=;
 b=G1RR6xrS+hNxM0G7YwHPw74P9VUWQuUqGaP/maOfikkQ7FSIF6pNwVSS8frNHpD9nH
 4E4RFZx3Fuz2S7hAc8bHqqy6AjEQYPhcSFBuJEAkH7SWrT10/KpSs+UFC3ATPGGpARge
 +ebrPdkulOL29TjZ3ZUdU0UQEynL8AWPLjb+0Nf7Oi5Y6o8R1DmhU+jYpu+jL4ZyX2wQ
 /tlGAVl2QXvf7Yy1xl99/tJdApZJWCeKdQFU9xx+WswVE462slFal8rbd2uUpoJCXEUS
 O5cS3fhJvgwC8XhHJWEHn0/i2nCpvdU3dtIJQOFieZfOz2OVU4MBUayoPRcrSSi5JMX0
 DARA==
X-Gm-Message-State: AOAM532Gfa9UQgm5NH6BSrJKovEQyI17/leTFgYjo5HzIoF7stHlsFcz
 OPepMnFlk73lRQw060J4BrKcSW6T+Xb0hHG9mDpTA+aYK8oO5RB8qiRj8ZZa4uswEVqDmialY/T
 RMhpkQDf6AFvJBS0=
X-Received: by 2002:a5d:6a06:: with SMTP id m6mr41433225wru.321.1593887365242; 
 Sat, 04 Jul 2020 11:29:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzL5qC0opAIGq3LdwfzYudCnMD2PqFHUdfAyc7aVD/GggL3R8GmEGuzcljkP0GbZdeqCZKTbA==
X-Received: by 2002:a5d:6a06:: with SMTP id m6mr41433220wru.321.1593887365005; 
 Sat, 04 Jul 2020 11:29:25 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 12sm16801217wmg.6.2020.07.04.11.29.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 11:29:24 -0700 (PDT)
Date: Sat, 4 Jul 2020 14:29:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 00/41] virtio,acpi: features, fixes, cleanups.
Message-ID: <20200704182750.1088103-1-mst@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 11:39:20
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


v2 of the pull, fixing non-Linux builds.


The following changes since commit fc1bff958998910ec8d25db86cd2f53ff125f7ab:

  hw/misc/pca9552: Add missing TypeInfo::class_size field (2020-06-29 21:16:10 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to f7d98068bf7a0913744dd4ac0a28e8c841df2af5:

  vhost-vdpa: introduce vhost-vdpa net client (2020-07-04 11:13:50 -0400)

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
 hw/net/vhost_net.c                          |  44 +-
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
 68 files changed, 2639 insertions(+), 187 deletions(-)
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


