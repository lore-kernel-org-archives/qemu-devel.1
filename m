Received: from eggs.gnu.org ([2001:4830:134:3::10]:42484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dn8ac-0003hn-RS
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 15:23:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dn8ab-0001mz-Kw
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 15:23:50 -0400
References: <cover.1504112256.git.jcody@redhat.com>
	<fc2539281a00353777c10f37dea6ccdb6aae4285.1504112256.git.jcody@redhat.com>
	<20170830172413.GA9720@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4f2efa42-4a81-9890-497f-123c2b9a946c@redhat.com>
Date: Wed, 30 Aug 2017 14:23:33 -0500
MIME-Version: 1.0
In-Reply-To: <20170830172413.GA9720@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Hb0KwjtoaDPuMHqPe2qg9vsxVBqqWQeif"
Subject: Re: [Qemu-devel] [PATCH v2 2/3] block-jobs: Optionally unregister
 live block operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Jeff Cody <jcody@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, peterx@redhat.com, dgilbert@redhat.com, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, mrezanin@redhat.com, jsnow@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Hb0KwjtoaDPuMHqPe2qg9vsxVBqqWQeif
From: Eric Blake <eblake@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>, Jeff Cody <jcody@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, peterx@redhat.com,
 dgilbert@redhat.com, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?=
 <marcandre.lureau@redhat.com>, mrezanin@redhat.com, jsnow@redhat.com
Message-ID: <4f2efa42-4a81-9890-497f-123c2b9a946c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/3] block-jobs: Optionally unregister
 live block operations
References: <cover.1504112256.git.jcody@redhat.com>
 <fc2539281a00353777c10f37dea6ccdb6aae4285.1504112256.git.jcody@redhat.com>
 <20170830172413.GA9720@localhost.localdomain>
In-Reply-To: <20170830172413.GA9720@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/30/2017 12:24 PM, Eduardo Habkost wrote:
> On Wed, Aug 30, 2017 at 01:01:41PM -0400, Jeff Cody wrote:
>> From: Jeffrey Cody <jcody@redhat.com>
>>
>> If configured without live block operations enabled, unregister the
>> live block operation commands.
>>
>> Signed-off-by: Jeff Cody <jcody@redhat.com>
>> ---
>>  monitor.c | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>

>=20
> I suggest using the new mechanisms added by:
>=20
>   [PATCH 00/26] qapi: add #if pre-processor conditions to generated cod=
e

Those haven't landed yet, but as both series are proposed for 2.11, I
indeed agree that basing this series on top of that one will be a bit
cleaner.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Hb0KwjtoaDPuMHqPe2qg9vsxVBqqWQeif
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmnELUACgkQp6FrSiUn
Q2pZkAf/Z/LM+c6iN32FYcXIj8g5oiNpF/o5Cjps8P8wh2B7BiodCwYEv/P/sTlT
eCnwhDoVATTo0J08dWrq9hd659jPkWfXh64h1kuOhSNdnzwOaxqn/dhkDKsbSym8
zR03vO65LxYhyFK1+wgtNBLbcd9ly48kkVHyslhYq0MJuCPkMivkZnEGmjJ2trJ2
D8Uvsi74hua7D9fo4BBRKC8AKAlygJ5OnL90BJkXXD/AfAWq2lXXyfjjf4DeVDLT
Q2Pj6kmjGGtjU6rSaS7lQcf8KTDmazaHLMtKcm4ns/8bYg611Ty2qlxRnPPpc2sM
DWoMioDs1aShSiXzqNIc9hWKk00HVg==
=g1p9
-----END PGP SIGNATURE-----

--Hb0KwjtoaDPuMHqPe2qg9vsxVBqqWQeif--
