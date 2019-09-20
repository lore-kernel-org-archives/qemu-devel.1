Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A0EC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 19:18:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32FBA205F4
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 19:18:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32FBA205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBOQ6-0008US-R8
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 15:18:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58849)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iBONg-00076L-1w
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 15:15:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iBONe-0003Wi-Bd
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 15:15:47 -0400
Received: from indium.canonical.com ([91.189.90.7]:48802)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iBONd-0003TG-8D
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 15:15:46 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iBONb-00012B-0v
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 19:15:43 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 0446D2E80CC
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 19:15:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Sep 2019 19:01:46 -0000
From: =?utf-8?q?=C5=BDilvinas_=C5=BDaltiena?= <1811533@bugs.launchpad.net>
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
X-Launchpad-Bug-Modifier: =?utf-8?q?=C5=BDilvinas_=C5=BDaltiena_=28zaltysz?=
 =?utf-8?q?=29?=
References: <154731859474.20612.3794172498936114295.malonedeb@soybean.canonical.com>
Message-Id: <156900610636.4953.7933770886441859746.malone@chaenomeles.canonical.com>
Subject: [Bug 1811533] Re: Unstable Win10 guest with qemu 3.1 + huge pages +
 hv_stimer
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19048";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 48487facfff8d540cd4f7e55851488acb55aedf3
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

As asked by dgilbert-h, I am attaching my qemu command line. It is
ripped from libvirt log.

** Attachment added: "Bug reproducing Qemu command line from libvirt log."
   https://bugs.launchpad.net/qemu/+bug/1811533/+attachment/5290067/+files/=
qemu_cmdln.txt

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

