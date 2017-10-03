Received: from eggs.gnu.org ([2001:4830:134:3::10]:36586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dzJFo-0002py-AN
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 05:12:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dzJFk-0007Bm-B0
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 05:12:40 -0400
Received: from mail-it0-x243.google.com ([2607:f8b0:4001:c0b::243]:49262)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1dzJFk-00079j-1p
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 05:12:36 -0400
Received: by mail-it0-x243.google.com with SMTP id c195so10871110itb.4
	for <qemu-devel@nongnu.org>; Tue, 03 Oct 2017 02:12:35 -0700 (PDT)
References: <150659494872.25889.2069124544245723984.stgit@aravinda>
	<150659505839.25889.2018054058894535368.stgit@aravinda>
	<20170929061735.GD7712@umbus.fritz.box>
	<87y3oxen7t.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<95142cc0-518a-b7b7-4e56-cfc2adca36ba@ozlabs.ru>
	<20171003060757.GF3260@umbus.fritz.box>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <4d649456-1242-febe-06bd-35bb01e3982b@ozlabs.ru>
Date: Tue, 3 Oct 2017 20:12:29 +1100
MIME-Version: 1.0
In-Reply-To: <20171003060757.GF3260@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="SV3pWiEt0n2tRjpMpvAuGTW5cTBenQPOJ"
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v5 1/6] ppc: spapr: Register and
 handle HCALL to receive updated RTAS region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Aravinda Prasad <aravinda@linux.vnet.ibm.com>, benh@au1.ibm.com, mahesh@linux.vnet.ibm.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, paulus@samba.org, sam.bobroff@au1.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SV3pWiEt0n2tRjpMpvAuGTW5cTBenQPOJ
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>,
 Aravinda Prasad <aravinda@linux.vnet.ibm.com>, benh@au1.ibm.com,
 mahesh@linux.vnet.ibm.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 paulus@samba.org, sam.bobroff@au1.ibm.com
Message-ID: <4d649456-1242-febe-06bd-35bb01e3982b@ozlabs.ru>
Subject: Re: [Qemu-ppc] [PATCH v5 1/6] ppc: spapr: Register and handle HCALL
 to receive updated RTAS region
References: <150659494872.25889.2069124544245723984.stgit@aravinda>
 <150659505839.25889.2018054058894535368.stgit@aravinda>
 <20170929061735.GD7712@umbus.fritz.box>
 <87y3oxen7t.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
 <95142cc0-518a-b7b7-4e56-cfc2adca36ba@ozlabs.ru>
 <20171003060757.GF3260@umbus.fritz.box>
In-Reply-To: <20171003060757.GF3260@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/10/17 17:07, David Gibson wrote:
> On Mon, Oct 02, 2017 at 02:02:19PM +1100, Alexey Kardashevskiy wrote:
>> On 29/09/17 21:52, Nikunj A Dadhania wrote:
>>> David Gibson <david@gibson.dropbear.id.au> writes:
>>>
>>>> On Thu, Sep 28, 2017 at 04:07:38PM +0530, Aravinda Prasad wrote:
>>>>> Receive updates from SLOF about the updated rtas-base.
>>>>> A separate patch for SLOF [1] (commit f9a60de3) adds
>>>>> functionality to invoke a private HCALL whenever OS
>>>>> issues instantiate-rtas with a new rtas-base.
>>>>>
>>>>> This is required as QEMU needs to know the updated rtas-base
>>>>> as it allocates error reporting structure in RTAS space upon
>>>>> a machine check exception.
>>>>>
>>>>> [1] https://lists.ozlabs.org/pipermail/linuxppc-dev/2014-August/120=
386.html
>>>>>
>>>>> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
>>>>> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
>>>>
>>>> Ao I acked this earlier, but I've now realized there might be some
>>>> connection between this and discussions taking place elsewhere about=

>>>> qemu not knowing what SLOF does with the device tree.
>>>>
>>>> At what point will SLOF call the UPDATE_RTAS hcall?  I'm guessing at=

