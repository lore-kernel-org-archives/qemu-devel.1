Received: from eggs.gnu.org ([2001:4830:134:3::10]:40921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1etOeW-0002Yg-H8
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 21:18:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1etOeT-00085b-9z
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 21:18:00 -0500
Received: from mail-pf0-x22b.google.com ([2607:f8b0:400e:c00::22b]:39926)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1etOeS-00084x-Sv
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 21:17:57 -0500
Received: by mail-pf0-x22b.google.com with SMTP id u5so347563pfh.6
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 18:17:56 -0800 (PST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
References: <20180212051954.GE11634@umbus.fritz.box>
	<0a57f0ec-4300-f4f3-3957-4bced8b57e14@ozlabs.ru>
	<20180212090653.42bdd2e2@w520.home>
	<0c594a0b-488c-b5f8-e8ed-ffa8f4a98088@ozlabs.ru>
	<20180213053630.GL11634@umbus.fritz.box>
	<20180213054124.GN11634@umbus.fritz.box>
	<8282d070-b2d3-7e43-3da9-b17c77b99a67@ozlabs.ru>
	<20180214013323.GA5247@umbus.fritz.box>
	<843efd62-7a39-8536-91ad-1abea2beb190@ozlabs.ru>
	<20180214085541.5491705f@w520.home>
	<20180216052824.GI2074@umbus.fritz.box>
	<c11af933-3f08-f2c8-0552-ce43ac8f5741@ozlabs.ru>
	<a29658e8-d2da-161d-d9b8-41f186969927@ozlabs.ru>
Message-ID: <821596dc-35b0-60cf-3e1f-3df0809b2f8e@ozlabs.ru>
Date: Wed, 7 Mar 2018 13:17:50 +1100
MIME-Version: 1.0
In-Reply-To: <a29658e8-d2da-161d-d9b8-41f186969927@ozlabs.ru>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="baBtISSwqtBl6fRWuZSs727oEVGST35L0"
Subject: Re: [Qemu-devel] [PATCH qemu v7 2/4] vfio/pci: Relax DMA map errors
 for MMIO regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--baBtISSwqtBl6fRWuZSs727oEVGST35L0
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>,
 Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Message-ID: <821596dc-35b0-60cf-3e1f-3df0809b2f8e@ozlabs.ru>
Subject: Re: [PATCH qemu v7 2/4] vfio/pci: Relax DMA map errors for MMIO
 regions
References: <20180212051954.GE11634@umbus.fritz.box>
 <0a57f0ec-4300-f4f3-3957-4bced8b57e14@ozlabs.ru>
 <20180212090653.42bdd2e2@w520.home>
 <0c594a0b-488c-b5f8-e8ed-ffa8f4a98088@ozlabs.ru>
 <20180213053630.GL11634@umbus.fritz.box>
 <20180213054124.GN11634@umbus.fritz.box>
 <8282d070-b2d3-7e43-3da9-b17c77b99a67@ozlabs.ru>
 <20180214013323.GA5247@umbus.fritz.box>
 <843efd62-7a39-8536-91ad-1abea2beb190@ozlabs.ru>
 <20180214085541.5491705f@w520.home> <20180216052824.GI2074@umbus.fritz.box>
 <c11af933-3f08-f2c8-0552-ce43ac8f5741@ozlabs.ru>
 <a29658e8-d2da-161d-d9b8-41f186969927@ozlabs.ru>
In-Reply-To: <a29658e8-d2da-161d-d9b8-41f186969927@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 26/02/18 19:36, Alexey Kardashevskiy wrote:
> On 19/02/18 13:46, Alexey Kardashevskiy wrote:
>> On 16/02/18 16:28, David Gibson wrote:
>>> On Wed, Feb 14, 2018 at 08:55:41AM -0700, Alex Williamson wrote:
>>>> On Wed, 14 Feb 2018 19:09:16 +1100
>>>> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>>>>
>>>>> On 14/02/18 12:33, David Gibson wrote:
>>>>>> On Tue, Feb 13, 2018 at 07:20:56PM +1100, Alexey Kardashevskiy wro=
te: =20
>>>>>>> On 13/02/18 16:41, David Gibson wrote: =20
>>>>>>>> On Tue, Feb 13, 2018 at 04:36:30PM +1100, David Gibson wrote: =20
>>>>>>>>> On Tue, Feb 13, 2018 at 12:15:52PM +1100, Alexey Kardashevskiy =
wrote: =20
>>>>>>>>>> On 13/02/18 03:06, Alex Williamson wrote: =20
>>>>>>>>>>> On Mon, 12 Feb 2018 18:05:54 +1100
>>>>>>>>>>> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>>>>>>>>>>> =20
>>>>>>>>>>>> On 12/02/18 16:19, David Gibson wrote: =20
>>>>>>>>>>>>> On Fri, Feb 09, 2018 at 06:55:01PM +1100, Alexey Kardashevs=
kiy wrote:   =20
>>>>>>>>>>>>>> At the moment if vfio_memory_listener is registered in the=
 system memory
>>>>>>>>>>>>>> address space, it maps/unmaps every RAM memory region for =
DMA.
>>>>>>>>>>>>>> It expects system page size aligned memory sections so vfi=
o_dma_map
>>>>>>>>>>>>>> would not fail and so far this has been the case. A mappin=
g failure
>>>>>>>>>>>>>> would be fatal. A side effect of such behavior is that som=
e MMIO pages
>>>>>>>>>>>>>> would not be mapped silently.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> However we are going to change MSIX BAR handling so we wil=
l end having
>>>>>>>>>>>>>> non-aligned sections in vfio_memory_listener (more details=
 is in
>>>>>>>>>>>>>> the next patch) and vfio_dma_map will exit QEMU.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> In order to avoid fatal failures on what previously was no=
t a failure and
>>>>>>>>>>>>>> was just silently ignored, this checks the section alignme=
nt to
>>>>>>>>>>>>>> the smallest supported IOMMU page size and prints an error=
 if not aligned;
>>>>>>>>>>>>>> it also prints an error if vfio_dma_map failed despite the=
 page size check.
>>>>>>>>>>>>>> Both errors are not fatal; only MMIO RAM regions are check=
ed
>>>>>>>>>>>>>> (aka "RAM device" regions).
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> If the amount of errors printed is overwhelming, the MSIX =
relocation
>>>>>>>>>>>>>> could be used to avoid excessive error output.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> This is unlikely to cause any behavioral change.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>   =20
>>>>>>>>>>>>>
>>>>>>>>>>>>> There are some relatively superficial problems noted below.=

>>>>>>>>>>>>>
>>>>>>>>>>>>> But more fundamentally, this feels like it's extending an e=
xisting
>>>>>>>>>>>>> hack past the point of usefulness.
>>>>>>>>>>>>>
>>>>>>>>>>>>> The explicit check for is_ram_device() here has always both=
ered me -
>>>>>>>>>>>>> it's not like a real bus bridge magically knows whether a t=
arget
>>>>>>>>>>>>> address maps to RAM or not.
>>>>>>>>>>>>>
>>>>>>>>>>>>> What I think is really going on is that even for systems wi=
thout an
>>>>>>>>>>>>> IOMMU, it's not really true to say that the PCI address spa=
ce maps
>>>>>>>>>>>>> directly onto address_space_memory.  Instead, there's a lar=
ge, but
>>>>>>>>>>>>> much less than 2^64 sized, "upstream window" at address 0 o=
n the PCI
>>>>>>>>>>>>> bus, which is identity mapped to the system bus.  Details w=
ill vary
>>>>>>>>>>>>> with the system, but in practice we expect nothing but RAM =
to be in
>>>>>>>>>>>>> that window.  Addresses not within that window won't be map=
ped to the
>>>>>>>>>>>>> system bus but will just be broadcast on the PCI bus and mi=
ght be
>>>>>>>>>>>>> picked up as a p2p transaction.   =20
>>>>>>>>>>>>
>>>>>>>>>>>> Currently this p2p works only via the IOMMU, direct p2p is n=
ot possible as
>>>>>>>>>>>> the guest needs to know physical MMIO addresses to make p2p =
work and it
>>>>>>>>>>>> does not. =20
>>>>>>>>>>>
>>>>>>>>>>> /me points to the Direct Translated P2P section of the ACS sp=
ec, though
>>>>>>>>>>> it's as prone to spoofing by the device as ATS.  In any case,=
 p2p
>>>>>>>>>>> reflected from the IOMMU is still p2p and offloads the CPU ev=
en if
>>>>>>>>>>> bandwidth suffers vs bare metal depending on if the data doub=
les back
>>>>>>>>>>> over any links.  Thanks, =20
>>>>>>>>>>
>>>>>>>>>> Sure, I was just saying that p2p via IOMMU won't be as simple =
as broadcast
>>>>>>>>>> on the PCI bus, IOMMU needs to be programmed in advance to mak=
e this work,
>>>>>>>>>> and current that broadcast won't work for the passed through d=
evices. =20
>>>>>>>>>
>>>>>>>>> Well, sure, p2p in a guest with passthrough devices clearly nee=
ds to
>>>>>>>>> be translated through the IOMMU (and p2p from a passthrough to =
an
>>>>>>>>> emulated device is essentially impossible).
>>>>>>>>>
>>>>>>>>> But.. what does that have to do with this code.  This is the me=
mory
>>>>>>>>> area watcher, looking for memory regions being mapped directly =
into
>>>>>>>>> the PCI space.  NOT IOMMU regions, since those are handled sepa=
rately
>>>>>>>>> by wiring up the IOMMU notifier.  This will only trigger if RAM=
-like,
>>>>>>>>> non-RAM regions are put into PCI space *not* behind an IOMMMU. =
=20
>>>>>>>>
>>>>>>>> Duh, sorry, realised I was mixing up host and guest IOMMU.  I gu=
ess
>>>>>>>> the point here is that this will map RAM-like devices into the h=
ost
>>>>>>>> IOMMU when there is no guest IOMMU, allowing p2p transactions be=
tween
>>>>>>>> passthrough devices (though not from passthrough to emulated dev=
ices). =20
>>>>>>>
>>>>>>> Correct.
>>>>>>> =20
>>>>>>>>
>>>>>>>> The conditions still seem kind of awkward to me, but I guess it =
makes
>>>>>>>> sense. =20
>>>>>>>
>>>>>>> Is it the time to split this listener to RAM-listener and PCI bus=
 listener? =20
>>>>>>
>>>>>> I'm not really sure what you mean by that.
>>>>>>  =20
>>>>>>> On x86 it listens on the "memory" AS, on spapr - on the
>>>>>>> "pci@800000020000000" AS, this will just create more confusion ov=
er time... =20
>>>>>>
>>>>>> Hm, it's still logically the same AS in each case - the PCI addres=
s
>>>>>> space.  It's just that in the x86 case that happens to be the same=
 as
>>>>>> the memory AS (at least when there isn't a guest side IOMMU). =20
>>>>>
>>>>> Hm. Ok.
>>>>>
>>>>>> I do wonder if that's really right even for x86 without IOMMU.  Th=
e
>>>>>> PCI address space is identity mapped to the "main" memory address
>>>>>> space there, but I'm not sure it's mapped th *all* of the main mem=
ory =20
>>>>>
>>>>> What should have been in the place of "th" above? :)
>>>>>
>>>>>> address space, probably just certain ranges of it.  That's what I =
was
>>>>>> suggesting earlier in the thread. =20
>>>>>
>>>>> afaict vfio is trying to mmap every RAM MR =3D=3D KVM memory slot, =
no ranges or
>>>>> anything like that. I am trying to figure out what is not correct w=
ith the
>>>>> patch. Thanks,
>>>>
>>>> It is possible for x86 systems to have translation applied to MMIO v=
s
>>>> RAM such that the processor view and device view of MMIO are differe=
nt,
>>>> putting them into separate address spaces, but this is not typical a=
nd
>>>> not available on the class of chipsets that QEMU emulates for PC.
>>>> Therefore I think it's correct that MMIO and RAM all live in one big=

>>>> happy, flat address space as they do now (assuming the guest IOMMU i=
s
>>>> not present or disabled).  Thanks,
>>>
>>> Ah.. I think the thing I was missing is that on PC (at least with
>>> typical chipsets) *all* MMIO essentially comes from PCI space.  Even
>>> the legacy devices are essentially ISA which is treated as being on a=

>>> bridge under the PCI space.  On non-x86 there are often at least a
>>> handful of MMIO devices that aren't within the PCI space - say, the
>>> PCI host bridge itself at least.  x86 avoids that by using the
>>> separate IO space, which is also a bit weird in that it's
>>> simultaneously direct attached to the cpu (and so doesn't need bridge=

>>> configuration), but also identified with the legay IO space treated a=
s
>>> being under two bridges (host->PCI, PCI->ISA) for other purposes.
>>>
>>> Maybe it's just me, but I find it makes more sense to me if I think o=
f
>>> it as the two ASes being equal because on PC the system address map
>>> (address_space_memory) is made equal to the PCI address map, rather
>>> than the PCI address map being made equal to the system one.
>>
>> It makes more sense to me too, we just do not exploit/expose this on S=
PAPR
>> - the PCI address space only has 2xIOMMU and 1xMSI windows and that's =
it,
>> no MMIO which is mapped to the system AS only (adding those to the PCI=
 AS
>> is little tricky as mentioned elsewhere).
>>
>> Anyway, I still wonder - what needs to be addressed in the 2/4 patch i=
n
>> order to proceed?
>=20
> Ping?
>=20


Ping?


--=20
Alexey


--baBtISSwqtBl6fRWuZSs727oEVGST35L0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEZSrPibrORRTHQ99dhhM92CvBILkFAlqfS88OHGFpa0Bvemxh
YnMucnUACgkQhhM92CvBILkpchAAvJ2QW+M8YkpoCFXIcgCgnDrHH2XACEsX27HJ
aWivCeMD7RGyS/RkbLTCqzjc8+p8McaVxtWb9QdGcrtlNlnyColFI0iNXoTbI6U6
c0pb5CQQG5fqjGqb9g6blaPVA3XmIL6UhNI5Bfi/QXNJusaNEsKluwg/oiCU8zyM
wocSsDkt+bOtzBpt6/IQAd/y6WzcOlFNchACIOmlAy2LzTBOvxPMOqpEve+LIr6b
iZpaW0ISBBdY+ADYMOsNxJqIcD6Jl++F3xG6uVrTUD4X7OnI8QpxO7414p7EtYly
Ho/GEDFEXD6QaQCBVzUcN/tRZHIwLMM3lrxH9bgZ1Warzzfk2ZGhi2PxPtDNJj+6
QuTk8SSBppzF3THsTPeDN22GehtKgN7VgR3Z8QP2/gRY0vdmjz2VuyPnTr+qvs8w
u/2LlIduaBgkDRuNNF2y1B/vHcsN6PcO0dyV6M6aWjGRoV15DpmjjfIlzP0oXqdo
nInzLT61xZ/IhjS21sFKi+LemgfBwHuXygDRLaaQ6LT90bxuYGAgzlyluFgz58YH
JWLhW210UQUK0l6pJ9pUDl1HsDWMTZMCZqR9PdSsoXkayG0T/KW+E8jqxqLv6qJJ
mutmnhlpeH31pgVfclCkh3xE4OD91dOueMKYwwIBchauDq9TpUo0SnuTOM+Eg8Gr
JNoFo9s=
=1Goc
-----END PGP SIGNATURE-----

--baBtISSwqtBl6fRWuZSs727oEVGST35L0--
