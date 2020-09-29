Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NORMAL_HTTP_TO_IP,
	NUMERIC_HTTP_ADDR,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97CBBC4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 08:04:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17F1C2075F
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 08:04:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17F1C2075F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNAd6-0003Y6-Uz
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 04:04:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60464)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kNA6S-0006nh-Fj
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:31:12 -0400
Received: from indium.canonical.com ([91.189.90.7]:57764)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kNA6N-0003Ke-CW
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:31:12 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kNA6K-0000hz-UR
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 07:31:04 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id E2B312E8052
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 07:31:04 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2020 07:21:35 -0000
From: =?utf-8?q?Christian_Ehrhardt_=EE=83=BF?= <1894804@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=qemu; component=main;
 status=Incomplete; importance=Undecided; assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: berrange james-page kashyapc lyarwood paelzer
 sean-k-mooney
X-Launchpad-Bug-Reporter: Lee Yarwood (lyarwood)
X-Launchpad-Bug-Modifier: =?utf-8?q?Christian_Ehrhardt_=EE=83=BF_=28paelzer?=
 =?utf-8?q?=29?=
References: <159955374051.12161.5076756019458607363.malonedeb@chaenomeles.canonical.com>
Message-Id: <160136409532.13250.6924496159474500495.malone@soybean.canonical.com>
Subject: [Bug 1894804] Re: Second DEVICE_DELETED event missing during
 virtio-blk disk device detach
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="d685c0a40836eb9844ed835c9700f20633c1d7af"; Instance="production"
X-Launchpad-Hash: 9df8ebd8a13f9f311905c90a72f5aab57d17701a
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 03:05:36
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -54
X-Spam_score: -5.5
X-Spam_bar: -----
X-Spam_report: (-5.5 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.199, NORMAL_HTTP_TO_IP=0.001,
 NUMERIC_HTTP_ADDR=1.242, RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 WEIRD_PORT=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Bug 1894804 <1894804@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thanks James, but now I'm  unsure where to go from here as it isn't
reproducible with many tries at different scales that James and I did.

@Sean/Lee
Since you wondered if it might be due to Ubuntu Delta on top of 4.2 - there=
 are two things we could compare Ubuntu's qemu to then:
1. qemu 4.2 as released by upstream
2. qemu 4.2 as build in centos (they have some delta as well)
Not sure I can provide you #2 easily and #1 will always need a bit of delta=
 to build&integrate correctly. All of that would be doable still, but in ge=
neral if I'd provide you PPA builds could you try those in your environment=
 to !reliably! trigger the issue allowing us to play bisect-ping-pong? The =
word "reliable" is important here as we'd need to sort out builds/patches b=
y a reliable yes/no on each step.

@Sean/Lee
- which "the centos 8 build of the same qemu" version is that exactly? I mi=
ght take a look at comparing the patches applied. We are at 4.2.1 already, =
the latest I found there was 4.2.0-29.el8.3.x86_64.rpm which already is the=
 advanced-virt version (otherwise 2.12 based).

@Sean/Lee
All of the following suggested approaches depend on the question if you can=
 test this reliably with different qemu PPA builds:
- qemu 4.2 (as upstream) vs usual Ubuntu build -> find the offending patch =
in our delta
- test Ubuntu 20.10 which has qemu 5.0 and libvirt 6.6 -> if fixed there fi=
nd by which change
- qemu 4.2 Ubuntu vs qemu 4.2 as in CentOS (but build for Ubuntu) -> if the=
 latter works better then let us find by which (set of) patches.


I was checking the Delta on Centos8 advanced-virt qemu 4.2 as that was repo=
rted
to (maybe) work better. I was comparing which patches are applied, that are=
 no
on Ubuntu and which of those might be related.
Among several individual fixes for some issues the biggest patch sets
are feature backports for Enhanced LUKS/backup/snapshot handling,
multifd migration/cancel, block-mirror, HMAT changes, virtiofs, qemu-img ze=
ro
write, arm time handling and some related build time self tests.
Due to the nature of these changes some affect the block handling by affect=
ing block/job/hotplug. But they might only do so by accident, nothing is cl=
early for addressing the issue that
was reported. And even of the list below most seem unrelated - so as Sean a=
ssumed maybe it just isn't exercised on centos enough to be seen there?

eca0f3524a4eb57d03a56b0cbcef5527a0981ce4 backup: don't acquire aio_context =
in backup_clean
58226634c4b02af7b10862f7fbd3610a344bfb7f backup: Improve error for bdrv_get=
length() failure
958a04bd32af18d9a207bcc78046e56a202aebc2 backup: Make sure that source and =
target size match
7b8e4857426f2e2de2441749996c6161b550bada block: Add flags to bdrv(_co)_trun=
cate()
92b92799dc8662b6f71809100a4aabc1ae408ebb block: Add flags to BlockDriver.bd=
rv_co_truncate()
087ab8e775f48766068e65de1bc99d03b40d1670 block: always fill entire LUKS hea=
der space with zeros
8c6242b6f383e43fd11d2c50f8bcdd2bba1100fc block-backend: Add flags to blk_tr=
uncate()
564806c529d4e0acad209b1e5b864a8886092f1f block-backend: Reorder flush/pdisc=
ard function definitions
0abf2581717a19d9749d5c2ff8acd0ac203452c2 block/backup-top: Don't acquire co=
ntext while dropping top
1de6b45fb5c1489b450df7d1a4c692bba9678ce6 block: bdrv_reopen() with backing =
file in different AioContext
e1d7f8bb1ec0c6911dcea81641ce6139dbded02d block.c: adding bdrv_co_delete_file
69032253c33ae1774233c63cedf36d32242a85fc block/curl: HTTP header field name=
s are case insensitive
7788a319399f17476ff1dd43164c869e320820a2 block/curl: HTTP header fields all=
ow whitespace around values
91005a495e228ebd7e5e173cd18f952450eef82d blockdev: Acquire AioContext on di=
rty bitmap functions
471ded690e19689018535e3f48480507ed073e22 blockdev: fix coding style issues =
in drive_backup_prepare
3ea67e08832775a28d0bd2795f01bc77e7ea1512 blockdev: honor bdrv_try_set_aio_c=
ontext() context requirements
c6996cf9a6c759c29919642be9a73ac64b38301b blockdev: Promote several bitmap f=
unctions to non-static
377410f6fb4f6b0d26d4a028c20766fae05de17e blockdev: Return bs to the proper =
context on snapshot abort
bb4e58c6137e80129b955789dd4b66c1504f20dc blockdev: Split off basic bitmap o=
perations for qemu-img
5b7bfe515ecbd584b40ff6e41d2fd8b37c7d5139 blockdev: unify qmp_blockdev_backu=
p and blockdev-backup transaction paths
2288ccfac96281c316db942d10e3f921c1373064 blockdev: unify qmp_drive_backup a=
nd drive-backup transaction paths
7f16476fab14fc32388e0ebae793f64673848efa block: Fix blk->in_flight during b=
lk_wait_while_drained()
30dd65f307b647eef8156c4a33bd007823ef85cb block: Fix cross-AioContext blockd=
ev-snapshot
eeea1faa099f82328f5831cf252f8ce0a59a9287 block: Fix leak in bdrv_create_fil=
e_fallback()
fd17146cd93d1704cd96d7c2757b325fc7aac6fd block: Generic file creation fallb=
ack
fbb92b6798894d3bf62fe3578d99fa62c720b242 block: Increase BB.in_flight for c=
oroutine and sync interfaces
17e1e2be5f9e84e0298e28e70675655b43e225ea block: Introduce 'bdrv_reopen_comm=
it_post' step
9bffae14df879255329473a7bd578643af2d4c9c block: introducing 'bdrv_co_delete=
_file' interface
c7a0f2be8f95b220cdadbba9a9236eaf115951dc block: Make bdrv_get_cumulative_pe=
rm() public
ef893b5c84f3199d777e33966dc28839f71b1a5c block: Make it easier to learn whi=
ch BDS support bitmaps
78c81a3f108870d325b0a39d88711366afe6f703 block/nbd: Fix hang in .bdrv_close=
()
b92902dfeaafbceaf744ab7473f2d070284f6172 block: pass BlockDriver reference =
to the .bdrv_co_create
65eb7c85a3e62529e2bad782e94d5a7b11dd5a92 block/qcow2: Move bitmap reopen in=
to bdrv_reopen_commit_post
d29d3d1f80b3947fb26e7139645c83de66d146a9 block: Relax restrictions for bloc=
kdev-snapshot
5a5e7f8cd86b7ced0732b1b6e28c82baa65b09c9 block: trickle down the fallback i=
mage creation function use to the block drivers
955c7d6687fefcd903900a1e597fcbc896c661cd block: truncate: Don't make backin=
g file data visible
1bba30da24e1124ceeb0693c81382a0d77e20ca5 crypto.c: cleanup created file whe=
n block_crypto_co_create_opts_luks fails
87ca3b8fa615b278b33cabf9ed22b3f44b5214ba file-posix: Drop hdev_co_create_op=
ts()
2f0c6e7a650de133eccd94e9bb6cf7b2070f07f1 file-posix: Support BDRV_REQ_ZERO_=
WRITE for truncate
89b6fc45614bb45dcd58f1590415afe5c2791abd hmp: Allow using qdev ID for qemu-=
io command
80f0900905b555f00d644894c786b6d66ac2e00e iscsi: Drop iscsi_co_create_opts()
0501e1aa1d32a6e02dd06a79bba97fbe9d557cb5 hw/pci/pcie: Forbid hot-plug if it=
's disabled on the slot
0dabc0f6544f2c0310546f6d6cf3b68979580a9c hw/pci/pcie: Move hot plug capabil=
ity check to pre_plug callback
6a1e073378353eb6ac0565e0dc649b3db76ed5dc hw/pci/pcie: Replace PCI_DEVICE() =
casts with existing variable
b660a84bbb0eb1a76b505648d31d5e82594fb75e job: take each job's lock individu=
ally in job_txn_apply
530a0963184e57e71a5b538e9161f115df533e96 pcie_root_port: Add hotplug disabl=
ing optio
c6bdc312f30d5c7326aa2fdca3e0f98c15eb541a qapi: Add '@allow-write-only-overl=
ay' feature for 'blockdev-snapshot'
5d72c68b49769c927e90b78af6d90f6a384b26ac qcow2: Expose bitmaps' size during=
 measure
eb8a0cf3ba26611f3981f8f45ac6a868975a68cc qcow2: Forward ZERO_WRITE flag for=
 full preallocation
f01643fb8b47e8a70c04bbf45e0f12a9e5bc54de qcow2: Support BDRV_REQ_ZERO_WRITE=
 for truncate
a555b8092abc6f1bbe4b64c516679cbd68fcfbd8 qemu-file: Don't do IO after shutd=
own
08558e33257ec796594bd411261028a93414a70c replication: assert we own context=
 before job_cancel_sync
49b44549ace7890fffdf027fd3695218ee7f1121 virtio-blk: On restart, process qu=
eued requests in the proper context
7aa1c247b466870b0704d3ccdc3755e5e7394dca virtio-blk: Refactor the code that=
 processes queued requests
d0435bc513e23a4961b6af20164d1c6c219eb4ea virtio: don't enable notifications=
 during polling

Vice versa being on 4.2.1 already gives Ubuntu some block changes that
might have caused this...

Waiting for Sean/Lee to comment on how testable/reliable that is on
their end -> incomplete

** Changed in: qemu (Ubuntu)
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1894804

Title:
  Second DEVICE_DELETED event missing during virtio-blk disk device
  detach

Status in QEMU:
  New
Status in qemu package in Ubuntu:
  Incomplete

Bug description:
  We are in the process of moving OpenStack CI across to use 20.04 Focal
  as the underlying OS and encountering the following issue in any test
  attempting to detach disk devices from running QEMU instances.

  We can see a single DEVICE_DELETED event raised to libvirtd for the
  /machine/peripheral/virtio-disk1/virtio-backend device but we do not
  see a second event for the actual disk. As a result the device is
  still marked as present in libvirt but QEMU reports it as missing in
  subsequent attempts to remove the device.

  The following log snippets can also be found in the following pastebin
  that's slightly easier to gork:

  http://paste.openstack.org/show/797564/

  https://review.opendev.org/#/c/746981/ libvirt: Bump
  MIN_{LIBVIRT,QEMU}_VERSION and NEXT_MIN_{LIBVIRT,QEMU}_VERSION

  https://zuul.opendev.org/t/openstack/build/4c56def513884c5eb3ba7b0adf7fa2=
60
  nova-ceph-multistore

  https://zuul.opendev.org/t/openstack/build/4c56def513884c5eb3ba7b0adf7fa2=
60/log/controller/logs/dpkg-l.txt

  ii  libvirt-daemon                       6.0.0-0ubuntu8.3                =
      amd64        Virtualization daemon
  ii  libvirt-daemon-driver-qemu           6.0.0-0ubuntu8.3                =
      amd64        Virtualization daemon QEMU connection driver
  ii  libvirt-daemon-system                6.0.0-0ubuntu8.3                =
      amd64        Libvirt daemon configuration files
  ii  libvirt-daemon-system-systemd        6.0.0-0ubuntu8.3                =
      amd64        Libvirt daemon configuration files (systemd)
  ii  libvirt-dev:amd64                    6.0.0-0ubuntu8.3                =
      amd64        development files for the libvirt library
  ii  libvirt0:amd64                       6.0.0-0ubuntu8.3                =
      amd64        library for interfacing with different virtualization sy=
stems
  [..]
  ii  qemu-block-extra:amd64               1:4.2-3ubuntu6.4                =
      amd64        extra block backend modules for qemu-system and qemu-uti=
ls
  ii  qemu-slof                            20191209+dfsg-1                 =
      all          Slimline Open Firmware -- QEMU PowerPC version
  ii  qemu-system                          1:4.2-3ubuntu6.4                =
      amd64        QEMU full system emulation binaries
  ii  qemu-system-arm                      1:4.2-3ubuntu6.4                =
      amd64        QEMU full system emulation binaries (arm)
  ii  qemu-system-common                   1:4.2-3ubuntu6.4                =
      amd64        QEMU full system emulation binaries (common files)
  ii  qemu-system-data                     1:4.2-3ubuntu6.4                =
      all          QEMU full system emulation (data files)
  ii  qemu-system-mips                     1:4.2-3ubuntu6.4                =
      amd64        QEMU full system emulation binaries (mips)
  ii  qemu-system-misc                     1:4.2-3ubuntu6.4                =
      amd64        QEMU full system emulation binaries (miscellaneous)
  ii  qemu-system-ppc                      1:4.2-3ubuntu6.4                =
      amd64        QEMU full system emulation binaries (ppc)
  ii  qemu-system-s390x                    1:4.2-3ubuntu6.4                =
      amd64        QEMU full system emulation binaries (s390x)
  ii  qemu-system-sparc                    1:4.2-3ubuntu6.4                =
      amd64        QEMU full system emulation binaries (sparc)
  ii  qemu-system-x86                      1:4.2-3ubuntu6.4                =
      amd64        QEMU full system emulation binaries (x86)
  ii  qemu-utils                           1:4.2-3ubuntu6.4                =
      amd64        QEMU utilities

  https://zuul.opendev.org/t/openstack/build/4c56def513884c5eb3ba7b0adf7fa2=
60/log/controller/logs/libvirt/qemu
  /instance-0000003a_log.txt

  2020-09-07 19:29:55.021+0000: starting up libvirt version: 6.0.0, package=
: 0ubuntu8.3 (Marc Deslauriers <marc.deslauriers@ubuntu.com> Thu, 30 Jul 20=
20 06:40:28 -0400), qemu version: 4.2.0Debian 1:4.2-3ubuntu6.4, kernel: 5.4=
.0-45-generic, hostname: ubuntu-focal-ovh-bhs1-0019682147
  LC_ALL=3DC \
  PATH=3D/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin \
  HOME=3D/var/lib/libvirt/qemu/domain-86-instance-0000003a \
  XDG_DATA_HOME=3D/var/lib/libvirt/qemu/domain-86-instance-0000003a/.local/=
share \
  XDG_CACHE_HOME=3D/var/lib/libvirt/qemu/domain-86-instance-0000003a/.cache=
 \
  XDG_CONFIG_HOME=3D/var/lib/libvirt/qemu/domain-86-instance-0000003a/.conf=
ig \
  QEMU_AUDIO_DRV=3Dnone \
  /usr/bin/qemu-system-x86_64 \
  -name guest=3Dinstance-0000003a,debug-threads=3Don \
  -S \
  -object secret,id=3DmasterKey0,format=3Draw,file=3D/var/lib/libvirt/qemu/=
domain-86-instance-0000003a/master-key.aes \
  -machine pc-i440fx-4.2,accel=3Dtcg,usb=3Doff,dump-guest-core=3Doff \
  -cpu qemu64 \
  -m 128 \
  -overcommit mem-lock=3Doff \
  -smp 1,sockets=3D1,cores=3D1,threads=3D1 \
  -uuid 0d59f238-daef-40d4-adf9-a4fa24c35231 \
  -smbios 'type=3D1,manufacturer=3DOpenStack Foundation,product=3DOpenStack=
 Nova,version=3D21.1.0,serial=3D0d59f238-daef-40d4-adf9-a4fa24c35231,uuid=
=3D0d59f238-daef-40d4-adf9-a4fa24c35231,family=3DVirtual Machine' \
  -no-user-config \
  -nodefaults \
  -chardev socket,id=3Dcharmonitor,fd=3D39,server,nowait \
  -mon chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol \
  -rtc base=3Dutc \
  -no-shutdown \
  -boot strict=3Don \
  -device piix3-usb-uhci,id=3Dusb,bus=3Dpci.0,addr=3D0x1.0x2 \
  -object secret,id=3Dlibvirt-3-storage-secret0,data=3DzT+XibedVJZM2du1+PXp=
IXHMVJ9a0pVcKihOtCGwlB0=3D,keyid=3DmasterKey0,iv=3D536Lfw+nsyvDhFBTOQG4zA=
=3D=3D,format=3Dbase64 \
  -blockdev '{"driver":"rbd","pool":"vms","image":"0d59f238-daef-40d4-adf9-=
a4fa24c35231_disk","server":[{"host":"158.69.70.115","port":"6789"}],"user"=
:"cinder","auth-client-required":["cephx","none"],"key-secret":"libvirt-3-s=
torage-secret0","node-name":"libvirt-3-storage","cache":{"direct":false,"no=
-flush":false},"auto-read-only":true,"discard":"unmap"}' \
  -blockdev '{"node-name":"libvirt-3-format","read-only":false,"cache":{"di=
rect":false,"no-flush":false},"driver":"raw","file":"libvirt-3-storage"}' \
  -device virtio-blk-pci,scsi=3Doff,bus=3Dpci.0,addr=3D0x4,drive=3Dlibvirt-=
3-format,id=3Dvirtio-disk0,bootindex=3D1,write-cache=3Don \
  -object secret,id=3Dlibvirt-2-storage-secret0,data=3DSO9AgCCTvkBBMYHZe+LV=
zoCF4GUNgvBtkFwRRIji7WI=3D,keyid=3DmasterKey0,iv=3DMzGu/h2Api4mMG9lL8hvdg=
=3D=3D,format=3Dbase64 \
  -blockdev '{"driver":"rbd","pool":"volumes","image":"volume-04dd79b2-3c05=
-4492-b1d7-7969d24df768","server":[{"host":"158.69.70.115","port":"6789"}],=
"user":"cinder","auth-client-required":["cephx","none"],"key-secret":"libvi=
rt-2-storage-secret0","node-name":"libvirt-2-storage","cache":{"direct":fal=
se,"no-flush":false},"auto-read-only":true,"discard":"unmap"}' \
  -blockdev '{"node-name":"libvirt-2-format","read-only":false,"discard":"u=
nmap","cache":{"direct":false,"no-flush":false},"driver":"raw","file":"libv=
irt-2-storage"}' \
  -device virtio-blk-pci,scsi=3Doff,bus=3Dpci.0,addr=3D0x7,drive=3Dlibvirt-=
2-format,id=3Dvirtio-disk1,write-cache=3Don,serial=3D04dd79b2-3c05-4492-b1d=
7-7969d24df768 \
  -object secret,id=3Dlibvirt-1-storage-secret0,data=3DlhbR9+ewiXiaf3dKoQWP=
3bk6hlLMLRXnbhh9ZkjZ9dQ=3D,keyid=3DmasterKey0,iv=3DWWHpGuOHkwXqxlLxGUqpcA=
=3D=3D,format=3Dbase64 \
  -blockdev '{"driver":"rbd","pool":"vms","image":"0d59f238-daef-40d4-adf9-=
a4fa24c35231_disk.config","server":[{"host":"158.69.70.115","port":"6789"}]=
,"user":"cinder","auth-client-required":["cephx","none"],"key-secret":"libv=
irt-1-storage-secret0","node-name":"libvirt-1-storage","cache":{"direct":fa=
lse,"no-flush":false},"auto-read-only":true,"discard":"unmap"}' \
  -blockdev '{"node-name":"libvirt-1-format","read-only":true,"cache":{"dir=
ect":false,"no-flush":false},"driver":"raw","file":"libvirt-1-storage"}' \
  -device ide-cd,bus=3Dide.0,unit=3D0,drive=3Dlibvirt-1-format,id=3Dide0-0-=
0,write-cache=3Don \
  -netdev tap,fd=3D41,id=3Dhostnet0 \
  -device virtio-net-pci,host_mtu=3D1400,netdev=3Dhostnet0,id=3Dnet0,mac=3D=
fa:16:3e:4d:bb:0b,bus=3Dpci.0,addr=3D0x3 \
  -add-fd set=3D2,fd=3D43 \
  -chardev pty,id=3Dcharserial0,logfile=3D/dev/fdset/2,logappend=3Don \
  -device isa-serial,chardev=3Dcharserial0,id=3Dserial0 \
  -vnc 0.0.0.0:3 \
  -device cirrus-vga,id=3Dvideo0,bus=3Dpci.0,addr=3D0x2 \
  -device virtio-balloon-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x5 \
  -object rng-random,id=3Dobjrng0,filename=3D/dev/urandom \
  -device virtio-rng-pci,rng=3Dobjrng0,id=3Drng0,bus=3Dpci.0,addr=3D0x6 \
  -sandbox on,obsolete=3Ddeny,elevateprivileges=3Ddeny,spawn=3Ddeny,resourc=
econtrol=3Ddeny \
  -msg timestamp=3Don
  char device redirected to /dev/pts/1 (label charserial0)

  https://storage.gra.cloud.ovh.net/v1/AUTH_dcaab5e32b234d56b626f72581e3644=
c/zuul_opendev_logs_4c5/746981/5/check
  /nova-ceph-multistore/4c56def/testr_results.html

  tempest.api.compute.servers.test_server_rescue_negative.ServerRescueNegat=
iveTestJSON.test_rescued_vm_detach_volume

  2020-09-07 19:30:13,764 100285 INFO     [tempest.lib.common.rest_client] =
Request (ServerRescueNegativeTestJSON:_run_cleanups): 202 DELETE https://15=
8.69.70.115/compute/v2.1/servers/0d59f238-daef-40d4-adf9-a4fa24c35231/os-vo=
lume_attachments/04dd79b2-3c05-4492-b1d7-7969d24df768 1.261s
  2020-09-07 19:30:13,764 100285 DEBUG    [tempest.lib.common.rest_client] =
Request - Headers: {'Content-Type': 'application/json', 'Accept': 'applicat=
ion/json', 'X-Auth-Token': '<omitted>'}
          Body: None
      Response - Headers: {'date': 'Mon, 07 Sep 2020 19:30:12 GMT', 'server=
': 'Apache/2.4.41 (Ubuntu)', 'content-length': '0', 'content-type': 'applic=
ation/json', 'openstack-api-version': 'compute 2.1', 'x-openstack-nova-api-=
version': '2.1', 'vary': 'OpenStack-API-Version,X-OpenStack-Nova-API-Versio=
n', 'x-openstack-request-id': 'req-502a0106-3eb9-4d42-9dd4-c43ba89187b6', '=
x-compute-request-id': 'req-502a0106-3eb9-4d42-9dd4-c43ba89187b6', 'connect=
ion': 'close', 'status': '202', 'content-location': 'https://158.69.70.115/=
compute/v2.1/servers/0d59f238-daef-40d4-adf9-a4fa24c35231/os-volume_attachm=
ents/04dd79b2-3c05-4492-b1d7-7969d24df768'}
          Body: b''

  # First attempt to detach the device  by n-cpu

  https://storage.gra.cloud.ovh.net/v1/AUTH_dcaab5e32b234d56b626f72581e3644=
c/zuul_opendev_logs_4c5/746981/5/check
  /nova-ceph-multistore/4c56def/controller/logs/screen-n-cpu.txt
  (gzipped)

  29957 Sep 07 19:30:14.185403 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]: DEBUG nova.virt.libvirt.guest [None req-502a0106-3eb9-4d42-9dd4-c=
43ba89187b6 tempest-ServerRescueNegativeTestJSON-73411582 tempest-ServerRes=
cueNegativeTestJSON-73411582] detach device xml: <disk type=3D"network" de
  29958 Sep 07 19:30:14.185403 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]:   <driver name=3D"qemu" type=3D"raw" cache=3D"writeback" discard=
=3D"unmap"/>
  29959 Sep 07 19:30:14.185403 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]:   <source protocol=3D"rbd" name=3D"volumes/volume-04dd79b2-3c05-4=
492-b1d7-7969d24df768">
  29960 Sep 07 19:30:14.185403 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]:     <host name=3D"158.69.70.115" port=3D"6789"/>
  29961 Sep 07 19:30:14.185403 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]:   </source>
  29962 Sep 07 19:30:14.185403 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]:   <target dev=3D"vdb" bus=3D"virtio"/>
  29963 Sep 07 19:30:14.185403 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]:   <serial>04dd79b2-3c05-4492-b1d7-7969d24df768</serial>
  29964 Sep 07 19:30:14.185403 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]:   <address type=3D"pci" domain=3D"0x0000" bus=3D"0x00" slot=3D"0x=
