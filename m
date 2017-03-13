Received: from eggs.gnu.org ([2001:4830:134:3::10]:37820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cnHcz-0004TP-D6
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 00:30:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cnHcu-0006e1-Gr
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 00:30:37 -0400
Received: from indium.canonical.com ([91.189.90.7]:42268)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cnHcu-0006d9-BD
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 00:30:32 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cnHcr-0005fu-80
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 04:30:29 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 163092E80CC
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 04:30:29 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Mar 2017 04:17:43 -0000
From: Launchpad Bug Tracker <1256826@bugs.launchpad.net>
Reply-To: Bug 1256826 <1256826@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20131202092045.6379.27394.malonedeb@soybean.canonical.com>
Message-Id: <20170313041743.15305.18595.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1256826] Re: INT instruction bug in WindowsXP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1256826

Title:
  INT instruction bug in WindowsXP

Status in QEMU:
  Expired

Bug description:
  This bug is in -no-kvm mode.

  In windowsXP at IDT entry 2&8 is Task gate

  when application use INT 2 or INT 8 it will cause blue screen in XP.

  I found it should cause #GP but not generate hw interrupt.

  also I check this bug with -enable-kvm & my PC and works correctly.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1256826/+subscriptions
