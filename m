Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2606C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 14:24:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4913E22248
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 14:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MDD0NTqD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4913E22248
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG11s-0000Zh-8O
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 10:24:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49816)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kG113-0007Na-Gw
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 10:24:05 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59565
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kG110-0004EQ-I3
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 10:24:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599661440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=RbsgY1PuWjvXwVEQA2MEsAwNUu7hAVi+9Ldr5F+teOk=;
 b=MDD0NTqD0h3mPjgYwSn/bdCJ7YS/aa3AIkNIAYLqKbz6WdUh6r/igTfZYVrwnlyQbEMBVv
 wfpvN6krj7VJbBUrwYxJ13q8qilR5PoHtImfs5nfhoFlGqkNMl2SPHiwFuNlVGtB2aVXlp
 YAAnVjv88Sxm80vIjX17H/Cx0Cc2rR0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-247-izzG2zPCOoW7n4dzatLczw-1; Wed, 09 Sep 2020 10:23:58 -0400
X-MC-Unique: izzG2zPCOoW7n4dzatLczw-1
Received: by mail-wr1-f70.google.com with SMTP id l15so1027192wro.10
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2020 07:23:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=RbsgY1PuWjvXwVEQA2MEsAwNUu7hAVi+9Ldr5F+teOk=;
 b=djx3HLG8d6BDI9a3GMSrCI45Gfrotki0t0fhTvElz53xAu4lJTPdDlF8JZJqGPnmtU
 +EYy22CugBl9MCJ7WPM68wz8xA94YWV+CWMBAMahXpJdjlkgFGk279kfDPmnnJzFWCmO
 d2DlNqQksurDyAseh8q/LQUmRK9RHi7/PNwpvXIH24cKFwQTouQ/gdb4eo3g/xRbau9l
 eutfkmmclNr/xChQ2q07hZqY+H3sQsg28yzh4b2zAynmWkfEK2ZaiFFf5isJ1CWe4and
 HnnWX2Pdx9oedofGJLCEeJJDyiQe305B5+o5c+X/4XG/V3vEV1tnSNYomlV8UpzorgjV
 jYbQ==
X-Gm-Message-State: AOAM530piurnglGMuQnZOdugGA4YI2hqGgCDQwsdInKT9WpxRsehH7fw
 Dv70Na3nrpvDIjSYPm3NghXEDCHXxlw9PFWR6DolcgRGLrGEEVs8Z+Ea03IOCkORYa7YzDhxsYH
 drjEWLGtMF7PcVqM=
X-Received: by 2002:a7b:c751:: with SMTP id w17mr3704275wmk.97.1599661436755; 
 Wed, 09 Sep 2020 07:23:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy7UFMK2XKbgo3+UfhmIyJ++uG6hVclo4HNEywvTmBlelNnXrv9lJ7iVTuJqm9tqzhzH8Vz/g==
X-Received: by 2002:a7b:c751:: with SMTP id w17mr3704250wmk.97.1599661436422; 
 Wed, 09 Sep 2020 07:23:56 -0700 (PDT)
Received: from x1w.redhat.com (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id 91sm5108312wrq.9.2020.09.09.07.23.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2020 07:23:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 0/4] util/vfio-helpers: Add support for multiple IRQs
Date: Wed,  9 Sep 2020 16:23:50 +0200
Message-Id: <20200909142354.334859-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 02:43:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Since RFC v5:
- addressed Fam review comment (return EINVAL)
- addressed Fam R-b tags
- no more RFC :)

Since RFC v4:
- addressed Alex review comment:
  check ioctl(VFIO_DEVICE_SET_IRQS) return value

Since RFC v3:
- addressed Alex and Stefan review comments

Since RFC v2:
- new patch to report vfio-helpers is not supported on AA64/POWER

(NVMe block driver series will follow).

Based-on: <20200908115322.325832-1-kwolf@redhat.com>
(Block layer pending pull request)

Philippe Mathieu-Daudé (4):
  util/vfio-helpers: Improve reporting unsupported IOMMU type
  util/vfio-helpers: Report error when IOMMU page size is not supported
  util/vfio-helpers: Introduce qemu_vfio_pci_init_msix_irqs()
  block/nvme: Use qemu_vfio_pci_init_msix_irqs() to initialize our IRQ

 include/qemu/vfio-helpers.h |  6 ++-
 block/nvme.c                |  9 +++-
 util/vfio-helpers.c         | 87 ++++++++++++++++++++++++++++++++++++-
 3 files changed, 97 insertions(+), 5 deletions(-)

-- 
2.26.2


