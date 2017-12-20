Received: from eggs.gnu.org ([2001:4830:134:3::10]:49605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eRhSV-0004rZ-Gs
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 11:43:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eRhSS-0005vk-Mq
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 11:43:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35590)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eRhSS-0005v3-F2
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 11:43:04 -0500
Date: Wed, 20 Dec 2017 16:42:56 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171220164256.GK12566@stefanha-x1.localdomain>
References: <20171219084557.9801-1-peterx@redhat.com>
	<20171219084557.9801-8-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6TC23+W66xmFESAX"
Content-Disposition: inline
In-Reply-To: <20171219084557.9801-8-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC v6 07/27] monitor: unify global init
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


--6TC23+W66xmFESAX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2017 at 04:45:37PM +0800, Peter Xu wrote:
> There are many places for monitor init its globals, at least:
>=20
> - monitor_init_qmp_commands() at the very beginning
> - single function to init monitor_lock
> - in the first entry of monitor_init() using "is_first_init"
>=20
> Unify them a bit.
>=20
> Reviewed-by: Fam Zheng <famz@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/monitor/monitor.h |  2 +-
>  monitor.c                 | 25 ++++++++++---------------
>  vl.c                      |  7 ++++++-
>  3 files changed, 17 insertions(+), 17 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--6TC23+W66xmFESAX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaOpMQAAoJEJykq7OBq3PIeU0H/2xLlhuqxv1YSkMPGOyPcx3Z
DDRH0FDbDRbpla5c1hLz7iPINSf+kd8NW5r09kQQmKY6e1K4huy8tlnsR9DnZbNn
HqH3QrjcZnx8zvlCUsk7gWVsQpAGx/LLALjwQ3k37tz7PeaJg3Csv/6GZ+tmlub4
PC4PIFzj6GYryxpQAzNcUXmn/eweWSBmuWDhYlO1MavuDzxYu192zJ3eS9ttsjLl
uKNqCDsfdKY6x+GOnEKeY4zq8lz99PlYc8s7jC10uLIjZcyvqUlPW4na+bSGBGpx
2t0fHJX1b95MLoid1FGBKZ2c9aaEHMxsVh8Bs3yNRGKdBcxde88M3rcXHcnQ3aQ=
=aejs
-----END PGP SIGNATURE-----

--6TC23+W66xmFESAX--
