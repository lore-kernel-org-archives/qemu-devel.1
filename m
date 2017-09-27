Received: from eggs.gnu.org ([2001:4830:134:3::10]:39685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dxI34-0008NH-Tl
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 15:31:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dxI2t-0006K6-Fr
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 15:31:05 -0400
Received: from indium.canonical.com ([91.189.90.7]:54456)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dxI2t-0006J6-A3
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 15:30:59 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1dxI2q-0001j2-Tp
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 19:30:56 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 984BB2E849D
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 19:30:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 Sep 2017 19:21:07 -0000
From: Todd Eisenberger <1719984@bugs.launchpad.net>
Reply-To: Bug 1719984 <1719984@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <150654006758.30143.16289666541182400408.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1719984] [NEW] wrgsbase misemulated in
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

Public bug reported:

qemu revision: cfe4cade054c0e0d00d0185cdc433a9e3ce3e2e4
command: ./qemu-system-x86_64 -m 2048 -nographic -net none -smp 4,threads=
=3D2 -machine q35 -kernel zircon.bin -cpu Haswell,+smap,-check -initrd boot=
data.bin -append 'TERM=3Dscreen kernel.halt-on-panic=3Dtrue '

On this revision, the VM reports CPUID.07H.0H.EBX[0] =3D 1.  In this VM,
with CR4[16] set to 1, wrgsbase triggers #UD, which mismatches the
behavior described in Intel's instruction reference.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1719984

Title:
  wrgsbase misemulated in x86_64-softmmu

Status in QEMU:
  New

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
