Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17757C6379D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 10:58:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90C012225C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 10:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i2CBHo+x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90C012225C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX0Cy-0002aG-CC
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 06:58:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50648)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kX09l-0006ra-Ds
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:55:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26833)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kX09i-0007vc-6A
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:55:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603709712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=rHqzz119/JBAYae2xS1pvE7dXekxnB1Mkl9t7p2TKWk=;
 b=i2CBHo+xRc9Czifv8UiVY/wgJqjTdqEvuDr56qnIatQRkaiI4v8iIkSc1psX19GriL7ieC
 2YOUPiy5Md0597cjaYOX3HxOFzbuR2CmIxDlCCM5VDlbKoeahoYHg4DZa5VKtdZVIZwF8n
 VqLjR85tongizyFUvWU+mHFYHhAXjvI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-vlACBLvVNiCMdNF-8PfOAw-1; Mon, 26 Oct 2020 06:55:11 -0400
X-MC-Unique: vlACBLvVNiCMdNF-8PfOAw-1
Received: by mail-wr1-f72.google.com with SMTP id m20so8187617wrb.21
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 03:55:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=rHqzz119/JBAYae2xS1pvE7dXekxnB1Mkl9t7p2TKWk=;
 b=hYMNxPmsGojkLyazaFTgUD6Yz4b6MyeawpINfVMCi2TmIWf8lTFsoPCuP6HqayFHV6
 TDomu3WOClJhhT1ZUgCCRyLB12UfiD1hzRe7gvbByNsVN4DzivGeWXiSSbT/4/lgKEc/
 r+tDdsGW9t23lJbE2rO1pwmfiZGA2DfReg4+zYYVHkHJVszHhUjX8r//acRyzM24OTjw
 VcDZYboAIY3doHeU+CPCRCV0L8Eygu3op6W7yna6/+8dj+JZqROc4Rh370n12PB9o8FI
 z3SV/1D3hwVJFS/hRXSuCHwhhZrfByiT85dzoFdPgCVOrf6VHLWjuo+Rq34132wk9na/
 Nlmg==
X-Gm-Message-State: AOAM532wrYIkWcOr80szpiyc1LrclHfznZicWnwkK0fLbPT4+00iEBVb
 KbzXANsIiW63PZatFGc6Y9T2caDCGPTGD/cS4Z2Zt8w+udnlSFXGhH2QRIAe/6HCicagldAlBoU
 LXIIuJrHTyAy9aWo=
X-Received: by 2002:a7b:cf04:: with SMTP id l4mr16613033wmg.137.1603709706961; 
 Mon, 26 Oct 2020 03:55:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzg2nJm1sTqCZx8mU1zOOGJ96fD9e895iq03UArhgMV3BsGZXrsBPMgD3SevW5d2w9EE4LRNA==
X-Received: by 2002:a7b:cf04:: with SMTP id l4mr16613005wmg.137.1603709706768; 
 Mon, 26 Oct 2020 03:55:06 -0700 (PDT)
Received: from localhost.localdomain (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id y2sm23213587wrh.0.2020.10.26.03.55.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2020 03:55:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 00/19] util/vfio-helpers: Allow using multiple MSIX IRQs
Date: Mon, 26 Oct 2020 11:54:45 +0100
Message-Id: <20201026105504.4023620-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:39:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series allow using multiple MSIX IRQs=0D
We currently share a single IRQ between 2 NVMe queues=0D
(ADMIN and I/O). This series still uses 1 shared IRQ=0D
but prepare for using multiple ones.=0D
=0D
Since v1:=0D
- Addressed Stefan comment in patch #14=0D
  "Pass minimum page size to qemu_vfio_open_pci"=0D
  (check the page size is in range with device)=0D
- To reduce (and simplify) changes in patch #14, added=0D
  new patch #2 "Introduce device/iommu 'page_size_min' variables"=0D
- Added "Trace controller capabilities" useful to test the=0D
  previous changes=0D
- "Set request_alignment at initialization" reported by Stefan=0D
  (and tested by Eric off-list).=0D
