Received: from eggs.gnu.org ([2001:4830:134:3::10]:57310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fpqQI-0001Mi-11
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 03:40:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fpqQG-0007Br-Sq
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 03:40:53 -0400
Received: from indium.canonical.com ([91.189.90.7]:52276)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fpqQG-00079F-Bk
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 03:40:52 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fpqQF-0006h7-L2
	for <qemu-devel@nongnu.org>; Wed, 15 Aug 2018 07:40:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 9B5822E851B
	for <qemu-devel@nongnu.org>; Wed, 15 Aug 2018 07:40:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Aug 2018 07:32:36 -0000
From: Thomas Huth <1739304@bugs.launchpad.net>
Reply-To: Bug 1739304 <1739304@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <151372207410.18061.3050483309114042068.malonedeb@chaenomeles.canonical.com>
Message-Id: <153431835650.26719.9504444915420048899.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1739304] Re: Passing a directory to (eg.) -cdrom
 results in misleading error message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Fixed here:
https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D230ff73904e72dde2d771=
8c2

** Changed in: qemu
       Status: Confirmed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1739304

Title:
  Passing a directory to (eg.) -cdrom results in misleading error
  message

Status in QEMU:
  Fix Released

Bug description:
  For example:

      qemu-system-x86_64 -cdrom /path/to/directory

  Results in:

      Could not read image for determining its format: File too large

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1739304/+subscriptions
