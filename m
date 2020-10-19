Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4735DC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 15:35:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8528322260
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 15:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hogYpWRb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8528322260
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUXBx-00053J-D7
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 11:35:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46580)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1kUXA8-0003dN-9V
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 11:33:29 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:37747)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1kUXA3-0005Rs-L0
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 11:33:28 -0400
Received: by mail-wm1-x32e.google.com with SMTP id j136so284246wmj.2
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 08:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=cSlr53k3shFzEb74i9qjedJpHY3aZ5jVJz916khuRCI=;
 b=hogYpWRb+56kn6JzbfrWaoaXhYtNxL/06XenSpJSk0kIuBWLND17orxV+PsVSNaV3D
 MBS0DjMklZ0s4dkeaIt8hC9lOKL23xFnb4RLWeO22x9Kt2SXy8QdqdRD5z/CM14wjDqp
 5Ayqz1q31Zj0COdSd2X9NdLgzNJi3BXWXOg8iEbwUL5FEFYp2ZVx6h+myq48mKka2rgT
 ItWNotOt3Vpd5TrENbVablJW9OETdfoJSCw/Y7dIIADqB6w2K2yOWHV3rAVpNOKBFxEr
 rTs7ixLWVxFPpCut/I+Xh5zt63r27SJeSzoGtRCThuq306F47c67PKJDh8LKEznFGwEA
 W17A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=cSlr53k3shFzEb74i9qjedJpHY3aZ5jVJz916khuRCI=;
 b=JnHiNG6akDiinUoQTxvjb8m5CvTV9oGsmej642ioBRSQC7nbdt1FuqnOCfMtBbqsRy
 QfNwgLWVSEIoTV2fhV/0ZTC9jDqHcLJsd1hrL12z+MW3cQpk9JiUpo8aLFpYU86LsNZX
 NxjRZltZ6IhrWdfQaDmPIZz5D6649IJs9B+ksf8+MgGIwzyFTaJqfiOwXOeDzF7nHIZ6
 9C8ZSdqDB8vSwtEJyVzDXfF3hFm1O25UrJ66+PhvV06hGm0h5mPopj+HpLrYvvephl5d
 AiEpQ7j0TXbkcSDfFz/U1Wv4mZTwUgzcTsGoorp5eb/X+q/oKGWl0fZ4jEPv7selY0Rl
 VWhg==
X-Gm-Message-State: AOAM533kZ+Yy4GpVBIxXrmF0qgjGWnnvUrIaRQ35OBG/J9MOjdwM4Zu8
 CzLGzzNg5jEaDR6J9RablPoxSu0woddDxQ==
X-Google-Smtp-Source: ABdhPJxfQGu9U8oZmT3vABext91HaBIaPY0wcAm4xnFCUEfnBxb7J3x4LK9hNJchnnnSTeX7ZB7+bg==
X-Received: by 2002:a1c:67c5:: with SMTP id b188mr95383wmc.164.1603121600631; 
 Mon, 19 Oct 2020 08:33:20 -0700 (PDT)
Received: from [192.168.2.1] (net.iroazh.eu. [109.190.73.171])
 by smtp.gmail.com with ESMTPSA id 4sm91058wrp.58.2020.10.19.08.33.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 19 Oct 2020 08:33:19 -0700 (PDT)
From: "Emmanuel Blot" <eblot.ml@gmail.com>
To: QEMU <qemu-devel@nongnu.org>
Subject: ld: file not found: _PreallocMode_lookup on macOS Catalina
Date: Mon, 19 Oct 2020 17:33:18 +0200
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <24B952F3-465C-4AB2-AF28-6CA4722D94B7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=eblot.ml@gmail.com; helo=mail-wm1-x32e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

I=E2=80=99m using the current master (ba2a9a9e)
I tried to build with both =E2=80=98ninja=E2=80=99 and also with =E2=80=98=
make=E2=80=99, as =

I=E2=80=99m not sure of the current status of the meson refactoring.

The build fails with a weird error message:

ld: file not found: _PreallocMode_lookup

PreallocMode_lookup should be a symbol, shouldn=E2=80=99t it?
Why is ld trying to load of file with this name?

Build log:

eblot@thurso ~/S/G/g/Q/fdt (master)> uname -a
Darwin thurso.iroazh.eu 19.6.0 Darwin Kernel Version 19.6.0: Mon Aug 31 =

22:12:52 PDT 2020; root:xnu-6153.141.2~1/RELEASE_X86_64 x86_64

eblot@thurso ~/S/G/g/Q/fdt (master)> git log -1
commit ba2a9a9e6318bfd93a2306dec40137e198205b86 (HEAD -> master, =

origin/master, origin/HEAD)
Merge: 22d30b340a bb997e5c96
Author: Peter Maydell <peter.maydell@linaro.org>
Date:   Mon Oct 19 11:46:03 2020 +0100

     Merge remote-tracking branch =

'remotes/mcayland/tags/qemu-macppc-20201019' into staging

     qemu-macppc updates

     # gpg: Signature made Mon 19 Oct 2020 08:13:16 BST
     # gpg:                using RSA key =

CC621AB98E82200D915CC9C45BC2C56FAE0F321F
     # gpg:                issuer "mark.cave-ayland@ilande.co.uk"
     # gpg: Good signature from "Mark Cave-Ayland =

<mark.cave-ayland@ilande.co.uk>" [full]
     # Primary key fingerprint: CC62 1AB9 8E82 200D 915C  C9C4 5BC2 C56F =

AE0F 321F

     * remotes/mcayland/tags/qemu-macppc-20201019:
       mac_oldworld: Change PCI address of macio to match real hardware
       mac_oldworld: Drop some variables
       mac_oldworld: Drop a variable, use get_system_memory() directly
       mac_newworld: Allow loading binary ROM image
       mac_oldworld: Allow loading binary ROM image
       m48t59: remove legacy m48t59_init() function
       ppc405_boards: use qdev properties instead of legacy =

m48t59_init() function
       sun4u: use qdev properties instead of legacy m48t59_init() =

function
       sun4m: use qdev properties instead of legacy m48t59_init() =

