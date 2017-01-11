Received: from eggs.gnu.org ([2001:4830:134:3::10]:33124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cRMRa-0001jz-9m
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 12:12:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cRMRW-0007GU-7W
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 12:12:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33818)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cRMRW-0007GA-1Q
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 12:12:10 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3D55E3F158
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 17:12:10 +0000 (UTC)
Date: Wed, 11 Jan 2017 17:12:02 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170111171202.GG9269@stefanha-x1.localdomain>
References: <20170106155543.12827-1-berrange@redhat.com>
	<20170106155543.12827-3-berrange@redhat.com>
	<20170110163713.GA19869@stefanha-x1.localdomain>
	<eabc1ecd-439c-69cc-facb-281699a4d26e@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="V32M1hWVjliPHW+c"
Content-Disposition: inline
In-Reply-To: <eabc1ecd-439c-69cc-facb-281699a4d26e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 02/47] trace: switch io/ directory to
 modular trace.h file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org


--V32M1hWVjliPHW+c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 10, 2017 at 10:51:29AM -0600, Eric Blake wrote:
> On 01/10/2017 10:37 AM, Stefan Hajnoczi wrote:
> > On Fri, Jan 06, 2017 at 03:54:58PM +0000, Daniel P. Berrange wrote:
> >> diff --git a/io/channel-buffer.c b/io/channel-buffer.c
> >> index 43d7959..b4e50d6 100644
> >> --- a/io/channel-buffer.c
> >> +++ b/io/channel-buffer.c
> >> @@ -22,7 +22,7 @@
> >>  #include "io/channel-buffer.h"
> >>  #include "io/channel-watch.h"
> >>  #include "qemu/sockets.h"
> >> -#include "trace.h"
> >> +#include "io/trace.h"
> >=20
> > Is this change necessary?
>=20
> Yes - now that there are more than one trace.h files spread across
> multiple directories, you need a prefix to ensure the correct one gets
> included.  In this particular case, it also matches consistency in
> including "io/channel-buffer.h" rather than just "channel-buffer.h".

"io/channel-buffer.h" is no more consistent or clear than
"channel-buffer.h".

Does it mean include/io/channel-buffer.h or
=2E/include/io/channel-buffer.h?  You don't know unless you know the
compiler include paths and which directories have a channel-buffer.h
file.

IMO a simple "foo.h" is clearest for ./foo.h.

Stefan

--V32M1hWVjliPHW+c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYdmdiAAoJEJykq7OBq3PITZ8H/2lCxxOQ3AINYJM0+kEMwsE/
QJIsO7iNxJV7h4Tf176+2qEOeQnS73YtT3IxY1QCtny4tByfsoKt2HCqqLo5PlwQ
auxTLkY31uXG1puvDxB6iEwHWVs8j23CJZ/UrFg9yos248TuIxvf9VLlhLhcyjGL
ghs40taqaLB0VZzckwE/WmzDA3+zw404sPrMYUaFe1U9RfPoGIEXa0lceRvG/ot7
+LGIF5ALOt9A34iJzsF4Zrs4FE3lOHNj+mAr3U5bM0yDNC7Dt95KmjwfbmyNjVxe
byhJSVWUnvO/lrb4/OakKD+91A4J/bm0Cw2PQEXUsNsOsvbiukmZVV24dyKTgh8=
=CD1T
-----END PGP SIGNATURE-----

--V32M1hWVjliPHW+c--
