Received: from eggs.gnu.org ([2001:4830:134:3::10]:50609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZ3Su-0006kL-FW
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 18:37:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZ3Sr-0000V3-5S
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 18:37:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52322)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eZ3Sq-0000UY-Sk
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 18:37:53 -0500
References: <20171219084557.9801-1-peterx@redhat.com>
	<20171219084557.9801-11-peterx@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a1c0a439-9458-e7aa-2beb-e21185075c26@redhat.com>
Date: Tue, 9 Jan 2018 17:37:39 -0600
MIME-Version: 1.0
In-Reply-To: <20171219084557.9801-11-peterx@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="0auVksiJZKPgC8CtsB8RyZzLN9ObwnjVR"
Subject: Re: [Qemu-devel] [RFC v6 10/27] monitor: allow to use IO thread for
 parsing
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
--0auVksiJZKPgC8CtsB8RyZzLN9ObwnjVR
From: Eric Blake <eblake@redhat.com>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <shajnocz@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>,
 Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com,
 Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <a1c0a439-9458-e7aa-2beb-e21185075c26@redhat.com>
Subject: Re: [RFC v6 10/27] monitor: allow to use IO thread for parsing
References: <20171219084557.9801-1-peterx@redhat.com>
 <20171219084557.9801-11-peterx@redhat.com>
In-Reply-To: <20171219084557.9801-11-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/19/2017 02:45 AM, Peter Xu wrote:

Grammar in the subject:

"allow to $VERB" is not idiomatic English; correct is either "allow
${VERB}ing" or "allow $SUBJECT to $VERB".  Concretely, s/to use/using/

> For each Monitor, add one field "use_io_thr" to show whether it will be=

> using the dedicated monitor IO thread to handle input/output.  When set=
,
> monitor IO parsing work will be offloaded to dedicated monitor IO

s/to/to the/

> thread, rather than the original main loop thread.
>=20
> This only works for QMP.  HMP will always be run on main loop thread.

s/on/on the/

>=20
> Currently we're still keeping use_io_thr to off always.  Will turn it o=
n

s/to off/off/

> later at some point.
>=20
> One thing to mention is that we cannot set use_io_thr for every QMP
> monitors.  The problem is that MUXed typed chardevs may not work well

s/monitors/monitor/

> with it now. When MUX is used, frontend of chardev can be the monitor
> plus something else.  The only thing we know would be safe to be run
> outside main thread so far is the monitor frontend. All the rest of the=

> frontends should still be run in main thread only.
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  monitor.c | 41 ++++++++++++++++++++++++++++++++---------
>  1 file changed, 32 insertions(+), 9 deletions(-)
>=20
I have nothing to add on the code review, but it looks like Stefan had
valid comments that need addressing.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--0auVksiJZKPgC8CtsB8RyZzLN9ObwnjVR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpVUkMACgkQp6FrSiUn
Q2o1yQgAjVrruqHSKZRIWMUXL6k18DrDiHbn9FBnEVBTCK3GtNSXVxKfZtQMI2wZ
PWKaS1UK9Mk/zTOBmDuYTRNVbJY2a92CXSsiNHthXjKTp7XWmyCyGNY5yr0iJeIf
HCh4HPLNC2oImBswrxh239FNdC1rCjeQDfyfDRtbQEdjmPey4JLXBVvZkw1VAuOw
LSr+KUEZF5WIiFPC2BMoTSumH9kRJK+O+ZPooMSLgvGeQ6Efb/QvqUbAI5UKTDsi
UIHD+L0oJ/YCbaKGoxHO61LgXlBl/7Gs3dFJ0/VMJZ2UpTSPIvXCB/d1MMyWwEMU
kgpJwDeL9QCtQezGxO5HKcgxrzZnzw==
=H8og
-----END PGP SIGNATURE-----

--0auVksiJZKPgC8CtsB8RyZzLN9ObwnjVR--
