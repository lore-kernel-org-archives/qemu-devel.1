Received: from eggs.gnu.org ([2001:4830:134:3::10]:54242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ehCEI-0004wA-CS
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 05:36:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ehCED-0004BD-CY
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 05:36:30 -0500
Received: from indium.canonical.com ([91.189.90.7]:44416)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ehCED-00049o-3X
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 05:36:25 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ehCEB-0003Zo-Ss
	for <qemu-devel@nongnu.org>; Thu, 01 Feb 2018 10:36:23 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id CBDDB2E806D
	for <qemu-devel@nongnu.org>; Thu,  1 Feb 2018 10:36:23 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Feb 2018 10:26:33 -0000
From: Launchpad Bug Tracker <1716028@bugs.launchpad.net>
Reply-To: Bug 1716028 <1716028@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150489404292.23034.16812601554685741285.malonedeb@wampee.canonical.com>
Message-Id: <151748079817.3710.9585090284915255806.malone@ackee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1716028] Re: qemu 2.10 locks images with no
 feature flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This bug was fixed in the package libvirt - 4.0.0-1ubuntu1

---------------
libvirt (4.0.0-1ubuntu1) bionic; urgency=3Dmedium

  * Merged with Debian unstable (4.0)
    This closes several bugs:
    - Error generating apparmor profile when hostname contains spaces
      (LP: #799997)
    - qemu 2.10 locks files, libvirt shared now sets share-rw=3Don (LP: #17=
16028)
    - libvirt usb passthrough throws apparmor denials related to
      /run/udev/data/+usb (LP: #1727311)
    - AppArmor denies access to /sys/block/*/queue/max_segments (LP: #17296=
26)
    - iohelper improvements to let bypass-cache work without opening up the
      apparmor isolation (LP: #1719579)
    - nodeinfo on s390x to contain more CPU info (LP: #1733688)
    - Upgrade libvirt >=3D 4.0 (LP: #1745934)
  * Remaining changes:
    - Disable libssh2 support (universe dependency)
    - Disable firewalld support (universe dependency)
    - Disable selinux
    - Set qemu-group to kvm (for compat with older ubuntu)
    - Additional apport package-hook
    - Modifications to adapt for our delayed switch away from libvirt-bin (=
can
      be dropped >18.04).
      + d/p/ubuntu/libvirtd-service-add-bin-alias.patch: systemd: define al=
ias
        to old service name so that old references work
      + d/p/ubuntu/libvirtd-init-add-bin-alias.patch: sysv init: define ali=
as
        to old service name so that old references work
      + d/control: transitional package with the old name and maintainer
        scripts to handle the transition
    - Backwards compatible handling of group rename (can be dropped >18.04).
    - config details and autostart of default bridged network. Creating tha=
t is
      now the default in general, yet our solution provides the following on
      top as of today:
      + autostart the default network by default
      + do not autostart if subnet is already taken (e.g. in guests).
    - d/p/ubuntu/Allow-libvirt-group-to-access-the-socket.patch: This is
      the group based access to libvirt functions as it was used in Ubuntu
      for quite long.
      + d/p/ubuntu/daemon-augeas-fix-expected.patch fix some related tests
        due to the group access change.
    - ubuntu/parallel-shutdown.patch: set parallel shutdown by default.
    - d/p/ubuntu/enable-kvm-spice.patch: compat with older Ubuntu qemu/kvm
      which provided a separate kvm-spice.
    - d/p/ubuntu/ubuntu-libxl-qemu-path.patch: this change was split. The
      section that adapts the path of the emulator to the Debian/Ubuntu
      packaging is kept.
    - d/p/ubuntu/ubuntu-libxl-Fix-up-VRAM-to-minimum-requirements.patch: au=
to
      set VRAM to minimum requirements
    - d/p/ubuntu/xen-default-uri.patch: set default URI on xen hosts
    - Add libxl log directory
    - libvirt-uri.sh: Automatically switch default libvirt URI for users on
      Xen dom0 via user profile (was missing on changelogs before)
    - d/p/ubuntu/apibuild-skip-libvirt-common.h: drop libvirt-common.h from
      included_files to avoid build failures due to duplicate definitions.
    - Update README.Debian with Ubuntu changes
    - Convert libvirt0, libnss_libvirt and libvirt-dev to multi-arch.
    - Enable some additional features on ppc64el and s390x (for arch parity)
      + systemtap, zfs, numa and numad on s390x.
      + systemtap on ppc64el.
    - fix conffile upgrade handling to avoid obsolete files
      and inactive duplicates (LP 1694159)
    - d/t/control, d/t/smoke-qemu-session: fixup smoke-qemu-session by maki=
ng
      vmlinuz available and accessible (Debian bug 848314)
    - d/test/smoke-lxc workaround for debbug 848317/867379
    - d/t/control, d/t/smoke-lxc: fix up lxc smoke test (Debian bug 848317)
    - Add dnsmasq configuration to work with system wide dnsmasq (drop >18.=
04,
      no more UCA onto Xenial then which has global dnsmasq by default).
    - d/p/ubuntu/ubuntu_machine_type.patch: accept ubuntu types as pci440fx
    - conffile handling of files dropped in 3.5 (can be dropped >18.04)
      + /etc/init.d/virtlockd was sysv init only
      + /etc/apparmor.d/local/usr.sbin.libvirtd and
        /etc/apparmor.d/local/usr.lib.libvirt.virt-aa-helper are now genera=
ted
        by dh_apparmor as needed
    - Reworked apparmor Delta, especially the more complex delta is dropped
      now, also our former delta is now split into logical pieces, has
      improved comments and is part of a continuous upstreaming effort.
      Listing related remaining changes:
      + d/p/0001-apparmor-Allow-pygrub-to-run-on-Debian-Ubuntu.patch: appar=
mor:
        Allow pygrub to run on Debian/Ubuntu
      + d/p/0003-apparmor-libvirt-qemu-Allow-read-access-to-overcommi.patch:
        apparmor, libvirt-qemu: Allow read access to overcommit_memory
      + d/p/0007-apparmor-libvirt-qemu-Allow-owner-read-access-to-PRO.patch:
        apparmor, libvirt-qemu: Allow owner read access to @{PROC}/*/auxv
      + d/p/0017-apparmor-virt-aa-helper-Allow-access-to-tmp-director.patch:
        apparmor, virt-aa-helper: Allow access to tmp directories
      + d/p/ubuntu-aa/0020-virt-aa-helper-ubuntu-storage-paths.patch:
        apparmor, virt-aa-helper: Allow various storage pools and image
        locations
      + d/p/0021-apparmor-virt-aa-helper-Add-openvswitch-support.patch:
        apparmor, virt-aa-helper: Add openvswitch support
      + d/p/0025-apparmor-fix-newer-virt-manager-1.4.0.patch: Add Apparmor
        permissions so virt-manager 1.4.0 viewing works (LP 1668681).
      + d/p/0029-appmor-libvirt-qemu-Add-9p-support.patch: appmor,
        libvirt-qemu: Add 9p support
      + d/p/0030-virt-aa-helper-Complete-9p-support.patch: virt-aa-helper:
        add l to 9p file options.
      + d/p/0031-virt-aa-helper-Ask-for-no-deny-rule-for-readonly-dis.patch:
        virt-aa-helper: Ask for no deny rule for readonly disk (renamed and
        reworded, was virt-aa-helper-no-explicity-deny-for-basefiles.patch)
      + d/p/0032-apparmor-libvirt-qemu-Allow-reading-charm-specific-c.patch:
        apparmor, libvirt-qemu: Allow reading charm-specific ceph config
      + d/p/0033-UBUNTU-only-apparmor-for-kvm.powerpc-LP-1680384.patch: all=
ow
        commands executed by ubuntu only kvm wrapper on ppc64el (LP 1686621=
).
      + d/p/0034-apparmor-virt-aa-helper-access-for-snapped-nova.patch:
        apparmor, virt-aa-helper: access for snapped nova
  * Dropped Changes (Upstream):
    - d/p/0005-apparmor-libvirt-qemu-Allow-use-of-sgabios.patch: apparmor,
      libvirt-qemu: Allow use of sgabios
    - d/p/0006-apparmor-libvirt-qemu-Silence-lttng-related-deny-mes.patch:
      apparmor, libvirt-qemu: Silence lttng related deny messages
    - d/p/0008-apparmor-libvirt-qemu-Allow-read-access-to-sysfs-sys.patch:
      apparmor, libvirt-qemu: Allow read access to sysfs system info
    - d/p/0009-apparmor-libvirt-qemu-Allow-read-access-to-max_mem_r.patch:
      apparmor, libvirt-qemu: Allow read access to max_mem_regions
    - d/p/0010-apparmor-libvirt-qemu-Allow-qemu-block-extra-librari.patch:
      apparmor, libvirt-qemu: Allow qemu-block-extra libraries
    - d/p/0012-apparmor-libvirtd-Allow-access-to-netlink-sockets.patch:
      apparmor, libvirtd: Allow access to netlink sockets
    - d/p/0013-apparmor-Add-rules-for-mediation-support.patch:
      apparmor: Add rules for mediation support
    - d/p/0015-apparmor-virt-aa-helper-Allow-access-to-ecryptfs-fil.patch:
      apparmor, virt-aa-helper: Allow access to ecryptfs files
    - d/p/0016-apparmor-libvirtd-Allow-ixr-to-var-lib-libvirt-virtd.patch:
      apparmor, libvirtd: Allow ixr to /var/lib/libvirt/virtd*
    - d/p/0018-apparmor-virt-aa-helper-Add-ipv6-network-policy.patch:
      apparmor, virt-aa-helper: Add ipv6 network policy
    - d/p/0019-apparmor-virt-aa-helper-Allow-access-to-sys-bus-usb-.patch:
      apparmor, virt-aa-helper: Allow access to /sys/bus/usb/devices
    - d/p/0023-apparmor-qemu-won-t-call-qemu-nbd.patch: apparmor: qemu
      won't call qemu-nbd
    - d/p/0027-apparmor-allow-reading-cmdline-of-shutdown-signal.patch:
      apparmor: allow to parse cmdline of the pid that send the shutdown
      signal (LP 1680384).
    - d/p/0028-apparmor-add-default-pki-path-of-lbvirt-spice.patch:
      apparmor: add default pki path of lbvirt-spice (LP 1690140)
    - d/p/ubuntu-aa/0035-virt-aa-helper-locking-disk-files-for-qemu-2.10.pa=
tch:
      for compatibility with the behavior of qemu 2.10 this adds locking
      permission to rules generated for disk files (LP 1709818)
    - d/p/ubuntu-aa/0036-virt-aa-helper-locking-loader-nvram-for-qemu-2.10.=
patch:
      for compatibility with the behavior of qemu 2.10 this adds locking
      permission to rules generated for loader/nvram (LP 1710960)
    - d/p/ubuntu-aa/0037-virt-aa-helper...: grant locking permission on app=
end
      files (LP 1726804)
    - d/p/ubuntu-aa/0038-virt-aa-helper-fix-paths-for-usb-hostdevs.patch:
      fix path generation for USB host devices (LP 1552241)
    - d/p/ubuntu-aa/0039-virt-aa-helper-fix-libusb-access-to-udev-usb-data.=
patch:
      generate valid rules on usb passthrough (LP 1686324)
    - d/p/avoid-double-locking.patch: fix a deadlock that could occur when
      libvirtd interactions raced with dbus causing a deadlock (LP 1714254).
    - d/p/u/gnulib-getopt-posix-Fix-build-failure-when-using-ac_cv_head.pat=
ch:
      fix FTBFS with glibc 2.26 (LP 1718668)
    - Extended handling of apparmor profiles - clear lost profiles via cron
      (now cleared by virt-aa-helper on domain stop)
    - nat only on some ports <port start=3D'1024' end=3D'65535'/> (upstream
      default now if nothing is specified, actually dropped last cycle)
  * Dropped Changes (In Debian or no more important):
    - d/p/0002-apparmor-libvirt-qemu-Allow-macvtap-access.patch: apparmor,
      libvirt-qemu: Allow macvtap access
    - d/p/0004-apparmor-Explicit-deny-for-setpcap.patch: apparmor: Explicit
      deny for setpcap (LP 522845).
    - d/p/0014-apparmor-virt-aa-helper-Improve-comment-about-backin.patch:
      apparmor, virt-aa-helper: Improve comment about backing store
    - d/p/0022-apparmor-drop-references-to-qemu-kvm.patch: apparmor: drop
      references to qemu-kvm
    - d/p/0024-apparmor-virt-aa-helper-Allow-access-to-name-service.patch:
      apparmor, virt-aa-helper: Allow access to name services
    - d/p/0026-apparmor-add-generic-base-vfio-device.patch: apparmor: add
      /dev/vfio for vf (hot) attach (LP 1680384) (added by virt-aa-helper p=
er
      guest if needed).
    - d/p/0011-apparmor-libvirt-qemu-Allow-access-to-hugepage-mount.patch:
      apparmor, libvirt-qemu: Allow access to hugepage mounts
    - Disable sheepdog (was for universe dependency, but is now only a sugg=
est)
    - d/p/ubuntu/storage-disable-gluster-test: gluster not enabled, skip te=
st
  * Dropped Changes (In Debian/Upstream now based on interim 3.10 work) som=
e of
    these were never released, but important to mention for the bug referen=
ces:
    - libnss-libvirt once enabled causes apt to call getdents
      avoid this being an issue by dropping a apt conf that allows
      this in seccomp (LP: #1732030).
    - d/libvirt-daemon-system.postrm: clean up more libvirt directories on
      purge
    - d/p/ubuntu-aa/0041-apparmor-allow-unix-stream-for-p2p-migrations.patc=
h:
      apparmor: allow unix stream for p2p migrations
    - d/p/ubuntu-aa/0043-security-apparmor-implement-domainSetPathLabel.pat=
ch:
      this replaces the hugepage rules and fixes many more formerly missing
    - d/p/ubuntu-aa/0044-security-full-path-option-for-DomainSetPathLabel.p=
atch:
      allowing to have path wildcards on labels set by domain callbacks
    - d/p/ubuntu-aa/0045-security-apparmor-add-Set-Restore-ChardevLabel.pat=
ch:
      apparmor implementation of security callback
    - d/p/ubuntu-aa/0046-apparmor-virt-aa-helper-drop-static-channel-rule.p=
atch:
      this is now covered by chardev label callbacks
  * Added Changes:
    - Revert Debian change "Drop libvirt-bin upgrade handling"
      This is needed in Ubuntu one last time (drop >18.04)
    - Revert Debian change "Drop maintscript helpers for versions predating
      jessie and wheezy-backports". This is needed in Ubuntu one last
      time (drop >18.04)
    - Refreshed d/p/* to match new version (only fuzz, no semantic change)
    - d/libvirt-daemon-system.postrm: change order of libvirt-qemu removal
      to avoid error messages on purge
    - remove no more used libvirt-dnsmasq user (drop >18.04)
    - d/p/ubuntu-aa/0040-apparmor-add-mediation-rules-for-unconfined.patch:
      apparmor: add mediation rules for unconfined guests
    - d/p/ubuntu-aa/0042-security-introduce-virSecurityManager-Set-Restore-=
Ch
      .patch: backport upstream cahnge to expose already used chardev calls.
    - d/libvirt-daemon-system.postrm: Remove the default.xml network link
      set up by postinst.
    - d/libvirt-daemon-system.maintscript: remove the now dropped conffile
      /etc/cron.daily/libvirt-daemon-system
    - d/libvirt-daemon-system.postinst: fixups for autostart default network
      - use modern shell syntax
      - try more default networks before giving up to enable by default
    - d/p/ubuntu-aa/0020-virt-aa-helper-ubuntu-storage-paths.patch:
      add multipass image path and mark as ubuntu only change.
    - d/rules: install virtlockd correctly with defaults file (LP: #1729516)
    - extended d/p/0025-apparmor-fix-newer-virt-manager-1.4.0.patch to cover
      the slightly changed behavior of libvirt 4.0 (LP: #1741617)
    - d/control: make libvirt-daemon-driver-storage-rbd a recommend instead=
 of
      just a suggest to have 3rd party relying on rbd out of the box workin=
g.
      This is deprecated and users of rbd backend should start depending on
      this package for it will be dropped to a suggest in future releases.

 -- Christian Ehrhardt <christian.ehrhardt@canonical.com>  Thu, 14 Dec
2017 14:15:55 +0100

** Changed in: libvirt (Ubuntu)
       Status: Triaged =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1716028

Title:
  qemu 2.10 locks images with no feature flag

Status in QEMU:
  Opinion
Status in libvirt package in Ubuntu:
  Fix Released
Status in qemu package in Ubuntu:
  Opinion
Status in libvirt source package in Artful:
  Triaged
Status in qemu source package in Artful:
  New

Bug description:
  1) % lsb_release -rd
  Description:	Ubuntu Artful Aardvark (development branch)
  Release:	17.10

  2) % apt-cache policy qemu-system-x86
  qemu-system-x86:
    Installed: 1:2.10~rc3+dfsg-0ubuntu1
    Candidate: 1:2.10+dfsg-0ubuntu1
    Version table:
       1:2.10+dfsg-0ubuntu1 500
          500 http://archive.ubuntu.com//ubuntu devel/main amd64 Packages
   *** 1:2.10~rc3+dfsg-0ubuntu1 100
          100 /var/lib/dpkg/status

  3) qemu locks image files with no way to discover this feature nor how
  to disable it

  4) qemu provides a way to query if it supports image locking, and what
  the default value is, and how to disable the locking via cli

  qemu 2.10 now will lock image files and warn if an image is currently
  locked.  This prevent qemu from running (and possibly corrupting said
  image).

  However, qemu does not provide any way to determine if a qemu binary
  actually has this capability.  Normally behavior changing features are
  exposed via some change to the qemu help menu or QMP/QAPI output of
  capabilities.

  I believe this slipped through since libvirt already does image
  locking, but direct cli users will be caught by this change.

  In particular, we have a use-case where we simulate multipath disks by
  creating to disks which point to the same file which now breaks
  without adding the 'file.locking=3Doff' to the -drive parameters;  which
  is also completely undocumented and unexposed.

  Some parts of the cli like -device allow querying of settable options
  (qemu-system-x86 -device scsi_hd,?)  but nothing equivalent exists for
  -drive parameters.

  ProblemType: Bug
  DistroRelease: Ubuntu 17.10
  Package: qemu-system-x86 1:2.10~rc3+dfsg-0ubuntu1
  ProcVersionSignature: Ubuntu 4.12.0-11.12-generic 4.12.5
  Uname: Linux 4.12.0-11-generic x86_64
  NonfreeKernelModules: zfs zunicode zavl zcommon znvpair
  ApportVersion: 2.20.6-0ubuntu7
  Architecture: amd64
  Date: Fri Sep  8 12:56:53 2017
  JournalErrors:
   Hint: You are currently not seeing messages from other users and the sys=
tem.
         Users in groups 'adm', 'systemd-journal' can see all messages.
         Pass -q to turn off this notice.
   -- Logs begin at Mon 2017-01-30 11:56:02 CST, end at Fri 2017-09-08 12:5=
6:46 CDT. --
   -- No entries --
  KvmCmdLine: COMMAND         STAT  EUID  RUID   PID  PPID %CPU COMMAND
  MachineType: HP ProLiant DL360 Gen9
  ProcEnviron:
   TERM=3Dxterm
   PATH=3D(custom, no user)
   XDG_RUNTIME_DIR=3D<set>
   LANG=3Den_US.UTF-8
   SHELL=3D/bin/bash
  ProcKernelCmdLine: BOOT_IMAGE=3D/vmlinuz-4.12.0-11-generic root=3DUUID=3D=
45354276-e0c0-4bf6-9083-f130b89411cc ro --- console=3DttyS1,115200
  SourcePackage: qemu
  UpgradeStatus: No upgrade log present (probably fresh install)
  dmi.bios.date: 03/05/2015
  dmi.bios.vendor: HP
  dmi.bios.version: P89
  dmi.chassis.type: 23
  dmi.chassis.vendor: HP
  dmi.modalias: dmi:bvnHP:bvrP89:bd03/05/2015:svnHP:pnProLiantDL360Gen9:pvr=
:cvnHP:ct23:cvr:
  dmi.product.family: ProLiant
  dmi.product.name: ProLiant DL360 Gen9
  dmi.sys.vendor: HP

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1716028/+subscriptions
