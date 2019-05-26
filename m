Return-Path: <SRS0=5YAC=T2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B914C282E3
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 17:11:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A7D020657
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 17:11:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A7D020657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57664 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUwgc-0003ey-NW
	for qemu-devel@archiver.kernel.org; Sun, 26 May 2019 13:11:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hUwfg-00033R-Jp
	for qemu-devel@nongnu.org; Sun, 26 May 2019 13:10:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hUwfe-0001ff-G2
	for qemu-devel@nongnu.org; Sun, 26 May 2019 13:10:56 -0400
Received: from 5.mo69.mail-out.ovh.net ([46.105.43.105]:59944)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1hUwfe-0001Yb-A3
	for qemu-devel@nongnu.org; Sun, 26 May 2019 13:10:54 -0400
Received: from player711.ha.ovh.net (unknown [10.109.160.239])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id 5306859B10
	for <qemu-devel@nongnu.org>; Sun, 26 May 2019 19:10:42 +0200 (CEST)
Received: from kaod.org (lfbn-1-10649-41.w90-89.abo.wanadoo.fr [90.89.235.41])
	(Authenticated sender: clg@kaod.org)
	by player711.ha.ovh.net (Postfix) with ESMTPSA id 42796618DEAA;
	Sun, 26 May 2019 17:10:34 +0000 (UTC)
To: Keno Fischer <keno@juliacomputing.com>
References: <20190525151241.5017-1-clg@kaod.org>
	<20190525151241.5017-8-clg@kaod.org>
	<CABV8kRycd41XNP09C9mBvTEEReZzFHC3U8gOq0Krzyj+c4KNgA@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <006f96c7-05fd-ee35-b6e6-1a27504e53ea@kaod.org>
Date: Sun, 26 May 2019 19:10:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CABV8kRycd41XNP09C9mBvTEEReZzFHC3U8gOq0Krzyj+c4KNgA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 14452614156711726035
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddruddvtddgudduvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.43.105
Subject: Re: [Qemu-devel] [PATCH 07/19] aspeed: add support for multiple NICs
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Andrew Jeffery <andrew@aj.id.au>, Peter Maydell <peter.maydell@linaro.org>,
	qemu-arm@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>,
	Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26/05/2019 03:01, Keno Fischer wrote:
> Drive by comment, since I spotted this in my inbox.
> When I tried to make this change (two years ago though),
> I additionally needed the following. Unfortunately, I don't quite remem=
ber
> exactly what the issue was, but I think qemu would crash trying to crea=
te more
> than one nic.

Yes.=20

The fix was :

  http://patchwork.ozlabs.org/patch/1102295/

Thanks,

C.

> ---
>  hw/net/ftgmac100.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
> index 8127d0532dc..1318de85a4e 100644
> --- a/hw/net/ftgmac100.c
> +++ b/hw/net/ftgmac100.c
> @@ -977,7 +977,8 @@ static void ftgmac100_realize(DeviceState *dev,
> Error **errp)
>      sysbus_init_irq(sbd, &s->irq);
>      qemu_macaddr_default_if_unset(&s->conf.macaddr);
>=20
> -    s->conf.peers.ncs[0] =3D nd_table[0].netdev;
> +    char *netdev_id =3D object_property_get_str(OBJECT(dev), "netdev",=
 NULL);
