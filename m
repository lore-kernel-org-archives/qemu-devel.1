Received: from eggs.gnu.org ([2001:4830:134:3::10]:40078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dae6v-0003h2-RM
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 04:25:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dae6t-0004vX-5b
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 04:25:33 -0400
Received: from indium.canonical.com ([91.189.90.7]:60361)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dae6t-0004vP-06
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 04:25:31 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dae6r-0007uJ-SH
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 08:25:29 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D1E362E80D3
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 08:25:29 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Jul 2017 08:15:37 -0000
From: Thomas Huth <1352465@bugs.launchpad.net>
Reply-To: Bug 1352465 <1352465@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140804172639.7272.35067.malonedeb@chaenomeles.canonical.com>
Message-Id: <150114333786.31388.5058867357544359247.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1352465] Re: Can't install virtio block drivers
 during Windows setup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Looks like nobody replied here within the last three years ... closing
this now, since this is not directly a QEMU problem. You should likely
report it to the virtio-win driver folks instead if the problem still
persists.

** Changed in: qemu
       Status: New =3D> Invalid

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1352465

Title:
  Can't install virtio block drivers during Windows setup

Status in QEMU:
  Invalid

Bug description:
  Hi!
  Apparently there's no way to install the virtio block drivers during Wind=
ows setup, as they're simply not recognized by the installer when it looks =
for them on the CD drive.
  The only way to setup virtio block drivers is to first install Windows on=
 a IDE drive, then add a dummy virtio disk, then load the drivers and swap =
the two disks.
  I'm using virtio-win-0.1-81.iso. I can confirm the issue with Windows Ser=
ver 2012 R2 and Windows 7 Professional, 64 bit.
  Thanks!

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1352465/+subscriptions
