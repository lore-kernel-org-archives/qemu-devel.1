Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1548EC433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 07:57:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D767E21924
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 07:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPK6w/Eq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D767E21924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQQo4-0005sp-Po
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 03:57:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35658)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chetan4windows@gmail.com>)
 id 1kQQkc-0003In-4b; Thu, 08 Oct 2020 03:54:12 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:43298)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chetan4windows@gmail.com>)
 id 1kQQkW-0001Ep-L1; Thu, 08 Oct 2020 03:54:09 -0400
Received: by mail-pf1-x443.google.com with SMTP id a200so3305671pfa.10;
 Thu, 08 Oct 2020 00:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YqM2YifAWwMNx+6Ws0rnADAbKCoMtPyDjfsN9BComvg=;
 b=gPK6w/EqkBwZr9Jg3wfxMPkGq62s379WIKWVa9lZL1yo5zMScB55wikR7a3U/heAaI
 U22oIdiKOg7Uw6li3rFfy2MuzM5phWS3OtzhP9sA8KdXd/xi+kyzSO/F5/nH26ni+N4H
 NgyoM+jwGekRKiZ0ZPHYXmLWQ7nTAQj0GeB+idi0nGKCsEa3O8jQDXfr8yWcU+0l1zKp
 idhXfo3otiUD0KjE8WmxsD89FtxFTIMNTPGevC2usFkkdPO3eVGYfzWxwcp6TCHpVwa9
 Hwq3rFmJ5gztv24oqbGapR5UkjXEjcinzWBOB+2p0Xmq7nywmj7KpsxVeJuSSA2MZ5I4
 GHOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YqM2YifAWwMNx+6Ws0rnADAbKCoMtPyDjfsN9BComvg=;
 b=HjDHp0Nb5tmFlt/v+3ezzNQR2Xph+U8o9+UEzlXgLWgaPLujfLymQJ9xcqFgid+nxg
 P7ruYn8fW1WfZ3Sih5GqGloxL6eDScR6UwQ9IpansrL5tlcO4Ei5F9P+ACj4+OLFX0Ug
 9iD0aLFQj/coOML9D8Pl+fxbPTXmkTEJeFW6A2CkeBtsmhWvVYH2TOTTPnehNzpu03of
 ivRmJ87+g6OLrYziYVZrxcmptHSXSaDxIvSSGsYR0xyf8atuz/SpMyQLlfY0XXgnbaz3
 zYO9ZgmIyETn0FHHshrQ63I46oEzRvc47xdTl+sriDKIG309HgBHymLszwQsZNcv/l6u
 gjJg==
X-Gm-Message-State: AOAM532/a6EfMzeHf/riTD4wOaLuxpAFlLLLGNY2L9h4BQCkjMCE/hwj
 IHmNegsQ4Qvhb7IUZRLz1Cnguok0NE/oWQ==
X-Google-Smtp-Source: ABdhPJz9vk4Am7GoBtpuWceo6IUCEBO6niKjL5b+PTkOthQ1/4KyKAGWWV90vbaJdwP7DOm/wDo0Ww==
X-Received: by 2002:a17:90b:19ce:: with SMTP id
 nm14mr7044492pjb.154.1602143638213; 
 Thu, 08 Oct 2020 00:53:58 -0700 (PDT)
Received: from pulp100.localdomain ([103.199.158.131])
 by smtp.gmail.com with ESMTPSA id n5sm5957044pff.190.2020.10.08.00.53.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2020 00:53:57 -0700 (PDT)
From: Chetan Pant <chetan4windows@gmail.com>
To: qemu-trivial@nongnu.org
Subject: [PATCH v2] Fixing LGPL version number
Date: Thu,  8 Oct 2020 07:52:22 +0000
Message-Id: <20201008075222.2093-1-chetan4windows@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=chetan4windows@gmail.com; helo=mail-pf1-x443.google.com
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
Cc: qemu-devel@nongnu.org, Chetan Pant <chetan4windows@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is no "version 2" of the "Lesser" General Public License. It is
either "GPL version 2.0" or "LGPL version 2.1". This patch replaces all
occurrences of "LGPL version 2" with "LGPL version 2.1" in comment section.

Also, It came to notice that some of the files that were edited for the change
were not following latest comment rules. For example using "//" to mark comment
instead of "/*". That is also fixed in this patch.

Signed-off-by: Chetan Pant <chetan4windows@gmail.com>
---
 authz/base.c                                 |  2 +-
 authz/list.c                                 |  2 +-
 authz/listfile.c                             |  2 +-
 authz/pamacct.c                              |  2 +-
 authz/simple.c                               |  2 +-
 backends/cryptodev-builtin.c                 |  2 +-
 backends/cryptodev-vhost-user.c              |  2 +-
 backends/cryptodev-vhost.c                   |  2 +-
 backends/cryptodev.c                         |  2 +-
 backends/tpm/tpm_emulator.c                  |  2 +-
 backends/tpm/tpm_passthrough.c               |  2 +-
 backends/tpm/tpm_util.c                      |  2 +-
 block/commit.c                               |  2 +-
 block/crypto.c                               |  2 +-
 block/crypto.h                               |  2 +-
 block/mirror.c                               |  2 +-
 block/qed-check.c                            |  2 +-
 block/qed-cluster.c                          |  2 +-
 block/qed-l2-cache.c                         |  2 +-
 block/qed-table.c                            |  2 +-
 block/qed.c                                  |  2 +-
 block/qed.h                                  |  2 +-
 block/stream.c                               |  2 +-
 block/vhdx-endian.c                          |  2 +-
 block/vhdx-log.c                             |  2 +-
 block/vhdx.c                                 |  2 +-
 block/vhdx.h                                 |  2 +-
 block/write-threshold.c                      |  2 +-
 cpus-common.c                                |  2 +-
 disas/lm32.c                                 |  2 +-
 exec-vary.c                                  |  2 +-
 exec.c                                       |  2 +-
 gdbstub.c                                    |  2 +-
 hw/acpi/core.c                               |  2 +-
 hw/acpi/hmat.c                               |  2 +-
 hw/acpi/hmat.h                               |  2 +-
 hw/acpi/ich9.c                               |  2 +-
 hw/acpi/nvdimm.c                             |  2 +-
 hw/acpi/pcihp.c                              |  2 +-
 hw/acpi/piix4.c                              |  2 +-
 hw/audio/milkymist-ac97.c                    |  2 +-
 hw/block/pflash_cfi01.c                      |  2 +-
 hw/block/pflash_cfi02.c                      |  2 +-
 hw/block/vhost-user-blk.c                    |  2 +-
 hw/char/lm32_juart.c                         |  2 +-
 hw/char/lm32_uart.c                          |  2 +-
 hw/char/milkymist-uart.c                     |  2 +-
 hw/core/bus.c                                |  2 +-
 hw/core/loader-fit.c                         |  2 +-
 hw/core/platform-bus.c                       |  2 +-
 hw/core/qdev.c                               |  2 +-
 hw/core/sysbus.c                             |  2 +-
 hw/display/bcm2835_fb.c                      |  2 +-
 hw/display/milkymist-tmu2.c                  |  2 +-
 hw/display/milkymist-vgafb.c                 |  2 +-
 hw/display/milkymist-vgafb_template.h        |  2 +-
 hw/gpio/mpc8xxx.c                            |  2 +-
 hw/i2c/pm_smbus.c                            |  2 +-
 hw/ide/ahci.c                                |  2 +-
 hw/ide/ahci_internal.h                       |  2 +-
 hw/ide/ich.c                                 |  2 +-
 hw/ide/qdev.c                                |  2 +-
 hw/input/milkymist-softusb.c                 |  2 +-
 hw/intc/apic.c                               |  2 +-
 hw/intc/apic_common.c                        |  2 +-
 hw/intc/arm_gicv2m.c                         |  2 +-
 hw/intc/arm_gicv3_its_kvm.c                  |  2 +-
 hw/intc/ioapic.c                             |  2 +-
 hw/intc/ioapic_common.c                      |  2 +-
 hw/intc/lm32_pic.c                           |  2 +-
 hw/intc/xics_pnv.c                           |  2 +-
 hw/isa/apm.c                                 |  2 +-
 hw/isa/i82378.c                              |  2 +-
 hw/isa/isa-bus.c                             |  2 +-
 hw/lm32/lm32_boards.c                        |  2 +-
 hw/lm32/lm32_hwsetup.h                       |  2 +-
 hw/lm32/milkymist.c                          |  2 +-
 hw/mem/nvdimm.c                              |  2 +-
 hw/mem/pc-dimm.c                             |  2 +-
 hw/mips/boston.c                             |  2 +-
 hw/mips/cps.c                                |  2 +-
 hw/misc/applesmc.c                           |  2 +-
 hw/misc/milkymist-hpdmc.c                    |  2 +-
 hw/misc/milkymist-pfpu.c                     |  2 +-
 hw/misc/mips_cpc.c                           |  2 +-
 hw/misc/mips_itu.c                           |  2 +-
 hw/net/e1000.c                               |  2 +-
 hw/net/e1000e.c                              | 66 ++++++++++----------
 hw/net/e1000e_core.c                         | 66 ++++++++++----------
 hw/net/e1000e_core.h                         | 66 ++++++++++----------
 hw/net/e1000x_common.c                       | 44 ++++++-------
 hw/net/e1000x_common.h                       | 44 ++++++-------
 hw/net/milkymist-minimac2.c                  |  2 +-
 hw/pci-bridge/i82801b11.c                    |  2 +-
 hw/pci-host/designware.c                     |  2 +-
 hw/pci-host/xilinx-pcie.c                    |  2 +-
 hw/ppc/pnv.c                                 |  2 +-
 hw/ppc/pnv_core.c                            |  2 +-
 hw/ppc/pnv_lpc.c                             |  2 +-
 hw/ppc/pnv_psi.c                             |  2 +-
 hw/ppc/pnv_xscom.c                           |  2 +-
 hw/ppc/ppce500_spin.c                        |  2 +-
 hw/ppc/spapr_iommu.c                         |  2 +-
 hw/ppc/spapr_vio.c                           |  2 +-
 hw/scsi/megasas.c                            |  2 +-
 hw/scsi/mptconfig.c                          |  2 +-
 hw/scsi/mptendian.c                          |  2 +-
 hw/scsi/mptsas.c                             |  2 +-
 hw/scsi/vhost-scsi-common.c                  |  2 +-
 hw/scsi/vhost-scsi.c                         |  2 +-
 hw/scsi/vhost-user-scsi.c                    |  2 +-
 hw/sd/milkymist-memcard.c                    |  2 +-
 hw/timer/hpet.c                              |  2 +-
 hw/timer/lm32_timer.c                        |  2 +-
 hw/timer/milkymist-sysctl.c                  |  2 +-
 hw/tpm/tpm_prop.h                            |  2 +-
 hw/tricore/tricore_testboard.c               |  2 +-
 hw/usb/ccid-card-emulated.c                  |  2 +-
 hw/usb/ccid.h                                |  2 +-
 hw/usb/hcd-ohci.c                            |  2 +-
 hw/usb/hcd-xhci-nec.c                        |  2 +-
 hw/usb/hcd-xhci-pci.c                        |  2 +-
 hw/usb/hcd-xhci-pci.h                        |  2 +-
 hw/usb/hcd-xhci.c                            |  2 +-
 hw/usb/hcd-xhci.h                            |  2 +-
 hw/virtio/vhost-scsi-pci.c                   |  2 +-
 hw/virtio/vhost-user-blk-pci.c               |  2 +-
 hw/virtio/vhost-user-input-pci.c             |  2 +-
 hw/virtio/vhost-user-scsi-pci.c              |  2 +-
 hw/xen/xen_pvdev.c                           |  2 +-
 include/authz/base.h                         |  2 +-
 include/authz/list.h                         |  2 +-
 include/authz/listfile.h                     |  2 +-
 include/authz/pamacct.h                      |  2 +-
 include/authz/simple.h                       |  2 +-
 include/block/write-threshold.h              |  2 +-
 include/exec/cpu-all.h                       |  2 +-
 include/exec/cpu-defs.h                      |  2 +-
 include/exec/cpu_ldst.h                      |  2 +-
 include/exec/cputlb.h                        |  2 +-
 include/exec/exec-all.h                      |  2 +-
 include/exec/ioport.h                        |  2 +-
 include/exec/memory_ldst.h.inc               |  2 +-
 include/exec/memory_ldst_cached.h.inc        |  2 +-
 include/exec/memory_ldst_phys.h.inc          |  2 +-
 include/exec/tb-context.h                    |  2 +-
 include/exec/tb-hash.h                       |  2 +-
 include/exec/user/thunk.h                    |  2 +-
 include/hw/acpi/acpi.h                       |  2 +-
 include/hw/acpi/ich9.h                       |  2 +-
 include/hw/acpi/pcihp.h                      |  2 +-
 include/hw/display/milkymist_tmu2.h          |  2 +-
 include/hw/i386/apic_internal.h              |  2 +-
 include/hw/i386/ioapic.h                     |  2 +-
 include/hw/i386/ioapic_internal.h            |  2 +-
 include/hw/ide/ahci.h                        |  2 +-
 include/hw/loader-fit.h                      |  2 +-
 include/hw/mips/cps.h                        |  2 +-
 include/hw/misc/mips_cpc.h                   |  2 +-
 include/hw/misc/mips_itu.h                   |  2 +-
 include/hw/pci-host/designware.h             |  2 +-
 include/hw/pci-host/spapr.h                  |  2 +-
 include/hw/pci-host/xilinx-pcie.h            |  2 +-
 include/hw/platform-bus.h                    |  2 +-
 include/hw/ppc/pnv.h                         |  2 +-
 include/hw/ppc/pnv_core.h                    |  2 +-
 include/hw/ppc/pnv_homer.h                   |  2 +-
 include/hw/ppc/pnv_lpc.h                     |  2 +-
 include/hw/ppc/pnv_occ.h                     |  2 +-
 include/hw/ppc/pnv_psi.h                     |  2 +-
 include/hw/ppc/pnv_xscom.h                   |  2 +-
 include/hw/ppc/spapr_vio.h                   |  2 +-
 include/hw/semihosting/semihost.h            |  2 +-
 include/hw/virtio/vhost-scsi-common.h        |  2 +-
 include/hw/virtio/vhost-scsi.h               |  2 +-
 include/hw/virtio/vhost-user-blk.h           |  2 +-
 include/hw/virtio/vhost-user-scsi.h          |  2 +-
 include/io/channel-buffer.h                  |  2 +-
 include/io/channel-command.h                 |  2 +-
 include/io/channel-file.h                    |  2 +-
 include/io/channel-socket.h                  |  2 +-
 include/io/channel-tls.h                     |  2 +-
 include/io/channel-util.h                    |  2 +-
 include/io/channel-watch.h                   |  2 +-
 include/io/channel-websock.h                 |  2 +-
 include/io/channel.h                         |  2 +-
 include/io/dns-resolver.h                    |  2 +-
 include/io/task.h                            |  2 +-
 include/qemu/base64.h                        |  2 +-
 include/qemu/buffer.h                        |  2 +-
 include/qemu/coroutine.h                     |  2 +-
 include/qemu/filemonitor.h                   |  2 +-
 include/qemu/lockable.h                      |  2 +-
 include/qemu/ratelimit.h                     |  2 +-
 include/sysemu/cryptodev-vhost-user.h        |  2 +-
 include/sysemu/cryptodev-vhost.h             |  2 +-
 include/sysemu/cryptodev.h                   |  2 +-
 include/sysemu/tpm_util.h                    |  2 +-
 io/channel-buffer.c                          |  2 +-
 io/channel-command.c                         |  2 +-
 io/channel-file.c                            |  2 +-
 io/channel-socket.c                          |  2 +-
 io/channel-tls.c                             |  2 +-
 io/channel-util.c                            |  2 +-
 io/channel-watch.c                           |  2 +-
 io/channel-websock.c                         |  2 +-
 io/channel.c                                 |  2 +-
 io/dns-resolver.c                            |  2 +-
 io/task.c                                    |  2 +-
 linux-user/aarch64/target_cpu.h              |  2 +-
 linux-user/aarch64/target_structs.h          |  2 +-
 linux-user/alpha/target_cpu.h                |  2 +-
 linux-user/alpha/target_structs.h            |  2 +-
 linux-user/arm/target_cpu.h                  |  2 +-
 linux-user/arm/target_structs.h              |  2 +-
 linux-user/cris/target_cpu.h                 |  2 +-
 linux-user/cris/target_structs.h             |  2 +-
 linux-user/hppa/target_cpu.h                 |  2 +-
 linux-user/hppa/target_structs.h             |  2 +-
 linux-user/i386/target_cpu.h                 |  2 +-
 linux-user/i386/target_structs.h             |  2 +-
 linux-user/microblaze/target_cpu.h           |  2 +-
 linux-user/microblaze/target_structs.h       |  2 +-
 linux-user/mips/target_cpu.h                 |  2 +-
 linux-user/mips/target_structs.h             |  2 +-
 linux-user/mips64/target_cpu.h               |  2 +-
 linux-user/nios2/target_cpu.h                |  2 +-
 linux-user/nios2/target_structs.h            |  2 +-
 linux-user/ppc/target_cpu.h                  |  2 +-
 linux-user/ppc/target_structs.h              |  2 +-
 linux-user/ppc/target_syscall.h              |  2 +-
 linux-user/s390x/target_structs.h            |  2 +-
 linux-user/sparc/target_cpu.h                |  2 +-
 linux-user/sparc/target_structs.h            |  2 +-
 linux-user/sparc64/target_structs.h          |  2 +-
 linux-user/tilegx/target_cpu.h               |  2 +-
 linux-user/tilegx/target_structs.h           |  2 +-
 linux-user/x86_64/target_structs.h           |  2 +-
 memory_ldst.c.inc                            |  2 +-
 migration/tls.c                              |  2 +-
 migration/tls.h                              |  2 +-
 net/hub.c                                    |  2 +-
 net/hub.h                                    |  2 +-
 qdev-monitor.c                               |  2 +-
 scripts/analyze-migration.py                 |  2 +-
 scripts/decodetree.py                        |  2 +-
 scripts/replay-dump.py                       |  2 +-
 target/alpha/cpu.h                           |  2 +-
 target/alpha/fpu_helper.c                    |  2 +-
 target/alpha/gdbstub.c                       |  2 +-
 target/alpha/helper.c                        |  2 +-
 target/alpha/int_helper.c                    |  2 +-
 target/alpha/mem_helper.c                    |  2 +-
 target/alpha/sys_helper.c                    |  2 +-
 target/alpha/translate.c                     |  2 +-
 target/alpha/vax_helper.c                    |  2 +-
 target/arm/a32-uncond.decode                 |  2 +-
 target/arm/a32.decode                        |  2 +-
 target/arm/arm_ldst.h                        |  2 +-
 target/arm/cpu.h                             |  2 +-
 target/arm/crypto_helper.c                   |  2 +-
 target/arm/gdbstub.c                         |  2 +-
 target/arm/gdbstub64.c                       |  2 +-
 target/arm/helper-a64.c                      |  2 +-
 target/arm/helper-a64.h                      |  2 +-
 target/arm/helper-sve.h                      |  2 +-
 target/arm/iwmmxt_helper.c                   |  2 +-
 target/arm/neon-dp.decode                    |  2 +-
 target/arm/neon-ls.decode                    |  2 +-
 target/arm/neon-shared.decode                |  2 +-
 target/arm/op_helper.c                       |  2 +-
 target/arm/pauth_helper.c                    |  2 +-
 target/arm/sve.decode                        |  2 +-
 target/arm/sve_helper.c                      |  2 +-
 target/arm/t16.decode                        |  2 +-
 target/arm/t32.decode                        |  2 +-
 target/arm/translate-a64.c                   |  2 +-
 target/arm/translate-a64.h                   |  2 +-
 target/arm/translate-neon.c.inc              |  2 +-
 target/arm/translate-sve.c                   |  2 +-
 target/arm/translate-vfp.c.inc               |  2 +-
 target/arm/translate.c                       |  2 +-
 target/arm/vec_helper.c                      |  2 +-
 target/arm/vec_internal.h                    |  2 +-
 target/arm/vfp-uncond.decode                 |  2 +-
 target/arm/vfp.decode                        |  2 +-
 target/cris/cpu.h                            |  2 +-
 target/cris/crisv10-decode.h                 |  2 +-
 target/cris/crisv32-decode.h                 |  2 +-
 target/cris/gdbstub.c                        |  2 +-
 target/cris/helper.c                         |  2 +-
 target/cris/machine.c                        |  2 +-
 target/cris/mmu.c                            |  2 +-
 target/cris/op_helper.c                      |  2 +-
 target/cris/translate.c                      |  2 +-
 target/cris/translate_v10.c.inc              |  2 +-
 target/hppa/cpu.h                            |  2 +-
 target/hppa/gdbstub.c                        |  2 +-
 target/hppa/helper.c                         |  2 +-
 target/hppa/insns.decode                     |  2 +-
 target/hppa/int_helper.c                     |  2 +-
 target/hppa/machine.c                        |  2 +-
 target/hppa/mem_helper.c                     |  2 +-
 target/hppa/op_helper.c                      |  2 +-
 target/hppa/translate.c                      |  2 +-
 target/i386/bpt_helper.c                     |  2 +-
 target/i386/cc_helper.c                      |  2 +-
 target/i386/cc_helper_template.h             |  2 +-
 target/i386/cpu.c                            |  2 +-
 target/i386/cpu.h                            |  2 +-
 target/i386/excp_helper.c                    |  2 +-
 target/i386/fpu_helper.c                     |  2 +-
 target/i386/gdbstub.c                        |  2 +-
 target/i386/helper.c                         |  2 +-
 target/i386/hvf/panic.h                      |  2 +-
 target/i386/hvf/vmx.h                        |  2 +-
 target/i386/hvf/x86.c                        |  2 +-
 target/i386/hvf/x86.h                        |  2 +-
 target/i386/hvf/x86_cpuid.c                  |  2 +-
 target/i386/hvf/x86_decode.c                 |  2 +-
 target/i386/hvf/x86_decode.h                 |  2 +-
 target/i386/hvf/x86_descr.c                  |  2 +-
 target/i386/hvf/x86_descr.h                  |  2 +-
 target/i386/hvf/x86_emu.c                    | 38 +++++------
 target/i386/hvf/x86_emu.h                    |  2 +-
 target/i386/hvf/x86_flags.c                  | 38 +++++------
 target/i386/hvf/x86_flags.h                  | 38 +++++------
 target/i386/hvf/x86_mmu.c                    |  2 +-
 target/i386/hvf/x86_mmu.h                    |  2 +-
 target/i386/hvf/x86hvf.c                     |  2 +-
 target/i386/hvf/x86hvf.h                     |  2 +-
 target/i386/int_helper.c                     |  2 +-
 target/i386/mem_helper.c                     |  2 +-
 target/i386/misc_helper.c                    |  2 +-
 target/i386/mpx_helper.c                     |  2 +-
 target/i386/ops_sse.h                        |  2 +-
 target/i386/ops_sse_header.h                 |  2 +-
 target/i386/seg_helper.c                     |  2 +-
 target/i386/shift_helper_template.h          |  2 +-
 target/i386/smm_helper.c                     |  2 +-
 target/i386/svm_helper.c                     |  2 +-
 target/i386/tcg-stub.c                       |  2 +-
 target/i386/translate.c                      |  2 +-
 target/lm32/cpu.h                            |  2 +-
 target/lm32/gdbstub.c                        |  2 +-
 target/lm32/helper.c                         |  2 +-
 target/lm32/translate.c                      |  2 +-
 target/microblaze/cpu.h                      |  2 +-
 target/microblaze/gdbstub.c                  |  2 +-
 target/microblaze/helper.c                   |  2 +-
 target/microblaze/machine.c                  |  2 +-
 target/microblaze/mmu.c                      |  2 +-
 target/microblaze/mmu.h                      |  2 +-
 target/microblaze/op_helper.c                |  2 +-
 target/microblaze/translate.c                |  2 +-
 target/mips/cp0_helper.c                     |  2 +-
 target/mips/dsp_helper.c                     |  2 +-
 target/mips/fpu_helper.c                     |  2 +-
 target/mips/gdbstub.c                        |  2 +-
 target/mips/helper.c                         |  2 +-
 target/mips/lmmi_helper.c                    |  2 +-
 target/mips/mips-semi.c                      |  2 +-
 target/mips/msa_helper.c                     |  2 +-
 target/mips/op_helper.c                      |  2 +-
 target/mips/translate.c                      |  2 +-
 target/mips/translate_init.c.inc             |  2 +-
 target/ppc/compat.c                          |  2 +-
 target/ppc/cpu-models.c                      |  2 +-
 target/ppc/cpu-models.h                      |  2 +-
 target/ppc/cpu.c                             |  2 +-
 target/ppc/cpu.h                             |  2 +-
 target/ppc/dfp_helper.c                      |  2 +-
 target/ppc/excp_helper.c                     |  2 +-
 target/ppc/fpu_helper.c                      |  2 +-
 target/ppc/gdbstub.c                         |  2 +-
 target/ppc/helper_regs.h                     |  2 +-
 target/ppc/int_helper.c                      |  2 +-
 target/ppc/internal.h                        |  2 +-
 target/ppc/mem_helper.c                      |  2 +-
 target/ppc/misc_helper.c                     |  2 +-
 target/ppc/mmu-book3s-v3.c                   |  2 +-
 target/ppc/mmu-book3s-v3.h                   |  2 +-
 target/ppc/mmu-hash32.c                      |  2 +-
 target/ppc/mmu-hash64.c                      |  2 +-
 target/ppc/mmu-radix64.c                     |  2 +-
 target/ppc/mmu_helper.c                      |  2 +-
 target/ppc/timebase_helper.c                 |  2 +-
 target/ppc/translate.c                       |  2 +-
 target/ppc/translate_init.c.inc              |  2 +-
 target/ppc/user_only_helper.c                |  2 +-
 target/rx/insns.decode                       |  2 +-
 target/sparc/cc_helper.c                     |  2 +-
 target/sparc/cpu.c                           |  2 +-
 target/sparc/fop_helper.c                    |  2 +-
 target/sparc/gdbstub.c                       |  2 +-
 target/sparc/helper.c                        |  2 +-
 target/sparc/int32_helper.c                  |  2 +-
 target/sparc/int64_helper.c                  |  2 +-
 target/sparc/ldst_helper.c                   |  2 +-
 target/sparc/mmu_helper.c                    |  2 +-
 target/sparc/translate.c                     | 34 +++++-----
 target/sparc/vis_helper.c                    |  2 +-
 target/sparc/win_helper.c                    |  2 +-
 target/tilegx/cpu.h                          |  2 +-
 target/tricore/gdbstub.c                     |  2 +-
 target/xtensa/gdbstub.c                      |  2 +-
 tests/acceptance/pc_cpu_hotplug_props.py     |  2 +-
 tests/acceptance/x86_cpu_model_versions.py   |  2 +-
 tests/decode/check.sh                        |  2 +-
 tests/decode/err_argset1.decode              |  2 +-
 tests/decode/err_argset2.decode              |  2 +-
 tests/decode/err_field1.decode               |  2 +-
 tests/decode/err_field2.decode               |  2 +-
 tests/decode/err_field3.decode               |  2 +-
 tests/decode/err_field4.decode               |  2 +-
 tests/decode/err_field5.decode               |  2 +-
 tests/decode/err_field6.decode               |  2 +-
 tests/decode/err_init1.decode                |  2 +-
 tests/decode/err_init2.decode                |  2 +-
 tests/decode/err_init3.decode                |  2 +-
 tests/decode/err_init4.decode                |  2 +-
 tests/decode/err_overlap1.decode             |  2 +-
 tests/decode/err_overlap2.decode             |  2 +-
 tests/decode/err_overlap3.decode             |  2 +-
 tests/decode/err_overlap4.decode             |  2 +-
 tests/decode/err_overlap5.decode             |  2 +-
 tests/decode/err_overlap6.decode             |  2 +-
 tests/decode/err_overlap7.decode             |  2 +-
 tests/decode/err_overlap8.decode             |  2 +-
 tests/decode/err_overlap9.decode             |  2 +-
 tests/decode/err_pattern_group_empty.decode  |  2 +-
 tests/decode/err_pattern_group_ident1.decode |  2 +-
 tests/decode/err_pattern_group_ident2.decode |  2 +-
 tests/decode/err_pattern_group_nest1.decode  |  2 +-
 tests/decode/err_pattern_group_nest2.decode  |  2 +-
 tests/decode/err_pattern_group_nest3.decode  |  2 +-
 tests/decode/err_width1.decode               |  2 +-
 tests/decode/err_width2.decode               |  2 +-
 tests/decode/err_width3.decode               |  2 +-
 tests/decode/err_width4.decode               |  2 +-
 tests/decode/succ_function.decode            |  2 +-
 tests/decode/succ_pattern_group_nest1.decode |  2 +-
 tests/decode/succ_pattern_group_nest2.decode |  2 +-
 tests/decode/succ_pattern_group_nest3.decode |  2 +-
 tests/decode/succ_pattern_group_nest4.decode |  2 +-
 tests/io-channel-helpers.c                   |  2 +-
 tests/io-channel-helpers.h                   |  2 +-
 tests/migration/guestperf-batch.py           |  2 +-
 tests/migration/guestperf-plot.py            |  2 +-
 tests/migration/guestperf.py                 |  2 +-
 tests/migration/guestperf/comparison.py      |  2 +-
 tests/migration/guestperf/engine.py          |  2 +-
 tests/migration/guestperf/hardware.py        |  2 +-
 tests/migration/guestperf/plot.py            |  2 +-
 tests/migration/guestperf/progress.py        |  2 +-
 tests/migration/guestperf/report.py          |  2 +-
 tests/migration/guestperf/scenario.py        |  2 +-
 tests/migration/guestperf/shell.py           |  2 +-
 tests/migration/guestperf/timings.py         |  2 +-
 tests/migration/stress.c                     |  2 +-
 tests/qemu-iotests/socket_scm_helper.c       |  2 +-
 tests/test-aio-multithread.c                 |  2 +-
 tests/test-aio.c                             |  2 +-
 tests/test-authz-list.c                      |  2 +-
 tests/test-authz-listfile.c                  |  2 +-
 tests/test-authz-pam.c                       |  2 +-
 tests/test-authz-simple.c                    |  2 +-
 tests/test-base64.c                          |  2 +-
 tests/test-bitcnt.c                          |  2 +-
 tests/test-bitops.c                          |  2 +-
 tests/test-blockjob-txn.c                    |  2 +-
 tests/test-blockjob.c                        |  2 +-
 tests/test-bufferiszero.c                    |  2 +-
 tests/test-coroutine.c                       |  2 +-
 tests/test-crypto-afsplit.c                  |  2 +-
 tests/test-crypto-block.c                    |  2 +-
 tests/test-crypto-cipher.c                   |  2 +-
 tests/test-crypto-hash.c                     |  2 +-
 tests/test-crypto-ivgen.c                    |  2 +-
 tests/test-crypto-pbkdf.c                    |  2 +-
 tests/test-crypto-secret.c                   |  2 +-
 tests/test-crypto-xts.c                      |  2 +-
 tests/test-int128.c                          |  2 +-
 tests/test-io-channel-buffer.c               |  2 +-
 tests/test-io-channel-command.c              |  2 +-
 tests/test-io-channel-file.c                 |  2 +-
 tests/test-io-channel-socket.c               |  2 +-
 tests/test-io-task.c                         |  2 +-
 tests/test-mul64.c                           |  2 +-
 tests/test-qgraph.c                          |  2 +-
 tests/test-shift128.c                        |  2 +-
 tests/test-throttle.c                        |  2 +-
 tests/test-timed-average.c                   |  2 +-
 tests/test-uuid.c                            |  2 +-
 tests/test-write-threshold.c                 |  2 +-
 thunk.c                                      |  2 +-
 ui/x_keymap.c                                |  2 +-
 util/base64.c                                |  2 +-
 util/buffer.c                                |  2 +-
 util/filemonitor-inotify.c                   |  2 +-
 util/filemonitor-stub.c                      |  2 +-
 util/log.c                                   |  2 +-
 util/oslib-win32.c                           |  2 +-
 util/qemu-coroutine-sleep.c                  |  2 +-
 util/qemu-coroutine.c                        |  2 +-
 505 files changed, 713 insertions(+), 713 deletions(-)

