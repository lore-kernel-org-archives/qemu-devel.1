Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1252C43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 06:19:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D4672147A
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 06:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="jiZIBVSX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D4672147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43980 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdqPr-00020i-9L
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 02:19:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35257)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <winaes@yandex.ru>) id 1hdl9Y-0004WC-1O
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 20:42:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <winaes@yandex.ru>) id 1hdl5p-0005iI-D8
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 20:38:23 -0400
Received: from forward105p.mail.yandex.net
 ([2a02:6b8:0:1472:2741:0:8b7:108]:43549)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <winaes@yandex.ru>) id 1hdl5o-0005fl-Nb
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 20:38:21 -0400
Received: from mxback9j.mail.yandex.net (mxback9j.mail.yandex.net
 [IPv6:2a02:6b8:0:1619::112])
 by forward105p.mail.yandex.net (Yandex) with ESMTP id 785EF4D400DE
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2019 03:38:15 +0300 (MSK)
Received: from localhost (localhost [::1])
 by mxback9j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id JAxnP49A15-cEJ8pq2w; 
 Thu, 20 Jun 2019 03:38:14 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1560991094; bh=hfqClprz5GtHFcppOC1PDmw4SLpPW2IBerJ9I42JlTE=;
 h=Message-Id:Date:Subject:To:From;
 b=jiZIBVSXTRAHQpSGSyHzftj7z71TSrrV7BzSr6+8A/S2DRE8ZeqEaG9Ar3CbRwEl0
 MJiFU6DYj2kLAXcvEiFBvUnclAog8duCHiyfL4rxayqi86bGjIakN4doSnRsxE4jEP
 HJFftRzclNoQXYu0CDZCKfATSxH3Uzk4bx2x04V4=
Authentication-Results: mxback9j.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by myt5-02b80404fd9e.qloud-c.yandex.net with HTTP;
 Thu, 20 Jun 2019 03:38:14 +0300
From: =?utf-8?B?0JzQtdGC0LvQuNGG0LrQuNC5INCu0YDQuNC5?= <winaes@yandex.ru>
To: qemu-devel@nongnu.org
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Thu, 20 Jun 2019 03:38:14 +0300
Message-Id: <16163281560991094@myt5-02b80404fd9e.qloud-c.yandex.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 2a02:6b8:0:1472:2741:0:8b7:108
X-Mailman-Approved-At: Thu, 20 Jun 2019 02:17:44 -0400
Subject: [Qemu-devel] [PATCH] some remarks to build last version of qemu in
 MSYS2 (from user)
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello!

Today I tried to build qemu from git in the current version of MSYS2 for =
Windows 10 (X64).
As a result, got the file qemu-setup-4.0.50.exe
But on the way to this I met several problems that I want to share.

Sorry to be newbie and write in bad english. And so...

After resolving all packages dependencies, I execute the commands:

