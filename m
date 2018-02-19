Received: from eggs.gnu.org ([2001:4830:134:3::10]:37276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1enbTr-0001s8-71
	for qemu-devel@nongnu.org; Sun, 18 Feb 2018 21:47:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1enbTn-0002wp-7n
	for qemu-devel@nongnu.org; Sun, 18 Feb 2018 21:47:03 -0500
Received: from mail-pf0-x234.google.com ([2607:f8b0:400e:c00::234]:34095)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1enbTm-0002w1-RM
	for qemu-devel@nongnu.org; Sun, 18 Feb 2018 21:46:59 -0500
Received: by mail-pf0-x234.google.com with SMTP id g17so1626908pfh.1
	for <qemu-devel@nongnu.org>; Sun, 18 Feb 2018 18:46:57 -0800 (PST)
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
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <c11af933-3f08-f2c8-0552-ce43ac8f5741@ozlabs.ru>
Date: Mon, 19 Feb 2018 13:46:50 +1100
MIME-Version: 1.0
In-Reply-To: <20180216052824.GI2074@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ETYCnhiZRNElnUHBGWiGUYdpngbm6aTEq"
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
--ETYCnhiZRNElnUHBGWiGUYdpngbm6aTEq
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>,
 Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Message-ID: <c11af933-3f08-f2c8-0552-ce43ac8f5741@ozlabs.ru>
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
In-Reply-To: <20180216052824.GI2074@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 16/02/18 16:28, David Gibson wrote:
> On Wed, Feb 14, 2018 at 08:55:41AM -0700, Alex Williamson wrote:
>> On Wed, 14 Feb 2018 19:09:16 +1100
>> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>>
>>> On 14/02/18 12:33, David Gibson wrote:
>>>> On Tue, Feb 13, 2018 at 07:20:56PM +1100, Alexey Kardashevskiy wrote=
: =20
>>>>> On 13/02/18 16:41, David Gibson wrote: =20
>>>>>> On Tue, Feb 13, 2018 at 04:36:30PM +1100, David Gibson wrote: =20
>>>>>>> On Tue, Feb 13, 2018 at 12:15:52PM +1100, Alexey Kardashevskiy wr=
ote: =20
>>>>>>>> On 13/02/18 03:06, Alex Williamson wrote: =20
>>>>>>>>> On Mon, 12 Feb 2018 18:05:54 +1100
>>>>>>>>> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>>>>>>>>> =20
>>>>>>>>>> On 12/02/18 16:19, David Gibson wrote: =20
>>>>>>>>>>> On Fri, Feb 09, 2018 at 06:55:01PM +1100, Alexey Kardashevski=
y wrote:   =20
>>>>>>>>>>>> At the moment if vfio_memory_listener is registered in the s=
ystem memory
>>>>>>>>>>>> address space, it maps/unmaps every RAM memory region for DM=
A.
>>>>>>>>>>>> It expects system page size aligned memory sections so vfio_=
dma_map
>>>>>>>>>>>> would not fail and so far this has been the case. A mapping =
failure
>>>>>>>>>>>> would be fatal. A side effect of such behavior is that some =
MMIO pages
>>>>>>>>>>>> would not be mapped silently.
>>>>>>>>>>>>
>>>>>>>>>>>> However we are going to change MSIX BAR handling so we will =
end having
>>>>>>>>>>>> non-aligned sections in vfio_memory_listener (more details i=
s in
>>>>>>>>>>>> the next patch) and vfio_dma_map will exit QEMU.
>>>>>>>>>>>>
>>>>>>>>>>>> In order to avoid fatal failures on what previously was not =
a failure and
>>>>>>>>>>>> was just silently ignored, this checks the section alignment=
 to
>>>>>>>>>>>> the smallest supported IOMMU page size and prints an error i=
f not aligned;
>>>>>>>>>>>> it also prints an error if vfio_dma_map failed despite the p=
age size check.
>>>>>>>>>>>> Both errors are not fatal; only MMIO RAM regions are checked=

>>>>>>>>>>>> (aka "RAM device" regions).
>>>>>>>>>>>>
>>>>>>>>>>>> If the amount of errors printed is overwhelming, the MSIX re=
location
>>>>>>>>>>>> could be used to avoid excessive error output.
>>>>>>>>>>>>
>>>>>>>>>>>> This is unlikely to cause any behavioral change.
>>>>>>>>>>>>
>>>>>>>>>>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>   =20
>>>>>>>>>>>
>>>>>>>>>>> There are some relatively superficial problems noted below.
>>>>>>>>>>>
>>>>>>>>>>> But more fundamentally, this feels like it's extending an exi=
sting
>>>>>>>>>>> hack past the point of usefulness.
>>>>>>>>>>>
>>>>>>>>>>> The explicit check for is_ram_device() here has always bother=
ed me -
>>>>>>>>>>> it's not like a real bus bridge magically knows whether a tar=
get
>>>>>>>>>>> address maps to RAM or not.
>>>>>>>>>>>
>>>>>>>>>>> What I think is really going on is that even for systems with=
out an
>>>>>>>>>>> IOMMU, it's not really true to say that the PCI address space=
 maps
>>>>>>>>>>> directly onto address_space_memory.  Instead, there's a large=
, but
>>>>>>>>>>> much less than 2^64 sized, "upstream window" at address 0 on =
the PCI
>>>>>>>>>>> bus, which is identity mapped to the system bus.  Details wil=
l vary
>>>>>>>>>>> with the system, but in practice we expect nothing but RAM to=
 be in
>>>>>>>>>>> that window.  Addresses not within that window won't be mappe=
d to the
>>>>>>>>>>> system bus but will just be broadcast on the PCI bus and migh=
t be
>>>>>>>>>>> picked up as a p2p transaction.   =20
>>>>>>>>>>
>>>>>>>>>> Currently this p2p works only via the IOMMU, direct p2p is not=
 possible as
>>>>>>>>>> the guest needs to know physical MMIO addresses to make p2p wo=
rk and it
>>>>>>>>>> does not. =20
>>>>>>>>>
>>>>>>>>> /me points to the Direct Translated P2P section of the ACS spec=
, though
>>>>>>>>> it's as prone to spoofing by the device as ATS.  In any case, p=
2p
>>>>>>>>> reflected from the IOMMU is still p2p and offloads the CPU even=
 if
>>>>>>>>> bandwidth suffers vs bare metal depending on if the data double=
s back
>>>>>>>>> over any links.  Thanks, =20
>>>>>>>>
>>>>>>>> Sure, I was just saying that p2p via IOMMU won't be as simple as=
 broadcast
>>>>>>>> on the PCI bus, IOMMU needs to be programmed in advance to make =
this work,
>>>>>>>> and current that broadcast won't work for the passed through dev=
ices. =20
>>>>>>>
>>>>>>> Well, sure, p2p in a guest with passthrough devices clearly needs=
 to
>>>>>>> be translated through the IOMMU (and p2p from a passthrough to an=

>>>>>>> emulated device is essentially impossible).
>>>>>>>
>>>>>>> But.. what does that have to do with this code.  This is the memo=
ry
>>>>>>> area watcher, looking for memory regions being mapped directly in=
to
>>>>>>> the PCI space.  NOT IOMMU regions, since those are handled separa=
tely
>>>>>>> by wiring up the IOMMU notifier.  This will only trigger if RAM-l=
ike,
>>>>>>> non-RAM regions are put into PCI space *not* behind an IOMMMU. =20
>>>>>>
>>>>>> Duh, sorry, realised I was mixing up host and guest IOMMU.  I gues=
s
>>>>>> the point here is that this will map RAM-like devices into the hos=
t
>>>>>> IOMMU when there is no guest IOMMU, allowing p2p transactions betw=
een
>>>>>> passthrough devices (though not from passthrough to emulated devic=
es). =20
>>>>>
>>>>> Correct.
>>>>> =20
>>>>>>
>>>>>> The conditions still seem kind of awkward to me, but I guess it ma=
kes
>>>>>> sense. =20
>>>>>
>>>>> Is it the time to split this listener to RAM-listener and PCI bus l=
istener? =20
>>>>
>>>> I'm not really sure what you mean by that.
>>>>  =20
>>>>> On x86 it listens on the "memory" AS, on spapr - on the
>>>>> "pci@800000020000000" AS, this will just create more confusion over=
 time... =20
>>>>
>>>> Hm, it's still logically the same AS in each case - the PCI address
>>>> space.  It's just that in the x86 case that happens to be the same a=
s
>>>> the memory AS (at least when there isn't a guest side IOMMU). =20
>>>
>>> Hm. Ok.
>>>
>>>> I do wonder if that's really right even for x86 without IOMMU.  The
>>>> PCI address space is identity mapped to the "main" memory address
>>>> space there, but I'm not sure it's mapped th *all* of the main memor=
y =20
>>>
>>> What should have been in the place of "th" above? :)
>>>
>>>> address space, probably just certain ranges of it.  That's what I wa=
s
>>>> suggesting earlier in the thread. =20
>>>
>>> afaict vfio is trying to mmap every RAM MR =3D=3D KVM memory slot, no=
 ranges or
>>> anything like that. I am trying to figure out what is not correct wit=
h the
>>> patch. Thanks,
>>
>> It is possible for x86 systems to have translation applied to MMIO vs
>> RAM such that the processor view and device view of MMIO are different=
,
>> putting them into separate address spaces, but this is not typical and=

>> not available on the class of chipsets that QEMU emulates for PC.
>> Therefore I think it's correct that MMIO and RAM all live in one big
>> happy, flat address space as they do now (assuming the guest IOMMU is
>> not present or disabled).  Thanks,
>=20
> Ah.. I think the thing I was missing is that on PC (at least with
> typical chipsets) *all* MMIO essentially comes from PCI space.  Even
> the legacy devices are essentially ISA which is treated as being on a
> bridge under the PCI space.  On non-x86 there are often at least a
> handful of MMIO devices that aren't within the PCI space - say, the
> PCI host bridge itself at least.  x86 avoids that by using the
> separate IO space, which is also a bit weird in that it's
> simultaneously direct attached to the cpu (and so doesn't need bridge
> configuration), but also identified with the legay IO space treated as
> being under two bridges (host->PCI, PCI->ISA) for other purposes.
>=20
> Maybe it's just me, but I find it makes more sense to me if I think of
> it as the two ASes being equal because on PC the system address map
> (address_space_memory) is made equal to the PCI address map, rather
> than the PCI address map being made equal to the system one.

It makes more sense to me too, we just do not exploit/expose this on SPAP=
R
- the PCI address space only has 2xIOMMU and 1xMSI windows and that's it,=

no MMIO which is mapped to the system AS only (adding those to the PCI AS=

is little tricky as mentioned elsewhere).

Anyway, I still wonder - what needs to be addressed in the 2/4 patch in
order to proceed?



--=20
Alexey


--ETYCnhiZRNElnUHBGWiGUYdpngbm6aTEq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEZSrPibrORRTHQ99dhhM92CvBILkFAlqKOpsOHGFpa0Bvemxh
YnMucnUACgkQhhM92CvBILk0rRAAwbFERB0gnIWjP9gnzEU7JVnQXc7xDyqO85ri
a55J1BbVkwE9z1gGD1lFSYbS9NveR9acEI/FVG10D+g+Y2dg1U9hjW8hu0duvSj0
QFceDbYaRDAi+tWJak4p/CurBdLlZwUYxULSypxxs4iIYNyCR0vlSn5FluWLFNh5
b/GOupbxIP33MFX7/CsCsEx8rzZz/1vIZFKda2KSCTO1nf2knuWTPXd61dzjM0IM
l+fJT9ZCdSYIG96316bEkWfXC+WjTgcOSRy7nC2e0HIJ0K9SPWrFQSxwr927i3Q/
TY3r6oAKXS3IbpQMpvuhF1Vkvz2rTKNhvDnMZA99+3X/66vJAdEBfEA1tvz/yFgc
25WVy9kAaNs3ol9xpnELezltqhzc6ban085Zqxid26ao5xGe9DA5xmEFxf2cT8OG
XispdfaPHsI6zYT4s34RbKxwXECbr9iBfaT5h47EwZzvHd/OCWg+y4JexYKsH/Mq
qVdV0mDgX3wmnHbcxyW8D7/b9W4fHezfi6UKg178EUMDZIVm7OfveF7Xr2he32bI
dtYnfq6JQfH3imjlzH2A8DjS2Tof/MfdhmelGMW/zgO6/+JZTKAlYXWO/CxWb16c
PoHSl0a0tkS2uDhGrziPQrPr3UzIoxWYi0A0l5urCuilxrq6B3DeWpGBPoQx3l7n
J1x9iCY=
=SUA0
-----END PGP SIGNATURE-----

--ETYCnhiZRNElnUHBGWiGUYdpngbm6aTEq--
