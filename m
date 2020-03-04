Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A1AC3F2D1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 15:37:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BD9B20870
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 15:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SfuKEKcU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BD9B20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9W5G-00058Z-BS
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 10:37:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45979)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j9W4F-00033x-2u
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 10:36:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j9W4D-0006h0-Pq
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 10:36:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21141
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j9W4D-0006gO-Ml
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 10:36:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583336173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=G5NhvDKvPjvQJhnY14fHyEvQ/0myRniZs3nKil3lehY=;
 b=SfuKEKcUGXR2YDZGeb30pIjzd+4USnjnkFRGK7gRJSzk3WpR8Gi1yvjSjERGiw6gAdS0ye
 0TRh0C8hAkgLnlHWHJMD6i/R10fELQYPQjnOZcwQow0DtYJQbutYp9/mo1RpljKF5w+xVF
 DKni8zcpgHEw3oRc1cGadfbsF7l8AIo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-465-VOAPlJulO8WwFxMkuLU4tQ-1; Wed, 04 Mar 2020 10:36:06 -0500
X-MC-Unique: VOAPlJulO8WwFxMkuLU4tQ-1
Received: by mail-wr1-f71.google.com with SMTP id d7so1019296wrr.0
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2020 07:36:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Y0p/4JL8TMvLa6UgCA/KzBmR/o65cHnlPhknYfGAHbc=;
 b=Lw4+UyWOyHGoSIjC0Zz1yE1T6S+M/1wjeE93vTVdhMcoRHSIszLfeOcnHHs/V/bIIr
 p4iVZoC+VHy7dHn3ss1PIBibYZZ20P58mmH9tZBm1PfG20nS8zh1ySDG4Qf1IPc4zWSl
 0qHbybGI96eyNN1PfZxpL234m+/NpCyPi/Pm5nUzMwTLPNz55fhwV3H3vyGzUtisd8TX
 dwt81TcplApWSw9ifp892YkpNYY4vzVh3UBMh5j+bRMc3IMAlaimB7A0qHvUktZhfOln
 KhXZpiOlkWikO+dP4oligHsZOGPbD2NZfxf+Cq0Y7OA4hF0jxLvLA1IiWqLFgWHOf2p2
 FSxw==
X-Gm-Message-State: ANhLgQ1VJFQXLxdTuGKhAJ4+YsoeddaBj9izWoDTI/dIq9Gtjr46z23a
 l+QKHoZlH2ca9cWpWNfD06TYB94thY3+MbtAaJeijq4K2DkFoKyN+8WCJXOs5M6YvZj88iHnGV+
 lvVpwlt20e2iA4GQ=
X-Received: by 2002:a1c:4c0c:: with SMTP id z12mr4104668wmf.63.1583336165275; 
 Wed, 04 Mar 2020 07:36:05 -0800 (PST)
X-Google-Smtp-Source: ADFU+vsnixoK4WwsHKStCKoeIJWoF8gsWVwNLxPcy/79wKopAsHeNRdXO/i3sWblxFg1UvZ1xZa0cw==
X-Received: by 2002:a1c:4c0c:: with SMTP id z12mr4104628wmf.63.1583336165037; 
 Wed, 04 Mar 2020 07:36:05 -0800 (PST)
Received: from localhost.localdomain (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id b10sm4906024wmh.48.2020.03.04.07.36.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2020 07:36:04 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] misc: Replace zero-length arrays with flexible array
 member
Date: Wed,  4 Mar 2020 16:35:59 +0100
Message-Id: <20200304153601.23423-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>, qemu-block@nongnu.org,
 Paul Durrant <paul@xen.org>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Max Reitz <mreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v2:
- do not modify qed.h (structure with single member)
- based on hw/scsi/spapr_vscsi fix series

This is a tree-wide cleanup inspired by a Linux kernel commit
(from Gustavo A. R. Silva).

--v-- description start --v--

  The current codebase makes use of the zero-length array language
  extension to the C90 standard, but the preferred mechanism to
  declare variable-length types such as these ones is a flexible
  array member [1], introduced in C99:

  struct foo {
      int stuff;
      struct boo array[];
  };

  By making use of the mechanism above, we will get a compiler
  warning in case the flexible array does not occur last in the
  structure, which will help us prevent some kind of undefined
  behavior bugs from being unadvertenly introduced [2] to the
  Linux codebase from now on.

--^-- description end --^--

Do the similar housekeeping in the QEMU codebase (which uses
C99 since commit 7be41675f7cb).

The first patch is done with the help of a coccinelle semantic
patch. However Coccinelle does not recognize:

  struct foo {
      int stuff;
      struct boo array[];
  } QEMU_PACKED;

but does recognize:

  struct QEMU_PACKED foo {
      int stuff;
      struct boo array[];
  };

I'm not sure why, neither it is worth refactoring all QEMU
structures to use the attributes before the structure name,
so I did the 2nd patch manually.

Anyway this is annoying, because many structures are not handled
by coccinelle. Maybe this needs to be reported to upstream
coccinelle?

I used spatch 1.0.8 with:

  -I include --include-headers \
  --macro-file scripts/cocci-macro-file.h \
  --keep-comments --indent 4

Regards,

Phil.

Based-on: <20200304153311.22959-1-philmd@redhat.com>
Supersedes: <20200304005105.27454-1-philmd@redhat.com>

Philippe Mathieu-Daud=C3=A9 (2):
  misc: Replace zero-length arrays with flexible array member
    (automatic)
  misc: Replace zero-length arrays with flexible array member (manual)

 docs/interop/vhost-user.rst           |  4 ++--
 bsd-user/qemu.h                       |  2 +-
 contrib/libvhost-user/libvhost-user.h |  2 +-
 hw/m68k/bootinfo.h                    |  2 +-
 hw/scsi/srp.h                         |  6 +++---
 hw/xen/xen_pt.h                       |  2 +-
 include/hw/acpi/acpi-defs.h           | 16 ++++++++--------
 include/hw/arm/smmu-common.h          |  2 +-
 include/hw/boards.h                   |  2 +-
 include/hw/i386/intel_iommu.h         |  3 ++-
 include/hw/s390x/event-facility.h     |  2 +-
 include/hw/s390x/sclp.h               |  8 ++++----
 include/hw/virtio/virtio-iommu.h      |  2 +-
 include/sysemu/cryptodev.h            |  2 +-
 include/tcg/tcg.h                     |  2 +-
 pc-bios/s390-ccw/bootmap.h            |  2 +-
 pc-bios/s390-ccw/sclp.h               |  2 +-
 tests/qtest/libqos/ahci.h             |  2 +-
 block/linux-aio.c                     |  2 +-
 block/vmdk.c                          |  2 +-
 hw/acpi/nvdimm.c                      |  6 +++---
 hw/char/sclpconsole-lm.c              |  2 +-
 hw/char/sclpconsole.c                 |  2 +-
 hw/dma/soc_dma.c                      |  2 +-
 hw/i386/x86.c                         |  2 +-
 hw/misc/omap_l4.c                     |  2 +-
 hw/nvram/eeprom93xx.c                 |  2 +-
 hw/rdma/vmw/pvrdma_qp_ops.c           |  4 ++--
 hw/s390x/virtio-ccw.c                 |  2 +-
 hw/usb/dev-network.c                  |  2 +-
 hw/usb/dev-smartcard-reader.c         |  4 ++--
 hw/virtio/virtio.c                    |  4 ++--
 net/queue.c                           |  2 +-
 target/s390x/ioinst.c                 |  2 +-
 34 files changed, 53 insertions(+), 52 deletions(-)

--=20
2.21.1


