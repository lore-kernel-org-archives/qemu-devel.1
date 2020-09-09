Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00212C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 15:06:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4292222268
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 15:06:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4292222268
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG1gO-0004jF-RY
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 11:06:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34216)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kG1fV-000416-UY
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 11:05:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:56888)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kG1fS-0002dJ-54
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 11:05:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 52F85AFB7;
 Wed,  9 Sep 2020 15:06:04 +0000 (UTC)
Subject: Re: Meson can't recover from deletion of generated QAPI file(s)
From: Claudio Fontana <cfontana@suse.de>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
References: <87pn6vw2he.fsf@dusky.pond.sub.org>
 <ff7ef6e4-254a-b171-22bf-c5cca4945160@redhat.com>
 <26432e3f-2b22-4966-ebea-8be448636fbb@suse.de>
 <2d49cdbb-41e2-ae1d-79cd-3a05678e9b87@redhat.com>
 <a443d9fe-d831-c7f2-5300-7f1d8660c81f@suse.de>
Message-ID: <0b2617b8-10dd-d487-cfa0-67b646c72ac0@suse.de>
Date: Wed, 9 Sep 2020 17:05:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <a443d9fe-d831-c7f2-5300-7f1d8660c81f@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 00:22:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -77
X-Spam_score: -7.8
X-Spam_bar: -------
X-Spam_report: (-7.8 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.576,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/9/20 4:36 PM, Claudio Fontana wrote:
> On 9/9/20 4:35 PM, Paolo Bonzini wrote:
>> On 09/09/20 15:35, Claudio Fontana wrote:
>>> On 9/9/20 3:06 PM, Philippe Mathieu-Daudé wrote:
>>>> Maybe related:
>>>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg736135.html
>>>> and later:
>>>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg738777.html
>>>>
>>>
>>> My use case is this:
>>
>> Hi Claudio,
>>
>> unlike Markus's, your issue is a genuine meson.build bug.  It should be
>> fixed like so:
>>
>> diff --git a/tests/meson.build b/tests/meson.build
>> index 998e4c48f9..721641afbb 100644
>> --- a/tests/meson.build
>> +++ b/tests/meson.build
>> @@ -223,7 +223,7 @@ foreach test_name, extra: tests
>>      src += test_ss.all_sources()
>>      deps += test_ss.all_dependencies()
>>    endif
>> -  exe = executable(test_name, src, dependencies: deps)
>> +  exe = executable(test_name, src, genh, dependencies: deps)
>>
>>    test(test_name, exe,
>>         depends: test_deps.get(test_name, []),
>>
>>
>> Paolo
>>
> 
> Will test right away, thanks!
> 
> C
> 

Hmm, I still encounter problems:

Passed all 120 iotests
+ cd ..
+ rm -fr build-nontcg
+ mkdir build-nontcg
+ cd build-nontcg
+ ../configure --disable-tcg --enable-kvm --enable-hax
cross containers  no

NOTE: guest cross-compilers enabled: cc
The Meson build system
Version: 0.55.1
Source dir: /dev/shm/cfontana/qemu
Build dir: /dev/shm/cfontana/qemu/build-nontcg
Build type: native build
Project name: qemu
Project version: 5.1.50
C compiler for the host machine: cc (gcc 7.5.0 "cc (SUSE Linux) 7.5.0")
C linker for the host machine: cc ld.bfd 2.34.0.20200325-386
Host machine cpu family: x86_64
Host machine cpu: x86_64
../meson.build:10: WARNING: Module unstable-keyval has no backwards or forwards compatibility and might not exist in future releases.
Program sh found: YES
Program python3 found: YES (/usr/bin/python3)
Configuring ninjatool using configuration
C++ compiler for the host machine: c++ (gcc 7.5.0 "c++ (SUSE Linux) 7.5.0")
C++ linker for the host machine: c++ ld.bfd 2.34.0.20200325-386
Library m found: YES
Library util found: YES
Found pkg-config: /usr/bin/pkg-config (0.29.2)
Run-time dependency pixman-1 found: YES 0.34.0
Library pam found: YES
Library aio found: YES
Run-time dependency zlib found: YES 1.2.11
Run-time dependency xkbcommon found: NO (tried pkgconfig)
Library rt found: YES
sdl2-config found: NO
Run-time dependency sdl2 found: NO (tried pkgconfig and config-tool)
Run-time dependency libpng found: NO (tried pkgconfig)
Has header "jpeglib.h" : NO 
Has header "sasl/sasl.h" : YES 
Library sasl2 found: YES
Run-time dependency u2f-emu found: NO (tried pkgconfig)
Run-time dependency libkeyutils found: NO (tried pkgconfig)
Checking for function "gettid" : NO 
Configuring config-host.h using configuration
Program scripts/minikconf.py found: YES
Configuring i386-softmmu-config-target.h using configuration
Configuring i386-softmmu-config-devices.mak with command
Reading depfile: /dev/shm/cfontana/qemu/build-nontcg/meson-private/i386-softmmu-config-devices.mak.d
Configuring i386-softmmu-config-devices.h using configuration
Configuring x86_64-softmmu-config-target.h using configuration
Configuring x86_64-softmmu-config-devices.mak with command
Reading depfile: /dev/shm/cfontana/qemu/build-nontcg/meson-private/x86_64-softmmu-config-devices.mak.d
Configuring x86_64-softmmu-config-devices.h using configuration
Program scripts/hxtool found: YES
Program scripts/shaderinclude.pl found: YES
Program scripts/qapi-gen.py found: YES
Program scripts/qemu-version.sh found: YES
Run-time dependency threads found: YES
Program keycodemapdb/tools/keymap-gen found: YES
Program scripts/decodetree.py found: YES
Program ../scripts/modules/module_block.py found: YES
Program nm found: YES
Program scripts/undefsym.py found: YES
Program scripts/feature_to_c.sh found: YES
Program bzip2 found: YES
Configuring 50-edk2-i386-secure.json using configuration
Configuring 50-edk2-x86_64-secure.json using configuration
Configuring 60-edk2-aarch64.json using configuration
Configuring 60-edk2-arm.json using configuration
Configuring 60-edk2-i386.json using configuration
Configuring 60-edk2-x86_64.json using configuration
Program qemu-keymap found: YES
Program python3 found: YES (/usr/bin/python3)
Program diff found: YES
Program dbus-daemon found: YES
Program initrd-stress.sh found: YES
Build targets in project: 410

qemu 5.1.50

            Install prefix: /usr/local
            BIOS directory: /usr/local/share/qemu
             firmware path: /usr/local/share/qemu-firmware
          binary directory: /usr/local/bin
         library directory: /usr/local/lib
          module directory: /usr/local/lib/qemu
         libexec directory: /usr/local/libexec
         include directory: /usr/local/include
          config directory: /usr/local/etc
     local state directory: /usr/local/var
          Manual directory: share/man
             Doc directory: /usr/local/share/doc
           Build directory: /dev/shm/cfontana/qemu/build-nontcg
               Source path: /dev/shm/cfontana/qemu
                GIT binary: git
            GIT submodules: ui/keycodemapdb tests/fp/berkeley-testfloat-3 tests/fp/berkeley-softfloat-3 meson capstone slirp
                C compiler: cc
           Host C compiler: cc
              C++ compiler: c++
                   ARFLAGS: rv
                    CFLAGS: -O2 -g -fPIE -DPIE -std=gnu99 -Wall
               QEMU_CFLAGS: -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2 -m64 -mcx16 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wundef -Wwrite-strings -Wmissing-prototypes -fno-strict-aliasing -fno-common -fwrapv  -Wold-style-declaration -Wold-style-definition -Wtype-limits -Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers -Wempty-body -Wnested-externs -Wendif-labels -Wexpansion-to-defined -Wno-missing-include-dirs -Wno-shift-negative-value -Wno-psabi -fstack-protector-strong
              QEMU_LDFLAGS: -Wl,--warn-common -Wl,-z,relro -Wl,-z,now -m64  -fstack-protector-strong
                      make: make
                    python: /usr/bin/python3 (version: 3.6)
              sphinx-build: 
               genisoimage: /usr/bin/mkisofs
             slirp support: YES
                      smbd: "/usr/sbin/smbd"
            module support: NO
                  host CPU: x86_64
           host endianness: little
               target list: i386-softmmu x86_64-softmmu
             gprof enabled: NO
            sparse enabled: NO
            strip binaries: YES
                  profiler: NO
              static build: YES
               SDL support: NO
         SDL image support: NO
               GTK support: NO
            GTK GL support: NO
                    pixman: YES
               VTE support: NO
              TLS priority: "NORMAL"
            GNUTLS support: NO
                 libgcrypt: NO
                    nettle: NO
                  libtasn1: NO
                       PAM: YES
             iconv support: YES
            curses support: YES
             virgl support: NO
              curl support: NO
           mingw32 support: NO
             Audio drivers: oss
      Block whitelist (rw): 
      Block whitelist (ro): 
            VirtFS support: NO
         Multipath support: NO
               VNC support: YES
          VNC SASL support: YES
          VNC JPEG support: NO
           VNC PNG support: NO
               xen support: NO
            brlapi support: NO
             Documentation: NO
                       PIE: YES
               vde support: NO
            netmap support: NO
         Linux AIO support: YES
    Linux io_uring support: NO
        ATTR/XATTR support: YES
             Install blobs: YES
       malloc trim support: YES
              RDMA support: NO
            PVRDMA support: NO
               fdt support: NO
                membarrier: NO
            preadv support: YES
                 fdatasync: YES
                   madvise: YES
             posix_madvise: YES
            posix_memalign: YES
         libcap-ng support: NO
         vhost-net support: YES
      vhost-crypto support: YES
        vhost-scsi support: YES
       vhost-vsock support: YES
        vhost-user support: YES
     vhost-user-fs support: YES
        vhost-vdpa support: YES
            Trace backends: log
             spice support: NO
               rbd support: NO
            xfsctl support: NO
         smartcard support: NO
               U2F support: NO
                    libusb: NO
             usb net redir: NO
            OpenGL support: NO
            OpenGL dmabufs: NO
          libiscsi support: NO
            libnfs support: NO
         build guest agent: YES
           seccomp support: NO
         coroutine backend: ucontext
            coroutine pool: YES
         debug stack usage: NO
           mutex debugging: NO
              crypto afalg: NO
         GlusterFS support: NO
                      gcov: NO
               TPM support: YES
            libssh support: NO
             QOM debugging: YES
      Live block migration: YES
               lzo support: NO
            snappy support: NO
             bzip2 support: NO
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
             Linux keyring: YES
Found ninja-1.8.2 at /usr/bin/ninja
+ make -j120
/usr/bin/python3 -B /dev/shm/cfontana/qemu/meson/meson.py introspect --tests --benchmarks | /usr/bin/python3 -B scripts/mtest2make.py > Makefile.mtest
./ninjatool -t ninja2make --omit clean dist uninstall cscope TAGS ctags < build.ninja > Makefile.ninja
make[1]: Entering directory '/dev/shm/cfontana/qemu/slirp'

[...]

  CC      pvh_main.o
  BUILD   multiboot.img
  BUILD   linuxboot.img
  BUILD   linuxboot_dma.img
  BUILD   kvmvapic.img
  BUILD   multiboot.raw
  BUILD   linuxboot.raw
  BUILD   kvmvapic.raw
  BUILD   linuxboot_dma.raw
  SIGN    multiboot.bin
  SIGN    kvmvapic.bin
  SIGN    linuxboot.bin
  SIGN    linuxboot_dma.bin
Linking target contrib/ivshmem-client/ivshmem-client
  BUILD   pvh.img
  BUILD   pvh.raw
In file included from tests/qapi-builtin-visit.c:14:0:
/dev/shm/cfontana/qemu/include/qapi/error.h:275:10: fatal error: qapi/qapi-types-error.h: No such file or directory
 #include "qapi/qapi-types-error.h"
          ^~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
In file included from tests/include/../test-qapi-events-sub-sub-module.h:17:0,
                 from tests/include/test-qapi-events-sub-module.h:16,
                 from tests/test-qapi-events.h:16,
                 from tests/test-qapi-events.c:15:
tests/include/../test-qapi-types-sub-sub-module.h:16:10: fatal error: qapi/qapi-builtin-types.h: No such file or directory
 #include "qapi/qapi-builtin-types.h"
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
In file included from /dev/shm/cfontana/qemu/include/qapi/dealloc-visitor.h:17:0,
                 from tests/qapi-builtin-types.c:14:
/dev/shm/cfontana/qemu/include/qapi/visitor.h:18:10: fatal error: qapi/qapi-builtin-types.h: No such file or directory
 #include "qapi/qapi-builtin-types.h"
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
In file included from /dev/shm/cfontana/qemu/include/qapi/dealloc-visitor.h:17:0,
                 from tests/test-qapi-types.c:14:
/dev/shm/cfontana/qemu/include/qapi/visitor.h:18:10: fatal error: qapi/qapi-builtin-types.h: No such file or directory
 #include "qapi/qapi-builtin-types.h"
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
  SIGN    pvh.bin
In file included from /dev/shm/cfontana/qemu/include/qapi/dealloc-visitor.h:17:0,
                 from tests/include/test-qapi-types-sub-module.c:14:
/dev/shm/cfontana/qemu/include/qapi/visitor.h:18:10: fatal error: qapi/qapi-builtin-types.h: No such file or directory
 #include "qapi/qapi-builtin-types.h"
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
In file included from tests/include/test-qapi-visit-sub-module.c:14:0:
/dev/shm/cfontana/qemu/include/qapi/error.h:275:10: fatal error: qapi/qapi-types-error.h: No such file or directory
 #include "qapi/qapi-types-error.h"
          ^~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make: *** [Makefile.ninja:1760: tests/libtestqapi.a.p/meson-generated_.._qapi-builtin-types.c.o] Error 1
make: *** Waiting for unfinished jobs....
make: *** [Makefile.ninja:1761: tests/libtestqapi.a.p/meson-generated_.._qapi-builtin-visit.c.o] Error 1
make: *** [Makefile.ninja:1766: tests/libtestqapi.a.p/meson-generated_.._test-qapi-events.c.o] Error 1
make: *** [Makefile.ninja:1770: tests/libtestqapi.a.p/meson-generated_.._test-qapi-types.c.o] Error 1
make: *** [Makefile.ninja:1775: tests/libtestqapi.a.p/meson-generated_.._include_test-qapi-types-sub-module.c.o] Error 1
make: *** [Makefile.ninja:1776: tests/libtestqapi.a.p/meson-generated_.._include_test-qapi-visit-sub-module.c.o] Error 1

In file included from tests/test-qapi-visit-sub-sub-module.c:14:0:
/dev/shm/cfontana/qemu/include/qapi/error.h:275:10: fatal error: qapi/qapi-types-error.h: No such file or directory
 #include "qapi/qapi-types-error.h"
          ^~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
In file included from tests/include/test-qapi-commands-sub-module.c:14:0:
/dev/shm/cfontana/qemu/include/qapi/visitor.h:18:10: fatal error: qapi/qapi-builtin-types.h: No such file or directory
 #include "qapi/qapi-builtin-types.h"
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
In file included from /dev/shm/cfontana/qemu/include/qapi/qmp/qlit.h:17:0,
                 from tests/test-qapi-introspect.h:15,
                 from tests/test-qapi-introspect.c:13:
/dev/shm/cfontana/qemu/include/qapi/qmp/qobject.h:35:10: fatal error: qapi/qapi-builtin-types.h: No such file or directory
 #include "qapi/qapi-builtin-types.h"
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
In file included from /dev/shm/cfontana/qemu/include/qapi/dealloc-visitor.h:17:0,
                 from tests/test-qapi-types-sub-sub-module.c:14:
/dev/shm/cfontana/qemu/include/qapi/visitor.h:18:10: fatal error: qapi/qapi-builtin-types.h: No such file or directory
 #include "qapi/qapi-builtin-types.h"
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make: *** [Makefile.ninja:1768: tests/libtestqapi.a.p/meson-generated_.._test-qapi-introspect.c.o] Error 1
make: *** [Makefile.ninja:1773: tests/libtestqapi.a.p/meson-generated_.._include_test-qapi-commands-sub-module.c.o] Error 1
make: *** [Makefile.ninja:1771: tests/libtestqapi.a.p/meson-generated_.._test-qapi-visit-sub-sub-module.c.o] Error 1
In file included from tests/test-qapi-commands.c:14:0:
/dev/shm/cfontana/qemu/include/qapi/visitor.h:18:10: fatal error: qapi/qapi-builtin-types.h: No such file or directory
 #include "qapi/qapi-builtin-types.h"
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
In file included from tests/include/../test-qapi-events-sub-sub-module.h:17:0,
                 from tests/include/test-qapi-events-sub-module.h:16,
                 from tests/include/test-qapi-events-sub-module.c:15:
tests/include/../test-qapi-types-sub-sub-module.h:16:10: fatal error: qapi/qapi-builtin-types.h: No such file or directory
 #include "qapi/qapi-builtin-types.h"
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make: *** [Makefile.ninja:1769: tests/libtestqapi.a.p/meson-generated_.._test-qapi-types-sub-sub-module.c.o] Error 1
In file included from tests/test-qapi-events-sub-sub-module.h:17:0,
                 from tests/test-qapi-events-sub-sub-module.c:15:
tests/test-qapi-types-sub-sub-module.h:16:10: fatal error: qapi/qapi-builtin-types.h: No such file or directory
 #include "qapi/qapi-builtin-types.h"
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make: *** [Makefile.ninja:1774: tests/libtestqapi.a.p/meson-generated_.._include_test-qapi-events-sub-module.c.o] Error 1
make: *** [Makefile.ninja:1763: tests/libtestqapi.a.p/meson-generated_.._test-qapi-commands.c.o] Error 1
make: *** [Makefile.ninja:1765: tests/libtestqapi.a.p/meson-generated_.._test-qapi-events-sub-sub-module.c.o] Error 1
In file included from tests/test-qapi-visit.c:14:0:
/dev/shm/cfontana/qemu/include/qapi/error.h:275:10: fatal error: qapi/qapi-types-error.h: No such file or directory
 #include "qapi/qapi-types-error.h"
          ^~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
In file included from tests/test-qapi-commands-sub-sub-module.c:14:0:
/dev/shm/cfontana/qemu/include/qapi/visitor.h:18:10: fatal error: qapi/qapi-builtin-types.h: No such file or directory
 #include "qapi/qapi-builtin-types.h"
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
In file included from tests/include/../test-qapi-events-sub-sub-module.h:17:0,
                 from tests/include/test-qapi-events-sub-module.h:16,
                 from tests/include/test-qapi-events-sub-module.c:15:
tests/include/../test-qapi-types-sub-sub-module.h:16:10: fatal error: qapi/qapi-builtin-types.h: No such file or directory
 #include "qapi/qapi-builtin-types.h"
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make: *** [Makefile.ninja:1769: tests/libtestqapi.a.p/meson-generated_.._test-qapi-types-sub-sub-module.c.o] Error 1
In file included from tests/test-qapi-events-sub-sub-module.h:17:0,
                 from tests/test-qapi-events-sub-sub-module.c:15:
tests/test-qapi-types-sub-sub-module.h:16:10: fatal error: qapi/qapi-builtin-types.h: No such file or directory
 #include "qapi/qapi-builtin-types.h"
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make: *** [Makefile.ninja:1774: tests/libtestqapi.a.p/meson-generated_.._include_test-qapi-events-sub-module.c.o] Error 1
make: *** [Makefile.ninja:1763: tests/libtestqapi.a.p/meson-generated_.._test-qapi-commands.c.o] Error 1
make: *** [Makefile.ninja:1765: tests/libtestqapi.a.p/meson-generated_.._test-qapi-events-sub-sub-module.c.o] Error 1
In file included from tests/test-qapi-visit.c:14:0:
/dev/shm/cfontana/qemu/include/qapi/error.h:275:10: fatal error: qapi/qapi-types-error.h: No such file or directory
 #include "qapi/qapi-types-error.h"
          ^~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
In file included from tests/test-qapi-commands-sub-sub-module.c:14:0:
/dev/shm/cfontana/qemu/include/qapi/visitor.h:18:10: fatal error: qapi/qapi-builtin-types.h: No such file or directory
 #include "qapi/qapi-builtin-types.h"
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
In file included from tests/include/../test-qapi-events-sub-sub-module.h:17:0,
                 from tests/include/test-qapi-events-sub-module.h:16,
                 from tests/include/test-qapi-events-sub-module.c:15:
tests/include/../test-qapi-types-sub-sub-module.h:16:10: fatal error: qapi/qapi-builtin-types.h: No such file or directory
 #include "qapi/qapi-builtin-types.h"
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make: *** [Makefile.ninja:1769: tests/libtestqapi.a.p/meson-generated_.._test-qapi-types-sub-sub-module.c.o] Error 1
In file included from tests/test-qapi-events-sub-sub-module.h:17:0,
                 from tests/test-qapi-events-sub-sub-module.c:15:
tests/test-qapi-types-sub-sub-module.h:16:10: fatal error: qapi/qapi-builtin-types.h: No such file or directory
 #include "qapi/qapi-builtin-types.h"
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make: *** [Makefile.ninja:1774: tests/libtestqapi.a.p/meson-generated_.._include_test-qapi-events-sub-module.c.o] Error 1
make: *** [Makefile.ninja:1763: tests/libtestqapi.a.p/meson-generated_.._test-qapi-commands.c.o] Error 1
make: *** [Makefile.ninja:1765: tests/libtestqapi.a.p/meson-generated_.._test-qapi-events-sub-sub-module.c.o] Error 1
In file included from tests/test-qapi-visit.c:14:0:
/dev/shm/cfontana/qemu/include/qapi/error.h:275:10: fatal error: qapi/qapi-types-error.h: No such file or directory
 #include "qapi/qapi-types-error.h"
          ^~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
In file included from tests/test-qapi-commands-sub-sub-module.c:14:0:
/dev/shm/cfontana/qemu/include/qapi/visitor.h:18:10: fatal error: qapi/qapi-builtin-types.h: No such file or directory
 #include "qapi/qapi-builtin-types.h"
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
In file included from tests/include/../test-qapi-commands-sub-sub-module.h:16:0,
                 from tests/include/test-qapi-commands-sub-module.h:16,
                 from tests/test-qapi-commands.h:16,
                 from tests/test-qapi-init-commands.c:14:
tests/include/../test-qapi-types-sub-sub-module.h:16:10: fatal error: qapi/qapi-builtin-types.h: No such file or directory
 #include "qapi/qapi-builtin-types.h"
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make: *** [Makefile.ninja:1772: tests/libtestqapi.a.p/meson-generated_.._test-qapi-visit.c.o] Error 1
make: *** [Makefile.ninja:1762: tests/libtestqapi.a.p/meson-generated_.._test-qapi-commands-sub-sub-module.c.o] Error 1
make: *** [Makefile.ninja:1767: tests/libtestqapi.a.p/meson-generated_.._test-qapi-init-commands.c.o] Error 1
warning: execution failed: build.sh
You can fix the problem, and then run

  git rebase --continue



