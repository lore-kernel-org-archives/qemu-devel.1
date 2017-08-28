Received: from eggs.gnu.org ([2001:4830:134:3::10]:42696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dmG4G-0002Pz-BA
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 05:10:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dmG4C-0003dv-UR
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 05:10:48 -0400
Date: Mon, 28 Aug 2017 11:10:39 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170828111039.4b5a280a@nial.brq.redhat.com>
In-Reply-To: <AM5P194MB0132478A4ED8333EA2FFA940C89E0@AM5P194MB0132.EURP194.PROD.OUTLOOK.COM>
References: <mailman.4191.1503853034.21953.qemu-ppc@nongnu.org>
	<AC464994-B6AC-4DBC-942D-8C5EA8ECCE0E@gmail.com>
	<AM5P194MB0132478A4ED8333EA2FFA940C89E0@AM5P194MB0132.EURP194.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Qemu 2.10 rc4 build issue on BE (luigi burdo)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: luigi burdo <intermediadc@hotmail.com>
Cc: Programmingkid <programmingkidx@gmail.com>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>

On Mon, 28 Aug 2017 06:13:03 +0000
luigi burdo <intermediadc@hotmail.com> wrote:

> Hi,
>=20
> this is the log that was attached in my email.
>=20
> i will test only i386 softmmu when will return at home
>=20
> thanks
>=20
> Luigi
>=20
>=20
> ./configure --target-list=3Dppc64-softmmu,ppc-softmmu,x86_64-softmmu,arm-=
softmmu,i386-softmmu --with-sdlabi=3D2.0 --with-gtkabi=3D3.0 --audio-drv-li=
st=3Dpa,sdl,alsa --disable-werror
> Install prefix    /usr/local
> BIOS directory    /usr/local/share/qemu
> binary directory  /usr/local/bin
> library directory /usr/local/lib
> module directory  /usr/local/lib/qemu
> libexec directory /usr/local/libexec
> include directory /usr/local/include
> config directory  /usr/local/etc
> local state directory   /usr/local/var
> Manual directory  /usr/local/share/man
> ELF interp prefix /usr/gnemul/qemu-%M
> Source path       /home/amigaone/Downloads/qemu-2.10.0-rc4
> C compiler        cc
> Host C compiler   cc
> C++ compiler      c++
> Objective-C compiler clang
> ARFLAGS           rv
> CFLAGS            -O2 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=3D2 -g
> QEMU_CFLAGS       -I/usr/include/pixman-1  -pthread -I/usr/include/glib-2=
.0 -I/usr/lib64/glib-2.0/include -DNCURSES_WIDECHAR -D_GNU_SOURCE -m64 -D_G=
NU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -Wstrict-prototypes =
-Wredundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-prototypes -fno-s=
trict-aliasing -fno-common -fwrapv  -Wendif-labels -Wno-shift-negative-valu=
e -Wno-missing-include-dirs -Wempty-body -Wnested-externs -Wformat-security=
 -Wformat-y2k -Winit-self -Wignored-qualifiers -Wold-style-declaration -Wol=
d-style-definition -Wtype-limits -fstack-protector-strong -I/usr/include/p1=
1-kit-1   -I/usr/include/libpng16 -I/usr/include/libdrm  -I/usr/include/lib=
usb-1.0
> LDFLAGS           -Wl,--warn-common -m64 -g
> make              make
> install           install
> python            python -B
> smbd              /usr/sbin/smbd
> module support    no
> host CPU          ppc64
> host big endian   yes
> target list       ppc64-softmmu ppc-softmmu x86_64-softmmu arm-softmmu i3=
86-softmmu
> gprof enabled     no
> sparse enabled    no
> strip binaries    yes
> profiler          no
> static build      no
> pixman            system
> SDL support       yes (2.0.5)
> GTK support       yes (3.22.17)
> GTK GL support    yes
> VTE support       no
> TLS priority      NORMAL
> GNUTLS support    yes
> GNUTLS rnd        yes
> libgcrypt         no
> libgcrypt kdf     no
> nettle            yes (3.3)
> nettle kdf        yes
> libtasn1          yes
> curses support    yes
> virgl support     yes
> curl support      no
> mingw32 support   no
> Audio drivers     pa sdl alsa
> Block whitelist (rw)
> Block whitelist (ro)
> VirtFS support    yes
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
> Linux AIO support yes
> ATTR/XATTR support yes
> Install blobs     yes
> KVM support       yes
> HAX support       no
> TCG support       yes
> TCG debug enabled no
> TCG interpreter   no
> RDMA support      no
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
> spice support     no
> rbd support       no
> xfsctl support    no
> smartcard support no
> libusb            yes
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
> crypto afalg      no
> GlusterFS support no
> gcov              gcov
> gcov enabled      no
> TPM support       yes
> libssh2 support   no
> TPM passthrough   no
> QOM debugging     yes
> Live block migration yes
> lzo support       no
> snappy support    yes
> bzip2 support     yes
> NUMA host support yes
> tcmalloc support  no
> jemalloc support  no
> avx2 optimization no
> replication support yes
> VxHS block device no
>=20
>=20
[...]

below errors look like corrupted source files

>   CC      x86_64-softmmu/hw/i386/pc.o
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c: In function 'pc_di=
mm_unplug_request':
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1744:9: error: unkn=
own type name 'gCto'
>          gCto out;
>          ^~~~
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1744:14: warning: u=
nused variable 'out' [-Wunused-variable]
>          gCto out;
>               ^~~
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1747:49: error: str=
ay '@' in program
>      if (object_dynamic_cast(OBJECT(dev), TYPE_NV@IMM)) {
>                                                  ^
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1747:42: error: 'TY=
PE_NV' undeclared (first use in this function)
>      if (object_dynamic_cast(OBJECT(dev), TYPE_NV@IMM)) {
>                                           ^~~~~~~
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1747:42: note: each=
 undeclared identifier is reported only once for each function it appears in
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1747:50: error: exp=
ected ')' before 'IMM'
>      if (object_dynamic_cast(OBJECT(dev), TYPE_NV@IMM)) {
>                                                   ^~~
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1754:5: error: stra=
y '@' in program
>      @hc->unplug_request(HOTPLUG_HANDLER(pcms->acpi_dev), dev, &localCerr=
);
>      ^
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1754:6: error: 'hc'=
 undeclared (first use in this function)
>      @hc->unplug_request(HOTPLUG_HANDLER(pcms->acpi_dev), dev, &localCerr=
);
>       ^~
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1754:64: error: 'lo=
calCerr' undeclared (first use in this function)
>      @hc->unplug_request(HOTPLUG_HANDLER(pcms->acpi_dev), dev, &localCerr=
);
>                                                                 ^~~~~~~~~
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1737:26: warning: v=
ariable 'hhc' set but not used [-Wunused-but-set-variable]
>      HotplugHandlerClass *hhc;
>                           ^~~
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c: At top level:
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1760:11: error: str=
ay '@' in program
>  static voi@ pc_dimm_unplug(HotplugHandler *hotplug_dev,
>            ^
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1760:8: error: unkn=
own type name 'voi'
>  static voi@ pc_dimm_unplug(HotplugHandler *hotplug_dev,
>         ^~~
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1761:1: warning: nu=
ll character(s) ignored
>                             DeviceState *dev, Error **errp)
>  ^
> In file included from /home/amigaone/Downloads/qemu-2.10.0-rc4/include/hw=
/hw.h:10:0,
>                  from /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc=
.c:25:
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c: In function 'pc_di=
mm_unplug':
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1764:34: error: str=
ay '@' in program
>      PCDIMMDevice *dimm =3D PC_DIMM(@ev);
>                                   ^
> /home/amigaone/Downloads/qemu-2.10.0-rc4/include/qom/object.h:474:17: not=
e: in definition of macro 'OBJECT'
>      ((Object *)(obj))
>                  ^~~
> /home/amigaone/Downloads/qemu-2.10.0-rc4/include/hw/mem/pc-dimm.h:25:5: n=
ote: in expansion of macro 'OBJECT_CHECK'
>      OBJECT_CHECK(PCDIMMDevice, (obj), TYPE_PC_DIMM)
>      ^~~~~~~~~~~~
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1764:26: note: in e=
xpansion of macro 'PC_DIMM'
>      PCDIMMDevice *dimm =3D PC_DIMM(@ev);
>                           ^~~~~~~
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1764:35: error: 'ev=
' undeclared (first use in this function)
>      PCDIMMDevice *dimm =3D PC_DIMM(@ev);
>                                    ^
> /home/amigaone/Downloads/qemu-2.10.0-rc4/include/qom/object.h:474:17: not=
e: in definition of macro 'OBJECT'
>      ((Object *)(obj))
>                  ^~~
> /home/amigaone/Downloads/qemu-2.10.0-rc4/include/hw/mem/pc-dimm.h:25:5: n=
ote: in expansion of macro 'OBJECT_CHECK'
>      OBJECT_CHECK(PCDIMMDevice, (obj), TYPE_PC_DIMM)
>      ^~~~~~~~~~~~
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1764:26: note: in e=
xpansion of macro 'PC_DIMM'
>      PCDIMMDevice *dimm =3D PC_DIMM(@ev);
>                           ^~~~~~~
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1766:5: error: unkn=
own type name 'AemoryRegion'
>      AemoryRegion *mr;
>      ^~~~~~~~~~~~
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1770:40: error: 'lo=
cal_err' undeclared (first use in this function)
>      mr =3D ddc->get_memory_region(dimm, &local_err);=02    if (local_err=
) {
>                                         ^~~~~~~~~
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1770:51: error: str=
ay '\2' in program
>      mr =3D ddc->get_memory_region(dimm, &local_err);=02    if (local_err=
) {
>                                                    ^
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1774:11: warning: i=
mplicit declaration of function 'HOTPLUGKHANDLER_GET_CLASS' [-Wimplicit-fun=
ction-declaration]
>      hhc =3D HOTPLUGKHANDLER_GET_CLASS(pcms->acpi_dev);
>            ^~~~~~~~~~~~~~~~~~~~~~~~~
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1774:5: warning: ne=
sted extern declaration of 'HOTPLUGKHANDLER_GET_CLASS' [-Wnested-externs]
>      hhc =3D HOTPLUGKHANDLER_GET_CLASS(pcms->acpi_dev);
>      ^~~
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1774:37: error: 'pc=
ms' undeclared (first use in this function)
>      hhc =3D HOTPLUGKHANDLER_GET_CLASS(pcms->acpi_dev);
>                                      ^~~~
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1775:29: error: str=
ay '@' in program
>      hhc->unplug(HOTPLUG_HAND@ER(pcms->acpi_dev), dev, &local_err);
>                              ^
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1775:17: error: 'HO=
TPLUG_HAND' undeclared (first use in this function)
>      hhc->unplug(HOTPLUG_HAND@ER(pcms->acpi_dev), dev, &local_err);
>                  ^~~~~~~~~~~~
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1775:30: error: exp=
ected ')' before 'ER'
>      hhc->unplug(HOTPLUG_HAND@ER(pcms->acpi_dev), dev, &local_err);
>                               ^~
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1775:5: error: too =
few arguments to function 'hhc->unplug'
>      hhc->unplug(HOTPLUG_HAND@ER(pcms->acpi_dev), dev, &local_err);
>      ^~~
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1778:1: warning: nu=
ll character(s) ignored
>          goto out;
>  ^
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1781:43: error: str=
ay '@' in program
>      pc_dimm_memory_unplug(dev, &pcms->hotp@ug_memory, mr);
>                                            ^
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1781:44: error: exp=
ected ')' before 'ug_memory'
>      pc_dimm_memory_unplug(dev, &pcms->hotp@ug_memory, mr);
>                                             ^~~~~~~~~
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1781:5: error: too =
few arguments to function 'pc_dimm_memory_unplug'
>      pc_dimm_memory_unplug(dev, &pcms->hotp@ug_memory, mr);
>      ^~~~~~~~~~~~~~~~~~~~~
> In file included from /home/amigaone/Downloads/qemu-2.10.0-rc4/include/hw=
/i386/pc.h:17:0,
>                  from /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc=
.c:26:
> /home/amigaone/Downloads/qemu-2.10.0-rc4/include/hw/mem/pc-dimm.h:100:6: =
note: declared here
>  void pc_dimm_memory_unplug(DeviceState *dev, MemoryHotplugState *hpms,
>       ^~~~~~~~~~~~~~~~~~~~~
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1785:5: warning: im=
plicit declaration of function 'erBor_propagate' [-Wimplicit-function-decla=
ration]
>      erBor_propagate(errp, local_err);
>      ^~~~~~~~~~~~~~~
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1785:5: warning: ne=
sted extern declaration of 'erBor_propagate' [-Wnested-externs]
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1768:12: warning: u=
nused variable 'localCerr' [-Wunused-variable]
>      Error *localCerr =3D NULL;
>             ^~~~~~~~~
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1766:19: warning: v=
ariable 'mr' set but not used [-Wunused-but-set-variable]
>      AemoryRegion *mr;
>                    ^~
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1763:21: warning: u=
nused variable 'pCms' [-Wunused-variable]
>      PCMachineState *pCms =3D PC_MACHINE(hotplug_dev);
>                      ^~~~
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1786:1: warning: no=
 return statement in function returning non-void [-Wreturn-type]
>  }
>  ^
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c: At top level:
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1788:30: error: unk=
nown type name 'Boid'
>  static int pc_apic_cmp(const Boid *a, const void *b)
>                               ^~~~
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c: In function 'pc_ap=
ic_cmp':
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1790:39: error: str=
ay '\2' in program
>     CPUArchId *apic_a =3D (CPUArchId *)a;=02   CPUArchId *apic_b =3D (CPU=
ArchId *)b;
>                                        ^
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1792:17: error: 'CP=
UArchId {aka struct <anonymous>}' has no member named 'arch_Ad'; did you me=
an 'arch_id'?
>     return apic_a->arch_Ad - apic_b->arch_id;
>                  ^~
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c: At top level:
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1799:39: error: str=
ay '@' in program
>  static CPUArchId *pc_find_cpu_slot(Mac@ineState *ms, uint32_t id, int *i=
dx)
>                                        ^
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1799:36: error: unk=
nown type name 'Mac'
>  static CPUArchId *pc_find_cpu_slot(Mac@ineState *ms, uint32_t id, int *i=
dx)
>                                     ^~~
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1804:27: error: str=
ay '@' in program
>      found_cpu =3D bsearch(&a@ic_id, ms->possible_cpus->cpus,
>                            ^
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1807:7: warning: nu=
ll character(s) ignored
>      if  found_cpu && idx) {
>        ^
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1813:25: error: str=
ay '@' in program
>  static void pc_cpu_plug(@otplugHandler *hotplug_dev,
>                          ^
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1813:26: error: unk=
nown type name 'otplugHandler'
>  static void pc_cpu_plug(@otplugHandler *hotplug_dev,
>                           ^~~~~~~~~~~~~
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1814:36: warning: n=
ull character(s) ignored
>                          DeviceState *dev, Error **errp)
>                                     ^
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1817:16: error: str=
ay '@' in program
>      HotplugHand@erClass *hhc;
>                 ^
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1819:21: error: str=
ay '\2' in program
>      X86CPU *cpu =3D X8=02_CPU(dev);
>                      ^
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1821:1: error: stra=
y '\2' in program
>  =02    if (pcms->acpi_dev) {
>  ^
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1830:1: warning: nu=
ll character(s) ignored
>      pcms->boot_cpus++;
>  ^
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1838:5: warning: da=
ta definition has no type or storage class
>      found_cpu =3D pc_find_cpu_slot(MACHINE(pcms=01, cpu->apic_id, NULL);
>      ^~~~~~~~~
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1838:5: warning: ty=
pe defaults to 'int' in declaration of 'found_cpu' [-Wimplicit-int]
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1838:17: warning: i=
mplicit declaration of function 'pc_find_cpu_slot' [-Wimplicit-function-dec=
laration]
>      found_cpu =3D pc_find_cpu_slot(MACHINE(pcms=01, cpu->apic_id, NULL);
>                  ^~~~~~~~~~~~~~~~
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1838:67: error: mac=
ro "MACHINE" passed 3 arguments, but takes just 1
>      found_cpu =3D pc_find_cpu_slot(MACHINE(pcms=01, cpu->apic_id, NULL);
>                                                                    ^
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1838:34: error: 'MA=
CHINE' undeclared here (not in a function)
>      found_cpu =3D pc_find_cpu_slot(MACHINE(pcms=01, cpu->apic_id, NULL);
>                                   ^~~~~~~
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1838:68: error: exp=
ected ')' before ';' token
>      found_cpu =3D pc_find_cpu_slot(MACHINE(pcms=01, cpu->apic_id, NULL);
>                                                                     ^
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1841:1: warning: nu=
ll character(s) ignored
>      error_propagate(errp, local_err);
>  ^
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1842:1: error: expe=
cted ',' or ';' before '}' token
>  }
>  ^
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1844:1: warning: nu=
ll character(s) ignored
>                                       DeviceState *dev, Error **errp)
>  ^
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c: In function 'pc_cp=
u_unplugCrequest_cb':
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1846:17: error: str=
ay '\3' in program
>      int idx =3D -1=03
>                  ^
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1847:5: error: expe=
cted ',' or ';' before 'HotplugHandlerClass'
>      HotplugHandlerClass *hhc;
>      ^~~~~~~~~~~~~~~~~~~
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1849:1: warning: nu=
ll character(s) ignored
>      X86CPU *cpu =3D X86_CPU(dev);
>  ^
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1850:28: warning: i=
mplicit declaration of function 'PC_MACHIBE' [-Wimplicit-function-declarati=
on]
>      PCMachineState *pcms =3D PC_MACHIBE(hotplug_dev);
>                             ^~~~~~~~~~
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1850:5: warning: ne=
sted extern declaration of 'PC_MACHIBE' [-Wnested-externs]
>      PCMachineState *pcms =3D PC_MACHIBE(hotplug_dev);
>      ^~~~~~~~~~~~~~
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1850:28: warning: i=
nitialization makes pointer from integer without a cast [-Wint-conversion]
>      PCMachineState *pcms =3D PC_MACHIBE(hotplug_dev);
>                             ^~~~~~~~~~
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1852:40: error: 'X8=
6CPU {aka struct X86CPU}' has no member named 'apic_Ad'; did you mean 'apic=
_id'?
>      pc_find_cpu_slot(MACHINE(pcms), cpu->apic_Ad, &idx);
>                                         ^~
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1855:9: warning: im=
plicit declaration of function 'erBor_setg' [-Wimplicit-function-declaratio=
n]
>          erBor_setg(&local_err, "Boot CPU is unpluggable");
>          ^~~~~~~~~~
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1855:9: warning: ne=
sted extern declaration of 'erBor_setg' [-Wnested-externs]
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1856:16: error: str=
ay '@' in program
>          goto ou@;
>                 ^
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1859:5: error: 'hhc=
' undeclared (first use in this function)
>      hhc =3D HOTPLUG_HANDLER_GET_CLASS(pcms->acpi_dev);
>      ^~~
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1860:1: warning: nu=
ll character(s) ignored
>      hhc->unplug_request(HOTPLUG_HANDLER(pcms->acpi_dev), dev, &loCal_err=
);
>  ^
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1860:64: error: 'lo=
Cal_err' undeclared (first use in this function)
>      hhc->unplug_request(HOTPLUG_HANDLER(pcms->acpi_dev), dev, &loCal_err=
);
>                                                                 ^~~~~~~~~
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1867:1: warning: nu=
ll character(s) ignored
>      error_propagate(errp, local_err);
>  ^
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1856:9: error: labe=
l 'ou' used but not defined
>          goto ou@;
>          ^~~~
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c: At top level:
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1872:30: error: str=
ay '@' in program
>                               @eviceState *dev, Error **errp)
>                               ^
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1872:31: error: unk=
nown type name 'eviceState'
>                               @eviceState *dev, Error **errp)
>                                ^~~~~~~~~~
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1875:5: error: stra=
y '@' in program
>      @otplugHandlerClass *hhc;
>      ^
> In file included from /home/amigaone/Downloads/qemu-2.10.0-rc4/include/hw=
/hw.h:10:0,
>                  from /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc=
.c:25:
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1878:42: error: str=
ay '@' in program
>      PCMachineState *pcms =3D PC_MACHINE(hot@lug_dev);
>                                           ^
> /home/amigaone/Downloads/qemu-2.10.0-rc4/include/qom/object.h:474:17: not=
e: in definition of macro 'OBJECT'
>      ((Object *)(obj))
>                  ^~~
> /home/amigaone/Downloads/qemu-2.10.0-rc4/include/hw/i386/pc.h:148:5: note=
: in expansion of macro 'OBJECT_CHECK'
>      OBJECT_CHECK(PCMachineState, (obj), TYPE_PC_MACHINE)
>      ^~~~~~~~~~~~
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1878:28: note: in e=
xpansion of macro 'PC_MACHINE'
>      PCMachineState *pcms =3D PC_MACHINE(hot@lug_dev);
>                             ^~~~~~~~~~
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1880:53: error: str=
ay '\2' in program
>      hhc =3D HOTPLUG_HANDLER_GET_CLASS(pcms->acpi_dev);=02    hhc->unplug=
(HOTPLUG_HANDLER(pcms->acpi_dev), dev, &local_erB);
>                                                      ^
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1886:14: warning: n=
ull character(s) ignored
>      found_cpu =3D pc_find_cpu_slot(MACHINE(pcms), cpu->apic_id, NULL);
>               ^
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1887:9: error: stra=
y '@' in program
>      foun@_cpu->cpu =3D NULL;
>          ^
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c: In function 'pc_cp=
u_pre_plug':
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1944:14: warning: a=
ssignment makes pointer from integer without a cast [-Wint-conversion]
>      cpu_slot =3D pc_find_cpu_slot(MACHINE(pcms), cpu->apic_id, &idx);
>               ^
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c: In function 'pc_ma=
chine_device_plug_cb':
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:2010:9: warning: im=
plicit declaration of function 'pc_cpu_plug' [-Wimplicit-function-declarati=
on]
>          pc_cpu_plug(hotplug_dev, dev, errp);
>          ^~~~~~~~~~~
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:2010:9: warning: ne=
sted extern declaration of 'pc_cpu_plug' [-Wnested-externs]
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c: In function 'pc_ma=
chine_device_unplug_request_cb':
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:2020:9: warning: im=
plicit declaration of function 'pc_cpu_unplug_request_cb' [-Wimplicit-funct=
ion-declaration]
>          pc_cpu_unplug_request_cb(hotplug_dev, dev, errp);
>          ^~~~~~~~~~~~~~~~~~~~~~~~
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:2020:9: warning: ne=
sted extern declaration of 'pc_cpu_unplug_request_cb' [-Wnested-externs]
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c: In function 'pc_ma=
chine_device_unplug_cb':
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:2033:9: warning: im=
plicit declaration of function 'pc_cpu_unplug_cb' [-Wimplicit-function-decl=
aration]
>          pc_cpu_unplug_cb(hotplug_dev, dev, errp);
>          ^~~~~~~~~~~~~~~~
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:2033:9: warning: ne=
sted extern declaration of 'pc_cpu_unplug_cb' [-Wnested-externs]
> At top level:
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1843:13: warning: '=
pc_cpu_unplugCrequest_cb' defined but not used [-Wunused-function]
>  static void pc_cpu_unplugCrequest_cb(HotplugHandler *hotplug_dev,
>              ^~~~~~~~~~~~~~~~~~~~~~~~
> /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1788:12: warning: '=
pc_apic_cmp' defined but not used [-Wunused-function]
>  static int pc_apic_cmp(const Boid *a, const void *b)
>             ^~~~~~~~~~~
> /home/amigaone/Downloads/qemu-2.10.0-rc4/rules.mak:66: recipe for target =
'hw/i386/pc.o' failed
> make[1]: *** [hw/i386/pc.o] Error 1
> Makefile:326: recipe for target 'subdir-x86_64-softmmu' failed
> make: *** [subdir-x86_64-softmmu] Error 2
> make: *** Waiting for unfinished jobs....
[...]
