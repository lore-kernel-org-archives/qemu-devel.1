Received: from eggs.gnu.org ([2001:4830:134:3::10]:46841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1cfxsO-0004E6-G1
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 19:00:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1cfxsG-0006Kc-R0
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 19:00:16 -0500
Received: from mailapp01.imgtec.com ([195.59.15.196]:5098)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1cfxsG-0006JI-9r
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 19:00:08 -0500
References: <148762362432.30.17684604984505984635@0e2666bad730>
From: Yongbok Kim <yongbok.kim@imgtec.com>
Message-ID: <b4ace576-e829-d07f-3dd8-0662f781ee57@imgtec.com>
Date: Tue, 21 Feb 2017 00:00:01 +0000
MIME-Version: 1.0
In-Reply-To: <148762362432.30.17684604984505984635@0e2666bad730>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/8] target-mips queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com

Ok. I will fix the warning and isolate the file for mips64el only as it i=
s
only used for that.

Regards,
Yongbok

On 20/02/2017 20:47, no-reply@patchew.org wrote:
> Hi,
>=20
> This series failed build test on s390x host. Please find the details be=
low.
>=20
> Subject: [Qemu-devel] [PULL 0/8] target-mips queue
> Message-id: 1487622662-62984-1-git-send-email-yongbok.kim@imgtec.com
> Type: series
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
> BUILD=3D/var/tmp/patchew-qemu-build
> echo -n "Using CC: "
> realpath $CC
> test -e $BUILD && rm -rf $BUILD
> mkdir -p $BUILD $INSTALL
> SRC=3D$PWD
> cd $BUILD
> $SRC/configure --cc=3D$CC --prefix=3D$INSTALL
> make -j4
> make check -j4
> make install
> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>=20
> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> From https://github.com/patchew-project/qemu
>  - [tag update]      patchew/1487067971-10443-1-git-send-email-armbru@r=
edhat.com -> patchew/1487067971-10443-1-git-send-email-armbru@redhat.com
>  - [tag update]      patchew/1487585521-19445-1-git-send-email-nikunj@l=
inux.vnet.ibm.com -> patchew/1487585521-19445-1-git-send-email-nikunj@lin=
ux.vnet.ibm.com
>  - [tag update]      patchew/1487614915-18710-1-git-send-email-den@open=
vz.org -> patchew/1487614915-18710-1-git-send-email-den@openvz.org
>  * [new tag]         patchew/1487622662-62984-1-git-send-email-yongbok.=
kim@imgtec.com -> patchew/1487622662-62984-1-git-send-email-yongbok.kim@i=
mgtec.com
>  - [tag update]      patchew/20170220165204.1980-1-stefanha@redhat.com =
-> patchew/20170220165204.1980-1-stefanha@redhat.com
> Switched to a new branch 'test'
> 0645df1 hw/mips: MIPS Boston board support
> 04f5bec hw: xilinx-pcie: Add support for Xilinx AXI PCIe Controller
> 6c3d656 loader: Support Flattened Image Trees (FIT images)
> 9275ec8 dtc: Update requirement to v1.4.2
> aa8e11a target-mips: Provide function to test if a CPU supports an ISA
> 0ea1cba hw/mips_gic: Update pin state on mask changes
> e84e2ee hw/mips_gictimer: provide API for retrieving frequency
> 65bddf5 hw/mips_cmgcr: allow GCR base to be moved
>=20
> =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
> =3D=3D=3D ENV =3D=3D=3D
> XDG_SESSION_ID=3D28414
> SHELL=3D/bin/sh
> USER=3Dfam
> PATCHEW=3D/home/fam/patchew/patchew-cli -s http://patchew.org --nodebug
> PATH=3D/usr/bin:/bin
> PWD=3D/var/tmp/patchew-tester-tmp-i2k78q7z/src
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
> libacl-2.2.52-11.fc24.s390x
> libxshmfence-1.2-3.fc24.s390x
> cdparanoia-libs-10.2-21.fc24.s390x
> ustr-1.0.4-21.fc24.s390x
> giflib-4.1.6-15.fc24.s390x
> libusb-0.1.5-7.fc24.s390x
> trousers-lib-0.3.13-6.fc24.s390x
> readline-devel-6.3-8.fc24.s390x
> python-srpm-macros-3-10.fc25.noarch
> ncurses-base-6.0-6.20160709.fc25.noarch
> gmp-6.1.1-1.fc25.s390x
> chkconfig-1.8-1.fc25.s390x
> libidn-1.33-1.fc25.s390x
> file-5.28-4.fc25.s390x
> slang-2.3.0-7.fc25.s390x
> avahi-libs-0.6.32-4.fc25.s390x
> libsemanage-2.5-8.fc25.s390x
> perl-Unicode-Normalize-1.25-365.fc25.s390x
> perl-libnet-3.10-1.fc25.noarch
> perl-Thread-Queue-3.11-1.fc25.noarch
> perl-podlators-4.09-1.fc25.noarch
> jasper-libs-1.900.13-1.fc25.s390x
> graphite2-1.3.6-1.fc25.s390x
> libblkid-2.28.2-1.fc25.s390x
> pkgconfig-0.29.1-1.fc25.s390x
> dbus-python-1.2.4-2.fc25.s390x
> alsa-lib-1.1.1-2.fc25.s390x
> libgnome-keyring-3.12.0-7.fc25.s390x
> yum-metadata-parser-1.1.4-17.fc25.s390x
> python3-3.5.2-4.fc25.s390x
> python3-slip-dbus-0.6.4-4.fc25.noarch
> python2-cssselect-0.9.2-1.fc25.noarch
> python-backports-1.0-8.fc25.s390x
> python-magic-5.28-4.fc25.noarch
> python-pycparser-2.14-7.fc25.noarch
> python-fedora-0.8.0-2.fc25.noarch
> createrepo_c-libs-0.10.0-6.fc25.s390x
> initscripts-9.69-1.fc25.s390x
> plymouth-scripts-0.9.3-0.6.20160620git0e65b86c.fc25.s390x
> cronie-1.5.1-2.fc25.s390x
> python2-librepo-1.7.18-3.fc25.s390x
> wget-1.18-2.fc25.s390x
> python3-dnf-plugins-core-0.1.21-4.fc25.noarch
> at-spi2-core-2.22.0-1.fc25.s390x
> libXv-1.0.11-1.fc25.s390x
> dhcp-client-4.3.5-1.fc25.s390x
> python2-dnf-plugins-core-0.1.21-4.fc25.noarch
> parted-3.2-21.fc25.s390x
> python2-ndg_httpsclient-0.4.0-4.fc25.noarch
> bash-completion-2.4-1.fc25.noarch
> btrfs-progs-4.6.1-1.fc25.s390x
> texinfo-6.1-3.fc25.s390x
> perl-Filter-1.55-366.fc25.s390x
> flex-2.6.0-3.fc25.s390x
> libgcc-6.3.1-1.fc25.s390x
> glib2-2.50.2-1.fc25.s390x
> dbus-libs-1.11.8-1.fc25.s390x
> libgomp-6.3.1-1.fc25.s390x
> colord-libs-1.3.4-1.fc25.s390x
> perl-Encode-2.88-5.fc25.s390x
> gstreamer1-1.10.2-1.fc25.s390x
> cracklib-2.9.6-4.fc25.s390x
> rpm-build-libs-4.13.0-6.fc25.s390x
> libobjc-6.3.1-1.fc25.s390x
> pcre-devel-8.40-1.fc25.s390x
> mariadb-config-10.1.20-1.fc25.s390x
> gcc-6.3.1-1.fc25.s390x
> mesa-libGL-13.0.3-1.fc25.s390x
> python3-dnf-plugin-system-upgrade-0.7.1-4.fc25.noarch
> bind-libs-9.10.4-4.P5.fc25.s390x
> python-osbs-client-0.33-3.fc25.noarch
> NetworkManager-1.4.4-3.fc25.s390x
> audit-2.7.1-1.fc25.s390x
> glibc-static-2.24-4.fc25.s390x
> perl-Pod-Simple-3.35-1.fc25.noarch
> gdb-7.12-36.fc25.s390x
> python2-simplejson-3.10.0-1.fc25.s390x
> python3-sssdconfig-1.14.2-2.fc25.noarch
> texlive-lib-2016-30.20160520.fc25.s390x
> boost-random-1.60.0-10.fc25.s390x
> brltty-5.4-2.fc25.s390x
> libref_array-0.1.5-29.fc25.s390x
> librados2-10.2.4-2.fc25.s390x
> gnutls-dane-3.5.8-1.fc25.s390x
> systemtap-client-3.1-0.20160725git91bfb36.fc25.s390x
> libXrender-devel-0.9.10-1.fc25.s390x
> libXi-devel-1.7.8-2.fc25.s390x
> texlive-pdftex-doc-svn41149-30.fc25.noarch
> tcp_wrappers-7.6-83.fc25.s390x
> javapackages-tools-4.7.0-6.1.fc25.noarch
> texlive-kpathsea-bin-svn40473-30.20160520.fc25.s390x
> texlive-url-svn32528.3.4-30.fc25.noarch
> texlive-latex-fonts-svn28888.0-30.fc25.noarch
> texlive-mptopdf-bin-svn18674.0-30.20160520.fc25.noarch
> texlive-underscore-svn18261.0-30.fc25.noarch
> texlive-subfig-svn15878.1.3-30.fc25.noarch
> texlive-dvipdfmx-def-svn40328-30.fc25.noarch
> texlive-plain-svn40274-30.fc25.noarch
> texlive-texlive-scripts-svn41433-30.fc25.noarch
> texlive-fancyref-svn15878.0.9c-30.fc25.noarch
> texlive-csquotes-svn39538-30.fc25.noarch
> texlive-pxfonts-svn15878.0-30.fc25.noarch
> texlive-cite-svn36428.5.5-30.fc25.noarch
> texlive-section-svn20180.0-30.fc25.noarch
> texlive-pslatex-svn16416.0-30.fc25.noarch
> texlive-tex-gyre-math-svn41264-30.fc25.noarch
> texlive-knuth-local-svn38627-30.fc25.noarch
> texlive-type1cm-svn21820.0-30.fc25.noarch
> texlive-finstrut-svn21719.0.5-30.fc25.noarch
> texlive-ucharcat-svn38907-30.fc25.noarch
> texlive-environ-svn33821.0.3-30.fc25.noarch
> texlive-eso-pic-svn37925.2.0g-30.fc25.noarch
> texlive-filehook-svn24280.0.5d-30.fc25.noarch
> texlive-luatexbase-svn38550-30.fc25.noarch
> texlive-pst-text-svn15878.1.00-30.fc25.noarch
> texlive-pst-tree-svn24142.1.12-30.fc25.noarch
> texlive-latex-bin-bin-svn14050.0-30.20160520.fc25.noarch
> texlive-metalogo-svn18611.0.12-30.fc25.noarch
> texlive-cm-super-svn15878.0-30.fc25.noarch
> texlive-xetex-svn41438-30.fc25.noarch
> keyutils-1.5.9-8.fc24.s390x
> libcephfs_jni1-10.2.4-2.fc25.s390x
> libcom_err-devel-1.43.3-1.fc25.s390x
> mesa-libGLES-devel-13.0.3-1.fc25.s390x
> graphite2-devel-1.3.6-1.fc25.s390x
> nettle-devel-3.3-1.fc25.s390x
> lzo-minilzo-2.08-8.fc24.s390x
> bzip2-devel-1.0.6-21.fc25.s390x
> libusbx-devel-1.0.21-1.fc25.s390x
> SDL2-devel-2.0.5-2.fc25.s390x
> virglrenderer-devel-0.5.0-1.20160411git61846f92f.fc25.s390x
> glib2-static-2.50.2-1.fc25.s390x
> mesa-libgbm-devel-13.0.3-1.fc25.s390x
> acpica-tools-20160831-1.fc25.s390x
> gdk-pixbuf2-2.36.4-1.fc25.s390x
> nss-softokn-3.28.1-1.0.fc25.s390x
> python3-dnf-1.1.10-5.fc25.noarch
> python-gluster-3.9.1-1.fc25.noarch
> perl-IO-1.36-382.fc25.s390x
> glusterfs-devel-3.9.1-1.fc25.s390x
> gtk3-3.22.7-1.fc25.s390x
> vim-enhanced-8.0.206-1.fc25.s390x
> nss-tools-3.28.1-1.3.fc25.s390x
> libmicrohttpd-0.9.52-1.fc25.s390x
> gpg-pubkey-a29cb19c-53bcbba6
> libaio-0.3.110-6.fc24.s390x
> m4-1.4.17-9.fc24.s390x
> libfontenc-1.1.3-3.fc24.s390x
> lzo-2.08-8.fc24.s390x
> isl-0.14-5.fc24.s390x
> libXau-1.0.8-6.fc24.s390x
> liblockfile-1.09-4.fc24.s390x
> linux-atm-libs-2.5.1-14.fc24.s390x
> sg3_utils-1.41-3.fc24.s390x
> libXext-1.3.3-4.fc24.s390x
> libXinerama-1.1.3-6.fc24.s390x
> libXxf86vm-1.1.4-3.fc24.s390x
> libXft-2.3.2-4.fc24.s390x
> ykpers-1.17.3-2.fc24.s390x
> bison-3.0.4-4.fc24.s390x
> perl-srpm-macros-1-20.fc25.noarch
> gawk-4.1.3-8.fc25.s390x
> tcp_wrappers-libs-7.6-83.fc25.s390x
> libwayland-client-1.12.0-1.fc25.s390x
> iptables-1.6.0-2.fc25.s390x
> perl-Exporter-5.72-366.fc25.noarch
> perl-Text-Tabs+Wrap-2013.0523-365.fc25.noarch
> perl-Error-0.17024-7.fc25.noarch
> perl-Term-Cap-1.17-365.fc25.noarch
> perl-version-0.99.17-1.fc25.s390x
> perl-Pod-Usage-1.69-1.fc25.noarch
> fftw-libs-double-3.3.5-3.fc25.s390x
> device-mapper-persistent-data-0.6.3-1.fc25.s390x
> krb5-libs-1.14.4-4.fc25.s390x
> system-python-libs-3.5.2-4.fc25.s390x
> net-snmp-libs-5.7.3-13.fc25.s390x
> libssh2-1.8.0-1.fc25.s390x
> libgusb-0.2.9-1.fc25.s390x
> ModemManager-glib-1.6.4-1.fc25.s390x
> python3-six-1.10.0-3.fc25.noarch
> newt-python3-0.52.19-2.fc25.s390x
> python3-pysocks-1.5.6-5.fc25.noarch
> python-chardet-2.3.0-1.fc25.noarch
> python-munch-2.0.4-3.fc25.noarch
> python2-cffi-1.7.0-2.fc25.s390x
> python-bugzilla-1.2.2-4.fc25.noarch
> openldap-2.4.44-2.fc25.s390x
> libedit-3.1-16.20160618cvs.fc25.s390x
> gc-devel-7.4.4-1.fc25.s390x
> python-pycurl-7.43.0-4.fc25.s390x
> createrepo_c-0.10.0-6.fc25.s390x
> plymouth-0.9.3-0.6.20160620git0e65b86c.fc25.s390x
> device-mapper-multipath-libs-0.4.9-83.fc25.s390x
> ebtables-2.0.10-21.fc25.s390x
> python3-librepo-1.7.18-3.fc25.s390x
> libwmf-lite-0.2.8.4-49.fc25.s390x
> net-snmp-5.7.3-13.fc25.s390x
> yum-3.4.3-510.fc25.noarch
> dnf-plugins-core-0.1.21-4.fc25.noarch
> at-spi2-atk-2.22.0-1.fc25.s390x
> ImageMagick-libs-6.9.3.0-3.fc25.s390x
> dhcp-common-4.3.5-1.fc25.noarch
> kernel-modules-4.8.8-300.fc25.s390x
> dracut-config-rescue-044-78.fc25.s390x
> sendmail-8.15.2-7.fc25.s390x
> avahi-autoipd-0.6.32-4.fc25.s390x
> teamd-1.26-1.fc25.s390x
> kernel-devel-4.8.8-300.fc25.s390x
> mozjs17-17.0.0-16.fc25.s390x
> libselinux-2.5-13.fc25.s390x
> libcrypt-nss-2.24-4.fc25.s390x
> systemd-libs-231-12.fc25.s390x
> libgo-6.3.1-1.fc25.s390x
> libgo-devel-6.3.1-1.fc25.s390x
> NetworkManager-libnm-1.4.4-3.fc25.s390x
> cpp-6.3.1-1.fc25.s390x
> rpm-plugin-selinux-4.13.0-6.fc25.s390x
> pcre-utf32-8.40-1.fc25.s390x
> packagedb-cli-2.14-1.fc25.noarch
> python2-pyparsing-2.1.10-1.fc25.noarch
> glibc-devel-2.24-4.fc25.s390x
> libdrm-2.4.74-1.fc25.s390x
> kernel-modules-4.9.3-200.fc25.s390x
> cairo-gobject-1.14.8-1.fc25.s390x
> bind99-license-9.9.9-4.P5.fc25.noarch
> pyrpkg-1.47-5.fc25.noarch
> emacs-25.1-3.fc25.s390x
> firewalld-0.4.4.2-2.fc25.noarch
> pyparsing-2.1.10-1.fc25.noarch
> kernel-devel-4.9.3-200.fc25.s390x
> libproxy-0.4.14-1.fc25.s390x
> ethtool-4.8-1.fc25.s390x
> python3-pyparsing-2.1.10-1.fc25.noarch
> xorg-x11-proto-devel-7.7-20.fc25.noarch
> brlapi-0.6.5-2.fc25.s390x
> libcollection-0.7.0-29.fc25.s390x
> librados-devel-10.2.4-2.fc25.s390x
> libcephfs-devel-10.2.4-2.fc25.s390x
> libXdamage-devel-1.1.4-8.fc24.s390x
> libXinerama-devel-1.1.3-6.fc24.s390x
> quota-4.03-7.fc25.s390x
> texlive-texlive-common-doc-svn40682-30.fc25.noarch
> texlive-metafont-bin-svn40987-30.20160520.fc25.s390x
> texlive-ifluatex-svn41346-30.fc25.noarch
> texlive-dvips-bin-svn40987-30.20160520.fc25.s390x
> texlive-marvosym-svn29349.2.2a-30.fc25.noarch
> texlive-graphics-cfg-svn40269-30.fc25.noarch
> texlive-carlisle-svn18258.0-30.fc25.noarch
> texlive-glyphlist-svn28576.0-30.fc25.noarch
> texlive-tex-bin-svn40987-30.20160520.fc25.s390x
> texlive-texlive-scripts-bin-svn29741.0-30.20160520.fc25.noarch
> texlive-mathtools-svn38833-30.fc25.noarch
> texlive-euro-svn22191.1.1-30.fc25.noarch
> texlive-palatino-svn31835.0-30.fc25.noarch
> texlive-anysize-svn15878.0-30.fc25.noarch
> texlive-sansmath-svn17997.1.1-30.fc25.noarch
> texlive-mfnfss-svn19410.0-30.fc25.noarch
> texlive-mathpazo-svn15878.1.003-30.fc25.noarch
> texlive-knuth-lib-svn35820.0-30.fc25.noarch
> texlive-updmap-map-svn41159-30.fc25.noarch
> texlive-beton-svn15878.0-30.fc25.noarch
> texlive-xetexconfig-svn41133-30.fc25.noarch
> texlive-trimspaces-svn15878.1.1-30.fc25.noarch
> texlive-memoir-svn41203-30.fc25.noarch
> texlive-latex-svn40218-30.fc25.noarch
> texlive-lualatex-math-svn40621-30.fc25.noarch
> texlive-pst-grad-svn15878.1.06-30.fc25.noarch
> texlive-pst-tools-svn34067.0.05-30.fc25.noarch
> texlive-amscls-svn36804.0-30.fc25.noarch
> texlive-tex-gyre-svn18651.2.004-30.fc25.noarch
> texlive-ltxmisc-svn21927.0-30.fc25.noarch
> texlive-xetex-bin-svn41091-30.20160520.fc25.s390x
> lua-posix-33.3.1-3.fc25.s390x
> gssproxy-0.5.1-3.fc25.s390x
> java-1.8.0-openjdk-1.8.0.111-5.b16.fc25.s390x
> libverto-devel-0.2.6-6.fc24.s390x
> mesa-libGLES-13.0.3-1.fc25.s390x
> p11-kit-devel-0.23.2-2.fc24.s390x
> snappy-1.1.3-2.fc24.s390x
> gnutls-devel-3.5.8-1.fc25.s390x
> cairo-gobject-devel-1.14.8-1.fc25.s390x
> usbredir-devel-0.7.1-2.fc24.s390x
> systemtap-3.1-0.20160725git91bfb36.fc25.s390x
> bluez-libs-devel-5.43-1.fc25.s390x
> libcurl-devel-7.51.0-4.fc25.s390x
> cyrus-sasl-devel-2.1.26-26.2.fc24.s390x
> python-libs-2.7.13-1.fc25.s390x
> nss-sysinit-3.28.1-1.3.fc25.s390x
> dnf-1.1.10-5.fc25.noarch
> glusterfs-extra-xlators-3.9.1-1.fc25.s390x
> perl-5.24.1-382.fc25.s390x
> linux-firmware-20161205-69.git91ddce49.fc25.noarch
> libX11-devel-1.6.4-4.fc25.s390x
> kernel-devel-4.9.5-200.fc25.s390x
> python-devel-2.7.13-1.fc25.s390x
> kernel-headers-4.9.5-200.fc25.s390x
> gpg-pubkey-efe550f5-5220ba41
> python-async-0.6.1-9.fc22.s390x
> gpg-pubkey-81b46521-55b3ca9a
> dejavu-sans-mono-fonts-2.35-3.fc24.noarch
> filesystem-3.2-37.fc24.s390x
> popt-1.16-7.fc24.s390x
> libffi-3.1-9.fc24.s390x
> cyrus-sasl-lib-2.1.26-26.2.fc24.s390x
> xz-5.2.2-2.fc24.s390x
> keyutils-libs-1.5.9-8.fc24.s390x
> libnfnetlink-1.0.1-8.fc24.s390x
> libnetfilter_conntrack-1.0.4-6.fc24.s390x
> libtheora-1.1.1-14.fc24.s390x
> xml-common-0.6.3-44.fc24.noarch
> autoconf-2.69-22.fc24.noarch
> libpipeline-1.4.1-2.fc24.s390x
> libXt-1.1.5-3.fc24.s390x
> kbd-legacy-2.0.3-3.fc24.noarch
> ghostscript-fonts-5.50-35.fc24.noarch
> libcroco-0.6.11-2.fc24.s390x
> pinentry-0.9.7-2.fc24.s390x
> libXevie-1.0.3-11.fc24.s390x
> pth-2.0.7-27.fc24.s390x
> python2-rpm-macros-3-10.fc25.noarch
> libsepol-2.5-10.fc25.s390x
> libcap-2.25-2.fc25.s390x
> sqlite-libs-3.14.2-1.fc25.s390x
> mpfr-3.1.5-1.fc25.s390x
> libxcb-1.12-1.fc25.s390x
> libicu-57.1-4.fc25.s390x
> perl-Carp-1.40-365.fc25.noarch
> perl-IO-Socket-IP-0.38-1.fc25.noarch
> libmnl-1.0.4-1.fc25.s390x
> perl-Unicode-EastAsianWidth-1.33-8.fc25.noarch
> perl-Getopt-Long-2.49.1-1.fc25.noarch
> libwayland-cursor-1.12.0-1.fc25.s390x
> coreutils-common-8.25-15.fc25.s390x
> libmount-2.28.2-1.fc25.s390x
> python2-decorator-4.0.10-3.fc25.noarch
> avahi-glib-0.6.32-4.fc25.s390x
> python3-pip-8.1.2-2.fc25.noarch
> python3-libcomps-0.1.7-5.fc25.s390x
> python-slip-0.6.4-4.fc25.noarch
> python-krbV-1.0.90-12.fc25.s390x
> python2-libcomps-0.1.7-5.fc25.s390x
> python2-urllib3-1.15.1-3.fc25.noarch
> fipscheck-1.4.1-11.fc25.s390x
> gc-7.4.4-1.fc25.s390x
> libndp-1.6-1.fc25.s390x
> libsolv-0.6.24-1.fc25.s390x
> gnupg2-2.1.13-2.fc25.s390x
> geoclue2-2.4.4-1.fc25.s390x
> s390utils-cmsfs-1.36.0-1.fc25.s390x
> libXfixes-5.0.3-1.fc25.s390x
> libXi-1.7.8-2.fc25.s390x
> adwaita-icon-theme-3.22.0-1.fc25.noarch
> dconf-0.26.0-1.fc25.s390x
> ncurses-devel-6.0-6.20160709.fc25.s390x
> newt-python-0.52.19-2.fc25.s390x
> perl-Test-Harness-3.36-367.fc25.noarch
> valgrind-3.12.0-1.fc25.s390x
> dejagnu-1.6-1.fc25.noarch
> audit-libs-2.7.1-1.fc25.s390x
> libstdc++-devel-6.3.1-1.fc25.s390x
> emacs-filesystem-25.1-3.fc25.noarch
> libdb-utils-5.3.28-16.fc25.s390x
> libidn2-0.11-1.fc25.s390x
> python3-rpm-4.13.0-6.fc25.s390x
> gnutls-3.5.8-1.fc25.s390x
> python-beautifulsoup4-4.5.3-1.fc25.noarch
> qt5-srpm-macros-5.7.1-1.fc25.noarch
> elfutils-default-yama-scope-0.168-1.fc25.noarch
> device-mapper-1.02.136-3.fc25.s390x
> device-mapper-event-1.02.136-3.fc25.s390x
> systemd-container-231-12.fc25.s390x
> python3-distro-1.0.1-2.fc25.noarch
> fedpkg-1.26-4.fc25.noarch
> gstreamer1-plugins-base-1.10.2-1.fc25.s390x
> subversion-1.9.5-1.fc25.s390x
> perl-Module-CoreList-5.20170115-1.fc25.noarch
> perl-Class-Inspector-1.31-2.fc25.noarch
> libtool-ltdl-2.4.6-13.fc25.s390x
> python2-sssdconfig-1.14.2-2.fc25.noarch
> glib2-devel-2.50.2-1.fc25.s390x
> poppler-0.45.0-2.fc25.s390x
> libbasicobjects-0.1.1-29.fc25.s390x
> libevent-2.0.22-1.fc25.s390x
> libradosstriper1-10.2.4-2.fc25.s390x
> atk-devel-2.22.0-1.fc25.s390x
> libXxf86vm-devel-1.1.4-3.fc24.s390x
> libev-4.24-1.fc25.s390x
> gsm-1.0.16-1.fc25.s390x
> libnfsidmap-0.27-0.fc25.s390x
> zziplib-0.13.62-7.fc24.s390x
> texlive-metafont-svn40793-30.fc25.noarch
> texlive-booktabs-svn40846-30.fc25.noarch
> texlive-dvips-svn41149-30.fc25.noarch
> texlive-zapfding-svn31835.0-30.fc25.noarch
> texlive-graphics-svn41015-30.fc25.noarch
> texlive-latexconfig-svn40274-30.fc25.noarch
> texlive-gsftopk-bin-svn40473-30.20160520.fc25.s390x
> texlive-tex-svn40793-30.fc25.noarch
> texlive-xdvi-bin-svn40750-30.20160520.fc25.s390x
> texlive-qstest-svn15878.0-30.fc25.noarch
> texlive-avantgar-svn31835.0-30.fc25.noarch
> texlive-ncntrsbk-svn31835.0-30.fc25.noarch
> texlive-cm-svn32865.0-30.fc25.noarch
> texlive-rcs-svn15878.0-30.fc25.noarch
> texlive-fix2col-svn38770-30.fc25.noarch
> texlive-lm-math-svn36915.1.959-30.fc25.noarch
> texlive-hyphen-base-svn41138-30.fc25.noarch
> texlive-unicode-data-svn39808-30.fc25.noarch
> texlive-luatex-svn40963-30.fc25.noarch
> texlive-xetex-def-svn40327-30.fc25.noarch
> texlive-varwidth-svn24104.0.92-30.fc25.noarch
> texlive-l3kernel-svn41246-30.fc25.noarch
> texlive-hyperref-svn41396-30.fc25.noarch
> texlive-unicode-math-svn38462-30.fc25.noarch
> texlive-fancyvrb-svn18492.2.8-30.fc25.noarch
> texlive-pst-plot-svn41242-30.fc25.noarch
> texlive-rotating-svn16832.2.16b-30.fc25.noarch
> texlive-pdfpages-svn40638-30.fc25.noarch
> texlive-ae-svn15878.1.4-30.fc25.noarch
> libpaper-1.1.24-12.fc24.s390x
> texlive-collection-latexrecommended-svn35765.0-30.20160520.fc25.noarch
> libini_config-1.3.0-29.fc25.s390x
> xorg-x11-fonts-Type1-7.5-16.fc24.noarch
> pcre2-devel-10.22-8.fc25.s390x
> gnutls-c++-3.5.8-1.fc25.s390x
> systemtap-devel-3.1-0.20160725git91bfb36.fc25.s390x
> libtasn1-devel-4.10-1.fc25.s390x
> pango-devel-1.40.3-1.fc25.s390x
> vte291-devel-0.46.1-1.fc25.s390x
> snappy-devel-1.1.3-2.fc24.s390x
> brlapi-devel-0.6.5-2.fc25.s390x
> man-pages-4.06-3.fc25.noarch
> libcap-ng-devel-0.7.8-1.fc25.s390x
> glusterfs-3.9.1-1.fc25.s390x
> nss-util-devel-3.28.1-1.0.fc25.s390x
> dnf-conf-1.1.10-5.fc25.noarch
> libxkbcommon-devel-0.7.1-1.fc25.s390x
> perl-macros-5.24.1-382.fc25.s390x
> rpcbind-0.2.4-2.fc25.s390x
> pulseaudio-libs-10.0-2.fc25.s390x
> kernel-4.9.5-200.fc25.s390x
> libnl3-cli-3.2.29-2.fc25.s390x
> tzdata-2016j-2.fc25.noarch
> gpg-pubkey-34ec9cba-54e38751
> gpg-pubkey-030d5aed-55b577f0
> basesystem-11-2.fc24.noarch
> libattr-2.4.47-16.fc24.s390x
> libmpc-1.0.2-5.fc24.s390x
> apr-util-1.5.4-3.fc24.s390x
> rsync-3.1.2-2.fc24.s390x
> libunistring-0.9.4-3.fc24.s390x
> jbigkit-libs-2.1-5.fc24.s390x
> pixman-0.34.0-2.fc24.s390x
> acl-2.2.52-11.fc24.s390x
> dwz-0.12-2.fc24.s390x
> expect-5.45-22.fc24.s390x
> libmodman-2.0.1-12.fc24.s390x
> libsigsegv-2.10-10.fc24.s390x
> libvisual-0.4.0-20.fc24.s390x
> fakeroot-libs-1.20.2-4.fc24.s390x
> m17n-lib-1.7.0-5.fc24.s390x
> libpcap-1.7.4-2.fc24.s390x
> libverto-0.2.6-6.fc24.s390x
> lsscsi-0.28-3.fc24.s390x
> setup-2.10.4-1.fc25.noarch
> rpmconf-base-1.0.18-2.fc25.noarch
> bash-4.3.43-4.fc25.s390x
> expat-2.2.0-1.fc25.s390x
> libxml2-2.9.3-4.fc25.s390x
> libgpg-error-1.24-1.fc25.s390x
> nspr-4.13.1-1.fc25.s390x
> libgcrypt-1.6.6-1.fc25.s390x
> file-libs-5.28-4.fc25.s390x
> findutils-4.6.0-8.fc25.s390x
> libjpeg-turbo-1.5.1-0.fc25.s390x
> kmod-23-1.fc25.s390x
> libassuan-2.4.3-1.fc25.s390x
> libusbx-1.0.21-1.fc25.s390x
> newt-0.52.19-2.fc25.s390x
> libxslt-1.1.28-13.fc25.s390x
> libmetalink-0.1.3-1.fc25.s390x
> perl-Socket-2.024-1.fc25.s390x
> perl-File-Path-2.12-365.fc25.noarch
> perl-MIME-Base64-3.15-365.fc25.s390x
> perl-HTTP-Tiny-0.070-1.fc25.noarch
> ncurses-6.0-6.20160709.fc25.s390x
> libwayland-server-1.12.0-1.fc25.s390x
> ipset-6.29-1.fc25.s390x
> perl-Text-Unidecode-1.27-3.fc25.noarch
> perl-Fedora-VSP-0.001-4.fc25.noarch
> perl-libintl-perl-1.26-1.fc25.s390x
> plymouth-core-libs-0.9.3-0.6.20160620git0e65b86c.fc25.s390x
> hunspell-1.4.1-1.fc25.s390x
> which-2.21-1.fc25.s390x
> coreutils-8.25-15.fc25.s390x
> python2-setuptools-25.1.1-1.fc25.noarch
> shadow-utils-4.2.1-11.fc25.s390x
> atk-2.22.0-1.fc25.s390x
> system-python-3.5.2-4.fc25.s390x
> pam-1.3.0-1.fc25.s390x
> python2-pyasn1-0.1.9-7.fc25.1.noarch
> harfbuzz-icu-1.3.2-1.fc25.s390x
> gsettings-desktop-schemas-3.22.0-1.fc25.s390x
> libsecret-0.18.5-2.fc25.s390x
> s390utils-iucvterm-1.36.0-1.fc25.s390x
> python3-setuptools-25.1.1-1.fc25.noarch
> python3-decorator-4.0.10-3.fc25.noarch
> python3-slip-0.6.4-4.fc25.noarch
> python3-magic-5.28-4.fc25.noarch
> python3-requests-2.10.0-4.fc25.noarch
> python3-systemd-232-1.fc25.s390x
> pyusb-1.0.0-2.fc25.noarch
> python-slip-dbus-0.6.4-4.fc25.noarch
> python-enum34-1.0.4-6.fc25.noarch
> python-lockfile-0.11.0-4.fc25.noarch
> python2-ply-3.8-2.fc25.noarch
> pyOpenSSL-16.0.0-2.fc25.noarch
> python2-requests-2.10.0-4.fc25.noarch
> pyxattr-0.5.3-8.fc25.s390x
> libarchive-3.2.2-1.fc25.s390x
> libkadm5-1.14.4-4.fc25.s390x
> dtc-1.4.2-1.fc25.s390x
> libbabeltrace-1.4.0-3.fc25.s390x
> guile-2.0.13-1.fc25.s390x
> libthai-0.1.25-1.fc25.s390x
> libnghttp2-1.13.0-2.fc25.s390x
> deltarpm-3.6-17.fc25.s390x
> python-urlgrabber-3.10.1-9.fc25.noarch
> iputils-20161105-1.fc25.s390x
> s390utils-mon_statd-1.36.0-1.fc25.s390x
> cryptsetup-libs-1.7.2-3.fc25.s390x
> device-mapper-multipath-0.4.9-83.fc25.s390x
> cronie-anacron-1.5.1-2.fc25.s390x
> ghostscript-core-9.20-5.fc25.s390x
> python3-pygpgme-0.3-18.fc25.s390x
> rest-0.8.0-1.fc25.s390x
> libreport-filesystem-2.8.0-1.fc25.s390x
> libXtst-1.2.3-1.fc25.s390x
> iso-codes-3.70-1.fc25.noarch
> ghc-srpm-macros-1.4.2-4.fc25.noarch
> adwaita-cursor-theme-3.22.0-1.fc25.noarch
> rpmdevtools-8.9-1.fc25.noarch
> kernel-4.8.8-300.fc25.s390x
> python-dnf-plugins-extras-migrate-0.0.12-4.fc25.noarch
> s390utils-1.36.0-1.fc25.s390x
> authconfig-6.2.10-14.fc25.s390x
> fedora-cert-0.6.0.1-1.fc25.noarch
> glibc-2.24-4.fc25.s390x
> elfutils-libelf-0.168-1.fc25.s390x
> libstdc++-6.3.1-1.fc25.s390x
> perl-Scalar-List-Utils-1.47-1.fc25.s390x
> gdb-headless-7.12-36.fc25.s390x
> bzip2-1.0.6-21.fc25.s390x
> bind-license-9.10.4-4.P5.fc25.noarch
> pcre-cpp-8.40-1.fc25.s390x
> perl-threads-2.12-1.fc25.s390x
> subversion-libs-1.9.5-1.fc25.s390x
> libss-1.43.3-1.fc25.s390x
> shared-mime-info-1.8-1.fc25.s390x
> libselinux-utils-2.5-13.fc25.s390x
> libgfortran-6.3.1-1.fc25.s390x
> rpm-4.13.0-6.fc25.s390x
> python2-rpm-4.13.0-6.fc25.s390x
> policycoreutils-2.5-19.fc25.s390x
> libtasn1-4.10-1.fc25.s390x
> mesa-libwayland-egl-13.0.3-1.fc25.s390x
> pigz-2.3.4-1.fc25.s390x
> koji-1.11.0-1.fc25.noarch
> python3-enchant-1.6.8-1.fc25.noarch
> mariadb-common-10.1.20-1.fc25.s390x
> firewalld-filesystem-0.4.4.2-2.fc25.noarch
> systemd-231-12.fc25.s390x
> device-mapper-libs-1.02.136-3.fc25.s390x
> systemd-udev-231-12.fc25.s390x
> dnf-plugin-system-upgrade-0.7.1-4.fc25.noarch
> mesa-libEGL-13.0.3-1.fc25.s390x
> dnsmasq-2.76-2.fc25.s390x
> distribution-gpg-keys-1.9-1.fc25.noarch
> bind-libs-lite-9.10.4-4.P5.fc25.s390x
> mock-1.3.3-1.fc25.noarch
> python2-dockerfile-parse-0.0.5-7.fc25.noarch
> fedora-packager-0.6.0.1-1.fc25.noarch
> openssl-1.0.2j-3.fc25.s390x
> lvm2-2.02.167-3.fc25.s390x
> systemd-bootchart-231-2.fc25.s390x
> gcc-c++-6.3.1-1.fc25.s390x
> texlive-base-2016-30.20160520.fc25.noarch
> boost-system-1.60.0-10.fc25.s390x
> pcre2-10.22-8.fc25.s390x
> libpng-devel-1.6.27-1.fc25.s390x
> perl-XML-Parser-2.44-5.fc25.s390x
> libtirpc-1.0.1-3.rc3.fc25.s390x
> lttng-ust-2.8.1-2.fc25.s390x
> libasyncns-0.8-10.fc24.s390x
> unbound-libs-1.5.10-1.fc25.s390x
> libradosstriper-devel-10.2.4-2.fc25.s390x
> systemtap-runtime-3.1-0.20160725git91bfb36.fc25.s390x
> libXau-devel-1.0.8-6.fc24.s390x
> libXfixes-devel-5.0.3-1.fc25.s390x
> mesa-libEGL-devel-13.0.3-1.fc25.s390x
> libXcomposite-devel-0.4.4-8.fc24.s390x
> libverto-libev-0.2.6-6.fc24.s390x
> texlive-kpathsea-doc-svn41139-30.fc25.noarch
> flac-libs-1.3.2-1.fc25.s390x
> quota-nls-4.03-7.fc25.noarch
> python3-html5lib-0.999-9.fc25.noarch
> python3-javapackages-4.7.0-6.1.fc25.noarch
> perl-Digest-1.17-366.fc25.noarch
> texlive-texlive.infra-svn41280-30.fc25.noarch
> texlive-tetex-svn41059-30.fc25.noarch
> texlive-amsfonts-svn29208.3.04-30.fc25.noarch
> texlive-etex-pkg-svn39355-30.fc25.noarch
> texlive-lm-svn28119.2.004-30.fc25.noarch
> texlive-fp-svn15878.0-30.fc25.noarch
> texlive-mptopdf-svn41282-30.fc25.noarch
> texlive-euler-svn17261.2.5-30.fc25.noarch
> texlive-setspace-svn24881.6.7a-30.fc25.noarch
> texlive-tools-svn40934-30.fc25.noarch
> texlive-colortbl-svn29803.v1.0a-30.fc25.noarch
> texlive-natbib-svn20668.8.31b-30.fc25.noarch
> texlive-bibtex-svn40768-30.fc25.noarch
> texlive-gsftopk-svn40768-30.fc25.noarch
> texlive-mfware-svn40768-30.fc25.noarch
> texlive-tex-ini-files-svn40533-30.fc25.noarch
> texlive-texconfig-bin-svn29741.0-30.20160520.fc25.noarch
> libXmu-1.1.2-4.fc24.s390x
> libXcursor-1.1.14-6.fc24.s390x
> kbd-misc-2.0.3-3.fc24.noarch
> libutempter-1.1.6-8.fc24.s390x
> python-kitchen-1.2.4-2.fc24.noarch
> polkit-libs-0.113-5.fc24.s390x
> libgudev-230-3.fc24.s390x
> popt-devel-1.16-7.fc24.s390x
> make-4.1-5.fc24.s390x
> fakeroot-1.20.2-4.fc24.s390x
> blktrace-1.1.0-3.fc24.s390x
> hicolor-icon-theme-0.15-3.fc24.noarch
> usermode-1.111-8.fc24.s390x
> kbd-2.0.3-3.fc24.s390x
> libaio-devel-0.3.110-6.fc24.s390x
> web-assets-filesystem-5-4.fc24.noarch
> perl-IO-Socket-SSL-2.038-1.fc25.noarch
> python-backports-ssl_match_hostname-3.5.0.1-3.fc25.noarch
> mc-4.8.18-2.fc25.s390x
> expat-devel-2.2.0-1.fc25.s390x
> automake-1.15-7.fc25.noarch
> perl-File-ShareDir-1.102-7.fc25.noarch
> lua-5.3.3-3.fc25.s390x
> tcl-8.6.6-1.fc25.s390x
> gcc-objc-6.3.1-1.fc25.s390x
> libselinux-devel-2.5-13.fc25.s390x
> e2fsprogs-1.43.3-1.fc25.s390x
> perl-Storable-2.56-367.fc25.s390x
> libstdc++-static-6.3.1-1.fc25.s390x
> perl-Time-Local-1.250-1.fc25.noarch
> libwebp-0.5.2-1.fc25.s390x
> xkeyboard-config-2.19-1.1.fc25.noarch
> python-firewall-0.4.4.2-2.fc25.noarch
> texlive-xdvi-svn40768-30.fc25.noarch
> texlive-wasy2-ps-svn35830.0-30.fc25.noarch
> texlive-ltabptch-svn17533.1.74d-30.fc25.noarch
> texlive-sauerj-svn15878.0-30.fc25.noarch
> texlive-bookman-svn31835.0-30.fc25.noarch
> texlive-courier-svn35058.0-30.fc25.noarch
> texlive-mflogo-font-svn36898.1.002-30.fc25.noarch
> texlive-rsfs-svn15878.0-30.fc25.noarch
> texlive-zapfchan-svn31835.0-30.fc25.noarch
> texlive-cmap-svn41168-30.fc25.noarch
> texlive-parskip-svn19963.2.0-30.fc25.noarch
> texlive-sepnum-svn20186.2.0-30.fc25.noarch
> texlive-fancyhdr-svn15878.3.1-30.fc25.noarch
> texlive-pspicture-svn15878.0-30.fc25.noarch
> texlive-fpl-svn15878.1.002-30.fc25.noarch
> texlive-utopia-svn15878.0-30.fc25.noarch
> texlive-hyph-utf8-svn41189-30.fc25.noarch
> texlive-lua-alt-getopt-svn29349.0.7.0-30.fc25.noarch
> texlive-texlive-msg-translations-svn41431-30.fc25.noarch
> texlive-parallel-svn15878.0-30.fc25.noarch
> texlive-luatex-bin-svn41091-30.20160520.fc25.s390x
> texlive-lineno-svn21442.4.41-30.fc25.noarch
> texlive-kastrup-svn15878.0-30.fc25.noarch
> texlive-chngcntr-svn17157.1.0a-30.fc25.noarch
> texlive-lualibs-svn40370-30.fc25.noarch
> texlive-xunicode-svn30466.0.981-30.fc25.noarch
> texlive-l3packages-svn41246-30.fc25.noarch
> texlive-pgf-svn40966-30.fc25.noarch
> texlive-koma-script-svn41508-30.fc25.noarch
> texlive-currfile-svn40725-30.fc25.noarch
> texlive-luaotfload-svn40902-30.fc25.noarch
> texlive-ifplatform-svn21156.0.4-30.fc25.noarch
> texlive-showexpl-svn32737.v0.3l-30.fc25.noarch
> texlive-pst-3d-svn17257.1.10-30.fc25.noarch
> texlive-pst-node-svn40743-30.fc25.noarch
> texlive-pstricks-add-svn40744-30.fc25.noarch
> texlive-pst-pdf-svn31660.1.1v-30.fc25.noarch
> texlive-latex-bin-svn41438-30.fc25.noarch
> texlive-powerdot-svn38984-30.fc25.noarch
> texlive-sansmathaccent-svn30187.0-30.fc25.noarch
> texlive-typehtml-svn17134.0-30.fc25.noarch
> texlive-ucs-svn35853.2.2-30.fc25.noarch
> teckit-2.5.1-15.fc24.s390x
> texlive-dvipdfmx-svn41149-30.fc25.noarch
> texlive-collection-latex-svn41011-30.20160520.fc25.noarch
> netpbm-10.76.00-2.fc25.s390x
> libpath_utils-0.2.1-29.fc25.s390x
> nfs-utils-1.3.4-1.rc3.fc25.s390x
> ttmkfdir-3.0.9-48.fc24.s390x
> libcephfs_jni-devel-10.2.4-2.fc25.s390x
> pcre2-utf16-10.22-8.fc25.s390x
> keyutils-libs-devel-1.5.9-8.fc24.s390x
> libicu-devel-57.1-4.fc25.s390x
> attr-2.4.47-16.fc24.s390x
> harfbuzz-devel-1.3.2-1.fc25.s390x
> libidn-devel-1.33-1.fc25.s390x
> usbredir-0.7.1-2.fc24.s390x
> libnfs-1.9.8-2.fc24.s390x
> SDL2-2.0.5-2.fc25.s390x
> freetype-devel-2.6.5-1.fc25.s390x
> cairo-devel-1.14.8-1.fc25.s390x
> libepoxy-devel-1.3.1-3.fc25.s390x
> libcacard-devel-2.5.2-2.fc24.s390x
> lzo-devel-2.08-8.fc24.s390x
> libssh2-devel-1.8.0-1.fc25.s390x
> pcre-static-8.40-1.fc25.s390x
> qemu-sanity-check-nodeps-1.1.5-5.fc24.s390x
> libcap-devel-2.25-2.fc25.s390x
> alsa-lib-devel-1.1.1-2.fc25.s390x
> nss-util-3.28.1-1.0.fc25.s390x
> glusterfs-client-xlators-3.9.1-1.fc25.s390x
> nss-softokn-freebl-3.28.1-1.0.fc25.s390x
> libnl3-3.2.29-2.fc25.s390x
> python3-hawkey-0.6.3-6.1.fc25.s390x
> git-core-doc-2.9.3-2.fc25.s390x
> glusterfs-fuse-3.9.1-1.fc25.s390x
> gdk-pixbuf2-devel-2.36.4-1.fc25.s390x
> perl-Errno-1.25-382.fc25.s390x
> git-2.9.3-2.fc25.s390x
> glusterfs-server-3.9.1-1.fc25.s390x
> kernel-modules-4.9.5-200.fc25.s390x
> pulseaudio-libs-glib2-10.0-2.fc25.s390x
> libpsl-0.17.0-1.fc25.s390x
> glusterfs-api-devel-3.9.1-1.fc25.s390x
> nss-devel-3.28.1-1.3.fc25.s390x
> wpa_supplicant-2.6-1.fc25.s390x
> xemacs-filesystem-21.5.34-19.20170114hgd0e8ec0fe015.fc25.noarch
> opus-1.1.3-2.fc25.s390x
> copy-jdk-configs-2.0-1.fc25.noarch
> gpg-pubkey-a0a7badb-52844296
> fontpackages-filesystem-1.44-17.fc24.noarch
> readline-6.3-8.fc24.s390x
> cpio-2.12-3.fc24.s390x
> groff-base-1.22.3-8.fc24.s390x
> ilmbase-2.2.0-5.fc24.s390x
> p11-kit-trust-0.23.2-2.fc24.s390x
> OpenEXR-libs-2.2.0-5.fc24.s390x
> hesiod-3.2.1-6.fc24.s390x
> sysfsutils-2.1.0-19.fc24.s390x
> qrencode-libs-3.4.2-6.fc24.s390x
> GeoIP-1.6.9-2.fc24.s390x
> ocaml-srpm-macros-2-4.fc24.noarch
> libXcomposite-0.4.4-8.fc24.s390x
> procps-ng-3.3.10-11.fc24.s390x
> GConf2-3.2.6-16.fc24.s390x
> mailx-12.5-19.fc24.s390x
> xz-devel-5.2.2-2.fc24.s390x
> fedora-logos-22.0.0-3.fc24.s390x
> telnet-0.17-65.fc24.s390x
> gpg-pubkey-e372e838-56fd7943
> fedora-repos-25-1.noarch
> ncurses-libs-6.0-6.20160709.fc25.s390x
> lua-libs-5.3.3-3.fc25.s390x
> kmod-libs-23-1.fc25.s390x
> libseccomp-2.3.1-1.fc25.s390x
> perl-parent-0.236-1.fc25.noarch
> libICE-1.0.9-5.fc25.s390x
> ipset-libs-6.29-1.fc25.s390x
> perl-TermReadKey-2.37-1.fc25.s390x
> dhcp-libs-4.3.5-1.fc25.s390x
> gmp-devel-6.1.1-1.fc25.s390x
> ncurses-c++-libs-6.0-6.20160709.fc25.s390x
> python-pip-8.1.2-2.fc25.noarch
> gzip-1.8-1.fc25.s390x
> harfbuzz-1.3.2-1.fc25.s390x
> python2-iniparse-0.4-20.fc25.noarch
> libfdisk-2.28.2-1.fc25.s390x
> python3-iniparse-0.4-20.fc25.noarch
> python3-gobject-base-3.22.0-1.fc25.s390x
> python3-kickstart-2.32-1.fc25.noarch
> python2-yubico-1.3.2-3.fc25.noarch
> python-idna-2.0-4.fc25.noarch
> nss-pem-1.0.2-2.fc25.s390x
> perl-Net-SSLeay-1.78-1.fc25.s390x
> krb5-workstation-1.14.4-4.fc25.s390x
> libepoxy-1.3.1-3.fc25.s390x
> drpm-0.3.0-3.fc25.s390x
> libsmartcols-2.28.2-1.fc25.s390x
> s390utils-ziomon-1.36.0-1.fc25.s390x
> librepo-1.7.18-3.fc25.s390x
> glib-networking-2.50.0-1.fc25.s390x
> librsvg2-2.40.16-2.fc25.s390x
> gnat-srpm-macros-4-1.fc25.noarch
> webkitgtk3-2.4.11-3.fc25.s390x
> libXaw-1.0.13-4.fc25.s390x
> sudo-1.8.18p1-1.fc25.s390x
> systemtap-sdt-devel-3.1-0.20160725git91bfb36.fc25.s390x
> xorg-x11-font-utils-7.5-32.fc25.s390x
> python-decoratortools-1.8-12.fc25.noarch
> m17n-db-1.7.0-7.fc25.noarch
> hardlink-1.1-1.fc25.s390x
> glibc-common-2.24-4.fc25.s390x
> libcom_err-1.43.3-1.fc25.s390x
> grep-2.27-1.fc25.s390x
> iproute-4.6.0-6.fc25.s390x
> e2fsprogs-libs-1.43.3-1.fc25.s390x
> curl-7.51.0-4.fc25.s390x
> libvorbis-1.3.5-1.fc25.s390x
> python2-dateutil-2.6.0-1.fc25.noarch
> python3-firewall-0.4.4.2-2.fc25.noarch
> libXpm-3.5.12-1.fc25.s390x
> systemd-pam-231-12.fc25.s390x
> mesa-libgbm-13.0.3-1.fc25.s390x
> rpm-build-4.13.0-6.fc25.s390x
> openssl-libs-1.0.2j-3.fc25.s390x
> python2-smmap-2.0.1-1.fc25.noarch
> bind99-libs-9.9.9-4.P5.fc25.s390x
> kernel-4.9.3-200.fc25.s390x
> gcc-gdb-plugin-6.3.1-1.fc25.s390x
> selinux-policy-targeted-3.13.1-225.6.fc25.noarch
> perl-Time-HiRes-1.9741-1.fc25.s390x
> npth-1.3-1.fc25.s390x
> poppler-data-0.4.7-6.fc25.noarch
> nspr-devel-4.13.1-1.fc25.s390x
> libcephfs1-10.2.4-2.fc25.s390x
> wayland-devel-1.12.0-1.fc25.s390x
> librbd1-10.2.4-2.fc25.s390x
> libxcb-devel-1.12-1.fc25.s390x
> mesa-libGL-devel-13.0.3-1.fc25.s390x
> perl-encoding-2.19-5.fc25.s390x
> libsndfile-1.0.27-1.fc25.s390x
> python3-cssselect-0.9.2-1.fc25.noarch
> perl-Digest-MD5-2.55-2.fc25.s390x
> texlive-tetex-bin-svn36770.0-30.20160520.fc25.noarch
> texlive-etoolbox-svn38031.2.2a-30.fc25.noarch
> texlive-babel-svn40706-30.fc25.noarch
> texlive-fancybox-svn18304.1.4-30.fc25.noarch
> texlive-xkeyval-svn35741.2.7a-30.fc25.noarch
> texlive-pdftex-def-svn22653.0.06d-30.fc25.noarch
> texlive-makeindex-bin-svn40473-30.20160520.fc25.s390x
> texlive-pdftex-bin-svn40987-30.20160520.fc25.s390x
> texlive-pst-ovl-svn40873-30.fc25.noarch
> texlive-crop-svn15878.1.5-30.fc25.noarch
> texlive-manfnt-font-svn35799.0-30.fc25.noarch
> texlive-txfonts-svn15878.0-30.fc25.noarch
> texlive-ntgclass-svn15878.2.1a-30.fc25.noarch
> texlive-dvisvgm-def-svn41011-30.fc25.noarch
> texlive-ec-svn25033.1.0-30.fc25.noarch
> texlive-etex-svn37057.0-30.fc25.noarch
> texlive-texlive-en-svn41185-30.fc25.noarch
> texlive-graphics-def-svn41879-30.fc25.noarch
> texlive-iftex-svn29654.0.2-30.fc25.noarch
> texlive-pst-math-svn34786.0.63-30.fc25.noarch
> texlive-bera-svn20031.0-30.fc25.noarch
> texlive-ms-svn29849.0-30.fc25.noarch
> texlive-luaotfload-bin-svn34647.0-30.20160520.fc25.noarch
> texlive-listings-svn37534.1.6-30.fc25.noarch
> texlive-pst-fill-svn15878.1.01-30.fc25.noarch
> texlive-pst-pdf-bin-svn7838.0-30.20160520.fc25.noarch
> texlive-pst-slpe-svn24391.1.31-30.fc25.noarch
> texlive-seminar-svn34011.1.62-30.fc25.noarch
> texlive-l3experimental-svn41163-30.fc25.noarch
> texlive-collection-fontsrecommended-svn35830.0-30.20160520.fc25.noarch
> gettext-libs-0.19.8.1-3.fc25.s390x
> java-1.8.0-openjdk-headless-1.8.0.111-5.b16.fc25.s390x
> pcre2-utf32-10.22-8.fc25.s390x
> at-spi2-atk-devel-2.22.0-1.fc25.s390x
> wayland-protocols-devel-1.7-1.fc25.noarch
> virglrenderer-0.5.0-1.20160411git61846f92f.fc25.s390x
> libcacard-2.5.2-2.fc24.s390x
> pixman-devel-0.34.0-2.fc24.s390x
> libacl-devel-2.2.52-11.fc24.s390x
> libnfs-devel-1.9.8-2.fc24.s390x
> texi2html-5.0-4.fc24.noarch
> libseccomp-devel-2.3.1-1.fc25.s390x
> perl-libs-5.24.1-382.fc25.s390x
> libxkbcommon-0.7.1-1.fc25.s390x
> git-core-2.9.3-2.fc25.s390x
> nss-softokn-freebl-devel-3.28.1-1.0.fc25.s390x
> gtk-update-icon-cache-3.22.7-1.fc25.s390x
> vim-filesystem-8.0.206-1.fc25.s390x
> libX11-common-1.6.4-4.fc25.noarch
> gtk3-devel-3.22.7-1.fc25.s390x
> python2-dnf-1.1.10-5.fc25.noarch
> vim-minimal-8.0.206-1.fc25.s390x
> GeoIP-GeoLite-data-2017.01-1.fc25.noarch
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
> freetype-2.6.5-1.fc25.s390x
> libcap-ng-0.7.8-1.fc25.s390x
> gdbm-1.12-1.fc25.s390x
> binutils-2.26.1-1.fc25.s390x
> lcms2-2.8-2.fc25.s390x
> libcomps-0.1.7-5.fc25.s390x
> less-481-6.fc25.s390x
> apr-1.5.2-4.fc25.s390x
> perl-constant-1.33-367.fc25.noarch
> perl-Data-Dumper-2.161-1.fc25.s390x
> ipcalc-0.1.8-1.fc25.s390x
> perl-Pod-Perldoc-3.27-1.fc25.noarch
> libteam-1.26-1.fc25.s390x
> gmp-c++-6.1.1-1.fc25.s390x
> fontconfig-2.12.1-1.fc25.s390x
> enchant-1.6.0-14.fc25.s390x
> json-glib-1.2.2-1.fc25.s390x
> pyliblzma-0.5.3-16.fc25.s390x
> libsepol-devel-2.5-10.fc25.s390x
> python3-libs-3.5.2-4.fc25.s390x
> python3-ordered-set-2.0.0-4.fc25.noarch
> python3-rpmconf-1.0.18-2.fc25.noarch
> python-ipaddress-1.0.16-3.fc25.noarch
> python2-kerberos-1.2.5-1.fc25.s390x
> python2-pysocks-1.5.6-5.fc25.noarch
> fipscheck-lib-1.4.1-11.fc25.s390x
> libatomic_ops-7.4.4-1.fc25.s390x
> net-snmp-agent-libs-5.7.3-13.fc25.s390x
> util-linux-2.28.2-1.fc25.s390x
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
> libtiff-4.0.7-1.fc25.s390x
> desktop-file-utils-0.23-2.fc25.s390x
> python2-cccolutils-1.4-1.fc25.s390x
> libcurl-7.51.0-4.fc25.s390x
> rpm-plugin-systemd-inhibit-4.13.0-6.fc25.s390x
> cups-libs-2.2.0-5.fc25.s390x
> python2-lxml-3.7.2-1.fc25.s390x
> redhat-rpm-config-45-1.fc25.noarch
> elfutils-libs-0.168-1.fc25.s390x
> device-mapper-event-libs-1.02.136-3.fc25.s390x
> lvm2-libs-2.02.167-3.fc25.s390x
> elfutils-0.168-1.fc25.s390x
> openssh-7.4p1-1.fc25.s390x
> python2-gitdb-2.0.0-1.fc25.noarch
> openssh-server-7.4p1-1.fc25.s390x
> gcc-gfortran-6.3.1-1.fc25.s390x
> rpm-devel-4.13.0-6.fc25.s390x
> libselinux-python-2.5-13.fc25.s390x
> openjpeg2-2.1.2-3.fc25.s390x
> js-jquery-2.2.4-1.fc25.noarch
> boost-thread-1.60.0-10.fc25.s390x
> json-c-0.12-7.fc24.s390x
> ghostscript-x11-9.20-5.fc25.s390x
> libdrm-devel-2.4.74-1.fc25.s390x
> libuuid-devel-2.28.2-1.fc25.s390x
> librbd-devel-10.2.4-2.fc25.s390x
> libXcursor-devel-1.1.14-6.fc24.s390x
> python3-beautifulsoup4-4.5.3-1.fc25.noarch
> texlive-kpathsea-svn41139-30.fc25.noarch
> texlive-amsmath-svn41561-30.fc25.noarch
> texlive-thumbpdf-svn34621.3.16-30.fc25.noarch
> texlive-multido-svn18302.1.42-30.fc25.noarch
> texlive-float-svn15878.1.3d-30.fc25.noarch
> texlive-psnfss-svn33946.9.2a-30.fc25.noarch
> texlive-wasy-svn35831.0-30.fc25.noarch
> texlive-makeindex-svn40768-30.fc25.noarch
> texlive-pdftex-svn41149-30.fc25.noarch
> texlive-enumitem-svn24146.3.5.2-30.fc25.noarch
> texlive-microtype-svn41127-30.fc25.noarch
> texlive-helvetic-svn31835.0-30.fc25.noarch
> texlive-times-svn35058.0-30.fc25.noarch
> texlive-mdwtools-svn15878.1.05.4-30.fc25.noarch
> texlive-babel-english-svn30264.3.3p-30.fc25.noarch
> texlive-cmextra-svn32831.0-30.fc25.noarch
> texlive-enctex-svn34957.0-30.fc25.noarch
> texlive-texlive-docindex-svn41430-30.fc25.noarch
> texlive-ifetex-svn24853.1.2-30.fc25.noarch
> texlive-mparhack-svn15878.1.4-30.fc25.noarch
> texlive-paralist-svn39247-30.fc25.noarch
> texlive-algorithms-svn38085.0.1-30.fc25.noarch
> texlive-geometry-svn19716.5.6-30.fc25.noarch
> texlive-fontspec-svn41262-30.fc25.noarch
> texlive-oberdiek-svn41346-30.fc25.noarch
> texlive-pst-eps-svn15878.1.0-30.fc25.noarch
> texlive-pstricks-svn41321-30.fc25.noarch
> texlive-pst-blur-svn15878.2.0-30.fc25.noarch
> texlive-jknapltx-svn19440.0-30.fc25.noarch
> texlive-breqn-svn38099.0.98d-30.fc25.noarch
> texlive-collection-basic-svn41149-30.20160520.fc25.noarch
> latex2html-2012-7.fc24.noarch
> lksctp-tools-1.0.16-5.fc24.s390x
> vte291-0.46.1-1.fc25.s390x
> openssl-devel-1.0.2j-3.fc25.s390x
> at-spi2-core-devel-2.22.0-1.fc25.s390x
> libfdt-1.4.2-1.fc25.s390x
> libXft-devel-2.3.2-4.fc24.s390x
> libattr-devel-2.4.47-16.fc24.s390x
> libiscsi-devel-1.15.0-2.fc24.s390x
> gettext-0.19.8.1-3.fc25.s390x
> libjpeg-turbo-devel-1.5.1-0.fc25.s390x
> glusterfs-libs-3.9.1-1.fc25.s390x
> glusterfs-api-3.9.1-1.fc25.s390x
> hawkey-0.6.3-6.1.fc25.s390x
> nss-softokn-devel-3.28.1-1.0.fc25.s390x
> glusterfs-cli-3.9.1-1.fc25.s390x
> vim-common-8.0.206-1.fc25.s390x
> libX11-1.6.4-4.fc25.s390x
> pulseaudio-libs-devel-10.0-2.fc25.s390x
> dnf-yum-1.1.10-5.fc25.noarch
> tzdata-java-2016j-2.fc25.noarch
> ccache-3.3.3-1.fc25.s390x
> gpg-pubkey-8e1431d5-53bcbac7
> zlib-1.2.8-10.fc24.s390x
> sed-4.2.2-15.fc24.s390x
> p11-kit-0.23.2-2.fc24.s390x
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
> python-rpm-macros-3-10.fc25.noarch
> info-6.1-3.fc25.s390x
> libuuid-2.28.2-1.fc25.s390x
> iptables-libs-1.6.0-2.fc25.s390x
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
> crypto-policies-20160921-2.git75b9b04.fc25.noarch
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
> pango-1.40.3-1.fc25.s390x
> fpc-srpm-macros-1.0-1.fc25.noarch
> kernel-core-4.8.8-300.fc25.s390x
> fedora-upgrade-25.2-1.fc25.noarch
> net-tools-2.0-0.38.20160329git.fc25.s390x
> libuser-0.62-4.fc25.s390x
> screen-4.4.0-4.fc25.s390x
> man-db-2.7.5-3.fc25.s390x
> sqlite-3.14.2-1.fc25.s390x
> python-systemd-doc-232-1.fc25.s390x
> pcre-8.40-1.fc25.s390x
> libdb-5.3.28-16.fc25.s390x
> lz4-1.7.5-1.fc25.s390x
> tar-1.29-3.fc25.s390x
> emacs-common-25.1-3.fc25.s390x
> perl-threads-shared-1.54-1.fc25.s390x
> unzip-6.0-31.fc25.s390x
> mesa-libglapi-13.0.3-1.fc25.s390x
> rpm-libs-4.13.0-6.fc25.s390x
> selinux-policy-3.13.1-225.6.fc25.noarch
> pcre-utf16-8.40-1.fc25.s390x
> bodhi-client-0.9.12.2-6.fc25.noarch
> rpmlint-1.9-5.fc25.noarch
> glibc-headers-2.24-4.fc25.s390x
> dbus-1.11.8-1.fc25.s390x
> kernel-core-4.9.3-200.fc25.s390x
> cairo-1.14.8-1.fc25.s390x
> ca-certificates-2017.2.11-1.0.fc25.noarch
> openssh-clients-7.4p1-1.fc25.s390x
> python2-GitPython-2.1.1-2.fc25.noarch
> mariadb-libs-10.1.20-1.fc25.s390x
> NetworkManager-glib-1.4.4-3.fc25.s390x
> gcc-go-6.3.1-1.fc25.s390x
> cracklib-dicts-2.9.6-4.fc25.s390x
> iproute-tc-4.6.0-6.fc25.s390x
> libselinux-python3-2.5-13.fc25.s390x
> strace-4.15-1.fc25.s390x
> python2-enchant-1.6.8-1.fc25.noarch
> boost-iostreams-1.60.0-10.fc25.s390x
> bluez-libs-5.43-1.fc25.s390x
> ghostscript-9.20-5.fc25.s390x
> userspace-rcu-0.9.2-2.fc25.s390x
> mesa-libwayland-egl-devel-13.0.3-1.fc25.s390x
> libXext-devel-1.3.3-4.fc24.s390x
> libXrandr-devel-1.5.1-1.fc25.s390x
> perl-XML-XPath-1.39-1.fc25.noarch
> python3-lxml-3.7.2-1.fc25.s390x
> texlive-texlive.infra-bin-svn40312-30.20160520.fc25.s390x
> texlive-ifxetex-svn19685.0.5-30.fc25.noarch
> texlive-thumbpdf-bin-svn6898.0-30.20160520.fc25.noarch
> texlive-babelbib-svn25245.1.31-30.fc25.noarch
> texlive-index-svn24099.4.1beta-30.fc25.noarch
> texlive-caption-svn41409-30.fc25.noarch
> texlive-bibtex-bin-svn40473-30.20160520.fc25.s390x
> texlive-mfware-bin-svn40473-30.20160520.fc25.s390x
> texlive-texconfig-svn40768-30.fc25.noarch
> texlive-footmisc-svn23330.5.5b-30.fc25.noarch
> texlive-psfrag-svn15878.3.04-30.fc25.noarch
> texlive-eurosym-svn17265.1.4_subrfix-30.fc25.noarch
> texlive-symbol-svn31835.0-30.fc25.noarch
> texlive-euenc-svn19795.0.1h-30.fc25.noarch
> texlive-textcase-svn15878.0-30.fc25.noarch
> texlive-charter-svn15878.0-30.fc25.noarch
> texlive-wasysym-svn15878.2.0-30.fc25.noarch
> texlive-mflogo-svn38628-30.fc25.noarch
> texlive-soul-svn15878.2.4-30.fc25.noarch
> texlive-marginnote-svn41382-30.fc25.noarch
> texlive-filecontents-svn24250.1.3-30.fc25.noarch
> texlive-tipa-svn29349.1.3-30.fc25.noarch
> texlive-xcolor-svn41044-30.fc25.noarch
> texlive-breakurl-svn29901.1.40-30.fc25.noarch
> texlive-attachfile-svn38830-30.fc25.noarch
> texlive-pst-coil-svn37377.1.07-30.fc25.noarch
> texlive-auto-pst-pdf-svn23723.0.6-30.fc25.noarch
> texlive-ctable-svn38672-30.fc25.noarch
> texlive-extsizes-svn17263.1.4a-30.fc25.noarch
> texlive-beamer-svn36461.3.36-30.fc25.noarch
> texlive-dvipdfmx-bin-svn40273-30.20160520.fc25.s390x
> netpbm-progs-10.76.00-2.fc25.s390x
> vte-profile-0.46.1-1.fc25.s390x
> krb5-devel-1.14.4-4.fc25.s390x
> dbus-devel-1.11.8-1.fc25.s390x
> sqlite-devel-3.14.2-1.fc25.s390x
> libiscsi-1.15.0-2.fc24.s390x
> fontconfig-devel-2.12.1-1.fc25.s390x
> libfdt-devel-1.4.2-1.fc25.s390x
> ceph-devel-compat-10.2.4-2.fc25.s390x
> zlib-static-1.2.8-10.fc24.s390x
> chrpath-0.16-3.fc24.s390x
> python-2.7.13-1.fc25.s390x
> nss-3.28.1-1.3.fc25.s390x
> python2-hawkey-0.6.3-6.1.fc25.s390x
> gdk-pixbuf2-modules-2.36.4-1.fc25.s390x
> perl-Git-2.9.3-2.fc25.noarch
> kernel-core-4.9.5-200.fc25.s390x
> publicsuffix-list-dafsa-20170116-1.fc25.noarch
> perl-SelfLoader-1.23-382.fc25.noarch
> perl-open-1.10-382.fc25.noarch
> gpgme-1.8.0-8.fc25.s390x
> =3D=3D=3D TEST BEGIN =3D=3D=3D
> Using CC: /home/fam/bin/cc
> Install prefix    /var/tmp/patchew-tester-tmp-i2k78q7z/src/install
> BIOS directory    /var/tmp/patchew-tester-tmp-i2k78q7z/src/install/shar=
e/qemu
> binary directory  /var/tmp/patchew-tester-tmp-i2k78q7z/src/install/bin
> library directory /var/tmp/patchew-tester-tmp-i2k78q7z/src/install/lib
> module directory  /var/tmp/patchew-tester-tmp-i2k78q7z/src/install/lib/=
qemu
> libexec directory /var/tmp/patchew-tester-tmp-i2k78q7z/src/install/libe=
xec
> include directory /var/tmp/patchew-tester-tmp-i2k78q7z/src/install/incl=
ude
> config directory  /var/tmp/patchew-tester-tmp-i2k78q7z/src/install/etc
> local state directory   /var/tmp/patchew-tester-tmp-i2k78q7z/src/instal=
l/var
> Manual directory  /var/tmp/patchew-tester-tmp-i2k78q7z/src/install/shar=
e/man
> ELF interp prefix /usr/gnemul/qemu-%M
> Source path       /var/tmp/patchew-tester-tmp-i2k78q7z/src
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
nclude/cacard -I/usr/include/nss3 -I/usr/include/nspr4 -I/usr/include/gli=
b-2.0 -I/usr/lib64/glib-2.0/include -I/usr/include/libusb-1.0=20
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
> GTK support       yes (3.22.7)
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
> Archipelago support no
> gcov              gcov
> gcov enabled      no
> TPM support       yes
> libssh2 support   yes
> TPM passthrough   no
> QOM debugging     yes
> lzo support       yes
> snappy support    yes
> bzip2 support     yes
> NUMA host support no
> tcmalloc support  no
> jemalloc support  no
> avx2 optimization no
> replication support yes
>   GEN     aarch64-softmmu/config-devices.mak.tmp
>   GEN     alpha-softmmu/config-devices.mak.tmp
>   GEN     arm-softmmu/config-devices.mak.tmp
>   GEN     cris-softmmu/config-devices.mak.tmp
>   GEN     cris-softmmu/config-devices.mak
>   GEN     i386-softmmu/config-devices.mak.tmp
>   GEN     arm-softmmu/config-devices.mak
>   GEN     lm32-softmmu/config-devices.mak.tmp
>   GEN     i386-softmmu/config-devices.mak
>   GEN     lm32-softmmu/config-devices.mak
>   GEN     m68k-softmmu/config-devices.mak.tmp
>   GEN     microblazeel-softmmu/config-devices.mak.tmp
>   GEN     alpha-softmmu/config-devices.mak
>   GEN     microblaze-softmmu/config-devices.mak.tmp
>   GEN     m68k-softmmu/config-devices.mak
>   GEN     microblazeel-softmmu/config-devices.mak
>   GEN     mips64el-softmmu/config-devices.mak.tmp
>   GEN     mips64-softmmu/config-devices.mak.tmp
>   GEN     microblaze-softmmu/config-devices.mak
>   GEN     mipsel-softmmu/config-devices.mak.tmp
>   GEN     mips64el-softmmu/config-devices.mak
>   GEN     aarch64-softmmu/config-devices.mak
>   GEN     mips-softmmu/config-devices.mak.tmp
>   GEN     mipsel-softmmu/config-devices.mak
>   GEN     nios2-softmmu/config-devices.mak.tmp
>   GEN     mips64-softmmu/config-devices.mak
>   GEN     or1k-softmmu/config-devices.mak.tmp
>   GEN     moxie-softmmu/config-devices.mak.tmp
>   GEN     mips-softmmu/config-devices.mak
>   GEN     nios2-softmmu/config-devices.mak
>   GEN     or1k-softmmu/config-devices.mak
>   GEN     ppc64-softmmu/config-devices.mak.tmp
>   GEN     ppcemb-softmmu/config-devices.mak.tmp
>   GEN     ppc-softmmu/config-devices.mak.tmp
>   GEN     ppcemb-softmmu/config-devices.mak
>   GEN     s390x-softmmu/config-devices.mak.tmp
>   GEN     s390x-softmmu/config-devices.mak
>   GEN     sh4eb-softmmu/config-devices.mak.tmp
>   GEN     ppc64-softmmu/config-devices.mak
>   GEN     sh4eb-softmmu/config-devices.mak
>   GEN     sh4-softmmu/config-devices.mak.tmp
>   GEN     ppc-softmmu/config-devices.mak
>   GEN     sparc64-softmmu/config-devices.mak.tmp
>   GEN     sparc-softmmu/config-devices.mak.tmp
>   GEN     moxie-softmmu/config-devices.mak
>   GEN     sparc64-softmmu/config-devices.mak
>   GEN     sh4-softmmu/config-devices.mak
>   GEN     tricore-softmmu/config-devices.mak.tmp
>   GEN     sparc-softmmu/config-devices.mak
>   GEN     unicore32-softmmu/config-devices.mak.tmp
>   GEN     tricore-softmmu/config-devices.mak
>   GEN     xtensaeb-softmmu/config-devices.mak.tmp
>   GEN     xtensa-softmmu/config-devices.mak.tmp
>   GEN     unicore32-softmmu/config-devices.mak
>   GEN     aarch64-linux-user/config-devices.mak.tmp
>   GEN     x86_64-softmmu/config-devices.mak.tmp
>   GEN     xtensa-softmmu/config-devices.mak
>   GEN     aarch64-linux-user/config-devices.mak
>   GEN     alpha-linux-user/config-devices.mak.tmp
>   GEN     armeb-linux-user/config-devices.mak.tmp
>   GEN     xtensaeb-softmmu/config-devices.mak
>   GEN     x86_64-softmmu/config-devices.mak
>   GEN     cris-linux-user/config-devices.mak.tmp
>   GEN     armeb-linux-user/config-devices.mak
>   GEN     hppa-linux-user/config-devices.mak.tmp
>   GEN     alpha-linux-user/config-devices.mak
>   GEN     arm-linux-user/config-devices.mak.tmp
>   GEN     cris-linux-user/config-devices.mak
>   GEN     i386-linux-user/config-devices.mak.tmp
>   GEN     m68k-linux-user/config-devices.mak.tmp
>   GEN     hppa-linux-user/config-devices.mak
>   GEN     microblazeel-linux-user/config-devices.mak.tmp
>   GEN     i386-linux-user/config-devices.mak
>   GEN     m68k-linux-user/config-devices.mak
>   GEN     mips64el-linux-user/config-devices.mak.tmp
>   GEN     microblaze-linux-user/config-devices.mak.tmp
>   GEN     microblazeel-linux-user/config-devices.mak
>   GEN     mips64-linux-user/config-devices.mak.tmp
>   GEN     arm-linux-user/config-devices.mak
>   GEN     mips64el-linux-user/config-devices.mak
>   GEN     mipsel-linux-user/config-devices.mak.tmp
>   GEN     mips-linux-user/config-devices.mak.tmp
>   GEN     mips64-linux-user/config-devices.mak
>   GEN     microblaze-linux-user/config-devices.mak
>   GEN     mipsn32el-linux-user/config-devices.mak.tmp
>   GEN     mips-linux-user/config-devices.mak
>   GEN     mipsn32-linux-user/config-devices.mak.tmp
>   GEN     nios2-linux-user/config-devices.mak.tmp
>   GEN     mipsel-linux-user/config-devices.mak
>   GEN     or1k-linux-user/config-devices.mak.tmp
>   GEN     mipsn32-linux-user/config-devices.mak
>   GEN     nios2-linux-user/config-devices.mak
>   GEN     mipsn32el-linux-user/config-devices.mak
>   GEN     ppc64abi32-linux-user/config-devices.mak.tmp
>   GEN     ppc64le-linux-user/config-devices.mak.tmp
>   GEN     ppc64-linux-user/config-devices.mak.tmp
>   GEN     ppc64abi32-linux-user/config-devices.mak
>   GEN     or1k-linux-user/config-devices.mak
>   GEN     ppc-linux-user/config-devices.mak.tmp
>   GEN     ppc64-linux-user/config-devices.mak
>   GEN     s390x-linux-user/config-devices.mak.tmp
>   GEN     ppc64le-linux-user/config-devices.mak
>   GEN     sh4eb-linux-user/config-devices.mak.tmp
>   GEN     ppc-linux-user/config-devices.mak
>   GEN     sparc32plus-linux-user/config-devices.mak.tmp
>   GEN     s390x-linux-user/config-devices.mak
>   GEN     sh4eb-linux-user/config-devices.mak
>   GEN     sparc64-linux-user/config-devices.mak.tmp
>   GEN     sparc-linux-user/config-devices.mak.tmp
>   GEN     sparc32plus-linux-user/config-devices.mak
>   GEN     sh4-linux-user/config-devices.mak.tmp
>   GEN     tilegx-linux-user/config-devices.mak.tmp
>   GEN     sh4-linux-user/config-devices.mak
>   GEN     sparc64-linux-user/config-devices.mak
>   GEN     x86_64-linux-user/config-devices.mak.tmp
>   GEN     tilegx-linux-user/config-devices.mak
>   GEN     sparc-linux-user/config-devices.mak
>   GEN     config-host.h
>   GEN     qemu-options.def
>   GEN     x86_64-linux-user/config-devices.mak
>   GEN     qmp-commands.h
>   GEN     qapi-types.h
>   GEN     qapi-visit.h
>   GEN     qapi-event.h
>   GEN     qmp-introspect.h
>   GEN     trace/generated-tcg-tracers.h
>   GEN     trace/generated-helpers-wrappers.h
>   GEN     trace/generated-helpers.h
>   GEN     module_block.h
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
>   GEN     backends/trace.h
>   GEN     hw/block/trace.h
>   GEN     block/trace.h
>   GEN     hw/block/dataplane/trace.h
>   GEN     hw/char/trace.h
>   GEN     hw/intc/trace.h
>   GEN     hw/net/trace.h
>   GEN     hw/virtio/trace.h
>   GEN     hw/audio/trace.h
>   GEN     hw/misc/trace.h
>   GEN     hw/usb/trace.h
>   GEN     hw/nvram/trace.h
>   GEN     hw/scsi/trace.h
>   GEN     hw/display/trace.h
>   GEN     hw/input/trace.h
>   GEN     hw/timer/trace.h
>   GEN     hw/dma/trace.h
>   GEN     hw/sparc/trace.h
>   GEN     hw/isa/trace.h
>   GEN     hw/sd/trace.h
>   GEN     hw/mem/trace.h
>   GEN     hw/i386/xen/trace.h
>   GEN     hw/i386/trace.h
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
>   GEN     target/sparc/trace.h
>   GEN     target/s390x/trace.h
>   GEN     qom/trace.h
>   GEN     linux-user/trace.h
>   GEN     target/ppc/trace.h
>   GEN     qapi/trace.h
>   GEN     config-all-devices.mak
>   CC      tests/qemu-iotests/socket_scm_helper.o
>   GEN     qemu-monitor.texi
>   GEN     qemu-options.texi
>   GEN     version.texi
>   GEN     qemu-img-cmds.texi
>   GEN     qemu-monitor-info.texi
>   GEN     qemu-nbd.8
>   GEN     qemu-ga.8
>   GEN     qemu-qapi.texi
>   GEN     qemu-ga-qapi.texi
>   GEN     qga/qapi-generated/qga-qapi-types.h
>   GEN     fsdev/virtfs-proxy-helper.1
>   GEN     qga/qapi-generated/qga-qapi-visit.h
>   GEN     qga/qapi-generated/qga-qapi-types.c
>   GEN     qga/qapi-generated/qga-qmp-commands.h
>   GEN     qga/qapi-generated/qga-qapi-visit.c
>   GEN     trace-root.c
>   GEN     qga/qapi-generated/qga-qmp-marshal.c
>   GEN     util/trace.c
>   GEN     crypto/trace.c
>   GEN     io/trace.c
>   GEN     migration/trace.c
>   GEN     block/trace.c
>   GEN     backends/trace.c
>   GEN     hw/block/trace.c
>   GEN     hw/block/dataplane/trace.c
>   GEN     hw/char/trace.c
>   GEN     hw/intc/trace.c
>   GEN     hw/net/trace.c
>   GEN     hw/virtio/trace.c
>   GEN     hw/misc/trace.c
>   GEN     hw/usb/trace.c
>   GEN     hw/audio/trace.c
>   GEN     hw/scsi/trace.c
>   GEN     hw/nvram/trace.c
>   GEN     hw/input/trace.c
>   GEN     hw/timer/trace.c
>   GEN     hw/display/trace.c
>   GEN     hw/dma/trace.c
>   GEN     hw/sparc/trace.c
>   GEN     hw/isa/trace.c
>   GEN     hw/mem/trace.c
>   GEN     hw/sd/trace.c
>   GEN     hw/i386/trace.c
>   GEN     hw/i386/xen/trace.c
>   GEN     hw/9pfs/trace.c
>   GEN     hw/ppc/trace.c
>   GEN     hw/pci/trace.c
>   GEN     hw/s390x/trace.c
>   GEN     hw/vfio/trace.c
>   GEN     hw/acpi/trace.c
>   GEN     hw/arm/trace.c
>   GEN     hw/alpha/trace.c
>   GEN     hw/xen/trace.c
>   GEN     ui/trace.c
>   GEN     audio/trace.c
>   GEN     target/arm/trace.c
>   GEN     net/trace.c
>   GEN     target/i386/trace.c
>   GEN     target/sparc/trace.c
>   GEN     target/ppc/trace.c
>   GEN     target/s390x/trace.c
>   GEN     qom/trace.c
>   GEN     linux-user/trace.c
>   GEN     qapi/trace.c
>   GEN     qmp-introspect.c
>   GEN     qapi-types.c
>   GEN     qapi-visit.c
>   GEN     qapi-event.c
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
>   CC      util/hexdump.o
>   CC      util/crc32c.o
>   CC      util/uuid.o
>   CC      util/throttle.o
>   CC      util/readline.o
>   CC      util/getauxval.o
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
>   CC      util/qdist.o
>   CC      util/qht.o
>   CC      util/range.o
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
>   CC      stubs/fdset.o
>   CC      stubs/error-printf.o
>   CC      stubs/dump.o
>   CC      stubs/get-vm-name.o
>   CC      stubs/gdbstub.o
>   CC      stubs/iothread.o
>   CC      stubs/iothread-lock.o
>   CC      stubs/is-daemonized.o
>   CC      stubs/machine-init-done.o
>   CC      stubs/migr-blocker.o
>   CC      stubs/notify-event.o
>   CC      stubs/monitor.o
>   CC      stubs/qtest.o
>   CC      stubs/replay.o
>   CC      stubs/runstate-check.o
>   CC      stubs/set-fd-handler.o
>   CC      stubs/slirp.o
>   CC      stubs/sysbus.o
>   CC      stubs/trace-control.o
>   CC      stubs/uuid.o
>   CC      stubs/vm-stop.o
>   CC      stubs/vmstate.o
>   CC      stubs/qmp_pc_dimm_device_list.o
>   CC      stubs/target-monitor-defs.o
>   CC      stubs/target-get-monitor-def.o
>   CC      stubs/pc_madt_cpu_entry.o
>   CC      contrib/ivshmem-client/ivshmem-client.o
>   CC      contrib/ivshmem-client/main.o
>   CC      contrib/ivshmem-server/ivshmem-server.o
>   CC      contrib/ivshmem-server/main.o
>   CC      qemu-nbd.o
>   CC      async.o
>   CC      thread-pool.o
>   CC      block.o
>   CC      blockjob.o
>   CC      main-loop.o
>   CC      iohandler.o
>   CC      qemu-timer.o
>   CC      qemu-io-cmds.o
>   CC      aio-posix.o
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
>   CC      block/qed.o
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
>   CC      block/mirror.o
>   CC      block/commit.o
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
>   CC      nbd/server.o
>   CC      block/crypto.o
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
>   CC      crypto/hmac-nettle.o
>   CC      crypto/hmac.o
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
>   CC      io/channel-command.o
>   CC      io/channel-buffer.o
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
>   CC      blockdev-nbd.o
>   CC      iothread.o
>   CC      blockdev.o
>   CC      qdev-monitor.o
>   CC      device-hotplug.o
>   CC      os-posix.o
>   CC      page_cache.o
>   CC      accel.o
>   CC      bt-host.o
>   CC      bt-vhci.o
>   CC      dma-helpers.o
>   CC      vl.o
>   CC      tpm.o
>   CC      device_tree.o
>   GEN     qmp-marshal.c
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
>   CC      backends/msmouse.o
>   CC      backends/wctablet.o
>   CC      backends/testdev.o
>   CC      backends/baum.o
>   CC      backends/tpm.o
>   CC      backends/hostmem-ram.o
>   CC      backends/hostmem.o
>   CC      backends/hostmem-file.o
>   CC      backends/cryptodev.o
>   CC      backends/cryptodev-builtin.o
>   CC      block/stream.o
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
>   CC      disas/s390.o
>   CC      disas/ppc.o
>   CC      disas/sh4.o
>   CC      disas/sparc.o
>   CC      disas/lm32.o
>   CXX     disas/libvixl/vixl/utils.o
>   CXX     disas/libvixl/vixl/compiler-intrinsics.o
>   CXX     disas/libvixl/vixl/a64/instructions-a64.o
>   CXX     disas/libvixl/vixl/a64/decoder-a64.o
>   CXX     disas/libvixl/vixl/a64/disasm-a64.o
>   CC      fsdev/qemu-fsdev.o
>   CC      fsdev/qemu-fsdev-opts.o
>   CC      fsdev/qemu-fsdev-dummy.o
>   CC      hw/9pfs/9p.o
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
>   CC      hw/acpi/acpi_interface.o
>   CC      hw/acpi/bios-linker-loader.o
>   CC      hw/acpi/aml-build.o
>   CC      hw/acpi/ipmi.o
>   CC      hw/acpi/acpi-stub.o
>   CC      hw/acpi/ipmi-stub.o
>   CC      hw/audio/sb16.o
>   CC      hw/audio/es1370.o
>   CC      hw/audio/ac97.o
>   CC      hw/audio/adlib.o
>   CC      hw/audio/fmopl.o
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
>   CC      hw/block/block.o
>   CC      hw/block/cdrom.o
>   CC      hw/block/hd-geometry.o
>   CC      hw/block/fdc.o
>   CC      hw/block/nand.o
>   CC      hw/block/m25p80.o
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
>   CC      hw/char/xilinx_uartlite.o
>   CC      hw/char/virtio-console.o
>   CC      hw/char/cadence_uart.o
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
>   CC      hw/core/fw-path-provider.o
>   CC      hw/core/irq.o
>   CC      hw/core/hotplug.o
>   CC      hw/core/empty_slot.o
>   CC      hw/core/stream.o
>   CC      hw/core/ptimer.o
>   CC      hw/core/sysbus.o
>   CC      hw/core/machine.o
>   CC      hw/core/loader.o
>   CC      hw/core/loader-fit.o
> /var/tmp/patchew-tester-tmp-i2k78q7z/src/hw/core/loader-fit.c: In funct=
ion =E2=80=98load_fit=E2=80=99:
> /var/tmp/patchew-tester-tmp-i2k78q7z/src/hw/core/loader-fit.c:215:8: er=
ror: =E2=80=98load_data=E2=80=99 may be used uninitialized in this functi=
on [-Werror=3Dmaybe-uninitialized]
>      if (data !=3D load_data) {
>         ^
> /var/tmp/patchew-tester-tmp-i2k78q7z/src/hw/core/loader-fit.c:179:17: n=
ote: =E2=80=98load_data=E2=80=99 was declared here
>      const void *load_data;
>                  ^~~~~~~~~
> /var/tmp/patchew-tester-tmp-i2k78q7z/src/hw/core/loader-fit.c:168:9: er=
ror: =E2=80=98load_data=E2=80=99 may be used uninitialized in this functi=
on [-Werror=3Dmaybe-uninitialized]
>          g_free((void *) load_data);
>          ^~~~~~~~~~~~~~~~~~~~~~~~~~
> /var/tmp/patchew-tester-tmp-i2k78q7z/src/hw/core/loader-fit.c:121:17: n=
ote: =E2=80=98load_data=E2=80=99 was declared here
>      const void *load_data;
>                  ^~~~~~~~~
> cc1: all warnings being treated as errors
> /var/tmp/patchew-tester-tmp-i2k78q7z/src/rules.mak:69: recipe for targe=
t 'hw/core/loader-fit.o' failed
> make: *** [hw/core/loader-fit.o] Error 1
> make: *** Waiting for unfinished jobs....
> =3D=3D=3D OUTPUT END =3D=3D=3D
>=20
> Test command exited with code: 2
>=20
>=20
> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@freelists.org
>=20
