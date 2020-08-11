Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B463C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 15:02:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2A1620771
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 15:02:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2A1620771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5VnK-0006im-VN
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 11:02:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48446)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1k5Vlc-0005h1-Q2
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 11:00:44 -0400
Received: from relay68.bu.edu ([128.197.228.73]:50818)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1k5VlW-00071m-W0
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 11:00:43 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay68.bu.edu (8.14.3/8.14.3) with ESMTP id 07BExvhJ013356
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 11 Aug 2020 11:00:00 -0400
Date: Tue, 11 Aug 2020 10:59:57 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 131/147] meson: link emulators without Makefile.target
Message-ID: <20200811145957.bbfq7laqme4rxwsp@mozz.bu.edu>
References: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
 <1597079345-42801-132-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1597079345-42801-132-git-send-email-pbonzini@redhat.com>
User-Agent: NeoMutt/20180716
Received-SPF: pass client-ip=128.197.228.73; envelope-from=alxndr@bu.edu;
 helo=relay68.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 11:00:38
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 HK_RANDOM_FROM=1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Paolo,
I looked through the code changes related to fuzzing and tested the
following builds:
 - qemu-fuzz-i386
 - qemu-fuzz-arm
 - qemu-system-i386 (with --enable-fuzzing)
 - configure --enable-fuzzing with GCC (should fail)
 - ./scripts/oss-fuzz/build.sh (in my local environment) 
 - ./scripts/oss-fuzz/build.sh (in the oss-fuzz Docker) 
I examined the symbols to ensure that the fuzzer linker-script is doing what it
needs to be doing. The sizes of the binaries have roughly stayed the same, and
there are no major differences between the symbols.
Only the oss-fuzz Docker build failed with a complaint about the linker-script,
but it fails for the current master, too! I think the problem might be related
to the fact that the docker uses a bleeding edge clang-12 compiler. I'll have
to look into it more.
I ran the existing fuzzers for a couple thousand runs. It looks like there is
some problem with the virtio-scsi arguments, but it's not specific to
fuzzing. It will probably be caught once this runs through CI:

./qemu-system-i386 -display none -machine accel=qtest -m 64 -M pc \
-drive id=drv0,if=none,file=null-co://,file.read-zeroes=on,format=raw \
-device virtio-scsi-pci,id=vs0,addr=04.0 \
-device scsi-hd,bus=vs0.0,drive=drv0 \
-drive file=blkdebug::null-co://,file.image.read-zeroes=on,if=none,id=dr1,format=raw,file.align=4k \
-device scsi-hd,drive=dr1,lun=0,scsi-id=1 -qtest /dev/null -qtest-log /dev/null

Immediately crashes with:
../block.c:442:10: runtime error: index 0 out of bounds for type 'const char *[0]'
SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior ../block.c:442:10 in 
../block.c:442:10: runtime error: load of address 0x5581a17161e0 with insufficient space for an object of type 'const char *'
0x5581a17161e0: note: pointer points here
 00 00 00 00  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  00 00 00 00
              ^ 
SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior ../block.c:442:10 in 
=================================================================
==26813==ERROR: AddressSanitizer: global-buffer-overflow on address 0x5581a17161e0 at pc 0x55819e05f1bd bp 0x7ffed60bdcc0 sp 0x7ffed60bdcb8
READ of size 8 at 0x5581a17161e0 thread T0
    #0 0x55819e05f1bc in bdrv_format_is_whitelisted /tmp/qemu/build/../block.c:442:10
    #1 0x55819e05f1bc in bdrv_is_whitelisted /tmp/qemu/build/../block.c:463:12
    #2 0x55819e075e5f in bdrv_open_common /tmp/qemu/build/../block.c:1680:32
    #3 0x55819e075e5f in bdrv_open_inherit /tmp/qemu/build/../block.c:3420:11
    #4 0x55819e07d1db in bdrv_open_child_bs /tmp/qemu/build/../block.c:3053:10
    #5 0x55819e074b61 in bdrv_open_inherit /tmp/qemu/build/../block.c:3367:19
    #6 0x55819e07dac4 in bdrv_open /tmp/qemu/build/../block.c:3513:12
    #7 0x55819e2d78c5 in blk_new_open /tmp/qemu/build/../block/block-backend.c:421:10
    #8 0x55819d4242ee in blockdev_init /tmp/qemu/build/../blockdev.c:617:15
    #9 0x55819d4242ee in drive_new /tmp/qemu/build/../blockdev.c:1005:11
    #10 0x55819da17085 in drive_init_func /tmp/qemu/build/../softmmu/vl.c:1000:12
    #11 0x55819e61bd4c in qemu_opts_foreach /tmp/qemu/build/../util/qemu-option.c:1172:14
    #12 0x55819da0aab2 in configure_blockdev /tmp/qemu/build/../softmmu/vl.c:1067:9
    #13 0x55819da0aab2 in qemu_init /tmp/qemu/build/../softmmu/vl.c:4145:5
    #14 0x55819c72a5b8 in main /tmp/qemu/build/../softmmu/main.c:48:5
    #15 0x7faba3b86e0a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x26e0a)
    #16 0x55819c680659 in _start (/tmp/qemu/build/qemu-system-i386+0x254d659)

0x5581a17161e0 is located 32 bytes to the left of global variable 'whitelist_ro' defined in '../block.c:437:24' (0x5581a1716200) of size 0
  'whitelist_ro' is ascii string ''
0x5581a17161e0 is located 0 bytes to the right of global variable 'whitelist_rw' defined in '../block.c:434:24' (0x5581a17161e0) of size 0
  'whitelist_rw' is ascii string ''
SUMMARY: AddressSanitizer: global-buffer-overflow /tmp/qemu/build/../block.c:442:10 in bdrv_format_is_whitelisted

This doesn't happen on master. Since its not related to this patch, and
I can't think of anything else to test, for the fuzzing changes to this
patch:

Reviewed-by: Alexander Bulekov <alxndr@bu.edu>

Thanks!
-Alex

