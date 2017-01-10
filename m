Received: from eggs.gnu.org ([2001:4830:134:3::10]:34119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cQsYe-00058s-N8
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 04:17:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cQsYa-0003dO-UT
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 04:17:32 -0500
Received: from indium.canonical.com ([91.189.90.7]:54005)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cQsYa-0003cI-PJ
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 04:17:28 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cQsYZ-0006LA-FY
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 09:17:27 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id EF1822E80D9
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 09:17:26 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Jan 2017 08:56:17 -0000
From: Thomas Huth <589827@bugs.launchpad.net>
Reply-To: Bug 589827 <589827@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20100604184053.4709.16201.malonedeb@soybean.canonical.com>
Message-Id: <20170110085617.21476.60418.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 589827] Re: QEMU netdev tap type id name is not
 used on linux host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The "id=3D..." is only the QEMU-internal name of the netdev, not the name
of the tap device. So this is not a bug --> closing this ticket.

** Changed in: qemu
       Status: New =3D> Invalid

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/589827

Title:
  QEMU netdev tap type id name is not used on linux host

Status in QEMU:
  Invalid

Bug description:
  Tested with 0.12.3, 0.12.4, and latest git as of 4 jun 2010.
  The new -netdev type seems to ignore manual specifications of tap ifname.

      qemu-system-x86_64 -hda disk.img -netdev tap,id=3Dids_e0 -device e100=
0,netdev=3Dids_e0
   **creates tap0 instead of ids_e0.  tap0 passes traffic, ids_e0 doesn't e=
xist
  (I tried -netdev type=3Dtap as well for brevity)

  QEMU creates a tap0 (or appropriate) interface and does not name this
  "ids_e0" as would be expected.  I also tried 'pre' creating the tap
  interface.

  Previous alterantive was
      qemu-system-x86_64 -hda disk.img -net nic,model=3De1000,vlan=3D99 -ne=
t tap,ifname=3Dids_e0,vlan=3D99 =

    **creates ids_e0 as expected, and passes traffic as expected.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/589827/+subscriptions
