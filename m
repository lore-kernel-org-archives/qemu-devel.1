Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F11C47420
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 08:38:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B727A206B7
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 08:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QiRlOfaU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B727A206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNXcw-00076R-QG
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 04:38:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51300)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kNXbK-0005qW-Oa
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 04:36:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60518)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kNXbI-0007W7-5m
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 04:36:38 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601454994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=kuMXAtvGN/B005vXkmMonSfaYsnH+UQ7+m+9MndOMZM=;
 b=QiRlOfaUM8qj6kwcXoj/Ag14dcvjnYU1pBXmId6xOsBK0sgq/5MTH0aJfUYk/9iA2RFcjo
 ZZPjatMzud8kvEpaE2o5VcmSW5XY4kXBiRtz40mh2b+7EuRhOu8mIMRX2451btVzTrOBIu
 MIsrQ651IyqdgQuQ/Hh5euAuVoogtsE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-hFly8dMSPNipmmAhNXQFPQ-1; Wed, 30 Sep 2020 04:36:33 -0400
X-MC-Unique: hFly8dMSPNipmmAhNXQFPQ-1
Received: by mail-wm1-f69.google.com with SMTP id s24so210547wmh.1
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 01:36:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=kuMXAtvGN/B005vXkmMonSfaYsnH+UQ7+m+9MndOMZM=;
 b=c0HSovgNIKwy8fqENiScmfzuZkBMxA+VlaA+AJyjLtHfLke3yHgJS/Pv57GrXBUl9Z
 /gYHnzLtNpq+wb1h8/2oPnD3loECKHSxFRGzxw9xsmwfkeUeAR7FYbqJp27DSaIn0TtK
 Bkc/5/mXYaas2RI4LnyPT9pqb29WUkfagPDWF1YUYYOlL3bLlSJhhQJT4f/2bZXo6kLc
 8KbdPtBbHu2Gar5mPEUOOKc4kjhPPAr2NM43RfvQxHTNDg9fizkEd0cWIlScPRS36/QE
 v/1S75POxnuG3k6H9w1pDxBfRTtPhadpptMYbFq8PLOTIXtBDqAk3srHes9v2xGt5d58
 SoVQ==
X-Gm-Message-State: AOAM533j7GfvI9Y9NPpkZ+HCnDGsHMSUPqzbWybqxyQVxhJD2EiU5CZp
 bzKlhA95iCj/y1h717XIgXKogoQP/SC6rgS/nFUdzXBWITjLnbYOWM5cwj116RJftproIN1+RCC
 tuDG2A27+pWe7VSE=
X-Received: by 2002:a1c:740c:: with SMTP id p12mr1715234wmc.176.1601454991348; 
 Wed, 30 Sep 2020 01:36:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyTvm5H0MKovJpvUFwhfdQpGFrbEiXnMURF6eveyN3KeHZYHaeTe2yTdVTf2w9sINf3Y5wEtg==
X-Received: by 2002:a1c:740c:: with SMTP id p12mr1715216wmc.176.1601454991121; 
 Wed, 30 Sep 2020 01:36:31 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id n3sm1438267wmn.28.2020.09.30.01.36.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2020 01:36:30 -0700 (PDT)
Date: Wed, 30 Sep 2020 04:36:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/2] acpi: unit test
Message-ID: <20200930083552.506733-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:31:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit f142e4ede72853aaa7d306bc79b099caed45769b:

  tests/acpi: drop unnecessary files (2020-09-29 07:10:37 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 42803552319a5481e90e93382d74a7336dfab496:

  tests/acpi: add DSDT.hpbrroot DSDT table blob to test global i440fx hotplug (2020-09-30 04:10:51 -0400)

----------------------------------------------------------------
acpi: unit test

This just adds a unit test for previously merged functionality.
A bit unusual, but we have a contribitor under a deadline,
let's be nice and merge the unit test right away - does no harm.
Hopefully this won't be a beginning of a trend ...

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Ani Sinha (2):
      tests/acpi: unit test exercising global pci hotplug off for i440fx
      tests/acpi: add DSDT.hpbrroot DSDT table blob to test global i440fx hotplug

 tests/qtest/bios-tables-test.c   |  17 +++++++++++++++++
 tests/data/acpi/pc/DSDT.hpbrroot | Bin 0 -> 3079 bytes
 2 files changed, 17 insertions(+)
 create mode 100644 tests/data/acpi/pc/DSDT.hpbrroot


