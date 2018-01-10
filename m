Received: from eggs.gnu.org ([2001:4830:134:3::10]:35457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZKte-0005nt-5n
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 13:14:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZKtd-0002Tg-3H
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 13:14:42 -0500
References: <20171122101958.17065-1-vsementsov@virtuozzo.com>
	<20171122101958.17065-6-vsementsov@virtuozzo.com>
	<9104d2de-e723-9a16-09bc-5c69d6d0c880@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3c8b73ec-7009-ca9e-b9ed-065816c997aa@redhat.com>
Date: Wed, 10 Jan 2018 12:14:33 -0600
MIME-Version: 1.0
In-Reply-To: <9104d2de-e723-9a16-09bc-5c69d6d0c880@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="yPahdHEe6XZ4LzmjlBN6VFTEm1wxywgTo"
Subject: Re: [Qemu-devel] [PATCH 5/5] nbd/server: structurize option reply
 sending
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--yPahdHEe6XZ4LzmjlBN6VFTEm1wxywgTo
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org, mreitz@redhat.com
Message-ID: <3c8b73ec-7009-ca9e-b9ed-065816c997aa@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 5/5] nbd/server: structurize option reply
 sending
References: <20171122101958.17065-1-vsementsov@virtuozzo.com>
 <20171122101958.17065-6-vsementsov@virtuozzo.com>
 <9104d2de-e723-9a16-09bc-5c69d6d0c880@redhat.com>
In-Reply-To: <9104d2de-e723-9a16-09bc-5c69d6d0c880@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/22/2017 04:02 PM, Eric Blake wrote:
> On 11/22/2017 04:19 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>=

>> ---
>>  nbd/server.c | 40 +++++++++++++---------------------------
>>  1 file changed, 13 insertions(+), 27 deletions(-)
>>
>=20
> Nice diffstat; shows that this one probably makes sense (even if it wil=
l
> need rebasing on top of the planned churn for the rest of the series).
>=20
>> diff --git a/nbd/server.c b/nbd/server.c
>> index 79b937d88f..975fe8efe9 100644
>> --- a/nbd/server.c
>> +++ b/nbd/server.c
>> @@ -152,43 +152,29 @@ static inline int nbd_opt_drop(NBDClient *client=
, size_t size, Error **errp)
>>      return nbd_drop(client->ioc, size, errp);
>>  }
>> =20
>> +static inline void set_be_option_rep(NBDOptionReply *rep, uint32_t op=
tion,
>> +                                     uint32_t type, uint32_t length)
>=20
> 'static inline' is probably pointless; the compiler already knows what
> static functions are ideal to inline, without us having to name it (I
> realize you've already done this in other patches, so I probably ought
> to post a cleanup patch that removes 'inline').

Then again, we're using it in other .c files, so there's nothing
particularly wrong in keeping it as is.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--yPahdHEe6XZ4LzmjlBN6VFTEm1wxywgTo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpWWAkACgkQp6FrSiUn
Q2qlRggAnEnGdnkWcjo4kANRz5lkLzluI6d5BpsEO0Ac37uPg66iw/VT0pPkMOWI
SKV+4yDzoufK/Sz+YaZlLhxEbsMHq/XRJXmDojU5hi8DU4gTSn6/40mFBbtD0xbw
X3HLfwmr0GEcjZQeZLEqTgJOImjTmm0NyvVhZrZiOOMLVxIj8Lkh7PhFgxlp0je6
iAeYK7PSq7ojO96Un9yFPPh9J+5wV+JQXZWwgHQkUFcnwqEPSjIJRkchK3c/tMRo
FMYi+YCD5PfoEUMXSV93rGt7xOw5vmbRlAutwIXWW1oo+K9QzCd9GBDtVyEBPZzK
d20hTU1Db7Qcthf9BJ783R88+PVpyg==
=WJ4N
-----END PGP SIGNATURE-----

--yPahdHEe6XZ4LzmjlBN6VFTEm1wxywgTo--
