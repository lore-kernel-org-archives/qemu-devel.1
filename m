Received: from eggs.gnu.org ([2001:4830:134:3::10]:58127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1ekBOW-00074U-FT
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 11:19:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1ekBOS-0000WH-An
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 11:19:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54340)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rjones@redhat.com>) id 1ekBOR-0000Vl-Vu
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 11:19:20 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9A700776F2
	for <qemu-devel@nongnu.org>; Fri,  9 Feb 2018 16:19:18 +0000 (UTC)
Date: Fri, 9 Feb 2018 16:19:06 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20180209161906.GA27744@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] ANNOUNCE: libguestfs 1.38 released
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: libguestfs@redhat.com, virt-tools-list@redhat.com, libvir-list@redhat.com, qemu-devel@nongnu.org

I'm pleased to announce libguestfs 1.38, a library and a set of tools
for accessing and modifying virtual machine disk images.

This release represents about a year of work by many contributors.
I'd like to call out in particular substantial contributions from:
C=C3=A9dric Bosdonnat, Pavel Butsykin, Matteo Cafasso, Tom=C3=A1=C5=A1 Go=
lembiovsk=C3=BD,
Nikos Skalkotos, and Pino Toscano.

Virt-builder-repository is a new tool for creating virt-builder
repositories.  Virt-rescue has been rewritten, implementing
implementing job control, -m and -i options, escape keys.  Virt-v2v
has several new methods to pull VMs out of VMware faster.  The
inspection code was rewritten and placed inside the daemon making it
much faster and more robust.

Of course dozens of other features have been added, and many bugs
fixed.  See the release notes below for full details.

You can get libguestfs 1.38 from here:

   Main website: http://libguestfs.org/ [not updated yet]
         Source: http://libguestfs.org/download/1.38-stable/
         Fedora: https://koji.fedoraproject.org/koji/packageinfo?packageI=
D=3D8391
 Debian/experimental: https://packages.debian.org/libguestfs0

Note for distro packagers: ocaml >=3D 4.01, ocaml-hivex are now
mandatory build dependencies.  If using glibc >=3D 2.27 which dropped
support for SunRPC and crypt(3), you will need rpcgen, libtirpc and
libxcrypt.

Rich.

----------------------------------------------------------------------

Release notes for libguestfs 1.38

These are also available online at:
http://libguestfs.org/guestfs-release-notes.1.html

   New features
       New tools

       Virt-builder-repository is a new tool allowing end users to create=
 and
       update virt-builder repositories (C=C3=A9dric Bosdonnat).

       Virt-rescue (while not a new tool) has been substantially rewritte=
n,
       implementing job control, -m and -i options, escape keys, etc.

       New features in existing tools

       Virt-builder planner has been improved so that faster and more
       efficient build plans are chosen for complex cases, especially whe=
n
       either the tmpdir or output is on networked storage.

       New virt-builder Fedora templates (starting with Fedora 26) will h=
ave
       plain partition layout and use GPT for partitions.

       Virt-customize "firstboot" scripts in guests using systemd are now
       installed under the "multi-user.target" instead of "default.target=
" so
       they will only run when the system is booted normally.

       Virt-customize now sets a random /etc/machine-id for Linux guests,=
 if
       one is not already set.

       Virt-df now works correctly on filesystems with block sizes smalle=
r
       than 1K (Nikolay Ivanets).

       Virt-dib has further compatibility enhancements with diskimage-bui=
lder
       (Pino Toscano).

       Virt-sysprep removes "DHCP_HOSTNAME" from ifcfg-* files.

       Virt-sysprep now works on Oracle Linux (Jamie Iles).

       Virt-resize now correctly copies GPT partition attributes from the
       source to the destination (C=C3=A9dric Bosdonnat).

       Bash tab completion implemented or enhanced for: virt-win-reg,
       virt-v2v-copy-to-local.

       virt-v2v and virt-p2v

       Virt-v2v can now read VMware VMX files directly, either from local
       disk, NFS storage, or over SSH from an ESXi hypervisor.

       Virt-v2v can now use VDDK as an input source.

       Both virt-v2v and virt-p2v are now able to pass through the source=
 CPU
       vendor, model and topology.  However unfortunately not all source =
and
       target hypervisors are able to provide or consume this data at pre=
sent
       (Tom=C3=A1=C5=A1 Golembiovsk=C3=BD).

       Virt-v2v now supports encrypted guests (Pino Toscano).

       Virt-v2v can now handle VMware snapshots.  Note that the snapshots=
 are
       collapsed =E2=80=94 it does not convert the chain of snapshots int=