07" function=3D"0x0"/>
  29965 Sep 07 19:30:14.185403 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]: </disk>
  29966 Sep 07 19:30:14.185403 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]:  {{(pid=3D92697) detach_device /opt/stack/nova/nova/virt/libvirt/=
guest.py:510}}

  # DEVICE_DELETED only raised for /machine/peripheral/virtio-disk1
  /virtio-backend

  https://storage.gra.cloud.ovh.net/v1/AUTH_dcaab5e32b234d56b626f72581e3644=
c/zuul_opendev_logs_4c5/746981/5/check
  /nova-ceph-multistore/4c56def/controller/logs/libvirt/libvirtd_log.txt
  (gzipped)

  329344 2020-09-07 19:30:14.165+0000: 65559: debug : qemuDomainObjEnterMon=
itorInternal:9869 : Entering monitor (mon=3D0x7f769405e470 vm=3D0x7f768c0df=
0b0 name=3Dinstance-0000003a)
  329345 2020-09-07 19:30:14.165+0000: 65559: debug : qemuMonitorDelDevice:=
2848 : devalias=3Dvirtio-disk1
  329346 2020-09-07 19:30:14.165+0000: 65559: debug : qemuMonitorDelDevice:=
2850 : mon:0x7f769405e470 vm:0x7f768c0df0b0 fd:39
  329347 2020-09-07 19:30:14.165+0000: 65559: info : qemuMonitorSend:993 : =
