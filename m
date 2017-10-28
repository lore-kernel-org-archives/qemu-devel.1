Received: from eggs.gnu.org ([2001:4830:134:3::10]:37183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e8RUe-00055b-8z
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 09:49:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e8RUa-0007As-CL
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 09:49:44 -0400
Received: from indium.canonical.com ([91.189.90.7]:54944)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e8RUa-0007AT-66
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 09:49:40 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e8RUZ-000680-7C
	for <qemu-devel@nongnu.org>; Sat, 28 Oct 2017 13:49:39 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 2568A2E80CC
	for <qemu-devel@nongnu.org>; Sat, 28 Oct 2017 13:49:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 28 Oct 2017 13:37:17 -0000
From: Thomas Huth <1292037@bugs.launchpad.net>
Reply-To: Bug 1292037 <1292037@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140313144131.19009.48697.malonedeb@wampee.canonical.com>
Message-Id: <150919783792.4552.6539066106802473390.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1292037] Re: Solaris 10 x86 guest crashes qemu
 with -icount 1 option
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
https://bugs.launchpad.net/bugs/1292037

Title:
  Solaris 10 x86 guest crashes qemu with -icount 1 option

Status in QEMU:
  Incomplete

Bug description:
  Solaris image: Solaris 10 x86 (32 bit)

  command: ./i386-softmmu/qemu-system-i386 -hda <image-file> -m 2G
  -icount 1 -monitor stdio

  Crashes saying:
  qemu: Fatal: Raised interrupt while not in I/O function

  Host:
  ubuntu x86_64 3.2.0-56 generic
  intel xeon E5649 @ 2.53GHz

  UPDATE:
  Tested on QEMU v2.0.50
  Also affects OpenIndiana (151a8 - Server Build 32bit)
  http://lists.gnu.org/archive/html/qemu-devel/2014-05/msg06365.html

  Workaround: Rename the kvmvapic.bin file under the pc-bios directory
  to something different.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1292037/+subscriptions
