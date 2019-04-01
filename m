Received: from eggs.gnu.org ([209.51.188.92]:43404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hAxU8-00045u-6I
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 10:00:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hAxU3-0006hl-B6
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 10:00:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37624)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1hAxU2-0006gb-WD
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 10:00:19 -0400
References: <20190329042750.14704-1-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e1117820-d4fb-8f9b-296a-a95f9f6fcd38@redhat.com>
Date: Mon, 1 Apr 2019 09:00:14 -0500
MIME-Version: 1.0
In-Reply-To: <20190329042750.14704-1-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="JMSvSeDKZMPiEyxq5LlcBnePXVBA8LuEe"
Subject: Re: [Qemu-devel] [PATCH for-4.0 v3 0/6] NBD server alignment
 improvement
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: vsementsov@virtuozzo.com, rjones@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JMSvSeDKZMPiEyxq5LlcBnePXVBA8LuEe
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: vsementsov@virtuozzo.com, rjones@redhat.com
Message-ID: <e1117820-d4fb-8f9b-296a-a95f9f6fcd38@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-4.0 v3 0/6] NBD server alignment
 improvement
References: <20190329042750.14704-1-eblake@redhat.com>
In-Reply-To: <20190329042750.14704-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 3/28/19 11:27 PM, Eric Blake wrote:
> I'm tired of nbdkit being able to trigger an assertion failure
> in qemu-img convert.  Let's get this into 4.0-rc2.
>=20
> Since v2:
> - add more patches, including a respin of a separately-posted
> nbd/client: Deal with unaligned size from server
> - Don't make unaligned sector from server inaccessible; instead,
> round our requests down and handle the tail locally
> - fix another issue reported by Rich where 'qemu-img map' output
> was less than stellar
>=20
> Eric Blake (6):
>   iotests: Add 241 to test NBD on unaligned images
>   nbd/client: Lower min_block for block-status, unaligned size
>   nbd/client: Report offsets in bdrv_block_status
>   nbd/client: Support qemu-img convert from unaligned size
>   block: Add bdrv_get_request_alignment()
>   nbd/server: Advertise actual minimum block size

I've queued this series on my NBD tree, and will send a pull request
shortly.

I have a couple more patches that I started work on that fix the final
few alignment bugs, but as they have not been on the list yet, they may
be too risky for 4.0; we'll see what happens based on how fast I can
polish them.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--JMSvSeDKZMPiEyxq5LlcBnePXVBA8LuEe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlyiGW4ACgkQp6FrSiUn
Q2qhPAgAmGz+WW63XRsQ4kb9KTHflUXR1fUMET9/2l+LJX8MLcH+icQb9qK3ROVE
LZFhSjigo7ll0SsE+D+50HR/N2Spit9wYCg0woUXOs+bMe6+TwjD1jowu6UXpB2f
RZ1VLoCouh2qvwkG8zVyRgB+h9aiSCpXoQiAMfax+lQ2Da8lop3v1UwadJaJvsSp
ZwWHyQ0zN7JHyIN/k11eqtqGGeK/y2b9p6Z/u8PN6ysgEhHZ1HPrP8XNecqM7PLh
PTpBBRprzFTzSpKM21Om5bBRWzFWGjS//CRQItOy3erQ2k0HrLlJ0g5Ne3o8+yBs
oOgYP+HoP2iJDCjsbnHVSy9DQYGspQ==
=rZYa
-----END PGP SIGNATURE-----

--JMSvSeDKZMPiEyxq5LlcBnePXVBA8LuEe--
