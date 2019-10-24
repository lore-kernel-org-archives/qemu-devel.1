Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D4AACA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:21:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04C2421906
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hp3A+2Hg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04C2421906
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNdzo-0007HW-O8
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 10:21:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34579)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iNdid-0006du-4F
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iNdib-0007a8-ID
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:03 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:38047)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iNdib-0007Yi-2P
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:01 -0400
Received: by mail-wm1-x333.google.com with SMTP id 3so2739376wmi.3
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 07:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=U8OtQi7dnENRNd0ivyUYGx9uZSTNBjcwHQ7Qm/bv+/4=;
 b=Hp3A+2HgbcCZ9o/v22FU79aqG9gW5SJPv2kzperAzMp15QWPr3mKgtWb1uu4fAXTdx
 ze/BpablqYwSLWlHMlVL3/uV6/u9JAIvTU53FpB+Z6o5jgkkL74aC4jV7Ft5e4UlIt6w
 XU78t1jXHMZVQOozkWBUV0EtssCuyS57iWSumy3M/RKGPi+P0/4ZsFEPdyxRHOyV2dlQ
 tpIetNXU6E363hILKTR4Wer/JsHc6G9oQDc9GdL25U4W8INAX5zaX08NZW78vAhVrMSB
 u7D7aNqvAcTbXyohJ3iGbT6q+4I8i+IOJVpRsMZUX4Uq1myd+CiE0uF4P2UTt8jrIozz
 KWlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=U8OtQi7dnENRNd0ivyUYGx9uZSTNBjcwHQ7Qm/bv+/4=;
 b=Ws1S/IbDQxkre6xSIS4eSEkZNPkzMOTY6OkRbKcqsZKyjcNpej0ryCcS+ZET8bfGUF
 zlIFIPnoRwTYSOYhekUJQcUir/gdX+HjAZcbJcjVUtw8a+RK1lGkCeJIEdQdfGghZPkL
 w+eLp7dGTKd3Is/tz4JjCso4gWqVI2XaHanjw3Ta/Y247gNAKs0LCS9AqlRL7yPesKvQ
 YbhKmc2B6IoJaW0knI9YJ5wU2GybRLs4I1OYALy7XPqyvfsCFA+ABclf3lM4ASFZ7lt0
 7+IAzWIvr9U9LcJZIO3Ny0kZIANfX31300C5R01xsT6kbFJ9j1nKWmjlpjp95qpnrEr4
 P8Mw==
X-Gm-Message-State: APjAAAV8B/PrKjVCGHlJuNh9gkT7XIcsekFf+OctbvVt2aNEzTih7xU4
 tc8vSBQ4L5Hng/pvqYvSBKZsZnWj
X-Google-Smtp-Source: APXvYqwV54jkJUM/bmIDcVD5ReXdtbVbfv/+5pr0tHHkQOneV8ZSxuXobbvSc/Pxv8yis2hR6OGzDg==
X-Received: by 2002:a1c:10b:: with SMTP id 11mr4904385wmb.118.1571925837713;
 Thu, 24 Oct 2019 07:03:57 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b7sm10610155wrn.53.2019.10.24.07.03.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Oct 2019 07:03:56 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/39] Misc (mostly x86) patches for 2019-10-24
Date: Thu, 24 Oct 2019 16:03:16 +0200
Message-Id: <1571925835-31930-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::333
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

The following changes since commit e9d42461920f6f40f4d847a5ba18e90d095ed0b9:

  Merge remote-tracking branch 'remotes/kraxel/tags/audio-20191018-pull-request' into staging (2019-10-18 14:13:11 +0100)

are available in the git repository at:


  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to a263f81cb4b302eb392898bdc4ad4381e1961629:

  i386: implement IGNNE (2019-10-24 16:02:04 +0200)

