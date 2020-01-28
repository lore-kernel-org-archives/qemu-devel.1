Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD50C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 17:56:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1EE22173E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 17:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X2I4B8vA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1EE22173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwV6N-0000wH-U5
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 12:56:39 -0500
Received: from [2001:470:142:3::10] (port=57119 helo=eggs.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV3m-0005gb-6l
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:54:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV3h-0007Bj-7f
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:53:58 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:39649)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV3g-000762-R6
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:53:53 -0500
Received: by mail-wm1-x32f.google.com with SMTP id c84so3550490wme.4
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=XzJlXAY2DfqUZGBA2GP68aMzTx5cQDd8rZYVjMaocWE=;
 b=X2I4B8vAO0kZK8kJXIZGvKCwIqHh3BDpODB0fIJHpMY5Mrf9biswgVk7xrkuMw4Cvi
 pO4GJozq5suBvSuJFl0yNh9BG/nXzbrVMEu9uca0Lb7UxcPWg/Y3XaJpgqtQFpH8Okgh
 PA/aIy1JQVJ4SxdpRPVLmXwsY0swo+gIDdeRmmei4MhrceFuaZ6GfIoLaA/TihS3HkwC
 NA9bOd3pfq8YeQ0X966ICl6mJZ37cGrUhescQ1ZmuqxdtDo2Hyv06/Uc6mMvkagleeFz
 tycSClwRTtFI4ADYspQK2yccKNe6TVQrB3Hs81MsAo7dGWvfaWk/hSyZgoB1fKKBFPI8
 xYvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=XzJlXAY2DfqUZGBA2GP68aMzTx5cQDd8rZYVjMaocWE=;
 b=lNxzTsh/rTnr5oSosXprilnkizozD4rdG4UXTJaolZLPmzbTMJRHGojqdRwqOvx9Oh
 RJ2PuyeWJe6B12+dpwR4vO6K3V1fxZfKBCDIx4iJ9F3mVI6l7L+SWOdWrtpUflwVwfyY
 dmh5YOC95uLxggYvl1dKmQrJGC+zQWlfAkXVI6QJP/dNXXjx2/14bseSB5Tj/snyEZWI
 zWagZE+fVCT/VK5APQNCA9LdZjtfiKZT/et8IDI57cIaOqe56RyGDSeBdm8RT2hHbTbL
 2pYZ86ETAhET3jAzYPomHk5McXWtqjFdarak2nb7aTCFV8tZMjWgCKKy6qHKHdB2oqSz
 8UFw==
X-Gm-Message-State: APjAAAXRXS3X1q+oTY3ebXQe2soE9JwKyWRC6re7lNFm58NSpM84SFu/
 HfgHYVR1NAz8fLUkthLj36Xt04Na
X-Google-Smtp-Source: APXvYqyvFjrTKBmnedRQpB++d4z2jkVU8Eye9QaWyEC8OhsAmOeO2DB20d+FJtLvmS+CzJuCU1dAWg==
X-Received: by 2002:a7b:cc6a:: with SMTP id n10mr6349770wmj.170.1580234029736; 
 Tue, 28 Jan 2020 09:53:49 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.53.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:53:49 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v4 000/142] Proof of concept for Meson integration
Date: Tue, 28 Jan 2020 18:51:20 +0100
Message-Id: <20200128175342.9066-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32f
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

Changes since https://patchew.org/QEMU/1576155176-2464-1-git-send-email-pbonzini@redhat.com/:

- updated to upstream commit
b0b74e1f17508cb8cef8afd698558db1bd8999cc ("Merge remote-tracking
branch 'remotes/ehabkost/tags/python-next-pull-request' into staging",
2020-01-06)

- includes the test() driver and the conversion of several testsuites

- a bunch of fixes

One slightly yucky thing that emerged is that Meson does not like .inc.c
for files that are included, so these are renamed to .inc.

In any case, after having spent quite some time rebasing the branch,
I can say with confidence that it is not really ever necessary to read
either build.ninja or the Makefile conversion (Makefile.ninja).

Sphinx build is basically untested.  Long term it may make sense to
add support for Sphinx directly to Meson.

Left to do before merging:

- Try to get rid of CONFIG_DEVICES and CONFIG_TARGET (should be possible
  using "generator()").

- Check which of the remaining junk can be removed from rules.mak

- Keep rebasing

- Move the configure script's summary to meson.build, using the new
  summary() function (https://mesonbuild.com/Reference-manual.html#summary)

- Test Sphinx and more supported platforms

- Fix Meson warnings

- Update build-system.txt

- Check if "ninja" and "meson test" work, even though "make" is expected
  to stay.

Please review more than the previous version. :)

Paolo

