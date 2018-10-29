Received: from eggs.gnu.org ([2001:4830:134:3::10]:39387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gGvgu-0004pt-NS
	for qemu-devel@nongnu.org; Sun, 28 Oct 2018 20:46:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gGvgj-0004Mv-S6
	for qemu-devel@nongnu.org; Sun, 28 Oct 2018 20:45:55 -0400
Received: from indium.canonical.com ([91.189.90.7]:54380)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gGvgY-0004EF-8a
	for qemu-devel@nongnu.org; Sun, 28 Oct 2018 20:45:42 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gGvgR-0005A8-O9
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 00:45:31 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id AA32A2E807C
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 00:45:31 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Oct 2018 00:40:09 -0000
From: Nicholas Vinson <1800401@bugs.launchpad.net>
Reply-To: Bug 1800401 <1800401@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154077313146.29068.467827083588404194.malonedeb@soybean.canonical.com>
Message-Id: <154077360903.20032.7549555467487184710.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1800401] Re: efifb on Linux guest fails to load
 when using VGA passthrough
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The OVMF BIOS used can be downloaded from
https://dev.gentoo.org/~tamiko/distfiles/edk2-ovmf-
2017_p20180211-bin.tar.xz

System information via 'emerge --info' is also provided below.

Portage 2.3.51 (python 3.6.6-final-0, default/linux/amd64/17.1/desktop, gcc=
-8.2.0, glibc-2.27-r6, 4.19.0-gentoo x86_64)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
                         System Settings
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
System uname: Linux-4.19.0-gentoo-x86_64-Intel-R-_Core-TM-_i7-4771_CPU_@_3.=
50GHz-with-gentoo-2.6
KiB Mem:    32634140 total,   6226108 free
KiB Swap:    2097148 total,   2097148 free
Timestamp of repository gentoo: Sun, 28 Oct 2018 09:44:31 +0000
Head commit of repository gentoo: aea18fb934c3bf31707dd73cde11f46aca67da49

Timestamp of repository brother-overlay: Sat, 27 Oct 2018 19:24:00 +0000
Head commit of repository brother-overlay: 6a39a7856547c13d12f40585721b65af=
7f1f6469

Head commit of repository nuntoo:
b7b28a262ea47f1e8d92e36ed1a59bac2f338095

sh bash 4.4_p23
ld GNU ld (Gentoo 2.31.1 p3) 2.31.1
app-shells/bash:          4.4_p23::gentoo
dev-java/java-config:     2.2.0-r4::gentoo
dev-lang/perl:            5.26.2::gentoo
dev-lang/python:          2.7.15::gentoo, 3.6.6::gentoo
dev-util/cmake:           3.12.3::gentoo
dev-util/pkgconfig:       0.29.2::gentoo
sys-apps/baselayout:      2.6-r1::gentoo
sys-apps/openrc:          0.39.1::gentoo
sys-apps/sandbox:         2.13::gentoo
sys-devel/autoconf:       2.13::gentoo, 2.69-r4::gentoo
sys-devel/automake:       1.11.6-r3::gentoo, 1.16.1-r1::gentoo
sys-devel/binutils:       2.31.1-r1::gentoo
sys-devel/gcc:            8.2.0-r4::gentoo
sys-devel/gcc-config:     2.0::gentoo
sys-devel/libtool:        2.4.6-r5::gentoo
sys-devel/make:           4.2.1-r4::gentoo
sys-kernel/linux-headers: 4.19::gentoo (virtual/os-headers)
sys-libs/glibc:           2.27-r6::gentoo
Repositories:

gentoo
    location: /var/db/repos/gentoo
    sync-type: git
    sync-uri: https://github.com/gentoo-mirror/gentoo.git
    priority: -1000

brother-overlay
    location: /var/db/repos/brother-overlay
    sync-type: git
    sync-uri: https://github.com/gentoo-mirror/brother-overlay.git
    masters: gentoo

nuntoo
    location: /var/db/repos/nuntoo
    sync-type: git
    sync-uri: https://github.com/nvinson/nuntoo.git
    masters: gentoo

private
    location: /var/db/repos/private
    masters: gentoo

