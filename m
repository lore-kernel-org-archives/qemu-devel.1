Received: from eggs.gnu.org ([2001:4830:134:3::10]:58316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1ds4Jw-0003QB-Hj
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 05:51:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1ds4Jr-0000XX-GB
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 05:51:00 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:36988)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1ds4Jq-0000Wk-PL
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 05:50:55 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <150525577025.321.3001704927093785609@6d89bd104fc3>
Date: Wed, 13 Sep 2017 12:50:43 +0300
In-Reply-To: <150525577025.321.3001704927093785609@6d89bd104fc3>
	(no-reply@patchew.org's message of "Tue, 12 Sep 2017 15:36:10 -0700
	(PDT)")
Message-ID: <87shfrsz9o.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 00/22] instrument: Add basic event
 instrumentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cota@braap.org, famz@redhat.com, stefanha@redhat.com, armbru@redhat.com

no-reply  writes:

> Hi,
> This series failed automatic build test. Please find the testing commands=
 and
> their output below. If you have docker installed, you can probably reprod=
uce it
> locally.

> Subject: [Qemu-devel] [PATCH v5 00/22] instrument: Add basic event instru=
mentation
> Message-id: 150525010239.15988.8172586618197849619.stgit@frigg.lan
> Type: series

> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> #!/bin/bash
> set -e
> git submodule update --init dtc
> # Let docker tests dump environment info
> export SHOW_ENV=3D1
> export J=3D8
> time make docker-test-quick@centos6
> time make docker-test-build@min-glib
> time make docker-test-mingw@fedora
> =3D=3D=3D TEST SCRIPT END =3D=3D=3D

> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> Switched to a new branch 'test'
> 1ab48ae9b7 instrument: Add API to manipulate guest memory
> 7e0bd2cad7 instrument: Add event 'guest_user_syscall_ret'
> 334caef899 instrument: Add event 'guest_user_syscall'
> 09a1773791 instrument: Add event 'guest_mem_before_exec'
> 2bd64563d3 instrument: Add event 'guest_mem_before_trans'
> 5b344ec1c3 trace: Introduce a proper structure to describe memory accesses
> 04e5b883b1 instrument: Add event 'guest_cpu_reset'
> 7971d0f2a4 instrument: Add event 'guest_cpu_exit'
> 53dbc9ad88 exec: Add function to synchronously flush TB on a stopped vCPU
> d8b51515d2 instrument: Support synchronous modification of vCPU state
> 08d492e35f instrument: Add event 'guest_cpu_enter'
> 0be52b1bbd instrument: Track vCPUs
> 7ab01f20f5 instrument: Add support for tracing events
> 78676cff2d instrument: Add basic control interface
> 00172972ae instrument: [hmp] Add library loader
> 34ccf831e6 instrument: [qapi] Add library loader
> d1ab648b00 instrument: [softmmu] Add command line library loader
> 150ad4a651 instrument: [bsd-user] Add command line library loader
> a064b1621a instrument: [linux-user] Add command line library loader
> aa78ee9f5a instrument: Add generic library loader
> f10357e313 instrument: Add configure-time flag
> 4d324ad619 instrument: Add documentation

