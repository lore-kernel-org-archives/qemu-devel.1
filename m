Received: from eggs.gnu.org ([2001:4830:134:3::10]:45670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eRhQ2-0002zH-EE
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 11:40:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eRhPz-0003Iq-Hh
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 11:40:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33442)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eRhPz-0003HX-80
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 11:40:31 -0500
Date: Wed, 20 Dec 2017 16:40:22 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171220164022.GI12566@stefanha-x1.localdomain>
References: <20171219084557.9801-1-peterx@redhat.com>
	<20171219084557.9801-2-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wjoFZxbW4tu+iR6v"
Content-Disposition: inline
In-Reply-To: <20171219084557.9801-2-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC v6 01/27] chardev: use backend chr context
 when watch for fe
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


--wjoFZxbW4tu+iR6v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2017 at 04:45:31PM +0800, Peter Xu wrote:
> In commit 6bbb6c0644 ("chardev: use per-dev context for
> io_add_watch_poll", 2017-09-22) all the chardev watches are converted to
> use per-chardev gcontext to support chardev to be run outside default
> main thread.  However that's still missing one call from the frontend
> code.  Touch that up.
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  chardev/char-fe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Either way, I'm happy with this patch:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--wjoFZxbW4tu+iR6v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaOpJ2AAoJEJykq7OBq3PIyZ0H+wTnd72kkpf8tS+e56MqHQtB
tk4X18P8Sx8khCDsjcm6x87weWjWAM/BR3zUxXN/pgM/ee1OaZSL3p/HCmr/gpyH
5tPudw4Y/uIraA3nBIW+zBmJXqJrtVimA04INFcEZ1sDGH/DExR2ZTfX8PSQrEu4
LTorsnXk82+7259iDLtGqKJjZNrGgV+VDlFGkTYHxWMw7pA9w0XI5XAOYKe9C9vf
D7rn2Fww7BOMvkjmcFenaxFicpCMU+swZsh/g9kiFa28z//j+gns2YJjMFAIeUPC
WGAnIS7xEz0OocpKa/JI8Hf0xaxu1npr3S7UUU6ZWbPqRkPnHw9FaUClH3VsVgE=
=h8il
-----END PGP SIGNATURE-----

--wjoFZxbW4tu+iR6v--