ACCEPT_KEYWORDS=3D"amd64 ~amd64"
ACCEPT_LICENSE=3D"* -@EULA"
CBUILD=3D"x86_64-pc-linux-gnu"
CFLAGS=3D"-march=3Dnative -O2 -pipe"
CHOST=3D"x86_64-pc-linux-gnu"
CONFIG_PROTECT=3D"/etc /usr/lib64/libreoffice/program/sofficerc /usr/share/=
gnupg/qualified.txt"
CONFIG_PROTECT_MASK=3D"/etc/ca-certificates.conf /etc/dconf /etc/env.d /etc=
/fonts/fonts.conf /etc/gconf /etc/gentoo-release /etc/revdep-rebuild /etc/s=
andbox.d /etc/terminfo /etc/texmf/language.dat.d /etc/texmf/language.def.d =
/etc/texmf/updmap.d /etc/texmf/web2c"
CXXFLAGS=3D"-march=3Dnative -O2 -pipe"
DISTDIR=3D"/var/cache/portage/distfiles"
EMERGE_DEFAULT_OPTS=3D"--jobs=3D8 --load-average=3D8"
ENV_UNSET=3D"DBUS_SESSION_BUS_ADDRESS DISPLAY PERL5LIB PERL5OPT PERLPREFIX =
PERL_CORE PERL_MB_OPT PERL_MM_OPT XAUTHORITY XDG_CACHE_HOME XDG_CONFIG_HOME=
 XDG_DATA_HOME XDG_RUNTIME_DIR"
FCFLAGS=3D"-O2 -pipe"
FEATURES=3D"assume-digests binpkg-logs config-protect-if-modified distlocks=
 ebuild-locks fixlafiles merge-sync multilib-strict news parallel-fetch pre=
serve-libs protect-owned sandbox sfperms strict unknown-features-warn unmer=
ge-logs unmerge-orphans userfetch userpriv usersandbox usersync xattr"
FFLAGS=3D"-O2 -pipe"
GENTOO_MIRRORS=3D"http://distfiles.gentoo.org"
LANG=3D"en_US.utf8"
LDFLAGS=3D"-Wl,-O1 -Wl,--as-needed"
LINGUAS=3D"en_US en"
MAKEOPTS=3D"-j8"
PKGDIR=3D"/usr/portage/packages"
PORTAGE_CONFIGROOT=3D"/"
PORTAGE_RSYNC_OPTS=3D"--recursive --links --safe-links --perms --times --om=
it-dir-times --compress --force --whole-file --delete --stats --human-reada=
ble --timeout=3D180 --exclude=3D/distfiles --exclude=3D/local --exclude=3D/=
packages --exclude=3D/.git"
PORTAGE_TMPDIR=3D"/var/tmp"
USE=3D"X a52 aac acl acpi alsa amd64 berkdb branding bzip2 cairo cdda cdr c=
leartype cli consolekit corefonts crypt cups cxx dbus dri dts dvd dvdr embo=
ss encode exif fam flac fortran gdbm gif glamor gpm gtk iconv ipv6 jpeg lcm=
s ldap libnotify libtirpc mad mng mp3 mp4 mpeg multilib ncurses nls nptl og=
g opengl openmp pam pango pcre pdf png policykit ppds qt5 readline sdl secc=
omp spell ssl startup-notification svg tcpd theora tiff truetype udev udisk=
s unicode upower usb vaapi vorbis vpx wxwidgets x264 xattr xcb xml xv xvid =
zlib" ABI_X86=3D"64" ALSA_CARDS=3D"ali5451 als4000 atiixp atiixp-modem bt87=
x ca0106 cmipci emu10k1x ens1370 ens1371 es1938 es1968 fm801 hda-intel inte=
l8x0 intel8x0m maestro3 trident usb-audio via82xx via82xx-modem ymfpci" APA=
CHE2_MODULES=3D"authn_core authz_core socache_shmcb unixd actions alias aut=
h_basic authn_alias authn_anon authn_dbm authn_default authn_file authz_dbm=
 authz_default authz_groupfile authz_host authz_owner authz_user autoindex =
