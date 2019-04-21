Received: from eggs.gnu.org ([209.51.188.92]:34267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hI6mF-0003bv-8O
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 03:20:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hI6mE-00019B-7o
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 03:20:39 -0400
Received: from indium.canonical.com ([91.189.90.7]:40370)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hI6mE-000181-2L
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 03:20:38 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hI6mC-0004FF-BU
	for <qemu-devel@nongnu.org>; Sun, 21 Apr 2019 07:20:36 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 392E52E80CB
	for <qemu-devel@nongnu.org>; Sun, 21 Apr 2019 07:20:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 21 Apr 2019 07:12:02 -0000
From: Lukas Straub <1824622@bugs.launchpad.net>
Reply-To: Bug 1824622 <1824622@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <155515766892.14199.10108123306728671913.malonedeb@gac.canonical.com>
Message-Id: <155583072247.17585.4814317714413821339.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1824622] Re: Qemu 4.0.0-rc3 COLO Primary Crashes
 with "Assertion `event_unhandled_count > 0' failed."
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

There is a Patch available which fixes this bug:
https://lists.nongnu.org/archive/html/qemu-devel/2019-04/msg03497.html

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1824622

Title:
  Qemu 4.0.0-rc3 COLO Primary Crashes with "Assertion
  `event_unhandled_count > 0' failed."

Status in QEMU:
  New

Bug description:
  Hello Everyone,
  Now with Qemu 4.0.0-rc3, COLO is finally working so I gave it a try, but =
the Primary is always crashing during Network use. Typing fast in ssh or ru=
nning "top" with 0.1 second delay (change with 'd') reliably trigger the cr=
ash for me. I use the attached scripts to run Qemu, in my case both primary=
 and secondary run on the same Host for testing purposes. See the files in =
the attached .tar.bz2 for more Info, they also contain a Coredump.

  Regards,
  Lukas Straub

  Configure CMDline:
  ./configure --target-list=3Dx86_64-softmmu,i386-softmmu --enable-debug-in=
fo

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1824622/+subscriptions
