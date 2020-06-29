Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B081BC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 21:38:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89CED206A1
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 21:38:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89CED206A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jq1UG-0002bG-QF
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 17:38:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jq1Sf-00015a-OK; Mon, 29 Jun 2020 17:37:09 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:48090)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jq1Sd-0006Ke-BS; Mon, 29 Jun 2020 17:37:09 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 4E3A47475F9;
 Mon, 29 Jun 2020 23:37:05 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 24760746335; Mon, 29 Jun 2020 23:37:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 22EE2746331;
 Mon, 29 Jun 2020 23:37:05 +0200 (CEST)
Date: Mon, 29 Jun 2020 23:37:05 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [PATCH 2/5] hw/i2c: Rename i2c_try_create_slave() as
 i2c_slave_new()
In-Reply-To: <20200629173821.22037-3-f4bug@amsat.org>
Message-ID: <alpine.BSF.2.22.395.2006292333540.63145@zero.eik.bme.hu>
References: <20200629173821.22037-1-f4bug@amsat.org>
 <20200629173821.22037-3-f4bug@amsat.org>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-715433422-1593466625=:63145"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 17:31:52
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Corey Minyard <cminyard@mvista.com>, Andrew Jeffery <andrew@aj.id.au>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@kaod.org>,
 Jan Kiszka <jan.kiszka@web.de>, David Gibson <david@gibson.dropbear.id.au>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-715433422-1593466625=:63145
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 29 Jun 2020, Philippe Mathieu-Daudé wrote:
> We use "new" names for functions that allocate and initialize
> device objects: pci_new(), isa_new(), usb_new().
> Let's call this one i2c_slave_new(). Since we have to update
> all the callers, also let it return a I2CSlave object.

All the callers now need a cast due to change to I2CSlave * instead of 
what they expect. Does that really worth it? Also this introduces 
inconsistency between i2c_create_slave and i2c_new so not sure about that 
part but I don't really mind either way. Maybe return what most callers 
expect so the calls are simple and don't need an additional cast in most 
of the cases?

Regards,
BALATON Zoltan

> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> include/hw/i2c/i2c.h | 2 +-
> hw/arm/aspeed.c      | 4 ++--
> hw/i2c/core.c        | 9 ++++-----
> 3 files changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/include/hw/i2c/i2c.h b/include/hw/i2c/i2c.h
> index d6e3d85faf..18efc668f1 100644
> --- a/include/hw/i2c/i2c.h
> +++ b/include/hw/i2c/i2c.h
> @@ -79,8 +79,8 @@ int i2c_send_recv(I2CBus *bus, uint8_t *data, bool send);
> int i2c_send(I2CBus *bus, uint8_t data);
> uint8_t i2c_recv(I2CBus *bus);
>
> +I2CSlave *i2c_slave_new(const char *name, uint8_t addr);
> DeviceState *i2c_create_slave(I2CBus *bus, const char *name, uint8_t addr);
> -DeviceState *i2c_try_create_slave(const char *name, uint8_t addr);
> bool i2c_realize_and_unref(DeviceState *dev, I2CBus *bus, Error **errp);
>
> /* lm832x.c */
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index 1285bf82c0..54ca36e0b6 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -513,7 +513,7 @@ static void witherspoon_bmc_i2c_init(AspeedMachineState *bmc)
>     /* Bus 3: TODO bmp280@77 */
>     /* Bus 3: TODO max31785@52 */
>     /* Bus 3: TODO dps310@76 */
> -    dev = i2c_try_create_slave(TYPE_PCA9552, 0x60);
> +    dev = DEVICE(i2c_slave_new(TYPE_PCA9552, 0x60));
>     qdev_prop_set_string(dev, "description", "pca1");
>     i2c_realize_and_unref(dev, aspeed_i2c_get_bus(&soc->i2c, 3),
>                           &error_fatal);
> @@ -531,7 +531,7 @@ static void witherspoon_bmc_i2c_init(AspeedMachineState *bmc)
>
>     smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 11), 0x51,
>                           eeprom_buf);
> -    dev = i2c_try_create_slave(TYPE_PCA9552, 0x60);
> +    dev = DEVICE(i2c_slave_new(TYPE_PCA9552, 0x60));
>     qdev_prop_set_string(dev, "description", "pca0");
>     i2c_realize_and_unref(dev, aspeed_i2c_get_bus(&soc->i2c, 11),
>                           &error_fatal);
> diff --git a/hw/i2c/core.c b/hw/i2c/core.c
> index acf34a12d6..6eacb4a463 100644
> --- a/hw/i2c/core.c
> +++ b/hw/i2c/core.c
> @@ -267,13 +267,13 @@ const VMStateDescription vmstate_i2c_slave = {
>     }
> };
>
> -DeviceState *i2c_try_create_slave(const char *name, uint8_t addr)
> +I2CSlave *i2c_slave_new(const char *name, uint8_t addr)
> {
>     DeviceState *dev;
>
>     dev = qdev_new(name);
>     qdev_prop_set_uint8(dev, "address", addr);
> -    return dev;
> +    return I2C_SLAVE(dev);
> }
>
> bool i2c_realize_and_unref(DeviceState *dev, I2CBus *bus, Error **errp)
> @@ -283,10 +283,9 @@ bool i2c_realize_and_unref(DeviceState *dev, I2CBus *bus, Error **errp)
>
> DeviceState *i2c_create_slave(I2CBus *bus, const char *name, uint8_t addr)
> {
> -    DeviceState *dev;
> +    DeviceState *dev = DEVICE(i2c_slave_new(name, addr));
>
> -    dev = i2c_try_create_slave(name, addr);
> -    i2c_realize_and_unref(dev, bus, &error_fatal);
> +    i2c_realize_and_unref(I2C_SLAVE(dev), bus, &error_fatal);
>
>     return dev;
> }
>
--3866299591-715433422-1593466625=:63145--