$ ./configure --enable-gtk --enable-sdl --enable-vnc-sasl --enable-capsto=
ne=3Dsystem --enable-docs
-------------------------------------------------------------------------=
---------------------------------
Install prefix    c:/Program Files/QEMU
BIOS directory    c:/Program Files/QEMU
firmware path     c:/Program Files/QEMU/share/qemu-firmware
binary directory  c:/Program Files/QEMU
library directory c:/Program Files/QEMU/lib
module directory  c:/Program Files/QEMU/lib
libexec directory c:/Program Files/QEMU/libexec
include directory c:/Program Files/QEMU/include
config directory  c:/Program Files/QEMU
local state directory   queried at runtime
Windows SDK       no
Source path       /home/my/qemu
GIT binary        git
GIT submodules    ui/keycodemapdb tests/fp/berkeley-testfloat-3 tests/fp/=
berkeley-softfloat-3 dtc slirp
C compiler        cc
Host C compiler   cc
C++ compiler      c++
Objective-C compiler cc
ARFLAGS           rv
CFLAGS            -O2 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=3D2 -g
QEMU_CFLAGS       -IC:/msys64/mingw64/include/pixman-1 -I$(SRC_PATH)/dtc/=
libfdt -Werror -DHAS_LIBSSH2_SFTP_FSYNC -IC:/msys64/mingw64/include -pthr=
ead -mms-bitfields -IC:/msys64/mingw64/include -IC:/msys64/mingw64/includ=
e/glib-2.0 -IC:/msys64/mingw64/lib/glib-2.0/include -IC:/msys64/mingw64/i=
nclude -m64 -mcx16 -mthreads -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LA=
RGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrit=
e-strings -Wmissing-prototypes -fno-strict-aliasing -fno-common -fwrapv -=
std=3Dgnu99  -Wexpansion-to-defined -Wendif-labels -Wno-shift-negative-va=
lue -Wno-missing-include-dirs -Wempty-body -Wnested-externs -Wformat-secu=
rity -Wformat-y2k -Winit-self -Wignored-qualifiers -Wold-style-declaratio=
n -Wold-style-definition -Wtype-limits -fstack-protector-strong -IC:/msys=
64/mingw64/include -IC:/msys64/mingw64/include/p11-kit-1 -IC:/msys64/ming=
w64/include   -IC:/msys64/mingw64/include/libpng16 -IC:/msys64/mingw64/in=
clude -IC:/msys64/mingw64/include/capstone
LDFLAGS           -Wl,--nxcompat -Wl,--no-seh -Wl,--dynamicbase -Wl,--war=
n-common -m64 -g
QEMU_LDFLAGS      -L$(BUILD_DIR)/dtc/libfdt
make              make
install           install
python            python3 -B (3.7.3)
slirp support     git
smbd              /usr/sbin/smbd
module support    no
host CPU          x86_64
host big endian   no
target list       aarch64-softmmu alpha-softmmu arm-softmmu cris-softmmu =
hppa-softmmu i386-softmmu lm32-softmmu m68k-softmmu microblazeel-softmmu =
microblaze-softmmu mips64el-softmmu mips64-softmmu mipsel-softmmu mips-so=
ftmmu moxie-softmmu nios2-softmmu or1k-softmmu ppc64-softmmu ppc-softmmu =
riscv32-softmmu riscv64-softmmu s390x-softmmu sh4eb-softmmu sh4-softmmu s=
parc64-softmmu sparc-softmmu tricore-softmmu unicore32-softmmu x86_64-sof=
tmmu xtensaeb-softmmu xtensa-softmmu
gprof enabled     no
sparse enabled    no
strip binaries    yes
profiler          no
static build      no
SDL support       yes (2.0.9)
SDL image support no
GTK support       yes (3.24.8)
GTK GL support    no
VTE support       no
TLS priority      NORMAL
GNUTLS support    yes
libgcrypt         no
nettle            yes (3.4.1)
libtasn1          yes
PAM               no
iconv support     yes
curses support    no
virgl support     no
curl support      yes
mingw32 support   yes
Audio drivers     dsound
Block whitelist (rw)
Block whitelist (ro)
VirtFS support    no
Multipath support no
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
HVF support       no
WHPX support      no
TCG support       yes
TCG debug enabled no
TCG interpreter   no
malloc trim support no
RDMA support      no
PVRDMA support    no
fdt support       git
membarrier        no
preadv support    no
fdatasync         no
madvise           no
posix_madvise     no
posix_memalign    no
libcap-ng support no
vhost-net support
vhost-crypto support no
vhost-scsi support no
vhost-vsock support no
vhost-user support no
Trace backends    log
spice support     no
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
QGA w32 disk info yes
QGA MSI support   no
seccomp support   no
coroutine backend win32
coroutine pool    yes
debug stack usage no
mutex debugging   no
crypto afalg      no
GlusterFS support no
gcov              gcov
gcov enabled      no
TPM support       no
libssh2 support   yes
QOM debugging     yes
Live block migration yes
lzo support       yes
snappy support    yes
bzip2 support     yes
lzfse support     no
NUMA host support no
libxml2           yes
tcmalloc support  no
jemalloc support  no
avx2 optimization yes
replication support yes
VxHS block device no
bochs support     yes
cloop support     yes
dmg support       yes
qcow v1 support   yes
vdi support       yes
vvfat support     yes
qed support       yes
parallels support yes
sheepdog support  yes
capstone          system
docker            no
libpmem support   no
libudev           no
default devices   yes

NOTE: cross-compilers enabled:  'cc'
-------------------------------------------------------------------------=
---------------------------------
$ make installer

Problem 1: if I do not use the --enable-capstone=3Dsystem option, the bui=
ld is aborted

