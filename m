Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 145ABC33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 07:59:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF41920748
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 07:59:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF41920748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isMXG-0002Bj-Sa
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 02:59:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36513)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1isMUw-0006X3-Su
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 02:56:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1isMUv-00075N-D0
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 02:56:54 -0500
Received: from 5.mo68.mail-out.ovh.net ([46.105.62.179]:57330)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1isMUv-0006zo-7I
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 02:56:53 -0500
Received: from player778.ha.ovh.net (unknown [10.109.143.146])
 by mo68.mail-out.ovh.net (Postfix) with ESMTP id 1F4A41568FC
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 08:56:43 +0100 (CET)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player778.ha.ovh.net (Postfix) with ESMTPSA id 32447E55C351;
 Fri, 17 Jan 2020 07:56:37 +0000 (UTC)
Subject: Re: [PATCH v2 08/86] arm:aspeed: actually check RAM size
To: Igor Mammedov <imammedo@redhat.com>
References: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
 <1579100861-73692-9-git-send-email-imammedo@redhat.com>
 <83481ccb-38e4-d0a2-18b5-66fcd7248521@kaod.org>
 <20200116183538.2f84604c@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <a2b7c17a-1f09-3272-d327-aff9688fdacb@kaod.org>
Date: Fri, 17 Jan 2020 08:56:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200116183538.2f84604c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 7546625603812953043
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrtdeigddutdelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrdeigedrvdehtddrudejtdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeejkedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.62.179
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
Cc: andrew@aj.id.au, peter.maydell@linaro.org, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, joel@jms.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/16/20 6:35 PM, Igor Mammedov wrote:
> On Thu, 16 Jan 2020 09:41:03 +0100
> C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>=20
>> On 1/15/20 4:06 PM, Igor Mammedov wrote:
>>> It's supposed that SOC will check if "-m" provided
>>> RAM size is valid by setting "ram-size" property and
>>> then board would read back valid (possibly corrected
>>> value) to map RAM MemoryReging with valid size.
>>> Well it isn't doing so, since check is called only
>>> indirectly from
>>>   aspeed_sdmc_reset()->asc->compute_conf()
>>> or much later when guest writes to configuration
>>> register.
>>>
>>> So depending on "-m" value QEMU end-ups with a warning
>>> and an invalid MemoryRegion size allocated and mapped.
>>> (examples:
>>>  -M ast2500-evb -m 1M
>>>     0000000080000000-000000017ffffffe (prio 0, i/o): aspeed-ram-conta=
iner
>>>       0000000080000000-00000000800fffff (prio 0, ram): ram
>>>       0000000080100000-00000000bfffffff (prio 0, i/o): max_ram
>>>  -M ast2500-evb -m 3G
>>>     0000000080000000-000000017ffffffe (prio 0, i/o): aspeed-ram-conta=
iner
>>>       0000000080000000-000000013fffffff (prio 0, ram): ram
>>>       [DETECTED OVERFLOW!] 0000000140000000-00000000bfffffff (prio 0,=
 i/o): max_ram
>>> )
>>> On top of that sdmc falls back and reports to guest
>>> "default" size, it thinks machine should have.>
>>> I don't know how hardware is supposed to work so
>>> I've kept it as is. =20
>>
>> The HW is hardwired and the modeling is trying to accommodate with
>> the '-m' option, the machine definition and the SDRAM controller
>> limits and register definitions for a given SoC. The result is not=20
>> that good it seems :/=20
>>
>>> But as for CLI side machine should honor whatever
>>> user configured or error out to make user fix CLI.
>>>
>>> This patch makes ram-size check actually work and
>>> changes behavior from a warning later on during
>>> machine reset to error_fatal at the moment SOC is
>>> realized so user will have to fix RAM size on CLI
>>> to start machine. =20
>>
>> commit 8e00d1a97d1d ("aspeed/sdmc: Introduce an object class per SoC")=
=20
>> moved some calls from the realize handler to reset handler and it
>> broke the checks on the RAM size.
>>
>> I think we should introduce get/set handlers on the "ram-size" propert=
y
>> that would look for a matching size in an AspeedSDMCClass array of val=
id
>> RAM sizes. The default size of the machine would be a valid default an=
d
>> bogus user defined sizes would be fatal to QEMU. =20
>=20
> That's what I'm after, i.e. board either accepts user asked size or exi=
ts
> with error.=20

