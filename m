Received: from eggs.gnu.org ([2001:4830:134:3::10]:33073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ds2rL-0002xm-1p
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 04:17:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ds2rG-00009n-1Q
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 04:17:23 -0400
Received: from indium.canonical.com ([91.189.90.7]:45610)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ds2rF-00007z-Rm
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 04:17:17 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1ds2rE-0004Jn-QX
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 08:17:16 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C53B12E8486
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 08:17:16 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 Sep 2017 07:56:26 -0000
From: Thomas Huth <932490@bugs.launchpad.net>
Reply-To: Bug 932490 <932490@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120215021135.22747.33099.malonedeb@soybean.canonical.com>
Message-Id: <150528938664.29603.470027703805471940.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 932490] Re: Qemu fails on -fda /dev/fd0 when no
 medium is present
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Is this still an issue with the latest version of QEMU (currently
v2.10), or could we close this ticket nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/932490

Title:
  Qemu fails on -fda /dev/fd0 when no medium is present

Status in QEMU:
  Incomplete

Bug description:
  # qemu-system-x86_64 --version
  QEMU emulator version 1.0 (qemu-kvm-1.0), Copyright (c) 2003-2008 Fabrice=
 Bellard

  # qemu-system-x86_64 -fda /dev/fd0
  qemu-system-x86_64: -fda /dev/fd0: could not open disk image /dev/fd0: No=
 such device or address

  Starting with a medium (floppy disk) inserted, then removing or
  changing the medium works fine.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/932490/+subscriptions
