Received: from eggs.gnu.org ([208.118.235.92]:42174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gf2XE-0005we-6w
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 07:55:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gf2X9-0005RD-98
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 07:55:40 -0500
Received: from indium.canonical.com ([91.189.90.7]:35244)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gf2X9-0005NX-3S
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 07:55:35 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gf2X6-0002zF-AF
	for <qemu-devel@nongnu.org>; Thu, 03 Jan 2019 12:55:32 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 418DB2E8024
	for <qemu-devel@nongnu.org>; Thu,  3 Jan 2019 12:55:32 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Jan 2019 12:47:16 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1714750 <1714750@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150442540217.17409.6458222878014636993.malonedeb@gac.canonical.com>
Message-Id: <154651963681.5030.1209522476986874653.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1714750] Re: 2.10.0 cannot be installed on
 case-insensitive file system
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Somebody re-reported this which reminded me that we forgot to tidy up the l=
oose ends here.
Current status:
 * this is fixed in upstream u-boot with their commit 610eec7f0593574 (comm=
itted October 2017, and in u-boot release v2017.11 and later)
 * in QEMU's release process we put in a workaround in our commit d0dead3b6=
df7f6cd97 which puts the u-boot sources in their own tarball rather than ex=
tracted; this went into QEMU release 2.11.0
 * we are still shipping the same old version of u-boot we were in 2.10

So ideally we'd finish fixing this bug report by:
 * updating our u-boot to some version v2017.11 or later
 * removing the d0dead3b6df7f6cd97 workaround

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1714750

Title:
  2.10.0 cannot be installed on case-insensitive file system

Status in QEMU:
  New

Bug description:
  The https://download.qemu.org/qemu-2.10.0.tar.bz2 tarball cannot be
  unpacked on a case-insensitive file system because it has a file
  qemu-2.10.0/roms/u-boot/scripts/Kconfig and a directory
  qemu-2.10.0/roms/u-boot/scripts/kconfig. This prevents installation on
  most macOS systems since by default the file system is case
  insensitive. The 2.10.0 upgrade is blocked in Homebrew due to this
  issue. See https://github.com/Homebrew/homebrew-core/pull/17467. This
  is a regression from 2.9.0, which didn't have this problem.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1714750/+subscriptions
