Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9446C10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 14:54:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1A2520752
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 14:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TxBEmQX3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1A2520752
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEa5j-00048E-P0
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 10:54:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46136)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jEa3P-0000Iv-Om
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 10:52:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1jEa3N-0005Fi-Qg
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 10:52:19 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:48040)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1jEa3N-00054M-K5
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 10:52:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584543136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9lVHBOmxpltkLkNhW8cy+rC1YjblwHBhLaPjDns0PYs=;
 b=TxBEmQX3DAx+vn2lIR4GflH/saJey8IubZ9sJHtT2lSr7gzaBbdvKp2/5d6mbmRXB8C621
 2BZOcFvJK3+Sw/LtzgwaHFASNch3UHBW9Aqx/mY3SOGDOCkdFl/stQvzbhKUEblBhgg2L/
 gD8ClgRCyYCPPq2Vo6av0CONqem1Fuw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-CZ3QRJKONYGsRCaYvYP07Q-1; Wed, 18 Mar 2020 10:52:11 -0400
X-MC-Unique: CZ3QRJKONYGsRCaYvYP07Q-1
Received: by mail-wm1-f70.google.com with SMTP id z26so1145539wmk.1
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2020 07:52:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Xm3l7+ijNgwjkdZHD5kmd80N4+OGRCY6QF0AEU/LdC4=;
 b=j9IND1TL9DwbBMbiLiXP4HBPfGJpauJE1zUshiIsG6HWwi25HH6tt35iFhkntsafSL
 xbXj0ZQeD7+6W2TV4gJmYmLUWxVblVngsOE/Yp2g160tbdWzIQ1dFqGtF6/Y4H8q7/Co
 vvSqhOcXd3R0lwPh1jQmqktC/t/oBbjS1eQYTBxt3YI3252fpPow5wxRU8dcZYPuA4VU
 B/TSpfZebbMbnNIKEowFa/GCssEQHmQ2WwOzxEsQjJXwy5LI6A/6jpsHbfJPr8I0N4si
 qqxW2cNtFmwyPxrAbL143ZTEZV/L4I10PjBMWkLl0Jiuf9o3OaIowITyz9qgeffpt1ww
 fogQ==
X-Gm-Message-State: ANhLgQ0Q9qHX7hAcuP+7eOAC1Ur4Q3hSVly8ZJwSS64yJJ4T5AlQ2Kox
 Z9ekHI5KcYHXGxu35MhCiz9PBmm/wccY+hnST4I+Ktc0yWtMVbawnbfXxMDMn1sHpH4JqMc1BuD
 Wm3AxESHgfbnv7VM=
X-Received: by 2002:a5d:6386:: with SMTP id p6mr5839535wru.194.1584543129410; 
 Wed, 18 Mar 2020 07:52:09 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsNmEQOAP6yN6PICRRXmgRKNPcylJJ/D2D50dW2nHsJlqFhFYaY6qoXb4mjYWH9YQhTcTMxWg==
X-Received: by 2002:a5d:6386:: with SMTP id p6mr5839509wru.194.1584543129087; 
 Wed, 18 Mar 2020 07:52:09 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id a186sm4182936wmh.33.2020.03.18.07.52.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2020 07:52:08 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 0/5] vfio/pci: Fix up breakage against split irqchip and
 INTx
Date: Wed, 18 Mar 2020 10:51:59 -0400
Message-Id: <20200318145204.74483-1-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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

v4:
- pick r-b and a-b for Alex without patch 4
- only kick resamplefd for level triggered irq (as 3.1 change on patch
  4) [Alex]
- fix mingw build error with below squashed into patch 4:

----------------------------------------
diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
index 2ae96e10be..b9ec570c03 100644
--- a/hw/intc/ioapic.c
+++ b/hw/intc/ioapic.c
@@ -241,6 +241,7 @@ void ioapic_eoi_broadcast(int vector)
                 continue;
             }

+#ifdef CONFIG_KVM
             /*
              * When IOAPIC is in the userspace while APIC is still in
              * the kernel (i.e., split irqchip), we have a trick to
@@ -257,6 +258,7 @@ void ioapic_eoi_broadcast(int vector)
              * emulated devices that are using/sharing the same IRQ.
              */
             kvm_resample_fd_notify(n);
+#endif

             if (!(entry & IOAPIC_LVT_REMOTE_IRR)) {
                 continue;
----------------------------------------

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
 hw/intc/ioapic.c       | 19 +++++++++
 hw/vfio/pci.c          | 37 +++++++---------
 include/sysemu/kvm.h   |  4 ++
 5 files changed, 126 insertions(+), 30 deletions(-)

--=20
2.24.1


