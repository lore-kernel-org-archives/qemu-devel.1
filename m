Received: from eggs.gnu.org ([209.51.188.92]:40507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gldB8-0005eW-Ed
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 12:16:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gldB7-00038x-LP
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 12:16:06 -0500
References: <20190116113523.9213-1-david@redhat.com>
	<20190116113523.9213-5-david@redhat.com>
	<7c7cfe1c-16c6-fe1b-0e9f-796502e75652@redhat.com>
	<d816bd88-1f59-e698-7819-2cb72c820706@redhat.com>
	<20190121120252.GB2083@work-vm>
	<5c645aaa-6521-fcc6-1fef-adefe11e5ea9@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8de5c4a4-27fe-7fe3-8605-8871fa376994@redhat.com>
Date: Mon, 21 Jan 2019 11:15:55 -0600
MIME-Version: 1.0
In-Reply-To: <5c645aaa-6521-fcc6-1fef-adefe11e5ea9@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="e9neVyLuLGkz1ax7uyArJb3J2R48K7Duj"
Subject: Re: [Qemu-devel] [PATCH RFC 04/10] virtio-pmem: Prototype
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Collin Walling <walling@linux.ibm.com>, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Pankaj Gupta <pagupta@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--e9neVyLuLGkz1ax7uyArJb3J2R48K7Duj
From: Eric Blake <eblake@redhat.com>
To: David Hildenbrand <david@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Eduardo Habkost <ehabkost@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, Cornelia Huck
 <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Collin Walling <walling@linux.ibm.com>, Markus Armbruster
 <armbru@redhat.com>, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 Pankaj Gupta <pagupta@redhat.com>
Message-ID: <8de5c4a4-27fe-7fe3-8605-8871fa376994@redhat.com>
Subject: Re: [PATCH RFC 04/10] virtio-pmem: Prototype
References: <20190116113523.9213-1-david@redhat.com>
 <20190116113523.9213-5-david@redhat.com>
 <7c7cfe1c-16c6-fe1b-0e9f-796502e75652@redhat.com>
 <d816bd88-1f59-e698-7819-2cb72c820706@redhat.com>
 <20190121120252.GB2083@work-vm>
 <5c645aaa-6521-fcc6-1fef-adefe11e5ea9@redhat.com>
In-Reply-To: <5c645aaa-6521-fcc6-1fef-adefe11e5ea9@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/21/19 7:31 AM, David Hildenbrand wrote:

>>>>>  ##
>>>>>  # @MemoryDeviceInfo:
>>>>>  #
>>>>> @@ -2958,7 +2981,8 @@
>>>>>  ##
>>>>>  { 'union': 'MemoryDeviceInfo',
>>>>
>>>> Does this union need a documentation update that virtio-pmem was add=
ed
>>>> in 4.0?
>>>
>>> Seems like:
>>>
>>> ##
>>> # @MemoryDeviceInfo:
>>> #
>>> # Union containing information about a memory device
>>> #
>>> # @dimm: Information about a pc-dimm device.
>>> #
>>> # @nvdimm: Information about a nvdimm device. (since 2.12)
>>> #
>>> # @virtio-pmem: Information about a virtio-pmem device. (since 4.0)
>>> #
>>> # Since: 2.1
>>> ##
>>>
>>> Does not work.
>>>
>>> In file included from /home/dhildenb/git/qemu/qapi/qapi-schema.json:9=
7:
>>> /home/dhildenb/git/qemu/qapi/misc.json:2975: The following documented=

>>> members are not in the declaration: dimm, nvdimm, virtio-pmem
>>>
>>> Any idea how to document this correctly?
>>
>> No I don't, but looking at other Union's they only ever seem to docume=
nt
>> the base members, not the data members, for example see CpuInfo.
>>
>=20
> Yes, that's also what I noticed. Guess I'll simply change that to
>=20
> "nvdimm is included since 2.12. virtio-pmem is included since 4.0."

Seems okay to me if we can't come up with something better.

>=20
> Unless Eric has another idea.

Or maybe Markus, since he's more familiar with the doc generator.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--e9neVyLuLGkz1ax7uyArJb3J2R48K7Duj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxF/ksACgkQp6FrSiUn
Q2rtcQf/c4rIQ5SfXTFTgmG6p7VDglXB75ySqFPwvNWp2n/9T0wCcbr79EuzMiN7
j2XJZYlRmlGmOGT/S/OHBL4Gn7Q6kPGQKy8+b1RmW8Y6VWBaYKTmP/Ap3EwYMNBz
o2th8M4dqpfJhihfJIxFprwd1CneH/dBvrrB9LnWFLmop1j4XWBLBNAqEyqkC7PO
HqeH+toiHq88raE0n4m0rjHjeFrAENh2aKefstgqCXf/MiFmktzVLYWJ5VHvvLcH
5KfkR1M8cGZakchji3l2OatYNUMCvUibL0cUso0OTfj8eiNWp1bSsdYHqCu8IXKo
lSuSNLRxV80q5VFO/3tCtv1O5XDMMg==
=Uh6W
-----END PGP SIGNATURE-----

--e9neVyLuLGkz1ax7uyArJb3J2R48K7Duj--
