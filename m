Received: from eggs.gnu.org ([2001:4830:134:3::10]:40363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1czwSc-00034g-7w
	for qemu-devel@nongnu.org; Sun, 16 Apr 2017 22:32:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1czwSR-0003Y7-Cl
	for qemu-devel@nongnu.org; Sun, 16 Apr 2017 22:32:14 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3437
	helo=dggrg02-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1czwSP-0003S5-7g
	for qemu-devel@nongnu.org; Sun, 16 Apr 2017 22:32:03 -0400
Message-ID: <58F428F0.9090206@huawei.com>
Date: Mon, 17 Apr 2017 10:31:12 +0800
From: "Longpeng (Mike)" <longpeng2@huawei.com>
MIME-Version: 1.0
References: <149239512259.10512.15835571093640619813@6c512846dbc7>
In-Reply-To: <149239512259.10512.15835571093640619813@6c512846dbc7>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 for-2.10 00/18] crypto: add
 afalg-backend support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: berrange@redhat.com
Cc: qemu-devel@nongnu.org, famz@redhat.com, weidong.huang@huawei.com, mst@redhat.com, armbru@redhat.com, arei.gonglei@huawei.com

Hi Daniel,

I will fix this error in V3, please continue reviewing V2.
Thx.

Regards,
Longpeng

On 2017/4/17 10:12, no-reply@patchew.org wrote:

