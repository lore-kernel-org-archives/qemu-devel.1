Received: from eggs.gnu.org ([209.51.188.92]:48762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h1mMO-0004EF-VS
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 01:18:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h1mMO-0005SY-33
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 01:18:28 -0500
Received: from 4.mo68.mail-out.ovh.net ([46.105.59.63]:45635)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1h1mMN-0005Rd-Sd
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 01:18:28 -0500
Received: from player158.ha.ovh.net (unknown [10.109.160.62])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 2E9C2118B20
	for <qemu-devel@nongnu.org>; Thu,  7 Mar 2019 07:18:24 +0100 (CET)
References: <20190306043801.8852-1-david@gibson.dropbear.id.au>
	<c1c9ba97-f80d-d61d-d5c8-9d909951da01@kaod.org>
	<20190307052149.GP7722@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <9fbdd05f-1715-ce6d-e719-676af7567da6@kaod.org>
Date: Thu, 7 Mar 2019 07:18:15 +0100
MIME-Version: 1.0
In-Reply-To: <20190307052149.GP7722@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC] spapr: Use CamelCase properly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: groug@kaod.org, aik@ozlabs.ru, agraf@suse.de, lvivier@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 3/7/19 6:21 AM, David Gibson wrote:
> On Wed, Mar 06, 2019 at 08:22:51AM +0100, C=E9dric Le Goater wrote:
>> Hello,
>>
>> On 3/6/19 5:38 AM, David Gibson wrote:
>>> The qemu coding standard is to use CamelCase for type and structure n=
ames,
>>> and the pseries code follows that... sort of.  There are quite a lot =
of
>>> places where we bend the rules in order to preserve the capitalizatio=
n of
>>> internal acronyms like "PHB", "TCE", "DIMM" and most commonly "sPAPR"=
.
>>>
>>> That was a bad idea - it frequently leads to names ending up with
>>> unreadable clusters of capital letters, and means they don't appear t=
o the
>>> eye as type identifiers, which is kind of the point of the CamelCase
>>> convention in the first place.
>>>
>>> In short, keeping type identifiers look like CamelCase is more import=
ant
>>> than preserving standard capitalization of internal "words".  So, thi=
s
>>> patch renames a heap of spapr internal type names to a more standard
>>> CamelCase.
>>
>> +1
>> =20
>>> We also rename VIOsPAPR* to SpaprVio*, the less natural reverse order=
ing
>>> was only there in the first place to mitigate the capital-letter clus=
ter
>>> of "sPAPRVIO".
>>
>> Could we remove the Device prefix ? I don't find it very useful.
>=20
> [Aside: ITYM "suffix"]

arg. yes :)

>=20
>>
>> 	SpaprVioVtyDevice
>> 	SpaprVioVlanDevice
>=20
> Done.
>=20
>> 	SpaprVioDevice
>=20
> I'll leave this one.  "SpaprVio" doesn't really make grammatical
> sense, and "SpaprVioDevice" works in analogy with, say, PCIDevice.

ok.

>>
>>> This is 100% a mechanical search-and-replace patch.  It will, however=
,
>>> conflict with essentially any and all outstanding patches touching th=
e
>>> spapr code.
>>>
>>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>>
>> I have spotted dromedaries :
>>
>> 	typedef struct SpaprDRConnector
>=20
> I've changed this to SpaprDrc.  Shorter and makes it clearer that
> these are the same things as the "DRC"s we reference elsewhere.
>=20
>> 	typedef struct SpaprDRCPhysical
>=20
> Changed to SpaprDrcPhysical
>=20
>>
>> Could we get rid of the 'State' prefix ? It does not add much to the n=
ame
>> and usually the associated macros remove it.
>=20
> True, but it is a common qemu pattern, so I think I'll leave these for =
now.

ok

>> 	SpaprRngState
>> 	SpaprPhbState
>> 	SpaprRtcState
>> 	SpaprDimmState
>> 	SpaprMachineState
>> 	SpaprCpuState
>>
>> It would be good to reverse the xics filenames also.
>=20
> I'm not really sure what you mean by that, and in any case I don't
> think it's really in scope for this patch.
=20
To be consistent with the other filenames, we should change :

	xics_spapr.h  ->  spapr_xics.h
	xics_spapr.c  ->  spapr_xics.c
	xics_kvm.c    ->  spapr_xics_kvm.c

and yes, it should be in another patch.

Thanks,

C.=20
