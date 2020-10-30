Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29709C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 12:47:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88D1720725
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 12:47:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VMPDAlWj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88D1720725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYToP-00025q-MR
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 08:47:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53556)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kYTmM-0000Qc-JN
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 08:45:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47414)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kYTmK-0000KW-CB
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 08:45:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604061909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=VQON/qkHfDHAcqI32ttgHuJ36suArQZ7MBSOwD5g+6Y=;
 b=VMPDAlWjbeGzdNfPJ/4FFfs9UyCnPE1EE/P2o4k6kVUpHxjkfUWbcsLnSqeKBLTfS1wSeN
 D7kf5S+0w8dvx4f41Njs8IrUptb1apPo6YNoFdW+pg/RKwizU9zRpi9GmuHBIomySJk/+g
 nDHvFLIBoXzGthaxXwZJSzKokFzFpgI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-XQDtYldNM_yPDOFPWx5M_Q-1; Fri, 30 Oct 2020 08:45:08 -0400
X-MC-Unique: XQDtYldNM_yPDOFPWx5M_Q-1
Received: by mail-wr1-f70.google.com with SMTP id n14so2616102wrp.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 05:45:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:content-transfer-encoding;
 bh=VQON/qkHfDHAcqI32ttgHuJ36suArQZ7MBSOwD5g+6Y=;
 b=LtSwRG1GvNKd+m/yFW7HZOWmDzcomBk6XmY2/kK1E+gruCTkUkzTzI58psJt7GnbP+
 qoaH9Bkx+9WAvXW7NMOnQ1vLyy4gObLw3ZdsVVsVirmhSTf7ULrzKneHUXYaxmng12aG
 Vw0yKebJB1eB9mHbzUv+eQ4gIrEKqY9BWkbY/l3YmBUDaozD6HJOE95wosKaVjlk0qeK
 rpctd8JOQdX/tkeuaCuE8w22i65F/oOD4nSSvms5NxL0sp3rAazezxFEx/iIN8nOtUIX
 4SFpAXSWIj2Hwysjgiu7o4mwpcASZD2cZV5MG4FeQ+G+m+GqkeHhaJs2vSQOSnCfLzl3
 J/pg==
X-Gm-Message-State: AOAM532SA/JwCvRF/LTW8y9+R/UWegETLwbVQvpkkPCRejpWZajV4tt/
 6R8QCHqVuEAvB26fq5eO98Ndf7f3N73sYtYssF4xe5kinKQzKQpDE6eCQeXTwkig4KampnidFlk
 cw8YGr7Sne1GVYn8=
X-Received: by 2002:a1c:3d54:: with SMTP id k81mr2640168wma.144.1604061906376; 
 Fri, 30 Oct 2020 05:45:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyQXoq4HHkVVEzPfrCzKk/9c3SYote7ULp1yu6VAG+Zlf1u5ZVbXyC+ihsCeOYT1j9VUXsSNA==
X-Received: by 2002:a1c:3d54:: with SMTP id k81mr2640156wma.144.1604061906216; 
 Fri, 30 Oct 2020 05:45:06 -0700 (PDT)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id a17sm10585283wra.29.2020.10.30.05.45.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2020 05:45:05 -0700 (PDT)
Date: Fri, 30 Oct 2020 08:45:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/15] pc,pci,vhost,virtio: misc fixes
Message-ID: <20201030124454.854286-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 01:22:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

The following changes since commit 802427bcdae1ad2eceea8a8877ecad835e3f8fde:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20201027-1' into staging (2020-10-29 11:40:04 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 73beb01ec54969f76ab32d1e0605a759b6c95ab0:

  intel_iommu: Fix two misuse of "0x%u" prints (2020-10-30 06:48:53 -0400)

----------------------------------------------------------------
pc,pci,vhost,virtio: misc fixes

Just a bunch of bugfixes all over the place.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Ben Widawsky (4):
      acpi/crs: Prevent bad ranges for host bridges
      acpi/crs: Support ranges > 32b for hosts
      pci: Change error_report to assert(3)
      pci: Disallow improper BAR registration for type 1

Eduardo Habkost (1):
      pc: Implement -no-hpet as sugar for -machine hpet=on

Felipe Franciosi (1):
      virtio: skip guest index check on device load

Greg Kurz (1):
      vhost: Don't special case vq->used_phys in vhost_get_log_size()

Jason Wang (1):
      pci: advertise a page aligned ATS

Jin Yu (1):
      vhost-blk: set features before setting inflight feature

Mark Cave-Ayland (1):
      pci: Assert irqnum is between 0 and bus->nirqs in pci_bus_change_irq_level

Peter Xu (1):
      intel_iommu: Fix two misuse of "0x%u" prints

Philippe Mathieu-Daudé (2):
      hw/virtio/vhost-vdpa: Fix Coverity CID 1432864
      hw/pci: Extract pci_bus_change_irq_level() from pci_change_irq_level()

Si-Wei Liu (1):
      vhost-vdpa: negotiate VIRTIO_NET_F_STATUS with driver

Stefano Garzarella (1):
      vhost-vsock: set vhostfd to non-blocking mode

 include/hw/i386/pc.h      |  1 +
 include/hw/i386/x86.h     |  3 ---
 include/hw/virtio/vhost.h |  1 +
 hw/block/vhost-user-blk.c |  6 +++++
 hw/i386/acpi-build.c      | 12 +++++++--
 hw/i386/intel_iommu.c     |  4 +--
 hw/i386/pc.c              | 63 ++++++++++++++++++++++++++++++++---------------
 hw/i386/pc_piix.c         |  2 +-
 hw/pci/pci.c              | 23 +++++++++++------
 hw/pci/pcie.c             |  5 ++--
 hw/virtio/vhost-vdpa.c    |  4 +--
 hw/virtio/vhost-vsock.c   | 10 ++++++++
 hw/virtio/vhost.c         | 28 +++++++++++++--------
 hw/virtio/virtio.c        | 13 +++++-----
 net/vhost-vdpa.c          |  1 +
 softmmu/vl.c              |  4 +--
 16 files changed, 123 insertions(+), 57 deletions(-)


