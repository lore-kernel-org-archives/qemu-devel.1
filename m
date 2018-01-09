Received: from eggs.gnu.org ([2001:4830:134:3::10]:59310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZ2pr-00024L-7a
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 17:57:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZ2pn-0000pE-Q4
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 17:57:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56706)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eZ2pn-0000oC-HL
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 17:57:31 -0500
References: <20171219084557.9801-1-peterx@redhat.com>
	<20171219084557.9801-7-peterx@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <da2f5908-5854-6888-38f0-af2d40c50cf0@redhat.com>
Date: Tue, 9 Jan 2018 16:57:21 -0600
MIME-Version: 1.0
In-Reply-To: <20171219084557.9801-7-peterx@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="DZHEdAKmpUYR1bk6oXo6wfhEGR4U50soL"
Subject: Re: [Qemu-devel] [RFC v6 06/27] monitor: move the cur_mon hack
 deeper for QMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DZHEdAKmpUYR1bk6oXo6wfhEGR4U50soL
From: Eric Blake <eblake@redhat.com>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <shajnocz@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>,
 Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com,
 Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <da2f5908-5854-6888-38f0-af2d40c50cf0@redhat.com>
Subject: Re: [RFC v6 06/27] monitor: move the cur_mon hack deeper for QMP
References: <20171219084557.9801-1-peterx@redhat.com>
 <20171219084557.9801-7-peterx@redhat.com>
In-Reply-To: <20171219084557.9801-7-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/19/2017 02:45 AM, Peter Xu wrote:
> In monitor_qmp_read(), we have the hack to temporarily replace the
> cur_mon pointer.  Now we move this hack deeper inside the QMP dispatche=
r
> routine since the Monitor pointer can be actually obtained using
> container_of() upon the parser object, just like most of the other JSON=

> parser users do.
>=20
> This does not make much sense as a single patch.  However, this will be=

> a big step for the next patch, when the QMP dispatcher routine will be
> split from the QMP parser.
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  monitor.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--DZHEdAKmpUYR1bk6oXo6wfhEGR4U50soL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpVSNEACgkQp6FrSiUn
Q2oBxAf/dNl/dMk/TgolvTdCjbm4S3hUzdmThmBqxSeKsWrvY/2Zb20GyNg74IOe
USBFx+4Q6OMso6pVnz9we0xcuxjtoZqwnBJhZ6y49R1mjYF8EpczfGEdbIWNf18/
afWyLVow/mVIAwhatjwSr04AuRogwT4h+kY8DxAxI0O69AZRf45t1618Ph9KIysP
5OJy9HCoJjo5I2/5M7JG5BQ637q+iKdJ4HQcvNlbUodmIzE+C4XoTSS4N5hqbd2g
psGF2SGCfBT8hK1lFH8IdO8fhFAvRBvPTEtQvGxV9K8jP6L+VP0B/kivGVeCmLUv
pOYQcpMNTfkWYGYPUoWrOxY6q/yXEA==
=wsNj
-----END PGP SIGNATURE-----

--DZHEdAKmpUYR1bk6oXo6wfhEGR4U50soL--
