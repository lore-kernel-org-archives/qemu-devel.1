Received: from eggs.gnu.org ([2001:4830:134:3::10]:34757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eeJxQ-00051k-UO
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 07:15:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eeJxO-0007rs-5Y
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 07:15:12 -0500
Received: from indium.canonical.com ([91.189.90.7]:44196)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eeJxN-0007rR-Sk
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 07:15:10 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eeJxN-0005VG-5w
	for <qemu-devel@nongnu.org>; Wed, 24 Jan 2018 12:15:09 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 29D582E854B
	for <qemu-devel@nongnu.org>; Wed, 24 Jan 2018 12:15:09 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jan 2018 12:00:03 -0000
From: jamiedo2nn <1089496@bugs.launchpad.net>
Reply-To: Bug 1089496 <1089496@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20121212172623.19173.36082.malonedeb@wampee.canonical.com>
Message-Id: <151679520450.4895.12457966211895112121.launchpad@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1089496] Re: qemu doesn't set vnc port correctly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Description changed:

  Qemu Version: 1.1.1
  =

  In the past it was possible to set the port for vnc with:
  -vnc :1
  That would mean the port would be 5901, Starting from 5900 plus the given=
 number. However, it was also possible to set the port directly with a cust=
om given port. Usually i set the port to something like 5801. With qemu-1.1=
.1 (and maybe prior versions too, i usually use spice) that's not possible =
anymore. For example:
  -vnc 192.168.1.1:5804
  Here the 'real' port would be 11704 (that's 5900 + 5804). I'm sure that w=
orked correctly in the past and i'm pretty sure it's easy to fix.
  =

  Would be nice if we can fix that.
  =

  System Info:
  Portage 2.1.11.31 (default/linux/amd64/10.0/no-multilib, gcc-4.5.4, glibc=
-2.15-r3, 3.5.7-gentoo x86_64)
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
- System uname: Linux-3.5.7-gentoo-x86_64-Intel-R-_Xeon-R-_CPU_E5405_@_2.00=
GHz-with-gentoo-2.1
- Timestamp of tree: Wed, 12 Dec 2012 05:15:01 +0000
- ld GNU ld (GNU Binutils) 2.22
- app-shells/bash:          4.2_p37
- dev-lang/python:          2.7.3-r2, 3.2.3
- dev-util/cmake:           2.8.9
- dev-util/pkgconfig:       0.27.1
- sys-apps/baselayout:      2.1-r1
- sys-apps/openrc:          0.11.8
- sys-apps/sandbox:         2.5
- sys-devel/autoconf:       2.68
- sys-devel/automake:       1.11.6
- sys-devel/binutils:       2.22-r1
- sys-devel/gcc:            4.5.4
- sys-devel/gcc-config:     1.7.3
- sys-devel/libtool:        2.4-r1
- sys-devel/make:           3.82-r3
- sys-kernel/linux-headers: 3.6 (virtual/os-headers)
- sys-libs/glibc:           2.15-r3
- Repositories: gentoo x-local x11 sunrise virtualization
- ACCEPT_KEYWORDS=3D"amd64"
- ACCEPT_LICENSE=3D"* -@EULA"
- CBUILD=3D"x86_64-pc-linux-gnu"
- CFLAGS=3D"-O2 -pipe -march=3Dnative -fopenmp"
- CHOST=3D"x86_64-pc-linux-gnu"
- CONFIG_PROTECT=3D"/etc /usr/share/openvpn/easy-rsa"
- CONFIG_PROTECT_MASK=3D"/etc/ca-certificates.conf /etc/env.d /etc/fonts/fo=
nts.conf /etc/gconf /etc/gentoo-release /etc/revdep-rebuild /etc/sandbox.d =
/etc/terminfo"
- CXXFLAGS=3D"-O2 -pipe -march=3Dnative -fopenmp"
- DISTDIR=3D"/usr/portage/distfiles"
- FCFLAGS=3D"-O2 -pipe"
- FEATURES=3D"assume-digests binpkg-logs config-protect-if-modified distloc=
ks ebuild-locks fixlafiles merge-sync news parallel-fetch protect-owned san=
dbox sfperms strict unknown-features-warn unmerge-logs unmerge-orphans user=
fetch"
- FFLAGS=3D"-O2 -pipe"
- GENTOO_MIRRORS=3D"        http://gentoo.supp.name/                       =
         http://ftp.fi.muni.cz/pub/linux/gentoo/                         ht=
tp://gentoo.mirror.web4u.cz/                          http://gentoo.mirror.=
dkm.cz/pub/gentoo/                         http://gentoo.ynet.sk/pub"
- LANG=3D"de_DE.utf8"
- LDFLAGS=3D"-Wl,-O1 -Wl,--as-needed -fopenmp"
- MAKEOPTS=3D"-j12"
- PKGDIR=3D"/usr/portage/packages"
- PORTAGE_CONFIGROOT=3D"/"
- PORTAGE_RSYNC_OPTS=3D"--recursive --links --safe-links --perms --times --=
compress --force --whole-file --delete --stats --human-readable --timeout=
=3D180 --exclude=3D/distfiles --exclude=3D/local --exclude=3D/packages"
- PORTAGE_TMPDIR=3D"/var/tmp"
- PORTDIR=3D"/usr/portage"
- PORTDIR_OVERLAY=3D"/mnt/data/public/overlays/local /mnt/data/public/overl=
ays/layman/x11 /mnt/data/public/overlays/layman/sunrise /mnt/data/public/ov=
erlays/layman/virtualization"
- SYNC=3D"rsync://rsync.europe.gentoo.org/gentoo-portage/"
- USE=3D"acl acpi amd64 berkdb bzip2 cli cracklib crypt cups cxx dbus dri f=
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
" PHP_TARGETS=3D"php5-3" PYTHON_SINGLE_TARGET=3D"python2_7" PYTHON_TARGETS=
=3D"python2_7 python3_2" QEMU_SOFTMMU_TARGETS=3D"i386 x86_64 mips arm ppc p=
pc64" QEMU_USER_TARGETS=3D"i386 x86_64 mips arm ppc ppc64" RUBY_TARGETS=3D"=
ruby18 ruby19" SANE_BACKENDS=3D"niash" USERLAND=3D"GNU" VIDEO_CARDS=3D"fbde=
v glint intel mach64 mga nouveau nv r128 radeon savage sis tdfx trident ves=
a via vmware dummy v4l" XTABLES_ADDONS=3D"quota2 psd pknock lscan length2 i=
pv4options ipset ipp2p iface geoip fuzzy condition tee tarpit sysrq steal r=
awnat logmark ipmark dhcpmac delude chaos account"
- Unset:  CPPFLAGS, CTARGET, EMERGE_DEFAULT_OPTS, INSTALL_MASK, LC_ALL, POR=
TAGE_BUNZIP2_COMMAND, PORTAGE_COMPRESS, PORTAGE_COMPRESS_FLAGS, PORTAGE_RSY=
NC_EXTRA_OPTS, USE_PYTHON
+ 8f5b300da8f952f8bbdd956b7d782c5cdb61dd06fd45f7755b8cfea51937a1f8

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1089496

Title:
  qemu doesn't set vnc port correctly

Status in QEMU:
  Invalid

Bug description:
  Qemu Version: 1.1.1

  In the past it was possible to set the port for vnc with:
  -vnc :1
  That would mean the port would be 5901, Starting from 5900 plus the given=
 number. However, it was also possible to set the port directly with a cust=
om given port. Usually i set the port to something like 5801. With qemu-1.1=
.1 (and maybe prior versions too, i usually use spice) that's not possible =
anymore. For example:
  -vnc 192.168.1.1:5804
  Here the 'real' port would be 11704 (that's 5900 + 5804). I'm sure that w=
orked correctly in the past and i'm pretty sure it's easy to fix.

  Would be nice if we can fix that.

  System Info:
  Portage 2.1.11.31 (default/linux/amd64/10.0/no-multilib, gcc-4.5.4, glibc=
-2.15-r3, 3.5.7-gentoo x86_64)
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  8f5b300da8f952f8bbdd956b7d782c5cdb61dd06fd45f7755b8cfea51937a1f8

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1089496/+subscriptions
