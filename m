Received: from eggs.gnu.org ([2001:4830:134:3::10]:47361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZ3Mi-0004P9-A8
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 18:31:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZ3Mf-00049Q-08
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 18:31:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38778)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eZ3Me-00045w-N0
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 18:31:28 -0500
References: <20171219084557.9801-1-peterx@redhat.com>
	<20171219084557.9801-10-peterx@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1b06d767-0529-12e5-8eaa-f9f56f72b111@redhat.com>
Date: Tue, 9 Jan 2018 17:31:18 -0600
MIME-Version: 1.0
In-Reply-To: <20171219084557.9801-10-peterx@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="xMJu7pHm5g66wh8MG1G7IX6M55Zdhs7sI"
Subject: Re: [Qemu-devel] [RFC v6 09/27] monitor: create monitor dedicate
 iothread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xMJu7pHm5g66wh8MG1G7IX6M55Zdhs7sI
From: Eric Blake <eblake@redhat.com>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <shajnocz@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>,
 Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com,
 Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <1b06d767-0529-12e5-8eaa-f9f56f72b111@redhat.com>
Subject: Re: [RFC v6 09/27] monitor: create monitor dedicate iothread
References: <20171219084557.9801-1-peterx@redhat.com>
 <20171219084557.9801-10-peterx@redhat.com>
In-Reply-To: <20171219084557.9801-10-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/19/2017 02:45 AM, Peter Xu wrote:

Grammar in the subject:

s/monitor dedicate/a dedicated monitor/

> Create one IOThread for the monitors, prepared to handle all the
> input/output IOs using existing iothread framework.
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  monitor.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>=20

> @@ -207,6 +208,11 @@ struct Monitor {
>      QTAILQ_ENTRY(Monitor) entry;
>  };
> =20
> +/* Let's add monitor global variables to this struct. */

Is this comment a placeholder for future additions in later patches of
the series?  If so, a temporary TODO or FIXME might make it easier to
track that this patch is part of a series; if not, you could delete the
comment altogether.

> +static struct {
> +    IOThread *mon_iothread;
> +} mon_global;
> +

Up to you what to do about the comment; tweaking it (or leaving it
unchanged) is not a semantic change, so I'm fine with:

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--xMJu7pHm5g66wh8MG1G7IX6M55Zdhs7sI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpVUMYACgkQp6FrSiUn
Q2rsngf/bxNNt6xVbaMspxy1pWSsBNxDcutwACIwkpFCVbmiUBmGQlkhSjMPI2ev
vN2pW2y4iSEUvCwCMkQmdlOu+TFLJ6AtJcb7ZaxAiBulGckfz89VuqVFRZmqhjn6
3OPa6Ffi3ol9oDIgUG0TkvAavlD4eMikrg42HcVDFNZnfl7nxp+t8gjjjFfal6vB
BX13rvFwCLyF5xf0uW3zLdk1vBstLKjCWtEc3jokrBxe4ULRqns7nyJC4gz40H+t
g7tjQ6b+z3ElKfm2GyBN6LvnHAaryenm1Tb+/b179gpeTHv6GJvMhnmxhyiIs0Nu
KCMqX37UwJ/OYRgKdgFj72Gu67aIyg==
=Gd+a
-----END PGP SIGNATURE-----

--xMJu7pHm5g66wh8MG1G7IX6M55Zdhs7sI--
