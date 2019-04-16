Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7A2C10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 16:20:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6F0620868
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 16:20:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6F0620868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39309 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGQoV-0003mu-Si
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 12:20:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hGPjc-0002e6-W0
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 11:10:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hGPjW-00007U-U4
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 11:10:55 -0400
Received: from indium.canonical.com ([91.189.90.7]:60392)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hGPjU-0008Uc-8b
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 11:10:50 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hGPjS-0005Qi-Gv
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 15:10:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 7BBFE2E80C7
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 15:10:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Apr 2019 14:59:18 -0000
From: Daniel Santos <daniel.santos@pobox.com>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: daniel-santos
X-Launchpad-Bug-Reporter: Daniel Santos (daniel-santos)
X-Launchpad-Bug-Modifier: Daniel Santos (daniel-santos)
Message-Id:
 <155542675846.7866.6509809085972568558.malonedeb@wampee.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18920";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 26c4eb0a9746e73574ea7688c5b9208bcff12535
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
X-Mailman-Approved-At: Tue, 16 Apr 2019 12:18:39 -0400
Subject: [Qemu-devel] [Bug 1825002] [NEW] "qemu: Unexpected FPU mode" since
 0c1bbedc10e86ea9366b6af8c5520fafa3266b2f
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1825002 <1825002@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190416145918.Tik3pfhQXSA2jJ18SsbGUNlhE9JvuYF6Ndm5hV5DMsI@z>

Public bug reported:

This happens every time I attempt to chroot into a gentoo-mips image
unless I load the executable via ld.so

/home (root)# chroot gentoo-mips32r2el /bin/sh
qemu: Unexpected FPU mode
/home (root)# chroot gentoo-mips32r2el /lib/ld-2.19.so /bin/sh
sh-4.2# exit
/home (root)# =


I don't know the underlying cause, but keep in mind that we may lie and
claim to have an FPU when our CPU doesn't because of kernel emulation
that may not be present in the host kernel.  Don't know if that's
related.

