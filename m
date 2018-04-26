Received: from eggs.gnu.org ([2001:4830:134:3::10]:51292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fBicV-0006DY-9L
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 11:15:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fBicQ-0002RT-8F
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 11:15:39 -0400
Received: from indium.canonical.com ([91.189.90.7]:58700)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fBicP-0002R2-Ow
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 11:15:34 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fBicO-0007Bm-Ot
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 15:15:32 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id B4BC72E804E
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 15:15:32 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Apr 2018 15:05:34 -0000
From: Thomas Huth <1767126@bugs.launchpad.net>
Reply-To: Bug 1767126 <1767126@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152475251964.6950.2732473928297665160.malonedeb@chaenomeles.canonical.com>
Message-Id: <152475513517.21887.14925923572522182237.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1767126] Re: Man page documents qemu -drive
 if=scsi but it no longer works
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The -drive if=3Dscsi still works on the machines that have a SCSI bus by
default. And the change for x86 has been documented in the ChangeLog:
https://wiki.qemu.org/ChangeLog/2.12

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1767126

Title:
  Man page documents qemu -drive if=3Dscsi but it no longer works

Status in QEMU:
  New

Bug description:
  The qemu man page section documenting the -drive option contains

             if=3Dinterface
                 This option defines on which type on interface the drive is
                 connected.  Available types are: ide, scsi, sd, mtd, flopp=
y,
                 pflash, virtio, none.

  but if=3Dscsi no longer works as of version 2.12.0.

  If you really have to make backwards incompatible changes, it would be
  helpful if you could at least document them.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1767126/+subscriptions
