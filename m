Received: from eggs.gnu.org ([2001:4830:134:3::10]:36082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dV1Za-0005AU-EO
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 16:15:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dV1ZX-0004vX-Vy
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 16:15:54 -0400
Received: from indium.canonical.com ([91.189.90.7]:52004)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dV1ZX-0004v8-QA
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 16:15:51 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dV1ZW-0001Xs-UD
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 20:15:50 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id E022C2E8190
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 20:15:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 Jul 2017 19:59:43 -0000
From: Thomas Huth <1095857@bugs.launchpad.net>
Reply-To: Bug 1095857 <1095857@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130103232452.20840.26594.malonedeb@chaenomeles.canonical.com>
Message-Id: <149980318376.15632.16703680800404582980.launchpad@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1095857] Re: incorrect handling of [r32] address
 (long mode)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1095857

Title:
  incorrect handling of [r32] address (long mode)

Status in QEMU:
  Incomplete

Bug description:
  while executing in Long Mode (x86-64) instructions such as

  mov eax,[r15d]

  end up executing as

  mov eax,[r15]

  according to x86 programmer manuals the behavior of using the Address-
  Size override (in long mode) is supposed to ignore the high 32bits of
  the register. I use this fact in my operating system to reduce
  register usage (the high 32 bits of r15 holds other data).
  consequently a general protection exception occurs since the memory
  address isn't "canonical". this error doesn't always appear since the
  high 32 bits might not be zero in those conditions.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1095857/+subscriptions
