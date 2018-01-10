Received: from eggs.gnu.org ([2001:4830:134:3::10]:34781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZKrA-0004pU-Tb
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 13:12:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZKr9-0008NQ-SY
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 13:12:08 -0500
References: <20171122101958.17065-1-vsementsov@virtuozzo.com>
	<20171122101958.17065-5-vsementsov@virtuozzo.com>
	<29b61d23-ddb9-962f-9913-4139598b18b8@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <64653f27-20a4-095f-380c-39f263c717c7@redhat.com>
Date: Wed, 10 Jan 2018 12:11:58 -0600
MIME-Version: 1.0
In-Reply-To: <29b61d23-ddb9-962f-9913-4139598b18b8@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="waGMQF9j9afKHZUKNXpQbuolX3VovRz5C"
Subject: Re: [Qemu-devel] [PATCH 4/5] nbd: rename nbd_option and
 nbd_opt_reply
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
--waGMQF9j9afKHZUKNXpQbuolX3VovRz5C
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org, mreitz@redhat.com
Message-ID: <64653f27-20a4-095f-380c-39f263c717c7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 4/5] nbd: rename nbd_option and nbd_opt_reply
References: <20171122101958.17065-1-vsementsov@virtuozzo.com>
 <20171122101958.17065-5-vsementsov@virtuozzo.com>
 <29b61d23-ddb9-962f-9913-4139598b18b8@redhat.com>
In-Reply-To: <29b61d23-ddb9-962f-9913-4139598b18b8@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/22/2017 03:56 PM, Eric Blake wrote:
> On 11/22/2017 04:19 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Rename nbd_optino and nbd_opt_reply to NBDOption and NBDOptionReply
>=20
> s/optino/option/
>=20
>> to correspond to Qemu coding style and other structures here.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>=

>> ---
>>  include/block/nbd.h |  8 ++++----
>>  nbd/client.c        | 12 ++++++------
>>  2 files changed, 10 insertions(+), 10 deletions(-)
>>
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20

This one is independently useful; I'm adding it to my NBD queue while
working on preparing my promised v2 post of the rest of the series.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--waGMQF9j9afKHZUKNXpQbuolX3VovRz5C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpWV24ACgkQp6FrSiUn
Q2oEcQgAmlSfEVTzg/pJRSo9q8puGnnNRhYJ3aVpWozmXo5nYPQ7VB6thn6r0JyJ
sXlovoovOC20JAWBbGprR4X5Ke600nJuzMMLHtBqdtVV8xnzQXqa+w0jy59tGTwf
3ILettIv/Wo7xE87UGjsA5VVko6afCvLRxUTc3xcOTIdFfNn6CDgfPxn1ANUiw2i
dncOGjMYP0rvB+A/WDm3AorNdWa9/gYvpk3y6w+hVpO9shSG5HiYcgPTnOhwu13e
6daQbrwBCf5ZVAehdtm/WVd8kdJZCVN2yDfRB6w320AVbytBcJAJG0K7w1HVtKGx
NCXxiLpOzFWQl9JNWMurlGeFVwKHxQ==
=6Kh2
-----END PGP SIGNATURE-----

--waGMQF9j9afKHZUKNXpQbuolX3VovRz5C--
