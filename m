Received: from eggs.gnu.org ([2001:4830:134:3::10]:39329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1daEfj-0005xH-66
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 01:15:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1daEfg-0002PL-0o
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 01:15:47 -0400
Received: from mail-io0-x243.google.com ([2607:f8b0:4001:c06::243]:33403)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1daEff-0002PH-RG
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 01:15:43 -0400
Received: by mail-io0-x243.google.com with SMTP id q64so5107287ioi.0
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 22:15:43 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <91ba54de-b2eb-f3a9-eb0f-a697b7698149@amsat.org>
Date: Wed, 26 Jul 2017 01:15:41 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <D06632B7-4405-47C8-BCF6-3C90274923E4@gmail.com>
References: <65ED9743-B53C-4E6A-866F-C883650914CE@gmail.com>
	<91ba54de-b2eb-f3a9-eb0f-a697b7698149@amsat.org>
Subject: Re: [Qemu-devel] hw/core/loader-fit.c:105:41: error: expected
 expression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>


> On Jul 26, 2017, at 12:13 AM, Philippe Mathieu-Daud=C3=A9 =
<f4bug@amsat.org> wrote:
>=20
> Hi John,
>=20
> On 07/25/2017 07:55 PM, Programmingkid wrote:
>> While compiling the mips64el-softmmu target I encountered these =
errors:
>>   CC      hw/display/g364fb.o
>> hw/core/loader-fit.c:105:41: error: expected expression
>>         *addr =3D fdt32_to_cpu(*(fdt32_t *)prop);
>>                                         ^
>> hw/core/loader-fit.c:105:32: error: use of undeclared identifier =
'fdt32_t'
>=20
> It seems you are missing the libfdt headers, so indeed you found bug.
>=20
> Replacing CONFIG_FITLOADER by CONFIG_FDT in hw/core/Makefile.objs and =
default-configs/mips64el-softmmu.mak should fix it, can you try?

That appears to help make things move past the loader-fit.c file. Here =
are the new errors:

  CC      hw/core/loader-fit.o
  CC      hw/dma/rc4030.o
  CC      hw/ide/via.o
hw/core/loader-fit.c:105:41: error: expected expression
        *addr =3D fdt32_to_cpu(*(fdt32_t *)prop);
                                        ^
hw/core/loader-fit.c:105:32: error: use of undeclared identifier =
'fdt32_t'
        *addr =3D fdt32_to_cpu(*(fdt32_t *)prop);
                               ^
hw/core/loader-fit.c:108:41: error: expected expression
        *addr =3D fdt64_to_cpu(*(fdt64_t *)prop);
                                        ^
hw/core/loader-fit.c:108:32: error: use of undeclared identifier =
'fdt64_t'
        *addr =3D fdt64_to_cpu(*(fdt64_t *)prop);
                               ^
hw/core/loader-fit.c:278:19: warning: implicit declaration of function
      'fdt_first_subnode' is invalid in C99 =
[-Wimplicit-function-declaration]
            off =3D fdt_first_subnode(itb, configs);
                  ^
hw/core/loader-fit.c:286:23: warning: implicit declaration of function
      'fdt_next_subnode' is invalid in C99 =
[-Wimplicit-function-declaration]
                off =3D fdt_next_subnode(itb, off);
                      ^
2 warnings and 4 errors generated.
make: *** [hw/core/loader-fit.o] Error 1
make: *** Waiting for unfinished jobs....


>=20
>>         *addr =3D fdt32_to_cpu(*(fdt32_t *)prop);
>>                                ^
>> hw/core/loader-fit.c:108:41: error: expected expression
>>         *addr =3D fdt64_to_cpu(*(fdt64_t *)prop);
>>                                         ^
>> hw/core/loader-fit.c:108:32: error: use of undeclared identifier =
'fdt64_t'
>>         *addr =3D fdt64_to_cpu(*(fdt64_t *)prop);
>>                                ^
>> hw/core/loader-fit.c:278:19: warning: implicit declaration of =
function
>>       'fdt_first_subnode' is invalid in C99 =
[-Wimplicit-function-declaration]
>>             off =3D fdt_first_subnode(itb, configs);
>>                   ^
>> hw/core/loader-fit.c:286:23: warning: implicit declaration of =
function
>>       'fdt_next_subnode' is invalid in C99 =
[-Wimplicit-function-declaration]
>>                 off =3D fdt_next_subnode(itb, off);
>>                       ^
>> 2 warnings and 4 errors generated.
>> make: *** [hw/core/loader-fit.o] Error 1
>> make: *** Waiting for unfinished jobs=E2=80=A6.
>=20
> It'd be useful if next time you also tell which compiler/version are =
you using.

gcc -v:

Configured with: --prefix=3D/Library/Developer/CommandLineTools/usr =
--with-gxx-include-dir=3D/usr/include/c++/4.2.1
Apple LLVM version 8.1.0 (clang-802.0.42)
Target: x86_64-apple-darwin16.6.0
Thread model: posix
InstalledDir: /Library/Developer/CommandLineTools/usr/bin

>=20
>> Steps to reproduce the error:
>> ./configure --target-list=3Dmips64el-softmmu && make
>=20
> And also the ./configure output, I'm interested by:
>=20
> "fdt support       no=E2=80=9D

Actually it was "fdt support       yes=E2=80=9D.

>=20
> Regards,
>=20
> Phil.

Thanks for the help. Here is some more info that might help:

Here is the full configure output:

./configure --target-list=3Dmips64el-softmmu
Install prefix    /usr/local
BIOS directory    /usr/local/share/qemu
binary directory  /usr/local/bin
library directory /usr/local/lib
module directory  /usr/local/lib/qemu
libexec directory /usr/local/libexec
include directory /usr/local/include
config directory  /usr/local/etc
local state directory   /usr/local/var
Manual directory  /usr/local/share/man
ELF interp prefix /usr/gnemul/qemu-%M
Source path       =
/Users/john/Documents/Development/Projects/Qemu/qemu-git
C compiler        cc
Host C compiler   cc
C++ compiler      c++
Objective-C compiler clang
ARFLAGS           rv
CFLAGS            -O2 -g=20
QEMU_CFLAGS       -I/usr/local/Cellar/pixman/0.34.0/include/pixman-1 =
-I$(SRC_PATH)/dtc/libfdt -D_REENTRANT =
-I/usr/local/Cellar/glib/2.46.2/include/glib-2.0 =
-I/usr/local/Cellar/glib/2.46.2/lib/glib-2.0/include =
-I/usr/local/opt/gettext/include -DNCURSES_WIDECHAR -D_DARWIN_C_SOURCE =
-I/opt/local/include -m64 -mcx16 -DOS_OBJECT_USE_OBJC=3D0 -arch x86_64 =
-D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE =
-Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings =
-Wmissing-prototypes -fno-strict-aliasing -fno-common -fwrapv  =
-Wno-string-plus-int -Wno-initializer-overrides -Wendif-labels =
-Wno-shift-negative-value -Wno-missing-include-dirs -Wempty-body =
-Wnested-externs -Wformat-security -Wformat-y2k -Winit-self =
-Wignored-qualifiers -Wold-style-definition -Wtype-limits =
-fstack-protector-strong -I/usr/local/Cellar/gnutls/3.4.11/include =
-I/usr/local/Cellar/nettle/3.2/include =
-I/usr/local/Cellar/libtasn1/4.8/include -I/opt/local/include =
-I/usr/local/Cellar/nettle/3.2/include   =
-I/usr/local/Cellar/libpng/1.6.29/include/libpng16 =
-I/usr/local/Cellar/libusb/1.0.20/include/libusb-1.0 =
-I/usr/local/Cellar/usbredir/0.7.1/include
LDFLAGS           -m64 -framework CoreFoundation -framework IOKit -arch =
x86_64 -g=20
make              make
install           install
python            python -B
smbd              /usr/sbin/smbd
module support    no
host CPU          x86_64
host big endian   no
target list       mips64el-softmmu
gprof enabled     no
sparse enabled    no
strip binaries    yes
profiler          no
static build      no
Cocoa support     yes
pixman            system
SDL support       no=20
GTK support       no=20
GTK GL support    no
VTE support       yes (0.39.92)
TLS priority      NORMAL
GNUTLS support    yes
GNUTLS rnd        yes
libgcrypt         no
libgcrypt kdf     no
nettle            yes (3.2)
nettle kdf        yes
libtasn1          yes
curses support    yes
virgl support     no
curl support      yes
mingw32 support   no
Audio drivers     coreaudio
Block whitelist (rw)=20
Block whitelist (ro)=20
VirtFS support    no
VNC support       yes
VNC SASL support  yes
VNC JPEG support  yes
VNC PNG support   yes
xen support       no
brlapi support    no
bluez  support    no
Documentation     yes
PIE               no
vde support       no
netmap support    no
Linux AIO support no
ATTR/XATTR support no
Install blobs     yes
KVM support       no
HAX support       yes
TCG support       yes
TCG debug enabled no
TCG interpreter   no
RDMA support      no
fdt support       yes
preadv support    no
fdatasync         no
madvise           yes
posix_madvise     yes
libcap-ng support no
vhost-net support no
vhost-scsi support no
vhost-vsock support no
Trace backends    log
spice support     no=20
rbd support       no
xfsctl support    no
smartcard support no
libusb            yes
usb net redir     yes
OpenGL support    no
OpenGL dmabufs    no
libiscsi support  no
libnfs support    no
build guest agent yes
QGA VSS support   no
QGA w32 disk info no
QGA MSI support   no
seccomp support   no
coroutine backend sigaltstack
coroutine pool    yes
debug stack usage no
crypto afalg      no
GlusterFS support no
gcov              gcov
gcov enabled      no
TPM support       yes
libssh2 support   no
TPM passthrough   no
QOM debugging     yes
Live block migration yes
lzo support       no
snappy support    no
bzip2 support     yes
NUMA host support no
tcmalloc support  no
jemalloc support  no
avx2 optimization no
replication support yes
VxHS block device no
