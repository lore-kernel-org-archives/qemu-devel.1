Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7CECC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 18:16:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB791207EA
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 18:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MS8wezdz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB791207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGR74-0007jr-OU
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 14:16:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54978)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kGR5o-00079z-1h; Thu, 10 Sep 2020 14:14:44 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:40795)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kGR5l-0001VT-Es; Thu, 10 Sep 2020 14:14:43 -0400
Received: by mail-oi1-x243.google.com with SMTP id t76so6808217oif.7;
 Thu, 10 Sep 2020 11:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:mime-version:content-transfer-encoding:to:from:in-reply-to
 :cc:references:message-id:user-agent:subject:date;
 bh=CIw4nu+O6ExZkZNMiHB9u3Fr00VdNoG4TVgcHBDa4Po=;
 b=MS8wezdzdYebR7zl3jjSWOQzKm8GLHwAc0siFTGgIOEzKvQiCy9KeemwmdkVqajHMl
 mxX+84qyhJfDjTkLHrOtlTWhLnA8zb03LhfKnE4/UWZoM6j0NlbRPiotmfRqcEL/Otix
 CQX2Et1jy3KPjDNFfUVC67v3joH7sMqtKSBCrfMOYGCbqO6V7/w39M2KcnaY+6w4AjlH
 9NkgXXtr67LDPWi1rhaNrNqkILkdI8UYRvbYrvZQvdbW8B88KhWDjINW1Ftk8ePz8rSg
 zu7kGAnAGQdnpY6F6mcYdfmbzbkYMOESJ+yBVL1dnwAsz8r01ZFZDcDGCRyQugA9IPTV
 PsmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:mime-version:content-transfer-encoding:to
 :from:in-reply-to:cc:references:message-id:user-agent:subject:date;
 bh=CIw4nu+O6ExZkZNMiHB9u3Fr00VdNoG4TVgcHBDa4Po=;
 b=Pz2/BojD/LECw3/KX63+C9r9iTgncvG3/WmPJLfx+7YbZpyEDQPJT8VkbPwPkS1RJS
 PJhexAb1YDfHmMXi+YED40huvKQ0ASlUKzrJaDPlGlkepySQ+JltGsjoyj7LucFMBTyD
 KwQJ0xI1eIbohPIO6aJNDwQZPcT+XYunaKUPqNSS7+5wdjuNEKpXiUc4UEDg35HDZEgu
 +TEg4qsGP1pmcFQon1yiLlXgK925q5Sh5QJCYIfmROqKQjv++w1F6n1mA9IfjCQ9XZGQ
 98hICiI7Fvrx7j3fG1aReOqlJzSU8BPI+iuHNZ60MCzfEFI1xV8DL4lqYKdIdcHuFdHq
 U1OA==
X-Gm-Message-State: AOAM530LirtH4XM4aYja+5bHBaWazTV2rXZCiocvurIDm1pqLSYMJ4tv
 A5G8P7SIil3Pk/3Z9zZc5dVycGqSW9I=
X-Google-Smtp-Source: ABdhPJxA8FS64SAWRR3qtsCjgiUkUdQWxSxy/AmId9mk/RHt/eLOS7IexqNLCxA/Y3+sobwsIKAavA==
X-Received: by 2002:aca:6c6:: with SMTP id 189mr770267oig.134.1599761678453;
 Thu, 10 Sep 2020 11:14:38 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id 39sm925780oto.67.2020.09.10.11.14.37
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 10 Sep 2020 11:14:37 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: qemu-devel@nongnu.org
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
References: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
Message-ID: <159976167179.29065.15527378176057475720@sif>
User-Agent: alot/0.7
Subject: Re: [PATCH 00/77] Patch Round-up for stable 5.0.1,
 freeze on 2020-09-10
Date: Thu, 10 Sep 2020 13:14:31 -0500
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=flukshun@gmail.com; helo=mail-oi1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Quoting Michael Roth (2020-09-03 15:58:18)
> Hi everyone,
> =

> The following new patches are queued for QEMU stable v5.0.1:
> =

>   https://github.com/mdroth/qemu/commits/stable-5.0-staging
> =

> Patch freeze is 2020-09-10, and the release is planned for 2020-09-15:
> =

>   https://wiki.qemu.org/Planning/5.0
> =

> Please respond here or CC qemu-stable@nongnu.org on any additional patches
> you think should be included in the release.