----------------------------------------------------------------
* Bulgarian translation update (Alexander)
* RTC and PC refactorings (Hervé, Philippe, Sergio)
* RTC fix (Marcelo)
* More comprehensive MCE logging (Mario)
* x86 IGNNE implementation (Paolo)
* Microvm machine type (Sergio)
* Support for UMONITOR/UMWAIT/TPAUSE (Tao)
* Do not use %m in common code (Thomas)
* NoNonArchitecturalCoreSharing Hyper-V enlightenment (Vitaly)
* getpagesize cleanups (Wei)

----------------------------------------------------------------
Alexander Shopov (1):
      Updated Bulgarian translation (19) - 4.1.0

Hervé Poussineau (2):
      mc146818rtc: move structure to header file
      mc146818rtc: always register rtc to rtc list

Laurent Vivier (1):
      runstate: ignore exit request in finish migrate state

Marcelo Tosatti (1):
      mc146818rtc: fix timer interrupt reinjection

Mario Smarduch (1):
      target/i386: log MCE guest and host addresses

Paolo Bonzini (6):
      memory-device: simplify Makefile.objs conditions
      hw/i386: split PCMachineState deriving X86MachineState from it
      audio: fix missing break
      target/i386: move FERR handling to target/i386
      target/i386: introduce cpu_set_fpus
      i386: implement IGNNE

Philippe Mathieu-Daudé (7):
      hw/timer/mc146818rtc: Only include qapi-commands-misc on I386
      hw/i386/pc: Extract pc_gsi_create()
      hw/i386/pc: Move gsi_state creation code
      hw/i386/pc: Extract pc_i8259_create()
      hw/i386/pc: Remove kvm_i386.h include
      mc146818rtc: Move RTC_ISA_IRQ definition
      mc146818rtc: Include mc146818rtc_regs.h directly in mc146818rtc.c

Sergio Lopez (14):
      hw/virtio: Factorize virtio-mmio headers
      hw/i386/pc: rename functions shared with non-PC machines
      hw/i386/pc: fix code style issues on functions that will be moved out
      hw/i386/pc: replace use of strtol with qemu_strtoui in x86_load_linux()
      hw/i386/pc: avoid an assignment in if condition in x86_load_linux()
      hw/i386/pc: remove commented out code from x86_load_linux()
      hw/i386/pc: move shared x86 functions to x86.c and export them
      hw/i386: make x86.c independent from PCMachineState
      fw_cfg: add "modify" functions for all types
      hw/intc/apic: reject pic ints if isa_pic == NULL
      roms: add microvm-bios (qboot) as binary and git submodule
      docs/microvm.rst: document the new microvm machine type
      hw/i386: Introduce the microvm machine type
      MAINTAINERS: add microvm related files

Tao Xu (2):
      x86/cpu: Add support for UMONITOR/UMWAIT/TPAUSE
      target/i386: Add support for save/load IA32_UMWAIT_CONTROL MSR

Thomas Huth (1):
      Do not use %m in common code to print error messages

Vitaly Kuznetsov (1):
      i386/kvm: add NoNonArchitecturalCoreSharing Hyper-V enlightenment

