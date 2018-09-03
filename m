Received: from eggs.gnu.org ([2001:4830:134:3::10]:57528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fwqt1-0005ZB-Ff
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 11:35:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fwqsx-0003i4-Ce
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 11:35:31 -0400
Received: from indium.canonical.com ([91.189.90.7]:44116)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fwqsx-0003gv-5M
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 11:35:27 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fwqsw-0002ap-Bd
	for <qemu-devel@nongnu.org>; Mon, 03 Sep 2018 15:35:26 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 551982E80CC
	for <qemu-devel@nongnu.org>; Mon,  3 Sep 2018 15:35:26 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Sep 2018 15:18:21 -0000
From: Thomas Huth <588688@bugs.launchpad.net>
Reply-To: Bug 588688 <588688@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20100602124549.9365.96865.malonedeb@soybean.canonical.com>
Message-Id: <153598790121.24667.13955487850825252290.malone@gac.canonical.com>
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

Looking through old bug tickets ... is this still an issue with the
latest version of QEMU, or could we close this ticket nowadays?

** Changed in: qemu
       Status: In Progress =3D> Incomplete

** Changed in: qemu
     Assignee: Natalia Portillo (claunia) =3D> (unassigned)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/588688

Title:
  Hard disk images are supporting ATAPI commands. They should fail.

Status in QEMU:
  Incomplete

Bug description:
  When using a hard disk image (qcow, qcow2, vdi, vmdk, bochs), the
  emulated device can be a CD-ROM and support ATAPI commands.

  These commands fails in real hard disks and these images are not
  prepared to handle optical disk formats, they should fail also.

  Only images able to handle that formats (dmg, raw, host) should work
  with ATAPI commands and CD-ROM devices.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/588688/+subscriptions
