Received: from eggs.gnu.org ([2001:4830:134:3::10]:34134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eiheS-0006rT-5R
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 09:21:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eiheN-0003Sq-GB
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 09:21:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:28275)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eiheN-0003SC-59
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 09:21:39 -0500
Date: Mon, 5 Feb 2018 14:21:27 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180205142127.GA28241@stefanha-x1.localdomain>
References: <20180205054725.25634-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
In-Reply-To: <20180205054725.25634-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/2] Add git-publish config file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@gmail.com, mdroth@linux.vnet.ibm.com


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 05, 2018 at 01:47:23PM +0800, Fam Zheng wrote:
> v3: Fix trivial hunk placement. [Michael]
>     Fix PPC sub-list. [Michael]
>=20
> v2: Add README paragraph [Marc-Andr=E9, Stefan]
>     Fix 'trivial' profile [Marc-Andr=E9]
>     Rename profiles [Stefan]
>=20
> Fam Zheng (2):
>   Add a git-publish configuration file
>   README: Document 'git-publish' workflow
>=20
>  .gitpublish | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++
>  README      | 30 +++++++++++++++++++++++++++++-
>  2 files changed, 87 insertions(+), 1 deletion(-)
>  create mode 100644 .gitpublish
>=20
> --=20
> 2.14.3

I fixed two small issues in README when applying:
s/git-profile/git-publish/ and s/for once/the first time/

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaeGhnAAoJEJykq7OBq3PIhacH/3Mnz1cQSs++Exa+VCoaJgkr
oPtPYmSVVjd87BN4LUZ18AYjFc7DSppWzzqZdzy6P/ezEBu3eYqcJOvtNfvZsvd+
3I5/xFJcc0aJgKASuukmsjiseW+RTFEg2vzJpE+dgh2utEa/fSQYTcdh8b8vXxTI
mGZc4O4imw6CYovL2JFAybKktTzXhTzvJt6jhCGGa++cyhZO6+CJqDrEBdL6p73F
jR1FHi+X59Q7mQg0QvV7s924Y3nI/YDHXYqI7YoTTfDTz+E3VGQ9314tWXKCbBdt
GH4SunmDNSlBn/f0FTnFL6fiMoaJ+zAoEmrx+To1PwTKzvp4uTJbSuNgv03PL2I=
=bfT+
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
