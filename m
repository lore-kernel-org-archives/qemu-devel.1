Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B079BC49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 08:08:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85EB3206C2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 08:08:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85EB3206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59781 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9m3x-0005j9-Db
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 04:08:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55931)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1i9m2o-0004p0-45
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 04:07:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1i9m2n-00025H-1b
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 04:07:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58446)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1i9m2m-000253-QF
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 04:07:32 -0400
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 05339C08E286
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 08:07:32 +0000 (UTC)
Received: by mail-pg1-f199.google.com with SMTP id i12so21612592pgm.12
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 01:07:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wBMS6QNHX0Hga83f+yotlq6i0y15nyLu19wU9igvxrE=;
 b=JlKp5rEY2wrMor1lDNGxXpVH9PhAi/jeJr4d5lFVczsAS/Fj3tALvC7eh6798ErlaI
 lm+pmg8ThYYP2Xu0ryUynpu4jp6w48ADuG0cnf+cWRTzG71rB8pSlG+RzEkEuBZGUlTN
 SbGtqJBNKg7vAiBGhW5nWkuePCg7fza3rXG2fQBJJZPJGmiedvITaI1Vcwzx132s+ytu
 R8kXv3qWOy988E7HN+Yd6A6Cp8O69M3Sd2J1zd27ItO9A1VI9narbPt5bT6+lVS/8acS
 vLuWsfTZhnFb7bZbhd3Nv3AC+EFvwguai7RGtR0tiSi6RdrNO3R/4s+aeTXclKyrvpdD
 cgUA==
X-Gm-Message-State: APjAAAVNdmQXF6FTrZdeXLv6GGc5Lk5cBrOKDpnEfWCf4FIRlSLyIoo/
 LhMwybqhsT4YHJOL5QGctMx5i88Yy42xA6dVs/p9mkrRyTRwD7GeZbxYYYJ2G6+jEDH5coCnJru
 d1Tw3v9TcQeIKJkc=
X-Received: by 2002:a17:90a:2182:: with SMTP id
 q2mr20005419pjc.56.1568621250774; 
 Mon, 16 Sep 2019 01:07:30 -0700 (PDT)
X-Google-Smtp-Source: APXvYqylQzNIwu0UqlRnZyqHe66QHlhc9NKYf5JWYxC70vwQ27j6oIAaTyMoczwM85oUYKXLzIdjHQ==
X-Received: by 2002:a17:90a:2182:: with SMTP id
 q2mr20005393pjc.56.1568621250510; 
 Mon, 16 Sep 2019 01:07:30 -0700 (PDT)
Received: from xz-x1.redhat.com ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id r12sm43051515pgb.73.2019.09.16.01.07.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2019 01:07:29 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 16 Sep 2019 16:07:14 +0800
Message-Id: <20190916080718.3299-1-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 0/4] intel_iommu: Do sanity check of
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
 peterx@redhat.com, Eric Auger <eric.auger@redhat.com>,
 Bandan Das <bsd@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v3:
- repost with the correct tree

v2:
- rebase to master [Eric]
- add r-bs for Eric
- remove RFC tag

The VT-d code has some defects, one of them is that we cannot detect
the misuse of vIOMMU and vfio-pci early enough.

For example, logically this is not allowed:

  -device intel-iommu,caching-mode=3Doff \
  -device vfio-pci,host=3D05:00.0

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

  -device intel-iommu,caching-mode=3Doff

Then we do something like:

  (HMP) device_add vfio-pci,host=3D05:00.0,bus=3Dpcie.1

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
 hw/i386/intel_iommu.c  | 41 +++++++++++++++++++++++++++++++++++------
 hw/i386/pc.c           | 21 +++++++++++++++++++++
 include/hw/boards.h    |  9 +++++++++
 include/hw/qdev-core.h |  1 +
 qdev-monitor.c         |  7 +++++++
 6 files changed, 90 insertions(+), 6 deletions(-)

--=20
2.21.0