=0D
Missing review: 2,3,4,14=0D
=0D
$ git backport-diff -u v1=0D
Key:=0D
[----] : patches are identical=0D
[####] : number of functional differences between upstream/downstream patch=
=0D
[down] : patch is downstream-only=0D
The flags [FC] indicate (F)unctional and (C)ontextual differences, respecti=
ve=3D=0D
ly=0D
=0D
001/19:[----] [--] 'block/nvme: Correct minimum device page size'=0D
002/19:[down] 'block/nvme: Set request_alignment at initialization'=0D
003/19:[down] 'block/nvme: Introduce device/iommu 'page_size_min' variables=
'=0D
004/19:[down] 'block/nvme: Trace controller capabilities'=0D
005/19:[----] [--] 'util/vfio-helpers: Improve reporting unsupported IOMMU =
ty=3D=0D
pe'=0D
006/19:[----] [-C] 'util/vfio-helpers: Trace PCI I/O config accesses'=0D
007/19:[----] [-C] 'util/vfio-helpers: Trace PCI BAR region info'=0D
008/19:[----] [-C] 'util/vfio-helpers: Trace where BARs are mapped'=0D
009/19:[----] [-C] 'util/vfio-helpers: Improve DMA trace events'=0D
010/19:[----] [-C] 'util/vfio-helpers: Convert vfio_dump_mapping to trace e=
ve=3D=0D
nts'=0D
011/19:[----] [-C] 'util/vfio-helpers: Let qemu_vfio_dma_map() propagate Er=
ro=3D=0D
r'=0D
012/19:[----] [--] 'util/vfio-helpers: Let qemu_vfio_do_mapping() propagate=
 E=3D=0D
rror'=0D
013/19:[----] [--] 'util/vfio-helpers: Let qemu_vfio_verify_mappings() use =
er=3D=0D
ror_report()'=0D
014/19:[0017] [FC] 'util/vfio-helpers: Pass minimum page size to qemu_vfio_=
op=3D=0D
en_pci()'=0D
015/19:[----] [-C] 'util/vfio-helpers: Report error when IOMMU page size is=
 n=3D=0D
ot supported'=0D
016/19:[----] [--] 'util/vfio-helpers: Introduce qemu_vfio_pci_msix_init_ir=
qs=3D=0D
()'=0D
017/19:[----] [--] 'util/vfio-helpers: Introduce qemu_vfio_pci_msix_set_irq=
()'=0D
018/19:[----] [-C] 'block/nvme: Switch to using the MSIX API'=0D
019/19:[----] [--] 'util/vfio-helpers: Remove now unused qemu_vfio_pci_init=
_i=3D=0D
rq()'=0D
=0D
Philippe Mathieu-Daud=3DC3=3DA9 (19):=0D
  block/nvme: Correct minimum device page size=0D
  block/nvme: Set request_alignment at initialization=0D
  block/nvme: Introduce device/iommu 'page_size_min' variables=0D
  block/nvme: Trace controller capabilities=0D
  util/vfio-helpers: Improve reporting unsupported IOMMU type=0D
  util/vfio-helpers: Trace PCI I/O config accesses=0D
  util/vfio-helpers: Trace PCI BAR region info=0D
  util/vfio-helpers: Trace where BARs are mapped=0D
  util/vfio-helpers: Improve DMA trace events=0D
  util/vfio-helpers: Convert vfio_dump_mapping to trace events=0D
  util/vfio-helpers: Let qemu_vfio_dma_map() propagate Error=0D
  util/vfio-helpers: Let qemu_vfio_do_mapping() propagate Error=0D
  util/vfio-helpers: Let qemu_vfio_verify_mappings() use error_report()=0D
  util/vfio-helpers: Pass minimum page size to qemu_vfio_open_pci()=0D
  util/vfio-helpers: Report error when IOMMU page size is not supported=0D
  util/vfio-helpers: Introduce qemu_vfio_pci_msix_init_irqs()=0D
  util/vfio-helpers: Introduce qemu_vfio_pci_msix_set_irq()=0D
  block/nvme: Switch to using the MSIX API=0D
  util/vfio-helpers: Remove now unused qemu_vfio_pci_init_irq()=0D
=0D
 include/qemu/vfio-helpers.h |  15 ++-=0D
 block/nvme.c                |  58 +++++++++---=0D
 util/vfio-helpers.c         | 183 +++++++++++++++++++++++++++---------=0D
 block/trace-events          |   1 +=0D
 util/trace-events           |  13 ++-=0D
 5 files changed, 208 insertions(+), 62 deletions(-)=0D
=0D
--=3D20=0D
2.26.2=0D
=0D


