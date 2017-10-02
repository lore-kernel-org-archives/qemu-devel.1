Received: from eggs.gnu.org ([2001:4830:134:3::10]:51215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dz5BI-0001bS-0U
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 14:11:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dz5BE-0003lR-06
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 14:11:03 -0400
Received: from indium.canonical.com ([91.189.90.7]:37856)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dz5BD-0003kK-Q7
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 14:10:59 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1dz5BB-0002xH-T2
	for <qemu-devel@nongnu.org>; Mon, 02 Oct 2017 18:10:57 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D9A2C2E80C7
	for <qemu-devel@nongnu.org>; Mon,  2 Oct 2017 18:10:57 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Oct 2017 18:00:39 -0000
From: Todd Eisenberger <1719984@bugs.launchpad.net>
Reply-To: Bug 1719984 <1719984@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150654006758.30143.16289666541182400408.malonedeb@wampee.canonical.com>
Message-Id: <150696724024.13468.17528394870247213151.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1719984] Re: wrgsbase misemulated in
 x86_64-softmmu
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
List-ID: <qemu-devel.nongnu.org>

Fix is in staging:
https://github.com/ehabkost/qemu/commit/cdcc80d41360e278b45c91de29a29d79726=
4e85d

** Changed in: qemu
       Status: New =3D> In Progress

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1719984

Title:
  wrgsbase misemulated in x86_64-softmmu

Status in QEMU:
  In Progress

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
