Received: from eggs.gnu.org ([2001:4830:134:3::10]:59257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dcZqf-0003uw-CV
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 12:16:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dcZqe-0006ep-De
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 12:16:45 -0400
Date: Tue, 1 Aug 2017 17:16:33 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170801161633.GF22017@stefanha-x1.localdomain>
References: <20170731095443.28211-1-el13635@mail.ntua.gr>
	<20170731095443.28211-7-el13635@mail.ntua.gr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9ADF8FXzFeE7X4jE"
Content-Disposition: inline
In-Reply-To: <20170731095443.28211-7-el13635@mail.ntua.gr>
Subject: Re: [Qemu-devel] [PATCH v3 6/7] block: add BlockDevOptionsThrottle
 to QAPI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-block <qemu-block@nongnu.org>


--9ADF8FXzFeE7X4jE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 31, 2017 at 12:54:42PM +0300, Manos Pitsidianakis wrote:
> @@ -3095,6 +3096,22 @@
>              '*tls-creds': 'str' } }
> =20
>  ##
> +# @BlockdevOptionsThrottle:
> +#
> +# Driver specific block device options for the throttle driver
> +#
> +# @throttle-group:   the name of the throttle-group object to use. It wi=
ll be
> +#                    created if it doesn't already exist
> +# @file:             reference to or definition of the data source block=
 device
> +# @limits:           ThrottleLimits options
> +# Since: 2.11
> +##
> +{ 'struct': 'BlockdevOptionsThrottle',
> +  'data': { '*throttle-group': 'str',
> +            'file' : 'BlockdevRef',
> +            '*limits' : 'ThrottleLimits'
> +             } }

What happens when throttle-group isn't given?  Please document it.

--9ADF8FXzFeE7X4jE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZgKlhAAoJEJykq7OBq3PIz9AH/3MAGoP1TYPUi/w0ZULYEV/b
ejTcVM+XJGl8plM5suhBXsTc6Dkyprouups8/xfl95oNyXiNIUzfbwDCB2qY8jXx
tiDak8XMpB8EyNi+J4UfnBAHMcbHaog2rzYFCb/gwvkd3xW9D6JveQ/Uo4ZlqU97
812GiNH/PoWPCGnIeTpKh1SLwmqAJnq9Ll2WksUluno17Sc3gVANRXEOUi2M9Uqd
3q2flniwn/fZWrL5E0nA+B1RskvNTSFeQsWLZFieBeC55IG6tnb7ZvsuD6H3WJJV
dkpgiqUC0FbSeJtxJpPWbQ7Ih9GNrcxPYSivC2qkUxIBRUsaXxyvSLIlgF7wS/M=
=GjiP
-----END PGP SIGNATURE-----

--9ADF8FXzFeE7X4jE--
