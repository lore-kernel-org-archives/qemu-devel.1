Received: from eggs.gnu.org ([2001:4830:134:3::10]:57531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fTjpc-0003e8-3b
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 04:11:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fTjpY-0000gY-0H
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 04:11:40 -0400
Received: from 13.mo5.mail-out.ovh.net ([87.98.182.191]:58942)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fTjpX-0000ej-O8
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 04:11:35 -0400
Received: from player735.ha.ovh.net (unknown [10.109.122.6])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 9DB351BF6C7
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 10:11:33 +0200 (CEST)
Date: Fri, 15 Jun 2018 10:11:24 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180615101124.41862862@bahia.lan>
In-Reply-To: <20180615014501.GI4129@umbus.fritz.box>
References: <152882087494.112322.15549780953419438229.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<152882305541.114463.3137854902721347235.stgit@bahia.lan>
	<20180613004506.GM30690@umbus.fritz.box>
	<20180613101915.4cc9485b@bahia.lab.toulouse-stg.fr.ibm.com>
	<ea3044c2-d8cd-d41d-91a6-5d78bff86e76@linaro.org>
	<20180615000020.2a3372a5@bahia.lan>
	<20180615014501.GI4129@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/kZFT.U/nDwlxL1JD/ak/mQH";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 3/3] target/ppc: filter out
 non-zero PCR values when using TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org

--Sig_/kZFT.U/nDwlxL1JD/ak/mQH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 15 Jun 2018 11:45:01 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Fri, Jun 15, 2018 at 12:00:20AM +0200, Greg Kurz wrote:
> > On Thu, 14 Jun 2018 09:52:55 -1000
> > Richard Henderson <richard.henderson@linaro.org> wrote:
> >  =20
> > > On 06/12/2018 10:19 PM, Greg Kurz wrote: =20
> > > > I'm confused... I don't see anything related to HTM in TCG. Also we=
 have
> > > > the following in cap_htm_apply():
> > > >=20
> > > >     if (tcg_enabled()) {
> > > >         error_setg(errp,
> > > >                    "No Transactional Memory support in TCG, try cap=
-htm=3Doff");
> > > >=20
> > > > I'm probably missing something... can you enlighten me ?   =20
> > >=20
> > > One of the two IBM machines -- and I thought it was ppc not s390x, bu=
t the code
> > > you quote seems to deny that memory -- has stub support for TM within=
 TCG. =20
> >=20
> > Oh ? I didn't know and didn't check :) =20
>=20
> That is true, there are stub implementations of the TM instructions.
>=20
> >  =20
> > > To wit, the instructions are recognized and transactions always fail.=
  Which is
> > > not a bad way to test the required fallback paths that rarely fail on=
 hardware.
> > >  ;-) =20
> >=20
> > If TM instructions don't cause an exception, I guess its reasonable to =
say
> > they're supported :) =20
>=20
> That argument has come up before, and I disagree.  I don't think it's
> reasonable to advertise TM support as available if the instructions
> always fail.
>=20

Fair enough! :)

--Sig_/kZFT.U/nDwlxL1JD/ak/mQH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAlsjdKwACgkQcdTV5YIv
c9aVCQ/7B+ALsHK2g5HhSyhtffiq9qaywOgitGWuk0mU3CG7EHXSWQ2wyZ5v9PjW
eF+dF77+Va+REFmDx/FgBufUs/HVGUqZGFhoKpEukRxu/NwAenPUpW+rJnXv/T4e
7Odu/4RfzvGOe+jj2YB8XT15N4gh4LK6qpMwYLA7AxlDQvK3ivyRafokOoykMKvR
T+tVhJieBy1dZO39PRAOe4hRNp+EEuKhUuXPKvB0RQq/x3zhVWgZx7py7GnloS2J
cpe2kkjvCI3gsqIWbOVip4CYbcLz/fm9AV5TQToApeDvmW/GZ0a6f2XeswyXKVu7
dLxqNQlCEgPn0lIE/T7v6KCcLHSdyXc+4bCSYVFlv/KKTTNlFGZ00+hdXqmnRFdn
yVUSJm660aavcV1MbCUCKCGcc4/3PRqVtjYTwi3XXIx4d/V50+lSw2reJgz7P0Mn
Pxf3vmJ4dU60h0z3noYAPl761MZ2zGTn8bA1sQHwgocWKdQrVSKyITKzYy6Sx7Aj
Ep5oZX8HkpKZOyC7IuRe6LYpgr53jfLzUjMjWIf4bU0S2CIIghJDK9QHFDaYrf7v
b7dhdsDKVUZ7RkaKobBAm6k+Uk3qsK/36WmLzIucj2RjOXhXTvinQEC/ckw20dZb
BhxI5gNc4Fp1JRfQxU3L6BGMgN+DPRLYKclK7J6oaAZW8J1arJI=
=wZuQ
-----END PGP SIGNATURE-----

--Sig_/kZFT.U/nDwlxL1JD/ak/mQH--
