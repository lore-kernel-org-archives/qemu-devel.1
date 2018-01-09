Received: from eggs.gnu.org ([2001:4830:134:3::10]:53692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZ2gE-0006kd-4V
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 17:47:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZ2g8-00019D-BX
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 17:47:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49258)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eZ2g8-00018q-1m
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 17:47:32 -0500
References: <20171219084557.9801-1-peterx@redhat.com>
	<20171219084557.9801-3-peterx@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f6dac58a-f569-4287-3f58-65bbd632aadb@redhat.com>
Date: Tue, 9 Jan 2018 16:47:14 -0600
MIME-Version: 1.0
In-Reply-To: <20171219084557.9801-3-peterx@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="dIJM950DrQAA6aZY5ur1r4WHoNzgo8T6n"
Subject: Re: [Qemu-devel] [RFC v6 02/27] qobject: introduce
 qstring_get_try_str()
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
--dIJM950DrQAA6aZY5ur1r4WHoNzgo8T6n
From: Eric Blake <eblake@redhat.com>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <shajnocz@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>,
 Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com,
 Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <f6dac58a-f569-4287-3f58-65bbd632aadb@redhat.com>
Subject: Re: [RFC v6 02/27] qobject: introduce qstring_get_try_str()
References: <20171219084557.9801-1-peterx@redhat.com>
 <20171219084557.9801-3-peterx@redhat.com>
In-Reply-To: <20171219084557.9801-3-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/19/2017 02:45 AM, Peter Xu wrote:
> The only difference from qstring_get_str() is that it allows the qstrin=
g
> to be NULL.  If so, NULL is returned.
>=20
> CC: Eric Blake <eblake@redhat.com>
> CC: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Fam Zheng <famz@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/qapi/qmp/qstring.h |  1 +
>  qobject/qstring.c          | 10 ++++++++++
>  2 files changed, 11 insertions(+)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--dIJM950DrQAA6aZY5ur1r4WHoNzgo8T6n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpVRnIACgkQp6FrSiUn
Q2rWXAgApsCAy7+JqrPgMjTN0hdOvjc6ZyAgMFGKwGlMslmSoxkgIo7rgnwxUzrR
ZppFmaxejgZTjQxM/VRMMfOCzf0aVpvcb+kQwrKiJH/KIKMP1pwjr7DWG63Mak9q
eB/RPxbQcYIPgUz+LF6v7Y+6RZiABP3eWDJejd6fpMcW86uFoy3dMaOUolyGSjKu
1wT1/kPfz91UpHhSpIVo+dz5K4vpaEBnm4GlcWH0loadXjuiZlQmG8D2tDSDVfMQ
Ms3EIkSz7M+q77xaHDDsQgOnTX+ouiKXXAGKweOQEnG2AfjORqxtJl1i3YQTnRPO
VU9wCIUDHiLQQPUWjyP7lNlFVFGYXQ==
=2esL
-----END PGP SIGNATURE-----

--dIJM950DrQAA6aZY5ur1r4WHoNzgo8T6n--
