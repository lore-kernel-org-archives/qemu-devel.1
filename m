Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B55AC433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 16:01:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E4E420820
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 16:01:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E4E420820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxCkw-0000ZQ-Ci
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 12:01:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49526)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hxCiq-0006L9-US
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 11:59:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hxCip-00082b-Az
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 11:59:00 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34707)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hxCip-00082L-4o
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 11:58:59 -0400
Received: by mail-wm1-f65.google.com with SMTP id e8so305618wme.1
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2019 08:58:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ojHzSKmUtq2wwJbOKVnCV6R33CUS+m9GuyHudd1LmW8=;
 b=X3VHxKM9pQBVgE/Q4wUt9rRb84v+0GHZaX8+Ghz1PZzifVOHnHfr2L8m1bFZ2tvDpn
 AIkWa3/EF8DLMoOJns40PqGzWViGA0IUUcGUsSPBaBMeGVL6v8meYQniIy7jjDf55wng
 S/RzvlL81M4wzC/mbotPCJwlXZ/Ml6Kqu9nfqyP0Suvl0XtThNr5wUKrOy0twzVSp6UQ
 qdDwOTVvT0TM4Jc1AVJUC7WildjRbkvqNMAMQvonTEz4OsMRuYQbx2xOOl5NQaC8VQEY
 hBI1JTWcD8fca5aG7iAiwQv0HYv3qmxfv/DCClUPWG16/f0iF5QGDa3eVa30uiTzEfUw
 I2MA==
X-Gm-Message-State: APjAAAXMYfvSx0RtZhSPY2ElkFWsuk2djJjt+O5Mx6X3b7CATanLsbWw
 UuskHU6Tkes2Z9tdpkYofnOJ4g==
X-Google-Smtp-Source: APXvYqzuUi4+iYtSh2Oik6wNEXmm1fn82ac8mo+HOeo79+xYhhC4KMlnID4UpId03WEYn7ltYZFDjA==
X-Received: by 2002:a7b:c76d:: with SMTP id x13mr6527wmk.110.1565625538056;
 Mon, 12 Aug 2019 08:58:58 -0700 (PDT)
Received: from [192.168.1.34] (59.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.59])
 by smtp.gmail.com with ESMTPSA id f17sm8895625wmj.27.2019.08.12.08.58.57
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 12 Aug 2019 08:58:57 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190812052359.30071-1-armbru@redhat.com>
 <20190812052359.30071-2-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <30d9a77b-2197-71ca-30ea-d2eb87d0b601@redhat.com>
