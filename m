Received: from eggs.gnu.org ([2001:4830:134:3::10]:50416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lepton@google.com>) id 1eJjjX-0001Rl-DT
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 12:32:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lepton@google.com>) id 1eJjj0-0000UL-EC
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 12:31:47 -0500
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:44765)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lepton@google.com>) id 1eJjiz-0000S5-Ae
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 12:31:14 -0500
Received: by mail-wm0-x22d.google.com with SMTP id t8so1092366wmc.3
	for <qemu-devel@nongnu.org>; Tue, 28 Nov 2017 09:31:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAOvqHj4Ki9DKgnVUvaC_oOLhr4nqwLNsE-jwBT7r56RetW7ptQ@mail.gmail.com>
References: <20171121214350.55138-1-lepton@google.com>
	<151130271761.534.3068397592210082095@bafd83ae6430>
	<CAOvqHj4Ki9DKgnVUvaC_oOLhr4nqwLNsE-jwBT7r56RetW7ptQ@mail.gmail.com>
From: =?UTF-8?B?VGFvIFd1KOWQtOa2m0BFbmcp?= <lepton@google.com>
Date: Tue, 28 Nov 2017 09:31:07 -0800
Message-ID: <CAOvqHj4xmsV2o9mhkea6qo6+QyLDAcjBB5V8hn62P=G-U2=+Mg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/input/hid: Fix some wrong hid usage
 mappings.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU <qemu-devel@nongnu.org>
Cc: famz@redhat.com, kraxel@redhat.com

Ping.

On Tue, Nov 21, 2017 at 2:42 PM, Tao Wu(=E5=90=B4=E6=B6=9B@Eng) <lepton@goo=
gle.com> wrote:
> FYI, The failed test isn't related with this CL.
>
> See this thread:
> https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg04044.html
>
> On Tue, Nov 21, 2017 at 2:18 PM, <no-reply@patchew.org> wrote:
>>
>> Hi,
>>
>> This series failed automatic build test. Please find the testing command=
s
>> and
>> their output below. If you have docker installed, you can probably
>> reproduce it
>> locally.
>>
>> Subject: [Qemu-devel] [PATCH] hw/input/hid: Fix some wrong hid usage
>> mappings.
>> Type: series
>> Message-id: 20171121214350.55138-1-lepton@google.com
>>
>> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
>> #!/bin/bash
>> set -e
>> git submodule update --init dtc
>> # Let docker tests dump environment info
>> export SHOW_ENV=3D1
>> export J=3D8
>> time make docker-test-quick@centos6
>> time make docker-test-build@min-glib
>> time make docker-test-mingw@fedora
>> time make docker-test-block@fedora
>> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>>
>> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
>> Switched to a new branch 'test'
>> ceba89feb0 hw/input/hid: Fix some wrong hid usage mappings.
>>
>> =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
>> Submodule 'dtc' (git://git.qemu-project.org/dtc.git) registered for path
>> 'dtc'
>> Cloning into '/var/tmp/patchew-tester-tmp-gmdmoybf/src/dtc'...
>> Submodule path 'dtc': checked out
>> '558cd81bdd432769b59bff01240c44f82cfb1a9d'
>>   BUILD   centos6
>> make[1]: Entering directory '/var/tmp/patchew-tester-tmp-gmdmoybf/src'
>>   GEN
>> /var/tmp/patchew-tester-tmp-gmdmoybf/src/docker-src.2017-11-21-16.55.33.=
22004/qemu.tar
>> Cloning into
>> '/var/tmp/patchew-tester-tmp-gmdmoybf/src/docker-src.2017-11-21-16.55.33=
.22004/qemu.tar.vroot'...
>> done.
>> Checking out files:  46% (2624/5662)
>> Checking out files:  47% (2662/5662)
>> Checking out files:  48% (2718/5662)
>> Checking out files:  49% (2775/5662)
>> Checking out files:  50% (2831/5662)
>> Checking out files:  51% (2888/5662)
>> Checking out files:  52% (2945/5662)
>> Checking out files:  53% (3001/5662)
>> Checking out files:  54% (3058/5662)
>> Checking out files:  55% (3115/5662)
>> Checking out files:  56% (3171/5662)
>> Checking out files:  57% (3228/5662)
>> Checking out files:  58% (3284/5662)
>> Checking out files:  59% (3341/5662)
>> Checking out files:  60% (3398/5662)
>> Checking out files:  61% (3454/5662)
>> Checking out files:  62% (3511/5662)
>> Checking out files:  63% (3568/5662)
>> Checking out files:  64% (3624/5662)
>> Checking out files:  65% (3681/5662)
>> Checking out files:  66% (3737/5662)
>> Checking out files:  67% (3794/5662)
>> Checking out files:  68% (3851/5662)
>> Checking out files:  69% (3907/5662)
>> Checking out files:  70% (3964/5662)
>> Checking out files:  71% (4021/5662)
>> Checking out files:  72% (4077/5662)
>> Checking out files:  73% (4134/5662)
>> Checking out files:  74% (4190/5662)
>> Checking out files:  75% (4247/5662)
>> Checking out files:  76% (4304/5662)
>> Checking out files:  77% (4360/5662)
>> Checking out files:  78% (4417/5662)
>> Checking out files:  79% (4473/5662)
>> Checking out files:  80% (4530/5662)
>> Checking out files:  81% (4587/5662)
>> Checking out files:  82% (4643/5662)
>> Checking out files:  83% (4700/5662)
>> Checking out files:  84% (4757/5662)
>> Checking out files:  85% (4813/5662)
>> Checking out files:  86% (4870/5662)
>> Checking out files:  87% (4926/5662)
>> Checking out files:  88% (4983/5662)
>> Checking out files:  89% (5040/5662)
>> Checking out files:  90% (5096/5662)
>> Checking out files:  91% (5153/5662)
>> Checking out files:  92% (5210/5662)
>> Checking out files:  93% (5266/5662)
>> Checking out files:  94% (5323/5662)
>> Checking out files:  95% (5379/5662)
>> Checking out files:  96% (5436/5662)
>> Checking out files:  97% (5493/5662)
>> Checking out files:  98% (5549/5662)
>> Checking out files:  99% (5606/5662)
>> Checking out files: 100% (5662/5662)
>> Checking out files: 100% (5662/5662), done.
>> Your branch is up-to-date with 'origin/test'.
>> Submodule 'dtc' (git://git.qemu-project.org/dtc.git) registered for path
>> 'dtc'
>> Cloning into
>> '/var/tmp/patchew-tester-tmp-gmdmoybf/src/docker-src.2017-11-21-16.55.33=
.22004/qemu.tar.vroot/dtc'...
>> Submodule path 'dtc': checked out
>> '558cd81bdd432769b59bff01240c44f82cfb1a9d'
>> Submodule 'ui/keycodemapdb' (git://git.qemu.org/keycodemapdb.git)
>> registered for path 'ui/keycodemapdb'
>> Cloning into
>> '/var/tmp/patchew-tester-tmp-gmdmoybf/src/docker-src.2017-11-21-16.55.33=
.22004/qemu.tar.vroot/ui/keycodemapdb'...
>> Submodule path 'ui/keycodemapdb': checked out
>> '10739aa26051a5d49d88132604539d3ed085e72e'
>>   COPY    RUNNER
>>     RUN test-quick in qemu:centos6
>> Packages installed:
>> SDL-devel-1.2.14-7.el6_7.1.x86_64
>> bison-2.4.1-5.el6.x86_64
>> bzip2-devel-1.0.5-7.el6_0.x86_64
>> ccache-3.1.6-2.el6.x86_64
>> csnappy-devel-0-6.20150729gitd7bc683.el6.x86_64
>> flex-2.5.35-9.el6.x86_64
>> gcc-4.4.7-18.el6.x86_64
>> gettext-0.17-18.el6.x86_64
>> git-1.7.1-9.el6_9.x86_64
>> glib2-devel-2.28.8-9.el6.x86_64
>> libepoxy-devel-1.2-3.el6.x86_64
>> libfdt-devel-1.4.0-1.el6.x86_64
>> librdmacm-devel-1.0.21-0.el6.x86_64
>> lzo-devel-2.03-3.1.el6_5.1.x86_64
>> make-3.81-23.el6.x86_64
>> mesa-libEGL-devel-11.0.7-4.el6.x86_64
>> mesa-libgbm-devel-11.0.7-4.el6.x86_64
>> package g++ is not installed
>> pixman-devel-0.32.8-1.el6.x86_64
>> spice-glib-devel-0.26-8.el6.x86_64
>> spice-server-devel-0.12.4-16.el6.x86_64
>> tar-1.23-15.el6_8.x86_64
>> vte-devel-0.25.1-9.el6.x86_64
>> xen-devel-4.6.6-2.el6.x86_64
>> zlib-devel-1.2.3-29.el6.x86_64
>>
>> Environment variables:
>> PACKAGES=3Dbison     bzip2-devel     ccache     csnappy-devel     flex
>> g++     gcc     gettext     git     glib2-devel     libepoxy-devel
>> libfdt-devel     librdmacm-devel     lzo-devel     make
>> mesa-libEGL-devel     mesa-libgbm-devel     pixman-devel     SDL-devel
>> spice-glib-devel     spice-server-devel     tar     vte-devel     xen-de=
vel
>> zlib-devel
>> HOSTNAME=3D0382bb14d37d
>> MAKEFLAGS=3D -j8
>> J=3D8
>> CCACHE_DIR=3D/var/tmp/ccache
>> EXTRA_CONFIGURE_OPTS=3D
>> V=3D
>> SHOW_ENV=3D1
>>
>> PATH=3D/usr/lib/ccache:/usr/lib64/ccache:/usr/local/sbin:/usr/local/bin:=
/usr/sbin:/usr/bin:/sbin:/bin
>> PWD=3D/
>> TARGET_LIST=3D
>> SHLVL=3D1
>> HOME=3D/root
>> TEST_DIR=3D/tmp/qemu-test
>> FEATURES=3D dtc
>> DEBUG=3D
>> _=3D/usr/bin/env
>>
>> Configure options:
>> --enable-werror --target-list=3Dx86_64-softmmu,aarch64-softmmu
>> --prefix=3D/tmp/qemu-test/install
>> No C++ compiler available; disabling C++ specific optional code
>> Install prefix    /tmp/qemu-test/install
>> BIOS directory    /tmp/qemu-test/install/share/qemu
>> firmware path     /tmp/qemu-test/install/share/qemu-firmware
>> binary directory  /tmp/qemu-test/install/bin
>> library directory /tmp/qemu-test/install/lib
>> module directory  /tmp/qemu-test/install/lib/qemu
>> libexec directory /tmp/qemu-test/install/libexec
>> include directory /tmp/qemu-test/install/include
>> config directory  /tmp/qemu-test/install/etc
>> local state directory   /tmp/qemu-test/install/var
>> Manual directory  /tmp/qemu-test/install/share/man
>> ELF interp prefix /usr/gnemul/qemu-%M
>> Source path       /tmp/qemu-test/src
>> GIT binary        git
>> GIT submodules
>> C compiler        cc
>> Host C compiler   cc
>> C++ compiler
>> Objective-C compiler cc
>> ARFLAGS           rv
>> CFLAGS            -O2 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=3D2 -g
>> QEMU_CFLAGS       -I/usr/include/pixman-1   -I$(SRC_PATH)/dtc/libfdt
>> -pthread -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include
>> -DNCURSES_WIDECHAR   -fPIE -DPIE -m64 -mcx16 -D_GNU_SOURCE
>> -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -Wstrict-prototypes
>> -Wredundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-prototypes
>> -fno-strict-aliasing -fno-common -fwrapv  -Wendif-labels
>> -Wno-missing-include-dirs -Wempty-body -Wnested-externs -Wformat-securit=
y
>> -Wformat-y2k -Winit-self -Wignored-qualifiers -Wold-style-declaration
>> -Wold-style-definition -Wtype-limits -fstack-protector-all
>> -Wno-missing-braces  -I/usr/include/libpng12   -I/usr/include/libdrm
>> -I/usr/include/spice-server -I/usr/include/cacard -I/usr/include/glib-2.=
0
>> -I/usr/lib64/glib-2.0/include -I/usr/include/pixman-1 -I/usr/include/nss=
3
>> -I/usr/include/nspr4 -I/usr/include/spice-1
>> LDFLAGS           -Wl,--warn-common -Wl,-z,relro -Wl,-z,now -pie -m64 -g
>> make              make
>> install           install
>> python            python -B
>> smbd              /usr/sbin/smbd
>> module support    no
>> host CPU          x86_64
>> host big endian   no
>> target list       x86_64-softmmu aarch64-softmmu
>> gprof enabled     no
>> sparse enabled    no
>> strip binaries    yes
>> profiler          no
>> static build      no
>> SDL support       yes (1.2.14)
>> GTK support       yes (2.24.23)
>> GTK GL support    no
>> VTE support       yes (0.25.1)
>> TLS priority      NORMAL
>> GNUTLS support    no
>> GNUTLS rnd        no
>> libgcrypt         no
>> libgcrypt kdf     no
>> nettle            no
>> nettle kdf        no
>> libtasn1          no
>> curses support    yes
>> virgl support     no
>> curl support      no
>> mingw32 support   no
>> Audio drivers     oss
>> Block whitelist (rw)
>> Block whitelist (ro)
>> VirtFS support    no
>> Multipath support no
>> VNC support       yes
>> VNC SASL support  no
>> VNC JPEG support  yes
>> VNC PNG support   yes
>> xen support       yes
>> xen ctrl version  40600
>> pv dom build      no
>> brlapi support    no
>> bluez  support    no
>> Documentation     no
>> PIE               yes
>> vde support       no
>> netmap support    no
>> Linux AIO support no
>> ATTR/XATTR support yes
>> Install blobs     yes
>> KVM support       yes
>> HAX support       no
>> TCG support       yes
>> TCG debug enabled no
>> TCG interpreter   no
>> RDMA support      yes
>> fdt support       yes
>> preadv support    yes
>> fdatasync         yes
>> madvise           yes
>> posix_madvise     yes
>> libcap-ng support no
>> vhost-net support yes
>> vhost-scsi support yes
>> vhost-vsock support yes
>> vhost-user support yes
>> Trace backends    log
>> spice support     yes (0.12.6/0.12.4)
>> rbd support       no
>> xfsctl support    no
>> smartcard support yes
>> libusb            no
>> usb net redir     no
>> OpenGL support    yes
>> OpenGL dmabufs    no
>> libiscsi support  no
>> libnfs support    no
>> build guest agent yes
>> QGA VSS support   no
>> QGA w32 disk info no
>> QGA MSI support   no
>> seccomp support   no
>> coroutine backend ucontext
>> coroutine pool    yes
>> debug stack usage no
>> crypto afalg      no
>> GlusterFS support no
>> gcov              gcov
>> gcov enabled      no
>> TPM support       yes
>> libssh2 support   no
>> TPM passthrough   yes
>> TPM emulator      yes
>> QOM debugging     yes
>> Live block migration yes
>> lzo support       yes
>> snappy support    no
>> bzip2 support     yes
>> NUMA host support no
>> tcmalloc support  no
>> jemalloc support  no
>> avx2 optimization no
>> replication support yes
>> VxHS block device no
>> capstone          no
>>   GEN     x86_64-softmmu/config-devices.mak.tmp
>>   GEN     aarch64-softmmu/config-devices.mak.tmp
>> mkdir -p dtc/libfdt
>> mkdir -p dtc/tests
>>   GEN     config-host.h
>>   GEN     qemu-options.def
>>   GEN     qapi-types.h
>>   GEN     qmp-commands.h
>>   GEN     qapi-visit.h
>>   GEN     qapi-event.h
>>   GEN     x86_64-softmmu/config-devices.mak
>>   GEN     qmp-marshal.c
>>   GEN     aarch64-softmmu/config-devices.mak
>>   GEN     qapi-types.c
>>   GEN     qapi-visit.c
>>   GEN     qapi-event.c
>>   GEN     qmp-introspect.h
>>   GEN     qmp-introspect.c
>>   GEN     trace/generated-tcg-tracers.h
>>   GEN     trace/generated-helpers-wrappers.h
>>   GEN     trace/generated-helpers.h
>>   GEN     trace/generated-helpers.c
>>   GEN     module_block.h
>>   GEN     ui/input-keymap-linux-to-qcode.c
>>   GEN     ui/input-keymap-qcode-to-qnum.c
>>   GEN     ui/input-keymap-qnum-to-qcode.c
>>   GEN     tests/test-qapi-types.h
>>   GEN     tests/test-qapi-visit.h
>>   GEN     tests/test-qmp-commands.h
>>   GEN     tests/test-qapi-event.h
>>   GEN     tests/test-qmp-introspect.h
>>   GEN     trace-root.h
>>   GEN     crypto/trace.h
>>   GEN     util/trace.h
>>   GEN     io/trace.h
>>   GEN     migration/trace.h
>>   GEN     block/trace.h
>>   GEN     chardev/trace.h
>>   GEN     hw/block/trace.h
>>   GEN     hw/block/dataplane/trace.h
>>   GEN     hw/char/trace.h
>>   GEN     hw/intc/trace.h
>>   GEN     hw/net/trace.h
>>   GEN     hw/virtio/trace.h
>>   GEN     hw/audio/trace.h
>>   GEN     hw/misc/trace.h
>>   GEN     hw/usb/trace.h
>>   GEN     hw/scsi/trace.h
>>   GEN     hw/nvram/trace.h
>>   GEN     hw/display/trace.h
>>   GEN     hw/input/trace.h
>>   GEN     hw/timer/trace.h
>>   GEN     hw/dma/trace.h
>>   GEN     hw/sparc/trace.h
>>   GEN     hw/sd/trace.h
>>   GEN     hw/isa/trace.h
>>   GEN     hw/mem/trace.h
>>   GEN     hw/i386/trace.h
>>   GEN     hw/i386/xen/trace.h
>>   GEN     hw/9pfs/trace.h
>>   GEN     hw/ppc/trace.h
>>   GEN     hw/pci/trace.h
>>   GEN     hw/s390x/trace.h
>>   GEN     hw/vfio/trace.h
>>   GEN     hw/acpi/trace.h
>>   GEN     hw/arm/trace.h
>>   GEN     hw/alpha/trace.h
>>   GEN     hw/xen/trace.h
>>   GEN     hw/ide/trace.h
>>   GEN     ui/trace.h
>>   GEN     audio/trace.h
>>   GEN     net/trace.h
>>   GEN     target/arm/trace.h
>>   GEN     target/i386/trace.h
>>   GEN     target/mips/trace.h
>>   GEN     target/sparc/trace.h
>>   GEN     target/s390x/trace.h
>>   GEN     target/ppc/trace.h
>>   GEN     qom/trace.h
>>   GEN     linux-user/trace.h
>>   GEN     qapi/trace.h
>>   GEN     accel/tcg/trace.h
>>   GEN     accel/kvm/trace.h
>>   GEN     nbd/trace.h
>>   GEN     scsi/trace.h
>>   GEN     trace-root.c
>>   GEN     util/trace.c
>>   GEN     crypto/trace.c
>>   GEN     io/trace.c
>>   GEN     migration/trace.c
>>   GEN     block/trace.c
>>   GEN     chardev/trace.c
>>   GEN     hw/block/trace.c
>>   GEN     hw/block/dataplane/trace.c
>>   GEN     hw/char/trace.c
>>   GEN     hw/intc/trace.c
>>   GEN     hw/net/trace.c
>>   GEN     hw/virtio/trace.c
>>   GEN     hw/audio/trace.c
>>   GEN     hw/misc/trace.c
>>   GEN     hw/usb/trace.c
>>   GEN     hw/scsi/trace.c
>>   GEN     hw/nvram/trace.c
>>   GEN     hw/display/trace.c
>>   GEN     hw/input/trace.c
>>   GEN     hw/timer/trace.c
>>   GEN     hw/dma/trace.c
>>   GEN     hw/sparc/trace.c
>>   GEN     hw/sd/trace.c
>>   GEN     hw/isa/trace.c
>>   GEN     hw/mem/trace.c
>>   GEN     hw/i386/trace.c
>>   GEN     hw/i386/xen/trace.c
>>   GEN     hw/9pfs/trace.c
>>   GEN     hw/ppc/trace.c
>>   GEN     hw/pci/trace.c
>>   GEN     hw/s390x/trace.c
>>   GEN     hw/vfio/trace.c
>>   GEN     hw/acpi/trace.c
>>   GEN     hw/arm/trace.c
>>   GEN     hw/alpha/trace.c
>>   GEN     hw/xen/trace.c
>>   GEN     hw/ide/trace.c
>>   GEN     ui/trace.c
>>   GEN     audio/trace.c
>>   GEN     net/trace.c
>>   GEN     target/arm/trace.c
>>   GEN     target/i386/trace.c
>>   GEN     target/mips/trace.c
>>   GEN     target/sparc/trace.c
>>   GEN     target/s390x/trace.c
>>   GEN     target/ppc/trace.c
>>   GEN     qom/trace.c
>>   GEN     linux-user/trace.c
>>   GEN     qapi/trace.c
>>   GEN     accel/tcg/trace.c
>>   GEN     accel/kvm/trace.c
>>   GEN     nbd/trace.c
>>   GEN     scsi/trace.c
>>   GEN     config-all-devices.mak
>>          DEP /tmp/qemu-test/src/dtc/tests/dumptrees.c
>>          DEP /tmp/qemu-test/src/dtc/tests/trees.S
>>          DEP /tmp/qemu-test/src/dtc/tests/testutils.c
>>          DEP /tmp/qemu-test/src/dtc/tests/value-labels.c
>>          DEP /tmp/qemu-test/src/dtc/tests/asm_tree_dump.c
>>          DEP /tmp/qemu-test/src/dtc/tests/truncated_property.c
>>          DEP /tmp/qemu-test/src/dtc/tests/check_path.c
>>          DEP /tmp/qemu-test/src/dtc/tests/overlay_bad_fixup.c
>>          DEP /tmp/qemu-test/src/dtc/tests/overlay.c
>>          DEP /tmp/qemu-test/src/dtc/tests/subnode_iterate.c
>>          DEP /tmp/qemu-test/src/dtc/tests/property_iterate.c
>>          DEP /tmp/qemu-test/src/dtc/tests/integer-expressions.c
>>          DEP /tmp/qemu-test/src/dtc/tests/utilfdt_test.c
>>          DEP /tmp/qemu-test/src/dtc/tests/add_subnode_with_nops.c
>>          DEP /tmp/qemu-test/src/dtc/tests/path_offset_aliases.c
>>          DEP /tmp/qemu-test/src/dtc/tests/dtbs_equal_unordered.c
>>          DEP /tmp/qemu-test/src/dtc/tests/dtb_reverse.c
>>          DEP /tmp/qemu-test/src/dtc/tests/dtbs_equal_ordered.c
>>          DEP /tmp/qemu-test/src/dtc/tests/extra-terminating-null.c
>>          DEP /tmp/qemu-test/src/dtc/tests/incbin.c
>>          DEP /tmp/qemu-test/src/dtc/tests/phandle_format.c
>>          DEP /tmp/qemu-test/src/dtc/tests/boot-cpuid.c
>>          DEP /tmp/qemu-test/src/dtc/tests/path-references.c
>>          DEP /tmp/qemu-test/src/dtc/tests/references.c
>>          DEP /tmp/qemu-test/src/dtc/tests/string_escapes.c
>>          DEP /tmp/qemu-test/src/dtc/tests/propname_escapes.c
>>          DEP /tmp/qemu-test/src/dtc/tests/appendprop2.c
>>          DEP /tmp/qemu-test/src/dtc/tests/appendprop1.c
>>          DEP /tmp/qemu-test/src/dtc/tests/del_node.c
>>          DEP /tmp/qemu-test/src/dtc/tests/del_property.c
>>          DEP /tmp/qemu-test/src/dtc/tests/set_name.c
>>          DEP /tmp/qemu-test/src/dtc/tests/setprop.c
>>          DEP /tmp/qemu-test/src/dtc/tests/rw_tree1.c
>>          DEP /tmp/qemu-test/src/dtc/tests/open_pack.c
>>          DEP /tmp/qemu-test/src/dtc/tests/nopulate.c
>>          DEP /tmp/qemu-test/src/dtc/tests/mangle-layout.c
>>          DEP /tmp/qemu-test/src/dtc/tests/move_and_save.c
>>          DEP /tmp/qemu-test/src/dtc/tests/sw_tree1.c
>>          DEP /tmp/qemu-test/src/dtc/tests/nop_node.c
>>          DEP /tmp/qemu-test/src/dtc/tests/nop_property.c
>>          DEP /tmp/qemu-test/src/dtc/tests/setprop_inplace.c
>>          DEP /tmp/qemu-test/src/dtc/tests/stringlist.c
>>          DEP /tmp/qemu-test/src/dtc/tests/notfound.c
>>          DEP /tmp/qemu-test/src/dtc/tests/addr_size_cells.c
>>          DEP /tmp/qemu-test/src/dtc/tests/sized_cells.c
>>          DEP /tmp/qemu-test/src/dtc/tests/char_literal.c
>>          DEP /tmp/qemu-test/src/dtc/tests/get_alias.c
>>          DEP /tmp/qemu-test/src/dtc/tests/node_offset_by_compatible.c
>>          DEP /tmp/qemu-test/src/dtc/tests/node_check_compatible.c
>>          DEP /tmp/qemu-test/src/dtc/tests/node_offset_by_phandle.c
>>          DEP /tmp/qemu-test/src/dtc/tests/node_offset_by_prop_value.c
>>          DEP /tmp/qemu-test/src/dtc/tests/parent_offset.c
>>          DEP /tmp/qemu-test/src/dtc/tests/supernode_atdepth_offset.c
>>          DEP /tmp/qemu-test/src/dtc/tests/get_path.c
>>          DEP /tmp/qemu-test/src/dtc/tests/get_phandle.c
>>          DEP /tmp/qemu-test/src/dtc/tests/getprop.c
>>          DEP /tmp/qemu-test/src/dtc/tests/path_offset.c
>>          DEP /tmp/qemu-test/src/dtc/tests/get_name.c
>>          DEP /tmp/qemu-test/src/dtc/tests/find_property.c
>>          DEP /tmp/qemu-test/src/dtc/tests/subnode_offset.c
>>          DEP /tmp/qemu-test/src/dtc/tests/root_node.c
>>          DEP /tmp/qemu-test/src/dtc/tests/get_mem_rsv.c
>>          DEP /tmp/qemu-test/src/dtc/libfdt/fdt_addresses.c
>>          DEP /tmp/qemu-test/src/dtc/libfdt/fdt_overlay.c
>>          DEP /tmp/qemu-test/src/dtc/libfdt/fdt_empty_tree.c
>>          DEP /tmp/qemu-test/src/dtc/libfdt/fdt_strerror.c
>>          DEP /tmp/qemu-test/src/dtc/libfdt/fdt_rw.c
>>          DEP /tmp/qemu-test/src/dtc/libfdt/fdt_sw.c
>>          DEP /tmp/qemu-test/src/dtc/libfdt/fdt_wip.c
>>          DEP /tmp/qemu-test/src/dtc/libfdt/fdt_ro.c
>>          DEP /tmp/qemu-test/src/dtc/libfdt/fdt.c
>>          DEP /tmp/qemu-test/src/dtc/fdtput.c
>>          DEP /tmp/qemu-test/src/dtc/util.c
>>          DEP /tmp/qemu-test/src/dtc/fdtget.c
>>          DEP /tmp/qemu-test/src/dtc/fdtdump.c
>>          LEX convert-dtsv0-lexer.lex.c
>>          DEP /tmp/qemu-test/src/dtc/srcpos.c
>>          BISON dtc-parser.tab.c
>>          LEX dtc-lexer.lex.c
>>          DEP /tmp/qemu-test/src/dtc/treesource.c
>>          DEP /tmp/qemu-test/src/dtc/livetree.c
>>          DEP /tmp/qemu-test/src/dtc/fstree.c
>>          DEP /tmp/qemu-test/src/dtc/flattree.c
>>          DEP /tmp/qemu-test/src/dtc/dtc.c
>>          DEP /tmp/qemu-test/src/dtc/data.c
>>          DEP /tmp/qemu-test/src/dtc/checks.c
>>          DEP convert-dtsv0-lexer.lex.c
>>          DEP dtc-lexer.lex.c
>>          DEP dtc-parser.tab.c
>>         CHK version_gen.h
>>         UPD version_gen.h
>>          DEP /tmp/qemu-test/src/dtc/util.c
>>          CC libfdt/fdt.o
>>          CC libfdt/fdt_ro.o
>>          CC libfdt/fdt_sw.o
>>          CC libfdt/fdt_wip.o
>>          CC libfdt/fdt_rw.o
>>          CC libfdt/fdt_strerror.o
>>          CC libfdt/fdt_empty_tree.o
>>          CC libfdt/fdt_addresses.o
>>          CC libfdt/fdt_overlay.o
>>          AR libfdt/libfdt.a
>> ar: creating libfdt/libfdt.a
>> a - libfdt/fdt.o
>> a - libfdt/fdt_ro.o
>> a - libfdt/fdt_wip.o
>> a - libfdt/fdt_sw.o
>> a - libfdt/fdt_rw.o
>> a - libfdt/fdt_strerror.o
>> a - libfdt/fdt_empty_tree.o
>> a - libfdt/fdt_addresses.o
>> a - libfdt/fdt_overlay.o
>> mkdir -p dtc/libfdt
>> mkdir -p dtc/tests
>>   CC      tests/qemu-iotests/socket_scm_helper.o
>>   GEN     qga/qapi-generated/qga-qapi-types.h
>>   GEN     qga/qapi-generated/qga-qapi-visit.h
>>   GEN     qga/qapi-generated/qga-qmp-commands.h
>>   GEN     qga/qapi-generated/qga-qapi-types.c
>>   GEN     qga/qapi-generated/qga-qmp-marshal.c
>>   CC      qmp-introspect.o
>>   GEN     qga/qapi-generated/qga-qapi-visit.c
>>   CC      qapi-types.o
>>   CC      qapi-visit.o
>>   CC      qapi-event.o
>>   CC      qapi/qapi-visit-core.o
>>   CC      qapi/qapi-dealloc-visitor.o
>>   CC      qapi/qobject-input-visitor.o
>>   CC      qapi/qobject-output-visitor.o
>>   CC      qapi/qmp-registry.o
>>   CC      qapi/qmp-dispatch.o
>>   CC      qapi/string-input-visitor.o
>>   CC      qapi/qapi-clone-visitor.o
>>   CC      qapi/string-output-visitor.o
>>   CC      qapi/opts-visitor.o
>>   CC      qapi/qmp-event.o
>>   CC      qapi/qapi-util.o
>>   CC      qobject/qnull.o
>>   CC      qobject/qnum.o
>>   CC      qobject/qstring.o
>>   CC      qobject/qdict.o
>>   CC      qobject/qlist.o
>>   CC      qobject/qbool.o
>>   CC      qobject/qlit.o
>>   CC      qobject/qjson.o
>>   CC      qobject/qobject.o
>>   CC      qobject/json-lexer.o
>>   CC      qobject/json-streamer.o
>>   CC      qobject/json-parser.o
>>   CC      trace/control.o
>>   CC      trace/qmp.o
>>   CC      util/osdep.o
>>   CC      util/cutils.o
>>   CC      util/unicode.o
>>   CC      util/qemu-timer-common.o
>>   CC      util/lockcnt.o
>>   CC      util/bufferiszero.o
>>   CC      util/aiocb.o
>>   CC      util/async.o
>>   CC      util/qemu-timer.o
>>   CC      util/main-loop.o
>>   CC      util/thread-pool.o
>>   CC      util/iohandler.o
>>   CC      util/aio-posix.o
>>   CC      util/compatfd.o
>>   CC      util/event_notifier-posix.o
>>   CC      util/mmap-alloc.o
>>   CC      util/oslib-posix.o
>>   CC      util/qemu-openpty.o
>>   CC      util/qemu-thread-posix.o
>>   CC      util/memfd.o
>>   CC      util/envlist.o
>>   CC      util/path.o
>>   CC      util/module.o
>>   CC      util/host-utils.o
>>   CC      util/bitmap.o
>>   CC      util/bitops.o
>>   CC      util/hbitmap.o
>>   CC      util/fifo8.o
>>   CC      util/acl.o
>>   CC      util/cacheinfo.o
>>   CC      util/error.o
>>   CC      util/qemu-error.o
>>   CC      util/id.o
>>   CC      util/iov.o
>>   CC      util/qemu-config.o
>>   CC      util/qemu-sockets.o
>>   CC      util/uri.o
>>   CC      util/notify.o
>>   CC      util/qemu-progress.o
>>   CC      util/qemu-option.o
>>   CC      util/keyval.o
>>   CC      util/hexdump.o
>>   CC      util/crc32c.o
>>   CC      util/uuid.o
>>   CC      util/throttle.o
>>   CC      util/getauxval.o
>>   CC      util/readline.o
>>   CC      util/rcu.o
>>   CC      util/qemu-coroutine.o
>>   CC      util/qemu-coroutine-lock.o
>>   CC      util/qemu-coroutine-io.o
>>   CC      util/qemu-coroutine-sleep.o
>>   CC      util/coroutine-ucontext.o
>>   CC      util/buffer.o
>>   CC      util/timed-average.o
>>   CC      util/base64.o
>>   CC      util/log.o
>>   CC      util/pagesize.o
>>   CC      util/qdist.o
>>   CC      util/range.o
>>   CC      util/qht.o
>>   CC      util/stats64.o
>>   CC      util/systemd.o
>>   CC      trace-root.o
>>   CC      util/trace.o
>>   CC      crypto/trace.o
>>   CC      io/trace.o
>>   CC      migration/trace.o
>>   CC      block/trace.o
>>   CC      chardev/trace.o
>>   CC      hw/block/trace.o
>>   CC      hw/block/dataplane/trace.o
>>   CC      hw/char/trace.o
>>   CC      hw/intc/trace.o
>>   CC      hw/net/trace.o
>>   CC      hw/virtio/trace.o
>>   CC      hw/audio/trace.o
>>   CC      hw/misc/trace.o
>>   CC      hw/usb/trace.o
>>   CC      hw/scsi/trace.o
>>   CC      hw/nvram/trace.o
>>   CC      hw/display/trace.o
>>   CC      hw/input/trace.o
>>   CC      hw/timer/trace.o
>>   CC      hw/dma/trace.o
>>   CC      hw/sparc/trace.o
>>   CC      hw/sd/trace.o
>>   CC      hw/isa/trace.o
>>   CC      hw/i386/trace.o
>>   CC      hw/mem/trace.o
>>   CC      hw/i386/xen/trace.o
>>   CC      hw/9pfs/trace.o
>>   CC      hw/ppc/trace.o
>>   CC      hw/pci/trace.o
>>   CC      hw/s390x/trace.o
>>   CC      hw/acpi/trace.o
>>   CC      hw/vfio/trace.o
>>   CC      hw/arm/trace.o
>>   CC      hw/alpha/trace.o
>>   CC      hw/xen/trace.o
>>   CC      hw/ide/trace.o
>>   CC      ui/trace.o
>>   CC      audio/trace.o
>>   CC      net/trace.o
>>   CC      target/arm/trace.o
>>   CC      target/i386/trace.o
>>   CC      target/mips/trace.o
>>   CC      target/sparc/trace.o
>>   CC      target/s390x/trace.o
>>   CC      target/ppc/trace.o
>>   CC      qom/trace.o
>>   CC      linux-user/trace.o
>>   CC      qapi/trace.o
>>   CC      accel/tcg/trace.o
>>   CC      accel/kvm/trace.o
>>   CC      nbd/trace.o
>>   CC      scsi/trace.o
>>   CC      crypto/pbkdf-stub.o
>>   CC      stubs/arch-query-cpu-def.o
>>   CC      stubs/arch-query-cpu-model-expansion.o
>>   CC      stubs/arch-query-cpu-model-comparison.o
>>   CC      stubs/arch-query-cpu-model-baseline.o
>>   CC      stubs/bdrv-next-monitor-owned.o
>>   CC      stubs/blk-commit-all.o
>>   CC      stubs/blockdev-close-all-bdrv-states.o
>>   CC      stubs/clock-warp.o
>>   CC      stubs/cpu-get-clock.o
>>   CC      stubs/cpu-get-icount.o
>>   CC      stubs/dump.o
>>   CC      stubs/error-printf.o
>>   CC      stubs/fdset.o
>>   CC      stubs/get-vm-name.o
>>   CC      stubs/gdbstub.o
>>   CC      stubs/iothread.o
>>   CC      stubs/iothread-lock.o
>>   CC      stubs/machine-init-done.o
>>   CC      stubs/is-daemonized.o
>>   CC      stubs/migr-blocker.o
>>   CC      stubs/change-state-handler.o
>>   CC      stubs/monitor.o
>>   CC      stubs/notify-event.o
>>   CC      stubs/qtest.o
>>   CC      stubs/replay.o
>>   CC      stubs/set-fd-handler.o
>>   CC      stubs/runstate-check.o
>>   CC      stubs/sysbus.o
>>   CC      stubs/slirp.o
>>   CC      stubs/tpm.o
>>   CC      stubs/trace-control.o
>>   CC      stubs/uuid.o
>>   CC      stubs/vm-stop.o
>>   CC      stubs/vmstate.o
>>   CC      stubs/qmp_pc_dimm.o
>>   CC      stubs/target-monitor-defs.o
>>   CC      stubs/target-get-monitor-def.o
>>   CC      stubs/pc_madt_cpu_entry.o
>>   CC      stubs/vmgenid.o
>>   CC      stubs/xen-common.o
>>   CC      stubs/xen-hvm.o
>>   CC      stubs/pci-host-piix.o
>>   CC      contrib/ivshmem-client/ivshmem-client.o
>>   CC      contrib/ivshmem-client/main.o
>>   CC      contrib/ivshmem-server/ivshmem-server.o
>>   CC      contrib/ivshmem-server/main.o
>>   CC      block.o
>>   CC      qemu-nbd.o
>>   CC      blockjob.o
>>   CC      qemu-io-cmds.o
>>   CC      replication.o
>>   CC      block/raw-format.o
>>   CC      block/vdi.o
>>   CC      block/qcow.o
>>   CC      block/vmdk.o
>>   CC      block/cloop.o
>>   CC      block/bochs.o
>>   CC      block/vpc.o
>>   CC      block/vvfat.o
>>   CC      block/dmg.o
>>   CC      block/qcow2.o
>>   CC      block/qcow2-refcount.o
>>   CC      block/qcow2-cluster.o
>>   CC      block/qcow2-cache.o
>>   CC      block/qcow2-snapshot.o
>>   CC      block/qcow2-bitmap.o
>>   CC      block/qed-l2-cache.o
>>   CC      block/qed.o
>>   CC      block/qed-table.o
>>   CC      block/qed-cluster.o
>>   CC      block/qed-check.o
>>   CC      block/vhdx.o
>>   CC      block/vhdx-endian.o
>>   CC      block/vhdx-log.o
>>   CC      block/quorum.o
>>   CC      block/parallels.o
>>   CC      block/blkdebug.o
>>   CC      block/blkreplay.o
>>   CC      block/blkverify.o
>>   CC      block/block-backend.o
>>   CC      block/snapshot.o
>>   CC      block/qapi.o
>>   CC      block/file-posix.o
>>   CC      block/null.o
>>   CC      block/mirror.o
>>   CC      block/commit.o
>>   CC      block/io.o
>>   CC      block/throttle-groups.o
>>   CC      block/nbd.o
>>   CC      block/nbd-client.o
>>   CC      block/sheepdog.o
>>   CC      block/accounting.o
>>   CC      block/write-threshold.o
>>   CC      block/dirty-bitmap.o
>>   CC      block/backup.o
>>   CC      block/replication.o
>>   CC      block/throttle.o
>>   CC      block/crypto.o
>>   CC      nbd/server.o
>>   CC      nbd/client.o
>>   CC      nbd/common.o
>>   CC      scsi/utils.o
>>   CC      scsi/pr-manager.o
>>   CC      scsi/pr-manager-helper.o
>>   CC      block/dmg-bz2.o
>>   CC      crypto/init.o
>>   CC      crypto/hash.o
>>   CC      crypto/hash-glib.o
>>   CC      crypto/hmac.o
>>   CC      crypto/hmac-glib.o
>>   CC      crypto/aes.o
>>   CC      crypto/desrfb.o
>>   CC      crypto/cipher.o
>>   CC      crypto/tlscreds.o
>>   CC      crypto/tlscredsanon.o
>>   CC      crypto/tlscredsx509.o
>>   CC      crypto/tlssession.o
>>   CC      crypto/random-platform.o
>>   CC      crypto/secret.o
>>   CC      crypto/pbkdf.o
>>   CC      crypto/ivgen-essiv.o
>>   CC      crypto/ivgen.o
>>   CC      crypto/ivgen-plain.o
>>   CC      crypto/ivgen-plain64.o
>>   CC      crypto/afsplit.o
>>   CC      crypto/xts.o
>>   CC      crypto/block.o
>>   CC      crypto/block-qcow.o
>>   CC      crypto/block-luks.o
>>   CC      io/channel.o
>>   CC      io/channel-buffer.o
>>   CC      io/channel-command.o
>>   CC      io/channel-file.o
>>   CC      io/channel-socket.o
>>   CC      io/channel-tls.o
>>   CC      io/channel-watch.o
>>   CC      io/channel-websock.o
>>   CC      io/channel-util.o
>>   CC      io/dns-resolver.o
>>   CC      io/task.o
>>   CC      qom/object.o
>>   CC      qom/container.o
>>   CC      qom/qom-qobject.o
>>   CC      qom/object_interfaces.o
>>   GEN     qemu-img-cmds.h
>>   CC      qemu-io.o
>>   CC      scsi/qemu-pr-helper.o
>>   CC      qemu-bridge-helper.o
>>   CC      blockdev.o
>>   CC      blockdev-nbd.o
>>   CC      bootdevice.o
>>   CC      iothread.o
>>   CC      qdev-monitor.o
>>   CC      device-hotplug.o
>>   CC      os-posix.o
>>   CC      bt-host.o
>>   CC      dma-helpers.o
>>   CC      bt-vhci.o
>>   CC      vl.o
>>   CC      tpm.o
>>   CC      device_tree.o
>>   CC      qmp-marshal.o
>>   CC      qmp.o
>>   CC      hmp.o
>>   CC      cpus-common.o
>>   CC      audio/audio.o
>>   CC      audio/noaudio.o
>>   CC      audio/wavaudio.o
>>   CC      audio/mixeng.o
>>   CC      audio/sdlaudio.o
>>   CC      audio/ossaudio.o
>>   CC      audio/spiceaudio.o
>>   CC      audio/wavcapture.o
>>   CC      backends/rng.o
>>   CC      backends/rng-egd.o
>>   CC      backends/rng-random.o
>>   CC      backends/tpm.o
>>   CC      backends/hostmem.o
>>   CC      backends/hostmem-ram.o
>>   CC      backends/hostmem-file.o
>>   CC      backends/cryptodev-builtin.o
>>   CC      backends/cryptodev.o
>>   CC      block/stream.o
>>   CC      chardev/msmouse.o
>>   CC      chardev/wctablet.o
>>   CC      chardev/testdev.o
>>   CC      chardev/spice.o
>>   CC      disas/arm.o
>>   CC      disas/i386.o
>>   CC      fsdev/qemu-fsdev-dummy.o
>>   CC      fsdev/qemu-fsdev-opts.o
>>   CC      fsdev/qemu-fsdev-throttle.o
>>   CC      hw/acpi/core.o
>>   CC      hw/acpi/piix4.o
>>   CC      hw/acpi/pcihp.o
>>   CC      hw/acpi/ich9.o
>>   CC      hw/acpi/tco.o
>>   CC      hw/acpi/cpu_hotplug.o
>>   CC      hw/acpi/memory_hotplug.o
>>   CC      hw/acpi/cpu.o
>>   CC      hw/acpi/nvdimm.o
>>   CC      hw/acpi/vmgenid.o
>>   CC      hw/acpi/acpi_interface.o
>>   CC      hw/acpi/bios-linker-loader.o
>>   CC      hw/acpi/aml-build.o
>>   CC      hw/acpi/ipmi.o
>>   CC      hw/acpi/acpi-stub.o
>>   CC      hw/acpi/ipmi-stub.o
>>   CC      hw/audio/sb16.o
>>   CC      hw/audio/es1370.o
>>   CC      hw/audio/ac97.o
>>   CC      hw/audio/fmopl.o
>>   CC      hw/audio/adlib.o
>>   CC      hw/audio/gus.o
>>   CC      hw/audio/gusemu_hal.o
>>   CC      hw/audio/gusemu_mixer.o
>>   CC      hw/audio/cs4231a.o
>>   CC      hw/audio/intel-hda.o
>>   CC      hw/audio/hda-codec.o
>>   CC      hw/audio/pcspk.o
>>   CC      hw/audio/wm8750.o
>>   CC      hw/audio/pl041.o
>>   CC      hw/audio/lm4549.o
>>   CC      hw/audio/marvell_88w8618.o
>>   CC      hw/audio/soundhw.o
>>   CC      hw/block/block.o
>>   CC      hw/block/cdrom.o
>>   CC      hw/block/hd-geometry.o
>>   CC      hw/block/fdc.o
>>   CC      hw/block/m25p80.o
>>   CC      hw/block/nand.o
>>   CC      hw/block/pflash_cfi01.o
>>   CC      hw/block/pflash_cfi02.o
>>   CC      hw/block/xen_disk.o
>>   CC      hw/block/ecc.o
>>   CC      hw/block/onenand.o
>>   CC      hw/block/nvme.o
>>   CC      hw/bt/core.o
>>   CC      hw/bt/l2cap.o
>>   CC      hw/bt/sdp.o
>>   CC      hw/bt/hci.o
>>   CC      hw/bt/hid.o
>>   CC      hw/bt/hci-csr.o
>>   CC      hw/char/ipoctal232.o
>>   CC      hw/char/pl011.o
>>   CC      hw/char/parallel.o
>>   CC      hw/char/serial.o
>>   CC      hw/char/serial-isa.o
>>   CC      hw/char/serial-pci.o
>>   CC      hw/char/virtio-console.o
>>   CC      hw/char/xen_console.o
>>   CC      hw/char/cadence_uart.o
>>   CC      hw/char/debugcon.o
>>   CC      hw/char/cmsdk-apb-uart.o
>>   CC      hw/char/imx_serial.o
>>   CC      hw/core/qdev-properties.o
>>   CC      hw/core/qdev.o
>>   CC      hw/core/bus.o
>>   CC      hw/core/reset.o
>>   CC      hw/core/fw-path-provider.o
>>   CC      hw/core/irq.o
>>   CC      hw/core/hotplug.o
>>   CC      hw/core/ptimer.o
>>   CC      hw/core/nmi.o
>>   CC      hw/core/sysbus.o
>>   CC      hw/core/machine.o
>>   CC      hw/core/loader.o
>>   CC      hw/core/qdev-properties-system.o
>>   CC      hw/core/register.o
>>   CC      hw/core/or-irq.o
>>   CC      hw/core/platform-bus.o
>>   CC      hw/display/ads7846.o
>>   CC      hw/display/cirrus_vga.o
>>   CC      hw/cpu/core.o
>>   CC      hw/display/ssd0303.o
>>   CC      hw/display/pl110.o
>>   CC      hw/display/ssd0323.o
>>   CC      hw/display/xenfb.o
>>   CC      hw/display/vga-pci.o
>>   CC      hw/display/vga-isa.o
>>   CC      hw/display/vmware_vga.o
>>   CC      hw/display/blizzard.o
>>   CC      hw/display/exynos4210_fimd.o
>>   CC      hw/display/framebuffer.o
>>   CC      hw/display/tc6393xb.o
>>   CC      hw/display/qxl-logger.o
>>   CC      hw/display/qxl.o
>>   CC      hw/display/qxl-render.o
>>   CC      hw/dma/pl080.o
>>   CC      hw/dma/pl330.o
>>   CC      hw/dma/i8257.o
>>   CC      hw/dma/xlnx-zynq-devcfg.o
>>   CC      hw/gpio/max7310.o
>>   CC      hw/gpio/pl061.o
>>   CC      hw/gpio/zaurus.o
>>   CC      hw/gpio/gpio_key.o
>>   CC      hw/i2c/core.o
>>   CC      hw/i2c/smbus.o
>>   CC      hw/i2c/smbus_eeprom.o
>>   CC      hw/i2c/versatile_i2c.o
>>   CC      hw/i2c/i2c-ddc.o
>>   CC      hw/i2c/smbus_ich9.o
>>   CC      hw/i2c/pm_smbus.o
>>   CC      hw/i2c/bitbang_i2c.o
>>   CC      hw/i2c/exynos4210_i2c.o
>>   CC      hw/i2c/imx_i2c.o
>>   CC      hw/i2c/aspeed_i2c.o
>>   CC      hw/ide/core.o
>>   CC      hw/ide/atapi.o
>>   CC      hw/ide/qdev.o
>>   CC      hw/ide/pci.o
>>   CC      hw/ide/isa.o
>>   CC      hw/ide/piix.o
>>   CC      hw/ide/microdrive.o
>>   CC      hw/ide/ahci.o
>>   CC      hw/ide/ich.o
>>   CC      hw/ide/ahci-allwinner.o
>>   CC      hw/input/hid.o
>>   CC      hw/input/lm832x.o
>>   CC      hw/input/pckbd.o
>>   CC      hw/input/pl050.o
>>   CC      hw/input/ps2.o
>>   CC      hw/input/stellaris_input.o
>>   CC      hw/input/tsc2005.o
>>   CC      hw/input/vmmouse.o
>>   CC      hw/input/virtio-input.o
>>   CC      hw/input/virtio-input-hid.o
>>   CC      hw/input/virtio-input-host.o
>>   CC      hw/intc/i8259_common.o
>>   CC      hw/intc/pl190.o
>>   CC      hw/intc/i8259.o
>>   CC      hw/intc/imx_avic.o
>>   CC      hw/intc/realview_gic.o
>>   CC      hw/intc/ioapic_common.o
>>   CC      hw/intc/arm_gic_common.o
>>   CC      hw/intc/arm_gic.o
>>   CC      hw/intc/arm_gicv2m.o
>>   CC      hw/intc/arm_gicv3_common.o
>>   CC      hw/intc/arm_gicv3.o
>>   CC      hw/intc/arm_gicv3_dist.o
>>   CC      hw/intc/arm_gicv3_redist.o
>>   CC      hw/intc/arm_gicv3_its_common.o
>>   CC      hw/intc/intc.o
>>   CC      hw/ipack/ipack.o
>>   CC      hw/ipack/tpci200.o
>>   CC      hw/ipmi/ipmi.o
>>   CC      hw/ipmi/ipmi_bmc_sim.o
>>   CC      hw/ipmi/ipmi_bmc_extern.o
>>   CC      hw/ipmi/isa_ipmi_kcs.o
>>   CC      hw/ipmi/isa_ipmi_bt.o
>>   CC      hw/isa/isa-bus.o
>>   CC      hw/isa/apm.o
>>   CC      hw/mem/pc-dimm.o
>>   CC      hw/mem/nvdimm.o
>>   CC      hw/misc/applesmc.o
>>   CC      hw/misc/max111x.o
>>   CC      hw/misc/tmp105.o
>>   CC      hw/misc/tmp421.o
>>   CC      hw/misc/debugexit.o
>>   CC      hw/misc/sga.o
>>   CC      hw/misc/pc-testdev.o
>>   CC      hw/misc/pci-testdev.o
>>   CC      hw/misc/edu.o
>>   CC      hw/misc/unimp.o
>>   CC      hw/misc/vmcoreinfo.o
>>   CC      hw/misc/arm_l2x0.o
>>   CC      hw/misc/arm_integrator_debug.o
>>   CC      hw/misc/a9scu.o
>>   CC      hw/misc/arm11scu.o
>>   CC      hw/net/xen_nic.o
>>   CC      hw/net/ne2000.o
>>   CC      hw/net/eepro100.o
>>   CC      hw/net/pcnet-pci.o
>>   CC      hw/net/pcnet.o
>>   CC      hw/net/e1000.o
>>   CC      hw/net/e1000x_common.o
>>   CC      hw/net/net_tx_pkt.o
>>   CC      hw/net/net_rx_pkt.o
>>   CC      hw/net/e1000e.o
>>   CC      hw/net/e1000e_core.o
>>   CC      hw/net/rtl8139.o
>>   CC      hw/net/vmxnet3.o
>>   CC      hw/net/smc91c111.o
>>   CC      hw/net/xgmac.o
>>   CC      hw/net/ne2000-isa.o
>>   CC      hw/net/lan9118.o
>>   CC      hw/net/imx_fec.o
>>   CC      hw/net/allwinner_emac.o
>>   CC      hw/net/cadence_gem.o
>>   CC      hw/net/stellaris_enet.o
>>   CC      hw/net/ftgmac100.o
>>   CC      hw/net/rocker/rocker.o
>>   CC      hw/net/rocker/rocker_fp.o
>>   CC      hw/net/rocker/rocker_desc.o
>>   CC      hw/net/rocker/rocker_world.o
>>   CC      hw/net/rocker/rocker_of_dpa.o
>>   CC      hw/nvram/fw_cfg.o
>>   CC      hw/nvram/chrp_nvram.o
>>   CC      hw/nvram/eeprom93xx.o
>>   CC      hw/pci-bridge/pci_bridge_dev.o
>>   CC      hw/pci-bridge/gen_pcie_root_port.o
>>   CC      hw/pci-bridge/pcie_root_port.o
>>   CC      hw/pci-bridge/pcie_pci_bridge.o
>>   CC      hw/pci-bridge/pci_expander_bridge.o
>>   CC      hw/pci-bridge/xio3130_upstream.o
>>   CC      hw/pci-bridge/xio3130_downstream.o
>>   CC      hw/pci-bridge/ioh3420.o
>>   CC      hw/pci-bridge/i82801b11.o
>>   CC      hw/pci-host/pam.o
>>   CC      hw/pci-host/versatile.o
>>   CC      hw/pci-host/piix.o
>>   CC      hw/pci-host/q35.o
>>   CC      hw/pci-host/gpex.o
>>   CC      hw/pci/pci_bridge.o
>>   CC      hw/pci/pci.o
>>   CC      hw/pci/msix.o
>>   CC      hw/pci/msi.o
>>   CC      hw/pci/shpc.o
>>   CC      hw/pci/slotid_cap.o
>>   CC      hw/pci/pci_host.o
>>   CC      hw/pci/pcie_host.o
>>   CC      hw/pci/pcie.o
>>   CC      hw/pci/pcie_aer.o
>>   CC      hw/pci/pcie_port.o
>>   CC      hw/pci/pci-stub.o
>>   CC      hw/pcmcia/pcmcia.o
>>   CC      hw/scsi/scsi-disk.o
>>   CC      hw/scsi/scsi-generic.o
>>   CC      hw/scsi/scsi-bus.o
>>   CC      hw/scsi/mptsas.o
>>   CC      hw/scsi/lsi53c895a.o
>>   CC      hw/scsi/mptconfig.o
>>   CC      hw/scsi/mptendian.o
>>   CC      hw/scsi/megasas.o
>>   CC      hw/scsi/vmw_pvscsi.o
>>   CC      hw/scsi/esp.o
>>   CC      hw/scsi/esp-pci.o
>>   CC      hw/sd/pl181.o
>>   CC      hw/sd/sd.o
>>   CC      hw/sd/ssi-sd.o
>>   CC      hw/sd/core.o
>>   CC      hw/sd/sdhci.o
>>   CC      hw/smbios/smbios.o
>>   CC      hw/smbios/smbios_type_38.o
>>   CC      hw/smbios/smbios-stub.o
>>   CC      hw/smbios/smbios_type_38-stub.o
>>   CC      hw/ssi/pl022.o
>>   CC      hw/ssi/ssi.o
>>   CC      hw/ssi/xilinx_spips.o
>>   CC      hw/ssi/aspeed_smc.o
>>   CC      hw/ssi/stm32f2xx_spi.o
>>   CC      hw/ssi/mss-spi.o
>>   CC      hw/timer/arm_timer.o
>>   CC      hw/timer/arm_mptimer.o
>>   CC      hw/timer/armv7m_systick.o
>>   CC      hw/timer/a9gtimer.o
>>   CC      hw/timer/cadence_ttc.o
>>   CC      hw/timer/ds1338.o
>>   CC      hw/timer/hpet.o
>>   CC      hw/timer/i8254_common.o
>>   CC      hw/timer/i8254.o
>>   CC      hw/timer/pl031.o
>>   CC      hw/timer/twl92230.o
>>   CC      hw/timer/imx_epit.o
>>   CC      hw/timer/imx_gpt.o
>>   CC      hw/timer/stm32f2xx_timer.o
>>   CC      hw/timer/aspeed_timer.o
>>   CC      hw/timer/cmsdk-apb-timer.o
>>   CC      hw/timer/mss-timer.o
>>   CC      hw/tpm/tpm_tis.o
>>   CC      hw/tpm/tpm_passthrough.o
>>   CC      hw/tpm/tpm_util.o
>>   CC      hw/usb/core.o
>>   CC      hw/tpm/tpm_emulator.o
>>   CC      hw/usb/combined-packet.o
>>   CC      hw/usb/bus.o
>>   CC      hw/usb/libhw.o
>>   CC      hw/usb/desc.o
>>   CC      hw/usb/desc-msos.o
>>   CC      hw/usb/hcd-uhci.o
>>   CC      hw/usb/hcd-ohci.o
>>   CC      hw/usb/hcd-ehci-pci.o
>>   CC      hw/usb/hcd-ehci.o
>>   CC      hw/usb/hcd-ehci-sysbus.o
>>   CC      hw/usb/hcd-xhci.o
>>   CC      hw/usb/hcd-xhci-nec.o
>>   CC      hw/usb/hcd-musb.o
>>   CC      hw/usb/dev-hub.o
>>   CC      hw/usb/dev-hid.o
>>   CC      hw/usb/dev-wacom.o
>>   CC      hw/usb/dev-storage.o
>>   CC      hw/usb/dev-uas.o
>>   CC      hw/usb/dev-audio.o
>>   CC      hw/usb/dev-serial.o
>>   CC      hw/usb/dev-network.o
>>   CC      hw/usb/dev-bluetooth.o
>>   CC      hw/usb/dev-smartcard-reader.o
>>   CC      hw/usb/ccid-card-passthru.o
>>   CC      hw/usb/ccid-card-emulated.o
>>   CC      hw/usb/dev-mtp.o
>>   CC      hw/usb/host-stub.o
>>   CC      hw/virtio/virtio-rng.o
>>   CC      hw/virtio/virtio-pci.o
>>   CC      hw/virtio/virtio-bus.o
>>   CC      hw/virtio/virtio-mmio.o
>>   CC      hw/virtio/vhost-stub.o
>>   CC      hw/watchdog/watchdog.o
>>   CC      hw/watchdog/wdt_i6300esb.o
>>   CC      hw/watchdog/wdt_ib700.o
>>   CC      hw/watchdog/wdt_aspeed.o
>>   CC      hw/xen/xen_backend.o
>>   CC      hw/xen/xen_devconfig.o
>>   CC      hw/xen/xen-common.o
>>   CC      hw/xen/xen_pvdev.o
>>   CC      migration/migration.o
>>   CC      migration/socket.o
>>   CC      migration/fd.o
>>   CC      migration/exec.o
>>   CC      migration/tls.o
>>   CC      migration/channel.o
>>   CC      migration/savevm.o
>>   CC      migration/colo-comm.o
>>   CC      migration/colo.o
>>   CC      migration/colo-failover.o
>>   CC      migration/vmstate.o
>>   CC      migration/vmstate-types.o
>>   CC      migration/page_cache.o
>>   CC      migration/qemu-file.o
>>   CC      migration/global_state.o
>>   CC      migration/qemu-file-channel.o
>>   CC      migration/xbzrle.o
>>   CC      migration/postcopy-ram.o
>>   CC      migration/qjson.o
>>   CC      migration/rdma.o
>>   CC      migration/block.o
>>   CC      net/net.o
>>   CC      net/queue.o
>>   CC      net/checksum.o
>>   CC      net/util.o
>>   CC      net/hub.o
>>   CC      net/socket.o
>>   CC      net/eth.o
>>   CC      net/dump.o
>>   CC      net/l2tpv3.o
>>   CC      net/vhost-user.o
>>   CC      net/slirp.o
>>   CC      net/filter.o
>>   CC      net/filter-buffer.o
>>   CC      net/colo-compare.o
>>   CC      net/filter-mirror.o
>>   CC      net/colo.o
>>   CC      net/filter-replay.o
>>   CC      net/filter-rewriter.o
>>   CC      net/tap.o
>>   CC      net/tap-linux.o
>>   CC      qom/cpu.o
>>   CC      replay/replay.o
>>   CC      replay/replay-internal.o
>>   CC      replay/replay-events.o
>>   CC      replay/replay-time.o
>>   CC      replay/replay-input.o
>>   CC      replay/replay-char.o
>> /tmp/qemu-test/src/replay/replay-internal.c: In function
>> 'replay_put_array':
>> /tmp/qemu-test/src/replay/replay-internal.c:65: warning: ignoring return
>> value of 'fwrite', declared with attribute warn_unused_result
>>   CC      replay/replay-snapshot.o
>>   CC      replay/replay-net.o
>>   CC      replay/replay-audio.o
>>   CC      slirp/cksum.o
>>   CC      slirp/if.o
>>   CC      slirp/ip_icmp.o
>>   CC      slirp/ip6_icmp.o
>>   CC      slirp/ip6_input.o
>>   CC      slirp/ip6_output.o
>>   CC      slirp/ip_input.o
>>   CC      slirp/dnssearch.o
>>   CC      slirp/ip_output.o
>>   CC      slirp/dhcpv6.o
>>   CC      slirp/slirp.o
>>   CC      slirp/mbuf.o
>>   CC      slirp/misc.o
>>   CC      slirp/sbuf.o
>>   CC      slirp/socket.o
>>   CC      slirp/tcp_input.o
>>   CC      slirp/tcp_output.o
>>   CC      slirp/tcp_timer.o
>>   CC      slirp/tcp_subr.o
>>   CC      slirp/udp.o
>>   CC      slirp/udp6.o
>>   CC      slirp/bootp.o
>> /tmp/qemu-test/src/slirp/tcp_input.c: In function 'tcp_input':
>> /tmp/qemu-test/src/slirp/tcp_input.c:219: warning: 'save_ip.ip_p' may be
>> used uninitialized in this function
>> /tmp/qemu-test/src/slirp/tcp_input.c:219: warning: 'save_ip.ip_len' may =
be
>> used uninitialized in this function
>> /tmp/qemu-test/src/slirp/tcp_input.c:219: warning: 'save_ip.ip_tos' may =
be
>> used uninitialized in this function
>> /tmp/qemu-test/src/slirp/tcp_input.c:219: warning: 'save_ip.ip_id' may b=
e
>> used uninitialized in this function
>> /tmp/qemu-test/src/slirp/tcp_input.c:219: warning: 'save_ip.ip_off' may =
be
>> used uninitialized in this function
>> /tmp/qemu-test/src/slirp/tcp_input.c:219: warning: 'save_ip.ip_ttl' may =
be
>> used uninitialized in this function
>> /tmp/qemu-test/src/slirp/tcp_input.c:219: warning: 'save_ip.ip_sum' may =
be
>> used uninitialized in this function
>> /tmp/qemu-test/src/slirp/tcp_input.c:219: warning: 'save_ip.ip_src.s_add=
r'
>> may be used uninitialized in this function
>> /tmp/qemu-test/src/slirp/tcp_input.c:219: warning: 'save_ip.ip_dst.s_add=
r'
>> may be used uninitialized in this function
>> /tmp/qemu-test/src/slirp/tcp_input.c:220: warning: 'save_ip6.ip_nh' may =
be
>> used uninitialized in this function
>>   CC      slirp/tftp.o
>>   CC      slirp/arp_table.o
>>   CC      slirp/ndp_table.o
>>   CC      slirp/ncsi.o
>>   CC      ui/keymaps.o
>>   CC      ui/console.o
>>   CC      ui/cursor.o
>>   CC      ui/qemu-pixman.o
>>   CC      ui/input.o
>>   CC      ui/input-keymap.o
>>   CC      ui/input-legacy.o
>>   CC      ui/input-linux.o
>>   CC      ui/spice-core.o
>>   CC      ui/spice-input.o
>>   CC      ui/spice-display.o
>>   CC      ui/sdl.o
>>   CC      ui/sdl_zoom.o
>>   CC      ui/x_keymap.o
>>   CC      ui/curses.o
>>   CC      ui/vnc.o
>>   CC      ui/vnc-enc-zlib.o
>>   CC      ui/vnc-enc-hextile.o
>>   CC      ui/vnc-enc-tight.o
>>   CC      ui/vnc-palette.o
>>   CC      ui/vnc-enc-zrle.o
>>   CC      ui/vnc-auth-vencrypt.o
>>   CC      ui/vnc-ws.o
>>   CC      ui/vnc-jobs.o
>>   CC      ui/gtk.o
>>   VERT    ui/shader/texture-blit-vert.h
>>   VERT    ui/shader/texture-blit-flip-vert.h
>>   FRAG    ui/shader/texture-blit-frag.h
>>   CC      ui/egl-helpers.o
>>   CC      ui/egl-context.o
>>   CC      ui/console-gl.o
>>   CC      ui/gtk-egl.o
>>   CC      chardev/char.o
>>   CC      chardev/char-fd.o
>>   CC      chardev/char-fe.o
>>   CC      chardev/char-file.o
>>   CC      chardev/char-io.o
>>   CC      chardev/char-mux.o
>>   CC      chardev/char-null.o
>>   CC      chardev/char-parallel.o
>>   CC      chardev/char-pipe.o
>>   CC      chardev/char-pty.o
>>   CC      chardev/char-ringbuf.o
>>   CC      chardev/char-serial.o
>>   CC      chardev/char-stdio.o
>>   CC      chardev/char-udp.o
>>   CC      chardev/char-socket.o
>>   LINK    tests/qemu-iotests/socket_scm_helper
>>   CC      qga/commands.o
>>   CC      qga/guest-agent-command-state.o
>>   CC      qga/main.o
>>   CC      qga/commands-posix.o
>>   CC      qga/channel-posix.o
>>   CC      qga/qapi-generated/qga-qapi-types.o
>>   CC      qga/qapi-generated/qga-qapi-visit.o
>>   CC      qga/qapi-generated/qga-qmp-marshal.o
>>   AR      libqemuutil.a
>>   CC      qemu-img.o
>>   AS      optionrom/multiboot.o
>>   AS      optionrom/linuxboot.o
>>   CC      ui/shader.o
>>   CC      optionrom/linuxboot_dma.o
>>   BUILD   optionrom/multiboot.img
>>   AS      optionrom/kvmvapic.o
>>   BUILD   optionrom/linuxboot.img
>> cc: unrecognized option '-no-integrated-as'
>> cc: unrecognized option '-no-integrated-as'
>>   BUILD   optionrom/linuxboot.raw
>>   BUILD   optionrom/multiboot.raw
>>   BUILD   optionrom/linuxboot_dma.img
>>   BUILD   optionrom/linuxboot_dma.raw
>>   BUILD   optionrom/kvmvapic.img
>>   SIGN    optionrom/multiboot.bin
>>   BUILD   optionrom/kvmvapic.raw
>>   SIGN    optionrom/linuxboot.bin
>>   SIGN    optionrom/linuxboot_dma.bin
>>   SIGN    optionrom/kvmvapic.bin
>>   LINK    qemu-ga
>>   LINK    ivshmem-client
>>   LINK    ivshmem-server
>>   LINK    qemu-nbd
>>   LINK    qemu-img
>>   LINK    qemu-io
>>   LINK    scsi/qemu-pr-helper
>>   LINK    qemu-bridge-helper
>> In file included from /usr/include/gtk-2.0/gtk/gtk.h:235,
>>                  from /tmp/qemu-test/src/include/ui/gtk.h:10,
>>                  from /tmp/qemu-test/src/ui/gtk-egl.c:21:
>> /usr/include/gtk-2.0/gtk/gtkitemfactory.h:47: warning: function
>> declaration isn't a prototype
>> In file included from /usr/include/gtk-2.0/gtk/gtk.h:235,
>>                  from /tmp/qemu-test/src/include/ui/gtk.h:10,
>>                  from /tmp/qemu-test/src/ui/gtk.c:43:
>> /usr/include/gtk-2.0/gtk/gtkitemfactory.h:47: warning: function
>> declaration isn't a prototype
>>   GEN     x86_64-softmmu/hmp-commands.h
>>   GEN     x86_64-softmmu/hmp-commands-info.h
>>   GEN     x86_64-softmmu/config-target.h
>>   GEN     aarch64-softmmu/hmp-commands.h
>>   GEN     aarch64-softmmu/hmp-commands-info.h
>>   GEN     aarch64-softmmu/config-target.h
>>   CC      x86_64-softmmu/exec.o
>>   CC      x86_64-softmmu/tcg/tcg-op.o
>>   CC      x86_64-softmmu/tcg/optimize.o
>>   CC      x86_64-softmmu/fpu/softfloat.o
>>   CC      x86_64-softmmu/tcg/tcg.o
>>   CC      x86_64-softmmu/tcg/tcg-common.o
>>   CC      x86_64-softmmu/disas.o
>>   CC      aarch64-softmmu/exec.o
>>   CC      aarch64-softmmu/tcg/tcg.o
>>   GEN     x86_64-softmmu/gdbstub-xml.c
>>   CC      x86_64-softmmu/arch_init.o
>>   CC      aarch64-softmmu/tcg/tcg-op.o
>>   CC      aarch64-softmmu/tcg/optimize.o
>>   CC      x86_64-softmmu/cpus.o
>>   CC      aarch64-softmmu/tcg/tcg-common.o
>>   CC      x86_64-softmmu/monitor.o
>>   CC      x86_64-softmmu/gdbstub.o
>>   CC      aarch64-softmmu/fpu/softfloat.o
>>   CC      x86_64-softmmu/balloon.o
>>   CC      aarch64-softmmu/disas.o
>>   CC      x86_64-softmmu/numa.o
>>   CC      x86_64-softmmu/ioport.o
>>   CC      x86_64-softmmu/qtest.o
>>   GEN     aarch64-softmmu/gdbstub-xml.c
>>   CC      aarch64-softmmu/arch_init.o
>>   CC      aarch64-softmmu/cpus.o
>>   CC      aarch64-softmmu/monitor.o
>>   CC      x86_64-softmmu/memory.o
>>   CC      x86_64-softmmu/memory_mapping.o
>>   CC      aarch64-softmmu/gdbstub.o
>>   CC      x86_64-softmmu/dump.o
>>   CC      aarch64-softmmu/balloon.o
>>   CC      aarch64-softmmu/ioport.o
>>   CC      aarch64-softmmu/numa.o
>>   CC      x86_64-softmmu/migration/ram.o
>>   CC      x86_64-softmmu/accel/accel.o
>>   CC      aarch64-softmmu/qtest.o
>>   CC      x86_64-softmmu/accel/kvm/kvm-all.o
>>   CC      x86_64-softmmu/accel/stubs/hax-stub.o
>>   CC      aarch64-softmmu/memory.o
>>   CC      aarch64-softmmu/memory_mapping.o
>>   CC      x86_64-softmmu/accel/tcg/tcg-all.o
>>   CC      x86_64-softmmu/accel/tcg/cputlb.o
>>   CC      x86_64-softmmu/accel/tcg/tcg-runtime.o
>>   CC      x86_64-softmmu/accel/tcg/cpu-exec.o
>>   CC      x86_64-softmmu/accel/tcg/cpu-exec-common.o
>>   CC      aarch64-softmmu/dump.o
>>   CC      x86_64-softmmu/accel/tcg/translate-all.o
>>   CC      aarch64-softmmu/migration/ram.o
>>   CC      x86_64-softmmu/accel/tcg/translator.o
>>   CC      x86_64-softmmu/hw/block/virtio-blk.o
>>   CC      x86_64-softmmu/hw/block/dataplane/virtio-blk.o
>>   CC      aarch64-softmmu/accel/accel.o
>>   CC      x86_64-softmmu/hw/char/virtio-serial-bus.o
>>   CC      x86_64-softmmu/hw/core/generic-loader.o
>>   CC      aarch64-softmmu/accel/stubs/hax-stub.o
>>   CC      x86_64-softmmu/hw/core/null-machine.o
>>   CC      x86_64-softmmu/hw/display/vga.o
>>   CC      x86_64-softmmu/hw/display/virtio-gpu.o
>>   CC      x86_64-softmmu/hw/display/virtio-gpu-3d.o
>>   CC      aarch64-softmmu/accel/stubs/kvm-stub.o
>>   CC      aarch64-softmmu/accel/tcg/tcg-all.o
>>   CC      aarch64-softmmu/accel/tcg/cputlb.o
>>   CC      x86_64-softmmu/hw/display/virtio-gpu-pci.o
>>   CC      x86_64-softmmu/hw/display/virtio-vga.o
>>   CC      x86_64-softmmu/hw/intc/apic.o
>>   CC      aarch64-softmmu/accel/tcg/tcg-runtime.o
>>   CC      x86_64-softmmu/hw/intc/apic_common.o
>>   CC      aarch64-softmmu/accel/tcg/cpu-exec.o
>>   CC      x86_64-softmmu/hw/intc/ioapic.o
>>   CC      aarch64-softmmu/accel/tcg/cpu-exec-common.o
>>   CC      x86_64-softmmu/hw/isa/lpc_ich9.o
>>   CC      x86_64-softmmu/hw/misc/vmport.o
>>   CC      x86_64-softmmu/hw/misc/ivshmem.o
>>   CC      x86_64-softmmu/hw/misc/pvpanic.o
>>   CC      x86_64-softmmu/hw/misc/hyperv_testdev.o
>>   CC      aarch64-softmmu/accel/tcg/translate-all.o
>>   CC      x86_64-softmmu/hw/misc/mmio_interface.o
>>   CC      x86_64-softmmu/hw/net/virtio-net.o
>>   CC      x86_64-softmmu/hw/net/vhost_net.o
>>   CC      x86_64-softmmu/hw/scsi/virtio-scsi.o
>>   CC      x86_64-softmmu/hw/scsi/virtio-scsi-dataplane.o
>>   CC      x86_64-softmmu/hw/scsi/vhost-scsi-common.o
>>   CC      x86_64-softmmu/hw/scsi/vhost-scsi.o
>>   CC      aarch64-softmmu/accel/tcg/translator.o
>>   CC      aarch64-softmmu/hw/adc/stm32f2xx_adc.o
>>   CC      x86_64-softmmu/hw/scsi/vhost-user-scsi.o
>>   CC      x86_64-softmmu/hw/timer/mc146818rtc.o
>>   CC      aarch64-softmmu/hw/block/virtio-blk.o
>>   CC      x86_64-softmmu/hw/vfio/common.o
>>   CC      x86_64-softmmu/hw/vfio/pci.o
>>   CC      x86_64-softmmu/hw/vfio/pci-quirks.o
>>   CC      x86_64-softmmu/hw/vfio/platform.o
>>   CC      x86_64-softmmu/hw/vfio/spapr.o
>>   CC      aarch64-softmmu/hw/block/dataplane/virtio-blk.o
>>   CC      aarch64-softmmu/hw/char/exynos4210_uart.o
>>   CC      x86_64-softmmu/hw/virtio/virtio.o
>>   CC      x86_64-softmmu/hw/virtio/virtio-balloon.o
>>   CC      aarch64-softmmu/hw/char/omap_uart.o
>>   CC      x86_64-softmmu/hw/virtio/vhost.o
>>   CC      x86_64-softmmu/hw/virtio/vhost-user.o
>>   CC      x86_64-softmmu/hw/virtio/vhost-backend.o
>>   CC      aarch64-softmmu/hw/char/digic-uart.o
>>   CC      x86_64-softmmu/hw/virtio/vhost-vsock.o
>>   CC      x86_64-softmmu/hw/virtio/virtio-crypto.o
>>   CC      aarch64-softmmu/hw/char/stm32f2xx_usart.o
>>   CC      aarch64-softmmu/hw/char/bcm2835_aux.o
>>   CC      aarch64-softmmu/hw/char/virtio-serial-bus.o
>>   CC      x86_64-softmmu/hw/virtio/virtio-crypto-pci.o
>>   CC      x86_64-softmmu/hw/xen/xen-host-pci-device.o
>>   CC      x86_64-softmmu/hw/xen/xen_pt.o
>>   CC      aarch64-softmmu/hw/core/generic-loader.o
>>   CC      aarch64-softmmu/hw/core/null-machine.o
>>   CC      x86_64-softmmu/hw/xen/xen_pt_config_init.o
>>   CC      aarch64-softmmu/hw/cpu/arm11mpcore.o
>>   CC      x86_64-softmmu/hw/xen/xen_pt_graphics.o
>>   CC      aarch64-softmmu/hw/cpu/realview_mpcore.o
>>   CC      aarch64-softmmu/hw/cpu/a9mpcore.o
>>   CC      x86_64-softmmu/hw/xen/xen_pt_msi.o
>>   CC      aarch64-softmmu/hw/cpu/a15mpcore.o
>>   CC      aarch64-softmmu/hw/display/omap_dss.o
>>   CC      aarch64-softmmu/hw/display/omap_lcdc.o
>>   CC      aarch64-softmmu/hw/display/pxa2xx_lcd.o
>>   CC      aarch64-softmmu/hw/display/bcm2835_fb.o
>>   CC      aarch64-softmmu/hw/display/vga.o
>>   CC      aarch64-softmmu/hw/display/virtio-gpu.o
>>   CC      x86_64-softmmu/hw/xen/xen_pt_load_rom.o
>>   CC      x86_64-softmmu/hw/i386/multiboot.o
>>   CC      aarch64-softmmu/hw/display/virtio-gpu-3d.o
>>   CC      aarch64-softmmu/hw/display/virtio-gpu-pci.o
>>   CC      aarch64-softmmu/hw/display/dpcd.o
>>   CC      aarch64-softmmu/hw/display/xlnx_dp.o
>>   CC      aarch64-softmmu/hw/dma/xlnx_dpdma.o
>>   CC      aarch64-softmmu/hw/dma/omap_dma.o
>>   CC      x86_64-softmmu/hw/i386/pc.o
>>   CC      x86_64-softmmu/hw/i386/pc_piix.o
>>   CC      aarch64-softmmu/hw/dma/soc_dma.o
>>   CC      x86_64-softmmu/hw/i386/pc_q35.o
>>   CC      aarch64-softmmu/hw/dma/pxa2xx_dma.o
>>   CC      aarch64-softmmu/hw/dma/bcm2835_dma.o
>>   CC      aarch64-softmmu/hw/gpio/omap_gpio.o
>>   CC      aarch64-softmmu/hw/gpio/imx_gpio.o
>>   CC      x86_64-softmmu/hw/i386/pc_sysfw.o
>>   CC      aarch64-softmmu/hw/gpio/bcm2835_gpio.o
>> /tmp/qemu-test/src/hw/i386/pc_piix.c: In function
>> 'igd_passthrough_isa_bridge_create':
>> /tmp/qemu-test/src/hw/i386/pc_piix.c:1073: warning: 'pch_rev_id' may be
>> used uninitialized in this function
>>   CC      x86_64-softmmu/hw/i386/x86-iommu.o
>>   CC      x86_64-softmmu/hw/i386/intel_iommu.o
>>   CC      aarch64-softmmu/hw/i2c/omap_i2c.o
>>   CC      x86_64-softmmu/hw/i386/amd_iommu.o
>>   CC      x86_64-softmmu/hw/i386/kvmvapic.o
>>   CC      aarch64-softmmu/hw/input/pxa2xx_keypad.o
>>   CC      aarch64-softmmu/hw/input/tsc210x.o
>>   CC      x86_64-softmmu/hw/i386/acpi-build.o
>>   CC      x86_64-softmmu/hw/i386/../xenpv/xen_machine_pv.o
>>   CC      x86_64-softmmu/hw/i386/kvm/clock.o
>>   CC      x86_64-softmmu/hw/i386/kvm/apic.o
>>   CC      aarch64-softmmu/hw/intc/armv7m_nvic.o
>>   CC      x86_64-softmmu/hw/i386/kvm/i8259.o
>>   CC      aarch64-softmmu/hw/intc/exynos4210_gic.o
>>   CC      x86_64-softmmu/hw/i386/kvm/ioapic.o
>> /tmp/qemu-test/src/hw/i386/acpi-build.c: In function
>> 'build_append_pci_bus_devices':
>> /tmp/qemu-test/src/hw/i386/acpi-build.c:509: warning: 'notify_method' ma=
y
>> be used uninitialized in this function
>>   CC      x86_64-softmmu/hw/i386/kvm/i8254.o
>>   CC      x86_64-softmmu/hw/i386/xen/xen_platform.o
>>   CC      x86_64-softmmu/hw/i386/xen/xen_apic.o
>>   CC      aarch64-softmmu/hw/intc/exynos4210_combiner.o
>>   CC      aarch64-softmmu/hw/intc/omap_intc.o
>>   CC      x86_64-softmmu/hw/i386/xen/xen_pvdevice.o
>>   CC      x86_64-softmmu/hw/i386/xen/xen-hvm.o
>>   CC      x86_64-softmmu/hw/i386/xen/xen-mapcache.o
>>   CC      x86_64-softmmu/target/i386/helper.o
>>   CC      x86_64-softmmu/target/i386/cpu.o
>>   CC      aarch64-softmmu/hw/intc/bcm2835_ic.o
>>   CC      x86_64-softmmu/target/i386/gdbstub.o
>>   CC      x86_64-softmmu/target/i386/xsave_helper.o
>>   CC      aarch64-softmmu/hw/intc/bcm2836_control.o
>>   CC      x86_64-softmmu/target/i386/translate.o
>>   CC      x86_64-softmmu/target/i386/bpt_helper.o
>>   CC      aarch64-softmmu/hw/intc/allwinner-a10-pic.o
>>   CC      x86_64-softmmu/target/i386/cc_helper.o
>>   CC      x86_64-softmmu/target/i386/excp_helper.o
>>   CC      aarch64-softmmu/hw/intc/aspeed_vic.o
>>   CC      x86_64-softmmu/target/i386/fpu_helper.o
>>   CC      aarch64-softmmu/hw/intc/arm_gicv3_cpuif.o
>>   CC      x86_64-softmmu/target/i386/int_helper.o
>>   CC      aarch64-softmmu/hw/misc/ivshmem.o
>>   CC      aarch64-softmmu/hw/misc/arm_sysctl.o
>>   CC      x86_64-softmmu/target/i386/mem_helper.o
>>   CC      aarch64-softmmu/hw/misc/cbus.o
>>   CC      x86_64-softmmu/target/i386/misc_helper.o
>>   CC      aarch64-softmmu/hw/misc/exynos4210_pmu.o
>>   CC      x86_64-softmmu/target/i386/mpx_helper.o
>>   CC      x86_64-softmmu/target/i386/seg_helper.o
>>   CC      aarch64-softmmu/hw/misc/exynos4210_clk.o
>>   CC      aarch64-softmmu/hw/misc/exynos4210_rng.o
>>   CC      x86_64-softmmu/target/i386/smm_helper.o
>>   CC      x86_64-softmmu/target/i386/svm_helper.o
>>   CC      aarch64-softmmu/hw/misc/imx_ccm.o
>>   CC      aarch64-softmmu/hw/misc/imx31_ccm.o
>>   CC      x86_64-softmmu/target/i386/machine.o
>>   CC      aarch64-softmmu/hw/misc/imx25_ccm.o
>>   CC      aarch64-softmmu/hw/misc/imx6_ccm.o
>>   CC      x86_64-softmmu/target/i386/arch_memory_mapping.o
>>   CC      x86_64-softmmu/target/i386/arch_dump.o
>>   CC      x86_64-softmmu/target/i386/monitor.o
>>   CC      x86_64-softmmu/target/i386/kvm.o
>>   CC      aarch64-softmmu/hw/misc/mst_fpga.o
>>   CC      aarch64-softmmu/hw/misc/imx6_src.o
>>   CC      aarch64-softmmu/hw/misc/omap_clk.o
>>   CC      aarch64-softmmu/hw/misc/omap_gpmc.o
>>   CC      x86_64-softmmu/target/i386/hyperv.o
>>   CC      aarch64-softmmu/hw/misc/omap_l4.o
>>   CC      aarch64-softmmu/hw/misc/omap_sdrc.o
>>   CC      aarch64-softmmu/hw/misc/omap_tap.o
>>   CC      aarch64-softmmu/hw/misc/bcm2835_mbox.o
>>   CC      x86_64-softmmu/trace/control-target.o
>>   CC      aarch64-softmmu/hw/misc/bcm2835_property.o
>>   GEN     trace/generated-helpers.c
>>   CC      aarch64-softmmu/hw/misc/bcm2835_rng.o
>>   CC      x86_64-softmmu/gdbstub-xml.o
>>   CC      aarch64-softmmu/hw/misc/zynq_slcr.o
>>   CC      aarch64-softmmu/hw/misc/zynq-xadc.o
>>   CC      aarch64-softmmu/hw/misc/stm32f2xx_syscfg.o
>>   CC      aarch64-softmmu/hw/misc/mps2-scc.o
>>   CC      aarch64-softmmu/hw/misc/auxbus.o
>>   CC      aarch64-softmmu/hw/misc/aspeed_scu.o
>>   CC      x86_64-softmmu/trace/generated-helpers.o
>>   CC      aarch64-softmmu/hw/misc/aspeed_sdmc.o
>>   CC      aarch64-softmmu/hw/misc/mmio_interface.o
>>   CC      aarch64-softmmu/hw/misc/msf2-sysreg.o
>>   CC      aarch64-softmmu/hw/net/virtio-net.o
>>   CC      aarch64-softmmu/hw/net/vhost_net.o
>>   CC      aarch64-softmmu/hw/pcmcia/pxa2xx.o
>>   CC      aarch64-softmmu/hw/scsi/virtio-scsi.o
>>   CC      aarch64-softmmu/hw/scsi/virtio-scsi-dataplane.o
>>   CC      aarch64-softmmu/hw/scsi/vhost-scsi-common.o
>>   CC      aarch64-softmmu/hw/scsi/vhost-scsi.o
>>   CC      aarch64-softmmu/hw/scsi/vhost-user-scsi.o
>>   CC      aarch64-softmmu/hw/sd/omap_mmc.o
>>   LINK    x86_64-softmmu/qemu-system-x86_64
>>   CC      aarch64-softmmu/hw/sd/pxa2xx_mmci.o
>>   CC      aarch64-softmmu/hw/sd/bcm2835_sdhost.o
>>   CC      aarch64-softmmu/hw/ssi/omap_spi.o
>>   CC      aarch64-softmmu/hw/ssi/imx_spi.o
>>   CC      aarch64-softmmu/hw/timer/exynos4210_mct.o
>>   CC      aarch64-softmmu/hw/timer/exynos4210_pwm.o
>>   CC      aarch64-softmmu/hw/timer/exynos4210_rtc.o
>>   CC      aarch64-softmmu/hw/timer/omap_gptimer.o
>>   CC      aarch64-softmmu/hw/timer/omap_synctimer.o
>>   CC      aarch64-softmmu/hw/timer/pxa2xx_timer.o
>>   CC      aarch64-softmmu/hw/timer/digic-timer.o
>>   CC      aarch64-softmmu/hw/timer/allwinner-a10-pit.o
>>   CC      aarch64-softmmu/hw/usb/tusb6010.o
>>   CC      aarch64-softmmu/hw/vfio/common.o
>>   CC      aarch64-softmmu/hw/vfio/pci.o
>>   CC      aarch64-softmmu/hw/vfio/pci-quirks.o
>>   CC      aarch64-softmmu/hw/vfio/platform.o
>>   CC      aarch64-softmmu/hw/vfio/calxeda-xgmac.o
>>   CC      aarch64-softmmu/hw/vfio/amd-xgbe.o
>>   CC      aarch64-softmmu/hw/vfio/spapr.o
>>   CC      aarch64-softmmu/hw/virtio/virtio.o
>>   CC      aarch64-softmmu/hw/virtio/vhost.o
>>   CC      aarch64-softmmu/hw/virtio/virtio-balloon.o
>>   CC      aarch64-softmmu/hw/virtio/vhost-user.o
>>   CC      aarch64-softmmu/hw/virtio/vhost-backend.o
>>   CC      aarch64-softmmu/hw/virtio/vhost-vsock.o
>>   CC      aarch64-softmmu/hw/virtio/virtio-crypto.o
>>   CC      aarch64-softmmu/hw/virtio/virtio-crypto-pci.o
>>   CC      aarch64-softmmu/hw/arm/collie.o
>>   CC      aarch64-softmmu/hw/arm/boot.o
>>   CC      aarch64-softmmu/hw/arm/exynos4_boards.o
>>   CC      aarch64-softmmu/hw/arm/gumstix.o
>>   CC      aarch64-softmmu/hw/arm/highbank.o
>>   CC      aarch64-softmmu/hw/arm/digic_boards.o
>>   CC      aarch64-softmmu/hw/arm/integratorcp.o
>>   CC      aarch64-softmmu/hw/arm/mainstone.o
>>   CC      aarch64-softmmu/hw/arm/musicpal.o
>>   CC      aarch64-softmmu/hw/arm/nseries.o
>>   CC      aarch64-softmmu/hw/arm/omap_sx1.o
>>   CC      aarch64-softmmu/hw/arm/palm.o
>>   CC      aarch64-softmmu/hw/arm/realview.o
>>   CC      aarch64-softmmu/hw/arm/spitz.o
>>   CC      aarch64-softmmu/hw/arm/stellaris.o
>>   CC      aarch64-softmmu/hw/arm/tosa.o
>>   CC      aarch64-softmmu/hw/arm/versatilepb.o
>>   CC      aarch64-softmmu/hw/arm/virt.o
>>   CC      aarch64-softmmu/hw/arm/vexpress.o
>>   CC      aarch64-softmmu/hw/arm/virt-acpi-build.o
>>   CC      aarch64-softmmu/hw/arm/xilinx_zynq.o
>>   CC      aarch64-softmmu/hw/arm/z2.o
>>   CC      aarch64-softmmu/hw/arm/netduino2.o
>>   CC      aarch64-softmmu/hw/arm/sysbus-fdt.o
>>   CC      aarch64-softmmu/hw/arm/armv7m.o
>>   CC      aarch64-softmmu/hw/arm/exynos4210.o
>>   CC      aarch64-softmmu/hw/arm/pxa2xx.o
>>   CC      aarch64-softmmu/hw/arm/pxa2xx_gpio.o
>>   CC      aarch64-softmmu/hw/arm/pxa2xx_pic.o
>>   CC      aarch64-softmmu/hw/arm/digic.o
>>   CC      aarch64-softmmu/hw/arm/omap1.o
>>   CC      aarch64-softmmu/hw/arm/omap2.o
>>   CC      aarch64-softmmu/hw/arm/strongarm.o
>>   CC      aarch64-softmmu/hw/arm/allwinner-a10.o
>>   CC      aarch64-softmmu/hw/arm/cubieboard.o
>>   CC      aarch64-softmmu/hw/arm/bcm2835_peripherals.o
>>   CC      aarch64-softmmu/hw/arm/bcm2836.o
>>   CC      aarch64-softmmu/hw/arm/raspi.o
>>   CC      aarch64-softmmu/hw/arm/stm32f205_soc.o
>>   CC      aarch64-softmmu/hw/arm/xlnx-zcu102.o
>>   CC      aarch64-softmmu/hw/arm/xlnx-zynqmp.o
>>   CC      aarch64-softmmu/hw/arm/fsl-imx25.o
>>   CC      aarch64-softmmu/hw/arm/imx25_pdk.o
>>   CC      aarch64-softmmu/hw/arm/fsl-imx31.o
>>   CC      aarch64-softmmu/hw/arm/kzm.o
>>   CC      aarch64-softmmu/hw/arm/fsl-imx6.o
>>   CC      aarch64-softmmu/hw/arm/sabrelite.o
>>   CC      aarch64-softmmu/hw/arm/aspeed_soc.o
>>   CC      aarch64-softmmu/hw/arm/aspeed.o
>>   CC      aarch64-softmmu/hw/arm/mps2.o
>>   CC      aarch64-softmmu/hw/arm/msf2-soc.o
>>   CC      aarch64-softmmu/hw/arm/msf2-som.o
>>   CC      aarch64-softmmu/target/arm/arm-semi.o
>>   CC      aarch64-softmmu/target/arm/machine.o
>>   CC      aarch64-softmmu/target/arm/psci.o
>>   CC      aarch64-softmmu/target/arm/arch_dump.o
>>   CC      aarch64-softmmu/target/arm/monitor.o
>>   CC      aarch64-softmmu/target/arm/kvm-stub.o
>>   CC      aarch64-softmmu/target/arm/op_helper.o
>>   CC      aarch64-softmmu/target/arm/translate.o
>>   CC      aarch64-softmmu/target/arm/helper.o
>>   CC      aarch64-softmmu/target/arm/cpu.o
>>   CC      aarch64-softmmu/target/arm/neon_helper.o
>>   CC      aarch64-softmmu/target/arm/iwmmxt_helper.o
>>   CC      aarch64-softmmu/target/arm/gdbstub.o
>>   CC      aarch64-softmmu/target/arm/cpu64.o
>>   CC      aarch64-softmmu/target/arm/translate-a64.o
>>   CC      aarch64-softmmu/target/arm/helper-a64.o
>>   CC      aarch64-softmmu/target/arm/gdbstub64.o
>>   CC      aarch64-softmmu/target/arm/crypto_helper.o
>>   CC      aarch64-softmmu/target/arm/arm-powerctl.o
>> /tmp/qemu-test/src/target/arm/translate-a64.c: In function
>> 'handle_shri_with_rndacc':
>> /tmp/qemu-test/src/target/arm/translate-a64.c:6392: warning: 'tcg_src_hi=
'
>> may be used uninitialized in this function
>> /tmp/qemu-test/src/target/arm/translate-a64.c: In function
>> 'disas_simd_scalar_two_reg_misc':
>> /tmp/qemu-test/src/target/arm/translate-a64.c:8119: warning: 'rmode' may
>> be used uninitialized in this function
>>   GEN     trace/generated-helpers.c
>>   CC      aarch64-softmmu/trace/control-target.o
>>   CC      aarch64-softmmu/gdbstub-xml.o
>>   CC      aarch64-softmmu/trace/generated-helpers.o
>>   LINK    aarch64-softmmu/qemu-system-aarch64
>> mkdir -p dtc/libfdt
>> mkdir -p dtc/tests
>>   TEST    tests/qapi-schema/alternate-any.out
>>   TEST    tests/qapi-schema/alternate-clash.out
>>   TEST    tests/qapi-schema/alternate-base.out
>>   TEST    tests/qapi-schema/alternate-array.out
>>   TEST    tests/qapi-schema/alternate-conflict-dict.out
>>   TEST    tests/qapi-schema/alternate-conflict-enum-bool.out
>>   TEST    tests/qapi-schema/alternate-conflict-enum-int.out
>>   TEST    tests/qapi-schema/alternate-conflict-string.out
>>   TEST    tests/qapi-schema/alternate-conflict-bool-string.out
>>   TEST    tests/qapi-schema/alternate-conflict-num-string.out
>>   TEST    tests/qapi-schema/alternate-empty.out
>>   TEST    tests/qapi-schema/alternate-nested.out
>>   TEST    tests/qapi-schema/alternate-unknown.out
>>   TEST    tests/qapi-schema/args-alternate.out
>>   TEST    tests/qapi-schema/args-any.out
>>   TEST    tests/qapi-schema/args-array-empty.out
>>   TEST    tests/qapi-schema/args-array-unknown.out
>>   TEST    tests/qapi-schema/args-bad-boxed.out
>>   TEST    tests/qapi-schema/args-boxed-anon.out
>>   TEST    tests/qapi-schema/args-boxed-empty.out
>>   TEST    tests/qapi-schema/args-boxed-string.out
>>   TEST    tests/qapi-schema/args-int.out
>>   TEST    tests/qapi-schema/args-invalid.out
>>   TEST    tests/qapi-schema/args-member-array-bad.out
>>   TEST    tests/qapi-schema/args-member-case.out
>>   TEST    tests/qapi-schema/args-member-unknown.out
>>   TEST    tests/qapi-schema/args-name-clash.out
>>   TEST    tests/qapi-schema/args-union.out
>>   TEST    tests/qapi-schema/args-unknown.out
>>   TEST    tests/qapi-schema/bad-data.out
>>   TEST    tests/qapi-schema/bad-base.out
>>   TEST    tests/qapi-schema/bad-type-bool.out
>>   TEST    tests/qapi-schema/bad-ident.out
>>   TEST    tests/qapi-schema/bad-type-dict.out
>>   TEST    tests/qapi-schema/bad-type-int.out
>>   TEST    tests/qapi-schema/base-cycle-direct.out
>>   TEST    tests/qapi-schema/base-cycle-indirect.out
>>   TEST    tests/qapi-schema/command-int.out
>>   TEST    tests/qapi-schema/comments.out
>>   TEST    tests/qapi-schema/doc-bad-alternate-member.out
>>   TEST    tests/qapi-schema/doc-bad-command-arg.out
>>   TEST    tests/qapi-schema/doc-bad-symbol.out
>>   TEST    tests/qapi-schema/doc-bad-union-member.out
>>   TEST    tests/qapi-schema/doc-before-include.out
>>   TEST    tests/qapi-schema/doc-before-pragma.out
>>   TEST    tests/qapi-schema/doc-duplicated-arg.out
>>   TEST    tests/qapi-schema/doc-duplicated-return.out
>>   TEST    tests/qapi-schema/doc-duplicated-since.out
>>   TEST    tests/qapi-schema/doc-empty-section.out
>>   TEST    tests/qapi-schema/doc-empty-arg.out
>>   TEST    tests/qapi-schema/doc-empty-symbol.out
>>   TEST    tests/qapi-schema/doc-good.out
>>   TEST    tests/qapi-schema/doc-interleaved-section.out
>>   TEST    tests/qapi-schema/doc-invalid-end.out
>>   TEST    tests/qapi-schema/doc-invalid-end2.out
>>   TEST    tests/qapi-schema/doc-invalid-return.out
>>   TEST    tests/qapi-schema/doc-invalid-section.out
>>   TEST    tests/qapi-schema/doc-invalid-start.out
>>   TEST    tests/qapi-schema/doc-missing.out
>>   TEST    tests/qapi-schema/doc-missing-colon.out
>>   TEST    tests/qapi-schema/doc-missing-expr.out
>>   TEST    tests/qapi-schema/doc-missing-space.out
>>   TEST    tests/qapi-schema/doc-no-symbol.out
>>   TEST    tests/qapi-schema/double-data.out
>>   TEST    tests/qapi-schema/double-type.out
>>   TEST    tests/qapi-schema/duplicate-key.out
>>   TEST    tests/qapi-schema/empty.out
>>   TEST    tests/qapi-schema/enum-bad-name.out
>>   TEST    tests/qapi-schema/enum-bad-prefix.out
>>   TEST    tests/qapi-schema/enum-clash-member.out
>>   TEST    tests/qapi-schema/enum-dict-member.out
>>   TEST    tests/qapi-schema/enum-int-member.out
>>   TEST    tests/qapi-schema/enum-member-case.out
>>   TEST    tests/qapi-schema/enum-missing-data.out
>>   TEST    tests/qapi-schema/enum-wrong-data.out
>>   TEST    tests/qapi-schema/escape-too-big.out
>>   TEST    tests/qapi-schema/escape-outside-string.out
>>   TEST    tests/qapi-schema/escape-too-short.out
>>   TEST    tests/qapi-schema/event-boxed-empty.out
>>   TEST    tests/qapi-schema/event-case.out
>>   TEST    tests/qapi-schema/event-nest-struct.out
>>   TEST    tests/qapi-schema/flat-union-array-branch.out
>>   TEST    tests/qapi-schema/flat-union-bad-base.out
>>   TEST    tests/qapi-schema/flat-union-bad-discriminator.out
>>   TEST    tests/qapi-schema/flat-union-base-any.out
>>   TEST    tests/qapi-schema/flat-union-base-union.out
>>   TEST    tests/qapi-schema/flat-union-clash-member.out
>>   TEST    tests/qapi-schema/flat-union-empty.out
>>   TEST    tests/qapi-schema/flat-union-incomplete-branch.out
>>   TEST    tests/qapi-schema/flat-union-inline.out
>>   TEST    tests/qapi-schema/flat-union-int-branch.out
>>   TEST    tests/qapi-schema/flat-union-invalid-branch-key.out
>>   TEST    tests/qapi-schema/flat-union-invalid-discriminator.out
>>   TEST    tests/qapi-schema/flat-union-no-base.out
>>   TEST    tests/qapi-schema/flat-union-optional-discriminator.out
>>   TEST    tests/qapi-schema/flat-union-string-discriminator.out
>>   TEST    tests/qapi-schema/funny-char.out
>>   TEST    tests/qapi-schema/ident-with-escape.out
>>   TEST    tests/qapi-schema/include-cycle.out
>>   TEST    tests/qapi-schema/include-before-err.out
>>   TEST    tests/qapi-schema/include-extra-junk.out
>>   TEST    tests/qapi-schema/include-format-err.out
>>   TEST    tests/qapi-schema/include-nested-err.out
>>   TEST    tests/qapi-schema/include-no-file.out
>>   TEST    tests/qapi-schema/include-non-file.out
>>   TEST    tests/qapi-schema/include-relpath.out
>>   TEST    tests/qapi-schema/include-repetition.out
>>   TEST    tests/qapi-schema/include-self-cycle.out
>>   TEST    tests/qapi-schema/include-simple.out
>>   TEST    tests/qapi-schema/indented-expr.out
>>   TEST    tests/qapi-schema/leading-comma-list.out
>>   TEST    tests/qapi-schema/missing-colon.out
>>   TEST    tests/qapi-schema/leading-comma-object.out
>>   TEST    tests/qapi-schema/missing-comma-list.out
>>   TEST    tests/qapi-schema/missing-comma-object.out
>>   TEST    tests/qapi-schema/missing-type.out
>>   TEST    tests/qapi-schema/nested-struct-data.out
>>   TEST    tests/qapi-schema/non-objects.out
>>   TEST    tests/qapi-schema/pragma-doc-required-crap.out
>>   TEST    tests/qapi-schema/pragma-name-case-whitelist-crap.out
>>   TEST    tests/qapi-schema/pragma-extra-junk.out
>>   TEST    tests/qapi-schema/pragma-non-dict.out
>>   TEST    tests/qapi-schema/pragma-returns-whitelist-crap.out
>>   TEST    tests/qapi-schema/qapi-schema-test.out
>>   TEST    tests/qapi-schema/quoted-structural-chars.out
>>   TEST    tests/qapi-schema/redefined-builtin.out
>>   TEST    tests/qapi-schema/redefined-command.out
>>   TEST    tests/qapi-schema/redefined-event.out
>>   TEST    tests/qapi-schema/redefined-type.out
>>   TEST    tests/qapi-schema/reserved-command-q.out
>>   TEST    tests/qapi-schema/reserved-enum-q.out
>>   TEST    tests/qapi-schema/reserved-member-has.out
>>   TEST    tests/qapi-schema/reserved-member-q.out
>>   TEST    tests/qapi-schema/reserved-member-u.out
>>   TEST    tests/qapi-schema/reserved-member-underscore.out
>>   TEST    tests/qapi-schema/reserved-type-kind.out
>>   TEST    tests/qapi-schema/reserved-type-list.out
>>   TEST    tests/qapi-schema/returns-alternate.out
>>   TEST    tests/qapi-schema/returns-array-bad.out
>>   TEST    tests/qapi-schema/returns-dict.out
>>   TEST    tests/qapi-schema/returns-unknown.out
>>   TEST    tests/qapi-schema/returns-whitelist.out
>>   TEST    tests/qapi-schema/struct-base-clash-deep.out
>>   TEST    tests/qapi-schema/struct-base-clash.out
>>   TEST    tests/qapi-schema/struct-data-invalid.out
>>   TEST    tests/qapi-schema/struct-member-invalid.out
>>   TEST    tests/qapi-schema/trailing-comma-list.out
>>   TEST    tests/qapi-schema/trailing-comma-object.out
>>   TEST    tests/qapi-schema/type-bypass-bad-gen.out
>>   TEST    tests/qapi-schema/unclosed-list.out
>>   TEST    tests/qapi-schema/unclosed-object.out
>>   TEST    tests/qapi-schema/unclosed-string.out
>>   TEST    tests/qapi-schema/unicode-str.out
>>   TEST    tests/qapi-schema/union-base-empty.out
>>   TEST    tests/qapi-schema/union-base-no-discriminator.out
>>   TEST    tests/qapi-schema/union-branch-case.out
>>   TEST    tests/qapi-schema/union-clash-branches.out
>>   TEST    tests/qapi-schema/union-empty.out
>>   TEST    tests/qapi-schema/union-invalid-base.out
>>   TEST    tests/qapi-schema/union-optional-branch.out
>>   TEST    tests/qapi-schema/union-unknown.out
>>   TEST    tests/qapi-schema/unknown-escape.out
>>   TEST    tests/qapi-schema/unknown-expr-key.out
>>   GEN     tests/qapi-schema/doc-good.test.texi
>>   CC      tests/check-qdict.o
>>   CC      tests/test-char.o
>>   CC      tests/check-qnum.o
>>   CC      tests/check-qstring.o
>>   CC      tests/check-qlist.o
>>   CC      tests/check-qnull.o
>>   CC      tests/check-qobject.o
>>   CC      tests/check-qjson.o
>>   CC      tests/check-qlit.o
>>   CC      tests/test-qobject-output-visitor.o
>>   GEN     tests/test-qapi-visit.c
>>   GEN     tests/test-qapi-types.c
>>   GEN     tests/test-qapi-event.c
>>   GEN     tests/test-qmp-introspect.c
>>   CC      tests/test-clone-visitor.o
>>   CC      tests/test-qobject-input-visitor.o
>>   CC      tests/test-qmp-commands.o
>>   GEN     tests/test-qmp-marshal.c
>>   CC      tests/test-string-input-visitor.o
>>   CC      tests/test-string-output-visitor.o
>>   CC      tests/test-qmp-event.o
>>   CC      tests/test-opts-visitor.o
>>   CC      tests/test-coroutine.o
>>   CC      tests/iothread.o
>>   CC      tests/test-visitor-serialization.o
>>   CC      tests/test-iov.o
>>   CC      tests/test-aio.o
>>   CC      tests/test-aio-multithread.o
>>   CC      tests/test-throttle.o
>>   CC      tests/test-thread-pool.o
>>   CC      tests/test-blockjob.o
>>   CC      tests/test-hbitmap.o
>>   CC      tests/test-blockjob-txn.o
>>   CC      tests/test-x86-cpuid.o
>>   CC      tests/test-xbzrle.o
>>   CC      tests/test-vmstate.o
>>   CC      tests/test-shift128.o
>>   CC      tests/test-cutils.o
>>   CC      tests/test-mul64.o
>>   CC      tests/test-int128.o
>>   CC      tests/rcutorture.o
>>   CC      tests/test-rcu-list.o
>>   CC      tests/test-qdist.o
>>   CC      tests/test-qht.o
>>   CC      tests/test-qht-par.o
>> /tmp/qemu-test/src/tests/test-int128.c:180: warning: '__noclone__'
>> attribute directive ignored
>>   CC      tests/qht-bench.o
>>   CC      tests/test-bitops.o
>>   CC      tests/test-bitcnt.o
>>   CC      tests/check-qom-interface.o
>>   CC      tests/test-qemu-opts.o
>>   CC      tests/check-qom-proplist.o
>>   CC      tests/test-keyval.o
>>   CC      tests/test-write-threshold.o
>>   CC      tests/test-crypto-hash.o
>>   CC      tests/test-crypto-hmac.o
>>   CC      tests/test-crypto-cipher.o
>>   CC      tests/test-crypto-secret.o
>>   CC      tests/test-qga.o
>>   CC      tests/libqtest.o
>>   CC      tests/test-timed-average.o
>>   CC      tests/test-io-task.o
>>   CC      tests/test-io-channel-socket.o
>>   CC      tests/io-channel-helpers.o
>>   CC      tests/test-io-channel-file.o
>>   CC      tests/test-io-channel-buffer.o
>>   CC      tests/test-io-channel-command.o
>>   CC      tests/test-base64.o
>>   CC      tests/test-crypto-ivgen.o
>>   CC      tests/test-crypto-afsplit.o
>>   CC      tests/test-crypto-xts.o
>>   CC      tests/test-crypto-block.o
>>   CC      tests/test-logging.o
>>   CC      tests/test-replication.o
>>   CC      tests/test-uuid.o
>>   CC      tests/test-bufferiszero.o
>>   CC      tests/ptimer-test.o
>>   CC      tests/ptimer-test-stubs.o
>>   CC      tests/test-qapi-util.o
>>   CC      tests/vhost-user-test.o
>>   CC      tests/libqos/fw_cfg.o
>>   CC      tests/libqos/pci.o
>>   CC      tests/libqos/malloc.o
>>   CC      tests/libqos/libqos.o
>>   CC      tests/libqos/i2c.o
>>   CC      tests/libqos/malloc-spapr.o
>>   CC      tests/libqos/libqos-spapr.o
>>   CC      tests/libqos/rtas.o
>>   CC      tests/libqos/pci-spapr.o
>>   CC      tests/libqos/pci-pc.o
>>   CC      tests/libqos/malloc-pc.o
>>   CC      tests/libqos/libqos-pc.o
>>   CC      tests/libqos/ahci.o
>>   CC      tests/libqos/virtio.o
>>   CC      tests/libqos/virtio-pci.o
>>   CC      tests/libqos/virtio-mmio.o
>>   CC      tests/libqos/malloc-generic.o
>>   CC      tests/endianness-test.o
>>   CC      tests/fdc-test.o
>>   CC      tests/ide-test.o
>>   CC      tests/ahci-test.o
>>   CC      tests/hd-geo-test.o
>>   CC      tests/boot-order-test.o
>>   CC      tests/bios-tables-test.o
>>   CC      tests/boot-sector.o
>>   CC      tests/acpi-utils.o
>>   CC      tests/rtc-test.o
>>   CC      tests/boot-serial-test.o
>>   CC      tests/pxe-test.o
>>   CC      tests/ipmi-kcs-test.o
>>   CC      tests/ipmi-bt-test.o
>>   CC      tests/i440fx-test.o
>>   CC      tests/fw_cfg-test.o
>>   CC      tests/drive_del-test.o
>>   CC      tests/wdt_ib700-test.o
>>   CC      tests/tco-test.o
>>   CC      tests/e1000-test.o
>>   CC      tests/e1000e-test.o
>>   CC      tests/rtl8139-test.o
>>   CC      tests/pcnet-test.o
>>   CC      tests/eepro100-test.o
>>   CC      tests/ne2000-test.o
>>   CC      tests/nvme-test.o
>>   CC      tests/ac97-test.o
>>   CC      tests/es1370-test.o
>>   CC      tests/virtio-net-test.o
>>   CC      tests/virtio-balloon-test.o
>>   CC      tests/virtio-rng-test.o
>>   CC      tests/virtio-scsi-test.o
>>   CC      tests/virtio-blk-test.o
>>   CC      tests/virtio-serial-test.o
>>   CC      tests/virtio-console-test.o
>>   CC      tests/tpci200-test.o
>>   CC      tests/ipoctal232-test.o
>>   CC      tests/display-vga-test.o
>>   CC      tests/intel-hda-test.o
>>   CC      tests/ivshmem-test.o
>>   CC      tests/megasas-test.o
>>   CC      tests/vmxnet3-test.o
>>   CC      tests/pvpanic-test.o
>>   CC      tests/i82801b11-test.o
>>   CC      tests/ioh3420-test.o
>>   CC      tests/libqos/usb.o
>>   CC      tests/usb-hcd-ohci-test.o
>>   CC      tests/usb-hcd-uhci-test.o
>>   CC      tests/usb-hcd-xhci-test.o
>>   CC      tests/usb-hcd-ehci-test.o
>>   CC      tests/pc-cpu-test.o
>>   CC      tests/q35-test.o
>>   CC      tests/vmgenid-test.o
>>   CC      tests/test-netfilter.o
>>   CC      tests/test-filter-mirror.o
>>   CC      tests/test-filter-redirector.o
>>   CC      tests/migration-test.o
>>   CC      tests/test-x86-cpuid-compat.o
>>   CC      tests/numa-test.o
>>   CC      tests/qmp-test.o
>>   CC      tests/qom-test.o
>>   CC      tests/device-introspect-test.o
>>   CC      tests/test-hmp.o
>>   LINK    tests/check-qdict
>>   LINK    tests/test-char
>>   LINK    tests/check-qnum
>>   LINK    tests/check-qstring
>>   LINK    tests/check-qlist
>>   LINK    tests/check-qnull
>>   LINK    tests/check-qobject
>>   LINK    tests/check-qjson
>>   LINK    tests/check-qlit
>>   CC      tests/test-qapi-event.o
>>   CC      tests/test-qapi-types.o
>>   CC      tests/test-qmp-marshal.o
>>   CC      tests/test-qapi-visit.o
>>   CC      tests/test-qmp-introspect.o
>>   LINK    tests/test-coroutine
>>   LINK    tests/test-iov
>>   LINK    tests/test-aio
>>   LINK    tests/test-aio-multithread
>>   LINK    tests/test-throttle
>>   LINK    tests/test-thread-pool
>>   LINK    tests/test-hbitmap
>>   LINK    tests/test-blockjob
>>   LINK    tests/test-blockjob-txn
>>   LINK    tests/test-x86-cpuid
>>   LINK    tests/test-xbzrle
>>   LINK    tests/test-vmstate
>>   LINK    tests/test-cutils
>>   LINK    tests/test-shift128
>>   LINK    tests/test-mul64
>>   LINK    tests/test-int128
>>   LINK    tests/rcutorture
>>   LINK    tests/test-rcu-list
>>   LINK    tests/test-qdist
>>   LINK    tests/test-qht
>>   LINK    tests/qht-bench
>>   LINK    tests/test-bitops
>>   LINK    tests/test-bitcnt
>>   LINK    tests/check-qom-interface
>>   LINK    tests/check-qom-proplist
>>   LINK    tests/test-qemu-opts
>>   LINK    tests/test-keyval
>>   LINK    tests/test-write-threshold
>>   LINK    tests/test-crypto-hash
>>   LINK    tests/test-crypto-hmac
>>   LINK    tests/test-crypto-cipher
>>   LINK    tests/test-crypto-secret
>>   LINK    tests/test-qga
>>   LINK    tests/test-timed-average
>>   LINK    tests/test-io-task
>>   LINK    tests/test-io-channel-socket
>>   LINK    tests/test-io-channel-file
>>   LINK    tests/test-io-channel-command
>>   LINK    tests/test-io-channel-buffer
>>   LINK    tests/test-base64
>>   LINK    tests/test-crypto-ivgen
>>   LINK    tests/test-crypto-afsplit
>>   LINK    tests/test-crypto-xts
>>   LINK    tests/test-crypto-block
>>   LINK    tests/test-logging
>>   LINK    tests/test-replication
>>   LINK    tests/test-bufferiszero
>>   LINK    tests/test-uuid
>>   LINK    tests/ptimer-test
>>   LINK    tests/test-qapi-util
>>   LINK    tests/vhost-user-test
>>   LINK    tests/endianness-test
>>   LINK    tests/fdc-test
>>   LINK    tests/ide-test
>>   LINK    tests/ahci-test
>>   LINK    tests/hd-geo-test
>>   LINK    tests/boot-order-test
>>   LINK    tests/bios-tables-test
>>   LINK    tests/boot-serial-test
>>   LINK    tests/pxe-test
>>   LINK    tests/rtc-test
>>   LINK    tests/ipmi-kcs-test
>>   LINK    tests/ipmi-bt-test
>>   LINK    tests/i440fx-test
>>   LINK    tests/fw_cfg-test
>>   LINK    tests/drive_del-test
>>   LINK    tests/wdt_ib700-test
>>   LINK    tests/tco-test
>>   LINK    tests/e1000-test
>>   LINK    tests/e1000e-test
>>   LINK    tests/rtl8139-test
>>   LINK    tests/pcnet-test
>>   LINK    tests/eepro100-test
>>   LINK    tests/ne2000-test
>>   LINK    tests/nvme-test
>>   LINK    tests/ac97-test
>>   LINK    tests/es1370-test
>>   LINK    tests/virtio-net-test
>>   LINK    tests/virtio-balloon-test
>>   LINK    tests/virtio-blk-test
>>   LINK    tests/virtio-rng-test
>>   LINK    tests/virtio-scsi-test
>>   LINK    tests/virtio-serial-test
>>   LINK    tests/virtio-console-test
>>   LINK    tests/tpci200-test
>>   LINK    tests/ipoctal232-test
>>   LINK    tests/display-vga-test
>>   LINK    tests/intel-hda-test
>>   LINK    tests/ivshmem-test
>>   LINK    tests/megasas-test
>>   LINK    tests/vmxnet3-test
>>   LINK    tests/pvpanic-test
>>   LINK    tests/i82801b11-test
>>   LINK    tests/ioh3420-test
>>   LINK    tests/usb-hcd-ohci-test
>>   LINK    tests/usb-hcd-uhci-test
>>   LINK    tests/usb-hcd-ehci-test
>>   LINK    tests/usb-hcd-xhci-test
>>   LINK    tests/pc-cpu-test
>>   LINK    tests/q35-test
>>   LINK    tests/vmgenid-test
>>   LINK    tests/test-netfilter
>>   LINK    tests/test-filter-mirror
>>   LINK    tests/test-filter-redirector
>>   LINK    tests/migration-test
>>   LINK    tests/test-x86-cpuid-compat
>>   LINK    tests/numa-test
>>   LINK    tests/qmp-test
>>   LINK    tests/device-introspect-test
>>   LINK    tests/qom-test
>>   LINK    tests/test-hmp
>>   GTESTER tests/check-qdict
>>   GTESTER tests/check-qnum
>>   GTESTER tests/test-char
>>   GTESTER tests/check-qstring
>>   GTESTER tests/check-qlist
>>   GTESTER tests/check-qnull
>>   GTESTER tests/check-qobject
>>   GTESTER tests/check-qjson
>>   GTESTER tests/check-qlit
>>   LINK    tests/test-qobject-output-visitor
>>   LINK    tests/test-clone-visitor
>>   LINK    tests/test-qobject-input-visitor
>>   LINK    tests/test-qmp-commands
>>   LINK    tests/test-string-input-visitor
>>   LINK    tests/test-string-output-visitor
>>   LINK    tests/test-qmp-event
>>   GTESTER tests/test-coroutine
>>   LINK    tests/test-opts-visitor
>>   LINK    tests/test-visitor-serialization
>>   GTESTER tests/test-iov
>>   GTESTER tests/test-aio
>>   GTESTER tests/test-aio-multithread
>>   GTESTER tests/test-throttle
>>   GTESTER tests/test-thread-pool
>>   GTESTER tests/test-blockjob
>>   GTESTER tests/test-hbitmap
>>   GTESTER tests/test-blockjob-txn
>>   GTESTER tests/test-x86-cpuid
>>   GTESTER tests/test-xbzrle
>>   GTESTER tests/test-vmstate
>>   GTESTER tests/test-cutils
>> Failed to load simple/primitive:b_1
>> Failed to load simple/primitive:i64_2
>> Failed to load simple/primitive:i32_1
>> Failed to load simple/primitive:i32_1
>> Failed to load test/with_tmp:a
>> Failed to load test/tmp_child_parent:f
>> Failed to load test/tmp_child:parent
>> Failed to load test/with_tmp:tmp
>> Failed to load test/tmp_child:diff
>> Failed to load test/with_tmp:tmp
>> Failed to load test/tmp_child:diff
>> Failed to load test/with_tmp:tmp
>>   GTESTER tests/test-shift128
>>   GTESTER tests/test-mul64
>>   GTESTER tests/test-int128
>>   GTESTER tests/rcutorture
>>   GTESTER tests/test-rcu-list
>>   GTESTER tests/test-qdist
>>   GTESTER tests/test-qht
>>   LINK    tests/test-qht-par
>>   GTESTER tests/test-bitops
>>   GTESTER tests/test-bitcnt
>>   GTESTER tests/check-qom-interface
>>   GTESTER tests/check-qom-proplist
>>   GTESTER tests/test-qemu-opts
>>   GTESTER tests/test-keyval
>>   GTESTER tests/test-write-threshold
>>   GTESTER tests/test-crypto-hash
>>   GTESTER tests/test-crypto-hmac
>>   GTESTER tests/test-crypto-cipher
>>   GTESTER tests/test-crypto-secret
>>   GTESTER tests/test-qga
>>   GTESTER tests/test-timed-average
>>   GTESTER tests/test-io-task
>>   GTESTER tests/test-io-channel-socket
>>   GTESTER tests/test-io-channel-file
>>   GTESTER tests/test-io-channel-command
>>   GTESTER tests/test-io-channel-buffer
>>   GTESTER tests/test-base64
>>   GTESTER tests/test-crypto-ivgen
>>   GTESTER tests/test-crypto-afsplit
>>   GTESTER tests/test-crypto-xts
>>   GTESTER tests/test-crypto-block
>>   GTESTER tests/test-logging
>>   GTESTER tests/test-replication
>>   GTESTER tests/test-bufferiszero
>>   GTESTER tests/test-uuid
>>   GTESTER tests/ptimer-test
>>   GTESTER tests/test-qapi-util
>>   GTESTER check-qtest-x86_64
>>   GTESTER check-qtest-aarch64
>>   GTESTER tests/test-qobject-output-visitor
>>   GTESTER tests/test-clone-visitor
>>   GTESTER tests/test-qobject-input-visitor
>>   GTESTER tests/test-qmp-commands
>>   GTESTER tests/test-string-input-visitor
>>   GTESTER tests/test-string-output-visitor
>>   GTESTER tests/test-qmp-event
>>   GTESTER tests/test-opts-visitor
>>   GTESTER tests/test-visitor-serialization
>>   GTESTER tests/test-qht-par
>> Could not access KVM kernel module: No such file or directory
>> qemu-system-x86_64: failed to initialize KVM: No such file or directory
>> qemu-system-x86_64: Back to tcg accelerator
>> Could not access KVM kernel module: No such file or directory
>> qemu-system-x86_64: failed to initialize KVM: No such file or directory
>> qemu-system-x86_64: Back to tcg accelerator
>> Could not access KVM kernel module: No such file or directory
>> qemu-system-x86_64: failed to initialize KVM: No such file or directory
>> qemu-system-x86_64: Back to tcg accelerator
>> Could not access KVM kernel module: No such file or directory
>> qemu-system-x86_64: failed to initialize KVM: No such file or directory
>> qemu-system-x86_64: Back to tcg accelerator
>> Could not access KVM kernel module: No such file or directory
>> qemu-system-x86_64: failed to initialize KVM: No such file or directory
>> qemu-system-x86_64: Back to tcg accelerator
>> Could not access KVM kernel module: No such file or directory
>> qemu-system-x86_64: failed to initialize KVM: No such file or directory
>> qemu-system-x86_64: Back to tcg accelerator
>> Could not access KVM kernel module: No such file or directory
>> qemu-system-x86_64: failed to initialize KVM: No such file or directory
>> qemu-system-x86_64: Back to tcg accelerator
>> Could not access KVM kernel module: No such file or directory
>> qemu-system-x86_64: failed to initialize KVM: No such file or directory
>> qemu-system-x86_64: Back to tcg accelerator
>> Could not access KVM kernel module: No such file or directory
>> qemu-system-x86_64: failed to initialize KVM: No such file or directory
>> qemu-system-x86_64: Back to tcg accelerator
>> Could not access KVM kernel module: No such file or directory
>> qemu-system-x86_64: failed to initialize KVM: No such file or directory
>> qemu-system-x86_64: Back to tcg accelerator
>> Could not access KVM kernel module: No such file or directory
>> qemu-system-x86_64: failed to initialize KVM: No such file or directory
>> qemu-system-x86_64: Back to tcg accelerator
>> Could not access KVM kernel module: No such file or directory
>> qemu-system-x86_64: failed to initialize KVM: No such file or directory
>> qemu-system-x86_64: Back to tcg accelerator
>> Could not access KVM kernel module: No such file or directory
>> qemu-system-x86_64: failed to initialize KVM: No such file or directory
>> qemu-system-x86_64: Back to tcg accelerator
>> Could not access KVM kernel module: No such file or directory
>> qemu-system-x86_64: failed to initialize KVM: No such file or directory
>> qemu-system-x86_64: Back to tcg accelerator
>> Could not access KVM kernel module: No such file or directory
>> qemu-system-x86_64: failed to initialize KVM: No such file or directory
>> qemu-system-x86_64: Back to tcg accelerator
>> Could not access KVM kernel module: No such file or directory
>> qemu-system-x86_64: failed to initialize KVM: No such file or directory
>> qemu-system-x86_64: Back to tcg accelerator
>> Could not access KVM kernel module: No such file or directory
>> qemu-system-x86_64: failed to initialize KVM: No such file or directory
>> qemu-system-x86_64: Back to tcg accelerator
>> mkdir -p dtc/libfdt
>> mkdir -p dtc/tests
>> install -d -m 0755
>> "/tmp/qemu-test/build/=3Ddestdir/tmp/qemu-test/install/share/qemu"
>> install -d -m 0755
>> "/tmp/qemu-test/build/=3Ddestdir/tmp/qemu-test/install/var"/run
>> install -d -m 0755
>> "/tmp/qemu-test/build/=3Ddestdir/tmp/qemu-test/install/bin"
>> install -c -m 0755 qemu-ga ivshmem-client ivshmem-server qemu-nbd qemu-i=
mg
>> qemu-io  scsi/qemu-pr-helper
>> "/tmp/qemu-test/build/=3Ddestdir/tmp/qemu-test/install/bin"
>> strip "/tmp/qemu-test/build/=3Ddestdir/tmp/qemu-test/install/bin/qemu-ga=
"
>> "/tmp/qemu-test/build/=3Ddestdir/tmp/qemu-test/install/bin/ivshmem-clien=
t"
>> "/tmp/qemu-test/build/=3Ddestdir/tmp/qemu-test/install/bin/ivshmem-serve=
r"
>> "/tmp/qemu-test/build/=3Ddestdir/tmp/qemu-test/install/bin/qemu-nbd"
>> "/tmp/qemu-test/build/=3Ddestdir/tmp/qemu-test/install/bin/qemu-img"
>> "/tmp/qemu-test/build/=3Ddestdir/tmp/qemu-test/install/bin/qemu-io"
>> "/tmp/qemu-test/build/=3Ddestdir/tmp/qemu-test/install/bin/qemu-pr-helpe=
r"
>> install -d -m 0755
>> "/tmp/qemu-test/build/=3Ddestdir/tmp/qemu-test/install/libexec"
>> install -c -m 0755 qemu-bridge-helper
>> "/tmp/qemu-test/build/=3Ddestdir/tmp/qemu-test/install/libexec"
>> strip
>> "/tmp/qemu-test/build/=3Ddestdir/tmp/qemu-test/install/libexec/qemu-brid=
ge-helper"
>> set -e; for x in bios.bin bios-256k.bin sgabios.bin vgabios.bin
>> vgabios-cirrus.bin vgabios-stdvga.bin vgabios-vmware.bin vgabios-qxl.bin
>> vgabios-virtio.bin acpi-dsdt.aml ppc_rom.bin openbios-sparc32
>> openbios-sparc64 openbios-ppc QEMU,tcx.bin QEMU,cgthree.bin pxe-e1000.ro=
m
>> pxe-eepro100.rom pxe-ne2k_pci.rom pxe-pcnet.rom pxe-rtl8139.rom
>> pxe-virtio.rom efi-e1000.rom efi-eepro100.rom efi-ne2k_pci.rom efi-pcnet=
.rom
>> efi-rtl8139.rom efi-virtio.rom efi-e1000e.rom efi-vmxnet3.rom qemu-icon.=
bmp
>> qemu_logo_no_text.svg bamboo.dtb petalogix-s3adsp1800.dtb
>> petalogix-ml605.dtb multiboot.bin linuxboot.bin linuxboot_dma.bin
>> kvmvapic.bin s390-ccw.img s390-netboot.img spapr-rtas.bin slof.bin
>> skiboot.lid palcode-clipper u-boot.e500 qemu_vga.ndrv; do \
>>                 install -c -m 0644 /tmp/qemu-test/src/pc-bios/$x
>> "/tmp/qemu-test/build/=3Ddestdir/tmp/qemu-test/install/share/qemu"; \
>>         done
>> make -C po install
>> make[1]: Entering directory `/tmp/qemu-test/build/po'
>>   GEN     /tmp/qemu-test/src/po/messages.po
>>   GEN     /tmp/qemu-test/src/po/bg.po
>>   GEN     /tmp/qemu-test/src/po/de_DE.po
>>   GEN     /tmp/qemu-test/src/po/hu.po
>>   GEN     /tmp/qemu-test/src/po/fr_FR.po
>>   GEN     /tmp/qemu-test/src/po/zh_CN.po
>>   GEN     /tmp/qemu-test/src/po/it.po
>>   GEN     /tmp/qemu-test/src/po/tr.po
>>   GEN     tr.mo
>>   GEN     zh_CN.mo
>>   GEN     hu.mo
>>   GEN     bg.mo
>>   GEN     de_DE.mo
>>   GEN     fr_FR.mo
>>   GEN     it.mo
>> for obj in bg.mo de_DE.mo fr_FR.mo hu.mo it.mo tr.mo zh_CN.mo; do \
>>             base=3D`basename $obj .mo`; \
>>             install -d
>> /tmp/qemu-test/build/=3Ddestdir/tmp/qemu-test/install/share/locale/$base=
/LC_MESSAGES;
>> \
>>             install -m644 $obj
>> /tmp/qemu-test/build/=3Ddestdir/tmp/qemu-test/install/share/locale/$base=
/LC_MESSAGES/qemu.mo;
>> \
>>         done
>> make[1]: Leaving directory `/tmp/qemu-test/build/po'
>> install -d -m 0755
>> "/tmp/qemu-test/build/=3Ddestdir/tmp/qemu-test/install/share/qemu/keymap=
s"
>> set -e; for x in da     en-gb  et  fr     fr-ch  is  lt  modifiers  no
>> pt-br  sv ar      de     en-us  fi  fr-be  hr     it  lv  nl         pl =
 ru
>> th common  de-ch  es     fo  fr-ca  hu     ja  mk  nl-be      pt  sl    =
 tr
>> bepo    cz; do \
>>                 install -c -m 0644 /tmp/qemu-test/src/pc-bios/keymaps/$x
>> "/tmp/qemu-test/build/=3Ddestdir/tmp/qemu-test/install/share/qemu/keymap=
s"; \
>>         done
>> install -c -m 0644 /tmp/qemu-test/build/trace-events-all
>> "/tmp/qemu-test/build/=3Ddestdir/tmp/qemu-test/install/share/qemu/trace-=
events-all"
>> for d in x86_64-softmmu aarch64-softmmu; do \
>>         make --no-print-directory BUILD_DIR=3D/tmp/qemu-test/build
>> TARGET_DIR=3D$d/ -C $d install || exit 1 ; \
>>         done
>> install -d -m 0755
>> "/tmp/qemu-test/build/=3Ddestdir/tmp/qemu-test/install/bin"
>> install -c -m 0755 qemu-system-x86_64
>> "/tmp/qemu-test/build/=3Ddestdir/tmp/qemu-test/install/bin"
>> strip
>> "/tmp/qemu-test/build/=3Ddestdir/tmp/qemu-test/install/bin/qemu-system-x=
86_64"
>> install -d -m 0755
>> "/tmp/qemu-test/build/=3Ddestdir/tmp/qemu-test/install/bin"
>> install -c -m 0755 qemu-system-aarch64
>> "/tmp/qemu-test/build/=3Ddestdir/tmp/qemu-test/install/bin"
>> strip
>> "/tmp/qemu-test/build/=3Ddestdir/tmp/qemu-test/install/bin/qemu-system-a=
arch64"
>>     CLEANUP
>> /var/tmp/patchew-tester-tmp-gmdmoybf/src/docker-src.2017-11-21-16.55.33.=
22004
>> make[1]: Leaving directory '/var/tmp/patchew-tester-tmp-gmdmoybf/src'
>>
>> real    8m3.325s
>> user    0m4.464s
>> sys     0m4.722s
>>   BUILD   min-glib
>> make[1]: Entering directory '/var/tmp/patchew-tester-tmp-gmdmoybf/src'
>>   GEN
>> /var/tmp/patchew-tester-tmp-gmdmoybf/src/docker-src.2017-11-21-17.03.29.=
1957/qemu.tar
>> Cloning into
>> '/var/tmp/patchew-tester-tmp-gmdmoybf/src/docker-src.2017-11-21-17.03.29=
.1957/qemu.tar.vroot'...
>> done.
>> Checking out files:  49% (2818/5662)
>> Checking out files:  50% (2831/5662)
>> Checking out files:  51% (2888/5662)
>> Checking out files:  52% (2945/5662)
>> Checking out files:  53% (3001/5662)
>> Checking out files:  54% (3058/5662)
>> Checking out files:  55% (3115/5662)
>> Checking out files:  56% (3171/5662)
>> Checking out files:  57% (3228/5662)
>> Checking out files:  58% (3284/5662)
>> Checking out files:  58% (3333/5662)
>> Checking out files:  59% (3341/5662)
>> Checking out files:  60% (3398/5662)
>> Checking out files:  61% (3454/5662)
>> Checking out files:  62% (3511/5662)
>> Checking out files:  63% (3568/5662)
>> Checking out files:  64% (3624/5662)
>> Checking out files:  65% (3681/5662)
>> Checking out files:  66% (3737/5662)
>> Checking out files:  67% (3794/5662)
>> Checking out files:  68% (3851/5662)
>> Checking out files:  69% (3907/5662)
>> Checking out files:  70% (3964/5662)
>> Checking out files:  71% (4021/5662)
>> Checking out files:  72% (4077/5662)
>> Checking out files:  73% (4134/5662)
>> Checking out files:  74% (4190/5662)
>> Checking out files:  75% (4247/5662)
>> Checking out files:  76% (4304/5662)
>> Checking out files:  77% (4360/5662)
>> Checking out files:  78% (4417/5662)
>> Checking out files:  79% (4473/5662)
>> Checking out files:  80% (4530/5662)
>> Checking out files:  81% (4587/5662)
>> Checking out files:  82% (4643/5662)
>> Checking out files:  83% (4700/5662)
>> Checking out files:  84% (4757/5662)
>> Checking out files:  85% (4813/5662)
>> Checking out files:  86% (4870/5662)
>> Checking out files:  87% (4926/5662)
>> Checking out files:  88% (4983/5662)
>> Checking out files:  89% (5040/5662)
>> Checking out files:  90% (5096/5662)
>> Checking out files:  91% (5153/5662)
>> Checking out files:  92% (5210/5662)
>> Checking out files:  93% (5266/5662)
>> Checking out files:  94% (5323/5662)
>> Checking out files:  95% (5379/5662)
>> Checking out files:  96% (5436/5662)
>> Checking out files:  97% (5493/5662)
>> Checking out files:  98% (5549/5662)
>> Checking out files:  99% (5606/5662)
>> Checking out files: 100% (5662/5662)
>> Checking out files: 100% (5662/5662), done.
>> Your branch is up-to-date with 'origin/test'.
>> Submodule 'dtc' (git://git.qemu-project.org/dtc.git) registered for path
>> 'dtc'
>> Cloning into
>> '/var/tmp/patchew-tester-tmp-gmdmoybf/src/docker-src.2017-11-21-17.03.29=
.1957/qemu.tar.vroot/dtc'...
>> Submodule path 'dtc': checked out
>> '558cd81bdd432769b59bff01240c44f82cfb1a9d'
>> Submodule 'ui/keycodemapdb' (git://git.qemu.org/keycodemapdb.git)
>> registered for path 'ui/keycodemapdb'
>> Cloning into
>> '/var/tmp/patchew-tester-tmp-gmdmoybf/src/docker-src.2017-11-21-17.03.29=
.1957/qemu.tar.vroot/ui/keycodemapdb'...
>> Submodule path 'ui/keycodemapdb': checked out
>> '10739aa26051a5d49d88132604539d3ed085e72e'
>>   COPY    RUNNER
>>     RUN test-build in qemu:min-glib
>> Environment variables:
>> HOSTNAME=3Df5e070c26c40
>> MAKEFLAGS=3D -j8
>> J=3D8
>> CCACHE_DIR=3D/var/tmp/ccache
>> EXTRA_CONFIGURE_OPTS=3D
>> V=3D
>> SHOW_ENV=3D1
>>
>> PATH=3D/usr/lib/ccache:/usr/lib64/ccache:/usr/local/sbin:/usr/local/bin:=
/usr/sbin:/usr/bin:/sbin:/bin
>> PWD=3D/
>> TARGET_LIST=3D
>> SHLVL=3D1
>> HOME=3D/root
>> TEST_DIR=3D/tmp/qemu-test
>> FEATURES=3D dtc
>> DEBUG=3D
>> _=3D/usr/bin/env
>>
>> Configure options:
>> --enable-werror --target-list=3Dx86_64-softmmu,aarch64-softmmu
>> --prefix=3D/tmp/qemu-test/install
>> No C++ compiler available; disabling C++ specific optional code
>> Install prefix    /tmp/qemu-test/install
>> BIOS directory    /tmp/qemu-test/install/share/qemu
>> firmware path     /tmp/qemu-test/install/share/qemu-firmware
>> binary directory  /tmp/qemu-test/install/bin
>> library directory /tmp/qemu-test/install/lib
>> module directory  /tmp/qemu-test/install/lib/qemu
>> libexec directory /tmp/qemu-test/install/libexec
>> include directory /tmp/qemu-test/install/include
>> config directory  /tmp/qemu-test/install/etc
>> local state directory   /tmp/qemu-test/install/var
>> Manual directory  /tmp/qemu-test/install/share/man
>> ELF interp prefix /usr/gnemul/qemu-%M
>> Source path       /tmp/qemu-test/src
>> GIT binary        git
>> GIT submodules
>> C compiler        cc
>> Host C compiler   cc
>> C++ compiler
>> Objective-C compiler cc
>> ARFLAGS           rv
>> CFLAGS            -O2 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=3D2 -g
>> QEMU_CFLAGS       -I/usr/include/pixman-1   -I$(SRC_PATH)/dtc/libfdt
>> -pthread -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include   -fPIE -=
DPIE
>> -m64 -mcx16 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE
>> -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings
>> -Wmissing-prototypes -fno-strict-aliasing -fno-common -fwrapv
>> -Wendif-labels -Wno-missing-include-dirs -Wempty-body -Wnested-externs
>> -Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers
>> -Wold-style-declaration -Wold-style-definition -Wtype-limits
>> -fstack-protector-all -Wno-missing-braces
>> LDFLAGS           -Wl,--warn-common -Wl,-z,relro -Wl,-z,now -pie -m64 -g
>> make              make
>> install           install
>> python            python -B
>> smbd              /usr/sbin/smbd
>> module support    no
>> host CPU          x86_64
>> host big endian   no
>> target list       x86_64-softmmu aarch64-softmmu
>> gprof enabled     no
>> sparse enabled    no
>> strip binaries    yes
>> profiler          no
>> static build      no
>> SDL support       yes (1.2.14)
>> GTK support       no
>> GTK GL support    no
>> VTE support       no
>> TLS priority      NORMAL
>> GNUTLS support    no
>> GNUTLS rnd        no
>> libgcrypt         no
>> libgcrypt kdf     no
>> nettle            no
>> nettle kdf        no
>> libtasn1          no
>> curses support    no
>> virgl support     no
>> curl support      no
>> mingw32 support   no
>> Audio drivers     oss
>> Block whitelist (rw)
>> Block whitelist (ro)
>> VirtFS support    no
>> Multipath support no
>> VNC support       yes
>> VNC SASL support  no
>> VNC JPEG support  no
>> VNC PNG support   no
>> xen support       no
>> brlapi support    no
>> bluez  support    no
>> Documentation     no
>> PIE               yes
>> vde support       no
>> netmap support    no
>> Linux AIO support no
>> ATTR/XATTR support yes
>> Install blobs     yes
>> KVM support       yes
>> HAX support       no
>> TCG support       yes
>> TCG debug enabled no
>> TCG interpreter   no
>> RDMA support      no
>> fdt support       yes
>> preadv support    yes
>> fdatasync         yes
>> madvise           yes
>> posix_madvise     yes
>> libcap-ng support no
>> vhost-net support yes
>> vhost-scsi support yes
>> vhost-vsock support yes
>> vhost-user support yes
>> Trace backends    log
>> spice support     no
>> rbd support       no
>> xfsctl support    no
>> smartcard support no
>> libusb            no
>> usb net redir     no
>> OpenGL support    no
>> OpenGL dmabufs    no
>> libiscsi support  no
>> libnfs support    no
>> build guest agent yes
>> QGA VSS support   no
>> QGA w32 disk info no
>> QGA MSI support   no
>> seccomp support   no
>> coroutine backend ucontext
>> coroutine pool    yes
>> debug stack usage no
>> crypto afalg      no
>> GlusterFS support no
>> gcov              gcov
>> gcov enabled      no
>> TPM support       yes
>> libssh2 support   no
>> TPM passthrough   yes
>> TPM emulator      yes
>> QOM debugging     yes
>> Live block migration yes
>> lzo support       no
>> snappy support    no
>> bzip2 support     no
>> NUMA host support no
>> tcmalloc support  no
>> jemalloc support  no
>> avx2 optimization no
>> replication support yes
>> VxHS block device no
>> capstone          no
>>   GEN     x86_64-softmmu/config-devices.mak.tmp
>> mkdir -p dtc/libfdt
>>   GEN     aarch64-softmmu/config-devices.mak.tmp
>> mkdir -p dtc/tests
>>   GEN     config-host.h
>>   GEN     qemu-options.def
>>   GEN     qmp-commands.h
>>   GEN     qapi-visit.h
>>   GEN     qapi-types.h
>>   GEN     qapi-event.h
>>   GEN     x86_64-softmmu/config-devices.mak
>>   GEN     aarch64-softmmu/config-devices.mak
>>   GEN     qmp-marshal.c
>>   GEN     qapi-types.c
>>   GEN     qapi-visit.c
>>   GEN     qapi-event.c
>>   GEN     qmp-introspect.h
>>   GEN     qmp-introspect.c
>>   GEN     trace/generated-tcg-tracers.h
>>   GEN     trace/generated-helpers-wrappers.h
>>   GEN     trace/generated-helpers.h
>>   GEN     trace/generated-helpers.c
>>   GEN     module_block.h
>>   GEN     ui/input-keymap-linux-to-qcode.c
>>   GEN     ui/input-keymap-qcode-to-qnum.c
>>   GEN     ui/input-keymap-qnum-to-qcode.c
>>   GEN     tests/test-qapi-types.h
>>   GEN     tests/test-qapi-visit.h
>>   GEN     tests/test-qmp-commands.h
>>   GEN     tests/test-qapi-event.h
>>   GEN     tests/test-qmp-introspect.h
>>   GEN     trace-root.h
>>   GEN     util/trace.h
>>   GEN     crypto/trace.h
>>   GEN     io/trace.h
>>   GEN     migration/trace.h
>>   GEN     block/trace.h
>>   GEN     chardev/trace.h
>>   GEN     hw/block/trace.h
>>   GEN     hw/block/dataplane/trace.h
>>   GEN     hw/char/trace.h
>>   GEN     hw/intc/trace.h
>>   GEN     hw/net/trace.h
>>   GEN     hw/virtio/trace.h
>>   GEN     hw/audio/trace.h
>>   GEN     hw/misc/trace.h
>>   GEN     hw/usb/trace.h
>>   GEN     hw/scsi/trace.h
>>   GEN     hw/nvram/trace.h
>>   GEN     hw/display/trace.h
>>   GEN     hw/input/trace.h
>>   GEN     hw/timer/trace.h
>>   GEN     hw/dma/trace.h
>>   GEN     hw/sparc/trace.h
>>   GEN     hw/sd/trace.h
>>   GEN     hw/isa/trace.h
>>   GEN     hw/mem/trace.h
>>   GEN     hw/i386/trace.h
>>   GEN     hw/i386/xen/trace.h
>>   GEN     hw/9pfs/trace.h
>>   GEN     hw/ppc/trace.h
>>   GEN     hw/pci/trace.h
>>   GEN     hw/s390x/trace.h
>>   GEN     hw/vfio/trace.h
>>   GEN     hw/acpi/trace.h
>>   GEN     hw/arm/trace.h
>>   GEN     hw/alpha/trace.h
>>   GEN     hw/xen/trace.h
>>   GEN     hw/ide/trace.h
>>   GEN     ui/trace.h
>>   GEN     audio/trace.h
>>   GEN     net/trace.h
>>   GEN     target/arm/trace.h
>>   GEN     target/i386/trace.h
>>   GEN     target/mips/trace.h
>>   GEN     target/sparc/trace.h
>>   GEN     target/s390x/trace.h
>>   GEN     target/ppc/trace.h
>>   GEN     qom/trace.h
>>   GEN     linux-user/trace.h
>>   GEN     qapi/trace.h
>>   GEN     accel/tcg/trace.h
>>   GEN     accel/kvm/trace.h
>>   GEN     nbd/trace.h
>>   GEN     trace-root.c
>>   GEN     scsi/trace.h
>>   GEN     util/trace.c
>>   GEN     crypto/trace.c
>>   GEN     io/trace.c
>>   GEN     migration/trace.c
>>   GEN     block/trace.c
>>   GEN     chardev/trace.c
>>   GEN     hw/block/trace.c
>>   GEN     hw/block/dataplane/trace.c
>>   GEN     hw/char/trace.c
>>   GEN     hw/intc/trace.c
>>   GEN     hw/net/trace.c
>>   GEN     hw/virtio/trace.c
>>   GEN     hw/audio/trace.c
>>   GEN     hw/misc/trace.c
>>   GEN     hw/usb/trace.c
>>   GEN     hw/scsi/trace.c
>>   GEN     hw/nvram/trace.c
>>   GEN     hw/display/trace.c
>>   GEN     hw/input/trace.c
>>   GEN     hw/timer/trace.c
>>   GEN     hw/dma/trace.c
>>   GEN     hw/sparc/trace.c
>>   GEN     hw/sd/trace.c
>>   GEN     hw/isa/trace.c
>>   GEN     hw/mem/trace.c
>>   GEN     hw/i386/trace.c
>>   GEN     hw/i386/xen/trace.c
>>   GEN     hw/9pfs/trace.c
>>   GEN     hw/ppc/trace.c
>>   GEN     hw/pci/trace.c
>>   GEN     hw/s390x/trace.c
>>   GEN     hw/vfio/trace.c
>>   GEN     hw/acpi/trace.c
>>   GEN     hw/arm/trace.c
>>   GEN     hw/alpha/trace.c
>>   GEN     hw/xen/trace.c
>>   GEN     hw/ide/trace.c
>>   GEN     ui/trace.c
>>   GEN     audio/trace.c
>>   GEN     net/trace.c
>>   GEN     target/arm/trace.c
>>   GEN     target/i386/trace.c
>>   GEN     target/mips/trace.c
>>   GEN     target/sparc/trace.c
>>   GEN     target/s390x/trace.c
>>   GEN     target/ppc/trace.c
>>   GEN     qom/trace.c
>>   GEN     linux-user/trace.c
>>   GEN     qapi/trace.c
>>   GEN     accel/tcg/trace.c
>>   GEN     accel/kvm/trace.c
>>   GEN     nbd/trace.c
>>   GEN     scsi/trace.c
>>   GEN     config-all-devices.mak
>>          DEP /tmp/qemu-test/src/dtc/tests/dumptrees.c
>>          DEP /tmp/qemu-test/src/dtc/tests/trees.S
>>          DEP /tmp/qemu-test/src/dtc/tests/testutils.c
>>          DEP /tmp/qemu-test/src/dtc/tests/value-labels.c
>>          DEP /tmp/qemu-test/src/dtc/tests/asm_tree_dump.c
>>          DEP /tmp/qemu-test/src/dtc/tests/truncated_property.c
>>          DEP /tmp/qemu-test/src/dtc/tests/check_path.c
>>          DEP /tmp/qemu-test/src/dtc/tests/overlay_bad_fixup.c
>>          DEP /tmp/qemu-test/src/dtc/tests/overlay.c
>>          DEP /tmp/qemu-test/src/dtc/tests/subnode_iterate.c
>>          DEP /tmp/qemu-test/src/dtc/tests/property_iterate.c
>>          DEP /tmp/qemu-test/src/dtc/tests/integer-expressions.c
>>          DEP /tmp/qemu-test/src/dtc/tests/utilfdt_test.c
>>          DEP /tmp/qemu-test/src/dtc/tests/path_offset_aliases.c
>>          DEP /tmp/qemu-test/src/dtc/tests/add_subnode_with_nops.c
>>          DEP /tmp/qemu-test/src/dtc/tests/dtbs_equal_unordered.c
>>          DEP /tmp/qemu-test/src/dtc/tests/dtb_reverse.c
>>          DEP /tmp/qemu-test/src/dtc/tests/dtbs_equal_ordered.c
>>          DEP /tmp/qemu-test/src/dtc/tests/extra-terminating-null.c
>>          DEP /tmp/qemu-test/src/dtc/tests/incbin.c
>>          DEP /tmp/qemu-test/src/dtc/tests/phandle_format.c
>>          DEP /tmp/qemu-test/src/dtc/tests/boot-cpuid.c
>>          DEP /tmp/qemu-test/src/dtc/tests/path-references.c
>>          DEP /tmp/qemu-test/src/dtc/tests/references.c
>>          DEP /tmp/qemu-test/src/dtc/tests/string_escapes.c
>>          DEP /tmp/qemu-test/src/dtc/tests/appendprop2.c
>>          DEP /tmp/qemu-test/src/dtc/tests/propname_escapes.c
>>          DEP /tmp/qemu-test/src/dtc/tests/appendprop1.c
>>          DEP /tmp/qemu-test/src/dtc/tests/del_node.c
>>          DEP /tmp/qemu-test/src/dtc/tests/del_property.c
>>          DEP /tmp/qemu-test/src/dtc/tests/setprop.c
>>          DEP /tmp/qemu-test/src/dtc/tests/set_name.c
>>          DEP /tmp/qemu-test/src/dtc/tests/rw_tree1.c
>>          DEP /tmp/qemu-test/src/dtc/tests/open_pack.c
>>          DEP /tmp/qemu-test/src/dtc/tests/nopulate.c
>>          DEP /tmp/qemu-test/src/dtc/tests/mangle-layout.c
>>          DEP /tmp/qemu-test/src/dtc/tests/move_and_save.c
>>          DEP /tmp/qemu-test/src/dtc/tests/sw_tree1.c
>>          DEP /tmp/qemu-test/src/dtc/tests/nop_node.c
>>          DEP /tmp/qemu-test/src/dtc/tests/nop_property.c
>>          DEP /tmp/qemu-test/src/dtc/tests/setprop_inplace.c
>>          DEP /tmp/qemu-test/src/dtc/tests/stringlist.c
>>          DEP /tmp/qemu-test/src/dtc/tests/addr_size_cells.c
>>          DEP /tmp/qemu-test/src/dtc/tests/sized_cells.c
>>          DEP /tmp/qemu-test/src/dtc/tests/char_literal.c
>>          DEP /tmp/qemu-test/src/dtc/tests/notfound.c
>>          DEP /tmp/qemu-test/src/dtc/tests/get_alias.c
>>          DEP /tmp/qemu-test/src/dtc/tests/node_check_compatible.c
>>          DEP /tmp/qemu-test/src/dtc/tests/node_offset_by_phandle.c
>>          DEP /tmp/qemu-test/src/dtc/tests/node_offset_by_compatible.c
>>          DEP /tmp/qemu-test/src/dtc/tests/node_offset_by_prop_value.c
>>          DEP /tmp/qemu-test/src/dtc/tests/supernode_atdepth_offset.c
>>          DEP /tmp/qemu-test/src/dtc/tests/parent_offset.c
>>          DEP /tmp/qemu-test/src/dtc/tests/get_path.c
>>          DEP /tmp/qemu-test/src/dtc/tests/get_phandle.c
>>          DEP /tmp/qemu-test/src/dtc/tests/getprop.c
>>          DEP /tmp/qemu-test/src/dtc/tests/get_name.c
>>          DEP /tmp/qemu-test/src/dtc/tests/path_offset.c
>>          DEP /tmp/qemu-test/src/dtc/tests/find_property.c
>>          DEP /tmp/qemu-test/src/dtc/tests/subnode_offset.c
>>          DEP /tmp/qemu-test/src/dtc/tests/root_node.c
>>          DEP /tmp/qemu-test/src/dtc/tests/get_mem_rsv.c
>>          DEP /tmp/qemu-test/src/dtc/libfdt/fdt_overlay.c
>>          DEP /tmp/qemu-test/src/dtc/libfdt/fdt_addresses.c
>>          DEP /tmp/qemu-test/src/dtc/libfdt/fdt_empty_tree.c
>>          DEP /tmp/qemu-test/src/dtc/libfdt/fdt_strerror.c
>>          DEP /tmp/qemu-test/src/dtc/libfdt/fdt_rw.c
>>          DEP /tmp/qemu-test/src/dtc/libfdt/fdt_sw.c
>>          DEP /tmp/qemu-test/src/dtc/libfdt/fdt_ro.c
>>          DEP /tmp/qemu-test/src/dtc/libfdt/fdt_wip.c
>>          DEP /tmp/qemu-test/src/dtc/libfdt/fdt.c
>>          DEP /tmp/qemu-test/src/dtc/util.c
>>          DEP /tmp/qemu-test/src/dtc/fdtput.c
>>          DEP /tmp/qemu-test/src/dtc/fdtget.c
>>          DEP /tmp/qemu-test/src/dtc/fdtdump.c
>>          LEX convert-dtsv0-lexer.lex.c
>> make[1]: flex: Command not found
>>          BISON dtc-parser.tab.c
>>          DEP /tmp/qemu-test/src/dtc/srcpos.c
>> make[1]: bison: Command not found
>>          DEP /tmp/qemu-test/src/dtc/treesource.c
>>          DEP /tmp/qemu-test/src/dtc/livetree.c
>>          LEX dtc-lexer.lex.c
>> make[1]: flex: Command not found
>>          DEP /tmp/qemu-test/src/dtc/fstree.c
>>          DEP /tmp/qemu-test/src/dtc/dtc.c
>>          DEP /tmp/qemu-test/src/dtc/data.c
>>          DEP /tmp/qemu-test/src/dtc/checks.c
>>          DEP /tmp/qemu-test/src/dtc/flattree.c
>>         CHK version_gen.h
>>          LEX convert-dtsv0-lexer.lex.c
>>          BISON dtc-parser.tab.c
>> make[1]: flex: Command not found
>> make[1]: bison: Command not found
>>         UPD version_gen.h
>>          LEX dtc-lexer.lex.c
>> make[1]: flex: Command not found
>>          DEP /tmp/qemu-test/src/dtc/util.c
>>          LEX convert-dtsv0-lexer.lex.c
>>          BISON dtc-parser.tab.c
>>          LEX dtc-lexer.lex.c
>> make[1]: flex: Command not found
>> make[1]: bison: Command not found
>> make[1]: flex: Command not found
>>          CC libfdt/fdt.o
>>          CC libfdt/fdt_wip.o
>>          CC libfdt/fdt_ro.o
>>          CC libfdt/fdt_strerror.o
>>          CC libfdt/fdt_sw.o
>>          CC libfdt/fdt_rw.o
>>          CC libfdt/fdt_empty_tree.o
>>          CC libfdt/fdt_addresses.o
>>          CC libfdt/fdt_overlay.o
>>          AR libfdt/libfdt.a
>> ar: creating libfdt/libfdt.a
>> a - libfdt/fdt.o
>> a - libfdt/fdt_ro.o
>> a - libfdt/fdt_wip.o
>> a - libfdt/fdt_sw.o
>> a - libfdt/fdt_rw.o
>> a - libfdt/fdt_strerror.o
>> a - libfdt/fdt_empty_tree.o
>> a - libfdt/fdt_addresses.o
>> a - libfdt/fdt_overlay.o
>> mkdir -p dtc/libfdt
>> mkdir -p dtc/tests
>>          LEX convert-dtsv0-lexer.lex.c
>> make[1]: flex: Command not found
>>          BISON dtc-parser.tab.c
>> make[1]: bison: Command not found
>>          LEX dtc-lexer.lex.c
>> make[1]: flex: Command not found
>>   CC      tests/qemu-iotests/socket_scm_helper.o
>>   GEN     qga/qapi-generated/qga-qapi-types.h
>>   GEN     qga/qapi-generated/qga-qapi-visit.h
>>   GEN     qga/qapi-generated/qga-qmp-commands.h
>>   GEN     qga/qapi-generated/qga-qapi-visit.c
>>   GEN     qga/qapi-generated/qga-qmp-marshal.c
>>   CC      qmp-introspect.o
>>   GEN     qga/qapi-generated/qga-qapi-types.c
>>   CC      qapi-types.o
>>   CC      qapi-visit.o
>>   CC      qapi-event.o
>>   CC      qapi/qapi-visit-core.o
>>   CC      qapi/qapi-dealloc-visitor.o
>>   CC      qapi/qobject-input-visitor.o
>>   CC      qapi/qobject-output-visitor.o
>>   CC      qapi/qmp-registry.o
>>   CC      qapi/qmp-dispatch.o
>>   CC      qapi/string-input-visitor.o
>>   CC      qapi/string-output-visitor.o
>>   CC      qapi/opts-visitor.o
>>   CC      qapi/qapi-clone-visitor.o
>>   CC      qapi/qmp-event.o
>>   CC      qapi/qapi-util.o
>>   CC      qobject/qnull.o
>>   CC      qobject/qnum.o
>>   CC      qobject/qstring.o
>>   CC      qobject/qdict.o
>>   CC      qobject/qlist.o
>>   CC      qobject/qbool.o
>>   CC      qobject/qlit.o
>>   CC      qobject/qjson.o
>>   CC      qobject/qobject.o
>>   CC      qobject/json-lexer.o
>>   CC      qobject/json-streamer.o
>>   CC      qobject/json-parser.o
>>   CC      trace/control.o
>>   CC      trace/qmp.o
>>   CC      util/osdep.o
>>   CC      util/cutils.o
>>   CC      util/unicode.o
>>   CC      util/qemu-timer-common.o
>>   CC      util/bufferiszero.o
>>   CC      util/lockcnt.o
>>   CC      util/aiocb.o
>>   CC      util/thread-pool.o
>>   CC      util/async.o
>>   CC      util/qemu-timer.o
>>   CC      util/main-loop.o
>>   CC      util/iohandler.o
>>   CC      util/aio-posix.o
>>   CC      util/event_notifier-posix.o
>>   CC      util/compatfd.o
>>   CC      util/mmap-alloc.o
>>   CC      util/qemu-openpty.o
>>   CC      util/oslib-posix.o
>>   CC      util/qemu-thread-posix.o
>>   CC      util/memfd.o
>>   CC      util/envlist.o
>>   CC      util/path.o
>>   CC      util/module.o
>>   CC      util/host-utils.o
>>   CC      util/bitmap.o
>>   CC      util/bitops.o
>>   CC      util/hbitmap.o
>>   CC      util/fifo8.o
>>   CC      util/acl.o
>>   CC      util/cacheinfo.o
>>   CC      util/error.o
>>   CC      util/qemu-error.o
>>   CC      util/id.o
>>   CC      util/iov.o
>>   CC      util/qemu-config.o
>>   CC      util/qemu-sockets.o
>>   CC      util/uri.o
>>   CC      util/notify.o
>>   CC      util/qemu-progress.o
>>   CC      util/qemu-option.o
>>   CC      util/hexdump.o
>>   CC      util/keyval.o
>>   CC      util/crc32c.o
>>   CC      util/uuid.o
>>   CC      util/throttle.o
>>   CC      util/getauxval.o
>>   CC      util/readline.o
>>   CC      util/rcu.o
>>   CC      util/qemu-coroutine.o
>>   CC      util/qemu-coroutine-lock.o
>>   CC      util/qemu-coroutine-io.o
>>   CC      util/qemu-coroutine-sleep.o
>>   CC      util/coroutine-ucontext.o
>>   CC      util/buffer.o
>>   CC      util/timed-average.o
>>   CC      util/base64.o
>>   CC      util/log.o
>>   CC      util/pagesize.o
>>   CC      util/qdist.o
>>   CC      util/qht.o
>>   CC      util/stats64.o
>>   CC      util/range.o
>>   CC      trace-root.o
>>   CC      util/systemd.o
>>   CC      crypto/trace.o
>>   CC      util/trace.o
>>   CC      io/trace.o
>>   CC      migration/trace.o
>>   CC      block/trace.o
>>   CC      chardev/trace.o
>>   CC      hw/block/trace.o
>>   CC      hw/block/dataplane/trace.o
>>   CC      hw/char/trace.o
>>   CC      hw/intc/trace.o
>>   CC      hw/net/trace.o
>>   CC      hw/virtio/trace.o
>>   CC      hw/audio/trace.o
>>   CC      hw/misc/trace.o
>>   CC      hw/usb/trace.o
>>   CC      hw/scsi/trace.o
>>   CC      hw/nvram/trace.o
>>   CC      hw/display/trace.o
>>   CC      hw/input/trace.o
>>   CC      hw/timer/trace.o
>>   CC      hw/dma/trace.o
>>   CC      hw/sparc/trace.o
>>   CC      hw/sd/trace.o
>>   CC      hw/isa/trace.o
>>   CC      hw/mem/trace.o
>>   CC      hw/i386/trace.o
>>   CC      hw/i386/xen/trace.o
>>   CC      hw/9pfs/trace.o
>>   CC      hw/pci/trace.o
>>   CC      hw/ppc/trace.o
>>   CC      hw/s390x/trace.o
>>   CC      hw/vfio/trace.o
>>   CC      hw/acpi/trace.o
>>   CC      hw/arm/trace.o
>>   CC      hw/alpha/trace.o
>>   CC      hw/xen/trace.o
>>   CC      ui/trace.o
>>   CC      hw/ide/trace.o
>>   CC      audio/trace.o
>>   CC      net/trace.o
>>   CC      target/arm/trace.o
>>   CC      target/i386/trace.o
>>   CC      target/mips/trace.o
>>   CC      target/sparc/trace.o
>>   CC      target/s390x/trace.o
>>   CC      target/ppc/trace.o
>>   CC      qom/trace.o
>>   CC      linux-user/trace.o
>>   CC      qapi/trace.o
>>   CC      accel/tcg/trace.o
>>   CC      accel/kvm/trace.o
>>   CC      scsi/trace.o
>>   CC      nbd/trace.o
>>   CC      crypto/pbkdf-stub.o
>>   CC      stubs/arch-query-cpu-def.o
>>   CC      stubs/arch-query-cpu-model-expansion.o
>>   CC      stubs/arch-query-cpu-model-comparison.o
>>   CC      stubs/arch-query-cpu-model-baseline.o
>>   CC      stubs/bdrv-next-monitor-owned.o
>>   CC      stubs/blk-commit-all.o
>>   CC      stubs/blockdev-close-all-bdrv-states.o
>>   CC      stubs/clock-warp.o
>>   CC      stubs/cpu-get-clock.o
>>   CC      stubs/cpu-get-icount.o
>>   CC      stubs/dump.o
>>   CC      stubs/error-printf.o
>>   CC      stubs/fdset.o
>>   CC      stubs/gdbstub.o
>>   CC      stubs/iothread.o
>>   CC      stubs/get-vm-name.o
>>   CC      stubs/iothread-lock.o
>>   CC      stubs/is-daemonized.o
>>   CC      stubs/machine-init-done.o
>>   CC      stubs/migr-blocker.o
>>   CC      stubs/monitor.o
>>   CC      stubs/change-state-handler.o
>>   CC      stubs/notify-event.o
>>   CC      stubs/qtest.o
>>   CC      stubs/replay.o
>>   CC      stubs/runstate-check.o
>>   CC      stubs/set-fd-handler.o
>>   CC      stubs/slirp.o
>>   CC      stubs/sysbus.o
>>   CC      stubs/tpm.o
>>   CC      stubs/uuid.o
>>   CC      stubs/vm-stop.o
>>   CC      stubs/trace-control.o
>>   CC      stubs/vmstate.o
>>   CC      stubs/qmp_pc_dimm.o
>>   CC      stubs/target-monitor-defs.o
>>   CC      stubs/target-get-monitor-def.o
>>   CC      stubs/pc_madt_cpu_entry.o
>>   CC      stubs/vmgenid.o
>>   CC      stubs/xen-common.o
>>   CC      stubs/xen-hvm.o
>>   CC      stubs/pci-host-piix.o
>>   CC      contrib/ivshmem-client/ivshmem-client.o
>>   CC      contrib/ivshmem-client/main.o
>>   CC      contrib/ivshmem-server/ivshmem-server.o
>>   CC      block.o
>>   CC      qemu-nbd.o
>>   CC      contrib/ivshmem-server/main.o
>>   CC      blockjob.o
>>   CC      qemu-io-cmds.o
>>   CC      replication.o
>>   CC      block/raw-format.o
>>   CC      block/qcow.o
>>   CC      block/vmdk.o
>>   CC      block/vdi.o
>>   CC      block/cloop.o
>>   CC      block/bochs.o
>>   CC      block/vpc.o
>>   CC      block/vvfat.o
>>   CC      block/dmg.o
>>   CC      block/qcow2.o
>>   CC      block/qcow2-refcount.o
>>   CC      block/qcow2-cluster.o
>>   CC      block/qcow2-snapshot.o
>>   CC      block/qcow2-cache.o
>>   CC      block/qed.o
>>   CC      block/qcow2-bitmap.o
>>   CC      block/qed-l2-cache.o
>>   CC      block/qed-table.o
>>   CC      block/qed-cluster.o
>>   CC      block/qed-check.o
>>   CC      block/vhdx-endian.o
>>   CC      block/vhdx.o
>>   CC      block/vhdx-log.o
>>   CC      block/quorum.o
>>   CC      block/parallels.o
>>   CC      block/blkdebug.o
>>   CC      block/blkverify.o
>>   CC      block/blkreplay.o
>>   CC      block/block-backend.o
>>   CC      block/snapshot.o
>>   CC      block/qapi.o
>>   CC      block/file-posix.o
>>   CC      block/null.o
>>   CC      block/mirror.o
>>   CC      block/commit.o
>>   CC      block/io.o
>>   CC      block/throttle-groups.o
>>   CC      block/nbd.o
>>   CC      block/nbd-client.o
>>   CC      block/sheepdog.o
>>   CC      block/accounting.o
>>   CC      block/dirty-bitmap.o
>>   CC      block/write-threshold.o
>>   CC      block/backup.o
>>   CC      block/replication.o
>>   CC      block/throttle.o
>>   CC      block/crypto.o
>>   CC      nbd/server.o
>>   CC      nbd/client.o
>>   CC      nbd/common.o
>>   CC      scsi/utils.o
>>   CC      scsi/pr-manager.o
>>   CC      scsi/pr-manager-helper.o
>>   CC      crypto/init.o
>>   CC      crypto/hash.o
>>   CC      crypto/hash-glib.o
>>   CC      crypto/hmac.o
>>   CC      crypto/hmac-glib.o
>>   CC      crypto/aes.o
>>   CC      crypto/desrfb.o
>>   CC      crypto/cipher.o
>>   CC      crypto/tlscreds.o
>>   CC      crypto/tlscredsanon.o
>>   CC      crypto/tlscredsx509.o
>>   CC      crypto/tlssession.o
>>   CC      crypto/secret.o
>>   CC      crypto/random-platform.o
>>   CC      crypto/pbkdf.o
>>   CC      crypto/ivgen.o
>>   CC      crypto/ivgen-essiv.o
>>   CC      crypto/ivgen-plain.o
>>   CC      crypto/afsplit.o
>>   CC      crypto/ivgen-plain64.o
>>   CC      crypto/block.o
>>   CC      crypto/xts.o
>>   CC      crypto/block-qcow.o
>>   CC      crypto/block-luks.o
>>   CC      io/channel.o
>>   CC      io/channel-buffer.o
>>   CC      io/channel-command.o
>>   CC      io/channel-file.o
>>   CC      io/channel-socket.o
>>   CC      io/channel-tls.o
>>   CC      io/channel-watch.o
>>   CC      io/channel-websock.o
>>   CC      io/channel-util.o
>>   CC      io/dns-resolver.o
>>   CC      io/task.o
>>   CC      qom/object.o
>>   CC      qom/qom-qobject.o
>>   CC      qom/container.o
>>   CC      qom/object_interfaces.o
>>   GEN     qemu-img-cmds.h
>>   CC      qemu-io.o
>>   CC      scsi/qemu-pr-helper.o
>>   CC      qemu-bridge-helper.o
>>   CC      blockdev-nbd.o
>>   CC      blockdev.o
>>   CC      bootdevice.o
>>   CC      iothread.o
>>   CC      qdev-monitor.o
>>   CC      device-hotplug.o
>>   CC      os-posix.o
>>   CC      bt-host.o
>>   CC      bt-vhci.o
>>   CC      dma-helpers.o
>>   CC      vl.o
>>   CC      tpm.o
>>   CC      device_tree.o
>>   CC      qmp-marshal.o
>>   CC      qmp.o
>>   CC      cpus-common.o
>>   CC      hmp.o
>>   CC      audio/audio.o
>>   CC      audio/wavaudio.o
>>   CC      audio/noaudio.o
>>   CC      audio/mixeng.o
>>   CC      audio/sdlaudio.o
>>   CC      audio/ossaudio.o
>>   CC      audio/wavcapture.o
>>   CC      backends/rng.o
>>   CC      backends/rng-random.o
>>   CC      backends/rng-egd.o
>>   CC      backends/tpm.o
>>   CC      backends/hostmem.o
>>   CC      backends/hostmem-ram.o
>>   CC      backends/hostmem-file.o
>>   CC      backends/cryptodev.o
>>   CC      backends/cryptodev-builtin.o
>>   CC      block/stream.o
>>   CC      chardev/msmouse.o
>>   CC      chardev/wctablet.o
>>   CC      chardev/testdev.o
>>   CC      disas/arm.o
>>   CC      disas/i386.o
>>   CC      fsdev/qemu-fsdev-dummy.o
>>   CC      fsdev/qemu-fsdev-opts.o
>>   CC      fsdev/qemu-fsdev-throttle.o
>>   CC      hw/acpi/core.o
>>   CC      hw/acpi/piix4.o
>>   CC      hw/acpi/pcihp.o
>>   CC      hw/acpi/ich9.o
>>   CC      hw/acpi/tco.o
>>   CC      hw/acpi/cpu_hotplug.o
>>   CC      hw/acpi/memory_hotplug.o
>>   CC      hw/acpi/cpu.o
>>   CC      hw/acpi/nvdimm.o
>>   CC      hw/acpi/vmgenid.o
>>   CC      hw/acpi/acpi_interface.o
>>   CC      hw/acpi/bios-linker-loader.o
>>   CC      hw/acpi/aml-build.o
>>   CC      hw/acpi/ipmi.o
>>   CC      hw/acpi/acpi-stub.o
>>   CC      hw/acpi/ipmi-stub.o
>>   CC      hw/audio/sb16.o
>>   CC      hw/audio/es1370.o
>>   CC      hw/audio/ac97.o
>>   CC      hw/audio/fmopl.o
>>   CC      hw/audio/adlib.o
>>   CC      hw/audio/gus.o
>>   CC      hw/audio/gusemu_hal.o
>>   CC      hw/audio/gusemu_mixer.o
>>   CC      hw/audio/cs4231a.o
>>   CC      hw/audio/intel-hda.o
>>   CC      hw/audio/hda-codec.o
>>   CC      hw/audio/pcspk.o
>>   CC      hw/audio/wm8750.o
>>   CC      hw/audio/pl041.o
>>   CC      hw/audio/lm4549.o
>>   CC      hw/audio/marvell_88w8618.o
>>   CC      hw/audio/soundhw.o
>>   CC      hw/block/block.o
>>   CC      hw/block/cdrom.o
>>   CC      hw/block/hd-geometry.o
>>   CC      hw/block/fdc.o
>>   CC      hw/block/m25p80.o
>>   CC      hw/block/nand.o
>>   CC      hw/block/pflash_cfi01.o
>>   CC      hw/block/pflash_cfi02.o
>>   CC      hw/block/ecc.o
>>   CC      hw/block/onenand.o
>>   CC      hw/block/nvme.o
>>   CC      hw/bt/l2cap.o
>>   CC      hw/bt/core.o
>>   CC      hw/bt/sdp.o
>>   CC      hw/bt/hci.o
>>   CC      hw/bt/hid.o
>>   CC      hw/bt/hci-csr.o
>>   CC      hw/char/ipoctal232.o
>>   CC      hw/char/parallel.o
>>   CC      hw/char/pl011.o
>>   CC      hw/char/serial.o
>>   CC      hw/char/serial-isa.o
>>   CC      hw/char/serial-pci.o
>>   CC      hw/char/virtio-console.o
>>   CC      hw/char/cadence_uart.o
>>   CC      hw/char/cmsdk-apb-uart.o
>>   CC      hw/char/debugcon.o
>>   CC      hw/char/imx_serial.o
>>   CC      hw/core/qdev.o
>>   CC      hw/core/bus.o
>>   CC      hw/core/qdev-properties.o
>>   CC      hw/core/reset.o
>>   CC      hw/core/irq.o
>>   CC      hw/core/fw-path-provider.o
>>   CC      hw/core/hotplug.o
>>   CC      hw/core/nmi.o
>>   CC      hw/core/sysbus.o
>>   CC      hw/core/ptimer.o
>>   CC      hw/core/machine.o
>>   CC      hw/core/loader.o
>>   CC      hw/core/qdev-properties-system.o
>>   CC      hw/core/register.o
>>   CC      hw/core/or-irq.o
>>   CC      hw/core/platform-bus.o
>>   CC      hw/cpu/core.o
>>   CC      hw/display/ads7846.o
>>   CC      hw/display/cirrus_vga.o
>>   CC      hw/display/pl110.o
>>   CC      hw/display/ssd0303.o
>>   CC      hw/display/ssd0323.o
>>   CC      hw/display/vga-pci.o
>>   CC      hw/display/vga-isa.o
>>   CC      hw/display/vmware_vga.o
>>   CC      hw/display/blizzard.o
>>   CC      hw/display/exynos4210_fimd.o
>>   CC      hw/display/framebuffer.o
>>   CC      hw/display/tc6393xb.o
>>   CC      hw/dma/pl080.o
>>   CC      hw/dma/pl330.o
>>   CC      hw/dma/i8257.o
>>   CC      hw/dma/xlnx-zynq-devcfg.o
>>   CC      hw/gpio/max7310.o
>>   CC      hw/gpio/pl061.o
>>   CC      hw/gpio/zaurus.o
>>   CC      hw/gpio/gpio_key.o
>>   CC      hw/i2c/core.o
>>   CC      hw/i2c/smbus.o
>>   CC      hw/i2c/smbus_eeprom.o
>>   CC      hw/i2c/i2c-ddc.o
>>   CC      hw/i2c/versatile_i2c.o
>>   CC      hw/i2c/smbus_ich9.o
>>   CC      hw/i2c/bitbang_i2c.o
>>   CC      hw/i2c/pm_smbus.o
>>   CC      hw/i2c/exynos4210_i2c.o
>>   CC      hw/i2c/imx_i2c.o
>>   CC      hw/i2c/aspeed_i2c.o
>>   CC      hw/ide/core.o
>>   CC      hw/ide/atapi.o
>>   CC      hw/ide/qdev.o
>>   CC      hw/ide/pci.o
>>   CC      hw/ide/isa.o
>>   CC      hw/ide/piix.o
>>   CC      hw/ide/microdrive.o
>>   CC      hw/ide/ahci.o
>>   CC      hw/ide/ich.o
>>   CC      hw/ide/ahci-allwinner.o
>>   CC      hw/input/hid.o
>>   CC      hw/input/lm832x.o
>>   CC      hw/input/pckbd.o
>>   CC      hw/input/pl050.o
>>   CC      hw/input/ps2.o
>>   CC      hw/input/stellaris_input.o
>>   CC      hw/input/tsc2005.o
>>   CC      hw/input/vmmouse.o
>>   CC      hw/input/virtio-input.o
>>   CC      hw/input/virtio-input-hid.o
>>   CC      hw/input/virtio-input-host.o
>>   CC      hw/intc/i8259_common.o
>>   CC      hw/intc/i8259.o
>>   CC      hw/intc/pl190.o
>>   CC      hw/intc/imx_avic.o
>>   CC      hw/intc/realview_gic.o
>>   CC      hw/intc/ioapic_common.o
>>   CC      hw/intc/arm_gic_common.o
>>   CC      hw/intc/arm_gicv2m.o
>>   CC      hw/intc/arm_gicv3_common.o
>>   CC      hw/intc/arm_gic.o
>>   CC      hw/intc/arm_gicv3.o
>>   CC      hw/intc/arm_gicv3_dist.o
>>   CC      hw/intc/arm_gicv3_redist.o
>>   CC      hw/intc/arm_gicv3_its_common.o
>>   CC      hw/intc/intc.o
>>   CC      hw/ipack/ipack.o
>>   CC      hw/ipack/tpci200.o
>>   CC      hw/ipmi/ipmi.o
>>   CC      hw/ipmi/ipmi_bmc_sim.o
>>   CC      hw/ipmi/ipmi_bmc_extern.o
>>   CC      hw/ipmi/isa_ipmi_kcs.o
>>   CC      hw/ipmi/isa_ipmi_bt.o
>>   CC      hw/isa/isa-bus.o
>>   CC      hw/isa/apm.o
>>   CC      hw/mem/pc-dimm.o
>>   CC      hw/mem/nvdimm.o
>>   CC      hw/misc/applesmc.o
>>   CC      hw/misc/max111x.o
>>   CC      hw/misc/tmp105.o
>>   CC      hw/misc/tmp421.o
>>   CC      hw/misc/debugexit.o
>>   CC      hw/misc/sga.o
>>   CC      hw/misc/pc-testdev.o
>>   CC      hw/misc/pci-testdev.o
>>   CC      hw/misc/edu.o
>>   CC      hw/misc/unimp.o
>>   CC      hw/misc/vmcoreinfo.o
>>   CC      hw/misc/arm_l2x0.o
>>   CC      hw/misc/arm_integrator_debug.o
>>   CC      hw/misc/a9scu.o
>>   CC      hw/misc/arm11scu.o
>>   CC      hw/net/ne2000.o
>>   CC      hw/net/eepro100.o
>>   CC      hw/net/pcnet-pci.o
>>   CC      hw/net/pcnet.o
>>   CC      hw/net/e1000.o
>>   CC      hw/net/e1000x_common.o
>>   CC      hw/net/net_tx_pkt.o
>>   CC      hw/net/net_rx_pkt.o
>>   CC      hw/net/e1000e.o
>>   CC      hw/net/e1000e_core.o
>>   CC      hw/net/rtl8139.o
>>   CC      hw/net/vmxnet3.o
>>   CC      hw/net/lan9118.o
>>   CC      hw/net/smc91c111.o
>>   CC      hw/net/ne2000-isa.o
>>   CC      hw/net/xgmac.o
>>   CC      hw/net/allwinner_emac.o
>>   CC      hw/net/imx_fec.o
>>   CC      hw/net/cadence_gem.o
>>   CC      hw/net/stellaris_enet.o
>>   CC      hw/net/ftgmac100.o
>>   CC      hw/net/rocker/rocker.o
>>   CC      hw/net/rocker/rocker_fp.o
>>   CC      hw/net/rocker/rocker_desc.o
>>   CC      hw/net/rocker/rocker_world.o
>>   CC      hw/net/rocker/rocker_of_dpa.o
>>   CC      hw/nvram/fw_cfg.o
>>   CC      hw/nvram/eeprom93xx.o
>>   CC      hw/nvram/chrp_nvram.o
>>   CC      hw/pci-bridge/pci_bridge_dev.o
>>   CC      hw/pci-bridge/pcie_root_port.o
>>   CC      hw/pci-bridge/gen_pcie_root_port.o
>>   CC      hw/pci-bridge/pcie_pci_bridge.o
>>   CC      hw/pci-bridge/pci_expander_bridge.o
>>   CC      hw/pci-bridge/xio3130_upstream.o
>>   CC      hw/pci-bridge/xio3130_downstream.o
>>   CC      hw/pci-bridge/ioh3420.o
>>   CC      hw/pci-bridge/i82801b11.o
>>   CC      hw/pci-host/pam.o
>>   CC      hw/pci-host/versatile.o
>>   CC      hw/pci-host/piix.o
>>   CC      hw/pci-host/q35.o
>>   CC      hw/pci-host/gpex.o
>>   CC      hw/pci/pci.o
>>   CC      hw/pci/pci_bridge.o
>>   CC      hw/pci/msix.o
>>   CC      hw/pci/msi.o
>>   CC      hw/pci/shpc.o
>>   CC      hw/pci/slotid_cap.o
>>   CC      hw/pci/pci_host.o
>>   CC      hw/pci/pcie_host.o
>>   CC      hw/pci/pcie.o
>>   CC      hw/pci/pcie_aer.o
>>   CC      hw/pci/pcie_port.o
>>   CC      hw/pci/pci-stub.o
>>   CC      hw/pcmcia/pcmcia.o
>>   CC      hw/scsi/scsi-disk.o
>>   CC      hw/scsi/scsi-generic.o
>>   CC      hw/scsi/scsi-bus.o
>>   CC      hw/scsi/lsi53c895a.o
>>   CC      hw/scsi/mptsas.o
>>   CC      hw/scsi/mptconfig.o
>>   CC      hw/scsi/mptendian.o
>>   CC      hw/scsi/megasas.o
>>   CC      hw/scsi/vmw_pvscsi.o
>>   CC      hw/scsi/esp.o
>>   CC      hw/scsi/esp-pci.o
>>   CC      hw/sd/pl181.o
>>   CC      hw/sd/ssi-sd.o
>>   CC      hw/sd/sd.o
>>   CC      hw/sd/core.o
>>   CC      hw/sd/sdhci.o
>>   CC      hw/smbios/smbios.o
>>   CC      hw/smbios/smbios_type_38.o
>>   CC      hw/smbios/smbios-stub.o
>>   CC      hw/smbios/smbios_type_38-stub.o
>>   CC      hw/ssi/pl022.o
>>   CC      hw/ssi/ssi.o
>>   CC      hw/ssi/xilinx_spips.o
>>   CC      hw/ssi/aspeed_smc.o
>>   CC      hw/ssi/stm32f2xx_spi.o
>>   CC      hw/ssi/mss-spi.o
>>   CC      hw/timer/arm_timer.o
>>   CC      hw/timer/arm_mptimer.o
>>   CC      hw/timer/armv7m_systick.o
>>   CC      hw/timer/a9gtimer.o
>>   CC      hw/timer/cadence_ttc.o
>>   CC      hw/timer/ds1338.o
>>   CC      hw/timer/hpet.o
>>   CC      hw/timer/i8254_common.o
>>   CC      hw/timer/i8254.o
>>   CC      hw/timer/pl031.o
>>   CC      hw/timer/twl92230.o
>>   CC      hw/timer/imx_epit.o
>>   CC      hw/timer/imx_gpt.o
>>   CC      hw/timer/stm32f2xx_timer.o
>>   CC      hw/timer/aspeed_timer.o
>>   CC      hw/timer/cmsdk-apb-timer.o
>>   CC      hw/timer/mss-timer.o
>>   CC      hw/tpm/tpm_tis.o
>>   CC      hw/tpm/tpm_passthrough.o
>>   CC      hw/tpm/tpm_util.o
>>   CC      hw/tpm/tpm_emulator.o
>>   CC      hw/usb/core.o
>>   CC      hw/usb/combined-packet.o
>>   CC      hw/usb/bus.o
>>   CC      hw/usb/libhw.o
>>   CC      hw/usb/desc.o
>>   CC      hw/usb/desc-msos.o
>>   CC      hw/usb/hcd-uhci.o
>>   CC      hw/usb/hcd-ohci.o
>>   CC      hw/usb/hcd-ehci.o
>>   CC      hw/usb/hcd-ehci-pci.o
>>   CC      hw/usb/hcd-ehci-sysbus.o
>>   CC      hw/usb/hcd-xhci.o
>>   CC      hw/usb/hcd-xhci-nec.o
>>   CC      hw/usb/hcd-musb.o
>>   CC      hw/usb/dev-hub.o
>>   CC      hw/usb/dev-hid.o
>>   CC      hw/usb/dev-wacom.o
>>   CC      hw/usb/dev-storage.o
>>   CC      hw/usb/dev-uas.o
>>   CC      hw/usb/dev-audio.o
>>   CC      hw/usb/dev-serial.o
>>   CC      hw/usb/dev-network.o
>>   CC      hw/usb/dev-bluetooth.o
>>   CC      hw/usb/dev-smartcard-reader.o
>>   CC      hw/usb/dev-mtp.o
>>   CC      hw/usb/host-stub.o
>>   CC      hw/virtio/virtio-rng.o
>>   CC      hw/virtio/virtio-pci.o
>>   CC      hw/virtio/virtio-bus.o
>>   CC      hw/virtio/virtio-mmio.o
>>   CC      hw/virtio/vhost-stub.o
>>   CC      hw/watchdog/watchdog.o
>>   CC      hw/watchdog/wdt_i6300esb.o
>>   CC      hw/watchdog/wdt_ib700.o
>>   CC      hw/watchdog/wdt_aspeed.o
>>   CC      migration/migration.o
>>   CC      migration/socket.o
>>   CC      migration/fd.o
>>   CC      migration/exec.o
>>   CC      migration/tls.o
>>   CC      migration/channel.o
>>   CC      migration/savevm.o
>>   CC      migration/colo-comm.o
>>   CC      migration/colo.o
>>   CC      migration/colo-failover.o
>>   CC      migration/vmstate.o
>>   CC      migration/vmstate-types.o
>>   CC      migration/page_cache.o
>>   CC      migration/qemu-file.o
>>   CC      migration/global_state.o
>>   CC      migration/qemu-file-channel.o
>>   CC      migration/xbzrle.o
>>   CC      migration/postcopy-ram.o
>>   CC      migration/qjson.o
>>   CC      migration/block.o
>>   CC      net/net.o
>>   CC      net/queue.o
>>   CC      net/checksum.o
>>   CC      net/util.o
>>   CC      net/hub.o
>>   CC      net/socket.o
>>   CC      net/dump.o
>>   CC      net/eth.o
>>   CC      net/l2tpv3.o
>>   CC      net/vhost-user.o
>>   CC      net/slirp.o
>>   CC      net/filter.o
>>   CC      net/filter-buffer.o
>>   CC      net/filter-mirror.o
>>   CC      net/colo-compare.o
>>   CC      net/colo.o
>>   CC      net/filter-rewriter.o
>>   CC      net/filter-replay.o
>>   CC      net/tap.o
>>   CC      net/tap-linux.o
>>   CC      qom/cpu.o
>>   CC      replay/replay.o
>>   CC      replay/replay-internal.o
>>   CC      replay/replay-events.o
>>   CC      replay/replay-time.o
>>   CC      replay/replay-input.o
>>   CC      replay/replay-char.o
>>   CC      replay/replay-snapshot.o
>>   CC      replay/replay-net.o
>> /tmp/qemu-test/src/replay/replay-internal.c: In function
>> 'replay_put_array':
>> /tmp/qemu-test/src/replay/replay-internal.c:65: warning: ignoring return
>> value of 'fwrite', declared with attribute warn_unused_result
>>   CC      replay/replay-audio.o
>>   CC      slirp/cksum.o
>>   CC      slirp/if.o
>>   CC      slirp/ip_icmp.o
>>   CC      slirp/ip6_icmp.o
>>   CC      slirp/ip6_input.o
>>   CC      slirp/ip6_output.o
>>   CC      slirp/ip_input.o
>>   CC      slirp/ip_output.o
>>   CC      slirp/dnssearch.o
>>   CC      slirp/dhcpv6.o
>>   CC      slirp/slirp.o
>>   CC      slirp/mbuf.o
>>   CC      slirp/misc.o
>>   CC      slirp/socket.o
>>   CC      slirp/sbuf.o
>>   CC      slirp/tcp_input.o
>>   CC      slirp/tcp_output.o
>>   CC      slirp/tcp_timer.o
>>   CC      slirp/tcp_subr.o
>>   CC      slirp/udp.o
>>   CC      slirp/udp6.o
>>   CC      slirp/bootp.o
>>   CC      slirp/tftp.o
>> /tmp/qemu-test/src/slirp/tcp_input.c: In function 'tcp_input':
>> /tmp/qemu-test/src/slirp/tcp_input.c:219: warning: 'save_ip.ip_p' may be
>> used uninitialized in this function
>> /tmp/qemu-test/src/slirp/tcp_input.c:219: warning: 'save_ip.ip_len' may =
be
>> used uninitialized in this function
>> /tmp/qemu-test/src/slirp/tcp_input.c:219: warning: 'save_ip.ip_tos' may =
be
>> used uninitialized in this function
>> /tmp/qemu-test/src/slirp/tcp_input.c:219: warning: 'save_ip.ip_id' may b=
e
>> used uninitialized in this function
>> /tmp/qemu-test/src/slirp/tcp_input.c:219: warning: 'save_ip.ip_off' may =
be
>> used uninitialized in this function
>> /tmp/qemu-test/src/slirp/tcp_input.c:219: warning: 'save_ip.ip_ttl' may =
be
>> used uninitialized in this function
>> /tmp/qemu-test/src/slirp/tcp_input.c:219: warning: 'save_ip.ip_sum' may =
be
>> used uninitialized in this function
>> /tmp/qemu-test/src/slirp/tcp_input.c:219: warning: 'save_ip.ip_src.s_add=
r'
>> may be used uninitialized in this function
>> /tmp/qemu-test/src/slirp/tcp_input.c:219: warning: 'save_ip.ip_dst.s_add=
r'
>> may be used uninitialized in this function
>> /tmp/qemu-test/src/slirp/tcp_input.c:220: warning: 'save_ip6.ip_nh' may =
be
>> used uninitialized in this function
>>   CC      slirp/arp_table.o
>>   CC      slirp/ndp_table.o
>>   CC      slirp/ncsi.o
>>   CC      ui/keymaps.o
>>   CC      ui/console.o
>>   CC      ui/cursor.o
>>   CC      ui/qemu-pixman.o
>>   CC      ui/input.o
>>   CC      ui/input-legacy.o
>>   CC      ui/input-keymap.o
>>   CC      ui/input-linux.o
>>   CC      ui/sdl.o
>>   CC      ui/sdl_zoom.o
>>   CC      ui/x_keymap.o
>>   CC      ui/vnc.o
>>   CC      ui/vnc-enc-zlib.o
>>   CC      ui/vnc-enc-hextile.o
>>   CC      ui/vnc-palette.o
>>   CC      ui/vnc-enc-tight.o
>>   CC      ui/vnc-enc-zrle.o
>>   CC      ui/vnc-auth-vencrypt.o
>>   CC      ui/vnc-ws.o
>>   CC      ui/vnc-jobs.o
>>   CC      chardev/char-fd.o
>>   CC      chardev/char.o
>>   CC      chardev/char-fe.o
>>   CC      chardev/char-file.o
>>   CC      chardev/char-io.o
>>   CC      chardev/char-mux.o
>>   CC      chardev/char-null.o
>>   CC      chardev/char-parallel.o
>>   CC      chardev/char-pipe.o
>>   CC      chardev/char-pty.o
>>   CC      chardev/char-ringbuf.o
>>   CC      chardev/char-serial.o
>>   CC      chardev/char-socket.o
>>   CC      chardev/char-stdio.o
>>   CC      chardev/char-udp.o
>>   LINK    tests/qemu-iotests/socket_scm_helper
>>   CC      qga/guest-agent-command-state.o
>>   CC      qga/commands.o
>>   CC      qga/main.o
>>   CC      qga/commands-posix.o
>>   CC      qga/channel-posix.o
>>   CC      qga/qapi-generated/qga-qapi-types.o
>>   CC      qga/qapi-generated/qga-qapi-visit.o
>>   CC      qga/qapi-generated/qga-qmp-marshal.o
>>   AR      libqemuutil.a
>>   CC      qemu-img.o
>>   AS      optionrom/multiboot.o
>>   AS      optionrom/linuxboot.o
>>   CC      optionrom/linuxboot_dma.o
>>   AS      optionrom/kvmvapic.o
>> cc: unrecognized option '-no-integrated-as'
>> cc: unrecognized option '-no-integrated-as'
>>   BUILD   optionrom/linuxboot_dma.img
>>   BUILD   optionrom/kvmvapic.img
>>   BUILD   optionrom/linuxboot.img
>>   BUILD   optionrom/multiboot.img
>>   BUILD   optionrom/linuxboot_dma.raw
>>   BUILD   optionrom/kvmvapic.raw
>>   SIGN    optionrom/linuxboot_dma.bin
>>   BUILD   optionrom/linuxboot.raw
>>   BUILD   optionrom/multiboot.raw
>>   SIGN    optionrom/linuxboot.bin
>>   SIGN    optionrom/kvmvapic.bin
>>   SIGN    optionrom/multiboot.bin
>>   LINK    qemu-ga
>>   LINK    ivshmem-client
>>   LINK    ivshmem-server
>>   LINK    qemu-nbd
>>   LINK    qemu-img
>>   LINK    qemu-io
>>   LINK    scsi/qemu-pr-helper
>>   LINK    qemu-bridge-helper
>>   GEN     x86_64-softmmu/hmp-commands.h
>>   GEN     x86_64-softmmu/config-target.h
>>   GEN     x86_64-softmmu/hmp-commands-info.h
>>   GEN     aarch64-softmmu/hmp-commands.h
>>   GEN     aarch64-softmmu/hmp-commands-info.h
>>   GEN     aarch64-softmmu/config-target.h
>>   CC      x86_64-softmmu/exec.o
>>   CC      x86_64-softmmu/tcg/tcg-op.o
>>   CC      x86_64-softmmu/tcg/tcg.o
>>   CC      aarch64-softmmu/exec.o
>>   CC      aarch64-softmmu/tcg/tcg.o
>>   CC      x86_64-softmmu/tcg/optimize.o
>>   CC      x86_64-softmmu/tcg/tcg-common.o
>>   CC      aarch64-softmmu/tcg/tcg-op.o
>>   CC      x86_64-softmmu/fpu/softfloat.o
>>   CC      aarch64-softmmu/tcg/optimize.o
>>   CC      x86_64-softmmu/disas.o
>>   GEN     x86_64-softmmu/gdbstub-xml.c
>>   CC      x86_64-softmmu/arch_init.o
>>   CC      x86_64-softmmu/cpus.o
>>   CC      x86_64-softmmu/monitor.o
>>   CC      x86_64-softmmu/gdbstub.o
>>   CC      x86_64-softmmu/balloon.o
>>   CC      x86_64-softmmu/ioport.o
>>   CC      aarch64-softmmu/tcg/tcg-common.o
>>   CC      x86_64-softmmu/numa.o
>>   CC      x86_64-softmmu/qtest.o
>>   CC      aarch64-softmmu/fpu/softfloat.o
>>   CC      x86_64-softmmu/memory.o
>>   CC      x86_64-softmmu/memory_mapping.o
>>   CC      x86_64-softmmu/dump.o
>>   CC      aarch64-softmmu/disas.o
>>   CC      x86_64-softmmu/migration/ram.o
>>   CC      x86_64-softmmu/accel/accel.o
>>   GEN     aarch64-softmmu/gdbstub-xml.c
>>   CC      x86_64-softmmu/accel/kvm/kvm-all.o
>>   CC      x86_64-softmmu/accel/stubs/hax-stub.o
>>   CC      aarch64-softmmu/arch_init.o
>>   CC      x86_64-softmmu/accel/tcg/tcg-all.o
>>   CC      x86_64-softmmu/accel/tcg/cputlb.o
>>   CC      x86_64-softmmu/accel/tcg/tcg-runtime.o
>>   CC      x86_64-softmmu/accel/tcg/cpu-exec.o
>>   CC      x86_64-softmmu/accel/tcg/cpu-exec-common.o
>>   CC      x86_64-softmmu/accel/tcg/translate-all.o
>>   CC      x86_64-softmmu/accel/tcg/translator.o
>>   CC      x86_64-softmmu/hw/block/virtio-blk.o
>>   CC      aarch64-softmmu/cpus.o
>>   CC      x86_64-softmmu/hw/block/dataplane/virtio-blk.o
>>   CC      x86_64-softmmu/hw/char/virtio-serial-bus.o
>>   CC      x86_64-softmmu/hw/core/generic-loader.o
>>   CC      x86_64-softmmu/hw/core/null-machine.o
>>   CC      aarch64-softmmu/monitor.o
>>   CC      aarch64-softmmu/balloon.o
>>   CC      aarch64-softmmu/gdbstub.o
>>   CC      x86_64-softmmu/hw/display/vga.o
>>   CC      aarch64-softmmu/ioport.o
>>   CC      x86_64-softmmu/hw/display/virtio-gpu.o
>>   CC      x86_64-softmmu/hw/display/virtio-gpu-3d.o
>>   CC      x86_64-softmmu/hw/display/virtio-gpu-pci.o
>>   CC      aarch64-softmmu/numa.o
>>   CC      aarch64-softmmu/qtest.o
>>   CC      x86_64-softmmu/hw/display/virtio-vga.o
>>   CC      aarch64-softmmu/memory.o
>>   CC      aarch64-softmmu/memory_mapping.o
>>   CC      x86_64-softmmu/hw/intc/apic.o
>>   CC      x86_64-softmmu/hw/intc/apic_common.o
>>   CC      aarch64-softmmu/dump.o
>>   CC      x86_64-softmmu/hw/intc/ioapic.o
>>   CC      x86_64-softmmu/hw/isa/lpc_ich9.o
>>   CC      aarch64-softmmu/migration/ram.o
>>   CC      aarch64-softmmu/accel/accel.o
>>   CC      x86_64-softmmu/hw/misc/vmport.o
>>   CC      x86_64-softmmu/hw/misc/ivshmem.o
>>   CC      aarch64-softmmu/accel/stubs/hax-stub.o
>>   CC      x86_64-softmmu/hw/misc/pvpanic.o
>>   CC      aarch64-softmmu/accel/stubs/kvm-stub.o
>>   CC      x86_64-softmmu/hw/misc/hyperv_testdev.o
>>   CC      x86_64-softmmu/hw/misc/mmio_interface.o
>>   CC      aarch64-softmmu/accel/tcg/tcg-all.o
>>   CC      x86_64-softmmu/hw/net/virtio-net.o
>>   CC      aarch64-softmmu/accel/tcg/cputlb.o
>>   CC      aarch64-softmmu/accel/tcg/tcg-runtime.o
>>   CC      x86_64-softmmu/hw/net/vhost_net.o
>>   CC      x86_64-softmmu/hw/scsi/virtio-scsi.o
>>   CC      x86_64-softmmu/hw/scsi/vhost-scsi-common.o
>>   CC      x86_64-softmmu/hw/scsi/virtio-scsi-dataplane.o
>>   CC      x86_64-softmmu/hw/scsi/vhost-scsi.o
>>   CC      aarch64-softmmu/accel/tcg/cpu-exec.o
>>   CC      x86_64-softmmu/hw/scsi/vhost-user-scsi.o
>>   CC      aarch64-softmmu/accel/tcg/cpu-exec-common.o
>>   CC      x86_64-softmmu/hw/timer/mc146818rtc.o
>>   CC      aarch64-softmmu/accel/tcg/translate-all.o
>>   CC      x86_64-softmmu/hw/vfio/common.o
>>   CC      x86_64-softmmu/hw/vfio/pci.o
>>   CC      aarch64-softmmu/accel/tcg/translator.o
>>   CC      x86_64-softmmu/hw/vfio/pci-quirks.o
>>   CC      x86_64-softmmu/hw/vfio/platform.o
>>   CC      x86_64-softmmu/hw/vfio/spapr.o
>>   CC      x86_64-softmmu/hw/virtio/virtio.o
>>   CC      x86_64-softmmu/hw/virtio/virtio-balloon.o
>>   CC      aarch64-softmmu/hw/adc/stm32f2xx_adc.o
>>   CC      x86_64-softmmu/hw/virtio/vhost.o
>>   CC      aarch64-softmmu/hw/block/virtio-blk.o
>>   CC      aarch64-softmmu/hw/block/dataplane/virtio-blk.o
>>   CC      x86_64-softmmu/hw/virtio/vhost-backend.o
>>   CC      aarch64-softmmu/hw/char/exynos4210_uart.o
>>   CC      aarch64-softmmu/hw/char/omap_uart.o
>>   CC      aarch64-softmmu/hw/char/digic-uart.o
>>   CC      x86_64-softmmu/hw/virtio/vhost-user.o
>>   CC      x86_64-softmmu/hw/virtio/vhost-vsock.o
>>   CC      aarch64-softmmu/hw/char/stm32f2xx_usart.o
>>   CC      x86_64-softmmu/hw/virtio/virtio-crypto.o
>>   CC      x86_64-softmmu/hw/virtio/virtio-crypto-pci.o
>>   CC      x86_64-softmmu/hw/i386/multiboot.o
>>   CC      aarch64-softmmu/hw/char/bcm2835_aux.o
>>   CC      aarch64-softmmu/hw/char/virtio-serial-bus.o
>>   CC      aarch64-softmmu/hw/core/generic-loader.o
>>   CC      aarch64-softmmu/hw/core/null-machine.o
>>   CC      x86_64-softmmu/hw/i386/pc.o
>>   CC      x86_64-softmmu/hw/i386/pc_q35.o
>>   CC      x86_64-softmmu/hw/i386/pc_piix.o
>>   CC      aarch64-softmmu/hw/cpu/arm11mpcore.o
>>   CC      aarch64-softmmu/hw/cpu/realview_mpcore.o
>>   CC      aarch64-softmmu/hw/cpu/a9mpcore.o
>>   CC      x86_64-softmmu/hw/i386/pc_sysfw.o
>>   CC      aarch64-softmmu/hw/cpu/a15mpcore.o
>>   CC      x86_64-softmmu/hw/i386/x86-iommu.o
>>   CC      aarch64-softmmu/hw/display/omap_dss.o
>> /tmp/qemu-test/src/hw/i386/pc_piix.c: In function
>> 'igd_passthrough_isa_bridge_create':
>> /tmp/qemu-test/src/hw/i386/pc_piix.c:1073: warning: 'pch_rev_id' may be
>> used uninitialized in this function
>>   CC      x86_64-softmmu/hw/i386/intel_iommu.o
>>   CC      x86_64-softmmu/hw/i386/amd_iommu.o
>>   CC      aarch64-softmmu/hw/display/omap_lcdc.o
>>   CC      aarch64-softmmu/hw/display/pxa2xx_lcd.o
>>   CC      x86_64-softmmu/hw/i386/kvmvapic.o
>>   CC      aarch64-softmmu/hw/display/bcm2835_fb.o
>>   CC      aarch64-softmmu/hw/display/vga.o
>>   CC      aarch64-softmmu/hw/display/virtio-gpu.o
>>   CC      aarch64-softmmu/hw/display/virtio-gpu-3d.o
>>   CC      x86_64-softmmu/hw/i386/acpi-build.o
>>   CC      aarch64-softmmu/hw/display/virtio-gpu-pci.o
>>   CC      x86_64-softmmu/hw/i386/kvm/clock.o
>>   CC      aarch64-softmmu/hw/display/dpcd.o
>>   CC      aarch64-softmmu/hw/display/xlnx_dp.o
>>   CC      x86_64-softmmu/hw/i386/kvm/apic.o
>>   CC      x86_64-softmmu/hw/i386/kvm/i8259.o
>> /tmp/qemu-test/src/hw/i386/acpi-build.c: In function
>> 'build_append_pci_bus_devices':
>> /tmp/qemu-test/src/hw/i386/acpi-build.c:509: warning: 'notify_method' ma=
y
>> be used uninitialized in this function
>>   CC      x86_64-softmmu/hw/i386/kvm/ioapic.o
>>   CC      x86_64-softmmu/hw/i386/kvm/i8254.o
>>   CC      aarch64-softmmu/hw/dma/xlnx_dpdma.o
>>   CC      aarch64-softmmu/hw/dma/omap_dma.o
>>   CC      aarch64-softmmu/hw/dma/soc_dma.o
>>   CC      aarch64-softmmu/hw/dma/pxa2xx_dma.o
>>   CC      x86_64-softmmu/target/i386/helper.o
>>   CC      x86_64-softmmu/target/i386/cpu.o
>>   CC      x86_64-softmmu/target/i386/gdbstub.o
>>   CC      aarch64-softmmu/hw/dma/bcm2835_dma.o
>>   CC      aarch64-softmmu/hw/gpio/omap_gpio.o
>>   CC      aarch64-softmmu/hw/gpio/imx_gpio.o
>>   CC      x86_64-softmmu/target/i386/xsave_helper.o
>>   CC      aarch64-softmmu/hw/gpio/bcm2835_gpio.o
>>   CC      x86_64-softmmu/target/i386/translate.o
>>   CC      x86_64-softmmu/target/i386/bpt_helper.o
>>   CC      aarch64-softmmu/hw/i2c/omap_i2c.o
>>   CC      aarch64-softmmu/hw/input/pxa2xx_keypad.o
>>   CC      x86_64-softmmu/target/i386/cc_helper.o
>>   CC      x86_64-softmmu/target/i386/excp_helper.o
>>   CC      aarch64-softmmu/hw/input/tsc210x.o
>>   CC      x86_64-softmmu/target/i386/fpu_helper.o
>>   CC      aarch64-softmmu/hw/intc/armv7m_nvic.o
>>   CC      x86_64-softmmu/target/i386/int_helper.o
>>   CC      x86_64-softmmu/target/i386/mem_helper.o
>>   CC      x86_64-softmmu/target/i386/misc_helper.o
>>   CC      aarch64-softmmu/hw/intc/exynos4210_gic.o
>>   CC      x86_64-softmmu/target/i386/mpx_helper.o
>>   CC      x86_64-softmmu/target/i386/seg_helper.o
>>   CC      x86_64-softmmu/target/i386/smm_helper.o
>>   CC      aarch64-softmmu/hw/intc/exynos4210_combiner.o
>>   CC      x86_64-softmmu/target/i386/machine.o
>>   CC      aarch64-softmmu/hw/intc/omap_intc.o
>>   CC      x86_64-softmmu/target/i386/svm_helper.o
>>   CC      x86_64-softmmu/target/i386/arch_memory_mapping.o
>>   CC      aarch64-softmmu/hw/intc/bcm2835_ic.o
>>   CC      x86_64-softmmu/target/i386/arch_dump.o
>>   CC      aarch64-softmmu/hw/intc/bcm2836_control.o
>>   CC      x86_64-softmmu/target/i386/monitor.o
>>   CC      x86_64-softmmu/target/i386/kvm.o
>>   CC      aarch64-softmmu/hw/intc/allwinner-a10-pic.o
>>   CC      aarch64-softmmu/hw/intc/aspeed_vic.o
>>   CC      x86_64-softmmu/target/i386/hyperv.o
>>   CC      aarch64-softmmu/hw/intc/arm_gicv3_cpuif.o
>>   CC      aarch64-softmmu/hw/misc/ivshmem.o
>>   GEN     trace/generated-helpers.c
>>   CC      aarch64-softmmu/hw/misc/cbus.o
>>   CC      aarch64-softmmu/hw/misc/arm_sysctl.o
>>   CC      aarch64-softmmu/hw/misc/exynos4210_pmu.o
>>   CC      x86_64-softmmu/trace/control-target.o
>>   CC      aarch64-softmmu/hw/misc/exynos4210_clk.o
>>   CC      x86_64-softmmu/gdbstub-xml.o
>>   CC      aarch64-softmmu/hw/misc/exynos4210_rng.o
>>   CC      aarch64-softmmu/hw/misc/imx31_ccm.o
>>   CC      aarch64-softmmu/hw/misc/imx_ccm.o
>>   CC      aarch64-softmmu/hw/misc/imx25_ccm.o
>>   CC      aarch64-softmmu/hw/misc/imx6_ccm.o
>>   CC      aarch64-softmmu/hw/misc/imx6_src.o
>>   CC      aarch64-softmmu/hw/misc/mst_fpga.o
>>   CC      x86_64-softmmu/trace/generated-helpers.o
>>   CC      aarch64-softmmu/hw/misc/omap_clk.o
>>   CC      aarch64-softmmu/hw/misc/omap_gpmc.o
>>   CC      aarch64-softmmu/hw/misc/omap_l4.o
>>   CC      aarch64-softmmu/hw/misc/omap_sdrc.o
>>   CC      aarch64-softmmu/hw/misc/omap_tap.o
>>   CC      aarch64-softmmu/hw/misc/bcm2835_mbox.o
>>   CC      aarch64-softmmu/hw/misc/bcm2835_property.o
>>   CC      aarch64-softmmu/hw/misc/bcm2835_rng.o
>>   CC      aarch64-softmmu/hw/misc/zynq_slcr.o
>>   CC      aarch64-softmmu/hw/misc/zynq-xadc.o
>>   CC      aarch64-softmmu/hw/misc/stm32f2xx_syscfg.o
>>   CC      aarch64-softmmu/hw/misc/mps2-scc.o
>>   CC      aarch64-softmmu/hw/misc/auxbus.o
>>   LINK    x86_64-softmmu/qemu-system-x86_64
>>   CC      aarch64-softmmu/hw/misc/aspeed_scu.o
>>   CC      aarch64-softmmu/hw/misc/aspeed_sdmc.o
>>   CC      aarch64-softmmu/hw/misc/mmio_interface.o
>>   CC      aarch64-softmmu/hw/misc/msf2-sysreg.o
>>   CC      aarch64-softmmu/hw/net/virtio-net.o
>>   CC      aarch64-softmmu/hw/net/vhost_net.o
>>   CC      aarch64-softmmu/hw/pcmcia/pxa2xx.o
>>   CC      aarch64-softmmu/hw/scsi/virtio-scsi-dataplane.o
>>   CC      aarch64-softmmu/hw/scsi/virtio-scsi.o
>>   CC      aarch64-softmmu/hw/scsi/vhost-scsi-common.o
>>   CC      aarch64-softmmu/hw/scsi/vhost-scsi.o
>>   CC      aarch64-softmmu/hw/scsi/vhost-user-scsi.o
>>   CC      aarch64-softmmu/hw/sd/omap_mmc.o
>>   CC      aarch64-softmmu/hw/sd/pxa2xx_mmci.o
>>   CC      aarch64-softmmu/hw/sd/bcm2835_sdhost.o
>>   CC      aarch64-softmmu/hw/ssi/omap_spi.o
>>   CC      aarch64-softmmu/hw/ssi/imx_spi.o
>>   CC      aarch64-softmmu/hw/timer/exynos4210_mct.o
>>   CC      aarch64-softmmu/hw/timer/exynos4210_pwm.o
>>   CC      aarch64-softmmu/hw/timer/exynos4210_rtc.o
>>   CC      aarch64-softmmu/hw/timer/omap_gptimer.o
>>   CC      aarch64-softmmu/hw/timer/omap_synctimer.o
>>   CC      aarch64-softmmu/hw/timer/pxa2xx_timer.o
>>   CC      aarch64-softmmu/hw/timer/digic-timer.o
>>   CC      aarch64-softmmu/hw/timer/allwinner-a10-pit.o
>>   CC      aarch64-softmmu/hw/usb/tusb6010.o
>>   CC      aarch64-softmmu/hw/vfio/common.o
>>   CC      aarch64-softmmu/hw/vfio/pci.o
>>   CC      aarch64-softmmu/hw/vfio/pci-quirks.o
>>   CC      aarch64-softmmu/hw/vfio/platform.o
>>   CC      aarch64-softmmu/hw/vfio/calxeda-xgmac.o
>>   CC      aarch64-softmmu/hw/vfio/amd-xgbe.o
>>   CC      aarch64-softmmu/hw/vfio/spapr.o
>>   CC      aarch64-softmmu/hw/virtio/virtio.o
>>   CC      aarch64-softmmu/hw/virtio/virtio-balloon.o
>>   CC      aarch64-softmmu/hw/virtio/vhost.o
>>   CC      aarch64-softmmu/hw/virtio/vhost-backend.o
>>   CC      aarch64-softmmu/hw/virtio/vhost-user.o
>>   CC      aarch64-softmmu/hw/virtio/vhost-vsock.o
>>   CC      aarch64-softmmu/hw/virtio/virtio-crypto.o
>>   CC      aarch64-softmmu/hw/virtio/virtio-crypto-pci.o
>>   CC      aarch64-softmmu/hw/arm/boot.o
>>   CC      aarch64-softmmu/hw/arm/collie.o
>>   CC      aarch64-softmmu/hw/arm/exynos4_boards.o
>>   CC      aarch64-softmmu/hw/arm/gumstix.o
>>   CC      aarch64-softmmu/hw/arm/highbank.o
>>   CC      aarch64-softmmu/hw/arm/digic_boards.o
>>   CC      aarch64-softmmu/hw/arm/integratorcp.o
>>   CC      aarch64-softmmu/hw/arm/mainstone.o
>>   CC      aarch64-softmmu/hw/arm/musicpal.o
>>   CC      aarch64-softmmu/hw/arm/nseries.o
>>   CC      aarch64-softmmu/hw/arm/omap_sx1.o
>>   CC      aarch64-softmmu/hw/arm/palm.o
>>   CC      aarch64-softmmu/hw/arm/realview.o
>>   CC      aarch64-softmmu/hw/arm/spitz.o
>>   CC      aarch64-softmmu/hw/arm/stellaris.o
>>   CC      aarch64-softmmu/hw/arm/tosa.o
>>   CC      aarch64-softmmu/hw/arm/vexpress.o
>>   CC      aarch64-softmmu/hw/arm/versatilepb.o
>>   CC      aarch64-softmmu/hw/arm/virt.o
>>   CC      aarch64-softmmu/hw/arm/xilinx_zynq.o
>>   CC      aarch64-softmmu/hw/arm/virt-acpi-build.o
>>   CC      aarch64-softmmu/hw/arm/z2.o
>>   CC      aarch64-softmmu/hw/arm/netduino2.o
>>   CC      aarch64-softmmu/hw/arm/sysbus-fdt.o
>>   CC      aarch64-softmmu/hw/arm/armv7m.o
>>   CC      aarch64-softmmu/hw/arm/exynos4210.o
>>   CC      aarch64-softmmu/hw/arm/pxa2xx.o
>>   CC      aarch64-softmmu/hw/arm/pxa2xx_gpio.o
>>   CC      aarch64-softmmu/hw/arm/pxa2xx_pic.o
>>   CC      aarch64-softmmu/hw/arm/omap1.o
>>   CC      aarch64-softmmu/hw/arm/digic.o
>>   CC      aarch64-softmmu/hw/arm/omap2.o
>>   CC      aarch64-softmmu/hw/arm/strongarm.o
>>   CC      aarch64-softmmu/hw/arm/allwinner-a10.o
>>   CC      aarch64-softmmu/hw/arm/cubieboard.o
>>   CC      aarch64-softmmu/hw/arm/bcm2835_peripherals.o
>>   CC      aarch64-softmmu/hw/arm/bcm2836.o
>>   CC      aarch64-softmmu/hw/arm/raspi.o
>>   CC      aarch64-softmmu/hw/arm/stm32f205_soc.o
>>   CC      aarch64-softmmu/hw/arm/xlnx-zynqmp.o
>>   CC      aarch64-softmmu/hw/arm/xlnx-zcu102.o
>>   CC      aarch64-softmmu/hw/arm/fsl-imx25.o
>>   CC      aarch64-softmmu/hw/arm/imx25_pdk.o
>>   CC      aarch64-softmmu/hw/arm/kzm.o
>>   CC      aarch64-softmmu/hw/arm/fsl-imx31.o
>>   CC      aarch64-softmmu/hw/arm/fsl-imx6.o
>>   CC      aarch64-softmmu/hw/arm/sabrelite.o
>>   CC      aarch64-softmmu/hw/arm/aspeed_soc.o
>>   CC      aarch64-softmmu/hw/arm/aspeed.o
>>   CC      aarch64-softmmu/hw/arm/mps2.o
>>   CC      aarch64-softmmu/hw/arm/msf2-soc.o
>>   CC      aarch64-softmmu/hw/arm/msf2-som.o
>>   CC      aarch64-softmmu/target/arm/arm-semi.o
>>   CC      aarch64-softmmu/target/arm/machine.o
>>   CC      aarch64-softmmu/target/arm/psci.o
>>   CC      aarch64-softmmu/target/arm/arch_dump.o
>>   CC      aarch64-softmmu/target/arm/monitor.o
>>   CC      aarch64-softmmu/target/arm/kvm-stub.o
>>   CC      aarch64-softmmu/target/arm/translate.o
>>   CC      aarch64-softmmu/target/arm/helper.o
>>   CC      aarch64-softmmu/target/arm/op_helper.o
>>   CC      aarch64-softmmu/target/arm/cpu.o
>>   CC      aarch64-softmmu/target/arm/neon_helper.o
>>   CC      aarch64-softmmu/target/arm/iwmmxt_helper.o
>>   CC      aarch64-softmmu/target/arm/gdbstub.o
>>   CC      aarch64-softmmu/target/arm/cpu64.o
>>   CC      aarch64-softmmu/target/arm/translate-a64.o
>>   CC      aarch64-softmmu/target/arm/helper-a64.o
>>   CC      aarch64-softmmu/target/arm/gdbstub64.o
>>   CC      aarch64-softmmu/target/arm/crypto_helper.o
>>   CC      aarch64-softmmu/target/arm/arm-powerctl.o
>>   GEN     trace/generated-helpers.c
>>   CC      aarch64-softmmu/trace/control-target.o
>> /tmp/qemu-test/src/target/arm/translate-a64.c: In function
>> 'handle_shri_with_rndacc':
>> /tmp/qemu-test/src/target/arm/translate-a64.c:6392: warning: 'tcg_src_hi=
'
>> may be used uninitialized in this function
>> /tmp/qemu-test/src/target/arm/translate-a64.c: In function
>> 'disas_simd_scalar_two_reg_misc':
>> /tmp/qemu-test/src/target/arm/translate-a64.c:8119: warning: 'rmode' may
>> be used uninitialized in this function
>>   CC      aarch64-softmmu/gdbstub-xml.o
>>   CC      aarch64-softmmu/trace/generated-helpers.o
>>   LINK    aarch64-softmmu/qemu-system-aarch64
>> mkdir -p dtc/libfdt
>> mkdir -p dtc/tests
>>          LEX convert-dtsv0-lexer.lex.c
>> make[1]: flex: Command not found
>>          BISON dtc-parser.tab.c
>>          LEX dtc-lexer.lex.c
>> make[1]: flex: Command not found
>> make[1]: bison: Command not found
>> install -d -m 0755
>> "/tmp/qemu-test/build/=3Ddestdir/tmp/qemu-test/install/share/qemu"
>> install -d -m 0755
>> "/tmp/qemu-test/build/=3Ddestdir/tmp/qemu-test/install/var"/run
>> install -d -m 0755
>> "/tmp/qemu-test/build/=3Ddestdir/tmp/qemu-test/install/bin"
>> install -c -m 0755 qemu-ga ivshmem-client ivshmem-server qemu-nbd qemu-i=
mg
>> qemu-io  scsi/qemu-pr-helper
>> "/tmp/qemu-test/build/=3Ddestdir/tmp/qemu-test/install/bin"
>> strip "/tmp/qemu-test/build/=3Ddestdir/tmp/qemu-test/install/bin/qemu-ga=
"
>> "/tmp/qemu-test/build/=3Ddestdir/tmp/qemu-test/install/bin/ivshmem-clien=
t"
>> "/tmp/qemu-test/build/=3Ddestdir/tmp/qemu-test/install/bin/ivshmem-serve=
r"
>> "/tmp/qemu-test/build/=3Ddestdir/tmp/qemu-test/install/bin/qemu-nbd"
>> "/tmp/qemu-test/build/=3Ddestdir/tmp/qemu-test/install/bin/qemu-img"
>> "/tmp/qemu-test/build/=3Ddestdir/tmp/qemu-test/install/bin/qemu-io"
>> "/tmp/qemu-test/build/=3Ddestdir/tmp/qemu-test/install/bin/qemu-pr-helpe=
r"
>> install -d -m 0755
>> "/tmp/qemu-test/build/=3Ddestdir/tmp/qemu-test/install/libexec"
>> install -c -m 0755 qemu-bridge-helper
>> "/tmp/qemu-test/build/=3Ddestdir/tmp/qemu-test/install/libexec"
>> strip
>> "/tmp/qemu-test/build/=3Ddestdir/tmp/qemu-test/install/libexec/qemu-brid=
ge-helper"
>> set -e; for x in bios.bin bios-256k.bin sgabios.bin vgabios.bin
>> vgabios-cirrus.bin vgabios-stdvga.bin vgabios-vmware.bin vgabios-qxl.bin
>> vgabios-virtio.bin acpi-dsdt.aml ppc_rom.bin openbios-sparc32
>> openbios-sparc64 openbios-ppc QEMU,tcx.bin QEMU,cgthree.bin pxe-e1000.ro=
m
>> pxe-eepro100.rom pxe-ne2k_pci.rom pxe-pcnet.rom pxe-rtl8139.rom
>> pxe-virtio.rom efi-e1000.rom efi-eepro100.rom efi-ne2k_pci.rom efi-pcnet=
.rom
>> efi-rtl8139.rom efi-virtio.rom efi-e1000e.rom efi-vmxnet3.rom qemu-icon.=
bmp
>> qemu_logo_no_text.svg bamboo.dtb petalogix-s3adsp1800.dtb
>> petalogix-ml605.dtb multiboot.bin linuxboot.bin linuxboot_dma.bin
>> kvmvapic.bin s390-ccw.img s390-netboot.img spapr-rtas.bin slof.bin
>> skiboot.lid palcode-clipper u-boot.e500 qemu_vga.ndrv; do \
>>                 install -c -m 0644 /tmp/qemu-test/src/pc-bios/$x
>> "/tmp/qemu-test/build/=3Ddestdir/tmp/qemu-test/install/share/qemu"; \
>>         done
>> install -d -m 0755
>> "/tmp/qemu-test/build/=3Ddestdir/tmp/qemu-test/install/share/qemu/keymap=
s"
>> set -e; for x in da     en-gb  et  fr     fr-ch  is  lt  modifiers  no
>> pt-br  sv ar      de     en-us  fi  fr-be  hr     it  lv  nl         pl =
 ru
>> th common  de-ch  es     fo  fr-ca  hu     ja  mk  nl-be      pt  sl    =
 tr
>> bepo    cz; do \
>>                 install -c -m 0644 /tmp/qemu-test/src/pc-bios/keymaps/$x
>> "/tmp/qemu-test/build/=3Ddestdir/tmp/qemu-test/install/share/qemu/keymap=
s"; \
>>         done
>> install -c -m 0644 /tmp/qemu-test/build/trace-events-all
>> "/tmp/qemu-test/build/=3Ddestdir/tmp/qemu-test/install/share/qemu/trace-=
events-all"
>> for d in x86_64-softmmu aarch64-softmmu; do \
>>         make --no-print-directory BUILD_DIR=3D/tmp/qemu-test/build
>> TARGET_DIR=3D$d/ -C $d install || exit 1 ; \
>>         done
>> install -d -m 0755
>> "/tmp/qemu-test/build/=3Ddestdir/tmp/qemu-test/install/bin"
>> install -c -m 0755 qemu-system-x86_64
>> "/tmp/qemu-test/build/=3Ddestdir/tmp/qemu-test/install/bin"
>> strip
>> "/tmp/qemu-test/build/=3Ddestdir/tmp/qemu-test/install/bin/qemu-system-x=
86_64"
>> install -d -m 0755
>> "/tmp/qemu-test/build/=3Ddestdir/tmp/qemu-test/install/bin"
>> install -c -m 0755 qemu-system-aarch64
>> "/tmp/qemu-test/build/=3Ddestdir/tmp/qemu-test/install/bin"
>> strip
>> "/tmp/qemu-test/build/=3Ddestdir/tmp/qemu-test/install/bin/qemu-system-a=
arch64"
>>     CLEANUP
>> /var/tmp/patchew-tester-tmp-gmdmoybf/src/docker-src.2017-11-21-17.03.29.=
1957
>> make[1]: Leaving directory '/var/tmp/patchew-tester-tmp-gmdmoybf/src'
>>
>> real    1m50.519s
>> user    0m4.307s
>> sys     0m4.379s
>>   BUILD   fedora
>> make[1]: Entering directory '/var/tmp/patchew-tester-tmp-gmdmoybf/src'
>>   GEN
>> /var/tmp/patchew-tester-tmp-gmdmoybf/src/docker-src.2017-11-21-17.05.20.=
8528/qemu.tar
>> Cloning into
>> '/var/tmp/patchew-tester-tmp-gmdmoybf/src/docker-src.2017-11-21-17.05.20=
.8528/qemu.tar.vroot'...
>> done.
>> Checking out files:  37% (2099/5662)
>> Checking out files:  38% (2152/5662)
>> Checking out files:  39% (2209/5662)
>> Checking out files:  40% (2265/5662)
>> Checking out files:  41% (2322/5662)
>> Checking out files:  42% (2379/5662)
>> Checking out files:  43% (2435/5662)
>> Checking out files:  44% (2492/5662)
>> Checking out files:  45% (2548/5662)
>> Checking out files:  46% (2605/5662)
>> Checking out files:  47% (2662/5662)
>> Checking out files:  48% (2718/5662)
>> Checking out files:  49% (2775/5662)
>> Checking out files:  50% (2831/5662)
>> Checking out files:  51% (2888/5662)
>> Checking out files:  52% (2945/5662)
>> Checking out files:  53% (3001/5662)
>> Checking out files:  54% (3058/5662)
>> Checking out files:  55% (3115/5662)
>> Checking out files:  55% (3152/5662)
>> Checking out files:  56% (3171/5662)
>> Checking out files:  57% (3228/5662)
>> Checking out files:  58% (3284/5662)
>> Checking out files:  59% (3341/5662)
>> Checking out files:  60% (3398/5662)
>> Checking out files:  61% (3454/5662)
>> Checking out files:  62% (3511/5662)
>> Checking out files:  63% (3568/5662)
>> Checking out files:  64% (3624/5662)
>> Checking out files:  65% (3681/5662)
>> Checking out files:  66% (3737/5662)
>> Checking out files:  67% (3794/5662)
>> Checking out files:  68% (3851/5662)
>> Checking out files:  69% (3907/5662)
>> Checking out files:  70% (3964/5662)
>> Checking out files:  71% (4021/5662)
>> Checking out files:  72% (4077/5662)
>> Checking out files:  73% (4134/5662)
>> Checking out files:  74% (4190/5662)
>> Checking out files:  75% (4247/5662)
>> Checking out files:  76% (4304/5662)
>> Checking out files:  77% (4360/5662)
>> Checking out files:  78% (4417/5662)
>> Checking out files:  79% (4473/5662)
>> Checking out files:  80% (4530/5662)
>> Checking out files:  81% (4587/5662)
>> Checking out files:  82% (4643/5662)
>> Checking out files:  83% (4700/5662)
>> Checking out files:  84% (4757/5662)
>> Checking out files:  85% (4813/5662)
>> Checking out files:  86% (4870/5662)
>> Checking out files:  87% (4926/5662)
>> Checking out files:  88% (4983/5662)
>> Checking out files:  89% (5040/5662)
>> Checking out files:  90% (5096/5662)
>> Checking out files:  91% (5153/5662)
>> Checking out files:  92% (5210/5662)
>> Checking out files:  93% (5266/5662)
>> Checking out files:  94% (5323/5662)
>> Checking out files:  95% (5379/5662)
>> Checking out files:  96% (5436/5662)
>> Checking out files:  97% (5493/5662)
>> Checking out files:  98% (5549/5662)
>> Checking out files:  99% (5606/5662)
>> Checking out files: 100% (5662/5662)
>> Checking out files: 100% (5662/5662), done.
>> Your branch is up-to-date with 'origin/test'.
>> Submodule 'dtc' (git://git.qemu-project.org/dtc.git) registered for path
>> 'dtc'
>> Cloning into
>> '/var/tmp/patchew-tester-tmp-gmdmoybf/src/docker-src.2017-11-21-17.05.20=
.8528/qemu.tar.vroot/dtc'...
>> Submodule path 'dtc': checked out
>> '558cd81bdd432769b59bff01240c44f82cfb1a9d'
>> Submodule 'ui/keycodemapdb' (git://git.qemu.org/keycodemapdb.git)
>> registered for path 'ui/keycodemapdb'
>> Cloning into
>> '/var/tmp/patchew-tester-tmp-gmdmoybf/src/docker-src.2017-11-21-17.05.20=
.8528/qemu.tar.vroot/ui/keycodemapdb'...
>> Submodule path 'ui/keycodemapdb': checked out
>> '10739aa26051a5d49d88132604539d3ed085e72e'
>>   COPY    RUNNER
>>     RUN test-mingw in qemu:fedora
>> Packages installed:
>> PyYAML-3.11-13.fc25.x86_64
>> SDL-devel-1.2.15-21.fc24.x86_64
>> bc-1.06.95-16.fc24.x86_64
>> bison-3.0.4-4.fc24.x86_64
>> bzip2-1.0.6-21.fc25.x86_64
>> ccache-3.3.4-1.fc25.x86_64
>> clang-3.9.1-2.fc25.x86_64
>> findutils-4.6.0-8.fc25.x86_64
>> flex-2.6.0-3.fc25.x86_64
>> gcc-6.4.1-1.fc25.x86_64
>> gcc-c++-6.4.1-1.fc25.x86_64
>> gettext-0.19.8.1-3.fc25.x86_64
>> git-2.9.5-1.fc25.x86_64
>> glib2-devel-2.50.3-1.fc25.x86_64
>> hostname-3.15-8.fc25.x86_64
>> libaio-devel-0.3.110-6.fc24.x86_64
>> libfdt-devel-1.4.2-1.fc25.x86_64
>> make-4.1-6.fc25.x86_64
>> mingw32-SDL-1.2.15-7.fc24.noarch
>> mingw32-bzip2-1.0.6-7.fc24.noarch
>> mingw32-curl-7.47.0-1.fc24.noarch
>> mingw32-glib2-2.50.3-1.fc25.noarch
>> mingw32-gmp-6.1.1-1.fc25.noarch
>> mingw32-gnutls-3.5.5-2.fc25.noarch
>> mingw32-gtk2-2.24.31-2.fc25.noarch
>> mingw32-gtk3-3.22.17-1.fc25.noarch
>> mingw32-libjpeg-turbo-1.5.1-1.fc25.noarch
>> mingw32-libpng-1.6.27-1.fc25.noarch
>> mingw32-libssh2-1.4.3-5.fc24.noarch
>> mingw32-libtasn1-4.9-1.fc25.noarch
>> mingw32-nettle-3.3-1.fc25.noarch
>> mingw32-pixman-0.34.0-1.fc25.noarch
>> mingw32-pkg-config-0.28-6.fc24.x86_64
>> mingw64-SDL-1.2.15-7.fc24.noarch
>> mingw64-bzip2-1.0.6-7.fc24.noarch
>> mingw64-curl-7.47.0-1.fc24.noarch
>> mingw64-glib2-2.50.3-1.fc25.noarch
>> mingw64-gmp-6.1.1-1.fc25.noarch
>> mingw64-gnutls-3.5.5-2.fc25.noarch
>> mingw64-gtk2-2.24.31-2.fc25.noarch
>> mingw64-gtk3-3.22.17-1.fc25.noarch
>> mingw64-libjpeg-turbo-1.5.1-1.fc25.noarch
>> mingw64-libpng-1.6.27-1.fc25.noarch
>> mingw64-libssh2-1.4.3-5.fc24.noarch
>> mingw64-libtasn1-4.9-1.fc25.noarch
>> mingw64-nettle-3.3-1.fc25.noarch
>> mingw64-pixman-0.34.0-1.fc25.noarch
>> mingw64-pkg-config-0.28-6.fc24.x86_64
>> nettle-devel-3.3-1.fc25.x86_64
>> package python2 is not installed
>> perl-5.24.2-387.fc25.x86_64
>> pixman-devel-0.34.0-2.fc24.x86_64
>> sparse-0.5.0-10.fc25.x86_64
>> tar-1.29-3.fc25.x86_64
>> which-2.21-1.fc25.x86_64
>> zlib-devel-1.2.8-10.fc24.x86_64
>>
>> Environment variables:
>> PACKAGES=3Dccache gettext git tar PyYAML sparse flex bison python2 bzip2
>> hostname     glib2-devel pixman-devel zlib-devel SDL-devel libfdt-devel
>> gcc gcc-c++ clang make perl which bc findutils libaio-devel     nettle-d=
evel
>> mingw32-pixman mingw32-glib2 mingw32-gmp mingw32-SDL mingw32-pkg-config
>> mingw32-gtk2 mingw32-gtk3 mingw32-gnutls mingw32-nettle mingw32-libtasn1
>> mingw32-libjpeg-turbo mingw32-libpng mingw32-curl mingw32-libssh2
>> mingw32-bzip2     mingw64-pixman mingw64-glib2 mingw64-gmp mingw64-SDL
>> mingw64-pkg-config     mingw64-gtk2 mingw64-gtk3 mingw64-gnutls
>> mingw64-nettle mingw64-libtasn1     mingw64-libjpeg-turbo mingw64-libpng
>> mingw64-curl mingw64-libssh2     mingw64-bzip2
>> HOSTNAME=3Dc21f934af0c2
>> MAKEFLAGS=3D -j8
>> J=3D8
>> CCACHE_DIR=3D/var/tmp/ccache
>> EXTRA_CONFIGURE_OPTS=3D
>> V=3D
>> SHOW_ENV=3D1
>>
>> PATH=3D/usr/lib/ccache:/usr/lib64/ccache:/usr/local/sbin:/usr/local/bin:=
/usr/sbin:/usr/bin:/sbin:/bin
>> PWD=3D/
>> TARGET_LIST=3D
>> FGC=3Df25
>> SHLVL=3D1
>> HOME=3D/root
>> TEST_DIR=3D/tmp/qemu-test
>> DISTTAG=3Df25container
>> FEATURES=3Dmingw clang pyyaml dtc
>> DEBUG=3D
>> _=3D/usr/bin/env
>>
>> Configure options:
>> --enable-werror --target-list=3Dx86_64-softmmu,aarch64-softmmu
>> --prefix=3D/tmp/qemu-test/install --cross-prefix=3Dx86_64-w64-mingw32-
>> --enable-trace-backends=3Dsimple --enable-debug --enable-gnutls
>> --enable-nettle --enable-curl --enable-vnc --enable-bzip2
>> --enable-guest-agent --with-sdlabi=3D1.2 --with-gtkabi=3D2.0
>> Install prefix    /tmp/qemu-test/install
>> BIOS directory    /tmp/qemu-test/install
>> firmware path     /tmp/qemu-test/install/share/qemu-firmware
>> binary directory  /tmp/qemu-test/install
>> library directory /tmp/qemu-test/install/lib
>> module directory  /tmp/qemu-test/install/lib
>> libexec directory /tmp/qemu-test/install/libexec
>> include directory /tmp/qemu-test/install/include
>> config directory  /tmp/qemu-test/install
>> local state directory   queried at runtime
>> Windows SDK       no
>> Source path       /tmp/qemu-test/src
>> GIT binary        git
>> GIT submodules
>> C compiler        x86_64-w64-mingw32-gcc
>> Host C compiler   cc
>> C++ compiler      x86_64-w64-mingw32-g++
>> Objective-C compiler clang
>> ARFLAGS           rv
>> CFLAGS            -g
>> QEMU_CFLAGS
>> -I/usr/x86_64-w64-mingw32/sys-root/mingw/include/pixman-1
>> -I$(SRC_PATH)/dtc/libfdt -Werror -mms-bitfields
>> -I/usr/x86_64-w64-mingw32/sys-root/mingw/include/glib-2.0
>> -I/usr/x86_64-w64-mingw32/sys-root/mingw/lib/glib-2.0/include
>> -I/usr/x86_64-w64-mingw32/sys-root/mingw/include  -m64 -mcx16 -mthreads
>> -D__USE_MINGW_ANSI_STDIO=3D1 -DWIN32_LEAN_AND_MEAN -DWINVER=3D0x501
>> -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -Wstrict-prot=
otypes
>> -Wredundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-prototypes
>> -fno-strict-aliasing -fno-common -fwrapv  -Wendif-labels
>> -Wno-shift-negative-value -Wno-missing-include-dirs -Wempty-body
>> -Wnested-externs -Wformat-security -Wformat-y2k -Winit-self
>> -Wignored-qualifiers -Wold-style-declaration -Wold-style-definition
>> -Wtype-limits -fstack-protector-strong
>> -I/usr/x86_64-w64-mingw32/sys-root/mingw/include
>> -I/usr/x86_64-w64-mingw32/sys-root/mingw/include/p11-kit-1
>> -I/usr/x86_64-w64-mingw32/sys-root/mingw/include
>> -I/usr/x86_64-w64-mingw32/sys-root/mingw/include
>> -I/usr/x86_64-w64-mingw32/sys-root/mingw/include/libpng16
>> LDFLAGS           -Wl,--nxcompat -Wl,--no-seh -Wl,--dynamicbase
>> -Wl,--warn-common -m64 -g
>> make              make
>> install           install
>> python            python -B
>> smbd              /usr/sbin/smbd
>> module support    no
>> host CPU          x86_64
>> host big endian   no
>> target list       x86_64-softmmu aarch64-softmmu
>> gprof enabled     no
>> sparse enabled    no
>> strip binaries    no
>> profiler          no
>> static build      no
>> SDL support       yes (1.2.15)
>> GTK support       yes (2.24.31)
>> GTK GL support    no
>> VTE support       no
>> TLS priority      NORMAL
>> GNUTLS support    yes
>> GNUTLS rnd        yes
>> libgcrypt         no
>> libgcrypt kdf     no
>> nettle            yes (3.3)
>> nettle kdf        yes
>> libtasn1          yes
>> curses support    no
>> virgl support     no
>> curl support      yes
>> mingw32 support   yes
>> Audio drivers     dsound
>> Block whitelist (rw)
>> Block whitelist (ro)
>> VirtFS support    no
>> Multipath support no
>> VNC support       yes
>> VNC SASL support  no
>> VNC JPEG support  yes
>> VNC PNG support   yes
>> xen support       no
>> brlapi support    no
>> bluez  support    no
>> Documentation     no
>> PIE               no
>> vde support       no
>> netmap support    no
>> Linux AIO support no
>> ATTR/XATTR support no
>> Install blobs     yes
>> KVM support       no
>> HAX support       yes
>> TCG support       yes
>> TCG debug enabled yes
>> TCG interpreter   no
>> RDMA support      no
>> fdt support       yes
>> preadv support    no
>> fdatasync         no
>> madvise           no
>> posix_madvise     no
>> libcap-ng support no
>> vhost-net support no
>> vhost-scsi support no
>> vhost-vsock support no
>> vhost-user support no
>> Trace backends    simple
>> Trace output file trace-<pid>
>> spice support     no
>> rbd support       no
>> xfsctl support    no
>> smartcard support no
>> libusb            no
>> usb net redir     no
>> OpenGL support    no
>> OpenGL dmabufs    no
>> libiscsi support  no
>> libnfs support    no
>> build guest agent yes
>> QGA VSS support   no
>> QGA w32 disk info yes
>> QGA MSI support   no
>> seccomp support   no
>> coroutine backend win32
>> coroutine pool    yes
>> debug stack usage no
>> crypto afalg      no
>> GlusterFS support no
>> gcov              gcov
>> gcov enabled      no
>> TPM support       yes
>> libssh2 support   yes
>> TPM passthrough   no
>> TPM emulator      no
>> QOM debugging     yes
>> Live block migration yes
>> lzo support       no
>> snappy support    no
>> bzip2 support     yes
>> NUMA host support no
>> tcmalloc support  no
>> jemalloc support  no
>> avx2 optimization yes
>> replication support yes
>> VxHS block device no
>> capstone          no
>> mkdir -p dtc/libfdt
>> mkdir -p dtc/tests
>>   GEN     x86_64-softmmu/config-devices.mak.tmp
>>   GEN     config-host.h
>>   GEN     aarch64-softmmu/config-devices.mak.tmp
>>   GEN     qemu-options.def
>>   GEN     qapi-types.h
>>   GEN     qmp-commands.h
>>   GEN     qapi-visit.h
>>   GEN     qapi-event.h
>>   GEN     x86_64-softmmu/config-devices.mak
>>   GEN     aarch64-softmmu/config-devices.mak
>>   GEN     qmp-marshal.c
>>   GEN     qapi-types.c
>>   GEN     qapi-visit.c
>>   GEN     qapi-event.c
>>   GEN     qmp-introspect.h
>>   GEN     qmp-introspect.c
>>   GEN     trace/generated-tcg-tracers.h
>>   GEN     trace/generated-helpers-wrappers.h
>>   GEN     trace/generated-helpers.h
>>   GEN     trace/generated-helpers.c
>>   GEN     module_block.h
>>   GEN     ui/input-keymap-linux-to-qcode.c
>>   GEN     ui/input-keymap-qcode-to-qnum.c
>>   GEN     ui/input-keymap-qnum-to-qcode.c
>>   GEN     tests/test-qapi-types.h
>>   GEN     tests/test-qapi-visit.h
>>   GEN     tests/test-qmp-commands.h
>>   GEN     tests/test-qapi-event.h
>>   GEN     tests/test-qmp-introspect.h
>>   GEN     trace-root.h
>>   GEN     util/trace.h
>>   GEN     crypto/trace.h
>>   GEN     io/trace.h
>>   GEN     migration/trace.h
>>   GEN     block/trace.h
>>   GEN     chardev/trace.h
>>   GEN     hw/block/trace.h
>>   GEN     hw/block/dataplane/trace.h
>>   GEN     hw/char/trace.h
>>   GEN     hw/intc/trace.h
>>   GEN     hw/net/trace.h
>>   GEN     hw/virtio/trace.h
>>   GEN     hw/audio/trace.h
>>   GEN     hw/misc/trace.h
>>   GEN     hw/usb/trace.h
>>   GEN     hw/scsi/trace.h
>>   GEN     hw/nvram/trace.h
>>   GEN     hw/display/trace.h
>>   GEN     hw/input/trace.h
>>   GEN     hw/timer/trace.h
>>   GEN     hw/dma/trace.h
>>   GEN     hw/sparc/trace.h
>>   GEN     hw/sd/trace.h
>>   GEN     hw/isa/trace.h
>>   GEN     hw/mem/trace.h
>>   GEN     hw/i386/trace.h
>>   GEN     hw/i386/xen/trace.h
>>   GEN     hw/9pfs/trace.h
>>   GEN     hw/ppc/trace.h
>>   GEN     hw/pci/trace.h
>>   GEN     hw/s390x/trace.h
>>   GEN     hw/vfio/trace.h
>>   GEN     hw/acpi/trace.h
>>   GEN     hw/arm/trace.h
>>   GEN     hw/alpha/trace.h
>>   GEN     hw/xen/trace.h
>>   GEN     hw/ide/trace.h
>>   GEN     ui/trace.h
>>   GEN     audio/trace.h
>>   GEN     net/trace.h
>>   GEN     target/arm/trace.h
>>   GEN     target/i386/trace.h
>>   GEN     target/mips/trace.h
>>   GEN     target/sparc/trace.h
>>   GEN     target/s390x/trace.h
>>   GEN     target/ppc/trace.h
>>   GEN     qom/trace.h
>>   GEN     linux-user/trace.h
>>   GEN     qapi/trace.h
>>   GEN     accel/tcg/trace.h
>>   GEN     accel/kvm/trace.h
>>   GEN     nbd/trace.h
>>   GEN     trace-root.c
>>   GEN     scsi/trace.h
>>   GEN     util/trace.c
>>   GEN     crypto/trace.c
>>   GEN     io/trace.c
>>   GEN     migration/trace.c
>>   GEN     block/trace.c
>>   GEN     chardev/trace.c
>>   GEN     hw/block/trace.c
>>   GEN     hw/block/dataplane/trace.c
>>   GEN     hw/char/trace.c
>>   GEN     hw/intc/trace.c
>>   GEN     hw/net/trace.c
>>   GEN     hw/virtio/trace.c
>>   GEN     hw/audio/trace.c
>>   GEN     hw/misc/trace.c
>>   GEN     hw/usb/trace.c
>>   GEN     hw/scsi/trace.c
>>   GEN     hw/nvram/trace.c
>>   GEN     hw/display/trace.c
>>   GEN     hw/input/trace.c
>>   GEN     hw/timer/trace.c
>>   GEN     hw/dma/trace.c
>>   GEN     hw/sparc/trace.c
>>   GEN     hw/sd/trace.c
>>   GEN     hw/isa/trace.c
>>   GEN     hw/mem/trace.c
>>   GEN     hw/i386/trace.c
>>   GEN     hw/i386/xen/trace.c
>>   GEN     hw/9pfs/trace.c
>>   GEN     hw/pci/trace.c
>>   GEN     hw/ppc/trace.c
>>   GEN     hw/s390x/trace.c
>>   GEN     hw/vfio/trace.c
>>   GEN     hw/acpi/trace.c
>>   GEN     hw/arm/trace.c
>>   GEN     hw/alpha/trace.c
>>   GEN     hw/xen/trace.c
>>   GEN     hw/ide/trace.c
>>   GEN     ui/trace.c
>>   GEN     audio/trace.c
>>   GEN     net/trace.c
>>   GEN     target/arm/trace.c
>>   GEN     target/i386/trace.c
>>   GEN     target/mips/trace.c
>>   GEN     target/sparc/trace.c
>>   GEN     target/s390x/trace.c
>>   GEN     target/ppc/trace.c
>>   GEN     qom/trace.c
>>   GEN     linux-user/trace.c
>>   GEN     qapi/trace.c
>>   GEN     accel/tcg/trace.c
>>   GEN     accel/kvm/trace.c
>>   GEN     nbd/trace.c
>>   GEN     scsi/trace.c
>>   GEN     config-all-devices.mak
>>          DEP /tmp/qemu-test/src/dtc/tests/dumptrees.c
>>          DEP /tmp/qemu-test/src/dtc/tests/trees.S
>>          DEP /tmp/qemu-test/src/dtc/tests/testutils.c
>>          DEP /tmp/qemu-test/src/dtc/tests/value-labels.c
>>          DEP /tmp/qemu-test/src/dtc/tests/truncated_property.c
>>          DEP /tmp/qemu-test/src/dtc/tests/check_path.c
>>          DEP /tmp/qemu-test/src/dtc/tests/overlay_bad_fixup.c
>>          DEP /tmp/qemu-test/src/dtc/tests/asm_tree_dump.c
>>          DEP /tmp/qemu-test/src/dtc/tests/overlay.c
>>          DEP /tmp/qemu-test/src/dtc/tests/subnode_iterate.c
>>          DEP /tmp/qemu-test/src/dtc/tests/property_iterate.c
>>          DEP /tmp/qemu-test/src/dtc/tests/integer-expressions.c
>>          DEP /tmp/qemu-test/src/dtc/tests/utilfdt_test.c
>>          DEP /tmp/qemu-test/src/dtc/tests/path_offset_aliases.c
>>          DEP /tmp/qemu-test/src/dtc/tests/add_subnode_with_nops.c
>>          DEP /tmp/qemu-test/src/dtc/tests/dtbs_equal_unordered.c
>>          DEP /tmp/qemu-test/src/dtc/tests/dtb_reverse.c
>>          DEP /tmp/qemu-test/src/dtc/tests/dtbs_equal_ordered.c
>>          DEP /tmp/qemu-test/src/dtc/tests/extra-terminating-null.c
>>          DEP /tmp/qemu-test/src/dtc/tests/incbin.c
>>          DEP /tmp/qemu-test/src/dtc/tests/boot-cpuid.c
>>          DEP /tmp/qemu-test/src/dtc/tests/phandle_format.c
>>          DEP /tmp/qemu-test/src/dtc/tests/references.c
>>          DEP /tmp/qemu-test/src/dtc/tests/path-references.c
>>          DEP /tmp/qemu-test/src/dtc/tests/string_escapes.c
>>          DEP /tmp/qemu-test/src/dtc/tests/propname_escapes.c
>>          DEP /tmp/qemu-test/src/dtc/tests/appendprop1.c
>>          DEP /tmp/qemu-test/src/dtc/tests/appendprop2.c
>>          DEP /tmp/qemu-test/src/dtc/tests/del_node.c
>>          DEP /tmp/qemu-test/src/dtc/tests/del_property.c
>>          DEP /tmp/qemu-test/src/dtc/tests/setprop.c
>>          DEP /tmp/qemu-test/src/dtc/tests/set_name.c
>>          DEP /tmp/qemu-test/src/dtc/tests/rw_tree1.c
>>          DEP /tmp/qemu-test/src/dtc/tests/open_pack.c
>>          DEP /tmp/qemu-test/src/dtc/tests/nopulate.c
>>          DEP /tmp/qemu-test/src/dtc/tests/mangle-layout.c
>>          DEP /tmp/qemu-test/src/dtc/tests/move_and_save.c
>>          DEP /tmp/qemu-test/src/dtc/tests/sw_tree1.c
>>          DEP /tmp/qemu-test/src/dtc/tests/nop_property.c
>>          DEP /tmp/qemu-test/src/dtc/tests/nop_node.c
>>          DEP /tmp/qemu-test/src/dtc/tests/setprop_inplace.c
>>          DEP /tmp/qemu-test/src/dtc/tests/stringlist.c
>>          DEP /tmp/qemu-test/src/dtc/tests/addr_size_cells.c
>>          DEP /tmp/qemu-test/src/dtc/tests/notfound.c
>>          DEP /tmp/qemu-test/src/dtc/tests/char_literal.c
>>          DEP /tmp/qemu-test/src/dtc/tests/sized_cells.c
>>          DEP /tmp/qemu-test/src/dtc/tests/get_alias.c
>>          DEP /tmp/qemu-test/src/dtc/tests/node_offset_by_compatible.c
>>          DEP /tmp/qemu-test/src/dtc/tests/node_check_compatible.c
>>          DEP /tmp/qemu-test/src/dtc/tests/node_offset_by_phandle.c
>>          DEP /tmp/qemu-test/src/dtc/tests/node_offset_by_prop_value.c
>>          DEP /tmp/qemu-test/src/dtc/tests/parent_offset.c
>>          DEP /tmp/qemu-test/src/dtc/tests/supernode_atdepth_offset.c
>>          DEP /tmp/qemu-test/src/dtc/tests/get_path.c
>>          DEP /tmp/qemu-test/src/dtc/tests/get_phandle.c
>>          DEP /tmp/qemu-test/src/dtc/tests/getprop.c
>>          DEP /tmp/qemu-test/src/dtc/tests/get_name.c
>>          DEP /tmp/qemu-test/src/dtc/tests/path_offset.c
>>          DEP /tmp/qemu-test/src/dtc/tests/subnode_offset.c
>>          DEP /tmp/qemu-test/src/dtc/tests/find_property.c
>>          DEP /tmp/qemu-test/src/dtc/tests/root_node.c
>>          DEP /tmp/qemu-test/src/dtc/tests/get_mem_rsv.c
>>          DEP /tmp/qemu-test/src/dtc/libfdt/fdt_overlay.c
>>          DEP /tmp/qemu-test/src/dtc/libfdt/fdt_addresses.c
>>          DEP /tmp/qemu-test/src/dtc/libfdt/fdt_empty_tree.c
>>          DEP /tmp/qemu-test/src/dtc/libfdt/fdt_strerror.c
>>          DEP /tmp/qemu-test/src/dtc/libfdt/fdt_sw.c
>>          DEP /tmp/qemu-test/src/dtc/libfdt/fdt_rw.c
>>          DEP /tmp/qemu-test/src/dtc/libfdt/fdt_wip.c
>>          DEP /tmp/qemu-test/src/dtc/libfdt/fdt_ro.c
>>          DEP /tmp/qemu-test/src/dtc/util.c
>>          DEP /tmp/qemu-test/src/dtc/libfdt/fdt.c
>>          DEP /tmp/qemu-test/src/dtc/fdtdump.c
>>          LEX convert-dtsv0-lexer.lex.c
>>          DEP /tmp/qemu-test/src/dtc/fdtput.c
>>          DEP /tmp/qemu-test/src/dtc/srcpos.c
>>          DEP /tmp/qemu-test/src/dtc/fdtget.c
>>          BISON dtc-parser.tab.c
>>          LEX dtc-lexer.lex.c
>>          DEP /tmp/qemu-test/src/dtc/treesource.c
>>          DEP /tmp/qemu-test/src/dtc/livetree.c
>>          DEP /tmp/qemu-test/src/dtc/fstree.c
>>          DEP /tmp/qemu-test/src/dtc/flattree.c
>>          DEP /tmp/qemu-test/src/dtc/dtc.c
>>          DEP /tmp/qemu-test/src/dtc/data.c
>>          DEP /tmp/qemu-test/src/dtc/checks.c
>>          DEP convert-dtsv0-lexer.lex.c
>>          DEP dtc-parser.tab.c
>>          DEP dtc-lexer.lex.c
>>         CHK version_gen.h
>>         UPD version_gen.h
>>          DEP /tmp/qemu-test/src/dtc/util.c
>>          CC libfdt/fdt.o
>>          CC libfdt/fdt_ro.o
>>          CC libfdt/fdt_wip.o
>>          CC libfdt/fdt_rw.o
>>          CC libfdt/fdt_sw.o
>>          CC libfdt/fdt_strerror.o
>>          CC libfdt/fdt_empty_tree.o
>>          CC libfdt/fdt_addresses.o
>>          CC libfdt/fdt_overlay.o
>>          AR libfdt/libfdt.a
>> x86_64-w64-mingw32-ar: creating libfdt/libfdt.a
>> a - libfdt/fdt.o
>> a - libfdt/fdt_ro.o
>> a - libfdt/fdt_wip.o
>> a - libfdt/fdt_sw.o
>> a - libfdt/fdt_rw.o
>> a - libfdt/fdt_strerror.o
>> a - libfdt/fdt_empty_tree.o
>> a - libfdt/fdt_addresses.o
>> a - libfdt/fdt_overlay.o
>>   RC      version.o
>> mkdir -p dtc/libfdt
>> mkdir -p dtc/tests
>>   GEN     qga/qapi-generated/qga-qapi-types.h
>>   GEN     qga/qapi-generated/qga-qmp-commands.h
>>   GEN     qga/qapi-generated/qga-qapi-visit.h
>>   GEN     qga/qapi-generated/qga-qapi-visit.c
>>   GEN     qga/qapi-generated/qga-qmp-marshal.c
>>   GEN     qga/qapi-generated/qga-qapi-types.c
>>   CC      qmp-introspect.o
>>   CC      qapi-types.o
>>   CC      qapi-visit.o
>>   CC      qapi-event.o
>>   CC      qapi/qapi-visit-core.o
>>   CC      qapi/qobject-input-visitor.o
>>   CC      qapi/qapi-dealloc-visitor.o
>>   CC      qapi/qmp-registry.o
>>   CC      qapi/qobject-output-visitor.o
>>   CC      qapi/qmp-dispatch.o
>>   CC      qapi/string-input-visitor.o
>>   CC      qapi/string-output-visitor.o
>>   CC      qapi/opts-visitor.o
>>   CC      qapi/qapi-clone-visitor.o
>>   CC      qapi/qmp-event.o
>>   CC      qapi/qapi-util.o
>>   CC      qobject/qnull.o
>>   CC      qobject/qnum.o
>>   CC      qobject/qdict.o
>>   CC      qobject/qstring.o
>>   CC      qobject/qlist.o
>>   CC      qobject/qbool.o
>>   CC      qobject/qlit.o
>>   CC      qobject/qjson.o
>>   CC      qobject/qobject.o
>>   CC      qobject/json-lexer.o
>>   CC      qobject/json-streamer.o
>>   CC      trace/simple.o
>>   CC      trace/control.o
>>   CC      qobject/json-parser.o
>>   CC      trace/qmp.o
>>   CC      util/cutils.o
>>   CC      util/osdep.o
>>   CC      util/unicode.o
>>   CC      util/qemu-timer-common.o
>>   CC      util/bufferiszero.o
>>   CC      util/lockcnt.o
>>   CC      util/aiocb.o
>>   CC      util/async.o
>>   CC      util/thread-pool.o
>>   CC      util/qemu-timer.o
>>   CC      util/iohandler.o
>>   CC      util/main-loop.o
>>   CC      util/aio-win32.o
>>   CC      util/event_notifier-win32.o
>>   CC      util/oslib-win32.o
>>   CC      util/qemu-thread-win32.o
>>   CC      util/envlist.o
>>   CC      util/path.o
>>   CC      util/module.o
>>   CC      util/host-utils.o
>>   CC      util/bitmap.o
>>   CC      util/bitops.o
>>   CC      util/hbitmap.o
>>   CC      util/fifo8.o
>>   CC      util/acl.o
>>   CC      util/cacheinfo.o
>>   CC      util/error.o
>>   CC      util/qemu-error.o
>>   CC      util/id.o
>>   CC      util/iov.o
>>   CC      util/qemu-config.o
>>   CC      util/qemu-sockets.o
>>   CC      util/uri.o
>>   CC      util/notify.o
>>   CC      util/qemu-option.o
>>   CC      util/qemu-progress.o
>>   CC      util/keyval.o
>>   CC      util/hexdump.o
>>   CC      util/crc32c.o
>>   CC      util/uuid.o
>>   CC      util/throttle.o
>>   CC      util/readline.o
>>   CC      util/getauxval.o
>>   CC      util/rcu.o
>>   CC      util/qemu-coroutine.o
>>   CC      util/qemu-coroutine-lock.o
>>   CC      util/qemu-coroutine-sleep.o
>>   CC      util/qemu-coroutine-io.o
>>   CC      util/coroutine-win32.o
>>   CC      util/buffer.o
>>   CC      util/timed-average.o
>>   CC      util/base64.o
>>   CC      util/log.o
>>   CC      util/pagesize.o
>>   CC      util/qht.o
>>   CC      util/qdist.o
>>   CC      util/range.o
>>   CC      util/stats64.o
>>   CC      trace-root.o
>>   CC      util/systemd.o
>>   CC      util/trace.o
>>   CC      io/trace.o
>>   CC      crypto/trace.o
>>   CC      migration/trace.o
>>   CC      block/trace.o
>>   CC      chardev/trace.o
>>   CC      hw/block/trace.o
>>   CC      hw/block/dataplane/trace.o
>>   CC      hw/char/trace.o
>>   CC      hw/intc/trace.o
>>   CC      hw/net/trace.o
>>   CC      hw/virtio/trace.o
>>   CC      hw/audio/trace.o
>>   CC      hw/misc/trace.o
>>   CC      hw/usb/trace.o
>>   CC      hw/nvram/trace.o
>>   CC      hw/scsi/trace.o
>>   CC      hw/display/trace.o
>>   CC      hw/input/trace.o
>>   CC      hw/timer/trace.o
>>   CC      hw/dma/trace.o
>>   CC      hw/sparc/trace.o
>>   CC      hw/isa/trace.o
>>   CC      hw/sd/trace.o
>>   CC      hw/mem/trace.o
>>   CC      hw/i386/trace.o
>>   CC      hw/i386/xen/trace.o
>>   CC      hw/9pfs/trace.o
>>   CC      hw/ppc/trace.o
>>   CC      hw/pci/trace.o
>>   CC      hw/s390x/trace.o
>>   CC      hw/vfio/trace.o
>>   CC      hw/acpi/trace.o
>>   CC      hw/arm/trace.o
>>   CC      hw/alpha/trace.o
>>   CC      hw/xen/trace.o
>>   CC      hw/ide/trace.o
>>   CC      audio/trace.o
>>   CC      ui/trace.o
>>   CC      net/trace.o
>>   CC      target/arm/trace.o
>>   CC      target/i386/trace.o
>>   CC      target/mips/trace.o
>>   CC      target/sparc/trace.o
>>   CC      target/s390x/trace.o
>>   CC      target/ppc/trace.o
>>   CC      qom/trace.o
>>   CC      linux-user/trace.o
>>   CC      qapi/trace.o
>>   CC      accel/tcg/trace.o
>>   CC      accel/kvm/trace.o
>>   CC      scsi/trace.o
>>   CC      nbd/trace.o
>>   CC      crypto/pbkdf-stub.o
>>   CC      stubs/arch-query-cpu-def.o
>>   CC      stubs/arch-query-cpu-model-expansion.o
>>   CC      stubs/arch-query-cpu-model-comparison.o
>>   CC      stubs/arch-query-cpu-model-baseline.o
>>   CC      stubs/bdrv-next-monitor-owned.o
>>   CC      stubs/blk-commit-all.o
>>   CC      stubs/blockdev-close-all-bdrv-states.o
>>   CC      stubs/clock-warp.o
>>   CC      stubs/cpu-get-clock.o
>>   CC      stubs/cpu-get-icount.o
>>   CC      stubs/dump.o
>>   CC      stubs/error-printf.o
>>   CC      stubs/fdset.o
>>   CC      stubs/get-vm-name.o
>>   CC      stubs/iothread.o
>>   CC      stubs/gdbstub.o
>>   CC      stubs/is-daemonized.o
>>   CC      stubs/iothread-lock.o
>>   CC      stubs/machine-init-done.o
>>   CC      stubs/migr-blocker.o
>>   CC      stubs/change-state-handler.o
>>   CC      stubs/monitor.o
>>   CC      stubs/notify-event.o
>>   CC      stubs/qtest.o
>>   CC      stubs/replay.o
>>   CC      stubs/runstate-check.o
>>   CC      stubs/set-fd-handler.o
>>   CC      stubs/sysbus.o
>>   CC      stubs/tpm.o
>>   CC      stubs/slirp.o
>>   CC      stubs/trace-control.o
>>   CC      stubs/uuid.o
>>   CC      stubs/vmstate.o
>>   CC      stubs/vm-stop.o
>>   CC      stubs/fd-register.o
>>   CC      stubs/qmp_pc_dimm.o
>>   CC      stubs/target-monitor-defs.o
>>   CC      stubs/target-get-monitor-def.o
>>   CC      stubs/pc_madt_cpu_entry.o
>>   CC      stubs/vmgenid.o
>>   CC      stubs/xen-common.o
>>   CC      stubs/xen-hvm.o
>>   CC      stubs/pci-host-piix.o
>>   GEN     qemu-img-cmds.h
>>   CC      block.o
>>   CC      blockjob.o
>>   CC      qemu-io-cmds.o
>>   CC      replication.o
>>   CC      block/raw-format.o
>>   CC      block/qcow.o
>>   CC      block/vdi.o
>>   CC      block/vmdk.o
>>   CC      block/cloop.o
>>   CC      block/bochs.o
>>   CC      block/vpc.o
>>   CC      block/vvfat.o
>>   CC      block/qcow2.o
>>   CC      block/dmg.o
>>   CC      block/qcow2-cluster.o
>>   CC      block/qcow2-refcount.o
>>   CC      block/qcow2-snapshot.o
>>   CC      block/qcow2-cache.o
>>   CC      block/qcow2-bitmap.o
>>   CC      block/qed.o
>>   CC      block/qed-l2-cache.o
>>   CC      block/qed-table.o
>>   CC      block/qed-cluster.o
>>   CC      block/qed-check.o
>>   CC      block/vhdx.o
>>   CC      block/vhdx-endian.o
>>   CC      block/vhdx-log.o
>>   CC      block/quorum.o
>>   CC      block/parallels.o
>>   CC      block/blkdebug.o
>>   CC      block/blkverify.o
>>   CC      block/blkreplay.o
>>   CC      block/snapshot.o
>>   CC      block/block-backend.o
>>   CC      block/qapi.o
>>   CC      block/file-win32.o
>>   CC      block/win32-aio.o
>>   CC      block/null.o
>>   CC      block/mirror.o
>>   CC      block/commit.o
>>   CC      block/io.o
>>   CC      block/throttle-groups.o
>>   CC      block/nbd.o
>>   CC      block/nbd-client.o
>>   CC      block/sheepdog.o
>>   CC      block/accounting.o
>>   CC      block/dirty-bitmap.o
>>   CC      block/write-threshold.o
>>   CC      block/backup.o
>>   CC      block/replication.o
>>   CC      block/throttle.o
>>   CC      nbd/server.o
>>   CC      block/crypto.o
>>   CC      nbd/client.o
>>   CC      nbd/common.o
>>   CC      scsi/utils.o
>>   CC      block/curl.o
>>   CC      block/ssh.o
>>   CC      block/dmg-bz2.o
>>   CC      crypto/init.o
>>   CC      crypto/hash.o
>>   CC      crypto/hmac.o
>>   CC      crypto/hmac-nettle.o
>>   CC      crypto/hash-nettle.o
>>   CC      crypto/aes.o
>>   CC      crypto/desrfb.o
>>   CC      crypto/cipher.o
>>   CC      crypto/tlscreds.o
>>   CC      crypto/tlscredsx509.o
>>   CC      crypto/tlscredsanon.o
>>   CC      crypto/tlssession.o
>>   CC      crypto/secret.o
>>   CC      crypto/random-gnutls.o
>>   CC      crypto/pbkdf.o
>>   CC      crypto/pbkdf-nettle.o
>>   CC      crypto/ivgen.o
>>   CC      crypto/ivgen-essiv.o
>>   CC      crypto/ivgen-plain.o
>>   CC      crypto/ivgen-plain64.o
>>   CC      crypto/afsplit.o
>>   CC      crypto/xts.o
>>   CC      crypto/block.o
>>   CC      crypto/block-qcow.o
>>   CC      crypto/block-luks.o
>>   CC      io/channel-buffer.o
>>   CC      io/channel.o
>>   CC      io/channel-command.o
>>   CC      io/channel-file.o
>>   CC      io/channel-socket.o
>>   CC      io/channel-tls.o
>>   CC      io/channel-watch.o
>>   CC      io/channel-websock.o
>>   CC      io/channel-util.o
>>   CC      io/dns-resolver.o
>>   CC      io/task.o
>>   CC      qom/object.o
>>   CC      qom/qom-qobject.o
>>   CC      qom/container.o
>>   CC      qom/object_interfaces.o
>>   CC      qemu-io.o
>>   CC      blockdev.o
>>   CC      blockdev-nbd.o
>>   CC      bootdevice.o
>>   CC      iothread.o
>>   CC      qdev-monitor.o
>>   CC      device-hotplug.o
>>   CC      os-win32.o
>>   CC      bt-host.o
>>   CC      dma-helpers.o
>>   CC      bt-vhci.o
>>   CC      vl.o
>>   CC      tpm.o
>>   CC      device_tree.o
>>   CC      qmp-marshal.o
>>   CC      qmp.o
>>   CC      hmp.o
>>   CC      cpus-common.o
>>   CC      audio/audio.o
>>   CC      audio/noaudio.o
>>   CC      audio/wavaudio.o
>>   CC      audio/mixeng.o
>>   CC      audio/sdlaudio.o
>>   CC      audio/dsoundaudio.o
>>   CC      audio/audio_win_int.o
>>   CC      audio/wavcapture.o
>>   CC      backends/rng.o
>>   CC      backends/rng-egd.o
>>   CC      backends/tpm.o
>>   CC      backends/hostmem.o
>>   CC      backends/hostmem-ram.o
>>   CC      backends/cryptodev.o
>>   CC      block/stream.o
>>   CC      backends/cryptodev-builtin.o
>>   CC      chardev/msmouse.o
>>   CC      chardev/wctablet.o
>>   CC      chardev/testdev.o
>>   CC      disas/arm.o
>>   CXX     disas/arm-a64.o
>>   CC      disas/i386.o
>>   CXX     disas/libvixl/vixl/utils.o
>>   CXX     disas/libvixl/vixl/compiler-intrinsics.o
>>   CXX     disas/libvixl/vixl/a64/instructions-a64.o
>>   CXX     disas/libvixl/vixl/a64/decoder-a64.o
>>   CXX     disas/libvixl/vixl/a64/disasm-a64.o
>>   CC      hw/acpi/core.o
>>   CC      hw/acpi/piix4.o
>>   CC      hw/acpi/pcihp.o
>>   CC      hw/acpi/ich9.o
>>   CC      hw/acpi/cpu_hotplug.o
>>   CC      hw/acpi/tco.o
>>   CC      hw/acpi/memory_hotplug.o
>>   CC      hw/acpi/cpu.o
>>   CC      hw/acpi/nvdimm.o
>>   CC      hw/acpi/vmgenid.o
>>   CC      hw/acpi/acpi_interface.o
>>   CC      hw/acpi/bios-linker-loader.o
>>   CC      hw/acpi/aml-build.o
>>   CC      hw/acpi/ipmi.o
>>   CC      hw/acpi/acpi-stub.o
>>   CC      hw/acpi/ipmi-stub.o
>>   CC      hw/audio/sb16.o
>>   CC      hw/audio/es1370.o
>>   CC      hw/audio/ac97.o
>>   CC      hw/audio/fmopl.o
>>   CC      hw/audio/adlib.o
>>   CC      hw/audio/gus.o
>>   CC      hw/audio/gusemu_hal.o
>>   CC      hw/audio/gusemu_mixer.o
>>   CC      hw/audio/cs4231a.o
>>   CC      hw/audio/intel-hda.o
>>   CC      hw/audio/hda-codec.o
>>   CC      hw/audio/pcspk.o
>>   CC      hw/audio/wm8750.o
>>   CC      hw/audio/pl041.o
>>   CC      hw/audio/lm4549.o
>>   CC      hw/audio/marvell_88w8618.o
>>   CC      hw/audio/soundhw.o
>>   CC      hw/block/block.o
>>   CC      hw/block/cdrom.o
>>   CC      hw/block/hd-geometry.o
>>   CC      hw/block/fdc.o
>>   CC      hw/block/m25p80.o
>>   CC      hw/block/nand.o
>>   CC      hw/block/pflash_cfi01.o
>>   CC      hw/block/pflash_cfi02.o
>>   CC      hw/block/ecc.o
>>   CC      hw/block/onenand.o
>>   CC      hw/block/nvme.o
>>   CC      hw/bt/core.o
>>   CC      hw/bt/sdp.o
>>   CC      hw/bt/l2cap.o
>>   CC      hw/bt/hci.o
>>   CC      hw/bt/hid.o
>>   CC      hw/bt/hci-csr.o
>>   CC      hw/char/ipoctal232.o
>>   CC      hw/char/parallel.o
>>   CC      hw/char/pl011.o
>>   CC      hw/char/serial-isa.o
>>   CC      hw/char/serial-pci.o
>>   CC      hw/char/serial.o
>>   CC      hw/char/virtio-console.o
>>   CC      hw/char/cadence_uart.o
>>   CC      hw/char/cmsdk-apb-uart.o
>>   CC      hw/char/debugcon.o
>>   CC      hw/char/imx_serial.o
>>   CC      hw/core/qdev.o
>>   CC      hw/core/qdev-properties.o
>>   CC      hw/core/reset.o
>>   CC      hw/core/bus.o
>>   CC      hw/core/fw-path-provider.o
>>   CC      hw/core/irq.o
>>   CC      hw/core/hotplug.o
>>   CC      hw/core/nmi.o
>>   CC      hw/core/ptimer.o
>>   CC      hw/core/sysbus.o
>>   CC      hw/core/machine.o
>>   CC      hw/core/loader.o
>>   CC      hw/core/qdev-properties-system.o
>>   CC      hw/core/register.o
>>   CC      hw/core/or-irq.o
>>   CC      hw/cpu/core.o
>>   CC      hw/core/platform-bus.o
>>   CC      hw/display/ads7846.o
>>   CC      hw/display/cirrus_vga.o
>>   CC      hw/display/pl110.o
>>   CC      hw/display/ssd0303.o
>>   CC      hw/display/ssd0323.o
>>   CC      hw/display/vga-pci.o
>>   CC      hw/display/vga-isa.o
>>   CC      hw/display/vmware_vga.o
>>   CC      hw/display/blizzard.o
>>   CC      hw/display/exynos4210_fimd.o
>>   CC      hw/display/framebuffer.o
>>   CC      hw/display/tc6393xb.o
>>   CC      hw/dma/pl080.o
>>   CC      hw/dma/pl330.o
>>   CC      hw/dma/i8257.o
>>   CC      hw/dma/xlnx-zynq-devcfg.o
>>   CC      hw/gpio/max7310.o
>>   CC      hw/gpio/pl061.o
>>   CC      hw/gpio/zaurus.o
>>   CC      hw/gpio/gpio_key.o
>>   CC      hw/i2c/smbus.o
>>   CC      hw/i2c/core.o
>>   CC      hw/i2c/smbus_eeprom.o
>>   CC      hw/i2c/i2c-ddc.o
>>   CC      hw/i2c/versatile_i2c.o
>>   CC      hw/i2c/smbus_ich9.o
>>   CC      hw/i2c/pm_smbus.o
>>   CC      hw/i2c/bitbang_i2c.o
>>   CC      hw/i2c/exynos4210_i2c.o
>>   CC      hw/i2c/imx_i2c.o
>>   CC      hw/i2c/aspeed_i2c.o
>>   CC      hw/ide/core.o
>>   CC      hw/ide/atapi.o
>>   CC      hw/ide/qdev.o
>>   CC      hw/ide/pci.o
>>   CC      hw/ide/isa.o
>>   CC      hw/ide/piix.o
>>   CC      hw/ide/microdrive.o
>>   CC      hw/ide/ahci.o
>>   CC      hw/ide/ich.o
>>   CC      hw/ide/ahci-allwinner.o
>>   CC      hw/input/hid.o
>>   CC      hw/input/lm832x.o
>>   CC      hw/input/pckbd.o
>>   CC      hw/input/pl050.o
>>   CC      hw/input/ps2.o
>>   CC      hw/input/stellaris_input.o
>>   CC      hw/input/tsc2005.o
>>   CC      hw/input/vmmouse.o
>>   CC      hw/input/virtio-input.o
>>   CC      hw/input/virtio-input-hid.o
>>   CC      hw/intc/i8259_common.o
>>   CC      hw/intc/pl190.o
>>   CC      hw/intc/i8259.o
>>   CC      hw/intc/imx_avic.o
>>   CC      hw/intc/realview_gic.o
>>   CC      hw/intc/ioapic_common.o
>>   CC      hw/intc/arm_gic_common.o
>>   CC      hw/intc/arm_gic.o
>>   CC      hw/intc/arm_gicv2m.o
>>   CC      hw/intc/arm_gicv3_common.o
>>   CC      hw/intc/arm_gicv3.o
>>   CC      hw/intc/arm_gicv3_dist.o
>>   CC      hw/intc/arm_gicv3_redist.o
>>   CC      hw/intc/arm_gicv3_its_common.o
>>   CC      hw/intc/intc.o
>>   CC      hw/ipack/ipack.o
>>   CC      hw/ipack/tpci200.o
>>   CC      hw/ipmi/ipmi.o
>>   CC      hw/ipmi/ipmi_bmc_sim.o
>>   CC      hw/ipmi/ipmi_bmc_extern.o
>>   CC      hw/ipmi/isa_ipmi_bt.o
>>   CC      hw/isa/isa-bus.o
>>   CC      hw/ipmi/isa_ipmi_kcs.o
>>   CC      hw/isa/apm.o
>>   CC      hw/mem/pc-dimm.o
>>   CC      hw/mem/nvdimm.o
>>   CC      hw/misc/applesmc.o
>>   CC      hw/misc/max111x.o
>>   CC      hw/misc/tmp105.o
>>   CC      hw/misc/tmp421.o
>>   CC      hw/misc/debugexit.o
>>   CC      hw/misc/pc-testdev.o
>>   CC      hw/misc/pci-testdev.o
>>   CC      hw/misc/sga.o
>>   CC      hw/misc/edu.o
>>   CC      hw/misc/unimp.o
>>   CC      hw/misc/vmcoreinfo.o
>>   CC      hw/misc/arm_l2x0.o
>>   CC      hw/misc/a9scu.o
>>   CC      hw/misc/arm_integrator_debug.o
>>   CC      hw/misc/arm11scu.o
>>   CC      hw/net/ne2000.o
>>   CC      hw/net/eepro100.o
>>   CC      hw/net/pcnet-pci.o
>>   CC      hw/net/e1000.o
>>   CC      hw/net/pcnet.o
>>   CC      hw/net/e1000x_common.o
>>   CC      hw/net/net_tx_pkt.o
>>   CC      hw/net/net_rx_pkt.o
>>   CC      hw/net/e1000e.o
>>   CC      hw/net/e1000e_core.o
>>   CC      hw/net/rtl8139.o
>>   CC      hw/net/vmxnet3.o
>>   CC      hw/net/smc91c111.o
>>   CC      hw/net/ne2000-isa.o
>>   CC      hw/net/lan9118.o
>>   CC      hw/net/xgmac.o
>>   CC      hw/net/allwinner_emac.o
>>   CC      hw/net/imx_fec.o
>>   CC      hw/net/cadence_gem.o
>>   CC      hw/net/stellaris_enet.o
>>   CC      hw/net/ftgmac100.o
>>   CC      hw/net/rocker/rocker.o
>>   CC      hw/net/rocker/rocker_fp.o
>>   CC      hw/net/rocker/rocker_desc.o
>>   CC      hw/net/rocker/rocker_of_dpa.o
>>   CC      hw/net/rocker/rocker_world.o
>>   CC      hw/nvram/eeprom93xx.o
>>   CC      hw/nvram/fw_cfg.o
>>   CC      hw/nvram/chrp_nvram.o
>>   CC      hw/pci-bridge/pci_bridge_dev.o
>>   CC      hw/pci-bridge/pcie_root_port.o
>>   CC      hw/pci-bridge/gen_pcie_root_port.o
>>   CC      hw/pci-bridge/pcie_pci_bridge.o
>>   CC      hw/pci-bridge/pci_expander_bridge.o
>>   CC      hw/pci-bridge/xio3130_upstream.o
>>   CC      hw/pci-bridge/xio3130_downstream.o
>>   CC      hw/pci-bridge/ioh3420.o
>>   CC      hw/pci-host/pam.o
>>   CC      hw/pci-bridge/i82801b11.o
>>   CC      hw/pci-host/versatile.o
>>   CC      hw/pci-host/piix.o
>>   CC      hw/pci-host/q35.o
>>   CC      hw/pci-host/gpex.o
>>   CC      hw/pci/pci.o
>>   CC      hw/pci/pci_bridge.o
>>   CC      hw/pci/msix.o
>>   CC      hw/pci/msi.o
>>   CC      hw/pci/shpc.o
>>   CC      hw/pci/slotid_cap.o
>>   CC      hw/pci/pci_host.o
>>   CC      hw/pci/pcie_host.o
>>   CC      hw/pci/pcie.o
>>   CC      hw/pci/pcie_aer.o
>>   CC      hw/pci/pcie_port.o
>>   CC      hw/pci/pci-stub.o
>>   CC      hw/pcmcia/pcmcia.o
>>   CC      hw/scsi/scsi-disk.o
>>   CC      hw/scsi/scsi-generic.o
>>   CC      hw/scsi/lsi53c895a.o
>>   CC      hw/scsi/scsi-bus.o
>>   CC      hw/scsi/mptsas.o
>>   CC      hw/scsi/mptendian.o
>>   CC      hw/scsi/mptconfig.o
>>   CC      hw/scsi/megasas.o
>>   CC      hw/scsi/vmw_pvscsi.o
>>   CC      hw/scsi/esp.o
>>   CC      hw/scsi/esp-pci.o
>>   CC      hw/sd/pl181.o
>>   CC      hw/sd/ssi-sd.o
>>   CC      hw/sd/sd.o
>>   CC      hw/sd/core.o
>>   CC      hw/sd/sdhci.o
>>   CC      hw/smbios/smbios.o
>>   CC      hw/smbios/smbios_type_38.o
>>   CC      hw/smbios/smbios-stub.o
>>   CC      hw/smbios/smbios_type_38-stub.o
>>   CC      hw/ssi/ssi.o
>>   CC      hw/ssi/pl022.o
>>   CC      hw/ssi/xilinx_spips.o
>>   CC      hw/ssi/aspeed_smc.o
>>   CC      hw/ssi/stm32f2xx_spi.o
>>   CC      hw/ssi/mss-spi.o
>>   CC      hw/timer/arm_timer.o
>>   CC      hw/timer/arm_mptimer.o
>>   CC      hw/timer/armv7m_systick.o
>>   CC      hw/timer/a9gtimer.o
>>   CC      hw/timer/cadence_ttc.o
>>   CC      hw/timer/ds1338.o
>>   CC      hw/timer/i8254_common.o
>>   CC      hw/timer/hpet.o
>>   CC      hw/timer/i8254.o
>>   CC      hw/timer/pl031.o
>>   CC      hw/timer/twl92230.o
>>   CC      hw/timer/imx_gpt.o
>>   CC      hw/timer/imx_epit.o
>>   CC      hw/timer/stm32f2xx_timer.o
>>   CC      hw/timer/aspeed_timer.o
>>   CC      hw/timer/cmsdk-apb-timer.o
>>   CC      hw/timer/mss-timer.o
>>   CC      hw/tpm/tpm_tis.o
>>   CC      hw/usb/core.o
>>   CC      hw/usb/combined-packet.o
>>   CC      hw/usb/bus.o
>>   CC      hw/usb/libhw.o
>>   CC      hw/usb/desc.o
>>   CC      hw/usb/desc-msos.o
>>   CC      hw/usb/hcd-uhci.o
>>   CC      hw/usb/hcd-ohci.o
>>   CC      hw/usb/hcd-ehci.o
>>   CC      hw/usb/hcd-ehci-pci.o
>>   CC      hw/usb/hcd-ehci-sysbus.o
>>   CC      hw/usb/hcd-xhci.o
>>   CC      hw/usb/hcd-xhci-nec.o
>>   CC      hw/usb/hcd-musb.o
>>   CC      hw/usb/dev-hub.o
>>   CC      hw/usb/dev-hid.o
>>   CC      hw/usb/dev-wacom.o
>>   CC      hw/usb/dev-storage.o
>>   CC      hw/usb/dev-uas.o
>>   CC      hw/usb/dev-audio.o
>>   CC      hw/usb/dev-serial.o
>>   CC      hw/usb/dev-network.o
>>   CC      hw/usb/dev-bluetooth.o
>>   CC      hw/usb/dev-smartcard-reader.o
>>   CC      hw/usb/host-stub.o
>>   CC      hw/virtio/virtio-rng.o
>>   CC      hw/virtio/virtio-pci.o
>>   CC      hw/virtio/virtio-bus.o
>>   CC      hw/virtio/virtio-mmio.o
>>   CC      hw/virtio/vhost-stub.o
>>   CC      hw/watchdog/watchdog.o
>>   CC      hw/watchdog/wdt_i6300esb.o
>>   CC      hw/watchdog/wdt_ib700.o
>>   CC      hw/watchdog/wdt_aspeed.o
>>   CC      migration/migration.o
>>   CC      migration/socket.o
>>   CC      migration/fd.o
>>   CC      migration/exec.o
>>   CC      migration/tls.o
>>   CC      migration/channel.o
>>   CC      migration/savevm.o
>>   CC      migration/colo-comm.o
>>   CC      migration/colo.o
>>   CC      migration/colo-failover.o
>>   CC      migration/vmstate.o
>>   CC      migration/vmstate-types.o
>>   CC      migration/page_cache.o
>>   CC      migration/qemu-file.o
>>   CC      migration/global_state.o
>>   CC      migration/qemu-file-channel.o
>>   CC      migration/xbzrle.o
>>   CC      migration/postcopy-ram.o
>>   CC      migration/qjson.o
>>   CC      migration/block.o
>>   CC      net/net.o
>>   CC      net/queue.o
>>   CC      net/util.o
>>   CC      net/checksum.o
>>   CC      net/hub.o
>>   CC      net/socket.o
>>   CC      net/dump.o
>>   CC      net/eth.o
>>   CC      net/filter.o
>>   CC      net/slirp.o
>>   CC      net/filter-buffer.o
>>   CC      net/filter-mirror.o
>>   CC      net/colo-compare.o
>>   CC      net/colo.o
>>   CC      net/filter-rewriter.o
>>   CC      net/filter-replay.o
>>   CC      net/tap-win32.o
>>   CC      replay/replay.o
>>   CC      qom/cpu.o
>>   CC      replay/replay-internal.o
>>   CC      replay/replay-events.o
>>   CC      replay/replay-time.o
>>   CC      replay/replay-input.o
>>   CC      replay/replay-char.o
>>   CC      replay/replay-snapshot.o
>>   CC      replay/replay-net.o
>>   CC      replay/replay-audio.o
>>   CC      slirp/cksum.o
>>   CC      slirp/if.o
>>   CC      slirp/ip_icmp.o
>>   CC      slirp/ip6_icmp.o
>>   CC      slirp/ip_input.o
>>   CC      slirp/ip6_output.o
>>   CC      slirp/ip6_input.o
>>   CC      slirp/ip_output.o
>>   CC      slirp/dnssearch.o
>>   CC      slirp/dhcpv6.o
>>   CC      slirp/slirp.o
>>   CC      slirp/mbuf.o
>>   CC      slirp/misc.o
>>   CC      slirp/sbuf.o
>>   CC      slirp/socket.o
>>   CC      slirp/tcp_input.o
>>   CC      slirp/tcp_output.o
>>   CC      slirp/tcp_subr.o
>>   CC      slirp/udp.o
>>   CC      slirp/tcp_timer.o
>>   CC      slirp/udp6.o
>>   CC      slirp/bootp.o
>>   CC      slirp/tftp.o
>>   CC      slirp/arp_table.o
>>   CC      ui/keymaps.o
>>   CC      slirp/ndp_table.o
>>   CC      ui/console.o
>>   CC      slirp/ncsi.o
>>   CC      ui/qemu-pixman.o
>>   CC      ui/cursor.o
>>   CC      ui/input.o
>>   CC      ui/input-legacy.o
>>   CC      ui/input-keymap.o
>>   CC      ui/sdl.o
>>   CC      ui/x_keymap.o
>>   CC      ui/vnc.o
>>   CC      ui/sdl_zoom.o
>>   CC      ui/vnc-enc-hextile.o
>>   CC      ui/vnc-enc-zlib.o
>>   CC      ui/vnc-enc-tight.o
>>   CC      ui/vnc-enc-zrle.o
>>   CC      ui/vnc-palette.o
>>   CC      ui/vnc-auth-vencrypt.o
>>   CC      ui/vnc-ws.o
>>   CC      ui/vnc-jobs.o
>>   CC      ui/gtk.o
>>   CC      chardev/char.o
>>   CC      chardev/char-console.o
>>   CC      chardev/char-fe.o
>>   CC      chardev/char-file.o
>>   CC      chardev/char-io.o
>>   CC      chardev/char-mux.o
>>   CC      chardev/char-null.o
>>   CC      chardev/char-ringbuf.o
>>   CC      chardev/char-pipe.o
>>   CC      chardev/char-serial.o
>>   CC      chardev/char-socket.o
>>   CC      chardev/char-stdio.o
>>   CC      chardev/char-udp.o
>>   CC      chardev/char-win.o
>>   CC      chardev/char-win-stdio.o
>>   CC      qga/commands.o
>>   CC      qga/guest-agent-command-state.o
>>   CC      qga/main.o
>>   CC      qga/commands-win32.o
>>   CC      qga/channel-win32.o
>>   CC      qga/service-win32.o
>>   CC      qga/vss-win32.o
>>   CC      qga/qapi-generated/qga-qapi-types.o
>>   AS      optionrom/multiboot.o
>>   CC      qga/qapi-generated/qga-qapi-visit.o
>>   AS      optionrom/linuxboot.o
>>   CC      qga/qapi-generated/qga-qmp-marshal.o
>>   CC      optionrom/linuxboot_dma.o
>>   AR      libqemuutil.a
>>   AS      optionrom/kvmvapic.o
>>   BUILD   optionrom/multiboot.img
>>   BUILD   optionrom/linuxboot.img
>>   BUILD   optionrom/linuxboot_dma.img
>>   BUILD   optionrom/multiboot.raw
>>   CC      qemu-img.o
>>   BUILD   optionrom/linuxboot.raw
>>   BUILD   optionrom/kvmvapic.img
>>   BUILD   optionrom/linuxboot_dma.raw
>>   BUILD   optionrom/kvmvapic.raw
>>   SIGN    optionrom/kvmvapic.bin
>>   SIGN    optionrom/multiboot.bin
>>   SIGN    optionrom/linuxboot.bin
>>   SIGN    optionrom/linuxboot_dma.bin
>>   LINK    qemu-io.exe
>>   LINK    qemu-ga.exe
>>   LINK    qemu-img.exe
>>   GEN     x86_64-softmmu/hmp-commands.h
>>   GEN     x86_64-softmmu/config-target.h
>>   GEN     x86_64-softmmu/hmp-commands-info.h
>>   GEN     aarch64-softmmu/hmp-commands-info.h
>>   GEN     aarch64-softmmu/hmp-commands.h
>>   GEN     aarch64-softmmu/config-target.h
>>   CC      x86_64-softmmu/tcg/tcg.o
>>   CC      x86_64-softmmu/tcg/tcg-common.o
>>   CC      x86_64-softmmu/tcg/tcg-op.o
>>   CC      x86_64-softmmu/tcg/optimize.o
>>   CC      x86_64-softmmu/disas.o
>>   CC      x86_64-softmmu/fpu/softfloat.o
>>   CC      x86_64-softmmu/exec.o
>>   CC      aarch64-softmmu/exec.o
>>   GEN     x86_64-softmmu/gdbstub-xml.c
>>   CC      x86_64-softmmu/arch_init.o
>>   CC      x86_64-softmmu/cpus.o
>>   CC      aarch64-softmmu/tcg/tcg.o
>>   CC      aarch64-softmmu/tcg/tcg-op.o
>>   CC      x86_64-softmmu/monitor.o
>>   CC      x86_64-softmmu/gdbstub.o
>>   CC      aarch64-softmmu/tcg/optimize.o
>>   CC      aarch64-softmmu/tcg/tcg-common.o
>>   CC      x86_64-softmmu/balloon.o
>>   CC      x86_64-softmmu/ioport.o
>>   CC      x86_64-softmmu/numa.o
>>   CC      aarch64-softmmu/fpu/softfloat.o
>>   CC      x86_64-softmmu/qtest.o
>>   CC      x86_64-softmmu/memory.o
>>   CC      aarch64-softmmu/disas.o
>>   CC      x86_64-softmmu/memory_mapping.o
>>   CC      x86_64-softmmu/dump.o
>>   GEN     aarch64-softmmu/gdbstub-xml.c
>>   CC      aarch64-softmmu/arch_init.o
>>   CC      x86_64-softmmu/migration/ram.o
>>   CC      aarch64-softmmu/cpus.o
>>   CC      aarch64-softmmu/monitor.o
>>   CC      x86_64-softmmu/accel/accel.o
>>   CC      aarch64-softmmu/gdbstub.o
>>   CC      aarch64-softmmu/balloon.o
>>   CC      aarch64-softmmu/numa.o
>>   CC      aarch64-softmmu/ioport.o
>>   CC      x86_64-softmmu/accel/stubs/kvm-stub.o
>>   CC      aarch64-softmmu/qtest.o
>>   CC      aarch64-softmmu/memory.o
>>   CC      aarch64-softmmu/memory_mapping.o
>>   CC      x86_64-softmmu/accel/tcg/tcg-all.o
>>   CC      aarch64-softmmu/dump.o
>>   CC      x86_64-softmmu/accel/tcg/cputlb.o
>>   CC      x86_64-softmmu/accel/tcg/tcg-runtime.o
>>   CC      aarch64-softmmu/migration/ram.o
>>   CC      x86_64-softmmu/accel/tcg/cpu-exec.o
>>   CC      aarch64-softmmu/accel/accel.o
>>   CC      x86_64-softmmu/accel/tcg/cpu-exec-common.o
>>   CC      aarch64-softmmu/accel/stubs/hax-stub.o
>>   CC      x86_64-softmmu/accel/tcg/translator.o
>>   CC      x86_64-softmmu/accel/tcg/translate-all.o
>>   CC      x86_64-softmmu/hw/block/virtio-blk.o
>>   CC      aarch64-softmmu/accel/stubs/kvm-stub.o
>>   CC      aarch64-softmmu/accel/tcg/tcg-all.o
>>   CC      aarch64-softmmu/accel/tcg/cputlb.o
>>   CC      x86_64-softmmu/hw/block/dataplane/virtio-blk.o
>>   CC      x86_64-softmmu/hw/char/virtio-serial-bus.o
>>   CC      aarch64-softmmu/accel/tcg/tcg-runtime.o
>>   CC      x86_64-softmmu/hw/core/generic-loader.o
>>   CC      aarch64-softmmu/accel/tcg/cpu-exec.o
>>   CC      x86_64-softmmu/hw/core/null-machine.o
>>   CC      x86_64-softmmu/hw/display/vga.o
>>   CC      aarch64-softmmu/accel/tcg/cpu-exec-common.o
>>   CC      x86_64-softmmu/hw/display/virtio-gpu.o
>>   CC      aarch64-softmmu/accel/tcg/translate-all.o
>>   CC      x86_64-softmmu/hw/display/virtio-gpu-3d.o
>>   CC      aarch64-softmmu/accel/tcg/translator.o
>>   CC      aarch64-softmmu/hw/adc/stm32f2xx_adc.o
>>   CC      x86_64-softmmu/hw/display/virtio-gpu-pci.o
>>   CC      x86_64-softmmu/hw/display/virtio-vga.o
>>   CC      aarch64-softmmu/hw/block/virtio-blk.o
>>   CC      x86_64-softmmu/hw/intc/apic.o
>>   CC      aarch64-softmmu/hw/block/dataplane/virtio-blk.o
>>   CC      x86_64-softmmu/hw/intc/apic_common.o
>>   CC      x86_64-softmmu/hw/intc/ioapic.o
>>   CC      x86_64-softmmu/hw/isa/lpc_ich9.o
>>   CC      x86_64-softmmu/hw/misc/vmport.o
>>   CC      x86_64-softmmu/hw/misc/pvpanic.o
>>   CC      x86_64-softmmu/hw/misc/mmio_interface.o
>>   CC      x86_64-softmmu/hw/net/virtio-net.o
>>   CC      aarch64-softmmu/hw/char/exynos4210_uart.o
>>   CC      x86_64-softmmu/hw/net/vhost_net.o
>>   CC      aarch64-softmmu/hw/char/omap_uart.o
>>   CC      x86_64-softmmu/hw/scsi/virtio-scsi.o
>>   CC      aarch64-softmmu/hw/char/digic-uart.o
>>   CC      aarch64-softmmu/hw/char/stm32f2xx_usart.o
>>   CC      aarch64-softmmu/hw/char/bcm2835_aux.o
>>   CC      aarch64-softmmu/hw/char/virtio-serial-bus.o
>>   CC      aarch64-softmmu/hw/core/generic-loader.o
>>   CC      aarch64-softmmu/hw/core/null-machine.o
>>   CC      aarch64-softmmu/hw/cpu/arm11mpcore.o
>>   CC      aarch64-softmmu/hw/cpu/realview_mpcore.o
>>   CC      aarch64-softmmu/hw/cpu/a9mpcore.o
>>   CC      aarch64-softmmu/hw/cpu/a15mpcore.o
>>   CC      x86_64-softmmu/hw/scsi/virtio-scsi-dataplane.o
>>   CC      aarch64-softmmu/hw/display/omap_dss.o
>>   CC      x86_64-softmmu/hw/timer/mc146818rtc.o
>>   CC      aarch64-softmmu/hw/display/omap_lcdc.o
>>   CC      x86_64-softmmu/hw/virtio/virtio.o
>>   CC      x86_64-softmmu/hw/virtio/virtio-balloon.o
>>   CC      aarch64-softmmu/hw/display/pxa2xx_lcd.o
>>   CC      x86_64-softmmu/hw/virtio/virtio-crypto.o
>>   CC      x86_64-softmmu/hw/virtio/virtio-crypto-pci.o
>>   CC      aarch64-softmmu/hw/display/bcm2835_fb.o
>>   CC      x86_64-softmmu/hw/i386/multiboot.o
>>   CC      aarch64-softmmu/hw/display/vga.o
>>   CC      aarch64-softmmu/hw/display/virtio-gpu.o
>>   CC      x86_64-softmmu/hw/i386/pc.o
>>   CC      aarch64-softmmu/hw/display/virtio-gpu-3d.o
>>   CC      aarch64-softmmu/hw/display/virtio-gpu-pci.o
>>   CC      x86_64-softmmu/hw/i386/pc_piix.o
>>   CC      x86_64-softmmu/hw/i386/pc_q35.o
>>   CC      x86_64-softmmu/hw/i386/pc_sysfw.o
>>   CC      x86_64-softmmu/hw/i386/x86-iommu.o
>>   CC      aarch64-softmmu/hw/display/dpcd.o
>>   CC      aarch64-softmmu/hw/display/xlnx_dp.o
>>   CC      aarch64-softmmu/hw/dma/xlnx_dpdma.o
>>   CC      aarch64-softmmu/hw/dma/omap_dma.o
>>   CC      x86_64-softmmu/hw/i386/intel_iommu.o
>>   CC      aarch64-softmmu/hw/dma/soc_dma.o
>>   CC      aarch64-softmmu/hw/dma/pxa2xx_dma.o
>>   CC      aarch64-softmmu/hw/dma/bcm2835_dma.o
>>   CC      x86_64-softmmu/hw/i386/amd_iommu.o
>>   CC      x86_64-softmmu/hw/i386/kvmvapic.o
>>   CC      x86_64-softmmu/hw/i386/acpi-build.o
>>   CC      aarch64-softmmu/hw/gpio/omap_gpio.o
>>   CC      x86_64-softmmu/target/i386/helper.o
>>   CC      aarch64-softmmu/hw/gpio/imx_gpio.o
>>   CC      x86_64-softmmu/target/i386/cpu.o
>>   CC      aarch64-softmmu/hw/gpio/bcm2835_gpio.o
>>   CC      aarch64-softmmu/hw/i2c/omap_i2c.o
>>   CC      x86_64-softmmu/target/i386/gdbstub.o
>>   CC      aarch64-softmmu/hw/input/pxa2xx_keypad.o
>>   CC      x86_64-softmmu/target/i386/xsave_helper.o
>>   CC      x86_64-softmmu/target/i386/translate.o
>>   CC      aarch64-softmmu/hw/input/tsc210x.o
>>   CC      aarch64-softmmu/hw/intc/armv7m_nvic.o
>>   CC      x86_64-softmmu/target/i386/cc_helper.o
>>   CC      x86_64-softmmu/target/i386/excp_helper.o
>>   CC      x86_64-softmmu/target/i386/bpt_helper.o
>>   CC      x86_64-softmmu/target/i386/fpu_helper.o
>>   CC      aarch64-softmmu/hw/intc/exynos4210_gic.o
>>   CC      x86_64-softmmu/target/i386/int_helper.o
>>   CC      aarch64-softmmu/hw/intc/exynos4210_combiner.o
>>   CC      x86_64-softmmu/target/i386/mem_helper.o
>>   CC      x86_64-softmmu/target/i386/misc_helper.o
>>   CC      aarch64-softmmu/hw/intc/omap_intc.o
>>   CC      aarch64-softmmu/hw/intc/bcm2835_ic.o
>>   CC      x86_64-softmmu/target/i386/mpx_helper.o
>>   CC      x86_64-softmmu/target/i386/seg_helper.o
>>   CC      aarch64-softmmu/hw/intc/bcm2836_control.o
>>   CC      x86_64-softmmu/target/i386/smm_helper.o
>>   CC      aarch64-softmmu/hw/intc/allwinner-a10-pic.o
>>   CC      aarch64-softmmu/hw/intc/aspeed_vic.o
>>   CC      aarch64-softmmu/hw/intc/arm_gicv3_cpuif.o
>>   CC      x86_64-softmmu/target/i386/svm_helper.o
>>   CC      x86_64-softmmu/target/i386/machine.o
>>   CC      aarch64-softmmu/hw/misc/arm_sysctl.o
>>   CC      x86_64-softmmu/target/i386/arch_memory_mapping.o
>>   CC      x86_64-softmmu/target/i386/arch_dump.o
>>   CC      aarch64-softmmu/hw/misc/cbus.o
>>   CC      aarch64-softmmu/hw/misc/exynos4210_pmu.o
>>   CC      aarch64-softmmu/hw/misc/exynos4210_clk.o
>>   CC      x86_64-softmmu/target/i386/monitor.o
>>   CC      x86_64-softmmu/target/i386/kvm-stub.o
>>   CC      x86_64-softmmu/target/i386/hax-all.o
>>   CC      aarch64-softmmu/hw/misc/exynos4210_rng.o
>>   CC      aarch64-softmmu/hw/misc/imx_ccm.o
>>   CC      aarch64-softmmu/hw/misc/imx31_ccm.o
>>   CC      x86_64-softmmu/target/i386/hax-mem.o
>>   CC      aarch64-softmmu/hw/misc/imx25_ccm.o
>>   CC      aarch64-softmmu/hw/misc/imx6_ccm.o
>>   CC      x86_64-softmmu/target/i386/hax-windows.o
>>   CC      aarch64-softmmu/hw/misc/imx6_src.o
>>   CC      aarch64-softmmu/hw/misc/mst_fpga.o
>>   CC      aarch64-softmmu/hw/misc/omap_clk.o
>>   GEN     trace/generated-helpers.c
>>   CC      aarch64-softmmu/hw/misc/omap_gpmc.o
>>   CC      x86_64-softmmu/trace/control-target.o
>>   CC      aarch64-softmmu/hw/misc/omap_l4.o
>>   CC      aarch64-softmmu/hw/misc/omap_sdrc.o
>>   CC      aarch64-softmmu/hw/misc/omap_tap.o
>>   CC      x86_64-softmmu/gdbstub-xml.o
>>   CC      aarch64-softmmu/hw/misc/bcm2835_mbox.o
>>   CC      aarch64-softmmu/hw/misc/bcm2835_property.o
>>   CC      aarch64-softmmu/hw/misc/bcm2835_rng.o
>>   CC      aarch64-softmmu/hw/misc/zynq_slcr.o
>>   CC      x86_64-softmmu/trace/generated-helpers.o
>>   CC      aarch64-softmmu/hw/misc/zynq-xadc.o
>>   CC      aarch64-softmmu/hw/misc/mps2-scc.o
>>   CC      aarch64-softmmu/hw/misc/stm32f2xx_syscfg.o
>>   CC      aarch64-softmmu/hw/misc/auxbus.o
>>   CC      aarch64-softmmu/hw/misc/aspeed_scu.o
>>   CC      aarch64-softmmu/hw/misc/aspeed_sdmc.o
>>   CC      aarch64-softmmu/hw/misc/mmio_interface.o
>>   CC      aarch64-softmmu/hw/misc/msf2-sysreg.o
>>   CC      aarch64-softmmu/hw/net/virtio-net.o
>>   CC      aarch64-softmmu/hw/net/vhost_net.o
>>   CC      aarch64-softmmu/hw/pcmcia/pxa2xx.o
>>   CC      aarch64-softmmu/hw/scsi/virtio-scsi.o
>>   CC      aarch64-softmmu/hw/scsi/virtio-scsi-dataplane.o
>>   CC      aarch64-softmmu/hw/sd/omap_mmc.o
>>   LINK    x86_64-softmmu/qemu-system-x86_64.exe
>>   CC      aarch64-softmmu/hw/sd/pxa2xx_mmci.o
>>   CC      aarch64-softmmu/hw/sd/bcm2835_sdhost.o
>>   CC      aarch64-softmmu/hw/ssi/omap_spi.o
>>   CC      aarch64-softmmu/hw/ssi/imx_spi.o
>>   CC      aarch64-softmmu/hw/timer/exynos4210_mct.o
>>   CC      aarch64-softmmu/hw/timer/exynos4210_pwm.o
>>   CC      aarch64-softmmu/hw/timer/exynos4210_rtc.o
>>   CC      aarch64-softmmu/hw/timer/omap_gptimer.o
>>   CC      aarch64-softmmu/hw/timer/omap_synctimer.o
>>   CC      aarch64-softmmu/hw/timer/pxa2xx_timer.o
>>   CC      aarch64-softmmu/hw/timer/digic-timer.o
>>   CC      aarch64-softmmu/hw/timer/allwinner-a10-pit.o
>>   CC      aarch64-softmmu/hw/usb/tusb6010.o
>>   CC      aarch64-softmmu/hw/virtio/virtio-balloon.o
>>   CC      aarch64-softmmu/hw/virtio/virtio-crypto.o
>>   CC      aarch64-softmmu/hw/virtio/virtio.o
>>   CC      aarch64-softmmu/hw/virtio/virtio-crypto-pci.o
>>   CC      aarch64-softmmu/hw/arm/boot.o
>>   CC      aarch64-softmmu/hw/arm/collie.o
>>   CC      aarch64-softmmu/hw/arm/exynos4_boards.o
>>   CC      aarch64-softmmu/hw/arm/gumstix.o
>>   CC      aarch64-softmmu/hw/arm/digic_boards.o
>>   CC      aarch64-softmmu/hw/arm/highbank.o
>>   CC      aarch64-softmmu/hw/arm/integratorcp.o
>>   CC      aarch64-softmmu/hw/arm/mainstone.o
>>   CC      aarch64-softmmu/hw/arm/musicpal.o
>>   CC      aarch64-softmmu/hw/arm/nseries.o
>>   CC      aarch64-softmmu/hw/arm/omap_sx1.o
>>   CC      aarch64-softmmu/hw/arm/palm.o
>>   CC      aarch64-softmmu/hw/arm/realview.o
>>   CC      aarch64-softmmu/hw/arm/spitz.o
>>   CC      aarch64-softmmu/hw/arm/tosa.o
>>   CC      aarch64-softmmu/hw/arm/versatilepb.o
>>   CC      aarch64-softmmu/hw/arm/stellaris.o
>>   CC      aarch64-softmmu/hw/arm/vexpress.o
>>   CC      aarch64-softmmu/hw/arm/virt.o
>>   CC      aarch64-softmmu/hw/arm/xilinx_zynq.o
>>   CC      aarch64-softmmu/hw/arm/z2.o
>>   CC      aarch64-softmmu/hw/arm/virt-acpi-build.o
>>   CC      aarch64-softmmu/hw/arm/netduino2.o
>>   CC      aarch64-softmmu/hw/arm/sysbus-fdt.o
>>   CC      aarch64-softmmu/hw/arm/armv7m.o
>>   CC      aarch64-softmmu/hw/arm/exynos4210.o
>>   CC      aarch64-softmmu/hw/arm/pxa2xx.o
>>   CC      aarch64-softmmu/hw/arm/pxa2xx_gpio.o
>>   CC      aarch64-softmmu/hw/arm/digic.o
>>   CC      aarch64-softmmu/hw/arm/pxa2xx_pic.o
>>   CC      aarch64-softmmu/hw/arm/omap1.o
>>   CC      aarch64-softmmu/hw/arm/omap2.o
>>   CC      aarch64-softmmu/hw/arm/strongarm.o
>>   CC      aarch64-softmmu/hw/arm/allwinner-a10.o
>>   CC      aarch64-softmmu/hw/arm/cubieboard.o
>>   CC      aarch64-softmmu/hw/arm/bcm2835_peripherals.o
>>   CC      aarch64-softmmu/hw/arm/bcm2836.o
>>   CC      aarch64-softmmu/hw/arm/raspi.o
>>   CC      aarch64-softmmu/hw/arm/stm32f205_soc.o
>>   CC      aarch64-softmmu/hw/arm/xlnx-zynqmp.o
>>   CC      aarch64-softmmu/hw/arm/xlnx-zcu102.o
>>   CC      aarch64-softmmu/hw/arm/fsl-imx25.o
>>   CC      aarch64-softmmu/hw/arm/imx25_pdk.o
>>   CC      aarch64-softmmu/hw/arm/fsl-imx31.o
>>   CC      aarch64-softmmu/hw/arm/kzm.o
>>   CC      aarch64-softmmu/hw/arm/fsl-imx6.o
>>   CC      aarch64-softmmu/hw/arm/sabrelite.o
>>   CC      aarch64-softmmu/hw/arm/aspeed_soc.o
>>   CC      aarch64-softmmu/hw/arm/aspeed.o
>>   CC      aarch64-softmmu/hw/arm/mps2.o
>>   CC      aarch64-softmmu/hw/arm/msf2-som.o
>>   CC      aarch64-softmmu/hw/arm/msf2-soc.o
>>   CC      aarch64-softmmu/target/arm/arm-semi.o
>>   CC      aarch64-softmmu/target/arm/machine.o
>>   CC      aarch64-softmmu/target/arm/psci.o
>>   CC      aarch64-softmmu/target/arm/arch_dump.o
>>   CC      aarch64-softmmu/target/arm/monitor.o
>>   CC      aarch64-softmmu/target/arm/kvm-stub.o
>>   CC      aarch64-softmmu/target/arm/translate.o
>>   CC      aarch64-softmmu/target/arm/op_helper.o
>>   CC      aarch64-softmmu/target/arm/helper.o
>>   CC      aarch64-softmmu/target/arm/cpu.o
>>   CC      aarch64-softmmu/target/arm/neon_helper.o
>>   CC      aarch64-softmmu/target/arm/iwmmxt_helper.o
>>   CC      aarch64-softmmu/target/arm/gdbstub.o
>>   CC      aarch64-softmmu/target/arm/cpu64.o
>>   CC      aarch64-softmmu/target/arm/translate-a64.o
>>   CC      aarch64-softmmu/target/arm/helper-a64.o
>>   CC      aarch64-softmmu/target/arm/gdbstub64.o
>>   CC      aarch64-softmmu/target/arm/crypto_helper.o
>>   CC      aarch64-softmmu/target/arm/arm-powerctl.o
>>   GEN     trace/generated-helpers.c
>>   CC      aarch64-softmmu/trace/control-target.o
>>   CC      aarch64-softmmu/gdbstub-xml.o
>>   CC      aarch64-softmmu/trace/generated-helpers.o
>>   LINK    aarch64-softmmu/qemu-system-aarch64.exe
>> mkdir -p dtc/libfdt
>> mkdir -p dtc/tests
>> install -d -m 0755 "/tmp/qemu-test/build/=3Ddestdir/tmp/qemu-test/instal=
l"
>> install -d -m 0755 "/tmp/qemu-test/build/=3Ddestdir/tmp/qemu-test/instal=
l"
>> install -c -m 0755 qemu-ga.exe qemu-img.exe qemu-io.exe
>> "/tmp/qemu-test/build/=3Ddestdir/tmp/qemu-test/install"
>> set -e; for x in bios.bin bios-256k.bin sgabios.bin vgabios.bin
>> vgabios-cirrus.bin vgabios-stdvga.bin vgabios-vmware.bin vgabios-qxl.bin
>> vgabios-virtio.bin acpi-dsdt.aml ppc_rom.bin openbios-sparc32
>> openbios-sparc64 openbios-ppc QEMU,tcx.bin QEMU,cgthree.bin pxe-e1000.ro=
m
>> pxe-eepro100.rom pxe-ne2k_pci.rom pxe-pcnet.rom pxe-rtl8139.rom
>> pxe-virtio.rom efi-e1000.rom efi-eepro100.rom efi-ne2k_pci.rom efi-pcnet=
.rom
>> efi-rtl8139.rom efi-virtio.rom efi-e1000e.rom efi-vmxnet3.rom qemu-icon.=
bmp
>> qemu_logo_no_text.svg bamboo.dtb petalogix-s3adsp1800.dtb
>> petalogix-ml605.dtb multiboot.bin linuxboot.bin linuxboot_dma.bin
>> kvmvapic.bin s390-ccw.img s390-netboot.img spapr-rtas.bin slof.bin
>> skiboot.lid palcode-clipper u-boot.e500 qemu_vga.ndrv; do \
>>         install -c -m 0644 /tmp/qemu-test/src/pc-bios/$x
>> "/tmp/qemu-test/build/=3Ddestdir/tmp/qemu-test/install"; \
>> done
>> make -C po install
>> make[1]: Entering directory '/tmp/qemu-test/build/po'
>>   GEN     /tmp/qemu-test/src/po/messages.po
>>   GEN     /tmp/qemu-test/src/po/hu.po
>>   GEN     /tmp/qemu-test/src/po/tr.po
>>   GEN     /tmp/qemu-test/src/po/fr_FR.po
>>   GEN     /tmp/qemu-test/src/po/bg.po
>>   GEN     /tmp/qemu-test/src/po/it.po
>>   GEN     /tmp/qemu-test/src/po/de_DE.po
>>   GEN     /tmp/qemu-test/src/po/zh_CN.po
>>   GEN     fr_FR.mo
>>   GEN     bg.mo
>>   GEN     zh_CN.mo
>>   GEN     de_DE.mo
>>   GEN     it.mo
>>   GEN     tr.mo
>>   GEN     hu.mo
>> for obj in hu.mo tr.mo it.mo bg.mo fr_FR.mo zh_CN.mo de_DE.mo; do \
>>     base=3D`basename $obj .mo`; \
>>     install -d
>> /tmp/qemu-test/build/=3Ddestdir/tmp/qemu-test/install/share/locale/$base=
/LC_MESSAGES;
>> \
>>     install -m644 $obj
>> /tmp/qemu-test/build/=3Ddestdir/tmp/qemu-test/install/share/locale/$base=
/LC_MESSAGES/qemu.mo;
>> \
>> done
>> make[1]: Leaving directory '/tmp/qemu-test/build/po'
>> install -d -m 0755
>> "/tmp/qemu-test/build/=3Ddestdir/tmp/qemu-test/install/keymaps"
>> set -e; for x in da     en-gb  et  fr     fr-ch  is  lt  modifiers  no
>> pt-br  sv ar      de     en-us  fi  fr-be  hr     it  lv  nl         pl =
 ru
>> th common  de-ch  es     fo  fr-ca  hu     ja  mk  nl-be      pt  sl    =
 tr
>> bepo    cz; do \
>>         install -c -m 0644 /tmp/qemu-test/src/pc-bios/keymaps/$x
>> "/tmp/qemu-test/build/=3Ddestdir/tmp/qemu-test/install/keymaps"; \
>> done
>> install -c -m 0644 /tmp/qemu-test/build/trace-events-all
>> "/tmp/qemu-test/build/=3Ddestdir/tmp/qemu-test/install/trace-events-all"
>> for d in x86_64-softmmu aarch64-softmmu; do \
>> make --no-print-directory BUILD_DIR=3D/tmp/qemu-test/build TARGET_DIR=3D=
$d/ -C
>> $d install || exit 1 ; \
>>         done
>> install -d -m 0755 "/tmp/qemu-test/build/=3Ddestdir/tmp/qemu-test/instal=
l"
>> install -c -m 0755 qemu-system-x86_64.exe
>> "/tmp/qemu-test/build/=3Ddestdir/tmp/qemu-test/install"
>> install -d -m 0755 "/tmp/qemu-test/build/=3Ddestdir/tmp/qemu-test/instal=
l"
>> install -c -m 0755 qemu-system-aarch64.exe
>> "/tmp/qemu-test/build/=3Ddestdir/tmp/qemu-test/install"
>> mkdir -p dtc/libfdt
>> mkdir -p dtc/tests
>> rm -f *.timestamp
>> make -C tests/tcg clean
>> make[1]: Entering directory '/tmp/qemu-test/build/tests/tcg'
>> rm -f *.timestamp
>> rm -f *~ *.o test-i386.out test-i386.ref \
>>            test-x86_64.log test-x86_64.ref qruncom test_path hello-i386
>> linux-test testthread sha1-i386 test-i386 test-i386-fprem test-mmap
>> run-test-x86_64
>> make[1]: Leaving directory '/tmp/qemu-test/build/tests/tcg'
>> rm -rf tests/check-qdict.exe tests/test-char.exe tests/check-qnum.exe
>> tests/check-qstring.exe tests/check-qlist.exe tests/check-qnull.exe
>> tests/check-qobject.exe tests/check-qjson.exe tests/check-qlit.exe
>> tests/test-qobject-output-visitor.exe tests/test-clone-visitor.exe
>> tests/test-qobject-input-visitor.exe tests/test-qmp-commands.exe
>> tests/test-string-input-visitor.exe tests/test-string-output-visitor.exe
>> tests/test-qmp-event.exe tests/test-opts-visitor.exe
>> tests/test-coroutine.exe tests/test-visitor-serialization.exe
>> tests/test-iov.exe tests/test-aio.exe tests/test-aio-multithread.exe
>> tests/test-throttle.exe tests/test-thread-pool.exe tests/test-hbitmap.ex=
e
>> tests/test-blockjob.exe tests/test-blockjob-txn.exe tests/test-x86-cpuid=
.exe
>> tests/test-xbzrle.exe tests/test-cutils.exe tests/test-shift128.exe
>> tests/test-mul64.exe tests/test-int128.exe tests/rcutorture.exe
>> tests/test-rcu-list.exe tests/test-qdist.exe tests/test-qht.exe
>> tests/test-qht-par.exe tests/test-bitops.exe tests/test-bitcnt.exe
>> tests/test-qdev-global-props.exe tests/check-qom-interface.exe
>> tests/check-qom-proplist.exe tests/test-qemu-opts.exe tests/test-keyval.=
exe
>> tests/test-write-threshold.exe tests/test-crypto-hash.exe
>> tests/test-crypto-hmac.exe tests/test-crypto-cipher.exe
>> tests/test-crypto-secret.exe tests/test-crypto-tlscredsx509.exe
>> tests/test-crypto-tlssession.exe tests/test-timed-average.exe
>> tests/test-io-task.exe tests/test-io-channel-socket.exe
>> tests/test-io-channel-file.exe tests/test-io-channel-tls.exe
>> tests/test-io-channel-command.exe tests/test-io-channel-buffer.exe
>> tests/test-base64.exe tests/test-crypto-pbkdf.exe
>> tests/test-crypto-ivgen.exe tests/test-crypto-afsplit.exe
>> tests/test-crypto-xts.exe tests/test-crypto-block.exe tests/test-logging=
.exe
>> tests/test-replication.exe tests/test-bufferiszero.exe tests/test-uuid.e=
xe
>> tests/ptimer-test.exe tests/test-qapi-util.exe tests/*.o
>> rm -rf tests/ac97-test.exe tests/ahci-test.exe tests/bios-tables-test.ex=
e
>> tests/boot-order-test.exe tests/boot-serial-test.exe
>> tests/device-introspect-test.exe tests/display-vga-test.exe
>> tests/drive_del-test.exe tests/ds1338-test.exe tests/e1000-test.exe
>> tests/e1000e-test.exe tests/eepro100-test.exe tests/endianness-test.exe
>> tests/es1370-test.exe tests/fdc-test.exe tests/fw_cfg-test.exe
>> tests/hd-geo-test.exe tests/i440fx-test.exe tests/i82801b11-test.exe
>> tests/ide-test.exe tests/intel-hda-test.exe tests/ioh3420-test.exe
>> tests/ipmi-bt-test.exe tests/ipmi-kcs-test.exe tests/ipoctal232-test.exe
>> tests/m25p80-test.exe tests/megasas-test.exe tests/migration-test.exe
>> tests/ne2000-test.exe tests/numa-test.exe tests/nvme-test.exe
>> tests/pc-cpu-test.exe tests/pcnet-test.exe tests/pnv-xscom-test.exe
>> tests/prom-env-test.exe tests/pvpanic-test.exe tests/pxe-test.exe
>> tests/q35-test.exe tests/qmp-test.exe tests/qom-test.exe tests/rtas-test=
.exe
>> tests/rtc-test.exe tests/rtl8139-test.exe tests/spapr-phb-test.exe
>> tests/tco-test.exe tests/test-arm-mptimer.exe tests/test-hmp.exe
>> tests/test-netfilter.exe tests/test-x86-cpuid-compat.exe
>> tests/tmp105-test.exe tests/tpci200-test.exe tests/usb-hcd-ehci-test.exe
>> tests/usb-hcd-ohci-test.exe tests/usb-hcd-uhci-test.exe
>> tests/usb-hcd-xhci-test.exe tests/virtio-balloon-test.exe
>> tests/virtio-blk-test.exe tests/virtio-console-test.exe
>> tests/virtio-net-test.exe tests/virtio-rng-test.exe
>> tests/virtio-scsi-test.exe tests/virtio-serial-test.exe
>> tests/vmgenid-test.exe tests/vmxnet3-test.exe tests/wdt_ib700-test.exe
>> rm -f config.mak op-i386.h opc-i386.h gen-op-i386.h op-arm.h opc-arm.h
>> gen-op-arm.h
>> rm -f qemu-options.def
>> rm -f *.msi
>> find . \( -name '*.so' -o -name '*.dll' -o -name '*.mo' -o -name '*.[oda=
]'
>> \) -type f -exec rm {} +
>> rm -f qemu-ga qemu-img.exe qemu-io.exe  qemu-ga TAGS cscope.* *.pod *~
>> */*~
>> rm -f fsdev/*.pod scsi/*.pod
>> rm -f qemu-img-cmds.h
>> rm -f ui/shader/*-vert.h ui/shader/*-frag.h
>> rm -f trace/generated-tracers-dtrace.dtrace*
>> rm -f trace/generated-tracers-dtrace.h*
>> rm -f qemu-version.h qemu-version.h-timestamp config-host.h
>> config-host.h-timestamp qemu-options.def qemu-options.def-timestamp
>> qmp-commands.h qmp-commands.h-timestamp qapi-types.h qapi-types.h-timest=
amp
>> qapi-visit.h qapi-visit.h-timestamp qapi-event.h qapi-event.h-timestamp
>> qmp-marshal.c qmp-marshal.c-timestamp qapi-types.c qapi-types.c-timestam=
p
>> qapi-visit.c qapi-visit.c-timestamp qapi-event.c qapi-event.c-timestamp
>> qmp-introspect.h qmp-introspect.h-timestamp qmp-introspect.c
>> qmp-introspect.c-timestamp trace/generated-tcg-tracers.h
>> trace/generated-tcg-tracers.h-timestamp trace/generated-helpers-wrappers=
.h
>> trace/generated-helpers-wrappers.h-timestamp trace/generated-helpers.h
>> trace/generated-helpers.h-timestamp trace/generated-helpers.c
>> trace/generated-helpers.c-timestamp module_block.h module_block.h-timest=
amp
>> trace-root.h trace-root.h-timestamp util/trace.h util/trace.h-timestamp
>> crypto/trace.h crypto/trace.h-timestamp io/trace.h io/trace.h-timestamp
>> migration/trace.h migration/trace.h-timestamp block/trace.h
>> block/trace.h-timestamp chardev/trace.h chardev/trace.h-timestamp
>> hw/block/trace.h hw/block/trace.h-timestamp hw/block/dataplane/trace.h
>> hw/block/dataplane/trace.h-timestamp hw/char/trace.h
>> hw/char/trace.h-timestamp hw/intc/trace.h hw/intc/trace.h-timestamp
>> hw/net/trace.h hw/net/trace.h-timestamp hw/virtio/trace.h
>> hw/virtio/trace.h-timestamp hw/audio/trace.h hw/audio/trace.h-timestamp
>> hw/misc/trace.h hw/misc/trace.h-timestamp hw/usb/trace.h
>> hw/usb/trace.h-timestamp hw/scsi/trace.h hw/scsi/trace.h-timestamp
>> hw/nvram/trace.h hw/nvram/trace.h-timestamp hw/display/trace.h
>> hw/display/trace.h-timestamp hw/input/trace.h hw/input/trace.h-timestamp
>> hw/timer/trace.h hw/timer/trace.h-timestamp hw/dma/trace.h
>> hw/dma/trace.h-timestamp hw/sparc/trace.h hw/sparc/trace.h-timestamp
>> hw/sd/trace.h hw/sd/trace.h-timestamp hw/isa/trace.h
>> hw/isa/trace.h-timestamp hw/mem/trace.h hw/mem/trace.h-timestamp
>> hw/i386/trace.h hw/i386/trace.h-timestamp hw/i386/xen/trace.h
>> hw/i386/xen/trace.h-timestamp hw/9pfs/trace.h hw/9pfs/trace.h-timestamp
>> hw/ppc/trace.h hw/ppc/trace.h-timestamp hw/pci/trace.h
>> hw/pci/trace.h-timestamp hw/s390x/trace.h hw/s390x/trace.h-timestamp
>> hw/vfio/trace.h hw/vfio/trace.h-timestamp hw/acpi/trace.h
>> hw/acpi/trace.h-timestamp hw/arm/trace.h hw/arm/trace.h-timestamp
>> hw/alpha/trace.h hw/alpha/trace.h-timestamp hw/xen/trace.h
>> hw/xen/trace.h-timestamp hw/ide/trace.h hw/ide/trace.h-timestamp ui/trac=
e.h
>> ui/trace.h-timestamp audio/trace.h audio/trace.h-timestamp net/trace.h
>> net/trace.h-timestamp target/arm/trace.h target/arm/trace.h-timestamp
>> target/i386/trace.h target/i386/trace.h-timestamp target/mips/trace.h
>> target/mips/trace.h-timestamp target/sparc/trace.h
>> target/sparc/trace.h-timestamp target/s390x/trace.h
>> target/s390x/trace.h-timestamp target/ppc/trace.h
>> target/ppc/trace.h-timestamp qom/trace.h qom/trace.h-timestamp
>> linux-user/trace.h linux-user/trace.h-timestamp qapi/trace.h
>> qapi/trace.h-timestamp accel/tcg/trace.h accel/tcg/trace.h-timestamp
>> accel/kvm/trace.h accel/kvm/trace.h-timestamp nbd/trace.h
>> nbd/trace.h-timestamp scsi/trace.h scsi/trace.h-timestamp trace-root.c
>> trace-root.c-timestamp util/trace.c util/trace.c-timestamp crypto/trace.=
c
>> crypto/trace.c-timestamp io/trace.c io/trace.c-timestamp migration/trace=
.c
>> migration/trace.c-timestamp block/trace.c block/trace.c-timestamp
>> chardev/trace.c chardev/trace.c-timestamp hw/block/trace.c
>> hw/block/trace.c-timestamp hw/block/dataplane/trace.c
>> hw/block/dataplane/trace.c-timestamp hw/char/trace.c
>> hw/char/trace.c-timestamp hw/intc/trace.c hw/intc/trace.c-timestamp
>> hw/net/trace.c hw/net/trace.c-timestamp hw/virtio/trace.c
>> hw/virtio/trace.c-timestamp hw/audio/trace.c hw/audio/trace.c-timestamp
>> hw/misc/trace.c hw/misc/trace.c-timestamp hw/usb/trace.c
>> hw/usb/trace.c-timestamp hw/scsi/trace.c hw/scsi/trace.c-timestamp
>> hw/nvram/trace.c hw/nvram/trace.c-timestamp hw/display/trace.c
>> hw/display/trace.c-timestamp hw/input/trace.c hw/input/trace.c-timestamp
>> hw/timer/trace.c hw/timer/trace.c-timestamp hw/dma/trace.c
>> hw/dma/trace.c-timestamp hw/sparc/trace.c hw/sparc/trace.c-timestamp
>> hw/sd/trace.c hw/sd/trace.c-timestamp hw/isa/trace.c
>> hw/isa/trace.c-timestamp hw/mem/trace.c hw/mem/trace.c-timestamp
>> hw/i386/trace.c hw/i386/trace.c-timestamp hw/i386/xen/trace.c
>> hw/i386/xen/trace.c-timestamp hw/9pfs/trace.c hw/9pfs/trace.c-timestamp
>> hw/ppc/trace.c hw/ppc/trace.c-timestamp hw/pci/trace.c
>> hw/pci/trace.c-timestamp hw/s390x/trace.c hw/s390x/trace.c-timestamp
>> hw/vfio/trace.c hw/vfio/trace.c-timestamp hw/acpi/trace.c
>> hw/acpi/trace.c-timestamp hw/arm/trace.c hw/arm/trace.c-timestamp
>> hw/alpha/trace.c hw/alpha/trace.c-timestamp hw/xen/trace.c
>> hw/xen/trace.c-timestamp hw/ide/trace.c hw/ide/trace.c-timestamp ui/trac=
e.c
>> ui/trace.c-timestamp audio/trace.c audio/trace.c-timestamp net/trace.c
>> net/trace.c-timestamp target/arm/trace.c target/arm/trace.c-timestamp
>> target/i386/trace.c target/i386/trace.c-timestamp target/mips/trace.c
>> target/mips/trace.c-timestamp target/sparc/trace.c
>> target/sparc/trace.c-timestamp target/s390x/trace.c
>> target/s390x/trace.c-timestamp target/ppc/trace.c
>> target/ppc/trace.c-timestamp qom/trace.c qom/trace.c-timestamp
>> linux-user/trace.c linux-user/trace.c-timestamp qapi/trace.c
>> qapi/trace.c-timestamp accel/tcg/trace.c accel/tcg/trace.c-timestamp
>> accel/kvm/trace.c accel/kvm/trace.c-timestamp nbd/trace.c
>> nbd/trace.c-timestamp scsi/trace.c scsi/trace.c-timestamp
>> /tmp/qemu-test/build/trace-events-all
>> /tmp/qemu-test/build/trace-events-all-timestamp .git-submodule-status
>> .git-submodule-status-timestamp ui/input-keymap-linux-to-qcode.c
>> ui/input-keymap-linux-to-qcode.c-timestamp ui/input-keymap-qcode-to-qnum=
.c
>> ui/input-keymap-qcode-to-qnum.c-timestamp ui/input-keymap-qnum-to-qcode.=
c
>> ui/input-keymap-qnum-to-qcode.c-timestamp tests/test-qapi-types.h
>> tests/test-qapi-types.h-timestamp tests/test-qapi-visit.h
>> tests/test-qapi-visit.h-timestamp tests/test-qmp-commands.h
>> tests/test-qmp-commands.h-timestamp tests/test-qapi-event.h
>> tests/test-qapi-event.h-timestamp tests/test-qmp-introspect.h
>> tests/test-qmp-introspect.h-timestamp
>> rm -rf qapi-generated
>> rm -rf qga/qapi-generated
>> for d in x86_64-softmmu aarch64-softmmu pc-bios/optionrom; do \
>> if test -d $d; then make -C $d clean || exit 1; fi; \
>> rm -f $d/qemu-options.def; \
>>         done
>> make[1]: Entering directory '/tmp/qemu-test/build/x86_64-softmmu'
>> rm -f *.timestamp
>> rm -f *.a *~ qemu-system-x86_64.exe
>> rm -f
>> rm -f hmp-commands.h gdbstub-xml.c
>> make[1]: Leaving directory '/tmp/qemu-test/build/x86_64-softmmu'
>> make[1]: Entering directory '/tmp/qemu-test/build/aarch64-softmmu'
>> rm -f *.timestamp
>> rm -f *.a *~ qemu-system-aarch64.exe
>> rm -f
>> rm -f hmp-commands.h gdbstub-xml.c
>> make[1]: Leaving directory '/tmp/qemu-test/build/aarch64-softmmu'
>> make[1]: Entering directory '/tmp/qemu-test/build/pc-bios/optionrom'
>> rm -f *.timestamp
>> rm -f *.o *.d *.raw *.img *.bin *~
>> make[1]: Leaving directory '/tmp/qemu-test/build/pc-bios/optionrom'
>> rm -f  x86_64-softmmu/config-devices.mak
>> aarch64-softmmu/config-devices.mak config-all-devices.mak
>> Configure options:
>> --enable-werror --target-list=3Dx86_64-softmmu,aarch64-softmmu
>> --prefix=3D/tmp/qemu-test/install --cross-prefix=3Di686-w64-mingw32-
>> --enable-trace-backends=3Dsimple --enable-debug --enable-gnutls
>> --enable-nettle --enable-curl --enable-vnc --enable-bzip2
>> --enable-guest-agent --with-sdlabi=3D1.2 --with-gtkabi=3D2.0
>> Install prefix    /tmp/qemu-test/install
>> BIOS directory    /tmp/qemu-test/install
>> firmware path     /tmp/qemu-test/install/share/qemu-firmware
>> binary directory  /tmp/qemu-test/install
>> library directory /tmp/qemu-test/install/lib
>> module directory  /tmp/qemu-test/install/lib
>> libexec directory /tmp/qemu-test/install/libexec
>> include directory /tmp/qemu-test/install/include
>> config directory  /tmp/qemu-test/install
>> local state directory   queried at runtime
>> Windows SDK       no
>> Source path       /tmp/qemu-test/src
>> GIT binary        git
>> GIT submodules
>> C compiler        i686-w64-mingw32-gcc
>> Host C compiler   cc
>> C++ compiler      i686-w64-mingw32-g++
>> Objective-C compiler clang
>> ARFLAGS           rv
>> CFLAGS            -g
>> QEMU_CFLAGS       -I/usr/i686-w64-mingw32/sys-root/mingw/include/pixman-=
1
>> -I$(SRC_PATH)/dtc/libfdt -Werror -mms-bitfields
>> -I/usr/i686-w64-mingw32/sys-root/mingw/include/glib-2.0
>> -I/usr/i686-w64-mingw32/sys-root/mingw/lib/glib-2.0/include
>> -I/usr/i686-w64-mingw32/sys-root/mingw/include  -m32 -mthreads
>> -D__USE_MINGW_ANSI_STDIO=3D1 -DWIN32_LEAN_AND_MEAN -DWINVER=3D0x501
>> -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -Wstrict-prot=
otypes
>> -Wredundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-prototypes
>> -fno-strict-aliasing -fno-common -fwrapv  -Wendif-labels
>> -Wno-shift-negative-value -Wno-missing-include-dirs -Wempty-body
>> -Wnested-externs -Wformat-security -Wformat-y2k -Winit-self
>> -Wignored-qualifiers -Wold-style-declaration -Wold-style-definition
>> -Wtype-limits -fstack-protector-strong
>> -I/usr/i686-w64-mingw32/sys-root/mingw/include
>> -I/usr/i686-w64-mingw32/sys-root/mingw/include/p11-kit-1
>> -I/usr/i686-w64-mingw32/sys-root/mingw/include
>> -I/usr/i686-w64-mingw32/sys-root/mingw/include
>> -I/usr/i686-w64-mingw32/sys-root/mingw/include/libpng16
>> LDFLAGS           -Wl,--nxcompat -Wl,--no-seh -Wl,--dynamicbase
>> -Wl,--warn-common -m32 -g
>> make              make
>> install           install
>> python            python -B
>> smbd              /usr/sbin/smbd
>> module support    no
>> host CPU          i386
>> host big endian   no
>> target list       x86_64-softmmu aarch64-softmmu
>> gprof enabled     no
>> sparse enabled    no
>> strip binaries    no
>> profiler          no
>> static build      no
>> SDL support       yes (1.2.15)
>> GTK support       yes (2.24.31)
>> GTK GL support    no
>> VTE support       no
>> TLS priority      NORMAL
>> GNUTLS support    yes
>> GNUTLS rnd        yes
>> libgcrypt         no
>> libgcrypt kdf     no
>> nettle            yes (3.3)
>> nettle kdf        yes
>> libtasn1          yes
>> curses support    no
>> virgl support     no
>> curl support      yes
>> mingw32 support   yes
>> Audio drivers     dsound
>> Block whitelist (rw)
>> Block whitelist (ro)
>> VirtFS support    no
>> Multipath support no
>> VNC support       yes
>> VNC SASL support  no
>> VNC JPEG support  yes
>> VNC PNG support   yes
>> xen support       no
>> brlapi support    no
>> bluez  support    no
>> Documentation     no
>> PIE               no
>> vde support       no
>> netmap support    no
>> Linux AIO support no
>> ATTR/XATTR support no
>> Install blobs     yes
>> KVM support       no
>> HAX support       yes
>> TCG support       yes
>> TCG debug enabled yes
>> TCG interpreter   no
>> RDMA support      no
>> fdt support       yes
>> preadv support    no
>> fdatasync         no
>> madvise           no
>> posix_madvise     no
>> libcap-ng support no
>> vhost-net support no
>> vhost-scsi support no
>> vhost-vsock support no
>> vhost-user support no
>> Trace backends    simple
>> Trace output file trace-<pid>
>> spice support     no
>> rbd support       no
>> xfsctl support    no
>> smartcard support no
>> libusb            no
>> usb net redir     no
>> OpenGL support    no
>> OpenGL dmabufs    no
>> libiscsi support  no
>> libnfs support    no
>> build guest agent yes
>> QGA VSS support   no
>> QGA w32 disk info yes
>> QGA MSI support   no
>> seccomp support   no
>> coroutine backend win32
>> coroutine pool    yes
>> debug stack usage no
>> crypto afalg      no
>> GlusterFS support no
>> gcov              gcov
>> gcov enabled      no
>> TPM support       yes
>> libssh2 support   yes
>> TPM passthrough   no
>> TPM emulator      no
>> QOM debugging     yes
>> Live block migration yes
>> lzo support       no
>> snappy support    no
>> bzip2 support     yes
>> NUMA host support no
>> tcmalloc support  no
>> jemalloc support  no
>> avx2 optimization yes
>> replication support yes
>> VxHS block device no
>> capstone          no
>> mkdir -p dtc/libfdt
>> mkdir -p dtc/tests
>>   GEN     x86_64-softmmu/config-devices.mak.tmp
>>   GEN     aarch64-softmmu/config-devices.mak.tmp
>>   GEN     config-host.h
>>   GEN     qmp-commands.h
>>   GEN     qemu-options.def
>>   GEN     qapi-visit.h
>>   GEN     qapi-types.h
>>   GEN     qapi-event.h
>>   GEN     x86_64-softmmu/config-devices.mak
>>   GEN     aarch64-softmmu/config-devices.mak
>>   GEN     qmp-marshal.c
>>   GEN     qapi-types.c
>>   GEN     qapi-visit.c
>>   GEN     qapi-event.c
>>   GEN     qmp-introspect.h
>>   GEN     qmp-introspect.c
>>   GEN     trace/generated-tcg-tracers.h
>>   GEN     trace/generated-helpers-wrappers.h
>>   GEN     trace/generated-helpers.h
>>   GEN     trace/generated-helpers.c
>>   GEN     module_block.h
>>   GEN     ui/input-keymap-linux-to-qcode.c
>>   GEN     ui/input-keymap-qcode-to-qnum.c
>>   GEN     ui/input-keymap-qnum-to-qcode.c
>>   GEN     tests/test-qapi-types.h
>>   GEN     tests/test-qapi-visit.h
>>   GEN     tests/test-qmp-commands.h
>>   GEN     tests/test-qapi-event.h
>>   GEN     tests/test-qmp-introspect.h
>>   GEN     trace-root.h
>>   GEN     util/trace.h
>>   GEN     crypto/trace.h
>>   GEN     io/trace.h
>>   GEN     migration/trace.h
>>   GEN     block/trace.h
>>   GEN     chardev/trace.h
>>   GEN     hw/block/trace.h
>>   GEN     hw/block/dataplane/trace.h
>>   GEN     hw/char/trace.h
>>   GEN     hw/intc/trace.h
>>   GEN     hw/net/trace.h
>>   GEN     hw/virtio/trace.h
>>   GEN     hw/audio/trace.h
>>   GEN     hw/misc/trace.h
>>   GEN     hw/usb/trace.h
>>   GEN     hw/scsi/trace.h
>>   GEN     hw/nvram/trace.h
>>   GEN     hw/display/trace.h
>>   GEN     hw/input/trace.h
>>   GEN     hw/timer/trace.h
>>   GEN     hw/dma/trace.h
>>   GEN     hw/sparc/trace.h
>>   GEN     hw/sd/trace.h
>>   GEN     hw/isa/trace.h
>>   GEN     hw/mem/trace.h
>>   GEN     hw/i386/trace.h
>>   GEN     hw/i386/xen/trace.h
>>   GEN     hw/9pfs/trace.h
>>   GEN     hw/ppc/trace.h
>>   GEN     hw/pci/trace.h
>>   GEN     hw/s390x/trace.h
>>   GEN     hw/vfio/trace.h
>>   GEN     hw/acpi/trace.h
>>   GEN     hw/arm/trace.h
>>   GEN     hw/alpha/trace.h
>>   GEN     hw/xen/trace.h
>>   GEN     hw/ide/trace.h
>>   GEN     ui/trace.h
>>   GEN     audio/trace.h
>>   GEN     net/trace.h
>>   GEN     target/arm/trace.h
>>   GEN     target/i386/trace.h
>>   GEN     target/mips/trace.h
>>   GEN     target/sparc/trace.h
>>   GEN     target/s390x/trace.h
>>   GEN     target/ppc/trace.h
>>   GEN     qom/trace.h
>>   GEN     linux-user/trace.h
>>   GEN     qapi/trace.h
>>   GEN     accel/tcg/trace.h
>>   GEN     accel/kvm/trace.h
>>   GEN     nbd/trace.h
>>   GEN     scsi/trace.h
>>   GEN     trace-root.c
>>   GEN     util/trace.c
>>   GEN     crypto/trace.c
>>   GEN     io/trace.c
>>   GEN     migration/trace.c
>>   GEN     block/trace.c
>>   GEN     chardev/trace.c
>>   GEN     hw/block/trace.c
>>   GEN     hw/block/dataplane/trace.c
>>   GEN     hw/char/trace.c
>>   GEN     hw/intc/trace.c
>>   GEN     hw/net/trace.c
>>   GEN     hw/virtio/trace.c
>>   GEN     hw/audio/trace.c
>>   GEN     hw/misc/trace.c
>>   GEN     hw/usb/trace.c
>>   GEN     hw/scsi/trace.c
>>   GEN     hw/nvram/trace.c
>>   GEN     hw/display/trace.c
>>   GEN     hw/input/trace.c
>>   GEN     hw/timer/trace.c
>>   GEN     hw/dma/trace.c
>>   GEN     hw/sparc/trace.c
>>   GEN     hw/sd/trace.c
>>   GEN     hw/isa/trace.c
>>   GEN     hw/mem/trace.c
>>   GEN     hw/i386/trace.c
>>   GEN     hw/i386/xen/trace.c
>>   GEN     hw/9pfs/trace.c
>>   GEN     hw/ppc/trace.c
>>   GEN     hw/pci/trace.c
>>   GEN     hw/s390x/trace.c
>>   GEN     hw/vfio/trace.c
>>   GEN     hw/acpi/trace.c
>>   GEN     hw/arm/trace.c
>>   GEN     hw/alpha/trace.c
>>   GEN     hw/xen/trace.c
>>   GEN     hw/ide/trace.c
>>   GEN     ui/trace.c
>>   GEN     audio/trace.c
>>   GEN     net/trace.c
>>   GEN     target/arm/trace.c
>>   GEN     target/i386/trace.c
>>   GEN     target/mips/trace.c
>>   GEN     target/sparc/trace.c
>>   GEN     target/s390x/trace.c
>>   GEN     target/ppc/trace.c
>>   GEN     qom/trace.c
>>   GEN     linux-user/trace.c
>>   GEN     qapi/trace.c
>>   GEN     accel/tcg/trace.c
>>   GEN     accel/kvm/trace.c
>>   GEN     nbd/trace.c
>>   GEN     scsi/trace.c
>>   GEN     config-all-devices.mak
>>          DEP /tmp/qemu-test/src/dtc/tests/dumptrees.c
>>          DEP /tmp/qemu-test/src/dtc/tests/trees.S
>>          DEP /tmp/qemu-test/src/dtc/tests/testutils.c
>>          DEP /tmp/qemu-test/src/dtc/tests/value-labels.c
>>          DEP /tmp/qemu-test/src/dtc/tests/asm_tree_dump.c
>>          DEP /tmp/qemu-test/src/dtc/tests/truncated_property.c
>>          DEP /tmp/qemu-test/src/dtc/tests/check_path.c
>>          DEP /tmp/qemu-test/src/dtc/tests/overlay_bad_fixup.c
>>          DEP /tmp/qemu-test/src/dtc/tests/overlay.c
>>          DEP /tmp/qemu-test/src/dtc/tests/subnode_iterate.c
>>          DEP /tmp/qemu-test/src/dtc/tests/property_iterate.c
>>          DEP /tmp/qemu-test/src/dtc/tests/integer-expressions.c
>>          DEP /tmp/qemu-test/src/dtc/tests/utilfdt_test.c
>>          DEP /tmp/qemu-test/src/dtc/tests/path_offset_aliases.c
>>          DEP /tmp/qemu-test/src/dtc/tests/dtbs_equal_unordered.c
>>          DEP /tmp/qemu-test/src/dtc/tests/add_subnode_with_nops.c
>>          DEP /tmp/qemu-test/src/dtc/tests/dtb_reverse.c
>>          DEP /tmp/qemu-test/src/dtc/tests/dtbs_equal_ordered.c
>>          DEP /tmp/qemu-test/src/dtc/tests/extra-terminating-null.c
>>          DEP /tmp/qemu-test/src/dtc/tests/incbin.c
>>          DEP /tmp/qemu-test/src/dtc/tests/phandle_format.c
>>          DEP /tmp/qemu-test/src/dtc/tests/path-references.c
>>          DEP /tmp/qemu-test/src/dtc/tests/boot-cpuid.c
>>          DEP /tmp/qemu-test/src/dtc/tests/references.c
>>          DEP /tmp/qemu-test/src/dtc/tests/string_escapes.c
>>          DEP /tmp/qemu-test/src/dtc/tests/propname_escapes.c
>>          DEP /tmp/qemu-test/src/dtc/tests/appendprop2.c
>>          DEP /tmp/qemu-test/src/dtc/tests/appendprop1.c
>>          DEP /tmp/qemu-test/src/dtc/tests/del_node.c
>>          DEP /tmp/qemu-test/src/dtc/tests/del_property.c
>>          DEP /tmp/qemu-test/src/dtc/tests/setprop.c
>>          DEP /tmp/qemu-test/src/dtc/tests/set_name.c
>>          DEP /tmp/qemu-test/src/dtc/tests/rw_tree1.c
>>          DEP /tmp/qemu-test/src/dtc/tests/open_pack.c
>>          DEP /tmp/qemu-test/src/dtc/tests/nopulate.c
>>          DEP /tmp/qemu-test/src/dtc/tests/mangle-layout.c
>>          DEP /tmp/qemu-test/src/dtc/tests/move_and_save.c
>>          DEP /tmp/qemu-test/src/dtc/tests/sw_tree1.c
>>          DEP /tmp/qemu-test/src/dtc/tests/nop_node.c
>>          DEP /tmp/qemu-test/src/dtc/tests/nop_property.c
>>          DEP /tmp/qemu-test/src/dtc/tests/setprop_inplace.c
>>          DEP /tmp/qemu-test/src/dtc/tests/stringlist.c
>>          DEP /tmp/qemu-test/src/dtc/tests/addr_size_cells.c
>>          DEP /tmp/qemu-test/src/dtc/tests/notfound.c
>>          DEP /tmp/qemu-test/src/dtc/tests/sized_cells.c
>>          DEP /tmp/qemu-test/src/dtc/tests/char_literal.c
>>          DEP /tmp/qemu-test/src/dtc/tests/get_alias.c
>>          DEP /tmp/qemu-test/src/dtc/tests/node_offset_by_compatible.c
>>          DEP /tmp/qemu-test/src/dtc/tests/node_check_compatible.c
>>          DEP /tmp/qemu-test/src/dtc/tests/node_offset_by_phandle.c
>>          DEP /tmp/qemu-test/src/dtc/tests/node_offset_by_prop_value.c
>>          DEP /tmp/qemu-test/src/dtc/tests/parent_offset.c
>>          DEP /tmp/qemu-test/src/dtc/tests/supernode_atdepth_offset.c
>>          DEP /tmp/qemu-test/src/dtc/tests/get_path.c
>>          DEP /tmp/qemu-test/src/dtc/tests/get_phandle.c
>>          DEP /tmp/qemu-test/src/dtc/tests/getprop.c
>>          DEP /tmp/qemu-test/src/dtc/tests/path_offset.c
>>          DEP /tmp/qemu-test/src/dtc/tests/get_name.c
>>          DEP /tmp/qemu-test/src/dtc/tests/subnode_offset.c
>>          DEP /tmp/qemu-test/src/dtc/tests/find_property.c
>>          DEP /tmp/qemu-test/src/dtc/tests/root_node.c
>>          DEP /tmp/qemu-test/src/dtc/tests/get_mem_rsv.c
>>          DEP /tmp/qemu-test/src/dtc/libfdt/fdt_overlay.c
>>          DEP /tmp/qemu-test/src/dtc/libfdt/fdt_addresses.c
>>          DEP /tmp/qemu-test/src/dtc/libfdt/fdt_empty_tree.c
>>          DEP /tmp/qemu-test/src/dtc/libfdt/fdt_strerror.c
>>          DEP /tmp/qemu-test/src/dtc/libfdt/fdt_rw.c
>>          DEP /tmp/qemu-test/src/dtc/libfdt/fdt_sw.c
>>          DEP /tmp/qemu-test/src/dtc/libfdt/fdt_wip.c
>>          DEP /tmp/qemu-test/src/dtc/libfdt/fdt_ro.c
>>          DEP /tmp/qemu-test/src/dtc/libfdt/fdt.c
>>          DEP /tmp/qemu-test/src/dtc/util.c
>>          DEP /tmp/qemu-test/src/dtc/fdtput.c
>>          DEP /tmp/qemu-test/src/dtc/fdtget.c
>>          DEP /tmp/qemu-test/src/dtc/fdtdump.c
>>          DEP convert-dtsv0-lexer.lex.c
>>          DEP /tmp/qemu-test/src/dtc/srcpos.c
>>          DEP dtc-parser.tab.c
>>          DEP dtc-lexer.lex.c
>>          DEP /tmp/qemu-test/src/dtc/treesource.c
>>          DEP /tmp/qemu-test/src/dtc/livetree.c
>>          DEP /tmp/qemu-test/src/dtc/fstree.c
>>          DEP /tmp/qemu-test/src/dtc/flattree.c
>>          DEP /tmp/qemu-test/src/dtc/dtc.c
>>          DEP /tmp/qemu-test/src/dtc/data.c
>>          DEP /tmp/qemu-test/src/dtc/checks.c
>>          CC libfdt/fdt.o
>>          CC libfdt/fdt_wip.o
>>          CC libfdt/fdt_ro.o
>>          CC libfdt/fdt_sw.o
>>          CC libfdt/fdt_strerror.o
>>          CC libfdt/fdt_empty_tree.o
>>          CC libfdt/fdt_rw.o
>>          CC libfdt/fdt_addresses.o
>>          CC libfdt/fdt_overlay.o
>>          AR libfdt/libfdt.a
>> i686-w64-mingw32-ar: creating libfdt/libfdt.a
>> a - libfdt/fdt.o
>> a - libfdt/fdt_ro.o
>> a - libfdt/fdt_wip.o
>> a - libfdt/fdt_sw.o
>> a - libfdt/fdt_rw.o
>> a - libfdt/fdt_strerror.o
>> a - libfdt/fdt_empty_tree.o
>> a - libfdt/fdt_addresses.o
>> a - libfdt/fdt_overlay.o
>>   RC      version.o
>> mkdir -p dtc/libfdt
>> mkdir -p dtc/tests
>>   GEN     qga/qapi-generated/qga-qapi-types.h
>>   GEN     qga/qapi-generated/qga-qmp-commands.h
>>   GEN     qga/qapi-generated/qga-qapi-types.c
>>   GEN     qga/qapi-generated/qga-qapi-visit.h
>>   GEN     qga/qapi-generated/qga-qmp-marshal.c
>>   GEN     qga/qapi-generated/qga-qapi-visit.c
>>   CC      qmp-introspect.o
>>   CC      qapi-types.o
>>   CC      qapi-visit.o
>>   CC      qapi-event.o
>>   CC      qapi/qapi-visit-core.o
>>   CC      qapi/qapi-dealloc-visitor.o
>>   CC      qapi/qobject-input-visitor.o
>>   CC      qapi/qobject-output-visitor.o
>>   CC      qapi/qmp-registry.o
>>   CC      qapi/qmp-dispatch.o
>>   CC      qapi/string-input-visitor.o
>>   CC      qapi/string-output-visitor.o
>>   CC      qapi/opts-visitor.o
>>   CC      qapi/qapi-clone-visitor.o
>>   CC      qapi/qmp-event.o
>>   CC      qapi/qapi-util.o
>>   CC      qobject/qnull.o
>>   CC      qobject/qnum.o
>>   CC      qobject/qstring.o
>>   CC      qobject/qdict.o
>>   CC      qobject/qlist.o
>>   CC      qobject/qbool.o
>>   CC      qobject/qlit.o
>>   CC      qobject/qjson.o
>>   CC      qobject/qobject.o
>>   CC      qobject/json-lexer.o
>>   CC      qobject/json-streamer.o
>>   CC      trace/simple.o
>>   CC      qobject/json-parser.o
>>   CC      trace/control.o
>>   CC      trace/qmp.o
>>   CC      util/osdep.o
>>   CC      util/cutils.o
>>   CC      util/unicode.o
>>   CC      util/qemu-timer-common.o
>>   CC      util/bufferiszero.o
>>   CC      util/lockcnt.o
>>   CC      util/aiocb.o
>>   CC      util/async.o
>>   CC      util/thread-pool.o
>>   CC      util/qemu-timer.o
>>   CC      util/main-loop.o
>>   CC      util/iohandler.o
>>   CC      util/aio-win32.o
>>   CC      util/event_notifier-win32.o
>>   CC      util/oslib-win32.o
>>   CC      util/qemu-thread-win32.o
>>   CC      util/envlist.o
>>   CC      util/path.o
>>   CC      util/module.o
>>   CC      util/host-utils.o
>>   CC      util/bitmap.o
>>   CC      util/hbitmap.o
>>   CC      util/fifo8.o
>>   CC      util/bitops.o
>>   CC      util/acl.o
>>   CC      util/cacheinfo.o
>>   CC      util/error.o
>>   CC      util/qemu-error.o
>>   CC      util/id.o
>>   CC      util/qemu-config.o
>>   CC      util/iov.o
>>   CC      util/qemu-sockets.o
>>   CC      util/uri.o
>>   CC      util/notify.o
>>   CC      util/qemu-option.o
>>   CC      util/qemu-progress.o
>>   CC      util/keyval.o
>>   CC      util/hexdump.o
>>   CC      util/uuid.o
>>   CC      util/throttle.o
>>   CC      util/crc32c.o
>>   CC      util/getauxval.o
>>   CC      util/readline.o
>>   CC      util/rcu.o
>>   CC      util/qemu-coroutine.o
>>   CC      util/qemu-coroutine-lock.o
>>   CC      util/qemu-coroutine-io.o
>>   CC      util/qemu-coroutine-sleep.o
>>   CC      util/coroutine-win32.o
>>   CC      util/buffer.o
>>   CC      util/timed-average.o
>>   CC      util/base64.o
>>   CC      util/log.o
>>   CC      util/qdist.o
>>   CC      util/pagesize.o
>>   CC      util/range.o
>>   CC      util/qht.o
>>   CC      util/stats64.o
>>   CC      trace-root.o
>>   CC      util/systemd.o
>>   CC      util/trace.o
>>   CC      io/trace.o
>>   CC      block/trace.o
>>   CC      crypto/trace.o
>>   CC      migration/trace.o
>>   CC      chardev/trace.o
>>   CC      hw/block/trace.o
>>   CC      hw/block/dataplane/trace.o
>>   CC      hw/char/trace.o
>>   CC      hw/intc/trace.o
>>   CC      hw/net/trace.o
>>   CC      hw/virtio/trace.o
>>   CC      hw/audio/trace.o
>>   CC      hw/misc/trace.o
>>   CC      hw/usb/trace.o
>>   CC      hw/scsi/trace.o
>>   CC      hw/nvram/trace.o
>>   CC      hw/display/trace.o
>>   CC      hw/input/trace.o
>>   CC      hw/timer/trace.o
>>   CC      hw/dma/trace.o
>>   CC      hw/sparc/trace.o
>>   CC      hw/sd/trace.o
>>   CC      hw/isa/trace.o
>>   CC      hw/mem/trace.o
>>   CC      hw/i386/trace.o
>>   CC      hw/i386/xen/trace.o
>>   CC      hw/9pfs/trace.o
>>   CC      hw/ppc/trace.o
>>   CC      hw/pci/trace.o
>>   CC      hw/s390x/trace.o
>>   CC      hw/vfio/trace.o
>>   CC      hw/acpi/trace.o
>>   CC      hw/arm/trace.o
>>   CC      hw/alpha/trace.o
>>   CC      hw/xen/trace.o
>>   CC      hw/ide/trace.o
>>   CC      ui/trace.o
>>   CC      audio/trace.o
>>   CC      net/trace.o
>>   CC      target/arm/trace.o
>>   CC      target/i386/trace.o
>>   CC      target/mips/trace.o
>>   CC      target/sparc/trace.o
>>   CC      target/s390x/trace.o
>>   CC      target/ppc/trace.o
>>   CC      qom/trace.o
>>   CC      linux-user/trace.o
>>   CC      qapi/trace.o
>>   CC      accel/tcg/trace.o
>>   CC      accel/kvm/trace.o
>>   CC      nbd/trace.o
>>   CC      scsi/trace.o
>>   CC      crypto/pbkdf-stub.o
>>   CC      stubs/arch-query-cpu-def.o
>>   CC      stubs/arch-query-cpu-model-comparison.o
>>   CC      stubs/arch-query-cpu-model-expansion.o
>>   CC      stubs/arch-query-cpu-model-baseline.o
>>   CC      stubs/bdrv-next-monitor-owned.o
>>   CC      stubs/blk-commit-all.o
>>   CC      stubs/blockdev-close-all-bdrv-states.o
>>   CC      stubs/clock-warp.o
>>   CC      stubs/cpu-get-clock.o
>>   CC      stubs/cpu-get-icount.o
>>   CC      stubs/dump.o
>>   CC      stubs/error-printf.o
>>   CC      stubs/fdset.o
>>   CC      stubs/gdbstub.o
>>   CC      stubs/iothread.o
>>   CC      stubs/get-vm-name.o
>>   CC      stubs/iothread-lock.o
>>   CC      stubs/is-daemonized.o
>>   CC      stubs/machine-init-done.o
>>   CC      stubs/migr-blocker.o
>>   CC      stubs/change-state-handler.o
>>   CC      stubs/monitor.o
>>   CC      stubs/notify-event.o
>>   CC      stubs/qtest.o
>>   CC      stubs/replay.o
>>   CC      stubs/runstate-check.o
>>   CC      stubs/set-fd-handler.o
>>   CC      stubs/slirp.o
>>   CC      stubs/sysbus.o
>>   CC      stubs/trace-control.o
>>   CC      stubs/tpm.o
>>   CC      stubs/uuid.o
>>   CC      stubs/vm-stop.o
>>   CC      stubs/vmstate.o
>>   CC      stubs/fd-register.o
>>   CC      stubs/qmp_pc_dimm.o
>>   CC      stubs/target-get-monitor-def.o
>>   CC      stubs/target-monitor-defs.o
>>   CC      stubs/pc_madt_cpu_entry.o
>>   CC      stubs/vmgenid.o
>>   CC      stubs/xen-common.o
>>   CC      stubs/xen-hvm.o
>>   CC      stubs/pci-host-piix.o
>>   GEN     qemu-img-cmds.h
>>   CC      block.o
>>   CC      blockjob.o
>>   CC      qemu-io-cmds.o
>>   CC      replication.o
>>   CC      block/raw-format.o
>>   CC      block/qcow.o
>>   CC      block/vdi.o
>>   CC      block/vmdk.o
>>   CC      block/cloop.o
>>   CC      block/bochs.o
>>   CC      block/vpc.o
>>   CC      block/vvfat.o
>>   CC      block/dmg.o
>>   CC      block/qcow2.o
>>   CC      block/qcow2-refcount.o
>>   CC      block/qcow2-cluster.o
>>   CC      block/qcow2-snapshot.o
>>   CC      block/qcow2-cache.o
>>   CC      block/qed.o
>>   CC      block/qcow2-bitmap.o
>>   CC      block/qed-l2-cache.o
>>   CC      block/qed-table.o
>>   CC      block/qed-cluster.o
>>   CC      block/qed-check.o
>>   CC      block/vhdx.o
>>   CC      block/vhdx-endian.o
>>   CC      block/vhdx-log.o
>>   CC      block/quorum.o
>>   CC      block/parallels.o
>>   CC      block/blkverify.o
>>   CC      block/blkdebug.o
>>   CC      block/blkreplay.o
>>   CC      block/block-backend.o
>>   CC      block/snapshot.o
>>   CC      block/qapi.o
>>   CC      block/file-win32.o
>>   CC      block/win32-aio.o
>>   CC      block/null.o
>>   CC      block/mirror.o
>>   CC      block/commit.o
>>   CC      block/io.o
>>   CC      block/throttle-groups.o
>>   CC      block/nbd-client.o
>>   CC      block/nbd.o
>>   CC      block/sheepdog.o
>>   CC      block/accounting.o
>>   CC      block/dirty-bitmap.o
>>   CC      block/write-threshold.o
>>   CC      block/backup.o
>>   CC      block/replication.o
>>   CC      block/throttle.o
>>   CC      block/crypto.o
>>   CC      nbd/server.o
>>   CC      nbd/client.o
>>   CC      nbd/common.o
>>   CC      scsi/utils.o
>>   CC      block/curl.o
>>   CC      block/ssh.o
>>   CC      block/dmg-bz2.o
>>   CC      crypto/hash.o
>>   CC      crypto/init.o
>>   CC      crypto/hash-nettle.o
>>   CC      crypto/hmac-nettle.o
>>   CC      crypto/hmac.o
>>   CC      crypto/aes.o
>>   CC      crypto/desrfb.o
>>   CC      crypto/cipher.o
>>   CC      crypto/tlscreds.o
>>   CC      crypto/tlscredsanon.o
>>   CC      crypto/tlscredsx509.o
>>   CC      crypto/tlssession.o
>>   CC      crypto/secret.o
>>   CC      crypto/random-gnutls.o
>>   CC      crypto/pbkdf.o
>>   CC      crypto/pbkdf-nettle.o
>>   CC      crypto/ivgen.o
>>   CC      crypto/ivgen-essiv.o
>>   CC      crypto/ivgen-plain64.o
>>   CC      crypto/ivgen-plain.o
>>   CC      crypto/afsplit.o
>>   CC      crypto/xts.o
>>   CC      crypto/block.o
>>   CC      crypto/block-qcow.o
>>   CC      crypto/block-luks.o
>>   CC      io/channel.o
>>   CC      io/channel-command.o
>>   CC      io/channel-buffer.o
>>   CC      io/channel-file.o
>>   CC      io/channel-socket.o
>>   CC      io/channel-tls.o
>>   CC      io/channel-watch.o
>>   CC      io/channel-websock.o
>>   CC      io/channel-util.o
>>   CC      io/dns-resolver.o
>>   CC      io/task.o
>>   CC      qom/object.o
>>   CC      qom/container.o
>>   CC      qom/qom-qobject.o
>>   CC      qom/object_interfaces.o
>>   CC      qemu-io.o
>>   CC      blockdev.o
>>   CC      blockdev-nbd.o
>>   CC      bootdevice.o
>>   CC      iothread.o
>>   CC      qdev-monitor.o
>>   CC      device-hotplug.o
>>   CC      os-win32.o
>>   CC      bt-host.o
>>   CC      bt-vhci.o
>>   CC      dma-helpers.o
>>   CC      vl.o
>>   CC      tpm.o
>>   CC      device_tree.o
>>   CC      qmp-marshal.o
>>   CC      qmp.o
>>   CC      hmp.o
>>   CC      cpus-common.o
>>   CC      audio/audio.o
>>   CC      audio/noaudio.o
>>   CC      audio/wavaudio.o
>>   CC      audio/mixeng.o
>>   CC      audio/sdlaudio.o
>>   CC      audio/dsoundaudio.o
>>   CC      audio/wavcapture.o
>>   CC      backends/rng.o
>>   CC      audio/audio_win_int.o
>>   CC      backends/rng-egd.o
>>   CC      backends/tpm.o
>>   CC      backends/hostmem.o
>>   CC      backends/cryptodev.o
>>   CC      backends/cryptodev-builtin.o
>>   CC      backends/hostmem-ram.o
>>   CC      block/stream.o
>>   CC      chardev/msmouse.o
>>   CC      chardev/wctablet.o
>>   CC      chardev/testdev.o
>>   CC      disas/arm.o
>>   CXX     disas/arm-a64.o
>>   CXX     disas/libvixl/vixl/utils.o
>>   CC      disas/i386.o
>>   CXX     disas/libvixl/vixl/compiler-intrinsics.o
>>   CXX     disas/libvixl/vixl/a64/instructions-a64.o
>>   CXX     disas/libvixl/vixl/a64/decoder-a64.o
>>   CXX     disas/libvixl/vixl/a64/disasm-a64.o
>>   CC      hw/acpi/core.o
>>   CC      hw/acpi/piix4.o
>>   CC      hw/acpi/pcihp.o
>>   CC      hw/acpi/ich9.o
>>   CC      hw/acpi/tco.o
>>   CC      hw/acpi/cpu_hotplug.o
>>   CC      hw/acpi/memory_hotplug.o
>>   CC      hw/acpi/cpu.o
>>   CC      hw/acpi/nvdimm.o
>>   CC      hw/acpi/vmgenid.o
>>   CC      hw/acpi/acpi_interface.o
>>   CC      hw/acpi/bios-linker-loader.o
>>   CC      hw/acpi/aml-build.o
>>   CC      hw/acpi/ipmi.o
>>   CC      hw/acpi/acpi-stub.o
>>   CC      hw/acpi/ipmi-stub.o
>>   CC      hw/audio/sb16.o
>>   CC      hw/audio/es1370.o
>>   CC      hw/audio/ac97.o
>>   CC      hw/audio/fmopl.o
>>   CC      hw/audio/adlib.o
>>   CC      hw/audio/gusemu_hal.o
>>   CC      hw/audio/gus.o
>>   CC      hw/audio/gusemu_mixer.o
>>   CC      hw/audio/cs4231a.o
>>   CC      hw/audio/hda-codec.o
>>   CC      hw/audio/intel-hda.o
>>   CC      hw/audio/pcspk.o
>>   CC      hw/audio/wm8750.o
>>   CC      hw/audio/lm4549.o
>>   CC      hw/audio/pl041.o
>>   CC      hw/audio/marvell_88w8618.o
>>   CC      hw/audio/soundhw.o
>>   CC      hw/block/cdrom.o
>>   CC      hw/block/block.o
>>   CC      hw/block/hd-geometry.o
>>   CC      hw/block/fdc.o
>>   CC      hw/block/m25p80.o
>>   CC      hw/block/nand.o
>>   CC      hw/block/pflash_cfi01.o
>>   CC      hw/block/pflash_cfi02.o
>>   CC      hw/block/ecc.o
>>   CC      hw/block/onenand.o
>>   CC      hw/block/nvme.o
>>   CC      hw/bt/core.o
>>   CC      hw/bt/l2cap.o
>>   CC      hw/bt/sdp.o
>>   CC      hw/bt/hci.o
>>   CC      hw/bt/hci-csr.o
>>   CC      hw/bt/hid.o
>>   CC      hw/char/ipoctal232.o
>>   CC      hw/char/parallel.o
>>   CC      hw/char/pl011.o
>>   CC      hw/char/serial.o
>>   CC      hw/char/serial-isa.o
>>   CC      hw/char/serial-pci.o
>>   CC      hw/char/virtio-console.o
>>   CC      hw/char/cadence_uart.o
>>   CC      hw/char/cmsdk-apb-uart.o
>>   CC      hw/char/debugcon.o
>>   CC      hw/char/imx_serial.o
>>   CC      hw/core/qdev.o
>>   CC      hw/core/qdev-properties.o
>>   CC      hw/core/bus.o
>>   CC      hw/core/reset.o
>>   CC      hw/core/fw-path-provider.o
>>   CC      hw/core/irq.o
>>   CC      hw/core/hotplug.o
>>   CC      hw/core/nmi.o
>>   CC      hw/core/sysbus.o
>>   CC      hw/core/ptimer.o
>>   CC      hw/core/machine.o
>>   CC      hw/core/loader.o
>>   CC      hw/core/qdev-properties-system.o
>>   CC      hw/core/register.o
>>   CC      hw/core/or-irq.o
>>   CC      hw/core/platform-bus.o
>>   CC      hw/cpu/core.o
>>   CC      hw/display/ads7846.o
>>   CC      hw/display/cirrus_vga.o
>>   CC      hw/display/pl110.o
>>   CC      hw/display/ssd0303.o
>>   CC      hw/display/ssd0323.o
>>   CC      hw/display/vga-pci.o
>>   CC      hw/display/vga-isa.o
>>   CC      hw/display/vmware_vga.o
>>   CC      hw/display/blizzard.o
>>   CC      hw/display/exynos4210_fimd.o
>>   CC      hw/display/framebuffer.o
>>   CC      hw/display/tc6393xb.o
>>   CC      hw/dma/pl080.o
>>   CC      hw/dma/pl330.o
>>   CC      hw/dma/i8257.o
>>   CC      hw/dma/xlnx-zynq-devcfg.o
>>   CC      hw/gpio/max7310.o
>>   CC      hw/gpio/zaurus.o
>>   CC      hw/gpio/pl061.o
>>   CC      hw/gpio/gpio_key.o
>>   CC      hw/i2c/smbus.o
>>   CC      hw/i2c/core.o
>>   CC      hw/i2c/smbus_eeprom.o
>>   CC      hw/i2c/i2c-ddc.o
>>   CC      hw/i2c/versatile_i2c.o
>>   CC      hw/i2c/smbus_ich9.o
>>   CC      hw/i2c/bitbang_i2c.o
>>   CC      hw/i2c/pm_smbus.o
>>   CC      hw/i2c/exynos4210_i2c.o
>>   CC      hw/i2c/imx_i2c.o
>>   CC      hw/i2c/aspeed_i2c.o
>>   CC      hw/ide/core.o
>>   CC      hw/ide/atapi.o
>>   CC      hw/ide/pci.o
>>   CC      hw/ide/qdev.o
>>   CC      hw/ide/isa.o
>>   CC      hw/ide/piix.o
>>   CC      hw/ide/microdrive.o
>>   CC      hw/ide/ahci.o
>>   CC      hw/ide/ich.o
>>   CC      hw/ide/ahci-allwinner.o
>>   CC      hw/input/hid.o
>>   CC      hw/input/pckbd.o
>>   CC      hw/input/lm832x.o
>>   CC      hw/input/pl050.o
>>   CC      hw/input/ps2.o
>>   CC      hw/input/stellaris_input.o
>>   CC      hw/input/tsc2005.o
>>   CC      hw/input/vmmouse.o
>>   CC      hw/input/virtio-input-hid.o
>>   CC      hw/input/virtio-input.o
>>   CC      hw/intc/i8259_common.o
>>   CC      hw/intc/i8259.o
>>   CC      hw/intc/pl190.o
>>   CC      hw/intc/imx_avic.o
>>   CC      hw/intc/realview_gic.o
>>   CC      hw/intc/ioapic_common.o
>>   CC      hw/intc/arm_gic_common.o
>>   CC      hw/intc/arm_gic.o
>>   CC      hw/intc/arm_gicv2m.o
>>   CC      hw/intc/arm_gicv3_common.o
>>   CC      hw/intc/arm_gicv3.o
>>   CC      hw/intc/arm_gicv3_dist.o
>>   CC      hw/intc/arm_gicv3_redist.o
>>   CC      hw/intc/arm_gicv3_its_common.o
>>   CC      hw/intc/intc.o
>>   CC      hw/ipack/ipack.o
>>   CC      hw/ipack/tpci200.o
>>   CC      hw/ipmi/ipmi.o
>>   CC      hw/ipmi/ipmi_bmc_sim.o
>>   CC      hw/ipmi/ipmi_bmc_extern.o
>>   CC      hw/ipmi/isa_ipmi_kcs.o
>>   CC      hw/ipmi/isa_ipmi_bt.o
>>   CC      hw/isa/isa-bus.o
>>   CC      hw/mem/pc-dimm.o
>>   CC      hw/isa/apm.o
>>   CC      hw/mem/nvdimm.o
>>   CC      hw/misc/applesmc.o
>>   CC      hw/misc/tmp105.o
>>   CC      hw/misc/max111x.o
>>   CC      hw/misc/tmp421.o
>>   CC      hw/misc/debugexit.o
>>   CC      hw/misc/sga.o
>>   CC      hw/misc/pc-testdev.o
>>   CC      hw/misc/pci-testdev.o
>>   CC      hw/misc/edu.o
>>   CC      hw/misc/unimp.o
>>   CC      hw/misc/vmcoreinfo.o
>>   CC      hw/misc/arm_l2x0.o
>>   CC      hw/misc/arm_integrator_debug.o
>>   CC      hw/misc/a9scu.o
>>   CC      hw/misc/arm11scu.o
>>   CC      hw/net/ne2000.o
>>   CC      hw/net/eepro100.o
>>   CC      hw/net/pcnet.o
>>   CC      hw/net/pcnet-pci.o
>>   CC      hw/net/e1000.o
>>   CC      hw/net/e1000x_common.o
>>   CC      hw/net/net_tx_pkt.o
>>   CC      hw/net/e1000e.o
>>   CC      hw/net/net_rx_pkt.o
>>   CC      hw/net/rtl8139.o
>>   CC      hw/net/e1000e_core.o
>>   CC      hw/net/vmxnet3.o
>>   CC      hw/net/smc91c111.o
>>   CC      hw/net/lan9118.o
>>   CC      hw/net/ne2000-isa.o
>>   CC      hw/net/xgmac.o
>>   CC      hw/net/allwinner_emac.o
>>   CC      hw/net/cadence_gem.o
>>   CC      hw/net/imx_fec.o
>>   CC      hw/net/ftgmac100.o
>>   CC      hw/net/stellaris_enet.o
>>   CC      hw/net/rocker/rocker.o
>>   CC      hw/net/rocker/rocker_fp.o
>>   CC      hw/net/rocker/rocker_desc.o
>>   CC      hw/net/rocker/rocker_world.o
>>   CC      hw/net/rocker/rocker_of_dpa.o
>>   CC      hw/nvram/eeprom93xx.o
>>   CC      hw/nvram/fw_cfg.o
>>   CC      hw/nvram/chrp_nvram.o
>>   CC      hw/pci-bridge/pci_bridge_dev.o
>>   CC      hw/pci-bridge/pcie_root_port.o
>>   CC      hw/pci-bridge/gen_pcie_root_port.o
>>   CC      hw/pci-bridge/pcie_pci_bridge.o
>>   CC      hw/pci-bridge/pci_expander_bridge.o
>>   CC      hw/pci-bridge/xio3130_upstream.o
>>   CC      hw/pci-bridge/xio3130_downstream.o
>>   CC      hw/pci-bridge/ioh3420.o
>>   CC      hw/pci-bridge/i82801b11.o
>>   CC      hw/pci-host/pam.o
>>   CC      hw/pci-host/versatile.o
>>   CC      hw/pci-host/piix.o
>>   CC      hw/pci-host/q35.o
>>   CC      hw/pci-host/gpex.o
>>   CC      hw/pci/pci.o
>>   CC      hw/pci/pci_bridge.o
>>   CC      hw/pci/msix.o
>>   CC      hw/pci/msi.o
>>   CC      hw/pci/shpc.o
>>   CC      hw/pci/slotid_cap.o
>>   CC      hw/pci/pcie_host.o
>>   CC      hw/pci/pci_host.o
>>   CC      hw/pci/pcie.o
>>   CC      hw/pci/pcie_aer.o
>>   CC      hw/pci/pcie_port.o
>>   CC      hw/pci/pci-stub.o
>>   CC      hw/pcmcia/pcmcia.o
>>   CC      hw/scsi/scsi-disk.o
>>   CC      hw/scsi/scsi-generic.o
>>   CC      hw/scsi/scsi-bus.o
>>   CC      hw/scsi/lsi53c895a.o
>>   CC      hw/scsi/mptsas.o
>>   CC      hw/scsi/mptconfig.o
>>   CC      hw/scsi/mptendian.o
>>   CC      hw/scsi/megasas.o
>>   CC      hw/scsi/vmw_pvscsi.o
>>   CC      hw/scsi/esp.o
>>   CC      hw/scsi/esp-pci.o
>>   CC      hw/sd/pl181.o
>>   CC      hw/sd/ssi-sd.o
>>   CC      hw/sd/sd.o
>>   CC      hw/sd/core.o
>>   CC      hw/sd/sdhci.o
>>   CC      hw/smbios/smbios.o
>>   CC      hw/smbios/smbios_type_38.o
>>   CC      hw/smbios/smbios-stub.o
>>   CC      hw/smbios/smbios_type_38-stub.o
>>   CC      hw/ssi/pl022.o
>>   CC      hw/ssi/ssi.o
>>   CC      hw/ssi/xilinx_spips.o
>>   CC      hw/ssi/aspeed_smc.o
>>   CC      hw/ssi/stm32f2xx_spi.o
>>   CC      hw/ssi/mss-spi.o
>>   CC      hw/timer/arm_timer.o
>>   CC      hw/timer/arm_mptimer.o
>>   CC      hw/timer/armv7m_systick.o
>>   CC      hw/timer/a9gtimer.o
>>   CC      hw/timer/cadence_ttc.o
>>   CC      hw/timer/ds1338.o
>>   CC      hw/timer/hpet.o
>>   CC      hw/timer/i8254.o
>>   CC      hw/timer/i8254_common.o
>>   CC      hw/timer/pl031.o
>>   CC      hw/timer/twl92230.o
>>   CC      hw/timer/imx_epit.o
>>   CC      hw/timer/imx_gpt.o
>>   CC      hw/timer/stm32f2xx_timer.o
>>   CC      hw/timer/aspeed_timer.o
>>   CC      hw/timer/cmsdk-apb-timer.o
>>   CC      hw/timer/mss-timer.o
>>   CC      hw/tpm/tpm_tis.o
>>   CC      hw/usb/core.o
>>   CC      hw/usb/combined-packet.o
>>   CC      hw/usb/libhw.o
>>   CC      hw/usb/bus.o
>>   CC      hw/usb/desc.o
>>   CC      hw/usb/desc-msos.o
>>   CC      hw/usb/hcd-uhci.o
>>   CC      hw/usb/hcd-ohci.o
>>   CC      hw/usb/hcd-ehci.o
>>   CC      hw/usb/hcd-ehci-pci.o
>>   CC      hw/usb/hcd-xhci.o
>>   CC      hw/usb/hcd-xhci-nec.o
>>   CC      hw/usb/hcd-ehci-sysbus.o
>>   CC      hw/usb/hcd-musb.o
>>   CC      hw/usb/dev-hub.o
>>   CC      hw/usb/dev-hid.o
>>   CC      hw/usb/dev-wacom.o
>>   CC      hw/usb/dev-storage.o
>>   CC      hw/usb/dev-uas.o
>>   CC      hw/usb/dev-audio.o
>>   CC      hw/usb/dev-serial.o
>>   CC      hw/usb/dev-network.o
>>   CC      hw/usb/dev-bluetooth.o
>>   CC      hw/usb/dev-smartcard-reader.o
>>   CC      hw/usb/host-stub.o
>>   CC      hw/virtio/virtio-rng.o
>>   CC      hw/virtio/virtio-pci.o
>>   CC      hw/virtio/virtio-bus.o
>>   CC      hw/virtio/virtio-mmio.o
>>   CC      hw/virtio/vhost-stub.o
>>   CC      hw/watchdog/watchdog.o
>>   CC      hw/watchdog/wdt_i6300esb.o
>>   CC      hw/watchdog/wdt_ib700.o
>>   CC      hw/watchdog/wdt_aspeed.o
>>   CC      migration/migration.o
>>   CC      migration/fd.o
>>   CC      migration/socket.o
>>   CC      migration/exec.o
>>   CC      migration/tls.o
>>   CC      migration/savevm.o
>>   CC      migration/channel.o
>>   CC      migration/colo-comm.o
>>   CC      migration/colo.o
>>   CC      migration/colo-failover.o
>>   CC      migration/vmstate.o
>>   CC      migration/vmstate-types.o
>>   CC      migration/page_cache.o
>>   CC      migration/qemu-file.o
>>   CC      migration/global_state.o
>>   CC      migration/qemu-file-channel.o
>>   CC      migration/xbzrle.o
>>   CC      migration/postcopy-ram.o
>>   CC      migration/qjson.o
>>   CC      migration/block.o
>>   CC      net/net.o
>>   CC      net/queue.o
>>   CC      net/checksum.o
>>   CC      net/util.o
>>   CC      net/hub.o
>>   CC      net/socket.o
>>   CC      net/dump.o
>>   CC      net/eth.o
>>   CC      net/filter.o
>>   CC      net/slirp.o
>>   CC      net/filter-buffer.o
>>   CC      net/filter-mirror.o
>>   CC      net/colo-compare.o
>>   CC      net/colo.o
>>   CC      net/filter-rewriter.o
>>   CC      net/tap-win32.o
>>   CC      net/filter-replay.o
>>   CC      qom/cpu.o
>>   CC      replay/replay.o
>>   CC      replay/replay-internal.o
>>   CC      replay/replay-events.o
>>   CC      replay/replay-time.o
>>   CC      replay/replay-input.o
>>   CC      replay/replay-char.o
>>   CC      replay/replay-audio.o
>>   CC      slirp/cksum.o
>>   CC      replay/replay-net.o
>>   CC      replay/replay-snapshot.o
>>   CC      slirp/if.o
>>   CC      slirp/ip_icmp.o
>>   CC      slirp/ip6_icmp.o
>>   CC      slirp/ip6_input.o
>>   CC      slirp/ip6_output.o
>>   CC      slirp/ip_input.o
>>   CC      slirp/ip_output.o
>>   CC      slirp/dnssearch.o
>>   CC      slirp/dhcpv6.o
>>   CC      slirp/slirp.o
>>   CC      slirp/mbuf.o
>>   CC      slirp/misc.o
>>   CC      slirp/sbuf.o
>>   CC      slirp/socket.o
>>   CC      slirp/tcp_input.o
>>   CC      slirp/tcp_output.o
>>   CC      slirp/tcp_subr.o
>>   CC      slirp/tcp_timer.o
>>   CC      slirp/udp.o
>>   CC      slirp/udp6.o
>>   CC      slirp/tftp.o
>>   CC      slirp/bootp.o
>>   CC      slirp/arp_table.o
>>   CC      slirp/ndp_table.o
>>   CC      slirp/ncsi.o
>>   CC      ui/keymaps.o
>>   CC      ui/console.o
>>   CC      ui/cursor.o
>>   CC      ui/qemu-pixman.o
>>   CC      ui/input.o
>>   CC      ui/input-keymap.o
>>   CC      ui/input-legacy.o
>>   CC      ui/sdl.o
>>   CC      ui/x_keymap.o
>>   CC      ui/sdl_zoom.o
>>   CC      ui/vnc-enc-zlib.o
>>   CC      ui/vnc-enc-hextile.o
>>   CC      ui/vnc.o
>>   CC      ui/vnc-enc-tight.o
>>   CC      ui/vnc-palette.o
>>   CC      ui/vnc-auth-vencrypt.o
>>   CC      ui/vnc-enc-zrle.o
>>   CC      ui/vnc-ws.o
>>   CC      ui/vnc-jobs.o
>>   CC      ui/gtk.o
>>   CC      chardev/char.o
>>   CC      chardev/char-console.o
>>   CC      chardev/char-fe.o
>>   CC      chardev/char-file.o
>>   CC      chardev/char-io.o
>>   CC      chardev/char-mux.o
>>   CC      chardev/char-null.o
>>   CC      chardev/char-pipe.o
>>   CC      chardev/char-ringbuf.o
>>   CC      chardev/char-serial.o
>>   CC      chardev/char-socket.o
>>   CC      chardev/char-stdio.o
>>   CC      chardev/char-udp.o
>>   CC      chardev/char-win.o
>>   CC      chardev/char-win-stdio.o
>>   CC      qga/commands.o
>>   CC      qga/guest-agent-command-state.o
>>   CC      qga/main.o
>>   CC      qga/commands-win32.o
>>   CC      qga/service-win32.o
>>   CC      qga/channel-win32.o
>>   CC      qga/vss-win32.o
>>   CC      qga/qapi-generated/qga-qapi-types.o
>>   AS      optionrom/multiboot.o
>>   AS      optionrom/linuxboot.o
>>   CC      qga/qapi-generated/qga-qapi-visit.o
>>   CC      optionrom/linuxboot_dma.o
>>   CC      qga/qapi-generated/qga-qmp-marshal.o
>>   AR      libqemuutil.a
>>   BUILD   optionrom/linuxboot.img
>>   AS      optionrom/kvmvapic.o
>>   CC      qemu-img.o
>>   BUILD   optionrom/multiboot.img
>>   BUILD   optionrom/linuxboot.raw
>>   BUILD   optionrom/linuxboot_dma.img
>>   BUILD   optionrom/multiboot.raw
>>   BUILD   optionrom/kvmvapic.img
>>   BUILD   optionrom/linuxboot_dma.raw
>>   BUILD   optionrom/kvmvapic.raw
>>   SIGN    optionrom/multiboot.bin
>>   SIGN    optionrom/linuxboot.bin
>>   SIGN    optionrom/linuxboot_dma.bin
>>   SIGN    optionrom/kvmvapic.bin
>>   LINK    qemu-io.exe
>>   LINK    qemu-ga.exe
>>   LINK    qemu-img.exe
>>   GEN     aarch64-softmmu/hmp-commands.h
>>   GEN     aarch64-softmmu/config-target.h
>>   CC      aarch64-softmmu/exec.o
>>   CC      aarch64-softmmu/tcg/optimize.o
>>   CC      aarch64-softmmu/tcg/tcg-op.o
>>   CC      aarch64-softmmu/disas.o
>>   CC      aarch64-softmmu/tcg/tcg-common.o
>>   CC      aarch64-softmmu/fpu/softfloat.o
>>   CC      aarch64-softmmu/tcg/tcg.o
>>   GEN     x86_64-softmmu/hmp-commands.h
>>   GEN     x86_64-softmmu/config-target.h
>>   GEN     aarch64-softmmu/gdbstub-xml.c
>>   CC      aarch64-softmmu/arch_init.o
>>   CC      x86_64-softmmu/exec.o
>>   CC      aarch64-softmmu/cpus.o
>>   CC      aarch64-softmmu/monitor.o
>>   CC      x86_64-softmmu/tcg/tcg.o
>>   CC      x86_64-softmmu/tcg/tcg-op.o
>>   CC      aarch64-softmmu/gdbstub.o
>>   CC      x86_64-softmmu/tcg/optimize.o
>>   CC      aarch64-softmmu/balloon.o
>>   CC      x86_64-softmmu/tcg/tcg-common.o
>>   CC      x86_64-softmmu/fpu/softfloat.o
>>   CC      aarch64-softmmu/ioport.o
>>   CC      aarch64-softmmu/numa.o
>>   CC      x86_64-softmmu/disas.o
>>   GEN     x86_64-softmmu/gdbstub-xml.c
>>   CC      aarch64-softmmu/qtest.o
>>   CC      x86_64-softmmu/arch_init.o
>>   CC      x86_64-softmmu/cpus.o
>>   CC      x86_64-softmmu/monitor.o
>>   CC      x86_64-softmmu/gdbstub.o
>>   CC      aarch64-softmmu/memory.o
>>   CC      x86_64-softmmu/balloon.o
>>   CC      x86_64-softmmu/ioport.o
>>   CC      x86_64-softmmu/numa.o
>>   CC      aarch64-softmmu/memory_mapping.o
>>   CC      x86_64-softmmu/qtest.o
>>   CC      x86_64-softmmu/memory_mapping.o
>>   CC      aarch64-softmmu/dump.o
>>   CC      x86_64-softmmu/memory.o
>>   CC      aarch64-softmmu/migration/ram.o
>>   CC      aarch64-softmmu/accel/accel.o
>>   CC      aarch64-softmmu/accel/stubs/hax-stub.o
>>   CC      x86_64-softmmu/dump.o
>>   CC      aarch64-softmmu/accel/stubs/kvm-stub.o
>>   CC      x86_64-softmmu/migration/ram.o
>>   CC      aarch64-softmmu/accel/tcg/tcg-all.o
>>   CC      x86_64-softmmu/accel/accel.o
>>   CC      aarch64-softmmu/accel/tcg/cputlb.o
>>   CC      aarch64-softmmu/accel/tcg/tcg-runtime.o
>>   CC      aarch64-softmmu/accel/tcg/cpu-exec.o
>>   CC      aarch64-softmmu/accel/tcg/cpu-exec-common.o
>>   CC      x86_64-softmmu/accel/stubs/kvm-stub.o
>>   CC      x86_64-softmmu/accel/tcg/tcg-all.o
>>   CC      aarch64-softmmu/accel/tcg/translate-all.o
>>   CC      x86_64-softmmu/accel/tcg/cputlb.o
>>   CC      x86_64-softmmu/accel/tcg/tcg-runtime.o
>>   CC      aarch64-softmmu/accel/tcg/translator.o
>>   CC      x86_64-softmmu/accel/tcg/cpu-exec.o
>>   CC      x86_64-softmmu/accel/tcg/cpu-exec-common.o
>>   CC      x86_64-softmmu/accel/tcg/translate-all.o
>>   CC      x86_64-softmmu/accel/tcg/translator.o
>>   CC      x86_64-softmmu/hw/block/virtio-blk.o
>>   CC      aarch64-softmmu/hw/adc/stm32f2xx_adc.o
>>   CC      aarch64-softmmu/hw/block/virtio-blk.o
>>   CC      aarch64-softmmu/hw/block/dataplane/virtio-blk.o
>>   CC      x86_64-softmmu/hw/block/dataplane/virtio-blk.o
>>   CC      x86_64-softmmu/hw/char/virtio-serial-bus.o
>>   CC      aarch64-softmmu/hw/char/exynos4210_uart.o
>>   CC      x86_64-softmmu/hw/core/generic-loader.o
>>   CC      aarch64-softmmu/hw/char/omap_uart.o
>>   CC      x86_64-softmmu/hw/core/null-machine.o
>>   CC      x86_64-softmmu/hw/display/vga.o
>>   CC      aarch64-softmmu/hw/char/digic-uart.o
>>   CC      aarch64-softmmu/hw/char/stm32f2xx_usart.o
>>   CC      aarch64-softmmu/hw/char/bcm2835_aux.o
>>   CC      aarch64-softmmu/hw/char/virtio-serial-bus.o
>>   CC      x86_64-softmmu/hw/display/virtio-gpu.o
>>   CC      x86_64-softmmu/hw/display/virtio-gpu-3d.o
>>   CC      x86_64-softmmu/hw/display/virtio-gpu-pci.o
>>   CC      aarch64-softmmu/hw/core/generic-loader.o
>>   CC      x86_64-softmmu/hw/display/virtio-vga.o
>>   CC      aarch64-softmmu/hw/core/null-machine.o
>>   CC      x86_64-softmmu/hw/intc/apic.o
>>   CC      x86_64-softmmu/hw/intc/apic_common.o
>>   CC      x86_64-softmmu/hw/intc/ioapic.o
>>   CC      x86_64-softmmu/hw/isa/lpc_ich9.o
>>   CC      x86_64-softmmu/hw/misc/vmport.o
>>   CC      aarch64-softmmu/hw/cpu/arm11mpcore.o
>>   CC      aarch64-softmmu/hw/cpu/realview_mpcore.o
>>   CC      x86_64-softmmu/hw/misc/pvpanic.o
>>   CC      x86_64-softmmu/hw/misc/mmio_interface.o
>>   CC      aarch64-softmmu/hw/cpu/a9mpcore.o
>>   CC      x86_64-softmmu/hw/net/virtio-net.o
>>   CC      x86_64-softmmu/hw/net/vhost_net.o
>>   CC      aarch64-softmmu/hw/cpu/a15mpcore.o
>>   CC      x86_64-softmmu/hw/scsi/virtio-scsi.o
>>   CC      x86_64-softmmu/hw/scsi/virtio-scsi-dataplane.o
>>   CC      aarch64-softmmu/hw/display/omap_dss.o
>>   CC      x86_64-softmmu/hw/timer/mc146818rtc.o
>>   CC      x86_64-softmmu/hw/virtio/virtio-balloon.o
>>   CC      x86_64-softmmu/hw/virtio/virtio.o
>>   CC      aarch64-softmmu/hw/display/omap_lcdc.o
>>   CC      x86_64-softmmu/hw/virtio/virtio-crypto.o
>>   CC      x86_64-softmmu/hw/virtio/virtio-crypto-pci.o
>>   CC      x86_64-softmmu/hw/i386/multiboot.o
>>   CC      aarch64-softmmu/hw/display/pxa2xx_lcd.o
>>   CC      aarch64-softmmu/hw/display/bcm2835_fb.o
>>   CC      aarch64-softmmu/hw/display/vga.o
>>   CC      aarch64-softmmu/hw/display/virtio-gpu.o
>>   CC      x86_64-softmmu/hw/i386/pc.o
>>   CC      aarch64-softmmu/hw/display/virtio-gpu-3d.o
>>   CC      x86_64-softmmu/hw/i386/pc_piix.o
>>   CC      x86_64-softmmu/hw/i386/pc_q35.o
>>   CC      x86_64-softmmu/hw/i386/pc_sysfw.o
>>   CC      aarch64-softmmu/hw/display/virtio-gpu-pci.o
>>   CC      aarch64-softmmu/hw/display/dpcd.o
>>   CC      x86_64-softmmu/hw/i386/x86-iommu.o
>>   CC      aarch64-softmmu/hw/display/xlnx_dp.o
>>   CC      aarch64-softmmu/hw/dma/xlnx_dpdma.o
>>   CC      aarch64-softmmu/hw/dma/omap_dma.o
>>   CC      aarch64-softmmu/hw/dma/soc_dma.o
>>   CC      aarch64-softmmu/hw/dma/pxa2xx_dma.o
>>   CC      x86_64-softmmu/hw/i386/intel_iommu.o
>>   CC      x86_64-softmmu/hw/i386/amd_iommu.o
>>   CC      aarch64-softmmu/hw/dma/bcm2835_dma.o
>>   CC      x86_64-softmmu/hw/i386/kvmvapic.o
>>   CC      x86_64-softmmu/hw/i386/acpi-build.o
>>   CC      x86_64-softmmu/target/i386/helper.o
>>   CC      aarch64-softmmu/hw/gpio/omap_gpio.o
>>   CC      aarch64-softmmu/hw/gpio/bcm2835_gpio.o
>>   CC      x86_64-softmmu/target/i386/cpu.o
>>   CC      aarch64-softmmu/hw/gpio/imx_gpio.o
>>   CC      aarch64-softmmu/hw/i2c/omap_i2c.o
>>   CC      x86_64-softmmu/target/i386/gdbstub.o
>>   CC      aarch64-softmmu/hw/input/pxa2xx_keypad.o
>>   CC      aarch64-softmmu/hw/input/tsc210x.o
>>   CC      x86_64-softmmu/target/i386/xsave_helper.o
>>   CC      x86_64-softmmu/target/i386/translate.o
>>   CC      x86_64-softmmu/target/i386/bpt_helper.o
>>   CC      aarch64-softmmu/hw/intc/armv7m_nvic.o
>>   CC      aarch64-softmmu/hw/intc/exynos4210_gic.o
>>   CC      x86_64-softmmu/target/i386/cc_helper.o
>>   CC      aarch64-softmmu/hw/intc/exynos4210_combiner.o
>>   CC      aarch64-softmmu/hw/intc/bcm2835_ic.o
>>   CC      aarch64-softmmu/hw/intc/omap_intc.o
>>   CC      aarch64-softmmu/hw/intc/bcm2836_control.o
>>   CC      x86_64-softmmu/target/i386/excp_helper.o
>>   CC      x86_64-softmmu/target/i386/fpu_helper.o
>>   CC      x86_64-softmmu/target/i386/mem_helper.o
>>   CC      x86_64-softmmu/target/i386/int_helper.o
>>   CC      aarch64-softmmu/hw/intc/allwinner-a10-pic.o
>>   CC      aarch64-softmmu/hw/intc/aspeed_vic.o
>>   CC      aarch64-softmmu/hw/intc/arm_gicv3_cpuif.o
>>   CC      x86_64-softmmu/target/i386/misc_helper.o
>>   CC      x86_64-softmmu/target/i386/mpx_helper.o
>>   CC      aarch64-softmmu/hw/misc/arm_sysctl.o
>>   CC      x86_64-softmmu/target/i386/seg_helper.o
>>   CC      aarch64-softmmu/hw/misc/cbus.o
>>   CC      x86_64-softmmu/target/i386/smm_helper.o
>>   CC      x86_64-softmmu/target/i386/svm_helper.o
>>   CC      x86_64-softmmu/target/i386/machine.o
>>   CC      aarch64-softmmu/hw/misc/exynos4210_pmu.o
>>   CC      aarch64-softmmu/hw/misc/exynos4210_clk.o
>>   CC      x86_64-softmmu/target/i386/arch_memory_mapping.o
>>   CC      aarch64-softmmu/hw/misc/exynos4210_rng.o
>>   CC      aarch64-softmmu/hw/misc/imx_ccm.o
>>   CC      aarch64-softmmu/hw/misc/imx31_ccm.o
>>   CC      x86_64-softmmu/target/i386/arch_dump.o
>>   CC      x86_64-softmmu/target/i386/monitor.o
>>   CC      aarch64-softmmu/hw/misc/imx6_ccm.o
>>   CC      aarch64-softmmu/hw/misc/imx25_ccm.o
>>   CC      aarch64-softmmu/hw/misc/imx6_src.o
>>   CC      aarch64-softmmu/hw/misc/mst_fpga.o
>>   CC      x86_64-softmmu/target/i386/kvm-stub.o
>>   CC      aarch64-softmmu/hw/misc/omap_clk.o
>>   CC      x86_64-softmmu/target/i386/hax-all.o
>>   CC      aarch64-softmmu/hw/misc/omap_gpmc.o
>>   CC      x86_64-softmmu/target/i386/hax-mem.o
>>   CC      aarch64-softmmu/hw/misc/omap_l4.o
>>   CC      x86_64-softmmu/target/i386/hax-windows.o
>>   CC      aarch64-softmmu/hw/misc/omap_sdrc.o
>>   CC      aarch64-softmmu/hw/misc/omap_tap.o
>>   CC      aarch64-softmmu/hw/misc/bcm2835_mbox.o
>>   CC      aarch64-softmmu/hw/misc/bcm2835_property.o
>>   CC      aarch64-softmmu/hw/misc/bcm2835_rng.o
>>   CC      aarch64-softmmu/hw/misc/zynq_slcr.o
>>   GEN     trace/generated-helpers.c
>>   CC      x86_64-softmmu/trace/control-target.o
>>   CC      aarch64-softmmu/hw/misc/zynq-xadc.o
>>   CC      aarch64-softmmu/hw/misc/stm32f2xx_syscfg.o
>>   CC      aarch64-softmmu/hw/misc/mps2-scc.o
>>   CC      aarch64-softmmu/hw/misc/auxbus.o
>>   CC      x86_64-softmmu/gdbstub-xml.o
>>   CC      aarch64-softmmu/hw/misc/aspeed_scu.o
>>   CC      aarch64-softmmu/hw/misc/aspeed_sdmc.o
>>   CC      aarch64-softmmu/hw/misc/mmio_interface.o
>>   CC      aarch64-softmmu/hw/misc/msf2-sysreg.o
>>   CC      x86_64-softmmu/trace/generated-helpers.o
>>   CC      aarch64-softmmu/hw/net/virtio-net.o
>>   CC      aarch64-softmmu/hw/net/vhost_net.o
>>   CC      aarch64-softmmu/hw/pcmcia/pxa2xx.o
>>   CC      aarch64-softmmu/hw/scsi/virtio-scsi.o
>>   CC      aarch64-softmmu/hw/scsi/virtio-scsi-dataplane.o
>>   CC      aarch64-softmmu/hw/sd/pxa2xx_mmci.o
>>   CC      aarch64-softmmu/hw/sd/omap_mmc.o
>>   CC      aarch64-softmmu/hw/sd/bcm2835_sdhost.o
>>   CC      aarch64-softmmu/hw/ssi/omap_spi.o
>>   CC      aarch64-softmmu/hw/ssi/imx_spi.o
>>   CC      aarch64-softmmu/hw/timer/exynos4210_mct.o
>>   CC      aarch64-softmmu/hw/timer/exynos4210_pwm.o
>>   CC      aarch64-softmmu/hw/timer/exynos4210_rtc.o
>>   CC      aarch64-softmmu/hw/timer/omap_gptimer.o
>>   CC      aarch64-softmmu/hw/timer/omap_synctimer.o
>>   LINK    x86_64-softmmu/qemu-system-x86_64.exe
>>   CC      aarch64-softmmu/hw/timer/pxa2xx_timer.o
>>   CC      aarch64-softmmu/hw/timer/allwinner-a10-pit.o
>>   CC      aarch64-softmmu/hw/timer/digic-timer.o
>>   CC      aarch64-softmmu/hw/usb/tusb6010.o
>>   CC      aarch64-softmmu/hw/virtio/virtio-balloon.o
>>   CC      aarch64-softmmu/hw/virtio/virtio.o
>>   CC      aarch64-softmmu/hw/virtio/virtio-crypto.o
>>   CC      aarch64-softmmu/hw/virtio/virtio-crypto-pci.o
>>   CC      aarch64-softmmu/hw/arm/boot.o
>>   CC      aarch64-softmmu/hw/arm/collie.o
>>   CC      aarch64-softmmu/hw/arm/exynos4_boards.o
>>   CC      aarch64-softmmu/hw/arm/gumstix.o
>>   CC      aarch64-softmmu/hw/arm/highbank.o
>>   CC      aarch64-softmmu/hw/arm/digic_boards.o
>>   CC      aarch64-softmmu/hw/arm/integratorcp.o
>>   CC      aarch64-softmmu/hw/arm/mainstone.o
>>   CC      aarch64-softmmu/hw/arm/musicpal.o
>>   CC      aarch64-softmmu/hw/arm/nseries.o
>>   CC      aarch64-softmmu/hw/arm/omap_sx1.o
>>   CC      aarch64-softmmu/hw/arm/realview.o
>>   CC      aarch64-softmmu/hw/arm/palm.o
>>   CC      aarch64-softmmu/hw/arm/spitz.o
>>   CC      aarch64-softmmu/hw/arm/tosa.o
>>   CC      aarch64-softmmu/hw/arm/stellaris.o
>>   CC      aarch64-softmmu/hw/arm/versatilepb.o
>>   CC      aarch64-softmmu/hw/arm/vexpress.o
>>   CC      aarch64-softmmu/hw/arm/virt.o
>>   CC      aarch64-softmmu/hw/arm/xilinx_zynq.o
>>   CC      aarch64-softmmu/hw/arm/z2.o
>>   CC      aarch64-softmmu/hw/arm/virt-acpi-build.o
>>   CC      aarch64-softmmu/hw/arm/netduino2.o
>>   CC      aarch64-softmmu/hw/arm/sysbus-fdt.o
>>   CC      aarch64-softmmu/hw/arm/armv7m.o
>>   CC      aarch64-softmmu/hw/arm/exynos4210.o
>>   CC      aarch64-softmmu/hw/arm/pxa2xx_gpio.o
>>   CC      aarch64-softmmu/hw/arm/pxa2xx.o
>>   CC      aarch64-softmmu/hw/arm/pxa2xx_pic.o
>>   CC      aarch64-softmmu/hw/arm/omap1.o
>>   CC      aarch64-softmmu/hw/arm/digic.o
>>   CC      aarch64-softmmu/hw/arm/omap2.o
>>   CC      aarch64-softmmu/hw/arm/strongarm.o
>>   CC      aarch64-softmmu/hw/arm/allwinner-a10.o
>>   CC      aarch64-softmmu/hw/arm/cubieboard.o
>>   CC      aarch64-softmmu/hw/arm/bcm2835_peripherals.o
>>   CC      aarch64-softmmu/hw/arm/bcm2836.o
>>   CC      aarch64-softmmu/hw/arm/raspi.o
>>   CC      aarch64-softmmu/hw/arm/stm32f205_soc.o
>>   CC      aarch64-softmmu/hw/arm/xlnx-zynqmp.o
>>   CC      aarch64-softmmu/hw/arm/xlnx-zcu102.o
>>   CC      aarch64-softmmu/hw/arm/fsl-imx25.o
>>   CC      aarch64-softmmu/hw/arm/imx25_pdk.o
>>   CC      aarch64-softmmu/hw/arm/fsl-imx31.o
>>   CC      aarch64-softmmu/hw/arm/kzm.o
>>   CC      aarch64-softmmu/hw/arm/fsl-imx6.o
>>   CC      aarch64-softmmu/hw/arm/sabrelite.o
>>   CC      aarch64-softmmu/hw/arm/aspeed_soc.o
>>   CC      aarch64-softmmu/hw/arm/aspeed.o
>>   CC      aarch64-softmmu/hw/arm/mps2.o
>>   CC      aarch64-softmmu/hw/arm/msf2-soc.o
>>   CC      aarch64-softmmu/hw/arm/msf2-som.o
>>   CC      aarch64-softmmu/target/arm/arm-semi.o
>>   CC      aarch64-softmmu/target/arm/machine.o
>>   CC      aarch64-softmmu/target/arm/psci.o
>>   CC      aarch64-softmmu/target/arm/arch_dump.o
>>   CC      aarch64-softmmu/target/arm/monitor.o
>>   CC      aarch64-softmmu/target/arm/kvm-stub.o
>>   CC      aarch64-softmmu/target/arm/translate.o
>>   CC      aarch64-softmmu/target/arm/op_helper.o
>>   CC      aarch64-softmmu/target/arm/helper.o
>>   CC      aarch64-softmmu/target/arm/cpu.o
>>   CC      aarch64-softmmu/target/arm/neon_helper.o
>>   CC      aarch64-softmmu/target/arm/iwmmxt_helper.o
>>   CC      aarch64-softmmu/target/arm/gdbstub.o
>>   CC      aarch64-softmmu/target/arm/translate-a64.o
>>   CC      aarch64-softmmu/target/arm/cpu64.o
>>   CC      aarch64-softmmu/target/arm/helper-a64.o
>>   CC      aarch64-softmmu/target/arm/gdbstub64.o
>>   CC      aarch64-softmmu/target/arm/crypto_helper.o
>>   CC      aarch64-softmmu/target/arm/arm-powerctl.o
>>   GEN     trace/generated-helpers.c
>>   CC      aarch64-softmmu/trace/control-target.o
>>   CC      aarch64-softmmu/gdbstub-xml.o
>>   CC      aarch64-softmmu/trace/generated-helpers.o
>>   LINK    aarch64-softmmu/qemu-system-aarch64.exe
>> mkdir -p dtc/libfdt
>> mkdir -p dtc/tests
>> install -d -m 0755 "/tmp/qemu-test/build/=3Ddestdir/tmp/qemu-test/instal=
l"
>> install -d -m 0755 "/tmp/qemu-test/build/=3Ddestdir/tmp/qemu-test/instal=
l"
>> install -c -m 0755 qemu-ga.exe qemu-img.exe qemu-io.exe
>> "/tmp/qemu-test/build/=3Ddestdir/tmp/qemu-test/install"
>> set -e; for x in bios.bin bios-256k.bin sgabios.bin vgabios.bin
>> vgabios-cirrus.bin vgabios-stdvga.bin vgabios-vmware.bin vgabios-qxl.bin
>> vgabios-virtio.bin acpi-dsdt.aml ppc_rom.bin openbios-sparc32
>> openbios-sparc64 openbios-ppc QEMU,tcx.bin QEMU,cgthree.bin pxe-e1000.ro=
m
>> pxe-eepro100.rom pxe-ne2k_pci.rom pxe-pcnet.rom pxe-rtl8139.rom
>> pxe-virtio.rom efi-e1000.rom efi-eepro100.rom efi-ne2k_pci.rom efi-pcnet=
.rom
>> efi-rtl8139.rom efi-virtio.rom efi-e1000e.rom efi-vmxnet3.rom qemu-icon.=
bmp
>> qemu_logo_no_text.svg bamboo.dtb petalogix-s3adsp1800.dtb
>> petalogix-ml605.dtb multiboot.bin linuxboot.bin linuxboot_dma.bin
>> kvmvapic.bin s390-ccw.img s390-netboot.img spapr-rtas.bin slof.bin
>> skiboot.lid palcode-clipper u-boot.e500 qemu_vga.ndrv; do \
>>         install -c -m 0644 /tmp/qemu-test/src/pc-bios/$x
>> "/tmp/qemu-test/build/=3Ddestdir/tmp/qemu-test/install"; \
>> done
>> make -C po install
>> make[1]: Entering directory '/tmp/qemu-test/build/po'
>>   GEN     hu.mo
>>   GEN     tr.mo
>>   GEN     it.mo
>>   GEN     bg.mo
>>   GEN     de_DE.mo
>>   GEN     zh_CN.mo
>>   GEN     fr_FR.mo
>> for obj in hu.mo tr.mo it.mo bg.mo fr_FR.mo zh_CN.mo de_DE.mo; do \
>>     base=3D`basename $obj .mo`; \
>>     install -d
>> /tmp/qemu-test/build/=3Ddestdir/tmp/qemu-test/install/share/locale/$base=
/LC_MESSAGES;
>> \
>>     install -m644 $obj
>> /tmp/qemu-test/build/=3Ddestdir/tmp/qemu-test/install/share/locale/$base=
/LC_MESSAGES/qemu.mo;
>> \
>> done
>> make[1]: Leaving directory '/tmp/qemu-test/build/po'
>> install -d -m 0755
>> "/tmp/qemu-test/build/=3Ddestdir/tmp/qemu-test/install/keymaps"
>> set -e; for x in da     en-gb  et  fr     fr-ch  is  lt  modifiers  no
>> pt-br  sv ar      de     en-us  fi  fr-be  hr     it  lv  nl         pl =
 ru
>> th common  de-ch  es     fo  fr-ca  hu     ja  mk  nl-be      pt  sl    =
 tr
>> bepo    cz; do \
>>         install -c -m 0644 /tmp/qemu-test/src/pc-bios/keymaps/$x
>> "/tmp/qemu-test/build/=3Ddestdir/tmp/qemu-test/install/keymaps"; \
>> done
>> install -c -m 0644 /tmp/qemu-test/build/trace-events-all
>> "/tmp/qemu-test/build/=3Ddestdir/tmp/qemu-test/install/trace-events-all"
>> for d in x86_64-softmmu aarch64-softmmu; do \
>> make --no-print-directory BUILD_DIR=3D/tmp/qemu-test/build TARGET_DIR=3D=
$d/ -C
>> $d install || exit 1 ; \
>>         done
>> install -d -m 0755 "/tmp/qemu-test/build/=3Ddestdir/tmp/qemu-test/instal=
l"
>> install -c -m 0755 qemu-system-x86_64.exe
>> "/tmp/qemu-test/build/=3Ddestdir/tmp/qemu-test/install"
>> install -d -m 0755 "/tmp/qemu-test/build/=3Ddestdir/tmp/qemu-test/instal=
l"
>> install -c -m 0755 qemu-system-aarch64.exe
>> "/tmp/qemu-test/build/=3Ddestdir/tmp/qemu-test/install"
>> mkdir -p dtc/libfdt
>> mkdir -p dtc/tests
>> rm -f *.timestamp
>> make -C tests/tcg clean
>> make[1]: Entering directory '/tmp/qemu-test/build/tests/tcg'
>> rm -f *.timestamp
>> rm -f *~ *.o test-i386.out test-i386.ref \
>>            test-x86_64.log test-x86_64.ref qruncom test_path hello-i386
>> linux-test testthread sha1-i386 test-i386 test-i386-fprem test-mmap
>> make[1]: Leaving directory '/tmp/qemu-test/build/tests/tcg'
>> rm -rf tests/check-qdict.exe tests/test-char.exe tests/check-qnum.exe
>> tests/check-qstring.exe tests/check-qlist.exe tests/check-qnull.exe
>> tests/check-qobject.exe tests/check-qjson.exe tests/check-qlit.exe
>> tests/test-qobject-output-visitor.exe tests/test-clone-visitor.exe
>> tests/test-qobject-input-visitor.exe tests/test-qmp-commands.exe
>> tests/test-string-input-visitor.exe tests/test-string-output-visitor.exe
>> tests/test-qmp-event.exe tests/test-opts-visitor.exe
>> tests/test-coroutine.exe tests/test-visitor-serialization.exe
>> tests/test-iov.exe tests/test-aio.exe tests/test-aio-multithread.exe
>> tests/test-throttle.exe tests/test-thread-pool.exe tests/test-hbitmap.ex=
e
>> tests/test-blockjob.exe tests/test-blockjob-txn.exe tests/test-x86-cpuid=
.exe
>> tests/test-xbzrle.exe tests/test-cutils.exe tests/test-shift128.exe
>> tests/test-mul64.exe tests/test-int128.exe tests/rcutorture.exe
>> tests/test-rcu-list.exe tests/test-qdist.exe tests/test-qht.exe
>> tests/test-qht-par.exe tests/test-bitops.exe tests/test-bitcnt.exe
>> tests/test-qdev-global-props.exe tests/check-qom-interface.exe
>> tests/check-qom-proplist.exe tests/test-qemu-opts.exe tests/test-keyval.=
exe
>> tests/test-write-threshold.exe tests/test-crypto-hash.exe
>> tests/test-crypto-hmac.exe tests/test-crypto-cipher.exe
>> tests/test-crypto-secret.exe tests/test-crypto-tlscredsx509.exe
>> tests/test-crypto-tlssession.exe tests/test-timed-average.exe
>> tests/test-io-task.exe tests/test-io-channel-socket.exe
>> tests/test-io-channel-file.exe tests/test-io-channel-tls.exe
>> tests/test-io-channel-command.exe tests/test-io-channel-buffer.exe
>> tests/test-base64.exe tests/test-crypto-pbkdf.exe
>> tests/test-crypto-ivgen.exe tests/test-crypto-afsplit.exe
>> tests/test-crypto-xts.exe tests/test-crypto-block.exe tests/test-logging=
.exe
>> tests/test-replication.exe tests/test-bufferiszero.exe tests/test-uuid.e=
xe
>> tests/ptimer-test.exe tests/test-qapi-util.exe tests/*.o
>> rm -rf tests/ac97-test.exe tests/ahci-test.exe tests/bios-tables-test.ex=
e
>> tests/boot-order-test.exe tests/boot-serial-test.exe
>> tests/device-introspect-test.exe tests/display-vga-test.exe
>> tests/drive_del-test.exe tests/ds1338-test.exe tests/e1000-test.exe
>> tests/e1000e-test.exe tests/eepro100-test.exe tests/endianness-test.exe
>> tests/es1370-test.exe tests/fdc-test.exe tests/fw_cfg-test.exe
>> tests/hd-geo-test.exe tests/i440fx-test.exe tests/i82801b11-test.exe
>> tests/ide-test.exe tests/intel-hda-test.exe tests/ioh3420-test.exe
>> tests/ipmi-bt-test.exe tests/ipmi-kcs-test.exe tests/ipoctal232-test.exe
>> tests/m25p80-test.exe tests/megasas-test.exe tests/migration-test.exe
>> tests/ne2000-test.exe tests/numa-test.exe tests/nvme-test.exe
>> tests/pc-cpu-test.exe tests/pcnet-test.exe tests/pnv-xscom-test.exe
>> tests/prom-env-test.exe tests/pvpanic-test.exe tests/pxe-test.exe
>> tests/q35-test.exe tests/qmp-test.exe tests/qom-test.exe tests/rtas-test=
.exe
>> tests/rtc-test.exe tests/rtl8139-test.exe tests/spapr-phb-test.exe
>> tests/tco-test.exe tests/test-arm-mptimer.exe tests/test-hmp.exe
>> tests/test-netfilter.exe tests/test-x86-cpuid-compat.exe
>> tests/tmp105-test.exe tests/tpci200-test.exe tests/usb-hcd-ehci-test.exe
>> tests/usb-hcd-ohci-test.exe tests/usb-hcd-uhci-test.exe
>> tests/usb-hcd-xhci-test.exe tests/virtio-balloon-test.exe
>> tests/virtio-blk-test.exe tests/virtio-console-test.exe
>> tests/virtio-net-test.exe tests/virtio-rng-test.exe
>> tests/virtio-scsi-test.exe tests/virtio-serial-test.exe
>> tests/vmgenid-test.exe tests/vmxnet3-test.exe tests/wdt_ib700-test.exe
>> rm -f config.mak op-i386.h opc-i386.h gen-op-i386.h op-arm.h opc-arm.h
>> gen-op-arm.h
>> rm -f qemu-options.def
>> rm -f *.msi
>> find . \( -name '*.so' -o -name '*.dll' -o -name '*.mo' -o -name '*.[oda=
]'
>> \) -type f -exec rm {} +
>> rm -f qemu-ga qemu-img.exe qemu-io.exe  qemu-ga TAGS cscope.* *.pod *~
>> */*~
>> rm -f fsdev/*.pod scsi/*.pod
>> rm -f qemu-img-cmds.h
>> rm -f ui/shader/*-vert.h ui/shader/*-frag.h
>> rm -f trace/generated-tracers-dtrace.dtrace*
>> rm -f trace/generated-tracers-dtrace.h*
>> rm -f qemu-version.h qemu-version.h-timestamp config-host.h
>> config-host.h-timestamp qemu-options.def qemu-options.def-timestamp
>> qmp-commands.h qmp-commands.h-timestamp qapi-types.h qapi-types.h-timest=
amp
>> qapi-visit.h qapi-visit.h-timestamp qapi-event.h qapi-event.h-timestamp
>> qmp-marshal.c qmp-marshal.c-timestamp qapi-types.c qapi-types.c-timestam=
p
>> qapi-visit.c qapi-visit.c-timestamp qapi-event.c qapi-event.c-timestamp
>> qmp-introspect.h qmp-introspect.h-timestamp qmp-introspect.c
>> qmp-introspect.c-timestamp trace/generated-tcg-tracers.h
>> trace/generated-tcg-tracers.h-timestamp trace/generated-helpers-wrappers=
.h
>> trace/generated-helpers-wrappers.h-timestamp trace/generated-helpers.h
>> trace/generated-helpers.h-timestamp trace/generated-helpers.c
>> trace/generated-helpers.c-timestamp module_block.h module_block.h-timest=
amp
>> trace-root.h trace-root.h-timestamp util/trace.h util/trace.h-timestamp
>> crypto/trace.h crypto/trace.h-timestamp io/trace.h io/trace.h-timestamp
>> migration/trace.h migration/trace.h-timestamp block/trace.h
>> block/trace.h-timestamp chardev/trace.h chardev/trace.h-timestamp
>> hw/block/trace.h hw/block/trace.h-timestamp hw/block/dataplane/trace.h
>> hw/block/dataplane/trace.h-timestamp hw/char/trace.h
>> hw/char/trace.h-timestamp hw/intc/trace.h hw/intc/trace.h-timestamp
>> hw/net/trace.h hw/net/trace.h-timestamp hw/virtio/trace.h
>> hw/virtio/trace.h-timestamp hw/audio/trace.h hw/audio/trace.h-timestamp
>> hw/misc/trace.h hw/misc/trace.h-timestamp hw/usb/trace.h
>> hw/usb/trace.h-timestamp hw/scsi/trace.h hw/scsi/trace.h-timestamp
>> hw/nvram/trace.h hw/nvram/trace.h-timestamp hw/display/trace.h
>> hw/display/trace.h-timestamp hw/input/trace.h hw/input/trace.h-timestamp
>> hw/timer/trace.h hw/timer/trace.h-timestamp hw/dma/trace.h
>> hw/dma/trace.h-timestamp hw/sparc/trace.h hw/sparc/trace.h-timestamp
>> hw/sd/trace.h hw/sd/trace.h-timestamp hw/isa/trace.h
>> hw/isa/trace.h-timestamp hw/mem/trace.h hw/mem/trace.h-timestamp
>> hw/i386/trace.h hw/i386/trace.h-timestamp hw/i386/xen/trace.h
>> hw/i386/xen/trace.h-timestamp hw/9pfs/trace.h hw/9pfs/trace.h-timestamp
>> hw/ppc/trace.h hw/ppc/trace.h-timestamp hw/pci/trace.h
>> hw/pci/trace.h-timestamp hw/s390x/trace.h hw/s390x/trace.h-timestamp
>> hw/vfio/trace.h hw/vfio/trace.h-timestamp hw/acpi/trace.h
>> hw/acpi/trace.h-timestamp hw/arm/trace.h hw/arm/trace.h-timestamp
>> hw/alpha/trace.h hw/alpha/trace.h-timestamp hw/xen/trace.h
>> hw/xen/trace.h-timestamp hw/ide/trace.h hw/ide/trace.h-timestamp ui/trac=
e.h
>> ui/trace.h-timestamp audio/trace.h audio/trace.h-timestamp net/trace.h
>> net/trace.h-timestamp target/arm/trace.h target/arm/trace.h-timestamp
>> target/i386/trace.h target/i386/trace.h-timestamp target/mips/trace.h
>> target/mips/trace.h-timestamp target/sparc/trace.h
>> target/sparc/trace.h-timestamp target/s390x/trace.h
>> target/s390x/trace.h-timestamp target/ppc/trace.h
>> target/ppc/trace.h-timestamp qom/trace.h qom/trace.h-timestamp
>> linux-user/trace.h linux-user/trace.h-timestamp qapi/trace.h
>> qapi/trace.h-timestamp accel/tcg/trace.h accel/tcg/trace.h-timestamp
>> accel/kvm/trace.h accel/kvm/trace.h-timestamp nbd/trace.h
>> nbd/trace.h-timestamp scsi/trace.h scsi/trace.h-timestamp trace-root.c
>> trace-root.c-timestamp util/trace.c util/trace.c-timestamp crypto/trace.=
c
>> crypto/trace.c-timestamp io/trace.c io/trace.c-timestamp migration/trace=
.c
>> migration/trace.c-timestamp block/trace.c block/trace.c-timestamp
>> chardev/trace.c chardev/trace.c-timestamp hw/block/trace.c
>> hw/block/trace.c-timestamp hw/block/dataplane/trace.c
>> hw/block/dataplane/trace.c-timestamp hw/char/trace.c
>> hw/char/trace.c-timestamp hw/intc/trace.c hw/intc/trace.c-timestamp
>> hw/net/trace.c hw/net/trace.c-timestamp hw/virtio/trace.c
>> hw/virtio/trace.c-timestamp hw/audio/trace.c hw/audio/trace.c-timestamp
>> hw/misc/trace.c hw/misc/trace.c-timestamp hw/usb/trace.c
>> hw/usb/trace.c-timestamp hw/scsi/trace.c hw/scsi/trace.c-timestamp
>> hw/nvram/trace.c hw/nvram/trace.c-timestamp hw/display/trace.c
>> hw/display/trace.c-timestamp hw/input/trace.c hw/input/trace.c-timestamp
>> hw/timer/trace.c hw/timer/trace.c-timestamp hw/dma/trace.c
>> hw/dma/trace.c-timestamp hw/sparc/trace.c hw/sparc/trace.c-timestamp
>> hw/sd/trace.c hw/sd/trace.c-timestamp hw/isa/trace.c
>> hw/isa/trace.c-timestamp hw/mem/trace.c hw/mem/trace.c-timestamp
>> hw/i386/trace.c hw/i386/trace.c-timestamp hw/i386/xen/trace.c
>> hw/i386/xen/trace.c-timestamp hw/9pfs/trace.c hw/9pfs/trace.c-timestamp
>> hw/ppc/trace.c hw/ppc/trace.c-timestamp hw/pci/trace.c
>> hw/pci/trace.c-timestamp hw/s390x/trace.c hw/s390x/trace.c-timestamp
>> hw/vfio/trace.c hw/vfio/trace.c-timestamp hw/acpi/trace.c
>> hw/acpi/trace.c-timestamp hw/arm/trace.c hw/arm/trace.c-timestamp
>> hw/alpha/trace.c hw/alpha/trace.c-timestamp hw/xen/trace.c
>> hw/xen/trace.c-timestamp hw/ide/trace.c hw/ide/trace.c-timestamp ui/trac=
e.c
>> ui/trace.c-timestamp audio/trace.c audio/trace.c-timestamp net/trace.c
>> net/trace.c-timestamp target/arm/trace.c target/arm/trace.c-timestamp
>> target/i386/trace.c target/i386/trace.c-timestamp target/mips/trace.c
>> target/mips/trace.c-timestamp target/sparc/trace.c
>> target/sparc/trace.c-timestamp target/s390x/trace.c
>> target/s390x/trace.c-timestamp target/ppc/trace.c
>> target/ppc/trace.c-timestamp qom/trace.c qom/trace.c-timestamp
>> linux-user/trace.c linux-user/trace.c-timestamp qapi/trace.c
>> qapi/trace.c-timestamp accel/tcg/trace.c accel/tcg/trace.c-timestamp
>> accel/kvm/trace.c accel/kvm/trace.c-timestamp nbd/trace.c
>> nbd/trace.c-timestamp scsi/trace.c scsi/trace.c-timestamp
>> /tmp/qemu-test/build/trace-events-all
>> /tmp/qemu-test/build/trace-events-all-timestamp .git-submodule-status
>> .git-submodule-status-timestamp ui/input-keymap-linux-to-qcode.c
>> ui/input-keymap-linux-to-qcode.c-timestamp ui/input-keymap-qcode-to-qnum=
.c
>> ui/input-keymap-qcode-to-qnum.c-timestamp ui/input-keymap-qnum-to-qcode.=
c
>> ui/input-keymap-qnum-to-qcode.c-timestamp tests/test-qapi-types.h
>> tests/test-qapi-types.h-timestamp tests/test-qapi-visit.h
>> tests/test-qapi-visit.h-timestamp tests/test-qmp-commands.h
>> tests/test-qmp-commands.h-timestamp tests/test-qapi-event.h
>> tests/test-qapi-event.h-timestamp tests/test-qmp-introspect.h
>> tests/test-qmp-introspect.h-timestamp
>> rm -rf qapi-generated
>> rm -rf qga/qapi-generated
>> for d in x86_64-softmmu aarch64-softmmu pc-bios/optionrom; do \
>> if test -d $d; then make -C $d clean || exit 1; fi; \
>> rm -f $d/qemu-options.def; \
>>         done
>> make[1]: Entering directory '/tmp/qemu-test/build/x86_64-softmmu'
>> rm -f *.timestamp
>> rm -f *.a *~ qemu-system-x86_64.exe
>> rm -f
>> rm -f hmp-commands.h gdbstub-xml.c
>> make[1]: Leaving directory '/tmp/qemu-test/build/x86_64-softmmu'
>> make[1]: Entering directory '/tmp/qemu-test/build/aarch64-softmmu'
>> rm -f *.timestamp
>> rm -f *.a *~ qemu-system-aarch64.exe
>> rm -f
>> rm -f hmp-commands.h gdbstub-xml.c
>> make[1]: Leaving directory '/tmp/qemu-test/build/aarch64-softmmu'
>> make[1]: Entering directory '/tmp/qemu-test/build/pc-bios/optionrom'
>> rm -f *.timestamp
>> rm -f *.o *.d *.raw *.img *.bin *~
>> make[1]: Leaving directory '/tmp/qemu-test/build/pc-bios/optionrom'
>> rm -f  x86_64-softmmu/config-devices.mak
>> aarch64-softmmu/config-devices.mak config-all-devices.mak
>>     CLEANUP
>> /var/tmp/patchew-tester-tmp-gmdmoybf/src/docker-src.2017-11-21-17.05.20.=
8528
>> make[1]: Leaving directory '/var/tmp/patchew-tester-tmp-gmdmoybf/src'
>>
>> real    3m45.912s
>> user    0m5.292s
>> sys     0m4.939s
>>   BUILD   fedora
>> make[1]: Entering directory '/var/tmp/patchew-tester-tmp-gmdmoybf/src'
>>   GEN
>> /var/tmp/patchew-tester-tmp-gmdmoybf/src/docker-src.2017-11-21-17.09.06.=
20869/qemu.tar
>> Cloning into
>> '/var/tmp/patchew-tester-tmp-gmdmoybf/src/docker-src.2017-11-21-17.09.06=
.20869/qemu.tar.vroot'...
>> done.
>> Checking out files:  13% (751/5662)
>> Checking out files:  14% (793/5662)
>> Checking out files:  15% (850/5662)
>> Checking out files:  16% (906/5662)
>> Checking out files:  17% (963/5662)
>> Checking out files:  18% (1020/5662)
>> Checking out files:  19% (1076/5662)
>> Checking out files:  20% (1133/5662)
>> Checking out files:  21% (1190/5662)
>> Checking out files:  22% (1246/5662)
>> Checking out files:  23% (1303/5662)
>> Checking out files:  24% (1359/5662)
>> Checking out files:  25% (1416/5662)
>> Checking out files:  26% (1473/5662)
>> Checking out files:  27% (1529/5662)
>> Checking out files:  28% (1586/5662)
>> Checking out files:  29% (1642/5662)
>> Checking out files:  30% (1699/5662)
>> Checking out files:  31% (1756/5662)
>> Checking out files:  32% (1812/5662)
>> Checking out files:  33% (1869/5662)
>> Checking out files:  34% (1926/5662)
>> Checking out files:  35% (1982/5662)
>> Checking out files:  36% (2039/5662)
>> Checking out files:  37% (2095/5662)
>> Checking out files:  38% (2152/5662)
>> Checking out files:  39% (2209/5662)
>> Checking out files:  40% (2265/5662)
>> Checking out files:  41% (2322/5662)
>> Checking out files:  42% (2379/5662)
>> Checking out files:  43% (2435/5662)
>> Checking out files:  44% (2492/5662)
>> Checking out files:  45% (2548/5662)
>> Checking out files:  46% (2605/5662)
>> Checking out files:  47% (2662/5662)
>> Checking out files:  48% (2718/5662)
>> Checking out files:  49% (2775/5662)
>> Checking out files:  50% (2831/5662)
>> Checking out files:  51% (2888/5662)
>> Checking out files:  52% (2945/5662)
>> Checking out files:  53% (3001/5662)
>> Checking out files:  53% (3032/5662)
>> Checking out files:  54% (3058/5662)
>> Checking out files:  55% (3115/5662)
>> Checking out files:  56% (3171/5662)
>> Checking out files:  57% (3228/5662)
>> Checking out files:  58% (3284/5662)
>> Checking out files:  59% (3341/5662)
>> Checking out files:  60% (3398/5662)
>> Checking out files:  61% (3454/5662)
>> Checking out files:  62% (3511/5662)
>> Checking out files:  63% (3568/5662)
>> Checking out files:  64% (3624/5662)
>> Checking out files:  65% (3681/5662)
>> Checking out files:  66% (3737/5662)
>> Checking out files:  67% (3794/5662)
>> Checking out files:  68% (3851/5662)
>> Checking out files:  69% (3907/5662)
>> Checking out files:  70% (3964/5662)
>> Checking out files:  71% (4021/5662)
>> Checking out files:  72% (4077/5662)
>> Checking out files:  73% (4134/5662)
>> Checking out files:  74% (4190/5662)
>> Checking out files:  75% (4247/5662)
>> Checking out files:  76% (4304/5662)
>> Checking out files:  77% (4360/5662)
>> Checking out files:  78% (4417/5662)
>> Checking out files:  79% (4473/5662)
>> Checking out files:  80% (4530/5662)
>> Checking out files:  81% (4587/5662)
>> Checking out files:  82% (4643/5662)
>> Checking out files:  83% (4700/5662)
>> Checking out files:  84% (4757/5662)
>> Checking out files:  85% (4813/5662)
>> Checking out files:  86% (4870/5662)
>> Checking out files:  87% (4926/5662)
>> Checking out files:  88% (4983/5662)
>> Checking out files:  89% (5040/5662)
>> Checking out files:  90% (5096/5662)
>> Checking out files:  91% (5153/5662)
>> Checking out files:  92% (5210/5662)
>> Checking out files:  93% (5266/5662)
>> Checking out files:  94% (5323/5662)
>> Checking out files:  95% (5379/5662)
>> Checking out files:  96% (5436/5662)
>> Checking out files:  97% (5493/5662)
>> Checking out files:  98% (5549/5662)
>> Checking out files:  99% (5606/5662)
>> Checking out files: 100% (5662/5662)
>> Checking out files: 100% (5662/5662), done.
>> Your branch is up-to-date with 'origin/test'.
>> Submodule 'dtc' (git://git.qemu-project.org/dtc.git) registered for path
>> 'dtc'
>> Cloning into
>> '/var/tmp/patchew-tester-tmp-gmdmoybf/src/docker-src.2017-11-21-17.09.06=
.20869/qemu.tar.vroot/dtc'...
>> Submodule path 'dtc': checked out
>> '558cd81bdd432769b59bff01240c44f82cfb1a9d'
>> Submodule 'ui/keycodemapdb' (git://git.qemu.org/keycodemapdb.git)
>> registered for path 'ui/keycodemapdb'
>> Cloning into
>> '/var/tmp/patchew-tester-tmp-gmdmoybf/src/docker-src.2017-11-21-17.09.06=
.20869/qemu.tar.vroot/ui/keycodemapdb'...
>> Submodule path 'ui/keycodemapdb': checked out
>> '10739aa26051a5d49d88132604539d3ed085e72e'
>>   COPY    RUNNER
>>     RUN test-block in qemu:fedora
>> Packages installed:
>> PyYAML-3.11-13.fc25.x86_64
>> SDL-devel-1.2.15-21.fc24.x86_64
>> bc-1.06.95-16.fc24.x86_64
>> bison-3.0.4-4.fc24.x86_64
>> bzip2-1.0.6-21.fc25.x86_64
>> ccache-3.3.4-1.fc25.x86_64
>> clang-3.9.1-2.fc25.x86_64
>> findutils-4.6.0-8.fc25.x86_64
>> flex-2.6.0-3.fc25.x86_64
>> gcc-6.4.1-1.fc25.x86_64
>> gcc-c++-6.4.1-1.fc25.x86_64
>> gettext-0.19.8.1-3.fc25.x86_64
>> git-2.9.5-1.fc25.x86_64
>> glib2-devel-2.50.3-1.fc25.x86_64
>> hostname-3.15-8.fc25.x86_64
>> libaio-devel-0.3.110-6.fc24.x86_64
>> libfdt-devel-1.4.2-1.fc25.x86_64
>> make-4.1-6.fc25.x86_64
>> mingw32-SDL-1.2.15-7.fc24.noarch
>> mingw32-bzip2-1.0.6-7.fc24.noarch
>> mingw32-curl-7.47.0-1.fc24.noarch
>> mingw32-glib2-2.50.3-1.fc25.noarch
>> mingw32-gmp-6.1.1-1.fc25.noarch
>> mingw32-gnutls-3.5.5-2.fc25.noarch
>> mingw32-gtk2-2.24.31-2.fc25.noarch
>> mingw32-gtk3-3.22.17-1.fc25.noarch
>> mingw32-libjpeg-turbo-1.5.1-1.fc25.noarch
>> mingw32-libpng-1.6.27-1.fc25.noarch
>> mingw32-libssh2-1.4.3-5.fc24.noarch
>> mingw32-libtasn1-4.9-1.fc25.noarch
>> mingw32-nettle-3.3-1.fc25.noarch
>> mingw32-pixman-0.34.0-1.fc25.noarch
>> mingw32-pkg-config-0.28-6.fc24.x86_64
>> mingw64-SDL-1.2.15-7.fc24.noarch
>> mingw64-bzip2-1.0.6-7.fc24.noarch
>> mingw64-curl-7.47.0-1.fc24.noarch
>> mingw64-glib2-2.50.3-1.fc25.noarch
>> mingw64-gmp-6.1.1-1.fc25.noarch
>> mingw64-gnutls-3.5.5-2.fc25.noarch
>> mingw64-gtk2-2.24.31-2.fc25.noarch
>> mingw64-gtk3-3.22.17-1.fc25.noarch
>> mingw64-libjpeg-turbo-1.5.1-1.fc25.noarch
>> mingw64-libpng-1.6.27-1.fc25.noarch
>> mingw64-libssh2-1.4.3-5.fc24.noarch
>> mingw64-libtasn1-4.9-1.fc25.noarch
>> mingw64-nettle-3.3-1.fc25.noarch
>> mingw64-pixman-0.34.0-1.fc25.noarch
>> mingw64-pkg-config-0.28-6.fc24.x86_64
>> nettle-devel-3.3-1.fc25.x86_64
>> package python2 is not installed
>> perl-5.24.2-387.fc25.x86_64
>> pixman-devel-0.34.0-2.fc24.x86_64
>> sparse-0.5.0-10.fc25.x86_64
>> tar-1.29-3.fc25.x86_64
>> which-2.21-1.fc25.x86_64
>> zlib-devel-1.2.8-10.fc24.x86_64
>>
>> Environment variables:
>> PACKAGES=3Dccache gettext git tar PyYAML sparse flex bison python2 bzip2
>> hostname     glib2-devel pixman-devel zlib-devel SDL-devel libfdt-devel
>> gcc gcc-c++ clang make perl which bc findutils libaio-devel     nettle-d=
evel
>> mingw32-pixman mingw32-glib2 mingw32-gmp mingw32-SDL mingw32-pkg-config
>> mingw32-gtk2 mingw32-gtk3 mingw32-gnutls mingw32-nettle mingw32-libtasn1
>> mingw32-libjpeg-turbo mingw32-libpng mingw32-curl mingw32-libssh2
>> mingw32-bzip2     mingw64-pixman mingw64-glib2 mingw64-gmp mingw64-SDL
>> mingw64-pkg-config     mingw64-gtk2 mingw64-gtk3 mingw64-gnutls
>> mingw64-nettle mingw64-libtasn1     mingw64-libjpeg-turbo mingw64-libpng
>> mingw64-curl mingw64-libssh2     mingw64-bzip2
>> HOSTNAME=3Dcbbc6bacf475
>> MAKEFLAGS=3D -j8
>> J=3D8
>> CCACHE_DIR=3D/var/tmp/ccache
>> EXTRA_CONFIGURE_OPTS=3D
>> V=3D
>> SHOW_ENV=3D1
>>
>> PATH=3D/usr/lib/ccache:/usr/lib64/ccache:/usr/local/sbin:/usr/local/bin:=
/usr/sbin:/usr/bin:/sbin:/bin
>> PWD=3D/
>> TARGET_LIST=3D
>> FGC=3Df25
>> SHLVL=3D1
>> HOME=3D/root
>> TEST_DIR=3D/tmp/qemu-test
>> DISTTAG=3Df25container
>> FEATURES=3Dmingw clang pyyaml dtc
>> DEBUG=3D
>> _=3D/usr/bin/env
>>
>> Configure options:
>> --enable-werror --prefix=3D/tmp/qemu-test/install
>> --target-list=3Dx86_64-softmmu
>> Install prefix    /tmp/qemu-test/install
>> BIOS directory    /tmp/qemu-test/install/share/qemu
>> firmware path     /tmp/qemu-test/install/share/qemu-firmware
>> binary directory  /tmp/qemu-test/install/bin
>> library directory /tmp/qemu-test/install/lib
>> module directory  /tmp/qemu-test/install/lib/qemu
>> libexec directory /tmp/qemu-test/install/libexec
>> include directory /tmp/qemu-test/install/include
>> config directory  /tmp/qemu-test/install/etc
>> local state directory   /tmp/qemu-test/install/var
>> Manual directory  /tmp/qemu-test/install/share/man
>> ELF interp prefix /usr/gnemul/qemu-%M
>> Source path       /tmp/qemu-test/src
>> GIT binary        git
>> GIT submodules
>> C compiler        cc
>> Host C compiler   cc
>> C++ compiler      c++
>> Objective-C compiler clang
>> ARFLAGS           rv
>> CFLAGS            -O2 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=3D2 -g
>> QEMU_CFLAGS       -I/usr/include/pixman-1  -Werror -pthread
>> -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include -fPIE -DPIE -m64
>> -mcx16 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE
>> -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings
>> -Wmissing-prototypes -fno-strict-aliasing -fno-common -fwrapv
>> -Wendif-labels -Wno-shift-negative-value -Wno-missing-include-dirs
>> -Wempty-body -Wnested-externs -Wformat-security -Wformat-y2k -Winit-self
>> -Wignored-qualifiers -Wold-style-declaration -Wold-style-definition
>> -Wtype-limits -fstack-protector-strong
>> LDFLAGS           -Wl,--warn-common -Wl,-z,relro -Wl,-z,now -pie -m64 -g
>> make              make
>> install           install
>> python            python -B
>> smbd              /usr/sbin/smbd
>> module support    no
>> host CPU          x86_64
>> host big endian   no
>> target list       x86_64-softmmu
>> gprof enabled     no
>> sparse enabled    no
>> strip binaries    yes
>> profiler          no
>> static build      no
>> SDL support       yes (1.2.15)
>> GTK support       no
>> GTK GL support    no
>> VTE support       no
>> TLS priority      NORMAL
>> GNUTLS support    no
>> GNUTLS rnd        no
>> libgcrypt         no
>> libgcrypt kdf     no
>> nettle            yes (3.3)
>> nettle kdf        yes
>> libtasn1          no
>> curses support    no
>> virgl support     no
>> curl support      no
>> mingw32 support   no
>> Audio drivers     oss
>> Block whitelist (rw)
>> Block whitelist (ro)
>> VirtFS support    no
>> Multipath support no
>> VNC support       yes
>> VNC SASL support  no
>> VNC JPEG support  no
>> VNC PNG support   no
>> xen support       no
>> brlapi support    no
>> bluez  support    no
>> Documentation     no
>> PIE               yes
>> vde support       no
>> netmap support    no
>> Linux AIO support yes
>> ATTR/XATTR support yes
>> Install blobs     yes
>> KVM support       yes
>> HAX support       no
>> TCG support       yes
>> TCG debug enabled no
>> TCG interpreter   no
>> RDMA support      no
>> fdt support       yes
>> preadv support    yes
>> fdatasync         yes
>> madvise           yes
>> posix_madvise     yes
>> libcap-ng support no
>> vhost-net support yes
>> vhost-scsi support yes
>> vhost-vsock support yes
>> vhost-user support yes
>> Trace backends    log
>> spice support     no
>> rbd support       no
>> xfsctl support    no
>> smartcard support no
>> libusb            no
>> usb net redir     no
>> OpenGL support    no
>> OpenGL dmabufs    no
>> libiscsi support  no
>> libnfs support    no
>> build guest agent yes
>> QGA VSS support   no
>> QGA w32 disk info no
>> QGA MSI support   no
>> seccomp support   no
>> coroutine backend ucontext
>> coroutine pool    yes
>> debug stack usage no
>> crypto afalg      no
>> GlusterFS support no
>> gcov              gcov
>> gcov enabled      no
>> TPM support       yes
>> libssh2 support   no
>> TPM passthrough   yes
>> TPM emulator      yes
>> QOM debugging     yes
>> Live block migration yes
>> lzo support       no
>> snappy support    no
>> bzip2 support     no
>> NUMA host support no
>> tcmalloc support  no
>> jemalloc support  no
>> avx2 optimization yes
>> replication support yes
>> VxHS block device no
>> capstone          no
>>   GEN     x86_64-softmmu/config-devices.mak.tmp
>>   GEN     config-host.h
>>   GEN     qemu-options.def
>>   GEN     qmp-commands.h
>>   GEN     qapi-types.h
>>   GEN     qapi-event.h
>>   GEN     qapi-visit.h
>>   GEN     qmp-marshal.c
>>   GEN     x86_64-softmmu/config-devices.mak
>>   GEN     qapi-types.c
>>   GEN     qapi-visit.c
>>   GEN     qapi-event.c
>>   GEN     qmp-introspect.h
>>   GEN     qmp-introspect.c
>>   GEN     trace/generated-tcg-tracers.h
>>   GEN     trace/generated-helpers.c
>>   GEN     trace/generated-helpers.h
>>   GEN     trace/generated-helpers-wrappers.h
>>   GEN     module_block.h
>>   GEN     ui/input-keymap-linux-to-qcode.c
>>   GEN     ui/input-keymap-qcode-to-qnum.c
>>   GEN     ui/input-keymap-qnum-to-qcode.c
>>   GEN     tests/test-qapi-types.h
>>   GEN     tests/test-qapi-visit.h
>>   GEN     tests/test-qmp-commands.h
>>   GEN     tests/test-qapi-event.h
>>   GEN     tests/test-qmp-introspect.h
>>   GEN     trace-root.h
>>   GEN     util/trace.h
>>   GEN     crypto/trace.h
>>   GEN     io/trace.h
>>   GEN     migration/trace.h
>>   GEN     block/trace.h
>>   GEN     chardev/trace.h
>>   GEN     hw/block/trace.h
>>   GEN     hw/block/dataplane/trace.h
>>   GEN     hw/char/trace.h
>>   GEN     hw/intc/trace.h
>>   GEN     hw/net/trace.h
>>   GEN     hw/virtio/trace.h
>>   GEN     hw/audio/trace.h
>>   GEN     hw/misc/trace.h
>>   GEN     hw/usb/trace.h
>>   GEN     hw/scsi/trace.h
>>   GEN     hw/nvram/trace.h
>>   GEN     hw/display/trace.h
>>   GEN     hw/input/trace.h
>>   GEN     hw/timer/trace.h
>>   GEN     hw/dma/trace.h
>>   GEN     hw/sparc/trace.h
>>   GEN     hw/sd/trace.h
>>   GEN     hw/isa/trace.h
>>   GEN     hw/mem/trace.h
>>   GEN     hw/i386/trace.h
>>   GEN     hw/i386/xen/trace.h
>>   GEN     hw/9pfs/trace.h
>>   GEN     hw/ppc/trace.h
>>   GEN     hw/pci/trace.h
>>   GEN     hw/s390x/trace.h
>>   GEN     hw/vfio/trace.h
>>   GEN     hw/acpi/trace.h
>>   GEN     hw/arm/trace.h
>>   GEN     hw/alpha/trace.h
>>   GEN     hw/xen/trace.h
>>   GEN     hw/ide/trace.h
>>   GEN     ui/trace.h
>>   GEN     audio/trace.h
>>   GEN     net/trace.h
>>   GEN     target/arm/trace.h
>>   GEN     target/i386/trace.h
>>   GEN     target/mips/trace.h
>>   GEN     target/sparc/trace.h
>>   GEN     target/s390x/trace.h
>>   GEN     target/ppc/trace.h
>>   GEN     qom/trace.h
>>   GEN     linux-user/trace.h
>>   GEN     qapi/trace.h
>>   GEN     accel/tcg/trace.h
>>   GEN     accel/kvm/trace.h
>>   GEN     nbd/trace.h
>>   GEN     scsi/trace.h
>>   GEN     trace-root.c
>>   GEN     util/trace.c
>>   GEN     crypto/trace.c
>>   GEN     io/trace.c
>>   GEN     migration/trace.c
>>   GEN     block/trace.c
>>   GEN     chardev/trace.c
>>   GEN     hw/block/trace.c
>>   GEN     hw/block/dataplane/trace.c
>>   GEN     hw/char/trace.c
>>   GEN     hw/intc/trace.c
>>   GEN     hw/net/trace.c
>>   GEN     hw/virtio/trace.c
>>   GEN     hw/audio/trace.c
>>   GEN     hw/misc/trace.c
>>   GEN     hw/usb/trace.c
>>   GEN     hw/scsi/trace.c
>>   GEN     hw/nvram/trace.c
>>   GEN     hw/display/trace.c
>>   GEN     hw/input/trace.c
>>   GEN     hw/timer/trace.c
>>   GEN     hw/dma/trace.c
>>   GEN     hw/sparc/trace.c
>>   GEN     hw/sd/trace.c
>>   GEN     hw/isa/trace.c
>>   GEN     hw/mem/trace.c
>>   GEN     hw/i386/trace.c
>>   GEN     hw/i386/xen/trace.c
>>   GEN     hw/9pfs/trace.c
>>   GEN     hw/ppc/trace.c
>>   GEN     hw/pci/trace.c
>>   GEN     hw/s390x/trace.c
>>   GEN     hw/vfio/trace.c
>>   GEN     hw/acpi/trace.c
>>   GEN     hw/arm/trace.c
>>   GEN     hw/alpha/trace.c
>>   GEN     hw/xen/trace.c
>>   GEN     hw/ide/trace.c
>>   GEN     ui/trace.c
>>   GEN     audio/trace.c
>>   GEN     net/trace.c
>>   GEN     target/arm/trace.c
>>   GEN     target/i386/trace.c
>>   GEN     target/mips/trace.c
>>   GEN     target/sparc/trace.c
>>   GEN     target/s390x/trace.c
>>   GEN     target/ppc/trace.c
>>   GEN     qom/trace.c
>>   GEN     linux-user/trace.c
>>   GEN     qapi/trace.c
>>   GEN     accel/tcg/trace.c
>>   GEN     accel/kvm/trace.c
>>   GEN     nbd/trace.c
>>   GEN     scsi/trace.c
>>   GEN     config-all-devices.mak
>>   CC      tests/qemu-iotests/socket_scm_helper.o
>>   GEN     qga/qapi-generated/qga-qapi-types.h
>>   GEN     qga/qapi-generated/qga-qmp-commands.h
>>   GEN     qga/qapi-generated/qga-qapi-types.c
>>   GEN     qga/qapi-generated/qga-qmp-marshal.c
>>   CC      qmp-introspect.o
>>   GEN     qga/qapi-generated/qga-qapi-visit.h
>>   GEN     qga/qapi-generated/qga-qapi-visit.c
>>   CC      qapi-types.o
>>   CC      qapi-event.o
>>   CC      qapi-visit.o
>>   CC      qapi/qapi-visit-core.o
>>   CC      qapi/qapi-dealloc-visitor.o
>>   CC      qapi/qobject-input-visitor.o
>>   CC      qapi/qobject-output-visitor.o
>>   CC      qapi/qmp-registry.o
>>   CC      qapi/qmp-dispatch.o
>>   CC      qapi/string-input-visitor.o
>>   CC      qapi/string-output-visitor.o
>>   CC      qapi/qapi-clone-visitor.o
>>   CC      qapi/opts-visitor.o
>>   CC      qapi/qmp-event.o
>>   CC      qapi/qapi-util.o
>>   CC      qobject/qnull.o
>>   CC      qobject/qstring.o
>>   CC      qobject/qnum.o
>>   CC      qobject/qdict.o
>>   CC      qobject/qlist.o
>>   CC      qobject/qjson.o
>>   CC      qobject/qbool.o
>>   CC      qobject/qobject.o
>>   CC      qobject/qlit.o
>>   CC      qobject/json-lexer.o
>>   CC      qobject/json-streamer.o
>>   CC      qobject/json-parser.o
>>   CC      trace/control.o
>>   CC      util/osdep.o
>>   CC      trace/qmp.o
>>   CC      util/cutils.o
>>   CC      util/unicode.o
>>   CC      util/qemu-timer-common.o
>>   CC      util/bufferiszero.o
>>   CC      util/lockcnt.o
>>   CC      util/aiocb.o
>>   CC      util/async.o
>>   CC      util/thread-pool.o
>>   CC      util/qemu-timer.o
>>   CC      util/main-loop.o
>>   CC      util/iohandler.o
>>   CC      util/compatfd.o
>>   CC      util/event_notifier-posix.o
>>   CC      util/aio-posix.o
>>   CC      util/mmap-alloc.o
>>   CC      util/oslib-posix.o
>>   CC      util/qemu-openpty.o
>>   CC      util/qemu-thread-posix.o
>>   CC      util/envlist.o
>>   CC      util/memfd.o
>>   CC      util/path.o
>>   CC      util/module.o
>>   CC      util/host-utils.o
>>   CC      util/bitmap.o
>>   CC      util/bitops.o
>>   CC      util/hbitmap.o
>>   CC      util/fifo8.o
>>   CC      util/acl.o
>>   CC      util/cacheinfo.o
>>   CC      util/error.o
>>   CC      util/qemu-error.o
>>   CC      util/id.o
>>   CC      util/iov.o
>>   CC      util/qemu-sockets.o
>>   CC      util/qemu-config.o
>>   CC      util/uri.o
>>   CC      util/notify.o
>>   CC      util/qemu-option.o
>>   CC      util/qemu-progress.o
>>   CC      util/keyval.o
>>   CC      util/hexdump.o
>>   CC      util/crc32c.o
>>   CC      util/uuid.o
>>   CC      util/throttle.o
>>   CC      util/getauxval.o
>>   CC      util/readline.o
>>   CC      util/rcu.o
>>   CC      util/qemu-coroutine.o
>>   CC      util/qemu-coroutine-lock.o
>>   CC      util/qemu-coroutine-io.o
>>   CC      util/qemu-coroutine-sleep.o
>>   CC      util/coroutine-ucontext.o
>>   CC      util/buffer.o
>>   CC      util/timed-average.o
>>   CC      util/base64.o
>>   CC      util/log.o
>>   CC      util/qdist.o
>>   CC      util/pagesize.o
>>   CC      util/qht.o
>>   CC      util/range.o
>>   CC      util/stats64.o
>>   CC      util/systemd.o
>>   CC      trace-root.o
>>   CC      util/trace.o
>>   CC      crypto/trace.o
>>   CC      io/trace.o
>>   CC      migration/trace.o
>>   CC      block/trace.o
>>   CC      chardev/trace.o
>>   CC      hw/block/trace.o
>>   CC      hw/block/dataplane/trace.o
>>   CC      hw/char/trace.o
>>   CC      hw/intc/trace.o
>>   CC      hw/net/trace.o
>>   CC      hw/virtio/trace.o
>>   CC      hw/audio/trace.o
>>   CC      hw/misc/trace.o
>>   CC      hw/scsi/trace.o
>>   CC      hw/usb/trace.o
>>   CC      hw/nvram/trace.o
>>   CC      hw/input/trace.o
>>   CC      hw/display/trace.o
>>   CC      hw/timer/trace.o
>>   CC      hw/dma/trace.o
>>   CC      hw/sparc/trace.o
>>   CC      hw/sd/trace.o
>>   CC      hw/isa/trace.o
>>   CC      hw/mem/trace.o
>>   CC      hw/i386/trace.o
>>   CC      hw/i386/xen/trace.o
>>   CC      hw/9pfs/trace.o
>>   CC      hw/ppc/trace.o
>>   CC      hw/pci/trace.o
>>   CC      hw/s390x/trace.o
>>   CC      hw/acpi/trace.o
>>   CC      hw/vfio/trace.o
>>   CC      hw/arm/trace.o
>>   CC      hw/alpha/trace.o
>>   CC      hw/xen/trace.o
>>   CC      hw/ide/trace.o
>>   CC      ui/trace.o
>>   CC      audio/trace.o
>>   CC      net/trace.o
>>   CC      target/arm/trace.o
>>   CC      target/i386/trace.o
>>   CC      target/mips/trace.o
>>   CC      target/sparc/trace.o
>>   CC      target/s390x/trace.o
>>   CC      target/ppc/trace.o
>>   CC      qom/trace.o
>>   CC      linux-user/trace.o
>>   CC      qapi/trace.o
>>   CC      accel/tcg/trace.o
>>   CC      accel/kvm/trace.o
>>   CC      nbd/trace.o
>>   CC      scsi/trace.o
>>   CC      crypto/pbkdf-stub.o
>>   CC      stubs/arch-query-cpu-def.o
>>   CC      stubs/arch-query-cpu-model-expansion.o
>>   CC      stubs/arch-query-cpu-model-comparison.o
>>   CC      stubs/arch-query-cpu-model-baseline.o
>>   CC      stubs/bdrv-next-monitor-owned.o
>>   CC      stubs/blk-commit-all.o
>>   CC      stubs/blockdev-close-all-bdrv-states.o
>>   CC      stubs/clock-warp.o
>>   CC      stubs/cpu-get-clock.o
>>   CC      stubs/dump.o
>>   CC      stubs/cpu-get-icount.o
>>   CC      stubs/error-printf.o
>>   CC      stubs/fdset.o
>>   CC      stubs/gdbstub.o
>>   CC      stubs/get-vm-name.o
>>   CC      stubs/iothread.o
>>   CC      stubs/iothread-lock.o
>>   CC      stubs/is-daemonized.o
>>   CC      stubs/linux-aio.o
>>   CC      stubs/machine-init-done.o
>>   CC      stubs/migr-blocker.o
>>   CC      stubs/change-state-handler.o
>>   CC      stubs/monitor.o
>>   CC      stubs/qtest.o
>>   CC      stubs/notify-event.o
>>   CC      stubs/replay.o
>>   CC      stubs/set-fd-handler.o
>>   CC      stubs/runstate-check.o
>>   CC      stubs/slirp.o
>>   CC      stubs/sysbus.o
>>   CC      stubs/trace-control.o
>>   CC      stubs/uuid.o
>>   CC      stubs/tpm.o
>>   CC      stubs/vm-stop.o
>>   CC      stubs/vmstate.o
>>   CC      stubs/qmp_pc_dimm.o
>>   CC      stubs/target-monitor-defs.o
>>   CC      stubs/target-get-monitor-def.o
>>   CC      stubs/pc_madt_cpu_entry.o
>>   CC      stubs/vmgenid.o
>>   CC      stubs/xen-hvm.o
>>   CC      stubs/xen-common.o
>>   CC      stubs/pci-host-piix.o
>>   CC      contrib/ivshmem-client/ivshmem-client.o
>>   CC      contrib/ivshmem-client/main.o
>>   CC      contrib/ivshmem-server/ivshmem-server.o
>>   CC      contrib/ivshmem-server/main.o
>>   CC      block.o
>>   CC      qemu-nbd.o
>>   CC      blockjob.o
>>   CC      qemu-io-cmds.o
>>   CC      replication.o
>>   CC      block/raw-format.o
>>   CC      block/qcow.o
>>   CC      block/vdi.o
>>   CC      block/vmdk.o
>>   CC      block/cloop.o
>>   CC      block/bochs.o
>>   CC      block/vpc.o
>>   CC      block/vvfat.o
>>   CC      block/qcow2.o
>>   CC      block/dmg.o
>>   CC      block/qcow2-refcount.o
>>   CC      block/qcow2-cluster.o
>>   CC      block/qcow2-snapshot.o
>>   CC      block/qcow2-cache.o
>>   CC      block/qcow2-bitmap.o
>>   CC      block/qed.o
>>   CC      block/qed-l2-cache.o
>>   CC      block/qed-table.o
>>   CC      block/qed-cluster.o
>>   CC      block/qed-check.o
>>   CC      block/vhdx.o
>>   CC      block/vhdx-endian.o
>>   CC      block/vhdx-log.o
>>   CC      block/quorum.o
>>   CC      block/parallels.o
>>   CC      block/blkdebug.o
>>   CC      block/blkverify.o
>>   CC      block/blkreplay.o
>>   CC      block/block-backend.o
>>   CC      block/snapshot.o
>>   CC      block/qapi.o
>>   CC      block/linux-aio.o
>>   CC      block/null.o
>>   CC      block/file-posix.o
>>   CC      block/mirror.o
>>   CC      block/commit.o
>>   CC      block/io.o
>>   CC      block/throttle-groups.o
>>   CC      block/nbd-client.o
>>   CC      block/nbd.o
>>   CC      block/sheepdog.o
>>   CC      block/accounting.o
>>   CC      block/dirty-bitmap.o
>>   CC      block/write-threshold.o
>>   CC      block/replication.o
>>   CC      block/throttle.o
>>   CC      block/backup.o
>>   CC      block/crypto.o
>>   CC      nbd/server.o
>>   CC      nbd/client.o
>>   CC      nbd/common.o
>>   CC      scsi/pr-manager.o
>>   CC      scsi/pr-manager-helper.o
>>   CC      crypto/init.o
>>   CC      scsi/utils.o
>>   CC      crypto/hash.o
>>   CC      crypto/hash-nettle.o
>>   CC      crypto/hmac.o
>>   CC      crypto/hmac-nettle.o
>>   CC      crypto/aes.o
>>   CC      crypto/desrfb.o
>>   CC      crypto/tlscreds.o
>>   CC      crypto/cipher.o
>>   CC      crypto/tlscredsanon.o
>>   CC      crypto/tlscredsx509.o
>>   CC      crypto/tlssession.o
>>   CC      crypto/secret.o
>>   CC      crypto/random-platform.o
>>   CC      crypto/pbkdf.o
>>   CC      crypto/ivgen.o
>>   CC      crypto/pbkdf-nettle.o
>>   CC      crypto/ivgen-essiv.o
>>   CC      crypto/ivgen-plain.o
>>   CC      crypto/ivgen-plain64.o
>>   CC      crypto/afsplit.o
>>   CC      crypto/xts.o
>>   CC      crypto/block.o
>>   CC      crypto/block-qcow.o
>>   CC      crypto/block-luks.o
>>   CC      io/channel.o
>>   CC      io/channel-command.o
>>   CC      io/channel-buffer.o
>>   CC      io/channel-file.o
>>   CC      io/channel-socket.o
>>   CC      io/channel-tls.o
>>   CC      io/channel-watch.o
>>   CC      io/channel-websock.o
>>   CC      io/channel-util.o
>>   CC      io/dns-resolver.o
>>   CC      qom/object.o
>>   CC      qom/qom-qobject.o
>>   CC      qom/container.o
>>   CC      io/task.o
>>   CC      qom/object_interfaces.o
>>   GEN     qemu-img-cmds.h
>>   CC      qemu-io.o
>>   CC      scsi/qemu-pr-helper.o
>>   CC      qemu-bridge-helper.o
>>   CC      blockdev.o
>>   CC      blockdev-nbd.o
>>   CC      bootdevice.o
>>   CC      iothread.o
>>   CC      qdev-monitor.o
>>   CC      device-hotplug.o
>>   CC      os-posix.o
>>   CC      bt-host.o
>>   CC      bt-vhci.o
>>   CC      dma-helpers.o
>>   CC      vl.o
>>   CC      tpm.o
>>   CC      device_tree.o
>>   CC      qmp-marshal.o
>>   CC      qmp.o
>>   CC      hmp.o
>>   CC      cpus-common.o
>>   CC      audio/noaudio.o
>>   CC      audio/wavaudio.o
>>   CC      audio/audio.o
>>   CC      audio/mixeng.o
>>   CC      audio/sdlaudio.o
>>   CC      audio/ossaudio.o
>>   CC      audio/wavcapture.o
>>   CC      backends/rng.o
>>   CC      backends/rng-egd.o
>>   CC      backends/rng-random.o
>>   CC      backends/tpm.o
>>   CC      backends/hostmem.o
>>   CC      backends/hostmem-ram.o
>>   CC      backends/hostmem-file.o
>>   CC      backends/cryptodev.o
>>   CC      backends/cryptodev-builtin.o
>>   CC      block/stream.o
>>   CC      chardev/wctablet.o
>>   CC      chardev/msmouse.o
>>   CC      chardev/testdev.o
>>   CC      disas/i386.o
>>   CC      fsdev/qemu-fsdev-dummy.o
>>   CC      fsdev/qemu-fsdev-opts.o
>>   CC      fsdev/qemu-fsdev-throttle.o
>>   CC      hw/acpi/core.o
>>   CC      hw/acpi/piix4.o
>>   CC      hw/acpi/pcihp.o
>>   CC      hw/acpi/ich9.o
>>   CC      hw/acpi/tco.o
>>   CC      hw/acpi/cpu_hotplug.o
>>   CC      hw/acpi/memory_hotplug.o
>>   CC      hw/acpi/cpu.o
>>   CC      hw/acpi/nvdimm.o
>>   CC      hw/acpi/vmgenid.o
>>   CC      hw/acpi/acpi_interface.o
>>   CC      hw/acpi/bios-linker-loader.o
>>   CC      hw/acpi/aml-build.o
>>   CC      hw/acpi/ipmi.o
>>   CC      hw/acpi/acpi-stub.o
>>   CC      hw/audio/sb16.o
>>   CC      hw/acpi/ipmi-stub.o
>>   CC      hw/audio/es1370.o
>>   CC      hw/audio/ac97.o
>>   CC      hw/audio/fmopl.o
>>   CC      hw/audio/adlib.o
>>   CC      hw/audio/gus.o
>>   CC      hw/audio/gusemu_hal.o
>>   CC      hw/audio/gusemu_mixer.o
>>   CC      hw/audio/cs4231a.o
>>   CC      hw/audio/intel-hda.o
>>   CC      hw/audio/hda-codec.o
>>   CC      hw/audio/pcspk.o
>>   CC      hw/audio/soundhw.o
>>   CC      hw/block/block.o
>>   CC      hw/block/cdrom.o
>>   CC      hw/block/hd-geometry.o
>>   CC      hw/block/pflash_cfi01.o
>>   CC      hw/block/nvme.o
>>   CC      hw/block/fdc.o
>>   CC      hw/bt/core.o
>>   CC      hw/bt/l2cap.o
>>   CC      hw/bt/sdp.o
>>   CC      hw/bt/hci.o
>>   CC      hw/bt/hid.o
>>   CC      hw/bt/hci-csr.o
>>   CC      hw/char/ipoctal232.o
>>   CC      hw/char/parallel.o
>>   CC      hw/char/serial.o
>>   CC      hw/char/serial-isa.o
>>   CC      hw/char/serial-pci.o
>>   CC      hw/char/virtio-console.o
>>   CC      hw/char/debugcon.o
>>   CC      hw/core/qdev.o
>>   CC      hw/core/qdev-properties.o
>>   CC      hw/core/bus.o
>>   CC      hw/core/reset.o
>>   CC      hw/core/fw-path-provider.o
>>   CC      hw/core/irq.o
>>   CC      hw/core/hotplug.o
>>   CC      hw/core/nmi.o
>>   CC      hw/core/sysbus.o
>>   CC      hw/core/machine.o
>>   CC      hw/core/qdev-properties-system.o
>>   CC      hw/core/loader.o
>>   CC      hw/core/register.o
>>   CC      hw/cpu/core.o
>>   CC      hw/core/or-irq.o
>>   CC      hw/display/cirrus_vga.o
>>   CC      hw/display/vga-isa.o
>>   CC      hw/display/vga-pci.o
>>   CC      hw/display/vmware_vga.o
>>   CC      hw/dma/i8257.o
>>   CC      hw/i2c/core.o
>>   CC      hw/i2c/smbus.o
>>   CC      hw/i2c/smbus_eeprom.o
>>   CC      hw/i2c/smbus_ich9.o
>>   CC      hw/ide/core.o
>>   CC      hw/ide/qdev.o
>>   CC      hw/ide/atapi.o
>>   CC      hw/i2c/pm_smbus.o
>>   CC      hw/ide/pci.o
>>   CC      hw/ide/isa.o
>>   CC      hw/ide/piix.o
>>   CC      hw/ide/ich.o
>>   CC      hw/ide/ahci.o
>>   CC      hw/input/hid.o
>>   CC      hw/input/ps2.o
>>   CC      hw/input/pckbd.o
>>   CC      hw/input/vmmouse.o
>>   CC      hw/input/virtio-input.o
>>   CC      hw/input/virtio-input-hid.o
>>   CC      hw/input/virtio-input-host.o
>>   CC      hw/intc/i8259_common.o
>>   CC      hw/intc/i8259.o
>>   CC      hw/intc/ioapic_common.o
>>   CC      hw/ipack/ipack.o
>>   CC      hw/ipack/tpci200.o
>>   CC      hw/ipmi/ipmi.o
>>   CC      hw/intc/intc.o
>>   CC      hw/ipmi/ipmi_bmc_sim.o
>>   CC      hw/ipmi/ipmi_bmc_extern.o
>>   CC      hw/ipmi/isa_ipmi_kcs.o
>>   CC      hw/ipmi/isa_ipmi_bt.o
>>   CC      hw/isa/isa-bus.o
>>   CC      hw/isa/apm.o
>>   CC      hw/mem/pc-dimm.o
>>   CC      hw/mem/nvdimm.o
>>   CC      hw/misc/applesmc.o
>>   CC      hw/misc/debugexit.o
>>   CC      hw/misc/sga.o
>>   CC      hw/misc/pc-testdev.o
>>   CC      hw/misc/pci-testdev.o
>>   CC      hw/misc/edu.o
>>   CC      hw/misc/unimp.o
>>   CC      hw/misc/vmcoreinfo.o
>>   CC      hw/net/ne2000.o
>>   CC      hw/net/eepro100.o
>>   CC      hw/net/pcnet-pci.o
>>   CC      hw/net/pcnet.o
>>   CC      hw/net/e1000.o
>>   CC      hw/net/e1000x_common.o
>>   CC      hw/net/net_tx_pkt.o
>>   CC      hw/net/e1000e.o
>>   CC      hw/net/e1000e_core.o
>>   CC      hw/net/rtl8139.o
>>   CC      hw/net/net_rx_pkt.o
>>   CC      hw/net/vmxnet3.o
>>   CC      hw/net/ne2000-isa.o
>>   CC      hw/net/rocker/rocker.o
>>   CC      hw/net/rocker/rocker_fp.o
>>   CC      hw/net/rocker/rocker_desc.o
>>   CC      hw/net/rocker/rocker_world.o
>>   CC      hw/net/rocker/rocker_of_dpa.o
>>   CC      hw/nvram/eeprom93xx.o
>>   CC      hw/nvram/fw_cfg.o
>>   CC      hw/nvram/chrp_nvram.o
>>   CC      hw/pci-bridge/pci_bridge_dev.o
>>   CC      hw/pci-bridge/pcie_root_port.o
>>   CC      hw/pci-bridge/gen_pcie_root_port.o
>>   CC      hw/pci-bridge/pcie_pci_bridge.o
>>   CC      hw/pci-bridge/pci_expander_bridge.o
>>   CC      hw/pci-bridge/xio3130_upstream.o
>>   CC      hw/pci-bridge/xio3130_downstream.o
>>   CC      hw/pci-bridge/i82801b11.o
>>   CC      hw/pci-bridge/ioh3420.o
>>   CC      hw/pci-host/pam.o
>>   CC      hw/pci-host/piix.o
>>   CC      hw/pci-host/q35.o
>>   CC      hw/pci/pci.o
>>   CC      hw/pci/pci_bridge.o
>>   CC      hw/pci/msix.o
>>   CC      hw/pci/shpc.o
>>   CC      hw/pci/msi.o
>>   CC      hw/pci/slotid_cap.o
>>   CC      hw/pci/pci_host.o
>>   CC      hw/pci/pcie.o
>>   CC      hw/pci/pcie_aer.o
>>   CC      hw/pci/pcie_host.o
>>   CC      hw/pci/pcie_port.o
>>   CC      hw/pci/pci-stub.o
>>   CC      hw/pcmcia/pcmcia.o
>>   CC      hw/scsi/scsi-disk.o
>>   CC      hw/scsi/scsi-generic.o
>>   CC      hw/scsi/scsi-bus.o
>>   CC      hw/scsi/lsi53c895a.o
>>   CC      hw/scsi/mptsas.o
>>   CC      hw/scsi/mptconfig.o
>>   CC      hw/scsi/mptendian.o
>>   CC      hw/scsi/megasas.o
>>   CC      hw/scsi/vmw_pvscsi.o
>>   CC      hw/scsi/esp.o
>>   CC      hw/scsi/esp-pci.o
>>   CC      hw/sd/sd.o
>>   CC      hw/sd/core.o
>>   CC      hw/sd/sdhci.o
>>   CC      hw/smbios/smbios.o
>>   CC      hw/smbios/smbios_type_38.o
>>   CC      hw/smbios/smbios-stub.o
>>   CC      hw/smbios/smbios_type_38-stub.o
>>   CC      hw/timer/hpet.o
>>   CC      hw/timer/i8254_common.o
>>   CC      hw/timer/i8254.o
>>   CC      hw/tpm/tpm_tis.o
>>   CC      hw/tpm/tpm_passthrough.o
>>   CC      hw/tpm/tpm_util.o
>>   CC      hw/tpm/tpm_emulator.o
>>   CC      hw/usb/core.o
>>   CC      hw/usb/combined-packet.o
>>   CC      hw/usb/bus.o
>>   CC      hw/usb/libhw.o
>>   CC      hw/usb/desc.o
>>   CC      hw/usb/desc-msos.o
>>   CC      hw/usb/hcd-uhci.o
>>   CC      hw/usb/hcd-ohci.o
>>   CC      hw/usb/hcd-ehci.o
>>   CC      hw/usb/hcd-ehci-pci.o
>>   CC      hw/usb/hcd-xhci.o
>>   CC      hw/usb/hcd-xhci-nec.o
>>   CC      hw/usb/dev-hub.o
>>   CC      hw/usb/dev-wacom.o
>>   CC      hw/usb/dev-hid.o
>>   CC      hw/usb/dev-storage.o
>>   CC      hw/usb/dev-uas.o
>>   CC      hw/usb/dev-audio.o
>>   CC      hw/usb/dev-serial.o
>>   CC      hw/usb/dev-network.o
>>   CC      hw/usb/dev-smartcard-reader.o
>>   CC      hw/usb/dev-bluetooth.o
>>   CC      hw/usb/dev-mtp.o
>>   CC      hw/usb/host-stub.o
>>   CC      hw/virtio/virtio-rng.o
>>   CC      hw/virtio/virtio-pci.o
>>   CC      hw/virtio/virtio-bus.o
>>   CC      hw/virtio/virtio-mmio.o
>>   CC      hw/virtio/vhost-stub.o
>>   CC      hw/watchdog/watchdog.o
>>   CC      hw/watchdog/wdt_i6300esb.o
>>   CC      hw/watchdog/wdt_ib700.o
>>   CC      migration/migration.o
>>   CC      migration/socket.o
>>   CC      migration/exec.o
>>   CC      migration/tls.o
>>   CC      migration/fd.o
>>   CC      migration/channel.o
>>   CC      migration/colo-comm.o
>>   CC      migration/colo.o
>>   CC      migration/savevm.o
>>   CC      migration/colo-failover.o
>>   CC      migration/vmstate.o
>>   CC      migration/vmstate-types.o
>>   CC      migration/page_cache.o
>>   CC      migration/qemu-file.o
>>   CC      migration/global_state.o
>>   CC      migration/qemu-file-channel.o
>>   CC      migration/xbzrle.o
>>   CC      migration/postcopy-ram.o
>>   CC      migration/block.o
>>   CC      migration/qjson.o
>>   CC      net/net.o
>>   CC      net/queue.o
>>   CC      net/checksum.o
>>   CC      net/util.o
>>   CC      net/hub.o
>>   CC      net/socket.o
>>   CC      net/dump.o
>>   CC      net/eth.o
>>   CC      net/l2tpv3.o
>>   CC      net/slirp.o
>>   CC      net/vhost-user.o
>>   CC      net/filter.o
>>   CC      net/filter-buffer.o
>>   CC      net/filter-mirror.o
>>   CC      net/colo-compare.o
>>   CC      net/filter-rewriter.o
>>   CC      net/colo.o
>>   CC      net/filter-replay.o
>>   CC      net/tap.o
>>   CC      net/tap-linux.o
>>   CC      qom/cpu.o
>>   CC      replay/replay.o
>>   CC      replay/replay-internal.o
>>   CC      replay/replay-events.o
>>   CC      replay/replay-time.o
>>   CC      replay/replay-input.o
>>   CC      replay/replay-char.o
>>   CC      replay/replay-snapshot.o
>>   CC      replay/replay-audio.o
>>   CC      slirp/cksum.o
>>   CC      replay/replay-net.o
>>   CC      slirp/if.o
>>   CC      slirp/ip6_icmp.o
>>   CC      slirp/ip6_input.o
>>   CC      slirp/ip_icmp.o
>>   CC      slirp/ip6_output.o
>>   CC      slirp/ip_input.o
>>   CC      slirp/ip_output.o
>>   CC      slirp/dnssearch.o
>>   CC      slirp/dhcpv6.o
>>   CC      slirp/slirp.o
>>   CC      slirp/mbuf.o
>>   CC      slirp/misc.o
>>   CC      slirp/sbuf.o
>>   CC      slirp/socket.o
>>   CC      slirp/tcp_output.o
>>   CC      slirp/tcp_input.o
>>   CC      slirp/tcp_subr.o
>>   CC      slirp/tcp_timer.o
>>   CC      slirp/udp.o
>>   CC      slirp/udp6.o
>>   CC      slirp/bootp.o
>>   CC      slirp/tftp.o
>>   CC      slirp/arp_table.o
>>   CC      slirp/ndp_table.o
>>   CC      slirp/ncsi.o
>>   CC      ui/console.o
>>   CC      ui/keymaps.o
>>   CC      ui/cursor.o
>>   CC      ui/qemu-pixman.o
>>   CC      ui/input.o
>>   CC      ui/input-keymap.o
>>   CC      ui/input-legacy.o
>>   CC      ui/input-linux.o
>>   CC      ui/sdl.o
>>   CC      ui/sdl_zoom.o
>>   CC      ui/x_keymap.o
>>   CC      ui/vnc.o
>>   CC      ui/vnc-enc-zlib.o
>>   CC      ui/vnc-enc-hextile.o
>>   CC      ui/vnc-enc-tight.o
>>   CC      ui/vnc-palette.o
>>   CC      ui/vnc-enc-zrle.o
>>   CC      ui/vnc-auth-vencrypt.o
>>   CC      ui/vnc-ws.o
>>   CC      chardev/char.o
>>   CC      chardev/char-fd.o
>>   CC      ui/vnc-jobs.o
>>   CC      chardev/char-fe.o
>>   CC      chardev/char-file.o
>>   CC      chardev/char-io.o
>>   CC      chardev/char-mux.o
>>   CC      chardev/char-null.o
>>   CC      chardev/char-parallel.o
>>   CC      chardev/char-pipe.o
>>   CC      chardev/char-pty.o
>>   CC      chardev/char-ringbuf.o
>>   CC      chardev/char-serial.o
>>   CC      chardev/char-stdio.o
>>   CC      chardev/char-socket.o
>>   CC      chardev/char-udp.o
>>   LINK    tests/qemu-iotests/socket_scm_helper
>>   CC      qga/commands.o
>>   CC      qga/guest-agent-command-state.o
>>   CC      qga/main.o
>>   CC      qga/commands-posix.o
>>   CC      qga/channel-posix.o
>>   CC      qga/qapi-generated/qga-qapi-types.o
>>   AS      optionrom/multiboot.o
>>   AS      optionrom/linuxboot.o
>>   CC      optionrom/linuxboot_dma.o
>>   AS      optionrom/kvmvapic.o
>>   CC      qga/qapi-generated/qga-qapi-visit.o
>>   BUILD   optionrom/multiboot.img
>>   BUILD   optionrom/linuxboot_dma.img
>>   BUILD   optionrom/linuxboot.img
>>   BUILD   optionrom/multiboot.raw
>>   BUILD   optionrom/kvmvapic.img
>>   BUILD   optionrom/linuxboot.raw
>>   BUILD   optionrom/linuxboot_dma.raw
>>   BUILD   optionrom/kvmvapic.raw
>>   CC      qga/qapi-generated/qga-qmp-marshal.o
>>   SIGN    optionrom/multiboot.bin
>>   SIGN    optionrom/linuxboot_dma.bin
>>   SIGN    optionrom/linuxboot.bin
>>   SIGN    optionrom/kvmvapic.bin
>>   AR      libqemuutil.a
>>   CC      qemu-img.o
>>   LINK    ivshmem-client
>>   LINK    ivshmem-server
>>   LINK    qemu-nbd
>>   LINK    qemu-img
>>   LINK    qemu-io
>>   LINK    scsi/qemu-pr-helper
>>   LINK    qemu-bridge-helper
>>   LINK    qemu-ga
>>   GEN     x86_64-softmmu/hmp-commands.h
>>   GEN     x86_64-softmmu/hmp-commands-info.h
>>   GEN     x86_64-softmmu/config-target.h
>>   CC      x86_64-softmmu/tcg/tcg.o
>>   CC      x86_64-softmmu/exec.o
>>   CC      x86_64-softmmu/tcg/tcg-op.o
>>   CC      x86_64-softmmu/tcg/optimize.o
>>   CC      x86_64-softmmu/tcg/tcg-common.o
>>   CC      x86_64-softmmu/fpu/softfloat.o
>>   CC      x86_64-softmmu/disas.o
>>   GEN     x86_64-softmmu/gdbstub-xml.c
>>   CC      x86_64-softmmu/arch_init.o
>>   CC      x86_64-softmmu/cpus.o
>>   CC      x86_64-softmmu/monitor.o
>>   CC      x86_64-softmmu/gdbstub.o
>>   CC      x86_64-softmmu/balloon.o
>>   CC      x86_64-softmmu/ioport.o
>>   CC      x86_64-softmmu/numa.o
>>   CC      x86_64-softmmu/qtest.o
>>   CC      x86_64-softmmu/memory.o
>>   CC      x86_64-softmmu/memory_mapping.o
>>   CC      x86_64-softmmu/dump.o
>>   CC      x86_64-softmmu/migration/ram.o
>>   CC      x86_64-softmmu/accel/accel.o
>>   CC      x86_64-softmmu/accel/stubs/hax-stub.o
>>   CC      x86_64-softmmu/accel/kvm/kvm-all.o
>>   CC      x86_64-softmmu/accel/tcg/tcg-all.o
>>   CC      x86_64-softmmu/accel/tcg/cputlb.o
>>   CC      x86_64-softmmu/accel/tcg/cpu-exec.o
>>   CC      x86_64-softmmu/accel/tcg/tcg-runtime.o
>>   CC      x86_64-softmmu/accel/tcg/cpu-exec-common.o
>>   CC      x86_64-softmmu/accel/tcg/translate-all.o
>>   CC      x86_64-softmmu/hw/block/virtio-blk.o
>>   CC      x86_64-softmmu/accel/tcg/translator.o
>>   CC      x86_64-softmmu/hw/block/dataplane/virtio-blk.o
>>   CC      x86_64-softmmu/hw/char/virtio-serial-bus.o
>>   CC      x86_64-softmmu/hw/core/generic-loader.o
>>   CC      x86_64-softmmu/hw/core/null-machine.o
>>   CC      x86_64-softmmu/hw/display/vga.o
>>   CC      x86_64-softmmu/hw/display/virtio-gpu.o
>>   CC      x86_64-softmmu/hw/display/virtio-gpu-3d.o
>>   CC      x86_64-softmmu/hw/display/virtio-gpu-pci.o
>>   CC      x86_64-softmmu/hw/intc/apic.o
>>   CC      x86_64-softmmu/hw/display/virtio-vga.o
>>   CC      x86_64-softmmu/hw/intc/apic_common.o
>>   CC      x86_64-softmmu/hw/intc/ioapic.o
>>   CC      x86_64-softmmu/hw/isa/lpc_ich9.o
>>   CC      x86_64-softmmu/hw/misc/vmport.o
>>   CC      x86_64-softmmu/hw/misc/pvpanic.o
>>   CC      x86_64-softmmu/hw/misc/ivshmem.o
>>   CC      x86_64-softmmu/hw/misc/hyperv_testdev.o
>>   CC      x86_64-softmmu/hw/misc/mmio_interface.o
>>   CC      x86_64-softmmu/hw/net/virtio-net.o
>>   CC      x86_64-softmmu/hw/net/vhost_net.o
>>   CC      x86_64-softmmu/hw/scsi/virtio-scsi.o
>>   CC      x86_64-softmmu/hw/scsi/virtio-scsi-dataplane.o
>>   CC      x86_64-softmmu/hw/scsi/vhost-scsi.o
>>   CC      x86_64-softmmu/hw/scsi/vhost-scsi-common.o
>>   CC      x86_64-softmmu/hw/timer/mc146818rtc.o
>>   CC      x86_64-softmmu/hw/scsi/vhost-user-scsi.o
>>   CC      x86_64-softmmu/hw/vfio/pci.o
>>   CC      x86_64-softmmu/hw/vfio/common.o
>>   CC      x86_64-softmmu/hw/vfio/pci-quirks.o
>>   CC      x86_64-softmmu/hw/vfio/platform.o
>>   CC      x86_64-softmmu/hw/vfio/spapr.o
>>   CC      x86_64-softmmu/hw/virtio/virtio.o
>>   CC      x86_64-softmmu/hw/virtio/virtio-balloon.o
>>   CC      x86_64-softmmu/hw/virtio/vhost.o
>>   CC      x86_64-softmmu/hw/virtio/vhost-user.o
>>   CC      x86_64-softmmu/hw/virtio/vhost-backend.o
>>   CC      x86_64-softmmu/hw/virtio/vhost-vsock.o
>>   CC      x86_64-softmmu/hw/virtio/virtio-crypto-pci.o
>>   CC      x86_64-softmmu/hw/virtio/virtio-crypto.o
>>   CC      x86_64-softmmu/hw/i386/multiboot.o
>>   CC      x86_64-softmmu/hw/i386/pc.o
>>   CC      x86_64-softmmu/hw/i386/pc_piix.o
>>   CC      x86_64-softmmu/hw/i386/pc_sysfw.o
>>   CC      x86_64-softmmu/hw/i386/pc_q35.o
>>   CC      x86_64-softmmu/hw/i386/x86-iommu.o
>>   CC      x86_64-softmmu/hw/i386/intel_iommu.o
>>   CC      x86_64-softmmu/hw/i386/amd_iommu.o
>>   CC      x86_64-softmmu/hw/i386/kvmvapic.o
>>   CC      x86_64-softmmu/hw/i386/acpi-build.o
>>   CC      x86_64-softmmu/hw/i386/kvm/clock.o
>>   CC      x86_64-softmmu/hw/i386/kvm/i8259.o
>>   CC      x86_64-softmmu/hw/i386/kvm/apic.o
>>   CC      x86_64-softmmu/hw/i386/kvm/ioapic.o
>>   CC      x86_64-softmmu/hw/i386/kvm/i8254.o
>>   CC      x86_64-softmmu/target/i386/helper.o
>>   CC      x86_64-softmmu/target/i386/cpu.o
>>   CC      x86_64-softmmu/target/i386/gdbstub.o
>>   CC      x86_64-softmmu/target/i386/xsave_helper.o
>>   CC      x86_64-softmmu/target/i386/bpt_helper.o
>>   CC      x86_64-softmmu/target/i386/cc_helper.o
>>   CC      x86_64-softmmu/target/i386/translate.o
>>   CC      x86_64-softmmu/target/i386/excp_helper.o
>>   CC      x86_64-softmmu/target/i386/fpu_helper.o
>>   CC      x86_64-softmmu/target/i386/int_helper.o
>>   CC      x86_64-softmmu/target/i386/mem_helper.o
>>   CC      x86_64-softmmu/target/i386/misc_helper.o
>>   CC      x86_64-softmmu/target/i386/mpx_helper.o
>>   CC      x86_64-softmmu/target/i386/seg_helper.o
>>   CC      x86_64-softmmu/target/i386/smm_helper.o
>>   CC      x86_64-softmmu/target/i386/svm_helper.o
>>   CC      x86_64-softmmu/target/i386/machine.o
>>   CC      x86_64-softmmu/target/i386/arch_memory_mapping.o
>>   CC      x86_64-softmmu/target/i386/arch_dump.o
>>   CC      x86_64-softmmu/target/i386/monitor.o
>>   CC      x86_64-softmmu/target/i386/kvm.o
>>   CC      x86_64-softmmu/target/i386/hyperv.o
>>   CC      x86_64-softmmu/trace/control-target.o
>>   GEN     trace/generated-helpers.c
>>   CC      x86_64-softmmu/gdbstub-xml.o
>>   CC      x86_64-softmmu/trace/generated-helpers.o
>>   LINK    x86_64-softmmu/qemu-system-x86_64
>> QEMU          -- "/tmp/qemu-test/build/x86_64-softmmu/qemu-system-x86_64=
"
>> -nodefaults -machine accel=3Dqtest
>> QEMU_IMG      -- "/tmp/qemu-test/build/qemu-img"
>> QEMU_IO       -- "/tmp/qemu-test/build/qemu-io"  --cache writeback -f ra=
w
>> QEMU_NBD      -- "/tmp/qemu-test/build/qemu-nbd"
>> IMGFMT        -- raw
>> IMGPROTO      -- file
>> PLATFORM      -- Linux/x86_64 cbbc6bacf475 4.11.10-300.fc26.x86_64
>> TEST_DIR      -- /tmp/qemu-test
>> SOCKET_SCM_HELPER --
>> /tmp/qemu-test/build/tests/qemu-iotests/socket_scm_helper
>>
>> 001
>> 002
>> 004
>> 005
>> 008
>> 009
>> 010
>> 011
>> 012
>> 017         [not run] not suitable for this image format: raw
>> 018         [not run] not suitable for this image format: raw
>> 019         [not run] not suitable for this image format: raw
>> 020         [not run] not suitable for this image format: raw
>> 021
>> 024         [not run] not suitable for this image format: raw
>> 025
>> 027         [not run] not suitable for this image format: raw
>> 028         [not run] not suitable for this image format: raw
>> 029         [not run] not suitable for this image format: raw
>> 031         [not run] not suitable for this image format: raw
>> 032
>> 033
>> 034         [not run] not suitable for this image format: raw
>> 035         [not run] not suitable for this image format: raw
>> 036         [not run] not suitable for this image format: raw
>> 037         [not run] not suitable for this image format: raw
>> 038         [not run] not suitable for this image format: raw
>> 039         [not run] not suitable for this image format: raw
>> 042         [not run] not suitable for this image format: raw
>> 045
>> 046         [not run] not suitable for this image format: raw
>> 047         [not run] not suitable for this image format: raw
>> 048
>> 050         [not run] not suitable for this image format: raw
>> 052
>> 053         [not run] not suitable for this image format: raw
>> 054         [not run] not suitable for this image format: raw
>> 058         [not run] not suitable for this image format: raw
>> 059         [not run] not suitable for this image format: raw
>> 060         [not run] not suitable for this image format: raw
>> 062         [not run] not suitable for this image format: raw
>> 063
>> 064         [not run] not suitable for this image format: raw
>> 065         [not run] not suitable for this image format: raw
>> 066         [not run] not suitable for this image format: raw
>> 067         [not run] not suitable for this image format: raw
>> 068         [not run] not suitable for this image format: raw
>> 069         [not run] not suitable for this image format: raw
>> 070         [not run] not suitable for this image format: raw
>> 071         [not run] not suitable for this image format: raw
>> 072         [not run] not suitable for this image format: raw
>> 073         [not run] not suitable for this image format: raw
>> 074         [not run] not suitable for this image format: raw
>> 075         [not run] not suitable for this image format: raw
>> 077
>> 078         [not run] not suitable for this image format: raw
>> 081
>> 082         [not run] not suitable for this image format: raw
>> 084         [not run] not suitable for this image format: raw
>> 086
>> 087         [not run] not suitable for this image format: raw
>> 088         [not run] not suitable for this image format: raw
>> 089         [not run] not suitable for this image format: raw
>> 090         [not run] not suitable for this image format: raw
>> 092         [not run] not suitable for this image format: raw
>> 094         [not run] not suitable for this image protocol: file
>> 095         [not run] not suitable for this image format: raw
>> 096         [not run] not suitable for this image format: raw
>> 098         [not run] not suitable for this image format: raw
>> 099         [not run] not suitable for this image format: raw
>> 101
>> 102         [not run] not suitable for this image format: raw
>> 103         [not run] not suitable for this image format: raw
>> 105         [not run] not suitable for this image format: raw
>> 106
>> 107         [not run] not suitable for this image format: raw
>> 108         [not run] not suitable for this image format: raw
>> 110         [not run] not suitable for this image format: raw
>> 111         [not run] not suitable for this image format: raw
>> 113         [not run] not suitable for this image format: raw
>> 114         [not run] not suitable for this image format: raw
>> 116         [not run] not suitable for this image format: raw
>> 119         [not run] not suitable for this image protocol: file
>> 120
>> 123         [not run] not suitable for this image protocol: file
>> 127         [not run] not suitable for this image format: raw
>> 128         [not run] root privileges required to run dmsetup
>> 129         [not run] not suitable for this image format: raw
>> 130         [not run] not suitable for this image format: raw
>> 131         [not run] not suitable for this image format: raw
>> 132
>> 133         [not run] not suitable for this image format: raw
>> 134         [not run] not suitable for this image format: raw
>> 138         [not run] not suitable for this image format: raw
>> 139         [not run] not suitable for this image format: raw
>> 140
>> 141         [not run] not suitable for this image format: raw
>> 143
>> 144         [not run] not suitable for this image format: raw
>> 145
>> 146         [not run] not suitable for this image format: raw
>> 148
>> 150
>> 152
>> 153         [not run] not suitable for this image format: raw
>> 154         [not run] not suitable for this image format: raw
>> 156         [not run] not suitable for this image format: raw
>> 158         [not run] not suitable for this image format: raw
>> 159
>> 160
>> 162         [not run] ssh support required
>> 163
>> 165         [not run] not suitable for this image format: raw
>> 170
>> 171
>> 175
>> 177         [not run] not suitable for this image format: raw
>> 179         [not run] not suitable for this image format: raw
>> 182         [not run] not suitable for this image format: raw
>> 184         [not run] not suitable for this image format: raw
>> 188         [not run] not suitable for this image format: raw
>> 190         [not run] not suitable for this image format: raw
>> 192
>> 194
>> 195         [not run] not suitable for this image format: raw
>> 196         [not run] not suitable for this image format: raw
>> 197         [not run] Insufficent memory to run test
>> Not run: 017 018 019 020 024 027 028 029 031 034 035 036 037 038 039 042
>> 046 047 050 053 054 058 059 060 062 064 065 066 067 068 069 070 071 072 =
073
>> 074 075 078 082 084 087 088 089 090 092 094 095 096 098 099 102 103 105 =
107
>> 108 110 111 113 114 116 119 123 127 128 129 130 131 133 134 138 139 141 =
144
>> 146 153 154 156 158 162 165 177 179 182 184 188 190 195 196 197
>> Passed all 38 tests
>> QEMU          -- "/tmp/qemu-test/build/x86_64-softmmu/qemu-system-x86_64=
"
>> -nodefaults -machine accel=3Dqtest
>> QEMU_IMG      -- "/tmp/qemu-test/build/qemu-img"
>> QEMU_IO       -- "/tmp/qemu-test/build/qemu-io"  --cache writeback -f
>> qcow2
>> QEMU_NBD      -- "/tmp/qemu-test/build/qemu-nbd"
>> IMGFMT        -- qcow2 (compat=3D1.1)
>> IMGPROTO      -- file
>> PLATFORM      -- Linux/x86_64 cbbc6bacf475 4.11.10-300.fc26.x86_64
>> TEST_DIR      -- /tmp/qemu-test
>> SOCKET_SCM_HELPER --
>> /tmp/qemu-test/build/tests/qemu-iotests/socket_scm_helper
>>
>> 001
>> 002
>> 004
>> 005
>> 008
>> 009
>> 010
>> 011
>> 012
>> 017
>> 018
>> 019
>> 020
>> 021
>> 024
>> 025
>> 027
>> 028
>> 029
>> 031
>> 032
>> 033
>> 034
>> 035
>> 036
>> 037
>> 038
>> 039
>> 042
>> 045         [not run] not suitable for this image format: qcow2
>> 046
>> 047
>> 048
>> 050
>> 052
>> 053
>> 054
>> 058
>> 059         [not run] not suitable for this image format: qcow2
>> 060
>> 062
>> 063
>> 064         [not run] not suitable for this image format: qcow2
>> 065
>> 066
>> 067
>> 068
>> 069
>> 070         [not run] not suitable for this image format: qcow2
>> 071
>> 072
>> 073
>> 074
>> 075         [not run] not suitable for this image format: qcow2
>> 077         [not run] not suitable for this image format: qcow2
>> 078         [not run] not suitable for this image format: qcow2
>> 081         [not run] not suitable for this image format: qcow2
>> 082
>> 084         [not run] not suitable for this image format: qcow2
>> 086
>> 087
>> 088         [not run] not suitable for this image format: qcow2
>> 089
>> 090
>> 092         [not run] not suitable for this image format: qcow2
>> 094         [not run] not suitable for this image protocol: file
>> 095
>> 096
>> 098         - output mismatch (see 098.out.bad)
>> --- /tmp/qemu-test/src/tests/qemu-iotests/098.out       2017-11-21
>> 22:09:10.000000000 +0000
>> +++ /tmp/qemu-test/build/tests/qemu-iotests/098.out.bad 2017-11-21
>> 22:15:08.283211077 +0000
>> @@ -6,7 +6,8 @@
>>  Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
>> backing_file=3DTEST_DIR/t.IMGFMT.base
>>  wrote 65536/65536 bytes at offset 0
>>  64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> -qemu-img: Could not empty
>> blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.IMGFMT: Input/output error
>> +qemu-img: TEST_DIR/src/block/block-backend.c:2088: blk_root_drained_end=
:
>> Assertion `blk->quiesce_counter' failed.
>> +./common.rc: line 61: 21522 Aborted                 (core dumped) ( exe=
c
>> "$QEMU_IMG_PROG" $QEMU_IMG_OPTIONS "$@" )
>>  No errors were found on the image.
>>
>>  =3D=3D=3D empty_image_prepare =3D=3D=3D
>> @@ -28,12 +29,8 @@
>>  Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
>> backing_file=3DTEST_DIR/t.IMGFMT.base
>>  wrote 65536/65536 bytes at offset 0
>>  64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> -qemu-img: Could not empty
>> blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.IMGFMT: Input/output error
>> -ERROR cluster 0 refcount=3D0 reference=3D1
>> -ERROR cluster 1 refcount=3D0 reference=3D1
>> -ERROR cluster 3 refcount=3D0 reference=3D1
>> -Rebuilding refcount structure
>> -Repairing cluster 1 refcount=3D1 reference=3D0
>> +qemu-img: TEST_DIR/src/block/block-backend.c:2088: blk_root_drained_end=
:
>> Assertion `blk->quiesce_counter' failed.
>> +./common.rc: line 61: 21599 Aborted                 (core dumped) ( exe=
c
>> "$QEMU_IMG_PROG" $QEMU_IMG_OPTIONS "$@" )
>>  No errors were found on the image.
>>
>>  =3D=3D=3D refblock_alloc =3D=3D=3D
>> @@ -42,11 +39,7 @@
>>  Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
>> backing_file=3DTEST_DIR/t.IMGFMT.base
>>  wrote 65536/65536 bytes at offset 0
>>  64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> -qemu-img: Could not empty
>> blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.IMGFMT: Input/output error
>> -ERROR cluster 0 refcount=3D0 reference=3D1
>> -ERROR cluster 1 refcount=3D0 reference=3D1
>> -ERROR cluster 3 refcount=3D0 reference=3D1
>> -Rebuilding refcount structure
>> -Repairing cluster 1 refcount=3D1 reference=3D0
>> +qemu-img: TEST_DIR/src/block/block-backend.c:2088: blk_root_drained_end=
:
>> Assertion `blk->quiesce_counter' failed.
>> +./common.rc: line 61: 21636 Aborted                 (core dumped) ( exe=
c
>> "$QEMU_IMG_PROG" $QEMU_IMG_OPTIONS "$@" )
>>  No errors were found on the image.
>>  *** done
>> 099
>> 101         [not run] not suitable for this image format: qcow2
>> 102
>> 103
>> 105
>> 106         [not run] not suitable for this image format: qcow2
>> 107
>> 108
>> 110
>> 111
>> 113         [not run] not suitable for this image format: qcow2
>> 114
>> 116         [not run] not suitable for this image format: qcow2
>> 119         [not run] not suitable for this image format: qcow2
>> 120
>> 123         [not run] not suitable for this image format: qcow2
>> 127
>> 128         [not run] not suitable for this image format: qcow2
>> 129
>> 130
>> 131         [not run] not suitable for this image format: qcow2
>> 132
>> 133
>> 134
>> 138
>> 139
>> 140
>> 141         [failed, exit status 1] - output mismatch (see 141.out.bad)
>> --- /tmp/qemu-test/src/tests/qemu-iotests/141.out       2017-11-21
>> 22:09:10.000000000 +0000
>> +++ /tmp/qemu-test/build/tests/qemu-iotests/141.out.bad 2017-11-21
>> 22:15:53.808342431 +0000
>> @@ -43,17 +43,4 @@
>>  {"return": {}}
>>  {"error": {"class": "GenericError", "desc": "Node drv0 is in use"}}
>>  {"return": {}}
>> -{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP},
>> "event": "BLOCK_JOB_CANCELLED", "data": {"device": "job0", "len": 104857=
6,
>> "offset": 524288, "speed": 1, "type": "commit"}}
>> -{"return": {}}
>> -
>> -=3D=3D=3D Testing block-stream =3D=3D=3D
>> -
>> -wrote 1048576/1048576 bytes at offset 0
>> -1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> -{"return": {}}
>> -{"return": {}}
>> -{"error": {"class": "GenericError", "desc": "Node drv0 is in use"}}
>> -{"return": {}}
>> -{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP},
>> "event": "BLOCK_JOB_CANCELLED", "data": {"device": "job0", "len": 104857=
6,
>> "offset": 524288, "speed": 1, "type": "stream"}}
>> -{"return": {}}
>> -*** done
>> +Timeout waiting for BLOCK_JOB_CANCELLED on handle 0
>> 143
>> 144
>> 145
>> 146         [not run] not suitable for this image format: qcow2
>> 148         [not run] not suitable for this image format: qcow2
>> 150
>> 152
>> 153         - output mismatch (see 153.out.bad)
>> --- /tmp/qemu-test/src/tests/qemu-iotests/153.out       2017-11-21
>> 22:09:10.000000000 +0000
>> +++ /tmp/qemu-test/build/tests/qemu-iotests/153.out.bad 2017-11-21
>> 22:16:05.162874016 +0000
>> @@ -294,6 +294,8 @@
>>  _qemu_img_wrapper amend -o  TEST_DIR/t.qcow2
>>
>>  _qemu_img_wrapper commit TEST_DIR/t.qcow2
>> +qemu-img: TEST_DIR/src/block/block-backend.c:2088: blk_root_drained_end=
:
>> Assertion `blk->quiesce_counter' failed.
>> +./common.rc: line 61: 25478 Aborted                 (core dumped) ( exe=
c
>> "$QEMU_IMG_PROG" $QEMU_IMG_OPTIONS "$@" )
>>
>>  _qemu_img_wrapper resize TEST_DIR/t.qcow2 32M
>>
>> 154
>> 156
>> 158
>> 159
>> 160         [not run] not suitable for this image format: qcow2
>> 162         [not run] ssh support required
>> 163
>> 165
>> 170
>> 171         [not run] not suitable for this image format: qcow2
>> 175         [not run] not suitable for this image format: qcow2
>> 177
>> 179
>> 182
>> 184
>> 188
>> 190
>> 192
>> 194
>> 195
>> 196
>> 197         [not run] Insufficent memory to run test
>> Not run: 045 059 064 070 075 077 078 081 084 088 092 094 101 106 113 116
>> 119 123 128 131 146 148 160 162 171 175 197
>> Failures: 098 141 153
>> Failed 3 of 100 tests
>> Test failed: iotests qcow2
>> Traceback (most recent call last):
>>   File "./tests/docker/docker.py", line 407, in <module>
>>     sys.exit(main())
>>   File "./tests/docker/docker.py", line 404, in main
>>     return args.cmdobj.run(args, argv)
>>   File "./tests/docker/docker.py", line 261, in run
>>     return Docker().run(argv, args.keep, quiet=3Dargs.quiet)
>>   File "./tests/docker/docker.py", line 229, in run
>>     quiet=3Dquiet)
>>   File "./tests/docker/docker.py", line 147, in _do_check
>>     return subprocess.check_call(self._command + cmd, **kwargs)
>>   File "/usr/lib64/python2.7/subprocess.py", line 186, in check_call
>>     raise CalledProcessError(retcode, cmd)
>> subprocess.CalledProcessError: Command '['docker', 'run', '--label',
>> 'com.qemu.instance.uuid=3D9cf1750ecf0811e7bab152540069c830', '-u', '0',
>> '--security-opt', 'seccomp=3Dunconfined', '--rm', '--net=3Dnone', '-e',
>> 'TARGET_LIST=3D', '-e', 'EXTRA_CONFIGURE_OPTS=3D', '-e', 'V=3D', '-e', '=
J=3D8',
>> '-e', 'DEBUG=3D', '-e', 'SHOW_ENV=3D1', '-e', 'CCACHE_DIR=3D/var/tmp/cca=
che',
>> '-v', '/root/.cache/qemu-docker-ccache:/var/tmp/ccache:z', '-v',
>> '/var/tmp/patchew-tester-tmp-gmdmoybf/src/docker-src.2017-11-21-17.09.06=
.20869:/var/tmp/qemu:z,ro',
>> 'qemu:fedora', '/var/tmp/qemu/run', 'test-block']' returned non-zero exi=
t
>> status 1
>> make[1]: *** [tests/docker/Makefile.include:129: docker-run] Error 1
>> make[1]: Leaving directory '/var/tmp/patchew-tester-tmp-gmdmoybf/src'
>> make: *** [tests/docker/Makefile.include:163:
>> docker-run-test-block@fedora] Error 2
>>
>> real    9m31.801s
>> user    0m4.669s
>> sys     0m4.689s
>> =3D=3D=3D OUTPUT END =3D=3D=3D
>>
>> Test command exited with code: 2
>>
>>
>> ---
>> Email generated automatically by Patchew [http://patchew.org/].
>> Please send your feedback to patchew-devel@freelists.org
>
>
