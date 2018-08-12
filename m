Received: from eggs.gnu.org ([2001:4830:134:3::10]:39658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fov8j-0003gk-Jv
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 14:30:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fov8g-0004EF-Aa
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 14:30:57 -0400
Received: from indium.canonical.com ([91.189.90.7]:55854)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fov8g-0004Cy-3o
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 14:30:54 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fov8d-0005jM-Uc
	for <qemu-devel@nongnu.org>; Sun, 12 Aug 2018 18:30:52 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 275DF2E8532
	for <qemu-devel@nongnu.org>; Sun, 12 Aug 2018 18:30:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 12 Aug 2018 18:21:42 -0000
From: Lorenz Brun <lorenz@dolansoft.org>
Reply-To: Bug 1777235 <1777235@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152914985958.7724.174010690226549747.malonedeb@wampee.canonical.com>
Message-Id: <153409810340.8206.14614488777671929977.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1777235] Re: NVME is missing support for Get Log
 Page command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I have a patch for that, it was designed to run NVMe for MacOS guests
and implements at least the bare minimum of the spec. I'll try to polish
it up and upstream it as soon as I have time.

** Patch added: "0001-Enough-GetLogCmd-for-macOS.patch"
   https://bugs.launchpad.net/qemu/+bug/1777235/+attachment/5174516/+files/=
0001-Enough-GetLogCmd-for-macOS.patch

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1777235

Title:
  NVME is missing support for Get Log Page command

Status in QEMU:
  New

Bug description:
  "Get Log Page" is a mandatory admin command by the specification (NVMe
  1.2, Section 5, Figure 40) currently not implemented by device.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1777235/+subscriptions
