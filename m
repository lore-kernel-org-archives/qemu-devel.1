Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1657C2D0E5
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 21:05:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8585920737
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 21:05:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8585920737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHDDL-0001KV-LC
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 17:05:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43344)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jHD99-0004dz-0e
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 17:01:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1jHD97-0000Nd-EM
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 17:01:06 -0400
Received: from indium.canonical.com ([91.189.90.7]:33348)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1jHD97-0000M7-7T
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 17:01:05 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jHD94-0003C8-2n
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 21:01:02 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 8FF402E80ED
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 21:00:59 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Mar 2020 20:50:52 -0000
From: Paul Menzel <1693050@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: paulmenzel rmustacc
X-Launchpad-Bug-Reporter: Robert Mustacchi (rmustacc)
X-Launchpad-Bug-Modifier: Paul Menzel (paulmenzel)
References: <149558234717.18218.15801621819682136328.malonedeb@chaenomeles.canonical.com>
Message-Id: <158516945260.16905.11037714506188450116.malone@gac.canonical.com>
Subject: [Bug 1693050] Re: xhci HCIVERSION register read emulation incorrectly
 handled
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="3a6db24bbe7280ec09bae73384238390fcc98ad3";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: e4a382e8762e0a69d8717d1c7200b2d61b9c11bc
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
Reply-To: Bug 1693050 <1693050@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

According to [1], this is still an issue today.

[1]: https://review.coreboot.org/c/coreboot/+/39838/

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1693050

Title:
  xhci HCIVERSION register read emulation incorrectly handled

Status in QEMU:
  New

Bug description:
  We had an illumos user trying to run illumos in QEMU 2.9.0 with the
  qemu-xhci device enabled. Note, that while this was discovered against
  QEMU 2.9.0, from my current read of the HEAD, it is still present. The
  illumos bug at https://www.illumos.org/issues/8173 has additional
  information on how the user invoked qemu. While investigating the
  problem we found that the illumos driver was reading a version of
  0x0000 when reading the HCIVERSION register from qemu.

  In the illumos driver we're performing a 16-bit read of the version
  register at offset 0x2. From looking around at other OSes, while Linux
  performs a 4 byte read at offset 0x0 and masks out the version, others
  that care about the version are doing a two byte read, though not all
  actually act on the version and some just discard the information.

  The user who hit this was able to enable tracing (note the tracing
  file is attached to the illumos bug linked previously) and we hit the
  unimplemented register read with offset 0x2 at
  http://git.qemu.org/?p=3Dqemu.git;a=3Dblob;f=3Dhw/usb/hcd-
  xhci.c;hb=3DHEAD#l2960. The xhci register specifies today that its
  allowed for users to do 1-4 byte reads; however, that it implements
  only four byte reads in its implementation
  (http://git.qemu.org/?p=3Dqemu.git;a=3Dblob;f=3Dhw/usb/hcd-
  xhci.c;hb=3DHEAD#l3333). Hence why when we read the HCIVERSION register
  at offset 0x2, it isn't handled in xhci_cap_read() which then returns
  zeros.

  From digging into this, I think that we're coming into
  memory_region_dispatch_read() and then memory_region_dispatch_read1().
  However, I don't see anything in either the general memory region
  logic or in the xhci_cap_read() function that would deal with
  adjusting the offset that we're reading at and then masking it off
  again. While the access_with_adjusted_size() attempts to deal with
  this, it never adjusts the hardware address that's passed in to be a
  multiple of the implementation defined offset that I can see. I
  suspect that the FIXME at line 582
  (http://git.qemu.org/?p=3Dqemu.git;a=3Dblob;f=3Dmemory.c;hb=3DHEAD#l582) =
and
  the implementation in the xhci code is the crux of the problem.

  For the time being we're working around this in the illumos driver,
  but I wanted to point this out such that it might be helpful for other
  systems which are assuming that they can do the two byte read like on
  hardware.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1693050/+subscriptions

