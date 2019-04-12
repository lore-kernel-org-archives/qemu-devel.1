Received: from eggs.gnu.org ([209.51.188.92]:34112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hEnvz-0003Pk-JL
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 00:37:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hEnvy-00075a-A3
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 00:37:03 -0400
Received: from 2.mo3.mail-out.ovh.net ([46.105.75.36]:48950)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1hEnvx-00073J-Vj
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 00:37:02 -0400
Received: from player799.ha.ovh.net (unknown [10.109.159.68])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 76B0F2070BE
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 06:36:59 +0200 (CEST)
References: <20190411161013.4514-1-clg@kaod.org>
	<20190411161013.4514-3-clg@kaod.org>
	<CACPK8XezRXPFFiiK7_xXLs-ipnfw9400E1dSRHN0XnF2cc4=vA@mail.gmail.com>
	<c007d615-4dbf-4525-9fb0-6e4feb28c344@www.fastmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <e9c90082-5312-5707-539b-3ab3c2e7d885@kaod.org>
Date: Fri, 12 Apr 2019 06:36:48 +0200
MIME-Version: 1.0
In-Reply-To: <c007d615-4dbf-4525-9fb0-6e4feb28c344@www.fastmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/3] aspeed: add a per SoC mapping for the
 memory space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 4/12/19 5:24 AM, Andrew Jeffery wrote:
>=20
>=20
> On Fri, 12 Apr 2019, at 11:48, Joel Stanley wrote:
>> On Thu, 11 Apr 2019 at 16:10, C=C3=A9dric Le Goater <clg@kaod.org> wro=
te:
>>>
>>> This will simplify the definition of new SoCs, like the AST2600 which
>>> should use a slightly different address space and have a different se=
t
>>> of controllers.
>>>
>>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>>
>>> diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
>>> index 5bbd1fb87d18..9b601709e93c 100644
>>> --- a/hw/arm/aspeed_soc.c
>>> +++ b/hw/arm/aspeed_soc.c
>>
>>> +static const hwaddr aspeed_soc_ast2400_memmap[] =3D {
>>
>>> +static const hwaddr aspeed_soc_ast2500_memmap[] =3D {
>>
>> Most of these arrays is common. And some of it will stay common in the
>> 2600. Any ideas how we could avoid duplication?
>=20
> I dunno, I feel that any attempt to create some "common" layout concept=
 is
> more distracting than having soc-specific, complete layouts described.

yes. I rather duplicate some values and see in one glance the full=20
address space.

Thanks,

C.
 =20
>=20
> There's no reason why they're common beyond coincidence (i.e. it's at
> ASPEED's whim). I think this is fine.
>=20
> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
>=20
>>
>> This is fine for now.
>>
>> Reviewed-by: Joel Stanley <joel@jms.id.au>
>>
