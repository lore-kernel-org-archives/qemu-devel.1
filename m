Received: from eggs.gnu.org ([2001:4830:134:3::10]:45361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fhrxM-0007UB-1u
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 03:42:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fhrxJ-0000Lq-1y
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 03:42:04 -0400
Received: from indium.canonical.com ([91.189.90.7]:48080)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fhrxI-0000L5-Sk
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 03:42:01 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fhrxH-0005oh-Is
	for <qemu-devel@nongnu.org>; Tue, 24 Jul 2018 07:41:59 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 8D6822E80C7
	for <qemu-devel@nongnu.org>; Tue, 24 Jul 2018 07:41:59 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Jul 2018 07:26:24 -0000
From: Thomas Huth <1481375@bugs.launchpad.net>
Reply-To: Bug 1481375 <1481375@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150804142725.24958.74014.malonedeb@soybean.canonical.com>
Message-Id: <153241718420.31823.4920332597173302173.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1481375] Re: Windows 7 Pro - Sticky Keys
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Looking through old bug tickets... can you still reproduce this issue
with the latest version of QEMU (currently v2.12)? Or could we close
this ticket nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1481375

Title:
  Windows 7 Pro - Sticky Keys

Status in QEMU:
  Incomplete

Bug description:
  Qemu KVM v: 1.1.0
  CentOS 7: 3.10.0-229.7.2.el7.x86_64
  Lenovo Thinkpad Yoga

  USB devices:
  Bus 001 Device 002: ID 8087:8000 Intel Corp. =

  Bus 002 Device 068: ID 2109:3431  =

  Bus 002 Device 012: ID 8087:07dc Intel Corp. =

  Bus 002 Device 004: ID 04f3:0254 Elan Microelectronics Corp. =

  Bus 002 Device 005: ID 04f2:b39f Chicony Electronics Co., Ltd =

  Bus 003 Device 047: ID 2109:0811  =

  Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
  Bus 002 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
  Bus 003 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
  Bus 001 Device 003: ID 0483:91d1 STMicroelectronics =

  Bus 001 Device 004: ID 056a:00ec Wacom Co., Ltd =

  Bus 002 Device 069: ID 046d:c03d Logitech, Inc. M-BT96a Pilot Optical Mou=
se
  Bus 002 Device 070: ID 04f2:0112 Chicony Electronics Co., Ltd KU-8933 Key=
board with PS/2 Mouse port
  Bus 002 Device 071: ID 2109:3431  =

  Bus 003 Device 048: ID 2109:0811  =

  Bus 003 Device 049: ID 17e9:4302 DisplayLink =


  CentOS (host OS) does not register stuck keys, primarily CTRL, ALT,
  Windows Key, and escape.  Windows 7 Pro VM keeps getting sticky keys
  registered when I boot into the OS or randomly bring back up the
  console.  The keys getting stuck are CTRL, L_SHIFT, ALT, or Windows
  key, maybe escape.  I have to frantically repress the primary shortcut
  keys on both the USB keyboard and the laptop keyboard.  The USB
  keyboard is mechanical and clean.  The laptop is new.  Remember, the
  host OS does not register stuck keys.  If anyone has had this problem,
  or knows a trick to prevent sticky keys, I'm all ears.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1481375/+subscriptions
