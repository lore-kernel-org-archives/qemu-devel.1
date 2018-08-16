Received: from eggs.gnu.org ([2001:4830:134:3::10]:47580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fqM4c-0006TN-9P
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 13:28:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fqM4Y-0004gE-9R
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 13:28:38 -0400
References: <153443194444.18476.14489058164586135585@502c9da6d61e>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <b998a9a1-218a-77fa-a217-617213d99848@virtuozzo.com>
Date: Thu, 16 Aug 2018 20:28:14 +0300
MIME-Version: 1.0
In-Reply-To: <153443194444.18476.14489058164586135585@502c9da6d61e>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [RFC v2] new, node-graph-based fleecing and backup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, qemu-block@nongnu.org, kwolf@redhat.com, armbru@redhat.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org, pbonzini@redhat.com, jsnow@redhat.com

Hmm, how should I properly set based-on, if there two series under this o=
ne?

Based on:
    [PATCH v3 0/8] dirty-bitmap: rewrite bdrv_dirty_iter_next_area
    and
    [PATCH 0/2] block: make .bdrv_close optional




16.08.2018 18:05, no-reply@patchew.org wrote:
> Hi,
>
> This series failed docker-mingw@fedora build test. Please find the test=
ing commands and
> their output below. If you have Docker installed, you can probably repr=
oduce it
> locally.
>
> Type: series
> Message-id: 20180814170126.56461-1-vsementsov@virtuozzo.com
> Subject: [Qemu-devel] [RFC v2] new, node-graph-based fleecing and backu=
p
>
> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> #!/bin/bash
> time make docker-test-mingw@fedora SHOW_ENV=3D1 J=3D8
> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>
> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> Switched to a new branch 'test'
> fede2b479e new, node-graph-based fleecing and backup
>
> =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
>    BUILD   fedora
> make[1]: Entering directory '/var/tmp/patchew-tester-tmp-axs4wus0/src'
>    GEN     /var/tmp/patchew-tester-tmp-axs4wus0/src/docker-src.2018-08-=
16-11.04.31.27398/qemu.tar
> Cloning into '/var/tmp/patchew-tester-tmp-axs4wus0/src/docker-src.2018-=
08-16-11.04.31.27398/qemu.tar.vroot'...
> done.
> Checking out files:   8% (537/6322)
> Checking out files:   9% (569/6322)
> Checking out files:  10% (633/6322)
> Checking out files:  11% (696/6322)
> Checking out files:  12% (759/6322)
> Checking out files:  13% (822/6322)
> Checking out files:  13% (870/6322)
> Checking out files:  14% (886/6322)
> Checking out files:  15% (949/6322)
> Checking out files:  16% (1012/6322)
> Checking out files:  17% (1075/6322)
> Checking out files:  18% (1138/6322)
> Checking out files:  19% (1202/6322)
> Checking out files:  20% (1265/6322)
> Checking out files:  21% (1328/6322)
> Checking out files:  22% (1391/6322)
> Checking out files:  23% (1455/6322)
> Checking out files:  24% (1518/6322)
> Checking out files:  25% (1581/6322)
> Checking out files:  26% (1644/6322)
> Checking out files:  26% (1648/6322)
> Checking out files:  27% (1707/6322)
> Checking out files:  28% (1771/6322)
> Checking out files:  29% (1834/6322)
> Checking out files:  30% (1897/6322)
> Checking out files:  31% (1960/6322)
> Checking out files:  32% (2024/6322)
> Checking out files:  33% (2087/6322)
> Checking out files:  34% (2150/6322)
> Checking out files:  35% (2213/6322)
> Checking out files:  36% (2276/6322)
> Checking out files:  37% (2340/6322)
> Checking out files:  38% (2403/6322)
> Checking out files:  39% (2466/6322)
> Checking out files:  40% (2529/6322)
> Checking out files:  41% (2593/6322)
> Checking out files:  42% (2656/6322)
> Checking out files:  43% (2719/6322)
> Checking out files:  44% (2782/6322)
> Checking out files:  45% (2845/6322)
> Checking out files:  46% (2909/6322)
> Checking out files:  47% (2972/6322)
> Checking out files:  48% (3035/6322)
> Checking out files:  49% (3098/6322)
> Checking out files:  50% (3161/6322)
> Checking out files:  51% (3225/6322)
> Checking out files:  52% (3288/6322)
> Checking out files:  53% (3351/6322)
> Checking out files:  54% (3414/6322)
> Checking out files:  55% (3478/6322)
> Checking out files:  56% (3541/6322)
> Checking out files:  57% (3604/6322)
> Checking out files:  58% (3667/6322)
> Checking out files:  59% (3730/6322)
> Checking out files:  60% (3794/6322)
> Checking out files:  61% (3857/6322)
> Checking out files:  62% (3920/6322)
> Checking out files:  63% (3983/6322)
> Checking out files:  64% (4047/6322)
> Checking out files:  65% (4110/6322)
> Checking out files:  66% (4173/6322)
> Checking out files:  67% (4236/6322)
> Checking out files:  68% (4299/6322)
> Checking out files:  69% (4363/6322)
> Checking out files:  70% (4426/6322)
> Checking out files:  71% (4489/6322)
> Checking out files:  72% (4552/6322)
> Checking out files:  73% (4616/6322)
> Checking out files:  74% (4679/6322)
> Checking out files:  75% (4742/6322)
> Checking out files:  76% (4805/6322)
> Checking out files:  77% (4868/6322)
> Checking out files:  78% (4932/6322)
> Checking out files:  79% (4995/6322)
> Checking out files:  80% (5058/6322)
> Checking out files:  81% (5121/6322)
> Checking out files:  82% (5185/6322)
> Checking out files:  83% (5248/6322)
> Checking out files:  84% (5311/6322)
> Checking out files:  85% (5374/6322)
> Checking out files:  86% (5437/6322)
> Checking out files:  87% (5501/6322)
> Checking out files:  88% (5564/6322)
> Checking out files:  89% (5627/6322)
> Checking out files:  90% (5690/6322)
> Checking out files:  91% (5754/6322)
> Checking out files:  92% (5817/6322)
> Checking out files:  93% (5880/6322)
> Checking out files:  94% (5943/6322)
> Checking out files:  95% (6006/6322)
> Checking out files:  96% (6070/6322)
> Checking out files:  97% (6133/6322)
> Checking out files:  98% (6196/6322)
> Checking out files:  99% (6259/6322)
> Checking out files:  99% (6321/6322)
> Checking out files: 100% (6322/6322)
> Checking out files: 100% (6322/6322), done.
> Your branch is up-to-date with 'origin/test'.
> Submodule 'dtc' (git://git.qemu-project.org/dtc.git) registered for pat=
h 'dtc'
> Cloning into '/var/tmp/patchew-tester-tmp-axs4wus0/src/docker-src.2018-=
08-16-11.04.31.27398/qemu.tar.vroot/dtc'...
> Submodule path 'dtc': checked out 'e54388015af1fb4bf04d0bca99caba1074d9=
cc42'
> Submodule 'ui/keycodemapdb' (git://git.qemu.org/keycodemapdb.git) regis=
tered for path 'ui/keycodemapdb'
> Cloning into '/var/tmp/patchew-tester-tmp-axs4wus0/src/docker-src.2018-=
08-16-11.04.31.27398/qemu.tar.vroot/ui/keycodemapdb'...
> Submodule path 'ui/keycodemapdb': checked out '6b3d716e2b6472eb7189d322=
0552280ef3d832ce'
>    COPY    RUNNER
>      RUN test-mingw in qemu:fedora
> Packages installed:
> SDL2-devel-2.0.8-5.fc28.x86_64
> bc-1.07.1-5.fc28.x86_64
> bison-3.0.4-9.fc28.x86_64
> bluez-libs-devel-5.49-3.fc28.x86_64
> brlapi-devel-0.6.7-12.fc28.x86_64
> bzip2-1.0.6-26.fc28.x86_64
> bzip2-devel-1.0.6-26.fc28.x86_64
> ccache-3.4.2-2.fc28.x86_64
> clang-6.0.0-5.fc28.x86_64
> device-mapper-multipath-devel-0.7.4-2.git07e7bd5.fc28.x86_64
> findutils-4.6.0-19.fc28.x86_64
> flex-2.6.1-7.fc28.x86_64
> gcc-8.1.1-1.fc28.x86_64
> gcc-c++-8.1.1-1.fc28.x86_64
> gettext-0.19.8.1-14.fc28.x86_64
> git-2.17.1-2.fc28.x86_64
> glib2-devel-2.56.1-3.fc28.x86_64
> glusterfs-api-devel-4.0.2-1.fc28.x86_64
> gnutls-devel-3.6.2-1.fc28.x86_64
> gtk3-devel-3.22.30-1.fc28.x86_64
> hostname-3.20-3.fc28.x86_64
> libaio-devel-0.3.110-11.fc28.x86_64
> libasan-8.1.1-1.fc28.x86_64
> libattr-devel-2.4.47-23.fc28.x86_64
> libcap-devel-2.25-9.fc28.x86_64
> libcap-ng-devel-0.7.9-1.fc28.x86_64
> libcurl-devel-7.59.0-3.fc28.x86_64
> libfdt-devel-1.4.6-4.fc28.x86_64
> libpng-devel-1.6.34-3.fc28.x86_64
> librbd-devel-12.2.5-1.fc28.x86_64
> libssh2-devel-1.8.0-7.fc28.x86_64
> libubsan-8.1.1-1.fc28.x86_64
> libusbx-devel-1.0.21-6.fc28.x86_64
> libxml2-devel-2.9.7-4.fc28.x86_64
> llvm-6.0.0-11.fc28.x86_64
> lzo-devel-2.08-12.fc28.x86_64
> make-4.2.1-6.fc28.x86_64
> mingw32-SDL2-2.0.5-3.fc27.noarch
> mingw32-bzip2-1.0.6-9.fc27.noarch
> mingw32-curl-7.57.0-1.fc28.noarch
> mingw32-glib2-2.54.1-1.fc28.noarch
> mingw32-gmp-6.1.2-2.fc27.noarch
> mingw32-gnutls-3.5.13-2.fc27.noarch
> mingw32-gtk3-3.22.16-1.fc27.noarch
> mingw32-libjpeg-turbo-1.5.1-3.fc27.noarch
> mingw32-libpng-1.6.29-2.fc27.noarch
> mingw32-libssh2-1.8.0-3.fc27.noarch
> mingw32-libtasn1-4.13-1.fc28.noarch
> mingw32-nettle-3.3-3.fc27.noarch
> mingw32-pixman-0.34.0-3.fc27.noarch
> mingw32-pkg-config-0.28-9.fc27.x86_64
> mingw64-SDL2-2.0.5-3.fc27.noarch
> mingw64-bzip2-1.0.6-9.fc27.noarch
> mingw64-curl-7.57.0-1.fc28.noarch
> mingw64-glib2-2.54.1-1.fc28.noarch
> mingw64-gmp-6.1.2-2.fc27.noarch
> mingw64-gnutls-3.5.13-2.fc27.noarch
> mingw64-gtk3-3.22.16-1.fc27.noarch
> mingw64-libjpeg-turbo-1.5.1-3.fc27.noarch
> mingw64-libpng-1.6.29-2.fc27.noarch
> mingw64-libssh2-1.8.0-3.fc27.noarch
> mingw64-libtasn1-4.13-1.fc28.noarch
> mingw64-nettle-3.3-3.fc27.noarch
> mingw64-pixman-0.34.0-3.fc27.noarch
> mingw64-pkg-config-0.28-9.fc27.x86_64
> ncurses-devel-6.1-5.20180224.fc28.x86_64
> nettle-devel-3.4-2.fc28.x86_64
> nss-devel-3.36.1-1.1.fc28.x86_64
> numactl-devel-2.0.11-8.fc28.x86_64
> package PyYAML is not installed
> package libjpeg-devel is not installed
> perl-5.26.2-411.fc28.x86_64
> pixman-devel-0.34.0-8.fc28.x86_64
> python3-3.6.5-1.fc28.x86_64
> snappy-devel-1.1.7-5.fc28.x86_64
> sparse-0.5.2-1.fc28.x86_64
> spice-server-devel-0.14.0-4.fc28.x86_64
> systemtap-sdt-devel-3.2-11.fc28.x86_64
> tar-1.30-3.fc28.x86_64
> usbredir-devel-0.7.1-7.fc28.x86_64
> virglrenderer-devel-0.6.0-4.20170210git76b3da97b.fc28.x86_64
> vte3-devel-0.36.5-6.fc28.x86_64
> which-2.21-8.fc28.x86_64
> xen-devel-4.10.1-3.fc28.x86_64
> zlib-devel-1.2.11-8.fc28.x86_64
>
> Environment variables:
> TARGET_LIST=3D
> PACKAGES=3Dccache gettext git tar PyYAML sparse flex bison python3 bzip=
2 hostname     gcc gcc-c++ llvm clang make perl which bc findutils glib2-=
devel     libaio-devel pixman-devel zlib-devel libfdt-devel libasan libub=
san     bluez-libs-devel brlapi-devel bzip2-devel     device-mapper-multi=
path-devel glusterfs-api-devel gnutls-devel     gtk3-devel libattr-devel =
libcap-devel libcap-ng-devel libcurl-devel     libjpeg-devel libpng-devel=
 librbd-devel libssh2-devel libusbx-devel     libxml2-devel lzo-devel ncu=
rses-devel nettle-devel nss-devel     numactl-devel SDL2-devel snappy-dev=
el spice-server-devel     systemtap-sdt-devel usbredir-devel virglrendere=
r-devel vte3-devel     xen-devel     mingw32-pixman mingw32-glib2 mingw32=
-gmp mingw32-SDL2 mingw32-pkg-config     mingw32-gtk3 mingw32-gnutls ming=
w32-nettle mingw32-libtasn1     mingw32-libjpeg-turbo mingw32-libpng ming=
w32-curl mingw32-libssh2     mingw32-bzip2     mingw64-pixman mingw64-gli=
b2 mingw64-gmp mingw64-SDL2 mingw64-pkg-config     mingw64-gtk3 mingw64-g=
nutls mingw64-nettle mingw64-libtasn1     mingw64-libjpeg-turbo mingw64-l=
ibpng mingw64-curl mingw64-libssh2     mingw64-bzip2
> J=3D8
> V=3D
> HOSTNAME=3D2d66dc589b5e
> DEBUG=3D
> SHOW_ENV=3D1
> PWD=3D/
> HOME=3D/
> CCACHE_DIR=3D/var/tmp/ccache
> DISTTAG=3Df28container
> QEMU_CONFIGURE_OPTS=3D--python=3D/usr/bin/python3
> FGC=3Df28
> TEST_DIR=3D/tmp/qemu-test
> SHLVL=3D1
> FEATURES=3Dmingw clang pyyaml asan dtc
> PATH=3D/usr/lib/ccache:/usr/lib64/ccache:/usr/local/sbin:/usr/local/bin=
:/usr/sbin:/usr/bin:/sbin:/bin
> MAKEFLAGS=3D -j8
> EXTRA_CONFIGURE_OPTS=3D
> _=3D/usr/bin/env
>
> Configure options:
> --enable-werror --target-list=3Dx86_64-softmmu,aarch64-softmmu --prefix=
=3D/tmp/qemu-test/install --python=3D/usr/bin/python3 --cross-prefix=3Dx8=
6_64-w64-mingw32- --enable-trace-backends=3Dsimple --enable-gnutls --enab=
le-nettle --enable-curl --enable-vnc --enable-bzip2 --enable-guest-agent =
--with-sdlabi=3D2.0 --with-gtkabi=3D3.0
> Install prefix    /tmp/qemu-test/install
> BIOS directory    /tmp/qemu-test/install
> firmware path     /tmp/qemu-test/install/share/qemu-firmware
> binary directory  /tmp/qemu-test/install
> library directory /tmp/qemu-test/install/lib
> module directory  /tmp/qemu-test/install/lib
> libexec directory /tmp/qemu-test/install/libexec
> include directory /tmp/qemu-test/install/include
> config directory  /tmp/qemu-test/install
> local state directory   queried at runtime
> Windows SDK       no
> Source path       /tmp/qemu-test/src
> GIT binary        git
> GIT submodules
> C compiler        x86_64-w64-mingw32-gcc
> Host C compiler   cc
> C++ compiler      x86_64-w64-mingw32-g++
> Objective-C compiler clang
> ARFLAGS           rv
> CFLAGS            -O2 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=3D2 -g
> QEMU_CFLAGS       -I/usr/x86_64-w64-mingw32/sys-root/mingw/include/pixm=
an-1  -I$(SRC_PATH)/dtc/libfdt -Werror -DHAS_LIBSSH2_SFTP_FSYNC -mms-bitf=
ields -I/usr/x86_64-w64-mingw32/sys-root/mingw/include/glib-2.0 -I/usr/x8=
6_64-w64-mingw32/sys-root/mingw/lib/glib-2.0/include -I/usr/x86_64-w64-mi=
ngw32/sys-root/mingw/include  -m64 -mcx16 -mthreads -D__USE_MINGW_ANSI_ST=
DIO=3D1 -DWIN32_LEAN_AND_MEAN -DWINVER=3D0x501 -D_GNU_SOURCE -D_FILE_OFFS=
ET_BITS=3D64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -W=
all -Wundef -Wwrite-strings -Wmissing-prototypes -fno-strict-aliasing -fn=
o-common -fwrapv  -Wexpansion-to-defined -Wendif-labels -Wno-shift-negati=
ve-value -Wno-missing-include-dirs -Wempty-body -Wnested-externs -Wformat=
-security -Wformat-y2k -Winit-self -Wignored-qualifiers -Wold-style-decla=
ration -Wold-style-definition -Wtype-limits -fstack-protector-strong -I/u=
sr/x86_64-w64-mingw32/sys-root/mingw/include -I/usr/x86_64-w64-mingw32/sy=
s-root/mingw/include/p11-kit-1 -I/usr/x86_64-w64-mingw32/sys-root/mingw/i=
nclude  -I/usr/x86_64-w64-mingw32/sys-root/mingw/include   -I/usr/x86_64-=
w64-mingw32/sys-root/mingw/include/libpng16
> LDFLAGS           -Wl,--nxcompat -Wl,--no-seh -Wl,--dynamicbase -Wl,--w=
arn-common -m64 -g
> QEMU_LDFLAGS      -L$(BUILD_DIR)/dtc/libfdt
> make              make
> install           install
> python            /usr/bin/python3 -B
> smbd              /usr/sbin/smbd
> module support    no
> host CPU          x86_64
> host big endian   no
> target list       x86_64-softmmu aarch64-softmmu
> gprof enabled     no
> sparse enabled    no
> strip binaries    yes
> profiler          no
> static build      no
> SDL support       yes (2.0.5)
> GTK support       yes (3.22.16)
> GTK GL support    no
> VTE support       no
> TLS priority      NORMAL
> GNUTLS support    yes
> GNUTLS rnd        yes
> libgcrypt         no
> libgcrypt kdf     no
> nettle            yes (3.3)
> nettle kdf        yes
> libtasn1          yes
> curses support    no
> virgl support     no
> curl support      yes
> mingw32 support   yes
> Audio drivers     dsound
> Block whitelist (rw)
> Block whitelist (ro)
> VirtFS support    no
> Multipath support no
> VNC support       yes
> VNC SASL support  no
> VNC JPEG support  yes
> VNC PNG support   yes
> xen support       no
> brlapi support    no
> bluez  support    no
> Documentation     no
> PIE               no
> vde support       no
> netmap support    no
> Linux AIO support no
> ATTR/XATTR support no
> Install blobs     yes
> KVM support       no
> HAX support       yes
> HVF support       no
> WHPX support      no
> TCG support       yes
> TCG debug enabled no
> TCG interpreter   no
> malloc trim support no
> RDMA support      no
> fdt support       git
> membarrier        no
> preadv support    no
> fdatasync         no
> madvise           no
> posix_madvise     no
> posix_memalign    no
> libcap-ng support no
> vhost-net support no
> vhost-crypto support no
> vhost-scsi support no
> vhost-vsock support no
> vhost-user support no
> Trace backends    simple
> Trace output file trace-<pid>
> spice support     no
> rbd support       no
> xfsctl support    no
> smartcard support no
> libusb            no
> usb net redir     no
> OpenGL support    no
> OpenGL dmabufs    no
> libiscsi support  no
> libnfs support    no
> build guest agent yes
> QGA VSS support   no
> QGA w32 disk info yes
> QGA MSI support   no
> seccomp support   no
> coroutine backend win32
> coroutine pool    yes
> debug stack usage no
> mutex debugging   no
> crypto afalg      no
> GlusterFS support no
> gcov              gcov
> gcov enabled      no
> TPM support       yes
> libssh2 support   yes
> TPM passthrough   no
> TPM emulator      no
> QOM debugging     yes
> Live block migration yes
> lzo support       no
> snappy support    no
> bzip2 support     yes
> NUMA host support no
> libxml2           no
> tcmalloc support  no
> jemalloc support  no
> avx2 optimization yes
> replication support yes
> VxHS block device no
> capstone          no
> docker            no
>
> NOTE: cross-compilers enabled:  'x86_64-w64-mingw32-gcc'
>    GEN     x86_64-softmmu/config-devices.mak.tmp
>    GEN     aarch64-softmmu/config-devices.mak.tmp
>    GEN     config-host.h
>    GEN     qemu-options.def
>    GEN     qapi-gen
>    GEN     trace/generated-tcg-tracers.h
>    GEN     trace/generated-helpers-wrappers.h
>    GEN     trace/generated-helpers.h
>    GEN     aarch64-softmmu/config-devices.mak
>    GEN     x86_64-softmmu/config-devices.mak
>    GEN     trace/generated-helpers.c
>    GEN     module_block.h
>    GEN     ui/input-keymap-atset1-to-qcode.c
>    GEN     ui/input-keymap-linux-to-qcode.c
>    GEN     ui/input-keymap-qcode-to-atset1.c
>    GEN     ui/input-keymap-qcode-to-atset2.c
>    GEN     ui/input-keymap-qcode-to-atset3.c
>    GEN     ui/input-keymap-qcode-to-linux.c
>    GEN     ui/input-keymap-qcode-to-qnum.c
>    GEN     ui/input-keymap-qcode-to-sun.c
>    GEN     ui/input-keymap-qnum-to-qcode.c
>    GEN     ui/input-keymap-usb-to-qcode.c
>    GEN     ui/input-keymap-win32-to-qcode.c
>    GEN     ui/input-keymap-x11-to-qcode.c
>    GEN     ui/input-keymap-xorgevdev-to-qcode.c
>    GEN     ui/input-keymap-xorgkbd-to-qcode.c
>    GEN     ui/input-keymap-xorgxquartz-to-qcode.c
>    GEN     ui/input-keymap-xorgxwin-to-qcode.c
>    GEN     ui/input-keymap-osx-to-qcode.c
>    GEN     tests/test-qapi-gen
>    GEN     trace-root.h
>    GEN     accel/kvm/trace.h
>    GEN     accel/tcg/trace.h
>    GEN     audio/trace.h
>    GEN     block/trace.h
>    GEN     chardev/trace.h
>    GEN     crypto/trace.h
>    GEN     hw/9pfs/trace.h
>    GEN     hw/acpi/trace.h
>    GEN     hw/alpha/trace.h
>    GEN     hw/arm/trace.h
>    GEN     hw/audio/trace.h
>    GEN     hw/block/trace.h
>    GEN     hw/block/dataplane/trace.h
>    GEN     hw/char/trace.h
>    GEN     hw/display/trace.h
>    GEN     hw/dma/trace.h
>    GEN     hw/hppa/trace.h
>    GEN     hw/i2c/trace.h
>    GEN     hw/i386/trace.h
>    GEN     hw/i386/xen/trace.h
>    GEN     hw/ide/trace.h
>    GEN     hw/input/trace.h
>    GEN     hw/intc/trace.h
>    GEN     hw/isa/trace.h
>    GEN     hw/mem/trace.h
>    GEN     hw/misc/trace.h
>    GEN     hw/misc/macio/trace.h
>    GEN     hw/net/trace.h
>    GEN     hw/nvram/trace.h
>    GEN     hw/pci/trace.h
>    GEN     hw/pci-host/trace.h
>    GEN     hw/ppc/trace.h
>    GEN     hw/rdma/trace.h
>    GEN     hw/rdma/vmw/trace.h
>    GEN     hw/s390x/trace.h
>    GEN     hw/scsi/trace.h
>    GEN     hw/sd/trace.h
>    GEN     hw/sparc/trace.h
>    GEN     hw/sparc64/trace.h
>    GEN     hw/timer/trace.h
>    GEN     hw/tpm/trace.h
>    GEN     hw/usb/trace.h
>    GEN     hw/vfio/trace.h
>    GEN     hw/virtio/trace.h
>    GEN     hw/xen/trace.h
>    GEN     io/trace.h
>    GEN     linux-user/trace.h
>    GEN     migration/trace.h
>    GEN     nbd/trace.h
>    GEN     net/trace.h
>    GEN     qapi/trace.h
>    GEN     qom/trace.h
>    GEN     scsi/trace.h
>    GEN     target/arm/trace.h
>    GEN     target/i386/trace.h
>    GEN     target/mips/trace.h
>    GEN     target/ppc/trace.h
>    GEN     target/s390x/trace.h
>    GEN     target/sparc/trace.h
>    GEN     ui/trace.h
>    GEN     util/trace.h
>    GEN     trace-root.c
>    GEN     accel/kvm/trace.c
>    GEN     accel/tcg/trace.c
>    GEN     audio/trace.c
>    GEN     block/trace.c
>    GEN     chardev/trace.c
>    GEN     crypto/trace.c
>    GEN     hw/9pfs/trace.c
>    GEN     hw/acpi/trace.c
>    GEN     hw/alpha/trace.c
>    GEN     hw/arm/trace.c
>    GEN     hw/audio/trace.c
>    GEN     hw/block/trace.c
>    GEN     hw/block/dataplane/trace.c
>    GEN     hw/char/trace.c
>    GEN     hw/display/trace.c
>    GEN     hw/dma/trace.c
>    GEN     hw/hppa/trace.c
>    GEN     hw/i2c/trace.c
>    GEN     hw/i386/trace.c
>    GEN     hw/i386/xen/trace.c
>    GEN     hw/ide/trace.c
>    GEN     hw/input/trace.c
>    GEN     hw/intc/trace.c
>    GEN     hw/isa/trace.c
>    GEN     hw/mem/trace.c
>    GEN     hw/misc/trace.c
>    GEN     hw/misc/macio/trace.c
>    GEN     hw/net/trace.c
>    GEN     hw/nvram/trace.c
>    GEN     hw/pci/trace.c
>    GEN     hw/pci-host/trace.c
>    GEN     hw/ppc/trace.c
>    GEN     hw/rdma/trace.c
>    GEN     hw/rdma/vmw/trace.c
>    GEN     hw/s390x/trace.c
>    GEN     hw/scsi/trace.c
>    GEN     hw/sd/trace.c
>    GEN     hw/sparc/trace.c
>    GEN     hw/sparc64/trace.c
>    GEN     hw/timer/trace.c
>    GEN     hw/tpm/trace.c
>    GEN     hw/usb/trace.c
>    GEN     hw/vfio/trace.c
>    GEN     hw/virtio/trace.c
>    GEN     hw/xen/trace.c
>    GEN     io/trace.c
>    GEN     linux-user/trace.c
>    GEN     migration/trace.c
>    GEN     nbd/trace.c
>    GEN     net/trace.c
>    GEN     qapi/trace.c
>    GEN     qom/trace.c
>    GEN     scsi/trace.c
>    GEN     target/arm/trace.c
>    GEN     target/i386/trace.c
>    GEN     target/mips/trace.c
>    GEN     target/ppc/trace.c
>    GEN     target/s390x/trace.c
>    GEN     target/sparc/trace.c
>    GEN     ui/trace.c
>    GEN     util/trace.c
>    GEN     config-all-devices.mak
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
> 	 DEP /tmp/qemu-test/src/dtc/tests/dtb_reverse.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/dtbs_equal_unordered.c
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
> 	 DEP /tmp/qemu-test/src/dtc/tests/nop_node.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/sw_tree1.c
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
> 	 DEP /tmp/qemu-test/src/dtc/tests/parent_offset.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/node_offset_by_prop_value.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/supernode_atdepth_offset.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/get_phandle.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/get_path.c
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
> 	 DEP /tmp/qemu-test/src/dtc/fdtoverlay.c
> 	 DEP /tmp/qemu-test/src/dtc/util.c
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
> 	 DEP /tmp/qemu-test/src/dtc/dtc.c
> 	 DEP /tmp/qemu-test/src/dtc/data.c
> 	 DEP /tmp/qemu-test/src/dtc/checks.c
> 	 DEP convert-dtsv0-lexer.lex.c
> 	 DEP dtc-parser.tab.c
> 	 DEP dtc-lexer.lex.c
> 	CHK version_gen.h
> 	UPD version_gen.h
> 	 DEP /tmp/qemu-test/src/dtc/util.c
> 	 CC libfdt/fdt.o
> 	 CC libfdt/fdt_ro.o
> 	 CC libfdt/fdt_wip.o
> 	 CC libfdt/fdt_rw.o
> 	 CC libfdt/fdt_sw.o
> 	 CC libfdt/fdt_strerror.o
> 	 CC libfdt/fdt_empty_tree.o
> 	 CC libfdt/fdt_addresses.o
> 	 CC libfdt/fdt_overlay.o
> 	 AR libfdt/libfdt.a
> x86_64-w64-mingw32-ar: creating libfdt/libfdt.a
> a - libfdt/fdt.o
> a - libfdt/fdt_ro.o
> a - libfdt/fdt_wip.o
> a - libfdt/fdt_sw.o
> a - libfdt/fdt_rw.o
> a - libfdt/fdt_strerror.o
> a - libfdt/fdt_empty_tree.o
> a - libfdt/fdt_addresses.o
> a - libfdt/fdt_overlay.o
>    RC      version.o
>    GEN     qga/qapi-generated/qapi-gen
>    CC      qapi/qapi-types.o
>    CC      qapi/qapi-types-block-core.o
>    CC      qapi/qapi-types-block.o
>    CC      qapi/qapi-builtin-types.o
>    CC      qapi/qapi-types-common.o
>    CC      qapi/qapi-types-char.o
>    CC      qapi/qapi-types-crypto.o
>    CC      qapi/qapi-types-introspect.o
>    CC      qapi/qapi-types-job.o
>    CC      qapi/qapi-types-migration.o
>    CC      qapi/qapi-types-misc.o
>    CC      qapi/qapi-types-net.o
>    CC      qapi/qapi-types-rocker.o
>    CC      qapi/qapi-types-run-state.o
>    CC      qapi/qapi-types-sockets.o
>    CC      qapi/qapi-types-tpm.o
>    CC      qapi/qapi-types-transaction.o
>    CC      qapi/qapi-types-ui.o
>    CC      qapi/qapi-types-trace.o
>    CC      qapi/qapi-builtin-visit.o
>    CC      qapi/qapi-visit.o
>    CC      qapi/qapi-visit-block-core.o
>    CC      qapi/qapi-visit-block.o
>    CC      qapi/qapi-visit-char.o
>    CC      qapi/qapi-visit-common.o
>    CC      qapi/qapi-visit-crypto.o
>    CC      qapi/qapi-visit-introspect.o
>    CC      qapi/qapi-visit-job.o
>    CC      qapi/qapi-visit-migration.o
>    CC      qapi/qapi-visit-misc.o
>    CC      qapi/qapi-visit-net.o
>    CC      qapi/qapi-visit-rocker.o
>    CC      qapi/qapi-visit-run-state.o
>    CC      qapi/qapi-visit-sockets.o
>    CC      qapi/qapi-visit-tpm.o
>    CC      qapi/qapi-visit-trace.o
>    CC      qapi/qapi-visit-transaction.o
>    CC      qapi/qapi-events-block-core.o
>    CC      qapi/qapi-events.o
>    CC      qapi/qapi-visit-ui.o
>    CC      qapi/qapi-events-block.o
>    CC      qapi/qapi-events-char.o
>    CC      qapi/qapi-events-common.o
>    CC      qapi/qapi-events-crypto.o
>    CC      qapi/qapi-events-introspect.o
>    CC      qapi/qapi-events-job.o
>    CC      qapi/qapi-events-migration.o
>    CC      qapi/qapi-events-misc.o
>    CC      qapi/qapi-events-net.o
>    CC      qapi/qapi-events-rocker.o
>    CC      qapi/qapi-events-sockets.o
>    CC      qapi/qapi-events-tpm.o
>    CC      qapi/qapi-events-transaction.o
>    CC      qapi/qapi-events-run-state.o
>    CC      qapi/qapi-events-ui.o
>    CC      qapi/qapi-events-trace.o
>    CC      qapi/qapi-introspect.o
>    CC      qapi/qapi-visit-core.o
>    CC      qapi/qapi-dealloc-visitor.o
>    CC      qapi/qobject-input-visitor.o
>    CC      qapi/qobject-output-visitor.o
>    CC      qapi/qmp-registry.o
>    CC      qapi/qmp-dispatch.o
>    CC      qapi/string-output-visitor.o
>    CC      qapi/opts-visitor.o
>    CC      qapi/string-input-visitor.o
>    CC      qapi/qapi-clone-visitor.o
>    CC      qapi/qmp-event.o
>    CC      qapi/qapi-util.o
>    CC      qobject/qnull.o
>    CC      qobject/qnum.o
>    CC      qobject/qstring.o
>    CC      qobject/qdict.o
>    CC      qobject/qlist.o
>    CC      qobject/qbool.o
>    CC      qobject/qlit.o
>    CC      qobject/qjson.o
>    CC      qobject/qobject.o
>    CC      qobject/json-lexer.o
>    CC      qobject/json-streamer.o
>    CC      qobject/json-parser.o
>    CC      qobject/block-qdict.o
>    CC      trace/simple.o
>    CC      trace/control.o
>    CC      trace/qmp.o
>    CC      util/osdep.o
>    CC      util/cutils.o
>    CC      util/unicode.o
>    CC      util/qemu-timer-common.o
>    CC      util/lockcnt.o
>    CC      util/bufferiszero.o
>    CC      util/aiocb.o
>    CC      util/async.o
>    CC      util/aio-wait.o
>    CC      util/thread-pool.o
>    CC      util/qemu-timer.o
>    CC      util/main-loop.o
>    CC      util/iohandler.o
>    CC      util/aio-win32.o
>    CC      util/event_notifier-win32.o
>    CC      util/oslib-win32.o
>    CC      util/qemu-thread-win32.o
>    CC      util/envlist.o
>    CC      util/path.o
>    CC      util/module.o
>    CC      util/host-utils.o
>    CC      util/bitmap.o
>    CC      util/bitops.o
>    CC      util/hbitmap.o
>    CC      util/fifo8.o
>    CC      util/acl.o
>    CC      util/cacheinfo.o
>    CC      util/error.o
>    CC      util/qemu-error.o
>    CC      util/id.o
>    CC      util/iov.o
>    CC      util/qemu-config.o
>    CC      util/qemu-sockets.o
>    CC      util/notify.o
>    CC      util/uri.o
>    CC      util/qemu-progress.o
>    CC      util/qemu-option.o
>    CC      util/keyval.o
>    CC      util/hexdump.o
>    CC      util/crc32c.o
>    CC      util/uuid.o
>    CC      util/throttle.o
>    CC      util/readline.o
>    CC      util/getauxval.o
>    CC      util/rcu.o
>    CC      util/qemu-coroutine.o
>    CC      util/qemu-coroutine-lock.o
>    CC      util/qemu-coroutine-io.o
>    CC      util/qemu-coroutine-sleep.o
>    CC      util/coroutine-win32.o
>    CC      util/timed-average.o
>    CC      util/buffer.o
>    CC      util/base64.o
>    CC      util/log.o
>    CC      util/pagesize.o
>    CC      util/qdist.o
>    CC      util/qht.o
>    CC      util/range.o
>    CC      util/stats64.o
>    CC      util/systemd.o
>    CC      util/iova-tree.o
>    CC      trace-root.o
>    CC      accel/kvm/trace.o
>    CC      accel/tcg/trace.o
>    CC      block/trace.o
>    CC      audio/trace.o
>    CC      chardev/trace.o
>    CC      crypto/trace.o
>    CC      hw/9pfs/trace.o
>    CC      hw/acpi/trace.o
>    CC      hw/alpha/trace.o
>    CC      hw/arm/trace.o
>    CC      hw/audio/trace.o
>    CC      hw/block/trace.o
>    CC      hw/block/dataplane/trace.o
>    CC      hw/char/trace.o
>    CC      hw/display/trace.o
>    CC      hw/dma/trace.o
>    CC      hw/hppa/trace.o
>    CC      hw/i2c/trace.o
>    CC      hw/i386/trace.o
>    CC      hw/i386/xen/trace.o
>    CC      hw/ide/trace.o
>    CC      hw/input/trace.o
>    CC      hw/intc/trace.o
>    CC      hw/isa/trace.o
>    CC      hw/mem/trace.o
>    CC      hw/misc/trace.o
>    CC      hw/misc/macio/trace.o
>    CC      hw/net/trace.o
>    CC      hw/nvram/trace.o
>    CC      hw/pci/trace.o
>    CC      hw/pci-host/trace.o
>    CC      hw/rdma/trace.o
>    CC      hw/ppc/trace.o
>    CC      hw/rdma/vmw/trace.o
>    CC      hw/s390x/trace.o
>    CC      hw/scsi/trace.o
>    CC      hw/sd/trace.o
>    CC      hw/sparc/trace.o
>    CC      hw/sparc64/trace.o
>    CC      hw/timer/trace.o
>    CC      hw/tpm/trace.o
>    CC      hw/usb/trace.o
>    CC      hw/vfio/trace.o
>    CC      hw/virtio/trace.o
>    CC      io/trace.o
>    CC      hw/xen/trace.o
>    CC      linux-user/trace.o
>    CC      nbd/trace.o
>    CC      net/trace.o
>    CC      qapi/trace.o
>    CC      migration/trace.o
>    CC      qom/trace.o
>    CC      scsi/trace.o
>    CC      target/arm/trace.o
>    CC      target/i386/trace.o
>    CC      target/mips/trace.o
>    CC      target/ppc/trace.o
>    CC      target/s390x/trace.o
>    CC      ui/trace.o
>    CC      target/sparc/trace.o
>    CC      util/trace.o
>    CC      crypto/pbkdf-stub.o
>    CC      stubs/arch-query-cpu-def.o
>    CC      stubs/arch-query-cpu-model-expansion.o
>    CC      stubs/arch-query-cpu-model-comparison.o
>    CC      stubs/arch-query-cpu-model-baseline.o
>    CC      stubs/bdrv-next-monitor-owned.o
>    CC      stubs/blk-commit-all.o
>    CC      stubs/blockdev-close-all-bdrv-states.o
>    CC      stubs/clock-warp.o
>    CC      stubs/cpu-get-clock.o
>    CC      stubs/cpu-get-icount.o
>    CC      stubs/error-printf.o
>    CC      stubs/dump.o
>    CC      stubs/fdset.o
>    CC      stubs/gdbstub.o
>    CC      stubs/get-vm-name.o
>    CC      stubs/iothread.o
>    CC      stubs/iothread-lock.o
>    CC      stubs/is-daemonized.o
>    CC      stubs/machine-init-done.o
>    CC      stubs/migr-blocker.o
>    CC      stubs/change-state-handler.o
>    CC      stubs/monitor.o
>    CC      stubs/notify-event.o
>    CC      stubs/qtest.o
>    CC      stubs/replay.o
>    CC      stubs/runstate-check.o
>    CC      stubs/set-fd-handler.o
>    CC      stubs/slirp.o
>    CC      stubs/sysbus.o
>    CC      stubs/tpm.o
>    CC      stubs/trace-control.o
>    CC      stubs/uuid.o
>    CC      stubs/vm-stop.o
>    CC      stubs/vmstate.o
>    CC      stubs/fd-register.o
>    CC      stubs/qmp_memory_device.o
>    CC      stubs/target-monitor-defs.o
>    CC      stubs/target-get-monitor-def.o
>    CC      stubs/pc_madt_cpu_entry.o
>    CC      stubs/vmgenid.o
>    CC      stubs/xen-common.o
>    CC      stubs/xen-hvm.o
>    CC      stubs/pci-host-piix.o
>    CC      stubs/ram-block.o
>    GEN     qemu-img-cmds.h
>    CC      blockjob.o
>    CC      block.o
>    CC      job.o
>    CC      replication.o
>    CC      qemu-io-cmds.o
>    CC      block/raw-format.o
>    CC      block/qcow.o
>    CC      block/vdi.o
>    CC      block/vmdk.o
>    CC      block/cloop.o
>    CC      block/bochs.o
>    CC      block/vvfat.o
>    CC      block/vpc.o
>    CC      block/dmg.o
>    CC      block/qcow2.o
>    CC      block/qcow2-refcount.o
>    CC      block/qcow2-cluster.o
>    CC      block/qcow2-snapshot.o
>    CC      block/qcow2-bitmap.o
>    CC      block/qcow2-cache.o
>    CC      block/qed-l2-cache.o
>    CC      block/qed.o
>    CC      block/qed-table.o
>    CC      block/qed-cluster.o
>    CC      block/qed-check.o
>    CC      block/vhdx.o
>    CC      block/vhdx-endian.o
>    CC      block/vhdx-log.o
>    CC      block/quorum.o
>    CC      block/parallels.o
>    CC      block/blkdebug.o
>    CC      block/blkverify.o
>    CC      block/blkreplay.o
>    CC      block/blklogwrites.o
>    CC      block/block-backend.o
>    CC      block/snapshot.o
>    CC      block/file-win32.o
>    CC      block/win32-aio.o
>    CC      block/null.o
>    CC      block/qapi.o
>    CC      block/mirror.o
>    CC      block/commit.o
>    CC      block/io.o
>    CC      block/create.o
>    CC      block/throttle-groups.o
>    CC      block/nbd.o
>    CC      block/nbd-client.o
>    CC      block/sheepdog.o
>    CC      block/accounting.o
>    CC      block/dirty-bitmap.o
>    CC      block/write-threshold.o
>    CC      block/backup.o
>    CC      block/replication.o
>    CC      block/throttle.o
>    CC      block/copy-on-read.o
>    CC      block/crypto.o
>    CC      block/fleecing-hook.o
>    CC      nbd/server.o
>    CC      nbd/client.o
>    CC      nbd/common.o
>    CC      scsi/utils.o
>    CC      scsi/pr-manager-stub.o
>    CC      block/curl.o
>    CC      block/ssh.o
>    CC      block/dmg-bz2.o
>    CC      crypto/init.o
>    CC      crypto/hash-nettle.o
>    CC      crypto/hash.o
>    CC      crypto/hmac.o
>    CC      crypto/hmac-nettle.o
>    CC      crypto/aes.o
>    CC      crypto/desrfb.o
>    CC      crypto/cipher.o
>    CC      crypto/tlscreds.o
>    CC      crypto/tlscredsanon.o
>    CC      crypto/tlscredspsk.o
>    CC      crypto/tlscredsx509.o
>    CC      crypto/tlssession.o
>    CC      crypto/secret.o
>    CC      crypto/random-gnutls.o
>    CC      crypto/pbkdf.o
>    CC      crypto/pbkdf-nettle.o
>    CC      crypto/ivgen.o
>    CC      crypto/ivgen-essiv.o
>    CC      crypto/ivgen-plain.o
>    CC      crypto/ivgen-plain64.o
>    CC      crypto/afsplit.o
>    CC      crypto/xts.o
>    CC      crypto/block.o
>    CC      crypto/block-qcow.o
>    CC      crypto/block-luks.o
>    CC      io/channel.o
>    CC      io/channel-buffer.o
>    CC      io/channel-command.o
>    CC      io/channel-file.o
>    CC      io/channel-socket.o
>    CC      io/channel-tls.o
>    CC      io/channel-watch.o
>    CC      io/channel-websock.o
>    CC      io/channel-util.o
>    CC      io/dns-resolver.o
>    CC      io/net-listener.o
>    CC      io/task.o
>    CC      qom/object.o
>    CC      qom/container.o
>    CC      qom/qom-qobject.o
>    CC      qom/object_interfaces.o
>    CC      qemu-io.o
>    CC      blockdev.o
>    CC      blockdev-nbd.o
>    CC      bootdevice.o
>    CC      iothread.o
>    CC      job-qmp.o
>    CC      qdev-monitor.o
>    CC      device-hotplug.o
> /tmp/qemu-test/src/block/fleecing-hook.c: In function 'fleecing_hook_co=
w':
> /tmp/qemu-test/src/block/fleecing-hook.c:61:12: error: implicit declara=
tion of function 'hbitmap_next_dirty_area'; did you mean 'hbitmap_next_ze=
ro'? [-Werror=3Dimplicit-function-declaration]
>       while (hbitmap_next_dirty_area(s->cow_bitmap, &off, end, &len)) {=

>              ^~~~~~~~~~~~~~~~~~~~~~~
>              hbitmap_next_zero
> /tmp/qemu-test/src/block/fleecing-hook.c:61:12: error: nested extern de=
claration of 'hbitmap_next_dirty_area' [-Werror=3Dnested-externs]
> cc1: all warnings being treated as errors
> make: *** [/tmp/qemu-test/src/rules.mak:69: block/fleecing-hook.o] Erro=
r 1
> make: *** Waiting for unfinished jobs....
> Traceback (most recent call last):
>    File "./tests/docker/docker.py", line 565, in <module>
>      sys.exit(main())
>    File "./tests/docker/docker.py", line 562, in main
>      return args.cmdobj.run(args, argv)
>    File "./tests/docker/docker.py", line 308, in run
>      return Docker().run(argv, args.keep, quiet=3Dargs.quiet)
>    File "./tests/docker/docker.py", line 276, in run
>      quiet=3Dquiet)
>    File "./tests/docker/docker.py", line 183, in _do_check
>      return subprocess.check_call(self._command + cmd, **kwargs)
>    File "/usr/lib64/python2.7/subprocess.py", line 186, in check_call
>      raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['sudo', '-n', 'docker', 'run',=
 '--label', 'com.qemu.instance.uuid=3Db3b1183ca16511e8a5bd52540069c830', =
'-u', '1000', '--security-opt', 'seccomp=3Dunconfined', '--rm', '--net=3D=
none', '-e', 'TARGET_LIST=3D', '-e', 'EXTRA_CONFIGURE_OPTS=3D', '-e', 'V=3D=
', '-e', 'J=3D8', '-e', 'DEBUG=3D', '-e', 'SHOW_ENV=3D1', '-e', 'CCACHE_D=
IR=3D/var/tmp/ccache', '-v', '/home/patchew/.cache/qemu-docker-ccache:/va=
r/tmp/ccache:z', '-v', '/var/tmp/patchew-tester-tmp-axs4wus0/src/docker-s=
rc.2018-08-16-11.04.31.27398:/var/tmp/qemu:z,ro', 'qemu:fedora', '/var/tm=
p/qemu/run', 'test-mingw']' returned non-zero exit status 2
> make[1]: *** [tests/docker/Makefile.include:213: docker-run] Error 1
> make[1]: Leaving directory '/var/tmp/patchew-tester-tmp-axs4wus0/src'
> make: *** [tests/docker/Makefile.include:247: docker-run-test-mingw@fed=
ora] Error 2
>
> real	1m13.823s
> user	0m4.993s
> sys	0m3.502s
> =3D=3D=3D OUTPUT END =3D=3D=3D
>
> Test command exited with code: 2
>
>
> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com


--=20
Best regards,
Vladimir
