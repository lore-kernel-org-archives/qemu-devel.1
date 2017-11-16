Received: from eggs.gnu.org ([2001:4830:134:3::10]:59404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eFQLf-0007ZF-KP
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 15:01:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eFQLb-00038f-O3
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 15:01:19 -0500
Received: from indium.canonical.com ([91.189.90.7]:45188)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eFQLb-00033v-Ho
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 15:01:15 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eFQLZ-00034s-4S
	for <qemu-devel@nongnu.org>; Thu, 16 Nov 2017 20:01:13 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 1D8BF2E80CC
	for <qemu-devel@nongnu.org>; Thu, 16 Nov 2017 20:01:13 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Nov 2017 19:46:39 -0000
From: Todd Eisenberger <1719984@bugs.launchpad.net>
Reply-To: Bug 1719984 <1719984@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150654006758.30143.16289666541182400408.malonedeb@wampee.canonical.com>
Message-Id: <151086159962.28504.554461444809828740.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1719984] Re: wrgsbase misemulated in
 x86_64-softmmu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Fix is in master:
https://github.com/qemu/qemu/commit/e0dd5fd41a1a38766009f442967fab700d2d0550

** Changed in: qemu
       Status: In Progress =3D> Fix Committed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1719984

Title:
  wrgsbase misemulated in x86_64-softmmu

Status in QEMU:
  Fix Committed

Bug description:
  qemu revision: cfe4cade054c0e0d00d0185cdc433a9e3ce3e2e4
  command: ./qemu-system-x86_64 -m 2048 -nographic -net none -smp 4,threads=
=3D2 -machine q35 -kernel zircon.bin -cpu Haswell,+smap,-check -initrd boot=
data.bin -append 'TERM=3Dscreen kernel.halt-on-panic=3Dtrue '

  On this revision, the VM reports CPUID.07H.0H.EBX[0] =3D 1.  In this VM,
  with CR4[16] set to 1, wrgsbase triggers #UD, which mismatches the
  behavior described in Intel's instruction reference.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1719984/+subscriptions
