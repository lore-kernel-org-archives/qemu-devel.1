Received: from eggs.gnu.org ([2001:4830:134:3::10]:40120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dZy3B-0000f5-6k
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 07:30:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dZy38-0000h0-1f
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 07:30:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37678)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dZy37-0000gg-Ov
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 07:30:49 -0400
References: <150091574424.30739.4131793221953168474.stgit@frigg.lan>
	<150091841019.30739.3661641061220051037.stgit@frigg.lan>
	<109e1849-1bf6-5875-b304-7cacbf45f068@redhat.com>
	<87wp6wgbzw.fsf@frigg.lan>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3a8accf6-2805-e2fa-1d58-1db85558c7a5@redhat.com>
Date: Tue, 25 Jul 2017 06:30:42 -0500
MIME-Version: 1.0
In-Reply-To: <87wp6wgbzw.fsf@frigg.lan>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6wS9M24Qrr2eR0furJfI0AEpJk2xDBneF"
Subject: Re: [Qemu-devel] [PATCH 11/13] instrument: [qapi] Add library loader
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, "Emilio G. Cota" <cota@braap.org>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6wS9M24Qrr2eR0furJfI0AEpJk2xDBneF
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org, "Emilio G. Cota" <cota@braap.org>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <3a8accf6-2805-e2fa-1d58-1db85558c7a5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 11/13] instrument: [qapi] Add library loader
References: <150091574424.30739.4131793221953168474.stgit@frigg.lan>
 <150091841019.30739.3661641061220051037.stgit@frigg.lan>
 <109e1849-1bf6-5875-b304-7cacbf45f068@redhat.com> <87wp6wgbzw.fsf@frigg.lan>
In-Reply-To: <87wp6wgbzw.fsf@frigg.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/25/2017 03:24 AM, Llu=C3=ADs Vilanova wrote:
> Eric Blake writes:
>=20
>> On 07/24/2017 12:46 PM, Llu=C3=ADs Vilanova wrote:
>>> Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
>>> ---
>>> instrument/Makefile.objs |    1 +
>>> instrument/qmp.c         |   71 ++++++++++++++++++++++++++++++++++++
>>> qapi-schema.json         |    3 ++
>>> qapi/instrument.json     |   92 +++++++++++++++++++++++++++++++++++++=
+++++++++
>>> 4 files changed, 167 insertions(+)
>>> create mode 100644 instrument/qmp.c
>>> create mode 100644 qapi/instrument.json
>=20
>> Adding new files; but I don't see a patch to MAINTAINERS to cover
>> instrument/*.
>=20
> Who should I put as a maintainer? Or does this go to the general mainta=
iner(s)?

You can be the maintainer if you'd like; or see if Stefan is okay
including it as part of the trace files, since it trace-related.


>>> +##
>>> +{ 'command': 'instr-load',
>>> +  'data':    { 'path': 'str', '*args': ['String'] },
>=20
>> Why are you double-nesting things?  It's a lot nicer to use ['str']

> Aha, you mean the definition should be this instead?
>=20
>   { 'command': 'instr-load',
>     'data':    { 'path': 'str', '*args': ['str'] },
>     'returns': 'InstrLoadResult' }

Yes.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--6wS9M24Qrr2eR0furJfI0AEpJk2xDBneF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll3K+IACgkQp6FrSiUn
Q2q2WwgAlfSyXIgr5Qca7b9iP8CK2sOd3W7JpgelaOZ9Xrs1T2eL2jnmuGd8TroB
D+ejzGJBGcMgYuUX1ud2ONSRoAMjGECEs9qTWBZ6wlWNZkl/GhylDtVzEjIUHoY2
/3Z2/P8dD1hEpGAaiI+mXsIICV/dmIamKcS1opMuNOSpsQDy86hXcIEPgj69jGCV
wP2P28XAv5Ve+duY30D9iKgr7Ib1woPHY2N1D/TVPpAiTmqWeADKqR8+HT3HwJ7a
0xpjifmXVu6dbrEjXlxGqztGFIJgVK/soKb2Y4sbMju3W7aPAc0WY/U8/4qL6v9Y
jOODOq4nCBE5MkaVjHIFpmZksEBd9w==
=h4Io
-----END PGP SIGNATURE-----

--6wS9M24Qrr2eR0furJfI0AEpJk2xDBneF--
