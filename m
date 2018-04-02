Received: from eggs.gnu.org ([2001:4830:134:3::10]:51380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f2y8s-0002Ki-Rx
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 08:00:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f2y8p-0000x2-Qj
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 08:00:54 -0400
Received: from indium.canonical.com ([91.189.90.7]:40440)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1f2y8p-0000vf-Jw
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 08:00:51 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1f2y8o-0005WE-7J
	for <qemu-devel@nongnu.org>; Mon, 02 Apr 2018 12:00:50 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 318752E80CC
	for <qemu-devel@nongnu.org>; Mon,  2 Apr 2018 12:00:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Apr 2018 11:50:41 -0000
From: Jason Wagner <1639983@bugs.launchpad.net>
Reply-To: Bug 1639983 <1639983@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20161108002106.20066.99780.malonedeb@soybean.canonical.com>
Message-Id: <152266984198.29145.13622210996646819100.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1639983] Re: e1000 EEPROM have bad checksum
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I'm also seeing this issue with version 2.11. Currently Intel's oldest
available is 18.4 and this version reports an invalid checksum. The
E1000.dos file when loaded doesn't recognize the emulated NIC.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1639983

Title:
  e1000 EEPROM have bad checksum

Status in QEMU:
  New

Bug description:
  I am using qemu-system-i386 to emulate FreeDOS with e1000 nic card.

  I am using Intel PRODOS v.19.0 (latest version with E1000ODI.COM file).
  E1000ODI.COM v.5.07 (140116)

  http://pclosmag.com/html/issues/201208/page11.html
  Suggest that v.4.75 (120212) was/is working.
  Oldest PRODOS available version seems now 18.5 (June 2013) which I have n=
ot tested yet.

  When running it, it detect: Slot 18, IRQ 11, Port C000.

  But complains:
  EEPROM checksum was incorrect.

  Contact your services network supplier for a replacement.

  paul@paul89473:~$ qemu-system-i386 --version
  QEMU emulator version 2.6.1 (Debian 1:2.6.1+dfsg-0ubuntu5), Copyright (c)=
 2003-2008 Fabrice Bellard
  paul@paul89473:~$

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1639983/+subscriptions
