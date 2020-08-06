Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC04C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 19:18:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 289252177B
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 19:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f63tpTfi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 289252177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3lOt-0005Bm-0w
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 15:18:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42314)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3lNW-0003Eg-NF
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 15:16:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39303
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3lNS-0006L6-N1
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 15:16:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596741393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=XLFIBHlMrRcv+SloyVVntTTEV96Y2dl2y8qCRiQufZQ=;
 b=f63tpTfiYyyDAMS5eQ88xztXfizJZdX8uabuh5z9Y9tByV47am/R1xs1bHZXa+XDAk2v2C
 uJX5+oaBqRee53aHkZDXSsdxjFd0uxjqaW0YQuFM3K+b2X8VPkMh3T0WMIwWwjBHCRLFNZ
 BpewWWEPKx+p0KbtEDx3uA+w9Ov11Ac=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-iYTJ_1CTP5iBgd7GcW9Kuw-1; Thu, 06 Aug 2020 15:16:28 -0400
X-MC-Unique: iYTJ_1CTP5iBgd7GcW9Kuw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C1A6880183C;
 Thu,  6 Aug 2020 19:16:27 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0F2C51D3;
 Thu,  6 Aug 2020 19:16:20 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [DRAFT PATCH 000/143] Meson integration for 5.2
Date: Thu,  6 Aug 2020 21:13:56 +0200
Message-Id: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 00:24:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, jsnow@redhat.com,
 armbru@redhat.com, philmd@redhat.com, stefanha@redhat.com,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This the more or less final version of the Meson conversion.  Due to
the sheer size of the series you have been CCed only on the cover
letter.

The series reaches the point where Makefile.target and unnest-vars
can be removed, and all builds become non-recursive.  I have also
converted parts of the testsuite, notably qtest since it is needed
for fuzzing.  What's left for _after_ the merge is: 1) unit tests;
2) moving the rest of installation to meson (for which I have patches);
3) moving feature detection from configure to meson.

Things I still haven't tested:
- fuzzing
- non-x86/Linux builds
- static builds
- Docker and VM builds

Things I have checked:
- x86 builds
- modules
- "make install"
- internal slirp/dtc/capstone.

It should be more or less bisectable.  I have not tried building
_all_ steps, but I have tried both before and after each major one.

Build system rebuild rules seem to work reliably.

After a week or quite intense rebasing, my impression is more or less
the same as last December: Meson looks more daunting, but it is actually
much nicer to work with.

The diffstat so far is not very favorable, but remember that:

1) the series leaves quite a few nearly-obsolete bits in configure,
Makefile and rules.mak (over 200 lines only in the makefiles).

2) configure test conversion will be where meson really shines.  I
included a couple examples just to show

    meson: convert VNC and dependent libraries to meson
       4 files changed, 44 insertions(+), 134 deletions(-)

    meson: move SDL and SDL-image detection to meson
       5 files changed, 30 insertions(+), 144 deletions(-)

    meson: replace create-config with meson configure_file
       6 files changed, 80 insertions(+), 168 deletions(-)

3) the idea behind using Makefile generators is to have stable
code written in a high-level language instead of Makefile magic
that tends to grow by accretion.  So even though ninjatool is
large at 1000 lines of Python, it can already be considered mature
or even "done".  It had only ~15 lines changed since the last post,
and whenever debugging meson.build issues looking at build.ninja has
always (literally!) been enough.

Available on git://github.com/bonzini/qemu branch meson-poc-next.

Paolo

Marc-André Lureau (92):
  optionrom: simplify Makefile
  build-sys hack: ensure target directory is there
  configure: expand path variables for meson configure
  configure: generate Meson cross file
  build-sys hack: link with whole .fa archives
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
  meson: uncompress edk2 bios
  meson: convert qom directory to Meson (tools part)
  meson: convert authz directory to Meson
  meson: convert crypto directory to Meson
  meson: convert io directory to Meson
  meson: convert target/s390x/gen-features.h
  meson: add macos dependencies
  meson: add modules infrastructure
  meson: convert chardev directory to Meson (tools part)
  meson: convert block
  meson: qemu-{img,io,nbd}
  meson: qemu-pr-helper
  meson: convert ui directory to Meson
  meson: convert trace/
  meson: convert block/
  meson: convert dump/
  meson: convert replay directory to Meson
  meson: convert migration directory to Meson
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
  meson: convert hw/9pfs, cleanup
  meson: convert hw/arch*
  meson: target
  meson: accel
  meson: linux-user
  meson: bsd-user
  meson: cpu-emu
  meson: convert systemtap files
  rules.mak: remove version.o
  meson: convert po/

