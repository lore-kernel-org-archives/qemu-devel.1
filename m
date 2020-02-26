Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B485AC4BA0B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 09:02:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ECAB20732
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 09:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PX7hOHFW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ECAB20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6saI-0006KG-NS
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 04:02:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55993)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j6sZ5-00050F-72
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:01:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j6sZ3-0000Ft-K8
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:01:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35789
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j6sZ3-0000Dd-D2
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:01:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582707668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wyBM9w5NQHfTQVsNOivIJiMDTmocoHv6Kid5lG+hEBI=;
 b=PX7hOHFWZg0y4yO5Om4qhyFdJy0beRiiqUjYmu4+BsoQeBrGEcXrQCT428yfQ8ajGvxBCg
 ktTw8a16KqZ4zRlPM91yG6osoEsAmPrC/wI2/iKDT3mI2wiIR/kDk/WkwoRlLfa2/gg5X/
 NV8sS7lrl1IBdn7CwALfvNNzTeaVWE8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-QsU6uOsyOFWaphopWwV2tQ-1; Wed, 26 Feb 2020 04:01:03 -0500
X-MC-Unique: QsU6uOsyOFWaphopWwV2tQ-1
Received: by mail-qk1-f199.google.com with SMTP id d2so3270365qko.3
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 01:01:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=7WPuRQ/w/VTpuymddn8nYTp5EryK6bIkvOeRtG/Srts=;
 b=mLLIr6MGcF/6FggUtcyOvLP2dE2CaCLYqemF8icDp8zc0dG0uczcYTroEnNAOLImyg
 rqWHNWkUr0PvUutSAMsBv9wGEspkLI63bUKAVsNQLSFPp3VzbWAWZ1OimkJlhWWUlK44
 jlR5VBi4vsIT113aP9hid1T/bj34JAe3iKekFAAE2HBW5EifLcIosR6zOsUnVxjQ3OGN
 i1XrAgr9M7mM5F9muXWLP22kN/FFeQyHt9RL/bOapLjcqe4HtpmDmxtEFcr1J+fAiaOP
 cE70R7MZdXnINopz/mIYdyg2Vhy2hD68TJZHsiqTDYMXD2Vv1cGaIGD/a8/rwFxWx2Kq
 8Rlg==
X-Gm-Message-State: APjAAAW2/JcODlcxdnNfaGN9ARTng3YeqAC4Z8SxSDzK7p1HMqu2G/m8
 vIrGAW7gQjahEJe1TMelpdtEe5dvekKlyZnKA9/1dW6SXzqD6IRxDNwhMW/tBH5z8q6eOap6fRY
 xwuxV5jgeQkM/zds=
X-Received: by 2002:a0c:b38a:: with SMTP id t10mr3970914qve.198.1582707662617; 
 Wed, 26 Feb 2020 01:01:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqyCsm5hkIPXb2Jq6F8O2quDmQTmI4NBLhZpag66LGszuLtnprAjqlZ0yjsVgRbvtrDKzc5wyg==
X-Received: by 2002:a0c:b38a:: with SMTP id t10mr3970892qve.198.1582707662369; 
 Wed, 26 Feb 2020 01:01:02 -0800 (PST)
Received: from redhat.com (bzq-79-178-2-214.red.bezeqint.net. [79.178.2.214])
 by smtp.gmail.com with ESMTPSA id
 64sm797556qkd.78.2020.02.26.01.01.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2020 01:01:01 -0800 (PST)
Date: Wed, 26 Feb 2020 04:00:58 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 00/30] virtio, pc: fixes, features
Message-ID: <20200226090010.708934-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
    dropped vhost changes, hope this fixes build on Mac OS.

