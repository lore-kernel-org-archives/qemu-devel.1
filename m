Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F170EC43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 19:50:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56CF821532
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 19:50:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56CF821532
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFN9U-0006HF-87
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 15:50:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58526)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>)
 id 1kFN7D-0004hh-O3; Mon, 07 Sep 2020 15:47:47 -0400
Received: from relay64.bu.edu ([128.197.228.104]:41507)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>)
 id 1kFN7A-0006Eu-Bx; Mon, 07 Sep 2020 15:47:47 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay64.bu.edu (8.14.3/8.14.3) with ESMTP id 087JlBfo008061
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 7 Sep 2020 15:47:14 -0400
Date: Mon, 7 Sep 2020 15:47:11 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Havard Skinnemoen <hskinnemoen@google.com>
Subject: Re: [PATCH v8 08/14] hw/nvram: NPCM7xx OTP device model
Message-ID: <20200907194711.gqvtntqab2yt5gco@mozz.bu.edu>
References: <20200825001711.1340443-1-hskinnemoen@google.com>
 <20200825001711.1340443-9-hskinnemoen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200825001711.1340443-9-hskinnemoen@google.com>
Received-SPF: pass client-ip=128.197.228.104; envelope-from=alxndr@bu.edu;
 helo=relay64.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 15:47:43
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
Cc: peter.maydell@linaro.org, f4bug@amsat.org, qemu-devel@nongnu.org,
 kfting@nuvoton.com, qemu-arm@nongnu.org, Avi.Fishman@nuvoton.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 200824 1717, Havard Skinnemoen via wrote:
