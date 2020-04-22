Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F037C54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 14:28:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F380D2076E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 14:28:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F380D2076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRGMP-0005gB-4u
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 10:28:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59042)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jRGLg-0004f6-6d
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 10:27:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jRGLc-0007oP-VP
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 10:27:34 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:18453)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jRGLc-0007me-D1; Wed, 22 Apr 2020 10:27:32 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 2ED48746333;
 Wed, 22 Apr 2020 16:27:29 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id EFBCF74632F; Wed, 22 Apr 2020 16:27:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id EE32E746324;
 Wed, 22 Apr 2020 16:27:28 +0200 (CEST)
Date: Wed, 22 Apr 2020 16:27:28 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 2/4] smbus: Fix spd_data_generate() error API violation
In-Reply-To: <20200422134815.1584-3-armbru@redhat.com>
Message-ID: <alpine.BSF.2.22.395.2004221622140.19234@zero.eik.bme.hu>
References: <20200422134815.1584-1-armbru@redhat.com>
 <20200422134815.1584-3-armbru@redhat.com>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 10:27:29
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Received-From: 152.66.115.2
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
Cc: philmd@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 22 Apr 2020, Markus Armbruster wrote:
> The Error ** argument must be NULL, &error_abort, &error_fatal, or a
> pointer to a variable containing NULL.  Passing an argument of the
> latter kind twice without clearing it in between is wrong: if the
> first call sets an error, it no longer points to NULL for the second
> call.
>
> spd_data_generate() can pass @errp to error_setg() more than once when
> it adjusts both memory size and type.  Harmless, because no caller
> passes anything that needs adjusting.  Until the previous commit,
> sam460ex passed types that needed adjusting, but not sizes.
>
> spd_data_generate()'s contract is rather awkward:
>
>    If everything's fine, return non-null and don't set an error.
>
>    Else, if memory size or type need adjusting, return non-null and
>    set an error describing the adjustment.
>
>    Else, return null and set an error reporting why no data can be
>    generated.
>
> Its callers treat the error as a warning even when null is returned.
> They don't create the "smbus-eeprom" device then.  Suspicious.
>
> Since the previous commit, only "everything's fine" can actually
> happen.  Drop the unused code and simplify the callers.  This gets rid
> of the error API violation.

This leaves board code no chance to recover from values given by user that 
won't fit without duplicating checks that this function does. Also this 
will abort without giving meaningful errors if an invalid value does get 
through and result in a crash which is not used friendly. So I don't like 
this but if others think this is acceptable maybe at least unit test 
should be adjusted to make sure aborts cannot be triggered by user for 
values that are not usually tested during development.

Regards,
BALATON Zoltan

> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
> include/hw/i2c/smbus_eeprom.h |  2 +-
> hw/i2c/smbus_eeprom.c         | 30 ++++--------------------------
> hw/mips/mips_fulong2e.c       | 10 ++--------
> hw/ppc/sam460ex.c             | 12 +++---------
> 4 files changed, 10 insertions(+), 44 deletions(-)
>
> diff --git a/include/hw/i2c/smbus_eeprom.h b/include/hw/i2c/smbus_eeprom.h
> index 15e2151b50..68b0063ab6 100644
> --- a/include/hw/i2c/smbus_eeprom.h
> +++ b/include/hw/i2c/smbus_eeprom.h
> @@ -31,6 +31,6 @@ void smbus_eeprom_init(I2CBus *bus, int nb_eeprom,
>                        const uint8_t *eeprom_spd, int size);
>
> enum sdram_type { SDR = 0x4, DDR = 0x7, DDR2 = 0x8 };
> -uint8_t *spd_data_generate(enum sdram_type type, ram_addr_t size, Error **errp);
> +uint8_t *spd_data_generate(enum sdram_type type, ram_addr_t size);
>
> #endif
> diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
> index 5adf3b15b5..07fbbf87f1 100644
> --- a/hw/i2c/smbus_eeprom.c
> +++ b/hw/i2c/smbus_eeprom.c
> @@ -195,8 +195,7 @@ void smbus_eeprom_init(I2CBus *smbus, int nb_eeprom,
> }
>
> /* Generate SDRAM SPD EEPROM data describing a module of type and size */
> -uint8_t *spd_data_generate(enum sdram_type type, ram_addr_t ram_size,
> -                           Error **errp)
> +uint8_t *spd_data_generate(enum sdram_type type, ram_addr_t ram_size)
> {
>     uint8_t *spd;
>     uint8_t nbanks;
> @@ -222,29 +221,10 @@ uint8_t *spd_data_generate(enum sdram_type type, ram_addr_t ram_size,
>         g_assert_not_reached();
>     }
>     size = ram_size >> 20; /* work in terms of megabytes */
> -    if (size < 4) {
> -        error_setg(errp, "SDRAM size is too small");
> -        return NULL;
> -    }
>     sz_log2 = 31 - clz32(size);
>     size = 1U << sz_log2;
> -    if (ram_size > size * MiB) {
> -        error_setg(errp, "SDRAM size 0x"RAM_ADDR_FMT" is not a power of 2, "
> -                   "truncating to %u MB", ram_size, size);
> -    }
> -    if (sz_log2 < min_log2) {
> -        error_setg(errp,
> -                   "Memory size is too small for SDRAM type, adjusting type");
> -        if (size >= 32) {
> -            type = DDR;
> -            min_log2 = 5;
> -            max_log2 = 12;
> -        } else {
> -            type = SDR;
> -            min_log2 = 2;
> -            max_log2 = 9;
> -        }
> -    }
> +    assert(ram_size == size * MiB);
> +    assert(sz_log2 >= min_log2);
>
>     nbanks = 1;
>     while (sz_log2 > max_log2 && nbanks < 8) {
> @@ -252,9 +232,7 @@ uint8_t *spd_data_generate(enum sdram_type type, ram_addr_t ram_size,
>         nbanks++;
>     }
>
> -    if (size > (1ULL << sz_log2) * nbanks) {
> -        error_setg(errp, "Memory size is too big for SDRAM, truncating");
> -    }
> +    assert(size == (1ULL << sz_log2) * nbanks);
>
>     /* split to 2 banks if possible to avoid a bug in MIPS Malta firmware */
>     if (nbanks == 1 && sz_log2 > min_log2) {
> diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
> index 5040afd581..ef02d54b33 100644
> --- a/hw/mips/mips_fulong2e.c
> +++ b/hw/mips/mips_fulong2e.c
> @@ -297,7 +297,6 @@ static void mips_fulong2e_init(MachineState *machine)
>     MemoryRegion *bios = g_new(MemoryRegion, 1);
>     long bios_size;
>     uint8_t *spd_data;
> -    Error *err = NULL;
>     int64_t kernel_entry;
>     PCIBus *pci_bus;
>     ISABus *isa_bus;
> @@ -377,13 +376,8 @@ static void mips_fulong2e_init(MachineState *machine)
>     }
>
>     /* Populate SPD eeprom data */
> -    spd_data = spd_data_generate(DDR, machine->ram_size, &err);
> -    if (err) {
> -        warn_report_err(err);
> -    }
> -    if (spd_data) {
> -        smbus_eeprom_init_one(smbus, 0x50, spd_data);
> -    }
> +    spd_data = spd_data_generate(DDR, machine->ram_size);
> +    smbus_eeprom_init_one(smbus, 0x50, spd_data);
>
>     mc146818_rtc_init(isa_bus, 2000, NULL);
>
> diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
> index 1e3eaac0db..42a8c9fb7f 100644
> --- a/hw/ppc/sam460ex.c
> +++ b/hw/ppc/sam460ex.c
> @@ -292,7 +292,6 @@ static void sam460ex_init(MachineState *machine)
>     SysBusDevice *sbdev;
>     struct boot_info *boot_info;
>     uint8_t *spd_data;
> -    Error *err = NULL;
>     int success;
>
>     cpu = POWERPC_CPU(cpu_create(machine->cpu_type));
> @@ -336,14 +335,9 @@ static void sam460ex_init(MachineState *machine)
>     i2c = PPC4xx_I2C(dev)->bus;
>     /* SPD EEPROM on RAM module */
>     spd_data = spd_data_generate(ram_sizes[0] < 128 * MiB ? DDR : DDR2,
> -                                 ram_sizes[0], &err);
> -    if (err) {
> -        warn_report_err(err);
> -    }
> -    if (spd_data) {
> -        spd_data[20] = 4; /* SO-DIMM module */
> -        smbus_eeprom_init_one(i2c, 0x50, spd_data);
> -    }
> +                                 ram_sizes[0]);
> +    spd_data[20] = 4; /* SO-DIMM module */
> +    smbus_eeprom_init_one(i2c, 0x50, spd_data);
>     /* RTC */
>     i2c_create_slave(i2c, "m41t80", 0x68);
>
>

