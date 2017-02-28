Received: from eggs.gnu.org ([2001:4830:134:3::10]:55748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1cipzr-0006bS-PH
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 17:11:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1cipzo-00038g-Ez
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 17:11:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43288)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rjones@redhat.com>) id 1cipzo-00038F-5V
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 17:11:48 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B61826AADC
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 22:11:47 +0000 (UTC)
Date: Tue, 28 Feb 2017 22:11:44 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20170228221144.GA14899@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] ANNOUNCE: libguestfs 1.36 released
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: libguestfs@redhat.com, virt-tools-list@redhat.com, libvir-list@redhat.com
Cc: qemu-devel@nongnu.org

I'm please to announce libguestfs 1.36, a library and a set of tools
for accessing and modifying virtual machine disk images.

This release represents about 7 months of work by many contributors.
I'd like to call out in particular substantial code contributions
from: Pino Toscano, Tom=C3=A1=C5=A1 Golembiovsk=C3=BD, C=C3=A9dric Bosdon=
nat, Roman Kagan,
Dawid Zamirski and Matteo Cafasso.  Also our testing team: Tingting
Zheng, Xiang Hua Chen, Ming Xie, Junquin Zhou and Xiaodai Wang.

Amongst the new features are substantial enhancements to virt-v2v
including support for Debian and Ubuntu guest conversions, and
conversions from AWS; a new "virt-tail" command for following log
files in guests; even more support for encrypted guests; robustness
when handling Windows guests with corrupted registries; ExFAT support;
GCC 7 support; and considerable internal code refactoring to make
things more maintainable.

Of course dozens of other features have been added, and many bugs
fixed.  See the release notes below for full details.

You can get libguestfs 1.36 from here:

   Main website: http://libguestfs.org/
         Source: http://libguestfs.org/download/1.36-stable/
         Fedora: https://koji.fedoraproject.org/koji/packageinfo?packageI=
D=3D8391
 Debian/experimental: https://packages.debian.org/libguestfs0

Note for distro packagers: libmagic (part of the 'file' command line
tool) is now a required build dependency.  It was previously optional.

Rich.

----------------------------------------------------------------------

Release notes for libguestfs 1.36

These are also available online at:
http://libguestfs.org/guestfs-release-notes.1.html

   New features
     New tools

       Virt-tail is a new tool for following (tailing) log files within a
       guest, similar to the regular "tail -f" command.

     New features in existing tools

       Virt-customize, virt-get-kernel, virt-sparsify and virt-sysprep ca=
n now
       handle encrypted guests (Pino Toscano).

       Virt-builder and virt-customize now support --append-line, which i=
s
       useful for adding lines to the end of configuration files.

       Virt-resize can now shrink and expand swap partitions (Pino Toscan=
o).

       Virt-resize can now output to non-local disks (Pino Toscano).

       Virt-sysprep has a new operation called "backup-files" for removin=
g
       editor backups, and "passwd-backups" for removing /etc/passwd- and
       similar.

       Virt-dib can now create checksums using the new --checksum option =
(Pino
       Toscano).

       Virt-dib can now create tgz files.  In addition, extended attribut=
es
       and SELinux labels are preserved in the output tar file (Pino Tosc=
ano).

       Virt-dib can now create squashfs files (Pino Toscano).

       Bash tab-completion is now available in every command line tool th=
at is
       shipped.

     virt-v2v and virt-p2v

       Conversions of Debian (6+) and Ubuntu (10.04+) guests are now supp=
orted
       (Tom=C3=A1=C5=A1 Golembiovsk=C3=BD, Pino Toscano).

       Conversions from SUSE Xen hypervisor have now been tested (C=C3=A9=
dric
       Bosdonnat).

       Windows conversions may now install a program "pnp_wait.exe" which
       prevents conflicts between the Windows Plug-and-Play Manager and o=
ur
       own scripts that install virtio device drivers.  Enabling this req=
uires
       the "pnp_wait.exe" program to be built separately (Roman Kagan).

       OVA files exported from AWS can now be converted (Shahar Havivi).

       When converting OVA files, in some circumstances virt-v2v can now =
