Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 910DEC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 14:18:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62BD722B40
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 14:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SNGgyQip"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62BD722B40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2xli-0002V7-Ko
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 10:18:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44432)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k2xkc-0001jJ-LY
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 10:17:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47595
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k2xkX-00057W-4X
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 10:17:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596550623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=4LKoN0NyOZAxcuTXyjWRMmHd8kIxcyJtt49Ygg7tYnA=;
 b=SNGgyQip/zzTdMt09T5CXyPj+H5VD4zWslxkHT6LpM+PPyULR6Md/W/a4PRv+tczaz5Gzl
 clym7OJJDY9MYeUQLWE8WEGIGuEas7yFwsICCWtaCx8u+PCNp9fwCps0Ug6UEEGDz1BBP9
 C6HdJ0YhS9v5usH8joP4FsLXawoa4HM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-l9Ui0_HqOMu2ptJysS4hxA-1; Tue, 04 Aug 2020 10:17:02 -0400
X-MC-Unique: l9Ui0_HqOMu2ptJysS4hxA-1
Received: by mail-qv1-f69.google.com with SMTP id h6so6787130qvz.14
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2020 07:17:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=4LKoN0NyOZAxcuTXyjWRMmHd8kIxcyJtt49Ygg7tYnA=;
 b=olY0qzJhxNH/DG22Y2rbRqgxJzQ7YQixnKQe7LyFvZoH6t2AQvVASiKNS0GJf5EP0B
 lLemKwoI4bm1Se60O8VOZUTJZe6KFvMb9J0UEj5WhoXL0KHzvF8g8o0k44AO1UGRW4L4
 gl/qrtVdl7iXZSBGbnEzHydKwmmlL5hiuRBBB3W0Zz7l4nXfgsZRCSdcY2+XXSGzrAP7
 /kpGKwWAmeUsfzObyJeiCyAkyKxyjWrfhSKk9YOpFVWvFxw2oq913jzHDNibAdKIkt+R
 zRKYqnEvuHx3oSbwO3X+Uh4g84pt2qjc+TCECS47/Cie57edUufqRJAWwPKdQX78KWha
 kRog==
X-Gm-Message-State: AOAM53127stsMAaCkKKIZ1wy2e4gWdo8EDjbV3xKMdD7x7A+6OtKMdK+
 oTOTergHf09zy5aZKKaybu710Q00D9b3qhQHzd4bDmm4Tbw0IbsXcxTXiFLo+CbRj4jZ+BIOWks
 qlbMkX62mOBjkVDg=
X-Received: by 2002:a05:620a:4006:: with SMTP id
 h6mr10852332qko.174.1596550621179; 
 Tue, 04 Aug 2020 07:17:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxVr/4iXaDbNAP33FoaeLByL7qWAowWX3ztaFqQP1u7F+UdgPqtmzh8T0r8+BkURxnA2+P/bg==
X-Received: by 2002:a05:620a:4006:: with SMTP id
 h6mr10852309qko.174.1596550620901; 
 Tue, 04 Aug 2020 07:17:00 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net.
 [79.177.102.128])
 by smtp.gmail.com with ESMTPSA id i18sm23691483qtv.39.2020.08.04.07.16.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2020 07:17:00 -0700 (PDT)
Date: Tue, 4 Aug 2020 10:16:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/3] virtio,acpi: bugfixes
Message-ID: <20200804141640.591031-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 01:28:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 5c1c3e4f02e458cf280c677c817ae4fd1ed9bf10:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200803' into staging (2020-08-03 20:34:26 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 5957b49b423fe456896e10f7e4a6c69be07f9407:

  virtio-mem: Correct format specifier mismatch for RISC-V (2020-08-04 09:13:34 -0400)

----------------------------------------------------------------
virtio,acpi: bugfixes

A couple of last minute bugfixes.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Bruce Rogers (1):
      virtio-mem: Correct format specifier mismatch for RISC-V

Michael S. Tsirkin (2):
      i386/acpi: fix inconsistent QEMU/OVMF device paths
      arm/acpi: fix an out of spec _UID for PCI root

 hw/arm/virt-acpi-build.c | 2 +-
 hw/i386/acpi-build.c     | 4 ++--
 hw/virtio/virtio-mem.c   | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)


