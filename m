Received: from eggs.gnu.org ([2001:4830:134:3::10]:51799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gJWXz-0006UU-Ud
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 23:31:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gJWXK-0008Tn-IQ
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 23:30:54 -0500
Received: from indium.canonical.com ([91.189.90.7]:39716)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gJWXK-0007d5-Ba
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 23:30:50 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gJWWt-0001y4-7F
	for <qemu-devel@nongnu.org>; Mon, 05 Nov 2018 04:30:23 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 2B5272E805B
	for <qemu-devel@nongnu.org>; Mon,  5 Nov 2018 04:30:23 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Nov 2018 04:17:19 -0000
From: Launchpad Bug Tracker <1496712@bugs.launchpad.net>
Reply-To: Bug 1496712 <1496712@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150917071936.19634.18927.malonedeb@soybean.canonical.com>
Message-Id: <154139143923.4655.18273131746935472674.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1496712] Re: no bootable device after qemu-img
 convert parallels windows 2012 r2 to raw/qcow2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1496712

Title:
  no bootable device after qemu-img convert parallels windows 2012 r2 to
  raw/qcow2

Status in QEMU:
  Expired

Bug description:
  Hello
  We have converted a parallels windows 2012 R2 image with the command
  qemu-img convert -p -f parallels -O raw ./TestLibvirt.pvm/TestLibvirtMig-=
0.hdd/TestLibvirtMig-0.hdd.0.hds /var/lib/libvirt/images/testlibvirtmig.raw

  Afterthat we have created a new entry with virtual machine manager and
  used this raw-hdd file as "import existing disk image"

  Then we booted this virtual server and we got the error =

  "Booting from Hard Disk"
  "no Bootable device"

  Test 1: we also tried to "overwrite" the windows server drive
  1. Create a vm with windows 2012 r2 (W2K12R2) with virtual machine manage=
r. Which runs good
  2. Then we mounted in the command line the "no bootable device" server  a=
s source (raw image)
      mount /ev/mapper/loop0p4 /mnt/source
  3. Then we mounted the new created (W2K12R2) as target (raw image)
      mount /ev/mapper/loop1p2 /mnt/target
  4. with the copy command we have overwritten all files on the windows dri=
ve
      rsync -av --delete /mnt/source/* /mnt/target/ =

  5. reboot the server and we have a blue screen and it tells me something =
prl_strg.sys =

       "your PC ran into a problem and needs to restart ...... If you'd lik=
e to know more, you can search online later for this error: SYSTEM_THREAD_E=
XCEPTION_NOT_HANDLED(prl_strg.sys)

  Test 2: We also did a qemu-img convert from an ubuntu 14.04 disk and
  this works perfect.

  Thanks a lot
  Moritz

  PS: Installation of Host-Server uses: ubuntu vivid 15.04 with
  qemu-system     1:2.2+dfsg-5expubuntu9.4
  libvirt-bin     1.2.12-0ubuntu14.2
  libvirt-glib-1.0-0      0.1.9-4
  libvirt0        1.2.12-0ubuntu14.2
  virt-manager    1:1.0.1-5ubuntu1

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1496712/+subscriptions
