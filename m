Received: from eggs.gnu.org ([2001:4830:134:3::10]:60295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cOd8z-0002jf-Ge
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 23:25:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cOd8u-0002DF-HT
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 23:25:45 -0500
Received: from indium.canonical.com ([91.189.90.7]:55936)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cOd8u-0002CZ-8F
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 23:25:40 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cOd8t-0000Nt-12
	for <qemu-devel@nongnu.org>; Wed, 04 Jan 2017 04:25:39 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id E63172E803B
	for <qemu-devel@nongnu.org>; Wed,  4 Jan 2017 04:25:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Jan 2017 04:18:02 -0000
From: Launchpad Bug Tracker <1639225@bugs.launchpad.net>
Reply-To: Bug 1639225 <1639225@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20161104124922.14508.87645.malonedeb@chaenomeles.canonical.com>
Message-Id: <20170104041803.27545.15263.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1639225] Re: qcow2 - filesize 8.1Petabyte
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
https://bugs.launchpad.net/bugs/1639225

Title:
  qcow2 - filesize 8.1Petabyte

Status in QEMU:
  Expired

Bug description:
  =

  problem :

  Filesystem                                     Size  Used Avail Use%
  Mounted on

  /dev/sdd1                                      120G   63G   57G  53%
  /storage/kvmstorage4ssd

  # pwd
  /storage/kvmstorage4ssd/images

  # qemu-img info vsys19_ssd1.qcow2 =

  image: vsys19_ssd1.qcow2
  file format: qcow2
  virtual size: 20G (21474836480 bytes)
  disk size: 11G
  cluster_size: 65536
  Format specific information:
      compat: 1.1
      lazy refcounts: true
      refcount bits: 16
      corrupt: true
  # ls -lah vsys19_*
  -rw------- 1 root root 8.1P Nov  4 13:16 vsys19_ssd1.qcow2

  # ls -la vsys19_*
  -rw------- 1 root root 9007203702079488 Nov  4 13:16 vsys19_ssd1.qcow2

  # qemu-img check vsys19_ssd1.qcow2 =

  qemu-img: Check failed: File too large

  # xfs_repair /dev/sdd1
  Phase 1 - find and verify superblock...
  Phase 2 - using internal log
          - zero log...
          - scan filesystem freespace and inode maps...
          - found root inode chunk
  Phase 3 - for each AG...
          - scan and clear agi unlinked lists...
          - process known inodes and perform inode discovery...
          - agno =3D 0
          - agno =3D 1
          - agno =3D 2
          - agno =3D 3
          - process newly discovered inodes...
  Phase 4 - check for duplicate blocks...
          - setting up duplicate extent list...
          - check for inodes claiming duplicate blocks...
          - agno =3D 0
          - agno =3D 1
          - agno =3D 2
          - agno =3D 3
  Phase 5 - rebuild AG headers and trees...
          - reset superblock...
  Phase 6 - check inode connectivity...
          - resetting contents of realtime bitmap and summary inodes
          - traversing filesystem ...
          - traversal finished ...
          - moving disconnected inodes to lost+found ...
  Phase 7 - verify and correct link counts...
  done

  =

  # pwd
  /storage/kvmstorage4ssd/images

      <disk type=3D'file' device=3D'disk'>
        <driver name=3D'qemu' type=3D'qcow2'/>
        <source file=3D'/storage/kvmstorage4ssd/images/vsys19_ssd1.qcow2'/>
        <target dev=3D'vdn' bus=3D'virtio'/>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x0f' =
function=3D'0x0'/>
      </disk>

  =

  guest OS:

  =

  # uname -a
  Linux vsys19 3.16.0-4-amd64 #1 SMP Debian 3.16.7-ckt11-1 (2015-05-24) x86=
_64 GNU/Linux
  cat /etc/debian_version =

  stretch/sid

  Nov  4 01:23:26 vsys19 kernel: [7654313.024844] end_request: I/O error, d=
ev vdk, sector 8691272
  Nov  4 01:23:26 vsys19 kernel: [7654313.025328] EXT4-fs warning (device d=
m-1): ext4_end_bio:317: I/O error -5 writing to inode 262305 (offset 0 size=
 4202496 s
  tarting block 1085897)
  Nov  4 01:23:26 vsys19 kernel: [7654313.025334] Buffer I/O error on devic=
e dm-1, logical block 1085897
  Nov  4 01:23:26 vsys19 kernel: [7654313.025488] Buffer I/O error on devic=
e dm-1, logical block 1085898
  Nov  4 01:23:26 vsys19 kernel: [7654313.025632] Buffer I/O error on devic=
e dm-1, logical block 1085899
  Nov  4 01:23:26 vsys19 kernel: [7654313.025776] Buffer I/O error on devic=
