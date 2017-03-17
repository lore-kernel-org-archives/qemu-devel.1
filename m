Received: from eggs.gnu.org ([2001:4830:134:3::10]:50257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cooSI-0008VE-HR
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 05:45:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cooSD-0002wt-Fx
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 05:45:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40586)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cooSD-0002vo-9F
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 05:45:49 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1C637804FF
	for <qemu-devel@nongnu.org>; Fri, 17 Mar 2017 09:45:49 +0000 (UTC)
Date: Fri, 17 Mar 2017 17:45:44 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170317094544.GC11116@stefanha-x1.localdomain>
References: <20170313051108.26811-1-stefanha@redhat.com>
	<7062cd7c-6271-7a77-e306-13075dcd1c2e@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PuGuTyElPB9bOcsM"
Content-Disposition: inline
In-Reply-To: <7062cd7c-6271-7a77-e306-13075dcd1c2e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-img: show help for invalid global
 options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>


--PuGuTyElPB9bOcsM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 16, 2017 at 03:07:29AM +0100, Max Reitz wrote:
> On 13.03.2017 06:11, Stefan Hajnoczi wrote:
> > The qemu-img sub-command executes regardless of invalid global options:
> >=20
> >   $ qemu-img --foo info test.img
> >   qemu-img: unrecognized option '--foo'
> >   image: test.img
> >   ...
> >=20
> > The unrecognized option warning may be missed by the user.  This can
> > hide incorrect command-lines in scripts and confuse users.
> >=20
> > This patch prints the help information and terminates instead of
> > executing the sub-command.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  qemu-img.c | 1 +
> >  1 file changed, 1 insertion(+)
>=20
> Well, now you get blown away by a wall of text and spotting what went
> wrong is actually not quite simple. Maybe we should follow the way of
> the coreutils, that is:
>=20
> qemu-img: unrecognized option '--foo'
> Try 'qemu-img --help' for more information.
>=20
> ?

Sure, I'll add another patch to improve that.

Stefan

--PuGuTyElPB9bOcsM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYy7BIAAoJEJykq7OBq3PIQVcIALfcJINu2uoQMXCPCY6eqQxY
PzW/RpNIjzl2cFLOU7p/xh2sb4zR5kphuFZyGuEurXsTFhTjiZT7IsCIOIN/OnLv
qwGlvwE9QzteA0XocbjtZoGYsb0jDsTl6XDUlpeNv1sSYbR+VX3WqR1iU96ZyEn7
h09pRfjKDXYKK3AqfezU/qXXPEaO9S7V3AwfdbJqwW4vas9yQie/ppW0bbIpPS6t
fA9gxnoQP1g17abPO/1jPi9dBiywXQWbx+/aD4qkhCy5BUItvE5HPQPATn0A5sQW
D1RdEsoUoYiOtNp2Rh+yAq5Z9WtCghUFGa1z662psru2fOrSCdsQdUfUPbRCfzc=
=HaR7
-----END PGP SIGNATURE-----

--PuGuTyElPB9bOcsM--
