Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF34C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 16:06:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DBC82078D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 16:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HKrLR1lL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DBC82078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8Qc0-00071s-SO
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 12:06:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45812)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k8QYj-0003BO-CL
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 12:03:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20940
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k8QYh-0005q4-7z
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 12:03:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597853006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=j8paKn5+FGfPmL9WoDSF+jo5RSGcv6FYxTXhO0jxguQ=;
 b=HKrLR1lL6bb+ud0yDtleEXH0UFKOwdNbi5OEavIvoE2x5XoKSlVoCbjX8A5a17E9IKxD4D
 ksV2vCAbOH6GhZdmlRM9i6Z6ARmBsUxM3kkbj5hAU6i2e/PFVuaj7sLC03eOzW3DwV8z9f
 eE6GhYR2bgq04lN1u/BHfL7NCLbhqPg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-04NfCxAVP2SeCugsMfYNbQ-1; Wed, 19 Aug 2020 12:03:23 -0400
X-MC-Unique: 04NfCxAVP2SeCugsMfYNbQ-1
Received: by mail-wr1-f69.google.com with SMTP id f14so9456724wrm.22
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2020 09:03:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=j8paKn5+FGfPmL9WoDSF+jo5RSGcv6FYxTXhO0jxguQ=;
 b=Df1yR7b7YGxZhmNOS8ocFyUzIg8ji8DLDfijK2/2sOZ/COe09jPNMdEr2PoWSmdCyy
 EFwmMkjgtN+ssOMN7GGQyPBc+yI8UdAexuBRbKQMb7wGN4O8kddO05mbZLFNyMH30s9d
 4YHlxEqaNxfIN6gKWxhIMuZopzRBAsROozqJRpVedm2F02HTZTAScvDeFQC6ZlaQHE3a
 NX2CKYnV+UHUKuZiHMBOLuR0FTxJxbF5bEcjZwxtwCDBoHrrNm/mD32zkxcP/pB6b4et
 H7G1gCdhgqGjTgtOBavXWutQI9M7r5OqS69d38PDfNFxAb307dqn4w8n6ftZMc0J3WXd
 PY0A==
X-Gm-Message-State: AOAM532o3CTzuIbETLQ2dz95/s8kqY87oMTNvjZfNVvyflViqoehBdUp
 4e3RBGSpyzegYo1sNdGHm5+nc7cBm9t1b/xQSTDRLhAtGFYuObTet795kd4kaprh6Z9sw4sntpz
 ZJuxYyjFc8IyCc3E=
X-Received: by 2002:a1c:4e10:: with SMTP id g16mr5198794wmh.146.1597853001674; 
 Wed, 19 Aug 2020 09:03:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyf2ene58d0cZaIEfOp+P0hqivQfR0ZUSbpxrQskQ6E/dor/rziOqrsUtBifxqt6WsnOQFfHA==
X-Received: by 2002:a1c:4e10:: with SMTP id g16mr5198770wmh.146.1597853001376; 
 Wed, 19 Aug 2020 09:03:21 -0700 (PDT)
Received: from x1w.redhat.com (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id 8sm42887219wrl.7.2020.08.19.09.03.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2020 09:03:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v4 0/5] util/vfio-helpers: Add support for multiple IRQs
Date: Wed, 19 Aug 2020 18:03:13 +0200
Message-Id: <20200819160318.835292-1-philmd@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 23:05:17
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
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

Since RFC v3:
- addressed Alex and Stefan review comments

Since RFC v2:
- new patch to report vfio-helpers is not supported on AA64/POWER

(NVMe block driver series will follow).

Based-on: <20200812185014.18267-1-philmd@redhat.com>
"block/nvme: Various cleanups required to use multiple queues"
https://www.mail-archive.com/qemu-devel@nongnu.org/msg729395.html

Philippe Mathieu-Daudé (5):
  block/nvme: Use an array of EventNotifier
  util/vfio-helpers: Improve reporting unsupported IOMMU type
  util/vfio-helpers: Report error when IOMMU page size is not supported
  util/vfio-helpers: Introduce qemu_vfio_pci_init_msix_irqs()
  block/nvme: Use qemu_vfio_pci_init_msix_irqs() to initialize our IRQ

 include/qemu/vfio-helpers.h |  2 +
 block/nvme.c                | 38 ++++++++++++------
 util/vfio-helpers.c         | 79 ++++++++++++++++++++++++++++++++++++-
 3 files changed, 107 insertions(+), 12 deletions(-)

-- 
2.26.2


