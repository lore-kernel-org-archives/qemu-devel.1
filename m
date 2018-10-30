Received: from eggs.gnu.org ([2001:4830:134:3::10]:55203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gHQWx-0006hJ-Qa
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 05:41:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gHQWx-0002Gn-4M
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 05:41:47 -0400
Date: Tue, 30 Oct 2018 09:41:39 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20181030094139.GA3743@stefanha-x1.localdomain>
References: <20180816135837.13149-1-jcfaracco@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
In-Reply-To: <20180816135837.13149-1-jcfaracco@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/4] Adding LZFSE compression support
 for DMG block driver.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julio Faracco <jcfaracco@gmail.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 16, 2018 at 10:58:33AM -0300, Julio Faracco wrote:
> Since Mac OS X El Capitain (v10.11), Apple uses LZFSE compression to=20
> generate compressed DMGs as an alternative to BZIP2. Possible, Apple
> want to keep this algorithm as default in long term. Some years ago,=20
> Apple opened the LZFSE algorithm to opensource and the main source (or=20
> the most active repo), can be found at: https://github.com/lzfse/lzfse
>=20
> Julio Faracco (4):
>   block: adding lzfse decompressing support as a module.
>   configure: adding support to lzfse library.
>   dmg: including dmg-lzfse module inside dmg block driver.
>   dmg: exchanging hardcoded dmg UDIF block types to enum.

Hi Julio,
Sorry I didn't get to this patch, I was away on leave.

Do you have time to rebase it on the latest qemu.git/master and send it
again?

Thanks,
Stefan

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJb2CdTAAoJEJykq7OBq3PIX8MH/0ZpXhepBr0a1NjuWOJeEpUz
FWjHEKac1NxiGXnvnhvmoe/WY7BTcQRcPo6upZbwIQ8gtLZhBeGvcz7rwLOA7Fg7
JOO88Uz/i6lsX2slL6MXmWPkONPN9FLe0vwM1wjjc7TXmU0h1Dvl+GHpOXPDiXpi
kxkp8QGbfCAQlG7bVC55TYwd7GsR72LNyjut2tLusxwJHVqVbrl7HozBSGDtFdFr
do1j2cqUp/uA7vINUMzuW+ksgnfJHVzWlqfV6QhnvZrexkydIMOVAGZ1FJ8aoKXr
2YA7D57lFHV6DbLrpjGLGkZdisLBmEbA7MgQbbg9LIdd2g3ptFtwH0YSTM5+QtA=
=Jqz8
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
