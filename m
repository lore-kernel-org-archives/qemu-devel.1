Received: from eggs.gnu.org ([2001:4830:134:3::10]:34003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e44GO-00012W-F5
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 08:13:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e44GM-0007y9-65
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 08:12:56 -0400
References: <20171015010131.12172-1-eblake@redhat.com>
	<20171015010131.12172-3-eblake@redhat.com>
	<58e026df-5e9d-2ba1-dd55-7b0d958fc3e3@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <469181a3-a171-188b-4c43-d406e5b340a2@redhat.com>
Date: Mon, 16 Oct 2017 07:12:45 -0500
MIME-Version: 1.0
In-Reply-To: <58e026df-5e9d-2ba1-dd55-7b0d958fc3e3@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="o0JkJf5TAWmLr2RAHfcNSx7Jae22nhCjK"
Subject: Re: [Qemu-devel] [PATCH v4 2/8] nbd: Move
 nbd_errno_to_system_errno() to public header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--o0JkJf5TAWmLr2RAHfcNSx7Jae22nhCjK
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Message-ID: <469181a3-a171-188b-4c43-d406e5b340a2@redhat.com>
Subject: Re: [PATCH v4 2/8] nbd: Move nbd_errno_to_system_errno() to public
 header
References: <20171015010131.12172-1-eblake@redhat.com>
 <20171015010131.12172-3-eblake@redhat.com>
 <58e026df-5e9d-2ba1-dd55-7b0d958fc3e3@virtuozzo.com>
In-Reply-To: <58e026df-5e9d-2ba1-dd55-7b0d958fc3e3@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/16/2017 03:33 AM, Vladimir Sementsov-Ogievskiy wrote:
> 15.10.2017 04:01, Eric Blake wrote:
>> This is needed in preparation for structured reply handling,
>> as we will be performing the translation from NBD error to
>> system errno value higher in the stack at block/nbd-client.c.
>=20
> you've forget to sign-off.

D'oh. Bad patch split on my part.

Signed-off-by: Eric Blake <eblake@redhat.com>

>=20
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>=20
>> ---
>> =C2=A0 include/block/nbd.h | 13 +++++++++++++
>> =C2=A0 nbd/nbd-internal.h=C2=A0 | 12 ------------
>> =C2=A0 nbd/client.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 32 ---=
-----------------------------
>> =C2=A0 nbd/common.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 34 +++=
+++++++++++++++++++++++++++++++
>> =C2=A0 nbd/trace-events=C2=A0=C2=A0=C2=A0 |=C2=A0 4 +++-
>> =C2=A0 5 files changed, 50 insertions(+), 45 deletions(-)
>>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--o0JkJf5TAWmLr2RAHfcNSx7Jae22nhCjK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnkoj0ACgkQp6FrSiUn
Q2riZQf/fnR4721aDpybfpqDqli0XXm8ILc4tNScJ4Sy25YuH7XROmBIrQobSofw
Qs3mrBGeO2pDFNm9qDk9LnpCRy/oUN6Q7R2hawoPEI3Yb9yG9WcpmtPR76wPOb7V
ZT9NdnH5kh37RLl0ES7YykBlTWG0XF8nsHzErurGAR7Ys0cFUaIzuO2RQafh6SWW
BLo71RtKyxmfdTNwJRiVqO6OV0axXrFSZzrYqKu1PBSdNyXt+bKdh3RswtGHHbzt
ujx8lgPf1DPnqmUIylSVZmLApj+nEZVb4d9SB94//LMo43/RqYNH/V+AvqCOjjEM
+9kA9Gboepq9Sf114yxdinxQyYmw2g==
=u3UE
-----END PGP SIGNATURE-----

--o0JkJf5TAWmLr2RAHfcNSx7Jae22nhCjK--