function
       m48t59-isa: remove legacy m48t59_init_isa() function
       uninorth: use qdev gpios for PCI IRQs
       grackle: use qdev gpios for PCI IRQs
       macio: don't reference serial_hd() directly within the device

     Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

eblot@thurso ~/S/G/g/Q/fdt (master)> git st
On branch master
nothing to commit, working tree clean

eblot@thurso ~/S/G/g/Q/fdt (master)> mkdir build && cd build

eblot@thurso ~/S/G/g/Q/f/build (master)> ls

eblot@thurso ~/S/G/g/Q/f/build (master)> ../configure =

--target-list=3Driscv32-softmmu,riscv64-softmmu --disable-slirp =

--enable-debug --enable-modules
Disabling PIE due to missing toolchain support
cross containers  docker
The Meson build system
Version: 0.55.3
Source dir: /Users/eblot/Sources/Git/github.com/QEMU/fdt
Build dir: /Users/eblot/Sources/Git/github.com/QEMU/fdt/build
Build type: native build
Project name: qemu
Project version: 5.1.50
C compiler for the host machine: cc (clang 12.0.0 "Apple clang version =

12.0.0 (clang-1200.0.32.2)")
C linker for the host machine: cc ld64 609
Host machine cpu family: x86_64
Host machine cpu: x86_64
=2E./meson.build:10: WARNING: Module unstable-keyval has no backwards or =

forwards compatibility and might not exist in future releases.
Program sh found: YES
Program python3 found: YES =

(/Applications/Xcode.app/Contents/Developer/usr/bin/python3)
C++ compiler for the host machine: c++ (clang 12.0.0 "Apple clang =

version 12.0.0 (clang-1200.0.32.2)")
C++ linker for the host machine: c++ ld64 609
Objective-C compiler for the host machine: cc (clang 12.0.0)
Objective-C linker for the host machine: cc ld64 609
Program cgcc found: NO
Library m found: YES
Library util found: YES
Run-time dependency appleframeworks found: YES (CoreFoundation)
Run-time dependency appleframeworks found: YES (IOKit)
Run-time dependency appleframeworks found: YES (Cocoa)
Run-time dependency appleframeworks found: YES (Hypervisor)
Found pkg-config: /usr/local/bin/pkg-config (0.29.2)
Run-time dependency pixman-1 found: YES 0.40.0
Library pam found: YES
Library aio found: NO
Run-time dependency zlib found: YES 1.2.11
Run-time dependency xkbcommon found: NO (tried pkgconfig)
Library rt found: NO
Library iconv found: NO
=2E./meson.build:531: WARNING: iconv required for curses UI but not =

available, disabling
Dependency sdl2 skipped: feature sdl disabled
Run-time dependency libpng found: YES 1.6.37
Has header "jpeglib.h" : YES
Library jpeg found: NO
Has header "sasl/sasl.h" : YES
Library sasl2 found: NO
Run-time dependency u2f-emu found: NO (tried pkgconfig)
Run-time dependency libkeyutils found: NO (tried pkgconfig)
Checking for function "gettid" : NO
Program scripts/minikconf.py found: YES
Configuring riscv32-softmmu-config-target.h using configuration
Configuring riscv32-softmmu-config-devices.mak with command
Reading depfile: =

/Users/eblot/Sources/Git/github.com/QEMU/fdt/build/meson-private/riscv32-=
softmmu-config-devices.mak.d
Configuring riscv32-softmmu-config-devices.h using configuration
Configuring riscv64-softmmu-config-target.h using configuration
Configuring riscv64-softmmu-config-devices.mak with command
Reading depfile: =

/Users/eblot/Sources/Git/github.com/QEMU/fdt/build/meson-private/riscv64-=
softmmu-config-devices.mak.d
Configuring riscv64-softmmu-config-devices.h using configuration
Run-time dependency capstone found: NO (tried pkgconfig)
Configuring capstone-defs.h using configuration
Library fdt found: NO
Configuring config-host.h using configuration
Program scripts/hxtool found: YES
Program scripts/shaderinclude.pl found: YES
Program scripts/qapi-gen.py found: YES
Program scripts/qemu-version.sh found: YES
Run-time dependency threads found: YES
Program keycodemapdb/tools/keymap-gen found: YES
Program scripts/decodetree.py found: YES
Program ../scripts/modules/module_block.py found: YES
Program ../scripts/block-coroutine-wrapper.py found: YES
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
Program qemu-keymap found: NO
Program sphinx-build-3 sphinx-build found: NO
Program python3 found: YES =

(/Applications/Xcode.app/Contents/Developer/usr/bin/python3)
Program diff found: YES
Program dbus-daemon found: NO
Program initrd-stress.sh found: YES
Build targets in project: 374

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
             Build directory: =

/Users/eblot/Sources/Git/github.com/QEMU/fdt/build
                 Source path: =

/Users/eblot/Sources/Git/github.com/QEMU/fdt
                  GIT binary: git
              GIT submodules: ui/keycodemapdb =

tests/fp/berkeley-testfloat-3 tests/fp/berkeley-softfloat-3 meson dtc =

capstone
                  C compiler: cc
             Host C compiler: cc
                C++ compiler: c++
        Objective-C compiler: cc
                     ARFLAGS: rv
                      CFLAGS: -O0 -g
                    CXXFLAGS: -O0 -g
                 QEMU_CFLAGS: -m64 -mcx16 -DOS_OBJECT_USE_OBJC=3D0 -arch =

x86_64 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE =

-Wstrict-prototypes -Wredundant-decls -Wundef -Wwrite-strings =

-Wmissing-prototypes -fno-strict-aliasing -fno-common -fwrapv  =

-Wold-style-definition -Wtype-limits -Wformat-security -Wformat-y2k =

-Winit-self -Wignored-qualifiers -Wempty-body -Wnested-externs =

-Wendif-labels -Wexpansion-to-defined -Wno-initializer-overrides =

-Wno-missing-include-dirs -Wno-shift-negative-value -Wno-string-plus-int =

-Wno-typedef-redefinition -Wno-tautological-type-limit-compare =

-fstack-protector-strong
                QEMU_LDFLAGS: -m64 -framework CoreFoundation -framework =

IOKit -arch x86_64  -fstack-protector-strong
                        make: make
                      python: =

/Applications/Xcode.app/Contents/Developer/usr/bin/python3 (version: =

3.8)
                sphinx-build: NO
                 genisoimage:
               slirp support: NO
              module support: YES
     alternative module path: NO
                    host CPU: x86_64
             host endianness: little
                 target list: riscv32-softmmu riscv64-softmmu
               gprof enabled: NO
              sparse enabled: NO
              strip binaries: NO
                    profiler: NO
                static build: NO
               Cocoa support: NO
                 SDL support: NO
           SDL image support: NO
                 GTK support: NO
              GTK GL support: NO
                      pixman: YES
                 VTE support: NO
                TLS priority: "NORMAL"
              GNUTLS support: YES
                   libgcrypt: NO
                      nettle: YES
                         XTS: YES
                    libtasn1: YES
                         PAM: YES
               iconv support: NO
              curses support: NO
               virgl support: NO
                curl support: YES
             mingw32 support: NO
               Audio drivers: coreaudio sdl
        Block whitelist (rw):
        Block whitelist (ro):
              VirtFS support: NO
           Multipath support: NO
                 VNC support: YES
            VNC SASL support: NO
            VNC JPEG support: NO
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
                 KVM support: NO
                 HAX support: NO
                 HVF support: NO
                WHPX support: NO
                 TCG support: YES
           TCG debug enabled: YES
             TCG interpreter: NO
         malloc trim support: NO
                RDMA support: NO
              PVRDMA support: NO
                 fdt support: internal
                  membarrier: NO
              preadv support: NO
                   fdatasync: NO
                     madvise: YES
               posix_madvise: YES
              posix_memalign: YES
           libcap-ng support: NO
           vhost-net support: YES
        vhost-crypto support: YES
          vhost-scsi support: NO
         vhost-vsock support: NO
          vhost-user support: NO
       vhost-user-fs support: YES
          vhost-vdpa support: NO
              Trace backends: log
               spice support: NO
                 rbd support: NO
              xfsctl support: NO
           smartcard support: NO
                 U2F support: NO
                      libusb: YES
               usb net redir: NO
              OpenGL support: NO
              OpenGL dmabufs: NO
            libiscsi support: NO
              libnfs support: NO
           build guest agent: YES
             seccomp support: NO
           coroutine backend: sigaltstack
              coroutine pool: YES
           debug stack usage: NO
             mutex debugging: YES
                crypto afalg: NO
           GlusterFS support: NO
                        gcov: NO
                 TPM support: YES
              libssh support: YES
               QOM debugging: YES
        Live block migration: YES
                 lzo support: YES
              snappy support: YES
               bzip2 support: YES
               lzfse support: NO
                zstd support: NO
           NUMA host support: NO
                     libxml2: YES
            memory allocator: system
           avx2 optimization: NO
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
            sheepdog support: NO
                    capstone: internal
             libpmem support: NO
           libdaxctl support: NO
                     libudev: NO
             default devices: YES
              plugin support: NO
             fuzzing support: NO
            thread sanitizer: NO
                    rng-none: NO
               Linux keyring: NO

Found ninja-1.10.1 at /usr/local/bin/ninja
eblot@thurso ~/S/G/g/Q/f/build (master)> ninja
[937/2125] Linking static target libhw-display-virtio-gpu.a
/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctool=
chain/usr/bin/ranlib: =

file: libhw-display-virtio-gpu.a(hw_display_virtio-gpu-3d.c.o) has no =

symbols
[993/2125] Linking static target libchardev.fa
/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctool=
chain/usr/bin/ranlib: =

file: libchardev.fa(chardev_char-parallel.c.o) has no symbols
[1978/2125] Linking static target libqemuutil.a
/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctool=
chain/usr/bin/ranlib: =

file: libqemuutil.a(util_stats64.c.o) has no symbols
[2015/2125] Generating block.syms with a meson_exe.py custom command
no symbols
[2017/2125] Generating qemu.syms with a meson_exe.py custom command
no symbols
no symbols
[2027/2125] Linking target qemu-system-riscv32
FAILED: qemu-system-riscv32
c++  -o qemu-system-riscv32 qemu-system-riscv32.p/softmmu_main.c.o =

libcommon.fa.p/hw_net_rocker_rocker_fp.c.o =

libcommon.fa.p/hw_core_cpu.c.o libcommon.fa.p/audio_audio_legacy.c.o =

libcommon.fa.p/hw_pci-bridge_pci_bridge_dev.c.o =

libcommon.fa.p/hw_sd_sdmmc-internal.c.o =

libcommon.fa.p/block_monitor_block-hmp-cmds.c.o =

libcommon.fa.p/backends_vhost-user.c.o =

libcommon.fa.p/monitor_qmp-cmds.c.o libcommon.fa.p/hw_ide_qdev.c.o =

libcommon.fa.p/backends_hostmem-file.c.o =

libcommon.fa.p/hw_char_virtio-console.c.o libcommon.fa.p/blockdev.c.o =

libcommon.fa.p/backends_rng-builtin.c.o =

libcommon.fa.p/hw_audio_soundhw.c.o libcommon.fa.p/hw_block_cdrom.c.o =

libcommon.fa.p/hw_core_machine.c.o libcommon.fa.p/hw_display_vga-pci.c.o =

libcommon.fa.p/hw_core_sysbus.c.o =

libcommon.fa.p/hw_smbios_smbios-stub.c.o =

libcommon.fa.p/hw_usb_hcd-ehci.c.o libcommon.fa.p/hw_usb_dev-serial.c.o =

libcommon.fa.p/net_dump.c.o libcommon.fa.p/accel_accel.c.o =

libcommon.fa.p/hw_char_serial-pci.c.o libcommon.fa.p/ui_vnc-palette.c.o =

libcommon.fa.p/os-posix.c.o libcommon.fa.p/replay_replay-debugging.c.o =

libcommon.fa.p/hw_usb_hcd-xhci.c.o libcommon.fa.p/net_queue.c.o =

libcommon.fa.p/chardev_wctablet.c.o libcommon.fa.p/hw_scsi_scsi-disk.c.o =

libcommon.fa.p/hw_pci_slotid_cap.c.o =

libcommon.fa.p/hw_net_e1000e_core.c.o libcommon.fa.p/disas_riscv.c.o =

libcommon.fa.p/hw_net_cadence_gem.c.o =

libcommon.fa.p/hw_char_ipoctal232.c.o libcommon.fa.p/hw_pci_pci.c.o =

libcommon.fa.p/audio_coreaudio.c.o =

libcommon.fa.p/hw_pci-bridge_pcie_root_port.c.o =

libcommon.fa.p/ui_vnc-enc-hextile.c.o libcommon.fa.p/ui_console.c.o =

libcommon.fa.p/ui_vnc-enc-tight.c.o libcommon.fa.p/hw_ide_core.c.o =

libcommon.fa.p/ui_input-keymap.c.o libcommon.fa.p/migration_xbzrle.c.o =

libcommon.fa.p/hw_misc_sifive_test.c.o =

libcommon.fa.p/hw_rtc_goldfish_rtc.c.o =

libcommon.fa.p/hw_usb_dev-smartcard-reader.c.o =

libcommon.fa.p/backends_cryptodev.c.o =

libcommon.fa.p/hw_usb_combined-packet.c.o libcommon.fa.p/net_socket.c.o =

libcommon.fa.p/hw_core_qdev-fw.c.o =

libcommon.fa.p/hw_net_rocker_rocker_desc.c.o =

libcommon.fa.p/migration_savevm.c.o =

libcommon.fa.p/hw_input_virtio-input-hid.c.o =

libcommon.fa.p/hw_scsi_scsi-bus.c.o =

libcommon.fa.p/hw_usb_hcd-ehci-pci.c.o =

libcommon.fa.p/chardev_testdev.c.o =

libcommon.fa.p/softmmu_qdev-monitor.c.o libcommon.fa.p/disas_i386.c.o =

libcommon.fa.p/net_eth.c.o libcommon.fa.p/hw_ide_ich.c.o =

libcommon.fa.p/hw_audio_hda-codec.c.o libcommon.fa.p/hw_misc_edu.c.o =

libcommon.fa.p/hw_pci_pci_host.c.o libcommon.fa.p/net_colo-compare.c.o =

libcommon.fa.p/hw_input_virtio-input.c.o =

libcommon.fa.p/migration_migration.c.o =

libcommon.fa.p/monitor_hmp-cmds.c.o libcommon.fa.p/hw_pci-host_gpex.c.o =

libcommon.fa.p/migration_vmstate-types.c.o =

libcommon.fa.p/hw_scsi_mptsas.c.o =

libcommon.fa.p/hw_misc_sifive_u_prci.c.o =

libcommon.fa.p/hw_char_cadence_uart.c.o libcommon.fa.p/net_tap.c.o =

libcommon.fa.p/hw_usb_core.c.o libcommon.fa.p/hw_cpu_core.c.o =

libcommon.fa.p/hw_usb_dev-uas.c.o libcommon.fa.p/net_announce.c.o =

libcommon.fa.p/ui_input-legacy.c.o =

libcommon.fa.p/backends_cryptodev-builtin.c.o =

libcommon.fa.p/hw_core_machine-hmp-cmds.c.o =

libcommon.fa.p/hw_nvram_eeprom93xx.c.o libcommon.fa.p/hw_net_ne2000.c.o =

libcommon.fa.p/hw_misc_unimp.c.o libcommon.fa.p/migration_page_cache.c.o =

libcommon.fa.p/migration_global_state.c.o =

libcommon.fa.p/hw_net_can_can_sja1000.c.o =

libcommon.fa.p/hw_pci_pcie_host.c.o =

libcommon.fa.p/hw_pci-bridge_gen_pcie_root_port.c.o =

libcommon.fa.p/hw_scsi_lsi53c895a.c.o libcommon.fa.p/migration_fd.c.o =

libcommon.fa.p/backends_dbus-vmstate.c.o =

libcommon.fa.p/hw_net_can_can_mioe3680_pci.c.o =

libcommon.fa.p/hw_net_can_can_pcm3680_pci.c.o =

libcommon.fa.p/qom_qom-hmp-cmds.c.o libcommon.fa.p/hw_pci_pci_bridge.c.o =

libcommon.fa.p/hw_usb_hcd-xhci-nec.c.o =

libcommon.fa.p/hw_usb_imx-usb-phy.c.o =

libcommon.fa.p/hw_net_net_tx_pkt.c.o =

libcommon.fa.p/hw_usb_hcd-xhci-pci.c.o =

libcommon.fa.p/backends_hostmem.c.o libcommon.fa.p/hw_pci_shpc.c.o =

libcommon.fa.p/ui_kbd-state.c.o =

libcommon.fa.p/hw_display_virtio-gpu-pci.c.o =

libcommon.fa.p/backends_cryptodev-vhost.c.o =

libcommon.fa.p/ui_vnc-jobs.c.o libcommon.fa.p/net_hub.c.o =

libcommon.fa.p/backends_tpm_tpm_backend.c.o =

libcommon.fa.p/net_vhost-user.c.o libcommon.fa.p/replay_replay-audio.c.o =

libcommon.fa.p/hw_net_pcnet.c.o libcommon.fa.p/hw_scsi_esp-pci.c.o =

libcommon.fa.p/hw_scsi_vmw_pvscsi.c.o libcommon.fa.p/hw_sd_sdhci.c.o =

libcommon.fa.p/softmmu_device_tree.c.o libcommon.fa.p/hw_usb_dev-hub.c.o =

libcommon.fa.p/chardev_msmouse.c.o libcommon.fa.p/hw_usb_dev-audio.c.o =

libcommon.fa.p/audio_noaudio.c.o libcommon.fa.p/hw_i2c_core.c.o =

libcommon.fa.p/migration_qemu-file.c.o =

libcommon.fa.p/hw_display_cirrus_vga.c.o =

libcommon.fa.p/hw_usb_dev-storage.c.o =

libcommon.fa.p/ui_input-barrier.c.o libcommon.fa.p/ui_cocoa.m.o =

libcommon.fa.p/softmmu_tpm.c.o libcommon.fa.p/net_filter-mirror.c.o =

libcommon.fa.p/hw_block_hd-geometry.c.o =

libcommon.fa.p/net_filter-buffer.c.o libcommon.fa.p/audio_audio.c.o =

libcommon.fa.p/hw_dma_sifive_pdma.c.o =

libcommon.fa.p/hw_display_bochs-display.c.o =

libcommon.fa.p/hw_usb_bus.c.o =

libcommon.fa.p/backends_cryptodev-vhost-user.c.o =

libcommon.fa.p/hw_scsi_megasas.c.o =

libcommon.fa.p/hw_usb_hcd-xhci-sysbus.c.o =

libcommon.fa.p/hw_pci-bridge_xio3130_upstream.c.o =

libcommon.fa.p/audio_mixeng.c.o libcommon.fa.p/migration_multifd.c.o =

libcommon.fa.p/hw_char_serial-pci-multi.c.o =

libcommon.fa.p/hw_core_clock-vmstate.c.o =

libcommon.fa.p/hw_sd_sdhci-pci.c.o libcommon.fa.p/replay_replay-time.c.o =

libcommon.fa.p/migration_tls.c.o libcommon.fa.p/net_can_can_core.c.o =

libcommon.fa.p/monitor_hmp.c.o libcommon.fa.p/hw_audio_ac97.c.o =

libcommon.fa.p/hw_block_block.c.o libcommon.fa.p/hw_net_tulip.c.o =

libcommon.fa.p/ui_qemu-pixman.c.o =

libcommon.fa.p/hw_pci-bridge_xio3130_downstream.c.o =

libcommon.fa.p/softmmu_dma-helpers.c.o =

libcommon.fa.p/migration_postcopy-ram.c.o =

libcommon.fa.p/hw_pci-bridge_pcie_pci_bridge.c.o =

libcommon.fa.p/migration_channel.c.o libcommon.fa.p/audio_wavaudio.c.o =

libcommon.fa.p/replay_replay-net.c.o =

libcommon.fa.p/hw_net_rocker_rocker.c.o =

libcommon.fa.p/hw_display_ati.c.o =

libcommon.fa.p/replay_replay-events.c.o libcommon.fa.p/hw_input_hid.c.o =

libcommon.fa.p/hw_pcmcia_pcmcia.c.o libcommon.fa.p/hw_display_ati_2d.c.o =

libcommon.fa.p/hw_scsi_mptendian.c.o =

libcommon.fa.p/hw_scsi_mptconfig.c.o =

libcommon.fa.p/hw_usb_host-libusb.c.o =

libcommon.fa.p/hw_net_vhost_net.c.o =

libcommon.fa.p/hw_core_null-machine.c.o =

libcommon.fa.p/backends_rng-egd.c.o =

libcommon.fa.p/hw_audio_intel-hda.c.o libcommon.fa.p/hw_cpu_cluster.c.o =

libcommon.fa.p/hw_ipack_ipack.c.o libcommon.fa.p/ui_vnc-enc-zrle.c.o =

libcommon.fa.p/hw_misc_sifive_u_otp.c.o =

libcommon.fa.p/hw_net_rocker_rocker_of_dpa.c.o =

libcommon.fa.p/hw_i2c_bitbang_i2c.c.o =

libcommon.fa.p/replay_replay-internal.c.o =

libcommon.fa.p/hw_net_net_rx_pkt.c.o =

libcommon.fa.p/hw_virtio_virtio-mmio.c.o =

libcommon.fa.p/hw_core_qdev-properties-system.c.o =

libcommon.fa.p/disas_capstone.c.o libcommon.fa.p/hw_char_sifive_uart.c.o =

libcommon.fa.p/hw_scsi_scsi-generic.c.o =

libcommon.fa.p/replay_replay-snapshot.c.o =

libcommon.fa.p/hw_net_e1000x_common.c.o libcommon.fa.p/hw_net_e1000e.c.o =

libcommon.fa.p/net_filter.c.o =

libcommon.fa.p/hw_watchdog_wdt_i6300esb.c.o =

libcommon.fa.p/hw_intc_intc.c.o libcommon.fa.p/hw_acpi_acpi-stub.c.o =

libcommon.fa.p/hw_usb_u2f.c.o libcommon.fa.p/migration_qjson.c.o =

libcommon.fa.p/hw_gpio_sifive_gpio.c.o libcommon.fa.p/hw_net_e1000.c.o =

libcommon.fa.p/hw_misc_sifive_e_prci.c.o =

libcommon.fa.p/hw_net_ne2000-pci.c.o =

libcommon.fa.p/hw_usb_hcd-ohci-pci.c.o =

libcommon.fa.p/hw_usb_dev-network.c.o =

libcommon.fa.p/hw_net_can_can_kvaser_pci.c.o =

libcommon.fa.p/migration_block.c.o =

libcommon.fa.p/backends_hostmem-ram.c.o libcommon.fa.p/job-qmp.c.o =

libcommon.fa.p/hw_acpi_aml-build-stub.c.o =

libcommon.fa.p/hw_ide_atapi.c.o libcommon.fa.p/replay_replay-input.c.o =

libcommon.fa.p/hw_net_can_ctucan_core.c.o =

libcommon.fa.p/hw_usb_dev-hid.c.o libcommon.fa.p/dump_dump-hmp-cmds.c.o =

libcommon.fa.p/migration_vmstate.c.o libcommon.fa.p/net_can_can_host.c.o =

libcommon.fa.p/softmmu_bootdevice.c.o =

libcommon.fa.p/hw_display_edid-generate.c.o =

libcommon.fa.p/migration_colo.c.o libcommon.fa.p/hw_ide_ahci.c.o =

libcommon.fa.p/hw_core_vm-change-state-handler.c.o =

libcommon.fa.p/chardev_chardev-sysemu.c.o =

libcommon.fa.p/ui_vnc-enc-zlib.c.o =

libcommon.fa.p/migration_colo-failover.c.o =

libcommon.fa.p/migration_socket.c.o =

libcommon.fa.p/net_filter-rewriter.c.o libcommon.fa.p/ui_vnc.c.o =

libcommon.fa.p/hw_core_loader.c.o libcommon.fa.p/net_tap-bsd.c.o =

libcommon.fa.p/ui_input.c.o libcommon.fa.p/hw_virtio_virtio-bus.c.o =

libcommon.fa.p/migration_exec.c.o =

libcommon.fa.p/hw_timer_cadence_ttc.c.o =

libcommon.fa.p/hw_usb_hcd-uhci.c.o =

libcommon.fa.p/hw_virtio_virtio-pci.c.o =

libcommon.fa.p/replay_replay-char.c.o libcommon.fa.p/hw_pci_msi.c.o =

libcommon.fa.p/hw_char_serial.c.o libcommon.fa.p/backends_rng.c.o =

libcommon.fa.p/hw_block_pflash_cfi01.c.o =

libcommon.fa.p/hw_nvram_fw_cfg.c.o libcommon.fa.p/hw_pci_pcie_aer.c.o =

libcommon.fa.p/hw_pci-bridge_ioh3420.c.o =

libcommon.fa.p/ui_vnc-auth-vencrypt.c.o =

libcommon.fa.p/net_filter-replay.c.o libcommon.fa.p/hw_usb_dev-mtp.c.o =

libcommon.fa.p/hw_ipack_tpci200.c.o libcommon.fa.p/net_checksum.c.o =

libcommon.fa.p/iothread.c.o libcommon.fa.p/hw_scsi_emulation.c.o =

libcommon.fa.p/hw_watchdog_watchdog.c.o libcommon.fa.p/ui_vnc-ws.c.o =

libcommon.fa.p/hw_display_ati_dbg.c.o =

libcommon.fa.p/migration_multifd-zlib.c.o =

libcommon.fa.p/hw_misc_pci-testdev.c.o libcommon.fa.p/hw_pci_msix.c.o =

libcommon.fa.p/hw_pci_pcie.c.o libcommon.fa.p/hw_usb_dev-wacom.c.o =

libcommon.fa.p/net_net.c.o libcommon.fa.p/hw_sd_sd.c.o =

libcommon.fa.p/hw_net_eepro100.c.o libcommon.fa.p/ui_cursor.c.o =

libcommon.fa.p/hw_display_vmware_vga.c.o =

libcommon.fa.p/block_qapi-sysemu.c.o =

libcommon.fa.p/replay_replay-random.c.o libcommon.fa.p/net_colo.c.o =

libcommon.fa.p/replay_replay.c.o libcommon.fa.p/audio_wavcapture.c.o =

libcommon.fa.p/ui_keymaps.c.o libcommon.fa.p/hw_sd_core.c.o =

libcommon.fa.p/hw_core_nmi.c.o =

libcommon.fa.p/hw_display_vhost-user-gpu-pci.c.o =

libcommon.fa.p/hw_net_vmxnet3.c.o =

libcommon.fa.p/hw_net_rocker_rocker_world.c.o =

libcommon.fa.p/migration_qemu-file-channel.c.o =

libcommon.fa.p/hw_audio_es1370.c.o libcommon.fa.p/hw_pci_pcie_port.c.o =

libcommon.fa.p/hw_usb_desc.c.o libcommon.fa.p/hw_display_edid-region.c.o =

libcommon.fa.p/net_util.c.o libcommon.fa.p/hw_pci-bridge_i82801b11.c.o =

libcommon.fa.p/hw_scsi_esp.c.o =

libcommon.fa.p/hw_input_vhost-user-input.c.o =

libcommon.fa.p/hw_block_nvme.c.o libcommon.fa.p/hw_usb_hcd-ohci.c.o =

libcommon.fa.p/hw_usb_libhw.c.o libcommon.fa.p/hw_usb_desc-msos.c.o =

libcommon.fa.p/cpus-common.c.o libcommon.fa.p/hw_core_generic-loader.c.o =

libcommon.fa.p/hw_net_can_ctucan_pci.c.o =

libcommon.fa.p/hw_display_i2c-ddc.c.o =

libcommon.fa.p/backends_tpm_tpm_util.c.o =

libcommon.fa.p/hw_net_pcnet-pci.c.o =

libcommon.fa.p/migration_block-dirty-bitmap.c.o =

libcommon.fa.p/backends_rng-random.c.o libcommon.fa.p/hw_net_rtl8139.c.o =

libcommon.fa.p/hw_char_ibex_uart.c.o =

libqemu-riscv32-softmmu.fa.p/target_riscv_monitor.c.o =

libqemu-riscv32-softmmu.fa.p/target_riscv_pmp.c.o =

libqemu-riscv32-softmmu.fa.p/hw_riscv_sifive_e.c.o =

libqemu-riscv32-softmmu.fa.p/hw_riscv_numa.c.o =

libqemu-riscv32-softmmu.fa.p/hw_riscv_opentitan.c.o =

libqemu-riscv32-softmmu.fa.p/hw_riscv_sifive_u.c.o =

libqemu-riscv32-softmmu.fa.p/hw_riscv_spike.c.o =

libqemu-riscv32-softmmu.fa.p/hw_riscv_virt.c.o =

libqemu-riscv32-softmmu.fa.p/hw_riscv_boot.c.o =

libqemu-riscv32-softmmu.fa.p/hw_riscv_riscv_hart.c.o =

libqemu-riscv32-softmmu.fa.p/target_riscv_cpu.c.o =

libqemu-riscv32-softmmu.fa.p/target_riscv_translate.c.o =

libqemu-riscv32-softmmu.fa.p/target_riscv_csr.c.o =

libqemu-riscv32-softmmu.fa.p/target_riscv_cpu_helper.c.o =

libqemu-riscv32-softmmu.fa.p/target_riscv_vector_helper.c.o =

libqemu-riscv32-softmmu.fa.p/target_riscv_gdbstub.c.o =

libqemu-riscv32-softmmu.fa.p/target_riscv_fpu_helper.c.o =

libqemu-riscv32-softmmu.fa.p/target_riscv_op_helper.c.o =

libqemu-riscv32-softmmu.fa.p/softmmu_ioport.c.o =

libqemu-riscv32-softmmu.fa.p/softmmu_qtest.c.o =

libqemu-riscv32-softmmu.fa.p/hw_virtio_virtio.c.o =

libqemu-riscv32-softmmu.fa.p/hw_virtio_virtio-rng-pci.c.o =

libqemu-riscv32-softmmu.fa.p/hw_scsi_virtio-scsi-dataplane.c.o =

libqemu-riscv32-softmmu.fa.p/hw_core_numa.c.o =

libqemu-riscv32-softmmu.fa.p/dump_dump.c.o =

libqemu-riscv32-softmmu.fa.p/migration_ram.c.o =

libqemu-riscv32-softmmu.fa.p/accel_tcg_cpu-exec.c.o =

libqemu-riscv32-softmmu.fa.p/gdbstub.c.o =

libqemu-riscv32-softmmu.fa.p/hw_virtio_virtio-crypto-pci.c.o =

libqemu-riscv32-softmmu.fa.p/softmmu_arch_init.c.o =

libqemu-riscv32-softmmu.fa.p/accel_tcg_tcg-cpus.c.o =

libqemu-riscv32-softmmu.fa.p/softmmu_cpus.c.o =

libqemu-riscv32-softmmu.fa.p/trace_control-target.c.o =

libqemu-riscv32-softmmu.fa.p/hw_virtio_virtio-scsi-pci.c.o =

libqemu-riscv32-softmmu.fa.p/softmmu_physmem.c.o =

libqemu-riscv32-softmmu.fa.p/disas.c.o =

libqemu-riscv32-softmmu.fa.p/hw_virtio_virtio-blk-pci.c.o =

libqemu-riscv32-softmmu.fa.p/accel_qtest_qtest-cpus.c.o =

libqemu-riscv32-softmmu.fa.p/hw_virtio_virtio-balloon.c.o =

libqemu-riscv32-softmmu.fa.p/tcg_optimize.c.o =

libqemu-riscv32-softmmu.fa.p/hw_display_vga.c.o =

libqemu-riscv32-softmmu.fa.p/monitor_misc.c.o =

libqemu-riscv32-softmmu.fa.p/hw_virtio_vhost.c.o =

libqemu-riscv32-softmmu.fa.p/hw_virtio_virtio-iommu.c.o =

libqemu-riscv32-softmmu.fa.p/accel_tcg_tcg-runtime.c.o =

libqemu-riscv32-softmmu.fa.p/tcg_tcg-op-gvec.c.o =

libqemu-riscv32-softmmu.fa.p/hw_char_riscv_htif.c.o =

libqemu-riscv32-softmmu.fa.p/hw_core_machine-qmp-cmds.c.o =

libqemu-riscv32-softmmu.fa.p/hw_intc_ibex_plic.c.o =

libqemu-riscv32-softmmu.fa.p/accel_tcg_cpu-exec-common.c.o =

libqemu-riscv32-softmmu.fa.p/accel_tcg_tcg-runtime-gvec.c.o =

libqemu-riscv32-softmmu.fa.p/tcg_tcg.c.o =

libqemu-riscv32-softmmu.fa.p/softmmu_balloon.c.o =

libqemu-riscv32-softmmu.fa.p/hw_virtio_vhost-user-fs-pci.c.o =

libqemu-riscv32-softmmu.fa.p/softmmu_icount.c.o =

libqemu-riscv32-softmmu.fa.p/hw_virtio_virtio-balloon-pci.c.o =

libqemu-riscv32-softmmu.fa.p/hw_virtio_vhost-user.c.o =

libqemu-riscv32-softmmu.fa.p/tcg_tcg-op.c.o =

libqemu-riscv32-softmmu.fa.p/softmmu_memory.c.o =

libqemu-riscv32-softmmu.fa.p/hw_block_dataplane_virtio-blk.c.o =

libqemu-riscv32-softmmu.fa.p/fpu_softfloat.c.o =

libqemu-riscv32-softmmu.fa.p/hw_intc_sifive_clint.c.o =

libqemu-riscv32-softmmu.fa.p/hw_scsi_virtio-scsi.c.o =

libqemu-riscv32-softmmu.fa.p/hw_virtio_virtio-rng.c.o =

libqemu-riscv32-softmmu.fa.p/accel_tcg_translator.c.o =

libqemu-riscv32-softmmu.fa.p/hw_intc_sifive_plic.c.o =

libqemu-riscv32-softmmu.fa.p/exec-vary.c.o =

libqemu-riscv32-softmmu.fa.p/hw_virtio_virtio-iommu-pci.c.o =

libqemu-riscv32-softmmu.fa.p/hw_char_virtio-serial-bus.c.o =

libqemu-riscv32-softmmu.fa.p/hw_block_virtio-blk.c.o =

libqemu-riscv32-softmmu.fa.p/hw_virtio_vhost-user-fs.c.o =

libqemu-riscv32-softmmu.fa.p/accel_tcg_tcg-all.c.o =

libqemu-riscv32-softmmu.fa.p/hw_virtio_virtio-net-pci.c.o =

libqemu-riscv32-softmmu.fa.p/softmmu_cpu-throttle.c.o =

libqemu-riscv32-softmmu.fa.p/hw_virtio_virtio-crypto.c.o =

libqemu-riscv32-softmmu.fa.p/softmmu_memory_mapping.c.o =

libqemu-riscv32-softmmu.fa.p/hw_virtio_vhost-backend.c.o =

libqemu-riscv32-softmmu.fa.p/tcg_tcg-common.c.o =

libqemu-riscv32-softmmu.fa.p/softmmu_cpu-timers.c.o =

libqemu-riscv32-softmmu.fa.p/accel_stubs_hax-stub.c.o =

libqemu-riscv32-softmmu.fa.p/hw_net_virtio-net.c.o =

libqemu-riscv32-softmmu.fa.p/migration_dirtyrate.c.o =

libqemu-riscv32-softmmu.fa.p/hw_virtio_vhost-user-input-pci.c.o =

libqemu-riscv32-softmmu.fa.p/accel_stubs_xen-stub.c.o =

libqemu-riscv32-softmmu.fa.p/tcg_tcg-op-vec.c.o =

libqemu-riscv32-softmmu.fa.p/accel_qtest_qtest.c.o =

libqemu-riscv32-softmmu.fa.p/accel_tcg_cputlb.c.o =

libqemu-riscv32-softmmu.fa.p/hw_virtio_virtio-input-pci.c.o =

libqemu-riscv32-softmmu.fa.p/softmmu_vl.c.o =

libqemu-riscv32-softmmu.fa.p/hw_virtio_virtio-serial-pci.c.o =

libqemu-riscv32-softmmu.fa.p/accel_tcg_translate-all.c.o =

libqemu-riscv32-softmmu.fa.p/cpu.c.o =

libqemu-riscv32-softmmu.fa.p/accel_stubs_kvm-stub.c.o =

libqemu-riscv32-softmmu.fa.p/meson-generated_.._riscv32-softmmu-gdbstub-x=
ml.c.o =

libqemu-riscv32-softmmu.fa.p/meson-generated_.._trace_generated-helpers.c=
=2Eo =

libqemu-riscv32-softmmu.fa.p/meson-generated_.._qapi_qapi-commands-machin=
e-target.c.o =

libqemu-riscv32-softmmu.fa.p/meson-generated_.._qapi_qapi-visit.c.o =

libqemu-riscv32-softmmu.fa.p/meson-generated_.._qapi_qapi-types-misc-targ=
et.c.o =

libqemu-riscv32-softmmu.fa.p/meson-generated_.._qapi_qapi-commands.c.o =

libqemu-riscv32-softmmu.fa.p/meson-generated_.._qapi_qapi-visit-misc-targ=
et.c.o =

libqemu-riscv32-softmmu.fa.p/meson-generated_.._qapi_qapi-init-commands.c=
=2Eo =

libqemu-riscv32-softmmu.fa.p/meson-generated_.._qapi_qapi-events-misc-tar=
get.c.o =

libqemu-riscv32-softmmu.fa.p/meson-generated_.._qapi_qapi-events.c.o =

libqemu-riscv32-softmmu.fa.p/meson-generated_.._qapi_qapi-commands-misc-t=
arget.c.o =

libqemu-riscv32-softmmu.fa.p/meson-generated_.._qapi_qapi-types-machine-t=
arget.c.o =

libqemu-riscv32-softmmu.fa.p/meson-generated_.._qapi_qapi-emit-events.c.o=
 =

libqemu-riscv32-softmmu.fa.p/meson-generated_.._qapi_qapi-introspect.c.o =

libqemu-riscv32-softmmu.fa.p/meson-generated_.._qapi_qapi-visit-machine-t=
arget.c.o =

libqemu-riscv32-softmmu.fa.p/meson-generated_.._qapi_qapi-events-machine-=
target.c.o =

libqemu-riscv32-softmmu.fa.p/meson-generated_.._qapi_qapi-types.c.o =

-Wl,-dead_strip_dylibs -Wl,-headerpad_max_install_names =

-Wl,-undefined,error -Wl,-force_load libhwcore.fa -Wl,-force_load =

libchardev.fa -Wl,-force_load libqmp.fa -Wl,-force_load libauthz.fa =

-Wl,-force_load libqom.fa -Wl,-force_load libio.fa -Wl,-force_load =

libcrypto.fa -Wl,-force_load libblock.fa -m64 -framework CoreFoundation =

-framework IOKit -arch x86_64 -fstack-protector-strong libfdt.a =

libcapstone.a libqemuutil.a libmigration.fa libhwcore.fa libchardev.fa =

libqmp.fa libauthz.fa libqom.fa libio.fa libcrypto.fa libblock.fa =

@block.syms @qemu.syms -lsnappy =

/usr/local/Cellar/pixman/0.40.0/lib/libpixman-1.dylib -llzo2 =

-L/usr/local/Cellar/libusb/1.0.23/lib -lusb-1.0 /usr/lib/libz.dylib =

-framework Cocoa -framework CoreAudio =

-L/usr/local/Cellar/glib/2.66.1/lib -L/usr/local/opt/gettext/lib =

-lgio-2.0 -lgobject-2.0 -lglib-2.0 -lintl =

-L/usr/local/Cellar/glib/2.66.1/lib -L/usr/local/opt/gettext/lib =

-lgio-2.0 -lgobject-2.0 -lglib-2.0 -lintl =

/usr/local/Cellar/libpng/1.6.37/lib/libpng16.dylib @block.syms =

-L/usr/local/Cellar/glib/2.66.1/lib -L/usr/local/opt/gettext/lib =

-lgio-2.0 -lgobject-2.0 -lglib-2.0 -lintl =

-L/usr/local/Cellar/glib/2.66.1/lib -L/usr/local/opt/gettext/lib =

-lgio-2.0 -lgobject-2.0 -lglib-2.0 -lintl =

-L/usr/local/Cellar/gnutls/3.6.15/lib -lgnutls -lutil -lm =

-L/usr/local/Cellar/glib/2.66.1/lib -L/usr/local/opt/gettext/lib =

-lgmodule-2.0 -lglib-2.0 -lintl -lpam =

-L/usr/local/Cellar/gnutls/3.6.15/lib -lgnutls =

-L/usr/local/Cellar/nettle/3.6/lib -lnettle -framework IOKit -framework =

CoreFoundation -lxml2 -Wl,-rpath,/usr/local/Cellar/pixman/0.40.0/lib =

-Wl,-rpath,/usr/lib -lc++
ld: file not found: _PreallocMode_lookup
clang: error: linker command failed with exit code 1 (use -v to see =

invocation)
[2036/2125] Compiling C object =

tests/fp/fp-bench.p/.._.._fpu_softfloat.c.o
ninja: build stopped: subcommand failed.

eblot@thurso ~/S/G/g/Q/f/build (master) [1]> cc --version
Apple clang version 12.0.0 (clang-1200.0.32.2)
Target: x86_64-apple-darwin19.6.0
Thread model: posix
InstalledDir: =

/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctool=
chain/usr/bin