diff --git a/authz/base.c b/authz/base.c
index c75bce3..f2b7fbe 100644
--- a/authz/base.c
+++ b/authz/base.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/authz/list.c b/authz/list.c
index 28b9909..0e17eed 100644
--- a/authz/list.c
+++ b/authz/list.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/authz/listfile.c b/authz/listfile.c
index cd6163a..c9dd116 100644
--- a/authz/listfile.c
+++ b/authz/listfile.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/authz/pamacct.c b/authz/pamacct.c
index c91593b..e67195f 100644
--- a/authz/pamacct.c
+++ b/authz/pamacct.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/authz/simple.c b/authz/simple.c
index ee061e9..18db035 100644
--- a/authz/simple.c
+++ b/authz/simple.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/backends/cryptodev-builtin.c b/backends/cryptodev-builtin.c
index c6edb1b..0671bf9 100644
--- a/backends/cryptodev-builtin.c
+++ b/backends/cryptodev-builtin.c
@@ -9,7 +9,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/backends/cryptodev-vhost-user.c b/backends/cryptodev-vhost-user.c
index e1df073..bedb452 100644
--- a/backends/cryptodev-vhost-user.c
+++ b/backends/cryptodev-vhost-user.c
@@ -9,7 +9,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/backends/cryptodev-vhost.c b/backends/cryptodev-vhost.c
index 8337c9a..8231e7f 100644
--- a/backends/cryptodev-vhost.c
+++ b/backends/cryptodev-vhost.c
@@ -10,7 +10,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/backends/cryptodev.c b/backends/cryptodev.c
index 3f141f6..bf52476 100644
--- a/backends/cryptodev.c
+++ b/backends/cryptodev.c
@@ -9,7 +9,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
index 201cd38..a012adc 100644
--- a/backends/tpm/tpm_emulator.c
+++ b/backends/tpm/tpm_emulator.c
@@ -14,7 +14,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/backends/tpm/tpm_passthrough.c b/backends/tpm/tpm_passthrough.c
index 8f6f499..21b7459 100644
--- a/backends/tpm/tpm_passthrough.c
+++ b/backends/tpm/tpm_passthrough.c
@@ -11,7 +11,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/backends/tpm/tpm_util.c b/backends/tpm/tpm_util.c
index b58d298..e6aeb63 100644
--- a/backends/tpm/tpm_util.c
+++ b/backends/tpm/tpm_util.c
@@ -8,7 +8,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/block/commit.c b/block/commit.c
index 1e85c30..063a815 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -7,7 +7,7 @@
  *  Jeff Cody   <jcody@redhat.com>
  *  Based on stream.c by Stefan Hajnoczi
  *
- * This work is licensed under the terms of the GNU LGPL, version 2 or later.
+ * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
  * See the COPYING.LIB file in the top-level directory.
  *
  */
diff --git a/block/crypto.c b/block/crypto.c
index 0807557..aef5a57 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/block/crypto.h b/block/crypto.h
index c72c3de..72e792c 100644
--- a/block/crypto.h
+++ b/block/crypto.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/block/mirror.c b/block/mirror.c
index 26acf4a..ee3c9d9 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -6,7 +6,7 @@
  * Authors:
  *  Paolo Bonzini  <pbonzini@redhat.com>
  *
- * This work is licensed under the terms of the GNU LGPL, version 2 or later.
+ * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
  * See the COPYING.LIB file in the top-level directory.
  *
  */
diff --git a/block/qed-check.c b/block/qed-check.c
index 418033e..9155303 100644
--- a/block/qed-check.c
+++ b/block/qed-check.c
@@ -6,7 +6,7 @@
  * Authors:
  *  Stefan Hajnoczi   <stefanha@linux.vnet.ibm.com>
  *
- * This work is licensed under the terms of the GNU LGPL, version 2 or later.
+ * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
  * See the COPYING.LIB file in the top-level directory.
  *
  */
diff --git a/block/qed-cluster.c b/block/qed-cluster.c
index 672e2e6..b6307c3 100644
--- a/block/qed-cluster.c
+++ b/block/qed-cluster.c
@@ -7,7 +7,7 @@
  *  Stefan Hajnoczi   <stefanha@linux.vnet.ibm.com>
  *  Anthony Liguori   <aliguori@us.ibm.com>
  *
- * This work is licensed under the terms of the GNU LGPL, version 2 or later.
+ * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
  * See the COPYING.LIB file in the top-level directory.
  *
  */
diff --git a/block/qed-l2-cache.c b/block/qed-l2-cache.c
index b548362..c6f378d 100644
--- a/block/qed-l2-cache.c
+++ b/block/qed-l2-cache.c
@@ -6,7 +6,7 @@
  * Authors:
  *  Anthony Liguori   <aliguori@us.ibm.com>
  *
- * This work is licensed under the terms of the GNU LGPL, version 2 or later.
+ * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
  * See the COPYING.LIB file in the top-level directory.
  *
  */
diff --git a/block/qed-table.c b/block/qed-table.c
index 405d446..8945149 100644
--- a/block/qed-table.c
+++ b/block/qed-table.c
@@ -7,7 +7,7 @@
  *  Stefan Hajnoczi   <stefanha@linux.vnet.ibm.com>
  *  Anthony Liguori   <aliguori@us.ibm.com>
  *
- * This work is licensed under the terms of the GNU LGPL, version 2 or later.
+ * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
  * See the COPYING.LIB file in the top-level directory.
  *
  */
diff --git a/block/qed.c b/block/qed.c
index b27e754..19d2b09 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -7,7 +7,7 @@
  *  Stefan Hajnoczi   <stefanha@linux.vnet.ibm.com>
  *  Anthony Liguori   <aliguori@us.ibm.com>
  *
- * This work is licensed under the terms of the GNU LGPL, version 2 or later.
+ * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
  * See the COPYING.LIB file in the top-level directory.
  *
  */
diff --git a/block/qed.h b/block/qed.h
index 3d12bf7..74d86a8 100644
--- a/block/qed.h
+++ b/block/qed.h
@@ -7,7 +7,7 @@
  *  Stefan Hajnoczi   <stefanha@linux.vnet.ibm.com>
  *  Anthony Liguori   <aliguori@us.ibm.com>
  *
- * This work is licensed under the terms of the GNU LGPL, version 2 or later.
+ * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
  * See the COPYING.LIB file in the top-level directory.
  *
  */
diff --git a/block/stream.c b/block/stream.c
index 8ce6729..af550a6 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -6,7 +6,7 @@
  * Authors:
  *  Stefan Hajnoczi   <stefanha@linux.vnet.ibm.com>
  *
- * This work is licensed under the terms of the GNU LGPL, version 2 or later.
+ * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
  * See the COPYING.LIB file in the top-level directory.
  *
  */
diff --git a/block/vhdx-endian.c b/block/vhdx-endian.c
index 52c8027..65bbe4e 100644
--- a/block/vhdx-endian.c
+++ b/block/vhdx-endian.c
@@ -10,7 +10,7 @@
  *  by Microsoft:
  *      https://www.microsoft.com/en-us/download/details.aspx?id=34750
  *
- * This work is licensed under the terms of the GNU LGPL, version 2 or later.
+ * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
  * See the COPYING.LIB file in the top-level directory.
  *
  */
diff --git a/block/vhdx-log.c b/block/vhdx-log.c
index 404fb5f..50b9c1d 100644
--- a/block/vhdx-log.c
+++ b/block/vhdx-log.c
@@ -13,7 +13,7 @@
  * This file covers the functionality of the metadata log writing, parsing, and
  * replay.
  *
- * This work is licensed under the terms of the GNU LGPL, version 2 or later.
+ * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
  * See the COPYING.LIB file in the top-level directory.
  *
  */
diff --git a/block/vhdx.c b/block/vhdx.c
index 356ec4c..8c59b0e 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -10,7 +10,7 @@
  *  by Microsoft:
  *      https://www.microsoft.com/en-us/download/details.aspx?id=34750
  *
- * This work is licensed under the terms of the GNU LGPL, version 2 or later.
+ * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
  * See the COPYING.LIB file in the top-level directory.
  *
  */
diff --git a/block/vhdx.h b/block/vhdx.h
index 0b74924..3369a04 100644
--- a/block/vhdx.h
+++ b/block/vhdx.h
@@ -10,7 +10,7 @@
  *  by Microsoft:
  *      https://www.microsoft.com/en-us/download/details.aspx?id=34750
  *
- * This work is licensed under the terms of the GNU LGPL, version 2 or later.
+ * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
  * See the COPYING.LIB file in the top-level directory.
  *
  */
diff --git a/block/write-threshold.c b/block/write-threshold.c
index 85b78dc..18f3f8a 100644
--- a/block/write-threshold.c
+++ b/block/write-threshold.c
@@ -6,7 +6,7 @@
  * Authors:
  *  Francesco Romani <fromani@redhat.com>
  *
- * This work is licensed under the terms of the GNU LGPL, version 2 or later.
+ * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
  * See the COPYING.LIB file in the top-level directory.
  */
 
diff --git a/cpus-common.c b/cpus-common.c
index 83475ef..6e73d3e 100644
--- a/cpus-common.c
+++ b/cpus-common.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/disas/lm32.c b/disas/lm32.c
index c0ef816..4fbb124 100644
--- a/disas/lm32.c
+++ b/disas/lm32.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/exec-vary.c b/exec-vary.c
index ff905f2..a603b1b 100644
--- a/exec-vary.c
+++ b/exec-vary.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/exec.c b/exec.c
index 3f5deb3..268b10c 100644
--- a/exec.c
+++ b/exec.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/gdbstub.c b/gdbstub.c
index 9dfb6e4..5952b29 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -10,7 +10,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/acpi/core.c b/hw/acpi/core.c
index ade9158..b77b202 100644
--- a/hw/acpi/core.c
+++ b/hw/acpi/core.c
@@ -5,7 +5,7 @@
  *
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
- * License version 2 as published by the Free Software Foundation.
+ * License version 2.1 as published by the Free Software Foundation.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/acpi/hmat.c b/hw/acpi/hmat.c
index 7c24bb5..37806f7 100644
--- a/hw/acpi/hmat.c
+++ b/hw/acpi/hmat.c
@@ -13,7 +13,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/acpi/hmat.h b/hw/acpi/hmat.h
index 437dbc6..e9031ca 100644
--- a/hw/acpi/hmat.h
+++ b/hw/acpi/hmat.h
@@ -13,7 +13,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index 95cb0f9..5ff4e01 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -10,7 +10,7 @@
  *
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
- * License version 2 as published by the Free Software Foundation.
+ * License version 2.1 as published by the Free Software Foundation.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
index 8f7cc16..e17734d 100644
--- a/hw/acpi/nvdimm.c
+++ b/hw/acpi/nvdimm.c
@@ -15,7 +15,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index 32ae8b2..245bdd8 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -10,7 +10,7 @@
  *
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
- * License version 2 as published by the Free Software Foundation.
+ * License version 2.1 as published by the Free Software Foundation.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 894d357..842bc38 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -5,7 +5,7 @@
  *
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
- * License version 2 as published by the Free Software Foundation.
+ * License version 2.1 as published by the Free Software Foundation.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/audio/milkymist-ac97.c b/hw/audio/milkymist-ac97.c
index 04b39f8..7d2e057 100644
--- a/hw/audio/milkymist-ac97.c
+++ b/hw/audio/milkymist-ac97.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index f0fcd63..daae965 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index eb02fcc..1b3d94e 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index a076b1e..e6fb1c1 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -11,7 +11,7 @@
  * Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
  * Nicholas Bellinger <nab@risingtidesystems.com>
  *
