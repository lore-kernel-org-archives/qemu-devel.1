Received: from eggs.gnu.org ([2001:4830:134:3::10]:40548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cUDBp-0005xo-9U
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 08:55:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cUDBj-0006fS-Aw
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 08:55:45 -0500
Received: from indium.canonical.com ([91.189.90.7]:52605)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cUDBi-0006f2-Up
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 08:55:39 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cUDBh-0008HC-JB
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 13:55:37 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 85E272E80C3
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 13:55:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Jan 2017 13:43:34 -0000
From: Nigel Horne <641118@bugs.launchpad.net>
Reply-To: Bug 641118 <641118@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20100917083650.27205.51256.malonedeb@wampee.canonical.com>
Message-Id: <20170119134334.21446.96490.malone@gac.canonical.com>
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

I've just tried, and it is OK using NetBSD7 as the guest.  I no longer
have NetBSD5 so I am unable to check if the problem still exists on
that.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/641118

Title:
  NetBSD guest only supports network without ACPI

Status in QEMU:
  Incomplete

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
