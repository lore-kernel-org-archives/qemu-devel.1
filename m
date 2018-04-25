Received: from eggs.gnu.org ([2001:4830:134:3::10]:32946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBLWl-0008Ok-RS
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 10:36:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBLWg-0007f4-7X
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 10:36:11 -0400
References: <20180421132929.21610-1-mreitz@redhat.com>
	<6c3a9ddd-a31b-74a2-1cce-3f353de1830f@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c467b498-29d8-f93f-7105-1c5ce7060895@redhat.com>
Date: Wed, 25 Apr 2018 09:36:00 -0500
MIME-Version: 1.0
In-Reply-To: <6c3a9ddd-a31b-74a2-1cce-3f353de1830f@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pdtuYh9FiIjQVFW8ji903zYuzyQQ80Kqr"
Subject: Re: [Qemu-devel] [PATCH v2 0/9] block: Add COR filter driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pdtuYh9FiIjQVFW8ji903zYuzyQQ80Kqr
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <c467b498-29d8-f93f-7105-1c5ce7060895@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/9] block: Add COR filter driver
References: <20180421132929.21610-1-mreitz@redhat.com>
 <6c3a9ddd-a31b-74a2-1cce-3f353de1830f@redhat.com>
In-Reply-To: <6c3a9ddd-a31b-74a2-1cce-3f353de1830f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/25/2018 07:18 AM, Max Reitz wrote:
> On 2018-04-21 15:29, Max Reitz wrote:
>> This series adds a copy-on-read block filter driver which works by
>> simply setting the BDRV_REQ_COPY_ON_READ flag on write requests (and
>> otherwise just passing everything through).
>>

>=20
> Thanks for the reviews, applied to my block branch.

Sorry for a late review - I've pointed out a missing documentation
change to supported_write_flags and supported_zero_flags; it can be
fixed either as a followup, or squashed in if you rebase your staging on
block branch before turning out a pull request.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--pdtuYh9FiIjQVFW8ji903zYuzyQQ80Kqr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrgklAACgkQp6FrSiUn
Q2qmaQf/WTl0OJxZzBOZAcO0U1qOKNM0G4ibaz3mn0O5Wj7shuoCQBDd8hlaGDjm
DeSk+Vwouml9q6Z2D0kAe9LSuTTKBVD5MMgfvPShQPGw+6HkFPok5z5ovJ53SngN
yRnh/M9h4Tg5MdDVxmtwKmCK/VSJnvat6dxa469iDQBbp0BqOd/qoa4hNEL9wGop
VYRyBMopK8f2dbnFPLHXu6UiW6LgdOx5bjUOp0HxnhxJIMlru0UirtAXbSLyq4vC
xnheJlxBIeld/BIWejZuIgaSi+qae3D8RL4NuY4gLNISJcJGyai7XBT8wDk1CNiA
oRRiUBnkQQM96dQM1HBmc9D7psUNAw==
=OHk/
-----END PGP SIGNATURE-----

--pdtuYh9FiIjQVFW8ji903zYuzyQQ80Kqr--
