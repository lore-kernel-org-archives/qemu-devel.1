Received: from eggs.gnu.org ([2001:4830:134:3::10]:47476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eNLSK-000504-JV
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 11:24:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eNLSH-0003LF-H0
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 11:24:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35918)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eNLSH-0003Kj-8f
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 11:24:53 -0500
References: <20171208074515.1553-1-lprosek@redhat.com>
	<20171208074515.1553-5-lprosek@redhat.com>
	<87y3mde3z1.fsf@dusky.pond.sub.org>
	<CABdb737EUy_rRCunxeDUDdhhDiCU8eZBNoYmh+QGp39mqsDung@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <eca9af63-7c72-b3a6-d5b1-883d6e33eecd@redhat.com>
Date: Fri, 8 Dec 2017 10:24:47 -0600
MIME-Version: 1.0
In-Reply-To: <CABdb737EUy_rRCunxeDUDdhhDiCU8eZBNoYmh+QGp39mqsDung@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lr5PSImvKKJsghev4VBNAujDXSMnTHD0j"
Subject: Re: [Qemu-devel] [PATCH v3 4/4] ivshmem: Disable irqfd on device
 reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ladi Prosek <lprosek@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Geoffrey McRae <geoff@hostfission.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lr5PSImvKKJsghev4VBNAujDXSMnTHD0j
From: Eric Blake <eblake@redhat.com>
To: Ladi Prosek <lprosek@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Geoffrey McRae <geoff@hostfission.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Message-ID: <eca9af63-7c72-b3a6-d5b1-883d6e33eecd@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 4/4] ivshmem: Disable irqfd on device
 reset
References: <20171208074515.1553-1-lprosek@redhat.com>
 <20171208074515.1553-5-lprosek@redhat.com>
 <87y3mde3z1.fsf@dusky.pond.sub.org>
 <CABdb737EUy_rRCunxeDUDdhhDiCU8eZBNoYmh+QGp39mqsDung@mail.gmail.com>
In-Reply-To: <CABdb737EUy_rRCunxeDUDdhhDiCU8eZBNoYmh+QGp39mqsDung@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/08/2017 07:44 AM, Ladi Prosek wrote:

>>>  static void ivshmem_write_config(PCIDevice *pdev, uint32_t address,
>>>                                   uint32_t val, int len)
>>>  {
>>
>> Why are you moving ivshmem_reset()?  Makes the actual change harder to=

>> see than necessary.
>=20
> ivshmem_disable_irqfd() is declared after ivshmem_reset() in the
> source file. I generally prefer to order static functions
> topologically if possible. If you'd prefer adding a forward decl
> instead (fewer lines touched, easier to bisect?) I can certainly do
> that. Thanks!

That, or split it into two patches (one doing just the code motion, the
other making the semantic change).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--lr5PSImvKKJsghev4VBNAujDXSMnTHD0j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloqvM8ACgkQp6FrSiUn
Q2rN1Qf+KG+vXrg0SWJxbNB6pODTVtWqZIWcI0Dc/jZLNX8YNdFM9eAGSO+dZ0nK
vpdSTCBBWkdrlJewrDYwBDJGu2udfvPDTU8O4saDTha73KTdpYkcNvKKPUO4aTvX
EAli23E+MURs6YJZ+zSVLhHm37+XvWDJFBnMKw2QWx1n5Lt09LUqLdgLLXe+WnJa
8ztWhIOA/cr8IOsJpOojXz33ocL12V5Vo/25zCQAm8qcg3pSQx25TF25yi6KVTIg
lmRNV2SzZlI9mU1D3E30Q8OxOmFras2Td9OejzAjU4muwN5VWhChj9lK2JweROW1
U64PFzusBJdx4NOq/IVF4OdVp7JTqw==
=7nH6
-----END PGP SIGNATURE-----

--lr5PSImvKKJsghev4VBNAujDXSMnTHD0j--