read
       disk images directly from the OVA input file instead of needing to
       unpack the OVA file to a temporary directory.  This can save large
       amounts of disk space, and is quicker (Tom=C3=A1=C5=A1 Golembiovsk=
=C3=BD).

       Virt-p2v can now be built on RHEL 5 (2007-era) Linux and RHEL 6, w=
hich
       means that 32 bit and hardware with ancient fakeraid disks can be
       virtualized.  Binaries of virt-p2v based on these old versions of =
RHEL
       can be found at http://oirase.annexia.org/virt-p2v/

       Virt-p2v can now use nbdkit (an NBD server) as an alternative to q=
emu-
       nbd.  In addition, virt-p2v can use "socket activation" which is a=
 more
       robust method for opening the NBD listening socket.  Socket activa=
tion
       works with qemu-nbd or nbdkit, but requires the most up to date
       versions.

       To prevent timeouts during P2V conversions, virt-p2v inhibits powe=
r
       saving on the physical machine, and also sends ping packets over t=
he
       ssh control and data connections.

       Virt-v2v no longer removes the "Processor" and "Intelppm" nodes fr=
om
       the Windows Registry.

       Xen and vCenter conversions can now be done using the libvirt back=
end,
       provided libvirt =E2=89=A5 2.1.0 is used.

       /dev/srX (SCSI CD-ROM) devices are ignored (Tom=C3=A1=C5=A1 Golemb=
iovsk=C3=BD).

       When converting SUSE Linux guests, use /etc/modprobe.conf.local if=
 it
       exists.

       Removing VMware tools from Linux guests should now work reliably (=
Pino
       Toscano).

       When converting OVA files, virt-v2v now checks the disk image hash
       contained in the manifest file, whereas previously it was ignored
       because of a mistake in the code.  In addition, SHA256 hashes are =
now
       supported (Tom=C3=A1=C5=A1 Golembiovsk=C3=BD).

       When converting OVA files that contain compressed disk images, we =
now
       trust the "ovf:compression" attribute from the metadata instead of
       using content sniffing on the disk image (Tom=C3=A1=C5=A1 Golembio=
vsk=C3=BD).

       A new flag --vdsm-compat has been added to -o vdsm mode, allowing =
more
       efficient qcow2 images to be generated.

       Since the RHEV product [commercially supported version of oVirt] h=
as
       now been renamed to RHV, "RHEV" was changed to "RHV" throughout th=
e
       tooling.  In particular, -o rhev becomes -o rhv, although the old =
name
       can be used for backwards compatibility.

       The "RHEV-APT" utility is only installed when the output hyperviso=
r is
       oVirt or RHV.

       A problem with virt-v2v running out of memory when doing an SELinu=
x
       relabel of the guest filesystem should now be resolved.

     Language bindings

       Setting "EXTRA_JAVAC_FLAGS" before ./configure allows you to add
       arbitrary flags to "javac" when compiling the Java bindings.

       Use of any libguestfs API which returned a single struct, from Per=
l or
       Java bindings, would have leaked memory.  This has now been fixed =
(Pino
       Toscano).

     Inspection

       Inspection of Windows guests with mildly corrupted Windows Registr=
y
       hives should now work instead of failing with an error.  This feat=
ure
       requires hivex =E2=89=A5 1.3.14 (Dawid Zamirski).

       For Debian guests, we can now read the URL, source name, summary a=
nd
       full description of installed packages.  For RPM-based guests we c=
an
       read the URL, summary and description (Pino Toscano).

       Inspection of guest operating systems that use a separate /usr
       partition should now work more reliably (Pino Toscano).

       When parsing guest /etc/fstab, paths are reduced to a canonical fo=
rm
       (eg. "///usr//local//" =E2=86=92 "/usr/local").

       Inspection of btrfs subvolumes now works where the /etc/fstab opti=
ons
       field contains commas.

       /dev/cdN devices in guest /etc/fstab are ignored (Pino Toscano).

     Architectures and platforms

       Stable releases are now tested on aarch64, ppc64 and ppc64le
       architectures.

       The RISC-V architecture is now handled as a guest, and libguestfs =
will
       now at least compile on RISC-V (but probably not work as there is =
no
       usable qemu at the time of writing).

       Detection of S/390 and S/390x binaries and guests is now supported=
