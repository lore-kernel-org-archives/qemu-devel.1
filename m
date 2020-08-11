Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF6BC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 14:24:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 058762076B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 14:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="DZI7Oax3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 058762076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5VCN-0001xx-A4
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 10:24:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37346)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1k5V9L-0008EN-8W
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 10:21:11 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:41794 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1k5V9I-00026N-B4
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 10:21:10 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id 579ED4C890;
 Tue, 11 Aug 2020 14:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 in-reply-to:content-transfer-encoding:content-disposition
 :content-type:content-type:mime-version:references:message-id
 :subject:subject:from:from:date:date:received:received:received;
 s=mta-01; t=1597155664; x=1598970065; bh=K9jXWN6rzSZNW5LJtRQkH2
 kQv7jOdLQbNG7Uw1Zi++g=; b=DZI7Oax3JtIK/Oufo4XaULho0CUGOps6D154pS
 y4BFIYqcmCWTwtWO47FhJBmAh4PUuuuly/0zAMqCVv1i6xIgbSx0nbDPDbqfQ18q
 Wfs5BnZigv5/jfMxqG1Ugbkh9iwPL7ycRXID3NtX+5pjcOyvypZ7ICu/zFU/TuCS
 8BiVQ=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6hiFnkNKd50T; Tue, 11 Aug 2020 17:21:04 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id A70894C84C;
 Tue, 11 Aug 2020 17:21:03 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Tue, 11
 Aug 2020 17:21:03 +0300
Date: Tue, 11 Aug 2020 17:21:02 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 000/147] Meson integration for 5.2
Message-ID: <20200811142102.GB86269@SPB-NB-133.local>
References: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
 <20200811120442.GA86269@SPB-NB-133.local>
 <3afa2a9a-8da7-0838-ad96-06703bb4d815@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <3afa2a9a-8da7-0838-ad96-06703bb4d815@redhat.com>
X-Originating-IP: [172.17.204.212]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Received-SPF: pass client-ip=89.207.88.252; envelope-from=r.bolshakov@yadro.com;
 helo=mta-01.yadro.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 10:21:06
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: peter.maydell@linaro.org, thuth@redhat.com, berrange@redhat.com,
 philmd@redhat.com, cohuck@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 alex.bennee@linaro.org, alxndr@bu.edu, stefanha@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 11, 2020 at 02:59:53PM +0200, Paolo Bonzini wrote:
> On 11/08/20 14:04, Roman Bolshakov wrote:
> > Compilation seems to partially succeed but linking of QEMU binary fails:
> >=20
> > [3691/5594] Linking target qemu-system-aarch64
> > FAILED: qemu-system-aarch64
> > ...snip...
> > ld: warning: directory not found for option '-L/Users/r.bolshakov/dev/q=
emu/build/dtc/libfdt'
> > ld: warning: directory not found for option '-L/Users/r.bolshakov/dev/q=
emu/build/dtc/libfdt'
> > ld: library not found for -lcapstone
> > clang: error: linker command failed with exit code 1 (use -v to see inv=
ocation)
>=20
> Does it help if you do "make
> dtc/all capstone/all" and then retry?
>

It helps, thanks, but then linking fails with:

  [13/83] Linking target qemu-system-microblazeel
  FAILED: qemu-system-microblazeel
  ld: library not found for -lslirp

If I invoke "make slirp/all" and then build with "ninja" again it
succeeds for all targets and I can start QEMU with Cocoa UI.

> Can you include your config-host.mak?
>=20

Sure, please find it below:
# Automatically generated by configure - do not modify

