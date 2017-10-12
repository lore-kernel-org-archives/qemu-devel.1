Received: from eggs.gnu.org ([2001:4830:134:3::10]:40750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e2m8Q-0007uX-OV
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 18:39:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e2m8P-0006FF-RI
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 18:39:22 -0400
References: <20171012095319.136610-1-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <dd3bbcfd-b0e0-19a1-1b0a-dbe9ef6bb443@redhat.com>
Date: Thu, 12 Oct 2017 17:39:16 -0500
MIME-Version: 1.0
In-Reply-To: <20171012095319.136610-1-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="fvCIPpijJ1sllLFnPuO7DXhs6nqduMAGu"
Subject: Re: [Qemu-devel] [PATCH v3 00/13] nbd minimal structured read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fvCIPpijJ1sllLFnPuO7DXhs6nqduMAGu
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org
Message-ID: <dd3bbcfd-b0e0-19a1-1b0a-dbe9ef6bb443@redhat.com>
Subject: Re: [PATCH v3 00/13] nbd minimal structured read
References: <20171012095319.136610-1-vsementsov@virtuozzo.com>
In-Reply-To: <20171012095319.136610-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/12/2017 04:53 AM, Vladimir Sementsov-Ogievskiy wrote:
> Minimally implement nbd structured read extension.
>=20
> v3:
>=20
> clone: tag up-nbd-minimal-structured-read-v3 from https://src.openvz.or=
g/scm/~vsementsov/qemu.git
> online: https://src.openvz.org/users/vsementsov/repos/qemu/browse?at=3D=
up-nbd-minimal-structured-read-v3
>=20
> 03: rename  nbd_co_send_reply here too, remove r-b
> 04-07: splitted nbd server refactoring, with some changes

English does not have 'splitted'; 'split' is one of those irregular
verbs that is the same form for present, past, and past participle tenses=
=2E

I've pushed 1-7 with tweaks to my NBD staging queue:
http://repo.or.cz/qemu/ericb.git/shortlog/refs/heads/nbd

Let me know if I need to redo any of the tweaks I made to your work.

> 08: add Eric's r-b
> 13: rewrite receiving loops by Paolo's suggestion
>=20

and I will resume review of the rest tomorrow.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--fvCIPpijJ1sllLFnPuO7DXhs6nqduMAGu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnf7xQACgkQp6FrSiUn
Q2qGUwf/YJc5tnf4UZLsDLQljrgaRRe/zmkJYRzmj67LnPYQv+t2k6gGYKLdFUux
HxJDLxlRW9fC2m6m+ue62Uho/U+wbC1F9Ygn3gWfgruHPIcXzMZ1cBuroy6usrDP
2o5LaV4HIoX1UUGSfKWDQLwl13corVbYD1p8UMICqUJQyoMN9IvtzVn9OVO4b6pe
J3srqeTY3sR6FSnm4806Sznmh5BRMLLXPbHzIPrt798NoMSPy9aH1avN6LUN9tGc
J9n98B8exFBmeu5s0u5oGhgef4UFu8Hwc74duWdR9rf0oBqRU4sovvzKh6B1Y3PX
jD+a3E9be9fcfIXMw/hOgIC7Y81pQA==
=eTnj
-----END PGP SIGNATURE-----

--fvCIPpijJ1sllLFnPuO7DXhs6nqduMAGu--
