Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A585C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 16:12:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B764B20855
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 16:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PjYK1yU1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B764B20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k99eM-0005nq-2C
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 12:12:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55990)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hsp.cat7@gmail.com>)
 id 1k99dk-0005KZ-Br
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 12:11:40 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236]:41471)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hsp.cat7@gmail.com>)
 id 1k99dh-0004Bn-PI
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 12:11:40 -0400
Received: by mail-oi1-x236.google.com with SMTP id b22so1937753oic.8
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 09:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YxT5sQQ3OyLtl241Wi7hL3uhq+nkrr0qKfBwHWADsP0=;
 b=PjYK1yU12jozp5AXDqC4GCp96QeB4nel/CjKABSybV1ujnsKq6LQreqgtIt61YlA1E
 3IwaYAZjMtUm2vWdK6SwaDf85DhqY835q62ysX4E/8iZrvuvWn610jirKmb4//hKCaQs
 7GmkxsTaObENLLziDSD5AuFpeLHas3kr84uOkei0axSuVJ1huQ4+BijVcaa22XoiJkwK
 QIN04KUujNTJvd50MatMH1okILHBCbAzJ5p9AgtzbvsG2JXdyLqdipmVyARvQ4jZViHi
 MmLRXqwjpxvtmazxqTeRGJorV7DYanErQEJrbhVu/3QJnUlEtRRCJp4DYYuLyiKLToCX
 imqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YxT5sQQ3OyLtl241Wi7hL3uhq+nkrr0qKfBwHWADsP0=;
 b=mVrLgpKccjRAeISJXSTd0Xq5AZJ0Jd53wcFN5zocRNax0WiRJt5WVGp5Vbz+Qom9pY
 KQT1QG71ez7ndjYtlpnhoK+ULTMquaOSyqG/3kgfNiFjSI5rf0XHCRQ5ioX83qfsFU8+
 sj921M8jh9Q2J3JFId00dSri7ArkCWzx04JQ0atq7SlzdbGQOS7DFaRviwv9bhgDY5rP
 OS/qdT8hTEVGmmu+OuiC9M5BE3JPTyqSbsPXiq0Y4NBqzSu9b6PPGFVK5ixlJZKCAP6R
 McuiHx7oWW42VuZzNLSTrymAZE7RZePTSa2wwR5+KnAWlNywC9BF4B/P0snVnhVwpCch
 l6fA==
X-Gm-Message-State: AOAM533phbDY8A3B1vtwyCcJCBdoLyCA6Xd6kCJELpW0jAyzLXx53Qz3
 0dqcDl6NYqYaatDL+0Hf7OgWOmHVeBn9AEN62FI=
X-Google-Smtp-Source: ABdhPJyicniud5OWQOcE61PTMzKJuqFZbynH5YtfWi3NRcGiq9BvncdI7KtwNKbAZG6EhsR7qZo3XI3WadDFOvUrgU8=
X-Received: by 2002:aca:490:: with SMTP id 138mr2298048oie.62.1598026296655;
 Fri, 21 Aug 2020 09:11:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200819213203.17876-1-pbonzini@redhat.com>
 <CABLmASFno04tFBRTq=V8AO7dj1d67-SNpugUJMVVa4yzrPq03Q@mail.gmail.com>
 <CABLmASECM5tVVw3TMJn+0bCT7O4H_guy5TJd9YQKYYx+QUKBKQ@mail.gmail.com>
 <dd66cee7-c6d2-a81e-2e53-eca34ed78be8@redhat.com>
In-Reply-To: <dd66cee7-c6d2-a81e-2e53-eca34ed78be8@redhat.com>
From: Howard Spoelstra <hsp.cat7@gmail.com>
Date: Fri, 21 Aug 2020 18:11:23 +0200
Message-ID: <CABLmASG_VtxD6L=RWotVJZ+C6KxPwoYCQ-K=1TbL8XqF7S5piA@mail.gmail.com>
Subject: Re: [PULL v7 000/151] Meson-based build system
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000c1044e05ad657d2c"
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=hsp.cat7@gmail.com; helo=mail-oi1-x236.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000c1044e05ad657d2c
Content-Type: text/plain; charset="UTF-8"

