Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A930C31E40
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 07:46:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 015A62085A
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 07:46:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 015A62085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hx528-0005Xw-LW
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 03:46:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51246)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peterx@redhat.com>) id 1hx51Q-00043c-Uf
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 03:45:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1hx51P-0007da-M5
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 03:45:40 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38961)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1hx51P-0007cH-EW
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 03:45:39 -0400
Received: by mail-wm1-f66.google.com with SMTP id u25so10859696wmc.4
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2019 00:45:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0TR+no1+BjQScWDAO9tp5ZPjs41wABSYfGnOZd+jKUw=;
 b=O4GmPuqBtkJDNY/mHf4iWM6zXeoPyg6IVrera9CFzV0LD+lubI4xb7MmIUCiEZ5xaF
 U13eEj89/DF/G/N7H4gOTSM9NGVeKoNDj3YUnWwCbZABmk5y1JJwSKqBUSd9DbFvck8k
 O0pp6jNw6cgF9NeQ2O7NbrM6fz//EmQM+kSuwv38FPl7Qdo0RlQIa1IT59/1oxAP8VOR
 5tazKEPokHThDpFA6QbcOlR349vrLWGRZArEqvcMlo1dGhxpCOS9xKQdMPx7jYzJV6I+
 Fb1V+EV+nWUeUcYKpAD4B95jd7SwJ7pTotHO+BFxu3OBQuinduOZLbJN78L4NxrNf0Au
 /VZg==
X-Gm-Message-State: APjAAAVipkXd6yNqMxFkftJzoz3QY5rgFRT6r/csyN7mgCFtGloZEgx+
 U9Dxw9jBgX+nuSqXt+f6/DeC0Hw/XxdsVw==
X-Google-Smtp-Source: APXvYqz+fnLfZepJaCOlJTX8GyKLbqSjKH3ZpEmnPcaCSHpMJyFOJBvH+vAU4cEWvOSbHMoZvHSL4g==
X-Received: by 2002:a05:600c:254e:: with SMTP id
 e14mr26369251wma.150.1565595935208; 
 Mon, 12 Aug 2019 00:45:35 -0700 (PDT)
Received: from xz-x1.redhat.com (net77-43-52-122.mclink.it. [77.43.52.122])
 by smtp.gmail.com with ESMTPSA id a84sm15909450wmf.29.2019.08.12.00.45.32
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 12 Aug 2019 00:45:34 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 12 Aug 2019 09:45:27 +0200
Message-Id: <20190812074531.28970-1-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
Subject: [Qemu-devel] [PATCH RFC 0/4] intel_iommu: Do sanity check of
 vfio-pci earlier
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Alex Williamson <alex.williamson@redhat.com>,
 peterx@redhat.com, Bandan Das <bsd@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a RFC series.

The VT-d code has some defects, one of them is that we cannot detect
the misuse of vIOMMU and vfio-pci early enough.

For example, logically this is not allowed:

  -device intel-iommu,caching-mode=off \
  -device vfio-pci,host=05:00.0

Because the caching mode is required to make vfio-pci devices
functional.

Previously we did this sanity check in vtd_iommu_notify_flag_changed()
as when the memory regions change their attributes.  However that's
too late in most cases!  Because the memory region layouts will only
change after IOMMU is enabled, and that's in most cases during the
guest OS boots.  So when the configuration is wrong, we will only bail
out during the guest boots rather than simply telling the user before
QEMU starts.

The same problem happens on device hotplug, say, when we have this:

  -device intel-iommu,caching-mode=off

Then we do something like:

  (HMP) device_add vfio-pci,host=05:00.0,bus=pcie.1

If at that time the vIOMMU is enabled in the guest then the QEMU
process will simply quit directly due to this hotplug event.  This is
a bit insane...

This series tries to solve above two problems by introducing two
sanity checks upon these places separately:

  - machine done
  - hotplug device

This is a bit awkward but I hope this could be better than before.
There is of course other solutions like hard-code the check into
vfio-pci but I feel it even more unpretty.  I didn't think out any
better way to do this, if there is please kindly shout out.

Please have a look to see whether this would be acceptable, thanks.

Peter Xu (4):
  intel_iommu: Sanity check vfio-pci config on machine init done
  qdev/machine: Introduce hotplug_allowed hook
  pc/q35: Disallow vfio-pci hotplug without VT-d caching mode
  intel_iommu: Remove the caching-mode check during flag change

 hw/core/qdev.c         | 17 +++++++++++++++++
 hw/i386/intel_iommu.c  | 40 ++++++++++++++++++++++++++++++++++------
 hw/i386/pc.c           | 21 +++++++++++++++++++++
 include/hw/boards.h    |  9 +++++++++
 include/hw/qdev-core.h |  1 +
 qdev-monitor.c         |  7 +++++++
 6 files changed, 89 insertions(+), 6 deletions(-)

-- 
2.21.0


