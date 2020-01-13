Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38C0C33CA9
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 18:04:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C49922075B
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 18:04:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C49922075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=marcansoft.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ir44s-0000KK-OW
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 13:04:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52488)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1ir2gv-0005yt-L3
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 11:35:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1ir2gu-0008Kj-5G
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 11:35:49 -0500
Received: from indium.canonical.com ([91.189.90.7]:44304)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1ir2gt-0008H3-T6
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 11:35:48 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1ir2gr-0001F7-Nv
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2020 16:35:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 9AC652E80C8
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2020 16:35:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jan 2020 16:27:03 -0000
From: Hector Martin <hector@marcansoft.com>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Invalid; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: fysnet kraxel-redhat marcan42
X-Launchpad-Bug-Reporter: Benjamin David Lunt (fysnet)
X-Launchpad-Bug-Modifier: Hector Martin (marcan42)
References: <157885971279.5587.15888635675000659382.malonedeb@gac.canonical.com>
Message-Id: <157893282333.5353.11082727892179775205.malone@gac.canonical.com>
Subject: [Bug 1859359] Re: xHCI and event ring handling
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="bceb5ef013b87ef7aafe0755545ceb689ca7ac60";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: e972d0351d6297be074972436298f8243c406684
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 91.189.90.7
X-Mailman-Approved-At: Mon, 13 Jan 2020 13:00:08 -0500
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
Reply-To: Bug 1859359 <1859359@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The part you're missing is in section 4.9.4.

> System software shall advance the Event Ring Dequeue Pointer by writing t=
he address of the last
processed Event TRB to the Event Ring Dequeue Pointer (ERDP) register. Note=
, the =E2=80=9Clast processed
Event TRB=E2=80=9D includes the case where software detects a Cycle bit mis=
match when evaluating an Event
TRB and the ring is empty.

So the bug is in your code, because it's supposed to check the next TRB,
find the cycle bit mismatch, and *that* qualifies as "processing" it,
and then it should write *that* address to the ERDP, which is going to
equal the actual last valid TRB's address + 1 (modulo wraparound), which
is exactly what qemu expects, and what Linux does too.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1859359

Title:
  xHCI and event ring handling

Status in QEMU:
  Invalid

Bug description:
  I believe that the Event Ring handling in QEMU is not correct.  For
  example, an Event Ring may have multiple segments.  However, the code
  in xhci_write_event()
  (https://git.qemu.org/?p=3Dqemu.git;a=3Dblob;f=3Dhw/usb/hcd-
  xhci.c;hb=3DHEAD#l645), starting with line 668, seems to only support a
  single segment.

  Also, QEMU is sending a spurious interrupt after the Guest writes to
  the ERDP register due to the fact that the address written does not
  match the current index.  This is because the index is incremented
  after sending the event.  The xHCI specification states in section
  5.5.2.3.3 "When software finishes processing an Event TRB, it will
  write the address of that Event TRB to the ERDP."

  Since xhci_write_event() has already incremented the index pointer
  (intr->er_ep_idx), the check at line 3098
  (https://git.qemu.org/?p=3Dqemu.git;a=3Dblob;f=3Dhw/usb/hcd-
  xhci.c;hb=3DHEAD#l3090) no longer is valid.

  I have not studied QEMU's code enough yet to offer a patch.  However,
  this should be a simple fix.

  intr->er_ep_idx++;
  if (intr->er_ep_idx >=3D intr->er_table[intr->er_segment].er_size) {
    intr->er_ep_idx =3D 0;
    intr->er_segment++;
    if (intr->er_segment >=3D intr->er_table_size) {
      intr->er_segment =3D 0;
      intr->er_pcs =3D !intr->er_pcs;
    }
  }

  Being sure to incorporate this new segment member into the above code
  (possibly as shown) as well as change the lines at 665 to use the new
  segment member of the structure, and of course in the initialization
  portion of the event ring.

  As for the spurious interrupt at line 3101, a new member will need to
  be added to the code to keep track of the last inserted ED (TRB) into
  the Event Ring and then of course checking against this new member,
  not the now newly incremented member.

  I have sent an email to the author listed at the top of the file as
  well, not sure if this is proper bug reporting etiquette or not.

  Thank you.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1859359/+subscriptions

