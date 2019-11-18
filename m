Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B1AC432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 07:45:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E7A520409
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 07:45:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E7A520409
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWbiu-0002nU-Eh
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 02:45:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45366)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iWbi2-0002F4-6c
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 02:44:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iWbi0-0002gL-NL
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 02:44:29 -0500
Received: from 17.mo3.mail-out.ovh.net ([87.98.178.58]:54274)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iWbi0-0002av-0A
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 02:44:28 -0500
Received: from player761.ha.ovh.net (unknown [10.109.159.90])
 by mo3.mail-out.ovh.net (Postfix) with ESMTP id 8D4E1231B40
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 08:44:18 +0100 (CET)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player761.ha.ovh.net (Postfix) with ESMTPSA id B8EAAC38F7E0;
 Mon, 18 Nov 2019 07:44:12 +0000 (UTC)
Subject: Re: [PATCH 5/5] aspeed: Add support for the tacoma-bmc board
To: Joel Stanley <joel@jms.id.au>
References: <20191114094544.30114-1-clg@kaod.org>
 <20191114094544.30114-6-clg@kaod.org>
 <CACPK8Xf7d7HOiVK=A9SZS32iZyJt5hC-JD4q9DrqvoT4yK88dg@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <9fb0d938-ec38-3955-394a-9ba4e6e236e7@kaod.org>
Date: Mon, 18 Nov 2019 08:44:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CACPK8Xf7d7HOiVK=A9SZS32iZyJt5hC-JD4q9DrqvoT4yK88dg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 5463429298909514560
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudeggedgudduvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjqdffgfeufgfipdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdeltddrjeeirdehtddrvddvfeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeeiuddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 87.98.178.58
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
Cc: Andrew Jeffery <andrew@aj.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18/11/2019 08:18, Joel Stanley wrote:
> On Thu, 14 Nov 2019 at 09:46, C=C3=A9dric Le Goater <clg@kaod.org> wrot=
e:
>>
>> The Tacoma BMC board is replacement board for the BMC of the OpenPOWER
>> Witherspoon system. It uses a AST2600 SoC instead of a AST2500 and is
>> used for HW bringup.
>>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> ---
>>  hw/arm/aspeed.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++=
+
>>  1 file changed, 52 insertions(+)
>>
>> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
>> index e34e6787430b..729f2e79cd79 100644
>> --- a/hw/arm/aspeed.c
>> +++ b/hw/arm/aspeed.c
>> @@ -92,6 +92,10 @@ struct AspeedBoardState {
>>  #define AST2600_EVB_HW_STRAP1 0x000000C0
>>  #define AST2600_EVB_HW_STRAP2 0x00000003
>>
>> +/* Tacoma hardware value */
>> +#define TACOMA_BMC_HW_STRAP1  0x00000000
>> +#define TACOMA_BMC_HW_STRAP2  0x00000000
>> +
>>  /*
>>   * The max ram region is for firmwares that scan the address space
>>   * with load/store to guess how much RAM the SoC has.
>> @@ -167,6 +171,34 @@ static void aspeed_board_init_flashes(AspeedSMCSt=
ate *s, const char *flashtype,
>>      }
>>  }
>>
>> +static void tacoma_bmc_i2c_init(AspeedBoardState *bmc)
>=20
> This should be identical to witherspoon. Do you want to use the same ca=
llback?

You are right. The tacoma board should use the same callback.

Thanks,

C.=20

> Either way,
>=20
> Reviewed-by: Joel Stanley <joel@jms.id.au>
>=20
>=20
>> +{
>> +    AspeedSoCState *soc =3D &bmc->soc;
>> +    uint8_t *eeprom_buf =3D g_malloc0(8 * 1024);
>> +
>> +    /* Bus 3: TODO bmp280@77 */
>> +    /* Bus 3: TODO max31785@52 */
>> +    /* Bus 3: TODO dps310@76 */
>> +    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 3), "pca95=
52", 0x60);
>> +
>> +    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 4), "tmp42=
3", 0x4c);
>> +
>> +    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 5), "tmp42=
3", 0x4c);
>> +
>> +    /* The tacoma expects a TMP275 but a TMP105 is compatible */
>> +    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 9), TYPE_T=
MP105,
>> +                     0x4a);
>> +
>> +    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 11), "pca9=
552",
>> +                     0x60);
>> +    /* The tacoma expects Epson RX8900 RTC but a ds1338 is compatible=
 */
>> +    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 11), "ds13=
38",
>> +                     0x32);
>> +    smbus_eeprom_init_one(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 11), =
0x51,
>> +                          eeprom_buf);
>> +    /* Bus 11: TODO ucd90160@64 */
>> +}
>> +
>>  static void aspeed_machine_init(MachineState *machine)
>>  {
>>      AspeedBoardState *bmc;
>> @@ -485,6 +517,22 @@ static void aspeed_machine_ast2600_evb_class_init=
(ObjectClass *oc, void *data)
>>      mc->default_ram_size =3D 1 * GiB;
>>  };
>>
>> +static void aspeed_machine_tacoma_class_init(ObjectClass *oc, void *d=
ata)
>> +{
>> +    MachineClass *mc =3D MACHINE_CLASS(oc);
>> +    AspeedMachineClass *amc =3D ASPEED_MACHINE_CLASS(oc);
>> +
>> +    mc->desc       =3D "Aspeed AST2600 EVB (Cortex A7)";
>> +    amc->soc_name  =3D "ast2600-a0";
>> +    amc->hw_strap1 =3D TACOMA_BMC_HW_STRAP1;
>> +    amc->hw_strap2 =3D TACOMA_BMC_HW_STRAP2;
>> +    amc->fmc_model =3D "mx66l1g45g";
>> +    amc->spi_model =3D "mx66l1g45g";
>> +    amc->num_cs    =3D 2;
>> +    amc->i2c_init  =3D tacoma_bmc_i2c_init;
>> +    mc->default_ram_size =3D 1 * GiB;
>> +};
>> +
>>  static const TypeInfo aspeed_machine_types[] =3D {
>>      {
>>          .name          =3D MACHINE_TYPE_NAME("palmetto-bmc"),
>> @@ -510,6 +558,10 @@ static const TypeInfo aspeed_machine_types[] =3D =
{
>>          .name          =3D MACHINE_TYPE_NAME("ast2600-evb"),
>>          .parent        =3D TYPE_ASPEED_MACHINE,
>>          .class_init    =3D aspeed_machine_ast2600_evb_class_init,
>> +    }, {
>> +        .name          =3D MACHINE_TYPE_NAME("tacoma-bmc"),
>> +        .parent        =3D TYPE_ASPEED_MACHINE,
>> +        .class_init    =3D aspeed_machine_tacoma_class_init,
>>      }, {
>>          .name          =3D TYPE_ASPEED_MACHINE,
>>          .parent        =3D TYPE_MACHINE,
>> --
>> 2.21.0
>>