> =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
> Submodule 'dtc' (git://git.qemu-project.org/dtc.git) registered for path =
'dtc'
> Cloning into '/var/tmp/patchew-tester-tmp-lf5qg9x6/src/dtc'...
> Submodule path 'dtc': checked out '558cd81bdd432769b59bff01240c44f82cfb1a=
9d'
>   BUILD   centos6
> make[1]: Entering directory '/var/tmp/patchew-tester-tmp-lf5qg9x6/src'
>   ARCHIVE qemu.tgz
>   ARCHIVE dtc.tgz
>   COPY    RUNNER
>     RUN test-quick in qemu:centos6=20
> Packages installed:
> SDL-devel-1.2.14-7.el6_7.1.x86_64
> bison-2.4.1-5.el6.x86_64
> bzip2-devel-1.0.5-7.el6_0.x86_64
> ccache-3.1.6-2.el6.x86_64
> csnappy-devel-0-6.20150729gitd7bc683.el6.x86_64
> flex-2.5.35-9.el6.x86_64
> gcc-4.4.7-18.el6.x86_64
> git-1.7.1-8.el6.x86_64
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
> xen-devel-4.6.3-15.el6.x86_64
> zlib-devel-1.2.3-29.el6.x86_64

> Environment variables:
> PACKAGES=3Dbison     bzip2-devel     ccache     csnappy-devel     flex   =
  g++     gcc     git     glib2-devel     libepoxy-devel     libfdt-devel  =
   librdmacm-devel     lzo-devel     make     mesa-libEGL-devel     mesa-li=
bgbm-devel     pixman-devel     SDL-devel     spice-glib-devel     spice-se=
rver-devel     tar     vte-devel     xen-devel     zlib-devel
> HOSTNAME=3Dfd698ce7a83b
> TERM=3Dxterm
> MAKEFLAGS=3D -j8
> HISTSIZE=3D1000
> J=3D8
> USER=3Droot
> LS_COLORS=3Drs=3D0:di=3D01;34:ln=3D01;36:mh=3D00:pi=3D40;33:so=3D01;35:do=
=3D01;35:bd=3D40;33;01:cd=3D40;33;01:or=3D40;31;01:mi=3D01;05;37;41:su=3D37=
;41:sg=3D30;43:ca=3D30;41:tw=3D30;42:ow=3D34;42:st=3D37;44:ex=3D01;32:*.tar=
=3D01;31:*.tgz=3D01;31:*.arj=3D01;31:*.taz=3D01;31:*.lzh=3D01;31:*.lzma=3D0=
1;31:*.tlz=3D01;31:*.txz=3D01;31:*.zip=3D01;31:*.z=3D01;31:*.Z=3D01;31:*.dz=
=3D01;31:*.gz=3D01;31:*.lz=3D01;31:*.xz=3D01;31:*.bz2=3D01;31:*.tbz=3D01;31=
:*.tbz2=3D01;31:*.bz=3D01;31:*.tz=3D01;31:*.deb=3D01;31:*.rpm=3D01;31:*.jar=
=3D01;31:*.rar=3D01;31:*.ace=3D01;31:*.zoo=3D01;31:*.cpio=3D01;31:*.7z=3D01=
;31:*.rz=3D01;31:*.jpg=3D01;35:*.jpeg=3D01;35:*.gif=3D01;35:*.bmp=3D01;35:*=
.pbm=3D01;35:*.pgm=3D01;35:*.ppm=3D01;35:*.tga=3D01;35:*.xbm=3D01;35:*.xpm=
=3D01;35:*.tif=3D01;35:*.tiff=3D01;35:*.png=3D01;35:*.svg=3D01;35:*.svgz=3D=
01;35:*.mng=3D01;35:*.pcx=3D01;35:*.mov=3D01;35:*.mpg=3D01;35:*.mpeg=3D01;3=
5:*.m2v=3D01;35:*.mkv=3D01;35:*.ogm=3D01;35:*.mp4=3D01;35:*.m4v=3D01;35:*.m=
p4v=3D01;35:*.vob=3D01;35:*.qt=3D01;35:*.nuv=3D01;35:*.wmv=3D01;35:*.asf=3D=
01;35:*.rm=3D01;35:*.rmvb=3D01;35:*.flc=3D01;35:*.avi=3D01;35:*.fli=3D01;35=
:*.flv=3D01;35:*.gl=3D01;35:*.dl=3D01;35:*.xcf=3D01;35:*.xwd=3D01;35:*.yuv=
=3D01;35:*.cgm=3D01;35:*.emf=3D01;35:*.axv=3D01;35:*.anx=3D01;35:*.ogv=3D01=
;35:*.ogx=3D01;35:*.aac=3D01;36:*.au=3D01;36:*.flac=3D01;36:*.mid=3D01;36:*=
.midi=3D01;36:*.mka=3D01;36:*.mp3=3D01;36:*.mpc=3D01;36:*.ogg=3D01;36:*.ra=
=3D01;36:*.wav=3D01;36:*.axa=3D01;36:*.oga=3D01;36:*.spx=3D01;36:*.xspf=3D0=
1;36:
> CCACHE_DIR=3D/var/tmp/ccache
> EXTRA_CONFIGURE_OPTS=3D
> V=3D
> SHOW_ENV=3D1
> MAIL=3D/var/spool/mail/root
> PATH=3D/usr/lib/ccache:/usr/lib64/ccache:/usr/local/sbin:/usr/local/bin:/=
usr/sbin:/usr/bin:/sbin:/bin
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
> C++ compiler=20=20=20=20=20=20
> Objective-C compiler cc
> ARFLAGS           rv
> CFLAGS            -O2 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=3D2 -g=20
> QEMU_CFLAGS       -I/usr/include/pixman-1   -I$(SRC_PATH)/dtc/libfdt -pth=
read -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include   -DNCURSES_WIDE=
CHAR   -fPIE -DPIE -m64 -mcx16 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LA=
RGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-=
strings -Wmissing-prototypes -fno-strict-aliasing -fno-common -fwrapv  -Wen=
dif-labels -Wno-missing-include-dirs -Wempty-body -Wnested-externs -Wformat=
-security -Wformat-y2k -Winit-self -Wignored-qualifiers -Wold-style-declara=
tion -Wold-style-definition -Wtype-limits -fstack-protector-all  -I/usr/inc=
lude/libpng12   -I/usr/include/libdrm     -I/usr/include/spice-server -I/us=
r/include/cacard -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include -I/u=
sr/include/pixman-1 -I/usr/include/nss3 -I/usr/include/nspr4 -I/usr/include=
/spice-1   -I/usr/include/cacard -I/usr/include/nss3 -I/usr/include/nspr4=
=20=20
> LDFLAGS           -Wl,--warn-common -Wl,-z,relro -Wl,-z,now -pie -m64 -g=
=20
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
> pixman            system
> SDL support       yes (1.2.14)
> GTK support       yes (2.24.23)
> GTK GL support    no
> VTE support       yes (0.25.1)
> TLS priority      NORMAL
> GNUTLS support    no
> GNUTLS rnd        no
> libgcrypt         no
> libgcrypt kdf     no
> nettle            no=20
> nettle kdf        no
> libtasn1          no
> curses support    yes
> virgl support     no
> curl support      no
> mingw32 support   no
> Audio drivers     oss
> Block whitelist (rw)=20
> Block whitelist (ro)=20
> VirtFS support    no
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
> instrumentation   no
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
> mkdir -p dtc/libfdt
> mkdir -p dtc/tests
>   GEN     aarch64-softmmu/config-devices.mak.tmp
>   GEN     x86_64-softmmu/config-devices.mak.tmp
>   GEN     config-host.h
>   GEN     qemu-options.def
>   GEN     qmp-commands.h
>   GEN     qapi-types.h
>   GEN     qapi-visit.h
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
>   GEN     chardev/trace.h
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
>   GEN     accel/tcg/trace.h
>   GEN     accel/kvm/trace.h
>   GEN     nbd/trace.h
>   GEN     trace-root.c
>   GEN     util/trace.c
>   GEN     crypto/trace.c
>   GEN     io/trace.c
>   GEN     migration/trace.c
>   GEN     block/trace.c
>   GEN     chardev/trace.c
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
>   GEN     accel/tcg/trace.c
>   GEN     accel/kvm/trace.c
>   GEN     nbd/trace.c
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
> 	 DEP /tmp/qemu-test/src/dtc/tests/get_alias.c
> 	 DEP /tmp/qemu-test/src/dtc/tests/char_literal.c
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
> 	 DEP /tmp/qemu-test/src/dtc/libfdt/fdt_ro.c
> 	 DEP /tmp/qemu-test/src/dtc/libfdt/fdt_wip.c
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
> 	 DEP /tmp/qemu-test/src/dtc/flattree.c
> 	 DEP /tmp/qemu-test/src/dtc/fstree.c
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
> 	 CC libfdt/fdt_sw.o
> 	 CC libfdt/fdt_rw.o
> 	 CC libfdt/fdt_empty_tree.o
> 	 CC libfdt/fdt_strerror.o
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
>   GEN     qga/qapi-generated/qga-qapi-types.h
>   GEN     qga/qapi-generated/qga-qapi-visit.h
>   GEN     qga/qapi-generated/qga-qapi-types.c
>   GEN     qga/qapi-generated/qga-qmp-marshal.c
>   GEN     qga/qapi-generated/qga-qapi-visit.c
>   GEN     qga/qapi-generated/qga-qmp-commands.h
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
>   CC      qobject/qnum.o
>   CC      qobject/qstring.o
>   CC      qobject/qdict.o
>   CC      qobject/qlist.o
>   CC      qobject/qbool.o
>   CC      qobject/qlit.o
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
>   CC      util/cacheinfo.o
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
>   CC      util/stats64.o
>   CC      util/systemd.o
>   CC      trace-root.o
>   CC      util/trace.o
>   CC      crypto/trace.o
>   CC      io/trace.o
>   CC      migration/trace.o
>   CC      block/trace.o
>   CC      chardev/trace.o
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
>   CC      accel/tcg/trace.o
>   CC      accel/kvm/trace.o
>   CC      nbd/trace.o
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
>   CC      stubs/instrument.o
>   CC      stubs/iothread.o
>   CC      stubs/iothread-lock.o
>   CC      stubs/is-daemonized.o
>   CC      stubs/machine-init-done.o
>   CC      stubs/migr-blocker.o
>   CC      stubs/change-state-handler.o
>   CC      stubs/monitor.o
>   CC      stubs/notify-event.o
>   CC      stubs/qtest.o
>   CC      stubs/replay.o
> /tmp/qemu-test/src/stubs/instrument.c:22: error: redefinition of typedef =
=E2=80=98strList=E2=80=99
> ./qapi-types.h:131: note: previous declaration of =E2=80=98strList=E2=80=
=99 was here
>   CC      stubs/runstate-check.o
> make: *** [stubs/instrument.o] Error 1
> make: *** Waiting for unfinished jobs....
> Traceback (most recent call last):
>   File "./tests/docker/docker.py", line 384, in <module>
>     sys.exit(main())
>   File "./tests/docker/docker.py", line 381, in main
>     return args.cmdobj.run(args, argv)
>   File "./tests/docker/docker.py", line 239, in run
>     return Docker().run(argv, args.keep, quiet=3Dargs.quiet)
>   File "./tests/docker/docker.py", line 207, in run
>     quiet=3Dquiet)
>   File "./tests/docker/docker.py", line 125, in _do_check
>     return subprocess.check_call(self._command + cmd, **kwargs)
>   File "/usr/lib64/python2.7/subprocess.py", line 186, in check_call
>     raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['docker', 'run', '--label', 'com=
.qemu.instance.uuid=3D9670c49e980a11e7950952540069c830', '-u', '0', '-t', '=
--rm', '--net=3Dnone', '-e', 'TARGET_LIST=3D', '-e', 'EXTRA_CONFIGURE_OPTS=
=3D', '-e', 'V=3D', '-e', 'J=3D8', '-e', 'DEBUG=3D', '-e', 'SHOW_ENV=3D1', =
'-e', 'CCACHE_DIR=3D/var/tmp/ccache', '-v', '/var/tmp/patchew-tester-tmp-lf=
5qg9x6/src/docker-src.2017-09-12-18.34.46.13887:/var/tmp/qemu:z,ro', '-v', =
'/root/.cache/qemu-docker-ccache:/var/tmp/ccache:z', 'qemu:centos6', '/var/=
tmp/qemu/run', 'test-quick']' returned non-zero exit status 2
> make[1]: *** [tests/docker/Makefile.include:139: docker-run] Error 1
> make[1]: Leaving directory '/var/tmp/patchew-tester-tmp-lf5qg9x6/src'
> make: *** [tests/docker/Makefile.include:168: docker-run-test-quick@cento=
s6] Error 2

I think I fixed it, and will send a new series (for some reason this does n=
ot
happen with my GCC version).


Cheers,
  Lluis
