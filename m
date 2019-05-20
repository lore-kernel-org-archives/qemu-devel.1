Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A09C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 15:06:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ACC120856
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 15:06:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ACC120856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36978 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSjrl-00023r-8q
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 11:06:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hSjqw-0001Wj-Fk
	for qemu-devel@nongnu.org; Mon, 20 May 2019 11:05:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hSjqu-0006Es-85
	for qemu-devel@nongnu.org; Mon, 20 May 2019 11:05:26 -0400
Received: from indium.canonical.com ([91.189.90.7]:33024)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hSjqu-0006D8-2q
	for qemu-devel@nongnu.org; Mon, 20 May 2019 11:05:24 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hSjqq-0001sc-4P
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 15:05:20 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 139342E80C7
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 15:05:20 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 May 2019 14:52:15 -0000
From: Greg Kurz <groug@kaod.org>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Committed; importance=Undecided;
	assignee=groug@kaod.org; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: gkurz vsyachepuz
X-Launchpad-Bug-Reporter: VsyachePuz (vsyachepuz)
X-Launchpad-Bug-Modifier: Greg Kurz (gkurz)
References: <20160515152428.9255.6201.malonedeb@gac.canonical.com>
Message-Id: <155836393597.26633.480801340914370262.malone@soybean.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18962";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 9f6286d164c59128b117469747eb4536536ef559
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1581976] Re: man qemu contains a bug in
 description of "-virtfs" command line argument
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1581976 <1581976@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fixed by the following commit:

https://github.com/qemu/qemu/commit/b44a6b09705e9e8a3005229b58de36d176020548


** Changed in: qemu
     Assignee: (unassigned) =3D> Greg Kurz (gkurz)

** Changed in: qemu
       Status: New =3D> Fix Committed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1581976

Title:
  man qemu contains a bug in description of "-virtfs" command line
  argument

Status in QEMU:
  Fix Committed

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

