Received: from eggs.gnu.org ([209.51.188.92]:55807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1h2TdQ-0001Po-NW
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 23:30:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1h2TdP-000187-Vd
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 23:30:56 -0500
Received: from indium.canonical.com ([91.189.90.7]:48712)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1h2TdP-00016y-OF
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 23:30:55 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1h2TdO-00011O-Tv
	for <qemu-devel@nongnu.org>; Sat, 09 Mar 2019 04:30:54 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id CC4D82E80C8
	for <qemu-devel@nongnu.org>; Sat,  9 Mar 2019 04:30:54 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 09 Mar 2019 04:17:35 -0000
From: Launchpad Bug Tracker <1534382@bugs.launchpad.net>
Reply-To: Bug 1534382 <1534382@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160115001145.28422.26218.malonedeb@gac.canonical.com>
Message-Id: <155210505542.19923.916418400080548636.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1534382] Re: loadvm makes Windows 7 x86 guest
 crash with some CPUs
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
https://bugs.launchpad.net/bugs/1534382

Title:
  loadvm makes Windows 7 x86 guest crash with some CPUs

Status in QEMU:
  Expired

Bug description:
  Running qemu with kvm enabled and -cpu set to some of the more "modern" C=
PUs,
  and having Windows 7 x86 as the guest.

  After guest OS loads, start some app (I started "cmd"), then do "savevm".
  After that, do some more activity (I closed cmd window and opened IE),
  then do "loadvm" of the previously saved snapshot.

  loadvm shows briefly the state that the system was in at the snapshot tim=
e,
  then guest OS crashes (blue screen).

  Originally I saw this problem on qemu 1.4.0,
  then I also tried qemu 2.5.0 and found the same problem.

  The CPUs that I tried were mostly those that support NX bit (core2duo, =

  qemu64, kvm64, Nehalem, etc.)

  If I use the default CPU, or some other like qemu32/kvm32,
  the problem does not occur.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1534382/+subscriptions