On 200810 1908, Paolo Bonzini wrote:
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  .gitlab-ci.yml                            |   6 +-
>  Makefile                                  |  34 +------
>  Makefile.objs                             |  32 -------
>  Makefile.target                           | 153 +-----------------------------
>  configure                                 |  24 ++---
>  docs/devel/blkverify.txt                  |   4 +-
>  docs/devel/testing.rst                    |   4 +-
>  docs/interop/live-block-operations.rst    |   4 +-
>  meson.build                               |  73 +++++++++++++-
>  os-posix.c                                |   2 +-
>  plugins/meson.build                       |  10 +-
>  rules.mak                                 |   1 -
>  scripts/device-crash-test                 |   2 +-
>  scripts/oss-fuzz/build.sh                 |  20 ++--
>  softmmu/Makefile.objs                     |   2 -
>  tests/Makefile.include                    |   4 +-
>  tests/acceptance/avocado_qemu/__init__.py |   3 +-
>  tests/data/acpi/rebuild-expected-aml.sh   |   2 +-
>  tests/multiboot/run_test.sh               |   2 +-
>  tests/qemu-iotests/check                  |   6 +-
>  tests/qtest/fuzz/Makefile.include         |  39 --------
>  tests/qtest/fuzz/i440fx_fuzz.c            |   4 +-
>  tests/qtest/fuzz/meson.build              |  35 +++++++
>  tests/qtest/fuzz/qtest_wrappers.c         |   2 +-
>  tests/qtest/fuzz/virtio_net_fuzz.c        |   3 +-
>  tests/qtest/fuzz/virtio_scsi_fuzz.c       |   8 +-
>  tests/qtest/libqos/qgraph.h               |   2 +-
>  tests/qtest/meson.build                   |   2 +-
>  tests/qtest/rtas-test.c                   |   2 +-
>  tests/tcg/configure.sh                    |   4 +-
>  30 files changed, 168 insertions(+), 321 deletions(-)
>  delete mode 100644 softmmu/Makefile.objs
>  delete mode 100644 tests/qtest/fuzz/Makefile.include
>  create mode 100644 tests/qtest/fuzz/meson.build
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 9820066..b7967b9 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -265,9 +265,9 @@ build-tci:
>      - make run-tcg-tests-x86_64-softmmu
>      - make tests/qtest/boot-serial-test tests/qtest/cdrom-test tests/qtest/pxe-test
>      - for tg in $TARGETS ; do
> -        export QTEST_QEMU_BINARY="${tg}-softmmu/qemu-system-${tg}" ;
> +        export QTEST_QEMU_BINARY="./qemu-system-${tg}" ;
>          ./tests/qtest/boot-serial-test || exit 1 ;
>          ./tests/qtest/cdrom-test || exit 1 ;
>        done
> -    - QTEST_QEMU_BINARY="x86_64-softmmu/qemu-system-x86_64" ./tests/qtest/pxe-test
> -    - QTEST_QEMU_BINARY="s390x-softmmu/qemu-system-s390x" ./tests/qtest/pxe-test -m slow
> +    - QTEST_QEMU_BINARY="./qemu-system-x86_64" ./tests/qtest/pxe-test
> +    - QTEST_QEMU_BINARY="./qemu-system-s390x" ./tests/qtest/pxe-test -m slow
> diff --git a/Makefile b/Makefile
> index e3ccea0..ebda912 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -105,9 +105,6 @@ include $(SRC_PATH)/rules.mak
>  # lor is defined in rules.mak
>  CONFIG_BLOCK := $(call lor,$(CONFIG_SOFTMMU),$(CONFIG_TOOLS))
>  
> -generated-files-y += target/s390x/gen-features.h
> -target/s390x/gen-features.h: Makefile.ninja
> -
>  generated-files-y += .git-submodule-status
>  
>  # Don't try to regenerate Makefile or configure
> @@ -171,29 +168,6 @@ config-host.h-timestamp: config-host.mak
>  
>  TARGET_DIRS_RULES := $(foreach t, all fuzz clean install, $(addsuffix /$(t), $(TARGET_DIRS)))
>  
> -SOFTMMU_ALL_RULES=$(filter %-softmmu/all, $(TARGET_DIRS_RULES))
> -$(SOFTMMU_ALL_RULES): $(authz-obj-y)
> -$(SOFTMMU_ALL_RULES): $(block-obj-y)
> -$(SOFTMMU_ALL_RULES): $(chardev-obj-y)
> -$(SOFTMMU_ALL_RULES): $(crypto-obj-y)
> -$(SOFTMMU_ALL_RULES): $(io-obj-y)
> -$(SOFTMMU_ALL_RULES): $(qom-obj-y)
> -$(SOFTMMU_ALL_RULES): config-all-devices.mak
> -
> -SOFTMMU_FUZZ_RULES=$(filter %-softmmu/fuzz, $(TARGET_DIRS_RULES))
> -$(SOFTMMU_FUZZ_RULES): $(authz-obj-y)
> -$(SOFTMMU_FUZZ_RULES): $(block-obj-y)
> -$(SOFTMMU_FUZZ_RULES): $(chardev-obj-y)
> -$(SOFTMMU_FUZZ_RULES): $(crypto-obj-y)
> -$(SOFTMMU_FUZZ_RULES): $(io-obj-y)
> -$(SOFTMMU_FUZZ_RULES): config-all-devices.mak
> -$(SOFTMMU_FUZZ_RULES): $(edk2-decompressed)
> -
> -# meson: this is sub-optimal but going away after conversion
> -TARGET_DEPS = $(patsubst %,%-config-target.h, $(TARGET_DIRS))
> -TARGET_DEPS += $(patsubst %,%-config-devices.h, $(filter %-softmmu,$(TARGET_DIRS)))
> -TARGET_DEPS += $(patsubst %,libqemu-%.fa, $(TARGET_DIRS))
> -
>  .PHONY: $(TARGET_DIRS_RULES)
>  # The $(TARGET_DIRS_RULES) are of the form SUBDIR/GOAL, so that
>  # $(dir $@) yields the sub-directory, and $(notdir $@) yields the sub-goal
> @@ -236,11 +210,7 @@ slirp/all: .git-submodule-status
>  		CC="$(CC)" AR="$(AR)" 	LD="$(LD)" RANLIB="$(RANLIB)"	\
>  		CFLAGS="$(QEMU_CFLAGS) $(CFLAGS)" LDFLAGS="$(QEMU_LDFLAGS)")
>  
> -$(filter %/all, $(TARGET_DIRS_RULES)): libqemuutil.a $(common-obj-y) \
> -	$(qom-obj-y) block.syms qemu.syms
> -
> -$(filter %/fuzz, $(TARGET_DIRS_RULES)): libqemuutil.a $(common-obj-y) \
> -	$(qom-obj-y) $(crypto-user-obj-$(CONFIG_USER_ONLY))
> +$(filter %/all, $(TARGET_DIRS_RULES)):
>  
>  ROM_DIRS = $(addprefix pc-bios/, $(ROMS))
>  ROM_DIRS_RULES=$(foreach t, all clean, $(addsuffix /$(t), $(ROM_DIRS)))
> @@ -262,8 +232,6 @@ Makefile: $(version-obj-y)
>  
>  ######################################################################
>  
> -COMMON_LDADDS = libqemuutil.a
> -
>  clean: recurse-clean
>  # avoid old build problems by removing potentially incorrect old files
>  	rm -f config.mak op-i386.h opc-i386.h gen-op-i386.h op-arm.h opc-arm.h gen-op-arm.h
> diff --git a/Makefile.objs b/Makefile.objs
> index 83622c5..5295c3a 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -34,37 +34,5 @@ io-obj-y = io/libio.fa
>  endif # CONFIG_SOFTMMU or CONFIG_TOOLS
>  
>  ######################################################################
> -# Target independent part of system emulation. The long term path is to
> -# suppress *all* target specific code in case of system emulation, i.e. a
> -# single QEMU executable should support all CPUs and machines.
> -
> -ifeq ($(CONFIG_SOFTMMU),y)
> -common-obj-y =
> -
> -common-obj-$(CONFIG_AUDIO_ALSA) += audio-alsa$(DSOSUF)
> -common-obj-$(CONFIG_AUDIO_OSS) += audio-oss$(DSOSUF)
> -common-obj-$(CONFIG_AUDIO_PA) += audio-pa$(DSOSUF)
> -common-obj-$(CONFIG_AUDIO_SDL) += audio-sdl$(DSOSUF)
> -
> -common-obj-$(if $(CONFIG_CURSES),m) += ui-curses$(DSOSUF)
> -common-obj-$(if $(CONFIG_GTK),m) += ui-gtk$(DSOSUF)
> -common-obj-$(if $(CONFIG_SDL),m) += ui-sdl$(DSOSUF)
> -common-obj-$(if $(CONFIG_SPICE),m) += ui-spice-app$(DSOSUF)
> -
> -common-obj-$(if $(CONFIG_CURL),m) += block-curl$(DSOSUF)
> -common-obj-$(if $(CONFIG_GLUSTERFS),m) += block-gluster$(DSOSUF)
> -common-obj-$(if $(CONFIG_LIBISCSI),m) += block-iscsi$(DSOSUF)
> -common-obj-$(if $(CONFIG_LIBNFS),m) += block-nfs$(DSOSUF)
> -common-obj-$(if $(CONFIG_LIBSSH),m) += block-ssh$(DSOSUF)
> -common-obj-$(if $(CONFIG_RBD),m) += block-rbd$(DSOSUF)
> -
> -common-obj-$(if $(CONFIG_LZFSE),m) += block-dmg-lzfse$(DSOSUF)
> -common-obj-$(if $(and $(CONFIG_BZIP2),$(CONFIG_DMG)),m) += block-dmg-bz2$(DSOSUF)
> -
> -common-obj-y += libqmp.fa
> -
> -endif # CONFIG_SOFTMMU
> -
> -######################################################################
>  # Resource file for Windows executables
>  version-obj-$(CONFIG_WIN32) += $(BUILD_DIR)/version.o
> diff --git a/Makefile.target b/Makefile.target
> index 2b7280b..8ee4c78 100644
> --- a/Makefile.target
> +++ b/Makefile.target
> @@ -6,43 +6,16 @@ include ../config-host.mak
>  include config-target.mak
>  include $(SRC_PATH)/rules.mak
>  
> -FULL_TARGET_NAME=$(TARGET_NAME)-$(if $(CONFIG_SOFTMMU),softmmu,linux-user)
> -
> -ifdef CONFIG_SOFTMMU
> -include ../$(FULL_TARGET_NAME)-config-devices.mak
> -endif
> -
>  $(call set-vpath, $(SRC_PATH):$(BUILD_DIR))
> -ifdef CONFIG_LINUX
> -QEMU_CFLAGS += -isystem ../linux-headers
> -endif
> -QEMU_CFLAGS += -iquote .. -iquote $(SRC_PATH)/target/$(TARGET_BASE_ARCH) -DNEED_CPU_H
> -
> -QEMU_CFLAGS+=-iquote $(SRC_PATH)/include
> -
> -QEMU_CFLAGS += -DCONFIG_TARGET=\"../$(FULL_TARGET_NAME)-config-target.h\"
> -QEMU_CFLAGS += -DCONFIG_DEVICES=\"../$(FULL_TARGET_NAME)-config-devices.h\"
>  
>  ifdef CONFIG_USER_ONLY
>  # user emulator name
>  QEMU_PROG=qemu-$(TARGET_NAME)
> -QEMU_PROG_BUILD = $(QEMU_PROG)
>  else
>  # system emulator name
>  QEMU_PROG=qemu-system-$(TARGET_NAME)$(EXESUF)
> -ifneq (,$(findstring -mwindows,$(SDL_LIBS)))
> -# Terminate program name with a 'w' because the linker builds a windows executable.
> -QEMU_PROGW=qemu-system-$(TARGET_NAME)w$(EXESUF)
> -$(QEMU_PROG): $(QEMU_PROGW)
> -	$(call quiet-command,$(OBJCOPY) --subsystem console $(QEMU_PROGW) $(QEMU_PROG),"GEN","$(TARGET_DIR)$(QEMU_PROG)")
> -QEMU_PROG_BUILD = $(QEMU_PROGW)
> -else
> -QEMU_PROG_BUILD = $(QEMU_PROG)
> -endif
>  endif
>  
> -LIBQEMU = ../libqemu-$(FULL_TARGET_NAME).fa
> -PROGS=$(QEMU_PROG) $(QEMU_PROGW)
>  STPFILES=
>  
>  ifdef CONFIG_TRACE_SYSTEMTAP
> @@ -98,109 +71,10 @@ stap:
>  endif
>  .PHONY: stap
>  
> -all: $(PROGS) stap
> -
> -# Dummy command so that make thinks it has done something
> -	@true
> -
> -obj-y += $(LIBQEMU)
> -
> -obj-y += trace/
> -
> -#########################################################
> -LIBS := $(libs_cpu) $(LIBS)
> -
> -#########################################################
> -# Linux user emulator target
> -
> -ifdef CONFIG_LINUX_USER
> -
> -QEMU_CFLAGS+=-I$(SRC_PATH)/linux-user/$(TARGET_ABI_DIR) \
> -             -I$(SRC_PATH)/linux-user/host/$(ARCH) \
> -             -I$(SRC_PATH)/linux-user \
> -             -Ilinux-user/$(TARGET_ABI_DIR)
> -
> -endif #CONFIG_LINUX_USER
> -
> -#########################################################
> -# BSD user emulator target
> -
> -ifdef CONFIG_BSD_USER
> -
> -QEMU_CFLAGS+=-I$(SRC_PATH)/bsd-user -I$(SRC_PATH)/bsd-user/$(TARGET_ABI_DIR) \
> -			 -I$(SRC_PATH)/bsd-user/$(HOST_VARIANT_DIR)
> -
> -endif #CONFIG_BSD_USER
> -
> -#########################################################
> -# System emulator target
> -ifdef CONFIG_SOFTMMU
> -obj-y += softmmu/
> -obj-y += gdbstub.o
> -LIBS := $(libs_softmmu) $(LIBS)
> -
> -# Temporary until emulators are linked by Meson
> -LIBS := $(LIBS) @../block.syms @../qemu.syms
> -ifneq ($(CONFIG_MODULES),y)
> -LIBS := $(LIBS) $(ALSA_LIBS) $(OSS_LIBS) $(PULSE_LIBS) $(SDL_LIBS)
> -LIBS := $(LIBS) $(GTK_LIBS) $(VTE_LIBS) $(X11_LIBS) $(CURSES_LIBS) $(ICONV_LIBS) $(GIO_LIBS)
> -endif
> -LIBS := $(LIBS) $(BRLAPI_LIBS) $(SDL_LIBS) $(SPICE_LIBS) $(OPENGL_LIBS) $(SECCOMP_LIBS)
> -LIBS := $(LIBS) $(COREAUDIO_LIBS) $(DSOUND_LIBS)
> -LIBS := $(LIBS) $(VDE_LIBS) $(SLIRP_LIBS)
> -LIBS := $(LIBS) $(LIBUSB_LIBS) $(SMARTCARD_LIBS) $(USB_REDIR_LIBS)
> -LIBS := $(LIBS) $(VIRGL_LIBS) $(CURSES_LIBS)
> -
> -ifeq ($(CONFIG_PLUGIN),y)
> -ifdef CONFIG_HAS_LD_DYNAMIC_LIST
> -LIBS += -Wl,--dynamic-list=$(BUILD_DIR)/qemu-plugins-ld.symbols
> -else
> -ifdef CONFIG_HAS_LD_EXPORTED_SYMBOLS_LIST
> -LIBS += -Wl,-exported_symbols_list,$(BUILD_DIR)/qemu-plugins-ld64.symbols
> -endif
> -endif
> -endif
> -
> -generated-files-y += hmp-commands.h hmp-commands-info.h
> -
> -endif # CONFIG_SOFTMMU
> -
> -dummy := $(call unnest-vars,,obj-y)
> -all-obj-y := $(obj-y)
> -
> -include $(SRC_PATH)/Makefile.objs
> -dummy := $(call fix-paths,../,, \
> -              authz-obj-y \
> -              block-obj-y \
> -              chardev-obj-y \
> -              crypto-obj-y \
> -              io-obj-y \
> -              qom-obj-y)
> -dummy := $(call unnest-vars,..,common-obj-y)
> -
> -all-obj-y += $(common-obj-y)
> -all-obj-y += $(qom-obj-y)
> -all-obj-$(CONFIG_SOFTMMU) += $(authz-obj-y)
> -all-obj-$(CONFIG_SOFTMMU) += $(block-obj-y) $(chardev-obj-y)
> -all-obj-$(CONFIG_SOFTMMU) += $(crypto-obj-y)
> -all-obj-$(CONFIG_SOFTMMU) += $(io-obj-y)
> -
> -ifdef CONFIG_SOFTMMU
> -$(QEMU_PROG_BUILD): ../$(FULL_TARGET_NAME)-config-devices.mak
> -endif
> -
> -COMMON_LDADDS = ../libqemuutil.a
> -
> -# build either PROG or PROGW
> -$(QEMU_PROG_BUILD): $(all-obj-y) $(COMMON_LDADDS) $(softmmu-main-y)
> -	$(call LINK, $(filter-out %.mak, $^))
> -ifdef CONFIG_DARWIN
> -	$(call quiet-command,Rez -append $(SRC_PATH)/pc-bios/qemu.rsrc -o $@,"REZ","$(TARGET_DIR)$@")
> -	$(call quiet-command,SetFile -a C $@,"SETFILE","$(TARGET_DIR)$@")
> -endif
> +all: stap
>  
> -clean: clean-target
> -	rm -f *.a *~ $(PROGS)
> +clean:
> +	rm -f *.a *~
>  	rm -f $(shell find . -name '*.[od]')
>  	rm -f hmp-commands.h gdbstub-xml.c
>  	rm -f trace/generated-helpers.c trace/generated-helpers.c-timestamp
> @@ -208,26 +82,7 @@ ifdef CONFIG_TRACE_SYSTEMTAP
>  	rm -f *.stp
>  endif
>  
> -ifdef CONFIG_FUZZ
> -include $(SRC_PATH)/tests/qtest/fuzz/Makefile.include
> -include $(SRC_PATH)/tests/qtest/Makefile.include
> -
> -fuzz: fuzz-vars
> -fuzz-vars: QEMU_CFLAGS := $(FUZZ_CFLAGS) $(QEMU_CFLAGS)
> -fuzz-vars: QEMU_LDFLAGS := $(FUZZ_LDFLAGS) $(QEMU_LDFLAGS)
> -fuzz-vars: $(QEMU_PROG_FUZZ)
> -dummy := $(call unnest-vars,, fuzz-obj-y)
> -
> -
> -$(QEMU_PROG_FUZZ): config-devices.mak $(all-obj-y) $(COMMON_LDADDS) $(fuzz-obj-y)
> -	$(call LINK, $(filter-out %.mak, $^))
> -
> -endif
> -
>  install: all
> -ifneq ($(PROGS),)
> -	$(call install-prog,$(PROGS),$(DESTDIR)$(bindir))
> -endif
>  ifdef CONFIG_TRACE_SYSTEMTAP
>  	$(INSTALL_DIR) "$(DESTDIR)$(qemu_datadir)/../systemtap/tapset"
>  	$(INSTALL_DATA) $(QEMU_PROG).stp-installed "$(DESTDIR)$(qemu_datadir)/../systemtap/tapset/$(QEMU_PROG).stp"
> @@ -235,4 +90,4 @@ ifdef CONFIG_TRACE_SYSTEMTAP
>  	$(INSTALL_DATA) $(QEMU_PROG)-log.stp "$(DESTDIR)$(qemu_datadir)/../systemtap/tapset/$(QEMU_PROG)-log.stp"
>  endif
>  
> -Makefile: $(generated-files-y)
> +.PHONY: all clean install
> diff --git a/configure b/configure
> index a912055..23e93aa 100755
> --- a/configure
> +++ b/configure
> @@ -316,7 +316,6 @@ audio_drv_list=""
>  block_drv_rw_whitelist=""
>  block_drv_ro_whitelist=""
>  host_cc="cc"
> -libs_cpu=""
>  libs_softmmu=""
>  libs_tools=""
>  audio_win_int=""
> @@ -5417,7 +5416,6 @@ case "$capstone" in
>      else
>        LIBCAPSTONE=libcapstone.a
>      fi
> -    libs_cpu="-L$PWD/capstone -lcapstone $libs_cpu"
>      capstone_libs="-L$PWD/capstone -lcapstone"
>      capstone_cflags="-I${source_path}/capstone/include"
>      ;;
> @@ -5426,7 +5424,6 @@ case "$capstone" in
>      capstone_libs="$($pkg_config --libs capstone)"
>      capstone_cflags="$($pkg_config --cflags capstone)"
>      QEMU_CFLAGS="$QEMU_CFLAGS $($pkg_config --cflags capstone)"
> -    libs_cpu="$($pkg_config --libs capstone) $libs_cpu"
>      ;;
>  
>    no)
> @@ -6344,7 +6341,10 @@ fi
>  if test "$fuzzing" = "yes" ; then
>    write_c_fuzzer_skeleton
>    if compile_prog "$CPU_CFLAGS -Werror -fsanitize=fuzzer" ""; then
> -      have_fuzzer=yes
> +    have_fuzzer=yes
> +  else
> +    error_exit "Your compiler doesn't support -fsanitize=fuzzer"
> +    exit 1
>    fi
>  fi
>  
> @@ -6844,7 +6844,6 @@ echo "qemu_helperdir=$libexecdir" >> $config_host_mak
>  echo "qemu_localedir=$qemu_localedir" >> $config_host_mak
>  echo "qemu_icondir=$qemu_icondir" >> $config_host_mak
>  echo "qemu_desktopdir=$qemu_desktopdir" >> $config_host_mak
> -echo "libs_cpu=$libs_cpu" >> $config_host_mak
>  echo "libs_softmmu=$libs_softmmu" >> $config_host_mak
>  echo "GIT=$git" >> $config_host_mak
>  echo "GIT_SUBMODULES=$git_submodules" >> $config_host_mak
> @@ -7709,14 +7708,7 @@ if test "$have_mlockall" = "yes" ; then
>    echo "HAVE_MLOCKALL=y" >> $config_host_mak
>  fi
>  if test "$fuzzing" = "yes" ; then
> -  if test "$have_fuzzer" = "yes"; then
> -    FUZZ_LDFLAGS=" -fsanitize=fuzzer"
> -    FUZZ_CFLAGS=" -fsanitize=fuzzer"
> -    QEMU_CFLAGS="$QEMU_CFLAGS -fsanitize=fuzzer-no-link"
> -  else
> -    error_exit "Your compiler doesn't support -fsanitize=fuzzer"
> -    exit 1
> -  fi
> +  QEMU_CFLAGS="$QEMU_CFLAGS -fsanitize=fuzzer-no-link"
>  fi
>  
>  if test "$plugins" = "yes" ; then
> @@ -7832,8 +7824,6 @@ if test "$libudev" != "no"; then
>  fi
>  if test "$fuzzing" != "no"; then
>      echo "CONFIG_FUZZ=y" >> $config_host_mak
> -    echo "FUZZ_CFLAGS=$FUZZ_CFLAGS" >> $config_host_mak
> -    echo "FUZZ_LDFLAGS=$FUZZ_LDFLAGS" >> $config_host_mak
>  fi
>  
>  if test "$edk2_blobs" = "yes" ; then
> @@ -8303,8 +8293,8 @@ if test "$TARGET_ARCH" = "s390x" && test "$target_softmmu" = "yes" && \
>      fi
>  fi
>  
> -echo "QEMU_LDFLAGS+=$ldflags" >> $config_target_mak
> -echo "QEMU_CFLAGS+=$cflags" >> $config_target_mak
> +echo "QEMU_LDFLAGS=$ldflags" >> $config_target_mak
> +echo "QEMU_CFLAGS=$cflags" >> $config_target_mak
>  
>  done # for target in $targets
>  
> diff --git a/docs/devel/blkverify.txt b/docs/devel/blkverify.txt
> index d556dc4..aca826c 100644
> --- a/docs/devel/blkverify.txt
> +++ b/docs/devel/blkverify.txt
> @@ -62,8 +62,8 @@ A more realistic scenario is verifying the installation of a guest OS:
>  
>      $ ./qemu-img create raw.img 16G
>      $ ./qemu-img create -f qcow2 test.qcow2 16G
> -    $ x86_64-softmmu/qemu-system-x86_64 -cdrom debian.iso \
> -                                        -drive file=blkverify:raw.img:test.qcow2
> +    $ ./qemu-system-x86_64 -cdrom debian.iso \
> +          -drive file=blkverify:raw.img:test.qcow2
>  
>  If the installation is aborted when blkverify detects corruption, use qemu-io
>  to explore the contents of the disk image at the sector in question.
> diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
> index a426469..196e3bc 100644
> --- a/docs/devel/testing.rst
> +++ b/docs/devel/testing.rst
> @@ -819,7 +819,7 @@ the following approaches:
>  1) Set ``qemu_bin``, and use the given binary
>  
>  2) Do not set ``qemu_bin``, and use a QEMU binary named like
> -   "${arch}-softmmu/qemu-system-${arch}", either in the current
> +   "qemu-system-${arch}", either in the current
>     working directory, or in the current source tree.
>  
>  The resulting ``qemu_bin`` value will be preserved in the
> @@ -886,7 +886,7 @@ like the following:
>  
>  .. code::
>  
> -  PARAMS (key=qemu_bin, path=*, default=x86_64-softmmu/qemu-system-x86_64) => 'x86_64-softmmu/qemu-system-x86_64
> +  PARAMS (key=qemu_bin, path=*, default=./qemu-system-x86_64) => './qemu-system-x86_64
>  
>  arch
>  ~~~~
> diff --git a/docs/interop/live-block-operations.rst b/docs/interop/live-block-operations.rst
> index 48afdc7..e13f5a2 100644
> --- a/docs/interop/live-block-operations.rst
> +++ b/docs/interop/live-block-operations.rst
> @@ -129,7 +129,7 @@ To show some example invocations of command-line, we will use the
>  following invocation of QEMU, with a QMP server running over UNIX
>  socket::
>  
> -    $ ./x86_64-softmmu/qemu-system-x86_64 -display none -no-user-config \
> +    $ ./qemu-system-x86_64 -display none -no-user-config \
>          -M q35 -nodefaults -m 512 \
>          -blockdev node-name=node-A,driver=qcow2,file.driver=file,file.node-name=file,file.filename=./a.qcow2 \
>          -device virtio-blk,drive=node-A,id=virtio0 \
> @@ -694,7 +694,7 @@ instance, with the following invocation.  (As noted earlier, for
>  simplicity's sake, the destination QEMU is started on the same host, but
>  it could be located elsewhere)::
>  
> -    $ ./x86_64-softmmu/qemu-system-x86_64 -display none -no-user-config \
> +    $ ./qemu-system-x86_64 -display none -no-user-config \
>          -M q35 -nodefaults -m 512 \
>          -blockdev node-name=node-TargetDisk,driver=qcow2,file.driver=file,file.node-name=file,file.filename=./target-disk.qcow2 \
>          -device virtio-blk,drive=node-TargetDisk,id=virtio0 \
> diff --git a/meson.build b/meson.build
> index 420e60b..797e69d 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -203,10 +203,12 @@ brlapi = not_found
>  if 'CONFIG_BRLAPI' in config_host
>    brlapi = declare_dependency(link_args: config_host['BRLAPI_LIBS'].split())
>  endif
> +sdlwindows = false
>  sdl = not_found
>  if 'CONFIG_SDL' in config_host
>    sdl = declare_dependency(compile_args: config_host['SDL_CFLAGS'].split(),
>                             link_args: config_host['SDL_LIBS'].split())
> +  sdlwindows = config_host['SDL_LIBS'].contains('-mwindows')
>  endif
>  rbd = not_found
>  if 'CONFIG_RBD' in config_host
> @@ -517,6 +519,7 @@ user_ss = ss.source_set()
>  bsd_user_ss = ss.source_set()
>  linux_user_ss = ss.source_set()
>  specific_ss = ss.source_set()
> +specific_fuzz_ss = ss.source_set()
>  
>  modules = {}
>  hw_arch = {}
> @@ -731,6 +734,7 @@ specific_ss.add_all(when: 'CONFIG_LINUX_USER', if_true: linux_user_ss)
>  
>  # needed for fuzzing binaries
>  subdir('tests/qtest/libqos')
> +subdir('tests/qtest/fuzz')
>  
>  mods = []
>  block_mods = []
> @@ -785,6 +789,9 @@ libqmp = static_library('qmp', qmp_ss.sources(),
>  
>  qmp = declare_dependency(link_whole: [libqmp])
>  
> +softmmu_ss.add(authz, block, chardev, crypto, io, qmp)
> +common_ss.add(qom, qemuutil)
> +
>  foreach m : mods
>    shared_module(m['dir'] + '-' + m['name'],
>                  name_prefix: '',
> @@ -793,7 +800,7 @@ foreach m : mods
>                  install_dir: config_host['qemu_moddir'])
>  endforeach
>  
> -common_ss.add_all(when: 'CONFIG_SOFTMMU', if_true: softmmu_ss)
> +common_ss.add_all(when: 'CONFIG_SOFTMMU', if_true: [softmmu_ss])
>  common_ss.add_all(when: 'CONFIG_USER_ONLY', if_true: user_ss)
>  
>  common_all = common_ss.apply(config_all, strict: false)
> @@ -805,11 +812,17 @@ common_all = static_library('common',
>  
>  feature_to_c = find_program('scripts/feature_to_c.sh')
>  
> +emulators = []
>  foreach target : target_dirs
>    config_target = config_target_mak[target]
>    target_name = config_target['TARGET_NAME']
>    arch = config_target['TARGET_BASE_ARCH']
>    arch_srcs = []
> +  arch_deps = []
> +  c_args = config_target['QEMU_CFLAGS'].split() + ['-DNEED_CPU_H',
> +                  '-DCONFIG_TARGET="@0@-config-target.h"'.format(target),
> +                  '-DCONFIG_DEVICES="@0@-config-devices.h"'.format(target)]
> +  link_args = config_target['QEMU_LDFLAGS'].split()
>  
>    target_inc = [include_directories('target' / config_target['TARGET_BASE_ARCH'])]
>    if host_machine.system() == 'linux'
> @@ -820,12 +833,15 @@ foreach target : target_dirs
>      target_type='system'
>      t = target_softmmu_arch[arch].apply(config_target, strict: false)
>      arch_srcs += t.sources()
> +    arch_deps += t.dependencies()
>  
>      hw_dir = target_name == 'sparc64' ? 'sparc64' : arch
>      hw = hw_arch[hw_dir].apply(config_target, strict: false)
>      arch_srcs += hw.sources()
> +    arch_deps += hw.dependencies()
>  
>      arch_srcs += config_devices_h[target]
> +    link_args += ['@block.syms', '@qemu.syms']
>    else
>      abi = config_target['TARGET_ABI_DIR']
>      target_type='user'
> @@ -862,9 +878,11 @@ foreach target : target_dirs
>  
>    t = target_arch[arch].apply(config_target, strict: false)
>    arch_srcs += t.sources()
> +  arch_deps += t.dependencies()
>  
>    target_common = common_ss.apply(config_target, strict: false)
>    objects = common_all.extract_objects(target_common.sources())
> +  deps = target_common.dependencies()
>  
>    # TODO: Change to generator once obj-y goes away
>    config_target_h = custom_target(target + '-config-target.h',
> @@ -875,15 +893,60 @@ foreach target : target_dirs
>  
>    target_specific = specific_ss.apply(config_target, strict: false)
>    arch_srcs += target_specific.sources()
> +  arch_deps += target_specific.dependencies()
>  
> -  static_library('qemu-' + target,
> +  lib = static_library('qemu-' + target,
>                   sources: arch_srcs + [config_target_h] + genh,
>                   objects: objects,
>                   include_directories: target_inc,
> -                 c_args: ['-DNEED_CPU_H',
> -                          '-DCONFIG_TARGET="@0@-config-target.h"'.format(target),
> -                          '-DCONFIG_DEVICES="@0@-config-devices.h"'.format(target)],
> +                 c_args: c_args,
> +                 build_by_default: false,
>                   name_suffix: 'fa')
> +
> +  if target.endswith('-softmmu')
> +    execs = [{
> +      'name': 'qemu-system-' + target_name,
> +      'gui': false,
> +      'sources': files('softmmu/main.c'),
> +      'dependencies': []
> +    }]
> +    if sdlwindows
> +      execs += [{
> +        'name': 'qemu-system-' + target_name + 'w',
> +        'gui': true,
> +        'sources': files('softmmu/main.c'),
> +        'dependencies': []
> +      }]
> +    endif
> +    if config_host.has_key('CONFIG_FUZZ')
> +      specific_fuzz = specific_fuzz_ss.apply(config_target, strict: false)
> +      execs += [{
> +        'name': 'qemu-fuzz-' + target_name,
> +        'gui': false,
> +        'sources': specific_fuzz.sources(),
> +        'dependencies': specific_fuzz.dependencies(),
> +        'link_depends': [files('tests/qtest/fuzz/fork_fuzz.ld')],
> +      }]
> +    endif
> +  else
> +    execs = [{
> +      'name': 'qemu-' + target_name,
> +      'gui': false,
> +      'sources': [],
> +      'dependencies': []
> +    }]
> +  endif
> +  foreach exe: execs
> +    emulators += executable(exe['name'], exe['sources'],
> +               install: true,
> +               c_args: c_args,
> +               dependencies: arch_deps + deps + exe['dependencies'],
> +               objects: lib.extract_all_objects(recursive: true),
> +               link_language: 'cpp',
> +               link_depends: [block_syms, qemu_syms] + exe.get('link_depends', []),
> +               link_args: link_args,
> +               gui_app: exe['gui'])
> +  endforeach
>  endforeach
>  
>  # Other build targets
> diff --git a/os-posix.c b/os-posix.c
> index 3572db3..8334193 100644
> --- a/os-posix.c
> +++ b/os-posix.c
> @@ -96,7 +96,7 @@ char *os_find_datadir(void)
>      exec_dir = qemu_get_exec_dir();
>      g_return_val_if_fail(exec_dir != NULL, NULL);
>  
> -    dir = g_build_filename(exec_dir, "..", "pc-bios", NULL);
> +    dir = g_build_filename(exec_dir, "pc-bios", NULL);
>      if (g_file_test(dir, G_FILE_TEST_IS_DIR)) {
>          return g_steal_pointer(&dir);
>      }
> diff --git a/plugins/meson.build b/plugins/meson.build
> index 9608e52..e777230 100644
> --- a/plugins/meson.build
> +++ b/plugins/meson.build
> @@ -1,5 +1,13 @@
> +if 'CONFIG_HAS_LD_DYNAMIC_LIST' in config_host
> +  plugin_ldflags = ['-Wl,--dynamic-list=' + (meson.build_root() / 'qemu-plugins-ld.symbols')]
> +elif 'CONFIG_HAS_LD_EXPORTED_SYMBOLS_LIST' in config_host
> +  plugin_ldflags = ['-Wl,-exported_symbols_list,' + (meson.build_root() / 'qemu-plugins-ld64.symbols')]
> +else
> +  plugin_ldflags = []
> +endif
> +
>  specific_ss.add(when: 'CONFIG_PLUGIN', if_true: [files(
>    'loader.c',
>    'core.c',
>    'api.c',
> -)])
> +), declare_dependency(link_args: plugin_ldflags)])
> diff --git a/rules.mak b/rules.mak
> index 8285fe5..6488dc3 100644
> --- a/rules.mak
> +++ b/rules.mak
> @@ -21,7 +21,6 @@ MAKEFLAGS += -rR
>  %.cpp:
>  %.m:
>  %.mak:
> -clean-target:
>  
>  # Flags for dependency generation
>  QEMU_DGFLAGS += -MMD -MP -MT $@ -MF $(@D)/$(*F).d
> diff --git a/scripts/device-crash-test b/scripts/device-crash-test
> index 305d042..866baf7 100755
> --- a/scripts/device-crash-test
> +++ b/scripts/device-crash-test
> @@ -383,7 +383,7 @@ def binariesToTest(args, testcase):
>      if args.qemu:
>          r = args.qemu
>      else:
> -        r = glob.glob('./*-softmmu/qemu-system-*')
> +        r = glob.glob('./qemu-system-*')
>      return r
>  
>  
> diff --git a/scripts/oss-fuzz/build.sh b/scripts/oss-fuzz/build.sh
> index 52430cb..f0b7442 100755
> --- a/scripts/oss-fuzz/build.sh
> +++ b/scripts/oss-fuzz/build.sh
> @@ -64,24 +64,26 @@ mkdir -p "$DEST_DIR/lib/"  # Copy the shared libraries here
>  
>  # Build once to get the list of dynamic lib paths, and copy them over
>  ../configure --disable-werror --cc="$CC" --cxx="$CXX" --enable-fuzzing \
> +    --prefix="$DEST_DIR" --bindir="$DEST_DIR" --datadir="$DEST_DIR/data/" \
>      --extra-cflags="$EXTRA_CFLAGS" --target-list="i386-softmmu"
>  
> -if ! make "-j$(nproc)" i386-softmmu/fuzz; then
> +if ! make "-j$(nproc)" qemu-fuzz-i386; then
>      fatal "Build failed. Please specify a compiler with fuzzing support"\
>            "using the \$CC and \$CXX environemnt variables"\
>            "\nFor example: CC=clang CXX=clang++ $0"
>  fi
>  
> -for i in $(ldd ./i386-softmmu/qemu-fuzz-i386 | cut -f3 -d' '); do
> +for i in $(ldd ./qemu-fuzz-i386 | cut -f3 -d' '); do
>      cp "$i" "$DEST_DIR/lib/"
>  done
> -rm ./i386-softmmu/qemu-fuzz-i386
> +rm qemu-fuzz-i386
>  
>  # Build a second time to build the final binary with correct rpath
> -../configure --bindir="$DEST_DIR" --datadir="$DEST_DIR/data/" --disable-werror \
> -    --cc="$CC" --cxx="$CXX" --extra-cflags="$EXTRA_CFLAGS" \
> -    --extra-ldflags="-Wl,-rpath,'\$\$ORIGIN/lib'"
> -make "-j$(nproc)" i386-softmmu/fuzz
> +../configure --disable-werror --cc="$CC" --cxx="$CXX" --enable-fuzzing \
> +    --prefix="$DEST_DIR" --bindir="$DEST_DIR" --datadir="$DEST_DIR/data/" \
> +    --extra-cflags="$EXTRA_CFLAGS" --extra-ldflags="-Wl,-rpath,'\$\$ORIGIN/lib'" \
> +    --target-list="i386-softmmu"
> +make "-j$(nproc)" qemu-fuzz-i386 V=1
>  
>  # Copy over the datadir
>  cp  -r ../pc-bios/ "$DEST_DIR/pc-bios"
> @@ -90,9 +92,9 @@ cp  -r ../pc-bios/ "$DEST_DIR/pc-bios"
>  # of available fuzz-targets. Copy over the qemu-fuzz-i386, naming it according
>  # to each available fuzz target (See 05509c8e6d fuzz: select fuzz target using
>  # executable name)
> -for target in $(./i386-softmmu/qemu-fuzz-i386 | awk '$1 ~ /\*/  {print $2}');
> +for target in $(./qemu-fuzz-i386 | awk '$1 ~ /\*/  {print $2}');
>  do
> -    cp ./i386-softmmu/qemu-fuzz-i386 "$DEST_DIR/qemu-fuzz-i386-target-$target"
> +    cp qemu-fuzz-i386 "$DEST_DIR/qemu-fuzz-i386-target-$target"
>  done
>  
>  echo "Done. The fuzzers are located in $DEST_DIR"
> diff --git a/softmmu/Makefile.objs b/softmmu/Makefile.objs
> deleted file mode 100644
> index ebcfd15..0000000
> --- a/softmmu/Makefile.objs
> +++ /dev/null
> @@ -1,2 +0,0 @@
> -softmmu-main-y = softmmu/main.o
> -main.o-cflags := $(GPROF_CFLAGS) $(SDL_CFLAGS)
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index b6d9661..c3874ca 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -457,7 +457,7 @@ build-tcg-tests-%: $(if $(CONFIG_PLUGIN),plugins)
>  	       	V="$(V)" TARGET="$*" guest-tests, \
>  		"BUILD", "TCG tests for $*")
>  
> -run-tcg-tests-%: build-tcg-tests-% %/all
> +run-tcg-tests-%: build-tcg-tests-% all
>  	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) \
>  		-f $(SRC_PATH)/tests/tcg/Makefile.qemu \
>  		SRC_PATH=$(SRC_PATH) SPEED="$(SPEED)" \
> @@ -485,7 +485,7 @@ QEMU_IOTESTS_HELPERS-$(call land,$(CONFIG_SOFTMMU),$(CONFIG_LINUX)) = tests/qemu
>  .PHONY: check-tests/check-block.sh
>  check-tests/check-block.sh: tests/check-block.sh qemu-img$(EXESUF) \
>  		qemu-io$(EXESUF) qemu-nbd$(EXESUF) $(QEMU_IOTESTS_HELPERS-y) \
> -		$(patsubst %,%/all,$(filter %-softmmu,$(TARGET_DIRS)))
> +		$(patsubst %-softmmu,qemu-system-%,$(filter %-softmmu,$(TARGET_DIRS)))
>  	@$<
>  
>  # Python venv for running tests
> diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance/avocado_qemu/__init__.py
> index 77d1c1d..db9c0f5 100644
> --- a/tests/acceptance/avocado_qemu/__init__.py
> +++ b/tests/acceptance/avocado_qemu/__init__.py
> @@ -57,8 +57,7 @@ def pick_default_qemu_bin(arch=None):
>      # qemu binary path does not match arch for powerpc, handle it
>      if 'ppc64le' in arch:
>          arch = 'ppc64'
> -    qemu_bin_relative_path = os.path.join("%s-softmmu" % arch,
> -                                          "qemu-system-%s" % arch)
> +    qemu_bin_relative_path = "./qemu-system-%s" % arch
>      if is_readable_executable_file(qemu_bin_relative_path):
>          return qemu_bin_relative_path
>  
> diff --git a/tests/data/acpi/rebuild-expected-aml.sh b/tests/data/acpi/rebuild-expected-aml.sh
> index 76cd797..fc78770 100755
> --- a/tests/data/acpi/rebuild-expected-aml.sh
> +++ b/tests/data/acpi/rebuild-expected-aml.sh
> @@ -12,7 +12,7 @@
>  # This work is licensed under the terms of the GNU GPLv2.
>  # See the COPYING.LIB file in the top-level directory.
>  
> -qemu_bins="x86_64-softmmu/qemu-system-x86_64 aarch64-softmmu/qemu-system-aarch64"
> +qemu_bins="./qemu-system-x86_64 ./qemu-system-aarch64"
>  
>  if [ ! -e "tests/qtest/bios-tables-test" ]; then
>      echo "Test: bios-tables-test is required! Run make check before this script."
> diff --git a/tests/multiboot/run_test.sh b/tests/multiboot/run_test.sh
> index 98df91e..f968bf7 100755
> --- a/tests/multiboot/run_test.sh
> +++ b/tests/multiboot/run_test.sh
> @@ -20,7 +20,7 @@
>  # OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
>  # THE SOFTWARE.
>  
> -QEMU=${QEMU:-"../../x86_64-softmmu/qemu-system-x86_64"}
> +QEMU=${QEMU:-"../../qemu-system-x86_64"}
>  
>  run_qemu() {
>      local kernel=$1
> diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
> index 0657f72..3ab859a 100755
> --- a/tests/qemu-iotests/check
> +++ b/tests/qemu-iotests/check
> @@ -577,11 +577,11 @@ if [ -z "$QEMU_PROG" ]
>  then
>      if [ -x "$build_iotests/qemu" ]; then
>          export QEMU_PROG="$build_iotests/qemu"
> -    elif [ -x "$build_root/${qemu_arch}-softmmu/qemu-system-${qemu_arch}" ]; then
> -        export QEMU_PROG="$build_root/${qemu_arch}-softmmu/qemu-system-${qemu_arch}"
> +    elif [ -x "$build_root/qemu-system-${qemu_arch}" ]; then
> +        export QEMU_PROG="$build_root/qemu-system-${qemu_arch}"
>      else
>          pushd "$build_root" > /dev/null
> -        for binary in *-softmmu/qemu-system-*
> +        for binary in qemu-system-*
>          do
>              if [ -x "$binary" ]
>              then
> diff --git a/tests/qtest/fuzz/Makefile.include b/tests/qtest/fuzz/Makefile.include
> deleted file mode 100644
> index 5bde793..0000000
> --- a/tests/qtest/fuzz/Makefile.include
> +++ /dev/null
> @@ -1,39 +0,0 @@
> -QEMU_PROG_FUZZ=qemu-fuzz-$(TARGET_NAME)$(EXESUF)
> -
> -fuzz-obj-y += tests/qtest/libqtest.o
> -fuzz-obj-y += $(libqos-obj-y)
> -fuzz-obj-y += tests/qtest/fuzz/fuzz.o # Fuzzer skeleton
> -fuzz-obj-y += tests/qtest/fuzz/fork_fuzz.o
> -fuzz-obj-y += tests/qtest/fuzz/qos_fuzz.o
> -fuzz-obj-y += tests/qtest/fuzz/qtest_wrappers.o
> -
> -# Targets
> -fuzz-obj-$(CONFIG_PCI_I440FX) += tests/qtest/fuzz/i440fx_fuzz.o
> -fuzz-obj-$(CONFIG_VIRTIO_NET) += tests/qtest/fuzz/virtio_net_fuzz.o
> -fuzz-obj-$(CONFIG_SCSI) += tests/qtest/fuzz/virtio_scsi_fuzz.o
> -
> -FUZZ_CFLAGS += -I$(SRC_PATH)/tests -I$(SRC_PATH)/tests/qtest
> -
> -# Linker Script to force coverage-counters into known regions which we can mark
> -# shared
> -FUZZ_LDFLAGS += -Xlinker -T$(SRC_PATH)/tests/qtest/fuzz/fork_fuzz.ld
> -
> -FUZZ_LDFLAGS += -Wl,-wrap,qtest_inb
> -FUZZ_LDFLAGS += -Wl,-wrap,qtest_inw
> -FUZZ_LDFLAGS += -Wl,-wrap,qtest_inl
> -FUZZ_LDFLAGS += -Wl,-wrap,qtest_outb
> -FUZZ_LDFLAGS += -Wl,-wrap,qtest_outw
> -FUZZ_LDFLAGS += -Wl,-wrap,qtest_outl
> -FUZZ_LDFLAGS += -Wl,-wrap,qtest_readb
> -FUZZ_LDFLAGS += -Wl,-wrap,qtest_readw
> -FUZZ_LDFLAGS += -Wl,-wrap,qtest_readl
> -FUZZ_LDFLAGS += -Wl,-wrap,qtest_readq
> -FUZZ_LDFLAGS += -Wl,-wrap,qtest_writeb
> -FUZZ_LDFLAGS += -Wl,-wrap,qtest_writew
> -FUZZ_LDFLAGS += -Wl,-wrap,qtest_writel
> -FUZZ_LDFLAGS += -Wl,-wrap,qtest_writeq
> -FUZZ_LDFLAGS += -Wl,-wrap,qtest_memread
> -FUZZ_LDFLAGS += -Wl,-wrap,qtest_bufread
> -FUZZ_LDFLAGS += -Wl,-wrap,qtest_memwrite
> -FUZZ_LDFLAGS += -Wl,-wrap,qtest_bufwrite
> -FUZZ_LDFLAGS += -Wl,-wrap,qtest_memset
> diff --git a/tests/qtest/fuzz/i440fx_fuzz.c b/tests/qtest/fuzz/i440fx_fuzz.c
> index f45373f..86796bf 100644
> --- a/tests/qtest/fuzz/i440fx_fuzz.c
> +++ b/tests/qtest/fuzz/i440fx_fuzz.c
> @@ -17,8 +17,8 @@
>  #include "tests/qtest/libqos/pci.h"
>  #include "tests/qtest/libqos/pci-pc.h"
>  #include "fuzz.h"
> -#include "fuzz/qos_fuzz.h"
> -#include "fuzz/fork_fuzz.h"
> +#include "qos_fuzz.h"
> +#include "fork_fuzz.h"
>  
>  
>  #define I440FX_PCI_HOST_BRIDGE_CFG 0xcf8
> diff --git a/tests/qtest/fuzz/meson.build b/tests/qtest/fuzz/meson.build
> new file mode 100644
> index 0000000..bb0a3f2
> --- /dev/null
> +++ b/tests/qtest/fuzz/meson.build
> @@ -0,0 +1,35 @@
> +specific_fuzz_ss.add(files('fuzz.c', 'fork_fuzz.c', 'qos_fuzz.c',
> +                           'qtest_wrappers.c'), qos)
> +
> +# Targets
> +specific_fuzz_ss.add(when: 'CONFIG_I440FX', if_true: files('i440fx_fuzz.c'))
> +specific_fuzz_ss.add(when: 'CONFIG_VIRTIO_NET', if_true: files('virtio_net_fuzz.c'))
> +specific_fuzz_ss.add(when: 'CONFIG_VIRTIO_SCSI', if_true: files('virtio_scsi_fuzz.c'))
> +
> +# unfortunately declare_dependency does not support link_depends, so
> +# this will be duplicated in meson.build
> +fork_fuzz = declare_dependency(
> +  link_args: ['-fsanitize=fuzzer',
> +              '-Wl,-T,' + (meson.current_source_dir() / 'fork_fuzz.ld'),
> +              '-Wl,-wrap,qtest_inb',
> +              '-Wl,-wrap,qtest_inw',
> +              '-Wl,-wrap,qtest_inl',
> +              '-Wl,-wrap,qtest_outb',
> +              '-Wl,-wrap,qtest_outw',
> +              '-Wl,-wrap,qtest_outl',
> +              '-Wl,-wrap,qtest_readb',
> +              '-Wl,-wrap,qtest_readw',
> +              '-Wl,-wrap,qtest_readl',
> +              '-Wl,-wrap,qtest_readq',
> +              '-Wl,-wrap,qtest_writeb',
> +              '-Wl,-wrap,qtest_writew',
> +              '-Wl,-wrap,qtest_writel',
> +              '-Wl,-wrap,qtest_writeq',
> +              '-Wl,-wrap,qtest_memread',
> +              '-Wl,-wrap,qtest_bufread',
> +              '-Wl,-wrap,qtest_memwrite',
> +              '-Wl,-wrap,qtest_bufwrite',
> +              '-Wl,-wrap,qtest_memset']
> +)
> +
> +specific_fuzz_ss.add(fork_fuzz)
> diff --git a/tests/qtest/fuzz/qtest_wrappers.c b/tests/qtest/fuzz/qtest_wrappers.c
> index 713c830..0580f8d 100644
> --- a/tests/qtest/fuzz/qtest_wrappers.c
> +++ b/tests/qtest/fuzz/qtest_wrappers.c
> @@ -12,7 +12,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> -#include "cpu.h"
> +#include "hw/core/cpu.h"
>  #include "exec/ioport.h"
>  
>  #include "fuzz.h"
> diff --git a/tests/qtest/fuzz/virtio_net_fuzz.c b/tests/qtest/fuzz/virtio_net_fuzz.c
> index 277a9e2..0e873ab 100644
> --- a/tests/qtest/fuzz/virtio_net_fuzz.c
> +++ b/tests/qtest/fuzz/virtio_net_fuzz.c
> @@ -61,7 +61,8 @@ static void virtio_net_fuzz_multi(QTestState *s,
>           * backend. Otherwise, always place the input on a virtqueue.
>           */
>          if (vqa.rx && sockfds_initialized) {
> -            write(sockfds[0], Data, vqa.length);
> +            int ignored = write(sockfds[0], Data, vqa.length);
> +            (void) ignored;
>          } else {
>              vqa.rx = 0;
>              uint64_t req_addr = guest_alloc(t_alloc, vqa.length);
> diff --git a/tests/qtest/fuzz/virtio_scsi_fuzz.c b/tests/qtest/fuzz/virtio_scsi_fuzz.c
> index 3a9ea13..6ff6fab 100644
> --- a/tests/qtest/fuzz/virtio_scsi_fuzz.c
> +++ b/tests/qtest/fuzz/virtio_scsi_fuzz.c
> @@ -12,10 +12,10 @@
>  
>  #include "qemu/osdep.h"
>  
> -#include "tests/qtest/libqtest.h"
> -#include "libqos/virtio-scsi.h"
> -#include "libqos/virtio.h"
> -#include "libqos/virtio-pci.h"
> +#include "tests/qtest/libqos/libqtest.h"
> +#include "tests/qtest/libqos/virtio-scsi.h"
> +#include "tests/qtest/libqos/virtio.h"
> +#include "tests/qtest/libqos/virtio-pci.h"
>  #include "standard-headers/linux/virtio_ids.h"
>  #include "standard-headers/linux/virtio_pci.h"
>  #include "standard-headers/linux/virtio_scsi.h"
> diff --git a/tests/qtest/libqos/qgraph.h b/tests/qtest/libqos/qgraph.h
> index 1054326..5f63d35 100644
> --- a/tests/qtest/libqos/qgraph.h
> +++ b/tests/qtest/libqos/qgraph.h
> @@ -226,7 +226,7 @@ typedef void *(*QOSBeforeTest) (GString *cmd_line, void *arg);
>   *        my_test <--consumed_by-- my_interface <--produces--+
>   *
>   * Assuming there the binary is
> - * QTEST_QEMU_BINARY=x86_64-softmmu/qemu-system-x86_64
> + * QTEST_QEMU_BINARY=./qemu-system-x86_64
>   * a valid test path will be:
>   * "/x86_64/pc/other_node/my_driver/my_interface/my_test".
>   *
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 30cb88d..8f8fdb1 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -234,7 +234,7 @@ foreach dir : target_dirs
>    qtest_env = environment()
>    qtest_env.set('QTEST_QEMU_IMG', './qemu-img')
>    qtest_env.set('G_TEST_DBUS_DAEMON', meson.source_root() / 'tests/dbus-vmstate-daemon.sh')
> -  qtest_env.set('QTEST_QEMU_BINARY', '@0@-softmmu/qemu-system-@0@'.format(target_base))
> +  qtest_env.set('QTEST_QEMU_BINARY', './qemu-system-' + target_base)
>    
>    foreach test : qtests
>      # Executables are shared across targets, declare them only the first time we
> diff --git a/tests/qtest/rtas-test.c b/tests/qtest/rtas-test.c
> index a7e83e7..16751db 100644
> --- a/tests/qtest/rtas-test.c
> +++ b/tests/qtest/rtas-test.c
> @@ -31,7 +31,7 @@ int main(int argc, char *argv[])
>      g_test_init(&argc, &argv, NULL);
>  
>      if (strcmp(arch, "ppc64")) {
> -        g_printerr("RTAS requires ppc64-softmmu/qemu-system-ppc64\n");
> +        g_printerr("RTAS requires qemu-system-ppc64\n");
>          exit(EXIT_FAILURE);
>      }
>      qtest_add_func("rtas/get-time-of-day", test_rtas_get_time_of_day);
> diff --git a/tests/tcg/configure.sh b/tests/tcg/configure.sh
> index 102578c..7d714f9 100755
> --- a/tests/tcg/configure.sh
> +++ b/tests/tcg/configure.sh
> @@ -193,11 +193,11 @@ for target in $target_list; do
>    case $target in
>      *-linux-user | *-bsd-user)
>        echo "CONFIG_USER_ONLY=y" >> $config_target_mak
> -      echo "QEMU=\$(BUILD_DIR)/$target/qemu-$arch" >> $config_target_mak
> +      echo "QEMU=\$(BUILD_DIR)/qemu-$arch" >> $config_target_mak
>        ;;
>      *-softmmu)
>        echo "CONFIG_SOFTMMU=y" >> $config_target_mak
> -      echo "QEMU=\$(BUILD_DIR)/$target/qemu-system-$arch" >> $config_target_mak
> +      echo "QEMU=\$(BUILD_DIR)/qemu-system-$arch" >> $config_target_mak
>        ;;
>    esac
>  
> -- 
> 1.8.3.1
> 
> 
> 

