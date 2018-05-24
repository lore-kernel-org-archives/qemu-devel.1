Received: from eggs.gnu.org ([2001:4830:134:3::10]:34946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fLlGA-0006sI-JF
	for qemu-devel@nongnu.org; Thu, 24 May 2018 04:06:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fLlG5-0006oX-ME
	for qemu-devel@nongnu.org; Thu, 24 May 2018 04:06:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48668 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fLlG5-0006o8-HC
	for qemu-devel@nongnu.org; Thu, 24 May 2018 04:06:01 -0400
Date: Thu, 24 May 2018 09:05:53 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180524080553.GB20733@stefanha-x1.localdomain>
References: <152646971421.34839.18198173866060880395.stgit@bahia.lan>
	<20180518153246.GE31915@stefanha-x1.localdomain>
	<20180523164610.09ec083b@bahia.lan>
	<ede94233-e969-0de4-c8ee-a9ff91ce808a@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GID0FwUMdk1T2AWN"
Content-Disposition: inline
In-Reply-To: <ede94233-e969-0de4-c8ee-a9ff91ce808a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] block: fix QEMU crash with scsi-hd and
 drive_del
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Greg Kurz <groug@kaod.org>, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>


--GID0FwUMdk1T2AWN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 24, 2018 at 08:04:59AM +0200, Paolo Bonzini wrote:
> On 23/05/2018 16:46, Greg Kurz wrote:
> > Maybe change bdrv_root_unref_child() to ensure we don't call
> > bdrv_close() with pending I/O requests ?
> >=20
> >  void bdrv_root_unref_child(BdrvChild *child)
> >  {
> >      BlockDriverState *child_bs;
> > =20
> >      child_bs =3D child->bs;
> > +    bdrv_drained_begin(child_bs);
> >      bdrv_detach_child(child);
> > +    bdrv_drained_end(child_bs);
> >      bdrv_unref(child_bs);
> >  }
>=20
> Maybe bdrv_detach_child should do it.

Sounds good.

Stefan

--GID0FwUMdk1T2AWN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbBnJhAAoJEJykq7OBq3PI+ckH/3dvbgB3DijaeEbbhOWzBjwg
/UpPIFofhj3wJigOwCaD5SDsQf2LRBNhBuwgLuoM+z+6fF1rRPK0kMx4h4MQBDSD
xN+z7HpKQy9w7NYVdX/zDZjrh3kjfCogNPoasnCmN7sk4efeMZ8T58foPd7VwhFO
yvf1/fTAjb9vAQDgAM2Pnzd/5epIz90qiARh2pzebelOm8c+zx+YHjrXx4i3+rV1
tcUyLhoPSfJ6JS928VALRZdbRoE27UtxIMgt0XI0i1tylkTpDkH4rnUHhyEU+b+9
bFFsTSrjappGqZaRchSti/xa8sUTTKigen9TKoG4rCHcOrfBWxqUOxNeQTOU2zM=
=RWcN
-----END PGP SIGNATURE-----

--GID0FwUMdk1T2AWN--
