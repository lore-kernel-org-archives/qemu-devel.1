Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68AD4C3276C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 02:27:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B45A21D56
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 02:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="h2PiMqFh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B45A21D56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inCgD-0003Zn-Uw
	for qemu-devel@archiver.kernel.org; Thu, 02 Jan 2020 21:27:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49888)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1inCf3-0002AY-2l
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 21:26:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1inCf1-00060M-EM
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 21:26:00 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:39555 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1inCf0-0005ja-2r; Thu, 02 Jan 2020 21:25:59 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47ppfk2pScz9sR8; Fri,  3 Jan 2020 13:25:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1578018350;
 bh=FjGMJI8ugYDqCgkEZ/x2g32ks3hBQputV4DP0QsRfAk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=h2PiMqFhnEzqdp3Gsqh3Varpx9HAvc6UR33ARjyyoMi2BsHi/G96goMp3xMxSYoPg
 lgVxl2YbhVOVpf8+4er7Pg/vhdhkVxNGPPMxvFbXJjY0sqczneaxUUVlb2wthib2yi
 W6xnF/SzAcFPzfRT7glHe6eJ6+4YKEI7zsf89uaE=
Date: Fri, 3 Jan 2020 12:20:15 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Subject: Re: [PATCH v4 3/4] spapr: Add NVDIMM device support
Message-ID: <20200103012015.GP2098@umbus>
References: <157657241446.53829.7078678659499762596.stgit@lep8c.aus.stglabs.ibm.com>
 <157657253645.53829.168353921681383728.stgit@lep8c.aus.stglabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="EkxpYdHiqGHPYbUt"
Content-Disposition: inline
In-Reply-To: <157657253645.53829.168353921681383728.stgit@lep8c.aus.stglabs.ibm.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org, imammedo@redhat.com, qemu-ppc@nongnu.org,
 xiaoguangrong.eric@gmail.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--EkxpYdHiqGHPYbUt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2019 at 02:49:14AM -0600, Shivaprasad G Bhat wrote:
> Add support for NVDIMM devices for sPAPR. Piggyback on existing nvdimm
> device interface in QEMU to support virtual NVDIMM devices for Power.
> Create the required DT entries for the device (some entries have
> dummy values right now).
>=20
> The patch creates the required DT node and sends a hotplug
> interrupt to the guest. Guest is expected to undertake the normal
> DR resource add path in response and start issuing PAPR SCM hcalls.
>=20
> The device support is verified based on the machine version unlike x86.
>=20
> This is how it can be used ..
> Ex :
> For coldplug, the device to be added in qemu command line as shown below
> -object memory-backend-file,id=3Dmemnvdimm0,prealloc=3Dyes,mem-path=3D/tm=
p/nvdimm0,share=3Dyes,size=3D1073872896
> -device nvdimm,label-size=3D128k,uuid=3D75a3cdd7-6a2f-4791-8d15-fe0a920e8=
e9e,memdev=3Dmemnvdimm0,id=3Dnvdimm0,slot=3D0
>=20
> For hotplug, the device to be added from monitor as below
> object_add memory-backend-file,id=3Dmemnvdimm0,prealloc=3Dyes,mem-path=3D=
/tmp/nvdimm0,share=3Dyes,size=3D1073872896
> device_add nvdimm,label-size=3D128k,uuid=3D75a3cdd7-6a2f-4791-8d15-fe0a92=
0e8e9e,memdev=3Dmemnvdimm0,id=3Dnvdimm0,slot=3D0
>=20
> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> Signed-off-by: Bharata B Rao <bharata@linux.ibm.com>
>                [Early implementation]
> ---
>  default-configs/ppc64-softmmu.mak |    1=20
>  hw/mem/Kconfig                    |    2=20
>  hw/ppc/spapr.c                    |  216 +++++++++++++++++++++++++++++++=
+++---
>  hw/ppc/spapr_drc.c                |   18 +++
>  hw/ppc/spapr_events.c             |    4 +
>  include/hw/ppc/spapr.h            |   11 ++
>  include/hw/ppc/spapr_drc.h        |    9 ++
>  7 files changed, 245 insertions(+), 16 deletions(-)
>=20
> diff --git a/default-configs/ppc64-softmmu.mak b/default-configs/ppc64-so=
ftmmu.mak
> index cca52665d9..ae0841fa3a 100644
> --- a/default-configs/ppc64-softmmu.mak
> +++ b/default-configs/ppc64-softmmu.mak
> @@ -8,3 +8,4 @@ CONFIG_POWERNV=3Dy
> =20
>  # For pSeries
>  CONFIG_PSERIES=3Dy
> +CONFIG_NVDIMM=3Dy
> diff --git a/hw/mem/Kconfig b/hw/mem/Kconfig
> index 620fd4cb59..2ad052a536 100644
> --- a/hw/mem/Kconfig
> +++ b/hw/mem/Kconfig
> @@ -8,4 +8,4 @@ config MEM_DEVICE
>  config NVDIMM
>      bool
>      default y
> -    depends on PC
> +    depends on (PC || PSERIES)
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 3ae7db1563..921d8d7c8e 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -80,6 +80,8 @@
>  #include "hw/ppc/spapr_cpu_core.h"
>  #include "hw/mem/memory-device.h"
>  #include "hw/ppc/spapr_tpm_proxy.h"
> +#include "hw/mem/nvdimm.h"
> +#include "qemu/nvdimm-utils.h"
> =20
>  #include "monitor/monitor.h"
> =20
> @@ -685,12 +687,22 @@ static int spapr_populate_drmem_v2(SpaprMachineStat=
e *spapr, void *fdt,
>              nr_entries++;
>          }
> =20
> -        /* Entry for DIMM */
> -        drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_LMB, addr / lmb_size);
> -        g_assert(drc);
> -        elem =3D spapr_get_drconf_cell(size / lmb_size, addr,
> -                                     spapr_drc_index(drc), node,
> -                                     SPAPR_LMB_FLAGS_ASSIGNED);
> +        if (info->value->type =3D=3D MEMORY_DEVICE_INFO_KIND_DIMM) {
> +            /* Entry for DIMM */
> +            drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_LMB, addr / lmb_size);
> +            g_assert(drc);
> +            elem =3D spapr_get_drconf_cell(size / lmb_size, addr,
> +                                         spapr_drc_index(drc), node,
> +                                         SPAPR_LMB_FLAGS_ASSIGNED);
> +        } else if (info->value->type =3D=3D MEMORY_DEVICE_INFO_KIND_NVDI=
MM) {
> +            /*
> +             * NVDIMM sits here, let the DIMM LMBs be unusable here in t=
he
> +             * whole range
> +             */
> +            elem =3D spapr_get_drconf_cell(size / lmb_size, addr, 0, -1,
> +                                         SPAPR_LMB_FLAGS_RESERVED |
> +                                         SPAPR_LMB_FLAGS_DRC_INVALID);
> +        }

