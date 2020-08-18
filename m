Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB6A9C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 16:46:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98896206B5
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 16:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z9KM/iGh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98896206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k84km-0000lI-NR
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 12:46:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k84jg-0007Y3-E4
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 12:45:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35521
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k84jd-00078R-BQ
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 12:45:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597769115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ABJDVW/80NKKKVLkDU06FDgDnI83sQgRUw7McX8yHO4=;
 b=Z9KM/iGh8Y7Gvq3RqHPB3j0185Zt5zo84o9o99YMA2DH5SBQ8rRyR++6yjhbl0ekizach0
 rNSd+2DS8N3n3K+TJogx9DbiuMah8yttQ3SWIkuZ6NyDD+sN5r1nfFTak76WFiXWm8qRq3
 QH2XkdyzLCo+5My5e7Rf9ZwPXYXWWJc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-W_r-KA19PCaryMe446Ichw-1; Tue, 18 Aug 2020 12:45:13 -0400
X-MC-Unique: W_r-KA19PCaryMe446Ichw-1
Received: by mail-wr1-f69.google.com with SMTP id k11so8442321wrv.1
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 09:45:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ABJDVW/80NKKKVLkDU06FDgDnI83sQgRUw7McX8yHO4=;
 b=Vx5P4v+bW5Gg1Wb92A5l2ojeuQWSh++kB6wWDdUdubAnvaZKKPbrZLvpuDnM1jzT8G
 lb74n1CIX1jCiDaIBCeqsHagQ0YvrI+SK7vZc/JR6s8V1cIwtK2/2fSng+HbtPHYQGVb
 CsHZXSSgxr3mZ/jEY5F/p+OrxBiTVVpMd4K1eTQhfOIlhPepUds56WM2KouE/s8+MOhm
 dxwta43e+39k/BxyWWrO6/Rre7OQgiEkKxn/C1TQ86DZ7ZdULd4MORXbQPUZ5QTQNzkl
 tWC1PBUQdJ1FV1sKgGDIdl+sLSnbJIpJkpibaoQKAmCmih0Imo35x3pfZZimg3rzRm2T
 qKUg==
X-Gm-Message-State: AOAM531YMNPS3cXIfforNjVf3ide2UjCdqTEwdsCdu+mKcKnfMxsajVB
 fjI9eH43y+5yrjqmXMvPlX8Ns3JDxb6G4nicrDIdqDokx9WbdMSlquUIygNEDHe7bLaJ0jhJDOo
 pX1kTnylBtJKkTKE=
X-Received: by 2002:a1c:df02:: with SMTP id w2mr786938wmg.137.1597769111923;
 Tue, 18 Aug 2020 09:45:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyre62Bs1AtKrPAyzBFHtBaqsgAxUXxfkB5ZZMJ9tnjc6XRV6B5NMTd+DaJnbcenEeSvZjQZA==
X-Received: by 2002:a1c:df02:: with SMTP id w2mr786909wmg.137.1597769111630;
 Tue, 18 Aug 2020 09:45:11 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id q19sm36781143wrf.48.2020.08.18.09.45.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2020 09:45:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v3 0/5] util/vfio-helpers: Add support for multiple IRQs
Date: Tue, 18 Aug 2020 18:45:04 +0200
Message-Id: <20200818164509.736367-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 03:19:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series intends to setup the VFIO helper to allow
binding notifiers on different IRQs.

For the NVMe use case, we only care about MSIX interrupts.
To not disrupt other users, introduce the qemu_vfio_pci_init_msix_irqs
function to initialize multiple MSIX IRQs and attach eventfd to
them.

Since RFC v2:
- new patch to report vfio-helpers is not supported on AA64/POWER

(NVMe block driver series will follow).

Based-on: <20200812185014.18267-1-philmd@redhat.com>
"block/nvme: Various cleanups required to use multiple queues"
https://www.mail-archive.com/qemu-devel@nongnu.org/msg729395.html

Philippe Mathieu-Daudé (5):
  block/nvme: Use an array of EventNotifier
  util/vfio-helpers: Report error on unsupported host architectures
  util/vfio-helpers: Store eventfd using int32_t type
  util/vfio-helpers: Introduce qemu_vfio_pci_init_msix_irqs()
  block/nvme: Use qemu_vfio_pci_init_msix_irqs() to initialize our IRQ

 include/qemu/vfio-helpers.h |  2 +
 block/nvme.c                | 30 +++++++++-----
 util/vfio-helpers.c         | 83 +++++++++++++++++++++++++++++++++++--
 3 files changed, 101 insertions(+), 14 deletions(-)

-- 
2.26.2


