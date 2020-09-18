Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E03C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 15:08:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2F3023888
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 15:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="azDRzBjF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2F3023888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJI0G-00014x-P7
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 11:08:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47266)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kJHxZ-0006KC-LH
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 11:06:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44756
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kJHxW-0000Vn-WB
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 11:06:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600441557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=Frm/rE/G7Rd8SWOBPwAxDnuhaYIwkzJHbTwBlh4ocT4=;
 b=azDRzBjF0grlRyOW6CLXP8h+XN33xyQWT5c7fuLlzEMKHvRaoywbWTP0vn/UEhm3DN/hFm
 1KJZR+nlyho0s4MSOZZNBbWwN1tE9HJqHaaFJt0Z5Pk3+ZVj/AsvailSCvYj0q/fMEhloP
 VteDCWLd4SsvphWJGd/7OvyymulU6wI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-Mv0brcSFMLSDYKl6oQTdYA-1; Fri, 18 Sep 2020 11:05:55 -0400
X-MC-Unique: Mv0brcSFMLSDYKl6oQTdYA-1
Received: by mail-wm1-f71.google.com with SMTP id a7so2170749wmc.2
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 08:05:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=Frm/rE/G7Rd8SWOBPwAxDnuhaYIwkzJHbTwBlh4ocT4=;
 b=b6ENTDvfwU0sNu7KOGEM6FwExsV4yOrKDtL7044swG73ZR134GOqFf72YoVk7mQ93j
 JKbx0acFndf+HoIQGpO9Lvv7CV1xZ4NhMbSGfdZW8/Wo95hmfl0+puR4LCWwYclZFfDK
 mkp5Zm/U+cSQ2Jhz6TtOG3s3QRHly+loNCdmWZI1WXTwAUK6uoamMElDcY8NC04ue5KJ
 6yo9nMDc5xTwbl+aL6Xg3fdOw6mcV4y8iJbAdAsjxnqXU7olKPnsRN9dzne4gDB3fc4f
 Rt5nlrGTh7izB1NPpKktBnwEhPmZxkbQz47CHtGSUb66Tq/xkp2jgV48zqQ04bQ30il5
 qnKA==
X-Gm-Message-State: AOAM530VnEunV8UOCAdhGYL1qBXhSmtZRUSW3tmSJWSxqoKbfOl4jH8k
 A/lRSD0u7rShyd/sP6wWX97y2k3AQ9DvZo13rY+Lp3/nUi+dbCsevm6G1FOutYXCHo+gevqg9lx
 ghmjmFxCErgaPmBw=
X-Received: by 2002:a7b:c111:: with SMTP id w17mr16726378wmi.28.1600441551313; 
 Fri, 18 Sep 2020 08:05:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy8H/eIJhQbLLTATnKOO4J1Rl81ljgI2zRGYWDINcqMeUH9+79jucEjW/BOTkBMhZGkU/Lw3A==
X-Received: by 2002:a7b:c111:: with SMTP id w17mr16726356wmi.28.1600441551089; 
 Fri, 18 Sep 2020 08:05:51 -0700 (PDT)
Received: from redhat.com (bzq-109-65-116-225.red.bezeqint.net.
 [109.65.116.225])
 by smtp.gmail.com with ESMTPSA id a5sm5618001wrp.37.2020.09.18.08.05.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 08:05:50 -0700 (PDT)
