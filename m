Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE647C11D04
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 13:08:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A641208C4
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 13:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A04WDmT7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A641208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4lZ3-0007y3-Rb
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 08:08:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55501)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j4lWm-00047N-8i
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 08:06:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j4lWk-0004i1-KT
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 08:06:04 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:56892
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j4lWk-0004hU-Al
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 08:06:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582203961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=gs0Sx5MSe2ZHpufIPviwETvw5yj3kxXeAW695lKR/TM=;
 b=A04WDmT7du6YAyESCnsSFaoBhgshBttIxV2o/ek3kFqyvmXf+qEKtR1Q3hX9baegTuUXCn
 dt4tkthCmcD6+X5rv5+5mAS0ljOOGhn10GW1R6Y4pOx5DsPMyAEpbAcTde439f4FNMzqtD
 dq6ShylSvvrF6GdZ9wSGN4vilJ5liyQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-lyz8ybnkPcyOrlJyzs-VuA-1; Thu, 20 Feb 2020 08:05:55 -0500
Received: by mail-wr1-f70.google.com with SMTP id s13so1703373wru.7
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 05:05:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=gu1OfO+Xr177r6zD7C+F/TxHFq6mosreIYv9UCpXME0=;
 b=M9SqMEUjkS/9N4K0GZ4f65VMn1tB/IjbA+l+Q6pL4P965bQb5yG4L8ck4MxJQKApR7
 IxNxEkifvv8ukHyqzznGR/DB0PDp0cnjbLx17jDMJqEOyenGbbc9AdeccH646h5mwi9P
 HQZUSE0KMm0U90j3vV0lMsB7+3YhZd4aOgNplSsb11T71YQu/npO2ihY+V9OiyvgfXnW
 lorvdDysD9NhAwfb6v4zihAA3vBdEu9pUEGDCDoBNSwho0YBbNd+tB11Tw7ueExGUAgw
 1ffdiOeOfz+goBK6XFOqdsYh3LpII/ZbFpX7so+CKs/bUsy9SkyVVmM8QjKGNd54fNrw
 lYcA==
X-Gm-Message-State: APjAAAX2P0D6cTUrmPDGgktf+vZvapYX21wXgxkS+inol0OWpyiAkCVg
 ml+AGt96iJnE6rZdl1q0ezNZW8pUlRI98MdSfXo8qhr7NWev7wWOx+8XA2Ulbk7s3Lmbvy8QwnJ
 gkjUMXXkQMPgNHmM=
X-Received: by 2002:a1c:f713:: with SMTP id v19mr4357699wmh.113.1582203953845; 
 Thu, 20 Feb 2020 05:05:53 -0800 (PST)
X-Google-Smtp-Source: APXvYqzh9hNepHCOwe2XDVm3wY3ajt8F8GOM+lVXRr3SymvEGFarpB4eXHypTAiBAMMl7y3VSmAESQ==
X-Received: by 2002:a1c:f713:: with SMTP id v19mr4357638wmh.113.1582203953503; 
 Thu, 20 Feb 2020 05:05:53 -0800 (PST)
Received: from localhost.localdomain (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id b67sm4594690wmc.38.2020.02.20.05.05.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2020 05:05:52 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 00/20] global exec/memory/dma APIs cleanup
Date: Thu, 20 Feb 2020 14:05:28 +0100
Message-Id: <20200220130548.29974-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-MC-Unique: lyz8ybnkPcyOrlJyzs-VuA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Fam Zheng <fam@euphon.net>, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-block@nongnu.org,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>, Paul Durrant <paul@xen.org>,
 Eric Auger <eric.auger@redhat.com>, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 John Snow <jsnow@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 Michael Walle <michael@walle.cc>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series is inspired from Peter Maydel cleanup patch:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg680625.html

- Convert 'is_write' argument to boolean
- Use void pointer for blob buffer
- Remove unnecessary casts (Stefan Weil)
- Replace [API]_rw() by [API]_read/write() when is_write is constant

Supersedes: <20200218112457.22712-1-peter.maydell@linaro.org>

Peter Maydell (1):
  Avoid address_space_rw() with a constant is_write argument

