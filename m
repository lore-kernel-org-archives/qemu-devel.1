Received: from eggs.gnu.org ([2001:4830:134:3::10]:38276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gSPMc-0001iY-HB
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 11:40:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gSPMX-0000SO-O7
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 11:40:30 -0500
Received: from 10.mo1.mail-out.ovh.net ([178.32.96.102]:50839)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gSPMX-0000Qr-Fk
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 11:40:25 -0500
Received: from player799.ha.ovh.net (unknown [10.109.160.230])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id B30AC144EA5
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 17:40:23 +0100 (CET)
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-33-clg@kaod.org>
	<20181129041244.GH14697@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <0afb583f-4474-7e44-f291-85010bdb173c@kaod.org>
Date: Thu, 29 Nov 2018 17:40:18 +0100
MIME-Version: 1.0
In-Reply-To: <20181129041244.GH14697@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 32/36] spapr/rtas: modify
 spapr_rtas_register() to remove RTAS handlers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On 11/29/18 5:12 AM, David Gibson wrote:
> On Fri, Nov 16, 2018 at 11:57:25AM +0100, C=E9dric Le Goater wrote:
>> Removing RTAS handlers will become necessary when the new pseries
>> machine supporting multiple interrupt mode is introduced.
>=20
> I'd prefer this to be done as a separate spapr_rtas_unregister()
> helper, just to improve greppability.

ok. I should propose an inline :

static inline void spapr_rtas_unregister(int token)=20
{=20
	spapr_rtas_register(token, NULL, NULL);=20
}
 =20
>=20
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>> ---
>>  hw/ppc/spapr_rtas.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
>> index d6a0952154ac..e005d5d08151 100644
>> --- a/hw/ppc/spapr_rtas.c
>> +++ b/hw/ppc/spapr_rtas.c
>> @@ -404,7 +404,7 @@ void spapr_rtas_register(int token, const char *na=
me, spapr_rtas_fn fn)
>> =20
>>      token -=3D RTAS_TOKEN_BASE;
>> =20
>> -    assert(!rtas_table[token].name);
>> +    assert(!name || !rtas_table[token].name);
>> =20
>>      rtas_table[token].name =3D name;
>>      rtas_table[token].fn =3D fn;
>=20
