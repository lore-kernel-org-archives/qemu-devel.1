Received: from eggs.gnu.org ([2001:4830:134:3::10]:34389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dE8EH-0000Dc-Di
	for qemu-devel@nongnu.org; Fri, 26 May 2017 01:56:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dE8EG-0002W4-CE
	for qemu-devel@nongnu.org; Fri, 26 May 2017 01:56:05 -0400
Date: Fri, 26 May 2017 15:55:53 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170526055553.GM12929@umbus.fritz.box>
References: <1495601614-18586-1-git-send-email-bharata@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bZ2MuwyI/0uB8yuJ"
Content-Disposition: inline
In-Reply-To: <1495601614-18586-1-git-send-email-bharata@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/3] ppc/spapr: Fix migration of radix
 guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bharata B Rao <bharata@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, sam.bobroff@au1.ibm.com, rnsastry@linux.vnet.ibm.com, sjitindarsingh@gmail.com


--bZ2MuwyI/0uB8yuJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 24, 2017 at 10:23:31AM +0530, Bharata B Rao wrote:
> This patchset fixes the migration of sPAPR radix guests.

Since Juan has approved merging the latest spin on the
unregister_savevm() patch through my tree, I've merged that, along
with your update 2/3 and 3/3 here.  I did rework 2/3 a bit to remove
unnecessary code motion.

>=20
> Changes in v3:
> --------------
> - Dropped the patch that made h_register_process_table flags global as
>   it is not required with the changed logic.
> - The post load logic is now same for both TCG as well as KVM radix guest=
s.
>   Also ensured that radix and future v3 hash migration post load is
>   treated similarly.
> - Ensure TCG Radix guest migration isn't broken.
>=20
> v2: https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg04491.html
>=20
> Bharata B Rao (3):
>   migration: Introduce unregister_savevm_live()
>   spapr: Unregister HPT savevm handlers for radix guests
>   spapr: Fix migration of Radix guests
>=20
>  hw/ppc/spapr.c              | 111 +++++++++++++++++++++++++-------------=
------
>  include/hw/ppc/spapr.h      |   2 +
>  include/migration/vmstate.h |   1 +
>  migration/savevm.c          |  17 ++++++-
>  4 files changed, 80 insertions(+), 51 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--bZ2MuwyI/0uB8yuJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZJ8NmAAoJEGw4ysog2bOS45IQAJtHfPmExU/TIctVaD093nrR
fIZAPDsuSyVyTvly3G6TRzvgPnNwXuUAvKznD0NEEk/jbhQ1PARWQCRdRyaAewab
X8aJ4mfbwRBCzMfL0gLct+SEP8PTwfHWtUcaWZbAJJkJgIGvlpkh8IT6UyHKsLei
owYhh6DVj+a7sAQOt5rRDSr7ZtgIZdK8jhXVeuoMp/IUe8Ri5A3be2pWyE/x8yF7
lcbC3STxTdM3uwahPDMGyFTpp5DqEmZqEjEUbtGWi3gL71pEYOTwsb4qm0efzBse
M+TNo4dl7akOxYeoq7Le2X94Ibc+X67GWseJ0r4xFO7PH9dhh+Yz9lPhNCDq4Iyv
Bwl4rZQ7OMEzxNxbfK4YllKGW0LXDpg7oLWzhbA9bvAPbmsCGCzsyaVe3iELYSPb
j55yBrfSCDBYyEc1FgKBMOf786aRZxfu0rBNocXKCFUdAGuocJMxfMS2KivB4KhE
eMXLIuI8CwVywP+pBZqI4A/D3G4OMdrIv4tnSKioP+vk3KWO+NjWqLCOuFCxfXMx
Nl/FFb+yOtdmApCtxlTW+f/udqipKS3029uttJP6QPHu8vDfOEfYZ0VDruAA+e2f
FD8f8OCB3rjsSb0sajCgxMYIH8RU0zyclglcCBpAVXFbxMWrAVtYR8gakWFV8mGp
7jESKnWrMepzHB2Tx7B5
=dwgp
-----END PGP SIGNATURE-----

--bZ2MuwyI/0uB8yuJ--