QEMU_MONITOR_SEND_MSG: mon=3D0x7f769405e470 msg=3D{"execute":"device_del","=
arguments":{"id":"virtio-disk1"},"id":"libvirt-367"}^M
  329348  fd=3D-1                                                          =
                =

  329349 2020-09-07 19:30:14.165+0000: 65555: info : qemuMonitorIOWrite:450=
 : QEMU_MONITOR_IO_WRITE: mon=3D0x7f769405e470 buf=3D{"execute":"device_del=
","arguments":{"id":"virtio-disk1"},"id":"libvirt-367"}^M
  329350  len=3D79 ret=3D79 errno=3D0                                      =
                    =

  329351 2020-09-07 19:30:14.168+0000: 65555: debug : qemuMonitorJSONIOProc=
essLine:220 : Line [{"return": {}, "id": "libvirt-367"}]
  329352 2020-09-07 19:30:14.168+0000: 65555: info : qemuMonitorJSONIOProce=
ssLine:239 : QEMU_MONITOR_RECV_REPLY: mon=3D0x7f769405e470 reply=3D{"return=
": {}, "id": "libvirt-367"}
  329353 2020-09-07 19:30:14.168+0000: 65559: debug : qemuDomainObjExitMoni=
torInternal:9892 : Exited monitor (mon=3D0x7f769405e470 vm=3D0x7f768c0df0b0=
 name=3Dinstance-0000003a)
  329354 2020-09-07 19:30:14.201+0000: 65555: debug : qemuMonitorJSONIOProc=
essLine:220 : Line [{"timestamp": {"seconds": 1599507014, "microseconds": 2=
01037}, "event": "DEVICE_DELETED", "data": {"path": "/machine/peripheral/vi=
rtio-disk1/virtio-backend"}}]
  329355 2020-09-07 19:30:14.208+0000: 65555: info : qemuMonitorJSONIOProce=
ssLine:234 : QEMU_MONITOR_RECV_EVENT: mon=3D0x7f769405e470 event=3D{"timest=
amp": {"seconds": 1599507014, "microseconds": 201037}, "event": "DEVICE_DEL=
ETED", "data": {"path": "/machine/peripheral/virtio-disk1/virtio-backend"}}
  329356 2020-09-07 19:30:14.208+0000: 65555: debug : qemuMonitorJSONIOProc=
essEvent:181 : mon=3D0x7f769405e470 obj=3D0x55dd95d0cba0
  329357 2020-09-07 19:30:14.208+0000: 65555: debug : qemuMonitorEmitEvent:=
1198 : mon=3D0x7f769405e470 event=3DDEVICE_DELETED
  329358 2020-09-07 19:30:14.208+0000: 65555: debug : qemuProcessHandleEven=
t:549 : vm=3D0x7f768c0df0b0
  329359 2020-09-07 19:30:14.208+0000: 65555: debug : virObjectEventNew:631=
 : obj=3D0x55dd95d3bf60
  329360 2020-09-07 19:30:14.208+0000: 65555: debug : qemuMonitorJSONIOProc=
essEvent:205 : handle DEVICE_DELETED handler=3D0x7f7691732840 data=3D0x55dd=
95eae3c0
  329361 2020-09-07 19:30:14.208+0000: 65555: debug : qemuMonitorJSONHandle=
DeviceDeleted:1287 : missing device in device deleted event

  # Second attempt to detach the device by n-cpu

  https://storage.gra.cloud.ovh.net/v1/AUTH_dcaab5e32b234d56b626f72581e3644=
c/zuul_opendev_logs_4c5/746981/5/check
  /nova-ceph-multistore/4c56def/controller/logs/screen-n-cpu.txt
  (gzipped)

  30046 Sep 07 19:30:19.192548 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]: DEBUG oslo.service.loopingcall [None req-502a0106-3eb9-4d42-9dd4-=
c43ba89187b6 tempest-ServerRescueNegativeTestJSON-73411582 tempest-ServerRe=
scueNegativeTestJSON-73411582] Waiting for function nova.virt.libvirt.gu
  30047 Sep 07 19:30:19.194846 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]: DEBUG nova.virt.libvirt.guest [-] detach device xml: <disk type=
=3D"network" device=3D"disk">
  30048 Sep 07 19:30:19.194846 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]:   <driver name=3D"qemu" type=3D"raw" cache=3D"writeback" discard=
=3D"unmap"/>
  30049 Sep 07 19:30:19.194846 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]:   <source protocol=3D"rbd" name=3D"volumes/volume-04dd79b2-3c05-4=
492-b1d7-7969d24df768">
  30050 Sep 07 19:30:19.194846 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]:     <host name=3D"158.69.70.115" port=3D"6789"/>
  30051 Sep 07 19:30:19.194846 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]:   </source>
  30052 Sep 07 19:30:19.194846 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]:   <target dev=3D"vdb" bus=3D"virtio"/>
  30053 Sep 07 19:30:19.194846 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]:   <serial>04dd79b2-3c05-4492-b1d7-7969d24df768</serial>
  30054 Sep 07 19:30:19.194846 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]:   <address type=3D"pci" domain=3D"0x0000" bus=3D"0x00" slot=3D"0x=
