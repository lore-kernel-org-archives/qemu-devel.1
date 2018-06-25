Received: from eggs.gnu.org ([2001:4830:134:3::10]:52429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fXPEy-000538-Eu
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 07:01:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fXPEu-0000q2-0s
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 07:01:00 -0400
Received: from indium.canonical.com ([91.189.90.7]:60548)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fXPEt-0000pm-QK
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 07:00:55 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fXPEs-0008PZ-95
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 11:00:54 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 434D42E80CC
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 11:00:54 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 Jun 2018 10:53:31 -0000
From: navicrej <1778350@bugs.launchpad.net>
Reply-To: Bug 1778350 <1778350@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152976906812.26719.4060539263907295716.malonedeb@gac.canonical.com>
Message-Id: <152992401182.25608.13015767721800507585.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1778350] Re: Android-x86 4.4-r5 won't boot on
 QEMU since v2.11.0-rc2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

After 'git bisect' -ing it I found the commit that is responsible for
this:

https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D9fa99d2519cbf71f871e4=
6871df12cb446dc1c3e

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1778350

Title:
  Android-x86 4.4-r5 won't boot on QEMU since v2.11.0-rc2

Status in QEMU:
  New

Bug description:
  Try to boot from the Android-x86 4.4-r5 ISO won't boot in QEMU after 2.11=
.0-rc2. The last known version it works is 2.11.0-rc1.
  It also works on the 2.10.x-line, even the 2.10.2 which was released afte=
r 2.11.0-rc2!

  How to reproduce:
  Download the ISO from
  http://www.android-x86.org/releases/releasenote-4-4-r5 or directly https:=
//www.fosshub.com/Android-x86.html/android-x86-4.4-r5.iso

  Start QEMU with this command-line: qemu-system-x86_64 -cdrom
  android-x86-4.4-r5.iso -m 1024

  On 2.11.0-rc1 and 2.10.2 after selecting to boot from CD it shows the And=
roid splash after a short while ...
  On 2.11.0-rc2 through the latest 2.12 line it goes to black screen shortl=
y right after selecting to boot from CD

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1778350/+subscriptions
