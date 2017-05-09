Received: from eggs.gnu.org ([2001:4830:134:3::10]:46547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d7yCI-0002Is-18
	for qemu-devel@nongnu.org; Tue, 09 May 2017 02:00:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d7yC5-0001kZ-6S
	for qemu-devel@nongnu.org; Tue, 09 May 2017 02:00:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48292)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1d7yC4-0001kG-Jv
	for qemu-devel@nongnu.org; Tue, 09 May 2017 02:00:21 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 632CC8124F
	for <qemu-devel@nongnu.org>; Tue,  9 May 2017 06:00:18 +0000 (UTC)
Date: Tue, 9 May 2017 14:00:01 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170509060001.GG2820@pxdev.xzpeter.org>
References: <1494304108-9805-1-git-send-email-peterx@redhat.com>
	<149430534166.261.4137875287496048314@c05f1edc8ed1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <149430534166.261.4137875287496048314@c05f1edc8ed1>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/3] kvm: irqchip: skip msi update when msi
 disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, pbonzini@redhat.com, mst@redhat.com

On Mon, May 08, 2017 at 09:49:02PM -0700, no-reply@patchew.org wrote:
> Hi,
>=20
> This series failed automatic build test. Please find the testing comman=
ds and
> their output below. If you have docker installed, you can probably repr=
oduce it
> locally.
>=20
> Subject: [Qemu-devel] [PATCH 0/3] kvm: irqchip: skip msi update when ms=
i disabled
> Type: series
> Message-id: 1494304108-9805-1-git-send-email-peterx@redhat.com
>=20
> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> #!/bin/bash
> set -e
> git submodule update --init dtc
> # Let docker tests dump environment info
> export SHOW_ENV=3D1
> export J=3D8
> time make docker-test-quick@centos6
> time make docker-test-mingw@fedora
> time make docker-test-build@min-glib
> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>=20
> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> From https://github.com/patchew-project/qemu
>  * [new tag]         patchew/1494304108-9805-1-git-send-email-peterx@re=
dhat.com -> patchew/1494304108-9805-1-git-send-email-peterx@redhat.com
>  - [tag update]      patchew/20170508180705.20609-1-stefanha@redhat.com=
 -> patchew/20170508180705.20609-1-stefanha@redhat.com
