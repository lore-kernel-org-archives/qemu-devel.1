Received: from eggs.gnu.org ([2001:4830:134:3::10]:38924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1cjiKm-0000jM-9s
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 03:13:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1cjiKM-0005wj-Tf
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 03:13:04 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38288)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1cjiKL-0005wG-Pe
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 03:12:38 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2388f9i048998
	for <qemu-devel@nongnu.org>; Fri, 3 Mar 2017 03:12:35 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28xs8e2pv6-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 03 Mar 2017 03:12:33 -0500
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 3 Mar 2017 01:12:32 -0700
References: <148847238435.285.7158100214182923369@0e2666bad730>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 3 Mar 2017 09:12:26 +0100
MIME-Version: 1.0
In-Reply-To: <148847238435.285.7158100214182923369@0e2666bad730>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Message-Id: <e58e0463-c12f-31ed-3944-a09735e7a7fc@de.ibm.com>
Subject: Re: [Qemu-devel] [PULL v2 0/3] Merge qio 2017/02/27
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: famz@redhat.com
Cc: qemu-devel@nongnu.org, berrange@redhat.com, peter.maydell@linaro.org

On 03/02/2017 05:33 PM, no-reply@patchew.org wrote:
> Hi,
> 
> This series failed build test on s390x host. Please find the details below.
> 
> Type: series
> Subject: [Qemu-devel] [PULL v2 0/3] Merge qio 2017/02/27
> Message-id: 20170302161033.4787-1-berrange@redhat.com
> 
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> # Testing script will be invoked under the git checkout with
> # HEAD pointing to a commit that has the patches applied on top of "base"
> # branch
> set -e
> echo "=== ENV ==="
> env
> echo "=== PACKAGES ==="
> rpm -qa
> echo "=== TEST BEGIN ==="
> CC=$HOME/bin/cc
> INSTALL=$PWD/install
> BUILD=/var/tmp/patchew-qemu-build
> echo -n "Using CC: "
> realpath $CC
> test -e $BUILD && rm -rf $BUILD
> mkdir -p $BUILD $INSTALL
> SRC=$PWD
> cd $BUILD
> $SRC/configure --cc=$CC --prefix=$INSTALL
> make -j4
> make check -j4
> make install
> === TEST SCRIPT END ===
> 
> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> From https://github.com/patchew-project/qemu
>  - [tag update]      patchew/20170302122429.7737-1-berrange@redhat.com -> patchew/20170302122429.7737-1-berrange@redhat.com
>  * [new tag]         patchew/20170302161033.4787-1-berrange@redhat.com -> patchew/20170302161033.4787-1-berrange@redhat.com
> Switched to a new branch 'test'
> 7f1793a io: fully parse & validate HTTP headers for websocket protocol handshake
> 69703de tests: fix leaks in test-io-channel-command
> c66170e io: fix decoding when multiple websockets frames arrive at once
> 
> === OUTPUT BEGIN ===
> === ENV ===
> XDG_SESSION_ID=42899
> SHELL=/bin/sh
> USER=fam
> PATCHEW=/home/fam/patchew/patchew-cli -s http://patchew.org --nodebug
> PATH=/usr/bin:/bin
> PWD=/var/tmp/patchew-tester-tmp-1ouqaay5/src
> LANG=en_US.UTF-8
> HOME=/home/fam
> SHLVL=2
> LOGNAME=fam
> DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1012/bus
> XDG_RUNTIME_DIR=/run/user/1012
> _=/usr/bin/env
> === PACKAGES ===
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
> === TEST BEGIN ===
> Using CC: /home/fam/bin/cc
> Install prefix    /var/tmp/patchew-tester-tmp-1ouqaay5/src/install
> BIOS directory    /var/tmp/patchew-tester-tmp-1ouqaay5/src/install/share/qemu
> binary directory  /var/tmp/patchew-tester-tmp-1ouqaay5/src/install/bin
> library directory /var/tmp/patchew-tester-tmp-1ouqaay5/src/install/lib
> module directory  /var/tmp/patchew-tester-tmp-1ouqaay5/src/install/lib/qemu
> libexec directory /var/tmp/patchew-tester-tmp-1ouqaay5/src/install/libexec
> include directory /var/tmp/patchew-tester-tmp-1ouqaay5/src/install/include
> config directory  /var/tmp/patchew-tester-tmp-1ouqaay5/src/install/etc
> local state directory   /var/tmp/patchew-tester-tmp-1ouqaay5/src/install/var
> Manual directory  /var/tmp/patchew-tester-tmp-1ouqaay5/src/install/share/man
> ELF interp prefix /usr/gnemul/qemu-%M
> Source path       /var/tmp/patchew-tester-tmp-1ouqaay5/src
> C compiler        /home/fam/bin/cc
> Host C compiler   cc
> C++ compiler      c++
> Objective-C compiler /home/fam/bin/cc
> ARFLAGS           rv
> CFLAGS            -O2 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2 -g 
> QEMU_CFLAGS       -I/usr/include/pixman-1  -Werror -DHAS_LIBSSH2_SFTP_FSYNC -pthread -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include -D_GNU_SOURCE -m64 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-prototypes -fno-strict-aliasing -fno-common -fwrapv  -Wendif-labels -Wno-shift-negative-value -Wno-missing-include-dirs -Wempty-body -Wnested-externs -Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers -Wold-style-declaration -Wold-style-definition -Wtype-limits -fstack-protector-strong -I/usr/include/p11-kit-1    -I/usr/include/libpng16 -I/usr/include/cacard -I/usr/include/nss3 -I/usr/include/nspr4 -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include -I/usr/include/libusb-1.0 
> LDFLAGS           -Wl,--warn-common -m64 -g 
> make              make
> install           install
> python            python -B
> smbd              /usr/sbin/smbd
> module support    no
> host CPU          s390x
> host big endian   yes
> target list        aarch64-softmmu alpha-softmmu arm-softmmu cris-softmmu i386-softmmu lm32-softmmu m68k-softmmu microblazeel-softmmu microblaze-softmmu mips64el-softmmu mips64-softmmu mipsel-softmmu mips-softmmu moxie-softmmu nios2-softmmu or1k-softmmu ppc64-softmmu ppcemb-softmmu ppc-softmmu s390x-softmmu sh4eb-softmmu sh4-softmmu sparc64-softmmu sparc-softmmu tricore-softmmu unicore32-softmmu x86_64-softmmu xtensaeb-softmmu xtensa-softmmu aarch64-linux-user alpha-linux-user armeb-linux-user arm-linux-user cris-linux-user hppa-linux-user i386-linux-user m68k-linux-user microblazeel-linux-user microblaze-linux-user mips64el-linux-user mips64-linux-user mipsel-linux-user mips-linux-user mipsn32el-linux-user mipsn32-linux-user nios2-linux-user or1k-linux-user ppc64abi32-linux-user ppc64le-linux-user ppc64-linux-user ppc-linux-user s390x-linux-user sh4eb-linux-user sh4-linux-user sparc32plus-linux-user sparc64-linux-user sparc-linux-user tilegx-linux-user x86_64-linux-user
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
> Block whitelist (rw) 
> Block whitelist (ro) 
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
> spice support     no 
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
>   GEN     alpha-softmmu/config-devices.mak
>   GEN     i386-softmmu/config-devices.mak.tmp
>   GEN     cris-softmmu/config-devices.mak
>   GEN     lm32-softmmu/config-devices.mak.tmp
>   GEN     aarch64-softmmu/config-devices.mak
>   GEN     m68k-softmmu/config-devices.mak.tmp
>   GEN     arm-softmmu/config-devices.mak
>   GEN     m68k-softmmu/config-devices.mak
>   GEN     lm32-softmmu/config-devices.mak
>   GEN     microblazeel-softmmu/config-devices.mak.tmp
>   GEN     microblaze-softmmu/config-devices.mak.tmp
>   GEN     mips64el-softmmu/config-devices.mak.tmp
>   GEN     i386-softmmu/config-devices.mak
>   GEN     mips64-softmmu/config-devices.mak.tmp
>   GEN     microblaze-softmmu/config-devices.mak
>   GEN     microblazeel-softmmu/config-devices.mak
>   GEN     mipsel-softmmu/config-devices.mak.tmp
>   GEN     mips-softmmu/config-devices.mak.tmp
>   GEN     mips64el-softmmu/config-devices.mak
>   GEN     moxie-softmmu/config-devices.mak.tmp
>   GEN     mips-softmmu/config-devices.mak
>   GEN     moxie-softmmu/config-devices.mak
>   GEN     mips64-softmmu/config-devices.mak
>   GEN     nios2-softmmu/config-devices.mak.tmp
>   GEN     or1k-softmmu/config-devices.mak.tmp
>   GEN     mipsel-softmmu/config-devices.mak
>   GEN     ppc64-softmmu/config-devices.mak.tmp
>   GEN     ppcemb-softmmu/config-devices.mak.tmp
>   GEN     or1k-softmmu/config-devices.mak
>   GEN     nios2-softmmu/config-devices.mak
>   GEN     ppc-softmmu/config-devices.mak.tmp
>   GEN     s390x-softmmu/config-devices.mak.tmp
>   GEN     s390x-softmmu/config-devices.mak
>   GEN     sh4eb-softmmu/config-devices.mak.tmp
>   GEN     ppcemb-softmmu/config-devices.mak
>   GEN     ppc64-softmmu/config-devices.mak
>   GEN     sh4-softmmu/config-devices.mak.tmp
>   GEN     sparc64-softmmu/config-devices.mak.tmp
>   GEN     sh4-softmmu/config-devices.mak
>   GEN     sparc64-softmmu/config-devices.mak
>   GEN     sparc-softmmu/config-devices.mak.tmp
>   GEN     ppc-softmmu/config-devices.mak
>   GEN     tricore-softmmu/config-devices.mak.tmp
>   GEN     sparc-softmmu/config-devices.mak
>   GEN     unicore32-softmmu/config-devices.mak.tmp
>   GEN     sh4eb-softmmu/config-devices.mak
>   GEN     xtensaeb-softmmu/config-devices.mak.tmp
>   GEN     x86_64-softmmu/config-devices.mak.tmp
>   GEN     xtensaeb-softmmu/config-devices.mak
>   GEN     tricore-softmmu/config-devices.mak
>   GEN     unicore32-softmmu/config-devices.mak
>   GEN     xtensa-softmmu/config-devices.mak.tmp
>   GEN     aarch64-linux-user/config-devices.mak.tmp
>   GEN     alpha-linux-user/config-devices.mak.tmp
>   GEN     x86_64-softmmu/config-devices.mak
>   GEN     xtensa-softmmu/config-devices.mak
>   GEN     armeb-linux-user/config-devices.mak.tmp
>   GEN     aarch64-linux-user/config-devices.mak
>   GEN     cris-linux-user/config-devices.mak.tmp
>   GEN     arm-linux-user/config-devices.mak.tmp
>   GEN     alpha-linux-user/config-devices.mak
>   GEN     armeb-linux-user/config-devices.mak
>   GEN     cris-linux-user/config-devices.mak
>   GEN     hppa-linux-user/config-devices.mak.tmp
>   GEN     i386-linux-user/config-devices.mak.tmp
>   GEN     m68k-linux-user/config-devices.mak.tmp
>   GEN     arm-linux-user/config-devices.mak
>   GEN     i386-linux-user/config-devices.mak
>   GEN     microblazeel-linux-user/config-devices.mak.tmp
>   GEN     microblaze-linux-user/config-devices.mak.tmp
>   GEN     hppa-linux-user/config-devices.mak
>   GEN     m68k-linux-user/config-devices.mak
>   GEN     mips64el-linux-user/config-devices.mak.tmp
>   GEN     microblazeel-linux-user/config-devices.mak
>   GEN     microblaze-linux-user/config-devices.mak
>   GEN     mips64-linux-user/config-devices.mak.tmp
>   GEN     mipsel-linux-user/config-devices.mak.tmp
>   GEN     mips64el-linux-user/config-devices.mak
>   GEN     mips-linux-user/config-devices.mak.tmp
>   GEN     mipsn32el-linux-user/config-devices.mak.tmp
>   GEN     mipsel-linux-user/config-devices.mak
>   GEN     mips64-linux-user/config-devices.mak
>   GEN     mipsn32-linux-user/config-devices.mak.tmp
>   GEN     mips-linux-user/config-devices.mak
>   GEN     mipsn32el-linux-user/config-devices.mak
>   GEN     nios2-linux-user/config-devices.mak.tmp
>   GEN     or1k-linux-user/config-devices.mak.tmp
>   GEN     ppc64abi32-linux-user/config-devices.mak.tmp
>   GEN     mipsn32-linux-user/config-devices.mak
>   GEN     or1k-linux-user/config-devices.mak
>   GEN     ppc64le-linux-user/config-devices.mak.tmp
>   GEN     nios2-linux-user/config-devices.mak
>   GEN     ppc64-linux-user/config-devices.mak.tmp
>   GEN     ppc64abi32-linux-user/config-devices.mak
>   GEN     ppc-linux-user/config-devices.mak.tmp
>   GEN     ppc64le-linux-user/config-devices.mak
>   GEN     s390x-linux-user/config-devices.mak.tmp
>   GEN     sh4eb-linux-user/config-devices.mak.tmp
>   GEN     ppc-linux-user/config-devices.mak
>   GEN     ppc64-linux-user/config-devices.mak
>   GEN     sh4-linux-user/config-devices.mak.tmp
>   GEN     s390x-linux-user/config-devices.mak
>   GEN     sh4eb-linux-user/config-devices.mak
>   GEN     sparc32plus-linux-user/config-devices.mak.tmp
>   GEN     sparc64-linux-user/config-devices.mak.tmp
>   GEN     sparc-linux-user/config-devices.mak.tmp
>   GEN     sh4-linux-user/config-devices.mak
>   GEN     tilegx-linux-user/config-devices.mak.tmp
>   GEN     sparc32plus-linux-user/config-devices.mak
>   GEN     sparc-linux-user/config-devices.mak
>   GEN     x86_64-linux-user/config-devices.mak.tmp
>   GEN     sparc64-linux-user/config-devices.mak
>   GEN     tilegx-linux-user/config-devices.mak
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
>   GEN     block/trace.h
>   GEN     migration/trace.h
>   GEN     backends/trace.h
>   GEN     hw/block/trace.h
>   GEN     hw/block/dataplane/trace.h
>   GEN     hw/char/trace.h
>   GEN     hw/intc/trace.h
>   GEN     hw/net/trace.h
>   GEN     hw/virtio/trace.h
>   GEN     hw/audio/trace.h
>   GEN     hw/usb/trace.h
>   GEN     hw/misc/trace.h
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
>   GEN     hw/ppc/trace.h
>   GEN     hw/pci/trace.h
>   GEN     hw/s390x/trace.h
>   GEN     hw/vfio/trace.h
>   GEN     hw/acpi/trace.h
>   GEN     hw/arm/trace.h
>   GEN     hw/alpha/trace.h
>   GEN     hw/xen/trace.h
>   GEN     ui/trace.h
>   GEN     audio/trace.h
>   GEN     target/arm/trace.h
>   GEN     net/trace.h
>   GEN     target/i386/trace.h
>   GEN     target/s390x/trace.h
>   GEN     target/ppc/trace.h
>   GEN     target/sparc/trace.h
>   GEN     qom/trace.h
>   GEN     qapi/trace.h
>   GEN     config-all-devices.mak
>   GEN     linux-user/trace.h
>   CC      tests/qemu-iotests/socket_scm_helper.o
>   GEN     version.texi
>   GEN     qemu-options.texi
>   GEN     qemu-monitor.texi
>   GEN     qemu-img-cmds.texi
>   GEN     qemu-monitor-info.texi
>   GEN     qemu-img.1
>   GEN     qemu-nbd.8
>   GEN     qemu-ga.8
>   GEN     qemu-qapi.texi
>   GEN     fsdev/virtfs-proxy-helper.1
>   GEN     qemu-ga-qapi.texi
>   GEN     qga/qapi-generated/qga-qapi-types.h
>   GEN     qga/qapi-generated/qga-qapi-visit.h
>   GEN     qga/qapi-generated/qga-qmp-commands.h
>   GEN     qga/qapi-generated/qga-qapi-types.c
>   GEN     qga/qapi-generated/qga-qapi-visit.c
>   GEN     qga/qapi-generated/qga-qmp-marshal.c
>   GEN     trace-root.c
>   GEN     crypto/trace.c
>   GEN     io/trace.c
>   GEN     util/trace.c
>   GEN     block/trace.c
>   GEN     migration/trace.c
>   GEN     backends/trace.c
>   GEN     hw/block/trace.c
>   GEN     hw/block/dataplane/trace.c
>   GEN     hw/char/trace.c
>   GEN     hw/virtio/trace.c
>   GEN     hw/net/trace.c
>   GEN     hw/intc/trace.c
>   GEN     hw/audio/trace.c
>   GEN     hw/usb/trace.c
>   GEN     hw/scsi/trace.c
>   GEN     hw/misc/trace.c
>   GEN     hw/nvram/trace.c
>   GEN     hw/display/trace.c
>   GEN     hw/input/trace.c
>   GEN     hw/timer/trace.c
>   GEN     hw/dma/trace.c
>   GEN     hw/sparc/trace.c
>   GEN     hw/sd/trace.c
>   GEN     hw/isa/trace.c
>   GEN     hw/mem/trace.c
>   GEN     hw/i386/trace.c
>   GEN     hw/9pfs/trace.c
>   GEN     hw/i386/xen/trace.c
>   GEN     hw/ppc/trace.c
>   GEN     hw/pci/trace.c
>   GEN     hw/s390x/trace.c
>   GEN     hw/vfio/trace.c
>   GEN     hw/alpha/trace.c
>   GEN     hw/arm/trace.c
>   GEN     hw/acpi/trace.c
>   GEN     hw/xen/trace.c
>   GEN     ui/trace.c
>   GEN     audio/trace.c
>   GEN     net/trace.c
>   GEN     target/arm/trace.c
>   GEN     target/i386/trace.c
>   GEN     target/sparc/trace.c
>   GEN     target/s390x/trace.c
>   GEN     target/ppc/trace.c
>   GEN     qom/trace.c
>   GEN     linux-user/trace.c
>   GEN     qmp-introspect.c
>   GEN     qapi-types.c
>   GEN     qapi/trace.c
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
>   CC      qapi/qmp-event.o
>   CC      qapi/qapi-clone-visitor.o
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
>   CC      util/qemu-timer-common.o
>   CC      util/unicode.o
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
>   CC      stubs/monitor.o
>   CC      stubs/notify-event.o
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
>   CC      block/replication.o
>   CC      block/backup.o
>   CC      block/crypto.o
>   CC      nbd/server.o
>   CC      nbd/client.o
>   CC      nbd/common.o
>   CC      block/iscsi.o
>   CC      block/nfs.o
>   CC      block/curl.o
>   CC      block/rbd.o
>   CC      block/ssh.o
>   CC      block/gluster.o
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
>   CC      io/channel-watch.o
>   CC      io/channel-tls.o
>   CC      io/channel-websock.o
>   CC      io/channel-util.o
>   CC      io/dns-resolver.o
>   CC      io/task.o
>   CC      qom/object.o
>   CC      qom/container.o
>   CC      qom/qom-qobject.o
>   CC      qom/object_interfaces.o
>   CC      qemu-io.o
>   GEN     qemu-img-cmds.h
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
>   CC      page_cache.o
>   CC      accel.o
>   CC      bt-host.o
>   CC      dma-helpers.o
>   CC      bt-vhci.o
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
>   CC      backends/hostmem.o
>   CC      backends/hostmem-ram.o
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
>   CC      disas/ppc.o
>   CC      disas/moxie.o
>   CC      disas/s390.o
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
>   CC      hw/9pfs/9p-synth.o
>   CC      hw/9pfs/coxattr.o
>   CC      hw/9pfs/9p-handle.o
>   CC      hw/9pfs/9p-proxy.o
>   CC      hw/acpi/core.o
>   CC      hw/acpi/piix4.o
>   CC      hw/acpi/pcihp.o
>   CC      hw/acpi/ich9.o
>   CC      hw/acpi/tco.o
>   CC      hw/acpi/cpu_hotplug.o
>   CC      hw/acpi/cpu.o
>   CC      hw/acpi/memory_hotplug.o
>   CC      hw/acpi/nvdimm.o
>   CC      hw/acpi/acpi_interface.o
>   CC      hw/acpi/bios-linker-loader.o
>   CC      hw/acpi/aml-build.o
>   CC      hw/acpi/ipmi.o
>   CC      hw/acpi/acpi-stub.o
>   CC      hw/acpi/ipmi-stub.o
>   CC      hw/audio/es1370.o
>   CC      hw/audio/sb16.o
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
>   CC      hw/block/block.o
>   CC      hw/audio/milkymist-ac97.o
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
>   CC      hw/i2c/smbus.o
>   CC      hw/i2c/core.o
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
>   CC      hw/net/mipsnet.o
>   CC      hw/net/xgmac.o
>   CC      hw/net/xilinx_axienet.o
>   CC      hw/net/imx_fec.o
>   CC      hw/net/allwinner_emac.o
>   CC      hw/net/cadence_gem.o
>   CC      hw/net/stellaris_enet.o
>   CC      hw/net/lance.o
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
>   CC      hw/pci-bridge/pci_expander_bridge.o
>   CC      hw/pci-bridge/gen_pcie_root_port.o
>   CC      hw/pci-bridge/xio3130_upstream.o
>   CC      hw/pci-bridge/xio3130_downstream.o
>   CC      hw/pci-bridge/i82801b11.o
>   CC      hw/pci-bridge/ioh3420.o
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
>   CC      hw/timer/arm_timer.o
>   CC      hw/timer/arm_mptimer.o
>   CC      hw/timer/armv7m_systick.o
>   CC      hw/timer/a9gtimer.o
>   CC      hw/timer/cadence_ttc.o
>   CC      hw/timer/ds1338.o
>   CC      hw/timer/hpet.o
>   CC      hw/timer/i8254.o
>   CC      hw/timer/i8254_common.o
>   CC      hw/timer/m48t59.o
>   CC      hw/timer/m48t59-isa.o
>   CC      hw/timer/pl031.o
>   CC      hw/timer/puv3_ost.o
>   CC      hw/timer/twl92230.o
>   CC      hw/timer/slavio_timer.o
>   CC      hw/timer/xilinx_timer.o
>   CC      hw/timer/etraxfs_timer.o
>   CC      hw/timer/grlib_gptimer.o
>   CC      hw/timer/imx_epit.o
>   CC      hw/timer/imx_gpt.o
>   CC      hw/timer/lm32_timer.o
>   CC      hw/timer/milkymist-sysctl.o
>   CC      hw/timer/stm32f2xx_timer.o
>   CC      hw/timer/aspeed_timer.o
>   CC      hw/timer/sun4v-rtc.o
>   CC      hw/tpm/tpm_tis.o
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
>   CC      hw/usb/hcd-musb.o
>   CC      hw/usb/dev-hub.o
>   CC      hw/usb/dev-hid.o
>   CC      hw/usb/dev-wacom.o
>   CC      hw/usb/dev-storage.o
>   CC      hw/usb/dev-audio.o
>   CC      hw/usb/dev-uas.o
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
>   CC      migration/colo-comm.o
>   CC      migration/colo.o
>   CC      migration/colo-failover.o
>   CC      migration/vmstate.o
>   CC      migration/qemu-file.o
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
>   CC      net/tap.o
>   CC      net/vhost-user.o
>   CC      net/tap-linux.o
>   CC      net/slirp.o
>   CC      net/filter.o
>   CC      net/filter-buffer.o
>   CC      net/filter-mirror.o
>   CC      net/colo-compare.o
>   CC      net/colo.o
>   CC      net/filter-rewriter.o
>   CC      net/filter-replay.o
>   CC      qom/cpu.o
>   CC      replay/replay.o
>   CC      replay/replay-internal.o
>   CC      replay/replay-events.o
>   CC      replay/replay-time.o
>   CC      replay/replay-input.o
>   CC      replay/replay-char.o
>   CC      replay/replay-snapshot.o
>   CC      replay/replay-net.o
>   CC      slirp/cksum.o
>   CC      slirp/if.o
>   CC      slirp/ip_icmp.o
>   CC      slirp/ip6_icmp.o
>   CC      slirp/ip6_input.o
>   CC      slirp/ip6_output.o
>   CC      slirp/ip_input.o
>   CC      slirp/ip_output.o
>   CC      slirp/dnssearch.o
>   CC      slirp/slirp.o
>   CC      slirp/dhcpv6.o
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
>   CC      ui/gtk.o
>   CC      ui/shader.o
>   VERT    ui/shader/texture-blit-vert.h
>   FRAG    ui/shader/texture-blit-frag.h
>   CC      ui/egl-helpers.o
>   CC      ui/egl-context.o
>   CC      ui/gtk-gl-area.o
>   CC      chardev/char.o
>   CC      chardev/char-fd.o
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
>   CC      s390-ccw/sclp-ascii.o
>   LINK    tests/qemu-iotests/socket_scm_helper
>   GEN     qemu-doc.html
>   CC      s390-ccw/virtio.o
>   CC      s390-ccw/virtio-scsi.o
>   GEN     qemu-doc.txt
>   GEN     qemu.1
>   BUILD   s390-ccw/s390-ccw.elf
>   STRIP   s390-ccw/s390-ccw.img
>   GEN     docs/qemu-qmp-ref.html
>   GEN     docs/qemu-qmp-ref.txt
>   GEN     docs/qemu-qmp-ref.7
>   GEN     docs/qemu-ga-ref.html
>   GEN     docs/qemu-ga-ref.txt
>   GEN     docs/qemu-ga-ref.7
>   CC      qga/commands.o
>   CC      qga/guest-agent-command-state.o
>   CC      qga/main.o
>   CC      qga/commands-posix.o
>   CC      qga/channel-posix.o
>   CC      qga/qapi-generated/qga-qapi-types.o
>   CC      qga/qapi-generated/qga-qapi-visit.o
>   CC      qga/qapi-generated/qga-qmp-marshal.o
>   CC      qmp-introspect.o
>   CC      qapi-types.o
>   CC      qapi-visit.o
>   CC      qapi-event.o
>   AR      libqemustub.a
>   CC      qemu-img.o
>   CC      qmp-marshal.o
>   CC      ui/console-gl.o
>   CC      trace-root.o
>   CC      util/trace.o
>   CC      crypto/trace.o
>   CC      io/trace.o
>   CC      migration/trace.o
>   CC      block/trace.o
>   CC      backends/trace.o
>   CC      hw/block/trace.o
>   CC      hw/block/dataplane/trace.o
>   CC      hw/char/trace.o
>   CC      hw/intc/trace.o
>   CC      hw/net/trace.o
>   CC      hw/virtio/trace.o
>   CC      hw/audio/trace.o
>   CC      hw/misc/trace.o
>   CC      hw/scsi/trace.o
>   CC      hw/usb/trace.o
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
>   CC      target/arm/trace.o
>   CC      target/i386/trace.o
>   CC      target/sparc/trace.o
>   CC      target/s390x/trace.o
>   CC      target/ppc/trace.o
>   CC      qom/trace.o
>   CC      linux-user/trace.o
>   CC      qapi/trace.o
>   AR      libqemuutil.a
>   LINK    qemu-ga
>   LINK    ivshmem-client
>   LINK    ivshmem-server
>   LINK    qemu-nbd
>   LINK    qemu-img
>   LINK    qemu-io
>   LINK    fsdev/virtfs-proxy-helper
>   LINK    qemu-bridge-helper
>   GEN     alpha-softmmu/hmp-commands.h
>   GEN     alpha-softmmu/hmp-commands-info.h
>   GEN     alpha-softmmu/config-target.h
>   GEN     aarch64-softmmu/hmp-commands.h
>   GEN     aarch64-softmmu/hmp-commands-info.h
>   GEN     cris-softmmu/hmp-commands.h
>   GEN     cris-softmmu/hmp-commands-info.h
>   CC      alpha-softmmu/exec.o
>   GEN     cris-softmmu/config-target.h
>   GEN     aarch64-softmmu/config-target.h
>   GEN     arm-softmmu/hmp-commands.h
>   CC      cris-softmmu/exec.o
>   GEN     arm-softmmu/hmp-commands-info.h
>   CC      aarch64-softmmu/exec.o
>   GEN     arm-softmmu/config-target.h
>   CC      arm-softmmu/exec.o
>   CC      aarch64-softmmu/translate-all.o
>   CC      alpha-softmmu/translate-all.o
>   CC      cris-softmmu/translate-all.o
>   CC      arm-softmmu/translate-all.o
>   CC      cris-softmmu/cpu-exec.o
>   CC      alpha-softmmu/cpu-exec.o
>   CC      aarch64-softmmu/cpu-exec.o
>   CC      arm-softmmu/cpu-exec.o
>   CC      cris-softmmu/translate-common.o
>   CC      alpha-softmmu/translate-common.o
>   CC      cris-softmmu/cpu-exec-common.o
>   CC      alpha-softmmu/cpu-exec-common.o
>   CC      arm-softmmu/translate-common.o
>   CC      aarch64-softmmu/translate-common.o
>   CC      alpha-softmmu/tcg/tcg.o
>   CC      aarch64-softmmu/cpu-exec-common.o
>   CC      arm-softmmu/cpu-exec-common.o
>   CC      cris-softmmu/tcg/tcg.o
>   CC      aarch64-softmmu/tcg/tcg.o
>   CC      arm-softmmu/tcg/tcg.o
>   CC      alpha-softmmu/tcg/tcg-op.o
>   CC      cris-softmmu/tcg/tcg-op.o
>   CC      aarch64-softmmu/tcg/tcg-op.o
>   CC      arm-softmmu/tcg/tcg-op.o
>   CC      alpha-softmmu/tcg/optimize.o
>   CC      cris-softmmu/tcg/optimize.o
>   CC      aarch64-softmmu/tcg/optimize.o
>   CC      alpha-softmmu/tcg/tcg-common.o
>   CC      arm-softmmu/tcg/optimize.o
>   CC      alpha-softmmu/fpu/softfloat.o
>   CC      cris-softmmu/tcg/tcg-common.o
>   CC      cris-softmmu/fpu/softfloat.o
>   CC      aarch64-softmmu/tcg/tcg-common.o
>   CC      arm-softmmu/tcg/tcg-common.o
>   CC      aarch64-softmmu/fpu/softfloat.o
>   CC      arm-softmmu/fpu/softfloat.o
>   CC      alpha-softmmu/disas.o
>   CC      cris-softmmu/disas.o
>   CC      alpha-softmmu/tcg-runtime.o
>   CC      cris-softmmu/tcg-runtime.o
>   CC      cris-softmmu/hax-stub.o
>   CC      cris-softmmu/kvm-stub.o
>   CC      alpha-softmmu/hax-stub.o
>   CC      aarch64-softmmu/disas.o
>   CC      cris-softmmu/arch_init.o
>   CC      alpha-softmmu/kvm-stub.o
>   CC      aarch64-softmmu/tcg-runtime.o
>   CC      cris-softmmu/cpus.o
>   CC      alpha-softmmu/arch_init.o
>   GEN     aarch64-softmmu/gdbstub-xml.c
>   CC      alpha-softmmu/cpus.o
>   CC      arm-softmmu/disas.o
>   CC      cris-softmmu/monitor.o
>   CC      arm-softmmu/tcg-runtime.o
>   CC      aarch64-softmmu/hax-stub.o
>   CC      alpha-softmmu/monitor.o
>   CC      aarch64-softmmu/kvm-stub.o
>   GEN     arm-softmmu/gdbstub-xml.c
>   CC      aarch64-softmmu/arch_init.o
>   CC      aarch64-softmmu/cpus.o
>   CC      arm-softmmu/hax-stub.o
>   CC      cris-softmmu/gdbstub.o
>   CC      arm-softmmu/kvm-stub.o
>   CC      aarch64-softmmu/monitor.o
>   CC      alpha-softmmu/gdbstub.o
>   CC      arm-softmmu/arch_init.o
>   CC      arm-softmmu/cpus.o
>   CC      cris-softmmu/balloon.o
>   CC      alpha-softmmu/balloon.o
>   CC      cris-softmmu/ioport.o
>   CC      alpha-softmmu/ioport.o
>   CC      arm-softmmu/monitor.o
>   CC      cris-softmmu/numa.o
>   CC      aarch64-softmmu/gdbstub.o
>   CC      alpha-softmmu/numa.o
>   CC      cris-softmmu/qtest.o
>   CC      aarch64-softmmu/balloon.o
>   CC      cris-softmmu/bootdevice.o
>   CC      alpha-softmmu/qtest.o
>   CC      cris-softmmu/memory.o
>   CC      aarch64-softmmu/ioport.o
>   CC      alpha-softmmu/bootdevice.o
>   CC      arm-softmmu/gdbstub.o
>   CC      aarch64-softmmu/numa.o
>   CC      alpha-softmmu/memory.o
>   CC      cris-softmmu/cputlb.o
>   CC      aarch64-softmmu/qtest.o
>   CC      arm-softmmu/balloon.o
>   CC      alpha-softmmu/cputlb.o
>   CC      aarch64-softmmu/bootdevice.o
>   CC      arm-softmmu/ioport.o
>   CC      aarch64-softmmu/memory.o
>   CC      arm-softmmu/numa.o
>   CC      cris-softmmu/memory_mapping.o
>   CC      arm-softmmu/qtest.o
>   CC      cris-softmmu/dump.o
>   CC      alpha-softmmu/memory_mapping.o
>   CC      arm-softmmu/bootdevice.o
>   CC      alpha-softmmu/dump.o
>   CC      aarch64-softmmu/cputlb.o
>   CC      arm-softmmu/memory.o
>   CC      cris-softmmu/migration/ram.o
>   CC      alpha-softmmu/migration/ram.o
>   CC      cris-softmmu/migration/savevm.o
>   CC      arm-softmmu/cputlb.o
>   CC      alpha-softmmu/migration/savevm.o
>   CC      cris-softmmu/xen-common-stub.o
>   CC      aarch64-softmmu/memory_mapping.o
>   CC      cris-softmmu/xen-hvm-stub.o
>   CC      aarch64-softmmu/dump.o
>   CC      cris-softmmu/hw/core/nmi.o
>   CC      arm-softmmu/memory_mapping.o
>   CC      cris-softmmu/hw/core/generic-loader.o
>   CC      alpha-softmmu/xen-common-stub.o
>   CC      arm-softmmu/dump.o
>   CC      alpha-softmmu/xen-hvm-stub.o
>   CC      cris-softmmu/hw/core/null-machine.o
>   CC      aarch64-softmmu/migration/ram.o
>   CC      alpha-softmmu/hw/9pfs/virtio-9p-device.o
>   CC      cris-softmmu/hw/cpu/core.o
>   CC      alpha-softmmu/hw/block/virtio-blk.o
>   CC      cris-softmmu/hw/net/etraxfs_eth.o
>   CC      arm-softmmu/migration/ram.o
>   CC      alpha-softmmu/hw/block/dataplane/virtio-blk.o
>   CC      cris-softmmu/hw/net/vhost_net.o
>   CC      aarch64-softmmu/migration/savevm.o
>   CC      alpha-softmmu/hw/char/virtio-serial-bus.o
>   CC      cris-softmmu/hw/net/rocker/qmp-norocker.o
>   CC      cris-softmmu/hw/vfio/common.o
>   CC      arm-softmmu/migration/savevm.o
>   CC      alpha-softmmu/hw/core/nmi.o
>   CC      aarch64-softmmu/xen-common-stub.o
>   CC      alpha-softmmu/hw/core/generic-loader.o
>   CC      cris-softmmu/hw/vfio/platform.o
>   CC      aarch64-softmmu/xen-hvm-stub.o
>   CC      alpha-softmmu/hw/core/null-machine.o
>   CC      arm-softmmu/xen-common-stub.o
>   CC      arm-softmmu/xen-hvm-stub.o
>   CC      alpha-softmmu/hw/cpu/core.o
>   CC      aarch64-softmmu/hw/9pfs/virtio-9p-device.o
>   CC      cris-softmmu/hw/vfio/spapr.o
>   CC      arm-softmmu/hw/9pfs/virtio-9p-device.o
>   CC      alpha-softmmu/hw/display/vga.o
>   CC      aarch64-softmmu/hw/adc/stm32f2xx_adc.o
>   CC      cris-softmmu/hw/cris/boot.o
>   CC      arm-softmmu/hw/adc/stm32f2xx_adc.o
>   CC      aarch64-softmmu/hw/block/virtio-blk.o
>   CC      cris-softmmu/hw/cris/axis_dev88.o
>   CC      arm-softmmu/hw/block/virtio-blk.o
>   CC      aarch64-softmmu/hw/block/dataplane/virtio-blk.o
>   CC      cris-softmmu/target/cris/translate.o
>   CC      arm-softmmu/hw/block/dataplane/virtio-blk.o
>   CC      alpha-softmmu/hw/display/virtio-gpu.o
>   CC      aarch64-softmmu/hw/char/exynos4210_uart.o
>   CC      arm-softmmu/hw/char/exynos4210_uart.o
>   CC      aarch64-softmmu/hw/char/omap_uart.o
>   CC      arm-softmmu/hw/char/omap_uart.o
>   CC      aarch64-softmmu/hw/char/digic-uart.o
>   CC      alpha-softmmu/hw/display/virtio-gpu-3d.o
>   CC      arm-softmmu/hw/char/digic-uart.o
>   CC      aarch64-softmmu/hw/char/stm32f2xx_usart.o
>   CC      arm-softmmu/hw/char/stm32f2xx_usart.o
>   CC      cris-softmmu/target/cris/op_helper.o
>   CC      aarch64-softmmu/hw/char/bcm2835_aux.o
>   CC      alpha-softmmu/hw/display/virtio-gpu-pci.o
>   CC      arm-softmmu/hw/char/bcm2835_aux.o
>   CC      cris-softmmu/target/cris/helper.o
>   CC      arm-softmmu/hw/char/virtio-serial-bus.o
>   CC      aarch64-softmmu/hw/char/virtio-serial-bus.o
>   CC      cris-softmmu/target/cris/cpu.o
>   CC      alpha-softmmu/hw/misc/ivshmem.o
>   CC      cris-softmmu/target/cris/gdbstub.o
>   CC      aarch64-softmmu/hw/core/nmi.o
>   CC      arm-softmmu/hw/core/nmi.o
>   CC      alpha-softmmu/hw/misc/edu.o
>   CC      cris-softmmu/target/cris/mmu.o
>   CC      aarch64-softmmu/hw/core/generic-loader.o
>   CC      arm-softmmu/hw/core/generic-loader.o
>   CC      cris-softmmu/target/cris/machine.o
>   CC      aarch64-softmmu/hw/core/null-machine.o
>   CC      arm-softmmu/hw/core/null-machine.o
>   CC      alpha-softmmu/hw/net/virtio-net.o
>   GEN     trace/generated-helpers.c
>   CC      cris-softmmu/trace/control-target.o
>   CC      arm-softmmu/hw/cpu/arm11mpcore.o
>   CC      aarch64-softmmu/hw/cpu/arm11mpcore.o
>   CC      aarch64-softmmu/hw/cpu/realview_mpcore.o
>   CC      cris-softmmu/trace/generated-helpers.o
>   CC      arm-softmmu/hw/cpu/realview_mpcore.o
>   CC      alpha-softmmu/hw/net/vhost_net.o
>   CC      aarch64-softmmu/hw/cpu/a9mpcore.o
>   LINK    cris-softmmu/qemu-system-cris
>   CC      arm-softmmu/hw/cpu/a9mpcore.o
>   CC      alpha-softmmu/hw/scsi/virtio-scsi.o
>   CC      aarch64-softmmu/hw/cpu/a15mpcore.o
>   CC      arm-softmmu/hw/cpu/a15mpcore.o
>   CC      alpha-softmmu/hw/scsi/virtio-scsi-dataplane.o
>   CC      aarch64-softmmu/hw/cpu/core.o
>   CC      arm-softmmu/hw/cpu/core.o
>   CC      aarch64-softmmu/hw/display/omap_dss.o
>   CC      alpha-softmmu/hw/scsi/vhost-scsi.o
>   CC      arm-softmmu/hw/display/omap_dss.o
>   CC      alpha-softmmu/hw/timer/mc146818rtc.o
>   CC      aarch64-softmmu/hw/display/omap_lcdc.o
>   CC      alpha-softmmu/hw/vfio/common.o
>   CC      arm-softmmu/hw/display/omap_lcdc.o
>   CC      aarch64-softmmu/hw/display/pxa2xx_lcd.o
>   GEN     i386-softmmu/hmp-commands.h
>   CC      arm-softmmu/hw/display/pxa2xx_lcd.o
>   GEN     i386-softmmu/hmp-commands-info.h
>   GEN     i386-softmmu/config-target.h
>   CC      i386-softmmu/exec.o
>   CC      alpha-softmmu/hw/vfio/pci.o
>   CC      aarch64-softmmu/hw/display/bcm2835_fb.o
>   CC      arm-softmmu/hw/display/bcm2835_fb.o
>   CC      alpha-softmmu/hw/vfio/pci-quirks.o
>   CC      arm-softmmu/hw/display/vga.o
>   CC      aarch64-softmmu/hw/display/vga.o
>   CC      alpha-softmmu/hw/vfio/platform.o
>   CC      i386-softmmu/translate-all.o
>   CC      alpha-softmmu/hw/vfio/spapr.o
>   CC      alpha-softmmu/hw/virtio/virtio.o
>   CC      arm-softmmu/hw/display/virtio-gpu.o
>   CC      aarch64-softmmu/hw/display/virtio-gpu.o
>   CC      i386-softmmu/cpu-exec.o
>   CC      arm-softmmu/hw/display/virtio-gpu-3d.o
>   CC      i386-softmmu/translate-common.o
>   CC      aarch64-softmmu/hw/display/virtio-gpu-3d.o
>   CC      alpha-softmmu/hw/virtio/virtio-balloon.o
>   CC      i386-softmmu/cpu-exec-common.o
>   CC      arm-softmmu/hw/display/virtio-gpu-pci.o
>   CC      alpha-softmmu/hw/virtio/vhost.o
>   CC      aarch64-softmmu/hw/display/virtio-gpu-pci.o
>   CC      i386-softmmu/tcg/tcg.o
>   CC      arm-softmmu/hw/dma/omap_dma.o
>   CC      alpha-softmmu/hw/virtio/vhost-backend.o
>   CC      aarch64-softmmu/hw/display/dpcd.o
>   CC      alpha-softmmu/hw/virtio/vhost-user.o
>   CC      aarch64-softmmu/hw/display/xlnx_dp.o
>   CC      arm-softmmu/hw/dma/soc_dma.o
>   CC      alpha-softmmu/hw/virtio/vhost-vsock.o
>   CC      aarch64-softmmu/hw/dma/xlnx_dpdma.o
>   CC      arm-softmmu/hw/dma/pxa2xx_dma.o
>   CC      alpha-softmmu/hw/virtio/virtio-crypto.o
>   CC      arm-softmmu/hw/dma/bcm2835_dma.o
>   CC      alpha-softmmu/hw/virtio/virtio-crypto-pci.o
>   CC      aarch64-softmmu/hw/dma/omap_dma.o
>   CC      i386-softmmu/tcg/tcg-op.o
>   CC      arm-softmmu/hw/gpio/omap_gpio.o
>   CC      alpha-softmmu/hw/alpha/dp264.o
>   CC      aarch64-softmmu/hw/dma/soc_dma.o
>   CC      arm-softmmu/hw/gpio/imx_gpio.o
>   CC      alpha-softmmu/hw/alpha/pci.o
>   CC      arm-softmmu/hw/gpio/bcm2835_gpio.o
>   CC      aarch64-softmmu/hw/dma/pxa2xx_dma.o
>   CC      alpha-softmmu/hw/alpha/typhoon.o
>   CC      arm-softmmu/hw/i2c/omap_i2c.o
>   CC      aarch64-softmmu/hw/dma/bcm2835_dma.o
>   CC      alpha-softmmu/target/alpha/machine.o
>   CC      arm-softmmu/hw/input/pxa2xx_keypad.o
>   CC      aarch64-softmmu/hw/gpio/omap_gpio.o
>   CC      alpha-softmmu/target/alpha/translate.o
>   CC      arm-softmmu/hw/input/tsc210x.o
>   CC      aarch64-softmmu/hw/gpio/imx_gpio.o
>   CC      i386-softmmu/tcg/optimize.o
>   CC      aarch64-softmmu/hw/gpio/bcm2835_gpio.o
>   CC      arm-softmmu/hw/intc/armv7m_nvic.o
>   CC      aarch64-softmmu/hw/i2c/omap_i2c.o
>   CC      aarch64-softmmu/hw/input/pxa2xx_keypad.o
>   CC      alpha-softmmu/target/alpha/helper.o
>   CC      i386-softmmu/tcg/tcg-common.o
>   CC      arm-softmmu/hw/intc/exynos4210_gic.o
>   CC      alpha-softmmu/target/alpha/cpu.o
>   CC      aarch64-softmmu/hw/input/tsc210x.o
>   CC      i386-softmmu/fpu/softfloat.o
>   CC      arm-softmmu/hw/intc/exynos4210_combiner.o
>   CC      alpha-softmmu/target/alpha/int_helper.o
>   CC      arm-softmmu/hw/intc/omap_intc.o
>   CC      aarch64-softmmu/hw/intc/armv7m_nvic.o
>   CC      alpha-softmmu/target/alpha/fpu_helper.o
>   CC      arm-softmmu/hw/intc/bcm2835_ic.o
>   CC      alpha-softmmu/target/alpha/vax_helper.o
>   CC      aarch64-softmmu/hw/intc/exynos4210_gic.o
>   CC      arm-softmmu/hw/intc/bcm2836_control.o
>   CC      alpha-softmmu/target/alpha/sys_helper.o
>   CC      arm-softmmu/hw/intc/allwinner-a10-pic.o
>   CC      aarch64-softmmu/hw/intc/exynos4210_combiner.o
>   CC      alpha-softmmu/target/alpha/mem_helper.o
>   CC      arm-softmmu/hw/intc/aspeed_vic.o
>   CC      aarch64-softmmu/hw/intc/omap_intc.o
>   CC      alpha-softmmu/target/alpha/gdbstub.o
>   CC      arm-softmmu/hw/intc/arm_gicv3_cpuif.o
>   GEN     trace/generated-helpers.c
>   CC      aarch64-softmmu/hw/intc/bcm2835_ic.o
>   CC      alpha-softmmu/trace/control-target.o
>   CC      i386-softmmu/disas.o
>   CC      aarch64-softmmu/hw/intc/bcm2836_control.o
>   CC      i386-softmmu/tcg-runtime.o
>   CC      alpha-softmmu/trace/generated-helpers.o
>   CC      aarch64-softmmu/hw/intc/allwinner-a10-pic.o
>   CC      i386-softmmu/hax-stub.o
>   LINK    alpha-softmmu/qemu-system-alpha
>   CC      aarch64-softmmu/hw/intc/aspeed_vic.o
>   CC      i386-softmmu/kvm-stub.o
>   CC      arm-softmmu/hw/misc/ivshmem.o
>   CC      aarch64-softmmu/hw/intc/arm_gicv3_cpuif.o
>   CC      i386-softmmu/arch_init.o
>   CC      arm-softmmu/hw/misc/arm_sysctl.o
>   CC      i386-softmmu/cpus.o
>   CC      arm-softmmu/hw/misc/cbus.o
>   CC      aarch64-softmmu/hw/misc/ivshmem.o
>   CC      i386-softmmu/monitor.o
>   CC      arm-softmmu/hw/misc/exynos4210_pmu.o
>   CC      aarch64-softmmu/hw/misc/arm_sysctl.o
>   CC      i386-softmmu/gdbstub.o
>   CC      arm-softmmu/hw/misc/exynos4210_clk.o
>   CC      arm-softmmu/hw/misc/imx_ccm.o
>   CC      aarch64-softmmu/hw/misc/cbus.o
>   CC      aarch64-softmmu/hw/misc/exynos4210_pmu.o
>   CC      i386-softmmu/balloon.o
>   CC      arm-softmmu/hw/misc/imx31_ccm.o
>   CC      aarch64-softmmu/hw/misc/exynos4210_clk.o
>   CC      i386-softmmu/ioport.o
>   CC      aarch64-softmmu/hw/misc/imx_ccm.o
>   CC      arm-softmmu/hw/misc/imx25_ccm.o
>   CC      aarch64-softmmu/hw/misc/imx31_ccm.o
>   CC      arm-softmmu/hw/misc/imx6_ccm.o
>   CC      i386-softmmu/numa.o
>   CC      aarch64-softmmu/hw/misc/imx25_ccm.o
>   GEN     lm32-softmmu/hmp-commands.h
>   CC      arm-softmmu/hw/misc/imx6_src.o
>   GEN     lm32-softmmu/hmp-commands-info.h
>   CC      aarch64-softmmu/hw/misc/imx6_ccm.o
>   GEN     lm32-softmmu/config-target.h
>   CC      lm32-softmmu/exec.o
>   CC      i386-softmmu/qtest.o
>   CC      arm-softmmu/hw/misc/mst_fpga.o
>   CC      aarch64-softmmu/hw/misc/imx6_src.o
>   CC      arm-softmmu/hw/misc/omap_clk.o
>   CC      aarch64-softmmu/hw/misc/mst_fpga.o
>   CC      aarch64-softmmu/hw/misc/omap_clk.o
>   CC      i386-softmmu/bootdevice.o
>   CC      arm-softmmu/hw/misc/omap_gpmc.o
>   CC      aarch64-softmmu/hw/misc/omap_gpmc.o
>   CC      i386-softmmu/memory.o
>   CC      arm-softmmu/hw/misc/omap_l4.o
>   CC      aarch64-softmmu/hw/misc/omap_l4.o
>   CC      lm32-softmmu/translate-all.o
>   CC      arm-softmmu/hw/misc/omap_sdrc.o
>   CC      aarch64-softmmu/hw/misc/omap_sdrc.o
>   CC      aarch64-softmmu/hw/misc/omap_tap.o
>   CC      arm-softmmu/hw/misc/omap_tap.o
>   CC      aarch64-softmmu/hw/misc/bcm2835_mbox.o
>   CC      lm32-softmmu/cpu-exec.o
>   CC      i386-softmmu/cputlb.o
>   CC      arm-softmmu/hw/misc/bcm2835_mbox.o
>   CC      aarch64-softmmu/hw/misc/bcm2835_property.o
>   CC      lm32-softmmu/translate-common.o
>   CC      arm-softmmu/hw/misc/bcm2835_property.o
>   CC      lm32-softmmu/cpu-exec-common.o
>   CC      aarch64-softmmu/hw/misc/bcm2835_rng.o
>   CC      lm32-softmmu/tcg/tcg.o
>   CC      arm-softmmu/hw/misc/bcm2835_rng.o
>   CC      aarch64-softmmu/hw/misc/zynq_slcr.o
>   CC      arm-softmmu/hw/misc/zynq_slcr.o
>   CC      i386-softmmu/memory_mapping.o
>   CC      aarch64-softmmu/hw/misc/zynq-xadc.o
>   CC      arm-softmmu/hw/misc/zynq-xadc.o
>   CC      i386-softmmu/dump.o
>   CC      arm-softmmu/hw/misc/stm32f2xx_syscfg.o
>   CC      aarch64-softmmu/hw/misc/stm32f2xx_syscfg.o
>   CC      arm-softmmu/hw/misc/edu.o
>   CC      i386-softmmu/migration/ram.o
>   CC      aarch64-softmmu/hw/misc/edu.o
>   CC      lm32-softmmu/tcg/tcg-op.o
>   CC      arm-softmmu/hw/misc/aspeed_scu.o
>   CC      aarch64-softmmu/hw/misc/auxbus.o
>   CC      arm-softmmu/hw/misc/aspeed_sdmc.o
>   CC      arm-softmmu/hw/net/virtio-net.o
>   CC      i386-softmmu/migration/savevm.o
>   CC      aarch64-softmmu/hw/misc/aspeed_scu.o
>   CC      aarch64-softmmu/hw/misc/aspeed_sdmc.o
>   CC      arm-softmmu/hw/net/vhost_net.o
>   CC      aarch64-softmmu/hw/net/virtio-net.o
>   CC      i386-softmmu/xen-common-stub.o
>   CC      arm-softmmu/hw/pcmcia/pxa2xx.o
>   CC      i386-softmmu/xen-hvm-stub.o
>   CC      aarch64-softmmu/hw/net/vhost_net.o
>   CC      lm32-softmmu/tcg/optimize.o
>   CC      i386-softmmu/hw/9pfs/virtio-9p-device.o
>   CC      arm-softmmu/hw/scsi/virtio-scsi.o
>   CC      aarch64-softmmu/hw/pcmcia/pxa2xx.o
>   CC      i386-softmmu/hw/block/virtio-blk.o
>   CC      arm-softmmu/hw/scsi/virtio-scsi-dataplane.o
>   CC      arm-softmmu/hw/scsi/vhost-scsi.o
>   CC      aarch64-softmmu/hw/scsi/virtio-scsi.o
>   CC      lm32-softmmu/tcg/tcg-common.o
>   CC      i386-softmmu/hw/block/dataplane/virtio-blk.o
>   CC      arm-softmmu/hw/sd/omap_mmc.o
>   CC      lm32-softmmu/fpu/softfloat.o
>   CC      aarch64-softmmu/hw/scsi/virtio-scsi-dataplane.o
>   CC      i386-softmmu/hw/char/virtio-serial-bus.o
>   CC      arm-softmmu/hw/sd/pxa2xx_mmci.o
>   CC      aarch64-softmmu/hw/scsi/vhost-scsi.o
>   CC      i386-softmmu/hw/core/nmi.o
>   CC      aarch64-softmmu/hw/sd/omap_mmc.o
>   CC      arm-softmmu/hw/sd/bcm2835_sdhost.o
>   CC      i386-softmmu/hw/core/generic-loader.o
>   CC      aarch64-softmmu/hw/sd/pxa2xx_mmci.o
>   CC      i386-softmmu/hw/core/null-machine.o
>   CC      arm-softmmu/hw/ssi/omap_spi.o
>   CC      i386-softmmu/hw/cpu/core.o
>   CC      aarch64-softmmu/hw/sd/bcm2835_sdhost.o
>   CC      arm-softmmu/hw/ssi/imx_spi.o
>   CC      i386-softmmu/hw/display/vga.o
>   CC      aarch64-softmmu/hw/ssi/omap_spi.o
>   CC      arm-softmmu/hw/timer/exynos4210_mct.o
>   CC      aarch64-softmmu/hw/ssi/imx_spi.o
>   CC      lm32-softmmu/disas.o
>   CC      aarch64-softmmu/hw/timer/exynos4210_mct.o
>   CC      arm-softmmu/hw/timer/exynos4210_pwm.o
>   CC      lm32-softmmu/tcg-runtime.o
>   CC      i386-softmmu/hw/display/virtio-gpu.o
>   CC      arm-softmmu/hw/timer/exynos4210_rtc.o
>   CC      aarch64-softmmu/hw/timer/exynos4210_pwm.o
>   CC      aarch64-softmmu/hw/timer/exynos4210_rtc.o
>   CC      lm32-softmmu/hax-stub.o
>   CC      arm-softmmu/hw/timer/omap_gptimer.o
>   CC      lm32-softmmu/kvm-stub.o
>   CC      aarch64-softmmu/hw/timer/omap_gptimer.o
>   CC      lm32-softmmu/arch_init.o
>   CC      arm-softmmu/hw/timer/omap_synctimer.o
>   CC      i386-softmmu/hw/display/virtio-gpu-3d.o
>   CC      lm32-softmmu/cpus.o
>   CC      arm-softmmu/hw/timer/pxa2xx_timer.o
>   CC      aarch64-softmmu/hw/timer/omap_synctimer.o
>   CC      aarch64-softmmu/hw/timer/pxa2xx_timer.o
>   CC      arm-softmmu/hw/timer/digic-timer.o
>   CC      lm32-softmmu/monitor.o
>   CC      i386-softmmu/hw/display/virtio-gpu-pci.o
>   CC      arm-softmmu/hw/timer/allwinner-a10-pit.o
>   CC      aarch64-softmmu/hw/timer/digic-timer.o
>   CC      i386-softmmu/hw/display/virtio-vga.o
>   CC      arm-softmmu/hw/usb/tusb6010.o
>   CC      aarch64-softmmu/hw/timer/allwinner-a10-pit.o
>   CC      i386-softmmu/hw/intc/apic.o
>   CC      aarch64-softmmu/hw/usb/tusb6010.o
>   CC      arm-softmmu/hw/vfio/common.o
>   CC      aarch64-softmmu/hw/vfio/common.o
>   CC      lm32-softmmu/gdbstub.o
>   CC      i386-softmmu/hw/intc/apic_common.o
>   CC      arm-softmmu/hw/vfio/pci.o
>   CC      lm32-softmmu/balloon.o
>   CC      aarch64-softmmu/hw/vfio/pci.o
>   CC      i386-softmmu/hw/intc/ioapic.o
>   CC      lm32-softmmu/ioport.o
>   CC      i386-softmmu/hw/isa/lpc_ich9.o
>   CC      lm32-softmmu/numa.o
>   CC      arm-softmmu/hw/vfio/pci-quirks.o
>   CC      aarch64-softmmu/hw/vfio/pci-quirks.o
>   CC      lm32-softmmu/qtest.o
>   CC      i386-softmmu/hw/misc/vmport.o
>   CC      arm-softmmu/hw/vfio/platform.o
>   CC      i386-softmmu/hw/misc/ivshmem.o
>   CC      aarch64-softmmu/hw/vfio/platform.o
>   CC      lm32-softmmu/bootdevice.o
>   CC      arm-softmmu/hw/vfio/calxeda-xgmac.o
>   CC      i386-softmmu/hw/misc/pvpanic.o
>   CC      lm32-softmmu/memory.o
>   CC      aarch64-softmmu/hw/vfio/calxeda-xgmac.o
>   CC      arm-softmmu/hw/vfio/amd-xgbe.o
>   CC      i386-softmmu/hw/misc/edu.o
>   CC      arm-softmmu/hw/vfio/spapr.o
>   CC      aarch64-softmmu/hw/vfio/amd-xgbe.o
>   CC      i386-softmmu/hw/net/virtio-net.o
>   CC      aarch64-softmmu/hw/vfio/spapr.o
>   CC      arm-softmmu/hw/virtio/virtio.o
>   CC      aarch64-softmmu/hw/virtio/virtio.o
>   CC      lm32-softmmu/cputlb.o
>   CC      i386-softmmu/hw/net/vhost_net.o
>   CC      arm-softmmu/hw/virtio/virtio-balloon.o
>   CC      i386-softmmu/hw/scsi/virtio-scsi.o
>   CC      arm-softmmu/hw/virtio/vhost.o
>   CC      aarch64-softmmu/hw/virtio/virtio-balloon.o
>   CC      i386-softmmu/hw/scsi/virtio-scsi-dataplane.o
>   CC      aarch64-softmmu/hw/virtio/vhost.o
>   CC      lm32-softmmu/memory_mapping.o
>   CC      arm-softmmu/hw/virtio/vhost-backend.o
>   CC      i386-softmmu/hw/scsi/vhost-scsi.o
>   CC      lm32-softmmu/dump.o
>   CC      i386-softmmu/hw/timer/mc146818rtc.o
>   CC      aarch64-softmmu/hw/virtio/vhost-backend.o
>   CC      arm-softmmu/hw/virtio/vhost-user.o
>   CC      i386-softmmu/hw/vfio/common.o
>   CC      arm-softmmu/hw/virtio/vhost-vsock.o
>   CC      aarch64-softmmu/hw/virtio/vhost-user.o
>   CC      lm32-softmmu/migration/ram.o
>   CC      arm-softmmu/hw/virtio/virtio-crypto.o
>   CC      i386-softmmu/hw/vfio/pci.o
>   CC      aarch64-softmmu/hw/virtio/vhost-vsock.o
>   CC      aarch64-softmmu/hw/virtio/virtio-crypto.o
>   CC      arm-softmmu/hw/virtio/virtio-crypto-pci.o
>   CC      lm32-softmmu/migration/savevm.o
>   CC      aarch64-softmmu/hw/virtio/virtio-crypto-pci.o
>   CC      i386-softmmu/hw/vfio/pci-quirks.o
>   CC      aarch64-softmmu/hw/arm/boot.o
>   CC      arm-softmmu/hw/arm/boot.o
>   CC      aarch64-softmmu/hw/arm/collie.o
>   CC      arm-softmmu/hw/arm/collie.o
>   CC      lm32-softmmu/xen-common-stub.o
>   CC      aarch64-softmmu/hw/arm/exynos4_boards.o
>   CC      i386-softmmu/hw/vfio/platform.o
>   CC      arm-softmmu/hw/arm/exynos4_boards.o
>   CC      lm32-softmmu/xen-hvm-stub.o
>   CC      lm32-softmmu/hw/core/nmi.o
>   CC      aarch64-softmmu/hw/arm/gumstix.o
>   CC      arm-softmmu/hw/arm/gumstix.o
>   CC      i386-softmmu/hw/vfio/spapr.o
>   CC      lm32-softmmu/hw/core/generic-loader.o
>   CC      aarch64-softmmu/hw/arm/highbank.o
>   CC      arm-softmmu/hw/arm/highbank.o
>   CC      i386-softmmu/hw/virtio/virtio.o
>   CC      lm32-softmmu/hw/core/null-machine.o
>   CC      aarch64-softmmu/hw/arm/digic_boards.o
>   CC      arm-softmmu/hw/arm/digic_boards.o
>   CC      lm32-softmmu/hw/cpu/core.o
>   CC      aarch64-softmmu/hw/arm/integratorcp.o
>   CC      arm-softmmu/hw/arm/integratorcp.o
>   CC      lm32-softmmu/hw/input/milkymist-softusb.o
>   CC      aarch64-softmmu/hw/arm/mainstone.o
>   CC      lm32-softmmu/hw/misc/milkymist-hpdmc.o
>   CC      i386-softmmu/hw/virtio/virtio-balloon.o
>   CC      arm-softmmu/hw/arm/mainstone.o
>   CC      aarch64-softmmu/hw/arm/musicpal.o
>   CC      arm-softmmu/hw/arm/musicpal.o
>   CC      lm32-softmmu/hw/misc/milkymist-pfpu.o
>   CC      i386-softmmu/hw/virtio/vhost.o
>   CC      lm32-softmmu/hw/net/milkymist-minimac2.o
>   CC      aarch64-softmmu/hw/arm/nseries.o
>   CC      lm32-softmmu/hw/net/vhost_net.o
>   CC      arm-softmmu/hw/arm/nseries.o
>   CC      lm32-softmmu/hw/net/rocker/qmp-norocker.o
>   CC      i386-softmmu/hw/virtio/vhost-backend.o
>   CC      aarch64-softmmu/hw/arm/omap_sx1.o
>   CC      lm32-softmmu/hw/sd/milkymist-memcard.o
>   CC      i386-softmmu/hw/virtio/vhost-user.o
>   CC      lm32-softmmu/hw/vfio/common.o
>   CC      aarch64-softmmu/hw/arm/palm.o
>   CC      arm-softmmu/hw/arm/omap_sx1.o
>   CC      i386-softmmu/hw/virtio/vhost-vsock.o
>   CC      aarch64-softmmu/hw/arm/realview.o
>   CC      arm-softmmu/hw/arm/palm.o
>   CC      lm32-softmmu/hw/vfio/platform.o
>   CC      i386-softmmu/hw/virtio/virtio-crypto.o
>   CC      aarch64-softmmu/hw/arm/spitz.o
>   CC      arm-softmmu/hw/arm/realview.o
>   CC      i386-softmmu/hw/virtio/virtio-crypto-pci.o
>   CC      lm32-softmmu/hw/vfio/spapr.o
>   CC      lm32-softmmu/hw/lm32/lm32_boards.o
>   CC      aarch64-softmmu/hw/arm/stellaris.o
>   CC      arm-softmmu/hw/arm/spitz.o
>   CC      i386-softmmu/hw/i386/multiboot.o
>   CC      lm32-softmmu/hw/lm32/milkymist.o
>   CC      i386-softmmu/hw/i386/pc.o
>   CC      aarch64-softmmu/hw/arm/tosa.o
>   CC      arm-softmmu/hw/arm/stellaris.o
>   CC      lm32-softmmu/target/lm32/translate.o
>   CC      aarch64-softmmu/hw/arm/versatilepb.o
>   CC      i386-softmmu/hw/i386/pc_piix.o
>   CC      arm-softmmu/hw/arm/tosa.o
>   CC      aarch64-softmmu/hw/arm/vexpress.o
>   CC      arm-softmmu/hw/arm/versatilepb.o
>   CC      lm32-softmmu/target/lm32/op_helper.o
>   CC      i386-softmmu/hw/i386/pc_q35.o
>   CC      aarch64-softmmu/hw/arm/virt.o
>   CC      arm-softmmu/hw/arm/vexpress.o
>   CC      lm32-softmmu/target/lm32/helper.o
>   CC      lm32-softmmu/target/lm32/cpu.o
>   CC      i386-softmmu/hw/i386/pc_sysfw.o
>   CC      arm-softmmu/hw/arm/virt.o
>   CC      i386-softmmu/hw/i386/x86-iommu.o
>   CC      aarch64-softmmu/hw/arm/xilinx_zynq.o
>   CC      lm32-softmmu/target/lm32/gdbstub.o
>   CC      i386-softmmu/hw/i386/intel_iommu.o
>   CC      arm-softmmu/hw/arm/xilinx_zynq.o
>   CC      lm32-softmmu/target/lm32/lm32-semi.o
>   CC      aarch64-softmmu/hw/arm/z2.o
>   CC      lm32-softmmu/target/lm32/machine.o
>   CC      arm-softmmu/hw/arm/z2.o
>   CC      aarch64-softmmu/hw/arm/virt-acpi-build.o
>   GEN     trace/generated-helpers.c
>   CC      lm32-softmmu/trace/control-target.o
>   CC      arm-softmmu/hw/arm/virt-acpi-build.o
>   CC      i386-softmmu/hw/i386/amd_iommu.o
>   CC      lm32-softmmu/trace/generated-helpers.o
>   CC      aarch64-softmmu/hw/arm/netduino2.o
>   CC      aarch64-softmmu/hw/arm/sysbus-fdt.o
>   LINK    lm32-softmmu/qemu-system-lm32
>   CC      arm-softmmu/hw/arm/netduino2.o
>   CC      arm-softmmu/hw/arm/sysbus-fdt.o
>   CC      aarch64-softmmu/hw/arm/armv7m.o
>   CC      i386-softmmu/hw/i386/kvmvapic.o
>   CC      aarch64-softmmu/hw/arm/exynos4210.o
>   CC      arm-softmmu/hw/arm/armv7m.o
>   CC      i386-softmmu/hw/i386/acpi-build.o
>   CC      aarch64-softmmu/hw/arm/pxa2xx.o
>   CC      arm-softmmu/hw/arm/exynos4210.o
>   CC      arm-softmmu/hw/arm/pxa2xx.o
>   GEN     m68k-softmmu/hmp-commands.h
>   GEN     m68k-softmmu/hmp-commands-info.h
>   GEN     m68k-softmmu/config-target.h
>   CC      i386-softmmu/hw/i386/pci-assign-load-rom.o
>   CC      m68k-softmmu/exec.o
>   CC      aarch64-softmmu/hw/arm/pxa2xx_gpio.o
>   CC      aarch64-softmmu/hw/arm/pxa2xx_pic.o
>   CC      i386-softmmu/target/i386/translate.o
>   CC      arm-softmmu/hw/arm/pxa2xx_gpio.o
>   CC      aarch64-softmmu/hw/arm/digic.o
>   CC      arm-softmmu/hw/arm/pxa2xx_pic.o
>   CC      aarch64-softmmu/hw/arm/omap1.o
>   CC      arm-softmmu/hw/arm/digic.o
>   CC      arm-softmmu/hw/arm/omap1.o
>   CC      m68k-softmmu/translate-all.o
>   CC      m68k-softmmu/cpu-exec.o
>   CC      aarch64-softmmu/hw/arm/omap2.o
>   CC      m68k-softmmu/translate-common.o
>   CC      arm-softmmu/hw/arm/omap2.o
>   CC      aarch64-softmmu/hw/arm/strongarm.o
>   CC      m68k-softmmu/cpu-exec-common.o
>   CC      aarch64-softmmu/hw/arm/allwinner-a10.o
>   CC      arm-softmmu/hw/arm/strongarm.o
>   CC      m68k-softmmu/tcg/tcg.o
>   CC      aarch64-softmmu/hw/arm/cubieboard.o
>   CC      arm-softmmu/hw/arm/allwinner-a10.o
>   CC      aarch64-softmmu/hw/arm/bcm2835_peripherals.o
>   CC      arm-softmmu/hw/arm/cubieboard.o
>   CC      aarch64-softmmu/hw/arm/bcm2836.o
>   CC      m68k-softmmu/tcg/tcg-op.o
>   CC      arm-softmmu/hw/arm/bcm2835_peripherals.o
>   CC      aarch64-softmmu/hw/arm/raspi.o
>   CC      i386-softmmu/target/i386/helper.o
>   CC      arm-softmmu/hw/arm/bcm2836.o
>   CC      aarch64-softmmu/hw/arm/stm32f205_soc.o
>   CC      i386-softmmu/target/i386/cpu.o
>   CC      arm-softmmu/hw/arm/raspi.o
>   CC      aarch64-softmmu/hw/arm/xlnx-zynqmp.o
>   CC      arm-softmmu/hw/arm/stm32f205_soc.o
>   CC      aarch64-softmmu/hw/arm/xlnx-ep108.o
>   CC      arm-softmmu/hw/arm/fsl-imx25.o
>   CC      i386-softmmu/target/i386/bpt_helper.o
>   CC      aarch64-softmmu/hw/arm/fsl-imx25.o
>   CC      m68k-softmmu/tcg/optimize.o
>   CC      arm-softmmu/hw/arm/imx25_pdk.o
>   CC      i386-softmmu/target/i386/excp_helper.o
>   CC      aarch64-softmmu/hw/arm/imx25_pdk.o
>   CC      i386-softmmu/target/i386/fpu_helper.o
>   CC      arm-softmmu/hw/arm/fsl-imx31.o
>   CC      aarch64-softmmu/hw/arm/fsl-imx31.o
>   CC      arm-softmmu/hw/arm/kzm.o
>   CC      m68k-softmmu/tcg/tcg-common.o
>   CC      aarch64-softmmu/hw/arm/kzm.o
>   CC      m68k-softmmu/fpu/softfloat.o
>   CC      arm-softmmu/hw/arm/fsl-imx6.o
>   CC      aarch64-softmmu/hw/arm/fsl-imx6.o
>   CC      arm-softmmu/hw/arm/sabrelite.o
>   CC      aarch64-softmmu/hw/arm/sabrelite.o
>   CC      arm-softmmu/hw/arm/aspeed_soc.o
>   CC      arm-softmmu/hw/arm/aspeed.o
>   CC      aarch64-softmmu/hw/arm/aspeed_soc.o
>   CC      arm-softmmu/target/arm/arm-semi.o
>   CC      aarch64-softmmu/hw/arm/aspeed.o
>   CC      i386-softmmu/target/i386/cc_helper.o
>   CC      aarch64-softmmu/target/arm/arm-semi.o
>   CC      arm-softmmu/target/arm/machine.o
>   CC      m68k-softmmu/disas.o
>   CC      arm-softmmu/target/arm/psci.o
>   CC      aarch64-softmmu/target/arm/machine.o
>   CC      i386-softmmu/target/i386/int_helper.o
>   CC      i386-softmmu/target/i386/svm_helper.o
>   CC      m68k-softmmu/tcg-runtime.o
>   CC      arm-softmmu/target/arm/arch_dump.o
>   CC      aarch64-softmmu/target/arm/psci.o
>   GEN     m68k-softmmu/gdbstub-xml.c
>   CC      i386-softmmu/target/i386/smm_helper.o
>   CC      aarch64-softmmu/target/arm/arch_dump.o
>   CC      arm-softmmu/target/arm/monitor.o
>   CC      m68k-softmmu/hax-stub.o
>   CC      arm-softmmu/target/arm/kvm-stub.o
>   CC      aarch64-softmmu/target/arm/monitor.o
>   CC      i386-softmmu/target/i386/misc_helper.o
>   CC      m68k-softmmu/kvm-stub.o
>   CC      aarch64-softmmu/target/arm/kvm-stub.o
>   CC      arm-softmmu/target/arm/translate.o
>   CC      m68k-softmmu/arch_init.o
>   CC      i386-softmmu/target/i386/mem_helper.o
>   CC      aarch64-softmmu/target/arm/translate.o
>   CC      m68k-softmmu/cpus.o
>   CC      i386-softmmu/target/i386/seg_helper.o
>   CC      m68k-softmmu/monitor.o
>   CC      m68k-softmmu/gdbstub.o
>   CC      i386-softmmu/target/i386/mpx_helper.o
>   CC      m68k-softmmu/balloon.o
>   CC      i386-softmmu/target/i386/gdbstub.o
>   CC      m68k-softmmu/ioport.o
>   CC      arm-softmmu/target/arm/op_helper.o
>   CC      m68k-softmmu/numa.o
>   CC      i386-softmmu/target/i386/machine.o
>   CC      i386-softmmu/target/i386/arch_memory_mapping.o
>   CC      m68k-softmmu/qtest.o
>   CC      i386-softmmu/target/i386/arch_dump.o
>   CC      m68k-softmmu/bootdevice.o
>   CC      arm-softmmu/target/arm/helper.o
>   CC      aarch64-softmmu/target/arm/op_helper.o
>   CC      i386-softmmu/target/i386/monitor.o
>   CC      m68k-softmmu/memory.o
>   CC      i386-softmmu/target/i386/kvm-stub.o
>   GEN     trace/generated-helpers.c
>   CC      i386-softmmu/trace/control-target.o
>   CC      i386-softmmu/trace/generated-helpers.o
>   CC      aarch64-softmmu/target/arm/helper.o
>   CC      m68k-softmmu/cputlb.o
>   LINK    i386-softmmu/qemu-system-i386
>   CC      arm-softmmu/target/arm/cpu.o
>   CC      m68k-softmmu/memory_mapping.o
>   CC      arm-softmmu/target/arm/neon_helper.o
>   CC      m68k-softmmu/migration/ram.o
>   CC      m68k-softmmu/dump.o
>   CC      aarch64-softmmu/target/arm/cpu.o
>   CC      m68k-softmmu/migration/savevm.o
>   CC      aarch64-softmmu/target/arm/neon_helper.o
>   CC      arm-softmmu/target/arm/iwmmxt_helper.o
>   GEN     microblazeel-softmmu/hmp-commands.h
>   GEN     microblazeel-softmmu/hmp-commands-info.h
>   GEN     microblazeel-softmmu/config-target.h
>   CC      microblazeel-softmmu/exec.o
>   CC      m68k-softmmu/xen-common-stub.o
>   CC      m68k-softmmu/xen-hvm-stub.o
>   CC      arm-softmmu/target/arm/gdbstub.o
>   CC      aarch64-softmmu/target/arm/iwmmxt_helper.o
>   CC      m68k-softmmu/hw/char/mcf_uart.o
>   CC      m68k-softmmu/hw/core/nmi.o
>   CC      arm-softmmu/target/arm/crypto_helper.o
>   CC      m68k-softmmu/hw/core/generic-loader.o
>   CC      m68k-softmmu/hw/core/null-machine.o
>   CC      m68k-softmmu/hw/cpu/core.o
>   CC      arm-softmmu/target/arm/arm-powerctl.o
>   CC      aarch64-softmmu/target/arm/gdbstub.o
>   CC      microblazeel-softmmu/translate-all.o
>   CC      m68k-softmmu/hw/net/mcf_fec.o
>   GEN     trace/generated-helpers.c
>   CC      arm-softmmu/trace/control-target.o
>   CC      aarch64-softmmu/target/arm/cpu64.o
>   CC      m68k-softmmu/hw/net/vhost_net.o
>   CC      arm-softmmu/gdbstub-xml.o
>   CC      m68k-softmmu/hw/net/rocker/qmp-norocker.o
>   CC      microblazeel-softmmu/cpu-exec.o
>   CC      arm-softmmu/trace/generated-helpers.o
>   CC      aarch64-softmmu/target/arm/translate-a64.o
>   CC      m68k-softmmu/hw/vfio/common.o
>   LINK    arm-softmmu/qemu-system-arm
>   CC      microblazeel-softmmu/translate-common.o
>   CC      m68k-softmmu/hw/vfio/platform.o
>   CC      microblazeel-softmmu/cpu-exec-common.o
>   CC      m68k-softmmu/hw/vfio/spapr.o
>   CC      microblazeel-softmmu/tcg/tcg.o
>   CC      m68k-softmmu/hw/m68k/an5206.o
>   CC      m68k-softmmu/hw/m68k/mcf5208.o
>   CC      m68k-softmmu/hw/m68k/mcf5206.o
>   CC      m68k-softmmu/hw/m68k/mcf_intc.o
>   CC      m68k-softmmu/target/m68k/m68k-semi.o
>   CC      m68k-softmmu/target/m68k/translate.o
>   CC      microblazeel-softmmu/tcg/tcg-op.o
>   CC      aarch64-softmmu/target/arm/helper-a64.o
>   CC      m68k-softmmu/target/m68k/op_helper.o
>   CC      aarch64-softmmu/target/arm/gdbstub64.o
>   CC      aarch64-softmmu/target/arm/crypto_helper.o
>   CC      m68k-softmmu/target/m68k/helper.o
>   CC      m68k-softmmu/target/m68k/cpu.o
>   CC      aarch64-softmmu/target/arm/arm-powerctl.o
>   GEN     trace/generated-helpers.c
>   CC      aarch64-softmmu/trace/control-target.o
>   CC      m68k-softmmu/target/m68k/gdbstub.o
>   GEN     trace/generated-helpers.c
>   CC      m68k-softmmu/trace/control-target.o
>   CC      microblazeel-softmmu/tcg/optimize.o
>   CC      aarch64-softmmu/gdbstub-xml.o
>   CC      aarch64-softmmu/trace/generated-helpers.o
>   CC      m68k-softmmu/gdbstub-xml.o
>   LINK    aarch64-softmmu/qemu-system-aarch64
>   CC      m68k-softmmu/trace/generated-helpers.o
>   GEN     microblaze-softmmu/hmp-commands.h
>   GEN     microblaze-softmmu/hmp-commands-info.h
>   GEN     microblaze-softmmu/config-target.h
>   CC      microblaze-softmmu/exec.o
>   LINK    m68k-softmmu/qemu-system-m68k
>   CC      microblazeel-softmmu/tcg/tcg-common.o
>   CC      microblazeel-softmmu/fpu/softfloat.o
>   CC      microblaze-softmmu/translate-all.o
>   GEN     mips64el-softmmu/hmp-commands.h
>   GEN     mips64el-softmmu/hmp-commands-info.h
>   GEN     mips64el-softmmu/config-target.h
>   CC      microblaze-softmmu/cpu-exec.o
>   CC      mips64el-softmmu/exec.o
>   GEN     mips64-softmmu/hmp-commands.h
>   GEN     mips64-softmmu/hmp-commands-info.h
>   CC      microblaze-softmmu/translate-common.o
>   GEN     mips64-softmmu/config-target.h
>   CC      mips64-softmmu/exec.o
>   CC      microblaze-softmmu/cpu-exec-common.o
>   CC      microblazeel-softmmu/disas.o
>   CC      microblazeel-softmmu/tcg-runtime.o
>   CC      microblaze-softmmu/tcg/tcg.o
>   CC      microblazeel-softmmu/hax-stub.o
>   CC      mips64el-softmmu/translate-all.o
>   CC      microblazeel-softmmu/kvm-stub.o
>   CC      mips64el-softmmu/cpu-exec.o
>   CC      mips64-softmmu/translate-all.o
>   CC      microblazeel-softmmu/arch_init.o
>   CC      microblaze-softmmu/tcg/tcg-op.o
>   CC      mips64el-softmmu/translate-common.o
>   CC      mips64-softmmu/cpu-exec.o
>   CC      microblazeel-softmmu/cpus.o
>   CC      mips64el-softmmu/cpu-exec-common.o
>   CC      mips64-softmmu/translate-common.o
>   CC      microblazeel-softmmu/monitor.o
>   CC      mips64el-softmmu/tcg/tcg.o
>   CC      mips64-softmmu/cpu-exec-common.o
>   CC      mips64-softmmu/tcg/tcg.o
>   CC      microblaze-softmmu/tcg/optimize.o
>   CC      microblazeel-softmmu/gdbstub.o
>   CC      microblaze-softmmu/tcg/tcg-common.o
>   CC      microblaze-softmmu/fpu/softfloat.o
>   CC      microblazeel-softmmu/balloon.o
>   CC      mips64el-softmmu/tcg/tcg-op.o
>   CC      mips64-softmmu/tcg/tcg-op.o
>   CC      microblazeel-softmmu/ioport.o
>   CC      microblazeel-softmmu/numa.o
>   CC      microblazeel-softmmu/qtest.o
>   CC      microblaze-softmmu/disas.o
>   CC      microblazeel-softmmu/bootdevice.o
>   CC      microblaze-softmmu/tcg-runtime.o
>   CC      microblazeel-softmmu/memory.o
>   CC      microblaze-softmmu/hax-stub.o
>   CC      mips64el-softmmu/tcg/optimize.o
>   CC      microblaze-softmmu/kvm-stub.o
>   CC      mips64-softmmu/tcg/optimize.o
>   CC      microblaze-softmmu/arch_init.o
>   CC      microblazeel-softmmu/cputlb.o
>   CC      microblaze-softmmu/cpus.o
>   CC      mips64-softmmu/tcg/tcg-common.o
>   CC      mips64el-softmmu/tcg/tcg-common.o
>   CC      mips64-softmmu/fpu/softfloat.o
>   CC      microblaze-softmmu/monitor.o
>   CC      mips64el-softmmu/fpu/softfloat.o
>   CC      microblazeel-softmmu/memory_mapping.o
>   CC      microblazeel-softmmu/dump.o
>   CC      microblaze-softmmu/gdbstub.o
>   CC      microblazeel-softmmu/migration/ram.o
>   CC      mips64el-softmmu/disas.o
>   CC      microblaze-softmmu/balloon.o
>   CC      mips64-softmmu/disas.o
>   CC      microblaze-softmmu/ioport.o
>   CC      mips64el-softmmu/tcg-runtime.o
>   CC      microblazeel-softmmu/migration/savevm.o
>   CC      mips64-softmmu/tcg-runtime.o
>   CC      mips64el-softmmu/hax-stub.o
>   CC      microblaze-softmmu/numa.o
>   CC      mips64-softmmu/hax-stub.o
>   CC      mips64el-softmmu/kvm-stub.o
>   CC      mips64-softmmu/kvm-stub.o
>   CC      microblaze-softmmu/qtest.o
>   CC      mips64el-softmmu/arch_init.o
>   CC      microblazeel-softmmu/xen-common-stub.o
>   CC      mips64-softmmu/arch_init.o
>   CC      microblazeel-softmmu/xen-hvm-stub.o
>   CC      mips64el-softmmu/cpus.o
>   CC      mips64-softmmu/cpus.o
>   CC      microblaze-softmmu/bootdevice.o
>   CC      microblazeel-softmmu/hw/core/nmi.o
>   CC      mips64el-softmmu/monitor.o
>   CC      mips64-softmmu/monitor.o
>   CC      microblaze-softmmu/memory.o
>   CC      microblazeel-softmmu/hw/core/generic-loader.o
>   CC      microblazeel-softmmu/hw/core/null-machine.o
>   CC      microblazeel-softmmu/hw/cpu/core.o
>   CC      mips64-softmmu/gdbstub.o
>   CC      mips64el-softmmu/gdbstub.o
>   CC      microblaze-softmmu/cputlb.o
>   CC      microblazeel-softmmu/hw/net/xilinx_ethlite.o
>   CC      mips64-softmmu/balloon.o
>   CC      mips64el-softmmu/balloon.o
>   CC      microblazeel-softmmu/hw/net/vhost_net.o
>   CC      mips64-softmmu/ioport.o
>   CC      mips64el-softmmu/ioport.o
>   CC      microblazeel-softmmu/hw/net/rocker/qmp-norocker.o
>   CC      mips64-softmmu/numa.o
>   CC      microblazeel-softmmu/hw/vfio/common.o
>   CC      microblaze-softmmu/memory_mapping.o
>   CC      mips64el-softmmu/numa.o
>   CC      mips64-softmmu/qtest.o
>   CC      microblaze-softmmu/dump.o
>   CC      mips64el-softmmu/qtest.o
>   CC      microblazeel-softmmu/hw/vfio/platform.o
>   CC      mips64-softmmu/bootdevice.o
>   CC      microblaze-softmmu/migration/ram.o
>   CC      microblazeel-softmmu/hw/vfio/spapr.o
>   CC      mips64el-softmmu/bootdevice.o
>   CC      mips64-softmmu/memory.o
>   CC      microblazeel-softmmu/hw/microblaze/petalogix_s3adsp1800_mmu.o
>   CC      mips64el-softmmu/memory.o
>   CC      microblazeel-softmmu/hw/microblaze/petalogix_ml605_mmu.o
>   CC      microblaze-softmmu/migration/savevm.o
>   CC      microblazeel-softmmu/hw/microblaze/boot.o
>   CC      microblazeel-softmmu/target/microblaze/translate.o
>   CC      mips64-softmmu/cputlb.o
>   CC      mips64el-softmmu/cputlb.o
>   CC      microblaze-softmmu/xen-common-stub.o
>   CC      microblaze-softmmu/xen-hvm-stub.o
>   CC      microblazeel-softmmu/target/microblaze/op_helper.o
>   CC      microblaze-softmmu/hw/core/nmi.o
>   CC      microblazeel-softmmu/target/microblaze/helper.o
>   CC      microblaze-softmmu/hw/core/generic-loader.o
>   CC      mips64-softmmu/memory_mapping.o
>   CC      microblaze-softmmu/hw/core/null-machine.o
>   CC      mips64el-softmmu/memory_mapping.o
>   CC      microblazeel-softmmu/target/microblaze/cpu.o
>   CC      mips64-softmmu/dump.o
>   CC      microblaze-softmmu/hw/cpu/core.o
>   CC      mips64el-softmmu/dump.o
>   CC      microblazeel-softmmu/target/microblaze/gdbstub.o
>   CC      microblaze-softmmu/hw/net/xilinx_ethlite.o
>   CC      microblazeel-softmmu/target/microblaze/mmu.o
>   CC      mips64-softmmu/migration/ram.o
>   CC      microblaze-softmmu/hw/net/vhost_net.o
>   GEN     trace/generated-helpers.c
>   CC      microblazeel-softmmu/trace/control-target.o
>   CC      microblaze-softmmu/hw/net/rocker/qmp-norocker.o
>   CC      mips64el-softmmu/migration/ram.o
>   CC      microblaze-softmmu/hw/vfio/common.o
>   CC      microblazeel-softmmu/trace/generated-helpers.o
>   CC      mips64-softmmu/migration/savevm.o
>   LINK    microblazeel-softmmu/qemu-system-microblazeel
>   CC      microblaze-softmmu/hw/vfio/platform.o
>   CC      mips64el-softmmu/migration/savevm.o
>   CC      microblaze-softmmu/hw/vfio/spapr.o
>   CC      mips64-softmmu/xen-common-stub.o
>   CC      mips64-softmmu/xen-hvm-stub.o
>   CC      mips64-softmmu/hw/9pfs/virtio-9p-device.o
>   CC      microblaze-softmmu/hw/microblaze/petalogix_s3adsp1800_mmu.o
>   CC      mips64el-softmmu/xen-common-stub.o
>   CC      microblaze-softmmu/hw/microblaze/petalogix_ml605_mmu.o
>   CC      mips64-softmmu/hw/block/virtio-blk.o
>   CC      mips64el-softmmu/xen-hvm-stub.o
>   GEN     mipsel-softmmu/hmp-commands.h
>   CC      mips64el-softmmu/hw/9pfs/virtio-9p-device.o
>   CC      microblaze-softmmu/hw/microblaze/boot.o
>   GEN     mipsel-softmmu/hmp-commands-info.h
>   GEN     mipsel-softmmu/config-target.h
>   CC      mipsel-softmmu/exec.o
>   CC      mips64-softmmu/hw/block/dataplane/virtio-blk.o
>   CC      mips64el-softmmu/hw/block/virtio-blk.o
>   CC      microblaze-softmmu/target/microblaze/translate.o
>   CC      mips64-softmmu/hw/char/virtio-serial-bus.o
>   CC      mips64el-softmmu/hw/block/dataplane/virtio-blk.o
>   CC      microblaze-softmmu/target/microblaze/op_helper.o
>   CC      mips64el-softmmu/hw/char/virtio-serial-bus.o
>   CC      mips64-softmmu/hw/core/nmi.o
>   CC      mips64-softmmu/hw/core/generic-loader.o
>   CC      microblaze-softmmu/target/microblaze/helper.o
>   CC      mips64-softmmu/hw/core/null-machine.o
>   CC      mips64el-softmmu/hw/core/nmi.o
>   CC      mips64-softmmu/hw/cpu/core.o
>   CC      microblaze-softmmu/target/microblaze/cpu.o
>   CC      mips64el-softmmu/hw/core/generic-loader.o
>   CC      mipsel-softmmu/translate-all.o
>   CC      mips64-softmmu/hw/display/vga.o
>   CC      microblaze-softmmu/target/microblaze/gdbstub.o
>   CC      mips64el-softmmu/hw/core/null-machine.o
>   CC      microblaze-softmmu/target/microblaze/mmu.o
>   CC      mipsel-softmmu/cpu-exec.o
>   CC      mips64el-softmmu/hw/cpu/core.o
>   GEN     trace/generated-helpers.c
>   CC      microblaze-softmmu/trace/control-target.o
>   CC      mips64el-softmmu/hw/display/vga.o
>   CC      mipsel-softmmu/translate-common.o
>   CC      mips64-softmmu/hw/display/virtio-gpu.o
>   CC      microblaze-softmmu/trace/generated-helpers.o
>   CC      mipsel-softmmu/cpu-exec-common.o
>   CC      mipsel-softmmu/tcg/tcg.o
>   LINK    microblaze-softmmu/qemu-system-microblaze
>   CC      mips64-softmmu/hw/display/virtio-gpu-3d.o
>   CC      mips64el-softmmu/hw/display/virtio-gpu.o
>   CC      mips64-softmmu/hw/display/virtio-gpu-pci.o
>   CC      mipsel-softmmu/tcg/tcg-op.o
>   CC      mips64-softmmu/hw/intc/mips_gic.o
>   CC      mips64el-softmmu/hw/display/virtio-gpu-3d.o
>   CC      mips64-softmmu/hw/misc/ivshmem.o
>   CC      mips64-softmmu/hw/misc/mips_cmgcr.o
>   CC      mips64el-softmmu/hw/display/virtio-gpu-pci.o
>   CC      mipsel-softmmu/tcg/optimize.o
>   CC      mips64-softmmu/hw/misc/mips_cpc.o
>   CC      mips64el-softmmu/hw/intc/mips_gic.o
>   CC      mips64-softmmu/hw/misc/mips_itu.o
>   CC      mips64el-softmmu/hw/misc/ivshmem.o
>   CC      mips64-softmmu/hw/misc/edu.o
>   CC      mips64-softmmu/hw/net/virtio-net.o
>   CC      mips64el-softmmu/hw/misc/mips_cmgcr.o
>   CC      mips64el-softmmu/hw/misc/mips_cpc.o
>   CC      mips64-softmmu/hw/net/vhost_net.o
>   CC      mips64el-softmmu/hw/misc/mips_itu.o
>   CC      mips64el-softmmu/hw/misc/edu.o
>   CC      mips64-softmmu/hw/scsi/virtio-scsi.o
>   CC      mipsel-softmmu/tcg/tcg-common.o
>   CC      mips64el-softmmu/hw/net/virtio-net.o
>   CC      mips64el-softmmu/hw/net/vhost_net.o
>   CC      mipsel-softmmu/fpu/softfloat.o
>   CC      mipsel-softmmu/disas.o
>   CC      mips64-softmmu/hw/scsi/virtio-scsi-dataplane.o
>   CC      mips64-softmmu/hw/scsi/vhost-scsi.o
>   CC      mips64el-softmmu/hw/scsi/virtio-scsi.o
>   CC      mips64-softmmu/hw/timer/mips_gictimer.o
>   CC      mips64-softmmu/hw/timer/mc146818rtc.o
>   CC      mips64el-softmmu/hw/scsi/virtio-scsi-dataplane.o
>   CC      mips64-softmmu/hw/vfio/common.o
>   CC      mips64el-softmmu/hw/scsi/vhost-scsi.o
>   CC      mips64el-softmmu/hw/timer/mips_gictimer.o
>   CC      mips64el-softmmu/hw/timer/mc146818rtc.o
>   CC      mips64-softmmu/hw/vfio/pci.o
>   CC      mips64-softmmu/hw/vfio/pci-quirks.o
>   CC      mips64el-softmmu/hw/vfio/common.o
>   CC      mips64-softmmu/hw/vfio/platform.o
>   CC      mipsel-softmmu/tcg-runtime.o
>   CC      mips64el-softmmu/hw/vfio/pci.o
>   CC      mipsel-softmmu/hax-stub.o
>   CC      mips64-softmmu/hw/vfio/spapr.o
>   CC      mipsel-softmmu/kvm-stub.o
>   CC      mips64-softmmu/hw/virtio/virtio.o
>   CC      mipsel-softmmu/arch_init.o
>   CC      mips64el-softmmu/hw/vfio/pci-quirks.o
>   GEN     mips-softmmu/hmp-commands.h
>   GEN     mips-softmmu/hmp-commands-info.h
>   GEN     mips-softmmu/config-target.h
>   CC      mips-softmmu/exec.o
>   CC      mipsel-softmmu/cpus.o
>   CC      mips64el-softmmu/hw/vfio/platform.o
>   CC      mips64-softmmu/hw/virtio/virtio-balloon.o
>   CC      mips64el-softmmu/hw/vfio/spapr.o
>   CC      mipsel-softmmu/monitor.o
>   CC      mips64-softmmu/hw/virtio/vhost.o
>   CC      mips64el-softmmu/hw/virtio/virtio.o
>   CC      mips-softmmu/translate-all.o
>   CC      mips64el-softmmu/hw/virtio/virtio-balloon.o
>   CC      mips64-softmmu/hw/virtio/vhost-backend.o
>   CC      mips-softmmu/cpu-exec.o
>   CC      mips64el-softmmu/hw/virtio/vhost.o
>   CC      mips64-softmmu/hw/virtio/vhost-user.o
>   CC      mipsel-softmmu/gdbstub.o
>   CC      mips-softmmu/translate-common.o
>   CC      mips64-softmmu/hw/virtio/vhost-vsock.o
>   CC      mips-softmmu/cpu-exec-common.o
>   CC      mips64el-softmmu/hw/virtio/vhost-backend.o
>   CC      mipsel-softmmu/balloon.o
>   CC      mips64-softmmu/hw/virtio/virtio-crypto.o
>   CC      mips64el-softmmu/hw/virtio/vhost-user.o
>   CC      mips-softmmu/tcg/tcg.o
>   CC      mipsel-softmmu/ioport.o
>   CC      mips64el-softmmu/hw/virtio/vhost-vsock.o
>   CC      mips64-softmmu/hw/virtio/virtio-crypto-pci.o
>   CC      mipsel-softmmu/numa.o
>   CC      mips64el-softmmu/hw/virtio/virtio-crypto.o
>   CC      mips64-softmmu/hw/mips/mips_r4k.o
>   CC      mipsel-softmmu/qtest.o
>   CC      mips64el-softmmu/hw/virtio/virtio-crypto-pci.o
>   CC      mips64-softmmu/hw/mips/mips_malta.o
>   CC      mips64el-softmmu/hw/mips/mips_r4k.o
>   CC      mipsel-softmmu/bootdevice.o
>   CC      mipsel-softmmu/memory.o
>   CC      mips-softmmu/tcg/tcg-op.o
>   CC      mips64el-softmmu/hw/mips/mips_malta.o
>   CC      mips64-softmmu/hw/mips/mips_mipssim.o
>   CC      mips64-softmmu/hw/mips/addr.o
>   CC      mips64el-softmmu/hw/mips/mips_mipssim.o
>   CC      mipsel-softmmu/cputlb.o
>   CC      mips64-softmmu/hw/mips/cputimer.o
>   CC      mips64el-softmmu/hw/mips/addr.o
>   CC      mips64-softmmu/hw/mips/mips_int.o
>   CC      mips64el-softmmu/hw/mips/cputimer.o
>   CC      mips64-softmmu/hw/mips/mips_jazz.o
>   CC      mips64el-softmmu/hw/mips/mips_int.o
>   CC      mipsel-softmmu/memory_mapping.o
>   CC      mips64el-softmmu/hw/mips/mips_jazz.o
>   CC      mips64-softmmu/hw/mips/gt64xxx_pci.o
>   CC      mips-softmmu/tcg/optimize.o
>   CC      mipsel-softmmu/dump.o
>   CC      mips64el-softmmu/hw/mips/mips_fulong2e.o
>   CC      mips64-softmmu/hw/mips/cps.o
>   CC      mips64el-softmmu/hw/mips/gt64xxx_pci.o
>   CC      mips64-softmmu/target/mips/translate.o
>   CC      mipsel-softmmu/migration/ram.o
>   CC      mips-softmmu/tcg/tcg-common.o
>   CC      mips64el-softmmu/hw/mips/cps.o
>   CC      mips64el-softmmu/hw/mips/boston.o
>   CC      mips-softmmu/fpu/softfloat.o
>   CC      mips64el-softmmu/target/mips/translate.o
>   CC      mipsel-softmmu/migration/savevm.o
>   CC      mipsel-softmmu/xen-common-stub.o
>   CC      mipsel-softmmu/xen-hvm-stub.o
>   CC      mipsel-softmmu/hw/9pfs/virtio-9p-device.o
>   CC      mips-softmmu/disas.o
>   CC      mipsel-softmmu/hw/block/virtio-blk.o
>   CC      mips-softmmu/tcg-runtime.o
>   CC      mips-softmmu/hax-stub.o
>   CC      mipsel-softmmu/hw/block/dataplane/virtio-blk.o
>   CC      mips-softmmu/kvm-stub.o
>   CC      mips-softmmu/arch_init.o
>   CC      mipsel-softmmu/hw/char/virtio-serial-bus.o
>   CC      mips-softmmu/cpus.o
>   CC      mipsel-softmmu/hw/core/nmi.o
>   CC      mipsel-softmmu/hw/core/generic-loader.o
>   CC      mips-softmmu/monitor.o
>   CC      mips64-softmmu/target/mips/dsp_helper.o
>   CC      mipsel-softmmu/hw/core/null-machine.o
>   CC      mipsel-softmmu/hw/cpu/core.o
>   CC      mipsel-softmmu/hw/display/vga.o
>   CC      mips64el-softmmu/target/mips/dsp_helper.o
>   CC      mips-softmmu/gdbstub.o
>   CC      mips64-softmmu/target/mips/op_helper.o
>   CC      mips-softmmu/balloon.o
>   CC      mipsel-softmmu/hw/display/virtio-gpu.o
>   CC      mips64el-softmmu/target/mips/op_helper.o
>   CC      mips-softmmu/ioport.o
>   CC      mipsel-softmmu/hw/display/virtio-gpu-3d.o
>   CC      mips-softmmu/numa.o
>   CC      mipsel-softmmu/hw/display/virtio-gpu-pci.o
>   CC      mips-softmmu/qtest.o
>   CC      mipsel-softmmu/hw/intc/mips_gic.o
>   CC      mips64-softmmu/target/mips/lmi_helper.o
>   CC      mipsel-softmmu/hw/misc/ivshmem.o
>   CC      mips-softmmu/bootdevice.o
>   CC      mips64el-softmmu/target/mips/lmi_helper.o
>   CC      mips-softmmu/memory.o
>   CC      mips64-softmmu/target/mips/helper.o
>   CC      mipsel-softmmu/hw/misc/mips_cmgcr.o
>   CC      mips64el-softmmu/target/mips/helper.o
>   CC      mipsel-softmmu/hw/misc/mips_cpc.o
>   CC      mips64-softmmu/target/mips/cpu.o
>   CC      mipsel-softmmu/hw/misc/mips_itu.o
>   CC      mips64el-softmmu/target/mips/cpu.o
>   CC      mips-softmmu/cputlb.o
>   CC      mips64-softmmu/target/mips/gdbstub.o
>   CC      mips64el-softmmu/target/mips/gdbstub.o
>   CC      mips64-softmmu/target/mips/msa_helper.o
>   CC      mipsel-softmmu/hw/misc/edu.o
>   CC      mips64el-softmmu/target/mips/msa_helper.o
>   CC      mipsel-softmmu/hw/net/virtio-net.o
>   CC      mips-softmmu/memory_mapping.o
>   CC      mipsel-softmmu/hw/net/vhost_net.o
>   CC      mips-softmmu/dump.o
>   CC      mipsel-softmmu/hw/scsi/virtio-scsi.o
>   CC      mipsel-softmmu/hw/scsi/virtio-scsi-dataplane.o
>   CC      mipsel-softmmu/hw/scsi/vhost-scsi.o
>   CC      mipsel-softmmu/hw/timer/mips_gictimer.o
>   CC      mips-softmmu/migration/ram.o
>   CC      mipsel-softmmu/hw/timer/mc146818rtc.o
>   CC      mips-softmmu/migration/savevm.o
>   CC      mipsel-softmmu/hw/vfio/common.o
>   CC      mips64-softmmu/target/mips/mips-semi.o
>   CC      mips64el-softmmu/target/mips/mips-semi.o
>   CC      mips64el-softmmu/target/mips/machine.o
>   CC      mips64-softmmu/target/mips/machine.o
>   GEN     trace/generated-helpers.c
>   CC      mipsel-softmmu/hw/vfio/pci.o
>   CC      mips-softmmu/xen-common-stub.o
>   CC      mips64el-softmmu/trace/control-target.o
>   GEN     trace/generated-helpers.c
>   CC      mips-softmmu/xen-hvm-stub.o
>   CC      mips64-softmmu/trace/control-target.o
>   CC      mips64el-softmmu/trace/generated-helpers.o
>   CC      mips-softmmu/hw/9pfs/virtio-9p-device.o
>   CC      mips64-softmmu/trace/generated-helpers.o
>   LINK    mips64el-softmmu/qemu-system-mips64el
>   CC      mips-softmmu/hw/block/virtio-blk.o
>   CC      mipsel-softmmu/hw/vfio/pci-quirks.o
>   LINK    mips64-softmmu/qemu-system-mips64
>   CC      mipsel-softmmu/hw/vfio/platform.o
>   CC      mips-softmmu/hw/block/dataplane/virtio-blk.o
>   CC      mipsel-softmmu/hw/vfio/spapr.o
>   CC      mips-softmmu/hw/char/virtio-serial-bus.o
>   CC      mipsel-softmmu/hw/virtio/virtio.o
>   CC      mips-softmmu/hw/core/nmi.o
>   CC      mipsel-softmmu/hw/virtio/virtio-balloon.o
>   CC      mipsel-softmmu/hw/virtio/vhost.o
>   CC      mips-softmmu/hw/core/generic-loader.o
>   CC      mipsel-softmmu/hw/virtio/vhost-backend.o
>   CC      mips-softmmu/hw/core/null-machine.o
>   CC      mips-softmmu/hw/cpu/core.o
>   GEN     moxie-softmmu/hmp-commands.h
>   CC      mips-softmmu/hw/display/vga.o
>   GEN     moxie-softmmu/hmp-commands-info.h
>   CC      mipsel-softmmu/hw/virtio/vhost-user.o
>   GEN     moxie-softmmu/config-target.h
>   CC      moxie-softmmu/exec.o
>   GEN     nios2-softmmu/hmp-commands.h
>   GEN     nios2-softmmu/hmp-commands-info.h
>   GEN     nios2-softmmu/config-target.h
>   CC      mipsel-softmmu/hw/virtio/vhost-vsock.o
>   CC      nios2-softmmu/exec.o
>   CC      mipsel-softmmu/hw/virtio/virtio-crypto.o
>   CC      mips-softmmu/hw/display/virtio-gpu.o
>   CC      mipsel-softmmu/hw/virtio/virtio-crypto-pci.o
>   CC      mipsel-softmmu/hw/mips/mips_r4k.o
>   CC      moxie-softmmu/translate-all.o
>   CC      mips-softmmu/hw/display/virtio-gpu-3d.o
>   CC      mipsel-softmmu/hw/mips/mips_malta.o
>   CC      moxie-softmmu/cpu-exec.o
>   CC      nios2-softmmu/translate-all.o
>   CC      mips-softmmu/hw/display/virtio-gpu-pci.o
>   CC      mipsel-softmmu/hw/mips/mips_mipssim.o
>   CC      moxie-softmmu/translate-common.o
>   CC      mipsel-softmmu/hw/mips/addr.o
>   CC      nios2-softmmu/cpu-exec.o
>   CC      mipsel-softmmu/hw/mips/cputimer.o
>   CC      moxie-softmmu/cpu-exec-common.o
>   CC      mips-softmmu/hw/intc/mips_gic.o
>   CC      mipsel-softmmu/hw/mips/mips_int.o
>   CC      nios2-softmmu/translate-common.o
>   CC      moxie-softmmu/tcg/tcg.o
>   CC      mips-softmmu/hw/misc/ivshmem.o
>   CC      nios2-softmmu/cpu-exec-common.o
>   CC      mipsel-softmmu/hw/mips/gt64xxx_pci.o
>   CC      nios2-softmmu/tcg/tcg.o
>   CC      mipsel-softmmu/hw/mips/cps.o
>   CC      mips-softmmu/hw/misc/mips_cmgcr.o
>   CC      mips-softmmu/hw/misc/mips_cpc.o
>   CC      mipsel-softmmu/target/mips/translate.o
>   CC      mips-softmmu/hw/misc/mips_itu.o
>   CC      moxie-softmmu/tcg/tcg-op.o
>   CC      mips-softmmu/hw/misc/edu.o
>   CC      nios2-softmmu/tcg/tcg-op.o
>   CC      mips-softmmu/hw/net/virtio-net.o
>   CC      moxie-softmmu/tcg/optimize.o
>   CC      mips-softmmu/hw/net/vhost_net.o
>   CC      mips-softmmu/hw/scsi/virtio-scsi.o
>   CC      mips-softmmu/hw/scsi/virtio-scsi-dataplane.o
>   CC      moxie-softmmu/tcg/tcg-common.o
>   CC      mips-softmmu/hw/scsi/vhost-scsi.o
>   CC      moxie-softmmu/fpu/softfloat.o
>   CC      mips-softmmu/hw/timer/mips_gictimer.o
>   CC      mips-softmmu/hw/timer/mc146818rtc.o
>   CC      nios2-softmmu/tcg/optimize.o
>   CC      mips-softmmu/hw/vfio/common.o
>   CC      mipsel-softmmu/target/mips/dsp_helper.o
>   CC      nios2-softmmu/tcg/tcg-common.o
>   CC      mips-softmmu/hw/vfio/pci.o
>   CC      nios2-softmmu/fpu/softfloat.o
>   CC      mipsel-softmmu/target/mips/op_helper.o
>   CC      mips-softmmu/hw/vfio/pci-quirks.o
>   CC      moxie-softmmu/disas.o
>   CC      moxie-softmmu/tcg-runtime.o
>   CC      mips-softmmu/hw/vfio/platform.o
>   CC      moxie-softmmu/hax-stub.o
>   CC      moxie-softmmu/kvm-stub.o
>   CC      mips-softmmu/hw/vfio/spapr.o
>   CC      moxie-softmmu/arch_init.o
>   CC      moxie-softmmu/cpus.o
>   CC      mips-softmmu/hw/virtio/virtio.o
>   CC      nios2-softmmu/disas.o
>   CC      moxie-softmmu/monitor.o
>   CC      mipsel-softmmu/target/mips/lmi_helper.o
>   CC      nios2-softmmu/tcg-runtime.o
>   CC      mips-softmmu/hw/virtio/virtio-balloon.o
>   CC      mipsel-softmmu/target/mips/helper.o
>   CC      nios2-softmmu/hax-stub.o
>   CC      nios2-softmmu/kvm-stub.o
>   CC      mips-softmmu/hw/virtio/vhost.o
>   CC      mipsel-softmmu/target/mips/cpu.o
>   CC      nios2-softmmu/arch_init.o
>   CC      moxie-softmmu/gdbstub.o
>   CC      mipsel-softmmu/target/mips/gdbstub.o
>   CC      nios2-softmmu/cpus.o
>   CC      mips-softmmu/hw/virtio/vhost-backend.o
>   CC      mipsel-softmmu/target/mips/msa_helper.o
>   CC      mips-softmmu/hw/virtio/vhost-user.o
>   CC      moxie-softmmu/balloon.o
>   CC      mips-softmmu/hw/virtio/vhost-vsock.o
>   CC      nios2-softmmu/monitor.o
>   CC      moxie-softmmu/ioport.o
>   CC      mips-softmmu/hw/virtio/virtio-crypto.o
>   CC      moxie-softmmu/numa.o
>   CC      mips-softmmu/hw/virtio/virtio-crypto-pci.o
>   CC      moxie-softmmu/qtest.o
>   CC      mips-softmmu/hw/mips/mips_r4k.o
>   CC      nios2-softmmu/gdbstub.o
>   CC      moxie-softmmu/bootdevice.o
>   CC      mips-softmmu/hw/mips/mips_malta.o
>   CC      moxie-softmmu/memory.o
>   CC      nios2-softmmu/balloon.o
>   CC      mips-softmmu/hw/mips/mips_mipssim.o
>   CC      nios2-softmmu/ioport.o
>   CC      mips-softmmu/hw/mips/addr.o
>   CC      nios2-softmmu/numa.o
>   CC      moxie-softmmu/cputlb.o
>   CC      mips-softmmu/hw/mips/cputimer.o
>   CC      nios2-softmmu/qtest.o
>   CC      mipsel-softmmu/target/mips/mips-semi.o
>   CC      mips-softmmu/hw/mips/mips_int.o
>   CC      nios2-softmmu/bootdevice.o
>   CC      mipsel-softmmu/target/mips/machine.o
>   CC      mips-softmmu/hw/mips/gt64xxx_pci.o
>   CC      nios2-softmmu/memory.o
>   GEN     trace/generated-helpers.c
>   CC      mipsel-softmmu/trace/control-target.o
>   CC      moxie-softmmu/memory_mapping.o
>   CC      mips-softmmu/hw/mips/cps.o
>   CC      mipsel-softmmu/trace/generated-helpers.o
>   CC      mips-softmmu/target/mips/translate.o
>   CC      moxie-softmmu/dump.o
>   LINK    mipsel-softmmu/qemu-system-mipsel
>   CC      nios2-softmmu/cputlb.o
>   CC      moxie-softmmu/migration/ram.o
>   CC      moxie-softmmu/migration/savevm.o
>   CC      mips-softmmu/target/mips/dsp_helper.o
>   CC      nios2-softmmu/memory_mapping.o
>   CC      nios2-softmmu/dump.o
>   CC      moxie-softmmu/xen-common-stub.o
>   CC      moxie-softmmu/xen-hvm-stub.o
>   CC      nios2-softmmu/migration/ram.o
>   GEN     or1k-softmmu/hmp-commands.h
>   CC      moxie-softmmu/hw/core/nmi.o
>   GEN     or1k-softmmu/hmp-commands-info.h
>   GEN     or1k-softmmu/config-target.h
>   CC      moxie-softmmu/hw/core/generic-loader.o
>   CC      or1k-softmmu/exec.o
>   CC      moxie-softmmu/hw/core/null-machine.o
>   CC      nios2-softmmu/migration/savevm.o
>   CC      moxie-softmmu/hw/cpu/core.o
>   CC      mips-softmmu/target/mips/op_helper.o
>   CC      moxie-softmmu/hw/display/vga.o
>   CC      nios2-softmmu/xen-common-stub.o
>   CC      nios2-softmmu/xen-hvm-stub.o
>   CC      nios2-softmmu/hw/core/nmi.o
>   CC      or1k-softmmu/translate-all.o
>   CC      moxie-softmmu/hw/net/vhost_net.o
>   CC      nios2-softmmu/hw/core/generic-loader.o
>   CC      or1k-softmmu/cpu-exec.o
>   CC      moxie-softmmu/hw/net/rocker/qmp-norocker.o
>   CC      nios2-softmmu/hw/core/null-machine.o
>   CC      or1k-softmmu/translate-common.o
>   CC      moxie-softmmu/hw/timer/mc146818rtc.o
>   CC      nios2-softmmu/hw/cpu/core.o
>   CC      or1k-softmmu/cpu-exec-common.o
>   CC      mips-softmmu/target/mips/lmi_helper.o
>   CC      or1k-softmmu/tcg/tcg.o
>   CC      nios2-softmmu/hw/intc/nios2_iic.o
>   CC      moxie-softmmu/hw/vfio/common.o
>   CC      nios2-softmmu/hw/net/vhost_net.o
>   CC      mips-softmmu/target/mips/helper.o
>   CC      moxie-softmmu/hw/vfio/platform.o
>   CC      nios2-softmmu/hw/net/rocker/qmp-norocker.o
>   CC      mips-softmmu/target/mips/cpu.o
>   CC      nios2-softmmu/hw/timer/altera_timer.o
>   CC      mips-softmmu/target/mips/gdbstub.o
>   CC      nios2-softmmu/hw/vfio/common.o
>   CC      moxie-softmmu/hw/vfio/spapr.o
>   CC      mips-softmmu/target/mips/msa_helper.o
>   CC      or1k-softmmu/tcg/tcg-op.o
>   CC      nios2-softmmu/hw/vfio/platform.o
>   CC      moxie-softmmu/hw/moxie/moxiesim.o
>   CC      moxie-softmmu/target/moxie/translate.o
>   CC      nios2-softmmu/hw/vfio/spapr.o
>   CC      nios2-softmmu/hw/nios2/boot.o
>   CC      moxie-softmmu/target/moxie/helper.o
>   CC      nios2-softmmu/hw/nios2/cpu_pic.o
>   CC      moxie-softmmu/target/moxie/machine.o
>   CC      nios2-softmmu/hw/nios2/10m50_devboard.o
>   CC      moxie-softmmu/target/moxie/cpu.o
>   CC      or1k-softmmu/tcg/optimize.o
>   CC      nios2-softmmu/target/nios2/translate.o
>   CC      moxie-softmmu/target/moxie/mmu.o
>   GEN     trace/generated-helpers.c
>   CC      moxie-softmmu/trace/control-target.o
>   CC      nios2-softmmu/target/nios2/op_helper.o
>   CC      moxie-softmmu/trace/generated-helpers.o
>   CC      or1k-softmmu/tcg/tcg-common.o
>   CC      nios2-softmmu/target/nios2/helper.o
>   CC      mips-softmmu/target/mips/mips-semi.o
>   LINK    moxie-softmmu/qemu-system-moxie
>   CC      or1k-softmmu/fpu/softfloat.o
>   CC      nios2-softmmu/target/nios2/cpu.o
>   CC      nios2-softmmu/target/nios2/mmu.o
>   CC      mips-softmmu/target/mips/machine.o
>   GEN     trace/generated-helpers.c
>   CC      nios2-softmmu/target/nios2/monitor.o
>   CC      mips-softmmu/trace/control-target.o
>   GEN     trace/generated-helpers.c
>   CC      nios2-softmmu/trace/control-target.o
>   CC      mips-softmmu/trace/generated-helpers.o
>   LINK    mips-softmmu/qemu-system-mips
>   CC      nios2-softmmu/trace/generated-helpers.o
>   GEN     ppc64-softmmu/hmp-commands.h
>   GEN     ppc64-softmmu/hmp-commands-info.h
>   GEN     ppc64-softmmu/config-target.h
>   LINK    nios2-softmmu/qemu-system-nios2
>   CC      ppc64-softmmu/exec.o
>   CC      or1k-softmmu/disas.o
>   CC      or1k-softmmu/tcg-runtime.o
>   CC      or1k-softmmu/hax-stub.o
>   CC      ppc64-softmmu/translate-all.o
>   CC      or1k-softmmu/kvm-stub.o
>   CC      or1k-softmmu/arch_init.o
>   CC      ppc64-softmmu/cpu-exec.o
>   CC      or1k-softmmu/cpus.o
>   CC      or1k-softmmu/monitor.o
>   CC      ppc64-softmmu/translate-common.o
>   GEN     ppcemb-softmmu/hmp-commands.h
>   GEN     ppcemb-softmmu/hmp-commands-info.h
>   GEN     ppcemb-softmmu/config-target.h
>   CC      ppcemb-softmmu/exec.o
>   CC      ppc64-softmmu/cpu-exec-common.o
>   CC      or1k-softmmu/gdbstub.o
>   CC      ppc64-softmmu/tcg/tcg.o
>   CC      ppc64-softmmu/tcg/tcg-op.o
>   CC      or1k-softmmu/balloon.o
>   CC      or1k-softmmu/ioport.o
>   CC      ppcemb-softmmu/translate-all.o
>   CC      or1k-softmmu/numa.o
>   CC      ppcemb-softmmu/cpu-exec.o
>   CC      or1k-softmmu/qtest.o
>   CC      ppc64-softmmu/tcg/optimize.o
>   CC      ppcemb-softmmu/translate-common.o
>   CC      or1k-softmmu/bootdevice.o
>   CC      ppcemb-softmmu/cpu-exec-common.o
>   CC      or1k-softmmu/memory.o
>   CC      or1k-softmmu/cputlb.o
>   CC      ppcemb-softmmu/tcg/tcg.o
>   CC      ppc64-softmmu/tcg/tcg-common.o
>   CC      ppc64-softmmu/fpu/softfloat.o
>   CC      ppc64-softmmu/disas.o
>   CC      or1k-softmmu/memory_mapping.o
>   CC      ppcemb-softmmu/tcg/tcg-op.o
>   CC      or1k-softmmu/dump.o
>   CC      or1k-softmmu/migration/ram.o
>   CC      ppc64-softmmu/tcg-runtime.o
>   CC      or1k-softmmu/migration/savevm.o
>   GEN     ppc64-softmmu/gdbstub-xml.c
>   CC      ppc64-softmmu/hax-stub.o
>   CC      ppc64-softmmu/kvm-stub.o
>   CC      or1k-softmmu/xen-common-stub.o
>   CC      ppc64-softmmu/libdecnumber/decContext.o
>   CC      ppcemb-softmmu/tcg/optimize.o
>   CC      or1k-softmmu/xen-hvm-stub.o
>   CC      ppc64-softmmu/libdecnumber/decNumber.o
>   GEN     ppc-softmmu/hmp-commands.h
>   CC      or1k-softmmu/hw/core/nmi.o
>   GEN     ppc-softmmu/hmp-commands-info.h
>   GEN     ppc-softmmu/config-target.h
>   CC      ppc-softmmu/exec.o
>   CC      or1k-softmmu/hw/core/generic-loader.o
>   CC      ppcemb-softmmu/tcg/tcg-common.o
>   CC      or1k-softmmu/hw/core/null-machine.o
>   CC      or1k-softmmu/hw/cpu/core.o
>   CC      ppcemb-softmmu/fpu/softfloat.o
>   CC      or1k-softmmu/hw/net/vhost_net.o
>   CC      ppc64-softmmu/libdecnumber/dpd/decimal32.o
>   CC      or1k-softmmu/hw/net/rocker/qmp-norocker.o
>   CC      or1k-softmmu/hw/vfio/common.o
>   CC      ppc64-softmmu/libdecnumber/dpd/decimal64.o
>   CC      ppc-softmmu/translate-all.o
>   CC      ppc64-softmmu/libdecnumber/dpd/decimal128.o
>   CC      ppc-softmmu/cpu-exec.o
>   CC      or1k-softmmu/hw/vfio/platform.o
>   CC      ppc64-softmmu/arch_init.o
>   CC      or1k-softmmu/hw/vfio/spapr.o
>   CC      ppc-softmmu/translate-common.o
>   CC      ppc64-softmmu/cpus.o
>   CC      ppc-softmmu/cpu-exec-common.o
>   CC      or1k-softmmu/hw/openrisc/pic_cpu.o
>   CC      ppc-softmmu/tcg/tcg.o
>   CC      or1k-softmmu/hw/openrisc/cputimer.o
>   CC      ppcemb-softmmu/disas.o
>   CC      or1k-softmmu/hw/openrisc/openrisc_sim.o
>   CC      ppc64-softmmu/monitor.o
>   CC      ppcemb-softmmu/tcg-runtime.o
>   CC      or1k-softmmu/target/openrisc/machine.o
>   GEN     ppcemb-softmmu/gdbstub-xml.c
>   CC      or1k-softmmu/target/openrisc/cpu.o
>   CC      ppcemb-softmmu/hax-stub.o
>   CC      ppcemb-softmmu/kvm-stub.o
>   CC      or1k-softmmu/target/openrisc/exception.o
>   CC      or1k-softmmu/target/openrisc/interrupt.o
>   CC      ppcemb-softmmu/libdecnumber/decContext.o
>   CC      ppc64-softmmu/gdbstub.o
>   CC      or1k-softmmu/target/openrisc/mmu.o
>   CC      ppc-softmmu/tcg/tcg-op.o
>   CC      or1k-softmmu/target/openrisc/translate.o
>   CC      ppcemb-softmmu/libdecnumber/decNumber.o
>   CC      ppc64-softmmu/balloon.o
>   CC      ppc64-softmmu/ioport.o
>   CC      or1k-softmmu/target/openrisc/exception_helper.o
>   CC      ppc64-softmmu/numa.o
>   CC      or1k-softmmu/target/openrisc/fpu_helper.o
>   CC      ppcemb-softmmu/libdecnumber/dpd/decimal32.o
>   CC      or1k-softmmu/target/openrisc/interrupt_helper.o
>   CC      ppc64-softmmu/qtest.o
>   CC      ppcemb-softmmu/libdecnumber/dpd/decimal64.o
>   CC      or1k-softmmu/target/openrisc/mmu_helper.o
>   CC      ppc64-softmmu/bootdevice.o
>   CC      ppcemb-softmmu/libdecnumber/dpd/decimal128.o
>   CC      ppc-softmmu/tcg/optimize.o
>   CC      or1k-softmmu/target/openrisc/sys_helper.o
>   CC      ppc64-softmmu/memory.o
>   CC      ppcemb-softmmu/arch_init.o
>   CC      or1k-softmmu/target/openrisc/gdbstub.o
>   CC      ppcemb-softmmu/cpus.o
>   GEN     trace/generated-helpers.c
>   CC      or1k-softmmu/trace/control-target.o
>   CC      ppcemb-softmmu/monitor.o
>   CC      ppc-softmmu/tcg/tcg-common.o
>   CC      or1k-softmmu/trace/generated-helpers.o
>   CC      ppc-softmmu/fpu/softfloat.o
>   CC      ppc64-softmmu/cputlb.o
>   LINK    or1k-softmmu/qemu-system-or1k
>   CC      ppcemb-softmmu/gdbstub.o
>   CC      ppc-softmmu/disas.o
>   CC      ppc64-softmmu/memory_mapping.o
>   CC      ppcemb-softmmu/balloon.o
>   CC      ppcemb-softmmu/ioport.o
>   CC      ppc-softmmu/tcg-runtime.o
>   CC      ppc64-softmmu/dump.o
>   GEN     ppc-softmmu/gdbstub-xml.c
>   CC      ppcemb-softmmu/numa.o
>   GEN     s390x-softmmu/hmp-commands.h
>   GEN     s390x-softmmu/hmp-commands-info.h
>   CC      ppc64-softmmu/migration/ram.o
>   CC      s390x-softmmu/gen-features
>   CC      ppc-softmmu/hax-stub.o
>   GEN     s390x-softmmu/config-target.h
>   GEN     s390x-softmmu/gen-features.h
>   CC      s390x-softmmu/exec.o
>   CC      ppcemb-softmmu/qtest.o
>   CC      ppc-softmmu/kvm-stub.o
>   CC      ppcemb-softmmu/bootdevice.o
>   CC      ppc-softmmu/libdecnumber/decContext.o
>   CC      ppc64-softmmu/migration/savevm.o
>   CC      ppc-softmmu/libdecnumber/decNumber.o
>   CC      ppcemb-softmmu/memory.o
>   CC      s390x-softmmu/translate-all.o
>   CC      ppc64-softmmu/xen-common-stub.o
>   CC      ppc64-softmmu/xen-hvm-stub.o
>   CC      s390x-softmmu/cpu-exec.o
>   CC      ppc-softmmu/libdecnumber/dpd/decimal32.o
>   CC      ppc64-softmmu/hw/9pfs/virtio-9p-device.o
>   CC      ppcemb-softmmu/cputlb.o
>   CC      ppc-softmmu/libdecnumber/dpd/decimal64.o
>   CC      s390x-softmmu/translate-common.o
>   CC      ppc64-softmmu/hw/block/virtio-blk.o
>   CC      s390x-softmmu/cpu-exec-common.o
>   CC      s390x-softmmu/tcg/tcg.o
>   CC      ppc-softmmu/libdecnumber/dpd/decimal128.o
>   CC      ppc64-softmmu/hw/block/dataplane/virtio-blk.o
>   CC      ppc-softmmu/arch_init.o
>   CC      ppc-softmmu/cpus.o
>   CC      ppc64-softmmu/hw/char/spapr_vty.o
>   CC      ppc64-softmmu/hw/char/virtio-serial-bus.o
>   CC      ppc-softmmu/monitor.o
>   CC      ppcemb-softmmu/memory_mapping.o
>   CC      ppc64-softmmu/hw/core/nmi.o
>   CC      ppcemb-softmmu/dump.o
>   CC      ppc64-softmmu/hw/core/generic-loader.o
>   CC      s390x-softmmu/tcg/tcg-op.o
>   CC      ppc-softmmu/gdbstub.o
>   CC      ppc64-softmmu/hw/core/null-machine.o
>   CC      ppcemb-softmmu/migration/ram.o
>   CC      ppc-softmmu/balloon.o
>   CC      ppc64-softmmu/hw/cpu/core.o
>   CC      ppc-softmmu/ioport.o
>   CC      ppc64-softmmu/hw/display/vga.o
>   CC      ppcemb-softmmu/migration/savevm.o
>   CC      ppc-softmmu/numa.o
>   CC      ppc-softmmu/qtest.o
>   CC      ppc-softmmu/bootdevice.o
>   CC      ppc-softmmu/memory.o
>   CC      ppc64-softmmu/hw/display/virtio-gpu.o
>   CC      ppcemb-softmmu/xen-common-stub.o
>   CC      s390x-softmmu/tcg/optimize.o
>   CC      ppcemb-softmmu/xen-hvm-stub.o
>   CC      ppcemb-softmmu/hw/9pfs/virtio-9p-device.o
>   CC      ppc64-softmmu/hw/display/virtio-gpu-3d.o
>   CC      ppcemb-softmmu/hw/block/virtio-blk.o
>   CC      ppc-softmmu/cputlb.o
>   CC      s390x-softmmu/tcg/tcg-common.o
>   CC      s390x-softmmu/fpu/softfloat.o
>   CC      ppc64-softmmu/hw/display/virtio-gpu-pci.o
>   CC      ppcemb-softmmu/hw/block/dataplane/virtio-blk.o
>   CC      ppcemb-softmmu/hw/char/virtio-serial-bus.o
>   CC      ppc64-softmmu/hw/display/virtio-vga.o
>   CC      ppc-softmmu/memory_mapping.o
>   CC      ppc-softmmu/dump.o
>   CC      ppcemb-softmmu/hw/core/nmi.o
>   CC      ppc64-softmmu/hw/intc/xics.o
>   CC      ppcemb-softmmu/hw/core/generic-loader.o
>   CC      ppc-softmmu/migration/ram.o
>   CC      ppc64-softmmu/hw/intc/xics_spapr.o
>   CC      ppcemb-softmmu/hw/core/null-machine.o
>   CC      ppc64-softmmu/hw/misc/ivshmem.o
>   CC      ppcemb-softmmu/hw/cpu/core.o
>   CC      s390x-softmmu/disas.o
>   CC      ppc64-softmmu/hw/misc/edu.o
>   CC      ppc-softmmu/migration/savevm.o
>   CC      ppcemb-softmmu/hw/display/vga.o
>   CC      s390x-softmmu/tcg-runtime.o
>   CC      ppc64-softmmu/hw/net/spapr_llan.o
>   GEN     s390x-softmmu/gdbstub-xml.c
>   CC      ppc64-softmmu/hw/net/xilinx_ethlite.o
>   CC      ppc64-softmmu/hw/net/virtio-net.o
>   CC      ppc-softmmu/xen-common-stub.o
>   CC      ppcemb-softmmu/hw/display/virtio-gpu.o
>   CC      s390x-softmmu/hax-stub.o
>   CC      ppc-softmmu/xen-hvm-stub.o
>   CC      s390x-softmmu/arch_init.o
>   CC      ppc-softmmu/hw/9pfs/virtio-9p-device.o
>   CC      ppc64-softmmu/hw/net/vhost_net.o
>   CC      s390x-softmmu/cpus.o
>   CC      ppcemb-softmmu/hw/display/virtio-gpu-3d.o
>   CC      ppc-softmmu/hw/block/virtio-blk.o
>   CC      ppc64-softmmu/hw/net/fsl_etsec/etsec.o
>   CC      s390x-softmmu/monitor.o
>   CC      ppc64-softmmu/hw/net/fsl_etsec/registers.o
>   CC      ppcemb-softmmu/hw/display/virtio-gpu-pci.o
>   CC      ppc-softmmu/hw/block/dataplane/virtio-blk.o
>   CC      ppc64-softmmu/hw/net/fsl_etsec/rings.o
>   CC      ppc-softmmu/hw/char/virtio-serial-bus.o
>   CC      ppcemb-softmmu/hw/misc/ivshmem.o
>   CC      ppc64-softmmu/hw/net/fsl_etsec/miim.o
>   CC      ppc-softmmu/hw/core/nmi.o
>   CC      ppc64-softmmu/hw/nvram/spapr_nvram.o
>   CC      ppc-softmmu/hw/core/generic-loader.o
>   CC      ppcemb-softmmu/hw/misc/edu.o
>   CC      s390x-softmmu/gdbstub.o
>   CC      ppc-softmmu/hw/core/null-machine.o
>   CC      ppc64-softmmu/hw/scsi/spapr_vscsi.o
>   CC      ppcemb-softmmu/hw/net/xilinx_ethlite.o
>   CC      ppc-softmmu/hw/cpu/core.o
>   CC      ppcemb-softmmu/hw/net/virtio-net.o
>   CC      s390x-softmmu/balloon.o
>   CC      ppc-softmmu/hw/display/vga.o
>   CC      ppc64-softmmu/hw/scsi/virtio-scsi.o
>   CC      s390x-softmmu/ioport.o
>   CC      ppcemb-softmmu/hw/net/vhost_net.o
>   CC      ppcemb-softmmu/hw/scsi/virtio-scsi.o
>   CC      s390x-softmmu/numa.o
>   CC      ppc64-softmmu/hw/scsi/virtio-scsi-dataplane.o
>   CC      ppc64-softmmu/hw/scsi/vhost-scsi.o
>   CC      ppc-softmmu/hw/display/virtio-gpu.o
>   CC      s390x-softmmu/qtest.o
>   CC      ppcemb-softmmu/hw/scsi/virtio-scsi-dataplane.o
>   CC      ppc64-softmmu/hw/timer/mc146818rtc.o
>   CC      s390x-softmmu/bootdevice.o
>   CC      ppcemb-softmmu/hw/scsi/vhost-scsi.o
>   CC      s390x-softmmu/kvm-all.o
>   CC      ppc64-softmmu/hw/vfio/common.o
>   CC      ppc-softmmu/hw/display/virtio-gpu-3d.o
>   CC      ppcemb-softmmu/hw/vfio/common.o
>   CC      ppc64-softmmu/hw/vfio/pci.o
>   CC      ppc-softmmu/hw/display/virtio-gpu-pci.o
>   CC      s390x-softmmu/memory.o
>   CC      ppcemb-softmmu/hw/vfio/pci.o
>   CC      ppc-softmmu/hw/misc/ivshmem.o
>   CC      ppc64-softmmu/hw/vfio/pci-quirks.o
>   CC      ppcemb-softmmu/hw/vfio/pci-quirks.o
>   CC      ppc-softmmu/hw/misc/edu.o
>   CC      s390x-softmmu/cputlb.o
>   CC      ppc64-softmmu/hw/vfio/platform.o
>   CC      ppc-softmmu/hw/net/xilinx_ethlite.o
>   CC      ppcemb-softmmu/hw/vfio/platform.o
>   CC      ppc64-softmmu/hw/vfio/spapr.o
>   CC      ppc-softmmu/hw/net/virtio-net.o
>   CC      ppcemb-softmmu/hw/vfio/spapr.o
>   CC      ppc64-softmmu/hw/virtio/virtio.o
>   CC      ppcemb-softmmu/hw/virtio/virtio.o
>   CC      ppc-softmmu/hw/net/vhost_net.o
>   CC      s390x-softmmu/memory_mapping.o
>   CC      s390x-softmmu/dump.o
>   CC      ppc-softmmu/hw/net/fsl_etsec/etsec.o
>   CC      ppc-softmmu/hw/net/fsl_etsec/registers.o
>   CC      ppcemb-softmmu/hw/virtio/virtio-balloon.o
>   CC      ppc-softmmu/hw/net/fsl_etsec/rings.o
>   CC      ppc64-softmmu/hw/virtio/virtio-balloon.o
>   CC      s390x-softmmu/migration/ram.o
>   CC      ppcemb-softmmu/hw/virtio/vhost.o
>   CC      ppc-softmmu/hw/net/fsl_etsec/miim.o
>   CC      ppc-softmmu/hw/scsi/virtio-scsi.o
>   CC      ppc64-softmmu/hw/virtio/vhost.o
>   CC      ppcemb-softmmu/hw/virtio/vhost-backend.o
>   CC      s390x-softmmu/migration/savevm.o
>   CC      ppc-softmmu/hw/scsi/virtio-scsi-dataplane.o
>   CC      ppc64-softmmu/hw/virtio/vhost-backend.o
>   CC      ppcemb-softmmu/hw/virtio/vhost-user.o
>   CC      ppc-softmmu/hw/scsi/vhost-scsi.o
>   CC      ppc64-softmmu/hw/virtio/vhost-user.o
>   CC      ppcemb-softmmu/hw/virtio/vhost-vsock.o
>   CC      ppc-softmmu/hw/timer/mc146818rtc.o
>   CC      s390x-softmmu/xen-common-stub.o
>   CC      ppc64-softmmu/hw/virtio/vhost-vsock.o
>   CC      ppcemb-softmmu/hw/virtio/virtio-crypto.o
>   CC      s390x-softmmu/xen-hvm-stub.o
>   CC      ppc-softmmu/hw/vfio/common.o
>   CC      ppcemb-softmmu/hw/virtio/virtio-crypto-pci.o
>   CC      ppc64-softmmu/hw/virtio/virtio-crypto.o
>   CC      s390x-softmmu/hw/9pfs/virtio-9p-device.o
>   CC      ppcemb-softmmu/hw/ppc/ppc.o
>   CC      s390x-softmmu/hw/block/virtio-blk.o
>   CC      ppc-softmmu/hw/vfio/pci.o
>   CC      ppc64-softmmu/hw/virtio/virtio-crypto-pci.o
>   CC      ppcemb-softmmu/hw/ppc/ppc_booke.o
>   CC      s390x-softmmu/hw/block/dataplane/virtio-blk.o
>   CC      ppcemb-softmmu/hw/ppc/fdt.o
>   CC      ppc64-softmmu/hw/ppc/ppc.o
>   CC      s390x-softmmu/hw/char/virtio-serial-bus.o
>   CC      ppcemb-softmmu/hw/ppc/ppc405_boards.o
>   CC      ppc-softmmu/hw/vfio/pci-quirks.o
>   CC      ppc64-softmmu/hw/ppc/ppc_booke.o
>   CC      ppcemb-softmmu/hw/ppc/ppc4xx_devs.o
>   CC      s390x-softmmu/hw/core/nmi.o
>   CC      ppc64-softmmu/hw/ppc/fdt.o
>   CC      ppc-softmmu/hw/vfio/platform.o
>   CC      ppc64-softmmu/hw/ppc/spapr.o
>   CC      ppcemb-softmmu/hw/ppc/ppc405_uc.o
>   CC      s390x-softmmu/hw/core/generic-loader.o
>   CC      ppc-softmmu/hw/vfio/spapr.o
>   CC      ppcemb-softmmu/hw/ppc/ppc440_bamboo.o
>   CC      ppc-softmmu/hw/virtio/virtio.o
>   CC      s390x-softmmu/hw/core/null-machine.o
>   CC      ppcemb-softmmu/hw/ppc/ppc4xx_pci.o
>   CC      s390x-softmmu/hw/cpu/core.o
>   CC      ppc64-softmmu/hw/ppc/spapr_vio.o
>   CC      ppcemb-softmmu/hw/ppc/virtex_ml507.o
>   CC      s390x-softmmu/hw/display/virtio-gpu.o
>   CC      ppcemb-softmmu/target/ppc/cpu-models.o
>   CC      ppc-softmmu/hw/virtio/virtio-balloon.o
>   CC      ppc64-softmmu/hw/ppc/spapr_events.o
>   CC      s390x-softmmu/hw/display/virtio-gpu-3d.o
>   CC      ppc-softmmu/hw/virtio/vhost.o
>   CC      ppc64-softmmu/hw/ppc/spapr_hcall.o
>   CC      s390x-softmmu/hw/display/virtio-gpu-pci.o
>   CC      ppcemb-softmmu/target/ppc/cpu.o
>   CC      ppc-softmmu/hw/virtio/vhost-backend.o
>   CC      ppcemb-softmmu/target/ppc/translate.o
>   CC      ppc64-softmmu/hw/ppc/spapr_iommu.o
>   CC      s390x-softmmu/hw/intc/s390_flic.o
>   CC      ppc-softmmu/hw/virtio/vhost-user.o
>   CC      s390x-softmmu/hw/intc/s390_flic_kvm.o
>   CC      ppc64-softmmu/hw/ppc/spapr_rtas.o
>   CC      ppc-softmmu/hw/virtio/vhost-vsock.o
>   CC      ppc64-softmmu/hw/ppc/spapr_pci.o
>   CC      s390x-softmmu/hw/net/virtio-net.o
>   CC      ppc-softmmu/hw/virtio/virtio-crypto.o
>   CC      ppc-softmmu/hw/virtio/virtio-crypto-pci.o
>   CC      ppc64-softmmu/hw/ppc/spapr_rtc.o
>   CC      s390x-softmmu/hw/net/vhost_net.o
>   CC      ppc-softmmu/hw/ppc/ppc.o
>   CC      ppc64-softmmu/hw/ppc/spapr_drc.o
>   CC      s390x-softmmu/hw/net/rocker/qmp-norocker.o
>   CC      s390x-softmmu/hw/scsi/virtio-scsi.o
>   CC      ppc64-softmmu/hw/ppc/spapr_rng.o
>   CC      ppc-softmmu/hw/ppc/ppc_booke.o
>   CC      ppc64-softmmu/hw/ppc/spapr_cpu_core.o
>   CC      s390x-softmmu/hw/scsi/virtio-scsi-dataplane.o
>   CC      ppc-softmmu/hw/ppc/fdt.o
>   CC      ppc64-softmmu/hw/ppc/spapr_ovec.o
>   CC      s390x-softmmu/hw/scsi/vhost-scsi.o
>   CC      ppc-softmmu/hw/ppc/ppc405_boards.o
>   CC      ppc64-softmmu/hw/ppc/pnv.o
>   CC      s390x-softmmu/hw/vfio/common.o
>   CC      ppc-softmmu/hw/ppc/ppc4xx_devs.o
>   CC      ppc64-softmmu/hw/ppc/pnv_xscom.o
>   CC      s390x-softmmu/hw/vfio/pci.o
>   CC      ppc-softmmu/hw/ppc/ppc405_uc.o
>   CC      ppc64-softmmu/hw/ppc/pnv_core.o
>   CC      ppc64-softmmu/hw/ppc/pnv_lpc.o
>   CC      ppc64-softmmu/hw/ppc/spapr_pci_vfio.o
>   CC      ppc-softmmu/hw/ppc/ppc440_bamboo.o
>   CC      ppc64-softmmu/hw/ppc/spapr_rtas_ddw.o
>   CC      s390x-softmmu/hw/vfio/pci-quirks.o
>   CC      ppc-softmmu/hw/ppc/ppc4xx_pci.o
>   CC      ppc64-softmmu/hw/ppc/ppc405_boards.o
>   CC      ppc64-softmmu/hw/ppc/ppc4xx_devs.o
>   CC      s390x-softmmu/hw/vfio/platform.o
>   CC      ppc-softmmu/hw/ppc/prep.o
>   CC      ppc64-softmmu/hw/ppc/ppc405_uc.o
>   CC      s390x-softmmu/hw/vfio/spapr.o
>   CC      ppc-softmmu/hw/ppc/prep_systemio.o
>   CC      ppc64-softmmu/hw/ppc/ppc440_bamboo.o
>   CC      s390x-softmmu/hw/virtio/virtio.o
>   CC      ppc-softmmu/hw/ppc/rs6000_mc.o
>   CC      ppc64-softmmu/hw/ppc/ppc4xx_pci.o
>   CC      ppc-softmmu/hw/ppc/mac_oldworld.o
>   CC      s390x-softmmu/hw/virtio/virtio-balloon.o
>   CC      ppc64-softmmu/hw/ppc/prep.o
>   CC      ppc-softmmu/hw/ppc/mac_newworld.o
>   CC      s390x-softmmu/hw/virtio/vhost.o
>   CC      ppc64-softmmu/hw/ppc/prep_systemio.o
>   CC      ppc-softmmu/hw/ppc/e500.o
>   CC      ppc64-softmmu/hw/ppc/rs6000_mc.o
>   CC      s390x-softmmu/hw/virtio/vhost-backend.o
>   CC      ppc64-softmmu/hw/ppc/mac_oldworld.o
>   CC      ppc-softmmu/hw/ppc/mpc8544ds.o
>   CC      ppc64-softmmu/hw/ppc/mac_newworld.o
>   CC      s390x-softmmu/hw/virtio/vhost-user.o
>   CC      ppc-softmmu/hw/ppc/e500plat.o
>   CC      ppc64-softmmu/hw/ppc/e500.o
>   CC      s390x-softmmu/hw/virtio/vhost-vsock.o
>   CC      ppc-softmmu/hw/ppc/mpc8544_guts.o
>   CC      s390x-softmmu/hw/virtio/virtio-crypto.o
>   CC      ppc64-softmmu/hw/ppc/mpc8544ds.o
>   CC      ppc-softmmu/hw/ppc/ppce500_spin.o
>   CC      ppc64-softmmu/hw/ppc/e500plat.o
>   CC      ppc-softmmu/hw/ppc/virtex_ml507.o
>   CC      s390x-softmmu/hw/virtio/virtio-crypto-pci.o
>   CC      ppc64-softmmu/hw/ppc/mpc8544_guts.o
>   CC      ppc-softmmu/target/ppc/cpu-models.o
>   CC      ppc64-softmmu/hw/ppc/ppce500_spin.o
>   CC      s390x-softmmu/hw/s390x/s390-virtio.o
>   CC      ppc64-softmmu/hw/ppc/virtex_ml507.o
>   CC      ppcemb-softmmu/target/ppc/machine.o
>   CC      s390x-softmmu/hw/s390x/s390-virtio-hcall.o
>   CC      ppc64-softmmu/target/ppc/cpu-models.o
>   CC      ppcemb-softmmu/target/ppc/mmu_helper.o
>   CC      s390x-softmmu/hw/s390x/sclp.o
>   CC      ppc-softmmu/target/ppc/cpu.o
>   CC      ppc-softmmu/target/ppc/translate.o
>   CC      s390x-softmmu/hw/s390x/event-facility.o
>   CC      ppcemb-softmmu/target/ppc/mmu-hash32.o
>   CC      ppc64-softmmu/target/ppc/cpu.o
>   CC      s390x-softmmu/hw/s390x/sclpquiesce.o
>   CC      ppcemb-softmmu/target/ppc/monitor.o
>   CC      ppc64-softmmu/target/ppc/translate.o
>   CC      s390x-softmmu/hw/s390x/sclpcpu.o
>   CC      s390x-softmmu/hw/s390x/ipl.o
>   CC      ppcemb-softmmu/target/ppc/arch_dump.o
>   CC      s390x-softmmu/hw/s390x/css.o
>   CC      ppcemb-softmmu/target/ppc/kvm-stub.o
>   CC      ppcemb-softmmu/target/ppc/dfp_helper.o
>   CC      s390x-softmmu/hw/s390x/s390-virtio-ccw.o
>   CC      ppcemb-softmmu/target/ppc/excp_helper.o
>   CC      s390x-softmmu/hw/s390x/virtio-ccw.o
>   CC      ppcemb-softmmu/target/ppc/fpu_helper.o
>   CC      s390x-softmmu/hw/s390x/css-bridge.o
>   CC      s390x-softmmu/hw/s390x/ccw-device.o
>   CC      s390x-softmmu/hw/s390x/s390-pci-bus.o
>   CC      s390x-softmmu/hw/s390x/s390-pci-inst.o
>   CC      s390x-softmmu/hw/s390x/s390-skeys.o
>   CC      s390x-softmmu/hw/s390x/s390-skeys-kvm.o
>   CC      s390x-softmmu/target/s390x/translate.o
>   CC      ppcemb-softmmu/target/ppc/int_helper.o
>   CC      ppcemb-softmmu/target/ppc/timebase_helper.o
>   CC      ppcemb-softmmu/target/ppc/misc_helper.o
>   CC      ppcemb-softmmu/target/ppc/mem_helper.o
>   CC      ppcemb-softmmu/target/ppc/gdbstub.o
>   GEN     trace/generated-helpers.c
>   CC      ppcemb-softmmu/trace/control-target.o
>   CC      ppcemb-softmmu/gdbstub-xml.o
>   CC      s390x-softmmu/target/s390x/helper.o
>   CC      ppcemb-softmmu/trace/generated-helpers.o
>   CC      s390x-softmmu/target/s390x/cpu.o
>   LINK    ppcemb-softmmu/qemu-system-ppcemb
>   CC      s390x-softmmu/target/s390x/interrupt.o
>   CC      ppc-softmmu/target/ppc/machine.o
>   CC      s390x-softmmu/target/s390x/int_helper.o
>   CC      s390x-softmmu/target/s390x/fpu_helper.o
>   CC      ppc-softmmu/target/ppc/mmu_helper.o
>   CC      s390x-softmmu/target/s390x/cc_helper.o
>   CC      ppc-softmmu/target/ppc/mmu-hash32.o
>   CC      s390x-softmmu/target/s390x/mem_helper.o
>   CC      ppc64-softmmu/target/ppc/machine.o
>   CC      ppc-softmmu/target/ppc/monitor.o
>   CC      ppc-softmmu/target/ppc/arch_dump.o
>   CC      ppc64-softmmu/target/ppc/mmu_helper.o
>   CC      ppc-softmmu/target/ppc/kvm-stub.o
>   CC      s390x-softmmu/target/s390x/misc_helper.o
>   CC      ppc-softmmu/target/ppc/dfp_helper.o
>   CC      s390x-softmmu/target/s390x/gdbstub.o
>   CC      ppc64-softmmu/target/ppc/mmu-hash32.o
>   CC      ppc-softmmu/target/ppc/excp_helper.o
>   CC      ppc64-softmmu/target/ppc/monitor.o
>   CC      s390x-softmmu/target/s390x/cpu_models.o
>   CC      ppc64-softmmu/target/ppc/arch_dump.o
>   CC      ppc-softmmu/target/ppc/fpu_helper.o
>   CC      ppc64-softmmu/target/ppc/mmu-hash64.o
>   CC      s390x-softmmu/target/s390x/cpu_features.o
>   GEN     sh4eb-softmmu/hmp-commands.h
>   GEN     sh4eb-softmmu/hmp-commands-info.h
>   GEN     sh4eb-softmmu/config-target.h
>   CC      sh4eb-softmmu/exec.o
>   CC      ppc64-softmmu/target/ppc/compat.o
>   CC      s390x-softmmu/target/s390x/machine.o
>   CC      ppc64-softmmu/target/ppc/kvm-stub.o
>   CC      s390x-softmmu/target/s390x/ioinst.o
>   CC      ppc64-softmmu/target/ppc/dfp_helper.o
>   CC      s390x-softmmu/target/s390x/arch_dump.o
>   CC      ppc64-softmmu/target/ppc/excp_helper.o
>   CC      s390x-softmmu/target/s390x/mmu_helper.o
>   CC      sh4eb-softmmu/translate-all.o
>   CC      ppc64-softmmu/target/ppc/fpu_helper.o
>   CC      s390x-softmmu/target/s390x/kvm.o
>   CC      sh4eb-softmmu/cpu-exec.o
>   CC      sh4eb-softmmu/translate-common.o
>   GEN     trace/generated-helpers.c
>   CC      s390x-softmmu/trace/control-target.o
>   CC      sh4eb-softmmu/cpu-exec-common.o
>   CC      ppc-softmmu/target/ppc/int_helper.o
>   CC      s390x-softmmu/gdbstub-xml.o
>   CC      sh4eb-softmmu/tcg/tcg.o
>   CC      s390x-softmmu/trace/generated-helpers.o
>   LINK    s390x-softmmu/qemu-system-s390x
>   CC      ppc-softmmu/target/ppc/timebase_helper.o
>   CC      ppc-softmmu/target/ppc/misc_helper.o
>   CC      sh4eb-softmmu/tcg/tcg-op.o
>   CC      ppc-softmmu/target/ppc/mem_helper.o
>   CC      sh4eb-softmmu/tcg/optimize.o
>   CC      ppc-softmmu/target/ppc/gdbstub.o
>   CC      ppc64-softmmu/target/ppc/int_helper.o
>   GEN     trace/generated-helpers.c
>   CC      ppc-softmmu/trace/control-target.o
>   CC      sh4eb-softmmu/tcg/tcg-common.o
>   CC      ppc-softmmu/gdbstub-xml.o
>   CC      ppc64-softmmu/target/ppc/timebase_helper.o
>   CC      ppc-softmmu/trace/generated-helpers.o
>   CC      sh4eb-softmmu/fpu/softfloat.o
>   LINK    ppc-softmmu/qemu-system-ppc
>   GEN     sh4-softmmu/hmp-commands.h
>   GEN     sh4-softmmu/hmp-commands-info.h
>   GEN     sh4-softmmu/config-target.h
>   CC      sh4-softmmu/exec.o
>   CC      ppc64-softmmu/target/ppc/misc_helper.o
>   CC      ppc64-softmmu/target/ppc/mem_helper.o
>   CC      ppc64-softmmu/target/ppc/gdbstub.o
>   CC      sh4-softmmu/translate-all.o
>   GEN     trace/generated-helpers.c
>   CC      ppc64-softmmu/trace/control-target.o
>   CC      sh4-softmmu/cpu-exec.o
>   CC      ppc64-softmmu/gdbstub-xml.o
>   CC      sh4eb-softmmu/disas.o
>   GEN     sparc64-softmmu/hmp-commands.h
>   CC      ppc64-softmmu/trace/generated-helpers.o
>   GEN     sparc64-softmmu/hmp-commands-info.h
>   CC      sh4-softmmu/translate-common.o
>   GEN     sparc64-softmmu/config-target.h
>   CC      sparc64-softmmu/exec.o
>   CC      sh4eb-softmmu/tcg-runtime.o
>   LINK    ppc64-softmmu/qemu-system-ppc64
>   CC      sh4-softmmu/cpu-exec-common.o
>   CC      sh4eb-softmmu/hax-stub.o
>   CC      sh4-softmmu/tcg/tcg.o
>   CC      sh4eb-softmmu/kvm-stub.o
>   CC      sh4eb-softmmu/arch_init.o
>   CC      sh4eb-softmmu/cpus.o
>   CC      sparc64-softmmu/translate-all.o
>   CC      sh4eb-softmmu/monitor.o
>   CC      sparc64-softmmu/cpu-exec.o
>   CC      sh4eb-softmmu/gdbstub.o
>   CC      sh4-softmmu/tcg/tcg-op.o
>   CC      sparc64-softmmu/translate-common.o
>   CC      sh4eb-softmmu/balloon.o
>   CC      sh4eb-softmmu/ioport.o
>   CC      sparc64-softmmu/cpu-exec-common.o
>   CC      sh4eb-softmmu/numa.o
>   CC      sparc64-softmmu/tcg/tcg.o
>   CC      sh4eb-softmmu/qtest.o
>   GEN     sparc-softmmu/hmp-commands.h
>   CC      sh4eb-softmmu/bootdevice.o
>   GEN     sparc-softmmu/hmp-commands-info.h
>   GEN     sparc-softmmu/config-target.h
>   CC      sh4eb-softmmu/memory.o
>   CC      sparc-softmmu/exec.o
>   CC      sh4-softmmu/tcg/optimize.o
>   CC      sparc64-softmmu/tcg/tcg-op.o
>   CC      sh4eb-softmmu/cputlb.o
>   CC      sh4-softmmu/tcg/tcg-common.o
>   CC      sh4-softmmu/fpu/softfloat.o
>   CC      sparc-softmmu/translate-all.o
>   CC      sparc-softmmu/cpu-exec.o
>   CC      sh4eb-softmmu/memory_mapping.o
>   CC      sparc64-softmmu/tcg/optimize.o
>   CC      sparc-softmmu/translate-common.o
>   CC      sh4eb-softmmu/dump.o
>   CC      sparc-softmmu/cpu-exec-common.o
>   CC      sparc64-softmmu/tcg/tcg-common.o
>   CC      sparc-softmmu/tcg/tcg.o
>   CC      sh4eb-softmmu/migration/ram.o
>   CC      sparc64-softmmu/fpu/softfloat.o
>   CC      sh4-softmmu/disas.o
>   CC      sh4-softmmu/tcg-runtime.o
>   CC      sh4eb-softmmu/migration/savevm.o
>   CC      sh4-softmmu/hax-stub.o
>   CC      sparc-softmmu/tcg/tcg-op.o
>   CC      sh4-softmmu/kvm-stub.o
>   CC      sh4-softmmu/arch_init.o
>   CC      sh4-softmmu/cpus.o
>   CC      sh4eb-softmmu/xen-common-stub.o
>   CC      sh4eb-softmmu/xen-hvm-stub.o
>   CC      sh4-softmmu/monitor.o
>   CC      sparc64-softmmu/disas.o
>   CC      sh4eb-softmmu/hw/9pfs/virtio-9p-device.o
>   CC      sparc64-softmmu/tcg-runtime.o
>   CC      sparc64-softmmu/hax-stub.o
>   CC      sh4eb-softmmu/hw/block/tc58128.o
>   CC      sparc64-softmmu/kvm-stub.o
>   CC      sparc-softmmu/tcg/optimize.o
>   CC      sh4eb-softmmu/hw/block/virtio-blk.o
>   CC      sparc64-softmmu/arch_init.o
>   CC      sh4-softmmu/gdbstub.o
>   CC      sparc64-softmmu/cpus.o
>   CC      sparc-softmmu/tcg/tcg-common.o
>   CC      sh4eb-softmmu/hw/block/dataplane/virtio-blk.o
>   CC      sparc-softmmu/fpu/softfloat.o
>   CC      sh4-softmmu/balloon.o
>   CC      sparc64-softmmu/monitor.o
>   CC      sh4eb-softmmu/hw/char/sh_serial.o
>   CC      sh4-softmmu/ioport.o
>   CC      sh4-softmmu/numa.o
>   CC      sh4eb-softmmu/hw/char/virtio-serial-bus.o
>   CC      sh4-softmmu/qtest.o
>   CC      sh4eb-softmmu/hw/core/nmi.o
>   CC      sh4-softmmu/bootdevice.o
>   CC      sh4eb-softmmu/hw/core/generic-loader.o
>   CC      sparc64-softmmu/gdbstub.o
>   CC      sh4eb-softmmu/hw/core/null-machine.o
>   CC      sh4-softmmu/memory.o
>   CC      sparc-softmmu/disas.o
>   CC      sh4eb-softmmu/hw/cpu/core.o
>   CC      sparc-softmmu/tcg-runtime.o
>   CC      sparc64-softmmu/balloon.o
>   CC      sh4eb-softmmu/hw/display/sm501.o
>   CC      sparc64-softmmu/ioport.o
>   CC      sparc-softmmu/hax-stub.o
>   CC      sparc-softmmu/kvm-stub.o
>   CC      sparc64-softmmu/numa.o
>   CC      sh4-softmmu/cputlb.o
>   CC      sparc-softmmu/arch_init.o
>   CC      sh4eb-softmmu/hw/display/vga.o
>   CC      sparc64-softmmu/qtest.o
>   CC      sparc-softmmu/cpus.o
>   CC      sparc64-softmmu/bootdevice.o
>   CC      sparc-softmmu/monitor.o
>   CC      sparc64-softmmu/memory.o
>   CC      sh4-softmmu/memory_mapping.o
>   CC      sh4eb-softmmu/hw/display/virtio-gpu.o
>   CC      sh4-softmmu/dump.o
>   CC      sparc64-softmmu/cputlb.o
>   CC      sh4-softmmu/migration/ram.o
>   CC      sh4eb-softmmu/hw/display/virtio-gpu-3d.o
>   CC      sparc-softmmu/gdbstub.o
>   CC      sh4-softmmu/migration/savevm.o
>   CC      sparc-softmmu/balloon.o
>   CC      sh4eb-softmmu/hw/display/virtio-gpu-pci.o
>   CC      sparc-softmmu/ioport.o
>   CC      sparc-softmmu/numa.o
>   CC      sparc64-softmmu/memory_mapping.o
>   CC      sh4eb-softmmu/hw/intc/sh_intc.o
>   CC      sh4-softmmu/xen-common-stub.o
>   CC      sparc-softmmu/qtest.o
>   CC      sparc64-softmmu/dump.o
>   CC      sh4eb-softmmu/hw/misc/ivshmem.o
>   CC      sh4-softmmu/xen-hvm-stub.o
>   CC      sparc-softmmu/bootdevice.o
>   CC      sh4-softmmu/hw/9pfs/virtio-9p-device.o
>   CC      sh4eb-softmmu/hw/misc/edu.o
>   CC      sparc64-softmmu/migration/ram.o
>   CC      sparc-softmmu/memory.o
>   CC      sh4-softmmu/hw/block/tc58128.o
>   CC      sh4eb-softmmu/hw/net/virtio-net.o
>   CC      sh4-softmmu/hw/block/virtio-blk.o
>   CC      sparc64-softmmu/migration/savevm.o
>   CC      sh4-softmmu/hw/block/dataplane/virtio-blk.o
>   CC      sh4eb-softmmu/hw/net/vhost_net.o
>   CC      sparc-softmmu/cputlb.o
>   CC      sh4eb-softmmu/hw/scsi/virtio-scsi.o
>   CC      sh4-softmmu/hw/char/sh_serial.o
>   CC      sparc64-softmmu/xen-common-stub.o
>   CC      sh4-softmmu/hw/char/virtio-serial-bus.o
>   CC      sparc64-softmmu/xen-hvm-stub.o
>   CC      sh4eb-softmmu/hw/scsi/virtio-scsi-dataplane.o
>   CC      sparc64-softmmu/hw/9pfs/virtio-9p-device.o
>   CC      sh4eb-softmmu/hw/scsi/vhost-scsi.o
>   CC      sparc64-softmmu/hw/block/virtio-blk.o
>   CC      sh4-softmmu/hw/core/nmi.o
>   CC      sparc-softmmu/memory_mapping.o
>   CC      sh4eb-softmmu/hw/timer/sh_timer.o
>   CC      sh4-softmmu/hw/core/generic-loader.o
>   CC      sparc-softmmu/dump.o
>   CC      sh4eb-softmmu/hw/timer/mc146818rtc.o
>   CC      sh4-softmmu/hw/core/null-machine.o
>   CC      sparc64-softmmu/hw/block/dataplane/virtio-blk.o
>   CC      sh4-softmmu/hw/cpu/core.o
>   CC      sh4eb-softmmu/hw/vfio/common.o
>   CC      sparc-softmmu/migration/ram.o
>   CC      sparc64-softmmu/hw/char/virtio-serial-bus.o
>   CC      sh4-softmmu/hw/display/sm501.o
>   CC      sh4eb-softmmu/hw/vfio/pci.o
>   CC      sparc64-softmmu/hw/core/nmi.o
>   CC      sh4-softmmu/hw/display/vga.o
>   CC      sparc64-softmmu/hw/core/generic-loader.o
>   CC      sparc64-softmmu/hw/core/null-machine.o
>   CC      sparc-softmmu/migration/savevm.o
>   CC      sparc64-softmmu/hw/cpu/core.o
>   CC      sh4eb-softmmu/hw/vfio/pci-quirks.o
>   CC      sparc64-softmmu/hw/display/vga.o
>   CC      sparc-softmmu/xen-common-stub.o
>   CC      sh4-softmmu/hw/display/virtio-gpu.o
>   CC      sparc-softmmu/xen-hvm-stub.o
>   CC      sh4eb-softmmu/hw/vfio/platform.o
>   CC      sh4eb-softmmu/hw/vfio/spapr.o
>   CC      sparc-softmmu/hw/core/nmi.o
>   CC      sparc64-softmmu/hw/display/virtio-gpu.o
>   CC      sh4eb-softmmu/hw/virtio/virtio.o
>   CC      sparc-softmmu/hw/core/generic-loader.o
>   CC      sh4-softmmu/hw/display/virtio-gpu-3d.o
>   CC      sparc-softmmu/hw/core/null-machine.o
>   CC      sh4eb-softmmu/hw/virtio/virtio-balloon.o
>   CC      sparc64-softmmu/hw/display/virtio-gpu-3d.o
>   CC      sh4-softmmu/hw/display/virtio-gpu-pci.o
>   CC      sparc-softmmu/hw/cpu/core.o
>   CC      sh4-softmmu/hw/intc/sh_intc.o
>   CC      sh4eb-softmmu/hw/virtio/vhost.o
>   CC      sparc-softmmu/hw/display/tcx.o
>   CC      sparc64-softmmu/hw/display/virtio-gpu-pci.o
>   CC      sh4-softmmu/hw/misc/ivshmem.o
>   CC      sparc-softmmu/hw/display/cg3.o
>   CC      sh4eb-softmmu/hw/virtio/vhost-backend.o
>   CC      sparc64-softmmu/hw/misc/ivshmem.o
>   CC      sh4-softmmu/hw/misc/edu.o
>   CC      sh4eb-softmmu/hw/virtio/vhost-user.o
>   CC      sparc64-softmmu/hw/misc/edu.o
>   CC      sparc-softmmu/hw/intc/grlib_irqmp.o
>   CC      sh4-softmmu/hw/net/virtio-net.o
>   CC      sh4eb-softmmu/hw/virtio/vhost-vsock.o
>   CC      sparc64-softmmu/hw/net/virtio-net.o
>   CC      sparc-softmmu/hw/misc/eccmemctl.o
>   CC      sh4eb-softmmu/hw/virtio/virtio-crypto.o
>   CC      sparc-softmmu/hw/misc/slavio_misc.o
>   CC      sparc64-softmmu/hw/net/vhost_net.o
>   CC      sh4-softmmu/hw/net/vhost_net.o
>   CC      sh4eb-softmmu/hw/virtio/virtio-crypto-pci.o
>   CC      sparc64-softmmu/hw/scsi/virtio-scsi.o
>   CC      sh4-softmmu/hw/scsi/virtio-scsi.o
>   CC      sparc-softmmu/hw/net/vhost_net.o
>   CC      sh4eb-softmmu/hw/sh4/shix.o
>   CC      sparc-softmmu/hw/net/rocker/qmp-norocker.o
>   CC      sh4-softmmu/hw/scsi/virtio-scsi-dataplane.o
>   CC      sh4eb-softmmu/hw/sh4/r2d.o
>   CC      sparc64-softmmu/hw/scsi/virtio-scsi-dataplane.o
>   CC      sparc-softmmu/hw/vfio/common.o
>   CC      sh4eb-softmmu/hw/sh4/sh7750.o
>   CC      sh4-softmmu/hw/scsi/vhost-scsi.o
>   CC      sparc64-softmmu/hw/scsi/vhost-scsi.o
>   CC      sh4eb-softmmu/hw/sh4/sh7750_regnames.o
>   CC      sh4-softmmu/hw/timer/sh_timer.o
>   CC      sparc64-softmmu/hw/timer/mc146818rtc.o
>   CC      sh4eb-softmmu/hw/sh4/sh_pci.o
>   CC      sparc-softmmu/hw/vfio/platform.o
>   CC      sh4-softmmu/hw/timer/mc146818rtc.o
>   CC      sh4eb-softmmu/target/sh4/translate.o
>   CC      sparc-softmmu/hw/vfio/spapr.o
>   CC      sparc64-softmmu/hw/vfio/common.o
>   CC      sh4-softmmu/hw/vfio/common.o
>   CC      sparc-softmmu/hw/sparc/sun4m.o
>   CC      sparc64-softmmu/hw/vfio/pci.o
>   CC      sh4-softmmu/hw/vfio/pci.o
>   CC      sparc-softmmu/hw/sparc/leon3.o
>   CC      sparc-softmmu/target/sparc/machine.o
>   CC      sparc64-softmmu/hw/vfio/pci-quirks.o
>   CC      sparc-softmmu/target/sparc/monitor.o
>   CC      sh4-softmmu/hw/vfio/pci-quirks.o
>   CC      sparc-softmmu/target/sparc/translate.o
>   CC      sh4eb-softmmu/target/sh4/op_helper.o
>   CC      sparc64-softmmu/hw/vfio/platform.o
>   CC      sh4-softmmu/hw/vfio/platform.o
>   CC      sh4eb-softmmu/target/sh4/helper.o
>   CC      sparc64-softmmu/hw/vfio/spapr.o
>   CC      sh4-softmmu/hw/vfio/spapr.o
>   CC      sparc-softmmu/target/sparc/helper.o
>   CC      sh4eb-softmmu/target/sh4/cpu.o
>   CC      sparc64-softmmu/hw/virtio/virtio.o
>   CC      sparc-softmmu/target/sparc/cpu.o
>   CC      sh4eb-softmmu/target/sh4/monitor.o
>   CC      sh4-softmmu/hw/virtio/virtio.o
>   CC      sparc-softmmu/target/sparc/fop_helper.o
>   CC      sh4eb-softmmu/target/sh4/gdbstub.o
>   CC      sparc-softmmu/target/sparc/cc_helper.o
>   CC      sparc64-softmmu/hw/virtio/virtio-balloon.o
>   CC      sparc-softmmu/target/sparc/win_helper.o
>   GEN     trace/generated-helpers.c
>   CC      sh4eb-softmmu/trace/control-target.o
>   CC      sh4-softmmu/hw/virtio/virtio-balloon.o
>   CC      sparc-softmmu/target/sparc/mmu_helper.o
>   CC      sparc64-softmmu/hw/virtio/vhost.o
>   CC      sh4eb-softmmu/trace/generated-helpers.o
>   LINK    sh4eb-softmmu/qemu-system-sh4eb
>   CC      sparc-softmmu/target/sparc/ldst_helper.o
>   CC      sh4-softmmu/hw/virtio/vhost.o
>   CC      sparc64-softmmu/hw/virtio/vhost-backend.o
>   CC      sparc-softmmu/target/sparc/int32_helper.o
>   CC      sparc-softmmu/target/sparc/gdbstub.o
>   CC      sparc64-softmmu/hw/virtio/vhost-user.o
>   CC      sh4-softmmu/hw/virtio/vhost-backend.o
>   GEN     trace/generated-helpers.c
>   CC      sparc-softmmu/trace/control-target.o
>   CC      sparc64-softmmu/hw/virtio/vhost-vsock.o
>   CC      sh4-softmmu/hw/virtio/vhost-user.o
>   CC      sparc-softmmu/trace/generated-helpers.o
>   CC      sparc64-softmmu/hw/virtio/virtio-crypto.o
>   CC      sparc64-softmmu/hw/virtio/virtio-crypto-pci.o
>   CC      sh4-softmmu/hw/virtio/vhost-vsock.o
>   LINK    sparc-softmmu/qemu-system-sparc
>   CC      sh4-softmmu/hw/virtio/virtio-crypto.o
>   CC      sparc64-softmmu/hw/sparc64/sparc64.o
>   CC      sh4-softmmu/hw/virtio/virtio-crypto-pci.o
>   CC      sparc64-softmmu/hw/sparc64/sun4u.o
>   GEN     tricore-softmmu/hmp-commands.h
>   CC      sparc64-softmmu/hw/sparc64/niagara.o
>   CC      sh4-softmmu/hw/sh4/shix.o
>   GEN     tricore-softmmu/hmp-commands-info.h
>   GEN     tricore-softmmu/config-target.h
>   CC      sh4-softmmu/hw/sh4/r2d.o
>   CC      tricore-softmmu/exec.o
>   CC      sparc64-softmmu/target/sparc/machine.o
>   CC      sh4-softmmu/hw/sh4/sh7750.o
>   CC      sparc64-softmmu/target/sparc/monitor.o
>   CC      sh4-softmmu/hw/sh4/sh7750_regnames.o
>   CC      sparc64-softmmu/target/sparc/translate.o
>   GEN     unicore32-softmmu/hmp-commands.h
>   CC      sh4-softmmu/hw/sh4/sh_pci.o
>   GEN     unicore32-softmmu/hmp-commands-info.h
>   GEN     unicore32-softmmu/config-target.h
>   CC      unicore32-softmmu/exec.o
>   CC      sh4-softmmu/target/sh4/translate.o
>   CC      tricore-softmmu/translate-all.o
>   CC      tricore-softmmu/cpu-exec.o
>   CC      sparc64-softmmu/target/sparc/helper.o
>   CC      tricore-softmmu/translate-common.o
>   CC      unicore32-softmmu/translate-all.o
>   CC      sparc64-softmmu/target/sparc/cpu.o
>   CC      tricore-softmmu/cpu-exec-common.o
>   CC      sparc64-softmmu/target/sparc/fop_helper.o
>   CC      tricore-softmmu/tcg/tcg.o
>   CC      sh4-softmmu/target/sh4/op_helper.o
>   CC      unicore32-softmmu/cpu-exec.o
>   CC      sparc64-softmmu/target/sparc/cc_helper.o
>   CC      sh4-softmmu/target/sh4/helper.o
>   CC      unicore32-softmmu/translate-common.o
>   CC      sparc64-softmmu/target/sparc/win_helper.o
>   CC      unicore32-softmmu/cpu-exec-common.o
>   CC      sh4-softmmu/target/sh4/cpu.o
>   CC      unicore32-softmmu/tcg/tcg.o
>   CC      sh4-softmmu/target/sh4/monitor.o
>   CC      sparc64-softmmu/target/sparc/mmu_helper.o
>   CC      tricore-softmmu/tcg/tcg-op.o
>   CC      sh4-softmmu/target/sh4/gdbstub.o
>   CC      sparc64-softmmu/target/sparc/ldst_helper.o
>   GEN     trace/generated-helpers.c
>   CC      sh4-softmmu/trace/control-target.o
>   CC      sparc64-softmmu/target/sparc/int64_helper.o
>   CC      sh4-softmmu/trace/generated-helpers.o
>   CC      sparc64-softmmu/target/sparc/vis_helper.o
>   LINK    sh4-softmmu/qemu-system-sh4
>   CC      unicore32-softmmu/tcg/tcg-op.o
>   CC      sparc64-softmmu/target/sparc/gdbstub.o
>   GEN     trace/generated-helpers.c
>   CC      sparc64-softmmu/trace/control-target.o
>   CC      tricore-softmmu/tcg/optimize.o
>   CC      sparc64-softmmu/trace/generated-helpers.o
>   CC      tricore-softmmu/tcg/tcg-common.o
>   LINK    sparc64-softmmu/qemu-system-sparc64
>   CC      tricore-softmmu/fpu/softfloat.o
>   CC      unicore32-softmmu/tcg/optimize.o
>   CC      tricore-softmmu/disas.o
>   CC      unicore32-softmmu/tcg/tcg-common.o
>   CC      unicore32-softmmu/fpu/softfloat.o
>   GEN     x86_64-softmmu/hmp-commands.h
>   GEN     x86_64-softmmu/hmp-commands-info.h
>   GEN     x86_64-softmmu/config-target.h
>   CC      x86_64-softmmu/exec.o
>   GEN     xtensaeb-softmmu/hmp-commands.h
>   CC      tricore-softmmu/tcg-runtime.o
>   GEN     xtensaeb-softmmu/hmp-commands-info.h
>   GEN     xtensaeb-softmmu/config-target.h
>   CC      xtensaeb-softmmu/exec.o
>   CC      tricore-softmmu/hax-stub.o
>   CC      tricore-softmmu/kvm-stub.o
>   CC      tricore-softmmu/arch_init.o
>   CC      unicore32-softmmu/disas.o
>   CC      x86_64-softmmu/translate-all.o
>   CC      tricore-softmmu/cpus.o
>   CC      unicore32-softmmu/tcg-runtime.o
>   CC      tricore-softmmu/monitor.o
>   CC      unicore32-softmmu/hax-stub.o
>   CC      x86_64-softmmu/cpu-exec.o
>   CC      xtensaeb-softmmu/translate-all.o
>   CC      unicore32-softmmu/kvm-stub.o
>   CC      unicore32-softmmu/arch_init.o
>   CC      x86_64-softmmu/translate-common.o
>   CC      xtensaeb-softmmu/cpu-exec.o
>   CC      unicore32-softmmu/cpus.o
>   CC      x86_64-softmmu/cpu-exec-common.o
>   CC      xtensaeb-softmmu/translate-common.o
>   CC      xtensaeb-softmmu/cpu-exec-common.o
>   CC      x86_64-softmmu/tcg/tcg.o
>   CC      tricore-softmmu/gdbstub.o
>   CC      xtensaeb-softmmu/tcg/tcg.o
>   CC      unicore32-softmmu/monitor.o
>   CC      tricore-softmmu/balloon.o
>   CC      tricore-softmmu/ioport.o
>   CC      unicore32-softmmu/gdbstub.o
>   CC      x86_64-softmmu/tcg/tcg-op.o
>   CC      tricore-softmmu/numa.o
>   CC      xtensaeb-softmmu/tcg/tcg-op.o
>   CC      unicore32-softmmu/balloon.o
>   CC      tricore-softmmu/qtest.o
>   CC      tricore-softmmu/bootdevice.o
>   CC      unicore32-softmmu/ioport.o
>   CC      tricore-softmmu/memory.o
>   CC      unicore32-softmmu/numa.o
>   CC      unicore32-softmmu/qtest.o
>   CC      x86_64-softmmu/tcg/optimize.o
>   CC      tricore-softmmu/cputlb.o
>   CC      unicore32-softmmu/bootdevice.o
>   CC      xtensaeb-softmmu/tcg/optimize.o
>   CC      unicore32-softmmu/memory.o
>   CC      xtensaeb-softmmu/tcg/tcg-common.o
>   CC      tricore-softmmu/memory_mapping.o
>   CC      x86_64-softmmu/tcg/tcg-common.o
>   CC      xtensaeb-softmmu/fpu/softfloat.o
>   CC      tricore-softmmu/dump.o
>   CC      x86_64-softmmu/fpu/softfloat.o
>   CC      unicore32-softmmu/cputlb.o
>   CC      tricore-softmmu/migration/ram.o
>   CC      x86_64-softmmu/disas.o
>   CC      tricore-softmmu/migration/savevm.o
>   CC      unicore32-softmmu/memory_mapping.o
>   CC      xtensaeb-softmmu/disas.o
>   CC      x86_64-softmmu/tcg-runtime.o
>   CC      unicore32-softmmu/dump.o
>   CC      x86_64-softmmu/hax-stub.o
>   CC      xtensaeb-softmmu/tcg-runtime.o
>   CC      x86_64-softmmu/kvm-stub.o
>   CC      tricore-softmmu/xen-common-stub.o
>   CC      unicore32-softmmu/migration/ram.o
>   CC      xtensaeb-softmmu/hax-stub.o
>   CC      tricore-softmmu/xen-hvm-stub.o
>   CC      x86_64-softmmu/arch_init.o
>   CC      tricore-softmmu/hw/core/nmi.o
>   CC      x86_64-softmmu/cpus.o
>   CC      xtensaeb-softmmu/kvm-stub.o
>   CC      tricore-softmmu/hw/core/generic-loader.o
>   CC      xtensaeb-softmmu/arch_init.o
>   CC      unicore32-softmmu/migration/savevm.o
>   CC      x86_64-softmmu/monitor.o
>   CC      xtensaeb-softmmu/cpus.o
>   CC      tricore-softmmu/hw/core/null-machine.o
>   CC      tricore-softmmu/hw/cpu/core.o
>   CC      unicore32-softmmu/xen-common-stub.o
>   CC      xtensaeb-softmmu/monitor.o
>   CC      tricore-softmmu/hw/net/vhost_net.o
>   CC      unicore32-softmmu/xen-hvm-stub.o
>   CC      tricore-softmmu/hw/net/rocker/qmp-norocker.o
>   CC      unicore32-softmmu/hw/core/nmi.o
>   CC      x86_64-softmmu/gdbstub.o
>   CC      unicore32-softmmu/hw/core/generic-loader.o
>   CC      tricore-softmmu/hw/vfio/common.o
>   CC      unicore32-softmmu/hw/core/null-machine.o
>   CC      x86_64-softmmu/balloon.o
>   CC      unicore32-softmmu/hw/cpu/core.o
>   CC      tricore-softmmu/hw/vfio/platform.o
>   CC      xtensaeb-softmmu/gdbstub.o
>   CC      x86_64-softmmu/ioport.o
>   CC      unicore32-softmmu/hw/net/vhost_net.o
>   CC      xtensaeb-softmmu/balloon.o
>   CC      tricore-softmmu/hw/vfio/spapr.o
>   CC      x86_64-softmmu/numa.o
>   CC      unicore32-softmmu/hw/net/rocker/qmp-norocker.o
>   CC      tricore-softmmu/hw/tricore/tricore_testboard.o
>   CC      xtensaeb-softmmu/ioport.o
>   CC      x86_64-softmmu/qtest.o
>   CC      unicore32-softmmu/hw/vfio/common.o
>   CC      tricore-softmmu/target/tricore/translate.o
>   CC      xtensaeb-softmmu/numa.o
>   CC      x86_64-softmmu/bootdevice.o
>   CC      unicore32-softmmu/hw/vfio/platform.o
>   CC      x86_64-softmmu/memory.o
>   CC      xtensaeb-softmmu/qtest.o
>   CC      unicore32-softmmu/hw/vfio/spapr.o
>   CC      xtensaeb-softmmu/bootdevice.o
>   CC      unicore32-softmmu/hw/unicore32/puv3.o
>   CC      unicore32-softmmu/target/unicore32/translate.o
>   CC      xtensaeb-softmmu/memory.o
>   CC      x86_64-softmmu/cputlb.o
>   CC      xtensaeb-softmmu/cputlb.o
>   CC      unicore32-softmmu/target/unicore32/op_helper.o
>   CC      unicore32-softmmu/target/unicore32/helper.o
>   CC      x86_64-softmmu/memory_mapping.o
>   CC      unicore32-softmmu/target/unicore32/cpu.o
>   CC      x86_64-softmmu/dump.o
>   CC      unicore32-softmmu/target/unicore32/ucf64_helper.o
>   CC      unicore32-softmmu/target/unicore32/softmmu.o
>   CC      xtensaeb-softmmu/memory_mapping.o
>   CC      x86_64-softmmu/migration/ram.o
>   CC      tricore-softmmu/target/tricore/helper.o
>   GEN     trace/generated-helpers.c
>   CC      unicore32-softmmu/trace/control-target.o
>   CC      tricore-softmmu/target/tricore/cpu.o
>   CC      xtensaeb-softmmu/dump.o
>   CC      unicore32-softmmu/trace/generated-helpers.o
>   CC      tricore-softmmu/target/tricore/op_helper.o
>   LINK    unicore32-softmmu/qemu-system-unicore32
>   CC      x86_64-softmmu/migration/savevm.o
>   CC      xtensaeb-softmmu/migration/ram.o
>   CC      tricore-softmmu/target/tricore/fpu_helper.o
>   CC      xtensaeb-softmmu/migration/savevm.o
>   CC      x86_64-softmmu/xen-common-stub.o
>   GEN     trace/generated-helpers.c
>   CC      tricore-softmmu/trace/control-target.o
>   CC      x86_64-softmmu/xen-hvm-stub.o
>   CC      tricore-softmmu/trace/generated-helpers.o
>   CC      x86_64-softmmu/hw/9pfs/virtio-9p-device.o
>   CC      xtensaeb-softmmu/xen-common-stub.o
>   LINK    tricore-softmmu/qemu-system-tricore
>   CC      xtensaeb-softmmu/xen-hvm-stub.o
>   GEN     xtensa-softmmu/hmp-commands.h
>   GEN     xtensa-softmmu/hmp-commands-info.h
>   CC      x86_64-softmmu/hw/block/virtio-blk.o
>   GEN     xtensa-softmmu/config-target.h
>   CC      xtensaeb-softmmu/hw/core/nmi.o
>   CC      xtensa-softmmu/exec.o
>   CC      xtensaeb-softmmu/hw/core/generic-loader.o
>   CC      x86_64-softmmu/hw/block/dataplane/virtio-blk.o
>   CC      xtensaeb-softmmu/hw/core/null-machine.o
>   CC      xtensaeb-softmmu/hw/cpu/core.o
>   CC      x86_64-softmmu/hw/char/virtio-serial-bus.o
>   CC      xtensaeb-softmmu/hw/net/vhost_net.o
>   GEN     aarch64-linux-user/config-target.h
>   CC      xtensaeb-softmmu/hw/net/rocker/qmp-norocker.o
>   CC      aarch64-linux-user/exec.o
>   CC      x86_64-softmmu/hw/core/nmi.o
>   CC      xtensaeb-softmmu/hw/vfio/common.o
>   CC      x86_64-softmmu/hw/core/generic-loader.o
>   CC      aarch64-linux-user/translate-all.o
>   CC      xtensa-softmmu/translate-all.o
>   CC      xtensaeb-softmmu/hw/vfio/platform.o
>   CC      x86_64-softmmu/hw/core/null-machine.o
>   CC      aarch64-linux-user/cpu-exec.o
>   CC      xtensa-softmmu/cpu-exec.o
>   CC      x86_64-softmmu/hw/cpu/core.o
>   CC      xtensaeb-softmmu/hw/vfio/spapr.o
>   CC      aarch64-linux-user/translate-common.o
>   CC      x86_64-softmmu/hw/display/vga.o
>   CC      xtensaeb-softmmu/hw/xtensa/pic_cpu.o
>   CC      xtensa-softmmu/translate-common.o
>   CC      aarch64-linux-user/cpu-exec-common.o
>   CC      aarch64-linux-user/tcg/tcg.o
>   CC      xtensaeb-softmmu/hw/xtensa/sim.o
>   CC      xtensa-softmmu/cpu-exec-common.o
>   CC      xtensaeb-softmmu/hw/xtensa/xtfpga.o
>   CC      xtensa-softmmu/tcg/tcg.o
>   CC      x86_64-softmmu/hw/display/virtio-gpu.o
>   CC      xtensaeb-softmmu/target/xtensa/xtensa-semi.o
>   CC      xtensaeb-softmmu/target/xtensa/core-dc232b.o
>   CC      x86_64-softmmu/hw/display/virtio-gpu-3d.o
>   CC      xtensaeb-softmmu/target/xtensa/core-dc233c.o
>   CC      xtensa-softmmu/tcg/tcg-op.o
>   CC      aarch64-linux-user/tcg/tcg-op.o
>   CC      xtensaeb-softmmu/target/xtensa/core-fsf.o
>   CC      xtensaeb-softmmu/target/xtensa/monitor.o
>   CC      x86_64-softmmu/hw/display/virtio-gpu-pci.o
>   CC      xtensaeb-softmmu/target/xtensa/translate.o
>   CC      x86_64-softmmu/hw/display/virtio-vga.o
>   CC      x86_64-softmmu/hw/intc/apic.o
>   CC      xtensa-softmmu/tcg/optimize.o
>   CC      xtensaeb-softmmu/target/xtensa/op_helper.o
>   CC      x86_64-softmmu/hw/intc/apic_common.o
>   CC      aarch64-linux-user/tcg/optimize.o
>   CC      x86_64-softmmu/hw/intc/ioapic.o
>   CC      xtensa-softmmu/tcg/tcg-common.o
>   CC      x86_64-softmmu/hw/isa/lpc_ich9.o
>   CC      xtensaeb-softmmu/target/xtensa/helper.o
>   CC      xtensa-softmmu/fpu/softfloat.o
>   CC      x86_64-softmmu/hw/misc/vmport.o
>   CC      xtensaeb-softmmu/target/xtensa/cpu.o
>   CC      aarch64-linux-user/tcg/tcg-common.o
>   CC      x86_64-softmmu/hw/misc/ivshmem.o
>   CC      xtensaeb-softmmu/target/xtensa/gdbstub.o
>   CC      aarch64-linux-user/fpu/softfloat.o
>   CC      x86_64-softmmu/hw/misc/pvpanic.o
>   GEN     trace/generated-helpers.c
>   CC      xtensaeb-softmmu/trace/control-target.o
>   CC      x86_64-softmmu/hw/misc/edu.o
>   CC      x86_64-softmmu/hw/net/virtio-net.o
>   CC      xtensaeb-softmmu/trace/generated-helpers.o
>   CC      x86_64-softmmu/hw/net/vhost_net.o
>   CC      x86_64-softmmu/hw/scsi/virtio-scsi.o
>   LINK    xtensaeb-softmmu/qemu-system-xtensaeb
>   CC      x86_64-softmmu/hw/scsi/virtio-scsi-dataplane.o
>   CC      xtensa-softmmu/disas.o
>   CC      x86_64-softmmu/hw/scsi/vhost-scsi.o
>   CC      aarch64-linux-user/disas.o
>   CC      x86_64-softmmu/hw/timer/mc146818rtc.o
>   CC      xtensa-softmmu/tcg-runtime.o
>   CC      aarch64-linux-user/tcg-runtime.o
>   CC      xtensa-softmmu/hax-stub.o
>   GEN     alpha-linux-user/config-target.h
>   CC      alpha-linux-user/exec.o
>   CC      x86_64-softmmu/hw/vfio/common.o
>   CC      xtensa-softmmu/kvm-stub.o
>   CC      xtensa-softmmu/arch_init.o
>   CC      alpha-linux-user/translate-all.o
>   GEN     aarch64-linux-user/gdbstub-xml.c
>   CC      xtensa-softmmu/cpus.o
>   CC      x86_64-softmmu/hw/vfio/pci.o
>   CC      alpha-linux-user/cpu-exec.o
>   CC      aarch64-linux-user/hax-stub.o
>   CC      xtensa-softmmu/monitor.o
>   CC      alpha-linux-user/translate-common.o
>   CC      aarch64-linux-user/kvm-stub.o
>   CC      x86_64-softmmu/hw/vfio/pci-quirks.o
>   CC      alpha-linux-user/cpu-exec-common.o
>   CC      aarch64-linux-user/gdbstub.o
>   CC      alpha-linux-user/tcg/tcg.o
>   CC      x86_64-softmmu/hw/vfio/platform.o
>   CC      aarch64-linux-user/thunk.o
>   CC      xtensa-softmmu/gdbstub.o
>   CC      aarch64-linux-user/user-exec.o
>   CC      x86_64-softmmu/hw/vfio/spapr.o
>   CC      aarch64-linux-user/user-exec-stub.o
>   CC      aarch64-linux-user/linux-user/main.o
>   CC      xtensa-softmmu/balloon.o
>   CC      x86_64-softmmu/hw/virtio/virtio.o
>   CC      xtensa-softmmu/ioport.o
>   CC      alpha-linux-user/tcg/tcg-op.o
>   CC      aarch64-linux-user/linux-user/syscall.o
>   CC      xtensa-softmmu/numa.o
>   CC      x86_64-softmmu/hw/virtio/virtio-balloon.o
>   CC      xtensa-softmmu/qtest.o
>   CC      x86_64-softmmu/hw/virtio/vhost.o
>   CC      xtensa-softmmu/bootdevice.o
>   CC      xtensa-softmmu/memory.o
>   CC      x86_64-softmmu/hw/virtio/vhost-backend.o
>   CC      alpha-linux-user/tcg/optimize.o
>   CC      x86_64-softmmu/hw/virtio/vhost-user.o
>   CC      x86_64-softmmu/hw/virtio/vhost-vsock.o
>   CC      alpha-linux-user/tcg/tcg-common.o
>   CC      x86_64-softmmu/hw/virtio/virtio-crypto.o
>   CC      xtensa-softmmu/cputlb.o
>   CC      alpha-linux-user/fpu/softfloat.o
>   CC      x86_64-softmmu/hw/virtio/virtio-crypto-pci.o
>   CC      x86_64-softmmu/hw/i386/multiboot.o
>   CC      aarch64-linux-user/linux-user/strace.o
>   CC      x86_64-softmmu/hw/i386/pc.o
>   CC      aarch64-linux-user/linux-user/mmap.o
>   CC      xtensa-softmmu/memory_mapping.o
>   CC      x86_64-softmmu/hw/i386/pc_piix.o
>   CC      aarch64-linux-user/linux-user/signal.o
>   CC      xtensa-softmmu/dump.o
>   CC      aarch64-linux-user/linux-user/elfload.o
>   CC      x86_64-softmmu/hw/i386/pc_q35.o
>   CC      xtensa-softmmu/migration/ram.o
>   CC      alpha-linux-user/disas.o
>   CC      aarch64-linux-user/linux-user/linuxload.o
>   CC      x86_64-softmmu/hw/i386/pc_sysfw.o
>   CC      aarch64-linux-user/linux-user/uaccess.o
>   CC      alpha-linux-user/tcg-runtime.o
>   CC      x86_64-softmmu/hw/i386/x86-iommu.o
>   CC      aarch64-linux-user/linux-user/uname.o
>   CC      xtensa-softmmu/migration/savevm.o
>   CC      x86_64-softmmu/hw/i386/intel_iommu.o
>   CCAS    aarch64-linux-user/linux-user/safe-syscall.o
>   CC      aarch64-linux-user/linux-user/flatload.o
>   CC      alpha-linux-user/hax-stub.o
>   CC      alpha-linux-user/kvm-stub.o
>   CC      x86_64-softmmu/hw/i386/amd_iommu.o
>   CC      aarch64-linux-user/target/arm/arm-semi.o
>   CC      alpha-linux-user/gdbstub.o
>   CC      xtensa-softmmu/xen-common-stub.o
>   CC      aarch64-linux-user/target/arm/kvm-stub.o
>   CC      x86_64-softmmu/hw/i386/kvmvapic.o
>   CC      xtensa-softmmu/xen-hvm-stub.o
>   CC      aarch64-linux-user/target/arm/translate.o
>   CC      xtensa-softmmu/hw/core/nmi.o
>   CC      alpha-linux-user/thunk.o
>   CC      x86_64-softmmu/hw/i386/acpi-build.o
>   CC      xtensa-softmmu/hw/core/generic-loader.o
>   CC      alpha-linux-user/user-exec.o
>   CC      xtensa-softmmu/hw/core/null-machine.o
>   CC      alpha-linux-user/user-exec-stub.o
>   CC      xtensa-softmmu/hw/cpu/core.o
>   CC      alpha-linux-user/linux-user/main.o
>   CC      x86_64-softmmu/hw/i386/pci-assign-load-rom.o
>   CC      xtensa-softmmu/hw/net/vhost_net.o
>   CC      x86_64-softmmu/target/i386/translate.o
>   CC      alpha-linux-user/linux-user/syscall.o
>   CC      xtensa-softmmu/hw/net/rocker/qmp-norocker.o
>   CC      xtensa-softmmu/hw/vfio/common.o
>   CC      xtensa-softmmu/hw/vfio/platform.o
>   CC      xtensa-softmmu/hw/vfio/spapr.o
>   CC      aarch64-linux-user/target/arm/op_helper.o
>   CC      xtensa-softmmu/hw/xtensa/pic_cpu.o
>   CC      xtensa-softmmu/hw/xtensa/sim.o
>   CC      aarch64-linux-user/target/arm/helper.o
>   CC      xtensa-softmmu/hw/xtensa/xtfpga.o
>   CC      alpha-linux-user/linux-user/strace.o
>   CC      xtensa-softmmu/target/xtensa/xtensa-semi.o
>   CC      xtensa-softmmu/target/xtensa/core-dc232b.o
>   CC      alpha-linux-user/linux-user/mmap.o
>   CC      xtensa-softmmu/target/xtensa/core-dc233c.o
>   CC      aarch64-linux-user/target/arm/cpu.o
>   CC      alpha-linux-user/linux-user/signal.o
>   CC      xtensa-softmmu/target/xtensa/core-fsf.o
>   CC      aarch64-linux-user/target/arm/neon_helper.o
>   CC      xtensa-softmmu/target/xtensa/monitor.o
>   CC      alpha-linux-user/linux-user/elfload.o
>   CC      xtensa-softmmu/target/xtensa/translate.o
>   CC      aarch64-linux-user/target/arm/iwmmxt_helper.o
>   CC      alpha-linux-user/linux-user/linuxload.o
>   CC      alpha-linux-user/linux-user/uaccess.o
>   CC      alpha-linux-user/linux-user/uname.o
>   CC      x86_64-softmmu/target/i386/helper.o
>   CCAS    alpha-linux-user/linux-user/safe-syscall.o
>   CC      alpha-linux-user/target/alpha/translate.o
>   CC      aarch64-linux-user/target/arm/gdbstub.o
>   CC      aarch64-linux-user/target/arm/cpu64.o
>   CC      xtensa-softmmu/target/xtensa/op_helper.o
>   CC      x86_64-softmmu/target/i386/cpu.o
>   CC      aarch64-linux-user/target/arm/translate-a64.o
>   CC      alpha-linux-user/target/alpha/helper.o
>   CC      xtensa-softmmu/target/xtensa/helper.o
>   CC      alpha-linux-user/target/alpha/cpu.o
>   CC      x86_64-softmmu/target/i386/bpt_helper.o
>   CC      xtensa-softmmu/target/xtensa/cpu.o
>   CC      alpha-linux-user/target/alpha/int_helper.o
>   CC      x86_64-softmmu/target/i386/excp_helper.o
>   CC      alpha-linux-user/target/alpha/fpu_helper.o
>   CC      xtensa-softmmu/target/xtensa/gdbstub.o
>   CC      x86_64-softmmu/target/i386/fpu_helper.o
>   CC      alpha-linux-user/target/alpha/vax_helper.o
>   CC      alpha-linux-user/target/alpha/sys_helper.o
>   GEN     trace/generated-helpers.c
>   CC      xtensa-softmmu/trace/control-target.o
>   CC      alpha-linux-user/target/alpha/mem_helper.o
>   CC      xtensa-softmmu/trace/generated-helpers.o
>   CC      alpha-linux-user/target/alpha/gdbstub.o
>   LINK    xtensa-softmmu/qemu-system-xtensa
>   GEN     trace/generated-helpers.c
>   CC      alpha-linux-user/trace/control-target.o
>   CC      alpha-linux-user/trace/generated-helpers.o
>   CC      aarch64-linux-user/target/arm/helper-a64.o
>   GEN     armeb-linux-user/config-target.h
>   LINK    alpha-linux-user/qemu-alpha
>   CC      armeb-linux-user/exec.o
>   CC      x86_64-softmmu/target/i386/cc_helper.o
>   CC      aarch64-linux-user/target/arm/gdbstub64.o
>   CC      armeb-linux-user/translate-all.o
>   CC      x86_64-softmmu/target/i386/int_helper.o
>   CC      aarch64-linux-user/target/arm/crypto_helper.o
>   CC      x86_64-softmmu/target/i386/svm_helper.o
>   GEN     trace/generated-helpers.c
>   CC      armeb-linux-user/cpu-exec.o
>   CC      aarch64-linux-user/trace/control-target.o
>   CC      x86_64-softmmu/target/i386/smm_helper.o
>   CC      x86_64-softmmu/target/i386/misc_helper.o
>   CC      aarch64-linux-user/gdbstub-xml.o
>   CC      aarch64-linux-user/trace/generated-helpers.o
>   CC      armeb-linux-user/translate-common.o
>   CC      x86_64-softmmu/target/i386/mem_helper.o
>   LINK    aarch64-linux-user/qemu-aarch64
>   CC      armeb-linux-user/cpu-exec-common.o
>   GEN     arm-linux-user/config-target.h
>   CC      arm-linux-user/exec.o
>   CC      armeb-linux-user/tcg/tcg.o
>   CC      x86_64-softmmu/target/i386/seg_helper.o
>   CC      armeb-linux-user/tcg/tcg-op.o
>   CC      arm-linux-user/translate-all.o
>   CC      arm-linux-user/cpu-exec.o
>   CC      arm-linux-user/translate-common.o
>   CC      arm-linux-user/cpu-exec-common.o
>   CC      arm-linux-user/tcg/tcg.o
>   CC      arm-linux-user/tcg/tcg-op.o
>   CC      x86_64-softmmu/target/i386/mpx_helper.o
>   CC      x86_64-softmmu/target/i386/gdbstub.o
>   CC      armeb-linux-user/tcg/optimize.o
>   CC      x86_64-softmmu/target/i386/machine.o
>   CC      x86_64-softmmu/target/i386/arch_memory_mapping.o
>   CC      armeb-linux-user/tcg/tcg-common.o
>   CC      arm-linux-user/tcg/optimize.o
>   CC      x86_64-softmmu/target/i386/arch_dump.o
>   CC      armeb-linux-user/fpu/softfloat.o
>   CC      x86_64-softmmu/target/i386/monitor.o
>   CC      arm-linux-user/tcg/tcg-common.o
>   CC      arm-linux-user/fpu/softfloat.o
>   CC      arm-linux-user/disas.o
>   CC      x86_64-softmmu/target/i386/kvm-stub.o
>   CC      armeb-linux-user/disas.o
>   GEN     trace/generated-helpers.c
>   CC      x86_64-softmmu/trace/control-target.o
>   CC      armeb-linux-user/tcg-runtime.o
>   CC      x86_64-softmmu/trace/generated-helpers.o
>   GEN     cris-linux-user/config-target.h
>   CC      cris-linux-user/exec.o
>   LINK    x86_64-softmmu/qemu-system-x86_64
>   GEN     armeb-linux-user/gdbstub-xml.c
>   CC      cris-linux-user/translate-all.o
>   CC      armeb-linux-user/hax-stub.o
>   CC      cris-linux-user/cpu-exec.o
>   CC      armeb-linux-user/kvm-stub.o
>   CC      arm-linux-user/tcg-runtime.o
>   CC      armeb-linux-user/gdbstub.o
>   CC      cris-linux-user/translate-common.o
>   CC      cris-linux-user/cpu-exec-common.o
>   CC      armeb-linux-user/thunk.o
>   GEN     arm-linux-user/gdbstub-xml.c
>   CC      cris-linux-user/tcg/tcg.o
>   CC      cris-linux-user/tcg/tcg-op.o
>   CC      arm-linux-user/hax-stub.o
>   CC      arm-linux-user/kvm-stub.o
>   CC      armeb-linux-user/user-exec.o
>   CC      arm-linux-user/gdbstub.o
>   CC      armeb-linux-user/user-exec-stub.o
>   CC      arm-linux-user/thunk.o
>   CC      armeb-linux-user/linux-user/main.o
>   CC      arm-linux-user/user-exec.o
>   CC      cris-linux-user/tcg/optimize.o
>   CC      armeb-linux-user/linux-user/syscall.o
>   CC      arm-linux-user/user-exec-stub.o
>   CC      arm-linux-user/linux-user/main.o
>   CC      arm-linux-user/linux-user/syscall.o
>   CC      cris-linux-user/tcg/tcg-common.o
>   CC      cris-linux-user/fpu/softfloat.o
>   CC      cris-linux-user/disas.o
>   CC      cris-linux-user/tcg-runtime.o
>   GEN     hppa-linux-user/config-target.h
>   CC      hppa-linux-user/exec.o
>   CC      cris-linux-user/hax-stub.o
>   CC      armeb-linux-user/linux-user/strace.o
>   CC      arm-linux-user/linux-user/strace.o
>   CC      hppa-linux-user/translate-all.o
>   CC      cris-linux-user/kvm-stub.o
>   CC      cris-linux-user/gdbstub.o
>   CC      hppa-linux-user/cpu-exec.o
>   CC      armeb-linux-user/linux-user/mmap.o
>   CC      arm-linux-user/linux-user/mmap.o
>   CC      armeb-linux-user/linux-user/signal.o
>   CC      hppa-linux-user/translate-common.o
>   CC      cris-linux-user/thunk.o
>   CC      arm-linux-user/linux-user/signal.o
>   CC      hppa-linux-user/cpu-exec-common.o
>   CC      hppa-linux-user/tcg/tcg.o
>   CC      cris-linux-user/user-exec.o
>   CC      armeb-linux-user/linux-user/elfload.o
>   CC      cris-linux-user/user-exec-stub.o
>   CC      arm-linux-user/linux-user/elfload.o
>   CC      cris-linux-user/linux-user/main.o
>   CC      armeb-linux-user/linux-user/linuxload.o
>   CC      cris-linux-user/linux-user/syscall.o
>   CC      armeb-linux-user/linux-user/uaccess.o
>   CC      arm-linux-user/linux-user/linuxload.o
>   CC      armeb-linux-user/linux-user/uname.o
>   CC      hppa-linux-user/tcg/tcg-op.o
>   CC      arm-linux-user/linux-user/uaccess.o
>   CCAS    armeb-linux-user/linux-user/safe-syscall.o
>   CC      armeb-linux-user/linux-user/flatload.o
>   CC      arm-linux-user/linux-user/uname.o
>   CC      armeb-linux-user/linux-user/arm/nwfpe/fpa11.o
>   CCAS    arm-linux-user/linux-user/safe-syscall.o
>   CC      arm-linux-user/linux-user/flatload.o
>   CC      armeb-linux-user/linux-user/arm/nwfpe/fpa11_cpdo.o
>   CC      arm-linux-user/linux-user/arm/nwfpe/fpa11.o
>   CC      armeb-linux-user/linux-user/arm/nwfpe/fpa11_cpdt.o
>   CC      arm-linux-user/linux-user/arm/nwfpe/fpa11_cpdo.o
>   CC      armeb-linux-user/linux-user/arm/nwfpe/fpa11_cprt.o
>   CC      arm-linux-user/linux-user/arm/nwfpe/fpa11_cpdt.o
>   CC      armeb-linux-user/linux-user/arm/nwfpe/fpopcode.o
>   CC      armeb-linux-user/linux-user/arm/nwfpe/single_cpdo.o
>   CC      arm-linux-user/linux-user/arm/nwfpe/fpa11_cprt.o
>   CC      armeb-linux-user/linux-user/arm/nwfpe/double_cpdo.o
>   CC      hppa-linux-user/tcg/optimize.o
>   CC      arm-linux-user/linux-user/arm/nwfpe/fpopcode.o
>   CC      arm-linux-user/linux-user/arm/nwfpe/single_cpdo.o
>   CC      armeb-linux-user/linux-user/arm/nwfpe/extended_cpdo.o
>   CC      arm-linux-user/linux-user/arm/nwfpe/double_cpdo.o
>   CC      cris-linux-user/linux-user/strace.o
>   CC      armeb-linux-user/target/arm/arm-semi.o
>   CC      arm-linux-user/linux-user/arm/nwfpe/extended_cpdo.o
>   CC      hppa-linux-user/tcg/tcg-common.o
>   CC      arm-linux-user/target/arm/arm-semi.o
>   CC      hppa-linux-user/fpu/softfloat.o
>   CC      armeb-linux-user/target/arm/kvm-stub.o
>   CC      cris-linux-user/linux-user/mmap.o
>   CC      arm-linux-user/target/arm/kvm-stub.o
>   CC      armeb-linux-user/target/arm/translate.o
>   CC      arm-linux-user/target/arm/translate.o
>   CC      cris-linux-user/linux-user/signal.o
>   CC      cris-linux-user/linux-user/elfload.o
>   CC      cris-linux-user/linux-user/linuxload.o
>   CC      hppa-linux-user/disas.o
>   CC      cris-linux-user/linux-user/uaccess.o
>   CC      hppa-linux-user/tcg-runtime.o
>   CC      cris-linux-user/linux-user/uname.o
>   CCAS    cris-linux-user/linux-user/safe-syscall.o
>   CC      hppa-linux-user/hax-stub.o
>   CC      cris-linux-user/target/cris/translate.o
>   CC      hppa-linux-user/kvm-stub.o
>   CC      hppa-linux-user/gdbstub.o
>   CC      hppa-linux-user/thunk.o
>   CC      arm-linux-user/target/arm/op_helper.o
>   CC      hppa-linux-user/user-exec.o
>   CC      cris-linux-user/target/cris/op_helper.o
>   CC      armeb-linux-user/target/arm/op_helper.o
>   CC      hppa-linux-user/user-exec-stub.o
>   CC      cris-linux-user/target/cris/helper.o
>   CC      arm-linux-user/target/arm/helper.o
>   CC      cris-linux-user/target/cris/cpu.o
>   CC      hppa-linux-user/linux-user/main.o
>   CC      hppa-linux-user/linux-user/syscall.o
>   CC      cris-linux-user/target/cris/gdbstub.o
>   CC      armeb-linux-user/target/arm/helper.o
>   GEN     trace/generated-helpers.c
>   CC      cris-linux-user/trace/control-target.o
>   CC      cris-linux-user/trace/generated-helpers.o
>   CC      arm-linux-user/target/arm/cpu.o
>   LINK    cris-linux-user/qemu-cris
>   CC      arm-linux-user/target/arm/neon_helper.o
>   CC      hppa-linux-user/linux-user/strace.o
>   CC      armeb-linux-user/target/arm/cpu.o
>   CC      armeb-linux-user/target/arm/neon_helper.o
>   CC      hppa-linux-user/linux-user/mmap.o
>   CC      arm-linux-user/target/arm/iwmmxt_helper.o
>   CC      arm-linux-user/target/arm/gdbstub.o
>   CC      hppa-linux-user/linux-user/signal.o
>   CC      hppa-linux-user/linux-user/elfload.o
>   CC      armeb-linux-user/target/arm/iwmmxt_helper.o
>   GEN     i386-linux-user/config-target.h
>   CC      i386-linux-user/exec.o
>   CC      arm-linux-user/target/arm/crypto_helper.o
>   CC      hppa-linux-user/linux-user/linuxload.o
>   CC      i386-linux-user/translate-all.o
>   GEN     trace/generated-helpers.c
>   CC      arm-linux-user/trace/control-target.o
>   CC      hppa-linux-user/linux-user/uaccess.o
>   CC      arm-linux-user/gdbstub-xml.o
>   CC      i386-linux-user/cpu-exec.o
>   CC      hppa-linux-user/linux-user/uname.o
>   CC      armeb-linux-user/target/arm/gdbstub.o
>   CC      arm-linux-user/trace/generated-helpers.o
>   CC      i386-linux-user/translate-common.o
>   CCAS    hppa-linux-user/linux-user/safe-syscall.o
>   CC      hppa-linux-user/target/hppa/translate.o
>   CC      i386-linux-user/cpu-exec-common.o
>   CC      armeb-linux-user/target/arm/crypto_helper.o
>   LINK    arm-linux-user/qemu-arm
>   CC      i386-linux-user/tcg/tcg.o
>   GEN     trace/generated-helpers.c
>   CC      armeb-linux-user/trace/control-target.o
>   GEN     m68k-linux-user/config-target.h
>   CC      m68k-linux-user/exec.o
>   CC      armeb-linux-user/gdbstub-xml.o
>   CC      armeb-linux-user/trace/generated-helpers.o
>   CC      m68k-linux-user/translate-all.o
>   LINK    armeb-linux-user/qemu-armeb
>   CC      hppa-linux-user/target/hppa/helper.o
>   CC      i386-linux-user/tcg/tcg-op.o
>   CC      m68k-linux-user/cpu-exec.o
>   CC      m68k-linux-user/translate-common.o
>   CC      hppa-linux-user/target/hppa/cpu.o
>   CC      m68k-linux-user/cpu-exec-common.o
>   CC      m68k-linux-user/tcg/tcg.o
>   CC      hppa-linux-user/target/hppa/op_helper.o
>   CC      m68k-linux-user/tcg/tcg-op.o
>   CC      hppa-linux-user/target/hppa/gdbstub.o
>   GEN     trace/generated-helpers.c
>   CC      hppa-linux-user/trace/control-target.o
>   CC      m68k-linux-user/tcg/optimize.o
>   CC      hppa-linux-user/trace/generated-helpers.o
>   CC      i386-linux-user/tcg/optimize.o
>   LINK    hppa-linux-user/qemu-hppa
>   CC      m68k-linux-user/tcg/tcg-common.o
>   CC      m68k-linux-user/fpu/softfloat.o
>   CC      m68k-linux-user/disas.o
>   GEN     microblazeel-linux-user/config-target.h
>   CC      m68k-linux-user/tcg-runtime.o
>   CC      i386-linux-user/tcg/tcg-common.o
>   CC      microblazeel-linux-user/exec.o
>   CC      microblazeel-linux-user/translate-all.o
>   CC      i386-linux-user/fpu/softfloat.o
>   GEN     m68k-linux-user/gdbstub-xml.c
>   CC      microblazeel-linux-user/cpu-exec.o
>   CC      microblazeel-linux-user/translate-common.o
>   CC      microblazeel-linux-user/cpu-exec-common.o
>   CC      microblazeel-linux-user/tcg/tcg.o
>   CC      microblazeel-linux-user/tcg/tcg-op.o
>   CC      m68k-linux-user/hax-stub.o
>   CC      m68k-linux-user/kvm-stub.o
>   CC      i386-linux-user/disas.o
>   CC      m68k-linux-user/gdbstub.o
>   CC      microblazeel-linux-user/tcg/optimize.o
>   CC      i386-linux-user/tcg-runtime.o
>   CC      m68k-linux-user/thunk.o
>   CC      i386-linux-user/hax-stub.o
>   CC      m68k-linux-user/user-exec.o
>   CC      microblazeel-linux-user/tcg/tcg-common.o
>   CC      microblazeel-linux-user/fpu/softfloat.o
>   CC      m68k-linux-user/user-exec-stub.o
>   CC      i386-linux-user/kvm-stub.o
>   CC      i386-linux-user/gdbstub.o
>   GEN     microblaze-linux-user/config-target.h
>   CC      m68k-linux-user/linux-user/main.o
>   CC      microblaze-linux-user/exec.o
>   CC      m68k-linux-user/linux-user/syscall.o
>   CC      microblaze-linux-user/translate-all.o
>   CC      i386-linux-user/thunk.o
>   CC      i386-linux-user/user-exec.o
>   CC      microblaze-linux-user/cpu-exec.o
>   CC      microblaze-linux-user/translate-common.o
>   CC      i386-linux-user/user-exec-stub.o
>   CC      microblaze-linux-user/cpu-exec-common.o
>   CC      i386-linux-user/linux-user/main.o
>   CC      microblaze-linux-user/tcg/tcg.o
>   CC      i386-linux-user/linux-user/syscall.o
>   CC      microblazeel-linux-user/disas.o
>   CC      microblazeel-linux-user/tcg-runtime.o
>   CC      microblazeel-linux-user/hax-stub.o
>   CC      microblaze-linux-user/tcg/tcg-op.o
>   CC      microblazeel-linux-user/kvm-stub.o
>   CC      microblazeel-linux-user/gdbstub.o
>   CC      m68k-linux-user/linux-user/strace.o
>   CC      microblazeel-linux-user/thunk.o
>   CC      m68k-linux-user/linux-user/mmap.o
>   CC      microblazeel-linux-user/user-exec.o
>   CC      m68k-linux-user/linux-user/signal.o
>   CC      microblazeel-linux-user/user-exec-stub.o
>   CC      microblazeel-linux-user/linux-user/main.o
>   CC      m68k-linux-user/linux-user/elfload.o
>   CC      microblaze-linux-user/tcg/optimize.o
>   CC      microblazeel-linux-user/linux-user/syscall.o
>   CC      m68k-linux-user/linux-user/linuxload.o
>   CC      i386-linux-user/linux-user/strace.o
>   CC      microblaze-linux-user/tcg/tcg-common.o
>   CC      m68k-linux-user/linux-user/uaccess.o
>   CC      microblaze-linux-user/fpu/softfloat.o
>   CC      m68k-linux-user/linux-user/uname.o
>   CC      i386-linux-user/linux-user/mmap.o
>   CCAS    m68k-linux-user/linux-user/safe-syscall.o
>   CC      m68k-linux-user/linux-user/flatload.o
>   CC      i386-linux-user/linux-user/signal.o
>   CC      m68k-linux-user/linux-user/m68k-sim.o
>   CC      m68k-linux-user/target/m68k/m68k-semi.o
>   CC      i386-linux-user/linux-user/elfload.o
>   CC      m68k-linux-user/target/m68k/translate.o
>   CC      i386-linux-user/linux-user/linuxload.o
>   CC      microblazeel-linux-user/linux-user/strace.o
>   CC      microblaze-linux-user/disas.o
>   CC      i386-linux-user/linux-user/uaccess.o
>   CC      microblaze-linux-user/tcg-runtime.o
>   CC      i386-linux-user/linux-user/uname.o
>   CC      microblazeel-linux-user/linux-user/mmap.o
>   CCAS    i386-linux-user/linux-user/safe-syscall.o
>   CC      i386-linux-user/linux-user/vm86.o
>   CC      microblaze-linux-user/hax-stub.o
>   CC      i386-linux-user/target/i386/translate.o
>   CC      microblazeel-linux-user/linux-user/signal.o
>   CC      microblaze-linux-user/kvm-stub.o
>   CC      m68k-linux-user/target/m68k/op_helper.o
>   CC      microblaze-linux-user/gdbstub.o
>   CC      m68k-linux-user/target/m68k/helper.o
>   CC      microblazeel-linux-user/linux-user/elfload.o
>   CC      m68k-linux-user/target/m68k/cpu.o
>   CC      microblaze-linux-user/thunk.o
>   CC      microblaze-linux-user/user-exec.o
>   CC      m68k-linux-user/target/m68k/gdbstub.o
>   CC      microblazeel-linux-user/linux-user/linuxload.o
>   CC      microblaze-linux-user/user-exec-stub.o
>   GEN     trace/generated-helpers.c
>   CC      m68k-linux-user/trace/control-target.o
>   CC      microblazeel-linux-user/linux-user/uaccess.o
>   CC      microblaze-linux-user/linux-user/main.o
>   CC      m68k-linux-user/gdbstub-xml.o
>   CC      microblazeel-linux-user/linux-user/uname.o
>   CC      microblaze-linux-user/linux-user/syscall.o
>   CC      m68k-linux-user/trace/generated-helpers.o
>   CCAS    microblazeel-linux-user/linux-user/safe-syscall.o
>   CC      microblazeel-linux-user/linux-user/flatload.o
>   LINK    m68k-linux-user/qemu-m68k
>   CC      microblaze-linux-user/linux-user/strace.o
>   CC      microblazeel-linux-user/target/microblaze/translate.o
>   CC      microblazeel-linux-user/target/microblaze/op_helper.o
>   GEN     mips64el-linux-user/config-target.h
>   CC      microblazeel-linux-user/target/microblaze/helper.o
>   CC      i386-linux-user/target/i386/helper.o
>   CC      mips64el-linux-user/exec.o
>   CC      microblazeel-linux-user/target/microblaze/cpu.o
>   CC      i386-linux-user/target/i386/cpu.o
>   CC      microblazeel-linux-user/target/microblaze/gdbstub.o
>   CC      mips64el-linux-user/translate-all.o
>   GEN     trace/generated-helpers.c
>   CC      microblazeel-linux-user/trace/control-target.o
>   CC      microblazeel-linux-user/trace/generated-helpers.o
>   CC      i386-linux-user/target/i386/bpt_helper.o
>   LINK    microblazeel-linux-user/qemu-microblazeel
>   CC      i386-linux-user/target/i386/excp_helper.o
>   CC      mips64el-linux-user/cpu-exec.o
>   CC      i386-linux-user/target/i386/fpu_helper.o
>   CC      microblaze-linux-user/linux-user/mmap.o
>   CC      mips64el-linux-user/translate-common.o
>   CC      mips64el-linux-user/cpu-exec-common.o
>   CC      microblaze-linux-user/linux-user/signal.o
>   GEN     mips64-linux-user/config-target.h
>   CC      mips64el-linux-user/tcg/tcg.o
>   CC      mips64-linux-user/exec.o
>   CC      microblaze-linux-user/linux-user/elfload.o
>   CC      mips64-linux-user/translate-all.o
>   CC      microblaze-linux-user/linux-user/linuxload.o
>   CC      i386-linux-user/target/i386/cc_helper.o
>   CC      mips64-linux-user/cpu-exec.o
>   CC      i386-linux-user/target/i386/int_helper.o
>   CC      microblaze-linux-user/linux-user/uaccess.o
>   CC      microblaze-linux-user/linux-user/uname.o
>   CC      mips64el-linux-user/tcg/tcg-op.o
>   CC      i386-linux-user/target/i386/svm_helper.o
>   CC      mips64-linux-user/translate-common.o
>   CC      mips64-linux-user/cpu-exec-common.o
>   CCAS    microblaze-linux-user/linux-user/safe-syscall.o
>   CC      microblaze-linux-user/linux-user/flatload.o
>   CC      i386-linux-user/target/i386/smm_helper.o
>   CC      mips64-linux-user/tcg/tcg.o
>   CC      microblaze-linux-user/target/microblaze/translate.o
>   CC      i386-linux-user/target/i386/misc_helper.o
>   CC      i386-linux-user/target/i386/mem_helper.o
>   CC      i386-linux-user/target/i386/seg_helper.o
>   CC      microblaze-linux-user/target/microblaze/op_helper.o
>   CC      microblaze-linux-user/target/microblaze/helper.o
>   CC      mips64el-linux-user/tcg/optimize.o
>   CC      microblaze-linux-user/target/microblaze/cpu.o
>   CC      i386-linux-user/target/i386/mpx_helper.o
>   CC      mips64-linux-user/tcg/tcg-op.o
>   CC      microblaze-linux-user/target/microblaze/gdbstub.o
>   CC      i386-linux-user/target/i386/gdbstub.o
>   GEN     trace/generated-helpers.c
>   CC      microblaze-linux-user/trace/control-target.o
>   CC      i386-linux-user/target/i386/kvm-stub.o
>   CC      mips64el-linux-user/tcg/tcg-common.o
>   GEN     trace/generated-helpers.c
>   CC      i386-linux-user/trace/control-target.o
>   CC      microblaze-linux-user/trace/generated-helpers.o
>   CC      mips64el-linux-user/fpu/softfloat.o
>   CC      i386-linux-user/trace/generated-helpers.o
>   LINK    microblaze-linux-user/qemu-microblaze
>   LINK    i386-linux-user/qemu-i386
>   CC      mips64el-linux-user/disas.o
>   CC      mips64-linux-user/tcg/optimize.o
>   CC      mips64-linux-user/tcg/tcg-common.o
>   CC      mips64el-linux-user/tcg-runtime.o
>   CC      mips64-linux-user/fpu/softfloat.o
>   GEN     mipsel-linux-user/config-target.h
>   CC      mipsel-linux-user/exec.o
>   CC      mips64el-linux-user/hax-stub.o
>   CC      mips64el-linux-user/kvm-stub.o
>   CC      mipsel-linux-user/translate-all.o
>   GEN     mips-linux-user/config-target.h
>   CC      mips-linux-user/exec.o
>   CC      mips64el-linux-user/gdbstub.o
>   CC      mipsel-linux-user/cpu-exec.o
>   CC      mips-linux-user/translate-all.o
>   CC      mips64el-linux-user/thunk.o
>   CC      mipsel-linux-user/translate-common.o
>   CC      mips64el-linux-user/user-exec.o
>   CC      mips-linux-user/cpu-exec.o
>   CC      mipsel-linux-user/cpu-exec-common.o
>   CC      mips64el-linux-user/user-exec-stub.o
>   CC      mips-linux-user/translate-common.o
>   CC      mipsel-linux-user/tcg/tcg.o
>   CC      mips-linux-user/cpu-exec-common.o
>   CC      mips64el-linux-user/linux-user/main.o
>   CC      mips-linux-user/tcg/tcg.o
>   CC      mips64-linux-user/disas.o
>   CC      mips64el-linux-user/linux-user/syscall.o
>   CC      mips64-linux-user/tcg-runtime.o
>   CC      mips64-linux-user/hax-stub.o
>   CC      mipsel-linux-user/tcg/tcg-op.o
>   CC      mips64-linux-user/kvm-stub.o
>   CC      mips-linux-user/tcg/tcg-op.o
>   CC      mips64-linux-user/gdbstub.o
>   CC      mips64-linux-user/thunk.o
>   CC      mips64-linux-user/user-exec.o
>   CC      mips64el-linux-user/linux-user/strace.o
>   CC      mips64-linux-user/user-exec-stub.o
>   CC      mipsel-linux-user/tcg/optimize.o
>   CC      mips64el-linux-user/linux-user/mmap.o
>   CC      mips64-linux-user/linux-user/main.o
>   CC      mips64el-linux-user/linux-user/signal.o
>   CC      mips64-linux-user/linux-user/syscall.o
>   CC      mips-linux-user/tcg/optimize.o
>   CC      mipsel-linux-user/tcg/tcg-common.o
>   CC      mips64el-linux-user/linux-user/elfload.o
>   CC      mipsel-linux-user/fpu/softfloat.o
>   CC      mips64el-linux-user/linux-user/linuxload.o
>   CC      mips-linux-user/tcg/tcg-common.o
>   CC      mips64el-linux-user/linux-user/uaccess.o
>   CC      mips-linux-user/fpu/softfloat.o
>   CC      mips64el-linux-user/linux-user/uname.o
>   CCAS    mips64el-linux-user/linux-user/safe-syscall.o
>   CC      mips64el-linux-user/target/mips/translate.o
>   CC      mips64-linux-user/linux-user/strace.o
>   CC      mipsel-linux-user/disas.o
>   CC      mipsel-linux-user/tcg-runtime.o
>   CC      mips64-linux-user/linux-user/mmap.o
>   CC      mips-linux-user/disas.o
>   CC      mips-linux-user/tcg-runtime.o
>   CC      mips64-linux-user/linux-user/signal.o
>   CC      mipsel-linux-user/hax-stub.o
>   CC      mipsel-linux-user/kvm-stub.o
>   CC      mips-linux-user/hax-stub.o
>   CC      mipsel-linux-user/gdbstub.o
>   CC      mips64-linux-user/linux-user/elfload.o
>   CC      mips-linux-user/kvm-stub.o
>   CC      mips-linux-user/gdbstub.o
>   CC      mipsel-linux-user/thunk.o
>   CC      mips64-linux-user/linux-user/linuxload.o
>   CC      mips-linux-user/thunk.o
>   CC      mips64-linux-user/linux-user/uaccess.o
>   CC      mipsel-linux-user/user-exec.o
>   CC      mips-linux-user/user-exec.o
>   CC      mipsel-linux-user/user-exec-stub.o
>   CC      mips64-linux-user/linux-user/uname.o
>   CC      mipsel-linux-user/linux-user/main.o
>   CC      mips-linux-user/user-exec-stub.o
>   CCAS    mips64-linux-user/linux-user/safe-syscall.o
>   CC      mips64-linux-user/target/mips/translate.o
>   CC      mipsel-linux-user/linux-user/syscall.o
>   CC      mips-linux-user/linux-user/main.o
>   CC      mips-linux-user/linux-user/syscall.o
>   CC      mips64el-linux-user/target/mips/dsp_helper.o
>   CC      mips64el-linux-user/target/mips/op_helper.o
>   CC      mipsel-linux-user/linux-user/strace.o
>   CC      mips-linux-user/linux-user/strace.o
>   CC      mips64-linux-user/target/mips/dsp_helper.o
>   CC      mipsel-linux-user/linux-user/mmap.o
>   CC      mips-linux-user/linux-user/mmap.o
>   CC      mips64el-linux-user/target/mips/lmi_helper.o
>   CC      mipsel-linux-user/linux-user/signal.o
>   CC      mips-linux-user/linux-user/signal.o
>   CC      mips64el-linux-user/target/mips/helper.o
>   CC      mips-linux-user/linux-user/elfload.o
>   CC      mips64-linux-user/target/mips/op_helper.o
>   CC      mipsel-linux-user/linux-user/elfload.o
>   CC      mips64el-linux-user/target/mips/cpu.o
>   CC      mips64el-linux-user/target/mips/gdbstub.o
>   CC      mips-linux-user/linux-user/linuxload.o
>   CC      mipsel-linux-user/linux-user/linuxload.o
>   CC      mips64el-linux-user/target/mips/msa_helper.o
>   CC      mips-linux-user/linux-user/uaccess.o
>   CC      mipsel-linux-user/linux-user/uaccess.o
>   CC      mipsel-linux-user/linux-user/uname.o
>   CC      mips-linux-user/linux-user/uname.o
>   CCAS    mips-linux-user/linux-user/safe-syscall.o
>   CC      mips-linux-user/target/mips/translate.o
>   CCAS    mipsel-linux-user/linux-user/safe-syscall.o
>   CC      mipsel-linux-user/target/mips/translate.o
>   CC      mips64-linux-user/target/mips/lmi_helper.o
>   CC      mips64-linux-user/target/mips/helper.o
>   CC      mips64-linux-user/target/mips/cpu.o
>   CC      mips64el-linux-user/target/mips/mips-semi.o
>   CC      mips64-linux-user/target/mips/gdbstub.o
>   CC      mips64-linux-user/target/mips/msa_helper.o
>   GEN     trace/generated-helpers.c
>   CC      mips64el-linux-user/trace/control-target.o
>   CC      mips64el-linux-user/trace/generated-helpers.o
>   LINK    mips64el-linux-user/qemu-mips64el
>   CC      mips-linux-user/target/mips/dsp_helper.o
>   CC      mipsel-linux-user/target/mips/dsp_helper.o
>   CC      mipsel-linux-user/target/mips/op_helper.o
>   CC      mips-linux-user/target/mips/op_helper.o
>   GEN     mipsn32el-linux-user/config-target.h
>   CC      mipsn32el-linux-user/exec.o
>   CC      mipsn32el-linux-user/translate-all.o
>   CC      mips64-linux-user/target/mips/mips-semi.o
>   CC      mipsn32el-linux-user/cpu-exec.o
>   GEN     trace/generated-helpers.c
>   CC      mips64-linux-user/trace/control-target.o
>   CC      mipsel-linux-user/target/mips/lmi_helper.o
>   CC      mipsn32el-linux-user/translate-common.o
>   CC      mipsn32el-linux-user/cpu-exec-common.o
>   CC      mips-linux-user/target/mips/lmi_helper.o
>   CC      mips64-linux-user/trace/generated-helpers.o
>   CC      mipsel-linux-user/target/mips/helper.o
>   CC      mipsn32el-linux-user/tcg/tcg.o
>   CC      mipsel-linux-user/target/mips/cpu.o
>   LINK    mips64-linux-user/qemu-mips64
>   CC      mips-linux-user/target/mips/helper.o
>   CC      mipsel-linux-user/target/mips/gdbstub.o
>   CC      mipsn32el-linux-user/tcg/tcg-op.o
>   CC      mipsel-linux-user/target/mips/msa_helper.o
>   CC      mips-linux-user/target/mips/cpu.o
>   CC      mips-linux-user/target/mips/gdbstub.o
>   CC      mips-linux-user/target/mips/msa_helper.o
>   CC      mipsn32el-linux-user/tcg/optimize.o
>   CC      mipsn32el-linux-user/tcg/tcg-common.o
>   CC      mipsn32el-linux-user/fpu/softfloat.o
>   GEN     mipsn32-linux-user/config-target.h
>   CC      mipsn32-linux-user/exec.o
>   CC      mipsn32-linux-user/translate-all.o
>   CC      mipsel-linux-user/target/mips/mips-semi.o
>   GEN     trace/generated-helpers.c
>   CC      mipsel-linux-user/trace/control-target.o
>   CC      mipsn32-linux-user/cpu-exec.o
>   CC      mipsel-linux-user/trace/generated-helpers.o
>   CC      mipsn32-linux-user/translate-common.o
>   CC      mips-linux-user/target/mips/mips-semi.o
>   LINK    mipsel-linux-user/qemu-mipsel
>   CC      mipsn32el-linux-user/disas.o
>   CC      mipsn32-linux-user/cpu-exec-common.o
>   GEN     trace/generated-helpers.c
>   CC      mips-linux-user/trace/control-target.o
>   CC      mipsn32-linux-user/tcg/tcg.o
>   CC      mips-linux-user/trace/generated-helpers.o
>   CC      mipsn32el-linux-user/tcg-runtime.o
>   LINK    mips-linux-user/qemu-mips
>   GEN     nios2-linux-user/config-target.h
>   CC      mipsn32-linux-user/tcg/tcg-op.o
>   CC      nios2-linux-user/exec.o
>   CC      mipsn32el-linux-user/hax-stub.o
>   CC      mipsn32el-linux-user/kvm-stub.o
>   CC      mipsn32el-linux-user/gdbstub.o
>   CC      nios2-linux-user/translate-all.o
>   CC      mipsn32el-linux-user/thunk.o
>   CC      mipsn32el-linux-user/user-exec.o
>   CC      nios2-linux-user/cpu-exec.o
>   CC      mipsn32el-linux-user/user-exec-stub.o
>   GEN     or1k-linux-user/config-target.h
>   CC      mipsn32el-linux-user/linux-user/main.o
>   CC      or1k-linux-user/exec.o
>   CC      nios2-linux-user/translate-common.o
>   CC      or1k-linux-user/translate-all.o
>   CC      nios2-linux-user/cpu-exec-common.o
>   CC      mipsn32el-linux-user/linux-user/syscall.o
>   CC      nios2-linux-user/tcg/tcg.o
>   CC      mipsn32-linux-user/tcg/optimize.o
>   CC      or1k-linux-user/cpu-exec.o
>   CC      or1k-linux-user/translate-common.o
>   CC      or1k-linux-user/cpu-exec-common.o
>   CC      mipsn32-linux-user/tcg/tcg-common.o
>   CC      or1k-linux-user/tcg/tcg.o
>   CC      mipsn32-linux-user/fpu/softfloat.o
>   CC      nios2-linux-user/tcg/tcg-op.o
>   CC      mipsn32el-linux-user/linux-user/strace.o
>   CC      or1k-linux-user/tcg/tcg-op.o
>   CC      mipsn32el-linux-user/linux-user/mmap.o
>   CC      nios2-linux-user/tcg/optimize.o
>   CC      mipsn32el-linux-user/linux-user/signal.o
>   CC      mipsn32-linux-user/disas.o
>   CC      mipsn32-linux-user/tcg-runtime.o
>   CC      nios2-linux-user/tcg/tcg-common.o
>   CC      mipsn32el-linux-user/linux-user/elfload.o
>   CC      nios2-linux-user/fpu/softfloat.o
>   CC      or1k-linux-user/tcg/optimize.o
>   CC      mipsn32-linux-user/hax-stub.o
>   CC      mipsn32el-linux-user/linux-user/linuxload.o
>   CC      mipsn32-linux-user/kvm-stub.o
>   CC      mipsn32el-linux-user/linux-user/uaccess.o
>   CC      or1k-linux-user/tcg/tcg-common.o
>   CC      mipsn32-linux-user/gdbstub.o
>   CC      or1k-linux-user/fpu/softfloat.o
>   CC      mipsn32el-linux-user/linux-user/uname.o
>   CCAS    mipsn32el-linux-user/linux-user/safe-syscall.o
>   CC      mipsn32el-linux-user/target/mips/translate.o
>   CC      mipsn32-linux-user/thunk.o
>   CC      mipsn32-linux-user/user-exec.o
>   CC      nios2-linux-user/disas.o
>   CC      mipsn32-linux-user/user-exec-stub.o
>   CC      nios2-linux-user/tcg-runtime.o
>   CC      mipsn32-linux-user/linux-user/main.o
>   CC      nios2-linux-user/hax-stub.o
>   CC      nios2-linux-user/kvm-stub.o
>   CC      or1k-linux-user/disas.o
>   CC      nios2-linux-user/gdbstub.o
>   CC      mipsn32-linux-user/linux-user/syscall.o
>   CC      or1k-linux-user/tcg-runtime.o
>   CC      nios2-linux-user/thunk.o
>   CC      or1k-linux-user/hax-stub.o
>   CC      nios2-linux-user/user-exec.o
>   CC      or1k-linux-user/kvm-stub.o
>   CC      nios2-linux-user/user-exec-stub.o
>   CC      or1k-linux-user/gdbstub.o
>   CC      nios2-linux-user/linux-user/main.o
>   CC      or1k-linux-user/thunk.o
>   CC      nios2-linux-user/linux-user/syscall.o
>   CC      or1k-linux-user/user-exec.o
>   CC      mipsn32el-linux-user/target/mips/dsp_helper.o
>   CC      or1k-linux-user/user-exec-stub.o
>   CC      mipsn32-linux-user/linux-user/strace.o
>   CC      or1k-linux-user/linux-user/main.o
>   CC      mipsn32-linux-user/linux-user/mmap.o
>   CC      mipsn32el-linux-user/target/mips/op_helper.o
>   CC      or1k-linux-user/linux-user/syscall.o
>   CC      mipsn32-linux-user/linux-user/signal.o
>   CC      mipsn32-linux-user/linux-user/elfload.o
>   CC      nios2-linux-user/linux-user/strace.o
>   CC      mipsn32-linux-user/linux-user/linuxload.o
>   CC      mipsn32-linux-user/linux-user/uaccess.o
>   CC      nios2-linux-user/linux-user/mmap.o
>   CC      mipsn32el-linux-user/target/mips/lmi_helper.o
>   CC      nios2-linux-user/linux-user/signal.o
>   CC      mipsn32-linux-user/linux-user/uname.o
>   CCAS    mipsn32-linux-user/linux-user/safe-syscall.o
>   CC      mipsn32-linux-user/target/mips/translate.o
>   CC      mipsn32el-linux-user/target/mips/helper.o
>   CC      nios2-linux-user/linux-user/elfload.o
>   CC      mipsn32el-linux-user/target/mips/cpu.o
>   CC      or1k-linux-user/linux-user/strace.o
>   CC      mipsn32el-linux-user/target/mips/gdbstub.o
>   CC      nios2-linux-user/linux-user/linuxload.o
>   CC      mipsn32el-linux-user/target/mips/msa_helper.o
>   CC      or1k-linux-user/linux-user/mmap.o
>   CC      nios2-linux-user/linux-user/uaccess.o
>   CC      or1k-linux-user/linux-user/signal.o
>   CC      nios2-linux-user/linux-user/uname.o
>   CCAS    nios2-linux-user/linux-user/safe-syscall.o
>   CC      nios2-linux-user/target/nios2/translate.o
>   CC      or1k-linux-user/linux-user/elfload.o
>   CC      nios2-linux-user/target/nios2/op_helper.o
>   CC      or1k-linux-user/linux-user/linuxload.o
>   CC      nios2-linux-user/target/nios2/helper.o
>   CC      or1k-linux-user/linux-user/uaccess.o
>   CC      nios2-linux-user/target/nios2/cpu.o
>   CC      nios2-linux-user/target/nios2/mmu.o
>   CC      or1k-linux-user/linux-user/uname.o
>   GEN     trace/generated-helpers.c
>   CC      nios2-linux-user/trace/control-target.o
>   CCAS    or1k-linux-user/linux-user/safe-syscall.o
>   CC      or1k-linux-user/target/openrisc/cpu.o
>   CC      mipsn32el-linux-user/target/mips/mips-semi.o
>   CC      or1k-linux-user/target/openrisc/exception.o
>   CC      nios2-linux-user/trace/generated-helpers.o
>   GEN     trace/generated-helpers.c
>   CC      mipsn32-linux-user/target/mips/dsp_helper.o
>   CC      or1k-linux-user/target/openrisc/interrupt.o
>   CC      mipsn32el-linux-user/trace/control-target.o
>   LINK    nios2-linux-user/qemu-nios2
>   CC      mipsn32el-linux-user/trace/generated-helpers.o
>   CC      or1k-linux-user/target/openrisc/mmu.o
>   CC      mipsn32-linux-user/target/mips/op_helper.o
>   LINK    mipsn32el-linux-user/qemu-mipsn32el
>   CC      or1k-linux-user/target/openrisc/translate.o
>   CC      mipsn32-linux-user/target/mips/lmi_helper.o
>   CC      or1k-linux-user/target/openrisc/exception_helper.o
>   CC      mipsn32-linux-user/target/mips/helper.o
>   CC      or1k-linux-user/target/openrisc/fpu_helper.o
>   CC      or1k-linux-user/target/openrisc/interrupt_helper.o
>   CC      or1k-linux-user/target/openrisc/mmu_helper.o
>   GEN     ppc64abi32-linux-user/config-target.h
>   CC      ppc64abi32-linux-user/exec.o
>   GEN     ppc64le-linux-user/config-target.h
>   CC      or1k-linux-user/target/openrisc/sys_helper.o
>   CC      ppc64le-linux-user/exec.o
>   CC      or1k-linux-user/target/openrisc/gdbstub.o
>   CC      mipsn32-linux-user/target/mips/cpu.o
>   CC      ppc64abi32-linux-user/translate-all.o
>   CC      ppc64le-linux-user/translate-all.o
>   GEN     trace/generated-helpers.c
>   CC      or1k-linux-user/trace/control-target.o
>   CC      mipsn32-linux-user/target/mips/gdbstub.o
>   CC      ppc64le-linux-user/cpu-exec.o
>   CC      ppc64abi32-linux-user/cpu-exec.o
>   CC      or1k-linux-user/trace/generated-helpers.o
>   CC      mipsn32-linux-user/target/mips/msa_helper.o
>   LINK    or1k-linux-user/qemu-or1k
>   CC      ppc64abi32-linux-user/translate-common.o
>   CC      ppc64le-linux-user/translate-common.o
>   CC      ppc64abi32-linux-user/cpu-exec-common.o
>   CC      mipsn32-linux-user/target/mips/mips-semi.o
>   CC      ppc64le-linux-user/cpu-exec-common.o
>   CC      ppc64abi32-linux-user/tcg/tcg.o
>   CC      ppc64le-linux-user/tcg/tcg.o
>   GEN     ppc64-linux-user/config-target.h
>   CC      ppc64-linux-user/exec.o
>   CC      ppc64-linux-user/translate-all.o
>   CC      ppc64abi32-linux-user/tcg/tcg-op.o
>   CC      ppc64le-linux-user/tcg/tcg-op.o
>   CC      ppc64-linux-user/cpu-exec.o
>   GEN     trace/generated-helpers.c
>   CC      mipsn32-linux-user/trace/control-target.o
>   CC      ppc64-linux-user/translate-common.o
>   CC      ppc64-linux-user/cpu-exec-common.o
>   CC      mipsn32-linux-user/trace/generated-helpers.o
>   CC      ppc64-linux-user/tcg/tcg.o
>   LINK    mipsn32-linux-user/qemu-mipsn32
>   CC      ppc64le-linux-user/tcg/optimize.o
>   CC      ppc64-linux-user/tcg/tcg-op.o
>   CC      ppc64abi32-linux-user/tcg/optimize.o
>   CC      ppc64abi32-linux-user/tcg/tcg-common.o
>   CC      ppc64abi32-linux-user/fpu/softfloat.o
>   CC      ppc64le-linux-user/tcg/tcg-common.o
>   CC      ppc64le-linux-user/fpu/softfloat.o
>   GEN     ppc-linux-user/config-target.h
>   CC      ppc-linux-user/exec.o
>   CC      ppc-linux-user/translate-all.o
>   CC      ppc64-linux-user/tcg/optimize.o
>   CC      ppc-linux-user/cpu-exec.o
>   CC      ppc-linux-user/translate-common.o
>   CC      ppc64abi32-linux-user/disas.o
>   CC      ppc-linux-user/cpu-exec-common.o
>   CC      ppc64abi32-linux-user/tcg-runtime.o
>   CC      ppc64-linux-user/tcg/tcg-common.o
>   CC      ppc-linux-user/tcg/tcg.o
>   GEN     ppc64abi32-linux-user/gdbstub-xml.c
>   CC      ppc64-linux-user/fpu/softfloat.o
>   CC      ppc64le-linux-user/disas.o
>   CC      ppc64abi32-linux-user/hax-stub.o
>   CC      ppc64abi32-linux-user/kvm-stub.o
>   CC      ppc64le-linux-user/tcg-runtime.o
>   CC      ppc64abi32-linux-user/libdecnumber/decContext.o
>   GEN     ppc64le-linux-user/gdbstub-xml.c
>   CC      ppc64le-linux-user/hax-stub.o
>   CC      ppc64abi32-linux-user/libdecnumber/decNumber.o
>   CC      ppc-linux-user/tcg/tcg-op.o
>   CC      ppc64le-linux-user/kvm-stub.o
>   CC      ppc64le-linux-user/libdecnumber/decContext.o
>   CC      ppc64le-linux-user/libdecnumber/decNumber.o
>   CC      ppc64-linux-user/disas.o
>   CC      ppc64abi32-linux-user/libdecnumber/dpd/decimal32.o
>   CC      ppc64-linux-user/tcg-runtime.o
>   CC      ppc64abi32-linux-user/libdecnumber/dpd/decimal64.o
>   CC      ppc64abi32-linux-user/libdecnumber/dpd/decimal128.o
>   CC      ppc64le-linux-user/libdecnumber/dpd/decimal32.o
>   CC      ppc-linux-user/tcg/optimize.o
>   GEN     ppc64-linux-user/gdbstub-xml.c
>   CC      ppc64abi32-linux-user/gdbstub.o
>   CC      ppc64le-linux-user/libdecnumber/dpd/decimal64.o
>   CC      ppc64le-linux-user/libdecnumber/dpd/decimal128.o
>   CC      ppc64abi32-linux-user/thunk.o
>   CC      ppc64le-linux-user/gdbstub.o
>   CC      ppc64-linux-user/hax-stub.o
>   CC      ppc64abi32-linux-user/user-exec.o
>   CC      ppc-linux-user/tcg/tcg-common.o
>   CC      ppc64-linux-user/kvm-stub.o
>   CC      ppc64abi32-linux-user/user-exec-stub.o
>   CC      ppc64le-linux-user/thunk.o
>   CC      ppc-linux-user/fpu/softfloat.o
>   CC      ppc64abi32-linux-user/linux-user/main.o
>   CC      ppc64-linux-user/libdecnumber/decContext.o
>   CC      ppc64le-linux-user/user-exec.o
>   CC      ppc64-linux-user/libdecnumber/decNumber.o
>   CC      ppc64le-linux-user/user-exec-stub.o
>   CC      ppc64abi32-linux-user/linux-user/syscall.o
>   CC      ppc64le-linux-user/linux-user/main.o
>   CC      ppc64le-linux-user/linux-user/syscall.o
>   CC      ppc64-linux-user/libdecnumber/dpd/decimal32.o
>   CC      ppc64-linux-user/libdecnumber/dpd/decimal64.o
>   CC      ppc-linux-user/disas.o
>   CC      ppc64-linux-user/libdecnumber/dpd/decimal128.o
>   CC      ppc-linux-user/tcg-runtime.o
>   CC      ppc64-linux-user/gdbstub.o
>   CC      ppc64abi32-linux-user/linux-user/strace.o
>   CC      ppc64-linux-user/thunk.o
>   GEN     ppc-linux-user/gdbstub-xml.c
>   CC      ppc64-linux-user/user-exec.o
>   CC      ppc-linux-user/hax-stub.o
>   CC      ppc-linux-user/kvm-stub.o
>   CC      ppc64abi32-linux-user/linux-user/mmap.o
>   CC      ppc64-linux-user/user-exec-stub.o
>   CC      ppc-linux-user/libdecnumber/decContext.o
>   CC      ppc64-linux-user/linux-user/main.o
>   CC      ppc-linux-user/libdecnumber/decNumber.o
>   CC      ppc64le-linux-user/linux-user/strace.o
>   CC      ppc64abi32-linux-user/linux-user/signal.o
>   CC      ppc64-linux-user/linux-user/syscall.o
>   CC      ppc64abi32-linux-user/linux-user/elfload.o
>   CC      ppc64le-linux-user/linux-user/mmap.o
>   CC      ppc64le-linux-user/linux-user/signal.o
>   CC      ppc-linux-user/libdecnumber/dpd/decimal32.o
>   CC      ppc-linux-user/libdecnumber/dpd/decimal64.o
>   CC      ppc64le-linux-user/linux-user/elfload.o
>   CC      ppc64abi32-linux-user/linux-user/linuxload.o
>   CC      ppc-linux-user/libdecnumber/dpd/decimal128.o
>   CC      ppc64abi32-linux-user/linux-user/uaccess.o
>   CC      ppc-linux-user/gdbstub.o
>   CC      ppc64abi32-linux-user/linux-user/uname.o
>   CC      ppc64le-linux-user/linux-user/linuxload.o
>   CCAS    ppc64abi32-linux-user/linux-user/safe-syscall.o
>   CC      ppc64abi32-linux-user/target/ppc/cpu-models.o
>   CC      ppc-linux-user/thunk.o
>   CC      ppc64le-linux-user/linux-user/uaccess.o
>   CC      ppc-linux-user/user-exec.o
>   CC      ppc64le-linux-user/linux-user/uname.o
>   CC      ppc64-linux-user/linux-user/strace.o
>   CCAS    ppc64le-linux-user/linux-user/safe-syscall.o
>   CC      ppc-linux-user/user-exec-stub.o
>   CC      ppc64le-linux-user/target/ppc/cpu-models.o
>   CC      ppc-linux-user/linux-user/main.o
>   CC      ppc64-linux-user/linux-user/mmap.o
>   CC      ppc64abi32-linux-user/target/ppc/cpu.o
>   CC      ppc-linux-user/linux-user/syscall.o
>   CC      ppc64-linux-user/linux-user/signal.o
>   CC      ppc64abi32-linux-user/target/ppc/translate.o
>   CC      ppc64-linux-user/linux-user/elfload.o
>   CC      ppc64le-linux-user/target/ppc/cpu.o
>   CC      ppc64le-linux-user/target/ppc/translate.o
>   CC      ppc64-linux-user/linux-user/linuxload.o
>   CC      ppc64-linux-user/linux-user/uaccess.o
>   CC      ppc64-linux-user/linux-user/uname.o
>   CCAS    ppc64-linux-user/linux-user/safe-syscall.o
>   CC      ppc64-linux-user/target/ppc/cpu-models.o
>   CC      ppc-linux-user/linux-user/strace.o
>   CC      ppc64-linux-user/target/ppc/cpu.o
>   CC      ppc64-linux-user/target/ppc/translate.o
>   CC      ppc-linux-user/linux-user/mmap.o
>   CC      ppc-linux-user/linux-user/signal.o
>   CC      ppc-linux-user/linux-user/elfload.o
>   CC      ppc-linux-user/linux-user/linuxload.o
>   CC      ppc-linux-user/linux-user/uaccess.o
>   CC      ppc-linux-user/linux-user/uname.o
>   CCAS    ppc-linux-user/linux-user/safe-syscall.o
>   CC      ppc-linux-user/target/ppc/cpu-models.o
>   CC      ppc-linux-user/target/ppc/cpu.o
>   CC      ppc-linux-user/target/ppc/translate.o
>   CC      ppc64abi32-linux-user/target/ppc/kvm-stub.o
>   CC      ppc64abi32-linux-user/target/ppc/dfp_helper.o
>   CC      ppc64le-linux-user/target/ppc/kvm-stub.o
>   CC      ppc64le-linux-user/target/ppc/dfp_helper.o
>   CC      ppc64abi32-linux-user/target/ppc/excp_helper.o
>   CC      ppc64abi32-linux-user/target/ppc/fpu_helper.o
>   CC      ppc64le-linux-user/target/ppc/excp_helper.o
>   CC      ppc64le-linux-user/target/ppc/fpu_helper.o
>   CC      ppc64-linux-user/target/ppc/kvm-stub.o
>   CC      ppc64-linux-user/target/ppc/dfp_helper.o
>   CC      ppc64-linux-user/target/ppc/excp_helper.o
>   CC      ppc64-linux-user/target/ppc/fpu_helper.o
>   CC      ppc64le-linux-user/target/ppc/int_helper.o
>   CC      ppc64abi32-linux-user/target/ppc/int_helper.o
>   CC      ppc64le-linux-user/target/ppc/timebase_helper.o
>   CC      ppc64le-linux-user/target/ppc/misc_helper.o
>   CC      ppc64le-linux-user/target/ppc/mem_helper.o
>   CC      ppc64abi32-linux-user/target/ppc/timebase_helper.o
>   CC      ppc64le-linux-user/target/ppc/user_only_helper.o
>   CC      ppc64abi32-linux-user/target/ppc/misc_helper.o
>   CC      ppc64le-linux-user/target/ppc/gdbstub.o
>   CC      ppc64abi32-linux-user/target/ppc/mem_helper.o
>   GEN     trace/generated-helpers.c
>   CC      ppc64le-linux-user/trace/control-target.o
>   CC      ppc64-linux-user/target/ppc/int_helper.o
>   CC      ppc64abi32-linux-user/target/ppc/user_only_helper.o
>   CC      ppc64le-linux-user/gdbstub-xml.o
>   CC      ppc-linux-user/target/ppc/kvm-stub.o
>   CC      ppc64abi32-linux-user/target/ppc/gdbstub.o
>   CC      ppc64le-linux-user/trace/generated-helpers.o
>   CC      ppc-linux-user/target/ppc/dfp_helper.o
>   GEN     trace/generated-helpers.c
>   CC      ppc64abi32-linux-user/trace/control-target.o
>   LINK    ppc64le-linux-user/qemu-ppc64le
>   CC      ppc64abi32-linux-user/gdbstub-xml.o
>   CC      ppc64-linux-user/target/ppc/timebase_helper.o
>   CC      ppc64abi32-linux-user/trace/generated-helpers.o
>   CC      ppc64-linux-user/target/ppc/misc_helper.o
>   CC      ppc-linux-user/target/ppc/excp_helper.o
>   LINK    ppc64abi32-linux-user/qemu-ppc64abi32
>   CC      ppc-linux-user/target/ppc/fpu_helper.o
>   CC      ppc64-linux-user/target/ppc/mem_helper.o
>   CC      s390x-linux-user/gen-features
>   GEN     s390x-linux-user/config-target.h
>   GEN     s390x-linux-user/gen-features.h
>   CC      s390x-linux-user/exec.o
>   CC      ppc-linux-user/target/ppc/int_helper.o
>   CC      ppc64-linux-user/target/ppc/user_only_helper.o
>   CC      s390x-linux-user/translate-all.o
>   CC      ppc64-linux-user/target/ppc/gdbstub.o
>   CC      s390x-linux-user/cpu-exec.o
>   GEN     trace/generated-helpers.c
>   CC      ppc64-linux-user/trace/control-target.o
>   CC      s390x-linux-user/translate-common.o
>   CC      ppc64-linux-user/gdbstub-xml.o
>   CC      s390x-linux-user/cpu-exec-common.o
>   CC      s390x-linux-user/tcg/tcg.o
>   CC      ppc64-linux-user/trace/generated-helpers.o
>   CC      ppc-linux-user/target/ppc/timebase_helper.o
>   LINK    ppc64-linux-user/qemu-ppc64
>   CC      s390x-linux-user/tcg/tcg-op.o
>   CC      s390x-linux-user/tcg/optimize.o
>   GEN     sh4-linux-user/config-target.h
>   CC      sh4-linux-user/exec.o
>   GEN     sh4eb-linux-user/config-target.h
>   CC      ppc-linux-user/target/ppc/misc_helper.o
>   CC      sh4eb-linux-user/exec.o
>   CC      sh4-linux-user/translate-all.o
>   CC      ppc-linux-user/target/ppc/mem_helper.o
>   CC      sh4eb-linux-user/translate-all.o
>   CC      ppc-linux-user/target/ppc/user_only_helper.o
>   CC      sh4-linux-user/cpu-exec.o
>   CC      ppc-linux-user/target/ppc/gdbstub.o
>   CC      sh4eb-linux-user/cpu-exec.o
>   CC      s390x-linux-user/tcg/tcg-common.o
>   CC      sh4-linux-user/translate-common.o
>   GEN     trace/generated-helpers.c
>   CC      s390x-linux-user/fpu/softfloat.o
>   CC      ppc-linux-user/trace/control-target.o
>   CC      sh4eb-linux-user/translate-common.o
>   CC      sh4-linux-user/cpu-exec-common.o
>   CC      sh4eb-linux-user/cpu-exec-common.o
>   CC      sh4-linux-user/tcg/tcg.o
>   CC      ppc-linux-user/gdbstub-xml.o
>   CC      sh4eb-linux-user/tcg/tcg.o
>   CC      ppc-linux-user/trace/generated-helpers.o
>   LINK    ppc-linux-user/qemu-ppc
>   CC      sh4-linux-user/tcg/tcg-op.o
>   CC      s390x-linux-user/disas.o
>   CC      sh4-linux-user/tcg/optimize.o
>   CC      sh4eb-linux-user/tcg/tcg-op.o
>   CC      s390x-linux-user/tcg-runtime.o
>   CC      sh4eb-linux-user/tcg/optimize.o
>   GEN     s390x-linux-user/gdbstub-xml.c
>   CC      sh4-linux-user/tcg/tcg-common.o
>   CC      s390x-linux-user/hax-stub.o
>   CC      sh4eb-linux-user/tcg/tcg-common.o
>   CC      sh4-linux-user/fpu/softfloat.o
>   CC      sh4eb-linux-user/fpu/softfloat.o
>   CC      s390x-linux-user/kvm-stub.o
>   CC      sh4eb-linux-user/disas.o
>   CC      s390x-linux-user/gdbstub.o
>   CC      s390x-linux-user/thunk.o
>   CC      sh4eb-linux-user/tcg-runtime.o
>   CC      s390x-linux-user/user-exec.o
>   CC      s390x-linux-user/user-exec-stub.o
>   CC      sh4eb-linux-user/hax-stub.o
>   CC      s390x-linux-user/linux-user/main.o
>   CC      sh4eb-linux-user/kvm-stub.o
>   CC      s390x-linux-user/linux-user/syscall.o
>   CC      sh4eb-linux-user/gdbstub.o
>   CC      sh4-linux-user/disas.o
>   CC      s390x-linux-user/linux-user/strace.o
>   CC      sh4-linux-user/tcg-runtime.o
>   CC      sh4eb-linux-user/thunk.o
>   CC      s390x-linux-user/linux-user/mmap.o
>   CC      sh4eb-linux-user/user-exec.o
>   CC      sh4-linux-user/hax-stub.o
>   CC      sh4eb-linux-user/user-exec-stub.o
>   CC      sh4eb-linux-user/linux-user/main.o
>   CC      sh4-linux-user/kvm-stub.o
>   CC      sh4eb-linux-user/linux-user/syscall.o
>   CC      sh4-linux-user/gdbstub.o
>   CC      sh4eb-linux-user/linux-user/strace.o
>   CC      sh4-linux-user/thunk.o
>   CC      s390x-linux-user/linux-user/signal.o
>   CC      sh4eb-linux-user/linux-user/mmap.o
>   CC      sh4-linux-user/user-exec.o
>   CC      sh4-linux-user/user-exec-stub.o
>   CC      s390x-linux-user/linux-user/elfload.o
>   CC      sh4-linux-user/linux-user/main.o
>   CC      s390x-linux-user/linux-user/linuxload.o
>   CC      sh4-linux-user/linux-user/syscall.o
>   GEN     sparc32plus-linux-user/config-target.h
>   CC      sparc32plus-linux-user/exec.o
>   CC      s390x-linux-user/linux-user/uaccess.o
>   CC      sparc32plus-linux-user/translate-all.o
>   CC      s390x-linux-user/linux-user/uname.o
>   CCAS    s390x-linux-user/linux-user/safe-syscall.o
>   CC      s390x-linux-user/target/s390x/translate.o
>   CC      sh4eb-linux-user/linux-user/signal.o
>   CC      sparc32plus-linux-user/cpu-exec.o
>   CC      sh4eb-linux-user/linux-user/elfload.o
>   CC      sparc32plus-linux-user/translate-common.o
>   CC      sparc32plus-linux-user/cpu-exec-common.o
>   CC      sparc32plus-linux-user/tcg/tcg.o
>   CC      sh4eb-linux-user/linux-user/linuxload.o
>   CC      sh4eb-linux-user/linux-user/uaccess.o
>   CC      s390x-linux-user/target/s390x/helper.o
>   CC      sh4eb-linux-user/linux-user/uname.o
>   CC      sh4-linux-user/linux-user/strace.o
>   CC      s390x-linux-user/target/s390x/cpu.o
>   CCAS    sh4eb-linux-user/linux-user/safe-syscall.o
>   CC      sparc32plus-linux-user/tcg/tcg-op.o
>   CC      sh4eb-linux-user/linux-user/flatload.o
>   CC      s390x-linux-user/target/s390x/interrupt.o
>   CC      sh4-linux-user/linux-user/mmap.o
>   CC      sh4eb-linux-user/target/sh4/translate.o
>   CC      s390x-linux-user/target/s390x/int_helper.o
>   CC      sh4-linux-user/linux-user/signal.o
>   CC      s390x-linux-user/target/s390x/fpu_helper.o
>   CC      s390x-linux-user/target/s390x/cc_helper.o
>   CC      sh4-linux-user/linux-user/elfload.o
>   CC      sparc32plus-linux-user/tcg/optimize.o
>   CC      s390x-linux-user/target/s390x/mem_helper.o
>   CC      s390x-linux-user/target/s390x/misc_helper.o
>   CC      sparc32plus-linux-user/tcg/tcg-common.o
>   CC      sh4-linux-user/linux-user/linuxload.o
>   CC      sh4eb-linux-user/target/sh4/op_helper.o
>   CC      s390x-linux-user/target/s390x/gdbstub.o
>   CC      sparc32plus-linux-user/fpu/softfloat.o
>   CC      sh4-linux-user/linux-user/uaccess.o
>   CC      s390x-linux-user/target/s390x/cpu_models.o
>   CC      sh4-linux-user/linux-user/uname.o
>   CC      sh4eb-linux-user/target/sh4/helper.o
>   CCAS    sh4-linux-user/linux-user/safe-syscall.o
>   CC      sh4-linux-user/linux-user/flatload.o
>   CC      s390x-linux-user/target/s390x/cpu_features.o
>   CC      sh4eb-linux-user/target/sh4/cpu.o
>   GEN     trace/generated-helpers.c
>   CC      s390x-linux-user/trace/control-target.o
>   CC      sh4-linux-user/target/sh4/translate.o
>   CC      s390x-linux-user/gdbstub-xml.o
>   CC      sh4eb-linux-user/target/sh4/gdbstub.o
>   CC      s390x-linux-user/trace/generated-helpers.o
>   GEN     trace/generated-helpers.c
>   CC      sh4eb-linux-user/trace/control-target.o
>   LINK    s390x-linux-user/qemu-s390x
>   CC      sh4eb-linux-user/trace/generated-helpers.o
>   LINK    sh4eb-linux-user/qemu-sh4eb
>   CC      sparc32plus-linux-user/disas.o
>   CC      sparc32plus-linux-user/tcg-runtime.o
>   GEN     sparc64-linux-user/config-target.h
>   CC      sparc64-linux-user/exec.o
>   GEN     sparc-linux-user/config-target.h
>   CC      sparc-linux-user/exec.o
>   CC      sparc64-linux-user/translate-all.o
>   CC      sparc-linux-user/translate-all.o
>   CC      sparc32plus-linux-user/hax-stub.o
>   CC      sh4-linux-user/target/sh4/op_helper.o
>   CC      sparc-linux-user/cpu-exec.o
>   CC      sparc64-linux-user/cpu-exec.o
>   CC      sparc32plus-linux-user/kvm-stub.o
>   CC      sh4-linux-user/target/sh4/helper.o
>   CC      sparc64-linux-user/translate-common.o
>   CC      sparc-linux-user/translate-common.o
>   CC      sparc32plus-linux-user/gdbstub.o
>   CC      sparc-linux-user/cpu-exec-common.o
>   CC      sparc64-linux-user/cpu-exec-common.o
>   CC      sh4-linux-user/target/sh4/cpu.o
>   CC      sparc-linux-user/tcg/tcg.o
>   CC      sparc32plus-linux-user/thunk.o
>   CC      sparc64-linux-user/tcg/tcg.o
>   CC      sh4-linux-user/target/sh4/gdbstub.o
>   CC      sparc32plus-linux-user/user-exec.o
>   GEN     trace/generated-helpers.c
>   CC      sh4-linux-user/trace/control-target.o
>   CC      sparc32plus-linux-user/user-exec-stub.o
>   CC      sparc32plus-linux-user/linux-user/main.o
>   CC      sh4-linux-user/trace/generated-helpers.o
>   CC      sparc32plus-linux-user/linux-user/syscall.o
>   CC      sparc-linux-user/tcg/tcg-op.o
>   LINK    sh4-linux-user/qemu-sh4
>   CC      sparc64-linux-user/tcg/tcg-op.o
>   CC      sparc32plus-linux-user/linux-user/strace.o
>   GEN     tilegx-linux-user/config-target.h
>   CC      tilegx-linux-user/exec.o
>   CC      sparc-linux-user/tcg/optimize.o
>   CC      sparc64-linux-user/tcg/optimize.o
>   CC      tilegx-linux-user/translate-all.o
>   CC      sparc32plus-linux-user/linux-user/mmap.o
>   CC      tilegx-linux-user/cpu-exec.o
>   CC      sparc-linux-user/tcg/tcg-common.o
>   CC      sparc32plus-linux-user/linux-user/signal.o
>   CC      sparc-linux-user/fpu/softfloat.o
>   CC      sparc64-linux-user/tcg/tcg-common.o
>   CC      tilegx-linux-user/translate-common.o
>   CC      sparc32plus-linux-user/linux-user/elfload.o
>   CC      sparc64-linux-user/fpu/softfloat.o
>   CC      tilegx-linux-user/cpu-exec-common.o
>   CC      sparc32plus-linux-user/linux-user/linuxload.o
>   CC      tilegx-linux-user/tcg/tcg.o
>   CC      sparc32plus-linux-user/linux-user/uaccess.o
>   CC      sparc32plus-linux-user/linux-user/uname.o
>   CCAS    sparc32plus-linux-user/linux-user/safe-syscall.o
>   CC      tilegx-linux-user/tcg/tcg-op.o
>   CC      sparc32plus-linux-user/target/sparc/translate.o
>   CC      sparc-linux-user/disas.o
>   CC      sparc-linux-user/tcg-runtime.o
>   CC      sparc64-linux-user/disas.o
>   CC      sparc64-linux-user/tcg-runtime.o
>   CC      sparc-linux-user/hax-stub.o
>   CC      sparc-linux-user/kvm-stub.o
>   CC      sparc-linux-user/gdbstub.o
>   CC      sparc64-linux-user/hax-stub.o
>   CC      sparc64-linux-user/kvm-stub.o
>   CC      sparc32plus-linux-user/target/sparc/helper.o
>   CC      sparc-linux-user/thunk.o
>   CC      sparc64-linux-user/gdbstub.o
>   CC      sparc32plus-linux-user/target/sparc/cpu.o
>   CC      tilegx-linux-user/tcg/optimize.o
>   CC      sparc-linux-user/user-exec.o
>   CC      sparc32plus-linux-user/target/sparc/fop_helper.o
>   CC      sparc-linux-user/user-exec-stub.o
>   CC      sparc64-linux-user/thunk.o
>   CC      sparc-linux-user/linux-user/main.o
>   CC      sparc32plus-linux-user/target/sparc/cc_helper.o
>   CC      tilegx-linux-user/tcg/tcg-common.o
>   CC      tilegx-linux-user/fpu/softfloat.o
>   CC      sparc64-linux-user/user-exec.o
>   CC      sparc32plus-linux-user/target/sparc/win_helper.o
>   CC      sparc64-linux-user/user-exec-stub.o
>   CC      sparc-linux-user/linux-user/syscall.o
>   CC      sparc64-linux-user/linux-user/main.o
>   CC      sparc32plus-linux-user/target/sparc/mmu_helper.o
>   CC      sparc32plus-linux-user/target/sparc/ldst_helper.o
>   CC      sparc32plus-linux-user/target/sparc/int64_helper.o
>   CC      sparc64-linux-user/linux-user/syscall.o
>   CC      sparc32plus-linux-user/target/sparc/vis_helper.o
>   CC      sparc32plus-linux-user/target/sparc/gdbstub.o
>   CC      tilegx-linux-user/disas.o
>   GEN     trace/generated-helpers.c
>   CC      sparc32plus-linux-user/trace/control-target.o
>   CC      tilegx-linux-user/tcg-runtime.o
>   CC      sparc32plus-linux-user/trace/generated-helpers.o
>   CC      tilegx-linux-user/hax-stub.o
>   LINK    sparc32plus-linux-user/qemu-sparc32plus
>   CC      sparc-linux-user/linux-user/strace.o
>   CC      tilegx-linux-user/kvm-stub.o
>   CC      sparc-linux-user/linux-user/mmap.o
>   CC      tilegx-linux-user/gdbstub.o
>   CC      sparc64-linux-user/linux-user/strace.o
>   CC      sparc-linux-user/linux-user/signal.o
>   CC      tilegx-linux-user/thunk.o
>   CC      sparc-linux-user/linux-user/elfload.o
>   CC      tilegx-linux-user/user-exec.o
>   CC      sparc64-linux-user/linux-user/mmap.o
>   CC      sparc-linux-user/linux-user/linuxload.o
>   CC      tilegx-linux-user/user-exec-stub.o
>   CC      sparc64-linux-user/linux-user/signal.o
>   CC      sparc-linux-user/linux-user/uaccess.o
>   CC      tilegx-linux-user/linux-user/main.o
>   CC      sparc-linux-user/linux-user/uname.o
>   CC      tilegx-linux-user/linux-user/syscall.o
>   CC      sparc64-linux-user/linux-user/elfload.o
>   CCAS    sparc-linux-user/linux-user/safe-syscall.o
>   CC      sparc-linux-user/target/sparc/translate.o
>   CC      sparc-linux-user/target/sparc/helper.o
>   CC      sparc64-linux-user/linux-user/linuxload.o
>   CC      sparc-linux-user/target/sparc/cpu.o
>   CC      sparc64-linux-user/linux-user/uaccess.o
>   CC      sparc-linux-user/target/sparc/fop_helper.o
>   CC      sparc64-linux-user/linux-user/uname.o
>   CCAS    sparc64-linux-user/linux-user/safe-syscall.o
>   CC      sparc-linux-user/target/sparc/cc_helper.o
>   CC      sparc64-linux-user/target/sparc/translate.o
>   CC      sparc64-linux-user/target/sparc/helper.o
>   CC      sparc64-linux-user/target/sparc/cpu.o
>   CC      sparc-linux-user/target/sparc/win_helper.o
>   CC      sparc64-linux-user/target/sparc/fop_helper.o
>   CC      sparc-linux-user/target/sparc/mmu_helper.o
>   CC      sparc-linux-user/target/sparc/ldst_helper.o
>   CC      sparc64-linux-user/target/sparc/cc_helper.o
>   CC      sparc-linux-user/target/sparc/int32_helper.o
>   CC      tilegx-linux-user/linux-user/strace.o
>   CC      sparc-linux-user/target/sparc/gdbstub.o
>   CC      tilegx-linux-user/linux-user/mmap.o
>   GEN     trace/generated-helpers.c
>   CC      sparc-linux-user/trace/control-target.o
>   CC      sparc64-linux-user/target/sparc/win_helper.o
>   CC      tilegx-linux-user/linux-user/signal.o
>   CC      sparc-linux-user/trace/generated-helpers.o
>   CC      sparc64-linux-user/target/sparc/mmu_helper.o
>   CC      tilegx-linux-user/linux-user/elfload.o
>   LINK    sparc-linux-user/qemu-sparc
>   CC      sparc64-linux-user/target/sparc/ldst_helper.o
>   CC      tilegx-linux-user/linux-user/linuxload.o
>   CC      sparc64-linux-user/target/sparc/int64_helper.o
>   CC      tilegx-linux-user/linux-user/uaccess.o
>   CC      tilegx-linux-user/linux-user/uname.o
>   GEN     x86_64-linux-user/config-target.h
>   CC      sparc64-linux-user/target/sparc/vis_helper.o
>   CCAS    tilegx-linux-user/linux-user/safe-syscall.o
>   CC      x86_64-linux-user/translate-all.o
>   CC      x86_64-linux-user/exec.o
>   CC      tilegx-linux-user/target/tilegx/cpu.o
>   CC      sparc64-linux-user/target/sparc/gdbstub.o
>   CC      x86_64-linux-user/cpu-exec.o
>   CC      tilegx-linux-user/target/tilegx/translate.o
>   GEN     trace/generated-helpers.c
>   CC      sparc64-linux-user/trace/control-target.o
>   CC      x86_64-linux-user/translate-common.o
>   CC      x86_64-linux-user/cpu-exec-common.o
>   CC      x86_64-linux-user/tcg/tcg.o
>   CC      sparc64-linux-user/trace/generated-helpers.o
>   CC      x86_64-linux-user/tcg/tcg-op.o
>   LINK    sparc64-linux-user/qemu-sparc64
>   CC      tilegx-linux-user/target/tilegx/helper.o
>   CC      tilegx-linux-user/target/tilegx/simd_helper.o
>   GEN     trace/generated-helpers.c
>   CC      tilegx-linux-user/trace/control-target.o
>   CC      x86_64-linux-user/tcg/optimize.o
>   CC      tilegx-linux-user/trace/generated-helpers.o
>   CC      x86_64-linux-user/tcg/tcg-common.o
>   LINK    tilegx-linux-user/qemu-tilegx
>   CC      x86_64-linux-user/fpu/softfloat.o
>   CC      x86_64-linux-user/disas.o
>   CC      x86_64-linux-user/tcg-runtime.o
>   CC      x86_64-linux-user/hax-stub.o
>   CC      x86_64-linux-user/kvm-stub.o
>   CC      x86_64-linux-user/gdbstub.o
>   CC      x86_64-linux-user/thunk.o
>   CC      x86_64-linux-user/user-exec.o
>   CC      x86_64-linux-user/user-exec-stub.o
>   CC      x86_64-linux-user/linux-user/main.o
>   CC      x86_64-linux-user/linux-user/syscall.o
>   CC      x86_64-linux-user/linux-user/strace.o
>   CC      x86_64-linux-user/linux-user/mmap.o
>   CC      x86_64-linux-user/linux-user/signal.o
>   CC      x86_64-linux-user/linux-user/elfload.o
>   CC      x86_64-linux-user/linux-user/linuxload.o
>   CC      x86_64-linux-user/linux-user/uaccess.o
>   CC      x86_64-linux-user/linux-user/uname.o
>   CCAS    x86_64-linux-user/linux-user/safe-syscall.o
>   CC      x86_64-linux-user/target/i386/translate.o
>   CC      x86_64-linux-user/target/i386/helper.o
>   CC      x86_64-linux-user/target/i386/cpu.o
>   CC      x86_64-linux-user/target/i386/bpt_helper.o
>   CC      x86_64-linux-user/target/i386/excp_helper.o
>   CC      x86_64-linux-user/target/i386/fpu_helper.o
>   CC      x86_64-linux-user/target/i386/cc_helper.o
>   CC      x86_64-linux-user/target/i386/int_helper.o
>   CC      x86_64-linux-user/target/i386/svm_helper.o
>   CC      x86_64-linux-user/target/i386/smm_helper.o
>   CC      x86_64-linux-user/target/i386/misc_helper.o
>   CC      x86_64-linux-user/target/i386/mem_helper.o
>   CC      x86_64-linux-user/target/i386/seg_helper.o
>   CC      x86_64-linux-user/target/i386/mpx_helper.o
>   CC      x86_64-linux-user/target/i386/gdbstub.o
>   CC      x86_64-linux-user/target/i386/kvm-stub.o
>   GEN     trace/generated-helpers.c
>   CC      x86_64-linux-user/trace/control-target.o
>   CC      x86_64-linux-user/trace/generated-helpers.o
>   LINK    x86_64-linux-user/qemu-x86_64
>   TEST    tests/qapi-schema/alternate-array.out
>   TEST    tests/qapi-schema/alternate-clash.out
>   TEST    tests/qapi-schema/alternate-base.out
>   TEST    tests/qapi-schema/alternate-any.out
>   TEST    tests/qapi-schema/alternate-conflict-dict.out
>   TEST    tests/qapi-schema/alternate-conflict-string.out
>   TEST    tests/qapi-schema/alternate-empty.out
>   TEST    tests/qapi-schema/alternate-nested.out
>   TEST    tests/qapi-schema/alternate-unknown.out
>   TEST    tests/qapi-schema/args-alternate.out
>   TEST    tests/qapi-schema/args-any.out
>   TEST    tests/qapi-schema/args-array-empty.out
>   TEST    tests/qapi-schema/args-array-unknown.out
>   TEST    tests/qapi-schema/args-bad-boxed.out
>   TEST    tests/qapi-schema/args-boxed-empty.out
>   TEST    tests/qapi-schema/args-boxed-anon.out
>   TEST    tests/qapi-schema/args-boxed-string.out
>   TEST    tests/qapi-schema/args-int.out
>   TEST    tests/qapi-schema/args-invalid.out
>   TEST    tests/qapi-schema/args-member-array-bad.out
>   TEST    tests/qapi-schema/args-member-case.out
>   TEST    tests/qapi-schema/args-member-unknown.out
>   TEST    tests/qapi-schema/args-name-clash.out
>   TEST    tests/qapi-schema/args-union.out
>   TEST    tests/qapi-schema/args-unknown.out
>   TEST    tests/qapi-schema/bad-base.out
>   TEST    tests/qapi-schema/bad-data.out
>   TEST    tests/qapi-schema/bad-ident.out
>   TEST    tests/qapi-schema/bad-type-bool.out
>   TEST    tests/qapi-schema/bad-type-dict.out
>   TEST    tests/qapi-schema/bad-type-int.out
>   TEST    tests/qapi-schema/base-cycle-direct.out
>   TEST    tests/qapi-schema/base-cycle-indirect.out
>   TEST    tests/qapi-schema/command-int.out
>   TEST    tests/qapi-schema/comments.out
>   TEST    tests/qapi-schema/doc-bad-args.out
>   TEST    tests/qapi-schema/doc-bad-symbol.out
>   TEST    tests/qapi-schema/doc-duplicated-arg.out
>   TEST    tests/qapi-schema/doc-duplicated-return.out
>   TEST    tests/qapi-schema/doc-duplicated-since.out
>   TEST    tests/qapi-schema/doc-empty-section.out
>   TEST    tests/qapi-schema/doc-empty-arg.out
>   TEST    tests/qapi-schema/doc-empty-symbol.out
>   TEST    tests/qapi-schema/doc-interleaved-section.out
>   TEST    tests/qapi-schema/doc-invalid-end.out
>   TEST    tests/qapi-schema/doc-invalid-return.out
>   TEST    tests/qapi-schema/doc-invalid-end2.out
>   TEST    tests/qapi-schema/doc-invalid-start.out
>   TEST    tests/qapi-schema/doc-invalid-section.out
>   TEST    tests/qapi-schema/doc-missing-colon.out
>   TEST    tests/qapi-schema/doc-missing-expr.out
>   TEST    tests/qapi-schema/doc-optional.out
>   TEST    tests/qapi-schema/doc-missing-space.out
>   TEST    tests/qapi-schema/double-data.out
>   TEST    tests/qapi-schema/double-type.out
>   TEST    tests/qapi-schema/duplicate-key.out
>   TEST    tests/qapi-schema/empty.out
>   TEST    tests/qapi-schema/enum-bad-name.out
>   TEST    tests/qapi-schema/enum-bad-prefix.out
>   TEST    tests/qapi-schema/enum-clash-member.out
>   TEST    tests/qapi-schema/enum-dict-member.out
>   TEST    tests/qapi-schema/enum-int-member.out
>   TEST    tests/qapi-schema/enum-member-case.out
>   TEST    tests/qapi-schema/enum-missing-data.out
>   TEST    tests/qapi-schema/enum-wrong-data.out
>   TEST    tests/qapi-schema/escape-outside-string.out
>   TEST    tests/qapi-schema/escape-too-big.out
>   TEST    tests/qapi-schema/escape-too-short.out
>   TEST    tests/qapi-schema/event-boxed-empty.out
>   TEST    tests/qapi-schema/event-nest-struct.out
>   TEST    tests/qapi-schema/event-case.out
>   TEST    tests/qapi-schema/flat-union-array-branch.out
>   TEST    tests/qapi-schema/flat-union-bad-base.out
>   TEST    tests/qapi-schema/flat-union-bad-discriminator.out
>   TEST    tests/qapi-schema/flat-union-base-any.out
>   TEST    tests/qapi-schema/flat-union-base-union.out
>   TEST    tests/qapi-schema/flat-union-clash-member.out
>   TEST    tests/qapi-schema/flat-union-empty.out
>   TEST    tests/qapi-schema/flat-union-incomplete-branch.out
>   TEST    tests/qapi-schema/flat-union-inline.out
>   TEST    tests/qapi-schema/flat-union-int-branch.out
>   TEST    tests/qapi-schema/flat-union-invalid-branch-key.out
>   TEST    tests/qapi-schema/flat-union-invalid-discriminator.out
>   TEST    tests/qapi-schema/flat-union-no-base.out
>   TEST    tests/qapi-schema/flat-union-optional-discriminator.out
>   TEST    tests/qapi-schema/flat-union-string-discriminator.out
>   TEST    tests/qapi-schema/funny-char.out
>   TEST    tests/qapi-schema/ident-with-escape.out
>   TEST    tests/qapi-schema/include-before-err.out
>   TEST    tests/qapi-schema/include-format-err.out
>   TEST    tests/qapi-schema/include-nested-err.out
>   TEST    tests/qapi-schema/include-cycle.out
>   TEST    tests/qapi-schema/include-no-file.out
>   TEST    tests/qapi-schema/include-non-file.out
>   TEST    tests/qapi-schema/include-relpath.out
>   TEST    tests/qapi-schema/include-repetition.out
>   TEST    tests/qapi-schema/include-self-cycle.out
>   TEST    tests/qapi-schema/include-simple.out
>   TEST    tests/qapi-schema/indented-expr.out
>   TEST    tests/qapi-schema/leading-comma-list.out
>   TEST    tests/qapi-schema/leading-comma-object.out
>   TEST    tests/qapi-schema/missing-colon.out
>   TEST    tests/qapi-schema/missing-comma-list.out
>   TEST    tests/qapi-schema/missing-comma-object.out
>   TEST    tests/qapi-schema/missing-type.out
>   TEST    tests/qapi-schema/nested-struct-data.out
>   TEST    tests/qapi-schema/non-objects.out
>   TEST    tests/qapi-schema/qapi-schema-test.out
>   TEST    tests/qapi-schema/quoted-structural-chars.out
>   TEST    tests/qapi-schema/redefined-command.out
>   TEST    tests/qapi-schema/redefined-builtin.out
>   TEST    tests/qapi-schema/redefined-event.out
>   TEST    tests/qapi-schema/redefined-type.out
>   TEST    tests/qapi-schema/reserved-command-q.out
>   TEST    tests/qapi-schema/reserved-member-has.out
>   TEST    tests/qapi-schema/reserved-enum-q.out
>   TEST    tests/qapi-schema/reserved-member-q.out
>   TEST    tests/qapi-schema/reserved-member-u.out
>   TEST    tests/qapi-schema/reserved-member-underscore.out
>   TEST    tests/qapi-schema/reserved-type-kind.out
>   TEST    tests/qapi-schema/reserved-type-list.out
>   TEST    tests/qapi-schema/returns-alternate.out
>   TEST    tests/qapi-schema/returns-array-bad.out
>   TEST    tests/qapi-schema/returns-dict.out
>   TEST    tests/qapi-schema/returns-unknown.out
>   TEST    tests/qapi-schema/returns-whitelist.out
>   TEST    tests/qapi-schema/struct-base-clash-deep.out
>   TEST    tests/qapi-schema/struct-base-clash.out
>   TEST    tests/qapi-schema/struct-data-invalid.out
>   TEST    tests/qapi-schema/struct-member-invalid.out
>   TEST    tests/qapi-schema/trailing-comma-list.out
>   TEST    tests/qapi-schema/trailing-comma-object.out
>   TEST    tests/qapi-schema/type-bypass-bad-gen.out
>   TEST    tests/qapi-schema/unclosed-list.out
>   TEST    tests/qapi-schema/unclosed-object.out
>   TEST    tests/qapi-schema/unclosed-string.out
>   TEST    tests/qapi-schema/unicode-str.out
>   TEST    tests/qapi-schema/union-base-no-discriminator.out
>   TEST    tests/qapi-schema/union-branch-case.out
>   TEST    tests/qapi-schema/union-clash-branches.out
>   TEST    tests/qapi-schema/union-empty.out
>   TEST    tests/qapi-schema/union-invalid-base.out
>   TEST    tests/qapi-schema/union-optional-branch.out
>   TEST    tests/qapi-schema/union-unknown.out
>   TEST    tests/qapi-schema/unknown-escape.out
>   TEST    tests/qapi-schema/unknown-expr-key.out
>   CC      tests/check-qdict.o
>   CC      tests/test-char.o
>   CC      tests/check-qfloat.o
>   CC      tests/check-qint.o
>   CC      tests/check-qstring.o
>   CC      tests/check-qlist.o
>   CC      tests/check-qnull.o
>   CC      tests/check-qjson.o
>   CC      tests/test-qobject-output-visitor.o
>   GEN     tests/test-qapi-visit.c
>   GEN     tests/test-qapi-types.c
>   GEN     tests/test-qapi-event.c
>   GEN     tests/test-qmp-introspect.c
>   CC      tests/test-clone-visitor.o
>   CC      tests/test-qobject-input-visitor.o
>   CC      tests/test-qobject-input-strict.o
>   CC      tests/test-qmp-commands.o
>   GEN     tests/test-qmp-marshal.c
>   CC      tests/test-string-input-visitor.o
>   CC      tests/test-string-output-visitor.o
>   CC      tests/test-qmp-event.o
>   CC      tests/test-opts-visitor.o
>   CC      tests/test-coroutine.o
>   CC      tests/iothread.o
>   CC      tests/test-visitor-serialization.o
>   CC      tests/test-iov.o
>   CC      tests/test-aio.o
>   CC      tests/test-aio-multithread.o
>   CC      tests/test-throttle.o
>   CC      tests/test-thread-pool.o
>   CC      tests/test-hbitmap.o
>   CC      tests/test-blockjob.o
>   CC      tests/test-blockjob-txn.o
>   CC      tests/test-x86-cpuid.o
>   CC      tests/test-xbzrle.o
>   CC      tests/test-vmstate.o
>   CC      tests/test-cutils.o
>   CC      tests/test-shift128.o
>   CC      tests/test-mul64.o
>   CC      tests/test-int128.o
>   CC      tests/rcutorture.o
>   CC      tests/test-rcu-list.o
>   CC      tests/test-qdist.o
>   CC      tests/test-qht.o
>   CC      tests/test-qht-par.o
>   CC      tests/qht-bench.o
>   CC      tests/test-bitops.o
>   CC      tests/test-qdev-global-props.o
>   CC      tests/test-bitcnt.o
>   CC      tests/check-qom-interface.o
>   CC      tests/check-qom-proplist.o
>   CC      tests/test-qemu-opts.o
>   CC      tests/test-write-threshold.o
>   CC      tests/test-crypto-hash.o
>   CC      tests/test-crypto-hmac.o
>   CC      tests/test-crypto-secret.o
>   CC      tests/test-crypto-cipher.o
>   CC      tests/test-crypto-tlscredsx509.o
>   CC      tests/crypto-tls-x509-helpers.o
>   CC      tests/pkix_asn1_tab.o
>   CC      tests/test-crypto-tlssession.o
>   CC      tests/test-qga.o
>   CC      tests/libqtest.o
>   CC      tests/test-timed-average.o
>   CC      tests/test-io-task.o
>   CC      tests/test-io-channel-socket.o
>   CC      tests/io-channel-helpers.o
>   CC      tests/test-io-channel-file.o
>   CC      tests/test-io-channel-tls.o
>   CC      tests/test-io-channel-command.o
>   CC      tests/test-io-channel-buffer.o
>   CC      tests/test-base64.o
>   CC      tests/test-crypto-pbkdf.o
>   CC      tests/test-crypto-ivgen.o
>   CC      tests/test-crypto-afsplit.o
>   CC      tests/test-crypto-block.o
>   CC      tests/test-crypto-xts.o
>   CC      tests/test-logging.o
>   CC      tests/test-replication.o
>   CC      tests/test-uuid.o
>   CC      tests/test-bufferiszero.o
>   CC      tests/ptimer-test.o
>   CC      tests/ptimer-test-stubs.o
>   CC      tests/boot-serial-test.o
>   CC      tests/libqos/pci.o
>   CC      tests/libqos/fw_cfg.o
>   CC      tests/libqos/malloc.o
>   CC      tests/libqos/i2c.o
>   CC      tests/libqos/libqos.o
>   CC      tests/tmp105-test.o
>   CC      tests/libqos/i2c-omap.o
>   CC      tests/ds1338-test.o
>   CC      tests/m25p80-test.o
>   CC      tests/libqos/i2c-imx.o
>   CC      tests/virtio-blk-test.o
>   CC      tests/libqos/malloc-spapr.o
>   CC      tests/libqos/libqos-spapr.o
>   CC      tests/libqos/rtas.o
>   CC      tests/libqos/pci-spapr.o
>   CC      tests/libqos/pci-pc.o
>   CC      tests/libqos/malloc-pc.o
>   CC      tests/libqos/ahci.o
>   CC      tests/libqos/virtio.o
>   CC      tests/libqos/libqos-pc.o
>   CC      tests/libqos/virtio-pci.o
>   CC      tests/libqos/virtio-mmio.o
>   CC      tests/libqos/malloc-generic.o
>   CC      tests/test-arm-mptimer.o
>   CC      tests/fdc-test.o
>   CC      tests/endianness-test.o
>   CC      tests/ide-test.o
>   CC      tests/ahci-test.o
>   CC      tests/hd-geo-test.o
>   CC      tests/boot-order-test.o
>   CC      tests/bios-tables-test.o
>   CC      tests/boot-sector.o
>   CC      tests/pxe-test.o
>   CC      tests/rtc-test.o
>   CC      tests/ipmi-kcs-test.o
>   CC      tests/ipmi-bt-test.o
>   CC      tests/i440fx-test.o
>   CC      tests/fw_cfg-test.o
>   CC      tests/drive_del-test.o
>   CC      tests/wdt_ib700-test.o
>   CC      tests/tco-test.o
>   CC      tests/e1000e-test.o
>   CC      tests/e1000-test.o
>   CC      tests/rtl8139-test.o
>   CC      tests/pcnet-test.o
>   CC      tests/eepro100-test.o
>   CC      tests/ne2000-test.o
>   CC      tests/nvme-test.o
>   CC      tests/ac97-test.o
>   CC      tests/es1370-test.o
>   CC      tests/virtio-net-test.o
>   CC      tests/virtio-balloon-test.o
>   CC      tests/virtio-rng-test.o
>   CC      tests/virtio-scsi-test.o
>   CC      tests/virtio-9p-test.o
>   CC      tests/virtio-serial-test.o
>   CC      tests/virtio-console-test.o
>   CC      tests/tpci200-test.o
>   CC      tests/ipoctal232-test.o
>   CC      tests/display-vga-test.o
>   CC      tests/intel-hda-test.o
>   CC      tests/ivshmem-test.o
>   CC      tests/vmxnet3-test.o
>   CC      tests/pvpanic-test.o
>   CC      tests/i82801b11-test.o
>   CC      tests/ioh3420-test.o
>   CC      tests/usb-hcd-ohci-test.o
>   CC      tests/libqos/usb.o
>   CC      tests/usb-hcd-uhci-test.o
>   CC      tests/usb-hcd-ehci-test.o
>   CC      tests/usb-hcd-xhci-test.o
>   CC      tests/pc-cpu-test.o
>   CC      tests/q35-test.o
>   CC      tests/test-filter-mirror.o
>   CC      tests/test-netfilter.o
>   CC      tests/test-filter-redirector.o
>   CC      tests/postcopy-test.o
>   CC      tests/test-x86-cpuid-compat.o
>   CC      tests/spapr-phb-test.o
>   CC      tests/prom-env-test.o
>   CC      tests/pnv-xscom-test.o
>   CC      tests/rtas-test.o
>   CC      tests/device-introspect-test.o
>   CC      tests/qom-test.o
>   LINK    tests/check-qdict
>   LINK    tests/test-char
>   LINK    tests/check-qfloat
>   LINK    tests/check-qint
>   LINK    tests/check-qstring
>   LINK    tests/check-qlist
>   LINK    tests/check-qnull
>   LINK    tests/check-qjson
>   CC      tests/test-qapi-visit.o
>   CC      tests/test-qapi-types.o
>   CC      tests/test-qapi-event.o
>   CC      tests/test-qmp-introspect.o
>   CC      tests/test-qmp-marshal.o
>   LINK    tests/test-coroutine
>   LINK    tests/test-iov
>   LINK    tests/test-aio
>   LINK    tests/test-aio-multithread
>   LINK    tests/test-throttle
>   LINK    tests/test-thread-pool
>   LINK    tests/test-hbitmap
>   LINK    tests/test-blockjob
>   LINK    tests/test-blockjob-txn
>   LINK    tests/test-x86-cpuid
>   LINK    tests/test-xbzrle
>   LINK    tests/test-vmstate
>   LINK    tests/test-cutils
>   LINK    tests/test-shift128
>   LINK    tests/test-mul64
>   LINK    tests/test-int128
>   LINK    tests/rcutorture
>   LINK    tests/test-rcu-list
>   LINK    tests/test-qdist
>   LINK    tests/test-qht
>   LINK    tests/test-bitops
>   LINK    tests/test-bitcnt
>   LINK    tests/qht-bench
>   LINK    tests/test-qdev-global-props
>   LINK    tests/check-qom-interface
>   LINK    tests/check-qom-proplist
>   LINK    tests/test-qemu-opts
>   LINK    tests/test-write-threshold
>   LINK    tests/test-crypto-hash
>   LINK    tests/test-crypto-hmac
>   LINK    tests/test-crypto-cipher
>   LINK    tests/test-crypto-secret
>   LINK    tests/test-crypto-tlscredsx509
>   LINK    tests/test-crypto-tlssession
>   LINK    tests/test-qga
>   LINK    tests/test-timed-average
>   LINK    tests/test-io-task
>   LINK    tests/test-io-channel-socket
>   LINK    tests/test-io-channel-file
>   LINK    tests/test-io-channel-tls
>   LINK    tests/test-io-channel-command
>   LINK    tests/test-io-channel-buffer
>   LINK    tests/test-base64
>   LINK    tests/test-crypto-pbkdf
>   LINK    tests/test-crypto-ivgen
>   LINK    tests/test-crypto-xts
>   LINK    tests/test-crypto-afsplit
>   LINK    tests/test-crypto-block
>   LINK    tests/test-logging
>   LINK    tests/test-replication
>   LINK    tests/test-bufferiszero
>   LINK    tests/test-uuid
>   LINK    tests/ptimer-test
>   LINK    tests/boot-serial-test
>   LINK    tests/tmp105-test
>   LINK    tests/ds1338-test
>   LINK    tests/m25p80-test
>   LINK    tests/virtio-blk-test
>   LINK    tests/test-arm-mptimer
>   LINK    tests/endianness-test
>   LINK    tests/fdc-test
>   LINK    tests/ide-test
>   LINK    tests/ahci-test
>   LINK    tests/hd-geo-test
>   LINK    tests/boot-order-test
>   LINK    tests/bios-tables-test
>   LINK    tests/pxe-test
>   LINK    tests/rtc-test
>   LINK    tests/ipmi-kcs-test
>   LINK    tests/ipmi-bt-test
>   LINK    tests/i440fx-test
>   LINK    tests/fw_cfg-test
>   LINK    tests/drive_del-test
>   LINK    tests/wdt_ib700-test
>   LINK    tests/tco-test
>   LINK    tests/e1000-test
>   LINK    tests/e1000e-test
>   LINK    tests/rtl8139-test
>   LINK    tests/pcnet-test
>   LINK    tests/eepro100-test
>   LINK    tests/ne2000-test
>   LINK    tests/nvme-test
>   LINK    tests/ac97-test
>   LINK    tests/es1370-test
>   LINK    tests/virtio-net-test
>   LINK    tests/virtio-balloon-test
>   LINK    tests/virtio-rng-test
>   LINK    tests/virtio-scsi-test
>   LINK    tests/virtio-9p-test
>   LINK    tests/virtio-serial-test
>   LINK    tests/virtio-console-test
>   LINK    tests/tpci200-test
>   LINK    tests/ipoctal232-test
>   LINK    tests/display-vga-test
>   LINK    tests/intel-hda-test
>   LINK    tests/ivshmem-test
>   LINK    tests/vmxnet3-test
>   LINK    tests/pvpanic-test
>   LINK    tests/i82801b11-test
>   LINK    tests/ioh3420-test
>   LINK    tests/usb-hcd-ohci-test
>   LINK    tests/usb-hcd-uhci-test
>   LINK    tests/usb-hcd-ehci-test
>   LINK    tests/usb-hcd-xhci-test
>   LINK    tests/q35-test
>   LINK    tests/pc-cpu-test
>   LINK    tests/test-netfilter
>   LINK    tests/test-filter-mirror
>   LINK    tests/test-filter-redirector
>   LINK    tests/postcopy-test
>   LINK    tests/test-x86-cpuid-compat
>   LINK    tests/spapr-phb-test
>   LINK    tests/prom-env-test
>   LINK    tests/pnv-xscom-test
>   LINK    tests/rtas-test
>   LINK    tests/device-introspect-test
>   LINK    tests/qom-test
>   GTESTER tests/check-qdict
>   GTESTER tests/test-char
>   GTESTER tests/check-qfloat
>   GTESTER tests/check-qint
>   GTESTER tests/check-qlist
>   GTESTER tests/check-qstring
>   GTESTER tests/check-qnull
>   GTESTER tests/check-qjson
>   LINK    tests/test-qobject-output-visitor
>   LINK    tests/test-clone-visitor
>   LINK    tests/test-qobject-input-visitor
>   LINK    tests/test-qobject-input-strict
>   LINK    tests/test-qmp-commands
>   LINK    tests/test-string-input-visitor
>   LINK    tests/test-string-output-visitor
>   LINK    tests/test-qmp-event
>   LINK    tests/test-opts-visitor
>   GTESTER tests/test-coroutine
>   LINK    tests/test-visitor-serialization
>   GTESTER tests/test-iov
>   GTESTER tests/test-aio
>   GTESTER tests/test-aio-multithread
>   GTESTER tests/test-throttle
>   GTESTER tests/test-thread-pool
>   GTESTER tests/test-hbitmap
>   GTESTER tests/test-blockjob
>   GTESTER tests/test-blockjob-txn
>   GTESTER tests/test-x86-cpuid
>   GTESTER tests/test-xbzrle
>   GTESTER tests/test-vmstate
>   GTESTER tests/test-cutils
>   GTESTER tests/test-shift128
>   GTESTER tests/test-mul64
>   GTESTER tests/test-int128
>   GTESTER tests/rcutorture
>   GTESTER tests/test-rcu-list
>   GTESTER tests/test-qdist
>   GTESTER tests/test-qht
>   LINK    tests/test-qht-par
>   GTESTER tests/test-bitops
>   GTESTER tests/test-bitcnt
>   GTESTER tests/test-qdev-global-props
>   GTESTER tests/check-qom-interface
>   GTESTER tests/check-qom-proplist
>   GTESTER tests/test-qemu-opts
>   GTESTER tests/test-write-threshold
>   GTESTER tests/test-crypto-hash
>   GTESTER tests/test-crypto-hmac
>   GTESTER tests/test-crypto-cipher
>   GTESTER tests/test-crypto-secret
>   GTESTER tests/test-crypto-tlscredsx509
>   GTESTER tests/test-crypto-tlssession
>   GTESTER tests/test-qga
>   GTESTER tests/test-timed-average
>   GTESTER tests/test-io-task
>   GTESTER tests/test-io-channel-socket
>   GTESTER tests/test-io-channel-file
>   GTESTER tests/test-io-channel-tls
>   GTESTER tests/test-io-channel-command
>   GTESTER tests/test-io-channel-buffer
>   GTESTER tests/test-base64
>   GTESTER tests/test-crypto-pbkdf
>   GTESTER tests/test-crypto-ivgen
>   GTESTER tests/test-crypto-afsplit
>   GTESTER tests/test-crypto-block
>   GTESTER tests/test-crypto-xts
>   GTESTER tests/test-logging
>   GTESTER tests/test-replication
>   GTESTER tests/test-bufferiszero
>   GTESTER tests/test-uuid
>   GTESTER tests/ptimer-test
>   GTESTER check-qtest-aarch64
>   GTESTER check-qtest-alpha
>   GTESTER check-qtest-arm
>   GTESTER check-qtest-cris
>   GTESTER check-qtest-i386
>   GTESTER check-qtest-lm32
>   GTESTER check-qtest-m68k
>   GTESTER check-qtest-microblazeel
>   GTESTER check-qtest-microblaze
>   GTESTER check-qtest-mips64el
>   GTESTER check-qtest-mips64
>   GTESTER check-qtest-mipsel
>   GTESTER check-qtest-mips
>   GTESTER check-qtest-moxie
> "kvm" accelerator not found.
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> "kvm" accelerator not found.
>   GTESTER check-qtest-nios2
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> "kvm" accelerator not found.
>   GTESTER check-qtest-or1k
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> "kvm" accelerator not found.
>   GTESTER check-qtest-ppc64
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> "kvm" accelerator not found.
>   GTESTER check-qtest-ppcemb
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> "kvm" accelerator not found.
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> "kvm" accelerator not found.
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
>   GTESTER check-qtest-ppc
>   GTESTER check-qtest-s390x
> "kvm" accelerator not found.
> GTester: last random seed: R02Sfd019825d9ee32f36ccd9630c32e2b78
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> "kvm" accelerator not found.
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> "kvm" accelerator not found.
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> /var/tmp/patchew-tester-tmp-1ouqaay5/src/tests/Makefile.include:792: recipe for target 'check-qtest-s390x' failed
> make: *** [check-qtest-s390x] Error 1
> make: *** Waiting for unfinished jobs....

Fam, this seems to happen sometimes. Can you have a look at that why the qtest 
thing fails on the s390 box?