all:
prefix=3D/usr/local
bindir=3D/usr/local/bin
libdir=3D/usr/local/lib
libexecdir=3D/usr/local/libexec
includedir=3D/usr/local/include
mandir=3D/usr/local/share/man
sysconfdir=3D/usr/local/etc
qemu_confdir=3D/usr/local/etc/qemu
qemu_datadir=3D/usr/local/share/qemu
qemu_firmwarepath=3D${prefix}/share/qemu-firmware
qemu_docdir=3D/usr/local/share/doc/qemu
qemu_moddir=3D/usr/local/lib/qemu
qemu_localstatedir=3D/usr/local/var
qemu_helperdir=3D/usr/local/libexec
qemu_localedir=3D/usr/local/share/locale
qemu_icondir=3D/usr/local/share/icons
qemu_desktopdir=3D/usr/local/share/applications
libs_softmmu=3D-L/usr/local/Cellar/pixman/0.40.0/lib -lpixman-1 -F/System/L=
ibrary/Frameworks -framework Cocoa -framework IOKit  -llzo2 -lsnappy -lfdt
GIT=3Dgit
GIT_SUBMODULES=3Dui/keycodemapdb tests/fp/berkeley-testfloat-3 tests/fp/ber=
keley-softfloat-3 dtc capstone slirp
GIT_UPDATE=3Dyes
ARCH=3Dx86_64
CONFIG_MINIKCONF_MODE=3D--defconfig
STRIP=3Dstrip
CONFIG_POSIX=3Dy
CONFIG_DARWIN=3Dy
CONFIG_TOOLS=3Dy
CONFIG_GUEST_AGENT=3Dy
CONFIG_SLIRP=3Dy
CONFIG_SMBD_COMMAND=3D"/usr/sbin/smbd"
SLIRP_CFLAGS=3D-I/Users/r.bolshakov/dev/qemu/slirp/src -I/Users/r.bolshakov=
/dev/qemu/build/slirp/src
SLIRP_LIBS=3D-L/Users/r.bolshakov/dev/qemu/build/slirp -lslirp
qemu-version.h: slirp/all
CONFIG_VDE=3Dy
VDE_LIBS=3D-lvdeplug
CONFIG_AUDIO_DRIVERS=3Dcoreaudio sdl
CONFIG_AUDIO_COREAUDIO=3Dy
CONFIG_AUDIO_SDL=3Dm
ALSA_LIBS=3D
ALSA_CFLAGS=3D
PULSE_LIBS=3D
PULSE_CFLAGS=3D
COREAUDIO_LIBS=3D-framework CoreAudio
DSOUND_LIBS=3D
OSS_LIBS=3D
JACK_LIBS=3D
CONFIG_BDRV_RW_WHITELIST=3D
CONFIG_BDRV_RO_WHITELIST=3D
PKGVERSION=3D
SRC_PATH=3D/Users/r.bolshakov/dev/qemu
TARGET_DIRS=3Daarch64-softmmu alpha-softmmu arm-softmmu avr-softmmu cris-so=
ftmmu hppa-softmmu i386-softmmu lm32-softmmu m68k-softmmu microblaze-softmm=
u microblazeel-softmmu mips-softmmu mips64-softmmu mips64el-softmmu mipsel-=
softmmu moxie-softmmu nios2-softmmu or1k-softmmu ppc-softmmu ppc64-softmmu =
riscv32-softmmu riscv64-softmmu rx-softmmu s390x-softmmu sh4-softmmu sh4eb-=
softmmu sparc-softmmu sparc64-softmmu tricore-softmmu unicore32-softmmu x86=
_64-softmmu xtensa-softmmu xtensaeb-softmmu
CONFIG_COCOA=3Dy
CONFIG_ICONV=3Dy
ICONV_CFLAGS=3D-I/usr/local/include
ICONV_LIBS=3D-L/usr/local/lib -liconv
CONFIG_CURL=3Dm
CURL_CFLAGS=3D
CURL_LIBS=3D-lcurl
CONFIG_GIO=3Dy
GIO_CFLAGS=3D-I/usr/local/Cellar/libffi/3.3/include -I/usr/local/Cellar/gli=
b/2.64.4_2/include -I/usr/local/Cellar/glib/2.64.4_2/include/glib-2.0 -I/us=
r/local/Cellar/glib/2.64.4_2/lib/glib-2.0/include -I/usr/local/opt/gettext/=
include -I/usr/local/Cellar/pcre/8.44/include -I/usr/local/Cellar/libffi/3.=
3/include -I/usr/local/Cellar/glib/2.64.4_2/include/gio-unix-2.0 -I/usr/loc=
al/Cellar/glib/2.64.4_2/include -I/usr/local/Cellar/glib/2.64.4_2/include/g=
lib-2.0 -I/usr/local/Cellar/glib/2.64.4_2/lib/glib-2.0/include -I/usr/local=
/opt/gettext/include -I/usr/local/Cellar/pcre/8.44/include
GIO_LIBS=3D-L/usr/local/Cellar/glib/2.64.4_2/lib -L/usr/local/opt/gettext/l=
ib -lgio-2.0 -lgobject-2.0 -lglib-2.0 -lintl -L/usr/local/Cellar/glib/2.64.=
4_2/lib -L/usr/local/opt/gettext/lib -lgio-2.0 -lgobject-2.0 -lglib-2.0 -li=
ntl
GDBUS_CODEGEN=3D/usr/local/Cellar/glib/2.64.4_2/bin/gdbus-codegen
CONFIG_TLS_PRIORITY=3D"NORMAL"
CONFIG_GNUTLS=3Dy
GNUTLS_CFLAGS=3D-I/usr/local/Cellar/gnutls/3.6.14/include -I/usr/local/Cell=
ar/nettle/3.6/include -I/usr/local/Cellar/libtasn1/4.16.0/include -I/usr/lo=
cal/Cellar/libidn2/2.3.0/include -I/usr/local/Cellar/p11-kit/0.23.20_1/incl=
ude/p11-kit-1
GNUTLS_LIBS=3D-L/usr/local/Cellar/gnutls/3.6.14/lib -lgnutls
CONFIG_NETTLE=3Dy
CONFIG_NETTLE_VERSION_MAJOR=3D3
NETTLE_CFLAGS=3D-I/usr/local/Cellar/nettle/3.6/include
NETTLE_LIBS=3D-L/usr/local/Cellar/nettle/3.6/lib -lnettle
CONFIG_TASN1=3Dy
CONFIG_AUTH_PAM=3Dy
HAVE_IFADDRS_H=3Dy
HAVE_OPENPTY=3Dy
HAVE_SYS_SIGNAL_H=3Dy
CONFIG_VTE=3Dy
VTE_CFLAGS=3D-I/usr/local/Cellar/libffi/3.3/include -I/usr/local/Cellar/vte=
3/0.60.3_1/include/vte-2.91 -I/usr/local/Cellar/gtk+3/3.24.21/include/gtk-3=
=2E0 -I/usr/local/Cellar/glib/2.64.4_2/include/gio-unix-2.0 -I/usr/local/Ce=
llar/cairo/1.16.0_3/include/cairo -I/usr/local/Cellar/libepoxy/1.5.4_1/incl=
ude -I/usr/local/Cellar/pango/1.44.7/include/pango-1.0 -I/usr/local/Cellar/=
fribidi/1.0.10/include/fribidi -I/usr/local/Cellar/harfbuzz/2.7.0/include/h=
arfbuzz -I/usr/local/Cellar/graphite2/1.3.14/include -I/usr/local/Cellar/at=
k/2.36.0/include/atk-1.0 -I/usr/local/Cellar/cairo/1.16.0_3/include/cairo -=
I/usr/local/Cellar/pixman/0.40.0/include/pixman-1 -I/usr/local/Cellar/fontc=
onfig/2.13.1/include -I/usr/local/opt/freetype/include/freetype2 -I/usr/loc=
al/Cellar/libpng/1.6.37/include/libpng16 -I/usr/local/Cellar/gdk-pixbuf/2.4=
0.0_1/include/gdk-pixbuf-2.0 -I/usr/local/Cellar/glib/2.64.4_2/include -I/u=
sr/local/Cellar/glib/2.64.4_2/include/glib-2.0 -I/usr/local/Cellar/glib/2.6=
4.4_2/lib/glib-2.0/include -I/usr/local/opt/gettext/include -I/usr/local/Ce=
llar/pcre/8.44/include
VTE_LIBS=3D-L/usr/local/Cellar/vte3/0.60.3_1/lib -L/usr/local/Cellar/gtk+3/=
3.24.21/lib -L/usr/local/Cellar/pango/1.44.7/lib -L/usr/local/Cellar/harfbu=
zz/2.7.0/lib -L/usr/local/Cellar/atk/2.36.0/lib -L/usr/local/Cellar/cairo/1=
=2E16.0_3/lib -L/usr/local/Cellar/gdk-pixbuf/2.40.0_1/lib -L/usr/local/Cell=
ar/glib/2.64.4_2/lib -L/usr/local/opt/gettext/lib -lvte-2.91 -lgtk-3 -lgdk-=
3 -Wl,-framework,Cocoa -Wl,-framework,Carbon -Wl,-framework,CoreGraphics -l=
pangocairo-1.0 -lpango-1.0 -lharfbuzz -latk-1.0 -lcairo-gobject -lcairo -lg=
dk_pixbuf-2.0 -lgio-2.0 -lgobject-2.0 -lglib-2.0 -lintl
CONFIG_VHOST_NET=3Dy
CONFIG_VHOST_NET_USER=3Dy
CONFIG_VHOST_CRYPTO=3Dy
CONFIG_VHOST_USER=3Dy
CONFIG_VHOST_USER_FS=3Dy
INSTALL_BLOBS=3Dyes
CONFIG_IOVEC=3Dy
CONFIG_FDT=3Dy
FDT_CFLAGS=3D-I/Users/r.bolshakov/dev/qemu/dtc/libfdt
FDT_LIBS=3D-L/Users/r.bolshakov/dev/qemu/build/dtc/libfdt -lfdt
HAVE_OPTRESET=3Dy
CONFIG_TCG=3Dy
CONFIG_MADVISE=3Dy
CONFIG_POSIX_MADVISE=3Dy
CONFIG_POSIX_MEMALIGN=3Dy
CONFIG_ZLIB=3Dy
ZLIB_CFLAGS=3D
ZLIB_LIBS=3D-lz
CONFIG_USB_LIBUSB=3Dy
LIBUSB_CFLAGS=3D-I/usr/local/Cellar/libusb/1.0.23/include/libusb-1.0
LIBUSB_LIBS=3D-L/usr/local/Cellar/libusb/1.0.23/lib -lusb-1.0
CONFIG_USB_REDIR=3Dy
USB_REDIR_CFLAGS=3D-I/usr/local/Cellar/usbredir/0.8.0/include
USB_REDIR_LIBS=3D-L/usr/local/Cellar/usbredir/0.8.0/lib -lusbredirparser
CONFIG_LZO=3Dy
LZO_LIBS=3D-llzo2
CONFIG_SNAPPY=3Dy
SNAPPY_LIBS=3D-lsnappy
CONFIG_BZIP2=3Dy
BZIP2_LIBS=3D-lbz2
CONFIG_ZSTD=3Dy
ZSTD_CFLAGS=3D-I/usr/local/Cellar/zstd/1.4.5//include
ZSTD_LIBS=3D-L/usr/local/Cellar/zstd/1.4.5//lib -lzstd
CONFIG_BSD=3Dy
CONFIG_QOM_CAST_DEBUG=3Dy
CONFIG_COROUTINE_BACKEND=3Dsigaltstack
CONFIG_COROUTINE_POOL=3D1
CONFIG_CPUID_H=3Dy
CONFIG_INT128=3Dy
CONFIG_CMPXCHG128=3Dy
CONFIG_ATOMIC64=3Dy
CONFIG_LIBSSH=3Dm
LIBSSH_CFLAGS=3D-DHAVE_LIBSSH_0_8 -I/usr/local/Cellar/libssh/0.9.4/include
LIBSSH_LIBS=3D-L/usr/local/Cellar/libssh/0.9.4/lib -lssh
CONFIG_LIVE_BLOCK_MIGRATION=3Dy
CONFIG_TPM=3Dy
TRACE_BACKENDS=3Dlog
CONFIG_TRACE_LOG=3Dy
CONFIG_TRACE_FILE=3Dtrace
CONFIG_LIBXML2=3Dy
LIBXML2_CFLAGS=3D
LIBXML2_LIBS=3D-lxml2
CONFIG_REPLICATION=3Dy
CONFIG_STATIC_ASSERT=3Dy
HAVE_UTMPX=3Dy
CONFIG_CAPSTONE=3Dy
CAPSTONE_CFLAGS=3D-I/Users/r.bolshakov/dev/qemu/capstone/include
CAPSTONE_LIBS=3D-L/Users/r.bolshakov/dev/qemu/build/capstone -lcapstone
CONFIG_THREAD_SETNAME_BYTHREAD=3Dy
CONFIG_PTHREAD_SETNAME_NP_WO_TID=3Dy
CONFIG_BOCHS=3Dy
CONFIG_CLOOP=3Dy
CONFIG_DMG=3Dy
CONFIG_QCOW1=3Dy
CONFIG_VDI=3Dy
CONFIG_VVFAT=3Dy
CONFIG_QED=3Dy
CONFIG_PARALLELS=3Dy
CONFIG_SHEEPDOG=3Dy
HAVE_MLOCKALL=3Dy
HAVE_GDB_BIN=3D/usr/local/bin/gdb
ROMS=3D
MAKE=3Dmake
INSTALL=3Dinstall
INSTALL_DIR=3Dinstall -d -m 0755
INSTALL_DATA=3Dinstall -c -m 0644
INSTALL_PROG=3Dinstall -c -m 0755
INSTALL_LIB=3Dinstall -c -m 0644
PYTHON=3D/usr/local/bin/python3 -B
SPHINX_BUILD=3D
GENISOIMAGE=3D/usr/local/bin/mkisofs
MESON=3D/usr/local/bin/meson
CC=3Dcc
CONFIG_IASL=3Diasl
HOST_CC=3Dcc
CXX=3Dc++
OBJCC=3Dclang
AR=3Dar
ARFLAGS=3Drv
AS=3Das
CCAS=3Dcc
CPP=3Dcc -E
OBJCOPY=3Dobjcopy
LD=3Dld
RANLIB=3Dranlib
NM=3Dnm
PKG_CONFIG=3Dpkg-config
WINDRES=3Dwindres
CFLAGS=3D-O2 -g -std=3Dgnu99 -Wall
CXXFLAGS=3D-O2 -g -std=3Dgnu++11 -Wall
CFLAGS_NOPIE=3D
QEMU_CFLAGS=3D-I/usr/local/Cellar/pixman/0.40.0/include/pixman-1 -I/Users/r=
=2Ebolshakov/dev/qemu/dtc/libfdt  -I/usr/local/Cellar/glib/2.64.4_2/include=
 -I/usr/local/Cellar/glib/2.64.4_2/include/glib-2.0 -I/usr/local/Cellar/gli=