o a chain of
       snapshots.

       Virt-v2v now installs Windows 10 / Windows Server 2016 virtio bloc=
k
       drivers correctly (Pavel Butsykin, Kun Wei).

       Virt-v2v now installs virtio-rng, balloon and pvpanic drivers, and
       correctly sets this in the target hypervisor metadata for hypervis=
ors
       which support that (Tom=C3=A1=C5=A1 Golembiovsk=C3=BD).

       Virt-v2v now installs both legacy and modern virtio keys in the Wi=
ndows
       registry (Ladi Prosek).

       Virt-p2v can now preserve (in some cases) the offset of the Real T=
ime
       Clock from UTC.

       Virt-p2v now combines several scp commands to the conversion serve=
r
       into a single command, improving conversion times.

       Virt-v2v now detects the special Linux Xen PV-only kernels correct=
ly
       (Laszlo Ersek).

       Virt-v2v -o glance now generates the right properties for UEFI gue=
sts
       (Pino Toscano).

       Virt-v2v -o null now avoids spooling the guest to a temporary file=
,
       instead it writes to the qemu "null block device".  This makes it
       faster and use almost no disk space.

       Virt-v2v -o rhv now supports Windows 2016 Server guest type.

       Virt-v2v -i libvirtxml can now open network disks over http or htt=
ps.

       Virt-v2v will now give a warning about host passthrough devices (P=
ino
       Toscano).

       The virt-v2v --machine-readable output has been enhanced so it inc=
ludes
       "vcenter-https", "xen-ssh" and "in-place" facts (Pino Toscano).

       Language bindings

       Fix multiple memory leaks and other data corruption problems in th=
e
       Java bindings (Pino Toscano).

       Perl %guestfs_introspection has been dropped.

       Inspection

       Inspection support was rewritten in OCaml and included inside the
       daemon.  This makes inspection considerably faster, more robust an=
d
       more easily extensible in future.

       Better icon support for ALT Linux guests (Pino Toscano).

       Better support for NeoKylin (Qingzheng Zhang).

       Can handle OSes like Void Linux which do not include "VERSION_ID" =
in
       /etc/os-release (Pino Toscano).

       Add support for Microsoft MS-DOS (Daniel Berrang=C3=A9).

       Architectures and platforms

       Multiple fixes for S/390 architecture.  Libguestfs and all the too=
ls
       should now compile and run on this architecture.

       Other

       The libguestfs API is now thread-safe (although not parallel).  Yo=
u can
       call APIs on the same handle from multiple threads without needing=
 to
       take a lock.

   Security
       There were multiple vulnerabilities in the icoutils "wrestool" pro=
gram
       which is run by libguestfs to create icons for Windows guests.  Us=
ing
       the latest "wrestool" is recommended.

   API
       New APIs

       "hivex_value_string"
           This replaces the deprecated "hivex_value_utf8" API, but does =
the
           same thing.

       "part_get_gpt_attributes"
       "part_set_gpt_attributes"
           Read and write GPT partition attribute flags (C=C3=A9dric Bosd=
onnat).

       "part_resize"
           Enlarge or shrink an existing partition (Nikos Skalkotos).

       "yara_destroy"
       "yara_load"
       "yara_scan"
           Support for the Yara malware scanning engine (Matteo Cafasso).

       Other API changes

       APIs implemented in the daemon can now be written in either C or O=
Caml.
       Several APIs were rewritten in OCaml, although we are not planning=
 to
       rewrite all of them.

       You will now get a clear error message if you try to add too many =
disks
       to the appliance, instead of getting a peculiar failure from qemu.

       Certain APIs accidentally allowed you to use "/dev/urandom" as an =
input
       "device", eg. "g.copy_device_to_device("/dev/urandom", "/dev/sda")=
".
       The code has been modified to forbid this usage.

       All APIs for inspecting installer CDs have been deprecated.  Use
       libosinfo for this task.

   Build changes
       A working OCaml compiler =E2=89=A5 4.01 is now required for buildi=
ng
       libguestfs.  The "./configure --disable-ocaml" option remains but =
is
       only used to disable the OCaml language bindings.

       Add "RELEASES" file which lists release dates for each version of
       libguestfs.  You must update this file when making a new release.

       Documentation generated by "gtk-doc" has been removed.  "./configu=
re
       --enable-gtk-doc" now does nothing.

       Libtirpc is now used for XDR functions and rpcgen.  Note that glib=
c has
       deprecated and in most Linux distros dropped these, so for most pe=
