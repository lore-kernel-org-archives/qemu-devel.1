Received: from eggs.gnu.org ([2001:4830:134:3::10]:37790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fcAJz-0007m9-Ec
	for qemu-devel@nongnu.org; Sun, 08 Jul 2018 10:05:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fcAJv-0006AL-BD
	for qemu-devel@nongnu.org; Sun, 08 Jul 2018 10:05:51 -0400
Received: from indium.canonical.com ([91.189.90.7]:39168)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fcAJv-00069s-4m
	for qemu-devel@nongnu.org; Sun, 08 Jul 2018 10:05:47 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fcAJt-0008CC-TA
	for <qemu-devel@nongnu.org>; Sun, 08 Jul 2018 14:05:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id DBB372E807B
	for <qemu-devel@nongnu.org>; Sun,  8 Jul 2018 14:05:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Jul 2018 13:58:23 -0000
From: navicrej <1778350@bugs.launchpad.net>
Reply-To: Bug 1778350 <1778350@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152976906812.26719.4060539263907295716.malonedeb@gac.canonical.com>
Message-Id: <153105830325.29991.12431474795822054244.malone@wampee.canonical.com>
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

I compiled the 4.4.4-r5 branch but I was not able to change the kernel
yet.

Furthermore I am not able to use any version of Android x86 6.x, 7.x,
8.x on current QEMU with or without the parameters.

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
