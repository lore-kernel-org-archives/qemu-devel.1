Received: from eggs.gnu.org ([2001:4830:134:3::10]:42569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fYBE8-0006Z4-MY
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 10:15:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fYBDg-0000de-UA
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 10:15:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49584 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fYBDf-0000bt-KA
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 10:14:52 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3968F26AB2
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 14:14:51 +0000 (UTC)
Date: Wed, 27 Jun 2018 15:14:47 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180627141447.GB6623@stefanha-x1.localdomain>
References: <20180619194549.15584-1-ehabkost@redhat.com>
	<152944919404.795.18163324770109790166@d39dc562802a>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8GpibOaaTibBMecb"
Content-Disposition: inline
In-Reply-To: <152944919404.795.18163324770109790166@d39dc562802a>
Subject: Re: [Qemu-devel] [PATCH] simpletrace: Convert name from mapping
 record to str
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, famz@redhat.com, crosa@redhat.com


--8GpibOaaTibBMecb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 19, 2018 at 03:59:54PM -0700, no-reply@patchew.org wrote:
> This series failed build test on s390x host. Please find the details belo=
w.

This looks like an unrelated failure (environment issue?) that can be
ignored.

>=20
> Type: series
> Message-id: 20180619194549.15584-1-ehabkost@redhat.com
> Subject: [Qemu-devel] [PATCH] simpletrace: Convert name from mapping reco=
rd to str
>=20
> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> #!/bin/bash
> # Testing script will be invoked under the git checkout with
> # HEAD pointing to a commit that has the patches applied on top of "base"
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
> Switched to a new branch 'test'
> d4f19623cb simpletrace: Convert name from mapping record to str
>=20
> =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
> =3D=3D=3D ENV =3D=3D=3D
> LANG=3Den_US.UTF-8
> XDG_SESSION_ID=3D238931
> USER=3Dfam
> PWD=3D/var/tmp/patchew-tester-tmp-4ppomfuh/src
> HOME=3D/home/fam
> SHELL=3D/bin/sh
> SHLVL=3D2
> PATCHEW=3D/home/fam/patchew/patchew-cli -s http://patchew.org --nodebug
> LOGNAME=3Dfam
> DBUS_SESSION_BUS_ADDRESS=3Dunix:path=3D/run/user/1012/bus
> XDG_RUNTIME_DIR=3D/run/user/1012
> PATH=3D/usr/bin:/bin
> _=3D/usr/bin/env
> =3D=3D=3D PACKAGES =3D=3D=3D
> gpg-pubkey-873529b8-54e386ff
> glibc-debuginfo-common-2.24-10.fc25.s390x
> fedora-release-26-1.noarch
> dejavu-sans-mono-fonts-2.35-4.fc26.noarch
> xemacs-filesystem-21.5.34-22.20170124hgf412e9f093d4.fc26.noarch
> bash-4.4.12-7.fc26.s390x
> libSM-1.2.2-5.fc26.s390x
> libmpc-1.0.2-6.fc26.s390x
> libaio-0.3.110-7.fc26.s390x
> libverto-0.2.6-7.fc26.s390x
> perl-Scalar-List-Utils-1.48-1.fc26.s390x
> iptables-libs-1.6.1-2.fc26.s390x
> tcl-8.6.6-2.fc26.s390x
> libxshmfence-1.2-4.fc26.s390x
> expect-5.45-23.fc26.s390x
> perl-Thread-Queue-3.12-1.fc26.noarch
> perl-encoding-2.19-6.fc26.s390x
> keyutils-1.5.10-1.fc26.s390x
> gmp-devel-6.1.2-4.fc26.s390x
> enchant-1.6.0-16.fc26.s390x
> python-gobject-base-3.24.1-1.fc26.s390x
> python3-enchant-1.6.10-1.fc26.noarch
> python-lockfile-0.11.0-6.fc26.noarch
> python2-pyparsing-2.1.10-3.fc26.noarch
> python2-lxml-4.1.1-1.fc26.s390x
> librados2-10.2.7-2.fc26.s390x
> trousers-lib-0.3.13-7.fc26.s390x
> libdatrie-0.2.9-4.fc26.s390x
> libsoup-2.58.2-1.fc26.s390x
> passwd-0.79-9.fc26.s390x
> bind99-libs-9.9.10-3.P3.fc26.s390x
> python3-rpm-4.13.0.2-1.fc26.s390x
> systemd-233-7.fc26.s390x
> virglrenderer-0.6.0-1.20170210git76b3da97b.fc26.s390x
> s390utils-ziomon-1.36.1-3.fc26.s390x
> s390utils-osasnmpd-1.36.1-3.fc26.s390x
> libXrandr-1.5.1-2.fc26.s390x
> libglvnd-glx-1.0.0-1.fc26.s390x
> texlive-ifxetex-svn19685.0.5-33.fc26.2.noarch
> texlive-psnfss-svn33946.9.2a-33.fc26.2.noarch
> texlive-dvipdfmx-def-svn40328-33.fc26.2.noarch
> texlive-natbib-svn20668.8.31b-33.fc26.2.noarch
> texlive-xdvi-bin-svn40750-33.20160520.fc26.2.s390x
> texlive-cm-svn32865.0-33.fc26.2.noarch
> texlive-beton-svn15878.0-33.fc26.2.noarch
> texlive-fpl-svn15878.1.002-33.fc26.2.noarch
> texlive-mflogo-svn38628-33.fc26.2.noarch
> texlive-texlive-docindex-svn41430-33.fc26.2.noarch
> texlive-luaotfload-bin-svn34647.0-33.20160520.fc26.2.noarch
> texlive-koma-script-svn41508-33.fc26.2.noarch
> texlive-pst-tree-svn24142.1.12-33.fc26.2.noarch
> texlive-breqn-svn38099.0.98d-33.fc26.2.noarch
> texlive-xetex-svn41438-33.fc26.2.noarch
> gstreamer1-plugins-bad-free-1.12.3-1.fc26.s390x
> xorg-x11-font-utils-7.5-33.fc26.s390x
> ghostscript-fonts-5.50-36.fc26.noarch
> libXext-devel-1.3.3-5.fc26.s390x
> libusbx-devel-1.0.21-2.fc26.s390x
> libglvnd-devel-1.0.0-1.fc26.s390x
> emacs-25.3-3.fc26.s390x
> alsa-lib-devel-1.1.4.1-1.fc26.s390x
> kbd-2.0.4-2.fc26.s390x
> dconf-0.26.0-2.fc26.s390x
> mc-4.8.19-5.fc26.s390x
> doxygen-1.8.13-9.fc26.s390x
> dpkg-1.18.24-1.fc26.s390x
> libtdb-1.3.13-1.fc26.s390x
> python2-pynacl-1.1.1-1.fc26.s390x
> perl-Filter-1.58-1.fc26.s390x
> python2-pip-9.0.1-11.fc26.noarch
> dnf-2.7.5-2.fc26.noarch
> bind-license-9.11.2-1.P1.fc26.noarch
> libtasn1-4.13-1.fc26.s390x
> cpp-7.3.1-2.fc26.s390x
> pkgconf-1.3.12-2.fc26.s390x
> python2-fedora-0.10.0-1.fc26.noarch
> cmake-filesystem-3.10.1-11.fc26.s390x
> python3-requests-kerberos-0.12.0-1.fc26.noarch
> libmicrohttpd-0.9.59-1.fc26.s390x
> GeoIP-GeoLite-data-2018.01-1.fc26.noarch
> python2-libs-2.7.14-7.fc26.s390x
> libidn2-2.0.4-3.fc26.s390x
> p11-kit-devel-0.23.10-1.fc26.s390x
> perl-Errno-1.25-396.fc26.s390x
> libdrm-2.4.90-2.fc26.s390x
> sssd-common-1.16.1-1.fc26.s390x
> boost-random-1.63.0-11.fc26.s390x
> urw-fonts-2.4-24.fc26.noarch
> ccache-3.3.6-1.fc26.s390x
> glibc-debuginfo-2.24-10.fc25.s390x
> dejavu-fonts-common-2.35-4.fc26.noarch
> bind99-license-9.9.10-3.P3.fc26.noarch
> ncurses-libs-6.0-8.20170212.fc26.s390x
> libpng-1.6.28-2.fc26.s390x
> libICE-1.0.9-9.fc26.s390x
> perl-Text-ParseWords-3.30-366.fc26.noarch
> libtool-ltdl-2.4.6-17.fc26.s390x
> libselinux-utils-2.6-7.fc26.s390x
> userspace-rcu-0.9.3-2.fc26.s390x
> perl-Class-Inspector-1.31-3.fc26.noarch
> keyutils-libs-devel-1.5.10-1.fc26.s390x
> isl-0.16.1-1.fc26.s390x
> libsecret-0.18.5-3.fc26.s390x
> compat-openssl10-1.0.2m-1.fc26.s390x
> python3-iniparse-0.4-24.fc26.noarch
> python3-dateutil-2.6.0-3.fc26.noarch
> python3-firewall-0.4.4.5-1.fc26.noarch
> python-enum34-1.1.6-1.fc26.noarch
> python2-pygments-2.2.0-7.fc26.noarch
> python2-dockerfile-parse-0.0.7-1.fc26.noarch
> perl-Net-SSLeay-1.81-1.fc26.s390x
> hostname-3.18-2.fc26.s390x
> libtirpc-1.0.2-0.fc26.s390x
> rpm-build-libs-4.13.0.2-1.fc26.s390x
> libutempter-1.1.6-9.fc26.s390x
> systemd-pam-233-7.fc26.s390x
> libXinerama-1.1.3-7.fc26.s390x
> mesa-libGL-17.2.4-2.fc26.s390x
> texlive-amsfonts-svn29208.3.04-33.fc26.2.noarch
> texlive-caption-svn41409-33.fc26.2.noarch
> texlive-enumitem-svn24146.3.5.2-33.fc26.2.noarch
> texlive-pdftex-def-svn22653.0.06d-33.fc26.2.noarch
> texlive-xdvi-svn40768-33.fc26.2.noarch
> texlive-courier-svn35058.0-33.fc26.2.noarch
> texlive-charter-svn15878.0-33.fc26.2.noarch
> texlive-graphics-def-svn41879-33.fc26.2.noarch
> texlive-mfnfss-svn19410.0-33.fc26.2.noarch
> texlive-texlive-en-svn41185-33.fc26.2.noarch
> texlive-ifplatform-svn21156.0.4-33.fc26.2.noarch
> texlive-ms-svn29849.0-33.fc26.2.noarch
> texlive-pst-tools-svn34067.0.05-33.fc26.2.noarch
> texlive-powerdot-svn38984-33.fc26.2.noarch
> texlive-xetexconfig-svn41133-33.fc26.2.noarch
> libvdpau-1.1.1-4.fc26.s390x
> zlib-devel-1.2.11-2.fc26.s390x
> gdk-pixbuf2-devel-2.36.9-1.fc26.s390x
> libX11-devel-1.6.5-2.fc26.s390x
> libglvnd-core-devel-1.0.0-1.fc26.s390x
> SDL2-devel-2.0.7-2.fc26.s390x
> webkitgtk3-2.4.11-5.fc26.s390x
> grubby-8.40-4.fc26.s390x
> uboot-tools-2017.05-4.fc26.s390x
> cracklib-dicts-2.9.6-5.fc26.s390x
> texinfo-6.3-3.fc26.s390x
> time-1.7-52.fc26.s390x
> python2-deltarpm-3.6-19.fc26.s390x
> python2-setuptools-37.0.0-1.fc26.noarch
> python2-dnf-2.7.5-2.fc26.noarch
> groff-base-1.22.3-10.fc26.s390x
> python2-GitPython-2.1.7-2.fc26.noarch
> cups-libs-2.2.2-8.fc26.s390x
> bind-libs-lite-9.11.2-1.P1.fc26.s390x
> libpkgconf-1.3.12-2.fc26.s390x
> java-1.8.0-openjdk-headless-1.8.0.161-5.b14.fc26.s390x
> python3-dnf-plugin-system-upgrade-2.0.5-1.fc26.noarch
> dtc-1.4.6-1.fc26.s390x
> glusterfs-client-xlators-3.10.11-1.fc26.s390x
> libunistring-0.9.9-1.fc26.s390x
> python3-libs-3.6.4-3.fc26.s390x
> perl-IO-1.36-396.fc26.s390x
> libXcursor-1.1.15-1.fc26.s390x
> libdrm-devel-2.4.90-2.fc26.s390x
> boost-thread-1.63.0-11.fc26.s390x
> strace-4.21-1.fc26.s390x
> boost-iostreams-1.63.0-11.fc26.s390x
> gpg-pubkey-efe550f5-5220ba41
> gpg-pubkey-81b46521-55b3ca9a
> filesystem-3.2-40.fc26.s390x
> basesystem-11-3.fc26.noarch
> js-jquery-3.2.1-1.fc26.noarch
> libidn-1.33-2.fc26.s390x
> libogg-1.3.2-6.fc26.s390x
> slang-2.3.1a-2.fc26.s390x
> apr-1.6.3-1.fc26.s390x
> libxkbcommon-0.7.1-3.fc26.s390x
> less-487-3.fc26.s390x
> lttng-ust-2.9.0-2.fc26.s390x
> OpenEXR-libs-2.2.0-6.fc26.s390x
> ipset-libs-6.29-3.fc26.s390x
> perl-XML-XPath-1.42-1.fc26.noarch
> lua-filesystem-1.6.3-3.fc24.s390x
> gstreamer1-1.12.3-1.fc26.s390x
> libpwquality-1.3.0-8.fc26.s390x
> gettext-libs-0.19.8.1-9.fc26.s390x
> python3-chardet-2.3.0-3.fc26.noarch
> python3-slip-dbus-0.6.4-6.fc26.noarch
> python-chardet-2.3.0-3.fc26.noarch
> python2-pyasn1-0.2.3-1.fc26.noarch
> python-slip-dbus-0.6.4-6.fc26.noarch
> libarchive-3.2.2-4.fc26.s390x
> libbabeltrace-1.5.2-2.fc26.s390x
> cdparanoia-libs-10.2-22.fc26.s390x
> gpgme-1.8.0-12.fc26.s390x
> python2-gpg-1.8.0-12.fc26.s390x
> shadow-utils-4.3.1-3.fc26.s390x
> cryptsetup-libs-1.7.5-1.fc26.s390x
> kpartx-0.4.9-88.fc26.s390x
> libXi-1.7.9-2.fc26.s390x
> texlive-tetex-svn41059-33.fc26.2.noarch
> texlive-tools-svn40934-33.fc26.2.noarch
> texlive-bibtex-bin-svn40473-33.20160520.fc26.2.s390x
> texlive-mfware-bin-svn40473-33.20160520.fc26.2.s390x
> texlive-underscore-svn18261.0-33.fc26.2.noarch
> texlive-avantgar-svn31835.0-33.fc26.2.noarch
> texlive-anysize-svn15878.0-33.fc26.2.noarch
> texlive-lineno-svn21442.4.41-33.fc26.2.noarch
> texlive-mathpazo-svn15878.1.003-33.fc26.2.noarch
> texlive-soul-svn15878.2.4-33.fc26.2.noarch
> texlive-luatexbase-svn38550-33.fc26.2.noarch
> texlive-listings-svn37534.1.6-33.fc26.2.noarch
> texlive-pstricks-svn41321-33.fc26.2.noarch
> texlive-metalogo-svn18611.0.12-33.fc26.2.noarch
> texlive-dvipdfmx-svn41149-33.fc26.2.noarch
> kbd-legacy-2.0.4-2.fc26.noarch
> ghostscript-x11-9.20-10.fc26.s390x
> libXrender-devel-0.9.10-2.fc26.s390x
> libxkbcommon-devel-0.7.1-3.fc26.s390x
> mesa-libGL-devel-17.2.4-2.fc26.s390x
> usbredir-devel-0.7.1-3.fc26.s390x
> libcap-devel-2.25-5.fc26.s390x
> brlapi-devel-0.6.6-5.fc26.s390x
> python3-pygpgme-0.3-22.fc26.s390x
> pinentry-0.9.7-3.fc26.s390x
> qemu-sanity-check-nodeps-1.1.5-6.fc26.s390x
> libldb-1.1.29-5.fc26.s390x
> libwayland-cursor-1.13.0-3.fc26.s390x
> pulseaudio-libs-devel-11.1-7.fc26.s390x
> json-c-0.12.1-5.fc26.s390x
> libgcrypt-1.8.2-1.fc26.s390x
> libgo-devel-7.3.1-2.fc26.s390x
> ca-certificates-2018.2.22-1.0.fc26.noarch
> python2-sphinx-1.5.6-1.fc26.noarch
> dnsmasq-2.76-6.fc26.s390x
> perl-Module-CoreList-5.20180120-1.fc26.noarch
> pcre-8.41-6.fc26.s390x
> net-snmp-libs-5.7.3-27.fc26.s390x
> gnutls-dane-3.5.18-2.fc26.s390x
> glusterfs-devel-3.10.11-1.fc26.s390x
> libsss_nss_idmap-1.16.1-1.fc26.s390x
> elfutils-0.170-4.fc26.s390x
> nss-devel-3.36.0-1.0.fc26.s390x
> perl-open-1.10-396.fc26.noarch
> ethtool-4.15-1.fc26.s390x
> gpg-pubkey-34ec9cba-54e38751
> gpg-pubkey-030d5aed-55b577f0
> setup-2.10.5-2.fc26.noarch
> lato-fonts-2.015-3.fc26.noarch
> web-assets-filesystem-5-5.fc26.noarch
> libsepol-2.6-2.fc26.s390x
> libcap-2.25-5.fc26.s390x
> tcp_wrappers-libs-7.6-85.fc26.s390x
> libnl3-3.3.0-1.fc26.s390x
> pixman-0.34.0-3.fc26.s390x
> lzo-2.08-9.fc26.s390x
> libnl3-cli-3.3.0-1.fc26.s390x
> gpm-libs-1.20.7-10.fc26.s390x
> iso-codes-3.74-2.fc26.noarch
> ipset-6.29-3.fc26.s390x
> lua-term-0.07-1.fc25.s390x
> libdb-utils-5.3.28-24.fc26.s390x
> dbus-glib-0.108-2.fc26.s390x
> pam-1.3.0-2.fc26.s390x
> avahi-glib-0.6.32-7.fc26.s390x
> python2-dateutil-2.6.0-3.fc26.noarch
> python3-asn1crypto-0.23.0-1.fc26.noarch
> python3-slip-0.6.4-6.fc26.noarch
> python-backports-ssl_match_hostname-3.5.0.1-4.fc26.noarch
> python2-pyOpenSSL-16.2.0-6.fc26.noarch
> python-slip-0.6.4-6.fc26.noarch
> nss-pem-1.0.3-3.fc26.s390x
> fipscheck-1.5.0-1.fc26.s390x
> cyrus-sasl-lib-2.1.26-32.fc26.s390x
> python3-kerberos-1.2.5-3.fc26.s390x
> rpmconf-1.0.19-1.fc26.noarch
> libsemanage-2.6-4.fc26.s390x
> device-mapper-libs-1.02.137-6.fc26.s390x
> yum-3.4.3-512.fc26.noarch
> device-mapper-multipath-0.4.9-88.fc26.s390x
> libXtst-1.2.3-2.fc26.s390x
> libXxf86vm-1.1.4-4.fc26.s390x
> texlive-amsmath-svn41561-33.fc26.2.noarch
> texlive-xkeyval-svn35741.2.7a-33.fc26.2.noarch
> texlive-bibtex-svn40768-33.fc26.2.noarch
> texlive-mfware-svn40768-33.fc26.2.noarch
> texlive-wasy-svn35831.0-33.fc26.2.noarch
> texlive-bookman-svn31835.0-33.fc26.2.noarch
> texlive-babel-english-svn30264.3.3p-33.fc26.2.noarch
> texlive-fix2col-svn38770-33.fc26.2.noarch
> texlive-mdwtools-svn15878.1.05.4-33.fc26.2.noarch
> texlive-tex-gyre-math-svn41264-33.fc26.2.noarch
> texlive-luaotfload-svn40902-33.fc26.2.noarch
> texlive-showexpl-svn32737.v0.3l-33.fc26.2.noarch
> texlive-pstricks-add-svn40744-33.fc26.2.noarch
> texlive-l3experimental-svn41163-33.fc26.2.noarch
> texlive-xetex-bin-svn41091-33.20160520.fc26.2.s390x
> kbd-misc-2.0.4-2.fc26.noarch
> libpng-devel-1.6.28-2.fc26.s390x
> ghostscript-core-9.20-10.fc26.s390x
> libXfixes-devel-5.0.3-2.fc26.s390x
> libverto-devel-0.2.6-7.fc26.s390x
> mesa-libEGL-devel-17.2.4-2.fc26.s390x
> popt-devel-1.16-12.fc26.s390x
> readline-devel-7.0-5.fc26.s390x
> cyrus-sasl-devel-2.1.26-32.fc26.s390x
> sendmail-8.15.2-19.fc26.s390x
> systemd-bootchart-231-3.fc26.s390x
> perl-IO-Socket-SSL-2.049-1.fc26.noarch
> python2-enchant-1.6.10-1.fc26.noarch
> perl-generators-1.10-2.fc26.noarch
> createrepo-0.10.3-11.fc26.noarch
> pulseaudio-libs-glib2-11.1-7.fc26.s390x
> dhcp-libs-4.3.5-10.fc26.s390x
> libtiff-4.0.9-1.fc26.s390x
> python-srpm-macros-3-21.fc26.noarch
> libtalloc-2.1.11-1.fc26.s390x
> nfs-utils-2.2.1-4.rc2.fc26.s390x
> qt5-srpm-macros-5.9.4-2.fc26.noarch
> python2-dnf-plugins-core-2.1.5-4.fc26.noarch
> mariadb-libs-10.1.30-2.fc26.s390x
> bind-libs-9.11.2-1.P1.fc26.s390x
> acpica-tools-20180105-1.fc26.s390x
> perl-podlators-4.09-3.fc26.noarch
> glusterfs-3.10.11-1.fc26.s390x
> nss-sysinit-3.36.0-1.0.fc26.s390x
> gnutls-c++-3.5.18-2.fc26.s390x
> perl-macros-5.24.3-396.fc26.s390x
> sssd-client-1.16.1-1.fc26.s390x
> elfutils-devel-0.170-4.fc26.s390x
> kernel-4.15.12-201.fc26.s390x
> vim-minimal-8.0.1553-1.fc26.s390x
> desktop-file-utils-0.23-6.fc26.s390x
> fontpackages-filesystem-1.44-18.fc26.noarch
> vte-profile-0.48.4-1.fc26.s390x
> texlive-kpathsea-doc-svn41139-33.fc26.2.noarch
> zlib-1.2.11-2.fc26.s390x
> readline-7.0-5.fc26.s390x
> libattr-2.4.47-18.fc26.s390x
> libglvnd-1.0.0-1.fc26.s390x
> lz4-libs-1.8.0-1.fc26.s390x
> perl-File-Path-2.12-367.fc26.noarch
> perl-Unicode-EastAsianWidth-1.33-9.fc26.noarch
> hunspell-1.5.4-2.fc26.s390x
> libasyncns-0.8-11.fc26.s390x
> libnetfilter_conntrack-1.0.6-2.fc26.s390x
> perl-Storable-2.56-368.fc26.s390x
> autoconf-2.69-24.fc26.noarch
> device-mapper-persistent-data-0.6.3-5.fc26.s390x
> quota-4.03-9.fc26.s390x
> crypto-policies-20170606-1.git7c32281.fc26.noarch
> glib2-2.52.3-2.fc26.s390x
> python2-idna-2.5-1.fc26.noarch
> python2-libcomps-0.1.8-3.fc26.s390x
> gsettings-desktop-schemas-3.24.1-1.fc26.s390x
> javapackages-tools-4.7.0-17.fc26.noarch
> libselinux-python3-2.6-7.fc26.s390x
> python-backports-1.0-9.fc26.s390x
> python2-cryptography-2.0.2-2.fc26.s390x
> libselinux-python-2.6-7.fc26.s390x
> Lmod-7.5.3-1.fc26.s390x
> fipscheck-lib-1.5.0-1.fc26.s390x
> libuser-0.62-6.fc26.s390x
> npth-1.5-1.fc26.s390x
> packagedb-cli-2.14.1-2.fc26.noarch
> ustr-1.0.4-22.fc26.s390x
> device-mapper-1.02.137-6.fc26.s390x
> polkit-pkla-compat-0.1-8.fc26.s390x
> fakeroot-1.22-1.fc26.s390x
> libXmu-1.1.2-5.fc26.s390x
> cairo-gobject-1.14.10-1.fc26.s390x
> texlive-booktabs-svn40846-33.fc26.2.noarch
> texlive-dvips-bin-svn40987-33.20160520.fc26.2.s390x
> texlive-float-svn15878.1.3d-33.fc26.2.noarch
> texlive-tex-svn40793-33.fc26.2.noarch
> texlive-fancyref-svn15878.0.9c-33.fc26.2.noarch
> texlive-manfnt-font-svn35799.0-33.fc26.2.noarch
> texlive-cmap-svn41168-33.fc26.2.noarch
> texlive-hyph-utf8-svn41189-33.fc26.2.noarch
> texlive-paralist-svn39247-33.fc26.2.noarch
> texlive-trimspaces-svn15878.1.1-33.fc26.2.noarch
> texlive-tipa-svn29349.1.3-33.fc26.2.noarch
> texlive-l3packages-svn41246-33.fc26.2.noarch
> texlive-pst-pdf-svn31660.1.1v-33.fc26.2.noarch
> texlive-tex-gyre-svn18651.2.004-33.fc26.2.noarch
> texlive-beamer-svn36461.3.36-33.fc26.2.noarch
> gd-2.2.5-1.fc26.s390x
> gc-devel-7.6.0-2.fc26.s390x
> libXft-devel-2.3.2-5.fc26.s390x
> rpm-devel-4.13.0.2-1.fc26.s390x
> bluez-libs-devel-5.46-6.fc26.s390x
> trousers-0.3.13-7.fc26.s390x
> iproute-tc-4.11.0-1.fc26.s390x
> libgnome-keyring-3.12.0-8.fc26.s390x
> perl-File-ShareDir-1.102-8.fc26.noarch
> python2-paramiko-2.2.1-1.fc26.noarch
> python2-openidc-client-0.4.0-1.20171113git54dee6e.fc26.noarch
> openssh-server-7.5p1-4.fc26.s390x
> pulseaudio-libs-11.1-7.fc26.s390x
> python2-bodhi-2.12.2-3.fc26.noarch
> lua-libs-5.3.4-7.fc26.s390x
> dhcp-common-4.3.5-10.fc26.noarch
> python3-pip-9.0.1-11.fc26.noarch
> python2-py-1.4.34-1.fc26.noarch
> glibc-common-2.25-13.fc26.s390x
> webkitgtk4-jsc-2.18.6-1.fc26.s390x
> glibc-devel-2.25-13.fc26.s390x
> pcre2-10.23-13.fc26.s390x
> linux-firmware-20171215-82.git2451bb22.fc26.noarch
> libfdt-devel-1.4.6-1.fc26.s390x
> audit-2.8.2-1.fc26.s390x
> perl-Socket-2.027-1.fc26.s390x
> nosync-1.0-6.fc26.s390x
> redhat-rpm-config-65-1.fc26.noarch
> freetype-2.7.1-10.fc26.s390x
> gnutls-3.5.18-2.fc26.s390x
> sqlite-3.20.1-2.fc26.s390x
> pcre-devel-8.41-6.fc26.s390x
> fedpkg-1.32-1.fc26.noarch
> gnutls-devel-3.5.18-2.fc26.s390x
> python2-pytz-2017.2-7.fc26.noarch
> gsm-1.0.17-2.fc26.s390x
> gpg-pubkey-95a43f54-5284415a
> gpg-pubkey-fdb19c98-56fd6333
> gpg-pubkey-64dab85d-57d33e22
> firewalld-filesystem-0.4.4.5-1.fc26.noarch
> xkeyboard-config-2.21-3.fc26.noarch
> texlive-texlive-common-doc-svn40682-33.fc26.2.noarch
> ncurses-base-6.0-8.20170212.fc26.noarch
> libselinux-2.6-7.fc26.s390x
> bzip2-libs-1.0.6-22.fc26.s390x
> libdb-5.3.28-24.fc26.s390x
> file-libs-5.30-11.fc26.s390x
> libxslt-1.1.29-1.fc26.s390x
> gdbm-1.13-1.fc26.s390x
> libepoxy-1.4.3-1.fc26.s390x
> libpsl-0.18.0-1.fc26.s390x
> perl-Carp-1.40-366.fc26.noarch
> e2fsprogs-libs-1.43.4-2.fc26.s390x
> libmnl-1.0.4-2.fc26.s390x
> openjpeg2-2.2.0-3.fc26.s390x
> perl-PathTools-3.63-367.fc26.s390x
> perl-File-Temp-0.230.400-2.fc26.noarch
> perl-XML-Parser-2.44-6.fc26.s390x
> libss-1.43.4-2.fc26.s390x
> ilmbase-2.2.0-8.fc26.s390x
> fuse-libs-2.9.7-2.fc26.s390x
> libdaemon-0.14-11.fc26.s390x
> libbasicobjects-0.1.1-34.fc26.s390x
> iptables-1.6.1-2.fc26.s390x
> perl-TermReadKey-2.37-2.fc26.s390x
> perl-Term-ANSIColor-4.06-2.fc26.noarch
> perl-libintl-perl-1.26-2.fc26.s390x
> usbredir-0.7.1-3.fc26.s390x
> fftw-libs-double-3.3.5-4.fc26.s390x
> libiscsi-1.15.0-3.fc26.s390x
> ttmkfdir-3.0.9-49.fc26.s390x
> texlive-base-2016-33.20160520.fc26.1.noarch
> python2-six-1.10.0-9.fc26.noarch
> atk-2.24.0-1.fc26.s390x
> python2-kitchen-1.2.4-6.fc26.noarch
> guile-2.0.14-1.fc26.s390x
> pyxattr-0.5.3-10.fc26.s390x
> libyaml-0.1.7-2.fc26.s390x
> python3-PyYAML-3.12-3.fc26.s390x
> openssh-7.5p1-4.fc26.s390x
> openssl-1.1.0g-1.fc26.s390x
> gawk-4.1.4-6.fc26.s390x
> openldap-2.4.45-2.fc26.s390x
> NetworkManager-libnm-1.8.2-4.fc26.s390x
> python2-urllib3-1.20-2.fc26.noarch
> python3-py-1.4.34-1.fc26.noarch
> perl-ExtUtils-Command-7.24-3.fc26.noarch
> tzdata-2018c-1.fc26.noarch
> libcrypt-nss-2.25-13.fc26.s390x
> libstdc++-devel-7.3.1-2.fc26.s390x
> rpcbind-0.2.4-8.rc3.fc26.s390x
> gdb-headless-8.0.1-36.fc26.s390x
> python3-dnf-plugins-extras-common-2.0.5-1.fc26.noarch
> glibc-headers-2.25-13.fc26.s390x
> libfdt-1.4.6-1.fc26.s390x
> wget-1.19.4-1.fc26.s390x
> mariadb-common-10.1.30-2.fc26.s390x
> python2-dnf-plugin-migrate-2.1.5-4.fc26.noarch
> pcre2-devel-10.23-13.fc26.s390x
> perl-threads-shared-1.58-1.fc26.s390x
> gcc-c++-7.3.1-2.fc26.s390x
> ImageMagick-libs-6.9.9.27-1.fc26.s390x
> poppler-0.52.0-11.fc26.s390x
> perl-Data-Dumper-2.161-4.fc26.s390x
> python2-dnf-plugins-extras-common-2.0.5-1.fc26.noarch
> gcc-debuginfo-7.3.1-2.fc26.s390x
> krb5-libs-1.15.2-7.fc26.s390x
> nspr-devel-4.19.0-1.fc26.s390x
> nss-softokn-3.36.0-1.0.fc26.s390x
> libsss_idmap-1.16.1-1.fc26.s390x
> systemtap-runtime-3.2-7.fc26.s390x
> gnupg2-2.2.5-1.fc26.s390x
> python2-gluster-3.10.11-1.fc26.s390x
> sqlite-devel-3.20.1-2.fc26.s390x
> git-2.13.6-3.fc26.s390x
> libtevent-0.9.36-1.fc26.s390x
> elfutils-libs-0.170-4.fc26.s390x
> systemtap-3.2-7.fc26.s390x
> vim-enhanced-8.0.1553-1.fc26.s390x
> gnupg2-smime-2.2.5-1.fc26.s390x
> libcurl-devel-7.53.1-16.fc26.s390x
> python2-sssdconfig-1.16.1-1.fc26.noarch
> patch-2.7.6-3.fc26.s390x
> fedora-repos-26-3.noarch
> python3-mock-2.0.0-4.fc26.noarch
> libgudev-232-1.fc26.s390x
> python3-javapackages-4.7.0-17.fc26.noarch
> python3-ply-3.9-3.fc26.noarch
> python3-systemd-234-1.fc26.s390x
> python3-requests-2.13.0-1.fc26.noarch
> blktrace-1.1.0-4.fc26.s390x
> python2-asn1crypto-0.23.0-1.fc26.noarch
> python2-cffi-1.9.1-2.fc26.s390x
> python2-sphinx_rtd_theme-0.2.4-1.fc26.noarch
> lua-json-1.3.2-7.fc26.noarch
> libcephfs1-10.2.7-2.fc26.s390x
> glib-networking-2.50.0-2.fc26.s390x
> libedit-3.1-17.20160618cvs.fc26.s390x
> libverto-libev-0.2.6-7.fc26.s390x
> libserf-1.3.9-3.fc26.s390x
> python2-kerberos-1.2.5-3.fc26.s390x
> libsrtp-1.5.4-4.fc26.s390x
> lzo-minilzo-2.08-9.fc26.s390x
> librepo-1.8.0-1.fc26.s390x
> sg3_utils-1.42-1.fc26.s390x
> policycoreutils-2.6-6.fc26.s390x
> lvm2-2.02.168-6.fc26.s390x
> device-mapper-multipath-libs-0.4.9-88.fc26.s390x
> s390utils-cmsfs-1.36.1-3.fc26.s390x
> libXdamage-1.1.4-9.fc26.s390x
> libXaw-1.0.13-5.fc26.s390x
> brltty-5.5-5.fc26.s390x
> librsvg2-2.40.18-1.fc26.s390x
> texlive-tetex-bin-svn36770.0-33.20160520.fc26.2.noarch
> texlive-etex-pkg-svn39355-33.fc26.2.noarch
> texlive-graphics-svn41015-33.fc26.2.noarch
> texlive-dvips-svn41149-33.fc26.2.noarch
> texlive-zapfding-svn31835.0-33.fc26.2.noarch
> texlive-footmisc-svn23330.5.5b-33.fc26.2.noarch
> texlive-makeindex-svn40768-33.fc26.2.noarch
> texlive-pst-ovl-svn40873-33.fc26.2.noarch
> texlive-texlive-scripts-svn41433-33.fc26.2.noarch
> texlive-ltabptch-svn17533.1.74d-33.fc26.2.noarch
> texlive-euro-svn22191.1.1-33.fc26.2.noarch
> texlive-mflogo-font-svn36898.1.002-33.fc26.2.noarch
> texlive-zapfchan-svn31835.0-33.fc26.2.noarch
> texlive-cmextra-svn32831.0-33.fc26.2.noarch
> texlive-finstrut-svn21719.0.5-33.fc26.2.noarch
> texlive-hyphen-base-svn41138-33.fc26.2.noarch
> texlive-marginnote-svn41382-33.fc26.2.noarch
> texlive-parallel-svn15878.0-33.fc26.2.noarch
> texlive-sepnum-svn20186.2.0-33.fc26.2.noarch
> texlive-environ-svn33821.0.3-33.fc26.2.noarch
> texlive-type1cm-svn21820.0-33.fc26.2.noarch
> texlive-xunicode-svn30466.0.981-33.fc26.2.noarch
> texlive-attachfile-svn38830-33.fc26.2.noarch
> texlive-fontspec-svn41262-33.fc26.2.noarch
> texlive-fancyvrb-svn18492.2.8-33.fc26.2.noarch
> texlive-pst-pdf-bin-svn7838.0-33.20160520.fc26.2.noarch
> texlive-xcolor-svn41044-33.fc26.2.noarch
> texlive-pdfpages-svn40638-33.fc26.2.noarch
> texlive-sansmathaccent-svn30187.0-33.fc26.2.noarch
> texlive-ucs-svn35853.2.2-33.fc26.2.noarch
> texlive-dvipdfmx-bin-svn40273-33.20160520.fc26.2.s390x
> libotf-0.9.13-8.fc26.s390x
> go-srpm-macros-2-8.fc26.noarch
> mesa-libwayland-egl-devel-17.2.4-2.fc26.s390x
> ghostscript-9.20-10.fc26.s390x
> libcephfs_jni-devel-10.2.7-2.fc26.s390x
> libXdamage-devel-1.1.4-9.fc26.s390x
> ncurses-devel-6.0-8.20170212.fc26.s390x
> fontconfig-devel-2.12.6-4.fc26.s390x
> cairo-devel-1.14.10-1.fc26.s390x
> libselinux-devel-2.6-7.fc26.s390x
> guile-devel-2.0.14-1.fc26.s390x
> libcap-ng-devel-0.7.8-3.fc26.s390x
> bash-completion-2.6-1.fc26.noarch
> libXevie-1.0.3-12.fc26.s390x
> python-firewall-0.4.4.5-1.fc26.noarch
> python3-html5lib-0.999-13.fc26.noarch
> python2-simplejson-3.10.0-3.fc26.s390x
> flex-2.6.1-3.fc26.s390x
> telnet-0.17-69.fc26.s390x
> gpg-pubkey-8e1431d5-53bcbac7
> emacs-filesystem-25.3-3.fc26.noarch
> fontawesome-fonts-4.7.0-2.fc26.noarch
> fontawesome-fonts-web-4.7.0-2.fc26.noarch
> rpmconf-base-1.0.19-1.fc26.noarch
> info-6.3-3.fc26.s390x
> texlive-lib-2016-33.20160520.fc26.1.s390x
> libicu-57.1-7.fc26.s390x
> libcap-ng-0.7.8-3.fc26.s390x
> nettle-3.3-2.fc26.s390x
> lcms2-2.8-3.fc26.s390x
> dbus-libs-1.11.18-1.fc26.s390x
> perl-Exporter-5.72-367.fc26.noarch
> unzip-6.0-34.fc26.s390x
> iproute-4.11.0-1.fc26.s390x
> zip-3.0-18.fc26.s390x
> perl-constant-1.33-368.fc26.noarch
> perl-MIME-Base64-3.15-366.fc26.s390x
> lua-posix-33.3.1-4.fc26.s390x
> bzip2-1.0.6-22.fc26.s390x
> hyphen-2.8.8-6.fc26.s390x
> libdvdread-5.0.3-4.fc26.s390x
> libcollection-0.7.0-34.fc26.s390x
> libdvdnav-5.0.3-5.fc26.s390x
> perl-version-0.99.18-1.fc26.s390x
> perl-Encode-2.88-6.fc26.s390x
> automake-1.15-9.fc26.noarch
> plymouth-core-libs-0.9.3-0.7.20160620git0e65b86c.fc26.s390x
> hesiod-3.2.1-7.fc26.s390x
> jasper-libs-2.0.14-1.fc26.s390x
> mozjs17-17.0.0-18.fc26.s390x
> fontconfig-2.12.6-4.fc26.s390x
> harfbuzz-1.4.4-1.fc26.s390x
> alsa-lib-1.1.4.1-1.fc26.s390x
> make-4.2.1-2.fc26.s390x
> gobject-introspection-1.52.1-1.fc26.s390x
> hicolor-icon-theme-0.15-5.fc26.noarch
> gdk-pixbuf2-2.36.9-1.fc26.s390x
> libgusb-0.2.11-1.fc26.s390x
> libdhash-0.5.0-34.fc26.s390x
> python2-bcrypt-3.1.4-2.fc26.s390x
> PyYAML-3.12-3.fc26.s390x
> openssl-devel-1.1.0g-1.fc26.s390x
> copy-jdk-configs-3.3-2.fc26.noarch
> python3-setuptools-37.0.0-1.fc26.noarch
> kernel-core-4.14.8-200.fc26.s390x
> NetworkManager-1.8.2-4.fc26.s390x
> libjpeg-turbo-devel-1.5.3-1.fc26.s390x
> lua-5.3.4-7.fc26.s390x
> kernel-devel-4.14.8-200.fc26.s390x
> perl-autodie-2.29-367.fc26.noarch
> tzdata-java-2018c-1.fc26.noarch
> createrepo_c-0.10.0-15.fc26.s390x
> libgfortran-7.3.1-2.fc26.s390x
> mariadb-config-10.1.30-2.fc26.s390x
> java-1.8.0-openjdk-1.8.0.161-5.b14.fc26.s390x
> libtasn1-devel-4.13-1.fc26.s390x
> gcc-gdb-plugin-7.3.1-2.fc26.s390x
> python2-libxml2-2.9.7-1.fc26.s390x
> net-tools-2.0-0.44.20160912git.fc26.s390x
> python2-requests-kerberos-0.12.0-1.fc26.noarch
> gcc-base-debuginfo-7.3.1-2.fc26.s390x
> glusterfs-libs-3.10.11-1.fc26.s390x
> system-python-libs-3.6.4-3.fc26.s390x
> nss-softokn-freebl-3.36.0-1.0.fc26.s390x
> git-core-2.13.6-3.fc26.s390x
> libsss_certmap-1.16.1-1.fc26.s390x
> nss-softokn-devel-3.36.0-1.0.fc26.s390x
> python3-3.6.4-3.fc26.s390x
> glusterfs-cli-3.10.11-1.fc26.s390x
> perl-5.24.3-396.fc26.s390x
> pcre-utf32-8.41-6.fc26.s390x
> kernel-headers-4.15.12-201.fc26.s390x
> mock-1.4.9-1.fc26.noarch
> libXcursor-devel-1.1.15-1.fc26.s390x
> python3-sssdconfig-1.16.1-1.fc26.noarch
> freetype-devel-2.7.1-10.fc26.s390x
> python2-devel-2.7.14-7.fc26.s390x
> sssd-nfs-idmap-1.16.1-1.fc26.s390x
> libsss_autofs-1.16.1-1.fc26.s390x
> libzip-1.3.0-1.fc26.s390x
> python3-lxml-4.1.1-1.fc26.s390x
> python3-ordered-set-2.0.0-6.fc26.noarch
> python3-rpmconf-1.0.19-1.fc26.noarch
> python-offtrac-0.1.0-9.fc26.noarch
> python2-pycparser-2.14-10.fc26.noarch
> python2-sphinx-theme-alabaster-0.7.9-3.fc26.noarch
> python2-pysocks-1.6.7-1.fc26.noarch
> lua-lpeg-1.0.1-2.fc26.s390x
> libproxy-0.4.15-2.fc26.s390x
> crontabs-1.11-14.20150630git.fc26.noarch
> libev-4.24-2.fc26.s390x
> libsigsegv-2.11-1.fc26.s390x
> fedora-cert-0.6.0.1-2.fc26.noarch
> drpm-0.3.0-6.fc26.s390x
> python2-cccolutils-1.5-3.fc26.s390x
> m17n-lib-1.7.0-6.fc26.s390x
> lsscsi-0.28-4.fc26.s390x
> python3-gpg-1.8.0-12.fc26.s390x
> sg3_utils-libs-1.42-1.fc26.s390x
> SDL2-2.0.7-2.fc26.s390x
> util-linux-2.30.2-1.fc26.s390x
> s390utils-mon_statd-1.36.1-3.fc26.s390x
> GConf2-3.2.6-17.fc26.s390x
> systemd-container-233-7.fc26.s390x
> libXt-1.1.5-4.fc26.s390x
> libXpm-3.5.12-2.fc26.s390x
> at-spi2-core-2.24.1-1.fc26.s390x
> cairo-1.14.10-1.fc26.s390x
> texlive-kpathsea-bin-svn40473-33.20160520.fc26.2.s390x
> texlive-ifluatex-svn41346-33.fc26.2.noarch
> texlive-babel-svn40706-33.fc26.2.noarch
> texlive-colortbl-svn29803.v1.0a-33.fc26.2.noarch
> texlive-marvosym-svn29349.2.2a-33.fc26.2.noarch
> texlive-euler-svn17261.2.5-33.fc26.2.noarch
> texlive-latexconfig-svn40274-33.fc26.2.noarch
> texlive-plain-svn40274-33.fc26.2.noarch
> texlive-texconfig-bin-svn29741.0-33.20160520.fc26.2.noarch
> giflib-4.1.6-16.fc26.s390x
> texlive-microtype-svn41127-33.fc26.2.noarch
> texlive-eurosym-svn17265.1.4_subrfix-33.fc26.2.noarch
> texlive-symbol-svn31835.0-33.fc26.2.noarch
> texlive-chngcntr-svn17157.1.0a-33.fc26.2.noarch
> texlive-euenc-svn19795.0.1h-33.fc26.2.noarch
> texlive-luatex-svn40963-33.fc26.2.noarch
> texlive-knuth-local-svn38627-33.fc26.2.noarch
> texlive-mparhack-svn15878.1.4-33.fc26.2.noarch
> texlive-rcs-svn15878.0-33.fc26.2.noarch
> texlive-texlive-msg-translations-svn41431-33.fc26.2.noarch
> texlive-updmap-map-svn41159-33.fc26.2.noarch
> texlive-geometry-svn19716.5.6-33.fc26.2.noarch
> texlive-memoir-svn41203-33.fc26.2.noarch
> texlive-l3kernel-svn41246-33.fc26.2.noarch
> texlive-pst-eps-svn15878.1.0-33.fc26.2.noarch
> texlive-pst-text-svn15878.1.00-33.fc26.2.noarch
> texlive-amscls-svn36804.0-33.fc26.2.noarch
> texlive-pst-slpe-svn24391.1.31-33.fc26.2.noarch
> texlive-extsizes-svn17263.1.4a-33.fc26.2.noarch
> texlive-xetex-def-svn40327-33.fc26.2.noarch
> texlive-collection-latex-svn41011-33.20160520.fc26.2.noarch
> gstreamer1-plugins-base-1.12.3-1.fc26.s390x
> fpc-srpm-macros-1.1-2.fc26.noarch
> xorg-x11-proto-devel-7.7-22.fc26.noarch
> atk-devel-2.24.0-1.fc26.s390x
> libxcb-devel-1.12-3.fc26.s390x
> libXrandr-devel-1.5.1-2.fc26.s390x
> libcom_err-devel-1.43.4-2.fc26.s390x
> dbus-devel-1.11.18-1.fc26.s390x
> libepoxy-devel-1.4.3-1.fc26.s390x
> libicu-devel-57.1-7.fc26.s390x
> rpm-build-4.13.0.2-1.fc26.s390x
> libssh2-devel-1.8.0-5.fc26.s390x
> graphviz-2.40.1-4.fc26.s390x
> zlib-static-1.2.11-2.fc26.s390x
> mesa-libgbm-devel-17.2.4-2.fc26.s390x
> screen-4.6.2-1.fc26.s390x
> python-osbs-client-0.39.1-1.fc26.noarch
> pyparsing-2.1.10-3.fc26.noarch
> python3-pyasn1-0.2.3-1.fc26.noarch
> python2-html5lib-0.999-13.fc26.noarch
> teamd-1.27-1.fc26.s390x
> hardlink-1.3-1.fc26.s390x
> chrpath-0.16-4.fc26.s390x
> texlive-pdftex-doc-svn41149-33.fc26.2.noarch
> grep-3.1-1.fc26.s390x
> libacl-2.2.52-15.fc26.s390x
> cpio-2.12-4.fc26.s390x
> libatomic_ops-7.4.4-2.fc26.s390x
> gc-7.6.0-2.fc26.s390x
> psmisc-22.21-9.fc26.s390x
> systemd-libs-233-7.fc26.s390x
> xz-5.2.3-2.fc26.s390x
> libpcap-1.8.1-3.fc26.s390x
> perl-parent-0.236-2.fc26.noarch
> perl-Text-Unidecode-1.30-2.fc26.noarch
> newt-0.52.20-1.fc26.s390x
> libcomps-0.1.8-3.fc26.s390x
> libfontenc-1.1.3-4.fc26.s390x
> ipcalc-0.2.0-1.fc26.s390x
> libnfnetlink-1.0.1-9.fc26.s390x
> libref_array-0.1.5-34.fc26.s390x
> perl-Term-Cap-1.17-366.fc26.noarch
> perl-Digest-1.17-367.fc26.noarch
> perl-Pod-Simple-3.35-2.fc26.noarch
> perl-URI-1.71-6.fc26.noarch
> attr-2.4.47-18.fc26.s390x
> gmp-c++-6.1.2-4.fc26.s390x
> harfbuzz-icu-1.4.4-1.fc26.s390x
> http-parser-2.7.1-5.fc26.s390x
> libsodium-1.0.14-1.fc26.s390x
> python-gssapi-1.2.0-5.fc26.s390x
> perl-libnet-3.11-1.fc26.noarch
> libwayland-client-1.13.0-3.fc26.s390x
> python3-dnf-2.7.5-2.fc26.noarch
> kernel-modules-4.14.8-200.fc26.s390x
> NetworkManager-ppp-1.8.2-4.fc26.s390x
> wayland-devel-1.13.0-3.fc26.s390x
> kernel-4.14.8-200.fc26.s390x
> NetworkManager-glib-1.8.2-4.fc26.s390x
> perl-IPC-System-Simple-1.25-12.fc26.noarch
> sed-4.4-2.fc26.s390x
> libassuan-2.5.1-1.fc26.s390x
> createrepo_c-libs-0.10.0-15.fc26.s390x
> dnf-utils-2.1.5-4.fc26.noarch
> libobjc-7.3.1-2.fc26.s390x
> dracut-046-8.git20180105.fc26.s390x
> libseccomp-2.3.3-1.fc26.s390x
> python-sphinx-locale-1.5.6-1.fc26.noarch
> libxml2-devel-2.9.7-1.fc26.s390x
> libseccomp-devel-2.3.3-1.fc26.s390x
> fedora-upgrade-28.1-1.fc26.noarch
> gcc-gfortran-7.3.1-2.fc26.s390x
> gdb-8.0.1-36.fc26.s390x
> unbound-libs-1.6.8-1.fc26.s390x
> man-db-2.7.6.1-9.fc26.s390x
> python2-rpm-macros-3-21.fc26.noarch
> kernel-devel-4.15.4-200.fc26.s390x
> sqlite-libs-3.20.1-2.fc26.s390x
> python2-2.7.14-7.fc26.s390x
> libkadm5-1.15.2-7.fc26.s390x
> libcurl-7.53.1-16.fc26.s390x
> net-snmp-agent-libs-5.7.3-27.fc26.s390x
> p11-kit-trust-0.23.10-1.fc26.s390x
> python3-koji-1.15.0-4.fc26.noarch
> glusterfs-server-3.10.11-1.fc26.s390x
> kernel-devel-4.15.12-201.fc26.s390x
> pcre-utf16-8.41-6.fc26.s390x
> jansson-2.11-1.fc26.s390x
> python2-rpkg-1.52-1.fc26.noarch
> pcre-static-8.41-6.fc26.s390x
> systemtap-sdt-devel-3.2-7.fc26.s390x
> libXfont-1.5.4-1.fc26.s390x
> system-python-3.6.4-3.fc26.s390x
> shared-mime-info-1.8-3.fc26.s390x
> libpaper-1.1.24-21.fc26.s390x
> python3-pbr-1.10.0-4.fc26.noarch
> libcroco-0.6.12-1.fc26.s390x
> libssh2-1.8.0-5.fc26.s390x
> json-glib-1.2.6-1.fc26.s390x
> libevent-2.0.22-3.fc26.s390x
> gdk-pixbuf2-modules-2.36.9-1.fc26.s390x
> colord-libs-1.3.5-1.fc26.s390x
> python3-magic-5.30-11.fc26.noarch
> python3-gobject-base-3.24.1-1.fc26.s390x
> python3-pyroute2-0.4.13-1.fc26.noarch
> python3-pysocks-1.6.7-1.fc26.noarch
> python2-click-6.7-3.fc26.noarch
> python-munch-2.1.0-2.fc26.noarch
> python2-ply-3.9-3.fc26.noarch
> python2-snowballstemmer-1.2.1-3.fc26.noarch
> python-magic-5.30-11.fc26.noarch
> python-beautifulsoup4-4.6.0-1.fc26.noarch
> python2-gitdb-2.0.3-1.fc26.noarch
> librados-devel-10.2.7-2.fc26.s390x
> libcacard-2.5.3-1.fc26.s390x
> libmodman-2.0.1-13.fc26.s390x
> zziplib-0.13.62-8.fc26.s390x
> lksctp-tools-1.0.16-6.fc26.s390x
> procmail-3.22-44.fc26.s390x
> libthai-0.1.25-2.fc26.s390x
> libpipeline-1.4.1-3.fc26.s390x
> python2-pycurl-7.43.0-8.fc26.s390x
> deltarpm-3.6-19.fc26.s390x
> subversion-libs-1.9.7-1.fc26.s390x
> python-krbV-1.0.90-13.fc26.s390x
> m17n-db-1.7.0-8.fc26.noarch
> linux-atm-libs-2.5.1-17.fc26.s390x
> python2-rpm-4.13.0.2-1.fc26.s390x
> python2-librepo-1.8.0-1.fc26.s390x
> qrencode-libs-3.4.4-1.fc26.s390x
> s390utils-iucvterm-1.36.1-3.fc26.s390x
> libsmartcols-2.30.2-1.fc26.s390x
> dbus-1.11.18-1.fc26.s390x
> systemd-udev-233-7.fc26.s390x
> device-mapper-event-1.02.137-6.fc26.s390x
> polkit-0.113-8.fc26.s390x
> libwmf-lite-0.2.8.4-53.fc26.s390x
> libXcomposite-0.4.4-9.fc26.s390x
> at-spi2-atk-2.24.1-1.fc26.s390x
> pango-1.40.12-1.fc26.s390x
> texlive-metafont-bin-svn40987-33.20160520.fc26.2.s390x
> texlive-url-svn32528.3.4-33.fc26.2.noarch
> texlive-fp-svn15878.0-33.fc26.2.noarch
> texlive-latex-fonts-svn28888.0-33.fc26.2.noarch
> texlive-mptopdf-bin-svn18674.0-33.20160520.fc26.2.noarch
> texlive-fancybox-svn18304.1.4-33.fc26.2.noarch
> texlive-lua-alt-getopt-svn29349.0.7.0-33.fc26.2.noarch
> texlive-tex-bin-svn40987-33.20160520.fc26.2.s390x
> texlive-texconfig-svn40768-33.fc26.2.noarch
> texlive-wasy2-ps-svn35830.0-33.fc26.2.noarch
> texlive-psfrag-svn15878.3.04-33.fc26.2.noarch
> texlive-helvetic-svn31835.0-33.fc26.2.noarch
> texlive-times-svn35058.0-33.fc26.2.noarch
> texlive-cite-svn36428.5.5-33.fc26.2.noarch
> texlive-fancyhdr-svn15878.3.1-33.fc26.2.noarch
> texlive-luatex-bin-svn41091-33.20160520.fc26.2.s390x
> texlive-lm-math-svn36915.1.959-33.fc26.2.noarch
> texlive-ntgclass-svn15878.2.1a-33.fc26.2.noarch
> texlive-sansmath-svn17997.1.1-33.fc26.2.noarch
> texlive-textcase-svn15878.0-33.fc26.2.noarch
> texlive-unicode-data-svn39808-33.fc26.2.noarch
> texlive-breakurl-svn29901.1.40-33.fc26.2.noarch
> texlive-latex-svn40218-33.fc26.2.noarch
> texlive-lualatex-math-svn40621-33.fc26.2.noarch
> texlive-pst-coil-svn37377.1.07-33.fc26.2.noarch
> texlive-pst-plot-svn41242-33.fc26.2.noarch
> texlive-unicode-math-svn38462-33.fc26.2.noarch
> texlive-pst-blur-svn15878.2.0-33.fc26.2.noarch
> texlive-cm-super-svn15878.0-33.fc26.2.noarch
> texlive-wasysym-svn15878.2.0-33.fc26.2.noarch
> texlive-collection-fontsrecommended-svn35830.0-33.20160520.fc26.2.noarch
> libXv-1.0.11-2.fc26.s390x
> ghc-srpm-macros-1.4.2-5.fc26.noarch
> latex2html-2017.2-2.fc26.noarch
> libXau-devel-1.0.8-7.fc26.s390x
> graphite2-devel-1.3.10-1.fc26.s390x
> pixman-devel-0.34.0-3.fc26.s390x
> wayland-protocols-devel-1.9-1.fc26.noarch
> mesa-libGLES-devel-17.2.4-2.fc26.s390x
> vte291-devel-0.48.4-1.fc26.s390x
> ceph-devel-compat-10.2.7-2.fc26.s390x
> lzo-devel-2.08-9.fc26.s390x
> libiscsi-devel-1.15.0-3.fc26.s390x
> avahi-autoipd-0.6.32-7.fc26.s390x
> rpm-plugin-systemd-inhibit-4.13.0.2-1.fc26.s390x
> python2-ndg_httpsclient-0.4.0-7.fc26.noarch
> gettext-0.19.8.1-9.fc26.s390x
> btrfs-progs-4.9.1-2.fc26.s390x
> fedora-logos-26.0.1-1.fc26.s390x
> dejagnu-1.6-2.fc26.noarch
> libaio-devel-0.3.110-7.fc26.s390x
> dos2unix-7.3.4-2.fc26.s390x
> popt-1.16-12.fc26.s390x
> tar-1.29-5.fc26.s390x
> avahi-libs-0.6.32-7.fc26.s390x
> m4-1.4.18-3.fc26.s390x
> perl-Time-Local-1.250-2.fc26.noarch
> libmetalink-0.1.3-2.fc26.s390x
> jbigkit-libs-2.1-6.fc26.s390x
> netpbm-10.80.00-2.fc26.s390x
> perl-Digest-MD5-2.55-3.fc26.s390x
> perl-Getopt-Long-2.49.1-2.fc26.noarch
> libglvnd-opengl-1.0.0-1.fc26.s390x
> libattr-devel-2.4.47-18.fc26.s390x
> teckit-2.5.1-16.fc26.s390x
> python3-six-1.10.0-9.fc26.noarch
> python3-libcomps-0.1.8-3.fc26.s390x
> python3-pyparsing-2.1.10-3.fc26.noarch
> python2-markupsafe-0.23-13.fc26.s390x
> python2-mock-2.0.0-4.fc26.noarch
> python2-yubico-1.3.2-7.fc26.noarch
> python2-smmap-2.0.3-1.fc26.noarch
> librbd-devel-10.2.7-2.fc26.s390x
> libnghttp2-1.21.1-1.fc26.s390x
> ykpers-1.18.0-2.fc26.s390x
> python3-librepo-1.8.0-1.fc26.s390x
> geoclue2-2.4.5-4.fc26.s390x
> initscripts-9.72-1.fc26.s390x
> plymouth-0.9.3-0.7.20160620git0e65b86c.fc26.s390x
> ebtables-2.0.10-22.fc26.s390x
> gssproxy-0.7.0-9.fc26.s390x
> libXext-1.3.3-5.fc26.s390x
> mesa-libEGL-17.2.4-2.fc26.s390x
> texlive-texlive.infra-bin-svn40312-33.20160520.fc26.2.s390x
> texlive-thumbpdf-svn34621.3.16-33.fc26.2.noarch
> texlive-carlisle-svn18258.0-33.fc26.2.noarch
> texlive-gsftopk-svn40768-33.fc26.2.noarch
> texlive-pdftex-svn41149-33.fc26.2.noarch
> texlive-crop-svn15878.1.5-33.fc26.2.noarch
> texlive-pxfonts-svn15878.0-33.fc26.2.noarch
> texlive-enctex-svn34957.0-33.fc26.2.noarch
> texlive-kastrup-svn15878.0-33.fc26.2.noarch
> texlive-pspicture-svn15878.0-33.fc26.2.noarch
> texlive-varwidth-svn24104.0.92-33.fc26.2.noarch
> texlive-currfile-svn40725-33.fc26.2.noarch
> texlive-pst-grad-svn15878.1.06-33.fc26.2.noarch
> texlive-latex-bin-svn41438-33.fc26.2.noarch
> texlive-ltxmisc-svn21927.0-33.fc26.2.noarch
> lasi-1.1.2-7.fc26.s390x
> adwaita-icon-theme-3.24.0-2.fc26.noarch
> xz-devel-5.2.3-2.fc26.s390x
> xorg-x11-fonts-Type1-7.5-17.fc26.noarch
> libXi-devel-1.7.9-2.fc26.s390x
> at-spi2-atk-devel-2.24.1-1.fc26.s390x
> pango-devel-1.40.12-1.fc26.s390x
> libcacard-devel-2.5.3-1.fc26.s390x
> subversion-1.9.7-1.fc26.s390x
> sudo-1.8.21p2-1.fc26.s390x
> pykickstart-2.35-2.fc26.noarch
> e2fsprogs-1.43.4-2.fc26.s390x
> libbsd-0.8.3-3.fc26.s390x
> c-ares-1.13.0-1.fc26.s390x
> python2-pyxdg-0.25-12.fc26.noarch
> valgrind-3.13.0-12.fc26.s390x
> libwayland-server-1.13.0-3.fc26.s390x
> dhcp-client-4.3.5-10.fc26.s390x
> man-pages-4.09-4.fc26.noarch
> libffi-devel-3.1-12.fc26.s390x
> libxml2-2.9.7-1.fc26.s390x
> kmod-25-1.fc26.s390x
> dnf-plugins-core-2.1.5-4.fc26.noarch
> kmod-libs-25-1.fc26.s390x
> pigz-2.4-1.fc26.s390x
> pkgconf-pkg-config-1.3.12-2.fc26.s390x
> gcc-go-7.3.1-2.fc26.s390x
> python-rpm-macros-3-21.fc26.noarch
> perl-libs-5.24.3-396.fc26.s390x
> glusterfs-api-3.10.11-1.fc26.s390x
> git-core-doc-2.13.6-3.fc26.s390x
> pcre-cpp-8.41-6.fc26.s390x
> usermode-1.112-1.fc26.s390x
> distribution-gpg-keys-1.19-1.fc26.noarch
> perl-Test-Harness-3.41-1.fc26.noarch
> krb5-devel-1.15.2-7.fc26.s390x
> libvorbis-1.3.6-1.fc26.s390x
> python2-configargparse-0.12.0-1.fc26.noarch
> gpg-pubkey-a29cb19c-53bcbba6
> quota-nls-4.03-9.fc26.noarch
> xz-libs-5.2.3-2.fc26.s390x
> gmp-6.1.2-4.fc26.s390x
> file-5.30-11.fc26.s390x
> libusbx-1.0.21-2.fc26.s390x
> binutils-2.27-28.fc26.s390x
> perl-HTTP-Tiny-0.070-2.fc26.noarch
> xml-common-0.6.3-45.fc26.noarch
> opus-1.2.1-1.fc26.s390x
> flac-libs-1.3.2-2.fc26.s390x
> libacl-devel-2.2.52-15.fc26.s390x
> coreutils-common-8.27-7.fc26.s390x
> cracklib-2.9.6-5.fc26.s390x
> pyliblzma-0.5.3-17.fc26.s390x
> libnotify-0.7.7-2.fc26.s390x
> python3-idna-2.5-1.fc26.noarch
> python3-pyOpenSSL-16.2.0-6.fc26.noarch
> python2-pbr-1.10.0-4.fc26.noarch
> pyusb-1.0.0-4.fc26.noarch
> librbd1-10.2.7-2.fc26.s390x
> libnfs-1.9.8-3.fc26.s390x
> libsolv-0.6.30-2.fc26.s390x
> python3-pycurl-7.43.0-8.fc26.s390x
> libyubikey-1.13-3.fc26.s390x
> rpmlint-1.10-5.fc26.noarch
> python2-pygpgme-0.3-22.fc26.s390x
> s390utils-base-1.36.1-3.fc26.s390x
> ppp-2.4.7-11.fc26.s390x
> s390utils-cpuplugd-1.36.1-3.fc26.s390x
> libXrender-0.9.10-2.fc26.s390x
> libglvnd-gles-1.0.0-1.fc26.s390x
> texlive-texlive.infra-svn41280-33.fc26.2.noarch
> texlive-lm-svn28119.2.004-33.fc26.2.noarch
> texlive-babelbib-svn25245.1.31-33.fc26.2.noarch
> texlive-index-svn24099.4.1beta-33.fc26.2.noarch
> texlive-pdftex-bin-svn40987-33.20160520.fc26.2.s390x
> texlive-csquotes-svn39538-33.fc26.2.noarch
> texlive-rsfs-svn15878.0-33.fc26.2.noarch
> texlive-etex-svn37057.0-33.fc26.2.noarch
> texlive-knuth-lib-svn35820.0-33.fc26.2.noarch
> texlive-pst-math-svn34786.0.63-33.fc26.2.noarch
> texlive-utopia-svn15878.0-33.fc26.2.noarch
> texlive-eso-pic-svn37925.2.0g-33.fc26.2.noarch
> texlive-pst-fill-svn15878.1.01-33.fc26.2.noarch
> texlive-latex-bin-bin-svn14050.0-33.20160520.fc26.2.noarch
> texlive-jknapltx-svn19440.0-33.fc26.2.noarch
> texlive-collection-latexrecommended-svn35765.0-33.20160520.fc26.2.noarch
> adwaita-cursor-theme-3.24.0-2.fc26.noarch
> xorg-x11-fonts-ISO8859-1-100dpi-7.5-17.fc26.noarch
> libXcomposite-devel-0.4.4-9.fc26.s390x
> at-spi2-core-devel-2.24.1-1.fc26.s390x
> harfbuzz-devel-1.4.4-1.fc26.s390x
> rpmdevtools-8.10-2.fc26.noarch
> texi2html-5.0-5.fc26.noarch
> libnfs-devel-1.9.8-3.fc26.s390x
> firewalld-0.4.4.5-1.fc26.noarch
> wpa_supplicant-2.6-12.fc26.s390x
> newt-python-0.52.20-1.fc26.s390x
> perl-Mozilla-CA-20160104-4.fc26.noarch
> pth-2.0.7-28.fc26.s390x
> python3-pyxdg-0.25-12.fc26.noarch
> timedatex-0.4-3.fc26.s390x
> libjpeg-turbo-1.5.3-1.fc26.s390x
> dnf-yum-2.7.5-2.fc26.noarch
> libuv-devel-1.11.0-1.fc26.s390x
> libstdc++-7.3.1-2.fc26.s390x
> libgo-7.3.1-2.fc26.s390x
> python3-dnf-plugins-core-2.1.5-4.fc26.noarch
> gtk3-3.22.21-3.fc26.s390x
> perl-threads-2.21-1.fc26.s390x
> pkgconf-m4-1.3.12-2.fc26.noarch
> gtk3-devel-3.22.21-3.fc26.s390x
> gcc-objc-7.3.1-2.fc26.s390x
> nss-util-3.36.0-1.0.fc26.s390x
> python2-koji-1.15.0-4.fc26.noarch
> kernel-modules-4.15.12-201.fc26.s390x
> elfutils-libelf-devel-0.170-4.fc26.s390x
> selinux-policy-3.13.1-260.20.fc26.noarch
> mock-core-configs-28.3-1.fc26.noarch
> glusterfs-api-devel-3.10.11-1.fc26.s390x
> krb5-workstation-1.15.2-7.fc26.s390x
> libsss_sudo-1.16.1-1.fc26.s390x
> mailcap-2.1.48-1.fc26.noarch
> python-async-0.6.1-9.fc22.s390x
> poppler-data-0.4.7-7.fc26.noarch
> ocaml-srpm-macros-4-2.fc26.noarch
> libuuid-2.30.2-1.fc26.s390x
> libgpg-error-1.25-2.fc26.s390x
> graphite2-1.3.10-1.fc26.s390x
> perl-Text-Tabs+Wrap-2013.0523-366.fc26.noarch
> perl-Error-0.17024-8.fc26.noarch
> which-2.21-2.fc26.s390x
> libXau-1.0.8-7.fc26.s390x
> orc-0.4.27-1.fc26.s390x
> perl-Pod-Perldoc-3.28-1.fc26.noarch
> libsndfile-1.0.28-6.fc26.s390x
> gzip-1.8-2.fc26.s390x
> python-ipaddress-1.0.16-4.fc26.noarch
> yum-metadata-parser-1.1.4-18.fc26.s390x
> python3-dbus-1.2.4-6.fc26.s390x
> python3-cryptography-2.0.2-2.fc26.s390x
> python3-kickstart-2.35-2.fc26.noarch
> python2-imagesize-0.7.1-5.fc26.noarch
> python2-jinja2-2.9.6-1.fc26.noarch
> libradosstriper-devel-10.2.7-2.fc26.s390x
> soundtouch-1.9.2-4.fc26.s390x
> libndp-1.6-2.fc26.s390x
> rpm-4.13.0.2-1.fc26.s390x
> rest-0.8.0-2.fc26.s390x
> libvisual-0.4.0-21.fc26.s390x
> python2-hawkey-0.11.1-1.fc26.s390x
> fakeroot-libs-1.22-1.fc26.s390x
> device-mapper-event-libs-1.02.137-6.fc26.s390x
> cyrus-sasl-2.1.26-32.fc26.s390x
> cronie-anacron-1.5.1-5.fc26.s390x
> libpath_utils-0.2.1-34.fc26.s390x
> libX11-common-1.6.5-2.fc26.noarch
> libXft-2.3.2-5.fc26.s390x
> gtk2-2.24.31-4.fc26.s390x
> texlive-etoolbox-svn38031.2.2a-33.fc26.2.noarch
> texlive-multido-svn18302.1.42-33.fc26.2.noarch
> texlive-glyphlist-svn28576.0-33.fc26.2.noarch
> texlive-setspace-svn24881.6.7a-33.fc26.2.noarch
> texlive-mathtools-svn38833-33.fc26.2.noarch
> texlive-ncntrsbk-svn31835.0-33.fc26.2.noarch
> texlive-dvisvgm-def-svn41011-33.fc26.2.noarch
> texlive-ifetex-svn24853.1.2-33.fc26.2.noarch
> texlive-parskip-svn19963.2.0-33.fc26.2.noarch
> texlive-bera-svn20031.0-33.fc26.2.noarch
> texlive-pgf-svn40966-33.fc26.2.noarch
> texlive-auto-pst-pdf-svn23723.0.6-33.fc26.2.noarch
> texlive-ctable-svn38672-33.fc26.2.noarch
> texlive-typehtml-svn17134.0-33.fc26.2.noarch
> mesa-libGLES-17.2.4-2.fc26.s390x
> vte291-0.48.4-1.fc26.s390x
> libcephfs_jni1-10.2.7-2.fc26.s390x
> bzip2-devel-1.0.6-22.fc26.s390x
> expat-devel-2.2.4-1.fc26.s390x
> libsepol-devel-2.6-2.fc26.s390x
> glib2-static-2.52.3-2.fc26.s390x
> virglrenderer-devel-0.6.0-1.20170210git76b3da97b.fc26.s390x
> parted-3.2-24.fc26.s390x
> python3-beautifulsoup4-4.6.0-1.fc26.noarch
> python-bunch-1.0.1-10.fc26.noarch
> lz4-1.8.0-1.fc26.s390x
> openssh-clients-7.5p1-4.fc26.s390x
> chrony-3.2-1.fc26.s390x
> dnf-conf-2.7.5-2.fc26.noarch
> bodhi-client-2.12.2-3.fc26.noarch
> libuv-1.11.0-1.fc26.s390x
> glibc-2.25-13.fc26.s390x
> libgomp-7.3.1-2.fc26.s390x
> cmake-rpm-macros-3.10.1-11.fc26.noarch
> gtk-update-icon-cache-3.22.21-3.fc26.s390x
> pcre2-utf32-10.23-13.fc26.s390x
> kernel-modules-4.15.4-200.fc26.s390x
> webkitgtk4-2.18.6-1.fc26.s390x
> libstdc++-static-7.3.1-2.fc26.s390x
> rsync-3.1.3-2.fc26.s390x
> nspr-4.19.0-1.fc26.s390x
> nss-util-devel-3.36.0-1.0.fc26.s390x
> kernel-core-4.15.12-201.fc26.s390x
> glusterfs-extra-xlators-3.10.11-1.fc26.s390x
> vim-filesystem-8.0.1553-1.fc26.noarch
> systemtap-client-3.2-7.fc26.s390x
> net-snmp-5.7.3-27.fc26.s390x
> mailx-12.5-25.fc26.s390x
> mpfr-3.1.6-1.fc26.s390x
> libzip-devel-1.3.0-1.fc26.s390x
> hawkey-0.6.4-3.fc25.s390x
> perl-srpm-macros-1-21.fc26.noarch
> expat-2.2.4-1.fc26.s390x
> chkconfig-1.10-1.fc26.s390x
> findutils-4.6.0-12.fc26.s390x
> mesa-libwayland-egl-17.2.4-2.fc26.s390x
> procps-ng-3.3.10-13.fc26.s390x
> mesa-libglapi-17.2.4-2.fc26.s390x
> perl-Unicode-Normalize-1.25-366.fc26.s390x
> perl-IO-Socket-IP-0.39-1.fc26.noarch
> hunspell-en-US-0.20140811.1-6.fc26.noarch
> libxcb-1.12-3.fc26.s390x
> perl-Pod-Escapes-1.07-366.fc26.noarch
> perl-Pod-Usage-1.69-2.fc26.noarch
> libtheora-1.1.1-15.fc26.s390x
> tcp_wrappers-7.6-85.fc26.s390x
> coreutils-8.27-7.fc26.s390x
> libmount-2.30.2-1.fc26.s390x
> python2-iniparse-0.4-24.fc26.noarch
> python2-decorator-4.0.11-2.fc26.noarch
> ModemManager-glib-1.6.10-1.fc26.s390x
> python3-decorator-4.0.11-2.fc26.noarch
> python3-cffi-1.9.1-2.fc26.s390x
> python-bugzilla-cli-2.1.0-1.fc26.noarch
> python2-funcsigs-1.0.2-5.fc26.noarch
> python2-babel-2.3.4-5.fc26.noarch
> python-bugzilla-2.1.0-1.fc26.noarch
> libradosstriper1-10.2.7-2.fc26.s390x
> snappy-1.1.4-3.fc26.s390x
> libmpcdec-1.2.6-17.fc26.s390x
> rpm-libs-4.13.0.2-1.fc26.s390x
> python-urlgrabber-3.10.1-11.fc26.noarch
> sysfsutils-2.1.0-20.fc26.s390x
> python3-hawkey-0.11.1-1.fc26.s390x
> iputils-20161105-5.fc26.s390x
> plymouth-scripts-0.9.3-0.7.20160620git0e65b86c.fc26.s390x
> cronie-1.5.1-5.fc26.s390x
> libini_config-1.3.1-34.fc26.s390x
> libX11-1.6.5-2.fc26.s390x
> libglvnd-egl-1.0.0-1.fc26.s390x
> texlive-kpathsea-svn41139-33.fc26.2.noarch
> texlive-thumbpdf-bin-svn6898.0-33.20160520.fc26.2.noarch
> texlive-subfig-svn15878.1.3-33.fc26.2.noarch
> texlive-gsftopk-bin-svn40473-33.20160520.fc26.2.s390x
> texlive-tex-ini-files-svn40533-33.fc26.2.noarch
> texlive-qstest-svn15878.0-33.fc26.2.noarch
> texlive-palatino-svn31835.0-33.fc26.2.noarch
> texlive-ec-svn25033.1.0-33.fc26.2.noarch
> texlive-iftex-svn29654.0.2-33.fc26.2.noarch
> texlive-pslatex-svn16416.0-33.fc26.2.noarch
> texlive-algorithms-svn38085.0.1-33.fc26.2.noarch
> texlive-filehook-svn24280.0.5d-33.fc26.2.noarch
> texlive-pst-node-svn40743-33.fc26.2.noarch
> texlive-rotating-svn16832.2.16b-33.fc26.2.noarch
> texlive-seminar-svn34011.1.62-33.fc26.2.noarch
> libuuid-devel-2.30.2-1.fc26.s390x
> libXinerama-devel-1.1.3-7.fc26.s390x
> emacs-common-25.3-3.fc26.s390x
> fedora-packager-0.6.0.1-2.fc26.noarch
> snappy-devel-1.1.4-3.fc26.s390x
> authconfig-7.0.1-2.fc26.s390x
> newt-python3-0.52.20-1.fc26.s390x
> python-decoratortools-1.8-13.fc26.noarch
> python-systemd-doc-234-1.fc26.s390x
> openssl-libs-1.1.0g-1.fc26.s390x
> lsof-4.89-5.fc26.s390x
> glibc-all-langpacks-2.25-13.fc26.s390x
> audit-libs-2.8.2-1.fc26.s390x
> gcc-7.3.1-2.fc26.s390x
> pcre2-utf16-10.23-13.fc26.s390x
> kernel-core-4.15.4-200.fc26.s390x
> dracut-config-rescue-046-8.git20180105.fc26.s390x
> webkitgtk4-plugin-process-gtk2-2.18.6-1.fc26.s390x
> perl-Time-HiRes-1.9753-1.fc26.s390x
> haveged-1.9.1-6.fc26.s390x
> p11-kit-0.23.10-1.fc26.s390x
> boost-system-1.63.0-11.fc26.s390x
> glusterfs-fuse-3.10.11-1.fc26.s390x
> vim-common-8.0.1553-1.fc26.s390x
> systemtap-devel-3.2-7.fc26.s390x
> perl-SelfLoader-1.23-396.fc26.noarch
> nss-tools-3.36.0-1.0.fc26.s390x
> libwebp-0.6.1-8.fc26.s390x
> python3-configargparse-0.12.0-1.fc26.noarch
> gpg-pubkey-a0a7badb-52844296
> gpg-pubkey-e372e838-56fd7943
> gpg-pubkey-3b921d09-57a87096
> google-roboto-slab-fonts-1.100263-0.5.20150923git.fc26.noarch
> libreport-filesystem-2.9.1-3.fc26.s390x
> libcom_err-1.43.4-2.fc26.s390x
> libffi-3.1-12.fc26.s390x
> keyutils-libs-1.5.10-1.fc26.s390x
> diffutils-3.5-3.fc26.s390x
> apr-util-1.5.4-6.fc26.s390x
> bluez-libs-5.46-6.fc26.s390x
> libksba-1.3.5-3.fc26.s390x
> ncurses-6.0-8.20170212.fc26.s390x
> libteam-1.27-1.fc26.s390x
> perl-Fedora-VSP-0.001-5.fc26.noarch
> libusb-0.1.5-8.fc26.s390x
> acl-2.2.52-15.fc26.s390x
> dwz-0.12-3.fc26.s390x
> libblkid-2.30.2-1.fc26.s390x
> polkit-libs-0.113-8.fc26.s390x
> dbus-python-1.2.4-6.fc26.s390x
> gts-0.7.6-30.20121130.fc26.s390x
> libfdisk-2.30.2-1.fc26.s390x
> python3-pycparser-2.14-10.fc26.noarch
> python3-bugzilla-2.1.0-1.fc26.noarch
> python2-docutils-0.13.1-4.fc26.noarch
> python2-requests-2.13.0-1.fc26.noarch
> libcephfs-devel-10.2.7-2.fc26.s390x
> ncurses-c++-libs-6.0-8.20170212.fc26.s390x
> GeoIP-1.6.11-1.fc26.s390x
> liblockfile-1.09-5.fc26.s390x
> rpm-plugin-selinux-4.13.0.2-1.fc26.s390x
> libsysfs-2.1.0-20.fc26.s390x
> libdnf-0.11.1-1.fc26.s390x
> mesa-libgbm-17.2.4-2.fc26.s390x
> lvm2-libs-2.02.168-6.fc26.s390x
> libXfixes-5.0.3-2.fc26.s390x
> brlapi-0.6.6-5.fc26.s390x
> texlive-metafont-svn40793-33.fc26.2.noarch
> texlive-graphics-cfg-svn40269-33.fc26.2.noarch
> texlive-mptopdf-svn41282-33.fc26.2.noarch
> texlive-makeindex-bin-svn40473-33.20160520.fc26.2.s390x
> texlive-texlive-scripts-bin-svn29741.0-33.20160520.fc26.2.noarch
> texlive-sauerj-svn15878.0-33.fc26.2.noarch
> texlive-txfonts-svn15878.0-33.fc26.2.noarch
> texlive-filecontents-svn24250.1.3-33.fc26.2.noarch
> texlive-lualibs-svn40370-33.fc26.2.noarch
> texlive-section-svn20180.0-33.fc26.2.noarch
> texlive-ucharcat-svn38907-33.fc26.2.noarch
> texlive-hyperref-svn41396-33.fc26.2.noarch
> texlive-pst-3d-svn17257.1.10-33.fc26.2.noarch
> texlive-oberdiek-svn41346-33.fc26.2.noarch
> texlive-ae-svn15878.1.4-33.fc26.2.noarch
> texlive-collection-basic-svn41149-33.20160520.fc26.2.noarch
> gnat-srpm-macros-4-2.fc26.noarch
> glib2-devel-2.52.3-2.fc26.s390x
> netpbm-progs-10.80.00-2.fc26.s390x
> libXxf86vm-devel-1.1.4-4.fc26.s390x
> nettle-devel-3.3-2.fc26.s390x
> cairo-gobject-devel-1.14.10-1.fc26.s390x
> fedora-rpm-macros-26-2.fc26.noarch
> libidn-devel-1.33-2.fc26.s390x
> s390utils-1.36.1-3.fc26.s390x
> libtool-2.4.6-17.fc26.s390x
> python3-cssselect-0.9.2-4.fc26.noarch
> python2-cssselect-0.9.2-4.fc26.noarch
> bison-3.0.4-6.fc26.s390x
> rootfiles-8.1-20.fc26.noarch
> python3-urllib3-1.20-2.fc26.noarch
> libgcc-7.3.1-2.fc26.s390x
> python3-distro-1.2.0-1.fc26.noarch
> libnfsidmap-2.2.1-4.rc2.fc26.s390x
> kernel-4.15.4-200.fc26.s390x
> glibc-static-2.25-13.fc26.s390x
> xapian-core-libs-1.4.5-1.fc26.s390x
> elfutils-libelf-0.170-4.fc26.s390x
> nss-3.36.0-1.0.fc26.s390x
> nss-softokn-freebl-devel-3.36.0-1.0.fc26.s390x
> koji-1.15.0-4.fc26.noarch
> perl-Git-2.13.6-3.fc26.noarch
> elfutils-default-yama-scope-0.170-4.fc26.noarch
> selinux-policy-targeted-3.13.1-260.20.fc26.noarch
> curl-7.53.1-16.fc26.s390x
> publicsuffix-list-dafsa-20180223-1.fc26.noarch
> python3-funcsigs-1.0.2-5.fc26.noarch
> =3D=3D=3D TEST BEGIN =3D=3D=3D
> Using CC: /home/fam/bin/cc
> Install prefix    /var/tmp/patchew-tester-tmp-4ppomfuh/src/install
> BIOS directory    /var/tmp/patchew-tester-tmp-4ppomfuh/src/install/share/=
qemu
> firmware path     /var/tmp/patchew-tester-tmp-4ppomfuh/src/install/share/=
qemu-firmware
> binary directory  /var/tmp/patchew-tester-tmp-4ppomfuh/src/install/bin
> library directory /var/tmp/patchew-tester-tmp-4ppomfuh/src/install/lib
> module directory  /var/tmp/patchew-tester-tmp-4ppomfuh/src/install/lib/qe=
mu
> libexec directory /var/tmp/patchew-tester-tmp-4ppomfuh/src/install/libexec
> include directory /var/tmp/patchew-tester-tmp-4ppomfuh/src/install/include
> config directory  /var/tmp/patchew-tester-tmp-4ppomfuh/src/install/etc
> local state directory   /var/tmp/patchew-tester-tmp-4ppomfuh/src/install/=
var
> Manual directory  /var/tmp/patchew-tester-tmp-4ppomfuh/src/install/share/=
man
> ELF interp prefix /usr/gnemul/qemu-%M
> Source path       /var/tmp/patchew-tester-tmp-4ppomfuh/src
> GIT binary        git
> GIT submodules    ui/keycodemapdb capstone
> C compiler        /home/fam/bin/cc
> Host C compiler   cc
> C++ compiler      c++
> Objective-C compiler /home/fam/bin/cc
> ARFLAGS           rv
> CFLAGS            -O2 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=3D2 -g=20
> QEMU_CFLAGS       -I/usr/include/pixman-1   -Werror -DHAS_LIBSSH2_SFTP_FS=
YNC -pthread -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include  -m64 -D=
_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -Wstrict-prototype=
s -Wredundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-prototypes -fno=
-strict-aliasing -fno-common -fwrapv  -Wexpansion-to-defined -Wendif-labels=
 -Wno-shift-negative-value -Wno-missing-include-dirs -Wempty-body -Wnested-=
externs -Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers -Wo=
ld-style-declaration -Wold-style-definition -Wtype-limits -fstack-protector=
-strong -I/usr/include/p11-kit-1     -I/usr/include/libpng16  -I/usr/includ=
e/libdrm  -I$(SRC_PATH)/capstone/include
> LDFLAGS           -Wl,--warn-common -m64 -g=20
> QEMU_LDFLAGS      =20
> make              make
> install           install
> python            python -B
> smbd              /usr/sbin/smbd
> module support    no
> host CPU          s390x
> host big endian   yes
> target list       aarch64-softmmu alpha-softmmu arm-softmmu cris-softmmu =
hppa-softmmu i386-softmmu lm32-softmmu m68k-softmmu microblazeel-softmmu mi=
croblaze-softmmu mips64el-softmmu mips64-softmmu mipsel-softmmu mips-softmm=
u moxie-softmmu nios2-softmmu or1k-softmmu ppc64-softmmu ppcemb-softmmu ppc=
-softmmu riscv32-softmmu riscv64-softmmu s390x-softmmu sh4eb-softmmu sh4-so=
ftmmu sparc64-softmmu sparc-softmmu tricore-softmmu unicore32-softmmu x86_6=
4-softmmu xtensaeb-softmmu xtensa-softmmu aarch64_be-linux-user aarch64-lin=
ux-user alpha-linux-user armeb-linux-user arm-linux-user cris-linux-user hp=
pa-linux-user i386-linux-user m68k-linux-user microblazeel-linux-user micro=
blaze-linux-user mips64el-linux-user mips64-linux-user mipsel-linux-user mi=
ps-linux-user mipsn32el-linux-user mipsn32-linux-user nios2-linux-user or1k=
-linux-user ppc64abi32-linux-user ppc64le-linux-user ppc64-linux-user ppc-l=
inux-user riscv32-linux-user riscv64-linux-user s390x-linux-user sh4eb-linu=
x-user sh4-linux-user sparc32plus-linux-user sparc64-linux-user sparc-linux=
-user tilegx-linux-user x86_64-linux-user xtensaeb-linux-user xtensa-linux-=
user
> gprof enabled     no
> sparse enabled    no
> strip binaries    yes
> profiler          no
> static build      no
> SDL support       yes (2.0.7)
> GTK support       yes (3.22.21)
> GTK GL support    yes
> VTE support       yes (0.48.4)
> TLS priority      NORMAL
> GNUTLS support    yes
> GNUTLS rnd        yes
> libgcrypt         no
> libgcrypt kdf     no
> nettle            yes (3.3)
> nettle kdf        yes
> libtasn1          yes
> curses support    yes
> virgl support     yes (0.6.0)
> curl support      yes
> mingw32 support   no
> Audio drivers     oss
> Block whitelist (rw)=20
> Block whitelist (ro)=20
> VirtFS support    yes
> Multipath support no
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
> HVF support       no
> WHPX support      no
> TCG support       yes
> TCG debug enabled no
> TCG interpreter   no
> malloc trim support yes
> RDMA support      no
> fdt support       system
> membarrier        no
> preadv support    yes
> fdatasync         yes
> madvise           yes
> posix_madvise     yes
> posix_memalign    yes
> libcap-ng support yes
> vhost-net support yes
> vhost-crypto support yes
> vhost-scsi support yes
> vhost-vsock support yes
> vhost-user support yes
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
> seccomp support   yes
> coroutine backend ucontext
> coroutine pool    yes
> debug stack usage no
> crypto afalg      no
> GlusterFS support yes
> gcov              gcov
> gcov enabled      no
> TPM support       yes
> libssh2 support   yes
> TPM passthrough   no
> TPM emulator      yes
> QOM debugging     yes
> Live block migration yes
> lzo support       yes
> snappy support    yes
> bzip2 support     yes
> NUMA host support no
> libxml2           yes
> tcmalloc support  no
> jemalloc support  no
> avx2 optimization no
> replication support yes
> VxHS block device no
> capstone          git
> docker            no
>   GEN     aarch64-softmmu/config-devices.mak.tmp
>   GEN     alpha-softmmu/config-devices.mak.tmp
>   GEN     arm-softmmu/config-devices.mak.tmp
>   GEN     cris-softmmu/config-devices.mak.tmp
>   GEN     cris-softmmu/config-devices.mak
>   GEN     alpha-softmmu/config-devices.mak
>   GEN     arm-softmmu/config-devices.mak
>   GEN     hppa-softmmu/config-devices.mak.tmp
>   GEN     i386-softmmu/config-devices.mak.tmp
>   GEN     lm32-softmmu/config-devices.mak.tmp
>   GEN     aarch64-softmmu/config-devices.mak
>   GEN     m68k-softmmu/config-devices.mak.tmp
>   GEN     lm32-softmmu/config-devices.mak
>   GEN     microblazeel-softmmu/config-devices.mak.tmp
>   GEN     hppa-softmmu/config-devices.mak
>   GEN     m68k-softmmu/config-devices.mak
>   GEN     microblaze-softmmu/config-devices.mak.tmp
>   GEN     mips64el-softmmu/config-devices.mak.tmp
>   GEN     i386-softmmu/config-devices.mak
>   GEN     microblazeel-softmmu/config-devices.mak
>   GEN     mips64-softmmu/config-devices.mak.tmp
>   GEN     mipsel-softmmu/config-devices.mak.tmp
>   GEN     microblaze-softmmu/config-devices.mak
>   GEN     mips-softmmu/config-devices.mak.tmp
>   GEN     mips64el-softmmu/config-devices.mak
>   GEN     moxie-softmmu/config-devices.mak.tmp
>   GEN     mips64-softmmu/config-devices.mak
>   GEN     mipsel-softmmu/config-devices.mak
>   GEN     mips-softmmu/config-devices.mak
>   GEN     moxie-softmmu/config-devices.mak
>   GEN     nios2-softmmu/config-devices.mak.tmp
>   GEN     or1k-softmmu/config-devices.mak.tmp
>   GEN     ppc64-softmmu/config-devices.mak.tmp
>   GEN     ppcemb-softmmu/config-devices.mak.tmp
>   GEN     or1k-softmmu/config-devices.mak
>   GEN     ppc-softmmu/config-devices.mak.tmp
>   GEN     nios2-softmmu/config-devices.mak
>   GEN     riscv32-softmmu/config-devices.mak.tmp
>   GEN     ppcemb-softmmu/config-devices.mak
>   GEN     ppc64-softmmu/config-devices.mak
>   GEN     riscv64-softmmu/config-devices.mak.tmp
>   GEN     s390x-softmmu/config-devices.mak.tmp
>   GEN     riscv32-softmmu/config-devices.mak
>   GEN     sh4eb-softmmu/config-devices.mak.tmp
>   GEN     ppc-softmmu/config-devices.mak
>   GEN     riscv64-softmmu/config-devices.mak
>   GEN     sh4-softmmu/config-devices.mak.tmp
>   GEN     sparc64-softmmu/config-devices.mak.tmp
>   GEN     s390x-softmmu/config-devices.mak
>   GEN     sparc-softmmu/config-devices.mak.tmp
>   GEN     sh4eb-softmmu/config-devices.mak
>   GEN     tricore-softmmu/config-devices.mak.tmp
>   GEN     sparc-softmmu/config-devices.mak
>   GEN     sh4-softmmu/config-devices.mak
>   GEN     sparc64-softmmu/config-devices.mak
>   GEN     unicore32-softmmu/config-devices.mak.tmp
>   GEN     x86_64-softmmu/config-devices.mak.tmp
>   GEN     xtensaeb-softmmu/config-devices.mak.tmp
>   GEN     tricore-softmmu/config-devices.mak
>   GEN     unicore32-softmmu/config-devices.mak
>   GEN     xtensa-softmmu/config-devices.mak.tmp
>   GEN     aarch64_be-linux-user/config-devices.mak.tmp
>   GEN     xtensaeb-softmmu/config-devices.mak
>   GEN     aarch64-linux-user/config-devices.mak.tmp
>   GEN     xtensa-softmmu/config-devices.mak
>   GEN     aarch64_be-linux-user/config-devices.mak
>   GEN     x86_64-softmmu/config-devices.mak
>   GEN     alpha-linux-user/config-devices.mak.tmp
>   GEN     armeb-linux-user/config-devices.mak.tmp
>   GEN     arm-linux-user/config-devices.mak.tmp
>   GEN     aarch64-linux-user/config-devices.mak
>   GEN     armeb-linux-user/config-devices.mak
>   GEN     alpha-linux-user/config-devices.mak
>   GEN     cris-linux-user/config-devices.mak.tmp
>   GEN     i386-linux-user/config-devices.mak.tmp
>   GEN     hppa-linux-user/config-devices.mak.tmp
>   GEN     arm-linux-user/config-devices.mak
>   GEN     m68k-linux-user/config-devices.mak.tmp
>   GEN     cris-linux-user/config-devices.mak
>   GEN     i386-linux-user/config-devices.mak
>   GEN     hppa-linux-user/config-devices.mak
>   GEN     microblazeel-linux-user/config-devices.mak.tmp
>   GEN     microblaze-linux-user/config-devices.mak.tmp
>   GEN     mips64el-linux-user/config-devices.mak.tmp
>   GEN     m68k-linux-user/config-devices.mak
>   GEN     microblazeel-linux-user/config-devices.mak
>   GEN     microblaze-linux-user/config-devices.mak
>   GEN     mips64-linux-user/config-devices.mak.tmp
>   GEN     mipsel-linux-user/config-devices.mak.tmp
>   GEN     mips-linux-user/config-devices.mak.tmp
>   GEN     mips64el-linux-user/config-devices.mak
>   GEN     mipsn32el-linux-user/config-devices.mak.tmp
>   GEN     mips64-linux-user/config-devices.mak
>   GEN     mips-linux-user/config-devices.mak
>   GEN     mipsel-linux-user/config-devices.mak
>   GEN     mipsn32-linux-user/config-devices.mak.tmp
>   GEN     nios2-linux-user/config-devices.mak.tmp
>   GEN     or1k-linux-user/config-devices.mak.tmp
>   GEN     mipsn32el-linux-user/config-devices.mak
>   GEN     ppc64abi32-linux-user/config-devices.mak.tmp
>   GEN     or1k-linux-user/config-devices.mak
>   GEN     mipsn32-linux-user/config-devices.mak
>   GEN     nios2-linux-user/config-devices.mak
>   GEN     ppc64-linux-user/config-devices.mak.tmp
>   GEN     ppc64le-linux-user/config-devices.mak.tmp
>   GEN     ppc-linux-user/config-devices.mak.tmp
>   GEN     ppc64abi32-linux-user/config-devices.mak
>   GEN     ppc64le-linux-user/config-devices.mak
>   GEN     ppc64-linux-user/config-devices.mak
>   GEN     riscv32-linux-user/config-devices.mak.tmp
>   GEN     riscv64-linux-user/config-devices.mak.tmp
>   GEN     ppc-linux-user/config-devices.mak
>   GEN     s390x-linux-user/config-devices.mak.tmp
>   GEN     sh4eb-linux-user/config-devices.mak.tmp
>   GEN     riscv32-linux-user/config-devices.mak
>   GEN     s390x-linux-user/config-devices.mak
>   GEN     riscv64-linux-user/config-devices.mak
>   GEN     sh4eb-linux-user/config-devices.mak
>   GEN     sh4-linux-user/config-devices.mak.tmp
>   GEN     sparc64-linux-user/config-devices.mak.tmp
>   GEN     sparc32plus-linux-user/config-devices.mak.tmp
>   GEN     sparc-linux-user/config-devices.mak.tmp
>   GEN     sh4-linux-user/config-devices.mak
>   GEN     sparc64-linux-user/config-devices.mak
>   GEN     sparc32plus-linux-user/config-devices.mak
>   GEN     tilegx-linux-user/config-devices.mak.tmp
>   GEN     x86_64-linux-user/config-devices.mak.tmp
>   GEN     sparc-linux-user/config-devices.mak
>   GEN     xtensaeb-linux-user/config-devices.mak.tmp
>   GEN     xtensa-linux-user/config-devices.mak.tmp
>   GEN     tilegx-linux-user/config-devices.mak
>   GEN     xtensaeb-linux-user/config-devices.mak
>   GEN     x86_64-linux-user/config-devices.mak
>   GEN     config-host.h
>   GIT     ui/keycodemapdb capstone
>   GEN     xtensa-linux-user/config-devices.mak
>   GEN     qemu-options.def
>   GEN     qapi-gen
>   GEN     trace/generated-tcg-tracers.h
>   GEN     trace/generated-helpers-wrappers.h
> Submodule 'capstone' (git://git.qemu.org/capstone.git) registered for pat=
h 'capstone'
> Submodule 'ui/keycodemapdb' (git://git.qemu.org/keycodemapdb.git) registe=
red for path 'ui/keycodemapdb'
>   GEN     trace/generated-helpers.h
> Cloning into '/var/tmp/patchew-tester-tmp-4ppomfuh/src/capstone'...
>   GEN     trace/generated-helpers.c
>   GEN     module_block.h
>   GEN     tests/test-qapi-gen
>   GEN     trace-root.h
>   GEN     accel/kvm/trace.h
>   GEN     accel/tcg/trace.h
>   GEN     audio/trace.h
>   GEN     block/trace.h
>   GEN     chardev/trace.h
>   GEN     crypto/trace.h
>   GEN     hw/9pfs/trace.h
>   GEN     hw/acpi/trace.h
>   GEN     hw/alpha/trace.h
>   GEN     hw/arm/trace.h
>   GEN     hw/audio/trace.h
>   GEN     hw/block/trace.h
>   GEN     hw/block/dataplane/trace.h
>   GEN     hw/char/trace.h
>   GEN     hw/display/trace.h
>   GEN     hw/dma/trace.h
>   GEN     hw/hppa/trace.h
>   GEN     hw/i2c/trace.h
>   GEN     hw/i386/trace.h
>   GEN     hw/i386/xen/trace.h
>   GEN     hw/ide/trace.h
>   GEN     hw/input/trace.h
>   GEN     hw/intc/trace.h
>   GEN     hw/isa/trace.h
>   GEN     hw/mem/trace.h
>   GEN     hw/misc/trace.h
>   GEN     hw/misc/macio/trace.h
>   GEN     hw/net/trace.h
>   GEN     hw/nvram/trace.h
>   GEN     hw/pci/trace.h
>   GEN     hw/pci-host/trace.h
>   GEN     hw/ppc/trace.h
>   GEN     hw/rdma/trace.h
>   GEN     hw/rdma/vmw/trace.h
>   GEN     hw/s390x/trace.h
>   GEN     hw/scsi/trace.h
>   GEN     hw/sd/trace.h
>   GEN     hw/sparc/trace.h
>   GEN     hw/sparc64/trace.h
>   GEN     hw/timer/trace.h
>   GEN     hw/tpm/trace.h
>   GEN     hw/usb/trace.h
>   GEN     hw/vfio/trace.h
>   GEN     hw/virtio/trace.h
>   GEN     hw/xen/trace.h
>   GEN     io/trace.h
>   GEN     linux-user/trace.h
>   GEN     migration/trace.h
>   GEN     nbd/trace.h
>   GEN     net/trace.h
>   GEN     qapi/trace.h
>   GEN     qom/trace.h
>   GEN     scsi/trace.h
>   GEN     target/arm/trace.h
>   GEN     target/i386/trace.h
>   GEN     target/mips/trace.h
>   GEN     target/ppc/trace.h
>   GEN     target/s390x/trace.h
>   GEN     target/sparc/trace.h
>   GEN     ui/trace.h
>   GEN     util/trace.h
>   GEN     trace-root.c
>   GEN     accel/kvm/trace.c
>   GEN     accel/tcg/trace.c
>   GEN     audio/trace.c
>   GEN     block/trace.c
>   GEN     chardev/trace.c
>   GEN     crypto/trace.c
>   GEN     hw/9pfs/trace.c
>   GEN     hw/acpi/trace.c
>   GEN     hw/alpha/trace.c
>   GEN     hw/arm/trace.c
>   GEN     hw/audio/trace.c
>   GEN     hw/block/trace.c
>   GEN     hw/block/dataplane/trace.c
>   GEN     hw/char/trace.c
>   GEN     hw/display/trace.c
>   GEN     hw/dma/trace.c
>   GEN     hw/hppa/trace.c
>   GEN     hw/i2c/trace.c
>   GEN     hw/i386/trace.c
>   GEN     hw/i386/xen/trace.c
>   GEN     hw/ide/trace.c
>   GEN     hw/input/trace.c
>   GEN     hw/intc/trace.c
>   GEN     hw/isa/trace.c
>   GEN     hw/mem/trace.c
>   GEN     hw/misc/trace.c
>   GEN     hw/misc/macio/trace.c
>   GEN     hw/net/trace.c
>   GEN     hw/nvram/trace.c
>   GEN     hw/pci/trace.c
>   GEN     hw/pci-host/trace.c
>   GEN     hw/ppc/trace.c
>   GEN     hw/rdma/trace.c
>   GEN     hw/rdma/vmw/trace.c
>   GEN     hw/s390x/trace.c
>   GEN     hw/scsi/trace.c
>   GEN     hw/sd/trace.c
>   GEN     hw/sparc/trace.c
>   GEN     hw/sparc64/trace.c
>   GEN     hw/timer/trace.c
>   GEN     hw/tpm/trace.c
>   GEN     hw/usb/trace.c
>   GEN     hw/vfio/trace.c
>   GEN     hw/virtio/trace.c
>   GEN     hw/xen/trace.c
>   GEN     io/trace.c
>   GEN     linux-user/trace.c
>   GEN     migration/trace.c
>   GEN     nbd/trace.c
>   GEN     net/trace.c
>   GEN     qapi/trace.c
>   GEN     qom/trace.c
>   GEN     scsi/trace.c
>   GEN     target/arm/trace.c
>   GEN     target/i386/trace.c
>   GEN     target/mips/trace.c
>   GEN     target/ppc/trace.c
>   GEN     target/s390x/trace.c
>   GEN     target/sparc/trace.c
>   GEN     ui/trace.c
>   GEN     util/trace.c
>   GEN     config-all-devices.mak
> Cloning into '/var/tmp/patchew-tester-tmp-4ppomfuh/src/ui/keycodemapdb'...
>   GEN     ui/input-keymap-atset1-to-qcode.c
>   GEN     ui/input-keymap-linux-to-qcode.c
>   GEN     ui/input-keymap-qcode-to-atset1.c
>   GEN     ui/input-keymap-qcode-to-atset2.c
>   GEN     ui/input-keymap-qcode-to-atset3.c
>   GEN     ui/input-keymap-qcode-to-linux.c
>   GEN     ui/input-keymap-qcode-to-qnum.c
>   GEN     ui/input-keymap-qcode-to-sun.c
>   GEN     ui/input-keymap-qnum-to-qcode.c
>   GEN     ui/input-keymap-usb-to-qcode.c
>   GEN     ui/input-keymap-win32-to-qcode.c
>   CC      cs.o
>   GEN     ui/input-keymap-x11-to-qcode.c
>   GEN     ui/input-keymap-xorgevdev-to-qcode.c
>   GEN     ui/input-keymap-xorgkbd-to-qcode.c
>   GEN     ui/input-keymap-xorgxquartz-to-qcode.c
>   GEN     ui/input-keymap-xorgxwin-to-qcode.c
>   GEN     ui/input-keymap-osx-to-qcode.c
>   CC      utils.o
>   CC      SStream.o
>   CC      MCInstrDesc.o
>   CC      MCRegisterInfo.o
>   CC      arch/ARM/ARMDisassembler.o
>   CC      arch/ARM/ARMInstPrinter.o
>   CC      arch/ARM/ARMMapping.o
>   CC      arch/ARM/ARMModule.o
>   CC      arch/AArch64/AArch64BaseInfo.o
>   CC      arch/AArch64/AArch64Disassembler.o
>   CC      arch/AArch64/AArch64InstPrinter.o
>   CC      arch/AArch64/AArch64Mapping.o
>   CC      arch/AArch64/AArch64Module.o
>   CC      arch/Mips/MipsDisassembler.o
>   CC      arch/Mips/MipsInstPrinter.o
>   CC      arch/Mips/MipsMapping.o
>   CC      arch/Mips/MipsModule.o
>   CC      arch/PowerPC/PPCDisassembler.o
>   CC      arch/PowerPC/PPCInstPrinter.o
>   CC      arch/PowerPC/PPCMapping.o
>   CC      arch/PowerPC/PPCModule.o
>   CC      arch/Sparc/SparcDisassembler.o
>   CC      arch/Sparc/SparcInstPrinter.o
>   CC      arch/Sparc/SparcMapping.o
>   CC      arch/Sparc/SparcModule.o
>   CC      arch/SystemZ/SystemZDisassembler.o
>   CC      arch/SystemZ/SystemZInstPrinter.o
>   CC      arch/SystemZ/SystemZMapping.o
>   CC      arch/SystemZ/SystemZModule.o
>   CC      arch/SystemZ/SystemZMCTargetDesc.o
>   CC      arch/X86/X86DisassemblerDecoder.o
>   CC      arch/X86/X86Disassembler.o
>   CC      arch/X86/X86IntelInstPrinter.o
>   CC      arch/X86/X86ATTInstPrinter.o
>   CC      arch/X86/X86Mapping.o
>   CC      arch/X86/X86Module.o
>   CC      arch/XCore/XCoreDisassembler.o
>   CC      arch/XCore/XCoreInstPrinter.o
>   CC      arch/XCore/XCoreMapping.o
>   CC      arch/XCore/XCoreModule.o
>   CC      MCInst.o
>   AR      libcapstone.a
> ar: creating /var/tmp/patchew-tester-tmp-4ppomfuh/src/build/capstone/libc=
apstone.a
>   GEN     docs/version.texi
>   GEN     qemu-options.texi
>   CC      tests/qemu-iotests/socket_scm_helper.o
>   GEN     qemu-monitor.texi
>   GEN     qemu-img-cmds.texi
>   GEN     qemu-monitor-info.texi
>   GEN     qemu-img.1
>   GEN     qemu-nbd.8
>   GEN     qemu-ga.8
>   GEN     qga/qapi-generated/qapi-gen
>   GEN     docs/qemu-block-drivers.7
>   GEN     fsdev/virtfs-proxy-helper.1
>   CC      qapi/qapi-builtin-types.o
>   CC      qapi/qapi-types.o
>   CC      qapi/qapi-types-block-core.o
>   CC      qapi/qapi-types-block.o
>   CC      qapi/qapi-types-char.o
>   CC      qapi/qapi-types-common.o
>   CC      qapi/qapi-types-crypto.o
>   CC      qapi/qapi-types-introspect.o
>   CC      qapi/qapi-types-migration.o
>   CC      qapi/qapi-types-job.o
>   CC      qapi/qapi-types-misc.o
>   CC      qapi/qapi-types-net.o
>   CC      qapi/qapi-types-rocker.o
>   CC      qapi/qapi-types-run-state.o
>   CC      qapi/qapi-types-sockets.o
>   CC      qapi/qapi-types-tpm.o
>   CC      qapi/qapi-types-trace.o
>   CC      qapi/qapi-types-transaction.o
>   CC      qapi/qapi-types-ui.o
>   CC      qapi/qapi-builtin-visit.o
>   CC      qapi/qapi-visit.o
>   CC      qapi/qapi-visit-block-core.o
>   CC      qapi/qapi-visit-block.o
>   CC      qapi/qapi-visit-char.o
>   CC      qapi/qapi-visit-common.o
>   CC      qapi/qapi-visit-crypto.o
>   CC      qapi/qapi-visit-introspect.o
>   CC      qapi/qapi-visit-job.o
>   CC      qapi/qapi-visit-migration.o
>   CC      qapi/qapi-visit-misc.o
>   CC      qapi/qapi-visit-net.o
>   CC      qapi/qapi-visit-rocker.o
>   CC      qapi/qapi-visit-run-state.o
>   CC      qapi/qapi-visit-sockets.o
>   CC      qapi/qapi-visit-tpm.o
>   CC      qapi/qapi-visit-trace.o
>   CC      qapi/qapi-visit-transaction.o
>   CC      qapi/qapi-visit-ui.o
>   CC      qapi/qapi-events.o
>   CC      qapi/qapi-events-block-core.o
>   CC      qapi/qapi-events-block.o
>   CC      qapi/qapi-events-char.o
>   CC      qapi/qapi-events-common.o
>   CC      qapi/qapi-events-crypto.o
>   CC      qapi/qapi-events-introspect.o
>   CC      qapi/qapi-events-job.o
>   CC      qapi/qapi-events-migration.o
>   CC      qapi/qapi-events-misc.o
>   CC      qapi/qapi-events-net.o
>   CC      qapi/qapi-events-rocker.o
>   CC      qapi/qapi-events-run-state.o
>   CC      qapi/qapi-events-sockets.o
>   CC      qapi/qapi-events-tpm.o
>   CC      qapi/qapi-events-trace.o
>   CC      qapi/qapi-events-transaction.o
>   CC      qapi/qapi-events-ui.o
>   CC      qapi/qapi-introspect.o
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
>   CC      qobject/qnum.o
>   CC      qobject/qstring.o
>   CC      qobject/qdict.o
>   CC      qobject/qlist.o
>   CC      qobject/qbool.o
>   CC      qobject/qlit.o
>   CC      qobject/qjson.o
>   CC      qobject/qobject.o
>   CC      qobject/json-lexer.o
>   CC      qobject/json-streamer.o
>   CC      qobject/json-parser.o
>   CC      qobject/block-qdict.o
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
>   CC      util/aio-wait.o
>   CC      util/thread-pool.o
>   CC      util/qemu-timer.o
>   CC      util/main-loop.o
>   CC      util/iohandler.o
>   CC      util/aio-posix.o
>   CC      util/compatfd.o
>   CC      util/event_notifier-posix.o
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
>   CC      util/bitops.o
>   CC      util/hbitmap.o
>   CC      util/fifo8.o
>   CC      util/acl.o
>   CC      util/cacheinfo.o
>   CC      util/error.o
>   CC      util/qemu-error.o
>   CC      util/id.o
>   CC      util/iov.o
>   CC      util/qemu-config.o
>   CC      util/qemu-sockets.o
>   CC      util/uri.o
>   CC      util/notify.o
>   CC      util/qemu-option.o
>   CC      util/qemu-progress.o
>   CC      util/keyval.o
>   CC      util/hexdump.o
>   CC      util/crc32c.o
>   CC      util/throttle.o
>   CC      util/uuid.o
>   CC      util/getauxval.o
>   CC      util/readline.o
>   CC      util/rcu.o
>   CC      util/qemu-coroutine.o
>   CC      util/qemu-coroutine-lock.o
>   CC      util/qemu-coroutine-io.o
>   CC      util/qemu-coroutine-sleep.o
>   CC      util/coroutine-ucontext.o
>   CC      util/buffer.o
>   CC      util/timed-average.o
>   CC      util/base64.o
>   CC      util/log.o
>   CC      util/pagesize.o
>   CC      util/qdist.o
>   CC      util/qht.o
>   CC      util/range.o
>   CC      util/stats64.o
>   CC      util/systemd.o
>   CC      util/iova-tree.o
>   CC      util/vfio-helpers.o
>   CC      trace-root.o
>   CC      accel/kvm/trace.o
>   CC      accel/tcg/trace.o
>   CC      audio/trace.o
>   CC      block/trace.o
>   CC      chardev/trace.o
>   CC      crypto/trace.o
>   CC      hw/9pfs/trace.o
>   CC      hw/acpi/trace.o
>   CC      hw/alpha/trace.o
>   CC      hw/arm/trace.o
>   CC      hw/audio/trace.o
>   CC      hw/block/trace.o
>   CC      hw/block/dataplane/trace.o
>   CC      hw/char/trace.o
>   CC      hw/display/trace.o
>   CC      hw/dma/trace.o
>   CC      hw/hppa/trace.o
>   CC      hw/i2c/trace.o
>   CC      hw/i386/trace.o
>   CC      hw/i386/xen/trace.o
>   CC      hw/ide/trace.o
>   CC      hw/input/trace.o
>   CC      hw/intc/trace.o
>   CC      hw/isa/trace.o
>   CC      hw/mem/trace.o
>   CC      hw/misc/trace.o
>   CC      hw/misc/macio/trace.o
>   CC      hw/net/trace.o
>   CC      hw/nvram/trace.o
>   CC      hw/pci/trace.o
>   CC      hw/pci-host/trace.o
>   CC      hw/ppc/trace.o
>   CC      hw/rdma/trace.o
>   CC      hw/rdma/vmw/trace.o
>   CC      hw/s390x/trace.o
>   CC      hw/scsi/trace.o
>   CC      hw/sd/trace.o
>   CC      hw/sparc/trace.o
>   CC      hw/sparc64/trace.o
>   CC      hw/timer/trace.o
>   CC      hw/tpm/trace.o
>   CC      hw/usb/trace.o
>   CC      hw/vfio/trace.o
>   CC      hw/virtio/trace.o
>   CC      hw/xen/trace.o
>   CC      io/trace.o
>   CC      linux-user/trace.o
>   CC      migration/trace.o
>   CC      nbd/trace.o
>   CC      net/trace.o
>   CC      qapi/trace.o
>   CC      qom/trace.o
>   CC      scsi/trace.o
>   CC      target/arm/trace.o
>   CC      target/i386/trace.o
>   CC      target/mips/trace.o
>   CC      target/ppc/trace.o
>   CC      target/s390x/trace.o
>   CC      target/sparc/trace.o
>   CC      ui/trace.o
>   CC      util/trace.o
>   CC      crypto/pbkdf-stub.o
>   CC      stubs/arch-query-cpu-def.o
>   CC      stubs/arch-query-cpu-model-expansion.o
>   CC      stubs/arch-query-cpu-model-comparison.o
>   CC      stubs/arch-query-cpu-model-baseline.o
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
>   CC      stubs/iothread.o
>   CC      stubs/iothread-lock.o
>   CC      stubs/is-daemonized.o
>   CC      stubs/linux-aio.o
>   CC      stubs/machine-init-done.o
>   CC      stubs/migr-blocker.o
>   CC      stubs/change-state-handler.o
>   CC      stubs/monitor.o
>   CC      stubs/notify-event.o
>   CC      stubs/qtest.o
>   CC      stubs/replay.o
>   CC      stubs/runstate-check.o
>   CC      stubs/set-fd-handler.o
>   CC      stubs/slirp.o
>   CC      stubs/sysbus.o
>   CC      stubs/tpm.o
>   CC      stubs/trace-control.o
>   CC      stubs/uuid.o
>   CC      stubs/vm-stop.o
>   CC      stubs/vmstate.o
>   CC      stubs/qmp_memory_device.o
>   CC      stubs/target-monitor-defs.o
>   CC      stubs/target-get-monitor-def.o
>   CC      stubs/pc_madt_cpu_entry.o
>   CC      stubs/vmgenid.o
>   CC      stubs/xen-common.o
>   CC      stubs/xen-hvm.o
>   CC      stubs/pci-host-piix.o
>   CC      stubs/ram-block.o
>   CC      qemu-keymap.o
>   CC      ui/input-keymap.o
>   CC      contrib/ivshmem-client/ivshmem-client.o
>   CC      contrib/ivshmem-client/main.o
>   CC      contrib/ivshmem-server/ivshmem-server.o
>   CC      contrib/ivshmem-server/main.o
>   CC      qemu-nbd.o
>   CC      block.o
>   CC      blockjob.o
>   CC      job.o
>   CC      qemu-io-cmds.o
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
>   CC      block/qcow2.o
>   CC      block/qcow2-refcount.o
>   CC      block/qcow2-cluster.o
>   CC      block/qcow2-snapshot.o
>   CC      block/qcow2-cache.o
>   CC      block/qcow2-bitmap.o
>   CC      block/qed.o
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
>   CC      block/mirror.o
>   CC      block/commit.o
>   CC      block/io.o
>   CC      block/create.o
>   CC      block/throttle-groups.o
>   CC      block/nvme.o
>   CC      block/nbd.o
>   CC      block/nbd-client.o
>   CC      block/sheepdog.o
>   CC      block/iscsi-opts.o
>   CC      block/accounting.o
>   CC      block/dirty-bitmap.o
>   CC      block/write-threshold.o
>   CC      block/backup.o
>   CC      block/replication.o
>   CC      block/throttle.o
>   CC      block/copy-on-read.o
>   CC      block/crypto.o
>   CC      nbd/server.o
>   CC      nbd/client.o
>   CC      nbd/common.o
>   CC      scsi/utils.o
>   CC      scsi/pr-manager.o
>   CC      scsi/pr-manager-helper.o
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
>   CC      io/net-listener.o
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
>   CC      scsi/qemu-pr-helper.o
>   CC      qemu-bridge-helper.o
>   CC      blockdev.o
>   CC      blockdev-nbd.o
>   CC      bootdevice.o
>   CC      iothread.o
>   CC      job-qmp.o
>   CC      qdev-monitor.o
>   CC      device-hotplug.o
>   CC      os-posix.o
>   CC      bt-host.o
>   CC      bt-vhci.o
>   CC      dma-helpers.o
>   CC      vl.o
>   CC      tpm.o
>   CC      qemu-seccomp.o
>   CC      device_tree.o
>   CC      qapi/qapi-commands.o
>   CC      qapi/qapi-commands-block-core.o
>   CC      qapi/qapi-commands-block.o
>   CC      qapi/qapi-commands-char.o
>   CC      qapi/qapi-commands-common.o
>   CC      qapi/qapi-commands-crypto.o
>   CC      qapi/qapi-commands-introspect.o
>   CC      qapi/qapi-commands-job.o
>   CC      qapi/qapi-commands-misc.o
>   CC      qapi/qapi-commands-migration.o
>   CC      qapi/qapi-commands-net.o
>   CC      qapi/qapi-commands-rocker.o
>   CC      qapi/qapi-commands-run-state.o
>   CC      qapi/qapi-commands-sockets.o
>   CC      qapi/qapi-commands-tpm.o
>   CC      qapi/qapi-commands-trace.o
>   CC      qapi/qapi-commands-transaction.o
>   CC      qapi/qapi-commands-ui.o
>   CC      qmp.o
>   CC      hmp.o
>   CC      cpus-common.o
>   CC      audio/audio.o
>   CC      audio/noaudio.o
>   CC      audio/wavaudio.o
>   CC      audio/mixeng.o
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
>   CC      backends/cryptodev-vhost.o
>   CC      backends/cryptodev-vhost-user.o
>   CC      backends/hostmem-memfd.o
>   CC      block/stream.o
>   CC      chardev/msmouse.o
>   CC      chardev/wctablet.o
>   CC      chardev/testdev.o
>   CC      chardev/baum.o
>   CC      disas/alpha.o
>   CC      disas/arm.o
>   CXX     disas/arm-a64.o
>   CC      disas/cris.o
>   CC      disas/hppa.o
>   CC      disas/i386.o
>   CC      disas/m68k.o
>   CC      disas/microblaze.o
>   CC      disas/mips.o
>   CC      disas/nios2.o
>   CC      disas/moxie.o
>   CC      disas/ppc.o
>   CC      disas/riscv.o
>   CC      disas/s390.o
>   CC      disas/sh4.o
>   CC      disas/sparc.o
>   CC      disas/lm32.o
>   CC      disas/xtensa.o
>   CXX     disas/libvixl/vixl/utils.o
>   CXX     disas/libvixl/vixl/compiler-intrinsics.o
>   CXX     disas/libvixl/vixl/a64/instructions-a64.o
>   CXX     disas/libvixl/vixl/a64/decoder-a64.o
>   CXX     disas/libvixl/vixl/a64/disasm-a64.o
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
>   CC      hw/block/hd-geometry.o
>   CC      hw/block/cdrom.o
>   CC      hw/block/fdc.o
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
>   CC      hw/char/parallel-isa.o
>   CC      hw/char/pl011.o
>   CC      hw/char/serial.o
>   CC      hw/char/serial-isa.o
>   CC      hw/char/serial-pci.o
>   CC      hw/char/virtio-console.o
>   CC      hw/char/xilinx_uartlite.o
>   CC      hw/char/cadence_uart.o
>   CC      hw/char/cmsdk-apb-uart.o
>   CC      hw/char/etraxfs_ser.o
>   CC      hw/char/debugcon.o
>   CC      hw/char/grlib_apbuart.o
>   CC      hw/char/imx_serial.o
>   CC      hw/char/lm32_juart.o
>   CC      hw/char/lm32_uart.o
>   CC      hw/char/milkymist-uart.o
>   CC      hw/char/sclpconsole.o
>   CC      hw/char/sclpconsole-lm.o
>   CC      hw/core/qdev.o
>   CC      hw/core/qdev-properties.o
>   CC      hw/core/bus.o
>   CC      hw/core/reset.o
>   CC      hw/core/qdev-fw.o
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
>   CC      hw/core/split-irq.o
>   CC      hw/core/platform-bus.o
>   CC      hw/cpu/core.o
>   CC      hw/display/ramfb.o
>   CC      hw/display/ramfb-standalone.o
>   CC      hw/display/ads7846.o
>   CC      hw/display/cirrus_vga.o
>   CC      hw/display/g364fb.o
>   CC      hw/display/jazz_led.o
>   CC      hw/display/pl110.o
>   CC      hw/display/sii9022.o
>   CC      hw/display/ssd0303.o
>   CC      hw/display/ssd0323.o
>   CC      hw/display/vga-pci.o
>   CC      hw/display/bochs-display.o
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
>   CC      hw/dma/xlnx-zdma.o
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
>   CC      hw/ide/ahci-allwinner.o
>   CC      hw/ide/sii3112.o
>   CC      hw/input/adb.o
>   CC      hw/input/adb-mouse.o
>   CC      hw/input/adb-kbd.o
>   CC      hw/input/hid.o
>   CC      hw/input/lm832x.o
>   CC      hw/input/pckbd.o
>   CC      hw/input/pl050.o
>   CC      hw/input/ps2.o
>   CC      hw/input/stellaris_input.o
>   CC      hw/input/tsc2005.o
>   CC      hw/input/virtio-input.o
>   CC      hw/input/virtio-input-hid.o
>   CC      hw/input/virtio-input-host.o
>   CC      hw/intc/heathrow_pic.o
>   CC      hw/intc/i8259_common.o
>   CC      hw/intc/i8259.o
>   CC      hw/intc/pl190.o
>   CC      hw/intc/puv3_intc.o
>   CC      hw/intc/xilinx_intc.o
>   CC      hw/intc/xlnx-pmu-iomod-intc.o
>   CC      hw/intc/xlnx-zynqmp-ipi.o
>   CC      hw/intc/etraxfs_pic.o
>   CC      hw/intc/imx_avic.o
>   CC      hw/intc/imx_gpcv2.o
>   CC      hw/intc/lm32_pic.o
>   CC      hw/intc/realview_gic.o
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
>   CC      hw/isa/isa-superio.o
>   CC      hw/isa/smc37c669-superio.o
>   CC      hw/isa/apm.o
>   CC      hw/isa/i82378.o
>   CC      hw/isa/pc87312.o
>   CC      hw/isa/piix4.o
>   CC      hw/isa/vt82c686.o
>   CC      hw/mem/pc-dimm.o
>   CC      hw/mem/memory-device.o
>   CC      hw/mem/nvdimm.o
>   CC      hw/misc/applesmc.o
>   CC      hw/misc/max111x.o
>   CC      hw/misc/tmp105.o
>   CC      hw/misc/tmp421.o
>   CC      hw/misc/debugexit.o
>   CC      hw/misc/sga.o
>   CC      hw/misc/pc-testdev.o
>   CC      hw/misc/pci-testdev.o
>   CC      hw/misc/edu.o
>   CC      hw/misc/pca9552.o
>   CC      hw/misc/unimp.o
>   CC      hw/misc/vmcoreinfo.o
>   CC      hw/misc/arm_l2x0.o
>   CC      hw/misc/arm_integrator_debug.o
>   CC      hw/misc/a9scu.o
>   CC      hw/misc/arm11scu.o
>   CC      hw/misc/mos6522.o
>   CC      hw/misc/puv3_pm.o
>   CC      hw/misc/macio/macio.o
>   CC      hw/misc/macio/cuda.o
>   CC      hw/misc/macio/pmu.o
>   CC      hw/misc/macio/mac_dbdma.o
>   CC      hw/misc/macio/gpio.o
>   CC      hw/net/dp8393x.o
>   CC      hw/net/ne2000.o
>   CC      hw/net/eepro100.o
>   CC      hw/net/pcnet-pci.o
>   CC      hw/net/pcnet.o
>   CC      hw/net/e1000.o
>   CC      hw/net/e1000x_common.o
>   CC      hw/net/net_tx_pkt.o
>   CC      hw/net/net_rx_pkt.o
>   CC      hw/net/e1000e.o
>   CC      hw/net/e1000e_core.o
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
>   CC      hw/net/imx_fec.o
>   CC      hw/net/cadence_gem.o
>   CC      hw/net/stellaris_enet.o
>   CC      hw/net/lance.o
>   CC      hw/net/sunhme.o
>   CC      hw/net/ftgmac100.o
>   CC      hw/net/sungem.o
>   CC      hw/net/rocker/rocker.o
>   CC      hw/net/rocker/rocker_fp.o
>   CC      hw/net/rocker/rocker_desc.o
>   CC      hw/net/rocker/rocker_world.o
>   CC      hw/net/rocker/rocker_of_dpa.o
>   CC      hw/net/can/can_sja1000.o
>   CC      hw/net/can/can_kvaser_pci.o
>   CC      hw/net/can/can_pcm3680_pci.o
>   CC      hw/net/can/can_mioe3680_pci.o
>   CC      hw/nvram/ds1225y.o
>   CC      hw/nvram/eeprom93xx.o
>   CC      hw/nvram/eeprom_at24c.o
>   CC      hw/nvram/fw_cfg.o
>   CC      hw/nvram/chrp_nvram.o
>   CC      hw/nvram/mac_nvram.o
>   CC      hw/pci-bridge/pci_bridge_dev.o
>   CC      hw/pci-bridge/pcie_root_port.o
>   CC      hw/pci-bridge/gen_pcie_root_port.o
>   CC      hw/pci-bridge/pcie_pci_bridge.o
>   CC      hw/pci-bridge/pci_expander_bridge.o
>   CC      hw/pci-bridge/xio3130_upstream.o
>   CC      hw/pci-bridge/xio3130_downstream.o
>   CC      hw/pci-bridge/ioh3420.o
>   CC      hw/pci-bridge/i82801b11.o
>   CC      hw/pci-bridge/dec.o
>   CC      hw/pci-bridge/simba.o
>   CC      hw/pci-host/pam.o
>   CC      hw/pci-host/prep.o
>   CC      hw/pci-host/grackle.o
>   CC      hw/pci-host/uninorth.o
>   CC      hw/pci-host/ppce500.o
>   CC      hw/pci-host/versatile.o
>   CC      hw/pci-host/sabre.o
>   CC      hw/pci-host/bonito.o
>   CC      hw/pci-host/piix.o
>   CC      hw/pci-host/q35.o
>   CC      hw/pci-host/gpex.o
>   CC      hw/pci-host/xilinx-pcie.o
>   CC      hw/pci-host/designware.o
>   CC      hw/pci/pci.o
>   CC      hw/pci/pci_bridge.o
>   CC      hw/pci/msix.o
>   CC      hw/pci/msi.o
>   CC      hw/pci/shpc.o
>   CC      hw/pci/slotid_cap.o
>   CC      hw/pci/pci_host.o
>   CC      hw/pci/pcie_host.o
>   CC      hw/pci/pcie.o
>   CC      hw/pci/pcie_aer.o
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
>   CC      hw/sd/sd.o
>   CC      hw/sd/core.o
>   CC      hw/sd/sdmmc-internal.o
>   CC      hw/sd/sdhci.o
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
>   CC      hw/ssi/mss-spi.o
>   CC      hw/timer/arm_timer.o
>   CC      hw/timer/arm_mptimer.o
>   CC      hw/timer/armv7m_systick.o
>   CC      hw/timer/a9gtimer.o
>   CC      hw/timer/cadence_ttc.o
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
>   CC      hw/timer/xlnx-zynqmp-rtc.o
>   CC      hw/timer/stm32f2xx_timer.o
>   CC      hw/timer/aspeed_timer.o
>   CC      hw/timer/sun4v-rtc.o
>   CC      hw/timer/cmsdk-apb-timer.o
>   CC      hw/timer/mss-timer.o
>   CC      hw/tpm/tpm_util.o
>   CC      hw/tpm/tpm_tis.o
>   CC      hw/tpm/tpm_crb.o
>   CC      hw/tpm/tpm_emulator.o
>   CC      hw/usb/core.o
>   CC      hw/usb/combined-packet.o
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
>   CC      hw/usb/host-stub.o
>   CC      hw/virtio/virtio-bus.o
>   CC      hw/virtio/virtio-rng.o
>   CC      hw/virtio/virtio-pci.o
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
>   CC      migration/global_state.o
>   CC      migration/qemu-file-channel.o
>   CC      migration/xbzrle.o
>   CC      migration/postcopy-ram.o
>   CC      migration/qjson.o
>   CC      migration/block-dirty-bitmap.o
>   CC      migration/block.o
>   CC      net/net.o
>   CC      net/queue.o
>   CC      net/checksum.o
>   CC      net/util.o
>   CC      net/hub.o
>   CC      net/socket.o
>   CC      net/dump.o
>   CC      net/eth.o
>   CC      net/l2tpv3.o
>   CC      net/vhost-user.o
>   CC      net/slirp.o
>   CC      net/filter.o
>   CC      net/filter-buffer.o
>   CC      net/filter-mirror.o
>   CC      net/colo-compare.o
>   CC      net/colo.o
>   CC      net/filter-rewriter.o
>   CC      net/filter-replay.o
>   CC      net/tap.o
>   CC      net/tap-linux.o
>   CC      net/can/can_core.o
>   CC      net/can/can_host.o
>   CC      net/can/can_socketcan.o
>   CC      qom/cpu.o
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
>   CC      slirp/ip_output.o
>   CC      slirp/dnssearch.o
>   CC      slirp/dhcpv6.o
>   CC      slirp/slirp.o
>   CC      slirp/mbuf.o
>   CC      slirp/misc.o
>   CC      slirp/sbuf.o
>   CC      slirp/socket.o
>   CC      slirp/tcp_input.o
>   CC      slirp/tcp_output.o
>   CC      slirp/tcp_subr.o
>   CC      slirp/tcp_timer.o
>   CC      slirp/udp.o
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
>   CC      ui/input-legacy.o
>   CC      ui/input-linux.o
>   CC      ui/vnc.o
>   CC      ui/vnc-enc-zlib.o
>   CC      ui/vnc-enc-hextile.o
>   CC      ui/vnc-enc-tight.o
>   CC      ui/vnc-palette.o
>   CC      ui/vnc-enc-zrle.o
>   CC      ui/vnc-auth-vencrypt.o
>   CC      ui/vnc-auth-sasl.o
>   CC      ui/vnc-ws.o
>   CC      ui/vnc-jobs.o
>   VERT    ui/shader/texture-blit-vert.h
>   VERT    ui/shader/texture-blit-flip-vert.h
>   FRAG    ui/shader/texture-blit-frag.h
>   CC      ui/console-gl.o
>   CC      ui/egl-helpers.o
>   CC      ui/egl-context.o
>   CC      ui/egl-headless.o
>   CC      audio/ossaudio.o
>   CC      ui/sdl2.o
>   CC      ui/sdl2-input.o
>   CC      ui/sdl2-2d.o
>   CC      ui/sdl2-gl.o
>   CC      ui/x_keymap.o
>   CC      ui/gtk.o
>   CC      ui/gtk-egl.o
>   CC      ui/gtk-gl-area.o
>   CC      ui/curses.o
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
>   LINK    tests/qemu-iotests/socket_scm_helper
>   GEN     qemu-doc.html
>   CC      s390-ccw/main.o
>   GEN     qemu-doc.txt
>   CC      s390-ccw/bootmap.o
>   GEN     qemu.1
>   CC      s390-ccw/jump2ipl.o
>   CC      s390-ccw/sclp.o
>   CC      s390-ccw/menu.o
>   GEN     docs/interop/qemu-qmp-ref.html
>   CC      s390-ccw/virtio.o
>   GEN     docs/interop/qemu-qmp-ref.txt
>   CC      s390-ccw/virtio-scsi.o
>   GEN     docs/interop/qemu-qmp-ref.7
>   CC      s390-ccw/virtio-blkdev.o
>   CC      s390-ccw/libc.o
> s390-netboot.img not built since roms/SLOF/ is not available.
>   BUILD   s390-ccw/s390-ccw.elf
>   CC      qga/commands.o
>   STRIP   s390-ccw/s390-ccw.img
>   CC      qga/guest-agent-command-state.o
>   CC      qga/main.o
>   CC      qga/commands-posix.o
>   CC      qga/channel-posix.o
>   CC      qga/qapi-generated/qga-qapi-types.o
>   CC      qga/qapi-generated/qga-qapi-visit.o
>   CC      qga/qapi-generated/qga-qapi-commands.o
>   AR      libqemuutil.a
>   CC      qemu-img.o
>   CC      ui/shader.o
>   GEN     docs/interop/qemu-ga-ref.html
>   GEN     docs/interop/qemu-ga-ref.txt
>   GEN     docs/interop/qemu-ga-ref.7
>   LINK    qemu-ga
>   LINK    qemu-keymap
>   LINK    ivshmem-client
>   LINK    ivshmem-server
>   LINK    qemu-nbd
>   LINK    qemu-io
>   LINK    fsdev/virtfs-proxy-helper
>   LINK    scsi/qemu-pr-helper
>   LINK    qemu-bridge-helper
>   GEN     cris-softmmu/hmp-commands.h
>   GEN     cris-softmmu/hmp-commands-info.h
>   GEN     aarch64-softmmu/hmp-commands.h
>   GEN     aarch64-softmmu/hmp-commands-info.h
>   GEN     aarch64-softmmu/config-target.h
>   GEN     cris-softmmu/config-target.h
>   GEN     alpha-softmmu/hmp-commands.h
>   CC      aarch64-softmmu/exec.o
>   CC      cris-softmmu/exec.o
>   GEN     alpha-softmmu/hmp-commands-info.h
>   GEN     alpha-softmmu/config-target.h
>   GEN     arm-softmmu/hmp-commands.h
>   CC      alpha-softmmu/exec.o
>   GEN     arm-softmmu/hmp-commands-info.h
>   GEN     arm-softmmu/config-target.h
>   CC      arm-softmmu/exec.o
>   CC      cris-softmmu/tcg/tcg.o
>   CC      alpha-softmmu/tcg/tcg.o
>   CC      arm-softmmu/tcg/tcg.o
>   CC      aarch64-softmmu/tcg/tcg.o
>   CC      cris-softmmu/tcg/tcg-op.o
>   CC      alpha-softmmu/tcg/tcg-op.o
>   CC      arm-softmmu/tcg/tcg-op.o
>   CC      aarch64-softmmu/tcg/tcg-op.o
>   CC      cris-softmmu/tcg/tcg-op-vec.o
>   CC      cris-softmmu/tcg/tcg-op-gvec.o
>   CC      alpha-softmmu/tcg/tcg-op-vec.o
>   CC      arm-softmmu/tcg/tcg-op-vec.o
>   CC      alpha-softmmu/tcg/tcg-op-gvec.o
>   CC      cris-softmmu/tcg/tcg-common.o
>   CC      aarch64-softmmu/tcg/tcg-op-vec.o
>   CC      arm-softmmu/tcg/tcg-op-gvec.o
>   CC      cris-softmmu/tcg/optimize.o
>   CC      aarch64-softmmu/tcg/tcg-op-gvec.o
>   CC      alpha-softmmu/tcg/tcg-common.o
>   CC      cris-softmmu/fpu/softfloat.o
>   CC      alpha-softmmu/tcg/optimize.o
>   CC      arm-softmmu/tcg/tcg-common.o
>   CC      alpha-softmmu/fpu/softfloat.o
>   CC      arm-softmmu/tcg/optimize.o
>   CC      aarch64-softmmu/tcg/tcg-common.o
>   CC      arm-softmmu/fpu/softfloat.o
>   CC      aarch64-softmmu/tcg/optimize.o
>   CC      aarch64-softmmu/fpu/softfloat.o
>   CC      cris-softmmu/disas.o
>   CC      cris-softmmu/arch_init.o
>   CC      cris-softmmu/cpus.o
>   CC      alpha-softmmu/disas.o
>   CC      arm-softmmu/disas.o
>   CC      cris-softmmu/monitor.o
>   CC      alpha-softmmu/arch_init.o
>   GEN     arm-softmmu/gdbstub-xml.c
>   CC      alpha-softmmu/cpus.o
>   CC      alpha-softmmu/monitor.o
>   CC      aarch64-softmmu/disas.o
>   CC      arm-softmmu/arch_init.o
>   CC      cris-softmmu/gdbstub.o
>   CC      arm-softmmu/cpus.o
>   GEN     aarch64-softmmu/gdbstub-xml.c
>   CC      cris-softmmu/balloon.o
>   CC      arm-softmmu/monitor.o
>   CC      alpha-softmmu/gdbstub.o
>   CC      aarch64-softmmu/arch_init.o
>   CC      cris-softmmu/ioport.o
>   CC      cris-softmmu/numa.o
>   CC      aarch64-softmmu/cpus.o
>   CC      cris-softmmu/qtest.o
>   CC      alpha-softmmu/balloon.o
>   CC      alpha-softmmu/ioport.o
>   CC      aarch64-softmmu/monitor.o
>   CC      cris-softmmu/memory.o
>   CC      arm-softmmu/gdbstub.o
>   CC      alpha-softmmu/numa.o
>   CC      alpha-softmmu/qtest.o
>   CC      arm-softmmu/balloon.o
>   CC      alpha-softmmu/memory.o
>   CC      cris-softmmu/memory_mapping.o
>   CC      arm-softmmu/ioport.o
>   CC      aarch64-softmmu/gdbstub.o
>   CC      arm-softmmu/numa.o
>   CC      cris-softmmu/dump.o
>   CC      arm-softmmu/qtest.o
>   CC      alpha-softmmu/memory_mapping.o
>   CC      cris-softmmu/migration/ram.o
>   CC      aarch64-softmmu/balloon.o
>   CC      alpha-softmmu/dump.o
>   CC      arm-softmmu/memory.o
>   CC      aarch64-softmmu/ioport.o
>   CC      alpha-softmmu/migration/ram.o
>   CC      cris-softmmu/accel/accel.o
>   CC      aarch64-softmmu/numa.o
>   CC      cris-softmmu/accel/stubs/hax-stub.o
>   CC      aarch64-softmmu/qtest.o
>   CC      arm-softmmu/memory_mapping.o
>   CC      cris-softmmu/accel/stubs/hvf-stub.o
>   CC      alpha-softmmu/accel/accel.o
>   CC      arm-softmmu/dump.o
>   CC      aarch64-softmmu/memory.o
>   CC      cris-softmmu/accel/stubs/whpx-stub.o
>   CC      alpha-softmmu/accel/stubs/hax-stub.o
>   CC      cris-softmmu/accel/stubs/kvm-stub.o
>   CC      cris-softmmu/accel/tcg/tcg-all.o
>   CC      alpha-softmmu/accel/stubs/hvf-stub.o
>   CC      cris-softmmu/accel/tcg/cputlb.o
>   CC      arm-softmmu/migration/ram.o
>   CC      alpha-softmmu/accel/stubs/whpx-stub.o
>   CC      aarch64-softmmu/memory_mapping.o
>   CC      alpha-softmmu/accel/stubs/kvm-stub.o
>   CC      aarch64-softmmu/dump.o
>   CC      alpha-softmmu/accel/tcg/tcg-all.o
>   CC      arm-softmmu/accel/accel.o
>   CC      alpha-softmmu/accel/tcg/cputlb.o
>   CC      arm-softmmu/accel/stubs/hax-stub.o
>   CC      aarch64-softmmu/migration/ram.o
>   CC      arm-softmmu/accel/stubs/hvf-stub.o
>   CC      cris-softmmu/accel/tcg/tcg-runtime.o
>   CC      arm-softmmu/accel/stubs/whpx-stub.o
>   CC      cris-softmmu/accel/tcg/tcg-runtime-gvec.o
>   CC      arm-softmmu/accel/stubs/kvm-stub.o
>   CC      aarch64-softmmu/accel/accel.o
>   CC      aarch64-softmmu/accel/stubs/hax-stub.o
>   CC      arm-softmmu/accel/tcg/tcg-all.o
>   CC      aarch64-softmmu/accel/stubs/hvf-stub.o
>   CC      arm-softmmu/accel/tcg/cputlb.o
>   CC      aarch64-softmmu/accel/stubs/whpx-stub.o
>   CC      alpha-softmmu/accel/tcg/tcg-runtime.o
>   CC      cris-softmmu/accel/tcg/cpu-exec.o
>   CC      aarch64-softmmu/accel/stubs/kvm-stub.o
>   CC      alpha-softmmu/accel/tcg/tcg-runtime-gvec.o
>   CC      cris-softmmu/accel/tcg/cpu-exec-common.o
>   CC      aarch64-softmmu/accel/tcg/tcg-all.o
>   CC      cris-softmmu/accel/tcg/translate-all.o
>   CC      aarch64-softmmu/accel/tcg/cputlb.o
>   CC      cris-softmmu/accel/tcg/translator.o
>   CC      alpha-softmmu/accel/tcg/cpu-exec.o
>   CC      cris-softmmu/hw/core/generic-loader.o
>   CC      cris-softmmu/hw/core/null-machine.o
>   CC      alpha-softmmu/accel/tcg/cpu-exec-common.o
>   CC      arm-softmmu/accel/tcg/tcg-runtime.o
>   CC      cris-softmmu/hw/misc/mmio_interface.o
>   CC      alpha-softmmu/accel/tcg/translate-all.o
>   CC      cris-softmmu/hw/net/etraxfs_eth.o
>   CC      arm-softmmu/accel/tcg/tcg-runtime-gvec.o
>   CC      alpha-softmmu/accel/tcg/translator.o
>   CC      cris-softmmu/hw/net/vhost_net.o
>   CC      aarch64-softmmu/accel/tcg/tcg-runtime.o
>   CC      alpha-softmmu/hw/9pfs/virtio-9p-device.o
>   CC      cris-softmmu/hw/net/rocker/qmp-norocker.o
>   CC      arm-softmmu/accel/tcg/cpu-exec.o
>   CC      cris-softmmu/hw/vfio/common.o
>   CC      aarch64-softmmu/accel/tcg/tcg-runtime-gvec.o
>   CC      alpha-softmmu/hw/block/virtio-blk.o
>   CC      arm-softmmu/accel/tcg/cpu-exec-common.o
>   CC      arm-softmmu/accel/tcg/translate-all.o
>   CC      cris-softmmu/hw/vfio/platform.o
>   CC      alpha-softmmu/hw/block/vhost-user-blk.o
>   CC      aarch64-softmmu/accel/tcg/cpu-exec.o
>   CC      arm-softmmu/accel/tcg/translator.o
>   CC      alpha-softmmu/hw/block/dataplane/virtio-blk.o
>   CC      cris-softmmu/hw/vfio/spapr.o
>   CC      aarch64-softmmu/accel/tcg/cpu-exec-common.o
>   CC      arm-softmmu/hw/9pfs/virtio-9p-device.o
>   CC      alpha-softmmu/hw/char/virtio-serial-bus.o
>   CC      aarch64-softmmu/accel/tcg/translate-all.o
>   CC      cris-softmmu/hw/cris/boot.o
>   CC      arm-softmmu/hw/adc/stm32f2xx_adc.o
>   CC      alpha-softmmu/hw/core/generic-loader.o
>   CC      arm-softmmu/hw/block/virtio-blk.o
>   CC      cris-softmmu/hw/cris/axis_dev88.o
>   CC      aarch64-softmmu/accel/tcg/translator.o
>   CC      alpha-softmmu/hw/core/null-machine.o
>   CC      cris-softmmu/target/cris/translate.o
>   CC      arm-softmmu/hw/block/vhost-user-blk.o
>   CC      alpha-softmmu/hw/display/vga.o
>   CC      arm-softmmu/hw/block/dataplane/virtio-blk.o
>   CC      aarch64-softmmu/hw/9pfs/virtio-9p-device.o
>   CC      arm-softmmu/hw/char/exynos4210_uart.o
>   CC      aarch64-softmmu/hw/adc/stm32f2xx_adc.o
>   CC      arm-softmmu/hw/char/omap_uart.o
>   CC      alpha-softmmu/hw/display/virtio-gpu.o
>   CC      aarch64-softmmu/hw/block/virtio-blk.o
>   CC      arm-softmmu/hw/char/digic-uart.o
>   CC      arm-softmmu/hw/char/stm32f2xx_usart.o
>   CC      cris-softmmu/target/cris/op_helper.o
>   CC      aarch64-softmmu/hw/block/vhost-user-blk.o
>   CC      alpha-softmmu/hw/display/virtio-gpu-3d.o
>   CC      arm-softmmu/hw/char/bcm2835_aux.o
>   CC      cris-softmmu/target/cris/helper.o
>   CC      aarch64-softmmu/hw/block/dataplane/virtio-blk.o
>   CC      arm-softmmu/hw/char/virtio-serial-bus.o
>   CC      cris-softmmu/target/cris/cpu.o
>   CC      aarch64-softmmu/hw/char/exynos4210_uart.o
>   CC      alpha-softmmu/hw/display/virtio-gpu-pci.o
>   CC      cris-softmmu/target/cris/gdbstub.o
>   CC      aarch64-softmmu/hw/char/omap_uart.o
>   CC      cris-softmmu/target/cris/mmu.o
>   CC      alpha-softmmu/hw/misc/ivshmem.o
>   CC      aarch64-softmmu/hw/char/digic-uart.o
>   CC      arm-softmmu/hw/core/generic-loader.o
>   CC      cris-softmmu/target/cris/machine.o
>   CC      aarch64-softmmu/hw/char/stm32f2xx_usart.o
>   CC      alpha-softmmu/hw/misc/mmio_interface.o
>   CC      arm-softmmu/hw/core/null-machine.o
>   GEN     trace/generated-helpers.c
>   CC      cris-softmmu/trace/control-target.o
>   CC      aarch64-softmmu/hw/char/bcm2835_aux.o
>   CC      alpha-softmmu/hw/net/virtio-net.o
>   CC      arm-softmmu/hw/cpu/arm11mpcore.o
>   CC      cris-softmmu/trace/generated-helpers.o
>   CC      aarch64-softmmu/hw/char/virtio-serial-bus.o
>   LINK    cris-softmmu/qemu-system-cris
>   CC      arm-softmmu/hw/cpu/realview_mpcore.o
>   CC      aarch64-softmmu/hw/core/generic-loader.o
>   CC      alpha-softmmu/hw/net/vhost_net.o
>   CC      arm-softmmu/hw/cpu/a9mpcore.o
>   CC      aarch64-softmmu/hw/core/null-machine.o
>   CC      alpha-softmmu/hw/scsi/virtio-scsi.o
>   CC      aarch64-softmmu/hw/cpu/arm11mpcore.o
>   CC      aarch64-softmmu/hw/cpu/realview_mpcore.o
>   CC      arm-softmmu/hw/cpu/a15mpcore.o
>   CC      alpha-softmmu/hw/scsi/virtio-scsi-dataplane.o
>   CC      aarch64-softmmu/hw/cpu/a9mpcore.o
>   CC      arm-softmmu/hw/display/omap_dss.o
>   CC      alpha-softmmu/hw/scsi/vhost-scsi-common.o
>   CC      arm-softmmu/hw/display/omap_lcdc.o
>   CC      aarch64-softmmu/hw/cpu/a15mpcore.o
>   CC      alpha-softmmu/hw/scsi/vhost-scsi.o
>   CC      aarch64-softmmu/hw/display/omap_dss.o
>   CC      arm-softmmu/hw/display/pxa2xx_lcd.o
>   CC      arm-softmmu/hw/display/bcm2835_fb.o
>   CC      alpha-softmmu/hw/scsi/vhost-user-scsi.o
>   CC      arm-softmmu/hw/display/vga.o
>   CC      aarch64-softmmu/hw/display/omap_lcdc.o
>   CC      arm-softmmu/hw/display/virtio-gpu.o
>   CC      aarch64-softmmu/hw/display/pxa2xx_lcd.o
>   CC      arm-softmmu/hw/display/virtio-gpu-3d.o
>   CC      arm-softmmu/hw/display/virtio-gpu-pci.o
>   CC      aarch64-softmmu/hw/display/bcm2835_fb.o
>   CC      arm-softmmu/hw/dma/omap_dma.o
>   CC      alpha-softmmu/hw/timer/mc146818rtc.o
>   CC      aarch64-softmmu/hw/display/vga.o
>   CC      aarch64-softmmu/hw/display/virtio-gpu.o
>   CC      arm-softmmu/hw/dma/soc_dma.o
>   CC      arm-softmmu/hw/dma/pxa2xx_dma.o
>   CC      arm-softmmu/hw/dma/bcm2835_dma.o
>   CC      alpha-softmmu/hw/vfio/common.o
>   CC      aarch64-softmmu/hw/display/virtio-gpu-3d.o
>   CC      aarch64-softmmu/hw/display/virtio-gpu-pci.o
>   CC      arm-softmmu/hw/gpio/omap_gpio.o
>   CC      alpha-softmmu/hw/vfio/pci.o
>   CC      aarch64-softmmu/hw/display/dpcd.o
>   CC      arm-softmmu/hw/gpio/imx_gpio.o
>   CC      arm-softmmu/hw/gpio/bcm2835_gpio.o
>   CC      aarch64-softmmu/hw/display/xlnx_dp.o
>   CC      alpha-softmmu/hw/vfio/pci-quirks.o
>   CC      aarch64-softmmu/hw/dma/xlnx_dpdma.o
>   CC      aarch64-softmmu/hw/dma/omap_dma.o
>   CC      alpha-softmmu/hw/vfio/display.o
>   GEN     hppa-softmmu/hmp-commands.h
>   GEN     hppa-softmmu/hmp-commands-info.h
>   GEN     hppa-softmmu/config-target.h
>   CC      hppa-softmmu/exec.o
>   CC      alpha-softmmu/hw/vfio/platform.o
>   CC      aarch64-softmmu/hw/dma/soc_dma.o
>   CC      aarch64-softmmu/hw/dma/pxa2xx_dma.o
>   CC      alpha-softmmu/hw/vfio/spapr.o
>   CC      aarch64-softmmu/hw/dma/bcm2835_dma.o
>   CC      alpha-softmmu/hw/virtio/virtio.o
>   CC      aarch64-softmmu/hw/gpio/omap_gpio.o
>   CC      aarch64-softmmu/hw/gpio/imx_gpio.o
>   CC      aarch64-softmmu/hw/gpio/bcm2835_gpio.o
>   CC      aarch64-softmmu/hw/i2c/omap_i2c.o
>   CC      hppa-softmmu/tcg/tcg.o
>   CC      alpha-softmmu/hw/virtio/virtio-balloon.o
>   CC      aarch64-softmmu/hw/input/pxa2xx_keypad.o
>   CC      alpha-softmmu/hw/virtio/virtio-crypto.o
>   CC      aarch64-softmmu/hw/input/tsc210x.o
>   CC      alpha-softmmu/hw/virtio/virtio-crypto-pci.o
>   CC      aarch64-softmmu/hw/intc/armv7m_nvic.o
>   CC      alpha-softmmu/hw/virtio/vhost.o
>   CC      hppa-softmmu/tcg/tcg-op.o
>   CC      aarch64-softmmu/hw/intc/exynos4210_gic.o
>   CC      alpha-softmmu/hw/virtio/vhost-backend.o
>   CC      alpha-softmmu/hw/virtio/vhost-user.o
>   CC      aarch64-softmmu/hw/intc/exynos4210_combiner.o
>   CC      aarch64-softmmu/hw/intc/omap_intc.o
>   CC      alpha-softmmu/hw/virtio/vhost-vsock.o
>   CC      aarch64-softmmu/hw/intc/bcm2835_ic.o
>   CC      alpha-softmmu/hw/alpha/dp264.o
>   CC      aarch64-softmmu/hw/intc/bcm2836_control.o
>   CC      alpha-softmmu/hw/alpha/pci.o
>   CC      aarch64-softmmu/hw/intc/allwinner-a10-pic.o
>   CC      alpha-softmmu/hw/alpha/typhoon.o
>   CC      aarch64-softmmu/hw/intc/aspeed_vic.o
>   CC      hppa-softmmu/tcg/tcg-op-vec.o
>   CC      aarch64-softmmu/hw/intc/arm_gicv3_cpuif.o
>   CC      alpha-softmmu/target/alpha/machine.o
>   CC      alpha-softmmu/target/alpha/translate.o
>   CC      hppa-softmmu/tcg/tcg-op-gvec.o
>   CC      aarch64-softmmu/hw/misc/ivshmem.o
>   CC      aarch64-softmmu/hw/misc/arm_sysctl.o
>   CC      aarch64-softmmu/hw/misc/cbus.o
>   CC      aarch64-softmmu/hw/misc/exynos4210_pmu.o
>   CC      alpha-softmmu/target/alpha/helper.o
>   CC      hppa-softmmu/tcg/tcg-common.o
>   CC      aarch64-softmmu/hw/misc/exynos4210_clk.o
>   CC      hppa-softmmu/tcg/optimize.o
>   CC      alpha-softmmu/target/alpha/cpu.o
>   CC      aarch64-softmmu/hw/misc/exynos4210_rng.o
>   CC      alpha-softmmu/target/alpha/int_helper.o
>   CC      aarch64-softmmu/hw/misc/imx_ccm.o
>   CC      alpha-softmmu/target/alpha/fpu_helper.o
>   CC      aarch64-softmmu/hw/misc/imx31_ccm.o
>   CC      hppa-softmmu/fpu/softfloat.o
>   CC      aarch64-softmmu/hw/misc/imx25_ccm.o
>   CC      alpha-softmmu/target/alpha/vax_helper.o
>   CC      aarch64-softmmu/hw/misc/imx6_ccm.o
>   CC      alpha-softmmu/target/alpha/sys_helper.o
>   CC      aarch64-softmmu/hw/misc/imx6_src.o
>   CC      alpha-softmmu/target/alpha/mem_helper.o
>   CC      aarch64-softmmu/hw/misc/imx7_ccm.o
>   CC      alpha-softmmu/target/alpha/gdbstub.o
>   CC      aarch64-softmmu/hw/misc/imx2_wdt.o
>   GEN     trace/generated-helpers.c
>   CC      alpha-softmmu/trace/control-target.o
>   CC      aarch64-softmmu/hw/misc/imx7_snvs.o
>   CC      aarch64-softmmu/hw/misc/imx7_gpr.o
>   CC      alpha-softmmu/trace/generated-helpers.o
>   CC      aarch64-softmmu/hw/misc/mst_fpga.o
>   LINK    alpha-softmmu/qemu-system-alpha
>   CC      aarch64-softmmu/hw/misc/omap_clk.o
>   CC      aarch64-softmmu/hw/misc/omap_gpmc.o
>   CC      aarch64-softmmu/hw/misc/omap_l4.o
>   CC      aarch64-softmmu/hw/misc/omap_sdrc.o
>   CC      aarch64-softmmu/hw/misc/omap_tap.o
>   CC      aarch64-softmmu/hw/misc/bcm2835_mbox.o
>   CC      aarch64-softmmu/hw/misc/bcm2835_property.o
>   CC      hppa-softmmu/disas.o
>   CC      aarch64-softmmu/hw/misc/bcm2835_rng.o
>   CC      hppa-softmmu/arch_init.o
>   CC      arm-softmmu/hw/i2c/omap_i2c.o
>   CC      aarch64-softmmu/hw/misc/zynq_slcr.o
>   CC      aarch64-softmmu/hw/misc/zynq-xadc.o
>   CC      hppa-softmmu/cpus.o
>   CC      aarch64-softmmu/hw/misc/stm32f2xx_syscfg.o
>   CC      arm-softmmu/hw/input/pxa2xx_keypad.o
>   CC      hppa-softmmu/monitor.o
>   CC      arm-softmmu/hw/input/tsc210x.o
>   CC      aarch64-softmmu/hw/misc/mps2-fpgaio.o
>   GEN     i386-softmmu/hmp-commands.h
>   GEN     i386-softmmu/hmp-commands-info.h
>   GEN     i386-softmmu/config-target.h
>   CC      aarch64-softmmu/hw/misc/mps2-scc.o
>   CC      aarch64-softmmu/hw/misc/tz-ppc.o
>   CC      i386-softmmu/exec.o
>   CC      arm-softmmu/hw/intc/armv7m_nvic.o
>   CC      aarch64-softmmu/hw/misc/iotkit-secctl.o
>   CC      aarch64-softmmu/hw/misc/auxbus.o
>   CC      hppa-softmmu/gdbstub.o
>   CC      arm-softmmu/hw/intc/exynos4210_gic.o
>   CC      aarch64-softmmu/hw/misc/aspeed_scu.o
>   CC      aarch64-softmmu/hw/misc/aspeed_sdmc.o
>   CC      hppa-softmmu/balloon.o
>   CC      arm-softmmu/hw/intc/exynos4210_combiner.o
>   CC      aarch64-softmmu/hw/misc/mmio_interface.o
>   CC      hppa-softmmu/ioport.o
>   CC      i386-softmmu/tcg/tcg.o
>   CC      aarch64-softmmu/hw/misc/msf2-sysreg.o
>   CC      arm-softmmu/hw/intc/omap_intc.o
>   CC      hppa-softmmu/numa.o
>   CC      aarch64-softmmu/hw/net/virtio-net.o
>   CC      arm-softmmu/hw/intc/bcm2835_ic.o
>   CC      hppa-softmmu/qtest.o
>   CC      arm-softmmu/hw/intc/bcm2836_control.o
>   CC      arm-softmmu/hw/intc/allwinner-a10-pic.o
>   CC      aarch64-softmmu/hw/net/vhost_net.o
>   CC      hppa-softmmu/memory.o
>   CC      arm-softmmu/hw/intc/aspeed_vic.o
>   CC      aarch64-softmmu/hw/pcmcia/pxa2xx.o
>   CC      arm-softmmu/hw/intc/arm_gicv3_cpuif.o
>   CC      aarch64-softmmu/hw/scsi/virtio-scsi.o
>   CC      i386-softmmu/tcg/tcg-op.o
>   CC      aarch64-softmmu/hw/scsi/virtio-scsi-dataplane.o
>   CC      arm-softmmu/hw/misc/ivshmem.o
>   CC      hppa-softmmu/memory_mapping.o
>   CC      aarch64-softmmu/hw/scsi/vhost-scsi-common.o
>   CC      arm-softmmu/hw/misc/arm_sysctl.o
>   CC      hppa-softmmu/dump.o
>   CC      aarch64-softmmu/hw/scsi/vhost-scsi.o
>   CC      arm-softmmu/hw/misc/cbus.o
>   CC      aarch64-softmmu/hw/scsi/vhost-user-scsi.o
>   CC      hppa-softmmu/migration/ram.o
>   CC      arm-softmmu/hw/misc/exynos4210_pmu.o
>   CC      i386-softmmu/tcg/tcg-op-vec.o
>   CC      aarch64-softmmu/hw/sd/omap_mmc.o
>   CC      arm-softmmu/hw/misc/exynos4210_clk.o
>   CC      aarch64-softmmu/hw/sd/pxa2xx_mmci.o
>   CC      arm-softmmu/hw/misc/exynos4210_rng.o
>   CC      i386-softmmu/tcg/tcg-op-gvec.o
>   CC      aarch64-softmmu/hw/sd/bcm2835_sdhost.o
>   CC      hppa-softmmu/accel/accel.o
>   CC      arm-softmmu/hw/misc/imx_ccm.o
>   CC      arm-softmmu/hw/misc/imx31_ccm.o
>   CC      hppa-softmmu/accel/stubs/hax-stub.o
>   CC      aarch64-softmmu/hw/ssi/omap_spi.o
>   CC      arm-softmmu/hw/misc/imx25_ccm.o
>   CC      hppa-softmmu/accel/stubs/hvf-stub.o
>   CC      arm-softmmu/hw/misc/imx6_ccm.o
>   CC      aarch64-softmmu/hw/ssi/imx_spi.o
>   CC      hppa-softmmu/accel/stubs/whpx-stub.o
>   CC      aarch64-softmmu/hw/timer/exynos4210_mct.o
>   CC      arm-softmmu/hw/misc/imx6_src.o
>   CC      hppa-softmmu/accel/stubs/kvm-stub.o
>   CC      aarch64-softmmu/hw/timer/exynos4210_pwm.o
>   CC      arm-softmmu/hw/misc/imx7_ccm.o
>   CC      hppa-softmmu/accel/tcg/tcg-all.o
>   CC      i386-softmmu/tcg/tcg-common.o
>   CC      aarch64-softmmu/hw/timer/exynos4210_rtc.o
>   CC      arm-softmmu/hw/misc/imx2_wdt.o
>   CC      hppa-softmmu/accel/tcg/cputlb.o
>   CC      i386-softmmu/tcg/optimize.o
>   CC      arm-softmmu/hw/misc/imx7_snvs.o
>   CC      aarch64-softmmu/hw/timer/omap_gptimer.o
>   CC      arm-softmmu/hw/misc/imx7_gpr.o
>   CC      aarch64-softmmu/hw/timer/omap_synctimer.o
>   CC      arm-softmmu/hw/misc/mst_fpga.o
>   CC      i386-softmmu/fpu/softfloat.o
>   CC      aarch64-softmmu/hw/timer/pxa2xx_timer.o
>   CC      arm-softmmu/hw/misc/omap_clk.o
>   CC      aarch64-softmmu/hw/timer/digic-timer.o
>   CC      arm-softmmu/hw/misc/omap_gpmc.o
>   CC      aarch64-softmmu/hw/timer/allwinner-a10-pit.o
>   CC      arm-softmmu/hw/misc/omap_l4.o
>   CC      hppa-softmmu/accel/tcg/tcg-runtime.o
>   CC      aarch64-softmmu/hw/usb/tusb6010.o
>   CC      arm-softmmu/hw/misc/omap_sdrc.o
>   CC      hppa-softmmu/accel/tcg/tcg-runtime-gvec.o
>   CC      aarch64-softmmu/hw/usb/chipidea.o
>   CC      arm-softmmu/hw/misc/omap_tap.o
>   CC      aarch64-softmmu/hw/vfio/common.o
>   CC      arm-softmmu/hw/misc/bcm2835_mbox.o
>   CC      hppa-softmmu/accel/tcg/cpu-exec.o
>   CC      arm-softmmu/hw/misc/bcm2835_property.o
>   CC      aarch64-softmmu/hw/vfio/pci.o
>   CC      hppa-softmmu/accel/tcg/cpu-exec-common.o
>   CC      arm-softmmu/hw/misc/bcm2835_rng.o
>   CC      i386-softmmu/disas.o
>   CC      hppa-softmmu/accel/tcg/translate-all.o
>   CC      arm-softmmu/hw/misc/zynq_slcr.o
>   GEN     i386-softmmu/gdbstub-xml.c
>   CC      aarch64-softmmu/hw/vfio/pci-quirks.o
>   CC      hppa-softmmu/accel/tcg/translator.o
>   CC      arm-softmmu/hw/misc/zynq-xadc.o
>   CC      i386-softmmu/arch_init.o
>   CC      arm-softmmu/hw/misc/stm32f2xx_syscfg.o
>   CC      i386-softmmu/cpus.o
>   CC      hppa-softmmu/hw/9pfs/virtio-9p-device.o
>   CC      arm-softmmu/hw/misc/mps2-fpgaio.o
>   CC      aarch64-softmmu/hw/vfio/display.o
>   CC      hppa-softmmu/hw/block/virtio-blk.o
>   CC      arm-softmmu/hw/misc/mps2-scc.o
>   CC      i386-softmmu/monitor.o
>   CC      arm-softmmu/hw/misc/tz-ppc.o
>   CC      aarch64-softmmu/hw/vfio/platform.o
>   CC      hppa-softmmu/hw/block/vhost-user-blk.o
>   CC      arm-softmmu/hw/misc/iotkit-secctl.o
>   CC      aarch64-softmmu/hw/vfio/calxeda-xgmac.o
>   CC      hppa-softmmu/hw/block/dataplane/virtio-blk.o
>   CC      arm-softmmu/hw/misc/aspeed_scu.o
>   CC      hppa-softmmu/hw/char/virtio-serial-bus.o
>   CC      aarch64-softmmu/hw/vfio/amd-xgbe.o
>   CC      arm-softmmu/hw/misc/aspeed_sdmc.o
>   CC      i386-softmmu/gdbstub.o
>   CC      aarch64-softmmu/hw/vfio/spapr.o
>   CC      hppa-softmmu/hw/core/generic-loader.o
>   CC      arm-softmmu/hw/misc/mmio_interface.o
>   CC      hppa-softmmu/hw/core/null-machine.o
>   CC      aarch64-softmmu/hw/virtio/virtio.o
>   CC      arm-softmmu/hw/misc/msf2-sysreg.o
>   CC      hppa-softmmu/hw/display/vga.o
>   CC      i386-softmmu/balloon.o
>   CC      arm-softmmu/hw/net/virtio-net.o
>   CC      i386-softmmu/ioport.o
>   CC      i386-softmmu/numa.o
>   CC      hppa-softmmu/hw/display/virtio-gpu.o
>   CC      arm-softmmu/hw/net/vhost_net.o
>   CC      aarch64-softmmu/hw/virtio/virtio-balloon.o
>   CC      i386-softmmu/qtest.o
>   CC      arm-softmmu/hw/pcmcia/pxa2xx.o
>   CC      arm-softmmu/hw/scsi/virtio-scsi.o
>   CC      aarch64-softmmu/hw/virtio/virtio-crypto.o
>   CC      i386-softmmu/memory.o
>   CC      hppa-softmmu/hw/display/virtio-gpu-3d.o
>   CC      arm-softmmu/hw/scsi/virtio-scsi-dataplane.o
>   CC      aarch64-softmmu/hw/virtio/virtio-crypto-pci.o
>   CC      arm-softmmu/hw/scsi/vhost-scsi-common.o
>   CC      hppa-softmmu/hw/display/virtio-gpu-pci.o
>   CC      aarch64-softmmu/hw/virtio/vhost.o
>   CC      arm-softmmu/hw/scsi/vhost-scsi.o
>   CC      i386-softmmu/memory_mapping.o
>   CC      hppa-softmmu/hw/display/virtio-vga.o
>   CC      i386-softmmu/dump.o
>   CC      arm-softmmu/hw/scsi/vhost-user-scsi.o
>   CC      aarch64-softmmu/hw/virtio/vhost-backend.o
>   CC      hppa-softmmu/hw/misc/ivshmem.o
>   CC      arm-softmmu/hw/sd/omap_mmc.o
>   CC      aarch64-softmmu/hw/virtio/vhost-user.o
>   CC      hppa-softmmu/hw/misc/mmio_interface.o
>   CC      arm-softmmu/hw/sd/pxa2xx_mmci.o
>   CC      i386-softmmu/migration/ram.o
>   CC      hppa-softmmu/hw/net/virtio-net.o
>   CC      arm-softmmu/hw/sd/bcm2835_sdhost.o
>   CC      aarch64-softmmu/hw/virtio/vhost-vsock.o
>   CC      arm-softmmu/hw/ssi/omap_spi.o
>   CC      aarch64-softmmu/hw/arm/boot.o
>   CC      hppa-softmmu/hw/net/vhost_net.o
>   CC      i386-softmmu/accel/accel.o
>   CC      arm-softmmu/hw/ssi/imx_spi.o
>   CC      hppa-softmmu/hw/scsi/virtio-scsi.o
>   CC      arm-softmmu/hw/timer/exynos4210_mct.o
>   CC      i386-softmmu/accel/stubs/hax-stub.o
>   CC      aarch64-softmmu/hw/arm/virt.o
>   CC      i386-softmmu/accel/stubs/hvf-stub.o
>   CC      arm-softmmu/hw/timer/exynos4210_pwm.o
>   CC      hppa-softmmu/hw/scsi/virtio-scsi-dataplane.o
>   CC      i386-softmmu/accel/stubs/whpx-stub.o
>   CC      arm-softmmu/hw/timer/exynos4210_rtc.o
>   CC      hppa-softmmu/hw/scsi/vhost-scsi-common.o
>   CC      i386-softmmu/accel/stubs/kvm-stub.o
>   CC      arm-softmmu/hw/timer/omap_gptimer.o
>   CC      aarch64-softmmu/hw/arm/sysbus-fdt.o
>   CC      i386-softmmu/accel/tcg/tcg-all.o
>   CC      hppa-softmmu/hw/scsi/vhost-scsi.o
>   CC      i386-softmmu/accel/tcg/cputlb.o
>   CC      arm-softmmu/hw/timer/omap_synctimer.o
>   CC      arm-softmmu/hw/timer/pxa2xx_timer.o
>   CC      aarch64-softmmu/hw/arm/virt-acpi-build.o
>   CC      hppa-softmmu/hw/scsi/vhost-user-scsi.o
>   CC      hppa-softmmu/hw/timer/mc146818rtc.o
>   CC      arm-softmmu/hw/timer/digic-timer.o
>   CC      aarch64-softmmu/hw/arm/digic_boards.o
>   CC      arm-softmmu/hw/timer/allwinner-a10-pit.o
>   CC      hppa-softmmu/hw/vfio/common.o
>   CC      arm-softmmu/hw/usb/tusb6010.o
>   CC      aarch64-softmmu/hw/arm/exynos4_boards.o
>   CC      aarch64-softmmu/hw/arm/highbank.o
>   CC      arm-softmmu/hw/usb/chipidea.o
>   CC      hppa-softmmu/hw/vfio/pci.o
>   CC      aarch64-softmmu/hw/arm/integratorcp.o
>   CC      arm-softmmu/hw/vfio/common.o
>   CC      aarch64-softmmu/hw/arm/mainstone.o
>   CC      i386-softmmu/accel/tcg/tcg-runtime.o
>   CC      aarch64-softmmu/hw/arm/musicpal.o
>   CC      i386-softmmu/accel/tcg/tcg-runtime-gvec.o
>   CC      hppa-softmmu/hw/vfio/pci-quirks.o
>   CC      arm-softmmu/hw/vfio/pci.o
>   CC      aarch64-softmmu/hw/arm/netduino2.o
>   CC      aarch64-softmmu/hw/arm/nseries.o
>   CC      i386-softmmu/accel/tcg/cpu-exec.o
>   CC      hppa-softmmu/hw/vfio/display.o
>   CC      arm-softmmu/hw/vfio/pci-quirks.o
>   CC      i386-softmmu/accel/tcg/cpu-exec-common.o
>   CC      aarch64-softmmu/hw/arm/omap_sx1.o
>   CC      hppa-softmmu/hw/vfio/platform.o
>   CC      i386-softmmu/accel/tcg/translate-all.o
>   CC      arm-softmmu/hw/vfio/display.o
>   CC      aarch64-softmmu/hw/arm/palm.o
>   CC      hppa-softmmu/hw/vfio/spapr.o
>   CC      i386-softmmu/accel/tcg/translator.o
>   CC      arm-softmmu/hw/vfio/platform.o
>   CC      aarch64-softmmu/hw/arm/gumstix.o
>   CC      hppa-softmmu/hw/virtio/virtio.o
>   CC      aarch64-softmmu/hw/arm/spitz.o
>   CC      i386-softmmu/hw/9pfs/virtio-9p-device.o
>   CC      arm-softmmu/hw/vfio/calxeda-xgmac.o
>   CC      aarch64-softmmu/hw/arm/tosa.o
>   CC      arm-softmmu/hw/vfio/amd-xgbe.o
>   CC      i386-softmmu/hw/block/virtio-blk.o
>   CC      aarch64-softmmu/hw/arm/z2.o
>   CC      arm-softmmu/hw/vfio/spapr.o
>   CC      hppa-softmmu/hw/virtio/virtio-balloon.o
>   CC      aarch64-softmmu/hw/arm/realview.o
>   CC      i386-softmmu/hw/block/vhost-user-blk.o
>   CC      arm-softmmu/hw/virtio/virtio.o
>   CC      hppa-softmmu/hw/virtio/virtio-crypto.o
>   CC      i386-softmmu/hw/block/dataplane/virtio-blk.o
>   CC      aarch64-softmmu/hw/arm/stellaris.o
>   CC      i386-softmmu/hw/char/virtio-serial-bus.o
>   CC      hppa-softmmu/hw/virtio/virtio-crypto-pci.o
>   CC      aarch64-softmmu/hw/arm/collie.o
>   CC      hppa-softmmu/hw/virtio/vhost.o
>   CC      i386-softmmu/hw/core/generic-loader.o
>   CC      arm-softmmu/hw/virtio/virtio-balloon.o
>   CC      aarch64-softmmu/hw/arm/vexpress.o
>   CC      i386-softmmu/hw/core/null-machine.o
>   CC      arm-softmmu/hw/virtio/virtio-crypto.o
>   CC      hppa-softmmu/hw/virtio/vhost-backend.o
>   CC      aarch64-softmmu/hw/arm/versatilepb.o
>   CC      i386-softmmu/hw/display/vga.o
>   CC      aarch64-softmmu/hw/arm/xilinx_zynq.o
>   CC      hppa-softmmu/hw/virtio/vhost-user.o
>   CC      arm-softmmu/hw/virtio/virtio-crypto-pci.o
>   CC      aarch64-softmmu/hw/arm/armv7m.o
>   CC      hppa-softmmu/hw/virtio/vhost-vsock.o
>   CC      arm-softmmu/hw/virtio/vhost.o
>   CC      aarch64-softmmu/hw/arm/exynos4210.o
>   CC      hppa-softmmu/hw/hppa/machine.o
>   CC      i386-softmmu/hw/display/virtio-gpu.o
>   CC      aarch64-softmmu/hw/arm/pxa2xx.o
>   CC      arm-softmmu/hw/virtio/vhost-backend.o
>   CC      hppa-softmmu/hw/hppa/pci.o
>   CC      hppa-softmmu/hw/hppa/dino.o
>   CC      arm-softmmu/hw/virtio/vhost-user.o
>   CC      i386-softmmu/hw/display/virtio-gpu-3d.o
>   CC      hppa-softmmu/target/hppa/translate.o
>   CC      aarch64-softmmu/hw/arm/pxa2xx_gpio.o
>   CC      arm-softmmu/hw/virtio/vhost-vsock.o
>   CC      aarch64-softmmu/hw/arm/pxa2xx_pic.o
>   CC      i386-softmmu/hw/display/virtio-gpu-pci.o
>   CC      aarch64-softmmu/hw/arm/digic.o
>   CC      arm-softmmu/hw/arm/boot.o
>   CC      i386-softmmu/hw/display/virtio-vga.o
>   CC      aarch64-softmmu/hw/arm/omap1.o
>   CC      arm-softmmu/hw/arm/virt.o
>   CC      i386-softmmu/hw/intc/apic.o
>   CC      arm-softmmu/hw/arm/sysbus-fdt.o
>   CC      hppa-softmmu/target/hppa/helper.o
>   CC      arm-softmmu/hw/arm/virt-acpi-build.o
>   CC      i386-softmmu/hw/intc/apic_common.o
>   CC      hppa-softmmu/target/hppa/cpu.o
>   CC      aarch64-softmmu/hw/arm/omap2.o
>   CC      arm-softmmu/hw/arm/digic_boards.o
>   CC      hppa-softmmu/target/hppa/op_helper.o
>   CC      i386-softmmu/hw/intc/ioapic.o
>   CC      arm-softmmu/hw/arm/exynos4_boards.o
>   CC      i386-softmmu/hw/isa/lpc_ich9.o
>   CC      aarch64-softmmu/hw/arm/strongarm.o
>   CC      hppa-softmmu/target/hppa/gdbstub.o
>   CC      arm-softmmu/hw/arm/highbank.o
>   CC      hppa-softmmu/target/hppa/mem_helper.o
>   CC      aarch64-softmmu/hw/arm/allwinner-a10.o
>   CC      i386-softmmu/hw/misc/ivshmem.o
>   CC      hppa-softmmu/target/hppa/int_helper.o
>   CC      arm-softmmu/hw/arm/integratorcp.o
>   CC      aarch64-softmmu/hw/arm/cubieboard.o
>   CC      hppa-softmmu/target/hppa/machine.o
>   CC      arm-softmmu/hw/arm/mainstone.o
>   CC      i386-softmmu/hw/misc/pvpanic.o
>   CC      aarch64-softmmu/hw/arm/bcm2835_peripherals.o
>   GEN     trace/generated-helpers.c
>   CC      i386-softmmu/hw/misc/mmio_interface.o
>   CC      arm-softmmu/hw/arm/musicpal.o
>   CC      hppa-softmmu/trace/control-target.o
>   CC      aarch64-softmmu/hw/arm/bcm2836.o
>   CC      hppa-softmmu/trace/generated-helpers.o
>   CC      i386-softmmu/hw/net/virtio-net.o
>   LINK    hppa-softmmu/qemu-system-hppa
>   CC      arm-softmmu/hw/arm/netduino2.o
>   CC      aarch64-softmmu/hw/arm/raspi.o
>   CC      arm-softmmu/hw/arm/nseries.o
>   CC      i386-softmmu/hw/net/vhost_net.o
>   CC      aarch64-softmmu/hw/arm/stm32f205_soc.o
>   CC      arm-softmmu/hw/arm/omap_sx1.o
>   CC      i386-softmmu/hw/scsi/virtio-scsi.o
>   CC      aarch64-softmmu/hw/arm/xlnx-zynqmp.o
>   CC      i386-softmmu/hw/scsi/virtio-scsi-dataplane.o
>   CC      arm-softmmu/hw/arm/palm.o
>   CC      arm-softmmu/hw/arm/gumstix.o
>   CC      i386-softmmu/hw/scsi/vhost-scsi-common.o
>   CC      aarch64-softmmu/hw/arm/xlnx-zcu102.o
>   CC      arm-softmmu/hw/arm/spitz.o
>   CC      i386-softmmu/hw/scsi/vhost-scsi.o
>   CC      aarch64-softmmu/hw/arm/fsl-imx25.o
>   CC      aarch64-softmmu/hw/arm/imx25_pdk.o
>   CC      i386-softmmu/hw/scsi/vhost-user-scsi.o
>   CC      arm-softmmu/hw/arm/tosa.o
>   CC      i386-softmmu/hw/timer/mc146818rtc.o
>   CC      arm-softmmu/hw/arm/z2.o
>   CC      aarch64-softmmu/hw/arm/fsl-imx31.o
>   CC      arm-softmmu/hw/arm/realview.o
>   CC      i386-softmmu/hw/vfio/common.o
>   CC      arm-softmmu/hw/arm/stellaris.o
>   CC      aarch64-softmmu/hw/arm/kzm.o
>   CC      arm-softmmu/hw/arm/collie.o
>   CC      i386-softmmu/hw/vfio/pci.o
>   CC      arm-softmmu/hw/arm/vexpress.o
>   CC      aarch64-softmmu/hw/arm/fsl-imx6.o
>   CC      arm-softmmu/hw/arm/versatilepb.o
>   CC      arm-softmmu/hw/arm/xilinx_zynq.o
>   CC      aarch64-softmmu/hw/arm/sabrelite.o
>   GEN     lm32-softmmu/hmp-commands.h
>   GEN     lm32-softmmu/hmp-commands-info.h
>   GEN     lm32-softmmu/config-target.h
>   CC      lm32-softmmu/exec.o
>   CC      arm-softmmu/hw/arm/armv7m.o
>   CC      i386-softmmu/hw/vfio/pci-quirks.o
>   CC      aarch64-softmmu/hw/arm/aspeed_soc.o
>   CC      arm-softmmu/hw/arm/exynos4210.o
>   CC      aarch64-softmmu/hw/arm/aspeed.o
>   CC      arm-softmmu/hw/arm/pxa2xx.o
>   CC      aarch64-softmmu/hw/arm/mps2.o
>   CC      i386-softmmu/hw/vfio/display.o
>   CC      aarch64-softmmu/hw/arm/mps2-tz.o
>   CC      i386-softmmu/hw/vfio/platform.o
>   CC      arm-softmmu/hw/arm/pxa2xx_gpio.o
>   CC      lm32-softmmu/tcg/tcg.o
>   CC      aarch64-softmmu/hw/arm/msf2-soc.o
>   CC      i386-softmmu/hw/vfio/spapr.o
>   CC      arm-softmmu/hw/arm/pxa2xx_pic.o
>   CC      arm-softmmu/hw/arm/digic.o
>   CC      aarch64-softmmu/hw/arm/msf2-som.o
>   CC      i386-softmmu/hw/virtio/virtio.o
>   CC      aarch64-softmmu/hw/arm/iotkit.o
>   CC      arm-softmmu/hw/arm/omap1.o
>   CC      aarch64-softmmu/hw/arm/fsl-imx7.o
>   CC      lm32-softmmu/tcg/tcg-op.o
>   CC      aarch64-softmmu/hw/arm/mcimx7d-sabre.o
>   CC      i386-softmmu/hw/virtio/virtio-balloon.o
>   CC      arm-softmmu/hw/arm/omap2.o
>   CC      aarch64-softmmu/hw/arm/smmu-common.o
>   CC      i386-softmmu/hw/virtio/virtio-crypto.o
>   CC      aarch64-softmmu/hw/arm/smmuv3.o
>   CC      i386-softmmu/hw/virtio/virtio-crypto-pci.o
>   CC      arm-softmmu/hw/arm/strongarm.o
>   CC      aarch64-softmmu/target/arm/arm-semi.o
>   CC      arm-softmmu/hw/arm/allwinner-a10.o
>   CC      lm32-softmmu/tcg/tcg-op-vec.o
>   CC      i386-softmmu/hw/virtio/vhost.o
>   CC      arm-softmmu/hw/arm/cubieboard.o
>   CC      aarch64-softmmu/target/arm/machine.o
>   CC      lm32-softmmu/tcg/tcg-op-gvec.o
>   CC      arm-softmmu/hw/arm/bcm2835_peripherals.o
>   CC      i386-softmmu/hw/virtio/vhost-backend.o
>   CC      aarch64-softmmu/target/arm/psci.o
>   CC      arm-softmmu/hw/arm/bcm2836.o
>   CC      i386-softmmu/hw/virtio/vhost-user.o
>   CC      aarch64-softmmu/target/arm/arch_dump.o
>   CC      arm-softmmu/hw/arm/raspi.o
>   CC      aarch64-softmmu/target/arm/monitor.o
>   CC      i386-softmmu/hw/virtio/vhost-vsock.o
>   CC      arm-softmmu/hw/arm/stm32f205_soc.o
>   CC      lm32-softmmu/tcg/tcg-common.o
>   CC      i386-softmmu/hw/i386/multiboot.o
>   CC      aarch64-softmmu/target/arm/kvm-stub.o
>   CC      lm32-softmmu/tcg/optimize.o
>   CC      arm-softmmu/hw/arm/fsl-imx25.o
>   CC      aarch64-softmmu/target/arm/translate.o
>   CC      i386-softmmu/hw/i386/pc.o
>   CC      arm-softmmu/hw/arm/imx25_pdk.o
>   CC      arm-softmmu/hw/arm/fsl-imx31.o
>   CC      lm32-softmmu/fpu/softfloat.o
>   CC      arm-softmmu/hw/arm/kzm.o
>   CC      i386-softmmu/hw/i386/pc_piix.o
>   CC      arm-softmmu/hw/arm/fsl-imx6.o
>   CC      i386-softmmu/hw/i386/pc_q35.o
>   CC      arm-softmmu/hw/arm/sabrelite.o
>   CC      i386-softmmu/hw/i386/pc_sysfw.o
>   CC      arm-softmmu/hw/arm/aspeed_soc.o
>   CC      i386-softmmu/hw/i386/x86-iommu.o
>   CC      arm-softmmu/hw/arm/aspeed.o
>   CC      i386-softmmu/hw/i386/intel_iommu.o
>   CC      arm-softmmu/hw/arm/mps2.o
>   CC      arm-softmmu/hw/arm/mps2-tz.o
>   CC      lm32-softmmu/disas.o
>   CC      i386-softmmu/hw/i386/amd_iommu.o
>   CC      arm-softmmu/hw/arm/msf2-soc.o
>   CC      lm32-softmmu/arch_init.o
>   CC      lm32-softmmu/cpus.o
>   CC      arm-softmmu/hw/arm/msf2-som.o
>   CC      i386-softmmu/hw/i386/vmport.o
>   CC      arm-softmmu/hw/arm/iotkit.o
>   CC      i386-softmmu/hw/i386/vmmouse.o
>   CC      lm32-softmmu/monitor.o
>   CC      arm-softmmu/hw/arm/fsl-imx7.o
>   CC      i386-softmmu/hw/i386/kvmvapic.o
>   CC      i386-softmmu/hw/i386/acpi-build.o
>   CC      arm-softmmu/hw/arm/mcimx7d-sabre.o
>   CC      aarch64-softmmu/target/arm/op_helper.o
>   CC      lm32-softmmu/gdbstub.o
>   CC      arm-softmmu/target/arm/arm-semi.o
>   CC      i386-softmmu/target/i386/helper.o
>   CC      arm-softmmu/target/arm/machine.o
>   CC      lm32-softmmu/balloon.o
>   CC      i386-softmmu/target/i386/cpu.o
>   CC      aarch64-softmmu/target/arm/helper.o
>   CC      arm-softmmu/target/arm/psci.o
>   CC      lm32-softmmu/ioport.o
>   CC      arm-softmmu/target/arm/arch_dump.o
>   CC      lm32-softmmu/numa.o
>   CC      i386-softmmu/target/i386/gdbstub.o
>   CC      arm-softmmu/target/arm/monitor.o
>   CC      arm-softmmu/target/arm/kvm-stub.o
>   CC      i386-softmmu/target/i386/xsave_helper.o
>   CC      lm32-softmmu/qtest.o
>   CC      i386-softmmu/target/i386/translate.o
>   CC      arm-softmmu/target/arm/translate.o
>   CC      lm32-softmmu/memory.o
>   CC      lm32-softmmu/memory_mapping.o
>   CC      aarch64-softmmu/target/arm/cpu.o
>   CC      lm32-softmmu/dump.o
>   CC      aarch64-softmmu/target/arm/neon_helper.o
>   CC      lm32-softmmu/migration/ram.o
>   CC      lm32-softmmu/accel/accel.o
>   CC      aarch64-softmmu/target/arm/iwmmxt_helper.o
>   CC      lm32-softmmu/accel/stubs/hax-stub.o
>   CC      lm32-softmmu/accel/stubs/hvf-stub.o
>   CC      lm32-softmmu/accel/stubs/whpx-stub.o
>   CC      aarch64-softmmu/target/arm/vec_helper.o
>   CC      i386-softmmu/target/i386/bpt_helper.o
>   CC      lm32-softmmu/accel/stubs/kvm-stub.o
>   CC      i386-softmmu/target/i386/cc_helper.o
>   CC      aarch64-softmmu/target/arm/gdbstub.o
>   CC      lm32-softmmu/accel/tcg/tcg-all.o
>   CC      i386-softmmu/target/i386/excp_helper.o
>   CC      aarch64-softmmu/target/arm/cpu64.o
>   CC      lm32-softmmu/accel/tcg/cputlb.o
>   CC      i386-softmmu/target/i386/fpu_helper.o
>   CC      aarch64-softmmu/target/arm/translate-a64.o
>   CC      arm-softmmu/target/arm/op_helper.o
>   CC      arm-softmmu/target/arm/helper.o
>   CC      lm32-softmmu/accel/tcg/tcg-runtime.o
>   CC      i386-softmmu/target/i386/int_helper.o
>   CC      lm32-softmmu/accel/tcg/tcg-runtime-gvec.o
>   CC      i386-softmmu/target/i386/mem_helper.o
>   CC      i386-softmmu/target/i386/misc_helper.o
>   CC      lm32-softmmu/accel/tcg/cpu-exec.o
>   CC      i386-softmmu/target/i386/mpx_helper.o
>   CC      lm32-softmmu/accel/tcg/cpu-exec-common.o
>   CC      lm32-softmmu/accel/tcg/translate-all.o
>   CC      arm-softmmu/target/arm/cpu.o
>   CC      aarch64-softmmu/target/arm/helper-a64.o
>   CC      i386-softmmu/target/i386/seg_helper.o
>   CC      lm32-softmmu/accel/tcg/translator.o
>   CC      arm-softmmu/target/arm/neon_helper.o
>   CC      aarch64-softmmu/target/arm/gdbstub64.o
>   CC      lm32-softmmu/hw/core/generic-loader.o
>   CC      aarch64-softmmu/target/arm/crypto_helper.o
>   CC      lm32-softmmu/hw/core/null-machine.o
>   CC      lm32-softmmu/hw/input/milkymist-softusb.o
>   CC      aarch64-softmmu/target/arm/arm-powerctl.o
>   CC      arm-softmmu/target/arm/iwmmxt_helper.o
>   CC      lm32-softmmu/hw/misc/milkymist-hpdmc.o
>   GEN     aarch64-softmmu/target/arm/decode-sve.inc.c
>   CC      aarch64-softmmu/target/arm/sve_helper.o
>   CC      i386-softmmu/target/i386/smm_helper.o
>   CC      lm32-softmmu/hw/misc/milkymist-pfpu.o
>   CC      lm32-softmmu/hw/misc/mmio_interface.o
>   CC      i386-softmmu/target/i386/svm_helper.o
>   CC      lm32-softmmu/hw/net/milkymist-minimac2.o
>   CC      arm-softmmu/target/arm/vec_helper.o
>   CC      lm32-softmmu/hw/net/vhost_net.o
>   CC      i386-softmmu/target/i386/machine.o
>   CC      lm32-softmmu/hw/net/rocker/qmp-norocker.o
>   CC      lm32-softmmu/hw/sd/milkymist-memcard.o
>   CC      arm-softmmu/target/arm/gdbstub.o
>   CC      i386-softmmu/target/i386/arch_memory_mapping.o
>   CC      arm-softmmu/target/arm/crypto_helper.o
>   CC      lm32-softmmu/hw/vfio/common.o
>   CC      i386-softmmu/target/i386/arch_dump.o
>   CC      arm-softmmu/target/arm/arm-powerctl.o
>   CC      i386-softmmu/target/i386/monitor.o
>   GEN     trace/generated-helpers.c
>   GEN     trace/generated-helpers.c
>   CC      lm32-softmmu/hw/vfio/platform.o
>   CC      aarch64-softmmu/trace/control-target.o
>   CC      arm-softmmu/trace/control-target.o
>   CC      arm-softmmu/gdbstub-xml.o
>   CC      i386-softmmu/target/i386/kvm-stub.o
>   CC      aarch64-softmmu/gdbstub-xml.o
>   CC      arm-softmmu/trace/generated-helpers.o
>   CC      lm32-softmmu/hw/vfio/spapr.o
>   CC      i386-softmmu/target/i386/sev-stub.o
>   CC      aarch64-softmmu/target/arm/translate-sve.o
>   LINK    arm-softmmu/qemu-system-arm
>   GEN     trace/generated-helpers.c
>   CC      lm32-softmmu/hw/lm32/lm32_boards.o
>   CC      i386-softmmu/trace/control-target.o
>   CC      i386-softmmu/gdbstub-xml.o
>   CC      lm32-softmmu/hw/lm32/milkymist.o
>   CC      i386-softmmu/trace/generated-helpers.o
>   CC      lm32-softmmu/target/lm32/translate.o
>   LINK    i386-softmmu/qemu-system-i386
>   CC      lm32-softmmu/target/lm32/op_helper.o
>   CC      lm32-softmmu/target/lm32/helper.o
>   CC      lm32-softmmu/target/lm32/cpu.o
>   CC      lm32-softmmu/target/lm32/gdbstub.o
>   GEN     m68k-softmmu/hmp-commands.h
>   GEN     m68k-softmmu/hmp-commands-info.h
>   GEN     m68k-softmmu/config-target.h
>   CC      m68k-softmmu/exec.o
>   CC      lm32-softmmu/target/lm32/lm32-semi.o
>   CC      m68k-softmmu/tcg/tcg.o
>   CC      aarch64-softmmu/trace/generated-helpers.o
>   LINK    aarch64-softmmu/qemu-system-aarch64
>   CC      lm32-softmmu/target/lm32/machine.o
>   GEN     trace/generated-helpers.c
>   CC      lm32-softmmu/trace/control-target.o
>   GEN     microblazeel-softmmu/hmp-commands.h
>   GEN     microblazeel-softmmu/hmp-commands-info.h
>   GEN     microblazeel-softmmu/config-target.h
>   CC      microblazeel-softmmu/exec.o
>   CC      m68k-softmmu/tcg/tcg-op.o
>   CC      lm32-softmmu/trace/generated-helpers.o
>   LINK    lm32-softmmu/qemu-system-lm32
>   GEN     microblaze-softmmu/hmp-commands.h
>   GEN     microblaze-softmmu/hmp-commands-info.h
>   GEN     microblaze-softmmu/config-target.h
>   CC      microblaze-softmmu/exec.o
>   CC      m68k-softmmu/tcg/tcg-op-vec.o
>   CC      microblazeel-softmmu/tcg/tcg.o
>   CC      microblaze-softmmu/tcg/tcg.o
>   CC      m68k-softmmu/tcg/tcg-op-gvec.o
>   CC      microblaze-softmmu/tcg/tcg-op.o
>   CC      microblazeel-softmmu/tcg/tcg-op.o
>   CC      m68k-softmmu/tcg/tcg-common.o
>   CC      m68k-softmmu/tcg/optimize.o
>   GEN     mips64el-softmmu/hmp-commands.h
>   GEN     mips64el-softmmu/hmp-commands-info.h
>   CC      m68k-softmmu/fpu/softfloat.o
>   GEN     mips64el-softmmu/config-target.h
>   CC      mips64el-softmmu/exec.o
>   CC      microblazeel-softmmu/tcg/tcg-op-vec.o
>   CC      microblazeel-softmmu/tcg/tcg-op-gvec.o
>   CC      mips64el-softmmu/tcg/tcg.o
>   CC      microblazeel-softmmu/tcg/tcg-common.o
>   CC      microblazeel-softmmu/tcg/optimize.o
>   CC      m68k-softmmu/disas.o
>   GEN     m68k-softmmu/gdbstub-xml.c
>   CC      microblazeel-softmmu/fpu/softfloat.o
>   CC      m68k-softmmu/arch_init.o
>   CC      m68k-softmmu/cpus.o
>   CC      m68k-softmmu/monitor.o
>   CC      mips64el-softmmu/tcg/tcg-op.o
>   CC      m68k-softmmu/gdbstub.o
>   CC      m68k-softmmu/balloon.o
>   CC      mips64el-softmmu/tcg/tcg-op-vec.o
>   CC      m68k-softmmu/ioport.o
>   CC      m68k-softmmu/numa.o
>   CC      microblazeel-softmmu/disas.o
>   CC      m68k-softmmu/qtest.o
>   CC      mips64el-softmmu/tcg/tcg-op-gvec.o
>   CC      microblazeel-softmmu/arch_init.o
>   CC      microblazeel-softmmu/cpus.o
>   CC      m68k-softmmu/memory.o
>   CC      microblazeel-softmmu/monitor.o
>   CC      m68k-softmmu/memory_mapping.o
>   CC      m68k-softmmu/dump.o
>   CC      mips64el-softmmu/tcg/tcg-common.o
>   CC      mips64el-softmmu/tcg/optimize.o
>   CC      microblazeel-softmmu/gdbstub.o
>   CC      m68k-softmmu/migration/ram.o
>   CC      mips64el-softmmu/fpu/softfloat.o
>   CC      microblazeel-softmmu/balloon.o
>   CC      microblazeel-softmmu/ioport.o
>   CC      m68k-softmmu/accel/accel.o
>   CC      microblazeel-softmmu/numa.o
>   CC      m68k-softmmu/accel/stubs/hax-stub.o
>   CC      m68k-softmmu/accel/stubs/hvf-stub.o
>   CC      microblazeel-softmmu/qtest.o
>   CC      m68k-softmmu/accel/stubs/whpx-stub.o
>   CC      m68k-softmmu/accel/stubs/kvm-stub.o
>   CC      microblazeel-softmmu/memory.o
>   CC      m68k-softmmu/accel/tcg/tcg-all.o
>   CC      m68k-softmmu/accel/tcg/cputlb.o
>   CC      microblazeel-softmmu/memory_mapping.o
>   CC      microblazeel-softmmu/dump.o
>   CC      microblazeel-softmmu/migration/ram.o
>   CC      mips64el-softmmu/disas.o
>   CC      m68k-softmmu/accel/tcg/tcg-runtime.o
>   CC      mips64el-softmmu/arch_init.o
>   CC      m68k-softmmu/accel/tcg/tcg-runtime-gvec.o
>   CC      mips64el-softmmu/cpus.o
>   CC      microblazeel-softmmu/accel/accel.o
>   CC      microblazeel-softmmu/accel/stubs/hax-stub.o
>   CC      microblazeel-softmmu/accel/stubs/hvf-stub.o
>   CC      mips64el-softmmu/monitor.o
>   CC      microblazeel-softmmu/accel/stubs/whpx-stub.o
>   CC      m68k-softmmu/accel/tcg/cpu-exec.o
>   CC      microblazeel-softmmu/accel/stubs/kvm-stub.o
>   CC      microblazeel-softmmu/accel/tcg/tcg-all.o
>   CC      m68k-softmmu/accel/tcg/cpu-exec-common.o
>   CC      microblazeel-softmmu/accel/tcg/cputlb.o
>   CC      m68k-softmmu/accel/tcg/translate-all.o
>   CC      m68k-softmmu/accel/tcg/translator.o
>   CC      mips64el-softmmu/gdbstub.o
>   CC      m68k-softmmu/hw/char/mcf_uart.o
>   CC      m68k-softmmu/hw/core/generic-loader.o
>   CC      m68k-softmmu/hw/core/null-machine.o
>   CC      mips64el-softmmu/balloon.o
>   CC      m68k-softmmu/hw/misc/mmio_interface.o
>   CC      mips64el-softmmu/ioport.o
>   CC      m68k-softmmu/hw/net/mcf_fec.o
>   CC      mips64el-softmmu/numa.o
>   CC      m68k-softmmu/hw/net/vhost_net.o
>   CC      microblazeel-softmmu/accel/tcg/tcg-runtime.o
>   CC      m68k-softmmu/hw/net/rocker/qmp-norocker.o
>   CC      mips64el-softmmu/qtest.o
>   CC      m68k-softmmu/hw/vfio/common.o
>   CC      microblazeel-softmmu/accel/tcg/tcg-runtime-gvec.o
>   CC      mips64el-softmmu/memory.o
>   CC      m68k-softmmu/hw/vfio/platform.o
>   CC      microblazeel-softmmu/accel/tcg/cpu-exec.o
>   CC      m68k-softmmu/hw/vfio/spapr.o
>   CC      microblazeel-softmmu/accel/tcg/cpu-exec-common.o
>   CC      mips64el-softmmu/memory_mapping.o
>   CC      m68k-softmmu/hw/m68k/an5206.o
>   CC      microblazeel-softmmu/accel/tcg/translate-all.o
>   CC      mips64el-softmmu/dump.o
>   CC      m68k-softmmu/hw/m68k/mcf5208.o
>   CC      m68k-softmmu/hw/m68k/mcf5206.o
>   CC      microblazeel-softmmu/accel/tcg/translator.o
>   CC      m68k-softmmu/hw/m68k/mcf_intc.o
>   CC      mips64el-softmmu/migration/ram.o
>   CC      microblazeel-softmmu/hw/core/generic-loader.o
>   CC      m68k-softmmu/target/m68k/m68k-semi.o
>   CC      microblazeel-softmmu/hw/core/null-machine.o
>   CC      m68k-softmmu/target/m68k/translate.o
>   CC      microblazeel-softmmu/hw/dma/xlnx_dpdma.o
>   CC      microblazeel-softmmu/hw/misc/mmio_interface.o
>   CC      mips64el-softmmu/accel/accel.o
>   CC      microblazeel-softmmu/hw/net/xilinx_ethlite.o
>   CC      mips64el-softmmu/accel/stubs/hax-stub.o
>   CC      microblazeel-softmmu/hw/net/vhost_net.o
>   CC      mips64el-softmmu/accel/stubs/hvf-stub.o
>   CC      microblazeel-softmmu/hw/net/rocker/qmp-norocker.o
>   CC      mips64el-softmmu/accel/stubs/whpx-stub.o
>   CC      microblazeel-softmmu/hw/vfio/common.o
>   CC      mips64el-softmmu/accel/stubs/kvm-stub.o
>   CC      mips64el-softmmu/accel/tcg/tcg-all.o
>   CC      mips64el-softmmu/accel/tcg/cputlb.o
>   CC      microblazeel-softmmu/hw/vfio/platform.o
>   CC      microblazeel-softmmu/hw/vfio/spapr.o
>   CC      microblazeel-softmmu/hw/microblaze/petalogix_s3adsp1800_mmu.o
>   CC      microblazeel-softmmu/hw/microblaze/petalogix_ml605_mmu.o
>   CC      m68k-softmmu/target/m68k/op_helper.o
>   CC      microblazeel-softmmu/hw/microblaze/xlnx-zynqmp-pmu.o
>   CC      microblazeel-softmmu/hw/microblaze/boot.o
>   CC      microblazeel-softmmu/target/microblaze/translate.o
>   CC      m68k-softmmu/target/m68k/helper.o
>   CC      mips64el-softmmu/accel/tcg/tcg-runtime.o
>   CC      mips64el-softmmu/accel/tcg/tcg-runtime-gvec.o
>   CC      m68k-softmmu/target/m68k/cpu.o
>   CC      m68k-softmmu/target/m68k/fpu_helper.o
>   CC      microblazeel-softmmu/target/microblaze/op_helper.o
>   CC      m68k-softmmu/target/m68k/softfloat.o
>   CC      mips64el-softmmu/accel/tcg/cpu-exec.o
>   CC      microblazeel-softmmu/target/microblaze/helper.o
>   CC      microblazeel-softmmu/target/microblaze/cpu.o
>   CC      mips64el-softmmu/accel/tcg/cpu-exec-common.o
>   CC      microblazeel-softmmu/target/microblaze/gdbstub.o
>   CC      mips64el-softmmu/accel/tcg/translate-all.o
>   CC      microblazeel-softmmu/target/microblaze/mmu.o
>   CC      m68k-softmmu/target/m68k/gdbstub.o
>   GEN     trace/generated-helpers.c
>   CC      microblazeel-softmmu/trace/control-target.o
>   CC      m68k-softmmu/target/m68k/monitor.o
>   CC      mips64el-softmmu/accel/tcg/translator.o
>   CC      microblazeel-softmmu/trace/generated-helpers.o
>   GEN     trace/generated-helpers.c
>   CC      m68k-softmmu/trace/control-target.o
>   LINK    microblazeel-softmmu/qemu-system-microblazeel
>   CC      m68k-softmmu/gdbstub-xml.o
>   CC      m68k-softmmu/trace/generated-helpers.o
>   CC      mips64el-softmmu/hw/9pfs/virtio-9p-device.o
>   LINK    m68k-softmmu/qemu-system-m68k
>   CC      mips64el-softmmu/hw/block/virtio-blk.o
>   CC      mips64el-softmmu/hw/block/vhost-user-blk.o
>   CC      microblaze-softmmu/tcg/tcg-op-vec.o
>   CC      mips64el-softmmu/hw/block/dataplane/virtio-blk.o
>   GEN     mips64-softmmu/hmp-commands.h
>   GEN     mips64-softmmu/hmp-commands-info.h
>   GEN     mips64-softmmu/config-target.h
>   CC      mips64-softmmu/exec.o
>   CC      mips64el-softmmu/hw/char/virtio-serial-bus.o
>   GEN     mipsel-softmmu/hmp-commands.h
>   GEN     mipsel-softmmu/hmp-commands-info.h
>   GEN     mipsel-softmmu/config-target.h
>   CC      mipsel-softmmu/exec.o
>   CC      mips64el-softmmu/hw/core/generic-loader.o
>   CC      mips64el-softmmu/hw/core/null-machine.o
>   CC      mips64el-softmmu/hw/display/vga.o
>   CC      mips64-softmmu/tcg/tcg.o
>   CC      mips64el-softmmu/hw/display/virtio-gpu.o
>   CC      mipsel-softmmu/tcg/tcg.o
>   CC      mips64el-softmmu/hw/display/virtio-gpu-3d.o
>   CC      mips64el-softmmu/hw/display/virtio-gpu-pci.o
>   CC      mips64el-softmmu/hw/intc/mips_gic.o
>   CC      mips64el-softmmu/hw/misc/ivshmem.o
>   CC      mips64-softmmu/tcg/tcg-op.o
>   CC      mipsel-softmmu/tcg/tcg-op.o
>   CC      mips64el-softmmu/hw/misc/mips_cmgcr.o
>   CC      mips64el-softmmu/hw/misc/mips_cpc.o
>   CC      mips64el-softmmu/hw/misc/mips_itu.o
>   CC      mips64el-softmmu/hw/misc/mmio_interface.o
>   CC      mips64el-softmmu/hw/net/virtio-net.o
>   CC      mips64el-softmmu/hw/net/vhost_net.o
>   CC      mips64el-softmmu/hw/scsi/virtio-scsi.o
>   CC      mips64-softmmu/tcg/tcg-op-vec.o
>   CC      mipsel-softmmu/tcg/tcg-op-vec.o
>   CC      mips64el-softmmu/hw/scsi/virtio-scsi-dataplane.o
>   CC      mips64el-softmmu/hw/scsi/vhost-scsi-common.o
>   CC      mipsel-softmmu/tcg/tcg-op-gvec.o
>   CC      mips64-softmmu/tcg/tcg-op-gvec.o
>   CC      mips64el-softmmu/hw/scsi/vhost-scsi.o
>   CC      mips64el-softmmu/hw/scsi/vhost-user-scsi.o
>   CC      mips64el-softmmu/hw/timer/mips_gictimer.o
>   CC      mips64el-softmmu/hw/timer/mc146818rtc.o
>   CC      mips64el-softmmu/hw/vfio/common.o
>   CC      mipsel-softmmu/tcg/tcg-common.o
>   CC      mips64-softmmu/tcg/tcg-common.o
>   CC      mipsel-softmmu/tcg/optimize.o
>   CC      mips64el-softmmu/hw/vfio/pci.o
>   CC      mips64-softmmu/tcg/optimize.o
>   CC      mipsel-softmmu/fpu/softfloat.o
>   CC      mips64el-softmmu/hw/vfio/pci-quirks.o
>   CC      mips64-softmmu/fpu/softfloat.o
>   CC      mips64el-softmmu/hw/vfio/display.o
>   CC      mips64el-softmmu/hw/vfio/platform.o
>   CC      mips64el-softmmu/hw/vfio/spapr.o
>   CC      mips64el-softmmu/hw/virtio/virtio.o
>   CC      mips64el-softmmu/hw/virtio/virtio-balloon.o
>   CC      mips64el-softmmu/hw/virtio/virtio-crypto.o
>   CC      mipsel-softmmu/disas.o
>   CC      mips64-softmmu/disas.o
>   CC      mips64el-softmmu/hw/virtio/virtio-crypto-pci.o
>   CC      mipsel-softmmu/arch_init.o
>   CC      mips64-softmmu/arch_init.o
>   CC      mipsel-softmmu/cpus.o
>   CC      mips64el-softmmu/hw/virtio/vhost.o
>   CC      mips64-softmmu/cpus.o
>   CC      mipsel-softmmu/monitor.o
>   CC      mips64el-softmmu/hw/virtio/vhost-backend.o
>   CC      mips64-softmmu/monitor.o
>   CC      mips64el-softmmu/hw/virtio/vhost-user.o
>   CC      mips64el-softmmu/hw/virtio/vhost-vsock.o
>   CC      mips64el-softmmu/hw/mips/mips_r4k.o
>   CC      mipsel-softmmu/gdbstub.o
>   CC      mips64el-softmmu/hw/mips/mips_malta.o
>   CC      mips64-softmmu/gdbstub.o
>   CC      mips64el-softmmu/hw/mips/mips_mipssim.o
>   CC      mipsel-softmmu/balloon.o
>   CC      mips64el-softmmu/hw/mips/addr.o
>   CC      mipsel-softmmu/ioport.o
>   CC      mips64-softmmu/balloon.o
>   CC      mips64el-softmmu/hw/mips/mips_int.o
>   CC      mips64el-softmmu/hw/mips/mips_jazz.o
>   CC      mips64-softmmu/ioport.o
>   CC      mipsel-softmmu/numa.o
>   CC      mips64el-softmmu/hw/mips/mips_fulong2e.o
>   CC      mips64-softmmu/numa.o
>   CC      mipsel-softmmu/qtest.o
>   CC      mips64el-softmmu/hw/mips/gt64xxx_pci.o
>   CC      mips64-softmmu/qtest.o
>   CC      mipsel-softmmu/memory.o
>   CC      mips64el-softmmu/hw/mips/cps.o
>   CC      mips64-softmmu/memory.o
>   CC      mips64el-softmmu/hw/mips/boston.o
>   CC      mips64el-softmmu/target/mips/translate.o
>   CC      mipsel-softmmu/memory_mapping.o
>   CC      mipsel-softmmu/dump.o
>   CC      mips64-softmmu/memory_mapping.o
>   CC      mips64-softmmu/dump.o
>   CC      mipsel-softmmu/migration/ram.o
>   CC      mips64-softmmu/migration/ram.o
>   CC      mipsel-softmmu/accel/accel.o
>   CC      mipsel-softmmu/accel/stubs/hax-stub.o
>   CC      mips64-softmmu/accel/accel.o
>   CC      mipsel-softmmu/accel/stubs/hvf-stub.o
>   CC      mips64-softmmu/accel/stubs/hax-stub.o
>   CC      mipsel-softmmu/accel/stubs/whpx-stub.o
>   CC      mips64-softmmu/accel/stubs/hvf-stub.o
>   CC      mipsel-softmmu/accel/stubs/kvm-stub.o
>   CC      mips64-softmmu/accel/stubs/whpx-stub.o
>   CC      mipsel-softmmu/accel/tcg/tcg-all.o
>   CC      mips64-softmmu/accel/stubs/kvm-stub.o
>   CC      mipsel-softmmu/accel/tcg/cputlb.o
>   CC      mips64-softmmu/accel/tcg/tcg-all.o
>   CC      mips64-softmmu/accel/tcg/cputlb.o
>   CC      mipsel-softmmu/accel/tcg/tcg-runtime.o
>   CC      mips64-softmmu/accel/tcg/tcg-runtime.o
>   CC      mipsel-softmmu/accel/tcg/tcg-runtime-gvec.o
>   CC      mips64-softmmu/accel/tcg/tcg-runtime-gvec.o
>   CC      mipsel-softmmu/accel/tcg/cpu-exec.o
>   CC      mips64-softmmu/accel/tcg/cpu-exec.o
>   CC      mipsel-softmmu/accel/tcg/cpu-exec-common.o
>   CC      mips64-softmmu/accel/tcg/cpu-exec-common.o
>   CC      mipsel-softmmu/accel/tcg/translate-all.o
>   CC      mips64-softmmu/accel/tcg/translate-all.o
>   CC      mipsel-softmmu/accel/tcg/translator.o
>   CC      mips64-softmmu/accel/tcg/translator.o
>   CC      mipsel-softmmu/hw/9pfs/virtio-9p-device.o
>   CC      mips64-softmmu/hw/9pfs/virtio-9p-device.o
>   CC      mipsel-softmmu/hw/block/virtio-blk.o
>   CC      mips64-softmmu/hw/block/virtio-blk.o
>   CC      mipsel-softmmu/hw/block/vhost-user-blk.o
>   CC      mips64-softmmu/hw/block/vhost-user-blk.o
>   CC      mipsel-softmmu/hw/block/dataplane/virtio-blk.o
>   CC      mips64el-softmmu/target/mips/dsp_helper.o
>   CC      mips64-softmmu/hw/block/dataplane/virtio-blk.o
>   CC      mipsel-softmmu/hw/char/virtio-serial-bus.o
>   CC      mips64-softmmu/hw/char/virtio-serial-bus.o
>   CC      mipsel-softmmu/hw/core/generic-loader.o
>   CC      mips64-softmmu/hw/core/generic-loader.o
>   CC      mipsel-softmmu/hw/core/null-machine.o
>   CC      mipsel-softmmu/hw/display/vga.o
>   CC      mips64-softmmu/hw/core/null-machine.o
>   CC      mips64-softmmu/hw/display/vga.o
>   CC      mips64el-softmmu/target/mips/op_helper.o
>   CC      mipsel-softmmu/hw/display/virtio-gpu.o
>   CC      mips64-softmmu/hw/display/virtio-gpu.o
>   CC      mipsel-softmmu/hw/display/virtio-gpu-3d.o
>   CC      mips64-softmmu/hw/display/virtio-gpu-3d.o
>   CC      mipsel-softmmu/hw/display/virtio-gpu-pci.o
>   CC      mips64-softmmu/hw/display/virtio-gpu-pci.o
>   CC      mipsel-softmmu/hw/intc/mips_gic.o
>   CC      mips64el-softmmu/target/mips/lmi_helper.o
>   CC      mips64-softmmu/hw/intc/mips_gic.o
>   CC      mipsel-softmmu/hw/misc/ivshmem.o
>   CC      mips64el-softmmu/target/mips/helper.o
>   CC      mips64-softmmu/hw/misc/ivshmem.o
>   CC      mipsel-softmmu/hw/misc/mips_cmgcr.o
>   CC      mips64el-softmmu/target/mips/cpu.o
>   CC      mips64-softmmu/hw/misc/mips_cmgcr.o
>   CC      mipsel-softmmu/hw/misc/mips_cpc.o
>   CC      mips64el-softmmu/target/mips/gdbstub.o
>   CC      mipsel-softmmu/hw/misc/mips_itu.o
>   CC      mips64-softmmu/hw/misc/mips_cpc.o
>   CC      mips64el-softmmu/target/mips/msa_helper.o
>   CC      mips64-softmmu/hw/misc/mips_itu.o
>   CC      mipsel-softmmu/hw/misc/mmio_interface.o
>   CC      mipsel-softmmu/hw/net/virtio-net.o
>   CC      mips64-softmmu/hw/misc/mmio_interface.o
>   CC      mips64-softmmu/hw/net/virtio-net.o
>   CC      mipsel-softmmu/hw/net/vhost_net.o
>   CC      mipsel-softmmu/hw/scsi/virtio-scsi.o
>   CC      mips64-softmmu/hw/net/vhost_net.o
>   CC      mips64-softmmu/hw/scsi/virtio-scsi.o
>   CC      mipsel-softmmu/hw/scsi/virtio-scsi-dataplane.o
>   CC      mips64-softmmu/hw/scsi/virtio-scsi-dataplane.o
>   CC      mipsel-softmmu/hw/scsi/vhost-scsi-common.o
>   CC      mipsel-softmmu/hw/scsi/vhost-scsi.o
>   CC      mips64-softmmu/hw/scsi/vhost-scsi-common.o
>   CC      mipsel-softmmu/hw/scsi/vhost-user-scsi.o
>   CC      mips64-softmmu/hw/scsi/vhost-scsi.o
>   CC      mipsel-softmmu/hw/timer/mips_gictimer.o
>   CC      mips64-softmmu/hw/scsi/vhost-user-scsi.o
>   CC      mipsel-softmmu/hw/timer/mc146818rtc.o
>   CC      mips64-softmmu/hw/timer/mips_gictimer.o
>   CC      mips64-softmmu/hw/timer/mc146818rtc.o
>   CC      mipsel-softmmu/hw/vfio/common.o
>   CC      mips64-softmmu/hw/vfio/common.o
>   CC      mips64el-softmmu/target/mips/mips-semi.o
>   CC      mips64el-softmmu/target/mips/machine.o
>   CC      mipsel-softmmu/hw/vfio/pci.o
>   CC      mips64el-softmmu/target/mips/cp0_timer.o
>   CC      mips64-softmmu/hw/vfio/pci.o
>   GEN     trace/generated-helpers.c
>   CC      mips64el-softmmu/trace/control-target.o
>   CC      mips64el-softmmu/trace/generated-helpers.o
>   LINK    mips64el-softmmu/qemu-system-mips64el
>   CC      mipsel-softmmu/hw/vfio/pci-quirks.o
>   CC      mips64-softmmu/hw/vfio/pci-quirks.o
>   CC      mipsel-softmmu/hw/vfio/display.o
>   CC      mips64-softmmu/hw/vfio/display.o
>   CC      mipsel-softmmu/hw/vfio/platform.o
>   CC      mips64-softmmu/hw/vfio/platform.o
>   CC      mipsel-softmmu/hw/vfio/spapr.o
>   CC      microblaze-softmmu/tcg/tcg-op-gvec.o
>   CC      mips64-softmmu/hw/vfio/spapr.o
>   CC      mips64-softmmu/hw/virtio/virtio.o
>   CC      mipsel-softmmu/hw/virtio/virtio.o
>   CC      microblaze-softmmu/tcg/tcg-common.o
>   CC      microblaze-softmmu/tcg/optimize.o
>   CC      mips64-softmmu/hw/virtio/virtio-balloon.o
>   CC      mipsel-softmmu/hw/virtio/virtio-balloon.o
>   CC      microblaze-softmmu/fpu/softfloat.o
>   CC      mips64-softmmu/hw/virtio/virtio-crypto.o
>   CC      mipsel-softmmu/hw/virtio/virtio-crypto.o
>   GEN     mips-softmmu/hmp-commands.h
>   GEN     mips-softmmu/hmp-commands-info.h
>   GEN     mips-softmmu/config-target.h
>   CC      mips-softmmu/exec.o
>   CC      mips64-softmmu/hw/virtio/virtio-crypto-pci.o
>   CC      mipsel-softmmu/hw/virtio/virtio-crypto-pci.o
>   CC      mips64-softmmu/hw/virtio/vhost.o
>   CC      mipsel-softmmu/hw/virtio/vhost.o
>   CC      mips64-softmmu/hw/virtio/vhost-backend.o
>   CC      mipsel-softmmu/hw/virtio/vhost-backend.o
>   CC      mips-softmmu/tcg/tcg.o
>   CC      mips64-softmmu/hw/virtio/vhost-user.o
>   CC      mipsel-softmmu/hw/virtio/vhost-user.o
>   CC      mips64-softmmu/hw/virtio/vhost-vsock.o
>   CC      microblaze-softmmu/disas.o
>   CC      mipsel-softmmu/hw/virtio/vhost-vsock.o
>   CC      mips64-softmmu/hw/mips/mips_r4k.o
>   CC      microblaze-softmmu/arch_init.o
>   CC      mipsel-softmmu/hw/mips/mips_r4k.o
>   CC      mips64-softmmu/hw/mips/mips_malta.o
>   CC      microblaze-softmmu/cpus.o
>   CC      mipsel-softmmu/hw/mips/mips_malta.o
>   CC      mips-softmmu/tcg/tcg-op.o
>   CC      mips64-softmmu/hw/mips/mips_mipssim.o
>   CC      microblaze-softmmu/monitor.o
>   CC      mipsel-softmmu/hw/mips/mips_mipssim.o
>   CC      mips64-softmmu/hw/mips/addr.o
>   CC      mipsel-softmmu/hw/mips/addr.o
>   CC      mips64-softmmu/hw/mips/mips_int.o
>   CC      mips64-softmmu/hw/mips/mips_jazz.o
>   CC      mipsel-softmmu/hw/mips/mips_int.o
>   CC      mipsel-softmmu/hw/mips/gt64xxx_pci.o
>   CC      mips64-softmmu/hw/mips/gt64xxx_pci.o
>   CC      mipsel-softmmu/hw/mips/cps.o
>   CC      mips64-softmmu/hw/mips/cps.o
>   CC      microblaze-softmmu/gdbstub.o
>   CC      mipsel-softmmu/target/mips/translate.o
>   CC      mips64-softmmu/target/mips/translate.o
>   CC      mips-softmmu/tcg/tcg-op-vec.o
>   CC      microblaze-softmmu/balloon.o
>   CC      mips-softmmu/tcg/tcg-op-gvec.o
>   CC      microblaze-softmmu/ioport.o
>   CC      microblaze-softmmu/numa.o
>   CC      microblaze-softmmu/qtest.o
>   CC      mips-softmmu/tcg/tcg-common.o
>   CC      mips-softmmu/tcg/optimize.o
>   CC      microblaze-softmmu/memory.o
>   CC      mips-softmmu/fpu/softfloat.o
>   CC      microblaze-softmmu/memory_mapping.o
>   CC      microblaze-softmmu/dump.o
>   CC      microblaze-softmmu/migration/ram.o
>   CC      mipsel-softmmu/target/mips/dsp_helper.o
>   CC      mips-softmmu/disas.o
>   CC      mips-softmmu/arch_init.o
>   CC      microblaze-softmmu/accel/accel.o
>   CC      mipsel-softmmu/target/mips/op_helper.o
>   CC      mips-softmmu/cpus.o
>   CC      microblaze-softmmu/accel/stubs/hax-stub.o
>   CC      microblaze-softmmu/accel/stubs/hvf-stub.o
>   CC      mips-softmmu/monitor.o
>   CC      mips64-softmmu/target/mips/dsp_helper.o
>   CC      microblaze-softmmu/accel/stubs/whpx-stub.o
>   CC      microblaze-softmmu/accel/stubs/kvm-stub.o
>   CC      microblaze-softmmu/accel/tcg/tcg-all.o
>   CC      mips-softmmu/gdbstub.o
>   CC      microblaze-softmmu/accel/tcg/cputlb.o
>   CC      mips64-softmmu/target/mips/op_helper.o
>   CC      mipsel-softmmu/target/mips/lmi_helper.o
>   CC      mips-softmmu/balloon.o
>   CC      mipsel-softmmu/target/mips/helper.o
>   CC      mips-softmmu/ioport.o
>   CC      mips-softmmu/numa.o
>   CC      mipsel-softmmu/target/mips/cpu.o
>   CC      mips-softmmu/qtest.o
>   CC      mipsel-softmmu/target/mips/gdbstub.o
>   CC      mips64-softmmu/target/mips/lmi_helper.o
>   CC      microblaze-softmmu/accel/tcg/tcg-runtime.o
>   CC      mips-softmmu/memory.o
>   CC      mipsel-softmmu/target/mips/msa_helper.o
>   CC      microblaze-softmmu/accel/tcg/tcg-runtime-gvec.o
>   CC      mips64-softmmu/target/mips/helper.o
>   CC      mips-softmmu/memory_mapping.o
>   CC      mips64-softmmu/target/mips/cpu.o
>   CC      mips-softmmu/dump.o
>   CC      mips64-softmmu/target/mips/gdbstub.o
>   CC      microblaze-softmmu/accel/tcg/cpu-exec.o
>   CC      mips64-softmmu/target/mips/msa_helper.o
>   CC      mips-softmmu/migration/ram.o
>   CC      microblaze-softmmu/accel/tcg/cpu-exec-common.o
>   CC      microblaze-softmmu/accel/tcg/translate-all.o
>   CC      mips-softmmu/accel/accel.o
>   CC      mips-softmmu/accel/stubs/hax-stub.o
>   CC      microblaze-softmmu/accel/tcg/translator.o
>   CC      mipsel-softmmu/target/mips/mips-semi.o
>   CC      mips-softmmu/accel/stubs/hvf-stub.o
>   CC      mips-softmmu/accel/stubs/whpx-stub.o
>   CC      mipsel-softmmu/target/mips/machine.o
>   CC      microblaze-softmmu/hw/core/generic-loader.o
>   CC      mips-softmmu/accel/stubs/kvm-stub.o
>   CC      mipsel-softmmu/target/mips/cp0_timer.o
>   GEN     trace/generated-helpers.c
>   CC      mipsel-softmmu/trace/control-target.o
>   CC      mips-softmmu/accel/tcg/tcg-all.o
>   CC      microblaze-softmmu/hw/core/null-machine.o
>   CC      mips-softmmu/accel/tcg/cputlb.o
>   CC      microblaze-softmmu/hw/dma/xlnx_dpdma.o
>   CC      mipsel-softmmu/trace/generated-helpers.o
>   LINK    mipsel-softmmu/qemu-system-mipsel
>   CC      mips64-softmmu/target/mips/mips-semi.o
>   CC      microblaze-softmmu/hw/misc/mmio_interface.o
>   CC      mips64-softmmu/target/mips/machine.o
>   CC      microblaze-softmmu/hw/net/xilinx_ethlite.o
>   CC      mips64-softmmu/target/mips/cp0_timer.o
>   GEN     trace/generated-helpers.c
>   CC      microblaze-softmmu/hw/net/vhost_net.o
>   CC      mips64-softmmu/trace/control-target.o
>   CC      microblaze-softmmu/hw/net/rocker/qmp-norocker.o
>   CC      mips-softmmu/accel/tcg/tcg-runtime.o
>   CC      microblaze-softmmu/hw/vfio/common.o
>   CC      mips64-softmmu/trace/generated-helpers.o
>   LINK    mips64-softmmu/qemu-system-mips64
>   CC      mips-softmmu/accel/tcg/tcg-runtime-gvec.o
>   GEN     moxie-softmmu/hmp-commands.h
>   GEN     moxie-softmmu/hmp-commands-info.h
>   GEN     moxie-softmmu/config-target.h
>   CC      moxie-softmmu/exec.o
>   CC      mips-softmmu/accel/tcg/cpu-exec.o
>   CC      mips-softmmu/accel/tcg/cpu-exec-common.o
>   CC      mips-softmmu/accel/tcg/translate-all.o
>   CC      microblaze-softmmu/hw/vfio/platform.o
>   CC      mips-softmmu/accel/tcg/translator.o
>   CC      mips-softmmu/hw/9pfs/virtio-9p-device.o
>   CC      moxie-softmmu/tcg/tcg.o
>   CC      microblaze-softmmu/hw/vfio/spapr.o
>   CC      mips-softmmu/hw/block/virtio-blk.o
>   GEN     nios2-softmmu/hmp-commands.h
>   GEN     nios2-softmmu/hmp-commands-info.h
>   GEN     nios2-softmmu/config-target.h
>   CC      microblaze-softmmu/hw/microblaze/petalogix_s3adsp1800_mmu.o
>   CC      nios2-softmmu/exec.o
>   CC      mips-softmmu/hw/block/vhost-user-blk.o
>   CC      microblaze-softmmu/hw/microblaze/petalogix_ml605_mmu.o
>   CC      microblaze-softmmu/hw/microblaze/xlnx-zynqmp-pmu.o
>   CC      mips-softmmu/hw/block/dataplane/virtio-blk.o
>   CC      microblaze-softmmu/hw/microblaze/boot.o
>   CC      mips-softmmu/hw/char/virtio-serial-bus.o
>   CC      microblaze-softmmu/target/microblaze/translate.o
>   CC      mips-softmmu/hw/core/generic-loader.o
>   CC      mips-softmmu/hw/core/null-machine.o
>   CC      nios2-softmmu/tcg/tcg.o
>   CC      mips-softmmu/hw/display/vga.o
>   CC      microblaze-softmmu/target/microblaze/op_helper.o
>   CC      microblaze-softmmu/target/microblaze/helper.o
>   CC      microblaze-softmmu/target/microblaze/cpu.o
>   CC      mips-softmmu/hw/display/virtio-gpu.o
>   CC      microblaze-softmmu/target/microblaze/gdbstub.o
>   CC      microblaze-softmmu/target/microblaze/mmu.o
>   CC      nios2-softmmu/tcg/tcg-op.o
>   GEN     trace/generated-helpers.c
>   CC      microblaze-softmmu/trace/control-target.o
>   CC      mips-softmmu/hw/display/virtio-gpu-3d.o
>   CC      microblaze-softmmu/trace/generated-helpers.o
>   LINK    microblaze-softmmu/qemu-system-microblaze
>   CC      mips-softmmu/hw/display/virtio-gpu-pci.o
>   CC      mips-softmmu/hw/intc/mips_gic.o
>   CC      mips-softmmu/hw/misc/ivshmem.o
>   CC      nios2-softmmu/tcg/tcg-op-vec.o
>   GEN     or1k-softmmu/hmp-commands.h
>   GEN     or1k-softmmu/hmp-commands-info.h
>   GEN     or1k-softmmu/config-target.h
>   CC      or1k-softmmu/exec.o
>   CC      nios2-softmmu/tcg/tcg-op-gvec.o
>   CC      nios2-softmmu/tcg/tcg-common.o
>   CC      nios2-softmmu/tcg/optimize.o
>   CC      or1k-softmmu/tcg/tcg.o
>   CC      nios2-softmmu/fpu/softfloat.o
>   CC      or1k-softmmu/tcg/tcg-op.o
>   CC      or1k-softmmu/tcg/tcg-op-vec.o
>   CC      or1k-softmmu/tcg/tcg-op-gvec.o
>   CC      nios2-softmmu/disas.o
>   CC      nios2-softmmu/arch_init.o
>   CC      nios2-softmmu/cpus.o
>   CC      nios2-softmmu/monitor.o
>   CC      or1k-softmmu/tcg/tcg-common.o
>   CC      or1k-softmmu/tcg/optimize.o
>   CC      or1k-softmmu/fpu/softfloat.o
>   CC      nios2-softmmu/gdbstub.o
>   CC      nios2-softmmu/balloon.o
>   CC      nios2-softmmu/ioport.o
>   CC      nios2-softmmu/numa.o
>   CC      nios2-softmmu/qtest.o
>   CC      nios2-softmmu/memory.o
>   CC      nios2-softmmu/memory_mapping.o
>   CC      or1k-softmmu/disas.o
>   CC      nios2-softmmu/dump.o
>   CC      or1k-softmmu/arch_init.o
>   CC      or1k-softmmu/cpus.o
>   CC      nios2-softmmu/migration/ram.o
>   CC      or1k-softmmu/monitor.o
>   CC      nios2-softmmu/accel/accel.o
>   CC      nios2-softmmu/accel/stubs/hax-stub.o
>   CC      nios2-softmmu/accel/stubs/hvf-stub.o
>   CC      nios2-softmmu/accel/stubs/whpx-stub.o
>   CC      nios2-softmmu/accel/stubs/kvm-stub.o
>   CC      or1k-softmmu/gdbstub.o
>   CC      nios2-softmmu/accel/tcg/tcg-all.o
>   CC      nios2-softmmu/accel/tcg/cputlb.o
>   CC      or1k-softmmu/balloon.o
>   CC      or1k-softmmu/ioport.o
>   CC      or1k-softmmu/numa.o
>   CC      or1k-softmmu/qtest.o
>   CC      or1k-softmmu/memory.o
>   CC      nios2-softmmu/accel/tcg/tcg-runtime.o
>   CC      nios2-softmmu/accel/tcg/tcg-runtime-gvec.o
>   CC      or1k-softmmu/memory_mapping.o
>   CC      or1k-softmmu/dump.o
>   CC      nios2-softmmu/accel/tcg/cpu-exec.o
>   CC      or1k-softmmu/migration/ram.o
>   CC      nios2-softmmu/accel/tcg/cpu-exec-common.o
>   CC      nios2-softmmu/accel/tcg/translate-all.o
>   CC      nios2-softmmu/accel/tcg/translator.o
>   CC      or1k-softmmu/accel/accel.o
>   CC      or1k-softmmu/accel/stubs/hax-stub.o
>   CC      nios2-softmmu/hw/core/generic-loader.o
>   CC      or1k-softmmu/accel/stubs/hvf-stub.o
>   CC      nios2-softmmu/hw/core/null-machine.o
>   CC      or1k-softmmu/accel/stubs/whpx-stub.o
>   CC      nios2-softmmu/hw/intc/nios2_iic.o
>   CC      or1k-softmmu/accel/stubs/kvm-stub.o
>   CC      nios2-softmmu/hw/misc/mmio_interface.o
>   CC      or1k-softmmu/accel/tcg/tcg-all.o
>   CC      nios2-softmmu/hw/net/vhost_net.o
>   CC      or1k-softmmu/accel/tcg/cputlb.o
>   CC      nios2-softmmu/hw/net/rocker/qmp-norocker.o
>   CC      nios2-softmmu/hw/timer/altera_timer.o
>   CC      nios2-softmmu/hw/vfio/common.o
>   CC      nios2-softmmu/hw/vfio/platform.o
>   CC      nios2-softmmu/hw/vfio/spapr.o
>   CC      nios2-softmmu/hw/nios2/boot.o
>   CC      or1k-softmmu/accel/tcg/tcg-runtime.o
>   CC      nios2-softmmu/hw/nios2/cpu_pic.o
>   CC      nios2-softmmu/hw/nios2/10m50_devboard.o
>   CC      or1k-softmmu/accel/tcg/tcg-runtime-gvec.o
>   CC      nios2-softmmu/target/nios2/translate.o
>   CC      or1k-softmmu/accel/tcg/cpu-exec.o
>   CC      nios2-softmmu/target/nios2/op_helper.o
>   CC      nios2-softmmu/target/nios2/helper.o
>   CC      or1k-softmmu/accel/tcg/cpu-exec-common.o
>   CC      nios2-softmmu/target/nios2/cpu.o
>   CC      or1k-softmmu/accel/tcg/translate-all.o
>   CC      nios2-softmmu/target/nios2/mmu.o
>   CC      nios2-softmmu/target/nios2/monitor.o
>   CC      or1k-softmmu/accel/tcg/translator.o
>   GEN     trace/generated-helpers.c
>   CC      nios2-softmmu/trace/control-target.o
>   CC      or1k-softmmu/hw/core/generic-loader.o
>   CC      nios2-softmmu/trace/generated-helpers.o
>   CC      or1k-softmmu/hw/core/null-machine.o
>   LINK    nios2-softmmu/qemu-system-nios2
>   CC      or1k-softmmu/hw/intc/ompic.o
>   CC      or1k-softmmu/hw/misc/mmio_interface.o
>   CC      or1k-softmmu/hw/net/vhost_net.o
>   CC      or1k-softmmu/hw/net/rocker/qmp-norocker.o
>   CC      or1k-softmmu/hw/vfio/common.o
>   CC      or1k-softmmu/hw/vfio/platform.o
>   CC      moxie-softmmu/tcg/tcg-op.o
>   CC      or1k-softmmu/hw/vfio/spapr.o
>   CC      moxie-softmmu/tcg/tcg-op-vec.o
>   CC      or1k-softmmu/hw/openrisc/pic_cpu.o
>   CC      or1k-softmmu/hw/openrisc/cputimer.o
>   CC      or1k-softmmu/hw/openrisc/openrisc_sim.o
>   GEN     ppc64-softmmu/hmp-commands.h
>   GEN     ppc64-softmmu/hmp-commands-info.h
>   GEN     ppc64-softmmu/config-target.h
>   CC      ppc64-softmmu/exec.o
>   CC      or1k-softmmu/target/openrisc/machine.o
>   CC      or1k-softmmu/target/openrisc/cpu.o
>   CC      or1k-softmmu/target/openrisc/exception.o
>   CC      or1k-softmmu/target/openrisc/interrupt.o
>   CC      or1k-softmmu/target/openrisc/mmu.o
>   GEN     or1k-softmmu/target/openrisc/decode.inc.c
>   CC      or1k-softmmu/target/openrisc/exception_helper.o
>   CC      or1k-softmmu/target/openrisc/fpu_helper.o
>   CC      or1k-softmmu/target/openrisc/interrupt_helper.o
>   CC      or1k-softmmu/target/openrisc/mmu_helper.o
>   CC      ppc64-softmmu/tcg/tcg.o
>   CC      or1k-softmmu/target/openrisc/sys_helper.o
>   CC      or1k-softmmu/target/openrisc/gdbstub.o
>   GEN     trace/generated-helpers.c
>   CC      or1k-softmmu/trace/control-target.o
>   CC      or1k-softmmu/target/openrisc/translate.o
>   CC      or1k-softmmu/trace/generated-helpers.o
>   LINK    or1k-softmmu/qemu-system-or1k
>   CC      ppc64-softmmu/tcg/tcg-op.o
>   CC      moxie-softmmu/tcg/tcg-op-gvec.o
>   CC      mips-softmmu/hw/misc/mips_cmgcr.o
>   CC      ppc64-softmmu/tcg/tcg-op-vec.o
>   CC      mips-softmmu/hw/misc/mips_cpc.o
>   CC      mips-softmmu/hw/misc/mips_itu.o
>   CC      moxie-softmmu/tcg/tcg-common.o
>   CC      ppc64-softmmu/tcg/tcg-op-gvec.o
>   CC      moxie-softmmu/tcg/optimize.o
>   CC      ppc64-softmmu/tcg/tcg-common.o
>   CC      mips-softmmu/hw/misc/mmio_interface.o
>   CC      ppc64-softmmu/tcg/optimize.o
>   CC      mips-softmmu/hw/net/virtio-net.o
>   CC      ppc64-softmmu/fpu/softfloat.o
>   CC      ppc64-softmmu/disas.o
>   GEN     ppcemb-softmmu/hmp-commands.h
>   GEN     ppcemb-softmmu/hmp-commands-info.h
>   GEN     ppcemb-softmmu/config-target.h
>   CC      ppcemb-softmmu/exec.o
>   CC      ppcemb-softmmu/tcg/tcg.o
>   CC      ppcemb-softmmu/tcg/tcg-op.o
>   CC      ppcemb-softmmu/tcg/tcg-op-vec.o
>   CC      ppcemb-softmmu/tcg/tcg-op-gvec.o
>   CC      ppcemb-softmmu/tcg/tcg-common.o
>   CC      ppcemb-softmmu/tcg/optimize.o
>   CC      ppcemb-softmmu/fpu/softfloat.o
>   CC      ppcemb-softmmu/disas.o
>   GEN     ppcemb-softmmu/gdbstub-xml.c
>   CC      ppcemb-softmmu/arch_init.o
>   CC      ppcemb-softmmu/cpus.o
>   CC      ppcemb-softmmu/monitor.o
>   CC      ppcemb-softmmu/gdbstub.o
>   CC      ppcemb-softmmu/balloon.o
>   CC      ppcemb-softmmu/ioport.o
>   CC      ppcemb-softmmu/numa.o
>   CC      ppcemb-softmmu/qtest.o
>   CC      ppcemb-softmmu/memory.o
>   CC      ppcemb-softmmu/memory_mapping.o
>   CC      ppcemb-softmmu/dump.o
>   CC      ppcemb-softmmu/migration/ram.o
>   CC      ppcemb-softmmu/accel/accel.o
>   CC      ppcemb-softmmu/accel/stubs/hax-stub.o
>   CC      ppcemb-softmmu/accel/stubs/hvf-stub.o
>   CC      ppcemb-softmmu/accel/stubs/whpx-stub.o
>   CC      ppcemb-softmmu/accel/stubs/kvm-stub.o
>   CC      ppcemb-softmmu/accel/tcg/tcg-all.o
>   CC      ppcemb-softmmu/accel/tcg/cputlb.o
>   CC      ppcemb-softmmu/accel/tcg/tcg-runtime.o
>   CC      ppcemb-softmmu/accel/tcg/tcg-runtime-gvec.o
>   CC      ppcemb-softmmu/accel/tcg/cpu-exec.o
>   CC      ppcemb-softmmu/accel/tcg/cpu-exec-common.o
>   CC      ppcemb-softmmu/accel/tcg/translate-all.o
>   CC      ppcemb-softmmu/accel/tcg/translator.o
>   CC      ppcemb-softmmu/hw/9pfs/virtio-9p-device.o
>   CC      ppcemb-softmmu/hw/block/virtio-blk.o
>   CC      ppcemb-softmmu/hw/block/vhost-user-blk.o
>   CC      ppcemb-softmmu/hw/block/dataplane/virtio-blk.o
>   CC      ppcemb-softmmu/hw/char/virtio-serial-bus.o
>   CC      ppcemb-softmmu/hw/core/generic-loader.o
>   CC      ppcemb-softmmu/hw/core/null-machine.o
>   CC      ppcemb-softmmu/hw/display/sm501.o
>   CC      ppcemb-softmmu/hw/display/vga.o
>   CC      ppcemb-softmmu/hw/display/virtio-gpu.o
>   CC      ppcemb-softmmu/hw/display/virtio-gpu-3d.o
>   CC      ppcemb-softmmu/hw/display/virtio-gpu-pci.o
>   CC      ppcemb-softmmu/hw/i2c/ppc4xx_i2c.o
>   CC      ppcemb-softmmu/hw/misc/ivshmem.o
>   CC      ppcemb-softmmu/hw/misc/mmio_interface.o
>   CC      ppcemb-softmmu/hw/net/xilinx_ethlite.o
>   CC      ppcemb-softmmu/hw/net/virtio-net.o
>   CC      ppcemb-softmmu/hw/net/vhost_net.o
>   CC      ppcemb-softmmu/hw/scsi/virtio-scsi.o
>   CC      ppcemb-softmmu/hw/scsi/virtio-scsi-dataplane.o
>   CC      ppcemb-softmmu/hw/scsi/vhost-scsi-common.o
>   CC      ppcemb-softmmu/hw/scsi/vhost-scsi.o
>   CC      ppcemb-softmmu/hw/scsi/vhost-user-scsi.o
>   CC      ppcemb-softmmu/hw/vfio/common.o
>   CC      ppcemb-softmmu/hw/vfio/pci.o
>   CC      ppcemb-softmmu/hw/vfio/pci-quirks.o
>   CC      ppcemb-softmmu/hw/vfio/display.o
>   CC      ppcemb-softmmu/hw/vfio/platform.o
>   CC      ppcemb-softmmu/hw/vfio/spapr.o
>   CC      ppcemb-softmmu/hw/virtio/virtio.o
>   CC      ppcemb-softmmu/hw/virtio/virtio-balloon.o
>   CC      ppcemb-softmmu/hw/virtio/virtio-crypto.o
>   CC      ppcemb-softmmu/hw/virtio/virtio-crypto-pci.o
>   CC      ppcemb-softmmu/hw/virtio/vhost.o
>   CC      ppcemb-softmmu/hw/virtio/vhost-backend.o
>   CC      ppcemb-softmmu/hw/virtio/vhost-user.o
>   CC      ppcemb-softmmu/hw/virtio/vhost-vsock.o
>   CC      ppcemb-softmmu/hw/ppc/ppc.o
>   CC      ppcemb-softmmu/hw/ppc/ppc_booke.o
>   CC      ppcemb-softmmu/hw/ppc/fdt.o
>   CC      ppcemb-softmmu/hw/ppc/ppc4xx_devs.o
>   CC      ppcemb-softmmu/hw/ppc/ppc405_uc.o
>   CC      ppcemb-softmmu/hw/ppc/ppc4xx_pci.o
>   CC      ppcemb-softmmu/hw/ppc/ppc405_boards.o
>   CC      ppcemb-softmmu/hw/ppc/ppc440_bamboo.o
>   CC      ppcemb-softmmu/hw/ppc/ppc440_pcix.o
>   CC      ppcemb-softmmu/hw/ppc/ppc440_uc.o
>   CC      ppcemb-softmmu/hw/ppc/sam460ex.o
>   CC      ppcemb-softmmu/hw/ppc/virtex_ml507.o
>   CC      ppcemb-softmmu/target/ppc/cpu-models.o
>   CC      ppcemb-softmmu/target/ppc/cpu.o
>   CC      ppcemb-softmmu/target/ppc/translate.o
>   CC      ppcemb-softmmu/target/ppc/machine.o
>   CC      ppcemb-softmmu/target/ppc/mmu_helper.o
>   CC      ppcemb-softmmu/target/ppc/mmu-hash32.o
>   CC      ppcemb-softmmu/target/ppc/monitor.o
>   CC      ppcemb-softmmu/target/ppc/arch_dump.o
>   CC      ppcemb-softmmu/target/ppc/kvm-stub.o
>   CC      ppcemb-softmmu/target/ppc/dfp_helper.o
>   CC      ppcemb-softmmu/target/ppc/excp_helper.o
>   CC      ppcemb-softmmu/target/ppc/fpu_helper.o
>   CC      ppcemb-softmmu/target/ppc/int_helper.o
>   CC      ppcemb-softmmu/target/ppc/timebase_helper.o
>   CC      ppcemb-softmmu/target/ppc/misc_helper.o
>   CC      ppcemb-softmmu/target/ppc/mem_helper.o
>   CC      ppcemb-softmmu/target/ppc/gdbstub.o
>   CC      ppcemb-softmmu/target/ppc/../../libdecnumber/decContext.o
>   CC      ppcemb-softmmu/target/ppc/../../libdecnumber/decNumber.o
>   CC      ppcemb-softmmu/target/ppc/../../libdecnumber/dpd/decimal32.o
>   CC      ppcemb-softmmu/target/ppc/../../libdecnumber/dpd/decimal64.o
>   CC      ppcemb-softmmu/target/ppc/../../libdecnumber/dpd/decimal128.o
>   GEN     trace/generated-helpers.c
>   CC      ppcemb-softmmu/trace/control-target.o
>   CC      ppcemb-softmmu/gdbstub-xml.o
>   CC      ppcemb-softmmu/trace/generated-helpers.o
>   LINK    ppcemb-softmmu/qemu-system-ppcemb
>   GEN     ppc-softmmu/hmp-commands.h
>   GEN     ppc-softmmu/hmp-commands-info.h
>   GEN     ppc-softmmu/config-target.h
>   CC      ppc-softmmu/exec.o
>   CC      ppc-softmmu/tcg/tcg.o
>   CC      ppc-softmmu/tcg/tcg-op.o
>   CC      ppc-softmmu/tcg/tcg-op-vec.o
>   CC      ppc-softmmu/tcg/tcg-op-gvec.o
>   CC      ppc-softmmu/tcg/tcg-common.o
>   CC      ppc-softmmu/tcg/optimize.o
>   CC      ppc-softmmu/fpu/softfloat.o
>   CC      ppc-softmmu/disas.o
>   GEN     ppc-softmmu/gdbstub-xml.c
>   CC      ppc-softmmu/arch_init.o
>   CC      ppc-softmmu/cpus.o
>   CC      ppc-softmmu/monitor.o
>   CC      ppc-softmmu/gdbstub.o
>   CC      ppc-softmmu/balloon.o
>   CC      ppc-softmmu/ioport.o
>   CC      ppc-softmmu/numa.o
>   CC      ppc-softmmu/qtest.o
>   CC      ppc-softmmu/memory.o
>   CC      ppc-softmmu/memory_mapping.o
>   CC      ppc-softmmu/dump.o
>   CC      ppc-softmmu/migration/ram.o
>   CC      ppc-softmmu/accel/accel.o
>   CC      ppc-softmmu/accel/stubs/hax-stub.o
>   CC      ppc-softmmu/accel/stubs/hvf-stub.o
>   CC      ppc-softmmu/accel/stubs/whpx-stub.o
>   CC      ppc-softmmu/accel/stubs/kvm-stub.o
>   CC      ppc-softmmu/accel/tcg/tcg-all.o
>   CC      ppc-softmmu/accel/tcg/cputlb.o
>   CC      ppc-softmmu/accel/tcg/tcg-runtime.o
>   CC      ppc-softmmu/accel/tcg/tcg-runtime-gvec.o
>   CC      ppc-softmmu/accel/tcg/cpu-exec.o
>   CC      ppc-softmmu/accel/tcg/cpu-exec-common.o
>   CC      ppc-softmmu/accel/tcg/translate-all.o
>   CC      ppc-softmmu/accel/tcg/translator.o
>   CC      ppc-softmmu/hw/9pfs/virtio-9p-device.o
>   CC      ppc-softmmu/hw/block/virtio-blk.o
>   CC      ppc-softmmu/hw/block/vhost-user-blk.o
>   CC      ppc-softmmu/hw/block/dataplane/virtio-blk.o
>   CC      ppc-softmmu/hw/char/virtio-serial-bus.o
>   CC      ppc-softmmu/hw/core/generic-loader.o
>   CC      ppc-softmmu/hw/core/null-machine.o
>   CC      ppc-softmmu/hw/display/sm501.o
>   CC      ppc-softmmu/hw/display/vga.o
>   CC      ppc-softmmu/hw/display/virtio-gpu.o
>   CC      ppc-softmmu/hw/display/virtio-gpu-3d.o
>   CC      ppc-softmmu/hw/display/virtio-gpu-pci.o
>   CC      ppc-softmmu/hw/i2c/ppc4xx_i2c.o
>   CC      ppc-softmmu/hw/misc/ivshmem.o
>   CC      ppc-softmmu/hw/misc/mmio_interface.o
>   CC      ppc-softmmu/hw/net/xilinx_ethlite.o
>   CC      ppc-softmmu/hw/net/virtio-net.o
>   CC      ppc-softmmu/hw/net/vhost_net.o
>   CC      ppc-softmmu/hw/net/fsl_etsec/etsec.o
>   CC      ppc-softmmu/hw/net/fsl_etsec/registers.o
>   CC      ppc-softmmu/hw/net/fsl_etsec/rings.o
>   CC      ppc-softmmu/hw/net/fsl_etsec/miim.o
>   CC      ppc-softmmu/hw/scsi/virtio-scsi.o
>   CC      ppc-softmmu/hw/scsi/virtio-scsi-dataplane.o
>   CC      ppc-softmmu/hw/scsi/vhost-scsi-common.o
>   CC      ppc-softmmu/hw/scsi/vhost-scsi.o
>   CC      ppc-softmmu/hw/scsi/vhost-user-scsi.o
>   CC      ppc-softmmu/hw/timer/mc146818rtc.o
>   CC      ppc-softmmu/hw/vfio/common.o
>   CC      ppc-softmmu/hw/vfio/pci.o
>   CC      ppc-softmmu/hw/vfio/pci-quirks.o
>   CC      ppc-softmmu/hw/vfio/display.o
>   CC      ppc-softmmu/hw/vfio/platform.o
>   CC      ppc-softmmu/hw/vfio/spapr.o
>   CC      ppc-softmmu/hw/virtio/virtio.o
>   CC      ppc-softmmu/hw/virtio/virtio-balloon.o
>   CC      ppc-softmmu/hw/virtio/virtio-crypto.o
>   CC      ppc-softmmu/hw/virtio/virtio-crypto-pci.o
>   CC      ppc-softmmu/hw/virtio/vhost.o
>   CC      ppc-softmmu/hw/virtio/vhost-backend.o
>   CC      ppc-softmmu/hw/virtio/vhost-user.o
>   CC      ppc-softmmu/hw/virtio/vhost-vsock.o
>   CC      ppc-softmmu/hw/ppc/ppc.o
>   CC      ppc-softmmu/hw/ppc/ppc_booke.o
>   CC      ppc-softmmu/hw/ppc/fdt.o
>   CC      ppc-softmmu/hw/ppc/ppc4xx_devs.o
>   CC      ppc-softmmu/hw/ppc/ppc405_uc.o
>   CC      ppc-softmmu/hw/ppc/ppc4xx_pci.o
>   CC      ppc-softmmu/hw/ppc/ppc405_boards.o
>   CC      ppc-softmmu/hw/ppc/ppc440_bamboo.o
>   CC      ppc-softmmu/hw/ppc/ppc440_pcix.o
>   CC      ppc-softmmu/hw/ppc/ppc440_uc.o
>   CC      ppc-softmmu/hw/ppc/sam460ex.o
>   CC      ppc-softmmu/hw/ppc/prep.o
>   CC      ppc-softmmu/hw/ppc/prep_systemio.o
>   CC      ppc-softmmu/hw/ppc/rs6000_mc.o
>   CC      ppc-softmmu/hw/ppc/mac_oldworld.o
>   CC      ppc-softmmu/hw/ppc/mac_newworld.o
>   CC      ppc-softmmu/hw/ppc/e500.o
>   CC      ppc-softmmu/hw/ppc/mpc8544ds.o
>   CC      ppc-softmmu/hw/ppc/e500plat.o
>   CC      ppc-softmmu/hw/ppc/mpc8544_guts.o
>   CC      ppc-softmmu/hw/ppc/ppce500_spin.o
>   CC      ppc-softmmu/hw/ppc/virtex_ml507.o
>   CC      ppc-softmmu/target/ppc/cpu-models.o
>   CC      ppc-softmmu/target/ppc/cpu.o
>   CC      ppc-softmmu/target/ppc/translate.o
>   CC      ppc-softmmu/target/ppc/machine.o
>   CC      ppc-softmmu/target/ppc/mmu_helper.o
>   CC      ppc-softmmu/target/ppc/mmu-hash32.o
>   CC      ppc-softmmu/target/ppc/monitor.o
>   CC      ppc-softmmu/target/ppc/arch_dump.o
>   CC      ppc-softmmu/target/ppc/kvm-stub.o
>   CC      ppc-softmmu/target/ppc/dfp_helper.o
>   CC      ppc-softmmu/target/ppc/excp_helper.o
>   CC      ppc-softmmu/target/ppc/fpu_helper.o
>   CC      ppc-softmmu/target/ppc/int_helper.o
>   CC      ppc-softmmu/target/ppc/timebase_helper.o
>   CC      ppc-softmmu/target/ppc/misc_helper.o
>   CC      ppc-softmmu/target/ppc/mem_helper.o
>   CC      ppc-softmmu/target/ppc/gdbstub.o
>   CC      ppc-softmmu/target/ppc/../../libdecnumber/decContext.o
>   CC      ppc-softmmu/target/ppc/../../libdecnumber/decNumber.o
>   CC      ppc-softmmu/target/ppc/../../libdecnumber/dpd/decimal32.o
>   CC      ppc-softmmu/target/ppc/../../libdecnumber/dpd/decimal64.o
>   CC      ppc-softmmu/target/ppc/../../libdecnumber/dpd/decimal128.o
>   GEN     trace/generated-helpers.c
>   CC      ppc-softmmu/trace/control-target.o
>   CC      ppc-softmmu/gdbstub-xml.o
>   CC      ppc-softmmu/trace/generated-helpers.o
>   LINK    ppc-softmmu/qemu-system-ppc
>   GEN     riscv32-softmmu/hmp-commands.h
>   GEN     riscv32-softmmu/hmp-commands-info.h
>   GEN     riscv32-softmmu/config-target.h
>   CC      riscv32-softmmu/exec.o
>   CC      riscv32-softmmu/tcg/tcg.o
>   CC      riscv32-softmmu/tcg/tcg-op.o
>   CC      riscv32-softmmu/tcg/tcg-op-vec.o
>   CC      riscv32-softmmu/tcg/tcg-op-gvec.o
>   CC      riscv32-softmmu/tcg/tcg-common.o
>   CC      riscv32-softmmu/tcg/optimize.o
>   CC      riscv32-softmmu/fpu/softfloat.o
>   CC      riscv32-softmmu/disas.o
>   CC      riscv32-softmmu/arch_init.o
>   CC      riscv32-softmmu/cpus.o
>   CC      riscv32-softmmu/monitor.o
>   CC      riscv32-softmmu/gdbstub.o
>   CC      riscv32-softmmu/balloon.o
>   CC      riscv32-softmmu/ioport.o
>   CC      riscv32-softmmu/numa.o
>   CC      riscv32-softmmu/qtest.o
>   CC      riscv32-softmmu/memory.o
>   CC      riscv32-softmmu/memory_mapping.o
>   CC      riscv32-softmmu/dump.o
>   CC      riscv32-softmmu/migration/ram.o
>   CC      riscv32-softmmu/accel/accel.o
>   CC      riscv32-softmmu/accel/stubs/hax-stub.o
>   CC      riscv32-softmmu/accel/stubs/hvf-stub.o
>   CC      riscv32-softmmu/accel/stubs/whpx-stub.o
>   CC      riscv32-softmmu/accel/stubs/kvm-stub.o
>   CC      riscv32-softmmu/accel/tcg/tcg-all.o
>   CC      riscv32-softmmu/accel/tcg/cputlb.o
>   CC      riscv32-softmmu/accel/tcg/tcg-runtime.o
>   CC      riscv32-softmmu/accel/tcg/tcg-runtime-gvec.o
>   CC      riscv32-softmmu/accel/tcg/cpu-exec.o
>   CC      riscv32-softmmu/accel/tcg/cpu-exec-common.o
>   CC      riscv32-softmmu/accel/tcg/translate-all.o
>   CC      riscv32-softmmu/accel/tcg/translator.o
>   CC      riscv32-softmmu/hw/9pfs/virtio-9p-device.o
>   CC      riscv32-softmmu/hw/block/virtio-blk.o
>   CC      riscv32-softmmu/hw/block/vhost-user-blk.o
>   CC      riscv32-softmmu/hw/block/dataplane/virtio-blk.o
>   CC      riscv32-softmmu/hw/char/virtio-serial-bus.o
>   CC      riscv32-softmmu/hw/core/generic-loader.o
>   CC      riscv32-softmmu/hw/core/null-machine.o
>   CC      riscv32-softmmu/hw/display/virtio-gpu.o
>   CC      riscv32-softmmu/hw/display/virtio-gpu-3d.o
>   CC      riscv32-softmmu/hw/misc/mmio_interface.o
>   CC      riscv32-softmmu/hw/net/virtio-net.o
>   CC      riscv32-softmmu/hw/net/vhost_net.o
>   CC      riscv32-softmmu/hw/net/rocker/qmp-norocker.o
>   CC      riscv32-softmmu/hw/scsi/virtio-scsi.o
>   CC      riscv32-softmmu/hw/scsi/virtio-scsi-dataplane.o
>   CC      riscv32-softmmu/hw/scsi/vhost-scsi-common.o
>   CC      riscv32-softmmu/hw/scsi/vhost-scsi.o
>   CC      riscv32-softmmu/hw/scsi/vhost-user-scsi.o
>   CC      riscv32-softmmu/hw/vfio/common.o
>   CC      riscv32-softmmu/hw/vfio/platform.o
>   CC      riscv32-softmmu/hw/vfio/spapr.o
>   CC      riscv32-softmmu/hw/virtio/virtio.o
>   CC      riscv32-softmmu/hw/virtio/virtio-balloon.o
>   CC      riscv32-softmmu/hw/virtio/virtio-crypto.o
>   CC      riscv32-softmmu/hw/virtio/vhost.o
>   CC      riscv32-softmmu/hw/virtio/vhost-backend.o
>   CC      riscv32-softmmu/hw/virtio/vhost-user.o
>   CC      riscv32-softmmu/hw/virtio/vhost-vsock.o
>   CC      riscv32-softmmu/hw/riscv/riscv_htif.o
>   CC      riscv32-softmmu/hw/riscv/riscv_hart.o
>   CC      riscv32-softmmu/hw/riscv/sifive_e.o
>   CC      riscv32-softmmu/hw/riscv/sifive_clint.o
>   CC      riscv32-softmmu/hw/riscv/sifive_prci.o
>   CC      riscv32-softmmu/hw/riscv/sifive_plic.o
>   CC      riscv32-softmmu/hw/riscv/sifive_test.o
>   CC      riscv32-softmmu/hw/riscv/sifive_u.o
>   CC      riscv32-softmmu/hw/riscv/sifive_uart.o
>   CC      riscv32-softmmu/hw/riscv/spike.o
>   CC      riscv32-softmmu/hw/riscv/virt.o
>   CC      riscv32-softmmu/target/riscv/translate.o
>   CC      riscv32-softmmu/target/riscv/op_helper.o
>   CC      riscv32-softmmu/target/riscv/helper.o
>   CC      riscv32-softmmu/target/riscv/cpu.o
>   CC      riscv32-softmmu/target/riscv/fpu_helper.o
>   CC      riscv32-softmmu/target/riscv/gdbstub.o
>   CC      riscv32-softmmu/target/riscv/pmp.o
>   GEN     trace/generated-helpers.c
>   CC      riscv32-softmmu/trace/control-target.o
>   CC      riscv32-softmmu/trace/generated-helpers.o
>   LINK    riscv32-softmmu/qemu-system-riscv32
>   GEN     riscv64-softmmu/hmp-commands.h
>   GEN     riscv64-softmmu/hmp-commands-info.h
>   GEN     riscv64-softmmu/config-target.h
>   CC      riscv64-softmmu/exec.o
>   CC      riscv64-softmmu/tcg/tcg.o
>   CC      riscv64-softmmu/tcg/tcg-op.o
>   CC      riscv64-softmmu/tcg/tcg-op-vec.o
>   CC      riscv64-softmmu/tcg/tcg-op-gvec.o
>   CC      riscv64-softmmu/tcg/tcg-common.o
>   CC      riscv64-softmmu/tcg/optimize.o
>   CC      riscv64-softmmu/fpu/softfloat.o
>   CC      riscv64-softmmu/disas.o
>   CC      riscv64-softmmu/arch_init.o
>   CC      riscv64-softmmu/cpus.o
>   CC      riscv64-softmmu/monitor.o
>   CC      riscv64-softmmu/gdbstub.o
>   CC      riscv64-softmmu/balloon.o
>   CC      riscv64-softmmu/ioport.o
>   CC      riscv64-softmmu/numa.o
>   CC      riscv64-softmmu/qtest.o
>   CC      riscv64-softmmu/memory.o
>   CC      riscv64-softmmu/memory_mapping.o
>   CC      riscv64-softmmu/dump.o
>   CC      riscv64-softmmu/migration/ram.o
>   CC      riscv64-softmmu/accel/accel.o
>   CC      riscv64-softmmu/accel/stubs/hax-stub.o
>   CC      riscv64-softmmu/accel/stubs/hvf-stub.o
>   CC      riscv64-softmmu/accel/stubs/whpx-stub.o
>   CC      riscv64-softmmu/accel/stubs/kvm-stub.o
>   CC      riscv64-softmmu/accel/tcg/tcg-all.o
>   CC      riscv64-softmmu/accel/tcg/cputlb.o
>   CC      riscv64-softmmu/accel/tcg/tcg-runtime.o
>   CC      riscv64-softmmu/accel/tcg/tcg-runtime-gvec.o
>   CC      riscv64-softmmu/accel/tcg/cpu-exec.o
>   CC      riscv64-softmmu/accel/tcg/cpu-exec-common.o
>   CC      riscv64-softmmu/accel/tcg/translate-all.o
>   CC      riscv64-softmmu/accel/tcg/translator.o
>   CC      riscv64-softmmu/hw/9pfs/virtio-9p-device.o
>   CC      riscv64-softmmu/hw/block/virtio-blk.o
>   CC      riscv64-softmmu/hw/block/vhost-user-blk.o
>   CC      riscv64-softmmu/hw/block/dataplane/virtio-blk.o
>   CC      riscv64-softmmu/hw/char/virtio-serial-bus.o
>   CC      riscv64-softmmu/hw/core/generic-loader.o
>   CC      riscv64-softmmu/hw/core/null-machine.o
>   CC      riscv64-softmmu/hw/display/virtio-gpu.o
>   CC      riscv64-softmmu/hw/display/virtio-gpu-3d.o
>   CC      riscv64-softmmu/hw/misc/mmio_interface.o
>   CC      riscv64-softmmu/hw/net/virtio-net.o
>   CC      riscv64-softmmu/hw/net/vhost_net.o
>   CC      riscv64-softmmu/hw/net/rocker/qmp-norocker.o
>   CC      riscv64-softmmu/hw/scsi/virtio-scsi.o
>   CC      riscv64-softmmu/hw/scsi/virtio-scsi-dataplane.o
>   CC      riscv64-softmmu/hw/scsi/vhost-scsi-common.o
>   CC      riscv64-softmmu/hw/scsi/vhost-scsi.o
>   CC      riscv64-softmmu/hw/scsi/vhost-user-scsi.o
>   CC      riscv64-softmmu/hw/vfio/common.o
>   CC      riscv64-softmmu/hw/vfio/platform.o
>   CC      riscv64-softmmu/hw/vfio/spapr.o
>   CC      riscv64-softmmu/hw/virtio/virtio.o
>   CC      riscv64-softmmu/hw/virtio/virtio-balloon.o
>   CC      riscv64-softmmu/hw/virtio/virtio-crypto.o
>   CC      riscv64-softmmu/hw/virtio/vhost.o
>   CC      riscv64-softmmu/hw/virtio/vhost-backend.o
>   CC      riscv64-softmmu/hw/virtio/vhost-user.o
>   CC      riscv64-softmmu/hw/virtio/vhost-vsock.o
>   CC      riscv64-softmmu/hw/riscv/riscv_htif.o
>   CC      riscv64-softmmu/hw/riscv/riscv_hart.o
>   CC      riscv64-softmmu/hw/riscv/sifive_e.o
>   CC      riscv64-softmmu/hw/riscv/sifive_clint.o
>   CC      riscv64-softmmu/hw/riscv/sifive_prci.o
>   CC      riscv64-softmmu/hw/riscv/sifive_plic.o
>   CC      riscv64-softmmu/hw/riscv/sifive_test.o
>   CC      riscv64-softmmu/hw/riscv/sifive_u.o
>   CC      riscv64-softmmu/hw/riscv/sifive_uart.o
>   CC      riscv64-softmmu/hw/riscv/spike.o
>   CC      riscv64-softmmu/hw/riscv/virt.o
>   CC      riscv64-softmmu/target/riscv/translate.o
>   CC      riscv64-softmmu/target/riscv/op_helper.o
>   CC      riscv64-softmmu/target/riscv/helper.o
>   CC      riscv64-softmmu/target/riscv/cpu.o
>   CC      riscv64-softmmu/target/riscv/fpu_helper.o
>   CC      riscv64-softmmu/target/riscv/gdbstub.o
>   CC      riscv64-softmmu/target/riscv/pmp.o
>   GEN     trace/generated-helpers.c
>   CC      riscv64-softmmu/trace/control-target.o
>   CC      riscv64-softmmu/trace/generated-helpers.o
>   LINK    riscv64-softmmu/qemu-system-riscv64
>   GEN     s390x-softmmu/hmp-commands.h
>   GEN     s390x-softmmu/hmp-commands-info.h
>   CC      s390x-softmmu/gen-features
>   GEN     s390x-softmmu/config-target.h
>   GEN     s390x-softmmu/gen-features.h
>   CC      s390x-softmmu/exec.o
>   CC      s390x-softmmu/tcg/tcg.o
>   CC      s390x-softmmu/tcg/tcg-op.o
>   CC      s390x-softmmu/tcg/tcg-op-vec.o
>   CC      s390x-softmmu/tcg/tcg-op-gvec.o
>   CC      s390x-softmmu/tcg/tcg-common.o
>   CC      s390x-softmmu/tcg/optimize.o
>   CC      s390x-softmmu/fpu/softfloat.o
>   CC      s390x-softmmu/disas.o
>   GEN     s390x-softmmu/gdbstub-xml.c
>   CC      s390x-softmmu/arch_init.o
>   CC      s390x-softmmu/cpus.o
>   CC      s390x-softmmu/monitor.o
>   CC      s390x-softmmu/gdbstub.o
>   CC      s390x-softmmu/balloon.o
>   CC      s390x-softmmu/ioport.o
>   CC      s390x-softmmu/numa.o
>   CC      s390x-softmmu/qtest.o
>   CC      s390x-softmmu/memory.o
>   CC      s390x-softmmu/memory_mapping.o
>   CC      s390x-softmmu/dump.o
>   CC      s390x-softmmu/migration/ram.o
>   CC      s390x-softmmu/accel/accel.o
>   CC      s390x-softmmu/accel/kvm/kvm-all.o
>   CC      s390x-softmmu/accel/kvm/sev-stub.o
>   CC      s390x-softmmu/accel/stubs/hax-stub.o
>   CC      s390x-softmmu/accel/stubs/hvf-stub.o
>   CC      s390x-softmmu/accel/stubs/whpx-stub.o
>   CC      s390x-softmmu/accel/tcg/tcg-all.o
>   CC      s390x-softmmu/accel/tcg/cputlb.o
>   CC      s390x-softmmu/accel/tcg/tcg-runtime.o
>   CC      s390x-softmmu/accel/tcg/tcg-runtime-gvec.o
>   CC      s390x-softmmu/accel/tcg/cpu-exec.o
>   CC      s390x-softmmu/accel/tcg/cpu-exec-common.o
>   CC      s390x-softmmu/accel/tcg/translate-all.o
>   CC      s390x-softmmu/accel/tcg/translator.o
>   CC      s390x-softmmu/hw/9pfs/virtio-9p-device.o
>   CC      s390x-softmmu/hw/block/virtio-blk.o
>   CC      s390x-softmmu/hw/block/vhost-user-blk.o
>   CC      s390x-softmmu/hw/block/dataplane/virtio-blk.o
>   CC      s390x-softmmu/hw/char/virtio-serial-bus.o
>   CC      s390x-softmmu/hw/char/terminal3270.o
>   CC      s390x-softmmu/hw/core/generic-loader.o
>   CC      s390x-softmmu/hw/core/null-machine.o
>   CC      s390x-softmmu/hw/display/virtio-gpu.o
>   CC      s390x-softmmu/hw/display/virtio-gpu-3d.o
>   CC      s390x-softmmu/hw/display/virtio-gpu-pci.o
>   CC      s390x-softmmu/hw/intc/s390_flic.o
>   CC      s390x-softmmu/hw/intc/s390_flic_kvm.o
>   CC      s390x-softmmu/hw/misc/mmio_interface.o
>   CC      s390x-softmmu/hw/net/virtio-net.o
>   CC      s390x-softmmu/hw/net/vhost_net.o
>   CC      s390x-softmmu/hw/net/rocker/qmp-norocker.o
>   CC      s390x-softmmu/hw/scsi/virtio-scsi.o
>   CC      s390x-softmmu/hw/scsi/virtio-scsi-dataplane.o
>   CC      s390x-softmmu/hw/scsi/vhost-scsi-common.o
>   CC      s390x-softmmu/hw/scsi/vhost-scsi.o
>   CC      s390x-softmmu/hw/scsi/vhost-user-scsi.o
>   CC      s390x-softmmu/hw/vfio/common.o
>   CC      s390x-softmmu/hw/vfio/pci.o
>   CC      s390x-softmmu/hw/vfio/pci-quirks.o
>   CC      s390x-softmmu/hw/vfio/display.o
>   CC      s390x-softmmu/hw/vfio/ccw.o
>   CC      s390x-softmmu/hw/vfio/platform.o
>   CC      s390x-softmmu/hw/vfio/spapr.o
>   CC      s390x-softmmu/hw/virtio/virtio.o
>   CC      s390x-softmmu/hw/virtio/virtio-balloon.o
>   CC      s390x-softmmu/hw/virtio/virtio-crypto.o
>   CC      s390x-softmmu/hw/virtio/virtio-crypto-pci.o
>   CC      s390x-softmmu/hw/virtio/vhost.o
>   CC      s390x-softmmu/hw/virtio/vhost-backend.o
>   CC      s390x-softmmu/hw/virtio/vhost-user.o
>   CC      s390x-softmmu/hw/virtio/vhost-vsock.o
>   CC      s390x-softmmu/hw/s390x/s390-virtio-hcall.o
>   CC      s390x-softmmu/hw/s390x/sclp.o
>   CC      s390x-softmmu/hw/s390x/event-facility.o
>   CC      s390x-softmmu/hw/s390x/sclpquiesce.o
>   CC      s390x-softmmu/hw/s390x/sclpcpu.o
>   CC      s390x-softmmu/hw/s390x/ipl.o
>   CC      s390x-softmmu/hw/s390x/css.o
>   CC      s390x-softmmu/hw/s390x/s390-virtio-ccw.o
>   CC      s390x-softmmu/hw/s390x/3270-ccw.o
>   CC      s390x-softmmu/hw/s390x/virtio-ccw.o
>   CC      s390x-softmmu/hw/s390x/css-bridge.o
>   CC      s390x-softmmu/hw/s390x/ccw-device.o
>   CC      s390x-softmmu/hw/s390x/s390-pci-bus.o
>   CC      s390x-softmmu/hw/s390x/s390-pci-inst.o
>   CC      s390x-softmmu/hw/s390x/s390-skeys.o
>   CC      s390x-softmmu/hw/s390x/s390-stattrib.o
>   CC      s390x-softmmu/hw/s390x/s390-skeys-kvm.o
>   CC      s390x-softmmu/hw/s390x/s390-stattrib-kvm.o
>   CC      s390x-softmmu/hw/s390x/s390-ccw.o
>   CC      s390x-softmmu/target/s390x/cpu.o
>   CC      s390x-softmmu/target/s390x/cpu_models.o
>   CC      s390x-softmmu/target/s390x/cpu_features.o
>   CC      s390x-softmmu/target/s390x/gdbstub.o
>   CC      s390x-softmmu/target/s390x/interrupt.o
>   CC      s390x-softmmu/target/s390x/helper.o
>   CC      s390x-softmmu/target/s390x/translate.o
>   CC      s390x-softmmu/target/s390x/cc_helper.o
>   CC      s390x-softmmu/target/s390x/excp_helper.o
>   CC      s390x-softmmu/target/s390x/fpu_helper.o
>   CC      s390x-softmmu/target/s390x/int_helper.o
>   CC      s390x-softmmu/target/s390x/mem_helper.o
>   CC      s390x-softmmu/target/s390x/misc_helper.o
>   CC      s390x-softmmu/target/s390x/crypto_helper.o
>   CC      s390x-softmmu/target/s390x/machine.o
>   CC      s390x-softmmu/target/s390x/ioinst.o
>   CC      s390x-softmmu/target/s390x/arch_dump.o
>   CC      s390x-softmmu/target/s390x/mmu_helper.o
>   CC      s390x-softmmu/target/s390x/diag.o
>   CC      s390x-softmmu/target/s390x/sigp.o
>   CC      s390x-softmmu/target/s390x/kvm.o
>   GEN     trace/generated-helpers.c
>   CC      s390x-softmmu/trace/control-target.o
>   CC      s390x-softmmu/gdbstub-xml.o
>   CC      s390x-softmmu/trace/generated-helpers.o
>   LINK    s390x-softmmu/qemu-system-s390x
>   GEN     sh4eb-softmmu/hmp-commands.h
>   GEN     sh4eb-softmmu/hmp-commands-info.h
>   GEN     sh4eb-softmmu/config-target.h
>   CC      sh4eb-softmmu/exec.o
>   CC      sh4eb-softmmu/tcg/tcg.o
>   CC      sh4eb-softmmu/tcg/tcg-op.o
>   CC      sh4eb-softmmu/tcg/tcg-op-vec.o
>   CC      sh4eb-softmmu/tcg/tcg-op-gvec.o
>   CC      sh4eb-softmmu/tcg/tcg-common.o
>   CC      sh4eb-softmmu/tcg/optimize.o
>   CC      sh4eb-softmmu/fpu/softfloat.o
>   CC      sh4eb-softmmu/disas.o
>   CC      sh4eb-softmmu/arch_init.o
>   CC      sh4eb-softmmu/cpus.o
>   CC      sh4eb-softmmu/monitor.o
>   CC      sh4eb-softmmu/gdbstub.o
>   CC      sh4eb-softmmu/balloon.o
>   CC      sh4eb-softmmu/ioport.o
>   CC      sh4eb-softmmu/numa.o
>   CC      sh4eb-softmmu/qtest.o
>   CC      sh4eb-softmmu/memory.o
>   CC      sh4eb-softmmu/memory_mapping.o
>   CC      sh4eb-softmmu/dump.o
>   CC      sh4eb-softmmu/migration/ram.o
>   CC      sh4eb-softmmu/accel/accel.o
>   CC      sh4eb-softmmu/accel/stubs/hax-stub.o
>   CC      sh4eb-softmmu/accel/stubs/hvf-stub.o
>   CC      sh4eb-softmmu/accel/stubs/whpx-stub.o
>   CC      sh4eb-softmmu/accel/stubs/kvm-stub.o
>   CC      sh4eb-softmmu/accel/tcg/tcg-all.o
>   CC      sh4eb-softmmu/accel/tcg/cputlb.o
>   CC      sh4eb-softmmu/accel/tcg/tcg-runtime.o
>   CC      sh4eb-softmmu/accel/tcg/tcg-runtime-gvec.o
>   CC      sh4eb-softmmu/accel/tcg/cpu-exec.o
>   CC      sh4eb-softmmu/accel/tcg/cpu-exec-common.o
>   CC      sh4eb-softmmu/accel/tcg/translate-all.o
>   CC      sh4eb-softmmu/accel/tcg/translator.o
>   CC      sh4eb-softmmu/hw/9pfs/virtio-9p-device.o
>   CC      sh4eb-softmmu/hw/block/tc58128.o
>   CC      sh4eb-softmmu/hw/block/virtio-blk.o
>   CC      sh4eb-softmmu/hw/block/vhost-user-blk.o
>   CC      sh4eb-softmmu/hw/block/dataplane/virtio-blk.o
>   CC      sh4eb-softmmu/hw/char/sh_serial.o
>   CC      sh4eb-softmmu/hw/char/virtio-serial-bus.o
>   CC      sh4eb-softmmu/hw/core/generic-loader.o
>   CC      sh4eb-softmmu/hw/core/null-machine.o
>   CC      sh4eb-softmmu/hw/display/sm501.o
>   CC      sh4eb-softmmu/hw/display/vga.o
>   CC      sh4eb-softmmu/hw/display/virtio-gpu.o
>   CC      sh4eb-softmmu/hw/display/virtio-gpu-3d.o
>   CC      sh4eb-softmmu/hw/display/virtio-gpu-pci.o
>   CC      sh4eb-softmmu/hw/intc/sh_intc.o
>   CC      sh4eb-softmmu/hw/misc/ivshmem.o
>   CC      sh4eb-softmmu/hw/misc/mmio_interface.o
>   CC      sh4eb-softmmu/hw/net/virtio-net.o
>   CC      sh4eb-softmmu/hw/net/vhost_net.o
>   CC      sh4eb-softmmu/hw/scsi/virtio-scsi.o
>   CC      sh4eb-softmmu/hw/scsi/virtio-scsi-dataplane.o
>   CC      sh4eb-softmmu/hw/scsi/vhost-scsi-common.o
>   CC      sh4eb-softmmu/hw/scsi/vhost-scsi.o
>   CC      sh4eb-softmmu/hw/scsi/vhost-user-scsi.o
>   CC      sh4eb-softmmu/hw/timer/sh_timer.o
>   CC      sh4eb-softmmu/hw/timer/mc146818rtc.o
>   CC      sh4eb-softmmu/hw/vfio/common.o
>   CC      sh4eb-softmmu/hw/vfio/pci.o
>   CC      sh4eb-softmmu/hw/vfio/pci-quirks.o
>   CC      sh4eb-softmmu/hw/vfio/display.o
>   CC      sh4eb-softmmu/hw/vfio/platform.o
>   CC      sh4eb-softmmu/hw/vfio/spapr.o
>   CC      sh4eb-softmmu/hw/virtio/virtio.o
>   CC      sh4eb-softmmu/hw/virtio/virtio-balloon.o
>   CC      sh4eb-softmmu/hw/virtio/virtio-crypto.o
>   CC      sh4eb-softmmu/hw/virtio/virtio-crypto-pci.o
>   CC      sh4eb-softmmu/hw/virtio/vhost.o
>   CC      sh4eb-softmmu/hw/virtio/vhost-backend.o
>   CC      sh4eb-softmmu/hw/virtio/vhost-user.o
>   CC      sh4eb-softmmu/hw/virtio/vhost-vsock.o
>   CC      sh4eb-softmmu/hw/sh4/shix.o
>   CC      sh4eb-softmmu/hw/sh4/r2d.o
>   CC      sh4eb-softmmu/hw/sh4/sh7750.o
>   CC      sh4eb-softmmu/hw/sh4/sh7750_regnames.o
>   CC      sh4eb-softmmu/hw/sh4/sh_pci.o
>   CC      sh4eb-softmmu/target/sh4/translate.o
>   CC      sh4eb-softmmu/target/sh4/op_helper.o
>   CC      sh4eb-softmmu/target/sh4/helper.o
>   CC      sh4eb-softmmu/target/sh4/cpu.o
>   CC      sh4eb-softmmu/target/sh4/monitor.o
>   CC      sh4eb-softmmu/target/sh4/gdbstub.o
>   GEN     trace/generated-helpers.c
>   CC      sh4eb-softmmu/trace/control-target.o
>   CC      sh4eb-softmmu/trace/generated-helpers.o
>   LINK    sh4eb-softmmu/qemu-system-sh4eb
>   GEN     ppc64-softmmu/gdbstub-xml.c
>   CC      ppc64-softmmu/arch_init.o
>   CC      ppc64-softmmu/cpus.o
>   GEN     sh4-softmmu/hmp-commands.h
>   GEN     sh4-softmmu/hmp-commands-info.h
>   GEN     sh4-softmmu/config-target.h
>   CC      sh4-softmmu/exec.o
>   CC      ppc64-softmmu/monitor.o
>   CC      sh4-softmmu/tcg/tcg.o
>   CC      ppc64-softmmu/gdbstub.o
>   CC      ppc64-softmmu/balloon.o
>   CC      ppc64-softmmu/ioport.o
>   CC      ppc64-softmmu/numa.o
>   CC      ppc64-softmmu/qtest.o
>   CC      sh4-softmmu/tcg/tcg-op.o
>   CC      ppc64-softmmu/memory.o
>   CC      ppc64-softmmu/memory_mapping.o
>   CC      ppc64-softmmu/dump.o
>   CC      sh4-softmmu/tcg/tcg-op-vec.o
>   CC      ppc64-softmmu/migration/ram.o
>   CC      sh4-softmmu/tcg/tcg-op-gvec.o
>   CC      ppc64-softmmu/accel/accel.o
>   CC      ppc64-softmmu/accel/stubs/hax-stub.o
>   CC      ppc64-softmmu/accel/stubs/hvf-stub.o
>   CC      sh4-softmmu/tcg/tcg-common.o
>   CC      ppc64-softmmu/accel/stubs/whpx-stub.o
>   CC      ppc64-softmmu/accel/stubs/kvm-stub.o
>   CC      sh4-softmmu/tcg/optimize.o
>   CC      ppc64-softmmu/accel/tcg/tcg-all.o
>   CC      ppc64-softmmu/accel/tcg/cputlb.o
>   CC      sh4-softmmu/fpu/softfloat.o
>   CC      ppc64-softmmu/accel/tcg/tcg-runtime.o
>   CC      ppc64-softmmu/accel/tcg/tcg-runtime-gvec.o
>   CC      ppc64-softmmu/accel/tcg/cpu-exec.o
>   CC      sh4-softmmu/disas.o
>   CC      ppc64-softmmu/accel/tcg/cpu-exec-common.o
>   CC      sh4-softmmu/arch_init.o
>   CC      ppc64-softmmu/accel/tcg/translate-all.o
>   CC      sh4-softmmu/cpus.o
>   CC      ppc64-softmmu/accel/tcg/translator.o
>   CC      sh4-softmmu/monitor.o
>   CC      ppc64-softmmu/hw/9pfs/virtio-9p-device.o
>   CC      ppc64-softmmu/hw/block/virtio-blk.o
>   CC      ppc64-softmmu/hw/block/vhost-user-blk.o
>   CC      ppc64-softmmu/hw/block/dataplane/virtio-blk.o
>   CC      sh4-softmmu/gdbstub.o
>   CC      ppc64-softmmu/hw/char/spapr_vty.o
>   CC      ppc64-softmmu/hw/char/virtio-serial-bus.o
>   CC      sh4-softmmu/balloon.o
>   CC      ppc64-softmmu/hw/core/generic-loader.o
>   CC      sh4-softmmu/ioport.o
>   CC      ppc64-softmmu/hw/core/null-machine.o
>   CC      sh4-softmmu/numa.o
>   CC      ppc64-softmmu/hw/display/sm501.o
>   CC      sh4-softmmu/qtest.o
>   CC      sh4-softmmu/memory.o
>   CC      ppc64-softmmu/hw/display/vga.o
>   CC      ppc64-softmmu/hw/display/virtio-gpu.o
>   CC      sh4-softmmu/memory_mapping.o
>   CC      sh4-softmmu/dump.o
>   CC      ppc64-softmmu/hw/display/virtio-gpu-3d.o
>   CC      sh4-softmmu/migration/ram.o
>   CC      ppc64-softmmu/hw/display/virtio-gpu-pci.o
>   CC      ppc64-softmmu/hw/display/virtio-vga.o
>   CC      sh4-softmmu/accel/accel.o
>   CC      ppc64-softmmu/hw/i2c/ppc4xx_i2c.o
>   CC      sh4-softmmu/accel/stubs/hax-stub.o
>   CC      ppc64-softmmu/hw/intc/xics.o
>   CC      sh4-softmmu/accel/stubs/hvf-stub.o
>   CC      sh4-softmmu/accel/stubs/whpx-stub.o
>   CC      ppc64-softmmu/hw/intc/xics_spapr.o
>   CC      sh4-softmmu/accel/stubs/kvm-stub.o
>   CC      sh4-softmmu/accel/tcg/tcg-all.o
>   CC      ppc64-softmmu/hw/intc/xics_pnv.o
>   CC      sh4-softmmu/accel/tcg/cputlb.o
>   CC      ppc64-softmmu/hw/misc/ivshmem.o
>   CC      ppc64-softmmu/hw/misc/mmio_interface.o
>   CC      ppc64-softmmu/hw/net/spapr_llan.o
>   CC      ppc64-softmmu/hw/net/xilinx_ethlite.o
>   CC      ppc64-softmmu/hw/net/virtio-net.o
>   CC      ppc64-softmmu/hw/net/vhost_net.o
>   CC      ppc64-softmmu/hw/net/fsl_etsec/etsec.o
>   CC      sh4-softmmu/accel/tcg/tcg-runtime.o
>   CC      ppc64-softmmu/hw/net/fsl_etsec/registers.o
>   CC      sh4-softmmu/accel/tcg/tcg-runtime-gvec.o
>   CC      ppc64-softmmu/hw/net/fsl_etsec/rings.o
>   CC      ppc64-softmmu/hw/net/fsl_etsec/miim.o
>   CC      ppc64-softmmu/hw/nvram/spapr_nvram.o
>   CC      ppc64-softmmu/hw/scsi/spapr_vscsi.o
>   CC      sh4-softmmu/accel/tcg/cpu-exec.o
>   CC      sh4-softmmu/accel/tcg/cpu-exec-common.o
>   CC      ppc64-softmmu/hw/scsi/virtio-scsi.o
>   CC      sh4-softmmu/accel/tcg/translate-all.o
>   CC      ppc64-softmmu/hw/scsi/virtio-scsi-dataplane.o
>   CC      sh4-softmmu/accel/tcg/translator.o
>   CC      ppc64-softmmu/hw/scsi/vhost-scsi-common.o
>   CC      sh4-softmmu/hw/9pfs/virtio-9p-device.o
>   CC      ppc64-softmmu/hw/scsi/vhost-scsi.o
>   CC      sh4-softmmu/hw/block/tc58128.o
>   CC      ppc64-softmmu/hw/scsi/vhost-user-scsi.o
>   CC      sh4-softmmu/hw/block/virtio-blk.o
>   CC      ppc64-softmmu/hw/timer/mc146818rtc.o
>   CC      sh4-softmmu/hw/block/vhost-user-blk.o
>   CC      ppc64-softmmu/hw/vfio/common.o
>   CC      sh4-softmmu/hw/block/dataplane/virtio-blk.o
>   CC      sh4-softmmu/hw/char/sh_serial.o
>   CC      sh4-softmmu/hw/char/virtio-serial-bus.o
>   CC      ppc64-softmmu/hw/vfio/pci.o
>   CC      sh4-softmmu/hw/core/generic-loader.o
>   CC      sh4-softmmu/hw/core/null-machine.o
>   CC      sh4-softmmu/hw/display/sm501.o
>   CC      ppc64-softmmu/hw/vfio/pci-quirks.o
>   CC      sh4-softmmu/hw/display/vga.o
>   CC      ppc64-softmmu/hw/vfio/display.o
>   CC      ppc64-softmmu/hw/vfio/platform.o
>   CC      sh4-softmmu/hw/display/virtio-gpu.o
>   CC      ppc64-softmmu/hw/vfio/spapr.o
>   CC      ppc64-softmmu/hw/virtio/virtio.o
>   CC      sh4-softmmu/hw/display/virtio-gpu-3d.o
>   CC      sh4-softmmu/hw/display/virtio-gpu-pci.o
>   CC      ppc64-softmmu/hw/virtio/virtio-balloon.o
>   CC      sh4-softmmu/hw/intc/sh_intc.o
>   CC      sh4-softmmu/hw/misc/ivshmem.o
>   CC      ppc64-softmmu/hw/virtio/virtio-crypto.o
>   CC      sh4-softmmu/hw/misc/mmio_interface.o
>   CC      ppc64-softmmu/hw/virtio/virtio-crypto-pci.o
>   CC      sh4-softmmu/hw/net/virtio-net.o
>   CC      ppc64-softmmu/hw/virtio/vhost.o
>   CC      sh4-softmmu/hw/net/vhost_net.o
>   CC      ppc64-softmmu/hw/virtio/vhost-backend.o
>   CC      sh4-softmmu/hw/scsi/virtio-scsi.o
>   CC      ppc64-softmmu/hw/virtio/vhost-user.o
>   CC      sh4-softmmu/hw/scsi/virtio-scsi-dataplane.o
>   CC      sh4-softmmu/hw/scsi/vhost-scsi-common.o
>   CC      ppc64-softmmu/hw/virtio/vhost-vsock.o
>   CC      sh4-softmmu/hw/scsi/vhost-scsi.o
>   CC      ppc64-softmmu/hw/ppc/ppc.o
>   CC      sh4-softmmu/hw/scsi/vhost-user-scsi.o
>   CC      sh4-softmmu/hw/timer/sh_timer.o
>   CC      ppc64-softmmu/hw/ppc/ppc_booke.o
>   CC      sh4-softmmu/hw/timer/mc146818rtc.o
>   CC      ppc64-softmmu/hw/ppc/fdt.o
>   CC      ppc64-softmmu/hw/ppc/spapr.o
>   CC      sh4-softmmu/hw/vfio/common.o
>   CC      sh4-softmmu/hw/vfio/pci.o
>   CC      ppc64-softmmu/hw/ppc/spapr_caps.o
>   CC      ppc64-softmmu/hw/ppc/spapr_vio.o
>   CC      ppc64-softmmu/hw/ppc/spapr_events.o
>   CC      sh4-softmmu/hw/vfio/pci-quirks.o
>   CC      ppc64-softmmu/hw/ppc/spapr_hcall.o
>   CC      sh4-softmmu/hw/vfio/display.o
>   CC      ppc64-softmmu/hw/ppc/spapr_iommu.o
>   CC      sh4-softmmu/hw/vfio/platform.o
>   CC      ppc64-softmmu/hw/ppc/spapr_rtas.o
>   CC      ppc64-softmmu/hw/ppc/spapr_pci.o
>   CC      sh4-softmmu/hw/vfio/spapr.o
>   CC      sh4-softmmu/hw/virtio/virtio.o
>   CC      ppc64-softmmu/hw/ppc/spapr_rtc.o
>   CC      ppc64-softmmu/hw/ppc/spapr_drc.o
>   CC      sh4-softmmu/hw/virtio/virtio-balloon.o
>   CC      ppc64-softmmu/hw/ppc/spapr_rng.o
>   CC      sh4-softmmu/hw/virtio/virtio-crypto.o
>   CC      ppc64-softmmu/hw/ppc/spapr_cpu_core.o
>   CC      ppc64-softmmu/hw/ppc/spapr_ovec.o
>   CC      sh4-softmmu/hw/virtio/virtio-crypto-pci.o
>   CC      ppc64-softmmu/hw/ppc/pnv.o
>   CC      sh4-softmmu/hw/virtio/vhost.o
>   CC      ppc64-softmmu/hw/ppc/pnv_xscom.o
>   CC      sh4-softmmu/hw/virtio/vhost-backend.o
>   CC      ppc64-softmmu/hw/ppc/pnv_core.o
>   CC      sh4-softmmu/hw/virtio/vhost-user.o
>   CC      ppc64-softmmu/hw/ppc/pnv_lpc.o
>   CC      ppc64-softmmu/hw/ppc/pnv_psi.o
>   CC      sh4-softmmu/hw/virtio/vhost-vsock.o
>   CC      ppc64-softmmu/hw/ppc/pnv_occ.o
>   CC      ppc64-softmmu/hw/ppc/pnv_bmc.o
>   CC      sh4-softmmu/hw/sh4/shix.o
>   CC      ppc64-softmmu/hw/ppc/spapr_pci_vfio.o
>   CC      sh4-softmmu/hw/sh4/r2d.o
>   CC      ppc64-softmmu/hw/ppc/spapr_rtas_ddw.o
>   CC      sh4-softmmu/hw/sh4/sh7750.o
>   CC      ppc64-softmmu/hw/ppc/ppc4xx_devs.o
>   CC      sh4-softmmu/hw/sh4/sh7750_regnames.o
>   CC      sh4-softmmu/hw/sh4/sh_pci.o
>   CC      ppc64-softmmu/hw/ppc/ppc405_uc.o
>   CC      sh4-softmmu/target/sh4/translate.o
>   CC      ppc64-softmmu/hw/ppc/ppc4xx_pci.o
>   CC      ppc64-softmmu/hw/ppc/ppc405_boards.o
>   CC      ppc64-softmmu/hw/ppc/ppc440_bamboo.o
>   CC      ppc64-softmmu/hw/ppc/ppc440_pcix.o
>   CC      sh4-softmmu/target/sh4/op_helper.o
>   CC      ppc64-softmmu/hw/ppc/ppc440_uc.o
>   CC      sh4-softmmu/target/sh4/helper.o
>   CC      ppc64-softmmu/hw/ppc/sam460ex.o
>   CC      sh4-softmmu/target/sh4/cpu.o
>   CC      ppc64-softmmu/hw/ppc/prep.o
>   CC      sh4-softmmu/target/sh4/monitor.o
>   CC      sh4-softmmu/target/sh4/gdbstub.o
>   CC      ppc64-softmmu/hw/ppc/prep_systemio.o
>   GEN     trace/generated-helpers.c
>   CC      sh4-softmmu/trace/control-target.o
>   CC      ppc64-softmmu/hw/ppc/rs6000_mc.o
>   CC      sh4-softmmu/trace/generated-helpers.o
>   CC      ppc64-softmmu/hw/ppc/mac_oldworld.o
>   LINK    sh4-softmmu/qemu-system-sh4
>   CC      ppc64-softmmu/hw/ppc/mac_newworld.o
>   CC      ppc64-softmmu/hw/ppc/e500.o
>   CC      ppc64-softmmu/hw/ppc/mpc8544ds.o
>   CC      ppc64-softmmu/hw/ppc/e500plat.o
>   CC      ppc64-softmmu/hw/ppc/mpc8544_guts.o
>   CC      ppc64-softmmu/hw/ppc/ppce500_spin.o
>   GEN     sparc64-softmmu/hmp-commands.h
>   GEN     sparc64-softmmu/hmp-commands-info.h
>   GEN     sparc64-softmmu/config-target.h
>   CC      sparc64-softmmu/exec.o
>   CC      sparc64-softmmu/tcg/tcg.o
>   CC      sparc64-softmmu/tcg/tcg-op.o
>   CC      sparc64-softmmu/tcg/tcg-op-vec.o
>   CC      sparc64-softmmu/tcg/tcg-op-gvec.o
>   CC      sparc64-softmmu/tcg/tcg-common.o
>   CC      sparc64-softmmu/tcg/optimize.o
>   CC      sparc64-softmmu/fpu/softfloat.o
>   CC      sparc64-softmmu/disas.o
>   CC      sparc64-softmmu/arch_init.o
>   CC      sparc64-softmmu/cpus.o
>   CC      sparc64-softmmu/monitor.o
>   CC      sparc64-softmmu/gdbstub.o
>   CC      sparc64-softmmu/balloon.o
>   CC      sparc64-softmmu/ioport.o
>   CC      sparc64-softmmu/numa.o
>   CC      sparc64-softmmu/qtest.o
>   CC      sparc64-softmmu/memory.o
>   CC      sparc64-softmmu/memory_mapping.o
>   CC      sparc64-softmmu/dump.o
>   CC      sparc64-softmmu/migration/ram.o
>   CC      sparc64-softmmu/accel/accel.o
>   CC      sparc64-softmmu/accel/stubs/hax-stub.o
>   CC      sparc64-softmmu/accel/stubs/hvf-stub.o
>   CC      sparc64-softmmu/accel/stubs/whpx-stub.o
>   CC      sparc64-softmmu/accel/stubs/kvm-stub.o
>   CC      sparc64-softmmu/accel/tcg/tcg-all.o
>   CC      sparc64-softmmu/accel/tcg/cputlb.o
>   CC      sparc64-softmmu/accel/tcg/tcg-runtime.o
>   CC      sparc64-softmmu/accel/tcg/tcg-runtime-gvec.o
>   CC      sparc64-softmmu/accel/tcg/cpu-exec.o
>   CC      sparc64-softmmu/accel/tcg/cpu-exec-common.o
>   CC      sparc64-softmmu/accel/tcg/translate-all.o
>   CC      sparc64-softmmu/accel/tcg/translator.o
>   CC      sparc64-softmmu/hw/9pfs/virtio-9p-device.o
>   CC      sparc64-softmmu/hw/block/virtio-blk.o
>   CC      sparc64-softmmu/hw/block/vhost-user-blk.o
>   CC      sparc64-softmmu/hw/block/dataplane/virtio-blk.o
>   CC      sparc64-softmmu/hw/char/virtio-serial-bus.o
>   CC      sparc64-softmmu/hw/core/generic-loader.o
>   CC      sparc64-softmmu/hw/core/null-machine.o
>   CC      sparc64-softmmu/hw/display/vga.o
>   CC      sparc64-softmmu/hw/display/virtio-gpu.o
>   CC      sparc64-softmmu/hw/display/virtio-gpu-3d.o
>   CC      sparc64-softmmu/hw/display/virtio-gpu-pci.o
>   CC      sparc64-softmmu/hw/misc/ivshmem.o
>   CC      sparc64-softmmu/hw/misc/mmio_interface.o
>   CC      sparc64-softmmu/hw/net/virtio-net.o
>   CC      sparc64-softmmu/hw/net/vhost_net.o
>   CC      sparc64-softmmu/hw/scsi/virtio-scsi.o
>   CC      sparc64-softmmu/hw/scsi/virtio-scsi-dataplane.o
>   CC      sparc64-softmmu/hw/scsi/vhost-scsi-common.o
>   CC      sparc64-softmmu/hw/scsi/vhost-scsi.o
>   CC      sparc64-softmmu/hw/scsi/vhost-user-scsi.o
>   CC      sparc64-softmmu/hw/timer/mc146818rtc.o
>   CC      sparc64-softmmu/hw/vfio/common.o
>   CC      sparc64-softmmu/hw/vfio/pci.o
>   CC      sparc64-softmmu/hw/vfio/pci-quirks.o
>   CC      sparc64-softmmu/hw/vfio/display.o
>   CC      sparc64-softmmu/hw/vfio/platform.o
>   CC      sparc64-softmmu/hw/vfio/spapr.o
>   CC      sparc64-softmmu/hw/virtio/virtio.o
>   CC      sparc64-softmmu/hw/virtio/virtio-balloon.o
>   CC      sparc64-softmmu/hw/virtio/virtio-crypto.o
>   CC      sparc64-softmmu/hw/virtio/virtio-crypto-pci.o
>   CC      sparc64-softmmu/hw/virtio/vhost.o
>   CC      sparc64-softmmu/hw/virtio/vhost-backend.o
>   CC      sparc64-softmmu/hw/virtio/vhost-user.o
>   CC      sparc64-softmmu/hw/virtio/vhost-vsock.o
>   CC      sparc64-softmmu/hw/sparc64/sparc64.o
>   CC      sparc64-softmmu/hw/sparc64/sun4u_iommu.o
>   CC      sparc64-softmmu/hw/sparc64/sun4u.o
>   CC      sparc64-softmmu/hw/sparc64/niagara.o
>   CC      sparc64-softmmu/target/sparc/machine.o
>   CC      sparc64-softmmu/target/sparc/monitor.o
>   CC      sparc64-softmmu/target/sparc/translate.o
>   CC      sparc64-softmmu/target/sparc/helper.o
>   CC      sparc64-softmmu/target/sparc/cpu.o
>   CC      sparc64-softmmu/target/sparc/fop_helper.o
>   CC      sparc64-softmmu/target/sparc/cc_helper.o
>   CC      sparc64-softmmu/target/sparc/win_helper.o
>   CC      sparc64-softmmu/target/sparc/mmu_helper.o
>   CC      sparc64-softmmu/target/sparc/ldst_helper.o
>   CC      sparc64-softmmu/target/sparc/int64_helper.o
>   CC      sparc64-softmmu/target/sparc/vis_helper.o
>   CC      sparc64-softmmu/target/sparc/gdbstub.o
>   GEN     trace/generated-helpers.c
>   CC      sparc64-softmmu/trace/control-target.o
>   CC      sparc64-softmmu/trace/generated-helpers.o
>   LINK    sparc64-softmmu/qemu-system-sparc64
>   CC      ppc64-softmmu/hw/ppc/virtex_ml507.o
>   CC      moxie-softmmu/fpu/softfloat.o
>   CC      ppc64-softmmu/target/ppc/cpu-models.o
>   CC      ppc64-softmmu/target/ppc/cpu.o
>   CC      moxie-softmmu/disas.o
>   CC      moxie-softmmu/arch_init.o
>   CC      moxie-softmmu/cpus.o
>   CC      moxie-softmmu/monitor.o
>   CC      moxie-softmmu/gdbstub.o
>   CC      moxie-softmmu/balloon.o
>   CC      moxie-softmmu/ioport.o
>   CC      moxie-softmmu/numa.o
>   CC      moxie-softmmu/qtest.o
>   CC      moxie-softmmu/memory.o
>   CC      moxie-softmmu/memory_mapping.o
>   CC      moxie-softmmu/dump.o
>   CC      moxie-softmmu/migration/ram.o
>   CC      moxie-softmmu/accel/accel.o
>   CC      moxie-softmmu/accel/stubs/hax-stub.o
>   CC      moxie-softmmu/accel/stubs/hvf-stub.o
>   CC      moxie-softmmu/accel/stubs/whpx-stub.o
>   CC      moxie-softmmu/accel/stubs/kvm-stub.o
>   CC      moxie-softmmu/accel/tcg/tcg-all.o
>   CC      moxie-softmmu/accel/tcg/cputlb.o
>   CC      moxie-softmmu/accel/tcg/tcg-runtime.o
>   CC      moxie-softmmu/accel/tcg/tcg-runtime-gvec.o
>   CC      moxie-softmmu/accel/tcg/cpu-exec.o
>   CC      moxie-softmmu/accel/tcg/cpu-exec-common.o
>   CC      moxie-softmmu/accel/tcg/translate-all.o
>   CC      moxie-softmmu/accel/tcg/translator.o
>   CC      moxie-softmmu/hw/core/generic-loader.o
>   CC      moxie-softmmu/hw/core/null-machine.o
>   CC      moxie-softmmu/hw/display/vga.o
>   CC      moxie-softmmu/hw/misc/mmio_interface.o
>   CC      moxie-softmmu/hw/net/vhost_net.o
>   CC      moxie-softmmu/hw/net/rocker/qmp-norocker.o
>   CC      moxie-softmmu/hw/timer/mc146818rtc.o
>   CC      moxie-softmmu/hw/vfio/common.o
>   CC      moxie-softmmu/hw/vfio/platform.o
>   CC      moxie-softmmu/hw/vfio/spapr.o
>   CC      moxie-softmmu/hw/moxie/moxiesim.o
>   CC      moxie-softmmu/target/moxie/translate.o
>   CC      moxie-softmmu/target/moxie/helper.o
>   CC      moxie-softmmu/target/moxie/machine.o
>   CC      moxie-softmmu/target/moxie/cpu.o
>   CC      moxie-softmmu/target/moxie/mmu.o
>   GEN     trace/generated-helpers.c
>   CC      moxie-softmmu/trace/control-target.o
>   CC      moxie-softmmu/trace/generated-helpers.o
>   LINK    moxie-softmmu/qemu-system-moxie
>   GEN     sparc-softmmu/hmp-commands.h
>   GEN     sparc-softmmu/hmp-commands-info.h
>   GEN     sparc-softmmu/config-target.h
>   CC      sparc-softmmu/exec.o
>   GEN     tricore-softmmu/hmp-commands.h
>   GEN     tricore-softmmu/hmp-commands-info.h
>   GEN     tricore-softmmu/config-target.h
>   CC      tricore-softmmu/exec.o
>   CC      tricore-softmmu/tcg/tcg.o
>   CC      tricore-softmmu/tcg/tcg-op.o
>   CC      tricore-softmmu/tcg/tcg-op-vec.o
>   CC      tricore-softmmu/tcg/tcg-op-gvec.o
>   CC      tricore-softmmu/tcg/tcg-common.o
>   CC      tricore-softmmu/tcg/optimize.o
>   CC      tricore-softmmu/fpu/softfloat.o
>   CC      tricore-softmmu/disas.o
>   CC      tricore-softmmu/arch_init.o
>   CC      tricore-softmmu/cpus.o
>   CC      tricore-softmmu/monitor.o
>   CC      tricore-softmmu/gdbstub.o
>   CC      tricore-softmmu/balloon.o
>   CC      tricore-softmmu/ioport.o
>   CC      tricore-softmmu/numa.o
>   CC      tricore-softmmu/qtest.o
>   CC      tricore-softmmu/memory.o
>   CC      tricore-softmmu/memory_mapping.o
>   CC      tricore-softmmu/dump.o
>   CC      tricore-softmmu/migration/ram.o
>   CC      tricore-softmmu/accel/accel.o
>   CC      tricore-softmmu/accel/stubs/hax-stub.o
>   CC      tricore-softmmu/accel/stubs/hvf-stub.o
>   CC      tricore-softmmu/accel/stubs/whpx-stub.o
>   CC      tricore-softmmu/accel/stubs/kvm-stub.o
>   CC      tricore-softmmu/accel/tcg/tcg-all.o
>   CC      tricore-softmmu/accel/tcg/cputlb.o
>   CC      tricore-softmmu/accel/tcg/tcg-runtime.o
>   CC      tricore-softmmu/accel/tcg/tcg-runtime-gvec.o
>   CC      tricore-softmmu/accel/tcg/cpu-exec.o
>   CC      tricore-softmmu/accel/tcg/cpu-exec-common.o
>   CC      tricore-softmmu/accel/tcg/translate-all.o
>   CC      tricore-softmmu/accel/tcg/translator.o
>   CC      tricore-softmmu/hw/core/generic-loader.o
>   CC      tricore-softmmu/hw/core/null-machine.o
>   CC      tricore-softmmu/hw/misc/mmio_interface.o
>   CC      tricore-softmmu/hw/net/vhost_net.o
>   CC      tricore-softmmu/hw/net/rocker/qmp-norocker.o
>   CC      tricore-softmmu/hw/vfio/common.o
>   CC      tricore-softmmu/hw/vfio/platform.o
>   CC      tricore-softmmu/hw/vfio/spapr.o
>   CC      tricore-softmmu/hw/tricore/tricore_testboard.o
>   CC      tricore-softmmu/target/tricore/translate.o
>   CC      tricore-softmmu/target/tricore/helper.o
>   CC      tricore-softmmu/target/tricore/cpu.o
>   CC      tricore-softmmu/target/tricore/op_helper.o
>   CC      tricore-softmmu/target/tricore/fpu_helper.o
>   GEN     trace/generated-helpers.c
>   CC      tricore-softmmu/trace/control-target.o
>   CC      tricore-softmmu/trace/generated-helpers.o
>   LINK    tricore-softmmu/qemu-system-tricore
>   CC      ppc64-softmmu/target/ppc/translate.o
>   GEN     unicore32-softmmu/hmp-commands.h
>   GEN     unicore32-softmmu/hmp-commands-info.h
>   GEN     unicore32-softmmu/config-target.h
>   CC      unicore32-softmmu/exec.o
>   CC      unicore32-softmmu/tcg/tcg.o
>   CC      unicore32-softmmu/tcg/tcg-op.o
>   CC      unicore32-softmmu/tcg/tcg-op-vec.o
>   CC      unicore32-softmmu/tcg/tcg-op-gvec.o
>   CC      unicore32-softmmu/tcg/tcg-common.o
>   CC      unicore32-softmmu/tcg/optimize.o
>   CC      unicore32-softmmu/fpu/softfloat.o
>   CC      unicore32-softmmu/disas.o
>   CC      unicore32-softmmu/arch_init.o
>   CC      unicore32-softmmu/cpus.o
>   CC      unicore32-softmmu/monitor.o
>   CC      ppc64-softmmu/target/ppc/machine.o
>   CC      ppc64-softmmu/target/ppc/mmu_helper.o
>   CC      unicore32-softmmu/gdbstub.o
>   CC      ppc64-softmmu/target/ppc/mmu-hash32.o
>   CC      unicore32-softmmu/balloon.o
>   CC      ppc64-softmmu/target/ppc/monitor.o
>   CC      unicore32-softmmu/ioport.o
>   CC      ppc64-softmmu/target/ppc/arch_dump.o
>   CC      unicore32-softmmu/numa.o
>   CC      ppc64-softmmu/target/ppc/mmu-hash64.o
>   CC      unicore32-softmmu/qtest.o
>   CC      ppc64-softmmu/target/ppc/mmu-book3s-v3.o
>   CC      unicore32-softmmu/memory.o
>   CC      ppc64-softmmu/target/ppc/compat.o
>   CC      ppc64-softmmu/target/ppc/mmu-radix64.o
>   CC      ppc64-softmmu/target/ppc/kvm-stub.o
>   CC      ppc64-softmmu/target/ppc/dfp_helper.o
>   CC      unicore32-softmmu/memory_mapping.o
>   CC      unicore32-softmmu/dump.o
>   CC      ppc64-softmmu/target/ppc/excp_helper.o
>   CC      unicore32-softmmu/migration/ram.o
>   CC      ppc64-softmmu/target/ppc/fpu_helper.o
>   CC      unicore32-softmmu/accel/accel.o
>   CC      unicore32-softmmu/accel/stubs/hax-stub.o
>   CC      unicore32-softmmu/accel/stubs/hvf-stub.o
>   CC      unicore32-softmmu/accel/stubs/whpx-stub.o
>   CC      unicore32-softmmu/accel/stubs/kvm-stub.o
>   CC      unicore32-softmmu/accel/tcg/tcg-all.o
>   CC      unicore32-softmmu/accel/tcg/cputlb.o
>   CC      ppc64-softmmu/target/ppc/int_helper.o
>   CC      unicore32-softmmu/accel/tcg/tcg-runtime.o
>   CC      unicore32-softmmu/accel/tcg/tcg-runtime-gvec.o
>   CC      ppc64-softmmu/target/ppc/timebase_helper.o
>   CC      ppc64-softmmu/target/ppc/misc_helper.o
>   CC      unicore32-softmmu/accel/tcg/cpu-exec.o
>   CC      ppc64-softmmu/target/ppc/mem_helper.o
>   CC      unicore32-softmmu/accel/tcg/cpu-exec-common.o
>   CC      unicore32-softmmu/accel/tcg/translate-all.o
>   CC      ppc64-softmmu/target/ppc/gdbstub.o
>   CC      unicore32-softmmu/accel/tcg/translator.o
>   CC      ppc64-softmmu/target/ppc/../../libdecnumber/decContext.o
>   CC      ppc64-softmmu/target/ppc/../../libdecnumber/decNumber.o
>   CC      unicore32-softmmu/hw/core/generic-loader.o
>   CC      unicore32-softmmu/hw/core/null-machine.o
>   CC      unicore32-softmmu/hw/misc/mmio_interface.o
>   CC      unicore32-softmmu/hw/net/vhost_net.o
>   CC      unicore32-softmmu/hw/net/rocker/qmp-norocker.o
>   CC      unicore32-softmmu/hw/vfio/common.o
>   CC      ppc64-softmmu/target/ppc/../../libdecnumber/dpd/decimal32.o
>   CC      unicore32-softmmu/hw/vfio/platform.o
>   CC      ppc64-softmmu/target/ppc/../../libdecnumber/dpd/decimal64.o
>   CC      ppc64-softmmu/target/ppc/../../libdecnumber/dpd/decimal128.o
>   CC      unicore32-softmmu/hw/vfio/spapr.o
>   GEN     trace/generated-helpers.c
>   CC      ppc64-softmmu/trace/control-target.o
>   CC      unicore32-softmmu/hw/unicore32/puv3.o
>   CC      ppc64-softmmu/gdbstub-xml.o
>   CC      ppc64-softmmu/trace/generated-helpers.o
>   CC      unicore32-softmmu/target/unicore32/translate.o
>   LINK    ppc64-softmmu/qemu-system-ppc64
>   CC      unicore32-softmmu/target/unicore32/op_helper.o
>   CC      unicore32-softmmu/target/unicore32/helper.o
>   CC      unicore32-softmmu/target/unicore32/cpu.o
>   GEN     x86_64-softmmu/hmp-commands.h
>   GEN     x86_64-softmmu/hmp-commands-info.h
>   GEN     x86_64-softmmu/config-target.h
>   CC      x86_64-softmmu/exec.o
>   CC      x86_64-softmmu/tcg/tcg.o
>   CC      x86_64-softmmu/tcg/tcg-op.o
>   CC      x86_64-softmmu/tcg/tcg-op-vec.o
>   CC      x86_64-softmmu/tcg/tcg-op-gvec.o
>   CC      x86_64-softmmu/tcg/tcg-common.o
>   CC      x86_64-softmmu/tcg/optimize.o
>   CC      x86_64-softmmu/fpu/softfloat.o
>   CC      x86_64-softmmu/disas.o
>   GEN     x86_64-softmmu/gdbstub-xml.c
>   CC      x86_64-softmmu/arch_init.o
>   CC      x86_64-softmmu/cpus.o
>   CC      x86_64-softmmu/monitor.o
>   CC      x86_64-softmmu/gdbstub.o
>   CC      x86_64-softmmu/balloon.o
>   CC      x86_64-softmmu/ioport.o
>   CC      x86_64-softmmu/numa.o
>   CC      x86_64-softmmu/qtest.o
>   CC      x86_64-softmmu/memory.o
>   CC      x86_64-softmmu/memory_mapping.o
>   CC      x86_64-softmmu/dump.o
>   CC      x86_64-softmmu/migration/ram.o
>   CC      x86_64-softmmu/accel/accel.o
>   CC      x86_64-softmmu/accel/stubs/hax-stub.o
>   CC      x86_64-softmmu/accel/stubs/hvf-stub.o
>   CC      x86_64-softmmu/accel/stubs/whpx-stub.o
>   CC      x86_64-softmmu/accel/stubs/kvm-stub.o
>   CC      x86_64-softmmu/accel/tcg/tcg-all.o
>   CC      x86_64-softmmu/accel/tcg/cputlb.o
>   CC      x86_64-softmmu/accel/tcg/tcg-runtime.o
>   CC      x86_64-softmmu/accel/tcg/tcg-runtime-gvec.o
>   CC      x86_64-softmmu/accel/tcg/cpu-exec.o
>   CC      x86_64-softmmu/accel/tcg/cpu-exec-common.o
>   CC      x86_64-softmmu/accel/tcg/translate-all.o
>   CC      x86_64-softmmu/accel/tcg/translator.o
>   CC      x86_64-softmmu/hw/9pfs/virtio-9p-device.o
>   CC      x86_64-softmmu/hw/block/virtio-blk.o
>   CC      x86_64-softmmu/hw/block/vhost-user-blk.o
>   CC      x86_64-softmmu/hw/block/dataplane/virtio-blk.o
>   CC      x86_64-softmmu/hw/char/virtio-serial-bus.o
>   CC      x86_64-softmmu/hw/core/generic-loader.o
>   CC      x86_64-softmmu/hw/core/null-machine.o
>   CC      x86_64-softmmu/hw/display/vga.o
>   CC      x86_64-softmmu/hw/display/virtio-gpu.o
>   CC      x86_64-softmmu/hw/display/virtio-gpu-3d.o
>   CC      x86_64-softmmu/hw/display/virtio-gpu-pci.o
>   CC      x86_64-softmmu/hw/display/virtio-vga.o
>   CC      x86_64-softmmu/hw/intc/apic.o
>   CC      x86_64-softmmu/hw/intc/apic_common.o
>   CC      x86_64-softmmu/hw/intc/ioapic.o
>   CC      x86_64-softmmu/hw/isa/lpc_ich9.o
>   CC      x86_64-softmmu/hw/misc/ivshmem.o
>   CC      x86_64-softmmu/hw/misc/pvpanic.o
>   CC      x86_64-softmmu/hw/misc/mmio_interface.o
>   CC      x86_64-softmmu/hw/net/virtio-net.o
>   CC      x86_64-softmmu/hw/net/vhost_net.o
>   CC      x86_64-softmmu/hw/scsi/virtio-scsi.o
>   CC      x86_64-softmmu/hw/scsi/virtio-scsi-dataplane.o
>   CC      x86_64-softmmu/hw/scsi/vhost-scsi-common.o
>   CC      x86_64-softmmu/hw/scsi/vhost-scsi.o
>   CC      x86_64-softmmu/hw/scsi/vhost-user-scsi.o
>   CC      x86_64-softmmu/hw/timer/mc146818rtc.o
>   CC      x86_64-softmmu/hw/vfio/common.o
>   CC      x86_64-softmmu/hw/vfio/pci.o
>   CC      x86_64-softmmu/hw/vfio/pci-quirks.o
>   CC      x86_64-softmmu/hw/vfio/display.o
>   CC      x86_64-softmmu/hw/vfio/platform.o
>   CC      x86_64-softmmu/hw/vfio/spapr.o
>   CC      x86_64-softmmu/hw/virtio/virtio.o
>   CC      x86_64-softmmu/hw/virtio/virtio-balloon.o
>   CC      x86_64-softmmu/hw/virtio/virtio-crypto.o
>   CC      x86_64-softmmu/hw/virtio/virtio-crypto-pci.o
>   CC      x86_64-softmmu/hw/virtio/vhost.o
>   CC      x86_64-softmmu/hw/virtio/vhost-backend.o
>   CC      x86_64-softmmu/hw/virtio/vhost-user.o
>   CC      x86_64-softmmu/hw/virtio/vhost-vsock.o
>   CC      x86_64-softmmu/hw/i386/multiboot.o
>   CC      x86_64-softmmu/hw/i386/pc.o
>   CC      x86_64-softmmu/hw/i386/pc_piix.o
>   CC      x86_64-softmmu/hw/i386/pc_q35.o
>   CC      x86_64-softmmu/hw/i386/pc_sysfw.o
>   CC      x86_64-softmmu/hw/i386/x86-iommu.o
>   CC      x86_64-softmmu/hw/i386/intel_iommu.o
>   CC      x86_64-softmmu/hw/i386/amd_iommu.o
>   CC      x86_64-softmmu/hw/i386/vmport.o
>   CC      x86_64-softmmu/hw/i386/vmmouse.o
>   CC      x86_64-softmmu/hw/i386/kvmvapic.o
>   CC      x86_64-softmmu/hw/i386/acpi-build.o
>   CC      x86_64-softmmu/target/i386/helper.o
>   CC      x86_64-softmmu/target/i386/cpu.o
>   CC      x86_64-softmmu/target/i386/gdbstub.o
>   CC      x86_64-softmmu/target/i386/xsave_helper.o
>   CC      x86_64-softmmu/target/i386/translate.o
>   CC      x86_64-softmmu/target/i386/bpt_helper.o
>   CC      x86_64-softmmu/target/i386/cc_helper.o
>   CC      x86_64-softmmu/target/i386/excp_helper.o
>   CC      x86_64-softmmu/target/i386/fpu_helper.o
>   CC      x86_64-softmmu/target/i386/int_helper.o
>   CC      x86_64-softmmu/target/i386/mem_helper.o
>   CC      x86_64-softmmu/target/i386/misc_helper.o
>   CC      x86_64-softmmu/target/i386/mpx_helper.o
>   CC      x86_64-softmmu/target/i386/seg_helper.o
>   CC      x86_64-softmmu/target/i386/smm_helper.o
>   CC      x86_64-softmmu/target/i386/svm_helper.o
>   CC      x86_64-softmmu/target/i386/machine.o
>   CC      x86_64-softmmu/target/i386/arch_memory_mapping.o
>   CC      x86_64-softmmu/target/i386/arch_dump.o
>   CC      x86_64-softmmu/target/i386/monitor.o
>   CC      x86_64-softmmu/target/i386/kvm-stub.o
>   CC      x86_64-softmmu/target/i386/sev-stub.o
>   GEN     trace/generated-helpers.c
>   CC      x86_64-softmmu/trace/control-target.o
>   CC      x86_64-softmmu/gdbstub-xml.o
>   CC      x86_64-softmmu/trace/generated-helpers.o
>   LINK    x86_64-softmmu/qemu-system-x86_64
>   CC      unicore32-softmmu/target/unicore32/ucf64_helper.o
>   CC      unicore32-softmmu/target/unicore32/softmmu.o
>   GEN     xtensaeb-softmmu/hmp-commands.h
>   GEN     xtensaeb-softmmu/hmp-commands-info.h
>   GEN     xtensaeb-softmmu/config-target.h
>   CC      xtensaeb-softmmu/exec.o
>   GEN     trace/generated-helpers.c
>   CC      unicore32-softmmu/trace/control-target.o
>   CC      unicore32-softmmu/trace/generated-helpers.o
>   LINK    unicore32-softmmu/qemu-system-unicore32
>   CC      xtensaeb-softmmu/tcg/tcg.o
>   CC      xtensaeb-softmmu/tcg/tcg-op.o
>   CC      xtensaeb-softmmu/tcg/tcg-op-vec.o
>   CC      xtensaeb-softmmu/tcg/tcg-op-gvec.o
>   CC      xtensaeb-softmmu/tcg/tcg-common.o
>   CC      sparc-softmmu/tcg/tcg.o
>   CC      mips-softmmu/hw/net/vhost_net.o
>   CC      sparc-softmmu/tcg/tcg-op.o
>   CC      mips-softmmu/hw/scsi/virtio-scsi.o
>   CC      mips-softmmu/hw/scsi/virtio-scsi-dataplane.o
>   CC      mips-softmmu/hw/scsi/vhost-scsi-common.o
>   GEN     xtensa-softmmu/hmp-commands.h
>   GEN     xtensa-softmmu/hmp-commands-info.h
>   GEN     xtensa-softmmu/config-target.h
>   CC      xtensa-softmmu/exec.o
>   CC      xtensa-softmmu/tcg/tcg.o
>   CC      xtensa-softmmu/tcg/tcg-op.o
>   CC      xtensa-softmmu/tcg/tcg-op-vec.o
>   CC      xtensa-softmmu/tcg/tcg-op-gvec.o
>   CC      xtensa-softmmu/tcg/tcg-common.o
>   CC      xtensa-softmmu/tcg/optimize.o
>   CC      xtensa-softmmu/fpu/softfloat.o
>   CC      xtensa-softmmu/disas.o
>   CC      xtensa-softmmu/arch_init.o
>   CC      xtensa-softmmu/cpus.o
>   CC      xtensa-softmmu/monitor.o
>   CC      xtensa-softmmu/gdbstub.o
>   CC      xtensa-softmmu/balloon.o
>   CC      xtensa-softmmu/ioport.o
>   CC      xtensa-softmmu/numa.o
>   CC      xtensa-softmmu/qtest.o
>   CC      xtensa-softmmu/memory.o
>   CC      xtensa-softmmu/memory_mapping.o
>   CC      xtensa-softmmu/dump.o
>   CC      xtensa-softmmu/migration/ram.o
>   CC      xtensa-softmmu/accel/accel.o
>   CC      xtensa-softmmu/accel/stubs/hax-stub.o
>   CC      xtensa-softmmu/accel/stubs/hvf-stub.o
>   CC      xtensa-softmmu/accel/stubs/whpx-stub.o
>   CC      xtensa-softmmu/accel/stubs/kvm-stub.o
>   CC      xtensa-softmmu/accel/tcg/tcg-all.o
>   CC      xtensa-softmmu/accel/tcg/cputlb.o
>   CC      xtensa-softmmu/accel/tcg/tcg-runtime.o
>   CC      xtensa-softmmu/accel/tcg/tcg-runtime-gvec.o
>   CC      xtensa-softmmu/accel/tcg/cpu-exec.o
>   CC      xtensa-softmmu/accel/tcg/cpu-exec-common.o
>   CC      xtensa-softmmu/accel/tcg/translate-all.o
>   CC      xtensa-softmmu/accel/tcg/translator.o
>   CC      xtensa-softmmu/hw/core/generic-loader.o
>   CC      xtensa-softmmu/hw/core/null-machine.o
>   CC      xtensa-softmmu/hw/misc/mmio_interface.o
>   CC      xtensa-softmmu/hw/net/vhost_net.o
>   CC      xtensa-softmmu/hw/net/rocker/qmp-norocker.o
>   CC      xtensa-softmmu/hw/vfio/common.o
>   CC      xtensa-softmmu/hw/vfio/platform.o
>   CC      xtensa-softmmu/hw/vfio/spapr.o
>   CC      xtensa-softmmu/hw/xtensa/pic_cpu.o
>   CC      xtensa-softmmu/hw/xtensa/sim.o
>   CC      xtensa-softmmu/hw/xtensa/xtensa_memory.o
>   CC      xtensa-softmmu/hw/xtensa/xtfpga.o
>   CC      xtensa-softmmu/target/xtensa/core-dc232b.o
>   CC      xtensa-softmmu/target/xtensa/core-dc233c.o
>   CC      xtensa-softmmu/target/xtensa/core-de212.o
>   CC      xtensa-softmmu/target/xtensa/core-fsf.o
>   CC      xtensa-softmmu/target/xtensa/core-sample_controller.o
>   CC      xtensa-softmmu/target/xtensa/monitor.o
>   CC      xtensa-softmmu/target/xtensa/xtensa-semi.o
>   CC      xtensa-softmmu/target/xtensa/xtensa-isa.o
>   CC      xtensa-softmmu/target/xtensa/translate.o
>   CC      xtensa-softmmu/target/xtensa/op_helper.o
>   CC      xtensa-softmmu/target/xtensa/helper.o
>   CC      xtensa-softmmu/target/xtensa/cpu.o
>   CC      xtensa-softmmu/target/xtensa/gdbstub.o
>   GEN     trace/generated-helpers.c
>   CC      xtensa-softmmu/trace/control-target.o
>   CC      xtensa-softmmu/trace/generated-helpers.o
>   LINK    xtensa-softmmu/qemu-system-xtensa
>   CC      sparc-softmmu/tcg/tcg-op-vec.o
>   CC      mips-softmmu/hw/scsi/vhost-scsi.o
>   CC      sparc-softmmu/tcg/tcg-op-gvec.o
>   CC      mips-softmmu/hw/scsi/vhost-user-scsi.o
>   CC      mips-softmmu/hw/timer/mips_gictimer.o
>   CC      sparc-softmmu/tcg/tcg-common.o
>   CC      xtensaeb-softmmu/tcg/optimize.o
>   GEN     aarch64_be-linux-user/config-target.h
>   CC      aarch64_be-linux-user/exec.o
>   CC      aarch64_be-linux-user/tcg/tcg.o
>   CC      xtensaeb-softmmu/fpu/softfloat.o
>   CC      aarch64_be-linux-user/tcg/tcg-op.o
>   CC      xtensaeb-softmmu/disas.o
>   CC      xtensaeb-softmmu/arch_init.o
>   CC      xtensaeb-softmmu/cpus.o
>   CC      aarch64_be-linux-user/tcg/tcg-op-vec.o
>   CC      xtensaeb-softmmu/monitor.o
>   CC      aarch64_be-linux-user/tcg/tcg-op-gvec.o
>   CC      xtensaeb-softmmu/gdbstub.o
>   CC      xtensaeb-softmmu/balloon.o
>   CC      xtensaeb-softmmu/ioport.o
>   CC      aarch64_be-linux-user/tcg/tcg-common.o
>   CC      aarch64_be-linux-user/tcg/optimize.o
>   CC      xtensaeb-softmmu/numa.o
>   CC      xtensaeb-softmmu/qtest.o
>   CC      xtensaeb-softmmu/memory.o
>   CC      aarch64_be-linux-user/fpu/softfloat.o
>   CC      xtensaeb-softmmu/memory_mapping.o
>   CC      xtensaeb-softmmu/dump.o
>   CC      xtensaeb-softmmu/migration/ram.o
>   CC      xtensaeb-softmmu/accel/accel.o
>   CC      xtensaeb-softmmu/accel/stubs/hax-stub.o
>   CC      xtensaeb-softmmu/accel/stubs/hvf-stub.o
>   CC      xtensaeb-softmmu/accel/stubs/whpx-stub.o
>   CC      xtensaeb-softmmu/accel/stubs/kvm-stub.o
>   CC      aarch64_be-linux-user/disas.o
>   CC      xtensaeb-softmmu/accel/tcg/tcg-all.o
>   GEN     aarch64_be-linux-user/gdbstub-xml.c
>   CC      xtensaeb-softmmu/accel/tcg/cputlb.o
>   CC      aarch64_be-linux-user/gdbstub.o
>   CC      aarch64_be-linux-user/thunk.o
>   CC      aarch64_be-linux-user/accel/stubs/hax-stub.o
>   CC      aarch64_be-linux-user/accel/stubs/hvf-stub.o
>   CC      aarch64_be-linux-user/accel/stubs/whpx-stub.o
>   CC      aarch64_be-linux-user/accel/stubs/kvm-stub.o
>   CC      aarch64_be-linux-user/accel/tcg/tcg-runtime.o
>   CC      aarch64_be-linux-user/accel/tcg/tcg-runtime-gvec.o
>   CC      xtensaeb-softmmu/accel/tcg/tcg-runtime.o
>   CC      xtensaeb-softmmu/accel/tcg/tcg-runtime-gvec.o
>   CC      aarch64_be-linux-user/accel/tcg/cpu-exec.o
>   CC      aarch64_be-linux-user/accel/tcg/cpu-exec-common.o
>   CC      aarch64_be-linux-user/accel/tcg/translate-all.o
>   CC      xtensaeb-softmmu/accel/tcg/cpu-exec.o
>   CC      aarch64_be-linux-user/accel/tcg/translator.o
>   CC      xtensaeb-softmmu/accel/tcg/cpu-exec-common.o
>   CC      xtensaeb-softmmu/accel/tcg/translate-all.o
>   CC      xtensaeb-softmmu/accel/tcg/translator.o
>   CC      aarch64_be-linux-user/accel/tcg/user-exec.o
>   CC      xtensaeb-softmmu/hw/core/generic-loader.o
>   CC      xtensaeb-softmmu/hw/core/null-machine.o
>   CC      xtensaeb-softmmu/hw/misc/mmio_interface.o
>   CC      xtensaeb-softmmu/hw/net/vhost_net.o
>   CC      aarch64_be-linux-user/accel/tcg/user-exec-stub.o
>   CC      xtensaeb-softmmu/hw/net/rocker/qmp-norocker.o
>   CC      aarch64_be-linux-user/linux-user/main.o
>   CC      xtensaeb-softmmu/hw/vfio/common.o
>   CC      aarch64_be-linux-user/linux-user/syscall.o
>   CC      xtensaeb-softmmu/hw/vfio/platform.o
>   CC      xtensaeb-softmmu/hw/vfio/spapr.o
>   CC      xtensaeb-softmmu/hw/xtensa/pic_cpu.o
>   CC      xtensaeb-softmmu/hw/xtensa/sim.o
>   CC      xtensaeb-softmmu/hw/xtensa/xtensa_memory.o
>   CC      xtensaeb-softmmu/hw/xtensa/xtfpga.o
>   CC      xtensaeb-softmmu/target/xtensa/core-dc232b.o
>   CC      aarch64_be-linux-user/linux-user/strace.o
>   CC      xtensaeb-softmmu/target/xtensa/core-dc233c.o
>   CC      aarch64_be-linux-user/linux-user/mmap.o
>   CC      aarch64_be-linux-user/linux-user/signal.o
>   CC      aarch64_be-linux-user/linux-user/elfload.o
>   CC      xtensaeb-softmmu/target/xtensa/core-de212.o
>   CC      aarch64_be-linux-user/linux-user/linuxload.o
>   CC      aarch64_be-linux-user/linux-user/uaccess.o
>   CC      aarch64_be-linux-user/linux-user/uname.o
>   CC      xtensaeb-softmmu/target/xtensa/core-fsf.o
>   CCAS    aarch64_be-linux-user/linux-user/safe-syscall.o
>   CC      aarch64_be-linux-user/linux-user/aarch64/signal.o
>   CC      aarch64_be-linux-user/linux-user/aarch64/cpu_loop.o
>   CC      aarch64_be-linux-user/linux-user/flatload.o
>   CC      xtensaeb-softmmu/target/xtensa/core-sample_controller.o
>   CC      aarch64_be-linux-user/target/arm/arm-semi.o
>   CC      aarch64_be-linux-user/target/arm/kvm-stub.o
>   CC      xtensaeb-softmmu/target/xtensa/monitor.o
>   CC      aarch64_be-linux-user/target/arm/translate.o
>   CC      xtensaeb-softmmu/target/xtensa/xtensa-semi.o
>   CC      xtensaeb-softmmu/target/xtensa/xtensa-isa.o
>   CC      xtensaeb-softmmu/target/xtensa/translate.o
>   CC      xtensaeb-softmmu/target/xtensa/op_helper.o
>   CC      xtensaeb-softmmu/target/xtensa/helper.o
>   CC      xtensaeb-softmmu/target/xtensa/cpu.o
>   CC      xtensaeb-softmmu/target/xtensa/gdbstub.o
>   GEN     trace/generated-helpers.c
>   CC      xtensaeb-softmmu/trace/control-target.o
>   CC      xtensaeb-softmmu/trace/generated-helpers.o
>   LINK    xtensaeb-softmmu/qemu-system-xtensaeb
>   CC      sparc-softmmu/tcg/optimize.o
>   GEN     aarch64-linux-user/config-target.h
>   CC      aarch64-linux-user/exec.o
>   CC      aarch64-linux-user/tcg/tcg.o
>   CC      sparc-softmmu/fpu/softfloat.o
>   CC      aarch64_be-linux-user/target/arm/op_helper.o
>   CC      aarch64_be-linux-user/target/arm/helper.o
>   CC      aarch64-linux-user/tcg/tcg-op.o
>   CC      aarch64_be-linux-user/target/arm/cpu.o
>   CC      aarch64_be-linux-user/target/arm/neon_helper.o
>   CC      sparc-softmmu/disas.o
>   CC      sparc-softmmu/arch_init.o
>   CC      sparc-softmmu/cpus.o
>   CC      aarch64-linux-user/tcg/tcg-op-vec.o
>   CC      aarch64_be-linux-user/target/arm/iwmmxt_helper.o
>   CC      sparc-softmmu/monitor.o
>   CC      aarch64-linux-user/tcg/tcg-op-gvec.o
>   CC      aarch64_be-linux-user/target/arm/vec_helper.o
>   CC      aarch64_be-linux-user/target/arm/gdbstub.o
>   CC      aarch64_be-linux-user/target/arm/cpu64.o
>   CC      aarch64_be-linux-user/target/arm/translate-a64.o
>   CC      sparc-softmmu/gdbstub.o
>   CC      aarch64-linux-user/tcg/tcg-common.o
>   CC      sparc-softmmu/balloon.o
>   CC      aarch64-linux-user/tcg/optimize.o
>   CC      sparc-softmmu/ioport.o
>   CC      sparc-softmmu/numa.o
>   CC      sparc-softmmu/qtest.o
>   CC      sparc-softmmu/memory.o
>   CC      aarch64-linux-user/fpu/softfloat.o
>   CC      sparc-softmmu/memory_mapping.o
>   CC      sparc-softmmu/dump.o
>   CC      sparc-softmmu/migration/ram.o
>   CC      sparc-softmmu/accel/accel.o
>   CC      sparc-softmmu/accel/stubs/hax-stub.o
>   CC      sparc-softmmu/accel/stubs/hvf-stub.o
>   CC      aarch64_be-linux-user/target/arm/helper-a64.o
>   CC      sparc-softmmu/accel/stubs/whpx-stub.o
>   CC      aarch64-linux-user/disas.o
>   CC      sparc-softmmu/accel/stubs/kvm-stub.o
>   CC      aarch64_be-linux-user/target/arm/gdbstub64.o
>   GEN     aarch64-linux-user/gdbstub-xml.c
>   CC      sparc-softmmu/accel/tcg/tcg-all.o
>   CC      aarch64-linux-user/gdbstub.o
>   CC      aarch64_be-linux-user/target/arm/crypto_helper.o
>   CC      sparc-softmmu/accel/tcg/cputlb.o
>   GEN     aarch64_be-linux-user/target/arm/decode-sve.inc.c
>   CC      aarch64_be-linux-user/target/arm/sve_helper.o
>   CC      aarch64-linux-user/thunk.o
>   CC      aarch64-linux-user/accel/stubs/hax-stub.o
>   CC      aarch64-linux-user/accel/stubs/hvf-stub.o
>   CC      aarch64-linux-user/accel/stubs/whpx-stub.o
>   CC      aarch64-linux-user/accel/stubs/kvm-stub.o
>   CC      aarch64-linux-user/accel/tcg/tcg-runtime.o
>   CC      aarch64-linux-user/accel/tcg/tcg-runtime-gvec.o
>   CC      sparc-softmmu/accel/tcg/tcg-runtime.o
>   CC      sparc-softmmu/accel/tcg/tcg-runtime-gvec.o
>   CC      aarch64-linux-user/accel/tcg/cpu-exec.o
>   CC      aarch64-linux-user/accel/tcg/cpu-exec-common.o
>   CC      aarch64-linux-user/accel/tcg/translate-all.o
>   GEN     trace/generated-helpers.c
>   CC      aarch64_be-linux-user/trace/control-target.o
>   CC      sparc-softmmu/accel/tcg/cpu-exec.o
>   CC      aarch64_be-linux-user/gdbstub-xml.o
>   CC      aarch64_be-linux-user/target/arm/translate-sve.o
>   CC      aarch64-linux-user/accel/tcg/translator.o
>   CC      sparc-softmmu/accel/tcg/cpu-exec-common.o
>   CC      sparc-softmmu/accel/tcg/translate-all.o
>   CC      aarch64-linux-user/accel/tcg/user-exec.o
>   CC      sparc-softmmu/accel/tcg/translator.o
>   CC      sparc-softmmu/hw/core/generic-loader.o
>   CC      sparc-softmmu/hw/core/null-machine.o
>   CC      sparc-softmmu/hw/display/tcx.o
>   CC      aarch64-linux-user/accel/tcg/user-exec-stub.o
>   CC      aarch64-linux-user/linux-user/main.o
>   CC      sparc-softmmu/hw/display/cg3.o
>   CC      aarch64-linux-user/linux-user/syscall.o
>   CC      sparc-softmmu/hw/intc/grlib_irqmp.o
>   CC      sparc-softmmu/hw/misc/eccmemctl.o
>   CC      sparc-softmmu/hw/misc/slavio_misc.o
>   CC      sparc-softmmu/hw/misc/mmio_interface.o
>   CC      sparc-softmmu/hw/net/vhost_net.o
>   CC      sparc-softmmu/hw/net/rocker/qmp-norocker.o
>   CC      sparc-softmmu/hw/vfio/common.o
>   CC      sparc-softmmu/hw/vfio/platform.o
>   CC      aarch64_be-linux-user/trace/generated-helpers.o
>   CC      sparc-softmmu/hw/vfio/spapr.o
>   LINK    aarch64_be-linux-user/qemu-aarch64_be
>   CC      aarch64-linux-user/linux-user/strace.o
>   CC      sparc-softmmu/hw/sparc/sun4m_iommu.o
>   CC      sparc-softmmu/hw/sparc/sun4m.o
>   CC      sparc-softmmu/hw/sparc/leon3.o
>   CC      sparc-softmmu/target/sparc/machine.o
>   CC      sparc-softmmu/target/sparc/monitor.o
>   CC      aarch64-linux-user/linux-user/mmap.o
>   CC      mips-softmmu/hw/timer/mc146818rtc.o
>   CC      mips-softmmu/hw/vfio/common.o
>   CC      sparc-softmmu/target/sparc/translate.o
>   CC      mips-softmmu/hw/vfio/pci.o
>   CC      mips-softmmu/hw/vfio/pci-quirks.o
>   CC      mips-softmmu/hw/vfio/display.o
>   CC      mips-softmmu/hw/vfio/platform.o
>   CC      mips-softmmu/hw/vfio/spapr.o
>   CC      mips-softmmu/hw/virtio/virtio.o
>   CC      mips-softmmu/hw/virtio/virtio-balloon.o
>   CC      mips-softmmu/hw/virtio/virtio-crypto.o
>   CC      mips-softmmu/hw/virtio/virtio-crypto-pci.o
>   CC      mips-softmmu/hw/virtio/vhost.o
>   CC      mips-softmmu/hw/virtio/vhost-backend.o
>   CC      mips-softmmu/hw/virtio/vhost-user.o
>   CC      mips-softmmu/hw/virtio/vhost-vsock.o
>   CC      mips-softmmu/hw/mips/mips_r4k.o
>   CC      mips-softmmu/hw/mips/mips_malta.o
>   CC      mips-softmmu/hw/mips/mips_mipssim.o
>   CC      mips-softmmu/hw/mips/addr.o
>   CC      mips-softmmu/hw/mips/mips_int.o
>   CC      mips-softmmu/hw/mips/gt64xxx_pci.o
>   CC      mips-softmmu/hw/mips/cps.o
>   CC      mips-softmmu/target/mips/translate.o
>   CC      mips-softmmu/target/mips/dsp_helper.o
>   CC      mips-softmmu/target/mips/op_helper.o
>   CC      mips-softmmu/target/mips/lmi_helper.o
>   CC      mips-softmmu/target/mips/helper.o
>   CC      mips-softmmu/target/mips/cpu.o
>   CC      mips-softmmu/target/mips/gdbstub.o
>   CC      mips-softmmu/target/mips/msa_helper.o
>   CC      mips-softmmu/target/mips/mips-semi.o
>   CC      mips-softmmu/target/mips/machine.o
>   CC      mips-softmmu/target/mips/cp0_timer.o
>   GEN     trace/generated-helpers.c
>   CC      mips-softmmu/trace/control-target.o
>   CC      sparc-softmmu/target/sparc/helper.o
>   CC      sparc-softmmu/target/sparc/cpu.o
>   CC      mips-softmmu/trace/generated-helpers.o
>   CC      sparc-softmmu/target/sparc/fop_helper.o
>   CC      sparc-softmmu/target/sparc/cc_helper.o
>   LINK    mips-softmmu/qemu-system-mips
>   CC      sparc-softmmu/target/sparc/win_helper.o
>   CC      sparc-softmmu/target/sparc/mmu_helper.o
>   CC      sparc-softmmu/target/sparc/ldst_helper.o
>   CC      sparc-softmmu/target/sparc/int32_helper.o
>   CC      sparc-softmmu/target/sparc/gdbstub.o
>   GEN     trace/generated-helpers.c
>   CC      sparc-softmmu/trace/control-target.o
>   CC      sparc-softmmu/trace/generated-helpers.o
>   CC      aarch64-linux-user/linux-user/signal.o
>   CC      aarch64-linux-user/linux-user/elfload.o
>   LINK    sparc-softmmu/qemu-system-sparc
>   CC      aarch64-linux-user/linux-user/linuxload.o
>   CC      aarch64-linux-user/linux-user/uaccess.o
>   CC      aarch64-linux-user/linux-user/uname.o
>   CCAS    aarch64-linux-user/linux-user/safe-syscall.o
>   CC      aarch64-linux-user/linux-user/aarch64/signal.o
>   CC      aarch64-linux-user/linux-user/aarch64/cpu_loop.o
>   CC      aarch64-linux-user/linux-user/flatload.o
>   CC      aarch64-linux-user/target/arm/arm-semi.o
>   CC      aarch64-linux-user/target/arm/kvm-stub.o
>   CC      aarch64-linux-user/target/arm/translate.o
>   CC      aarch64-linux-user/target/arm/op_helper.o
>   CC      aarch64-linux-user/target/arm/helper.o
>   CC      aarch64-linux-user/target/arm/cpu.o
>   CC      aarch64-linux-user/target/arm/neon_helper.o
>   CC      aarch64-linux-user/target/arm/iwmmxt_helper.o
>   CC      aarch64-linux-user/target/arm/vec_helper.o
>   CC      aarch64-linux-user/target/arm/gdbstub.o
>   CC      aarch64-linux-user/target/arm/cpu64.o
>   CC      aarch64-linux-user/target/arm/translate-a64.o
>   CC      aarch64-linux-user/target/arm/helper-a64.o
>   CC      aarch64-linux-user/target/arm/gdbstub64.o
>   CC      aarch64-linux-user/target/arm/crypto_helper.o
>   GEN     aarch64-linux-user/target/arm/decode-sve.inc.c
>   CC      aarch64-linux-user/target/arm/sve_helper.o
>   GEN     trace/generated-helpers.c
>   CC      aarch64-linux-user/trace/control-target.o
>   GEN     alpha-linux-user/config-target.h
>   GEN     armeb-linux-user/config-target.h
>   CC      armeb-linux-user/exec.o
>   CC      alpha-linux-user/exec.o
>   GEN     arm-linux-user/config-target.h
>   CC      alpha-linux-user/tcg/tcg.o
>   CC      arm-linux-user/exec.o
>   CC      aarch64-linux-user/gdbstub-xml.o
>   CC      arm-linux-user/tcg/tcg.o
>   CC      aarch64-linux-user/target/arm/translate-sve.o
>   CC      alpha-linux-user/tcg/tcg-op.o
>   CC      arm-linux-user/tcg/tcg-op.o
>   CC      alpha-linux-user/tcg/tcg-op-vec.o
>   CC      alpha-linux-user/tcg/tcg-op-gvec.o
>   CC      arm-linux-user/tcg/tcg-op-vec.o
>   CC      arm-linux-user/tcg/tcg-op-gvec.o
>   CC      aarch64-linux-user/trace/generated-helpers.o
>   LINK    aarch64-linux-user/qemu-aarch64
>   CC      alpha-linux-user/tcg/tcg-common.o
>   CC      alpha-linux-user/tcg/optimize.o
>   GEN     cris-linux-user/config-target.h
>   CC      cris-linux-user/exec.o
>   CC      cris-linux-user/tcg/tcg.o
>   CC      alpha-linux-user/fpu/softfloat.o
>   CC      cris-linux-user/tcg/tcg-op.o
>   CC      cris-linux-user/tcg/tcg-op-vec.o
>   CC      alpha-linux-user/disas.o
>   CC      cris-linux-user/tcg/tcg-op-gvec.o
>   CC      alpha-linux-user/gdbstub.o
>   CC      alpha-linux-user/thunk.o
>   CC      alpha-linux-user/accel/stubs/hax-stub.o
>   CC      alpha-linux-user/accel/stubs/hvf-stub.o
>   CC      alpha-linux-user/accel/stubs/whpx-stub.o
>   CC      cris-linux-user/tcg/tcg-common.o
>   CC      alpha-linux-user/accel/stubs/kvm-stub.o
>   CC      cris-linux-user/tcg/optimize.o
>   CC      alpha-linux-user/accel/tcg/tcg-runtime.o
>   CC      alpha-linux-user/accel/tcg/tcg-runtime-gvec.o
>   CC      cris-linux-user/fpu/softfloat.o
>   CC      alpha-linux-user/accel/tcg/cpu-exec.o
>   CC      alpha-linux-user/accel/tcg/cpu-exec-common.o
>   CC      alpha-linux-user/accel/tcg/translate-all.o
>   CC      alpha-linux-user/accel/tcg/translator.o
>   CC      alpha-linux-user/accel/tcg/user-exec.o
>   CC      alpha-linux-user/accel/tcg/user-exec-stub.o
>   CC      alpha-linux-user/linux-user/main.o
>   CC      alpha-linux-user/linux-user/syscall.o
>   CC      cris-linux-user/disas.o
>   CC      cris-linux-user/gdbstub.o
>   CC      cris-linux-user/thunk.o
>   CC      cris-linux-user/accel/stubs/hax-stub.o
>   CC      cris-linux-user/accel/stubs/hvf-stub.o
>   CC      cris-linux-user/accel/stubs/whpx-stub.o
>   CC      cris-linux-user/accel/stubs/kvm-stub.o
>   CC      cris-linux-user/accel/tcg/tcg-runtime.o
>   CC      cris-linux-user/accel/tcg/tcg-runtime-gvec.o
>   CC      cris-linux-user/accel/tcg/cpu-exec.o
>   CC      alpha-linux-user/linux-user/strace.o
>   CC      cris-linux-user/accel/tcg/cpu-exec-common.o
>   CC      cris-linux-user/accel/tcg/translate-all.o
>   CC      alpha-linux-user/linux-user/mmap.o
>   CC      cris-linux-user/accel/tcg/translator.o
>   CC      alpha-linux-user/linux-user/signal.o
>   CC      cris-linux-user/accel/tcg/user-exec.o
>   CC      alpha-linux-user/linux-user/elfload.o
>   CC      alpha-linux-user/linux-user/linuxload.o
>   CC      cris-linux-user/accel/tcg/user-exec-stub.o
>   CC      alpha-linux-user/linux-user/uaccess.o
>   CC      cris-linux-user/linux-user/main.o
>   CC      alpha-linux-user/linux-user/uname.o
>   CCAS    alpha-linux-user/linux-user/safe-syscall.o
>   CC      alpha-linux-user/linux-user/alpha/signal.o
>   CC      cris-linux-user/linux-user/syscall.o
>   CC      alpha-linux-user/linux-user/alpha/cpu_loop.o
>   CC      alpha-linux-user/target/alpha/translate.o
>   CC      alpha-linux-user/target/alpha/helper.o
>   CC      alpha-linux-user/target/alpha/cpu.o
>   CC      alpha-linux-user/target/alpha/int_helper.o
>   CC      alpha-linux-user/target/alpha/fpu_helper.o
>   CC      alpha-linux-user/target/alpha/vax_helper.o
>   CC      alpha-linux-user/target/alpha/sys_helper.o
>   CC      alpha-linux-user/target/alpha/mem_helper.o
>   CC      alpha-linux-user/target/alpha/gdbstub.o
>   GEN     trace/generated-helpers.c
>   CC      alpha-linux-user/trace/control-target.o
>   CC      alpha-linux-user/trace/generated-helpers.o
>   CC      cris-linux-user/linux-user/strace.o
>   LINK    alpha-linux-user/qemu-alpha
>   GEN     hppa-linux-user/config-target.h
>   CC      hppa-linux-user/exec.o
>   CC      cris-linux-user/linux-user/mmap.o
>   CC      hppa-linux-user/tcg/tcg.o
>   CC      cris-linux-user/linux-user/signal.o
>   CC      cris-linux-user/linux-user/elfload.o
>   CC      cris-linux-user/linux-user/linuxload.o
>   CC      cris-linux-user/linux-user/uaccess.o
>   CC      cris-linux-user/linux-user/uname.o
>   CC      hppa-linux-user/tcg/tcg-op.o
>   CCAS    cris-linux-user/linux-user/safe-syscall.o
>   CC      cris-linux-user/linux-user/cris/signal.o
>   CC      cris-linux-user/linux-user/cris/cpu_loop.o
>   CC      cris-linux-user/target/cris/translate.o
>   CC      hppa-linux-user/tcg/tcg-op-vec.o
>   CC      hppa-linux-user/tcg/tcg-op-gvec.o
>   CC      cris-linux-user/target/cris/op_helper.o
>   CC      cris-linux-user/target/cris/helper.o
>   CC      cris-linux-user/target/cris/cpu.o
>   CC      cris-linux-user/target/cris/gdbstub.o
>   GEN     trace/generated-helpers.c
>   CC      cris-linux-user/trace/control-target.o
>   CC      cris-linux-user/trace/generated-helpers.o
>   CC      hppa-linux-user/tcg/tcg-common.o
>   LINK    cris-linux-user/qemu-cris
>   CC      hppa-linux-user/tcg/optimize.o
>   CC      hppa-linux-user/fpu/softfloat.o
>   CC      armeb-linux-user/tcg/tcg.o
>   CC      hppa-linux-user/disas.o
>   GEN     i386-linux-user/config-target.h
>   CC      i386-linux-user/exec.o
>   CC      i386-linux-user/tcg/tcg.o
>   CC      armeb-linux-user/tcg/tcg-op.o
>   CC      i386-linux-user/tcg/tcg-op.o
>   CC      hppa-linux-user/gdbstub.o
>   CC      armeb-linux-user/tcg/tcg-op-vec.o
>   CC      hppa-linux-user/thunk.o
>   CC      hppa-linux-user/accel/stubs/hax-stub.o
>   CC      armeb-linux-user/tcg/tcg-op-gvec.o
>   CC      hppa-linux-user/accel/stubs/hvf-stub.o
>   CC      hppa-linux-user/accel/stubs/whpx-stub.o
>   CC      hppa-linux-user/accel/stubs/kvm-stub.o
>   CC      i386-linux-user/tcg/tcg-op-vec.o
>   CC      hppa-linux-user/accel/tcg/tcg-runtime.o
>   CC      hppa-linux-user/accel/tcg/tcg-runtime-gvec.o
>   CC      i386-linux-user/tcg/tcg-op-gvec.o
>   CC      armeb-linux-user/tcg/tcg-common.o
>   CC      hppa-linux-user/accel/tcg/cpu-exec.o
>   CC      armeb-linux-user/tcg/optimize.o
>   CC      hppa-linux-user/accel/tcg/cpu-exec-common.o
>   CC      hppa-linux-user/accel/tcg/translate-all.o
>   CC      armeb-linux-user/fpu/softfloat.o
>   CC      i386-linux-user/tcg/tcg-common.o
>   CC      hppa-linux-user/accel/tcg/translator.o
>   CC      i386-linux-user/tcg/optimize.o
>   CC      hppa-linux-user/accel/tcg/user-exec.o
>   CC      i386-linux-user/fpu/softfloat.o
>   CC      hppa-linux-user/accel/tcg/user-exec-stub.o
>   CC      hppa-linux-user/linux-user/main.o
>   CC      hppa-linux-user/linux-user/syscall.o
>   CC      armeb-linux-user/disas.o
>   GEN     armeb-linux-user/gdbstub-xml.c
>   CC      armeb-linux-user/gdbstub.o
>   CC      armeb-linux-user/thunk.o
>   CC      i386-linux-user/disas.o
>   CC      armeb-linux-user/accel/stubs/hax-stub.o
>   GEN     i386-linux-user/gdbstub-xml.c
>   CC      i386-linux-user/gdbstub.o
>   CC      armeb-linux-user/accel/stubs/hvf-stub.o
>   CC      armeb-linux-user/accel/stubs/whpx-stub.o
>   CC      armeb-linux-user/accel/stubs/kvm-stub.o
>   CC      hppa-linux-user/linux-user/strace.o
>   CC      armeb-linux-user/accel/tcg/tcg-runtime.o
>   CC      i386-linux-user/thunk.o
>   CC      armeb-linux-user/accel/tcg/tcg-runtime-gvec.o
>   CC      i386-linux-user/accel/stubs/hax-stub.o
>   CC      i386-linux-user/accel/stubs/hvf-stub.o
>   CC      hppa-linux-user/linux-user/mmap.o
>   CC      i386-linux-user/accel/stubs/whpx-stub.o
>   CC      i386-linux-user/accel/stubs/kvm-stub.o
>   CC      hppa-linux-user/linux-user/signal.o
>   CC      i386-linux-user/accel/tcg/tcg-runtime.o
>   CC      armeb-linux-user/accel/tcg/cpu-exec.o
>   CC      hppa-linux-user/linux-user/elfload.o
>   CC      i386-linux-user/accel/tcg/tcg-runtime-gvec.o
>   CC      armeb-linux-user/accel/tcg/cpu-exec-common.o
>   CC      armeb-linux-user/accel/tcg/translate-all.o
>   CC      hppa-linux-user/linux-user/linuxload.o
>   CC      hppa-linux-user/linux-user/uaccess.o
>   CC      hppa-linux-user/linux-user/uname.o
>   CC      i386-linux-user/accel/tcg/cpu-exec.o
>   CC      armeb-linux-user/accel/tcg/translator.o
>   CCAS    hppa-linux-user/linux-user/safe-syscall.o
>   CC      hppa-linux-user/linux-user/hppa/signal.o
>   CC      i386-linux-user/accel/tcg/cpu-exec-common.o
>   CC      hppa-linux-user/linux-user/hppa/cpu_loop.o
>   CC      i386-linux-user/accel/tcg/translate-all.o
>   CC      armeb-linux-user/accel/tcg/user-exec.o
>   CC      hppa-linux-user/target/hppa/translate.o
>   CC      i386-linux-user/accel/tcg/translator.o
>   CC      i386-linux-user/accel/tcg/user-exec.o
>   CC      armeb-linux-user/accel/tcg/user-exec-stub.o
>   CC      armeb-linux-user/linux-user/main.o
>   CC      armeb-linux-user/linux-user/syscall.o
>   CC      hppa-linux-user/target/hppa/helper.o
>   CC      i386-linux-user/accel/tcg/user-exec-stub.o
>   CC      hppa-linux-user/target/hppa/cpu.o
>   CC      i386-linux-user/linux-user/main.o
>   CC      hppa-linux-user/target/hppa/op_helper.o
>   CC      i386-linux-user/linux-user/syscall.o
>   CC      hppa-linux-user/target/hppa/gdbstub.o
>   CC      hppa-linux-user/target/hppa/mem_helper.o
>   CC      hppa-linux-user/target/hppa/int_helper.o
>   GEN     trace/generated-helpers.c
>   CC      hppa-linux-user/trace/control-target.o
>   CC      hppa-linux-user/trace/generated-helpers.o
>   LINK    hppa-linux-user/qemu-hppa
>   CC      arm-linux-user/tcg/tcg-common.o
>   GEN     m68k-linux-user/config-target.h
>   CC      arm-linux-user/tcg/optimize.o
>   CC      m68k-linux-user/exec.o
>   CC      m68k-linux-user/tcg/tcg.o
>   CC      arm-linux-user/fpu/softfloat.o
>   CC      armeb-linux-user/linux-user/strace.o
>   CC      armeb-linux-user/linux-user/mmap.o
>   CC      m68k-linux-user/tcg/tcg-op.o
>   CC      armeb-linux-user/linux-user/signal.o
>   CC      armeb-linux-user/linux-user/elfload.o
>   CC      armeb-linux-user/linux-user/linuxload.o
>   CC      armeb-linux-user/linux-user/uaccess.o
>   CC      m68k-linux-user/tcg/tcg-op-vec.o
>   CC      armeb-linux-user/linux-user/uname.o
>   CCAS    armeb-linux-user/linux-user/safe-syscall.o
>   CC      armeb-linux-user/linux-user/arm/signal.o
>   CC      m68k-linux-user/tcg/tcg-op-gvec.o
>   CC      armeb-linux-user/linux-user/arm/cpu_loop.o
>   CC      arm-linux-user/disas.o
>   CC      armeb-linux-user/linux-user/flatload.o
>   GEN     arm-linux-user/gdbstub-xml.c
>   CC      arm-linux-user/gdbstub.o
>   CC      armeb-linux-user/linux-user/arm/nwfpe/fpa11.o
>   CC      armeb-linux-user/linux-user/arm/nwfpe/fpa11_cpdo.o
>   CC      armeb-linux-user/linux-user/arm/nwfpe/fpa11_cpdt.o
>   CC      m68k-linux-user/tcg/tcg-common.o
>   CC      arm-linux-user/thunk.o
>   CC      m68k-linux-user/tcg/optimize.o
>   CC      armeb-linux-user/linux-user/arm/nwfpe/fpa11_cprt.o
>   CC      arm-linux-user/accel/stubs/hax-stub.o
>   CC      armeb-linux-user/linux-user/arm/nwfpe/fpopcode.o
>   CC      arm-linux-user/accel/stubs/hvf-stub.o
>   CC      armeb-linux-user/linux-user/arm/nwfpe/single_cpdo.o
>   CC      arm-linux-user/accel/stubs/whpx-stub.o
>   CC      m68k-linux-user/fpu/softfloat.o
>   CC      arm-linux-user/accel/stubs/kvm-stub.o
>   CC      armeb-linux-user/linux-user/arm/nwfpe/double_cpdo.o
>   CC      arm-linux-user/accel/tcg/tcg-runtime.o
>   CC      armeb-linux-user/linux-user/arm/nwfpe/extended_cpdo.o
>   CC      arm-linux-user/accel/tcg/tcg-runtime-gvec.o
>   CC      armeb-linux-user/target/arm/arm-semi.o
>   CC      armeb-linux-user/target/arm/kvm-stub.o
>   CC      armeb-linux-user/target/arm/translate.o
>   CC      arm-linux-user/accel/tcg/cpu-exec.o
>   CC      arm-linux-user/accel/tcg/cpu-exec-common.o
>   CC      arm-linux-user/accel/tcg/translate-all.o
>   CC      arm-linux-user/accel/tcg/translator.o
>   CC      arm-linux-user/accel/tcg/user-exec.o
>   CC      m68k-linux-user/disas.o
>   GEN     m68k-linux-user/gdbstub-xml.c
>   CC      m68k-linux-user/gdbstub.o
>   CC      arm-linux-user/accel/tcg/user-exec-stub.o
>   CC      arm-linux-user/linux-user/main.o
>   CC      m68k-linux-user/thunk.o
>   CC      arm-linux-user/linux-user/syscall.o
>   CC      m68k-linux-user/accel/stubs/hax-stub.o
>   CC      m68k-linux-user/accel/stubs/hvf-stub.o
>   CC      m68k-linux-user/accel/stubs/whpx-stub.o
>   CC      m68k-linux-user/accel/stubs/kvm-stub.o
>   CC      m68k-linux-user/accel/tcg/tcg-runtime.o
>   CC      m68k-linux-user/accel/tcg/tcg-runtime-gvec.o
>   CC      m68k-linux-user/accel/tcg/cpu-exec.o
>   CC      m68k-linux-user/accel/tcg/cpu-exec-common.o
>   CC      m68k-linux-user/accel/tcg/translate-all.o
>   CC      m68k-linux-user/accel/tcg/translator.o
>   CC      armeb-linux-user/target/arm/op_helper.o
>   CC      m68k-linux-user/accel/tcg/user-exec.o
>   CC      arm-linux-user/linux-user/strace.o
>   CC      armeb-linux-user/target/arm/helper.o
>   CC      m68k-linux-user/accel/tcg/user-exec-stub.o
>   CC      m68k-linux-user/linux-user/main.o
>   CC      arm-linux-user/linux-user/mmap.o
>   CC      m68k-linux-user/linux-user/syscall.o
>   CC      arm-linux-user/linux-user/signal.o
>   CC      arm-linux-user/linux-user/elfload.o
>   CC      armeb-linux-user/target/arm/cpu.o
>   CC      arm-linux-user/linux-user/linuxload.o
>   CC      arm-linux-user/linux-user/uaccess.o
>   CC      armeb-linux-user/target/arm/neon_helper.o
>   CC      arm-linux-user/linux-user/uname.o
>   CCAS    arm-linux-user/linux-user/safe-syscall.o
>   CC      arm-linux-user/linux-user/arm/signal.o
>   CC      arm-linux-user/linux-user/arm/cpu_loop.o
>   CC      armeb-linux-user/target/arm/iwmmxt_helper.o
>   CC      arm-linux-user/linux-user/flatload.o
>   CC      arm-linux-user/linux-user/arm/nwfpe/fpa11.o
>   CC      arm-linux-user/linux-user/arm/nwfpe/fpa11_cpdo.o
>   CC      arm-linux-user/linux-user/arm/nwfpe/fpa11_cpdt.o
>   CC      armeb-linux-user/target/arm/vec_helper.o
>   CC      m68k-linux-user/linux-user/strace.o
>   CC      arm-linux-user/linux-user/arm/nwfpe/fpa11_cprt.o
>   CC      armeb-linux-user/target/arm/gdbstub.o
>   CC      arm-linux-user/linux-user/arm/nwfpe/fpopcode.o
>   CC      armeb-linux-user/target/arm/crypto_helper.o
>   CC      arm-linux-user/linux-user/arm/nwfpe/single_cpdo.o
>   CC      m68k-linux-user/linux-user/mmap.o
>   GEN     trace/generated-helpers.c
>   CC      arm-linux-user/linux-user/arm/nwfpe/double_cpdo.o
>   CC      armeb-linux-user/trace/control-target.o
>   CC      m68k-linux-user/linux-user/signal.o
>   CC      arm-linux-user/linux-user/arm/nwfpe/extended_cpdo.o
>   CC      armeb-linux-user/gdbstub-xml.o
>   CC      armeb-linux-user/trace/generated-helpers.o
>   CC      arm-linux-user/target/arm/arm-semi.o
>   CC      m68k-linux-user/linux-user/elfload.o
>   LINK    armeb-linux-user/qemu-armeb
>   CC      arm-linux-user/target/arm/kvm-stub.o
>   CC      i386-linux-user/linux-user/strace.o
>   CC      m68k-linux-user/linux-user/linuxload.o
>   GEN     microblazeel-linux-user/config-target.h
>   CC      microblazeel-linux-user/exec.o
>   CC      m68k-linux-user/linux-user/uaccess.o
>   CC      microblazeel-linux-user/tcg/tcg.o
>   CC      m68k-linux-user/linux-user/uname.o
>   CC      i386-linux-user/linux-user/mmap.o
>   CCAS    m68k-linux-user/linux-user/safe-syscall.o
>   CC      m68k-linux-user/linux-user/m68k/signal.o
>   CC      i386-linux-user/linux-user/signal.o
>   CC      m68k-linux-user/linux-user/m68k/cpu_loop.o
>   CC      m68k-linux-user/linux-user/flatload.o
>   CC      i386-linux-user/linux-user/elfload.o
>   CC      m68k-linux-user/linux-user/m68k-sim.o
>   CC      m68k-linux-user/target/m68k/m68k-semi.o
>   CC      microblazeel-linux-user/tcg/tcg-op.o
>   CC      m68k-linux-user/target/m68k/translate.o
>   CC      i386-linux-user/linux-user/linuxload.o
>   CC      i386-linux-user/linux-user/uaccess.o
>   CC      i386-linux-user/linux-user/uname.o
>   CCAS    i386-linux-user/linux-user/safe-syscall.o
>   CC      i386-linux-user/linux-user/i386/signal.o
>   CC      i386-linux-user/linux-user/i386/cpu_loop.o
>   CC      i386-linux-user/linux-user/vm86.o
>   CC      i386-linux-user/target/i386/helper.o
>   CC      microblazeel-linux-user/tcg/tcg-op-vec.o
>   CC      i386-linux-user/target/i386/cpu.o
>   CC      microblazeel-linux-user/tcg/tcg-op-gvec.o
>   CC      m68k-linux-user/target/m68k/op_helper.o
>   CC      i386-linux-user/target/i386/gdbstub.o
>   CC      i386-linux-user/target/i386/xsave_helper.o
>   CC      m68k-linux-user/target/m68k/helper.o
>   CC      i386-linux-user/target/i386/translate.o
>   CC      m68k-linux-user/target/m68k/cpu.o
>   CC      microblazeel-linux-user/tcg/tcg-common.o
>   CC      m68k-linux-user/target/m68k/fpu_helper.o
>   CC      microblazeel-linux-user/tcg/optimize.o
>   CC      m68k-linux-user/target/m68k/softfloat.o
>   CC      microblazeel-linux-user/fpu/softfloat.o
>   CC      m68k-linux-user/target/m68k/gdbstub.o
>   GEN     trace/generated-helpers.c
>   CC      m68k-linux-user/trace/control-target.o
>   CC      m68k-linux-user/gdbstub-xml.o
>   CC      m68k-linux-user/trace/generated-helpers.o
>   LINK    m68k-linux-user/qemu-m68k
>   CC      arm-linux-user/target/arm/translate.o
>   CC      i386-linux-user/target/i386/bpt_helper.o
>   CC      i386-linux-user/target/i386/cc_helper.o
>   CC      microblazeel-linux-user/disas.o
>   CC      i386-linux-user/target/i386/excp_helper.o
>   CC      arm-linux-user/target/arm/op_helper.o
>   CC      microblazeel-linux-user/gdbstub.o
>   CC      i386-linux-user/target/i386/fpu_helper.o
>   CC      i386-linux-user/target/i386/int_helper.o
>   CC      arm-linux-user/target/arm/helper.o
>   CC      arm-linux-user/target/arm/cpu.o
>   CC      i386-linux-user/target/i386/mem_helper.o
>   CC      i386-linux-user/target/i386/misc_helper.o
>   CC      arm-linux-user/target/arm/neon_helper.o
>   CC      i386-linux-user/target/i386/mpx_helper.o
>   GEN     microblaze-linux-user/config-target.h
>   CC      microblaze-linux-user/exec.o
>   CC      i386-linux-user/target/i386/seg_helper.o
>   CC      microblaze-linux-user/tcg/tcg.o
>   CC      microblaze-linux-user/tcg/tcg-op.o
>   CC      i386-linux-user/target/i386/smm_helper.o
>   CC      i386-linux-user/target/i386/svm_helper.o
>   CC      i386-linux-user/target/i386/kvm-stub.o
>   CC      i386-linux-user/target/i386/sev-stub.o
>   GEN     trace/generated-helpers.c
>   CC      i386-linux-user/trace/control-target.o
>   CC      i386-linux-user/gdbstub-xml.o
>   CC      i386-linux-user/trace/generated-helpers.o
>   LINK    i386-linux-user/qemu-i386
>   GEN     mips64el-linux-user/config-target.h
>   CC      mips64el-linux-user/exec.o
>   CC      mips64el-linux-user/tcg/tcg.o
>   CC      mips64el-linux-user/tcg/tcg-op.o
>   CC      mips64el-linux-user/tcg/tcg-op-vec.o
>   CC      mips64el-linux-user/tcg/tcg-op-gvec.o
>   CC      mips64el-linux-user/tcg/tcg-common.o
>   CC      mips64el-linux-user/tcg/optimize.o
>   CC      mips64el-linux-user/fpu/softfloat.o
>   CC      mips64el-linux-user/disas.o
>   CC      mips64el-linux-user/gdbstub.o
>   CC      mips64el-linux-user/thunk.o
>   CC      mips64el-linux-user/accel/stubs/hax-stub.o
>   CC      mips64el-linux-user/accel/stubs/hvf-stub.o
>   CC      mips64el-linux-user/accel/stubs/whpx-stub.o
>   CC      mips64el-linux-user/accel/stubs/kvm-stub.o
>   CC      mips64el-linux-user/accel/tcg/tcg-runtime.o
>   CC      mips64el-linux-user/accel/tcg/tcg-runtime-gvec.o
>   CC      mips64el-linux-user/accel/tcg/cpu-exec.o
>   CC      mips64el-linux-user/accel/tcg/cpu-exec-common.o
>   CC      mips64el-linux-user/accel/tcg/translate-all.o
>   CC      mips64el-linux-user/accel/tcg/translator.o
>   CC      mips64el-linux-user/accel/tcg/user-exec.o
>   CC      mips64el-linux-user/accel/tcg/user-exec-stub.o
>   CC      mips64el-linux-user/linux-user/main.o
>   CC      mips64el-linux-user/linux-user/syscall.o
>   CC      mips64el-linux-user/linux-user/strace.o
>   CC      mips64el-linux-user/linux-user/mmap.o
>   CC      mips64el-linux-user/linux-user/signal.o
>   CC      mips64el-linux-user/linux-user/elfload.o
>   CC      mips64el-linux-user/linux-user/linuxload.o
>   CC      mips64el-linux-user/linux-user/uaccess.o
>   CC      mips64el-linux-user/linux-user/uname.o
>   CCAS    mips64el-linux-user/linux-user/safe-syscall.o
>   CC      mips64el-linux-user/linux-user/mips64/signal.o
>   CC      mips64el-linux-user/linux-user/mips64/cpu_loop.o
>   CC      mips64el-linux-user/target/mips/translate.o
>   CC      mips64el-linux-user/target/mips/dsp_helper.o
>   CC      mips64el-linux-user/target/mips/op_helper.o
>   CC      mips64el-linux-user/target/mips/lmi_helper.o
>   CC      mips64el-linux-user/target/mips/helper.o
>   CC      mips64el-linux-user/target/mips/cpu.o
>   CC      mips64el-linux-user/target/mips/gdbstub.o
>   CC      mips64el-linux-user/target/mips/msa_helper.o
>   CC      mips64el-linux-user/target/mips/mips-semi.o
>   GEN     trace/generated-helpers.c
>   CC      mips64el-linux-user/trace/control-target.o
>   CC      mips64el-linux-user/trace/generated-helpers.o
>   LINK    mips64el-linux-user/qemu-mips64el
>   CC      microblaze-linux-user/tcg/tcg-op-vec.o
>   CC      microblaze-linux-user/tcg/tcg-op-gvec.o
>   CC      microblaze-linux-user/tcg/tcg-common.o
>   CC      microblaze-linux-user/tcg/optimize.o
>   CC      microblaze-linux-user/fpu/softfloat.o
>   CC      arm-linux-user/target/arm/iwmmxt_helper.o
>   CC      microblazeel-linux-user/thunk.o
>   CC      arm-linux-user/target/arm/vec_helper.o
>   CC      microblazeel-linux-user/accel/stubs/hax-stub.o
>   CC      arm-linux-user/target/arm/gdbstub.o
>   CC      microblazeel-linux-user/accel/stubs/hvf-stub.o
>   CC      microblazeel-linux-user/accel/stubs/whpx-stub.o
>   CC      arm-linux-user/target/arm/crypto_helper.o
>   CC      microblazeel-linux-user/accel/stubs/kvm-stub.o
>   CC      microblazeel-linux-user/accel/tcg/tcg-runtime.o
>   CC      microblazeel-linux-user/accel/tcg/tcg-runtime-gvec.o
>   GEN     mips64-linux-user/config-target.h
>   CC      mips64-linux-user/exec.o
>   CC      mips64-linux-user/tcg/tcg.o
>   CC      microblazeel-linux-user/accel/tcg/cpu-exec.o
>   CC      microblazeel-linux-user/accel/tcg/cpu-exec-common.o
>   CC      microblazeel-linux-user/accel/tcg/translate-all.o
>   CC      microblazeel-linux-user/accel/tcg/translator.o
>   CC      microblazeel-linux-user/accel/tcg/user-exec.o
>   CC      mips64-linux-user/tcg/tcg-op.o
>   CC      microblazeel-linux-user/accel/tcg/user-exec-stub.o
>   CC      microblazeel-linux-user/linux-user/main.o
>   CC      microblazeel-linux-user/linux-user/syscall.o
>   CC      mips64-linux-user/tcg/tcg-op-vec.o
>   CC      mips64-linux-user/tcg/tcg-op-gvec.o
>   CC      mips64-linux-user/tcg/tcg-common.o
>   CC      mips64-linux-user/tcg/optimize.o
>   CC      microblazeel-linux-user/linux-user/strace.o
>   CC      mips64-linux-user/fpu/softfloat.o
>   CC      microblazeel-linux-user/linux-user/mmap.o
>   CC      microblazeel-linux-user/linux-user/signal.o
>   CC      microblazeel-linux-user/linux-user/elfload.o
>   CC      microblazeel-linux-user/linux-user/linuxload.o
>   CC      microblazeel-linux-user/linux-user/uaccess.o
>   CC      microblazeel-linux-user/linux-user/uname.o
>   CCAS    microblazeel-linux-user/linux-user/safe-syscall.o
>   CC      microblazeel-linux-user/linux-user/microblaze/signal.o
>   CC      microblazeel-linux-user/linux-user/microblaze/cpu_loop.o
>   CC      microblazeel-linux-user/linux-user/flatload.o
>   CC      microblazeel-linux-user/target/microblaze/translate.o
>   CC      mips64-linux-user/disas.o
>   CC      mips64-linux-user/gdbstub.o
>   CC      microblazeel-linux-user/target/microblaze/op_helper.o
>   CC      mips64-linux-user/thunk.o
>   CC      microblazeel-linux-user/target/microblaze/helper.o
>   CC      microblazeel-linux-user/target/microblaze/cpu.o
>   CC      mips64-linux-user/accel/stubs/hax-stub.o
>   CC      mips64-linux-user/accel/stubs/hvf-stub.o
>   CC      microblazeel-linux-user/target/microblaze/gdbstub.o
>   CC      mips64-linux-user/accel/stubs/whpx-stub.o
>   GEN     trace/generated-helpers.c
>   CC      microblazeel-linux-user/trace/control-target.o
>   CC      mips64-linux-user/accel/stubs/kvm-stub.o
>   CC      microblazeel-linux-user/trace/generated-helpers.o
>   CC      mips64-linux-user/accel/tcg/tcg-runtime.o
>   LINK    microblazeel-linux-user/qemu-microblazeel
>   CC      mips64-linux-user/accel/tcg/tcg-runtime-gvec.o
>   GEN     mipsel-linux-user/config-target.h
>   CC      mipsel-linux-user/exec.o
>   CC      mipsel-linux-user/tcg/tcg.o
>   CC      mipsel-linux-user/tcg/tcg-op.o
>   CC      mipsel-linux-user/tcg/tcg-op-vec.o
>   CC      mipsel-linux-user/tcg/tcg-op-gvec.o
>   CC      mipsel-linux-user/tcg/tcg-common.o
>   CC      mipsel-linux-user/tcg/optimize.o
>   CC      mipsel-linux-user/fpu/softfloat.o
>   CC      mipsel-linux-user/disas.o
>   CC      mipsel-linux-user/gdbstub.o
>   CC      mipsel-linux-user/thunk.o
>   CC      mipsel-linux-user/accel/stubs/hax-stub.o
>   CC      mipsel-linux-user/accel/stubs/hvf-stub.o
>   CC      mipsel-linux-user/accel/stubs/whpx-stub.o
>   CC      mipsel-linux-user/accel/stubs/kvm-stub.o
>   CC      mipsel-linux-user/accel/tcg/tcg-runtime.o
>   CC      mipsel-linux-user/accel/tcg/tcg-runtime-gvec.o
>   CC      mipsel-linux-user/accel/tcg/cpu-exec.o
>   CC      mipsel-linux-user/accel/tcg/cpu-exec-common.o
>   CC      mipsel-linux-user/accel/tcg/translate-all.o
>   CC      mipsel-linux-user/accel/tcg/translator.o
>   CC      mipsel-linux-user/accel/tcg/user-exec.o
>   CC      mipsel-linux-user/accel/tcg/user-exec-stub.o
>   CC      mipsel-linux-user/linux-user/main.o
>   CC      mipsel-linux-user/linux-user/syscall.o
>   CC      mipsel-linux-user/linux-user/strace.o
>   CC      mipsel-linux-user/linux-user/mmap.o
>   CC      mipsel-linux-user/linux-user/signal.o
>   CC      mipsel-linux-user/linux-user/elfload.o
>   CC      mipsel-linux-user/linux-user/linuxload.o
>   CC      mipsel-linux-user/linux-user/uaccess.o
>   CC      mipsel-linux-user/linux-user/uname.o
>   CCAS    mipsel-linux-user/linux-user/safe-syscall.o
>   CC      mipsel-linux-user/linux-user/mips/signal.o
>   CC      mipsel-linux-user/linux-user/mips/cpu_loop.o
>   CC      mipsel-linux-user/target/mips/translate.o
>   CC      mipsel-linux-user/target/mips/dsp_helper.o
>   CC      mipsel-linux-user/target/mips/op_helper.o
>   CC      mipsel-linux-user/target/mips/lmi_helper.o
>   CC      mipsel-linux-user/target/mips/helper.o
>   CC      mipsel-linux-user/target/mips/cpu.o
>   CC      mipsel-linux-user/target/mips/gdbstub.o
>   CC      mipsel-linux-user/target/mips/msa_helper.o
>   CC      mipsel-linux-user/target/mips/mips-semi.o
>   GEN     trace/generated-helpers.c
>   CC      mipsel-linux-user/trace/control-target.o
>   CC      mipsel-linux-user/trace/generated-helpers.o
>   LINK    mipsel-linux-user/qemu-mipsel
>   GEN     trace/generated-helpers.c
>   CC      microblaze-linux-user/disas.o
>   CC      arm-linux-user/trace/control-target.o
>   CC      microblaze-linux-user/gdbstub.o
>   CC      arm-linux-user/gdbstub-xml.o
>   CC      microblaze-linux-user/thunk.o
>   CC      mips64-linux-user/accel/tcg/cpu-exec.o
>   CC      mips64-linux-user/accel/tcg/cpu-exec-common.o
>   CC      arm-linux-user/trace/generated-helpers.o
>   CC      microblaze-linux-user/accel/stubs/hax-stub.o
>   CC      mips64-linux-user/accel/tcg/translate-all.o
>   LINK    arm-linux-user/qemu-arm
>   CC      microblaze-linux-user/accel/stubs/hvf-stub.o
>   CC      mips64-linux-user/accel/tcg/translator.o
>   CC      microblaze-linux-user/accel/stubs/whpx-stub.o
>   CC      mips64-linux-user/accel/tcg/user-exec.o
>   GEN     mips-linux-user/config-target.h
>   CC      microblaze-linux-user/accel/stubs/kvm-stub.o
>   CC      mips-linux-user/exec.o
>   CC      microblaze-linux-user/accel/tcg/tcg-runtime.o
>   CC      mips64-linux-user/accel/tcg/user-exec-stub.o
>   CC      mips-linux-user/tcg/tcg.o
>   CC      microblaze-linux-user/accel/tcg/tcg-runtime-gvec.o
>   CC      mips64-linux-user/linux-user/main.o
>   CC      mips64-linux-user/linux-user/syscall.o
>   CC      mips64-linux-user/linux-user/strace.o
>   CC      microblaze-linux-user/accel/tcg/cpu-exec.o
>   CC      microblaze-linux-user/accel/tcg/cpu-exec-common.o
>   CC      mips64-linux-user/linux-user/mmap.o
>   CC      microblaze-linux-user/accel/tcg/translate-all.o
>   CC      mips-linux-user/tcg/tcg-op.o
>   CC      mips64-linux-user/linux-user/signal.o
>   CC      microblaze-linux-user/accel/tcg/translator.o
>   CC      mips64-linux-user/linux-user/elfload.o
>   CC      mips64-linux-user/linux-user/linuxload.o
>   CC      microblaze-linux-user/accel/tcg/user-exec.o
>   GEN     mipsn32el-linux-user/config-target.h
>   CC      mips64-linux-user/linux-user/uaccess.o
>   CC      mipsn32el-linux-user/exec.o
>   CC      mips64-linux-user/linux-user/uname.o
>   CC      mipsn32el-linux-user/tcg/tcg.o
>   CCAS    mips64-linux-user/linux-user/safe-syscall.o
>   CC      mips64-linux-user/linux-user/mips64/signal.o
>   CC      microblaze-linux-user/accel/tcg/user-exec-stub.o
>   CC      mips64-linux-user/linux-user/mips64/cpu_loop.o
>   CC      microblaze-linux-user/linux-user/main.o
>   CC      mips64-linux-user/target/mips/translate.o
>   CC      microblaze-linux-user/linux-user/syscall.o
>   CC      mipsn32el-linux-user/tcg/tcg-op.o
>   CC      mipsn32el-linux-user/tcg/tcg-op-vec.o
>   CC      microblaze-linux-user/linux-user/strace.o
>   CC      mipsn32el-linux-user/tcg/tcg-op-gvec.o
>   CC      microblaze-linux-user/linux-user/mmap.o
>   CC      microblaze-linux-user/linux-user/signal.o
>   CC      microblaze-linux-user/linux-user/elfload.o
>   CC      microblaze-linux-user/linux-user/linuxload.o
>   CC      mipsn32el-linux-user/tcg/tcg-common.o
>   CC      microblaze-linux-user/linux-user/uaccess.o
>   CC      mipsn32el-linux-user/tcg/optimize.o
>   CC      microblaze-linux-user/linux-user/uname.o
>   CCAS    microblaze-linux-user/linux-user/safe-syscall.o
>   CC      microblaze-linux-user/linux-user/microblaze/signal.o
>   CC      microblaze-linux-user/linux-user/microblaze/cpu_loop.o
>   CC      microblaze-linux-user/linux-user/flatload.o
>   CC      mipsn32el-linux-user/fpu/softfloat.o
>   CC      microblaze-linux-user/target/microblaze/translate.o
>   CC      mips64-linux-user/target/mips/dsp_helper.o
>   CC      microblaze-linux-user/target/microblaze/op_helper.o
>   CC      microblaze-linux-user/target/microblaze/helper.o
>   CC      microblaze-linux-user/target/microblaze/cpu.o
>   CC      microblaze-linux-user/target/microblaze/gdbstub.o
>   GEN     trace/generated-helpers.c
>   CC      microblaze-linux-user/trace/control-target.o
>   CC      microblaze-linux-user/trace/generated-helpers.o
>   CC      mips64-linux-user/target/mips/op_helper.o
>   LINK    microblaze-linux-user/qemu-microblaze
>   GEN     mipsn32-linux-user/config-target.h
>   CC      mipsn32-linux-user/exec.o
>   CC      mipsn32-linux-user/tcg/tcg.o
>   CC      mipsn32-linux-user/tcg/tcg-op.o
>   CC      mipsn32-linux-user/tcg/tcg-op-vec.o
>   CC      mipsn32-linux-user/tcg/tcg-op-gvec.o
>   CC      mipsn32-linux-user/tcg/tcg-common.o
>   CC      mipsn32-linux-user/tcg/optimize.o
>   CC      mipsn32-linux-user/fpu/softfloat.o
>   CC      mipsn32-linux-user/disas.o
>   CC      mipsn32-linux-user/gdbstub.o
>   CC      mipsn32-linux-user/thunk.o
>   CC      mipsn32-linux-user/accel/stubs/hax-stub.o
>   CC      mipsn32-linux-user/accel/stubs/hvf-stub.o
>   CC      mipsn32-linux-user/accel/stubs/whpx-stub.o
>   CC      mipsn32-linux-user/accel/stubs/kvm-stub.o
>   CC      mipsn32-linux-user/accel/tcg/tcg-runtime.o
>   CC      mipsn32-linux-user/accel/tcg/tcg-runtime-gvec.o
>   CC      mipsn32-linux-user/accel/tcg/cpu-exec.o
>   CC      mipsn32-linux-user/accel/tcg/cpu-exec-common.o
>   CC      mipsn32-linux-user/accel/tcg/translate-all.o
>   CC      mipsn32-linux-user/accel/tcg/translator.o
>   CC      mipsn32-linux-user/accel/tcg/user-exec.o
>   CC      mipsn32-linux-user/accel/tcg/user-exec-stub.o
>   CC      mipsn32-linux-user/linux-user/main.o
>   CC      mipsn32-linux-user/linux-user/syscall.o
>   CC      mipsn32-linux-user/linux-user/strace.o
>   CC      mipsn32-linux-user/linux-user/mmap.o
>   CC      mipsn32-linux-user/linux-user/signal.o
>   CC      mipsn32-linux-user/linux-user/elfload.o
>   CC      mipsn32-linux-user/linux-user/linuxload.o
>   CC      mipsn32-linux-user/linux-user/uaccess.o
>   CC      mipsn32-linux-user/linux-user/uname.o
>   CCAS    mipsn32-linux-user/linux-user/safe-syscall.o
>   CC      mipsn32-linux-user/linux-user/mips64/signal.o
>   CC      mipsn32-linux-user/linux-user/mips64/cpu_loop.o
>   CC      mipsn32-linux-user/target/mips/translate.o
>   CC      mipsn32-linux-user/target/mips/dsp_helper.o
>   CC      mipsn32-linux-user/target/mips/op_helper.o
>   CC      mipsn32-linux-user/target/mips/lmi_helper.o
>   CC      mipsn32-linux-user/target/mips/helper.o
>   CC      mipsn32-linux-user/target/mips/cpu.o
>   CC      mipsn32-linux-user/target/mips/gdbstub.o
>   CC      mipsn32-linux-user/target/mips/msa_helper.o
>   CC      mipsn32-linux-user/target/mips/mips-semi.o
>   GEN     trace/generated-helpers.c
>   CC      mipsn32-linux-user/trace/control-target.o
>   CC      mipsn32-linux-user/trace/generated-helpers.o
>   LINK    mipsn32-linux-user/qemu-mipsn32
>   CC      mips64-linux-user/target/mips/lmi_helper.o
>   CC      mips-linux-user/tcg/tcg-op-vec.o
>   CC      mipsn32el-linux-user/disas.o
>   CC      mips64-linux-user/target/mips/helper.o
>   CC      mipsn32el-linux-user/gdbstub.o
>   CC      mips64-linux-user/target/mips/cpu.o
>   GEN     nios2-linux-user/config-target.h
>   CC      mips-linux-user/tcg/tcg-op-gvec.o
>   CC      mips64-linux-user/target/mips/gdbstub.o
>   CC      nios2-linux-user/exec.o
>   CC      mips64-linux-user/target/mips/msa_helper.o
>   CC      nios2-linux-user/tcg/tcg.o
>   CC      mips-linux-user/tcg/tcg-common.o
>   CC      mips-linux-user/tcg/optimize.o
>   CC      nios2-linux-user/tcg/tcg-op.o
>   CC      mips-linux-user/fpu/softfloat.o
>   CC      mips64-linux-user/target/mips/mips-semi.o
>   CC      nios2-linux-user/tcg/tcg-op-vec.o
>   GEN     trace/generated-helpers.c
>   CC      mips64-linux-user/trace/control-target.o
>   CC      mips64-linux-user/trace/generated-helpers.o
>   CC      nios2-linux-user/tcg/tcg-op-gvec.o
>   LINK    mips64-linux-user/qemu-mips64
>   CC      mipsn32el-linux-user/thunk.o
>   CC      mips-linux-user/disas.o
>   CC      mipsn32el-linux-user/accel/stubs/hax-stub.o
>   CC      nios2-linux-user/tcg/tcg-common.o
>   CC      mipsn32el-linux-user/accel/stubs/hvf-stub.o
>   CC      nios2-linux-user/tcg/optimize.o
>   CC      mipsn32el-linux-user/accel/stubs/whpx-stub.o
>   GEN     or1k-linux-user/config-target.h
>   CC      or1k-linux-user/exec.o
>   CC      or1k-linux-user/tcg/tcg.o
>   CC      or1k-linux-user/tcg/tcg-op.o
>   CC      or1k-linux-user/tcg/tcg-op-vec.o
>   CC      or1k-linux-user/tcg/tcg-op-gvec.o
>   CC      or1k-linux-user/tcg/tcg-common.o
>   CC      or1k-linux-user/tcg/optimize.o
>   CC      or1k-linux-user/fpu/softfloat.o
>   CC      or1k-linux-user/disas.o
>   CC      or1k-linux-user/gdbstub.o
>   CC      or1k-linux-user/thunk.o
>   CC      or1k-linux-user/accel/stubs/hax-stub.o
>   CC      or1k-linux-user/accel/stubs/hvf-stub.o
>   CC      or1k-linux-user/accel/stubs/whpx-stub.o
>   CC      or1k-linux-user/accel/stubs/kvm-stub.o
>   CC      or1k-linux-user/accel/tcg/tcg-runtime.o
>   CC      or1k-linux-user/accel/tcg/tcg-runtime-gvec.o
>   CC      or1k-linux-user/accel/tcg/cpu-exec.o
>   CC      or1k-linux-user/accel/tcg/cpu-exec-common.o
>   CC      or1k-linux-user/accel/tcg/translate-all.o
>   CC      or1k-linux-user/accel/tcg/translator.o
>   CC      or1k-linux-user/accel/tcg/user-exec.o
>   CC      or1k-linux-user/accel/tcg/user-exec-stub.o
>   CC      or1k-linux-user/linux-user/main.o
>   CC      or1k-linux-user/linux-user/syscall.o
>   CC      or1k-linux-user/linux-user/strace.o
>   CC      or1k-linux-user/linux-user/mmap.o
>   CC      or1k-linux-user/linux-user/signal.o
>   CC      or1k-linux-user/linux-user/elfload.o
>   CC      or1k-linux-user/linux-user/linuxload.o
>   CC      or1k-linux-user/linux-user/uaccess.o
>   CC      or1k-linux-user/linux-user/uname.o
>   CCAS    or1k-linux-user/linux-user/safe-syscall.o
>   CC      or1k-linux-user/linux-user/openrisc/signal.o
>   CC      or1k-linux-user/linux-user/openrisc/cpu_loop.o
>   CC      or1k-linux-user/target/openrisc/cpu.o
>   CC      or1k-linux-user/target/openrisc/exception.o
>   CC      or1k-linux-user/target/openrisc/interrupt.o
>   CC      or1k-linux-user/target/openrisc/mmu.o
>   GEN     or1k-linux-user/target/openrisc/decode.inc.c
>   CC      or1k-linux-user/target/openrisc/exception_helper.o
>   CC      or1k-linux-user/target/openrisc/fpu_helper.o
>   CC      or1k-linux-user/target/openrisc/interrupt_helper.o
>   CC      or1k-linux-user/target/openrisc/mmu_helper.o
>   CC      or1k-linux-user/target/openrisc/sys_helper.o
>   CC      or1k-linux-user/target/openrisc/gdbstub.o
>   GEN     trace/generated-helpers.c
>   CC      or1k-linux-user/trace/control-target.o
>   CC      or1k-linux-user/target/openrisc/translate.o
>   CC      or1k-linux-user/trace/generated-helpers.o
>   LINK    or1k-linux-user/qemu-or1k
>   CC      nios2-linux-user/fpu/softfloat.o
>   CC      mipsn32el-linux-user/accel/stubs/kvm-stub.o
>   CC      nios2-linux-user/disas.o
>   CC      mipsn32el-linux-user/accel/tcg/tcg-runtime.o
>   GEN     ppc64abi32-linux-user/config-target.h
>   CC      ppc64abi32-linux-user/exec.o
>   CC      ppc64abi32-linux-user/tcg/tcg.o
>   CC      ppc64abi32-linux-user/tcg/tcg-op.o
>   CC      nios2-linux-user/gdbstub.o
>   CC      nios2-linux-user/thunk.o
>   CC      nios2-linux-user/accel/stubs/hax-stub.o
>   CC      nios2-linux-user/accel/stubs/hvf-stub.o
>   CC      nios2-linux-user/accel/stubs/whpx-stub.o
>   CC      ppc64abi32-linux-user/tcg/tcg-op-vec.o
>   CC      nios2-linux-user/accel/stubs/kvm-stub.o
>   CC      nios2-linux-user/accel/tcg/tcg-runtime.o
>   CC      nios2-linux-user/accel/tcg/tcg-runtime-gvec.o
>   CC      ppc64abi32-linux-user/tcg/tcg-op-gvec.o
>   CC      nios2-linux-user/accel/tcg/cpu-exec.o
>   CC      nios2-linux-user/accel/tcg/cpu-exec-common.o
>   CC      nios2-linux-user/accel/tcg/translate-all.o
>   CC      ppc64abi32-linux-user/tcg/tcg-common.o
>   CC      ppc64abi32-linux-user/tcg/optimize.o
>   CC      nios2-linux-user/accel/tcg/translator.o
>   CC      nios2-linux-user/accel/tcg/user-exec.o
>   CC      ppc64abi32-linux-user/fpu/softfloat.o
>   CC      nios2-linux-user/accel/tcg/user-exec-stub.o
>   CC      nios2-linux-user/linux-user/main.o
>   CC      nios2-linux-user/linux-user/syscall.o
>   CC      ppc64abi32-linux-user/disas.o
>   GEN     ppc64abi32-linux-user/gdbstub-xml.c
>   CC      ppc64abi32-linux-user/gdbstub.o
>   CC      ppc64abi32-linux-user/thunk.o
>   CC      nios2-linux-user/linux-user/strace.o
>   CC      ppc64abi32-linux-user/accel/stubs/hax-stub.o
>   CC      ppc64abi32-linux-user/accel/stubs/hvf-stub.o
>   CC      ppc64abi32-linux-user/accel/stubs/whpx-stub.o
>   CC      nios2-linux-user/linux-user/mmap.o
>   CC      ppc64abi32-linux-user/accel/stubs/kvm-stub.o
>   CC      ppc64abi32-linux-user/accel/tcg/tcg-runtime.o
>   CC      nios2-linux-user/linux-user/signal.o
>   CC      ppc64abi32-linux-user/accel/tcg/tcg-runtime-gvec.o
>   CC      nios2-linux-user/linux-user/elfload.o
>   CC      nios2-linux-user/linux-user/linuxload.o
>   CC      ppc64abi32-linux-user/accel/tcg/cpu-exec.o
>   CC      nios2-linux-user/linux-user/uaccess.o
>   CC      nios2-linux-user/linux-user/uname.o
>   CC      ppc64abi32-linux-user/accel/tcg/cpu-exec-common.o
>   CC      ppc64abi32-linux-user/accel/tcg/translate-all.o
>   CCAS    nios2-linux-user/linux-user/safe-syscall.o
>   CC      nios2-linux-user/linux-user/nios2/signal.o
>   CC      nios2-linux-user/linux-user/nios2/cpu_loop.o
>   CC      ppc64abi32-linux-user/accel/tcg/translator.o
>   CC      nios2-linux-user/target/nios2/translate.o
>   CC      ppc64abi32-linux-user/accel/tcg/user-exec.o
>   CC      nios2-linux-user/target/nios2/op_helper.o
>   CC      nios2-linux-user/target/nios2/helper.o
>   CC      nios2-linux-user/target/nios2/cpu.o
>   CC      nios2-linux-user/target/nios2/mmu.o
>   GEN     trace/generated-helpers.c
>   CC      nios2-linux-user/trace/control-target.o
>   CC      ppc64abi32-linux-user/accel/tcg/user-exec-stub.o
>   CC      ppc64abi32-linux-user/linux-user/main.o
>   CC      nios2-linux-user/trace/generated-helpers.o
>   LINK    nios2-linux-user/qemu-nios2
>   CC      ppc64abi32-linux-user/linux-user/syscall.o
>   CC      mipsn32el-linux-user/accel/tcg/tcg-runtime-gvec.o
>   CC      ppc64abi32-linux-user/linux-user/strace.o
>   CC      ppc64abi32-linux-user/linux-user/mmap.o
>   CC      mipsn32el-linux-user/accel/tcg/cpu-exec.o
>   GEN     ppc64le-linux-user/config-target.h
>   CC      ppc64le-linux-user/exec.o
>   CC      mipsn32el-linux-user/accel/tcg/cpu-exec-common.o
>   CC      ppc64le-linux-user/tcg/tcg.o
>   CC      mipsn32el-linux-user/accel/tcg/translate-all.o
>   CC      mipsn32el-linux-user/accel/tcg/translator.o
>   CC      mipsn32el-linux-user/accel/tcg/user-exec.o
>   CC      ppc64le-linux-user/tcg/tcg-op.o
>   CC      ppc64abi32-linux-user/linux-user/signal.o
>   CC      mipsn32el-linux-user/accel/tcg/user-exec-stub.o
>   CC      mipsn32el-linux-user/linux-user/main.o
>   CC      ppc64abi32-linux-user/linux-user/elfload.o
>   CC      mipsn32el-linux-user/linux-user/syscall.o
>   CC      ppc64abi32-linux-user/linux-user/linuxload.o
>   CC      ppc64abi32-linux-user/linux-user/uaccess.o
>   CC      ppc64abi32-linux-user/linux-user/uname.o
>   CCAS    ppc64abi32-linux-user/linux-user/safe-syscall.o
>   CC      ppc64abi32-linux-user/linux-user/ppc/signal.o
>   CC      ppc64le-linux-user/tcg/tcg-op-vec.o
>   CC      ppc64abi32-linux-user/linux-user/ppc/cpu_loop.o
>   CC      ppc64abi32-linux-user/target/ppc/cpu-models.o
>   CC      ppc64le-linux-user/tcg/tcg-op-gvec.o
>   CC      ppc64abi32-linux-user/target/ppc/cpu.o
>   CC      ppc64abi32-linux-user/target/ppc/translate.o
>   CC      ppc64le-linux-user/tcg/tcg-common.o
>   CC      mipsn32el-linux-user/linux-user/strace.o
>   CC      ppc64le-linux-user/tcg/optimize.o
>   CC      mipsn32el-linux-user/linux-user/mmap.o
>   CC      mipsn32el-linux-user/linux-user/signal.o
>   CC      ppc64le-linux-user/fpu/softfloat.o
>   CC      mipsn32el-linux-user/linux-user/elfload.o
>   CC      mipsn32el-linux-user/linux-user/linuxload.o
>   CC      mipsn32el-linux-user/linux-user/uaccess.o
>   CC      mipsn32el-linux-user/linux-user/uname.o
>   CCAS    mipsn32el-linux-user/linux-user/safe-syscall.o
>   CC      mipsn32el-linux-user/linux-user/mips64/signal.o
>   CC      mipsn32el-linux-user/linux-user/mips64/cpu_loop.o
>   CC      mipsn32el-linux-user/target/mips/translate.o
>   CC      ppc64le-linux-user/disas.o
>   GEN     ppc64le-linux-user/gdbstub-xml.c
>   CC      ppc64le-linux-user/gdbstub.o
>   CC      ppc64le-linux-user/thunk.o
>   CC      ppc64le-linux-user/accel/stubs/hax-stub.o
>   CC      ppc64le-linux-user/accel/stubs/hvf-stub.o
>   CC      ppc64le-linux-user/accel/stubs/whpx-stub.o
>   CC      ppc64le-linux-user/accel/stubs/kvm-stub.o
>   CC      ppc64le-linux-user/accel/tcg/tcg-runtime.o
>   CC      ppc64le-linux-user/accel/tcg/tcg-runtime-gvec.o
>   CC      ppc64le-linux-user/accel/tcg/cpu-exec.o
>   CC      ppc64le-linux-user/accel/tcg/cpu-exec-common.o
>   CC      ppc64le-linux-user/accel/tcg/translate-all.o
>   CC      ppc64le-linux-user/accel/tcg/translator.o
>   CC      ppc64le-linux-user/accel/tcg/user-exec.o
>   CC      ppc64le-linux-user/accel/tcg/user-exec-stub.o
>   CC      ppc64le-linux-user/linux-user/main.o
>   CC      ppc64le-linux-user/linux-user/syscall.o
>   CC      mipsn32el-linux-user/target/mips/dsp_helper.o
>   CC      ppc64abi32-linux-user/target/ppc/kvm-stub.o
>   CC      ppc64abi32-linux-user/target/ppc/dfp_helper.o
>   CC      ppc64abi32-linux-user/target/ppc/excp_helper.o
>   CC      ppc64abi32-linux-user/target/ppc/fpu_helper.o
>   CC      mipsn32el-linux-user/target/mips/op_helper.o
>   CC      ppc64le-linux-user/linux-user/strace.o
>   CC      ppc64le-linux-user/linux-user/mmap.o
>   CC      ppc64le-linux-user/linux-user/signal.o
>   CC      mipsn32el-linux-user/target/mips/lmi_helper.o
>   CC      ppc64le-linux-user/linux-user/elfload.o
>   CC      mipsn32el-linux-user/target/mips/helper.o
>   CC      mipsn32el-linux-user/target/mips/cpu.o
>   CC      mipsn32el-linux-user/target/mips/gdbstub.o
>   CC      ppc64le-linux-user/linux-user/linuxload.o
>   CC      mipsn32el-linux-user/target/mips/msa_helper.o
>   CC      ppc64le-linux-user/linux-user/uaccess.o
>   CC      ppc64abi32-linux-user/target/ppc/int_helper.o
>   CC      ppc64le-linux-user/linux-user/uname.o
>   CCAS    ppc64le-linux-user/linux-user/safe-syscall.o
>   CC      ppc64le-linux-user/linux-user/ppc/signal.o
>   CC      ppc64le-linux-user/linux-user/ppc/cpu_loop.o
>   CC      ppc64le-linux-user/target/ppc/cpu-models.o
>   CC      ppc64abi32-linux-user/target/ppc/timebase_helper.o
>   CC      ppc64abi32-linux-user/target/ppc/misc_helper.o
>   CC      ppc64abi32-linux-user/target/ppc/mem_helper.o
>   CC      ppc64le-linux-user/target/ppc/cpu.o
>   CC      ppc64le-linux-user/target/ppc/translate.o
>   CC      ppc64abi32-linux-user/target/ppc/user_only_helper.o
>   CC      ppc64abi32-linux-user/target/ppc/gdbstub.o
>   CC      ppc64abi32-linux-user/target/ppc/../../libdecnumber/decContext.o
>   CC      mipsn32el-linux-user/target/mips/mips-semi.o
>   CC      ppc64abi32-linux-user/target/ppc/../../libdecnumber/decNumber.o
>   GEN     trace/generated-helpers.c
>   CC      mipsn32el-linux-user/trace/control-target.o
>   CC      mipsn32el-linux-user/trace/generated-helpers.o
>   LINK    mipsn32el-linux-user/qemu-mipsn32el
>   GEN     ppc64-linux-user/config-target.h
>   CC      ppc64-linux-user/exec.o
>   CC      ppc64-linux-user/tcg/tcg.o
> make[1]: *** [/var/tmp/patchew-tester-tmp-4ppomfuh/src/rules.mak:69: tcg/=
tcg.o] Error 1
> make: *** [Makefile:483: subdir-ppc64-linux-user] Error 2
> make: *** Waiting for unfinished jobs....
>   CC      mips-linux-user/gdbstub.o
>   CC      ppc64le-linux-user/target/ppc/kvm-stub.o
>   CC      ppc64le-linux-user/target/ppc/dfp_helper.o
> make[1]: *** [/var/tmp/patchew-tester-tmp-4ppomfuh/src/rules.mak:69: gdbs=
tub.o] Error 1
> make: *** [Makefile:483: subdir-mips-linux-user] Error 2
>   CC      ppc64abi32-linux-user/target/ppc/../../libdecnumber/dpd/decimal=
32.o
>   CC      ppc64le-linux-user/target/ppc/excp_helper.o
> make[1]: *** [/var/tmp/patchew-tester-tmp-4ppomfuh/src/rules.mak:69: targ=
et/ppc/dfp_helper.o] Error 1
> make[1]: *** Waiting for unfinished jobs....
>   CC      ppc64abi32-linux-user/target/ppc/../../libdecnumber/dpd/decimal=
64.o
>   CC      ppc64abi32-linux-user/target/ppc/../../libdecnumber/dpd/decimal=
128.o
> make[1]: *** [/var/tmp/patchew-tester-tmp-4ppomfuh/src/rules.mak:69: targ=
et/ppc/excp_helper.o] Error 1
>   GEN     trace/generated-helpers.c
>   CC      ppc64abi32-linux-user/trace/control-target.o
>   CC      ppc64abi32-linux-user/gdbstub-xml.o
>   CC      ppc64abi32-linux-user/trace/generated-helpers.o
> make[1]: *** [/var/tmp/patchew-tester-tmp-4ppomfuh/src/rules.mak:69: gdbs=
tub-xml.o] Error 1
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:483: subdir-ppc64abi32-linux-user] Error 2
> make[1]: *** [/var/tmp/patchew-tester-tmp-4ppomfuh/src/rules.mak:69: targ=
et/ppc/translate.o] Error 1
> make: *** [Makefile:483: subdir-ppc64le-linux-user] Error 2
> =3D=3D=3D OUTPUT END =3D=3D=3D
>=20
> Test command exited with code: 2
>=20
>=20
> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com

--8GpibOaaTibBMecb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbM5vXAAoJEJykq7OBq3PI1Y8H/27FanYOxaYWRa+wjR5owPj3
rzQweGhVg4Q5VGQFSo52bqCSspexy0MkfYhxT3QY5QYjVIjpMSIH2Gsi5g3ypFwh
Zh6fLmGRjsMVrb7N/Qj48K8XhqWBeLBCOMxGcvvXM5P2oABvNF9Zjnueo9ZAJ1ed
ngjamAMJys1UbhzIxWGRaOrq4X01XA9es4cN7IAFSp6r1aeLhfDBwIWaPCTC4shK
UGiepAagFOcFmZodXi03poso13oxIcSWdMs6uSx56VwG2peyfXVd2aasXY0Mu3oJ
mnmqQ5KvfJrADGxb4523AmaPXkZupD+unpvJpQU1DD9kum87QRNQ49c1nq+zhdU=
=xcKm
-----END PGP SIGNATURE-----

--8GpibOaaTibBMecb--
