Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57DFC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 09:38:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA1CF206A1
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 09:38:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V/t59am9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA1CF206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqCj5-0001ur-06
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 05:38:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50402)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jqCiJ-0000q0-3f
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 05:38:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49496
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jqCiH-0000KN-7s
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 05:38:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593509880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h/X4dkra4te4TNqf8Arh+j26kU0iw19IffM3irc8a3Q=;
 b=V/t59am9fi8p0nmCx5OxnbCBqf3c03xZtlZbycCNy3bvKH+lcXT3Ga8zd5qs/o93EGQvP3
 OD8doevvnfULamYqsX47W5tFO4qZcc50m1m5T+SSp4q1XVC+ZxgWOIY+1+f14zw5uVHeoW
 bQK4BOx2zLNtSq0WINQOSStvVIfJMB0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-5C-LmIbuM3WTW0fhTiiRwA-1; Tue, 30 Jun 2020 05:37:51 -0400
X-MC-Unique: 5C-LmIbuM3WTW0fhTiiRwA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 21C977BAC;
 Tue, 30 Jun 2020 09:37:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 085DA7BEDB;
 Tue, 30 Jun 2020 09:37:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 899E611384A6; Tue, 30 Jun 2020 11:37:46 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Subject: Re: [PATCH 2/5] hw/i2c: Rename i2c_try_create_slave() as
 i2c_slave_new()
References: <20200629173821.22037-1-f4bug@amsat.org>
 <20200629173821.22037-3-f4bug@amsat.org>
 <alpine.BSF.2.22.395.2006292333540.63145@zero.eik.bme.hu>
