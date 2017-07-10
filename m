Received: from eggs.gnu.org ([2001:4830:134:3::10]:49248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dUcv7-0004HQ-4d
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 13:56:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dUcv2-0007dx-8D
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 13:56:29 -0400
Received: from indium.canonical.com ([91.189.90.7]:48331)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dUcv2-0007dD-2b
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 13:56:24 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dUcuz-0000lW-PA
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 17:56:22 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 43FCB2E826B
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 17:56:11 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Jul 2017 17:49:31 -0000
From: Michael Johnson <johnsomor@gmail.com>
Reply-To: Bug 1691109 <1691109@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <149494197837.9319.2077559864368104737.malonedeb@wampee.canonical.com>
Message-Id: <149970897186.15700.1614735111796333385.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1691109] Re: qemu-kvm not working as nested
 inside ESX 6.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

It appears that the recent qemu packages released for 16.04 set the
machine type to "pc-i440fx-zesty" instead of "pc-i440fx-xenial".  If you
override this and make it use "pc-i440fx-xenial" instances boot again.

FYI, if you are using OpenStack, this can be done by editing nova.conf,
[libvirt] section, and add hw_machine_type =3D x86_64=3Dpc-i440fx-xenial

** Changed in: qemu
       Status: New =3D> Confirmed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1691109

Title:
  qemu-kvm not working as nested inside ESX 6.0

Status in OpenStack Community Project:
  New
Status in QEMU:
  Confirmed

Bug description:
  ESX 6.0 (virt bits exposed) - Ubuntu 16.04 + qemu-kvm 1:2.8+dfsg-
  3ubuntu2~cloud0 - CirrOS launched by OpenStack (devstack master)

  =

  VM will start with -machine =3D 'pc-i440fx-zesty' and will stuck in "boot=
ing from hard disk"

  to fix it you can manually change -machine to 'pc-i440fx-2.3'

  also, ISOs boots well, so I think it`s something about block devices
  configuration introduced in new machine type.

  p.s.
  also confirmed with RHEL instead of Ubuntu as KVM host - new machine type=
 don`t work

To manage notifications about this bug go to:
https://bugs.launchpad.net/openstack-community/+bug/1691109/+subscriptions
