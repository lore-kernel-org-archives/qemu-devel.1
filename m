Received: from eggs.gnu.org ([2001:4830:134:3::10]:46528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dzaQ3-0002RI-NQ
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 23:32:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dzaQ0-0006NT-KO
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 23:32:23 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:36143)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1dzaQ0-0006M3-7Q
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 23:32:20 -0400
Received: by mail-pf0-x242.google.com with SMTP id f84so11084592pfj.3
	for <qemu-devel@nongnu.org>; Tue, 03 Oct 2017 20:32:19 -0700 (PDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
References: <150659494872.25889.2069124544245723984.stgit@aravinda>
	<150659505839.25889.2018054058894535368.stgit@aravinda>
	<20170929061735.GD7712@umbus.fritz.box>
	<87y3oxen7t.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<95142cc0-518a-b7b7-4e56-cfc2adca36ba@ozlabs.ru>
	<20171003060757.GF3260@umbus.fritz.box>
	<4d649456-1242-febe-06bd-35bb01e3982b@ozlabs.ru>
Message-ID: <8fa746ca-302f-b2bf-ee05-a4b0b4f2fcbb@ozlabs.ru>
Date: Wed, 4 Oct 2017 14:32:11 +1100
MIME-Version: 1.0
In-Reply-To: <4d649456-1242-febe-06bd-35bb01e3982b@ozlabs.ru>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8TtbvdeT1GpFO0vkKPcetQspwviI20Hci"
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
--8TtbvdeT1GpFO0vkKPcetQspwviI20Hci
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>,
 Aravinda Prasad <aravinda@linux.vnet.ibm.com>, benh@au1.ibm.com,
 mahesh@linux.vnet.ibm.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 paulus@samba.org, sam.bobroff@au1.ibm.com
Message-ID: <8fa746ca-302f-b2bf-ee05-a4b0b4f2fcbb@ozlabs.ru>
Subject: Re: [Qemu-ppc] [PATCH v5 1/6] ppc: spapr: Register and handle HCALL
 to receive updated RTAS region
References: <150659494872.25889.2069124544245723984.stgit@aravinda>
 <150659505839.25889.2018054058894535368.stgit@aravinda>
 <20170929061735.GD7712@umbus.fritz.box>
 <87y3oxen7t.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
 <95142cc0-518a-b7b7-4e56-cfc2adca36ba@ozlabs.ru>
 <20171003060757.GF3260@umbus.fritz.box>
 <4d649456-1242-febe-06bd-35bb01e3982b@ozlabs.ru>
In-Reply-To: <4d649456-1242-febe-06bd-35bb01e3982b@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/10/17 20:12, Alexey Kardashevskiy wrote:
> On 03/10/17 17:07, David Gibson wrote:
>> On Mon, Oct 02, 2017 at 02:02:19PM +1100, Alexey Kardashevskiy wrote:
>>> On 29/09/17 21:52, Nikunj A Dadhania wrote:
>>>> David Gibson <david@gibson.dropbear.id.au> writes:
>>>>
>>>>> On Thu, Sep 28, 2017 at 04:07:38PM +0530, Aravinda Prasad wrote:
>>>>>> Receive updates from SLOF about the updated rtas-base.
>>>>>> A separate patch for SLOF [1] (commit f9a60de3) adds
>>>>>> functionality to invoke a private HCALL whenever OS
>>>>>> issues instantiate-rtas with a new rtas-base.
>>>>>>
>>>>>> This is required as QEMU needs to know the updated rtas-base
>>>>>> as it allocates error reporting structure in RTAS space upon
>>>>>> a machine check exception.
>>>>>>
>>>>>> [1] https://lists.ozlabs.org/pipermail/linuxppc-dev/2014-August/12=
0386.html
>>>>>>
>>>>>> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
>>>>>> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
>>>>>
>>>>> Ao I acked this earlier, but I've now realized there might be some
>>>>> connection between this and discussions taking place elsewhere abou=
t
>>>>> qemu not knowing what SLOF does with the device tree.
>>>>>
>>>>> At what point will SLOF call the UPDATE_RTAS hcall?  I'm guessing a=
t
>>>>> the time of instantiate-rtas, is that right?
>>>>
>>>> The call happens from
>>>> arch/powerpc/kernel/prom_init.c:prom_instantiate_rtas() and after th=
at
>>>> linux kernel makes two entries in the DT
>>>>
>>>> ....
>>>>        if (call_prom_ret("call-method", 3, 2, &entry,
>>>>                           ADDR("instantiate-rtas"),
>>>>                           rtas_inst, base) !=3D 0
>>>>             || entry =3D=3D 0) {
>>>>                 prom_printf(" failed\n");
>>>>                 return;
>>>>         }
>>>>         prom_printf(" done\n");
>>>>
>>>>         reserve_mem(base, size);
>>>>
>>>>         val =3D cpu_to_be32(base);
>>>>         prom_setprop(rtas_node, "/rtas", "linux,rtas-base",
>>>>                      &val, sizeof(val));
>>>>         val =3D cpu_to_be32(entry);
>>>>         prom_setprop(rtas_node, "/rtas", "linux,rtas-entry",
>>>>                      &val, sizeof(val));
>>>> ....
>>>>
>>>> Quiesce is called after this.=20
>>>>
>>>>> Does SLOF put the RTAS blob address in its internal device tree, or=

>>>>> does it only pass it to the guest via the return parameters from
>>>>> instantiate-rtas?
>>>>
>>>> Entry was made to the DT by linux kernel prom_init code, will this b=
e
>>>> visible to QEMU?
>>>
>>> With my recent SLOF FDT patch - yes:
>>>
>>> aik@fstn1-p1:~$ grep rtas dbg.dts
>>> 	rtas {
>>> 		linux,rtas-entry =3D <0x2fff0000>;
>>> 		linux,rtas-base =3D <0x2fff0000>;
>>> [...]
>>
>> Ah.. except.. isn't that relying on the kernel putting the RTAS
>> address into the device tree before it calls quiesce and kills SLOF?
>>
>> The SLOF image is bundled in with qemu, so it's ok for us to rely on
>> its behaviour up to a point.  It's not really ok for us to rely on the=

>> kernel's behaviour here, unless that behaviour is mandated by PAPR,
>> which this isn't.
>=20
> Fair point.
>=20
>> So, I think we either need to have *SLOF* update the device tree with
>> that address at instantiate-rtas time,
>=20
> I can do that, in a separate patch.


One comment though - if I create the properties in SLOF, I have to name
them different, like rtas-entry/rtas-base or slof,rtas-entry/slof,rtas-ba=
se
to avoid colliding with the ones create by the guest kernel.

So what do I name them? And do we need 2 copies of the same thing, do we
ever expect rtas-entry!=3Drtas-base? The guest can potentially get them
different (under powervm) but not with SLOF.


>=20
>> or we'll need to resurrect
>> Aravinda's original UPDATE_RTAS hcall.



--=20
Alexey


--8TtbvdeT1GpFO0vkKPcetQspwviI20Hci
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIrBAEBCAAVBQJZ1FY7DhxhaWtAb3psYWJzLnJ1AAoJEIYTPdgrwSC5fn4P/ilb
eT0/8b2DJxW2YDoZVxLUXARyRylug191mCCPiTjwoPM2bHxBCsn9bDqiMlcsB+dP
27JSkvlZWyzkqYXxFMcvR1k+/Or15yfK1Y8jE9guCoyqMsOmAAywzc2hUqLNQ6sb
K73oHJf5ax6opj/c8KNAQIP3ouLbwBk7aI2NGpo5wRmvstn8TneNmG07NS415QdV
zPaB58/u95bkxQc3LoZsGhcYLjYsoXXMrmj0rx2Kx5lFsPluvGG67DruGWd/Dr2o
eQDmNEPab97eL8P1vlJTNtfA8pyYEbZ+L8PlfmeGmylUDlgotPP9l7BadApVFtDe
a1T0U8P3WvwNus7OgwGlLD6oNL8yr/hlM7FSJ3NoUg5g1DlNB/0qwX3xeOZuqeCg
3122QbzMyw1lXjbdYqUxbu0soTRfNSSTPIE4fMVV4UVM90f939kW4VNx6XJYJKaB
P5bHkINuYK9S0xk+f0DjA/gBczuWRQqWTdoOjqFM5tIrRaNeZmlMDc+zVl9Y2FiU
RaVlXfIaTlkWl8xWRYaPjM37v8UqwvHmeYkj711Qkhgm4y5WgO9s3T8SwImp9Krz
R76jmZB2ea1JOzIwdUClnEm7aYeC0VRyR4ynVNy6+PgnnMvuoBZ3k6DMcwrMfY6X
zZEnKq/NoXqez87vslGr7ZIcWBNzWLGM5nNo7GnB
=Xj5s
-----END PGP SIGNATURE-----

--8TtbvdeT1GpFO0vkKPcetQspwviI20Hci--
