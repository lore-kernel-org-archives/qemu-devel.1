Received: from eggs.gnu.org ([2001:4830:134:3::10]:36402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cc0rc-00065k-J2
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 21:23:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cc0rb-00028V-JZ
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 21:23:08 -0500
Received: from ozlabs.org ([103.22.144.67]:54433)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1cc0rb-00025E-8m
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 21:23:07 -0500
Date: Fri, 10 Feb 2017 12:20:58 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170210012058.GX27610@umbus.fritz.box>
References: <1486456099-7345-1-git-send-email-peterx@redhat.com>
	<1486456099-7345-10-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="R9dSeJxMIUBTi9Do"
Content-Disposition: inline
In-Reply-To: <1486456099-7345-10-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 09/17] intel_iommu: vtd_slpt_level_shift
 check level
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, jasowang@redhat.com, alex.williamson@redhat.com, bd.aviv@gmail.com


--R9dSeJxMIUBTi9Do
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 07, 2017 at 04:28:11PM +0800, Peter Xu wrote:
> This helps in debugging incorrect level passed in.
>=20
> Reviewed-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/i386/intel_iommu.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index ad304f6..22d8226 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -168,6 +168,7 @@ static gboolean vtd_hash_remove_by_domain(gpointer ke=
y, gpointer value,
>  /* The shift of an addr for a certain level of paging structure */
>  static inline uint32_t vtd_slpt_level_shift(uint32_t level)
>  {
> +    assert(level !=3D 0);
>      return VTD_PAGE_SHIFT_4K + (level - 1) * VTD_SL_LEVEL_BITS;
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--R9dSeJxMIUBTi9Do
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYnRV6AAoJEGw4ysog2bOSv7sP/3q5v17ry+odP3Gl+7C96Vfq
9j36m/9yeJw+SByqClv0RfzA6s6So11vs+qf9AJdh0E86zUB2/3etUYww2Zeq5f4
29UJARl5+zDIQb1DMIzbhl5ah9fkLeqLmrm//SJlovrc+kaB59pgWboz8uLwo47m
37pCNghk9+ClURSHgyKY4TvXuo94ayOtxEaNBRJv4KFOmMGkNiLf2wjpABeA11pv
10ksaffKhb9lCHJYSm96pm/CHYmY8jk7r1V3Epi+k1Gvqcp/sb8301qelJDi12hc
SAs5Wf73q3VkoWVBDzcvMUPJyJlr4gMIXjuacIoCfJf6VRSOhJG6xDBCb/ohDNCW
6roBzNKx/j1RwbjbKKfo+kWj2SlKI8mdQVdhjttOCg5sOPzXHa1+1vrl0tV/fq4L
UCohTYNIKm9ppDO/T3qREG1d54bmZsgyjgzVoetzc8tSBvSCEHbgFk09OC7GXbG8
uBBv2sMcoWB6DU09Gx8XpSjPSscRqVh8ESCNcvlkb/keYWIlIewd5ugxabvO+8r5
1/QgCaeYYu0IkAzd5ye2h1aW8kUCcSUKV8Fh+LAEHr0/VwsNE6Bqy7KjavKAOPCK
QIq3n5NY2DZCH5mFJoTOg07QyLKJq8iEKEcDBdjEh0ajwcyc8xjYey9Vu968clKX
7hNi5ulWZMEgKNlGEHyj
=2E4v
-----END PGP SIGNATURE-----

--R9dSeJxMIUBTi9Do--
