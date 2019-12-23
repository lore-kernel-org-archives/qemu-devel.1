Return-Path: <SRS0=AgAn=2N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F4CC2D0C0
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 21:21:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 062F5206B7
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 21:21:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 062F5206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ijV8n-0003AS-2g
	for qemu-devel@archiver.kernel.org; Mon, 23 Dec 2019 16:21:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34867)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1ijV89-0002j5-Bs
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 16:20:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1ijV88-0003MH-7d
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 16:20:45 -0500
Received: from indium.canonical.com ([91.189.90.7]:49794)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1ijV88-0003K7-1x
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 16:20:44 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1ijV86-0008RI-Ak
 for <qemu-devel@nongnu.org>; Mon, 23 Dec 2019 21:20:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 5059F2E80C0
 for <qemu-devel@nongnu.org>; Mon, 23 Dec 2019 21:20:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Dec 2019 21:14:30 -0000
From: John Snow <1816805@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
 assignee=jsnow@redhat.com; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: ayaurov jnsnow
X-Launchpad-Bug-Reporter: Andrii Yaurov (ayaurov)
X-Launchpad-Bug-Modifier: John Snow (jnsnow)
References: <155067985595.12116.1229580080440735698.malonedeb@gac.canonical.com>
Message-Id: <157713567064.14296.608073723478870482.malone@wampee.canonical.com>
Subject: [Bug 1816805] Re: Cannot create cdrom device with open tray and cache
 option
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="bceb5ef013b87ef7aafe0755545ceb689ca7ac60";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: f6469e53286f696bd17aaa8a6001561db947fdef
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Reply-To: Bug 1816805 <1816805@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, versions 2.5 and 2.11 are quite old (though version 2.10 fixed the
bug mentioned in the Red Hat BZ, so I think this might be a different
bug.)


It's not clear at what step this is failing or where you are seeing the err=
or message, so:

1. What is your full command line for QEMU?
2. Do you see this error message when migrating? If so, what does the desti=
nation QEMU command line look like?
3. Does the problem reproduce on a currently-supported upstream QEMU? (4.1.=
1, 4.2.0)

** Changed in: qemu
       Status: New =3D> Incomplete

** Changed in: qemu
     Assignee: (unassigned) =3D> John Snow (jnsnow)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1816805

Title:
  Cannot create cdrom device with open tray and cache option

Status in QEMU:
  Incomplete

Bug description:
  When trying to create cdrom device with open tray and either of
  "cache" or "discard" options specified, I get the following error:

  qemu-system-x86_64: -drive if=3Dnone,id=3Ddrive-
  ide0-0-0,readonly=3Don,cache=3Dwriteback,discard=3Dunmap,throttling.iops-
  total=3D900: Must specify either driver or file

  This bug essentially forbids live migration of VMs with open cdrom
  trays.

  I was able to find the same bug at RedHat:
  https://bugzilla.redhat.com/show_bug.cgi?id=3D1338638

  The bug was encountered in versions 2.5 and 2.11.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1816805/+subscriptions