- * This work is licensed under the terms of the GNU LGPL, version 2 or later.
+ * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
  * See the COPYING.LIB file in the top-level directory.
  *
  */
diff --git a/hw/char/lm32_juart.c b/hw/char/lm32_juart.c
index b97aacb..aced357 100644
--- a/hw/char/lm32_juart.c
+++ b/hw/char/lm32_juart.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/char/lm32_uart.c b/hw/char/lm32_uart.c
index 0e8b4e4..2f58e29 100644
--- a/hw/char/lm32_uart.c
+++ b/hw/char/lm32_uart.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/char/milkymist-uart.c b/hw/char/milkymist-uart.c
index 1e83dbc..a817c51 100644
--- a/hw/char/milkymist-uart.c
+++ b/hw/char/milkymist-uart.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/core/bus.c b/hw/core/bus.c
index 6b987b6..c547f8e 100644
--- a/hw/core/bus.c
+++ b/hw/core/bus.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/core/loader-fit.c b/hw/core/loader-fit.c
index c465921..b7c7b3b 100644
--- a/hw/core/loader-fit.c
+++ b/hw/core/loader-fit.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/core/platform-bus.c b/hw/core/platform-bus.c
index 5037ca2..b8487b2 100644
--- a/hw/core/platform-bus.c
+++ b/hw/core/platform-bus.c
@@ -8,7 +8,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 96772a1..69b882d 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
index 68e8dc8..aaae8e2 100644
--- a/hw/core/sysbus.c
+++ b/hw/core/sysbus.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/display/bcm2835_fb.c b/hw/display/bcm2835_fb.c
index 986c994..2be77bd 100644
--- a/hw/display/bcm2835_fb.c
+++ b/hw/display/bcm2835_fb.c
@@ -10,7 +10,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/display/milkymist-tmu2.c b/hw/display/milkymist-tmu2.c
index 64636db..02a28c8 100644
--- a/hw/display/milkymist-tmu2.c
+++ b/hw/display/milkymist-tmu2.c
@@ -8,7 +8,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/display/milkymist-vgafb.c b/hw/display/milkymist-vgafb.c
index 6f2b11d..e2c587e 100644
--- a/hw/display/milkymist-vgafb.c
+++ b/hw/display/milkymist-vgafb.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/display/milkymist-vgafb_template.h b/hw/display/milkymist-vgafb_template.h
index 4883780..96137f9 100644
--- a/hw/display/milkymist-vgafb_template.h
+++ b/hw/display/milkymist-vgafb_template.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/gpio/mpc8xxx.c b/hw/gpio/mpc8xxx.c
index e60c919..cb42acb 100644
--- a/hw/gpio/mpc8xxx.c
+++ b/hw/gpio/mpc8xxx.c
@@ -8,7 +8,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/i2c/pm_smbus.c b/hw/i2c/pm_smbus.c
index 4728540..06e1e53 100644
--- a/hw/i2c/pm_smbus.c
+++ b/hw/i2c/pm_smbus.c
@@ -6,7 +6,7 @@
  *
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
- * License version 2 as published by the Free Software Foundation.
+ * License version 2.1 as published by the Free Software Foundation.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index ee1d47f..71b0678 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -9,7 +9,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/ide/ahci_internal.h b/hw/ide/ahci_internal.h
index ac9bdea..7f32e87 100644
--- a/hw/ide/ahci_internal.h
+++ b/hw/ide/ahci_internal.h
@@ -9,7 +9,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/ide/ich.c b/hw/ide/ich.c
index 51cd2f3..1007a51 100644
--- a/hw/ide/ich.c
+++ b/hw/ide/ich.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/ide/qdev.c b/hw/ide/qdev.c
index 27ff1f7..1086b7a 100644
--- a/hw/ide/qdev.c
+++ b/hw/ide/qdev.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/input/milkymist-softusb.c b/hw/input/milkymist-softusb.c
index 5acd7a6..d885c70 100644
--- a/hw/input/milkymist-softusb.c
+++ b/hw/input/milkymist-softusb.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/intc/apic.c b/hw/intc/apic.c
index b6a05e5..1c8be40 100644
--- a/hw/intc/apic.c
+++ b/hw/intc/apic.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
index 81addd6..502e94e 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/intc/arm_gicv2m.c b/hw/intc/arm_gicv2m.c
index 596fa66..d564b85 100644
--- a/hw/intc/arm_gicv2m.c
+++ b/hw/intc/arm_gicv2m.c
@@ -8,7 +8,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/intc/arm_gicv3_its_kvm.c b/hw/intc/arm_gicv3_its_kvm.c
index 4ee9875..057cb53 100644
--- a/hw/intc/arm_gicv3_its_kvm.c
+++ b/hw/intc/arm_gicv3_its_kvm.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
index bca71b5..a3021a4 100644
--- a/hw/intc/ioapic.c
+++ b/hw/intc/ioapic.c
@@ -9,7 +9,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/intc/ioapic_common.c b/hw/intc/ioapic_common.c
index 5538b5b..3cccfc1 100644
--- a/hw/intc/ioapic_common.c
+++ b/hw/intc/ioapic_common.c
@@ -8,7 +8,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/intc/lm32_pic.c b/hw/intc/lm32_pic.c
index 0c48a9c..991a90b 100644
--- a/hw/intc/lm32_pic.c
+++ b/hw/intc/lm32_pic.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/intc/xics_pnv.c b/hw/intc/xics_pnv.c
index 35f3811..753c067 100644
--- a/hw/intc/xics_pnv.c
+++ b/hw/intc/xics_pnv.c
@@ -5,7 +5,7 @@
  *
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public License
- * as published by the Free Software Foundation; either version 2 of
+ * as published by the Free Software Foundation; either version 2.1 of
  * the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful, but
