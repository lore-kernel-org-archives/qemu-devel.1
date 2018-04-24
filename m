Received: from eggs.gnu.org ([2001:4830:134:3::10]:43045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fB6P9-0003A9-QB
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 18:27:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fB6P8-0004pL-Ld
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 18:27:19 -0400
References: <20180424152515.25664-1-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d456659b-7ea8-faab-8022-73a845974821@redhat.com>
Date: Tue, 24 Apr 2018 17:27:04 -0500
MIME-Version: 1.0
In-Reply-To: <20180424152515.25664-1-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="H0r8tQ6QhxrHD02CMLJhsMLNz3gtWrygp"
Subject: Re: [Qemu-devel] [RFC PATCH 00/33] Generic background jobs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--H0r8tQ6QhxrHD02CMLJhsMLNz3gtWrygp
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Message-ID: <d456659b-7ea8-faab-8022-73a845974821@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 00/33] Generic background jobs
References: <20180424152515.25664-1-kwolf@redhat.com>
In-Reply-To: <20180424152515.25664-1-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/24/2018 10:24 AM, Kevin Wolf wrote:
> Before we can make x-blockdev-create a background job, we need to
> generalise the job infrastructure so that it can be used without any
> associated block node.
>=20
> This series extracts a Job object from the block job infrastructure,
> which should contain everything related to jobs that doesn't require th=
e
> block layer to be involved.
>=20
> The split between BlockJob and Job is reasonably complete as of this RF=
C
> (though there are still some rough edges). Missing are mainly:
>=20
> * Some cleanups. This means mostly TODOs left for functions moved to
>   job.c that should become static again, but were still called from
>   blockjob.c. At this point, most of these public declarations aren't
>   actually necessary any more, or very little is missing to make them
>   unnecessary.
>=20
> * A QMP interface that can be used with non-block job. The existing
>   block-job-* QMP commands will tell the user that they don't know the
>   job if you pass the ID of a non-block job.
>=20
> * The actual conversion of x-blockdev-create to Job, as a proof of
>   concept that the generalised infrastructure actually works.

I didn't review the second half as closely, but did glance through the
whole series.  Overall, I like what I'm seeing; it looks like you have
indeed extracted the non-block portions into a reusable framework that
can be extended to other uses.  It would also be interesting to see what
other long-running operations we can map into this scheme, such as
migration or capturing a screenshot.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--H0r8tQ6QhxrHD02CMLJhsMLNz3gtWrygp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrfrzgACgkQp6FrSiUn
Q2o8pwf/dJwHVDnIU7YNm24U/s2sDSL2g5B1BUc5k6CWcWxXzqYs7JA7PTRDvU1a
rjnU94zdcXxn/qXqb9qonv92LOtn71ylr86gTEWQ+DP6CPt4Cr10SFmaALAgDuwV
Lp5R5b3/dYD6Qopr5n8dg8VVQfB9EK63At0lB5A1szXi3I1QgL2lG0+ryZd/Jg6O
S9gEXC9/S6QWzrUxF68SSBl5I9CN1ySt8ue+NSiif+Xoegt5itDxRQidGRCZLEPU
NMFybr4rArEiOg63Wj8rydaSXgANxfFLREwsDfKbhTSG5KTskxyV9h3QMH56Kv/C
E6H2fkD6FTa3GK0xOgatHX0c5VjBgQ==
=wh1n
-----END PGP SIGNATURE-----

--H0r8tQ6QhxrHD02CMLJhsMLNz3gtWrygp--
