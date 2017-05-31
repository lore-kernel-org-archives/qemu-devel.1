Received: from eggs.gnu.org ([2001:4830:134:3::10]:58016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dG2w7-0000wK-GU
	for qemu-devel@nongnu.org; Wed, 31 May 2017 08:41:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dG2vy-00040Y-7p
	for qemu-devel@nongnu.org; Wed, 31 May 2017 08:41:15 -0400
Date: Wed, 31 May 2017 13:40:57 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170531124057.GS16733@stefanha-x1.localdomain>
References: <1495830130-30611-1-git-send-email-kwolf@redhat.com>
	<1495830130-30611-19-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CRjAHycgiaTQGSqU"
Content-Disposition: inline
In-Reply-To: <1495830130-30611-19-git-send-email-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 18/29] qed: Add return value
 to qed_aio_write_l2_update()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, pbonzini@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com, mreitz@redhat.com


--CRjAHycgiaTQGSqU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 26, 2017 at 10:21:59PM +0200, Kevin Wolf wrote:
> Don't recurse into qed_aio_next_io() and qed_aio_complete() here, but
> just return an error code and let the caller handle it.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/qed.c | 43 ++++++++++++++++++++++++++-----------------
>  1 file changed, 26 insertions(+), 17 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--CRjAHycgiaTQGSqU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZLrnZAAoJEJykq7OBq3PIlX0IALXmlK+jwTR6tCNRAEIeEyA/
GdZNemF53bNWtPt5pVjFBH62Xzd1po8II+Tvt2P0x3MlwbnFUehibBHtkxniHVjG
pDEp1qE8e7fmEowgC5q7SgEeAM40UblKty6pdp1jtEXHyyCuwm4pQYS5CCN66K8g
RM4ut+vISTbmDmQh2QIhsD+lBU6zXKjEPnWJQB99fgdK42dFmDjc5QQx0p072BpR
8lvz4ywy8dZJzafLe7hCsZ65euihevp3j+HgmjJtKWbPJfIUn5nWRVXnS7C/YBuz
LnAI0DtQy/Oz/2LGVs+CgfkICybH75PSqYWoA2iKdBPE43z0hcXZbVirKUt1B3A=
=11qs
-----END PGP SIGNATURE-----

--CRjAHycgiaTQGSqU--