Marc-André Lureau (116):
  minikconf: accept alnum identifiers
  optionrom: simplify Makefile
  build-sys hack: ensure target directory is there
  configure: expand path variables for meson configure
  configure: generate Meson cross file
  build-sys: add meson submodule
  meson: enable pie
  meson: use coverage option
  meson: add remaining generated tcg trace helpers
  meson: add version.o
  contrib/vhost-user-input: convert to meson
  contrib/vhost-user-gpu: convert to meson
  contrib/ivshmem: convert to meson
  contrib/elf2dmp: convert to meson
  meson: convert vss-win32
  meson: add msi generation
  meson: add qemu-bridge-helper
  meson: add qemu-keymap
  meson: add qemu-edid
  meson: add virtfs-proxy-helper
  meson: keymap-gen
  meson: generate qemu-version.h
  meson: generate shader headers
  meson: generate hxtool files
  meson: configure 50-qemu-gpu.json
  meson: uncompress edk2 bios
  build-sys hack: link with whole .fa archives
  meson: convert qom directory to Meson
  meson: convert authz directory to Meson
  meson: convert crypto directory to Meson
  meson: convert io directory to Meson
  meson: convert target/s390x/gen-features.h
  meson: infrastructure for building emulators
  meson: add macos dependencies
  meson: add modules infrastructure
  meson: convert chardev directory to Meson (tools part)
  meson: convert block
  meson: qemu-{img,io,nbd}
  meson: qemu-pr-helper
  meson: convert ui directory to Meson
  meson: convert trace/
  meson: convert qom/
  meson: convert block/
  meson: convert dump/
  meson: convert monitor directory to Meson
  meson: convert replay directory to Meson
  meson: convert migration directory to Meson
  meson: build softmmu-specific migration/ram.c
  meson: convert net directory to Meson
  meson: convert backends directory to Meson
  meson: convert fsdev/
  meson: convert disas directory to Meson
  meson: convert qapi-specific to meson
  meson: convert hw/xen
  meson: convert hw/core
  meson: convert hw/smbios
  meson: convert hw/mem
  meson: convert hw/watchdog
  meson: convert hw/virtio
  meson: convert hw/vfio
  meson: convert hw/usb
  meson: convert hw/tpm
  meson: convert hw/ssi
  meson: convert hw/sd
  meson: convert hw/scsi
  meson: convert hw/pcmcia
  meson: convert hw/pci-host
  meson: convert hw/pci-bridge
  meson: convert hw/pci
  meson: convert hw/nvram
  meson: convert hw/rdma
  meson: convert hw/net
  meson: convert hw/misc
  meson: convert hw/isa
  meson: convert hw/ipmi
  meson: convert hw/ipack
  meson: convert hw/intc
  meson: convert hw/input
  meson: convert hw/ide
  meson: convert hw/i2c
  meson: convert hw/hyperv
  meson: convert hw/gpio
  meson: convert hw/dma
  meson: convert hw/display
  meson: convert hw/cpu
  meson: convert hw/char
  meson: convert hw/block
  meson: convert hw/audio
  meson: convert hw/adc
  meson: convert hw/acpi
  meson: convert hw/9pfs
  meson: convert hw/arch*
  meson: target
  meson: accel
  meson: linux-user
  meson: bsd-user
  meson: cpu-emu
  meson: softmmu
  Aaaaallelujah!
  systemtap
  build-sys/rules.mak: remove version.o
  meson: sphinx-build
  meson: generate version.texi
  meson: build texi doc
  meson: add NSIS building
  meson: install some scripts
  meson: install edk2
  meson: install blobs
  meson: install edk2 json descriptors
  meson: install icons
  meson: install desktop file
  meson: convert pc-bios/keymaps/Makefile
  meson: convert po/
  meson: replace mostly useless pc-bios/Makefile
  meson: convert pc-bios/s390-ccw
  meson: convert pc-bios/optionrom