> How are you executing ldd?  I cross built a mingw executable from Fedora
> and it was definitely using system DLLs.
>
> This is what I see in Fedora 32 before moving executable and dlls to
Windows:

[hsp@localhost build]$ uname -a
Linux localhost.localdomain 5.7.14-200.fc32.x86_64 #1 SMP Fri Aug 7
23:16:37 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux

[hsp@localhost build]$ ../configure --cross-prefix=x86_64-w64-mingw32-
--enable-gtk --enable-sdl --target-list=ppc-softmmu --disable-pie
cross containers  podman
The Meson build system
Version: 0.55.0
Source dir: /home/hsp/src/qemu-master
Build dir: /home/hsp/src/qemu-master/build
Build type: cross build
Project name: qemu
Project version: 5.1.50
C compiler for the build machine: cc (gcc 10.2.1 "cc (GCC) 10.2.1 20200723
(Red Hat 10.2.1-1)")
C linker for the build machine: cc ld.bfd 2.34-4
C compiler for the host machine: x86_64-w64-mingw32-gcc (gcc 9.2.1
"x86_64-w64-mingw32-gcc (GCC) 9.2.1 20190827 (Fedora MinGW 9.2.1-6.fc32)")
C linker for the host machine: x86_64-w64-mingw32-gcc ld.bfd 2.32
Build machine cpu family: x86_64
Build machine cpu: x86_64
Host machine cpu family: x86
Host machine cpu: x86_64
Target machine cpu family: x86
Target machine cpu: x86_64
../meson.build:9: WARNING: Module unstable-keyval has no backwards or
forwards compatibility and might not exist in future releases.
Program sh found: YES
Program python3 found: YES (/usr/bin/python3)
C++ compiler for the host machine: x86_64-w64-mingw32-g++ (gcc 9.2.1
"x86_64-w64-mingw32-g++ (GCC) 9.2.1 20190827 (Fedora MinGW 9.2.1-6.fc32)")
C++ linker for the host machine: x86_64-w64-mingw32-g++ ld.bfd 2.32
Configuring ninjatool using configuration
Library m found: YES
Library util found: NO
Library ws2_32 found: YES
Library winmm found: YES
Windows resource compiler: GNU windres version 2.32-%{release}
Library aio found: NO
Library rt found: NO
Found pkg-config: /usr/bin/x86_64-w64-mingw32-pkg-config (0.28)
Run-time dependency sdl2 found: YES 2.0.12
Found CMake: NO
Run-time dependency sdl-image found: NO (tried pkgconfig and cmake)
Run-time dependency libpng found: YES 1.6.37
Has header "jpeglib.h" : YES
Library jpeg found: YES
Has header "sasl/sasl.h" : NO
Configuring config-host.h using configuration
Program scripts/minikconf.py found: YES
Configuring ppc-softmmu-config-target.h using configuration
Configuring ppc-softmmu-config-devices.mak with command
Reading depfile:
/home/hsp/src/qemu-master/build/meson-private/ppc-softmmu-config-devices.mak.d
Configuring ppc-softmmu-config-devices.h using configuration
Program scripts/grepy.sh found: YES
Configuring config-all-devices.mak with command
Program scripts/hxtool found: YES
Program scripts/shaderinclude.pl found: YES
Program scripts/qapi-gen.py found: YES
Program scripts/qemu-version.sh found: YES
Run-time dependency threads found: YES
Program keycodemapdb/tools/keymap-gen found: YES
Program scripts/decodetree.py found: YES
Program ../scripts/modules/module_block.py found: YES
Program x86_64-w64-mingw32-nm found: YES
Program scripts/undefsym.sh found: YES
Program scripts/feature_to_c.sh found: YES
Program wixl found: NO
Program bzip2 found: YES
Configuring 50-edk2-i386-secure.json using configuration
Configuring 50-edk2-x86_64-secure.json using configuration
Configuring 60-edk2-aarch64.json using configuration
Configuring 60-edk2-arm.json using configuration
Configuring 60-edk2-i386.json using configuration
Configuring 60-edk2-x86_64.json using configuration
Program diff found: YES
Build targets in project: 215

qemu 5.1.50

            Install prefix: c:/Program Files/QEMU
            BIOS directory: c:/Program Files/QEMU
             firmware path: ${prefix}/share/qemu-firmware
          binary directory: c:/Program Files/QEMU
         library directory: c:/Program Files/QEMU/lib
          module directory: c:/Program Files/QEMU/lib
         libexec directory: c:/Program Files/QEMU/libexec
         include directory: c:/Program Files/QEMU/include
          config directory: c:/Program Files/QEMU
     local state directory: queried at runtime
           Build directory: /home/hsp/src/qemu-master/build
               Source path: /home/hsp/src/qemu-master
                GIT binary: git
            GIT submodules: ui/keycodemapdb tests/fp/berkeley-testfloat-3
tests/fp/berkeley-softfloat-3 meson dtc capstone slirp
                C compiler: x86_64-w64-mingw32-gcc
           Host C compiler: cc
              C++ compiler: x86_64-w64-mingw32-g++
                   ARFLAGS: rv
                    CFLAGS: -O2 -g -fno-pie -mthreads -std=gnu99 -Wall
               QEMU_CFLAGS:
-I/usr/x86_64-w64-mingw32/sys-root/mingw/include/pixman-1
 -I/home/hsp/src/qemu-master/dtc/libfdt -Werror -U_FORTIFY_SOURCE
-D_FORTIFY_SOURCE=2 -I/usr/x86_64-w64-mingw32/sys-root/mingw/include
 -mms-bitfields -I/usr/x86_64-w64-mingw32/sys-root/mingw/include
-I/usr/x86_64-w64-mingw32/sys-root/mingw/include/glib-2.0
-I/usr/x86_64-w64-mingw32/sys-root/mingw/lib/glib-2.0/include
-I/usr/x86_64-w64-mingw32/sys-root/mingw/include  -m64 -mcx16 -D_GNU_SOURCE
-D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -Wstrict-prototypes
-Wredundant-decls -Wundef -Wwrite-strings -Wmissing-prototypes
-fno-strict-aliasing -fno-common -fwrapv  -Wold-style-declaration
-Wold-style-definition -Wtype-limits -Wformat-security -Wformat-y2k
-Winit-self -Wignored-qualifiers -Wempty-body -Wnested-externs
-Wendif-labels -Wexpansion-to-defined -Wno-missing-include-dirs
-Wno-shift-negative-value -Wno-psabi -fstack-protector-strong
-I/home/hsp/src/qemu-master/capstone/include
              QEMU_LDFLAGS: -L/home/hsp/src/qemu-master/build/dtc/libfdt
-Wl,--nxcompat -Wl,--no-seh -Wl,--dynamicbase -Wl,--warn-common -m64
 -fstack-protector-strong
                      make: make
                   install: install
                    python: /usr/bin/python3 (version: 3.8)
              sphinx-build:
               genisoimage: /usr/bin/genisoimage
             slirp support: YES
                      smbd: "/usr/sbin/smbd"
            module support: NO
                  host CPU: x86
           host endianness: little
               target list: ppc-softmmu
             gprof enabled: NO
            sparse enabled: NO
            strip binaries: YES
                  profiler: NO
              static build: YES
               SDL support: YES
         SDL image support: NO
               GTK support: YES
            GTK GL support: NO
               VTE support: NO
              TLS priority: "NORMAL"
            GNUTLS support: NO
                 libgcrypt: NO
                    nettle: NO
                  libtasn1: NO
                       PAM: NO
             iconv support: YES
            curses support: NO
             virgl support: NO
              curl support: NO
           mingw32 support: YES
             Audio drivers: dsound
      Block whitelist (rw):
      Block whitelist (ro):
            VirtFS support: NO
         Multipath support: NO
               VNC support: YES
          VNC SASL support: NO
          VNC JPEG support: YES
           VNC PNG support: YES
               xen support: NO
            brlapi support: NO
             Documentation: NO
                       PIE: NO
               vde support: NO
            netmap support: NO
         Linux AIO support: NO
    Linux io_uring support: NO
        ATTR/XATTR support: NO
             Install blobs: YES
       malloc trim support: NO
              RDMA support: NO
            PVRDMA support: NO
               fdt support: YES
                membarrier: NO
            preadv support: NO
                 fdatasync: NO
                   madvise: NO
             posix_madvise: NO
            posix_memalign: NO
         libcap-ng support: NO
         vhost-net support: NO
      vhost-crypto support: NO
        vhost-scsi support: NO
       vhost-vsock support: NO
        vhost-user support: NO
     vhost-user-fs support: NO
        vhost-vdpa support: NO
            Trace backends: log
             spice support: NO
               rbd support: NO
            xfsctl support: NO
         smartcard support: NO
                    libusb: YES
             usb net redir: NO
            OpenGL support: NO
            OpenGL dmabufs: NO
          libiscsi support: NO
            libnfs support: NO
         build guest agent: YES
           QGA VSS support: NO
         QGA w32 disk info: YES
           QGA MSI support: NO
           seccomp support: NO
         coroutine backend: win32
            coroutine pool: YES
         debug stack usage: NO
           mutex debugging: NO
              crypto afalg: NO
         GlusterFS support: NO
                      gcov: NO
               TPM support: NO
            libssh support: NO
             QOM debugging: YES
      Live block migration: YES
               lzo support: NO
            snappy support: NO
             bzip2 support: YES
             lzfse support: NO
              zstd support: NO
         NUMA host support: NO
                   libxml2: NO
          tcmalloc support: NO
          jemalloc support: NO
         avx2 optimization: YES
      avx512f optimization: NO
       replication support: YES
             bochs support: YES
             cloop support: YES
               dmg support: YES
           qcow v1 support: YES
               vdi support: YES
             vvfat support: YES
               qed support: YES
         parallels support: YES
          sheepdog support: YES
                  capstone: YES
           libpmem support: NO
         libdaxctl support: NO
                   libudev: NO
           default devices: YES
            plugin support: NO
           fuzzing support: NO
                       gdb: /usr/bin/gdb
          thread sanitizer: NO
                  rng-none: NO
             Linux keyring: NO

Found ninjatool-1.8 at /home/hsp/src/qemu-master/build/ninjatool
WARNING: custom_target 'shared QAPI source files' has more than one output!
Using the first one.
WARNING: custom_target 'QGA QAPI files' has more than one output! Using the
first one.
WARNING: custom_target 'QAPI files for qemu-storage-daemon' has more than
one output! Using the first one.
WARNING: custom_target 'QAPI doc' has more than one output! Using the first
one.
Command line for building ['libcommon.fa'] is long, using a response file
[hsp@localhost build]$ make -j4
....
[hsp@localhost build]$ ldd qemu-system-ppc.exe
not a dynamic executable
[hsp@localhost build]$ which ldd
/usr/bin/ldd
[hsp@localhost build]$

Best,
Howard

--000000000000c1044e05ad657d2c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><div class=3D"gmail_quote"><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">
How are you executing ldd?=C2=A0 I cross built a mingw executable from Fedo=
ra<br>
and it was definitely using system DLLs.<br>
<br></blockquote><div>This is what I see in Fedora 32 before moving executa=
ble and dlls to Windows:</div><div><br></div><div>[hsp@localhost build]$ un=
ame -a<br>Linux localhost.localdomain 5.7.14-200.fc32.x86_64 #1 SMP Fri Aug=
 7 23:16:37 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux<br></div><div><br></div=
><div>[hsp@localhost build]$ ../configure --cross-prefix=3Dx86_64-w64-mingw=
32- --enable-gtk --enable-sdl --target-list=3Dppc-softmmu --disable-pie<br>=
cross containers =C2=A0podman<br>The Meson build system<br>Version: 0.55.0<=
br>Source dir: /home/hsp/src/qemu-master<br>Build dir: /home/hsp/src/qemu-m=
aster/build<br>Build type: cross build<br>Project name: qemu<br>Project ver=
sion: 5.1.50<br>C compiler for the build machine: cc (gcc 10.2.1 &quot;cc (=
GCC) 10.2.1 20200723 (Red Hat 10.2.1-1)&quot;)<br>C linker for the build ma=
chine: cc ld.bfd 2.34-4<br>C compiler for the host machine: x86_64-w64-ming=
w32-gcc (gcc 9.2.1 &quot;x86_64-w64-mingw32-gcc (GCC) 9.2.1 20190827 (Fedor=
a MinGW 9.2.1-6.fc32)&quot;)<br>C linker for the host machine: x86_64-w64-m=
ingw32-gcc ld.bfd 2.32<br>Build machine cpu family: x86_64<br>Build machine=
 cpu: x86_64<br>Host machine cpu family: x86<br>Host machine cpu: x86_64<br=
>Target machine cpu family: x86<br>Target machine cpu: x86_64<br>../meson.b=
uild:9: WARNING: Module unstable-keyval has no backwards or forwards compat=
ibility and might not exist in future releases.<br>Program sh found: YES<br=
>Program python3 found: YES (/usr/bin/python3)<br>C++ compiler for the host=
 machine: x86_64-w64-mingw32-g++ (gcc 9.2.1 &quot;x86_64-w64-mingw32-g++ (G=
CC) 9.2.1 20190827 (Fedora MinGW 9.2.1-6.fc32)&quot;)<br>C++ linker for the=
 host machine: x86_64-w64-mingw32-g++ ld.bfd 2.32<br>Configuring ninjatool =
using configuration<br>Library m found: YES<br>Library util found: NO<br>Li=
brary ws2_32 found: YES<br>Library winmm found: YES<br>Windows resource com=
piler: GNU windres version 2.32-%{release}<br>Library aio found: NO<br>Libr=
ary rt found: NO<br>Found pkg-config: /usr/bin/x86_64-w64-mingw32-pkg-confi=
g (0.28)<br>Run-time dependency sdl2 found: YES 2.0.12<br>Found CMake: NO<b=
r>Run-time dependency sdl-image found: NO (tried pkgconfig and cmake)<br>Ru=
n-time dependency libpng found: YES 1.6.37<br>Has header &quot;jpeglib.h&qu=
ot; : YES <br>Library jpeg found: YES<br>Has header &quot;sasl/sasl.h&quot;=
 : NO <br>Configuring config-host.h using configuration<br>Program scripts/=
minikconf.py found: YES<br>Configuring ppc-softmmu-config-target.h using co=
nfiguration<br>Configuring ppc-softmmu-config-devices.mak with command<br>R=
eading depfile: /home/hsp/src/qemu-master/build/meson-private/ppc-softmmu-c=
onfig-devices.mak.d<br>Configuring ppc-softmmu-config-devices.h using confi=
guration<br>Program scripts/grepy.sh found: YES<br>Configuring config-all-d=
evices.mak with command<br>Program scripts/hxtool found: YES<br>Program scr=
ipts/<a href=3D"http://shaderinclude.pl">shaderinclude.pl</a> found: YES<br=
>Program scripts/qapi-gen.py found: YES<br>Program scripts/qemu-version.sh =
found: YES<br>Run-time dependency threads found: YES<br>Program keycodemapd=
b/tools/keymap-gen found: YES<br>Program scripts/decodetree.py found: YES<b=
r>Program ../scripts/modules/module_block.py found: YES<br>Program x86_64-w=
64-mingw32-nm found: YES<br>Program scripts/undefsym.sh found: YES<br>Progr=
am scripts/feature_to_c.sh found: YES<br>Program wixl found: NO<br>Program =
bzip2 found: YES<br>Configuring 50-edk2-i386-secure.json using configuratio=
n<br>Configuring 50-edk2-x86_64-secure.json using configuration<br>Configur=
ing 60-edk2-aarch64.json using configuration<br>Configuring 60-edk2-arm.jso=
n using configuration<br>Configuring 60-edk2-i386.json using configuration<=
br>Configuring 60-edk2-x86_64.json using configuration<br>Program diff foun=
d: YES<br>Build targets in project: 215<br><br>qemu 5.1.50<br><br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Install prefix: c:/Program Files/QEMU<br=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BIOS directory: c:/Program Files=
/QEMU<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0firmware path: ${p=
refix}/share/qemu-firmware<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 binary dir=
ectory: c:/Program Files/QEMU<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0library =
directory: c:/Program Files/QEMU/lib<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
module directory: c:/Program Files/QEMU/lib<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0libexec directory: c:/Program Files/QEMU/libexec<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0include directory: c:/Program Files/QEMU/include<br>=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 config directory: c:/Program Files/QEMU<br>=C2=
=A0 =C2=A0 =C2=A0local state directory: queried at runtime<br>=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0Build directory: /home/hsp/src/qemu-master/buil=
d<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Source path: /h=
ome/hsp/src/qemu-master<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 GIT binary: git<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GIT su=
bmodules: ui/keycodemapdb tests/fp/berkeley-testfloat-3 tests/fp/berkeley-s=
oftfloat-3 meson dtc capstone slirp<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 C compiler: x86_64-w64-mingw32-gcc<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0Host C compiler: cc<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 C++ compiler: x86_64-w64-mingw32-g++<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ARFLAGS: rv<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CFLAG=
S: -O2 -g -fno-pie -mthreads -std=3Dgnu99 -Wall<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0QEMU_CFLAGS: -I/usr/x86_64-w64-mingw32/sys-r=
oot/mingw/include/pixman-1 =C2=A0-I/home/hsp/src/qemu-master/dtc/libfdt -We=
rror -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=3D2 -I/usr/x86_64-w64-mingw32/sys-=
root/mingw/include =C2=A0-mms-bitfields -I/usr/x86_64-w64-mingw32/sys-root/=
mingw/include -I/usr/x86_64-w64-mingw32/sys-root/mingw/include/glib-2.0 -I/=
usr/x86_64-w64-mingw32/sys-root/mingw/lib/glib-2.0/include -I/usr/x86_64-w6=
4-mingw32/sys-root/mingw/include =C2=A0-m64 -mcx16 -D_GNU_SOURCE -D_FILE_OF=
FSET_BITS=3D64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -W=
undef -Wwrite-strings -Wmissing-prototypes -fno-strict-aliasing -fno-common=
 -fwrapv =C2=A0-Wold-style-declaration -Wold-style-definition -Wtype-limits=
 -Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers -Wempty-bo=
dy -Wnested-externs -Wendif-labels -Wexpansion-to-defined -Wno-missing-incl=
ude-dirs -Wno-shift-negative-value -Wno-psabi -fstack-protector-strong -I/h=
ome/hsp/src/qemu-master/capstone/include<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 QEMU_LDFLAGS: -L/home/hsp/src/qemu-master/build/dtc/libfd=
t -Wl,--nxcompat -Wl,--no-seh -Wl,--dynamicbase -Wl,--warn-common -m64 =C2=
=A0-fstack-protector-strong<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 make: make<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0install: install<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 python: /usr/bi=
n/python3 (version: 3.8)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 sphinx-build: <br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0genisoimage: /usr/bin/genisoimage<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0slirp support: YES<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 smbd: &quot;/usr/sbin/smbd&quot;<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 module support: NO<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 host CPU: x86<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0host endianness: little<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0target list: ppc-softmmu<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gprof enabled: NO<br>=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sparse enabled: NO<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 strip binaries: YES<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 profiler: NO<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 static build: YES<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SDL support: YES<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0SDL image support: NO<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0GTK support: YES<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 GTK GL support: NO<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0VTE support: NO<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 T=
LS priority: &quot;NORMAL&quot;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 GNUTLS support: NO<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0libgcrypt: NO<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 nettle: NO<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 libtasn1: NO<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PAM: NO<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iconv support: YES<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 curses support: NO<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0virgl support: NO<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 curl support: NO<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0mingw32 support: YES<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0Audio drivers: dsound<br>=C2=A0 =C2=A0 =C2=A0 Block whitelist (rw): <=
br>=C2=A0 =C2=A0 =C2=A0 Block whitelist (ro): <br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 VirtFS support: NO<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0M=
ultipath support: NO<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0VNC support: YES<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VNC SASL suppo=
rt: NO<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VNC JPEG support: YES<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VNC PNG support: YES<br>=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0xen support: NO<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 brlapi support: NO<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0Documentation: NO<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PIE: NO<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vde support: NO<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 netmap support: NO<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0Linux AIO support: NO<br>=C2=A0 =C2=A0 Linux io_uring supp=
ort: NO<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 ATTR/XATTR support: NO<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Install blobs: YES<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0malloc trim support: NO<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 RDMA support: NO<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 PVRDMA support: NO<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0fdt support: YES<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 membarrier: NO<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 preadv supp=
ort: NO<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fd=
atasync: NO<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0madvise: NO<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0po=
six_madvise: NO<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 posix_memalign=
: NO<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0libcap-ng support: NO<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0vhost-net support: NO<br>=C2=A0 =C2=A0 =C2=A0 vh=
ost-crypto support: NO<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 vhost-scsi support: N=
O<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0vhost-vsock support: NO<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 vhost-user support: NO<br>=C2=A0 =C2=A0 =C2=A0vhost-user-fs s=
upport: NO<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 vhost-vdpa support: NO<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Trace backends: log<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0spice support: NO<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rbd support: NO<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 xfsctl support: NO<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0smartcard support: NO<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 libusb: YES<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0usb net redir: NO<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 OpenGL support: NO<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OpenGL dma=
bufs: NO<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 libiscsi support: NO<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 libnfs support: NO<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0build guest agent: YES<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0QGA VSS support: NO<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0QGA w=
32 disk info: YES<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0QGA MSI suppo=
rt: NO<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0seccomp support: NO<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0coroutine backend: win32<br>=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 coroutine pool: YES<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0debug stack usage: NO<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0mutex debugging: NO<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 crypto afalg: NO<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0GlusterFS support=
: NO<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 gcov: NO<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0TPM support: NO<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 libssh supp=
ort: NO<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0QOM debugging: Y=
ES<br>=C2=A0 =C2=A0 =C2=A0 Live block migration: YES<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0lzo support: NO<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 snappy support: NO<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0bzip2 support: YES<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0lzfse support: NO<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 zstd support: NO<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NUMA ho=
st support: NO<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0libxml2: NO<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcmalloc sup=
port: NO<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 jemalloc support: NO<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0avx2 optimization: YES<br>=C2=A0 =C2=A0 =C2=
=A0 avx512f optimization: NO<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0replication supp=
ort: YES<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bochs support: =
YES<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cloop support: YES<b=
r>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dmg support: YES<b=
r>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qcow v1 support: YES<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vdi support: YES<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vvfat support: YES<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qed support: YES<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0parallels support: YES<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 sheepdog support: YES<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 capstone: YES<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0libpmem support: NO<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0libdaxct=
l support: NO<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0libudev: NO<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0defaul=
t devices: YES<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 plugin support:=
 NO<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fuzzing support: NO<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0gdb: /usr/bin/gdb<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 thread saniti=
zer: NO<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r=
ng-none: NO<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Linux keyrin=
g: NO<br><br>Found ninjatool-1.8 at /home/hsp/src/qemu-master/build/ninjato=
ol<br>WARNING: custom_target &#39;shared QAPI source files&#39; has more th=
an one output! Using the first one.<br>WARNING: custom_target &#39;QGA QAPI=
 files&#39; has more than one output! Using the first one.<br>WARNING: cust=
om_target &#39;QAPI files for qemu-storage-daemon&#39; has more than one ou=
tput! Using the first one.<br>WARNING: custom_target &#39;QAPI doc&#39; has=
 more than one output! Using the first one.<br>Command line for building [&=
#39;libcommon.fa&#39;] is long, using a response file<br>[hsp@localhost bui=
ld]$ make -j4<br></div><div>....</div><div>[hsp@localhost build]$ ldd qemu-=
system-ppc.exe<br>	not a dynamic executable<br>[hsp@localhost build]$ which=
 ldd<br>/usr/bin/ldd<br>[hsp@localhost build]$ <br></div><div><br></div><di=
v>Best,</div><div>Howard<br></div></div></div>

--000000000000c1044e05ad657d2c--

