Return-Path: <SRS0=HErD=SP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE3FC10F11
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 12:21:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82CEF2077C
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 12:21:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82CEF2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51252 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFHex-00087C-HZ
	for qemu-devel@archiver.kernel.org; Sat, 13 Apr 2019 08:21:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hFHe7-00078W-Vm
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 08:20:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hFHe6-0007xI-W0
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 08:20:35 -0400
Received: from indium.canonical.com ([91.189.90.7]:57952)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hFHe6-0007wv-Nl
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 08:20:34 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hFHe5-0003Or-La
	for <qemu-devel@nongnu.org>; Sat, 13 Apr 2019 12:20:33 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 932912E80C8
	for <qemu-devel@nongnu.org>; Sat, 13 Apr 2019 12:20:33 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 13 Apr 2019 12:14:28 -0000
From: Lukas Straub <1824622@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: lukey3332
X-Launchpad-Bug-Reporter: Lukas Straub (lukey3332)
X-Launchpad-Bug-Modifier: Lukas Straub (lukey3332)
Message-Id:
 <155515766892.14199.10108123306728671913.malonedeb@gac.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18920";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 896a53e743f9573f37c639379c41422826f86586
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1824622] [NEW] Qemu 4.0.0-rc3 COLO Primary
 Crashes with "Assertion `event_unhandled_count > 0' failed."
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
Reply-To: Bug 1824622 <1824622@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190413121428.gDKT7X0UFZwqK-IJ0QWq_dIUoqwfiWKNxVALwIwY5Dk@z>

Public bug reported:

Hello Everyone,
Now with Qemu 4.0.0-rc3, COLO is finally working so I gave it a try, but th=
e Primary is always crashing during Network use. Typing fast in ssh or runn=
ing "top" with 0.1 second delay (change with 'd') reliably trigger the cras=
h for me. I use the attached scripts to run Qemu, in my case both primary a=
nd secondary run on the same Host for testing purposes. See the files in th=
e attached .tar.bz2 for more Info, they also contain a Coredump.

Regards,
Lukas Straub

Configure CMDline:
./configure --target-list=3Dx86_64-softmmu,i386-softmmu --enable-debug-info

** Affects: qemu
     Importance: Undecided
         Status: New

** Attachment added: "attachements.tar.bz2"
   https://bugs.launchpad.net/bugs/1824622/+attachment/5255425/+files/attac=
hements.tar.bz2

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1824622

Title:
  Qemu 4.0.0-rc3 COLO Primary Crashes with "Assertion
  `event_unhandled_count > 0' failed."

Status in QEMU:
  New

Bug description:
  Hello Everyone,
  Now with Qemu 4.0.0-rc3, COLO is finally working so I gave it a try, but =
the Primary is always crashing during Network use. Typing fast in ssh or ru=
nning "top" with 0.1 second delay (change with 'd') reliably trigger the cr=
ash for me. I use the attached scripts to run Qemu, in my case both primary=
 and secondary run on the same Host for testing purposes. See the files in =
the attached .tar.bz2 for more Info, they also contain a Coredump.

  Regards,
  Lukas Straub

  Configure CMDline:
  ./configure --target-list=3Dx86_64-softmmu,i386-softmmu --enable-debug-in=
fo

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1824622/+subscriptions

