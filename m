Received: from eggs.gnu.org ([2001:4830:134:3::10]:52121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dAdiu-0005hC-ND
	for qemu-devel@nongnu.org; Tue, 16 May 2017 10:45:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dAdiq-000127-Rs
	for qemu-devel@nongnu.org; Tue, 16 May 2017 10:45:16 -0400
Date: Tue, 16 May 2017 15:44:54 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170516144454.GH8498@stefanha-x1.localdomain>
References: <20170511144208.24075-1-pbonzini@redhat.com>
	<20170511144208.24075-9-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CEUtFxTsmBsHRLs3"
Content-Disposition: inline
In-Reply-To: <20170511144208.24075-9-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 08/18] throttle-groups: do not use
 qemu_co_enter_next
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, qemu-block@nongnu.org


--CEUtFxTsmBsHRLs3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 11, 2017 at 04:41:58PM +0200, Paolo Bonzini wrote:
> Prepare for removing this function; always restart throttled requests
> from coroutine context.  This will matter when restarting throttled
> requests will have to acquire a CoMutex.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>         v1->v2: heavily simplified thanks to previous patch [Stefan]
>                 add coroutine_fn as needed [Stefan]
>=20
>  block/throttle-groups.c | 42 +++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 37 insertions(+), 5 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--CEUtFxTsmBsHRLs3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZGxBmAAoJEJykq7OBq3PIbqwH/0JuvAGx9urTzeeMlhhyCYCD
Io1VHCH1yEpSTVnVSNBFsoGMu9j2EzyHuzS+5qQAAbjXusLWGF7UbHv9wx+rz1v6
IGKkrisObGEHRwYou0MFDsLWM0xuHDqMbAwdi7yovWdpP+q7aCwtgCTnrP3DKWAW
R0xLt+dila5JnkN1MJy8nsMxtj5sBsXyDhYy30RXPemGsylPUJh34m7xkVioXdpl
vsU98FCPBHEVkRJ5hrEmPd6x+WcTYkmlg/TDTl8KSqWlmp5EKYCdei7rC5wjQpNK
bIpb+95FMXlotM6QLd24Nht8jBwEbAXmpirXPXbwBEULY7mARBgeZhdZLUsl6zY=
=wTiR
-----END PGP SIGNATURE-----

--CEUtFxTsmBsHRLs3--
