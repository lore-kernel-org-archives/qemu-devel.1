Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C007EC4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 15:25:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3591A20E65
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 15:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cLdyKh8m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3591A20E65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVywY-0000DZ-5b
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 11:25:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57262)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kVyqr-000106-82
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:19:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51688)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kVyqo-00008q-J6
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:19:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603466369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mS4cNoZCpTcj12a4mxTiyf+hXPKCC57MGOqx5knq2Pg=;
 b=cLdyKh8mn2xbQJR3cKxQ9dqRYfOihrityt0QyM7Pi3WSXqAuhUnCAw+IlxyupfZmuBvCxJ
 Q5lKnEg4T/q+huz88Vk9fuVzChOdZFPnXlueuiIoSvg/z+8HEU50KuSnA22XzqtlOXSckT
 j1tz7gonzP4M1gE+bK47OPwdrGiE3TM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-NFEx9ZOJP9ePhX2QAgXxvw-1; Fri, 23 Oct 2020 11:19:26 -0400
X-MC-Unique: NFEx9ZOJP9ePhX2QAgXxvw-1
Received: by mail-wm1-f71.google.com with SMTP id l16so224974wmh.1
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2020 08:19:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YpzeiY8zxMqvW9+k4iVJTdBSjs/Hepn9DCBDQ9Z3cI0=;
 b=iVgnAL3ji0BXr2qVaP1DTM0rVIvGuqLvsGKGU6z3Qbcu6Br5bJpKfUIGg8qbjicUkB
 ADM1cMTM3v0RYZytFm/iohLWDMxg25iH7IDNsNm66D9QPJKsSzPYom82scL2ciBjfMKw
 HLW2uNSd/xdVeAX8ZwoH/4n/Od/5myc8ZLK7SO9Cmx+0F+vwSoQNPIMMYlbILK1TMRGn
 1I/+Ss5cWI3r4d4K+vAOgyDxFqRlgdP2iXjhfWXPrLs6frmCAxfv+Xi3n34W0iVUri0D
 oRmZ+9kvpcfB1kixJ5Vbad1bBYOPa05ZrEHSjo7z/Jn1Ubaur7V7GbJagefozR9B14bs
 Hzbg==
X-Gm-Message-State: AOAM531hDngp3Mp9+mrf0RGS0pWIYGzNnv2CzfRiG2R2C1J5GJvKhrp3
 OvX/fylDF0UjLJnRzaxQl+py+eg521adVh1sDS7wBhrOAzRNPwqd0UU5BsfHSUZNODxMp69ddHe
 SjVusAXLLQ0rk5ms=
X-Received: by 2002:a1c:dd05:: with SMTP id u5mr2976169wmg.56.1603466365328;
 Fri, 23 Oct 2020 08:19:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxqoupkUJFgbPnXMbDIT8BN5gbBJEb90XDEKPHgE4yvBTi+rVA6bp5BYNrOvHvWmc8lhEqcoA==
X-Received: by 2002:a1c:dd05:: with SMTP id u5mr2976148wmg.56.1603466365147;
 Fri, 23 Oct 2020 08:19:25 -0700 (PDT)
Received: from localhost.localdomain (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id t19sm4468948wmi.26.2020.10.23.08.19.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2020 08:19:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND v3 00/10] hw: Let DMA/PCI API propagate MemTxResult
Date: Fri, 23 Oct 2020 17:19:13 +0200
Message-Id: <20201023151923.3243652-1-philmd@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 01:44:00
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently the MemTxResult return value is not propagated,=0D
so lost. The motivation behind this series is to make the=0D
API more robust to enforce correct use by the consumers.=0D
=0D
All series reviewed.=0D
=0D
Since v2:=0D
- Rebased=0D
- Removed patches adding MemTxAttrs argument to DMA/PCI API=0D
  (we will discuss them later).=0D
=0D
v2:=0D
https://www.mail-archive.com/qemu-devel@nongnu.org/msg746761.html=0D
=0D
The DMA API propagates MemTxResult:=0D
- MEMTX_OK,=0D
- MEMTX_device_ERROR,=0D
- MEMTX_DECODE_ERROR.=0D
=0D
Let the PCI DMA API propagate them, as they are=0D
clearer than an undocumented 'int'.=0D
=0D
Supersedes: <20201001172519.1620782-1-philmd@redhat.com>=0D
=0D
Klaus Jensen (1):=0D
  pci: pass along the return value of dma_memory_rw=0D
=0D
Philippe Mathieu-Daud=C3=A9 (9):=0D
  docs/devel/loads-stores: Add regexp for DMA functions=0D
  dma: Document address_space_map/address_space_unmap() prototypes=0D
  dma: Let dma_memory_set() propagate MemTxResult=0D
  dma: Let dma_memory_rw() propagate MemTxResult=0D
  dma: Let dma_memory_read() propagate MemTxResult=0D
  dma: Let dma_memory_write() propagate MemTxResult=0D
  pci: Let pci_dma_rw() propagate MemTxResult=0D
  pci: Let pci_dma_read() propagate MemTxResult=0D
  pci: Let pci_dma_write() propagate MemTxResult=0D
=0D
 docs/devel/loads-stores.rst |   2 +=0D
 include/hw/pci/pci.h        |  53 +++++++++++++---=0D
 include/sysemu/dma.h        | 117 ++++++++++++++++++++++++++++++------=0D
 softmmu/dma-helpers.c       |   7 ++-=0D
 4 files changed, 150 insertions(+), 29 deletions(-)=0D
=0D
--=20=0D
2.26.2=0D
=0D


