Received: from eggs.gnu.org ([2001:4830:134:3::10]:54866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1db7Zj-000544-35
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 11:53:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1db7Zf-0006Qb-Ul
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 11:53:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58658)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1db7Zf-0006QC-LJ
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 11:53:11 -0400
References: <1501229198-30588-1-git-send-email-peterx@redhat.com>
	<1501229198-30588-12-git-send-email-peterx@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2e01324b-73e2-ddb9-7df3-6ae3ec2a7222@redhat.com>
Date: Fri, 28 Jul 2017 10:53:00 -0500
MIME-Version: 1.0
In-Reply-To: <1501229198-30588-12-git-send-email-peterx@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="iKmdaNqBnxJsdwqwlflfNXwWB9v1RCmlL"
Subject: Re: [Qemu-devel] [RFC 11/29] migration: new postcopy-pause state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, Juan Quintela <quintela@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iKmdaNqBnxJsdwqwlflfNXwWB9v1RCmlL
From: Eric Blake <eblake@redhat.com>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>,
 Andrea Arcangeli <aarcange@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Alexey Perevalov <a.perevalov@samsung.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <2e01324b-73e2-ddb9-7df3-6ae3ec2a7222@redhat.com>
Subject: Re: [Qemu-devel] [RFC 11/29] migration: new postcopy-pause state
References: <1501229198-30588-1-git-send-email-peterx@redhat.com>
 <1501229198-30588-12-git-send-email-peterx@redhat.com>
In-Reply-To: <1501229198-30588-12-git-send-email-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/28/2017 03:06 AM, Peter Xu wrote:
> Introducing a new state "postcopy-paused", which can be used to pause a=

> postcopy migration. It is targeted to support network failures during
> postcopy migration. Now when network down for postcopy, the source side=

> will not fail the migration. Instead we convert the status into this ne=
w
> paused state, and we will try to wait for a rescue in the future.
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---

You might want to use scripts/git.orderfile to put .json changes early
in your diffs (interface before implementation makes for easier reviews).=


> +++ b/qapi-schema.json
> @@ -667,6 +667,8 @@
>  #
>  # @postcopy-active: like active, but now in postcopy mode. (since 2.5)=

>  #
> +# @postcopy-paused: during postcopy but paused. (since 2.10)
> +#

You've missed 2.10; this should be 2.11.  Can this state occur without
any explicit request (ie. old clients may be confused by it), or do you
have to opt-in to a specific migration parameter to inform qemu that you
are aware of how to handle this state?

>  # @completed: migration is finished.
>  #
>  # @failed: some error occurred during migration process.
> @@ -679,7 +681,8 @@
>  ##
>  { 'enum': 'MigrationStatus',
>    'data': [ 'none', 'setup', 'cancelling', 'cancelled',
> -            'active', 'postcopy-active', 'completed', 'failed', 'colo'=
 ] }
> +            'active', 'postcopy-active', 'postcopy-paused',
> +            'completed', 'failed', 'colo' ] }
> =20
>  ##
>  # @MigrationInfo:
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--iKmdaNqBnxJsdwqwlflfNXwWB9v1RCmlL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll7XdwACgkQp6FrSiUn
Q2qDtgf/eY1yAk3VhtYqTa3w9OrqBD6dTCSyZkzmDLXFpSYcUsPXHEH65D28wnba
cVxQrPEpeLi3EQq4ftGDQV24q/ALfkwpf6l81nYyE5DRptlCrWJDy11lXdadTiNn
rYQY/+JyW/yeh1fDQa0z102IZc8i2H3AE2N5elGMeifiguaR6LfyjEmfk+CCo6IL
WSbEqQynx6PUWdzBoMdkUeTv+mWnsucAdkDQPzu4uN52KazYE4SLx1+bF7w1K1FH
Lb4seSamk0L4TvyIBzUA3xfEt7vvXb0H//rbZHnWZHjWNcas5Y6NkPk8shvJ1h5j
2ixCxw3USvVVHebRIXb1gTGoaR6Yeg==
=Rism
-----END PGP SIGNATURE-----

--iKmdaNqBnxJsdwqwlflfNXwWB9v1RCmlL--
