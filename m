Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A7E8C35647
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 11:12:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5096824650
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 11:12:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5096824650
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j56EB-00066j-H4
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 06:12:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60741)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1j56DO-0005fJ-PA
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 06:11:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1j56DN-0007i3-IA
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 06:11:26 -0500
Received: from indium.canonical.com ([91.189.90.7]:38626)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1j56DN-0007gm-Cj
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 06:11:25 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1j56DL-00086Y-Tz
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 11:11:23 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id E1F4A2E80C7
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 11:11:23 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Feb 2020 10:58:19 -0000
From: Geoffrey McRae <1722884@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: gnif jens-nyberg
X-Launchpad-Bug-Reporter: Geoffrey McRae (gnif)
X-Launchpad-Bug-Modifier: Geoffrey McRae (gnif)
References: <150774787109.964.13450141235232669497.malonedeb@chaenomeles.canonical.com>
Message-Id: <158228269973.24464.10218693734899292824.malone@gac.canonical.com>
Subject: [Bug 1722884] Re: keyboard input while mouse moving triggers mouse
 failure
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="19413b719a8df7423ab1390528edadce9e0e4aca";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 78110c046027edc35dbeb973667dbc8685b709a0
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
Reply-To: Bug 1722884 <1722884@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I tracked this down and fixed it last year, your issue is unrelated.

https://github.com/qemu/qemu/commit/143c04c7e0639e53086519592ead15d2556bfbf2
#diff-3b5bd599c018d558b135bd19647a00c6

https://github.com/qemu/qemu/commit/7abe7eb29494b4e4a11ec99ae5623083409a2f1e
#diff-3b5bd599c018d558b135bd19647a00c6

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1722884

Title:
  keyboard input while mouse moving triggers mouse failure

Status in QEMU:
  New

Bug description:
  When QEMU is getting a ton of mouse input events if keys are pressed
  on the keyboard the scan code will be corrupted causing erroneous
  behavior. I have confirmed this problem in the latest version in git
  (530049bc1dcc24c1178a29d99ca08b6dd08413e0).

  After the erroneous behavior the operating system issues a keyboard
  reset which prevents the mouse from functioning until the operating
  system is restarted.

  This seems to only occur if the PS2 mouse is being used as the input,
  the tablet input device doesn't exhibit this behavior.

  The same problem was reported here also:
  https://openxt.atlassian.net/browse/OXT-562

  Host  : Debian 9
  CPU   : Ryzen 1700X
  RAM   : 16GB
  Kernel: 4.12.0-0.bpo.2-amd64

  Guest : Windows 10 (KVM)
  RAM   : 8GB (1GB Huge pages)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1722884/+subscriptions

