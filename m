Received: from eggs.gnu.org ([2001:4830:134:3::10]:45876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dxIM2-00056b-0u
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 15:50:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dxILy-0003Ag-UN
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 15:50:46 -0400
Received: from indium.canonical.com ([91.189.90.7]:60174)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dxILy-0003AN-Ns
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 15:50:42 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1dxILx-0005qE-MB
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 19:50:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id A5E772E8492
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 19:50:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 Sep 2017 19:43:49 -0000
From: Todd Eisenberger <1719984@bugs.launchpad.net>
Reply-To: Bug 1719984 <1719984@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150654006758.30143.16289666541182400408.malonedeb@wampee.canonical.com>
Message-Id: <150654142967.21822.17159393112458566226.malone@chaenomeles.canonical.com>
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

For further data, the faulting instruction is
f3 48 0f ae df          wrgsbase %rdi

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
