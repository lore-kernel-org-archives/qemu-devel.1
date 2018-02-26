Received: from eggs.gnu.org ([2001:4830:134:3::10]:35704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eqDeZ-00005G-NK
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 02:57:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eqDeP-000180-Ru
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 02:56:55 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39854 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eqDeP-00017U-8S
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 02:56:45 -0500
Date: Mon, 26 Feb 2018 15:56:26 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180226075626.GB21035@lemon.usersys.redhat.com>
References: <20180226070311.10057-1-famz@redhat.com>
	<151962902323.1087.13965193861426943419@bdbb90650ae5>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <151962902323.1087.13965193861426943419@bdbb90650ae5>
Subject: Re: [Qemu-devel] [PATCH 0/2] slirp: Add query-usernet QMP command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com, armbru@redhat.com, samuel.thibault@ens-lyon.org

On Sun, 02/25 23:10, no-reply@patchew.org wrote:
> Hi,
>=20
> This series failed build test on s390x host. Please find the details belo=
w.
>=20
> Type: series
> Message-id: 20180226070311.10057-1-famz@redhat.com
> Subject: [Qemu-devel] [PATCH 0/2] slirp: Add query-usernet QMP command
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
>  t [tag update]            patchew/1519533358-13759-1-git-send-email-suha=
ng16@mails.ucas.ac.cn -> patchew/1519533358-13759-1-git-send-email-suhang16=
@mails.ucas.ac.cn
>  * [new tag]               patchew/20180226070311.10057-1-famz@redhat.com=
 -> patchew/20180226070311.10057-1-famz@redhat.com
> Switched to a new branch 'test'
> 0069927f29 tests: Use query-usernet instead of 'info usernet'
> 085ab77db6 slirp: Add "query-usernet" QMP command
>=20
> =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
> =3D=3D=3D ENV =3D=3D=3D
> LANG=3Den_US.UTF-8
> XDG_SESSION_ID=3D73208
> USER=3Dfam
> PWD=3D/var/tmp/patchew-tester-tmp-5g645hxd/src
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
> freetype-2.7.1-9.fc26.s390x
> libSM-1.2.2-5.fc26.s390x
> libmpc-1.0.2-6.fc26.s390x
> libaio-0.3.110-7.fc26.s390x
> libverto-0.2.6-7.fc26.s390x
> perl-Scalar-List-Utils-1.48-1.fc26.s390x
> iptables-libs-1.6.1-2.fc26.s390x
> perl-threads-shared-1.57-1.fc26.s390x
> p11-kit-trust-0.23.9-2.fc26.s390x
> tcl-8.6.6-2.fc26.s390x
> libxshmfence-1.2-4.fc26.s390x
> expect-5.45-23.fc26.s390x
> perl-Thread-Queue-3.12-1.fc26.noarch
> perl-encoding-2.19-6.fc26.s390x
> keyutils-1.5.10-1.fc26.s390x
> gmp-devel-6.1.2-4.fc26.s390x
> enchant-1.6.0-16.fc26.s390x
> net-snmp-libs-5.7.3-17.fc26.s390x
> python-gobject-base-3.24.1-1.fc26.s390x
> python3-distro-1.0.3-1.fc26.noarch
> python3-enchant-1.6.10-1.fc26.noarch
> python-lockfile-0.11.0-6.fc26.noarch
> python2-pyparsing-2.1.10-3.fc26.noarch
> python2-lxml-4.1.1-1.fc26.s390x
> librados2-10.2.7-2.fc26.s390x
> trousers-lib-0.3.13-7.fc26.s390x
> libpaper-1.1.24-14.fc26.s390x
> libdatrie-0.2.9-4.fc26.s390x
> libsoup-2.58.2-1.fc26.s390x
> passwd-0.79-9.fc26.s390x
> bind99-libs-9.9.10-3.P3.fc26.s390x
> python3-rpm-4.13.0.2-1.fc26.s390x
> mock-core-configs-27.4-1.fc26.noarch
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
> ccache-3.3.4-1.fc26.s390x
> glibc-static-2.25-12.fc26.s390x
> mc-4.8.19-5.fc26.s390x
> doxygen-1.8.13-9.fc26.s390x
> dpkg-1.18.24-1.fc26.s390x
> libtdb-1.3.13-1.fc26.s390x
> python2-pynacl-1.1.1-1.fc26.s390x
> nss-sysinit-3.34.0-1.0.fc26.s390x
> kernel-4.13.16-202.fc26.s390x
> perl-Filter-1.58-1.fc26.s390x
> python2-pip-9.0.1-11.fc26.noarch
> dnf-2.7.5-2.fc26.noarch
> pcre2-utf16-10.23-11.fc26.s390x
> glusterfs-devel-3.10.8-1.fc26.s390x
> sssd-common-1.16.0-4.fc26.s390x
> python2-sssdconfig-1.16.0-4.fc26.noarch
> acpica-tools-20171110-1.fc26.s390x
> glibc-debuginfo-2.24-10.fc25.s390x
> fedora-repos-26-1.noarch
> dejavu-fonts-common-2.35-4.fc26.noarch
> bind99-license-9.9.10-3.P3.fc26.noarch
> ncurses-libs-6.0-8.20170212.fc26.s390x
> libpng-1.6.28-2.fc26.s390x
> libICE-1.0.9-9.fc26.s390x
> kmod-24-1.fc26.s390x
> libseccomp-2.3.2-1.fc26.s390x
> perl-Text-ParseWords-3.30-366.fc26.noarch
> libtool-ltdl-2.4.6-17.fc26.s390x
> perl-threads-2.16-1.fc26.s390x
> libselinux-utils-2.6-7.fc26.s390x
> userspace-rcu-0.9.3-2.fc26.s390x
> libXfont-1.5.2-5.fc26.s390x
> perl-Class-Inspector-1.31-3.fc26.noarch
> perl-open-1.10-395.fc26.noarch
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
> pcre-utf16-8.41-3.fc26.s390x
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
> libtasn1-devel-4.12-1.fc26.s390x
> libglvnd-core-devel-1.0.0-1.fc26.s390x
> SDL2-devel-2.0.7-2.fc26.s390x
> webkitgtk3-2.4.11-5.fc26.s390x
> grubby-8.40-4.fc26.s390x
> uboot-tools-2017.05-4.fc26.s390x
> cracklib-dicts-2.9.6-5.fc26.s390x
> texinfo-6.3-3.fc26.s390x
> time-1.7-52.fc26.s390x
> python2-deltarpm-3.6-19.fc26.s390x
> nss-3.34.0-1.0.fc26.s390x
> webkitgtk4-2.18.3-1.fc26.s390x
> net-tools-2.0-0.43.20160912git.fc26.s390x
> python2-setuptools-37.0.0-1.fc26.noarch
> python2-dnf-2.7.5-2.fc26.noarch
> pcre2-10.23-11.fc26.s390x
> groff-base-1.22.3-10.fc26.s390x
> python2-devel-2.7.14-4.fc26.s390x
> python2-GitPython-2.1.7-2.fc26.noarch
> boost-iostreams-1.63.0-10.fc26.s390x
> gpg-pubkey-efe550f5-5220ba41
> gpg-pubkey-81b46521-55b3ca9a
> filesystem-3.2-40.fc26.s390x
> basesystem-11-3.fc26.noarch
> js-jquery-3.2.1-1.fc26.noarch
> pcre-8.41-3.fc26.s390x
> elfutils-libelf-0.169-1.fc26.s390x
> libidn-1.33-2.fc26.s390x
> libogg-1.3.2-6.fc26.s390x
> slang-2.3.1a-2.fc26.s390x
> apr-1.6.3-1.fc26.s390x
> libxkbcommon-0.7.1-3.fc26.s390x
> perl-IO-1.36-395.fc26.s390x
> libvorbis-1.3.5-2.fc26.s390x
> less-487-3.fc26.s390x
> lttng-ust-2.9.0-2.fc26.s390x
> OpenEXR-libs-2.2.0-6.fc26.s390x
> ipset-libs-6.29-3.fc26.s390x
> perl-XML-XPath-1.42-1.fc26.noarch
> lua-filesystem-1.6.3-3.fc24.s390x
> sqlite-3.20.1-1.fc26.s390x
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
> krb5-workstation-1.15.2-4.fc26.s390x
> python3-requests-kerberos-0.10.0-4.fc26.noarch
> gpgme-1.8.0-12.fc26.s390x
> python2-gpg-1.8.0-12.fc26.s390x
> shadow-utils-4.3.1-3.fc26.s390x
> cryptsetup-libs-1.7.5-1.fc26.s390x
> kpartx-0.4.9-88.fc26.s390x
> net-snmp-agent-libs-5.7.3-17.fc26.s390x
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
> nspr-devel-4.17.0-1.fc26.s390x
> ghostscript-x11-9.20-10.fc26.s390x
> libXrender-devel-0.9.10-2.fc26.s390x
> libxkbcommon-devel-0.7.1-3.fc26.s390x
> mesa-libGL-devel-17.2.4-2.fc26.s390x
> sqlite-devel-3.20.1-1.fc26.s390x
> usbredir-devel-0.7.1-3.fc26.s390x
> libcap-devel-2.25-5.fc26.s390x
> brlapi-devel-0.6.6-5.fc26.s390x
> fedora-upgrade-27.1-1.fc26.noarch
> python3-pygpgme-0.3-22.fc26.s390x
> pinentry-0.9.7-3.fc26.s390x
> perl-Test-Harness-3.39-1.fc26.noarch
> qemu-sanity-check-nodeps-1.1.5-6.fc26.s390x
> libldb-1.1.29-5.fc26.s390x
> python-libxml2-2.9.4-2.fc26.s390x
> nss-util-devel-3.34.0-1.0.fc26.s390x
> vim-filesystem-8.0.1360-1.fc26.s390x
> webkitgtk4-plugin-process-gtk2-2.18.3-1.fc26.s390x
> python2-2.7.14-4.fc26.s390x
> libwayland-cursor-1.13.0-3.fc26.s390x
> mariadb-config-10.1.29-1.fc26.s390x
> gdb-headless-8.0.1-33.fc26.s390x
> pulseaudio-libs-devel-11.1-7.fc26.s390x
> curl-7.53.1-13.fc26.s390x
> json-c-0.12.1-5.fc26.s390x
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
> perl-5.24.3-395.fc26.s390x
> libnl3-cli-3.3.0-1.fc26.s390x
> gpm-libs-1.20.7-10.fc26.s390x
> libgo-7.2.1-2.fc26.s390x
> iso-codes-3.74-2.fc26.noarch
> ipset-6.29-3.fc26.s390x
> lua-term-0.07-1.fc25.s390x
> libdb-utils-5.3.28-24.fc26.s390x
> system-python-libs-3.6.3-2.fc26.s390x
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
> elfutils-0.169-1.fc26.s390x
> cyrus-sasl-lib-2.1.26-32.fc26.s390x
> libkadm5-1.15.2-4.fc26.s390x
> python3-kerberos-1.2.5-3.fc26.s390x
> rpmconf-1.0.19-1.fc26.noarch
> libsemanage-2.6-4.fc26.s390x
> device-mapper-libs-1.02.137-6.fc26.s390x
> yum-3.4.3-512.fc26.noarch
> device-mapper-multipath-0.4.9-88.fc26.s390x
> net-snmp-5.7.3-17.fc26.s390x
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
> webkitgtk4-jsc-2.18.3-1.fc26.s390x
> vim-common-8.0.1360-1.fc26.s390x
> nss-tools-3.34.0-1.0.fc26.s390x
> glusterfs-api-3.10.8-1.fc26.s390x
> pulseaudio-libs-glib2-11.1-7.fc26.s390x
> mariadb-common-10.1.29-1.fc26.s390x
> dhcp-libs-4.3.5-10.fc26.s390x
> pcre2-devel-10.23-11.fc26.s390x
> libtiff-4.0.9-1.fc26.s390x
> kernel-headers-4.14.8-200.fc26.s390x
> fontpackages-filesystem-1.44-18.fc26.noarch
> vte-profile-0.48.4-1.fc26.s390x
> texlive-kpathsea-doc-svn41139-33.fc26.2.noarch
> zlib-1.2.11-2.fc26.s390x
> readline-7.0-5.fc26.s390x
> libattr-2.4.47-18.fc26.s390x
> libgomp-7.2.1-2.fc26.s390x
> libglvnd-1.0.0-1.fc26.s390x
> lz4-libs-1.8.0-1.fc26.s390x
> libcrypt-nss-2.25-12.fc26.s390x
> jansson-2.10-2.fc26.s390x
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
> elfutils-libs-0.169-1.fc26.s390x
> krb5-libs-1.15.2-4.fc26.s390x
> libuser-0.62-6.fc26.s390x
> python2-requests-kerberos-0.10.0-4.fc26.noarch
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
> elfutils-libelf-devel-0.169-1.fc26.s390x
> gc-devel-7.6.0-2.fc26.s390x
> libXft-devel-2.3.2-5.fc26.s390x
> krb5-devel-1.15.2-4.fc26.s390x
> rpm-devel-4.13.0.2-1.fc26.s390x
> pcre-static-8.41-3.fc26.s390x
> bluez-libs-devel-5.46-6.fc26.s390x
> systemtap-3.2-2.fc26.s390x
> trousers-0.3.13-7.fc26.s390x
> iproute-tc-4.11.0-1.fc26.s390x
> python2-sphinx-1.5.5-1.fc26.noarch
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
> python3-sssdconfig-1.16.0-4.fc26.noarch
> python2-py-1.4.34-1.fc26.noarch
> gpg-pubkey-95a43f54-5284415a
> gpg-pubkey-fdb19c98-56fd6333
> gpg-pubkey-64dab85d-57d33e22
> tzdata-2017c-1.fc26.noarch
> firewalld-filesystem-0.4.4.5-1.fc26.noarch
> xkeyboard-config-2.21-3.fc26.noarch
> texlive-texlive-common-doc-svn40682-33.fc26.2.noarch
> ncurses-base-6.0-8.20170212.fc26.noarch
> libselinux-2.6-7.fc26.s390x
> bzip2-libs-1.0.6-22.fc26.s390x
> libdb-5.3.28-24.fc26.s390x
> mpfr-3.1.5-3.fc26.s390x
> file-libs-5.30-11.fc26.s390x
> libunistring-0.9.7-1.fc26.s390x
> libxslt-1.1.29-1.fc26.s390x
> libtasn1-4.12-1.fc26.s390x
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
> rsync-3.1.2-5.fc26.s390x
> libiscsi-1.15.0-3.fc26.s390x
> ttmkfdir-3.0.9-49.fc26.s390x
> texlive-base-2016-33.20160520.fc26.1.noarch
> python2-six-1.10.0-9.fc26.noarch
> atk-2.24.0-1.fc26.s390x
> python2-kitchen-1.2.4-6.fc26.noarch
> guile-2.0.14-1.fc26.s390x
> desktop-file-utils-0.23-3.fc26.s390x
> pyxattr-0.5.3-10.fc26.s390x
> shared-mime-info-1.8-2.fc26.s390x
> libyaml-0.1.7-2.fc26.s390x
> python3-PyYAML-3.12-3.fc26.s390x
> openssh-7.5p1-4.fc26.s390x
> kernel-core-4.13.16-202.fc26.s390x
> perl-Git-2.13.6-2.fc26.noarch
> python3-dnf-plugins-extras-common-2.0.4-1.fc26.noarch
> openssl-1.1.0g-1.fc26.s390x
> gawk-4.1.4-6.fc26.s390x
> gnutls-3.5.16-4.fc26.s390x
> openldap-2.4.45-2.fc26.s390x
> bind-license-9.11.1-4.P3.fc26.noarch
> python2-gluster-3.10.8-1.fc26.s390x
> selinux-policy-3.13.1-260.17.fc26.noarch
> linux-firmware-20171215-81.git2451bb22.fc26.noarch
> libpkgconf-1.3.12-1.fc26.s390x
> NetworkManager-libnm-1.8.2-4.fc26.s390x
> gnutls-devel-3.5.16-4.fc26.s390x
> mariadb-libs-10.1.29-1.fc26.s390x
> python2-urllib3-1.20-2.fc26.noarch
> sssd-nfs-idmap-1.16.0-4.fc26.s390x
> libsss_sudo-1.16.0-4.fc26.s390x
> python3-py-1.4.34-1.fc26.noarch
> libgudev-232-1.fc26.s390x
> python3-libs-3.6.3-2.fc26.s390x
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
> elfutils-default-yama-scope-0.169-1.fc26.noarch
> GeoIP-GeoLite-data-2017.10-1.fc26.noarch
> libedit-3.1-17.20160618cvs.fc26.s390x
> libverto-libev-0.2.6-7.fc26.s390x
> libserf-1.3.9-3.fc26.s390x
> createrepo_c-0.10.0-9.fc26.s390x
> python2-kerberos-1.2.5-3.fc26.s390x
> libsrtp-1.5.4-4.fc26.s390x
> lzo-minilzo-2.08-9.fc26.s390x
> librepo-1.8.0-1.fc26.s390x
> koji-1.14.0-1.fc26.noarch
> sg3_utils-1.42-1.fc26.s390x
> libobjc-7.2.1-2.fc26.s390x
> policycoreutils-2.6-6.fc26.s390x
> libdrm-2.4.88-1.fc26.s390x
> kernel-core-4.13.13-200.fc26.s390x
> systemtap-client-3.2-2.fc26.s390x
> lvm2-2.02.168-6.fc26.s390x
> device-mapper-multipath-libs-0.4.9-88.fc26.s390x
> libfdt-1.4.5-1.fc26.s390x
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
> pcre-devel-8.41-3.fc26.s390x
> mesa-libwayland-egl-devel-17.2.4-2.fc26.s390x
> ghostscript-9.20-10.fc26.s390x
> libcephfs_jni-devel-10.2.7-2.fc26.s390x
> libXdamage-devel-1.1.4-9.fc26.s390x
> freetype-devel-2.7.1-9.fc26.s390x
> ncurses-devel-6.0-8.20170212.fc26.s390x
> fontconfig-devel-2.12.6-4.fc26.s390x
> cairo-devel-1.14.10-1.fc26.s390x
> libselinux-devel-2.6-7.fc26.s390x
> guile-devel-2.0.14-1.fc26.s390x
> libcap-ng-devel-0.7.8-3.fc26.s390x
> bash-completion-2.6-1.fc26.noarch
> libXevie-1.0.3-12.fc26.s390x
> kernel-4.13.13-200.fc26.s390x
> audit-2.8.1-1.fc26.s390x
> gcc-objc-7.2.1-2.fc26.s390x
> gcc-go-7.2.1-2.fc26.s390x
> python-firewall-0.4.4.5-1.fc26.noarch
> python3-html5lib-0.999-13.fc26.noarch
> python2-simplejson-3.10.0-3.fc26.s390x
> flex-2.6.1-3.fc26.s390x
> telnet-0.17-69.fc26.s390x
> gpg-pubkey-8e1431d5-53bcbac7
> emacs-filesystem-25.3-3.fc26.noarch
> fontawesome-fonts-4.7.0-2.fc26.noarch
> fontawesome-fonts-web-4.7.0-2.fc26.noarch
> tzdata-java-2017c-1.fc26.noarch
> rpmconf-base-1.0.19-1.fc26.noarch
> glibc-2.25-12.fc26.s390x
> info-6.3-3.fc26.s390x
> sqlite-libs-3.20.1-1.fc26.s390x
> texlive-lib-2016-33.20160520.fc26.1.s390x
> sed-4.4-1.fc26.s390x
> libicu-57.1-7.fc26.s390x
> libcap-ng-0.7.8-3.fc26.s390x
> nettle-3.3-2.fc26.s390x
> libidn2-2.0.4-1.fc26.s390x
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
> libstdc++-devel-7.2.1-2.fc26.s390x
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
> libtalloc-2.1.10-2.fc26.s390x
> libdhash-0.5.0-34.fc26.s390x
> python2-bcrypt-3.1.4-2.fc26.s390x
> PyYAML-3.12-3.fc26.s390x
> nss-softokn-freebl-3.34.0-1.0.fc26.s390x
> kernel-modules-4.13.16-202.fc26.s390x
> git-2.13.6-2.fc26.s390x
> gnupg2-smime-2.2.3-1.fc26.s390x
> openssl-devel-1.1.0g-1.fc26.s390x
> python2-dnf-plugins-extras-common-2.0.4-1.fc26.noarch
> copy-jdk-configs-3.3-2.fc26.noarch
> glusterfs-client-xlators-3.10.8-1.fc26.s390x
> libcurl-7.53.1-13.fc26.s390x
> bind-libs-lite-9.11.1-4.P3.fc26.s390x
> glusterfs-extra-xlators-3.10.8-1.fc26.s390x
> python3-setuptools-37.0.0-1.fc26.noarch
> kernel-core-4.14.8-200.fc26.s390x
> pkgconf-1.3.12-1.fc26.s390x
> NetworkManager-1.8.2-4.fc26.s390x
> libjpeg-turbo-devel-1.5.3-1.fc26.s390x
> lua-5.3.4-7.fc26.s390x
> boost-thread-1.63.0-10.fc26.s390x
> wget-1.19.2-2.fc26.s390x
> libwebp-0.6.1-1.fc26.s390x
> kernel-devel-4.14.8-200.fc26.s390x
> python3-lxml-4.1.1-1.fc26.s390x
> python3-ordered-set-2.0.0-6.fc26.noarch
> python3-rpmconf-1.0.19-1.fc26.noarch
> python-offtrac-0.1.0-9.fc26.noarch
> python2-pycparser-2.14-10.fc26.noarch
> python2-sphinx-theme-alabaster-0.7.9-3.fc26.noarch
> python2-pysocks-1.6.7-1.fc26.noarch
> lua-lpeg-1.0.1-2.fc26.s390x
> poppler-0.52.0-10.fc26.s390x
> libproxy-0.4.15-2.fc26.s390x
> crontabs-1.11-14.20150630git.fc26.noarch
> java-1.8.0-openjdk-headless-1.8.0.151-1.b12.fc26.s390x
> libev-4.24-2.fc26.s390x
> libsigsegv-2.11-1.fc26.s390x
> fedora-cert-0.6.0.1-2.fc26.noarch
> drpm-0.3.0-6.fc26.s390x
> createrepo_c-libs-0.10.0-9.fc26.s390x
> python2-cccolutils-1.5-3.fc26.s390x
> m17n-lib-1.7.0-6.fc26.s390x
> lsscsi-0.28-4.fc26.s390x
> python2-koji-1.14.0-1.fc26.noarch
> python3-koji-1.14.0-1.fc26.noarch
> python3-gpg-1.8.0-12.fc26.s390x
> sg3_utils-libs-1.42-1.fc26.s390x
> SDL2-2.0.7-2.fc26.s390x
> util-linux-2.30.2-1.fc26.s390x
> rpcbind-0.2.4-8.rc2.fc26.s390x
> s390utils-mon_statd-1.36.1-3.fc26.s390x
> GConf2-3.2.6-17.fc26.s390x
> systemd-container-233-7.fc26.s390x
> usermode-1.111-9.fc26.s390x
> pcre-utf32-8.41-3.fc26.s390x
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
> urw-fonts-2.4-23.fc26.noarch
> atk-devel-2.24.0-1.fc26.s390x
> ImageMagick-libs-6.9.9.22-1.fc26.s390x
> libxcb-devel-1.12-3.fc26.s390x
> libXrandr-devel-1.5.1-2.fc26.s390x
> libcom_err-devel-1.43.4-2.fc26.s390x
> dbus-devel-1.11.18-1.fc26.s390x
> libepoxy-devel-1.4.3-1.fc26.s390x
> libicu-devel-57.1-7.fc26.s390x
> p11-kit-devel-0.23.9-2.fc26.s390x
> rpm-build-4.13.0.2-1.fc26.s390x
> libssh2-devel-1.8.0-5.fc26.s390x
> graphviz-2.40.1-4.fc26.s390x
> zlib-static-1.2.11-2.fc26.s390x
> mesa-libgbm-devel-17.2.4-2.fc26.s390x
> dracut-config-rescue-046-3.1.fc26.s390x
> screen-4.6.2-1.fc26.s390x
> python-osbs-client-0.39.1-1.fc26.noarch
> gcc-gdb-plugin-7.2.1-2.fc26.s390x
> pyparsing-2.1.10-3.fc26.noarch
> python3-pyasn1-0.2.3-1.fc26.noarch
> python2-html5lib-0.999-13.fc26.noarch
> teamd-1.27-1.fc26.s390x
> hardlink-1.3-1.fc26.s390x
> chrpath-0.16-4.fc26.s390x
> libgcc-7.2.1-2.fc26.s390x
> python-rpm-macros-3-20.fc26.noarch
> texlive-pdftex-doc-svn41149-33.fc26.2.noarch
> glibc-common-2.25-12.fc26.s390x
> libstdc++-7.2.1-2.fc26.s390x
> nspr-4.17.0-1.fc26.s390x
> grep-3.1-1.fc26.s390x
> libgcrypt-1.7.9-1.fc26.s390x
> libacl-2.2.52-15.fc26.s390x
> cpio-2.12-4.fc26.s390x
> libatomic_ops-7.4.4-2.fc26.s390x
> p11-kit-0.23.9-2.fc26.s390x
> gc-7.6.0-2.fc26.s390x
> psmisc-22.21-9.fc26.s390x
> systemd-libs-233-7.fc26.s390x
> xz-5.2.3-2.fc26.s390x
> perl-libs-5.24.3-395.fc26.s390x
> kmod-libs-24-1.fc26.s390x
> libpcap-1.8.1-3.fc26.s390x
> perl-macros-5.24.3-395.fc26.s390x
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
> perl-SelfLoader-1.23-395.fc26.noarch
> perl-Pod-Simple-3.35-2.fc26.noarch
> perl-URI-1.71-6.fc26.noarch
> cpp-7.2.1-2.fc26.s390x
> attr-2.4.47-18.fc26.s390x
> gmp-c++-6.1.2-4.fc26.s390x
> xapian-core-libs-1.4.4-1.fc26.s390x
> system-python-3.6.3-2.fc26.s390x
> harfbuzz-icu-1.4.4-1.fc26.s390x
> libtevent-0.9.34-1.fc26.s390x
> http-parser-2.7.1-5.fc26.s390x
> libsodium-1.0.14-1.fc26.s390x
> python-gssapi-1.2.0-5.fc26.s390x
> nss-softokn-3.34.0-1.0.fc26.s390x
> gnupg2-2.2.3-1.fc26.s390x
> nss-devel-3.34.0-1.0.fc26.s390x
> vim-minimal-8.0.1360-1.fc26.s390x
> perl-libnet-3.11-1.fc26.noarch
> kernel-devel-4.13.16-202.fc26.s390x
> python2-libs-2.7.14-4.fc26.s390x
> libwayland-client-1.13.0-3.fc26.s390x
> python3-dnf-2.7.5-2.fc26.noarch
> glusterfs-fuse-3.10.8-1.fc26.s390x
> pcre2-utf32-10.23-11.fc26.s390x
> kernel-modules-4.14.8-200.fc26.s390x
> pkgconf-pkg-config-1.3.12-1.fc26.s390x
> NetworkManager-ppp-1.8.2-4.fc26.s390x
> wayland-devel-1.13.0-3.fc26.s390x
> kernel-4.14.8-200.fc26.s390x
> boost-random-1.63.0-10.fc26.s390x
> libmicrohttpd-0.9.58-1.fc26.s390x
> mailx-12.5-24.fc26.s390x
> NetworkManager-glib-1.8.2-4.fc26.s390x
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
> python2-dnf-plugins-core-2.1.5-1.fc26.noarch
> qrencode-libs-3.4.4-1.fc26.s390x
> s390utils-iucvterm-1.36.1-3.fc26.s390x
> libsmartcols-2.30.2-1.fc26.s390x
> dbus-1.11.18-1.fc26.s390x
> systemd-udev-233-7.fc26.s390x
> device-mapper-event-1.02.137-6.fc26.s390x
> polkit-0.113-8.fc26.s390x
> mock-1.4.7-2.fc26.noarch
> libwmf-lite-0.2.8.4-53.fc26.s390x
> libXcomposite-0.4.4-9.fc26.s390x
> libXcursor-1.1.14-8.fc26.s390x
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
> libXcursor-devel-1.1.14-8.fc26.s390x
> graphite2-devel-1.3.10-1.fc26.s390x
> pixman-devel-0.34.0-3.fc26.s390x
> wayland-protocols-devel-1.9-1.fc26.noarch
> mesa-libGLES-devel-17.2.4-2.fc26.s390x
> redhat-rpm-config-63-1.fc26.noarch
> vte291-devel-0.48.4-1.fc26.s390x
> ceph-devel-compat-10.2.7-2.fc26.s390x
> lzo-devel-2.08-9.fc26.s390x
> libiscsi-devel-1.15.0-3.fc26.s390x
> libfdt-devel-1.4.5-1.fc26.s390x
> dnsmasq-2.76-5.fc26.s390x
> avahi-autoipd-0.6.32-7.fc26.s390x
> rpm-plugin-systemd-inhibit-4.13.0.2-1.fc26.s390x
> gcc-c++-7.2.1-2.fc26.s390x
> python2-ndg_httpsclient-0.4.0-7.fc26.noarch
> gettext-0.19.8.1-9.fc26.s390x
> btrfs-progs-4.9.1-2.fc26.s390x
> fedora-logos-26.0.1-1.fc26.s390x
> dejagnu-1.6-2.fc26.noarch
> libaio-devel-0.3.110-7.fc26.s390x
> dos2unix-7.3.4-2.fc26.s390x
> distribution-gpg-keys-1.15-1.fc26.noarch
> python-sphinx-locale-1.5.5-1.fc26.noarch
> python2-rpm-macros-3-20.fc26.noarch
> libxml2-2.9.4-2.fc26.s390x
> popt-1.16-12.fc26.s390x
> tar-1.29-5.fc26.s390x
> avahi-libs-0.6.32-7.fc26.s390x
> m4-1.4.18-3.fc26.s390x
> perl-Socket-2.024-2.fc26.s390x
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
> gtk-update-icon-cache-3.22.21-2.fc26.s390x
> python3-3.6.3-2.fc26.s390x
> python3-pyparsing-2.1.10-3.fc26.noarch
> python2-markupsafe-0.23-13.fc26.s390x
> python2-mock-2.0.0-4.fc26.noarch
> python2-yubico-1.3.2-7.fc26.noarch
> python2-smmap-2.0.3-1.fc26.noarch
> librbd-devel-10.2.7-2.fc26.s390x
> pigz-2.3.4-2.fc26.s390x
> gcc-7.2.1-2.fc26.s390x
> libnghttp2-1.21.1-1.fc26.s390x
> cups-libs-2.2.2-7.fc26.s390x
> libnfsidmap-0.27-1.fc26.s390x
> ykpers-1.18.0-2.fc26.s390x
> python3-librepo-1.8.0-1.fc26.s390x
> systemtap-runtime-3.2-2.fc26.s390x
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
> libseccomp-devel-2.3.2-1.fc26.s390x
> subversion-1.9.7-1.fc26.s390x
> sudo-1.8.21p2-1.fc26.s390x
> pykickstart-2.35-2.fc26.noarch
> e2fsprogs-1.43.4-2.fc26.s390x
> libstdc++-static-7.2.1-2.fc26.s390x
> libbsd-0.8.3-3.fc26.s390x
> c-ares-1.13.0-1.fc26.s390x
> python2-pyxdg-0.25-12.fc26.noarch
> nss-softokn-freebl-devel-3.34.0-1.0.fc26.s390x
> python2-rpkg-1.51-2.fc26.noarch
> strace-4.20-1.fc26.s390x
> valgrind-3.13.0-12.fc26.s390x
> libsss_idmap-1.16.0-4.fc26.s390x
> gnutls-c++-3.5.16-4.fc26.s390x
> libwayland-server-1.13.0-3.fc26.s390x
> dhcp-client-4.3.5-10.fc26.s390x
> bind-libs-9.11.1-4.P3.fc26.s390x
> man-pages-4.09-4.fc26.noarch
> gpg-pubkey-a29cb19c-53bcbba6
> quota-nls-4.03-9.fc26.noarch
> qt5-srpm-macros-5.8.0-2.fc26.noarch
> xz-libs-5.2.3-2.fc26.s390x
> gmp-6.1.2-4.fc26.s390x
> audit-libs-2.8.1-1.fc26.s390x
> file-5.30-11.fc26.s390x
> libusbx-1.0.21-2.fc26.s390x
> binutils-2.27-28.fc26.s390x
> perl-Errno-1.25-395.fc26.s390x
> perl-HTTP-Tiny-0.070-2.fc26.noarch
> xml-common-0.6.3-45.fc26.noarch
> opus-1.2.1-1.fc26.s390x
> kernel-devel-4.13.13-200.fc26.s390x
> perl-podlators-4.09-2.fc26.noarch
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
> python2-fedora-0.9.0-6.fc26.noarch
> librbd1-10.2.7-2.fc26.s390x
> pcre-cpp-8.41-3.fc26.s390x
> glibc-devel-2.25-12.fc26.s390x
> libnfs-1.9.8-3.fc26.s390x
> libsolv-0.6.30-2.fc26.s390x
> python3-pycurl-7.43.0-8.fc26.s390x
> libyubikey-1.13-3.fc26.s390x
> rpmlint-1.10-5.fc26.noarch
> python2-pygpgme-0.3-22.fc26.s390x
> s390utils-base-1.36.1-3.fc26.s390x
> ppp-2.4.7-11.fc26.s390x
> s390utils-cpuplugd-1.36.1-3.fc26.s390x
> nfs-utils-2.1.1-6.rc6.fc26.s390x
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
> systemtap-sdt-devel-3.2-2.fc26.s390x
> newt-python-0.52.20-1.fc26.s390x
> perl-Mozilla-CA-20160104-4.fc26.noarch
> pth-2.0.7-28.fc26.s390x
> python3-pyxdg-0.25-12.fc26.noarch
> nss-softokn-devel-3.34.0-1.0.fc26.s390x
> fedpkg-1.30-4.fc26.noarch
> timedatex-0.4-3.fc26.s390x
> libjpeg-turbo-1.5.3-1.fc26.s390x
> glusterfs-cli-3.10.8-1.fc26.s390x
> libsss_nss_idmap-1.16.0-4.fc26.s390x
> gdb-8.0.1-33.fc26.s390x
> dnf-yum-2.7.5-2.fc26.noarch
> perl-Data-Dumper-2.161-3.fc26.s390x
> python-async-0.6.1-9.fc22.s390x
> poppler-data-0.4.7-7.fc26.noarch
> ocaml-srpm-macros-4-2.fc26.noarch
> libuuid-2.30.2-1.fc26.s390x
> libgpg-error-1.25-2.fc26.s390x
> libassuan-2.4.3-2.fc26.s390x
> graphite2-1.3.10-1.fc26.s390x
> perl-Text-Tabs+Wrap-2013.0523-366.fc26.noarch
> perl-Error-0.17024-8.fc26.noarch
> which-2.21-2.fc26.s390x
> libXau-1.0.8-7.fc26.s390x
> orc-0.4.27-1.fc26.s390x
> perl-Pod-Perldoc-3.28-1.fc26.noarch
> libsndfile-1.0.28-6.fc26.s390x
> patch-2.7.5-4.fc26.s390x
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
> glibc-headers-2.25-12.fc26.s390x
> libndp-1.6-2.fc26.s390x
> rpm-4.13.0.2-1.fc26.s390x
> rest-0.8.0-2.fc26.s390x
> libvisual-0.4.0-21.fc26.s390x
> python2-hawkey-0.11.1-1.fc26.s390x
> dnf-plugins-core-2.1.5-1.fc26.noarch
> fakeroot-libs-1.22-1.fc26.s390x
> device-mapper-event-libs-1.02.137-6.fc26.s390x
> cyrus-sasl-2.1.26-32.fc26.s390x
> kernel-modules-4.13.13-200.fc26.s390x
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
> libdrm-devel-2.4.88-1.fc26.s390x
> libcephfs_jni1-10.2.7-2.fc26.s390x
> bzip2-devel-1.0.6-22.fc26.s390x
> expat-devel-2.2.4-1.fc26.s390x
> libsepol-devel-2.6-2.fc26.s390x
> glib2-static-2.52.3-2.fc26.s390x
> virglrenderer-devel-0.6.0-1.20170210git76b3da97b.fc26.s390x
> yum-utils-1.1.31-512.fc26.noarch
> parted-3.2-24.fc26.s390x
> python3-beautifulsoup4-4.6.0-1.fc26.noarch
> python-bunch-1.0.1-10.fc26.noarch
> perl-Time-HiRes-1.9746-1.fc26.s390x
> lz4-1.8.0-1.fc26.s390x
> nss-util-3.34.0-1.0.fc26.s390x
> openssh-clients-7.5p1-4.fc26.s390x
> chrony-3.2-1.fc26.s390x
> dnf-conf-2.7.5-2.fc26.noarch
> glusterfs-server-3.10.8-1.fc26.s390x
> sssd-client-1.16.0-4.fc26.s390x
> man-db-2.7.6.1-8.fc26.s390x
> bodhi-client-2.12.2-3.fc26.noarch
> perl-Module-CoreList-5.20171120-1.fc26.noarch
> hawkey-0.6.4-3.fc25.s390x
> python-srpm-macros-3-20.fc26.noarch
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
> libgo-devel-7.2.1-2.fc26.s390x
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
> dtc-1.4.5-1.fc26.s390x
> libmpcdec-1.2.6-17.fc26.s390x
> rpm-libs-4.13.0.2-1.fc26.s390x
> python-urlgrabber-3.10.1-11.fc26.noarch
> sysfsutils-2.1.0-20.fc26.s390x
> python3-hawkey-0.11.1-1.fc26.s390x
> python3-dnf-plugins-core-2.1.5-1.fc26.noarch
> ethtool-4.13-1.fc26.s390x
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
> gtk3-3.22.21-2.fc26.s390x
> libuuid-devel-2.30.2-1.fc26.s390x
> java-1.8.0-openjdk-1.8.0.151-1.b12.fc26.s390x
> libXinerama-devel-1.1.3-7.fc26.s390x
> emacs-common-25.3-3.fc26.s390x
> gtk3-devel-3.22.21-2.fc26.s390x
> fedora-packager-0.6.0.1-2.fc26.noarch
> libxml2-devel-2.9.4-2.fc26.s390x
> snappy-devel-1.1.4-3.fc26.s390x
> python2-dnf-plugin-migrate-2.1.5-1.fc26.noarch
> authconfig-7.0.1-2.fc26.s390x
> newt-python3-0.52.20-1.fc26.s390x
> python-decoratortools-1.8-13.fc26.noarch
> python-systemd-doc-234-1.fc26.s390x
> openssl-libs-1.1.0g-1.fc26.s390x
> git-core-2.13.6-2.fc26.s390x
> python3-dnf-plugin-system-upgrade-2.0.4-1.fc26.noarch
> glusterfs-libs-3.10.8-1.fc26.s390x
> ca-certificates-2017.2.20-1.0.fc26.noarch
> unbound-libs-1.6.7-1.fc26.s390x
> libsss_certmap-1.16.0-4.fc26.s390x
> glusterfs-api-devel-3.10.8-1.fc26.s390x
> selinux-policy-targeted-3.13.1-260.17.fc26.noarch
> publicsuffix-list-dafsa-20171028-1.fc26.noarch
> gpg-pubkey-a0a7badb-52844296
> gpg-pubkey-e372e838-56fd7943
> gpg-pubkey-3b921d09-57a87096
> google-roboto-slab-fonts-1.100263-0.5.20150923git.fc26.noarch
> libreport-filesystem-2.9.1-3.fc26.s390x
> glibc-all-langpacks-2.25-12.fc26.s390x
> libcom_err-1.43.4-2.fc26.s390x
> libffi-3.1-12.fc26.s390x
> keyutils-libs-1.5.10-1.fc26.s390x
> diffutils-3.5-3.fc26.s390x
> apr-util-1.5.4-6.fc26.s390x
> bluez-libs-5.46-6.fc26.s390x
> libksba-1.3.5-3.fc26.s390x
> ncurses-6.0-8.20170212.fc26.s390x
> gsm-1.0.17-1.fc26.s390x
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
> pytz-2016.10-4.fc26.noarch
> python2-requests-2.13.0-1.fc26.noarch
> libcephfs-devel-10.2.7-2.fc26.s390x
> ncurses-c++-libs-6.0-8.20170212.fc26.s390x
> GeoIP-1.6.11-1.fc26.s390x
> liblockfile-1.09-5.fc26.s390x
> rpm-plugin-selinux-4.13.0.2-1.fc26.s390x
> systemtap-devel-3.2-2.fc26.s390x
> libsysfs-2.1.0-20.fc26.s390x
> libdnf-0.11.1-1.fc26.s390x
> libgfortran-7.2.1-2.fc26.s390x
> mesa-libgbm-17.2.4-2.fc26.s390x
> dracut-046-3.1.fc26.s390x
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
> elfutils-devel-0.169-1.fc26.s390x
> libidn-devel-1.33-2.fc26.s390x
> s390utils-1.36.1-3.fc26.s390x
> gcc-gfortran-7.2.1-2.fc26.s390x
> libtool-2.4.6-17.fc26.s390x
> python3-cssselect-0.9.2-4.fc26.noarch
> python2-cssselect-0.9.2-4.fc26.noarch
> bison-3.0.4-6.fc26.s390x
> rootfiles-8.1-20.fc26.noarch
> git-core-doc-2.13.6-2.fc26.s390x
> vim-enhanced-8.0.1360-1.fc26.s390x
> glusterfs-3.10.8-1.fc26.s390x
> boost-system-1.63.0-10.fc26.s390x
> gnutls-dane-3.5.16-4.fc26.s390x
> pkgconf-m4-1.3.12-1.fc26.noarch
> libcurl-devel-7.53.1-13.fc26.s390x
> python3-urllib3-1.20-2.fc26.noarch
> libsss_autofs-1.16.0-4.fc26.s390x
> =3D=3D=3D TEST BEGIN =3D=3D=3D
> Using CC: /home/fam/bin/cc
> Install prefix    /var/tmp/patchew-tester-tmp-5g645hxd/src/install
> BIOS directory    /var/tmp/patchew-tester-tmp-5g645hxd/src/install/share/=
qemu
> firmware path     /var/tmp/patchew-tester-tmp-5g645hxd/src/install/share/=
qemu-firmware
> binary directory  /var/tmp/patchew-tester-tmp-5g645hxd/src/install/bin
> library directory /var/tmp/patchew-tester-tmp-5g645hxd/src/install/lib
> module directory  /var/tmp/patchew-tester-tmp-5g645hxd/src/install/lib/qe=
mu
> libexec directory /var/tmp/patchew-tester-tmp-5g645hxd/src/install/libexec
> include directory /var/tmp/patchew-tester-tmp-5g645hxd/src/install/include
> config directory  /var/tmp/patchew-tester-tmp-5g645hxd/src/install/etc
> local state directory   /var/tmp/patchew-tester-tmp-5g645hxd/src/install/=
var
> Manual directory  /var/tmp/patchew-tester-tmp-5g645hxd/src/install/share/=
man
> ELF interp prefix /usr/gnemul/qemu-%M
> Source path       /var/tmp/patchew-tester-tmp-5g645hxd/src
> GIT binary        git
> GIT submodules    ui/keycodemapdb capstone
> C compiler        /home/fam/bin/cc
> Host C compiler   cc
> C++ compiler      c++
> Objective-C compiler /home/fam/bin/cc
> ARFLAGS           rv
> CFLAGS            -O2 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=3D2 -g=20
> QEMU_CFLAGS       -I/usr/include/pixman-1   -Werror -DHAS_LIBSSH2_SFTP_FS=
YNC -pthread -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include  -DNCURS=
ES_WIDECHAR -D_GNU_SOURCE -D_DEFAULT_SOURCE  -m64 -D_GNU_SOURCE -D_FILE_OFF=
SET_BITS=3D64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wa=
ll -Wundef -Wwrite-strings -Wmissing-prototypes -fno-strict-aliasing -fno-c=
ommon -fwrapv  -Wexpansion-to-defined -Wendif-labels -Wno-shift-negative-va=
lue -Wno-missing-include-dirs -Wempty-body -Wnested-externs -Wformat-securi=
ty -Wformat-y2k -Winit-self -Wignored-qualifiers -Wold-style-declaration -W=
old-style-definition -Wtype-limits -fstack-protector-strong -I/usr/include/=
p11-kit-1     -I/usr/include/libpng16  -I/usr/include/libdrm   -I$(SRC_PATH=
)/capstone/include
> LDFLAGS           -Wl,--warn-common -m64 -g=20
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
-softmmu s390x-softmmu sh4eb-softmmu sh4-softmmu sparc64-softmmu sparc-soft=
mmu tricore-softmmu unicore32-softmmu x86_64-softmmu xtensaeb-softmmu xtens=
a-softmmu aarch64_be-linux-user aarch64-linux-user alpha-linux-user armeb-l=
inux-user arm-linux-user cris-linux-user hppa-linux-user i386-linux-user m6=
8k-linux-user microblazeel-linux-user microblaze-linux-user mips64el-linux-=
user mips64-linux-user mipsel-linux-user mips-linux-user mipsn32el-linux-us=
er mipsn32-linux-user nios2-linux-user or1k-linux-user ppc64abi32-linux-use=
r ppc64le-linux-user ppc64-linux-user ppc-linux-user s390x-linux-user sh4eb=
-linux-user sh4-linux-user sparc32plus-linux-user sparc64-linux-user sparc-=
linux-user tilegx-linux-user x86_64-linux-user
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
> fdt support       yes
> preadv support    yes
> fdatasync         yes
> madvise           yes
> posix_madvise     yes
> posix_memalign    yes
> libcap-ng support yes
> vhost-net support yes
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
>   GEN     aarch64-softmmu/config-devices.mak
>   GEN     hppa-softmmu/config-devices.mak.tmp
>   GEN     i386-softmmu/config-devices.mak.tmp
>   GEN     lm32-softmmu/config-devices.mak.tmp
>   GEN     m68k-softmmu/config-devices.mak.tmp
>   GEN     lm32-softmmu/config-devices.mak
>   GEN     m68k-softmmu/config-devices.mak
>   GEN     microblazeel-softmmu/config-devices.mak.tmp
>   GEN     microblaze-softmmu/config-devices.mak.tmp
>   GEN     i386-softmmu/config-devices.mak
>   GEN     hppa-softmmu/config-devices.mak
>   GEN     mips64el-softmmu/config-devices.mak.tmp
>   GEN     mips64-softmmu/config-devices.mak.tmp
>   GEN     microblazeel-softmmu/config-devices.mak
>   GEN     microblaze-softmmu/config-devices.mak
>   GEN     mipsel-softmmu/config-devices.mak.tmp
>   GEN     mips-softmmu/config-devices.mak.tmp
>   GEN     mips64-softmmu/config-devices.mak
>   GEN     mips64el-softmmu/config-devices.mak
>   GEN     moxie-softmmu/config-devices.mak.tmp
>   GEN     nios2-softmmu/config-devices.mak.tmp
>   GEN     mipsel-softmmu/config-devices.mak
>   GEN     or1k-softmmu/config-devices.mak.tmp
>   GEN     mips-softmmu/config-devices.mak
>   GEN     moxie-softmmu/config-devices.mak
>   GEN     ppc64-softmmu/config-devices.mak.tmp
>   GEN     ppcemb-softmmu/config-devices.mak.tmp
>   GEN     nios2-softmmu/config-devices.mak
>   GEN     or1k-softmmu/config-devices.mak
>   GEN     ppc-softmmu/config-devices.mak.tmp
>   GEN     s390x-softmmu/config-devices.mak.tmp
>   GEN     s390x-softmmu/config-devices.mak
>   GEN     ppcemb-softmmu/config-devices.mak
>   GEN     sh4eb-softmmu/config-devices.mak.tmp
>   GEN     ppc-softmmu/config-devices.mak
>   GEN     sh4-softmmu/config-devices.mak.tmp
>   GEN     sparc64-softmmu/config-devices.mak.tmp
>   GEN     ppc64-softmmu/config-devices.mak
>   GEN     sparc-softmmu/config-devices.mak.tmp
>   GEN     sh4eb-softmmu/config-devices.mak
>   GEN     sh4-softmmu/config-devices.mak
>   GEN     sparc-softmmu/config-devices.mak
>   GEN     tricore-softmmu/config-devices.mak.tmp
>   GEN     unicore32-softmmu/config-devices.mak.tmp
>   GEN     x86_64-softmmu/config-devices.mak.tmp
>   GEN     sparc64-softmmu/config-devices.mak
>   GEN     xtensaeb-softmmu/config-devices.mak.tmp
>   GEN     tricore-softmmu/config-devices.mak
>   GEN     unicore32-softmmu/config-devices.mak
>   GEN     xtensa-softmmu/config-devices.mak.tmp
>   GEN     aarch64_be-linux-user/config-devices.mak.tmp
>   GEN     xtensaeb-softmmu/config-devices.mak
>   GEN     aarch64-linux-user/config-devices.mak.tmp
>   GEN     x86_64-softmmu/config-devices.mak
>   GEN     aarch64_be-linux-user/config-devices.mak
>   GEN     xtensa-softmmu/config-devices.mak
>   GEN     alpha-linux-user/config-devices.mak.tmp
>   GEN     aarch64-linux-user/config-devices.mak
>   GEN     armeb-linux-user/config-devices.mak.tmp
>   GEN     arm-linux-user/config-devices.mak.tmp
>   GEN     cris-linux-user/config-devices.mak.tmp
>   GEN     alpha-linux-user/config-devices.mak
>   GEN     arm-linux-user/config-devices.mak
>   GEN     armeb-linux-user/config-devices.mak
>   GEN     hppa-linux-user/config-devices.mak.tmp
>   GEN     cris-linux-user/config-devices.mak
>   GEN     m68k-linux-user/config-devices.mak.tmp
>   GEN     i386-linux-user/config-devices.mak.tmp
>   GEN     microblazeel-linux-user/config-devices.mak.tmp
>   GEN     i386-linux-user/config-devices.mak
>   GEN     hppa-linux-user/config-devices.mak
>   GEN     m68k-linux-user/config-devices.mak
>   GEN     microblaze-linux-user/config-devices.mak.tmp
>   GEN     mips64el-linux-user/config-devices.mak.tmp
>   GEN     mips64-linux-user/config-devices.mak.tmp
>   GEN     microblazeel-linux-user/config-devices.mak
>   GEN     microblaze-linux-user/config-devices.mak
>   GEN     mipsel-linux-user/config-devices.mak.tmp
>   GEN     mips-linux-user/config-devices.mak.tmp
>   GEN     mips64-linux-user/config-devices.mak
>   GEN     mips64el-linux-user/config-devices.mak
>   GEN     mipsn32el-linux-user/config-devices.mak.tmp
>   GEN     mipsel-linux-user/config-devices.mak
>   GEN     mips-linux-user/config-devices.mak
>   GEN     mipsn32-linux-user/config-devices.mak.tmp
>   GEN     nios2-linux-user/config-devices.mak.tmp
>   GEN     or1k-linux-user/config-devices.mak.tmp
>   GEN     mipsn32el-linux-user/config-devices.mak
>   GEN     ppc64abi32-linux-user/config-devices.mak.tmp
>   GEN     mipsn32-linux-user/config-devices.mak
>   GEN     nios2-linux-user/config-devices.mak
>   GEN     ppc64le-linux-user/config-devices.mak.tmp
>   GEN     or1k-linux-user/config-devices.mak
>   GEN     ppc64-linux-user/config-devices.mak.tmp
>   GEN     ppc64abi32-linux-user/config-devices.mak
>   GEN     ppc-linux-user/config-devices.mak.tmp
>   GEN     s390x-linux-user/config-devices.mak.tmp
>   GEN     ppc64-linux-user/config-devices.mak
>   GEN     ppc-linux-user/config-devices.mak
>   GEN     ppc64le-linux-user/config-devices.mak
>   GEN     sh4eb-linux-user/config-devices.mak.tmp
>   GEN     sh4-linux-user/config-devices.mak.tmp
>   GEN     sparc32plus-linux-user/config-devices.mak.tmp
>   GEN     s390x-linux-user/config-devices.mak
>   GEN     sh4eb-linux-user/config-devices.mak
>   GEN     sparc64-linux-user/config-devices.mak.tmp
>   GEN     sh4-linux-user/config-devices.mak
>   GEN     sparc-linux-user/config-devices.mak.tmp
>   GEN     tilegx-linux-user/config-devices.mak.tmp
>   GEN     sparc32plus-linux-user/config-devices.mak
>   GEN     x86_64-linux-user/config-devices.mak.tmp
>   GEN     sparc64-linux-user/config-devices.mak
>   GEN     sparc-linux-user/config-devices.mak
>   GEN     config-host.h
>   GEN     tilegx-linux-user/config-devices.mak
>   GIT     ui/keycodemapdb capstone
>   GEN     x86_64-linux-user/config-devices.mak
>   GEN     qemu-options.def
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
> Submodule 'capstone' (git://git.qemu.org/capstone.git) registered for pat=
h 'capstone'
> Submodule 'ui/keycodemapdb' (git://git.qemu.org/keycodemapdb.git) registe=
red for path 'ui/keycodemapdb'
>   GEN     trace/generated-helpers.c
>   GEN     module_block.h
> Cloning into '/var/tmp/patchew-tester-tmp-5g645hxd/src/capstone'...
>   GEN     tests/test-qapi-types.h
>   GEN     tests/test-qapi-visit.h
>   GEN     tests/test-qmp-commands.h
>   GEN     tests/test-qapi-event.h
>   GEN     tests/test-qmp-introspect.h
>   GEN     trace-root.h
>   GEN     util/trace.h
>   GEN     crypto/trace.h
>   GEN     io/trace.h
>   GEN     migration/trace.h
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
> Cloning into '/var/tmp/patchew-tester-tmp-5g645hxd/src/ui/keycodemapdb'...
>   GEN     ui/input-keymap-linux-to-qcode.c
>   GEN     ui/input-keymap-atset1-to-qcode.c
>   GEN     ui/input-keymap-qcode-to-atset1.c
>   CC      cs.o
>   GEN     ui/input-keymap-qcode-to-atset2.c
>   GEN     ui/input-keymap-qcode-to-atset3.c
>   CC      utils.o
>   GEN     ui/input-keymap-qcode-to-linux.c
>   GEN     ui/input-keymap-qcode-to-qnum.c
>   GEN     ui/input-keymap-qcode-to-sun.c
>   GEN     ui/input-keymap-qnum-to-qcode.c
>   GEN     ui/input-keymap-usb-to-qcode.c
>   CC      SStream.o
>   CC      MCInstrDesc.o
>   GEN     ui/input-keymap-win32-to-qcode.c
>   GEN     ui/input-keymap-x11-to-qcode.c
>   GEN     ui/input-keymap-xorgevdev-to-qcode.c
>   GEN     ui/input-keymap-xorgkbd-to-qcode.c
>   CC      MCRegisterInfo.o
>   CC      arch/ARM/ARMDisassembler.o
>   GEN     ui/input-keymap-xorgxquartz-to-qcode.c
>   CC      arch/ARM/ARMInstPrinter.o
>   GEN     ui/input-keymap-xorgxwin-to-qcode.c
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
> ar: creating /var/tmp/patchew-tester-tmp-5g645hxd/src/build/capstone/libc=
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
>   GEN     docs/interop/qemu-qmp-qapi.texi
>   GEN     docs/interop/qemu-ga-qapi.texi
>   GEN     docs/qemu-block-drivers.7
>   GEN     fsdev/virtfs-proxy-helper.1
>   GEN     qga/qapi-generated/qga-qapi-types.h
>   GEN     qga/qapi-generated/qga-qapi-visit.h
>   GEN     qga/qapi-generated/qga-qmp-commands.h
>   GEN     qga/qapi-generated/qga-qapi-types.c
>   GEN     qga/qapi-generated/qga-qapi-visit.c
>   GEN     qga/qapi-generated/qga-qmp-marshal.c
>   CC      qmp-introspect.o
>   CC      qapi-types.o
>   CC      qapi-visit.o
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
>   CC      hw/s390x/trace.o
>   CC      hw/vfio/trace.o
>   CC      hw/acpi/trace.o
>   CC      hw/arm/trace.o
>   CC      hw/alpha/trace.o
>   CC      hw/hppa/trace.o
>   CC      hw/xen/trace.o
>   CC      hw/ide/trace.o
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
>   CC      stubs/qmp_pc_dimm.o
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
>   CC      backends/hostmem-memfd.o
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
>   CC      disas/mips.o
>   CC      disas/nios2.o
>   CC      disas/moxie.o
>   CC      disas/ppc.o
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
>   CC      hw/block/cdrom.o
>   CC      hw/block/hd-geometry.o
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
>   CC      hw/char/pl011.o
>   CC      hw/char/serial.o
>   CC      hw/char/serial-isa.o
>   CC      hw/char/serial-pci.o
>   CC      hw/char/virtio-console.o
>   CC      hw/char/xilinx_uartlite.o
>   CC      hw/char/cadence_uart.o
>   CC      hw/char/cmsdk-apb-uart.o
>   CC      hw/char/etraxfs_ser.o
>   CC      hw/char/grlib_apbuart.o
>   CC      hw/char/debugcon.o
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
>   CC      hw/core/platform-bus.o
>   CC      hw/cpu/core.o
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
>   CC      hw/misc/tmp421.o
>   CC      hw/misc/debugexit.o
>   CC      hw/misc/sga.o
>   CC      hw/misc/pc-testdev.o
>   CC      hw/misc/pci-testdev.o
>   CC      hw/misc/edu.o
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
>   CC      hw/misc/macio/mac_dbdma.o
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
>   CC      migration/global_state.o
>   CC      migration/qemu-file-channel.o
>   CC      migration/xbzrle.o
>   CC      migration/postcopy-ram.o
>   CC      migration/qjson.o
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
> /var/tmp/patchew-tester-tmp-5g645hxd/src/slirp/misc.c: In function =E2=80=
=98slirp_connection_info=E2=80=99:
> /var/tmp/patchew-tester-tmp-5g645hxd/src/slirp/misc.c:339:44: error: =E2=
=80=98%ld=E2=80=99 directive output may be truncated writing between 1 and =
17 bytes into a region of size 14 [-Werror=3Dformat-truncation=3D]
>                  snprintf(buf, sizeof(buf), "  UDP[%" PRId64 " sec]",
>                                             ^~~~~~~~~
> /var/tmp/patchew-tester-tmp-5g645hxd/src/slirp/misc.c:339:51: note: forma=
t string is defined here
>                  snprintf(buf, sizeof(buf), "  UDP[%" PRId64 " sec]",
> /var/tmp/patchew-tester-tmp-5g645hxd/src/slirp/misc.c:339:44: note: direc=
tive argument in the range [-9223372036854775, 9223372036854775]
>                  snprintf(buf, sizeof(buf), "  UDP[%" PRId64 " sec]",
>                                             ^~~~~~~~~
> In file included from /usr/include/stdio.h:939:0,
>                  from /var/tmp/patchew-tester-tmp-5g645hxd/src/include/qe=
mu/osdep.h:68,
>                  from /var/tmp/patchew-tester-tmp-5g645hxd/src/slirp/misc=
=2Ec:8:
> /usr/include/bits/stdio2.h:64:10: note: =E2=80=98__builtin___snprintf_chk=
=E2=80=99 output between 13 and 29 bytes into a destination of size 20
>    return __builtin___snprintf_chk (__s, __n, __USE_FORTIFY_LEVEL - 1,
>           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>         __bos (__s), __fmt, __va_arg_pack ());
>         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /var/tmp/patchew-tester-tmp-5g645hxd/src/slirp/misc.c:352:40: error: =E2=
=80=98%ld=E2=80=99 directive output may be truncated writing between 1 and =
17 bytes into a region of size 13 [-Werror=3Dformat-truncation=3D]
>              snprintf(buf, sizeof(buf), "  ICMP[%" PRId64 " sec]",
>                                         ^~~~~~~~~~
> /var/tmp/patchew-tester-tmp-5g645hxd/src/slirp/misc.c:352:48: note: forma=
t string is defined here
>              snprintf(buf, sizeof(buf), "  ICMP[%" PRId64 " sec]",
> /var/tmp/patchew-tester-tmp-5g645hxd/src/slirp/misc.c:352:40: note: direc=
tive argument in the range [-9223372036854775, 9223372036854775]
>              snprintf(buf, sizeof(buf), "  ICMP[%" PRId64 " sec]",
>                                         ^~~~~~~~~~
> In file included from /usr/include/stdio.h:939:0,
>                  from /var/tmp/patchew-tester-tmp-5g645hxd/src/include/qe=
mu/osdep.h:68,
>                  from /var/tmp/patchew-tester-tmp-5g645hxd/src/slirp/misc=
=2Ec:8:
> /usr/include/bits/stdio2.h:64:10: note: =E2=80=98__builtin___snprintf_chk=
=E2=80=99 output between 14 and 30 bytes into a destination of size 20
>    return __builtin___snprintf_chk (__s, __n, __USE_FORTIFY_LEVEL - 1,
>           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>         __bos (__s), __fmt, __va_arg_pack ());
>         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors

I will enlarge @buf to 64 bytes just to be safe.

Fam