Date: Tue, 30 Jun 2020 11:37:46 +0200
In-Reply-To: <alpine.BSF.2.22.395.2006292333540.63145@zero.eik.bme.hu>
 (BALATON Zoltan's message of "Mon, 29 Jun 2020 23:37:05 +0200 (CEST)")
Message-ID: <87mu4khp1x.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 03:55:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
 Joel Stanley <joel@jms.id.au>, qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Jan Kiszka <jan.kiszka@web.de>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

BALATON Zoltan <balaton@eik.bme.hu> writes:

> On Mon, 29 Jun 2020, Philippe Mathieu-Daud=C3=A9 wrote:
>> We use "new" names for functions that allocate and initialize
>> device objects: pci_new(), isa_new(), usb_new().
>> Let's call this one i2c_slave_new(). Since we have to update
>> all the callers, also let it return a I2CSlave object.
>
> All the callers now need a cast due to change to I2CSlave * instead of

Actually, all but one; I'll mark it inline.

> what they expect. Does that really worth it? Also this introduces
> inconsistency between i2c_create_slave and i2c_new so not sure about

For what it's worth, this inconsistency is healed in PATCH 4.

> that part but I don't really mind either way. Maybe return what most
> callers expect so the calls are simple and don't need an additional
> cast in most of the cases?

I'd prefer consistency with similar FOO_new() functions for abstract
devices plugging into a FOOBus: pci_new(), isa_new(), usb_new().

> Regards,
> BALATON Zoltan
>
>> Suggested-by: Markus Armbruster <armbru@redhat.com>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
>> include/hw/i2c/i2c.h | 2 +-
>> hw/arm/aspeed.c      | 4 ++--
>> hw/i2c/core.c        | 9 ++++-----
>> 3 files changed, 7 insertions(+), 8 deletions(-)
>>
>> diff --git a/include/hw/i2c/i2c.h b/include/hw/i2c/i2c.h
>> index d6e3d85faf..18efc668f1 100644
>> --- a/include/hw/i2c/i2c.h
>> +++ b/include/hw/i2c/i2c.h
>> @@ -79,8 +79,8 @@ int i2c_send_recv(I2CBus *bus, uint8_t *data, bool sen=
d);
>> int i2c_send(I2CBus *bus, uint8_t data);
>> uint8_t i2c_recv(I2CBus *bus);
>>
>> +I2CSlave *i2c_slave_new(const char *name, uint8_t addr);
>> DeviceState *i2c_create_slave(I2CBus *bus, const char *name, uint8_t add=
r);
>> -DeviceState *i2c_try_create_slave(const char *name, uint8_t addr);
>> bool i2c_realize_and_unref(DeviceState *dev, I2CBus *bus, Error **errp);
>>
>> /* lm832x.c */
>> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
>> index 1285bf82c0..54ca36e0b6 100644
>> --- a/hw/arm/aspeed.c
>> +++ b/hw/arm/aspeed.c
>> @@ -513,7 +513,7 @@ static void witherspoon_bmc_i2c_init(AspeedMachineSt=
ate *bmc)
>>     /* Bus 3: TODO bmp280@77 */
>>     /* Bus 3: TODO max31785@52 */
>>     /* Bus 3: TODO dps310@76 */
>> -    dev =3D i2c_try_create_slave(TYPE_PCA9552, 0x60);
>> +    dev =3D DEVICE(i2c_slave_new(TYPE_PCA9552, 0x60));
>>     qdev_prop_set_string(dev, "description", "pca1");
>>     i2c_realize_and_unref(dev, aspeed_i2c_get_bus(&soc->i2c, 3),
>>                           &error_fatal);
>> @@ -531,7 +531,7 @@ static void witherspoon_bmc_i2c_init(AspeedMachineSt=
ate *bmc)
>>
>>     smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 11), 0x51,
>>                           eeprom_buf);
>> -    dev =3D i2c_try_create_slave(TYPE_PCA9552, 0x60);
>> +    dev =3D DEVICE(i2c_slave_new(TYPE_PCA9552, 0x60));
>>     qdev_prop_set_string(dev, "description", "pca0");
>>     i2c_realize_and_unref(dev, aspeed_i2c_get_bus(&soc->i2c, 11),
>>                           &error_fatal);
>> diff --git a/hw/i2c/core.c b/hw/i2c/core.c
>> index acf34a12d6..6eacb4a463 100644
>> --- a/hw/i2c/core.c
>> +++ b/hw/i2c/core.c
>> @@ -267,13 +267,13 @@ const VMStateDescription vmstate_i2c_slave =3D {
>>     }
>> };
>>
>> -DeviceState *i2c_try_create_slave(const char *name, uint8_t addr)
>> +I2CSlave *i2c_slave_new(const char *name, uint8_t addr)
>> {
>>     DeviceState *dev;
>>
>>     dev =3D qdev_new(name);
>>     qdev_prop_set_uint8(dev, "address", addr);
>> -    return dev;
>> +    return I2C_SLAVE(dev);
>> }
>>
>> bool i2c_realize_and_unref(DeviceState *dev, I2CBus *bus, Error **errp)
>> @@ -283,10 +283,9 @@ bool i2c_realize_and_unref(DeviceState *dev, I2CBus=
 *bus, Error **errp)
>>
>> DeviceState *i2c_create_slave(I2CBus *bus, const char *name, uint8_t add=
r)
>> {
>> -    DeviceState *dev;
>> +    DeviceState *dev =3D DEVICE(i2c_slave_new(name, addr));
>>
>> -    dev =3D i2c_try_create_slave(name, addr);
>> -    i2c_realize_and_unref(dev, bus, &error_fatal);
>> +    i2c_realize_and_unref(I2C_SLAVE(dev), bus, &error_fatal);
>>
>>     return dev;
>> }

Fewer casts:

   DeviceState *i2c_create_slave(I2CBus *bus, const char *name, uint8_t add=
r)
   {
        I2CSlave *dev =3D i2c_slave_new(name, addr );

        i2c_realize_and_unref(dev, bus, &error_fatal);
        return DEVICE(dev);
   }

It's all the same after PATCH 4.  You decide whether to polish the
intermediate state.

Reviewed-by: Markus Armbruster <armbru@redhat.com>


