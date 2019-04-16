Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1648C10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 12:02:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F58C20821
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 12:02:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F58C20821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35706 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGMmx-00081b-8O
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 08:02:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hGMln-0007Rz-VW
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:01:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hGMlm-0008UJ-NX
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:00:59 -0400
Received: from indium.canonical.com ([91.189.90.7]:38070)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hGMll-0008Tu-M6
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:00:57 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hGMlk-0001dI-J1
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 12:00:56 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 863122E806D
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 12:00:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Apr 2019 11:47:33 -0000
From: =?utf-8?q?J=C3=B6rg_Vehlow?= <1423124@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
	assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: mofx stefanha sugar9032039 ugop
X-Launchpad-Bug-Reporter: Ugo (ugop)
X-Launchpad-Bug-Modifier: =?utf-8?q?J=C3=B6rg_Vehlow_=28mofx=29?=
References: <20150218112959.10810.54623.malonedeb@chaenomeles.canonical.com>
Message-Id: <155541525337.13876.7738948035284335852.malone@gac.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18920";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 4e4953f51bee47da07664b849dff0517a9d6221d
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1423124] Re: QEMU crash after sending data on
 host serial port
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
Reply-To: Bug 1423124 <1423124@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190416114733.IeJe0uBEosZmVmPUFXS_iaz0sgz-QVS-2xcvtw7L6Yg@z>

Looks like the bug still exists. Sending eg "CTRL+D" or Arrow up/down
makes qemu hang indefinitely

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1423124

Title:
  QEMU crash after sending data on host serial port

Status in QEMU:
  Fix Released

Bug description:
  Good morning,

  I'm using QEMU for Windows last version.
  The host system is Windows 7 64bits.
  I'm excuting the following statment :

  qemu-system-x86_64w.exe -hda debian.img -m 256 -net nic -net
  tap,ifname=3DTAP32 -soundhw all -serial COM9

  Qemu starts the emulated Debian and it runs correctly.

  If I try to send data from Windows using COM9 to QEMU (both "real" or emu=
lated by the COM0COM driver), QEMU crashes. Windows dump available if requi=
red.
  If I try to send data to /dev/ttyS0 (that should be the Linux side of COM=
9) from Debian, again, the wirtual machine crashes.

  More details if necessary
  Best regards
  U.Poddine

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1423124/+subscriptions

