Received: from eggs.gnu.org ([2001:4830:134:3::10]:49065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eCnVh-0000lF-Iz
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 09:08:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eCnVa-0004cX-Kz
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 09:08:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34522)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1eCnVa-0004c9-5d
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 09:08:42 -0500
References: <151023266893.360.2441014157612423993@bafd83ae6430>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <7e42c571-7e7e-052c-cf6b-2ddd23b56cd4@redhat.com>
Date: Thu, 9 Nov 2017 16:08:33 +0200
MIME-Version: 1.0
In-Reply-To: <151023266893.360.2441014157612423993@bafd83ae6430>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V4] hw/pcie-pci-bridge: restrict to X86 and
 ARM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, famz@redhat.com
Cc: patchew-devel@freelists.org

On 09/11/2017 15:04, no-reply@patchew.org wrote:
> Hi,
> 
> This series failed automatic build test. Please find the testing commands and
> their output below. If you have docker installed, you can probably reproduce it
> locally.
> 
> Subject: [Qemu-devel] [PATCH V4] hw/pcie-pci-bridge: restrict to X86 and ARM
> Type: series
> Message-id: 20171109125826.120228-1-marcel@redhat.com
> 
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> set -e
> git submodule update --init dtc
> # Let docker tests dump environment info
> export SHOW_ENV=1
> export J=8
> time make docker-test-quick@centos6
> time make docker-test-build@min-glib
> time make docker-test-mingw@fedora
> time make docker-test-block@fedora
> === TEST SCRIPT END ===
> 
> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> Switched to a new branch 'test'
> e0f832ffeb hw/pcie-pci-bridge: restrict to X86 and ARM
> 
> === OUTPUT BEGIN ===
> Submodule 'dtc' (git://git.qemu-project.org/dtc.git) registered for path 'dtc'
> Cloning into '/var/tmp/patchew-tester-tmp-gp94i687/src/dtc'...
> Submodule path 'dtc': checked out '558cd81bdd432769b59bff01240c44f82cfb1a9d'
>    BUILD   centos6
> make[1]: Entering directory '/var/tmp/patchew-tester-tmp-gp94i687/src'
>    GEN     /var/tmp/patchew-tester-tmp-gp94i687/src/docker-src.2017-11-09-08.03.01.2879/qemu.tar
> Cloning into '/var/tmp/patchew-tester-tmp-gp94i687/src/docker-src.2017-11-09-08.03.01.2879/qemu.tar.vroot'...
> done.
> Checking out files:  43% (2465/5654)
> Checking out files:  44% (2488/5654)
> Checking out files:  45% (2545/5654)
> Checking out files:  46% (2601/5654)
> Checking out files:  47% (2658/5654)
> Checking out files:  48% (2714/5654)
> Checking out files:  49% (2771/5654)
> Checking out files:  50% (2827/5654)
> Checking out files:  51% (2884/5654)
> Checking out files:  52% (2941/5654)
> Checking out files:  53% (2997/5654)
> Checking out files:  54% (3054/5654)
> Checking out files:  55% (3110/5654)
> Checking out files:  56% (3167/5654)
> Checking out files:  57% (3223/5654)
> Checking out files:  58% (3280/5654)
> Checking out files:  59% (3336/5654)
> Checking out files:  60% (3393/5654)
> Checking out files:  61% (3449/5654)
> Checking out files:  62% (3506/5654)
> Checking out files:  62% (3553/5654)
> Checking out files:  63% (3563/5654)
> Checking out files:  64% (3619/5654)
> Checking out files:  65% (3676/5654)
> Checking out files:  66% (3732/5654)
> Checking out files:  67% (3789/5654)
> Checking out files:  68% (3845/5654)
> Checking out files:  69% (3902/5654)
> Checking out files:  70% (3958/5654)
> Checking out files:  71% (4015/5654)
> Checking out files:  72% (4071/5654)
> Checking out files:  73% (4128/5654)
> Checking out files:  74% (4184/5654)
> Checking out files:  75% (4241/5654)
> Checking out files:  76% (4298/5654)
> Checking out files:  77% (4354/5654)
> Checking out files:  78% (4411/5654)
> Checking out files:  79% (4467/5654)
> Checking out files:  80% (4524/5654)
> Checking out files:  81% (4580/5654)
> Checking out files:  82% (4637/5654)
> Checking out files:  83% (4693/5654)
> Checking out files:  84% (4750/5654)
> Checking out files:  85% (4806/5654)
> Checking out files:  86% (4863/5654)
> Checking out files:  87% (4919/5654)
> Checking out files:  88% (4976/5654)
> Checking out files:  89% (5033/5654)
> Checking out files:  90% (5089/5654)
> Checking out files:  91% (5146/5654)
> Checking out files:  92% (5202/5654)
> Checking out files:  93% (5259/5654)
> Checking out files:  94% (5315/5654)
> Checking out files:  95% (5372/5654)
> Checking out files:  96% (5428/5654)
> Checking out files:  97% (5485/5654)
> Checking out files:  98% (5541/5654)
> Checking out files:  99% (5598/5654)
> Checking out files: 100% (5654/5654)
> Checking out files: 100% (5654/5654), done.
> Your branch is up-to-date with 'origin/test'.
> Submodule 'dtc' (git://git.qemu-project.org/dtc.git) registered for path 'dtc'
> Cloning into '/var/tmp/patchew-tester-tmp-gp94i687/src/docker-src.2017-11-09-08.03.01.2879/qemu.tar.vroot/dtc'...
> Submodule path 'dtc': checked out '558cd81bdd432769b59bff01240c44f82cfb1a9d'
> Submodule 'ui/keycodemapdb' (git://git.qemu.org/keycodemapdb.git) registered for path 'ui/keycodemapdb'
> Cloning into '/var/tmp/patchew-tester-tmp-gp94i687/src/docker-src.2017-11-09-08.03.01.2879/qemu.tar.vroot/ui/keycodemapdb'...
> Submodule path 'ui/keycodemapdb': checked out '10739aa26051a5d49d88132604539d3ed085e72e'
>    COPY    RUNNER
>      RUN test-quick in qemu:centos6
> Packages installed:
> SDL-devel-1.2.14-7.el6_7.1.x86_64
> bison-2.4.1-5.el6.x86_64
> bzip2-devel-1.0.5-7.el6_0.x86_64
> ccache-3.1.6-2.el6.x86_64
> csnappy-devel-0-6.20150729gitd7bc683.el6.x86_64
> flex-2.5.35-9.el6.x86_64
> gcc-4.4.7-18.el6.x86_64
> gettext-0.17-18.el6.x86_64
> git-1.7.1-9.el6_9.x86_64
> glib2-devel-2.28.8-9.el6.x86_64
> libepoxy-devel-1.2-3.el6.x86_64
> libfdt-devel-1.4.0-1.el6.x86_64
> librdmacm-devel-1.0.21-0.el6.x86_64
> lzo-devel-2.03-3.1.el6_5.1.x86_64
> make-3.81-23.el6.x86_64
> mesa-libEGL-devel-11.0.7-4.el6.x86_64
> mesa-libgbm-devel-11.0.7-4.el6.x86_64
> package g++ is not installed
> pixman-devel-0.32.8-1.el6.x86_64
> spice-glib-devel-0.26-8.el6.x86_64
> spice-server-devel-0.12.4-16.el6.x86_64
> tar-1.23-15.el6_8.x86_64
> vte-devel-0.25.1-9.el6.x86_64
> xen-devel-4.6.6-2.el6.x86_64
> zlib-devel-1.2.3-29.el6.x86_64
> 
> Environment variables:
> PACKAGES=bison     bzip2-devel     ccache     csnappy-devel     flex     g++     gcc     gettext     git     glib2-devel     libepoxy-devel     libfdt-devel     librdmacm-devel     lzo-devel     make     mesa-libEGL-devel     mesa-libgbm-devel     pixman-devel     SDL-devel     spice-glib-devel     spice-server-devel     tar     vte-devel     xen-devel     zlib-devel
> HOSTNAME=94dbf70809aa
> MAKEFLAGS= -j8
> J=8
> CCACHE_DIR=/var/tmp/ccache
> EXTRA_CONFIGURE_OPTS=
> V=
> SHOW_ENV=1
> PATH=/usr/lib/ccache:/usr/lib64/ccache:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
> PWD=/
> TARGET_LIST=
> SHLVL=1
> HOME=/root
> TEST_DIR=/tmp/qemu-test
> FEATURES= dtc
> DEBUG=
> _=/usr/bin/env
> 
> Configure options:
> --enable-werror --target-list=x86_64-softmmu,aarch64-softmmu --prefix=/tmp/qemu-test/install
> No C++ compiler available; disabling C++ specific optional code
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
> GIT submodules
> C compiler        cc
> Host C compiler   cc
> C++ compiler
> Objective-C compiler cc
> ARFLAGS           rv
> CFLAGS            -O2 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2 -g
> QEMU_CFLAGS       -I/usr/include/pixman-1   -I$(SRC_PATH)/dtc/libfdt -pthread -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include   -DNCURSES_WIDECHAR   -fPIE -DPIE -m64 -mcx16 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-prototypes -fno-strict-aliasing -fno-common -fwrapv  -Wendif-labels -Wno-missing-include-dirs -Wempty-body -Wnested-externs -Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers -Wold-style-declaration -Wold-style-definition -Wtype-limits -fstack-protector-all -Wno-missing-braces  -I/usr/include/libpng12   -I/usr/include/libdrm     -I/usr/include/spice-server -I/usr/include/cacard -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include -I/usr/include/pixman-1 -I/usr/include/nss3 -I/usr/include/nspr4 -I/usr/include/spice-1
> LDFLAGS           -Wl,--warn-common -Wl,-z,relro -Wl,-z,now -pie -m64 -g
> make              make
> install           install
> python            python -B
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
> SDL support       yes (1.2.14)
> GTK support       yes (2.24.23)
> GTK GL support    no
> VTE support       yes (0.25.1)
> TLS priority      NORMAL
> GNUTLS support    no
> GNUTLS rnd        no
> libgcrypt         no
> libgcrypt kdf     no
> nettle            no
> nettle kdf        no
> libtasn1          no
> curses support    yes
> virgl support     no
> curl support      no
> mingw32 support   no
> Audio drivers     oss
> Block whitelist (rw)
> Block whitelist (ro)
> VirtFS support    no
> Multipath support no
> VNC support       yes
> VNC SASL support  no
> VNC JPEG support  yes
> VNC PNG support   yes
> xen support       yes
> xen ctrl version  40600
> pv dom build      no
> brlapi support    no
> bluez  support    no
> Documentation     no
> PIE               yes
> vde support       no
> netmap support    no
> Linux AIO support no
> ATTR/XATTR support yes
> Install blobs     yes
> KVM support       yes
> HAX support       no
> TCG support       yes
> TCG debug enabled no
> TCG interpreter   no
> RDMA support      yes
> fdt support       yes
> preadv support    yes
> fdatasync         yes
> madvise           yes
> posix_madvise     yes
> libcap-ng support no
> vhost-net support yes
> vhost-scsi support yes
> vhost-vsock support yes
> vhost-user support yes
> Trace backends    log
> spice support     yes (0.12.6/0.12.4)
> rbd support       no
> xfsctl support    no
> smartcard support yes
> libusb            no
> usb net redir     no
> OpenGL support    yes
> OpenGL dmabufs    no
> libiscsi support  no
> libnfs support    no
> build guest agent yes
> QGA VSS support   no
> QGA w32 disk info no
> QGA MSI support   no
> seccomp support   no
> coroutine backend ucontext
> coroutine pool    yes
> debug stack usage no
> crypto afalg      no
> GlusterFS support no
> gcov              gcov
> gcov enabled      no
> TPM support       yes
> libssh2 support   no
> TPM passthrough   yes
> TPM emulator      yes
> QOM debugging     yes
> Live block migration yes
> lzo support       yes
> snappy support    no
> bzip2 support     yes
> NUMA host support no
> tcmalloc support  no
> jemalloc support  no
> avx2 optimization no
> replication support yes
> VxHS block device no
> capstone          no
> mkdir -p dtc/libfdt
>    GEN     x86_64-softmmu/config-devices.mak.tmp
> mkdir -p dtc/tests
>    GEN     aarch64-softmmu/config-devices.mak.tmp
>    GEN     config-host.h
>    GEN     qemu-options.def
>    GEN     qapi-visit.h
>    GEN     qmp-commands.h
>    GEN     qapi-types.h
>    GEN     qapi-event.h
>    GEN     x86_64-softmmu/config-devices.mak
>    GEN     qmp-marshal.c
>    GEN     qapi-types.c
>    GEN     aarch64-softmmu/config-devices.mak
>    GEN     qapi-visit.c
>    GEN     qapi-event.c
>    GEN     qmp-introspect.h
>    GEN     qmp-introspect.c
>    GEN     trace/generated-tcg-tracers.h
>    GEN     trace/generated-helpers-wrappers.h
>    GEN     trace/generated-helpers.h
>    GEN     trace/generated-helpers.c
>    GEN     module_block.h
>    GEN     ui/input-keymap-linux-to-qcode.c
>    GEN     ui/input-keymap-qcode-to-qnum.c
>    GEN     ui/input-keymap-qnum-to-qcode.c
>    GEN     tests/test-qapi-types.h
>    GEN     tests/test-qapi-visit.h
>    GEN     tests/test-qmp-commands.h
>    GEN     tests/test-qapi-event.h
>    GEN     tests/test-qmp-introspect.h
>    GEN     trace-root.h
>    GEN     util/trace.h
>    GEN     crypto/trace.h
>    GEN     io/trace.h
>    GEN     migration/trace.h
>    GEN     block/trace.h
>    GEN     chardev/trace.h
>    GEN     hw/block/trace.h
>    GEN     hw/block/dataplane/trace.h
>    GEN     hw/char/trace.h
>    GEN     hw/intc/trace.h
>    GEN     hw/net/trace.h
>    GEN     hw/virtio/trace.h
>    GEN     hw/audio/trace.h
>    GEN     hw/misc/trace.h
>    GEN     hw/usb/trace.h
>    GEN     hw/scsi/trace.h
>    GEN     hw/nvram/trace.h
>    GEN     hw/display/trace.h
>    GEN     hw/input/trace.h
>    GEN     hw/timer/trace.h
>    GEN     hw/dma/trace.h
>    GEN     hw/sparc/trace.h
>    GEN     hw/sd/trace.h
>    GEN     hw/isa/trace.h
>    GEN     hw/mem/trace.h
>    GEN     hw/i386/trace.h
>    GEN     hw/i386/xen/trace.h
>    GEN     hw/9pfs/trace.h
>    GEN     hw/ppc/trace.h
>    GEN     hw/pci/trace.h
>    GEN     hw/s390x/trace.h
>    GEN     hw/vfio/trace.h
>    GEN     hw/acpi/trace.h
>    GEN     hw/arm/trace.h
>    GEN     hw/alpha/trace.h
>    GEN     hw/xen/trace.h
>    GEN     hw/ide/trace.h
>    GEN     ui/trace.h
>    GEN     audio/trace.h
>    GEN     net/trace.h
>    GEN     target/arm/trace.h
>    GEN     target/i386/trace.h
>    GEN     target/mips/trace.h
>    GEN     target/sparc/trace.h
>    GEN     target/s390x/trace.h
>    GEN     target/ppc/trace.h
>    GEN     qom/trace.h
>    GEN     linux-user/trace.h
>    GEN     qapi/trace.h
>    GEN     accel/tcg/trace.h
>    GEN     accel/kvm/trace.h
>    GEN     nbd/trace.h
>    GEN     scsi/trace.h
>    GEN     trace-root.c
>    GEN     util/trace.c
>    GEN     crypto/trace.c
>    GEN     io/trace.c
>    GEN     migration/trace.c
>    GEN     block/trace.c
>    GEN     chardev/trace.c
>    GEN     hw/block/trace.c
>    GEN     hw/block/dataplane/trace.c
>    GEN     hw/char/trace.c
>    GEN     hw/intc/trace.c
>    GEN     hw/net/trace.c
>    GEN     hw/virtio/trace.c
>    GEN     hw/audio/trace.c
>    GEN     hw/misc/trace.c
>    GEN     hw/usb/trace.c
>    GEN     hw/scsi/trace.c
>    GEN     hw/nvram/trace.c
>    GEN     hw/display/trace.c
>    GEN     hw/input/trace.c
>    GEN     hw/timer/trace.c
>    GEN     hw/dma/trace.c
>    GEN     hw/sparc/trace.c
>    GEN     hw/sd/trace.c
>    GEN     hw/isa/trace.c
>    GEN     hw/mem/trace.c
>    GEN     hw/i386/trace.c
>    GEN     hw/i386/xen/trace.c
>    GEN     hw/9pfs/trace.c
>    GEN     hw/ppc/trace.c
>    GEN     hw/pci/trace.c
>    GEN     hw/s390x/trace.c
>    GEN     hw/vfio/trace.c
>    GEN     hw/acpi/trace.c
>    GEN     hw/arm/trace.c
>    GEN     hw/alpha/trace.c
>    GEN     hw/xen/trace.c
>    GEN     hw/ide/trace.c
>    GEN     ui/trace.c
>    GEN     audio/trace.c
>    GEN     net/trace.c
>    GEN     target/arm/trace.c
>    GEN     target/i386/trace.c
>    GEN     target/mips/trace.c
>    GEN     target/sparc/trace.c
>    GEN     target/s390x/trace.c
>    GEN     target/ppc/trace.c
>    GEN     qom/trace.c
>    GEN     linux-user/trace.c
>    GEN     qapi/trace.c
>    GEN     accel/tcg/trace.c
>    GEN     accel/kvm/trace.c
>    GEN     nbd/trace.c
>    GEN     scsi/trace.c
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
> 	 DEP /tmp/qemu-test/src/dtc/tests/add_subnode_with_nops.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/path_offset_aliases.c
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
> 	 DEP /tmp/qemu-test/src/dtc/tests/node_offset_by_prop_value.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/parent_offset.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/supernode_atdepth_offset.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/get_path.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/get_phandle.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/getprop.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/path_offset.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/get_name.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/find_property.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/subnode_offset.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/root_node.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/get_mem_rsv.c
> 	 DEP /tmp/qemu-test/src/dtc/libfdt/fdt_overlay.c
> 	 DEP /tmp/qemu-test/src/dtc/libfdt/fdt_empty_tree.c
> 	 DEP /tmp/qemu-test/src/dtc/libfdt/fdt_addresses.c
> 	 DEP /tmp/qemu-test/src/dtc/libfdt/fdt_strerror.c
> 	 DEP /tmp/qemu-test/src/dtc/libfdt/fdt_rw.c
> 	 DEP /tmp/qemu-test/src/dtc/libfdt/fdt_sw.c
> 	 DEP /tmp/qemu-test/src/dtc/libfdt/fdt_wip.c
> 	 DEP /tmp/qemu-test/src/dtc/libfdt/fdt_ro.c
> 	 DEP /tmp/qemu-test/src/dtc/libfdt/fdt.c
> 	 DEP /tmp/qemu-test/src/dtc/util.c
> 	 DEP /tmp/qemu-test/src/dtc/fdtput.c
> 	 DEP /tmp/qemu-test/src/dtc/fdtget.c
> 	 LEX convert-dtsv0-lexer.lex.c
> 	 DEP /tmp/qemu-test/src/dtc/fdtdump.c
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
> 	 DEP dtc-lexer.lex.c
> 	 DEP dtc-parser.tab.c
> 	CHK version_gen.h
> 	UPD version_gen.h
> 	 DEP /tmp/qemu-test/src/dtc/util.c
> 	 CC libfdt/fdt_wip.o
> 	 CC libfdt/fdt.o
> 	 CC libfdt/fdt_ro.o
> 	 CC libfdt/fdt_rw.o
> 	 CC libfdt/fdt_strerror.o
> 	 CC libfdt/fdt_sw.o
> 	 CC libfdt/fdt_empty_tree.o
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
> mkdir -p dtc/libfdt
> mkdir -p dtc/tests
>    CC      tests/qemu-iotests/socket_scm_helper.o
>    GEN     qga/qapi-generated/qga-qapi-types.c
>    GEN     qga/qapi-generated/qga-qapi-visit.h
>    GEN     qga/qapi-generated/qga-qapi-types.h
>    GEN     qga/qapi-generated/qga-qmp-commands.h
>    GEN     qga/qapi-generated/qga-qmp-marshal.c
>    GEN     qga/qapi-generated/qga-qapi-visit.c
>    CC      qmp-introspect.o
>    CC      qapi-types.o
>    CC      qapi-visit.o
>    CC      qapi-event.o
>    CC      qapi/qapi-visit-core.o
>    CC      qapi/qapi-dealloc-visitor.o
>    CC      qapi/qobject-output-visitor.o
>    CC      qapi/qobject-input-visitor.o
>    CC      qapi/qmp-registry.o
>    CC      qapi/qmp-dispatch.o
>    CC      qapi/string-output-visitor.o
>    CC      qapi/opts-visitor.o
>    CC      qapi/qapi-clone-visitor.o
>    CC      qapi/qmp-event.o
>    CC      qapi/qapi-util.o
>    CC      qobject/qnull.o
>    CC      qapi/string-input-visitor.o
>    CC      qobject/qnum.o
>    CC      qobject/qstring.o
>    CC      qobject/qdict.o
>    CC      qobject/qlist.o
>    CC      qobject/qlit.o
>    CC      qobject/qjson.o
>    CC      qobject/qobject.o
>    CC      qobject/qbool.o
>    CC      qobject/json-lexer.o
>    CC      qobject/json-streamer.o
>    CC      qobject/json-parser.o
>    CC      trace/control.o
>    CC      trace/qmp.o
>    CC      util/osdep.o
>    CC      util/cutils.o
>    CC      util/unicode.o
>    CC      util/qemu-timer-common.o
>    CC      util/bufferiszero.o
>    CC      util/aiocb.o
>    CC      util/lockcnt.o
>    CC      util/async.o
>    CC      util/thread-pool.o
>    CC      util/qemu-timer.o
>    CC      util/main-loop.o
>    CC      util/iohandler.o
>    CC      util/aio-posix.o
>    CC      util/compatfd.o
>    CC      util/event_notifier-posix.o
>    CC      util/mmap-alloc.o
>    CC      util/oslib-posix.o
>    CC      util/qemu-openpty.o
>    CC      util/qemu-thread-posix.o
>    CC      util/memfd.o
>    CC      util/envlist.o
>    CC      util/path.o
>    CC      util/module.o
>    CC      util/host-utils.o
>    CC      util/bitmap.o
>    CC      util/bitops.o
>    CC      util/hbitmap.o
>    CC      util/fifo8.o
>    CC      util/cacheinfo.o
>    CC      util/acl.o
>    CC      util/error.o
>    CC      util/qemu-error.o
>    CC      util/id.o
>    CC      util/iov.o
>    CC      util/qemu-config.o
>    CC      util/qemu-sockets.o
>    CC      util/uri.o
>    CC      util/qemu-progress.o
>    CC      util/notify.o
>    CC      util/keyval.o
>    CC      util/qemu-option.o
>    CC      util/hexdump.o
>    CC      util/crc32c.o
>    CC      util/uuid.o
>    CC      util/throttle.o
>    CC      util/getauxval.o
>    CC      util/rcu.o
>    CC      util/readline.o
>    CC      util/qemu-coroutine.o
>    CC      util/qemu-coroutine-lock.o
>    CC      util/qemu-coroutine-io.o
>    CC      util/qemu-coroutine-sleep.o
>    CC      util/coroutine-ucontext.o
>    CC      util/buffer.o
>    CC      util/timed-average.o
>    CC      util/base64.o
>    CC      util/log.o
>    CC      util/pagesize.o
>    CC      util/qdist.o
>    CC      util/qht.o
>    CC      util/range.o
>    CC      util/stats64.o
>    CC      util/systemd.o
>    CC      trace-root.o
>    CC      util/trace.o
>    CC      crypto/trace.o
>    CC      io/trace.o
>    CC      migration/trace.o
>    CC      block/trace.o
>    CC      chardev/trace.o
>    CC      hw/block/trace.o
>    CC      hw/block/dataplane/trace.o
>    CC      hw/char/trace.o
>    CC      hw/intc/trace.o
>    CC      hw/net/trace.o
>    CC      hw/virtio/trace.o
>    CC      hw/audio/trace.o
>    CC      hw/misc/trace.o
>    CC      hw/scsi/trace.o
>    CC      hw/nvram/trace.o
>    CC      hw/usb/trace.o
>    CC      hw/display/trace.o
>    CC      hw/input/trace.o
>    CC      hw/dma/trace.o
>    CC      hw/timer/trace.o
>    CC      hw/sd/trace.o
>    CC      hw/sparc/trace.o
>    CC      hw/isa/trace.o
>    CC      hw/mem/trace.o
>    CC      hw/i386/trace.o
>    CC      hw/i386/xen/trace.o
>    CC      hw/ppc/trace.o
>    CC      hw/9pfs/trace.o
>    CC      hw/pci/trace.o
>    CC      hw/vfio/trace.o
>    CC      hw/s390x/trace.o
>    CC      hw/acpi/trace.o
>    CC      hw/arm/trace.o
>    CC      hw/alpha/trace.o
>    CC      hw/xen/trace.o
>    CC      hw/ide/trace.o
>    CC      ui/trace.o
>    CC      audio/trace.o
>    CC      net/trace.o
>    CC      target/arm/trace.o
>    CC      target/i386/trace.o
>    CC      target/mips/trace.o
>    CC      target/s390x/trace.o
>    CC      target/ppc/trace.o
>    CC      target/sparc/trace.o
>    CC      qom/trace.o
>    CC      linux-user/trace.o
>    CC      qapi/trace.o
>    CC      accel/kvm/trace.o
>    CC      accel/tcg/trace.o
>    CC      scsi/trace.o
>    CC      nbd/trace.o
>    CC      crypto/pbkdf-stub.o
>    CC      stubs/arch-query-cpu-def.o
>    CC      stubs/arch-query-cpu-model-expansion.o
>    CC      stubs/arch-query-cpu-model-comparison.o
>    CC      stubs/arch-query-cpu-model-baseline.o
>    CC      stubs/bdrv-next-monitor-owned.o
>    CC      stubs/blk-commit-all.o
>    CC      stubs/blockdev-close-all-bdrv-states.o
>    CC      stubs/clock-warp.o
>    CC      stubs/dump.o
>    CC      stubs/cpu-get-clock.o
>    CC      stubs/cpu-get-icount.o
>    CC      stubs/error-printf.o
>    CC      stubs/fdset.o
>    CC      stubs/get-vm-name.o
>    CC      stubs/gdbstub.o
>    CC      stubs/iothread.o
>    CC      stubs/iothread-lock.o
>    CC      stubs/is-daemonized.o
>    CC      stubs/machine-init-done.o
>    CC      stubs/migr-blocker.o
>    CC      stubs/change-state-handler.o
>    CC      stubs/monitor.o
>    CC      stubs/notify-event.o
>    CC      stubs/replay.o
>    CC      stubs/qtest.o
>    CC      stubs/runstate-check.o
>    CC      stubs/set-fd-handler.o
>    CC      stubs/slirp.o
>    CC      stubs/sysbus.o
>    CC      stubs/tpm.o
>    CC      stubs/trace-control.o
>    CC      stubs/vm-stop.o
>    CC      stubs/uuid.o
>    CC      stubs/vmstate.o
>    CC      stubs/qmp_pc_dimm.o
>    CC      stubs/target-get-monitor-def.o
>    CC      stubs/target-monitor-defs.o
>    CC      stubs/pc_madt_cpu_entry.o
>    CC      stubs/vmgenid.o
>    CC      stubs/xen-common.o
>    CC      stubs/xen-hvm.o
>    CC      stubs/pci-host-piix.o
>    CC      contrib/ivshmem-client/ivshmem-client.o
>    CC      contrib/ivshmem-client/main.o
>    CC      contrib/ivshmem-server/ivshmem-server.o
>    CC      contrib/ivshmem-server/main.o
>    CC      block.o
>    CC      blockjob.o
>    CC      qemu-nbd.o
>    CC      qemu-io-cmds.o
>    CC      replication.o
>    CC      block/raw-format.o
>    CC      block/qcow.o
>    CC      block/vdi.o
>    CC      block/vmdk.o
>    CC      block/cloop.o
>    CC      block/vpc.o
>    CC      block/bochs.o
>    CC      block/vvfat.o
>    CC      block/dmg.o
>    CC      block/qcow2.o
>    CC      block/qcow2-refcount.o
>    CC      block/qcow2-cluster.o
>    CC      block/qcow2-snapshot.o
>    CC      block/qcow2-cache.o
>    CC      block/qcow2-bitmap.o
>    CC      block/qed.o
>    CC      block/qed-l2-cache.o
>    CC      block/qed-table.o
>    CC      block/qed-cluster.o
>    CC      block/vhdx.o
>    CC      block/qed-check.o
>    CC      block/vhdx-endian.o
>    CC      block/quorum.o
>    CC      block/vhdx-log.o
>    CC      block/parallels.o
>    CC      block/blkdebug.o
>    CC      block/blkverify.o
>    CC      block/blkreplay.o
>    CC      block/block-backend.o
>    CC      block/snapshot.o
>    CC      block/qapi.o
>    CC      block/file-posix.o
>    CC      block/null.o
>    CC      block/mirror.o
>    CC      block/commit.o
>    CC      block/io.o
>    CC      block/throttle-groups.o
>    CC      block/nbd.o
>    CC      block/nbd-client.o
>    CC      block/sheepdog.o
>    CC      block/dirty-bitmap.o
>    CC      block/accounting.o
>    CC      block/write-threshold.o
>    CC      block/backup.o
>    CC      block/replication.o
>    CC      block/throttle.o
>    CC      nbd/server.o
>    CC      block/crypto.o
>    CC      nbd/client.o
>    CC      nbd/common.o
>    CC      scsi/utils.o
>    CC      scsi/pr-manager.o
>    CC      scsi/pr-manager-helper.o
>    CC      block/dmg-bz2.o
>    CC      crypto/init.o
>    CC      crypto/hash.o
>    CC      crypto/hmac.o
>    CC      crypto/hash-glib.o
>    CC      crypto/hmac-glib.o
>    CC      crypto/aes.o
>    CC      crypto/desrfb.o
>    CC      crypto/cipher.o
>    CC      crypto/tlscreds.o
>    CC      crypto/tlscredsanon.o
>    CC      crypto/tlscredsx509.o
>    CC      crypto/secret.o
>    CC      crypto/tlssession.o
>    CC      crypto/random-platform.o
>    CC      crypto/pbkdf.o
>    CC      crypto/ivgen.o
>    CC      crypto/ivgen-essiv.o
>    CC      crypto/ivgen-plain.o
>    CC      crypto/ivgen-plain64.o
>    CC      crypto/afsplit.o
>    CC      crypto/block.o
>    CC      crypto/xts.o
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
>    CC      io/task.o
>    CC      qom/object.o
>    CC      qom/container.o
>    CC      qom/qom-qobject.o
>    CC      qom/object_interfaces.o
>    GEN     qemu-img-cmds.h
>    CC      qemu-io.o
>    CC      qemu-bridge-helper.o
>    CC      scsi/qemu-pr-helper.o
>    CC      blockdev.o
>    CC      blockdev-nbd.o
>    CC      bootdevice.o
>    CC      iothread.o
>    CC      qdev-monitor.o
>    CC      device-hotplug.o
>    CC      os-posix.o
>    CC      bt-host.o
>    CC      bt-vhci.o
>    CC      dma-helpers.o
>    CC      vl.o
>    CC      tpm.o
>    CC      device_tree.o
>    CC      qmp-marshal.o
>    CC      qmp.o
>    CC      hmp.o
>    CC      cpus-common.o
>    CC      audio/audio.o
>    CC      audio/wavaudio.o
>    CC      audio/noaudio.o
>    CC      audio/mixeng.o
>    CC      audio/sdlaudio.o
>    CC      audio/ossaudio.o
>    CC      audio/spiceaudio.o
>    CC      audio/wavcapture.o
>    CC      backends/rng.o
>    CC      backends/rng-egd.o
>    CC      backends/tpm.o
>    CC      backends/rng-random.o
>    CC      backends/hostmem.o
>    CC      backends/hostmem-ram.o
>    CC      backends/hostmem-file.o
>    CC      backends/cryptodev.o
>    CC      backends/cryptodev-builtin.o
>    CC      block/stream.o
>    CC      chardev/msmouse.o
>    CC      chardev/wctablet.o
>    CC      chardev/testdev.o
>    CC      chardev/spice.o
>    CC      disas/arm.o
>    CC      disas/i386.o
>    CC      fsdev/qemu-fsdev-dummy.o
>    CC      fsdev/qemu-fsdev-opts.o
>    CC      fsdev/qemu-fsdev-throttle.o
>    CC      hw/acpi/core.o
>    CC      hw/acpi/piix4.o
>    CC      hw/acpi/pcihp.o
>    CC      hw/acpi/ich9.o
>    CC      hw/acpi/cpu_hotplug.o
>    CC      hw/acpi/tco.o
>    CC      hw/acpi/memory_hotplug.o
>    CC      hw/acpi/nvdimm.o
>    CC      hw/acpi/vmgenid.o
>    CC      hw/acpi/bios-linker-loader.o
>    CC      hw/acpi/acpi_interface.o
>    CC      hw/acpi/cpu.o
>    CC      hw/acpi/aml-build.o
>    CC      hw/acpi/acpi-stub.o
>    CC      hw/acpi/ipmi.o
>    CC      hw/acpi/ipmi-stub.o
>    CC      hw/audio/es1370.o
>    CC      hw/audio/sb16.o
>    CC      hw/audio/ac97.o
>    CC      hw/audio/fmopl.o
>    CC      hw/audio/adlib.o
>    CC      hw/audio/gus.o
>    CC      hw/audio/gusemu_hal.o
>    CC      hw/audio/gusemu_mixer.o
>    CC      hw/audio/cs4231a.o
>    CC      hw/audio/hda-codec.o
>    CC      hw/audio/intel-hda.o
>    CC      hw/audio/pcspk.o
>    CC      hw/audio/wm8750.o
>    CC      hw/audio/pl041.o
>    CC      hw/audio/lm4549.o
>    CC      hw/audio/marvell_88w8618.o
>    CC      hw/block/block.o
>    CC      hw/audio/soundhw.o
>    CC      hw/block/cdrom.o
>    CC      hw/block/hd-geometry.o
>    CC      hw/block/m25p80.o
>    CC      hw/block/fdc.o
>    CC      hw/block/nand.o
>    CC      hw/block/pflash_cfi01.o
>    CC      hw/block/pflash_cfi02.o
>    CC      hw/block/xen_disk.o
>    CC      hw/block/ecc.o
>    CC      hw/block/onenand.o
>    CC      hw/block/nvme.o
>    CC      hw/bt/core.o
>    CC      hw/bt/l2cap.o
>    CC      hw/bt/sdp.o
>    CC      hw/bt/hci.o
>    CC      hw/bt/hci-csr.o
>    CC      hw/bt/hid.o
>    CC      hw/char/ipoctal232.o
>    CC      hw/char/parallel.o
>    CC      hw/char/pl011.o
>    CC      hw/char/serial.o
>    CC      hw/char/serial-isa.o
>    CC      hw/char/serial-pci.o
>    CC      hw/char/virtio-console.o
>    CC      hw/char/xen_console.o
>    CC      hw/char/cadence_uart.o
>    CC      hw/char/cmsdk-apb-uart.o
>    CC      hw/char/debugcon.o
>    CC      hw/char/imx_serial.o
>    CC      hw/core/qdev.o
>    CC      hw/core/bus.o
>    CC      hw/core/qdev-properties.o
>    CC      hw/core/reset.o
>    CC      hw/core/fw-path-provider.o
>    CC      hw/core/irq.o
>    CC      hw/core/hotplug.o
>    CC      hw/core/nmi.o
>    CC      hw/core/ptimer.o
>    CC      hw/core/sysbus.o
>    CC      hw/core/machine.o
>    CC      hw/core/loader.o
>    CC      hw/core/qdev-properties-system.o
>    CC      hw/core/register.o
>    CC      hw/core/or-irq.o
>    CC      hw/core/platform-bus.o
>    CC      hw/cpu/core.o
>    CC      hw/display/ads7846.o
>    CC      hw/display/pl110.o
>    CC      hw/display/ssd0323.o
>    CC      hw/display/ssd0303.o
>    CC      hw/display/cirrus_vga.o
>    CC      hw/display/xenfb.o
>    CC      hw/display/vga-pci.o
>    CC      hw/display/vga-isa.o
>    CC      hw/display/vmware_vga.o
>    CC      hw/display/blizzard.o
>    CC      hw/display/exynos4210_fimd.o
>    CC      hw/display/framebuffer.o
>    CC      hw/display/tc6393xb.o
>    CC      hw/display/qxl.o
>    CC      hw/display/qxl-render.o
>    CC      hw/dma/pl080.o
>    CC      hw/dma/pl330.o
>    CC      hw/display/qxl-logger.o
>    CC      hw/dma/i8257.o
>    CC      hw/dma/xlnx-zynq-devcfg.o
>    CC      hw/gpio/max7310.o
>    CC      hw/gpio/pl061.o
>    CC      hw/gpio/zaurus.o
>    CC      hw/gpio/gpio_key.o
>    CC      hw/i2c/core.o
>    CC      hw/i2c/smbus.o
>    CC      hw/i2c/i2c-ddc.o
>    CC      hw/i2c/smbus_eeprom.o
>    CC      hw/i2c/versatile_i2c.o
>    CC      hw/i2c/smbus_ich9.o
>    CC      hw/i2c/pm_smbus.o
>    CC      hw/i2c/bitbang_i2c.o
>    CC      hw/i2c/exynos4210_i2c.o
>    CC      hw/i2c/imx_i2c.o
>    CC      hw/i2c/aspeed_i2c.o
>    CC      hw/ide/core.o
>    CC      hw/ide/atapi.o
>    CC      hw/ide/qdev.o
>    CC      hw/ide/pci.o
>    CC      hw/ide/microdrive.o
>    CC      hw/ide/piix.o
>    CC      hw/ide/isa.o
>    CC      hw/ide/ahci.o
>    CC      hw/ide/ich.o
>    CC      hw/ide/ahci-allwinner.o
>    CC      hw/input/hid.o
>    CC      hw/input/lm832x.o
>    CC      hw/input/pckbd.o
>    CC      hw/input/pl050.o
>    CC      hw/input/ps2.o
>    CC      hw/input/stellaris_input.o
>    CC      hw/input/tsc2005.o
>    CC      hw/input/vmmouse.o
>    CC      hw/input/virtio-input.o
>    CC      hw/input/virtio-input-hid.o
>    CC      hw/input/virtio-input-host.o
>    CC      hw/intc/i8259.o
>    CC      hw/intc/i8259_common.o
>    CC      hw/intc/pl190.o
>    CC      hw/intc/imx_avic.o
>    CC      hw/intc/realview_gic.o
>    CC      hw/intc/ioapic_common.o
>    CC      hw/intc/arm_gic_common.o
>    CC      hw/intc/arm_gic.o
>    CC      hw/intc/arm_gicv2m.o
>    CC      hw/intc/arm_gicv3_common.o
>    CC      hw/intc/arm_gicv3.o
>    CC      hw/intc/arm_gicv3_redist.o
>    CC      hw/intc/arm_gicv3_dist.o
>    CC      hw/intc/intc.o
>    CC      hw/intc/arm_gicv3_its_common.o
>    CC      hw/ipack/ipack.o
>    CC      hw/ipack/tpci200.o
>    CC      hw/ipmi/ipmi.o
>    CC      hw/ipmi/ipmi_bmc_sim.o
>    CC      hw/ipmi/ipmi_bmc_extern.o
>    CC      hw/ipmi/isa_ipmi_bt.o
>    CC      hw/ipmi/isa_ipmi_kcs.o
>    CC      hw/isa/isa-bus.o
>    CC      hw/isa/apm.o
>    CC      hw/mem/pc-dimm.o
>    CC      hw/misc/applesmc.o
>    CC      hw/misc/max111x.o
>    CC      hw/mem/nvdimm.o
>    CC      hw/misc/tmp105.o
>    CC      hw/misc/tmp421.o
>    CC      hw/misc/debugexit.o
>    CC      hw/misc/sga.o
>    CC      hw/misc/pc-testdev.o
>    CC      hw/misc/pci-testdev.o
>    CC      hw/misc/edu.o
>    CC      hw/misc/unimp.o
>    CC      hw/misc/vmcoreinfo.o
>    CC      hw/misc/arm_l2x0.o
>    CC      hw/misc/arm_integrator_debug.o
>    CC      hw/misc/a9scu.o
>    CC      hw/misc/arm11scu.o
>    CC      hw/net/xen_nic.o
>    CC      hw/net/ne2000.o
>    CC      hw/net/eepro100.o
>    CC      hw/net/pcnet.o
>    CC      hw/net/pcnet-pci.o
>    CC      hw/net/e1000.o
>    CC      hw/net/e1000x_common.o
>    CC      hw/net/net_tx_pkt.o
>    CC      hw/net/net_rx_pkt.o
>    CC      hw/net/e1000e.o
>    CC      hw/net/e1000e_core.o
>    CC      hw/net/rtl8139.o
>    CC      hw/net/vmxnet3.o
>    CC      hw/net/smc91c111.o
>    CC      hw/net/lan9118.o
>    CC      hw/net/ne2000-isa.o
>    CC      hw/net/xgmac.o
>    CC      hw/net/allwinner_emac.o
>    CC      hw/net/imx_fec.o
>    CC      hw/net/cadence_gem.o
>    CC      hw/net/stellaris_enet.o
>    CC      hw/net/rocker/rocker.o
>    CC      hw/net/ftgmac100.o
>    CC      hw/net/rocker/rocker_fp.o
>    CC      hw/net/rocker/rocker_desc.o
>    CC      hw/net/rocker/rocker_world.o
>    CC      hw/net/rocker/rocker_of_dpa.o
>    CC      hw/nvram/eeprom93xx.o
>    CC      hw/nvram/fw_cfg.o
>    CC      hw/nvram/chrp_nvram.o
>    CC      hw/pci-bridge/pci_bridge_dev.o
>    CC      hw/pci-bridge/pcie_root_port.o
>    CC      hw/pci-bridge/gen_pcie_root_port.o
>    CC      hw/pci-bridge/pci_expander_bridge.o
>    CC      hw/pci-bridge/xio3130_upstream.o
>    CC      hw/pci-bridge/xio3130_downstream.o
>    CC      hw/pci-bridge/i82801b11.o
>    CC      hw/pci-bridge/ioh3420.o
>    CC      hw/pci-host/pam.o
>    CC      hw/pci-host/versatile.o
>    CC      hw/pci-host/piix.o
>    CC      hw/pci-host/q35.o
>    CC      hw/pci-host/gpex.o
>    CC      hw/pci/pci.o
>    CC      hw/pci/pci_bridge.o
>    CC      hw/pci/msix.o
>    CC      hw/pci/msi.o
>    CC      hw/pci/shpc.o
>    CC      hw/pci/slotid_cap.o
>    CC      hw/pci/pci_host.o
>    CC      hw/pci/pcie.o
>    CC      hw/pci/pcie_host.o
>    CC      hw/pci/pcie_aer.o
>    CC      hw/pci/pcie_port.o
>    CC      hw/pci/pci-stub.o
>    CC      hw/pcmcia/pcmcia.o
>    CC      hw/scsi/scsi-disk.o
>    CC      hw/scsi/scsi-generic.o
>    CC      hw/scsi/scsi-bus.o
>    CC      hw/scsi/lsi53c895a.o
>    CC      hw/scsi/mptsas.o
>    CC      hw/scsi/mptconfig.o
>    CC      hw/scsi/mptendian.o
>    CC      hw/scsi/megasas.o
>    CC      hw/scsi/vmw_pvscsi.o
>    CC      hw/scsi/esp-pci.o
>    CC      hw/scsi/esp.o
>    CC      hw/sd/pl181.o
>    CC      hw/sd/ssi-sd.o
>    CC      hw/sd/sd.o
>    CC      hw/sd/core.o
>    CC      hw/sd/sdhci.o
>    CC      hw/smbios/smbios.o
>    CC      hw/smbios/smbios_type_38.o
>    CC      hw/smbios/smbios-stub.o
>    CC      hw/smbios/smbios_type_38-stub.o
>    CC      hw/ssi/pl022.o
>    CC      hw/ssi/ssi.o
>    CC      hw/ssi/aspeed_smc.o
>    CC      hw/ssi/xilinx_spips.o
>    CC      hw/ssi/stm32f2xx_spi.o
>    CC      hw/ssi/mss-spi.o
>    CC      hw/timer/arm_mptimer.o
>    CC      hw/timer/arm_timer.o
>    CC      hw/timer/armv7m_systick.o
>    CC      hw/timer/a9gtimer.o
>    CC      hw/timer/cadence_ttc.o
>    CC      hw/timer/ds1338.o
>    CC      hw/timer/hpet.o
>    CC      hw/timer/i8254_common.o
>    CC      hw/timer/i8254.o
>    CC      hw/timer/pl031.o
>    CC      hw/timer/imx_epit.o
>    CC      hw/timer/twl92230.o
>    CC      hw/timer/imx_gpt.o
>    CC      hw/timer/stm32f2xx_timer.o
>    CC      hw/timer/aspeed_timer.o
>    CC      hw/timer/cmsdk-apb-timer.o
>    CC      hw/timer/mss-timer.o
>    CC      hw/tpm/tpm_tis.o
>    CC      hw/tpm/tpm_passthrough.o
>    CC      hw/tpm/tpm_util.o
>    CC      hw/tpm/tpm_emulator.o
>    CC      hw/usb/core.o
>    CC      hw/usb/combined-packet.o
>    CC      hw/usb/bus.o
>    CC      hw/usb/desc.o
>    CC      hw/usb/libhw.o
>    CC      hw/usb/desc-msos.o
>    CC      hw/usb/hcd-uhci.o
>    CC      hw/usb/hcd-ohci.o
>    CC      hw/usb/hcd-ehci.o
>    CC      hw/usb/hcd-ehci-pci.o
>    CC      hw/usb/hcd-ehci-sysbus.o
>    CC      hw/usb/hcd-xhci-nec.o
>    CC      hw/usb/hcd-xhci.o
>    CC      hw/usb/hcd-musb.o
>    CC      hw/usb/dev-hub.o
>    CC      hw/usb/dev-hid.o
>    CC      hw/usb/dev-wacom.o
>    CC      hw/usb/dev-uas.o
>    CC      hw/usb/dev-storage.o
>    CC      hw/usb/dev-audio.o
>    CC      hw/usb/dev-network.o
>    CC      hw/usb/dev-serial.o
>    CC      hw/usb/dev-bluetooth.o
>    CC      hw/usb/dev-smartcard-reader.o
>    CC      hw/usb/ccid-card-passthru.o
>    CC      hw/usb/ccid-card-emulated.o
>    CC      hw/usb/dev-mtp.o
>    CC      hw/usb/host-stub.o
>    CC      hw/virtio/virtio-rng.o
>    CC      hw/virtio/virtio-pci.o
>    CC      hw/virtio/virtio-bus.o
>    CC      hw/virtio/virtio-mmio.o
>    CC      hw/virtio/vhost-stub.o
>    CC      hw/watchdog/watchdog.o
>    CC      hw/watchdog/wdt_i6300esb.o
>    CC      hw/watchdog/wdt_ib700.o
>    CC      hw/watchdog/wdt_aspeed.o
>    CC      hw/xen/xen_backend.o
>    CC      hw/xen/xen_devconfig.o
>    CC      hw/xen/xen_pvdev.o
>    CC      hw/xen/xen-common.o
>    CC      migration/migration.o
>    CC      migration/socket.o
>    CC      migration/fd.o
>    CC      migration/exec.o
>    CC      migration/tls.o
>    CC      migration/channel.o
>    CC      migration/savevm.o
>    CC      migration/colo-comm.o
>    CC      migration/colo.o
>    CC      migration/colo-failover.o
>    CC      migration/vmstate.o
>    CC      migration/page_cache.o
>    CC      migration/vmstate-types.o
>    CC      migration/qemu-file.o
>    CC      migration/global_state.o
>    CC      migration/qemu-file-channel.o
>    CC      migration/xbzrle.o
>    CC      migration/postcopy-ram.o
>    CC      migration/rdma.o
>    CC      migration/block.o
>    CC      migration/qjson.o
>    CC      net/net.o
>    CC      net/queue.o
>    CC      net/checksum.o
>    CC      net/hub.o
>    CC      net/util.o
>    CC      net/socket.o
>    CC      net/dump.o
>    CC      net/eth.o
>    CC      net/l2tpv3.o
>    CC      net/vhost-user.o
>    CC      net/slirp.o
>    CC      net/filter.o
>    CC      net/filter-mirror.o
>    CC      net/colo.o
>    CC      net/filter-replay.o
>    CC      net/filter-rewriter.o
>    CC      net/tap.o
>    CC      net/colo-compare.o
>    CC      net/filter-buffer.o
>    CC      net/tap-linux.o
>    CC      qom/cpu.o
>    CC      replay/replay.o
>    CC      replay/replay-internal.o
>    CC      replay/replay-events.o
>    CC      replay/replay-time.o
>    CC      replay/replay-input.o
> /tmp/qemu-test/src/replay/replay-internal.c: In function 'replay_put_array':
> /tmp/qemu-test/src/replay/replay-internal.c:65: warning: ignoring return value of 'fwrite', declared with attribute warn_unused_result
>    CC      replay/replay-snapshot.o
>    CC      replay/replay-char.o
>    CC      replay/replay-net.o
>    CC      replay/replay-audio.o
>    CC      slirp/cksum.o
>    CC      slirp/if.o
>    CC      slirp/ip_icmp.o
>    CC      slirp/ip6_icmp.o
>    CC      slirp/ip6_input.o
>    CC      slirp/ip6_output.o
>    CC      slirp/ip_input.o
>    CC      slirp/ip_output.o
>    CC      slirp/dnssearch.o
>    CC      slirp/dhcpv6.o
>    CC      slirp/slirp.o
>    CC      slirp/mbuf.o
>    CC      slirp/sbuf.o
>    CC      slirp/misc.o
>    CC      slirp/tcp_input.o
>    CC      slirp/socket.o
>    CC      slirp/tcp_output.o
>    CC      slirp/tcp_subr.o
>    CC      slirp/tcp_timer.o
>    CC      slirp/udp.o
>    CC      slirp/udp6.o
>    CC      slirp/bootp.o
>    CC      slirp/tftp.o
>    CC      slirp/arp_table.o
>    CC      slirp/ndp_table.o
>    CC      slirp/ncsi.o
> /tmp/qemu-test/src/slirp/tcp_input.c: In function 'tcp_input':
> /tmp/qemu-test/src/slirp/tcp_input.c:219: warning: 'save_ip.ip_p' may be used uninitialized in this function
> /tmp/qemu-test/src/slirp/tcp_input.c:219: warning: 'save_ip.ip_len' may be used uninitialized in this function
> /tmp/qemu-test/src/slirp/tcp_input.c:219: warning: 'save_ip.ip_tos' may be used uninitialized in this function
> /tmp/qemu-test/src/slirp/tcp_input.c:219: warning: 'save_ip.ip_id' may be used uninitialized in this function
> /tmp/qemu-test/src/slirp/tcp_input.c:219: warning: 'save_ip.ip_off' may be used uninitialized in this function
> /tmp/qemu-test/src/slirp/tcp_input.c:219: warning: 'save_ip.ip_ttl' may be used uninitialized in this function
> /tmp/qemu-test/src/slirp/tcp_input.c:219: warning: 'save_ip.ip_sum' may be used uninitialized in this function
> /tmp/qemu-test/src/slirp/tcp_input.c:219: warning: 'save_ip.ip_src.s_addr' may be used uninitialized in this function
> /tmp/qemu-test/src/slirp/tcp_input.c:219: warning: 'save_ip.ip_dst.s_addr' may be used uninitialized in this function
> /tmp/qemu-test/src/slirp/tcp_input.c:220: warning: 'save_ip6.ip_nh' may be used uninitialized in this function
>    CC      ui/console.o
>    CC      ui/keymaps.o
>    CC      ui/cursor.o
>    CC      ui/qemu-pixman.o
>    CC      ui/input.o
>    CC      ui/input-keymap.o
>    CC      ui/input-legacy.o
>    CC      ui/input-linux.o
>    CC      ui/spice-core.o
>    CC      ui/spice-input.o
>    CC      ui/spice-display.o
>    CC      ui/sdl.o
>    CC      ui/curses.o
>    CC      ui/vnc.o
>    CC      ui/sdl_zoom.o
>    CC      ui/x_keymap.o
>    CC      ui/vnc-enc-zlib.o
>    CC      ui/vnc-enc-hextile.o
>    CC      ui/vnc-enc-tight.o
>    CC      ui/vnc-palette.o
>    CC      ui/vnc-enc-zrle.o
>    CC      ui/vnc-auth-vencrypt.o
>    CC      ui/vnc-ws.o
>    CC      ui/vnc-jobs.o
>    CC      ui/gtk.o
>    VERT    ui/shader/texture-blit-vert.h
>    VERT    ui/shader/texture-blit-flip-vert.h
>    CC      ui/egl-helpers.o
>    FRAG    ui/shader/texture-blit-frag.h
>    CC      ui/console-gl.o
>    CC      ui/egl-context.o
>    CC      ui/gtk-egl.o
>    CC      chardev/char-fd.o
>    CC      chardev/char.o
>    CC      chardev/char-fe.o
>    CC      chardev/char-file.o
>    CC      chardev/char-io.o
>    CC      chardev/char-mux.o
> In file included from /usr/include/gtk-2.0/gtk/gtk.h:235,
>                   from /tmp/qemu-test/src/include/ui/gtk.h:10,
>                   from /tmp/qemu-test/src/ui/gtk.c:43:
> /usr/include/gtk-2.0/gtk/gtkitemfactory.h:47: warning: function declaration isn't a prototype
>    CC      chardev/char-null.o
>    CC      chardev/char-parallel.o
>    CC      chardev/char-pipe.o
>    CC      chardev/char-pty.o
>    CC      chardev/char-ringbuf.o
>    CC      chardev/char-serial.o
>    CC      chardev/char-socket.o
>    CC      chardev/char-stdio.o
>    CC      chardev/char-udp.o
>    LINK    tests/qemu-iotests/socket_scm_helper
>    CC      qga/commands.o
>    CC      qga/main.o
>    CC      qga/guest-agent-command-state.o
>    CC      qga/commands-posix.o
>    CC      qga/channel-posix.o
> In file included from /usr/include/gtk-2.0/gtk/gtk.h:235,
>                   from /tmp/qemu-test/src/include/ui/gtk.h:10,
>                   from /tmp/qemu-test/src/ui/gtk-egl.c:21:
> /usr/include/gtk-2.0/gtk/gtkitemfactory.h:47: warning: function declaration isn't a prototype
>    CC      qga/qapi-generated/qga-qapi-types.o
>    CC      qga/qapi-generated/qga-qapi-visit.o
>    CC      qga/qapi-generated/qga-qmp-marshal.o
>    AR      libqemuutil.a
>    CC      qemu-img.o
>    CC      ui/shader.o
>    AS      optionrom/multiboot.o
>    AS      optionrom/linuxboot.o
>    CC      optionrom/linuxboot_dma.o
>    AS      optionrom/kvmvapic.o
> cc: unrecognized option '-no-integrated-as'
> cc: unrecognized option '-no-integrated-as'
>    BUILD   optionrom/linuxboot_dma.img
>    BUILD   optionrom/linuxboot_dma.raw
>    SIGN    optionrom/linuxboot_dma.bin
>    LINK    qemu-ga
>    BUILD   optionrom/multiboot.img
>    BUILD   optionrom/linuxboot.img
>    BUILD   optionrom/kvmvapic.img
>    BUILD   optionrom/kvmvapic.raw
>    BUILD   optionrom/multiboot.raw
>    BUILD   optionrom/linuxboot.raw
>    SIGN    optionrom/kvmvapic.bin
>    SIGN    optionrom/multiboot.bin
>    SIGN    optionrom/linuxboot.bin
>    LINK    ivshmem-client
>    LINK    ivshmem-server
>    LINK    qemu-nbd
>    LINK    qemu-img
>    LINK    qemu-io
>    LINK    scsi/qemu-pr-helper
>    LINK    qemu-bridge-helper
>    GEN     aarch64-softmmu/hmp-commands.h
>    GEN     aarch64-softmmu/hmp-commands-info.h
>    GEN     aarch64-softmmu/config-target.h
>    CC      aarch64-softmmu/exec.o
>    CC      aarch64-softmmu/tcg/tcg-common.o
>    CC      aarch64-softmmu/tcg/optimize.o
>    CC      aarch64-softmmu/tcg/tcg-op.o
>    CC      aarch64-softmmu/fpu/softfloat.o
>    CC      aarch64-softmmu/tcg/tcg.o
>    CC      aarch64-softmmu/disas.o
>    GEN     aarch64-softmmu/gdbstub-xml.c
>    CC      aarch64-softmmu/arch_init.o
>    GEN     x86_64-softmmu/hmp-commands.h
>    CC      aarch64-softmmu/cpus.o
>    CC      aarch64-softmmu/monitor.o
>    CC      aarch64-softmmu/gdbstub.o
>    GEN     x86_64-softmmu/hmp-commands-info.h
>    CC      aarch64-softmmu/balloon.o
>    GEN     x86_64-softmmu/config-target.h
>    CC      aarch64-softmmu/ioport.o
>    CC      aarch64-softmmu/numa.o
>    CC      aarch64-softmmu/qtest.o
>    CC      aarch64-softmmu/memory.o
>    CC      aarch64-softmmu/dump.o
>    CC      aarch64-softmmu/migration/ram.o
>    CC      aarch64-softmmu/memory_mapping.o
>    CC      x86_64-softmmu/exec.o
>    CC      aarch64-softmmu/accel/accel.o
>    CC      aarch64-softmmu/accel/stubs/hax-stub.o
>    CC      aarch64-softmmu/accel/stubs/kvm-stub.o
>    CC      aarch64-softmmu/accel/tcg/tcg-all.o
>    CC      aarch64-softmmu/accel/tcg/cputlb.o
>    CC      x86_64-softmmu/tcg/tcg.o
>    CC      aarch64-softmmu/accel/tcg/tcg-runtime.o
>    CC      aarch64-softmmu/accel/tcg/cpu-exec.o
>    CC      x86_64-softmmu/tcg/optimize.o
>    CC      x86_64-softmmu/tcg/tcg-op.o
>    CC      x86_64-softmmu/tcg/tcg-common.o
>    CC      aarch64-softmmu/accel/tcg/cpu-exec-common.o
>    CC      aarch64-softmmu/accel/tcg/translate-all.o
>    CC      x86_64-softmmu/fpu/softfloat.o
>    CC      x86_64-softmmu/disas.o
>    CC      aarch64-softmmu/accel/tcg/translator.o
>    CC      aarch64-softmmu/hw/adc/stm32f2xx_adc.o
>    CC      aarch64-softmmu/hw/block/virtio-blk.o
>    CC      aarch64-softmmu/hw/block/dataplane/virtio-blk.o
>    GEN     x86_64-softmmu/gdbstub-xml.c
>    CC      x86_64-softmmu/arch_init.o
>    CC      x86_64-softmmu/cpus.o
>    CC      x86_64-softmmu/monitor.o
>    CC      aarch64-softmmu/hw/char/exynos4210_uart.o
>    CC      aarch64-softmmu/hw/char/omap_uart.o
>    CC      aarch64-softmmu/hw/char/digic-uart.o
>    CC      x86_64-softmmu/gdbstub.o
>    CC      aarch64-softmmu/hw/char/stm32f2xx_usart.o
>    CC      aarch64-softmmu/hw/char/bcm2835_aux.o
>    CC      x86_64-softmmu/balloon.o
>    CC      aarch64-softmmu/hw/char/virtio-serial-bus.o
>    CC      x86_64-softmmu/ioport.o
>    CC      x86_64-softmmu/numa.o
>    CC      x86_64-softmmu/qtest.o
>    CC      x86_64-softmmu/memory.o
>    CC      x86_64-softmmu/memory_mapping.o
>    CC      x86_64-softmmu/dump.o
>    CC      x86_64-softmmu/migration/ram.o
>    CC      x86_64-softmmu/accel/accel.o
>    CC      x86_64-softmmu/accel/kvm/kvm-all.o
>    CC      x86_64-softmmu/accel/stubs/hax-stub.o
>    CC      aarch64-softmmu/hw/core/generic-loader.o
>    CC      aarch64-softmmu/hw/core/null-machine.o
>    CC      aarch64-softmmu/hw/cpu/arm11mpcore.o
>    CC      aarch64-softmmu/hw/cpu/realview_mpcore.o
>    CC      aarch64-softmmu/hw/cpu/a9mpcore.o
>    CC      aarch64-softmmu/hw/cpu/a15mpcore.o
>    CC      aarch64-softmmu/hw/display/omap_dss.o
>    CC      x86_64-softmmu/accel/tcg/tcg-all.o
>    CC      aarch64-softmmu/hw/display/omap_lcdc.o
>    CC      x86_64-softmmu/accel/tcg/cputlb.o
>    CC      aarch64-softmmu/hw/display/pxa2xx_lcd.o
>    CC      x86_64-softmmu/accel/tcg/tcg-runtime.o
>    CC      aarch64-softmmu/hw/display/bcm2835_fb.o
>    CC      x86_64-softmmu/accel/tcg/cpu-exec.o
>    CC      aarch64-softmmu/hw/display/vga.o
>    CC      x86_64-softmmu/accel/tcg/cpu-exec-common.o
>    CC      aarch64-softmmu/hw/display/virtio-gpu.o
>    CC      x86_64-softmmu/accel/tcg/translate-all.o
>    CC      aarch64-softmmu/hw/display/virtio-gpu-3d.o
>    CC      aarch64-softmmu/hw/display/virtio-gpu-pci.o
>    CC      x86_64-softmmu/accel/tcg/translator.o
>    CC      x86_64-softmmu/hw/block/virtio-blk.o
>    CC      aarch64-softmmu/hw/display/dpcd.o
>    CC      x86_64-softmmu/hw/block/dataplane/virtio-blk.o
>    CC      x86_64-softmmu/hw/char/virtio-serial-bus.o
>    CC      aarch64-softmmu/hw/display/xlnx_dp.o
>    CC      x86_64-softmmu/hw/core/generic-loader.o
>    CC      aarch64-softmmu/hw/dma/xlnx_dpdma.o
>    CC      x86_64-softmmu/hw/core/null-machine.o
>    CC      aarch64-softmmu/hw/dma/omap_dma.o
>    CC      x86_64-softmmu/hw/display/vga.o
>    CC      x86_64-softmmu/hw/display/virtio-gpu.o
>    CC      x86_64-softmmu/hw/display/virtio-gpu-3d.o
>    CC      aarch64-softmmu/hw/dma/pxa2xx_dma.o
>    CC      aarch64-softmmu/hw/dma/soc_dma.o
>    CC      x86_64-softmmu/hw/display/virtio-gpu-pci.o
>    CC      aarch64-softmmu/hw/dma/bcm2835_dma.o
>    CC      x86_64-softmmu/hw/display/virtio-vga.o
>    CC      x86_64-softmmu/hw/intc/apic.o
>    CC      aarch64-softmmu/hw/gpio/omap_gpio.o
>    CC      aarch64-softmmu/hw/gpio/imx_gpio.o
>    CC      x86_64-softmmu/hw/intc/apic_common.o
>    CC      x86_64-softmmu/hw/intc/ioapic.o
>    CC      x86_64-softmmu/hw/isa/lpc_ich9.o
>    CC      x86_64-softmmu/hw/misc/vmport.o
>    CC      aarch64-softmmu/hw/gpio/bcm2835_gpio.o
>    CC      x86_64-softmmu/hw/misc/ivshmem.o
>    CC      x86_64-softmmu/hw/misc/pvpanic.o
>    CC      x86_64-softmmu/hw/misc/hyperv_testdev.o
>    CC      aarch64-softmmu/hw/i2c/omap_i2c.o
>    CC      x86_64-softmmu/hw/misc/mmio_interface.o
>    CC      x86_64-softmmu/hw/net/virtio-net.o
>    CC      aarch64-softmmu/hw/input/pxa2xx_keypad.o
>    CC      x86_64-softmmu/hw/net/vhost_net.o
>    CC      aarch64-softmmu/hw/input/tsc210x.o
>    CC      x86_64-softmmu/hw/scsi/virtio-scsi-dataplane.o
>    CC      x86_64-softmmu/hw/scsi/virtio-scsi.o
>    CC      x86_64-softmmu/hw/scsi/vhost-scsi-common.o
>    CC      aarch64-softmmu/hw/intc/armv7m_nvic.o
>    CC      x86_64-softmmu/hw/scsi/vhost-scsi.o
>    CC      x86_64-softmmu/hw/scsi/vhost-user-scsi.o
>    CC      x86_64-softmmu/hw/timer/mc146818rtc.o
>    CC      x86_64-softmmu/hw/vfio/common.o
>    CC      x86_64-softmmu/hw/vfio/pci.o
>    CC      x86_64-softmmu/hw/vfio/pci-quirks.o
>    CC      x86_64-softmmu/hw/vfio/platform.o
>    CC      aarch64-softmmu/hw/intc/exynos4210_combiner.o
>    CC      aarch64-softmmu/hw/intc/exynos4210_gic.o
>    CC      x86_64-softmmu/hw/vfio/spapr.o
>    CC      x86_64-softmmu/hw/virtio/virtio.o
>    CC      x86_64-softmmu/hw/virtio/virtio-balloon.o
>    CC      aarch64-softmmu/hw/intc/bcm2835_ic.o
>    CC      aarch64-softmmu/hw/intc/omap_intc.o
>    CC      aarch64-softmmu/hw/intc/bcm2836_control.o
>    CC      x86_64-softmmu/hw/virtio/vhost-backend.o
>    CC      aarch64-softmmu/hw/intc/allwinner-a10-pic.o
>    CC      x86_64-softmmu/hw/virtio/vhost-user.o
>    CC      x86_64-softmmu/hw/virtio/vhost.o
>    CC      x86_64-softmmu/hw/virtio/vhost-vsock.o
>    CC      x86_64-softmmu/hw/virtio/virtio-crypto.o
>    CC      x86_64-softmmu/hw/virtio/virtio-crypto-pci.o
>    CC      aarch64-softmmu/hw/intc/aspeed_vic.o
>    CC      x86_64-softmmu/hw/xen/xen-host-pci-device.o
>    CC      aarch64-softmmu/hw/intc/arm_gicv3_cpuif.o
>    CC      x86_64-softmmu/hw/xen/xen_pt.o
>    CC      x86_64-softmmu/hw/xen/xen_pt_config_init.o
>    CC      x86_64-softmmu/hw/xen/xen_pt_graphics.o
>    CC      x86_64-softmmu/hw/xen/xen_pt_msi.o
>    CC      x86_64-softmmu/hw/xen/xen_pt_load_rom.o
>    CC      x86_64-softmmu/hw/i386/multiboot.o
>    CC      aarch64-softmmu/hw/misc/ivshmem.o
>    CC      x86_64-softmmu/hw/i386/pc.o
>    CC      aarch64-softmmu/hw/misc/arm_sysctl.o
>    CC      x86_64-softmmu/hw/i386/pc_piix.o
>    CC      x86_64-softmmu/hw/i386/pc_q35.o
>    CC      x86_64-softmmu/hw/i386/pc_sysfw.o
> /tmp/qemu-test/src/hw/i386/pc_piix.c: In function 'igd_passthrough_isa_bridge_create':
> /tmp/qemu-test/src/hw/i386/pc_piix.c:1072: warning: 'pch_rev_id' may be used uninitialized in this function
>    CC      x86_64-softmmu/hw/i386/intel_iommu.o
>    CC      x86_64-softmmu/hw/i386/x86-iommu.o
>    CC      x86_64-softmmu/hw/i386/amd_iommu.o
>    CC      x86_64-softmmu/hw/i386/kvmvapic.o
>    CC      x86_64-softmmu/hw/i386/acpi-build.o
>    CC      x86_64-softmmu/hw/i386/../xenpv/xen_machine_pv.o
>    CC      aarch64-softmmu/hw/misc/cbus.o
>    CC      x86_64-softmmu/hw/i386/kvm/clock.o
>    CC      x86_64-softmmu/hw/i386/kvm/apic.o
> /tmp/qemu-test/src/hw/i386/acpi-build.c: In function 'build_append_pci_bus_devices':
> /tmp/qemu-test/src/hw/i386/acpi-build.c:509: warning: 'notify_method' may be used uninitialized in this function
>    CC      aarch64-softmmu/hw/misc/exynos4210_pmu.o
>    CC      x86_64-softmmu/hw/i386/kvm/i8259.o
>    CC      x86_64-softmmu/hw/i386/kvm/ioapic.o
>    CC      aarch64-softmmu/hw/misc/exynos4210_clk.o
>    CC      x86_64-softmmu/hw/i386/kvm/i8254.o
>    CC      aarch64-softmmu/hw/misc/exynos4210_rng.o
>    CC      x86_64-softmmu/hw/i386/xen/xen_platform.o
>    CC      x86_64-softmmu/hw/i386/xen/xen_apic.o
>    CC      aarch64-softmmu/hw/misc/imx_ccm.o
>    CC      x86_64-softmmu/hw/i386/xen/xen_pvdevice.o
>    CC      aarch64-softmmu/hw/misc/imx31_ccm.o
>    CC      aarch64-softmmu/hw/misc/imx25_ccm.o
>    CC      x86_64-softmmu/hw/i386/xen/xen-hvm.o
>    CC      aarch64-softmmu/hw/misc/imx6_ccm.o
>    CC      x86_64-softmmu/hw/i386/xen/xen-mapcache.o
>    CC      aarch64-softmmu/hw/misc/imx6_src.o
>    CC      x86_64-softmmu/target/i386/helper.o
>    CC      x86_64-softmmu/target/i386/cpu.o
>    CC      x86_64-softmmu/target/i386/gdbstub.o
>    CC      aarch64-softmmu/hw/misc/mst_fpga.o
>    CC      x86_64-softmmu/target/i386/xsave_helper.o
>    CC      x86_64-softmmu/target/i386/translate.o
>    CC      aarch64-softmmu/hw/misc/omap_clk.o
>    CC      x86_64-softmmu/target/i386/bpt_helper.o
>    CC      aarch64-softmmu/hw/misc/omap_gpmc.o
>    CC      aarch64-softmmu/hw/misc/omap_l4.o
>    CC      x86_64-softmmu/target/i386/cc_helper.o
>    CC      aarch64-softmmu/hw/misc/omap_sdrc.o
>    CC      x86_64-softmmu/target/i386/excp_helper.o
>    CC      aarch64-softmmu/hw/misc/omap_tap.o
>    CC      x86_64-softmmu/target/i386/fpu_helper.o
>    CC      aarch64-softmmu/hw/misc/bcm2835_mbox.o
>    CC      aarch64-softmmu/hw/misc/bcm2835_property.o
>    CC      aarch64-softmmu/hw/misc/bcm2835_rng.o
>    CC      aarch64-softmmu/hw/misc/zynq_slcr.o
>    CC      x86_64-softmmu/target/i386/int_helper.o
>    CC      x86_64-softmmu/target/i386/mem_helper.o
>    CC      aarch64-softmmu/hw/misc/zynq-xadc.o
>    CC      x86_64-softmmu/target/i386/misc_helper.o
>    CC      x86_64-softmmu/target/i386/mpx_helper.o
>    CC      aarch64-softmmu/hw/misc/stm32f2xx_syscfg.o
>    CC      aarch64-softmmu/hw/misc/mps2-scc.o
>    CC      x86_64-softmmu/target/i386/seg_helper.o
>    CC      x86_64-softmmu/target/i386/smm_helper.o
>    CC      aarch64-softmmu/hw/misc/auxbus.o
>    CC      x86_64-softmmu/target/i386/svm_helper.o
>    CC      aarch64-softmmu/hw/misc/aspeed_scu.o
>    CC      x86_64-softmmu/target/i386/machine.o
>    CC      aarch64-softmmu/hw/misc/aspeed_sdmc.o
>    CC      x86_64-softmmu/target/i386/arch_memory_mapping.o
>    CC      x86_64-softmmu/target/i386/arch_dump.o
>    CC      aarch64-softmmu/hw/misc/mmio_interface.o
>    CC      x86_64-softmmu/target/i386/monitor.o
>    CC      aarch64-softmmu/hw/misc/msf2-sysreg.o
>    CC      aarch64-softmmu/hw/net/virtio-net.o
>    CC      x86_64-softmmu/target/i386/hyperv.o
>    CC      x86_64-softmmu/target/i386/kvm.o
>    CC      aarch64-softmmu/hw/net/vhost_net.o
>    CC      aarch64-softmmu/hw/pcmcia/pxa2xx.o
>    CC      aarch64-softmmu/hw/scsi/virtio-scsi.o
>    CC      aarch64-softmmu/hw/scsi/virtio-scsi-dataplane.o
> make[1]: *** No rule to make target `../hw/pci-bridge/pcie_pci_bridge.o', needed by `qemu-system-x86_64'.  Stop.
> make[1]: *** Waiting for unfinished jobs....
>    CC      aarch64-softmmu/hw/scsi/vhost-scsi-common.o
>    CC      aarch64-softmmu/hw/scsi/vhost-scsi.o
>    CC      aarch64-softmmu/hw/scsi/vhost-user-scsi.o
>    CC      aarch64-softmmu/hw/sd/omap_mmc.o
>    CC      aarch64-softmmu/hw/sd/pxa2xx_mmci.o
>    CC      aarch64-softmmu/hw/sd/bcm2835_sdhost.o
> make: *** [subdir-x86_64-softmmu] Error 2
> make: *** Waiting for unfinished jobs....
>    CC      aarch64-softmmu/hw/ssi/omap_spi.o
>    CC      aarch64-softmmu/hw/ssi/imx_spi.o
>    CC      aarch64-softmmu/hw/timer/exynos4210_mct.o
>    CC      aarch64-softmmu/hw/timer/exynos4210_pwm.o
>    CC      aarch64-softmmu/hw/timer/exynos4210_rtc.o
>    CC      aarch64-softmmu/hw/timer/omap_gptimer.o
>    CC      aarch64-softmmu/hw/timer/omap_synctimer.o
>    CC      aarch64-softmmu/hw/timer/pxa2xx_timer.o
>    CC      aarch64-softmmu/hw/timer/digic-timer.o
>    CC      aarch64-softmmu/hw/timer/allwinner-a10-pit.o
>    CC      aarch64-softmmu/hw/usb/tusb6010.o
>    CC      aarch64-softmmu/hw/vfio/common.o
>    CC      aarch64-softmmu/hw/vfio/platform.o
>    CC      aarch64-softmmu/hw/vfio/pci.o
>    CC      aarch64-softmmu/hw/vfio/pci-quirks.o
>    CC      aarch64-softmmu/hw/vfio/calxeda-xgmac.o
>    CC      aarch64-softmmu/hw/vfio/amd-xgbe.o
>    CC      aarch64-softmmu/hw/vfio/spapr.o
>    CC      aarch64-softmmu/hw/virtio/virtio.o
>    CC      aarch64-softmmu/hw/virtio/virtio-balloon.o
>    CC      aarch64-softmmu/hw/virtio/vhost.o
>    CC      aarch64-softmmu/hw/virtio/vhost-backend.o
>    CC      aarch64-softmmu/hw/virtio/vhost-user.o
>    CC      aarch64-softmmu/hw/virtio/vhost-vsock.o
>    CC      aarch64-softmmu/hw/virtio/virtio-crypto.o
>    CC      aarch64-softmmu/hw/virtio/virtio-crypto-pci.o
>    CC      aarch64-softmmu/hw/arm/boot.o
>    CC      aarch64-softmmu/hw/arm/collie.o
>    CC      aarch64-softmmu/hw/arm/exynos4_boards.o
>    CC      aarch64-softmmu/hw/arm/gumstix.o
>    CC      aarch64-softmmu/hw/arm/highbank.o
>    CC      aarch64-softmmu/hw/arm/mainstone.o
>    CC      aarch64-softmmu/hw/arm/digic_boards.o
>    CC      aarch64-softmmu/hw/arm/musicpal.o
>    CC      aarch64-softmmu/hw/arm/integratorcp.o
>    CC      aarch64-softmmu/hw/arm/nseries.o
>    CC      aarch64-softmmu/hw/arm/omap_sx1.o
>    CC      aarch64-softmmu/hw/arm/palm.o
>    CC      aarch64-softmmu/hw/arm/realview.o
>    CC      aarch64-softmmu/hw/arm/spitz.o
>    CC      aarch64-softmmu/hw/arm/stellaris.o
>    CC      aarch64-softmmu/hw/arm/tosa.o
>    CC      aarch64-softmmu/hw/arm/versatilepb.o
>    CC      aarch64-softmmu/hw/arm/vexpress.o
>    CC      aarch64-softmmu/hw/arm/virt.o
>    CC      aarch64-softmmu/hw/arm/xilinx_zynq.o
>    CC      aarch64-softmmu/hw/arm/virt-acpi-build.o
>    CC      aarch64-softmmu/hw/arm/z2.o
>    CC      aarch64-softmmu/hw/arm/netduino2.o
>    CC      aarch64-softmmu/hw/arm/sysbus-fdt.o
>    CC      aarch64-softmmu/hw/arm/armv7m.o
>    CC      aarch64-softmmu/hw/arm/exynos4210.o
>    CC      aarch64-softmmu/hw/arm/pxa2xx.o
>    CC      aarch64-softmmu/hw/arm/pxa2xx_gpio.o
>    CC      aarch64-softmmu/hw/arm/pxa2xx_pic.o
>    CC      aarch64-softmmu/hw/arm/digic.o
>    CC      aarch64-softmmu/hw/arm/omap1.o
>    CC      aarch64-softmmu/hw/arm/omap2.o
>    CC      aarch64-softmmu/hw/arm/strongarm.o
>    CC      aarch64-softmmu/hw/arm/allwinner-a10.o
>    CC      aarch64-softmmu/hw/arm/cubieboard.o
>    CC      aarch64-softmmu/hw/arm/bcm2835_peripherals.o
>    CC      aarch64-softmmu/hw/arm/bcm2836.o
>    CC      aarch64-softmmu/hw/arm/raspi.o
>    CC      aarch64-softmmu/hw/arm/xlnx-zynqmp.o
>    CC      aarch64-softmmu/hw/arm/stm32f205_soc.o
>    CC      aarch64-softmmu/hw/arm/xlnx-zcu102.o
>    CC      aarch64-softmmu/hw/arm/imx25_pdk.o
>    CC      aarch64-softmmu/hw/arm/fsl-imx25.o
>    CC      aarch64-softmmu/hw/arm/fsl-imx31.o
>    CC      aarch64-softmmu/hw/arm/kzm.o
>    CC      aarch64-softmmu/hw/arm/fsl-imx6.o
>    CC      aarch64-softmmu/hw/arm/aspeed_soc.o
>    CC      aarch64-softmmu/hw/arm/aspeed.o
>    CC      aarch64-softmmu/hw/arm/sabrelite.o
>    CC      aarch64-softmmu/hw/arm/msf2-soc.o
>    CC      aarch64-softmmu/hw/arm/mps2.o
>    CC      aarch64-softmmu/hw/arm/msf2-som.o
>    CC      aarch64-softmmu/target/arm/arm-semi.o
>    CC      aarch64-softmmu/target/arm/machine.o
>    CC      aarch64-softmmu/target/arm/psci.o
>    CC      aarch64-softmmu/target/arm/arch_dump.o
>    CC      aarch64-softmmu/target/arm/monitor.o
>    CC      aarch64-softmmu/target/arm/kvm-stub.o
>    CC      aarch64-softmmu/target/arm/translate.o
>    CC      aarch64-softmmu/target/arm/op_helper.o
>    CC      aarch64-softmmu/target/arm/helper.o
>    CC      aarch64-softmmu/target/arm/cpu.o
>    CC      aarch64-softmmu/target/arm/neon_helper.o
>    CC      aarch64-softmmu/target/arm/iwmmxt_helper.o
>    CC      aarch64-softmmu/target/arm/gdbstub.o
>    CC      aarch64-softmmu/target/arm/cpu64.o
>    CC      aarch64-softmmu/target/arm/helper-a64.o
>    CC      aarch64-softmmu/target/arm/gdbstub64.o
>    CC      aarch64-softmmu/target/arm/crypto_helper.o
>    CC      aarch64-softmmu/target/arm/arm-powerctl.o
>    CC      aarch64-softmmu/target/arm/translate-a64.o
> make[1]: *** No rule to make target `../hw/pci-bridge/pcie_pci_bridge.o', needed by `qemu-system-aarch64'.  Stop.
> make[1]: *** Waiting for unfinished jobs..../tmp/qemu-test/src/target/arm/translate-a64.c: In function 'handle_shri_with_rndacc':
> /tmp/qemu-test/src/target/arm/translate-a64.c:6390: warning: 'tcg_src_hi' may be used uninitialized in this function
> /tmp/qemu-test/src/target/arm/translate-a64.c: In function 'disas_simd_scalar_two_reg_misc':
> /tmp/qemu-test/src/target/arm/translate-a64.c:8117: warning: 'rmode' may be used uninitialized in this function
> 
> make: *** [subdir-aarch64-softmmu] Error 2
> Traceback (most recent call last):
>    File "./tests/docker/docker.py", line 385, in <module>
>      sys.exit(main())
>    File "./tests/docker/docker.py", line 382, in main
>      return args.cmdobj.run(args, argv)
>    File "./tests/docker/docker.py", line 239, in run
>      return Docker().run(argv, args.keep, quiet=args.quiet)
>    File "./tests/docker/docker.py", line 207, in run
>      quiet=quiet)
>    File "./tests/docker/docker.py", line 125, in _do_check
>      return subprocess.check_call(self._command + cmd, **kwargs)
>    File "/usr/lib64/python2.7/subprocess.py", line 186, in check_call
>      raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['docker', 'run', '--label', 'com.qemu.instance.uuid=561e8180c54e11e79bd052540069c830', '-u', '0', '--security-opt', 'seccomp=unconfined', '--rm', '--net=none', '-e', 'TARGET_LIST=', '-e', 'EXTRA_CONFIGURE_OPTS=', '-e', 'V=', '-e', 'J=8', '-e', 'DEBUG=', '-e', 'SHOW_ENV=1', '-e', 'CCACHE_DIR=/var/tmp/ccache', '-v', '/root/.cache/qemu-docker-ccache:/var/tmp/ccache:z', '-v', '/var/tmp/patchew-tester-tmp-gp94i687/src/docker-src.2017-11-09-08.03.01.2879:/var/tmp/qemu:z,ro', 'qemu:centos6', '/var/tmp/qemu/run', 'test-quick']' returned non-zero exit status 2
> make[1]: *** [tests/docker/Makefile.include:129: docker-run] Error 1
> make[1]: Leaving directory '/var/tmp/patchew-tester-tmp-gp94i687/src'
> make: *** [tests/docker/Makefile.include:163: docker-run-test-quick@centos6] Error 2
> 
> real	1m28.235s
> user	0m4.283s
> sys	0m4.399s
> === OUTPUT END ===
> 
> Test command exited with code: 2
> 
> 
> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@freelists.org
> 

Hi Fam,

I can compile just fine in my workstation, can you
please advice ?

Thanks,
Marcel
