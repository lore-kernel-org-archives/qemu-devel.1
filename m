Received: from eggs.gnu.org ([2001:4830:134:3::10]:40449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ePToT-0005Vu-Da
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 08:44:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ePToO-0004bA-HZ
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 08:44:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38624)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ePToO-0004aX-Ah
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 08:44:32 -0500
Date: Thu, 14 Dec 2017 13:44:22 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171214134422.GK14433@stefanha-x1.localdomain>
References: <20171205055200.16305-1-peterx@redhat.com>
	<20171205055200.16305-23-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YQEH9CATo+4lan7A"
Content-Disposition: inline
In-Reply-To: <20171205055200.16305-23-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC v5 22/26] monitor: enable IO thread for (qmp
 & !mux) typed
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


--YQEH9CATo+4lan7A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2017 at 01:51:56PM +0800, Peter Xu wrote:
> Start to use dedicate IO thread for QMP monitors that are not using
> MUXed chardev.
>=20
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  monitor.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--YQEH9CATo+4lan7A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaMoA2AAoJEJykq7OBq3PIVncH/2WEXS6hO5jX6oGmdalK51oF
YsEDtxwmUXZulUwZMqfjRQv/Z+s7qiopIL/Rn171aBGmJrbxsvbQsp+QJlnf/Wop
EJtlDY+6N1QT+Q9OuZ0d/GDnWK8R+Sw4PrUUY8qHhSa5dm1bPEKRrAtcF0DOrelW
La9+3xw9uMTUNsLrAG/JgAUziA0B6G/EooukUyH02iqEscOM/K+dc6ewi4Jx/Gjt
/BRj/5dYjLwTSOzFqiPFwQp3UOY4CQMd0S9OtDpKLdK0u8nowSdNQ7Kk43qs0BEd
JHpg7F3kdfBVGn2LLq8og3IikjjA3AuTLNcedq8s9Libk3lPEtTQk4IG+xeaW/I=
=cnpp
-----END PGP SIGNATURE-----

--YQEH9CATo+4lan7A--
