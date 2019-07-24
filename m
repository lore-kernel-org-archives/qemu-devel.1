Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3AC0C7618B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 04:30:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 868FF20644
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 04:30:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 868FF20644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hq8vD-0006Qb-Kf
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 00:30:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56577)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1hq8uy-0005tI-0N
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 00:30:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hq8uw-0006WG-Ql
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 00:30:19 -0400
Received: from indium.canonical.com ([91.189.90.7]:46090)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hq8uw-0006Vp-Lc
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 00:30:18 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hq8uv-0006ie-4Y
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2019 04:30:17 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 18F202E806E
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2019 04:30:17 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jul 2019 04:17:40 -0000
From: Launchpad Bug Tracker <1585971@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Expired; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: antonios-dimtsoudis janitor th-huth
X-Launchpad-Bug-Reporter: TuniTunes (antonios-dimtsoudis)
X-Launchpad-Bug-Modifier: Launchpad Janitor (janitor)
References: <20160526095955.26642.69942.malonedeb@chaenomeles.canonical.com>
Message-Id: <156394186091.19185.4265967821136341888.malone@loganberry.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19010";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 169bc67d6780951c4c2bebedd2f11701d914b638
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1585971] Re: Host system crashes on qemu with DMA
 remapping
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
Reply-To: Bug 1585971 <1585971@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1585971

Title:
  Host system crashes on qemu with DMA remapping

Status in QEMU:
  Expired

Bug description:
  Hy,

  the host system crashes completely, when i try to pass an physical
  device without boot option intel_iommu=3Don set. In older kernel
  versions you didn't have to pass that option.

  I wonder if this can be easily checked by asking iommu state, avoiding
  a crash of the complete system.

  My data:
  cpu model: Intel(R) Core(TM) i7 CPU
  qemu version: 2.4.1-r2
  kernel version: 4.1.2 x86_64
  command line: =

  qemu-system-x86_64 -enable-kvm -drive file=3D/vms/prod/fw/fw.iso,if=3Dvir=
tio,format=3Draw -drive file=3D/vms/prod/fw/swap,if=3Dvirtio,format=3Draw -=
drive file=3D/vms/prod/fw/fwdata.iso,if=3Dvirtio,format=3Draw -m 512 -nogra=
phic -kernel /data/kernels/vmlinuz-2.6.36-gentoo-r8 -append "root=3D/dev/vd=
a console=3DttyS0 earlyprintk=3Dserial" -net nic,model=3Dvirtio,macaddr=3DD=
E:AD:BE:EF:2D:AD -net tap,ifname=3Dtapfw0,script=3D/etc/qemu/qemu-ifup -dev=
ice pci-assign,host=3D03:00.0

  There are also more detailed informations (if needed) here:
  https://forums.gentoo.org/viewtopic-p-7923976.html

  Thanks,
  Antonios.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1585971/+subscriptions

