Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD39C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 04:37:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E91DB218FE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 04:37:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E91DB218FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35568 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJ9ef-0003MG-Pa
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 00:37:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hJ9dE-0002IL-N4
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 00:35:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hJ9Yw-00031F-0X
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 00:31:15 -0400
Received: from indium.canonical.com ([91.189.90.7]:59726)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hJ9Yu-0002xD-35
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 00:31:12 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hJ9Yq-0007cl-7k
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 04:31:08 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 314DB2E806F
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 04:31:08 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Apr 2019 04:17:33 -0000
From: Launchpad Bug Tracker <1548166@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Expired; importance=Undecided;
	assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: janitor sugar9032039 th-huth
X-Launchpad-Bug-Reporter: Sugar (sugar9032039)
X-Launchpad-Bug-Modifier: Launchpad Janitor (janitor)
References: <20160222033240.1894.82255.malonedeb@wampee.canonical.com>
Message-Id:
 <155607945409.22348.8935329774832677919.malone@loganberry.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18928";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 2f411df9b14ca1dc045e9025aeab1f06e341a462
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1548166] Re: QEMU crash after send data from Host
 through serial port
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
Reply-To: Bug 1548166 <1548166@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190424041733.N3g07NfnbpDN8lbaG82LYKelasauOQp1i4meLwe7kgs@z>

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1548166

Title:
  QEMU crash after send data from Host through serial port

Status in QEMU:
  Expired

Bug description:
  Hi All

  I have two computer, one is Win7 32 another is Win7 64, Both computer mee=
t this issue.
  My QEMU version is qemu-w32-setup-20160215

  I want used EDK2 OVMF with Intel UDK Debugger tools to do source level de=
bug
  I had install com0com Virtual Com Port, and set COM3 connect to COM4

  Intel UDK Debugger tools used COM3
  QEMU run OVMF used COM4

  First execute Intel UDK Debugger tools, then launch QEMU
  C:\Program Files\qemu\qemu-system-x86_64.exe -bios "C:\EDK2\Build\OvmfX64=
\DEBUG_VS2010\FV\OVMF.fd" -serial COM4
  Then QEMU crashes on stratup

  I have do some experiment
  Execute terminal tool Tera Term and used COM3
  launch QEMU and used COM4
  C:\Program Files\qemu\qemu-system-x86_64.exe -bios "C:\EDK2\Build\OvmfX64=
\DEBUG_VS2010\FV\OVMF.fd" -serial COM4
  This is fine and i can see OVMF trace log on terminal
  But if i press "Down" key on terminal, then QEMU crashe
  It's caused by terminal send data("Down" key) to QEMU

  Have somebody can share some information about this?

  Thanks a lot.
  Sugar

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1548166/+subscriptions

