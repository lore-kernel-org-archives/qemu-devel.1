Received: from eggs.gnu.org ([2001:4830:134:3::10]:55528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gJWxf-0003Q2-Q5
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 23:58:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gJWxc-0006Tp-82
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 23:58:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:60936 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fli@suse.com>) id 1gJWxb-0006OE-Qh
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 23:58:00 -0500
References: <154126858595.25884.12979424396318824704@015909e0f939>
From: Fei Li <fli@suse.com>
Message-ID: <901f00a3-68dc-a63b-f1f4-f5a28af14e90@suse.com>
Date: Mon, 5 Nov 2018 12:57:48 +0800
MIME-Version: 1.0
In-Reply-To: <154126858595.25884.12979424396318824704@015909e0f939>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH RFC v7 0/9] qemu_thread_create: propagate
 errors to callers to check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, no-reply@patchew.org
Cc: famz@redhat.com, quintela@redhat.com, armbru@redhat.com, peterx@redhat.com, dgilbert@redhat.com

Sorry that somehow forget the "#include "qemu/error-report.h" for
hw/usb/ccid-card-emulated.c

Have a nice day, thanks
Fei

On 11/04/2018 02:09 AM, no-reply@patchew.org wrote:
> Hi,
>
> This series failed docker-quick@centos7 build test. Please find the testing commands and
> their output below. If you have Docker installed, you can probably reproduce it
> locally.
>
> Type: series
> Message-id: 20181101101715.9443-1-fli@suse.com
> Subject: [Qemu-devel] [PATCH RFC v7 0/9] qemu_thread_create: propagate errors to callers to check
>
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> time make docker-test-quick@centos7 SHOW_ENV=1 J=8
> === TEST SCRIPT END ===
>
> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> Switched to a new branch 'test'
> 8239f692a6 qemu_thread_create: propagate the error to callers to handle
> f73c91c32a migration: add more error handling for postcopy_ram_enable_notify
> 6b8c9d0a7b migration: remove unused &local_err parameter in migrate_set_error
> adcb648e2e migration: fix the multifd code when receiving less channels
> ce89d9baf9 migration: fix the multifd code when sending less channels
> a06e512206 migration: fix some segmentation faults when using multifd
> 7f516dc786 qemu_thread_join: fix segmentation fault
> a6f6f24ff3 qemu_init_vcpu: add a new Error parameter to propagate
> b44013aa26 Fix segmentation fault when qemu_signal_init fails
>
> === OUTPUT BEGIN ===
>    BUILD   centos7
> make[1]: Entering directory '/var/tmp/patchew-tester-tmp-6f6bzbwa/src'
>    GEN     /var/tmp/patchew-tester-tmp-6f6bzbwa/src/docker-src.2018-11-03-14.07.14.17130/qemu.tar
> Cloning into '/var/tmp/patchew-tester-tmp-6f6bzbwa/src/docker-src.2018-11-03-14.07.14.17130/qemu.tar.vroot'...
> done.
> Your branch is up-to-date with 'origin/test'.
> Submodule 'dtc' (git://git.qemu-project.org/dtc.git) registered for path 'dtc'
> Cloning into '/var/tmp/patchew-tester-tmp-6f6bzbwa/src/docker-src.2018-11-03-14.07.14.17130/qemu.tar.vroot/dtc'...
> Submodule path 'dtc': checked out '88f18909db731a627456f26d779445f84e449536'
> Submodule 'ui/keycodemapdb' (git://git.qemu.org/keycodemapdb.git) registered for path 'ui/keycodemapdb'
> Cloning into '/var/tmp/patchew-tester-tmp-6f6bzbwa/src/docker-src.2018-11-03-14.07.14.17130/qemu.tar.vroot/ui/keycodemapdb'...
> Submodule path 'ui/keycodemapdb': checked out '6b3d716e2b6472eb7189d3220552280ef3d832ce'
>    COPY    RUNNER
>      RUN test-quick in qemu:centos7
> Packages installed:
> SDL-devel-1.2.15-14.el7.x86_64
> bison-3.0.4-1.el7.x86_64
> bzip2-1.0.6-13.el7.x86_64
> bzip2-devel-1.0.6-13.el7.x86_64
> ccache-3.3.4-1.el7.x86_64
> csnappy-devel-0-6.20150729gitd7bc683.el7.x86_64
> flex-2.5.37-3.el7.x86_64
> gcc-4.8.5-28.el7_5.1.x86_64
> gettext-0.19.8.1-2.el7.x86_64
> git-1.8.3.1-14.el7_5.x86_64
> glib2-devel-2.54.2-2.el7.x86_64
> libaio-devel-0.3.109-13.el7.x86_64
> libepoxy-devel-1.3.1-2.el7_5.x86_64
> libfdt-devel-1.4.6-1.el7.x86_64
> lzo-devel-2.06-8.el7.x86_64
> make-3.82-23.el7.x86_64
> mesa-libEGL-devel-17.2.3-8.20171019.el7.x86_64
> mesa-libgbm-devel-17.2.3-8.20171019.el7.x86_64
> nettle-devel-2.7.1-8.el7.x86_64
> package g++ is not installed
> package librdmacm-devel is not installed
> pixman-devel-0.34.0-1.el7.x86_64
> spice-glib-devel-0.34-3.el7_5.1.x86_64
> spice-server-devel-0.14.0-2.el7_5.4.x86_64
> tar-1.26-34.el7.x86_64
> vte-devel-0.28.2-10.el7.x86_64
> xen-devel-4.6.6-12.el7.x86_64
> zlib-devel-1.2.7-17.el7.x86_64
>
> Environment variables:
> PACKAGES=bison     bzip2     bzip2-devel     ccache     csnappy-devel     flex     g++     gcc     gettext     git     glib2-devel     libaio-devel     libepoxy-devel     libfdt-devel     librdmacm-devel     lzo-devel     make     mesa-libEGL-devel     mesa-libgbm-devel     nettle-devel     pixman-devel     SDL-devel     spice-glib-devel     spice-server-devel     tar     vte-devel     xen-devel     zlib-devel
> HOSTNAME=ec6a074d2e2d
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
> HOME=/home/patchew
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
> QEMU_CFLAGS       -I/usr/include/pixman-1    -Werror   -pthread -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include   -fPIE -DPIE -m64 -mcx16 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-prototypes -fno-strict-aliasing -fno-common -fwrapv  -Wendif-labels -Wno-missing-include-dirs -Wempty-body -Wnested-externs -Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers -Wold-style-declaration -Wold-style-definition -Wtype-limits -fstack-protector-strong -Wno-missing-braces   -I/usr/include/libpng15     -pthread -I/usr/include/spice-server -I/usr/include/cacard -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include -I/usr/include/pixman-1 -I/usr/include/nss3 -I/usr/include/nspr4 -I/usr/include/spice-1
> LDFLAGS           -Wl,--warn-common -Wl,-z,relro -Wl,-z,now -pie -m64 -g
> QEMU_LDFLAGS
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
> SDL support       yes (1.2.15)
> GTK support       no
> GTK GL support    no
> VTE support       no
> TLS priority      NORMAL
> GNUTLS support    no
> libgcrypt         no
> nettle            yes (2.7.1)
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
> VNC JPEG support  no
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
> RDMA support      yes
> PVRDMA support    yes
> fdt support       system
> membarrier        no
> preadv support    yes
> fdatasync         yes
> madvise           yes
> posix_madvise     yes
> posix_memalign    yes
> libcap-ng support no
> vhost-net support yes
> vhost-crypto support yes
> vhost-scsi support yes
> vhost-vsock support yes
> vhost-user support yes
> Trace backends    log
> spice support     yes (0.12.13/0.14.0)
> rbd support       no
> xfsctl support    no
> smartcard support yes
> libusb            no
> usb net redir     no
> OpenGL support    yes
> OpenGL dmabufs    yes
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
> mutex debugging   no
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
> libxml2           no
> tcmalloc support  no
> jemalloc support  no
> avx2 optimization yes
> replication support yes
> VxHS block device no
> capstone          no
> docker            no
> libpmem support   no
> libudev           no
>
> WARNING: Use of SDL 1.2 is deprecated and will be removed in
> WARNING: future releases. Please switch to using SDL 2.0
>
> NOTE: cross-compilers enabled:  'cc'
>    GEN     x86_64-softmmu/config-devices.mak.tmp
>    GEN     aarch64-softmmu/config-devices.mak.tmp
>    GEN     config-host.h
>    GEN     qemu-options.def
>    GEN     qapi-gen
>    GEN     trace/generated-tcg-tracers.h
>    GEN     trace/generated-helpers-wrappers.h
>    GEN     trace/generated-helpers.h
>    GEN     trace/generated-helpers.c
>    GEN     module_block.h
>    GEN     x86_64-softmmu/config-devices.mak
>    GEN     aarch64-softmmu/config-devices.mak
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
>    GEN     hw/watchdog/trace.h
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
>    GEN     hw/watchdog/trace.c
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
>    CC      tests/qemu-iotests/socket_scm_helper.o
>    GEN     qga/qapi-generated/qapi-gen
>    CC      qapi/qapi-builtin-types.o
>    CC      qapi/qapi-types.o
>    CC      qapi/qapi-types-block-core.o
>    CC      qapi/qapi-types-block.o
>    CC      qapi/qapi-types-char.o
>    CC      qapi/qapi-types-common.o
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
>    CC      qapi/qapi-types-trace.o
>    CC      qapi/qapi-types-transaction.o
>    CC      qapi/qapi-types-ui.o
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
>    CC      qapi/qapi-visit-ui.o
>    CC      qapi/qapi-events.o
>    CC      qapi/qapi-events-block-core.o
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
>    CC      qapi/qapi-events-run-state.o
>    CC      qapi/qapi-events-sockets.o
>    CC      qapi/qapi-events-tpm.o
>    CC      qapi/qapi-events-trace.o
>    CC      qapi/qapi-events-transaction.o
>    CC      qapi/qapi-events-ui.o
>    CC      qapi/qapi-introspect.o
>    CC      qapi/qapi-dealloc-visitor.o
>    CC      qapi/qapi-visit-core.o
>    CC      qapi/qobject-input-visitor.o
>    CC      qapi/qobject-output-visitor.o
>    CC      qapi/qmp-registry.o
>    CC      qapi/qmp-dispatch.o
>    CC      qapi/string-input-visitor.o
>    CC      qapi/string-output-visitor.o
>    CC      qapi/opts-visitor.o
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
>    CC      trace/control.o
>    CC      trace/qmp.o
>    CC      util/osdep.o
>    CC      util/cutils.o
>    CC      util/unicode.o
>    CC      util/qemu-timer-common.o
>    CC      util/bufferiszero.o
>    CC      util/lockcnt.o
>    CC      util/aiocb.o
>    CC      util/async.o
>    CC      util/aio-wait.o
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
>    CC      util/acl.o
>    CC      util/cacheinfo.o
>    CC      util/error.o
>    CC      util/qemu-error.o
>    CC      util/id.o
>    CC      util/iov.o
>    CC      util/qemu-config.o
>    CC      util/qemu-sockets.o
>    CC      util/uri.o
>    CC      util/notify.o
>    CC      util/qemu-option.o
>    CC      util/qemu-progress.o
>    CC      util/keyval.o
>    CC      util/hexdump.o
>    CC      util/crc32c.o
>    CC      util/uuid.o
>    CC      util/throttle.o
>    CC      util/getauxval.o
>    CC      util/readline.o
>    CC      util/rcu.o
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
>    CC      util/qsp.o
>    CC      util/range.o
>    CC      util/stats64.o
>    CC      util/systemd.o
>    CC      util/iova-tree.o
>    CC      util/vfio-helpers.o
>    CC      util/drm.o
>    CC      trace-root.o
>    CC      accel/kvm/trace.o
>    CC      accel/tcg/trace.o
>    CC      audio/trace.o
>    CC      block/trace.o
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
>    CC      hw/ppc/trace.o
>    CC      hw/rdma/trace.o
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
>    CC      hw/watchdog/trace.o
>    CC      hw/xen/trace.o
>    CC      io/trace.o
>    CC      linux-user/trace.o
>    CC      migration/trace.o
>    CC      nbd/trace.o
>    CC      net/trace.o
>    CC      qapi/trace.o
>    CC      qom/trace.o
>    CC      scsi/trace.o
>    CC      target/arm/trace.o
>    CC      target/i386/trace.o
>    CC      target/mips/trace.o
>    CC      target/ppc/trace.o
>    CC      target/s390x/trace.o
>    CC      target/sparc/trace.o
>    CC      ui/trace.o
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
>    CC      stubs/dump.o
>    CC      stubs/error-printf.o
>    CC      stubs/fdset.o
>    CC      stubs/gdbstub.o
>    CC      stubs/get-vm-name.o
>    CC      stubs/iothread.o
>    CC      stubs/iothread-lock.o
>    CC      stubs/is-daemonized.o
>    CC      stubs/linux-aio.o
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
>    CC      stubs/qmp_memory_device.o
>    CC      stubs/target-monitor-defs.o
>    CC      stubs/target-get-monitor-def.o
>    CC      stubs/pc_madt_cpu_entry.o
>    CC      stubs/vmgenid.o
>    CC      stubs/xen-common.o
>    CC      stubs/xen-hvm.o
>    CC      stubs/pci-host-piix.o
>    CC      stubs/ram-block.o
>    CC      stubs/ramfb.o
>    CC      contrib/ivshmem-client/ivshmem-client.o
>    CC      contrib/ivshmem-client/main.o
>    CC      contrib/ivshmem-server/ivshmem-server.o
>    CC      contrib/ivshmem-server/main.o
>    CC      qemu-nbd.o
>    CC      block.o
>    CC      blockjob.o
>    CC      job.o
>    CC      qemu-io-cmds.o
>    CC      replication.o
>    CC      block/raw-format.o
>    CC      block/qcow.o
>    CC      block/vdi.o
>    CC      block/vmdk.o
>    CC      block/cloop.o
>    CC      block/bochs.o
>    CC      block/vpc.o
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
>    CC      block/qapi.o
>    CC      block/file-posix.o
>    CC      block/linux-aio.o
>    CC      block/null.o
>    CC      block/mirror.o
>    CC      block/commit.o
>    CC      block/io.o
>    CC      block/create.o
>    CC      block/throttle-groups.o
>    CC      block/nvme.o
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
>    CC      nbd/server.o
>    CC      nbd/client.o
>    CC      nbd/common.o
>    CC      scsi/utils.o
>    CC      scsi/pr-manager.o
>    CC      scsi/pr-manager-helper.o
>    CC      block/dmg-bz2.o
>    CC      crypto/init.o
>    CC      crypto/hash.o
>    CC      crypto/hash-nettle.o
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
>    CC      crypto/random-platform.o
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
>    GEN     qemu-img-cmds.h
>    CC      qemu-io.o
>    CC      qemu-edid.o
>    CC      hw/display/edid-generate.o
>    CC      scsi/qemu-pr-helper.o
>    CC      qemu-bridge-helper.o
>    CC      blockdev.o
>    CC      blockdev-nbd.o
>    CC      bootdevice.o
>    CC      iothread.o
>    CC      job-qmp.o
>    CC      qdev-monitor.o
>    CC      device-hotplug.o
>    CC      os-posix.o
>    CC      bt-host.o
>    CC      bt-vhci.o
>    CC      dma-helpers.o
>    CC      vl.o
>    CC      tpm.o
>    CC      device_tree.o
>    CC      qapi/qapi-commands.o
>    CC      qapi/qapi-commands-block-core.o
>    CC      qapi/qapi-commands-block.o
>    CC      qapi/qapi-commands-char.o
>    CC      qapi/qapi-commands-common.o
>    CC      qapi/qapi-commands-crypto.o
>    CC      qapi/qapi-commands-introspect.o
>    CC      qapi/qapi-commands-job.o
>    CC      qapi/qapi-commands-migration.o
>    CC      qapi/qapi-commands-net.o
>    CC      qapi/qapi-commands-misc.o
>    CC      qapi/qapi-commands-rocker.o
>    CC      qapi/qapi-commands-run-state.o
>    CC      qapi/qapi-commands-sockets.o
>    CC      qapi/qapi-commands-tpm.o
>    CC      qapi/qapi-commands-trace.o
>    CC      qapi/qapi-commands-transaction.o
>    CC      qapi/qapi-commands-ui.o
>    CC      qmp.o
>    CC      hmp.o
>    CC      cpus-common.o
>    CC      audio/audio.o
>    CC      audio/noaudio.o
>    CC      audio/wavaudio.o
>    CC      audio/mixeng.o
>    CC      audio/spiceaudio.o
>    CC      audio/wavcapture.o
>    CC      backends/rng.o
>    CC      backends/rng-egd.o
>    CC      backends/rng-random.o
>    CC      backends/tpm.o
>    CC      backends/hostmem.o
>    CC      backends/hostmem-ram.o
>    CC      backends/hostmem-file.o
>    CC      backends/cryptodev.o
>    CC      backends/cryptodev-builtin.o
>    CC      backends/cryptodev-vhost.o
>    CC      backends/cryptodev-vhost-user.o
>    CC      backends/hostmem-memfd.o
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
>    CC      hw/acpi/tco.o
>    CC      hw/acpi/cpu_hotplug.o
>    CC      hw/acpi/memory_hotplug.o
>    CC      hw/acpi/cpu.o
>    CC      hw/acpi/nvdimm.o
>    CC      hw/acpi/vmgenid.o
>    CC      hw/acpi/acpi_interface.o
>    CC      hw/acpi/bios-linker-loader.o
>    CC      hw/acpi/aml-build.o
>    CC      hw/acpi/ipmi.o
>    CC      hw/acpi/acpi-stub.o
>    CC      hw/acpi/ipmi-stub.o
>    CC      hw/audio/sb16.o
>    CC      hw/audio/es1370.o
>    CC      hw/audio/ac97.o
>    CC      hw/audio/fmopl.o
>    CC      hw/audio/adlib.o
>    CC      hw/audio/gus.o
>    CC      hw/audio/gusemu_hal.o
>    CC      hw/audio/gusemu_mixer.o
>    CC      hw/audio/cs4231a.o
>    CC      hw/audio/intel-hda.o
>    CC      hw/audio/hda-codec.o
>    CC      hw/audio/pcspk.o
>    CC      hw/audio/wm8750.o
>    CC      hw/audio/pl041.o
>    CC      hw/audio/lm4549.o
>    CC      hw/audio/marvell_88w8618.o
>    CC      hw/audio/soundhw.o
>    CC      hw/block/block.o
>    CC      hw/block/cdrom.o
>    CC      hw/block/hd-geometry.o
>    CC      hw/block/fdc.o
>    CC      hw/block/m25p80.o
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
>    CC      hw/bt/hid.o
>    CC      hw/bt/hci-csr.o
>    CC      hw/char/ipoctal232.o
>    CC      hw/char/parallel.o
>    CC      hw/char/parallel-isa.o
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
>    CC      hw/core/qdev-properties.o
>    CC      hw/core/bus.o
>    CC      hw/core/reset.o
>    CC      hw/core/qdev-fw.o
>    CC      hw/core/fw-path-provider.o
>    CC      hw/core/irq.o
>    CC      hw/core/hotplug.o
>    CC      hw/core/nmi.o
>    CC      hw/core/stream.o
>    CC      hw/core/ptimer.o
>    CC      hw/core/sysbus.o
>    CC      hw/core/machine.o
>    CC      hw/core/loader.o
>    CC      hw/core/qdev-properties-system.o
>    CC      hw/core/register.o
>    CC      hw/core/or-irq.o
>    CC      hw/core/split-irq.o
>    CC      hw/core/platform-bus.o
>    CC      hw/core/generic-loader.o
>    CC      hw/core/null-machine.o
>    CC      hw/cpu/core.o
>    CC      hw/display/ramfb.o
>    CC      hw/display/ramfb-standalone.o
>    CC      hw/display/ads7846.o
>    CC      hw/display/cirrus_vga.o
>    CC      hw/display/cirrus_vga_isa.o
>    CC      hw/display/pl110.o
>    CC      hw/display/sii9022.o
>    CC      hw/display/ssd0303.o
>    CC      hw/display/ssd0323.o
>    CC      hw/display/xenfb.o
>    CC      hw/display/vga-pci.o
>    CC      hw/display/edid-region.o
>    CC      hw/display/vga-isa.o
>    CC      hw/display/vmware_vga.o
>    CC      hw/display/bochs-display.o
>    CC      hw/display/blizzard.o
>    CC      hw/display/exynos4210_fimd.o
>    CC      hw/display/framebuffer.o
>    CC      hw/display/tc6393xb.o
>    CC      hw/display/qxl.o
>    CC      hw/display/qxl-logger.o
>    CC      hw/display/qxl-render.o
>    CC      hw/dma/pl080.o
>    CC      hw/dma/pl330.o
>    CC      hw/dma/i8257.o
>    CC      hw/dma/xilinx_axidma.o
>    CC      hw/dma/xlnx-zynq-devcfg.o
>    CC      hw/dma/xlnx-zdma.o
>    CC      hw/gpio/max7310.o
>    CC      hw/gpio/pl061.o
>    CC      hw/gpio/zaurus.o
>    CC      hw/gpio/gpio_key.o
>    CC      hw/i2c/core.o
>    CC      hw/i2c/smbus.o
>    CC      hw/i2c/smbus_eeprom.o
>    CC      hw/i2c/versatile_i2c.o
>    CC      hw/i2c/i2c-ddc.o
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
>    CC      hw/ide/isa.o
>    CC      hw/ide/piix.o
>    CC      hw/ide/microdrive.o
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
>    CC      hw/input/virtio-input.o
>    CC      hw/input/virtio-input-hid.o
>    CC      hw/input/virtio-input-host.o
>    CC      hw/intc/i8259_common.o
>    CC      hw/intc/i8259.o
>    CC      hw/intc/pl190.o
>    CC      hw/intc/xlnx-pmu-iomod-intc.o
>    CC      hw/intc/xlnx-zynqmp-ipi.o
>    CC      hw/intc/imx_avic.o
>    CC      hw/intc/imx_gpcv2.o
>    CC      hw/intc/realview_gic.o
>    CC      hw/intc/ioapic_common.o
>    CC      hw/intc/arm_gic_common.o
>    CC      hw/intc/arm_gic.o
>    CC      hw/intc/arm_gicv2m.o
>    CC      hw/intc/arm_gicv3_common.o
>    CC      hw/intc/arm_gicv3.o
>    CC      hw/intc/arm_gicv3_dist.o
>    CC      hw/intc/arm_gicv3_redist.o
>    CC      hw/intc/arm_gicv3_its_common.o
>    CC      hw/intc/intc.o
>    CC      hw/ipack/ipack.o
>    CC      hw/ipack/tpci200.o
>    CC      hw/ipmi/ipmi.o
>    CC      hw/ipmi/ipmi_bmc_sim.o
>    CC      hw/ipmi/ipmi_bmc_extern.o
>    CC      hw/ipmi/isa_ipmi_kcs.o
>    CC      hw/ipmi/isa_ipmi_bt.o
>    CC      hw/isa/isa-bus.o
>    CC      hw/isa/isa-superio.o
>    CC      hw/isa/apm.o
>    CC      hw/mem/pc-dimm.o
>    CC      hw/mem/memory-device.o
>    CC      hw/mem/nvdimm.o
>    CC      hw/misc/applesmc.o
>    CC      hw/misc/max111x.o
>    CC      hw/misc/tmp105.o
>    CC      hw/misc/tmp421.o
>    CC      hw/misc/debugexit.o
>    CC      hw/misc/sga.o
>    CC      hw/misc/pc-testdev.o
>    CC      hw/misc/pci-testdev.o
>    CC      hw/misc/edu.o
>    CC      hw/misc/pca9552.o
>    CC      hw/misc/unimp.o
>    CC      hw/misc/vmcoreinfo.o
>    CC      hw/misc/arm_l2x0.o
>    CC      hw/misc/arm_integrator_debug.o
>    CC      hw/misc/a9scu.o
>    CC      hw/net/xen_nic.o
>    CC      hw/misc/arm11scu.o
>    CC      hw/net/ne2000.o
>    CC      hw/net/eepro100.o
>    CC      hw/net/pcnet-pci.o
>    CC      hw/net/pcnet.o
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
>    CC      hw/net/xilinx_axienet.o
>    CC      hw/net/allwinner_emac.o
>    CC      hw/net/imx_fec.o
>    CC      hw/net/cadence_gem.o
>    CC      hw/net/stellaris_enet.o
>    CC      hw/net/ftgmac100.o
>    CC      hw/net/rocker/rocker.o
>    CC      hw/net/rocker/rocker_fp.o
>    CC      hw/net/rocker/rocker_desc.o
>    CC      hw/net/rocker/rocker_world.o
>    CC      hw/net/rocker/rocker_of_dpa.o
>    CC      hw/net/can/can_sja1000.o
>    CC      hw/net/can/can_kvaser_pci.o
>    CC      hw/net/can/can_pcm3680_pci.o
>    CC      hw/net/can/can_mioe3680_pci.o
>    CC      hw/nvram/eeprom93xx.o
>    CC      hw/nvram/fw_cfg.o
>    CC      hw/nvram/chrp_nvram.o
>    CC      hw/pci-bridge/pci_bridge_dev.o
>    CC      hw/pci-bridge/pcie_root_port.o
>    CC      hw/pci-bridge/gen_pcie_root_port.o
>    CC      hw/pci-bridge/pcie_pci_bridge.o
>    CC      hw/pci-bridge/pci_expander_bridge.o
>    CC      hw/pci-bridge/xio3130_upstream.o
>    CC      hw/pci-bridge/xio3130_downstream.o
>    CC      hw/pci-bridge/ioh3420.o
>    CC      hw/pci-bridge/i82801b11.o
>    CC      hw/pci-host/pam.o
>    CC      hw/pci-host/versatile.o
>    CC      hw/pci-host/piix.o
>    CC      hw/pci-host/q35.o
>    CC      hw/pci-host/gpex.o
>    CC      hw/pci-host/designware.o
>    CC      hw/pci/pci.o
>    CC      hw/pci/pci_bridge.o
>    CC      hw/pci/msix.o
>    CC      hw/pci/msi.o
>    CC      hw/pci/shpc.o
>    CC      hw/pci/slotid_cap.o
>    CC      hw/pci/pci_host.o
>    CC      hw/pci/pcie_host.o
>    CC      hw/pci/pcie.o
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
>    CC      hw/scsi/esp.o
>    CC      hw/scsi/esp-pci.o
>    CC      hw/sd/pl181.o
>    CC      hw/sd/ssi-sd.o
>    CC      hw/sd/sd.o
>    CC      hw/sd/core.o
>    CC      hw/sd/sdmmc-internal.o
>    CC      hw/sd/sdhci.o
>    CC      hw/smbios/smbios.o
>    CC      hw/smbios/smbios_type_38.o
>    CC      hw/smbios/smbios-stub.o
>    CC      hw/smbios/smbios_type_38-stub.o
>    CC      hw/ssi/pl022.o
>    CC      hw/ssi/ssi.o
>    CC      hw/ssi/xilinx_spips.o
>    CC      hw/ssi/aspeed_smc.o
>    CC      hw/ssi/stm32f2xx_spi.o
>    CC      hw/ssi/mss-spi.o
>    CC      hw/timer/arm_timer.o
>    CC      hw/timer/arm_mptimer.o
>    CC      hw/timer/armv7m_systick.o
>    CC      hw/timer/a9gtimer.o
>    CC      hw/timer/cadence_ttc.o
>    CC      hw/timer/ds1338.o
>    CC      hw/timer/hpet.o
>    CC      hw/timer/i8254_common.o
>    CC      hw/timer/i8254.o
>    CC      hw/timer/pl031.o
>    CC      hw/timer/twl92230.o
>    CC      hw/timer/imx_epit.o
>    CC      hw/timer/imx_gpt.o
>    CC      hw/timer/xlnx-zynqmp-rtc.o
>    CC      hw/timer/stm32f2xx_timer.o
>    CC      hw/timer/aspeed_timer.o
>    CC      hw/timer/cmsdk-apb-timer.o
>    CC      hw/timer/cmsdk-apb-dualtimer.o
>    CC      hw/timer/mss-timer.o
>    CC      hw/tpm/tpm_util.o
>    CC      hw/tpm/tpm_tis.o
>    CC      hw/tpm/tpm_crb.o
>    CC      hw/tpm/tpm_passthrough.o
>    CC      hw/tpm/tpm_emulator.o
>    CC      hw/usb/core.o
>    CC      hw/usb/combined-packet.o
>    CC      hw/usb/bus.o
>    CC      hw/usb/libhw.o
>    CC      hw/usb/desc.o
>    CC      hw/usb/desc-msos.o
>    CC      hw/usb/hcd-uhci.o
>    CC      hw/usb/hcd-ohci.o
>    CC      hw/usb/hcd-ehci.o
>    CC      hw/usb/hcd-ehci-pci.o
>    CC      hw/usb/hcd-ehci-sysbus.o
>    CC      hw/usb/hcd-xhci.o
>    CC      hw/usb/hcd-xhci-nec.o
>    CC      hw/usb/hcd-musb.o
>    CC      hw/usb/dev-hub.o
>    CC      hw/usb/dev-hid.o
>    CC      hw/usb/dev-wacom.o
>    CC      hw/usb/dev-storage.o
>    CC      hw/usb/dev-uas.o
>    CC      hw/usb/dev-audio.o
>    CC      hw/usb/dev-serial.o
>    CC      hw/usb/dev-network.o
>    CC      hw/usb/dev-bluetooth.o
>    CC      hw/usb/dev-smartcard-reader.o
>    CC      hw/usb/ccid-card-passthru.o
>    CC      hw/usb/ccid-card-emulated.o
>    CC      hw/usb/dev-mtp.o
>    CC      hw/usb/host-stub.o
>    CC      hw/virtio/virtio-bus.o
>    CC      hw/virtio/virtio-rng.o
> /tmp/qemu-test/src/hw/usb/ccid-card-emulated.c: In function 'emulated_realize':
> /tmp/qemu-test/src/hw/usb/ccid-card-emulated.c:549:9: error: implicit declaration of function 'error_report' [-Werror=implicit-function-declaration]
>           error_report("failed to create event_thread");
>           ^
> /tmp/qemu-test/src/hw/usb/ccid-card-emulated.c:549:9: error: nested extern declaration of 'error_report' [-Werror=nested-externs]
> cc1: all warnings being treated as errors
> make: *** [hw/usb/ccid-card-emulated.o] Error 1
> make: *** Waiting for unfinished jobs....
> Traceback (most recent call last):
>    File "./tests/docker/docker.py", line 563, in <module>
>      sys.exit(main())
>    File "./tests/docker/docker.py", line 560, in main
>      return args.cmdobj.run(args, argv)
>    File "./tests/docker/docker.py", line 306, in run
>      return Docker().run(argv, args.keep, quiet=args.quiet)
>    File "./tests/docker/docker.py", line 274, in run
>      quiet=quiet)
>    File "./tests/docker/docker.py", line 181, in _do_check
>      return subprocess.check_call(self._command + cmd, **kwargs)
>    File "/usr/lib64/python2.7/subprocess.py", line 186, in check_call
>      raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['sudo', '-n', 'docker', 'run', '--label', 'com.qemu.instance.uuid=53298fa0df9311e8a18952540069c830', '-u', '1000', '--security-opt', 'seccomp=unconfined', '--rm', '--net=none', '-e', 'TARGET_LIST=', '-e', 'EXTRA_CONFIGURE_OPTS=', '-e', 'V=', '-e', 'J=8', '-e', 'DEBUG=', '-e', 'SHOW_ENV=1', '-e', 'CCACHE_DIR=/var/tmp/ccache', '-v', '/home/patchew/.cache/qemu-docker-ccache:/var/tmp/ccache:z', '-v', '/var/tmp/patchew-tester-tmp-6f6bzbwa/src/docker-src.2018-11-03-14.07.14.17130:/var/tmp/qemu:z,ro', 'qemu:centos7', '/var/tmp/qemu/run', 'test-quick']' returned non-zero exit status 2
> make[1]: *** [tests/docker/Makefile.include:217: docker-run] Error 1
> make[1]: Leaving directory '/var/tmp/patchew-tester-tmp-6f6bzbwa/src'
> make: *** [tests/docker/Makefile.include:251: docker-run-test-quick@centos7] Error 2
>
> real	2m27.767s
> user	0m5.117s
> sys	0m3.918s
> === OUTPUT END ===
>
> Test command exited with code: 2
>
>
> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com
