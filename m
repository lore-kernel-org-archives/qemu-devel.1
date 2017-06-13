Received: from eggs.gnu.org ([2001:4830:134:3::10]:41934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dKqO6-00049E-42
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 14:18:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dKqO1-0002r2-KQ
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 14:17:58 -0400
Received: from indium.canonical.com ([91.189.90.7]:57867)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dKqO1-0002pg-BX
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 14:17:53 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dKqO0-0003wN-0a
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 18:17:52 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id CB8EF2E81AB
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 18:17:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Jun 2017 18:04:57 -0000
From: Thomas Huth <1067517@bugs.launchpad.net>
Reply-To: Bug 1067517 <1067517@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20121016210525.14788.5580.malonedeb@gac.canonical.com>
Message-Id: <149737709692.28243.12533788438050030835.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1067517] Re: qemu dosn't save snapshots with the
 'commit' command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Triaging old bug tickets ... Can you still reproduce this problem with
the latest version of QEMU (currently version 2.9.0)?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1067517

Title:
  qemu dosn't save snapshots with the 'commit' command

Status in QEMU:
  Incomplete

Bug description:
  Usually there is the 'commit' command in qemu which is described as follo=
wed: "commit changes to the disk images (if -snapshot is used) or backing f=
iles"
  From the context i though if i start a guest with the "-snapshot" option,=
 the commit command would save all the changes back to the file. I've tried=
 it out but i didn't get it to work. I tried a few things like first use sa=
vevm or stop and than commit all, but actually nothing works.
  Interestingly, when using qcow2 files qemu doesn't show's any error at al=
l. The changes in the guest just won't get saved. But if i'm using lvm2 par=
titions i would get I/O errors after execute 'commit all'. That's probably =
because lvm2 doesn't support this feature.?!? However i made a attachment w=
hich shows the error's in the guest (dmesg).

  Right now i started the guest with following command:
  /usr/bin/qemu-system-x86_64 -name g64 -runas kvm -m 4096 -smp 2 \
  -monitor unix:/var/run/kvm/g64.sock,server,nowait -pidfile /var/run/kvm/g=
64.pid -daemonize -snapshot \
  -device virtio-serial -chardev spicevmc,id=3Dvdagent,name=3Dvdagent \
  -device virtserialport,chardev=3Dvdagent,name=3Dcom.redhat.spice.0 \
  -drive file=3D/media/btrfs/g64.qcow2,if=3Dvirtio,cache=3Dnone,aio=3Dthrea=
ds \
  -netdev type=3Dtap,id=3Dg64_3,vhost=3Don,ifname=3Dqtap3,script=3Dno,downs=
cript=3Dno \
  -device virtio-net-pci,netdev=3Dg64_3,mac=3DDE:AD:BE:EF:CB:22 \
  -spice port=3D5803,addr=3D192.168.2.60,password=3Dsecret -k de -cpu host \
  -usb -usbdevice tablet -vga qxl

  The system is stable gentoo:
  Portage 2.1.11.9 (default/linux/amd64/10.0/no-multilib, gcc-4.5.4, glibc-=
2.15-r2, 3.4.9-gentoo x86_64)
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
                          System Settings
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  System uname: Linux-3.4.9-gentoo-x86_64-Intel-R-_Xeon-R-_CPU_E5405_@_2.00=
GHz-with-gentoo-2.1
  Timestamp of tree: Tue, 16 Oct 2012 03:45:01 +0000
  app-shells/bash:          4.2_p37
  dev-lang/python:          2.7.3-r2, 3.2.3
  dev-util/cmake:           2.8.8-r3
  dev-util/pkgconfig:       0.27.1
  sys-apps/baselayout:      2.1-r1
  sys-apps/openrc:          0.9.8.4
  sys-apps/sandbox:         2.5
  sys-devel/autoconf:       2.68
  sys-devel/automake:       1.11.6
  sys-devel/binutils:       2.22-r1
  sys-devel/gcc:            4.5.4
  sys-devel/gcc-config:     1.7.3
  sys-devel/libtool:        2.4-r1
  sys-devel/make:           3.82-r3
  sys-kernel/linux-headers: 3.4-r2 (virtual/os-headers)
  sys-libs/glibc:           2.15-r2
  Repositories: gentoo x-local x11 sunrise virtualization
  ACCEPT_KEYWORDS=3D"amd64"
  ACCEPT_LICENSE=3D"* -@EULA"
  CBUILD=3D"x86_64-pc-linux-gnu"
  CFLAGS=3D"-O2 -pipe -march=3Dnative -fopenmp"
  CHOST=3D"x86_64-pc-linux-gnu"
  CONFIG_PROTECT=3D"/etc /usr/share/openvpn/easy-rsa"
  CONFIG_PROTECT_MASK=3D"/etc/ca-certificates.conf /etc/env.d /etc/fonts/fo=
