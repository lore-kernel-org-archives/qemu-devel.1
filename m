Received: from eggs.gnu.org ([2001:4830:134:3::10]:41666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ega41-0000tP-RV
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 12:51:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ega3x-0000lN-P3
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 12:51:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47442)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ega3x-0000kR-EZ
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 12:51:17 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 91245883D2
	for <qemu-devel@nongnu.org>; Tue, 30 Jan 2018 17:51:16 +0000 (UTC)
References: <20180130102202.28519-1-armbru@redhat.com>
	<20180130102202.28519-12-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9ad15af5-babb-d4ee-6601-42c1a390d82e@redhat.com>
Date: Tue, 30 Jan 2018 11:51:14 -0600
MIME-Version: 1.0
In-Reply-To: <20180130102202.28519-12-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KmROkRyYAscD0XPgr2zKaOvyNt7OqfFkW"
Subject: Re: [Qemu-devel] [PATCH 11/18] Include qapi/qmp/qdict.h exactly
 where needed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KmROkRyYAscD0XPgr2zKaOvyNt7OqfFkW
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <9ad15af5-babb-d4ee-6601-42c1a390d82e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 11/18] Include qapi/qmp/qdict.h exactly where
 needed
References: <20180130102202.28519-1-armbru@redhat.com>
 <20180130102202.28519-12-armbru@redhat.com>
In-Reply-To: <20180130102202.28519-12-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/30/2018 04:21 AM, Markus Armbruster wrote:
> This cleanup makes the number of objects depending on qapi/qmp/qdict.h
> drop from 4547 (out of 4739) to 368 in my "build everything" tree.
> For qapi/qmp/qobject.h, the number drops from 4549 to 390.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

> +++ b/block/qcow.c
> @@ -21,6 +21,7 @@
>   * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALI=
NGS IN
>   * THE SOFTWARE.
>   */
> +
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "qemu-common.h"
> @@ -30,6 +31,7 @@
>  #include "qemu/module.h"
>  #include "qemu/bswap.h"
>  #include <zlib.h>
> +#include "qapi/qmp/qdict.h"

Same comments as on other patches in the series.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--KmROkRyYAscD0XPgr2zKaOvyNt7OqfFkW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpwsJIACgkQp6FrSiUn
Q2qwzwf/Q6PNXfBBpE0vUxvzgAknpHq5sANNcBNB41OFPpvV6lu/e3XZwe86GAkF
ez113YL4WGw21OsxUtHBFJm4/29mRUfxk4FAdhEYJ6d5ejVgykKmQ/fS9UTjKixs
lqS9GRSeQk73kiEZiWlgJg12jWahxIVIkCq94gIxlEXVu/C45xLF3w62gewVzWd0
7oAA5sKUfQCNgiMbVXgaMFJs62eYPXiZ90jmYfDR1sj2V3Zen6b9q2z1QxUMgeNf
iWcgX0DbKiNhPUpeEkoBiTWbqJG6r5ZknwoHe5FSwvC3dSHFWSewk7QaN3763WaR
bk8XGVGUamDqxDBDiiyEYgQ/45BSCw==
=zLkm
-----END PGP SIGNATURE-----

--KmROkRyYAscD0XPgr2zKaOvyNt7OqfFkW--
