Received: from eggs.gnu.org ([209.51.188.92]:54973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gz1OG-0002fu-IT
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 10:45:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gz1O3-000094-Co
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 10:44:53 -0500
Date: Wed, 27 Feb 2019 15:33:11 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190227153311.GH22539@stefanha-x1.localdomain>
References: <20190226153549.17867-1-stefanha@redhat.com>
	<8a8d76d1-1280-f3d9-3d72-1c662d1ad666@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="o71xDhNo7p97+qVi"
Content-Disposition: inline
In-Reply-To: <8a8d76d1-1280-f3d9-3d72-1c662d1ad666@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] file-posix: add drop-cache=on|off option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>, qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>, Neil Skrypuch <neil@tembosocial.com>, Max Reitz <mreitz@redhat.com>


--o71xDhNo7p97+qVi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 26, 2019 at 10:54:55AM -0600, Eric Blake wrote:
> On 2/26/19 9:35 AM, Stefan Hajnoczi wrote:
> > Commit dd577a26ff03b6829721b1ffbbf9e7c411b72378 ("block/file-posix:
> > implement bdrv_co_invalidate_cache() on Linux") introduced page cache
> > invalidation so that cache.direct=3Doff live migration is safe on Linux.
> >=20
> > The invalidation takes a significant amount of time when the file is
> > large and present in the page cache.  Normally this is not the case for
> > cross-host live migration but it can happen when migrating between QEMU
> > processes on the same host.
> >=20
> > On same-host migration we don't need to invalidate pages for correctness
> > anyway, so an option to skip page cache invalidation is useful.  I
> > investigated optimizing invalidation and detecting same-host migration,
> > but both are hard to achieve so a user-visible option will suffice.
> >=20
> > As a bonus this option means that the cache invalidation feature will
> > now be detectable by libvirt via QMP schema introspection.
>=20
> Do you still want to pursue the QMP query-qemu-features command, or does
> this delay that for another day?

The presence of this new option doesn't guarantee that dropping caches
works.  It is currently only implemented on Linux.

We still need query-qemu-features so that libvirt can detect whether
this QEMU binary can drop caches (e.g. on Linux vs FreeBSD).

Stefan

--o71xDhNo7p97+qVi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcdq23AAoJEJykq7OBq3PIsa0H/jdjWertbi9rQ/7pEGsABOlr
knJ7QFr9bVeD85CA6nKadIyJV1CrqEOCK0louLwDh5Y1KE3aEV1Zaz24MB1LNQcr
9Iw4YeB/EFi8Qpx3UZ3CWfHH2UX8HLHWS6CI4RW2j0717TghpnhdJLKZxkllyioG
3+dGSFhOwKlK3LcbMVGoNCw2r7d8iBMcf47OKaL5nTtjf6porTUB0ErZe0JxLoQa
8AKzYzxQ4hoE1JOACl6et+DwMMPN7HB63k+vHDUiAo4dDGcVxLcDzZyrKbgsBGQ/
JXvhD/VN68stKSe02zqRYpipFWaQDvspeMYb6SJ0y5mT0HjByULRuQGAkFu8nx8=
=wgTL
-----END PGP SIGNATURE-----

--o71xDhNo7p97+qVi--
