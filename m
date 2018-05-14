Received: from eggs.gnu.org ([2001:4830:134:3::10]:55974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fIJTT-0008P7-Md
	for qemu-devel@nongnu.org; Mon, 14 May 2018 15:49:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fIJTS-0000kn-Tu
	for qemu-devel@nongnu.org; Mon, 14 May 2018 15:49:35 -0400
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-30-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <3ca835b1-07ef-8333-3b8e-1e5aab79ef76@redhat.com>
Date: Mon, 14 May 2018 21:49:27 +0200
MIME-Version: 1.0
In-Reply-To: <20180509162637.15575-30-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="NmdsQpwhdEz8CcUq0TIu7THIGUJFU2thj"
Subject: Re: [Qemu-devel] [PATCH 29/42] job: Move job_finish_sync() to Job
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: eblake@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NmdsQpwhdEz8CcUq0TIu7THIGUJFU2thj
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: eblake@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <3ca835b1-07ef-8333-3b8e-1e5aab79ef76@redhat.com>
Subject: Re: [PATCH 29/42] job: Move job_finish_sync() to Job
References: <20180509162637.15575-1-kwolf@redhat.com>
 <20180509162637.15575-30-kwolf@redhat.com>
In-Reply-To: <20180509162637.15575-30-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-09 18:26, Kevin Wolf wrote:
> block_job_finish_sync() doesn't contain anything block job specific any=

> more, so it can be moved to Job.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/qemu/job.h |  9 +++++++++
>  blockjob.c         | 55 +++++++++-------------------------------------=
--------
>  job.c              | 28 +++++++++++++++++++++++++++
>  3 files changed, 46 insertions(+), 46 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--NmdsQpwhdEz8CcUq0TIu7THIGUJFU2thj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlr56EcACgkQ9AfbAGHV
z0A6dAf/RkZd9r93pMVNXFigFL/7uzRfQ3vp0RhCFwt/Xclpw/vcTeYQc22V23Pn
VKe3TxnTRCI2ANJFsEyTw1myn/cBsMPc5s9+RjhCMNUy3ZlvIW7T7X/tDLkXX7vb
o/SUyzJIR3cJkkNE01gG+V7BykfNePCupZ5l5ErGD6TH5A4KY1l9e6ycA8RiKxz1
RXtKPGHxSKJgqA7MkCAbX6PEqrjLrqjnyJaz9dEJRsQJurE/I2o8S84av098CgWH
515cLTfTTCagGmalJ0dW2Cjl65qpGvVBiUzmVRD+9QiqfabRZ2/A55EeQ0D4e5oJ
15C0IVOY2AsQ6Hzcx0A1J+pLZQ+zPA==
=MshP
-----END PGP SIGNATURE-----

--NmdsQpwhdEz8CcUq0TIu7THIGUJFU2thj--