The following changes since commit 9a8abceb5f01d1066d3a1ac5a33aabcbaeec1860=
:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-docs-20200225' i=
nto staging (2020-02-25 11:03:47 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to deec824070e408b936e02883a1e2cb5af92448d0:

  Fixed assert in vhost_user_set_mem_table_postcopy (2020-02-25 16:55:32 -0=
500)

----------------------------------------------------------------
virtio, pc: fixes, features

New virtio iommu.
Unrealize memory leaks.
In-band kick/call support.
Bugfixes, documentation all over the place.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Adrian Moreno (1):
      vhost-user: only set slave channel for first vq

Eric Auger (10):
      virtio-iommu: Add skeleton
      virtio-iommu: Decode the command payload
      virtio-iommu: Implement attach/detach command
      virtio-iommu: Implement map/unmap
      virtio-iommu: Implement translate
      virtio-iommu: Implement fault reporting
      virtio-iommu: Support migration
      virtio-iommu-pci: Add virtio iommu pci support
      hw/arm/virt: Add the virtio-iommu device tree mappings
      MAINTAINERS: add virtio-iommu related files

Igor Mammedov (1):
      acpi: cpuhp: document CPHP_GET_CPU_ID_CMD command

Johannes Berg (6):
      libvhost-user: implement VHOST_USER_PROTOCOL_F_REPLY_ACK
      libvhost-user-glib: fix VugDev main fd cleanup
      libvhost-user-glib: use g_main_context_get_thread_default()
      libvhost-user: handle NOFD flag in call/kick/err better
      docs: vhost-user: add in-band kick/call messages
      libvhost-user: implement in-band notifications

Michael S. Tsirkin (4):
      bios-tables-test: tell people how to update
      bios-tables-test: fix up DIFF generation
      bios-tables-test: default diff command
      rebuild-expected-aml.sh: remind about the process

Pan Nengyuan (6):
      vhost-user-fs: do delete virtio_queues in unrealize
      vhost-user-fs: convert to the new virtio_delete_queue function
      virtio-pmem: do delete rq_vq in virtio_pmem_unrealize
      virtio-crypto: do delete ctrl_vq in virtio_crypto_device_unrealize
      vhost-user-blk: delete virtioqueues in unrealize to fix memleaks
      vhost-user-blk: convert to new virtio_delete_queue

Raphael Norwitz (1):
      Fixed assert in vhost_user_set_mem_table_postcopy

Stefan Hajnoczi (1):
      virtio: gracefully handle invalid region caches

 docs/specs/acpi_cpu_hotplug.txt            |   2 +
 contrib/libvhost-user/libvhost-user-glib.h |   1 +
 contrib/libvhost-user/libvhost-user.h      |  14 +
 include/hw/arm/virt.h                      |   2 +
 include/hw/pci/pci.h                       |   1 +
 include/hw/virtio/vhost-user-blk.h         |   3 +-
 include/hw/virtio/vhost-user-fs.h          |   2 +
 include/hw/virtio/virtio-iommu.h           |  61 ++
 contrib/libvhost-user/libvhost-user-glib.c |  17 +-
 contrib/libvhost-user/libvhost-user.c      | 139 ++++-
 contrib/vhost-user-input/main.c            |   6 +-
 hw/arm/virt.c                              |  57 +-
 hw/block/vhost-user-blk.c                  |  23 +-
 hw/virtio/vhost-user-fs.c                  |  16 +-
 hw/virtio/vhost-user.c                     |  10 +-
 hw/virtio/virtio-crypto.c                  |   3 +-
 hw/virtio/virtio-iommu-pci.c               | 104 ++++
 hw/virtio/virtio-iommu.c                   | 890 +++++++++++++++++++++++++=
++++
 hw/virtio/virtio-pmem.c                    |   1 +
 hw/virtio/virtio.c                         |  99 +++-
 qdev-monitor.c                             |   1 +
 tests/qtest/bios-tables-test.c             |  31 +-
 MAINTAINERS                                |   6 +
 docs/interop/vhost-user.rst                | 122 +++-
 hw/virtio/Kconfig                          |   5 +
 hw/virtio/Makefile.objs                    |   2 +
 hw/virtio/trace-events                     |  20 +
 tests/data/acpi/rebuild-expected-aml.sh    |   7 +
 28 files changed, 1562 insertions(+), 83 deletions(-)
 create mode 100644 include/hw/virtio/virtio-iommu.h
 create mode 100644 hw/virtio/virtio-iommu-pci.c
 create mode 100644 hw/virtio/virtio-iommu.c


