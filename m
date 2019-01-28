Received: from eggs.gnu.org ([209.51.188.92]:60949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1goAvL-0004Kk-Dw
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:42:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1goAvJ-0005tQ-Tk
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:42:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45508)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1goAvJ-0005fw-GB
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:42:17 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 431B919CF53
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 17:42:12 +0000 (UTC)
References: <20190128170321.16936-1-dgilbert@redhat.com>
	<20190128170321.16936-2-dgilbert@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5e2fce30-a0da-33d2-ed34-a963e4464b1a@redhat.com>
Date: Mon, 28 Jan 2019 11:42:07 -0600
MIME-Version: 1.0
In-Reply-To: <20190128170321.16936-2-dgilbert@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="iJ4TPtg0fwagZLYXZyUteR4S4vCaroaje"
Subject: Re: [Qemu-devel] [PATCH 1/9] net: Introduce announce timer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, quintela@redhat.com, jasowang@redhat.com, mst@redhat.com, armbru@redhat.com, berrange@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iJ4TPtg0fwagZLYXZyUteR4S4vCaroaje
From: Eric Blake <eblake@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, quintela@redhat.com, jasowang@redhat.com,
 mst@redhat.com, armbru@redhat.com, berrange@redhat.com
Message-ID: <5e2fce30-a0da-33d2-ed34-a963e4464b1a@redhat.com>
Subject: Re: [PATCH 1/9] net: Introduce announce timer
References: <20190128170321.16936-1-dgilbert@redhat.com>
 <20190128170321.16936-2-dgilbert@redhat.com>
In-Reply-To: <20190128170321.16936-2-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/28/19 11:03 AM, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> The 'announce timer' will be used by migration, and explicit
> requests for qemu to perform network announces.
>=20
> Based on the work by Germano Veit Michel <germano@redhat.com>
>  and Vlad Yasevich <vyasevic@redhat.com>
>=20
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---

> +++ b/qapi/net.json
> @@ -684,3 +684,26 @@
>  ##
>  { 'event': 'NIC_RX_FILTER_CHANGED',
>    'data': { '*name': 'str', 'path': 'str' } }
> +
> +##
> +# @AnnounceParameters:
> +#
> +# Parameters for self-announce timers
> +#
> +# @initial: Initial delay (in ms) before sending the first GARP/RARP
> +#       announcement
> +#
> +# @max: Maximum delay (in ms) to between GARP/RARP announcement packet=
s

"to between" should be either "to use in between" or merely "between"

> +#
> +# @rounds: Number of self-announcement attempts
> +#
> +# @step: Delay increase (in ms) after each self-announcement attempt
> +#
> +# Since: 4.0
> +##
> +
> +{ 'struct': 'AnnounceParameters',
> +  'data': { 'initial': 'int',
> +            'max': 'int',
> +            'rounds': 'int',
> +            'step': 'int' } }
>=20

Can/should any of the parameters be optional with a sane (documented)
default?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--iJ4TPtg0fwagZLYXZyUteR4S4vCaroaje
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxPPu8ACgkQp6FrSiUn
Q2oDyAf/ZDhZZjq3Szx4sXKjfSbxXWiXUpwpWAij5AcvyVIsxwultVvbPhOGZHWB
2Et8edh10Ow5XmWv4Uk50V7J6FYFmDOK5jV3JOLzJaRM9Qucp7YmCTwSrvzFh8o8
2t/ocDTN1HH4lM3Idhy8XtXXG0pCvJYsSg9f8Gx02Iy/rlquGT4zMrHYxcX1U1DP
+CdT354uIzhjGt0r6hMviW1Phd8Ek1jb+ZMlv1OjRkKhoSZJ/AXAulNW8NCzQGUQ
zaWWmCU04l7GOrivN2OHT4vfwdZ8N6EtZVIkp5EYIPDj8iTbRMLa44kGXlfEtV+a
5yWaSA9oCNn7HUjhBWc6PUeex5Cp4w==
=ETWF
-----END PGP SIGNATURE-----

--iJ4TPtg0fwagZLYXZyUteR4S4vCaroaje--