cache cgi cgid dav dav_fs dav_lock deflate dir disk_cache env expires ext_f=
ilter file_cache filter headers include info log_config logio mem_cache mim=
e mime_magic negotiation rewrite setenvif speling status unique_id userdir =
usertrack vhost_alias" CALLIGRA_FEATURES=3D"karbon plan sheets stage words"=
 COLLECTD_PLUGINS=3D"df interface irq load memory rrdtool swap syslog" CPU_=
FLAGS_X86=3D"aes avx avx2 fma3 mmx mmxext popcnt sse sse2 sse3 sse4 sse4_1 =
sse4_2 ssse3" ELIBC=3D"glibc" GPSD_PROTOCOLS=3D"ashtech aivdm earthmate eve=
rmore fv18 garmin garmintxt gpsclock isync itrax mtk3301 nmea ntrip navcom =
oceanserver oldstyle oncore rtcm104v2 rtcm104v3 sirf skytraq superstar2 tim=
ing tsip tripmate tnt ublox ubx" GRUB_PLATFORMS=3D"efi-64 pc" INPUT_DEVICES=
=3D"evdev" KERNEL=3D"linux" L10N=3D"en-US en" LCD_DEVICES=3D"bayrad cfontz =
cfontz633 glk hd44780 lb216 lcdm001 mtxorb ncurses text" LIBREOFFICE_EXTENS=
IONS=3D"presenter-console presenter-minimizer" OFFICE_IMPLEMENTATION=3D"lib=
reoffice" PHP_TARGETS=3D"php5-6 php7-1" POSTGRES_TARGETS=3D"postgres9_5 pos=
tgres10" PYTHON_SINGLE_TARGET=3D"python3_6" PYTHON_TARGETS=3D"python2_7 pyt=
hon3_6" RUBY_TARGETS=3D"ruby23" USERLAND=3D"GNU" VIDEO_CARDS=3D"intel i965"=
 XTABLES_ADDONS=3D"quota2 psd pknock lscan length2 ipv4options ipset ipp2p =
iface geoip fuzzy condition tee tarpit sysrq steal rawnat logmark ipmark dh=
cpmac delude chaos account"
Unset:  CC, CPPFLAGS, CTARGET, CXX, INSTALL_MASK, LC_ALL, PORTAGE_BINHOST, =
PORTAGE_BUNZIP2_COMMAND, PORTAGE_COMPRESS, PORTAGE_COMPRESS_FLAGS, PORTAGE_=
RSYNC_EXTRA_OPTS

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1800401

Title:
  efifb on Linux guest fails to load when using VGA passthrough

Status in QEMU:
  New

Bug description:
  The EFI framebuffer fails to load when booting a Gentoo guest using
  ovmf + vga_passthrough.  I retested using they system rescue CD and
  saw the same issue, but also noticed that when a second framebuffer
  loads, nouveaufb in my case, the terminal appears.  I have also
  verified that the Gentoo min CD is not hanging at boot as I can type
  'poweroff' after waiting a few minutes and the system responds by
  powering off.  I am unable to reproduce with seabios as I have been
  unable to get vga passthrough to work with that BIOS.

  Steps to Reproduce:
      1. Install qemu and ovmf
      2. Download systemrescuecd-x86-5.3.1.iso
      3. Run qemu using one of the configurations below
      4. Select first boot option in GRUB menu
      5. Wait 30 seconds
      6. Press enter # System rescue is prompting for the keymap between st=
eps 5 and 6
      7. Wait 2 minutes
      8. Observe fb console
      9. Note lack of output until very late in boot process
     10. Check dmesg
     11. Note efifb failed to load (invalid address)
     12. Note nouveaufb started late in boot process =


  Expected Results:
     The EFI FB to load and display output to monitor.  This is the behavio=
r I see when booting the host system via UEFI.

  Actual Results:
     The EFI FB fails to load and display output.  System fails to display =
any output until nouveaufb loads.  When booting using the Gentoo minCD, thi=
s makes the system largely unusable.

  Additional information:

  Tested using Gentoo's app-emulation/qemu-3.0.0 version.  Bug report:
  https://bugs.gentoo.org/669880

  I also tested qemu at git commit
  179f9ac887973c818b2578bd79fa3ed2522657d4.  Configuration log for the
  build will be attached.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1800401/+subscriptions
