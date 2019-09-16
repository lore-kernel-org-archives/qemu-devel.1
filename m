Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BACEC49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 08:04:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F469206C2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 08:04:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F469206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9lzT-0001Gg-Qt
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 04:04:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54396)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1i9luS-0005os-0U
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 03:58:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1i9luQ-00065Q-J5
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 03:58:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34404)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1i9luQ-000651-AP
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 03:58:54 -0400
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9993B4E926
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 07:58:53 +0000 (UTC)
Received: by mail-pf1-f197.google.com with SMTP id c5so26588302pfo.17
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 00:58:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=pANWPujV8mgqfUm9CrHdTpHe+SE6fW1aXQVq1T1e/yo=;
 b=VAQmSF53BfHMILNfl4+e/nQChE5weeBCxn5KRIhqIc++Z+1dF/K4zm9sgUN1SzVp4x
 kHOXILnFYDbi5yIyUPusNpQNRg8BNZNQ07KbKUNFhRbzNQ88eqfM96TcE/IQXTiZAoom
 CTqXBBLdZwaTWhR9yIJUGX9GbXa8fNsbVO6rx8xq0xlWAUfRCEp2Jgox/WMuaV5skse6
 zk+qEwNEVrSjm8pEcbrUHWj2VfAQUDgPcfUZ2tcZos0/fowYkErmpYKoFVhnF+Fv3/Cs
 Fc+LW2sqGGIjj0BMJKn3SizQihSE4JUwfO6YNFVyKflSRb1b9abMW+H83jB07cu4ikwP
 doVg==
X-Gm-Message-State: APjAAAWhjJxK9NyjghGrK6ZPBJGY98aqvM3yQN5LBkjQGJhpR3AkhD/4
 ZJ08Eg9lxfHSV4obDzRmucoIW8MD0gZRKcuFAKR074CS2/gTR3HI+4Rpn6ZM0XBpNOfG32t5YM9
 5p2sJojqodaCs2OA=
X-Received: by 2002:a17:90a:7f8b:: with SMTP id
 m11mr19415414pjl.92.1568620732558; 
 Mon, 16 Sep 2019 00:58:52 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz9yiNIAAwhfOBrVcDIKg34jyg8lZRC4kjSfRVUIeiDkFGyJl0DrHbq6rZswgtncHk2rwGNNg==
X-Received: by 2002:a17:90a:7f8b:: with SMTP id
 m11mr19415391pjl.92.1568620732313; 
 Mon, 16 Sep 2019 00:58:52 -0700 (PDT)
Received: from xz-x1.redhat.com ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id p20sm50321443pgi.81.2019.09.16.00.58.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2019 00:58:50 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 16 Sep 2019 15:58:35 +0800
Message-Id: <20190916075839.390-1-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 0/4] intel_iommu: Do sanity check of
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
 hw/i386/intel_iommu.c  | 40 ++++++++++++++++++++++++++++++++++------
 hw/i386/pc.c           | 21 +++++++++++++++++++++
 include/hw/boards.h    |  9 +++++++++
 include/hw/qdev-core.h |  1 +
 qdev-monitor.c         |  7 +++++++
 6 files changed, 89 insertions(+), 6 deletions(-)

--=20
2.21.0


