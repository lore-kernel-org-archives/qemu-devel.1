Received: from eggs.gnu.org ([2001:4830:134:3::10]:52229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cZfM8-0007Gu-U3
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:00:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cZfM5-0004D7-07
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:00:57 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:36057)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cZfM4-0004Cv-PX
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:00:52 -0500
Received: by mail-wm0-x244.google.com with SMTP id r18so4891831wmd.3
	for <qemu-devel@nongnu.org>; Fri, 03 Feb 2017 07:00:52 -0800 (PST)
Date: Fri, 3 Feb 2017 15:00:50 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170203150050.GF642@stefanha-x1.localdomain>
References: <20170202150530.1025-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WlEyl6ow+jlIgNUh"
Content-Disposition: inline
In-Reply-To: <20170202150530.1025-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH] configure: remove
 --enable-replication/--disable-replication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com


--WlEyl6ow+jlIgNUh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 02, 2017 at 07:05:30AM -0800, Paolo Bonzini wrote:
> The replication feature is a small amount of code, does not
> require any external library and unless used does not add
> anything to the guest's attack surface.  Since any extra
> configure option affects maintainability on the other hand
> and is subject to bit rot, I think there is no need to
> make it configurable.

I think the current state is good: replication is enabled by default but
can be compiled out if desired.

Downstreams may not be comfortable supporting this feature yet since
it's incomplete.  It's fair to offer an option to disable it, otherwise
downstreams will have to patch this themselves.

Stefan

--WlEyl6ow+jlIgNUh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYlJsiAAoJEJykq7OBq3PIJKQH/2nTjtgc5iJ2gs3h/vREB+p1
mnu87dCnVKICF8rxvJrtbIwcaOLJtg8FejiVNfWMCK0vmq40t5B7ZIrbvl2+SCwD
XWycsvkWbaetTNIaXjZ9a0TddT9wsHsf4rNbTVDo6pEuMSHROuod/xpNeJsZWxUm
nP/cza46IXYmlnXk+y6YJ/m5uCqzrFcTiRlh+2/H+MWQsKrU2xN4Bnaw4nOdgiCJ
fZ4QaZwapwsLHw3u0dgswxAqSZo4tuYrV8LIijiJB3HZUTorE6XsyxBVb4z6JPbt
pWLWp+1QBNf0KiedKPsUtBTV20oVLntgJj7shVOuw/YfmjiRl4h4ytbK58w9lNM=
=vQWw
-----END PGP SIGNATURE-----

--WlEyl6ow+jlIgNUh--
