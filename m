Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D7ADC35E01
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 15:15:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCE4621744
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 15:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vo8Rpvt8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCE4621744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6bvc-0002Oy-1N
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 10:15:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55129)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j6bt1-0005ys-1q
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:12:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j6bsz-0000or-Oz
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:12:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53434
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j6bsz-0000oS-KD
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:12:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582643557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=D+YFW0GAp5FOw96r8UcqQnLMBmsV8WIdAcMc+g1MBBg=;
 b=Vo8Rpvt88BXaDqmlB2SW+groaqnuupAsJJnkOsxRnuR8ADtPw7A0yiNlTgKvonyb3PLeNO
 R5yrG1aV0VVQf4YJuhcokzJfX8x78QVjV3oVwT0IWwOfSVwOd4zJKKiAKtsvfL49TL9v0W
 9hepMy8haKOI3m6/7Nowkg74TCaetHU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-Rgl9Qgo6OnaFL_IOllqcsw-1; Tue, 25 Feb 2020 10:12:29 -0500
X-MC-Unique: Rgl9Qgo6OnaFL_IOllqcsw-1
Received: by mail-qv1-f69.google.com with SMTP id ce2so13163500qvb.23
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 07:12:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=/P10MK+T8XAegYl6PyUapW26JMQATqvjYBuMNYcvki0=;
 b=DNb6kBztG2VfTWCfFGJkk9BZedu+EGzcUyX+AFPlG+VPhupit06HYTXi5I/xqKS7MV
 hySz4jtaWONteAxes4ecjD5KSGqfJRANtzZoBgpdS+tfhnMx5FJXNUQwuDIKlhCpeTYv
 m8hmj73CAZjJitwgvtCRt21kRDpHgHQPMftCkptJT55i+eCjnI+NuaoqILWpGny5YJSy
 32uBwKar0V4K3kDpNqhmjBUBQHb3/Sm+D6MBathhqhz2Ch3HxKSzOAuLGhJef91zvgeW
 DCPFpkR9Ez7qRbwryRcOKCr/eWQqczSNMaJm9qUM6EwhYFS9OUGxRcoul9AFKVht5RsQ
 So+g==
X-Gm-Message-State: APjAAAWIf4ivoDinGd7KlJdebNpHoNm7oeZcIIpuFH7fvJbrrWFP3dQS
 5wHYRwyP/cnY/v15ju5ZcjCWKW2u+iCNJp1+RZ7ZgPDzYLIq6AzC9qrAdKRXBP6CH5Atj5AcwnQ
 9UyFwRJqkOzNpJRg=
X-Received: by 2002:a05:620a:522:: with SMTP id
 h2mr2370273qkh.260.1582643548428; 
 Tue, 25 Feb 2020 07:12:28 -0800 (PST)
X-Google-Smtp-Source: APXvYqyOngNIeDhStyFY83zlumr/CYrCtpHzmUoYMezCDS6HGoZTsAUS9QG6HMhqWDCcGEk++MZj9A==
X-Received: by 2002:a05:620a:522:: with SMTP id
 h2mr2370241qkh.260.1582643548160; 
 Tue, 25 Feb 2020 07:12:28 -0800 (PST)
Received: from redhat.com (bzq-79-178-2-214.red.bezeqint.net. [79.178.2.214])
 by smtp.gmail.com with ESMTPSA id
 o16sm7724355qtr.28.2020.02.25.07.12.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 07:12:27 -0800 (PST)
Date: Tue, 25 Feb 2020 10:12:24 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/32] virtio, pc: fixes, features
Message-ID: <20200225151210.647797-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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

The following changes since commit 9a8abceb5f01d1066d3a1ac5a33aabcbaeec1860=
:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-docs-20200225' i=
nto staging (2020-02-25 11:03:47 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to afc37debf27ecf34d6bc1d4b52fa0918d0bd3f3c:

  Fixed assert in vhost_user_set_mem_table_postcopy (2020-02-25 08:47:47 -0=
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

Laurent Vivier (2):
      tests/vhost-user-bridge: move to contrib/
      virtiofsd: add it to the tools list

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

 docs/specs/acpi_cpu_hotplug.txt                    |   2 +
 configure                                          |   3 +
 Makefile                                           |   7 +-
 contrib/libvhost-user/libvhost-user-glib.h         |   1 +
 contrib/libvhost-user/libvhost-user.h              |  14 +
 include/hw/arm/virt.h                              |   2 +
 include/hw/pci/pci.h                               |   1 +
 include/hw/virtio/vhost-user-blk.h                 |   3 +-
 include/hw/virtio/vhost-user-fs.h                  |   2 +
 include/hw/virtio/virtio-iommu.h                   |  61 ++
 contrib/libvhost-user/libvhost-user-glib.c         |  17 +-
 contrib/libvhost-user/libvhost-user.c              | 139 +++-
 .../vhost-user-bridge/main.c                       |   0
 contrib/vhost-user-input/main.c                    |   6 +-
 hw/arm/virt.c                                      |  57 +-
 hw/block/vhost-user-blk.c                          |  23 +-
 hw/virtio/vhost-user-fs.c                          |  16 +-
 hw/virtio/vhost-user.c                             |  10 +-
 hw/virtio/virtio-crypto.c                          |   3 +-
 hw/virtio/virtio-iommu-pci.c                       | 104 +++
 hw/virtio/virtio-iommu.c                           | 890 +++++++++++++++++=
++++
 hw/virtio/virtio-pmem.c                            |   1 +
 hw/virtio/virtio.c                                 |  99 ++-
 qdev-monitor.c                                     |   1 +
 tests/qtest/bios-tables-test.c                     |  31 +-
 MAINTAINERS                                        |   6 +
 Makefile.objs                                      |   1 +
 contrib/vhost-user-bridge/Makefile.objs            |   1 +
 docs/devel/migration.rst                           |   2 +-
 docs/interop/vhost-user.rst                        | 122 ++-
 hw/virtio/Kconfig                                  |   5 +
 hw/virtio/Makefile.objs                            |   2 +
 hw/virtio/trace-events                             |  20 +
 tests/Makefile.include                             |   1 -
 tests/data/acpi/rebuild-expected-aml.sh            |   7 +
 35 files changed, 1573 insertions(+), 87 deletions(-)
 create mode 100644 include/hw/virtio/virtio-iommu.h
 rename tests/vhost-user-bridge.c =3D> contrib/vhost-user-bridge/main.c (10=
0%)
 create mode 100644 hw/virtio/virtio-iommu-pci.c
 create mode 100644 hw/virtio/virtio-iommu.c
 create mode 100644 contrib/vhost-user-bridge/Makefile.objs


