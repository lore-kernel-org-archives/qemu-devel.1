Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7BE5C5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 12:36:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 879E02187F
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 12:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iDqptGLC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 879E02187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSKY2-0000WY-5o
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 07:36:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57049)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iSKWu-0007qG-Sr
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 07:35:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iSKWt-0005Ir-8b
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 07:35:20 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52532
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iSKWs-0005I3-KK
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 07:35:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573043716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ab4cN5/fEhTk+ajkcROTzLT0+SROZYLl7PsWqUJHIO8=;
 b=iDqptGLCAIpB6jG8w/I/KgIZsrdWU2/HJBMHjGRzzOoqM9iVlCWQY4jzKPsE0lcVbxxJg6
 D41fPEka1NyqnuBHFJ2PB9k9oV65cHoC8aVQmYj+n7SFURTRCM0tXmg+lMy+yqiEOvLKaG
 NQX/jLr5LfoE2VOhwif2+cMu2jfDTrU=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-jvrlg7e8P82McyGDmyY8ZQ-1; Wed, 06 Nov 2019 07:35:14 -0500
Received: by mail-qk1-f199.google.com with SMTP id 64so24646646qkm.5
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2019 04:35:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=xD+iWxTC9VHBeXGnAofJDTh5dB7FcQPIYf1LT+g1i48=;
 b=m3htOpsynyp426P7YfNEtbh9NhS4Btw8uBSMUgjETCW5rWSVf7T4aA5nxa869D8Am+
 gbpcNY8+qZObcKreHIcoTylrkDi0laAZiCXsUidx6MAVlDwpzda7HVA7PeLgNNO0m69c
 PR2orK143MrqsCHOdW/1297PdijC6MCQAmAU0AnMGIV51ROdf1CUPFKiG1M8zTD3jVVV
 1BbMzGftoxP7CdRil0BOKq5sNPX93JlSVv96EvIEXffBbuJ/NRY7UKBFZakwkWuCzYu4
 arGiNQ8g8RQ/897R2q/WF0kCtA0eK0MgWiKtQJlrRW3SN0Fvgb/Ni9jYINjT/XEOUEHP
 Ec0Q==
X-Gm-Message-State: APjAAAXa+uCYkjDRlHpFBUJfJ0aKZKBmGEV0mQ6/N4Z0r5R3H1srZK8u
 ArPW3ax3xfrxmc0yX2vxT554oCW6Os5TtIdTYAa6omJw9t9ChXmcNDQYQa0SHjlYf+3QICMOtf5
 L7qlduLmiKvMLCgE=
X-Received: by 2002:a37:a5d3:: with SMTP id o202mr1597509qke.283.1573043713714; 
 Wed, 06 Nov 2019 04:35:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqwmRl3Nd24w3wRstrLReAF8hd+yrmXk4aFzKsTKBm8zYzAegWYRbo2p25KGi7U4WTIZ2EfOWw==
X-Received: by 2002:a37:a5d3:: with SMTP id o202mr1597297qke.283.1573043710368; 
 Wed, 06 Nov 2019 04:35:10 -0800 (PST)
Received: from redhat.com (bzq-79-178-12-128.red.bezeqint.net. [79.178.12.128])
 by smtp.gmail.com with ESMTPSA id p145sm6206496qke.37.2019.11.06.04.35.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2019 04:35:09 -0800 (PST)
Date: Wed, 6 Nov 2019 07:35:06 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/3] virtio, pci: fixes
Message-ID: <20191106123407.20997-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-MC-Unique: jvrlg7e8P82McyGDmyY8ZQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

The following changes since commit 36609b4fa36f0ac934874371874416f7533a5408=
:

  Merge remote-tracking branch 'remotes/palmer/tags/palmer-for-master-4.2-s=
f1' into staging (2019-11-02 17:59:03 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to fcccb271e0894bc04078ababb29d3d5e06b79892:

  virtio: notify virtqueue via host notifier when available (2019-11-06 06:=
35:00 -0500)

----------------------------------------------------------------
virtio, pci: fixes

A couple of bugfixes.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Alex Williamson (2):
      pci: Use PCI aliases when determining device IOMMU address space
      hw/i386: AMD-Vi IVRS DMA alias support

Stefan Hajnoczi (1):
      virtio: notify virtqueue via host notifier when available

 include/hw/virtio/virtio.h |   1 +
 hw/i386/acpi-build.c       | 127 +++++++++++++++++++++++++++++++++++++++++=
+---
 hw/pci/pci.c               |  43 +++++++++++++--
 hw/virtio/virtio-bus.c     |   4 ++
 hw/virtio/virtio.c         |   9 +++-
 5 files changed, 173 insertions(+), 11 deletions(-)