> +    s->conf.peers.ncs[0] =3D qemu_find_netdev(netdev_id);
>=20
>      s->nic =3D qemu_new_nic(&net_ftgmac100_info, &s->conf,
>                            object_get_typename(OBJECT(dev)), DEVICE(dev=
)->id,
>=20
>=20
>=20
> On Sat, May 25, 2019 at 11:22 AM C=C3=A9dric Le Goater <clg@kaod.org> w=
rote:
>>
>> The Aspeed SoCs have two MACs. Extend the Aspeed model to support a
>> second NIC.
>>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> ---
>>  include/hw/arm/aspeed_soc.h |  3 ++-
>>  hw/arm/aspeed_soc.c         | 33 +++++++++++++++++++--------------
>>  2 files changed, 21 insertions(+), 15 deletions(-)
>>
>> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
>> index 7247f6da2505..e8556abf4737 100644
>> --- a/include/hw/arm/aspeed_soc.h
>> +++ b/include/hw/arm/aspeed_soc.h
>> @@ -25,6 +25,7 @@
>>  #define ASPEED_SPIS_NUM  2
>>  #define ASPEED_WDTS_NUM  3
>>  #define ASPEED_CPUS_NUM  2
>> +#define ASPEED_MACS_NUM  2
>>
>>  typedef struct AspeedSoCState {
>>      /*< private >*/
>> @@ -42,7 +43,7 @@ typedef struct AspeedSoCState {
>>      AspeedSMCState spi[ASPEED_SPIS_NUM];
>>      AspeedSDMCState sdmc;
>>      AspeedWDTState wdt[ASPEED_WDTS_NUM];
>> -    FTGMAC100State ftgmac100;
>> +    FTGMAC100State ftgmac100[ASPEED_MACS_NUM];
>>  } AspeedSoCState;
>>
>>  #define TYPE_ASPEED_SOC "aspeed-soc"
>> diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
>> index b983d5efc5d1..8cfe9e9515ed 100644
>> --- a/hw/arm/aspeed_soc.c
>> +++ b/hw/arm/aspeed_soc.c
>> @@ -229,8 +229,10 @@ static void aspeed_soc_init(Object *obj)
>>                                      sc->info->silicon_rev);
>>      }
>>
>> -    sysbus_init_child_obj(obj, "ftgmac100", OBJECT(&s->ftgmac100),
>> -                          sizeof(s->ftgmac100), TYPE_FTGMAC100);
>> +    for (i =3D 0; i < ASPEED_MACS_NUM; i++) {
>> +        sysbus_init_child_obj(obj, "ftgmac100[*]", OBJECT(&s->ftgmac1=
00[i]),
>> +                              sizeof(s->ftgmac100[i]), TYPE_FTGMAC100=
);
>> +    }
>>  }
>>
>>  static void aspeed_soc_realize(DeviceState *dev, Error **errp)
>> @@ -371,19 +373,22 @@ static void aspeed_soc_realize(DeviceState *dev,=
 Error **errp)
>>      }
>>
>>      /* Net */
>> -    qdev_set_nic_properties(DEVICE(&s->ftgmac100), &nd_table[0]);
>> -    object_property_set_bool(OBJECT(&s->ftgmac100), true, "aspeed", &=
err);
>> -    object_property_set_bool(OBJECT(&s->ftgmac100), true, "realized",
>> -                             &local_err);
>> -    error_propagate(&err, local_err);
>> -    if (err) {
>> -        error_propagate(errp, err);
>> -        return;
>> +    for (i =3D 0; i < nb_nics; i++) {
>> +        qdev_set_nic_properties(DEVICE(&s->ftgmac100[i]), &nd_table[i=
]);
>> +        object_property_set_bool(OBJECT(&s->ftgmac100[i]), true, "asp=
eed",
>> +                                 &err);
>> +        object_property_set_bool(OBJECT(&s->ftgmac100[i]), true, "rea=
lized",
>> +                                 &local_err);
>> +        error_propagate(&err, local_err);
>> +        if (err) {
>> +            error_propagate(errp, err);
>> +           return;
>> +        }
>> +        sysbus_mmio_map(SYS_BUS_DEVICE(&s->ftgmac100[i]), 0,
>> +                        sc->info->memmap[ASPEED_ETH1 + i]);
>> +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->ftgmac100[i]), 0,
>> +                           aspeed_soc_get_irq(s, ASPEED_ETH1 + i));
>>      }
>> -    sysbus_mmio_map(SYS_BUS_DEVICE(&s->ftgmac100), 0,
>> -                    sc->info->memmap[ASPEED_ETH1]);
>> -    sysbus_connect_irq(SYS_BUS_DEVICE(&s->ftgmac100), 0,
>> -                       aspeed_soc_get_irq(s, ASPEED_ETH1));
>>  }
>>
>>  static void aspeed_soc_class_init(ObjectClass *oc, void *data)
>> --
>> 2.20.1
>>
>>


