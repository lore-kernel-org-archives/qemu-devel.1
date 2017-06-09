Received: from eggs.gnu.org ([2001:4830:134:3::10]:36825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dJKCR-0006YL-5w
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 09:43:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dJKCG-000243-2a
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 09:43:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39758)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dJKCF-00022Z-FV
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 09:43:28 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6FD024E326
	for <qemu-devel@nongnu.org>; Fri,  9 Jun 2017 13:43:26 +0000 (UTC)
Date: Fri, 9 Jun 2017 21:43:15 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170609134315.GR3628@pxdev.xzpeter.org>
References: <1497013453-13688-1-git-send-email-peterx@redhat.com>
	<149701469324.3165.3148851973975499400@84b42461e25a>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <149701469324.3165.3148851973975499400@84b42461e25a>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/3] VT-d: convert the rest of DPRINTF()s
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, marcel@redhat.com, jasowang@redhat.com, mst@redhat.com

On Fri, Jun 09, 2017 at 06:24:53AM -0700, no-reply@patchew.org wrote:
> Hi,
>=20
> This series failed build test on s390x host. Please find the details be=
low.
>=20
> Subject: [Qemu-devel] [PATCH 0/3] VT-d: convert the rest of DPRINTF()s
> Type: series
> Message-id: 1497013453-13688-1-git-send-email-peterx@redhat.com
>=20
> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> #!/bin/bash
> # Testing script will be invoked under the git checkout with
> # HEAD pointing to a commit that has the patches applied on top of "bas=
e"
> # branch
> set -e
> echo "=3D=3D=3D ENV =3D=3D=3D"
> env
> echo "=3D=3D=3D PACKAGES =3D=3D=3D"
> rpm -qa
> echo "=3D=3D=3D TEST BEGIN =3D=3D=3D"
> CC=3D$HOME/bin/cc
> INSTALL=3D$PWD/install
> BUILD=3D$PWD/build
> echo -n "Using CC: "
> realpath $CC
> mkdir -p $BUILD $INSTALL
> SRC=3D$PWD
> cd $BUILD
> $SRC/configure --cc=3D$CC --prefix=3D$INSTALL
> make -j4
> # XXX: we need reliable clean up
> # make check -j4 V=3D1
> make install
> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>=20
> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> From https://github.com/patchew-project/qemu
>  * [new tag]         patchew/1497013453-13688-1-git-send-email-peterx@r=
edhat.com -> patchew/1497013453-13688-1-git-send-email-peterx@redhat.com
>  - [tag update]      patchew/20170602112158.232757-1-vsementsov@virtuoz=
zo.com -> patchew/20170602112158.232757-1-vsementsov@virtuozzo.com
> Switched to a new branch 'test'
> afa3193 intel_iommu: cleanup vtd_interrupt_remap_msi()
> a0ebf4f intel_iommu: cleanup vtd_iommu_translate()
> 759648f intel_iommu: switching the rest DPRINTF to trace
>=20
> =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
> =3D=3D=3D ENV =3D=3D=3D
> XDG_SESSION_ID=3D89645
> SHELL=3D/bin/sh
> USER=3Dfam
> PATCHEW=3D/home/fam/patchew/patchew-cli -s http://patchew.org --nodebug
> PATH=3D/usr/bin:/bin
> PWD=3D/var/tmp/patchew-tester-tmp-xibqn8r3/src
> LANG=3Den_US.UTF-8
> HOME=3D/home/fam
> SHLVL=3D2
> LOGNAME=3Dfam
> DBUS_SESSION_BUS_ADDRESS=3Dunix:path=3D/run/user/1012/bus
> XDG_RUNTIME_DIR=3D/run/user/1012
> _=3D/usr/bin/env
> =3D=3D=3D PACKAGES =3D=3D=3D
> gpg-pubkey-873529b8-54e386ff
> xz-libs-5.2.2-2.fc24.s390x
> libxshmfence-1.2-3.fc24.s390x
> giflib-4.1.6-15.fc24.s390x
> trousers-lib-0.3.13-6.fc24.s390x
> ncurses-base-6.0-6.20160709.fc25.noarch
> gmp-6.1.1-1.fc25.s390x
> libidn-1.33-1.fc25.s390x
> slang-2.3.0-7.fc25.s390x
> libsemanage-2.5-8.fc25.s390x
> pkgconfig-0.29.1-1.fc25.s390x
> alsa-lib-1.1.1-2.fc25.s390x
> yum-metadata-parser-1.1.4-17.fc25.s390x
> python3-slip-dbus-0.6.4-4.fc25.noarch
> python2-cssselect-0.9.2-1.fc25.noarch
> python-fedora-0.8.0-2.fc25.noarch
> createrepo_c-libs-0.10.0-6.fc25.s390x
> initscripts-9.69-1.fc25.s390x
> wget-1.18-2.fc25.s390x
> dhcp-client-4.3.5-1.fc25.s390x
> parted-3.2-21.fc25.s390x
> flex-2.6.0-3.fc25.s390x
> colord-libs-1.3.4-1.fc25.s390x
> python-osbs-client-0.33-3.fc25.noarch
> perl-Pod-Simple-3.35-1.fc25.noarch
> python2-simplejson-3.10.0-1.fc25.s390x
> brltty-5.4-2.fc25.s390x
> librados2-10.2.4-2.fc25.s390x
> tcp_wrappers-7.6-83.fc25.s390x
> libcephfs_jni1-10.2.4-2.fc25.s390x
> nettle-devel-3.3-1.fc25.s390x
> bzip2-devel-1.0.6-21.fc25.s390x
> libuuid-2.28.2-2.fc25.s390x
> pango-1.40.4-1.fc25.s390x
> python3-dnf-1.1.10-6.fc25.noarch
> cryptsetup-libs-1.7.4-1.fc25.s390x
> texlive-kpathsea-doc-svn41139-33.fc25.1.noarch
> netpbm-10.77.00-3.fc25.s390x
> openssh-7.4p1-4.fc25.s390x
> texlive-kpathsea-bin-svn40473-33.20160520.fc25.1.s390x
> texlive-graphics-svn41015-33.fc25.1.noarch
> texlive-dvipdfmx-def-svn40328-33.fc25.1.noarch
> texlive-mfware-svn40768-33.fc25.1.noarch
> texlive-texlive-scripts-svn41433-33.fc25.1.noarch
> texlive-euro-svn22191.1.1-33.fc25.1.noarch
> texlive-etex-svn37057.0-33.fc25.1.noarch
> texlive-iftex-svn29654.0.2-33.fc25.1.noarch
> texlive-palatino-svn31835.0-33.fc25.1.noarch
> texlive-texlive-docindex-svn41430-33.fc25.1.noarch
> texlive-xunicode-svn30466.0.981-33.fc25.1.noarch
> texlive-koma-script-svn41508-33.fc25.1.noarch
> texlive-pst-grad-svn15878.1.06-33.fc25.1.noarch
> texlive-pst-blur-svn15878.2.0-33.fc25.1.noarch
> texlive-jknapltx-svn19440.0-33.fc25.1.noarch
> netpbm-progs-10.77.00-3.fc25.s390x
> texinfo-6.1-4.fc25.s390x
> openssl-devel-1.0.2k-1.fc25.s390x
> python2-sssdconfig-1.15.2-1.fc25.noarch
> gdk-pixbuf2-2.36.6-1.fc25.s390x
> mesa-libEGL-13.0.4-3.fc25.s390x
> pcre-cpp-8.40-6.fc25.s390x
> pcre-utf16-8.40-6.fc25.s390x
> glusterfs-extra-xlators-3.10.1-1.fc25.s390x
> mesa-libGL-devel-13.0.4-3.fc25.s390x
> nss-devel-3.29.3-1.1.fc25.s390x
> libaio-0.3.110-6.fc24.s390x
> libfontenc-1.1.3-3.fc24.s390x
> lzo-2.08-8.fc24.s390x
> isl-0.14-5.fc24.s390x
> libXau-1.0.8-6.fc24.s390x
> linux-atm-libs-2.5.1-14.fc24.s390x
> libXext-1.3.3-4.fc24.s390x
> libXxf86vm-1.1.4-3.fc24.s390x
> bison-3.0.4-4.fc24.s390x
> perl-srpm-macros-1-20.fc25.noarch
> gawk-4.1.3-8.fc25.s390x
> libwayland-client-1.12.0-1.fc25.s390x
> perl-Exporter-5.72-366.fc25.noarch
> perl-version-0.99.17-1.fc25.s390x
> fftw-libs-double-3.3.5-3.fc25.s390x
> libssh2-1.8.0-1.fc25.s390x
> ModemManager-glib-1.6.4-1.fc25.s390x
> newt-python3-0.52.19-2.fc25.s390x
> python-munch-2.0.4-3.fc25.noarch
> python-bugzilla-1.2.2-4.fc25.noarch
> libedit-3.1-16.20160618cvs.fc25.s390x
> python-pycurl-7.43.0-4.fc25.s390x
> createrepo_c-0.10.0-6.fc25.s390x
> device-mapper-multipath-libs-0.4.9-83.fc25.s390x
> yum-3.4.3-510.fc25.noarch
> dhcp-common-4.3.5-1.fc25.noarch
> dracut-config-rescue-044-78.fc25.s390x
> teamd-1.26-1.fc25.s390x
> mozjs17-17.0.0-16.fc25.s390x
> libselinux-2.5-13.fc25.s390x
> libgo-devel-6.3.1-1.fc25.s390x
> NetworkManager-libnm-1.4.4-3.fc25.s390x
> python2-pyparsing-2.1.10-1.fc25.noarch
> cairo-gobject-1.14.8-1.fc25.s390x
> ethtool-4.8-1.fc25.s390x
> xorg-x11-proto-devel-7.7-20.fc25.noarch
> brlapi-0.6.5-2.fc25.s390x
> librados-devel-10.2.4-2.fc25.s390x
> libXinerama-devel-1.1.3-6.fc24.s390x
> quota-4.03-7.fc25.s390x
> lua-posix-33.3.1-3.fc25.s390x
> usbredir-devel-0.7.1-2.fc24.s390x
> python-libs-2.7.13-1.fc25.s390x
> libX11-devel-1.6.4-4.fc25.s390x
> python-devel-2.7.13-1.fc25.s390x
> libepoxy-1.4.1-1.fc25.s390x
> freetype-devel-2.6.5-3.fc25.s390x
> python3-dnf-plugins-core-0.1.21-5.fc25.noarch
> perl-macros-5.24.1-385.fc25.s390x
> texlive-pdftex-doc-svn41149-33.fc25.1.noarch
> mariadb-config-10.1.21-3.fc25.s390x
> openssh-clients-7.4p1-4.fc25.s390x
> iptables-1.6.0-3.fc25.s390x
> texlive-texlive.infra-svn41280-33.fc25.1.noarch
> texlive-graphics-cfg-svn40269-33.fc25.1.noarch
> texlive-bibtex-svn40768-33.fc25.1.noarch
> texlive-mfware-bin-svn40473-33.20160520.fc25.1.s390x
> texlive-texlive-scripts-bin-svn29741.0-33.20160520.fc25.1.noarch
> texlive-sauerj-svn15878.0-33.fc25.1.noarch
> texlive-enctex-svn34957.0-33.fc25.1.noarch
> texlive-ifetex-svn24853.1.2-33.fc25.1.noarch
> texlive-ntgclass-svn15878.2.1a-33.fc25.1.noarch
> texlive-tex-gyre-math-svn41264-33.fc25.1.noarch
> texlive-bera-svn20031.0-33.fc25.1.noarch
> texlive-ms-svn29849.0-33.fc25.1.noarch
> texlive-pst-fill-svn15878.1.01-33.fc25.1.noarch
> texlive-ctable-svn38672-33.fc25.1.noarch
> texlive-extsizes-svn17263.1.4a-33.fc25.1.noarch
> texlive-collection-latexrecommended-svn35765.0-33.20160520.fc25.1.noarc=
h
> perl-Filter-1.57-1.fc25.s390x
> krb5-workstation-1.14.4-7.fc25.s390x
> python2-rpm-macros-3-12.fc25.noarch
> audit-libs-2.7.4-1.fc25.s390x
> libglvnd-egl-0.2.999-14.20170308git8e6e102.fc25.s390x
> libglvnd-opengl-0.2.999-14.20170308git8e6e102.fc25.s390x
> pcre-devel-8.40-6.fc25.s390x
> gdbm-1.13-1.fc25.s390x
> mesa-libGLES-devel-13.0.4-3.fc25.s390x
> java-1.8.0-openjdk-1.8.0.121-10.b14.fc25.s390x
> gpg-pubkey-efe550f5-5220ba41
> gpg-pubkey-81b46521-55b3ca9a
> filesystem-3.2-37.fc24.s390x
> libffi-3.1-9.fc24.s390x
> keyutils-libs-1.5.9-8.fc24.s390x
> libnfnetlink-1.0.1-8.fc24.s390x
> libtheora-1.1.1-14.fc24.s390x
> xml-common-0.6.3-44.fc24.noarch
> autoconf-2.69-22.fc24.noarch
> libXt-1.1.5-3.fc24.s390x
> kbd-legacy-2.0.3-3.fc24.noarch
> ghostscript-fonts-5.50-35.fc24.noarch
> libXevie-1.0.3-11.fc24.s390x
> libcap-2.25-2.fc25.s390x
> mpfr-3.1.5-1.fc25.s390x
> perl-Carp-1.40-365.fc25.noarch
> libmnl-1.0.4-1.fc25.s390x
> perl-Unicode-EastAsianWidth-1.33-8.fc25.noarch
> libwayland-cursor-1.12.0-1.fc25.s390x
> python-krbV-1.0.90-12.fc25.s390x
> python2-urllib3-1.15.1-3.fc25.noarch
> fipscheck-1.4.1-11.fc25.s390x
> libndp-1.6-1.fc25.s390x
> gnupg2-2.1.13-2.fc25.s390x
> libXfixes-5.0.3-1.fc25.s390x
> adwaita-icon-theme-3.22.0-1.fc25.noarch
> dconf-0.26.0-1.fc25.s390x
> ncurses-devel-6.0-6.20160709.fc25.s390x
> dejagnu-1.6-1.fc25.noarch
> libstdc++-devel-6.3.1-1.fc25.s390x
> python-beautifulsoup4-4.5.3-1.fc25.noarch
> device-mapper-1.02.136-3.fc25.s390x
> subversion-1.9.5-1.fc25.s390x
> libtool-ltdl-2.4.6-13.fc25.s390x
> libevent-2.0.22-1.fc25.s390x
> atk-devel-2.22.0-1.fc25.s390x
> libev-4.24-1.fc25.s390x
> xorg-x11-fonts-Type1-7.5-16.fc24.noarch
> libtasn1-devel-4.10-1.fc25.s390x
> vte291-devel-0.46.1-1.fc25.s390x
> brlapi-devel-0.6.5-2.fc25.s390x
> pulseaudio-libs-10.0-2.fc25.s390x
> libnl3-cli-3.2.29-2.fc25.s390x
> perl-libs-5.24.1-385.fc25.s390x
> glib2-2.50.3-1.fc25.s390x
> python3-firewall-0.4.4.4-1.fc25.noarch
> python2-rpm-4.13.0.1-1.fc25.s390x
> gnutls-3.5.10-1.fc25.s390x
> pango-devel-1.40.4-1.fc25.s390x
> dnf-1.1.10-6.fc25.noarch
> texlive-metafont-bin-svn40987-33.20160520.fc25.1.s390x
> texlive-xkeyval-svn35741.2.7a-33.fc25.1.noarch
> texlive-euler-svn17261.2.5-33.fc25.1.noarch
> texlive-mptopdf-svn41282-33.fc25.1.noarch
> texlive-wasy-svn35831.0-33.fc25.1.noarch
> texlive-avantgar-svn31835.0-33.fc25.1.noarch
> texlive-eurosym-svn17265.1.4_subrfix-33.fc25.1.noarch
> texlive-knuth-lib-svn35820.0-33.fc25.1.noarch
> texlive-parallel-svn15878.0-33.fc25.1.noarch
> texlive-texlive-msg-translations-svn41431-33.fc25.1.noarch
> texlive-latex-svn40218-33.fc25.1.noarch
> texlive-lualatex-math-svn40621-33.fc25.1.noarch
> texlive-auto-pst-pdf-svn23723.0.6-33.fc25.1.noarch
> texlive-powerdot-svn38984-33.fc25.1.noarch
> texlive-wasysym-svn15878.2.0-33.fc25.1.noarch
> ImageMagick-libs-6.9.3.0-6.fc25.s390x
> geoclue2-2.4.5-1.fc25.s390x
> perl-IO-Socket-IP-0.39-1.fc25.noarch
> gdb-7.12.1-47.fc25.s390x
> python2-pyasn1-0.2.3-1.fc25.noarch
> libglvnd-0.2.999-14.20170308git8e6e102.fc25.s390x
> libglvnd-gles-0.2.999-14.20170308git8e6e102.fc25.s390x
> gdk-pixbuf2-devel-2.36.6-1.fc25.s390x
> libidn2-2.0.0-1.fc25.s390x
> system-python-libs-3.5.3-4.fc25.s390x
> GeoIP-1.6.10-1.fc25.s390x
> at-spi2-core-devel-2.22.1-1.fc25.s390x
> gpg-pubkey-34ec9cba-54e38751
> gpg-pubkey-030d5aed-55b577f0
> basesystem-11-2.fc24.noarch
> libmpc-1.0.2-5.fc24.s390x
> libunistring-0.9.4-3.fc24.s390x
> libmodman-2.0.1-12.fc24.s390x
> lsscsi-0.28-3.fc24.s390x
> kbd-misc-2.0.3-3.fc24.noarch
> rpmconf-base-1.0.18-2.fc25.noarch
> libxml2-2.9.3-4.fc25.s390x
> kmod-23-1.fc25.s390x
> newt-0.52.19-2.fc25.s390x
> perl-Text-Unidecode-1.27-3.fc25.noarch
> plymouth-core-libs-0.9.3-0.6.20160620git0e65b86c.fc25.s390x
> which-2.21-1.fc25.s390x
> python3-slip-0.6.4-4.fc25.noarch
> python3-systemd-232-1.fc25.s390x
> python-lockfile-0.11.0-4.fc25.noarch
> python2-requests-2.10.0-4.fc25.noarch
> libarchive-3.2.2-1.fc25.s390x
> libnghttp2-1.13.0-2.fc25.s390x
> python-urlgrabber-3.10.1-9.fc25.noarch
> iputils-20161105-1.fc25.s390x
> rest-0.8.0-1.fc25.s390x
> adwaita-cursor-theme-3.22.0-1.fc25.noarch
> authconfig-6.2.10-14.fc25.s390x
> expat-devel-2.2.0-1.fc25.s390x
> automake-1.15-7.fc25.noarch
> shared-mime-info-1.8-1.fc25.s390x
> pigz-2.3.4-1.fc25.s390x
> device-mapper-libs-1.02.136-3.fc25.s390x
> dnsmasq-2.76-2.fc25.s390x
> fedora-packager-0.6.0.1-1.fc25.noarch
> gcc-c++-6.3.1-1.fc25.s390x
> libwebp-0.5.2-1.fc25.s390x
> boost-system-1.60.0-10.fc25.s390x
> libasyncns-0.8-10.fc24.s390x
> libXau-devel-1.0.8-6.fc24.s390x
> libverto-libev-0.2.6-6.fc24.s390x
> python3-html5lib-0.999-9.fc25.noarch
> ttmkfdir-3.0.9-48.fc24.s390x
> pulseaudio-libs-glib2-10.0-2.fc25.s390x
> wpa_supplicant-2.6-1.fc25.s390x
> texlive-lib-2016-33.20160520.fc25.s390x
> libXi-devel-1.7.9-1.fc25.s390x
> python3-distro-1.0.3-1.fc25.noarch
> rpm-plugin-systemd-inhibit-4.13.0.1-1.fc25.s390x
> gnutls-c++-3.5.10-1.fc25.s390x
> texlive-texlive-common-doc-svn40682-33.fc25.1.noarch
> packagedb-cli-2.14.1-1.fc25.noarch
> rpcbind-0.2.4-5.fc25.s390x
> texlive-metafont-svn40793-33.fc25.1.noarch
> texlive-tools-svn40934-33.fc25.1.noarch
> texlive-enumitem-svn24146.3.5.2-33.fc25.1.noarch
> texlive-mptopdf-bin-svn18674.0-33.20160520.fc25.1.noarch
> texlive-underscore-svn18261.0-33.fc25.1.noarch
> texlive-anysize-svn15878.0-33.fc25.1.noarch
> texlive-euenc-svn19795.0.1h-33.fc25.1.noarch
> texlive-kastrup-svn15878.0-33.fc25.1.noarch
> texlive-paralist-svn39247-33.fc25.1.noarch
> texlive-texlive-en-svn41185-33.fc25.1.noarch
> texlive-tipa-svn29349.1.3-33.fc25.1.noarch
> texlive-currfile-svn40725-33.fc25.1.noarch
> texlive-pst-node-svn40743-33.fc25.1.noarch
> texlive-pst-slpe-svn24391.1.31-33.fc25.1.noarch
> texlive-typehtml-svn17134.0-33.fc25.1.noarch
> SDL2-devel-2.0.5-3.fc25.s390x
> perl-Module-CoreList-5.20170320-1.fc25.noarch
> libcroco-0.6.11-3.fc25.s390x
> publicsuffix-list-dafsa-20170206-1.fc25.noarch
> pcre-8.40-6.fc25.s390x
> cups-libs-2.2.0-8.fc25.s390x
> gtk-update-icon-cache-3.22.11-1.fc25.s390x
> libcurl-7.51.0-6.fc25.s390x
> python3-libs-3.5.3-4.fc25.s390x
> bluez-libs-devel-5.44-1.fc25.s390x
> kernel-4.10.8-200.fc25.s390x
> fontpackages-filesystem-1.44-17.fc24.noarch
> groff-base-1.22.3-8.fc24.s390x
> ilmbase-2.2.0-5.fc24.s390x
> OpenEXR-libs-2.2.0-5.fc24.s390x
> hesiod-3.2.1-6.fc24.s390x
> sysfsutils-2.1.0-19.fc24.s390x
> ocaml-srpm-macros-2-4.fc24.noarch
> mailx-12.5-19.fc24.s390x
> ncurses-libs-6.0-6.20160709.fc25.s390x
> ipset-libs-6.29-1.fc25.s390x
> gmp-devel-6.1.1-1.fc25.s390x
> python-pip-8.1.2-2.fc25.noarch
> harfbuzz-1.3.2-1.fc25.s390x
> python2-iniparse-0.4-20.fc25.noarch
> python3-iniparse-0.4-20.fc25.noarch
> python3-kickstart-2.32-1.fc25.noarch
> perl-Net-SSLeay-1.78-1.fc25.s390x
> drpm-0.3.0-3.fc25.s390x
> glib-networking-2.50.0-1.fc25.s390x
> webkitgtk3-2.4.11-3.fc25.s390x
> libXaw-1.0.13-4.fc25.s390x
> xorg-x11-font-utils-7.5-32.fc25.s390x
> hardlink-1.1-1.fc25.s390x
> libcom_err-1.43.3-1.fc25.s390x
> python2-dateutil-2.6.0-1.fc25.noarch
> libXpm-3.5.12-1.fc25.s390x
> python2-smmap-2.0.1-1.fc25.noarch
> poppler-data-0.4.7-6.fc25.noarch
> nspr-devel-4.13.1-1.fc25.s390x
> librbd1-10.2.4-2.fc25.s390x
> libsndfile-1.0.27-1.fc25.s390x
> perl-Digest-MD5-2.55-2.fc25.s390x
> wayland-protocols-devel-1.7-1.fc25.noarch
> libacl-devel-2.2.52-11.fc24.s390x
> texi2html-5.0-4.fc24.noarch
> libxkbcommon-0.7.1-1.fc25.s390x
> freetype-2.6.5-3.fc25.s390x
> libuuid-devel-2.28.2-2.fc25.s390x
> coreutils-common-8.25-16.fc25.s390x
> gdb-headless-7.12.1-47.fc25.s390x
> libcacard-2.5.3-1.fc25.s390x
> perl-threads-shared-1.55-1.fc25.s390x
> python2-rpkg-1.49-2.fc25.noarch
> libwmf-lite-0.2.8.4-50.fc25.s390x
> unbound-libs-1.6.0-6.fc25.s390x
> texlive-tetex-svn41059-33.fc25.1.noarch
> texlive-thumbpdf-svn34621.3.16-33.fc25.1.noarch
> texlive-carlisle-svn18258.0-33.fc25.1.noarch
> texlive-makeindex-bin-svn40473-33.20160520.fc25.1.s390x
> texlive-pdftex-svn41149-33.fc25.1.noarch
> texlive-csquotes-svn39538-33.fc25.1.noarch
> texlive-courier-svn35058.0-33.fc25.1.noarch
> texlive-helvetic-svn31835.0-33.fc25.1.noarch
> texlive-mfnfss-svn19410.0-33.fc25.1.noarch
> texlive-sepnum-svn20186.2.0-33.fc25.1.noarch
> texlive-utopia-svn15878.0-33.fc25.1.noarch
> texlive-luatexbase-svn38550-33.fc25.1.noarch
> texlive-pst-3d-svn17257.1.10-33.fc25.1.noarch
> texlive-latex-bin-bin-svn14050.0-33.20160520.fc25.1.noarch
> texlive-l3experimental-svn41163-33.fc25.1.noarch
> bind99-libs-9.9.9-4.P6.fc25.s390x
> net-tools-2.0-0.40.20160329git.fc25.s390x
> perl-Pod-Perldoc-3.28-1.fc25.noarch
> openssl-1.0.2k-1.fc25.s390x
> man-pages-4.06-4.fc25.noarch
> libdrm-2.4.77-1.fc25.s390x
> p11-kit-0.23.2-3.fc25.s390x
> glusterfs-cli-3.10.1-1.fc25.s390x
> git-core-2.9.3-3.fc25.s390x
> python3-3.5.3-4.fc25.s390x
> python3-magic-5.29-4.fc25.noarch
> p11-kit-trust-0.23.2-3.fc25.s390x
> gpg-pubkey-95a43f54-5284415a
> dejavu-fonts-common-2.35-3.fc24.noarch
> libSM-1.2.2-4.fc24.s390x
> diffutils-3.3-13.fc24.s390x
> libogg-1.3.2-5.fc24.s390x
> hunspell-en-US-0.20140811.1-5.fc24.noarch
> libdaemon-0.14-10.fc24.s390x
> patch-2.7.5-3.fc24.s390x
> libsysfs-2.1.0-19.fc24.s390x
> procmail-3.22-39.fc24.s390x
> libXdamage-1.1.4-8.fc24.s390x
> libotf-0.9.13-7.fc24.s390x
> urw-fonts-2.4-22.fc24.noarch
> crontabs-1.11-12.20150630git.fc24.noarch
> ppp-2.4.7-9.fc24.s390x
> polkit-0.113-5.fc24.s390x
> cyrus-sasl-2.1.26-26.2.fc24.s390x
> zlib-devel-1.2.8-10.fc24.s390x
> time-1.7-49.fc24.s390x
> gpg-pubkey-fdb19c98-56fd6333
> fedora-release-25-1.noarch
> libcap-ng-0.7.8-1.fc25.s390x
> binutils-2.26.1-1.fc25.s390x
> lcms2-2.8-2.fc25.s390x
> libcomps-0.1.7-5.fc25.s390x
> less-481-6.fc25.s390x
> apr-1.5.2-4.fc25.s390x
> perl-constant-1.33-367.fc25.noarch
> perl-Data-Dumper-2.161-1.fc25.s390x
> ipcalc-0.1.8-1.fc25.s390x
> libteam-1.26-1.fc25.s390x
> gmp-c++-6.1.1-1.fc25.s390x
> fontconfig-2.12.1-1.fc25.s390x
> enchant-1.6.0-14.fc25.s390x
> pyliblzma-0.5.3-16.fc25.s390x
> libsepol-devel-2.5-10.fc25.s390x
> python3-ordered-set-2.0.0-4.fc25.noarch
> python3-rpmconf-1.0.18-2.fc25.noarch
> python-ipaddress-1.0.16-3.fc25.noarch
> python2-kerberos-1.2.5-1.fc25.s390x
> python2-pysocks-1.5.6-5.fc25.noarch
> fipscheck-lib-1.4.1-11.fc25.s390x
> libatomic_ops-7.4.4-1.fc25.s390x
> net-snmp-agent-libs-5.7.3-13.fc25.s390x
> dracut-044-78.fc25.s390x
> python2-pygpgme-0.3-18.fc25.s390x
> libsoup-2.56.0-2.fc25.s390x
> orc-0.4.26-1.fc25.s390x
> yum-utils-1.1.31-511.fc25.noarch
> libXrender-0.9.10-1.fc25.s390x
> libXrandr-1.5.1-1.fc25.s390x
> go-srpm-macros-2-7.fc25.noarch
> gnupg2-smime-2.1.13-2.fc25.s390x
> guile-devel-2.0.13-1.fc25.s390x
> uboot-tools-2016.09.01-2.fc25.s390x
> pykickstart-2.32-1.fc25.noarch
> python-bunch-1.0.1-9.fc25.noarch
> perl-generators-1.10-1.fc25.noarch
> perl-Mozilla-CA-20160104-3.fc25.noarch
> glibc-all-langpacks-2.24-4.fc25.s390x
> bzip2-libs-1.0.6-21.fc25.s390x
> libpng-1.6.27-1.fc25.s390x
> desktop-file-utils-0.23-2.fc25.s390x
> python2-cccolutils-1.4-1.fc25.s390x
> python2-lxml-3.7.2-1.fc25.s390x
> redhat-rpm-config-45-1.fc25.noarch
> elfutils-libs-0.168-1.fc25.s390x
> device-mapper-event-libs-1.02.136-3.fc25.s390x
> lvm2-libs-2.02.167-3.fc25.s390x
> elfutils-0.168-1.fc25.s390x
> python2-gitdb-2.0.0-1.fc25.noarch
> gcc-gfortran-6.3.1-1.fc25.s390x
> libselinux-python-2.5-13.fc25.s390x
> openjpeg2-2.1.2-3.fc25.s390x
> js-jquery-2.2.4-1.fc25.noarch
> boost-thread-1.60.0-10.fc25.s390x
> json-c-0.12-7.fc24.s390x
> librbd-devel-10.2.4-2.fc25.s390x
> libXcursor-devel-1.1.14-6.fc24.s390x
> python3-beautifulsoup4-4.5.3-1.fc25.noarch
> latex2html-2012-7.fc24.noarch
> lksctp-tools-1.0.16-5.fc24.s390x
> vte291-0.46.1-1.fc25.s390x
> libfdt-1.4.2-1.fc25.s390x
> libXft-devel-2.3.2-4.fc24.s390x
> libattr-devel-2.4.47-16.fc24.s390x
> libiscsi-devel-1.15.0-2.fc24.s390x
> gettext-0.19.8.1-3.fc25.s390x
> libjpeg-turbo-devel-1.5.1-0.fc25.s390x
> libX11-1.6.4-4.fc25.s390x
> pulseaudio-libs-devel-10.0-2.fc25.s390x
> ccache-3.3.3-1.fc25.s390x
> systemd-libs-231-14.fc25.s390x
> nss-softokn-freebl-3.29.3-1.0.fc25.s390x
> libepoxy-devel-1.4.1-1.fc25.s390x
> krb5-libs-1.14.4-7.fc25.s390x
> libmount-2.28.2-2.fc25.s390x
> python3-decorator-4.0.11-1.fc25.noarch
> rpm-plugin-selinux-4.13.0.1-1.fc25.s390x
> perl-threads-2.15-1.fc25.s390x
> tzdata-java-2017b-1.fc25.noarch
> python-srpm-macros-3-12.fc25.noarch
> libsmartcols-2.28.2-2.fc25.s390x
> kernel-core-4.10.5-200.fc25.s390x
> kernel-modules-4.10.5-200.fc25.s390x
> texlive-kpathsea-svn41139-33.fc25.1.noarch
> texlive-amsmath-svn41561-33.fc25.1.noarch
> texlive-thumbpdf-bin-svn6898.0-33.20160520.fc25.1.noarch
> texlive-psnfss-svn33946.9.2a-33.fc25.1.noarch
> texlive-subfig-svn15878.1.3-33.fc25.1.noarch
> texlive-fancybox-svn18304.1.4-33.fc25.1.noarch
> texlive-lua-alt-getopt-svn29349.0.7.0-33.fc25.1.noarch
> texlive-natbib-svn20668.8.31b-33.fc25.1.noarch
> texlive-pdftex-bin-svn40987-33.20160520.fc25.1.s390x
> texlive-xdvi-svn40768-33.fc25.1.noarch
> texlive-crop-svn15878.1.5-33.fc25.1.noarch
> texlive-babel-english-svn30264.3.3p-33.fc25.1.noarch
> texlive-cmextra-svn32831.0-33.fc25.1.noarch
> texlive-fancyhdr-svn15878.3.1-33.fc25.1.noarch
> texlive-luatex-svn40963-33.fc25.1.noarch
> texlive-knuth-local-svn38627-33.fc25.1.noarch
> texlive-mflogo-font-svn36898.1.002-33.fc25.1.noarch
> texlive-parskip-svn19963.2.0-33.fc25.1.noarch
> texlive-section-svn20180.0-33.fc25.1.noarch
> texlive-textcase-svn15878.0-33.fc25.1.noarch
> texlive-updmap-map-svn41159-33.fc25.1.noarch
> texlive-attachfile-svn38830-33.fc25.1.noarch
> nss-3.29.3-1.1.fc25.s390x
> glusterfs-client-xlators-3.10.1-1.fc25.s390x
> libglvnd-glx-0.2.999-14.20170308git8e6e102.fc25.s390x
> libtiff-4.0.7-4.fc25.s390x
> dbus-devel-1.11.12-1.fc25.s390x
> java-1.8.0-openjdk-headless-1.8.0.121-10.b14.fc25.s390x
> pcre2-utf16-10.23-5.fc25.s390x
> git-core-doc-2.9.3-3.fc25.s390x
> iproute-4.10.0-1.fc25.s390x
> nfs-utils-2.1.1-3.rc1.fc25.s390x
> libglvnd-core-devel-0.2.999-14.20170308git8e6e102.fc25.s390x
> python-magic-5.29-4.fc25.noarch
> pcre2-devel-10.23-5.fc25.s390x
> p11-kit-devel-0.23.2-3.fc25.s390x
> texlive-luaotfload-svn40902-33.fc25.1.noarch
> texlive-unicode-math-svn38462-33.fc25.1.noarch
> texlive-fancyvrb-svn18492.2.8-33.fc25.1.noarch
> texlive-pst-pdf-bin-svn7838.0-33.20160520.fc25.1.noarch
> texlive-amscls-svn36804.0-33.fc25.1.noarch
> texlive-ltxmisc-svn21927.0-33.fc25.1.noarch
> texlive-breqn-svn38099.0.98d-33.fc25.1.noarch
> texlive-xetex-def-svn40327-33.fc25.1.noarch
> openssh-server-7.4p1-4.fc25.s390x
> sendmail-8.15.2-8.fc25.s390x
> python-firewall-0.4.4.4-1.fc25.noarch
> python3-sssdconfig-1.15.2-1.fc25.noarch
> tzdata-2017b-1.fc25.noarch
> hunspell-1.4.1-2.fc25.s390x
> gpg-pubkey-8e1431d5-53bcbac7
> zlib-1.2.8-10.fc24.s390x
> sed-4.2.2-15.fc24.s390x
> psmisc-22.21-8.fc24.s390x
> gpm-libs-1.20.7-9.fc24.s390x
> zip-3.0-16.fc24.s390x
> hostname-3.15-7.fc24.s390x
> libyubikey-1.13-2.fc24.s390x
> sg3_utils-libs-1.41-3.fc24.s390x
> polkit-pkla-compat-0.1-7.fc24.s390x
> passwd-0.79-8.fc24.s390x
> trousers-0.3.13-6.fc24.s390x
> grubby-8.40-3.fc24.s390x
> rootfiles-8.1-19.fc24.noarch
> nettle-3.3-1.fc25.s390x
> jansson-2.9-1.fc25.s390x
> libksba-1.3.5-1.fc25.s390x
> perl-Text-ParseWords-3.30-365.fc25.noarch
> perl-PathTools-3.63-366.fc25.s390x
> perl-File-Temp-0.23.04-365.fc25.noarch
> fuse-libs-2.9.7-1.fc25.s390x
> perl-Pod-Escapes-1.07-365.fc25.noarch
> perl-Term-ANSIColor-4.05-2.fc25.noarch
> perl-URI-1.71-5.fc25.noarch
> libXfont-1.5.2-1.fc25.s390x
> python-six-1.10.0-3.fc25.noarch
> dbus-glib-0.108-1.fc25.s390x
> gobject-introspection-1.50.0-1.fc25.s390x
> libpwquality-1.3.0-6.fc25.s390x
> python-gobject-base-3.22.0-1.fc25.s390x
> python-html5lib-0.999-9.fc25.noarch
> python3-dbus-1.2.4-2.fc25.s390x
> python3-chardet-2.3.0-1.fc25.noarch
> python3-urllib3-1.15.1-3.fc25.noarch
> python-offtrac-0.1.0-7.fc25.noarch
> python2-cryptography-1.5.3-3.fc25.s390x
> python2-requests-kerberos-0.10.0-2.fc25.noarch
> libserf-1.3.9-1.fc25.s390x
> libdatrie-0.2.9-3.fc25.s390x
> s390utils-base-1.36.0-1.fc25.s390x
> kpartx-0.4.9-83.fc25.s390x
> s390utils-cpuplugd-1.36.0-1.fc25.s390x
> rpmconf-1.0.18-2.fc25.noarch
> s390utils-osasnmpd-1.36.0-1.fc25.s390x
> python-dnf-plugins-extras-common-0.0.12-4.fc25.noarch
> fpc-srpm-macros-1.0-1.fc25.noarch
> libuser-0.62-4.fc25.s390x
> man-db-2.7.5-3.fc25.s390x
> sqlite-3.14.2-1.fc25.s390x
> python-systemd-doc-232-1.fc25.s390x
> libdb-5.3.28-16.fc25.s390x
> lz4-1.7.5-1.fc25.s390x
> tar-1.29-3.fc25.s390x
> emacs-common-25.1-3.fc25.s390x
> unzip-6.0-31.fc25.s390x
> bodhi-client-0.9.12.2-6.fc25.noarch
> glibc-headers-2.24-4.fc25.s390x
> cairo-1.14.8-1.fc25.s390x
> ca-certificates-2017.2.11-1.0.fc25.noarch
> NetworkManager-glib-1.4.4-3.fc25.s390x
> gcc-go-6.3.1-1.fc25.s390x
> cracklib-dicts-2.9.6-4.fc25.s390x
> libselinux-python3-2.5-13.fc25.s390x
> python2-enchant-1.6.8-1.fc25.noarch
> boost-iostreams-1.60.0-10.fc25.s390x
> userspace-rcu-0.9.2-2.fc25.s390x
> libXext-devel-1.3.3-4.fc24.s390x
> libXrandr-devel-1.5.1-1.fc25.s390x
> perl-XML-XPath-1.39-1.fc25.noarch
> python3-lxml-3.7.2-1.fc25.s390x
> vte-profile-0.46.1-1.fc25.s390x
> sqlite-devel-3.14.2-1.fc25.s390x
> libiscsi-1.15.0-2.fc24.s390x
> fontconfig-devel-2.12.1-1.fc25.s390x
> libfdt-devel-1.4.2-1.fc25.s390x
> ceph-devel-compat-10.2.4-2.fc25.s390x
> zlib-static-1.2.8-10.fc24.s390x
> chrpath-0.16-3.fc24.s390x
> python-2.7.13-1.fc25.s390x
> kernel-core-4.9.5-200.fc25.s390x
> info-6.1-4.fc25.s390x
> iptables-libs-1.6.0-3.fc25.s390x
> bind-license-9.10.4-4.P6.fc25.noarch
> lua-5.3.4-1.fc25.s390x
> libfdisk-2.28.2-2.fc25.s390x
> dnf-plugins-core-0.1.21-5.fc25.noarch
> selinux-policy-3.13.1-225.11.fc25.noarch
> perl-Errno-1.25-385.fc25.s390x
> perl-Storable-2.56-368.fc25.s390x
> python2-decorator-4.0.11-1.fc25.noarch
> mariadb-common-10.1.21-3.fc25.s390x
> systemtap-client-3.1-2.fc25.s390x
> libnetfilter_conntrack-1.0.6-2.fc25.s390x
> texlive-texlive.infra-bin-svn40312-33.20160520.fc25.1.s390x
> texlive-ifluatex-svn41346-33.fc25.1.noarch
> texlive-fp-svn15878.0-33.fc25.1.noarch
> texlive-latex-fonts-svn28888.0-33.fc25.1.noarch
> texlive-bibtex-bin-svn40473-33.20160520.fc25.1.s390x
> texlive-glyphlist-svn28576.0-33.fc25.1.noarch
> texlive-marvosym-svn29349.2.2a-33.fc25.1.noarch
> texlive-tex-bin-svn40987-33.20160520.fc25.1.s390x
> texlive-texconfig-svn40768-33.fc25.1.noarch
> texlive-wasy2-ps-svn35830.0-33.fc25.1.noarch
> texlive-psfrag-svn15878.3.04-33.fc25.1.noarch
> texlive-charter-svn15878.0-33.fc25.1.noarch
> texlive-ec-svn25033.1.0-33.fc25.1.noarch
> texlive-lineno-svn21442.4.41-33.fc25.1.noarch
> texlive-hyphen-base-svn41138-33.fc25.1.noarch
> texlive-manfnt-font-svn35799.0-33.fc25.1.noarch
> texlive-ncntrsbk-svn31835.0-33.fc25.1.noarch
> texlive-pst-math-svn34786.0.63-33.fc25.1.noarch
> texlive-symbol-svn31835.0-33.fc25.1.noarch
> texlive-environ-svn33821.0.3-33.fc25.1.noarch
> texlive-algorithms-svn38085.0.1-33.fc25.1.noarch
> glusterfs-libs-3.10.1-1.fc25.s390x
> mesa-libwayland-egl-13.0.4-3.fc25.s390x
> glusterfs-api-3.10.1-1.fc25.s390x
> kernel-core-4.10.8-200.fc25.s390x
> mesa-libwayland-egl-devel-13.0.4-3.fc25.s390x
> nss-tools-3.29.3-1.1.fc25.s390x
> pcre2-10.23-5.fc25.s390x
> perl-Git-2.9.3-3.fc25.noarch
> gssproxy-0.7.0-3.fc25.s390x
> glusterfs-server-3.10.1-1.fc25.s390x
> libglvnd-devel-0.2.999-14.20170308git8e6e102.fc25.s390x
> python3-hawkey-0.6.4-3.fc25.s390x
> vim-enhanced-8.0.514-1.fc25.s390x
> mesa-libgbm-devel-13.0.4-3.fc25.s390x
> texlive-ifplatform-svn21156.0.4-33.fc25.1.noarch
> texlive-eso-pic-svn37925.2.0g-33.fc25.1.noarch
> texlive-xcolor-svn41044-33.fc25.1.noarch
> texlive-pst-eps-svn15878.1.0-33.fc25.1.noarch
> texlive-pst-text-svn15878.1.00-33.fc25.1.noarch
> texlive-rotating-svn16832.2.16b-33.fc25.1.noarch
> texlive-pdfpages-svn40638-33.fc25.1.noarch
> texlive-cm-super-svn15878.0-33.fc25.1.noarch
> texlive-xetex-svn41438-33.fc25.1.noarch
> dnf-yum-1.1.10-6.fc25.noarch
> mariadb-libs-10.1.21-3.fc25.s390x
> rpmlint-1.9-8.fc25.noarch
> systemtap-sdt-devel-3.1-2.fc25.s390x
> libseccomp-devel-2.3.2-1.fc25.s390x
> telnet-0.17-67.fc25.s390x
> gpgme-1.8.0-10.fc25.s390x
> apr-util-1.5.4-3.fc24.s390x
> rsync-3.1.2-2.fc24.s390x
> jbigkit-libs-2.1-5.fc24.s390x
> pixman-0.34.0-2.fc24.s390x
> dwz-0.12-2.fc24.s390x
> expect-5.45-22.fc24.s390x
> libsigsegv-2.10-10.fc24.s390x
> fakeroot-libs-1.20.2-4.fc24.s390x
> m17n-lib-1.7.0-5.fc24.s390x
> libverto-0.2.6-6.fc24.s390x
> libXmu-1.1.2-4.fc24.s390x
> libXcursor-1.1.14-6.fc24.s390x
> python-kitchen-1.2.4-2.fc24.noarch
> polkit-libs-0.113-5.fc24.s390x
> fakeroot-1.20.2-4.fc24.s390x
> blktrace-1.1.0-3.fc24.s390x
> usermode-1.111-8.fc24.s390x
> kbd-2.0.3-3.fc24.s390x
> libaio-devel-0.3.110-6.fc24.s390x
> web-assets-filesystem-5-4.fc24.noarch
> expat-2.2.0-1.fc25.s390x
> libgpg-error-1.24-1.fc25.s390x
> libgcrypt-1.6.6-1.fc25.s390x
> findutils-4.6.0-8.fc25.s390x
> libassuan-2.4.3-1.fc25.s390x
> libusbx-1.0.21-1.fc25.s390x
> libxslt-1.1.28-13.fc25.s390x
> libmetalink-0.1.3-1.fc25.s390x
> perl-File-Path-2.12-365.fc25.noarch
> perl-MIME-Base64-3.15-365.fc25.s390x
> ncurses-6.0-6.20160709.fc25.s390x
> libwayland-server-1.12.0-1.fc25.s390x
> perl-Fedora-VSP-0.001-4.fc25.noarch
> perl-libintl-perl-1.26-1.fc25.s390x
> shadow-utils-4.2.1-11.fc25.s390x
> atk-2.22.0-1.fc25.s390x
> pam-1.3.0-1.fc25.s390x
> harfbuzz-icu-1.3.2-1.fc25.s390x
> libsecret-0.18.5-2.fc25.s390x
> s390utils-iucvterm-1.36.0-1.fc25.s390x
> python3-requests-2.10.0-4.fc25.noarch
> pyusb-1.0.0-2.fc25.noarch
> python-enum34-1.0.4-6.fc25.noarch
> pyOpenSSL-16.0.0-2.fc25.noarch
> pyxattr-0.5.3-8.fc25.s390x
> libbabeltrace-1.4.0-3.fc25.s390x
> libthai-0.1.25-1.fc25.s390x
> deltarpm-3.6-17.fc25.s390x
> s390utils-mon_statd-1.36.0-1.fc25.s390x
> device-mapper-multipath-0.4.9-83.fc25.s390x
> python3-pygpgme-0.3-18.fc25.s390x
> libreport-filesystem-2.8.0-1.fc25.s390x
> ghc-srpm-macros-1.4.2-4.fc25.noarch
> rpmdevtools-8.9-1.fc25.noarch
> python-dnf-plugins-extras-migrate-0.0.12-4.fc25.noarch
> perl-IO-Socket-SSL-2.038-1.fc25.noarch
> perl-File-ShareDir-1.102-7.fc25.noarch
> tcl-8.6.6-1.fc25.s390x
> glibc-2.24-4.fc25.s390x
> elfutils-libelf-0.168-1.fc25.s390x
> perl-Scalar-List-Utils-1.47-1.fc25.s390x
> bzip2-1.0.6-21.fc25.s390x
> libss-1.43.3-1.fc25.s390x
> libselinux-utils-2.5-13.fc25.s390x
> koji-1.11.0-1.fc25.noarch
> python3-enchant-1.6.8-1.fc25.noarch
> python2-dockerfile-parse-0.0.5-7.fc25.noarch
> systemd-bootchart-231-2.fc25.s390x
> gcc-objc-6.3.1-1.fc25.s390x
> e2fsprogs-1.43.3-1.fc25.s390x
> libstdc++-static-6.3.1-1.fc25.s390x
> libpng-devel-1.6.27-1.fc25.s390x
> perl-XML-Parser-2.44-5.fc25.s390x
> lttng-ust-2.8.1-2.fc25.s390x
> libXfixes-devel-5.0.3-1.fc25.s390x
> libXcomposite-devel-0.4.4-8.fc24.s390x
> quota-nls-4.03-7.fc25.noarch
> python3-javapackages-4.7.0-6.1.fc25.noarch
> libcephfs_jni-devel-10.2.4-2.fc25.s390x
> keyutils-libs-devel-1.5.9-8.fc24.s390x
> libicu-devel-57.1-4.fc25.s390x
> harfbuzz-devel-1.3.2-1.fc25.s390x
> libidn-devel-1.33-1.fc25.s390x
> libnfs-1.9.8-2.fc24.s390x
> libssh2-devel-1.8.0-1.fc25.s390x
> qemu-sanity-check-nodeps-1.1.5-5.fc24.s390x
> alsa-lib-devel-1.1.1-2.fc25.s390x
> libnl3-3.2.29-2.fc25.s390x
> kernel-modules-4.9.5-200.fc25.s390x
> libpsl-0.17.0-1.fc25.s390x
> lua-libs-5.3.4-1.fc25.s390x
> libseccomp-2.3.2-1.fc25.s390x
> nss-softokn-freebl-devel-3.29.3-1.0.fc25.s390x
> copy-jdk-configs-2.2-2.fc25.noarch
> json-glib-1.2.6-1.fc25.s390x
> python2-dnf-1.1.10-6.fc25.noarch
> bind-libs-lite-9.10.4-4.P6.fc25.s390x
> perl-IO-1.36-385.fc25.s390x
> python2-GitPython-2.1.3-1.fc25.noarch
> linux-firmware-20170313-72.git695f2d6d.fc25.noarch
> systemd-container-231-14.fc25.s390x
> gnutls-dane-3.5.10-1.fc25.s390x
> texlive-tetex-bin-svn36770.0-33.20160520.fc25.1.noarch
> texlive-amsfonts-svn29208.3.04-33.fc25.1.noarch
> texlive-babel-svn40706-33.fc25.1.noarch
> texlive-colortbl-svn29803.v1.0a-33.fc25.1.noarch
> texlive-babelbib-svn25245.1.31-33.fc25.1.noarch
> texlive-footmisc-svn23330.5.5b-33.fc25.1.noarch
> texlive-makeindex-svn40768-33.fc25.1.noarch
> texlive-plain-svn40274-33.fc25.1.noarch
> texlive-texconfig-bin-svn29741.0-33.20160520.fc25.1.noarch
> texlive-zapfding-svn31835.0-33.fc25.1.noarch
> texlive-microtype-svn41127-33.fc25.1.noarch
> texlive-bookman-svn31835.0-33.fc25.1.noarch
> texlive-dvisvgm-def-svn41011-33.fc25.1.noarch
> texlive-finstrut-svn21719.0.5-33.fc25.1.noarch
> texlive-hyph-utf8-svn41189-33.fc25.1.noarch
> texlive-lualibs-svn40370-33.fc25.1.noarch
> glusterfs-3.10.1-1.fc25.s390x
> mesa-libglapi-13.0.4-3.fc25.s390x
> mesa-libgbm-13.0.4-3.fc25.s390x
> kernel-modules-4.10.8-200.fc25.s390x
> glusterfs-fuse-3.10.1-1.fc25.s390x
> openldap-2.4.44-10.fc25.s390x
> pcre-utf32-8.40-6.fc25.s390x
> git-2.9.3-3.fc25.s390x
> python2-gluster-3.10.1-1.fc25.s390x
> glusterfs-devel-3.10.1-1.fc25.s390x
> mesa-libEGL-devel-13.0.4-3.fc25.s390x
> glusterfs-api-devel-3.10.1-1.fc25.s390x
> sudo-1.8.19p2-1.fc25.s390x
> python2-hawkey-0.6.4-3.fc25.s390x
> texlive-mparhack-svn15878.1.4-33.fc25.1.noarch
> texlive-pspicture-svn15878.0-33.fc25.1.noarch
> texlive-soul-svn15878.2.4-33.fc25.1.noarch
> texlive-trimspaces-svn15878.1.1-33.fc25.1.noarch
> texlive-varwidth-svn24104.0.92-33.fc25.1.noarch
> texlive-geometry-svn19716.5.6-33.fc25.1.noarch
> texlive-memoir-svn41203-33.fc25.1.noarch
> texlive-pgf-svn40966-33.fc25.1.noarch
> texlive-pst-coil-svn37377.1.07-33.fc25.1.noarch
> texlive-pst-plot-svn41242-33.fc25.1.noarch
> texlive-latex-bin-svn41438-33.fc25.1.noarch
> texlive-ucs-svn35853.2.2-33.fc25.1.noarch
> texlive-ae-svn15878.1.4-33.fc25.1.noarch
> texlive-xetex-bin-svn41091-33.20160520.fc25.1.s390x
> fedora-upgrade-26.1-1.fc25.noarch
> fedpkg-1.28-1.fc25.noarch
> perl-Thread-Queue-3.12-1.fc25.noarch
> gstreamer1-plugins-base-1.10.4-1.fc25.s390x
> screen-4.5.1-1.fc25.s390x
> strace-4.16-1.fc25.s390x
> fedora-repos-25-3.noarch
> libacl-2.2.52-11.fc24.s390x
> cdparanoia-libs-10.2-21.fc24.s390x
> ustr-1.0.4-21.fc24.s390x
> libusb-0.1.5-7.fc24.s390x
> readline-devel-6.3-8.fc24.s390x
> chkconfig-1.8-1.fc25.s390x
> avahi-libs-0.6.32-4.fc25.s390x
> perl-Unicode-Normalize-1.25-365.fc25.s390x
> perl-libnet-3.10-1.fc25.noarch
> perl-podlators-4.09-1.fc25.noarch
> graphite2-1.3.6-1.fc25.s390x
> dbus-python-1.2.4-2.fc25.s390x
> libgnome-keyring-3.12.0-7.fc25.s390x
> python-backports-1.0-8.fc25.s390x
> python-pycparser-2.14-7.fc25.noarch
> plymouth-scripts-0.9.3-0.6.20160620git0e65b86c.fc25.s390x
> cronie-1.5.1-2.fc25.s390x
> python2-librepo-1.7.18-3.fc25.s390x
> libXv-1.0.11-1.fc25.s390x
> python2-ndg_httpsclient-0.4.0-4.fc25.noarch
> btrfs-progs-4.6.1-1.fc25.s390x
> libgcc-6.3.1-1.fc25.s390x
> libgomp-6.3.1-1.fc25.s390x
> perl-Encode-2.88-5.fc25.s390x
> cracklib-2.9.6-4.fc25.s390x
> libobjc-6.3.1-1.fc25.s390x
> gcc-6.3.1-1.fc25.s390x
> python3-dnf-plugin-system-upgrade-0.7.1-4.fc25.noarch
> NetworkManager-1.4.4-3.fc25.s390x
> glibc-static-2.24-4.fc25.s390x
> boost-random-1.60.0-10.fc25.s390x
> libref_array-0.1.5-29.fc25.s390x
> libXrender-devel-0.9.10-1.fc25.s390x
> javapackages-tools-4.7.0-6.1.fc25.noarch
> keyutils-1.5.9-8.fc24.s390x
> libcom_err-devel-1.43.3-1.fc25.s390x
> graphite2-devel-1.3.6-1.fc25.s390x
> lzo-minilzo-2.08-8.fc24.s390x
> libusbx-devel-1.0.21-1.fc25.s390x
> virglrenderer-devel-0.5.0-1.20160411git61846f92f.fc25.s390x
> acpica-tools-20160831-1.fc25.s390x
> grep-2.27-2.fc25.s390x
> dnf-conf-1.1.10-6.fc25.noarch
> crypto-policies-20160921-4.gitf3018dd.fc25.noarch
> rpm-build-libs-4.13.0.1-1.fc25.s390x
> libnfsidmap-0.27-1.fc25.s390x
> systemtap-devel-3.1-2.fc25.s390x
> systemd-231-14.fc25.s390x
> SDL2-2.0.5-3.fc25.s390x
> texlive-etex-pkg-svn39355-33.fc25.1.noarch
> texlive-multido-svn18302.1.42-33.fc25.1.noarch
> texlive-gsftopk-svn40768-33.fc25.1.noarch
> texlive-pst-ovl-svn40873-33.fc25.1.noarch
> texlive-ltabptch-svn17533.1.74d-33.fc25.1.noarch
> texlive-cite-svn36428.5.5-33.fc25.1.noarch
> texlive-fpl-svn15878.1.002-33.fc25.1.noarch
> texlive-mathpazo-svn15878.1.003-33.fc25.1.noarch
> texlive-rcs-svn15878.0-33.fc25.1.noarch
> texlive-type1cm-svn21820.0-33.fc25.1.noarch
> texlive-l3kernel-svn41246-33.fc25.1.noarch
> texlive-hyperref-svn41396-33.fc25.1.noarch
> texlive-pst-tree-svn24142.1.12-33.fc25.1.noarch
> texlive-sansmathaccent-svn30187.0-33.fc25.1.noarch
> texlive-dvipdfmx-bin-svn40273-33.20160520.fc25.1.s390x
> texlive-zapfchan-svn31835.0-33.fc25.1.noarch
> firewalld-0.4.4.4-1.fc25.noarch
> glib2-static-2.50.3-1.fc25.s390x
> libmicrohttpd-0.9.52-3.fc25.s390x
> perl-open-1.10-385.fc25.noarch
> bash-completion-2.5-1.fc25.noarch
> libsolv-0.6.26-3.fc25.s390x
> ghostscript-core-9.20-7.fc25.s390x
> nss-util-devel-3.29.3-1.1.fc25.s390x
> kernel-headers-4.10.8-200.fc25.s390x
> system-python-3.5.3-4.fc25.s390x
> iproute-tc-4.10.0-1.fc25.s390x
> audit-2.7.4-1.fc25.s390x
> gpg-pubkey-a29cb19c-53bcbba6
> m4-1.4.17-9.fc24.s390x
> liblockfile-1.09-4.fc24.s390x
> sg3_utils-1.41-3.fc24.s390x
> libXinerama-1.1.3-6.fc24.s390x
> libXft-2.3.2-4.fc24.s390x
> tcp_wrappers-libs-7.6-83.fc25.s390x
> perl-Text-Tabs+Wrap-2013.0523-365.fc25.noarch
> perl-Error-0.17024-7.fc25.noarch
> perl-Term-Cap-1.17-365.fc25.noarch
> perl-Pod-Usage-1.69-1.fc25.noarch
> device-mapper-persistent-data-0.6.3-1.fc25.s390x
> net-snmp-libs-5.7.3-13.fc25.s390x
> libgusb-0.2.9-1.fc25.s390x
> python3-six-1.10.0-3.fc25.noarch
> python3-pysocks-1.5.6-5.fc25.noarch
> python-chardet-2.3.0-1.fc25.noarch
> python2-cffi-1.7.0-2.fc25.s390x
> gc-devel-7.4.4-1.fc25.s390x
> plymouth-0.9.3-0.6.20160620git0e65b86c.fc25.s390x
> ebtables-2.0.10-21.fc25.s390x
> python3-librepo-1.7.18-3.fc25.s390x
> net-snmp-5.7.3-13.fc25.s390x
> at-spi2-atk-2.22.0-1.fc25.s390x
> avahi-autoipd-0.6.32-4.fc25.s390x
> libcrypt-nss-2.24-4.fc25.s390x
> libgo-6.3.1-1.fc25.s390x
> cpp-6.3.1-1.fc25.s390x
> glibc-devel-2.24-4.fc25.s390x
> emacs-25.1-3.fc25.s390x
> pyparsing-2.1.10-1.fc25.noarch
> libproxy-0.4.14-1.fc25.s390x
> python3-pyparsing-2.1.10-1.fc25.noarch
> libcollection-0.7.0-29.fc25.s390x
> libcephfs-devel-10.2.4-2.fc25.s390x
> libXdamage-devel-1.1.4-8.fc24.s390x
> libverto-devel-0.2.6-6.fc24.s390x
> snappy-1.1.3-2.fc24.s390x
> cairo-gobject-devel-1.14.8-1.fc25.s390x
> cyrus-sasl-devel-2.1.26-26.2.fc24.s390x
> kernel-devel-4.9.5-200.fc25.s390x
> libXi-1.7.9-1.fc25.s390x
> distribution-gpg-keys-1.11-1.fc25.noarch
> texlive-base-2016-33.20160520.fc25.noarch
> gstreamer1-1.10.4-1.fc25.s390x
> python3-rpm-4.13.0.1-1.fc25.s390x
> systemtap-runtime-3.1-2.fc25.s390x
> perl-SelfLoader-1.23-385.fc25.noarch
> bind99-license-9.9.9-4.P6.fc25.noarch
> texlive-booktabs-svn40846-33.fc25.1.noarch
> texlive-lm-svn28119.2.004-33.fc25.1.noarch
> texlive-gsftopk-bin-svn40473-33.20160520.fc25.1.s390x
> texlive-tex-svn40793-33.fc25.1.noarch
> texlive-fancyref-svn15878.0.9c-33.fc25.1.noarch
> texlive-chngcntr-svn17157.1.0a-33.fc25.1.noarch
> texlive-fix2col-svn38770-33.fc25.1.noarch
> texlive-marginnote-svn41382-33.fc25.1.noarch
> texlive-pxfonts-svn15878.0-33.fc25.1.noarch
> texlive-txfonts-svn15878.0-33.fc25.1.noarch
> texlive-l3packages-svn41246-33.fc25.1.noarch
> texlive-oberdiek-svn41346-33.fc25.1.noarch
> texlive-pst-tools-svn34067.0.05-33.fc25.1.noarch
> texlive-tex-gyre-svn18651.2.004-33.fc25.1.noarch
> texlive-dvipdfmx-svn41149-33.fc25.1.noarch
> texlive-collection-fontsrecommended-svn35830.0-33.20160520.fc25.1.noarc=
h
> gnutls-devel-3.5.10-1.fc25.s390x
> libcacard-devel-2.5.3-1.fc25.s390x
> selinux-policy-targeted-3.13.1-225.11.fc25.noarch
> ykpers-1.18.0-2.fc25.s390x
> python2-idna-2.5-1.fc25.noarch
> dbus-libs-1.11.12-1.fc25.s390x
> ghostscript-x11-9.20-7.fc25.s390x
> vim-minimal-8.0.514-1.fc25.s390x
> libdrm-devel-2.4.77-1.fc25.s390x
> file-libs-5.29-4.fc25.s390x
> gtk3-devel-3.22.11-1.fc25.s390x
> policycoreutils-2.5-20.fc25.s390x
> python-async-0.6.1-9.fc22.s390x
> dejavu-sans-mono-fonts-2.35-3.fc24.noarch
> popt-1.16-7.fc24.s390x
> cyrus-sasl-lib-2.1.26-26.2.fc24.s390x
> xz-5.2.2-2.fc24.s390x
> libpipeline-1.4.1-2.fc24.s390x
> pinentry-0.9.7-2.fc24.s390x
> pth-2.0.7-27.fc24.s390x
> libsepol-2.5-10.fc25.s390x
> sqlite-libs-3.14.2-1.fc25.s390x
> libxcb-1.12-1.fc25.s390x
> libicu-57.1-4.fc25.s390x
> perl-Getopt-Long-2.49.1-1.fc25.noarch
> avahi-glib-0.6.32-4.fc25.s390x
> python3-pip-8.1.2-2.fc25.noarch
> python3-libcomps-0.1.7-5.fc25.s390x
> python-slip-0.6.4-4.fc25.noarch
> python2-libcomps-0.1.7-5.fc25.s390x
> gc-7.4.4-1.fc25.s390x
> s390utils-cmsfs-1.36.0-1.fc25.s390x
> newt-python-0.52.19-2.fc25.s390x
> valgrind-3.12.0-1.fc25.s390x
> emacs-filesystem-25.1-3.fc25.noarch
> libdb-utils-5.3.28-16.fc25.s390x
> qt5-srpm-macros-5.7.1-1.fc25.noarch
> elfutils-default-yama-scope-0.168-1.fc25.noarch
> device-mapper-event-1.02.136-3.fc25.s390x
> perl-Class-Inspector-1.31-2.fc25.noarch
> poppler-0.45.0-2.fc25.s390x
> libbasicobjects-0.1.1-29.fc25.s390x
> libradosstriper1-10.2.4-2.fc25.s390x
> libXxf86vm-devel-1.1.4-3.fc24.s390x
> gsm-1.0.16-1.fc25.s390x
> zziplib-0.13.62-7.fc24.s390x
> libpaper-1.1.24-12.fc24.s390x
> libini_config-1.3.0-29.fc25.s390x
> snappy-devel-1.1.3-2.fc24.s390x
> libcap-ng-devel-0.7.8-1.fc25.s390x
> libxkbcommon-devel-0.7.1-1.fc25.s390x
> kernel-4.9.5-200.fc25.s390x
> nss-softokn-3.29.3-1.0.fc25.s390x
> openssl-libs-1.0.2k-1.fc25.s390x
> libkadm5-1.14.4-7.fc25.s390x
> rpm-libs-4.13.0.1-1.fc25.s390x
> perl-5.24.1-385.fc25.s390x
> util-linux-2.28.2-2.fc25.s390x
> libICE-1.0.9-8.fc25.s390x
> texlive-etoolbox-svn38031.2.2a-33.fc25.1.noarch
> texlive-dvips-svn41149-33.fc25.1.noarch
> texlive-latexconfig-svn40274-33.fc25.1.noarch
> texlive-tex-ini-files-svn40533-33.fc25.1.noarch
> texlive-qstest-svn15878.0-33.fc25.1.noarch
> texlive-cmap-svn41168-33.fc25.1.noarch
> texlive-luatex-bin-svn41091-33.20160520.fc25.1.s390x
> texlive-mflogo-svn38628-33.fc25.1.noarch
> texlive-sansmath-svn17997.1.1-33.fc25.1.noarch
> texlive-unicode-data-svn39808-33.fc25.1.noarch
> texlive-luaotfload-bin-svn34647.0-33.20160520.fc25.1.noarch
> texlive-listings-svn37534.1.6-33.fc25.1.noarch
> texlive-pstricks-svn41321-33.fc25.1.noarch
> texlive-metalogo-svn18611.0.12-33.fc25.1.noarch
> texlive-collection-latex-svn41011-33.20160520.fc25.1.noarch
> kernel-4.10.5-200.fc25.s390x
> python2-dnf-plugins-core-0.1.21-5.fc25.noarch
> xkeyboard-config-2.20-2.fc25.noarch
> nss-util-3.29.3-1.1.fc25.s390x
> dbus-1.11.12-1.fc25.s390x
> ghostscript-9.20-7.fc25.s390x
> vim-filesystem-8.0.514-1.fc25.s390x
> jasper-libs-1.900.13-3.fc25.s390x
> file-5.29-4.fc25.s390x
> curl-7.51.0-6.fc25.s390x
> perl-Test-Harness-3.39-1.fc25.noarch
> libattr-2.4.47-16.fc24.s390x
> acl-2.2.52-11.fc24.s390x
> libvisual-0.4.0-20.fc24.s390x
> libpcap-1.7.4-2.fc24.s390x
> libutempter-1.1.6-8.fc24.s390x
> libgudev-230-3.fc24.s390x
> popt-devel-1.16-7.fc24.s390x
> make-4.1-5.fc24.s390x
> hicolor-icon-theme-0.15-3.fc24.noarch
> setup-2.10.4-1.fc25.noarch
> bash-4.3.43-4.fc25.s390x
> nspr-4.13.1-1.fc25.s390x
> libjpeg-turbo-1.5.1-0.fc25.s390x
> perl-Socket-2.024-1.fc25.s390x
> perl-HTTP-Tiny-0.070-1.fc25.noarch
> ipset-6.29-1.fc25.s390x
> python2-setuptools-25.1.1-1.fc25.noarch
> gsettings-desktop-schemas-3.22.0-1.fc25.s390x
> python3-setuptools-25.1.1-1.fc25.noarch
> python-slip-dbus-0.6.4-4.fc25.noarch
> python2-ply-3.8-2.fc25.noarch
> dtc-1.4.2-1.fc25.s390x
> guile-2.0.13-1.fc25.s390x
> cronie-anacron-1.5.1-2.fc25.s390x
> libXtst-1.2.3-1.fc25.s390x
> iso-codes-3.70-1.fc25.noarch
> s390utils-1.36.0-1.fc25.s390x
> python-backports-ssl_match_hostname-3.5.0.1-3.fc25.noarch
> fedora-cert-0.6.0.1-1.fc25.noarch
> libstdc++-6.3.1-1.fc25.s390x
> subversion-libs-1.9.5-1.fc25.s390x
> libgfortran-6.3.1-1.fc25.s390x
> libtasn1-4.10-1.fc25.s390x
> dnf-plugin-system-upgrade-0.7.1-4.fc25.noarch
> lvm2-2.02.167-3.fc25.s390x
> libselinux-devel-2.5-13.fc25.s390x
> perl-Time-Local-1.250-1.fc25.noarch
> libtirpc-1.0.1-3.rc3.fc25.s390x
> libradosstriper-devel-10.2.4-2.fc25.s390x
> flac-libs-1.3.2-1.fc25.s390x
> perl-Digest-1.17-366.fc25.noarch
> teckit-2.5.1-15.fc24.s390x
> libpath_utils-0.2.1-29.fc25.s390x
> attr-2.4.47-16.fc24.s390x
> usbredir-0.7.1-2.fc24.s390x
> cairo-devel-1.14.8-1.fc25.s390x
> lzo-devel-2.08-8.fc24.s390x
> libcap-devel-2.25-2.fc25.s390x
> opus-1.1.3-2.fc25.s390x
> firewalld-filesystem-0.4.4.4-1.fc25.noarch
> coreutils-8.25-16.fc25.s390x
> krb5-devel-1.14.4-7.fc25.s390x
> rpm-4.13.0.1-1.fc25.s390x
> kernel-devel-4.10.5-200.fc25.s390x
> systemd-pam-231-14.fc25.s390x
> libbsd-0.8.3-1.fc25.s390x
> texlive-url-svn32528.3.4-33.fc25.1.noarch
> texlive-dvips-bin-svn40987-33.20160520.fc25.1.s390x
> texlive-index-svn24099.4.1beta-33.fc25.1.noarch
> texlive-setspace-svn24881.6.7a-33.fc25.1.noarch
> texlive-mathtools-svn38833-33.fc25.1.noarch
> texlive-cm-svn32865.0-33.fc25.1.noarch
> texlive-graphics-def-svn41879-33.fc25.1.noarch
> texlive-mdwtools-svn15878.1.05.4-33.fc25.1.noarch
> texlive-rsfs-svn15878.0-33.fc25.1.noarch
> texlive-ucharcat-svn38907-33.fc25.1.noarch
> texlive-fontspec-svn41262-33.fc25.1.noarch
> texlive-showexpl-svn32737.v0.3l-33.fc25.1.noarch
> texlive-pstricks-add-svn40744-33.fc25.1.noarch
> texlive-beamer-svn36461.3.36-33.fc25.1.noarch
> texlive-collection-basic-svn41149-33.20160520.fc25.1.noarch
> mock-1.3.4-1.fc25.noarch
> rpm-build-4.13.0.1-1.fc25.s390x
> xemacs-filesystem-21.5.34-20.20170124hgf412e9f093d4.fc25.noarch
> nss-sysinit-3.29.3-1.1.fc25.s390x
> hawkey-0.6.4-3.fc25.s390x
> mesa-libGLES-13.0.4-3.fc25.s390x
> vim-common-8.0.514-1.fc25.s390x
> gdk-pixbuf2-modules-2.36.6-1.fc25.s390x
> bluez-libs-5.44-1.fc25.s390x
> libcurl-devel-7.51.0-6.fc25.s390x
> mc-4.8.19-1.fc25.s390x
> gpg-pubkey-a0a7badb-52844296
> readline-6.3-8.fc24.s390x
> cpio-2.12-3.fc24.s390x
> qrencode-libs-3.4.2-6.fc24.s390x
> libXcomposite-0.4.4-8.fc24.s390x
> procps-ng-3.3.10-11.fc24.s390x
> GConf2-3.2.6-16.fc24.s390x
> xz-devel-5.2.2-2.fc24.s390x
> fedora-logos-22.0.0-3.fc24.s390x
> gpg-pubkey-e372e838-56fd7943
> kmod-libs-23-1.fc25.s390x
> perl-parent-0.236-1.fc25.noarch
> perl-TermReadKey-2.37-1.fc25.s390x
> dhcp-libs-4.3.5-1.fc25.s390x
> ncurses-c++-libs-6.0-6.20160709.fc25.s390x
> gzip-1.8-1.fc25.s390x
> python3-gobject-base-3.22.0-1.fc25.s390x
> python2-yubico-1.3.2-3.fc25.noarch
> s390utils-ziomon-1.36.0-1.fc25.s390x
> librepo-1.7.18-3.fc25.s390x
> librsvg2-2.40.16-2.fc25.s390x
> gnat-srpm-macros-4-1.fc25.noarch
> python-decoratortools-1.8-12.fc25.noarch
> m17n-db-1.7.0-7.fc25.noarch
> glibc-common-2.24-4.fc25.s390x
> e2fsprogs-libs-1.43.3-1.fc25.s390x
> libvorbis-1.3.5-1.fc25.s390x
> gcc-gdb-plugin-6.3.1-1.fc25.s390x
> perl-Time-HiRes-1.9741-1.fc25.s390x
> npth-1.3-1.fc25.s390x
> libcephfs1-10.2.4-2.fc25.s390x
> wayland-devel-1.12.0-1.fc25.s390x
> libxcb-devel-1.12-1.fc25.s390x
> perl-encoding-2.19-5.fc25.s390x
> python3-cssselect-0.9.2-1.fc25.noarch
> gettext-libs-0.19.8.1-3.fc25.s390x
> at-spi2-atk-devel-2.22.0-1.fc25.s390x
> virglrenderer-0.5.0-1.20160411git61846f92f.fc25.s390x
> pixman-devel-0.34.0-2.fc24.s390x
> libnfs-devel-1.9.8-2.fc24.s390x
> libX11-common-1.6.4-4.fc25.noarch
> nss-softokn-devel-3.29.3-1.0.fc25.s390x
> libblkid-2.28.2-2.fc25.s390x
> bind-libs-9.10.4-4.P6.fc25.s390x
> glib2-devel-2.50.3-1.fc25.s390x
> systemd-udev-231-14.fc25.s390x
> texlive-ifxetex-svn19685.0.5-33.fc25.1.noarch
> texlive-caption-svn41409-33.fc25.1.noarch
> texlive-float-svn15878.1.3d-33.fc25.1.noarch
> texlive-pdftex-def-svn22653.0.06d-33.fc25.1.noarch
> texlive-xdvi-bin-svn40750-33.20160520.fc25.1.s390x
> texlive-beton-svn15878.0-33.fc25.1.noarch
> texlive-filecontents-svn24250.1.3-33.fc25.1.noarch
> texlive-lm-math-svn36915.1.959-33.fc25.1.noarch
> texlive-pslatex-svn16416.0-33.fc25.1.noarch
> texlive-times-svn35058.0-33.fc25.1.noarch
> texlive-breakurl-svn29901.1.40-33.fc25.1.noarch
> texlive-filehook-svn24280.0.5d-33.fc25.1.noarch
> texlive-pst-pdf-svn31660.1.1v-33.fc25.1.noarch
> texlive-seminar-svn34011.1.62-33.fc25.1.noarch
> texlive-xetexconfig-svn41133-33.fc25.1.noarch
> systemtap-3.1-2.fc25.s390x
> python-rpm-macros-3-12.fc25.noarch
> rpm-devel-4.13.0.1-1.fc25.s390x
> nss-pem-1.0.3-3.fc25.s390x
> mesa-libGL-13.0.4-3.fc25.s390x
> at-spi2-core-2.22.1-1.fc25.s390x
> pcre2-utf32-10.23-5.fc25.s390x
> gtk3-3.22.11-1.fc25.s390x
> GeoIP-GeoLite-data-2017.04-1.fc25.noarch
> pcre-static-8.40-6.fc25.s390x
> kernel-devel-4.10.8-200.fc25.s390x
> =3D=3D=3D TEST BEGIN =3D=3D=3D
> Using CC: /home/fam/bin/cc
> Install prefix    /var/tmp/patchew-tester-tmp-xibqn8r3/src/install
> BIOS directory    /var/tmp/patchew-tester-tmp-xibqn8r3/src/install/shar=
e/qemu
> binary directory  /var/tmp/patchew-tester-tmp-xibqn8r3/src/install/bin
> library directory /var/tmp/patchew-tester-tmp-xibqn8r3/src/install/lib
> module directory  /var/tmp/patchew-tester-tmp-xibqn8r3/src/install/lib/=
qemu
> libexec directory /var/tmp/patchew-tester-tmp-xibqn8r3/src/install/libe=
xec
> include directory /var/tmp/patchew-tester-tmp-xibqn8r3/src/install/incl=
ude
> config directory  /var/tmp/patchew-tester-tmp-xibqn8r3/src/install/etc
> local state directory   /var/tmp/patchew-tester-tmp-xibqn8r3/src/instal=
l/var
> Manual directory  /var/tmp/patchew-tester-tmp-xibqn8r3/src/install/shar=
e/man
> ELF interp prefix /usr/gnemul/qemu-%M
> Source path       /var/tmp/patchew-tester-tmp-xibqn8r3/src
> C compiler        /home/fam/bin/cc
> Host C compiler   cc
> C++ compiler      c++
> Objective-C compiler /home/fam/bin/cc
> ARFLAGS           rv
> CFLAGS            -O2 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=3D2 -g=20
> QEMU_CFLAGS       -I/usr/include/pixman-1  -Werror -DHAS_LIBSSH2_SFTP_F=
SYNC -pthread -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include -D_GN=
U_SOURCE -m64 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE =
-Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings -Wmis=
sing-prototypes -fno-strict-aliasing -fno-common -fwrapv  -Wendif-labels =
-Wno-shift-negative-value -Wno-missing-include-dirs -Wempty-body -Wnested=
-externs -Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers =
-Wold-style-declaration -Wold-style-definition -Wtype-limits -fstack-prot=
ector-strong -I/usr/include/p11-kit-1    -I/usr/include/libpng16 -I/usr/i=
nclude/libdrm  -I/usr/include/cacard -I/usr/include/nss3 -I/usr/include/n=
spr4 -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include -I/usr/include=
/libusb-1.0=20
> LDFLAGS           -Wl,--warn-common -m64 -g=20
> make              make
> install           install
> python            python -B
> smbd              /usr/sbin/smbd
> module support    no
> host CPU          s390x
> host big endian   yes
> target list        aarch64-softmmu alpha-softmmu arm-softmmu cris-softm=
mu i386-softmmu lm32-softmmu m68k-softmmu microblazeel-softmmu microblaze=
-softmmu mips64el-softmmu mips64-softmmu mipsel-softmmu mips-softmmu moxi=
e-softmmu nios2-softmmu or1k-softmmu ppc64-softmmu ppcemb-softmmu ppc-sof=
tmmu s390x-softmmu sh4eb-softmmu sh4-softmmu sparc64-softmmu sparc-softmm=
u tricore-softmmu unicore32-softmmu x86_64-softmmu xtensaeb-softmmu xtens=
a-softmmu aarch64-linux-user alpha-linux-user armeb-linux-user arm-linux-=
user cris-linux-user hppa-linux-user i386-linux-user m68k-linux-user micr=
oblazeel-linux-user microblaze-linux-user mips64el-linux-user mips64-linu=
x-user mipsel-linux-user mips-linux-user mipsn32el-linux-user mipsn32-lin=
ux-user nios2-linux-user or1k-linux-user ppc64abi32-linux-user ppc64le-li=
nux-user ppc64-linux-user ppc-linux-user s390x-linux-user sh4eb-linux-use=
r sh4-linux-user sparc32plus-linux-user sparc64-linux-user sparc-linux-us=
er tilegx-linux-user x86_64-linux-user
> tcg debug enabled no
> gprof enabled     no
> sparse enabled    no
> strip binaries    yes
> profiler          no
> static build      no
> pixman            system
> SDL support       yes (2.0.5)
> GTK support       yes (3.22.11)
> GTK GL support    yes
> VTE support       yes (0.46.1)
> TLS priority      NORMAL
> GNUTLS support    yes
> GNUTLS rnd        yes
> libgcrypt         no
> libgcrypt kdf     no
> nettle            yes (3.3)
> nettle kdf        yes
> libtasn1          yes
> curses support    yes
> virgl support     yes
> curl support      yes
> mingw32 support   no
> Audio drivers     oss
> Block whitelist (rw)=20
> Block whitelist (ro)=20
> VirtFS support    yes
> VNC support       yes
> VNC SASL support  yes
> VNC JPEG support  yes
> VNC PNG support   yes
> xen support       no
> brlapi support    yes
> bluez  support    yes
> Documentation     yes
> PIE               no
> vde support       no
> netmap support    no
> Linux AIO support yes
> ATTR/XATTR support yes
> Install blobs     yes
> KVM support       yes
> HAX support       no
> RDMA support      no
> TCG interpreter   no
> fdt support       yes
> preadv support    yes
> fdatasync         yes
> madvise           yes
> posix_madvise     yes
> libcap-ng support yes
> vhost-net support yes
> vhost-scsi support yes
> vhost-vsock support yes
> Trace backends    log
> spice support     no=20
> rbd support       yes
> xfsctl support    no
> smartcard support yes
> libusb            yes
> usb net redir     yes
> OpenGL support    yes
> OpenGL dmabufs    yes
> libiscsi support  yes
> libnfs support    yes
> build guest agent yes
> QGA VSS support   no
> QGA w32 disk info no
> QGA MSI support   no
> seccomp support   no
> coroutine backend ucontext
> coroutine pool    yes
> debug stack usage no
> GlusterFS support yes
> gcov              gcov
> gcov enabled      no
> TPM support       yes
> libssh2 support   yes
> TPM passthrough   no
> QOM debugging     yes
> Live block migration yes
> lzo support       yes
> snappy support    yes
> bzip2 support     yes
> NUMA host support no
> tcmalloc support  no
> jemalloc support  no
> avx2 optimization no
> replication support yes
> VxHS block device no
>   GEN     aarch64-softmmu/config-devices.mak.tmp
>   GEN     cris-softmmu/config-devices.mak.tmp
>   GEN     alpha-softmmu/config-devices.mak.tmp
>   GEN     arm-softmmu/config-devices.mak.tmp
>   GEN     cris-softmmu/config-devices.mak
>   GEN     i386-softmmu/config-devices.mak.tmp
>   GEN     arm-softmmu/config-devices.mak
>   GEN     lm32-softmmu/config-devices.mak.tmp
>   GEN     aarch64-softmmu/config-devices.mak
>   GEN     alpha-softmmu/config-devices.mak
>   GEN     m68k-softmmu/config-devices.mak.tmp
>   GEN     microblazeel-softmmu/config-devices.mak.tmp
>   GEN     lm32-softmmu/config-devices.mak
>   GEN     i386-softmmu/config-devices.mak
>   GEN     microblaze-softmmu/config-devices.mak.tmp
>   GEN     mips64el-softmmu/config-devices.mak.tmp
>   GEN     m68k-softmmu/config-devices.mak
>   GEN     microblaze-softmmu/config-devices.mak
>   GEN     mips64-softmmu/config-devices.mak.tmp
>   GEN     mipsel-softmmu/config-devices.mak.tmp
>   GEN     microblazeel-softmmu/config-devices.mak
>   GEN     mips-softmmu/config-devices.mak.tmp
>   GEN     mips64el-softmmu/config-devices.mak
>   GEN     moxie-softmmu/config-devices.mak.tmp
>   GEN     mips64-softmmu/config-devices.mak
>   GEN     mipsel-softmmu/config-devices.mak
>   GEN     or1k-softmmu/config-devices.mak.tmp
>   GEN     nios2-softmmu/config-devices.mak.tmp
>   GEN     moxie-softmmu/config-devices.mak
>   GEN     mips-softmmu/config-devices.mak
>   GEN     nios2-softmmu/config-devices.mak
>   GEN     ppc64-softmmu/config-devices.mak.tmp
>   GEN     or1k-softmmu/config-devices.mak
>   GEN     ppc-softmmu/config-devices.mak.tmp
>   GEN     ppcemb-softmmu/config-devices.mak.tmp
>   GEN     s390x-softmmu/config-devices.mak.tmp
>   GEN     s390x-softmmu/config-devices.mak
>   GEN     ppc64-softmmu/config-devices.mak
>   GEN     sh4eb-softmmu/config-devices.mak.tmp
>   GEN     sh4-softmmu/config-devices.mak.tmp
>   GEN     ppcemb-softmmu/config-devices.mak
>   GEN     ppc-softmmu/config-devices.mak
>   GEN     sparc64-softmmu/config-devices.mak.tmp
>   GEN     sparc-softmmu/config-devices.mak.tmp
>   GEN     sh4eb-softmmu/config-devices.mak
>   GEN     sparc-softmmu/config-devices.mak
>   GEN     sparc64-softmmu/config-devices.mak
>   GEN     sh4-softmmu/config-devices.mak
>   GEN     unicore32-softmmu/config-devices.mak.tmp
>   GEN     tricore-softmmu/config-devices.mak.tmp
>   GEN     x86_64-softmmu/config-devices.mak.tmp
>   GEN     xtensaeb-softmmu/config-devices.mak.tmp
>   GEN     unicore32-softmmu/config-devices.mak
>   GEN     tricore-softmmu/config-devices.mak
>   GEN     aarch64-linux-user/config-devices.mak.tmp
>   GEN     xtensa-softmmu/config-devices.mak.tmp
>   GEN     xtensaeb-softmmu/config-devices.mak
>   GEN     x86_64-softmmu/config-devices.mak
>   GEN     alpha-linux-user/config-devices.mak.tmp
>   GEN     armeb-linux-user/config-devices.mak.tmp
>   GEN     aarch64-linux-user/config-devices.mak
>   GEN     xtensa-softmmu/config-devices.mak
>   GEN     arm-linux-user/config-devices.mak.tmp
>   GEN     cris-linux-user/config-devices.mak.tmp
>   GEN     armeb-linux-user/config-devices.mak
>   GEN     alpha-linux-user/config-devices.mak
>   GEN     arm-linux-user/config-devices.mak
>   GEN     hppa-linux-user/config-devices.mak.tmp
>   GEN     i386-linux-user/config-devices.mak.tmp
>   GEN     cris-linux-user/config-devices.mak
>   GEN     m68k-linux-user/config-devices.mak.tmp
>   GEN     microblazeel-linux-user/config-devices.mak.tmp
>   GEN     hppa-linux-user/config-devices.mak
>   GEN     i386-linux-user/config-devices.mak
>   GEN     microblaze-linux-user/config-devices.mak.tmp
>   GEN     mips64el-linux-user/config-devices.mak.tmp
>   GEN     m68k-linux-user/config-devices.mak
>   GEN     mips64-linux-user/config-devices.mak.tmp
>   GEN     mips64el-linux-user/config-devices.mak
>   GEN     microblazeel-linux-user/config-devices.mak
>   GEN     mipsel-linux-user/config-devices.mak.tmp
>   GEN     mips-linux-user/config-devices.mak.tmp
>   GEN     microblaze-linux-user/config-devices.mak
>   GEN     mips64-linux-user/config-devices.mak
>   GEN     mipsn32el-linux-user/config-devices.mak.tmp
>   GEN     mipsn32-linux-user/config-devices.mak.tmp
>   GEN     mipsel-linux-user/config-devices.mak
>   GEN     mips-linux-user/config-devices.mak
>   GEN     mipsn32el-linux-user/config-devices.mak
>   GEN     or1k-linux-user/config-devices.mak.tmp
>   GEN     nios2-linux-user/config-devices.mak.tmp
>   GEN     ppc64abi32-linux-user/config-devices.mak.tmp
>   GEN     mipsn32-linux-user/config-devices.mak
>   GEN     ppc64le-linux-user/config-devices.mak.tmp
>   GEN     ppc64abi32-linux-user/config-devices.mak
>   GEN     or1k-linux-user/config-devices.mak
>   GEN     nios2-linux-user/config-devices.mak
>   GEN     ppc64-linux-user/config-devices.mak.tmp
>   GEN     ppc-linux-user/config-devices.mak.tmp
>   GEN     s390x-linux-user/config-devices.mak.tmp
>   GEN     ppc64le-linux-user/config-devices.mak
>   GEN     sh4eb-linux-user/config-devices.mak.tmp
>   GEN     ppc64-linux-user/config-devices.mak
>   GEN     ppc-linux-user/config-devices.mak
>   GEN     sh4eb-linux-user/config-devices.mak
>   GEN     s390x-linux-user/config-devices.mak
>   GEN     sh4-linux-user/config-devices.mak.tmp
>   GEN     sparc32plus-linux-user/config-devices.mak.tmp
>   GEN     sparc64-linux-user/config-devices.mak.tmp
>   GEN     sparc-linux-user/config-devices.mak.tmp
>   GEN     sh4-linux-user/config-devices.mak
>   GEN     tilegx-linux-user/config-devices.mak.tmp
>   GEN     sparc64-linux-user/config-devices.mak
>   GEN     sparc-linux-user/config-devices.mak
>   GEN     x86_64-linux-user/config-devices.mak.tmp
>   GEN     sparc32plus-linux-user/config-devices.mak
>   GEN     tilegx-linux-user/config-devices.mak
>   GEN     config-host.h
>   GEN     qemu-options.def
>   GEN     x86_64-linux-user/config-devices.mak
>   GEN     qmp-commands.h
>   GEN     qapi-types.h
>   GEN     qapi-visit.h
>   GEN     qapi-event.h
>   GEN     qmp-marshal.c
>   GEN     qapi-types.c
>   GEN     qapi-visit.c
>   GEN     qapi-event.c
>   GEN     qmp-introspect.h
>   GEN     qmp-introspect.c
>   GEN     trace/generated-tcg-tracers.h
>   GEN     trace/generated-helpers-wrappers.h
>   GEN     trace/generated-helpers.h
>   GEN     trace/generated-helpers.c
>   GEN     tests/test-qapi-types.h
>   GEN     module_block.h
>   GEN     tests/test-qapi-visit.h
>   GEN     tests/test-qmp-commands.h
>   GEN     tests/test-qapi-event.h
>   GEN     trace-root.h
>   GEN     tests/test-qmp-introspect.h
>   GEN     crypto/trace.h
>   GEN     io/trace.h
>   GEN     util/trace.h
>   GEN     migration/trace.h
>   GEN     block/trace.h
>   GEN     chardev/trace.h
>   GEN     backends/trace.h
>   GEN     hw/block/trace.h
>   GEN     hw/block/dataplane/trace.h
>   GEN     hw/char/trace.h
>   GEN     hw/intc/trace.h
>   GEN     hw/net/trace.h
>   GEN     hw/virtio/trace.h
>   GEN     hw/audio/trace.h
>   GEN     hw/misc/trace.h
>   GEN     hw/usb/trace.h
>   GEN     hw/scsi/trace.h
>   GEN     hw/nvram/trace.h
>   GEN     hw/display/trace.h
>   GEN     hw/input/trace.h
>   GEN     hw/timer/trace.h
>   GEN     hw/dma/trace.h
>   GEN     hw/sparc/trace.h
>   GEN     hw/sd/trace.h
>   GEN     hw/isa/trace.h
>   GEN     hw/mem/trace.h
>   GEN     hw/i386/trace.h
>   GEN     hw/i386/xen/trace.h
>   GEN     hw/9pfs/trace.h
>   GEN     hw/pci/trace.h
>   GEN     hw/ppc/trace.h
>   GEN     hw/s390x/trace.h
>   GEN     hw/vfio/trace.h
>   GEN     hw/acpi/trace.h
>   GEN     hw/arm/trace.h
>   GEN     hw/alpha/trace.h
>   GEN     hw/xen/trace.h
>   GEN     ui/trace.h
>   GEN     audio/trace.h
>   GEN     net/trace.h
>   GEN     target/arm/trace.h
>   GEN     target/i386/trace.h
>   GEN     target/mips/trace.h
>   GEN     target/sparc/trace.h
>   GEN     target/s390x/trace.h
>   GEN     target/ppc/trace.h
>   GEN     qom/trace.h
>   GEN     linux-user/trace.h
>   GEN     trace-root.c
>   GEN     qapi/trace.h
>   GEN     util/trace.c
>   GEN     crypto/trace.c
>   GEN     io/trace.c
>   GEN     migration/trace.c
>   GEN     block/trace.c
>   GEN     backends/trace.c
>   GEN     chardev/trace.c
>   GEN     hw/block/trace.c
>   GEN     hw/block/dataplane/trace.c
>   GEN     hw/intc/trace.c
>   GEN     hw/char/trace.c
>   GEN     hw/net/trace.c
>   GEN     hw/virtio/trace.c
>   GEN     hw/audio/trace.c
>   GEN     hw/misc/trace.c
>   GEN     hw/scsi/trace.c
>   GEN     hw/usb/trace.c
>   GEN     hw/nvram/trace.c
>   GEN     hw/display/trace.c
>   GEN     hw/input/trace.c
>   GEN     hw/timer/trace.c
>   GEN     hw/dma/trace.c
>   GEN     hw/sparc/trace.c
>   GEN     hw/isa/trace.c
>   GEN     hw/sd/trace.c
>   GEN     hw/i386/trace.c
>   GEN     hw/mem/trace.c
>   GEN     hw/i386/xen/trace.c
>   GEN     hw/9pfs/trace.c
>   GEN     hw/pci/trace.c
>   GEN     hw/ppc/trace.c
>   GEN     hw/vfio/trace.c
>   GEN     hw/s390x/trace.c
>   GEN     hw/acpi/trace.c
>   GEN     hw/arm/trace.c
>   GEN     hw/alpha/trace.c
>   GEN     hw/xen/trace.c
>   GEN     ui/trace.c
>   GEN     net/trace.c
>   GEN     audio/trace.c
>   GEN     target/arm/trace.c
>   GEN     target/i386/trace.c
>   GEN     target/mips/trace.c
>   GEN     target/sparc/trace.c
>   GEN     target/s390x/trace.c
>   GEN     qom/trace.c
>   GEN     linux-user/trace.c
>   GEN     target/ppc/trace.c
>   GEN     qapi/trace.c
>   GEN     config-all-devices.mak
>   GEN     qemu-options.texi
>   CC      tests/qemu-iotests/socket_scm_helper.o
>   GEN     qemu-img-cmds.texi
>   GEN     qemu-monitor.texi
>   GEN     qemu-monitor-info.texi
>   GEN     qemu-img.1
>   GEN     qemu-nbd.8
>   GEN     qemu-ga.8
>   GEN     docs/version.texi
>   GEN     docs/qemu-qmp-qapi.texi
>   GEN     docs/qemu-ga-qapi.texi
>   GEN     qga/qapi-generated/qga-qapi-types.h
>   GEN     fsdev/virtfs-proxy-helper.1
>   GEN     qga/qapi-generated/qga-qapi-visit.h
>   GEN     qga/qapi-generated/qga-qmp-commands.h
>   GEN     qga/qapi-generated/qga-qapi-types.c
>   GEN     qga/qapi-generated/qga-qapi-visit.c
>   GEN     qga/qapi-generated/qga-qmp-marshal.c
>   CC      qmp-introspect.o
>   CC      qapi-visit.o
>   CC      qapi-types.o
>   CC      qapi-event.o
>   CC      qapi/qapi-visit-core.o
>   CC      qapi/qapi-dealloc-visitor.o
>   CC      qapi/qobject-input-visitor.o
>   CC      qapi/qobject-output-visitor.o
>   CC      qapi/qmp-registry.o
>   CC      qapi/qmp-dispatch.o
>   CC      qapi/string-input-visitor.o
>   CC      qapi/string-output-visitor.o
>   CC      qapi/opts-visitor.o
>   CC      qapi/qapi-clone-visitor.o
>   CC      qapi/qmp-event.o
>   CC      qapi/qapi-util.o
>   CC      qobject/qnull.o
>   CC      qobject/qint.o
>   CC      qobject/qstring.o
>   CC      qobject/qdict.o
>   CC      qobject/qlist.o
>   CC      qobject/qfloat.o
>   CC      qobject/qbool.o
>   CC      qobject/qobject.o
>   CC      qobject/json-lexer.o
>   CC      qobject/qjson.o
>   CC      qobject/json-streamer.o
>   CC      qobject/json-parser.o
>   CC      trace/control.o
>   CC      trace/qmp.o
>   CC      util/osdep.o
>   CC      util/cutils.o
>   CC      util/unicode.o
>   CC      util/qemu-timer-common.o
>   CC      util/bufferiszero.o
>   CC      util/lockcnt.o
>   CC      util/aiocb.o
>   CC      util/async.o
>   CC      util/thread-pool.o
>   CC      util/qemu-timer.o
>   CC      util/main-loop.o
>   CC      util/iohandler.o
>   CC      util/aio-posix.o
>   CC      util/event_notifier-posix.o
>   CC      util/compatfd.o
>   CC      util/mmap-alloc.o
>   CC      util/oslib-posix.o
>   CC      util/qemu-openpty.o
>   CC      util/qemu-thread-posix.o
>   CC      util/memfd.o
>   CC      util/envlist.o
>   CC      util/path.o
>   CC      util/module.o
>   CC      util/host-utils.o
>   CC      util/bitmap.o
>   CC      util/hbitmap.o
>   CC      util/bitops.o
>   CC      util/fifo8.o
>   CC      util/acl.o
>   CC      util/error.o
>   CC      util/qemu-error.o
>   CC      util/id.o
>   CC      util/qemu-config.o
>   CC      util/iov.o
>   CC      util/qemu-sockets.o
>   CC      util/uri.o
>   CC      util/notify.o
>   CC      util/qemu-progress.o
>   CC      util/qemu-option.o
>   CC      util/keyval.o
>   CC      util/hexdump.o
>   CC      util/crc32c.o
>   CC      util/uuid.o
>   CC      util/throttle.o
>   CC      util/getauxval.o
>   CC      util/rcu.o
>   CC      util/readline.o
>   CC      util/qemu-coroutine.o
>   CC      util/qemu-coroutine-lock.o
>   CC      util/qemu-coroutine-io.o
>   CC      util/qemu-coroutine-sleep.o
>   CC      util/coroutine-ucontext.o
>   CC      util/buffer.o
>   CC      util/timed-average.o
>   CC      util/base64.o
>   CC      util/log.o
>   CC      util/qdist.o
>   CC      util/qht.o
>   CC      util/range.o
>   CC      util/systemd.o
>   CC      trace-root.o
>   CC      util/trace.o
>   CC      crypto/trace.o
>   CC      io/trace.o
>   CC      migration/trace.o
>   CC      block/trace.o
>   CC      backends/trace.o
>   CC      chardev/trace.o
>   CC      hw/block/trace.o
>   CC      hw/block/dataplane/trace.o
>   CC      hw/char/trace.o
>   CC      hw/intc/trace.o
>   CC      hw/net/trace.o
>   CC      hw/virtio/trace.o
>   CC      hw/audio/trace.o
>   CC      hw/usb/trace.o
>   CC      hw/misc/trace.o
>   CC      hw/scsi/trace.o
>   CC      hw/nvram/trace.o
>   CC      hw/display/trace.o
>   CC      hw/input/trace.o
>   CC      hw/timer/trace.o
>   CC      hw/dma/trace.o
>   CC      hw/sparc/trace.o
>   CC      hw/sd/trace.o
>   CC      hw/isa/trace.o
>   CC      hw/mem/trace.o
>   CC      hw/i386/trace.o
>   CC      hw/i386/xen/trace.o
>   CC      hw/9pfs/trace.o
>   CC      hw/ppc/trace.o
>   CC      hw/pci/trace.o
>   CC      hw/s390x/trace.o
>   CC      hw/vfio/trace.o
>   CC      hw/acpi/trace.o
>   CC      hw/arm/trace.o
>   CC      hw/alpha/trace.o
>   CC      hw/xen/trace.o
>   CC      ui/trace.o
>   CC      audio/trace.o
>   CC      net/trace.o
>   CC      target/i386/trace.o
>   CC      target/arm/trace.o
>   CC      target/mips/trace.o
>   CC      target/sparc/trace.o
>   CC      target/s390x/trace.o
>   CC      target/ppc/trace.o
>   CC      qom/trace.o
>   CC      linux-user/trace.o
>   CC      qapi/trace.o
>   CC      crypto/pbkdf-stub.o
>   CC      stubs/arch-query-cpu-def.o
>   CC      stubs/arch-query-cpu-model-expansion.o
>   CC      stubs/arch-query-cpu-model-baseline.o
>   CC      stubs/arch-query-cpu-model-comparison.o
>   CC      stubs/bdrv-next-monitor-owned.o
>   CC      stubs/blk-commit-all.o
>   CC      stubs/blockdev-close-all-bdrv-states.o
>   CC      stubs/clock-warp.o
>   CC      stubs/cpu-get-clock.o
>   CC      stubs/cpu-get-icount.o
>   CC      stubs/dump.o
>   CC      stubs/error-printf.o
>   CC      stubs/fdset.o
>   CC      stubs/gdbstub.o
>   CC      stubs/get-vm-name.o
>   CC      stubs/iothread-lock.o
>   CC      stubs/iothread.o
>   CC      stubs/is-daemonized.o
>   CC      stubs/linux-aio.o
>   CC      stubs/machine-init-done.o
>   CC      stubs/monitor.o
>   CC      stubs/migr-blocker.o
>   CC      stubs/notify-event.o
>   CC      stubs/qtest.o
>   CC      stubs/replay.o
>   CC      stubs/runstate-check.o
>   CC      stubs/slirp.o
>   CC      stubs/set-fd-handler.o
>   CC      stubs/sysbus.o
>   CC      stubs/uuid.o
>   CC      stubs/trace-control.o
>   CC      stubs/vm-stop.o
>   CC      stubs/vmstate.o
>   CC      stubs/qmp_pc_dimm_device_list.o
>   CC      stubs/target-monitor-defs.o
>   CC      stubs/target-get-monitor-def.o
>   CC      stubs/pc_madt_cpu_entry.o
>   CC      stubs/vmgenid.o
>   CC      stubs/xen-common.o
>   CC      stubs/xen-hvm.o
>   CC      contrib/ivshmem-client/ivshmem-client.o
>   CC      contrib/ivshmem-client/main.o
>   CC      contrib/ivshmem-server/ivshmem-server.o
>   CC      contrib/ivshmem-server/main.o
>   CC      qemu-nbd.o
>   CC      block.o
>   CC      qemu-io-cmds.o
>   CC      blockjob.o
>   CC      replication.o
>   CC      block/raw-format.o
>   CC      block/qcow.o
>   CC      block/vdi.o
>   CC      block/vmdk.o
>   CC      block/cloop.o
>   CC      block/bochs.o
>   CC      block/vpc.o
>   CC      block/vvfat.o
>   CC      block/dmg.o
>   CC      block/qcow2-refcount.o
>   CC      block/qcow2.o
>   CC      block/qcow2-cluster.o
>   CC      block/qcow2-snapshot.o
>   CC      block/qed.o
>   CC      block/qcow2-cache.o
>   CC      block/qed-gencb.o
>   CC      block/qed-l2-cache.o
>   CC      block/qed-table.o
>   CC      block/qed-cluster.o
>   CC      block/qed-check.o
>   CC      block/vhdx.o
>   CC      block/vhdx-endian.o
>   CC      block/vhdx-log.o
>   CC      block/quorum.o
>   CC      block/parallels.o
>   CC      block/blkdebug.o
>   CC      block/blkverify.o
>   CC      block/blkreplay.o
>   CC      block/block-backend.o
>   CC      block/snapshot.o
>   CC      block/qapi.o
>   CC      block/file-posix.o
>   CC      block/linux-aio.o
>   CC      block/null.o
>   CC      block/commit.o
>   CC      block/mirror.o
>   CC      block/io.o
>   CC      block/throttle-groups.o
>   CC      block/nbd.o
>   CC      block/nbd-client.o
>   CC      block/sheepdog.o
>   CC      block/iscsi-opts.o
>   CC      block/accounting.o
>   CC      block/dirty-bitmap.o
>   CC      block/write-threshold.o
>   CC      block/backup.o
>   CC      block/replication.o
>   CC      block/crypto.o
>   CC      nbd/server.o
>   CC      nbd/client.o
>   CC      nbd/common.o
>   CC      block/iscsi.o
>   CC      block/nfs.o
>   CC      block/curl.o
>   CC      block/rbd.o
>   CC      block/gluster.o
>   CC      block/ssh.o
>   CC      block/dmg-bz2.o
>   CC      crypto/init.o
>   CC      crypto/hash.o
>   CC      crypto/hash-nettle.o
>   CC      crypto/hmac.o
>   CC      crypto/hmac-nettle.o
>   CC      crypto/aes.o
>   CC      crypto/desrfb.o
>   CC      crypto/cipher.o
>   CC      crypto/tlscreds.o
>   CC      crypto/tlscredsanon.o
>   CC      crypto/tlscredsx509.o
>   CC      crypto/tlssession.o
>   CC      crypto/secret.o
>   CC      crypto/random-gnutls.o
>   CC      crypto/pbkdf.o
>   CC      crypto/pbkdf-nettle.o
>   CC      crypto/ivgen.o
>   CC      crypto/ivgen-essiv.o
>   CC      crypto/ivgen-plain.o
>   CC      crypto/ivgen-plain64.o
>   CC      crypto/afsplit.o
>   CC      crypto/xts.o
>   CC      crypto/block.o
>   CC      crypto/block-qcow.o
>   CC      crypto/block-luks.o
>   CC      io/channel.o
>   CC      io/channel-buffer.o
>   CC      io/channel-command.o
>   CC      io/channel-file.o
>   CC      io/channel-socket.o
>   CC      io/channel-tls.o
>   CC      io/channel-watch.o
>   CC      io/channel-websock.o
>   CC      io/channel-util.o
>   CC      io/dns-resolver.o
>   CC      io/task.o
>   CC      qom/object.o
>   CC      qom/container.o
>   CC      qom/qom-qobject.o
>   CC      qom/object_interfaces.o
>   GEN     qemu-img-cmds.h
>   CC      qemu-io.o
>   CC      fsdev/virtfs-proxy-helper.o
>   CC      fsdev/9p-marshal.o
>   CC      fsdev/9p-iov-marshal.o
>   CC      qemu-bridge-helper.o
>   CC      blockdev.o
>   CC      blockdev-nbd.o
>   CC      iothread.o
>   CC      qdev-monitor.o
>   CC      device-hotplug.o
>   CC      os-posix.o
>   CC      accel.o
>   CC      bt-host.o
>   CC      bt-vhci.o
>   CC      dma-helpers.o
>   CC      vl.o
>   CC      tpm.o
>   CC      device_tree.o
>   CC      qmp-marshal.o
>   CC      qmp.o
>   CC      hmp.o
>   CC      cpus-common.o
>   CC      audio/audio.o
>   CC      audio/noaudio.o
>   CC      audio/wavaudio.o
>   CC      audio/mixeng.o
>   CC      audio/sdlaudio.o
>   CC      audio/ossaudio.o
>   CC      audio/wavcapture.o
>   CC      backends/rng.o
>   CC      backends/rng-egd.o
>   CC      backends/rng-random.o
>   CC      backends/tpm.o
>   CC      backends/hostmem.o
>   CC      backends/hostmem-ram.o
>   CC      backends/hostmem-file.o
>   CC      backends/cryptodev.o
>   CC      backends/cryptodev-builtin.o
>   CC      block/stream.o
>   CC      chardev/msmouse.o
>   CC      chardev/wctablet.o
>   CC      chardev/testdev.o
>   CC      chardev/baum.o
>   CC      disas/alpha.o
>   CC      disas/arm.o
>   CXX     disas/arm-a64.o
>   CC      disas/hppa.o
>   CC      disas/cris.o
>   CC      disas/i386.o
>   CC      disas/m68k.o
>   CC      disas/microblaze.o
>   CC      disas/nios2.o
>   CC      disas/mips.o
>   CC      disas/moxie.o
>   CC      disas/ppc.o
>   CC      disas/s390.o
>   CC      disas/sh4.o
>   CC      disas/sparc.o
>   CC      disas/lm32.o
>   CXX     disas/libvixl/vixl/utils.o
>   CXX     disas/libvixl/vixl/compiler-intrinsics.o
>   CXX     disas/libvixl/vixl/a64/instructions-a64.o
>   CXX     disas/libvixl/vixl/a64/disasm-a64.o
>   CXX     disas/libvixl/vixl/a64/decoder-a64.o
>   CC      fsdev/qemu-fsdev.o
>   CC      fsdev/qemu-fsdev-opts.o
>   CC      fsdev/qemu-fsdev-throttle.o
>   CC      fsdev/qemu-fsdev-dummy.o
>   CC      hw/9pfs/9p.o
>   CC      hw/9pfs/9p-util.o
>   CC      hw/9pfs/9p-local.o
>   CC      hw/9pfs/9p-xattr.o
>   CC      hw/9pfs/9p-xattr-user.o
>   CC      hw/9pfs/9p-posix-acl.o
>   CC      hw/9pfs/coth.o
>   CC      hw/9pfs/cofs.o
>   CC      hw/9pfs/codir.o
>   CC      hw/9pfs/cofile.o
>   CC      hw/9pfs/coxattr.o
>   CC      hw/9pfs/9p-synth.o
>   CC      hw/9pfs/9p-handle.o
>   CC      hw/9pfs/9p-proxy.o
>   CC      hw/acpi/core.o
>   CC      hw/acpi/piix4.o
>   CC      hw/acpi/pcihp.o
>   CC      hw/acpi/ich9.o
>   CC      hw/acpi/tco.o
>   CC      hw/acpi/cpu_hotplug.o
>   CC      hw/acpi/memory_hotplug.o
>   CC      hw/acpi/cpu.o
>   CC      hw/acpi/nvdimm.o
>   CC      hw/acpi/vmgenid.o
>   CC      hw/acpi/acpi_interface.o
>   CC      hw/acpi/bios-linker-loader.o
>   CC      hw/acpi/aml-build.o
>   CC      hw/acpi/ipmi.o
>   CC      hw/acpi/acpi-stub.o
>   CC      hw/acpi/ipmi-stub.o
>   CC      hw/audio/sb16.o
>   CC      hw/audio/es1370.o
>   CC      hw/audio/ac97.o
>   CC      hw/audio/fmopl.o
>   CC      hw/audio/adlib.o
>   CC      hw/audio/gus.o
>   CC      hw/audio/gusemu_hal.o
>   CC      hw/audio/gusemu_mixer.o
>   CC      hw/audio/cs4231a.o
>   CC      hw/audio/intel-hda.o
>   CC      hw/audio/hda-codec.o
>   CC      hw/audio/pcspk.o
>   CC      hw/audio/wm8750.o
>   CC      hw/audio/pl041.o
>   CC      hw/audio/lm4549.o
>   CC      hw/audio/cs4231.o
>   CC      hw/audio/marvell_88w8618.o
>   CC      hw/audio/milkymist-ac97.o
>   CC      hw/audio/soundhw.o
>   CC      hw/block/block.o
>   CC      hw/block/cdrom.o
>   CC      hw/block/fdc.o
>   CC      hw/block/hd-geometry.o
>   CC      hw/block/m25p80.o
>   CC      hw/block/nand.o
>   CC      hw/block/pflash_cfi01.o
>   CC      hw/block/pflash_cfi02.o
>   CC      hw/block/ecc.o
>   CC      hw/block/onenand.o
>   CC      hw/block/nvme.o
>   CC      hw/bt/core.o
>   CC      hw/bt/l2cap.o
>   CC      hw/bt/sdp.o
>   CC      hw/bt/hci.o
>   CC      hw/bt/hid.o
>   CC      hw/bt/hci-csr.o
>   CC      hw/char/ipoctal232.o
>   CC      hw/char/escc.o
>   CC      hw/char/parallel.o
>   CC      hw/char/pl011.o
>   CC      hw/char/serial.o
>   CC      hw/char/serial-isa.o
>   CC      hw/char/serial-pci.o
>   CC      hw/char/virtio-console.o
>   CC      hw/char/xilinx_uartlite.o
>   CC      hw/char/cadence_uart.o
>   CC      hw/char/etraxfs_ser.o
>   CC      hw/char/debugcon.o
>   CC      hw/char/grlib_apbuart.o
>   CC      hw/char/imx_serial.o
>   CC      hw/char/lm32_uart.o
>   CC      hw/char/lm32_juart.o
>   CC      hw/char/milkymist-uart.o
>   CC      hw/char/sclpconsole.o
>   CC      hw/char/sclpconsole-lm.o
>   CC      hw/core/qdev.o
>   CC      hw/core/qdev-properties.o
>   CC      hw/core/bus.o
>   CC      hw/core/reset.o
>   CC      hw/core/fw-path-provider.o
>   CC      hw/core/irq.o
>   CC      hw/core/hotplug.o
>   CC      hw/core/nmi.o
>   CC      hw/core/empty_slot.o
>   CC      hw/core/stream.o
>   CC      hw/core/ptimer.o
>   CC      hw/core/sysbus.o
>   CC      hw/core/machine.o
>   CC      hw/core/loader.o
>   CC      hw/core/loader-fit.o
>   CC      hw/core/qdev-properties-system.o
>   CC      hw/core/register.o
>   CC      hw/core/or-irq.o
>   CC      hw/core/platform-bus.o
>   CC      hw/display/ads7846.o
>   CC      hw/display/cirrus_vga.o
>   CC      hw/display/g364fb.o
>   CC      hw/display/jazz_led.o
>   CC      hw/display/pl110.o
>   CC      hw/display/ssd0303.o
>   CC      hw/display/ssd0323.o
>   CC      hw/display/vga-pci.o
>   CC      hw/display/vga-isa.o
>   CC      hw/display/vga-isa-mm.o
>   CC      hw/display/vmware_vga.o
>   CC      hw/display/blizzard.o
>   CC      hw/display/exynos4210_fimd.o
>   CC      hw/display/framebuffer.o
>   CC      hw/display/milkymist-vgafb.o
>   CC      hw/display/tc6393xb.o
>   CC      hw/display/milkymist-tmu2.o
>   CC      hw/dma/puv3_dma.o
>   CC      hw/dma/rc4030.o
>   CC      hw/dma/pl080.o
>   CC      hw/dma/pl330.o
>   CC      hw/dma/i82374.o
>   CC      hw/dma/i8257.o
>   CC      hw/dma/xilinx_axidma.o
>   CC      hw/dma/xlnx-zynq-devcfg.o
>   CC      hw/dma/etraxfs_dma.o
>   CC      hw/dma/sparc32_dma.o
>   CC      hw/dma/sun4m_iommu.o
>   CC      hw/gpio/max7310.o
>   CC      hw/gpio/pl061.o
>   CC      hw/gpio/puv3_gpio.o
>   CC      hw/gpio/zaurus.o
>   CC      hw/gpio/mpc8xxx.o
>   CC      hw/gpio/gpio_key.o
>   CC      hw/i2c/core.o
>   CC      hw/i2c/smbus.o
>   CC      hw/i2c/smbus_eeprom.o
>   CC      hw/i2c/i2c-ddc.o
>   CC      hw/i2c/versatile_i2c.o
>   CC      hw/i2c/smbus_ich9.o
>   CC      hw/i2c/pm_smbus.o
>   CC      hw/i2c/bitbang_i2c.o
>   CC      hw/i2c/exynos4210_i2c.o
>   CC      hw/i2c/imx_i2c.o
>   CC      hw/i2c/aspeed_i2c.o
>   CC      hw/ide/core.o
>   CC      hw/ide/atapi.o
>   CC      hw/ide/qdev.o
>   CC      hw/ide/pci.o
>   CC      hw/ide/isa.o
>   CC      hw/ide/piix.o
>   CC      hw/ide/cmd646.o
>   CC      hw/ide/macio.o
>   CC      hw/ide/mmio.o
>   CC      hw/ide/via.o
>   CC      hw/ide/microdrive.o
>   CC      hw/ide/ahci.o
>   CC      hw/ide/ich.o
>   CC      hw/input/adb.o
>   CC      hw/input/hid.o
>   CC      hw/input/lm832x.o
>   CC      hw/input/pckbd.o
>   CC      hw/input/pl050.o
>   CC      hw/input/ps2.o
>   CC      hw/input/stellaris_input.o
>   CC      hw/input/tsc2005.o
>   CC      hw/input/vmmouse.o
>   CC      hw/input/virtio-input.o
>   CC      hw/input/virtio-input-hid.o
>   CC      hw/input/virtio-input-host.o
>   CC      hw/intc/heathrow_pic.o
>   CC      hw/intc/i8259_common.o
>   CC      hw/intc/i8259.o
>   CC      hw/intc/pl190.o
>   CC      hw/intc/puv3_intc.o
>   CC      hw/intc/xilinx_intc.o
>   CC      hw/intc/etraxfs_pic.o
>   CC      hw/intc/imx_avic.o
>   CC      hw/intc/realview_gic.o
>   CC      hw/intc/lm32_pic.o
>   CC      hw/intc/slavio_intctl.o
>   CC      hw/intc/ioapic_common.o
>   CC      hw/intc/arm_gic_common.o
>   CC      hw/intc/arm_gic.o
>   CC      hw/intc/arm_gicv2m.o
>   CC      hw/intc/arm_gicv3_common.o
>   CC      hw/intc/arm_gicv3.o
>   CC      hw/intc/arm_gicv3_dist.o
>   CC      hw/intc/arm_gicv3_redist.o
>   CC      hw/intc/arm_gicv3_its_common.o
>   CC      hw/intc/openpic.o
>   CC      hw/intc/intc.o
>   CC      hw/ipack/ipack.o
>   CC      hw/ipack/tpci200.o
>   CC      hw/ipmi/ipmi.o
>   CC      hw/ipmi/ipmi_bmc_sim.o
>   CC      hw/ipmi/ipmi_bmc_extern.o
>   CC      hw/ipmi/isa_ipmi_kcs.o
>   CC      hw/ipmi/isa_ipmi_bt.o
>   CC      hw/isa/isa-bus.o
>   CC      hw/isa/apm.o
>   CC      hw/isa/i82378.o
>   CC      hw/isa/pc87312.o
>   CC      hw/isa/piix4.o
>   CC      hw/isa/vt82c686.o
>   CC      hw/mem/pc-dimm.o
>   CC      hw/mem/nvdimm.o
>   CC      hw/misc/applesmc.o
>   CC      hw/misc/max111x.o
>   CC      hw/misc/tmp105.o
>   CC      hw/misc/debugexit.o
>   CC      hw/misc/sga.o
>   CC      hw/misc/pc-testdev.o
>   CC      hw/misc/pci-testdev.o
>   CC      hw/misc/unimp.o
>   CC      hw/misc/arm_l2x0.o
>   CC      hw/misc/arm_integrator_debug.o
>   CC      hw/misc/a9scu.o
>   CC      hw/misc/arm11scu.o
>   CC      hw/misc/puv3_pm.o
>   CC      hw/misc/macio/macio.o
>   CC      hw/misc/macio/cuda.o
>   CC      hw/misc/macio/mac_dbdma.o
>   CC      hw/net/dp8393x.o
>   CC      hw/net/ne2000.o
>   CC      hw/net/eepro100.o
>   CC      hw/net/pcnet-pci.o
>   CC      hw/net/pcnet.o
>   CC      hw/net/e1000x_common.o
>   CC      hw/net/e1000.o
>   CC      hw/net/net_tx_pkt.o
>   CC      hw/net/net_rx_pkt.o
>   CC      hw/net/e1000e_core.o
>   CC      hw/net/e1000e.o
>   CC      hw/net/rtl8139.o
>   CC      hw/net/vmxnet3.o
>   CC      hw/net/smc91c111.o
>   CC      hw/net/lan9118.o
>   CC      hw/net/ne2000-isa.o
>   CC      hw/net/opencores_eth.o
>   CC      hw/net/xgmac.o
>   CC      hw/net/mipsnet.o
>   CC      hw/net/xilinx_axienet.o
>   CC      hw/net/allwinner_emac.o
>   CC      hw/net/cadence_gem.o
>   CC      hw/net/imx_fec.o
>   CC      hw/net/stellaris_enet.o
>   CC      hw/net/lance.o
>   CC      hw/net/ftgmac100.o
>   CC      hw/net/rocker/rocker.o
>   CC      hw/net/rocker/rocker_fp.o
>   CC      hw/net/rocker/rocker_desc.o
>   CC      hw/net/rocker/rocker_world.o
>   CC      hw/net/rocker/rocker_of_dpa.o
>   CC      hw/nvram/ds1225y.o
>   CC      hw/nvram/eeprom93xx.o
>   CC      hw/nvram/fw_cfg.o
>   CC      hw/nvram/chrp_nvram.o
>   CC      hw/nvram/mac_nvram.o
>   CC      hw/pci-bridge/pci_bridge_dev.o
>   CC      hw/pci-bridge/pcie_root_port.o
>   CC      hw/pci-bridge/gen_pcie_root_port.o
>   CC      hw/pci-bridge/pci_expander_bridge.o
>   CC      hw/pci-bridge/xio3130_upstream.o
>   CC      hw/pci-bridge/xio3130_downstream.o
>   CC      hw/pci-bridge/ioh3420.o
>   CC      hw/pci-bridge/i82801b11.o
>   CC      hw/pci-bridge/dec.o
>   CC      hw/pci-host/pam.o
>   CC      hw/pci-host/prep.o
>   CC      hw/pci-host/grackle.o
>   CC      hw/pci-host/uninorth.o
>   CC      hw/pci-host/ppce500.o
>   CC      hw/pci-host/versatile.o
>   CC      hw/pci-host/apb.o
>   CC      hw/pci-host/bonito.o
>   CC      hw/pci-host/piix.o
>   CC      hw/pci-host/q35.o
>   CC      hw/pci-host/gpex.o
>   CC      hw/pci-host/xilinx-pcie.o
>   CC      hw/pci/pci.o
>   CC      hw/pci/msix.o
>   CC      hw/pci/msi.o
>   CC      hw/pci/pci_bridge.o
>   CC      hw/pci/shpc.o
>   CC      hw/pci/pci_host.o
>   CC      hw/pci/slotid_cap.o
>   CC      hw/pci/pcie_host.o
>   CC      hw/pci/pcie_aer.o
>   CC      hw/pci/pcie.o
>   CC      hw/pci/pcie_port.o
>   CC      hw/pci/pci-stub.o
>   CC      hw/pcmcia/pcmcia.o
>   CC      hw/scsi/scsi-disk.o
>   CC      hw/scsi/scsi-generic.o
>   CC      hw/scsi/scsi-bus.o
>   CC      hw/scsi/lsi53c895a.o
>   CC      hw/scsi/mptsas.o
>   CC      hw/scsi/mptconfig.o
>   CC      hw/scsi/mptendian.o
>   CC      hw/scsi/megasas.o
>   CC      hw/scsi/vmw_pvscsi.o
>   CC      hw/scsi/esp.o
>   CC      hw/scsi/esp-pci.o
>   CC      hw/sd/pl181.o
>   CC      hw/sd/ssi-sd.o
>   CC      hw/sd/core.o
>   CC      hw/sd/sdhci.o
>   CC      hw/sd/sd.o
>   CC      hw/smbios/smbios.o
>   CC      hw/smbios/smbios_type_38.o
>   CC      hw/smbios/smbios-stub.o
>   CC      hw/smbios/smbios_type_38-stub.o
>   CC      hw/ssi/pl022.o
>   CC      hw/ssi/ssi.o
>   CC      hw/ssi/xilinx_spi.o
>   CC      hw/ssi/xilinx_spips.o
>   CC      hw/ssi/aspeed_smc.o
>   CC      hw/ssi/stm32f2xx_spi.o
>   CC      hw/timer/arm_timer.o
>   CC      hw/timer/arm_mptimer.o
>   CC      hw/timer/armv7m_systick.o
>   CC      hw/timer/cadence_ttc.o
>   CC      hw/timer/a9gtimer.o
>   CC      hw/timer/ds1338.o
>   CC      hw/timer/hpet.o
>   CC      hw/timer/i8254_common.o
>   CC      hw/timer/i8254.o
>   CC      hw/timer/m48t59.o
>   CC      hw/timer/m48t59-isa.o
>   CC      hw/timer/pl031.o
>   CC      hw/timer/puv3_ost.o
>   CC      hw/timer/twl92230.o
>   CC      hw/timer/xilinx_timer.o
>   CC      hw/timer/slavio_timer.o
>   CC      hw/timer/etraxfs_timer.o
>   CC      hw/timer/grlib_gptimer.o
>   CC      hw/timer/imx_epit.o
>   CC      hw/timer/imx_gpt.o
>   CC      hw/timer/lm32_timer.o
>   CC      hw/timer/milkymist-sysctl.o
>   CC      hw/timer/stm32f2xx_timer.o
>   CC      hw/timer/sun4v-rtc.o
>   CC      hw/timer/aspeed_timer.o
>   CC      hw/usb/combined-packet.o
>   CC      hw/tpm/tpm_tis.o
>   CC      hw/usb/core.o
>   CC      hw/usb/bus.o
>   CC      hw/usb/libhw.o
>   CC      hw/usb/desc.o
>   CC      hw/usb/desc-msos.o
>   CC      hw/usb/hcd-uhci.o
>   CC      hw/usb/hcd-ohci.o
>   CC      hw/usb/hcd-ehci.o
>   CC      hw/usb/hcd-ehci-pci.o
>   CC      hw/usb/hcd-ehci-sysbus.o
>   CC      hw/usb/hcd-xhci.o
>   CC      hw/usb/hcd-xhci-nec.o
>   CC      hw/usb/hcd-musb.o
>   CC      hw/usb/dev-hub.o
>   CC      hw/usb/dev-hid.o
>   CC      hw/usb/dev-wacom.o
>   CC      hw/usb/dev-storage.o
>   CC      hw/usb/dev-uas.o
>   CC      hw/usb/dev-audio.o
>   CC      hw/usb/dev-serial.o
>   CC      hw/usb/dev-network.o
>   CC      hw/usb/dev-bluetooth.o
>   CC      hw/usb/dev-smartcard-reader.o
>   CC      hw/usb/ccid-card-passthru.o
>   CC      hw/usb/ccid-card-emulated.o
>   CC      hw/usb/dev-mtp.o
>   CC      hw/usb/redirect.o
>   CC      hw/usb/quirks.o
>   CC      hw/usb/host-libusb.o
>   CC      hw/usb/host-legacy.o
>   CC      hw/virtio/virtio-rng.o
>   CC      hw/virtio/virtio-pci.o
>   CC      hw/virtio/virtio-bus.o
>   CC      hw/virtio/virtio-mmio.o
>   CC      hw/virtio/vhost-stub.o
>   CC      hw/watchdog/watchdog.o
>   CC      hw/watchdog/wdt_i6300esb.o
>   CC      hw/watchdog/wdt_ib700.o
>   CC      hw/watchdog/wdt_diag288.o
>   CC      hw/watchdog/wdt_aspeed.o
>   CC      migration/migration.o
>   CC      migration/socket.o
>   CC      migration/fd.o
>   CC      migration/exec.o
>   CC      migration/tls.o
>   CC      migration/channel.o
>   CC      migration/savevm.o
>   CC      migration/colo-comm.o
>   CC      migration/colo.o
>   CC      migration/colo-failover.o
>   CC      migration/vmstate.o
>   CC      migration/vmstate-types.o
>   CC      migration/page_cache.o
>   CC      migration/qemu-file.o
>   CC      migration/qemu-file-channel.o
>   CC      migration/xbzrle.o
>   CC      migration/postcopy-ram.o
>   CC      migration/qjson.o
>   CC      net/net.o
>   CC      migration/block.o
>   CC      net/queue.o
>   CC      net/checksum.o
>   CC      net/util.o
>   CC      net/hub.o
>   CC      net/socket.o
>   CC      net/eth.o
>   CC      net/dump.o
>   CC      net/l2tpv3.o
>   CC      net/vhost-user.o
>   CC      net/slirp.o
>   CC      net/filter-buffer.o
>   CC      net/filter.o
>   CC      net/filter-mirror.o
>   CC      net/colo-compare.o
>   CC      net/colo.o
>   CC      net/filter-rewriter.o
>   CC      net/filter-replay.o
>   CC      net/tap.o
>   CC      qom/cpu.o
>   CC      net/tap-linux.o
>   CC      replay/replay.o
>   CC      replay/replay-internal.o
>   CC      replay/replay-events.o
>   CC      replay/replay-time.o
>   CC      replay/replay-input.o
>   CC      replay/replay-char.o
>   CC      replay/replay-snapshot.o
>   CC      replay/replay-net.o
>   CC      replay/replay-audio.o
>   CC      slirp/cksum.o
>   CC      slirp/if.o
>   CC      slirp/ip_icmp.o
>   CC      slirp/ip6_icmp.o
>   CC      slirp/ip6_input.o
>   CC      slirp/ip6_output.o
>   CC      slirp/ip_input.o
>   CC      slirp/dnssearch.o
>   CC      slirp/ip_output.o
>   CC      slirp/dhcpv6.o
>   CC      slirp/mbuf.o
>   CC      slirp/slirp.o
>   CC      slirp/misc.o
>   CC      slirp/sbuf.o
>   CC      slirp/socket.o
>   CC      slirp/tcp_input.o
>   CC      slirp/tcp_output.o
>   CC      slirp/tcp_timer.o
>   CC      slirp/udp.o
>   CC      slirp/tcp_subr.o
>   CC      slirp/udp6.o
>   CC      slirp/bootp.o
>   CC      slirp/tftp.o
>   CC      slirp/arp_table.o
>   CC      slirp/ndp_table.o
>   CC      slirp/ncsi.o
>   CC      ui/keymaps.o
>   CC      ui/console.o
>   CC      ui/cursor.o
>   CC      ui/qemu-pixman.o
>   CC      ui/input.o
>   CC      ui/input-keymap.o
>   CC      ui/input-legacy.o
>   CC      ui/input-linux.o
>   CC      ui/sdl2.o
>   CC      ui/sdl2-input.o
>   CC      ui/sdl2-2d.o
>   CC      ui/sdl2-gl.o
>   CC      ui/x_keymap.o
>   CC      ui/curses.o
>   CC      ui/vnc-enc-zlib.o
>   CC      ui/vnc.o
>   CC      ui/vnc-enc-hextile.o
>   CC      ui/vnc-enc-tight.o
>   CC      ui/vnc-palette.o
>   CC      ui/vnc-enc-zrle.o
>   CC      ui/vnc-auth-vencrypt.o
>   CC      ui/vnc-auth-sasl.o
>   CC      ui/vnc-ws.o
>   CC      ui/vnc-jobs.o
>   CC      ui/gtk.o
>   CC      ui/shader.o
>   VERT    ui/shader/texture-blit-vert.h
>   FRAG    ui/shader/texture-blit-frag.h
>   CC      ui/egl-helpers.o
>   CC      ui/egl-context.o
>   CC      ui/egl-headless.o
>   CC      ui/gtk-gl-area.o
>   CC      chardev/char.o
>   CC      chardev/char-fd.o
>   CC      chardev/char-fe.o
>   CC      chardev/char-file.o
>   CC      chardev/char-io.o
>   CC      chardev/char-mux.o
>   CC      chardev/char-null.o
>   CC      chardev/char-parallel.o
>   CC      chardev/char-pipe.o
>   CC      chardev/char-pty.o
>   CC      chardev/char-ringbuf.o
>   CC      chardev/char-serial.o
>   CC      chardev/char-socket.o
>   CC      chardev/char-stdio.o
>   CC      chardev/char-udp.o
>   CCAS    s390-ccw/start.o
>   CC      s390-ccw/main.o
>   CC      s390-ccw/bootmap.o
>   LINK    tests/qemu-iotests/socket_scm_helper
>   CC      s390-ccw/sclp.o
>   CC      s390-ccw/virtio.o
>   GEN     qemu-doc.html
>   GEN     qemu-doc.txt
>   CC      s390-ccw/virtio-scsi.o
>   GEN     qemu.1
>   BUILD   s390-ccw/s390-ccw.elf
>   GEN     docs/qemu-qmp-ref.html
>   STRIP   s390-ccw/s390-ccw.img
>   GEN     docs/qemu-qmp-ref.txt
>   GEN     docs/qemu-qmp-ref.7
>   GEN     docs/qemu-ga-ref.html
>   GEN     docs/qemu-ga-ref.txt
>   CC      qga/commands.o
>   GEN     docs/qemu-ga-ref.7
>   CC      qga/guest-agent-command-state.o
>   CC      qga/main.o
>   CC      qga/commands-posix.o
>   CC      qga/channel-posix.o
>   CC      qga/qapi-generated/qga-qapi-types.o
>   CC      qga/qapi-generated/qga-qapi-visit.o
>   AR      libqemuutil.a
>   CC      qga/qapi-generated/qga-qmp-marshal.o
>   AR      libqemustub.a
>   CC      qemu-img.o
>   CC      ui/console-gl.o
>   LINK    ivshmem-client
>   LINK    ivshmem-server
>   LINK    qemu-nbd
>   LINK    qemu-io
>   LINK    fsdev/virtfs-proxy-helper
>   LINK    qemu-bridge-helper
>   GEN     aarch64-softmmu/hmp-commands.h
>   GEN     alpha-softmmu/hmp-commands.h
>   GEN     alpha-softmmu/hmp-commands-info.h
>   GEN     alpha-softmmu/config-target.h
>   CC      alpha-softmmu/exec.o
>   GEN     aarch64-softmmu/hmp-commands-info.h
>   GEN     aarch64-softmmu/config-target.h
>   GEN     arm-softmmu/hmp-commands.h
>   GEN     cris-softmmu/hmp-commands.h
>   GEN     arm-softmmu/hmp-commands-info.h
>   CC      aarch64-softmmu/exec.o
>   GEN     cris-softmmu/hmp-commands-info.h
>   GEN     cris-softmmu/config-target.h
>   GEN     arm-softmmu/config-target.h
>   CC      cris-softmmu/exec.o
>   CC      arm-softmmu/exec.o
>   CC      alpha-softmmu/translate-all.o
>   CC      aarch64-softmmu/translate-all.o
>   CC      cris-softmmu/translate-all.o
>   CC      alpha-softmmu/cpu-exec.o
>   CC      arm-softmmu/translate-all.o
>   CC      aarch64-softmmu/cpu-exec.o
>   CC      cris-softmmu/cpu-exec.o
>   CC      arm-softmmu/cpu-exec.o
>   CC      alpha-softmmu/translate-common.o
>   CC      alpha-softmmu/cpu-exec-common.o
>   CC      aarch64-softmmu/translate-common.o
>   CC      cris-softmmu/translate-common.o
>   CC      alpha-softmmu/tcg/tcg.o
>   CC      aarch64-softmmu/cpu-exec-common.o
>   CC      cris-softmmu/cpu-exec-common.o
>   CC      arm-softmmu/translate-common.o
>   CC      aarch64-softmmu/tcg/tcg.o
>   CC      arm-softmmu/cpu-exec-common.o
>   CC      cris-softmmu/tcg/tcg.o
>   CC      arm-softmmu/tcg/tcg.o
>   CC      alpha-softmmu/tcg/tcg-op.o
>   CC      aarch64-softmmu/tcg/tcg-op.o
>   CC      cris-softmmu/tcg/tcg-op.o
>   CC      arm-softmmu/tcg/tcg-op.o
>   CC      alpha-softmmu/tcg/optimize.o
>   CC      cris-softmmu/tcg/optimize.o
>   CC      alpha-softmmu/tcg/tcg-common.o
>   CC      aarch64-softmmu/tcg/optimize.o
>   CC      alpha-softmmu/fpu/softfloat.o
>   CC      arm-softmmu/tcg/optimize.o
>   CC      cris-softmmu/tcg/tcg-common.o
>   CC      cris-softmmu/fpu/softfloat.o
>   CC      aarch64-softmmu/tcg/tcg-common.o
>   CC      aarch64-softmmu/fpu/softfloat.o
>   CC      arm-softmmu/tcg/tcg-common.o
>   CC      arm-softmmu/fpu/softfloat.o
>   CC      alpha-softmmu/disas.o
>   CC      alpha-softmmu/tcg-runtime.o
>   CC      alpha-softmmu/hax-stub.o
>   CC      cris-softmmu/disas.o
>   CC      aarch64-softmmu/disas.o
>   CC      cris-softmmu/tcg-runtime.o
>   CC      alpha-softmmu/kvm-stub.o
>   CC      arm-softmmu/disas.o
>   CC      alpha-softmmu/arch_init.o
>   CC      aarch64-softmmu/tcg-runtime.o
>   CC      cris-softmmu/hax-stub.o
>   CC      arm-softmmu/tcg-runtime.o
>   CC      alpha-softmmu/cpus.o
>   GEN     arm-softmmu/gdbstub-xml.c
>   CC      cris-softmmu/kvm-stub.o
>   CC      arm-softmmu/hax-stub.o
>   GEN     aarch64-softmmu/gdbstub-xml.c
>   CC      cris-softmmu/arch_init.o
>   CC      arm-softmmu/kvm-stub.o
>   CC      cris-softmmu/cpus.o
>   CC      alpha-softmmu/monitor.o
>   CC      aarch64-softmmu/hax-stub.o
>   CC      arm-softmmu/arch_init.o
>   CC      cris-softmmu/monitor.o
>   CC      arm-softmmu/cpus.o
>   CC      aarch64-softmmu/kvm-stub.o
>   CC      aarch64-softmmu/arch_init.o
>   CC      arm-softmmu/monitor.o
>   CC      alpha-softmmu/gdbstub.o
>   CC      aarch64-softmmu/cpus.o
>   CC      cris-softmmu/gdbstub.o
>   CC      alpha-softmmu/balloon.o
>   CC      alpha-softmmu/ioport.o
>   CC      cris-softmmu/balloon.o
>   CC      aarch64-softmmu/monitor.o
>   CC      cris-softmmu/ioport.o
>   CC      alpha-softmmu/numa.o
>   CC      arm-softmmu/gdbstub.o
>   CC      cris-softmmu/numa.o
>   CC      aarch64-softmmu/gdbstub.o
>   CC      alpha-softmmu/qtest.o
>   CC      aarch64-softmmu/balloon.o
>   CC      cris-softmmu/qtest.o
>   CC      arm-softmmu/balloon.o
>   CC      aarch64-softmmu/ioport.o
>   CC      alpha-softmmu/bootdevice.o
>   CC      cris-softmmu/bootdevice.o
>   CC      arm-softmmu/ioport.o
>   CC      alpha-softmmu/memory.o
>   CC      aarch64-softmmu/numa.o
>   CC      cris-softmmu/memory.o
>   CC      arm-softmmu/numa.o
>   CC      aarch64-softmmu/qtest.o
>   CC      arm-softmmu/qtest.o
>   CC      cris-softmmu/cputlb.o
>   CC      alpha-softmmu/cputlb.o
>   CC      aarch64-softmmu/bootdevice.o
>   CC      arm-softmmu/bootdevice.o
>   CC      aarch64-softmmu/memory.o
>   CC      arm-softmmu/memory.o
>   CC      cris-softmmu/memory_mapping.o
>   CC      aarch64-softmmu/cputlb.o
>   CC      alpha-softmmu/memory_mapping.o
>   CC      cris-softmmu/dump.o
>   CC      arm-softmmu/cputlb.o
>   CC      alpha-softmmu/dump.o
>   CC      cris-softmmu/migration/ram.o
>   CC      alpha-softmmu/migration/ram.o
>   CC      aarch64-softmmu/memory_mapping.o
>   CC      aarch64-softmmu/dump.o
>   CC      alpha-softmmu/hw/9pfs/virtio-9p-device.o
>   CC      cris-softmmu/hw/core/generic-loader.o
>   CC      arm-softmmu/memory_mapping.o
>   CC      alpha-softmmu/hw/block/virtio-blk.o
>   CC      arm-softmmu/dump.o
>   CC      cris-softmmu/hw/core/null-machine.o
>   CC      aarch64-softmmu/migration/ram.o
>   CC      cris-softmmu/hw/cpu/core.o
>   CC      alpha-softmmu/hw/block/dataplane/virtio-blk.o
>   CC      cris-softmmu/hw/net/etraxfs_eth.o
>   CC      alpha-softmmu/hw/char/virtio-serial-bus.o
>   CC      arm-softmmu/migration/ram.o
>   CC      aarch64-softmmu/hw/9pfs/virtio-9p-device.o
>   CC      cris-softmmu/hw/net/vhost_net.o
>   CC      alpha-softmmu/hw/core/generic-loader.o
>   CC      cris-softmmu/hw/net/rocker/qmp-norocker.o
>   CC      aarch64-softmmu/hw/adc/stm32f2xx_adc.o
>   CC      cris-softmmu/hw/vfio/common.o
>   CC      arm-softmmu/hw/9pfs/virtio-9p-device.o
>   CC      alpha-softmmu/hw/core/null-machine.o
>   CC      aarch64-softmmu/hw/block/virtio-blk.o
>   CC      arm-softmmu/hw/adc/stm32f2xx_adc.o
>   CC      alpha-softmmu/hw/cpu/core.o
>   CC      arm-softmmu/hw/block/virtio-blk.o
>   CC      cris-softmmu/hw/vfio/platform.o
>   CC      aarch64-softmmu/hw/block/dataplane/virtio-blk.o
>   CC      alpha-softmmu/hw/display/vga.o
>   CC      cris-softmmu/hw/vfio/spapr.o
>   CC      aarch64-softmmu/hw/char/exynos4210_uart.o
>   CC      arm-softmmu/hw/block/dataplane/virtio-blk.o
>   CC      aarch64-softmmu/hw/char/omap_uart.o
>   CC      cris-softmmu/hw/cris/boot.o
>   CC      cris-softmmu/hw/cris/axis_dev88.o
>   CC      aarch64-softmmu/hw/char/digic-uart.o
>   CC      arm-softmmu/hw/char/exynos4210_uart.o
>   CC      aarch64-softmmu/hw/char/stm32f2xx_usart.o
>   CC      cris-softmmu/target/cris/translate.o
>   CC      alpha-softmmu/hw/display/virtio-gpu.o
>   CC      aarch64-softmmu/hw/char/bcm2835_aux.o
>   CC      arm-softmmu/hw/char/omap_uart.o
>   CC      arm-softmmu/hw/char/digic-uart.o
>   CC      aarch64-softmmu/hw/char/virtio-serial-bus.o
>   CC      arm-softmmu/hw/char/stm32f2xx_usart.o
>   CC      arm-softmmu/hw/char/bcm2835_aux.o
>   CC      alpha-softmmu/hw/display/virtio-gpu-3d.o
>   CC      aarch64-softmmu/hw/core/generic-loader.o
>   CC      cris-softmmu/target/cris/op_helper.o
>   CC      arm-softmmu/hw/char/virtio-serial-bus.o
>   CC      aarch64-softmmu/hw/core/null-machine.o
>   CC      alpha-softmmu/hw/display/virtio-gpu-pci.o
>   CC      arm-softmmu/hw/core/generic-loader.o
>   CC      aarch64-softmmu/hw/cpu/arm11mpcore.o
>   CC      cris-softmmu/target/cris/helper.o
>   CC      alpha-softmmu/hw/misc/ivshmem.o
>   CC      aarch64-softmmu/hw/cpu/realview_mpcore.o
>   CC      arm-softmmu/hw/core/null-machine.o
>   CC      cris-softmmu/target/cris/cpu.o
>   CC      arm-softmmu/hw/cpu/arm11mpcore.o
>   CC      alpha-softmmu/hw/misc/edu.o
>   CC      aarch64-softmmu/hw/cpu/a9mpcore.o
>   CC      arm-softmmu/hw/cpu/realview_mpcore.o
>   CC      cris-softmmu/target/cris/gdbstub.o
>   CC      cris-softmmu/target/cris/mmu.o
>   CC      alpha-softmmu/hw/net/virtio-net.o
>   CC      aarch64-softmmu/hw/cpu/a15mpcore.o
>   CC      arm-softmmu/hw/cpu/a9mpcore.o
>   CC      cris-softmmu/target/cris/machine.o
>   GEN     trace/generated-helpers.c
>   CC      aarch64-softmmu/hw/cpu/core.o
>   CC      cris-softmmu/trace/control-target.o
>   CC      arm-softmmu/hw/cpu/a15mpcore.o
>   CC      cris-softmmu/trace/generated-helpers.o
>   CC      aarch64-softmmu/hw/display/omap_dss.o
>   CC      arm-softmmu/hw/cpu/core.o
>   CC      alpha-softmmu/hw/net/vhost_net.o
>   LINK    cris-softmmu/qemu-system-cris
>   CC      alpha-softmmu/hw/scsi/virtio-scsi.o
>   CC      aarch64-softmmu/hw/display/omap_lcdc.o
>   CC      arm-softmmu/hw/display/omap_dss.o
>   CC      alpha-softmmu/hw/scsi/virtio-scsi-dataplane.o
>   CC      alpha-softmmu/hw/scsi/vhost-scsi-common.o
>   CC      arm-softmmu/hw/display/omap_lcdc.o
>   CC      aarch64-softmmu/hw/display/pxa2xx_lcd.o
>   CC      alpha-softmmu/hw/scsi/vhost-scsi.o
>   CC      arm-softmmu/hw/display/pxa2xx_lcd.o
>   CC      arm-softmmu/hw/display/bcm2835_fb.o
>   CC      alpha-softmmu/hw/timer/mc146818rtc.o
>   CC      aarch64-softmmu/hw/display/bcm2835_fb.o
>   CC      arm-softmmu/hw/display/vga.o
>   CC      alpha-softmmu/hw/vfio/common.o
>   CC      arm-softmmu/hw/display/virtio-gpu.o
>   CC      aarch64-softmmu/hw/display/vga.o
>   CC      alpha-softmmu/hw/vfio/pci.o
>   CC      arm-softmmu/hw/display/virtio-gpu-3d.o
>   CC      aarch64-softmmu/hw/display/virtio-gpu.o
>   GEN     i386-softmmu/hmp-commands.h
>   GEN     i386-softmmu/hmp-commands-info.h
>   CC      alpha-softmmu/hw/vfio/pci-quirks.o
>   GEN     i386-softmmu/config-target.h
>   CC      arm-softmmu/hw/display/virtio-gpu-pci.o
>   CC      i386-softmmu/exec.o
>   CC      aarch64-softmmu/hw/display/virtio-gpu-3d.o
>   CC      arm-softmmu/hw/dma/omap_dma.o
>   CC      alpha-softmmu/hw/vfio/platform.o
>   CC      aarch64-softmmu/hw/display/virtio-gpu-pci.o
>   CC      alpha-softmmu/hw/vfio/spapr.o
>   CC      arm-softmmu/hw/dma/soc_dma.o
>   CC      aarch64-softmmu/hw/display/dpcd.o
>   CC      i386-softmmu/translate-all.o
>   CC      aarch64-softmmu/hw/display/xlnx_dp.o
>   CC      alpha-softmmu/hw/virtio/virtio.o
>   CC      arm-softmmu/hw/dma/pxa2xx_dma.o
>   CC      arm-softmmu/hw/dma/bcm2835_dma.o
>   CC      aarch64-softmmu/hw/dma/xlnx_dpdma.o
>   CC      i386-softmmu/cpu-exec.o
>   CC      arm-softmmu/hw/gpio/omap_gpio.o
>   CC      alpha-softmmu/hw/virtio/virtio-balloon.o
>   CC      aarch64-softmmu/hw/dma/omap_dma.o
>   CC      i386-softmmu/translate-common.o
>   CC      arm-softmmu/hw/gpio/imx_gpio.o
>   CC      i386-softmmu/cpu-exec-common.o
>   CC      alpha-softmmu/hw/virtio/vhost.o
>   CC      aarch64-softmmu/hw/dma/soc_dma.o
>   CC      i386-softmmu/tcg/tcg.o
>   CC      arm-softmmu/hw/gpio/bcm2835_gpio.o
>   CC      aarch64-softmmu/hw/dma/pxa2xx_dma.o
>   CC      alpha-softmmu/hw/virtio/vhost-backend.o
>   CC      arm-softmmu/hw/i2c/omap_i2c.o
>   CC      aarch64-softmmu/hw/dma/bcm2835_dma.o
>   CC      alpha-softmmu/hw/virtio/vhost-user.o
>   CC      arm-softmmu/hw/input/pxa2xx_keypad.o
>   CC      aarch64-softmmu/hw/gpio/omap_gpio.o
>   CC      alpha-softmmu/hw/virtio/vhost-vsock.o
>   CC      arm-softmmu/hw/input/tsc210x.o
>   CC      aarch64-softmmu/hw/gpio/imx_gpio.o
>   CC      alpha-softmmu/hw/virtio/virtio-crypto.o
>   CC      aarch64-softmmu/hw/gpio/bcm2835_gpio.o
>   CC      i386-softmmu/tcg/tcg-op.o
>   CC      arm-softmmu/hw/intc/armv7m_nvic.o
>   CC      alpha-softmmu/hw/virtio/virtio-crypto-pci.o
>   CC      aarch64-softmmu/hw/i2c/omap_i2c.o
>   CC      arm-softmmu/hw/intc/exynos4210_gic.o
>   CC      alpha-softmmu/hw/alpha/dp264.o
>   CC      arm-softmmu/hw/intc/exynos4210_combiner.o
>   CC      aarch64-softmmu/hw/input/pxa2xx_keypad.o
>   CC      arm-softmmu/hw/intc/omap_intc.o
>   CC      alpha-softmmu/hw/alpha/pci.o
>   CC      aarch64-softmmu/hw/input/tsc210x.o
>   CC      arm-softmmu/hw/intc/bcm2835_ic.o
>   CC      alpha-softmmu/hw/alpha/typhoon.o
>   CC      arm-softmmu/hw/intc/bcm2836_control.o
>   CC      alpha-softmmu/target/alpha/machine.o
>   CC      aarch64-softmmu/hw/intc/armv7m_nvic.o
>   CC      arm-softmmu/hw/intc/allwinner-a10-pic.o
>   CC      alpha-softmmu/target/alpha/translate.o
>   CC      i386-softmmu/tcg/optimize.o
>   CC      arm-softmmu/hw/intc/aspeed_vic.o
>   CC      aarch64-softmmu/hw/intc/exynos4210_gic.o
>   CC      arm-softmmu/hw/intc/arm_gicv3_cpuif.o
>   CC      aarch64-softmmu/hw/intc/exynos4210_combiner.o
>   CC      i386-softmmu/tcg/tcg-common.o
>   CC      alpha-softmmu/target/alpha/helper.o
>   CC      aarch64-softmmu/hw/intc/omap_intc.o
>   CC      i386-softmmu/fpu/softfloat.o
>   CC      alpha-softmmu/target/alpha/cpu.o
>   CC      aarch64-softmmu/hw/intc/bcm2835_ic.o
>   CC      alpha-softmmu/target/alpha/int_helper.o
>   CC      arm-softmmu/hw/misc/ivshmem.o
>   CC      alpha-softmmu/target/alpha/fpu_helper.o
>   CC      aarch64-softmmu/hw/intc/bcm2836_control.o
>   CC      arm-softmmu/hw/misc/arm_sysctl.o
>   CC      aarch64-softmmu/hw/intc/allwinner-a10-pic.o
>   CC      arm-softmmu/hw/misc/cbus.o
>   CC      alpha-softmmu/target/alpha/vax_helper.o
>   CC      aarch64-softmmu/hw/intc/aspeed_vic.o
>   CC      alpha-softmmu/target/alpha/sys_helper.o
>   CC      i386-softmmu/disas.o
>   CC      arm-softmmu/hw/misc/exynos4210_pmu.o
>   CC      aarch64-softmmu/hw/intc/arm_gicv3_cpuif.o
>   CC      alpha-softmmu/target/alpha/mem_helper.o
>   CC      arm-softmmu/hw/misc/exynos4210_clk.o
>   CC      i386-softmmu/tcg-runtime.o
>   CC      arm-softmmu/hw/misc/imx_ccm.o
>   CC      alpha-softmmu/target/alpha/gdbstub.o
>   GEN     trace/generated-helpers.c
>   CC      alpha-softmmu/trace/control-target.o
>   CC      aarch64-softmmu/hw/misc/ivshmem.o
>   CC      arm-softmmu/hw/misc/imx31_ccm.o
>   GEN     i386-softmmu/gdbstub-xml.c
>   CC      aarch64-softmmu/hw/misc/arm_sysctl.o
>   CC      alpha-softmmu/trace/generated-helpers.o
>   CC      i386-softmmu/hax-stub.o
>   CC      arm-softmmu/hw/misc/imx25_ccm.o
>   LINK    alpha-softmmu/qemu-system-alpha
>   CC      aarch64-softmmu/hw/misc/cbus.o
>   CC      arm-softmmu/hw/misc/imx6_ccm.o
>   CC      i386-softmmu/kvm-stub.o
>   CC      aarch64-softmmu/hw/misc/exynos4210_pmu.o
>   CC      i386-softmmu/arch_init.o
>   CC      arm-softmmu/hw/misc/imx6_src.o
>   CC      aarch64-softmmu/hw/misc/exynos4210_clk.o
>   CC      i386-softmmu/cpus.o
>   CC      aarch64-softmmu/hw/misc/imx_ccm.o
>   CC      arm-softmmu/hw/misc/mst_fpga.o
>   CC      aarch64-softmmu/hw/misc/imx31_ccm.o
>   CC      arm-softmmu/hw/misc/omap_clk.o
>   GEN     lm32-softmmu/hmp-commands.h
>   CC      aarch64-softmmu/hw/misc/imx25_ccm.o
>   GEN     lm32-softmmu/hmp-commands-info.h
>   CC      i386-softmmu/monitor.o
>   CC      arm-softmmu/hw/misc/omap_gpmc.o
>   GEN     lm32-softmmu/config-target.h
>   CC      lm32-softmmu/exec.o
>   CC      aarch64-softmmu/hw/misc/imx6_ccm.o
>   CC      arm-softmmu/hw/misc/omap_l4.o
>   CC      aarch64-softmmu/hw/misc/imx6_src.o
>   CC      arm-softmmu/hw/misc/omap_sdrc.o
>   CC      aarch64-softmmu/hw/misc/mst_fpga.o
>   CC      arm-softmmu/hw/misc/omap_tap.o
>   CC      arm-softmmu/hw/misc/bcm2835_mbox.o
>   CC      aarch64-softmmu/hw/misc/omap_clk.o
>   CC      arm-softmmu/hw/misc/bcm2835_property.o
>   CC      i386-softmmu/gdbstub.o
>   CC      arm-softmmu/hw/misc/bcm2835_rng.o
>   CC      aarch64-softmmu/hw/misc/omap_gpmc.o
>   CC      arm-softmmu/hw/misc/zynq_slcr.o
>   CC      lm32-softmmu/translate-all.o
>   CC      aarch64-softmmu/hw/misc/omap_l4.o
>   CC      arm-softmmu/hw/misc/zynq-xadc.o
>   CC      i386-softmmu/balloon.o
>   CC      arm-softmmu/hw/misc/stm32f2xx_syscfg.o
>   CC      i386-softmmu/ioport.o
>   CC      aarch64-softmmu/hw/misc/omap_sdrc.o
>   CC      i386-softmmu/numa.o
>   CC      lm32-softmmu/cpu-exec.o
>   CC      arm-softmmu/hw/misc/edu.o
>   CC      aarch64-softmmu/hw/misc/omap_tap.o
>   CC      i386-softmmu/qtest.o
>   CC      aarch64-softmmu/hw/misc/bcm2835_mbox.o
>   CC      lm32-softmmu/translate-common.o
>   CC      aarch64-softmmu/hw/misc/bcm2835_property.o
>   CC      arm-softmmu/hw/misc/aspeed_scu.o
>   CC      i386-softmmu/bootdevice.o
>   CC      lm32-softmmu/cpu-exec-common.o
>   CC      aarch64-softmmu/hw/misc/bcm2835_rng.o
>   CC      arm-softmmu/hw/misc/aspeed_sdmc.o
>   CC      lm32-softmmu/tcg/tcg.o
>   CC      i386-softmmu/memory.o
>   CC      aarch64-softmmu/hw/misc/zynq_slcr.o
>   CC      arm-softmmu/hw/net/virtio-net.o
>   CC      aarch64-softmmu/hw/misc/zynq-xadc.o
>   CC      aarch64-softmmu/hw/misc/stm32f2xx_syscfg.o
>   CC      arm-softmmu/hw/net/vhost_net.o
>   CC      i386-softmmu/cputlb.o
>   CC      aarch64-softmmu/hw/misc/edu.o
>   CC      arm-softmmu/hw/pcmcia/pxa2xx.o
>   CC      lm32-softmmu/tcg/tcg-op.o
>   CC      aarch64-softmmu/hw/misc/auxbus.o
>   CC      arm-softmmu/hw/scsi/virtio-scsi.o
>   CC      aarch64-softmmu/hw/misc/aspeed_scu.o
>   CC      arm-softmmu/hw/scsi/virtio-scsi-dataplane.o
>   CC      i386-softmmu/memory_mapping.o
>   CC      aarch64-softmmu/hw/misc/aspeed_sdmc.o
>   CC      arm-softmmu/hw/scsi/vhost-scsi-common.o
>   CC      i386-softmmu/dump.o
>   CC      aarch64-softmmu/hw/net/virtio-net.o
>   CC      arm-softmmu/hw/scsi/vhost-scsi.o
>   CC      arm-softmmu/hw/sd/omap_mmc.o
>   CC      lm32-softmmu/tcg/optimize.o
>   CC      aarch64-softmmu/hw/net/vhost_net.o
>   CC      i386-softmmu/migration/ram.o
>   CC      arm-softmmu/hw/sd/pxa2xx_mmci.o
>   CC      aarch64-softmmu/hw/pcmcia/pxa2xx.o
>   CC      lm32-softmmu/tcg/tcg-common.o
>   CC      arm-softmmu/hw/sd/bcm2835_sdhost.o
>   CC      aarch64-softmmu/hw/scsi/virtio-scsi.o
>   CC      i386-softmmu/hw/9pfs/virtio-9p-device.o
>   CC      lm32-softmmu/fpu/softfloat.o
>   CC      arm-softmmu/hw/ssi/omap_spi.o
>   CC      aarch64-softmmu/hw/scsi/virtio-scsi-dataplane.o
>   CC      i386-softmmu/hw/block/virtio-blk.o
>   CC      arm-softmmu/hw/ssi/imx_spi.o
>   CC      aarch64-softmmu/hw/scsi/vhost-scsi-common.o
>   CC      i386-softmmu/hw/block/dataplane/virtio-blk.o
>   CC      arm-softmmu/hw/timer/exynos4210_mct.o
>   CC      aarch64-softmmu/hw/scsi/vhost-scsi.o
>   CC      i386-softmmu/hw/char/virtio-serial-bus.o
>   CC      arm-softmmu/hw/timer/exynos4210_pwm.o
>   CC      aarch64-softmmu/hw/sd/omap_mmc.o
>   CC      i386-softmmu/hw/core/generic-loader.o
>   CC      arm-softmmu/hw/timer/exynos4210_rtc.o
>   CC      i386-softmmu/hw/core/null-machine.o
>   CC      aarch64-softmmu/hw/sd/pxa2xx_mmci.o
>   CC      lm32-softmmu/disas.o
>   CC      arm-softmmu/hw/timer/omap_gptimer.o
>   CC      lm32-softmmu/tcg-runtime.o
>   CC      i386-softmmu/hw/cpu/core.o
>   CC      aarch64-softmmu/hw/sd/bcm2835_sdhost.o
>   CC      arm-softmmu/hw/timer/omap_synctimer.o
>   CC      i386-softmmu/hw/display/vga.o
>   CC      lm32-softmmu/hax-stub.o
>   CC      arm-softmmu/hw/timer/pxa2xx_timer.o
>   CC      aarch64-softmmu/hw/ssi/omap_spi.o
>   CC      lm32-softmmu/kvm-stub.o
>   CC      arm-softmmu/hw/timer/digic-timer.o
>   CC      aarch64-softmmu/hw/ssi/imx_spi.o
>   CC      lm32-softmmu/arch_init.o
>   CC      aarch64-softmmu/hw/timer/exynos4210_mct.o
>   CC      i386-softmmu/hw/display/virtio-gpu.o
>   CC      lm32-softmmu/cpus.o
>   CC      arm-softmmu/hw/timer/allwinner-a10-pit.o
>   CC      aarch64-softmmu/hw/timer/exynos4210_pwm.o
>   CC      arm-softmmu/hw/usb/tusb6010.o
>   CC      i386-softmmu/hw/display/virtio-gpu-3d.o
>   CC      lm32-softmmu/monitor.o
>   CC      aarch64-softmmu/hw/timer/exynos4210_rtc.o
>   CC      arm-softmmu/hw/vfio/common.o
>   CC      aarch64-softmmu/hw/timer/omap_gptimer.o
>   CC      i386-softmmu/hw/display/virtio-gpu-pci.o
>   CC      arm-softmmu/hw/vfio/pci.o
>   CC      aarch64-softmmu/hw/timer/omap_synctimer.o
>   CC      i386-softmmu/hw/display/virtio-vga.o
>   CC      aarch64-softmmu/hw/timer/pxa2xx_timer.o
>   CC      lm32-softmmu/gdbstub.o
>   CC      i386-softmmu/hw/intc/apic.o
>   CC      aarch64-softmmu/hw/timer/digic-timer.o
>   CC      arm-softmmu/hw/vfio/pci-quirks.o
>   CC      i386-softmmu/hw/intc/apic_common.o
>   CC      lm32-softmmu/balloon.o
>   CC      aarch64-softmmu/hw/timer/allwinner-a10-pit.o
>   CC      i386-softmmu/hw/intc/ioapic.o
>   CC      i386-softmmu/hw/isa/lpc_ich9.o
>   CC      lm32-softmmu/ioport.o
>   CC      aarch64-softmmu/hw/usb/tusb6010.o
>   CC      i386-softmmu/hw/misc/vmport.o
>   CC      arm-softmmu/hw/vfio/platform.o
>   CC      lm32-softmmu/numa.o
>   CC      aarch64-softmmu/hw/vfio/common.o
>   CC      i386-softmmu/hw/misc/ivshmem.o
>   CC      arm-softmmu/hw/vfio/calxeda-xgmac.o
>   CC      lm32-softmmu/qtest.o
>   CC      i386-softmmu/hw/misc/pvpanic.o
>   CC      arm-softmmu/hw/vfio/amd-xgbe.o
>   CC      i386-softmmu/hw/misc/edu.o
>   CC      aarch64-softmmu/hw/vfio/pci.o
>   CC      i386-softmmu/hw/net/virtio-net.o
>   CC      lm32-softmmu/bootdevice.o
>   CC      arm-softmmu/hw/vfio/spapr.o
>   CC      lm32-softmmu/memory.o
>   CC      arm-softmmu/hw/virtio/virtio.o
>   CC      i386-softmmu/hw/net/vhost_net.o
>   CC      aarch64-softmmu/hw/vfio/pci-quirks.o
>   CC      i386-softmmu/hw/scsi/virtio-scsi.o
>   CC      aarch64-softmmu/hw/vfio/platform.o
>   CC      i386-softmmu/hw/scsi/virtio-scsi-dataplane.o
>   CC      aarch64-softmmu/hw/vfio/calxeda-xgmac.o
>   CC      i386-softmmu/hw/scsi/vhost-scsi-common.o
>   CC      arm-softmmu/hw/virtio/virtio-balloon.o
>   CC      lm32-softmmu/cputlb.o
>   CC      i386-softmmu/hw/scsi/vhost-scsi.o
>   CC      aarch64-softmmu/hw/vfio/amd-xgbe.o
>   CC      arm-softmmu/hw/virtio/vhost.o
>   CC      i386-softmmu/hw/timer/mc146818rtc.o
>   CC      aarch64-softmmu/hw/vfio/spapr.o
>   CC      aarch64-softmmu/hw/virtio/virtio.o
>   CC      lm32-softmmu/memory_mapping.o
>   CC      i386-softmmu/hw/vfio/common.o
>   CC      arm-softmmu/hw/virtio/vhost-backend.o
>   CC      lm32-softmmu/dump.o
>   CC      arm-softmmu/hw/virtio/vhost-user.o
>   CC      i386-softmmu/hw/vfio/pci.o
>   CC      aarch64-softmmu/hw/virtio/virtio-balloon.o
>   CC      arm-softmmu/hw/virtio/vhost-vsock.o
>   CC      lm32-softmmu/migration/ram.o
>   CC      aarch64-softmmu/hw/virtio/vhost.o
>   CC      arm-softmmu/hw/virtio/virtio-crypto.o
>   CC      arm-softmmu/hw/virtio/virtio-crypto-pci.o
>   CC      arm-softmmu/hw/arm/boot.o
>   CC      i386-softmmu/hw/vfio/pci-quirks.o
>   CC      lm32-softmmu/hw/core/generic-loader.o
>   CC      aarch64-softmmu/hw/virtio/vhost-backend.o
>   CC      arm-softmmu/hw/arm/collie.o
>   CC      aarch64-softmmu/hw/virtio/vhost-user.o
>   CC      lm32-softmmu/hw/core/null-machine.o
>   CC      arm-softmmu/hw/arm/exynos4_boards.o
>   CC      i386-softmmu/hw/vfio/platform.o
>   CC      lm32-softmmu/hw/cpu/core.o
>   CC      arm-softmmu/hw/arm/gumstix.o
>   CC      aarch64-softmmu/hw/virtio/vhost-vsock.o
>   CC      lm32-softmmu/hw/input/milkymist-softusb.o
>   CC      i386-softmmu/hw/vfio/spapr.o
>   CC      aarch64-softmmu/hw/virtio/virtio-crypto.o
>   CC      arm-softmmu/hw/arm/highbank.o
>   CC      i386-softmmu/hw/virtio/virtio.o
>   CC      arm-softmmu/hw/arm/digic_boards.o
>   CC      lm32-softmmu/hw/misc/milkymist-hpdmc.o
>   CC      aarch64-softmmu/hw/virtio/virtio-crypto-pci.o
>   CC      arm-softmmu/hw/arm/integratorcp.o
>   CC      lm32-softmmu/hw/misc/milkymist-pfpu.o
>   CC      i386-softmmu/hw/virtio/virtio-balloon.o
>   CC      aarch64-softmmu/hw/arm/boot.o
>   CC      arm-softmmu/hw/arm/mainstone.o
>   CC      i386-softmmu/hw/virtio/vhost.o
>   CC      lm32-softmmu/hw/net/milkymist-minimac2.o
>   CC      aarch64-softmmu/hw/arm/collie.o
>   CC      arm-softmmu/hw/arm/musicpal.o
>   CC      aarch64-softmmu/hw/arm/exynos4_boards.o
>   CC      lm32-softmmu/hw/net/vhost_net.o
>   CC      arm-softmmu/hw/arm/nseries.o
>   CC      i386-softmmu/hw/virtio/vhost-backend.o
>   CC      aarch64-softmmu/hw/arm/gumstix.o
>   CC      lm32-softmmu/hw/net/rocker/qmp-norocker.o
>   CC      i386-softmmu/hw/virtio/vhost-user.o
>   CC      aarch64-softmmu/hw/arm/highbank.o
>   CC      lm32-softmmu/hw/sd/milkymist-memcard.o
>   CC      i386-softmmu/hw/virtio/vhost-vsock.o
>   CC      arm-softmmu/hw/arm/omap_sx1.o
>   CC      aarch64-softmmu/hw/arm/digic_boards.o
>   CC      lm32-softmmu/hw/vfio/common.o
>   CC      i386-softmmu/hw/virtio/virtio-crypto.o
>   CC      aarch64-softmmu/hw/arm/integratorcp.o
>   CC      arm-softmmu/hw/arm/palm.o
>   CC      lm32-softmmu/hw/vfio/platform.o
>   CC      i386-softmmu/hw/virtio/virtio-crypto-pci.o
>   CC      lm32-softmmu/hw/vfio/spapr.o
>   CC      aarch64-softmmu/hw/arm/mainstone.o
>   CC      arm-softmmu/hw/arm/realview.o
>   CC      lm32-softmmu/hw/lm32/lm32_boards.o
>   CC      i386-softmmu/hw/i386/multiboot.o
>   CC      aarch64-softmmu/hw/arm/musicpal.o
>   CC      lm32-softmmu/hw/lm32/milkymist.o
>   CC      arm-softmmu/hw/arm/spitz.o
>   CC      i386-softmmu/hw/i386/pc.o
>   CC      lm32-softmmu/target/lm32/translate.o
>   CC      aarch64-softmmu/hw/arm/nseries.o
>   CC      i386-softmmu/hw/i386/pc_piix.o
>   CC      arm-softmmu/hw/arm/stellaris.o
>   CC      lm32-softmmu/target/lm32/op_helper.o
>   CC      arm-softmmu/hw/arm/tosa.o
>   CC      aarch64-softmmu/hw/arm/omap_sx1.o
>   CC      i386-softmmu/hw/i386/pc_q35.o
>   CC      lm32-softmmu/target/lm32/helper.o
>   CC      arm-softmmu/hw/arm/versatilepb.o
>   CC      lm32-softmmu/target/lm32/cpu.o
>   CC      aarch64-softmmu/hw/arm/palm.o
>   CC      lm32-softmmu/target/lm32/gdbstub.o
>   CC      i386-softmmu/hw/i386/pc_sysfw.o
>   CC      lm32-softmmu/target/lm32/lm32-semi.o
>   CC      arm-softmmu/hw/arm/vexpress.o
>   CC      i386-softmmu/hw/i386/x86-iommu.o
>   CC      aarch64-softmmu/hw/arm/realview.o
>   CC      arm-softmmu/hw/arm/virt.o
>   CC      lm32-softmmu/target/lm32/machine.o
>   CC      i386-softmmu/hw/i386/intel_iommu.o
>   GEN     trace/generated-helpers.c
>   CC      lm32-softmmu/trace/control-target.o
>   CC      aarch64-softmmu/hw/arm/spitz.o
>   CC      lm32-softmmu/trace/generated-helpers.o
>   CC      arm-softmmu/hw/arm/xilinx_zynq.o
>   CC      aarch64-softmmu/hw/arm/stellaris.o
>   LINK    lm32-softmmu/qemu-system-lm32
> /var/tmp/patchew-tester-tmp-xibqn8r3/src/hw/i386/intel_iommu.c: In func=
tion =E2=80=98vtd_interrupt_remap_msi=E2=80=99:
> /var/tmp/patchew-tester-tmp-xibqn8r3/src/hw/i386/intel_iommu.c:2574:5: =
error: =E2=80=98ioapic_irq=E2=80=99 may be used uninitialized in this fun=
ction [-Werror=3Dmaybe-uninitialized]
>      trace_vtd_ir_remap_msi(ioapic_irq ? "IOAPIC" : "MSI",
>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>                             origin->address, origin->data,
>                             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>                             translated->address, translated->data);
>                             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Yes it's valid after patch 3. Will fix and repost. Sorry.

--=20
Peter Xu