07" function=3D"0x0"/>
  30055 Sep 07 19:30:19.194846 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]: </disk>
  30056 Sep 07 19:30:19.194846 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]:  {{(pid=3D92697) detach_device /opt/stack/nova/nova/virt/libvirt/=
guest.py:510}}

  # DeviceNotFound raised by QEMU

  https://storage.gra.cloud.ovh.net/v1/AUTH_dcaab5e32b234d56b626f72581e3644=
c/zuul_opendev_logs_4c5/746981/5/check
  /nova-ceph-multistore/4c56def/controller/logs/libvirt/libvirtd_log.txt
  (gzipped)

  332479 2020-09-07 19:30:19.196+0000: 65560: debug : qemuDomainObjBeginJob=
Internal:9416 : Starting job: job=3Dmodify agentJob=3Dnone asyncJob=3Dnone =
(vm=3D0x7f768c0df0b0 name=3Dinstance-0000003a, current job=3Dnone agentJob=
=3Dnone async=3Dnone)
  332480 2020-09-07 19:30:19.196+0000: 65560: debug : qemuDomainObjBeginJob=
Internal:9470 : Started job: modify (async=3Dnone vm=3D0x7f768c0df0b0 name=
=3Dinstance-0000003a)
  332481 2020-09-07 19:30:19.196+0000: 65560: debug : qemuDomainObjEnterMon=
