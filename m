Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97BF5C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 12:11:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6528B20771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 12:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DVE17KGU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6528B20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyDax-0008V4-KO
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 08:11:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44902)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jyDYf-0005Gw-Jz
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 08:09:13 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23327
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jyDYe-0006Yy-2G
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 08:09:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595419751;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=31VqY//DtBodiNGMXlVfA/2kGPUGV525DXCYEW/HUqs=;
 b=DVE17KGUezWmryv5DjNvcFxw5k9kIF7JahL4BpAeICUMfbay/xPrw4v+BKw6vAmCfjpfED
 VyFlcN3+focWEsgaELU/SqdrlmNheO28cqmhGxTeoacacUpyNdDOYT05FBfuuHVcCNRNp4
 cWfWyKnhl3JjA0lbU8OLTjb+l4kSxjk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-VKOqQqEYPbG2SDHqNY7O-Q-1; Wed, 22 Jul 2020 08:09:09 -0400
X-MC-Unique: VKOqQqEYPbG2SDHqNY7O-Q-1
Received: by mail-wm1-f70.google.com with SMTP id z74so975319wmc.4
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 05:09:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=31VqY//DtBodiNGMXlVfA/2kGPUGV525DXCYEW/HUqs=;
 b=TrwOCzSTo0U4Qx8XaJua88xh6tMWfhzdrG1mI8mQxEtyn4rU4eiDLk4XTG9fpHVoHq
 0r7r11D2b/+TkmjgUJwlYYz85Qmoa6snJJchAtZqbeJJ5kwjB0+uD168p0Y1/Dy7QiT/
 DExH+bY+MvgVcA5hqBP38eB5W+jsMYFzSSWoN/3Hq5CqKu+8D2F57zL0SrTFLUlC7mC5
 ZQFIXfK/4/K0hUpPeolElheJWRAqCF3iUPcYfbdYivFZ/dmiQuicsjZzSJ9Nc67iI+UW
 ceYdMZggFdgShGJmSnBP/WgABBFnZFrzG9A2PMKcMdoQo1MkWcCPOxeYCpYCS7UaNpvK
 p4dw==
X-Gm-Message-State: AOAM530Nl2eIJkrsyJmgieBOPVccwCoceeqZ2LCnrofACc42uMHkKZdt
 LDpWYWvUTXXcyVB39SKXmdU4m8h3+uM+3hiRwL4IXY0ybgizIPLp3A6TNQoEu2dZt6pqZVklBoD
 JUysug13iljGpHak=
X-Received: by 2002:a1c:9e06:: with SMTP id h6mr7932292wme.45.1595419748030;
 Wed, 22 Jul 2020 05:09:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwbeCThEDeXQXXoSOAOk0QUKUkli2853xncBuPPyxeJNj+hI6kK8ksEcJ3mYIkLvtJOJsnLAA==
X-Received: by 2002:a1c:9e06:: with SMTP id h6mr7932276wme.45.1595419747800;
 Wed, 22 Jul 2020 05:09:07 -0700 (PDT)
Received: from redhat.com (bzq-79-182-82-99.red.bezeqint.net. [79.182.82.99])
 by smtp.gmail.com with ESMTPSA id
 t14sm29233384wrv.14.2020.07.22.05.09.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2020 05:09:07 -0700 (PDT)
Date: Wed, 22 Jul 2020 08:09:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/9] acpi,virtio,pc: bugfixes
Message-ID: <20200722120853.9144-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 21:28:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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

The following changes since commit c8004fe6bbfc0d9c2e7b942c418a85efb3ac4b00:

  Update version for v5.1.0-rc1 release (2020-07-21 20:28:59 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to ccec7e9603f446fe75c6c563ba335c00cfda6a06:

  virtio-pci: Changed vdev to proxy for VirtIO PCI BAR callbacks. (2020-07-22 08:05:37 -0400)

----------------------------------------------------------------
acpi,virtio,pc: bugfixes

Fix bug in ACPI which were tripping up guests.
Fix a use-after-free with hotplug of virtio devices.
Block ability to create legacy devices which shouldn't have been
there in the first place.
Fix migration error handling with balloon.
Drop some dead code in virtio.
vtd emulation fixup.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Alexander Duyck (3):
      virtio-balloon: Prevent guest from starting a report when we didn't request one
      virtio-balloon: Add locking to prevent possible race when starting hinting
      virtio-balloon: Replace free page hinting references to 'report' with 'hint'

Andrew Melnychenko (1):
      virtio-pci: Changed vdev to proxy for VirtIO PCI BAR callbacks.

Cornelia Huck (2):
      virtio: list legacy-capable devices
      virtio: verify that legacy support is not accidentally on

Liu Yi L (1):
      intel_iommu: Use correct shift for 256 bits qi descriptor

Markus Armbruster (1):
      virtio: Drop broken and superfluous object_property_set_link()

Michael Tokarev (1):
      acpi: accept byte and word access to core ACPI registers

 hw/i386/intel_iommu_internal.h     |  3 +-
 include/hw/virtio/virtio-balloon.h | 20 +++++-----
 include/hw/virtio/virtio.h         |  2 +
 hw/acpi/core.c                     |  9 +++--
 hw/i386/intel_iommu.c              |  7 +++-
 hw/s390x/virtio-ccw-crypto.c       |  3 --
 hw/s390x/virtio-ccw-rng.c          |  3 --
 hw/s390x/virtio-ccw.c              |  6 +++
 hw/virtio/virtio-balloon.c         | 79 ++++++++++++++++++++------------------
 hw/virtio/virtio-crypto-pci.c      |  2 -
 hw/virtio/virtio-pci.c             | 38 +++++++++++++-----
 hw/virtio/virtio-rng-pci.c         |  3 --
 hw/virtio/virtio.c                 | 25 ++++++++++++
 13 files changed, 127 insertions(+), 73 deletions(-)


