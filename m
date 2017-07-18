Received: from eggs.gnu.org ([2001:4830:134:3::10]:41779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXTsV-0000Xi-WC
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:53:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXTsV-0007W6-4V
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:53:36 -0400
References: <1500385286-21142-1-git-send-email-armbru@redhat.com>
	<1500385286-21142-4-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e6f2611e-ff9f-450c-a438-e740c2b57ece@redhat.com>
Date: Tue, 18 Jul 2017 09:53:25 -0500
MIME-Version: 1.0
In-Reply-To: <1500385286-21142-4-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="12KxEQUJ4gMbQQ3sPprxdTjjjqbbEiwMF"
Subject: Re: [Qemu-devel] [PATCH for-2.10 03/10] qapi: Introduce a first
 class 'null' type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, quintela@redhat.com, dgilbert@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--12KxEQUJ4gMbQQ3sPprxdTjjjqbbEiwMF
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, kwolf@redhat.com, mreitz@redhat.com,
 qemu-block@nongnu.org, quintela@redhat.com, dgilbert@redhat.com
Message-ID: <e6f2611e-ff9f-450c-a438-e740c2b57ece@redhat.com>
Subject: Re: [PATCH for-2.10 03/10] qapi: Introduce a first class 'null' type
References: <1500385286-21142-1-git-send-email-armbru@redhat.com>
 <1500385286-21142-4-git-send-email-armbru@redhat.com>
In-Reply-To: <1500385286-21142-4-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/18/2017 08:41 AM, Markus Armbruster wrote:
> I expect the 'null' type to be useful mostly for members of alternate
> types.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

> +++ b/include/qapi/qmp/qobject.h
> @@ -93,9 +93,9 @@ static inline QType qobject_type(const QObject *obj)
>      return obj->type;
>  }
> =20
> -typedef struct QNull {
> +struct QNull {

This line was just added...

>      QObject base;
> -} QNull;
> +};
> =20
>  extern QNull qnull_;
> =20
> diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
> index 2706aab..ba69bd8 100644
> --- a/include/qemu/typedefs.h
> +++ b/include/qemu/typedefs.h
> @@ -87,6 +87,7 @@ typedef struct QEMUSGList QEMUSGList;
>  typedef struct QEMUTimer QEMUTimer;
>  typedef struct QEMUTimerListGroup QEMUTimerListGroup;
>  typedef struct QObject QObject;
> +typedef struct QNull QNull;

=2E..is it worth hoisting this typedef into 2/10 for less churn?

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--12KxEQUJ4gMbQQ3sPprxdTjjjqbbEiwMF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlluIOUACgkQp6FrSiUn
Q2oqPQf/dmN7Zh9f9Nv3vpIsUMA5gLFYWe2q1LDrsi+73Iv9maM08h5g07WfKaa8
OrYXxwam19vGLhGL7ff/yjGQc3so6EwOw2l50QGefB60IGaZmQolPMJ5DiJG09T+
e0T+XnYpHAAgr4MHm/fhZM9n/XfLyAKUVnxOSFy3gex/P4yEyKL0s0V0nC5ghwBv
fT349/vtA7Gg48M+WucGl6hGPHY/COv/Z0GgE8qjBCVuDhQu8PQDY+yJpRQBbglr
NRr4MwTAZgju1Yb+S2i7+BQQ8LItVZgqZuFgEvWDZH3y7UShmVsZshz5VPd2zBWK
Yp6QLJ4EC1YzXb+hPBy5DGWz2Hj5HA==
=n78f
-----END PGP SIGNATURE-----

--12KxEQUJ4gMbQQ3sPprxdTjjjqbbEiwMF--
