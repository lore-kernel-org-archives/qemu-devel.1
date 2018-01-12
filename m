Received: from eggs.gnu.org ([2001:4830:134:3::10]:58627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ea0Dw-0008Ny-Dq
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 09:22:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ea0Dq-0003LM-B5
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 09:22:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45616)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ea0Dq-0003Ks-4A
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 09:22:18 -0500
Date: Fri, 12 Jan 2018 14:20:36 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180112142036.GC11423@stefanha-x1.localdomain>
References: <20171219084557.9801-1-peterx@redhat.com>
	<20171219084557.9801-21-peterx@redhat.com>
	<20180109134528.GE31400@stefanha-x1.localdomain>
	<20180112061610.GL2551@xz-mi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ncSAzJYg3Aa9+CRW"
Content-Disposition: inline
In-Reply-To: <20180112061610.GL2551@xz-mi>
Subject: Re: [Qemu-devel] [RFC v6 20/27] qmp: export qmp_dispatch_check_obj
 and allow "id"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>


--ncSAzJYg3Aa9+CRW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2018 at 02:16:10PM +0800, Peter Xu wrote:
> On Tue, Jan 09, 2018 at 01:45:28PM +0000, Stefan Hajnoczi wrote:
> > On Tue, Dec 19, 2017 at 04:45:50PM +0800, Peter Xu wrote:
> > > We need this for earlier check for OOB, before reaching
> > > do_qmp_dispatch().  Meanwhile, a small touch-up to allow "id" field,
> > > after all we allow that for sure in the spec (in any form).
> >=20
> > This change would be better as part of the patch that needs it.  I don't
> > understand the commit description and there is no context in this patch
> > showing how this change is used.
>=20
> Maybe I should mention it explicitly that "it'll be used in the
> following up patch".
>=20
> Logically I think this has nothing to do with OOB so I splitted it
> out.  I would prefer it to be a separate patch (though I can enrich
> the commit message).  Or, I'm also fine if you think squashing this
> into next would be nicer.  Thanks,

I didn't understand the patch in isolation.  Maybe rephrasing the commit
description would help.  My suggestion to squash it means there will be
more context to review this change and hopefully it will become
self-explanatory.

Stefan

--ncSAzJYg3Aa9+CRW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaWMQ0AAoJEJykq7OBq3PI9j8H/j/zmxl/o2b4sJOBPO+bI34F
fIEWUp8eT/rz5XeckXduv2gugLUUlG8rkOxKP924D364b8v49PHCm3VlZ/t5p4eu
LrNRT8GtzOCqWhim8ki0TKmjhyuHzXlSyfvS5Ky7iWwsukG/NUPVm//Sxg2IJFBZ
Nft7i0JTU0ZNTR2TgzVpWkaoOUs8ld5heSqLWnpEnGu/isqTDZi7VYPg2F6sgQ+i
N8iWkh178JoT+VsOjlRgCmQjEYEOZny5HNI+T3X2eXdumsbQD6+VbZnlSDrHFsxJ
oebuiJD0bUZGAEFaWXk0cBptp9gfMFB0JJO0d4nTLp456bj1IuBtPOPi04ypEdM=
=D/iT
-----END PGP SIGNATURE-----

--ncSAzJYg3Aa9+CRW--