> This supports reading and writing OTP fuses and keys. Only fuse reading
> has been tested. Protection is not implemented.
> 
> Reviewed-by: Avi Fishman <avi.fishman@nuvoton.com>
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
> ---
>  include/hw/arm/npcm7xx.h       |   3 +
>  include/hw/nvram/npcm7xx_otp.h |  79 ++++++
>  hw/arm/npcm7xx.c               |  29 +++
>  hw/nvram/npcm7xx_otp.c         | 439 +++++++++++++++++++++++++++++++++
>  hw/nvram/meson.build           |   1 +
>  5 files changed, 551 insertions(+)
>  create mode 100644 include/hw/nvram/npcm7xx_otp.h
>  create mode 100644 hw/nvram/npcm7xx_otp.c
> 
> diff --git a/include/hw/arm/npcm7xx.h b/include/hw/arm/npcm7xx.h
> index ba7495869d..5816a07a72 100644
> --- a/include/hw/arm/npcm7xx.h
> +++ b/include/hw/arm/npcm7xx.h
> @@ -20,6 +20,7 @@
>  #include "hw/cpu/a9mpcore.h"
>  #include "hw/misc/npcm7xx_clk.h"
>  #include "hw/misc/npcm7xx_gcr.h"
> +#include "hw/nvram/npcm7xx_otp.h"
>  #include "hw/timer/npcm7xx_timer.h"
>  #include "target/arm/cpu.h"
>  
> @@ -68,6 +69,8 @@ typedef struct NPCM7xxState {
>      NPCM7xxGCRState     gcr;
>      NPCM7xxCLKState     clk;
>      NPCM7xxTimerCtrlState tim[3];
> +    NPCM7xxOTPState     key_storage;
> +    NPCM7xxOTPState     fuse_array;
>  } NPCM7xxState;
>  
>  #define TYPE_NPCM7XX    "npcm7xx"
> diff --git a/include/hw/nvram/npcm7xx_otp.h b/include/hw/nvram/npcm7xx_otp.h
> new file mode 100644
> index 0000000000..156bbd151a
> --- /dev/null
> +++ b/include/hw/nvram/npcm7xx_otp.h
> @@ -0,0 +1,79 @@
> +/*
> + * Nuvoton NPCM7xx OTP (Fuse Array) Interface
> + *
> + * Copyright 2020 Google LLC
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the
> + * Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
> + * for more details.
> + */
> +#ifndef NPCM7XX_OTP_H
> +#define NPCM7XX_OTP_H
> +
> +#include "exec/memory.h"
> +#include "hw/sysbus.h"
> +
> +/* Each OTP module holds 8192 bits of one-time programmable storage */
> +#define NPCM7XX_OTP_ARRAY_BITS (8192)
> +#define NPCM7XX_OTP_ARRAY_BYTES (NPCM7XX_OTP_ARRAY_BITS / BITS_PER_BYTE)
> +
> +/* Fuse array offsets */
> +#define NPCM7XX_FUSE_FUSTRAP (0)
> +#define NPCM7XX_FUSE_CP_FUSTRAP (12)
> +#define NPCM7XX_FUSE_DAC_CALIB (16)
> +#define NPCM7XX_FUSE_ADC_CALIB (24)
> +#define NPCM7XX_FUSE_DERIVATIVE (64)
> +#define NPCM7XX_FUSE_TEST_SIG (72)
> +#define NPCM7XX_FUSE_DIE_LOCATION (74)
> +#define NPCM7XX_FUSE_GP1 (80)
> +#define NPCM7XX_FUSE_GP2 (128)
> +
> +/*
> + * Number of registers in our device state structure. Don't change this without
> + * incrementing the version_id in the vmstate.
> + */
> +#define NPCM7XX_OTP_NR_REGS (0x18 / sizeof(uint32_t))
> +
> +/**
> + * struct NPCM7xxOTPState - Device state for one OTP module.
> + * @parent: System bus device.
> + * @mmio: Memory region through which registers are accessed.
> + * @regs: Register contents.
> + * @array: OTP storage array.
> + */
> +typedef struct NPCM7xxOTPState {
> +    SysBusDevice parent;
> +
> +    MemoryRegion mmio;
> +    uint32_t regs[NPCM7XX_OTP_NR_REGS];
> +    uint8_t array[NPCM7XX_OTP_ARRAY_BYTES];
> +} NPCM7xxOTPState;
> +
> +#define TYPE_NPCM7XX_OTP "npcm7xx-otp"
> +#define NPCM7XX_OTP(obj) OBJECT_CHECK(NPCM7xxOTPState, (obj), TYPE_NPCM7XX_OTP)
> +
> +#define TYPE_NPCM7XX_KEY_STORAGE "npcm7xx-key-storage"
> +#define TYPE_NPCM7XX_FUSE_ARRAY "npcm7xx-fuse-array"
> +
> +typedef struct NPCM7xxOTPClass NPCM7xxOTPClass;
> +
> +/**
> + * npcm7xx_otp_array_write - ECC encode and write data to OTP array.
> + * @s: OTP module.
> + * @data: Data to be encoded and written.
> + * @offset: Offset of first byte to be written in the OTP array.
> + * @len: Number of bytes before ECC encoding.
> + *
> + * Each nibble of data is encoded into a byte, so the number of bytes written
> + * to the array will be @len * 2.
> + */
> +extern void npcm7xx_otp_array_write(NPCM7xxOTPState *s, const void *data,
> +                                    unsigned int offset, unsigned int len);
> +
> +#endif /* NPCM7XX_OTP_H */
> diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c
> index 9669ac5fa0..9166002598 100644
> --- a/hw/arm/npcm7xx.c
> +++ b/hw/arm/npcm7xx.c
> @@ -34,6 +34,10 @@
>  #define NPCM7XX_MMIO_BA         (0x80000000)
>  #define NPCM7XX_MMIO_SZ         (0x7ffd0000)
>  
> +/* OTP key storage and fuse strap array */
> +#define NPCM7XX_OTP1_BA         (0xf0189000)
> +#define NPCM7XX_OTP2_BA         (0xf018a000)
> +
>  /* Core system modules. */
>  #define NPCM7XX_L2C_BA          (0xf03fc000)
>  #define NPCM7XX_CPUP_BA         (0xf03fe000)
> @@ -144,6 +148,20 @@ void npcm7xx_load_kernel(MachineState *machine, NPCM7xxState *soc)
>      arm_load_kernel(&soc->cpu[0], machine, &npcm7xx_binfo);
>  }
>  
> +static void npcm7xx_init_fuses(NPCM7xxState *s)
> +{
> +    NPCM7xxClass *nc = NPCM7XX_GET_CLASS(s);
> +    uint32_t value;
> +
> +    /*
> +     * The initial mask of disabled modules indicates the chip derivative (e.g.
> +     * NPCM750 or NPCM730).
> +     */
> +    value = tswap32(nc->disabled_modules);
> +    npcm7xx_otp_array_write(&s->fuse_array, &value, NPCM7XX_FUSE_DERIVATIVE,
> +                            sizeof(value));
> +}
> +
>  static qemu_irq npcm7xx_irq(NPCM7xxState *s, int n)
>  {
>      return qdev_get_gpio_in(DEVICE(&s->a9mpcore), n);
> @@ -164,6 +182,10 @@ static void npcm7xx_init(Object *obj)
>      object_property_add_alias(obj, "power-on-straps", OBJECT(&s->gcr),
>                                "power-on-straps");
>      object_initialize_child(obj, "clk", &s->clk, TYPE_NPCM7XX_CLK);
> +    object_initialize_child(obj, "otp1", &s->key_storage,
> +                            TYPE_NPCM7XX_KEY_STORAGE);
> +    object_initialize_child(obj, "otp2", &s->fuse_array,
> +                            TYPE_NPCM7XX_FUSE_ARRAY);
>  
>      for (i = 0; i < ARRAY_SIZE(s->tim); i++) {
>          object_initialize_child(obj, "tim[*]", &s->tim[i], TYPE_NPCM7XX_TIMER);
> @@ -232,6 +254,13 @@ static void npcm7xx_realize(DeviceState *dev, Error **errp)
>      sysbus_realize(SYS_BUS_DEVICE(&s->clk), &error_abort);
>      sysbus_mmio_map(SYS_BUS_DEVICE(&s->clk), 0, NPCM7XX_CLK_BA);
>  
> +    /* OTP key storage and fuse strap array. Cannot fail. */
> +    sysbus_realize(SYS_BUS_DEVICE(&s->key_storage), &error_abort);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->key_storage), 0, NPCM7XX_OTP1_BA);
> +    sysbus_realize(SYS_BUS_DEVICE(&s->fuse_array), &error_abort);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->fuse_array), 0, NPCM7XX_OTP2_BA);
> +    npcm7xx_init_fuses(s);
> +
>      /* Timer Modules (TIM). Cannot fail. */
>      QEMU_BUILD_BUG_ON(ARRAY_SIZE(npcm7xx_tim_addr) != ARRAY_SIZE(s->tim));
>      for (i = 0; i < ARRAY_SIZE(s->tim); i++) {
> diff --git a/hw/nvram/npcm7xx_otp.c b/hw/nvram/npcm7xx_otp.c
> new file mode 100644
> index 0000000000..ba4188ada8
> --- /dev/null
> +++ b/hw/nvram/npcm7xx_otp.c
> @@ -0,0 +1,439 @@
> +/*
> + * Nuvoton NPCM7xx OTP (Fuse Array) Interface
> + *
> + * Copyright 2020 Google LLC
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the
> + * Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
> + * for more details.
> + */
> +
> +#include "qemu/osdep.h"
> +
> +#include "hw/nvram/npcm7xx_otp.h"
> +#include "migration/vmstate.h"
> +#include "qapi/error.h"
> +#include "qemu/bitops.h"
> +#include "qemu/log.h"
> +#include "qemu/module.h"
> +#include "qemu/units.h"
> +
> +/* Each module has 4 KiB of register space. Only a fraction of it is used. */
> +#define NPCM7XX_OTP_REGS_SIZE (4 * KiB)
> +
> +/* 32-bit register indices. */
> +typedef enum NPCM7xxOTPRegister {
> +    NPCM7XX_OTP_FST,
> +    NPCM7XX_OTP_FADDR,
> +    NPCM7XX_OTP_FDATA,
> +    NPCM7XX_OTP_FCFG,
> +    /* Offset 0x10 is FKEYIND in OTP1, FUSTRAP in OTP2 */
> +    NPCM7XX_OTP_FKEYIND = 0x0010 / sizeof(uint32_t),
> +    NPCM7XX_OTP_FUSTRAP = 0x0010 / sizeof(uint32_t),
> +    NPCM7XX_OTP_FCTL,
> +    NPCM7XX_OTP_REGS_END,
> +} NPCM7xxOTPRegister;
> +
> +/* Register field definitions. */
> +#define FST_RIEN BIT(2)
> +#define FST_RDST BIT(1)
> +#define FST_RDY BIT(0)
> +#define FST_RO_MASK (FST_RDST | FST_RDY)
> +
> +#define FADDR_BYTEADDR(rv) extract32((rv), 0, 10)
> +#define FADDR_BITPOS(rv) extract32((rv), 10, 3)
> +
> +#define FDATA_CLEAR 0x00000001
> +
> +#define FCFG_FDIS BIT(31)
> +#define FCFG_FCFGLK_MASK 0x00ff0000
> +
> +#define FCTL_PROG_CMD1 0x00000001
> +#define FCTL_PROG_CMD2 0xbf79e5d0
> +#define FCTL_READ_CMD 0x00000002
> +
> +/**
> + * struct NPCM7xxOTPClass - OTP module class.
> + * @parent: System bus device class.
> + * @mmio_ops: MMIO register operations for this type of module.
> + *
> + * The two OTP modules (key-storage and fuse-array) have slightly different
> + * behavior, so we give them different MMIO register operations.
> + */
> +struct NPCM7xxOTPClass {
> +    SysBusDeviceClass parent;
> +
> +    const MemoryRegionOps *mmio_ops;
> +};
> +
> +#define NPCM7XX_OTP_CLASS(klass) \
> +    OBJECT_CLASS_CHECK(NPCM7xxOTPClass, (klass), TYPE_NPCM7XX_OTP)
> +#define NPCM7XX_OTP_GET_CLASS(obj) \
> +    OBJECT_GET_CLASS(NPCM7xxOTPClass, (obj), TYPE_NPCM7XX_OTP)
> +
> +static uint8_t ecc_encode_nibble(uint8_t n)
> +{
> +    uint8_t result = n;
> +
> +    result |= (((n >> 0) & 1) ^ ((n >> 1) & 1)) << 4;
> +    result |= (((n >> 2) & 1) ^ ((n >> 3) & 1)) << 5;
> +    result |= (((n >> 0) & 1) ^ ((n >> 2) & 1)) << 6;
> +    result |= (((n >> 1) & 1) ^ ((n >> 3) & 1)) << 7;
> +
> +    return result;
> +}
> +
> +void npcm7xx_otp_array_write(NPCM7xxOTPState *s, const void *data,
> +                             unsigned int offset, unsigned int len)
> +{
> +    const uint8_t *src = data;
> +    uint8_t *dst = &s->array[offset];
> +
> +    while (len-- > 0) {
> +        uint8_t c = *src++;
> +
> +        *dst++ = ecc_encode_nibble(extract8(c, 0, 4));
> +        *dst++ = ecc_encode_nibble(extract8(c, 4, 4));
> +    }
> +}
> +
> +/* Common register read handler for both OTP classes. */
> +static uint64_t npcm7xx_otp_read(NPCM7xxOTPState *s, NPCM7xxOTPRegister reg)
> +{
> +    uint32_t value = 0;
> +
> +    switch (reg) {
> +    case NPCM7XX_OTP_FST:
> +    case NPCM7XX_OTP_FADDR:
> +    case NPCM7XX_OTP_FDATA:
> +    case NPCM7XX_OTP_FCFG:
> +        value = s->regs[reg];
> +        break;
> +
> +    case NPCM7XX_OTP_FCTL:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: read from write-only FCTL register\n",
> +                      DEVICE(s)->canonical_path);
> +        break;
> +
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: read from invalid offset 0x%zx\n",
> +                      DEVICE(s)->canonical_path, reg * sizeof(uint32_t));
> +        break;
> +    }
> +
> +    return value;
> +}
> +
> +/* Read a byte from the OTP array into the data register. */
> +static void npcm7xx_otp_read_array(NPCM7xxOTPState *s)
> +{
> +    uint32_t faddr = s->regs[NPCM7XX_OTP_FADDR];
> +
> +    s->regs[NPCM7XX_OTP_FDATA] = s->array[FADDR_BYTEADDR(faddr)];
> +    s->regs[NPCM7XX_OTP_FST] |= FST_RDST | FST_RDY;
> +}
> +
> +/* Program a byte from the data register into the OTP array. */
> +static void npcm7xx_otp_program_array(NPCM7xxOTPState *s)
> +{
> +    uint32_t faddr = s->regs[NPCM7XX_OTP_FADDR];
> +
> +    /* Bits can only go 0->1, never 1->0. */
> +    s->array[FADDR_BYTEADDR(faddr)] |= (1U << FADDR_BITPOS(faddr));
> +    s->regs[NPCM7XX_OTP_FST] |= FST_RDST | FST_RDY;
> +}
> +
> +/* Compute the next value of the FCFG register. */
> +static uint32_t npcm7xx_otp_compute_fcfg(uint32_t cur_value, uint32_t new_value)
> +{
> +    uint32_t lock_mask;
> +    uint32_t value;
> +
> +    /*
> +     * FCFGLK holds sticky bits 16..23, indicating which bits in FPRGLK (8..15)
> +     * and FRDLK (0..7) that are read-only.
> +     */
> +    lock_mask = (cur_value & FCFG_FCFGLK_MASK) >> 8;
> +    lock_mask |= lock_mask >> 8;
> +    /* FDIS and FCFGLK bits are sticky (write 1 to set; can't clear). */
> +    value = cur_value & (FCFG_FDIS | FCFG_FCFGLK_MASK);
> +    /* Preserve read-only bits in FPRGLK and FRDLK */
> +    value |= cur_value & lock_mask;
> +    /* Set all bits that aren't read-only. */
> +    value |= new_value & ~lock_mask;
> +
> +    return value;
> +}
> +
> +/* Common register write handler for both OTP classes. */
> +static void npcm7xx_otp_write(NPCM7xxOTPState *s, NPCM7xxOTPRegister reg,
> +                              uint32_t value)
> +{
> +    switch (reg) {
> +    case NPCM7XX_OTP_FST:
> +        /* RDST is cleared by writing 1 to it. */
> +        if (value & FST_RDST) {
> +            s->regs[NPCM7XX_OTP_FST] &= ~FST_RDST;
> +        }
> +        /* Preserve read-only and write-one-to-clear bits */
> +        value &= ~FST_RO_MASK;
> +        value |= s->regs[NPCM7XX_OTP_FST] & FST_RO_MASK;
> +        break;
> +
> +    case NPCM7XX_OTP_FADDR:
> +        break;
> +
> +    case NPCM7XX_OTP_FDATA:
> +        /*
> +         * This register is cleared by writing a magic value to it; no other
> +         * values can be written.
> +         */
> +        if (value == FDATA_CLEAR) {
> +            value = 0;
> +        } else {
> +            value = s->regs[NPCM7XX_OTP_FDATA];
> +        }
> +        break;
> +
> +    case NPCM7XX_OTP_FCFG:
> +        value = npcm7xx_otp_compute_fcfg(s->regs[NPCM7XX_OTP_FCFG], value);
> +        break;
> +
> +    case NPCM7XX_OTP_FCTL:
> +        switch (value) {
> +        case FCTL_READ_CMD:
> +            npcm7xx_otp_read_array(s);
> +            break;
> +
> +        case FCTL_PROG_CMD1:
> +            /*
> +             * Programming requires writing two separate magic values to this
> +             * register; this is the first one. Just store it so it can be
> +             * verified later when the second magic value is received.
> +             */
> +            break;
> +
> +        case FCTL_PROG_CMD2:
> +            /*
> +             * Only initiate programming if we received the first half of the
> +             * command immediately before this one.
> +             */
> +            if (s->regs[NPCM7XX_OTP_FCTL] == FCTL_PROG_CMD1) {
> +                npcm7xx_otp_program_array(s);
> +            }
> +            break;
> +
> +        default:
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: unrecognized FCNTL value 0x%" PRIx32 "\n",
> +                          DEVICE(s)->canonical_path, value);
> +            break;
> +        }
> +        if (value != FCTL_PROG_CMD1) {
> +            value = 0;
> +        }
> +        break;
> +
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: write to invalid offset 0x%zx\n",
> +                      DEVICE(s)->canonical_path, reg * sizeof(uint32_t));
> +        return;
> +    }
> +
> +    s->regs[reg] = value;
> +}
> +
> +/* Register read handler specific to the fuse array OTP module. */
> +static uint64_t npcm7xx_fuse_array_read(void *opaque, hwaddr addr,
> +                                        unsigned int size)
> +{
> +    NPCM7xxOTPRegister reg = addr / sizeof(uint32_t);
> +    NPCM7xxOTPState *s = opaque;
> +    uint32_t value;
> +
> +    /*
> +     * Only the Fuse Strap register needs special handling; all other registers
> +     * work the same way for both kinds of OTP modules.
> +     */
> +    if (reg != NPCM7XX_OTP_FUSTRAP) {
> +        value = npcm7xx_otp_read(s, reg);
> +    } else {
> +        /* FUSTRAP is stored as three copies in the OTP array. */
> +        uint32_t fustrap[3];
> +
> +        memcpy(fustrap, &s->array[0], sizeof(fustrap));
> +
> +        /* Determine value by a majority vote on each bit. */
> +        value = (fustrap[0] & fustrap[1]) | (fustrap[0] & fustrap[2]) |
> +                (fustrap[1] & fustrap[2]);
> +    }
> +
> +    return value;
> +}
> +
> +/* Register write handler specific to the fuse array OTP module. */
> +static void npcm7xx_fuse_array_write(void *opaque, hwaddr addr, uint64_t v,
> +                                     unsigned int size)
> +{
> +    NPCM7xxOTPRegister reg = addr / sizeof(uint32_t);
> +    NPCM7xxOTPState *s = opaque;
> +
> +    /*
> +     * The Fuse Strap register is read-only. Other registers are handled by
> +     * common code.
> +     */
> +    if (reg != NPCM7XX_OTP_FUSTRAP) {
> +        npcm7xx_otp_write(s, reg, v);
> +    }
> +}
> +
> +static const MemoryRegionOps npcm7xx_fuse_array_ops = {
> +    .read       = npcm7xx_fuse_array_read,
> +    .write      = npcm7xx_fuse_array_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid      = {
> +        .min_access_size        = 4,
> +        .max_access_size        = 4,
> +        .unaligned              = false,
> +    },
> +};
> +
> +/* Register read handler specific to the key storage OTP module. */
> +static uint64_t npcm7xx_key_storage_read(void *opaque, hwaddr addr,
> +                                         unsigned int size)
> +{
> +    NPCM7xxOTPRegister reg = addr / sizeof(uint32_t);
> +    NPCM7xxOTPState *s = opaque;
> +
> +    /*
> +     * Only the Fuse Key Index register needs special handling; all other
> +     * registers work the same way for both kinds of OTP modules.
> +     */
> +    if (reg != NPCM7XX_OTP_FKEYIND) {
> +        return npcm7xx_otp_read(s, reg);
> +    }
> +
> +    qemu_log_mask(LOG_UNIMP, "%s: FKEYIND is not implemented\n", __func__);
> +
> +    return s->regs[NPCM7XX_OTP_FKEYIND];
> +}
> +
> +/* Register write handler specific to the key storage OTP module. */
> +static void npcm7xx_key_storage_write(void *opaque, hwaddr addr, uint64_t v,
> +                                      unsigned int size)
> +{
> +    NPCM7xxOTPRegister reg = addr / sizeof(uint32_t);
> +    NPCM7xxOTPState *s = opaque;
> +
> +    /*
> +     * Only the Fuse Key Index register needs special handling; all other
> +     * registers work the same way for both kinds of OTP modules.
> +     */
> +    if (reg != NPCM7XX_OTP_FKEYIND) {
> +        npcm7xx_otp_write(s, reg, v);
> +        return;
> +    }
> +
> +    qemu_log_mask(LOG_UNIMP, "%s: FKEYIND is not implemented\n", __func__);
> +
> +    s->regs[NPCM7XX_OTP_FKEYIND] = v;
> +}
> +
> +static const MemoryRegionOps npcm7xx_key_storage_ops = {
> +    .read       = npcm7xx_key_storage_read,
> +    .write      = npcm7xx_key_storage_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid      = {
> +        .min_access_size        = 4,
> +        .max_access_size        = 4,
> +        .unaligned              = false,
> +    },
> +};
> +
> +static void npcm7xx_otp_enter_reset(Object *obj, ResetType type)
> +{
> +    NPCM7xxOTPState *s = NPCM7XX_OTP(obj);
> +
> +    memset(s->regs, 0, sizeof(s->regs));
> +
> +    s->regs[NPCM7XX_OTP_FST] = 0x00000001;
> +    s->regs[NPCM7XX_OTP_FCFG] = 0x20000000;
> +}
> +
> +static void npcm7xx_otp_realize(DeviceState *dev, Error **errp)
> +{
> +    NPCM7xxOTPClass *oc = NPCM7XX_OTP_GET_CLASS(dev);
> +    NPCM7xxOTPState *s = NPCM7XX_OTP(dev);
> +    SysBusDevice *sbd = &s->parent;
> +
> +    memset(s->array, 0, sizeof(s->array));
> +
> +    memory_region_init_io(&s->mmio, OBJECT(s), oc->mmio_ops, s, "regs",
> +                          NPCM7XX_OTP_REGS_SIZE);
> +    sysbus_init_mmio(sbd, &s->mmio);
> +}
> +
> +static const VMStateDescription vmstate_npcm7xx_otp = {
> +    .name = "npcm7xx-otp",
> +    .version_id = 0,
> +    .minimum_version_id = 0,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT32_ARRAY(regs, NPCM7xxOTPState, NPCM7XX_OTP_NR_REGS),
> +        VMSTATE_UINT8_ARRAY(array, NPCM7xxOTPState, NPCM7XX_OTP_ARRAY_BYTES),
> +        VMSTATE_END_OF_LIST(),
> +    },
> +};
> +
> +static void npcm7xx_otp_class_init(ObjectClass *klass, void *data)
> +{
> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    QEMU_BUILD_BUG_ON(NPCM7XX_OTP_REGS_END > NPCM7XX_OTP_NR_REGS);
> +
> +    dc->realize = npcm7xx_otp_realize;
> +    dc->vmsd = &vmstate_npcm7xx_otp;
> +    rc->phases.enter = npcm7xx_otp_enter_reset;
> +}
> +
> +static void npcm7xx_key_storage_class_init(ObjectClass *klass, void *data)
> +{
> +    NPCM7xxOTPClass *oc = NPCM7XX_OTP_CLASS(klass);
> +
> +    oc->mmio_ops = &npcm7xx_key_storage_ops;
> +}

