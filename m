Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 417BCC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 10:49:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15461206B7
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 10:49:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15461206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joluq-00068r-Db
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 06:49:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44854)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1joltw-0005RT-In; Fri, 26 Jun 2020 06:48:08 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:11632)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jolts-0002Dq-4M; Fri, 26 Jun 2020 06:48:06 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id E1B077475FA;
 Fri, 26 Jun 2020 12:47:58 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id B60E374633D; Fri, 26 Jun 2020 12:47:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B48AF745702;
 Fri, 26 Jun 2020 12:47:58 +0200 (CEST)
Date: Fri, 26 Jun 2020 12:47:58 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [RFC PATCH 1/3] hw/i2c/smbus_eeprom: Set QOM parent
In-Reply-To: <20200626102744.15053-2-f4bug@amsat.org>
Message-ID: <alpine.BSF.2.22.395.2006261240500.94870@zero.eik.bme.hu>
References: <20200626102744.15053-1-f4bug@amsat.org>
 <20200626102744.15053-2-f4bug@amsat.org>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1679641061-1593168478=:94870"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Corey Minyard <cminyard@mvista.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Markus Armbruster <armbru@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-devel@nongnu.org, Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 qemu-ppc@nongnu.org, =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@kaod.org>,
 Huacai Chen <chenhc@lemote.com>,
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1679641061-1593168478=:94870
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Fri, 26 Jun 2020, Philippe Mathieu-Daudé wrote:
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> Aspeed change pending latest ARM pull-request, so meanwhile sending
> as RFC.
> ---
> include/hw/i2c/smbus_eeprom.h |  9 ++++++---
> hw/i2c/smbus_eeprom.c         | 13 ++++++++++---
> hw/mips/fuloong2e.c           |  2 +-
> hw/ppc/sam460ex.c             |  2 +-
> 4 files changed, 18 insertions(+), 8 deletions(-)
>
> diff --git a/include/hw/i2c/smbus_eeprom.h b/include/hw/i2c/smbus_eeprom.h
> index 68b0063ab6..037612bbbb 100644
> --- a/include/hw/i2c/smbus_eeprom.h
> +++ b/include/hw/i2c/smbus_eeprom.h
> @@ -26,9 +26,12 @@
> #include "exec/cpu-common.h"
> #include "hw/i2c/i2c.h"
>
> -void smbus_eeprom_init_one(I2CBus *bus, uint8_t address, uint8_t *eeprom_buf);
> -void smbus_eeprom_init(I2CBus *bus, int nb_eeprom,
> -                       const uint8_t *eeprom_spd, int size);
> +void smbus_eeprom_init_one(Object *parent_obj, const char *child_name,
> +                           I2CBus *smbus, uint8_t address,
> +                           uint8_t *eeprom_buf);
> +void smbus_eeprom_init(Object *parent_obj, const char *child_name_prefix,
> +                       I2CBus *smbus, int nb_eeprom,
> +                       const uint8_t *eeprom_spd, int eeprom_spd_size);

Keeping I2CBus *smbus and uint8_t address as first parameters before 
parent_obj and name looks better to me. These functions still operate on 
an I2Cbus so could be regarded as methods of I2CBus therefore first 
parameter should be that.

Regards,
BALATON Zoltan

> enum sdram_type { SDR = 0x4, DDR = 0x7, DDR2 = 0x8 };
> uint8_t *spd_data_generate(enum sdram_type type, ram_addr_t size);
> diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
> index b7def9eeb8..879fd7c416 100644
> --- a/hw/i2c/smbus_eeprom.c
> +++ b/hw/i2c/smbus_eeprom.c
> @@ -165,7 +165,9 @@ static void smbus_eeprom_register_types(void)
>
> type_init(smbus_eeprom_register_types)
>
> -void smbus_eeprom_init_one(I2CBus *smbus, uint8_t address, uint8_t *eeprom_buf)
> +void smbus_eeprom_init_one(Object *parent_obj, const char *child_name,
> +                           I2CBus *smbus, uint8_t address,
> +                           uint8_t *eeprom_buf)
> {
>     DeviceState *dev;
>
> @@ -173,10 +175,12 @@ void smbus_eeprom_init_one(I2CBus *smbus, uint8_t address, uint8_t *eeprom_buf)
>     qdev_prop_set_uint8(dev, "address", address);
>     /* FIXME: use an array of byte or block backend property? */
>     SMBUS_EEPROM(dev)->init_data = eeprom_buf;
> +    object_property_add_child(parent_obj, child_name, OBJECT(dev));
>     qdev_realize_and_unref(dev, (BusState *)smbus, &error_fatal);
> }
>
> -void smbus_eeprom_init(I2CBus *smbus, int nb_eeprom,
> +void smbus_eeprom_init(Object *parent_obj, const char *child_name_prefix,
> +                       I2CBus *smbus, int nb_eeprom,
>                        const uint8_t *eeprom_spd, int eeprom_spd_size)
> {
>     int i;
> @@ -189,8 +193,11 @@ void smbus_eeprom_init(I2CBus *smbus, int nb_eeprom,
>     }
>
>     for (i = 0; i < nb_eeprom; i++) {
> -        smbus_eeprom_init_one(smbus, 0x50 + i,
> +        char *name = g_strdup_printf("%s-%d", child_name_prefix, i);
> +
> +        smbus_eeprom_init_one(parent_obj, name, smbus, 0x50 + i,
>                               eeprom_buf + (i * SMBUS_EEPROM_SIZE));
> +        g_free(name);
>     }
> }
>
> diff --git a/hw/mips/fuloong2e.c b/hw/mips/fuloong2e.c
> index 8ca31e5162..304a096c6a 100644
> --- a/hw/mips/fuloong2e.c
> +++ b/hw/mips/fuloong2e.c
> @@ -377,7 +377,7 @@ static void mips_fuloong2e_init(MachineState *machine)
>
>     /* Populate SPD eeprom data */
>     spd_data = spd_data_generate(DDR, machine->ram_size);
> -    smbus_eeprom_init_one(smbus, 0x50, spd_data);
> +    smbus_eeprom_init_one(OBJECT(machine->ram), "spd", smbus, 0x50, spd_data);
>
>     mc146818_rtc_init(isa_bus, 2000, NULL);
>
> diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
> index 1a106a68de..064d07f4e2 100644
> --- a/hw/ppc/sam460ex.c
> +++ b/hw/ppc/sam460ex.c
> @@ -337,7 +337,7 @@ static void sam460ex_init(MachineState *machine)
>     spd_data = spd_data_generate(ram_sizes[0] < 128 * MiB ? DDR : DDR2,
>                                  ram_sizes[0]);
>     spd_data[20] = 4; /* SO-DIMM module */
> -    smbus_eeprom_init_one(i2c, 0x50, spd_data);
> +    smbus_eeprom_init_one(OBJECT(machine->ram), "spd", i2c, 0x50, spd_data);
>     /* RTC */
>     i2c_create_slave(i2c, "m41t80", 0x68);
>
>
--3866299591-1679641061-1593168478=:94870--