ople
       this will be an extra dependency (Martin Kletzander).

       Libxcrypt is now used for crypt(3).  This is required if using gli=
bc =E2=89=A5
       2.27.

       "ocaml-hivex" is now required.

       Libvirt =E2=89=A5 1.2.20 is now required.

       There is now a "make check-root" target for tests which need to be=
 run
       as root (analogous to "make check-slow").

       "./configure"-time check for "__attribute__((cleanup))" now works =
in
       the cross-compilation case (Yann E. Morin).

       The "AUTHORS" and "p2v/about-authors.c" files are now generated fr=
om a
       single place.

       Either GnuPG v1 or v2 can be used.

       "./configure --with-guestfs-path" may be used to set the default
       "LIBGUESTFS_PATH".  In addition the way that the path is searched =
has
       changed slightly so that all types of appliances are searched in e=
ach
       path element separately (Pavel Butsykin).

       "GUESTFSD_EXT_CMD" which was used to mark external commands in the
       daemon has been removed.  It was originally used by SUSE builds, b=
ut
       they have not been using it for a while.

       The output from "./configure" is now visually grouped under headin=
gs
       related to what it is doing, making it much easier to scan (Pino
       Toscano).

       OCaml dependencies are now generated from a single script instead =
of
       multiple not-quite-the-same Makefile fragments.

       "./configure --with-distro=3DID" can be used to override automatic=
 Linux
       distro detection at build time (Pino Toscano).

       qemu =E2=89=A5 2.10 is supported (but not required).  This adds ma=
ndatory
       locking to disks and libguestfs turns this off in certain circumst=
ances
       when it is known to be safe (Lars Seipel, Peter Krempa, Daniel
       Berrang=C3=A9, Pino Toscano, Fam Zheng, Yongkui Guo, V=C3=A1clav K=
adl=C4=8D=C3=ADk).

   Internals
       Most common code has been moved to the common/ subdirectory, with =
OCaml
       common code being in common/ml* directories (eg.  common/visit and
       common/mlvisit contain the visitor library in C and OCaml
       respectively).  The mllib directory has been deleted and replaced =
by
       common/mltools.

       There is now a lightweight OCaml binding for PCRE, see common/mlpc=
re.
       Use of OCaml "Str" library has been mostly replaced with PCRE.

       Add more calls to "udev_settle" to improve stability of partition =
code
       (Dawid Zamirski).

       Run "udev_settle" with --exit-if-exists option, which improves the
       speed of this command (Pavel Butsykin).

       Detect new locations of major(3), minor(3), makedev(3).

       Actions can now be deprecated with no suggested replacement, for A=
PIs
       such as "guestfs_wait_ready" that should simply be removed from cl=
ient
       code.

       Use gnulib "set_nonblocking_flag" wrapper instead of calling fcntl=
