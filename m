Received: from eggs.gnu.org ([2001:4830:134:3::10]:34797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e44Ih-0002Tj-Pf
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 08:15:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e44Id-00016O-0G
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 08:15:19 -0400
References: <20171015010131.12172-1-eblake@redhat.com>
	<20171015010131.12172-4-eblake@redhat.com>
	<bee8a445-1cb9-53f6-4828-bdbd9c745ccc@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <dcbf9daa-f3fb-7fc0-3ec8-aa3ed48c302a@redhat.com>
Date: Mon, 16 Oct 2017 07:15:03 -0500
MIME-Version: 1.0
In-Reply-To: <bee8a445-1cb9-53f6-4828-bdbd9c745ccc@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="093rMA476kFfxlCxcqNvjE7b4HpOdw6sP"
Subject: Re: [Qemu-devel] [PATCH v4 3/8] nbd: Expose constants and structs
 for structured read
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
--093rMA476kFfxlCxcqNvjE7b4HpOdw6sP
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Message-ID: <dcbf9daa-f3fb-7fc0-3ec8-aa3ed48c302a@redhat.com>
Subject: Re: [PATCH v4 3/8] nbd: Expose constants and structs for structured
 read
References: <20171015010131.12172-1-eblake@redhat.com>
 <20171015010131.12172-4-eblake@redhat.com>
 <bee8a445-1cb9-53f6-4828-bdbd9c745ccc@virtuozzo.com>
In-Reply-To: <bee8a445-1cb9-53f6-4828-bdbd9c745ccc@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/16/2017 03:49 AM, Vladimir Sementsov-Ogievskiy wrote:
> 15.10.2017 04:01, Eric Blake wrote:
>> Upcoming patches will implement the NBD structured reply
>> extension [1] for both client and server roles.=C2=A0 Declare the
>> constants, structs, and lookup routines that will be valuable
>> whether the server or client code is backported in isolation.
>>
>> This includes moving one constant from an internal header to
>> the public header, as part of the structured read processing
>> will be done in block/nbd-client.c rather than nbd/client.c.
>>
>> [1]https://github.com/NetworkBlockDevice/nbd/blob/extension-structured=
-reply/doc/proto.md
>>
>=20
> this link may become dead in future, after merging extension spec into
> master...

Perhaps; but it's a git branch, so it's not going to disappear, even
when it is no longer actively maintained.  For comparison, here's the
(now-stale) link for NBD_CMD_WRITE_ZEROES:

https://github.com/NetworkBlockDevice/nbd/blob/extension-write-zeroes/doc=
/proto.md

So I'm not too worried about having the URL in the commit message.

>=20
>>
>> Based on patches from Vladimir Sementsov-Ogievskiy.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>=20
>=20
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--093rMA476kFfxlCxcqNvjE7b4HpOdw6sP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnkoscACgkQp6FrSiUn
Q2oo2Qf/UPSmH9PNXJ9u4HWgo4IoyPFZogKoC/S0o04/yZjCeTMHcQsdaO9GBiq0
QHMxHyVj+eoBNCxhjyYJ/oixQ0CpGE3hLsb1zAlqQyfPWFvlExXhEkllwmfEBr/6
V+SxUnErW9N4YbwhZAw8gaIMKH5kFX9oWqjd33R88b1ntr07kYSZiTno4+9u+/W6
Cb7/RCYBX0fRm0ZO/tiaVUSfWxolyf3fEc+JahMSjYQtP9EzTkBVLExS5n5x9lkW
zmaYyou1izAWN2GsOXrAZsO/Ig3uY1Q/OI9vVg7KezapNpvxkI1/oLJUm3/PS7ZB
Z6Vq4EZ/dkymtEUALbmtQxI49mEVhQ==
=YHbV
-----END PGP SIGNATURE-----

--093rMA476kFfxlCxcqNvjE7b4HpOdw6sP--
