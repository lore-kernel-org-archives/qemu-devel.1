Received: from eggs.gnu.org ([2001:4830:134:3::10]:44265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ejqxH-0004Ll-6Z
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 13:29:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ejqxD-0005CD-7j
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 13:29:55 -0500
Received: from indium.canonical.com ([91.189.90.7]:60044)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ejqxD-0005As-1K
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 13:29:51 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ejqxB-00058x-T6
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 18:29:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id CC23A2E8059
	for <qemu-devel@nongnu.org>; Thu,  8 Feb 2018 18:29:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Feb 2018 18:19:31 -0000
From: Thomas Huth <1211943@bugs.launchpad.net>
Reply-To: Bug 1211943 <1211943@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130813192045.32709.2408.malonedeb@chaenomeles.canonical.com>
Message-Id: <151811397164.29730.13606561073560144201.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1211943] Re: #GP and aligned move instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Triaging old bug tickets... can you still reproduce this issue with the
latest version of QEMU? Or could we close this ticket nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1211943

Title:
  #GP and aligned move instruction

Status in QEMU:
  Incomplete

Bug description:
  When the operand of movaps, movapd or movdqa instruction isn't
  aligned, general-protection exception should be generated.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1211943/+subscriptions
