Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86266C433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 08:32:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45D44205F4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 08:32:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45D44205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDkf5-0007Nf-Cl
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 04:32:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53832)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kDkeS-0006m9-4u
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 04:31:24 -0400
Received: from indium.canonical.com ([91.189.90.7]:35330)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kDkeQ-0001Nj-5M
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 04:31:23 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kDkeN-00034m-04
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 08:31:19 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 173ED2E817D
 for <qemu-devel@nongnu.org>; Thu,  3 Sep 2020 08:31:15 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2020 08:18:05 -0000
From: "Tony.LI" <1731347@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: bigboy0822 jfalke
X-Launchpad-Bug-Reporter: Johannes Falke (jfalke)
X-Launchpad-Bug-Modifier: Tony.LI (bigboy0822)
References: <151026612898.3153.4753501294134415779.malonedeb@gac.canonical.com>
Message-Id: <159912108563.23377.8336820576259564992.malone@wampee.canonical.com>
Subject: [Bug 1731347] Re: VFIO Passthrough of SAS2008-based HBA card fails on
 E3-1225v3 due to failed DMA mapping (-14)
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="195cbfa84cb75815472f69dd83d46f006869050b"; Instance="production"
X-Launchpad-Hash: 5b70e37a38e918a404574a0f5c755d2594eec2bf
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 04:31:20
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Reply-To: Bug 1731347 <1731347@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello=EF=BC=81
   Has your problem been solved? I also encountered a similar problem. My i=
octl() also returned an error -14(Bad address).

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1731347

Title:
  VFIO Passthrough of SAS2008-based HBA card fails on E3-1225v3 due to
  failed DMA mapping (-14)

Status in QEMU:
  New

Bug description:
  There is a bug preventing multiple people with my combination of
  hardware from using PCI passthrough. I am not actually sure whether
  the bug is in kernel/kvm, vfio or qemu, however, as qemu is the
  highest-level of these, I am reporting the bug here as you will likely
  know better where the origin of the bug may be found.

  When attempting to pass through this device to a KVM using VFIO, this
  results in error -14 (Bad Address):

  # qemu-system-x86_64 -enable-kvm -m 10G -net none -monitor stdio -serial
  # none -parallel none -vnc :1 -device vfio-pci,host=3D1:00.0 -S
  QEMU 2.9.1 monitor - type 'help' for more information
  (qemu) c
  (qemu) qemu-system-x86_64: VFIO_MAP_DMA: -14
  qemu-system-x86_64: vfio_dma_map(0x7f548f0a1fc0, 0xfebd0000, 0x2000, 0x7f=
54a909d000) =3D -14 (Bad address)
  qemu: hardware error: vfio: DMA mapping failed, unable to continue

  See also:
  https://bugzilla.proxmox.com/show_bug.cgi?id=3D1556
  https://www.redhat.com/archives/vfio-users/2016-May/msg00088.html

  This has occurred on Proxmox (Proxmox and Debian packages, Ubuntu kernel)=
, Ubuntu,
  and pure Debian packages and kernel on Proxmox. However, this error
  reportedly does NOT occur for:

  - different distributions(!) (Fedora 24, 25)
  - different HBA cards (SAS2308, SAS3008)
  - different CPU (E3-1220v5)

  I would be thankful for any input and I'll be happy to provide any
  further info necessary. This is my first time delving this deep into
  anything close to the kernel.

  Thanks and best regards,
  Johannes Falke

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1731347/+subscriptions

