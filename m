Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A61C4BA2D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 22:54:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 698C72072D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 22:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="auyoz4kY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 698C72072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j75Zg-0006Bj-K9
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 17:54:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38525)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j75W8-0001Mw-AC
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 17:51:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j75W6-0002sS-FT
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 17:51:00 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36926
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j75W6-0002rf-BP
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 17:50:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582757457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jH5YZEO+5d1prqi26ePXIPxs7Xn5z2klMwcx96s1W84=;
 b=auyoz4kYc7G5PQuFwXkPCIyR/CxuLQL7NKLPNxZk8nh6TyA6Pc7VzBnvh8NYvh1hP7fCFz
 AJ9j85j1tjsWHsjIW3i2/RRCVaZEXIRlERHUsSJ6qZZvitkj1ItRO246cYc0Jycp2GLzGc
 N5yWc5ZjmBuHGdCVC9+Amnk2IAqaTbg=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-qmb6vJo3N-eusC-MTc2y_g-1; Wed, 26 Feb 2020 17:50:52 -0500
X-MC-Unique: qmb6vJo3N-eusC-MTc2y_g-1
Received: by mail-qk1-f200.google.com with SMTP id s189so1287220qke.5
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 14:50:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=pkEwLiQfwezvGpZghQckBi/Zen9+oiXzMGCinIRovhg=;
 b=s6Lz9nsYbm8q35i9yejA6YbFsnDpTnrFe1tnmdilERSYK+4lCIhxoeR2cPFMcfKNst
 KneEQrHRiF8ds0WiHKv+1lg0MMM0Idey0tAOt9z7EiMKwMsNUbDrhlGbTFbbKI2jV+N7
 2GlydkBZ9TK1tNk0cP43h2ccToPjVv7XOYvp2ql0379ewTbIpXnGdVL3/GOIl2U6GCGA
 Ill/w57o1AyzNUJAs1GBumvxAprAsLxBdo/x3tSfZKrDmMn1Ngg1NuxFC6FbwABI2MvD
 Mda5Vzh2/Xpul9/33yLL+xtIbx+vHPH2dZBLoOTXevQxVqMTBIkaeY7gnOs5BqiwK+wK
 fGMA==
X-Gm-Message-State: APjAAAUxeomanNmNFrXAF9stulik1ZTvgJb2Rxu1McfghcAlclzz+pDl
 fYAKRrdItZ/nb+oicCzOsMp+qhpvJJ+6Le1XypiDQPWNjKUMPKVp/8vfzPt7Jk3mqUUHUNAsoZS
 VR4VQOavLMZP7RWc=
X-Received: by 2002:ad4:46c3:: with SMTP id g3mr1483477qvw.60.1582757451007;
 Wed, 26 Feb 2020 14:50:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqzklR69M7OxjuzMeWEimHTD/uuSQix/WU4dHvzE+tWGzD5xqhFU1xlLooqhwI305vceqCGpGQ==
X-Received: by 2002:ad4:46c3:: with SMTP id g3mr1483453qvw.60.1582757450681;
 Wed, 26 Feb 2020 14:50:50 -0800 (PST)
Received: from xz-x1.redhat.com
 (CPEf81d0fb19163-CMf81d0fb19160.cpe.net.fido.ca. [72.137.123.47])
 by smtp.gmail.com with ESMTPSA id t23sm1859140qtp.82.2020.02.26.14.50.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2020 14:50:50 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/5] vfio/pci: Fix up breakage against split irqchip and INTx
Date: Wed, 26 Feb 2020 17:50:43 -0500
Message-Id: <20200226225048.216508-1-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, peterx@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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

 accel/kvm/kvm-all.c    | 83 +++++++++++++++++++++++++++++++++++++++---
 accel/kvm/trace-events |  1 +
 hw/intc/ioapic.c       | 11 +++++-
 hw/vfio/pci.c          | 37 ++++++++-----------
 include/sysemu/kvm.h   |  4 ++
 5 files changed, 106 insertions(+), 30 deletions(-)

--=20
2.24.1


