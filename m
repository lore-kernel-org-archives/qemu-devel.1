Received: from eggs.gnu.org ([209.51.188.92]:53951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h1VtX-0000F1-Hy
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 07:43:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h1VtW-0006qH-Mu
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 07:43:35 -0500
References: <20190227172256.30368-1-kwolf@redhat.com>
	<20190227172256.30368-4-kwolf@redhat.com>
	<20190301161724.GB18260@stefanha-x1.localdomain>
	<d6ba8e66-5ddf-9091-ff44-5024a53240a8@redhat.com>
	<20190306095147.GF22159@stefanha-x1.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ec417842-c9f4-7a7e-e49f-4d509115e540@redhat.com>
Date: Wed, 6 Mar 2019 06:43:30 -0600
MIME-Version: 1.0
In-Reply-To: <20190306095147.GF22159@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="IKjfvwoBb0kI23egAhJlHv8NFIq9JvHyx"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 03/20] qcow2: Extend spec for
 external data files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IKjfvwoBb0kI23egAhJlHv8NFIq9JvHyx
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, mreitz@redhat.com
Message-ID: <ec417842-c9f4-7a7e-e49f-4d509115e540@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 03/20] qcow2: Extend spec for
 external data files
References: <20190227172256.30368-1-kwolf@redhat.com>
 <20190227172256.30368-4-kwolf@redhat.com>
 <20190301161724.GB18260@stefanha-x1.localdomain>
 <d6ba8e66-5ddf-9091-ff44-5024a53240a8@redhat.com>
 <20190306095147.GF22159@stefanha-x1.localdomain>
In-Reply-To: <20190306095147.GF22159@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 3/6/19 3:51 AM, Stefan Hajnoczi wrote:
> On Fri, Mar 01, 2019 at 10:32:27AM -0600, Eric Blake wrote:
>> On 3/1/19 10:17 AM, Stefan Hajnoczi wrote:
>>> On Wed, Feb 27, 2019 at 06:22:39PM +0100, Kevin Wolf wrote:
>>>> @@ -148,6 +170,7 @@ be stored. Each extension has a structure like t=
he following:
>>>>                          0x6803f857 - Feature name table
>>>>                          0x23852875 - Bitmaps extension
>>>>                          0x0537be77 - Full disk encryption header po=
inter
>>>> +                        0x44415441 - External data file name
>>>
>>> This new header extension isn't described in this patch?
>>
>> I asked the same on v1, and the answer (which remains valid) is that
>> neither is 0xe2792aca Backing file format name.  (In other words, both=

>> extensions are simple enough as a single file name to be implicitly
>> described by the reference to the header in the earlier text).  Making=

>> both explicit wouldn't hurt my feelings, but I don't see it as a
>> showstopper to the patch as-is.
>=20
> The spec should make the representation clear.  Is it a NUL-terminated
> string or is the length dictated by the header extension length field?

My understanding is length determined by the header field, with optional
NUL padding out to the alignment boundary (but that also means that it
does NOT necessarily have a trailing NUL on disk if sizing matches
alignment).  But yes, being explicit never hurts.

>=20
> Otherwise implementors are forced to look at the QEMU source code or
> guess based on hex dumping example files :(.

Indeed, cleaning up the existing Backing file format name is worth doing
(at which point this should follow suit). But it still sounds like a
separate patch, at which point it becomes a question of ordering - if
the cleanup lands first, then this needs to rebase to do the same; if
this lands first, then the cleanup does both headers at once.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--IKjfvwoBb0kI23egAhJlHv8NFIq9JvHyx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlx/wHIACgkQp6FrSiUn
Q2peNQf/eQIFfT469W/CklfWMmGtf0+7y2+pUR+YvcDoUuyG1DdEhglUZf/qpm9e
YY2qmlj9QF3gMHOmfGvs/sQPNr2qfsl+IzvlmoJ5D9dINRNizMu2V6EzNs3XZaGW
Kkx0RYD9AWeaOlIRdMCRu3sx8TjjbPXPC+QsIQpcLBwI3tz8GEPCx3dlgz04x9Ww
vu9puY9MIycLyAAbdhWqX/73TJlnaD4eQvjW0wN6PGZSSY3eARedD0dAh/5+Achw
bunPoDvx5f3uT8uM++T6zbcQSFLVEhsinEoul83WoVkPoEOwqfzSjm2v9Ha2zF49
D18BvLK7/lZ2KBWzncZzJXN+zE5LPA==
=4RU6
-----END PGP SIGNATURE-----

--IKjfvwoBb0kI23egAhJlHv8NFIq9JvHyx--
