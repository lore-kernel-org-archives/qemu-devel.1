Received: from eggs.gnu.org ([2001:4830:134:3::10]:43602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ejncf-0005cA-Rd
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 09:56:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ejncc-0005Vu-Lf
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 09:56:25 -0500
Received: from indium.canonical.com ([91.189.90.7]:48386)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ejncc-0005Uv-CI
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 09:56:22 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ejnca-0007zG-1x
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 14:56:20 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 062582E80D4
	for <qemu-devel@nongnu.org>; Thu,  8 Feb 2018 14:56:20 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Feb 2018 14:36:05 -0000
From: Launchpad Bug Tracker <1350435@bugs.launchpad.net>
Reply-To: Bug 1350435 <1350435@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140730162025.27276.9650.malonedeb@soybean.canonical.com>
Message-Id: <151810057134.12722.9789147457318428651.malone@ackee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1350435] Re: tcg.c:1693: tcg fatal error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This bug was fixed in the package qemu - 1:2.11+dfsg-1ubuntu1

---------------
qemu (1:2.11+dfsg-1ubuntu1) bionic; urgency=3Dmedium

  * Merge with Debian testing, among other fixes this includes
    - fix fatal error on negative maxcpus (LP: #1722495)
    - fix segfault on dump-guest-memory on guests without memory (LP: #1723=
381)
    - linux user threading issues (LP: #1350435)
    - TOD-Clock Epoch Extension Support on s390x (LP: #1732691)
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
    - arch aware kvm wrappers
  * Added Changes
    - update VCS-git to match the bionic branch
    - sdl2 is yet too unstable for the LTS Ubuntu release given the reports
      we still see upstream and in Debian - furthermore sdl2 isn't in main =
yet,
      so we revert related changes to stick with the proven for now:
      - 0fd25810 - do not build-depend on libx11-dev (libsdl2-dev already
                   depends on it)
      - 9594f820 - switch from sdl1.2 to sdl2 (#870025)
    - d/qemu-system-x86.README.Debian: document intention of nested being
      default is comfort, not full support
    - update Ubuntu machine types for qemu 2.11
    - qemu-guest-agent: freeze-hook fixes (LP: #1484990)
      - d/p/guest-agent-freeze-hook-skip-dpkg-artifacts.patch
      - d/qemu-guest-agent.install: provide /etc/qemu/fsfreeze-hook
      - d/qemu-guest-agent.dirs: provide /etc/qemu/fsfreeze-hook.d
    - Create and install pxe netboot images for KVM s390x (LP: #1732094)
      - d/rules enable install s390x-netboot.img
      - debian/patches/ubuntu/partial-SLOF-for-s390x-netboot-compilation.pa=
tch
    - d/control-in: enable RDMA support in qemu (LP: #1692476)
    - on s390x provide facility bits 81 (ppa15) and 82 (bpb) (LP: #1743560)
      - d/p/ubuntu/linux-headers-update-to-4.15-rc1.patch
      - d/p/ubuntu/linux-headers-update-4.15-rc9.patch
      - d/p/ubuntu/lp1743560-s390x-kvm-Handle-bpb-feature.patch
      - d/p/ubuntu/lp1743560-s390x-kvm-provide-stfle.81.patch
    - tolerate ipxe size change on migrations to >=3D18.04 (LP: #1713490)
      - d/p/ubuntu/pre-bionic-256k-ipxe-efi-roms.patch: old machine types
        reference 256k path
      - d/control: depend on ipxe-qemu-256k-compat-efi-roms to be able to
        handle incoming migrations from former releases.
    - d/control-in: enable seccomp on s390x
  * Dropped changes (no more needed):
    - Dropped VHOST_NET_ENABLED and KVM_HUGEPAGES from /etc/default/qemu-kvm
      The functionality is retained for upgraders, but is deprecated.
      Post 18.04 the implementation for these configurations will be remove=
d.
  * Dropped changes (in Debian now):
    - ppc64[le] support
      - Enable seccomp for ppc64el
      - bump libseccomp-dev dependency, 2.3 is the minimum for ppc64
    - disable missing x32 architecture
    - d/rules: or32 is now named or1k (since 4a09d0bb)
    - d/qemu-system-common.docs: new paths since (ac06724a)
    - d/qemu-system-common.install: qmp-commands.txt removed, but replaced
      by qapi-schema.json which is already packaged (since 4d8bb958)
    - d/p/02_kfreebsd.patch: utimensat is no more optional upstream (Update
      to Debian patch to match qemu 2.10)
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
  * Dropped changes (integrated upstream):
    - d/p/detect-ITS-and-skip-usage-on-older-kernel.patch to avoid crashes
      on arm64 when doing suspend/resume and reboots due to older kernels n=
ot
      supporting ITS (LP 1731051).
    - Apply linux-user-return-EINVAL-from-prctl-PR_-_SECCOMP.patch from
      James Cowgill to prevent qemu-user from forwarding prctl seccomp
      calls (LP 1726394)
    - update to upstream 2.10.1 point release (LP 1722808)

 -- Christian Ehrhardt <christian.ehrhardt@canonical.com>  Mon, 22 Jan
2018 14:35:18 +0100

** Changed in: qemu (Ubuntu)
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1350435

Title:
  tcg.c:1693: tcg fatal error

Status in launchpad-buildd:
  Won't Fix
Status in QEMU:
  Fix Released
Status in qemu package in Ubuntu:
  Fix Released

Bug description:
  this started happening after the launchpad buildd trusty deploy
  https://code.launchpad.net/~costamagnagianfranco/+archive/ubuntu/firefox/=
+build/6224439

  =

  debconf-updatepo
  qemu: uncaught target signal 11 (Segmentation fault) - core dumped
  Segmentation fault (core dumped)
  qemu: uncaught target signal 11 (Segmentation fault) - core dumped
  Segmentation fault (core dumped)
  /build/buildd/qemu-2.0.0+dfsg/tcg/tcg.c:1693: tcg fatal error
  /build/buildd/qemu-2.0.0+dfsg/tcg/tcg.c:1693: tcg fatal error

  this seems to be the patch needed
  https://patches.linaro.org/32473/

To manage notifications about this bug go to:
https://bugs.launchpad.net/launchpad-buildd/+bug/1350435/+subscriptions
