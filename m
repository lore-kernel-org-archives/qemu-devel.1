Received: from eggs.gnu.org ([2001:4830:134:3::10]:37357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fquzs-0007IG-Cy
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 02:46:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fquzo-0004Lf-H3
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 02:46:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39252 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fquzo-0004Ko-8b
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 02:46:00 -0400
Date: Sat, 18 Aug 2018 14:45:54 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180818064554.GA2277@lemon.usersys.redhat.com>
References: <20180817051853.23792-1-cota@braap.org>
	<153455848651.26347.421862919623233041@502c9da6d61e>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <153455848651.26347.421862919623233041@502c9da6d61e>
Subject: Re: [Qemu-devel] [PATCH v2 0/9] synchronization profiler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cota@braap.org

On Fri, 08/17 19:14, no-reply@patchew.org wrote:
> This series failed docker-clang@ubuntu build test. Please find the testin=
g commands and
> their output below. If you have Docker installed, you can probably reprod=
uce it
> locally.
>=20
> Type: series
> Message-id: 20180817051853.23792-1-cota@braap.org
> Subject: [Qemu-devel] [PATCH v2 0/9] synchronization profiler
>=20
> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> #!/bin/bash
> time make docker-test-clang@ubuntu SHOW_ENV=3D1 J=3D8
> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>=20
> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> Switched to a new branch 'test'
> 5f5c9f4814 hmp-commands-info: add sync-profile
> dda3cae528 hmp-commands: add sync-profile
> 88d0f93fe4 vl: add -enable-sync-profile
> 15359bc24a tests/atomic_add-bench: add -p to enable sync profiler
> c03b816ed4 qsp: track BQL callers explicitly
> a213737f84 qsp: support call site coalescing
> 6edc020b67 qsp: add qsp_reset
> 0b7317100b qsp: add sort_by option to qsp_report
> 2b55a85381 qsp: QEMU's Synchronization Profiler
>=20
> =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
>   BUILD   ubuntu
> make[1]: Entering directory '/var/tmp/patchew-tester-tmp-pdpmalc5/src'
>   GEN     /var/tmp/patchew-tester-tmp-pdpmalc5/src/docker-src.2018-08-17-=
22.12.51.31192/qemu.tar
> Cloning into '/var/tmp/patchew-tester-tmp-pdpmalc5/src/docker-src.2018-08=
-17-22.12.51.31192/qemu.tar.vroot'...
> done.
> Your branch is up-to-date with 'origin/test'.
> Submodule 'dtc' (git://git.qemu-project.org/dtc.git) registered for path =
'dtc'
> Cloning into '/var/tmp/patchew-tester-tmp-pdpmalc5/src/docker-src.2018-08=
-17-22.12.51.31192/qemu.tar.vroot/dtc'...
> Submodule path 'dtc': checked out 'e54388015af1fb4bf04d0bca99caba1074d9cc=
42'
> Submodule 'ui/keycodemapdb' (git://git.qemu.org/keycodemapdb.git) registe=
red for path 'ui/keycodemapdb'
> Cloning into '/var/tmp/patchew-tester-tmp-pdpmalc5/src/docker-src.2018-08=
-17-22.12.51.31192/qemu.tar.vroot/ui/keycodemapdb'...
> Submodule path 'ui/keycodemapdb': checked out '6b3d716e2b6472eb7189d32205=
52280ef3d832ce'
>   COPY    RUNNER
>     RUN test-clang in qemu:ubuntu=20
> Packages installed:
> +++-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D-=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Desired=3DUnknown/Install/Remove/Purge/Hold
> ii  bison                     2:3.0.4.dfsg-1            amd64        YACC=
-compatible parser generator
> ii  ccache                    3.2.4-1                   amd64        Comp=
iler cache for fast recompilation of C/C++ code
> ii  clang                     1:3.8-33ubuntu3.1         amd64        C, C=
++ and Objective-C compiler (LLVM based)
> ii  flex                      2.6.0-11                  amd64        fast=
 lexical analyzer generator
> ii  gcc                       4:5.3.1-1ubuntu1          amd64        GNU =
C compiler
> ii  gettext                   0.19.7-2ubuntu3           amd64        GNU =
Internationalization utilities
> ii  git                       1:2.7.4-0ubuntu1.4        amd64        fast=
, scalable, distributed revision control system
> ii  glusterfs-common          3.7.6-1ubuntu1            amd64        Glus=
terFS common libraries and translator modules
> ii  libaio-dev                0.3.110-2                 amd64        Linu=
x kernel AIO access library - development files
> ii  libattr1-dev:amd64        1:2.4.47-2                amd64        Exte=
nded attribute static libraries and headers
> ii  libbluetooth-dev          5.37-0ubuntu5.1           amd64        Deve=
lopment files for using the BlueZ Linux Bluetooth library
> ii  libbrlapi-dev:amd64       5.3.1-2ubuntu2.1          amd64        Libr=
ary for communication with BRLTTY - static libs and headers
> ii  libbz2-dev:amd64          1.0.6-8                   amd64        high=
-quality block-sorting file compressor library - development
> ii  libcacard-dev:amd64       1:2.5.0-2                 amd64        Virt=
ual Common Access Card (CAC) Emulator (development files)
> ii  libcap-dev:amd64          1:2.24-12                 amd64        POSI=
X 1003.1e capabilities (development)
> ii  libcap-ng-dev             0.7.7-1                   amd64        Deve=
lopment and header files for libcap-ng
> ii  libcurl4-gnutls-dev:amd64 7.47.0-1ubuntu2.8         amd64        deve=
lopment files and documentation for libcurl (GnuTLS flavour)
> ii  libdrm-dev:amd64          2.4.91-2~16.04.1          amd64        User=
space interface to kernel DRM services -- development files
> ii  libepoxy-dev:amd64        1.3.1-1ubuntu0.16.04.2    amd64        Open=
GL function pointer management library- development
> ii  libfdt-dev                1.4.0+dfsg-2              amd64        Flat=
 Device Trees manipulation library - development files
> ii  libgbm-dev:amd64          18.0.5-0ubuntu0~16.04.1   amd64        gene=
ric buffer management API -- development files
> ii  libgnutls-dev:amd64       3.4.10-4ubuntu1.4         amd64        GNU =
TLS library - development files
> ii  libgtk-3-dev:amd64        3.18.9-1ubuntu3.3         amd64        deve=
lopment files for the GTK+ library
> ii  libibverbs-dev            1.1.8-1.1ubuntu2          amd64        Deve=
lopment files for the libibverbs library
> ii  libiscsi-dev              1.12.0-2                  amd64        iSCS=
I client library development files
> ii  libjemalloc-dev           3.6.0-9ubuntu1            amd64        deve=
lopment files and documentation for jemalloc
> ii  libjpeg-turbo8-dev:amd64  1.4.2-0ubuntu3.1          amd64        Deve=
lopment files for the IJG JPEG library
> ii  liblzo2-dev:amd64         2.08-1.2                  amd64        data=
 compression library (development files)
> ii  libncurses5-dev:amd64     6.0+20160213-1ubuntu1     amd64        deve=
loper's libraries for ncurses
> ii  libncursesw5-dev:amd64    6.0+20160213-1ubuntu1     amd64        deve=
loper's libraries for ncursesw
> ii  libnfs-dev:amd64          1.9.8-1                   amd64        NFS =
client library (development files)
> ii  libnss3-dev:amd64         2:3.28.4-0ubuntu0.16.04.3 amd64        Deve=
lopment files for the Network Security Service libraries
> ii  libnuma-dev:amd64         2.0.11-1ubuntu1.1         amd64        Deve=
lopment files for libnuma
> ii  libpixman-1-dev           0.33.6-1                  amd64        pixe=
l-manipulation library for X and cairo (development files)
> ii  libpng12-dev:amd64        1.2.54-1ubuntu1.1         amd64        PNG =
library - development
> ii  librados-dev              10.2.9-0ubuntu0.16.04.1   amd64        RADO=
S distributed object store client library (development files)
> ii  librbd-dev                10.2.9-0ubuntu0.16.04.1   amd64        RADO=
S block device client library (development files)
> ii  librdmacm-dev             1.0.21-1                  amd64        Deve=
lopment files for the librdmacm library
> ii  libsasl2-dev              2.1.26.dfsg1-14build1     amd64        Cyru=
s SASL - development files for authentication abstraction library
> ii  libsdl2-dev               2.0.4+dfsg1-2ubuntu2      amd64        Simp=
le DirectMedia Layer development files
> ii  libseccomp-dev:amd64      2.3.1-2.1ubuntu2~16.04.1  amd64        high=
 level interface to Linux seccomp filter (development files)
> ii  libsnappy-dev:amd64       1.1.3-2                   amd64        fast=
 compression/decompression library (development files)
> ii  libspice-protocol-dev     0.12.10-1ubuntu0.1        all          SPIC=
E protocol headers
> ii  libspice-server-dev       0.12.6-4ubuntu0.3         amd64        Head=
er files and development documentation for spice-server
> ii  libssh2-1-dev:amd64       1.5.0-2ubuntu0.1          amd64        SSH2=
 client-side library (development headers)
> ii  libusb-1.0-0-dev:amd64    2:1.0.20-1                amd64        user=
space USB programming library development files
> ii  libusbredirhost-dev:amd64 0.7.1-1                   amd64        impl=
ementing the usb-host (*) side of a usbredir connection (development)
> ii  libvdeplug-dev            2.3.2+r586-2              amd64        Virt=
ual Distributed Ethernet - Plug development files
> ii  libvte-2.91-dev:amd64     0.42.5-1ubuntu1           amd64        Term=
inal emulator widget for GTK+ 3.0 - development files
> ii  libxen-dev:amd64          4.6.5-0ubuntu1.4          amd64        Publ=
ic headers and libs for Xen
> ii  make                      4.1-6                     amd64        util=
ity for directing compilation
> ii  python-yaml               3.11-3build1              amd64        YAML=
 parser and emitter for Python
> ii  sparse                    0.5.0-1build1             amd64        sema=
ntic parser of source files
> ii  texinfo                   6.1.0.dfsg.1-5            amd64        Docu=
mentation system for on-line information and printed output
> ii  xfslibs-dev               4.3.0+nmu1ubuntu1.1       amd64        XFS =
filesystem-specific static libraries and headers
> | Status=3DNot/Inst/Conf-files/Unpacked/halF-conf/Half-inst/trig-aWait/Tr=
ig-pend
> |/ Err?=3D(none)/Reinst-required (Status,Err: uppercase=3Dbad)
> ||/ Name                      Version                   Architecture Desc=
ription
>=20
> Environment variables:
> PACKAGES=3Dflex bison     libusb-1.0-0-dev libiscsi-dev librados-dev libn=
curses5-dev libncursesw5-dev     libseccomp-dev libgnutls-dev libssh2-1-dev=
  libspice-server-dev     libspice-protocol-dev libnss3-dev libfdt-dev     =
libgtk-3-dev libvte-2.91-dev libsdl2-dev libpng12-dev libpixman-1-dev     l=
ibvdeplug-dev liblzo2-dev libsnappy-dev libbz2-dev libxen-dev librdmacm-dev=
 libibverbs-dev     libsasl2-dev libjpeg-turbo8-dev xfslibs-dev libcap-ng-d=
ev libbrlapi-dev libcurl4-gnutls-dev     libbluetooth-dev librbd-dev libaio=
-dev glusterfs-common libnuma-dev libepoxy-dev libdrm-dev libgbm-dev     li=
bjemalloc-dev libcacard-dev libusbredirhost-dev libnfs-dev libcap-dev libat=
tr1-dev     texinfo     gettext git make ccache python-yaml gcc clang sparse
> HOSTNAME=3D7b87689198c3
> MAKEFLAGS=3D -j8
> J=3D8
> CCACHE_DIR=3D/var/tmp/ccache
> EXTRA_CONFIGURE_OPTS=3D
> V=3D
> SHOW_ENV=3D1
> PATH=3D/usr/lib/ccache:/usr/lib64/ccache:/usr/local/sbin:/usr/local/bin:/=
usr/sbin:/usr/bin:/sbin:/bin
> PWD=3D/
> TARGET_LIST=3D
> SHLVL=3D1
> HOME=3D/home/patchew
> TEST_DIR=3D/tmp/qemu-test
> FEATURES=3Dclang pyyaml sdl2 dtc
> DEBUG=3D
> _=3D/usr/bin/env
>=20
> Configure options:
> --enable-werror --prefix=3D/tmp/qemu-test/install --cxx=3Dclang++ --cc=3D=
clang --host-cc=3Dclang
> Install prefix    /tmp/qemu-test/install
> BIOS directory    /tmp/qemu-test/install/share/qemu
> firmware path     /tmp/qemu-test/install/share/qemu-firmware
> binary directory  /tmp/qemu-test/install/bin
> library directory /tmp/qemu-test/install/lib
> module directory  /tmp/qemu-test/install/lib/qemu
> libexec directory /tmp/qemu-test/install/libexec
> include directory /tmp/qemu-test/install/include
> config directory  /tmp/qemu-test/install/etc
> local state directory   /tmp/qemu-test/install/var
> Manual directory  /tmp/qemu-test/install/share/man
> ELF interp prefix /usr/gnemul/qemu-%M
> Source path       /tmp/qemu-test/src
> GIT binary        git
> GIT submodules   =20
> C compiler        clang
> Host C compiler   clang
> C++ compiler      clang++
> Objective-C compiler clang
> ARFLAGS           rv
> CFLAGS            -O2 -g=20
> QEMU_CFLAGS       -I/usr/include/pixman-1 -I$(SRC_PATH)/dtc/libfdt -Werro=
r -DHAS_LIBSSH2_SFTP_FSYNC -pthread -I/usr/include/glib-2.0 -I/usr/lib/x86_=
64-linux-gnu/glib-2.0/include -fPIE -DPIE -m64 -mcx16 -D_GNU_SOURCE -D_FILE=
_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls=
 -Wall -Wundef -Wwrite-strings -Wmissing-prototypes -fno-strict-aliasing -f=
no-common -fwrapv  -Wno-string-plus-int -Wno-initializer-overrides -Wendif-=
labels -Wno-shift-negative-value -Wno-missing-include-dirs -Wempty-body -Wn=
ested-externs -Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifie=
rs -Wold-style-definition -Wtype-limits -fstack-protector-strong -Wno-missi=
ng-braces -I/usr/include/p11-kit-1    -I/usr/include/libpng12  -I/usr/inclu=
de/spice-server -I/usr/include/spice-1
> LDFLAGS           -Wl,--warn-common -Wl,-z,relro -Wl,-z,now -pie -m64 -g=
=20
> QEMU_LDFLAGS      -L$(BUILD_DIR)/dtc/libfdt=20
> make              make
> install           install
> python            python -B
> smbd              /usr/sbin/smbd
> module support    no
> host CPU          x86_64
> host big endian   no
> target list       aarch64-softmmu alpha-softmmu arm-softmmu cris-softmmu =
hppa-softmmu i386-softmmu lm32-softmmu m68k-softmmu microblaze-softmmu micr=
oblazeel-softmmu mips-softmmu mips64-softmmu mips64el-softmmu mipsel-softmm=
u moxie-softmmu nios2-softmmu or1k-softmmu ppc-softmmu ppc64-softmmu ppcemb=
-softmmu riscv32-softmmu riscv64-softmmu s390x-softmmu sh4-softmmu sh4eb-so=
ftmmu sparc-softmmu sparc64-softmmu tricore-softmmu unicore32-softmmu x86_6=
4-softmmu xtensa-softmmu xtensaeb-softmmu aarch64-linux-user aarch64_be-lin=
ux-user alpha-linux-user arm-linux-user armeb-linux-user cris-linux-user hp=
pa-linux-user i386-linux-user m68k-linux-user microblaze-linux-user microbl=
azeel-linux-user mips-linux-user mips64-linux-user mips64el-linux-user mips=
el-linux-user mipsn32-linux-user mipsn32el-linux-user nios2-linux-user or1k=
-linux-user ppc-linux-user ppc64-linux-user ppc64abi32-linux-user ppc64le-l=
inux-user riscv32-linux-user riscv64-linux-user s390x-linux-user sh4-linux-=
user sh4eb-linux-user sparc-linux-user sparc32plus-linux-user sparc64-linux=
-user tilegx-linux-user x86_64-linux-user xtensa-linux-user xtensaeb-linux-=
user
> gprof enabled     no
> sparse enabled    no
> strip binaries    yes
> profiler          no
> static build      no
> SDL support       yes (2.0.4)
> GTK support       yes (3.18.9)
> GTK GL support    yes
> VTE support       yes (0.42.5)
> TLS priority      NORMAL
> GNUTLS support    yes
> GNUTLS rnd        yes
> libgcrypt         no
> libgcrypt kdf     no
> nettle            yes (3.2)
> nettle kdf        yes
> libtasn1          yes
> curses support    yes
> virgl support     no=20
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
> xen support       yes
> xen ctrl version  40600
> pv dom build      no
> brlapi support    yes
> bluez  support    yes
> Documentation     yes
> PIE               yes
> vde support       yes
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
> fdt support       git
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
> spice support     yes (0.12.10/0.12.6)
> rbd support       yes
> xfsctl support    yes
> smartcard support no
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
> mutex debugging   no
> crypto afalg      no
> GlusterFS support yes
> gcov              gcov
> gcov enabled      no
> TPM support       yes
> libssh2 support   yes
> TPM passthrough   yes
> TPM emulator      yes
> QOM debugging     yes
> Live block migration yes
> lzo support       yes
> snappy support    yes
> bzip2 support     yes
> NUMA host support yes
> libxml2           no
> tcmalloc support  no
> jemalloc support  no
> avx2 optimization no
> replication support yes
> VxHS block device no
> capstone          no
> docker            no
>=20
> NOTE: cross-compilers enabled:  'clang' 'clang'
>   GEN     aarch64-softmmu/config-devices.mak.tmp
>   GEN     alpha-softmmu/config-devices.mak.tmp
>   GEN     arm-softmmu/config-devices.mak.tmp
>   GEN     cris-softmmu/config-devices.mak.tmp
>   GEN     i386-softmmu/config-devices.mak.tmp
>   GEN     hppa-softmmu/config-devices.mak.tmp
>   GEN     m68k-softmmu/config-devices.mak.tmp
>   GEN     lm32-softmmu/config-devices.mak.tmp
>   GEN     lm32-softmmu/config-devices.mak
>   GEN     m68k-softmmu/config-devices.mak
>   GEN     cris-softmmu/config-devices.mak
>   GEN     alpha-softmmu/config-devices.mak
>   GEN     i386-softmmu/config-devices.mak
>   GEN     arm-softmmu/config-devices.mak
>   GEN     hppa-softmmu/config-devices.mak
>   GEN     aarch64-softmmu/config-devices.mak
>   GEN     microblaze-softmmu/config-devices.mak.tmp
>   GEN     microblazeel-softmmu/config-devices.mak.tmp
>   GEN     mips-softmmu/config-devices.mak.tmp
>   GEN     mips64-softmmu/config-devices.mak.tmp
>   GEN     mips64el-softmmu/config-devices.mak.tmp
>   GEN     moxie-softmmu/config-devices.mak.tmp
>   GEN     mipsel-softmmu/config-devices.mak.tmp
>   GEN     nios2-softmmu/config-devices.mak.tmp
>   GEN     microblaze-softmmu/config-devices.mak
>   GEN     microblazeel-softmmu/config-devices.mak
>   GEN     or1k-softmmu/config-devices.mak.tmp
>   GEN     moxie-softmmu/config-devices.mak
>   GEN     nios2-softmmu/config-devices.mak
>   GEN     ppc-softmmu/config-devices.mak.tmp
>   GEN     ppc64-softmmu/config-devices.mak.tmp
>   GEN     or1k-softmmu/config-devices.mak
>   GEN     ppcemb-softmmu/config-devices.mak.tmp
>   GEN     mips-softmmu/config-devices.mak
>   GEN     mips64-softmmu/config-devices.mak
>   GEN     riscv32-softmmu/config-devices.mak.tmp
>   GEN     riscv64-softmmu/config-devices.mak.tmp
>   GEN     mipsel-softmmu/config-devices.mak
>   GEN     s390x-softmmu/config-devices.mak.tmp
>   GEN     mips64el-softmmu/config-devices.mak
>   GEN     sh4-softmmu/config-devices.mak.tmp
>   GEN     riscv32-softmmu/config-devices.mak
>   GEN     sh4eb-softmmu/config-devices.mak.tmp
>   GEN     ppc-softmmu/config-devices.mak
>   GEN     sparc-softmmu/config-devices.mak.tmp
>   GEN     riscv64-softmmu/config-devices.mak
>   GEN     s390x-softmmu/config-devices.mak
>   GEN     ppc64-softmmu/config-devices.mak
>   GEN     sparc64-softmmu/config-devices.mak.tmp
>   GEN     tricore-softmmu/config-devices.mak.tmp
>   GEN     ppcemb-softmmu/config-devices.mak
>   GEN     unicore32-softmmu/config-devices.mak.tmp
>   GEN     x86_64-softmmu/config-devices.mak.tmp
>   GEN     sparc-softmmu/config-devices.mak
>   GEN     xtensa-softmmu/config-devices.mak.tmp
>   GEN     sh4-softmmu/config-devices.mak
>   GEN     xtensaeb-softmmu/config-devices.mak.tmp
>   GEN     tricore-softmmu/config-devices.mak
>   GEN     sh4eb-softmmu/config-devices.mak
>   GEN     unicore32-softmmu/config-devices.mak
>   GEN     aarch64-linux-user/config-devices.mak.tmp
>   GEN     aarch64_be-linux-user/config-devices.mak.tmp
>   GEN     alpha-linux-user/config-devices.mak.tmp
>   GEN     xtensaeb-softmmu/config-devices.mak
>   GEN     arm-linux-user/config-devices.mak.tmp
>   GEN     x86_64-softmmu/config-devices.mak
>   GEN     aarch64-linux-user/config-devices.mak
>   GEN     armeb-linux-user/config-devices.mak.tmp
>   GEN     aarch64_be-linux-user/config-devices.mak
>   GEN     arm-linux-user/config-devices.mak
>   GEN     cris-linux-user/config-devices.mak.tmp
>   GEN     alpha-linux-user/config-devices.mak
>   GEN     i386-linux-user/config-devices.mak.tmp
>   GEN     hppa-linux-user/config-devices.mak.tmp
>   GEN     armeb-linux-user/config-devices.mak
>   GEN     m68k-linux-user/config-devices.mak.tmp
>   GEN     microblaze-linux-user/config-devices.mak.tmp
>   GEN     microblazeel-linux-user/config-devices.mak.tmp
>   GEN     cris-linux-user/config-devices.mak
>   GEN     xtensa-softmmu/config-devices.mak
>   GEN     hppa-linux-user/config-devices.mak
>   GEN     i386-linux-user/config-devices.mak
>   GEN     mips-linux-user/config-devices.mak.tmp
>   GEN     m68k-linux-user/config-devices.mak
>   GEN     microblaze-linux-user/config-devices.mak
>   GEN     microblazeel-linux-user/config-devices.mak
>   GEN     mips64el-linux-user/config-devices.mak.tmp
>   GEN     mips64-linux-user/config-devices.mak.tmp
>   GEN     mipsel-linux-user/config-devices.mak.tmp
>   GEN     mipsn32-linux-user/config-devices.mak.tmp
>   GEN     mipsn32el-linux-user/config-devices.mak.tmp
>   GEN     nios2-linux-user/config-devices.mak.tmp
>   GEN     sparc64-softmmu/config-devices.mak
>   GEN     mipsel-linux-user/config-devices.mak
>   GEN     or1k-linux-user/config-devices.mak.tmp
>   GEN     mips64-linux-user/config-devices.mak
>   GEN     mips64el-linux-user/config-devices.mak
>   GEN     mips-linux-user/config-devices.mak
>   GEN     mipsn32-linux-user/config-devices.mak
>   GEN     mipsn32el-linux-user/config-devices.mak
>   GEN     ppc-linux-user/config-devices.mak.tmp
>   GEN     ppc64-linux-user/config-devices.mak.tmp
>   GEN     nios2-linux-user/config-devices.mak
>   GEN     ppc64abi32-linux-user/config-devices.mak.tmp
>   GEN     ppc64le-linux-user/config-devices.mak.tmp
>   GEN     riscv32-linux-user/config-devices.mak.tmp
>   GEN     riscv64-linux-user/config-devices.mak.tmp
>   GEN     s390x-linux-user/config-devices.mak.tmp
>   GEN     or1k-linux-user/config-devices.mak
>   GEN     ppc-linux-user/config-devices.mak
>   GEN     ppc64-linux-user/config-devices.mak
>   GEN     sh4-linux-user/config-devices.mak.tmp
>   GEN     ppc64abi32-linux-user/config-devices.mak
>   GEN     riscv32-linux-user/config-devices.mak
>   GEN     riscv64-linux-user/config-devices.mak
>   GEN     ppc64le-linux-user/config-devices.mak
>   GEN     sh4eb-linux-user/config-devices.mak.tmp
>   GEN     sparc-linux-user/config-devices.mak.tmp
>   GEN     sparc32plus-linux-user/config-devices.mak.tmp
>   GEN     s390x-linux-user/config-devices.mak
>   GEN     sparc64-linux-user/config-devices.mak.tmp
>   GEN     tilegx-linux-user/config-devices.mak.tmp
>   GEN     sh4-linux-user/config-devices.mak
>   GEN     x86_64-linux-user/config-devices.mak.tmp
>   GEN     xtensa-linux-user/config-devices.mak.tmp
>   GEN     sh4eb-linux-user/config-devices.mak
>   GEN     xtensaeb-linux-user/config-devices.mak.tmp
>   GEN     sparc-linux-user/config-devices.mak
>   GEN     x86_64-linux-user/config-devices.mak
>   GEN     sparc32plus-linux-user/config-devices.mak
>   GEN     sparc64-linux-user/config-devices.mak
>   GEN     xtensa-linux-user/config-devices.mak
>   GEN     tilegx-linux-user/config-devices.mak
>   GEN     xtensaeb-linux-user/config-devices.mak
>   GEN     config-host.h
>   GEN     qemu-options.def
>   GEN     qapi-gen
>   GEN     trace/generated-tcg-tracers.h
>   GEN     trace/generated-helpers.h
>   GEN     trace/generated-helpers-wrappers.h
>   GEN     trace/generated-helpers.c
>   GEN     module_block.h
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
>   GEN     ui/input-keymap-x11-to-qcode.c
>   GEN     ui/input-keymap-xorgevdev-to-qcode.c
>   GEN     ui/input-keymap-xorgkbd-to-qcode.c
>   GEN     ui/input-keymap-xorgxquartz-to-qcode.c
>   GEN     ui/input-keymap-xorgxwin-to-qcode.c
>   GEN     ui/input-keymap-osx-to-qcode.c
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
> 	 DEP /tmp/qemu-test/src/dtc/tests/dumptrees.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/trees.S
> 	 DEP /tmp/qemu-test/src/dtc/tests/testutils.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/value-labels.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/asm_tree_dump.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/truncated_property.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/check_path.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/overlay_bad_fixup.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/overlay.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/subnode_iterate.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/property_iterate.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/integer-expressions.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/utilfdt_test.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/path_offset_aliases.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/add_subnode_with_nops.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/dtbs_equal_unordered.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/dtb_reverse.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/dtbs_equal_ordered.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/extra-terminating-null.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/incbin.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/boot-cpuid.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/phandle_format.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/path-references.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/references.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/string_escapes.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/propname_escapes.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/appendprop2.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/appendprop1.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/del_node.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/del_property.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/setprop.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/set_name.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/rw_tree1.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/open_pack.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/nopulate.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/mangle-layout.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/move_and_save.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/sw_tree1.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/nop_node.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/nop_property.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/setprop_inplace.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/stringlist.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/addr_size_cells.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/notfound.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/sized_cells.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/char_literal.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/get_alias.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/node_offset_by_compatible.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/node_check_compatible.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/node_offset_by_phandle.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/node_offset_by_prop_value.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/parent_offset.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/supernode_atdepth_offset.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/get_path.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/get_phandle.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/getprop.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/get_name.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/path_offset.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/subnode_offset.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/find_property.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/root_node.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/get_mem_rsv.c
> 	 DEP /tmp/qemu-test/src/dtc/libfdt/fdt_overlay.c
> 	 DEP /tmp/qemu-test/src/dtc/libfdt/fdt_addresses.c
> 	 DEP /tmp/qemu-test/src/dtc/libfdt/fdt_empty_tree.c
> 	 DEP /tmp/qemu-test/src/dtc/libfdt/fdt_strerror.c
> 	 DEP /tmp/qemu-test/src/dtc/libfdt/fdt_rw.c
> 	 DEP /tmp/qemu-test/src/dtc/libfdt/fdt_sw.c
> 	 DEP /tmp/qemu-test/src/dtc/libfdt/fdt_wip.c
> 	 DEP /tmp/qemu-test/src/dtc/libfdt/fdt_ro.c
> 	 DEP /tmp/qemu-test/src/dtc/libfdt/fdt.c
> 	 DEP /tmp/qemu-test/src/dtc/util.c
> 	 DEP /tmp/qemu-test/src/dtc/fdtoverlay.c
> 	 DEP /tmp/qemu-test/src/dtc/fdtput.c
> 	 DEP /tmp/qemu-test/src/dtc/fdtget.c
> 	 DEP /tmp/qemu-test/src/dtc/fdtdump.c
> 	 LEX convert-dtsv0-lexer.lex.c
> 	 DEP /tmp/qemu-test/src/dtc/srcpos.c
> 	 BISON dtc-parser.tab.c
> 	 LEX dtc-lexer.lex.c
> 	 DEP /tmp/qemu-test/src/dtc/treesource.c
> 	 DEP /tmp/qemu-test/src/dtc/livetree.c
> 	 DEP /tmp/qemu-test/src/dtc/fstree.c
> 	 DEP /tmp/qemu-test/src/dtc/flattree.c
> 	 DEP /tmp/qemu-test/src/dtc/data.c
> 	 DEP /tmp/qemu-test/src/dtc/dtc.c
> 	 DEP /tmp/qemu-test/src/dtc/checks.c
> 	 DEP convert-dtsv0-lexer.lex.c
> 	 DEP dtc-parser.tab.c
> 	 DEP dtc-lexer.lex.c
> 	CHK version_gen.h
> 	UPD version_gen.h
> 	 DEP /tmp/qemu-test/src/dtc/util.c
> 	 CC libfdt/fdt.o
> 	 CC libfdt/fdt_ro.o
> 	 CC libfdt/fdt_sw.o
> 	 CC libfdt/fdt_rw.o
> 	 CC libfdt/fdt_strerror.o
> 	 CC libfdt/fdt_empty_tree.o
> 	 CC libfdt/fdt_wip.o
> 	 CC libfdt/fdt_addresses.o
> 	 CC libfdt/fdt_overlay.o
> 	 AR libfdt/libfdt.a
> ar: creating libfdt/libfdt.a
> a - libfdt/fdt.o
> a - libfdt/fdt_ro.o
> a - libfdt/fdt_wip.o
> a - libfdt/fdt_sw.o
> a - libfdt/fdt_rw.o
> a - libfdt/fdt_strerror.o
> a - libfdt/fdt_empty_tree.o
> a - libfdt/fdt_addresses.o
> a - libfdt/fdt_overlay.o
>   CC      tests/qemu-iotests/socket_scm_helper.o
>   GEN     qemu-monitor.texi
>   GEN     docs/version.texi
>   GEN     qemu-monitor-info.texi
>   GEN     qemu-nbd.8
>   GEN     qemu-options.texi
>   GEN     qemu-img-cmds.texi
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
>   CC      qapi/qapi-visit-migration.o
>   CC      qapi/qapi-visit-job.o
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
>   CC      qobject/qobject.o
>   CC      qobject/qjson.o
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
> In file included from /tmp/qemu-test/src/qapi/qapi-visit-core.c:21:
> In file included from /tmp/qemu-test/build/qapi/trace.h:7:
> In file included from /tmp/qemu-test/src/trace/control.h:270:
> In file included from /tmp/qemu-test/src/trace/control-internal.h:13:
> In file included from /tmp/qemu-test/src/include/qom/cpu.h:30:
> /tmp/qemu-test/src/include/qemu/thread.h:101:1: error: all paths through =
this function will call itself [-Werror,-Winfinite-recursion]
> {
> ^
> 1 error generated.
> /tmp/qemu-test/src/rules.mak:69: recipe for target 'qapi/qapi-visit-core.=
o' failed
> make: *** [qapi/qapi-visit-core.o] Error 1
> make: *** Waiting for unfinished jobs....
> In file included from /tmp/qemu-test/src/qapi/qmp-dispatch.c:21:
> In file included from /tmp/qemu-test/src/include/sysemu/sysemu.h:9:
> In file included from /tmp/qemu-test/src/include/qemu/main-loop.h:28:
> In file included from /tmp/qemu-test/src/include/block/aio.h:20:
> /tmp/qemu-test/src/include/qemu/thread.h:101:1: error: all paths through =
this function will call itself [-Werror,-Winfinite-recursion]
> {
> ^
> 1 error generated.
> /tmp/qemu-test/src/rules.mak:69: recipe for target 'qapi/qmp-dispatch.o' =
failed
> make: *** [qapi/qmp-dispatch.o] Error 1
> In file included from /tmp/qemu-test/src/trace/qmp.c:13:
> In file included from /tmp/qemu-test/src/trace/control.h:270:
> In file included from /tmp/qemu-test/src/trace/control-internal.h:13:
> In file included from /tmp/qemu-test/src/include/qom/cpu.h:30:
> /tmp/qemu-test/src/include/qemu/thread.h:101:1: error: all paths through =
this function will call itself [-Werror,-Winfinite-recursion]
> {
> ^
> 1 error generated.
> In file included from /tmp/qemu-test/src/util/osdep.c:39:
> In file included from /tmp/qemu-test/src/include/monitor/monitor.h:5:
> In file included from /tmp/qemu-test/src/include/block/block.h:4:
> In file included from /tmp/qemu-test/src/include/block/aio.h:20:
> /tmp/qemu-test/src/include/qemu/thread.h:101:1: error: all paths through =
this function will call itself [-Werror,-Winfinite-recursion]
> {
> ^
> 1 error generated.
> /tmp/qemu-test/src/rules.mak:69: recipe for target 'util/osdep.o' failed
> make: *** [util/osdep.o] Error 1
> In file included from /tmp/qemu-test/src/trace/control.c:11:
> In file included from /tmp/qemu-test/src/trace/control.h:270:
> In file included from /tmp/qemu-test/src/trace/control-internal.h:13:
> In file included from /tmp/qemu-test/src/include/qom/cpu.h:30:
> /tmp/qemu-test/src/include/qemu/thread.h:101:1: error: all paths through =
this function will call itself [-Werror,-Winfinite-recursion]
> {
> ^
> 1 error generated.
> /tmp/qemu-test/src/rules.mak:69: recipe for target 'trace/control.o' fail=
ed
> make: *** [trace/control.o] Error 1
> In file included from /tmp/qemu-test/src/util/aiocb.c:26:
> In file included from /tmp/qemu-test/src/include/block/aio.h:20:
> /tmp/qemu-test/src/include/qemu/thread.h:101:1: error: all paths through =
this function will call itself [-Werror,-Winfinite-recursion]
> {
> ^
> 1 error generated.
> /tmp/qemu-test/src/rules.mak:69: recipe for target 'util/aiocb.o' failed
> make: *** [util/aiocb.o] Error 1
> In file included from /tmp/qemu-test/src/util/lockcnt.c:10:
> /tmp/qemu-test/src/include/qemu/thread.h:101:1: error: all paths through =
this function will call itself [-Werror,-Winfinite-recursion]
> {
> ^
> 1 error generated.
> make: *** [util/lockcnt.o] Error 1
> /tmp/qemu-test/src/rules.mak:69: recipe for target 'util/lockcnt.o' failed
> make: *** [trace/qmp.o] Error 1
> /tmp/qemu-test/src/rules.mak:69: recipe for target 'trace/qmp.o' failed
> Traceback (most recent call last):
>   File "./tests/docker/docker.py", line 565, in <module>
>     sys.exit(main())
>   File "./tests/docker/docker.py", line 562, in main
>     return args.cmdobj.run(args, argv)
>   File "./tests/docker/docker.py", line 308, in run
>     return Docker().run(argv, args.keep, quiet=3Dargs.quiet)
>   File "./tests/docker/docker.py", line 276, in run
>     quiet=3Dquiet)
>   File "./tests/docker/docker.py", line 183, in _do_check
>     return subprocess.check_call(self._command + cmd, **kwargs)
>   File "/usr/lib64/python2.7/subprocess.py", line 186, in check_call
>     raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['sudo', '-n', 'docker', 'run', '=
--label', 'com.qemu.instance.uuid=3D3dee4156a28c11e8b93c52540069c830', '-u'=
, '1000', '--security-opt', 'seccomp=3Dunconfined', '--rm', '--net=3Dnone',=
 '-e', 'TARGET_LIST=3D', '-e', 'EXTRA_CONFIGURE_OPTS=3D', '-e', 'V=3D', '-e=
', 'J=3D8', '-e', 'DEBUG=3D', '-e', 'SHOW_ENV=3D1', '-e', 'CCACHE_DIR=3D/va=
r/tmp/ccache', '-v', '/home/patchew/.cache/qemu-docker-ccache:/var/tmp/ccac=
he:z', '-v', '/var/tmp/patchew-tester-tmp-pdpmalc5/src/docker-src.2018-08-1=
7-22.12.51.31192:/var/tmp/qemu:z,ro', 'qemu:ubuntu', '/var/tmp/qemu/run', '=
test-clang']' returned non-zero exit status 2
> make[1]: *** [tests/docker/Makefile.include:216: docker-run] Error 1
> make[1]: Leaving directory '/var/tmp/patchew-tester-tmp-pdpmalc5/src'
> make: *** [tests/docker/Makefile.include:250: docker-run-test-clang@ubunt=
u] Error 2
>=20
> real	1m55.855s
> user	0m4.734s
> sys	0m3.377s
> =3D=3D=3D OUTPUT END =3D=3D=3D
>=20
> Test command exited with code: 2

Could you check if this one is relevant?

Fam
