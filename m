Received: from eggs.gnu.org ([2001:4830:134:3::10]:46075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fGMIW-0004pn-Bn
	for qemu-devel@nongnu.org; Wed, 09 May 2018 06:26:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fGMIS-0001tk-AK
	for qemu-devel@nongnu.org; Wed, 09 May 2018 06:26:12 -0400
Received: from indium.canonical.com ([91.189.90.7]:47588)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fGMIS-0001re-53
	for qemu-devel@nongnu.org; Wed, 09 May 2018 06:26:08 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fGMIQ-0006uT-L6
	for <qemu-devel@nongnu.org>; Wed, 09 May 2018 10:26:06 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 9D1D82E80C9
	for <qemu-devel@nongnu.org>; Wed,  9 May 2018 10:26:06 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 May 2018 10:15:10 -0000
From: Thomas Huth <1445633@bugs.launchpad.net>
Reply-To: Bug 1445633 <1445633@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150417192044.16261.51463.malonedeb@soybean.canonical.com>
Message-Id: <152586091103.6712.16978598227816135465.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1445633] Re: Creating a passthrough USB device
 causes excessive CPU usage in the guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Looking through old bug tickets... can you still reproduce this issue
with the latest version of QEMU? Or could we close this ticket nowadays?


** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1445633

Title:
  Creating a passthrough USB device causes excessive CPU usage in the
  guest

Status in QEMU:
  Incomplete

Bug description:
  My host machine is a Lenovo X1 Carbon (3rd gen) laptop running 64-bit Ubu=
ntu Linux 14.04.  My guest machine is running 64-bit Ubuntu Linux 12.04.  M=
y QEMU was compiled moments ago from the git repository, and it says its ve=
rsion is:
  qemu-x86_64 version 2.2.93, Copyright (c) 2003-2008 Fabrice Bellard

  My issue is that when I create a passthrough for a USB host device to
  the guest, it causes qemu's CPU utilization on the host to increase
  significantly and stay there.  After the passthrough is created,
  qemu's CPU usage in top hovers between 20% and 30% (evenly spread
  across CPUs).  In virt-manager's CPU usage chart, it shows the guest's
  CPU usage growing from 0% to about 5%, although running "top" in the
  guest does not show an increase in CPU usage.  These usage levels drop
  back down to normal (0 to 1%) only after I physically unplug the
  device or remove the passthrough mapping.

  It doesn't seem to matter what the device is.  I have tested it using:
  A Realtek rtl8192cu-based 802.11n adapter
  An HP optical mouse
  A Samsung Galaxy S5 phone

  The behavior is the same regardless of device, and they otherwise seem
  to work properly in the guest machine.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1445633/+subscriptions