(2)
       with "O_NONBLOCK" (Eric Blake).  Similarly "set_cloexec_flag".

       Fix memory leak in XFS version of "guestfs_vfs_minimum_size" (Pino
       Toscano).

       Valgrind checks now run on the virt-p2v binary.

       Unicode single quotes ("=E2=80=98=E2=80=99") and now used in place=
 of '' or `'
       throughout the code and documentation.  Similarly for "=E2=80=99s"=
 instead of
       "'s".

       The "is_zero" function has been reimplemented for greater speed (E=
ric
       Blake).

       In the direct backend, virtio-blk support has been removed.  Virti=
o-
       scsi is now the only supported way to add disks.

       Generator string parameter and return types have been rationalised=
 so
       there are only two types ("String", "StringList") with many subtyp=
es
       eg. "FileIn" becomes "String (FileIn, ...)".

       The appliance disk image can now be in formats other than raw (Pav=
el
       Butsykin).

       Multiple improvements to how we automatically build Debian templat=
es
       for virt-builder (Pino Toscano).  Enable serial console for these
       templates (Florian Klink).

       In the daemon, instead of making a private copy of lvm.conf and
       modifying it (eg for filters), start with an empty file since LVM
       understands that to mean "all defaults" (Alasdair Kergon, Zdenek
       Kabelac).

       The "direct" backend can now run QMP queries against the QEMU bina=
ry,
       enhancing the kinds of information we can detect.  In addition the=
 code
       to query QEMU has been made more robust for handling multiple para=
llel
       queries of different versions of QEMU.

       OCaml Augeas bindings are bundled under common/mlaugeas.  The long=
 term
       plan is to remove this and use system ocaml-augeas when it is more
       widely available in distros (Pino Toscano).

       All OCaml modules ("*.ml" files) are now required to have an inter=
face
       file ("*.mli").  If they don't export anything then the interface =
will
       be empty except for comments.

       Certain OCaml features in OCaml =E2=89=A5 4.01 are used throughout=
 the code,
       including replacing =E2=80=98{ field =3D field }=E2=80=99 with =E2=
=80=98{ field }=E2=80=99.

       Virt-builder "make-template" utility now uses the "virt-install
       --transient" option so that we should never need to clean up left =
over
       domains after a crash.  It also saves kickstarts and virt-install
       commands, which are committed to git for future reference.

       /dev/shm is now created in the appliance (Nicolas Hicher).

       In verbose mode on Fedora guests, virt-customize will now use "dnf
       --verbose" enabling better debugging output.

       Virt-v2v input and output classes now contain a "#precheck" method
       which is used to perform environmental checks before conversion st=
arts.

       Virt-p2v enables miniexpect debugging.  It is written to stderr (o=
f
       virt-p2v).

       Virt-v2v free space checks are more liberal especially for smaller
       guests (Pino Toscano).

   Bugs fixed
       https://bugzilla.redhat.com/1540535
           Example URI of "Convert from ESXi hypervisor over SSH to local
           libvirt" is incorrect in v2v man page

       https://bugzilla.redhat.com/1539395
           virt-customize segfaults after upgrading to 1.37.35-3

       https://bugzilla.redhat.com/1536765
           Libguestfs Perl bindings can leak a small amount of memory on =
error

       https://bugzilla.redhat.com/1536763
           libguestfs Lua bindings use strerror(), which isn=E2=80=99t th=
read safe

       https://bugzilla.redhat.com/1536603
           man page makes no mention of using '--' when trying to change =
exit
           on error behavior

       https://bugzilla.redhat.com/1525241
           virt-df displays zeros for filesystems with block size =3D512

       https://bugzilla.redhat.com/1519204
           v2v should improve the result when convert a rhel7.4 guest wit=
h no
           available kernels found in the bootloader

       https://bugzilla.redhat.com/1518517
           virt-v2v fails with "unsupported configuration: shared access =
for
           disk 'sdb' requires use of supported storage format"

       https://bugzilla.redhat.com/1516094
           Mere presence of QEMU file locking options breaks NBD (Block
           protocol 'nbd' doesn't support the option 'locking')

       https://bugzilla.redhat.com/1514756
           ./configure --disable-ocaml breaks building common/mlpcre whic=
h
           breaks building daemon

       https://bugzilla.redhat.com/1513884
           [RFE]Should update some vddk info in v2v man page

       https://bugzilla.redhat.com/1508874
           virt-v2v: warning: ova disk has an unknown VMware controller t=
ype
           (20)

       https://bugzilla.redhat.com/1506572
           virt-v2v '-i ova' is not parsing the MAC address from the sour=
ce
           OVF

       https://bugzilla.redhat.com/1506511
           virt-builder fails to parse repo file if it has blank space af=
ter
           the repository identifier

       https://bugzilla.redhat.com/1503958
           Failed to convert the rhel5 guest with kmod-xenpv installed fr=
om
           xen server by virt-v2v

       https://bugzilla.redhat.com/1503497
           qemu-kvm fails to open qcow2 files in read-only mode with qemu=
-kvm
           1.5.3

       https://bugzilla.redhat.com/1500673
           Error info shows wrong sometimes when ssh to conversion server
           using non-root user with sudo on p2v client

       https://bugzilla.redhat.com/1500537
           /dev/shm does not exist in the appliance environment

       https://bugzilla.redhat.com/1497475
           guestfish cannot list commands from interactive mode

       https://bugzilla.redhat.com/1493048
           Unbound constructor Hivex.OPEN_UNSAFE

       https://bugzilla.redhat.com/1484957
           bump debian images to use single-partition layout

       https://bugzilla.redhat.com/1482737
           virt-resize failed to expand swap partition for RHEL5.11 guest
           image with "parsing UUID failed"

       https://bugzilla.redhat.com/1477623
           Running file API on a special chardev may hang forever

       https://bugzilla.redhat.com/1476081
           inspect-os  report error: could not parse integer in version
           number: V7Update2

       https://bugzilla.redhat.com/1472719
           [RFE]Add warning in process of v2v converting guest which has =
pci
           passthrough device

       https://bugzilla.redhat.com/1472208
           virt-v2v fails on opensuse 13.2 guest with error: statns:
           statns_stub: path must start with a / character

       https://bugzilla.redhat.com/1469655
           firstboot scripts are not correctly installed in Fedora 26

       https://bugzilla.redhat.com/1466563
           Libguestfs should pass copyonread flag through to the libvirt =
XML

       https://bugzilla.redhat.com/1465665
           1.36.x build failure: gtkdocize fails using newer autotools du=
e to
           missing GTK_DOC_CHECK in configure.ac

       https://bugzilla.redhat.com/1460338
           guestfs_shutdown hangs if main process sets signal handlers

       https://bugzilla.redhat.com/1459979
           guestfs_add_domain_argv fails with readonly option when vdi/vh=
d
           disk is attached to libvirt domain

       https://bugzilla.redhat.com/1451665
           RFE: Virt-v2v can't convert the guest which has encrypted part=
ition

       https://bugzilla.redhat.com/1450325
           document URI format for -a parameters of tools

       https://bugzilla.redhat.com/1448739
           RFE: Support multicore decompression for OVA files using pigz =
and
           pxz

       https://bugzilla.redhat.com/1447202
           Win 2016 guest is described as Win 10 after imported to RHEVM

       https://bugzilla.redhat.com/1441197
           RFE: ability to convert VMware virtual machines via vmx

       https://bugzilla.redhat.com/1438939
           Please drop or update GnuPG (1.4.x) dependency

       https://bugzilla.redhat.com/1438794
           [RFE] Install Windows virtio-rng drivers on VMs imported

       https://bugzilla.redhat.com/1433937
           virt-inspector can't get icon info from altlinux-centaurus

       https://bugzilla.redhat.com/1433577
           policycoreutils setfiles >=3D 2.6 does .. nothing

       https://bugzilla.redhat.com/1431579
           Windows 8 UEFI from VMware to KVM fails to boot after conversi=
on

       https://bugzilla.redhat.com/1430680
           There is error info about "No such file or directory" when con=
vert
           a guest from ova file by v2v

       https://bugzilla.redhat.com/1430184
           virt-dib should generate sha256 checksum instead of sha512

       https://bugzilla.redhat.com/1429506
           RFE: OVMF should be detected on conversion server to prevent f=
ailed
           conversion

       https://bugzilla.redhat.com/1429491
           Should rename network name of rhv in virt-v2v man page

       https://bugzilla.redhat.com/1427529
           virt-sysprep should remove DHCP_HOSTNAME

       https://bugzilla.redhat.com/1417306
           QEMU image file locking (libguestfs)

       https://bugzilla.redhat.com/1409024
           [Debian] Missing db_dump abort inspection

       https://bugzilla.redhat.com/1406906
           Segmentation fault when reading corrupted path with Python 3
           bindings

       https://bugzilla.redhat.com/1379289
           RFE: virt-p2v should support mnemonic operations

       https://bugzilla.redhat.com/1378022
           There is virt-v2v warning about <listen type=3D'none'> during
           converting a guest which has listen type=3D'none' in XML

       https://bugzilla.redhat.com/1376547
           qemu-system-s390x: -device
           isa-serial,chardev=3Dcharserial0,id=3Dserial0: 'isa-serial' is=
 not a
           valid device model name

       https://bugzilla.redhat.com/1374232
           selinux relabel fails on RHEL 6.2 guests with "libguestfs erro=
r:
           selinux_relabel: : Success"

       https://bugzilla.redhat.com/1367738
           Missing bash completion scripts for: virt-diff guestunmount vi=
rt-
           copy-in virt-copy-out virt-customize virt-get-kernel
           virt-p2v-make-disk virt-p2v-make-kickstart virt-tar-in virt-ta=
r-out
           virt-v2v-copy-to-local virt-win-reg

       https://bugzilla.redhat.com/1362649
           RFE: virt-sysprep does not utilize libguestfs encryption suppo=
rt

       https://bugzilla.redhat.com/1172425
           [RFE]virt-v2v failed to convert VMware ESX VM with snapshot

       https://bugzilla.redhat.com/1171654
           Modify a file in virt-rescue with vi on some linux terminal su=
ch as
           yakuake, can lead to abnormal display in virt-rescue shell

       https://bugzilla.redhat.com/1167623
           Remove "If reporting bugs, run virt-v2v with debugging enabled=
 .."
           message when running virt-p2v

       https://bugzilla.redhat.com/1152819
           Can not end a running command in virt-rescue by press ^C or ot=
her
           keys, the only way is to exit virt-rescue



--=20
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rj=
ones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-top is 'top' for virtual machines.  Tiny program with many
powerful monitoring features, net stats, disk stats, logging, etc.
http://people.redhat.com/~rjones/virt-top
