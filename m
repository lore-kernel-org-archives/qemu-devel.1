Received: from eggs.gnu.org ([2001:4830:134:3::10]:48386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dVXXq-0000uT-9j
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 02:24:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dVXXn-0008PH-5o
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 02:24:14 -0400
Received: from 18.mo7.mail-out.ovh.net ([188.165.56.163]:45795)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dVXXm-0008Nt-WA
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 02:24:11 -0400
Received: from player788.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id 7F3D461520
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 08:24:08 +0200 (CEST)
References: <20170713062128.38954-1-aik@ozlabs.ru>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <00f6b958-4b48-8bd0-3d3e-668e70516878@kaod.org>
Date: Thu, 13 Jul 2017 08:24:04 +0200
MIME-Version: 1.0
In-Reply-To: <20170713062128.38954-1-aik@ozlabs.ru>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH qemu] ppc/pnv: Remove unused
 XICSState reference
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On 07/13/2017 08:21 AM, Alexey Kardashevskiy wrote:
> e6f7e110ee70 "ppc/xics: remove the XICSState classes" got rid of
> XICSState, this is just an leftover.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Indeed.

Reviewed-by: C=E9dric Le Goater <clg@kaod.org>

Thanks,

C.
> ---
>  include/hw/ppc/pnv_psi.h | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/include/hw/ppc/pnv_psi.h b/include/hw/ppc/pnv_psi.h
> index 11d83e43f8..f6af5eae1f 100644
> --- a/include/hw/ppc/pnv_psi.h
> +++ b/include/hw/ppc/pnv_psi.h
> @@ -28,8 +28,6 @@
> =20
>  #define PSIHB_XSCOM_MAX         0x20
> =20
> -typedef struct XICSState XICSState;
> -
>  typedef struct PnvPsi {
>      SysBusDevice parent;
> =20
>=20
