Received: from eggs.gnu.org ([2001:4830:134:3::10]:52060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ek9QP-0006wv-R7
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 09:13:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ek9QO-00056o-Uy
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 09:13:13 -0500
References: <20180208192328.16550-1-kwolf@redhat.com>
	<20180208192328.16550-5-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <5641b890-bb30-a253-634b-13e0e28d0110@redhat.com>
Date: Fri, 9 Feb 2018 15:12:48 +0100
MIME-Version: 1.0
In-Reply-To: <20180208192328.16550-5-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ngfhkrzotH0lTFlJM5Z3g3r7SEL8txXtR"
Subject: Re: [Qemu-devel] [PATCH 04/27] qcow2: Pass BlockdevCreateOptions to
 qcow2_create2()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com, jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ngfhkrzotH0lTFlJM5Z3g3r7SEL8txXtR
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com,
 jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com,
 qemu-devel@nongnu.org
Message-ID: <5641b890-bb30-a253-634b-13e0e28d0110@redhat.com>
Subject: Re: [PATCH 04/27] qcow2: Pass BlockdevCreateOptions to
 qcow2_create2()
References: <20180208192328.16550-1-kwolf@redhat.com>
 <20180208192328.16550-5-kwolf@redhat.com>
In-Reply-To: <20180208192328.16550-5-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-08 20:23, Kevin Wolf wrote:
> All of the simple options are now passed to qcow2_create2() in a
> BlockdevCreateOptions object. Still missing: node-name and the
> encryption options.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/qcow2.c | 190 ++++++++++++++++++++++++++++++++++++++++++++++----=
--------
>  1 file changed, 152 insertions(+), 38 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--ngfhkrzotH0lTFlJM5Z3g3r7SEL8txXtR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlp9rGASHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9Afx8H/iZjgOCk6hYmN0up+raOitciD+zz7zeo
ju1qwl7m+QjL04L+5XQK2y2yTE4+rV94IDgg1jBR39fRRdzGMX0Z6aBnAHhrhgKr
IzvYmhMlLga9TolJl3AmN7vK963i7jf/kZFg3qkJJ+WG+qTzgNwxe4Xh5dWQm2eX
/NNaJtvRcx6Id0x69F4nbeQr3bbhgpIWdPir36K0E6cZupnAjO5zYOrn7Mx3ULXN
am7xNoYEa1TP7c1GkKFtzV/Y7sJCQbGlD9Hn5lWFwLhEpoDpBuT3Rb0/hdkKFfEu
7shEyZ45sJhrJ5ykDMCav77BAisZbuvZKJgqPnnCXmCHK/2C3wiCBqA=
=4SUa
-----END PGP SIGNATURE-----

--ngfhkrzotH0lTFlJM5Z3g3r7SEL8txXtR--