itorInternal:9869 : Entering monitor (mon=3D0x7f769405e470 vm=3D0x7f768c0df=
0b0 name=3Dinstance-0000003a)
  332482 2020-09-07 19:30:19.196+0000: 65560: debug : qemuMonitorDelDevice:=
2848 : devalias=3Dvirtio-disk1
  332483 2020-09-07 19:30:19.196+0000: 65560: debug : qemuMonitorDelDevice:=
2850 : mon:0x7f769405e470 vm:0x7f768c0df0b0 fd:39
  332484 2020-09-07 19:30:19.196+0000: 65560: info : qemuMonitorSend:993 : =
QEMU_MONITOR_SEND_MSG: mon=3D0x7f769405e470 msg=3D{"execute":"device_del","=
arguments":{"id":"virtio-disk1"},"id":"libvirt-369"}^M
  332485  fd=3D-1                                                          =
                =

  332486 2020-09-07 19:30:19.196+0000: 65555: info : qemuMonitorIOWrite:450=
 : QEMU_MONITOR_IO_WRITE: mon=3D0x7f769405e470 buf=3D{"execute":"device_del=
","arguments":{"id":"virtio-disk1"},"id":"libvirt-369"}^M
  332487  len=3D79 ret=3D79 errno=3D0                                      =
                    =

  332488 2020-09-07 19:30:19.197+0000: 65555: debug : qemuMonitorJSONIOProc=
essLine:220 : Line [{"id": "libvirt-369", "error": {"class": "DeviceNotFoun=
d", "desc": "Device 'virtio-disk1' not found"}}]
  332489 2020-09-07 19:30:19.197+0000: 65555: info : qemuMonitorJSONIOProce=
ssLine:239 : QEMU_MONITOR_RECV_REPLY: mon=3D0x7f769405e470 reply=3D{"id": "=
libvirt-369", "error": {"class": "DeviceNotFound", "desc": "Device 'virtio-=
disk1' not found"}}
  332490 2020-09-07 19:30:19.197+0000: 65560: debug : qemuDomainObjExitMoni=
torInternal:9892 : Exited monitor (mon=3D0x7f769405e470 vm=3D0x7f768c0df0b0=
 name=3Dinstance-0000003a)
  332491 2020-09-07 19:30:19.197+0000: 65560: debug : qemuDomainDeleteDevic=
e:128 : Detaching of device virtio-disk1 failed and no event arrived

  # n-cpu continues to retry the detach

  30245 Sep 07 19:30:26.209322 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]: DEBUG nova.virt.libvirt.guest [-] detach device xml: <disk type=
=3D"network" device=3D"disk">
  30246 Sep 07 19:30:26.209322 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]:   <driver name=3D"qemu" type=3D"raw" cache=3D"writeback" discard=
=3D"unmap"/>
  30247 Sep 07 19:30:26.209322 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]:   <source protocol=3D"rbd" name=3D"volumes/volume-04dd79b2-3c05-4=
492-b1d7-7969d24df768">
  30248 Sep 07 19:30:26.209322 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]:     <host name=3D"158.69.70.115" port=3D"6789"/>
  30249 Sep 07 19:30:26.209322 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]:   </source>
  30250 Sep 07 19:30:26.209322 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]:   <target dev=3D"vdb" bus=3D"virtio"/>
  30251 Sep 07 19:30:26.209322 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]:   <serial>04dd79b2-3c05-4492-b1d7-7969d24df768</serial>
  30252 Sep 07 19:30:26.209322 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]:   <address type=3D"pci" domain=3D"0x0000" bus=3D"0x00" slot=3D"0x=
