Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B961EC1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 19:51:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7402C206EC
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 19:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R7fW/Brb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7402C206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEIFe-0000G4-GA
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 15:51:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34229)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jEIEo-0007ja-Ne
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 15:50:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1jEIEm-0001g6-N3
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 15:50:53 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:22829)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1jEIEm-0001do-J6
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 15:50:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584474651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=VI3BNtWgb2pIvVL7mD7Z90LVfccrOcQhs4gMlfqEMVQ=;
 b=R7fW/BrbKQpHPGx8aZPPm2uFwqE1yhaTbdfZv7QhrTZXSDdOU9xTk/RoEWYMbiGJaG0bkl
 pmR4ejbtkyvIf6ee/r/9PFplfUXL+1CWjDZ0v8geKgZQnQvKLbO7AtQAhTDbe52tbjjd3j
 BL91NNEyBEafDDhauwZa4bM1JEXVTXw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-LuS14xSAP12R4181-_K-zg-1; Tue, 17 Mar 2020 15:50:48 -0400
X-MC-Unique: LuS14xSAP12R4181-_K-zg-1
Received: by mail-wr1-f72.google.com with SMTP id 94so6504835wrr.3
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 12:50:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=VWImJkkOFrmZL++ATxhRlLdZEMijJ/nikXmoDLH7TO8=;
 b=mHq8cFj/sleorcSdMaTTBcrqqE+z1eOwjBdfa27p3WIwGTJKlJaGQMnRZlMdT/tLy4
 zscX4VDjh8sU6nXT4+CdqTwbp5EdWnOcYQhr8OQYXBqDG4ME/lcwh0Qdd+aq2yrQS4yI
 qkYq6qPlWUcrTIWtgNiR2n10/9099r08AAWh4miVF2wvwW3mTbdHInHBtgzpQAiJfbls
 /Ihn0+Gf+uXsr9veIPiqRLM7TTDcee7N2r2gIthl65v1RMW0hhvSrG9Xq3hUnwK1LBIi
 NzzOMDdeIhjNj7zt6RuQS0G03jFP24iPePCc4n5kDg+V1h4d892lesozQjkeiXFF632H
 UXaA==
X-Gm-Message-State: ANhLgQ1+YKTdg5q+NHEplCtJK0GHmyj3+vhKOVSB2MasWILSTfdWCPLx
 5GfAPfSpSXV6atQCM3yemhYcbFCJaH+p9i/N6MJZxaLaY37dRl4ACdIWshtTRKvWPF6etqUkVkL
 QmqkEbLkfknfPBfk=
X-Received: by 2002:a05:600c:258c:: with SMTP id
 12mr697641wmh.140.1584474646465; 
 Tue, 17 Mar 2020 12:50:46 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvH5UHJLzgBbqDbGpdzrmzkDXFaxwoe35cuyebWmukWwCvztiryTCAhDOArk/HaMbRHxM0MMg==
X-Received: by 2002:a05:600c:258c:: with SMTP id
 12mr697608wmh.140.1584474646158; 
 Tue, 17 Mar 2020 12:50:46 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id x17sm574507wmi.28.2020.03.17.12.50.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2020 12:50:45 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/5] vfio/pci: Fix up breakage against split irqchip and
 INTx
Date: Tue, 17 Mar 2020 15:50:37 -0400
Message-Id: <20200317195042.282977-1-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
 Alex Williamson <alex.williamson@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, peterx@redhat.com,
 Eric Auger <eric.auger@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I believe I missed 5.0... Anyway still good to post it before being
forgotten...

v3:
- collect r-bs for Eric
- unconditionally call kvm_resample_fd_notify(), change comment [Alex]
- remove the split irqchip check in kvm_resample_fd_notify(), then let
  it return nothing [Alex]
- test against shared irq to make sure it won't break

v2:
- pick tags
- don't register resamplefd with KVM kernel when the userspace
  resamplefd path is enabled (should enable fast path on new kernels)
- fix resamplefd mem leak
- fix commit message of patch 4 [Eric]
- let kvm_resample_fd_notify() return a boolean, skip ioapic check if
  returned true
- more comments here and there in the code to state the fact that
  userspace ioapic irr & remote-irr are bypassed [Paolo]

VFIO INTx is not working with split irqchip.  On new kernels KVM_IRQFD
will directly fail with resamplefd attached so QEMU will automatically
fallback to the INTx slow path.  However on old kernels it's still
broken.

Only until recently I noticed that this could also break PXE boot for
assigned NICs [1].  My wild guess is that the PXE ROM will be mostly
using INTx as well, which means we can't bypass that even if we
enables MSI for the guest kernel.

This series tries to first fix this issue function-wise, then speed up
for the INTx again with resamplefd (mostly following the ideas
proposed by Paolo one year ago [2]).  My TCP_RR test shows that:

  - Before this series: this is broken, no number to show

  - After patch 1 (enable slow path): get 63% perf comparing to full
    kernel irqchip

  - After whole series (enable fast path partly, irq injection will be
    the same as fast path, however userspace needs to intercept for
    EOI broadcast to resamplefd, though should still be faster than
    the MMIO trick for intx eoi): get 93% perf comparing to full
    kernel irqchip, which is a 46% performance boost

I think we can consider to apply patch 1 even sooner than the rest of
the series to unbreak intx+split first.

The whole test matrix for reference:

  |----------+---------+-------------------+--------------+----------------=
----|
  | IRQ type | irqchip | TCP_STREAM (Gbps) | TCP_RR (pps) | note           =
    |
  |----------+---------+-------------------+--------------+----------------=
----|
  | msi      | on      |              9.39 |        17567 |                =
    |
  | nomsi    | on      |              9.29 |        14056 |                =
    |
  | msi      | split   |              9.36 |        17330 |                =
    |
  | nomsi    | split   |                 / |            / | currently broke=
n   |
  | nomsi    | split   |              8.98 |         8977 | after patch 1  =
    |
  | nomsi    | split   |              9.21 |        13142 | after whole ser=
ies |
  |----------+---------+-------------------+--------------+----------------=
----|

Any review comment is welcomed.  Thanks,

[1] https://bugzilla.redhat.com/show_bug.cgi?id=3D1786404
[2] https://patchwork.kernel.org/patch/10738541/#22609933

Peter Xu (5):
  vfio/pci: Disable INTx fast path if using split irqchip
  vfio/pci: Use kvm_irqchip_add_irqfd_notifier_gsi() for irqfds
  KVM: Pass EventNotifier into kvm_irqchip_assign_irqfd
  KVM: Kick resamplefd for split kernel irqchip
  Revert "vfio/pci: Disable INTx fast path if using split irqchip"

 accel/kvm/kvm-all.c    | 95 ++++++++++++++++++++++++++++++++++++++----
 accel/kvm/trace-events |  1 +
 hw/intc/ioapic.c       | 25 ++++++++++-
 hw/vfio/pci.c          | 37 +++++++---------
 include/sysemu/kvm.h   |  4 ++
 5 files changed, 130 insertions(+), 32 deletions(-)

--=20
2.24.1


