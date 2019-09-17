Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D7E0C4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 15:13:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BDDB2171F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 15:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GAilcvFk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BDDB2171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAFAV-0003cJ-5V
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 11:13:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60045)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iAF7p-0002Bp-0s
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 11:10:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iAF7m-0000JG-BV
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 11:10:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49887
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iAF7m-0000Il-0o
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 11:10:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1568733037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ykfl59zCCmop/Y0BjsixPiI1Ho47hf/EutE2iaEz1Zc=;
 b=GAilcvFkUfvPy79r3//jaGD2Um8OvrmDFUkH5UyfvABkkEB5DhPONDOAR3y0lF/t711Ffy
 mAFuQl0VZyctMit+L4gUBtVHZ9bh2RgBdBXfiw0rCImAxXAJ99H7RUQuznWMOC9lMu4qhY
 7ntHvFWBQVLFXZwF5CGGgaxjLHeD+3k=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-4dMXMU9ZOO-tcRe11vVD7g-1; Tue, 17 Sep 2019 11:10:35 -0400
Received: by mail-qk1-f198.google.com with SMTP id s28so4569348qkm.5
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 08:10:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=9ctUaqIooB9LK9f9i4+vlUqEOeFw/Z0RRIJTN98UZvs=;
 b=BRJsJBkC/0oKZj5a+0ybasGH1cwLfip7jZRfAk62/o4HNcqDgnAxtH3BM90fJGZete
 IXlVDk6LWk43dXt8cptHNHsyqf9mUFh9cciPxgDPCMW4tYgz41fZVhqvEMO+/lAJ7KaV
 5mhz7yuRcXH1vZmH/eUVqgSk27noHi3MUdP0D+sim1aCvKI9ubsXXm4VoCD6If3CxGvY
 5JFmoyed8Uc+kVlb4E5bCcAZ0UwU3Ox3M1xlBHdY9cnxQ+lFpDUNq45cRvfYGeN6L1Eo
 dYxRzxHgmym1DlH2VsoNSUU7dS/Ny8ELLVK802rY6cYdkfhHCE0eWS8zYEUDxP27PNa0
 t4Ow==
X-Gm-Message-State: APjAAAVe3Kbl32TpN1SuDHOnBX9erkrtRr3OdG/Cse9ZMpUv+QGJBR71
 V6v+SKV7Zg9BWfekARtIzUhRZdAcJFRipcMJ2Lyu/dj5dZj6ixs6YUmnY3GvPNAidR7IQhwMN2x
 LC4knet6ABBQTEZM=
X-Received: by 2002:a37:9742:: with SMTP id z63mr4450722qkd.350.1568733033626; 
 Tue, 17 Sep 2019 08:10:33 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw/TWozT+L3CkR1MJxMZ3FAapkePKeEKGTlPI2NF91cTQVBQY00DOt9JmSlZLxOPFJMAFpIwA==
X-Received: by 2002:a37:9742:: with SMTP id z63mr4450691qkd.350.1568733033389; 
 Tue, 17 Sep 2019 08:10:33 -0700 (PDT)
Received: from redhat.com (bzq-79-176-40-226.red.bezeqint.net. [79.176.40.226])
 by smtp.gmail.com with ESMTPSA id f11sm1128348qkk.76.2019.09.17.08.10.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2019 08:10:32 -0700 (PDT)
Date: Tue, 17 Sep 2019 11:10:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190917151011.24588-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-MC-Unique: 4dMXMU9ZOO-tcRe11vVD7g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
Subject: [Qemu-devel] [PULL 00/10] virtio, vhost, pc: features, fixes,
 cleanups.
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

The following changes since commit 138985c1ef8b66e4e5b383354e133e05d01d0b5f=
:

  Merge remote-tracking branch 'remotes/amarkovic/tags/mips-queue-sep-12-20=
19' into staging (2019-09-13 16:04:46 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 44e687a4d9ab327761e221844ced7dc9c23350a5:

  virtio-mmio: implement modern (v2) personality (virtio-1) (2019-09-16 11:=
17:06 -0400)

----------------------------------------------------------------
virtio,vhost,pc: features, fixes, cleanups.

Virtio 1.0 support for virtio-mmio.
Misc fixes, cleanups.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Laurent Vivier (1):
      MAINTAINERS: update virtio-rng and virtio-serial maintainer

Pankaj Gupta (1):
      virtio pmem: user document

Peter Xu (4):
      intel_iommu: Sanity check vfio-pci config on machine init done
      qdev/machine: Introduce hotplug_allowed hook
      pc/q35: Disallow vfio-pci hotplug without VT-d caching mode
      intel_iommu: Remove the caching-mode check during flag change

Raphael Norwitz (2):
      vhost-user-blk: prevent using uninitialized vqs
      backends/vhost-user.c: prevent using uninitialized vqs

Sergio Lopez (1):
      virtio-mmio: implement modern (v2) personality (virtio-1)

Wei Yang (1):
      docs/nvdimm: add example on persistent backend setup

 docs/nvdimm.txt           |  31 +++++
 include/hw/boards.h       |   9 ++
 include/hw/qdev-core.h    |   1 +
 backends/vhost-user.c     |   2 +-
 hw/block/vhost-user-blk.c |   2 +-
 hw/core/qdev.c            |  17 +++
 hw/i386/intel_iommu.c     |  41 +++++-
 hw/i386/pc.c              |  21 +++
 hw/virtio/virtio-mmio.c   | 342 ++++++++++++++++++++++++++++++++++++++++++=
----
 qdev-monitor.c            |   7 +
 MAINTAINERS               |   6 +-
 docs/virtio-pmem.rst      |  75 ++++++++++
 12 files changed, 521 insertions(+), 33 deletions(-)
 create mode 100644 docs/virtio-pmem.rst


