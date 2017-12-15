Received: from eggs.gnu.org ([2001:4830:134:3::10]:54670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ePsBF-0002FO-Fm
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 10:45:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ePsBA-0006oS-QN
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 10:45:45 -0500
Received: from indium.canonical.com ([91.189.90.7]:44328)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ePsBA-0006mp-K0
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 10:45:40 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ePsB9-00078W-1l
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 15:45:39 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 0C0342E80D1
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 15:45:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 Dec 2017 15:36:34 -0000
From: Thomas Huth <1709170@bugs.launchpad.net>
Reply-To: Bug 1709170 <1709170@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150213708469.19430.16716526584783151905.malonedeb@chaenomeles.canonical.com>
Message-Id: <151335219422.9940.343560924642269373.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1709170] Re: QEMU fails to honor O_TMPFILE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Fix has been released with QEMU 2.11:
https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D5f9cee46cd4ec4600e1a

** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1709170

Title:
  QEMU fails to honor O_TMPFILE

Status in QEMU:
  Fix Released

Bug description:
  When making a call like

    open("/tmp", O_TMPFILE | O_RDWR);

  under QEMU, we ged -EISDIR.

  Under any kernel 3.11 or later, we are supposed to get an unnamed file
  in /tmp. In case the filesystem for /tmp does not support unnamed
  files, we are supposed to get EOPNOTSUPP.

  [I don't know the QEMU version, since this happened in a system I
  don't have access to]

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1709170/+subscriptions
