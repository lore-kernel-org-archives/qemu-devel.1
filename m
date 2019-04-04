Received: from eggs.gnu.org ([209.51.188.92]:55974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hBzdx-0008JN-E3
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 06:30:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hBzdv-0006yn-Vw
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 06:30:49 -0400
Received: from indium.canonical.com ([91.189.90.7]:53516)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hBzdv-0006xW-MU
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 06:30:47 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hBzdu-0003de-GM
	for <qemu-devel@nongnu.org>; Thu, 04 Apr 2019 10:30:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 771BE2E8078
	for <qemu-devel@nongnu.org>; Thu,  4 Apr 2019 10:30:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Apr 2019 10:19:30 -0000
From: Sushant  Gokhale <1823152@bugs.launchpad.net>
Reply-To: Bug 1823152 <1823152@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <155437317153.8246.1283253665470856398.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1823152] [NEW] QEMU not able to boot ubuntu 18.04
 as a guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

Host information:
sushant@sushant-OptiPlex-7050:~$ lsb_release -a
No LSB modules are available.
Distributor ID:	Ubuntu
Description:	Ubuntu 18.04.2 LTS
Release:	18.04
Codename:	bionic

QEMU version:
sushant@sushant-OptiPlex-7050:~$ /usr/bin/qemu-system-x86_64   --version
QEMU emulator version 2.11.1(Debian 1:2.11+dfsg-1ubuntu7.12)
Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers

I am trying to install xubuntu 18.04 as a qemu guest. The installation
process goes smoothly and I reboot. After reboot, the boot process hangs
with black screen and a blinking pointer. I used the following steps to
install and boot the machine:

STEP 1:
sudo qemu-img create /var/lib/libvirt/images/xubuntu18_04.qcow2 30G


STEP 2:
sudo qemu-system-x86_64-spice -enable-kvm -cpu host -boot d -cdrom /home/su=
shant/Downloads/xubuntu-18.04.2-desktop-amd64.iso /var/lib/libvirt/images/x=
ubuntu18_04.qcow2   -m 8G


STEP 3:
sudo qemu-system-x86_64-spice -enable-kvm -cpu host  /var/lib/libvirt/image=
s/xubuntu18_04.qcow2   -m 8G

I tried with ubuntu 18.04(deafult ubuntu) and it also hangs with error
"removed slice user slice of gdm"

Also, if I install ubuntu 16.04 as guest, it boots smoothly.

What should be done?

** Affects: qemu
     Importance: Undecided
         Status: New

** Description changed:

  Host information:
  sushant@sushant-OptiPlex-7050:~$ lsb_release -a
  No LSB modules are available.
  Distributor ID:	Ubuntu
  Description:	Ubuntu 18.04.2 LTS
  Release:	18.04
  Codename:	bionic
  =

- =

  QEMU version:
  sushant@sushant-OptiPlex-7050:~$ /usr/bin/qemu-system-x86_64   --version
  QEMU emulator version 2.11.1(Debian 1:2.11+dfsg-1ubuntu7.12)
  Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers
- =

  =

  I am trying to install xubuntu 18.04 as a qemu guest. The installation pr=
ocess goes smoothly and I reboot. After reboot, the boot process hangs with=
 black screen and a blinking pointer. I used the following steps to install=
 and boot the machine:
  sudo qemu-img create /var/lib/libvirt/images/xubuntu18_04.qcow2 30G
  =

  sudo qemu-system-x86_64-spice -enable-kvm -cpu host -boot d -cdrom
  /home/sushant/Downloads/xubuntu-18.04.2-desktop-amd64.iso
  /var/lib/libvirt/images/xubuntu18_04.qcow2   -m 8G
  =

  sudo qemu-system-x86_64-spice -enable-kvm -cpu host
  /var/lib/libvirt/images/xubuntu18_04.qcow2   -m 8G
  =

- =

- =

- =

- I tried with ubuntu 18.04(deafult ubuntu) and it also hangs with error "r=
emoved slice user slice of gdm"
- =

+ I tried with ubuntu 18.04(deafult ubuntu) and it also hangs with error
+ "removed slice user slice of gdm"
  =

  Also, if I install ubuntu 16.04 as guest, it boots smoothly.
  =

  What should be done?