07" function=3D"0x0"/>
  30253 Sep 07 19:30:26.209322 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]: </disk>

  30276 Sep 07 19:30:42.028517 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]: DEBUG nova.virt.libvirt.guest [-] detach device xml: <disk type=
=3D"network" device=3D"disk">
  30277 Sep 07 19:30:42.028517 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]:   <driver name=3D"qemu" type=3D"raw" cache=3D"writeback" discard=
=3D"unmap"/>
  30278 Sep 07 19:30:42.028517 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]:   <source protocol=3D"rbd" name=3D"volumes/volume-04dd79b2-3c05-4=
492-b1d7-7969d24df768">
  30279 Sep 07 19:30:42.028517 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]:     <host name=3D"158.69.70.115" port=3D"6789"/>
  30280 Sep 07 19:30:42.028517 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]:   </source>
  30281 Sep 07 19:30:42.028517 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]:   <target dev=3D"vdb" bus=3D"virtio"/>
  30282 Sep 07 19:30:42.028517 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]:   <serial>04dd79b2-3c05-4492-b1d7-7969d24df768</serial>
  30283 Sep 07 19:30:42.028517 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]:   <address type=3D"pci" domain=3D"0x0000" bus=3D"0x00" slot=3D"0x=
07" function=3D"0x0"/>
  30284 Sep 07 19:30:42.028517 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]: </disk>

  30356 Sep 07 19:30:53.232072 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]: DEBUG nova.virt.libvirt.guest [-] detach device xml: <disk type=