As discussed in reply to an earlier thread, this whole scheme
basically breaks down in the presence of hotplug - it relies on which
GPAs are DIMMs and which are NVDIMMs not changing.

Other than that significant problem, the rest of this looks
reasonable.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--EkxpYdHiqGHPYbUt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4Ols0ACgkQbDjKyiDZ
s5J2ohAAvAI0a2uIhlaGi4VoWc5R4/GhT27YMp55jQtiSdoT6ja6kSXGQjtkqd34
kMZHr508aYnJU5d917PplMh9ryXpRStnfDnC3rB4FOqWi54gy6VYb0ZrA6mEubX9
0ey32UF09lYueRkspbthSuMKCxeOQC7HKIJFMjkdN+iiACZACa5Pv0A4avYmIaXy
D2mhaxrlxH6r4PlhlubFyePUyNd23CuFrNT8+Kt4eG0T8psyfvq+ZXoP2/8idmU9
dZDaz1ayjH1Na6gPaykppMdFC+0xDGu7uYO5WqZu+csq7X4v1jE/R2PXYTpOSFxX
kYVNTsQrWmse0zRapHTcwZVbFlUcM5uNQoeb/R7jCX9iruPoWdEtDhTKnFa2ezPU
Zu88ImGihR1dwPVSJ3xyMJxFDKxkxvvjGMtq+ZKG0ClPCapnEdQ9ksD4UY5aKcU6
DCGu2sUcRziEWS+1E/s0cAPCwqsmafvFvpcNR1x6OlnRusa1H7o4kW+CWWHnCwM1
VYqBdagC2NPtwqGLUBNqRlsweC1pElfmx0kj1uCA1Pg43MjPm+fvMozvHyDmvZew
AY4KmTiJwyz9liM4KPWQ2d+xh+BIqeYaDTezQ8V0OJ726XVdT4OCLYnFTwE93gQe
rSbstcCLDIxaTbP8ASTMTEDfwLTrsJOCC2R7jLusY08ksMLdq0A=
=ZuRP
-----END PGP SIGNATURE-----

--EkxpYdHiqGHPYbUt--