Date: Fri, 18 Sep 2020 11:05:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/15] virtio,pc,acpi: fixes, tests
Message-ID: <20200918150506.286890-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 03:47:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 8ee612722dc08830761516e761dde934c3753a14:

  Merge remote-tracking branch 'remotes/cschoenebeck/tags/pull-9p-20200915' into staging (2020-09-16 14:47:50 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 4c67a4c6b399c8fadacb0a0b542d6372fd4092f5:

  virtio-iommu-pci: force virtio version 1 (2020-09-18 10:58:09 -0400)

----------------------------------------------------------------
virtio,pc,acpi: fixes, tests

Fixes and tests all over the place.
Batch iommu updates for vdpa.
Removal of deprecated cpu hotplug commands.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
David Hildenbrand (1):
      pc: fix auto_enable_numa_with_memhp/auto_enable_numa_with_memdev for the 5.0 machine

Dima Stepanov (7):
      vhost: recheck dev state in the vhost_migration_log routine
      vhost: check queue state in the vhost_dev_set_log routine
      tests/qtest/vhost-user-test: prepare the tests for adding new dev class
      tests/qtest/libqos/virtio-blk: add support for vhost-user-blk
      tests/qtest/vhost-user-test: add support for the vhost-user-blk device
      tests/qtest/vhost-user-test: add migrate_reconnect test
      tests/qtest/vhost-user-test: enable the reconnect tests

Eric Auger (2):
      virtio-iommu: Check gtrees are non null before destroying them
      virtio-iommu-pci: force virtio version 1

Igor Mammedov (1):
      cphp: remove deprecated cpu-add command(s)

Jason Wang (3):
      linux headers: sync to 5.9-rc4
      vhost: switch to use IOTLB v2 format
      vhost-vdpa: batch updating IOTLB mappings

Li Qiang (1):
      virtio-mem: detach the element from the virtqueue when error occurs

 qapi/machine.json                                  |  24 --
 include/hw/boards.h                                |   1 -
 include/hw/i386/pc.h                               |   1 -
 include/hw/virtio/vhost-backend.h                  |   2 +
 include/hw/virtio/vhost-user-blk.h                 |  10 +
 include/hw/virtio/vhost-vdpa.h                     |   1 +
 include/hw/virtio/vhost.h                          |   1 +
 include/monitor/hmp.h                              |   1 -
 include/standard-headers/drm/drm_fourcc.h          | 140 ++++++++++
 include/standard-headers/linux/ethtool.h           |  87 +++++++
 include/standard-headers/linux/input-event-codes.h |   3 +-
 include/standard-headers/linux/vhost_types.h       |  11 +
 include/standard-headers/linux/virtio_9p.h         |   4 +-
 include/standard-headers/linux/virtio_blk.h        |  26 +-
 include/standard-headers/linux/virtio_config.h     |   8 +-
 include/standard-headers/linux/virtio_console.h    |   8 +-
 include/standard-headers/linux/virtio_net.h        |   6 +-
 include/standard-headers/linux/virtio_scsi.h       |  20 +-
 linux-headers/asm-generic/unistd.h                 |   6 +-
 linux-headers/asm-mips/unistd_n32.h                |   1 +
 linux-headers/asm-mips/unistd_n64.h                |   1 +
 linux-headers/asm-mips/unistd_o32.h                |   1 +
 linux-headers/asm-powerpc/kvm.h                    |   5 +
 linux-headers/asm-powerpc/unistd_32.h              |   1 +
 linux-headers/asm-powerpc/unistd_64.h              |   1 +
 linux-headers/asm-s390/kvm.h                       |   7 +-
 linux-headers/asm-s390/unistd_32.h                 |   1 +
 linux-headers/asm-s390/unistd_64.h                 |   1 +
 linux-headers/asm-x86/unistd_32.h                  |   1 +
 linux-headers/asm-x86/unistd_64.h                  |   1 +
 linux-headers/asm-x86/unistd_x32.h                 |   1 +
 linux-headers/linux/kvm.h                          |   4 +
 linux-headers/linux/vfio.h                         |   2 +-
 linux-headers/linux/vhost.h                        |   2 +
 hw/block/vhost-user-blk.c                          |  19 +-
 hw/core/machine-hmp-cmds.c                         |  12 -
 hw/core/machine-qmp-cmds.c                         |  12 -
 hw/i386/pc.c                                       |  27 --
 hw/i386/pc_piix.c                                  |   1 -
 hw/i386/pc_q35.c                                   |   2 +-
 hw/s390x/s390-virtio-ccw.c                         |  12 -
 hw/virtio/vhost-backend.c                          |  88 +++++--
 hw/virtio/vhost-vdpa.c                             |  66 +++++
 hw/virtio/vhost.c                                  |  49 +++-
 hw/virtio/virtio-iommu-pci.c                       |   2 +-
 hw/virtio/virtio-iommu.c                           |   8 +-
 hw/virtio/virtio-mem.c                             |   3 +
 tests/qtest/cpu-plug-test.c                        | 100 +------
 tests/qtest/libqos/virtio-blk.c                    |  14 +
 tests/qtest/test-hmp.c                             |   1 -
 tests/qtest/vhost-user-test.c                      | 289 ++++++++++++++++++---
 docs/system/deprecated.rst                         |  25 +-
 hmp-commands.hx                                    |  15 --
 53 files changed, 813 insertions(+), 322 deletions(-)


