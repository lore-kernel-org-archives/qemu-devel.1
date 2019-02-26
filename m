Received: from eggs.gnu.org ([209.51.188.92]:60825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gyc1w-0008Ba-36
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 07:40:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gyc1v-0006yE-5J
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 07:40:16 -0500
Received: from indium.canonical.com ([91.189.90.7]:38402)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gyc1u-0006uU-T0
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 07:40:15 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gyc1g-0005zb-1J
	for <qemu-devel@nongnu.org>; Tue, 26 Feb 2019 12:40:00 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 9F3F82E81AB
	for <qemu-devel@nongnu.org>; Tue, 26 Feb 2019 12:39:58 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 Feb 2019 12:26:19 -0000
From: Thomas Huth <1556044@bugs.launchpad.net>
Reply-To: Bug 1556044 <1556044@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160311113437.1236.81872.malonedeb@gac.canonical.com>
Message-Id: <155118397930.30908.1689473467363109067.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1556044] Re: Redox GUI hangs with 100% CPU on ARM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Which QEMU version have you been using here? Can you still reproduce the
problem with the latest upstream version of QEMU?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1556044

Title:
  Redox GUI hangs with 100% CPU on ARM

Status in QEMU:
  Incomplete

Bug description:
  Booting into Redox OS cli on ARM with qemu-system-i386 works fine.
  However, starting the Redox GUI (orbital) brings up the graphical
  interface and then starts using 100% CPU. I'd guess it's related to
  mouse detection and handling.

  The OS image is fully usable on x86.

  =

  https://www.dropbox.com/s/u6v2k9wzcuiycfo/redox-disk.img.xz?dl=3D0

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1556044/+subscriptions
