Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD1EC18E5A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 21:09:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BDB9215A4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 21:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bd4J0TXY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BDB9215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBm7p-0005Cj-QT
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 17:09:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39637)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1jBm18-0006pv-Gr
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 17:02:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1jBm14-00059E-5q
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 17:02:22 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:46514)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1jBm0u-0004rQ-P1; Tue, 10 Mar 2020 17:02:08 -0400
Received: by mail-io1-xd43.google.com with SMTP id v3so8226144iom.13;
 Tue, 10 Mar 2020 14:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Lw5NyFFEwKaalIwzLCnmO/ZnUE9vCDsBy4/YsDSHZMI=;
 b=bd4J0TXY7eRGbpk2OCwWk4d52wwk1ytZyqBfLer37aTEswtg7oeR2ZxtX7sTi1rAsL
 yuU96Km9zAgIy1deC35jnaARfapxPswpR+lOYNA3xmMa20Nv3xH4Xi0wFoE8OMM0fVaK
 OVi53VQ9/SAiDLAwM9q7y1xLcdn+BkV76lV4GK1pMa8JIY1IwHHxD6D6WHXFjpBuXsis
 bNCjcMwAe42g+LMJxBoo63MgeIcCLyLzr7lvbojxjkmdMMnUgdAdOcE5K3LxN1Bt61ZV
 uOxJHu5yvBRMkl1KYItVumRd0adICTadRt2s/3PBV2OJgr0If/tS9l8zCVwcOmBa9o1L
 CDzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Lw5NyFFEwKaalIwzLCnmO/ZnUE9vCDsBy4/YsDSHZMI=;
 b=WZHQkOCSZBjx2aChCqkJOp1MmKZCUUudwef84wUwymFn7FnDiyXIh5j3DdzwkTUJXl
 2odsL9KUaVqmrnOiwdaW4nYMD1v9VufSuHMwn91oGAbOUpUDTpWUhkkNN+Xd705roqCv
 YojxIRxmTCLOfHLoHJjvVfw4ss+tNCinCgdDke0I1qOGKnuYa9Et0cK68t4t7btsr+OI
 D6/dEbeaHF4wbf7QB0e2kluHzVDx9oTAC6icg+sSh5LYal5LADSWJ/XjtUNW9TBIPzhK
 19H9A1z8vIZjhHsK9o+IvI98IGkGsNn7DQPFyfDgwxHp+EQFUXLVygqvJZCJp7KNpPRo
 3q6Q==
X-Gm-Message-State: ANhLgQ2KYoGDfCtGTC+nz/A8UJacbyW02BPKqU1igLj8cHtTsRPTqjFY
 M6nkcNeSbALCsa0Cg1CkHLlkUDEPIuSKjUOJq98=
X-Google-Smtp-Source: ADFU+vtd482vbrqA/7FCFrWsBPH2J+op+twrOluEvHxZ4Vq9tGVw6Mzdz+554k2L05Jqm/1tm8/qv9HdbeVzMPYJkgE=
X-Received: by 2002:a6b:5406:: with SMTP id i6mr13608700iob.188.1583874128001; 
 Tue, 10 Mar 2020 14:02:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200309215818.2021-1-peter.maydell@linaro.org>
 <20200309215818.2021-6-peter.maydell@linaro.org>
In-Reply-To: <20200309215818.2021-6-peter.maydell@linaro.org>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Tue, 10 Mar 2020 22:01:56 +0100
Message-ID: <CAPan3Wp+yp6Z8GYcs9THTguOBfADmPvZ8Vix+R6Qn5Hi5uVpjg@mail.gmail.com>
Subject: Re: [PATCH 5/5] docs: Be consistent about capitalization of 'Arm'
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000c4bdf705a0866e9e"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d43
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000c4bdf705a0866e9e
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Niek Linnenbank <nieklinnenbank@gmail.com>

On Mon, Mar 9, 2020 at 10:58 PM Peter Maydell <peter.maydell@linaro.org>
wrote:

