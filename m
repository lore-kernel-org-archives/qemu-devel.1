Received: from eggs.gnu.org ([2001:4830:134:3::10]:36719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eXZn4-0008OI-GX
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 16:44:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eXZn1-0004cA-Aa
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 16:44:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57284)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eXZn0-0004aU-Tm
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 16:44:35 -0500
References: <1514940265-18093-1-git-send-email-mjc@sifive.com>
	<1514940265-18093-13-git-send-email-mjc@sifive.com>
	<20180106004105.281b992abcf939b0cf45b88f@gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b829219c-23e2-d3b6-3381-ecfa97d1d9b2@redhat.com>
Date: Fri, 5 Jan 2018 15:44:31 -0600
MIME-Version: 1.0
In-Reply-To: <20180106004105.281b992abcf939b0cf45b88f@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="TsUopMqxCAw3WuZiB7KLsmU31qMEeqLvY"
Subject: Re: [Qemu-devel] [PATCH v1 12/21] RISC-V HART Array
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Antony Pavlov <antonynpavlov@gmail.com>, Michael Clark <mjc@sifive.com>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org, Sagar Karandikar <sagark@eecs.berkeley.edu>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TsUopMqxCAw3WuZiB7KLsmU31qMEeqLvY
From: Eric Blake <eblake@redhat.com>
To: Antony Pavlov <antonynpavlov@gmail.com>, Michael Clark <mjc@sifive.com>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 qemu-devel@nongnu.org, Sagar Karandikar <sagark@eecs.berkeley.edu>
Message-ID: <b829219c-23e2-d3b6-3381-ecfa97d1d9b2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 12/21] RISC-V HART Array
References: <1514940265-18093-1-git-send-email-mjc@sifive.com>
 <1514940265-18093-13-git-send-email-mjc@sifive.com>
 <20180106004105.281b992abcf939b0cf45b88f@gmail.com>
In-Reply-To: <20180106004105.281b992abcf939b0cf45b88f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/05/2018 03:41 PM, Antony Pavlov wrote:
> On Wed,  3 Jan 2018 13:44:16 +1300
> Michael Clark <mjc@sifive.com> wrote:
>=20
>> Holds the state of a heterogenous array of RISC-V hardware threads.
>=20

>=20
> Hmm, you use SysBusDevice, uint32_t and RISCVCPU types but there is no =
header files
> inclusion to define these types.
>=20
> I propose this fixup:
>=20
> --- a/include/hw/riscv/riscv_hart.h
> +++ b/include/hw/riscv/riscv_hart.h
> @@ -27,6 +27,10 @@
>  #ifndef HW_RISCV_HART_H
>  #define HW_RISCV_HART_H
> =20
> +#include "qemu/osdep.h"

NACK to this part.  Our policy is that all .c files should include
osdep.h before anything else, and therefore, all .h files can assume
that osdep.h has already been included.  Extending that logic, uint32_t
is always available for use in any .h, without having to add any includes=
=2E

> +#include "hw/sysbus.h"
> +#include "target/riscv/cpu.h"

But including these headers for SysBusDevice and RISCVCPU makes sense.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--TsUopMqxCAw3WuZiB7KLsmU31qMEeqLvY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpP8cAACgkQp6FrSiUn
Q2qzzgf/cyC5mIcP0SQ97Lhr8adSEnKuFCbjhISTM2OITxzzIwKihPXa4fg3bbxm
RFI42JuRD192CscrhI7R+SgoUA5Pd4+zYOyjVyvikGUkQ84UqMrc1AIDbnHpyMrG
JzGvsOgobfbQgGCzFTNbESeX9H42pVKL4ow9s2Yj6DsO2bRnjIdE7WBtO0uCpJ1g
HIHx1x6rNpeRIDotpppgpkJUdV+yfYFYa9t7JkAaohcbF1yGnPqcrKPbmX5dUVtE
+BMlbhO4H3SURxY8KO49NHz9Jsi/XS76NP7ZgVf4LZhIz08f9Zwqa+y9fS2uMPh9
8SJWOJafZne7lR4Sq9aO4j9aQBijEA==
=ELeU
-----END PGP SIGNATURE-----

--TsUopMqxCAw3WuZiB7KLsmU31qMEeqLvY--
