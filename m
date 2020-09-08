Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B73B1C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 18:04:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10256207DE
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 18:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dVlT3ovM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10256207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFhyu-00056Q-R3
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 14:04:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44088)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFhyC-0004EC-EQ
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 14:03:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26565
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFhyA-0004tI-A4
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 14:03:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599588228;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bvjRkE8EepsC88R1qJyFoVzd61YZqet4j0LfDVyDqW8=;
 b=dVlT3ovM+3aGjs6btkmE7B31Y4nyhiaxMWdDhS16+g2BIAXVqrLIP/ODWi9f+AdHP3Jft2
 EG/nBVH5FpuN3bZqNSy0t79FMNupD7cIcnY5mp4rwoRq2S72cDcnYn7PuJ01Z8HpXeVBFw
 lE8IwgXfzUJUah3W0Ox0/PShW2ru7gY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-gy_tySRBMUqUN_xdIu_6Fw-1; Tue, 08 Sep 2020 14:03:47 -0400
X-MC-Unique: gy_tySRBMUqUN_xdIu_6Fw-1
Received: by mail-wr1-f72.google.com with SMTP id l17so7186555wrw.11
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 11:03:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=bvjRkE8EepsC88R1qJyFoVzd61YZqet4j0LfDVyDqW8=;
 b=LiIF0nQFtVw/X/mwrwZMj9/NsfxNBmGC/3oatH1HaGXOG3YW0WaQdNfuoicyVVz8X+
 0URgJRJ/r9b7zL4/d3IIJnlqGpOUwjYrB/4NHysna6Fpp65o1vj6kCnRH0WWJNZeenRR
 gBzvopbBBEZeOBKg9ihi8mGZ0FlLzBfZnP3TCgWkf1kf46KdRA7yVbN1qNaYnwaqSoRJ
 cXNzche9XYzToTQq1/5bY4L/QjqVTRJ4LACazFzP04DH67bES9On/Lf7ZFafJDvUg7FA
 cWomTdjepIYlSuS/+oqjH9Lb+2kAls8vV/giT77fVtlF0S33V1Ev7mCf3+NdN3Zh++iV
 GxqQ==
X-Gm-Message-State: AOAM532U2igcKBIV+SUcGbjks4xBzXTenKAerOnO+wK/awWclrUNNmaz
 rotv14qQ2HPKXxejaMBhiDjgYcqD1cL85GQUogPEoFqBQsZXSxRjwgSbnVw4sM0xN70hIBb6+ny
 ADJ5f/jbO7hAxgOk=
X-Received: by 2002:a05:6000:151:: with SMTP id
 r17mr775524wrx.311.1599588225550; 
 Tue, 08 Sep 2020 11:03:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/6s0UIkXLC19f/7LfoZA6VR3XqZtZlq8SXOjky18nk7LcaOGSpEHkPdcu13tG3VcJG0dg6Q==
X-Received: by 2002:a05:6000:151:: with SMTP id
 r17mr775513wrx.311.1599588225357; 
 Tue, 08 Sep 2020 11:03:45 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id d13sm303933wrp.44.2020.09.08.11.03.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 11:03:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v5 0/4] util/vfio-helpers: Add support for multiple IRQs
Date: Tue,  8 Sep 2020 20:03:38 +0200
Message-Id: <20200908180342.280749-1-philmd@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 02:10:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


