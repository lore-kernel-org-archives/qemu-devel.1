Received: from eggs.gnu.org ([2001:4830:134:3::10]:53781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dnqGa-0005t5-LL
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 14:02:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dnqGY-00005f-Iz
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 14:02:04 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:35952)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1dnqGY-000054-97
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 14:02:02 -0400
Received: by mail-wm0-x22e.google.com with SMTP id f127so5883523wmf.1
	for <qemu-devel@nongnu.org>; Fri, 01 Sep 2017 11:02:02 -0700 (PDT)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <150428626668.228.5015312063444784137@b5667b65043c>
References: <cover.1504228916.git.alistair.francis@xilinx.com>
	<150428626668.228.5015312063444784137@b5667b65043c>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Fri, 1 Sep 2017 11:01:29 -0700
Message-ID: <CAKmqyKNM_sjSAXOV2J1Do+Dk5UBgKf9uCeE5pX3Pv11R7PTDBg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 0/7] More warning reporting fixed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Fri, Sep 1, 2017 at 10:17 AM,  <no-reply@patchew.org> wrote:
> Hi,
>
> This series failed automatic build test. Please find the testing commands=
 and
> their output below. If you have docker installed, you can probably reprod=
uce it
> locally.
>
> Message-id: cover.1504228916.git.alistair.francis@xilinx.com
> Subject: [Qemu-devel] [PATCH v3 0/7]  More warning reporting fixed
> Type: series
>
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
>
> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> Switched to a new branch 'test'
> daa632f1a9 Convert remaining single line fprintf() to warn_report()
> 3564057f47 Makefile: Remove libqemustub.a
> db8f58a8fe General warn report fixups
> 17f734cd2b Convert multi-line fprintf() to warn_report()
> bc49a89a7b Convert single line fprintf(.../n) to warn_report()
> f30abc7491 Convert remaining error_report() to warn_report()
> fce2253253 hw/i386: Improve some of the warning messages
>
> =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
> Submodule 'dtc' (git://git.qemu-project.org/dtc.git) registered for path =
'dtc'
> Cloning into '/var/tmp/patchew-tester-tmp-w0rxgc15/src/dtc'...
> Submodule path 'dtc': checked out '558cd81bdd432769b59bff01240c44f82cfb1a=
9d'
>   BUILD   centos6
> make[1]: Entering directory '/var/tmp/patchew-tester-tmp-w0rxgc15/src'
>   ARCHIVE qemu.tgz
>   ARCHIVE dtc.tgz
>   COPY    RUNNER
>     RUN test-quick in qemu:centos6
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
>
> Environment variables:
> PACKAGES=3Dbison     bzip2-devel     ccache     csnappy-devel     flex   =
  g++     gcc     git     glib2-devel     libepoxy-devel     libfdt-devel  =
   librdmacm-devel     lzo-devel     make     mesa-libEGL-devel     mesa-li=
bgbm-devel     pixman-devel     SDL-devel     spice-glib-devel     spice-se=
rver-devel     tar     vte-devel     xen-devel     zlib-devel
> HOSTNAME=3D48641f5feb73
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
>
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
> C++ compiler
> Objective-C compiler cc
> ARFLAGS           rv
> CFLAGS            -O2 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=3D2 -g
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
/spice-1   -I/usr/include/cacard -I/usr/include/nss3 -I/usr/include/nspr4
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
>   GEN     x86_64-softmmu/config-devices.mak.tmp
> mkdir -p dtc/libfdt
> mkdir -p dtc/tests
>   GEN     aarch64-softmmu/config-devices.mak.tmp

...

>   CC      aarch64-softmmu/hw/arm/pxa2xx_gpio.o
>   CC      aarch64-softmmu/hw/arm/pxa2xx_pic.o
>   CC      aarch64-softmmu/hw/arm/digic.o
> /tmp/qemu-test/src/target/i386/hax-mem.c: In function 'hax_process_sectio=
n':
> /tmp/qemu-test/src/target/i386/hax-mem.c:181:13: error: implicit declarat=
ion of function 'warn_report' [-Werror=3Dimplicit-function-declaration]
>              warn_report("Ignoring ROMD region 0x%016"PRIx64"->0x%016"PRI=
x64"",
>              ^~~~~~~~~~~
> /tmp/qemu-test/src/target/i386/hax-mem.c:181:13: error: nested extern dec=
laration of 'warn_report' [-Werror=3Dnested-externs]
> cc1: all warnings being treated as errors
> /tmp/qemu-test/src/rules.mak:66: recipe for target 'target/i386/hax-mem.o=
' failed
> make[1]: *** [target/i386/hax-mem.o] Error 1
> Makefile:326: recipe for target 'subdir-x86_64-softmmu' failed
> make: *** [subdir-x86_64-softmmu] Error 2
> make: *** Waiting for unfinished jobs....
>   CC      aarch64-softmmu/hw/arm/omap1.o
>   CC      aarch64-softmmu/hw/arm/omap2.o
>   CC      aarch64-softmmu/hw/arm/strongarm.o
>   CC      aarch64-softmmu/hw/arm/allwinner-a10.o

I will fix this in the next version.

Thanks,
Alistair
