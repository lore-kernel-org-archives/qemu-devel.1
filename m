Received: from eggs.gnu.org ([209.51.188.92]:58345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1h3HeJ-00006Q-TN
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 05:55:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1h3HeJ-0004ZR-1S
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 05:55:11 -0400
Date: Mon, 11 Mar 2019 09:55:05 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190311095505.GB5991@stefanha-x1.localdomain>
References: <1545387387-9613-1-git-send-email-baiyaowei@cmss.chinamobile.com>
	<20190306215633.GM6818@localhost.localdomain>
	<20190307102206.GC2843@stefanha-x1.localdomain>
	<20190307103455.GA5786@linux.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lEGEL1/lMxI0MVQ2"
Content-Disposition: inline
In-Reply-To: <20190307103455.GA5786@linux.fritz.box>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] tcmu: Introduce qemu-tcmu
 utility
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Yaowei Bai <baiyaowei@cmss.chinamobile.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, Amar Tumballi <atumball@redhat.com>, Mike Christie <mchristi@redhat.com>, Prasanna Kalever <pkalever@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Xiubo Li <xiubli@redhat.com>


--lEGEL1/lMxI0MVQ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2019 at 11:34:55AM +0100, Kevin Wolf wrote:
> Am 07.03.2019 um 11:22 hat Stefan Hajnoczi geschrieben:
> > On Wed, Mar 06, 2019 at 10:56:33PM +0100, Kevin Wolf wrote:
> > > Am 21.12.2018 um 11:16 hat Yaowei Bai geschrieben:
> > > * The first priority should be adding an in-process iscsi target that
> > >   can be managed with QMP, similar to the built-in NBD server.
> >=20
> > Using the in-kernel SCSI target with TCMU, or do you mean implementing
> > the iSCSI network protocol inside QEMU?
>=20
> Using TCMU in this case, of course. This point was about external tool
> vs. exporting from a running QEMU instance, not about how to implement
> the actual functionality.
>=20
> Building an external command line tool around QMP functionality is easy,
> but the reverse way isn't necessarily. This is why I think QMP-based
> should come first.

Makes sense, thanks.

Stefan

--lEGEL1/lMxI0MVQ2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJchjB5AAoJEJykq7OBq3PIsEAH/1GrQHG/36Li4OIEPDMbsZs/
11qVNUcRuX81sqvtrVb7OOjV970ImUCaAR2yIEi7b+nQzAFeWoauyoAlYa5mnOjr
PYcrdVGMvLoH+H+hk3ghBGLoX6MlUfq2dV7xBHnY+05XBno4mYDE3unQTWTcmbPu
ZfXBDMXr82N8V0uejN0ZMP20SkRMbFPbYPNNzks2EwlnCmFCb1AOCBodwGl7ESTh
55WTfze71G0npOqxKWx5exR7rcO/d0M+hQ9eWzJb5GHOd8hTsdSYhQ4LQPtGAkpp
Sntq0ZZX+lRoMHVALp1QOaT9PDmllfhpQzR2w/8Z7s3x6vkJPI1EpvR96kCI1AA=
=6v3R
-----END PGP SIGNATURE-----

--lEGEL1/lMxI0MVQ2--