.

     Other

       ExFAT filesystems are now supported (Miles Wolbe).

   Security
       See also guestfs-security(1).

       There were no CVEs reported in this development cycle.  However so=
me
       security-related hardening was carried out as described below.

       Temporary filenames are now always generated using randomness from
       /dev/urandom (previously the C function random(3) was used in one
       case).

       The $TERM environment variable is now validated before passing it
       through to the appliance kernel command line.

   API
     New APIs

       "guestfs_aug_transform"
           Exposes the Augeas "aug_transform" API (Pino Toscano).

       "guestfs_find_inode"
           Find files by inode number (Matteo Cafasso).

       "guestfs_inspect_get_windows_software_hive"
       "guestfs_inspect_get_windows_system_hive"
           Return the path to the Windows "HKLM\SYSTEM" and "HKLM\SOFTWAR=
E"
           hives computed during inspection.

       "guestfs_mksquashfs"
           Create a squashfs filesystem from a path (Pino Toscano).

     Other API changes

       "guestfs_add_domain"
           This call now handles libvirt file-based volumes correctly, wh=
ere
           previously these would have been ignored.  Also handled are di=
sks
           which require libvirt authentication secrets to open (Pino
           Toscano).

       "guestfs_canonical_device_name"
           This call will no longer incorrectly modify Linux software RAI=
D
           device names (like /dev/mdX).

       "guestfs_file_architecture"
           Previously the "file_architecture" API could return either of =
the
           strings "i386" or "i486" for 32 bit x86 binaries.  It now only
           returns "i386" (as documented).

           This API can now return the following new values: "riscv32",
           "riscv64", "riscv128", "s390", "s390x".

       "guestfs_hivex_open"
           This now has an optional "GUESTFS_HIVEX_OPEN_UNSAFE" flag whic=
h
           allows certain corrupted Windows Registry hives to be opened. =
 This
           feature requires hivex =E2=89=A5 1.3.14 (Dawid Zamirski).

       "guestfs_list_partitions"
           This call now returns Linux software RAID partitions.

       "guestfs_part_to_dev"
           This call now correctly handles partition names which include
           "p<N>" (Pino Toscano).

       "guestfs_set_label"
           This call can now change the labels of swap partitions (Pino
           Toscano).

   Build changes
       libmagic, the library part of the "file" command, is now required =
at
       build time (previously optional).

       GCC 7 is now supported.

       "Silent rules" are now used for OCaml programs, Java bindings.  To=
 show
       the full command line executed, add "V=3D1" on the make command li=
ne
       (Pino Toscano).

       Slow testing ("make check-slow") now covers: firstboot scripts in =
Linux
       guests; v2v conversion of a selection of real Linux guests; the vi=
rt-
       customize --hostname and --timezone settings; the --root-password
       parameter; that the serial console works in virt-builder guests.

       Large generated C source files, eg. the list of commands found in
       fish/cmds.c (and many more), have been split into smaller files to
       speed parallel compilation.

       "make maintainer-check-extra-dist" now checks that all generated f=
iles
       are included in the tarball.

       The tests no longer assume that "." is in Perl's @INC, as it is go=
ing
       to be removed soon (Pino Toscano).

       Debian hosts using UsrMerge are now supported (Pino Toscano).

       Header files and C structs can now have internal documentation usi=
ng
       the special "/** ... */" comments.

       "@VAR@" subtitutions in "./run" are now fully quoted.  This is
       necessary so that (eg) "./configure PYTHON=3D/some/path" works rob=
ustly
       if "/some/path" contains characters that need to be quoted (Hilko
       Bengen).

       gperf =E2=89=A5 3.1 is now supported.

       Kraxel's old edk2 builds can no longer be used for UEFI support.  =
UEFI
       code is now fully free software, so use the versions bundled with =
your
       Linux distro instead.

       Virt-p2v can now be compiled on RHEL 5 (2007-era) Linux with Gtk 2=
.10.

   Internals
       The generator and mllib "Common_utils" modules are now shared from=
 the
       same source file.

       A considerable amount of common code has been moved into the commo=
n
       directory in the source and is now compiled only once.  The mini-
       libraries located under here are: common/edit, common/errnostring,
       common/miniexpect, common/options, common/parallel, common/progres=
