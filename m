Return-Path: <SRS0=ZZp+=TS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3660C04AAF
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 10:01:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B84AB2087B
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 10:01:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B84AB2087B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60146 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRw9z-0005Qe-Rq
	for qemu-devel@archiver.kernel.org; Sat, 18 May 2019 06:01:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hRw99-0004tm-Eb
	for qemu-devel@nongnu.org; Sat, 18 May 2019 06:00:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hRw97-0004TE-Ga
	for qemu-devel@nongnu.org; Sat, 18 May 2019 06:00:55 -0400
Received: from indium.canonical.com ([91.189.90.7]:54904)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hRw95-0004Qc-PV
	for qemu-devel@nongnu.org; Sat, 18 May 2019 06:00:52 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hRw8z-0005J7-U3
	for <qemu-devel@nongnu.org>; Sat, 18 May 2019 10:00:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id B803F2E80D6
	for <qemu-devel@nongnu.org>; Sat, 18 May 2019 10:00:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 May 2019 09:51:19 -0000
From: Lukas Straub <1824622@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
	assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: lukey3332
X-Launchpad-Bug-Reporter: Lukas Straub (lukey3332)
X-Launchpad-Bug-Modifier: Lukas Straub (lukey3332)
References: <155515766892.14199.10108123306728671913.malonedeb@gac.canonical.com>
Message-Id: <155817308009.26671.16943565132603071076.malone@soybean.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18962";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 4317e0d20bcbb2326bfc9604037c18a18ee6f240
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1824622] Re: Qemu 4.0.0-rc3 COLO Primary Crashes
 with "Assertion `event_unhandled_count > 0' failed."
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

Fix applied to qemu 4.1

** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1824622

Title:
  Qemu 4.0.0-rc3 COLO Primary Crashes with "Assertion
  `event_unhandled_count > 0' failed."

Status in QEMU:
  Fix Released

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

