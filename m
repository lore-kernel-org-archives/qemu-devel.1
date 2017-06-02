Received: from eggs.gnu.org ([2001:4830:134:3::10]:43920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dGmxJ-0003r1-6U
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 09:49:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dGmxE-0008J1-Kb
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 09:49:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46960)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dGmxE-0008IP-Bi
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 09:49:28 -0400
References: <20170531165541.47338-1-vsementsov@virtuozzo.com>
	<20170531165541.47338-2-vsementsov@virtuozzo.com>
	<70aa332e-c868-15ac-0c4c-23d41a777b6c@redhat.com>
	<76a74826-f9ed-825e-0d3d-3043943d636c@virtuozzo.com>
	<8e900b35-65a9-789f-2cf4-9de6d16460a3@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <40ed0b31-84b7-380f-65ce-bc79de780c04@redhat.com>
Date: Fri, 2 Jun 2017 08:49:25 -0500
MIME-Version: 1.0
In-Reply-To: <8e900b35-65a9-789f-2cf4-9de6d16460a3@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="cfleVxhk5vBxSQupNSDiEvsf95nej3BLL"
Subject: Re: [Qemu-devel] [PATCH 01/12] nbd: rename read_sync and friends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cfleVxhk5vBxSQupNSDiEvsf95nej3BLL
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, den@openvz.org
Message-ID: <40ed0b31-84b7-380f-65ce-bc79de780c04@redhat.com>
Subject: Re: [PATCH 01/12] nbd: rename read_sync and friends
References: <20170531165541.47338-1-vsementsov@virtuozzo.com>
 <20170531165541.47338-2-vsementsov@virtuozzo.com>
 <70aa332e-c868-15ac-0c4c-23d41a777b6c@redhat.com>
 <76a74826-f9ed-825e-0d3d-3043943d636c@virtuozzo.com>
 <8e900b35-65a9-789f-2cf4-9de6d16460a3@virtuozzo.com>
In-Reply-To: <8e900b35-65a9-789f-2cf4-9de6d16460a3@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/02/2017 07:00 AM, Vladimir Sementsov-Ogievskiy wrote:

>>>> 2. _sync suffix
>>>>     _sync is related to the fact, that nbd_wr_syncv doesn't return i=
f
>>> s/fact,/fact/
>>>
>>>>     write to socket returns EAGAIN. In first implementation
>>>> nbd_wr_syncv
>>>>     just loops while getting EAGAIN, current implementation yields i=
n
>>>>     this case.
>>> As mentioned in your followup, you may want to rewrite this to:
>>>
>>> _sync was originally used (back in commit 7a5ca864 when it was named
>>> wr_sync) to indicate that we looped rather than returned on EAGAIN.  =
But
>>> now we use qio_channel which yields on our behalf rather than giving =
us
>>> EAGAIN.
>>
>> hmm, I like my wording (with adding note "... implementaion
>> nbd_wr_syncv (was wr_sync in 7a5ca8648b) just ...")  more, because:
>> 1. not only nbd_wr_syncv has that suffix, so nbd_wr_syncv should be
>> mentioned (as we mention wr_sync)
>> 2. I don't say about contrast between old and current, I say that they=

>> are similar.
>>
>=20
> Finally, are you OK with my wording? If I reroll, can I add your r-b?

What final wording are you proposing (full paragraph, not a snippet)?

>>>
>>> Reviewed-by: Eric Blake <eblake@redhat.com>

At any rate, I already gave R-b for the code, so finessing the commit
message doesn't change that if the code remains unchanged.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--cfleVxhk5vBxSQupNSDiEvsf95nej3BLL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEbBAEBCAAGBQJZMWzlAAoJEKeha0olJ0NqJtAH92RndQov8bui5/WhChgJ2jAH
0kkzJauJpa4Jp3kLBhsnxsv+xxxP8WzS5/RHX+VUcQlziSwdjP/pbbFOWYB2Z9Lq
AOweuBAfZn2SH3QDZ9v85SNECspxRRrkkhNa6j/NN3zkFf/4hidq02Fh4NLatsyR
BrTYPc5yzABAIf4GkU0BZHtdqwHs0jyRsZyu3LeamroAiPOCANE3/lH7DGk88WcL
PIhdzv1qKouDCzVkXlE7YiSyK9PH3vsN6B56PA+fo3mmQye1tJcC3aQjvtmUroHn
f3SVU5wQOOur57W1Nwm/BDM2X7mn9PUKGzppXlzuKKip91FqnLDM1h3VrXxSAg==
=9N/c
-----END PGP SIGNATURE-----

--cfleVxhk5vBxSQupNSDiEvsf95nej3BLL--