Date: Mon, 12 Aug 2019 17:58:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190812052359.30071-2-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH v4 01/29] include: Make headers more
 self-contained
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
Cc: Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/12/19 7:23 AM, Markus Armbruster wrote:
> Back in 2016, we discussed[1] rules for headers, and these were
> generally liked:
> 
> 1. Have a carefully curated header that's included everywhere first.  We
>    got that already thanks to Peter: osdep.h.
> 
> 2. Headers should normally include everything they need beyond osdep.h.
>    If exceptions are needed for some reason, they must be documented in
>    the header.  If all that's needed from a header is typedefs, put
>    those into qemu/typedefs.h instead of including the header.
> 
> 3. Cyclic inclusion is forbidden.
> 
> This patch gets include/ closer to obeying 2.
> 
> It's actually extracted from my "[RFC] Baby steps towards saner
> headers" series[2], which demonstrates a possible path towards
> checking 2 automatically.  It passes the RFC test there.
> 
> [1] Message-ID: <87h9g8j57d.fsf@blackfin.pond.sub.org>
>     https://lists.nongnu.org/archive/html/qemu-devel/2016-03/msg03345.html
> [2] Message-Id: <20190711122827.18970-1-armbru@redhat.com>
>     https://lists.nongnu.org/archive/html/qemu-devel/2019-07/msg02715.html
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  include/block/raw-aio.h               | 2 ++
>  include/block/write-threshold.h       | 2 ++
>  include/disas/disas.h                 | 1 +
>  include/exec/cputlb.h                 | 3 +++
>  include/exec/exec-all.h               | 1 +
>  include/exec/ioport.h                 | 2 ++
>  include/exec/memory-internal.h        | 2 ++
>  include/exec/ram_addr.h               | 1 +
>  include/exec/softmmu-semi.h           | 2 ++
>  include/exec/tb-hash.h                | 2 ++
>  include/exec/user/thunk.h             | 2 ++
>  include/fpu/softfloat-macros.h        | 2 ++
>  include/hw/acpi/pci.h                 | 3 +++
>  include/hw/acpi/tco.h                 | 3 +++
>  include/hw/adc/stm32f2xx_adc.h        | 2 ++
>  include/hw/arm/allwinner-a10.h        | 1 +
>  include/hw/arm/aspeed_soc.h           | 1 +
>  include/hw/arm/bcm2836.h              | 1 +
>  include/hw/arm/exynos4210.h           | 3 +--
>  include/hw/arm/fsl-imx25.h            | 1 +
>  include/hw/arm/fsl-imx31.h            | 1 +
>  include/hw/arm/sharpsl.h              | 3 +++
>  include/hw/arm/xlnx-zynqmp.h          | 1 +
>  include/hw/block/fdc.h                | 2 ++
>  include/hw/block/flash.h              | 1 +
>  include/hw/char/escc.h                | 1 +
>  include/hw/char/xilinx_uartlite.h     | 2 ++
>  include/hw/core/generic-loader.h      | 1 +
>  include/hw/cris/etraxfs.h             | 1 +
>  include/hw/cris/etraxfs_dma.h         | 3 +++
>  include/hw/display/i2c-ddc.h          | 1 +
>  include/hw/empty_slot.h               | 2 ++
>  include/hw/gpio/bcm2835_gpio.h        | 1 +
>  include/hw/i2c/aspeed_i2c.h           | 2 ++
>  include/hw/i386/apic_internal.h       | 1 +
>  include/hw/i386/ioapic_internal.h     | 1 +
>  include/hw/intc/allwinner-a10-pic.h   | 2 ++
>  include/hw/intc/heathrow_pic.h        | 2 ++
>  include/hw/intc/mips_gic.h            | 1 +
>  include/hw/isa/vt82c686.h             | 2 ++
>  include/hw/mips/cps.h                 | 1 +
>  include/hw/misc/macio/cuda.h          | 2 ++
>  include/hw/misc/macio/gpio.h          | 3 +++
>  include/hw/misc/macio/macio.h         | 2 ++
>  include/hw/misc/macio/pmu.h           | 3 +++
>  include/hw/misc/mips_cmgcr.h          | 2 ++
>  include/hw/misc/mips_cpc.h            | 2 ++
>  include/hw/misc/pvpanic.h             | 3 +++
>  include/hw/net/allwinner_emac.h       | 1 +
>  include/hw/net/lance.h                | 1 +
>  include/hw/nvram/chrp_nvram.h         | 2 ++
>  include/hw/pci-host/sabre.h           | 2 ++
>  include/hw/pci-host/uninorth.h        | 2 +-
>  include/hw/pci/pcie_aer.h             | 1 +
>  include/hw/ppc/pnv_core.h             | 1 +
>  include/hw/ppc/ppc4xx.h               | 4 ++++
>  include/hw/ppc/spapr_irq.h            | 3 +++
>  include/hw/ppc/spapr_vio.h            | 1 +
>  include/hw/ppc/spapr_xive.h           | 2 ++
>  include/hw/ppc/xive_regs.h            | 3 +++
>  include/hw/riscv/boot.h               | 2 ++
>  include/hw/riscv/riscv_hart.h         | 3 +++
>  include/hw/riscv/sifive_clint.h       | 2 ++
>  include/hw/riscv/sifive_e.h           | 1 +
>  include/hw/riscv/sifive_plic.h        | 2 +-
>  include/hw/riscv/sifive_prci.h        | 2 ++
>  include/hw/riscv/sifive_test.h        | 2 ++
>  include/hw/riscv/sifive_u.h           | 1 +
>  include/hw/riscv/sifive_uart.h        | 3 +++
>  include/hw/riscv/spike.h              | 3 +++
>  include/hw/riscv/virt.h               | 3 +++
>  include/hw/s390x/ap-device.h          | 3 +++
>  include/hw/s390x/css-bridge.h         | 3 ++-
>  include/hw/s390x/css.h                | 1 +
>  include/hw/s390x/tod.h                | 2 +-
>  include/hw/semihosting/console.h      | 2 ++
>  include/hw/sh4/sh_intc.h              | 1 +
>  include/hw/sparc/sparc64.h            | 2 ++
>  include/hw/ssi/aspeed_smc.h           | 1 +
>  include/hw/ssi/xilinx_spips.h         | 1 +
>  include/hw/timer/allwinner-a10-pit.h  | 1 +
>  include/hw/timer/i8254_internal.h     | 1 +
>  include/hw/timer/m48t59.h             | 2 ++
>  include/hw/timer/mc146818rtc_regs.h   | 2 ++
>  include/hw/timer/xlnx-zynqmp-rtc.h    | 1 +
>  include/hw/virtio/virtio-access.h     | 1 +
>  include/hw/virtio/virtio-gpu-bswap.h  | 1 +
>  include/hw/virtio/virtio-rng.h        | 1 +
>  include/hw/watchdog/wdt_aspeed.h      | 1 +
>  include/libdecnumber/decNumberLocal.h | 1 +
>  include/migration/cpu.h               | 3 +++
>  include/monitor/hmp-target.h          | 2 ++
>  include/qemu/atomic128.h              | 2 ++
>  include/qemu/ratelimit.h              | 2 ++
>  include/qemu/thread-win32.h           | 2 +-
>  include/sysemu/balloon.h              | 1 +
>  include/sysemu/cryptodev-vhost-user.h | 3 +++
>  include/sysemu/hvf.h                  | 1 +
>  include/sysemu/iothread.h             | 1 +
>  include/sysemu/kvm_int.h              | 2 ++
>  include/sysemu/memory_mapping.h       | 2 ++
>  include/sysemu/xen-mapcache.h         | 2 ++
>  include/ui/egl-helpers.h              | 3 +++
>  include/ui/input.h                    | 1 +
>  include/ui/spice-display.h            | 1 +
>  target/hppa/cpu.h                     | 2 +-
>  106 files changed, 183 insertions(+), 8 deletions(-)