Philippe Mathieu-Daud=C3=A9 (19):
  scripts/git.orderfile: Display Cocci scripts before code modifications
  hw: Remove unnecessary cast when calling dma_memory_read()
  exec: Let qemu_ram_*() functions take a const pointer argument
  exec: Rename ram_ptr variable
  exec: Let flatview API take void pointer arguments
  exec: Let the address_space API use void pointer arguments
  hw/net: Avoid casting non-const pointer, use address_space_write()
  Remove unnecessary cast when using the address_space API
  exec: Let the cpu_[physical]_memory API use void pointer arguments
  Remove unnecessary cast when using the cpu_[physical]_memory API
  hw/ide/internal: Remove unused DMARestartFunc typedef
  hw/ide: Let the DMAIntFunc prototype use a boolean 'is_write' argument
  hw/virtio: Let virtqueue_map_iovec() use a boolean 'is_write' argument
  hw/virtio: Let vhost_memory_map() use a boolean 'is_write' argument
  exec: Let address_space_unmap() use a boolean 'is_write' argument
  Let address_space_rw() calls pass a boolean 'is_write' argument
  exec: Let cpu_[physical]_memory API use a boolean 'is_write' argument
  Let cpu_[physical]_memory() calls pass a boolean 'is_write' argument
  Avoid cpu_physical_memory_rw() with a constant is_write argument

 scripts/coccinelle/exec_rw_const.cocci | 103 +++++++++++++++++++++++++
 include/exec/cpu-all.h                 |   2 +-
 include/exec/cpu-common.h              |  18 ++---
 include/exec/memory.h                  |  16 ++--
 include/hw/ide/internal.h              |   3 +-
 include/sysemu/xen-mapcache.h          |   4 +-
 target/i386/hvf/vmx.h                  |   7 +-
 accel/kvm/kvm-all.c                    |   6 +-
 dma-helpers.c                          |   4 +-
 exec.c                                 |  75 +++++++++---------
 hw/arm/boot.c                          |   6 +-
 hw/arm/smmu-common.c                   |   3 +-
 hw/arm/smmuv3.c                        |  10 +--
 hw/display/exynos4210_fimd.c           |   3 +-
 hw/display/milkymist-tmu2.c            |   8 +-
 hw/display/omap_dss.c                  |   2 +-
 hw/display/omap_lcdc.c                 |  10 +--
 hw/display/ramfb.c                     |   2 +-
 hw/dma/etraxfs_dma.c                   |  25 +++---
 hw/dma/rc4030.c                        |  10 +--
 hw/dma/xlnx-zdma.c                     |  11 +--
 hw/i386/xen/xen-mapcache.c             |   2 +-
 hw/ide/ahci.c                          |   2 +-
 hw/ide/core.c                          |   2 +-
 hw/ide/macio.c                         |   2 +-
 hw/ide/pci.c                           |   2 +-
 hw/misc/pc-testdev.c                   |   2 +-
 hw/net/cadence_gem.c                   |  21 +++--
 hw/net/dp8393x.c                       |  70 +++++++++--------
 hw/net/i82596.c                        |  25 +++---
 hw/net/lasi_i82596.c                   |   5 +-
 hw/nvram/spapr_nvram.c                 |   4 +-
 hw/ppc/pnv_lpc.c                       |   8 +-
 hw/ppc/ppc440_uc.c                     |   6 +-
 hw/ppc/spapr_hcall.c                   |   4 +-
 hw/s390x/css.c                         |  12 +--
 hw/s390x/ipl.c                         |   2 +-
 hw/s390x/s390-pci-bus.c                |   2 +-
 hw/s390x/virtio-ccw.c                  |   2 +-
 hw/scsi/vmw_pvscsi.c                   |   8 +-
 hw/sd/sdhci.c                          |  15 ++--
 hw/virtio/vhost.c                      |   8 +-
 hw/virtio/virtio.c                     |   7 +-
 hw/xen/xen_pt_graphics.c               |   2 +-
 qtest.c                                |  52 ++++++-------
 target/i386/hax-all.c                  |   6 +-
 target/i386/hvf/x86_mmu.c              |  12 +--
 target/i386/whpx-all.c                 |   2 +-
 target/s390x/excp_helper.c             |   2 +-
 target/s390x/helper.c                  |   6 +-
 target/s390x/mmu_helper.c              |   2 +-
 scripts/git.orderfile                  |   3 +
 52 files changed, 360 insertions(+), 266 deletions(-)
 create mode 100644 scripts/coccinelle/exec_rw_const.cocci

--=20
2.21.1


