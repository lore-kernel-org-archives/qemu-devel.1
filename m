Received: from eggs.gnu.org ([2001:4830:134:3::10]:56965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dG2s2-0006V6-KU
	for qemu-devel@nongnu.org; Wed, 31 May 2017 08:37:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dG2s1-0002X4-TJ
	for qemu-devel@nongnu.org; Wed, 31 May 2017 08:37:02 -0400
Date: Wed, 31 May 2017 13:36:53 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170531123653.GO16733@stefanha-x1.localdomain>
References: <1495830130-30611-1-git-send-email-kwolf@redhat.com>
	<1495830130-30611-15-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i7KxW38SoMauyveo"
Content-Disposition: inline
In-Reply-To: <1495830130-30611-15-git-send-email-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 14/29] qed: Make
 qed_aio_read_data() synchronous
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


--i7KxW38SoMauyveo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 26, 2017 at 10:21:55PM +0200, Kevin Wolf wrote:
> Note that this code is generally not running in coroutine context, so
> this is an actual blocking synchronous operation. We'll fix this in a
> moment.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/qed.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--i7KxW38SoMauyveo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZLrjlAAoJEJykq7OBq3PI0IoIAIid/qExHmMDErF2GgNgS6uj
KRy18GqYtOanAazjJRKJMl7u5kpfnssjURMPRzIpcWURh5C6T6W5AdZkjlnAKqnu
XY2eXYVaTHVy6i03IvYUr5llllCHsnM4EiL3CkGKR8kG3SKogOcz8xT7h4hiqT85
TiCfWWLrcLRlYKnllWzdEjxnP+JQPUayL8ocCRM6IJm+jiZlfjeyF1+5c2WyFHj+
u8taIWskBsMWznrkZNOwAJTx1NExUiyapCY4r0M3BqOPev+n359F6gUrdS9EkPhQ
qYKw9eJUG79Y9bI10q+wieOdl11yVediFLcBL5eoq4GOySAqwZgvBsi/F7To1MM=
=yLYF
-----END PGP SIGNATURE-----

--i7KxW38SoMauyveo--
