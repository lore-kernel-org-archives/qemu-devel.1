Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59694C33CAF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 14:02:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 330132081E
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 14:02:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 330132081E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ir0IR-0002d2-QM
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 09:02:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58204)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1ir0H1-000128-HX
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 09:01:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1ir0Gz-0004pI-GB
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 09:00:55 -0500
Received: from indium.canonical.com ([91.189.90.7]:53300)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1ir0Gz-0004mW-9R
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 09:00:53 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1ir0Gw-0000Qj-KN
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2020 14:00:50 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 97D8C2E80C8
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2020 14:00:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jan 2020 13:53:04 -0000
From: Benjamin David Lunt <1859378@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Invalid; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: fysnet kraxel-redhat
X-Launchpad-Bug-Reporter: Benjamin David Lunt (fysnet)
X-Launchpad-Bug-Modifier: Benjamin David Lunt (fysnet)
References: <157887453515.27484.18206056235819884101.malonedeb@chaenomeles.canonical.com>
Message-Id: <157892358444.5958.5912372991631476698.malone@gac.canonical.com>
Subject: [Bug 1859378] Re: xhci Control Transfer requiring a Status TRB before
 starting transfer
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="bceb5ef013b87ef7aafe0755545ceb689ca7ac60";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 9d0aa2bc6119ae8fb8653cb83966b5c5085aa54f
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
Reply-To: Bug 1859378 <1859378@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I believe it is required to send an error event.  It checked for the
STATUS TRB and found that it was missing, therefore it must send an
Error Event.

This is (not so clearly) stated in the specification and I have quoted
this in a previous comment.

I took it as:
If the controller checks for the error and then does not processes the tran=
sfer due to the check, the controller is required to place an Error Event o=
n the Event ring.

Therefore, QEMU either needs to follow through with the check and place
an Error on the Event Ring *or* not do the 'check and return'.

Anyway, this is just my opinion.  Thank you for your time.
Ben

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1859378

Title:
  xhci Control Transfer requiring a Status TRB before starting transfer

Status in QEMU:
  Invalid

Bug description:
  This may not necessarily be a bug, but more of a change.

  A little background may need to be in order.

  With all USB Control transfers, there is a SETUP transfer, zero or
  more DATA transfers, and if successful, a STATUS transfer.  This
  STATUS transfer is used to indicate to the recipient that the previous
  transfers were successful.  For example, in a CONTROL IN transfer, the
  host sends a SETUP packet to the device, receives zero or more DATA
  packets, and then on successful transfer, the HOST sends the STATUS
  packet indicating to the device that all was received.

  If no DATA packets are received, the HOST is not to send a STATUS
  packet.  This could be due to a STALL or other error.

  With this in mind, the STATUS transfer, in this case an xHCI STATUS
  TRB, may not even be on the transfer ring yet.  The HOST software may
  be waiting for a successful transfer before it submits the STATUS
  transfer.

  However, if you look at the test at line 1701
  (https://git.qemu.org/?p=3Dqemu.git;a=3Dblob;f=3Dhw/usb/hcd-xhci.c#l1701),
  the current code will not start the CONTROL transfer at all if it
  doesn't see that STATUS TRB on the ring.

  In my opinion, this is in error.  It is not required that a STATUS TRB
  be on the ring to start the CONTROL transfer.  This STATUS TRB can be
  placed on the ring after a successful SETUP and zero or more DATA
  transfers followed by a ring to the door bell.  Then after a
  successful transfer to this point, placing this STATUS TRB on the ring
  and another ring to the door bell.

  In my opinion, the check at line 1701 should be removed.

  Thank you,
  Ben

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1859378/+subscriptions