Updated staging tree with the following patches:
  virtio-ccw: fix virtio_set_ind_atomic
  nvram: Exit QEMU if NVRAM cannot contain all -prom-env data
  9p: null terminate fs driver options list

and removed as suggested:
  virtio: list legacy-capable devices
  virtio: verify that legacy support is not accidentally on

Thanks for the suggestions!

> =

> Thanks!
> =

> =

> ----------------------------------------------------------------
> Alexander Duyck (3):
>       virtio-balloon: Prevent guest from starting a report when we didn't=
 request one
>       virtio-balloon: Add locking to prevent possible race when starting =
hinting
>       virtio-balloon: Replace free page hinting references to 'report' wi=
th 'hint'
> =

> Alistair Francis (1):
>       hw/riscv: Allow 64 bit access to SiFive CLINT
> =

> Allan Peramaki (1):
>       hw/audio/gus: Fix registers 32-bit access
> =

> Andrew Melnychenko (1):
>       virtio-pci: Changed vdev to proxy for VirtIO PCI BAR callbacks.
> =

> Christian Schoenebeck (1):
>       xen-9pfs: Fix log messages of reply errors
> =

> Cornelia Huck (3):
>       linux-headers: update against Linux 5.7-rc3
>       virtio: list legacy-capable devices
>       virtio: verify that legacy support is not accidentally on
> =

> Dan Robertson (1):
>       9pfs: include linux/limits.h for XATTR_SIZE_MAX
> =

> David Hildenbrand (4):
>       virtio-balloon: fix free page hinting without an iothread
>       virtio-balloon: fix free page hinting check on unrealize
>       virtio-balloon: unref the iothread when unrealizing
>       virtio-balloon: always indicate S_DONE when migration fails
> =

> Eric Blake (4):
>       nbd/server: Avoid long error message assertions CVE-2020-10761
>       block: Call attention to truncation of long NBD exports
>       nbd: Avoid off-by-one in long export name truncation
>       nbd: Fix large trim/zero requests
> =

> Gerd Hoffmann (1):
>       usb: fix setup_len init (CVE-2020-14364)
> =

> Graeme Gregory (1):
>       hw/arm/sbsa-ref: fix typo breaking PCIe IRQs
> =

> Greg Kurz (1):
>       9p: Lock directory streams with a CoMutex
> =

> Helge Deller (2):
>       Fix tulip breakage
>       hw/display/artist: Unbreak size mismatch memory accesses
> =

> Igor Mammedov (1):
>       hostmem: don't use mbind() if host-nodes is empty
> =

> Jason Wang (1):
>       net: use peer when purging queue in qemu_flush_or_purge_queue_packe=
ts()
> =

> Kevin Wolf (1):
>       iotests/283: Use consistent size for source and target
> =

> Laurent Vivier (1):
>       xhci: fix valid.max_access_size to access address registers
> =

> Liu Yi L (1):
>       intel_iommu: Use correct shift for 256 bits qi descriptor
> =

> Marc-Andr=C3=A9 Lureau (1):
>       qga: fix assert regression on guest-shutdown
> =

> Mark Cave-Ayland (1):
>       Update OpenBIOS images to 7f28286f built from submodule.
> =

> Markus Armbruster (4):
>       net/virtio: Fix failover_replug_primary() return value regression
>       error: Use error_reportf_err() where appropriate
>       usb/dev-mtp: Fix Error double free after inotify failure
>       qdev: Fix device_add DRIVER,help to print to monitor
> =

> Max Reitz (3):
>       virtiofsd: Whitelist fchmod
>       block: Fix bdrv_aligned_p*v() for qiov_offset !=3D 0
>       iotests/028: Add test for cross-base-EOF reads
> =

> Michael S. Tsirkin (1):
>       memory: Revert "memory: accept mismatching sizes in memory_region_a=
ccess_valid"
> =

> Michael Tokarev (1):
>       acpi: accept byte and word access to core ACPI registers
> =

> Michal Privoznik (2):
>       util: Introduce qemu_get_host_name()
>       qga: Use qemu_get_host_name() instead of g_get_host_name()
> =

> Niek Linnenbank (1):
>       docs/orangepi: Add instructions for resizing SD image to power of t=
wo
> =

> Omar Sandoval (1):
>       9pfs: local: ignore O_NOATIME if we don't have permissions
> =

> Paolo Bonzini (3):
>       KVM: x86: believe what KVM says about WAITPKG
>       libqos: usb-hcd-ehci: use 32-bit write for config register
>       libqos: pci-pc: use 32-bit write for EJ register
> =

