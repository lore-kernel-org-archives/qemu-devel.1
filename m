Received: from eggs.gnu.org ([2001:4830:134:3::10]:54667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fOgFr-0003V8-ID
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 05:22:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fOgFi-0004GY-JL
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 05:21:51 -0400
Date: Fri, 1 Jun 2018 17:21:18 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180601092118.GB21919@lemon.usersys.redhat.com>
References: <20180601062849.28641-1-famz@redhat.com>
	<152783551554.348.11775495549488216762@d39dc562802a>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <152783551554.348.11775495549488216762@d39dc562802a>
Subject: Re: [Qemu-devel] [PATCH v8 00/11] qemu-img convert with copy
 offloading
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, qemu-block@nongnu.org, pl@kamp.de, f4bug@amsat.org, mreitz@redhat.com, ronniesahlberg@gmail.com, pbonzini@redhat.com, alex.bennee@linaro.org

On Thu, 05/31 23:45, no-reply@patchew.org wrote:
> Hi,
>=20
> This series failed build test on s390x host. Please find the details belo=
w.
>=20
> Type: series
> Message-id: 20180601062849.28641-1-famz@redhat.com
> Subject: [Qemu-devel] [PATCH v8 00/11] qemu-img convert with copy offload=
ing
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
> From https://github.com/patchew-project/qemu
>  * [new tag]               patchew/20180601062849.28641-1-famz@redhat.com=
 -> patchew/20180601062849.28641-1-famz@redhat.com
> Switched to a new branch 'test'
> 5c03bb24cc qemu-img: Convert with copy offloading
> 51e732e62a block-backend: Add blk_co_copy_range
> 92edadadac iscsi: Implement copy offloading
> 6f8d57827a iscsi: Create and use iscsi_co_wait_for_task
> 5940e7ebff iscsi: Query and save device designator when opening
> 7619b4045d file-posix: Implement bdrv_co_copy_range
> af0dbb042d qcow2: Implement copy offloading
> d1550d576c raw: Implement copy offloading
> 61c824c950 raw: Check byte range uniformly
> 35c506afdd block: Introduce API for copy offloading
> b5683be886 docker: Update fedora image to 28
>=20
> =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
> =3D=3D=3D ENV =3D=3D=3D
> LANG=3Den_US.UTF-8
> XDG_SESSION_ID=3D212219
> USER=3Dfam
> PWD=3D/var/tmp/patchew-tester-tmp-2l7s8dte/src
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
> Install prefix    /var/tmp/patchew-tester-tmp-2l7s8dte/src/install
> BIOS directory    /var/tmp/patchew-tester-tmp-2l7s8dte/src/install/share/=
qemu
> firmware path     /var/tmp/patchew-tester-tmp-2l7s8dte/src/install/share/=
qemu-firmware
> binary directory  /var/tmp/patchew-tester-tmp-2l7s8dte/src/install/bin
> library directory /var/tmp/patchew-tester-tmp-2l7s8dte/src/install/lib
> module directory  /var/tmp/patchew-tester-tmp-2l7s8dte/src/install/lib/qe=
mu
> libexec directory /var/tmp/patchew-tester-tmp-2l7s8dte/src/install/libexec
> include directory /var/tmp/patchew-tester-tmp-2l7s8dte/src/install/include
> config directory  /var/tmp/patchew-tester-tmp-2l7s8dte/src/install/etc
> local state directory   /var/tmp/patchew-tester-tmp-2l7s8dte/src/install/=
var
> Manual directory  /var/tmp/patchew-tester-tmp-2l7s8dte/src/install/share/=
man
> ELF interp prefix /usr/gnemul/qemu-%M
> Source path       /var/tmp/patchew-tester-tmp-2l7s8dte/src
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
> virgl support     yes
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
>   GEN     m68k-softmmu/config-devices.mak
>   GEN     hppa-softmmu/config-devices.mak
>   GEN     microblaze-softmmu/config-devices.mak.tmp
>   GEN     mips64el-softmmu/config-devices.mak.tmp
>   GEN     i386-softmmu/config-devices.mak
>   GEN     mips64-softmmu/config-devices.mak.tmp
>   GEN     microblaze-softmmu/config-devices.mak
>   GEN     mipsel-softmmu/config-devices.mak.tmp
>   GEN     microblazeel-softmmu/config-devices.mak
>   GEN     mips64el-softmmu/config-devices.mak
>   GEN     mips64-softmmu/config-devices.mak
>   GEN     mips-softmmu/config-devices.mak.tmp
>   GEN     moxie-softmmu/config-devices.mak.tmp
>   GEN     nios2-softmmu/config-devices.mak.tmp
>   GEN     mipsel-softmmu/config-devices.mak
>   GEN     moxie-softmmu/config-devices.mak
>   GEN     nios2-softmmu/config-devices.mak
>   GEN     or1k-softmmu/config-devices.mak.tmp
>   GEN     ppc64-softmmu/config-devices.mak.tmp
>   GEN     ppcemb-softmmu/config-devices.mak.tmp
>   GEN     or1k-softmmu/config-devices.mak
>   GEN     mips-softmmu/config-devices.mak
>   GEN     ppc-softmmu/config-devices.mak.tmp
>   GEN     riscv32-softmmu/config-devices.mak.tmp
>   GEN     ppc64-softmmu/config-devices.mak
>   GEN     riscv64-softmmu/config-devices.mak.tmp
>   GEN     riscv32-softmmu/config-devices.mak
>   GEN     ppcemb-softmmu/config-devices.mak
>   GEN     s390x-softmmu/config-devices.mak.tmp
>   GEN     sh4eb-softmmu/config-devices.mak.tmp
>   GEN     ppc-softmmu/config-devices.mak
>   GEN     s390x-softmmu/config-devices.mak
>   GEN     riscv64-softmmu/config-devices.mak
>   GEN     sh4-softmmu/config-devices.mak.tmp
>   GEN     sparc64-softmmu/config-devices.mak.tmp
>   GEN     sparc-softmmu/config-devices.mak.tmp
>   GEN     sh4eb-softmmu/config-devices.mak
>   GEN     sparc-softmmu/config-devices.mak
>   GEN     tricore-softmmu/config-devices.mak.tmp
>   GEN     unicore32-softmmu/config-devices.mak.tmp
>   GEN     sh4-softmmu/config-devices.mak
>   GEN     x86_64-softmmu/config-devices.mak.tmp
>   GEN     tricore-softmmu/config-devices.mak
>   GEN     sparc64-softmmu/config-devices.mak
>   GEN     unicore32-softmmu/config-devices.mak
>   GEN     xtensaeb-softmmu/config-devices.mak.tmp
>   GEN     xtensa-softmmu/config-devices.mak.tmp
>   GEN     aarch64_be-linux-user/config-devices.mak.tmp
>   GEN     xtensaeb-softmmu/config-devices.mak
>   GEN     aarch64_be-linux-user/config-devices.mak
>   GEN     aarch64-linux-user/config-devices.mak.tmp
>   GEN     xtensa-softmmu/config-devices.mak
>   GEN     alpha-linux-user/config-devices.mak.tmp
>   GEN     x86_64-softmmu/config-devices.mak
>   GEN     armeb-linux-user/config-devices.mak.tmp
>   GEN     arm-linux-user/config-devices.mak.tmp
>   GEN     aarch64-linux-user/config-devices.mak
>   GEN     armeb-linux-user/config-devices.mak
>   GEN     alpha-linux-user/config-devices.mak
>   GEN     cris-linux-user/config-devices.mak.tmp
>   GEN     hppa-linux-user/config-devices.mak.tmp
>   GEN     i386-linux-user/config-devices.mak.tmp
>   GEN     arm-linux-user/config-devices.mak
>   GEN     cris-linux-user/config-devices.mak
>   GEN     m68k-linux-user/config-devices.mak.tmp
>   GEN     microblazeel-linux-user/config-devices.mak.tmp
>   GEN     hppa-linux-user/config-devices.mak
>   GEN     microblaze-linux-user/config-devices.mak.tmp
>   GEN     i386-linux-user/config-devices.mak
>   GEN     microblazeel-linux-user/config-devices.mak
>   GEN     m68k-linux-user/config-devices.mak
>   GEN     mips64el-linux-user/config-devices.mak.tmp
>   GEN     microblaze-linux-user/config-devices.mak
>   GEN     mips64-linux-user/config-devices.mak.tmp
>   GEN     mipsel-linux-user/config-devices.mak.tmp
>   GEN     mips-linux-user/config-devices.mak.tmp
>   GEN     mips64el-linux-user/config-devices.mak
>   GEN     mips64-linux-user/config-devices.mak
>   GEN     mipsel-linux-user/config-devices.mak
>   GEN     mipsn32el-linux-user/config-devices.mak.tmp
>   GEN     mipsn32-linux-user/config-devices.mak.tmp
>   GEN     nios2-linux-user/config-devices.mak.tmp
>   GEN     mips-linux-user/config-devices.mak
>   GEN     mipsn32-linux-user/config-devices.mak
>   GEN     ppc64abi32-linux-user/config-devices.mak.tmp
>   GEN     or1k-linux-user/config-devices.mak.tmp
>   GEN     mipsn32el-linux-user/config-devices.mak
>   GEN     nios2-linux-user/config-devices.mak
>   GEN     ppc64le-linux-user/config-devices.mak.tmp
>   GEN     ppc64-linux-user/config-devices.mak.tmp
>   GEN     ppc64abi32-linux-user/config-devices.mak
>   GEN     ppc64-linux-user/config-devices.mak
>   GEN     ppc64le-linux-user/config-devices.mak
>   GEN     or1k-linux-user/config-devices.mak
>   GEN     ppc-linux-user/config-devices.mak.tmp
>   GEN     riscv32-linux-user/config-devices.mak.tmp
>   GEN     riscv64-linux-user/config-devices.mak.tmp
>   GEN     s390x-linux-user/config-devices.mak.tmp
>   GEN     riscv32-linux-user/config-devices.mak
>   GEN     ppc-linux-user/config-devices.mak
>   GEN     s390x-linux-user/config-devices.mak
>   GEN     sh4eb-linux-user/config-devices.mak.tmp
>   GEN     riscv64-linux-user/config-devices.mak
>   GEN     sh4-linux-user/config-devices.mak.tmp
>   GEN     sparc32plus-linux-user/config-devices.mak.tmp
>   GEN     sparc64-linux-user/config-devices.mak.tmp
>   GEN     sh4eb-linux-user/config-devices.mak
>   GEN     sh4-linux-user/config-devices.mak
>   GEN     sparc64-linux-user/config-devices.mak
>   GEN     sparc-linux-user/config-devices.mak.tmp
>   GEN     sparc32plus-linux-user/config-devices.mak
>   GEN     tilegx-linux-user/config-devices.mak.tmp
>   GEN     x86_64-linux-user/config-devices.mak.tmp
>   GEN     xtensaeb-linux-user/config-devices.mak.tmp
>   GEN     sparc-linux-user/config-devices.mak
>   GEN     tilegx-linux-user/config-devices.mak
>   GEN     xtensa-linux-user/config-devices.mak.tmp
>   GEN     xtensaeb-linux-user/config-devices.mak
>   GEN     x86_64-linux-user/config-devices.mak
>   GEN     config-host.h
>   GIT     ui/keycodemapdb capstone
>   GEN     xtensa-linux-user/config-devices.mak
>   GEN     qemu-options.def
>   GEN     qapi-gen
>   GEN     trace/generated-tcg-tracers.h
>   GEN     trace/generated-helpers-wrappers.h
>   GEN     trace/generated-helpers.h
>   GEN     trace/generated-helpers.c
>   GEN     module_block.h
>   GEN     tests/test-qapi-gen
>   GEN     trace-root.h
>   GEN     util/trace.h
>   GEN     crypto/trace.h
>   GEN     io/trace.h
>   GEN     migration/trace.h
> Submodule 'capstone' (git://git.qemu.org/capstone.git) registered for pat=
h 'capstone'
> Submodule 'ui/keycodemapdb' (git://git.qemu.org/keycodemapdb.git) registe=
red for path 'ui/keycodemapdb'
> Cloning into '/var/tmp/patchew-tester-tmp-2l7s8dte/src/capstone'...
>   GEN     block/trace.h
>   GEN     chardev/trace.h
>   GEN     hw/block/trace.h
>   GEN     hw/block/dataplane/trace.h
>   GEN     hw/char/trace.h
>   GEN     hw/intc/trace.h
>   GEN     hw/net/trace.h
>   GEN     hw/rdma/trace.h
>   GEN     hw/rdma/vmw/trace.h
>   GEN     hw/virtio/trace.h
>   GEN     hw/audio/trace.h
>   GEN     hw/misc/trace.h
>   GEN     hw/misc/macio/trace.h
>   GEN     hw/usb/trace.h
>   GEN     hw/scsi/trace.h
>   GEN     hw/nvram/trace.h
>   GEN     hw/display/trace.h
>   GEN     hw/input/trace.h
>   GEN     hw/timer/trace.h
>   GEN     hw/dma/trace.h
>   GEN     hw/sparc/trace.h
>   GEN     hw/sparc64/trace.h
>   GEN     hw/sd/trace.h
>   GEN     hw/isa/trace.h
>   GEN     hw/mem/trace.h
>   GEN     hw/i386/trace.h
>   GEN     hw/i386/xen/trace.h
>   GEN     hw/9pfs/trace.h
>   GEN     hw/ppc/trace.h
>   GEN     hw/pci/trace.h
>   GEN     hw/pci-host/trace.h
>   GEN     hw/s390x/trace.h
>   GEN     hw/vfio/trace.h
>   GEN     hw/acpi/trace.h
>   GEN     hw/arm/trace.h
>   GEN     hw/alpha/trace.h
>   GEN     hw/hppa/trace.h
>   GEN     hw/xen/trace.h
>   GEN     hw/ide/trace.h
>   GEN     hw/tpm/trace.h
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
>   GEN     qapi/trace.h
>   GEN     accel/tcg/trace.h
>   GEN     accel/kvm/trace.h
>   GEN     nbd/trace.h
>   GEN     scsi/trace.h
>   GEN     trace-root.c
>   GEN     util/trace.c
>   GEN     crypto/trace.c
>   GEN     io/trace.c
>   GEN     migration/trace.c
>   GEN     block/trace.c
>   GEN     chardev/trace.c
>   GEN     hw/block/trace.c
>   GEN     hw/block/dataplane/trace.c
>   GEN     hw/char/trace.c
>   GEN     hw/intc/trace.c
>   GEN     hw/net/trace.c
>   GEN     hw/rdma/trace.c
>   GEN     hw/rdma/vmw/trace.c
>   GEN     hw/virtio/trace.c
>   GEN     hw/audio/trace.c
>   GEN     hw/misc/trace.c
>   GEN     hw/misc/macio/trace.c
>   GEN     hw/usb/trace.c
>   GEN     hw/scsi/trace.c
>   GEN     hw/nvram/trace.c
>   GEN     hw/display/trace.c
>   GEN     hw/input/trace.c
>   GEN     hw/timer/trace.c
>   GEN     hw/dma/trace.c
>   GEN     hw/sparc/trace.c
>   GEN     hw/sparc64/trace.c
>   GEN     hw/sd/trace.c
>   GEN     hw/isa/trace.c
>   GEN     hw/mem/trace.c
>   GEN     hw/i386/trace.c
>   GEN     hw/i386/xen/trace.c
>   GEN     hw/9pfs/trace.c
>   GEN     hw/ppc/trace.c
>   GEN     hw/pci/trace.c
>   GEN     hw/pci-host/trace.c
>   GEN     hw/s390x/trace.c
>   GEN     hw/vfio/trace.c
>   GEN     hw/acpi/trace.c
>   GEN     hw/arm/trace.c
>   GEN     hw/alpha/trace.c
>   GEN     hw/hppa/trace.c
>   GEN     hw/xen/trace.c
>   GEN     hw/ide/trace.c
>   GEN     hw/tpm/trace.c
>   GEN     ui/trace.c
>   GEN     audio/trace.c
>   GEN     net/trace.c
>   GEN     target/arm/trace.c
>   GEN     target/i386/trace.c
>   GEN     target/mips/trace.c
>   GEN     target/sparc/trace.c
>   GEN     target/s390x/trace.c
>   GEN     target/ppc/trace.c
>   GEN     qom/trace.c
>   GEN     linux-user/trace.c
>   GEN     qapi/trace.c
>   GEN     accel/tcg/trace.c
>   GEN     accel/kvm/trace.c
>   GEN     nbd/trace.c
>   GEN     scsi/trace.c
>   GEN     config-all-devices.mak
> Cloning into '/var/tmp/patchew-tester-tmp-2l7s8dte/src/ui/keycodemapdb'...
>   GEN     ui/input-keymap-atset1-to-qcode.c
>   GEN     ui/input-keymap-linux-to-qcode.c
>   GEN     ui/input-keymap-qcode-to-atset1.c
>   GEN     ui/input-keymap-qcode-to-atset2.c
>   GEN     ui/input-keymap-qcode-to-atset3.c
>   GEN     ui/input-keymap-qcode-to-linux.c
>   GEN     ui/input-keymap-qcode-to-qnum.c
>   CC      cs.o
>   GEN     ui/input-keymap-qcode-to-sun.c
>   GEN     ui/input-keymap-qnum-to-qcode.c
>   GEN     ui/input-keymap-usb-to-qcode.c
>   GEN     ui/input-keymap-win32-to-qcode.c
>   GEN     ui/input-keymap-x11-to-qcode.c
>   GEN     ui/input-keymap-xorgevdev-to-qcode.c
>   CC      utils.o
>   GEN     ui/input-keymap-xorgkbd-to-qcode.c
>   GEN     ui/input-keymap-xorgxquartz-to-qcode.c
>   GEN     ui/input-keymap-xorgxwin-to-qcode.c
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
> ar: creating /var/tmp/patchew-tester-tmp-2l7s8dte/src/build/capstone/libc=
apstone.a
>   CC      tests/qemu-iotests/socket_scm_helper.o
>   GEN     qemu-options.texi
>   GEN     docs/version.texi
>   GEN     qemu-img-cmds.texi
>   GEN     qemu-monitor.texi
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
>   CC      qapi/qapi-types-job.o
>   CC      qapi/qapi-types-migration.o
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
>   CC      util/uuid.o
>   CC      util/throttle.o
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
>   CC      util/trace.o
>   CC      crypto/trace.o
>   CC      io/trace.o
>   CC      migration/trace.o
>   CC      block/trace.o
>   CC      chardev/trace.o
>   CC      hw/block/trace.o
>   CC      hw/block/dataplane/trace.o
>   CC      hw/char/trace.o
>   CC      hw/intc/trace.o
>   CC      hw/net/trace.o
>   CC      hw/rdma/trace.o
>   CC      hw/rdma/vmw/trace.o
>   CC      hw/virtio/trace.o
>   CC      hw/audio/trace.o
>   CC      hw/misc/trace.o
>   CC      hw/misc/macio/trace.o
>   CC      hw/usb/trace.o
>   CC      hw/scsi/trace.o
>   CC      hw/nvram/trace.o
>   CC      hw/display/trace.o
>   CC      hw/input/trace.o
>   CC      hw/timer/trace.o
>   CC      hw/dma/trace.o
>   CC      hw/sparc/trace.o
>   CC      hw/sparc64/trace.o
>   CC      hw/sd/trace.o
>   CC      hw/isa/trace.o
>   CC      hw/mem/trace.o
>   CC      hw/i386/trace.o
>   CC      hw/i386/xen/trace.o
>   CC      hw/9pfs/trace.o
>   CC      hw/ppc/trace.o
>   CC      hw/pci/trace.o
>   CC      hw/pci-host/trace.o
>   CC      hw/vfio/trace.o
>   CC      hw/s390x/trace.o
>   CC      hw/acpi/trace.o
>   CC      hw/arm/trace.o
>   CC      hw/alpha/trace.o
>   CC      hw/hppa/trace.o
>   CC      hw/xen/trace.o
>   CC      hw/ide/trace.o
>   CC      hw/tpm/trace.o
>   CC      ui/trace.o
>   CC      audio/trace.o
>   CC      net/trace.o
>   CC      target/arm/trace.o
>   CC      target/i386/trace.o
>   CC      target/mips/trace.o
>   CC      target/sparc/trace.o
>   CC      target/s390x/trace.o
>   CC      target/ppc/trace.o
>   CC      qom/trace.o
>   CC      linux-user/trace.o
>   CC      qapi/trace.o
>   CC      accel/tcg/trace.o
>   CC      accel/kvm/trace.o
>   CC      nbd/trace.o
>   CC      scsi/trace.o
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
> /var/tmp/patchew-tester-tmp-2l7s8dte/src/block/iscsi.c: In function =E2=
=80=98iscsi_populate_target_desc=E2=80=99:
> /var/tmp/patchew-tester-tmp-2l7s8dte/src/block/iscsi.c:2242:15: error: =
=E2=80=98IDENT_DESCR_TGT_DESCR=E2=80=99 undeclared (first use in this funct=
ion); did you mean =E2=80=98IDENT_DESCR_TGT_DESCR_SIZE=E2=80=99?
>      desc[0] =3D IDENT_DESCR_TGT_DESCR;

Apparently I lost this change when doing rebase -i (and then only tested F28
compile).  Should be

       desc[0] =3D 0xE4; /* IDENT_DESCR_TGT_DESCR */

Fam
