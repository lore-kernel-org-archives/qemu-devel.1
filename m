Received: from eggs.gnu.org ([2001:4830:134:3::10]:55568)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1gQhgu-0001SQ-FZ
	for qemu-devel@nongnu.org; Sat, 24 Nov 2018 18:50:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1gQhgp-0003dl-Go
	for qemu-devel@nongnu.org; Sat, 24 Nov 2018 18:50:24 -0500
Received: from mout.gmx.net ([212.227.17.20]:50185)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1gQhgp-0003YM-6p
	for qemu-devel@nongnu.org; Sat, 24 Nov 2018 18:50:19 -0500
From: Kamil Rytarowski <n54@gmx.com>
References: <20181114130428.32326-1-asanchez@kryptoslogic.com>
	<1782562d-41c7-0cc7-94f3-fb7ff4b7bd40@redhat.com>
	<adc671f3-808a-59ef-2650-2b558958a00f@gmx.com>
Message-ID: <61ab003f-1b0d-c17d-8827-4d31bba0a53e@gmx.com>
Date: Sun, 25 Nov 2018 00:50:56 +0100
MIME-Version: 1.0
In-Reply-To: <adc671f3-808a-59ef-2650-2b558958a00f@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="CPg6SgDjCG7FO4c7NdxUUqiE7Iy7mlAm0"
Subject: Re: [Qemu-devel] [PATCH] hax: Support for Linux hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Alexandro Sanchez Bach <asanchez@kryptoslogic.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, yu.ning@intel.com, Richard Henderson <rth@twiddle.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CPg6SgDjCG7FO4c7NdxUUqiE7Iy7mlAm0
From: Kamil Rytarowski <n54@gmx.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Alexandro Sanchez Bach <asanchez@kryptoslogic.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, yu.ning@intel.com,
 Richard Henderson <rth@twiddle.net>
Message-ID: <61ab003f-1b0d-c17d-8827-4d31bba0a53e@gmx.com>
Subject: Re: [Qemu-devel] [PATCH] hax: Support for Linux hosts
References: <20181114130428.32326-1-asanchez@kryptoslogic.com>
 <1782562d-41c7-0cc7-94f3-fb7ff4b7bd40@redhat.com>
 <adc671f3-808a-59ef-2650-2b558958a00f@gmx.com>
In-Reply-To: <adc671f3-808a-59ef-2650-2b558958a00f@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 22.11.2018 08:24, Kamil Rytarowski wrote:
> On 16.11.2018 13:52, Paolo Bonzini wrote:
>> On 14/11/18 14:04, Alexandro Sanchez Bach wrote:
>>> Intel HAXM supports now 32-bit and 64-bit Linux hosts. This patch inc=
ludes
>>> the corresponding userland changes.
>>>
>>> Since the Darwin userland backend is POSIX-compliant, the hax-darwin.=
{c,h}
>>> files have been renamed to hax-posix.{c,h}. This prefix is consistent=
 with
>>> the naming used in the rest of QEMU.
>>
>> What's the advantage of HAXM when Linux hosts can just run KVM?  I gue=
ss
>> avoiding bitrot?
>>
>> Paolo
>>
>=20
> This patch is also useful for NetBSD, even if it's not a Linux host.
> There is a driver in progress again (thanks to the newly added Linux
> port, it's now much easier to get done).
>=20
> I recommend to merge this patch.
>=20

For the record, I've a functional version of HAXM for NetBSD as host.
Once you will merge this patch, I will submit another one to configure
to enable haxm for NetBSD.

I need to keep the patch by Alexandro in a local copy of qemu.


--CPg6SgDjCG7FO4c7NdxUUqiE7Iy7mlAm0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJABAEBCAAqFiEELaxVpweEzw+lMDwuS7MI6bAudmwFAlv54+AMHG41NEBnbXgu
Y29tAAoJEEuzCOmwLnZsVXQP/AmGVgx9COabxPZwETcPBRW9anTaKbz39RJk6OrZ
N7U88XA+117ejwHHN/Cx0HeJZGb0WT1HtP3WzyVttp2nU++D2nCueu+4C4eqMMWe
JeVqUjgg6tvrNoVloErRKPRQ4x4AMdJxLI13ewdL9TL7CQHT+ylSJMA8UWbGFzoO
NJAgvqMpE544YGBxZ+jBHAMrENQ+/bwIqoMp75NiAqz6R3TpK+uImExxFcrfd1vl
FGl2Y/4k+Jrx3bMlgT8zYLXCVT3e4sbCudGKqFi1emZwGKERFvhY92Lh/LHWzVTc
gMmQADjH6An8MfSI2qOc6Zz2GXuJaZLZlVQBmNz0WRAQzxviG6pTT8Hms5/VNxqq
sEYK9zR87cW8JrytRxoQ6UnEEIH+AAJYmY1hgGDQMV9fhT7ri/TckFKkt4ZuSXfK
vIolYcGtWLyVTFkXc0YUQTYqDsXLO4t+ohWqHXDwBdGeXxkeHZav5TmQnzO8V+Ea
8uzJylu/JUJNSJCQ3ZMGcj2fhWmbDcYHJ7GLCLBb3+sRWwJ13bX0uSEojiJF3VeO
cIAO9NJMRNx1SHUua8NdmnOs2Tbc3ZU1aGBiePi4RiakGYstmq53DgpMSm/HzWMv
pgf0i0Ne0Xc2/CHUBlcXRvE6g6iXBG7IngSqs4FGcpMIL8YbejaFSw3qwv5MHgBZ
EUkr
=6oa5
-----END PGP SIGNATURE-----

--CPg6SgDjCG7FO4c7NdxUUqiE7Iy7mlAm0--