Paolo Bonzini (26):
  pc-bios/s390-ccw: simplify Makefile
  configure: do not include $(...) variables in config-host.mak
  configure: integrate Meson in the build system
  meson: add testsuite Makefile generator
  libqemuutil: convert to meson
  contrib/libvhost-user: convert to Meson
  contrib/vhost-user-blk: convert to Meson
  contrib/vhost-user-scsi: convert to Meson
  contrib/rdmacm-mux: convert to Meson
  meson: convert qemu-ga
  meson: convert dummy Windows qga/qemu-ga target
  configure, Makefile; remove TOOLS and HELPERS-y variable
  meson: convert chardev directory to Meson (emulator part)
  meson: convert audio directory to Meson
  meson: convert root directory to Meson
  meson: convert hw/semihosting
  meson: convert hw/nubus
  meson: convert hw/timer
  meson: convert hw/rtc
  meson: plugins
  remove Makefile.target
  rules.mak: drop unneeded macros
  meson: convert check-block
  meson: convert check-decodetree
  meson: convert tests/fp and check-softfloat
  meson: convert check-qapi-schema

 .gitignore                                |    3 +-
 .gitlab-ci.yml                            |    6 +-
 .gitmodules                               |    3 +
 Kconfig.host                              |    1 +
 Makefile                                  |  989 +------------------
 Makefile.objs                             |  221 +----
 Makefile.target                           |  258 -----
 accel/Makefile.objs                       |    5 -
 accel/kvm/Makefile.objs                   |    2 -
 accel/kvm/meson.build                     |    5 +
 accel/kvm/trace.h                         |    1 +
 accel/meson.build                         |    6 +
 accel/stubs/Makefile.objs                 |    5 -
 accel/stubs/meson.build                   |    5 +
 accel/tcg/Makefile.objs                   |    9 -
 accel/tcg/meson.build                     |   15 +
 accel/tcg/trace.h                         |    1 +
 audio/Makefile.objs                       |   30 -
 audio/meson.build                         |   29 +
 audio/trace.h                             |    1 +
 authz/Makefile.objs                       |    7 -
 authz/meson.build                         |   18 +
 authz/trace.h                             |    1 +
 backends/Makefile.objs                    |   19 -
 backends/meson.build                      |   17 +
 balloon.c                                 |    2 +-
 block.c                                   |    2 +-
 block/Makefile.objs                       |   69 --
 block/meson.build                         |  106 ++
 block/trace.h                             |    1 +
 bsd-user/Makefile.objs                    |    2 -
 bsd-user/meson.build                      |   10 +
 chardev/Makefile.objs                     |   25 -
 chardev/meson.build                       |   36 +
 chardev/trace.h                           |    1 +
 configure                                 |  318 ++++--
 contrib/elf2dmp/Makefile.objs             |    4 -
 contrib/elf2dmp/meson.build               |    4 +
 contrib/ivshmem-client/Makefile.objs      |    1 -
 contrib/ivshmem-client/meson.build        |    3 +
 contrib/ivshmem-server/Makefile.objs      |    1 -
 contrib/ivshmem-server/meson.build        |    3 +
 contrib/libvhost-user/Makefile.objs       |    1 -
 contrib/libvhost-user/meson.build         |    2 +
 contrib/rdmacm-mux/Makefile.objs          |    3 -
 contrib/rdmacm-mux/meson.build            |    6 +
 contrib/vhost-user-blk/meson.build        |    3 +
 contrib/vhost-user-gpu/Makefile.objs      |   10 -
 contrib/vhost-user-gpu/meson.build        |   10 +
 contrib/vhost-user-input/Makefile.objs    |    1 -
 contrib/vhost-user-input/meson.build      |    3 +
 contrib/vhost-user-scsi/Makefile.objs     |    1 -
 contrib/vhost-user-scsi/meson.build       |    5 +
 crypto/Makefile.objs                      |   39 -
 crypto/meson.build                        |   57 ++
 crypto/trace.h                            |    1 +
 disas/Makefile.objs                       |   30 -
 disas/libvixl/Makefile.objs               |    5 -
 disas/libvixl/meson.build                 |    7 +
 disas/meson.build                         |   27 +
 dma-helpers.c                             |    2 +-
 docs/devel/blkverify.txt                  |    4 +-
 docs/devel/build-system.txt               |    5 +-
 docs/devel/testing.rst                    |   11 +-
 docs/devel/tracing.txt                    |    2 +-
 docs/interop/live-block-operations.rst    |    4 +-
 docs/interop/qemu-ga-ref.texi             |    2 +-
 docs/interop/qemu-qmp-ref.texi            |    2 +-
 docs/meson.build                          |   93 ++
 docs/version.texi.in                      |    2 +
 dump/Makefile.objs                        |    3 -
 dump/meson.build                          |    4 +
 exec.c                                    |    2 +-
 fsdev/Makefile.objs                       |   12 -
 fsdev/meson.build                         |   14 +
 gdbstub.c                                 |    2 +-
 hw/9pfs/Kconfig                           |    4 +
 hw/9pfs/Makefile.objs                     |    9 -
 hw/9pfs/meson.build                       |   20 +
 hw/9pfs/trace.h                           |    1 +
 hw/Makefile.objs                          |   46 -
 hw/acpi/Makefile.objs                     |   24 -
 hw/acpi/meson.build                       |   22 +
 hw/acpi/trace.h                           |    1 +
 hw/adc/Makefile.objs                      |    1 -
 hw/adc/meson.build                        |    1 +
 hw/alpha/Makefile.objs                    |    1 -
 hw/alpha/meson.build                      |    8 +
 hw/alpha/trace.h                          |    1 +
 hw/arm/Makefile.objs                      |   53 -
 hw/arm/meson.build                        |   56 ++
 hw/arm/trace.h                            |    1 +
 hw/audio/Makefile.objs                    |   18 -
 hw/audio/meson.build                      |   14 +
 hw/audio/trace.h                          |    1 +
 hw/block/Makefile.objs                    |   18 -
 hw/block/dataplane/Makefile.objs          |    2 -
 hw/block/dataplane/meson.build            |    2 +
 hw/block/dataplane/trace.h                |    1 +
 hw/block/meson.build                      |   21 +
 hw/block/trace.h                          |    1 +
 hw/char/Makefile.objs                     |   36 -
 hw/char/meson.build                       |   34 +
 hw/char/trace.h                           |    1 +
 hw/core/Makefile.objs                     |   30 -
 hw/core/cpu.c                             |    2 +-
 hw/core/meson.build                       |   39 +
 hw/cpu/Makefile.objs                      |    5 -
 hw/cpu/meson.build                        |    6 +
 hw/cris/Makefile.objs                     |    2 -
 hw/cris/meson.build                       |    5 +
 hw/display/Makefile.objs                  |   61 --
 hw/display/meson.build                    |   56 ++
 hw/display/trace.h                        |    1 +
 hw/dma/Makefile.objs                      |   16 -
 hw/dma/meson.build                        |   16 +
 hw/dma/trace.h                            |    1 +
 hw/gpio/Makefile.objs                     |   12 -
 hw/gpio/meson.build                       |   12 +
 hw/gpio/trace.h                           |    1 +
 hw/hppa/Makefile.objs                     |    1 -
 hw/hppa/meson.build                       |    4 +
 hw/hppa/trace.h                           |    1 +
 hw/hyperv/Makefile.objs                   |    2 -
 hw/hyperv/meson.build                     |    2 +
 hw/i2c/Makefile.objs                      |   13 -
 hw/i2c/meson.build                        |   18 +
 hw/i2c/trace.h                            |    1 +
 hw/i386/fw_cfg.c                          |    2 +-
 hw/i386/kvm/Makefile.objs                 |    5 -
 hw/i386/kvm/meson.build                   |    8 +
 hw/i386/meson.build                       |   25 +
 hw/i386/pc.c                              |    2 +-
 hw/i386/pc_piix.c                         |    2 +-
 hw/i386/trace.h                           |    1 +
 hw/i386/x86.c                             |    2 +-
 hw/i386/xen/Makefile.objs                 |    1 -
 hw/i386/xen/meson.build                   |    7 +
 hw/i386/xen/trace.h                       |    1 +
 hw/ide/Makefile.objs                      |   14 -
 hw/ide/meson.build                        |   14 +
 hw/ide/trace.h                            |    1 +
 hw/input/Makefile.objs                    |   17 -
 hw/input/meson.build                      |   17 +
 hw/input/trace.h                          |    1 +
 hw/intc/Makefile.objs                     |   51 -
 hw/intc/meson.build                       |   52 +
 hw/intc/trace.h                           |    1 +
 hw/ipack/Makefile.objs                    |    2 -
 hw/ipack/meson.build                      |    1 +
 hw/ipmi/Makefile.objs                     |    8 -
 hw/ipmi/meson.build                       |   11 +
 hw/isa/Makefile.objs                      |   11 -
 hw/isa/meson.build                        |   11 +
 hw/isa/trace.h                            |    1 +
 hw/lm32/Makefile.objs                     |    3 -
 hw/lm32/meson.build                       |    6 +
 hw/m68k/meson.build                       |    7 +
 hw/mem/Kconfig                            |    1 +
 hw/mem/meson.build                        |    6 +
 hw/mem/trace.h                            |    1 +
 hw/meson.build                            |   65 ++
 hw/microblaze/Makefile.objs               |    4 -
 hw/microblaze/meson.build                 |    7 +
 hw/mips/Makefile.objs                     |    8 -
 hw/mips/meson.build                       |   11 +
 hw/mips/trace.h                           |    1 +
 hw/misc/Makefile.objs                     |   84 --
 hw/misc/macio/Makefile.objs               |    5 -
 hw/misc/macio/meson.build                 |    8 +
 hw/misc/macio/trace.h                     |    1 +
 hw/misc/meson.build                       |   88 ++
 hw/misc/trace.h                           |    1 +
 hw/moxie/Makefile.objs                    |    2 -
 hw/moxie/meson.build                      |    4 +
 hw/net/Makefile.objs                      |   54 -
 hw/net/can/Makefile.objs                  |    4 -
 hw/net/can/meson.build                    |    4 +
 hw/net/meson.build                        |   62 ++
 hw/net/trace.h                            |    1 +
 hw/nios2/Makefile.objs                    |    3 -
 hw/nios2/meson.build                      |    6 +
 hw/nubus/Makefile.objs                    |    4 -
 hw/nubus/meson.build                      |    7 +
 hw/nvram/Makefile.objs                    |    8 -
 hw/nvram/meson.build                      |   11 +
 hw/nvram/trace.h                          |    1 +
 hw/openrisc/Makefile.objs                 |    2 -
 hw/openrisc/meson.build                   |    5 +
 hw/pci-bridge/Makefile.objs               |   10 -
 hw/pci-bridge/meson.build                 |   14 +
 hw/pci-host/Makefile.objs                 |   22 -
 hw/pci-host/meson.build                   |   23 +
 hw/pci-host/trace.h                       |    1 +
 hw/pci/Makefile.objs                      |   14 -
 hw/pci/meson.build                        |   19 +
 hw/pci/trace.h                            |    1 +
 hw/pcmcia/Makefile.objs                   |    2 -
 hw/pcmcia/meson.build                     |    2 +
 hw/ppc/Makefile.objs                      |   36 -
 hw/ppc/meson.build                        |   82 ++
 hw/ppc/trace.h                            |    1 +
 hw/rdma/Makefile.objs                     |    3 -
 hw/rdma/meson.build                       |   10 +
 hw/rdma/trace.h                           |    1 +
 hw/rdma/vmw/trace.h                       |    1 +
 hw/riscv/Makefile.objs                    |   15 -
 hw/riscv/meson.build                      |   18 +
 hw/riscv/trace.h                          |    1 +
 hw/rtc/Makefile.objs                      |   13 -
 hw/rtc/meson.build                        |   14 +
 hw/rtc/trace.h                            |    1 +
 hw/s390x/Makefile.objs                    |   36 -
 hw/s390x/meson.build                      |   45 +
 hw/s390x/trace.h                          |    1 +
 hw/scsi/Makefile.objs                     |   15 -
 hw/scsi/meson.build                       |   26 +
 hw/scsi/trace.h                           |    1 +
 hw/sd/Makefile.objs                       |   11 -
 hw/sd/meson.build                         |   11 +
 hw/sd/trace.h                             |    1 +
 hw/semihosting/Makefile.objs              |    2 -
 hw/semihosting/meson.build                |    4 +
 hw/sh4/Makefile.objs                      |    4 -
 hw/sh4/meson.build                        |   10 +
 hw/smbios/Makefile.objs                   |   10 -
 hw/smbios/meson.build                     |   13 +
 hw/sparc/Makefile.objs                    |    3 -
 hw/sparc/meson.build                      |    6 +
 hw/sparc/trace.h                          |    1 +
 hw/sparc64/Makefile.objs                  |    4 -
 hw/sparc64/meson.build                    |    6 +
 hw/sparc64/trace.h                        |    1 +
 hw/ssi/Makefile.objs                      |   10 -
 hw/ssi/meson.build                        |   10 +
 hw/timer/Makefile.objs                    |   37 -
 hw/timer/meson.build                      |   33 +
 hw/timer/trace.h                          |    1 +
 hw/tpm/Makefile.objs                      |    6 -
 hw/tpm/meson.build                        |    7 +
 hw/tpm/trace.h                            |    1 +
 hw/tricore/Makefile.objs                  |    1 -
 hw/tricore/meson.build                    |    4 +
 hw/unicore32/Makefile.objs                |    4 -
 hw/unicore32/meson.build                  |    5 +
 hw/usb/meson.build                        |   53 +
 hw/usb/trace.h                            |    1 +
 hw/vfio/Makefile.objs                     |    7 -
 hw/vfio/meson.build                       |   17 +
 hw/vfio/trace.h                           |    1 +
 hw/virtio/Makefile.objs                   |   41 -
 hw/virtio/meson.build                     |   44 +
 hw/virtio/trace.h                         |    1 +
 hw/watchdog/Makefile.objs                 |    6 -
 hw/watchdog/meson.build                   |    6 +
 hw/watchdog/trace.h                       |    1 +
 hw/xen/Makefile.objs                      |    6 -
 hw/xen/meson.build                        |   18 +
 hw/xen/trace.h                            |    1 +
 hw/xenpv/Makefile.objs                    |    2 -
 hw/xenpv/meson.build                      |    1 +
 hw/xtensa/Makefile.objs                   |    6 -
 hw/xtensa/meson.build                     |   11 +
 include/exec/cpu_ldst_template.h          |    2 +-
 include/exec/cpu_ldst_useronly_template.h |    2 +-
 include/qemu/osdep.h                      |    2 +-
 io/Makefile.objs                          |   12 -
 io/meson.build                            |   25 +
 io/trace.h                                |    1 +
 ioport.c                                  |    2 +-
 job-qmp.c                                 |    2 +-
 job.c                                     |    2 +-
 libdecnumber/Makefile.objs                |    5 -
 libdecnumber/meson.build                  |    7 +
 linux-user/Makefile.objs                  |   10 -
 linux-user/arm/nwfpe/Makefile.objs        |    2 -
 linux-user/arm/nwfpe/meson.build          |   10 +
 linux-user/meson.build                    |   22 +
 linux-user/trace.h                        |    1 +
 memory.c                                  |    2 +-
 meson                                     |    1 +
 meson.build                               | 1096 +++++++++++++++++++++
 migration/Makefile.objs                   |   15 -
 migration/meson.build                     |   26 +
 migration/trace.h                         |    1 +
 monitor/Makefile.objs                     |    3 -
 monitor/meson.build                       |    9 +
 monitor/trace.h                           |    1 +
 nbd/Makefile.objs                         |    1 -
 nbd/meson.build                           |    5 +
 nbd/trace.h                               |    1 +
 net/Makefile.objs                         |   32 -
 net/can/Makefile.objs                     |    2 -
 net/can/meson.build                       |    5 +
 net/meson.build                           |   39 +
 net/trace.h                               |    1 +
 os-posix.c                                |    2 +-
 pc-bios/Makefile                          |   19 -
 pc-bios/descriptors/meson.build           |   14 +
 pc-bios/keymaps/Makefile                  |   56 --
 pc-bios/keymaps/meson.build               |   53 +
 pc-bios/meson.build                       |  112 +++
 pc-bios/optionrom/Makefile                |   62 --
 pc-bios/optionrom/meson.build             |   72 ++
 pc-bios/s390-ccw/Makefile                 |   42 -
 pc-bios/s390-ccw/meson.build              |  175 ++++
 pc-bios/s390-ccw/netboot.mak              |   61 --
 plugins/Makefile.objs                     |   21 -
 plugins/meson.build                       |   13 +
 po/LINGUAS                                |    7 +
 po/Makefile                               |   52 -
 po/POTFILES                               |    1 +
 po/meson.build                            |    5 +
 po/messages.po                            |   74 --
 qapi/Makefile.objs                        |   32 -
 qapi/meson.build                          |  106 ++
 qapi/trace.h                              |    1 +
 qga/Makefile.objs                         |    9 -
 qga/installer/qemu-ga.wxs                 |    2 +-
 qga/meson.build                           |   78 ++
 qga/vss-win32/Makefile.objs               |   23 -
 qga/vss-win32/meson.build                 |   29 +
 qobject/Makefile.objs                     |    3 -
 qobject/meson.build                       |    3 +
 qom/Makefile.objs                         |    4 -
 qom/meson.build                           |   20 +
 qom/trace.h                               |    1 +
 replay/Makefile.objs                      |    9 -
 replay/meson.build                        |   11 +
 rules.mak                                 |  238 +----
 scripts/archive-source.sh                 |    3 +-
 scripts/create_config                     |    2 +
 scripts/decodetree.py                     |    2 +-
 scripts/device-crash-test                 |    2 +-
 scripts/feature_to_c.sh                   |   24 +-
 scripts/grepy.sh                          |    3 +
 scripts/hxtool                            |    2 +-
 scripts/meson.build                       |    3 +
 scripts/minikconf.py                      |    3 +-
 scripts/modules/module_block.py           |    0
 scripts/mtest2make.py                     |  101 ++
 scripts/ninjatool.py                      | 1004 +++++++++++++++++++
 scripts/nsis.sh                           |   58 ++
 scripts/qapi-gen.py                       |    2 +-
 scripts/qemu-version.sh                   |   25 +
 scripts/signrom.py                        |    2 +
 scripts/tracetool.py                      |    2 +-
 scripts/tracetool/backend/dtrace.py       |    2 +-
 scripts/tracetool/backend/ust.py          |    6 +-
 scripts/tracetool/format/c.py             |    5 +-
 scripts/tracetool/format/tcg_h.py         |    2 +-
 scripts/tracetool/format/tcg_helper_c.py  |    2 +-
 scripts/undefsym.sh                       |   20 +
 scsi/Makefile.objs                        |    4 -
 scsi/meson.build                          |    4 +
 scsi/trace.h                              |    1 +
 stubs/Makefile.objs                       |   43 -
 stubs/meson.build                         |   45 +
 target/alpha/Makefile.objs                |    4 -
 target/alpha/meson.build                  |   18 +
 target/arm/Makefile.objs                  |   69 --
 target/arm/meson.build                    |   57 ++
 target/arm/trace.h                        |    1 +
 target/arm/translate-sve.c                |    2 +-
 target/arm/translate-vfp.inc.c            |    4 +-
 target/arm/translate.c                    |    8 +-
 target/cris/Makefile.objs                 |    3 -
 target/cris/meson.build                   |   14 +
 target/hppa/Makefile.objs                 |   11 -
 target/hppa/meson.build                   |   19 +
 target/hppa/trace.h                       |    1 +
 target/hppa/translate.c                   |    2 +-
 target/i386/Makefile.objs                 |   22 -
 target/i386/hvf/Makefile.objs             |    2 -
 target/i386/hvf/meson.build               |   12 +
 target/i386/meson.build                   |   41 +
 target/i386/trace.h                       |    1 +
 target/lm32/Makefile.objs                 |    4 -
 target/lm32/meson.build                   |   15 +
 target/m68k/Makefile.objs                 |    5 -
 target/m68k/meson.build                   |   17 +
 target/meson.build                        |   21 +
 target/microblaze/Makefile.objs           |    3 -
 target/microblaze/meson.build             |   14 +
 target/mips/Makefile.objs                 |    5 -
 target/mips/meson.build                   |   22 +
 target/mips/trace.h                       |    1 +
 target/moxie/Makefile.objs                |    2 -
 target/moxie/meson.build                  |   14 +
 target/nios2/Makefile.objs                |    4 -
 target/nios2/meson.build                  |   15 +
 target/openrisc/Makefile.objs             |   15 -
 target/openrisc/disas.c                   |    2 +-
 target/openrisc/meson.build               |   23 +
 target/openrisc/translate.c               |    2 +-
 target/ppc/Makefile.objs                  |   20 -
 target/ppc/meson.build                    |   37 +
 target/ppc/trace.h                        |    1 +
 target/riscv/Makefile.objs                |   28 -
 target/riscv/meson.build                  |   33 +
 target/riscv/trace.h                      |    1 +
 target/riscv/translate.c                  |    4 +-
 target/s390x/Makefile.objs                |   30 -
 target/s390x/cpu_features.h               |    2 +-
 target/s390x/cpu_models.h                 |    2 +-
 target/s390x/meson.build                  |   48 +
 target/s390x/trace.h                      |    1 +
 target/sh4/Makefile.objs                  |    3 -
 target/sh4/meson.build                    |   14 +
 target/sparc/Makefile.objs                |    7 -
 target/sparc/meson.build                  |   23 +
 target/sparc/trace.h                      |    1 +
 target/tilegx/Makefile.objs               |    1 -
 target/tilegx/meson.build                 |   13 +
 target/tricore/Makefile.objs              |    1 -
 target/tricore/meson.build                |   14 +
 target/unicore32/Makefile.objs            |    8 -
 target/unicore32/meson.build              |   14 +
 target/xtensa/Makefile.objs               |   16 -
 target/xtensa/meson.build                 |   30 +
 tests/Makefile.include                    |  394 +-------
 tests/acceptance/avocado_qemu/__init__.py |    3 +-
 tests/data/acpi/rebuild-expected-aml.sh   |    2 +-
 tests/fp/Makefile                         |  602 -----------
 tests/fp/meson.build                      |  616 ++++++++++++
 tests/libqos/qgraph.h                     |    2 +-
 tests/meson.build                         |   14 +
 tests/multiboot/run_test.sh               |    2 +-
 tests/qapi-schema/meson.build             |  214 ++++
 tests/qemu-iotests/check                  |    6 +-
 tests/qemu-iotests/meson.build            |    8 +
 tests/rtas-test.c                         |    2 +-
 tests/tcg/configure.sh                    |    4 +-
 tests/test-qga.c                          |    8 +-
 trace/Makefile.objs                       |   59 --
 trace/control-target.c                    |    2 +-
 trace/control.c                           |    2 +-
 trace/meson.build                         |   99 ++
 ui/Makefile.objs                          |   70 --
 ui/icons/meson.build                      |   13 +
 ui/meson.build                            |  115 +++
 ui/shader.c                               |    6 +-
 ui/shader/meson.build                     |   15 +
 ui/trace.h                                |    1 +
 util/Makefile.objs                        |   58 --
 util/meson.build                          |   58 ++
 util/trace.h                              |    1 +
 vl.c                                      |    2 +-
 449 files changed, 7125 insertions(+), 5146 deletions(-)
 delete mode 100644 Makefile.target
 delete mode 100644 accel/Makefile.objs
 delete mode 100644 accel/kvm/Makefile.objs
 create mode 100644 accel/kvm/meson.build
 create mode 100644 accel/kvm/trace.h
 create mode 100644 accel/meson.build
 delete mode 100644 accel/stubs/Makefile.objs
 create mode 100644 accel/stubs/meson.build
 delete mode 100644 accel/tcg/Makefile.objs
 create mode 100644 accel/tcg/meson.build
 create mode 100644 accel/tcg/trace.h
 delete mode 100644 audio/Makefile.objs
 create mode 100644 audio/meson.build
 create mode 100644 audio/trace.h
 delete mode 100644 authz/Makefile.objs
 create mode 100644 authz/meson.build
 create mode 100644 authz/trace.h
 delete mode 100644 backends/Makefile.objs
 create mode 100644 backends/meson.build
 delete mode 100644 block/Makefile.objs
 create mode 100644 block/meson.build
 create mode 100644 block/trace.h
 delete mode 100644 bsd-user/Makefile.objs
 create mode 100644 bsd-user/meson.build
 delete mode 100644 chardev/Makefile.objs
 create mode 100644 chardev/meson.build
 create mode 100644 chardev/trace.h
 delete mode 100644 contrib/elf2dmp/Makefile.objs
 create mode 100644 contrib/elf2dmp/meson.build
 delete mode 100644 contrib/ivshmem-client/Makefile.objs
 create mode 100644 contrib/ivshmem-client/meson.build
 delete mode 100644 contrib/ivshmem-server/Makefile.objs
 create mode 100644 contrib/ivshmem-server/meson.build
 delete mode 100644 contrib/libvhost-user/Makefile.objs
 create mode 100644 contrib/libvhost-user/meson.build
 delete mode 100644 contrib/rdmacm-mux/Makefile.objs
 create mode 100644 contrib/rdmacm-mux/meson.build
 create mode 100644 contrib/vhost-user-blk/meson.build
 delete mode 100644 contrib/vhost-user-gpu/Makefile.objs
 create mode 100644 contrib/vhost-user-gpu/meson.build
 delete mode 100644 contrib/vhost-user-input/Makefile.objs
 create mode 100644 contrib/vhost-user-input/meson.build
 delete mode 100644 contrib/vhost-user-scsi/Makefile.objs
 create mode 100644 contrib/vhost-user-scsi/meson.build
 delete mode 100644 crypto/Makefile.objs
 create mode 100644 crypto/meson.build
 create mode 100644 crypto/trace.h
 delete mode 100644 disas/Makefile.objs
 delete mode 100644 disas/libvixl/Makefile.objs
 create mode 100644 disas/libvixl/meson.build
 create mode 100644 disas/meson.build
 create mode 100644 docs/meson.build
 create mode 100644 docs/version.texi.in
 delete mode 100644 dump/Makefile.objs
 create mode 100644 dump/meson.build
 delete mode 100644 fsdev/Makefile.objs
 create mode 100644 fsdev/meson.build
 delete mode 100644 hw/9pfs/Makefile.objs
 create mode 100644 hw/9pfs/meson.build
 create mode 100644 hw/9pfs/trace.h
 delete mode 100644 hw/Makefile.objs
 delete mode 100644 hw/acpi/Makefile.objs
 create mode 100644 hw/acpi/meson.build
 create mode 100644 hw/acpi/trace.h
 delete mode 100644 hw/adc/Makefile.objs
 create mode 100644 hw/adc/meson.build
 delete mode 100644 hw/alpha/Makefile.objs
 create mode 100644 hw/alpha/meson.build
 create mode 100644 hw/alpha/trace.h
 delete mode 100644 hw/arm/Makefile.objs
 create mode 100644 hw/arm/meson.build
 create mode 100644 hw/arm/trace.h
 delete mode 100644 hw/audio/Makefile.objs
 create mode 100644 hw/audio/meson.build
 create mode 100644 hw/audio/trace.h
 delete mode 100644 hw/block/Makefile.objs
 delete mode 100644 hw/block/dataplane/Makefile.objs
 create mode 100644 hw/block/dataplane/meson.build
 create mode 100644 hw/block/dataplane/trace.h
 create mode 100644 hw/block/meson.build
 create mode 100644 hw/block/trace.h
 delete mode 100644 hw/char/Makefile.objs
 create mode 100644 hw/char/meson.build
 create mode 100644 hw/char/trace.h
 delete mode 100644 hw/core/Makefile.objs
 create mode 100644 hw/core/meson.build
 delete mode 100644 hw/cpu/Makefile.objs
 create mode 100644 hw/cpu/meson.build
 delete mode 100644 hw/cris/Makefile.objs
 create mode 100644 hw/cris/meson.build
 delete mode 100644 hw/display/Makefile.objs
 create mode 100644 hw/display/meson.build
 create mode 100644 hw/display/trace.h
 delete mode 100644 hw/dma/Makefile.objs
 create mode 100644 hw/dma/meson.build
 create mode 100644 hw/dma/trace.h
 delete mode 100644 hw/gpio/Makefile.objs
 create mode 100644 hw/gpio/meson.build
 create mode 100644 hw/gpio/trace.h
 delete mode 100644 hw/hppa/Makefile.objs
 create mode 100644 hw/hppa/meson.build
 create mode 100644 hw/hppa/trace.h
 delete mode 100644 hw/hyperv/Makefile.objs
 create mode 100644 hw/hyperv/meson.build
 delete mode 100644 hw/i2c/Makefile.objs
 create mode 100644 hw/i2c/meson.build
 create mode 100644 hw/i2c/trace.h
 delete mode 100644 hw/i386/kvm/Makefile.objs
 create mode 100644 hw/i386/kvm/meson.build
 create mode 100644 hw/i386/meson.build
 create mode 100644 hw/i386/trace.h
 delete mode 100644 hw/i386/xen/Makefile.objs
 create mode 100644 hw/i386/xen/meson.build
 create mode 100644 hw/i386/xen/trace.h
 delete mode 100644 hw/ide/Makefile.objs
 create mode 100644 hw/ide/meson.build
 create mode 100644 hw/ide/trace.h
 delete mode 100644 hw/input/Makefile.objs
 create mode 100644 hw/input/meson.build
 create mode 100644 hw/input/trace.h
 delete mode 100644 hw/intc/Makefile.objs
 create mode 100644 hw/intc/meson.build
 create mode 100644 hw/intc/trace.h
 delete mode 100644 hw/ipack/Makefile.objs
 create mode 100644 hw/ipack/meson.build
 delete mode 100644 hw/ipmi/Makefile.objs
 create mode 100644 hw/ipmi/meson.build
 delete mode 100644 hw/isa/Makefile.objs
 create mode 100644 hw/isa/meson.build
 create mode 100644 hw/isa/trace.h
 delete mode 100644 hw/lm32/Makefile.objs
 create mode 100644 hw/lm32/meson.build
 create mode 100644 hw/m68k/meson.build
 create mode 100644 hw/mem/meson.build
 create mode 100644 hw/mem/trace.h
 create mode 100644 hw/meson.build
 delete mode 100644 hw/microblaze/Makefile.objs
 create mode 100644 hw/microblaze/meson.build
 delete mode 100644 hw/mips/Makefile.objs
 create mode 100644 hw/mips/meson.build
 create mode 100644 hw/mips/trace.h
 delete mode 100644 hw/misc/Makefile.objs
 delete mode 100644 hw/misc/macio/Makefile.objs
 create mode 100644 hw/misc/macio/meson.build
 create mode 100644 hw/misc/macio/trace.h
 create mode 100644 hw/misc/meson.build
 create mode 100644 hw/misc/trace.h
 delete mode 100644 hw/moxie/Makefile.objs
 create mode 100644 hw/moxie/meson.build
 delete mode 100644 hw/net/Makefile.objs
 delete mode 100644 hw/net/can/Makefile.objs
 create mode 100644 hw/net/can/meson.build
 create mode 100644 hw/net/meson.build
 create mode 100644 hw/net/trace.h
 delete mode 100644 hw/nios2/Makefile.objs
 create mode 100644 hw/nios2/meson.build
 delete mode 100644 hw/nubus/Makefile.objs
 create mode 100644 hw/nubus/meson.build
 delete mode 100644 hw/nvram/Makefile.objs
 create mode 100644 hw/nvram/meson.build
 create mode 100644 hw/nvram/trace.h
 delete mode 100644 hw/openrisc/Makefile.objs
 create mode 100644 hw/openrisc/meson.build
 delete mode 100644 hw/pci-bridge/Makefile.objs
 create mode 100644 hw/pci-bridge/meson.build
 delete mode 100644 hw/pci-host/Makefile.objs
 create mode 100644 hw/pci-host/meson.build
 create mode 100644 hw/pci-host/trace.h
 delete mode 100644 hw/pci/Makefile.objs
 create mode 100644 hw/pci/meson.build
 create mode 100644 hw/pci/trace.h
 delete mode 100644 hw/pcmcia/Makefile.objs
 create mode 100644 hw/pcmcia/meson.build
 delete mode 100644 hw/ppc/Makefile.objs
 create mode 100644 hw/ppc/meson.build
 create mode 100644 hw/ppc/trace.h
 delete mode 100644 hw/rdma/Makefile.objs
 create mode 100644 hw/rdma/meson.build
 create mode 100644 hw/rdma/trace.h
 create mode 100644 hw/rdma/vmw/trace.h
 delete mode 100644 hw/riscv/Makefile.objs
 create mode 100644 hw/riscv/meson.build
 create mode 100644 hw/riscv/trace.h
 delete mode 100644 hw/rtc/Makefile.objs
 create mode 100644 hw/rtc/meson.build
 create mode 100644 hw/rtc/trace.h
 delete mode 100644 hw/s390x/Makefile.objs
 create mode 100644 hw/s390x/meson.build
 create mode 100644 hw/s390x/trace.h
 delete mode 100644 hw/scsi/Makefile.objs
 create mode 100644 hw/scsi/meson.build
 create mode 100644 hw/scsi/trace.h
 delete mode 100644 hw/sd/Makefile.objs
 create mode 100644 hw/sd/meson.build
 create mode 100644 hw/sd/trace.h
 delete mode 100644 hw/semihosting/Makefile.objs
 create mode 100644 hw/semihosting/meson.build
 delete mode 100644 hw/sh4/Makefile.objs
 create mode 100644 hw/sh4/meson.build
 delete mode 100644 hw/smbios/Makefile.objs
 create mode 100644 hw/smbios/meson.build
 delete mode 100644 hw/sparc/Makefile.objs
 create mode 100644 hw/sparc/meson.build
 create mode 100644 hw/sparc/trace.h
 delete mode 100644 hw/sparc64/Makefile.objs
 create mode 100644 hw/sparc64/meson.build
 create mode 100644 hw/sparc64/trace.h
 delete mode 100644 hw/ssi/Makefile.objs
 create mode 100644 hw/ssi/meson.build
 delete mode 100644 hw/timer/Makefile.objs
 create mode 100644 hw/timer/meson.build
 create mode 100644 hw/timer/trace.h
 delete mode 100644 hw/tpm/Makefile.objs
 create mode 100644 hw/tpm/meson.build
 create mode 100644 hw/tpm/trace.h
 delete mode 100644 hw/tricore/Makefile.objs
 create mode 100644 hw/tricore/meson.build
 delete mode 100644 hw/unicore32/Makefile.objs
 create mode 100644 hw/unicore32/meson.build
 create mode 100644 hw/usb/meson.build
 create mode 100644 hw/usb/trace.h
 delete mode 100644 hw/vfio/Makefile.objs
 create mode 100644 hw/vfio/meson.build
 create mode 100644 hw/vfio/trace.h
 delete mode 100644 hw/virtio/Makefile.objs
 create mode 100644 hw/virtio/meson.build
 create mode 100644 hw/virtio/trace.h
 delete mode 100644 hw/watchdog/Makefile.objs
 create mode 100644 hw/watchdog/meson.build
 create mode 100644 hw/watchdog/trace.h
 delete mode 100644 hw/xen/Makefile.objs
 create mode 100644 hw/xen/meson.build
 create mode 100644 hw/xen/trace.h
 delete mode 100644 hw/xenpv/Makefile.objs
 create mode 100644 hw/xenpv/meson.build
 delete mode 100644 hw/xtensa/Makefile.objs
 create mode 100644 hw/xtensa/meson.build
 delete mode 100644 io/Makefile.objs
 create mode 100644 io/meson.build
 create mode 100644 io/trace.h
 delete mode 100644 libdecnumber/Makefile.objs
 create mode 100644 libdecnumber/meson.build
 delete mode 100644 linux-user/Makefile.objs
 delete mode 100644 linux-user/arm/nwfpe/Makefile.objs
 create mode 100644 linux-user/arm/nwfpe/meson.build
 create mode 100644 linux-user/meson.build
 create mode 100644 linux-user/trace.h
 create mode 160000 meson
 create mode 100644 meson.build
 delete mode 100644 migration/Makefile.objs
 create mode 100644 migration/meson.build
 create mode 100644 migration/trace.h
 delete mode 100644 monitor/Makefile.objs
 create mode 100644 monitor/meson.build
 create mode 100644 monitor/trace.h
 delete mode 100644 nbd/Makefile.objs
 create mode 100644 nbd/meson.build
 create mode 100644 nbd/trace.h
 delete mode 100644 net/Makefile.objs
 delete mode 100644 net/can/Makefile.objs
 create mode 100644 net/can/meson.build
 create mode 100644 net/meson.build
 create mode 100644 net/trace.h
 delete mode 100644 pc-bios/Makefile
 create mode 100644 pc-bios/descriptors/meson.build
 delete mode 100644 pc-bios/keymaps/Makefile
 create mode 100644 pc-bios/keymaps/meson.build
 create mode 100644 pc-bios/meson.build
 delete mode 100644 pc-bios/optionrom/Makefile
 create mode 100644 pc-bios/optionrom/meson.build
 delete mode 100644 pc-bios/s390-ccw/Makefile
 create mode 100644 pc-bios/s390-ccw/meson.build
 delete mode 100644 pc-bios/s390-ccw/netboot.mak
 delete mode 100644 plugins/Makefile.objs
 create mode 100644 plugins/meson.build
 create mode 100644 po/LINGUAS
 delete mode 100644 po/Makefile
 create mode 100644 po/POTFILES
 create mode 100644 po/meson.build
 delete mode 100644 po/messages.po
 delete mode 100644 qapi/Makefile.objs
 create mode 100644 qapi/meson.build
 create mode 100644 qapi/trace.h
 delete mode 100644 qga/Makefile.objs
 create mode 100644 qga/meson.build
 delete mode 100644 qga/vss-win32/Makefile.objs
 create mode 100644 qga/vss-win32/meson.build
 delete mode 100644 qobject/Makefile.objs
 create mode 100644 qobject/meson.build
 delete mode 100644 qom/Makefile.objs
 create mode 100644 qom/meson.build
 create mode 100644 qom/trace.h
 delete mode 100644 replay/Makefile.objs
 create mode 100644 replay/meson.build
 create mode 100755 scripts/grepy.sh
 mode change 100644 => 100755 scripts/hxtool
 create mode 100644 scripts/meson.build
 mode change 100644 => 100755 scripts/minikconf.py
 mode change 100644 => 100755 scripts/modules/module_block.py
 create mode 100644 scripts/mtest2make.py
 create mode 100755 scripts/ninjatool.py
 create mode 100755 scripts/nsis.sh
 create mode 100755 scripts/qemu-version.sh
 mode change 100644 => 100755 scripts/tracetool/backend/dtrace.py
 create mode 100755 scripts/undefsym.sh
 delete mode 100644 scsi/Makefile.objs
 create mode 100644 scsi/meson.build
 create mode 100644 scsi/trace.h
 delete mode 100644 stubs/Makefile.objs
 create mode 100644 stubs/meson.build
 delete mode 100644 target/alpha/Makefile.objs
 create mode 100644 target/alpha/meson.build
 delete mode 100644 target/arm/Makefile.objs
 create mode 100644 target/arm/meson.build
 create mode 100644 target/arm/trace.h
 delete mode 100644 target/cris/Makefile.objs
 create mode 100644 target/cris/meson.build
 delete mode 100644 target/hppa/Makefile.objs
 create mode 100644 target/hppa/meson.build
 create mode 100644 target/hppa/trace.h
 delete mode 100644 target/i386/Makefile.objs
 delete mode 100644 target/i386/hvf/Makefile.objs
 create mode 100644 target/i386/hvf/meson.build
 create mode 100644 target/i386/meson.build
 create mode 100644 target/i386/trace.h
 delete mode 100644 target/lm32/Makefile.objs
 create mode 100644 target/lm32/meson.build
 delete mode 100644 target/m68k/Makefile.objs
 create mode 100644 target/m68k/meson.build
 create mode 100644 target/meson.build
 delete mode 100644 target/microblaze/Makefile.objs
 create mode 100644 target/microblaze/meson.build
 delete mode 100644 target/mips/Makefile.objs
 create mode 100644 target/mips/meson.build
 create mode 100644 target/mips/trace.h
 delete mode 100644 target/moxie/Makefile.objs
 create mode 100644 target/moxie/meson.build
 delete mode 100644 target/nios2/Makefile.objs
 create mode 100644 target/nios2/meson.build
 delete mode 100644 target/openrisc/Makefile.objs
 create mode 100644 target/openrisc/meson.build
 delete mode 100644 target/ppc/Makefile.objs
 create mode 100644 target/ppc/meson.build
 create mode 100644 target/ppc/trace.h
 delete mode 100644 target/riscv/Makefile.objs
 create mode 100644 target/riscv/meson.build
 create mode 100644 target/riscv/trace.h
 delete mode 100644 target/s390x/Makefile.objs
 create mode 100644 target/s390x/meson.build
 create mode 100644 target/s390x/trace.h
 delete mode 100644 target/sh4/Makefile.objs
 create mode 100644 target/sh4/meson.build
 delete mode 100644 target/sparc/Makefile.objs
 create mode 100644 target/sparc/meson.build
 create mode 100644 target/sparc/trace.h
 delete mode 100644 target/tilegx/Makefile.objs
 create mode 100644 target/tilegx/meson.build
 delete mode 100644 target/tricore/Makefile.objs
 create mode 100644 target/tricore/meson.build
 delete mode 100644 target/unicore32/Makefile.objs
 create mode 100644 target/unicore32/meson.build
 delete mode 100644 target/xtensa/Makefile.objs
 create mode 100644 target/xtensa/meson.build
 delete mode 100644 tests/fp/Makefile
 create mode 100644 tests/fp/meson.build
 create mode 100644 tests/meson.build
 create mode 100644 tests/qapi-schema/meson.build
 create mode 100644 tests/qemu-iotests/meson.build
 delete mode 100644 trace/Makefile.objs
 create mode 100644 trace/meson.build
 delete mode 100644 ui/Makefile.objs
 create mode 100644 ui/icons/meson.build
 create mode 100644 ui/meson.build
 create mode 100644 ui/shader/meson.build
 create mode 100644 ui/trace.h
 delete mode 100644 util/Makefile.objs
 create mode 100644 util/meson.build
 create mode 100644 util/trace.h

-- 
2.21.0


