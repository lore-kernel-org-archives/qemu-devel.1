Received: from eggs.gnu.org ([2001:4830:134:3::10]:55150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f8nTE-0004Y9-Eg
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 09:50:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f8nTD-0008Vu-JD
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 09:50:00 -0400
References: <20180227155514.16721-1-eblake@redhat.com>
	<20180227162944.17343-2-eblake@redhat.com>
	<w51vaehpfzw.fsf@maestria.local.igalia.com>
	<89477aaf-a1af-861d-fcd5-5bfe2143f8b8@redhat.com>
	<w51po4pp54z.fsf@maestria.local.igalia.com>
	<f1d1c403-1a2a-aee2-5fe6-7cfbb81339d6@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5430e92a-db1e-e853-e7d8-1b31cbfc0edc@redhat.com>
Date: Wed, 18 Apr 2018 08:49:55 -0500
MIME-Version: 1.0
In-Reply-To: <f1d1c403-1a2a-aee2-5fe6-7cfbb81339d6@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="dPKjYJMMpOLJSZ54fHoHi3GFKO0wQUSrr"
Subject: Re: [Qemu-devel] [PATCH v4 2/5] qcow2: Document some maximum size
 constraints
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dPKjYJMMpOLJSZ54fHoHi3GFKO0wQUSrr
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com
Message-ID: <5430e92a-db1e-e853-e7d8-1b31cbfc0edc@redhat.com>
Subject: Re: [PATCH v4 2/5] qcow2: Document some maximum size constraints
References: <20180227155514.16721-1-eblake@redhat.com>
 <20180227162944.17343-2-eblake@redhat.com>
 <w51vaehpfzw.fsf@maestria.local.igalia.com>
 <89477aaf-a1af-861d-fcd5-5bfe2143f8b8@redhat.com>
 <w51po4pp54z.fsf@maestria.local.igalia.com>
 <f1d1c403-1a2a-aee2-5fe6-7cfbb81339d6@redhat.com>
In-Reply-To: <f1d1c403-1a2a-aee2-5fe6-7cfbb81339d6@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/13/2018 12:08 PM, Max Reitz wrote:

>>>> With 512 byte clusters and 64 bit refcount entries I still get 8 PB,=

>>>> way over what's limited by the L1/L2 tables (128 GB).
>>>
>>> Do I need to make any modifications to the sentence, then?
>>
>> I guess what surprised me the first time that I read it was that it
>> suggests that this has to be taken into account when calculating the
>> physical limits of an image, while in practice it can be ignored.
>>
>> You could say something like=20
>>
>>   Although the larger the cluster size, the larger the offsets that ca=
n
>>   be covered by the refcount table, in practice these limits cannot be=

>>   reached because they are larger than the ones imposed by other data
>>   structures.
>=20
> Are there any updates here?  I guess I personally would just drop the
> whole paragraph, because I think it really doesn't matter...

Yeah, I need to post a v5 of this series now that 2.13 is nearly open.

>=20
> Also note that the maximum file size of ext4 is 16 PB (for 4 kB blocks)=
=2E
>  OK, it's bigger for XFS, but that still gives some perspective.
>=20
> Also, long before anyone is going to complain about the specification
> failing to mention that limit, they are going to complain that qemu
> refuses to open their image (because of its limit on the reftable size)=
=2E
>=20
> Max
>=20
>> although I'm sure that you can come up with a better wording than mine=
 :)
>>
>> Berto
>>
>=20
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--dPKjYJMMpOLJSZ54fHoHi3GFKO0wQUSrr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrXTQMACgkQp6FrSiUn
Q2qTLAgAncTmDTUIzwGREGNyYZW+uGNCf/UVSN8XKteS6IH4GBYA6Uf7DrfbGeiw
8k8wLynC41tRshMtovoXPfKfk9Kt828gAHcv0AMSmJZJKAPczUiq6KftkBgIbK+D
xeNMSJARzIS/xDtvNPxfi9BqYgQkmeGD1f5EZQzmo/OvcAFZG+l2oHXlQuYGLfwh
uT/lFyV5MjRGcAke/NuL/Sty4zTNsBsvoEMGyvGqah1F/nWyAlHpCl6uasyCIafu
I1vWIpALe/cxXcfTb17IEVPKuKC8kW2WQFHb8aTMD9URpDoUHtQWa86y8SfmQqz8
9vHc6BOmdfHEpFVSHP+Z50eDKDS+sQ==
=LV+l
-----END PGP SIGNATURE-----

--dPKjYJMMpOLJSZ54fHoHi3GFKO0wQUSrr--