Wei Yang (2):
      checkpatch: suggest qemu_real_host_page_size instead of getpagesize() or sysconf(_SC_PAGESIZE)
      core: replace getpagesize() with qemu_real_host_page_size

 .gitmodules                         |   3 +
 MAINTAINERS                         |   9 +
 accel/kvm/kvm-all.c                 |   6 +-
 audio/paaudio.c                     |   1 +
 backends/hostmem.c                  |   2 +-
 block.c                             |   4 +-
 block/file-posix.c                  |   9 +-
 block/io.c                          |   2 +-
 block/parallels.c                   |   2 +-
 block/qcow2-cache.c                 |   2 +-
 contrib/vhost-user-gpu/vugbm.c      |   2 +-
 default-configs/i386-softmmu.mak    |   1 +
 docs/hyperv.txt                     |  13 +
 docs/microvm.rst                    | 108 +++++
 exec.c                              |   6 +-
 hw/acpi/cpu_hotplug.c               |  10 +-
 hw/i386/Kconfig                     |  10 +
 hw/i386/Makefile.objs               |   2 +
 hw/i386/acpi-build.c                |  29 +-
 hw/i386/amd_iommu.c                 |   3 +-
 hw/i386/intel_iommu.c               |   3 +-
 hw/i386/microvm.c                   | 572 +++++++++++++++++++++++++
 hw/i386/pc.c                        | 832 +++++-------------------------------
 hw/i386/pc_piix.c                   |  65 ++-
 hw/i386/pc_q35.c                    |  62 +--
 hw/i386/pc_sysfw.c                  |  60 +--
 hw/i386/x86.c                       | 795 ++++++++++++++++++++++++++++++++++
 hw/i386/xen/xen-hvm.c               |  28 +-
 hw/intc/apic.c                      |   2 +-
 hw/intc/ioapic.c                    |   2 +-
 hw/intc/s390_flic_kvm.c             |   2 +-
 hw/mem/Makefile.objs                |   2 +-
 hw/misc/tmp421.c                    |   4 +-
 hw/nvram/fw_cfg.c                   |  29 ++
 hw/ppc/mac_newworld.c               |   2 +-
 hw/ppc/spapr_pci.c                  |   2 +-
 hw/rdma/vmw/pvrdma_main.c           |   2 +-
 hw/timer/mc146818rtc.c              |  94 ++--
 hw/vfio/spapr.c                     |   7 +-
 hw/virtio/virtio-mmio.c             |  48 +--
 include/exec/ram_addr.h             |   2 +-
 include/hw/i386/microvm.h           |  71 +++
 include/hw/i386/pc.h                |  32 +-
 include/hw/i386/x86.h               |  96 +++++
 include/hw/nvram/fw_cfg.h           |  42 ++
 include/hw/timer/mc146818rtc.h      |  36 +-
 include/hw/timer/mc146818rtc_regs.h |   2 -
 include/hw/virtio/virtio-mmio.h     |  73 ++++
 include/qemu/osdep.h                |   4 +-
 migration/migration.c               |   2 +-
 migration/postcopy-ram.c            |   4 +-
 monitor/misc.c                      |   2 +-
 pc-bios/bios-microvm.bin            | Bin 0 -> 65536 bytes
 po/bg.po                            |  10 +-
 roms/Makefile                       |   6 +
 roms/qboot                          |   1 +
 scripts/checkpatch.pl               |   6 +
 target/i386/cpu.c                   |   4 +-
 target/i386/cpu.h                   |  11 +-
 target/i386/fpu_helper.c            |  60 ++-
 target/i386/hyperv-proto.h          |   1 +
 target/i386/kvm.c                   |  74 +++-
 target/i386/machine.c               |  20 +
 target/ppc/kvm.c                    |   2 +-
 tests/rtc-test.c                    |   1 +
 tests/vhost-user-bridge.c           |   8 +-
 util/main-loop.c                    |   3 +-
 util/mmap-alloc.c                   |  10 +-
 util/oslib-posix.c                  |   4 +-
 util/oslib-win32.c                  |   2 +-
 util/systemd.c                      |   4 +-
 util/vfio-helpers.c                 |  12 +-
 vl.c                                |   3 +
 73 files changed, 2338 insertions(+), 1107 deletions(-)
 create mode 100644 docs/microvm.rst
 create mode 100644 hw/i386/microvm.c
 create mode 100644 hw/i386/x86.c
 create mode 100644 include/hw/i386/microvm.h
 create mode 100644 include/hw/i386/x86.h
 create mode 100644 include/hw/virtio/virtio-mmio.h
 create mode 100644 pc-bios/bios-microvm.bin
 create mode 160000 roms/qboot
-- 
1.8.3.1


