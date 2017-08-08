Received: from eggs.gnu.org ([2001:4830:134:3::10]:44260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dfCdR-0000yx-GX
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 18:05:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dfCdM-0004cx-Jz
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 18:05:57 -0400
Received: from indium.canonical.com ([91.189.90.7]:51517)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dfCdM-0004bA-Db
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 18:05:52 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dfCdJ-00043p-IC
	for <qemu-devel@nongnu.org>; Tue, 08 Aug 2017 22:05:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 868452E80D0
	for <qemu-devel@nongnu.org>; Tue,  8 Aug 2017 22:05:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Aug 2017 21:56:03 -0000
From: Thiago Macieira <thiago@kde.org>
Reply-To: Bug 1709170 <1709170@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150213708469.19430.16716526584783151905.malonedeb@chaenomeles.canonical.com>
Message-Id: <150222936360.11024.13892330726532626765.malone@wampee.canonical.com>
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

It was a Yocto 2.0 sysroot running on an Ubuntu 16.04 host.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1709170

Title:
  QEMU fails to honor O_TMPFILE

Status in QEMU:
  New

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
