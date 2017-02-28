Received: from eggs.gnu.org ([2001:4830:134:3::10]:59861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cijj2-0006v7-5Z
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 10:30:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cijiz-00024R-IX
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 10:30:04 -0500
References: <1488286469-9381-1-git-send-email-kwolf@redhat.com>
	<1488286469-9381-26-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <ab4ec47b-cedc-aa3a-0c60-53cb292c0a45@redhat.com>
Date: Tue, 28 Feb 2017 16:29:54 +0100
MIME-Version: 1.0
In-Reply-To: <1488286469-9381-26-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="HSjIHK87eExIEA5RMSLBrBW9Gmvd08IOH"
Subject: Re: [Qemu-devel] [PATCH v3 25/44] commit: Use real permissions in
 commit block job
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HSjIHK87eExIEA5RMSLBrBW9Gmvd08IOH
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <ab4ec47b-cedc-aa3a-0c60-53cb292c0a45@redhat.com>
Subject: Re: [PATCH v3 25/44] commit: Use real permissions in commit block job
References: <1488286469-9381-1-git-send-email-kwolf@redhat.com>
 <1488286469-9381-26-git-send-email-kwolf@redhat.com>
In-Reply-To: <1488286469-9381-26-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 28.02.2017 13:54, Kevin Wolf wrote:
> This is probably one of the most interesting conversions to the new
> op blocker system because a commit block job intentionally leaves some
> intermediate block nodes in the backing chain that aren't valid on thei=
r
> own any more; only the whole chain together results in a valid view.
>=20
> In order to provide the 'consistent read' permission to the parents of
> the 'top' node of the commit job, a new filter block driver is inserted=

> above 'top' which doesn't require 'consistent read' on its backing
> chain. Subsequently, the commit job can block 'consistent read' on all
> intermediate nodes without causing a conflict.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/commit.c | 113 ++++++++++++++++++++++++++++++++++++++++++++++++-=
--------
>  1 file changed, 95 insertions(+), 18 deletions(-)

Thanks for the comment change!

Reviewed-by: Max Reitz <mreitz@redhat.com>


--HSjIHK87eExIEA5RMSLBrBW9Gmvd08IOH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAli1l3ISHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ApgsIAKnK47wGuzemyxxv4GKW0uHrQjdX5MdM
DP0ARO7siMcjgusxNSThQmrv5ORaTUFcgM6tKGNpb2dJ37W4VwzJ8BiM1uPf5nym
HrS7+fhUINLPzfPTNEYfnMEMadj/KWpStAR1tL8emkn/UedYLLaX2k62SpsTssJS
MGsWqR6DpllaJNB6Stet47EN67b8yQxZekTPQ2vLjJ0KAxoRuNCAF+Lc3Lazum7R
zLH4Ms+h3eVtDU8RTZHESBhQNz4Jbe7y+6iNqoYnmBHHsUHC3wY3MYK/C78DwwKb
6IrpPO7t1fytmTGUYzl8iO8nnx/OOEmyIf1vmhbl7cVcprthGXz2FGo=
=Jm21
-----END PGP SIGNATURE-----

--HSjIHK87eExIEA5RMSLBrBW9Gmvd08IOH--
