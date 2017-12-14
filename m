Received: from eggs.gnu.org ([2001:4830:134:3::10]:52367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ePTNW-0003j1-Vo
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 08:16:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ePTNT-0005iL-Lb
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 08:16:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39090)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ePTNT-0005h1-F3
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 08:16:43 -0500
Date: Thu, 14 Dec 2017 13:16:32 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171214131632.GI14433@stefanha-x1.localdomain>
References: <20171205055200.16305-1-peterx@redhat.com>
	<20171205055200.16305-21-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OfrWf2Fun5Ae4m0Y"
Content-Disposition: inline
In-Reply-To: <20171205055200.16305-21-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC v5 20/26] qmp: support out-of-band (oob)
 execution
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


--OfrWf2Fun5Ae4m0Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 05, 2017 at 01:51:54PM +0800, Peter Xu wrote:
>      if (qdict) {
>          id = qdict_get(qdict, "id");
> +        /* When OOB is enabled, the "id" field is mandatory. */
> +        if (qmp_oob_enabled(mon) && !id) {
> +            error_setg(&err, "Out-Of-Band capability requires that "
> +                       "every command contains an 'id' field.");

Is this documented in docs/interop/qmp-spec.txt?

--OfrWf2Fun5Ae4m0Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaMnmwAAoJEJykq7OBq3PI+dUIAKcqNtkveNbPrlD0pRQj5cCQ
QgKWx1xiVNgiBsiENE02dNOy2d8vXcJ9wHvcwlm63GMMS/3Xufp658RtXggi2x58
LcaDzUsC4EpbYTbRe+xj3h6CCEChQGJ5+l4HzutkNbv643Ny9E4MIysHVhA0NtYU
8Sjj0423odKx7pjbaWesx9u5xniKB8dQvWPZUQe8VRLCsNTZEacCyd4U1uMECz5F
yv32Rm1I2qisvmep5w7eQlhGbgdkKteFNoKKxyz2uWaH2O3ktzVH3o6pv8c+T7LD
4OtdWgpMd5NGBRhAUD6b92PKgHaipZzX9hOr9xW8TNQPssZJKHYfZhLKNeeTMt0=
=5IOh
-----END PGP SIGNATURE-----

--OfrWf2Fun5Ae4m0Y--
