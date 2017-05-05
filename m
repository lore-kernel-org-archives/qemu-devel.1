Received: from eggs.gnu.org ([2001:4830:134:3::10]:36951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d6fAv-0007Gr-2L
	for qemu-devel@nongnu.org; Fri, 05 May 2017 11:29:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d6fAs-0006F2-FZ
	for qemu-devel@nongnu.org; Fri, 05 May 2017 11:29:45 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:33969)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1d6fAs-0006Eh-8L
	for qemu-devel@nongnu.org; Fri, 05 May 2017 11:29:42 -0400
Received: by mail-wm0-x242.google.com with SMTP id z129so2031979wmb.1
	for <qemu-devel@nongnu.org>; Fri, 05 May 2017 08:29:42 -0700 (PDT)
Date: Fri, 5 May 2017 16:29:39 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170505152939.GF14316@stefanha-x1.localdomain>
References: <cover.1493858877.git.shorne@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8JPrznbw0YAQ/KXy"
Content-Disposition: inline
In-Reply-To: <cover.1493858877.git.shorne@gmail.com>
Subject: Re: [Qemu-devel] [PULL v2 00/11] Fixes and features for OpenRISC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stafford Horne <shorne@gmail.com>
Cc: QEMU Development <qemu-devel@nongnu.org>


--8JPrznbw0YAQ/KXy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 04, 2017 at 09:53:15AM +0900, Stafford Horne wrote:
> Hello,
>=20
> This are the openrisc patches I have been circulating on the mailing list
> of the last few months.  We have had help from a few new people and added
> the following:
>  * Fixes for gdb memory debugging
>  * Added support for Shadow Registers, EVBAR, EPH
>  * Added support for idle state, no more 100% pegged cpu's
>  * Fixed VM state persisting
>=20
>=20
> Changes Since v1:
>   o Fixed all checkpatch warnings and errors
>=20
>=20
> The following changes since commit 359c41abe32638adad503e386969fa428cecff=
52:
>=20
>   Update version for v2.9.0 release (2017-04-20 15:31:34 +0100)
>=20
> are available in the git repository at:
>=20
>   git://github.com/stffrdhrn/qemu.git tags/pull-or-20170504
>=20
> for you to fetch changes up to f4d1414a9385e3375d9107b29eeb75d27daf2147:
>=20
>   target/openrisc: Support non-busy idle state using PMR SPR (2017-05-04 =
09:39:14 +0900)
>=20
> ----------------------------------------------------------------
> Openrisc Features and Fixes for qemu 2.10
>=20
> ----------------------------------------------------------------
> Stafford Horne (9):
>       MAINTAINERS: Add myself as openrisc maintainer
>       target/openrisc: Fixes for memory debugging
>       target/openrisc: add numcores and coreid support
>       migration: Add VMSTATE_UINTTL_2DARRAY()
>       target/openrisc: implement shadow registers
>       migration: Add VMSTATE_STRUCT_2DARRAY()
>       target/openrisc: Implement full vmstate serialization
>       target/openrisc: Remove duplicate features property
>       target/openrisc: Support non-busy idle state using PMR SPR
>=20
> Tim 'mithro' Ansell (2):
>       target/openrisc: Implement EVBAR register
>       target/openrisc: Implement EPH bit
>=20
>  MAINTAINERS                         |  4 +-
>  hw/openrisc/cputimer.c              |  1 +
>  include/migration/cpu.h             |  7 ++++
>  include/migration/vmstate.h         | 18 +++++++++
>  linux-user/elfload.c                |  2 +-
>  linux-user/main.c                   | 18 ++++-----
>  linux-user/openrisc/target_cpu.h    |  6 +--
>  linux-user/openrisc/target_signal.h |  2 +-
>  linux-user/signal.c                 | 17 +++++----
>  target/openrisc/cpu.c               | 16 +++-----
>  target/openrisc/cpu.h               | 46 ++++++++++++++--------
>  target/openrisc/gdbstub.c           |  4 +-
>  target/openrisc/interrupt.c         | 11 +++++-
>  target/openrisc/machine.c           | 76 +++++++++++++++++++++++++++++++=
++++--
>  target/openrisc/mmu.c               | 24 ++++++++++--
>  target/openrisc/sys_helper.c        | 35 +++++++++++++++++
>  target/openrisc/translate.c         |  5 ++-
>  17 files changed, 230 insertions(+), 62 deletions(-)
>=20
> --=20
> 2.9.3
>=20

Thanks, applied to my staging tree:
https://github.com/stefanha/qemu/commits/staging

Stefan

--8JPrznbw0YAQ/KXy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZDJpjAAoJEJykq7OBq3PIxOcIAKtBTv0EcAqK5wcRn7vOSInq
w2uqtOh8RiDV2J8piDGnTz7LT3ws0Eg65BFIHpdxpcmMk4pda/thbrhs4AqYRSHi
dSfAyhsFnDBaN4kVQzaPCbwG7T3HZRNY/bPomSoQzcEPW2Tq8ETTBqlduMvHCDGG
hLwlymgB5ag/t+qoE6Ruw2L0G7qzew/iC4yACmBrErJJgpBvKwn24wer/wlocnER
q2FMIipdjspbXGpnlhlO4ZKtReu64PIcoEBp/lVE2hqccy/xFCqIe46VSzKV2UCv
YWn0M1LJaGh/PHiJCqlECqz0NEfuY5eLh7kYiqJWtsA5+H2kk0n1bDaCsS90eIA=
=6E2H
-----END PGP SIGNATURE-----

--8JPrznbw0YAQ/KXy--
