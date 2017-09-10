Received: from eggs.gnu.org ([2001:4830:134:3::10]:58968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dqttZ-0003hz-Cn
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 00:30:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dqttW-0003Of-9z
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 00:30:57 -0400
Received: from indium.canonical.com ([91.189.90.7]:42830)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dqttW-0003Nq-3P
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 00:30:54 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dqttV-0000t3-1A
	for <qemu-devel@nongnu.org>; Sun, 10 Sep 2017 04:30:53 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id F29492E8488
	for <qemu-devel@nongnu.org>; Sun, 10 Sep 2017 04:30:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 10 Sep 2017 04:17:48 -0000
From: Launchpad Bug Tracker <1089006@bugs.launchpad.net>
Reply-To: Bug 1089006 <1089006@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20121211164913.12221.91398.malonedeb@soybean.canonical.com>
Message-Id: <150501706896.27827.5660993393314358059.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1089006] Re: Qemu scrambles order of eth devices
 in vm
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
https://bugs.launchpad.net/bugs/1089006

Title:
  Qemu scrambles order of eth devices in vm

Status in QEMU:
  Expired

Bug description:
  HV =3D 12.04 LTS plus libvirt 1.0x
  VM =3D 12.04 LTS

  On the HV there are 12 eth interfaces which we make available to the
  VM. We have 4 10G virtual function interfaces, and 8 1G conventionally
  bridged interfaces. No matter what order we present the interfaces in
  the xml file, they come up in eth0-eth11 order on the VM as follows:
  ( the interfcaes do work, once you figure out which is which)

  eth0-eth7 not in order as compoared to the bridges on the HV (interfaces =
file) or compared to the xml file for the VM, or compared to the bus number=
s. MAC addresses are random.
  eth8-eth11 show up in the VM  in order of PCU bus numbers just as you'd e=
xpect, always after the bridged interfaces.

  Consulting the libvirt mailing list, the developer says they present
  the list in bus order to qemu, but qemu scrambles that order. That
  appears to me too, to be the case.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1089006/+subscriptions
