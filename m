Received: from eggs.gnu.org ([2001:4830:134:3::10]:43421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dKqXY-0006rw-MY
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 14:27:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dKqXW-0005L4-Ml
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 14:27:44 -0400
Received: from indium.canonical.com ([91.189.90.7]:33880)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dKqXW-0005Ku-Gc
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 14:27:42 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dKqXV-00042h-6P
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 18:27:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 2F47D2E80E8
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 18:27:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Jun 2017 18:07:15 -0000
From: Thomas Huth <1090837@bugs.launchpad.net>
Reply-To: Bug 1090837 <1090837@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20121216032007.25057.46110.malonedeb@chaenomeles.canonical.com>
Message-Id: <149737723503.28642.11998659479143784183.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1090837] Re: Error in building Qemu-1.3.0 on
 Solaris 10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Closing, as there is a work-around according to comment #6

** Changed in: qemu
       Status: New =3D> Won't Fix

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1090837

Title:
  Error in building Qemu-1.3.0 on Solaris 10

Status in QEMU:
  Won't Fix

Bug description:
  While trying to build Qemu on Oracle Solaris 10 (SPARC processor), I
  encountered the following error in the configure step:

  ./configure --prefix=3D/usr/local/ --install=3D/usr/ucb/install
  ./configure: bad substitution
  ./configure: !: not found
  ./configure: !: not found
  ./configure: !: not found
  ./configure: !: not found
  ./configure: !: not found
  ./configure: curl-config: not found
  ./configure: curl-config: not found

  As the following bug report says:
  https://bugs.launchpad.net/qemu/+bug/636315, "sh" is hard-coded in the
  script. Can't the script be modified to accept a $SHELL argument to
  make use of bash or other shell during configure and make step?

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1090837/+subscriptions