Hello,
With this series applied, when I build with --enable-sanitizers and run
./qemu-system-arm:

==373753==ERROR: AddressSanitizer: heap-buffer-overflow on address 0x61000000b400 at pc 0x557496abbefc bp 0x7ffdd5851210 sp 0x7ffdd5851208
WRITE of size 8 at 0x61000000b400 thread T0
    #0 0x557496abbefb in npcm7xx_key_storage_class_init /../hw/nvram/npcm7xx_otp.c:410:18
    #1 0x5574998a8780 in type_initialize /../qom/object.c:362:9
    #2 0x5574998a9bef in object_class_foreach_tramp /../qom/object.c:1030:5
    #3 0x7fc26b427b2f in g_hash_table_foreach (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x3eb2f)
    #4 0x5574998a9a41 in object_class_foreach /../qom/object.c:1052:5
    #5 0x5574998ab28a in object_class_get_list /../qom/object.c:1109:5
    #6 0x557498e6f8e1 in select_machine /../softmmu/vl.c:2438:24
    #7 0x557498e5a921 in qemu_init /../softmmu/vl.c:3842:21
    #8 0x557495b181d7 in main /../softmmu/main.c:49:5
    #9 0x7fc269e7dcc9 in __libc_start_main csu/../csu/libc-start.c:308:16
    #10 0x557495a6d9b9 in _start (/qemu-system-arm+0x35959b9)

