Return-Path: <SRS0=AgAn=2N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C54E1C2D0D2
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 04:33:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85985206D3
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 04:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="k1bx7h9Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85985206D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ijFPO-00068C-NS
	for qemu-devel@archiver.kernel.org; Sun, 22 Dec 2019 23:33:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45508)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ijFO3-0004rp-SE
 for qemu-devel@nongnu.org; Sun, 22 Dec 2019 23:32:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ijFO2-0000ft-EV
 for qemu-devel@nongnu.org; Sun, 22 Dec 2019 23:32:07 -0500
Received: from ozlabs.org ([203.11.71.1]:47023)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ijFO1-0000N0-0W; Sun, 22 Dec 2019 23:32:06 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47h5zP6JL9z9sR4; Mon, 23 Dec 2019 15:32:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1577075521;
 bh=rWBh9NATchNjgmyVoTHNjlEx4v4QytYxANno8qT3v4A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=k1bx7h9Y+tdPXMHiZwOOAROG6mdhZwhQHxhNk6TthNMXh9xO3wpBw9sPjUKrsruCI
 dHxQKBmUWg4AvJqsrYolAs4DGI7MERzX9jU8TJIMACBU4YjSFx1dkV4OIfrFOjv2fI
 7A+FzeyNpA8Nu1aZBIyVGC14FazicC9X5doaKs9k=
Date: Mon, 23 Dec 2019 15:31:40 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Subject: Re: [PATCH v4 1/4] mem: move nvdimm_device_list to utilities
Message-ID: <20191223043140.GA38380@umbus.modem>
References: <157657241446.53829.7078678659499762596.stgit@lep8c.aus.stglabs.ibm.com>
 <157657248567.53829.16210727613973616224.stgit@lep8c.aus.stglabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
In-Reply-To: <157657248567.53829.16210727613973616224.stgit@lep8c.aus.stglabs.ibm.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2019 at 02:48:20AM -0600, Shivaprasad G Bhat wrote:
> nvdimm_device_list is required for parsing the list for devices
> in subsequent patches. Move it to common utility area.
>=20
> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/acpi/nvdimm.c            |   28 +---------------------------
>  include/qemu/nvdimm-utils.h |    7 +++++++
>  util/Makefile.objs          |    1 +
>  util/nvdimm-utils.c         |   29 +++++++++++++++++++++++++++++
>  4 files changed, 38 insertions(+), 27 deletions(-)
>  create mode 100644 include/qemu/nvdimm-utils.h
>  create mode 100644 util/nvdimm-utils.c
>=20
> diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
> index 9fdad6dc3f..5219dd0e2e 100644
> --- a/hw/acpi/nvdimm.c
> +++ b/hw/acpi/nvdimm.c
> @@ -32,33 +32,7 @@
>  #include "hw/acpi/bios-linker-loader.h"
>  #include "hw/nvram/fw_cfg.h"
>  #include "hw/mem/nvdimm.h"
> -
> -static int nvdimm_device_list(Object *obj, void *opaque)
> -{
> -    GSList **list =3D opaque;
> -
> -    if (object_dynamic_cast(obj, TYPE_NVDIMM)) {
> -        *list =3D g_slist_append(*list, DEVICE(obj));
> -    }
> -
> -    object_child_foreach(obj, nvdimm_device_list, opaque);
> -    return 0;
> -}
> -
> -/*
> - * inquire NVDIMM devices and link them into the list which is
> - * returned to the caller.
> - *
> - * Note: it is the caller's responsibility to free the list to avoid
> - * memory leak.
> - */
> -static GSList *nvdimm_get_device_list(void)
> -{
> -    GSList *list =3D NULL;
> -
> -    object_child_foreach(qdev_get_machine(), nvdimm_device_list, &list);
> -    return list;
> -}
> +#include "qemu/nvdimm-utils.h"
> =20
>  #define NVDIMM_UUID_LE(a, b, c, d0, d1, d2, d3, d4, d5, d6, d7)         =
    \
