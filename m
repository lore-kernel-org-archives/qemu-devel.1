Received: from eggs.gnu.org ([2001:4830:134:3::10]:32791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f76kf-0001Hj-5D
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 18:01:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f76kc-0002XK-7V
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 18:01:01 -0400
Received: from indium.canonical.com ([91.189.90.7]:38122)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1f76kc-0002Ws-1N
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 18:00:58 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1f76ka-0003to-Pb
	for <qemu-devel@nongnu.org>; Fri, 13 Apr 2018 22:00:56 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C07512E80CD
	for <qemu-devel@nongnu.org>; Fri, 13 Apr 2018 22:00:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Apr 2018 21:43:10 -0000
From: Thomas Huth <1423668@bugs.launchpad.net>
Reply-To: Bug 1423668 <1423668@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150219192049.20629.3164.malonedeb@gac.canonical.com>
Message-Id: <152365579103.31927.12853900222505664630.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1423668] Re: Unable to set scsi drive serial if
 it contains spaces.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This error message comes from libvirt, not from QEMU, so please report
the error there if it still persists: https://libvirt.org/bugs.html

** Changed in: qemu
       Status: New =3D> Invalid

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1423668

Title:
  Unable to set scsi drive serial if it contains spaces.

Status in QEMU:
  Invalid
Status in qemu-kvm:
  New

Bug description:
  I am virtualzing a physical server for which I need to set the
  SCSI/SATA drive serial.  It is comprised of 12 " " spaces then 8
  letter/digits.  If I exclude the spaces, the drive serial is not
  accurate.  If I include the spaces I get the following error.

  error: Failed to start domain test1
  error: internal error: driver serial '            ABCD1234' contains unsa=
fe characters

  virsh edit
  Centos 7.0
  3.19.0-1.el7.elrepo.x86_64
  QEMU emulator version 1.5.3 (qemu-kvm-1.5.3-60.el7.centos.7), Copyright (=
c) 2003-2008 Fabrice Bellard

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1423668/+subscriptions
