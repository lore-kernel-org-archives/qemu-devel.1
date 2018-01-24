Received: from eggs.gnu.org ([2001:4830:134:3::10]:46463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eeQIK-0005PJ-MK
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 14:01:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eeQII-0001OT-Lg
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 14:01:12 -0500
Received: from indium.canonical.com ([91.189.90.7]:53202)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eeQII-0001Ns-Fs
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 14:01:10 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eeQIH-0003eT-FL
	for <qemu-devel@nongnu.org>; Wed, 24 Jan 2018 19:01:09 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 7070D2E854D
	for <qemu-devel@nongnu.org>; Wed, 24 Jan 2018 19:01:09 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jan 2018 18:48:31 -0000
From: Thomas Huth <1369347@bugs.launchpad.net>
Reply-To: Bug 1369347 <1369347@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140914222349.18130.54347.malonedeb@chaenomeles.canonical.com>
Message-Id: <151681971147.10317.16858285984500439388.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1369347] Re: Mac OS X cannot passthrough USB
 device to guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Comment #3 sounds like this bug has been fixed, right? So I'm closing
this bug ticket now.

** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1369347

Title:
  Mac OS X cannot passthrough USB device to guest

Status in QEMU:
  Fix Released

Bug description:
  I'm using Mac OS 10.9.4 with qemu-system-arm installed from brew
  (version 1.7.1) and verified with qemu-system-x86_64. I'm trying to
  pass a Ralink 5370 WiFi USB dongle to my guest system, it appears in
  my system profiler as:

  802.11 n WLAN:

    Product ID:	0x5370
    Vendor ID:	0x148f
    Version:	 1.01
    Serial Number:	1.0
    Speed:	Up to 480 Mb/sec
    Manufacturer:	Ralink
    Location ID:	0x1d110000 / 6
    Current Available (mA):	500
    Current Required (mA):	450

  Using the docs, I'm passing "-usb -device usb-host,vendorid=3D0x148f,prod=
uctid=3D0x5370" and getting this error back:
  "qemu-system-arm: -device usb-host,vendorid=3D0x148f,productid=3D0x5370: =
Parameter 'driver' expects device type"

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1369347/+subscriptions
