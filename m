Received: from eggs.gnu.org ([2001:4830:134:3::10]:48972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cdeBo-0002JN-88
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 09:34:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cdeBk-0003AA-CW
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 09:34:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60162)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cdeBk-00039M-77
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 09:34:40 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 481007FB60
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 14:34:40 +0000 (UTC)
Date: Tue, 14 Feb 2017 14:34:37 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170214143437.GL23310@stefanha-x1.localdomain>
References: <20170213135235.12274-1-pbonzini@redhat.com>
	<20170213135235.12274-2-pbonzini@redhat.com>
	<20170214074831.GE6428@lemon.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f54savKjS/tSNRaU"
Content-Disposition: inline
In-Reply-To: <20170214074831.GE6428@lemon.lan>
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
To: Fam Zheng <famz@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org


--f54savKjS/tSNRaU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 14, 2017 at 03:48:31PM +0800, Fam Zheng wrote:
> On Mon, 02/13 14:52, Paolo Bonzini wrote:
> > --- /dev/null
> > +++ b/util/aiocb.c
> > @@ -0,0 +1,55 @@
> > +/*
> > + * BlockAIOCB allocation
> > + *
> > + * Copyright (c) 2003-2017 Fabrice Bellard and the QEMU team
>=20
> Hmm, I'm not lawyer, just wondering if the QEMU team is a legal entity th=
at can
> hold copyright? :)

That is taken from ./LICENSE.  I'm not sure what it means either.
Probably "use git log to find all the people who modified the code you
are distributing".

Stefan

--f54savKjS/tSNRaU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYoxV9AAoJEJykq7OBq3PI84cH/0c7xmNqiY8Kjl3pOS8X5cIF
h+KIHHoSw9VprPMfKE+VFs7gyQAR046BMxha+TGni2HwOhF8y7YRiyFPISZwgob5
YidI48sr89XVN3ctki8HZAjrcA3iRhP4PtgM04VDzM+dI6/jmHaieENWtillA9rS
m4KzpzU+R8hv1NFLCGxNtZCe0ZPpke+ABnEd7baHbncFeor+++cipAER/JgetQ8H
4TfpzEq0/CEoK5D5dnS/Nyhi8GbdDvOCBVhZ5BIZUoslWs/kFWxmqltZsqIFe4Vy
UGc2/pp3wcTI3yq2mu51cfrBzghUFXDW5efESlJvCi0KzkbCrWdawpuH4EJpOZY=
=7kuT
-----END PGP SIGNATURE-----

--f54savKjS/tSNRaU--
