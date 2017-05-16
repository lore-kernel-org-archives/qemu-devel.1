Received: from eggs.gnu.org ([2001:4830:134:3::10]:38017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dAcs4-0005os-O2
	for qemu-devel@nongnu.org; Tue, 16 May 2017 09:50:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dAcs0-0002Ur-SF
	for qemu-devel@nongnu.org; Tue, 16 May 2017 09:50:40 -0400
Received: from indium.canonical.com ([91.189.90.7]:51227)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dAcs0-0002TR-N6
	for qemu-devel@nongnu.org; Tue, 16 May 2017 09:50:36 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dAcrz-00016D-Fk
	for <qemu-devel@nongnu.org>; Tue, 16 May 2017 13:50:35 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 75FB02E807D
	for <qemu-devel@nongnu.org>; Tue, 16 May 2017 13:50:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 May 2017 13:44:57 -0000
From: fxpester <a.yurtaykin@gmail.com>
Reply-To: Bug 1691109 <1691109@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <149494197837.9319.2077559864368104737.malonedeb@wampee.canonical.com>
Message-Id: <149494229768.14889.17505440835309980951.launchpad@chaenomeles.canonical.com>
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

** Also affects: openstack-community
   Importance: Undecided
       Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1691109

Title:
  qemu-kvm not working as nested inside ESX 6.0

Status in OpenStack Community Project:
  New
Status in QEMU:
  New

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
