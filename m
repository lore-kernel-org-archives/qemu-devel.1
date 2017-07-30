Received: from eggs.gnu.org ([2001:4830:134:3::10]:41860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dbneM-0005ip-VS
	for qemu-devel@nongnu.org; Sun, 30 Jul 2017 08:48:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dbneI-0000Mv-TU
	for qemu-devel@nongnu.org; Sun, 30 Jul 2017 08:48:51 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:45572)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dbneI-0000LQ-26
	for qemu-devel@nongnu.org; Sun, 30 Jul 2017 08:48:46 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <150141536336.27.11838757684685886569@93e45bedd699>
	<87shhegkm5.fsf@frigg.lan>
Date: Sun, 30 Jul 2017 15:48:38 +0300
In-Reply-To: <87shhegkm5.fsf@frigg.lan> (=?utf-8?Q?=22Llu=C3=ADs?=
	Vilanova"'s message of "Sun, 30 Jul 2017 15:44:18 +0300")
Message-ID: <87efsygkex.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 0/5] hypertrace: Lightweight
 guest-to-QEMU trace channel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: no-reply@patchew.org
Cc: qemu-devel@nongnu.org, famz@redhat.com, stefanha@redhat.com, lcapitulino@redhat.com

Llu=C3=ADs Vilanova writes:

> no-reply  writes:
>> Hi,
>> This series failed build test on FreeBSD host. Please find the details b=
elow.

>> Subject: [Qemu-devel] [PATCH v7 0/5] hypertrace: Lightweight guest-to-QE=
MU trace channel
>> Type: series
>> Message-id: 150141363372.9857.9055094189388759132.stgit@frigg.lan

>> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
>> #!/bin/sh
>> # Testing script will be invoked under the git checkout with
>> # HEAD pointing to a commit that has the patches applied on top of "base"
>> # branch
>> set -e
>> echo "=3D=3D=3D ENV =3D=3D=3D"
>> env
>> echo "=3D=3D=3D PACKAGES =3D=3D=3D"
>> pkg info
>> echo "=3D=3D=3D TEST BEGIN =3D=3D=3D"
>> CC=3D/usr/local/libexec/ccache/cc
>> INSTALL=3D$PWD/install
>> BUILD=3D$PWD/build
>> echo -n "Using CC: "
>> realpath $CC
>> mkdir -p $BUILD $INSTALL
>> SRC=3D$PWD
>> cd $BUILD
>> $SRC/configure --cc=3D$CC --prefix=3D$INSTALL --target-list=3Dx86_64-sof=
tmmu
>> gmake -j4
>> # XXX: we need reliable clean up
>> # make check -j4 V=3D1
>> gmake install
>> =3D=3D=3D TEST SCRIPT END =3D=3D=3D

>> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
>> From https://github.com/patchew-project/qemu
>> * [new tag]               patchew/150141363372.9857.9055094189388759132.=
stgit@frigg.lan -> patchew/150141363372.9857.9055094189388759132.stgit@frig=
g.lan
>> Switched to a new branch 'test'
>> 5dad7c93de hypertrace: Add guest-side user-level library
>> dcf9d9c7c7 hypertrace: [softmmu] Add QEMU-side proxy to "guest_hypertrac=
e" event
>> 4c041f724d hypertrace: [*-user] Add QEMU-side proxy to "guest_hypertrace=
" event
>> 73796a3885 hypertrace: Add tracing event "guest_hypertrace"
>> 43fe7e2e2e hypertrace: Add documentation

>> =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
>> =3D=3D=3D ENV =3D=3D=3D
>> LOGNAME=3Dpatchew-tester
>> PATH=3D/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin
>> PWD=3D/var/tmp/patchew-tester-tmp-eswc2rbf/src
>> HOME=3D/home/patchew-tester
>> USER=3Dpatchew-tester
>> SHELL=3D/bin/sh
>> PATCHEW=3D/home/patchew-tester/patchew/patchew-cli -s http://patchew.org=
 --nodebug
>> =3D=3D=3D PACKAGES =3D=3D=3D
>> bash-4.4.12_2                  GNU Project's Bourne Again SHell
>> binutils-2.28,1                GNU binary tools
>> bison-3.0.4,1                  Parser generator from FSF, (mostly) compa=
tible with Yacc
>> ca_root_nss-3.30.2             Root certificate bundle from the Mozilla =
Project
>> ccache-3.3.4_3                 Tool to minimize the compile time of C/C+=
+ programs
>> curl-7.54.0                    Non-interactive tool to get files from FT=
P, GOPHER, HTTP(S) servers
>> cvsps-2.1_2                    Create patchset information from CVS
>> dtc-1.4.2_1                    Device Tree Compiler
>> expat-2.2.0_1                  XML 1.0 parser written in C
>> gcc-5.4.0                      GNU Compiler Collection 5
>> gcc-ecj-4.5                    Eclipse Java Compiler used to build GCC J=
ava
>> gettext-runtime-0.19.8.1_1     GNU gettext runtime libraries and programs
>> git-2.13.0                     Distributed source code management tool
>> glib-2.46.2_5                  Some useful routines of C programming (cu=
rrent stable version)
>> gmake-4.2.1_1                  GNU version of 'make' utility
>> gmp-6.1.2                      Free library for arbitrary precision arit=
hmetic
>> indexinfo-0.2.6                Utility to regenerate the GNU info page i=
ndex
>> libffi-3.2.1                   Foreign Function Interface
>> libiconv-1.14_10               Character set conversion library
>> libnghttp2-1.21.0              HTTP/2.0 C Library
>> m4-1.4.18,1                    GNU M4
>> mpc-1.0.3                      Library of complex numbers with arbitrari=
ly high precision
>> mpfr-3.1.5_1                   Library for multiple-precision floating-p=
oint computations
>> p5-Authen-SASL-2.16_1          Perl5 module for SASL authentication
>> p5-Digest-HMAC-1.03_1          Perl5 interface to HMAC Message-Digest Al=
gorithms
>> p5-Error-0.17024               Error/exception handling in object-orient=
ed programming style
>> p5-GSSAPI-0.28_1               Perl extension providing access to the GS=
SAPIv2 library
>> pcre-8.40                      Perl Compatible Regular Expressions libra=
ry
>> perl5-5.24.1                   Practical Extraction and Report Language
>> pixman-0.34.0                  Low-level pixel manipulation library
>> pkg-1.10.1                     Package manager
>> pkgconf-1.3.0,1                Utility to help to configure compiler and=
 linker flags