> The company 'Arm' went through a rebranding some years back
> involving a recapitalization from 'ARM' to 'Arm'. As a result
> our documentation is a bit inconsistent between the two forms.
> It's not worth trying to update everywhere in QEMU, but it's
> easy enough to make docs/ consistent.
>
> Note that "ARMv8" and similar architecture names, and
> older CPU names like "ARM926" still retain all-caps.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I don't feel very strongly about this change, but it
> looked a bit odd where earlier rearrangements in this
> series meant that some documents had a mix of both styles,
> so I thought I might as well fix all of docs/.
> ---
>  docs/can.txt                     | 2 +-
>  docs/devel/atomics.txt           | 2 +-
>  docs/devel/multi-thread-tcg.txt  | 8 ++++----
>  docs/replay.txt                  | 2 +-
>  docs/specs/fw_cfg.txt            | 2 +-
>  docs/devel/kconfig.rst           | 2 +-
>  docs/devel/loads-stores.rst      | 2 +-
>  docs/devel/tcg.rst               | 2 +-
>  docs/specs/tpm.rst               | 6 +++---
>  docs/system/arm/cpu-features.rst | 4 ++--
>  docs/system/arm/integratorcp.rst | 2 +-
>  docs/system/arm/musicpal.rst     | 2 +-
>  docs/system/arm/nseries.rst      | 2 +-
>  docs/system/arm/palm.rst         | 2 +-
>  docs/system/arm/realview.rst     | 4 ++--
>  docs/system/arm/sx1.rst          | 2 +-
>  docs/system/arm/versatile.rst    | 2 +-
>  docs/system/arm/xscale.rst       | 2 +-
>  docs/user/main.rst               | 8 ++++----
>  19 files changed, 29 insertions(+), 29 deletions(-)
>
> diff --git a/docs/can.txt b/docs/can.txt
> index 9fa6ed51c82..11ed8f2d68b 100644
> --- a/docs/can.txt
> +++ b/docs/can.txt
> @@ -13,7 +13,7 @@ controller is implemented.
>
>  The PCI addon card hardware has been selected as the first CAN
>  interface to implement because such device can be easily connected
> -to systems with different CPU architectures (x86, PowerPC, ARM, etc.).
> +to systems with different CPU architectures (x86, PowerPC, Arm, etc.).
>
>  The project has been initially started in frame of RTEMS GSoC 2013
>  slot by Jin Yang under our mentoring  The initial idea was to provide
> generic
> diff --git a/docs/devel/atomics.txt b/docs/devel/atomics.txt
> index a4db3a4aaad..67bdf826280 100644
> --- a/docs/devel/atomics.txt
> +++ b/docs/devel/atomics.txt
> @@ -87,7 +87,7 @@ Sequentially consistent loads and stores can be done
> using:
>      atomic_xchg(ptr, val) for stores
>
>  However, they are quite expensive on some platforms, notably POWER and
> -ARM.  Therefore, qemu/atomic.h provides two primitives with slightly
> +Arm.  Therefore, qemu/atomic.h provides two primitives with slightly
>  weaker constraints:
>
>      typeof(*ptr) atomic_mb_read(ptr)
> diff --git a/docs/devel/multi-thread-tcg.txt
> b/docs/devel/multi-thread-tcg.txt
> index 782bebc28b4..3c85ac0eab9 100644
> --- a/docs/devel/multi-thread-tcg.txt
> +++ b/docs/devel/multi-thread-tcg.txt
> @@ -227,7 +227,7 @@ minimise contention.
>  (Current solution)
>
>  MMIO access automatically serialises hardware emulation by way of the
> -BQL. Currently ARM targets serialise all ARM_CP_IO register accesses
> +BQL. Currently Arm targets serialise all ARM_CP_IO register accesses
>  and also defer the reset/startup of vCPUs to the vCPU context by way
>  of async_run_on_cpu().
>
> @@ -268,7 +268,7 @@ ordered backends this could become a NOP.
>  Aside from explicit standalone memory barrier instructions there are
>  also implicit memory ordering semantics which comes with each guest
>  memory access instruction. For example all x86 load/stores come with
> -fairly strong guarantees of sequential consistency where as ARM has
> +fairly strong guarantees of sequential consistency whereas Arm has
>  special variants of load/store instructions that imply acquire/release
>  semantics.
>
> @@ -317,7 +317,7 @@ x86 cmpxchg instruction.
>
>  The second type offer a pair of load/store instructions which offer a
>  guarantee that a region of memory has not been touched between the
> -load and store instructions. An example of this is ARM's ldrex/strex
> +load and store instructions. An example of this is Arm's ldrex/strex
>  pair where the strex instruction will return a flag indicating a
>  successful store only if no other CPU has accessed the memory region
>  since the ldrex.
> @@ -339,7 +339,7 @@ CURRENT OPEN QUESTIONS:
>
>  The TCG provides a number of atomic helpers (tcg_gen_atomic_*) which
>  can be used directly or combined to emulate other instructions like
> -ARM's ldrex/strex instructions. While they are susceptible to the ABA
> +Arm's ldrex/strex instructions. While they are susceptible to the ABA
>  problem so far common guests have not implemented patterns where
>  this may be a problem - typically presenting a locking ABI which
>  assumes cmpxchg like semantics.
> diff --git a/docs/replay.txt b/docs/replay.txt
> index f4619a62a3d..70c27edb362 100644
> --- a/docs/replay.txt
> +++ b/docs/replay.txt
> @@ -19,7 +19,7 @@ Deterministic replay has the following features:
>     the memory, state of the hardware devices, clocks, and screen of the
> VM.
>   * Writes execution log into the file for later replaying for multiple
> times
>     on different machines.
> - * Supports i386, x86_64, and ARM hardware platforms.
> + * Supports i386, x86_64, and Arm hardware platforms.
>   * Performs deterministic replay of all operations with keyboard and mouse
>     input devices.
>
> diff --git a/docs/specs/fw_cfg.txt b/docs/specs/fw_cfg.txt
> index 08c00bdf44a..8f1ebc66fa4 100644
> --- a/docs/specs/fw_cfg.txt
> +++ b/docs/specs/fw_cfg.txt
> @@ -82,7 +82,7 @@ Selector Register IOport: 0x510
>  Data Register IOport:     0x511
>  DMA Address IOport:       0x514
>
> -=== ARM Register Locations ===
> +=== Arm Register Locations ===
>
>  Selector Register address: Base + 8 (2 bytes)
>  Data Register address:     Base + 0 (8 bytes)
> diff --git a/docs/devel/kconfig.rst b/docs/devel/kconfig.rst
> index b7bca447046..e5df72b3422 100644
> --- a/docs/devel/kconfig.rst
> +++ b/docs/devel/kconfig.rst
> @@ -8,7 +8,7 @@ time different targets can share large amounts of code.
> For example,
>  a POWER and an x86 board can run the same code to emulate a PCI network
>  card, even though the boards use different PCI host bridges, and they
>  can run the same code to emulate a SCSI disk while using different
> -SCSI adapters.  ARM, s390 and x86 boards can all present a virtio-blk
> +SCSI adapters.  Arm, s390 and x86 boards can all present a virtio-blk
>  disk to their guests, but with three different virtio guest interfaces.
>
>  Each QEMU target enables a subset of the boards, devices and buses that
> diff --git a/docs/devel/loads-stores.rst b/docs/devel/loads-stores.rst
> index 03aa9e7ff80..0d99eb24c1b 100644
> --- a/docs/devel/loads-stores.rst
> +++ b/docs/devel/loads-stores.rst
> @@ -302,7 +302,7 @@ way QEMU defines the view of memory that a device or
> CPU has.
>  or bus fabric.)
>
>  Each CPU has an AddressSpace. Some kinds of CPU have more than
> -one AddressSpace (for instance ARM guest CPUs have an AddressSpace
> +one AddressSpace (for instance Arm guest CPUs have an AddressSpace
>  for the Secure world and one for NonSecure if they implement TrustZone).
>  Devices which can do DMA-type operations should generally have an
>  AddressSpace. There is also a "system address space" which typically
> diff --git a/docs/devel/tcg.rst b/docs/devel/tcg.rst
> index 4956a30a4e6..4ebde44b9d7 100644
> --- a/docs/devel/tcg.rst
> +++ b/docs/devel/tcg.rst
> @@ -83,7 +83,7 @@ memory until the end of the translation block.  This is
> done for internal
>  emulation state that is rarely accessed directly by the program and/or
> changes
>  very often throughout the execution of a translation block---this includes
>  condition codes on x86, delay slots on SPARC, conditional execution on
> -ARM, and so on.  This state is stored for each target instruction, and
> +Arm, and so on.  This state is stored for each target instruction, and
>  looked up on exceptions.
>
>  MMU emulation
> diff --git a/docs/specs/tpm.rst b/docs/specs/tpm.rst
> index da9eb39ca97..5e61238bc5f 100644
> --- a/docs/specs/tpm.rst
> +++ b/docs/specs/tpm.rst
> @@ -25,7 +25,7 @@ QEMU files related to TPM TIS interface:
>
>  Both an ISA device and a sysbus device are available. The former is
>  used with pc/q35 machine while the latter can be instantiated in the
> -ARM virt machine.
> +Arm virt machine.
>
>  CRB interface
>  -------------
> @@ -331,7 +331,7 @@ In case a pSeries machine is emulated, use the
> following command line:
>      -device
> virtio-blk-pci,scsi=off,bus=pci.0,addr=0x3,drive=drive-virtio-disk0,id=virtio-disk0
> \
>      -drive file=test.img,format=raw,if=none,id=drive-virtio-disk0
>
> -In case an ARM virt machine is emulated, use the following command line:
> +In case an Arm virt machine is emulated, use the following command line:
>
>  .. code-block:: console
>
> @@ -346,7 +346,7 @@ In case an ARM virt machine is emulated, use the
> following command line:
>      -drive if=pflash,format=raw,file=flash0.img,readonly \
>      -drive if=pflash,format=raw,file=flash1.img
>
> -  On ARM, ACPI boot with TPM is not yet supported.
> +  On Arm, ACPI boot with TPM is not yet supported.
>
>  In case SeaBIOS is used as firmware, it should show the TPM menu item
>  after entering the menu with 'ESC'.
> diff --git a/docs/system/arm/cpu-features.rst
> b/docs/system/arm/cpu-features.rst
> index 7495b7b672b..2d5c06cd016 100644
> --- a/docs/system/arm/cpu-features.rst
> +++ b/docs/system/arm/cpu-features.rst
> @@ -5,9 +5,9 @@ CPU features are optional features that a CPU of
> supporting type may
>  choose to implement or not.  In QEMU, optional CPU features have
>  corresponding boolean CPU proprieties that, when enabled, indicate
>  that the feature is implemented, and, conversely, when disabled,
> -indicate that it is not implemented. An example of an ARM CPU feature
> +indicate that it is not implemented. An example of an Arm CPU feature
>  is the Performance Monitoring Unit (PMU).  CPU types such as the
> -Cortex-A15 and the Cortex-A57, which respectively implement ARM
> +Cortex-A15 and the Cortex-A57, which respectively implement Arm
>  architecture reference manuals ARMv7-A and ARMv8-A, may both optionally
>  implement PMUs.  For example, if a user wants to use a Cortex-A15 without
>  a PMU, then the `-cpu` parameter should contain `pmu=off` on the QEMU
> diff --git a/docs/system/arm/integratorcp.rst
> b/docs/system/arm/integratorcp.rst
> index 3232b43a08b..e6f050f602b 100644
> --- a/docs/system/arm/integratorcp.rst
> +++ b/docs/system/arm/integratorcp.rst
> @@ -1,7 +1,7 @@
>  Integrator/CP (``integratorcp``)
>  ================================
>
> -The ARM Integrator/CP board is emulated with the following devices:
> +The Arm Integrator/CP board is emulated with the following devices:
>
>  -  ARM926E, ARM1026E, ARM946E, ARM1136 or Cortex-A8 CPU
>
> diff --git a/docs/system/arm/musicpal.rst b/docs/system/arm/musicpal.rst
> index 35c22212486..9de380edf81 100644
> --- a/docs/system/arm/musicpal.rst
> +++ b/docs/system/arm/musicpal.rst
> @@ -4,7 +4,7 @@ Freecom MusicPal (``musicpal``)
>  The Freecom MusicPal internet radio emulation includes the following
>  elements:
>
> --  Marvell MV88W8618 ARM core.
> +-  Marvell MV88W8618 Arm core.
>
>  -  32 MB RAM, 256 KB SRAM, 8 MB flash.
>
> diff --git a/docs/system/arm/nseries.rst b/docs/system/arm/nseries.rst
> index b000b6d13bb..cd9edf5d88b 100644
> --- a/docs/system/arm/nseries.rst
> +++ b/docs/system/arm/nseries.rst
> @@ -4,7 +4,7 @@ Nokia N800 and N810 tablets (``n800``, ``n810``)
>  Nokia N800 and N810 internet tablets (known also as RX-34 and RX-44 /
>  48) emulation supports the following elements:
>
> --  Texas Instruments OMAP2420 System-on-chip (ARM 1136 core)
> +-  Texas Instruments OMAP2420 System-on-chip (ARM1136 core)
>
>  -  RAM and non-volatile OneNAND Flash memories
>
> diff --git a/docs/system/arm/palm.rst b/docs/system/arm/palm.rst
> index 0eabf63e0e7..47ff9b36d46 100644
> --- a/docs/system/arm/palm.rst
> +++ b/docs/system/arm/palm.rst
> @@ -4,7 +4,7 @@ Palm Tungsten|E PDA (``cheetah``)
>  The Palm Tungsten|E PDA (codename \"Cheetah\") emulation includes the
>  following elements:
>
> --  Texas Instruments OMAP310 System-on-chip (ARM 925T core)
> +-  Texas Instruments OMAP310 System-on-chip (ARM925T core)
>
>  -  ROM and RAM memories (ROM firmware image can be loaded with
>     -option-rom)
> diff --git a/docs/system/arm/realview.rst b/docs/system/arm/realview.rst
> index 8e08eb5da16..65f5be346b1 100644
> --- a/docs/system/arm/realview.rst
> +++ b/docs/system/arm/realview.rst
> @@ -1,7 +1,7 @@
>  Arm Realview boards (``realview-eb``, ``realview-eb-mpcore``,
> ``realview-pb-a8``, ``realview-pbx-a9``)
>
>  ======================================================================================================
>
> -Several variants of the ARM RealView baseboard are emulated, including
> +Several variants of the Arm RealView baseboard are emulated, including
>  the EB, PB-A8 and PBX-A9. Due to interactions with the bootloader, only
>  certain Linux kernel configurations work out of the box on these boards.
>
> @@ -14,7 +14,7 @@ The following devices are emulated:
>
>  -  ARM926E, ARM1136, ARM11MPCore, Cortex-A8 or Cortex-A9 MPCore CPU
>
> --  ARM AMBA Generic/Distributed Interrupt Controller
> +-  Arm AMBA Generic/Distributed Interrupt Controller
>
>  -  Four PL011 UARTs
>
> diff --git a/docs/system/arm/sx1.rst b/docs/system/arm/sx1.rst
> index 321993bc098..8bce30d4b25 100644
> --- a/docs/system/arm/sx1.rst
> +++ b/docs/system/arm/sx1.rst
> @@ -4,7 +4,7 @@ Siemens SX1 (``sx1``, ``sx1-v1``)
>  The Siemens SX1 models v1 and v2 (default) basic emulation. The
>  emulation includes the following elements:
>
> --  Texas Instruments OMAP310 System-on-chip (ARM 925T core)
> +-  Texas Instruments OMAP310 System-on-chip (ARM925T core)
>
>  -  ROM and RAM memories (ROM firmware image can be loaded with
>     -pflash) V1 1 Flash of 16MB and 1 Flash of 8MB V2 1 Flash of 32MB
> diff --git a/docs/system/arm/versatile.rst b/docs/system/arm/versatile.rst
> index 48b6ca0a020..51221c30a48 100644
> --- a/docs/system/arm/versatile.rst
> +++ b/docs/system/arm/versatile.rst
> @@ -1,7 +1,7 @@
>  Arm Versatile boards (``versatileab``, ``versatilepb``)
>  =======================================================
>
> -The ARM Versatile baseboard is emulated with the following devices:
> +The Arm Versatile baseboard is emulated with the following devices:
>
>  -  ARM926E, ARM1136 or Cortex-A8 CPU
>
> diff --git a/docs/system/arm/xscale.rst b/docs/system/arm/xscale.rst
> index 19da2eff352..89ec93e904e 100644
> --- a/docs/system/arm/xscale.rst
> +++ b/docs/system/arm/xscale.rst
> @@ -4,7 +4,7 @@ Sharp XScale-based PDA models (``akita``, ``borzoi``,
> ``spitz``, ``terrier``)
>  The XScale-based clamshell PDA models (\"Spitz\", \"Akita\", \"Borzoi\"
>  and \"Terrier\") emulation includes the following peripherals:
>
> --  Intel PXA270 System-on-chip (ARM V5TE core)
> +-  Intel PXA270 System-on-chip (ARMv5TE core)
>
>  -  NAND Flash memory
>
> diff --git a/docs/user/main.rst b/docs/user/main.rst
> index ca69f7727d5..bd99b0fdbe9 100644
> --- a/docs/user/main.rst
> +++ b/docs/user/main.rst
> @@ -35,7 +35,7 @@ QEMU user space emulation has the following notable
> features:
>     On Linux, QEMU can emulate the ``clone`` syscall and create a real
>     host thread (with a separate virtual CPU) for each emulated thread.
>     Note that not all targets currently emulate atomic operations
> -   correctly. x86 and ARM use a global lock in order to preserve their
> +   correctly. x86 and Arm use a global lock in order to preserve their
>     semantics.
>
>  QEMU was conceived so that ultimately it can emulate itself. Although it
> @@ -173,11 +173,11 @@ Other binaries
>  user mode (Alpha)
>  ``qemu-alpha`` TODO.
>
> -user mode (ARM)
> +user mode (Arm)
>  ``qemu-armeb`` TODO.
>
> -user mode (ARM)
> -``qemu-arm`` is also capable of running ARM \"Angel\" semihosted ELF
> +user mode (Arm)
> +``qemu-arm`` is also capable of running Arm \"Angel\" semihosted ELF
>  binaries (as implemented by the arm-elf and arm-eabi Newlib/GDB
>  configurations), and arm-uclinux bFLT format binaries.
>
> --
> 2.20.1
>
>

-- 
Niek Linnenbank

--000000000000c4bdf705a0866e9e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Reviewed-by: Niek Linnenbank &lt;<a href=3D"mailto:ni=
eklinnenbank@gmail.com">nieklinnenbank@gmail.com</a>&gt;<br></div><br><div =
class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Mar 9, =
2020 at 10:58 PM Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.o=
rg">peter.maydell@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">The company &#39;Arm&#39; went through a rebran=
ding some years back<br>
involving a recapitalization from &#39;ARM&#39; to &#39;Arm&#39;. As a resu=
lt<br>
our documentation is a bit inconsistent between the two forms.<br>
It&#39;s not worth trying to update everywhere in QEMU, but it&#39;s<br>
easy enough to make docs/ consistent.<br>
<br>
Note that &quot;ARMv8&quot; and similar architecture names, and<br>
older CPU names like &quot;ARM926&quot; still retain all-caps.<br>
<br>
Signed-off-by: Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org=
" target=3D"_blank">peter.maydell@linaro.org</a>&gt;<br>
---<br>
I don&#39;t feel very strongly about this change, but it<br>
looked a bit odd where earlier rearrangements in this<br>
series meant that some documents had a mix of both styles,<br>
so I thought I might as well fix all of docs/.<br>
---<br>
=C2=A0docs/can.txt=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0| 2 +-<br>
=C2=A0docs/devel/atomics.txt=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 2 +-=
<br>
=C2=A0docs/devel/multi-thread-tcg.txt=C2=A0 | 8 ++++----<br>
=C2=A0docs/replay.txt=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | 2 +-<br>
=C2=A0docs/specs/fw_cfg.txt=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2 +-=
<br>
=C2=A0docs/devel/kconfig.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 2 +-=
<br>
=C2=A0docs/devel/loads-stores.rst=C2=A0 =C2=A0 =C2=A0 | 2 +-<br>
=C2=A0docs/devel/tcg.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| 2 +-<br>
=C2=A0docs/specs/tpm.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| 6 +++---<br>
=C2=A0docs/system/arm/cpu-features.rst | 4 ++--<br>
=C2=A0docs/system/arm/integratorcp.rst | 2 +-<br>
=C2=A0docs/system/arm/musicpal.rst=C2=A0 =C2=A0 =C2=A0| 2 +-<br>
=C2=A0docs/system/arm/nseries.rst=C2=A0 =C2=A0 =C2=A0 | 2 +-<br>
=C2=A0docs/system/arm/palm.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 2 +-<br>
=C2=A0docs/system/arm/realview.rst=C2=A0 =C2=A0 =C2=A0| 4 ++--<br>
=C2=A0docs/system/arm/sx1.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2 +-<br>
=C2=A0docs/system/arm/versatile.rst=C2=A0 =C2=A0 | 2 +-<br>
=C2=A0docs/system/arm/xscale.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0| 2 +-<br>
=C2=A0docs/user/main.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| 8 ++++----<br>
=C2=A019 files changed, 29 insertions(+), 29 deletions(-)<br>
<br>
diff --git a/docs/can.txt b/docs/can.txt<br>
index 9fa6ed51c82..11ed8f2d68b 100644<br>
--- a/docs/can.txt<br>
+++ b/docs/can.txt<br>
@@ -13,7 +13,7 @@ controller is implemented.<br>
<br>
=C2=A0The PCI addon card hardware has been selected as the first CAN<br>
=C2=A0interface to implement because such device can be easily connected<br=
>
-to systems with different CPU architectures (x86, PowerPC, ARM, etc.).<br>
+to systems with different CPU architectures (x86, PowerPC, Arm, etc.).<br>
<br>
=C2=A0The project has been initially started in frame of RTEMS GSoC 2013<br=
>
=C2=A0slot by Jin Yang under our mentoring=C2=A0 The initial idea was to pr=
ovide generic<br>
diff --git a/docs/devel/atomics.txt b/docs/devel/atomics.txt<br>
index a4db3a4aaad..67bdf826280 100644<br>
--- a/docs/devel/atomics.txt<br>
+++ b/docs/devel/atomics.txt<br>
@@ -87,7 +87,7 @@ Sequentially consistent loads and stores can be done usin=
g:<br>
=C2=A0 =C2=A0 =C2=A0atomic_xchg(ptr, val) for stores<br>
<br>
=C2=A0However, they are quite expensive on some platforms, notably POWER an=
d<br>
-ARM.=C2=A0 Therefore, qemu/atomic.h provides two primitives with slightly<=
br>
+Arm.=C2=A0 Therefore, qemu/atomic.h provides two primitives with slightly<=
br>
=C2=A0weaker constraints:<br>
<br>
=C2=A0 =C2=A0 =C2=A0typeof(*ptr) atomic_mb_read(ptr)<br>
diff --git a/docs/devel/multi-thread-tcg.txt b/docs/devel/multi-thread-tcg.=
txt<br>
index 782bebc28b4..3c85ac0eab9 100644<br>
--- a/docs/devel/multi-thread-tcg.txt<br>
+++ b/docs/devel/multi-thread-tcg.txt<br>
@@ -227,7 +227,7 @@ minimise contention.<br>
=C2=A0(Current solution)<br>
<br>
=C2=A0MMIO access automatically serialises hardware emulation by way of the=
<br>
-BQL. Currently ARM targets serialise all ARM_CP_IO register accesses<br>
+BQL. Currently Arm targets serialise all ARM_CP_IO register accesses<br>
=C2=A0and also defer the reset/startup of vCPUs to the vCPU context by way<=
br>
=C2=A0of async_run_on_cpu().<br>
<br>
@@ -268,7 +268,7 @@ ordered backends this could become a NOP.<br>
=C2=A0Aside from explicit standalone memory barrier instructions there are<=
br>
=C2=A0also implicit memory ordering semantics which comes with each guest<b=
r>
=C2=A0memory access instruction. For example all x86 load/stores come with<=
br>
-fairly strong guarantees of sequential consistency where as ARM has<br>
+fairly strong guarantees of sequential consistency whereas Arm has<br>
=C2=A0special variants of load/store instructions that imply acquire/releas=
e<br>
=C2=A0semantics.<br>
<br>
@@ -317,7 +317,7 @@ x86 cmpxchg instruction.<br>
<br>
=C2=A0The second type offer a pair of load/store instructions which offer a=
<br>
=C2=A0guarantee that a region of memory has not been touched between the<br=
>
-load and store instructions. An example of this is ARM&#39;s ldrex/strex<b=
r>
+load and store instructions. An example of this is Arm&#39;s ldrex/strex<b=
r>
=C2=A0pair where the strex instruction will return a flag indicating a<br>
=C2=A0successful store only if no other CPU has accessed the memory region<=
br>
=C2=A0since the ldrex.<br>
@@ -339,7 +339,7 @@ CURRENT OPEN QUESTIONS:<br>
<br>
=C2=A0The TCG provides a number of atomic helpers (tcg_gen_atomic_*) which<=
br>
=C2=A0can be used directly or combined to emulate other instructions like<b=
r>
-ARM&#39;s ldrex/strex instructions. While they are susceptible to the ABA<=
br>
+Arm&#39;s ldrex/strex instructions. While they are susceptible to the ABA<=
br>
=C2=A0problem so far common guests have not implemented patterns where<br>
=C2=A0this may be a problem - typically presenting a locking ABI which<br>
=C2=A0assumes cmpxchg like semantics.<br>
diff --git a/docs/replay.txt b/docs/replay.txt<br>
index f4619a62a3d..70c27edb362 100644<br>
--- a/docs/replay.txt<br>
+++ b/docs/replay.txt<br>
@@ -19,7 +19,7 @@ Deterministic replay has the following features:<br>
=C2=A0 =C2=A0 the memory, state of the hardware devices, clocks, and screen=
 of the VM.<br>
=C2=A0 * Writes execution log into the file for later replaying for multipl=
e times<br>
=C2=A0 =C2=A0 on different machines.<br>
- * Supports i386, x86_64, and ARM hardware platforms.<br>
+ * Supports i386, x86_64, and Arm hardware platforms.<br>
=C2=A0 * Performs deterministic replay of all operations with keyboard and =
mouse<br>
=C2=A0 =C2=A0 input devices.<br>
<br>
diff --git a/docs/specs/fw_cfg.txt b/docs/specs/fw_cfg.txt<br>
index 08c00bdf44a..8f1ebc66fa4 100644<br>
--- a/docs/specs/fw_cfg.txt<br>
+++ b/docs/specs/fw_cfg.txt<br>
@@ -82,7 +82,7 @@ Selector Register IOport: 0x510<br>
=C2=A0Data Register IOport:=C2=A0 =C2=A0 =C2=A00x511<br>
=C2=A0DMA Address IOport:=C2=A0 =C2=A0 =C2=A0 =C2=A00x514<br>
<br>
-=3D=3D=3D ARM Register Locations =3D=3D=3D<br>
+=3D=3D=3D Arm Register Locations =3D=3D=3D<br>
<br>
=C2=A0Selector Register address: Base + 8 (2 bytes)<br>
=C2=A0Data Register address:=C2=A0 =C2=A0 =C2=A0Base + 0 (8 bytes)<br>
diff --git a/docs/devel/kconfig.rst b/docs/devel/kconfig.rst<br>
index b7bca447046..e5df72b3422 100644<br>
--- a/docs/devel/kconfig.rst<br>
+++ b/docs/devel/kconfig.rst<br>
@@ -8,7 +8,7 @@ time different targets can share large amounts of code.=C2=
=A0 For example,<br>
=C2=A0a POWER and an x86 board can run the same code to emulate a PCI netwo=
rk<br>
=C2=A0card, even though the boards use different PCI host bridges, and they=
<br>
=C2=A0can run the same code to emulate a SCSI disk while using different<br=
>
-SCSI adapters.=C2=A0 ARM, s390 and x86 boards can all present a virtio-blk=
<br>
+SCSI adapters.=C2=A0 Arm, s390 and x86 boards can all present a virtio-blk=
<br>
=C2=A0disk to their guests, but with three different virtio guest interface=
s.<br>
<br>
=C2=A0Each QEMU target enables a subset of the boards, devices and buses th=
at<br>
diff --git a/docs/devel/loads-stores.rst b/docs/devel/loads-stores.rst<br>
index 03aa9e7ff80..0d99eb24c1b 100644<br>
--- a/docs/devel/loads-stores.rst<br>
+++ b/docs/devel/loads-stores.rst<br>
@@ -302,7 +302,7 @@ way QEMU defines the view of memory that a device or CP=
U has.<br>
=C2=A0or bus fabric.)<br>
<br>
=C2=A0Each CPU has an AddressSpace. Some kinds of CPU have more than<br>
-one AddressSpace (for instance ARM guest CPUs have an AddressSpace<br>
+one AddressSpace (for instance Arm guest CPUs have an AddressSpace<br>
=C2=A0for the Secure world and one for NonSecure if they implement TrustZon=
e).<br>
=C2=A0Devices which can do DMA-type operations should generally have an<br>
=C2=A0AddressSpace. There is also a &quot;system address space&quot; which =
typically<br>
diff --git a/docs/devel/tcg.rst b/docs/devel/tcg.rst<br>
index 4956a30a4e6..4ebde44b9d7 100644<br>
--- a/docs/devel/tcg.rst<br>
+++ b/docs/devel/tcg.rst<br>
@@ -83,7 +83,7 @@ memory until the end of the translation block.=C2=A0 This=
 is done for internal<br>
=C2=A0emulation state that is rarely accessed directly by the program and/o=
r changes<br>
=C2=A0very often throughout the execution of a translation block---this inc=
ludes<br>
=C2=A0condition codes on x86, delay slots on SPARC, conditional execution o=
n<br>
-ARM, and so on.=C2=A0 This state is stored for each target instruction, an=
d<br>
+Arm, and so on.=C2=A0 This state is stored for each target instruction, an=
d<br>
=C2=A0looked up on exceptions.<br>
<br>
=C2=A0MMU emulation<br>
diff --git a/docs/specs/tpm.rst b/docs/specs/tpm.rst<br>
index da9eb39ca97..5e61238bc5f 100644<br>
--- a/docs/specs/tpm.rst<br>
+++ b/docs/specs/tpm.rst<br>
@@ -25,7 +25,7 @@ QEMU files related to TPM TIS interface:<br>
<br>
=C2=A0Both an ISA device and a sysbus device are available. The former is<b=
r>
=C2=A0used with pc/q35 machine while the latter can be instantiated in the<=
br>
-ARM virt machine.<br>
+Arm virt machine.<br>
<br>
=C2=A0CRB interface<br>
=C2=A0-------------<br>
@@ -331,7 +331,7 @@ In case a pSeries machine is emulated, use the followin=
g command line:<br>
=C2=A0 =C2=A0 =C2=A0-device virtio-blk-pci,scsi=3Doff,bus=3Dpci.0,addr=3D0x=
3,drive=3Ddrive-virtio-disk0,id=3Dvirtio-disk0 \<br>
=C2=A0 =C2=A0 =C2=A0-drive file=3Dtest.img,format=3Draw,if=3Dnone,id=3Ddriv=
e-virtio-disk0<br>
<br>
-In case an ARM virt machine is emulated, use the following command line:<b=
r>
+In case an Arm virt machine is emulated, use the following command line:<b=
r>
<br>
=C2=A0.. code-block:: console<br>
<br>
@@ -346,7 +346,7 @@ In case an ARM virt machine is emulated, use the follow=
ing command line:<br>
=C2=A0 =C2=A0 =C2=A0-drive if=3Dpflash,format=3Draw,file=3Dflash0.img,reado=
nly \<br>
=C2=A0 =C2=A0 =C2=A0-drive if=3Dpflash,format=3Draw,file=3Dflash1.img<br>
<br>
-=C2=A0 On ARM, ACPI boot with TPM is not yet supported.<br>
+=C2=A0 On Arm, ACPI boot with TPM is not yet supported.<br>
<br>
=C2=A0In case SeaBIOS is used as firmware, it should show the TPM menu item=
<br>
=C2=A0after entering the menu with &#39;ESC&#39;.<br>
diff --git a/docs/system/arm/cpu-features.rst b/docs/system/arm/cpu-feature=
s.rst<br>
index 7495b7b672b..2d5c06cd016 100644<br>
--- a/docs/system/arm/cpu-features.rst<br>
+++ b/docs/system/arm/cpu-features.rst<br>
@@ -5,9 +5,9 @@ CPU features are optional features that a CPU of supporting=
 type may<br>
=C2=A0choose to implement or not.=C2=A0 In QEMU, optional CPU features have=
<br>
=C2=A0corresponding boolean CPU proprieties that, when enabled, indicate<br=
>
=C2=A0that the feature is implemented, and, conversely, when disabled,<br>
-indicate that it is not implemented. An example of an ARM CPU feature<br>
+indicate that it is not implemented. An example of an Arm CPU feature<br>
=C2=A0is the Performance Monitoring Unit (PMU).=C2=A0 CPU types such as the=
<br>
-Cortex-A15 and the Cortex-A57, which respectively implement ARM<br>
+Cortex-A15 and the Cortex-A57, which respectively implement Arm<br>
=C2=A0architecture reference manuals ARMv7-A and ARMv8-A, may both optional=
ly<br>
=C2=A0implement PMUs.=C2=A0 For example, if a user wants to use a Cortex-A1=
5 without<br>
=C2=A0a PMU, then the `-cpu` parameter should contain `pmu=3Doff` on the QE=
MU<br>
diff --git a/docs/system/arm/integratorcp.rst b/docs/system/arm/integratorc=
p.rst<br>
index 3232b43a08b..e6f050f602b 100644<br>
--- a/docs/system/arm/integratorcp.rst<br>
+++ b/docs/system/arm/integratorcp.rst<br>
@@ -1,7 +1,7 @@<br>
=C2=A0Integrator/CP (``integratorcp``)<br>
=C2=A0=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
<br>
-The ARM Integrator/CP board is emulated with the following devices:<br>
+The Arm Integrator/CP board is emulated with the following devices:<br>
<br>
=C2=A0-=C2=A0 ARM926E, ARM1026E, ARM946E, ARM1136 or Cortex-A8 CPU<br>
<br>
diff --git a/docs/system/arm/musicpal.rst b/docs/system/arm/musicpal.rst<br=
>
index 35c22212486..9de380edf81 100644<br>
--- a/docs/system/arm/musicpal.rst<br>
+++ b/docs/system/arm/musicpal.rst<br>
@@ -4,7 +4,7 @@ Freecom MusicPal (``musicpal``)<br>
=C2=A0The Freecom MusicPal internet radio emulation includes the following<=
br>
=C2=A0elements:<br>
<br>
--=C2=A0 Marvell MV88W8618 ARM core.<br>
+-=C2=A0 Marvell MV88W8618 Arm core.<br>
<br>
=C2=A0-=C2=A0 32 MB RAM, 256 KB SRAM, 8 MB flash.<br>
<br>
diff --git a/docs/system/arm/nseries.rst b/docs/system/arm/nseries.rst<br>
index b000b6d13bb..cd9edf5d88b 100644<br>
--- a/docs/system/arm/nseries.rst<br>
+++ b/docs/system/arm/nseries.rst<br>
@@ -4,7 +4,7 @@ Nokia N800 and N810 tablets (``n800``, ``n810``)<br>
=C2=A0Nokia N800 and N810 internet tablets (known also as RX-34 and RX-44 /=
<br>
=C2=A048) emulation supports the following elements:<br>
<br>
--=C2=A0 Texas Instruments OMAP2420 System-on-chip (ARM 1136 core)<br>
+-=C2=A0 Texas Instruments OMAP2420 System-on-chip (ARM1136 core)<br>
<br>
=C2=A0-=C2=A0 RAM and non-volatile OneNAND Flash memories<br>
<br>
diff --git a/docs/system/arm/palm.rst b/docs/system/arm/palm.rst<br>
index 0eabf63e0e7..47ff9b36d46 100644<br>
--- a/docs/system/arm/palm.rst<br>
+++ b/docs/system/arm/palm.rst<br>
@@ -4,7 +4,7 @@ Palm Tungsten|E PDA (``cheetah``)<br>
=C2=A0The Palm Tungsten|E PDA (codename \&quot;Cheetah\&quot;) emulation in=
cludes the<br>
=C2=A0following elements:<br>
<br>
--=C2=A0 Texas Instruments OMAP310 System-on-chip (ARM 925T core)<br>
+-=C2=A0 Texas Instruments OMAP310 System-on-chip (ARM925T core)<br>
<br>
=C2=A0-=C2=A0 ROM and RAM memories (ROM firmware image can be loaded with<b=
r>
=C2=A0 =C2=A0 -option-rom)<br>
diff --git a/docs/system/arm/realview.rst b/docs/system/arm/realview.rst<br=
>
index 8e08eb5da16..65f5be346b1 100644<br>
--- a/docs/system/arm/realview.rst<br>
+++ b/docs/system/arm/realview.rst<br>
@@ -1,7 +1,7 @@<br>
=C2=A0Arm Realview boards (``realview-eb``, ``realview-eb-mpcore``, ``realv=
iew-pb-a8``, ``realview-pbx-a9``)<br>
=C2=A0=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D<br>
<br>
-Several variants of the ARM RealView baseboard are emulated, including<br>
+Several variants of the Arm RealView baseboard are emulated, including<br>
=C2=A0the EB, PB-A8 and PBX-A9. Due to interactions with the bootloader, on=
ly<br>
=C2=A0certain Linux kernel configurations work out of the box on these boar=
ds.<br>
<br>
@@ -14,7 +14,7 @@ The following devices are emulated:<br>
<br>
=C2=A0-=C2=A0 ARM926E, ARM1136, ARM11MPCore, Cortex-A8 or Cortex-A9 MPCore =
CPU<br>
<br>
--=C2=A0 ARM AMBA Generic/Distributed Interrupt Controller<br>
+-=C2=A0 Arm AMBA Generic/Distributed Interrupt Controller<br>
<br>
=C2=A0-=C2=A0 Four PL011 UARTs<br>
<br>
diff --git a/docs/system/arm/sx1.rst b/docs/system/arm/sx1.rst<br>
index 321993bc098..8bce30d4b25 100644<br>
--- a/docs/system/arm/sx1.rst<br>
+++ b/docs/system/arm/sx1.rst<br>
@@ -4,7 +4,7 @@ Siemens SX1 (``sx1``, ``sx1-v1``)<br>
=C2=A0The Siemens SX1 models v1 and v2 (default) basic emulation. The<br>
=C2=A0emulation includes the following elements:<br>
<br>
--=C2=A0 Texas Instruments OMAP310 System-on-chip (ARM 925T core)<br>
+-=C2=A0 Texas Instruments OMAP310 System-on-chip (ARM925T core)<br>
<br>
=C2=A0-=C2=A0 ROM and RAM memories (ROM firmware image can be loaded with<b=
r>
=C2=A0 =C2=A0 -pflash) V1 1 Flash of 16MB and 1 Flash of 8MB V2 1 Flash of =
32MB<br>
diff --git a/docs/system/arm/versatile.rst b/docs/system/arm/versatile.rst<=
br>
index 48b6ca0a020..51221c30a48 100644<br>
--- a/docs/system/arm/versatile.rst<br>
+++ b/docs/system/arm/versatile.rst<br>
@@ -1,7 +1,7 @@<br>
=C2=A0Arm Versatile boards (``versatileab``, ``versatilepb``)<br>
=C2=A0=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D<br>
<br>
-The ARM Versatile baseboard is emulated with the following devices:<br>
+The Arm Versatile baseboard is emulated with the following devices:<br>
<br>
=C2=A0-=C2=A0 ARM926E, ARM1136 or Cortex-A8 CPU<br>
<br>
diff --git a/docs/system/arm/xscale.rst b/docs/system/arm/xscale.rst<br>
index 19da2eff352..89ec93e904e 100644<br>
--- a/docs/system/arm/xscale.rst<br>
+++ b/docs/system/arm/xscale.rst<br>
@@ -4,7 +4,7 @@ Sharp XScale-based PDA models (``akita``, ``borzoi``, ``spi=
tz``, ``terrier``)<br>
=C2=A0The XScale-based clamshell PDA models (\&quot;Spitz\&quot;, \&quot;Ak=
ita\&quot;, \&quot;Borzoi\&quot;<br>
=C2=A0and \&quot;Terrier\&quot;) emulation includes the following periphera=
ls:<br>
<br>
--=C2=A0 Intel PXA270 System-on-chip (ARM V5TE core)<br>
+-=C2=A0 Intel PXA270 System-on-chip (ARMv5TE core)<br>
<br>
=C2=A0-=C2=A0 NAND Flash memory<br>
<br>
diff --git a/docs/user/main.rst b/docs/user/main.rst<br>
index ca69f7727d5..bd99b0fdbe9 100644<br>
--- a/docs/user/main.rst<br>
+++ b/docs/user/main.rst<br>
@@ -35,7 +35,7 @@ QEMU user space emulation has the following notable featu=
res:<br>
=C2=A0 =C2=A0 On Linux, QEMU can emulate the ``clone`` syscall and create a=
 real<br>
=C2=A0 =C2=A0 host thread (with a separate virtual CPU) for each emulated t=
hread.<br>
=C2=A0 =C2=A0 Note that not all targets currently emulate atomic operations=
<br>
-=C2=A0 =C2=A0correctly. x86 and ARM use a global lock in order to preserve=
 their<br>
+=C2=A0 =C2=A0correctly. x86 and Arm use a global lock in order to preserve=
 their<br>
=C2=A0 =C2=A0 semantics.<br>
<br>
=C2=A0QEMU was conceived so that ultimately it can emulate itself. Although=
 it<br>
@@ -173,11 +173,11 @@ Other binaries<br>
=C2=A0user mode (Alpha)<br>
=C2=A0``qemu-alpha`` TODO.<br>
<br>
-user mode (ARM)<br>
+user mode (Arm)<br>
=C2=A0``qemu-armeb`` TODO.<br>
<br>
-user mode (ARM)<br>
-``qemu-arm`` is also capable of running ARM \&quot;Angel\&quot; semihosted=
 ELF<br>
+user mode (Arm)<br>
+``qemu-arm`` is also capable of running Arm \&quot;Angel\&quot; semihosted=
 ELF<br>
=C2=A0binaries (as implemented by the arm-elf and arm-eabi Newlib/GDB<br>
=C2=A0configurations), and arm-uclinux bFLT format binaries.<br>
<br>
-- <br>
2.20.1<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div></div>

--000000000000c4bdf705a0866e9e--