>     { (a) & 0xff, ((a) >> 8) & 0xff, ((a) >> 16) & 0xff, ((a) >> 24) & 0x=
ff, \
> diff --git a/include/qemu/nvdimm-utils.h b/include/qemu/nvdimm-utils.h
> new file mode 100644
> index 0000000000..4b8b198ba7
> --- /dev/null
> +++ b/include/qemu/nvdimm-utils.h
> @@ -0,0 +1,7 @@
> +#ifndef NVDIMM_UTILS_H
> +#define NVDIMM_UTILS_H
> +
> +#include "qemu/osdep.h"
> +
> +GSList *nvdimm_get_device_list(void);
> +#endif
> diff --git a/util/Makefile.objs b/util/Makefile.objs
> index df124af1c5..2a096fe190 100644
> --- a/util/Makefile.objs
> +++ b/util/Makefile.objs
> @@ -20,6 +20,7 @@ util-obj-y +=3D envlist.o path.o module.o
>  util-obj-y +=3D host-utils.o
>  util-obj-y +=3D bitmap.o bitops.o hbitmap.o
>  util-obj-y +=3D fifo8.o
> +util-obj-y +=3D nvdimm-utils.o
>  util-obj-y +=3D cacheinfo.o
>  util-obj-y +=3D error.o qemu-error.o
>  util-obj-y +=3D qemu-print.o
> diff --git a/util/nvdimm-utils.c b/util/nvdimm-utils.c
> new file mode 100644
> index 0000000000..5cc768ca47
> --- /dev/null
> +++ b/util/nvdimm-utils.c
> @@ -0,0 +1,29 @@
> +#include "qemu/nvdimm-utils.h"
> +#include "hw/mem/nvdimm.h"
> +
> +static int nvdimm_device_list(Object *obj, void *opaque)
> +{
> +    GSList **list =3D opaque;
> +
> +    if (object_dynamic_cast(obj, TYPE_NVDIMM)) {
> +        *list =3D g_slist_append(*list, DEVICE(obj));
> +    }
> +
> +    object_child_foreach(obj, nvdimm_device_list, opaque);
> +    return 0;
> +}
> +
> +/*
> + * inquire NVDIMM devices and link them into the list which is
> + * returned to the caller.
> + *
> + * Note: it is the caller's responsibility to free the list to avoid
> + * memory leak.
> + */
> +GSList *nvdimm_get_device_list(void)
> +{
> +    GSList *list =3D NULL;
> +
> +    object_child_foreach(qdev_get_machine(), nvdimm_device_list, &list);
> +    return list;
> +}
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4AQywACgkQbDjKyiDZ
s5Ibxw//VUVJTmAX5nFX5Y3cwRCtiey0ZhH9UTPaPV2/N0O/A3YvyPoA5YjdsCpQ
3oCVqZTOayNUQj+IeDePulD+EuEzZ7rc/4sSfltJ9BlpPJonVbbHncZVYb8bxYyY
4hBQZL1qBQYZQHh4KihoPtBnGmgNRFN7tY7OY8ycdcDvFNL5D5qCZmDwTBQmCfIN
oh8EwQmqGuqpAGyDfWvxy3UypY9gyvxNSld1NrVz4yz4YiNtqUhq4P1geZ/jGRxc
CmEyv+GDuL6xXJpVlwTx/uN97uferQH31EXkiiE2rrMxnkpFVN8cqyUGNEllxWoH
tkHx9zw6uhBR3WghJDltk4a5EL28haU1eFwne/0BLcYZW/eXghUx9ZbFaPcZx90Q
78K0Vv9uoCgtvh3cq/aU4POfMcaXbeVMgh5P0cu/4t/Mg1kPlAVe6/yS6d6N1nQt
/L2qHYaN0wNMA74sRhHCMd2kKxbCMBi4aSW6u43IE5vHmOSB3g42d2ji4S66LWWi
Frm9p0vetJIuJ/1HYSth2fIfbltVnqsA4k7leYywsLygZNbPYPyvMjRmSfeEUrl4
frQu9h408xHb5+8Z9fDv5eZnppKUXMQdaOtg3IjnCW08PQmipkMcPFsTafz444Ua
I5WBiNEjEnODoBOmb9PuxkNqxgw/nkreHSuO3zSqOZpgFwAUvAA=
=jIbH
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--

