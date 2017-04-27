Received: from eggs.gnu.org ([2001:4830:134:3::10]:39385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d3lbH-00071h-0T
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 11:45:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d3lbE-0002y7-D7
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 11:44:59 -0400
Received: from indium.canonical.com ([91.189.90.7]:59634)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1d3lbE-0002xl-73
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 11:44:56 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1d3lbD-0008Hv-4z
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 15:44:55 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 20EB22E80C7
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 15:44:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Apr 2017 15:31:43 -0000
From: Thomas Huth <1090604@bugs.launchpad.net>
Reply-To: Bug 1090604 <1090604@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20121215001427.24095.85792.malonedeb@soybean.canonical.com>
Message-Id: <20170427153143.26320.7238.launchpad@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1090604] Re: RFE: Implement support for SMBIOS
 Type 41 structures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Changed in: qemu
   Importance: Undecided =3D> Wishlist

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1090604

Title:
  RFE: Implement support for SMBIOS Type 41 structures

Status in QEMU:
  New

Bug description:
  This was originally filed in Fedora bugzilla:
  https://bugzilla.redhat.com/show_bug.cgi?id=3D669955

  """
  Please extend the existing support for SMBIOS in qemu to add a capability=
 to provide "Onboard Devices Extended Information" (Type 41). Not only is t=
his replacing one of the existing types, but it also provides a mapping bet=
ween devices and physical system chassis locations. But there is no physica=
l chassis! Right. However, this doesn't mean you don't want to tell the gue=
st OS which virtual (e.g. network) interface is which. You can do that, if =
you implement this extension that is already going into real hardware, and =
likely other VMs too.

  See also page 117 of the v2.7 of the SMBIOS spec.

  FWIW, VMware ESX and Workstation expose their PCI NICs in the PCI IRQ Rou=
ting Table.  Kind of odd the first time you see it with biosdevname, as you=
r NIC becomes pci3#1, but that's "correct" from a BIOS perspective. :-)
  """

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1090604/+subscriptions
