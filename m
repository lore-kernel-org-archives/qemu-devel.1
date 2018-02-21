Received: from eggs.gnu.org ([2001:4830:134:3::10]:50610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eoX5I-0002dT-VC
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 11:17:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eoX5E-0002Xv-1v
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 11:17:32 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59446 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eoX5D-0002Xl-SE
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 11:17:27 -0500
Date: Wed, 21 Feb 2018 16:17:18 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180221161718.GB21436@stefanha-x1.localdomain>
References: <20180124053957.29145-1-peterx@redhat.com>
	<20180124053957.29145-11-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f2QGlHpHGjS2mn6Y"
Content-Disposition: inline
In-Reply-To: <20180124053957.29145-11-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 10/23] qmp: introduce QMPCapability
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


--f2QGlHpHGjS2mn6Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 24, 2018 at 01:39:44PM +0800, Peter Xu wrote:
> diff --git a/qapi-schema.json b/qapi-schema.json
> index 5c06745c79..2490d5188e 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -102,21 +102,47 @@
>  #
>  # Enable QMP capabilities.
>  #
> -# Arguments: None.
> +# Arguments:
> +#
> +# @enable:    List of QMPCapabilities to enable, which is optional.
> +#             Client must not enable any capability that is not
> +#             mentioned in QMP greeting message.

qapi-schema.json uses full sentences so I've added missing articles to
the text.  I also changed s/QMPCapabilities/QMPCapability values/ to
avoid confusion about the type name:

  An optional list of QMPCapability values to enable.  The client must
  not enable any capability that is not mentioned in the QMP greeting
  message.

>  #
>  # Example:
>  #
> -# -> { "execute": "qmp_capabilities" }
> +# -> { "execute": "qmp_capabilities",
> +#      "arguments": { "enable": [ "oob" ] } }
>  # <- { "return": {} }
>  #
>  # Notes: This command is valid exactly when first connecting: it must be
>  # issued before any other command will be accepted, and will fail once the
>  # monitor is accepting other commands. (see qemu docs/interop/qmp-spec.txt)
>  #
> +# QMP client needs to explicitly enable QMP capabilities, otherwise

s/QMP client/The QMP client/

--f2QGlHpHGjS2mn6Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJajZuOAAoJEJykq7OBq3PIrSkIAJoBi8XVrcKlBHdgx5pc3IVo
KNNvW7XfEZRBnBOyAT91mxhwpIrbdWBfbeKNKLIeAS5WpFTrAki4r4ZejY7GBFGS
O6XE13ZEgjDPfABM5atKD/CXi7rJlic9u3IKtqINwQf3IFRgqQQ+Ypm+uwYUuBEA
WE1ZDD7CSoVY1ii/Awuh9LYk9nFcuLuIthk6bILg0WHFjeGxVydXZmbZ604Q9GO3
pu+h+yyf6qDPX5GEZWVh0xsffRaV7WHnYZCXeBggtoxWR9W055QWLNvVORJ/oqM2
oU1f9XQbKdPjaKxoQDsgv3V84IlivICs7OqfO6agpQ3SmL4oKo1BtsFDDus9MDs=
=RVK9
-----END PGP SIGNATURE-----

--f2QGlHpHGjS2mn6Y--
