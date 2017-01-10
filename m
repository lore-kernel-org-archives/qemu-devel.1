Received: from eggs.gnu.org ([2001:4830:134:3::10]:56135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cQzYm-0005fG-MY
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 11:46:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cQzYh-0001At-2I
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 11:46:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48090)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cQzYg-0001Ak-SO
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 11:46:02 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D244C31B32C
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 16:46:02 +0000 (UTC)
Date: Tue, 10 Jan 2017 16:37:13 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170110163713.GA19869@stefanha-x1.localdomain>
References: <20170106155543.12827-1-berrange@redhat.com>
	<20170106155543.12827-3-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline
In-Reply-To: <20170106155543.12827-3-berrange@redhat.com>
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
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 06, 2017 at 03:54:58PM +0000, Daniel P. Berrange wrote:
> diff --git a/io/channel-buffer.c b/io/channel-buffer.c
> index 43d7959..b4e50d6 100644
> --- a/io/channel-buffer.c
> +++ b/io/channel-buffer.c
> @@ -22,7 +22,7 @@
>  #include "io/channel-buffer.h"
>  #include "io/channel-watch.h"
>  #include "qemu/sockets.h"
> -#include "trace.h"
> +#include "io/trace.h"

Is this change necessary?

I think the per-subdir trace.h file should be generated in
$BUILD_DIR/<sub-dir>/trace.h and gcc -I. can locate that file.

Stefan

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYdQ25AAoJEJykq7OBq3PIpIEH/j59489w9emXwPoxpStyu3Vi
WDbNBkQy0Ft2mYmGAQFD7b9k1XmoR1RMgWVmgbSH2vT82APl7RNy6jrmdbBYOe00
+gYMCA/pkbml2hy+MYROc01rzU/cxzC4A4RGCzUo9Kur2jDSwmFjKwyKG2L7Uy94
l/tvcRQ7u8ePl5MpstQLAPtKk1ypSUM4wH0SRWQ0Qff67GfNUMfAjjL8K2GJpq+S
hGC+cQ2yjt2l8RyshH4VtW+VBOCodFIu40p5U4UFjyqV4cFv42/bQImUuwbR/Yxv
Su3Fcbx8ZNOAXq/NwHFKLed+9cJmgfp8Q8EyqwOKInflQDgbLGGrP+RGmNBQ0Xc=
=tJXf
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
