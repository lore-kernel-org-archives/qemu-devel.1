Received: from eggs.gnu.org ([2001:4830:134:3::10]:53361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fTWTS-0003Oi-PN
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 13:55:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fTWTQ-0006p1-Np
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 13:55:54 -0400
Received: from indium.canonical.com ([91.189.90.7]:58412)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fTWTQ-0006on-Gj
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 13:55:52 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fTWTP-0005bR-ES
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 17:55:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 687F52E80CE
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 17:55:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 Jun 2018 17:44:04 -0000
From: Thomas Huth <1386478@bugs.launchpad.net>
Reply-To: Bug 1386478 <1386478@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20141028013928.8160.30202.malonedeb@chaenomeles.canonical.com>
Message-Id: <152899824421.25456.11671005929208476199.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1386478] Re: PS/2 keyboard returns incorrect scan
 code for F7 to guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I think this has been fixed by:
https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D8c10e0baf0260b5
... so closing this ticket now. If you still have trouble, please re-open i=
t.

** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1386478

Title:
  PS/2 keyboard returns incorrect scan code for F7 to guest

Status in QEMU:
  Fix Released

Bug description:
  Using qemu 2.1 as supplied in Debian jessie, the F7 scan code (scan
  set 2) is being returned by qemu to the guest as 0x02, and not the
  correct value of 0x83.  (I assume 0x83 is correct, given that I cannot
  locate any scan set 2 charts that use any other value for F7.
  Including those published by Microsoft.)

  I see the map in hw/input/ps2.c ps2_raw_keycode[] using the correct
  values, starting at F1:  5, 6, 4, 12 (0x0C). 3. 11 (0x0B), 2, 10
  (0x0A), 1, 9, ... but nowhere in that map do I see 131 (0x83).

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1386478/+subscriptions
