Received: from eggs.gnu.org ([208.118.235.92]:40647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <roman.kapl@sysgo.com>) id 1gfMv4-0002Ct-NP
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 05:41:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <roman.kapl@sysgo.com>) id 1gfMv2-0002F6-2q
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 05:41:38 -0500
References: <CALvuzg43uSodseEHjNaRcPFBKKPTY2mcppUbYgiLL=QO9RxX_Q@mail.gmail.com>
	<e62bbdda-2ab9-b9a1-7843-0a3a40f56282@vivier.eu>
From: Roman Kapl <roman.kapl@sysgo.com>
Message-ID: <4cfad0f8-1b66-b6be-693e-ba439e81f171@sysgo.com>
Date: Fri, 4 Jan 2019 11:41:33 +0100
MIME-Version: 1.0
In-Reply-To: <e62bbdda-2ab9-b9a1-7843-0a3a40f56282@vivier.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-trivial] ppc: e6500 registers SPR 604 twice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, Jon Diekema <jon.diekema@gmail.com>
Cc: qemu-trivial@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Roman Kapl <rka@sysgo.com>

> Le 25/12/2018 =C3=A0 10:50, Jon Diekema a =C3=A9crit=C2=A0:
>>  From f399f28441e0aa79458d68996038ca3606fcb699 Mon Sep 17 00:00:00 200=
1
>> From: Jon Diekema <jon.diekema@ge.com <mailto:jon.diekema@ge.com>>
>> Date: Tue, 25 Dec 2018 04:36:06 -0500
>> Subject: ppc: e6500 registers SPR 604 twice
>>
>> When using the e6500 CPU, QEMU generates a fatal error after
>> complaining about registering SPR 604 twice.
>>
>>
>> diff --git a/target/ppc/translate_init.inc.c
>> b/target/ppc/translate_init.inc.c
>> index 03f1d34a97..c971a5faf7 100644
>> --- a/target/ppc/translate_init.inc.c
>> +++ b/target/ppc/translate_init.inc.c
>> @@ -4947,14 +4947,6 @@ static void init_proc_e500(CPUPPCState *env, in=
t
>> version)
>>  =C2=A0 =C2=A0 =C2=A0}
>>  =20
>>  =C2=A0 =C2=A0 =C2=A0if (version =3D=3D fsl_e6500) {
>> -=C2=A0 =C2=A0 =C2=A0 =C2=A0 spr_register(env, SPR_BOOKE_SPRG8, "SPRG8=
",
>> -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0SPR_NOACCESS, SPR_NOACCESS,
>> -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0&spr_read_generic, &spr_write_generic,
>> -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A00x00000000);
>> -=C2=A0 =C2=A0 =C2=A0 =C2=A0 spr_register(env, SPR_BOOKE_SPRG9, "SPRG9=
",
>> -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0SPR_NOACCESS, SPR_NOACCESS,
>> -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0&spr_read_generic, &spr_write_generic,
>> -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A00x00000000);
>>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Thread identification */
>>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0spr_register(env, SPR_TIR, "TIR",
>>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 SPR_NOACCESS, SPR_NOACCESS,
>> --=20
>> 2.20.1.3.gf17a2b179
>>
>=20
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> Tested-by: Laurent Vivier <laurent@vivier.eu>
>=20

Thanks Jon, I did not test with e6500. The patch fixes the issue &=20
debugging still works on e5500.

Roman Kapl