> Switched to a new branch 'test'
> a0142b6 kvm: irqchip: skip update msi when disabled
> 76598e9 msix: trace control bit write op
> ba36235 kvm: irqchip: trace changes on msi add/remove
>=20
> =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
> Submodule 'dtc' (git://git.qemu-project.org/dtc.git) registered for pat=
h 'dtc'
> Cloning into '/var/tmp/patchew-tester-tmp-u9m5b1f4/src/dtc'...
> Submodule path 'dtc': checked out '558cd81bdd432769b59bff01240c44f82cfb=
1a9d'
>   BUILD   centos6
> make[1]: Entering directory '/var/tmp/patchew-tester-tmp-u9m5b1f4/src'
>   ARCHIVE qemu.tgz
>   ARCHIVE dtc.tgz
>   COPY    RUNNER
>     RUN test-quick in qemu:centos6=20
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
>=20
> Environment variables:
> PACKAGES=3Dlibfdt-devel ccache     tar git make gcc g++     zlib-devel =
glib2-devel SDL-devel pixman-devel     epel-release
> HOSTNAME=3D05429a3bc711
> TERM=3Dxterm
> MAKEFLAGS=3D -j8
> HISTSIZE=3D1000
> J=3D8
> USER=3Droot
> CCACHE_DIR=3D/var/tmp/ccache
> EXTRA_CONFIGURE_OPTS=3D
> V=3D
> SHOW_ENV=3D1
> MAIL=3D/var/spool/mail/root
> PATH=3D/usr/lib/ccache:/usr/lib64/ccache:/usr/local/sbin:/usr/local/bin=
:/usr/sbin:/usr/bin:/sbin:/bin
> PWD=3D/
> LANG=3Den_US.UTF-8
> TARGET_LIST=3D
> HISTCONTROL=3Dignoredups
> SHLVL=3D1
> HOME=3D/root
> TEST_DIR=3D/tmp/qemu-test
> LOGNAME=3Droot
> LESSOPEN=3D||/usr/bin/lesspipe.sh %s
> FEATURES=3D dtc
> DEBUG=3D
> G_BROKEN_FILENAMES=3D1
> CCACHE_HASHDIR=3D
> _=3D/usr/bin/env
>=20
> Configure options:
> --enable-werror --target-list=3Dx86_64-softmmu,aarch64-softmmu --prefix=
=3D/var/tmp/qemu-build/install
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
> C++ compiler     =20
> Objective-C compiler cc
> ARFLAGS           rv
> CFLAGS            -O2 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=3D2 -g=20
> QEMU_CFLAGS       -I/usr/include/pixman-1   -I$(SRC_PATH)/dtc/libfdt -p=
thread -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include   -fPIE -DPI=
E -m64 -mcx16 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE =
-Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings -Wmis=
sing-prototypes -fno-strict-aliasing -fno-common -fwrapv  -Wendif-labels =
-Wno-missing-include-dirs -Wempty-body -Wnested-externs -Wformat-security=
 -Wformat-y2k -Winit-self -Wignored-qualifiers -Wold-style-declaration -W=
old-style-definition -Wtype-limits -fstack-protector-all
> LDFLAGS           -Wl,--warn-common -Wl,-z,relro -Wl,-z,now -pie -m64 -=
g=20
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
> GTK support       no=20
> GTK GL support    no
> VTE support       no=20
> TLS priority      NORMAL
> GNUTLS support    no
> GNUTLS rnd        no
> libgcrypt         no
> libgcrypt kdf     no
> nettle            no=20
> nettle kdf        no
> libtasn1          no
> curses support    no
> virgl support     no
> curl support      no
> mingw32 support   no
> Audio drivers     oss
> Block whitelist (rw)=20
> Block whitelist (ro)=20
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
> spice support     no=20
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
> VxHS block device no
>   GEN     aarch64-softmmu/config-devices.mak.tmp
> mkdir -p dtc/libfdt
> mkdir -p dtc/tests
>   GEN     x86_64-softmmu/config-devices.mak.tmp
>   GEN     config-host.h
>   GEN     qemu-options.def
>   GEN     qmp-commands.h
>   GEN     qapi-visit.h
>   GEN     qapi-types.h
>   GEN     qapi-event.h
>   GEN     x86_64-softmmu/config-devices.mak
>   GEN     qmp-marshal.c
>   GEN     aarch64-softmmu/config-devices.mak
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
>   GEN     target/s390x/trace.c
>   GEN     target/sparc/trace.c
>   GEN     target/ppc/trace.c
>   GEN     qom/trace.c
>   GEN     linux-user/trace.c
>   GEN     qapi/trace.c
>   GEN     config-all-devices.mak
> 	 DEP /tmp/qemu-test/src/dtc/tests/dumptrees.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/trees.S
> 	 DEP /tmp/qemu-test/src/dtc/tests/testutils.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/value-labels.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/truncated_property.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/check_path.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/asm_tree_dump.c
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
> 	 DEP /tmp/qemu-test/src/dtc/tests/rw_tree1.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/set_name.c
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
> 	 DEP /tmp/qemu-test/src/dtc/tests/supernode_atdepth_offset.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/parent_offset.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/get_path.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/get_phandle.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/path_offset.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/get_name.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/getprop.c
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
> 	 DEP /tmp/qemu-test/src/dtc/fdtput.c
> 	 DEP /tmp/qemu-test/src/dtc/fdtget.c
> 	 DEP /tmp/qemu-test/src/dtc/fdtdump.c
> 	 LEX convert-dtsv0-lexer.lex.c
> make[1]: flex: Command not found
> 	 DEP /tmp/qemu-test/src/dtc/srcpos.c
> 	 BISON dtc-parser.tab.c
> make[1]: bison: Command not found
> 	 LEX dtc-lexer.lex.c
> make[1]: flex: Command not found
> 	 DEP /tmp/qemu-test/src/dtc/treesource.c
> 	 DEP /tmp/qemu-test/src/dtc/livetree.c
> 	 DEP /tmp/qemu-test/src/dtc/fstree.c
> 	 DEP /tmp/qemu-test/src/dtc/flattree.c
> 	 DEP /tmp/qemu-test/src/dtc/dtc.c
> 	 DEP /tmp/qemu-test/src/dtc/data.c
> 	 DEP /tmp/qemu-test/src/dtc/checks.c
> 	 LEX convert-dtsv0-lexer.lex.c
> 	CHK version_gen.h
> 	 BISON dtc-parser.tab.c
> 	 LEX dtc-lexer.lex.c
> make[1]: flex: Command not found
> make[1]: bison: Command not found
> make[1]: flex: Command not found
> 	UPD version_gen.h
> 	 DEP /tmp/qemu-test/src/dtc/util.c
> 	 LEX convert-dtsv0-lexer.lex.c
> make[1]: flex: Command not found
> 	 LEX dtc-lexer.lex.c
> 	 BISON dtc-parser.tab.c
> make[1]: flex: Command not found
> make[1]: bison: Command not found
> 	 CC libfdt/fdt.o
> 	 CC libfdt/fdt_ro.o
> 	 CC libfdt/fdt_wip.o
> 	 CC libfdt/fdt_sw.o
> 	 CC libfdt/fdt_rw.o
> 	 CC libfdt/fdt_empty_tree.o
> 	 CC libfdt/fdt_addresses.o
> 	 CC libfdt/fdt_strerror.o
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
> make[1]: flex: Command not found
> 	 BISON dtc-parser.tab.c
> 	 LEX dtc-lexer.lex.c
> make[1]: bison: Command not found
> make[1]: flex: Command not found
>   GEN     qga/qapi-generated/qga-qmp-commands.h
>   CC      tests/qemu-iotests/socket_scm_helper.o
>   GEN     qga/qapi-generated/qga-qapi-types.h
>   GEN     qga/qapi-generated/qga-qapi-visit.h
>   GEN     qga/qapi-generated/qga-qmp-marshal.c
>   GEN     qga/qapi-generated/qga-qapi-visit.c
>   CC      qmp-introspect.o
>   GEN     qga/qapi-generated/qga-qapi-types.c
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
>   CC      util/qemu-coroutine-lock.o
>   CC      util/qemu-coroutine.o
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
>   CC      stubs/qmp_pc_dimm_device_list.o
>   CC      stubs/target-monitor-defs.o
>   CC      stubs/target-get-monitor-def.o
>   CC      stubs/pc_madt_cpu_entry.o
>   CC      stubs/vmgenid.o
>   CC      stubs/xen-common.o
>   CC      stubs/xen-hvm.o
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
>   CC      block/null.o
>   CC      block/mirror.o
>   CC      block/commit.o
>   CC      block/io.o
>   CC      block/throttle-groups.o
>   CC      block/nbd.o
>   CC      block/nbd-client.o
>   CC      block/dirty-bitmap.o
>   CC      block/accounting.o
>   CC      block/sheepdog.o
>   CC      block/write-threshold.o
>   CC      block/backup.o
>   CC      block/replication.o
>   CC      nbd/server.o
>   CC      block/crypto.o
>   CC      nbd/common.o
>   CC      crypto/init.o
>   CC      nbd/client.o
>   CC      crypto/hash.o
>   CC      crypto/hash-glib.o
>   CC      crypto/hmac.o
>   CC      crypto/hmac-glib.o
>   CC      crypto/aes.o
>   CC      crypto/desrfb.o
>   CC      crypto/cipher.o
>   CC      crypto/tlscreds.o
>   CC      crypto/tlscredsanon.o
>   CC      crypto/tlscredsx509.o
>   CC      crypto/tlssession.o
>   CC      crypto/secret.o
>   CC      crypto/random-platform.o
>   CC      crypto/pbkdf.o
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
>   CC      io/task.o
>   CC      qom/container.o
>   CC      qom/object.o
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
>   CC      qmp.o
>   CC      qmp-marshal.o
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
>   CC      backends/tpm.o
>   CC      backends/hostmem.o
>   CC      backends/hostmem-ram.o
>   CC      backends/hostmem-file.o
>   CC      backends/cryptodev.o
>   CC      backends/cryptodev-builtin.o
>   CC      block/stream.o
>   CC      disas/i386.o
>   CC      fsdev/qemu-fsdev-opts.o
>   CC      fsdev/qemu-fsdev-dummy.o
>   CC      disas/arm.o
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
>   CC      hw/acpi/acpi-stub.o
>   CC      hw/acpi/ipmi.o
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
>   CC      hw/core/reset.o
>   CC      hw/core/bus.o
>   CC      hw/core/fw-path-provider.o
>   CC      hw/core/irq.o
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
>   CC      hw/dma/pl330.o
>   CC      hw/dma/pl080.o
>   CC      hw/dma/i8257.o
>   CC      hw/dma/xlnx-zynq-devcfg.o
>   CC      hw/gpio/max7310.o
>   CC      hw/gpio/pl061.o
>   CC      hw/gpio/zaurus.o
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
>   CC      hw/ide/microdrive.o
>   CC      hw/ide/ahci.o
>   CC      hw/ide/piix.o
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
>   CC      hw/intc/arm_gicv2m.o
>   CC      hw/intc/arm_gic.o
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
>   CC      hw/misc/applesmc.o
>   CC      hw/mem/nvdimm.o
>   CC      hw/misc/max111x.o
>   CC      hw/misc/debugexit.o
>   CC      hw/misc/sga.o
>   CC      hw/misc/pc-testdev.o
>   CC      hw/misc/pci-testdev.o
>   CC      hw/misc/arm_l2x0.o
>   CC      hw/misc/tmp105.o
>   CC      hw/misc/unimp.o
>   CC      hw/misc/arm_integrator_debug.o
>   CC      hw/misc/a9scu.o
>   CC      hw/misc/arm11scu.o
>   CC      hw/net/eepro100.o
>   CC      hw/net/pcnet-pci.o
>   CC      hw/net/e1000.o
>   CC      hw/net/ne2000.o
>   CC      hw/net/pcnet.o
>   CC      hw/net/e1000x_common.o
>   CC      hw/net/net_rx_pkt.o
>   CC      hw/net/net_tx_pkt.o
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
>   CC      hw/net/ftgmac100.o
>   CC      hw/net/rocker/rocker.o
>   CC      hw/net/rocker/rocker_fp.o
>   CC      hw/net/rocker/rocker_desc.o
>   CC      hw/nvram/eeprom93xx.o
>   CC      hw/net/rocker/rocker_world.o
>   CC      hw/nvram/fw_cfg.o
>   CC      hw/net/rocker/rocker_of_dpa.o
>   CC      hw/pci-bridge/pci_bridge_dev.o
>   CC      hw/nvram/chrp_nvram.o
>   CC      hw/pci-bridge/pcie_root_port.o
>   CC      hw/pci-bridge/pci_expander_bridge.o
>   CC      hw/pci-bridge/gen_pcie_root_port.o
>   CC      hw/pci-bridge/xio3130_upstream.o
>   CC      hw/pci-bridge/xio3130_downstream.o
>   CC      hw/pci-bridge/ioh3420.o
>   CC      hw/pci-bridge/i82801b11.o
>   CC      hw/pci-host/pam.o
>   CC      hw/pci-host/q35.o
>   CC      hw/pci-host/versatile.o
>   CC      hw/pci-host/piix.o
>   CC      hw/pci-host/gpex.o
>   CC      hw/pci/pci.o
>   CC      hw/pci/msix.o
>   CC      hw/pci/pci_bridge.o
>   CC      hw/pci/msi.o
>   CC      hw/pci/shpc.o
>   CC      hw/pci/slotid_cap.o
>   CC      hw/pci/pci_host.o
>   CC      hw/pci/pcie_host.o
>   CC      hw/pci/pcie.o
>   CC      hw/pci/pcie_aer.o
>   CC      hw/pci/pcie_port.o
>   CC      hw/pci/pci-stub.o
>   CC      hw/scsi/scsi-disk.o
>   CC      hw/pcmcia/pcmcia.o
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
>   CC      hw/timer/armv7m_systick.o
>   CC      hw/timer/arm_mptimer.o
>   CC      hw/timer/a9gtimer.o
>   CC      hw/timer/cadence_ttc.o
>   CC      hw/timer/ds1338.o
>   CC      hw/timer/hpet.o
>   CC      hw/timer/i8254_common.o
>   CC      hw/timer/i8254.o
>   CC      hw/timer/twl92230.o
>   CC      hw/timer/pl031.o
>   CC      hw/timer/imx_epit.o
>   CC      hw/timer/imx_gpt.o
>   CC      hw/timer/stm32f2xx_timer.o
>   CC      hw/timer/aspeed_timer.o
>   CC      hw/tpm/tpm_tis.o
>   CC      hw/tpm/tpm_util.o
>   CC      hw/tpm/tpm_passthrough.o
>   CC      hw/usb/core.o
>   CC      hw/usb/combined-packet.o
>   CC      hw/usb/libhw.o
>   CC      hw/usb/bus.o
>   CC      hw/usb/desc.o
>   CC      hw/usb/desc-msos.o
>   CC      hw/usb/hcd-uhci.o
>   CC      hw/usb/hcd-ehci.o
>   CC      hw/usb/hcd-ohci.o
>   CC      hw/usb/hcd-ehci-pci.o
>   CC      hw/usb/hcd-ehci-sysbus.o
>   CC      hw/usb/hcd-xhci.o
>   CC      hw/usb/dev-hub.o
>   CC      hw/usb/hcd-musb.o
>   CC      hw/usb/dev-hid.o
>   CC      hw/usb/dev-wacom.o
>   CC      hw/usb/dev-storage.o
>   CC      hw/usb/dev-uas.o
>   CC      hw/usb/dev-serial.o
>   CC      hw/usb/dev-audio.o
>   CC      hw/usb/dev-network.o
>   CC      hw/usb/dev-bluetooth.o
>   CC      hw/usb/dev-smartcard-reader.o
>   CC      hw/usb/dev-mtp.o
>   CC      hw/usb/host-stub.o
>   CC      hw/virtio/virtio-rng.o
>   CC      hw/virtio/virtio-pci.o
>   CC      hw/virtio/virtio-bus.o
>   CC      hw/virtio/virtio-mmio.o
>   CC      hw/watchdog/watchdog.o
>   CC      hw/virtio/vhost-stub.o
>   CC      hw/watchdog/wdt_i6300esb.o
>   CC      hw/watchdog/wdt_ib700.o
>   CC      hw/watchdog/wdt_aspeed.o
>   CC      migration/migration.o
>   CC      migration/socket.o
>   CC      migration/fd.o
>   CC      migration/exec.o
>   CC      migration/colo-comm.o
>   CC      migration/tls.o
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
> /tmp/qemu-test/src/replay/replay-internal.c: In function =E2=80=98repla=
y_put_array=E2=80=99:
> /tmp/qemu-test/src/replay/replay-internal.c:65: warning: ignoring retur=
n value of =E2=80=98fwrite=E2=80=99, declared with attribute warn_unused_=
result
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
>   CC      slirp/dnssearch.o
>   CC      slirp/ip_output.o
>   CC      slirp/dhcpv6.o
>   CC      slirp/slirp.o
>   CC      slirp/mbuf.o
>   CC      slirp/misc.o
>   CC      slirp/sbuf.o
>   CC      slirp/socket.o
>   CC      slirp/tcp_input.o
>   CC      slirp/tcp_output.o
>   CC      slirp/tcp_subr.o
>   CC      slirp/tcp_timer.o
>   CC      slirp/udp.o
>   CC      slirp/bootp.o
>   CC      slirp/udp6.o
> /tmp/qemu-test/src/slirp/tcp_input.c: In function =E2=80=98tcp_input=E2=
=80=99:
> /tmp/qemu-test/src/slirp/tcp_input.c:219: warning: =E2=80=98save_ip.ip_=
p=E2=80=99 may be used uninitialized in this function
> /tmp/qemu-test/src/slirp/tcp_input.c:219: warning: =E2=80=98save_ip.ip_=
len=E2=80=99 may be used uninitialized in this function
> /tmp/qemu-test/src/slirp/tcp_input.c:219: warning: =E2=80=98save_ip.ip_=
tos=E2=80=99 may be used uninitialized in this function
> /tmp/qemu-test/src/slirp/tcp_input.c:219: warning: =E2=80=98save_ip.ip_=
id=E2=80=99 may be used uninitialized in this function
> /tmp/qemu-test/src/slirp/tcp_input.c:219: warning: =E2=80=98save_ip.ip_=
off=E2=80=99 may be used uninitialized in this function
> /tmp/qemu-test/src/slirp/tcp_input.c:219: warning: =E2=80=98save_ip.ip_=
ttl=E2=80=99 may be used uninitialized in this function
> /tmp/qemu-test/src/slirp/tcp_input.c:219: warning: =E2=80=98save_ip.ip_=
sum=E2=80=99 may be used uninitialized in this function
> /tmp/qemu-test/src/slirp/tcp_input.c:219: warning: =E2=80=98save_ip.ip_=
src.s_addr=E2=80=99 may be used uninitialized in this function
> /tmp/qemu-test/src/slirp/tcp_input.c:219: warning: =E2=80=98save_ip.ip_=
dst.s_addr=E2=80=99 may be used uninitialized in this function
> /tmp/qemu-test/src/slirp/tcp_input.c:220: warning: =E2=80=98save_ip6.ip=
_nh=E2=80=99 may be used uninitialized in this function
>   CC      slirp/tftp.o
>   CC      slirp/arp_table.o
>   CC      slirp/ndp_table.o
>   CC      slirp/ncsi.o
>   CC      ui/keymaps.o
>   CC      ui/console.o
>   CC      ui/cursor.o
>   CC      ui/qemu-pixman.o
>   CC      ui/input.o
>   CC      ui/input-keymap.o
>   CC      ui/input-legacy.o
>   CC      ui/input-linux.o
>   CC      ui/sdl.o
>   CC      ui/x_keymap.o
>   CC      ui/sdl_zoom.o
>   CC      ui/vnc.o
>   CC      ui/vnc-enc-hextile.o
>   CC      ui/vnc-enc-zlib.o
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
>   AS      optionrom/multiboot.o
>   CC      qga/qapi-generated/qga-qapi-types.o
>   CC      qga/qapi-generated/qga-qapi-visit.o
>   AS      optionrom/linuxboot.o
>   CC      qga/qapi-generated/qga-qmp-marshal.o
>   AR      libqemuutil.a
>   CC      optionrom/linuxboot_dma.o
> cc: unrecognized option '-no-integrated-as'
> cc: unrecognized option '-no-integrated-as'
>   AR      libqemustub.a
>   AS      optionrom/kvmvapic.o
>   CC      qemu-img.o
>   BUILD   optionrom/multiboot.img
>   BUILD   optionrom/linuxboot.img
>   BUILD   optionrom/linuxboot_dma.img
>   BUILD   optionrom/kvmvapic.img
>   BUILD   optionrom/multiboot.raw
>   BUILD   optionrom/linuxboot.raw
>   BUILD   optionrom/linuxboot_dma.raw
>   BUILD   optionrom/kvmvapic.raw
>   SIGN    optionrom/linuxboot.bin
>   SIGN    optionrom/multiboot.bin
>   SIGN    optionrom/linuxboot_dma.bin
>   SIGN    optionrom/kvmvapic.bin
>   LINK    ivshmem-client
>   LINK    ivshmem-server
>   LINK    qemu-nbd
>   LINK    qemu-img
>   LINK    qemu-io
>   LINK    qemu-bridge-helper
>   LINK    qemu-ga
>   GEN     x86_64-softmmu/config-target.h
>   GEN     x86_64-softmmu/hmp-commands.h
>   GEN     x86_64-softmmu/hmp-commands-info.h
>   GEN     aarch64-softmmu/hmp-commands.h
>   GEN     aarch64-softmmu/hmp-commands-info.h
>   GEN     aarch64-softmmu/config-target.h
>   CC      x86_64-softmmu/exec.o
>   CC      x86_64-softmmu/translate-all.o
>   CC      x86_64-softmmu/cpu-exec-common.o
>   CC      x86_64-softmmu/cpu-exec.o
>   CC      x86_64-softmmu/translate-common.o
>   CC      x86_64-softmmu/tcg/tcg.o
>   CC      x86_64-softmmu/tcg/tcg-op.o
>   CC      aarch64-softmmu/exec.o
>   CC      x86_64-softmmu/tcg/optimize.o
>   CC      x86_64-softmmu/tcg/tcg-common.o
>   CC      x86_64-softmmu/fpu/softfloat.o
>   CC      aarch64-softmmu/translate-all.o
>   CC      aarch64-softmmu/cpu-exec.o
>   CC      x86_64-softmmu/disas.o
>   CC      x86_64-softmmu/tcg-runtime.o
>   CC      x86_64-softmmu/hax-stub.o
>   CC      x86_64-softmmu/arch_init.o
>   CC      aarch64-softmmu/translate-common.o
>   CC      aarch64-softmmu/cpu-exec-common.o
>   CC      x86_64-softmmu/cpus.o
>   CC      aarch64-softmmu/tcg/tcg.o
>   CC      aarch64-softmmu/tcg/tcg-op.o
>   CC      aarch64-softmmu/tcg/optimize.o
>   CC      aarch64-softmmu/tcg/tcg-common.o
>   CC      aarch64-softmmu/fpu/softfloat.o
>   CC      aarch64-softmmu/disas.o
>   CC      aarch64-softmmu/tcg-runtime.o
>   GEN     aarch64-softmmu/gdbstub-xml.c
>   CC      aarch64-softmmu/hax-stub.o
>   CC      aarch64-softmmu/kvm-stub.o
>   CC      aarch64-softmmu/arch_init.o
>   CC      aarch64-softmmu/cpus.o
>   CC      aarch64-softmmu/monitor.o
>   CC      aarch64-softmmu/gdbstub.o
>   CC      x86_64-softmmu/monitor.o
>   CC      aarch64-softmmu/balloon.o
>   CC      aarch64-softmmu/ioport.o
>   CC      aarch64-softmmu/numa.o
>   CC      aarch64-softmmu/qtest.o
>   CC      aarch64-softmmu/bootdevice.o
>   CC      x86_64-softmmu/gdbstub.o
>   CC      aarch64-softmmu/memory.o
>   CC      x86_64-softmmu/balloon.o
>   CC      aarch64-softmmu/cputlb.o
>   CC      aarch64-softmmu/memory_mapping.o
>   CC      x86_64-softmmu/ioport.o
>   CC      aarch64-softmmu/dump.o
>   CC      aarch64-softmmu/migration/ram.o
>   CC      aarch64-softmmu/migration/savevm.o
>   CC      aarch64-softmmu/hw/adc/stm32f2xx_adc.o
>   CC      aarch64-softmmu/hw/block/virtio-blk.o
>   CC      aarch64-softmmu/hw/block/dataplane/virtio-blk.o
>   CC      x86_64-softmmu/numa.o
>   CC      aarch64-softmmu/hw/char/exynos4210_uart.o
>   CC      aarch64-softmmu/hw/char/omap_uart.o
>   CC      x86_64-softmmu/qtest.o
>   CC      aarch64-softmmu/hw/char/digic-uart.o
>   CC      x86_64-softmmu/bootdevice.o
>   CC      x86_64-softmmu/kvm-all.o
>   CC      x86_64-softmmu/memory.o
>   CC      x86_64-softmmu/cputlb.o
>   CC      aarch64-softmmu/hw/char/bcm2835_aux.o
>   CC      aarch64-softmmu/hw/char/stm32f2xx_usart.o
>   CC      aarch64-softmmu/hw/char/virtio-serial-bus.o
>   CC      aarch64-softmmu/hw/core/nmi.o
>   CC      aarch64-softmmu/hw/core/generic-loader.o
>   CC      aarch64-softmmu/hw/core/null-machine.o
>   CC      aarch64-softmmu/hw/cpu/arm11mpcore.o
>   CC      aarch64-softmmu/hw/cpu/realview_mpcore.o
>   CC      aarch64-softmmu/hw/cpu/a9mpcore.o
>   CC      aarch64-softmmu/hw/cpu/a15mpcore.o
>   CC      aarch64-softmmu/hw/cpu/core.o
>   CC      aarch64-softmmu/hw/display/omap_dss.o
>   CC      x86_64-softmmu/memory_mapping.o
>   CC      x86_64-softmmu/dump.o
>   CC      x86_64-softmmu/migration/ram.o
>   CC      x86_64-softmmu/migration/savevm.o
>   CC      x86_64-softmmu/hw/block/virtio-blk.o
>   CC      x86_64-softmmu/hw/block/dataplane/virtio-blk.o
>   CC      aarch64-softmmu/hw/display/omap_lcdc.o
>   CC      aarch64-softmmu/hw/display/pxa2xx_lcd.o
>   CC      aarch64-softmmu/hw/display/bcm2835_fb.o
>   CC      aarch64-softmmu/hw/display/vga.o
>   CC      x86_64-softmmu/hw/char/virtio-serial-bus.o
>   CC      x86_64-softmmu/hw/core/nmi.o
>   CC      aarch64-softmmu/hw/display/virtio-gpu.o
>   CC      aarch64-softmmu/hw/display/virtio-gpu-3d.o
>   CC      aarch64-softmmu/hw/display/virtio-gpu-pci.o
>   CC      x86_64-softmmu/hw/core/generic-loader.o
>   CC      aarch64-softmmu/hw/display/dpcd.o
>   CC      x86_64-softmmu/hw/core/null-machine.o
>   CC      x86_64-softmmu/hw/cpu/core.o
>   CC      aarch64-softmmu/hw/display/xlnx_dp.o
>   CC      x86_64-softmmu/hw/display/vga.o
>   CC      x86_64-softmmu/hw/display/virtio-gpu.o
>   CC      aarch64-softmmu/hw/dma/xlnx_dpdma.o
>   CC      aarch64-softmmu/hw/dma/omap_dma.o
>   CC      aarch64-softmmu/hw/dma/soc_dma.o
>   CC      aarch64-softmmu/hw/dma/pxa2xx_dma.o
>   CC      aarch64-softmmu/hw/dma/bcm2835_dma.o
>   CC      aarch64-softmmu/hw/gpio/omap_gpio.o
>   CC      aarch64-softmmu/hw/gpio/imx_gpio.o
>   CC      aarch64-softmmu/hw/gpio/bcm2835_gpio.o
>   CC      x86_64-softmmu/hw/display/virtio-gpu-3d.o
>   CC      aarch64-softmmu/hw/i2c/omap_i2c.o
>   CC      x86_64-softmmu/hw/display/virtio-gpu-pci.o
>   CC      aarch64-softmmu/hw/input/pxa2xx_keypad.o
>   CC      x86_64-softmmu/hw/display/virtio-vga.o
>   CC      aarch64-softmmu/hw/input/tsc210x.o
>   CC      x86_64-softmmu/hw/intc/apic.o
>   CC      x86_64-softmmu/hw/intc/apic_common.o
>   CC      x86_64-softmmu/hw/intc/ioapic.o
>   CC      x86_64-softmmu/hw/isa/lpc_ich9.o
>   CC      x86_64-softmmu/hw/misc/vmport.o
>   CC      x86_64-softmmu/hw/misc/ivshmem.o
>   CC      x86_64-softmmu/hw/misc/pvpanic.o
>   CC      x86_64-softmmu/hw/misc/edu.o
>   CC      x86_64-softmmu/hw/misc/hyperv_testdev.o
>   CC      x86_64-softmmu/hw/net/virtio-net.o
>   CC      aarch64-softmmu/hw/intc/armv7m_nvic.o
>   CC      aarch64-softmmu/hw/intc/exynos4210_gic.o
>   CC      aarch64-softmmu/hw/intc/exynos4210_combiner.o
>   CC      aarch64-softmmu/hw/intc/omap_intc.o
>   CC      aarch64-softmmu/hw/intc/bcm2835_ic.o
>   CC      aarch64-softmmu/hw/intc/bcm2836_control.o
>   CC      x86_64-softmmu/hw/net/vhost_net.o
>   CC      aarch64-softmmu/hw/intc/allwinner-a10-pic.o
>   CC      x86_64-softmmu/hw/scsi/virtio-scsi.o
>   CC      aarch64-softmmu/hw/intc/aspeed_vic.o
>   CC      aarch64-softmmu/hw/intc/arm_gicv3_cpuif.o
>   CC      aarch64-softmmu/hw/misc/ivshmem.o
>   CC      aarch64-softmmu/hw/misc/arm_sysctl.o
>   CC      aarch64-softmmu/hw/misc/cbus.o
>   CC      aarch64-softmmu/hw/misc/exynos4210_pmu.o
>   CC      x86_64-softmmu/hw/scsi/virtio-scsi-dataplane.o
>   CC      aarch64-softmmu/hw/misc/imx_ccm.o
>   CC      aarch64-softmmu/hw/misc/exynos4210_clk.o
>   CC      aarch64-softmmu/hw/misc/imx31_ccm.o
>   CC      aarch64-softmmu/hw/misc/imx25_ccm.o
>   CC      aarch64-softmmu/hw/misc/imx6_ccm.o
>   CC      aarch64-softmmu/hw/misc/imx6_src.o
>   CC      x86_64-softmmu/hw/scsi/vhost-scsi.o
>   CC      aarch64-softmmu/hw/misc/mst_fpga.o
>   CC      aarch64-softmmu/hw/misc/omap_clk.o
>   CC      aarch64-softmmu/hw/misc/omap_sdrc.o
>   CC      aarch64-softmmu/hw/misc/omap_gpmc.o
>   CC      aarch64-softmmu/hw/misc/omap_l4.o
>   CC      x86_64-softmmu/hw/timer/mc146818rtc.o
>   CC      aarch64-softmmu/hw/misc/omap_tap.o
>   CC      aarch64-softmmu/hw/misc/bcm2835_mbox.o
>   CC      x86_64-softmmu/hw/vfio/pci.o
>   CC      aarch64-softmmu/hw/misc/bcm2835_property.o
>   CC      x86_64-softmmu/hw/vfio/common.o
>   CC      aarch64-softmmu/hw/misc/bcm2835_rng.o
>   CC      aarch64-softmmu/hw/misc/zynq_slcr.o
>   CC      aarch64-softmmu/hw/misc/stm32f2xx_syscfg.o
>   CC      aarch64-softmmu/hw/misc/zynq-xadc.o
>   CC      x86_64-softmmu/hw/vfio/pci-quirks.o
>   CC      aarch64-softmmu/hw/misc/edu.o
>   CC      x86_64-softmmu/hw/vfio/platform.o
>   CC      aarch64-softmmu/hw/misc/auxbus.o
>   CC      x86_64-softmmu/hw/vfio/spapr.o
>   CC      aarch64-softmmu/hw/misc/aspeed_scu.o
>   CC      aarch64-softmmu/hw/misc/aspeed_sdmc.o
>   CC      aarch64-softmmu/hw/net/virtio-net.o
>   CC      aarch64-softmmu/hw/net/vhost_net.o
>   CC      aarch64-softmmu/hw/pcmcia/pxa2xx.o
>   CC      aarch64-softmmu/hw/scsi/virtio-scsi.o
>   CC      x86_64-softmmu/hw/virtio/virtio.o
>   CC      x86_64-softmmu/hw/virtio/virtio-balloon.o
>   CC      aarch64-softmmu/hw/scsi/virtio-scsi-dataplane.o
>   CC      aarch64-softmmu/hw/scsi/vhost-scsi.o
>   CC      aarch64-softmmu/hw/sd/omap_mmc.o
>   CC      aarch64-softmmu/hw/sd/pxa2xx_mmci.o
>   CC      aarch64-softmmu/hw/sd/bcm2835_sdhost.o
>   CC      aarch64-softmmu/hw/ssi/omap_spi.o
>   CC      aarch64-softmmu/hw/ssi/imx_spi.o
>   CC      aarch64-softmmu/hw/timer/exynos4210_mct.o
>   CC      x86_64-softmmu/hw/virtio/vhost.o
>   CC      aarch64-softmmu/hw/timer/exynos4210_pwm.o
>   CC      aarch64-softmmu/hw/timer/exynos4210_rtc.o
>   CC      aarch64-softmmu/hw/timer/omap_gptimer.o
>   CC      aarch64-softmmu/hw/timer/omap_synctimer.o
>   CC      x86_64-softmmu/hw/virtio/vhost-backend.o
>   CC      aarch64-softmmu/hw/timer/pxa2xx_timer.o
>   CC      x86_64-softmmu/hw/virtio/vhost-user.o
>   CC      aarch64-softmmu/hw/timer/digic-timer.o
>   CC      aarch64-softmmu/hw/timer/allwinner-a10-pit.o
>   CC      x86_64-softmmu/hw/virtio/vhost-vsock.o
>   CC      aarch64-softmmu/hw/usb/tusb6010.o
>   CC      x86_64-softmmu/hw/virtio/virtio-crypto.o
>   CC      aarch64-softmmu/hw/vfio/common.o
>   CC      aarch64-softmmu/hw/vfio/pci.o
>   CC      x86_64-softmmu/hw/virtio/virtio-crypto-pci.o
>   CC      aarch64-softmmu/hw/vfio/pci-quirks.o
>   CC      aarch64-softmmu/hw/vfio/platform.o
>   CC      aarch64-softmmu/hw/vfio/calxeda-xgmac.o
>   CC      aarch64-softmmu/hw/vfio/amd-xgbe.o
>   CC      aarch64-softmmu/hw/vfio/spapr.o
>   CC      x86_64-softmmu/hw/i386/multiboot.o
>   CC      x86_64-softmmu/hw/i386/pc.o
>   CC      aarch64-softmmu/hw/virtio/virtio.o
>   CC      x86_64-softmmu/hw/i386/pc_piix.o
>   CC      aarch64-softmmu/hw/virtio/virtio-balloon.o
> /tmp/qemu-test/src/hw/i386/pc_piix.c: In function =E2=80=98igd_passthro=
ugh_isa_bridge_create=E2=80=99:
> /tmp/qemu-test/src/hw/i386/pc_piix.c:1055: warning: =E2=80=98pch_rev_id=
=E2=80=99 may be used uninitialized in this function
>   CC      x86_64-softmmu/hw/i386/pc_q35.o
>   CC      aarch64-softmmu/hw/virtio/vhost.o
>   CC      x86_64-softmmu/hw/i386/pc_sysfw.o
>   CC      aarch64-softmmu/hw/virtio/vhost-backend.o
>   CC      aarch64-softmmu/hw/virtio/vhost-user.o
>   CC      aarch64-softmmu/hw/virtio/vhost-vsock.o
>   CC      x86_64-softmmu/hw/i386/x86-iommu.o
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
>   CC      x86_64-softmmu/hw/i386/intel_iommu.o
>   CC      x86_64-softmmu/hw/i386/amd_iommu.o
>   CC      x86_64-softmmu/hw/i386/kvmvapic.o
>   CC      x86_64-softmmu/hw/i386/acpi-build.o
>   CC      x86_64-softmmu/hw/i386/pci-assign-load-rom.o
>   CC      x86_64-softmmu/hw/i386/kvm/clock.o
>   CC      x86_64-softmmu/hw/i386/kvm/apic.o
>   CC      x86_64-softmmu/hw/i386/kvm/i8259.o
>   CC      x86_64-softmmu/hw/i386/kvm/ioapic.o
>   CC      x86_64-softmmu/hw/i386/kvm/i8254.o
>   CC      x86_64-softmmu/hw/i386/kvm/pci-assign.o
>   CC      x86_64-softmmu/target/i386/translate.o
>   CC      x86_64-softmmu/target/i386/helper.o
>   CC      aarch64-softmmu/hw/arm/z2.o
>   CC      aarch64-softmmu/hw/arm/virt-acpi-build.o
>   CC      aarch64-softmmu/hw/arm/netduino2.o
>   CC      x86_64-softmmu/target/i386/cpu.o
>   CC      aarch64-softmmu/hw/arm/sysbus-fdt.o
>   CC      x86_64-softmmu/target/i386/bpt_helper.o
>   CC      aarch64-softmmu/hw/arm/armv7m.o
>   CC      aarch64-softmmu/hw/arm/exynos4210.o
>   CC      x86_64-softmmu/target/i386/excp_helper.o
>   CC      aarch64-softmmu/hw/arm/pxa2xx.o
>   CC      x86_64-softmmu/target/i386/fpu_helper.o
>   CC      aarch64-softmmu/hw/arm/pxa2xx_gpio.o
>   CC      aarch64-softmmu/hw/arm/pxa2xx_pic.o
>   CC      aarch64-softmmu/hw/arm/digic.o
>   CC      aarch64-softmmu/hw/arm/omap1.o
>   CC      aarch64-softmmu/hw/arm/omap2.o
>   CC      aarch64-softmmu/hw/arm/strongarm.o
>   CC      aarch64-softmmu/hw/arm/allwinner-a10.o
>   CC      aarch64-softmmu/hw/arm/cubieboard.o
>   CC      aarch64-softmmu/hw/arm/bcm2835_peripherals.o
>   CC      aarch64-softmmu/hw/arm/bcm2836.o
>   CC      x86_64-softmmu/target/i386/cc_helper.o
>   CC      x86_64-softmmu/target/i386/int_helper.o
>   CC      x86_64-softmmu/target/i386/svm_helper.o
>   CC      x86_64-softmmu/target/i386/smm_helper.o
>   CC      x86_64-softmmu/target/i386/misc_helper.o
> /tmp/qemu-test/src/hw/i386/acpi-build.c: In function =E2=80=98build_app=
end_pci_bus_devices=E2=80=99:
> /tmp/qemu-test/src/hw/i386/acpi-build.c:496: warning: =E2=80=98notify_m=
ethod=E2=80=99 may be used uninitialized in this function
>   CC      aarch64-softmmu/hw/arm/stm32f205_soc.o
>   CC      aarch64-softmmu/hw/arm/raspi.o
>   CC      x86_64-softmmu/target/i386/mem_helper.o
>   CC      aarch64-softmmu/hw/arm/xlnx-zynqmp.o
>   CC      aarch64-softmmu/hw/arm/xlnx-ep108.o
>   CC      aarch64-softmmu/hw/arm/fsl-imx25.o
>   CC      aarch64-softmmu/hw/arm/imx25_pdk.o
>   CC      aarch64-softmmu/hw/arm/fsl-imx31.o
>   CC      aarch64-softmmu/hw/arm/kzm.o
>   CC      aarch64-softmmu/hw/arm/fsl-imx6.o
>   CC      x86_64-softmmu/target/i386/seg_helper.o
>   CC      x86_64-softmmu/target/i386/mpx_helper.o
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
>   CC      x86_64-softmmu/target/i386/gdbstub.o
>   CC      x86_64-softmmu/target/i386/machine.o
>   CC      x86_64-softmmu/target/i386/arch_memory_mapping.o
>   CC      x86_64-softmmu/target/i386/arch_dump.o
>   CC      aarch64-softmmu/target/arm/helper.o
>   CC      aarch64-softmmu/target/arm/cpu.o
>   CC      aarch64-softmmu/target/arm/neon_helper.o
>   CC      aarch64-softmmu/target/arm/iwmmxt_helper.o
>   CC      aarch64-softmmu/target/arm/gdbstub.o
>   CC      aarch64-softmmu/target/arm/cpu64.o
>   CC      aarch64-softmmu/target/arm/translate-a64.o
>   CC      x86_64-softmmu/target/i386/monitor.o
>   CC      x86_64-softmmu/target/i386/kvm.o
>   CC      x86_64-softmmu/target/i386/hyperv.o
>   GEN     trace/generated-helpers.c
>   CC      aarch64-softmmu/target/arm/helper-a64.o
>   CC      aarch64-softmmu/target/arm/gdbstub64.o
>   CC      aarch64-softmmu/target/arm/crypto_helper.o
>   CC      aarch64-softmmu/target/arm/arm-powerctl.o
>   GEN     trace/generated-helpers.c
>   CC      aarch64-softmmu/trace/control-target.o
> /tmp/qemu-test/src/target/arm/translate-a64.c: In function =E2=80=98han=
dle_shri_with_rndacc=E2=80=99:
> /tmp/qemu-test/src/target/arm/translate-a64.c:6359: warning: =E2=80=98t=
cg_src_hi=E2=80=99 may be used uninitialized in this function
> /tmp/qemu-test/src/target/arm/translate-a64.c: In function =E2=80=98dis=
as_simd_scalar_two_reg_misc=E2=80=99:
> /tmp/qemu-test/src/target/arm/translate-a64.c:8086: warning: =E2=80=98r=
mode=E2=80=99 may be used uninitialized in this function
>   CC      x86_64-softmmu/trace/control-target.o
>   CC      aarch64-softmmu/gdbstub-xml.o
>   CC      aarch64-softmmu/trace/generated-helpers.o
>   CC      x86_64-softmmu/trace/generated-helpers.o
> /tmp/qemu-test/src/target/i386/kvm.c: In function =E2=80=98kvm_update_m=
si_routes_all=E2=80=99:
> /tmp/qemu-test/src/target/i386/kvm.c:3518: warning: implicit declaratio=
n of function =E2=80=98msix_enabled=E2=80=99
> /tmp/qemu-test/src/target/i386/kvm.c:3518: warning: nested extern decla=
ration of =E2=80=98msix_enabled=E2=80=99
>   LINK    x86_64-softmmu/qemu-system-x86_64
>   LINK    aarch64-softmmu/qemu-system-aarch64
> 	 LEX convert-dtsv0-lexer.lex.c
> make[1]: flex: Command not found
> 	 BISON dtc-parser.tab.c
> make[1]: bison: Command not found
> 	 LEX dtc-lexer.lex.c
> make[1]: flex: Command not found
>   TEST    tests/qapi-schema/alternate-any.out
>   TEST    tests/qapi-schema/alternate-array.out
>   TEST    tests/qapi-schema/alternate-base.out
>   TEST    tests/qapi-schema/alternate-clash.out
>   TEST    tests/qapi-schema/alternate-conflict-string.out
>   TEST    tests/qapi-schema/alternate-conflict-dict.out
>   TEST    tests/qapi-schema/alternate-empty.out
>   TEST    tests/qapi-schema/alternate-nested.out
>   TEST    tests/qapi-schema/alternate-unknown.out
>   TEST    tests/qapi-schema/args-alternate.out
>   TEST    tests/qapi-schema/args-any.out
>   TEST    tests/qapi-schema/args-array-unknown.out
>   TEST    tests/qapi-schema/args-array-empty.out
>   TEST    tests/qapi-schema/args-bad-boxed.out
>   TEST    tests/qapi-schema/args-boxed-anon.out
>   TEST    tests/qapi-schema/args-boxed-empty.out
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
>   TEST    tests/qapi-schema/bad-type-int.out
>   TEST    tests/qapi-schema/bad-type-dict.out
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
>   TEST    tests/qapi-schema/flat-union-empty.out
>   TEST    tests/qapi-schema/flat-union-clash-member.out
>   TEST    tests/qapi-schema/flat-union-incomplete-branch.out
>   TEST    tests/qapi-schema/flat-union-inline.out
>   TEST    tests/qapi-schema/flat-union-invalid-branch-key.out
>   TEST    tests/qapi-schema/flat-union-int-branch.out
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
>   TEST    tests/qapi-schema/pragma-doc-required-crap.out
>   TEST    tests/qapi-schema/pragma-extra-junk.out
>   TEST    tests/qapi-schema/pragma-name-case-whitelist-crap.out
>   TEST    tests/qapi-schema/pragma-non-dict.out
>   TEST    tests/qapi-schema/pragma-returns-whitelist-crap.out
>   TEST    tests/qapi-schema/qapi-schema-test.out
>   TEST    tests/qapi-schema/quoted-structural-chars.out
>   TEST    tests/qapi-schema/redefined-builtin.out
>   TEST    tests/qapi-schema/redefined-command.out
>   TEST    tests/qapi-schema/redefined-event.out
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
>   TEST    tests/qapi-schema/trailing-comma-list.out
>   TEST    tests/qapi-schema/struct-member-invalid.out
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
>   CC      tests/test-visitor-serialization.o
>   CC      tests/test-aio.o
>   CC      tests/test-iov.o
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
> /tmp/qemu-test/src/tests/test-int128.c:180: warning: =E2=80=98__noclone=
__=E2=80=99 attribute directive ignored
>   CC      tests/test-qht-par.o
>   CC      tests/qht-bench.o
>   CC      tests/test-bitops.o
>   CC      tests/check-qom-interface.o
>   CC      tests/test-bitcnt.o
>   CC      tests/check-qom-proplist.o
>   CC      tests/test-qemu-opts.o
>   CC      tests/test-keyval.o
>   CC      tests/test-write-threshold.o
>   CC      tests/test-crypto-hash.o
>   CC      tests/test-crypto-hmac.o
>   CC      tests/test-crypto-cipher.o
>   CC      tests/test-crypto-secret.o
>   CC      tests/test-qga.o
>   CC      tests/libqtest.o
>   CC      tests/test-timed-average.o
>   CC      tests/test-io-channel-socket.o
>   CC      tests/test-io-task.o
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
>   CC      tests/libqos/pci.o
>   CC      tests/vhost-user-test.o
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
>   CC      tests/libqos/virtio.o
>   CC      tests/libqos/virtio-pci.o
>   CC      tests/libqos/virtio-mmio.o
>   CC      tests/libqos/malloc-generic.o
>   CC      tests/endianness-test.o
>   CC      tests/fdc-test.o
>   CC      tests/ide-test.o
>   CC      tests/ahci-test.o
>   CC      tests/hd-geo-test.o
>   CC      tests/boot-order-test.o
>   CC      tests/bios-tables-test.o
>   CC      tests/boot-sector.o
>   CC      tests/acpi-utils.o
>   CC      tests/boot-serial-test.o
>   CC      tests/pxe-test.o
>   CC      tests/rtc-test.o
>   CC      tests/ipmi-kcs-test.o
> /tmp/qemu-test/src/tests/ide-test.c: In function =E2=80=98cdrom_pio_imp=
l=E2=80=99:
> /tmp/qemu-test/src/tests/ide-test.c:803: warning: ignoring return value=
 of =E2=80=98fwrite=E2=80=99, declared with attribute warn_unused_result
> /tmp/qemu-test/src/tests/ide-test.c: In function =E2=80=98test_cdrom_dm=
a=E2=80=99:
> /tmp/qemu-test/src/tests/ide-test.c:899: warning: ignoring return value=
 of =E2=80=98fwrite=E2=80=99, declared with attribute warn_unused_result
>   CC      tests/ipmi-bt-test.o
>   CC      tests/i440fx-test.o
>   CC      tests/fw_cfg-test.o
>   CC      tests/drive_del-test.o
>   CC      tests/wdt_ib700-test.o
>   CC      tests/tco-test.o
>   CC      tests/e1000-test.o
>   CC      tests/e1000e-test.o
>   CC      tests/rtl8139-test.o
>   CC      tests/pcnet-test.o
>   CC      tests/eepro100-test.o
>   CC      tests/ne2000-test.o
>   CC      tests/nvme-test.o
>   CC      tests/ac97-test.o
>   CC      tests/es1370-test.o
>   CC      tests/virtio-balloon-test.o
>   CC      tests/virtio-net-test.o
>   CC      tests/virtio-blk-test.o
>   CC      tests/virtio-rng-test.o
>   CC      tests/virtio-serial-test.o
>   CC      tests/virtio-scsi-test.o
>   CC      tests/virtio-console-test.o
>   CC      tests/tpci200-test.o
>   CC      tests/ipoctal232-test.o
>   CC      tests/display-vga-test.o
>   CC      tests/intel-hda-test.o
>   CC      tests/vmxnet3-test.o
>   CC      tests/ivshmem-test.o
>   CC      tests/i82801b11-test.o
>   CC      tests/pvpanic-test.o
>   CC      tests/usb-hcd-ohci-test.o
>   CC      tests/ioh3420-test.o
>   CC      tests/libqos/usb.o
>   CC      tests/usb-hcd-uhci-test.o
>   CC      tests/usb-hcd-xhci-test.o
>   CC      tests/usb-hcd-ehci-test.o
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
>   CC      tests/test-hmp.o
>   LINK    tests/check-qdict
>   LINK    tests/test-char
>   LINK    tests/check-qfloat
>   LINK    tests/check-qint
>   LINK    tests/check-qstring
>   LINK    tests/check-qlist
>   LINK    tests/check-qnull
>   LINK    tests/check-qjson
>   CC      tests/test-qapi-visit.o
>   CC      tests/test-qmp-introspect.o
>   CC      tests/test-qapi-event.o
>   CC      tests/test-qmp-marshal.o
>   CC      tests/test-qapi-types.o
>   LINK    tests/test-coroutine
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
>   LINK    tests/test-hmp
>   GTESTER tests/test-char
>   GTESTER tests/check-qfloat
>   GTESTER tests/check-qdict
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
>   GTESTER tests/test-iov
>   LINK    tests/test-visitor-serialization
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
>   GTESTER tests/test-clone-visitor
>   GTESTER tests/test-qobject-output-visitor
>   GTESTER tests/test-qobject-input-visitor
>   GTESTER tests/test-qmp-commands
>   GTESTER tests/test-string-input-visitor
>   GTESTER tests/test-string-output-visitor
>   GTESTER tests/test-qmp-event
>   GTESTER tests/test-opts-visitor
>   GTESTER tests/test-visitor-serialization
>   GTESTER tests/test-qht-par
> **
> ERROR:/tmp/qemu-test/src/tests/test-qga.c:867:test_qga_guest_exec: asse=
rtion failed: (exited)
> GTester: last random seed: R02S8d7e1707ff0f7bbd8f95db2b90e706b9
> make: *** [check-tests/test-qga] Error 1
> make: *** Waiting for unfinished jobs....
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
> tests/docker/Makefile.include:118: recipe for target 'docker-run' faile=
d
> make[1]: *** [docker-run] Error 2
> make[1]: Leaving directory '/var/tmp/patchew-tester-tmp-u9m5b1f4/src'
> tests/docker/Makefile.include:149: recipe for target 'docker-run-test-q=
uick@centos6' failed
> make: *** [docker-run-test-quick@centos6] Error 2
> =3D=3D=3D OUTPUT END =3D=3D=3D
>=20
> Test command exited with code: 2

This looks like a false positive. However looks like there is one line
missing during git commit in the last patch. Will resend. Sorry!

--=20
Peter Xu