$make -C /home/my/qemu/capstone CAPSTONE_SHARED=3Dno BUILDDIR=3D"/home/my=
/qemu/capstone" CC=3D"cc" AR=3D"ar" LD=3D"ld" RANLIB=3D"ranlib" CFLAGS=3D=
"-O2 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=3D2 -g -IC:/msys64/mingw64/inclu=
de/pixman-1 -I/home/my/qemu/dtc/libfdt -DHAS_LIBSSH2_SFTP_FSYNC -IC:/msys=
64/mingw64/include -pthread -mms-bitfields -IC:/msys64/mingw64/include -I=
C:/msys64/mingw64/include/glib-2.0 -IC:/msys64/mingw64/lib/glib-2.0/inclu=
de -IC:/msys64/mingw64/include -m64 -mcx16 -mthreads -D_GNU_SOURCE -D_FIL=
E_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -fno-strict-aliasing -fno-common -=
fwrapv -std=3Dgnu99 -fstack-protector-strong -IC:/msys64/mingw64/include =
-IC:/msys64/mingw64/include/p11-kit-1 -IC:/msys64/mingw64/include -IC:/ms=
ys64/mingw64/include/libpng16 -IC:/msys64/mingw64/include -I/home/my/qemu=
/capstone/include -I/home/my/qemu/tests -DCAPSTONE_USE_SYS_DYN_MEM -DCAPS=
TONE_HAS_ARM -DCAPSTONE_HAS_ARM64 -DCAPSTONE_HAS_POWERPC -DCAPSTONE_HAS_X=
86"  BUILD_DIR=3D/home/my/qemu /home/my/qemu/capstone/capstone.lib

make: Entering directory '/home/my/qemu/capstone'
make: *** No rule to make target '/home/my/qemu/capstone/capstone.lib'.  =
Stop.
make: Leaving directory '/home/my/qemu/capstone'

I found this solution:
$ cd capstone
$ make CROSS=3Dx86_64-w64-mingw32- capstone.lib
  ...
  AR      capstone.lib
C:/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/9.1.0/../../../../x86=
_64-w64-mingw32/bin/ar.exe: creating ./capstone.lib
$ cd ..

Problem 2: I wanted to use the --enable-vnc-sasl option, but the build st=
opped due to a conflict of iovec structure definitions in files /mingw64/=
x86_64-w64-mingw32/include/sasl.h and include/qemu/osdep.h
I made simple patches:

diff -Nurp cyrus-sasl-2.1.27-old/include/sasl.h cyrus-sasl-2.1.27/include=
/sasl.h
--- cyrus-sasl-old/include/sasl.h       2019-06-19 17:05:06.334050200 +03=
00
+++ cyrus-sasl/include/sasl.h   2019-06-19 17:08:22.115365400 +0300
@@ -189,8 +189,8 @@
 #ifndef STRUCT_IOVEC_DEFINED
 #define STRUCT_IOVEC_DEFINED 1
 struct iovec {
-    long iov_len;
-    char *iov_base;
+    void *iov_base;
+    size_t iov_len;
 };
 #endif
 #else

