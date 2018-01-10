Received: from eggs.gnu.org ([2001:4830:134:3::10]:53262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eZOpJ-0006W5-RF
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 17:26:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eZOpI-000432-CK
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 17:26:29 -0500
Received: from indium.canonical.com ([91.189.90.7]:51122)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eZOpI-00042P-6m
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 17:26:28 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eZOpG-0002l6-08
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 22:26:26 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 486102E8597
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 22:19:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jan 2018 22:06:03 -0000
From: Thomas Huth <1173490@bugs.launchpad.net>
Reply-To: Bug 1173490 <1173490@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130427071354.27973.42206.malonedeb@chaenomeles.canonical.com>
Message-Id: <151562196362.23838.12609820113827243329.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1173490] Re: virtio net adapter driver with kvm
 slow on winxp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Triaging old bug tickets... can you still reproduce this issue with the
latest version of QEMU? Or could we close this ticket nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1173490

Title:
  virtio net adapter driver with kvm slow on winxp

Status in QEMU:
  Incomplete

Bug description:
  # lsb_release -a
  No LSB modules are available.
  Distributor ID: Ubuntu
  Description:    Ubuntu 12.04.1 LTS
  Release:        12.04
  Codename:       precise

  #virsh version =

  Compiled against library: libvirt 1.0.4
  Using library: libvirt 1.0.4
  Using API: QEMU 1.0.4
  Running hypervisor: QEMU 1.2.0

  windows xp clean install with spice-guest-tools-0.52.exe from
    http://spice-space.org/download/windows/spice-guest-tools/spice-guest-t=
ools-0.52.exe

  it comes very slow , and the Interrupts process got very high cpu usage(a=
bove 60%).
  when i switch the net adapter from virtio to default(rtl8139) ,it works w=
ell.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1173490/+subscriptions
