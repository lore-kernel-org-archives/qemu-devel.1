Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172FAC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 17:26:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A4B82222D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 17:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NvdhRMGt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A4B82222D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUvP1-0007wl-7w
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 13:26:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34484)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUvNF-00062N-OX
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 13:24:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45721)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUvND-0007sg-Os
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 13:24:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603214674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+WaSTZpM2AkAytNV14cvRXJ+IpFUTCA6TjZk5wGvnoE=;
 b=NvdhRMGtzGOZC0SUWyVHbXf0Lkr5B1yTd2unZ3PAw3Y1iuJ0ZmTLNmgRMDFtHh9umWfcgi
 yQy+vl6D5vUob3XRQcDdC3Uo3uWpfE4xsgyV9vbrNxzYEU0tEbAE2MWKPGxOdGrLg9NSfQ
 mTno/yZVc0CWgfTxKemLpwuJDedYEyo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-mxWSSj9FNraURztf6Lvciw-1; Tue, 20 Oct 2020 13:24:32 -0400
X-MC-Unique: mxWSSj9FNraURztf6Lvciw-1
Received: by mail-wm1-f71.google.com with SMTP id l22so627917wmi.4
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 10:24:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=2Uv83TbQivMfO6GzVmVXFpynVITASprGNQTSB8ruzGo=;
 b=qU364IOS0LvVkcDVtVYlb+2bTccB3iUT1PDliL3KcPoOQNUKUOmvzAB9LIEZGHwtin
 AikEljPRwqXqX0MSMdHc4LRPLLqaTXYnmzGvpNjZKXAyXKNrTGh6LAtIgb0y4RjMuYKS
 EIADrO6Z2CUhfW0+djAnVeW4yygoZgAqz2V1+DYxGcB/8Sf8JbpyULVzhVuef/LcOxbw
 9gx/T4ttXclz/3RRWQF/Ni7XEbuRppy7Joth3bfhX5P97PHfyhcHI75Y8AVPmJ+ORxsu
 A9EHuHOUKdIBbhL3UxF9r/nncAx6LVBarkEEiReHtxI7mpFjWO3/V953yDf/puq3xoYu
 WqOg==
X-Gm-Message-State: AOAM533f6e1SYm0Fcw6GXa6Xx9XREBUERwRKvbkzxYOrM+7y5z0CU+FL
 Xjbbh9cYFm9NiPk4Vl6eaYh2SIQFXUxWuSu332yzq2gUKqBPlEuCFBtCqzkI3rDJv0hsgoopdym
 Fj3oWny5z3ooPOsQ=
X-Received: by 2002:adf:e744:: with SMTP id c4mr4670000wrn.222.1603214670926; 
 Tue, 20 Oct 2020 10:24:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJziQO7S6UHMBor6W1nTR2XVINpxxv+Du4syiiFrDonoJXm/roQOzdW3dgf9DNdVNuQdkODmlw==
X-Received: by 2002:adf:e744:: with SMTP id c4mr4669968wrn.222.1603214670664; 
 Tue, 20 Oct 2020 10:24:30 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id y7sm3576729wmg.40.2020.10.20.10.24.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 10:24:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/16] util/vfio-helpers: Allow using multiple MSIX IRQs
Date: Tue, 20 Oct 2020 19:24:12 +0200
Message-Id: <20201020172428.2220726-1-philmd@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:16:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
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
The series is organized as:=0D
- Fix device minimum page size (prerequisite: patch 1)=0D
- Check IOMMU minimum page size (patches 3, 4)=0D
- Boring cleanups already reviewed (patches 2, 5-12)=0D
- Introduce helpers to use multiple MSIX (patches 13, 14)=0D
- Switch NVMe block driver to use the multiple MSIX API (15)=0D
- Remove single MSIX helper (16).=0D
=0D
Most patches are trivial, except 13 and 14 which are the=0D
important VFIO ones.=0D
=0D
Please review,=0D
=0D
Phil.=0D
=0D
Philippe Mathieu-Daud=C3=A9 (16):=0D
  block/nvme: Correct minimum device page size=0D
  util/vfio-helpers: Improve reporting unsupported IOMMU type=0D
  util/vfio-helpers: Pass minimum page size to qemu_vfio_open_pci()=0D
  util/vfio-helpers: Report error when IOMMU page size is not supported=0D
  util/vfio-helpers: Trace PCI I/O config accesses=0D
  util/vfio-helpers: Trace PCI BAR region info=0D
  util/vfio-helpers: Trace where BARs are mapped=0D
  util/vfio-helpers: Improve DMA trace events=0D
  util/vfio-helpers: Convert vfio_dump_mapping to trace events=0D
  util/vfio-helpers: Let qemu_vfio_dma_map() propagate Error=0D
  util/vfio-helpers: Let qemu_vfio_do_mapping() propagate Error=0D
  util/vfio-helpers: Let qemu_vfio_verify_mappings() use error_report()=0D
  util/vfio-helpers: Introduce qemu_vfio_pci_msix_init_irqs()=0D
  util/vfio-helpers: Introduce qemu_vfio_pci_msix_set_irq()=0D
  block/nvme: Switch to using the MSIX API=0D
  util/vfio-helpers: Remove now unused qemu_vfio_pci_init_irq()=0D
=0D
 include/qemu/vfio-helpers.h |  15 ++-=0D
 block/nvme.c                |  33 ++++---=0D
 util/vfio-helpers.c         | 183 +++++++++++++++++++++++++++---------=0D
 util/trace-events           |  13 ++-=0D
 4 files changed, 182 insertions(+), 62 deletions(-)=0D
=0D
--=20=0D
2.26.2=0D
=0D


