Received: from eggs.gnu.org ([2001:4830:134:3::10]:40290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fhSVB-00032f-AT
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 00:31:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fhSVA-0000Tj-D0
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 00:31:17 -0400
Received: from indium.canonical.com ([91.189.90.7]:38806)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fhSVA-0000Qv-5u
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 00:31:16 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fhSV7-0006rU-4N
	for <qemu-devel@nongnu.org>; Mon, 23 Jul 2018 04:31:13 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id ACFC62E8179
	for <qemu-devel@nongnu.org>; Mon, 23 Jul 2018 04:31:12 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Jul 2018 04:17:17 -0000
From: Launchpad Bug Tracker <1353947@bugs.launchpad.net>
Reply-To: Bug 1353947 <1353947@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140807104056.23920.38524.malonedeb@wampee.canonical.com>
Message-Id: <153231943733.16639.11662821455500541861.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1353947] Re: Hypervisor with QEMU-2.0/libvirtd
 1.2.2 stack when launching VM with CirrOS or Ubuntu 12.04
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
https://bugs.launchpad.net/bugs/1353947

Title:
  Hypervisor with QEMU-2.0/libvirtd 1.2.2 stack when launching VM with
  CirrOS or Ubuntu 12.04

Status in QEMU:
  Expired
Status in linux package in Ubuntu:
  Expired

Bug description:
  The issue observed when running an hypervisor with QEMU 2.0/libvirtd 1.2.2
  The VM network interface is attached to a PCI virtual function (SR-IOV).

  When we ran VM with guest OS CirrOS or Ubuntu 12.04 we observed an hiperv=
isor hang shortly after the VM is loaded
  We observed the same issue with Mellanox NIC and with Intel NIC

  We=E2=80=99ve tried few combinations of {GuestOS}X{Hypervisor} and we got=
 the following findings:
  When a hypervisor is running QEMU 1.5/libvirtd 1.1.1 - no issue observed
  When a hypervisor is running QEMU 2.0/libvirtd 1.2.2 - CirrOS and Ubuntu =
12.04 guest OSes caused hypervisor hang
  When a hypervisor is running QEMU 2.0/libvirtd 1.2.2 - CentOS 6.4 and Ubu=
ntu 13.10 - no issue observed

  The problematic guest OSes are with kernel versions ~3.2.y

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1353947/+subscriptions
