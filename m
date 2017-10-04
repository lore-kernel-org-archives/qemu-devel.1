Received: from eggs.gnu.org ([2001:4830:134:3::10]:35068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dziz1-000636-W9
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 08:41:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dziyx-0003Zs-4p
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 08:41:04 -0400
Received: from indium.canonical.com ([91.189.90.7]:32824)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dziyw-0003Yn-V7
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 08:40:59 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1dziyt-0000kE-TD
	for <qemu-devel@nongnu.org>; Wed, 04 Oct 2017 12:40:55 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id CD0052E80CC
	for <qemu-devel@nongnu.org>; Wed,  4 Oct 2017 12:40:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Oct 2017 12:35:11 -0000
From: laurent <1721187@bugs.launchpad.net>
Reply-To: Bug 1721187 <1721187@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150709842178.2640.16899221192910481679.malonedeb@chaenomeles.canonical.com>
Message-Id: <150712051195.1972.9660561275655283425.malone@chaenomeles.canonical.com>
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

I use qemu-w64-setup-20170830.exe on Windows8-64bits
I tried the following command, but it is very, very slow :

qemu-img create centos7_hd.img 80G

qemu-system-x86_64 -k fr -cpu core2duo -m 1024 -usb -device usb-mouse
-hda centos7_hd.img --drive
media=3Dcdrom,file=3DCentOS-7-x86_64-Everything-1708.iso,readonly

BRgds,
Laurent

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1721187

Title:
  install Centos7 or fedora27 on qemu on windows8.1

Status in QEMU:
  New

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
