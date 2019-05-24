Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52DE7C282DE
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 01:02:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F01C20862
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 01:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="aij2Nu4P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F01C20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45585 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTybM-0007Ff-9U
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 21:02:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hTyZy-0006F6-Oy
	for qemu-devel@nongnu.org; Thu, 23 May 2019 21:01:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hTyZx-0000dB-Ci
	for qemu-devel@nongnu.org; Thu, 23 May 2019 21:01:02 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:36747 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hTyZn-0000EC-Qp; Thu, 23 May 2019 21:00:56 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 4597Mc5xNPz9sMM; Fri, 24 May 2019 11:00:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1558659628;
	bh=MGKo8nRnCCiM4Jy+1IykQcQPHHpXy3uOGSDISVggz9M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aij2Nu4Pq0qtXbpvFg5u4ufdyTBbK4JJ29ZsplTFONBLO9SuJ5o9Zp0Gp2DdUaY7X
	9cmCJvPMF6icUjOCN0WPpKQ6VIWw6qB1ePG5phy0ghgy4wdE9gBhkY2d1u2x8csDrW
	ndpZJWb2b1I2PADWLzv7RNBbtYrFv0BHjM0RiaFI=
Date: Fri, 24 May 2019 10:44:28 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190524004428.GA1967@umbus.fritz.box>
References: <20190523124320.28726-1-philmd@redhat.com>
	<20190523124320.28726-6-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
In-Reply-To: <20190523124320.28726-6-philmd@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PULL 05/15] hw/ppc: Implement
 fw_cfg_arch_key_name()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
	Gerd Hoffmann <kraxel@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
	Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2019 at 02:43:10PM +0200, Philippe Mathieu-Daud=E9 wrote:
> Implement fw_cfg_arch_key_name(), which returns the name of a
> ppc-specific key.
>=20
> The fw_cfg device is used by the machine using OpenBIOS:
> - 40p
> - mac99 (oldworld)
> - g3beige (newworld)
>=20
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
> Message-Id: <20190422195020.1494-6-philmd@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ppc/Makefile.objs |  2 +-
>  hw/ppc/fw_cfg.c      | 45 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 46 insertions(+), 1 deletion(-)
>  create mode 100644 hw/ppc/fw_cfg.c
>=20
> diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
> index 636e717f20..9da93af905 100644
> --- a/hw/ppc/Makefile.objs
> +++ b/hw/ppc/Makefile.objs
> @@ -1,5 +1,5 @@
>  # shared objects
> -obj-y +=3D ppc.o ppc_booke.o fdt.o
> +obj-y +=3D ppc.o ppc_booke.o fdt.o fw_cfg.o
>  # IBM pSeries (sPAPR)
>  obj-$(CONFIG_PSERIES) +=3D spapr.o spapr_caps.o spapr_vio.o spapr_events=
=2Eo
>  obj-$(CONFIG_PSERIES) +=3D spapr_hcall.o spapr_iommu.o spapr_rtas.o
> diff --git a/hw/ppc/fw_cfg.c b/hw/ppc/fw_cfg.c
> new file mode 100644
> index 0000000000..a88b5c4bde
> --- /dev/null
> +++ b/hw/ppc/fw_cfg.c
> @@ -0,0 +1,45 @@
> +/*
> + * fw_cfg helpers (PPC specific)
> + *
> + * Copyright (c) 2019 Red Hat, Inc.
> + *
> + * Author:
> + *   Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/ppc/ppc.h"
> +#include "hw/nvram/fw_cfg.h"
> +
> +const char *fw_cfg_arch_key_name(uint16_t key)
> +{
> +    static const struct {
> +        uint16_t key;
> +        const char *name;
> +    } fw_cfg_arch_wellknown_keys[] =3D {
> +        {FW_CFG_PPC_WIDTH, "width"},
> +        {FW_CFG_PPC_HEIGHT, "height"},
> +        {FW_CFG_PPC_DEPTH, "depth"},
> +        {FW_CFG_PPC_TBFREQ, "tbfreq"},
> +        {FW_CFG_PPC_CLOCKFREQ, "clockfreq"},
> +        {FW_CFG_PPC_IS_KVM, "is_kvm"},
> +        {FW_CFG_PPC_KVM_HC, "kvm_hc"},
> +        {FW_CFG_PPC_KVM_PID, "pid"},
> +        {FW_CFG_PPC_NVRAM_ADDR, "nvram_addr"},
> +        {FW_CFG_PPC_BUSFREQ, "busfreq"},
> +        {FW_CFG_PPC_NVRAM_FLAT, "nvram_flat"},
> +        {FW_CFG_PPC_VIACONFIG, "viaconfig"},
> +    };
> +
> +    for (size_t i =3D 0; i < ARRAY_SIZE(fw_cfg_arch_wellknown_keys); i++=
) {
> +        if (fw_cfg_arch_wellknown_keys[i].key =3D=3D key) {
> +            return fw_cfg_arch_wellknown_keys[i].name;
> +        }
> +    }
> +    return NULL;
> +}

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlznPmoACgkQbDjKyiDZ
s5IR3w/+MwwVLLaSuUmDIefC2jgM/uvfL8XGZWGQ7qh5pRl6c7CaAmd5f58hFpt/
A+gCh0D3j8qTk6iAZdX37lTqsLjAvOlu9nDBykIVcJ4OLvxrzwS8s0MphvZdu2mn
HXPvcFAJofq9WdgE4FmybuWSCDpT4vgdjETWBq4zZZPTGqgBE089lsMIxRV6sQk7
TW8WLOpm+Y6MRNwPlDXDGub6GNIbKLoQ7SqFkOv+NJP6tctnp1/cyim4s3WfBn7v
ehwHmzOWpPbY2NG30hBsUjdogEueqmWJrD0qpUqhoRPvAePyBM+Kki0RKG9KinLY
BHFx5XcVQZpkeMqQYKRzvxndozlzYDFiUEn7valoIAF3QL4LBaIzEHy4jO3S5iE/
2y4M8oTj6jGG2yosq1+f7us3f9t4/jj7Tuiyl5EwGhfabMa7EXxnWtk9hhLnzD5X
YnO4LxPXpedjAZZ+5038lCg2WeXxyyQG04k+g2CDfGfOezgOtnpPQ5ksH2/UJ7T6
qJ0G1+EW1hRjctcLOvi4pUabrmA/eFnTOSdPw58TKHfEpQ4oZHACKB6m90KB5y+n
gMRC+nfmpUr27eGLamub4Ge+5XddeEbD0BF8oG/agRVr9hf8TSspxf7g0ive27yl
Vihe8uAWo8/61JNFKwvOq7TT14k/9KPg+xDk5/qkGiiXRQNR6UM=
=xo/V
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--

