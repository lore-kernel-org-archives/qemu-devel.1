Received: from eggs.gnu.org ([2001:4830:134:3::10]:53793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ebet7-0003Ql-Np
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 22:59:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ebet3-0006wU-G8
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 22:59:45 -0500
Date: Wed, 17 Jan 2018 14:13:35 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180117031335.GY30352@umbus.fritz.box>
References: <1516104958-3881-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iIOavGAISvUeFFLW"
Content-Disposition: inline
In-Reply-To: <1516104958-3881-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/4] Clean up the ppc configs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, BALATON Zoltan <balaton@eik.bme.hu>


--iIOavGAISvUeFFLW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2018 at 01:15:54PM +0100, Thomas Huth wrote:
> ppc64-softmmu is a superset of ppc-softmmu which in turn is a superset
> of ppcemb-softmmu. But since the config files are currently independent
> from each other, we missed to define some CONFIG switches in the super-
> sets: CONFIG_SUNGEM is missing from the ppc64-softmmu config, and the
> CONFIG_IDE_SII3112 switch is only defined in ppcemb-softmmu.
>=20
> This patch series fixes these problems, together with cleaning up
> the config- and make-files for better usability. qemu-system-ppcemb
> is finally marked as deprecated since there is hardly any use case
> for this separate build nowadays anymore (and if somebody really
> still needs page sizes < 4k, we should likely rather use the dynamic
> approach that is already done on the ARM boards instead).

Applied to ppc-for-2.12, thanks.


>=20
> v2:
>  - Added patch to disable the PPC4xx boards in the hw/ppc/Makefile
>  - Added patch to deprecate qemu-system-ppcemb
>=20
> Thomas Huth (4):
>   default-configs/ppc64-softmmu: Include 32-bit configs instead of
>     copying them
>   default-configs/ppc-softmmu: Restructure the switches according to the
>     machines
>   hw/ppc/Makefile: Add a way to disable the PPC4xx boards
>   ppc: Deprecate qemu-system-ppcemb
>=20
>  default-configs/ppc-softmmu.mak   | 59 ++++++++++++++++++++-------------=
----
>  default-configs/ppc64-softmmu.mak | 61 +++++----------------------------=
------
>  hw/ppc/Makefile.objs              |  4 +--
>  qemu-doc.texi                     |  6 ++++
>  target/ppc/translate_init.c       |  5 ++++
>  5 files changed, 53 insertions(+), 82 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--iIOavGAISvUeFFLW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlpev1wACgkQbDjKyiDZ
s5LZPhAAu0NRnp/+KqkCPINE7ZS5VKQAnDjvwX8kU5GEbdzzeIeis6RIV57MQZkz
w6ly0koy27XE3lCpyXqUqdL9ThoS25LcGx+2m7FctVbAFaIOBcVJxvYsaNmpKSEG
QEO6Ka9IcFQ4HErHSJAMevb1Jrb3i3pAYb04OrVcDpe97HgZJD3ElI1i/z6ArNkW
jifOXXgtz+XUQXrzi7sS6VANMVKkgM1cb/Yhyszwi5qrg7IEDFu4SC802+Yr2phk
G+g3oyzJB3oxKmnGD/2W994J7XQ4psx5XKYTrZOEv/BXLuSTYOtYVhiG3JhYgEp7
vfI1LO383lLLL+hQc4LNzWUNhf/HFg1kMpXcYOlpIMP8sKY+7aNbjYayWidcDOn9
CsDpdlUzBFL8FAZeNo+tHz6sDZH6N9JCWZQpFOgoMmKv72BhCPwEO9KuGYovs3WN
bn85YBZSqq9IF2JcYHE+2JgjSkitjbxytq9RT/TEWnaaE0KvA5RK/HOKkrR0pyV4
WyXKlqWUfcJozPfTt/P6bE8WZfNaSckohzZKpLflJKP3PnWkivnt6Dkm9aDzh/2I
icEw0goB1rRfy/NRX0tWVUpT57LWi70b957irTH2qETn1dyGHWouTcIvh0A6dH0C
Rtd96oHIrsnsxgdHvISDpZElmc8NQ8oiB6zOWKPQACL20PBFwyY=
=00ZY
-----END PGP SIGNATURE-----

--iIOavGAISvUeFFLW--