b/2.64.4_2/lib/glib-2.0/include -I/usr/local/opt/gettext/include -I/usr/loc=
al/Cellar/pcre/8.44/include -m64 -mcx16 -DOS_OBJECT_USE_OBJC=3D0 -arch x86_=
64 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -Wstrict-prot=
otypes -Wredundant-decls -Wundef -Wwrite-strings -Wmissing-prototypes -fno-=
strict-aliasing -fno-common -fwrapv  -Wold-style-definition -Wtype-limits -=
Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers -Wempty-body=
 -Wnested-externs -Wendif-labels -Wexpansion-to-defined -Wno-initializer-ov=
errides -Wno-missing-include-dirs -Wno-shift-negative-value -Wno-string-plu=
s-int -Wno-typedef-redefinition -Wno-tautological-type-limit-compare -fstac=
k-protector-strong -I/usr/local/Cellar/gnutls/3.6.14/include -I/usr/local/C=
ellar/nettle/3.6/include -I/usr/local/Cellar/libtasn1/4.16.0/include -I/usr=
/local/Cellar/libidn2/2.3.0/include -I/usr/local/Cellar/p11-kit/0.23.20_1/i=
nclude/p11-kit-1 -I/usr/local/Cellar/nettle/3.6/include -I/Users/r.bolshako=
v/dev/qemu/capstone/include
QEMU_CXXFLAGS=3D -D__STDC_LIMIT_MACROS -D__STDC_CONSTANT_MACROS -D__STDC_FO=
RMAT_MACROS -I/usr/local/Cellar/glib/2.64.4_2/include -I/usr/local/Cellar/g=
lib/2.64.4_2/include/glib-2.0 -I/usr/local/Cellar/glib/2.64.4_2/lib/glib-2.=
0/include -I/usr/local/opt/gettext/include -I/usr/local/Cellar/pcre/8.44/in=
clude -m64 -mcx16 -DOS_OBJECT_USE_OBJC=3D0 -arch x86_64 -D_GNU_SOURCE -D_FI=
LE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -Wundef -Wwrite-strings -fno-strict=
-aliasing -fno-common -fwrapv -Wtype-limits -Wformat-security -Wformat-y2k =
-Winit-self -Wignored-qualifiers -Wempty-body -Wendif-labels -Wexpansion-to=
-defined -Wno-initializer-overrides -Wno-missing-include-dirs -Wno-shift-ne=
gative-value -Wno-string-plus-int -Wno-typedef-redefinition -Wno-tautologic=
al-type-limit-compare -fstack-protector-strong -I/usr/local/Cellar/gnutls/3=
=2E6.14/include -I/usr/local/Cellar/nettle/3.6/include -I/usr/local/Cellar/=
libtasn1/4.16.0/include -I/usr/local/Cellar/libidn2/2.3.0/include -I/usr/lo=
cal/Cellar/p11-kit/0.23.20_1/include/p11-kit-1 -I/usr/local/Cellar/nettle/3=
=2E6/include -I/Users/r.bolshakov/dev/qemu/capstone/include
QEMU_INCLUDES=3D-iquote /Users/r.bolshakov/dev/qemu/tcg/i386 -iquote . -iqu=
ote /Users/r.bolshakov/dev/qemu -iquote /Users/r.bolshakov/dev/qemu/accel/t=
cg -iquote /Users/r.bolshakov/dev/qemu/include -iquote /Users/r.bolshakov/d=
ev/qemu/disas/libvixl
GLIB_CFLAGS=3D-I/usr/local/Cellar/glib/2.64.4_2/include -I/usr/local/Cellar=
/glib/2.64.4_2/include/glib-2.0 -I/usr/local/Cellar/glib/2.64.4_2/lib/glib-=
2.0/include -I/usr/local/opt/gettext/include -I/usr/local/Cellar/pcre/8.44/=
include
GLIB_LIBS=3D-L/usr/local/Cellar/glib/2.64.4_2/lib -L/usr/local/opt/gettext/=
lib -lgthread-2.0 -lglib-2.0 -lintl
QEMU_LDFLAGS=3D-L/Users/r.bolshakov/dev/qemu/build/dtc/libfdt -framework Hy=
pervisor -m64 -framework CoreFoundation -framework IOKit -arch x86_64  -fst=
ack-protector-strong
LDFLAGS_NOPIE=3D
LD_REL_FLAGS=3D
LD_I386_EMULATION=3D
LIBS+=3D-lz -L/usr/local/Cellar/glib/2.64.4_2/lib -L/usr/local/opt/gettext/=
lib -lgthread-2.0 -lglib-2.0 -lintl -L/usr/local/Cellar/nettle/3.6/lib -lne=
ttle -L/usr/local/Cellar/gnutls/3.6.14/lib -lgnutls=20
LIBS_TOOLS+=3D
PTHREAD_LIB=3D
EXESUF=3D
HOST_DSOSUF=3D.so
LDFLAGS_SHARED=3D-bundle -undefined dynamic_lookup
LIBS_QGA=3D
TASN1_LIBS=3D-L/usr/local/Cellar/libtasn1/4.16.0/lib -ltasn1
TASN1_CFLAGS=3D-I/usr/local/Cellar/libtasn1/4.16.0/include
POD2MAN=3Dpod2man --utf8
DECOMPRESS_EDK2_BLOBS=3Dy
PIXMAN_CFLAGS=3D-I/usr/local/Cellar/pixman/0.40.0/include/pixman-1
PIXMAN_LIBS=3D-L/usr/local/Cellar/pixman/0.40.0/lib -lpixman-1
qemu-version.h: dtc/all
qemu-version.h: capstone/all
LIBCAPSTONE=3Dlibcapstone.a

