Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6FCC3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 05:00:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3AE22089E
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 05:00:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3AE22089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyUM1-0004N0-3z
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 01:00:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47681)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1hyUL8-0003ZG-3c
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 00:59:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hyUL7-0000Z9-1Y
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 00:59:50 -0400
Received: from indium.canonical.com ([91.189.90.7]:51176)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hyUL6-0000Yn-SQ
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 00:59:48 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hyUL6-0002ri-1p
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2019 04:59:48 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id F28C22E80D4
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2019 04:59:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Aug 2019 04:49:10 -0000
From: Thomas Huth <1581976@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
 assignee=groug@kaod.org; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: gkurz vsyachepuz
X-Launchpad-Bug-Reporter: VsyachePuz (vsyachepuz)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <20160515152428.9255.6201.malonedeb@gac.canonical.com>
Message-Id: <156593095135.16499.6998667492255205145.launchpad@wampee.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19022";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 7fc0230f148c65895b5527e79d31f106fbde3726
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1581976] Re: man qemu contains a bug in
 description of "-virtfs" command line argument
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
Reply-To: Bug 1581976 <1581976@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1581976

Title:
  man qemu contains a bug in description of "-virtfs" command line
  argument

Status in QEMU:
  Fix Released

Bug description:
  The description of command line argument =

  https://github.com/qemu/qemu/blob/63d3145aadbecaa7e8be1e74b5d6b5cbbeb4e15=
3/qemu-options.hx#L796-L799
  looks like this:

  =C2=A0-virtfs
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fsdriver[,path=3Dpath],mount_ta=
g=3Dmount_tag[,security_model=3Dsecurity_model][,writeout=3Dwriteout][,read=
only][,socket=3Dsocket|sock_fd=3Dsock_fd]

  note, that there is no "id" attribute in the list of parameters.

  later on the man there the "id" attribute is documented, as it were
  present:

  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0id=3Did
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0Specifies identifier for this device

  i think that it was copied from above section (about "-fsdev") without
  reviewing.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1581976/+subscriptions