=3D"network" device=3D"disk">
  30357 Sep 07 19:30:53.232072 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]:   <driver name=3D"qemu" type=3D"raw" cache=3D"writeback" discard=
=3D"unmap"/>
  30358 Sep 07 19:30:53.232072 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]:   <source protocol=3D"rbd" name=3D"volumes/volume-04dd79b2-3c05-4=
492-b1d7-7969d24df768">
  30359 Sep 07 19:30:53.232072 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]:     <host name=3D"158.69.70.115" port=3D"6789"/>
  30360 Sep 07 19:30:53.232072 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]:   </source>
  30361 Sep 07 19:30:53.232072 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]:   <target dev=3D"vdb" bus=3D"virtio"/>
  30362 Sep 07 19:30:53.232072 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]:   <serial>04dd79b2-3c05-4492-b1d7-7969d24df768</serial>
  30363 Sep 07 19:30:53.232072 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]:   <address type=3D"pci" domain=3D"0x0000" bus=3D"0x00" slot=3D"0x=
07" function=3D"0x0"/>
  30364 Sep 07 19:30:53.232072 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]: </disk>

  30381 Sep 07 19:31:06.239532 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]: DEBUG nova.virt.libvirt.guest [-] detach device xml: <disk type=
=3D"network" device=3D"disk">
  30382 Sep 07 19:31:06.239532 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]:   <driver name=3D"qemu" type=3D"raw" cache=3D"writeback" discard=
=3D"unmap"/>
  30383 Sep 07 19:31:06.239532 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]:   <source protocol=3D"rbd" name=3D"volumes/volume-04dd79b2-3c05-4=
492-b1d7-7969d24df768">
  30384 Sep 07 19:31:06.239532 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]:     <host name=3D"158.69.70.115" port=3D"6789"/>
  30385 Sep 07 19:31:06.239532 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]:   </source>
  30386 Sep 07 19:31:06.239532 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]:   <target dev=3D"vdb" bus=3D"virtio"/>
  30387 Sep 07 19:31:06.239532 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]:   <serial>04dd79b2-3c05-4492-b1d7-7969d24df768</serial>
  30388 Sep 07 19:31:06.239532 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]:   <address type=3D"pci" domain=3D"0x0000" bus=3D"0x00" slot=3D"0x=
07" function=3D"0x0"/>
  30389 Sep 07 19:31:06.239532 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]: </disk>

  30478 Sep 07 19:31:21.369016 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]: DEBUG nova.virt.libvirt.guest [-] detach device xml: <disk type=
=3D"network" device=3D"disk">
  30479 Sep 07 19:31:21.369016 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]:   <driver name=3D"qemu" type=3D"raw" cache=3D"writeback" discard=
=3D"unmap"/>
  30480 Sep 07 19:31:21.369016 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]:   <source protocol=3D"rbd" name=3D"volumes/volume-04dd79b2-3c05-4=
492-b1d7-7969d24df768">
  30481 Sep 07 19:31:21.369016 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]:     <host name=3D"158.69.70.115" port=3D"6789"/>
  30482 Sep 07 19:31:21.369016 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]:   </source>
  30483 Sep 07 19:31:21.369016 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]:   <target dev=3D"vdb" bus=3D"virtio"/>
  30484 Sep 07 19:31:21.369016 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]:   <serial>04dd79b2-3c05-4492-b1d7-7969d24df768</serial>
  30485 Sep 07 19:31:21.369016 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]:   <address type=3D"pci" domain=3D"0x0000" bus=3D"0x00" slot=3D"0x=