I get this with various gentoo-mips stage3 tarballs, but not with
OpenWRT.  (e.g.,
https://gentoo.osuosl.org/experimental/mips/stages/mips32r2el/2014)


# emerge --info app-emulation/qemu
Portage 2.3.51 (python 3.6.5-final-0, default/linux/amd64/17.0/desktop/plas=
ma, gcc-8.2.0, glibc-2.27-r6, 4.14.96-gentoo x86_64)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
                         System Settings
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
System uname: Linux-4.14.96-gentoo-x86_64-AMD_Ryzen_7_2700X_Eight-Core_Proc=
essor-with-gentoo-2.6
KiB Mem:    32890732 total,   3480024 free
KiB Swap:   16777212 total,  10575592 free
Timestamp of repository gentoo: Thu, 11 Apr 2019 06:00:01 +0000
Head commit of repository gentoo: 66eaaa28926103e690db0699466a274a17ab1979
sh bash 4.4_p23-r1
ld GNU ld (Gentoo 2.30 p5) 2.30.0
distcc 3.3.2 x86_64-pc-linux-gnu [disabled]
ccache version 3.3.4 [disabled]
app-shells/bash:          4.4_p23-r1::gentoo
dev-java/java-config:     2.2.0-r4::gentoo
dev-lang/perl:            5.26.2::gentoo
dev-lang/python:          2.7.15::gentoo, 3.6.5::gentoo
dev-util/ccache:          3.3.4-r1::gentoo
dev-util/cmake:           3.9.6::gentoo
dev-util/pkgconfig:       0.29.2::gentoo
sys-apps/baselayout:      2.6-r1::gentoo
sys-apps/openrc:          0.38.3-r1::gentoo
sys-apps/sandbox:         2.13::gentoo
sys-devel/autoconf:       2.13-r1::gentoo, 2.64-r1::gentoo, 2.69-r4::gentoo
sys-devel/automake:       1.11.6-r3::gentoo, 1.13.4-r2::gentoo, 1.15.1-r2::=
gentoo, 1.16.1-r1::gentoo
sys-devel/binutils:       2.30-r4::gentoo
sys-devel/gcc:            4.9.4::gentoo, 5.4.0-r6::gentoo, 6.4.0-r5::gentoo=
, 7.3.0-r6::gentoo, 8.1.0-r3::gentoo, 8.2.0-r6::gentoo, 8.3.0::gentoo
sys-devel/gcc-config:     2.0::gentoo
sys-devel/libtool:        2.4.6-r3::gentoo
sys-devel/make:           4.2.1-r4::gentoo
sys-kernel/linux-headers: 4.14-r1::gentoo (virtual/os-headers)
sys-libs/glibc:           2.27-r6::gentoo
Repositories:

gentoo
    location: /usr/portage
    sync-type: rsync
    sync-uri: rsync://rsync.gentoo.org/gentoo-portage
    priority: -1000
    sync-rsync-verify-jobs: 1
    sync-rsync-extra-opts: =

    sync-rsync-verify-metamanifest: yes
    sync-rsync-verify-max-age: 24

love-local
    location: /usr/local/portage
    masters: gentoo
    priority: 0

chaoslab
    location: /var/lib/layman/chaoslab
    masters: gentoo
    priority: 50

java
    location: /var/lib/layman/java
    masters: gentoo
    priority: 50

steam-overlay
    location: /var/lib/layman/steam-overlay
    masters: gentoo
    priority: 50

zugaina
    location: /var/lib/layman/zugaina
    masters: gentoo
    priority: 50

ACCEPT_KEYWORDS=3D"amd64"
ACCEPT_LICENSE=3D"* -@EULA"
CBUILD=3D"x86_64-pc-linux-gnu"
CFLAGS=3D"-march=3Dnative -O2 -ggdb3 -pipe"
CHOST=3D"x86_64-pc-linux-gnu"
CONFIG_PROTECT=3D"/etc /usr/lib64/libreoffice/program/sofficerc /usr/share/=
config /usr/share/gnupg/qualified.txt"
CONFIG_PROTECT_MASK=3D"/etc/ca-certificates.conf /etc/dconf /etc/env.d /etc=
/fonts/fonts.conf /etc/gconf /etc/gentoo-release /etc/revdep-rebuild /etc/s=
andbox.d /etc/splash /etc/terminfo /etc/texmf/language.dat.d /etc/texmf/lan=
guage.def.d /etc/texmf/updmap.d /etc/texmf/web2c"
CXXFLAGS=3D"-march=3Dnative -O2 -ggdb3 -pipe"
DISTDIR=3D"/mnt/large/distfiles"
EMERGE_DEFAULT_OPTS=3D"-j3 --load-average=3D17.5 --with-bdeps=3Dy --autounm=
ask=3Dn"
ENV_UNSET=3D"DBUS_SESSION_BUS_ADDRESS DISPLAY GOBIN PERL5LIB PERL5OPT PERLP=
REFIX PERL_CORE PERL_MB_OPT PERL_MM_OPT XAUTHORITY XDG_CACHE_HOME XDG_CONFI=
G_HOME XDG_DATA_HOME XDG_RUNTIME_DIR"
FCFLAGS=3D"-O2 -pipe"
FEATURES=3D"assume-digests binpkg-logs buildpkg candy cgroup compress-build=
-logs compressdebug config-protect-if-modified distlocks ebuild-locks fixla=
files installsources ipc-sandbox merge-sync multilib-strict network-sandbox=
 news parallel-fetch preserve-libs protect-owned sandbox sfperms split-elog=
 split-log splitdebug strict strict-keepdir unknown-features-warn unmerge-l=
ogs unmerge-orphans userfetch userpriv usersandbox usersync xattr"
FFLAGS=3D"-O2 -pipe"
GENTOO_MIRRORS=3D"http://gentoo.mirrors.tds.net/gentoo http://gentoo.mirror=
s.easynews.com/linux/gentoo/ http://gentoo.osuosl.org/ http://mirrors.rit.e=
du/gentoo/ http://gentoo.cs.uni.edu/ http://gentoo.osuosl.org/ "
LANG=3D"en_US.utf8"
LDFLAGS=3D"-Wl,-O1 -Wl,--as-needed"
LINGUAS=3D"en en-US en_US"
MAKEOPTS=3D"-j15 --load-average=3D17"
PKGDIR=3D"/mnt/large/packages"
PORTAGE_COMPRESS=3D"pxz"
PORTAGE_COMPRESS_FLAGS=3D"-9e"
PORTAGE_CONFIGROOT=3D"/"
PORTAGE_RSYNC_OPTS=3D"--recursive --links --safe-links --perms --times --om=
it-dir-times --compress --force --whole-file --delete --stats --human-reada=
ble --timeout=3D180 --exclude=3D/distfiles --exclude=3D/local --exclude=3D/=
packages --exclude=3D/.git"
PORTAGE_TMPDIR=3D"/tmp"
USE=3D"X a52 aac aacs acl acpi activities aes aio alsa amd64 amr avx avx2 b=
cache berkdb bluetooth bluray branding bzip2 cairo cdda cddb cdio cdr celt =
cli consolekit crypt cups cxx d3d9 dbus declarative designer device-mapper =
dirac directfb dot dri dts dvd dvdr emboss encode exif f16c fam ffmpeg fftw=
 flac fluidsynth fma3 fontconfig fortran fuse gdbm geolocation gif git glam=
or go gphoto2 gpm gps graphite graphviz gsm gstreamer gtk hardened hddtemp =
highlight iconv icu ipv6 jpeg jpeg2k kde kerberos kipi kwallet lame latex l=
cms ldap libass libcaca libnotify libsamplerate libtirpc lm_sensors lto lvm=
 lz4 lzma lzo mad matroska midi mjpeg mmx mmxext mng mono mp3 mp4 mpeg mtp =
multicall multilib multitarget musepack natspec ncurses netlink networkmana=
ger nfs nls nptl nsplugin ogg openal openexr opengl openh264 openmp openssl=
 opus osmesa pam pango pcap pch pclmul pcre pdf perl pgo phonon plasma play=
list png policykit popcnt postgres postproc ppds pulseaudio python qml qt5 =
rar raw readline samba sasl savedconfig scanner schroedinger sdl seccomp se=
nsors sid smp snappy speex spell spice sqlite sqlite3 squashfs sse sse2 sse=
3 sse4_1 sse4_2 sse4a ssh ssl ssse3 startup-notification static-libs subver=
sion svg syslog systemtap taglib tcpd theora threads tiff timidity tools tr=
emor truetype tty-helpers twolame udev udisks unicode upnp-av upower usb us=
bredir utils v4l vaapi valgrind vcdx vdpau vim-syntax virt-network virtio v=
lc vorbis vpx webdav webp widgets wxwidgets x264 x265 xattr xcb xcomposite =
xen xine xml xspice xv xvid xvmc zeroconf zlib" ABI_X86=3D"64 32" ALSA_CARD=
S=3D"ali5451 als4000 atiixp atiixp-modem bt87x ca0106 cmipci emu10k1x ens13=
70 ens1371 es1938 es1968 fm801 hda-intel intel8x0 intel8x0m maestro3 triden=
t usb-audio via82xx via82xx-modem ymfpci" APACHE2_MODULES=3D"authn_core aut=
hz_core socache_shmcb unixd actions alias auth_basic authn_alias authn_anon=
 authn_dbm authn_default authn_file authz_dbm authz_default authz_groupfile=
 authz_host authz_owner authz_user autoindex cache cgi cgid dav dav_fs dav_=
lock deflate dir disk_cache env expires ext_filter file_cache filter header=
s include info log_config logio mem_cache mime mime_magic negotiation rewri=
te setenvif speling status unique_id userdir usertrack vhost_alias" CALLIGR=
A_FEATURES=3D"karbon sheets words" COLLECTD_PLUGINS=3D"df interface irq loa=
d memory rrdtool swap syslog" CPU_FLAGS_X86=3D"aes avx avx2 f16c fma3 mmx m=
mxext pclmul popcnt sse sse2 sse3 sse4_1 sse4_2 sse4a ssse3" CURL_SSL=3D"op=
enssl" ELIBC=3D"glibc" GPSD_PROTOCOLS=3D"ashtech aivdm earthmate evermore f=
v18 garmin garmintxt gpsclock isync itrax mtk3301 nmea ntrip navcom oceanse=
rver oldstyle oncore rtcm104v2 rtcm104v3 sirf skytraq superstar2 timing tsi=
p tripmate tnt ublox ubx" GRUB_PLATFORMS=3D"efi-64 pc coreboot emu multiboo=
t qemu xen" INPUT_DEVICES=3D"keyboard mouse joystick evdev wacom vmmouse" K=
ERNEL=3D"linux" L10N=3D"en en-US en_US" LCD_DEVICES=3D"bayrad cfontz cfontz=
633 glk hd44780 lb216 lcdm001 mtxorb ncurses text" LIBREOFFICE_EXTENSIONS=
=3D"presenter-console presenter-minimizer" LLVM_TARGETS=3D"AMDGPU ARM BPF N=
VPTX Mips X86" NETBEANS_MODULES=3D"apisupport cnd groovy gsf harness ide id=
entity j2ee java mobility nb php profiler soa visualweb webcommon websvccom=
mon xml" OFFICE_IMPLEMENTATION=3D"libreoffice" PHP_TARGETS=3D"php5-6 php7-1=
" POSTGRES_TARGETS=3D"postgres9_5 postgres10" PYTHON_SINGLE_TARGET=3D"pytho=
n3_6" PYTHON_TARGETS=3D"python2_7 python3_6" QEMU_SOFTMMU_TARGETS=3D"aarch6=
4 arm armeb i386 hppa m68k microblaze microblazeel mips mips64 mips64el mip=
sel mipsn32 mipsn32el ppc ppc64 ppc64abi32 ppc64le s390x sparc sparc32plus =
sparc64 x86_64" QEMU_USER_TARGETS=3D"aarch64 arm armeb i386 hppa m68k micro=
blaze microblazeel mips mips64 mips64el mipsel mipsn32 mipsn32el ppc ppc64 =
ppc64abi32 ppc64le s390x sparc sparc32plus sparc64 x86_64" RUBY_TARGETS=3D"=
ruby24" USERLAND=3D"GNU" VIDEO_CARDS=3D"radeon radeonsi vesa qxl vmware amd=
gpu" XTABLES_ADDONS=3D"quota2 psd pknock lscan length2 ipv4options ipset ip=
p2p iface geoip fuzzy condition tee tarpit sysrq steal rawnat logmark ipmar=
k dhcpmac delude chaos account"
Unset:  CC, CPPFLAGS, CTARGET, CXX, INSTALL_MASK, LC_ALL, PORTAGE_BINHOST, =
PORTAGE_BUNZIP2_COMMAND, PORTAGE_RSYNC_EXTRA_OPTS

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
                        Package Settings
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

app-emulation/qemu-3.1.0-r4::gentoo was built with the following:
USE=3D"aio alsa bzip2 caps curl fdt filecaps gtk jpeg lzo ncurses nfs nls o=
pengl pin-upstream-blobs png pulseaudio python sasl sdl seccomp snappy spic=
e ssh static-user systemtap usb usbredir vde vhost-net virtfs vnc vte xattr=
 xen -accessibility (-capstone) -debug (-glusterfs) -gnutls -infiniband -is=
csi -numa -rbd (-selinux) -smartcard (-static) -tci -test -virgl -xfs" ABI_=
X86=3D"(64)" PYTHON_TARGETS=3D"python2_7 python3_6 -python3_5 (-python3_7)"=
 QEMU_SOFTMMU_TARGETS=3D"aarch64 arm hppa i386 m68k microblaze microblazeel=
 mips mips64 mips64el mipsel ppc ppc64 s390x sparc sparc64 x86_64 -alpha -c=
ris -lm32 -moxie -nios2 -or1k -riscv32 -riscv64 -sh4 -sh4eb -tricore -unico=
re32 -xtensa -xtensaeb" QEMU_USER_TARGETS=3D"aarch64 arm armeb hppa i386 m6=
8k microblaze microblazeel mips mips64 mips64el mipsel mipsn32 mipsn32el pp=
c ppc64 ppc64abi32 ppc64le s390x sparc sparc32plus sparc64 x86_64 -aarch64_=
be -alpha -cris -nios2 -or1k -riscv32 -riscv64 -sh4 -sh4eb -tilegx -xtensa =
-xtensaeb"

>>> Attempting to run pkg_info() for 'app-emulation/qemu-3.1.0-r4'
Using:
  app-emulation/spice-protocol-0.12.14
  sys-firmware/edk2-ovmf-2017_p20180211
    USE=3Dbinary
  sys-firmware/ipxe-1.0.0_p20180211
  sys-firmware/seabios-1.11.0
    USE=3Dbinary
  sys-firmware/sgabios-0.1_pre8-r1

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1825002

Title:
  "qemu: Unexpected FPU mode" since
  0c1bbedc10e86ea9366b6af8c5520fafa3266b2f

Status in QEMU:
  New

Bug description:
  This happens every time I attempt to chroot into a gentoo-mips image
  unless I load the executable via ld.so

  /home (root)# chroot gentoo-mips32r2el /bin/sh
  qemu: Unexpected FPU mode
  /home (root)# chroot gentoo-mips32r2el /lib/ld-2.19.so /bin/sh
  sh-4.2# exit
  /home (root)# =


  I don't know the underlying cause, but keep in mind that we may lie
  and claim to have an FPU when our CPU doesn't because of kernel
  emulation that may not be present in the host kernel.  Don't know if
  that's related.

  I get this with various gentoo-mips stage3 tarballs, but not with
  OpenWRT.  (e.g.,
  https://gentoo.osuosl.org/experimental/mips/stages/mips32r2el/2014)


  # emerge --info app-emulation/qemu
  Portage 2.3.51 (python 3.6.5-final-0, default/linux/amd64/17.0/desktop/pl=
asma, gcc-8.2.0, glibc-2.27-r6, 4.14.96-gentoo x86_64)
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
                           System Settings
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  System uname: Linux-4.14.96-gentoo-x86_64-AMD_Ryzen_7_2700X_Eight-Core_Pr=
ocessor-with-gentoo-2.6
  KiB Mem:    32890732 total,   3480024 free
  KiB Swap:   16777212 total,  10575592 free
  Timestamp of repository gentoo: Thu, 11 Apr 2019 06:00:01 +0000
  Head commit of repository gentoo: 66eaaa28926103e690db0699466a274a17ab1979
  sh bash 4.4_p23-r1
  ld GNU ld (Gentoo 2.30 p5) 2.30.0
  distcc 3.3.2 x86_64-pc-linux-gnu [disabled]
  ccache version 3.3.4 [disabled]
  app-shells/bash:          4.4_p23-r1::gentoo
  dev-java/java-config:     2.2.0-r4::gentoo
  dev-lang/perl:            5.26.2::gentoo
  dev-lang/python:          2.7.15::gentoo, 3.6.5::gentoo
  dev-util/ccache:          3.3.4-r1::gentoo
  dev-util/cmake:           3.9.6::gentoo
  dev-util/pkgconfig:       0.29.2::gentoo
  sys-apps/baselayout:      2.6-r1::gentoo
  sys-apps/openrc:          0.38.3-r1::gentoo
  sys-apps/sandbox:         2.13::gentoo
  sys-devel/autoconf:       2.13-r1::gentoo, 2.64-r1::gentoo, 2.69-r4::gent=
oo
  sys-devel/automake:       1.11.6-r3::gentoo, 1.13.4-r2::gentoo, 1.15.1-r2=
::gentoo, 1.16.1-r1::gentoo
  sys-devel/binutils:       2.30-r4::gentoo
  sys-devel/gcc:            4.9.4::gentoo, 5.4.0-r6::gentoo, 6.4.0-r5::gent=
oo, 7.3.0-r6::gentoo, 8.1.0-r3::gentoo, 8.2.0-r6::gentoo, 8.3.0::gentoo
  sys-devel/gcc-config:     2.0::gentoo
  sys-devel/libtool:        2.4.6-r3::gentoo
  sys-devel/make:           4.2.1-r4::gentoo
  sys-kernel/linux-headers: 4.14-r1::gentoo (virtual/os-headers)
  sys-libs/glibc:           2.27-r6::gentoo
  Repositories:

  gentoo
      location: /usr/portage
      sync-type: rsync
      sync-uri: rsync://rsync.gentoo.org/gentoo-portage
      priority: -1000
      sync-rsync-verify-jobs: 1
      sync-rsync-extra-opts: =

      sync-rsync-verify-metamanifest: yes
      sync-rsync-verify-max-age: 24

  love-local
      location: /usr/local/portage
      masters: gentoo
      priority: 0

  chaoslab
      location: /var/lib/layman/chaoslab
      masters: gentoo
      priority: 50

  java
      location: /var/lib/layman/java
      masters: gentoo
      priority: 50

  steam-overlay
      location: /var/lib/layman/steam-overlay
      masters: gentoo
      priority: 50

  zugaina
      location: /var/lib/layman/zugaina
      masters: gentoo
      priority: 50

  ACCEPT_KEYWORDS=3D"amd64"
  ACCEPT_LICENSE=3D"* -@EULA"
  CBUILD=3D"x86_64-pc-linux-gnu"
  CFLAGS=3D"-march=3Dnative -O2 -ggdb3 -pipe"
  CHOST=3D"x86_64-pc-linux-gnu"
  CONFIG_PROTECT=3D"/etc /usr/lib64/libreoffice/program/sofficerc /usr/shar=
e/config /usr/share/gnupg/qualified.txt"
  CONFIG_PROTECT_MASK=3D"/etc/ca-certificates.conf /etc/dconf /etc/env.d /e=
tc/fonts/fonts.conf /etc/gconf /etc/gentoo-release /etc/revdep-rebuild /etc=
/sandbox.d /etc/splash /etc/terminfo /etc/texmf/language.dat.d /etc/texmf/l=
anguage.def.d /etc/texmf/updmap.d /etc/texmf/web2c"
  CXXFLAGS=3D"-march=3Dnative -O2 -ggdb3 -pipe"
  DISTDIR=3D"/mnt/large/distfiles"
  EMERGE_DEFAULT_OPTS=3D"-j3 --load-average=3D17.5 --with-bdeps=3Dy --autou=
nmask=3Dn"
  ENV_UNSET=3D"DBUS_SESSION_BUS_ADDRESS DISPLAY GOBIN PERL5LIB PERL5OPT PER=
LPREFIX PERL_CORE PERL_MB_OPT PERL_MM_OPT XAUTHORITY XDG_CACHE_HOME XDG_CON=
FIG_HOME XDG_DATA_HOME XDG_RUNTIME_DIR"
  FCFLAGS=3D"-O2 -pipe"
  FEATURES=3D"assume-digests binpkg-logs buildpkg candy cgroup compress-bui=
ld-logs compressdebug config-protect-if-modified distlocks ebuild-locks fix=
lafiles installsources ipc-sandbox merge-sync multilib-strict network-sandb=
ox news parallel-fetch preserve-libs protect-owned sandbox sfperms split-el=
og split-log splitdebug strict strict-keepdir unknown-features-warn unmerge=
-logs unmerge-orphans userfetch userpriv usersandbox usersync xattr"
  FFLAGS=3D"-O2 -pipe"
  GENTOO_MIRRORS=3D"http://gentoo.mirrors.tds.net/gentoo http://gentoo.mirr=
ors.easynews.com/linux/gentoo/ http://gentoo.osuosl.org/ http://mirrors.rit=
.edu/gentoo/ http://gentoo.cs.uni.edu/ http://gentoo.osuosl.org/ "
  LANG=3D"en_US.utf8"
  LDFLAGS=3D"-Wl,-O1 -Wl,--as-needed"
  LINGUAS=3D"en en-US en_US"
  MAKEOPTS=3D"-j15 --load-average=3D17"
  PKGDIR=3D"/mnt/large/packages"
  PORTAGE_COMPRESS=3D"pxz"
  PORTAGE_COMPRESS_FLAGS=3D"-9e"
  PORTAGE_CONFIGROOT=3D"/"
  PORTAGE_RSYNC_OPTS=3D"--recursive --links --safe-links --perms --times --=
omit-dir-times --compress --force --whole-file --delete --stats --human-rea=
dable --timeout=3D180 --exclude=3D/distfiles --exclude=3D/local --exclude=
=3D/packages --exclude=3D/.git"
  PORTAGE_TMPDIR=3D"/tmp"
  USE=3D"X a52 aac aacs acl acpi activities aes aio alsa amd64 amr avx avx2=
 bcache berkdb bluetooth bluray branding bzip2 cairo cdda cddb cdio cdr cel=
t cli consolekit crypt cups cxx d3d9 dbus declarative designer device-mappe=
r dirac directfb dot dri dts dvd dvdr emboss encode exif f16c fam ffmpeg ff=
tw flac fluidsynth fma3 fontconfig fortran fuse gdbm geolocation gif git gl=
amor go gphoto2 gpm gps graphite graphviz gsm gstreamer gtk hardened hddtem=
p highlight iconv icu ipv6 jpeg jpeg2k kde kerberos kipi kwallet lame latex=
 lcms ldap libass libcaca libnotify libsamplerate libtirpc lm_sensors lto l=
vm lz4 lzma lzo mad matroska midi mjpeg mmx mmxext mng mono mp3 mp4 mpeg mt=
p multicall multilib multitarget musepack natspec ncurses netlink networkma=
nager nfs nls nptl nsplugin ogg openal openexr opengl openh264 openmp opens=
sl opus osmesa pam pango pcap pch pclmul pcre pdf perl pgo phonon plasma pl=
aylist png policykit popcnt postgres postproc ppds pulseaudio python qml qt=
5 rar raw readline samba sasl savedconfig scanner schroedinger sdl seccomp =
sensors sid smp snappy speex spell spice sqlite sqlite3 squashfs sse sse2 s=
se3 sse4_1 sse4_2 sse4a ssh ssl ssse3 startup-notification static-libs subv=
ersion svg syslog systemtap taglib tcpd theora threads tiff timidity tools =
tremor truetype tty-helpers twolame udev udisks unicode upnp-av upower usb =
usbredir utils v4l vaapi valgrind vcdx vdpau vim-syntax virt-network virtio=
 vlc vorbis vpx webdav webp widgets wxwidgets x264 x265 xattr xcb xcomposit=
e xen xine xml xspice xv xvid xvmc zeroconf zlib" ABI_X86=3D"64 32" ALSA_CA=
RDS=3D"ali5451 als4000 atiixp atiixp-modem bt87x ca0106 cmipci emu10k1x ens=
1370 ens1371 es1938 es1968 fm801 hda-intel intel8x0 intel8x0m maestro3 trid=
ent usb-audio via82xx via82xx-modem ymfpci" APACHE2_MODULES=3D"authn_core a=
uthz_core socache_shmcb unixd actions alias auth_basic authn_alias authn_an=
on authn_dbm authn_default authn_file authz_dbm authz_default authz_groupfi=
le authz_host authz_owner authz_user autoindex cache cgi cgid dav dav_fs da=
v_lock deflate dir disk_cache env expires ext_filter file_cache filter head=
ers include info log_config logio mem_cache mime mime_magic negotiation rew=
rite setenvif speling status unique_id userdir usertrack vhost_alias" CALLI=
GRA_FEATURES=3D"karbon sheets words" COLLECTD_PLUGINS=3D"df interface irq l=
oad memory rrdtool swap syslog" CPU_FLAGS_X86=3D"aes avx avx2 f16c fma3 mmx=
 mmxext pclmul popcnt sse sse2 sse3 sse4_1 sse4_2 sse4a ssse3" CURL_SSL=3D"=
openssl" ELIBC=3D"glibc" GPSD_PROTOCOLS=3D"ashtech aivdm earthmate evermore=
 fv18 garmin garmintxt gpsclock isync itrax mtk3301 nmea ntrip navcom ocean=
server oldstyle oncore rtcm104v2 rtcm104v3 sirf skytraq superstar2 timing t=
sip tripmate tnt ublox ubx" GRUB_PLATFORMS=3D"efi-64 pc coreboot emu multib=
oot qemu xen" INPUT_DEVICES=3D"keyboard mouse joystick evdev wacom vmmouse"=
 KERNEL=3D"linux" L10N=3D"en en-US en_US" LCD_DEVICES=3D"bayrad cfontz cfon=
tz633 glk hd44780 lb216 lcdm001 mtxorb ncurses text" LIBREOFFICE_EXTENSIONS=
=3D"presenter-console presenter-minimizer" LLVM_TARGETS=3D"AMDGPU ARM BPF N=
VPTX Mips X86" NETBEANS_MODULES=3D"apisupport cnd groovy gsf harness ide id=
entity j2ee java mobility nb php profiler soa visualweb webcommon websvccom=
mon xml" OFFICE_IMPLEMENTATION=3D"libreoffice" PHP_TARGETS=3D"php5-6 php7-1=
" POSTGRES_TARGETS=3D"postgres9_5 postgres10" PYTHON_SINGLE_TARGET=3D"pytho=
n3_6" PYTHON_TARGETS=3D"python2_7 python3_6" QEMU_SOFTMMU_TARGETS=3D"aarch6=
4 arm armeb i386 hppa m68k microblaze microblazeel mips mips64 mips64el mip=
sel mipsn32 mipsn32el ppc ppc64 ppc64abi32 ppc64le s390x sparc sparc32plus =
sparc64 x86_64" QEMU_USER_TARGETS=3D"aarch64 arm armeb i386 hppa m68k micro=
blaze microblazeel mips mips64 mips64el mipsel mipsn32 mipsn32el ppc ppc64 =
ppc64abi32 ppc64le s390x sparc sparc32plus sparc64 x86_64" RUBY_TARGETS=3D"=
ruby24" USERLAND=3D"GNU" VIDEO_CARDS=3D"radeon radeonsi vesa qxl vmware amd=
gpu" XTABLES_ADDONS=3D"quota2 psd pknock lscan length2 ipv4options ipset ip=
p2p iface geoip fuzzy condition tee tarpit sysrq steal rawnat logmark ipmar=
k dhcpmac delude chaos account"
  Unset:  CC, CPPFLAGS, CTARGET, CXX, INSTALL_MASK, LC_ALL, PORTAGE_BINHOST=
, PORTAGE_BUNZIP2_COMMAND, PORTAGE_RSYNC_EXTRA_OPTS

  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
                          Package Settings
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

  app-emulation/qemu-3.1.0-r4::gentoo was built with the following:
  USE=3D"aio alsa bzip2 caps curl fdt filecaps gtk jpeg lzo ncurses nfs nls=
 opengl pin-upstream-blobs png pulseaudio python sasl sdl seccomp snappy sp=
ice ssh static-user systemtap usb usbredir vde vhost-net virtfs vnc vte xat=
tr xen -accessibility (-capstone) -debug (-glusterfs) -gnutls -infiniband -=
iscsi -numa -rbd (-selinux) -smartcard (-static) -tci -test -virgl -xfs" AB=
I_X86=3D"(64)" PYTHON_TARGETS=3D"python2_7 python3_6 -python3_5 (-python3_7=
)" QEMU_SOFTMMU_TARGETS=3D"aarch64 arm hppa i386 m68k microblaze microblaze=
el mips mips64 mips64el mipsel ppc ppc64 s390x sparc sparc64 x86_64 -alpha =
-cris -lm32 -moxie -nios2 -or1k -riscv32 -riscv64 -sh4 -sh4eb -tricore -uni=
core32 -xtensa -xtensaeb" QEMU_USER_TARGETS=3D"aarch64 arm armeb hppa i386 =
m68k microblaze microblazeel mips mips64 mips64el mipsel mipsn32 mipsn32el =
ppc ppc64 ppc64abi32 ppc64le s390x sparc sparc32plus sparc64 x86_64 -aarch6=
4_be -alpha -cris -nios2 -or1k -riscv32 -riscv64 -sh4 -sh4eb -tilegx -xtens=
a -xtensaeb"

  >>> Attempting to run pkg_info() for 'app-emulation/qemu-3.1.0-r4'
  Using:
    app-emulation/spice-protocol-0.12.14
    sys-firmware/edk2-ovmf-2017_p20180211
      USE=3Dbinary
    sys-firmware/ipxe-1.0.0_p20180211
    sys-firmware/seabios-1.11.0
      USE=3Dbinary
    sys-firmware/sgabios-0.1_pre8-r1

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1825002/+subscriptions

