Received: from eggs.gnu.org ([2001:4830:134:3::10]:48629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eEFUM-0006Zo-QM
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 09:13:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eEFUG-0000RS-RK
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 09:13:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42202)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eEFUG-0000R2-Hi
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 09:13:20 -0500
References: <37193dd7-a0fc-bfa6-3870-ecbcfefac4e5@virtuozzo.com>
	<bf31a83e-7cd6-4f26-595b-3b1a2def883f@redhat.com>
	<608ba1f1-38b3-7312-e27b-8a62b197d53e@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f109edd5-ef86-ff6d-c242-e0731d919c77@redhat.com>
Date: Mon, 13 Nov 2017 08:13:16 -0600
MIME-Version: 1.0
In-Reply-To: <608ba1f1-38b3-7312-e27b-8a62b197d53e@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="0NIbDvM5X26nIE76cLdHvCU4HdscEKXmB"
Subject: Re: [Qemu-devel] NBD BLOCK_STATUS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Wouter Verhelst <w@uter.be>, Alex Bligh <alex@alex.org.uk>, nbd list <nbd@other.debian.org>, qemu-devel <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0NIbDvM5X26nIE76cLdHvCU4HdscEKXmB
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Wouter Verhelst <w@uter.be>, Alex Bligh <alex@alex.org.uk>,
 nbd list <nbd@other.debian.org>, qemu-devel <qemu-devel@nongnu.org>
Message-ID: <f109edd5-ef86-ff6d-c242-e0731d919c77@redhat.com>
Subject: Re: NBD BLOCK_STATUS
References: <37193dd7-a0fc-bfa6-3870-ecbcfefac4e5@virtuozzo.com>
 <bf31a83e-7cd6-4f26-595b-3b1a2def883f@redhat.com>
 <608ba1f1-38b3-7312-e27b-8a62b197d53e@virtuozzo.com>
In-Reply-To: <608ba1f1-38b3-7312-e27b-8a62b197d53e@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/10/2017 10:51 AM, Vladimir Sementsov-Ogievskiy wrote:
> 10.11.2017 19:06, Eric Blake wrote:
>> On 11/09/2017 06:42 AM, Vladimir Sementsov-Ogievskiy wrote:
>>> Hi!
>>>
>>> Interesting fact: list/set_meta_context options are per-export,
>>> so, in the server we should keep context selection per client per
>>> export.
>>>
>>> And it is possible for client to set contexts for one export and than=

>>> proceed
>>> to transmission phase with another one.
>> However, we also documented in the spec that
>>
>> +=C2=A0=C2=A0=C2=A0 A client MUST NOT send `NBD_CMD_BLOCK_STATUS` unle=
ss
>> +=C2=A0=C2=A0=C2=A0 within the negotiation phase it sent `NBD_OPT_SET_=
META_CONTEXT`
>> +=C2=A0=C2=A0=C2=A0 at least once, and the final time it was sent, it =
referred
>> +=C2=A0=C2=A0=C2=A0 to the export name that was ultimately selected, t=
he server
>> +=C2=A0=C2=A0=C2=A0 responded without an error, and returned at least =
one metadata
>> +=C2=A0=C2=A0=C2=A0 context.
>=20
> I've missed this, then it's OK.
>=20
> maybe "ultimately selected for transmission phase" would be a bit bette=
r.

Sure, I'll queue that up for my next round of doc tweaks.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--0NIbDvM5X26nIE76cLdHvCU4HdscEKXmB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloJqHwACgkQp6FrSiUn
Q2pUpQf+IgUmd2t+G2u0yR7IxD1BykCU2jdrdmPfOl7kQSslM1a0nixlnkxkqoK7
+bfJZ07/tJdHMHp+C3WX8oG0+hyNw/b7Z6kutea8/6cwRpru/I5XXTPVlAXthv/F
hxZZKDMzSlBFDglaqQpVde/N/XbHvaB83Gb3HgqKMmd8QBeRVjA3A8hdoMYnqJVl
t6GOpTVDxYIWu0reYZYMGNw9JxawaLM3kwjBd5KdxlMIEdcVhuOnuWWGLYY4uxvz
t8SuazIlQRvo2OAdsoWsR70jxGJZExMiE1hmzTPpNF9jFT+qOEIaS9WruVbdBQCx
LX8Bbb/Q31K4Eoli9ugnl+l4MP3C+g==
=xrTh
-----END PGP SIGNATURE-----

--0NIbDvM5X26nIE76cLdHvCU4HdscEKXmB--