** Description changed:

  Host information:
  sushant@sushant-OptiPlex-7050:~$ lsb_release -a
  No LSB modules are available.
  Distributor ID:	Ubuntu
  Description:	Ubuntu 18.04.2 LTS
  Release:	18.04
  Codename:	bionic
  =

  QEMU version:
  sushant@sushant-OptiPlex-7050:~$ /usr/bin/qemu-system-x86_64   --version
  QEMU emulator version 2.11.1(Debian 1:2.11+dfsg-1ubuntu7.12)
  Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers
  =

- I am trying to install xubuntu 18.04 as a qemu guest. The installation pr=
ocess goes smoothly and I reboot. After reboot, the boot process hangs with=
 black screen and a blinking pointer. I used the following steps to install=
 and boot the machine:
+ I am trying to install xubuntu 18.04 as a qemu guest. The installation
+ process goes smoothly and I reboot. After reboot, the boot process hangs
+ with black screen and a blinking pointer. I used the following steps to
+ install and boot the machine:
+ =

+ STEP 1:
  sudo qemu-img create /var/lib/libvirt/images/xubuntu18_04.qcow2 30G
  =

- sudo qemu-system-x86_64-spice -enable-kvm -cpu host -boot d -cdrom
- /home/sushant/Downloads/xubuntu-18.04.2-desktop-amd64.iso
- /var/lib/libvirt/images/xubuntu18_04.qcow2   -m 8G
  =

- sudo qemu-system-x86_64-spice -enable-kvm -cpu host
- /var/lib/libvirt/images/xubuntu18_04.qcow2   -m 8G
+ STEP 2:
+ sudo qemu-system-x86_64-spice -enable-kvm -cpu host -boot d -cdrom /home/=
sushant/Downloads/xubuntu-18.04.2-desktop-amd64.iso /var/lib/libvirt/images=
/xubuntu18_04.qcow2   -m 8G
+ =

+ =

+ STEP 3:
+ sudo qemu-system-x86_64-spice -enable-kvm -cpu host  /var/lib/libvirt/ima=
ges/xubuntu18_04.qcow2   -m 8G
  =

  I tried with ubuntu 18.04(deafult ubuntu) and it also hangs with error
  "removed slice user slice of gdm"
  =

  Also, if I install ubuntu 16.04 as guest, it boots smoothly.
  =

  What should be done?

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1823152

Title:
  QEMU not able to boot ubuntu 18.04 as a guest

Status in QEMU:
  New

Bug description:
  Host information:
  sushant@sushant-OptiPlex-7050:~$ lsb_release -a
  No LSB modules are available.
  Distributor ID:	Ubuntu
  Description:	Ubuntu 18.04.2 LTS
  Release:	18.04
  Codename:	bionic

  QEMU version:
  sushant@sushant-OptiPlex-7050:~$ /usr/bin/qemu-system-x86_64   --version
  QEMU emulator version 2.11.1(Debian 1:2.11+dfsg-1ubuntu7.12)
  Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers

  I am trying to install xubuntu 18.04 as a qemu guest. The installation
  process goes smoothly and I reboot. After reboot, the boot process
  hangs with black screen and a blinking pointer. I used the following
  steps to install and boot the machine:

  STEP 1:
  sudo qemu-img create /var/lib/libvirt/images/xubuntu18_04.qcow2 30G

  =

  STEP 2:
  sudo qemu-system-x86_64-spice -enable-kvm -cpu host -boot d -cdrom /home/=
sushant/Downloads/xubuntu-18.04.2-desktop-amd64.iso /var/lib/libvirt/images=
/xubuntu18_04.qcow2   -m 8G

  =

  STEP 3:
  sudo qemu-system-x86_64-spice -enable-kvm -cpu host  /var/lib/libvirt/ima=
ges/xubuntu18_04.qcow2   -m 8G

  I tried with ubuntu 18.04(deafult ubuntu) and it also hangs with error
  "removed slice user slice of gdm"

  Also, if I install ubuntu 16.04 as guest, it boots smoothly.

  What should be done?

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1823152/+subscriptions