>> python-2.7_3,2                 "meta-port" for the default version of Py=
thon interpreter
>> python2-2_3                    The "meta-port" for version 2 of the Pyth=
on interpreter
>> python27-2.7.13_3              Interpreted object-oriented programming l=
anguage
>> python3-3_3                    The "meta-port" for version 3 of the Pyth=
on interpreter
>> python35-3.5.3_1               Interpreted object-oriented programming l=
anguage
>> readline-6.3.8                 Library for editing command lines as they=
 are typed
>> sudo-1.8.20p1                  Allow others to run commands as root
>> =3D=3D=3D TEST BEGIN =3D=3D=3D
>> Using CC: /usr/local/bin/ccache
>> Install prefix    /var/tmp/patchew-tester-tmp-eswc2rbf/src/install
>> BIOS directory    /var/tmp/patchew-tester-tmp-eswc2rbf/src/install/share=
/qemu
>> binary directory  /var/tmp/patchew-tester-tmp-eswc2rbf/src/install/bin
>> library directory /var/tmp/patchew-tester-tmp-eswc2rbf/src/install/lib
>> module directory  /var/tmp/patchew-tester-tmp-eswc2rbf/src/install/lib/q=
emu
>> libexec directory /var/tmp/patchew-tester-tmp-eswc2rbf/src/install/libex=
ec
>> include directory /var/tmp/patchew-tester-tmp-eswc2rbf/src/install/inclu=
de
>> config directory  /var/tmp/patchew-tester-tmp-eswc2rbf/src/install/etc
>> local state directory   /var/tmp/patchew-tester-tmp-eswc2rbf/src/install=
/var
>> Manual directory  /var/tmp/patchew-tester-tmp-eswc2rbf/src/install/share=
/man
>> ELF interp prefix /usr/gnemul/qemu-%M
>> Source path       /var/tmp/patchew-tester-tmp-eswc2rbf/src
>> C compiler        /usr/local/libexec/ccache/cc
>> Host C compiler   cc
>> C++ compiler      c++
>> Objective-C compiler clang
>> ARFLAGS           rv
>> CFLAGS            -O2 -g=20
>> QEMU_CFLAGS -I/usr/local/include/pixman-1 -pthread
> -I/usr/local/include/glib-2.0 -I/usr/local/lib/glib-2.0/include
> -I/usr/local/include -DNCURSES_WIDECHAR -m64 -mcx16 -D_GNU_SOURCE
> -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredund=
ant-decls
> -Wall -Wundef -Wwrite-strings -Wmissing-prototypes -fno-strict-aliasing
> -fno-common -fwrapv -Wno-string-plus-int -Wno-initializer-overrides
> -Wendif-labels -Wno-shift-negative-value -Wno-missing-include-dirs -Wempt=
y-body
> -Wnested-externs -Wformat-security -Wformat-y2k -Winit-self -Wignored-qua=
lifiers
> -Wold-style-definition -Wtype-limits -fstack-protector-strong
>> LDFLAGS           -Wl,--warn-common -m64 -g=20
>> make              gmake
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
>> pixman            system
>> SDL support       no=20
>> GTK support       no=20
>> GTK GL support    no
>> VTE support       no=20
>> TLS priority      NORMAL
>> GNUTLS support    no
>> GNUTLS rnd        no
>> libgcrypt         no
>> libgcrypt kdf     no
>> nettle            no=20
>> nettle kdf        no
>> libtasn1          no
>> curses support    yes
>> virgl support     no
>> curl support      yes
>> mingw32 support   no
>> Audio drivers     oss
>> Block whitelist (rw)=20
>> Block whitelist (ro)=20
>> VirtFS support    no
>> VNC support       yes
>> VNC SASL support  no
>> VNC JPEG support  no
>> VNC PNG support   no
>> xen support       no
>> brlapi support    no
>> bluez  support    no
>> Documentation     no
>> PIE               no
>> vde support       no
>> netmap support    yes
>> Linux AIO support no
>> ATTR/XATTR support no
>> Install blobs     yes
>> KVM support       no
>> HAX support       no
>> TCG support       yes
>> TCG debug enabled no
>> TCG interpreter   no
>> RDMA support      no
>> fdt support       no
>> preadv support    yes
>> fdatasync         no
>> madvise           yes
>> posix_madvise     yes
>> libcap-ng support no
>> vhost-net support no
>> vhost-scsi support no
>> vhost-vsock support no
>> Trace backends    log
>> Hypertrace arguments  1
>> spice support     no=20
>> rbd support       no
>> xfsctl support    no
>> smartcard support no
>> libusb            yes
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
>> TPM passthrough   no
>> QOM debugging     yes
>> Live block migration yes
>> lzo support       no
>> snappy support    no
>> bzip2 support     yes
>> NUMA host support no
>> tcmalloc support  no
>> jemalloc support  no
>> avx2 optimization no
>> replication support yes
>> VxHS block device no
>> GEN     x86_64-softmmu/config-devices.mak.tmp
>> GEN     config-host.h
>> GEN     qemu-options.def
>> GEN     qmp-commands.h
>> GEN     x86_64-softmmu/config-devices.mak
>> GEN     qapi-types.h
>> GEN     qapi-visit.h
>> GEN     qapi-event.h
>> GEN     qmp-marshal.c
>> GEN     qapi-types.c
>> GEN     qapi-visit.c
>> GEN     qapi-event.c
>> GEN     qmp-introspect.h
>> GEN     qmp-introspect.c
>> GEN     trace/generated-tcg-tracers.h
>> GEN     trace/generated-helpers-wrappers.h
>> GEN     trace/generated-helpers.h
>> GEN     trace/generated-helpers.c
>> GEN     module_block.h
>> GEN     /var/tmp/patchew-tester-tmp-eswc2rbf/src/build/hypertrace/trace.h
>> GEN     tests/test-qapi-types.h
>> GEN     tests/test-qapi-visit.h
>> GEN     tests/test-qmp-commands.h
>> GEN     tests/test-qapi-event.h
>> GEN     tests/test-qmp-introspect.h
>> GEN     trace-root.h
>> GEN     util/trace.h
>> GEN     crypto/trace.h
>> GEN     io/trace.h
>> GEN     migration/trace.h
>> GEN     block/trace.h
>> GEN     chardev/trace.h
>> GEN     hw/block/trace.h
>> GEN     hw/block/dataplane/trace.h
>> GEN     hw/char/trace.h
>> GEN     hw/intc/trace.h
>> GEN     hw/net/trace.h
>> GEN     hw/virtio/trace.h
>> GEN     hw/audio/trace.h
>> GEN     hw/misc/trace.h
>> GEN     hw/usb/trace.h
>> GEN     hw/scsi/trace.h
>> GEN     hw/nvram/trace.h
>> GEN     hw/display/trace.h
>> GEN     hw/input/trace.h
>> GEN     hw/timer/trace.h
>> GEN     hw/dma/trace.h
>> GEN     hw/sparc/trace.h
>> GEN     hw/sd/trace.h
>> GEN     hw/isa/trace.h
>> GEN     hw/mem/trace.h
>> GEN     hw/i386/trace.h
>> GEN     hw/i386/xen/trace.h
>> GEN     hw/9pfs/trace.h
>> GEN     hw/ppc/trace.h
>> GEN     hw/pci/trace.h
>> GEN     hw/s390x/trace.h
>> GEN     hw/vfio/trace.h
>> GEN     hw/acpi/trace.h
>> GEN     hw/arm/trace.h
>> GEN     hw/alpha/trace.h
>> GEN     hw/xen/trace.h
>> GEN     ui/trace.h
>> GEN     audio/trace.h
>> GEN     net/trace.h
>> GEN     target/arm/trace.h
>> GEN     target/i386/trace.h
>> GEN     target/mips/trace.h
>> GEN     target/sparc/trace.h
>> GEN     target/s390x/trace.h
>> GEN     target/ppc/trace.h
>> GEN     qom/trace.h
>> GEN     linux-user/trace.h
>> GEN     qapi/trace.h
>> GEN     accel/tcg/trace.h
>> GEN     accel/kvm/trace.h
>> GEN     nbd/trace.h
>> GEN     trace-root.c
>> GEN     util/trace.c
>> GEN     crypto/trace.c
>> GEN     io/trace.c
>> GEN     migration/trace.c
>> GEN     block/trace.c
>> GEN     chardev/trace.c
>> GEN     hw/block/trace.c
>> GEN     hw/block/dataplane/trace.c
>> GEN     hw/char/trace.c
>> GEN     hw/intc/trace.c
>> GEN     hw/net/trace.c
>> GEN     hw/virtio/trace.c
>> GEN     hw/audio/trace.c
>> GEN     hw/misc/trace.c
>> GEN     hw/usb/trace.c
>> GEN     hw/scsi/trace.c
>> GEN     hw/nvram/trace.c
>> GEN     hw/display/trace.c
>> GEN     hw/input/trace.c
>> GEN     hw/timer/trace.c
>> GEN     hw/dma/trace.c
>> GEN     hw/sparc/trace.c
>> GEN     hw/sd/trace.c
>> GEN     hw/isa/trace.c
>> GEN     hw/mem/trace.c
>> GEN     hw/i386/trace.c
>> GEN     hw/i386/xen/trace.c
>> GEN     hw/9pfs/trace.c
>> GEN     hw/ppc/trace.c
>> GEN     hw/pci/trace.c
>> GEN     hw/s390x/trace.c
>> GEN     hw/vfio/trace.c
>> GEN     hw/acpi/trace.c
>> GEN     hw/arm/trace.c
>> GEN     hw/alpha/trace.c
>> GEN     hw/xen/trace.c
>> GEN     ui/trace.c
>> GEN     audio/trace.c
>> GEN     net/trace.c
>> GEN     target/arm/trace.c
>> GEN     target/i386/trace.c
>> GEN     target/mips/trace.c
>> GEN     target/sparc/trace.c
>> GEN     target/s390x/trace.c
>> GEN     target/ppc/trace.c
>> GEN     qom/trace.c
>> GEN     linux-user/trace.c
>> GEN     qapi/trace.c
>> GEN     accel/tcg/trace.c
>> GEN     accel/kvm/trace.c
>> GEN     nbd/trace.c
>> GEN     config-all-devices.mak
>> rm /var/tmp/patchew-tester-tmp-eswc2rbf/src/build/hypertrace/trace.h-tim=
estamp
>> GEN     qga/qapi-generated/qga-qapi-types.h
>> GEN     qga/qapi-generated/qga-qapi-visit.h
>> GEN     qga/qapi-generated/qga-qmp-commands.h
>> GEN     qga/qapi-generated/qga-qapi-types.c
>> GEN     qga/qapi-generated/qga-qapi-visit.c
>> GEN     qga/qapi-generated/qga-qmp-marshal.c
>> CC      qmp-introspect.o
>> CC      qapi-types.o
>> CC      qapi-visit.o
>> CC      qapi-event.o
>> CC      qapi/qapi-visit-core.o
>> CC      qapi/qapi-dealloc-visitor.o
>> CC      qapi/qobject-input-visitor.o
>> CC      qapi/qobject-output-visitor.o
>> CC      qapi/qmp-registry.o
>> CC      qapi/qmp-dispatch.o
>> CC      qapi/string-input-visitor.o
>> CC      qapi/string-output-visitor.o
>> CC      qapi/opts-visitor.o
>> CC      qapi/qapi-clone-visitor.o
>> CC      qapi/qmp-event.o
>> CC      qapi/qapi-util.o
>> CC      qobject/qnull.o
>> CC      qobject/qnum.o
>> CC      qobject/qstring.o
>> CC      qobject/qdict.o
>> CC      qobject/qlist.o
>> CC      qobject/qbool.o
>> CC      qobject/qjson.o
>> CC      qobject/qobject.o
>> CC      qobject/json-lexer.o
>> CC      qobject/json-streamer.o
>> CC      qobject/json-parser.o
>> CC      trace/control.o
>> CC      trace/qmp.o
>> CC      util/osdep.o
>> CC      util/cutils.o
>> CC      util/unicode.o
>> CC      util/qemu-timer-common.o
>> CC      util/bufferiszero.o
>> CC      util/lockcnt.o
>> CC      util/aiocb.o
>> CC      util/async.o
>> CC      util/thread-pool.o
>> CC      util/qemu-timer.o
>> CC      util/main-loop.o
>> CC      util/iohandler.o
>> CC      util/aio-posix.o
>> CC      util/compatfd.o
>> CC      util/event_notifier-posix.o
>> CC      util/mmap-alloc.o
>> CC      util/oslib-posix.o
>> CC      util/qemu-openpty.o
>> CC      util/qemu-thread-posix.o
>> CC      util/memfd.o
>> CC      util/envlist.o
>> CC      util/path.o
>> CC      util/module.o
>> CC      util/host-utils.o
>> CC      util/bitmap.o
>> CC      util/bitops.o
>> CC      util/hbitmap.o
>> CC      util/fifo8.o
>> CC      util/acl.o
>> CC      util/cacheinfo.o
>> CC      util/error.o
>> CC      util/qemu-error.o
>> CC      util/id.o
>> CC      util/iov.o
>> CC      util/qemu-config.o
>> CC      util/qemu-sockets.o
>> CC      util/uri.o
>> CC      util/notify.o
>> CC      util/qemu-option.o
>> CC      util/qemu-progress.o
>> CC      util/keyval.o
>> CC      util/hexdump.o
>> CC      util/crc32c.o
>> CC      util/uuid.o
>> CC      util/throttle.o
>> CC      util/getauxval.o
>> CC      util/readline.o
>> CC      util/rcu.o
>> CC      util/qemu-coroutine.o
>> CC      util/qemu-coroutine-lock.o
>> CC      util/qemu-coroutine-io.o
>> CC      util/qemu-coroutine-sleep.o
>> CC      util/coroutine-ucontext.o
>> CC      util/buffer.o
>> CC      util/timed-average.o
>> CC      util/base64.o
>> CC      util/log.o
>> CC      util/qdist.o
>> CC      util/qht.o
>> CC      util/range.o
>> CC      util/stats64.o
>> CC      util/systemd.o
>> CC      trace-root.o
>> CC      util/trace.o
>> CC      crypto/trace.o
>> CC      io/trace.o
>> CC      migration/trace.o
>> CC      block/trace.o
>> CC      chardev/trace.o
>> CC      hw/block/trace.o
>> CC      hw/block/dataplane/trace.o
>> CC      hw/char/trace.o
>> CC      hw/intc/trace.o
>> CC      hw/net/trace.o
>> CC      hw/virtio/trace.o
>> CC      hw/audio/trace.o
>> CC      hw/misc/trace.o
>> CC      hw/usb/trace.o
>> CC      hw/scsi/trace.o
>> CC      hw/nvram/trace.o
>> CC      hw/display/trace.o
>> CC      hw/input/trace.o
>> CC      hw/timer/trace.o
>> CC      hw/dma/trace.o
>> CC      hw/sparc/trace.o
>> CC      hw/sd/trace.o
>> CC      hw/isa/trace.o
>> CC      hw/mem/trace.o
>> CC      hw/i386/trace.o
>> CC      hw/i386/xen/trace.o
>> CC      hw/9pfs/trace.o
>> CC      hw/ppc/trace.o
>> CC      hw/pci/trace.o
>> CC      hw/s390x/trace.o
>> CC      hw/vfio/trace.o
>> CC      hw/acpi/trace.o
>> CC      hw/arm/trace.o
>> CC      hw/alpha/trace.o
>> CC      hw/xen/trace.o
>> CC      ui/trace.o
>> CC      audio/trace.o
>> CC      net/trace.o
>> CC      target/arm/trace.o
>> CC      target/i386/trace.o
>> CC      target/mips/trace.o
>> CC      target/sparc/trace.o
>> CC      target/s390x/trace.o
>> CC      target/ppc/trace.o
>> CC      qom/trace.o
>> CC      linux-user/trace.o
>> CC      qapi/trace.o
>> CC      accel/tcg/trace.o
>> CC      accel/kvm/trace.o
>> CC      nbd/trace.o
>> GEN     /var/tmp/patchew-tester-tmp-eswc2rbf/src/build/hypertrace/trace.c
>> CC      crypto/pbkdf-stub.o
>> CC      stubs/arch-query-cpu-def.o
>> CC      stubs/arch-query-cpu-model-expansion.o
>> CC      stubs/arch-query-cpu-model-comparison.o
>> CC      stubs/arch-query-cpu-model-baseline.o
>> CC      stubs/bdrv-next-monitor-owned.o
>> CC      stubs/blk-commit-all.o
>> CC      stubs/blockdev-close-all-bdrv-states.o
>> CC      stubs/clock-warp.o
>> CC      stubs/cpu-get-clock.o
>> CC      stubs/cpu-get-icount.o
>> CC      stubs/dump.o
>> CC      stubs/error-printf.o
>> CC      stubs/fdset.o
>> CC      stubs/gdbstub.o
>> CC      stubs/get-vm-name.o
>> CC      stubs/iothread.o
>> CC      stubs/iothread-lock.o
>> CC      stubs/is-daemonized.o
>> CC      stubs/machine-init-done.o
>> CC      stubs/migr-blocker.o
>> CC      stubs/monitor.o
>> CC      stubs/notify-event.o
>> CC      stubs/qtest.o
>> CC      stubs/replay.o
>> CC      stubs/runstate-check.o
>> CC      stubs/set-fd-handler.o
>> CC      stubs/slirp.o
>> CC      stubs/sysbus.o
>> CC      stubs/trace-control.o
>> CC      stubs/uuid.o
>> CC      stubs/vm-stop.o
>> CC      stubs/vmstate.o
>> CC      stubs/qmp_pc_dimm_device_list.o
>> CC      stubs/target-monitor-defs.o
>> CC      stubs/target-get-monitor-def.o
>> CC      stubs/pc_madt_cpu_entry.o
>> CC      stubs/vmgenid.o
>> CC      stubs/xen-common.o
>> CC      stubs/xen-hvm.o
>> CC      qemu-nbd.o
>> CC      block.o
>> CC      blockjob.o
>> CC      qemu-io-cmds.o
>> CC      replication.o
>> CC      block/raw-format.o
>> CC      block/qcow.o
>> CC      block/vdi.o
>> CC      block/vmdk.o
>> CC      block/cloop.o
>> CC      block/bochs.o
>> CC      block/vpc.o
>> CC      block/vvfat.o
>> CC      block/dmg.o
>> CC      block/qcow2.o
>> CC      block/qcow2-refcount.o
>> CC      block/qcow2-cluster.o
>> CC      block/qcow2-snapshot.o
>> CC      block/qcow2-cache.o
>> CC      block/qcow2-bitmap.o
>> CC      block/qed.o
>> CC      block/qed-l2-cache.o
>> CC      block/qed-table.o
>> CC      block/qed-cluster.o
>> CC      block/qed-check.o
>> CC      block/vhdx.o
>> CC      block/vhdx-endian.o
>> CC      block/vhdx-log.o
>> CC      block/quorum.o
>> CC      block/parallels.o
>> CC      block/blkdebug.o
>> CC      block/blkverify.o
>> CC      block/blkreplay.o
>> CC      block/block-backend.o
>> CC      block/snapshot.o
>> CC      block/qapi.o
>> CC      block/file-posix.o
>> CC      block/null.o
>> CC      block/mirror.o
>> CC      block/commit.o
>> CC      block/io.o
>> CC      block/throttle-groups.o
>> CC      block/nbd.o
>> CC      block/nbd-client.o
>> CC      block/sheepdog.o
>> CC      block/accounting.o
>> CC      block/dirty-bitmap.o
>> CC      block/write-threshold.o
>> CC      block/backup.o
>> CC      block/replication.o
>> CC      block/crypto.o
>> CC      nbd/server.o
>> CC      nbd/client.o
>> CC      nbd/common.o
>> CC      block/curl.o
>> CC      block/dmg-bz2.o
>> CC      crypto/init.o
>> CC      crypto/hash.o
>> CC      crypto/hash-glib.o
>> CC      crypto/hmac-glib.o
>> CC      crypto/hmac.o
>> CC      crypto/aes.o
>> CC      crypto/desrfb.o
>> CC      crypto/cipher.o
>> CC      crypto/tlscreds.o
>> CC      crypto/tlscredsanon.o
>> CC      crypto/tlscredsx509.o
>> CC      crypto/tlssession.o
>> CC      crypto/secret.o
>> CC      crypto/random-platform.o
>> CC      crypto/pbkdf.o
>> CC      crypto/ivgen.o
>> CC      crypto/ivgen-essiv.o
>> CC      crypto/ivgen-plain.o
>> CC      crypto/afsplit.o
>> CC      crypto/ivgen-plain64.o
>> CC      crypto/xts.o
>> CC      crypto/block.o
>> CC      crypto/block-qcow.o
>> CC      crypto/block-luks.o
>> CC      io/channel.o
>> CC      io/channel-buffer.o
>> CC      io/channel-command.o
>> CC      io/channel-file.o
>> CC      io/channel-socket.o
>> CC      io/channel-tls.o
>> CC      io/channel-watch.o
>> CC      io/channel-websock.o
>> CC      io/channel-util.o
>> CC      io/dns-resolver.o
>> CC      io/task.o
>> CC      qom/object.o
>> CC      qom/container.o
>> CC      qom/qom-qobject.o
>> CC      qom/object_interfaces.o
>> GEN     qemu-img-cmds.h
>> CC      qemu-io.o
>> CC      blockdev.o
>> CC      blockdev-nbd.o
>> CC      bootdevice.o
>> CC      iothread.o
>> CC      qdev-monitor.o
>> CC      device-hotplug.o
>> CC      os-posix.o
>> CC      bt-host.o
>> CC      bt-vhci.o
>> CC      dma-helpers.o
>> CC      vl.o
>> CC      tpm.o
>> CC      qmp-marshal.o
>> CC      qmp.o
>> CC      hmp.o
>> CC      cpus-common.o
>> CC      audio/audio.o
>> CC      audio/noaudio.o
>> CC      audio/wavaudio.o
>> CC      audio/mixeng.o
>> CC      audio/ossaudio.o
>> CC      audio/wavcapture.o
>> CC      backends/rng.o
>> CC      backends/rng-egd.o
>> CC      backends/rng-random.o
>> CC      backends/tpm.o
>> CC      backends/hostmem.o
>> CC      backends/hostmem-ram.o
>> CC      backends/cryptodev.o
>> CC      backends/cryptodev-builtin.o
>> CC      block/stream.o
>> CC      chardev/msmouse.o
>> CC      chardev/wctablet.o
>> CC      chardev/testdev.o
>> CC      disas/i386.o
>> CC      hw/acpi/core.o
>> CC      hw/acpi/piix4.o
>> CC      hw/acpi/pcihp.o
>> CC      hw/acpi/ich9.o
>> CC      hw/acpi/tco.o
>> CC      hw/acpi/cpu_hotplug.o
>> CC      hw/acpi/memory_hotplug.o
>> CC      hw/acpi/cpu.o
>> CC      hw/acpi/nvdimm.o
>> CC      hw/acpi/vmgenid.o
>> CC      hw/acpi/acpi_interface.o
>> CC      hw/acpi/bios-linker-loader.o
>> CC      hw/acpi/aml-build.o
>> CC      hw/acpi/ipmi.o
>> CC      hw/acpi/acpi-stub.o
>> CC      hw/acpi/ipmi-stub.o
>> CC      hw/audio/sb16.o
>> CC      hw/audio/es1370.o
>> CC      hw/audio/ac97.o
>> CC      hw/audio/fmopl.o
>> CC      hw/audio/adlib.o
>> CC      hw/audio/gus.o
>> CC      hw/audio/gusemu_hal.o
>> CC      hw/audio/gusemu_mixer.o
>> CC      hw/audio/cs4231a.o
>> CC      hw/audio/intel-hda.o
>> CC      hw/audio/hda-codec.o
>> CC      hw/audio/pcspk.o
>> CC      hw/audio/soundhw.o
>> CC      hw/block/block.o
>> CC      hw/block/cdrom.o
>> CC      hw/block/hd-geometry.o
>> CC      hw/block/fdc.o
>> CC      hw/block/pflash_cfi01.o
>> CC      hw/block/nvme.o
>> CC      hw/bt/core.o
>> CC      hw/bt/l2cap.o
>> CC      hw/bt/sdp.o
>> CC      hw/bt/hid.o
>> CC      hw/bt/hci.o
>> CC      hw/bt/hci-csr.o
>> CC      hw/char/ipoctal232.o
>> CC      hw/char/parallel.o
>> CC      hw/char/serial.o
>> CC      hw/char/serial-isa.o
>> CC      hw/char/serial-pci.o
>> CC      hw/char/virtio-console.o
>> CC      hw/char/debugcon.o
>> CC      hw/core/qdev.o
>> CC      hw/core/qdev-properties.o
>> CC      hw/core/bus.o
>> CC      hw/core/reset.o
>> CC      hw/core/fw-path-provider.o
>> CC      hw/core/irq.o
>> CC      hw/core/hotplug.o
>> CC      hw/core/nmi.o
>> CC      hw/core/sysbus.o
>> CC      hw/core/machine.o
>> CC      hw/core/loader.o
>> CC      hw/core/qdev-properties-system.o
>> CC      hw/core/register.o
>> CC      hw/core/or-irq.o
>> CC      hw/cpu/core.o
>> CC      hw/display/cirrus_vga.o
>> CC      hw/display/vga-pci.o
>> CC      hw/display/vga-isa.o
>> CC      hw/display/vmware_vga.o
>> CC      hw/dma/i8257.o
>> CC      hw/i2c/core.o
>> CC      hw/i2c/smbus.o
>> CC      hw/i2c/smbus_eeprom.o
>> CC      hw/i2c/smbus_ich9.o
>> CC      hw/i2c/pm_smbus.o
>> CC      hw/ide/core.o
>> CC      hw/ide/atapi.o
>> CC      hw/ide/qdev.o
>> CC      hw/ide/pci.o
>> CC      hw/ide/isa.o
>> CC      hw/ide/piix.o
>> CC      hw/ide/ahci.o
>> CC      hw/ide/ich.o
>> CC      hw/input/hid.o
>> CC      hw/input/pckbd.o
>> CC      hw/input/ps2.o
>> CC      hw/input/vmmouse.o
>> CC      hw/input/virtio-input.o
>> CC      hw/input/virtio-input-hid.o
>> CC      hw/intc/i8259_common.o
>> CC      hw/intc/i8259.o
>> CC      hw/intc/ioapic_common.o
>> CC      hw/intc/intc.o
>> CC      hw/ipack/ipack.o
>> CC      hw/ipack/tpci200.o
>> CC      hw/ipmi/ipmi.o
>> CC      hw/ipmi/ipmi_bmc_sim.o
>> CC      hw/ipmi/ipmi_bmc_extern.o
>> CC      hw/ipmi/isa_ipmi_kcs.o
>> CC      hw/ipmi/isa_ipmi_bt.o
>> CC      hw/isa/isa-bus.o
>> CC      hw/isa/apm.o
>> CC      hw/mem/pc-dimm.o
>> CC      hw/mem/nvdimm.o
>> CC      hw/misc/applesmc.o
>> CC      hw/misc/debugexit.o
>> CC      hw/misc/sga.o
>> CC      hw/misc/pc-testdev.o
>> CC      hw/misc/pci-testdev.o
>> CC      hw/misc/edu.o
>> CC      hw/misc/unimp.o
>> CC      hw/net/ne2000.o
>> CC      hw/net/eepro100.o
>> CC      hw/net/pcnet-pci.o
>> CC      hw/net/pcnet.o
>> CC      hw/net/e1000.o
>> CC      hw/net/e1000x_common.o
>> CC      hw/net/net_tx_pkt.o
>> CC      hw/net/net_rx_pkt.o
>> CC      hw/net/e1000e.o
>> CC      hw/net/e1000e_core.o
>> CC      hw/net/rtl8139.o
>> CC      hw/net/vmxnet3.o
>> CC      hw/net/ne2000-isa.o
>> CC      hw/net/rocker/rocker.o
>> CC      hw/net/rocker/rocker_fp.o
>> CC      hw/net/rocker/rocker_desc.o
>> CC      hw/net/rocker/rocker_world.o
>> CC      hw/net/rocker/rocker_of_dpa.o
>> CC      hw/nvram/eeprom93xx.o
>> CC      hw/nvram/fw_cfg.o
>> CC      hw/nvram/chrp_nvram.o
>> CC      hw/pci-bridge/pci_bridge_dev.o
>> CC      hw/pci-bridge/pcie_root_port.o
>> CC      hw/pci-bridge/gen_pcie_root_port.o
>> CC      hw/pci-bridge/pci_expander_bridge.o
>> CC      hw/pci-bridge/xio3130_upstream.o
>> CC      hw/pci-bridge/xio3130_downstream.o
>> CC      hw/pci-bridge/ioh3420.o
>> CC      hw/pci-bridge/i82801b11.o
>> CC      hw/pci-host/piix.o
>> CC      hw/pci-host/pam.o
>> CC      hw/pci-host/q35.o
>> CC      hw/pci/pci.o
>> CC      hw/pci/pci_bridge.o
>> CC      hw/pci/msix.o
>> CC      hw/pci/msi.o
>> CC      hw/pci/shpc.o
>> CC      hw/pci/slotid_cap.o
>> CC      hw/pci/pci_host.o
>> CC      hw/pci/pcie_host.o
>> CC      hw/pci/pcie.o
>> CC      hw/pci/pcie_aer.o
>> CC      hw/pci/pcie_port.o
>> CC      hw/pci/pci-stub.o
>> CC      hw/pcmcia/pcmcia.o
>> CC      hw/scsi/scsi-disk.o
>> CC      hw/scsi/scsi-generic.o
>> CC      hw/scsi/scsi-bus.o
>> CC      hw/scsi/lsi53c895a.o
>> CC      hw/scsi/mptsas.o
>> CC      hw/scsi/mptconfig.o
>> CC      hw/scsi/mptendian.o
>> CC      hw/scsi/megasas.o
>> CC      hw/scsi/vmw_pvscsi.o
>> CC      hw/scsi/esp.o
>> CC      hw/scsi/esp-pci.o
>> CC      hw/sd/sd.o
>> CC      hw/sd/core.o
>> CC      hw/sd/sdhci.o
>> CC      hw/smbios/smbios.o
>> CC      hw/smbios/smbios_type_38.o
>> CC      hw/smbios/smbios-stub.o
>> CC      hw/smbios/smbios_type_38-stub.o
>> CC      hw/timer/hpet.o
>> CC      hw/timer/i8254_common.o
>> CC      hw/timer/i8254.o
>> CC      hw/tpm/tpm_tis.o
>> CC      hw/usb/core.o
>> CC      hw/usb/combined-packet.o
>> CC      hw/usb/bus.o
>> CC      hw/usb/libhw.o
>> CC      hw/usb/desc.o
>> CC      hw/usb/desc-msos.o
>> CC      hw/usb/hcd-uhci.o
>> CC      hw/usb/hcd-ohci.o
>> CC      hw/usb/hcd-ehci.o
>> CC      hw/usb/hcd-ehci-pci.o
>> CC      hw/usb/hcd-xhci.o
>> CC      hw/usb/hcd-xhci-nec.o
>> CC      hw/usb/dev-hub.o
>> CC      hw/usb/dev-hid.o
>> CC      hw/usb/dev-wacom.o
>> CC      hw/usb/dev-storage.o
>> CC      hw/usb/dev-uas.o
>> CC      hw/usb/dev-audio.o
>> CC      hw/usb/dev-serial.o
>> CC      hw/usb/dev-network.o
>> CC      hw/usb/dev-bluetooth.o
>> CC      hw/usb/dev-smartcard-reader.o
>> CC      hw/usb/dev-mtp.o
>> CC      hw/usb/host-libusb.o
>> CC      hw/usb/host-legacy.o
>> CC      hw/virtio/virtio-rng.o
>> CC      hw/virtio/virtio-pci.o
>> CC      hw/virtio/virtio-bus.o
>> CC      hw/virtio/virtio-mmio.o
>> CC      hw/virtio/vhost-stub.o
>> CC      hw/watchdog/watchdog.o
>> CC      hw/watchdog/wdt_i6300esb.o
>> CC      hw/watchdog/wdt_ib700.o
>> CC      migration/migration.o
>> CC      migration/socket.o
>> CC      migration/fd.o
>> CC      migration/exec.o
>> CC      migration/tls.o
>> CC      migration/channel.o
>> CC      migration/savevm.o
>> CC      migration/colo-comm.o
>> CC      migration/colo.o
>> CC      migration/colo-failover.o
>> CC      migration/vmstate.o
>> CC      migration/vmstate-types.o
>> CC      migration/page_cache.o
>> CC      migration/qemu-file.o
>> CC      migration/global_state.o
>> CC      migration/qemu-file-channel.o
>> CC      migration/xbzrle.o
>> CC      migration/postcopy-ram.o
>> CC      migration/qjson.o
>> CC      migration/block.o
>> CC      net/net.o
>> CC      net/queue.o
>> CC      net/checksum.o
>> CC      net/util.o
>> CC      net/hub.o
>> CC      net/socket.o
>> CC      net/dump.o
>> CC      net/eth.o
>> CC      net/vhost-user.o
>> CC      net/slirp.o
>> CC      net/netmap.o
>> CC      net/filter.o
>> CC      net/filter-buffer.o
>> CC      net/filter-mirror.o
>> CC      net/colo-compare.o
>> CC      net/colo.o
>> CC      net/filter-rewriter.o
>> CC      net/filter-replay.o
>> CC      net/tap.o
>> CC      net/tap-bsd.o
>> CC      qom/cpu.o
>> CC      replay/replay.o
>> CC      replay/replay-internal.o
>> CC      replay/replay-events.o
>> CC      replay/replay-time.o
>> CC      replay/replay-input.o
>> CC      replay/replay-char.o
>> CC      replay/replay-snapshot.o
>> CC      replay/replay-net.o
>> CC      replay/replay-audio.o
>> CC      slirp/cksum.o
>> CC      slirp/if.o
>> CC      slirp/ip_icmp.o
>> CC      slirp/ip6_icmp.o
>> CC      slirp/ip6_input.o
>> CC      slirp/ip6_output.o
>> CC      slirp/ip_input.o
>> CC      slirp/ip_output.o
>> CC      slirp/dnssearch.o
>> CC      slirp/dhcpv6.o
>> CC      slirp/slirp.o
>> CC      slirp/mbuf.o
>> CC      slirp/misc.o
>> CC      slirp/sbuf.o
>> CC      slirp/socket.o
>> CC      slirp/tcp_input.o
>> CC      slirp/tcp_output.o
>> CC      slirp/tcp_subr.o
>> CC      slirp/tcp_timer.o
>> CC      slirp/udp.o
>> CC      slirp/udp6.o
>> CC      slirp/bootp.o
>> CC      slirp/tftp.o
>> CC      slirp/arp_table.o
>> CC      slirp/ndp_table.o
>> CC      slirp/ncsi.o
>> CC      ui/keymaps.o
>> CC      ui/console.o
>> CC      ui/cursor.o
>> CC      ui/qemu-pixman.o
>> CC      ui/input.o
>> CC      ui/input-keymap.o
>> CC      ui/input-legacy.o
>> CC      ui/curses.o
>> CC      ui/vnc.o
>> CC      ui/vnc-enc-zlib.o
>> CC      ui/vnc-enc-hextile.o
>> CC      ui/vnc-enc-tight.o
>> CC      ui/vnc-palette.o
>> CC      ui/vnc-enc-zrle.o
>> CC      ui/vnc-auth-vencrypt.o
>> CC      ui/vnc-ws.o
>> CC      ui/vnc-jobs.o
>> CC      chardev/char.o
>> CC      chardev/char-fd.o
>> CC      chardev/char-fe.o
>> CC      chardev/char-file.o
>> CC      chardev/char-io.o
>> CC      chardev/char-mux.o
>> CC      chardev/char-null.o
>> CC      chardev/char-parallel.o
>> CC      chardev/char-pipe.o
>> CC      chardev/char-pty.o
>> CC      chardev/char-ringbuf.o
>> CC      chardev/char-serial.o
>> CC      chardev/char-socket.o
>> CC      chardev/char-stdio.o
>> CC      chardev/char-udp.o
>> AS      optionrom/multiboot.o
>> AS      optionrom/linuxboot.o
>> CC      optionrom/linuxboot_dma.o
>> AS      optionrom/kvmvapic.o
>> CC      qga/commands.o
>> CC      qga/guest-agent-command-state.o
>> BUILD   optionrom/multiboot.img
>> BUILD   optionrom/linuxboot.img
>> BUILD   optionrom/kvmvapic.img
>> BUILD   optionrom/multiboot.raw
>> BUILD   optionrom/linuxboot.raw
>> BUILD   optionrom/linuxboot_dma.img
>> CC      qga/main.o
>> CC      qga/commands-posix.o
>> BUILD   optionrom/kvmvapic.raw
>> SIGN    optionrom/multiboot.bin
>> SIGN    optionrom/linuxboot.bin
>> BUILD   optionrom/linuxboot_dma.raw
>> SIGN    optionrom/kvmvapic.bin
>> CC      qga/channel-posix.o
>> SIGN    optionrom/linuxboot_dma.bin
>> CC      qga/qapi-generated/qga-qapi-types.o
>> CC      qga/qapi-generated/qga-qapi-visit.o
>> CC      qga/qapi-generated/qga-qmp-marshal.o
>> AR      libqemustub.a
>> CC      qemu-img.o
>> CC      /var/tmp/patchew-tester-tmp-eswc2rbf/src/build/hypertrace/trace.o
>> AR      libqemuutil.a
>> LINK    qemu-ga
>> LINK    qemu-nbd
>> LINK    qemu-io
>> LINK    qemu-img
>> GEN     x86_64-softmmu/hmp-commands.h
>> GEN     x86_64-softmmu/hmp-commands-info.h
>> GEN     x86_64-softmmu/config-target.h
>> CC      x86_64-softmmu/tcg/tcg-op.o
>> CC      x86_64-softmmu/exec.o
>> CC      x86_64-softmmu/tcg/tcg.o
>> CC      x86_64-softmmu/tcg/optimize.o
>> CC      x86_64-softmmu/tcg/tcg-common.o
>> CC      x86_64-softmmu/tcg/tcg-runtime.o
>> CC      x86_64-softmmu/fpu/softfloat.o
>> CC      x86_64-softmmu/disas.o
>> GEN     x86_64-softmmu/gdbstub-xml.c
>> CC      x86_64-softmmu/hax-stub.o
>> CC      x86_64-softmmu/arch_init.o
>> CC      x86_64-softmmu/cpus.o
>> CC      x86_64-softmmu/monitor.o
>> CC      x86_64-softmmu/gdbstub.o
>> CC      x86_64-softmmu/balloon.o
>> CC      x86_64-softmmu/ioport.o
>> CC      x86_64-softmmu/numa.o
>> CC      x86_64-softmmu/qtest.o
>> CC      x86_64-softmmu/memory.o
>> CC      x86_64-softmmu/memory_mapping.o
>> CC      x86_64-softmmu/dump.o
>> CC      x86_64-softmmu/migration/ram.o
>> CC      x86_64-softmmu/accel/accel.o
>> CC      x86_64-softmmu/accel/stubs/kvm-stub.o
>> CC      x86_64-softmmu/accel/tcg/tcg-all.o
>> CC      x86_64-softmmu/accel/tcg/cputlb.o
>> CC      x86_64-softmmu/accel/tcg/cpu-exec.o
>> CC      x86_64-softmmu/accel/tcg/cpu-exec-common.o
>> CC      x86_64-softmmu/accel/tcg/translate-all.o
>> CC      x86_64-softmmu/hw/block/virtio-blk.o
>> CC      x86_64-softmmu/hw/block/dataplane/virtio-blk.o
>> CC      x86_64-softmmu/hw/char/virtio-serial-bus.o
>> CC      x86_64-softmmu/hw/core/generic-loader.o
>> CC      x86_64-softmmu/hw/core/null-machine.o
>> CC      x86_64-softmmu/hw/display/vga.o
>> CC      x86_64-softmmu/hw/display/virtio-gpu.o
>> CC      x86_64-softmmu/hw/display/virtio-gpu-3d.o
>> CC      x86_64-softmmu/hw/display/virtio-gpu-pci.o
>> CC      x86_64-softmmu/hw/display/virtio-vga.o
>> CC      x86_64-softmmu/hw/intc/apic.o
>> CC      x86_64-softmmu/hw/intc/apic_common.o
>> CC      x86_64-softmmu/hw/intc/ioapic.o
>> CC      x86_64-softmmu/hw/isa/lpc_ich9.o
>> CC      x86_64-softmmu/hw/misc/vmport.o
>> CC      x86_64-softmmu/hw/misc/pvpanic.o
>> CC      x86_64-softmmu/hw/misc/mmio_interface.o
>> CC      x86_64-softmmu/hw/net/virtio-net.o
>> CC      x86_64-softmmu/hw/net/vhost_net.o
>> CC      x86_64-softmmu/hw/scsi/virtio-scsi.o
>> CC      x86_64-softmmu/hw/scsi/virtio-scsi-dataplane.o
>> CC      x86_64-softmmu/hw/timer/mc146818rtc.o
>> CC      x86_64-softmmu/hw/virtio/virtio.o
>> CC      x86_64-softmmu/hw/virtio/virtio-balloon.o
>> CC      x86_64-softmmu/hw/virtio/virtio-crypto.o
>> CC      x86_64-softmmu/hw/virtio/virtio-crypto-pci.o
>> CC      x86_64-softmmu/hw/i386/multiboot.o
>> CC      x86_64-softmmu/hw/i386/pc.o
>> CC      x86_64-softmmu/hw/i386/pc_piix.o
>> CC      x86_64-softmmu/hw/i386/pc_q35.o
>> CC      x86_64-softmmu/hw/i386/pc_sysfw.o
>> CC      x86_64-softmmu/hw/i386/x86-iommu.o
>> CC      x86_64-softmmu/hw/i386/intel_iommu.o
>> CC      x86_64-softmmu/hw/i386/amd_iommu.o
>> CC      x86_64-softmmu/hw/i386/kvmvapic.o
>> CC      x86_64-softmmu/hw/i386/acpi-build.o
>> CC      x86_64-softmmu/hw/i386/pci-assign-load-rom.o
>> CC      x86_64-softmmu/target/i386/helper.o
>> CC      x86_64-softmmu/target/i386/cpu.o
>> CC      x86_64-softmmu/target/i386/gdbstub.o
>> CC      x86_64-softmmu/target/i386/xsave_helper.o
>> CC      x86_64-softmmu/target/i386/translate.o
>> CC      x86_64-softmmu/target/i386/bpt_helper.o
>> CC      x86_64-softmmu/target/i386/cc_helper.o
>> CC      x86_64-softmmu/target/i386/excp_helper.o
>> CC      x86_64-softmmu/target/i386/fpu_helper.o
>> CC      x86_64-softmmu/target/i386/int_helper.o
>> CC      x86_64-softmmu/target/i386/mem_helper.o
>> CC      x86_64-softmmu/target/i386/misc_helper.o
>> CC      x86_64-softmmu/target/i386/mpx_helper.o
>> CC      x86_64-softmmu/target/i386/seg_helper.o
>> CC      x86_64-softmmu/target/i386/smm_helper.o
>> CC      x86_64-softmmu/target/i386/svm_helper.o
>> CC      x86_64-softmmu/target/i386/machine.o
>> CC      x86_64-softmmu/target/i386/arch_memory_mapping.o
>> CC      x86_64-softmmu/target/i386/arch_dump.o
>> CC      x86_64-softmmu/target/i386/monitor.o
>> CC      x86_64-softmmu/target/i386/kvm-stub.o
>> GEN     trace/generated-helpers.c
>> CC      x86_64-softmmu/trace/control-target.o
>> CC      x86_64-softmmu/gdbstub-xml.o
>> CC      x86_64-softmmu/hypertrace/softmmu.o
>> CC      x86_64-softmmu/hypertrace/common.o
>> CC      x86_64-softmmu/trace/generated-helpers.o
>> In file included from /var/tmp/patchew-tester-tmp-eswc2rbf/src/hypertrac=
e/common.c:42:
>> ./hypertrace/emit.c:3:39: error: too many arguments to function call, ex=
pected 2, have 4
>> trace_guest_hypertrace(cpu, arg1, data[1-1], data[0-1]);
>> ~~~~~~~~~~~~~~~~~~~~~~            ^~~~~~~~~~~~~~~~~~~~
>> ../hypertrace/trace.h:28:1: note: 'trace_guest_hypertrace' declared here
>> static inline void trace_guest_hypertrace(CPUState * __cpu, uint64_t arg=
1)
>> ^
>> 1 error generated.
>> gmake[1]: *** [/var/tmp/patchew-tester-tmp-eswc2rbf/src/rules.mak:66: hy=
pertrace/common.o] Error 1
>> gmake[1]: *** Waiting for unfinished jobs....
>> gmake: *** [Makefile:329: subdir-x86_64-softmmu] Error 2
>> rm /var/tmp/patchew-tester-tmp-eswc2rbf/src/build/hypertrace/trace.c-tim=
estamp /var/tmp/patchew-tester-tmp-eswc2rbf/src/build/hypertrace/trace.c
>> =3D=3D=3D OUTPUT END =3D=3D=3D

>> Test command exited with code: 2

> Is there a BSD machine I can log into to check why is this failing?

Nevermind, I easily found a disk image for FreeBSD. Sorry.

Lluis
