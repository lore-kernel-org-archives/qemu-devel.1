Received: from eggs.gnu.org ([209.51.188.92]:51713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ggRdV-0006PF-PL
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 04:55:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ggRdU-0004pg-SV
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 04:55:57 -0500
Received: from indium.canonical.com ([91.189.90.7]:55630)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ggRdU-0004pO-Mk
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 04:55:56 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ggRdT-0007aR-RM
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 09:55:55 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id CD3FF2E80C8
	for <qemu-devel@nongnu.org>; Mon,  7 Jan 2019 09:55:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Jan 2019 09:36:48 -0000
From: Thomas Huth <1534382@bugs.launchpad.net>
Reply-To: Bug 1534382 <1534382@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160115001145.28422.26218.malonedeb@gac.canonical.com>
Message-Id: <154685380873.24863.3411822445144915864.malone@gac.canonical.com>
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

Looking through old bug tickets... can you still reproduce this issue
with the latest version of QEMU? Or could we close this ticket nowadays?


** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1534382

Title:
  loadvm makes Windows 7 x86 guest crash with some CPUs

Status in QEMU:
  Incomplete

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
