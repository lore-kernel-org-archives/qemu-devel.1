Received: from eggs.gnu.org ([2001:4830:134:3::10]:51087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYWrR-0005nH-Lw
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 08:16:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYWrQ-0001vH-J0
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 08:16:49 -0400
References: <20170721093416.17816-1-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fb720b66-8b5f-bd84-2cb6-aa7d7d14b2db@redhat.com>
Date: Fri, 21 Jul 2017 07:16:34 -0500
MIME-Version: 1.0
In-Reply-To: <20170721093416.17816-1-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1OWhWCji0BjPLXxWWcr8kdapTTl7EqesM"
Subject: Re: [Qemu-devel] [PATCH] qemu-iotests: add a "how to" to ./README
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Ishani Chugh <chugh.ishani@research.iiit.ac.in>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1OWhWCji0BjPLXxWWcr8kdapTTl7EqesM
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>,
 Ishani Chugh <chugh.ishani@research.iiit.ac.in>, qemu-block@nongnu.org
Message-ID: <fb720b66-8b5f-bd84-2cb6-aa7d7d14b2db@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-iotests: add a "how to" to ./README
References: <20170721093416.17816-1-stefanha@redhat.com>
In-Reply-To: <20170721093416.17816-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/21/2017 04:34 AM, Stefan Hajnoczi wrote:
> There is not much getting started documentation for qemu-iotests.  This=

> patch explains how to create a new test and covers the overall testing
> approach.
>=20
> Cc: Ishani Chugh <chugh.ishani@research.iiit.ac.in>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---

> +3. Assign groups to the test
> +
> +Add your test to the ./group file.  This file is the index of tests an=
d assigns
> +them to functional groups like "rw" for read-write tests.  Most tests =
belong to
> +the "rw" and "auto" groups.  "auto" means the test runs when ./check i=
s invoked
> +without a -g argument.
> +
> +Consider adding your test to the "quick" group if it executes quickly =
(<1s).

We have several tests going up to 5s (and I have a patch pending to
remove two tests that took longer) - I think 1s is a bit on the short
end for still classifying a test as quick.

> +This group is run by "make check-block" and is often included as part =
of build
> +tests in continuous integration systems.

It would still be nice to have 'make check' run 'make check-block'...
but that's independent of this patch.

> +Once you are happy with the test output it can be used as the golden m=
aster
> +with "mv <test-number>.out.bad <test-number>.out".  Rerun the test to =
verify
> +that it passes.
> +
> +Congratulations, you've created a new test!

Maybe a reminder to 'git add' the new files, then submit the patch?

Better than what we have, so whether or not you make further tweaks
according to my suggestions,
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--1OWhWCji0BjPLXxWWcr8kdapTTl7EqesM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAllx8KIACgkQp6FrSiUn
Q2qSUQf9FkQG63Y5ScJ5zf150GMHZxrGf3dtEvYEZSXBRiJzMr7sqqfi29LaayLG
CCpH8z8tdDh642/KbcWUi/HtNdcCnA+FHzPXqQzQup4Wm+vh2lHI3yEgwisYguvI
L/vqN3qtJUIaykYy6KO+tac5VA+Ar8jqa6WW5R0SjhqC3Q0PlyLJ0rt+UutA9+ci
DGsEPJwhDDXeJfgXcwvH/nuEHTX+bWY7gV/6rIhOtTvgdbE/i+SIV8hto1RUgRWs
CnPOGPxi5AjK9fkY8ygzrXGpQElNvVdQ/XqaQ+g/o/mQRxlxQKOaOAm40gJI1tIS
xqpJIz7mhXZvd18obKoP/hOtcBPURg==
=rsI1
-----END PGP SIGNATURE-----

--1OWhWCji0BjPLXxWWcr8kdapTTl7EqesM--