> Pavel Dovgaluk (3):
>       tests/acceptance: allow console interaction with specific VMs
>       tests/acceptance: refactor boot_linux to allow code reuse
>       tests/acceptance: refactor boot_linux_console test to allow code re=
use
> =

> Philippe Mathieu-Daud=C3=A9 (9):
>       hw/net/e1000e: Do not abort() on invalid PSRCTL register value
>       tests/acceptance/boot_linux: Tag tests using a SD card with 'device=
:sd'
>       tests/acceptance/boot_linux: Expand SD card image to power of 2
>       hw/sd/sdcard: Restrict Class 6 commands to SCSD cards
>       hw/sd/sdcard: Simplify realize() a bit
>       hw/sd/sdcard: Do not allow invalid SD card sizes
>       hw/sd/sdcard: Update coding style to make checkpatch.pl happy
>       hw/sd/sdcard: Do not switch to ReceivingData if address is invalid
>       libvhost-user: Report descriptor index on panic
> =

> Prasad J Pandit (2):
>       ati-vga: check mm_index before recursive call (CVE-2020-13800)
>       es1370: check total frame count against current frame
> =

> Raphael Pour (1):
>       qemu-nbd: Close inherited stderr
> =

> Richard Henderson (2):
>       target/arm: Clear tail in gvec_fmul_idx_*, gvec_fmla_idx_*
>       target/hppa: Free some temps in do_sub
> =

> Sergei Trofimovich (1):
>       linux-user/strace.list: fix epoll_create{,1} -strace output
> =

> Stefan Berger (2):
>       tpm: tpm_spapr: Exit on TPM backend failures
>       tests: tpm: Skip over pcrUpdateCounter byte in result comparison
> =

> Stefan Hajnoczi (4):
>       virtiofsd: add --rlimit-nofile=3DNUM option
>       virtiofsd: stay below fs.file-max sysctl value (CVE-2020-10717)
>       aio-posix: don't duplicate fd handler deletion in fdmon_io_uring_de=
stroy()
>       aio-posix: disable fdmon-io_uring when GSource is used
> =

> Stefano Stabellini (2):
>       Revert "9p: init_in_iov_from_pdu can truncate the size"
>       xen/9pfs: yield when there isn't enough room on the ring
> =

> Thomas Huth (1):
>       net: Do not include a newline in the id of -nic devices
> =

> Vladimir Sementsov-Ogievskiy (1):
>       migration/block-dirty-bitmap: fix dirty_bitmap_mig_before_vm_start
> =

> Yuri Benditovich (1):
>       virtio-net: align RSC fields with updated virtio-net header
> =

> lichun (1):
>       chardev/tcp: Fix error message double free error
> =

