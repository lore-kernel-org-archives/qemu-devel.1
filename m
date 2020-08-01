Return-Path: <SRS0=xT3E=BL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C63C433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Aug 2020 05:16:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DE1A20716
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Aug 2020 05:16:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DE1A20716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1jsp-0004ov-L0
	for qemu-devel@archiver.kernel.org; Sat, 01 Aug 2020 01:16:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55848)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k1jsE-0004Nm-6k
 for qemu-devel@nongnu.org; Sat, 01 Aug 2020 01:15:58 -0400
Received: from indium.canonical.com ([91.189.90.7]:40600)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k1jsA-0002w3-GH
 for qemu-devel@nongnu.org; Sat, 01 Aug 2020 01:15:57 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k1js8-0005Y3-1P
 for <qemu-devel@nongnu.org>; Sat, 01 Aug 2020 05:15:52 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 06E442E80EE
 for <qemu-devel@nongnu.org>; Sat,  1 Aug 2020 05:15:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2020 05:05:56 -0000
From: Launchpad Bug Tracker <1749393@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=qemu; component=main;
 status=Fix Released; importance=Undecided;
 assignee=christian.ehrhardt@canonical.com; 
X-Launchpad-Bug-Tags: arm linux-user qemu-20.10
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: doko gerard-f-vidal-4 hertzog janitor
 laurent-vivier paelzer peterogden pmaydell rth
X-Launchpad-Bug-Reporter: =?utf-8?q?Rapha=C3=ABl_Hertzog_=28hertzog=29?=
X-Launchpad-Bug-Modifier: Launchpad Janitor (janitor)
References: <151859702399.9461.6832978283203997178.malonedeb@chaenomeles.canonical.com>
Message-Id: <159625836082.31160.8655355779845819548.malone@ackee.canonical.com>
Subject: [Bug 1749393] Re: sbrk() not working under qemu-user with a
 PIE-compiled binary?
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="a24057fea7e4c6a98c0220d5f878da0f3c783699";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 8b873500c7bf0fba37464bef61ce03588eb48f86
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/01 01:15:52
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1749393 <1749393@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This bug was fixed in the package qemu - 1:5.0-5ubuntu3

