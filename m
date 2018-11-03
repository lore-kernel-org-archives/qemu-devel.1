Received: from eggs.gnu.org ([2001:4830:134:3::10]:55649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gInaC-0007OX-77
	for qemu-devel@nongnu.org; Sat, 03 Nov 2018 00:30:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gInaB-0002DP-3H
	for qemu-devel@nongnu.org; Sat, 03 Nov 2018 00:30:48 -0400
Received: from indium.canonical.com ([91.189.90.7]:60048)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gInaA-00025j-PO
	for qemu-devel@nongnu.org; Sat, 03 Nov 2018 00:30:46 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gIna3-0006mi-0s
	for <qemu-devel@nongnu.org>; Sat, 03 Nov 2018 04:30:39 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id F236D2E80C8
	for <qemu-devel@nongnu.org>; Sat,  3 Nov 2018 04:30:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Nov 2018 04:17:19 -0000
From: Launchpad Bug Tracker <588688@bugs.launchpad.net>
Reply-To: Bug 588688 <588688@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20100602124549.9365.96865.malonedeb@soybean.canonical.com>
Message-Id: <154121863997.11376.5239361951732188536.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 588688] Re: Hard disk images are supporting ATAPI
 commands. They should fail.
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
https://bugs.launchpad.net/bugs/588688

Title:
  Hard disk images are supporting ATAPI commands. They should fail.

Status in QEMU:
  Expired

Bug description:
  When using a hard disk image (qcow, qcow2, vdi, vmdk, bochs), the
  emulated device can be a CD-ROM and support ATAPI commands.

  These commands fails in real hard disks and these images are not
  prepared to handle optical disk formats, they should fail also.

  Only images able to handle that formats (dmg, raw, host) should work
  with ATAPI commands and CD-ROM devices.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/588688/+subscriptions
