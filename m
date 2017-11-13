Received: from eggs.gnu.org ([2001:4830:134:3::10]:43412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eE6Nr-0005EA-VC
	for qemu-devel@nongnu.org; Sun, 12 Nov 2017 23:30:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eE6Nn-0001YA-Tb
	for qemu-devel@nongnu.org; Sun, 12 Nov 2017 23:30:07 -0500
Received: from indium.canonical.com ([91.189.90.7]:33522)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eE6Nn-0001Wj-NO
	for qemu-devel@nongnu.org; Sun, 12 Nov 2017 23:30:03 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eE6Nl-0003Xm-CL
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 04:30:01 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 5A7C72E80C3
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 04:30:01 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Nov 2017 04:17:22 -0000
From: Launchpad Bug Tracker <888016@bugs.launchpad.net>
Reply-To: Bug 888016 <888016@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20111109115824.7938.15673.malonedeb@chaenomeles.canonical.com>
Message-Id: <151054664311.17693.6509638852335223279.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 888016] Re: RHEL 6.1 guest fails to boot with
 vhost
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
https://bugs.launchpad.net/bugs/888016

Title:
  RHEL 6.1 guest fails to boot with vhost

Status in QEMU:
  Expired

Bug description:
  Tried to boot 6.1 guest on hs22 blade with/without  vhost enabled.

  With vhost enabled,  guest aborted with core dump.

  installed guest with autotest.    =

  Command : =

  /usr/local/bin/qemu-system-x86_64 -name 'vm1' -nodefaults -vga std -monit=
or unix:'/tmp/monitor-humanmonitor1-20111108-193209-fc6O',server,nowait -se=
rial unix:'/tmp/serial-20111108-193209-fc6O',server,nowait -drive file=3D'/=
home/pradeep/autotest/client/tests/kvm/images/rhel6.1-64.qed',index=3D0,if=
=3Dvirtio,cache=3Dnone -device virtio-net-pci,netdev=3DidQhUaOc,mac=3D'9a:b=
7:ea:c9:0e:0d',id=3D'idVR6XQz' -netdev tap,id=3DidQhUaOc,vhost=3Don,script=
=3D/home/pradeep/qemu-ifup-latest -m 1024 -smp 8 -vnc :0 -monitor stdio
  QEMU 0.15.91 monitor - type 'help' for more information
  (qemu) Aborted (core dumped)

  =

  host:

  2.6.32-214
  m/c: hs22
  vhost modules are loaded.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/888016/+subscriptions