07" function=3D"0x0"/>
  30486 Sep 07 19:31:21.369016 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]: </disk>

  30796 Sep 07 19:31:42.590535 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]: DEBUG nova.virt.libvirt.guest [-] detach device xml: <disk type=
=3D"network" device=3D"disk">
  30797 Sep 07 19:31:42.590535 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]:   <driver name=3D"qemu" type=3D"raw" cache=3D"writeback" discard=
=3D"unmap"/>
  30798 Sep 07 19:31:42.590535 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]:   <source protocol=3D"rbd" name=3D"volumes/volume-04dd79b2-3c05-4=
492-b1d7-7969d24df768">
  30799 Sep 07 19:31:42.590535 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]:     <host name=3D"158.69.70.115" port=3D"6789"/>
  30800 Sep 07 19:31:42.590535 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]:   </source>
  30801 Sep 07 19:31:42.590535 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]:   <target dev=3D"vdb" bus=3D"virtio"/>
  30802 Sep 07 19:31:42.590535 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]:   <serial>04dd79b2-3c05-4492-b1d7-7969d24df768</serial>
  30803 Sep 07 19:31:42.590535 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]:   <address type=3D"pci" domain=3D"0x0000" bus=3D"0x00" slot=3D"0x=
07" function=3D"0x0"/>
  30804 Sep 07 19:31:42.590535 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]: </disk>

  31050 Sep 07 19:32:01.613201 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]: DEBUG nova.virt.libvirt.guest [-] detach device xml: <disk type=
=3D"network" device=3D"disk">
  31051 Sep 07 19:32:01.613201 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]:   <driver name=3D"qemu" type=3D"raw" cache=3D"writeback" discard=
=3D"unmap"/>
  31052 Sep 07 19:32:01.613201 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]:   <source protocol=3D"rbd" name=3D"volumes/volume-04dd79b2-3c05-4=
492-b1d7-7969d24df768">
  31053 Sep 07 19:32:01.613201 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]:     <host name=3D"158.69.70.115" port=3D"6789"/>
  31054 Sep 07 19:32:01.613201 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]:   </source>
  31055 Sep 07 19:32:01.613201 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]:   <target dev=3D"vdb" bus=3D"virtio"/>
  31056 Sep 07 19:32:01.613201 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]:   <serial>04dd79b2-3c05-4492-b1d7-7969d24df768</serial>
  31057 Sep 07 19:32:01.613201 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]:   <address type=3D"pci" domain=3D"0x0000" bus=3D"0x00" slot=3D"0x=
07" function=3D"0x0"/>
  31058 Sep 07 19:32:01.613201 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]: </disk>

  # n-cpu eventually gives up trying to detach the device

  https://storage.gra.cloud.ovh.net/v1/AUTH_dcaab5e32b234d56b626f72581e3644=
c/zuul_opendev_logs_4c5/746981/5/check
  /nova-ceph-multistore/4c56def/controller/logs/screen-n-cpu.txt
  (gzipped)

  31102 Sep 07 19:32:06.850434 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]: ERROR oslo.service.loopingcall [-] Dynamic interval looping call =
'oslo_service.loopingcall.RetryDecorator.__call__.<locals>._func' failed: n=
ova.exception.DeviceDetachFailed: Device detach failed for vdb: Unable t
  31103 Sep 07 19:32:06.850434 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]: ERROR oslo.service.loopingcall Traceback (most recent call last):
  31104 Sep 07 19:32:06.850434 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]: ERROR oslo.service.loopingcall   File "/usr/local/lib/python3.8/d=
ist-packages/oslo_service/loopingcall.py", line 150, in _run_loop
  31105 Sep 07 19:32:06.850434 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]: ERROR oslo.service.loopingcall     result =3D func(*self.args, **=
self.kw)
  31106 Sep 07 19:32:06.850434 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]: ERROR oslo.service.loopingcall   File "/usr/local/lib/python3.8/d=
ist-packages/oslo_service/loopingcall.py", line 428, in _func
  31107 Sep 07 19:32:06.850434 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]: ERROR oslo.service.loopingcall     return self._sleep_time
  31108 Sep 07 19:32:06.850434 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]: ERROR oslo.service.loopingcall   File "/usr/local/lib/python3.8/d=
ist-packages/oslo_utils/excutils.py", line 220, in __exit__
  31109 Sep 07 19:32:06.850434 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]: ERROR oslo.service.loopingcall     self.force_reraise()
  31110 Sep 07 19:32:06.850434 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]: ERROR oslo.service.loopingcall   File "/usr/local/lib/python3.8/d=
ist-packages/oslo_utils/excutils.py", line 196, in force_reraise
  31111 Sep 07 19:32:06.850434 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]: ERROR oslo.service.loopingcall     six.reraise(self.type_, self.v=
alue, self.tb)
  31112 Sep 07 19:32:06.850434 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]: ERROR oslo.service.loopingcall   File "/usr/local/lib/python3.8/d=
ist-packages/six.py", line 703, in reraise
  31113 Sep 07 19:32:06.850434 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]: ERROR oslo.service.loopingcall     raise value
  31114 Sep 07 19:32:06.850434 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]: ERROR oslo.service.loopingcall   File "/usr/local/lib/python3.8/d=
ist-packages/oslo_service/loopingcall.py", line 407, in _func
  31115 Sep 07 19:32:06.850434 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]: ERROR oslo.service.loopingcall     result =3D f(*args, **kwargs)
  31116 Sep 07 19:32:06.850434 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]: ERROR oslo.service.loopingcall   File "/opt/stack/nova/nova/virt/=
libvirt/guest.py", line 489, in _do_wait_and_retry_detach
  31117 Sep 07 19:32:06.850434 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]: ERROR oslo.service.loopingcall     raise exception.DeviceDetachFa=
iled(
  31118 Sep 07 19:32:06.850434 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]: ERROR oslo.service.loopingcall nova.exception.DeviceDetachFailed:=
 Device detach failed for vdb: Unable to detach the device from the live co=
nfig.
  31119 Sep 07 19:32:06.850434 ubuntu-focal-ovh-bhs1-0019682147 nova-comput=
e[92697]: ERROR oslo.service.loopingcall

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1894804/+subscriptions

