Received: from eggs.gnu.org ([2001:4830:134:3::10]:53222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eZOpG-0006Ul-Gb
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 17:26:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eZOpC-0003uP-Ao
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 17:26:26 -0500
Received: from indium.canonical.com ([91.189.90.7]:50714)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eZOpC-0003sq-3i
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 17:26:22 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eZOpA-0002kW-2C
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 22:26:20 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id AB06F2E85A9
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 22:19:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jan 2018 22:03:41 -0000
From: Thomas Huth <1163474@bugs.launchpad.net>
Reply-To: Bug 1163474 <1163474@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130402172849.8870.11981.malonedeb@gac.canonical.com>
Message-Id: <151562182202.2836.18217306233719136750.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1163474] Re: qemu mount usb permission denied
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Triaging old bug tickets ... Sounds like this was rather a problem with
your distro / udev than with qemu. In case you still have the problem,
please report it to the Debian bug tracker first.

** Changed in: qemu
       Status: New =3D> Invalid

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1163474

Title:
  qemu mount usb permission denied

Status in QEMU:
  Invalid

Bug description:
  I use debian with kde and the new Qemu 14.0 . I use this Qemu start
  arguments:

  /usr/bin/qemu-system-x86_64 -monitor stdio -smp 2 -soundhw es1370,ac97
  -k de -enable-kvm -m 4096 -localtime -cdrom /dev/sr0 -hda
  /home/....../.aqemu/Windows_7_x64_HDA.img -boot once=3Dd,menu=3Doff -net
  nic,vlan=3D0 -net user,vlan=3D0 -usb -usbdevice tablet -device usb-
  host,hostbus=3D1,hostaddr=3D2 -device usb-host,hostbus=3D2,hostaddr=3D2 -=
name
  "Windows 7 x64"

  Then I get this error: /dev/bus/usb/000/001: Permission denied

  Some says I must change the permissions /dev/bus/usb to 777 but I
  think that can't be the solution and when I restart the changes are
  lost. I think there is also a problem with the automount in KDE.

  The user user who starts Qemu has also full access to usb device
  (member of the group plugdev)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1163474/+subscriptions
