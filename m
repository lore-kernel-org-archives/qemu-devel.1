Received: from eggs.gnu.org ([2001:4830:134:3::10]:59519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fzNq0-0004EQ-QY
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 11:10:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fzNpx-0008Gs-Ad
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 11:10:52 -0400
Received: from indium.canonical.com ([91.189.90.7]:35878)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fzNpx-0008GK-3b
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 11:10:49 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fzNpw-0008GE-Cw
	for <qemu-devel@nongnu.org>; Mon, 10 Sep 2018 15:10:48 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 5E8922E806B
	for <qemu-devel@nongnu.org>; Mon, 10 Sep 2018 15:10:48 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Sep 2018 14:57:43 -0000
From: Jan Marti <1791680@bugs.launchpad.net>
Reply-To: Bug 1791680 <1791680@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153658763815.28323.7728344780520066918.malonedeb@wampee.canonical.com>
Message-Id: <153659146358.32319.13458281620861416248.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1791680] Re: network bridge does not work
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

what do i need for netdev id? n1 as described in your links does not
work. messsage: "netdev 'n1' not found"

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1791680

Title:
  network bridge does not work

Status in QEMU:
  Invalid

Bug description:
  hi there

  the network bridge does not seem to work described as here:
  https://en.wikibooks.org/wiki/QEMU/Networking

  When i add that parameters in a 192.168.80.x subnet, my emulated
  raspbian ARM gets the IP 10.0.2.15.... While all other computers get
  192.168.80.x

  The command i use is:

  =

  qemu-system-arm.exe -M versatilepb -cpu arm1176 -hda 2018-09-03_stretch_i=
nkl_phalcon.img -kernel kernel-qemu-4.4.34-jessie -m 192 -append "root=3D/d=
ev/sda2 panic=3D1 rootfstype=3Dext4 rw" -no-reboot -net nic -net user -devi=
ce e1000,mac=3D52:54:00:12:34:56 &

  =

  Does not build up a network bridge to 192.168.80.x...

  The host system i use is win10 x64 v1803

  Best regards,
  Jan

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1791680/+subscriptions
