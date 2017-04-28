Received: from eggs.gnu.org ([2001:4830:134:3::10]:59193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d494j-0002La-Ln
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 12:49:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d494i-0004Sq-My
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 12:48:57 -0400
References: <20170207235757.2026-1-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <9ebd567b-0255-4935-4bc5-4bf4a10a0572@redhat.com>
Date: Fri, 28 Apr 2017 18:48:50 +0200
MIME-Version: 1.0
In-Reply-To: <20170207235757.2026-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2M8XMnFgvM1qAVlShGt0nDQjCMsBQEoWp"
Subject: Re: [Qemu-devel] [PATCH] progress: Show current progress on SIGINFO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2M8XMnFgvM1qAVlShGt0nDQjCMsBQEoWp
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <9ebd567b-0255-4935-4bc5-4bf4a10a0572@redhat.com>
Subject: Re: [PATCH] progress: Show current progress on SIGINFO
References: <20170207235757.2026-1-mreitz@redhat.com>
In-Reply-To: <20170207235757.2026-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08.02.2017 00:57, Max Reitz wrote:
> Currently we only print progress information on retrieval of SIGUSR1.
> Some systems have a dedicated SIGINFO for this, however, so it should b=
e
> handled appropriately if it is available.
>=20
> Buglink: https://bugs.launchpad.net/qemu/+bug/1662468
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
> Can anyone test this on a BSD system? O:-)
> ---
>  util/qemu-progress.c | 3 +++
>  qemu-img.texi        | 3 ++-
>  2 files changed, 5 insertions(+), 1 deletion(-)

Applied to my block branch.

(https://github.com/XanClic/qemu/commits/block)

Max


--2M8XMnFgvM1qAVlShGt0nDQjCMsBQEoWp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlkDcnISHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AANwH/iXU57Q1xJ9jvr+BdvoFL54VFrGHKOa+
Ds9w9WGMu4M5gB7oiKlAQQSVgp6g4ludMX4NW0e4V57boenJ3ocbo95LQ5rBBSDA
G0a1JfpCllRUBt8VCH+xp1PULNOpxQ4nOlpAVDDricAx3Epk/ce7n1olnitehQUF
af7IUgbzDMHYypyxt1VaV/AashaChwIa6IMEmNokFY7GuCAUE0Ov50GJJNjQn3FK
GtzWBLbN1UsTm+BFDFI2N5tNAOOUFP/2j4y84zcG4j8wjs46bcBpRqoAPwM60hvO
sv9MynXU4XmIuq+blSvuAHOSVYCs0V4TRSZp64wg5ZhJHU0ecir0poY=
=IAGy
-----END PGP SIGNATURE-----

--2M8XMnFgvM1qAVlShGt0nDQjCMsBQEoWp--
