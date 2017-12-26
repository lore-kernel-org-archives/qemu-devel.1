Received: from eggs.gnu.org ([2001:4830:134:3::10]:45243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eTgsF-0004qC-B7
	for qemu-devel@nongnu.org; Mon, 25 Dec 2017 23:29:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eTgsA-0000Fm-99
	for qemu-devel@nongnu.org; Mon, 25 Dec 2017 23:29:55 -0500
Received: from indium.canonical.com ([91.189.90.7]:38428)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eTgsA-0000Eo-2B
	for qemu-devel@nongnu.org; Mon, 25 Dec 2017 23:29:50 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eTgs6-0001EJ-Gj
	for <qemu-devel@nongnu.org>; Tue, 26 Dec 2017 04:29:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 6FEDF2E80D3
	for <qemu-devel@nongnu.org>; Tue, 26 Dec 2017 04:29:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 Dec 2017 04:17:38 -0000
From: Launchpad Bug Tracker <1358722@bugs.launchpad.net>
Reply-To: Bug 1358722 <1358722@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140819123712.28945.58932.malonedeb@chaenomeles.canonical.com>
Message-Id: <151426185866.1219.3283131229455721854.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1358722] Re: latest acpi commits causes memory
 allocation fault in macosx
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
https://bugs.launchpad.net/bugs/1358722

Title:
  latest acpi commits causes memory allocation fault in macosx

Status in QEMU:
  Expired

Bug description:
  qemu release 2.1.0

  Hi,
  I've found a regression on MacOSX guest (10.9.4) after merging the follow=
ing commits =


  18045fb9f457a0f0cba2bd113c748a2dcb4ed39e pc: future-proof migration-compa=
tibility of ACPI tables
  868270f23d8db2cce83e4f082fe75e8625a5fbf9 acpi-build: tweak acpi migration=
 limits

  The migration limits make x86 chameleon bootloader generate a memory
  allocation error with 0xdeadbeef address at line 899 in source file:

  http://forge.voodooprojects.org/p/chameleon/source/tree/2360/branches/Bun=
go/i386/libsaio/acpi_patcher.c

  I've not tried to recompile chameleon yet.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1358722/+subscriptions
