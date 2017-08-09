Received: from eggs.gnu.org ([2001:4830:134:3::10]:58536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dfN7O-0001jB-VW
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 05:17:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dfN7L-00060I-NP
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 05:17:34 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:33107)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dfN7L-000608-Gz
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 05:17:31 -0400
Received: by mail-wm0-x22c.google.com with SMTP id k20so12414101wmg.0
	for <qemu-devel@nongnu.org>; Wed, 09 Aug 2017 02:17:31 -0700 (PDT)
Date: Wed, 9 Aug 2017 10:17:28 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170809091728.GD18003@stefanha-x1.localdomain>
References: <20170808203935.30021-1-ehabkost@redhat.com>
	<20170808203935.30021-2-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="P+33d92oIH25kiaB"
Content-Disposition: inline
In-Reply-To: <20170808203935.30021-2-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.11 v2 1/5] qmp-shell: Use optparse
 module
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>


--P+33d92oIH25kiaB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 08, 2017 at 05:39:31PM -0300, Eduardo Habkost wrote:
> It makes command-line parsing and generation of help text much
> simpler.
>=20
> The optparse module is deprecated since Python 2.7, but argparse
> is not available in Python 2.6 (the minimum Python version
> required for building QEMU).
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> Changes v1 -> v2:
> * Use optparse module, as the minimum Python version for building
>   QEMU is 2.6
>   * Reported-by: Stefan Hajnoczi <stefanha@gmail.com>
>   * Suggested-by: "Daniel P. Berrange" <berrange@redhat.com>
> ---
>  scripts/qmp/qmp-shell | 63 +++++++++++++++++++--------------------------=
------
>  1 file changed, 23 insertions(+), 40 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--P+33d92oIH25kiaB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZitMoAAoJEJykq7OBq3PIb98H/2XWkPux7tIa/REXxyqOIs+X
QE8B1fwmwCv/o4q12V/ZduQ0FGyWzd2WFvr6BtSmIaILYyK6UkrqY7oBT9qU11QO
TKiz5OIb8rkcydacXkWfTAfzxStdmMiEkjlR7EAYYXFhtTyhOycGLdBuZ4bTGDAP
W5dlqsCZgOldKZlLB8btymHV0VUc9JizKZ1nY922wSrkzTB4dVS3xNHpM5FgaHS0
iQkgyq6HzCQeVJItiKIJIXMqBDQiVKd9bY1e25SFioUAxl7IdUVJJbb9DNIXqqA8
hjJqXcIz2ECD82sD9DwSY1ZlMHSHdYlgB+x3dWPF+uKnX/yfSUj9EjhUaVh6LaA=
=OLpI
-----END PGP SIGNATURE-----

--P+33d92oIH25kiaB--
