Received: from eggs.gnu.org ([2001:4830:134:3::10]:54424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egtqw-0000hp-IM
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 09:59:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egtqq-0004Tn-UU
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 09:59:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37910)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1egtqq-0004TG-LD
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 09:59:04 -0500
References: <20180131144846.31697-1-armbru@redhat.com>
	<20180131144846.31697-2-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fd604c0a-bf97-edba-f648-820294447fa5@redhat.com>
Date: Wed, 31 Jan 2018 08:59:00 -0600
MIME-Version: 1.0
In-Reply-To: <20180131144846.31697-2-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="TGc485gLjN8cD9nkBUCASW1UabXikiNve"
Subject: Re: [Qemu-devel] [PATCH v2 01/19] Use #include "..." for our own
 headers, <...> for others
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu, f4bug@amsat.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TGc485gLjN8cD9nkBUCASW1UabXikiNve
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu, f4bug@amsat.org
Message-ID: <fd604c0a-bf97-edba-f648-820294447fa5@redhat.com>
Subject: Re: [PATCH v2 01/19] Use #include "..." for our own headers, <...>
 for others
References: <20180131144846.31697-1-armbru@redhat.com>
 <20180131144846.31697-2-armbru@redhat.com>
In-Reply-To: <20180131144846.31697-2-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/31/2018 08:48 AM, Markus Armbruster wrote:
> System headers should be included with <...>, our own headers with
> "...".  Offenders tracked down with an ugly, brittle and probably
> buggy Perl script.  Previous iteration was commit a9c94277f0.
>=20
> Put the cleaned up system header includes first, except for the ones
> the next commit will delete.
>=20
> While there, separate #include from file comment with a blank line,
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

> +++ b/target/i386/hvf/x86_mmu.c
> @@ -15,18 +15,17 @@
>   * You should have received a copy of the GNU Lesser General Public
>   * License along with this program; if not, see <http://www.gnu.org/li=
censes/>.
>   */
> +
>  #include "qemu/osdep.h"
> +#include <memory.h>

<memory.h> is an obsolete spelling for the now-universal <string.h>.  We
should NEVER need to include it; scripts/clean-includes should be taught
to blacklist this one.

But that's a matter for another patch; this one does exactly what it
promises, and was mechanical (even if the brittle perl script isn't
published), so it's best to keep it as-is.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--TGc485gLjN8cD9nkBUCASW1UabXikiNve
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpx2bQACgkQp6FrSiUn
Q2rHHggAqV7rNmR28tgl5tLTxYmNG/rVLAKHWfh7+1iPoF3vOFt5RI+0rc9V/pHF
RG9DoOhFZ7pFCX1nOOQnwY4vkAjKLMYM2E8Js7Sop5y+e5cLu2FAnNRhZmACrQ1D
mhwtafCd6a+ySJrEFWLILRrsD15Jfu0ps9tcjPAXaOtJi/FOhs411/9MIVXcQjPP
QxdZkhVCGj0WDdg+xrbBdhJl7qcZrNknlLkWA8xl80w/lBas8IXeg/6siqdPaIcI
TgUDfUZ4nuEblzfefOMoBOn9dh1rGfV/pMK0SPVim/IfZPCxCMRyM1+RdAtBNXdZ
/kxfRMn5RBLpxGdAuzSwTauSP4lNtg==
=GlIx
-----END PGP SIGNATURE-----

--TGc485gLjN8cD9nkBUCASW1UabXikiNve--