s,
       common/protocol, common/utils, common/visit, common/windows.

       The directory containing the main library code has moved from src =
=E2=86=92
       lib.

       All tests written in shell script now use a common file of utility
       functions (tests/test-functions.sh).  There are several new utilit=
y
       functions, mainly for skipping tests.  Also these test scripts can=
 now
       use autoconf-like path variables like $abs_top_srcdir.

       UEFI paths are now stored in the generator (generator/uefi.ml).

       The way the generator handles actions and procedure numbers was ch=
anged
       quite substantially.  See generator/actions_*.ml and
       generator/proc_nr.ml.

       The gnulib "getprogname" module is now used everywhere when
       needing/printing the program name (Pino Toscano).

       perl/Guestfs.c is not translatable (Nikos Skalkotos).

       Virt-builder templates moved from builder/website to builder/templ=
ates
       and there is now a single unified program which can build any temp=
late.

       All Windows registry utilities used by virt-customize and virt-v2v=
 have
       been moved to a common module called "Registry" under mllib.

       All POSIX bindings have been moved to a new module called "Unix_ut=
ils"
       under mllib.

       Inspection, virt-customize and virt-v2v no longer recompute the Wi=
ndows
       "%systemroot%", "CurrentControlSet" or paths to the "HKLM\SYSTEM" =
and
       "HKLM\SOFTWARE" hives in multiple places.  Instead these are all
       computed once (during inspection) and passed to the other tools th=
rough
       various "guestfs_inspect_get_windows_*" APIs.

       "/dev/pts" is now available inside the appliance, so any tools we =
run
       which require a pty will now work (Pino Toscano).

       Most OCaml warnings have been fixed.

       There is now a single common function for creating temporary files
       ("guestfs_int_make_temp_path") (Matteo Cafasso).

       The $TERM environment variable is now validated before passing it
       through to the appliance kernel command line.

       Useless USB and memballoon devices are no longer created in the
       appliance (Laine Stump).

       On aarch64 we now use virtio-pci for the appliance.  This is somew=
hat
       faster than virtio-mmio.

       Use of srandom(3) and random(3) has been minimized.  In particular=
,
       temporary filenames are no longer created based on randomness retu=
rned
       by random(3), but /dev/urandom is used instead.

   Bugs fixed
       https://bugzilla.redhat.com/1425306
           typo error in virt-tail man page

       https://bugzilla.redhat.com/1418283
           virt-v2v: appliance runs out of memory running setfiles comman=
d

       https://bugzilla.redhat.com/1417549
           /usr/bin/x86_64-linux-gnu-ld.bfd.real:
           ../common/progress/.libs/libprogress.a(libprogress_la-progress=
.o):
           undefined reference to symbol 'UP@@NCURSES_TINFO_5.0.19991023'

       https://bugzilla.redhat.com/1417444
           *** No rule to make target '../perl/lib/Sys/Guestfs.c', needed=
 by
           'libguestfs.pot'

       https://bugzilla.redhat.com/1416941
           compile of 1.34.3 fails with gperf 3.1

       https://bugzilla.redhat.com/1414682
           guestfs_canonical_device_name incorrectly returns /dev/sd0 for=
 MD
           devices (/dev/md0)

       https://bugzilla.redhat.com/1414510
           guestfs_list_filesystems does not recognize ddf partitions

       https://bugzilla.redhat.com/1409023
           [Debian] ldmtool not installed in the appliance

       https://bugzilla.redhat.com/1404287
           qemu-kvm cannot boot RHEL 7 kernel with TCG, hangs at "Probing=
 EDD
           (edd=3Doff to disable)..."

       https://bugzilla.redhat.com/1404182
           RFE: virt-resize should support a URL as the outdisk

       https://bugzilla.redhat.com/1401474
           Importing VMs from VMware is failing with error "Inspection fi=