> Hi,
> 
> This series failed automatic build test. Please find the testing commands and
> their output below. If you have docker installed, you can probably reproduce it
> locally.
> 
> Type: series
> Subject: [Qemu-devel] [PATCH v2 for-2.10 00/18] crypto: add afalg-backend support
> Message-id: 1492392806-53720-1-git-send-email-longpeng2@huawei.com
> 
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> set -e
> git submodule update --init dtc
> # Let docker tests dump environment info
> export SHOW_ENV=1
> export J=8
> make docker-test-quick@centos6
> make docker-test-mingw@fedora
> make docker-test-build@min-glib
> === TEST SCRIPT END ===
> 
> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> Switched to a new branch 'test'
> 7c7c5ab tests: crypto: add hmac speed benchmark support
> 584050f tests: crypto: add hash speed benchmark support
> 9753f2d tests: crypto: add cipher speed benchmark support
> b5576a6 crypto: hmac: add af_alg hmac support
> 24c7660 crypto: hash: add afalg-backend hash support
> aadd140 crypto: cipher: add afalg-backend cipher support
> 6c354ce crypto: introduce some common functions for af_alg backend
> 305c87f crypto: hmac: add hmac driver framework
> e65ebfc crypto: hmac: introduce qcrypto_hmac_ctx_new for glib-backend
> 71d05b5 crypto: hmac: introduce qcrypto_hmac_ctx_new for nettle-backend
> 0e4ca51 crypto: hmac: introduce qcrypto_hmac_ctx_new for gcrypt-backend
> d7194f2 crypto: hmac: move crypto/hmac.h into include/crypto/
> e63ff2c crypto: hash: add hash driver framework
> 43a3c26 crypto: cipher: add cipher driver framework
> 4535ea3 crypto: cipher: introduce qcrypto_cipher_ctx_new for builtin-backend
> 1a104c6 crypto: cipher: introduce qcrypto_cipher_ctx_new for nettle-backend
> 10d58f2 crypto: cipher: introduce qcrypto_cipher_ctx_new for gcrypt-backend
> 29cbd1e crypto: cipher: introduce context free function
> 
> === OUTPUT BEGIN ===
> Submodule 'dtc' (git://git.qemu-project.org/dtc.git) registered for path 'dtc'
> Cloning into '/var/tmp/patchew-tester-tmp-e8571v4e/src/dtc'...
> Submodule path 'dtc': checked out '558cd81bdd432769b59bff01240c44f82cfb1a9d'
>   BUILD   centos6
> make[1]: Entering directory '/var/tmp/patchew-tester-tmp-e8571v4e/src'
>   ARCHIVE qemu.tgz
>   ARCHIVE dtc.tgz
>   COPY    RUNNER
>     RUN test-quick in qemu:centos6 
> Packages installed:
> SDL-devel-1.2.14-7.el6_7.1.x86_64
> ccache-3.1.6-2.el6.x86_64
> epel-release-6-8.noarch
> gcc-4.4.7-17.el6.x86_64
> git-1.7.1-4.el6_7.1.x86_64
> glib2-devel-2.28.8-5.el6.x86_64
> libfdt-devel-1.4.0-1.el6.x86_64
> make-3.81-23.el6.x86_64
> package g++ is not installed
> pixman-devel-0.32.8-1.el6.x86_64
> tar-1.23-15.el6_8.x86_64
> zlib-devel-1.2.3-29.el6.x86_64
> 
> Environment variables:
> PACKAGES=libfdt-devel ccache     tar git make gcc g++     zlib-devel glib2-devel SDL-devel pixman-devel     epel-release
> HOSTNAME=b4472302f4f3
> TERM=xterm
> MAKEFLAGS= -j8
> HISTSIZE=1000
> J=8
> USER=root
> CCACHE_DIR=/var/tmp/ccache
> EXTRA_CONFIGURE_OPTS=
> V=
> SHOW_ENV=1
> MAIL=/var/spool/mail/root
> PATH=/usr/lib/ccache:/usr/lib64/ccache:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
> PWD=/
> LANG=en_US.UTF-8
> TARGET_LIST=
> HISTCONTROL=ignoredups
> SHLVL=1
> HOME=/root
> TEST_DIR=/tmp/qemu-test
> LOGNAME=root
> LESSOPEN=||/usr/bin/lesspipe.sh %s
> FEATURES= dtc
> DEBUG=
> G_BROKEN_FILENAMES=1
> CCACHE_HASHDIR=
> _=/usr/bin/env
> 
> Configure options:
> --enable-werror --target-list=x86_64-softmmu,aarch64-softmmu --prefix=/var/tmp/qemu-build/install
> No C++ compiler available; disabling C++ specific optional code
> Install prefix    /var/tmp/qemu-build/install
> BIOS directory    /var/tmp/qemu-build/install/share/qemu
> binary directory  /var/tmp/qemu-build/install/bin
> library directory /var/tmp/qemu-build/install/lib
> module directory  /var/tmp/qemu-build/install/lib/qemu
> libexec directory /var/tmp/qemu-build/install/libexec
> include directory /var/tmp/qemu-build/install/include
> config directory  /var/tmp/qemu-build/install/etc
> local state directory   /var/tmp/qemu-build/install/var
> Manual directory  /var/tmp/qemu-build/install/share/man
> ELF interp prefix /usr/gnemul/qemu-%M
> Source path       /tmp/qemu-test/src
> C compiler        cc
> Host C compiler   cc
> C++ compiler      
> Objective-C compiler cc
> ARFLAGS           rv
> CFLAGS            -O2 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2 -g 
> QEMU_CFLAGS       -I/usr/include/pixman-1   -I$(SRC_PATH)/dtc/libfdt -pthread -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include   -fPIE -DPIE -m64 -mcx16 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-prototypes -fno-strict-aliasing -fno-common -fwrapv  -Wendif-labels -Wno-missing-include-dirs -Wempty-body -Wnested-externs -Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers -Wold-style-declaration -Wold-style-definition -Wtype-limits -fstack-protector-all
> LDFLAGS           -Wl,--warn-common -Wl,-z,relro -Wl,-z,now -pie -m64 -g 
> make              make
> install           install
> python            python -B
> smbd              /usr/sbin/smbd
> module support    no
> host CPU          x86_64
> host big endian   no
> target list       x86_64-softmmu aarch64-softmmu
> tcg debug enabled no
> gprof enabled     no
> sparse enabled    no
> strip binaries    yes
> profiler          no
> static build      no
> pixman            system
> SDL support       yes (1.2.14)
> GTK support       no 
> GTK GL support    no
> VTE support       no 
> TLS priority      NORMAL
> GNUTLS support    no
> GNUTLS rnd        no
> libgcrypt         no
> libgcrypt kdf     no
> nettle            no 
> nettle kdf        no
> libtasn1          no
> curses support    no
> virgl support     no
> curl support      no
> mingw32 support   no
> Audio drivers     oss
> Block whitelist (rw) 
> Block whitelist (ro) 
> VirtFS support    no
> VNC support       yes
> VNC SASL support  no
> VNC JPEG support  no
> VNC PNG support   no
> xen support       no
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
> RDMA support      no
> TCG interpreter   no
> fdt support       yes
> preadv support    yes
> fdatasync         yes
> madvise           yes
> posix_madvise     yes
> libcap-ng support no
> vhost-net support yes
> vhost-scsi support yes
> vhost-vsock support yes
> Trace backends    log
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
> QGA w32 disk info no
> QGA MSI support   no
> seccomp support   no
> coroutine backend ucontext
> coroutine pool    yes
> debug stack usage no
> GlusterFS support no
> gcov              gcov
> gcov enabled      no
> TPM support       yes
> libssh2 support   no
> TPM passthrough   yes
> QOM debugging     yes
> lzo support       no
> snappy support    no
> bzip2 support     no
> NUMA host support no
> tcmalloc support  no
> jemalloc support  no
> avx2 optimization no
> replication support yes
>   GEN     x86_64-softmmu/config-devices.mak.tmp
>   GEN     aarch64-softmmu/config-devices.mak.tmp
> mkdir -p dtc/libfdt
> mkdir -p dtc/tests
>   GEN     config-host.h
>   GEN     qemu-options.def
>   GEN     qmp-commands.h
>   GEN     qapi-types.h
>   GEN     qapi-visit.h
>   GEN     qapi-event.h
>   GEN     x86_64-softmmu/config-devices.mak
>   GEN     aarch64-softmmu/config-devices.mak
>   GEN     qmp-marshal.c
>   GEN     qapi-types.c
>   GEN     qapi-visit.c
>   GEN     qapi-event.c
>   GEN     qmp-introspect.h
>   GEN     qmp-introspect.c
>   GEN     trace/generated-tcg-tracers.h
>   GEN     trace/generated-helpers-wrappers.h
>   GEN     trace/generated-helpers.h
>   GEN     trace/generated-helpers.c
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
>   GEN     block/trace.h
>   GEN     backends/trace.h
>   GEN     hw/block/trace.h
>   GEN     hw/block/dataplane/trace.h
>   GEN     hw/char/trace.h
>   GEN     hw/intc/trace.h
>   GEN     hw/net/trace.h
>   GEN     hw/virtio/trace.h
>   GEN     hw/audio/trace.h
>   GEN     hw/misc/trace.h
>   GEN     hw/usb/trace.h
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
>   GEN     trace-root.c
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
>   GEN     hw/audio/trace.c
>   GEN     hw/misc/trace.c
>   GEN     hw/usb/trace.c
>   GEN     hw/scsi/trace.c
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
>   GEN     config-all-devices.mak
> 	 DEP /tmp/qemu-test/src/dtc/tests/dumptrees.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/testutils.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/value-labels.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/trees.S
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
> 	 DEP /tmp/qemu-test/src/dtc/tests/get_path.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/supernode_atdepth_offset.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/get_phandle.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/getprop.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/get_name.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/path_offset.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/subnode_offset.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/find_property.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/get_mem_rsv.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/root_node.c
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
> 	 DEP /tmp/qemu-test/src/dtc/fdtput.c
> 	 DEP /tmp/qemu-test/src/dtc/fdtget.c
> 	 DEP /tmp/qemu-test/src/dtc/fdtdump.c
> 	 LEX convert-dtsv0-lexer.lex.c
> make[1]: flex: Command not found
> 	 BISON dtc-parser.tab.c
> 	 DEP /tmp/qemu-test/src/dtc/srcpos.c
> make[1]: bison: Command not found
> 	 LEX dtc-lexer.lex.c
> 	 DEP /tmp/qemu-test/src/dtc/treesource.c
> make[1]: flex: Command not found
> 	 DEP /tmp/qemu-test/src/dtc/livetree.c
> 	 DEP /tmp/qemu-test/src/dtc/fstree.c
> 	 DEP /tmp/qemu-test/src/dtc/flattree.c
> 	 DEP /tmp/qemu-test/src/dtc/dtc.c
> 	 DEP /tmp/qemu-test/src/dtc/data.c
> 	 DEP /tmp/qemu-test/src/dtc/checks.c
> 	CHK version_gen.h
> 	 LEX convert-dtsv0-lexer.lex.c
> make[1]: flex: Command not found
> 	 BISON dtc-parser.tab.c
> 	 LEX dtc-lexer.lex.c
> make[1]: bison: Command not found
> make[1]: flex: Command not found
> 	UPD version_gen.h
> 	 DEP /tmp/qemu-test/src/dtc/util.c
> 	 LEX convert-dtsv0-lexer.lex.c
> 	 BISON dtc-parser.tab.c
> 	 LEX dtc-lexer.lex.c
> make[1]: flex: Command not found
> make[1]: bison: Command not found
> make[1]: flex: Command not found
> 	 CC libfdt/fdt.o
> 	 CC libfdt/fdt_ro.o
> 	 CC libfdt/fdt_wip.o
> 	 CC libfdt/fdt_sw.o
> 	 CC libfdt/fdt_strerror.o
> 	 CC libfdt/fdt_rw.o
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
> 	 LEX convert-dtsv0-lexer.lex.c
> 	 BISON dtc-parser.tab.c
> make[1]: flex: Command not found
> make[1]: bison: Command not found
> 	 LEX dtc-lexer.lex.c
> make[1]: flex: Command not found
>   CC      tests/qemu-iotests/socket_scm_helper.o
>   GEN     qga/qapi-generated/qga-qapi-types.h
>   GEN     qga/qapi-generated/qga-qapi-visit.h
>   GEN     qga/qapi-generated/qga-qapi-visit.c
>   GEN     qga/qapi-generated/qga-qapi-types.c
>   GEN     qga/qapi-generated/qga-qmp-commands.h
>   GEN     qga/qapi-generated/qga-qmp-marshal.c
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
>   CC      hw/audio/trace.o
>   CC      hw/virtio/trace.o
>   CC      hw/net/trace.o
>   CC      hw/misc/trace.o
>   CC      hw/usb/trace.o
>   CC      hw/scsi/trace.o
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
>   CC      target/mips/trace.o
>   CC      target/sparc/trace.o
>   CC      target/s390x/trace.o
>   CC      target/ppc/trace.o
>   CC      qom/trace.o
>   CC      linux-user/trace.o
>   CC      qapi/trace.o
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
>   CC      qobject/qnull.o
>   CC      qapi/qapi-util.o
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
>   CC      util/qdist.o
>   CC      util/qht.o
>   CC      util/range.o
>   CC      util/systemd.o
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
>   CC      stubs/migr-blocker.o
>   CC      stubs/machine-init-done.o
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
>   CC      stubs/vmgenid.o
>   CC      contrib/ivshmem-client/ivshmem-client.o
>   CC      contrib/ivshmem-client/main.o
>   CC      contrib/ivshmem-server/ivshmem-server.o
>   CC      contrib/ivshmem-server/main.o
>   CC      block.o
>   CC      qemu-nbd.o
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
>   CC      block/null.o
>   CC      block/mirror.o
>   CC      block/commit.o
>   CC      block/io.o
>   CC      block/throttle-groups.o
>   CC      block/nbd.o
>   CC      block/nbd-client.o
>   CC      block/sheepdog.o
>   CC      block/accounting.o
>   CC      block/dirty-bitmap.o
>   CC      block/backup.o
>   CC      block/replication.o
>   CC      block/write-threshold.o
>   CC      block/crypto.o
>   CC      nbd/server.o
>   CC      nbd/client.o
>   CC      nbd/common.o
>   CC      crypto/init.o
>   CC      crypto/hash.o
>   CC      crypto/hash-glib.o
>   CC      crypto/hmac.o
>   CC      crypto/hmac-glib.o
>   CC      crypto/aes.o
>   CC      crypto/desrfb.o
>   CC      crypto/cipher.o
> In file included from /tmp/qemu-test/src/crypto/hmacpriv.h:18,
>                  from /tmp/qemu-test/src/crypto/hmac.c:15:
> /tmp/qemu-test/src/crypto/afalgpriv.h:17:26: warning: linux/if_alg.h: No such file or directory
>   CC      crypto/tlscreds.o
> In file included from /tmp/qemu-test/src/crypto/hashpriv.h:18,
>                  from /tmp/qemu-test/src/crypto/hash.c:24:
> /tmp/qemu-test/src/crypto/afalgpriv.h:17:26: warning: linux/if_alg.h: No such file or directory
>   CC      crypto/tlscredsanon.o
> In file included from /tmp/qemu-test/src/crypto/hashpriv.h:18,
>                  from /tmp/qemu-test/src/crypto/hash-glib.c:24:
> /tmp/qemu-test/src/crypto/afalgpriv.h:17:26: warning: linux/if_alg.h: No such file or directory
>   CC      crypto/tlscredsx509.o
>   CC      crypto/tlssession.o
>   CC      crypto/secret.o
> In file included from /tmp/qemu-test/src/crypto/hmacpriv.h:18,
>                  from /tmp/qemu-test/src/crypto/hmac-glib.c:18:
> /tmp/qemu-test/src/crypto/afalgpriv.h:17:26: warning: linux/if_alg.h: No such file or directory
>   CC      crypto/pbkdf.o
>   CC      crypto/random-platform.o
>   CC      crypto/ivgen.o
>   CC      crypto/ivgen-essiv.o
>   CC      crypto/ivgen-plain.o
>   CC      crypto/ivgen-plain64.o
>   CC      crypto/afsplit.o
>   CC      crypto/xts.o
>   CC      crypto/block.o
>   CC      crypto/block-qcow.o
> In file included from /tmp/qemu-test/src/crypto/cipherpriv.h:19,
>                  from /tmp/qemu-test/src/crypto/cipher.c:24:
> /tmp/qemu-test/src/crypto/afalgpriv.h:17:26: warning: linux/if_alg.h: No such file or directory
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
>   CC      io/task.o
>   CC      qom/object.o
>   CC      qom/container.o
>   CC      qom/qom-qobject.o
>   CC      qom/object_interfaces.o
>   GEN     qemu-img-cmds.h
>   CC      qemu-io.o
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
>   CC      bt-vhci.o
>   CC      dma-helpers.o
>   CC      vl.o
>   CC      tpm.o
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
>   CC      backends/rng.o
>   CC      audio/wavcapture.o
>   CC      backends/rng-egd.o
>   CC      backends/rng-random.o
>   CC      backends/msmouse.o
>   CC      backends/wctablet.o
>   CC      backends/testdev.o
>   CC      backends/tpm.o
>   CC      backends/hostmem-ram.o
>   CC      backends/hostmem.o
>   CC      backends/hostmem-file.o
>   CC      backends/cryptodev.o
>   CC      backends/cryptodev-builtin.o
>   CC      block/stream.o
>   CC      disas/arm.o
>   CC      disas/i386.o
>   CC      fsdev/qemu-fsdev-dummy.o
>   CC      fsdev/qemu-fsdev-opts.o
>   CC      fsdev/qemu-fsdev-throttle.o
>   CC      hw/acpi/core.o
>   CC      hw/acpi/piix4.o
>   CC      hw/acpi/pcihp.o
>   CC      hw/acpi/tco.o
>   CC      hw/acpi/ich9.o
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
>   CC      hw/audio/marvell_88w8618.o
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
>   CC      hw/char/parallel.o
>   CC      hw/char/pl011.o
>   CC      hw/char/serial.o
>   CC      hw/char/serial-isa.o
>   CC      hw/char/serial-pci.o
>   CC      hw/char/virtio-console.o
>   CC      hw/char/cadence_uart.o
>   CC      hw/char/debugcon.o
>   CC      hw/char/imx_serial.o
>   CC      hw/core/qdev.o
>   CC      hw/core/qdev-properties.o
>   CC      hw/core/bus.o
>   CC      hw/core/reset.o
>   CC      hw/core/irq.o
>   CC      hw/core/fw-path-provider.o
>   CC      hw/core/hotplug.o
>   CC      hw/core/ptimer.o
>   CC      hw/core/sysbus.o
>   CC      hw/core/machine.o
>   CC      hw/core/loader.o
>   CC      hw/core/qdev-properties-system.o
>   CC      hw/core/register.o
>   CC      hw/core/or-irq.o
>   CC      hw/core/platform-bus.o
>   CC      hw/display/ads7846.o
>   CC      hw/display/cirrus_vga.o
>   CC      hw/display/pl110.o
>   CC      hw/display/ssd0303.o
>   CC      hw/display/ssd0323.o
>   CC      hw/display/vga-pci.o
>   CC      hw/display/vga-isa.o
>   CC      hw/display/vmware_vga.o
>   CC      hw/display/blizzard.o
>   CC      hw/display/exynos4210_fimd.o
>   CC      hw/display/framebuffer.o
>   CC      hw/display/tc6393xb.o
>   CC      hw/dma/pl080.o
>   CC      hw/dma/pl330.o
>   CC      hw/dma/i8257.o
>   CC      hw/dma/xlnx-zynq-devcfg.o
>   CC      hw/gpio/max7310.o
>   CC      hw/gpio/pl061.o
>   CC      hw/gpio/zaurus.o
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
>   CC      hw/ide/microdrive.o
>   CC      hw/ide/ahci.o
>   CC      hw/ide/ich.o
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
>   CC      hw/intc/i8259_common.o
>   CC      hw/intc/i8259.o
>   CC      hw/intc/pl190.o
>   CC      hw/intc/imx_avic.o
>   CC      hw/intc/realview_gic.o
>   CC      hw/intc/ioapic_common.o
>   CC      hw/intc/arm_gic_common.o
>   CC      hw/intc/arm_gic.o
>   CC      hw/intc/arm_gicv2m.o
>   CC      hw/intc/arm_gicv3_common.o
>   CC      hw/intc/arm_gicv3.o
>   CC      hw/intc/arm_gicv3_dist.o
>   CC      hw/intc/arm_gicv3_redist.o
>   CC      hw/intc/arm_gicv3_its_common.o
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
>   CC      hw/net/xgmac.o
>   CC      hw/net/allwinner_emac.o
>   CC      hw/net/imx_fec.o
>   CC      hw/net/cadence_gem.o
>   CC      hw/net/stellaris_enet.o
>   CC      hw/net/rocker/rocker.o
>   CC      hw/net/rocker/rocker_fp.o
>   CC      hw/net/rocker/rocker_desc.o
>   CC      hw/net/rocker/rocker_world.o
>   CC      hw/net/rocker/rocker_of_dpa.o
>   CC      hw/nvram/eeprom93xx.o
>   CC      hw/nvram/fw_cfg.o
>   CC      hw/nvram/chrp_nvram.o
>   CC      hw/pci-bridge/pci_bridge_dev.o
>   CC      hw/pci-bridge/pcie_root_port.o
>   CC      hw/pci-bridge/gen_pcie_root_port.o
>   CC      hw/pci-bridge/pci_expander_bridge.o
>   CC      hw/pci-bridge/xio3130_upstream.o
>   CC      hw/pci-bridge/xio3130_downstream.o
>   CC      hw/pci-bridge/ioh3420.o
>   CC      hw/pci-bridge/i82801b11.o
>   CC      hw/pci-host/pam.o
>   CC      hw/pci-host/versatile.o
>   CC      hw/pci-host/piix.o
>   CC      hw/pci-host/q35.o
>   CC      hw/pci-host/gpex.o
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
>   CC      hw/timer/i8254_common.o
>   CC      hw/timer/i8254.o
>   CC      hw/timer/pl031.o
>   CC      hw/timer/twl92230.o
>   CC      hw/timer/imx_epit.o
>   CC      hw/timer/imx_gpt.o
>   CC      hw/timer/stm32f2xx_timer.o
>   CC      hw/timer/aspeed_timer.o
>   CC      hw/tpm/tpm_tis.o
>   CC      hw/tpm/tpm_passthrough.o
>   CC      hw/tpm/tpm_util.o
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
>   CC      hw/usb/dev-uas.o
>   CC      hw/usb/dev-audio.o
>   CC      hw/usb/dev-serial.o
>   CC      hw/usb/dev-network.o
>   CC      hw/usb/dev-bluetooth.o
>   CC      hw/usb/dev-smartcard-reader.o
>   CC      hw/usb/dev-mtp.o
>   CC      hw/usb/host-stub.o
>   CC      hw/virtio/virtio-rng.o
>   CC      hw/virtio/virtio-bus.o
>   CC      hw/virtio/virtio-pci.o
>   CC      hw/virtio/virtio-mmio.o
>   CC      hw/virtio/vhost-stub.o
>   CC      hw/watchdog/watchdog.o
>   CC      hw/watchdog/wdt_i6300esb.o
>   CC      hw/watchdog/wdt_ib700.o
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
> /tmp/qemu-test/src/replay/replay-internal.c: In function ‘replay_put_array’:
> /tmp/qemu-test/src/replay/replay-internal.c:65: warning: ignoring return value of ‘fwrite’, declared with attribute warn_unused_result
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
>   CC      slirp/tcp_input.o
>   CC      slirp/tcp_subr.o
>   CC      slirp/tcp_output.o
> /tmp/qemu-test/src/slirp/tcp_input.c: In function ‘tcp_input’:
> /tmp/qemu-test/src/slirp/tcp_input.c:219: warning: ‘save_ip.ip_p’ may be used uninitialized in this function
> /tmp/qemu-test/src/slirp/tcp_input.c:219: warning: ‘save_ip.ip_len’ may be used uninitialized in this function
> /tmp/qemu-test/src/slirp/tcp_input.c:219: warning: ‘save_ip.ip_tos’ may be used uninitialized in this function
> /tmp/qemu-test/src/slirp/tcp_input.c:219: warning: ‘save_ip.ip_id’ may be used uninitialized in this function
> /tmp/qemu-test/src/slirp/tcp_input.c:219: warning: ‘save_ip.ip_off’ may be used uninitialized in this function
> /tmp/qemu-test/src/slirp/tcp_input.c:219: warning: ‘save_ip.ip_ttl’ may be used uninitialized in this function
> /tmp/qemu-test/src/slirp/tcp_input.c:219: warning: ‘save_ip.ip_sum’ may be used uninitialized in this function
> /tmp/qemu-test/src/slirp/tcp_input.c:219: warning: ‘save_ip.ip_src.s_addr’ may be used uninitialized in this function
> /tmp/qemu-test/src/slirp/tcp_input.c:219: warning: ‘save_ip.ip_dst.s_addr’ may be used uninitialized in this function
> /tmp/qemu-test/src/slirp/tcp_input.c:220: warning: ‘save_ip6.ip_nh’ may be used uninitialized in this function
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
>   CC      ui/sdl.o
>   CC      ui/sdl_zoom.o
>   CC      ui/x_keymap.o
>   CC      ui/vnc.o
>   CC      ui/vnc-enc-zlib.o
>   CC      ui/vnc-enc-hextile.o
>   CC      ui/vnc-enc-tight.o
>   CC      ui/vnc-palette.o
>   CC      ui/vnc-enc-zrle.o
>   CC      ui/vnc-auth-vencrypt.o
>   CC      ui/vnc-ws.o
>   CC      ui/vnc-jobs.o
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
>   LINK    tests/qemu-iotests/socket_scm_helper
>   CC      qga/commands.o
>   CC      qga/guest-agent-command-state.o
>   CC      qga/main.o
>   CC      qga/commands-posix.o
>   CC      qga/channel-posix.o
>   CC      qga/qapi-generated/qga-qapi-types.o
>   AS      optionrom/multiboot.o
>   CC      qga/qapi-generated/qga-qapi-visit.o
>   AS      optionrom/linuxboot.o
>   CC      optionrom/linuxboot_dma.o
> cc: unrecognized option '-no-integrated-as'
> cc: unrecognized option '-no-integrated-as'
>   CC      qga/qapi-generated/qga-qmp-marshal.o
>   AS      optionrom/kvmvapic.o
>   AR      libqemuutil.a
>   AR      libqemustub.a
>   BUILD   optionrom/multiboot.img
>   BUILD   optionrom/linuxboot.img
>   BUILD   optionrom/linuxboot_dma.img
>   CC      qemu-img.o
>   BUILD   optionrom/kvmvapic.img
>   BUILD   optionrom/multiboot.raw
>   BUILD   optionrom/linuxboot.raw
>   BUILD   optionrom/linuxboot_dma.raw
>   BUILD   optionrom/kvmvapic.raw
>   LINK    ivshmem-client
>   SIGN    optionrom/multiboot.bin
>   LINK    ivshmem-server
>   SIGN    optionrom/kvmvapic.bin
>   LINK    qemu-nbd
>   LINK    qemu-img
>   SIGN    optionrom/linuxboot.bin
>   SIGN    optionrom/linuxboot_dma.bin
>   LINK    qemu-io
>   LINK    qemu-bridge-helper
>   LINK    qemu-ga
>   GEN     x86_64-softmmu/hmp-commands.h
>   GEN     x86_64-softmmu/hmp-commands-info.h
>   GEN     x86_64-softmmu/config-target.h
>   GEN     aarch64-softmmu/hmp-commands.h
>   GEN     aarch64-softmmu/hmp-commands-info.h
>   GEN     aarch64-softmmu/config-target.h
>   CC      x86_64-softmmu/exec.o
>   CC      x86_64-softmmu/translate-common.o
>   CC      x86_64-softmmu/cpu-exec-common.o
>   CC      x86_64-softmmu/translate-all.o
>   CC      x86_64-softmmu/tcg/tcg.o
>   CC      x86_64-softmmu/tcg/tcg-op.o
>   CC      x86_64-softmmu/cpu-exec.o
>   CC      aarch64-softmmu/exec.o
>   CC      x86_64-softmmu/tcg/optimize.o
>   CC      x86_64-softmmu/tcg/tcg-common.o
>   CC      x86_64-softmmu/fpu/softfloat.o
>   CC      aarch64-softmmu/translate-all.o
>   CC      x86_64-softmmu/disas.o
>   CC      x86_64-softmmu/tcg-runtime.o
>   CC      x86_64-softmmu/hax-stub.o
>   CC      aarch64-softmmu/cpu-exec.o
>   CC      x86_64-softmmu/arch_init.o
>   CC      x86_64-softmmu/cpus.o
>   CC      x86_64-softmmu/monitor.o
>   CC      x86_64-softmmu/gdbstub.o
>   CC      x86_64-softmmu/balloon.o
>   CC      aarch64-softmmu/translate-common.o
>   CC      x86_64-softmmu/ioport.o
>   CC      x86_64-softmmu/numa.o
>   CC      x86_64-softmmu/qtest.o
>   CC      x86_64-softmmu/bootdevice.o
>   CC      x86_64-softmmu/kvm-all.o
>   CC      aarch64-softmmu/cpu-exec-common.o
>   CC      x86_64-softmmu/memory.o
>   CC      x86_64-softmmu/cputlb.o
>   CC      x86_64-softmmu/memory_mapping.o
>   CC      x86_64-softmmu/dump.o
>   CC      x86_64-softmmu/migration/ram.o
>   CC      aarch64-softmmu/tcg/tcg.o
>   CC      x86_64-softmmu/migration/savevm.o
>   CC      x86_64-softmmu/xen-common-stub.o
>   CC      x86_64-softmmu/xen-hvm-stub.o
>   CC      x86_64-softmmu/hw/block/virtio-blk.o
>   CC      x86_64-softmmu/hw/block/dataplane/virtio-blk.o
>   CC      x86_64-softmmu/hw/char/virtio-serial-bus.o
>   CC      x86_64-softmmu/hw/core/nmi.o
>   CC      x86_64-softmmu/hw/core/generic-loader.o
>   CC      x86_64-softmmu/hw/core/null-machine.o
>   CC      x86_64-softmmu/hw/cpu/core.o
>   CC      aarch64-softmmu/tcg/tcg-op.o
>   CC      aarch64-softmmu/tcg/optimize.o
>   CC      x86_64-softmmu/hw/display/vga.o
>   CC      x86_64-softmmu/hw/display/virtio-gpu.o
>   CC      x86_64-softmmu/hw/display/virtio-gpu-3d.o
>   CC      x86_64-softmmu/hw/display/virtio-gpu-pci.o
>   CC      x86_64-softmmu/hw/display/virtio-vga.o
>   CC      x86_64-softmmu/hw/intc/apic.o
>   CC      x86_64-softmmu/hw/intc/apic_common.o
>   CC      x86_64-softmmu/hw/intc/ioapic.o
>   CC      aarch64-softmmu/tcg/tcg-common.o
>   CC      aarch64-softmmu/fpu/softfloat.o
>   CC      x86_64-softmmu/hw/isa/lpc_ich9.o
>   CC      x86_64-softmmu/hw/misc/vmport.o
>   CC      x86_64-softmmu/hw/misc/ivshmem.o
>   CC      x86_64-softmmu/hw/misc/pvpanic.o
>   CC      x86_64-softmmu/hw/misc/edu.o
>   CC      aarch64-softmmu/disas.o
>   CC      x86_64-softmmu/hw/misc/hyperv_testdev.o
>   CC      aarch64-softmmu/tcg-runtime.o
>   CC      x86_64-softmmu/hw/net/virtio-net.o
>   CC      x86_64-softmmu/hw/net/vhost_net.o
>   CC      x86_64-softmmu/hw/scsi/virtio-scsi.o
>   CC      x86_64-softmmu/hw/scsi/virtio-scsi-dataplane.o
>   GEN     aarch64-softmmu/gdbstub-xml.c
>   CC      aarch64-softmmu/hax-stub.o
>   CC      aarch64-softmmu/kvm-stub.o
>   CC      x86_64-softmmu/hw/scsi/vhost-scsi.o
>   CC      x86_64-softmmu/hw/timer/mc146818rtc.o
>   CC      aarch64-softmmu/arch_init.o
>   CC      x86_64-softmmu/hw/vfio/common.o
>   CC      x86_64-softmmu/hw/vfio/pci.o
>   CC      aarch64-softmmu/cpus.o
>   CC      x86_64-softmmu/hw/vfio/pci-quirks.o
>   CC      aarch64-softmmu/monitor.o
>   CC      aarch64-softmmu/gdbstub.o
>   CC      aarch64-softmmu/balloon.o
>   CC      x86_64-softmmu/hw/vfio/platform.o
>   CC      aarch64-softmmu/ioport.o
>   CC      x86_64-softmmu/hw/vfio/spapr.o
>   CC      x86_64-softmmu/hw/virtio/virtio.o
>   CC      x86_64-softmmu/hw/virtio/virtio-balloon.o
>   CC      aarch64-softmmu/numa.o
>   CC      aarch64-softmmu/qtest.o
>   CC      aarch64-softmmu/bootdevice.o
>   CC      x86_64-softmmu/hw/virtio/vhost.o
>   CC      aarch64-softmmu/memory.o
>   CC      aarch64-softmmu/cputlb.o
>   CC      aarch64-softmmu/memory_mapping.o
>   CC      aarch64-softmmu/dump.o
>   CC      x86_64-softmmu/hw/virtio/vhost-backend.o
>   CC      x86_64-softmmu/hw/virtio/vhost-user.o
>   CC      aarch64-softmmu/migration/ram.o
>   CC      aarch64-softmmu/migration/savevm.o
>   CC      aarch64-softmmu/xen-common-stub.o
>   CC      aarch64-softmmu/xen-hvm-stub.o
>   CC      x86_64-softmmu/hw/virtio/vhost-vsock.o
>   CC      aarch64-softmmu/hw/adc/stm32f2xx_adc.o
>   CC      x86_64-softmmu/hw/virtio/virtio-crypto.o
>   CC      x86_64-softmmu/hw/virtio/virtio-crypto-pci.o
>   CC      x86_64-softmmu/hw/i386/multiboot.o
>   CC      aarch64-softmmu/hw/block/virtio-blk.o
>   CC      x86_64-softmmu/hw/i386/pc.o
>   CC      x86_64-softmmu/hw/i386/pc_piix.o
>   CC      x86_64-softmmu/hw/i386/pc_q35.o
>   CC      x86_64-softmmu/hw/i386/pc_sysfw.o
>   CC      x86_64-softmmu/hw/i386/x86-iommu.o
>   CC      aarch64-softmmu/hw/block/dataplane/virtio-blk.o
>   CC      x86_64-softmmu/hw/i386/intel_iommu.o
>   CC      x86_64-softmmu/hw/i386/amd_iommu.o
>   CC      x86_64-softmmu/hw/i386/kvmvapic.o
>   CC      x86_64-softmmu/hw/i386/acpi-build.o
> /tmp/qemu-test/src/hw/i386/pc_piix.c: In function ‘igd_passthrough_isa_bridge_create’:
> /tmp/qemu-test/src/hw/i386/pc_piix.c:1055: warning: ‘pch_rev_id’ may be used uninitialized in this function
>   CC      aarch64-softmmu/hw/char/exynos4210_uart.o
>   CC      x86_64-softmmu/hw/i386/pci-assign-load-rom.o
>   CC      x86_64-softmmu/hw/i386/kvm/clock.o
>   CC      aarch64-softmmu/hw/char/omap_uart.o
>   CC      x86_64-softmmu/hw/i386/kvm/apic.o
>   CC      aarch64-softmmu/hw/char/digic-uart.o
>   CC      aarch64-softmmu/hw/char/stm32f2xx_usart.o
> /tmp/qemu-test/src/hw/i386/acpi-build.c: In function ‘build_append_pci_bus_devices’:
> /tmp/qemu-test/src/hw/i386/acpi-build.c:496: warning: ‘notify_method’ may be used uninitialized in this function
>   CC      x86_64-softmmu/hw/i386/kvm/i8259.o
>   CC      aarch64-softmmu/hw/char/bcm2835_aux.o
>   CC      aarch64-softmmu/hw/char/virtio-serial-bus.o
>   CC      aarch64-softmmu/hw/core/nmi.o
>   CC      x86_64-softmmu/hw/i386/kvm/ioapic.o
>   CC      x86_64-softmmu/hw/i386/kvm/i8254.o
>   CC      aarch64-softmmu/hw/core/generic-loader.o
>   CC      x86_64-softmmu/hw/i386/kvm/pci-assign.o
>   CC      x86_64-softmmu/target/i386/translate.o
>   CC      x86_64-softmmu/target/i386/helper.o
>   CC      aarch64-softmmu/hw/core/null-machine.o
>   CC      aarch64-softmmu/hw/cpu/arm11mpcore.o
>   CC      aarch64-softmmu/hw/cpu/realview_mpcore.o
>   CC      x86_64-softmmu/target/i386/cpu.o
>   CC      aarch64-softmmu/hw/cpu/a9mpcore.o
>   CC      aarch64-softmmu/hw/cpu/a15mpcore.o
>   CC      x86_64-softmmu/target/i386/bpt_helper.o
>   CC      x86_64-softmmu/target/i386/excp_helper.o
>   CC      aarch64-softmmu/hw/cpu/core.o
>   CC      x86_64-softmmu/target/i386/fpu_helper.o
>   CC      aarch64-softmmu/hw/display/omap_dss.o
>   CC      aarch64-softmmu/hw/display/omap_lcdc.o
>   CC      x86_64-softmmu/target/i386/cc_helper.o
>   CC      x86_64-softmmu/target/i386/int_helper.o
>   CC      aarch64-softmmu/hw/display/pxa2xx_lcd.o
>   CC      aarch64-softmmu/hw/display/bcm2835_fb.o
>   CC      x86_64-softmmu/target/i386/svm_helper.o
>   CC      x86_64-softmmu/target/i386/smm_helper.o
>   CC      aarch64-softmmu/hw/display/vga.o
>   CC      x86_64-softmmu/target/i386/misc_helper.o
>   CC      aarch64-softmmu/hw/display/virtio-gpu.o
>   CC      aarch64-softmmu/hw/display/virtio-gpu-3d.o
>   CC      aarch64-softmmu/hw/display/virtio-gpu-pci.o
>   CC      x86_64-softmmu/target/i386/mem_helper.o
>   CC      x86_64-softmmu/target/i386/seg_helper.o
>   CC      aarch64-softmmu/hw/display/dpcd.o
>   CC      x86_64-softmmu/target/i386/mpx_helper.o
>   CC      aarch64-softmmu/hw/display/xlnx_dp.o
>   CC      aarch64-softmmu/hw/dma/xlnx_dpdma.o
>   CC      aarch64-softmmu/hw/dma/omap_dma.o
>   CC      aarch64-softmmu/hw/dma/soc_dma.o
>   CC      x86_64-softmmu/target/i386/gdbstub.o
>   CC      aarch64-softmmu/hw/dma/pxa2xx_dma.o
>   CC      aarch64-softmmu/hw/dma/bcm2835_dma.o
>   CC      x86_64-softmmu/target/i386/machine.o
>   CC      aarch64-softmmu/hw/gpio/omap_gpio.o
>   CC      x86_64-softmmu/target/i386/arch_memory_mapping.o
>   CC      x86_64-softmmu/target/i386/arch_dump.o
>   CC      x86_64-softmmu/target/i386/monitor.o
>   CC      x86_64-softmmu/target/i386/kvm.o
>   CC      aarch64-softmmu/hw/gpio/imx_gpio.o
>   CC      x86_64-softmmu/target/i386/hyperv.o
>   CC      aarch64-softmmu/hw/gpio/bcm2835_gpio.o
>   CC      aarch64-softmmu/hw/i2c/omap_i2c.o
>   GEN     trace/generated-helpers.c
>   CC      aarch64-softmmu/hw/input/pxa2xx_keypad.o
>   CC      aarch64-softmmu/hw/input/tsc210x.o
>   CC      aarch64-softmmu/hw/intc/armv7m_nvic.o
>   CC      x86_64-softmmu/trace/control-target.o
>   CC      aarch64-softmmu/hw/intc/exynos4210_gic.o
>   CC      aarch64-softmmu/hw/intc/exynos4210_combiner.o
>   CC      aarch64-softmmu/hw/intc/omap_intc.o
>   CC      x86_64-softmmu/trace/generated-helpers.o
>   CC      aarch64-softmmu/hw/intc/bcm2835_ic.o
>   CC      aarch64-softmmu/hw/intc/bcm2836_control.o
>   CC      aarch64-softmmu/hw/intc/allwinner-a10-pic.o
>   CC      aarch64-softmmu/hw/intc/arm_gicv3_cpuif.o
>   CC      aarch64-softmmu/hw/intc/aspeed_vic.o
>   CC      aarch64-softmmu/hw/misc/ivshmem.o
>   CC      aarch64-softmmu/hw/misc/arm_sysctl.o
>   LINK    x86_64-softmmu/qemu-system-x86_64
>   CC      aarch64-softmmu/hw/misc/cbus.o
>   CC      aarch64-softmmu/hw/misc/exynos4210_pmu.o
>   CC      aarch64-softmmu/hw/misc/exynos4210_clk.o
>   CC      aarch64-softmmu/hw/misc/imx_ccm.o
>   CC      aarch64-softmmu/hw/misc/imx25_ccm.o
>   CC      aarch64-softmmu/hw/misc/imx31_ccm.o
>   CC      aarch64-softmmu/hw/misc/imx6_src.o
>   CC      aarch64-softmmu/hw/misc/imx6_ccm.o
>   CC      aarch64-softmmu/hw/misc/mst_fpga.o
>   CC      aarch64-softmmu/hw/misc/omap_clk.o
>   CC      aarch64-softmmu/hw/misc/omap_gpmc.o
>   CC      aarch64-softmmu/hw/misc/omap_l4.o
>   CC      aarch64-softmmu/hw/misc/omap_sdrc.o
>   CC      aarch64-softmmu/hw/misc/omap_tap.o
>   CC      aarch64-softmmu/hw/misc/bcm2835_mbox.o
>   CC      aarch64-softmmu/hw/misc/bcm2835_property.o
>   CC      aarch64-softmmu/hw/misc/bcm2835_rng.o
>   CC      aarch64-softmmu/hw/misc/zynq_slcr.o
>   CC      aarch64-softmmu/hw/misc/zynq-xadc.o
>   CC      aarch64-softmmu/hw/misc/stm32f2xx_syscfg.o
>   CC      aarch64-softmmu/hw/misc/edu.o
>   CC      aarch64-softmmu/hw/misc/auxbus.o
>   CC      aarch64-softmmu/hw/misc/aspeed_scu.o
>   CC      aarch64-softmmu/hw/misc/aspeed_sdmc.o
>   CC      aarch64-softmmu/hw/net/virtio-net.o
>   CC      aarch64-softmmu/hw/net/vhost_net.o
>   CC      aarch64-softmmu/hw/pcmcia/pxa2xx.o
>   CC      aarch64-softmmu/hw/scsi/virtio-scsi.o
>   CC      aarch64-softmmu/hw/scsi/virtio-scsi-dataplane.o
>   CC      aarch64-softmmu/hw/scsi/vhost-scsi.o
>   CC      aarch64-softmmu/hw/sd/omap_mmc.o
>   CC      aarch64-softmmu/hw/sd/pxa2xx_mmci.o
>   CC      aarch64-softmmu/hw/sd/bcm2835_sdhost.o
>   CC      aarch64-softmmu/hw/ssi/omap_spi.o
>   CC      aarch64-softmmu/hw/ssi/imx_spi.o
>   CC      aarch64-softmmu/hw/timer/exynos4210_mct.o
>   CC      aarch64-softmmu/hw/timer/exynos4210_pwm.o
>   CC      aarch64-softmmu/hw/timer/exynos4210_rtc.o
>   CC      aarch64-softmmu/hw/timer/omap_gptimer.o
>   CC      aarch64-softmmu/hw/timer/omap_synctimer.o
>   CC      aarch64-softmmu/hw/timer/pxa2xx_timer.o
>   CC      aarch64-softmmu/hw/timer/digic-timer.o
>   CC      aarch64-softmmu/hw/timer/allwinner-a10-pit.o
>   CC      aarch64-softmmu/hw/usb/tusb6010.o
>   CC      aarch64-softmmu/hw/vfio/common.o
>   CC      aarch64-softmmu/hw/vfio/pci-quirks.o
>   CC      aarch64-softmmu/hw/vfio/pci.o
>   CC      aarch64-softmmu/hw/vfio/calxeda-xgmac.o
>   CC      aarch64-softmmu/hw/vfio/amd-xgbe.o
>   CC      aarch64-softmmu/hw/vfio/spapr.o
>   CC      aarch64-softmmu/hw/vfio/platform.o
>   CC      aarch64-softmmu/hw/virtio/virtio.o
>   CC      aarch64-softmmu/hw/virtio/virtio-balloon.o
>   CC      aarch64-softmmu/hw/virtio/vhost.o
>   CC      aarch64-softmmu/hw/virtio/vhost-backend.o
>   CC      aarch64-softmmu/hw/virtio/vhost-user.o
>   CC      aarch64-softmmu/hw/virtio/vhost-vsock.o
>   CC      aarch64-softmmu/hw/virtio/virtio-crypto.o
>   CC      aarch64-softmmu/hw/virtio/virtio-crypto-pci.o
>   CC      aarch64-softmmu/hw/arm/boot.o
>   CC      aarch64-softmmu/hw/arm/collie.o
>   CC      aarch64-softmmu/hw/arm/exynos4_boards.o
>   CC      aarch64-softmmu/hw/arm/gumstix.o
>   CC      aarch64-softmmu/hw/arm/highbank.o
>   CC      aarch64-softmmu/hw/arm/digic_boards.o
>   CC      aarch64-softmmu/hw/arm/integratorcp.o
>   CC      aarch64-softmmu/hw/arm/mainstone.o
>   CC      aarch64-softmmu/hw/arm/musicpal.o
>   CC      aarch64-softmmu/hw/arm/nseries.o
>   CC      aarch64-softmmu/hw/arm/omap_sx1.o
>   CC      aarch64-softmmu/hw/arm/palm.o
>   CC      aarch64-softmmu/hw/arm/realview.o
>   CC      aarch64-softmmu/hw/arm/spitz.o
>   CC      aarch64-softmmu/hw/arm/stellaris.o
>   CC      aarch64-softmmu/hw/arm/tosa.o
>   CC      aarch64-softmmu/hw/arm/versatilepb.o
>   CC      aarch64-softmmu/hw/arm/vexpress.o
>   CC      aarch64-softmmu/hw/arm/virt.o
>   CC      aarch64-softmmu/hw/arm/xilinx_zynq.o
>   CC      aarch64-softmmu/hw/arm/z2.o
>   CC      aarch64-softmmu/hw/arm/virt-acpi-build.o
>   CC      aarch64-softmmu/hw/arm/netduino2.o
>   CC      aarch64-softmmu/hw/arm/sysbus-fdt.o
>   CC      aarch64-softmmu/hw/arm/armv7m.o
>   CC      aarch64-softmmu/hw/arm/exynos4210.o
>   CC      aarch64-softmmu/hw/arm/pxa2xx.o
>   CC      aarch64-softmmu/hw/arm/pxa2xx_gpio.o
>   CC      aarch64-softmmu/hw/arm/pxa2xx_pic.o
>   CC      aarch64-softmmu/hw/arm/digic.o
>   CC      aarch64-softmmu/hw/arm/omap1.o
>   CC      aarch64-softmmu/hw/arm/omap2.o
>   CC      aarch64-softmmu/hw/arm/strongarm.o
>   CC      aarch64-softmmu/hw/arm/allwinner-a10.o
>   CC      aarch64-softmmu/hw/arm/cubieboard.o
>   CC      aarch64-softmmu/hw/arm/bcm2836.o
>   CC      aarch64-softmmu/hw/arm/bcm2835_peripherals.o
>   CC      aarch64-softmmu/hw/arm/raspi.o
>   CC      aarch64-softmmu/hw/arm/stm32f205_soc.o
>   CC      aarch64-softmmu/hw/arm/xlnx-zynqmp.o
>   CC      aarch64-softmmu/hw/arm/xlnx-ep108.o
>   CC      aarch64-softmmu/hw/arm/fsl-imx25.o
>   CC      aarch64-softmmu/hw/arm/imx25_pdk.o
>   CC      aarch64-softmmu/hw/arm/fsl-imx31.o
>   CC      aarch64-softmmu/hw/arm/kzm.o
>   CC      aarch64-softmmu/hw/arm/fsl-imx6.o
>   CC      aarch64-softmmu/hw/arm/sabrelite.o
>   CC      aarch64-softmmu/hw/arm/aspeed_soc.o
>   CC      aarch64-softmmu/hw/arm/aspeed.o
>   CC      aarch64-softmmu/target/arm/arm-semi.o
>   CC      aarch64-softmmu/target/arm/machine.o
>   CC      aarch64-softmmu/target/arm/psci.o
>   CC      aarch64-softmmu/target/arm/arch_dump.o
>   CC      aarch64-softmmu/target/arm/monitor.o
>   CC      aarch64-softmmu/target/arm/kvm-stub.o
>   CC      aarch64-softmmu/target/arm/translate.o
>   CC      aarch64-softmmu/target/arm/op_helper.o
>   CC      aarch64-softmmu/target/arm/helper.o
>   CC      aarch64-softmmu/target/arm/cpu.o
>   CC      aarch64-softmmu/target/arm/neon_helper.o
>   CC      aarch64-softmmu/target/arm/iwmmxt_helper.o
>   CC      aarch64-softmmu/target/arm/gdbstub.o
>   CC      aarch64-softmmu/target/arm/cpu64.o
>   CC      aarch64-softmmu/target/arm/translate-a64.o
>   CC      aarch64-softmmu/target/arm/helper-a64.o
>   CC      aarch64-softmmu/target/arm/gdbstub64.o
>   CC      aarch64-softmmu/target/arm/crypto_helper.o
>   CC      aarch64-softmmu/target/arm/arm-powerctl.o
>   GEN     trace/generated-helpers.c
>   CC      aarch64-softmmu/trace/control-target.o
> /tmp/qemu-test/src/target/arm/translate-a64.c: In function ‘handle_shri_with_rndacc’:
> /tmp/qemu-test/src/target/arm/translate-a64.c:6359: warning: ‘tcg_src_hi’ may be used uninitialized in this function
> /tmp/qemu-test/src/target/arm/translate-a64.c: In function ‘disas_simd_scalar_two_reg_misc’:
> /tmp/qemu-test/src/target/arm/translate-a64.c:8086: warning: ‘rmode’ may be used uninitialized in this function
>   CC      aarch64-softmmu/gdbstub-xml.o
>   CC      aarch64-softmmu/trace/generated-helpers.o
>   LINK    aarch64-softmmu/qemu-system-aarch64
> 	 LEX convert-dtsv0-lexer.lex.c
> make[1]: flex: Command not found
> 	 BISON dtc-parser.tab.c
> 	 LEX dtc-lexer.lex.c
> make[1]: bison: Command not found
> make[1]: flex: Command not found
>   TEST    tests/qapi-schema/alternate-any.out
>   TEST    tests/qapi-schema/alternate-array.out
>   TEST    tests/qapi-schema/alternate-clash.out
>   TEST    tests/qapi-schema/alternate-base.out
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
>   TEST    tests/qapi-schema/args-name-clash.out
>   TEST    tests/qapi-schema/args-union.out
>   TEST    tests/qapi-schema/args-member-unknown.out
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
>   TEST    tests/qapi-schema/doc-bad-alternate-member.out
>   TEST    tests/qapi-schema/doc-bad-command-arg.out
>   TEST    tests/qapi-schema/doc-bad-symbol.out
>   TEST    tests/qapi-schema/doc-bad-union-member.out
>   TEST    tests/qapi-schema/doc-before-include.out
>   TEST    tests/qapi-schema/doc-before-pragma.out
>   TEST    tests/qapi-schema/doc-duplicated-arg.out
>   TEST    tests/qapi-schema/doc-duplicated-return.out
>   TEST    tests/qapi-schema/doc-duplicated-since.out
>   TEST    tests/qapi-schema/doc-empty-arg.out
>   TEST    tests/qapi-schema/doc-empty-section.out
>   TEST    tests/qapi-schema/doc-empty-symbol.out
>   TEST    tests/qapi-schema/doc-good.out
>   TEST    tests/qapi-schema/doc-interleaved-section.out
>   TEST    tests/qapi-schema/doc-invalid-end.out
>   TEST    tests/qapi-schema/doc-invalid-end2.out
>   TEST    tests/qapi-schema/doc-invalid-return.out
>   TEST    tests/qapi-schema/doc-invalid-section.out
>   TEST    tests/qapi-schema/doc-invalid-start.out
>   TEST    tests/qapi-schema/doc-missing.out
>   TEST    tests/qapi-schema/doc-missing-colon.out
>   TEST    tests/qapi-schema/doc-missing-expr.out
>   TEST    tests/qapi-schema/doc-missing-space.out
>   TEST    tests/qapi-schema/doc-no-symbol.out
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
>   TEST    tests/qapi-schema/event-case.out
>   TEST    tests/qapi-schema/event-nest-struct.out
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
>   TEST    tests/qapi-schema/include-cycle.out
>   TEST    tests/qapi-schema/include-extra-junk.out
>   TEST    tests/qapi-schema/include-format-err.out
>   TEST    tests/qapi-schema/include-nested-err.out
>   TEST    tests/qapi-schema/include-no-file.out
>   TEST    tests/qapi-schema/include-non-file.out
>   TEST    tests/qapi-schema/include-relpath.out
>   TEST    tests/qapi-schema/include-repetition.out
>   TEST    tests/qapi-schema/include-simple.out
>   TEST    tests/qapi-schema/indented-expr.out
>   TEST    tests/qapi-schema/leading-comma-list.out
>   TEST    tests/qapi-schema/include-self-cycle.out
>   TEST    tests/qapi-schema/leading-comma-object.out
>   TEST    tests/qapi-schema/missing-colon.out
>   TEST    tests/qapi-schema/missing-comma-list.out
>   TEST    tests/qapi-schema/missing-comma-object.out
>   TEST    tests/qapi-schema/missing-type.out
>   TEST    tests/qapi-schema/nested-struct-data.out
>   TEST    tests/qapi-schema/non-objects.out
>   TEST    tests/qapi-schema/pragma-doc-required-crap.out
>   TEST    tests/qapi-schema/pragma-extra-junk.out
>   TEST    tests/qapi-schema/pragma-name-case-whitelist-crap.out
>   TEST    tests/qapi-schema/pragma-non-dict.out
>   TEST    tests/qapi-schema/pragma-returns-whitelist-crap.out
>   TEST    tests/qapi-schema/qapi-schema-test.out
>   TEST    tests/qapi-schema/quoted-structural-chars.out
>   TEST    tests/qapi-schema/redefined-command.out
>   TEST    tests/qapi-schema/redefined-event.out
>   TEST    tests/qapi-schema/redefined-builtin.out
>   TEST    tests/qapi-schema/redefined-type.out
>   TEST    tests/qapi-schema/reserved-command-q.out
>   TEST    tests/qapi-schema/reserved-enum-q.out
>   TEST    tests/qapi-schema/reserved-member-has.out
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
>   TEST    tests/qapi-schema/union-base-empty.out
>   TEST    tests/qapi-schema/union-base-no-discriminator.out
>   TEST    tests/qapi-schema/union-branch-case.out
>   TEST    tests/qapi-schema/union-clash-branches.out
>   TEST    tests/qapi-schema/union-empty.out
>   TEST    tests/qapi-schema/union-invalid-base.out
>   TEST    tests/qapi-schema/union-optional-branch.out
>   TEST    tests/qapi-schema/union-unknown.out
>   TEST    tests/qapi-schema/unknown-escape.out
>   TEST    tests/qapi-schema/unknown-expr-key.out
>   GEN     tests/qapi-schema/doc-good.test.texi
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
>   CC      tests/test-qmp-commands.o
>   GEN     tests/test-qmp-marshal.c
>   CC      tests/test-string-input-visitor.o
>   CC      tests/test-string-output-visitor.o
>   CC      tests/test-qmp-event.o
>   CC      tests/test-opts-visitor.o
>   CC      tests/test-coroutine.o
>   CC      tests/iothread.o
>   CC      tests/test-iov.o
>   CC      tests/test-visitor-serialization.o
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
> /tmp/qemu-test/src/tests/test-int128.c:180: warning: ‘__noclone__’ attribute directive ignored
>   CC      tests/test-bitops.o
>   CC      tests/test-bitcnt.o
>   CC      tests/check-qom-interface.o
>   CC      tests/check-qom-proplist.o
>   CC      tests/test-qemu-opts.o
>   CC      tests/test-keyval.o
>   CC      tests/test-write-threshold.o
>   CC      tests/test-crypto-hash.o
>   CC      tests/test-crypto-hmac.o
>   CC      tests/test-crypto-cipher.o
>   CC      tests/test-qga.o
>   CC      tests/test-crypto-secret.o
>   CC      tests/libqtest.o
>   CC      tests/test-io-task.o
>   CC      tests/test-timed-average.o
>   CC      tests/test-io-channel-socket.o
>   CC      tests/io-channel-helpers.o
>   CC      tests/test-io-channel-file.o
>   CC      tests/test-io-channel-command.o
>   CC      tests/test-io-channel-buffer.o
>   CC      tests/test-base64.o
>   CC      tests/test-crypto-ivgen.o
>   CC      tests/test-crypto-afsplit.o
>   CC      tests/test-crypto-xts.o
>   CC      tests/test-crypto-block.o
>   CC      tests/test-logging.o
>   CC      tests/test-replication.o
>   CC      tests/test-bufferiszero.o
>   CC      tests/test-uuid.o
>   CC      tests/ptimer-test.o
>   CC      tests/ptimer-test-stubs.o
>   CC      tests/test-qapi-util.o
>   CC      tests/vhost-user-test.o
>   CC      tests/libqos/pci.o
>   CC      tests/libqos/fw_cfg.o
>   CC      tests/libqos/malloc.o
>   CC      tests/libqos/i2c.o
>   CC      tests/libqos/libqos.o
>   CC      tests/libqos/malloc-spapr.o
>   CC      tests/libqos/libqos-spapr.o
>   CC      tests/libqos/rtas.o
>   CC      tests/libqos/pci-spapr.o
>   CC      tests/libqos/pci-pc.o
>   CC      tests/libqos/malloc-pc.o
>   CC      tests/libqos/libqos-pc.o
>   CC      tests/libqos/ahci.o
>   CC      tests/libqos/virtio-pci.o
>   CC      tests/libqos/virtio.o
>   CC      tests/libqos/virtio-mmio.o
>   CC      tests/libqos/malloc-generic.o
>   CC      tests/endianness-test.o
>   CC      tests/ide-test.o
>   CC      tests/fdc-test.o
>   CC      tests/ahci-test.o
> /tmp/qemu-test/src/tests/ide-test.c: In function ‘cdrom_pio_impl’:
> /tmp/qemu-test/src/tests/ide-test.c:803: warning: ignoring return value of ‘fwrite’, declared with attribute warn_unused_result
> /tmp/qemu-test/src/tests/ide-test.c: In function ‘test_cdrom_dma’:
> /tmp/qemu-test/src/tests/ide-test.c:899: warning: ignoring return value of ‘fwrite’, declared with attribute warn_unused_result
>   CC      tests/hd-geo-test.o
>   CC      tests/boot-order-test.o
>   CC      tests/bios-tables-test.o
>   CC      tests/acpi-utils.o
>   CC      tests/boot-sector.o
>   CC      tests/boot-serial-test.o
>   CC      tests/pxe-test.o
>   CC      tests/rtc-test.o
>   CC      tests/ipmi-kcs-test.o
>   CC      tests/ipmi-bt-test.o
>   CC      tests/i440fx-test.o
>   CC      tests/fw_cfg-test.o
>   CC      tests/drive_del-test.o
>   CC      tests/tco-test.o
>   CC      tests/wdt_ib700-test.o
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
>   CC      tests/virtio-blk-test.o
>   CC      tests/virtio-scsi-test.o
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
>   CC      tests/test-netfilter.o
>   CC      tests/test-filter-mirror.o
>   CC      tests/test-filter-redirector.o
>   CC      tests/postcopy-test.o
>   CC      tests/test-x86-cpuid-compat.o
>   CC      tests/qmp-test.o
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
>   LINK    tests/test-visitor-serialization
>   LINK    tests/test-iov
>   LINK    tests/test-aio
>   LINK    tests/test-aio-multithread
>   LINK    tests/test-throttle
>   LINK    tests/test-thread-pool
>   LINK    tests/test-hbitmap
>   LINK    tests/test-blockjob
>   LINK    tests/test-x86-cpuid
>   LINK    tests/test-blockjob-txn
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
>   LINK    tests/qht-bench
>   LINK    tests/test-bitops
>   LINK    tests/test-bitcnt
>   LINK    tests/check-qom-interface
>   LINK    tests/check-qom-proplist
>   LINK    tests/test-qemu-opts
>   LINK    tests/test-keyval
>   LINK    tests/test-write-threshold
>   LINK    tests/test-crypto-hash
>   LINK    tests/test-crypto-hmac
>   LINK    tests/test-crypto-cipher
>   LINK    tests/test-crypto-secret
>   LINK    tests/test-qga
>   LINK    tests/test-timed-average
>   LINK    tests/test-io-task
>   LINK    tests/test-io-channel-socket
>   LINK    tests/test-io-channel-file
>   LINK    tests/test-io-channel-command
>   LINK    tests/test-io-channel-buffer
>   LINK    tests/test-base64
>   LINK    tests/test-crypto-ivgen
>   LINK    tests/test-crypto-afsplit
>   LINK    tests/test-crypto-xts
>   LINK    tests/test-crypto-block
>   LINK    tests/test-logging
>   LINK    tests/test-replication
>   LINK    tests/test-bufferiszero
>   LINK    tests/test-uuid
>   LINK    tests/ptimer-test
>   LINK    tests/test-qapi-util
>   LINK    tests/vhost-user-test
>   LINK    tests/endianness-test
>   LINK    tests/fdc-test
>   LINK    tests/ide-test
>   LINK    tests/ahci-test
>   LINK    tests/hd-geo-test
>   LINK    tests/boot-order-test
>   LINK    tests/bios-tables-test
>   LINK    tests/boot-serial-test
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
>   LINK    tests/virtio-blk-test
>   LINK    tests/virtio-rng-test
>   LINK    tests/virtio-scsi-test
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
>   LINK    tests/pc-cpu-test
>   LINK    tests/q35-test
>   LINK    tests/test-netfilter
>   LINK    tests/test-filter-mirror
>   LINK    tests/test-filter-redirector
>   LINK    tests/postcopy-test
>   LINK    tests/test-x86-cpuid-compat
>   LINK    tests/qmp-test
>   LINK    tests/device-introspect-test
>   LINK    tests/qom-test
>   GTESTER tests/check-qdict
>   GTESTER tests/test-char
>   GTESTER tests/check-qfloat
>   GTESTER tests/check-qint
>   GTESTER tests/check-qstring
>   GTESTER tests/check-qlist
>   GTESTER tests/check-qnull
>   GTESTER tests/check-qjson
>   LINK    tests/test-qobject-output-visitor
>   LINK    tests/test-clone-visitor
>   LINK    tests/test-qobject-input-visitor
>   LINK    tests/test-qmp-commands
>   LINK    tests/test-string-input-visitor
>   LINK    tests/test-string-output-visitor
>   LINK    tests/test-qmp-event
>   LINK    tests/test-opts-visitor
>   GTESTER tests/test-coroutine
>   GTESTER tests/test-visitor-serialization
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
> Failed to load simple/primitive:b_1
> Failed to load simple/primitive:i64_2
> Failed to load simple/primitive:i32_1
> Failed to load simple/primitive:i32_1
> Failed to load test/with_tmp:a
> Failed to load test/tmp_child_parent:f
> Failed to load test/tmp_child:parent
> Failed to load test/with_tmp:tmp
> Failed to load test/tmp_child:diff
> Failed to load test/with_tmp:tmp
> Failed to load test/tmp_child:diff
> Failed to load test/with_tmp:tmp
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
>   GTESTER tests/check-qom-interface
>   GTESTER tests/check-qom-proplist
>   GTESTER tests/test-qemu-opts
>   GTESTER tests/test-keyval
>   GTESTER tests/test-write-threshold
>   GTESTER tests/test-crypto-hash
>   GTESTER tests/test-crypto-hmac
>   GTESTER tests/test-crypto-cipher
>   GTESTER tests/test-crypto-secret
>   GTESTER tests/test-qga
>   GTESTER tests/test-timed-average
>   GTESTER tests/test-io-task
>   GTESTER tests/test-io-channel-socket
>   GTESTER tests/test-io-channel-file
>   GTESTER tests/test-io-channel-command
>   GTESTER tests/test-io-channel-buffer
>   GTESTER tests/test-base64
>   GTESTER tests/test-crypto-ivgen
>   GTESTER tests/test-crypto-afsplit
>   GTESTER tests/test-crypto-xts
>   GTESTER tests/test-crypto-block
>   GTESTER tests/test-logging
>   GTESTER tests/test-replication
>   GTESTER tests/test-bufferiszero
>   GTESTER tests/test-uuid
>   GTESTER tests/ptimer-test
>   GTESTER tests/test-qapi-util
>   GTESTER check-qtest-x86_64
>   GTESTER check-qtest-aarch64
>   GTESTER tests/test-qobject-output-visitor
>   GTESTER tests/test-clone-visitor
>   GTESTER tests/test-qobject-input-visitor
>   GTESTER tests/test-qmp-commands
>   GTESTER tests/test-string-input-visitor
>   GTESTER tests/test-string-output-visitor
>   GTESTER tests/test-qmp-event
>   GTESTER tests/test-opts-visitor
>   GTESTER tests/test-qht-par
> Could not access KVM kernel module: No such file or directory
> failed to initialize KVM: No such file or directory
> Back to tcg accelerator.
> Could not access KVM kernel module: No such file or directory
> failed to initialize KVM: No such file or directory
> Back to tcg accelerator.
> Could not access KVM kernel module: No such file or directory
> failed to initialize KVM: No such file or directory
> Back to tcg accelerator.
> Could not access KVM kernel module: No such file or directory
> failed to initialize KVM: No such file or directory
> Back to tcg accelerator.
> Could not access KVM kernel module: No such file or directory
> failed to initialize KVM: No such file or directory
> Back to tcg accelerator.
> Could not access KVM kernel module: No such file or directory
> failed to initialize KVM: No such file or directory
> Back to tcg accelerator.
> Could not access KVM kernel module: No such file or directory
> failed to initialize KVM: No such file or directory
> Back to tcg accelerator.
> Could not access KVM kernel module: No such file or directory
> failed to initialize KVM: No such file or directory
> Back to tcg accelerator.
> Could not access KVM kernel module: No such file or directory
> failed to initialize KVM: No such file or directory
> Back to tcg accelerator.
> Could not access KVM kernel module: No such file or directory
> failed to initialize KVM: No such file or directory
> Back to tcg accelerator.
> make[1]: Leaving directory '/var/tmp/patchew-tester-tmp-e8571v4e/src'
>   BUILD   fedora
> make[1]: Entering directory '/var/tmp/patchew-tester-tmp-e8571v4e/src'
>   ARCHIVE qemu.tgz
>   ARCHIVE dtc.tgz
>   COPY    RUNNER
>     RUN test-mingw in qemu:fedora 
> Packages installed:
> PyYAML-3.11-13.fc25.x86_64
> SDL-devel-1.2.15-21.fc24.x86_64
> bc-1.06.95-16.fc24.x86_64
> bison-3.0.4-4.fc24.x86_64
> ccache-3.3.4-1.fc25.x86_64
> clang-3.9.1-2.fc25.x86_64
> findutils-4.6.0-8.fc25.x86_64
> flex-2.6.0-3.fc25.x86_64
> gcc-6.3.1-1.fc25.x86_64
> gcc-c++-6.3.1-1.fc25.x86_64
> git-2.9.3-2.fc25.x86_64
> glib2-devel-2.50.3-1.fc25.x86_64
> libfdt-devel-1.4.2-1.fc25.x86_64
> make-4.1-5.fc24.x86_64
> mingw32-SDL-1.2.15-7.fc24.noarch
> mingw32-bzip2-1.0.6-7.fc24.noarch
> mingw32-curl-7.47.0-1.fc24.noarch
> mingw32-glib2-2.50.1-1.fc25.noarch
> mingw32-gmp-6.1.1-1.fc25.noarch
> mingw32-gnutls-3.5.5-2.fc25.noarch
> mingw32-gtk2-2.24.31-2.fc25.noarch
> mingw32-gtk3-3.22.2-1.fc25.noarch
> mingw32-libjpeg-turbo-1.5.1-1.fc25.noarch
> mingw32-libpng-1.6.27-1.fc25.noarch
> mingw32-libssh2-1.4.3-5.fc24.noarch
> mingw32-libtasn1-4.9-1.fc25.noarch
> mingw32-nettle-3.3-1.fc25.noarch
> mingw32-pixman-0.34.0-1.fc25.noarch
> mingw32-pkg-config-0.28-6.fc24.x86_64
> mingw64-SDL-1.2.15-7.fc24.noarch
> mingw64-bzip2-1.0.6-7.fc24.noarch
> mingw64-curl-7.47.0-1.fc24.noarch
> mingw64-glib2-2.50.1-1.fc25.noarch
> mingw64-gmp-6.1.1-1.fc25.noarch
> mingw64-gnutls-3.5.5-2.fc25.noarch
> mingw64-gtk2-2.24.31-2.fc25.noarch
> mingw64-gtk3-3.22.2-1.fc25.noarch
> mingw64-libjpeg-turbo-1.5.1-1.fc25.noarch
> mingw64-libpng-1.6.27-1.fc25.noarch
> mingw64-libssh2-1.4.3-5.fc24.noarch
> mingw64-libtasn1-4.9-1.fc25.noarch
> mingw64-nettle-3.3-1.fc25.noarch
> mingw64-pixman-0.34.0-1.fc25.noarch
> mingw64-pkg-config-0.28-6.fc24.x86_64
> package python2 is not installed
> perl-5.24.1-385.fc25.x86_64
> pixman-devel-0.34.0-2.fc24.x86_64
> sparse-0.5.0-10.fc25.x86_64
> tar-1.29-3.fc25.x86_64
> which-2.21-1.fc25.x86_64
> zlib-devel-1.2.8-10.fc24.x86_64
> 
> Environment variables:
> FBR=f25
> PACKAGES=ccache git tar PyYAML sparse flex bison python2     glib2-devel pixman-devel zlib-devel SDL-devel libfdt-devel     gcc gcc-c++ clang make perl which bc findutils     mingw32-pixman mingw32-glib2 mingw32-gmp mingw32-SDL mingw32-pkg-config     mingw32-gtk2 mingw32-gtk3 mingw32-gnutls mingw32-nettle mingw32-libtasn1     mingw32-libjpeg-turbo mingw32-libpng mingw32-curl mingw32-libssh2     mingw32-bzip2     mingw64-pixman mingw64-glib2 mingw64-gmp mingw64-SDL mingw64-pkg-config     mingw64-gtk2 mingw64-gtk3 mingw64-gnutls mingw64-nettle mingw64-libtasn1     mingw64-libjpeg-turbo mingw64-libpng mingw64-curl mingw64-libssh2     mingw64-bzip2
> HOSTNAME=
> TERM=xterm
> MAKEFLAGS= -j8
> HISTSIZE=1000
> J=8
> USER=root
> LS_COLORS=rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=01;05;37;41:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.
vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=01;36:*.au=01;36:*.flac=01;36:*.m4a=01;36:*.mid=01;36:*.midi=01;36:*.mka=01;36:*.mp3=01;36:*.mpc=01;36:*.ogg=01;36:*.ra=01;36:*.wav=01;36:*.oga=01;36:*.opus=01;36:*.spx=01;36:*.xspf=01;36:
> CCACHE_DIR=/var/tmp/ccache
> EXTRA_CONFIGURE_OPTS=
> V=
> SHOW_ENV=1
> MAIL=/var/spool/mail/root
> PATH=/usr/lib/ccache:/usr/lib64/ccache:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
> PWD=/
> TARGET_LIST=
> HISTCONTROL=ignoredups
> FGC=f25
> SHLVL=1
> HOME=/root
> TEST_DIR=/tmp/qemu-test
> DISTTAG=f25docker
> LOGNAME=root
> LESSOPEN=||/usr/bin/lesspipe.sh %s
> FEATURES=mingw clang pyyaml dtc
> DEBUG=
> _=/usr/bin/env
> 
> Configure options:
> --enable-werror --target-list=x86_64-softmmu,aarch64-softmmu --prefix=/var/tmp/qemu-build/install --cross-prefix=x86_64-w64-mingw32- --enable-trace-backends=simple --enable-debug --enable-gnutls --enable-nettle --enable-curl --enable-vnc --enable-bzip2 --enable-guest-agent --with-sdlabi=1.2 --with-gtkabi=2.0
> Install prefix    /var/tmp/qemu-build/install
> BIOS directory    /var/tmp/qemu-build/install
> binary directory  /var/tmp/qemu-build/install
> library directory /var/tmp/qemu-build/install/lib
> module directory  /var/tmp/qemu-build/install/lib
> libexec directory /var/tmp/qemu-build/install/libexec
> include directory /var/tmp/qemu-build/install/include
> config directory  /var/tmp/qemu-build/install
> local state directory   queried at runtime
> Windows SDK       no
> Source path       /tmp/qemu-test/src
> C compiler        x86_64-w64-mingw32-gcc
> Host C compiler   cc
> C++ compiler      x86_64-w64-mingw32-g++
> Objective-C compiler clang
> ARFLAGS           rv
> CFLAGS            -g 
> QEMU_CFLAGS       -I/usr/x86_64-w64-mingw32/sys-root/mingw/include/pixman-1  -I$(SRC_PATH)/dtc/libfdt -Werror -mms-bitfields -I/usr/x86_64-w64-mingw32/sys-root/mingw/include/glib-2.0 -I/usr/x86_64-w64-mingw32/sys-root/mingw/lib/glib-2.0/include -I/usr/x86_64-w64-mingw32/sys-root/mingw/include  -m64 -mcx16 -mthreads -D__USE_MINGW_ANSI_STDIO=1 -DWIN32_LEAN_AND_MEAN -DWINVER=0x501 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-prototypes -fno-strict-aliasing -fno-common -fwrapv  -Wendif-labels -Wno-shift-negative-value -Wno-missing-include-dirs -Wempty-body -Wnested-externs -Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers -Wold-style-declaration -Wold-style-definition -Wtype-limits -fstack-protector-strong -I/usr/x86_64-w64-mingw32/sys-root/mingw/include -I/usr/x86_64-w64-mingw32/sys-root/mingw/include/p11-kit-1 -I/usr/x86_64-w64-mingw32/sys-root/mingw/include  -I/usr/x86_64-w64-min
gw32/sys-root/mingw/include   -I/usr/x86_64-w64-mingw32/sys-root/mingw/include/libpng16 
> LDFLAGS           -Wl,--nxcompat -Wl,--no-seh -Wl,--dynamicbase -Wl,--warn-common -m64 -g 
> make              make
> install           install
> python            python -B
> smbd              /usr/sbin/smbd
> module support    no
> host CPU          x86_64
> host big endian   no
> target list       x86_64-softmmu aarch64-softmmu
> tcg debug enabled yes
> gprof enabled     no
> sparse enabled    no
> strip binaries    no
> profiler          no
> static build      no
> pixman            system
> SDL support       yes (1.2.15)
> GTK support       yes (2.24.31)
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
> RDMA support      no
> TCG interpreter   no
> fdt support       yes
> preadv support    no
> fdatasync         no
> madvise           no
> posix_madvise     no
> libcap-ng support no
> vhost-net support no
> vhost-scsi support no
> vhost-vsock support no
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
> GlusterFS support no
> gcov              gcov
> gcov enabled      no
> TPM support       yes
> libssh2 support   yes
> TPM passthrough   no
> QOM debugging     yes
> lzo support       no
> snappy support    no
> bzip2 support     yes
> NUMA host support no
> tcmalloc support  no
> jemalloc support  no
> avx2 optimization yes
> replication support yes
> mkdir -p dtc/libfdt
> mkdir -p dtc/tests
>   GEN     x86_64-softmmu/config-devices.mak.tmp
>   GEN     aarch64-softmmu/config-devices.mak.tmp
>   GEN     config-host.h
>   GEN     qmp-commands.h
>   GEN     qapi-visit.h
>   GEN     qapi-types.h
>   GEN     qemu-options.def
>   GEN     qapi-event.h
>   GEN     aarch64-softmmu/config-devices.mak
>   GEN     x86_64-softmmu/config-devices.mak
>   GEN     qmp-marshal.c
>   GEN     qapi-types.c
>   GEN     qapi-visit.c
>   GEN     qapi-event.c
>   GEN     qmp-introspect.h
>   GEN     qmp-introspect.c
>   GEN     trace/generated-tcg-tracers.h
>   GEN     trace/generated-helpers-wrappers.h
>   GEN     trace/generated-helpers.h
>   GEN     trace/generated-helpers.c
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
>   GEN     block/trace.h
>   GEN     backends/trace.h
>   GEN     hw/block/trace.h
>   GEN     hw/block/dataplane/trace.h
>   GEN     hw/char/trace.h
>   GEN     hw/intc/trace.h
>   GEN     hw/net/trace.h
>   GEN     hw/virtio/trace.h
>   GEN     hw/audio/trace.h
>   GEN     hw/misc/trace.h
>   GEN     hw/usb/trace.h
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
>   GEN     trace-root.c
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
>   GEN     hw/audio/trace.c
>   GEN     hw/misc/trace.c
>   GEN     hw/usb/trace.c
>   GEN     hw/scsi/trace.c
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
>   GEN     config-all-devices.mak
> 	 DEP /tmp/qemu-test/src/dtc/tests/dumptrees.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/testutils.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/trees.S
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
> 	 DEP /tmp/qemu-test/src/dtc/tests/references.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/path-references.c
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
> 	 DEP /tmp/qemu-test/src/dtc/libfdt/fdt_rw.c
> 	 DEP /tmp/qemu-test/src/dtc/libfdt/fdt_strerror.c
> 	 DEP /tmp/qemu-test/src/dtc/libfdt/fdt_sw.c
> 	 DEP /tmp/qemu-test/src/dtc/libfdt/fdt_wip.c
> 	 DEP /tmp/qemu-test/src/dtc/libfdt/fdt_ro.c
> 	 DEP /tmp/qemu-test/src/dtc/libfdt/fdt.c
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
> 	 CC libfdt/fdt_sw.o
> 	 CC libfdt/fdt_rw.o
> 	 CC libfdt/fdt_wip.o
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
>   RC      version.o
>   GEN     qga/qapi-generated/qga-qapi-types.h
>   GEN     qga/qapi-generated/qga-qapi-visit.h
>   GEN     qga/qapi-generated/qga-qmp-commands.h
>   GEN     qga/qapi-generated/qga-qapi-types.c
>   GEN     qga/qapi-generated/qga-qapi-visit.c
>   GEN     qga/qapi-generated/qga-qmp-marshal.c
>   CC      trace-root.o
>   CC      util/trace.o
>   CC      crypto/trace.o
>   CC      migration/trace.o
>   CC      io/trace.o
>   CC      backends/trace.o
>   CC      block/trace.o
>   CC      hw/block/trace.o
>   CC      hw/block/dataplane/trace.o
>   CC      hw/char/trace.o
>   CC      hw/intc/trace.o
>   CC      hw/net/trace.o
>   CC      hw/virtio/trace.o
>   CC      hw/audio/trace.o
>   CC      hw/misc/trace.o
>   CC      hw/usb/trace.o
>   CC      hw/scsi/trace.o
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
>   CC      target/mips/trace.o
>   CC      target/sparc/trace.o
>   CC      target/s390x/trace.o
>   CC      target/ppc/trace.o
>   CC      qom/trace.o
>   CC      linux-user/trace.o
>   CC      qapi/trace.o
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
>   CC      trace/simple.o
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
>   CC      util/aio-win32.o
>   CC      util/event_notifier-win32.o
>   CC      util/oslib-win32.o
>   CC      util/qemu-thread-win32.o
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
>   CC      util/keyval.o
>   CC      util/hexdump.o
>   CC      util/crc32c.o
>   CC      util/uuid.o
>   CC      util/throttle.o
>   CC      util/getauxval.o
>   CC      util/readline.o
>   CC      util/qemu-coroutine.o
>   CC      util/qemu-coroutine-lock.o
>   CC      util/rcu.o
>   CC      util/qemu-coroutine-io.o
>   CC      util/qemu-coroutine-sleep.o
>   CC      util/coroutine-win32.o
>   CC      util/buffer.o
>   CC      util/timed-average.o
>   CC      util/base64.o
>   CC      util/log.o
>   CC      util/qdist.o
>   CC      util/qht.o
>   CC      util/range.o
>   CC      util/systemd.o
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
>   CC      stubs/fd-register.o
>   CC      stubs/qmp_pc_dimm_device_list.o
>   CC      stubs/target-monitor-defs.o
>   CC      stubs/target-get-monitor-def.o
>   CC      stubs/pc_madt_cpu_entry.o
>   CC      stubs/vmgenid.o
>   GEN     qemu-img-cmds.h
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
>   CC      block/file-win32.o
>   CC      block/win32-aio.o
>   CC      block/null.o
>   CC      block/mirror.o
>   CC      block/commit.o
>   CC      block/io.o
>   CC      block/throttle-groups.o
>   CC      block/nbd.o
>   CC      block/nbd-client.o
>   CC      block/sheepdog.o
>   CC      block/accounting.o
>   CC      block/dirty-bitmap.o
>   CC      block/write-threshold.o
>   CC      block/backup.o
>   CC      block/replication.o
>   CC      block/crypto.o
>   CC      nbd/server.o
>   CC      nbd/client.o
>   CC      nbd/common.o
>   CC      block/curl.o
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
> In file included from [01m[K/tmp/qemu-test/src/crypto/hashpriv.h:18:0[m[K,
>                  from [01m[K/tmp/qemu-test/src/crypto/hash.c:24[m[K:
> [01m[K/tmp/qemu-test/src/crypto/afalgpriv.h:17:26:[m[K [01;31m[Kfatal error: [m[Klinux/if_alg.h: No such file or directory
>  #include <linux/if_alg.h>
>                           [01;31m[K^[m[K
> compilation terminated.
> /tmp/qemu-test/src/rules.mak:69: recipe for target 'crypto/hash.o' failed
> make: *** [crypto/hash.o] Error 1
> make: *** Waiting for unfinished jobs....
> In file included from [01m[K/tmp/qemu-test/src/crypto/hashpriv.h:18:0[m[K,
>                  from [01m[K/tmp/qemu-test/src/crypto/hash-nettle.c:24[m[K:
> [01m[K/tmp/qemu-test/src/crypto/afalgpriv.h:17:26:[m[K [01;31m[Kfatal error: [m[Klinux/if_alg.h: No such file or directory
>  #include <linux/if_alg.h>
>                           [01;31m[K^[m[K
> compilation terminated.
> /tmp/qemu-test/src/rules.mak:69: recipe for target 'crypto/hash-nettle.o' failed
> make: *** [crypto/hash-nettle.o] Error 1
> In file included from [01m[K/tmp/qemu-test/src/crypto/hmacpriv.h:18:0[m[K,
>                  from [01m[K/tmp/qemu-test/src/crypto/hmac-nettle.c:18[m[K:
> [01m[K/tmp/qemu-test/src/crypto/afalgpriv.h:17:26:[m[K [01;31m[Kfatal error: [m[Klinux/if_alg.h: No such file or directory
>  #include <linux/if_alg.h>
>                           [01;31m[K^[m[K
> compilation terminated.
> /tmp/qemu-test/src/rules.mak:69: recipe for target 'crypto/hmac-nettle.o' failed
> make: *** [crypto/hmac-nettle.o] Error 1
> In file included from [01m[K/tmp/qemu-test/src/crypto/hmacpriv.h:18:0[m[K,
>                  from [01m[K/tmp/qemu-test/src/crypto/hmac.c:15[m[K:
> [01m[K/tmp/qemu-test/src/crypto/afalgpriv.h:17:26:[m[K [01;31m[Kfatal error: [m[Klinux/if_alg.h: No such file or directory
>  #include <linux/if_alg.h>
>                           [01;31m[K^[m[K
> compilation terminated.
> /tmp/qemu-test/src/rules.mak:69: recipe for target 'crypto/hmac.o' failed
> make: *** [crypto/hmac.o] Error 1
> In file included from [01m[K/tmp/qemu-test/src/crypto/cipherpriv.h:19:0[m[K,
>                  from [01m[K/tmp/qemu-test/src/crypto/cipher.c:24[m[K:
> [01m[K/tmp/qemu-test/src/crypto/afalgpriv.h:17:26:[m[K [01;31m[Kfatal error: [m[Klinux/if_alg.h: No such file or directory
>  #include <linux/if_alg.h>
>                           [01;31m[K^[m[K
> compilation terminated.
> /tmp/qemu-test/src/rules.mak:69: recipe for target 'crypto/cipher.o' failed
> make: *** [crypto/cipher.o] Error 1
> tests/docker/Makefile.include:118: recipe for target 'docker-run' failed
> make[1]: *** [docker-run] Error 2
> make[1]: Leaving directory '/var/tmp/patchew-tester-tmp-e8571v4e/src'
> tests/docker/Makefile.include:149: recipe for target 'docker-run-test-mingw@fedora' failed
> make: *** [docker-run-test-mingw@fedora] Error 2
> === OUTPUT END ===
> 
> Test command exited with code: 2
> 
> 
> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@freelists.org


-- 
Regards,
Longpeng(Mike)
