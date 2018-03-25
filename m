Received: from eggs.gnu.org ([2001:4830:134:3::10]:60622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ezxIO-00080s-FM
	for qemu-devel@nongnu.org; Sun, 25 Mar 2018 00:30:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ezxIL-0002RY-AX
	for qemu-devel@nongnu.org; Sun, 25 Mar 2018 00:30:16 -0400
Received: from indium.canonical.com ([91.189.90.7]:55706)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ezxIL-0002Qw-4F
	for qemu-devel@nongnu.org; Sun, 25 Mar 2018 00:30:13 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ezxIK-0002fp-3Y
	for <qemu-devel@nongnu.org>; Sun, 25 Mar 2018 04:30:12 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 1838D2E806B
	for <qemu-devel@nongnu.org>; Sun, 25 Mar 2018 04:30:12 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Mar 2018 04:17:35 -0000
From: Launchpad Bug Tracker <1185311@bugs.launchpad.net>
Reply-To: Bug 1185311 <1185311@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130529082251.26644.90536.malonedeb@chaenomeles.canonical.com>
Message-Id: <152195145619.15147.13440475964933106174.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1185311] Re: could not hot-remove disabled NIC
 from Win2012 guest by 'devel_del id1'
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
https://bugs.launchpad.net/bugs/1185311

Title:
  could not hot-remove disabled NIC from Win2012 guest by 'devel_del
  id1'

Status in QEMU:
  Expired

Bug description:
  # qemu-latest-upstream -mon chardev=3Dqmp,mode=3Dcontrol,pretty=3Don \
   -chardev socket,id=3Dqmp,host=3Dlocalhost,port=3D1234,server,nowait -vnc=
 :0 \
   -monitor stdio /images/win2012-64-virtio.qcow2 \
   -device virtio-net-pci,netdev=3Dndev1,id=3Did1 -netdev tap,id=3Dndev1 \
   -device e1000,netdev=3Dndev2,id=3Did2 -netdev tap,id=3Dndev2 \
   -device rtl8139,netdev=3Dndev3,id=3Did3 -netdev tap,id=3Dndev3 \
   -smp 4 -m 3000 -usbdevice tablet

  If disable nic in guest's "Network Connections" panel, nic could not
  be hot-removed through qemu monitor.

  1) if disable nic in guest
  (qemu) devel_del id1 (nic still in "Network Connections". if enable nic, =
nic can work)
  (qemu) devel_del id1
  (qemu) devel_del id1

  2) if enable nic in guest
  (qemu) devel_del id1 (nic will be removed, disappear from "Network Connec=
tions")
  (qemu) devel_del id1
  Device 'id1' not found

  Could not reproduced this problem with all linux guests & other Windows g=
uests
  Problem exists with virtio-nic/e1000/rtl8139, it seems the problem of pci=
-hotplug in piix4.

  Could not reproduce this problem with Vmware + win2012 guest.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1185311/+subscriptions
