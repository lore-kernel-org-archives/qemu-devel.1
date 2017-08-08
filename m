Received: from eggs.gnu.org ([2001:4830:134:3::10]:43935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1df5sv-0002Ml-9L
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 10:53:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1df5su-0004AU-4A
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 10:53:29 -0400
References: <1502117160-24655-1-git-send-email-armbru@redhat.com>
	<1502117160-24655-28-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <dd036d00-e59d-6696-e872-6557d7fe75f2@redhat.com>
Date: Tue, 8 Aug 2017 09:53:13 -0500
MIME-Version: 1.0
In-Reply-To: <1502117160-24655-28-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="erOCMpAomqXhkEMBISOdXHdA7djrwQFr0"
Subject: Re: [Qemu-devel] [RFC PATCH 27/56] block/dirty-bitmap: Clean up
 signed vs. unsigned dirty counts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, famz@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com, dgilbert@redhat.com, quintela@redhat.com, berrange@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--erOCMpAomqXhkEMBISOdXHdA7djrwQFr0
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, famz@redhat.com,
 jsnow@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com,
 dgilbert@redhat.com, quintela@redhat.com, berrange@redhat.com,
 qemu-block@nongnu.org
Message-ID: <dd036d00-e59d-6696-e872-6557d7fe75f2@redhat.com>
Subject: Re: [RFC PATCH 27/56] block/dirty-bitmap: Clean up signed vs.
 unsigned dirty counts
References: <1502117160-24655-1-git-send-email-armbru@redhat.com>
 <1502117160-24655-28-git-send-email-armbru@redhat.com>
In-Reply-To: <1502117160-24655-28-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/07/2017 09:45 AM, Markus Armbruster wrote:
> hbitmap_count() returns uint64_t.
>=20
> Clean up test-hbitmap.c to check its value with g_assert_cmpuint()
> instead of g_assert_cmpint().
>=20
> bdrv_get_dirty_count() and bdrv_get_meta_dirty_count() return its
> value converted to int64_t.  Clean them up to return it unadulterated.
>=20
> This moves the implicit conversion to some callers, so clean them up,
> too.
>=20
> mirror_run() assigns the value of bdrv_get_meta_dirty_count() to a
> local int64_t variable.  Change it to uint64_t.  Signedness still gets
> mixed up in the computation of s->common.len, but messing with that is
> more than I can handle right now.
>=20
> get_remaining_dirty() tallies bdrv_get_dirty_count() values in
> int64_t.  Its caller block_save_pending() converts it back to
> uint64_t.  Change get_remaining_dirty() to uint64_t.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  block/dirty-bitmap.c         |  4 ++--
>  block/mirror.c               |  4 ++--
>  block/trace-events           |  8 ++++----
>  include/block/dirty-bitmap.h |  4 ++--
>  migration/block.c            |  4 ++--
>  tests/test-hbitmap.c         | 16 +++++++++-------
>  6 files changed, 21 insertions(+), 19 deletions(-)

I don't know how much this will conflict with my pending work for
byte-based block status, but I suspect it may be easier for your RFC to
go in after my cleanups (I think you'll still have things to fix).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--erOCMpAomqXhkEMBISOdXHdA7djrwQFr0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmJ0FkACgkQp6FrSiUn
Q2pFXQf9GE1YJesfGn5XcUZSdXjxZ+TCGe5vIPdA0x4dKwuZOMC/yKvmdAovhA62
ZHyRkUpnNdoTo7KRVD7orQNHgHv6Iltu5VsL7e2UUqP2abXQ7no0nrnPwiMWadgX
Ju1U+FTAR4vp240hi66i78OdmePmJ+3d8bPc/RrbpxJXXqLW8eZCXy7NLYgOWsgA
VSxampHw5M8t1Oz7hDBhRVR8oMeDbA9T60oNz7DzguPvQyzD5fQQXY8DhfNp5Hfu
mA28dbm1LlG1soy5SSX8DGdcpbX7Xy94PSUP100IgURTlFRo/dJCfm0a++l5ZS72
egTi9q4agAJt/0hqVR0dcm0s8jIw+g==
=ZoPG
-----END PGP SIGNATURE-----

--erOCMpAomqXhkEMBISOdXHdA7djrwQFr0--
