Received: from eggs.gnu.org ([2001:4830:134:3::10]:41446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cHSv6-0005iW-1E
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 05:05:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cHSv2-0006GS-Sg
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 05:05:48 -0500
Received: from indium.canonical.com ([91.189.90.7]:40954)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cHSv2-0006F7-Mj
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 05:05:44 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cHSv1-0006hV-Ix
	for <qemu-devel@nongnu.org>; Thu, 15 Dec 2016 10:05:43 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 700642E80C3
	for <qemu-devel@nongnu.org>; Thu, 15 Dec 2016 10:05:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Dec 2016 09:59:38 -0000
From: Stefan Hajnoczi <1650175@bugs.launchpad.net>
Reply-To: Bug 1650175 <1650175@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20161215084056.19927.66069.malonedeb@gac.canonical.com>
Message-Id: <20161215095938.20195.81474.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1650175] Re: wrong version in 2.8.0-rc03
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This is intentional and is the way that QEMU release candidates are
versioned.

The versioning scheme is MAJOR.MINOR.PATCH where:

0 >=3D PATCH < 90 is a stable release
PATCH =3D 90 is the development window for the next MINOR release
91 >=3D PATCH <=3D 99 is a release candidate for the next MINOR release

This means 2.7.93 is release candidate 3 for 2.8.

I suppose one reason this scheme has been used is that simple
MAJOR.MINOR.PATCH version comparison algorithms will work correctly even
if they do not support -rcN notation.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1650175

Title:
  wrong version in 2.8.0-rc03

Status in QEMU:
  Invalid

Bug description:
  When you compile qemu the version still 2.7.93 instead 2.8.0-rc03

  build/config-host.mak:VERSION=3D2.7.93

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1650175/+subscriptions