diff --git a/hw/isa/apm.c b/hw/isa/apm.c
index bce266b..dfe9020 100644
--- a/hw/isa/apm.c
+++ b/hw/isa/apm.c
@@ -6,7 +6,7 @@
  *
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
- * License version 2 as published by the Free Software Foundation.
+ * License version 2.1 as published by the Free Software Foundation.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/isa/i82378.c b/hw/isa/i82378.c
index 8285b06..2a2ff05 100644
--- a/hw/isa/i82378.c
+++ b/hw/isa/i82378.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/isa/isa-bus.c b/hw/isa/isa-bus.c
index 10bb7ff..7820068 100644
--- a/hw/isa/isa-bus.c
+++ b/hw/isa/isa-bus.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/lm32/lm32_boards.c b/hw/lm32/lm32_boards.c
index b842f74..b5d97dd 100644
--- a/hw/lm32/lm32_boards.c
+++ b/hw/lm32/lm32_boards.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/lm32/lm32_hwsetup.h b/hw/lm32/lm32_hwsetup.h
index de94de1..e6cd30a 100644
--- a/hw/lm32/lm32_hwsetup.h
+++ b/hw/lm32/lm32_hwsetup.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/lm32/milkymist.c b/hw/lm32/milkymist.c
index 9f8fe9f..9ef9488 100644
--- a/hw/lm32/milkymist.c
+++ b/hw/lm32/milkymist.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
index e1574bc..03c2201 100644
--- a/hw/mem/nvdimm.c
+++ b/hw/mem/nvdimm.c
@@ -11,7 +11,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index c303510..50a04dd 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index 1b3f69e..0e9c771 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/mips/cps.c b/hw/mips/cps.c
index 23c0f87..ea58d82 100644
--- a/hw/mips/cps.c
+++ b/hw/mips/cps.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/misc/applesmc.c b/hw/misc/applesmc.c
index a4deb3e..1b9acaf 100644
--- a/hw/misc/applesmc.c
+++ b/hw/misc/applesmc.c
@@ -9,7 +9,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/misc/milkymist-hpdmc.c b/hw/misc/milkymist-hpdmc.c
index 5e26d90..09a3875 100644
--- a/hw/misc/milkymist-hpdmc.c
+++ b/hw/misc/milkymist-hpdmc.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/misc/milkymist-pfpu.c b/hw/misc/milkymist-pfpu.c
index 83491db..e4ee209 100644
--- a/hw/misc/milkymist-pfpu.c
+++ b/hw/misc/milkymist-pfpu.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/misc/mips_cpc.c b/hw/misc/mips_cpc.c
index 2f7b2c9..692c0db 100644
--- a/hw/misc/mips_cpc.c
+++ b/hw/misc/mips_cpc.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/misc/mips_itu.c b/hw/misc/mips_itu.c
index 3540985..1333995 100644
--- a/hw/misc/mips_itu.c
+++ b/hw/misc/mips_itu.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/net/e1000.c b/hw/net/e1000.c
index 83347cb..d7d05ae 100644
--- a/hw/net/e1000.c
+++ b/hw/net/e1000.c
@@ -13,7 +13,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
index b6f1ae3..2beb150 100644
--- a/hw/net/e1000e.c
+++ b/hw/net/e1000e.c
@@ -1,37 +1,37 @@
 /*
-* QEMU INTEL 82574 GbE NIC emulation
-*
-* Software developer's manuals:
-* http://www.intel.com/content/dam/doc/datasheet/82574l-gbe-controller-datasheet.pdf
-*
-* Copyright (c) 2015 Ravello Systems LTD (http://ravellosystems.com)
-* Developed by Daynix Computing LTD (http://www.daynix.com)
-*
-* Authors:
-* Dmitry Fleytman <dmitry@daynix.com>
-* Leonid Bloch <leonid@daynix.com>
-* Yan Vugenfirer <yan@daynix.com>
-*
-* Based on work done by:
-* Nir Peleg, Tutis Systems Ltd. for Qumranet Inc.
-* Copyright (c) 2008 Qumranet
-* Based on work done by:
-* Copyright (c) 2007 Dan Aloni
-* Copyright (c) 2004 Antony T Curtis
-*
-* This library is free software; you can redistribute it and/or
-* modify it under the terms of the GNU Lesser General Public
-* License as published by the Free Software Foundation; either
-* version 2 of the License, or (at your option) any later version.
-*
-* This library is distributed in the hope that it will be useful,
-* but WITHOUT ANY WARRANTY; without even the implied warranty of
-* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-* Lesser General Public License for more details.
-*
-* You should have received a copy of the GNU Lesser General Public
-* License along with this library; if not, see <http://www.gnu.org/licenses/>.
-*/
+ * QEMU INTEL 82574 GbE NIC emulation
+ *
+ * Software developer's manuals:
+ * http://www.intel.com/content/dam/doc/datasheet/82574l-gbe-controller-datasheet.pdf
+ *
+ * Copyright (c) 2015 Ravello Systems LTD (http://ravellosystems.com)
+ * Developed by Daynix Computing LTD (http://www.daynix.com)
+ *
+ * Authors:
+ * Dmitry Fleytman <dmitry@daynix.com>
+ * Leonid Bloch <leonid@daynix.com>
+ * Yan Vugenfirer <yan@daynix.com>
+ *
+ * Based on work done by:
+ * Nir Peleg, Tutis Systems Ltd. for Qumranet Inc.
+ * Copyright (c) 2008 Qumranet
+ * Based on work done by:
+ * Copyright (c) 2007 Dan Aloni
+ * Copyright (c) 2004 Antony T Curtis
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
 
 #include "qemu/osdep.h"
 #include "qemu/units.h"
diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index bcfd466..93f377a 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -1,37 +1,37 @@
 /*
-* Core code for QEMU e1000e emulation
-*
-* Software developer's manuals:
-* http://www.intel.com/content/dam/doc/datasheet/82574l-gbe-controller-datasheet.pdf
-*
-* Copyright (c) 2015 Ravello Systems LTD (http://ravellosystems.com)
-* Developed by Daynix Computing LTD (http://www.daynix.com)
-*
-* Authors:
-* Dmitry Fleytman <dmitry@daynix.com>
-* Leonid Bloch <leonid@daynix.com>
-* Yan Vugenfirer <yan@daynix.com>
-*
-* Based on work done by:
-* Nir Peleg, Tutis Systems Ltd. for Qumranet Inc.
-* Copyright (c) 2008 Qumranet
-* Based on work done by:
-* Copyright (c) 2007 Dan Aloni
-* Copyright (c) 2004 Antony T Curtis
-*
-* This library is free software; you can redistribute it and/or
-* modify it under the terms of the GNU Lesser General Public
-* License as published by the Free Software Foundation; either
-* version 2 of the License, or (at your option) any later version.
-*
-* This library is distributed in the hope that it will be useful,
-* but WITHOUT ANY WARRANTY; without even the implied warranty of
-* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-* Lesser General Public License for more details.
-*
-* You should have received a copy of the GNU Lesser General Public
-* License along with this library; if not, see <http://www.gnu.org/licenses/>.
-*/
+ * Core code for QEMU e1000e emulation
+ *
+ * Software developer's manuals:
+ * http://www.intel.com/content/dam/doc/datasheet/82574l-gbe-controller-datasheet.pdf
+ *
+ * Copyright (c) 2015 Ravello Systems LTD (http://ravellosystems.com)
+ * Developed by Daynix Computing LTD (http://www.daynix.com)
+ *
+ * Authors:
+ * Dmitry Fleytman <dmitry@daynix.com>
+ * Leonid Bloch <leonid@daynix.com>
+ * Yan Vugenfirer <yan@daynix.com>
+ *
+ * Based on work done by:
+ * Nir Peleg, Tutis Systems Ltd. for Qumranet Inc.
+ * Copyright (c) 2008 Qumranet
+ * Based on work done by:
+ * Copyright (c) 2007 Dan Aloni
+ * Copyright (c) 2004 Antony T Curtis
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
diff --git a/hw/net/e1000e_core.h b/hw/net/e1000e_core.h
index aee32f7..b8f38c4 100644
--- a/hw/net/e1000e_core.h
+++ b/hw/net/e1000e_core.h
@@ -1,37 +1,37 @@
 /*
-* Core code for QEMU e1000e emulation
-*
-* Software developer's manuals:
-* http://www.intel.com/content/dam/doc/datasheet/82574l-gbe-controller-datasheet.pdf
-*
-* Copyright (c) 2015 Ravello Systems LTD (http://ravellosystems.com)
-* Developed by Daynix Computing LTD (http://www.daynix.com)
-*
-* Authors:
-* Dmitry Fleytman <dmitry@daynix.com>
-* Leonid Bloch <leonid@daynix.com>
-* Yan Vugenfirer <yan@daynix.com>
-*
-* Based on work done by:
-* Nir Peleg, Tutis Systems Ltd. for Qumranet Inc.
-* Copyright (c) 2008 Qumranet
-* Based on work done by:
-* Copyright (c) 2007 Dan Aloni
-* Copyright (c) 2004 Antony T Curtis
-*
-* This library is free software; you can redistribute it and/or
-* modify it under the terms of the GNU Lesser General Public
-* License as published by the Free Software Foundation; either
-* version 2 of the License, or (at your option) any later version.
-*
-* This library is distributed in the hope that it will be useful,
-* but WITHOUT ANY WARRANTY; without even the implied warranty of
-* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-* Lesser General Public License for more details.
-*
-* You should have received a copy of the GNU Lesser General Public
-* License along with this library; if not, see <http://www.gnu.org/licenses/>.
-*/
+ * Core code for QEMU e1000e emulation
+ *
+ * Software developer's manuals:
+ * http://www.intel.com/content/dam/doc/datasheet/82574l-gbe-controller-datasheet.pdf
+ *
+ * Copyright (c) 2015 Ravello Systems LTD (http://ravellosystems.com)
+ * Developed by Daynix Computing LTD (http://www.daynix.com)
+ *
+ * Authors:
+ * Dmitry Fleytman <dmitry@daynix.com>
+ * Leonid Bloch <leonid@daynix.com>
+ * Yan Vugenfirer <yan@daynix.com>
+ *
+ * Based on work done by:
+ * Nir Peleg, Tutis Systems Ltd. for Qumranet Inc.
+ * Copyright (c) 2008 Qumranet
+ * Based on work done by:
+ * Copyright (c) 2007 Dan Aloni
+ * Copyright (c) 2004 Antony T Curtis
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
 
 #ifndef HW_NET_E1000E_CORE_H
 #define HW_NET_E1000E_CORE_H
diff --git a/hw/net/e1000x_common.c b/hw/net/e1000x_common.c
index 717f9df..83ffb76 100644
--- a/hw/net/e1000x_common.c
+++ b/hw/net/e1000x_common.c
@@ -1,26 +1,26 @@
 /*
-* QEMU e1000(e) emulation - shared code
-*
-* Copyright (c) 2008 Qumranet
-*
-* Based on work done by:
-* Nir Peleg, Tutis Systems Ltd. for Qumranet Inc.
-* Copyright (c) 2007 Dan Aloni
-* Copyright (c) 2004 Antony T Curtis
-*
-* This library is free software; you can redistribute it and/or
-* modify it under the terms of the GNU Lesser General Public
-* License as published by the Free Software Foundation; either
-* version 2 of the License, or (at your option) any later version.
-*
-* This library is distributed in the hope that it will be useful,
-* but WITHOUT ANY WARRANTY; without even the implied warranty of
-* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-* Lesser General Public License for more details.
-*
-* You should have received a copy of the GNU Lesser General Public
-* License along with this library; if not, see <http://www.gnu.org/licenses/>.
-*/
+ * QEMU e1000(e) emulation - shared code
+ *
+ * Copyright (c) 2008 Qumranet
+ *
+ * Based on work done by:
+ * Nir Peleg, Tutis Systems Ltd. for Qumranet Inc.
+ * Copyright (c) 2007 Dan Aloni
+ * Copyright (c) 2004 Antony T Curtis
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
 
 #include "qemu/osdep.h"
 #include "qemu/units.h"
diff --git a/hw/net/e1000x_common.h b/hw/net/e1000x_common.h
index 19c56f4..bc1ee75 100644
--- a/hw/net/e1000x_common.h
+++ b/hw/net/e1000x_common.h
@@ -1,26 +1,26 @@
 /*
-* QEMU e1000(e) emulation - shared code
-*
-* Copyright (c) 2008 Qumranet
-*
-* Based on work done by:
-* Nir Peleg, Tutis Systems Ltd. for Qumranet Inc.
-* Copyright (c) 2007 Dan Aloni
-* Copyright (c) 2004 Antony T Curtis
-*
-* This library is free software; you can redistribute it and/or
-* modify it under the terms of the GNU Lesser General Public
-* License as published by the Free Software Foundation; either
-* version 2 of the License, or (at your option) any later version.
-*
-* This library is distributed in the hope that it will be useful,
-* but WITHOUT ANY WARRANTY; without even the implied warranty of
-* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-* Lesser General Public License for more details.
-*
-* You should have received a copy of the GNU Lesser General Public
-* License along with this library; if not, see <http://www.gnu.org/licenses/>.
-*/
+ * QEMU e1000(e) emulation - shared code
+ *
+ * Copyright (c) 2008 Qumranet
+ *
+ * Based on work done by:
+ * Nir Peleg, Tutis Systems Ltd. for Qumranet Inc.
+ * Copyright (c) 2007 Dan Aloni
+ * Copyright (c) 2004 Antony T Curtis
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
 
 #ifndef HW_NET_E1000X_COMMON_H
 #define HW_NET_E1000X_COMMON_H
diff --git a/hw/net/milkymist-minimac2.c b/hw/net/milkymist-minimac2.c
index 78c20c9..5826944 100644
--- a/hw/net/milkymist-minimac2.c
+++ b/hw/net/milkymist-minimac2.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/pci-bridge/i82801b11.c b/hw/pci-bridge/i82801b11.c
index 2b39076..f28181e 100644
--- a/hw/pci-bridge/i82801b11.c
+++ b/hw/pci-bridge/i82801b11.c
@@ -30,7 +30,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
index 8492c18..f9fb97a 100644
--- a/hw/pci-host/designware.c
+++ b/hw/pci-host/designware.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/pci-host/xilinx-pcie.c b/hw/pci-host/xilinx-pcie.c
index 3b32142..38d5901 100644
--- a/hw/pci-host/xilinx-pcie.c
+++ b/hw/pci-host/xilinx-pcie.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 6670967..79d322e 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 4724ddf..bd2bf2e 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -5,7 +5,7 @@
  *
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public License
- * as published by the Free Software Foundation; either version 2 of
+ * as published by the Free Software Foundation; either version 2.1 of
  * the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful, but
diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
index 23f1e09..5903590 100644
--- a/hw/ppc/pnv_lpc.c
+++ b/hw/ppc/pnv_lpc.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index 6a479ca..3e868c8 100644
--- a/hw/ppc/pnv_psi.c
+++ b/hw/ppc/pnv_psi.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
index b681c72..e9ae156 100644
--- a/hw/ppc/pnv_xscom.c
+++ b/hw/ppc/pnv_xscom.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/ppc/ppce500_spin.c b/hw/ppc/ppce500_spin.c
index 25c9ce7..d57b199 100644
--- a/hw/ppc/ppce500_spin.c
+++ b/hw/ppc/ppce500_spin.c
@@ -8,7 +8,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
index 0fecabc..0790239 100644
--- a/hw/ppc/spapr_iommu.c
+++ b/hw/ppc/spapr_iommu.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
index 731080d..32cdc36 100644
--- a/hw/ppc/spapr_vio.c
+++ b/hw/ppc/spapr_vio.c
@@ -8,7 +8,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index e90c008..ebcbab3 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/scsi/mptconfig.c b/hw/scsi/mptconfig.c
index 3b2a857..19d01f3 100644
--- a/hw/scsi/mptconfig.c
+++ b/hw/scsi/mptconfig.c
@@ -8,7 +8,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/scsi/mptendian.c b/hw/scsi/mptendian.c
index 313f40e..0d5abb4 100644
--- a/hw/scsi/mptendian.c
+++ b/hw/scsi/mptendian.c
@@ -9,7 +9,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/scsi/mptsas.c b/hw/scsi/mptsas.c
index 135e7d9..f866165 100644
--- a/hw/scsi/mptsas.c
+++ b/hw/scsi/mptsas.c
@@ -11,7 +11,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/scsi/vhost-scsi-common.c b/hw/scsi/vhost-scsi-common.c
index 8ec49d7..b18becc 100644
--- a/hw/scsi/vhost-scsi-common.c
+++ b/hw/scsi/vhost-scsi-common.c
@@ -10,7 +10,7 @@
  *  Stefan Hajnoczi    <stefanha@linux.vnet.ibm.com>
  *  Nicholas Bellinger <nab@risingtidesystems.com>
  *
- * This work is licensed under the terms of the GNU LGPL, version 2 or later.
+ * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
  * See the COPYING.LIB file in the top-level directory.
  *
  */
diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index a83ffee..93b10d0 100644
--- a/hw/scsi/vhost-scsi.c
+++ b/hw/scsi/vhost-scsi.c
@@ -9,7 +9,7 @@
  * Changes for QEMU mainline + tcm_vhost kernel upstream:
  *  Nicholas Bellinger <nab@risingtidesystems.com>
  *
- * This work is licensed under the terms of the GNU LGPL, version 2 or later.
+ * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
  * See the COPYING.LIB file in the top-level directory.
  *
  */
diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index 7c06316..e468a50 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -10,7 +10,7 @@
  *  Stefan Hajnoczi    <stefanha@linux.vnet.ibm.com>
  *  Nicholas Bellinger <nab@risingtidesystems.com>
  *
- * This work is licensed under the terms of the GNU LGPL, version 2 or later.
+ * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
  * See the COPYING.LIB file in the top-level directory.
  *
  */
diff --git a/hw/sd/milkymist-memcard.c b/hw/sd/milkymist-memcard.c
index 8cde320..a1235aa 100644
--- a/hw/sd/milkymist-memcard.c
+++ b/hw/sd/milkymist-memcard.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index 05fd86a..9520471 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -9,7 +9,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/timer/lm32_timer.c b/hw/timer/lm32_timer.c
index be87c65..eeaf0ad 100644
--- a/hw/timer/lm32_timer.c
+++ b/hw/timer/lm32_timer.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/timer/milkymist-sysctl.c b/hw/timer/milkymist-sysctl.c
index 950437b..9ecea63 100644
--- a/hw/timer/milkymist-sysctl.c
+++ b/hw/timer/milkymist-sysctl.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/tpm/tpm_prop.h b/hw/tpm/tpm_prop.h
index 85e1ae5..d19e40c 100644
--- a/hw/tpm/tpm_prop.h
+++ b/hw/tpm/tpm_prop.h
@@ -8,7 +8,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/tricore/tricore_testboard.c b/hw/tricore/tricore_testboard.c
index 8ec2b5b..12ea149 100644
--- a/hw/tricore/tricore_testboard.c
+++ b/hw/tricore/tricore_testboard.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/usb/ccid-card-emulated.c b/hw/usb/ccid-card-emulated.c
index 2d566f7..75f50a3 100644
--- a/hw/usb/ccid-card-emulated.c
+++ b/hw/usb/ccid-card-emulated.c
@@ -4,7 +4,7 @@
  * Copyright (c) 2011 Red Hat.
  * Written by Alon Levy.
  *
- * This code is licensed under the GNU LGPL, version 2 or later.
+ * This code is licensed under the GNU LGPL, version 2.1 or later.
  */
 
 /*
diff --git a/hw/usb/ccid.h b/hw/usb/ccid.h
index 6b82a55..644c1e8 100644
--- a/hw/usb/ccid.h
+++ b/hw/usb/ccid.h
@@ -4,7 +4,7 @@
  * Copyright (c) 2011 Red Hat.
  * Written by Alon Levy.
  *
- * This code is licensed under the GNU LGPL, version 2 or later.
+ * This code is licensed under the GNU LGPL, version 2.1 or later.
  */
 
 #ifndef CCID_H
diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index 8b912e9..f8c64c8 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/usb/hcd-xhci-nec.c b/hw/usb/hcd-xhci-nec.c
index 2efa6fa..65fde63 100644
--- a/hw/usb/hcd-xhci-nec.c
+++ b/hw/usb/hcd-xhci-nec.c
@@ -8,7 +8,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/usb/hcd-xhci-pci.c b/hw/usb/hcd-xhci-pci.c
index a6d746e..3920099 100644
--- a/hw/usb/hcd-xhci-pci.c
+++ b/hw/usb/hcd-xhci-pci.c
@@ -12,7 +12,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/usb/hcd-xhci-pci.h b/hw/usb/hcd-xhci-pci.h
index aa2e890..c193f79 100644
--- a/hw/usb/hcd-xhci-pci.h
+++ b/hw/usb/hcd-xhci-pci.h
@@ -10,7 +10,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 5e8bed9..e68ae2a 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -8,7 +8,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/usb/hcd-xhci.h b/hw/usb/hcd-xhci.h
index f859a17..fbe9981 100644
--- a/hw/usb/hcd-xhci.h
+++ b/hw/usb/hcd-xhci.h
@@ -8,7 +8,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/virtio/vhost-scsi-pci.c b/hw/virtio/vhost-scsi-pci.c
index cb71a29..c1480ed 100644
--- a/hw/virtio/vhost-scsi-pci.c
+++ b/hw/virtio/vhost-scsi-pci.c
@@ -9,7 +9,7 @@
  * Changes for QEMU mainline + tcm_vhost kernel upstream:
  *  Nicholas Bellinger <nab@risingtidesystems.com>
  *
- * This work is licensed under the terms of the GNU LGPL, version 2 or later.
+ * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
  * See the COPYING.LIB file in the top-level directory.
  *
  */
diff --git a/hw/virtio/vhost-user-blk-pci.c b/hw/virtio/vhost-user-blk-pci.c
index 33b404d..500a5d0 100644
--- a/hw/virtio/vhost-user-blk-pci.c
+++ b/hw/virtio/vhost-user-blk-pci.c
@@ -11,7 +11,7 @@
  * Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
  * Nicholas Bellinger <nab@risingtidesystems.com>
  *
- * This work is licensed under the terms of the GNU LGPL, version 2 or later.
+ * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
  * See the COPYING.LIB file in the top-level directory.
  *
  */
diff --git a/hw/virtio/vhost-user-input-pci.c b/hw/virtio/vhost-user-input-pci.c
index c9d3e91..2c156d5 100644
--- a/hw/virtio/vhost-user-input-pci.c
+++ b/hw/virtio/vhost-user-input-pci.c
@@ -1,5 +1,5 @@
 /*
- * This work is licensed under the terms of the GNU LGPL, version 2 or
+ * This work is licensed under the terms of the GNU LGPL, version 2.1 or
  * later.  See the COPYING.LIB file in the top-level directory.
  */
 
diff --git a/hw/virtio/vhost-user-scsi-pci.c b/hw/virtio/vhost-user-scsi-pci.c
index d534341..58818f0 100644
--- a/hw/virtio/vhost-user-scsi-pci.c
+++ b/hw/virtio/vhost-user-scsi-pci.c
@@ -10,7 +10,7 @@
  *  Stefan Hajnoczi    <stefanha@linux.vnet.ibm.com>
  *  Nicholas Bellinger <nab@risingtidesystems.com>
  *
- * This work is licensed under the terms of the GNU LGPL, version 2 or later.
+ * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
  * See the COPYING.LIB file in the top-level directory.
  *
  */
diff --git a/hw/xen/xen_pvdev.c b/hw/xen/xen_pvdev.c
index 43a336a..8ab4589 100644
--- a/hw/xen/xen_pvdev.c
+++ b/hw/xen/xen_pvdev.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/authz/base.h b/include/authz/base.h
index eca170e..b53e4e4 100644
--- a/include/authz/base.h
+++ b/include/authz/base.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/authz/list.h b/include/authz/list.h
index f73bc5c..7ef4ad4 100644
--- a/include/authz/list.h
+++ b/include/authz/list.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/authz/listfile.h b/include/authz/listfile.h
index 51824f3..0a1e5bd 100644
--- a/include/authz/listfile.h
+++ b/include/authz/listfile.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/authz/pamacct.h b/include/authz/pamacct.h
index d05c18a..592edb2 100644
--- a/include/authz/pamacct.h
+++ b/include/authz/pamacct.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/authz/simple.h b/include/authz/simple.h
index 9f5b979..c46a5ac 100644
--- a/include/authz/simple.h
+++ b/include/authz/simple.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/block/write-threshold.h b/include/block/write-threshold.h
index c646f26..6aabab1 100644
--- a/include/block/write-threshold.h
+++ b/include/block/write-threshold.h
@@ -6,7 +6,7 @@
  * Authors:
  *  Francesco Romani <fromani@redhat.com>
  *
- * This work is licensed under the terms of the GNU LGPL, version 2 or later.
+ * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
  * See the COPYING.LIB file in the top-level directory.
  */
 
diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index f6439c4..1c92ab6 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
index 9185632..d1f5e3f 100644
--- a/include/exec/cpu-defs.h
+++ b/include/exec/cpu-defs.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index 30605ed..ef54cb7 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -4,7 +4,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/exec/cputlb.h b/include/exec/cputlb.h
index a62cfb2..19b16e5 100644
--- a/include/exec/cputlb.h
+++ b/include/exec/cputlb.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 1fe28d5..5ebe5d4 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/exec/ioport.h b/include/exec/ioport.h
index 97feb29..e34f668 100644
--- a/include/exec/ioport.h
+++ b/include/exec/ioport.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/exec/memory_ldst.h.inc b/include/exec/memory_ldst.h.inc
index 272c20f..46e6c22 100644
--- a/include/exec/memory_ldst.h.inc
+++ b/include/exec/memory_ldst.h.inc
@@ -8,7 +8,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/exec/memory_ldst_cached.h.inc b/include/exec/memory_ldst_cached.h.inc
index fd4bbb4..5565a08 100644
--- a/include/exec/memory_ldst_cached.h.inc
+++ b/include/exec/memory_ldst_cached.h.inc
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/exec/memory_ldst_phys.h.inc b/include/exec/memory_ldst_phys.h.inc
index 91f7297..b9dd53c 100644
--- a/include/exec/memory_ldst_phys.h.inc
+++ b/include/exec/memory_ldst_phys.h.inc
@@ -8,7 +8,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/exec/tb-context.h b/include/exec/tb-context.h
index feb585e..ec4c13b 100644
--- a/include/exec/tb-context.h
+++ b/include/exec/tb-context.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/exec/tb-hash.h b/include/exec/tb-hash.h
index 805235d..0a273d9 100644
--- a/include/exec/tb-hash.h
+++ b/include/exec/tb-hash.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/exec/user/thunk.h b/include/exec/user/thunk.h
index b281dfa..300a840 100644
--- a/include/exec/user/thunk.h
+++ b/include/exec/user/thunk.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/hw/acpi/acpi.h b/include/hw/acpi/acpi.h
index 4bef575..22b0b65 100644
--- a/include/hw/acpi/acpi.h
+++ b/include/hw/acpi/acpi.h
@@ -8,7 +8,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/hw/acpi/ich9.h b/include/hw/acpi/ich9.h
index 28a5318..54571c7 100644
--- a/include/hw/acpi/ich9.h
+++ b/include/hw/acpi/ich9.h
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h
index 02f4665..dfd3758 100644
--- a/include/hw/acpi/pcihp.h
+++ b/include/hw/acpi/pcihp.h
@@ -10,7 +10,7 @@
  *
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
- * License version 2 as published by the Free Software Foundation.
+ * License version 2.1 as published by the Free Software Foundation.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/hw/display/milkymist_tmu2.h b/include/hw/display/milkymist_tmu2.h
index e3394ff..fdce953 100644
--- a/include/hw/display/milkymist_tmu2.h
+++ b/include/hw/display/milkymist_tmu2.h
@@ -8,7 +8,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/hw/i386/apic_internal.h b/include/hw/i386/apic_internal.h
index da38541..c175e7e 100644
--- a/include/hw/i386/apic_internal.h
+++ b/include/hw/i386/apic_internal.h
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/hw/i386/ioapic.h b/include/hw/i386/ioapic.h
index 59fcb15..06bfaae 100644
--- a/include/hw/i386/ioapic.h
+++ b/include/hw/i386/ioapic.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/hw/i386/ioapic_internal.h b/include/hw/i386/ioapic_internal.h
index 0ac9e24..0f9002a 100644
--- a/include/hw/i386/ioapic_internal.h
+++ b/include/hw/i386/ioapic_internal.h
@@ -8,7 +8,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/hw/ide/ahci.h b/include/hw/ide/ahci.h
index b1bdf64..210e5e7 100644
--- a/include/hw/ide/ahci.h
+++ b/include/hw/ide/ahci.h
@@ -9,7 +9,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/hw/loader-fit.h b/include/hw/loader-fit.h
index 0284c3e..0832e37 100644
--- a/include/hw/loader-fit.h
+++ b/include/hw/loader-fit.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/hw/mips/cps.h b/include/hw/mips/cps.h
index 9e35a88..c31d9ac 100644
--- a/include/hw/mips/cps.h
+++ b/include/hw/mips/cps.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/hw/misc/mips_cpc.h b/include/hw/misc/mips_cpc.h
index e5dccea..fcafbd5 100644
--- a/include/hw/misc/mips_cpc.h
+++ b/include/hw/misc/mips_cpc.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/hw/misc/mips_itu.h b/include/hw/misc/mips_itu.h
index 96347db..50d9611 100644
--- a/include/hw/misc/mips_itu.h
+++ b/include/hw/misc/mips_itu.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/hw/pci-host/designware.h b/include/hw/pci-host/designware.h
index 79869c7..6d9b51a 100644
--- a/include/hw/pci-host/designware.h
+++ b/include/hw/pci-host/designware.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
index 04917f3..4f58f02 100644
--- a/include/hw/pci-host/spapr.h
+++ b/include/hw/pci-host/spapr.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/hw/pci-host/xilinx-pcie.h b/include/hw/pci-host/xilinx-pcie.h
index f079e50..89be88d 100644
--- a/include/hw/pci-host/xilinx-pcie.h
+++ b/include/hw/pci-host/xilinx-pcie.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/hw/platform-bus.h b/include/hw/platform-bus.h
index 1f3d1ce..44f30c5 100644
--- a/include/hw/platform-bus.h
+++ b/include/hw/platform-bus.h
@@ -11,7 +11,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index dd2535a..ee7eda3 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
index f15829d..6ecee98 100644
--- a/include/hw/ppc/pnv_core.h
+++ b/include/hw/ppc/pnv_core.h
@@ -5,7 +5,7 @@
  *
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public License
- * as published by the Free Software Foundation; either version 2 of
+ * as published by the Free Software Foundation; either version 2.1 of
  * the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful, but
diff --git a/include/hw/ppc/pnv_homer.h b/include/hw/ppc/pnv_homer.h
index 7d29db8..1889e30 100644
--- a/include/hw/ppc/pnv_homer.h
+++ b/include/hw/ppc/pnv_homer.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/hw/ppc/pnv_lpc.h b/include/hw/ppc/pnv_lpc.h
index cd3c13c..e893e76 100644
--- a/include/hw/ppc/pnv_lpc.h
+++ b/include/hw/ppc/pnv_lpc.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/hw/ppc/pnv_occ.h b/include/hw/ppc/pnv_occ.h
index 6219f58..b78185a 100644
--- a/include/hw/ppc/pnv_occ.h
+++ b/include/hw/ppc/pnv_occ.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/hw/ppc/pnv_psi.h b/include/hw/ppc/pnv_psi.h
index 682b09f..eb841b3 100644
--- a/include/hw/ppc/pnv_psi.h
+++ b/include/hw/ppc/pnv_psi.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
index 7e3b189..8578f5a 100644
--- a/include/hw/ppc/pnv_xscom.h
+++ b/include/hw/ppc/pnv_xscom.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/hw/ppc/spapr_vio.h b/include/hw/ppc/spapr_vio.h
index 356751e..4bea87f 100644
--- a/include/hw/ppc/spapr_vio.h
+++ b/include/hw/ppc/spapr_vio.h
@@ -11,7 +11,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/hw/semihosting/semihost.h b/include/hw/semihosting/semihost.h
index b8ce511..0c55ade 100644
--- a/include/hw/semihosting/semihost.h
+++ b/include/hw/semihosting/semihost.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/hw/virtio/vhost-scsi-common.h b/include/hw/virtio/vhost-scsi-common.h
index 0c8909d..6f1c208 100644
--- a/include/hw/virtio/vhost-scsi-common.h
+++ b/include/hw/virtio/vhost-scsi-common.h
@@ -6,7 +6,7 @@
  * Author:
  *  Felipe Franciosi <felipe@nutanix.com>
  *
- * This work is licensed under the terms of the GNU LGPL, version 2 or later.
+ * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
  * See the COPYING.LIB file in the top-level directory.
  *
  */
diff --git a/include/hw/virtio/vhost-scsi.h b/include/hw/virtio/vhost-scsi.h
index 7dc2bdd..a62a07d 100644
--- a/include/hw/virtio/vhost-scsi.h
+++ b/include/hw/virtio/vhost-scsi.h
@@ -6,7 +6,7 @@
  * Authors:
  *  Stefan Hajnoczi   <stefanha@linux.vnet.ibm.com>
  *
- * This work is licensed under the terms of the GNU LGPL, version 2 or later.
+ * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
  * See the COPYING.LIB file in the top-level directory.
  *
  */
diff --git a/include/hw/virtio/vhost-user-blk.h b/include/hw/virtio/vhost-user-blk.h
index 7c91f15..d4d12d6 100644
--- a/include/hw/virtio/vhost-user-blk.h
+++ b/include/hw/virtio/vhost-user-blk.h
@@ -7,7 +7,7 @@
  *
  * Based on vhost-scsi.h, Copyright IBM, Corp. 2011
  *
- * This work is licensed under the terms of the GNU LGPL, version 2 or later.
+ * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
  * See the COPYING.LIB file in the top-level directory.
  *
  */
diff --git a/include/hw/virtio/vhost-user-scsi.h b/include/hw/virtio/vhost-user-scsi.h
index 521b08e..d6bd063 100644
--- a/include/hw/virtio/vhost-user-scsi.h
+++ b/include/hw/virtio/vhost-user-scsi.h
@@ -9,7 +9,7 @@
  * This file is largely based on "vhost-scsi.h" by:
  *  Stefan Hajnoczi   <stefanha@linux.vnet.ibm.com>
  *
- * This work is licensed under the terms of the GNU LGPL, version 2 or later.
+ * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
  * See the COPYING.LIB file in the top-level directory.
  *
  */
diff --git a/include/io/channel-buffer.h b/include/io/channel-buffer.h
index 518c28f..c9463ee 100644
--- a/include/io/channel-buffer.h
+++ b/include/io/channel-buffer.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/io/channel-command.h b/include/io/channel-command.h
index 5556a38..27e42bd 100644
--- a/include/io/channel-command.h
+++ b/include/io/channel-command.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/io/channel-file.h b/include/io/channel-file.h
index c61d6e0..50e8eb1 100644
--- a/include/io/channel-file.h
+++ b/include/io/channel-file.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/io/channel-socket.h b/include/io/channel-socket.h
index d07d67f..e747e63 100644
--- a/include/io/channel-socket.h
+++ b/include/io/channel-socket.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/io/channel-tls.h b/include/io/channel-tls.h
index 6dd1a3c..5672479 100644
--- a/include/io/channel-tls.h
+++ b/include/io/channel-tls.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/io/channel-util.h b/include/io/channel-util.h
index c0b79cf..a5d720d 100644
--- a/include/io/channel-util.h
+++ b/include/io/channel-util.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/io/channel-watch.h b/include/io/channel-watch.h
index 63bc4ae..a36aab8 100644
--- a/include/io/channel-watch.h
+++ b/include/io/channel-watch.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/io/channel-websock.h b/include/io/channel-websock.h
index 9c40513..e180827 100644
--- a/include/io/channel-websock.h
+++ b/include/io/channel-websock.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/io/channel.h b/include/io/channel.h
index 3c04f0e..4d6fe45 100644
--- a/include/io/channel.h
+++ b/include/io/channel.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/io/dns-resolver.h b/include/io/dns-resolver.h
index 01d0bd7..558ea51 100644
--- a/include/io/dns-resolver.h
+++ b/include/io/dns-resolver.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/io/task.h b/include/io/task.h
index 6818dfe..beec4f5 100644
--- a/include/io/task.h
+++ b/include/io/task.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/qemu/base64.h b/include/qemu/base64.h
index 0a3c5c9..46a75fb 100644
--- a/include/qemu/base64.h
+++ b/include/qemu/base64.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/qemu/buffer.h b/include/qemu/buffer.h
index 3a909ae..d34d2c8 100644
--- a/include/qemu/buffer.h
+++ b/include/qemu/buffer.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/qemu/coroutine.h b/include/qemu/coroutine.h
index 84eab6e..05da2dc 100644
--- a/include/qemu/coroutine.h
+++ b/include/qemu/coroutine.h
@@ -7,7 +7,7 @@
  *  Stefan Hajnoczi    <stefanha@linux.vnet.ibm.com>
  *  Kevin Wolf         <kwolf@redhat.com>
  *
- * This work is licensed under the terms of the GNU LGPL, version 2 or later.
+ * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
  * See the COPYING.LIB file in the top-level directory.
  *
  */
diff --git a/include/qemu/filemonitor.h b/include/qemu/filemonitor.h
index a41ceb0..8715d5c 100644
--- a/include/qemu/filemonitor.h
+++ b/include/qemu/filemonitor.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/qemu/lockable.h b/include/qemu/lockable.h
index b620023..a618edc 100644
--- a/include/qemu/lockable.h
+++ b/include/qemu/lockable.h
@@ -5,7 +5,7 @@
  *
  * Author: Paolo Bonzini <pbonzini@redhat.com>
  *
- * This work is licensed under the terms of the GNU LGPL, version 2 or later.
+ * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
  * See the COPYING.LIB file in the top-level directory.
  *
  */
diff --git a/include/qemu/ratelimit.h b/include/qemu/ratelimit.h
index 01da8d6..6689210 100644
--- a/include/qemu/ratelimit.h
+++ b/include/qemu/ratelimit.h
@@ -6,7 +6,7 @@
  * Authors:
  *  Stefan Hajnoczi   <stefanha@linux.vnet.ibm.com>
  *
- * This work is licensed under the terms of the GNU LGPL, version 2 or later.
+ * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
  * See the COPYING.LIB file in the top-level directory.
  *
  */
diff --git a/include/sysemu/cryptodev-vhost-user.h b/include/sysemu/cryptodev-vhost-user.h
index 0d3421e..6071050 100644
--- a/include/sysemu/cryptodev-vhost-user.h
+++ b/include/sysemu/cryptodev-vhost-user.h
@@ -9,7 +9,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/sysemu/cryptodev-vhost.h b/include/sysemu/cryptodev-vhost.h
index f42824f..e8cab13 100644
--- a/include/sysemu/cryptodev-vhost.h
+++ b/include/sysemu/cryptodev-vhost.h
@@ -10,7 +10,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/sysemu/cryptodev.h b/include/sysemu/cryptodev.h
index b458aa4..f4d4057 100644
--- a/include/sysemu/cryptodev.h
+++ b/include/sysemu/cryptodev.h
@@ -9,7 +9,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/sysemu/tpm_util.h b/include/sysemu/tpm_util.h
index 63e872c..08f0517 100644
--- a/include/sysemu/tpm_util.h
+++ b/include/sysemu/tpm_util.h
@@ -8,7 +8,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/io/channel-buffer.c b/io/channel-buffer.c
index 5402e0c..baa4e2b 100644
--- a/io/channel-buffer.c
+++ b/io/channel-buffer.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/io/channel-command.c b/io/channel-command.c
index 368dd62..b2a9e27 100644
--- a/io/channel-command.c
+++ b/io/channel-command.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/io/channel-file.c b/io/channel-file.c
index 2ed3b75..c4bf799 100644
--- a/io/channel-file.c
+++ b/io/channel-file.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/io/channel-socket.c b/io/channel-socket.c
index e1b4667..de259f7 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/io/channel-tls.c b/io/channel-tls.c
index 7ec8cef..388f019 100644
--- a/io/channel-tls.c
+++ b/io/channel-tls.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/io/channel-util.c b/io/channel-util.c
index 423d798..848a7a4 100644
--- a/io/channel-util.c
+++ b/io/channel-util.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/io/channel-watch.c b/io/channel-watch.c
index 8640d1c..0289b36 100644
--- a/io/channel-watch.c
+++ b/io/channel-watch.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/io/channel-websock.c b/io/channel-websock.c
index 47a0e94..bb545fa 100644
--- a/io/channel-websock.c
+++ b/io/channel-websock.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/io/channel.c b/io/channel.c
index e4376eb..93d449d 100644
--- a/io/channel.c
+++ b/io/channel.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/io/dns-resolver.c b/io/dns-resolver.c
index b55d8cc..743a0ef 100644
--- a/io/dns-resolver.c
+++ b/io/dns-resolver.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/io/task.c b/io/task.c
index 53c0bed..451f26f 100644
--- a/io/task.c
+++ b/io/task.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/linux-user/aarch64/target_cpu.h b/linux-user/aarch64/target_cpu.h
index 6cc02e7..97a477b 100644
--- a/linux-user/aarch64/target_cpu.h
+++ b/linux-user/aarch64/target_cpu.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/linux-user/aarch64/target_structs.h b/linux-user/aarch64/target_structs.h
index a4998a7..7c74834 100644
--- a/linux-user/aarch64/target_structs.h
+++ b/linux-user/aarch64/target_structs.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/linux-user/alpha/target_cpu.h b/linux-user/alpha/target_cpu.h
index ad408ab..dc2dd65 100644
--- a/linux-user/alpha/target_cpu.h
+++ b/linux-user/alpha/target_cpu.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/linux-user/alpha/target_structs.h b/linux-user/alpha/target_structs.h
index db2bfe2..d91cebd 100644
--- a/linux-user/alpha/target_structs.h
+++ b/linux-user/alpha/target_structs.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/linux-user/arm/target_cpu.h b/linux-user/arm/target_cpu.h
index 2747211..709d19b 100644
--- a/linux-user/arm/target_cpu.h
+++ b/linux-user/arm/target_cpu.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/linux-user/arm/target_structs.h b/linux-user/arm/target_structs.h
index 9a3dbce..339b070 100644
--- a/linux-user/arm/target_structs.h
+++ b/linux-user/arm/target_structs.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/linux-user/cris/target_cpu.h b/linux-user/cris/target_cpu.h
index 74ead55..7f6cade 100644
--- a/linux-user/cris/target_cpu.h
+++ b/linux-user/cris/target_cpu.h
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/linux-user/cris/target_structs.h b/linux-user/cris/target_structs.h
index 76f9653..f949d23 100644
--- a/linux-user/cris/target_structs.h
+++ b/linux-user/cris/target_structs.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/linux-user/hppa/target_cpu.h b/linux-user/hppa/target_cpu.h
index 71654b3..aacf3e9 100644
--- a/linux-user/hppa/target_cpu.h
+++ b/linux-user/hppa/target_cpu.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/linux-user/hppa/target_structs.h b/linux-user/hppa/target_structs.h
index b560b18..b7cf4a3 100644
--- a/linux-user/hppa/target_structs.h
+++ b/linux-user/hppa/target_structs.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/linux-user/i386/target_cpu.h b/linux-user/i386/target_cpu.h
index 2207d24..52caf78 100644
--- a/linux-user/i386/target_cpu.h
+++ b/linux-user/i386/target_cpu.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/linux-user/i386/target_structs.h b/linux-user/i386/target_structs.h
index 25388a7..e22847f 100644
--- a/linux-user/i386/target_structs.h
+++ b/linux-user/i386/target_structs.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/linux-user/microblaze/target_cpu.h b/linux-user/microblaze/target_cpu.h
index ce7b22e..dcae2ab 100644
--- a/linux-user/microblaze/target_cpu.h
+++ b/linux-user/microblaze/target_cpu.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/linux-user/microblaze/target_structs.h b/linux-user/microblaze/target_structs.h
index 70dbdb6..d08f6a5 100644
--- a/linux-user/microblaze/target_structs.h
+++ b/linux-user/microblaze/target_structs.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/linux-user/mips/target_cpu.h b/linux-user/mips/target_cpu.h
index 758ae4d..c375616 100644
--- a/linux-user/mips/target_cpu.h
+++ b/linux-user/mips/target_cpu.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/linux-user/mips/target_structs.h b/linux-user/mips/target_structs.h
index 909ba89..c1150fd 100644
--- a/linux-user/mips/target_structs.h
+++ b/linux-user/mips/target_structs.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/linux-user/mips64/target_cpu.h b/linux-user/mips64/target_cpu.h
index f16991b..2857a76 100644
--- a/linux-user/mips64/target_cpu.h
+++ b/linux-user/mips64/target_cpu.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/linux-user/nios2/target_cpu.h b/linux-user/nios2/target_cpu.h
index 50f0381..2d2008f 100644
--- a/linux-user/nios2/target_cpu.h
+++ b/linux-user/nios2/target_cpu.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/linux-user/nios2/target_structs.h b/linux-user/nios2/target_structs.h
index 7145251..daa2886 100644
--- a/linux-user/nios2/target_structs.h
+++ b/linux-user/nios2/target_structs.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/linux-user/ppc/target_cpu.h b/linux-user/ppc/target_cpu.h
index 76b67d2..51ee148 100644
--- a/linux-user/ppc/target_cpu.h
+++ b/linux-user/ppc/target_cpu.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/linux-user/ppc/target_structs.h b/linux-user/ppc/target_structs.h
index 6b1f579..520e326 100644
--- a/linux-user/ppc/target_structs.h
+++ b/linux-user/ppc/target_structs.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/linux-user/ppc/target_syscall.h b/linux-user/ppc/target_syscall.h
index c461f87..b9c4b81 100644
--- a/linux-user/ppc/target_syscall.h
+++ b/linux-user/ppc/target_syscall.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/linux-user/s390x/target_structs.h b/linux-user/s390x/target_structs.h
index cadff6d..aab716e 100644
--- a/linux-user/s390x/target_structs.h
+++ b/linux-user/s390x/target_structs.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/linux-user/sparc/target_cpu.h b/linux-user/sparc/target_cpu.h
index 14b2158..1fa1011 100644
--- a/linux-user/sparc/target_cpu.h
+++ b/linux-user/sparc/target_cpu.h
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/linux-user/sparc/target_structs.h b/linux-user/sparc/target_structs.h
index ee24c3b..9953540 100644
--- a/linux-user/sparc/target_structs.h
+++ b/linux-user/sparc/target_structs.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/linux-user/sparc64/target_structs.h b/linux-user/sparc64/target_structs.h
index 1808132..4a8ed48 100644
--- a/linux-user/sparc64/target_structs.h
+++ b/linux-user/sparc64/target_structs.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/linux-user/tilegx/target_cpu.h b/linux-user/tilegx/target_cpu.h
index 316b7a6..5fa9e2a 100644
--- a/linux-user/tilegx/target_cpu.h
+++ b/linux-user/tilegx/target_cpu.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/linux-user/tilegx/target_structs.h b/linux-user/tilegx/target_structs.h
index de8b1f2..1df000c 100644
--- a/linux-user/tilegx/target_structs.h
+++ b/linux-user/tilegx/target_structs.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/linux-user/x86_64/target_structs.h b/linux-user/x86_64/target_structs.h
index b6e82a8..ce367b2 100644
--- a/linux-user/x86_64/target_structs.h
+++ b/linux-user/x86_64/target_structs.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/memory_ldst.c.inc b/memory_ldst.c.inc
index c54aee4..9fac37e 100644
--- a/memory_ldst.c.inc
+++ b/memory_ldst.c.inc
@@ -8,7 +8,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/migration/tls.c b/migration/tls.c
index 66c6f43..abb149d 100644
--- a/migration/tls.c
+++ b/migration/tls.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/migration/tls.h b/migration/tls.h
index 0cfbe36..de4fe2c 100644
--- a/migration/tls.h
+++ b/migration/tls.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/net/hub.c b/net/hub.c
index 1375738..6502c33 100644
--- a/net/hub.c
+++ b/net/hub.c
@@ -7,7 +7,7 @@
  *  Stefan Hajnoczi   <stefanha@linux.vnet.ibm.com>
  *  Zhi Yong Wu       <wuzhy@linux.vnet.ibm.com>
  *
- * This work is licensed under the terms of the GNU LGPL, version 2 or later.
+ * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
  * See the COPYING.LIB file in the top-level directory.
  *
  */
diff --git a/net/hub.h b/net/hub.h
index ce45f7b..83e33e4 100644
--- a/net/hub.h
+++ b/net/hub.h
@@ -7,7 +7,7 @@
  *  Stefan Hajnoczi   <stefanha@linux.vnet.ibm.com>
  *  Zhi Yong Wu       <wuzhy@linux.vnet.ibm.com>
  *
- * This work is licensed under the terms of the GNU LGPL, version 2 or later.
+ * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
  * See the COPYING.LIB file in the top-level directory.
  *
  */
diff --git a/qdev-monitor.c b/qdev-monitor.c
index e9b7228..62bf0fa 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/scripts/analyze-migration.py b/scripts/analyze-migration.py
index d70ec7d..d7177b2 100755
--- a/scripts/analyze-migration.py
+++ b/scripts/analyze-migration.py
@@ -7,7 +7,7 @@
 # This library is free software; you can redistribute it and/or
 # modify it under the terms of the GNU Lesser General Public
 # License as published by the Free Software Foundation; either
-# version 2 of the License, or (at your option) any later version.
+# version 2.1 of the License, or (at your option) any later version.
 #
 # This library is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/scripts/decodetree.py b/scripts/decodetree.py
index 60fd3b5..157b1e8 100644
--- a/scripts/decodetree.py
+++ b/scripts/decodetree.py
@@ -4,7 +4,7 @@
 # This library is free software; you can redistribute it and/or
 # modify it under the terms of the GNU Lesser General Public
 # License as published by the Free Software Foundation; either
-# version 2 of the License, or (at your option) any later version.
+# version 2.1 of the License, or (at your option) any later version.
 #
 # This library is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/scripts/replay-dump.py b/scripts/replay-dump.py
index 4cbc1e4..3ba97a6 100755
--- a/scripts/replay-dump.py
+++ b/scripts/replay-dump.py
@@ -8,7 +8,7 @@
 # This library is free software; you can redistribute it and/or
 # modify it under the terms of the GNU Lesser General Public
 # License as published by the Free Software Foundation; either
-# version 2 of the License, or (at your option) any later version.
+# version 2.1 of the License, or (at your option) any later version.
 #
 # This library is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index be29bdd..82df108 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/alpha/fpu_helper.c b/target/alpha/fpu_helper.c
index df8b589..3ff8bb4 100644
--- a/target/alpha/fpu_helper.c
+++ b/target/alpha/fpu_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/alpha/gdbstub.c b/target/alpha/gdbstub.c
index 0cd76dd..7db14f4 100644
--- a/target/alpha/gdbstub.c
+++ b/target/alpha/gdbstub.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index 55d7274..4f56fe4 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/alpha/int_helper.c b/target/alpha/int_helper.c
index e43b50a..5672696 100644
--- a/target/alpha/int_helper.c
+++ b/target/alpha/int_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/alpha/mem_helper.c b/target/alpha/mem_helper.c
index 934faa1..75e72bc 100644
--- a/target/alpha/mem_helper.c
+++ b/target/alpha/mem_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/alpha/sys_helper.c b/target/alpha/sys_helper.c
index 3922923..25f6cb8 100644
--- a/target/alpha/sys_helper.c
+++ b/target/alpha/sys_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 8870284..ba5bba7 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/alpha/vax_helper.c b/target/alpha/vax_helper.c
index 2b0c178..f94fb51 100644
--- a/target/alpha/vax_helper.c
+++ b/target/alpha/vax_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/a32-uncond.decode b/target/arm/a32-uncond.decode
index 60ccfc5..2339de2 100644
--- a/target/arm/a32-uncond.decode
+++ b/target/arm/a32-uncond.decode
@@ -5,7 +5,7 @@
 # This library is free software; you can redistribute it and/or
 # modify it under the terms of the GNU Lesser General Public
 # License as published by the Free Software Foundation; either
-# version 2 of the License, or (at your option) any later version.
+# version 2.1 of the License, or (at your option) any later version.
 #
 # This library is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/a32.decode b/target/arm/a32.decode
index 4dfd913..fcd8cd4 100644
--- a/target/arm/a32.decode
+++ b/target/arm/a32.decode
@@ -5,7 +5,7 @@
 # This library is free software; you can redistribute it and/or
 # modify it under the terms of the GNU Lesser General Public
 # License as published by the Free Software Foundation; either
-# version 2 of the License, or (at your option) any later version.
+# version 2.1 of the License, or (at your option) any later version.
 #
 # This library is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/arm_ldst.h b/target/arm/arm_ldst.h
index 45edb10..057160e 100644
--- a/target/arm/arm_ldst.h
+++ b/target/arm/arm_ldst.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 6036f61..36205a9 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/crypto_helper.c b/target/arm/crypto_helper.c
index c76806d..28a84c2 100644
--- a/target/arm/crypto_helper.c
+++ b/target/arm/crypto_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  */
 
 #include "qemu/osdep.h"
diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
index ecfa88f..866595b 100644
--- a/target/arm/gdbstub.c
+++ b/target/arm/gdbstub.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
index 35d0b80..251539e 100644
--- a/target/arm/gdbstub64.c
+++ b/target/arm/gdbstub64.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
index 0308214..30b2ad1 100644
--- a/target/arm/helper-a64.c
+++ b/target/arm/helper-a64.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/helper-a64.h b/target/arm/helper-a64.h
index 5b0b699..7bd6aed 100644
--- a/target/arm/helper-a64.h
+++ b/target/arm/helper-a64.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 4411c47..e4cadd2 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/iwmmxt_helper.c b/target/arm/iwmmxt_helper.c
index 24244d0..610b1b2 100644
--- a/target/arm/iwmmxt_helper.c
+++ b/target/arm/iwmmxt_helper.c
@@ -8,7 +8,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index 51aa0f0..ec83f10 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -5,7 +5,7 @@
 # This library is free software; you can redistribute it and/or
 # modify it under the terms of the GNU Lesser General Public
 # License as published by the Free Software Foundation; either
-# version 2 of the License, or (at your option) any later version.
+# version 2.1 of the License, or (at your option) any later version.
 #
 # This library is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/neon-ls.decode b/target/arm/neon-ls.decode
index c7b03a7..c17f501 100644
--- a/target/arm/neon-ls.decode
+++ b/target/arm/neon-ls.decode
@@ -5,7 +5,7 @@
 # This library is free software; you can redistribute it and/or
 # modify it under the terms of the GNU Lesser General Public
 # License as published by the Free Software Foundation; either
-# version 2 of the License, or (at your option) any later version.
+# version 2.1 of the License, or (at your option) any later version.
 #
 # This library is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/neon-shared.decode b/target/arm/neon-shared.decode
index a9d0108..ca0c699 100644
--- a/target/arm/neon-shared.decode
+++ b/target/arm/neon-shared.decode
@@ -5,7 +5,7 @@
 # This library is free software; you can redistribute it and/or
 # modify it under the terms of the GNU Lesser General Public
 # License as published by the Free Software Foundation; either
-# version 2 of the License, or (at your option) any later version.
+# version 2.1 of the License, or (at your option) any later version.
 #
 # This library is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index b106521..b84d6d5 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/pauth_helper.c b/target/arm/pauth_helper.c
index 6dbab03..564c48f 100644
--- a/target/arm/pauth_helper.c
+++ b/target/arm/pauth_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 6425396..5c90603 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -5,7 +5,7 @@
 # This library is free software; you can redistribute it and/or
 # modify it under the terms of the GNU Lesser General Public
 # License as published by the Free Software Foundation; either
-# version 2 of the License, or (at your option) any later version.
+# version 2.1 of the License, or (at your option) any later version.
 #
 # This library is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 4758d46..5f037c3 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/t16.decode b/target/arm/t16.decode
index 43b9a26..646c749 100644
--- a/target/arm/t16.decode
+++ b/target/arm/t16.decode
@@ -5,7 +5,7 @@
 # This library is free software; you can redistribute it and/or
 # modify it under the terms of the GNU Lesser General Public
 # License as published by the Free Software Foundation; either
-# version 2 of the License, or (at your option) any later version.
+# version 2.1 of the License, or (at your option) any later version.
 #
 # This library is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/t32.decode b/target/arm/t32.decode
index 7069d82..06d16b3 100644
--- a/target/arm/t32.decode
+++ b/target/arm/t32.decode
@@ -5,7 +5,7 @@
 # This library is free software; you can redistribute it and/or
 # modify it under the terms of the GNU Lesser General Public
 # License as published by the Free Software Foundation; either
-# version 2 of the License, or (at your option) any later version.
+# version 2.1 of the License, or (at your option) any later version.
 #
 # This library is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 7188808..6cb8d5a 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/translate-a64.h b/target/arm/translate-a64.h
index 2e0d16d..3668b67 100644
--- a/target/arm/translate-a64.h
+++ b/target/arm/translate-a64.h
@@ -4,7 +4,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/translate-neon.c.inc b/target/arm/translate-neon.c.inc
index 4d1a292..0c6db4d 100644
--- a/target/arm/translate-neon.c.inc
+++ b/target/arm/translate-neon.c.inc
@@ -9,7 +9,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index e4cd6b6..bf1ce67 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/translate-vfp.c.inc b/target/arm/translate-vfp.c.inc
index 28e0dba..4a05312 100644
--- a/target/arm/translate-vfp.c.inc
+++ b/target/arm/translate-vfp.c.inc
@@ -9,7 +9,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/translate.c b/target/arm/translate.c
index d34c1d3..0329648 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -8,7 +8,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index a973454..86ad8b1 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/vec_internal.h b/target/arm/vec_internal.h
index 00a8277..e3eb3e7 100644
--- a/target/arm/vec_internal.h
+++ b/target/arm/vec_internal.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/vfp-uncond.decode b/target/arm/vfp-uncond.decode
index 8891ab3..5c50447 100644
--- a/target/arm/vfp-uncond.decode
+++ b/target/arm/vfp-uncond.decode
@@ -5,7 +5,7 @@
 # This library is free software; you can redistribute it and/or
 # modify it under the terms of the GNU Lesser General Public
 # License as published by the Free Software Foundation; either
-# version 2 of the License, or (at your option) any later version.
+# version 2.1 of the License, or (at your option) any later version.
 #
 # This library is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/vfp.decode b/target/arm/vfp.decode
index 51f143b..1300ba0 100644
--- a/target/arm/vfp.decode
+++ b/target/arm/vfp.decode
@@ -5,7 +5,7 @@
 # This library is free software; you can redistribute it and/or
 # modify it under the terms of the GNU Lesser General Public
 # License as published by the Free Software Foundation; either
-# version 2 of the License, or (at your option) any later version.
+# version 2.1 of the License, or (at your option) any later version.
 #
 # This library is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/cris/cpu.h b/target/cris/cpu.h
index 8f08d76..d3b6492 100644
--- a/target/cris/cpu.h
+++ b/target/cris/cpu.h
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/cris/crisv10-decode.h b/target/cris/crisv10-decode.h
index 028179b..9c531f3 100644
--- a/target/cris/crisv10-decode.h
+++ b/target/cris/crisv10-decode.h
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/cris/crisv32-decode.h b/target/cris/crisv32-decode.h
index cdc2f8c..fa0a7f0 100644
--- a/target/cris/crisv32-decode.h
+++ b/target/cris/crisv32-decode.h
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/cris/gdbstub.c b/target/cris/gdbstub.c
index b01b2aa..2418d57 100644
--- a/target/cris/gdbstub.c
+++ b/target/cris/gdbstub.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/cris/helper.c b/target/cris/helper.c
index b5159b8..ed45c3d 100644
--- a/target/cris/helper.c
+++ b/target/cris/helper.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/cris/machine.c b/target/cris/machine.c
index be38a89..f370f33 100644
--- a/target/cris/machine.c
+++ b/target/cris/machine.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/cris/mmu.c b/target/cris/mmu.c
index 2acbcfd..a279b7f 100644
--- a/target/cris/mmu.c
+++ b/target/cris/mmu.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/cris/op_helper.c b/target/cris/op_helper.c
index 6b1e7ae..d55a18a 100644
--- a/target/cris/op_helper.c
+++ b/target/cris/op_helper.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/cris/translate.c b/target/cris/translate.c
index c312e6f..c893f87 100644
--- a/target/cris/translate.c
+++ b/target/cris/translate.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/cris/translate_v10.c.inc b/target/cris/translate_v10.c.inc
index 7f38fd2..86d78a8 100644
--- a/target/cris/translate_v10.c.inc
+++ b/target/cris/translate_v10.c.inc
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index fb6c59d..61178fa 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/hppa/gdbstub.c b/target/hppa/gdbstub.c
index a6428a2..729c37b 100644
--- a/target/hppa/gdbstub.c
+++ b/target/hppa/gdbstub.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/hppa/helper.c b/target/hppa/helper.c
index 0dcd105..1ccff57 100644
--- a/target/hppa/helper.c
+++ b/target/hppa/helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index dceaad6..d4eefc0 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -6,7 +6,7 @@
 # This library is free software; you can redistribute it and/or
 # modify it under the terms of the GNU Lesser General Public
 # License as published by the Free Software Foundation; either
-# version 2 of the License, or (at your option) any later version.
+# version 2.1 of the License, or (at your option) any later version.
 #
 # This library is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/hppa/int_helper.c b/target/hppa/int_helper.c
index 462747b..349495d 100644
--- a/target/hppa/int_helper.c
+++ b/target/hppa/int_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/hppa/machine.c b/target/hppa/machine.c
index 7030101..b60b654 100644
--- a/target/hppa/machine.c
+++ b/target/hppa/machine.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index 5a465db..afc5b56 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index 39361d3..7ae31e1 100644
--- a/target/hppa/op_helper.c
+++ b/target/hppa/op_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index f5765ef..64af1e0 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/bpt_helper.c b/target/i386/bpt_helper.c
index c3a8ea7..e6cc292 100644
--- a/target/i386/bpt_helper.c
+++ b/target/i386/bpt_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/cc_helper.c b/target/i386/cc_helper.c
index c9c90e1..924dd3c 100644
--- a/target/i386/cc_helper.c
+++ b/target/i386/cc_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/cc_helper_template.h b/target/i386/cc_helper_template.h
index 607311f..bb611fe 100644
--- a/target/i386/cc_helper_template.h
+++ b/target/i386/cc_helper_template.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 3ffd877..3ff1cdf 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index f519d2b..97f2b4b 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/excp_helper.c b/target/i386/excp_helper.c
index b10c7ec..1914717 100644
--- a/target/i386/excp_helper.c
+++ b/target/i386/excp_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/fpu_helper.c b/target/i386/fpu_helper.c
index 4ea7387..03b3544 100644
--- a/target/i386/fpu_helper.c
+++ b/target/i386/fpu_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/gdbstub.c b/target/i386/gdbstub.c
index 9ae43bd..4a3de5f 100644
--- a/target/i386/gdbstub.c
+++ b/target/i386/gdbstub.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/helper.c b/target/i386/helper.c
index 70be53e..d46999b 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/hvf/panic.h b/target/i386/hvf/panic.h
index 411ef43..a3eabeb 100644
--- a/target/i386/hvf/panic.h
+++ b/target/i386/hvf/panic.h
@@ -5,7 +5,7 @@
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/hvf/vmx.h b/target/i386/hvf/vmx.h
index 587b1b8..24c4cdf 100644
--- a/target/i386/hvf/vmx.h
+++ b/target/i386/hvf/vmx.h
@@ -8,7 +8,7 @@
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/hvf/x86.c b/target/i386/hvf/x86.c
index fdb11c8..cd04518 100644
--- a/target/i386/hvf/x86.c
+++ b/target/i386/hvf/x86.c
@@ -5,7 +5,7 @@
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/hvf/x86.h b/target/i386/hvf/x86.h
index bacade7..9e2c003 100644
--- a/target/i386/hvf/x86.h
+++ b/target/i386/hvf/x86.h
@@ -5,7 +5,7 @@
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/hvf/x86_cpuid.c b/target/i386/hvf/x86_cpuid.c
index 16762b6..ac731c2 100644
--- a/target/i386/hvf/x86_cpuid.c
+++ b/target/i386/hvf/x86_cpuid.c
@@ -7,7 +7,7 @@
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/hvf/x86_decode.c b/target/i386/hvf/x86_decode.c
index 34c5e30..062713b 100644
--- a/target/i386/hvf/x86_decode.c
+++ b/target/i386/hvf/x86_decode.c
@@ -5,7 +5,7 @@
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/hvf/x86_decode.h b/target/i386/hvf/x86_decode.h
index ef79601..a2d7a2a 100644
--- a/target/i386/hvf/x86_decode.h
+++ b/target/i386/hvf/x86_decode.h
@@ -4,7 +4,7 @@
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/hvf/x86_descr.c b/target/i386/hvf/x86_descr.c
index 8c05c34..9f539e7 100644
--- a/target/i386/hvf/x86_descr.c
+++ b/target/i386/hvf/x86_descr.c
@@ -5,7 +5,7 @@
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/hvf/x86_descr.h b/target/i386/hvf/x86_descr.h
index 049ef9a..c356932 100644
--- a/target/i386/hvf/x86_descr.h
+++ b/target/i386/hvf/x86_descr.h
@@ -5,7 +5,7 @@
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/hvf/x86_emu.c b/target/i386/hvf/x86_emu.c
index d3e289e..91668be 100644
--- a/target/i386/hvf/x86_emu.c
+++ b/target/i386/hvf/x86_emu.c
@@ -5,7 +5,7 @@
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
@@ -16,24 +16,24 @@
  * License along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
-/////////////////////////////////////////////////////////////////////////
-//
-//  Copyright (C) 2001-2012  The Bochs Project
-//
-//  This library is free software; you can redistribute it and/or
-//  modify it under the terms of the GNU Lesser General Public
-//  License as published by the Free Software Foundation; either
-//  version 2 of the License, or (at your option) any later version.
-//
-//  This library is distributed in the hope that it will be useful,
-//  but WITHOUT ANY WARRANTY; without even the implied warranty of
-//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-//  Lesser General Public License for more details.
-//
-//  You should have received a copy of the GNU Lesser General Public
-//  License along with this library; if not, write to the Free Software
-//  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA B 02110-1301 USA
-/////////////////////////////////////////////////////////////////////////
+/*
+ *
+ *  Copyright (C) 2001-2012  The Bochs Project
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA B 02110-1301 USA
+ */
 
 #include "qemu/osdep.h"
 #include "panic.h"
diff --git a/target/i386/hvf/x86_emu.h b/target/i386/hvf/x86_emu.h
index f92a9c5..233f7b8 100644
--- a/target/i386/hvf/x86_emu.h
+++ b/target/i386/hvf/x86_emu.h
@@ -5,7 +5,7 @@
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/hvf/x86_flags.c b/target/i386/hvf/x86_flags.c
index 5ca4f41..d8b09ea 100644
--- a/target/i386/hvf/x86_flags.c
+++ b/target/i386/hvf/x86_flags.c
@@ -1,22 +1,22 @@
-/////////////////////////////////////////////////////////////////////////
-//
-//  Copyright (C) 2001-2012  The Bochs Project
-//  Copyright (C) 2017 Google Inc.
-//
-//  This library is free software; you can redistribute it and/or
-//  modify it under the terms of the GNU Lesser General Public
-//  License as published by the Free Software Foundation; either
-//  version 2 of the License, or (at your option) any later version.
-//
-//  This library is distributed in the hope that it will be useful,
-//  but WITHOUT ANY WARRANTY; without even the implied warranty of
-//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-//  Lesser General Public License for more details.
-//
-//  You should have received a copy of the GNU Lesser General Public
-//  License along with this library; if not, write to the Free Software
-//  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA B 02110-1301 USA
-/////////////////////////////////////////////////////////////////////////
+/*
+ *
+ *  Copyright (C) 2001-2012  The Bochs Project
+ *  Copyright (C) 2017 Google Inc.
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA B 02110-1301 USA
+ */
 /*
  * flags functions
  */
diff --git a/target/i386/hvf/x86_flags.h b/target/i386/hvf/x86_flags.h
index 785e80c..636446e 100644
--- a/target/i386/hvf/x86_flags.h
+++ b/target/i386/hvf/x86_flags.h
@@ -1,22 +1,22 @@
-/////////////////////////////////////////////////////////////////////////
-//
-//  Copyright (C) 2001-2012  The Bochs Project
-//  Copyright (C) 2017 Google Inc.
-//
-//  This library is free software; you can redistribute it and/or
-//  modify it under the terms of the GNU Lesser General Public
-//  License as published by the Free Software Foundation; either
-//  version 2 of the License, or (at your option) any later version.
-//
-//  This library is distributed in the hope that it will be useful,
-//  but WITHOUT ANY WARRANTY; without even the implied warranty of
-//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-//  Lesser General Public License for more details.
-//
-//  You should have received a copy of the GNU Lesser General Public
-//  License along with this library; if not, write to the Free Software
-//  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA B 02110-1301 USA
-/////////////////////////////////////////////////////////////////////////
+/*
+ *
+ *  Copyright (C) 2001-2012  The Bochs Project
+ *  Copyright (C) 2017 Google Inc.
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA B 02110-1301 USA
+ */
 /*
  * x86 eflags functions
  */
diff --git a/target/i386/hvf/x86_mmu.c b/target/i386/hvf/x86_mmu.c
index 65d4603..882a623 100644
--- a/target/i386/hvf/x86_mmu.c
+++ b/target/i386/hvf/x86_mmu.c
@@ -5,7 +5,7 @@
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/hvf/x86_mmu.h b/target/i386/hvf/x86_mmu.h
index cd6e137..9ae8a54 100644
--- a/target/i386/hvf/x86_mmu.h
+++ b/target/i386/hvf/x86_mmu.h
@@ -5,7 +5,7 @@
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/hvf/x86hvf.c b/target/i386/hvf/x86hvf.c
index 5cbcb32..f267698 100644
--- a/target/i386/hvf/x86hvf.c
+++ b/target/i386/hvf/x86hvf.c
@@ -6,7 +6,7 @@
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/hvf/x86hvf.h b/target/i386/hvf/x86hvf.h
index 79539f7..860bd2e 100644
--- a/target/i386/hvf/x86hvf.h
+++ b/target/i386/hvf/x86hvf.h
@@ -5,7 +5,7 @@
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/int_helper.c b/target/i386/int_helper.c
index 334469c..4f89436 100644
--- a/target/i386/int_helper.c
+++ b/target/i386/int_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/mem_helper.c b/target/i386/mem_helper.c
index 3a6d3ae..21ca3e3 100644
--- a/target/i386/mem_helper.c
+++ b/target/i386/mem_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/misc_helper.c b/target/i386/misc_helper.c
index b6b1d41..ae259d9 100644
--- a/target/i386/misc_helper.c
+++ b/target/i386/misc_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/mpx_helper.c b/target/i386/mpx_helper.c
index ade5d24..fd96617 100644
--- a/target/i386/mpx_helper.c
+++ b/target/i386/mpx_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/ops_sse.h b/target/i386/ops_sse.h
index c7614f8..6f1fc17 100644
--- a/target/i386/ops_sse.h
+++ b/target/i386/ops_sse.h
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/ops_sse_header.h b/target/i386/ops_sse_header.h
index 094aafc..6c0c849 100644
--- a/target/i386/ops_sse_header.h
+++ b/target/i386/ops_sse_header.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/seg_helper.c b/target/i386/seg_helper.c
index b96de06..16311e5 100644
--- a/target/i386/seg_helper.c
+++ b/target/i386/seg_helper.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/shift_helper_template.h b/target/i386/shift_helper_template.h
index cf91a2d..54f15d6 100644
--- a/target/i386/shift_helper_template.h
+++ b/target/i386/shift_helper_template.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/smm_helper.c b/target/i386/smm_helper.c
index eb5aa6e..d20e8ed 100644
--- a/target/i386/smm_helper.c
+++ b/target/i386/smm_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/svm_helper.c b/target/i386/svm_helper.c
index 6224387..3893158 100644
--- a/target/i386/svm_helper.c
+++ b/target/i386/svm_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/tcg-stub.c b/target/i386/tcg-stub.c
index b00e23d..8d45579 100644
--- a/target/i386/tcg-stub.c
+++ b/target/i386/tcg-stub.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/translate.c b/target/i386/translate.c
index caea6f5..4c57307 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/lm32/cpu.h b/target/lm32/cpu.h
index 01d408e..ea7c01c 100644
--- a/target/lm32/cpu.h
+++ b/target/lm32/cpu.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/lm32/gdbstub.c b/target/lm32/gdbstub.c
index b6fe12e..56f508a 100644
--- a/target/lm32/gdbstub.c
+++ b/target/lm32/gdbstub.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/lm32/helper.c b/target/lm32/helper.c
index 1130fc8..7c52ae7 100644
--- a/target/lm32/helper.c
+++ b/target/lm32/helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/lm32/translate.c b/target/lm32/translate.c
index e583d52..030b232 100644
--- a/target/lm32/translate.c
+++ b/target/lm32/translate.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 297b368..c1c2641 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/microblaze/gdbstub.c b/target/microblaze/gdbstub.c
index be39fd4..2e6e070 100644
--- a/target/microblaze/gdbstub.c
+++ b/target/microblaze/gdbstub.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index 3d6ce1b..cda14a1 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/microblaze/machine.c b/target/microblaze/machine.c
index acdb8d0..c2074bb 100644
--- a/target/microblaze/machine.c
+++ b/target/microblaze/machine.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/microblaze/mmu.c b/target/microblaze/mmu.c
index 1dbbb27..2baaef7 100644
--- a/target/microblaze/mmu.c
+++ b/target/microblaze/mmu.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/microblaze/mmu.h b/target/microblaze/mmu.h
index 7d0fbb8..09e4075 100644
--- a/target/microblaze/mmu.h
+++ b/target/microblaze/mmu.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
index 757f3ff..58d6335 100644
--- a/target/microblaze/op_helper.c
+++ b/target/microblaze/op_helper.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index abfcc7e..c1b13f4 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/mips/cp0_helper.c b/target/mips/cp0_helper.c
index de64add..a950946 100644
--- a/target/mips/cp0_helper.c
+++ b/target/mips/cp0_helper.c
@@ -8,7 +8,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/mips/dsp_helper.c b/target/mips/dsp_helper.c
index 8c58eeb..09b6e5f 100644
--- a/target/mips/dsp_helper.c
+++ b/target/mips/dsp_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/mips/fpu_helper.c b/target/mips/fpu_helper.c
index 56beda4..ffaac3c 100644
--- a/target/mips/fpu_helper.c
+++ b/target/mips/fpu_helper.c
@@ -8,7 +8,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/mips/gdbstub.c b/target/mips/gdbstub.c
index 98f56e6..e39f8d7 100644
--- a/target/mips/gdbstub.c
+++ b/target/mips/gdbstub.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/mips/helper.c b/target/mips/helper.c
index afd78b1..063b65c 100644
--- a/target/mips/helper.c
+++ b/target/mips/helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/mips/lmmi_helper.c b/target/mips/lmmi_helper.c
index 6c645cf..abeb773 100644
--- a/target/mips/lmmi_helper.c
+++ b/target/mips/lmmi_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/mips/mips-semi.c b/target/mips/mips-semi.c
index 10a710c..898251a 100644
--- a/target/mips/mips-semi.c
+++ b/target/mips/mips-semi.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
index 6865add..249f0fd 100644
--- a/target/mips/msa_helper.c
+++ b/target/mips/msa_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index 9552b28..bbd0bf6 100644
--- a/target/mips/op_helper.c
+++ b/target/mips/op_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 398edf7..3a6bd1e 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -10,7 +10,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/mips/translate_init.c.inc b/target/mips/translate_init.c.inc
index 637cacc..4f24443 100644
--- a/target/mips/translate_init.c.inc
+++ b/target/mips/translate_init.c.inc
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/ppc/compat.c b/target/ppc/compat.c
index 08aede8..dd56025 100644
--- a/target/ppc/compat.c
+++ b/target/ppc/compat.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
index 4ad1686..87e4228 100644
--- a/target/ppc/cpu-models.c
+++ b/target/ppc/cpu-models.c
@@ -8,7 +8,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/ppc/cpu-models.h b/target/ppc/cpu-models.h
index ce750b2..fc5e217 100644
--- a/target/ppc/cpu-models.h
+++ b/target/ppc/cpu-models.h
@@ -8,7 +8,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/ppc/cpu.c b/target/ppc/cpu.c
index 2801166..e501a7f 100644
--- a/target/ppc/cpu.c
+++ b/target/ppc/cpu.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 766e9c5..9e108ed 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/ppc/dfp_helper.c b/target/ppc/dfp_helper.c
index 2c65bad..07341a6 100644
--- a/target/ppc/dfp_helper.c
+++ b/target/ppc/dfp_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index a988ba1..8429bf6 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index ae43b08..ccc155a 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/ppc/gdbstub.c b/target/ppc/gdbstub.c
index 5c11c88..01459dd 100644
--- a/target/ppc/gdbstub.c
+++ b/target/ppc/gdbstub.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/ppc/helper_regs.h b/target/ppc/helper_regs.h
index d78c2af..efcc903 100644
--- a/target/ppc/helper_regs.h
+++ b/target/ppc/helper_regs.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index b45626f..0b682a1 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index 15d655b..6104940 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -4,7 +4,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index 98f5895..f4f7e73 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
index e43a3b4..5d6e0de 100644
--- a/target/ppc/misc_helper.c
+++ b/target/ppc/misc_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/ppc/mmu-book3s-v3.c b/target/ppc/mmu-book3s-v3.c
index 32b8c16..c78fd8d 100644
--- a/target/ppc/mmu-book3s-v3.c
+++ b/target/ppc/mmu-book3s-v3.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/ppc/mmu-book3s-v3.h b/target/ppc/mmu-book3s-v3.h
index 0f3c9d0..7b89be5 100644
--- a/target/ppc/mmu-book3s-v3.h
+++ b/target/ppc/mmu-book3s-v3.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/ppc/mmu-hash32.c b/target/ppc/mmu-hash32.c
index 55cf156..178cf09 100644
--- a/target/ppc/mmu-hash32.c
+++ b/target/ppc/mmu-hash32.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index c31d21e..46061e9 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
index c60bf31..30fcfcf 100644
--- a/target/ppc/mmu-radix64.c
+++ b/target/ppc/mmu-radix64.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index 8972714..ed74144 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/ppc/timebase_helper.c b/target/ppc/timebase_helper.c
index d16360a..8ff4080 100644
--- a/target/ppc/timebase_helper.c
+++ b/target/ppc/timebase_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index fedb9b2..54cac0e 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/ppc/translate_init.c.inc b/target/ppc/translate_init.c.inc
index bb66526..c765803 100644
--- a/target/ppc/translate_init.c.inc
+++ b/target/ppc/translate_init.c.inc
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/ppc/user_only_helper.c b/target/ppc/user_only_helper.c
index 683c033..aa3f867 100644
--- a/target/ppc/user_only_helper.c
+++ b/target/ppc/user_only_helper.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/rx/insns.decode b/target/rx/insns.decode
index 232a61f..ca9334b 100644
--- a/target/rx/insns.decode
+++ b/target/rx/insns.decode
@@ -7,7 +7,7 @@
 # This library is free software; you can redistribute it and/or
 # modify it under the terms of the GNU Lesser General Public
 # License as published by the Free Software Foundation; either
-# version 2 of the License, or (at your option) any later version.
+# version 2.1 of the License, or (at your option) any later version.
 #
 # This library is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/sparc/cc_helper.c b/target/sparc/cc_helper.c
index a410a0b..7ad5b9b 100644
--- a/target/sparc/cc_helper.c
+++ b/target/sparc/cc_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index cf21efd..701e794 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/sparc/fop_helper.c b/target/sparc/fop_helper.c
index e6dd3fc..f54fa9b 100644
--- a/target/sparc/fop_helper.c
+++ b/target/sparc/fop_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/sparc/gdbstub.c b/target/sparc/gdbstub.c
index 78dc8dc..5d1e808 100644
--- a/target/sparc/gdbstub.c
+++ b/target/sparc/gdbstub.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/sparc/helper.c b/target/sparc/helper.c
index 07d87ef..c7bcaa3 100644
--- a/target/sparc/helper.c
+++ b/target/sparc/helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/sparc/int32_helper.c b/target/sparc/int32_helper.c
index 9a71e1a..e1c4f9f 100644
--- a/target/sparc/int32_helper.c
+++ b/target/sparc/int32_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/sparc/int64_helper.c b/target/sparc/int64_helper.c
index f3e7f32..ba95bf2 100644
--- a/target/sparc/int64_helper.c
+++ b/target/sparc/int64_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index e91cfde..22327d7 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
index afbfba7..a44473a 100644
--- a/target/sparc/mmu_helper.c
+++ b/target/sparc/mmu_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 1a4efd4..e78bf00 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1,21 +1,21 @@
 /*
-   SPARC translation
-
-   Copyright (C) 2003 Thomas M. Ogrisegg <tom@fnord.at>
-   Copyright (C) 2003-2005 Fabrice Bellard
-
-   This library is free software; you can redistribute it and/or
-   modify it under the terms of the GNU Lesser General Public
-   License as published by the Free Software Foundation; either
-   version 2 of the License, or (at your option) any later version.
-
-   This library is distributed in the hope that it will be useful,
-   but WITHOUT ANY WARRANTY; without even the implied warranty of
-   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-   Lesser General Public License for more details.
-
-   You should have received a copy of the GNU Lesser General Public
-   License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ * SPARC translation
+ *
+ * Copyright (C) 2003 Thomas M. Ogrisegg <tom@fnord.at>
+ * Copyright (C) 2003-2005 Fabrice Bellard
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include "qemu/osdep.h"
diff --git a/target/sparc/vis_helper.c b/target/sparc/vis_helper.c
index 8a9b763..f917e59 100644
--- a/target/sparc/vis_helper.c
+++ b/target/sparc/vis_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/sparc/win_helper.c b/target/sparc/win_helper.c
index 8290a21..5b57892 100644
--- a/target/sparc/win_helper.c
+++ b/target/sparc/win_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/tilegx/cpu.h b/target/tilegx/cpu.h
index c194c1a..7d8e44d 100644
--- a/target/tilegx/cpu.h
+++ b/target/tilegx/cpu.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/tricore/gdbstub.c b/target/tricore/gdbstub.c
index 0f4e612..3ce55ab 100644
--- a/target/tricore/gdbstub.c
+++ b/target/tricore/gdbstub.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/xtensa/gdbstub.c b/target/xtensa/gdbstub.c
index 4d43f13..b669606 100644
--- a/target/xtensa/gdbstub.c
+++ b/target/xtensa/gdbstub.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/tests/acceptance/pc_cpu_hotplug_props.py b/tests/acceptance/pc_cpu_hotplug_props.py
index 08b7e63..e49bf33 100644
--- a/tests/acceptance/pc_cpu_hotplug_props.py
+++ b/tests/acceptance/pc_cpu_hotplug_props.py
@@ -9,7 +9,7 @@
 # This library is free software; you can redistribute it and/or
 # modify it under the terms of the GNU Lesser General Public
 # License as published by the Free Software Foundation; either
-# version 2 of the License, or (at your option) any later version.
+# version 2.1 of the License, or (at your option) any later version.
 #
 # This library is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/tests/acceptance/x86_cpu_model_versions.py b/tests/acceptance/x86_cpu_model_versions.py
index 01ff614..2b7461b 100644
--- a/tests/acceptance/x86_cpu_model_versions.py
+++ b/tests/acceptance/x86_cpu_model_versions.py
@@ -9,7 +9,7 @@
 # This library is free software; you can redistribute it and/or
 # modify it under the terms of the GNU Lesser General Public
 # License as published by the Free Software Foundation; either
-# version 2 of the License, or (at your option) any later version.
+# version 2.1 of the License, or (at your option) any later version.
 #
 # This library is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/tests/decode/check.sh b/tests/decode/check.sh
index 95445a0..0f086fc 100755
--- a/tests/decode/check.sh
+++ b/tests/decode/check.sh
@@ -1,5 +1,5 @@
 #!/bin/sh
-# This work is licensed under the terms of the GNU LGPL, version 2 or later.
+# This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
 # See the COPYING.LIB file in the top-level directory.
 
 PYTHON=$1
diff --git a/tests/decode/err_argset1.decode b/tests/decode/err_argset1.decode
index fcaebcc..ef9cd63 100644
--- a/tests/decode/err_argset1.decode
+++ b/tests/decode/err_argset1.decode
@@ -1,4 +1,4 @@
-# This work is licensed under the terms of the GNU LGPL, version 2 or later.
+# This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
 # See the COPYING.LIB file in the top-level directory.
 
 # Diagnose duplicate member names
diff --git a/tests/decode/err_argset2.decode b/tests/decode/err_argset2.decode
index 256b2f9..242d8e7 100644
--- a/tests/decode/err_argset2.decode
+++ b/tests/decode/err_argset2.decode
@@ -1,4 +1,4 @@
-# This work is licensed under the terms of the GNU LGPL, version 2 or later.
+# This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
 # See the COPYING.LIB file in the top-level directory.
 
 # Diagnose invalid member names
diff --git a/tests/decode/err_field1.decode b/tests/decode/err_field1.decode
index e07a5a7..5db7001 100644
--- a/tests/decode/err_field1.decode
+++ b/tests/decode/err_field1.decode
@@ -1,4 +1,4 @@
-# This work is licensed under the terms of the GNU LGPL, version 2 or later.
+# This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
 # See the COPYING.LIB file in the top-level directory.
 
 # Diagnose invalid field syntax
diff --git a/tests/decode/err_field2.decode b/tests/decode/err_field2.decode
index 7664a3e..f4a5fd3 100644
--- a/tests/decode/err_field2.decode
+++ b/tests/decode/err_field2.decode
@@ -1,4 +1,4 @@
-# This work is licensed under the terms of the GNU LGPL, version 2 or later.
+# This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
 # See the COPYING.LIB file in the top-level directory.
 
 # Diagnose invalid field width.
diff --git a/tests/decode/err_field3.decode b/tests/decode/err_field3.decode
index 87e680f..8e51986 100644
--- a/tests/decode/err_field3.decode
+++ b/tests/decode/err_field3.decode
@@ -1,4 +1,4 @@
-# This work is licensed under the terms of the GNU LGPL, version 2 or later.
+# This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
 # See the COPYING.LIB file in the top-level directory.
 
 # Diagnose invalid field position.
diff --git a/tests/decode/err_field4.decode b/tests/decode/err_field4.decode
index 888ce47..954866f 100644
--- a/tests/decode/err_field4.decode
+++ b/tests/decode/err_field4.decode
@@ -1,4 +1,4 @@
-# This work is licensed under the terms of the GNU LGPL, version 2 or later.
+# This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
 # See the COPYING.LIB file in the top-level directory.
 
 # Diagnose duplicate field name.
diff --git a/tests/decode/err_field5.decode b/tests/decode/err_field5.decode
index b0c62af..1aae682 100644
--- a/tests/decode/err_field5.decode
+++ b/tests/decode/err_field5.decode
@@ -1,4 +1,4 @@
-# This work is licensed under the terms of the GNU LGPL, version 2 or later.
+# This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
 # See the COPYING.LIB file in the top-level directory.
 
 # Diagnose duplicate function specifier.
diff --git a/tests/decode/err_field6.decode b/tests/decode/err_field6.decode
index a719884..a2e42d4 100644
--- a/tests/decode/err_field6.decode
+++ b/tests/decode/err_field6.decode
@@ -1,4 +1,4 @@
-# This work is licensed under the terms of the GNU LGPL, version 2 or later.
+# This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
 # See the COPYING.LIB file in the top-level directory.
 
 # Diagnose no bits in field
diff --git a/tests/decode/err_init1.decode b/tests/decode/err_init1.decode
index da855bd..df17d58 100644
--- a/tests/decode/err_init1.decode
+++ b/tests/decode/err_init1.decode
@@ -1,4 +1,4 @@
-# This work is licensed under the terms of the GNU LGPL, version 2 or later.
+# This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
 # See the COPYING.LIB file in the top-level directory.
 
 # Diagnose uninitialized member in pattern.
diff --git a/tests/decode/err_init2.decode b/tests/decode/err_init2.decode
index b58de30..63b22de 100644
--- a/tests/decode/err_init2.decode
+++ b/tests/decode/err_init2.decode
@@ -1,4 +1,4 @@
-# This work is licensed under the terms of the GNU LGPL, version 2 or later.
+# This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
 # See the COPYING.LIB file in the top-level directory.
 
 # Diagnose member initialized twice in pattern.
diff --git a/tests/decode/err_init3.decode b/tests/decode/err_init3.decode
index 96790ab..f822b9f 100644
--- a/tests/decode/err_init3.decode
+++ b/tests/decode/err_init3.decode
@@ -1,4 +1,4 @@
-# This work is licensed under the terms of the GNU LGPL, version 2 or later.
+# This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
 # See the COPYING.LIB file in the top-level directory.
 
 # Diagnose member initialized twice in pattern + format.
diff --git a/tests/decode/err_init4.decode b/tests/decode/err_init4.decode
index 4336d46..6d643bf 100644
--- a/tests/decode/err_init4.decode
+++ b/tests/decode/err_init4.decode
@@ -1,4 +1,4 @@
-# This work is licensed under the terms of the GNU LGPL, version 2 or later.
+# This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
 # See the COPYING.LIB file in the top-level directory.
 
 # Diagnose uninitialized member in pattern + format.
diff --git a/tests/decode/err_overlap1.decode b/tests/decode/err_overlap1.decode
index 1ae6347..545ad2d 100644
--- a/tests/decode/err_overlap1.decode
+++ b/tests/decode/err_overlap1.decode
@@ -1,4 +1,4 @@
-# This work is licensed under the terms of the GNU LGPL, version 2 or later.
+# This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
 # See the COPYING.LIB file in the top-level directory.
 
 # Diagnose field overlapping fixedbits.
diff --git a/tests/decode/err_overlap2.decode b/tests/decode/err_overlap2.decode
index 1d6d7a3..b437bb4 100644
--- a/tests/decode/err_overlap2.decode
+++ b/tests/decode/err_overlap2.decode
@@ -1,4 +1,4 @@
-# This work is licensed under the terms of the GNU LGPL, version 2 or later.
+# This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
 # See the COPYING.LIB file in the top-level directory.
 
 # Diagnose field overlapping fixedbits w/format.
diff --git a/tests/decode/err_overlap3.decode b/tests/decode/err_overlap3.decode
index 3ab0c48..8dadb02 100644
--- a/tests/decode/err_overlap3.decode
+++ b/tests/decode/err_overlap3.decode
@@ -1,4 +1,4 @@
-# This work is licensed under the terms of the GNU LGPL, version 2 or later.
+# This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
 # See the COPYING.LIB file in the top-level directory.
 
 # Diagnose field overlapping unspecified bits.
diff --git a/tests/decode/err_overlap4.decode b/tests/decode/err_overlap4.decode
index 53c5399..d759769 100644
--- a/tests/decode/err_overlap4.decode
+++ b/tests/decode/err_overlap4.decode
@@ -1,4 +1,4 @@
-# This work is licensed under the terms of the GNU LGPL, version 2 or later.
+# This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
 # See the COPYING.LIB file in the top-level directory.
 
 # Diagnose fixed bits overlapping unspecified bits.
diff --git a/tests/decode/err_overlap5.decode b/tests/decode/err_overlap5.decode
index df0e31f..1e28ce4 100644
--- a/tests/decode/err_overlap5.decode
+++ b/tests/decode/err_overlap5.decode
@@ -1,4 +1,4 @@
-# This work is licensed under the terms of the GNU LGPL, version 2 or later.
+# This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
 # See the COPYING.LIB file in the top-level directory.
 
 # Diagnose overlapping sub-fields.
diff --git a/tests/decode/err_overlap6.decode b/tests/decode/err_overlap6.decode
index cc69fc8..944b375 100644
--- a/tests/decode/err_overlap6.decode
+++ b/tests/decode/err_overlap6.decode
@@ -1,4 +1,4 @@
-# This work is licensed under the terms of the GNU LGPL, version 2 or later.
+# This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
 # See the COPYING.LIB file in the top-level directory.
 
 # Diagnose overlapping fixed bits w/format.
diff --git a/tests/decode/err_overlap7.decode b/tests/decode/err_overlap7.decode
index 6f55529..7ce081d 100644
--- a/tests/decode/err_overlap7.decode
+++ b/tests/decode/err_overlap7.decode
@@ -1,4 +1,4 @@
-# This work is licensed under the terms of the GNU LGPL, version 2 or later.
+# This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
 # See the COPYING.LIB file in the top-level directory.
 
 # Diagnose overlapping patterns.
diff --git a/tests/decode/err_overlap8.decode b/tests/decode/err_overlap8.decode
index df4bae8..3ffb508 100644
--- a/tests/decode/err_overlap8.decode
+++ b/tests/decode/err_overlap8.decode
@@ -1,4 +1,4 @@
-# This work is licensed under the terms of the GNU LGPL, version 2 or later.
+# This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
 # See the COPYING.LIB file in the top-level directory.
 
 # Diagnose not specified bit (. vs -).
diff --git a/tests/decode/err_overlap9.decode b/tests/decode/err_overlap9.decode
index 58b6ac1..bf732cc 100644
--- a/tests/decode/err_overlap9.decode
+++ b/tests/decode/err_overlap9.decode
@@ -1,4 +1,4 @@
-# This work is licensed under the terms of the GNU LGPL, version 2 or later.
+# This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
 # See the COPYING.LIB file in the top-level directory.
 
 # Diagnose not specified bit (. vs -) w/format.
diff --git a/tests/decode/err_pattern_group_empty.decode b/tests/decode/err_pattern_group_empty.decode
index abbff6b..e72c5d1 100644
--- a/tests/decode/err_pattern_group_empty.decode
+++ b/tests/decode/err_pattern_group_empty.decode
@@ -1,4 +1,4 @@
-# This work is licensed under the terms of the GNU LGPL, version 2 or later.
+# This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
 # See the COPYING.LIB file in the top-level directory.
 
 # empty groups are not allowed
diff --git a/tests/decode/err_pattern_group_ident1.decode b/tests/decode/err_pattern_group_ident1.decode
index 3e65fab..266bac6 100644
--- a/tests/decode/err_pattern_group_ident1.decode
+++ b/tests/decode/err_pattern_group_ident1.decode
@@ -1,4 +1,4 @@
-# This work is licensed under the terms of the GNU LGPL, version 2 or later.
+# This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
 # See the COPYING.LIB file in the top-level directory.
 
 %sub1 0:8
diff --git a/tests/decode/err_pattern_group_ident2.decode b/tests/decode/err_pattern_group_ident2.decode
index bc85923..4df2ec0 100644
--- a/tests/decode/err_pattern_group_ident2.decode
+++ b/tests/decode/err_pattern_group_ident2.decode
@@ -1,4 +1,4 @@
-# This work is licensed under the terms of the GNU LGPL, version 2 or later.
+# This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
 # See the COPYING.LIB file in the top-level directory.
 
 %sub1 0:8
diff --git a/tests/decode/err_pattern_group_nest1.decode b/tests/decode/err_pattern_group_nest1.decode
index 7d09891..73c18a8 100644
--- a/tests/decode/err_pattern_group_nest1.decode
+++ b/tests/decode/err_pattern_group_nest1.decode
@@ -1,4 +1,4 @@
-# This work is licensed under the terms of the GNU LGPL, version 2 or later.
+# This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
 # See the COPYING.LIB file in the top-level directory.
 
 %sub1 0:8
diff --git a/tests/decode/err_pattern_group_nest2.decode b/tests/decode/err_pattern_group_nest2.decode
index c172239..a40f365 100644
--- a/tests/decode/err_pattern_group_nest2.decode
+++ b/tests/decode/err_pattern_group_nest2.decode
@@ -1,4 +1,4 @@
-# This work is licensed under the terms of the GNU LGPL, version 2 or later.
+# This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
 # See the COPYING.LIB file in the top-level directory.
 
 # Make sure braces are matched
diff --git a/tests/decode/err_pattern_group_nest3.decode b/tests/decode/err_pattern_group_nest3.decode
index b085d01..20793e5 100644
--- a/tests/decode/err_pattern_group_nest3.decode
+++ b/tests/decode/err_pattern_group_nest3.decode
@@ -1,4 +1,4 @@
-# This work is licensed under the terms of the GNU LGPL, version 2 or later.
+# This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
 # See the COPYING.LIB file in the top-level directory.
 
 %sub1 0:8
diff --git a/tests/decode/err_width1.decode b/tests/decode/err_width1.decode
index 0c14f6d..836d18d 100644
--- a/tests/decode/err_width1.decode
+++ b/tests/decode/err_width1.decode
@@ -1,4 +1,4 @@
-# This work is licensed under the terms of the GNU LGPL, version 2 or later.
+# This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
 # See the COPYING.LIB file in the top-level directory.
 
 # Diagnose too many bits (33 of 32)
diff --git a/tests/decode/err_width2.decode b/tests/decode/err_width2.decode
index 47f0acf..e8ef32c 100644
--- a/tests/decode/err_width2.decode
+++ b/tests/decode/err_width2.decode
@@ -1,4 +1,4 @@
-# This work is licensed under the terms of the GNU LGPL, version 2 or later.
+# This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
 # See the COPYING.LIB file in the top-level directory.
 
 # Diagnose too few bits (31 of 32)
diff --git a/tests/decode/err_width3.decode b/tests/decode/err_width3.decode
index c5fb6b3..312e0a1 100644
--- a/tests/decode/err_width3.decode
+++ b/tests/decode/err_width3.decode
@@ -1,4 +1,4 @@
-# This work is licensed under the terms of the GNU LGPL, version 2 or later.
+# This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
 # See the COPYING.LIB file in the top-level directory.
 
 # Diagnose too many bits (33 of 32)
diff --git a/tests/decode/err_width4.decode b/tests/decode/err_width4.decode
index 1588a63..f415b28 100644
--- a/tests/decode/err_width4.decode
+++ b/tests/decode/err_width4.decode
@@ -1,4 +1,4 @@
-# This work is licensed under the terms of the GNU LGPL, version 2 or later.
+# This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
 # See the COPYING.LIB file in the top-level directory.
 
 # Diagnose too few bits (31 of 32)
diff --git a/tests/decode/succ_function.decode b/tests/decode/succ_function.decode
index 7751b17..3230e40 100644
--- a/tests/decode/succ_function.decode
+++ b/tests/decode/succ_function.decode
@@ -1,4 +1,4 @@
-# This work is licensed under the terms of the GNU LGPL, version 2 or later.
+# This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
 # See the COPYING.LIB file in the top-level directory.
 
 # "Field" as parameter pulled from DisasContext.
diff --git a/tests/decode/succ_pattern_group_nest1.decode b/tests/decode/succ_pattern_group_nest1.decode
index 77b0f48..640c514 100644
--- a/tests/decode/succ_pattern_group_nest1.decode
+++ b/tests/decode/succ_pattern_group_nest1.decode
@@ -1,4 +1,4 @@
-# This work is licensed under the terms of the GNU LGPL, version 2 or later.
+# This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
 # See the COPYING.LIB file in the top-level directory.
 
 %sub1 0:8
diff --git a/tests/decode/succ_pattern_group_nest2.decode b/tests/decode/succ_pattern_group_nest2.decode
index 8d5ab4b..411ae33 100644
--- a/tests/decode/succ_pattern_group_nest2.decode
+++ b/tests/decode/succ_pattern_group_nest2.decode
@@ -1,4 +1,4 @@
-# This work is licensed under the terms of the GNU LGPL, version 2 or later.
+# This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
 # See the COPYING.LIB file in the top-level directory.
 
 %sub1 0:8
diff --git a/tests/decode/succ_pattern_group_nest3.decode b/tests/decode/succ_pattern_group_nest3.decode
index 156249f..152fbe5 100644
--- a/tests/decode/succ_pattern_group_nest3.decode
+++ b/tests/decode/succ_pattern_group_nest3.decode
@@ -1,4 +1,4 @@
-# This work is licensed under the terms of the GNU LGPL, version 2 or later.
+# This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
 # See the COPYING.LIB file in the top-level directory.
 
 {
diff --git a/tests/decode/succ_pattern_group_nest4.decode b/tests/decode/succ_pattern_group_nest4.decode
index dc54a1d..2b94a3e 100644
--- a/tests/decode/succ_pattern_group_nest4.decode
+++ b/tests/decode/succ_pattern_group_nest4.decode
@@ -1,4 +1,4 @@
-# This work is licensed under the terms of the GNU LGPL, version 2 or later.
+# This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
 # See the COPYING.LIB file in the top-level directory.
 
 # Verify deeper nesting, and a single element in the groups.
diff --git a/tests/io-channel-helpers.c b/tests/io-channel-helpers.c
index ab988ef..ff156ed 100644
--- a/tests/io-channel-helpers.c
+++ b/tests/io-channel-helpers.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/tests/io-channel-helpers.h b/tests/io-channel-helpers.h
index bb2de6f..3d14043 100644
--- a/tests/io-channel-helpers.h
+++ b/tests/io-channel-helpers.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/tests/migration/guestperf-batch.py b/tests/migration/guestperf-batch.py
index f1e9009..ab6bdb9 100755
--- a/tests/migration/guestperf-batch.py
+++ b/tests/migration/guestperf-batch.py
@@ -7,7 +7,7 @@
 # This library is free software; you can redistribute it and/or
 # modify it under the terms of the GNU Lesser General Public
 # License as published by the Free Software Foundation; either
-# version 2 of the License, or (at your option) any later version.
+# version 2.1 of the License, or (at your option) any later version.
 #
 # This library is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/tests/migration/guestperf-plot.py b/tests/migration/guestperf-plot.py
index 9071510..32977b4 100755
--- a/tests/migration/guestperf-plot.py
+++ b/tests/migration/guestperf-plot.py
@@ -7,7 +7,7 @@
 # This library is free software; you can redistribute it and/or
 # modify it under the terms of the GNU Lesser General Public
 # License as published by the Free Software Foundation; either
-# version 2 of the License, or (at your option) any later version.
+# version 2.1 of the License, or (at your option) any later version.
 #
 # This library is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/tests/migration/guestperf.py b/tests/migration/guestperf.py
index ba1c4bc..e8cc127 100755
--- a/tests/migration/guestperf.py
+++ b/tests/migration/guestperf.py
@@ -7,7 +7,7 @@
 # This library is free software; you can redistribute it and/or
 # modify it under the terms of the GNU Lesser General Public
 # License as published by the Free Software Foundation; either
-# version 2 of the License, or (at your option) any later version.
+# version 2.1 of the License, or (at your option) any later version.
 #
 # This library is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/tests/migration/guestperf/comparison.py b/tests/migration/guestperf/comparison.py
index d0b7df9..ba2edbe 100644
--- a/tests/migration/guestperf/comparison.py
+++ b/tests/migration/guestperf/comparison.py
@@ -6,7 +6,7 @@
 # This library is free software; you can redistribute it and/or
 # modify it under the terms of the GNU Lesser General Public
 # License as published by the Free Software Foundation; either
-# version 2 of the License, or (at your option) any later version.
+# version 2.1 of the License, or (at your option) any later version.
 #
 # This library is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/tests/migration/guestperf/engine.py b/tests/migration/guestperf/engine.py
index fd63c66..e2a214b 100644
--- a/tests/migration/guestperf/engine.py
+++ b/tests/migration/guestperf/engine.py
@@ -6,7 +6,7 @@
 # This library is free software; you can redistribute it and/or
 # modify it under the terms of the GNU Lesser General Public
 # License as published by the Free Software Foundation; either
-# version 2 of the License, or (at your option) any later version.
+# version 2.1 of the License, or (at your option) any later version.
 #
 # This library is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/tests/migration/guestperf/hardware.py b/tests/migration/guestperf/hardware.py
index a66c9dd..3145785 100644
--- a/tests/migration/guestperf/hardware.py
+++ b/tests/migration/guestperf/hardware.py
@@ -6,7 +6,7 @@
 # This library is free software; you can redistribute it and/or
 # modify it under the terms of the GNU Lesser General Public
 # License as published by the Free Software Foundation; either
-# version 2 of the License, or (at your option) any later version.
+# version 2.1 of the License, or (at your option) any later version.
 #
 # This library is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/tests/migration/guestperf/plot.py b/tests/migration/guestperf/plot.py
index 34cebd5..30b3f66 100644
--- a/tests/migration/guestperf/plot.py
+++ b/tests/migration/guestperf/plot.py
@@ -6,7 +6,7 @@
 # This library is free software; you can redistribute it and/or
 # modify it under the terms of the GNU Lesser General Public
 # License as published by the Free Software Foundation; either
-# version 2 of the License, or (at your option) any later version.
+# version 2.1 of the License, or (at your option) any later version.
 #
 # This library is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/tests/migration/guestperf/progress.py b/tests/migration/guestperf/progress.py
index 46d2157..ab1ee57 100644
--- a/tests/migration/guestperf/progress.py
+++ b/tests/migration/guestperf/progress.py
@@ -6,7 +6,7 @@
 # This library is free software; you can redistribute it and/or
 # modify it under the terms of the GNU Lesser General Public
 # License as published by the Free Software Foundation; either
-# version 2 of the License, or (at your option) any later version.
+# version 2.1 of the License, or (at your option) any later version.
 #
 # This library is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/tests/migration/guestperf/report.py b/tests/migration/guestperf/report.py
index 6a1f971..1efd40c 100644
--- a/tests/migration/guestperf/report.py
+++ b/tests/migration/guestperf/report.py
@@ -6,7 +6,7 @@
 # This library is free software; you can redistribute it and/or
 # modify it under the terms of the GNU Lesser General Public
 # License as published by the Free Software Foundation; either
-# version 2 of the License, or (at your option) any later version.
+# version 2.1 of the License, or (at your option) any later version.
 #
 # This library is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/tests/migration/guestperf/scenario.py b/tests/migration/guestperf/scenario.py
index 705c2e8..28ef36c 100644
--- a/tests/migration/guestperf/scenario.py
+++ b/tests/migration/guestperf/scenario.py
@@ -6,7 +6,7 @@
 # This library is free software; you can redistribute it and/or
 # modify it under the terms of the GNU Lesser General Public
 # License as published by the Free Software Foundation; either
-# version 2 of the License, or (at your option) any later version.
+# version 2.1 of the License, or (at your option) any later version.
 #
 # This library is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/tests/migration/guestperf/shell.py b/tests/migration/guestperf/shell.py
index 5bcc066..f838888 100644
--- a/tests/migration/guestperf/shell.py
+++ b/tests/migration/guestperf/shell.py
@@ -6,7 +6,7 @@
 # This library is free software; you can redistribute it and/or
 # modify it under the terms of the GNU Lesser General Public
 # License as published by the Free Software Foundation; either
-# version 2 of the License, or (at your option) any later version.
+# version 2.1 of the License, or (at your option) any later version.
 #
 # This library is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/tests/migration/guestperf/timings.py b/tests/migration/guestperf/timings.py
index f94d809..2374010 100644
--- a/tests/migration/guestperf/timings.py
+++ b/tests/migration/guestperf/timings.py
@@ -6,7 +6,7 @@
 # This library is free software; you can redistribute it and/or
 # modify it under the terms of the GNU Lesser General Public
 # License as published by the Free Software Foundation; either
-# version 2 of the License, or (at your option) any later version.
+# version 2.1 of the License, or (at your option) any later version.
 #
 # This library is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/tests/migration/stress.c b/tests/migration/stress.c
index 0c72a42..de45e8e 100644
--- a/tests/migration/stress.c
+++ b/tests/migration/stress.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/tests/qemu-iotests/socket_scm_helper.c b/tests/qemu-iotests/socket_scm_helper.c
index eb76d31..9fb4d11 100644
--- a/tests/qemu-iotests/socket_scm_helper.c
+++ b/tests/qemu-iotests/socket_scm_helper.c
@@ -6,7 +6,7 @@
  * Authors:
  *  Wenchao Xia    <xiawenc@linux.vnet.ibm.com>
  *
- * This work is licensed under the terms of the GNU LGPL, version 2 or later.
+ * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
  * See the COPYING.LIB file in the top-level directory.
  */
 
diff --git a/tests/test-aio-multithread.c b/tests/test-aio-multithread.c
index a555cc8..f77f022 100644
--- a/tests/test-aio-multithread.c
+++ b/tests/test-aio-multithread.c
@@ -6,7 +6,7 @@
  * Authors:
  *  Paolo Bonzini    <pbonzini@redhat.com>
  *
- * This work is licensed under the terms of the GNU LGPL, version 2 or later.
+ * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
  * See the COPYING.LIB file in the top-level directory.
  */
 
diff --git a/tests/test-aio.c b/tests/test-aio.c
index 8a46078..69cfcbb 100644
--- a/tests/test-aio.c
+++ b/tests/test-aio.c
@@ -6,7 +6,7 @@
  * Authors:
  *  Paolo Bonzini    <pbonzini@redhat.com>
  *
- * This work is licensed under the terms of the GNU LGPL, version 2 or later.
+ * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
  * See the COPYING.LIB file in the top-level directory.
  */
 
diff --git a/tests/test-authz-list.c b/tests/test-authz-list.c
index d80e6a6..5351992 100644
--- a/tests/test-authz-list.c
+++ b/tests/test-authz-list.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/tests/test-authz-listfile.c b/tests/test-authz-listfile.c
index 26166b6..64d0e15 100644
--- a/tests/test-authz-listfile.c
+++ b/tests/test-authz-listfile.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/tests/test-authz-pam.c b/tests/test-authz-pam.c
index 02bb149..1baeade 100644
--- a/tests/test-authz-pam.c
+++ b/tests/test-authz-pam.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/tests/test-authz-simple.c b/tests/test-authz-simple.c
index d21d43e..6f9034d 100644
--- a/tests/test-authz-simple.c
+++ b/tests/test-authz-simple.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/tests/test-base64.c b/tests/test-base64.c
index a7f722c..3012d7b 100644
--- a/tests/test-base64.c
+++ b/tests/test-base64.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/tests/test-bitcnt.c b/tests/test-bitcnt.c
index e153dcb..59b2849 100644
--- a/tests/test-bitcnt.c
+++ b/tests/test-bitcnt.c
@@ -1,7 +1,7 @@
 /*
  * Test bit count routines
  *
- * This work is licensed under the terms of the GNU LGPL, version 2 or later.
+ * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
  * See the COPYING.LIB file in the top-level directory.
  *
  */
diff --git a/tests/test-bitops.c b/tests/test-bitops.c
index 5a791d2..33b07a9 100644
--- a/tests/test-bitops.c
+++ b/tests/test-bitops.c
@@ -1,7 +1,7 @@
 /*
  * Test bitops routines
  *
- * This work is licensed under the terms of the GNU LGPL, version 2 or later.
+ * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
  * See the COPYING.LIB file in the top-level directory.
  *
  */
diff --git a/tests/test-blockjob-txn.c b/tests/test-blockjob-txn.c
index 8bd13b9..d8f4aeb 100644
--- a/tests/test-blockjob-txn.c
+++ b/tests/test-blockjob-txn.c
@@ -6,7 +6,7 @@
  * Authors:
  *  Stefan Hajnoczi    <stefanha@redhat.com>
  *
- * This work is licensed under the terms of the GNU LGPL, version 2 or later.
+ * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
  * See the COPYING.LIB file in the top-level directory.
  */
 
diff --git a/tests/test-blockjob.c b/tests/test-blockjob.c
index 7519847..aa156a1 100644
--- a/tests/test-blockjob.c
+++ b/tests/test-blockjob.c
@@ -6,7 +6,7 @@
  * Authors:
  *  Alberto Garcia   <berto@igalia.com>
  *
- * This work is licensed under the terms of the GNU LGPL, version 2 or later.
+ * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
  * See the COPYING.LIB file in the top-level directory.
  */
 
diff --git a/tests/test-bufferiszero.c b/tests/test-bufferiszero.c
index 42d194c..e45fd31 100644
--- a/tests/test-bufferiszero.c
+++ b/tests/test-bufferiszero.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/tests/test-coroutine.c b/tests/test-coroutine.c
index e946d93..41631cc 100644
--- a/tests/test-coroutine.c
+++ b/tests/test-coroutine.c
@@ -6,7 +6,7 @@
  * Authors:
  *  Stefan Hajnoczi    <stefanha@linux.vnet.ibm.com>
  *
- * This work is licensed under the terms of the GNU LGPL, version 2 or later.
+ * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
  * See the COPYING.LIB file in the top-level directory.
  *
  */
diff --git a/tests/test-crypto-afsplit.c b/tests/test-crypto-afsplit.c
index f9f2fcd..00a7c18 100644
--- a/tests/test-crypto-afsplit.c
+++ b/tests/test-crypto-afsplit.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/tests/test-crypto-block.c b/tests/test-crypto-block.c
index 7c1ab07..3b1f0d5 100644
--- a/tests/test-crypto-block.c
+++ b/tests/test-crypto-block.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/tests/test-crypto-cipher.c b/tests/test-crypto-cipher.c
index bebba1a..280319a 100644
--- a/tests/test-crypto-cipher.c
+++ b/tests/test-crypto-cipher.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/tests/test-crypto-hash.c b/tests/test-crypto-hash.c
index 214a9f7..ce7d0ab 100644
--- a/tests/test-crypto-hash.c
+++ b/tests/test-crypto-hash.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/tests/test-crypto-ivgen.c b/tests/test-crypto-ivgen.c
index a5ff5d3..f581e6a 100644
--- a/tests/test-crypto-ivgen.c
+++ b/tests/test-crypto-ivgen.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/tests/test-crypto-pbkdf.c b/tests/test-crypto-pbkdf.c
index 85ed1f9..c50fd63 100644
--- a/tests/test-crypto-pbkdf.c
+++ b/tests/test-crypto-pbkdf.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/tests/test-crypto-secret.c b/tests/test-crypto-secret.c
index 9d06176..34a4aec 100644
--- a/tests/test-crypto-secret.c
+++ b/tests/test-crypto-secret.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/tests/test-crypto-xts.c b/tests/test-crypto-xts.c
index 6fb61cf..7acbc95 100644
--- a/tests/test-crypto-xts.c
+++ b/tests/test-crypto-xts.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/tests/test-int128.c b/tests/test-int128.c
index b86a3c7..ff18570 100644
--- a/tests/test-int128.c
+++ b/tests/test-int128.c
@@ -1,7 +1,7 @@
 /*
  * Test Int128 arithmetic
  *
- * This work is licensed under the terms of the GNU LGPL, version 2 or later.
+ * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
  * See the COPYING.LIB file in the top-level directory.
  *
  */
diff --git a/tests/test-io-channel-buffer.c b/tests/test-io-channel-buffer.c
index 59d6c64..9c6724d 100644
--- a/tests/test-io-channel-buffer.c
+++ b/tests/test-io-channel-buffer.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/tests/test-io-channel-command.c b/tests/test-io-channel-command.c
index 3bc5266..99056e0 100644
--- a/tests/test-io-channel-command.c
+++ b/tests/test-io-channel-command.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/tests/test-io-channel-file.c b/tests/test-io-channel-file.c
index 0aa0477..29038e6 100644
--- a/tests/test-io-channel-file.c
+++ b/tests/test-io-channel-file.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/tests/test-io-channel-socket.c b/tests/test-io-channel-socket.c
index 743577d..c49eec1 100644
--- a/tests/test-io-channel-socket.c
+++ b/tests/test-io-channel-socket.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/tests/test-io-task.c b/tests/test-io-task.c
index 85e7a98..953a50a 100644
--- a/tests/test-io-task.c
+++ b/tests/test-io-task.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/tests/test-mul64.c b/tests/test-mul64.c
index 9be775d..e37ad03 100644
--- a/tests/test-mul64.c
+++ b/tests/test-mul64.c
@@ -1,7 +1,7 @@
 /*
  * Test 64x64 -> 128 multiply subroutines
  *
- * This work is licensed under the terms of the GNU LGPL, version 2 or later.
+ * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
  * See the COPYING.LIB file in the top-level directory.
  *
  */
diff --git a/tests/test-qgraph.c b/tests/test-qgraph.c
index 267291c..ae2f7b2 100644
--- a/tests/test-qgraph.c
+++ b/tests/test-qgraph.c
@@ -5,7 +5,7 @@
  *
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
- * License version 2 as published by the Free Software Foundation.
+ * License version 2.1 as published by the Free Software Foundation.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/tests/test-shift128.c b/tests/test-shift128.c
index f3ff736..cd1ccdc 100644
--- a/tests/test-shift128.c
+++ b/tests/test-shift128.c
@@ -1,7 +1,7 @@
 /*
  * Test unsigned left and right shift
  *
- * This work is licensed under the terms of the GNU LGPL, version 2 or later.
+ * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
  * See the COPYING.LIB file in the top-level directory.
  *
  */
diff --git a/tests/test-throttle.c b/tests/test-throttle.c
index 7adb5e6..851ec6f 100644
--- a/tests/test-throttle.c
+++ b/tests/test-throttle.c
@@ -8,7 +8,7 @@
  *  Benoît Canet     <benoit.canet@nodalink.com>
  *  Alberto Garcia   <berto@igalia.com>
  *
- * This work is licensed under the terms of the GNU LGPL, version 2 or later.
+ * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
  * See the COPYING.LIB file in the top-level directory.
  */
 
diff --git a/tests/test-timed-average.c b/tests/test-timed-average.c
index e2bcf5f..5c504dc 100644
--- a/tests/test-timed-average.c
+++ b/tests/test-timed-average.c
@@ -6,7 +6,7 @@
  * Authors:
  *  Benoît Canet     <benoit.canet@nodalink.com>
  *
- * This work is licensed under the terms of the GNU LGPL, version 2 or later.
+ * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
  * See the COPYING.LIB file in the top-level directory.
  */
 
diff --git a/tests/test-uuid.c b/tests/test-uuid.c
index 22b4b07..c111de5 100644
--- a/tests/test-uuid.c
+++ b/tests/test-uuid.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/tests/test-write-threshold.c b/tests/test-write-threshold.c
index 97ca12f..e86f205 100644
--- a/tests/test-write-threshold.c
+++ b/tests/test-write-threshold.c
@@ -1,7 +1,7 @@
 /*
  * Test block device write threshold
  *
- * This work is licensed under the terms of the GNU LGPL, version 2 or later.
+ * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
  * See the COPYING.LIB file in the top-level directory.
  *
  */
diff --git a/thunk.c b/thunk.c
index 0718325..fc5be1a 100644
--- a/thunk.c
+++ b/thunk.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/ui/x_keymap.c b/ui/x_keymap.c
index 2bc0143..555086f 100644
--- a/ui/x_keymap.c
+++ b/ui/x_keymap.c
@@ -5,7 +5,7 @@
  * Copyright (C) 2017 Red Hat, Inc
  *
  * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU Lesser General Public License version 2 as
+ * it under the terms of the GNU Lesser General Public License version 2.1 as
  * published by the Free Software Foundation.
  */
 
diff --git a/util/base64.c b/util/base64.c
index 9d3c46c..811111a 100644
--- a/util/base64.c
+++ b/util/base64.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/util/buffer.c b/util/buffer.c
index d8bb874..743eaa9 100644
--- a/util/buffer.c
+++ b/util/buffer.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/util/filemonitor-inotify.c b/util/filemonitor-inotify.c
index b5f4b93..2c45f7f 100644
--- a/util/filemonitor-inotify.c
+++ b/util/filemonitor-inotify.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/util/filemonitor-stub.c b/util/filemonitor-stub.c
index 2c0e97e..93fef65 100644
--- a/util/filemonitor-stub.c
+++ b/util/filemonitor-stub.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/util/log.c b/util/log.c
index 4b42306..2ee1500 100644
--- a/util/log.c
+++ b/util/log.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index c654daf..48e34c1 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -367,7 +367,7 @@ char *qemu_get_exec_dir(void)
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/util/qemu-coroutine-sleep.c b/util/qemu-coroutine-sleep.c
index 8c4dac4..29a65f8 100644
--- a/util/qemu-coroutine-sleep.c
+++ b/util/qemu-coroutine-sleep.c
@@ -6,7 +6,7 @@
  * Authors:
  *  Stefan Hajnoczi    <stefanha@linux.vnet.ibm.com>
  *
- * This work is licensed under the terms of the GNU LGPL, version 2 or later.
+ * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
  * See the COPYING.LIB file in the top-level directory.
  *
  */
diff --git a/util/qemu-coroutine.c b/util/qemu-coroutine.c
index 38fb6d3..8fe4bbe 100644
--- a/util/qemu-coroutine.c
+++ b/util/qemu-coroutine.c
@@ -7,7 +7,7 @@
  *  Stefan Hajnoczi    <stefanha@linux.vnet.ibm.com>
  *  Kevin Wolf         <kwolf@redhat.com>
  *
- * This work is licensed under the terms of the GNU LGPL, version 2 or later.
+ * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
  * See the COPYING.LIB file in the top-level directory.
  *
  */
-- 
2.17.1