>>>> the time of instantiate-rtas, is that right?
>>>
>>> The call happens from
>>> arch/powerpc/kernel/prom_init.c:prom_instantiate_rtas() and after tha=
t
>>> linux kernel makes two entries in the DT
>>>
>>> ....
>>>        if (call_prom_ret("call-method", 3, 2, &entry,
>>>                           ADDR("instantiate-rtas"),
>>>                           rtas_inst, base) !=3D 0
>>>             || entry =3D=3D 0) {
>>>                 prom_printf(" failed\n");
>>>                 return;
>>>         }
>>>         prom_printf(" done\n");
>>>
>>>         reserve_mem(base, size);
>>>
>>>         val =3D cpu_to_be32(base);
>>>         prom_setprop(rtas_node, "/rtas", "linux,rtas-base",
>>>                      &val, sizeof(val));
>>>         val =3D cpu_to_be32(entry);
>>>         prom_setprop(rtas_node, "/rtas", "linux,rtas-entry",
>>>                      &val, sizeof(val));
>>> ....
>>>
>>> Quiesce is called after this.=20
>>>
>>>> Does SLOF put the RTAS blob address in its internal device tree, or
>>>> does it only pass it to the guest via the return parameters from
>>>> instantiate-rtas?
>>>
>>> Entry was made to the DT by linux kernel prom_init code, will this be=

>>> visible to QEMU?
>>
>> With my recent SLOF FDT patch - yes:
>>
>> aik@fstn1-p1:~$ grep rtas dbg.dts
>> 	rtas {
>> 		linux,rtas-entry =3D <0x2fff0000>;
>> 		linux,rtas-base =3D <0x2fff0000>;
>> [...]
>=20
> Ah.. except.. isn't that relying on the kernel putting the RTAS
> address into the device tree before it calls quiesce and kills SLOF?
>=20
> The SLOF image is bundled in with qemu, so it's ok for us to rely on
> its behaviour up to a point.  It's not really ok for us to rely on the
> kernel's behaviour here, unless that behaviour is mandated by PAPR,
> which this isn't.

Fair point.

> So, I think we either need to have *SLOF* update the device tree with
> that address at instantiate-rtas time,

I can do that, in a separate patch.

> or we'll need to resurrect
> Aravinda's original UPDATE_RTAS hcall.





--=20
Alexey


--SV3pWiEt0n2tRjpMpvAuGTW5cTBenQPOJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIrBAEBCAAVBQJZ01R9DhxhaWtAb3psYWJzLnJ1AAoJEIYTPdgrwSC5xb0QALtC
dScqqafDEtUGnmXkQndXSFlmUEgmNL+qB21GNvHBQEuNR0jEKmp8WMItebW0bSe3
dPqcMUjlPVVKCW/L/PSeF3aVWY2ef0iETddV9WHtpkzucgzv+v/NbWsf0kejrRnQ
npi4e6KOisrsupuzbFEiiTsBiFWmsD/JYk6B3kqCfTCN1+KPRlBCiH9KGS7iryko
yUZqyHp09LYka6b3JI6Pcad58pxI2yDb3VN2v4WQGoVq7SIZWVYjrxteG5DTM5ho
OKlK/sZtafdDlczASJ52/F2CxcI999RMDlQbKc8cRh6eV3R4SPzxZCljsOZUSYk2
qa/PqXgny7JVQz3J1DB/mSCIJK2IKBgOjJz2om6VCYtvC6DFkgBy683/MJXWIkh+
2f5DB5tYrbz6gp+9nXUdwbQOc0zgCjzCaZXm8ZxA1I2MmpwkMq84idsWcT1E0eWa
tqMaI9gkyYMIbgaMtSooKC//tDTme4VHQehLjr3ZBAr6T2yo3tA8B4E1LrtHBmaO
lVVUpiMDItWT2ghue1YAEJWDnoc2GfvTpxsSVb0BTWZfz83UO1iIMFS4MNB6Vif0
n6/VafiMZezLwrKj9JIQ/LM9/9wnkz5s27TLDk7SCY2RblupaTnTuaEHwwfWmjiZ
6e4g9WL48GnuRmyH+PPWdPKDk9q7zLBYLb6Z/W/G
=qZXH
-----END PGP SIGNATURE-----

--SV3pWiEt0n2tRjpMpvAuGTW5cTBenQPOJ--
