Received: from eggs.gnu.org ([2001:4830:134:3::10]:44212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eqEH8-0001P0-RC
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 03:36:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eqEH4-0005uG-3A
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 03:36:46 -0500
Received: from mail-it0-x234.google.com ([2607:f8b0:4001:c0b::234]:35081)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1eqEH3-0005tu-Nt
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 03:36:42 -0500
Received: by mail-it0-x234.google.com with SMTP id v194so10084748itb.0
	for <qemu-devel@nongnu.org>; Mon, 26 Feb 2018 00:36:41 -0800 (PST)
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
Message-ID: <a29658e8-d2da-161d-d9b8-41f186969927@ozlabs.ru>
Date: Mon, 26 Feb 2018 19:36:34 +1100
MIME-Version: 1.0
In-Reply-To: <c11af933-3f08-f2c8-0552-ce43ac8f5741@ozlabs.ru>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ltwUhkJf0CqqQnZLuydmecN6B52AV9yYn"
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
--ltwUhkJf0CqqQnZLuydmecN6B52AV9yYn
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>,
 Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Message-ID: <a29658e8-d2da-161d-d9b8-41f186969927@ozlabs.ru>
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
In-Reply-To: <c11af933-3f08-f2c8-0552-ce43ac8f5741@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 19/02/18 13:46, Alexey Kardashevskiy wrote:
> On 16/02/18 16:28, David Gibson wrote:
>> On Wed, Feb 14, 2018 at 08:55:41AM -0700, Alex Williamson wrote:
>>> On Wed, 14 Feb 2018 19:09:16 +1100
>>> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>>>
>>>> On 14/02/18 12:33, David Gibson wrote:
>>>>> On Tue, Feb 13, 2018 at 07:20:56PM +1100, Alexey Kardashevskiy wrot=
e: =20
>>>>>> On 13/02/18 16:41, David Gibson wrote: =20
>>>>>>> On Tue, Feb 13, 2018 at 04:36:30PM +1100, David Gibson wrote: =20
>>>>>>>> On Tue, Feb 13, 2018 at 12:15:52PM +1100, Alexey Kardashevskiy w=
rote: =20
>>>>>>>>> On 13/02/18 03:06, Alex Williamson wrote: =20
>>>>>>>>>> On Mon, 12 Feb 2018 18:05:54 +1100
>>>>>>>>>> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>>>>>>>>>> =20
>>>>>>>>>>> On 12/02/18 16:19, David Gibson wrote: =20
>>>>>>>>>>>> On Fri, Feb 09, 2018 at 06:55:01PM +1100, Alexey Kardashevsk=
iy wrote:   =20
>>>>>>>>>>>>> At the moment if vfio_memory_listener is registered in the =
system memory
>>>>>>>>>>>>> address space, it maps/unmaps every RAM memory region for D=
MA.
>>>>>>>>>>>>> It expects system page size aligned memory sections so vfio=
_dma_map
>>>>>>>>>>>>> would not fail and so far this has been the case. A mapping=
 failure
>>>>>>>>>>>>> would be fatal. A side effect of such behavior is that some=
 MMIO pages
>>>>>>>>>>>>> would not be mapped silently.
>>>>>>>>>>>>>
>>>>>>>>>>>>> However we are going to change MSIX BAR handling so we will=
 end having
>>>>>>>>>>>>> non-aligned sections in vfio_memory_listener (more details =
is in
>>>>>>>>>>>>> the next patch) and vfio_dma_map will exit QEMU.
>>>>>>>>>>>>>
>>>>>>>>>>>>> In order to avoid fatal failures on what previously was not=
 a failure and
>>>>>>>>>>>>> was just silently ignored, this checks the section alignmen=
t to
>>>>>>>>>>>>> the smallest supported IOMMU page size and prints an error =
if not aligned;
>>>>>>>>>>>>> it also prints an error if vfio_dma_map failed despite the =
page size check.
>>>>>>>>>>>>> Both errors are not fatal; only MMIO RAM regions are checke=
d
>>>>>>>>>>>>> (aka "RAM device" regions).
>>>>>>>>>>>>>
>>>>>>>>>>>>> If the amount of errors printed is overwhelming, the MSIX r=
elocation
>>>>>>>>>>>>> could be used to avoid excessive error output.
>>>>>>>>>>>>>
>>>>>>>>>>>>> This is unlikely to cause any behavioral change.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>   =20
>>>>>>>>>>>>
>>>>>>>>>>>> There are some relatively superficial problems noted below.
>>>>>>>>>>>>
>>>>>>>>>>>> But more fundamentally, this feels like it's extending an ex=
isting
>>>>>>>>>>>> hack past the point of usefulness.
>>>>>>>>>>>>
>>>>>>>>>>>> The explicit check for is_ram_device() here has always bothe=
red me -
>>>>>>>>>>>> it's not like a real bus bridge magically knows whether a ta=
rget
>>>>>>>>>>>> address maps to RAM or not.
>>>>>>>>>>>>
>>>>>>>>>>>> What I think is really going on is that even for systems wit=
hout an
>>>>>>>>>>>> IOMMU, it's not really true to say that the PCI address spac=
e maps
>>>>>>>>>>>> directly onto address_space_memory.  Instead, there's a larg=
e, but
>>>>>>>>>>>> much less than 2^64 sized, "upstream window" at address 0 on=
 the PCI
>>>>>>>>>>>> bus, which is identity mapped to the system bus.  Details wi=
ll vary
>>>>>>>>>>>> with the system, but in practice we expect nothing but RAM t=
o be in
>>>>>>>>>>>> that window.  Addresses not within that window won't be mapp=
ed to the
>>>>>>>>>>>> system bus but will just be broadcast on the PCI bus and mig=
ht be
>>>>>>>>>>>> picked up as a p2p transaction.   =20
>>>>>>>>>>>
>>>>>>>>>>> Currently this p2p works only via the IOMMU, direct p2p is no=
t possible as
>>>>>>>>>>> the guest needs to know physical MMIO addresses to make p2p w=
ork and it
>>>>>>>>>>> does not. =20
>>>>>>>>>>
>>>>>>>>>> /me points to the Direct Translated P2P section of the ACS spe=
c, though
>>>>>>>>>> it's as prone to spoofing by the device as ATS.  In any case, =
p2p
>>>>>>>>>> reflected from the IOMMU is still p2p and offloads the CPU eve=
n if
>>>>>>>>>> bandwidth suffers vs bare metal depending on if the data doubl=
es back
>>>>>>>>>> over any links.  Thanks, =20
>>>>>>>>>
>>>>>>>>> Sure, I was just saying that p2p via IOMMU won't be as simple a=
s broadcast
>>>>>>>>> on the PCI bus, IOMMU needs to be programmed in advance to make=
 this work,
>>>>>>>>> and current that broadcast won't work for the passed through de=
vices. =20
>>>>>>>>
>>>>>>>> Well, sure, p2p in a guest with passthrough devices clearly need=
s to
>>>>>>>> be translated through the IOMMU (and p2p from a passthrough to a=
n
>>>>>>>> emulated device is essentially impossible).
>>>>>>>>
>>>>>>>> But.. what does that have to do with this code.  This is the mem=
ory
>>>>>>>> area watcher, looking for memory regions being mapped directly i=
nto
>>>>>>>> the PCI space.  NOT IOMMU regions, since those are handled separ=
ately
>>>>>>>> by wiring up the IOMMU notifier.  This will only trigger if RAM-=
like,
>>>>>>>> non-RAM regions are put into PCI space *not* behind an IOMMMU.  =

>>>>>>>
>>>>>>> Duh, sorry, realised I was mixing up host and guest IOMMU.  I gue=
ss
>>>>>>> the point here is that this will map RAM-like devices into the ho=
st
>>>>>>> IOMMU when there is no guest IOMMU, allowing p2p transactions bet=
ween
>>>>>>> passthrough devices (though not from passthrough to emulated devi=
ces). =20
>>>>>>
>>>>>> Correct.
>>>>>> =20
>>>>>>>
>>>>>>> The conditions still seem kind of awkward to me, but I guess it m=
akes
>>>>>>> sense. =20
>>>>>>
>>>>>> Is it the time to split this listener to RAM-listener and PCI bus =
listener? =20
>>>>>
>>>>> I'm not really sure what you mean by that.
>>>>>  =20
>>>>>> On x86 it listens on the "memory" AS, on spapr - on the
>>>>>> "pci@800000020000000" AS, this will just create more confusion ove=
r time... =20
>>>>>
>>>>> Hm, it's still logically the same AS in each case - the PCI address=

>>>>> space.  It's just that in the x86 case that happens to be the same =
as
>>>>> the memory AS (at least when there isn't a guest side IOMMU). =20
>>>>
>>>> Hm. Ok.
>>>>
>>>>> I do wonder if that's really right even for x86 without IOMMU.  The=

>>>>> PCI address space is identity mapped to the "main" memory address
>>>>> space there, but I'm not sure it's mapped th *all* of the main memo=
ry =20
>>>>
>>>> What should have been in the place of "th" above? :)
>>>>
>>>>> address space, probably just certain ranges of it.  That's what I w=
as
>>>>> suggesting earlier in the thread. =20
>>>>
>>>> afaict vfio is trying to mmap every RAM MR =3D=3D KVM memory slot, n=
o ranges or
>>>> anything like that. I am trying to figure out what is not correct wi=
th the
>>>> patch. Thanks,
>>>
>>> It is possible for x86 systems to have translation applied to MMIO vs=

>>> RAM such that the processor view and device view of MMIO are differen=
t,
>>> putting them into separate address spaces, but this is not typical an=
d
>>> not available on the class of chipsets that QEMU emulates for PC.
>>> Therefore I think it's correct that MMIO and RAM all live in one big
>>> happy, flat address space as they do now (assuming the guest IOMMU is=

>>> not present or disabled).  Thanks,
>>
>> Ah.. I think the thing I was missing is that on PC (at least with
>> typical chipsets) *all* MMIO essentially comes from PCI space.  Even
>> the legacy devices are essentially ISA which is treated as being on a
>> bridge under the PCI space.  On non-x86 there are often at least a
>> handful of MMIO devices that aren't within the PCI space - say, the
>> PCI host bridge itself at least.  x86 avoids that by using the
>> separate IO space, which is also a bit weird in that it's
>> simultaneously direct attached to the cpu (and so doesn't need bridge
>> configuration), but also identified with the legay IO space treated as=

>> being under two bridges (host->PCI, PCI->ISA) for other purposes.
>>
>> Maybe it's just me, but I find it makes more sense to me if I think of=

>> it as the two ASes being equal because on PC the system address map
>> (address_space_memory) is made equal to the PCI address map, rather
>> than the PCI address map being made equal to the system one.
>=20
> It makes more sense to me too, we just do not exploit/expose this on SP=
APR
> - the PCI address space only has 2xIOMMU and 1xMSI windows and that's i=
t,
> no MMIO which is mapped to the system AS only (adding those to the PCI =
AS
> is little tricky as mentioned elsewhere).
>=20
> Anyway, I still wonder - what needs to be addressed in the 2/4 patch in=

> order to proceed?

Ping?



--=20
Alexey


--ltwUhkJf0CqqQnZLuydmecN6B52AV9yYn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEZSrPibrORRTHQ99dhhM92CvBILkFAlqTxxMOHGFpa0Bvemxh
YnMucnUACgkQhhM92CvBILmX6xAAoPwlzr9Xlacf6XJgIwX1pC06YUjRxP4o5iOG
WhaoKRtU++zYsbYb6zylj9hAuV3VBJp+fSE/6Mpvn8CWxMzUZ/TgieiaVWaklMvA
ksWyz81d47O0N2xK/nGH2eKmWvpvDj+1fRBHTyxk5uqpLrpLzJ0Y8pqx0sbcIPOv
NoXmVunvAhDCIija9665S9yOXVCdHRJsqEt3mtNsWoZBpuuz3M4QmJC+bmibg2rf
IloJjjE5AFV3m9Tz9m8G+wDiQrqHm6LcVXaKkGP5pPkFWVYIOkolrXp35Yer5KER
jlzErUsWzLoYdEf+GkUlWEsG8NanozbNmlFbzjCCkXWDvGHAOThfArmynz6dyQvz
M6jNB95RFgUQrmWpPeEXvoxyZIgA5dX+RAM37udXS5BSykBXaqbyMIIlaeIfKRBP
s188y8Xbvy2hZxLnwdFyOFhqrTbQALgNSPjH80dby4M8XDYTdZvOHNFS0gx9zxoz
xgDPeja1Q1fv4iuyi8DVsE07eeTyxL3e4jNfRIsLRHRAGvepfyG1cppX9DDFxSwK
dauDqF6Xe3HPGJWdtuUnp0z291QidMRd8MwOqQJNrhTauR34gTBaUfUX5GL+DWGr
3Iqr8aHvvH625NRio+fzfgyOIO4qH+i9NsdGnMNES500pGAUFt+UIVDD9QHZzncp
JRMhEqg=
=AqVd
-----END PGP SIGNATURE-----

--ltwUhkJf0CqqQnZLuydmecN6B52AV9yYn--
