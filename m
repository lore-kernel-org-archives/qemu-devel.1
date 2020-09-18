Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFDCC43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 02:00:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4371A2087D
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 02:00:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4371A2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJ5hA-00075d-3E
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 22:00:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58530)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kJ5ga-0006fX-R1
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 21:59:40 -0400
Received: from indium.canonical.com ([91.189.90.7]:60848)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kJ5gY-0006Gk-LJ
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 21:59:40 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kJ5gW-0004SV-Bm
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 01:59:36 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 3FF252E80EC
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 01:59:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2020 01:45:59 -0000
From: Jiajie Li <1090604@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=In Progress; importance=Wishlist;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: crobinso l00580144
X-Launchpad-Bug-Reporter: Cole Robinson (crobinso)
X-Launchpad-Bug-Modifier: Jiajie Li (l00580144)
References: <20121215001427.24095.85792.malonedeb@soybean.canonical.com>
Message-Id: <160039355981.17103.4973312351439624677.malone@soybean.canonical.com>
Subject: [Bug 1090604] Re: RFE: Implement support for SMBIOS Type 41 structures
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="83bdf6c8a3a5f87722c8927e54838522f3e57504"; Instance="production"
X-Launchpad-Hash: e88dbfb73775c3b8c772e8f3870175d283e548b2
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 21:25:35
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.248, RCVD_IN_DNSWL_HI=-5,
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
Reply-To: Bug 1090604 <1090604@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello, I'm intersted in this bug fix and have some free time. maybe I
can do this bug-fix.

** Changed in: qemu
       Status: New =3D> In Progress

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1090604

Title:
  RFE: Implement support for SMBIOS Type 41 structures

Status in QEMU:
  In Progress

Bug description:
  This was originally filed in Fedora bugzilla:
  https://bugzilla.redhat.com/show_bug.cgi?id=3D669955

  """
  Please extend the existing support for SMBIOS in qemu to add a capability=
 to provide "Onboard Devices Extended Information" (Type 41). Not only is t=
his replacing one of the existing types, but it also provides a mapping bet=
ween devices and physical system chassis locations. But there is no physica=
l chassis! Right. However, this doesn't mean you don't want to tell the gue=
st OS which virtual (e.g. network) interface is which. You can do that, if =
you implement this extension that is already going into real hardware, and =
likely other VMs too.

  See also page 117 of the v2.7 of the SMBIOS spec.

  FWIW, VMware ESX and Workstation expose their PCI NICs in the PCI IRQ Rou=
ting Table.  Kind of odd the first time you see it with biosdevname, as you=
r NIC becomes pci3#1, but that's "correct" from a BIOS perspective. :-)
  """

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1090604/+subscriptions