diff -Nurp qemu-old/include/qemu/osdep.h qemu/include/qemu/osdep.h
--- qemu-old/include/qemu/osdep.h       2019-06-19 18:10:22.808111000 +03=
00
+++ qemu/include/qemu/osdep.h   2019-06-19 18:12:54.223226500 +0300
@@ -483,10 +483,18 @@ bool qemu_write_pidfile(const char *pidf
 int qemu_get_thread_id(void);

 #ifndef CONFIG_IOVEC
+
+#ifdef _WIN32
+#ifndef STRUCT_IOVEC_DEFINED
+#define STRUCT_IOVEC_DEFINED 1
 struct iovec {
     void *iov_base;
     size_t iov_len;
 };
+#endif
+#else
+struct iovec;                               /* Defined in OS headers */
+#endif
 /*
  * Use the same value as Linux for now.
  */

Problem 3: when generating the html build stopped with

Warning, treated as error:
C:/msys64/home/my/qemu/docs/interop/bitmaps.rst:202:Could not lex literal=
_block as "json". Highlighting skipped.

Here I simply remove the -W option

$ sphinx-build -v -T -n -b html -D version=3D4.0.50 -D release=3D"4.0.50 =
(v4.0.0-1396-gf3d0bec9f8-dirty)" -d .doctrees/interop /home/my/qemu/docs/=
interop docs/built/interop
...
C:/msys64/home/my/qemu/docs/interop/bitmaps.rst:1437: WARNING: Could not =
lex literal_block as "json". Highlighting skipped.
generating indices... genindex
writing additional pages... search
copying static files... done
copying extra files... done
dumping search index in English (code: en) ... done
dumping object inventory... done
build succeeded, 27 warnings.

Problem 4: When installing files into a temporary directory, copying brea=
ked
I made a patch by deleting the "/".

--- Makefile-orig       2019-06-16 23:23:49.352281900 +0300
+++ Makefile    2019-06-16 23:31:44.344762800 +0300
@@ -873,19 +873,19 @@ ifneq ($(DESCS),)
        done
 endif
        for s in $(ICON_SIZES); do \
-               mkdir -p "$(DESTDIR)/$(qemu_icondir)/hicolor/$${s}/apps";=
 \
+               mkdir -p "$(DESTDIR)$(qemu_icondir)/hicolor/$${s}/apps"; =
\
                $(INSTALL_DATA) $(SRC_PATH)/ui/icons/qemu_$${s}.png \
-                       "$(DESTDIR)/$(qemu_icondir)/hicolor/$${s}/apps/qe=
mu.png"; \
+                       "$(DESTDIR)$(qemu_icondir)/hicolor/$${s}/apps/qem=
u.png"; \
        done; \
-       mkdir -p "$(DESTDIR)/$(qemu_icondir)/hicolor/32x32/apps"; \
+       mkdir -p "$(DESTDIR)$(qemu_icondir)/hicolor/32x32/apps"; \
        $(INSTALL_DATA) $(SRC_PATH)/ui/icons/qemu_32x32.bmp \
-               "$(DESTDIR)/$(qemu_icondir)/hicolor/32x32/apps/qemu.bmp";=
 \
-       mkdir -p "$(DESTDIR)/$(qemu_icondir)/hicolor/scalable/apps"; \
+               "$(DESTDIR)$(qemu_icondir)/hicolor/32x32/apps/qemu.bmp"; =
\
+       mkdir -p "$(DESTDIR)$(qemu_icondir)/hicolor/scalable/apps"; \
        $(INSTALL_DATA) $(SRC_PATH)/ui/icons/qemu.svg \
-               "$(DESTDIR)/$(qemu_icondir)/hicolor/scalable/apps/qemu.sv=
g"
-       mkdir -p "$(DESTDIR)/$(qemu_desktopdir)"
+               "$(DESTDIR)$(qemu_icondir)/hicolor/scalable/apps/qemu.svg=
"
+       mkdir -p "$(DESTDIR)$(qemu_desktopdir)"
        $(INSTALL_DATA) $(SRC_PATH)/ui/qemu.desktop \
-               "$(DESTDIR)/$(qemu_desktopdir)/qemu.desktop"
+               "$(DESTDIR)$(qemu_desktopdir)/qemu.desktop"
 ifdef CONFIG_GTK
        $(MAKE) -C po $@
 endif

Problem 5: No bmp files
...
File: "C:/msys64/tmp/qemu-nsis\*.bmp" -> no files found.
Usage: File [/nonfatal] [/a] ([/r] [/x filespec [...]] filespec [...] |
   /oname=3Doutfile one_file_only)
Error in script "C:/msys64/home/my/qemu/qemu.nsi" on line 122 -- aborting=
 creation process
make: *** [Makefile:1073: qemu-setup-4.0.50.exe] Error 1

Simple hack:

--- qemu.nsi-orig       2019-06-17 00:33:33.148978300 +0300
+++ qemu.nsi    2019-06-20 02:57:19.030516900 +0300
@@ -119,7 +119,7 @@ Section "${PRODUCT} (required)"
     File "${SRCDIR}\README"
     File "${SRCDIR}\VERSION"

-    File "${BINDIR}\*.bmp"
+;    File "${BINDIR}\*.bmp"
     File "${BINDIR}\*.bin"
     File "${BINDIR}\*.dtb"
     File "${BINDIR}\*.rom"
@@ -206,7 +206,7 @@ Section "Uninstall"
     Delete "$INSTDIR\COPYING.LIB"
     Delete "$INSTDIR\README"
     Delete "$INSTDIR\VERSION"
-    Delete "$INSTDIR\*.bmp"
+;    Delete "$INSTDIR\*.bmp"
     Delete "$INSTDIR\*.bin"
     Delete "$INSTDIR\*.dll"
     Delete "$INSTDIR\*.dtb"

Finally, the build is over, but it was not very easy


--=C2=A0
With best regards, Youry Metlitsky