>  backends/hostmem.c                                 |   6 +-
>  block.c                                            |   7 +-
>  block/io.c                                         |  10 +-
>  block/nbd.c                                        |  21 ++--
>  chardev/char-socket.c                              |   8 +-
>  contrib/libvhost-user/libvhost-user.c              |   4 +-
>  docs/system/arm/orangepi.rst                       |  16 ++-
>  hw/9pfs/9p-util.h                                  |  13 ++
>  hw/9pfs/9p.c                                       |  34 ++----
>  hw/9pfs/9p.h                                       |  10 +-
>  hw/9pfs/virtio-9p-device.c                         |  11 +-
>  hw/9pfs/xen-9p-backend.c                           |  41 +++++--
>  hw/acpi/core.c                                     |   9 +-
>  hw/arm/sbsa-ref.c                                  |   2 +-
>  hw/audio/es1370.c                                  |   7 +-
>  hw/audio/gusemu_hal.c                              |   2 +-
>  hw/audio/gusemu_mixer.c                            |   2 +-
>  hw/display/artist.c                                |  12 +-
>  hw/display/ati.c                                   |  10 +-
>  hw/i386/intel_iommu.c                              |   7 +-
>  hw/i386/intel_iommu_internal.h                     |   3 +-
>  hw/net/e1000e_core.c                               |  10 +-
>  hw/net/tulip.c                                     |   6 -
>  hw/net/virtio-net.c                                |  29 +----
>  hw/riscv/sifive_clint.c                            |   2 +-
>  hw/s390x/virtio-ccw.c                              |   6 +
>  hw/sd/pxa2xx_mmci.c                                |   4 +-
>  hw/sd/sd.c                                         |  90 ++++++++++----
>  hw/tpm/tpm_spapr.c                                 |   5 +-
>  hw/usb/core.c                                      |  16 ++-
>  hw/usb/dev-mtp.c                                   |  11 +-
>  hw/usb/hcd-xhci.c                                  |   4 +-
>  hw/virtio/virtio-balloon.c                         | 133 ++++++++++++---=
------
>  hw/virtio/virtio-pci.c                             |  38 ++++--
>  hw/virtio/virtio.c                                 |  25 ++++
>  include/block/aio.h                                |   3 +
>  include/hw/virtio/virtio-balloon.h                 |  20 ++--
>  include/hw/virtio/virtio.h                         |   2 +
>  include/qemu/osdep.h                               |  10 ++
>  include/standard-headers/linux/ethtool.h           |  10 +-
>  include/standard-headers/linux/input-event-codes.h |   5 +-
>  include/standard-headers/linux/pci_regs.h          |   2 +
>  include/standard-headers/linux/vhost_types.h       |   8 ++
>  include/standard-headers/linux/virtio_balloon.h    |  12 +-
>  include/standard-headers/linux/virtio_ids.h        |   1 +
>  include/standard-headers/linux/virtio_net.h        | 102 +++++++++++++++-
>  linux-headers/COPYING                              |   2 +
>  linux-headers/asm-x86/kvm.h                        |   1 +
>  linux-headers/asm-x86/unistd_32.h                  |   1 +
>  linux-headers/asm-x86/unistd_64.h                  |   1 +
>  linux-headers/asm-x86/unistd_x32.h                 |   1 +
>  linux-headers/linux/kvm.h                          |  47 +++++++-
>  linux-headers/linux/mman.h                         |   5 +-
>  linux-headers/linux/userfaultfd.h                  |  40 +++++--
>  linux-headers/linux/vfio.h                         |  37 ++++++
>  linux-headers/linux/vhost.h                        |  24 ++++
>  linux-user/strace.list                             |   4 +-
>  memory.c                                           |  29 ++---
>  migration/block-dirty-bitmap.c                     |   2 +-
>  nbd/server.c                                       |  51 ++++++--
>  net/net.c                                          |   4 +-
>  pc-bios/openbios-ppc                               | Bin 696912 -> 69691=
2 bytes
>  pc-bios/openbios-sparc32                           | Bin 382048 -> 38204=
8 bytes
>  pc-bios/openbios-sparc64                           | Bin 1593408 -> 1593=
408 bytes
>  qdev-monitor.c                                     |   2 +-
>  qemu-nbd.c                                         |  13 +-
>  qga/commands.c                                     |  17 ++-
>  qga/main.c                                         |   6 +-
>  roms/openbios                                      |   2 +-
>  scsi/qemu-pr-helper.c                              |   4 +-
>  target/arm/vec_helper.c                            |   2 +
>  target/hppa/translate.c                            |   2 +
>  target/i386/cpu.c                                  |   3 +
>  target/i386/kvm.c                                  |  11 +-
>  target/i386/kvm_i386.h                             |   1 +
>  tests/acceptance/avocado_qemu/__init__.py          |  13 +-
>  tests/acceptance/boot_linux.py                     |  49 ++++----
>  tests/acceptance/boot_linux_console.py             |  55 ++++++---
>  tests/qemu-iotests/028                             |  19 +++
>  tests/qemu-iotests/028.out                         |  11 ++
>  tests/qemu-iotests/143                             |   4 +
>  tests/qemu-iotests/143.out                         |   2 +
>  tests/qemu-iotests/283                             |   6 +-
>  tests/qemu-iotests/283.out                         |   2 +-
>  tests/qtest/libqos/pci-pc.c                        |   2 +-
>  tests/qtest/tpm-util.c                             |   6 +-
>  tests/qtest/usb-hcd-ehci-test.c                    |   2 +-
>  tools/virtiofsd/fuse_lowlevel.h                    |   1 +
>  tools/virtiofsd/helper.c                           |  47 ++++++++
>  tools/virtiofsd/passthrough_ll.c                   |  22 ++--
>  tools/virtiofsd/seccomp.c                          |   1 +
>  util/aio-posix.c                                   |  13 ++
>  util/aio-win32.c                                   |   4 +
>  util/async.c                                       |   1 +
>  util/fdmon-io_uring.c                              |  13 +-
>  util/oslib-posix.c                                 |  35 ++++++
>  util/oslib-win32.c                                 |  13 ++
>  97 files changed, 1045 insertions(+), 377 deletions(-)
> =

>=20