---------------
qemu (1:5.0-5ubuntu3) groovy; urgency=3Dmedium

  * d/p/ubuntu/lp-1887763-*: fix TCG sizing that OOMed many small CI
    environments (LP: #1887763)
  * Pick further changes for groovy from debian/master since 5.0-5
    - ati-vga-check-mm_index-before-recursive-call-CVE-2020-13800.patch
      Closes: CVE-2020-13800, ati-vga allows guest OS users to trigger
      infinite recursion via a crafted mm_index value during
      ati_mm_read or ati_mm_write call.
    - revert-memory-accept-mismatching-sizes-in-memory_region_access_valid.=
..patch
      Closes: CVE-2020-13754, possible OOB memory accesses in a bunch of qe=
mu
      devices which uses min_access_size and max_access_size Memory API fie=
lds.
      Also closes: CVE-2020-13791
    - exec-set-map-length-to-zero-when-returning-NULL-CVE-2020-13659.patch
      CVE-2020-13659: address_space_map in exec.c can trigger
      a NULL pointer dereference related to BounceBuffer
    - megasas-use-unsigned-type-for-reply_queue_head-and-check-index...patch
      Closes: #961887, CVE-2020-13362, megasas_lookup_frame in hw/scsi/mega=
sas.c
      has an OOB read via a crafted reply_queue_head field from a guest OS =
user
    - megasas-use-unsigned-type-for-positive-numeric-fields.patch
      fix other possible cases like in CVE-2020-13362 (#961887)
    - megasas-fix-possible-out-of-bounds-array-access.patch
      Some tracepoints use a guest-controlled value as an index into the
      mfi_frame_desc[] array. Thus a malicious guest could cause a very low
      impact OOB errors here
    - nbd-server-avoid-long-error-message-assertions-CVE-2020-10761.patch
      Closes: CVE-2020-10761, An assertion failure issue in the QEMU NBD Se=
rver.
      This flaw occurs when an nbd-client sends a spec-compliant request th=
at is
      near the boundary of maximum permitted request length. A remote nbd-c=
lient
      could use this flaw to crash the qemu-nbd server resulting in a DoS.
    - es1370-check-total-frame-count-against-current-frame-CVE-2020-13361.p=
atch
      Closes: CVE-2020-13361, es1370_transfer_audio in hw/audio/es1370.c do=
es not
      properly validate the frame count, which allows guest OS users to tri=
gger
      an out-of-bounds access during an es1370_write() operation
    - a few patches from the stable series:
      - fix-tulip-breakage.patch
        The tulip network driver in a qemu-system-hppa emulation is broken =
in
        the sense that bigger network packages aren't received any longer a=
nd
        thus even running e.g. "apt update" inside the VM fails. Fix this.
      - 9p-lock-directory-streams-with-a-CoMutex.patch
        Prevent deadlocks in 9pfs readdir code
      - net-do-not-include-a-newline-in-the-id-of-nic-device.patch
        Fix newline accidentally sneaked into id string of a nic
      - qemu-nbd-close-inherited-stderr.patch
      - virtio-balloon-fix-free-page-hinting-check-on-unreal.patch
      - virtio-balloon-fix-free-page-hinting-without-an-iothread.patch
      - virtio-balloon-unref-the-iothread-when-unrealizing.patch
    - acpi-tmr-allow-2-byte-reads.patch (Closes: #964247)
    - reapply CVE-2020-13253 fixed from upstream:
      sdcard-simplify-realize-a-bit.patch (preparation for the next patch)
      sdcard-dont-allow-invalid-SD-card-sizes.patch (half part of CVE-2020-=
13253)
      sdcard-update-coding-style-to-make-checkpatch-happy.patch (preparatio=
nal)
      sdcard-dont-switch-to-ReceivingData-if-address-is-in..-CVE-2020-13253=
.patch
      Closes: #961297, CVE-2020-13253
    - linux-user-refactor-ipc-syscall-and-support-of-semtimedop.patch
      (Closes: #965109)
    - linux-user-add-netlink-RTM_SETLINK-command.patch (Closes: #964289)
    - d/control: since qemu-system-data now contains module(s),
      it can't be multi-arch. Ditto for qemu-block-extra.
    - qemu-system-foo: depend on exact version of qemu-system-data,
      due to the latter having modules
    - acpi-allow-accessing-acpi-cnt-register-by-byte.patch' (Closes: #96479=
3)
      This is another incarnation of the recent bugfix which actually enabl=
ed
      memory access constraints, like #964247
    - acpi-accept-byte-and-word-access-to-core-ACPI-registers.patch
      this replace acpi-allow-accessing-acpi-cnt-register-by-byte.patch
      and acpi-tmr-allow-2-byte-reads.patch, a more complete fix
    - xhci-fix-valid.max_access_size-to-access-address-registers.patch
      fix one more incarnation of the breakage after the CVE-2020-13754 fix
    - do not install outdated (0.12 and before) Changelog (Closes: #965381)
    - xgmac-fix-buffer-overflow-in-xgmac_enet_send-CVE-2020-15863.patch
      ARM-only XGMAC NIC, possible buffer overflow during packet transmissi=
on
      Closes: CVE-2020-15863
    - sm501 OOB read/write due to integer overflow in sm501_2d_operation()
      List of patches:
       sm501-convert-printf-abort-to-qemu_log_mask.patch
       sm501-shorten-long-variable-names-in-sm501_2d_operation.patch
       sm501-use-BIT-macro-to-shorten-constant.patch
       sm501-clean-up-local-variables-in-sm501_2d_operation.patch
       sm501-replace-hand-written-implementation-with-pixman-CVE-2020-12829=
.patch
      Closes: #961451, CVE-2020-12829
    - riscv-allow-64-bit-access-to-SiFive-CLINT.patch
      another fix for revert-memory-accept-.. CVE-2020-13754
    - seabios-hppa-fno-ipa-sra.patch fix ftbfs with gcc-10

qemu (1:5.0-5ubuntu2) groovy; urgency=3Dmedium

  * No change rebuild against new libnettle8 and libhogweed6 ABI.

qemu (1:5.0-5ubuntu1) groovy; urgency=3Dmedium

  * Merge with Debian testing (LP: #1749393), remaining changes:
    - qemu-kvm to systemd unit
      - d/qemu-kvm-init: script for QEMU KVM preparation modules, ksm,
        hugepages and architecture specifics
      - d/qemu-system-common.qemu-kvm.service: systemd unit to call
        qemu-kvm-init
      - d/qemu-system-common.install: install helper script
      - d/qemu-system-common.qemu-kvm.default: defaults for
        /etc/default/qemu-kvm
      - d/rules: call dh_installinit and dh_installsystemd for qemu-kvm
    - Distribution specific machine type (LP: 1304107 1621042)
      - d/p/ubuntu/define-ubuntu-machine-types.patch: define distro machine
        types
      - d/qemu-system-x86.NEWS Info on fixed machine type definitions
        for host-phys-bits=3Dtrue (LP: 1776189)
      - add an info about -hpb machine type in debian/qemu-system-x86.NEWS
      - provide pseries-bionic-2.11-sxxm type as convenience with all
        meltdown/spectre workarounds enabled by default. (LP: 1761372).
      - ubuntu-q35 alias added to auto-select the most recent q35 ubuntu ty=
pe
    - Enable nesting by default
      - d/p/ubuntu/enable-svm-by-default.patch: Enable nested svm by default
        in qemu64 on amd
        [ No more strictly needed, but required for backward compatibility ]
    - improved dependencies
      - Make qemu-system-common depend on qemu-block-extra
      - Make qemu-utils depend on qemu-block-extra
      - let qemu-utils recommend sharutils
    - arch aware kvm wrappers
    - tolerate ipxe size change on migrations to >=3D18.04 (LP: 1713490)
      - d/p/ubuntu/pre-bionic-256k-ipxe-efi-roms.patch: old machine types
        reference 256k path
      - d/control-in: depend on ipxe-qemu-256k-compat-efi-roms to be able to
        handle incoming migrations from former releases.
    - d/control-in: Disable capstone disassembler library support (universe)
    - d/qemu-system-x86.README.Debian: add info about updated nesting chang=
es
    - d/control*, d/rules: disable xen by default, but provide universe
      package qemu-system-x86-xen as alternative
      [includes --disable-xen for user-static builds]
    - d/control-in: disable pmem on ppc64 as it is currently considered
      experimental on that architecture (pmdk v1.8-1)
    - d/rules: makefile definitions can't be recursive - sys_systems for s3=
90x
    - d/rules: report config log from the correct subdir
    - allow qemu to load old modules post upgrade (LP 1847361)
      - d/qemu-block-extra.*.in, d/qemu-system-gui.*.in: save shared object=
s on
        upgrade
      - d/rules: generate maintainer scripts matching package version on bu=
ild
      - d/rules: enable --enable-module-upgrades where --enable-modules is =
set
    - d/p/ubuntu/lp-1835546-*: backport the s390x protvirt feature (LP 1835=
546)
    - d/control-in: disable rbd support unavailable on riscv (LP: 1872931)
    - debian/patches/ubuntu/lp-1878973-*: fix assert in qemu-guest-agent th=
at
      crashes it on shutdown (LP 1878973)
  * Dropped changes (no more needed)
    - d/qemu-system-common.maintscript: clean old sysv and upstart scripts
    - d/p/ubuntu/expose-vmx_qemu64cpu.patch: expose nested kvm by default
      in qemu64 cpu type.
    - d/control: avoid upgrade issues triggered by moving ivshmem tools aft=
er
      Debian. Fixed by bumping the related Breaks/Replaces to the
      Version Ubuntu introduced the change (LP 1862287)
  * Dropped changes (in Debian)
    - improved s390x support
    - d/binfmt-update-in: fix binfmt being called in some containers
      (LP 1840956)
    - qemu-system-x86-microvm package
      In addition to the generic multi-purpose qemu also provide a minimal
      feature binary that is loading faster for use cases with microvm mach=
ine
      type and qboot bios
      - d/control-in: add a new qemu-system-x86-microvm package
      - d/rules: add an extra config/build step to get the minimal qemu
    - Security and packaging fixes (LP 1872937)
      - arm-fix-PAuth-sbox-functions-CVE-2020-10702.patch
      - net-tulip-check-frame-size-and-r-w-data-length-CVE-2020-11102.patch
        CVE-2020-10702
        CVE-2020-11102
      - fix external spice UI
        + install ui-spice-app.so in qemu-system-common
        + install ui-spice-app.so only if built, spice is optional
      - switch binfmt registration to use update-binfmts --[un]import (#866=
756)
      - qemu-system-gui: Multi-Arch=3Dsame, not foreign (#956763)
      - qemu-system-data: s/highcolor/hicolor/ (#955741)
    - enable riscv build (LP 1872931)
      [ changes picked from Debian ]
      - enable support for riscv64 hosts
      - only enable librbd on architectures where it is built
      - ceph: do not list librados-dev as we only use librbd-dev and the la=
tter
        depends on the former
      - seccomp grew up, no need in versioned build-dep
      - enable seccomp only on architectures where it can be built
  * Dropped changes (upstream)
    - d/p/ubuntu/lp-1857033-*: add support for Cooper Lake cpu model
      (LP 1857033)
    - d/p/lp-1859527-*: avoid breakage on high virtqueue counts (LP 1859527)
    - d/p/ubuntu/vhost-user-gpu-Drop-trailing-json-comma.patch: fix parsing=
 of
      vhost-user-gpu
    - d/p/ubuntu/lp-1847361-vhost-correctly-turn-on-VIRTIO_F_IOMMU_PLATFORM=
.patch:
      avoid unnecessary IOTLB transactions (LP 1866207)
    - d/p/stable/lp-1867519-*: Stabilize qemu 4.2 with upstream
      patches @qemu-stable (LP 1867519)
    - remove d/p/ubuntu/expose-vmx_qemu64cpu.patch: Stop adding VMX to qemu=
64
      to avoid broken nesting (LP 1868692)
    - d/p/ubuntu/lp-1871830-*: avoid crash when using QEMU_MODULE_DIR
      (LP 1871830)
    - d/p/ubuntu/lp-1872107*: fix migration while rebooting guests (LP 1872=
107)
    - d/p/ubuntu/lp-1872931-*: fix build on non KVM platforms
    - d/p/ubuntu/lp-1872945-*: fix riscv emulation errors that e.g. hung ssh
      and clobbered doubles (LP 1872945)
    - SECURITY UPDATE: DoS via integer overflow in ati_2d_blt()
      - debian/patches/ubuntu/CVE-2020-11869.patch: fix checks in
        ati_2d_blt() to avoid crash in hw/display/ati_2d.c.
      - CVE-2020-11869
    - d/p/ubuntu/lp-1805256*: Fixes for QEMU on aarch64 ARM hosts
      - async: use explicit memory barriers (LP 1805256)
      - aio-wait: delegate polling of main AioContext if BQL not held
    - d/p/ubuntu/lp-1882774-*: fix issues with VMX subfeatures on systems n=
ot
      supporting to set them (LP 1882774)
    - d/p/ubuntu/lp-1847361-modules-load-upgrade.patch: to fallback module
      load to a versioned path
  * Added Changes:
    - d/control: regenerate debian/control out of control-in
    - update d/p/ubuntu/lp-1835546-* to the final versions
      - 11 patches dropped as they are in 5.0
      - 20 patches updated to how they will be in 5.1
    - d/p/ubuntu/virtio-net-fix-rsc_ext-compat-handling.patch: fix
      FTBFS in groovy
    - Make qemu-system-x86-microvm a transitional package as the binary is =
now
      in qemu-system-x86 itself.
    - d/control-in: build-dep libcap is no more needed
    - d/rules: update arch aware kvm wrappers
    - d/qemu-system-x86.README.Debian: fix typo

qemu (1:5.0-5) unstable; urgency=3Dmedium

  * more binfmt-install updates
  * CVE-2020-10717 fix from upstream:
    virtiofsd-add-rlimit-nofile-NUM-option.patch (preparational) and
    virtiofsd-stay-below-fs.file-max-CVE-2020-10717.patch
    (Closes: #959746, CVE-2020-10717)
  * 2 patches from upstream/stable to fix io_uring fd set buildup:
    aio-posix-dont-duplicate-fd-handler-deletion-in-fdmon_io_uring_destroy.=
patch
    aio-posix-disable-fdmon-io_uring-when-GSource-is-used.patch
  * upstream stable fix: hostmem-dont-use-mbind-if-host-nodes-is-empty.patch
  * upstream stable fix:
    net-use-peer-when-purging-queue-in-qemu_flush_or_purge_queue_packets.pa=
tch

qemu (1:5.0-4) unstable; urgency=3Dmedium

  * fix binfmt registration (Closes: #959222)
  * disable PIE for user-static build on x32 too, not only i386

qemu (1:5.0-3) unstable; urgency=3Dmedium

  * do not explicitly enable -static-pie on non-i386 architectures.
    Apparenly only amd64 actually support -static-pie for now, and
    it is correctly detected.

qemu (1:5.0-2) unstable; urgency=3Dmedium

  * (temporarily) disable pie on i386 static build
    For now -static-pie fails on i386 with the following error message:
      /usr/bin/ld: /usr/lib/i386-linux-gnu/libc.a(memset_chk-nonshared.o):
          unsupported non-PIC call to IFUNC `memset'
  * install qemu-system docs in qemu-system-common, not qemu-system-data,
    since docs require ./configure run

qemu (1:5.0-1) unstable; urgency=3Dmedium

  * new upstream release (5.0)
    Closes: #958926
    Closes: CVE-2020-11869
  * refresh patches, remove patches applied upstream
  * do not mention openhackware, it is not used anymore
  * do not disable bluez (support removed)
  * new system arch "rx"
  * dont install qemu-doc.* for now,
    but install virtiofsd & qemu-storage-daemon
  * add shared-lib-without-dependency-information tag
    to qemu-user-static.lintian-overrides
  * add html docs to qemu-system-data (to /usr/share/doc/qemu-system-common)
  * do not install usr/share/doc/qemu/specs & usr/share/doc/qemu/tools
  * install qemu-user html docs for qemu-user & qemu-user-static
  * build hppa-firmware.img from roms/seabios-hppa
    (and Build-Depeds-Indep on gcc-hppa-linux-gnu)
  * enable liburing on linux (build-depend on liburing-dev)
  * add upstream signing-key.asc (Michael Roth <flukshun@gmail.com>)
  * build opensbi firmware
    (for riscv64 only, riscv32 is possible with compiler flags)
  * add source-level lintian-overrides for binaries-without-sources
    (lintian can't find sources for a few firmware images which are in roms=
/)

qemu (1:4.2-7) unstable; urgency=3Dmedium

  * qemu-system-gui: Multi-Arch=3Dsame, not foreign (Closes: #956763)
  * x32 arch is in the same family as i386 & x86_64, omit binfmt registrati=
on
  * check systemd-detect-virt before running update-binfmt
  * gluster is de-facto linux-only, do not build-depend on it on non-linux
  * virglrenderer is also essentially linux-specific
  * qemu-user-static does not depend on shlibs
  * disable parallel building of targets of d/rules
  * add lintian overrides (arch-dependent static binaries) for openbios bin=
aries
  * separate binary-indep target into install-indep-prep and binary-indep
  * split out various components of qemu-system-data into independent
    build/install rules and add infrastructure for more components:
    x86-optionrom, sgabios, qboot, openbios, skiboot, palcode-clipper,
    slof, s390x-fw
  * iscsi-fix-heap-buffer-overflow-in-iscsi_aio_ioctl_cb.patch

qemu (1:4.2-6) unstable; urgency=3Dmedium

  * d/rules: fix FTBFS (brown-paper-bag bug) in last upload

qemu (1:4.2-5) unstable; urgency=3Dmedium

  * no error-out on address-of-packet-member in openbios
  * install ui-spice-app.so only if built, spice is optional
  * arm-fix-PAuth-sbox-functions-CVE-2020-10702.patch -
    Closes: CVE-2020-10702, weak signature generation
    in Pointer Authentication support for ARM
  * (temporarily) enable seccomp only on architectures where it can be built
    (Closes: #956624)
  * seccomp has grown up, no need in versioned build-dep
  * do not list librados-dev in build-dep as we only use librbd-dev
    and the latter depends on the former
  * only enable librbd on architectures where it is buildable

qemu (1:4.2-4) unstable; urgency=3Dmedium

  [ Michael Tokarev ]
  * d/rules: build minimal configuration for qboot/microvm usage
  * set microvm to be the default machine type for microvm case
  * install ui-spice-app.so in qemu-system-common
  * do not depend on libattr-dev, functions are now in libc6 (Closes: #9539=
10)
  * net-tulip-check-frame-size-and-r-w-data-length-CVE-2020-11102.patch
    (Closes: #956145, CVE-2020-11102, tulip nic buffer overflow)
  * qemu-system-data: s/highcolor/hicolor/ (Closes: #955741)
  * switch binfmt registration to use update-binfmts --[un]import
    (Closes: #866756)
  * build openbios-ppc & openbios-sparc binaries in qemu-system-data,
    and replace corresponding binary packages.
    Add gcc-sparc64-linux-gnu, fcode-utils & xsltproc to build-depend-indep
  * build and provide/replace qemu-slof too

  [ Aurelien Jarno ]
  * enable support for riscv64 hosts

 -- Christian Ehrhardt <christian.ehrhardt@canonical.com>  Tue, 28 Jul
2020 13:21:31 +0200

** Changed in: qemu (Ubuntu)
       Status: Triaged =3D> Fix Released

** CVE added: https://cve.mitre.org/cgi-bin/cvename.cgi?name=3D2020-10702

** CVE added: https://cve.mitre.org/cgi-bin/cvename.cgi?name=3D2020-10717

** CVE added: https://cve.mitre.org/cgi-bin/cvename.cgi?name=3D2020-10761

** CVE added: https://cve.mitre.org/cgi-bin/cvename.cgi?name=3D2020-11102

** CVE added: https://cve.mitre.org/cgi-bin/cvename.cgi?name=3D2020-11869

** CVE added: https://cve.mitre.org/cgi-bin/cvename.cgi?name=3D2020-12829

** CVE added: https://cve.mitre.org/cgi-bin/cvename.cgi?name=3D2020-13253

** CVE added: https://cve.mitre.org/cgi-bin/cvename.cgi?name=3D2020-13361

** CVE added: https://cve.mitre.org/cgi-bin/cvename.cgi?name=3D2020-13362

** CVE added: https://cve.mitre.org/cgi-bin/cvename.cgi?name=3D2020-13659

** CVE added: https://cve.mitre.org/cgi-bin/cvename.cgi?name=3D2020-13754

** CVE added: https://cve.mitre.org/cgi-bin/cvename.cgi?name=3D2020-13791

** CVE added: https://cve.mitre.org/cgi-bin/cvename.cgi?name=3D2020-13800

** CVE added: https://cve.mitre.org/cgi-bin/cvename.cgi?name=3D2020-15863

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1749393

Title:
  sbrk() not working under qemu-user with a PIE-compiled binary?

Status in QEMU:
  Fix Released
Status in qemu package in Ubuntu:
  Fix Released

Bug description:
  In Debian unstable, we recently switched bash to be a PIE-compiled
  binary (for hardening). Unfortunately this resulted in bash being
  broken when run under qemu-user (for all target architectures, host
  being amd64 for me).

  $ sudo chroot /srv/chroots/sid-i386/ qemu-i386-static /bin/bash
  bash: xmalloc: .././shell.c:1709: cannot allocate 10 bytes (0 bytes alloc=
ated)

  bash has its own malloc implementation based on sbrk():
  https://git.savannah.gnu.org/cgit/bash.git/tree/lib/malloc/malloc.c

  When we disable this internal implementation and rely on glibc's
  malloc, then everything is fine. But it might be that glibc has a
  fallback when sbrk() is not working properly and it might hide the
  underlying problem in qemu-user.

  This issue has also been reported to the bash upstream author and he sugg=
ested that the issue might be in qemu-user so I'm opening a ticket here. He=
re's the discussion with the bash upstream author:
  https://lists.gnu.org/archive/html/bug-bash/2018-02/threads.html#00080

  You can find the problematic bash binary in that .deb file:
  http://snapshot.debian.org/archive/debian/20180206T154716Z/pool/main/b/ba=
sh/bash_4.4.18-1_i386.deb

  The version of qemu I have been using is 2.11 (Debian package qemu-
  user-static version 1:2.11+dfsg-1) but I have had reports that the
  problem is reproducible with older versions (back to 2.8 at least).

  Here are the related Debian bug reports:
  https://bugs.debian.org/889869
  https://bugs.debian.org/865599

  It's worth noting that bash used to have this problem (when compiled as a=
 PIE binary) even when run directly but then something got fixed in the ker=
nel and now the problem only appears when run under qemu-user:
  https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1518483

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1749393/+subscriptions