nts.conf /etc/gconf /etc/gentoo-release /etc/revdep-rebuild /etc/sandbox.d =
/etc/terminfo"
  CXXFLAGS=3D"-O2 -pipe -march=3Dnative -fopenmp"
  DISTDIR=3D"/usr/portage/distfiles"
  FCFLAGS=3D"-O2 -pipe"
  FEATURES=3D"assume-digests binpkg-logs config-protect-if-modified distloc=
ks ebuild-locks fixlafiles news parallel-fetch parse-eapi-ebuild-head prote=
ct-owned sandbox sfperms strict unknown-features-warn unmerge-logs unmerge-=
orphans userfetch"
  FFLAGS=3D"-O2 -pipe"
  GENTOO_MIRRORS=3D"        http://gentoo.supp.name/                       =
         http://ftp.fi.muni.cz/pub/linux/gentoo/                         ht=
tp://gentoo.mirror.web4u.cz/                          http://gentoo.mirror.=
dkm.cz/pub/gentoo/                         http://gentoo.ynet.sk/pub"
  LANG=3D"de_DE.utf8"
  LDFLAGS=3D"-Wl,-O1 -Wl,--as-needed -fopenmp"
  LINGUAS=3D"en"
  MAKEOPTS=3D"-j12"
  PKGDIR=3D"/usr/portage/packages"
  PORTAGE_CONFIGROOT=3D"/"
  PORTAGE_RSYNC_OPTS=3D"--recursive --links --safe-links --perms --times --=
compress --force --whole-file --delete --stats --human-readable --timeout=
=3D180 --exclude=3D/distfiles --exclude=3D/local --exclude=3D/packages"
  PORTAGE_TMPDIR=3D"/var/tmp"
  PORTDIR=3D"/usr/portage"
  PORTDIR_OVERLAY=3D"/home/clown/public/overlays/local /home/clown/public/o=
verlays/layman/x11 /home/clown/public/overlays/layman/sunrise /home/clown/p=
ublic/overlays/layman/virtualization"
  SYNC=3D"rsync://rsync.europe.gentoo.org/gentoo-portage/"
  USE=3D"acl acpi amd64 berkdb bzip2 cli cracklib crypt cups cxx dbus dri f=
ortran gdbm gif gpm iconv ipv6 mmx modules mudflap ncurses nls nptl openmp =
pam pbm pcre png pppd readline session sqlite sse sse2 ssl ssse3 tcpd threa=
ds unicode zlib" ALSA_CARDS=3D"ali5451 als4000 atiixp atiixp-modem bt87x ca=
0106 cmipci emu10k1x ens1370 ens1371 es1938 es1968 fm801 hda-intel intel8x0=
 intel8x0m maestro3 trident usb-audio via82xx via82xx-modem ymfpci" ALSA_PC=
M_PLUGINS=3D"adpcm alaw asym copy dmix dshare dsnoop empty extplug file hoo=
ks iec958 ioplug ladspa lfloat linear meter mmap_emul mulaw multi null plug=
 rate route share shm softvol" APACHE2_MODULES=3D"authn_core authz_core soc=
