Received: from eggs.gnu.org ([2001:4830:134:3::10]:44667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eOpYp-000256-5T
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 13:45:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eOpYk-0002m7-65
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 13:45:47 -0500
Received: from indium.canonical.com ([91.189.90.7]:45628)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eOpYj-0002lL-Vp
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 13:45:42 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eOpYh-0004ro-Bh
	for <qemu-devel@nongnu.org>; Tue, 12 Dec 2017 18:45:39 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 0FA212E807D
	for <qemu-devel@nongnu.org>; Tue, 12 Dec 2017 18:45:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 12 Dec 2017 18:39:28 -0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Reply-To: Bug 1723161 <1723161@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150782239801.1729.1327212510076491094.malonedeb@chaenomeles.canonical.com>
Message-Id: <151310396851.3145.17646509985801497974.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1723161] Re: Migration failing in qemu-2.10.1 but
 working qemu-2.9.1 and earlier with same options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This still seems to be present on current head

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1723161

Title:
  Migration failing in qemu-2.10.1 but working qemu-2.9.1 and earlier
  with same options

Status in QEMU:
  New

Bug description:
  =

  Qemu-2.10.1 migration failing with the following error:
  Receiving block device images
  qemu-system-x86_64: error while loading section id 2(block)
  qemu-system-x86_64: load of migration failed: Input/output error

  Migration is setup on the destination system of the migration using:
  -incoming tcp:0:4444

  Migration is initiated from the source using the following commands in it=
s qemu monitor:
  migrate -b "tcp:localhost:4444"

  The command-line used in both the source and destination is:
  qemu-system-x86_64 \
          -nodefaults \
          -pidfile vm0.pid \
          -enable-kvm \
          -machine q35 \
          -cpu host -smp 2 \
          -m 4096M \
          -drive if=3Dpflash,format=3Draw,unit=3D0,file=3DOVMF_CODE.fd,read=
only \
          -drive if=3Dpflash,format=3Draw,unit=3D1,file=3DOVMF_VARS.fd \
          -drive file=3D${HDRIVE},format=3Dqcow2 \
          -drive media=3Dcdrom \
          -usb -device usb-tablet \
          -vga std -vnc :0 \
          -net nic,macaddr=3D${TAPMACADDR} -net user,net=3D192.168.2.0/24,d=
hcpstart=3D192.168.2.10 \
          -serial stdio \
          -monitor unix:${MONITORSOCKET},server,nowait

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1723161/+subscriptions