e dm-1, logical block 1085900
  Nov  4 01:23:26 vsys19 kernel: [7654313.025920] Buffer I/O error on devic=
e dm-1, logical block 1085901
  Nov  4 01:23:26 vsys19 kernel: [7654313.026064] Buffer I/O error on devic=
e dm-1, logical block 1085902
  Nov  4 01:23:26 vsys19 kernel: [7654313.026207] Buffer I/O error on devic=
e dm-1, logical block 1085903
  Nov  4 01:23:26 vsys19 kernel: [7654313.026350] Buffer I/O error on devic=
e dm-1, logical block 1085904
  Nov  4 01:23:26 vsys19 kernel: [7654313.026500] Buffer I/O error on devic=
e dm-1, logical block 1085905
  Nov  4 01:23:26 vsys19 kernel: [7654313.028837] Buffer I/O error on devic=
e dm-1, logical block 1085906
  Nov  4 01:23:26 vsys19 kernel: [7654313.031122] end_request: I/O error, d=
ev vdk, sector 8692280
  Nov  4 01:23:26 vsys19 kernel: [7654313.031325] EXT4-fs warning (device d=
m-1): ext4_end_bio:317: I/O error -5 writing to inode 262305 (offset 0 size=
 4202496 starting block 1086023)
  Nov  4 01:23:26 vsys19 kernel: [7654313.031388] end_request: I/O error, d=
ev vdk, sector 8693288
  Nov  4 01:23:26 vsys19 kernel: [7654313.031527] EXT4-fs warning (device d=
m-1): ext4_end_bio:317: I/O error -5 writing to inode 262305 (offset 0 size=
 4202496 starting block 1086149)
  Nov  4 01:23:26 vsys19 kernel: [7654313.031598] end_request: I/O error, d=
ev vdk, sector 8694296
  Nov  4 01:23:26 vsys19 kernel: [7654313.031736] EXT4-fs warning (device d=
m-1): ext4_end_bio:317: I/O error -5 writing to inode 262305 (offset 0 size=
 4202496 starting block 1086275)
  Nov  4 01:23:26 vsys19 kernel: [7654313.031798] end_request: I/O error, d=
ev vdk, sector 8695304
  Nov  4 01:23:26 vsys19 kernel: [7654313.031933] EXT4-fs warning (device d=
m-1): ext4_end_bio:317: I/O error -5 writing to inode 262305 (offset 0 size=
 4202496 starting block 1086401)

  KVM host :
  # cat /etc/debian_version =

  stretch/sid

  Debian

  =

  # uname -a
  Linux asus1 4.5.5-custom #1 SMP Sun May 22 21:14:57 CEST 2016 x86_64 GNU/=
Linux

  # dpkg -l | grep -i qemu
  ii  ipxe-qemu                             1.0.0+git-20150424.a25a16d-1   =
 all          PXE boot firmware - ROM images for qemu
  ii  qemu                                  1:2.5+dfsg-5+b1                =
 amd64        fast processor emulator
  ii  qemu-kvm                              1:2.5+dfsg-5+b1                =
 amd64        QEMU Full virtualization on x86 hardware
  ii  qemu-slof                             20151103+dfsg-2                =
 all          Slimline Open Firmware -- QEMU PowerPC version
  ii  qemu-system                           1:2.5+dfsg-5+b1                =
 amd64        QEMU full system emulation binaries
  ii  qemu-system-arm                       1:2.5+dfsg-5+b1                =
 amd64        QEMU full system emulation binaries (arm)
  ii  qemu-system-common                    1:2.5+dfsg-5+b1                =
 amd64        QEMU full system emulation binaries (common files)
  ii  qemu-system-mips                      1:2.5+dfsg-5+b1                =
 amd64        QEMU full system emulation binaries (mips)
  ii  qemu-system-misc                      1:2.5+dfsg-5+b1                =
 amd64        QEMU full system emulation binaries (miscelaneous)
  ii  qemu-system-ppc                       1:2.5+dfsg-5+b1                =
 amd64        QEMU full system emulation binaries (ppc)
  ii  qemu-system-sparc                     1:2.5+dfsg-5+b1                =
 amd64        QEMU full system emulation binaries (sparc)
  ii  qemu-system-x86                       1:2.5+dfsg-5+b1                =
 amd64        QEMU full system emulation binaries (x86)
  ii  qemu-user                             1:2.5+dfsg-5+b1                =
 amd64        QEMU user mode emulation binaries
  ii  qemu-user-binfmt                      1:2.5+dfsg-5+b1                =
 amd64        QEMU user mode binfmt registration for qemu-user
  ii  qemu-utils                            1:2.5+dfsg-5+b1                =
 amd64        QEMU utilities
  ii  qemubuilder                           0.80                           =
 amd64        pbuilder using QEMU as backend

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1639225/+subscriptions
