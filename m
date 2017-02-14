Received: from eggs.gnu.org ([2001:4830:134:3::10]:57309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cdeSZ-0001mE-4p
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 09:52:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cdeSW-0003F4-0y
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 09:52:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40974)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cdeSV-0003Ef-RI
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 09:51:59 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BD806804E5
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 14:51:59 +0000 (UTC)
Date: Tue, 14 Feb 2017 14:51:56 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170214145156.GM23310@stefanha-x1.localdomain>
References: <20170213135235.12274-1-pbonzini@redhat.com>
	<20170213135235.12274-2-pbonzini@redhat.com>
	<20170214074831.GE6428@lemon.lan> <20170214122607.GD467@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="um2V5WpqCyd73IVb"
Content-Disposition: inline
In-Reply-To: <20170214122607.GD467@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 01/18] block: move AioContext, QEMUTimer,
 main-loop to libqemuutil
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org


--um2V5WpqCyd73IVb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 14, 2017 at 12:26:07PM +0000, Daniel P. Berrange wrote:
> On Tue, Feb 14, 2017 at 03:48:31PM +0800, Fam Zheng wrote:
> > On Mon, 02/13 14:52, Paolo Bonzini wrote:
> > > --- /dev/null
> > > +++ b/util/aiocb.c
> > > @@ -0,0 +1,55 @@
> > > +/*
> > > + * BlockAIOCB allocation
> > > + *
> > > + * Copyright (c) 2003-2017 Fabrice Bellard and the QEMU team
> >=20
> > Hmm, I'm not lawyer, just wondering if the QEMU team is a legal entity =
that can
> > hold copyright? :)
>=20
> Reword it to say
>=20
>   "Copyright (c) 2003-2017 Fabrice Bellard and other QEMU contributors"
>=20
> so it is referring to individual contributors as distinct copyright
> holders, as opposed to a single entity called "QEMU team"

Paolo: Please confirm and I'll merge your series with this tweak.

Stefan

--um2V5WpqCyd73IVb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYoxmMAAoJEJykq7OBq3PI9CMH+gLz21lJvCXt9pq/WkkIrpEZ
8iK7nnbQf1HKVhVhxqwRuGxtX7wovFnrAM0gzpk/vXY4jpAiFIJWoDU+I9Cv7ulU
TBJ52Sc3evGVKxftLkD8v6/aMTEID3X6ndH6qyt4d1oF6blqTjMIMM6CvvIG/Oln
O7DDsK6zS0ECwVOK1TJbJnv/cPePhUs+RNj80pJRuyg4/svZnhSvDISTY7JpY/xx
R2WCyr9sqA3yKJOUe8mAqwJSmr0jIiuwgjHIqAe8uG0U0vnsh54hSfgHuUQfSExz
Gq8E/NmAxkT7XsB2xEXHJotE7/70UcO3awv7Hu/VMqxZISJx4awo0aQPsLImIZ8=
=CqW7
-----END PGP SIGNATURE-----

--um2V5WpqCyd73IVb--
