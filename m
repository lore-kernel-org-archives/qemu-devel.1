Received: from eggs.gnu.org ([209.51.188.92]:44171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gpPPf-000192-0D
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 22:22:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gpPIp-0000iD-HM
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 22:15:40 -0500
Date: Fri, 1 Feb 2019 12:04:53 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190201010453.GC26425@umbus.fritz.box>
References: <1548866382-14488-1-git-send-email-thuth@redhat.com>
	<4e8dcc26-7e62-c79d-c354-8ade5db33f26@redhat.com>
	<3c30472b-bc7f-d3cc-cf1f-1e5127205984@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IrhDeMKUP4DT/M7F"
Content-Disposition: inline
In-Reply-To: <3c30472b-bc7f-d3cc-cf1f-1e5127205984@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] hw/ppc: Don't include m48t59.h
 if it is not necessary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, qemu-ppc@nongnu.org, qemu-trivial@nongnu.org, qemu-devel@nongnu.org


--IrhDeMKUP4DT/M7F
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 31, 2019 at 03:12:48PM +0100, Thomas Huth wrote:
> On 2019-01-30 18:21, Philippe Mathieu-Daud=E9 wrote:
> > On 1/30/19 5:39 PM, Thomas Huth wrote:
> >> These files don't use anything from m48t59.h, so no need to include
> >> this header here.
> >>
> >> Signed-off-by: Thomas Huth <thuth@redhat.com>
> >> ---
> >>  hw/ppc/mac_newworld.c | 1 -
> >>  hw/ppc/mac_oldworld.c | 1 -
> >>  hw/ppc/ppc.c          | 2 --
> >>  hw/ppc/ppc_booke.c    | 1 -
> >>  4 files changed, 5 deletions(-)
> >>
> >> diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
> >> index bb19eab..f1c8400 100644
> >> --- a/hw/ppc/mac_newworld.c
> >> +++ b/hw/ppc/mac_newworld.c
> >> @@ -53,7 +53,6 @@
> >>  #include "hw/ppc/mac.h"
> >>  #include "hw/input/adb.h"
> >>  #include "hw/ppc/mac_dbdma.h"
> >> -#include "hw/timer/m48t59.h"
> >>  #include "hw/pci/pci.h"
> >>  #include "net/net.h"
> >>  #include "sysemu/sysemu.h"
> >> diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
> >> index 817f70e..98d531d 100644
> >> --- a/hw/ppc/mac_oldworld.c
> >> +++ b/hw/ppc/mac_oldworld.c
> >> @@ -30,7 +30,6 @@
> >>  #include "hw/ppc/ppc.h"
> >>  #include "mac.h"
> >>  #include "hw/input/adb.h"
> >> -#include "hw/timer/m48t59.h"
> >>  #include "sysemu/sysemu.h"
> >>  #include "net/net.h"
> >>  #include "hw/isa/isa.h"
> >> diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
> >> index 98b409f..cffdc39 100644
> >> --- a/hw/ppc/ppc.c
> >> +++ b/hw/ppc/ppc.c
> >> @@ -30,10 +30,8 @@
> >>  #include "qemu/timer.h"
> >>  #include "sysemu/sysemu.h"
> >>  #include "sysemu/cpus.h"
> >> -#include "hw/timer/m48t59.h"
> >>  #include "qemu/log.h"
> >>  #include "qemu/error-report.h"
> >> -#include "hw/loader.h"
> >=20
> > I supposed the "hw/loader.h" change slipped in by mistake.
>=20
> I should have mentioned it in the patch description, I guess. ppc.c also
> compiles without this line, so it can be removed, too.

Fair enough, applied to ppc-for-4.0.

>=20
>  Thomas
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--IrhDeMKUP4DT/M7F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxTmzUACgkQbDjKyiDZ
s5JzKg//QbZZtlG+qJ5iaImi6MxCDgn5sXPN/AKoJlZIgrG+YRZlWN18LZdkw+i7
oKutmggFO+oMse4JT3doFxk/e2E0ItPX5QAV6HG+VGgnBoMQjIUSDwAP37F3aW6c
1A+WLzmJApZlCI8qxn5AGYxn+m7/mwMVj+hKQVNtLcCPPVZ+WXH02Vi7982AcRaN
QKDp8Ef4aLwNMzg0fwyu6dhnTQggojSO2GLdh39OrBKAeo6s1aOH4T7ZHchDgmbs
lYP2327fPshYyzC+lMq9oysXnzt5ows9Lg5hKTk8U17vMOvfeC4aXR9KHAocNGYQ
i3ouyIYycnWkAq4bLv/FhIgwDRoa7tW02xKi2U1PiOZ1X2bi8WODXcBAXGwxxlhf
Fe/Ro8PcX0dmwrAEnYd3oMg1zd+O+K7/2aYoSgQ6ly3mxHf/usrDqvoboJGvM9DZ
c7IuHs60LhbKnrvKC33pTELTAttMyhvO1lRetPzgYLwrOJ75iqK3uXpPCvE87jn2
8zC+TlT3qZUizoOJvIZ/6ebW6Re7anjqvCfOKRyuiQQVwx75FXptuQf2cx1zUL2w
nrBizo52Cf4AxLgEJxEIO6peT14HVP3Tk8HevbOXicF56PrRJCB9Sme5nctzD5kT
MYyp8Xb/53PSNaXeFVtsdlneqdYn3WBeuEfTXEltenGXcOG143c=
=QQ6+
-----END PGP SIGNATURE-----

--IrhDeMKUP4DT/M7F--