0x61000000b400 is located 0 bytes to the right of 192-byte region [0x61000000b340,0x61000000b400)
allocated by thread T0 here:
    #0 0x557495ae6272 in calloc (/qemu-system-arm+0x360e272)
    #1 0x7fc26b43f210 in g_malloc0 (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x56210)
    #2 0x5574998a9bef in object_class_foreach_tramp /../qom/object.c:1030:5
    #3 0x7fc26b427b2f in g_hash_table_foreach (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x3eb2f)

SUMMARY: AddressSanitizer: heap-buffer-overflow /../hw/nvram/npcm7xx_otp.c:410:18 in npcm7xx_key_storage_class_init

-Alex

> +
> +static void npcm7xx_fuse_array_class_init(ObjectClass *klass, void *data)
> +{
> +    NPCM7xxOTPClass *oc = NPCM7XX_OTP_CLASS(klass);
> +
> +    oc->mmio_ops = &npcm7xx_fuse_array_ops;
> +}
> +
> +static const TypeInfo npcm7xx_otp_types[] = {
> +    {
> +        .name = TYPE_NPCM7XX_OTP,
> +        .parent = TYPE_SYS_BUS_DEVICE,
> +        .instance_size = sizeof(NPCM7xxOTPState),
> +        .class_init = npcm7xx_otp_class_init,
> +        .abstract = true,
> +    },
> +    {
> +        .name = TYPE_NPCM7XX_KEY_STORAGE,
> +        .parent = TYPE_NPCM7XX_OTP,
> +        .class_init = npcm7xx_key_storage_class_init,
> +    },
> +    {
> +        .name = TYPE_NPCM7XX_FUSE_ARRAY,
> +        .parent = TYPE_NPCM7XX_OTP,
> +        .class_init = npcm7xx_fuse_array_class_init,
> +    },
> +};
> +DEFINE_TYPES(npcm7xx_otp_types);
> diff --git a/hw/nvram/meson.build b/hw/nvram/meson.build
> index ba214558ac..1f2ed013b2 100644
> --- a/hw/nvram/meson.build
> +++ b/hw/nvram/meson.build
> @@ -4,6 +4,7 @@ softmmu_ss.add(when: 'CONFIG_DS1225Y', if_true: files('ds1225y.c'))
>  softmmu_ss.add(when: 'CONFIG_NMC93XX_EEPROM', if_true: files('eeprom93xx.c'))
>  softmmu_ss.add(when: 'CONFIG_AT24C', if_true: files('eeprom_at24c.c'))
>  softmmu_ss.add(when: 'CONFIG_MAC_NVRAM', if_true: files('mac_nvram.c'))
> +softmmu_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx_otp.c'))
>  softmmu_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_nvm.c'))
>  
>  specific_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr_nvram.c'))
> -- 
> 2.28.0.297.g1956fa8f8d-goog
> 
> 