ache_shmcb unixd actions alias auth_basic authn_alias authn_anon authn_dbm =
authn_default authn_file authz_dbm authz_default authz_groupfile authz_host=
 authz_owner authz_user autoindex cache cgi cgid dav dav_fs dav_lock deflat=
e dir disk_cache env expires ext_filter file_cache filter headers include i=
nfo log_config logio mem_cache mime mime_magic negotiation rewrite setenvif=
 speling status unique_id userdir usertrack vhost_alias" CALLIGRA_FEATURES=
=3D"kexi words flow plan sheets stage tables krita karbon braindump" CAMERA=
S=3D"ptp2" COLLECTD_PLUGINS=3D"df interface irq load memory rrdtool swap sy=
slog" ELIBC=3D"glibc" GPSD_PROTOCOLS=3D"ashtech aivdm earthmate evermore fv=
18 garmin garmintxt gpsclock itrax mtk3301 nmea ntrip navcom oceanserver ol=
dstyle oncore rtcm104v2 rtcm104v3 sirf superstar2 timing tsip tripmate tnt =
ubx" INPUT_DEVICES=3D"keyboard mouse evdev" KERNEL=3D"linux" LCD_DEVICES=3D=
"bayrad cfontz cfontz633 glk hd44780 lb216 lcdm001 mtxorb ncurses text" LIB=
REOFFICE_EXTENSIONS=3D"presenter-console presenter-minimizer" LINGUAS=3D"en=
" PHP_TARGETS=3D"php5-3" PYTHON_TARGETS=3D"python3_2 python2_7" QEMU_SOFTMM=
U_TARGETS=3D"i386 x86_64" QEMU_USER_TARGETS=3D"i386 x86_64" RUBY_TARGETS=3D=
"ruby18 ruby19" SANE_BACKENDS=3D"niash" USERLAND=3D"GNU" VIDEO_CARDS=3D"fbd=
ev glint intel mach64 mga nouveau nv r128 radeon savage sis tdfx trident ve=
sa via vmware dummy v4l" XTABLES_ADDONS=3D"quota2 psd pknock lscan length2 =
ipv4options ipset ipp2p iface geoip fuzzy condition tee tarpit sysrq steal =
rawnat logmark ipmark dhcpmac delude chaos account"
  Unset:  CPPFLAGS, CTARGET, EMERGE_DEFAULT_OPTS, INSTALL_MASK, LC_ALL, POR=
TAGE_BUNZIP2_COMMAND, PORTAGE_COMPRESS, PORTAGE_COMPRESS_FLAGS, PORTAGE_RSY=
NC_EXTRA_OPTS, USE_PYTHON

  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
                          Package Settings
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

  app-emulation/qemu-1.1.1-r1 was built with the following:
  USE=3D"aio caps curl ncurses sasl spice vde vhost-net -alsa -bluetooth -b=
rltty -debug -doc -fdt -opengl -pulseaudio -python -rbd -sdl -smartcard -st=
atic -tci -tls -usbredir -virtfs -xattr -xen -xfs" QEMU_SOFTMMU_TARGETS=3D"=
i386 x86_64 (-alpha) (-arm) -cris (-m68k) -microblaze -microblazeel (-mips)=
 -mips64 -mips64el -mipsel (-ppc) (-ppc64) -ppcemb -s390x -sh4 -sh4eb (-spa=
rc) -sparc64 -xtensa -xtensaeb" QEMU_USER_TARGETS=3D"i386 x86_64 (-alpha) (=
-arm) -armeb -cris (-m68k) -microblaze -microblazeel (-mips) -mipsel (-ppc)=
 (-ppc64) -ppc64abi32 -s390x -sh4 -sh4eb (-sparc) -sparc32plus -sparc64 -un=
icore32"

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1067517/+subscriptions
