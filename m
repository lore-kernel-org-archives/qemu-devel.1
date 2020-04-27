Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F240C54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 10:25:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1762F2064C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 10:25:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E3hO16Af"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1762F2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT0x9-00014J-Vr
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 06:25:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43072)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jT0w6-0000EB-UU
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 06:24:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jT0w5-0005ee-Ts
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 06:24:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33202
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jT0w5-0005eV-H8
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 06:24:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587983064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=j6g9s5XUflybaheUo/IGc4BDyuX36qLojgvo/hs4cHE=;
 b=E3hO16AfP9djMzjrz3PFSqiFU35OUFF1ntHMd7hD6m8ZBUNrlAJZvhAcrhuEoBPJznn1Yv
 mxorZZpFzU1gk7T/HztYfHLCdUgHaxICI66B5g48j8uCx7d8GhGcnOorXV6it7YVQ5vhuC
 FrS9k3Rwjp8EKUjgB5CSvuidQ2nJ0qI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-xaTwFezrOT6bAh4pz573xw-1; Mon, 27 Apr 2020 06:24:23 -0400
X-MC-Unique: xaTwFezrOT6bAh4pz573xw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 55D4F107ACF3;
 Mon, 27 Apr 2020 10:24:22 +0000 (UTC)
Received: from localhost (ovpn-112-184.ams2.redhat.com [10.36.112.184])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DCEB127CCA;
 Mon, 27 Apr 2020 10:24:19 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 0/3] headers update and virtio-net fixup
Date: Mon, 27 Apr 2020 12:24:12 +0200
Message-Id: <20200427102415.10915-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 02:05:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Yuri Benditovich <yuri.benditovich@daynix.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This updates the headers to Linux 5.7-rc3. Doing so exposes
a problem in virtio-net (the #define for compat covers too much),
fix it.

Note 1: I'd like this to go through s390-next so that I can go
        ahead with protected virtualization, which needs a headers
        update.

Note 2: Why has the feature been merged in the first place without the
        kernel part being upstream yet?

Cornelia Huck (3):
  virtio-net: fix rsc_ext compat handling
  linux-headers: update against Linux 5.7-rc3
  virtio-net: remove VIRTIO_NET_HDR_F_RSC_INFO compat handling

 hw/net/virtio-net.c                           |   8 --
 include/standard-headers/linux/ethtool.h      |  10 +-
 .../linux/input-event-codes.h                 |   5 +-
 include/standard-headers/linux/pci_regs.h     |   2 +
 include/standard-headers/linux/vhost_types.h  |   8 ++
 .../standard-headers/linux/virtio_balloon.h   |  12 ++-
 include/standard-headers/linux/virtio_ids.h   |   1 +
 include/standard-headers/linux/virtio_net.h   | 102 +++++++++++++++++-
 linux-headers/COPYING                         |   2 +
 linux-headers/asm-x86/kvm.h                   |   1 +
 linux-headers/asm-x86/unistd_32.h             |   1 +
 linux-headers/asm-x86/unistd_64.h             |   1 +
 linux-headers/asm-x86/unistd_x32.h            |   1 +
 linux-headers/linux/kvm.h                     |  47 +++++++-
 linux-headers/linux/mman.h                    |   5 +-
 linux-headers/linux/userfaultfd.h             |  40 +++++--
 linux-headers/linux/vfio.h                    |  37 +++++++
 linux-headers/linux/vhost.h                   |  24 +++++
 18 files changed, 280 insertions(+), 27 deletions(-)

--=20
2.21.1


