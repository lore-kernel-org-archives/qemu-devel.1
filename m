Received: from eggs.gnu.org ([209.51.188.92]:58153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gw3Io-0006W3-Jm
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 06:11:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gw3Ii-0001Fm-Ro
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 06:11:06 -0500
Received: from indium.canonical.com ([91.189.90.7]:58770)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gw3Ii-0001Eo-LJ
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 06:11:00 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gw3Ig-0000BP-L2
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 11:10:58 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 9D7FF2E80CB
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 11:10:58 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 Feb 2019 10:56:40 -0000
From: Ali Sag <1808928@bugs.launchpad.net>
Reply-To: Bug 1808928 <1808928@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154511858636.8591.3431958243733477284.malonedeb@gac.canonical.com>
Message-Id: <155057380013.634.5849250806432584436.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1808928] Re: Bitmap Extra data is not supported
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Sorry, because of log time, VM logs were removed. Journalctl for libvirtd i=
s remain.. It was like that.
018-12-17 17:01:50.990+0000: 43198: error : qemuMonitorIORead:606 : Unable =
to read from monitor: Connection reset by peer
Dec 17 20:01:50 vm-kvm09 libvirtd[43198]: 2018-12-17 17:01:50.991+0000: 431=
98: error : qemuProcessReportLogError:1935 : internal error: qemu unexpecte=
dly closed the monitor: .guest_agent.0 -chardev spicevmc,id=3Dcharchannel1,=
name=3Dvdagent -device virtserialport,bus=3Dvirtio
Dec 17 20:01:51 vm-kvm09 libvirtd[43198]: 2018-12-17T17:01:50.984315Z qemu-=
kvm: -drive file=3D/var/lib/libvirt/images/exo1-jb-h01-2.qcow2,format=3Dqco=
w2,if=3Dnone,id=3Ddrive-virtio-disk1,cache=3Dnone: Bitmap extra data is not=
 supported
Dec 17 20:02:02 vm-kvm09 libvirtd[43198]: 2018-12-17 17:02:02.652+0000: 432=
03: warning : virQEMUCapsInit:923 : Failed to get host CPU cache info
Dec 17 20:02:02 vm-kvm09 libvirtd[43198]: 2018-12-17 17:02:02.668+0000: 689=
90: warning : virQEMUCapsInit:923 : Failed to get host CPU cache info
Dec 17 20:02:02 vm-kvm09 libvirtd[43198]: 2018-12-17 17:02:02.683+0000: 170=
99: warning : virQEMUCapsInit:923 : Failed to get host CPU cache info
Dec 17 20:09:58 vm-kvm09 libvirtd[43198]: 2018-12-17 17:09:58.700+0000: 688=
89: warning : virQEMUCapsInit:923 : Failed to get host CPU cache info
Dec 17 20:09:58 vm-kvm09 libvirtd[43198]: 2018-12-17 17:09:58.717+0000: 432=
00: warning : virQEMUCapsInit:923 : Failed to get host CPU cache info
Dec 17 20:09:58 vm-kvm09 libvirtd[43198]: 2018-12-17 17:09:58.732+0000: 432=
02: warning : virQEMUCapsInit:923 : Failed to get host CPU cache info
Dec 17 20:09:59 vm-kvm09 libvirtd[43198]: 2018-12-17 17:09:59.144+0000: 431=
98: error : qemuMonitorIORead:606 : Unable to read from monitor: Connection=
 reset by peer
Dec 17 20:09:59 vm-kvm09 libvirtd[43198]: 2018-12-17 17:09:59.145+0000: 431=
98: error : qemuProcessReportLogError:1935 : internal error: qemu unexpecte=
dly closed the monitor: 2018-12-17T17:09:59.132340Z qemu-kvm: -drive file=
=3D/var/lib/libvirt/images/exo1-jb-h01-2.qcow2,f...

I keep the broken image file. I run some qemu-img commands:

> qemu-img check /var/lib/libvirt/images/exo1-jb-h01-2.qcow2.1712
qemu-img: Could not open '/var/lib/libvirt/images/exo1-jb-h01-2.qcow2.1712'=
: Bitmap extra data is not supported

> qemu-img info /var/lib/libvirt/images/exo1-jb-h01-2.qcow2.1712
qemu-img: Could not open '/var/lib/libvirt/images/exo1-jb-h01-2.qcow2.1712'=
: Bitmap extra data is not supported

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1808928

Title:
  Bitmap Extra data is not supported

Status in QEMU:
  New

Bug description:
  i am using dirty bitmaps and drive-backup. It works as aspected.

  Lately, i encounter a disastrous error. There is not any information
  about that situation. I cannot reach/open/attach/info or anything with
  a qcow2 file.

  virsh version
  Compiled against library: libvirt 4.10.0
  Using library: libvirt 4.10.0
  Using API: QEMU 4.10.0
  Running hypervisor: QEMU 2.12.0

  "qemu-img: Could not open '/var/lib/libvirt/images/test.qcow2': Bitmap
  extra data is not supported"

  what is that mean? what should i do?
  i cannot remove bitmap. i cannot open image or query.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1808928/+subscriptions
