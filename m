Received: from eggs.gnu.org ([2001:4830:134:3::10]:50688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cUDed-0005Uu-By
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:25:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cUDea-0005Iv-RD
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:25:31 -0500
Received: from indium.canonical.com ([91.189.90.7]:34589)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cUDea-0005Id-Ld
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:25:28 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cUDeZ-000272-Ro
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 14:25:27 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D05332E80BF
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 14:25:27 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Jan 2017 14:06:09 -0000
From: Thomas Huth <641118@bugs.launchpad.net>
Reply-To: Bug 641118 <641118@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20100917083650.27205.51256.malonedeb@wampee.canonical.com>
Message-Id: <20170119140609.20707.21603.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 641118] Re: NetBSD guest only supports network
 without ACPI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

OK, thanks for checking! ... so let's close this bug.

** Changed in: qemu
       Status: Incomplete =3D> Won't Fix

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/641118

Title:
  NetBSD guest only supports network without ACPI

Status in QEMU:
  Won't Fix

Bug description:
  Git commit: abdfd9500e07fab7d6ffd4385fa30a065c329a39
  Host: Linux 64bit Debian
  Guest: NetBSD5.0.2/i386

  Networking works only when ACPI is disabled in the guest. Without it
  the network card (wm0) is not detected.

  Boot: qemu -hda netbsd5.0.2-i386 -boot c -enable-kvm
  Configure: --enable-linux-aio --enable-io-thread --enable-kvm

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/641118/+subscriptions
