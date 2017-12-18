Received: from eggs.gnu.org ([2001:4830:134:3::10]:33120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eQsEB-00027T-Pb
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 05:01:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eQsE6-0006Bz-3u
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 05:00:55 -0500
Received: from indium.canonical.com ([91.189.90.7]:41704)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eQsE5-0006AY-UH
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 05:00:50 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eQsE4-0002vh-Lx
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 10:00:48 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id A53442E80CC
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 10:00:48 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 Dec 2017 09:53:17 -0000
From: Thomas Huth <1721187@bugs.launchpad.net>
Reply-To: Bug 1721187 <1721187@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150709842178.2640.16899221192910481679.malonedeb@chaenomeles.canonical.com>
Message-Id: <151359079727.11633.15143686196285021650.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1721187] Re: install Centos7 or fedora27 on qemu
 on windows8.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

So I assume the mouse is working now? I think we then can close this ticket.
Concerning the speed: QEMU is emulating the CPU by default, so this is of c=
ourse slower than running everything natively. You've got to use an acceler=
ator to get more speed - for Windows, you can use HAXM: https://www.qemu.or=
g/2017/11/22/haxm-usage-windows/

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1721187

Title:
  install Centos7 or fedora27 on qemu on windows8.1

Status in QEMU:
  Incomplete

Bug description:
  Hello,
  I have tried to install CentOs or Fedora27 on my Windows8 using QEMU. I w=
ork on notepad with 4GB.
  Unfortunatly, my touchpad nor my usb-mouse are not recognise on the graph=
ical installation of CentOs and Fedora installation. So, I cannot install t=
hem.
  Here are the commands I use for installation :

  qemu-img create -f qcow2 fedora27b2_hd.qcow2 80G

  qemu-system-x86_64 -k fr -hda fedora27b2_hd.qcow2 -cdrom Fedora-
  Workstation-Live-x86_64-27_Beta-1.5.iso -m 512 -boot d

  I have tried to add the option : -device usb-mouse  but, I got the
  error message that no 'usb-bus' found for the usb-mouse device.

  What is wrong ?  QEMU or my installation command ?

  Thank, BRgds,
  Laurent

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1721187/+subscriptions