eld
           'i_arch' was 'unknown'"

       https://bugzilla.redhat.com/1401320
           RFE: Increate virt-sysprep coverage a bit

       https://bugzilla.redhat.com/1400205
           Add --vdsm-compat=3D1.1 flag for VDSM

       https://bugzilla.redhat.com/1398070
           typo error in man page

       https://bugzilla.redhat.com/1392798
           secrets from libvirt domains are not read

       https://bugzilla.redhat.com/1390876
           "--machine-readable" info should be updated in virt-v2v manual=
 page

       https://bugzilla.redhat.com/1379289
           RFE: virt-p2v should support mnemonic operations

       https://bugzilla.redhat.com/1378022
           There is virt-v2v warning about <listen type=3D'none'> during
           converting a guest which has listen type=3D'none' in XML

       https://bugzilla.redhat.com/1377081
           virt-p2v manual should update the new dialog information

       https://bugzilla.redhat.com/1375157
           virt-v2v: -i ova: Permission denied when using libvirt and run=
ning
           as root

       https://bugzilla.redhat.com/1374651
           Can't install qxl driver for display device in win7 guest afte=
r
           converting to glance by virt-v2v

       https://bugzilla.redhat.com/1374405
           There is HTTP 404 error info when convert guest to glance by
           virt-v2v

       https://bugzilla.redhat.com/1374232
           selinux relabel fails on RHEL 6.2 guests with "libguestfs erro=
r:
           selinux_relabel: : Success"

       https://bugzilla.redhat.com/1372668
           Process status is not normal in windows guest after converted =
from
           kvm to rhev by virt-v2v

       https://bugzilla.redhat.com/1372269
           Builder does not set hostname properly for Debian 8 (Jessie)

       https://bugzilla.redhat.com/1371843
           Improve OVA import compatibility

       https://bugzilla.redhat.com/1370424
           virt-manager coredump when vm with gluster image exists

       https://bugzilla.redhat.com/1367839
           Cannot import VMs from Xen and VMware when using RHEL7.3 host.

       https://bugzilla.redhat.com/1367738
           Missing bash completion scripts for: virt-diff guestunmount vi=
rt-
           copy-in virt-copy-out virt-customize virt-get-kernel
           virt-p2v-make-disk virt-p2v-make-kickstart virt-tar-in virt-ta=
r-out
           virt-v2v-copy-to-local virt-win-reg

       https://bugzilla.redhat.com/1367615
           OVMF file which is built for rhel7.3  can't be used for virt-v=
2v
           uefi conversion

       https://bugzilla.redhat.com/1366456
           Converting rhel7 host installed on RAID:warning: fstrim: fstri=
m:
           /sysroot/: the discard operation is not supported

       https://bugzilla.redhat.com/1366049
           RFE: libvirt backend: support handling disks stored as volume =
name
           in a pool

       https://bugzilla.redhat.com/1365005
           Guest name is incorrect if convert guest from disk image by
           virt-v2v

       https://bugzilla.redhat.com/1362649
           RFE: virt-sysprep does not utilize libguestfs encryption suppo=
rt

       https://bugzilla.redhat.com/1354507
           virt-v2v conversions from vCenter do not consistently obey the
           proxy environment variables

       https://bugzilla.redhat.com/1168144
           warning: fstrim: fstrim: /sysroot/: FITRIM ioctl failed: Opera=
tion
           not supported (ignored) when convert win2003 guest from xen se=
rver

       https://bugzilla.redhat.com/1161019
           RFE: Only install RHEV-APT if virt-v2v -o rhev/-o vdsm option =
is
           used

       https://bugzilla.redhat.com/1152369
           virt-v2v failed to convert RHEL 6.7 UEFI guest: no
           grub1/grub-legacy or grub2 configuration file was found

       https://bugzilla.redhat.com/1141631
           [RFE] virt-v2v should support convert a guest to a dir-pool wi=
th
           using pool's uuid

       https://bugzilla.redhat.com/1134878
           libvirt reports json "backing file" is missing

       https://bugzilla.redhat.com/1019388
           firstboot scripts (virt-builder, virt-sysprep) don't work for
           Debian 6 & 7 guests

       https://bugzilla.redhat.com/737600
           virt-v2v windows xp - machine dies BSOD - processr,sys - worka=
round
           provided


--=20
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rj=
ones
Read my programming and virtualization blog: http://rwmj.wordpress.com
Fedora Windows cross-compiler. Compile Windows programs, test, and
build Windows installers. Over 100 libraries supported.
http://fedoraproject.org/wiki/MinGW
