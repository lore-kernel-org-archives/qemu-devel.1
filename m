Received: from eggs.gnu.org ([2001:4830:134:3::10]:47867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dnrta-0000Eb-L1
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 15:46:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dnrtW-0007TA-MS
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 15:46:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37500)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dnrtW-0007SX-DW
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 15:46:22 -0400
References: <1504190408-11143-1-git-send-email-thuth@redhat.com>
	<612870af-f8a4-039c-3e97-7590388b9e77@redhat.com>
	<87o9qudbsk.fsf@dusky.pond.sub.org>
	<96af6291-8427-89c8-c644-a3d82c3240c8@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a9a20aa6-c016-75f6-48ed-b95765895209@redhat.com>
Date: Fri, 1 Sep 2017 14:46:07 -0500
MIME-Version: 1.0
In-Reply-To: <96af6291-8427-89c8-c644-a3d82c3240c8@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="OEQGvPSKW00SGN2Lce1O1aSHxsLitlrmh"
Subject: Re: [Qemu-devel] [PATCH v2] tests: Enable the drive_del test also
 on s390x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, David Hildenbrand <david@redhat.com>
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>, Farhan Ali <alifm@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>, Michael S Tsirkin <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Jason J Herne <jjherne@linux.vnet.ibm.com>, Cleber Rosa <crosa@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OEQGvPSKW00SGN2Lce1O1aSHxsLitlrmh
From: Eric Blake <eblake@redhat.com>
To: Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>,
 Farhan Ali <alifm@linux.vnet.ibm.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, Michael S Tsirkin <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>,
 qemu-devel@nongnu.org, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Jason J Herne <jjherne@linux.vnet.ibm.com>, Cleber Rosa <crosa@redhat.com>,
 Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Message-ID: <a9a20aa6-c016-75f6-48ed-b95765895209@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] tests: Enable the drive_del test also on
 s390x
References: <1504190408-11143-1-git-send-email-thuth@redhat.com>
 <612870af-f8a4-039c-3e97-7590388b9e77@redhat.com>
 <87o9qudbsk.fsf@dusky.pond.sub.org>
 <96af6291-8427-89c8-c644-a3d82c3240c8@redhat.com>
In-Reply-To: <96af6291-8427-89c8-c644-a3d82c3240c8@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/01/2017 05:39 AM, Thomas Huth wrote:
>>>>      /* Start with a drive used by a device that unplugs instantaneo=
usly */
>>>> -    qtest_start("-drive if=3Dnone,id=3Ddrive0,file=3Dnull-co://,for=
mat=3Draw"
>>>> -                " -device virtio-scsi-pci"
>>>> -                " -device scsi-hd,drive=3Ddrive0,id=3Ddev0");
>>>> +    args =3D g_strdup_printf("-drive if=3Dnone,id=3Ddrive0,file=3Dn=
ull-co://,format=3Draw"
>>>> +                           " -device virtio-scsi-%s"
>>>> +                           " -device scsi-hd,drive=3Ddrive0,id=3Dde=
v0",
>>>
>>> Would look better with the spaces at the end of the previous line (so=

>>> all "-device" are aligned), but just my taste.
>>
>> The -device *are* aligned, but I get what you mean.
>>
>> The advantage of leading rather than trailing space is that the
>> intention "this is still the same string" is locally obvious both at t=
he
>> first part's end (no comma) and at the second part's beginning (leadin=
g
>> space).
>=20
> I don't mind either way, but in this case, I think I'd prefer to keep
> the original formatting with the space at the beginning, for the
> following two reasons:
>=20
> - The first line is already hitting the 80 columns limit, and I want to=

>   avoid complaints from checkpatch.pl
> - The original author formatted it that way.

As it is, I got annoyed by the fact that we had so much strdup() of args
to pass to qtest_init/qtest_start(), so my latest series reformats the
code yet another way:
https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg00308.html

Prone to cause some fun conflict resolution if my cleanups take too long
to get in the tree...

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--OEQGvPSKW00SGN2Lce1O1aSHxsLitlrmh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmpuP8ACgkQp6FrSiUn
Q2p0EggArP3TiOcpNAzYn86kJjv55v6nwKsfiO09Vj+0z6U1oLGBxPey8moyygtN
fhdIxHGxXz/h6QaQ8H2fRnHy9hMBu0Giz9AANkJVUjlzlOmVsi0JyNFPMlsv0aLk
ApXTmejZVGmn+vbCFVxMFUR58jExH9dXpoEr9Usdu8/9K2VCa371OWGiexD4VjXE
6mBX77XxX/uaWK7AicwAYiGf30Izs20ql4W3+XPWmEHmMkC93OMkcSjxv3f4UuO8
CD+urC6XLFOgxrfJyq68icfPnkssPlJfKDiyTvS0UK3Csf2nPAKnl2PwZOzJn57c
81UHx/A0wt4FvdgPnrTVSnLi2W4gJA==
=ckRV
-----END PGP SIGNATURE-----

--OEQGvPSKW00SGN2Lce1O1aSHxsLitlrmh--
