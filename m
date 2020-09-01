Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC406C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:41:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7DAA21534
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:41:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7DAA21534
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD7TN-00048A-Ln
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 10:41:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56950)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD74p-0001Ii-4U; Tue, 01 Sep 2020 10:15:59 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:55351)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD74m-0004hu-Ri; Tue, 01 Sep 2020 10:15:58 -0400
Received: from [192.168.100.1] ([82.252.135.186]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MfZ9C-1kodgA0xdw-00g1k0; Tue, 01 Sep 2020 16:15:54 +0200
Subject: Re: [PULL 00/44] Trivial branch for 5.2 patches
To: qemu-devel@nongnu.org
References: <20200901140803.888852-1-laurent@vivier.eu>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <c63cde35-2959-f119-5c22-fccdf23a23d7@vivier.eu>
Date: Tue, 1 Sep 2020 16:15:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200901140803.888852-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:iZWP6PGhc5e89YDxMHmTCaCukAqApNyX2Oc7R+ENc3a39L+Pmo2
 pxQji6nOari2gglAjkXD0qvJwYxFWe5wUijWMwI4vxp7twhhR8UMYMIvArJmuWzu0A8HB9y
 8UoRhSN+VVygzBitODByR/+ske8vLctPA6LQH+m18w+/1ynhpCxpu3TCSp3RE5NOnFLJ37W
 EIoTTyxMTqGo77qEQ2z4A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:thn7lQq/EQY=:biWpCjag0X/3V1G5GOhq0J
 U3qK8L9k1KFPEAmNDLoG8R/ujxnutZ8aVUk3fkO2Fh67mFIYMoIJk3HYkPGvrRhKyve0o2ybx
 a7PYLNZOAQlBLbSP/0/xWm1xg6tCO+LPGVBy0ljKBZpgc9v74a9GsTM6M8+xLodv2465pu+i0
 ftqXYT2QZI1JSXp2h+jyMjxTL1fPWhfJn0Yg5NRezp+Wnk4LfOZeOvxL79z1lAUMBtQ2UtJEU
 0UDg9RM9aYh5nKzoDS0f10I23WbBQK1AUZsgxlSywgZOOufEG2mq7YvbFUeK1nUj6al1Nsy67
 HhvVCRnA1C1maCGGOQ34am1D/rqnjO9lVHDQ/PY1LHGWPMwUNXtSxtvluewZav1D3qf89AMxo
 O02/+D4FL+9voprSgFBZy5OFcDao3b2rDKJrMaAIABPcqb7OzDBg5uciMrX/I6rMI9FMZoQ1t
 +A/Xiw8qcch0mQ9OH0XdQMfh9Uxp6Ksm4VJwqavNBSyn7wqRupBRV1wcX0XPnPihX4JDbE/OY
 qJKO7bsYnnCtlzSmGJkCMfJHH+MbuieXp9k5Xau1o4g9YPjJ4fUfyBBuYT44pWRNIbewlpV3E
 WdiaUYDhE2F49LrbgqrebeJ/O08aigBazPtGvBHG0dJqWXpwkcL6/3t6A/GFRMjWWeL5NRVpc
 WrsBSXGnSpieg142ppif7qwKISsx1xceRzbMVQlepy2z2xjeoBBgebHekzCfnOGxFq4LfoBAE
 sh5AdjRVFD9zsOvSMlR4IDDEDzrzhWiI/IHUcRDnhYNUPK7YSrsAX3FFEG/tCemBeA1jQzoT5
 o57jCAhEF3HTrJppRhn3/YaQZ2xcNaPM9lRu0pT07g1VIsGfO2OiYIBn6uj1x1AGz9wwlpkkR
 pYdSQBEOxyDUs7sYUozSSXdVtSO+uXhuzGH0UNqKa5549HE+B7qmGR3119HPaJzGGmt3Au+lb
 /4+A5eGGs0rTmho/2TSKycYEHTic4kzpG3/2XACWX+uw4VKYdXRA7s09jbtrkzaiXwpaxViUl
 SNNKX4zVzd4j9tAXTVPjdLk=
Received-SPF: none client-ip=217.72.192.74; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 10:02:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.13,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-trivial@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 01/09/2020 à 16:07, Laurent Vivier a écrit :
> The following changes since commit 39335fab59e11cfda9b7cf63929825db2dd3a3e0:
> 
>   Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-5.2-pull-=
> request' into staging (2020-08-28 22:30:11 +0100)
> 
> are available in the Git repository at:
> 
>   git://github.com/vivier/qemu.git tags/trivial-branch-for-5.2-pull-request
> 
> for you to fetch changes up to 1eef4ba6be30f8b95c8cda1bcb50a176d680a34d:
> 
>   docs/system: Fix grammar in documentation (2020-09-01 12:09:30 +0200)
> 
> ----------------------------------------------------------------
> Pull request trivial patches 20200901
> 
> ----------------------------------------------------------------
> 
> Chen Qun (10):
>   hw/arm/virt-acpi-build:Remove dead assignment in build_madt()
>   hw/arm/omap1:Remove redundant statement in omap_clkdsp_read()
>   target/arm/translate-a64:Remove dead assignment in
>     handle_scalar_simd_shli()
>   target/arm/translate-a64:Remove redundant statement in
>     disas_simd_two_reg_misc_fp16()
>   hw/virtio/vhost-user:Remove dead assignment in scrub_shadow_regions()
>   hw/net/virtio-net:Remove redundant statement in
>     virtio_net_rsc_tcp_ctrl_check()
>   vfio/platform: Remove dead assignment in vfio_intp_interrupt()
>   usb/bus: Remove dead assignment in usb_get_fw_dev_path()
>   hw/intc: fix default registers value in exynos4210_combiner_read()
>   hw/display/vga:Remove redundant statement in vga_draw_graphic()
> 
> Greg Kurz (1):
>   mailmap: Add entry for Greg Kurz
> 
> Han Han (1):
>   docs: Fix broken links
> 
> Kenta Ishiguro (1):
>   hw/i386/kvm/ioapic.c: fix typo in error message
> 
> Liao Pingfang (8):
>   target/arm/kvm: Remove superfluous break
>   target/ppc: Remove superfluous breaks
>   scsi: Remove superfluous breaks
>   vnc: Remove the superfluous break
>   block/vmdk: Remove superfluous breaks
>   hw: Remove superfluous breaks
>   target/sh4: Remove superfluous breaks
>   target/cris: Remove superfluous breaks
> 
> Mike Gelfand (1):
>   linux-user: Add strace support for printing OFD fcntl operations
> 
> Philippe Mathieu-Daud=C3=A9 (17):
>   hw/register: Document register_init_block @memory_size
>   hw/isa/isa-superio: Fix IDE controller realization
>   stubs/cmos: Use correct include
>   hw/core/sysbus: Fix a typo
>   hw/core/sysbus: Assert memory region index is in range
>   Revert "mailmap: Update philmd email address"
>   .mailmap: Update Paul Burton email address
>   hw/i2c: Fix typo in description
>   util/qemu-timer: Fix typo in description
>   util/vfio-helpers: Fix typo in description
>   hw/ide/core: Trivial typo fix
>   hw/ide/ahci: Replace magic '512' value by BDRV_SECTOR_SIZE
>   hw/ide/atapi: Replace magic '512' value by BDRV_SECTOR_SIZE
>   hw/ide/pci: Replace magic '512' value by BDRV_SECTOR_SIZE
>   hw/scsi/scsi-disk: Replace magic '512' value by BDRV_SECTOR_SIZE
>   hw/net/xilinx_axienet: Remove unused code
>   util/vfio-helpers: Unify trace-events size format
> 
> Stefan Weil (2):
>   main-loop: Fix comment
>   docs/system: Fix grammar in documentation
> 
> Thomas Huth (2):
>   hw/net/can: Add missing fallthrough statements
>   docs/system/target-avr: Improve the AVR docs and add to MAINTAINERS
> 
> Tianjia Zhang (1):
>   qemu-options.hx: Fix typo for netdev documentation
> 
>  .mailmap                        |  9 ++++---
>  MAINTAINERS                     |  1 +
>  block/vmdk.c                    |  3 ---
>  docs/amd-memory-encryption.txt  |  4 +--
>  docs/pvrdma.txt                 |  2 +-
>  docs/system/build-platforms.rst |  6 ++---
>  docs/system/target-avr.rst      | 47 ++++++++++++++++++++-------------
>  hw/arm/omap1.c                  |  1 -
>  hw/arm/virt-acpi-build.c        |  3 +--
>  hw/block/pflash_cfi01.c         |  1 -
>  hw/core/sysbus.c                |  3 ++-
>  hw/display/cirrus_vga.c         |  1 -
>  hw/display/qxl-logger.c         |  2 --
>  hw/display/vga.c                |  1 -
>  hw/gpio/max7310.c               |  3 ---
>  hw/i386/intel_iommu.c           |  1 -
>  hw/i386/kvm/ioapic.c            |  2 +-
>  hw/ide/ahci.c                   |  5 ++--
>  hw/ide/atapi.c                  |  8 +++---
>  hw/ide/core.c                   |  2 +-
>  hw/ide/pci.c                    |  2 +-
>  hw/input/pxa2xx_keypad.c        | 10 -------
>  hw/intc/armv7m_nvic.c           |  1 -
>  hw/intc/exynos4210_combiner.c   |  1 -
>  hw/isa/isa-superio.c            |  2 +-
>  hw/net/can/can_sja1000.c        |  2 ++
>  hw/net/lan9118.c                |  2 --
>  hw/net/virtio-net.c             |  1 -
>  hw/net/xilinx_axienet.c         | 23 ----------------
>  hw/scsi/scsi-disk.c             | 44 +++++++++++++++---------------
>  hw/usb/bus.c                    |  4 +--
>  hw/usb/ccid-card-emulated.c     |  1 -
>  hw/vfio/platform.c              |  2 +-
>  hw/virtio/vhost-user.c          |  2 +-
>  include/hw/i2c/i2c.h            |  2 +-
>  include/hw/register.h           |  1 +
>  include/qemu/main-loop.h        |  2 +-
>  linux-user/strace.c             | 12 +++++++++
>  qemu-options.hx                 |  2 +-
>  scsi/utils.c                    |  4 ---
>  stubs/cmos.c                    |  2 +-
>  target/arm/kvm64.c              |  1 -
>  target/arm/translate-a64.c      |  7 ++---
>  target/cris/translate.c         |  7 +++--
>  target/cris/translate_v10.c.inc |  2 --
>  target/ppc/misc_helper.c        |  5 ----
>  target/sh4/translate.c          |  3 ---
>  ui/vnc-enc-tight.c              |  1 -
>  util/qemu-timer.c               |  2 +-
>  util/trace-events               |  6 ++---
>  util/vfio-helpers.c             |  4 +--
>  51 files changed, 112 insertions(+), 153 deletions(-)
> 

Please ignore this PR, it failed after the first patch.

The second attempt is the one to take (same name, no versioning but
completed).

Thanks,
Laurent

