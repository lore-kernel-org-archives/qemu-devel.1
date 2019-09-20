Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF43AC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 16:11:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5DE3206B6
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 16:11:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5DE3206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBLVB-00059A-36
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 12:11:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48061)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iBLBM-0002RW-LL
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 11:50:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iBLBL-00051D-8C
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 11:50:52 -0400
Received: from indium.canonical.com ([91.189.90.7]:59360)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iBLBL-00050m-2j
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 11:50:51 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iBLBH-0000nT-Hu
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 15:50:47 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 65BBD2E80DE
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 15:50:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Sep 2019 15:38:40 -0000
From: Vitaly Kuznetsov <1811533@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Confirmed; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: dgilbert-h djdatte vkuznets zaltysz
X-Launchpad-Bug-Reporter: =?utf-8?q?=C5=BDilvinas_=C5=BDaltiena_=28zaltysz?=
 =?utf-8?q?=29?=
X-Launchpad-Bug-Modifier: Vitaly Kuznetsov (vkuznets)
References: <154731859474.20612.3794172498936114295.malonedeb@soybean.canonical.com>
Message-Id: <156899392075.26730.527039292397667656.malone@soybean.canonical.com>
Subject: [Bug 1811533] Re: Unstable Win10 guest with qemu 3.1 + huge pages +
 hv_stimer
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19048";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 34b9f2d56817c3d9f763cde779f3ca2cba3f4b37
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1811533 <1811533@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

No, I think it's the other way around: clearing guest pages is
unrelated. It is easy to check with the following kernel patch:

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index fff790a3f4ee..73c574f930e3 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -776,7 +776,7 @@ int kvm_hv_activate_synic(struct kvm_vcpu *vcpu, bool d=
ont_zero_synic_pages)
         */
        kvm_vcpu_deactivate_apicv(vcpu);
        synic->active =3D true;
-       synic->dont_zero_synic_pages =3D dont_zero_synic_pages;
+       synic->dont_zero_synic_pages =3D false;
        return 0;
 }

my expectation is that the issue will remain.

Now what *can* be causing it: when in-QEMU synic is initialized it
creates two memory subregions: for Event page and for Message page
(HV_X64_MSR_SIEFP/HV_X64_MSR_SIMP MSRs). These regions are always 4k in
size and they can me anywhere in guest's memory, not necessarily 2M
aligned.

Now, (if I understood correctly) in vhost code,
vhost_region_add_section() is trying to align to qemu_ram_pagesize() and
this may intersect with synic regions.

We need to summon someone who understands memory_region_* magic in QEMU
and vhost in particular.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1811533

Title:
  Unstable Win10 guest with qemu 3.1 + huge pages + hv_stimer

Status in QEMU:
  Confirmed

Bug description:
  Host:
  Gentoo linux x86_64, kernel 4.20.1
  Qemu 3.1.0 =

  CPU: Intel i7 6850K
  Chipset: X99

  Guest:
  Windows 10 Pro 64bit (1809)
  Machine type: pc-q35_3.1
  Hyper-V enlightenments: hv_stimer,hv_reenlightenment,hv_frequencies,hv_va=
pic,hv_reset,hv_synic,hv_runtime,hv_vpindex,hv_time,hv_relaxed,hv_spinlocks=
=3D0x1fff
  Memory: 16GB backed by 2MB huge pages

  Issue:
  Once guest is started, log gets flooded with:

  qemu-system-x86_64: vhost_region_add_section: Overlapping but not
  coherent sections at 103000

  or

  qemu-system-x86_64: vhost_region_add_section:Section rounded to 0
  prior to previous 1f000

  (line endings change)

  and as time goes guest loses network access (virtio-net-pci) and
  general performance diminishes to extent of freezing applications.

  Observations:
  1) problem disappears when hv_stimer is removed
  2) problem disappears when memory backing with huge pages is disabled
  3) problem disappears when machine type is downgraded to pc-q35_3.0

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1811533/+subscriptions

