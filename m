Received: from eggs.gnu.org ([2001:4830:134:3::10]:50104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1do3Wn-0003cf-DH
	for qemu-devel@nongnu.org; Sat, 02 Sep 2017 04:11:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1do3Wi-0007Q0-98
	for qemu-devel@nongnu.org; Sat, 02 Sep 2017 04:11:41 -0400
Received: from indium.canonical.com ([91.189.90.7]:38996)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1do3Wi-0007Pg-2W
	for qemu-devel@nongnu.org; Sat, 02 Sep 2017 04:11:36 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1do3Wg-0003nd-2r
	for <qemu-devel@nongnu.org>; Sat, 02 Sep 2017 08:11:34 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C64B62E80E4
	for <qemu-devel@nongnu.org>; Sat,  2 Sep 2017 08:11:33 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 02 Sep 2017 08:04:05 -0000
From: Launchpad Bug Tracker <1711602@bugs.launchpad.net>
Reply-To: Bug 1711602 <1711602@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150305905460.11582.12289718300820278863.malonedeb@wampee.canonical.com>
Message-Id: <150433944938.10535.14149286760036571226.malone@ackee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1711602] Re: --copy-storage-all failing with qemu
 2.10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This bug was fixed in the package qemu - 1:2.10~rc4+dfsg-0ubuntu1

---------------
qemu (1:2.10~rc4+dfsg-0ubuntu1) artful; urgency=3Dmedium

  * Merge with Upstream 2.10-rc4; This fixes a migration issue (LP: #171160=
2);
    Remaining changes:
    - qemu-kvm to systemd unit
      - d/qemu-kvm-init: script for QEMU KVM preparation modules, ksm,
        hugepages and architecture specifics
      - d/qemu-kvm.service: systemd unit to call qemu-kvm-init
      - d/qemu-system-common.install: install systemd unit and helper script
      - d/qemu-system-common.maintscript: clean old sysv and upstart scripts
      - d/qemu-system-common.qemu-kvm.default: defaults for
        /etc/default/qemu-kvm
      - d/rules: install /etc/default/qemu-kvm
    - Enable nesting by default
      - set nested=3D1 module option on intel. (is default on amd)
      - re-load kvm_intel.ko if it was loaded without nested=3D1
      - d/p/ubuntu/expose-vmx_qemu64cpu.patch: expose nested kvm by default
        in qemu64 cpu type.
      - d/p/ubuntu/enable-svm-by-default.patch: Enable nested svm by default
        in qemu64 on amd
    - libvirt/qemu user/group support
      - qemu-system-common.postinst: remove acl placed by udev, and add ude=
vadm
        trigger.
      - qemu-system-common.preinst: add kvm group if needed
    - Distribution specific machine type
      - d/p/ubuntu/define-ubuntu-machine-types.patch: define distro machine
        types to ease future live vm migration.
      - d/qemu-system-x86.NEWS Info on fixed machine type defintions
    - improved dependencies
      - Make qemu-system-common depend on qemu-block-extra
      - Make qemu-utils depend on qemu-block-extra
      - let qemu-utils recommend sharutils
    - s390x support
      - Create qemu-system-s390x package
      - Include s390-ccw.img firmware
      - Enable numa support for s390x
    - ppc64[le] support
      - d/qemu-system-ppc.links provide usr/bin/qemu-system-ppc64le symlink
      - Enable seccomp for ppc64el
      - bump libseccomp-dev dependency, 2.3 is the minimum for ppc64
    - arch aware kvm wrappers
    - update VCS-git to match the Artful branch
    - disable missing x32 architecture
    - d/rules: or32 is now named or1k (since 4a09d0bb)
    - d/qemu-system-common.docs: new paths since (ac06724a)
    - d/qemu-system-common.install: qmp-commands.txt removed, but replaced
      by qapi-schema.json which is already packaged (since 4d8bb958)
    - d/p/02_kfreebsd.patch: utimensat is no more optional upstream (Update
      to Debian patch to match qemu 2.10)
    - s390x package now builds correctly on all architectures (LP 1710695)
  * Added changes:
    - d/qemu-system-common.docs: adapt new path of live-block-operations.rst
      since 8508eee7
    - d/qemu-system-common.docs: adapt q35 config paths since 9ca019c1
    - make nios2/hppa not installed explicitly until further stablized
    - d/qemu-guest-agent.install: add the new guest agent reference man page
      qemu-ga-ref
    - d/qemu-system-common.install: add the now generated qapi/qmp reference
      along the qapi intro
    - d/not-installed: ignore further generated (since 56e8bdd4) files in
      dh_missing that are already provided in other formats qemu-doc,
      qemu-qmp-ref,qemu-ga-ref
    - d/p/ubuntu/define-ubuntu-machine-types.patch: update to match new
      changes in 2.10-rc4

 -- Christian Ehrhardt <christian.ehrhardt@canonical.com>  Fri, 25 Aug
2017 07:49:30 +0200

** Changed in: qemu (Ubuntu)
       Status: In Progress =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1711602

Title:
  --copy-storage-all failing with qemu 2.10

Status in QEMU:
  Fix Committed
Status in qemu package in Ubuntu:
  Fix Released

Bug description:
  We fixed an issue around disk locking already in regard to qemu-nbd
  [1], but there still seem to be issues.

  $ virsh migrate --live --copy-storage-all kvmguest-artful-normal qemu+ssh=
://10.22.69.196/system
  error: internal error: qemu unexpectedly closed the monitor: 2017-08-18T1=
2:10:29.800397Z qemu-system-x86_64: -chardev pty,id=3Dcharserial0: char dev=
ice redirected to /dev/pts/0 (label charserial0)
  2017-08-18T12:10:48.545776Z qemu-system-x86_64: load of migration failed:=
 Input/output error

  Source libvirt log for the guest:
  2017-08-18 12:09:08.251+0000: initiating migration
  2017-08-18T12:09:08.809023Z qemu-system-x86_64: Unable to read from socke=
t: Connection reset by peer
  2017-08-18T12:09:08.809481Z qemu-system-x86_64: Unable to read from socke=
t: Connection reset by peer

  Target libvirt log for the guest:
  2017-08-18T12:09:08.730911Z qemu-system-x86_64: load of migration failed:=
 Input/output error
  2017-08-18 12:09:09.010+0000: shutting down, reason=3Dcrashed

  Given the timing it seems that the actual copy now works (it is busy ~10 =
seconds on my environment which would be the copy).
  Also we don't see the old errors we saw before, but afterwards on the act=
ual take-over it fails.

  Dmesg has no related denials as often apparmor is in the mix.

  Need to check libvirt logs of source [2] and target [3] in Detail.

  [1]: https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg02200.html
  [2]: http://paste.ubuntu.com/25339356/
  [3]: http://paste.ubuntu.com/25339358/

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1711602/+subscriptions
