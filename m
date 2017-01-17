Received: from eggs.gnu.org ([2001:4830:134:3::10]:45529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cTTbY-00043l-Rg
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 08:15:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cTTbX-0001Dn-WA
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 08:15:16 -0500
Date: Tue, 17 Jan 2017 13:15:04 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170117131504.GI4265@stefanha-x1.localdomain>
References: <1480926904-17596-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1480926904-17596-5-git-send-email-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BghK6+krpKHjj+jk"
Content-Disposition: inline
In-Reply-To: <1480926904-17596-5-git-send-email-zhang.zhanghailiang@huawei.com>
Subject: Re: [Qemu-devel] [PATCH RFC v2 4/6] replication: fix code logic
 with the new shared_disk option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: zhanghailiang <zhang.zhanghailiang@huawei.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, wency@cn.fujitsu.com, xiecl.fnst@cn.fujitsu.com


--BghK6+krpKHjj+jk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 05, 2016 at 04:35:02PM +0800, zhanghailiang wrote:
> Some code logic only be needed in non-shared disk, here
> we adjust these codes to prepare for shared disk scenario.
>=20
> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
> ---
>  block/replication.c | 47 ++++++++++++++++++++++++++++-------------------
>  1 file changed, 28 insertions(+), 19 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--BghK6+krpKHjj+jk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYfhjYAAoJEJykq7OBq3PIMrQH/1OG5KLYlkD+hIRJIqXtQQWs
RzJnqESTyW9hAXWiGY6cjjXVhOapWsx59bL7lmigqgPHE/eJ/aaTezzSbd4FHFpn
XMEyGe+CyKpcEc6arfbgmCFu0o+820bHyUjjbDemuOqGLf96UqLPwJdJs9oaiG/x
mFp9ab1ZAiiWyaM8Lr3Hf0usQ+lqxNeHJoR7QJmB2yZ6Mc60sb5aSeYzIPB8dN3L
7Kugf+Q1B6afcS1LKGvfUOQuIH3S32QQZCFNEvgdr5b4vEE7mjg1KTMSInp9oVUk
N2x7GVvI9jctr/JOBlV0tzY8mEdMvezmngXADtLm0FEIBUAGeP6PQHIU8pkOLtk=
=YV6o
-----END PGP SIGNATURE-----

--BghK6+krpKHjj+jk--
