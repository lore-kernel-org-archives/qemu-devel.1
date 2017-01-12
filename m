Received: from eggs.gnu.org ([2001:4830:134:3::10]:53022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cRdD4-0001gv-Fi
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 06:06:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cRdCz-00072t-IX
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 06:06:22 -0500
Received: from indium.canonical.com ([91.189.90.7]:45066)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cRdCz-00072i-DF
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 06:06:17 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cRdCy-0001SW-EH
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 11:06:16 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id E6C952E80CD
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 11:06:15 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Jan 2017 10:53:49 -0000
From: Thomas Huth <1130533@bugs.launchpad.net>
Reply-To: Bug 1130533 <1130533@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130220075033.29111.25291.malonedeb@chaenomeles.canonical.com>
Message-Id: <20170112105349.21508.70079.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1130533] Re: Documentation cannot be build since
 commit c70a01e449536c616c85ab820c6fbad7d7e9cf39
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This should have been fixed by this commit here:
http://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D5d6768e3b8908a60f0

** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1130533

Title:
  Documentation cannot be build since commit
  c70a01e449536c616c85ab820c6fbad7d7e9cf39

Status in QEMU:
  Fix Released

Bug description:
  I tried to build git -based qemu and when documentation is processed I
  got this error :

  ./qemu-options.texi:1526: unknown command `list'
  ./qemu-options.texi:1526: table requires an argument: the formatter for @=
item
  ./qemu-options.texi:1526: warning: @table has text but no @item

  Looks like commit c70a01e449536c616c85ab820c6fbad7d7e9cf39 is guilty
  ?!

  Or any modification related to documentation, I think.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1130533/+subscriptions