Paolo Bonzini (51):
  tests: move socket_scm_helper back to tests/
  pc-bios/s390-ccw: simplify Makefile
  trace: switch position of headers to what Meson requires
  meson: rename .inc.c files to .inc
  tests/vm: do not pollute configure with --efi-aarch64
  tests/vm: check for Python YAML parser in the Makefile
  configure: do not include $(...) variables in config-host.mak
  configure: prepare CFLAGS/CXXFLAGS/LDFLAGS for Meson
  configure: integrate Meson in the build system
  meson: move summary to meson.build
  meson: add sparse support
  meson: add testsuite Makefile generator
  libqemuutil, qapi, trace: convert to meson
  contrib/libvhost-user: convert to Meson
  tools/virtiofsd: convert to Meson
  contrib/vhost-user-blk: convert to Meson
  contrib/vhost-user-scsi: convert to Meson
  contrib/rdmacm-mux: convert to Meson
  meson: convert qemu-ga
  meson: convert dummy Windows qga/qemu-ga target
  meson: convert check-decodetree
  meson: convert tests/fp and check-softfloat
  meson: convert check-qapi-schema
  meson: infrastructure for building emulators
  configure, Makefile; remove TOOLS and HELPERS-y variable
  meson: convert chardev directory to Meson (emulator part)
  meson: convert tests/qtest to meson
  meson: convert audio directory to Meson
  meson: convert root directory to Meson
  meson: convert most of softmmu/
  meson: convert most of softmmu/
  meson: convert common QMP bits for qemu and qemu-storage-daemon
  meson: convert qemu-storage-daemon
  meson: convert hw/semihosting
  meson: convert hw/nubus
  meson: convert hw/usb
  meson: convert hw/tpm
  meson: convert hw/timer
  meson: convert hw/rtc
  meson: plugins
  meson: link emulators without Makefile.target
  remove Makefile.target
  meson: sphinx-build
  meson: build texi doc
  meson: convert check-block
  rules.mak: drop unneeded macros
  meson: replace create-config with meson configure_file
  meson: convert sample plugins
  meson: move SDL and SDL-image detection to meson
  meson: convert VNC and dependent libraries to meson
  meson: update build-system documentation

 .gitignore                                         |    4 +-
 .gitlab-ci.yml                                     |    4 +-
 .gitmodules                                        |    3 +
 Makefile                                           |  955 +------------
 Makefile.objs                                      |  218 +--
 Makefile.target                                    |  287 ----
 accel/Makefile.objs                                |    6 -
 accel/kvm/Makefile.objs                            |    2 -
 accel/kvm/meson.build                              |    5 +
 accel/kvm/trace.h                                  |    1 +
 accel/meson.build                                  |    7 +
 accel/stubs/Makefile.objs                          |    6 -
 accel/stubs/meson.build                            |    6 +
 accel/tcg/Makefile.objs                            |    9 -
 .../tcg/{atomic_common.inc.c => atomic_common.inc} |    0
 accel/tcg/cputlb.c                                 |    4 +-
 accel/tcg/meson.build                              |   15 +
 accel/tcg/trace.h                                  |    1 +
 accel/tcg/user-exec.c                              |    4 +-
 accel/xen/Makefile.objs                            |    1 -
 accel/xen/meson.build                              |    1 +
 audio/Makefile.objs                                |   35 -
 audio/meson.build                                  |   32 +
 audio/trace.h                                      |    1 +
 authz/Makefile.objs                                |    7 -
 authz/meson.build                                  |   19 +
 authz/trace.h                                      |    1 +
 backends/Makefile.objs                             |   23 -
 backends/meson.build                               |   19 +
 backends/tpm/Makefile.objs                         |    4 -
 backends/tpm/meson.build                           |    8 +
 backends/tpm/trace.h                               |    1 +
 backends/trace.h                                   |    1 +
 block.c                                            |    6 +-
 block/Makefile.objs                                |   75 --
 block/meson.build                                  |  111 ++
 block/monitor/Makefile.objs                        |    2 -
 block/monitor/meson.build                          |    2 +
 block/trace.h                                      |    1 +
 bsd-user/Makefile.objs                             |    2 -
 bsd-user/meson.build                               |   10 +
 chardev/Makefile.objs                              |   29 -
 chardev/meson.build                                |   43 +
 chardev/trace.h                                    |    1 +
 configure                                          |  958 ++++---------
 contrib/elf2dmp/Makefile.objs                      |    4 -
 contrib/elf2dmp/meson.build                        |    4 +
 contrib/gitdm/filetypes.txt                        |    2 +-
 contrib/ivshmem-client/Makefile.objs               |    1 -
 contrib/ivshmem-client/meson.build                 |    3 +
 contrib/ivshmem-server/Makefile.objs               |    1 -
 contrib/ivshmem-server/meson.build                 |    3 +
 contrib/libvhost-user/Makefile.objs                |    1 -
 contrib/libvhost-user/meson.build                  |    2 +
 contrib/rdmacm-mux/Makefile.objs                   |    3 -
 contrib/rdmacm-mux/meson.build                     |    6 +
 contrib/vhost-user-blk/Makefile.objs               |    1 -
 contrib/vhost-user-blk/meson.build                 |    3 +
 contrib/vhost-user-gpu/Makefile.objs               |   10 -
 contrib/vhost-user-gpu/meson.build                 |   11 +
 contrib/vhost-user-input/Makefile.objs             |    1 -
 contrib/vhost-user-input/meson.build               |    3 +
 contrib/vhost-user-scsi/Makefile.objs              |    1 -
 contrib/vhost-user-scsi/meson.build                |    5 +
 crypto/Makefile.objs                               |   43 -
 crypto/meson.build                                 |   63 +
 crypto/trace.h                                     |    1 +
 disas/Makefile.objs                                |   30 -
 disas/libvixl/Makefile.objs                        |    5 -
 disas/libvixl/meson.build                          |    7 +
 disas/meson.build                                  |   27 +
 dma-helpers.c                                      |    2 +-
 docs/devel/blkverify.txt                           |    4 +-
 docs/devel/build-system.txt                        |  378 +++---
 docs/devel/testing.rst                             |   11 +-
 docs/devel/tracing.txt                             |    2 +-
 docs/index.html.in                                 |    4 +-
 docs/interop/live-block-operations.rst             |    4 +-
 docs/interop/qemu-ga-ref.texi                      |    2 +-
 docs/interop/qemu-qmp-ref.texi                     |    2 +-
 docs/meson.build                                   |   68 +
 dump/Makefile.objs                                 |    3 -
 dump/meson.build                                   |    4 +
 exec.c                                             |    6 +-
 ...t-specialize.inc.c => softfloat-specialize.inc} |    0
 fpu/softfloat.c                                    |    2 +-
 fsdev/Makefile.objs                                |   12 -
 fsdev/meson.build                                  |   15 +
 gdbstub.c                                          |    2 +-
 hw/9pfs/Kconfig                                    |    4 +
 hw/9pfs/Makefile.objs                              |    9 -
 hw/9pfs/meson.build                                |   20 +
 hw/9pfs/trace.h                                    |    1 +
 hw/Makefile.objs                                   |   48 -
 hw/acpi/Makefile.objs                              |   26 -
 hw/acpi/meson.build                                |   25 +
 hw/acpi/trace.h                                    |    1 +
 hw/adc/Makefile.objs                               |    1 -
 hw/adc/meson.build                                 |    1 +
 hw/alpha/Makefile.objs                             |    1 -
 hw/alpha/meson.build                               |    8 +
 hw/alpha/trace.h                                   |    1 +
 hw/arm/Makefile.objs                               |   56 -
 hw/arm/meson.build                                 |   59 +
 hw/arm/trace.h                                     |    1 +
 hw/audio/Makefile.objs                             |   18 -
 hw/audio/meson.build                               |   14 +
 hw/audio/trace.h                                   |    1 +
 hw/avr/Makefile.objs                               |    3 -
 hw/avr/meson.build                                 |    6 +
 hw/block/Makefile.objs                             |   18 -
 hw/block/dataplane/Makefile.objs                   |    2 -
 hw/block/dataplane/meson.build                     |    2 +
 hw/block/dataplane/trace.h                         |    1 +
 hw/block/meson.build                               |   21 +
 hw/block/trace.h                                   |    1 +
 hw/char/Makefile.objs                              |   39 -
 hw/char/meson.build                                |   38 +
 hw/char/trace.h                                    |    1 +
 hw/core/Makefile.objs                              |   34 -
 hw/core/cpu.c                                      |    2 +-
 hw/core/meson.build                                |   43 +
 hw/core/trace.h                                    |    1 +
 hw/cpu/Makefile.objs                               |    5 -
 hw/cpu/meson.build                                 |    6 +
 hw/cris/Makefile.objs                              |    2 -
 hw/cris/meson.build                                |    5 +
 hw/display/Makefile.objs                           |   65 -
 hw/display/meson.build                             |   94 ++
 hw/display/trace.h                                 |    1 +
 hw/dma/Makefile.objs                               |   16 -
 hw/dma/meson.build                                 |   15 +
 hw/dma/trace.h                                     |    1 +
 hw/gpio/Makefile.objs                              |   12 -
 hw/gpio/meson.build                                |   12 +
 hw/gpio/trace.h                                    |    1 +
 hw/hppa/Makefile.objs                              |    1 -
 hw/hppa/meson.build                                |    4 +
 hw/hppa/trace.h                                    |    1 +
 hw/hyperv/Makefile.objs                            |    3 -
 hw/hyperv/meson.build                              |    3 +
 hw/hyperv/trace.h                                  |    1 +
 hw/i2c/Makefile.objs                               |   14 -
 hw/i2c/meson.build                                 |   16 +
 hw/i2c/trace.h                                     |    1 +
 hw/i386/Makefile.objs                              |   20 -
 hw/i386/fw_cfg.c                                   |    2 +-
 hw/i386/kvm/Makefile.objs                          |    5 -
 hw/i386/kvm/meson.build                            |    8 +
 hw/i386/meson.build                                |   32 +
 hw/i386/pc.c                                       |    2 +-
 hw/i386/pc_piix.c                                  |    2 +-
 hw/i386/trace.h                                    |    1 +
 hw/i386/x86.c                                      |    2 +-
 hw/i386/xen/Makefile.objs                          |    1 -
 hw/i386/xen/meson.build                            |    7 +
 hw/i386/xen/trace.h                                |    1 +
 hw/ide/Makefile.objs                               |   14 -
 hw/ide/meson.build                                 |   14 +
 hw/ide/trace.h                                     |    1 +
 hw/input/Makefile.objs                             |   18 -
 hw/input/meson.build                               |   18 +
 hw/input/trace.h                                   |    1 +
 hw/intc/Makefile.objs                              |   54 -
 hw/intc/meson.build                                |   55 +
 hw/intc/trace.h                                    |    1 +
 hw/ipack/Makefile.objs                             |    2 -
 hw/ipack/meson.build                               |    1 +
 hw/ipmi/Makefile.objs                              |    8 -
 hw/ipmi/meson.build                                |   11 +
 hw/isa/Makefile.objs                               |   11 -
 hw/isa/meson.build                                 |   11 +
 hw/isa/trace.h                                     |    1 +
 hw/lm32/Makefile.objs                              |    3 -
 hw/lm32/meson.build                                |    6 +
 hw/m68k/Makefile.objs                              |    4 -
 hw/m68k/meson.build                                |    7 +
 hw/mem/Kconfig                                     |    1 +
 hw/mem/Makefile.objs                               |    3 -
 hw/mem/meson.build                                 |    6 +
 hw/mem/trace.h                                     |    1 +
 hw/meson.build                                     |   67 +
 hw/microblaze/Makefile.objs                        |    4 -
 hw/microblaze/meson.build                          |    7 +
 hw/mips/Makefile.objs                              |    8 -
 hw/mips/meson.build                                |   11 +
 hw/mips/trace.h                                    |    1 +
 hw/misc/Makefile.objs                              |   95 --
 hw/misc/macio/Makefile.objs                        |    5 -
 hw/misc/macio/meson.build                          |    8 +
 hw/misc/macio/trace.h                              |    1 +
 hw/misc/meson.build                                |   99 ++
 hw/misc/trace.h                                    |    1 +
 hw/moxie/Makefile.objs                             |    2 -
 hw/moxie/meson.build                               |    4 +
 hw/net/Makefile.objs                               |   59 -
 hw/net/can/Makefile.objs                           |    4 -
 hw/net/can/meson.build                             |    4 +
 hw/net/meson.build                                 |   67 +
 hw/net/trace.h                                     |    1 +
 hw/nios2/Makefile.objs                             |    3 -
 hw/nios2/meson.build                               |    6 +
 hw/nubus/Makefile.objs                             |    4 -
 hw/nubus/meson.build                               |    7 +
 hw/nvram/Makefile.objs                             |    8 -
 hw/nvram/meson.build                               |    9 +
 hw/nvram/trace.h                                   |    1 +
 hw/openrisc/Makefile.objs                          |    2 -
 hw/openrisc/meson.build                            |    5 +
 hw/pci-bridge/Makefile.objs                        |   10 -
 hw/pci-bridge/meson.build                          |   14 +
 hw/pci-host/Makefile.objs                          |   24 -
 hw/pci-host/meson.build                            |   30 +
 hw/pci-host/trace.h                                |    1 +
 hw/pci/Makefile.objs                               |   14 -
 hw/pci/meson.build                                 |   19 +
 hw/pci/trace.h                                     |    1 +
 hw/pcmcia/Makefile.objs                            |    2 -
 hw/pcmcia/meson.build                              |    2 +
 hw/ppc/Makefile.objs                               |   35 -
 hw/ppc/meson.build                                 |   80 ++
 hw/ppc/trace.h                                     |    1 +
 hw/rdma/Makefile.objs                              |    3 -
 hw/rdma/meson.build                                |   10 +
 hw/rdma/trace.h                                    |    1 +
 hw/rdma/vmw/trace.h                                |    1 +
 hw/riscv/Makefile.objs                             |   16 -
 hw/riscv/meson.build                               |   19 +
 hw/riscv/trace.h                                   |    1 +
 hw/rtc/Makefile.objs                               |   15 -
 hw/rtc/meson.build                                 |   16 +
 hw/rtc/trace.h                                     |    1 +
 hw/rx/Makefile.objs                                |    2 -
 hw/rx/meson.build                                  |    5 +
 hw/s390x/Makefile.objs                             |   37 -
 hw/s390x/meson.build                               |   46 +
 hw/s390x/trace.h                                   |    1 +
 hw/scsi/Makefile.objs                              |   15 -
 hw/scsi/meson.build                                |   26 +
 hw/scsi/trace.h                                    |    1 +
 hw/sd/Makefile.objs                                |   12 -
 hw/sd/meson.build                                  |   12 +
 hw/sd/trace.h                                      |    1 +
 hw/semihosting/Makefile.objs                       |    2 -
 hw/semihosting/meson.build                         |    4 +
 hw/sh4/Makefile.objs                               |    4 -
 hw/sh4/meson.build                                 |   10 +
 hw/smbios/Makefile.objs                            |   10 -
 hw/smbios/meson.build                              |   13 +
 hw/sparc/Makefile.objs                             |    3 -
 hw/sparc/meson.build                               |    6 +
 hw/sparc/trace.h                                   |    1 +
 hw/sparc64/Makefile.objs                           |    4 -
 hw/sparc64/meson.build                             |    6 +
 hw/sparc64/trace.h                                 |    1 +
 hw/ssi/Makefile.objs                               |   10 -
 hw/ssi/meson.build                                 |    9 +
 hw/ssi/trace.h                                     |    1 +
 hw/timer/Makefile.objs                             |   41 -
 hw/timer/meson.build                               |   37 +
 hw/timer/trace.h                                   |    1 +
 hw/tpm/Makefile.objs                               |    6 -
 hw/tpm/meson.build                                 |    8 +
 hw/tpm/trace.h                                     |    1 +
 hw/tricore/Makefile.objs                           |    1 -
 hw/tricore/meson.build                             |    4 +
 hw/unicore32/Makefile.objs                         |    4 -
 hw/unicore32/meson.build                           |    5 +
 hw/usb/Makefile.objs                               |   71 -
 hw/usb/meson.build                                 |   69 +
 hw/usb/trace.h                                     |    1 +
 hw/vfio/Makefile.objs                              |    8 -
 hw/vfio/meson.build                                |   18 +
 hw/vfio/pci-quirks.c                               |    2 +-
 hw/vfio/trace.h                                    |    1 +
 hw/virtio/Makefile.objs                            |   48 -
 hw/virtio/meson.build                              |   51 +
 hw/virtio/trace.h                                  |    1 +
 hw/virtio/virtio-mem.c                             |    2 +-
 hw/watchdog/Makefile.objs                          |    7 -
 hw/watchdog/meson.build                            |    7 +
 hw/watchdog/trace.h                                |    1 +
 hw/xen/Makefile.objs                               |    7 -
 hw/xen/meson.build                                 |   20 +
 hw/xen/trace.h                                     |    1 +
 hw/xenpv/Makefile.objs                             |    2 -
 hw/xenpv/meson.build                               |    3 +
 hw/xtensa/Makefile.objs                            |    6 -
 hw/xtensa/meson.build                              |   11 +
 include/qemu/osdep.h                               |    2 +-
 include/tcg/tcg.h                                  |    2 +-
 include/user/syscall-trace.h                       |    2 +-
 io/Makefile.objs                                   |   12 -
 io/meson.build                                     |   25 +
 io/trace.h                                         |    1 +
 job-qmp.c                                          |    2 +-
 job.c                                              |    2 +-
 libdecnumber/Makefile.objs                         |    5 -
 libdecnumber/meson.build                           |    7 +
 linux-user/Makefile.objs                           |   25 -
 linux-user/alpha/Makefile.objs                     |    5 -
 linux-user/alpha/meson.build                       |    5 +
 linux-user/arm/Makefile.objs                       |    8 -
 linux-user/arm/meson.build                         |   10 +
 linux-user/arm/nwfpe/Makefile.objs                 |    2 -
 linux-user/arm/nwfpe/meson.build                   |   10 +
 linux-user/hppa/Makefile.objs                      |    5 -
 linux-user/hppa/meson.build                        |    5 +
 linux-user/i386/Makefile.objs                      |    5 -
 linux-user/i386/meson.build                        |    5 +
 linux-user/i386/syscall_nr.h                       |    1 +
 linux-user/m68k/Makefile.objs                      |    5 -
 linux-user/m68k/meson.build                        |    5 +
 linux-user/meson.build                             |   37 +
 linux-user/microblaze/Makefile.objs                |    5 -
 linux-user/microblaze/meson.build                  |    5 +
 linux-user/mips/Makefile.objs                      |    5 -
 linux-user/mips/meson.build                        |    5 +
 linux-user/mips/syscall_nr.h                       |    1 +
 linux-user/mips64/Makefile.objs                    |   12 -
 linux-user/mips64/meson.build                      |    6 +
 linux-user/mips64/syscall_nr.h                     |    7 +
 linux-user/ppc/Makefile.objs                       |    6 -
 linux-user/ppc/meson.build                         |    5 +
 linux-user/s390x/Makefile.objs                     |    5 -
 linux-user/s390x/meson.build                       |    5 +
 linux-user/sh4/Makefile.objs                       |    5 -
 linux-user/sh4/meson.build                         |    5 +
 linux-user/sparc/Makefile.objs                     |    5 -
 linux-user/sparc/meson.build                       |    5 +
 linux-user/sparc64/Makefile.objs                   |    5 -
 linux-user/sparc64/meson.build                     |    5 +
 linux-user/trace.h                                 |    1 +
 linux-user/x86_64/Makefile.objs                    |    5 -
 linux-user/x86_64/meson.build                      |    5 +
 linux-user/x86_64/syscall_nr.h                     |    1 +
 linux-user/xtensa/Makefile.objs                    |    5 -
 linux-user/xtensa/meson.build                      |    5 +
 memory_ldst.inc.c => memory_ldst.inc               |    0
 meson                                              |    1 +
 meson.build                                        | 1413 ++++++++++++++++++++
 meson_options.txt                                  |    6 +
 migration/Makefile.objs                            |   18 -
 migration/meson.build                              |   29 +
 migration/trace.h                                  |    1 +
 monitor/Makefile.objs                              |    6 -
 monitor/meson.build                                |    9 +
 monitor/trace.h                                    |    1 +
 nbd/Makefile.objs                                  |    1 -
 nbd/meson.build                                    |    5 +
 nbd/trace.h                                        |    1 +
 net/Makefile.objs                                  |   32 -
 net/can/Makefile.objs                              |    2 -
 net/can/meson.build                                |    5 +
 net/meson.build                                    |   40 +
 net/trace.h                                        |    1 +
 os-posix.c                                         |    2 +-
 pc-bios/meson.build                                |   23 +
 pc-bios/optionrom/Makefile                         |   67 +-
 pc-bios/s390-ccw/Makefile                          |  105 +-
 pc-bios/s390-ccw/netboot.mak                       |   62 -
 plugins/Makefile.objs                              |   21 -
 plugins/meson.build                                |   13 +
 po/LINGUAS                                         |    7 +
 po/Makefile                                        |   52 -
 po/POTFILES                                        |    1 +
 po/meson.build                                     |    5 +
 po/messages.po                                     |   74 -
 qapi/Makefile.objs                                 |   38 -
 qapi/meson.build                                   |  124 ++
 qapi/trace.h                                       |    1 +
 qga/Makefile.objs                                  |   10 -
 qga/installer/qemu-ga.wxs                          |    2 +-
 qga/meson.build                                    |   86 ++
 qga/vss-win32/Makefile.objs                        |   23 -
 qga/vss-win32/meson.build                          |   36 +
 qobject/Makefile.objs                              |    3 -
 qobject/meson.build                                |    3 +
 qom/Makefile.objs                                  |    5 -
 qom/meson.build                                    |   18 +
 qom/trace.h                                        |    1 +
 replay/Makefile.objs                               |   10 -
 replay/meson.build                                 |   12 +
 rules.mak                                          |  314 +----
 scripts/archive-source.sh                          |    3 +-
 scripts/check_sparse.py                            |   25 +
 scripts/clean-includes                             |    2 +-
 scripts/create_config                              |  129 --
 scripts/decodetree.py                              |    2 +-
 scripts/device-crash-test                          |    2 +-
 scripts/feature_to_c.sh                            |   24 +-
 scripts/grepy.sh                                   |    3 +
 scripts/hxtool                                     |    2 +-
 scripts/modules/module_block.py                    |    0
 scripts/mtest2make.py                              |  102 ++
 scripts/ninjatool.py                               | 1010 ++++++++++++++
 scripts/qemu-version.sh                            |   25 +
 scripts/tracetool/backend/dtrace.py                |    2 +-
 scripts/tracetool/backend/ust.py                   |    6 +-
 scripts/tracetool/format/c.py                      |    5 +-
 scripts/tracetool/format/tcg_h.py                  |    2 +-
 scripts/tracetool/format/tcg_helper_c.py           |    2 +-
 scripts/undefsym.sh                                |   20 +
 scsi/Makefile.objs                                 |    4 -
 scsi/meson.build                                   |    4 +
 scsi/trace.h                                       |    1 +
 softmmu/Makefile.objs                              |   14 -
 softmmu/balloon.c                                  |    2 +-
 softmmu/ioport.c                                   |    2 +-
 softmmu/memory.c                                   |    2 +-
 softmmu/meson.build                                |   14 +
 softmmu/qtest.c                                    |    2 +-
 softmmu/vl.c                                       |    2 +-
 storage-daemon/Makefile.objs                       |    1 -
 storage-daemon/meson.build                         |   13 +
 storage-daemon/qapi/Makefile.objs                  |    1 -
 storage-daemon/qapi/meson.build                    |    7 +
 .../qemu-storage-daemon.c                          |    0
 stubs/Makefile.objs                                |   56 -
 stubs/meson.build                                  |   50 +
 target/alpha/Makefile.objs                         |    4 -
 target/alpha/meson.build                           |   18 +
 target/arm/Makefile.objs                           |   89 --
 target/arm/meson.build                             |   62 +
 target/arm/trace.h                                 |    1 +
 .../{translate-neon.inc.c => translate-neon.inc}   |    6 +-
 target/arm/translate-sve.c                         |    2 +-
 .../arm/{translate-vfp.inc.c => translate-vfp.inc} |    4 +-
 target/arm/translate.c                             |   12 +-
 target/avr/Makefile.objs                           |   34 -
 target/avr/disas.c                                 |    2 +-
 target/avr/meson.build                             |   20 +
 target/avr/translate.c                             |    2 +-
 target/cris/Makefile.objs                          |    3 -
 target/cris/meson.build                            |   14 +
 target/cris/translate.c                            |    2 +-
 .../{translate_v10.inc.c => translate_v10.inc}     |    0
 target/hppa/Makefile.objs                          |   11 -
 target/hppa/meson.build                            |   19 +
 target/hppa/trace.h                                |    1 +
 target/hppa/translate.c                            |    2 +-
 target/i386/Makefile.objs                          |   23 -
 target/i386/hvf/Makefile.objs                      |    2 -
 target/i386/hvf/meson.build                        |   12 +
 target/i386/meson.build                            |   40 +
 target/i386/trace.h                                |    1 +
 target/lm32/Makefile.objs                          |    4 -
 target/lm32/meson.build                            |   15 +
 target/m68k/Makefile.objs                          |    5 -
 target/m68k/meson.build                            |   17 +
 target/meson.build                                 |   23 +
 target/microblaze/Makefile.objs                    |    3 -
 target/microblaze/meson.build                      |   14 +
 target/mips/Makefile.objs                          |    6 -
 target/mips/meson.build                            |   24 +
 target/mips/trace.h                                |    1 +
 target/mips/translate.c                            |    2 +-
 .../{translate_init.inc.c => translate_init.inc}   |    0
 target/moxie/Makefile.objs                         |    2 -
 target/moxie/meson.build                           |   14 +
 target/nios2/Makefile.objs                         |    4 -
 target/nios2/meson.build                           |   15 +
 target/openrisc/Makefile.objs                      |   15 -
 target/openrisc/disas.c                            |    2 +-
 target/openrisc/meson.build                        |   23 +
 target/openrisc/translate.c                        |    2 +-
 target/ppc/Makefile.objs                           |   20 -
 target/ppc/int_helper.c                            |    2 +-
 target/ppc/meson.build                             |   37 +
 target/ppc/{mfrom_table.inc.c => mfrom_table.inc}  |    0
 target/ppc/trace.h                                 |    1 +
 target/ppc/translate.c                             |   22 +-
 .../ppc/translate/{dfp-impl.inc.c => dfp-impl.inc} |    0
 .../ppc/translate/{dfp-ops.inc.c => dfp-ops.inc}   |    0
 .../ppc/translate/{fp-impl.inc.c => fp-impl.inc}   |    0
 target/ppc/translate/{fp-ops.inc.c => fp-ops.inc}  |    0
 .../ppc/translate/{spe-impl.inc.c => spe-impl.inc} |    0
 .../ppc/translate/{spe-ops.inc.c => spe-ops.inc}   |    0
 .../ppc/translate/{vmx-impl.inc.c => vmx-impl.inc} |    0
 .../ppc/translate/{vmx-ops.inc.c => vmx-ops.inc}   |    0
 .../ppc/translate/{vsx-impl.inc.c => vsx-impl.inc} |    0
 .../ppc/translate/{vsx-ops.inc.c => vsx-ops.inc}   |    0
 .../{translate_init.inc.c => translate_init.inc}   |    0
 target/riscv/Makefile.objs                         |   28 -
 ...trans_privileged.inc.c => trans_privileged.inc} |    0
 .../insn_trans/{trans_rva.inc.c => trans_rva.inc}  |    0
 .../insn_trans/{trans_rvd.inc.c => trans_rvd.inc}  |    0
 .../insn_trans/{trans_rvf.inc.c => trans_rvf.inc}  |    0
 .../insn_trans/{trans_rvh.inc.c => trans_rvh.inc}  |    0
 .../insn_trans/{trans_rvi.inc.c => trans_rvi.inc}  |    0
 .../insn_trans/{trans_rvm.inc.c => trans_rvm.inc}  |    0
 .../insn_trans/{trans_rvv.inc.c => trans_rvv.inc}  |    0
 target/riscv/meson.build                           |   34 +
 target/riscv/trace.h                               |    1 +
 target/riscv/translate.c                           |   20 +-
 target/rx/Makefile.objs                            |   11 -
 target/rx/disas.c                                  |    2 +-
 target/rx/meson.build                              |   16 +
 target/rx/translate.c                              |    2 +-
 target/s390x/Makefile.objs                         |   30 -
 target/s390x/cpu_features.h                        |    2 +-
 target/s390x/cpu_models.h                          |    2 +-
 target/s390x/meson.build                           |   48 +
 target/s390x/trace.h                               |    1 +
 target/s390x/translate.c                           |    2 +-
 .../s390x/{translate_vx.inc.c => translate_vx.inc} |    0
 target/sh4/Makefile.objs                           |    3 -
 target/sh4/meson.build                             |   14 +
 target/sparc/Makefile.objs                         |    7 -
 target/sparc/meson.build                           |   23 +
 target/sparc/trace.h                               |    1 +
 target/tilegx/Makefile.objs                        |    1 -
 target/tilegx/meson.build                          |   13 +
 target/tricore/Makefile.objs                       |    1 -
 target/tricore/meson.build                         |   15 +
 target/unicore32/Makefile.objs                     |    8 -
 target/unicore32/meson.build                       |   14 +
 target/xtensa/Makefile.objs                        |   16 -
 target/xtensa/core-dc232b.c                        |    4 +-
 .../{gdb-config.inc.c => gdb-config.inc}           |    0
 .../{xtensa-modules.inc.c => xtensa-modules.inc}   |    0
 target/xtensa/core-dc233c.c                        |    4 +-
 .../{gdb-config.inc.c => gdb-config.inc}           |    0
 .../{xtensa-modules.inc.c => xtensa-modules.inc}   |    0
 target/xtensa/core-de212.c                         |    4 +-
 .../{gdb-config.inc.c => gdb-config.inc}           |    0
 .../{xtensa-modules.inc.c => xtensa-modules.inc}   |    0
 target/xtensa/core-fsf.c                           |    2 +-
 .../{xtensa-modules.inc.c => xtensa-modules.inc}   |    0
 target/xtensa/core-sample_controller.c             |    4 +-
 .../{gdb-config.inc.c => gdb-config.inc}           |    0
 .../{xtensa-modules.inc.c => xtensa-modules.inc}   |    0
 target/xtensa/core-test_kc705_be.c                 |    4 +-
 .../{gdb-config.inc.c => gdb-config.inc}           |    0
 .../{xtensa-modules.inc.c => xtensa-modules.inc}   |    0
 target/xtensa/core-test_mmuhifi_c3.c               |    4 +-
 .../{gdb-config.inc.c => gdb-config.inc}           |    0
 .../{xtensa-modules.inc.c => xtensa-modules.inc}   |    0
 target/xtensa/import_core.sh                       |    8 +-
 target/xtensa/meson.build                          |   30 +
 tcg/README                                         |    2 +-
 tcg/aarch64/{tcg-target.inc.c => tcg-target.inc}   |    4 +-
 tcg/arm/{tcg-target.inc.c => tcg-target.inc}       |    4 +-
 tcg/i386/{tcg-target.inc.c => tcg-target.inc}      |    4 +-
 tcg/mips/{tcg-target.inc.c => tcg-target.inc}      |    2 +-
 tcg/ppc/{tcg-target.inc.c => tcg-target.inc}       |    4 +-
 tcg/riscv/{tcg-target.inc.c => tcg-target.inc}     |    4 +-
 tcg/s390/{tcg-target.inc.c => tcg-target.inc}      |    4 +-
 tcg/sparc/{tcg-target.inc.c => tcg-target.inc}     |    2 +-
 tcg/{tcg-ldst.inc.c => tcg-ldst.inc}               |    0
 tcg/{tcg-pool.inc.c => tcg-pool.inc}               |    2 +-
 tcg/tcg.c                                          |    6 +-
 tcg/tci/README                                     |    4 +-
 tcg/tci/{tcg-target.inc.c => tcg-target.inc}       |    0
 tests/Makefile.include                             |  451 +------
 tests/acceptance/avocado_qemu/__init__.py          |    3 +-
 tests/data/acpi/rebuild-expected-aml.sh            |    2 +-
 tests/fp/Makefile                                  |  600 ---------
 tests/fp/fp-test.c                                 |    2 +-
 tests/fp/meson.build                               |  628 +++++++++
 tests/fp/{wrap.inc.c => wrap.inc}                  |    0
 tests/meson.build                                  |   18 +
 tests/multiboot/run_test.sh                        |    2 +-
 tests/plugin/Makefile                              |   46 -
 tests/plugin/meson.build                           |    7 +
 tests/qapi-schema/meson.build                      |  215 +++
 tests/qemu-iotests/check                           |    6 +-
 tests/qemu-iotests/meson.build                     |    8 +
 tests/qtest/Makefile.include                       |  332 -----
 tests/qtest/ac97-test.c                            |    2 +-
 tests/qtest/acpi-utils.h                           |    2 +-
 tests/qtest/ahci-test.c                            |    2 +-
 tests/qtest/arm-cpu-features.c                     |    2 +-
 tests/qtest/bios-tables-test.c                     |    2 +-
 tests/qtest/boot-order-test.c                      |    2 +-
 tests/qtest/boot-sector.c                          |    2 +-
 tests/qtest/boot-sector.h                          |    2 +-
 tests/qtest/boot-serial-test.c                     |    2 +-
 tests/qtest/cdrom-test.c                           |    2 +-
 tests/qtest/dbus-vmstate-test.c                    |    2 +-
 tests/qtest/device-introspect-test.c               |    2 +-
 tests/qtest/device-plug-test.c                     |    2 +-
 tests/qtest/drive_del-test.c                       |    2 +-
 tests/qtest/ds1338-test.c                          |    2 +-
 tests/qtest/e1000-test.c                           |    2 +-
 tests/qtest/eepro100-test.c                        |    2 +-
 tests/qtest/endianness-test.c                      |    2 +-
 tests/qtest/es1370-test.c                          |    2 +-
 tests/qtest/fuzz/Makefile.include                  |   39 -
 tests/qtest/fuzz/fuzz.c                            |    2 +-
 tests/qtest/fuzz/fuzz.h                            |    2 +-
 tests/qtest/fuzz/i440fx_fuzz.c                     |    6 +-
 tests/qtest/fuzz/meson.build                       |   34 +
 tests/qtest/fuzz/qos_fuzz.c                        |    2 +-
 tests/qtest/fuzz/virtio_net_fuzz.c                 |    5 +-
 tests/qtest/fuzz/virtio_scsi_fuzz.c                |    2 +-
 tests/qtest/fw_cfg-test.c                          |    2 +-
 tests/qtest/hd-geo-test.c                          |    2 +-
 tests/qtest/hexloader-test.c                       |    2 +-
 tests/qtest/ide-test.c                             |    2 +-
 tests/qtest/ipoctal232-test.c                      |    2 +-
 tests/qtest/ivshmem-test.c                         |    2 +-
 tests/qtest/libqos/aarch64-xlnx-zcu102-machine.c   |    4 +-
 tests/qtest/libqos/ahci.c                          |    6 +-
 tests/qtest/libqos/ahci.h                          |    6 +-
 tests/qtest/libqos/arm-imx25-pdk-machine.c         |    6 +-
 tests/qtest/libqos/arm-n800-machine.c              |    6 +-
 tests/qtest/libqos/arm-raspi2-machine.c            |    4 +-
 tests/qtest/libqos/arm-sabrelite-machine.c         |    4 +-
 tests/qtest/libqos/arm-smdkc210-machine.c          |    4 +-
 tests/qtest/libqos/arm-virt-machine.c              |    6 +-
 tests/qtest/libqos/arm-xilinx-zynq-a9-machine.c    |    4 +-
 tests/qtest/libqos/e1000e.c                        |    6 +-
 tests/qtest/libqos/e1000e.h                        |    2 +-
 tests/qtest/libqos/fw_cfg.c                        |    2 +-
 tests/qtest/libqos/i2c-imx.c                       |    2 +-
 tests/qtest/libqos/i2c-omap.c                      |    2 +-
 tests/qtest/libqos/i2c.c                           |    2 +-
 tests/qtest/libqos/i2c.h                           |    2 +-
 tests/qtest/libqos/libqos-pc.c                     |    6 +-
 tests/qtest/libqos/libqos-pc.h                     |    2 +-
 tests/qtest/libqos/libqos-spapr.c                  |    6 +-
 tests/qtest/libqos/libqos-spapr.h                  |    2 +-
 tests/qtest/libqos/libqos.c                        |    4 +-
 tests/qtest/libqos/libqos.h                        |    4 +-
 tests/qtest/{ => libqos}/libqtest.h                |    0
 tests/qtest/libqos/malloc-pc.c                     |    4 +-
 tests/qtest/libqos/malloc-pc.h                     |    2 +-
 tests/qtest/libqos/malloc-spapr.c                  |    2 +-
 tests/qtest/libqos/malloc-spapr.h                  |    2 +-
 tests/qtest/libqos/malloc.c                        |    2 +-
 tests/qtest/libqos/meson.build                     |   57 +
 tests/qtest/libqos/pci-pc.c                        |    2 +-
 tests/qtest/libqos/pci-pc.h                        |    6 +-
 tests/qtest/libqos/pci-spapr.c                     |    6 +-
 tests/qtest/libqos/pci-spapr.h                     |    6 +-
 tests/qtest/libqos/pci.c                           |    4 +-
 tests/qtest/libqos/pci.h                           |    2 +-
 tests/qtest/libqos/ppc64_pseries-machine.c         |    4 +-
 tests/qtest/libqos/qgraph.c                        |    4 +-
 tests/qtest/libqos/qgraph.h                        |    8 +-
 tests/qtest/libqos/qgraph_internal.h               |    4 +-
 tests/qtest/libqos/qos_external.c                  |    8 +-
 tests/qtest/libqos/qos_external.h                  |    4 +-
 tests/qtest/libqos/rtas.c                          |    2 +-
 tests/qtest/libqos/rtas.h                          |    2 +-
 tests/qtest/libqos/sdhci.c                         |    2 +-
 tests/qtest/libqos/sdhci.h                         |    2 +-
 tests/qtest/libqos/tpci200.c                       |    4 +-
 tests/qtest/libqos/usb.c                           |    2 +-
 tests/qtest/libqos/usb.h                           |    2 +-
 tests/qtest/libqos/virtio-9p.c                     |    4 +-
 tests/qtest/libqos/virtio-9p.h                     |    6 +-
 tests/qtest/libqos/virtio-balloon.c                |    4 +-
 tests/qtest/libqos/virtio-balloon.h                |    6 +-
 tests/qtest/libqos/virtio-blk.c                    |    4 +-
 tests/qtest/libqos/virtio-blk.h                    |    6 +-
 tests/qtest/libqos/virtio-mmio.c                   |    8 +-
 tests/qtest/libqos/virtio-mmio.h                   |    4 +-
 tests/qtest/libqos/virtio-net.c                    |    4 +-
 tests/qtest/libqos/virtio-net.h                    |    6 +-
 tests/qtest/libqos/virtio-pci.c                    |   14 +-
 tests/qtest/libqos/virtio-pci.h                    |    6 +-
 tests/qtest/libqos/virtio-rng.c                    |    4 +-
 tests/qtest/libqos/virtio-rng.h                    |    6 +-
 tests/qtest/libqos/virtio-scsi.c                   |    4 +-
 tests/qtest/libqos/virtio-scsi.h                   |    6 +-
 tests/qtest/libqos/virtio-serial.c                 |    4 +-
 tests/qtest/libqos/virtio-serial.h                 |    6 +-
 tests/qtest/libqos/virtio.c                        |    2 +-
 tests/qtest/libqos/virtio.h                        |    2 +-
 tests/qtest/libqos/x86_64_pc-machine.c             |    2 +-
 tests/qtest/libqtest-single.h                      |    2 +-
 tests/qtest/libqtest.c                             |    2 +-
 tests/qtest/m48t59-test.c                          |    2 +-
 tests/qtest/machine-none-test.c                    |    2 +-
 tests/qtest/megasas-test.c                         |    2 +-
 tests/qtest/meson.build                            |  254 ++++
 tests/qtest/microbit-test.c                        |    2 +-
 tests/qtest/migration-helpers.h                    |    2 +-
 tests/qtest/migration-test.c                       |    4 +-
 tests/qtest/modules-test.c                         |    2 +-
 tests/qtest/ne2000-test.c                          |    2 +-
 tests/qtest/numa-test.c                            |    2 +-
 tests/qtest/nvme-test.c                            |    2 +-
 tests/qtest/pca9552-test.c                         |    2 +-
 tests/qtest/pci-test.c                             |    2 +-
 tests/qtest/pcnet-test.c                           |    2 +-
 tests/qtest/pflash-cfi02-test.c                    |    2 +-
 tests/qtest/pnv-xscom-test.c                       |    2 +-
 tests/qtest/prom-env-test.c                        |    2 +-
 tests/qtest/pvpanic-test.c                         |    2 +-
 tests/qtest/pxe-test.c                             |    2 +-
 tests/qtest/q35-test.c                             |    2 +-
 tests/qtest/qmp-cmd-test.c                         |    2 +-
 tests/qtest/qmp-test.c                             |    2 +-
 tests/qtest/qom-test.c                             |    2 +-
 tests/qtest/rtas-test.c                            |    4 +-
 tests/qtest/sdhci-test.c                           |    2 +-
 tests/qtest/spapr-phb-test.c                       |    2 +-
 tests/qtest/tco-test.c                             |    2 +-
 tests/qtest/test-filter-mirror.c                   |    2 +-
 tests/qtest/test-filter-redirector.c               |    2 +-
 tests/qtest/test-hmp.c                             |    2 +-
 tests/qtest/tpm-crb-swtpm-test.c                   |    2 +-
 tests/qtest/tpm-tis-device-swtpm-test.c            |    2 +-
 tests/qtest/tpm-tis-swtpm-test.c                   |    2 +-
 tests/qtest/tpm-util.c                             |    2 +-
 tests/qtest/tulip-test.c                           |    2 +-
 tests/qtest/virtio-rng-test.c                      |    2 +-
 tests/qtest/virtio-test.c                          |    2 +-
 tests/qtest/vmgenid-test.c                         |    2 +-
 tests/qtest/vmxnet3-test.c                         |    2 +-
 tests/qtest/wdt_ib700-test.c                       |    2 +-
 tests/tcg/configure.sh                             |    4 +-
 tests/test-qga.c                                   |   10 +-
 tests/test-qgraph.c                                |    5 +-
 tests/vm/Makefile.include                          |    6 +-
 tools/meson.build                                  |    7 +
 tools/virtiofsd/Makefile.objs                      |   12 -
 tools/virtiofsd/meson.build                        |   17 +
 tools/virtiofsd/passthrough_ll.c                   |    2 +-
 .../virtiofsd/{seccomp.c => passthrough_seccomp.c} |    2 +-
 .../virtiofsd/{seccomp.h => passthrough_seccomp.h} |    0
 trace/Makefile.objs                                |   59 -
 trace/control-target.c                             |    2 +-
 trace/control.c                                    |    2 +-
 trace/meson.build                                  |   99 ++
 ui/Makefile.objs                                   |   73 -
 ui/meson.build                                     |  114 ++
 ui/shader.c                                        |    6 +-
 ui/shader/meson.build                              |   15 +
 ui/trace.h                                         |    1 +
 ui/vnc-enc-zrle.c                                  |   22 +-
 ui/{vnc-enc-zrle.inc.c => vnc-enc-zrle.inc}        |    0
 util/Makefile.objs                                 |   83 --
 util/meson.build                                   |   65 +
 util/trace.h                                       |    1 +
 version.texi.in                                    |    2 +
 739 files changed, 8491 insertions(+), 7194 deletions(-)
 delete mode 100644 Makefile.target
 delete mode 100644 accel/Makefile.objs
 delete mode 100644 accel/kvm/Makefile.objs
 create mode 100644 accel/kvm/meson.build
 create mode 100644 accel/kvm/trace.h
 create mode 100644 accel/meson.build
 delete mode 100644 accel/stubs/Makefile.objs
 create mode 100644 accel/stubs/meson.build
 delete mode 100644 accel/tcg/Makefile.objs
 rename accel/tcg/{atomic_common.inc.c => atomic_common.inc} (100%)
 create mode 100644 accel/tcg/meson.build
 create mode 100644 accel/tcg/trace.h
 delete mode 100644 accel/xen/Makefile.objs
 create mode 100644 accel/xen/meson.build
 delete mode 100644 audio/Makefile.objs
 create mode 100644 audio/meson.build
 create mode 100644 audio/trace.h
 delete mode 100644 authz/Makefile.objs
 create mode 100644 authz/meson.build
 create mode 100644 authz/trace.h
 delete mode 100644 backends/Makefile.objs
 create mode 100644 backends/meson.build
 delete mode 100644 backends/tpm/Makefile.objs
 create mode 100644 backends/tpm/meson.build
 create mode 100644 backends/tpm/trace.h
 create mode 100644 backends/trace.h
 delete mode 100644 block/Makefile.objs
 create mode 100644 block/meson.build
 delete mode 100644 block/monitor/Makefile.objs
 create mode 100644 block/monitor/meson.build
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
 delete mode 100644 contrib/vhost-user-blk/Makefile.objs
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
 delete mode 100644 dump/Makefile.objs
 create mode 100644 dump/meson.build
 rename fpu/{softfloat-specialize.inc.c => softfloat-specialize.inc} (100%)
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
 delete mode 100644 hw/avr/Makefile.objs
 create mode 100644 hw/avr/meson.build
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
 create mode 100644 hw/core/trace.h
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
 create mode 100644 hw/hyperv/trace.h
 delete mode 100644 hw/i2c/Makefile.objs
 create mode 100644 hw/i2c/meson.build
 create mode 100644 hw/i2c/trace.h
 delete mode 100644 hw/i386/Makefile.objs
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
 delete mode 100644 hw/m68k/Makefile.objs
 create mode 100644 hw/m68k/meson.build
 delete mode 100644 hw/mem/Makefile.objs
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
 delete mode 100644 hw/rx/Makefile.objs
 create mode 100644 hw/rx/meson.build
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
 create mode 100644 hw/ssi/trace.h
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
 delete mode 100644 hw/usb/Makefile.objs
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
 delete mode 100644 linux-user/alpha/Makefile.objs
 create mode 100644 linux-user/alpha/meson.build
 delete mode 100644 linux-user/arm/Makefile.objs
 create mode 100644 linux-user/arm/meson.build
 delete mode 100644 linux-user/arm/nwfpe/Makefile.objs
 create mode 100644 linux-user/arm/nwfpe/meson.build
 delete mode 100644 linux-user/hppa/Makefile.objs
 create mode 100644 linux-user/hppa/meson.build
 delete mode 100644 linux-user/i386/Makefile.objs
 create mode 100644 linux-user/i386/meson.build
 create mode 100644 linux-user/i386/syscall_nr.h
 delete mode 100644 linux-user/m68k/Makefile.objs
 create mode 100644 linux-user/m68k/meson.build
 create mode 100644 linux-user/meson.build
 delete mode 100644 linux-user/microblaze/Makefile.objs
 create mode 100644 linux-user/microblaze/meson.build
 delete mode 100644 linux-user/mips/Makefile.objs
 create mode 100644 linux-user/mips/meson.build
 create mode 100644 linux-user/mips/syscall_nr.h
 delete mode 100644 linux-user/mips64/Makefile.objs
 create mode 100644 linux-user/mips64/meson.build
 create mode 100644 linux-user/mips64/syscall_nr.h
 delete mode 100644 linux-user/ppc/Makefile.objs
 create mode 100644 linux-user/ppc/meson.build
 delete mode 100644 linux-user/s390x/Makefile.objs
 create mode 100644 linux-user/s390x/meson.build
 delete mode 100644 linux-user/sh4/Makefile.objs
 create mode 100644 linux-user/sh4/meson.build
 delete mode 100644 linux-user/sparc/Makefile.objs
 create mode 100644 linux-user/sparc/meson.build
 delete mode 100644 linux-user/sparc64/Makefile.objs
 create mode 100644 linux-user/sparc64/meson.build
 create mode 100644 linux-user/trace.h
 delete mode 100644 linux-user/x86_64/Makefile.objs
 create mode 100644 linux-user/x86_64/meson.build
 create mode 100644 linux-user/x86_64/syscall_nr.h
 delete mode 100644 linux-user/xtensa/Makefile.objs
 create mode 100644 linux-user/xtensa/meson.build
 rename memory_ldst.inc.c => memory_ldst.inc (100%)
 create mode 160000 meson
 create mode 100644 meson.build
 create mode 100644 meson_options.txt
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
 create mode 100644 pc-bios/meson.build
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
 create mode 100644 scripts/check_sparse.py
 delete mode 100755 scripts/create_config
 create mode 100755 scripts/grepy.sh
 mode change 100644 => 100755 scripts/hxtool
 mode change 100644 => 100755 scripts/modules/module_block.py
 create mode 100644 scripts/mtest2make.py
 create mode 100755 scripts/ninjatool.py
 create mode 100755 scripts/qemu-version.sh
 create mode 100755 scripts/undefsym.sh
 delete mode 100644 scsi/Makefile.objs
 create mode 100644 scsi/meson.build
 create mode 100644 scsi/trace.h
 delete mode 100644 softmmu/Makefile.objs
 create mode 100644 softmmu/meson.build
 delete mode 100644 storage-daemon/Makefile.objs
 create mode 100644 storage-daemon/meson.build
 delete mode 100644 storage-daemon/qapi/Makefile.objs
 create mode 100644 storage-daemon/qapi/meson.build
 rename qemu-storage-daemon.c => storage-daemon/qemu-storage-daemon.c (100%)
 delete mode 100644 stubs/Makefile.objs
 create mode 100644 stubs/meson.build
 delete mode 100644 target/alpha/Makefile.objs
 create mode 100644 target/alpha/meson.build
 delete mode 100644 target/arm/Makefile.objs
 create mode 100644 target/arm/meson.build
 create mode 100644 target/arm/trace.h
 rename target/arm/{translate-neon.inc.c => translate-neon.inc} (99%)
 rename target/arm/{translate-vfp.inc.c => translate-vfp.inc} (99%)
 delete mode 100644 target/avr/Makefile.objs
 create mode 100644 target/avr/meson.build
 delete mode 100644 target/cris/Makefile.objs
 create mode 100644 target/cris/meson.build
 rename target/cris/{translate_v10.inc.c => translate_v10.inc} (100%)
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
 rename target/mips/{translate_init.inc.c => translate_init.inc} (100%)
 delete mode 100644 target/moxie/Makefile.objs
 create mode 100644 target/moxie/meson.build
 delete mode 100644 target/nios2/Makefile.objs
 create mode 100644 target/nios2/meson.build
 delete mode 100644 target/openrisc/Makefile.objs
 create mode 100644 target/openrisc/meson.build
 delete mode 100644 target/ppc/Makefile.objs
 create mode 100644 target/ppc/meson.build
 rename target/ppc/{mfrom_table.inc.c => mfrom_table.inc} (100%)
 create mode 100644 target/ppc/trace.h
 rename target/ppc/translate/{dfp-impl.inc.c => dfp-impl.inc} (100%)
 rename target/ppc/translate/{dfp-ops.inc.c => dfp-ops.inc} (100%)
 rename target/ppc/translate/{fp-impl.inc.c => fp-impl.inc} (100%)
 rename target/ppc/translate/{fp-ops.inc.c => fp-ops.inc} (100%)
 rename target/ppc/translate/{spe-impl.inc.c => spe-impl.inc} (100%)
 rename target/ppc/translate/{spe-ops.inc.c => spe-ops.inc} (100%)
 rename target/ppc/translate/{vmx-impl.inc.c => vmx-impl.inc} (100%)
 rename target/ppc/translate/{vmx-ops.inc.c => vmx-ops.inc} (100%)
 rename target/ppc/translate/{vsx-impl.inc.c => vsx-impl.inc} (100%)
 rename target/ppc/translate/{vsx-ops.inc.c => vsx-ops.inc} (100%)
 rename target/ppc/{translate_init.inc.c => translate_init.inc} (100%)
 delete mode 100644 target/riscv/Makefile.objs
 rename target/riscv/insn_trans/{trans_privileged.inc.c => trans_privileged.inc} (100%)
 rename target/riscv/insn_trans/{trans_rva.inc.c => trans_rva.inc} (100%)
 rename target/riscv/insn_trans/{trans_rvd.inc.c => trans_rvd.inc} (100%)
 rename target/riscv/insn_trans/{trans_rvf.inc.c => trans_rvf.inc} (100%)
 rename target/riscv/insn_trans/{trans_rvh.inc.c => trans_rvh.inc} (100%)
 rename target/riscv/insn_trans/{trans_rvi.inc.c => trans_rvi.inc} (100%)
 rename target/riscv/insn_trans/{trans_rvm.inc.c => trans_rvm.inc} (100%)
 rename target/riscv/insn_trans/{trans_rvv.inc.c => trans_rvv.inc} (100%)
 create mode 100644 target/riscv/meson.build
 create mode 100644 target/riscv/trace.h
 delete mode 100644 target/rx/Makefile.objs
 create mode 100644 target/rx/meson.build
 delete mode 100644 target/s390x/Makefile.objs
 create mode 100644 target/s390x/meson.build
 create mode 100644 target/s390x/trace.h
 rename target/s390x/{translate_vx.inc.c => translate_vx.inc} (100%)
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
 rename target/xtensa/core-dc232b/{gdb-config.inc.c => gdb-config.inc} (100%)
 rename target/xtensa/core-dc232b/{xtensa-modules.inc.c => xtensa-modules.inc} (100%)
 rename target/xtensa/core-dc233c/{gdb-config.inc.c => gdb-config.inc} (100%)
 rename target/xtensa/core-dc233c/{xtensa-modules.inc.c => xtensa-modules.inc} (100%)
 rename target/xtensa/core-de212/{gdb-config.inc.c => gdb-config.inc} (100%)
 rename target/xtensa/core-de212/{xtensa-modules.inc.c => xtensa-modules.inc} (100%)
 rename target/xtensa/core-fsf/{xtensa-modules.inc.c => xtensa-modules.inc} (100%)
 rename target/xtensa/core-sample_controller/{gdb-config.inc.c => gdb-config.inc} (100%)
 rename target/xtensa/core-sample_controller/{xtensa-modules.inc.c => xtensa-modules.inc} (100%)
 rename target/xtensa/core-test_kc705_be/{gdb-config.inc.c => gdb-config.inc} (100%)
 rename target/xtensa/core-test_kc705_be/{xtensa-modules.inc.c => xtensa-modules.inc} (100%)
 rename target/xtensa/core-test_mmuhifi_c3/{gdb-config.inc.c => gdb-config.inc} (100%)
 rename target/xtensa/core-test_mmuhifi_c3/{xtensa-modules.inc.c => xtensa-modules.inc} (100%)
 create mode 100644 target/xtensa/meson.build
 rename tcg/aarch64/{tcg-target.inc.c => tcg-target.inc} (99%)
 rename tcg/arm/{tcg-target.inc.c => tcg-target.inc} (99%)
 rename tcg/i386/{tcg-target.inc.c => tcg-target.inc} (99%)
 rename tcg/mips/{tcg-target.inc.c => tcg-target.inc} (99%)
 rename tcg/ppc/{tcg-target.inc.c => tcg-target.inc} (99%)
 rename tcg/riscv/{tcg-target.inc.c => tcg-target.inc} (99%)
 rename tcg/s390/{tcg-target.inc.c => tcg-target.inc} (99%)
 rename tcg/sparc/{tcg-target.inc.c => tcg-target.inc} (99%)
 rename tcg/{tcg-ldst.inc.c => tcg-ldst.inc} (100%)
 rename tcg/{tcg-pool.inc.c => tcg-pool.inc} (99%)
 rename tcg/tci/{tcg-target.inc.c => tcg-target.inc} (100%)
 delete mode 100644 tests/fp/Makefile
 create mode 100644 tests/fp/meson.build
 rename tests/fp/{wrap.inc.c => wrap.inc} (100%)
 create mode 100644 tests/meson.build
 delete mode 100644 tests/plugin/Makefile
 create mode 100644 tests/plugin/meson.build
 create mode 100644 tests/qapi-schema/meson.build
 create mode 100644 tests/qemu-iotests/meson.build
 delete mode 100644 tests/qtest/Makefile.include
 delete mode 100644 tests/qtest/fuzz/Makefile.include
 create mode 100644 tests/qtest/fuzz/meson.build
 rename tests/qtest/{ => libqos}/libqtest.h (100%)
 create mode 100644 tests/qtest/libqos/meson.build
 create mode 100644 tests/qtest/meson.build
 create mode 100644 tools/meson.build
 delete mode 100644 tools/virtiofsd/Makefile.objs
 create mode 100644 tools/virtiofsd/meson.build
 rename tools/virtiofsd/{seccomp.c => passthrough_seccomp.c} (99%)
 rename tools/virtiofsd/{seccomp.h => passthrough_seccomp.h} (100%)
 delete mode 100644 trace/Makefile.objs
 create mode 100644 trace/meson.build
 delete mode 100644 ui/Makefile.objs
 create mode 100644 ui/meson.build
 create mode 100644 ui/shader/meson.build
 create mode 100644 ui/trace.h
 rename ui/{vnc-enc-zrle.inc.c => vnc-enc-zrle.inc} (100%)
 delete mode 100644 util/Makefile.objs
 create mode 100644 util/meson.build
 create mode 100644 util/trace.h
 create mode 100644 version.texi.in

-- 
1.8.3.1