We should be able to catch bogus values with :

    object_property_set_uint(OBJECT(&bmc->soc), ram_size, "ram-size",
                             &error_abort);

in aspeed_machine_init() and let QEMU exit.

> So as far as there aren't any fix-ups it should work for
> the purpose of this series
>
>>
>> We could get rid of the code :
>>
>>     /* use a common default */
>>     warn_report("Invalid RAM size 0x%" PRIx64 ". Using default 512M",
>>                 s->ram_size);
>>     s->ram_size =3D 512 << 20;
>>     return ASPEED_SDMC_AST2500_512MB;
>>
>>
>> 'max_ram_size' would be the last entry of the AspeedSDMCClass array
>> and, anyhow, we need to check bmc->max_ram is really needed. I am not=20
>> sure anymore.=20
>=20
> I'll rework aspeed parts taking in account feedback.

OK. We will give them a try. I don't think you have to bother with=20
bmc->max_ram for the moment. It doesn't seem to be in your way.=20

Thanks,

C.=20

>>> It also gets out of the way mutable ram-size logic,
>>> so we could consolidate RAM allocation logic around
>>> pre-allocated hostmem backend (supplied by user or
>>> auto created by generic machine code depending on
>>> supplied -m/mem-path/mem-prealloc options.
>>>
>>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>>> ---
>>> CC: clg@kaod.org
>>> CC: peter.maydell@linaro.org
>>> CC: andrew@aj.id.au
>>> CC: joel@jms.id.au
>>> CC: qemu-arm@nongnu.org
>>> ---
>>>  hw/arm/aspeed.c       | 9 +--------
>>>  hw/misc/aspeed_sdmc.c | 5 +++++
>>>  2 files changed, 6 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
>>> index cc06af4..525c547 100644
>>> --- a/hw/arm/aspeed.c
>>> +++ b/hw/arm/aspeed.c
>>> @@ -213,14 +213,7 @@ static void aspeed_machine_init(MachineState *ma=
chine)
>>>                                  "hw-prot-key", &error_abort);
>>>      }
>>>      object_property_set_bool(OBJECT(&bmc->soc), true, "realized",
>>> -                             &error_abort);
>>> -
>>> -    /*
>>> -     * Allocate RAM after the memory controller has checked the size
>>> -     * was valid. If not, a default value is used.
>>> -     */
>>> -    ram_size =3D object_property_get_uint(OBJECT(&bmc->soc), "ram-si=
ze",
>>> -                                        &error_abort);
>>> +                             &error_fatal);
>>> =20
>>>      memory_region_allocate_system_memory(&bmc->ram, NULL, "ram", ram=
_size);
>>>      memory_region_add_subregion(&bmc->ram_container, 0, &bmc->ram);
>>> diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
>>> index 3fc80f0..b398e36 100644
>>> --- a/hw/misc/aspeed_sdmc.c
>>> +++ b/hw/misc/aspeed_sdmc.c
>>> @@ -165,6 +165,11 @@ static void aspeed_sdmc_realize(DeviceState *dev=
, Error **errp)
>>>      AspeedSDMCState *s =3D ASPEED_SDMC(dev);
>>>      AspeedSDMCClass *asc =3D ASPEED_SDMC_GET_CLASS(s);
>>> =20
>>> +    if (!g_hash_table_contains(asc->ram2feat,
>>> +                               GINT_TO_POINTER(s->ram_size >> 20))) =
{
>>> +        error_setg(errp, "Invalid RAM size 0x%" PRIx64, s->ram_size)=
;
>>> +        return;
>>> +    }
>>>      s->max_ram_size =3D asc->max_ram_size;
>>> =20
>>>      memory_region_init_io(&s->iomem, OBJECT(s), &aspeed_sdmc_ops, s,
>>>  =20
>>
>>
>=20


