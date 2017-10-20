Received: from eggs.gnu.org ([2001:4830:134:3::10]:33064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e5Yy3-00044l-LN
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 11:12:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e5Yxx-0004Vz-Se
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 11:12:11 -0400
Date: Fri, 20 Oct 2017 17:11:18 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171020151118.GD3667@localhost.localdomain>
References: <20171012034720.11947-1-eblake@redhat.com>
	<20171012034720.11947-24-eblake@redhat.com>
	<61e393f8-fcc5-b098-d6f2-160091c448c2@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
In-Reply-To: <61e393f8-fcc5-b098-d6f2-160091c448c2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 23/24] qcow2: Relax is_zero() assertion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, famz@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 12.10.2017 um 15:20 hat Eric Blake geschrieben:
> On 10/11/2017 10:47 PM, Eric Blake wrote:
> > Now that bdrv_is_allocated accepts non-aligned inputs, we can
> > remove the TODO added in earlier refactoring.
> >=20
> > Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> I was a bit too hasty in the copy-and-paste from 22/24 - there is no
> assertion in this patch, so the subject would be better as:
>=20
> qcow2: Reduce is_zero() rounding

In fact, I don't see any assertion being modified in patch 22 either.

Kevin

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJZ6hIWAAoJEH8JsnLIjy/Wmf0P/2FM4VcyWBH7iV7HtwTV1U++
GaAFl+R9bEgE3ezHsJNfE15zJY80TX1O4W/fXeEBOHkvec8OB5c3P8s5x+SYB6BL
CnX7xeZKrp+yalvX0EB/HfBTGwU9PRhe3snh8+ohMTAYmzoOtIgK0rDvewpwJyqF
cV/ResshWrzzDK9U0EiLRcB/CB/1lsXSRe0vGE1l0LUzsKeHrKRzLNuQMSG4grxL
8jx25YPHGiqQIqYx2tb4jya33FOQiz4zwWCSth6tE/Ha2KzQq5A23bmE3kzU37z8
wNwluSGq1I/tFVHQE6b6QqFqZz3MGmsJYdp3WFKUsTNJlW7NGGIO9vj4D6VRi4pC
gdaSYx2uYT1CSUEjB+qYh6SZEadlfEbOwDxnNS1li0VkFY/Qxrk1KGQ2Fb+7KMrF
VXZzpT3GkZJ2tlrVa89210LN5qWW2cbeBQ7fQ7PbuuusRdEQKtAHMoEawIjwb/6G
lvgZzxUwVskHL464IsQro0rYurwjeoX8WPOM845N8/7XhuV92GYgUpRqWdt0gvOS
nN/1SVkY2iv0sa7PO1qEGgDsrs9HCbaIgAHNdw4DhiuTQCvYQgoQ6x5sgzqRdLf4
Xy2dOPv/Hjw90FT65ZFhUQB2tUmLhurkzLfCQtb7SfX8vFklX+0zpjr74cKd8SPk
lanWX5BVmbuR4WVqVuYx
=AzDU
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
