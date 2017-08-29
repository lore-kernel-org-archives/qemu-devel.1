Received: from eggs.gnu.org ([2001:4830:134:3::10]:56211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dmhY3-0006rc-Dw
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 10:31:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dmhY2-0007dn-G3
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 10:31:23 -0400
References: <f5ef1341-cfe2-6e20-3f98-b08ef2f7d373@redhat.com>
	<a81c8dfb-3d98-57ad-8159-5147283433fa@virtuozzo.com>
	<cb783ebb-198e-1814-2f9c-aec93c83b17a@virtuozzo.com>
	<0988b4ef-56e2-5ce9-ed25-40a742eadbd4@redhat.com>
	<b0d72a26-2052-ecc6-67f5-d32572804ebf@redhat.com>
	<cfcca274-9e3b-a9d5-6470-6c8917085da4@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4f3aff4d-7277-3277-985b-27d7e6fdaedd@redhat.com>
Date: Tue, 29 Aug 2017 09:30:43 -0500
MIME-Version: 1.0
In-Reply-To: <cfcca274-9e3b-a9d5-6470-6c8917085da4@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Uj54WnTOU5WhoejV37nsljt2OQP8ts00d"
Subject: Re: [Qemu-devel] Persistent bitmaps for non-qcow2 formats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Qemu-block <qemu-block@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Manos Pitsidianakis <el13635@mail.ntua.gr>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Uj54WnTOU5WhoejV37nsljt2OQP8ts00d
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Qemu-block <qemu-block@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <4f3aff4d-7277-3277-985b-27d7e6fdaedd@redhat.com>
Subject: Re: [Qemu-devel] Persistent bitmaps for non-qcow2 formats
References: <f5ef1341-cfe2-6e20-3f98-b08ef2f7d373@redhat.com>
 <a81c8dfb-3d98-57ad-8159-5147283433fa@virtuozzo.com>
 <cb783ebb-198e-1814-2f9c-aec93c83b17a@virtuozzo.com>
 <0988b4ef-56e2-5ce9-ed25-40a742eadbd4@redhat.com>
 <b0d72a26-2052-ecc6-67f5-d32572804ebf@redhat.com>
 <cfcca274-9e3b-a9d5-6470-6c8917085da4@redhat.com>
In-Reply-To: <cfcca274-9e3b-a9d5-6470-6c8917085da4@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/28/2017 08:18 PM, John Snow wrote:
>>> We'd have to develop a new syntax for specifying these resources that=

>>> can be stored in a qcow2 file,
>>
>> It's called the json-pseudo-protocol and was developed exactly for thi=
s.
>>
>=20
> That's what I was hinting at for "or otherwise co-opt an existing
> syntax" but I was unaware that it was intended for "exactly" this.
>=20
> Do we actually use it in any on-disk format, currently? qcow2 only lets=

> you specify simple filenames in the qcow2 metadata, right?

You can specify json-pseudo backing names both on the command line AND
embedded in the qcow2 file itself (within the length limits imposed by
the qcow2 header size).  Yes, this means it is already possible to
create qcow2 files that can only be opened by qemu (or else teaching
your alternative program how to parse qemu's json-pseudo-protocol).

>=20
>>>                                or otherwise co-opt an existing syntax=

>>> in-use by QEMU. This syntax would likely be useful only to QEMU, whic=
h
>>> would steer the qcow2 format in a direction not too useful by other
>>> emulators, and qcow2 is an open format, so we may want to avoid this.=

>>
>> Storing a file name in the backing link field that cannot be interpret=
ed
>> by other programs is in my opinion still very much better than not
>> storing any information whatsoever, because in the former case other
>> programs can at least say "sorry, I have no idea what this means" (or
>> maybe they can indeed interpret it, who knows), whereas in the latter
>> they may not even know that the qcow2 image is incomplete.
>>
>=20
> I don't disagree personally, but I seem to recall that Kevin was adaman=
t
> that the qcow2 bitmap extension should remain useful and semantically
> meaningful to third parties, so I try to keep that in mind. Maybe I
> should let him chime in instead of try to "concern troll" my own
> suggestions into the ground.

We already have that situation today, but you are right to worry about
whether making it even more prevalent is something we can try to minimize=
=2E

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Uj54WnTOU5WhoejV37nsljt2OQP8ts00d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmlepMACgkQp6FrSiUn
Q2r9zQf/f+XHkvJDYnbTRnDPCGEIuk8znQUCPf+Pj48JXPzkcl83fC3qmeZ8MRD9
OaB+W76viw2xA9Qi0HW8y5dNbRvXsjZx74Mgf05ZL3NHphvAdFcQSrtNx1834wx8
6PbArmPMXJh2HFlPGa6idabCJNmldMUU/QAemUquiVfjJYrvIbxO2BkfTYtuwtel
f/XGX+IB/6QDAgNDKLS3epUWcE0i68isyEZQ/G5euyDPj4r2VcTT6dMZy0dkwiZJ
BSxW97uHki1AvKwsSQ3z8ujx2UHqGRSozQvPkKyxDL3eEkd0qTXe/BntCvcj1yON
rFe/v5n1h3J6N21BJ0CbAz7RDOlPzQ==
=ExcX
-----END PGP SIGNATURE-----

--Uj54WnTOU5WhoejV37nsljt2OQP8ts00d--
