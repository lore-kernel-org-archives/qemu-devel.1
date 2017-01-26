Received: from eggs.gnu.org ([2001:4830:134:3::10]:38953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cWnWC-0004fv-Kh
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 12:07:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cWnW7-0002Vj-TM
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 12:07:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50368)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cWnW7-0002VQ-O8
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 12:07:23 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9328E7FB95
	for <qemu-devel@nongnu.org>; Thu, 26 Jan 2017 17:07:23 +0000 (UTC)
Date: Thu, 26 Jan 2017 17:07:19 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170126170719.GA27101@stefanha-x1.localdomain>
References: <20170125141426.23454-1-stefanha@redhat.com>
	<20170125142022.GD15529@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
In-Reply-To: <20170125142022.GD15529@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] trace: clean up trace-events files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 25, 2017 at 02:20:22PM +0000, Daniel P. Berrange wrote:
> On Wed, Jan 25, 2017 at 02:14:26PM +0000, Stefan Hajnoczi wrote:
> > There are a number of unused trace events that
> > scripts/cleanup-trace-events.pl finds.  The "hw/vfio/pci-quirks.c"
> > filename was typoed and "qapi/qapi-visit-core.c" was missing the qapi/
> > directory prefix.
> >=20
> > diff --git a/qapi/trace-events b/qapi/trace-events
> > index 2c5d3bc..82a0b73 100644
> > --- a/qapi/trace-events
> > +++ b/qapi/trace-events
> > @@ -1,4 +1,4 @@
> > -# qapi-visit-core.c
> > +# qapi/qapi-visit-core.c
> >  visit_free(void *v) "v=3D%p"
> >  visit_complete(void *v, void *opaque) "v=3D%p opaque=3D%p"
> > =20
> > @@ -15,7 +15,6 @@ visit_end_alternate(void *v, void *obj) "v=3D%p obj=
=3D%p"
> > =20
> >  visit_optional(void *v, const char *name, bool *present) "v=3D%p name=
=3D%s present=3D%p"
> > =20
> > -visit_type_enum(void *v, const char *name, int *obj) "v=3D%p name=3D%s=
 obj=3D%p"
>=20
> The actual bug is that the source file is mistakenly not calling this
> trace point - we shouldn't delete it - we should call it from the
> visit_type_enum() method

I'll add a patch to the v2 series to fix this.

Stefan

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYiizHAAoJEJykq7OBq3PIcPoH/3wqh0q1uRI4QjKDwKo2Umms
QDsw5KBv8Y9kLSthhXOl0DwnDKqcTr90jQvqH79ADteout8ZpYB2KX9Ve0btZnpD
89spmRTmeXjjtoDsIwRG0xQYdWcADLnS+drov2xJbm8aRpKtWt0yk1KYR04wwaDI
tPJUTdcMYzFhUzsZ7fOS1qUxYwLAx4+Kc190JI87HantDiimezDHtbsX7rboQPQ0
YEvTMyJPFbFc2XhUB7DyPhKG9U2ig6mcq16oppu47b/0R4/ws/sKNScx7RYuDBie
JwB7M/GKo5JDTh3VrOQFThGV9U9uYzQFXn/0oOKhFPdlsrAzE+xZZNp9C5oneDk=
=Rze/
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
