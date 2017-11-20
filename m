Received: from eggs.gnu.org ([2001:4830:134:3::10]:39615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eGnBT-00082N-KV
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 09:36:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eGnBS-0007It-Pk
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 09:36:27 -0500
Date: Mon, 20 Nov 2017 15:36:18 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171120143618.GC7197@localhost.localdomain>
References: <20171117164747.11525-1-eblake@redhat.com>
	<9279377e-9165-d6b9-930f-7949c2c1fb72@redhat.com>
	<dbb84db4-ead4-e8cf-25c4-fba4dd8701c4@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JP+T4n/bALQSJXh8"
Content-Disposition: inline
In-Reply-To: <dbb84db4-ead4-e8cf-25c4-fba4dd8701c4@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.11] qcow2: fix image corruption on
 commit with persistent snapshot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, vsementsov@virtuozzo.com


--JP+T4n/bALQSJXh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 17.11.2017 um 19:46 hat Eric Blake geschrieben:
> > -- and I'm not really a fan of testing this on every possible
> > architecture and then adding different reference outputs.
> >=20
> > Therefore, the best fix is probably to just filter the hashes out (you
> > don't need the exact value anyway, do you?), and I think it's fine to do
> > this as a follow-up.
>=20
> At any rate, I concur with this conclusion; I'll post a followup that
> filters out the hash (for this test, we only care that the existence of
> a hash proves the bitmap exists; unlike 165 where we want to validate
> that it is actually tracking correct information).
>=20
> I missed Kevin's -rc2 pull, unless he wants to send a v2; but we also
> have time (it's not the end of the world if the fix goes in -rc3).

There is no rule that a maintainer can only send one pull request per
release candidate. I already missed -rc1, so I wanted to make sure to
get things merged definitely in time for -rc2, but it's not too unlikely
that I'll send another small pull request for tomorrow.

Kevin

--JP+T4n/bALQSJXh8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJaEuhiAAoJEH8JsnLIjy/Wt8UP/ilDx6/sn6vDqkZqVcMuxsd4
zhfTxaHS04tas2uFX6IydmROQSe9nbTCKMFqR/LstqunayNlHEayQhug3A1ZdmQ4
XQAQGe1/DPLWqE4neSVJ4uXT6uUe8PbC/hbHjQLBpr7KkL6cdh95XnWe0tjb3UQt
prlKY7sh1Sw8LFxlpqGcCBtU6fAkVL78KlvKNQhog4HL+SNctKxpVHLlfcF/0sad
4NAzQCg4pzMrLILNAMfQNCeaH1uFmEQNO0lvKO1lFreV2IOsK6YLoWYdwkQ1mAl6
PMidS317QeAZu3VzxUoMmqzA5wdJqYNp+ne5JLD0J03vNvJNchAXRWBkKLIQZek0
PlFFWMULVihOh2mx1cd3pbNh5jh9fH+vXVJF9zmM7CoVBPokP062O0SEMGAVdnok
QiKeK4Av9WmnxU5YC8xF95RGCelUXF3Cqw+rrVydtKUeZmF/8nAmDuu5iiE77MrY
UpeuVl56AiQ5/bNrvG1hxn4XPKleBh8gKZAZzQTP0iV0oVCG3IGgt6N4YD7OEARJ
Po9LpHjFQVeHMVeQ/zFbvNEXk8hmy8xh+N4lscIqDl+nVXs+TjNrISLzOBKnijiT
rly9fouNdhy0TAOIbGpghHGxyOBEw8dtHtQ8qr1eAkOEpTjisq5ulbFbvHKKq+10
ilft++vwSgWIt2tkHsAZ
=EKol
-----END PGP SIGNATURE-----

--JP+T4n/bALQSJXh8--
