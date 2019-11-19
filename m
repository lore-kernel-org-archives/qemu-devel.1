Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFBDDC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 03:13:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF98F22319
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 03:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="X+3c9WxP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF98F22319
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWtx3-0007nv-Ld
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 22:13:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43074)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iWttA-00031f-MX
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 22:09:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iWtt8-0005a5-8Q
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 22:09:12 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:33835 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iWtt7-0005YQ-F0; Mon, 18 Nov 2019 22:09:10 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47H9lP5lZKz9sPZ; Tue, 19 Nov 2019 14:09:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1574132945;
 bh=e2SLBN2if2Z9PIluek508wuq3qtwUnGhJXrwGSMFxI0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=X+3c9WxPsXihRjRHVTBQrxJXv/0VZo3uLEwZcHRIJeeI+KDQOjP489d09dprGoddB
 It3pvtsBnSa+vpsZJ0tOFyFNrD/jb/okvAoJcajCSJKqS+itPlOs/L5XFdMm4AaR2y
 g+YkddAfE5/ODmxjYcM9QgngPRjMua8Qlh8fBB4w=
Date: Tue, 19 Nov 2019 13:58:01 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Subject: Re: [PATCH v3 1/3] mem: move nvdimm_device_list to utilities
Message-ID: <20191119025801.GP5582@umbus.fritz.box>
References: <157107820388.27733.3565652855304038259.stgit@lep8c.aus.stglabs.ibm.com>
 <157107825148.27733.10924648339824665145.stgit@lep8c.aus.stglabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="FilwpOHBrTVNlmJ3"
Content-Disposition: inline
In-Reply-To: <157107825148.27733.10924648339824665145.stgit@lep8c.aus.stglabs.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
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
Cc: xiaoguangrong.eric@gmail.com, mst@redhat.com, sbhat@linux.vnet.ibm.com,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--FilwpOHBrTVNlmJ3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2019 at 01:37:37PM -0500, Shivaprasad G Bhat wrote:
> nvdimm_device_list is required for parsing the list for devices
> in subsequent patches. Move it to common utility area.
>=20
> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>

LGTM, assuming it's needed in the subsequent patches.  An ack from
NVDIMM people would be nice if I'm to merge it via my tree.

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
> index 41bf59d127..a0f40d26e3 100644
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

--FilwpOHBrTVNlmJ3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3TWjgACgkQbDjKyiDZ
s5If9A//axSFWDWBlYRnc2z9ZbcBGV+E4CVME+ApbidYGlYl0ShaUpWvHbJhSGbL
If3htCSHIvhLPaBWXdX5M70fmssMLFNWXLs23ux/fcDAtjlpYr0ZyRuA48ba47Iw
MADW+qjsloUcaRdWt6K2LHXHGl4LzsQKaNInrcHPKCSaxmIykbPk6a+bGYhmtjiN
g5bz79ZnERYuQigFtNYIbA02AKiKfYZtE99ItzLdAvJ4gomFRNVrzpS1aVF/AjLh
jLx0FDZnQlAjpSKOhZpmmpvAZ51UWL4lGvSVYuBaSQYXLBkIG8MlzBZSTr3qJH+K
ZhE4R31z962UeNHN9PlsDgKtdhGGzXNRqKGkYnr8fFRW018t4a1tTjZNhCuQMVqh
tcMPTCNLg2rQBRhtMm5BE6b0rTl2TwSQpUvsyJrjVMwJi3VlIr2LWL9usvJqT/dZ
mgk9FuwMCZO1BsezJMXtBtbck0g2MQTmKMqmsp/mc7jX3HfuerEzT9UztdApNxit
j9anHaYBXpJ8RwZT05KhrfU7FnZgjB/YqkiK2by2yn7Gu4K87wGznqwVmDvqeWNr
19jegaBgHl0i0D9UGq1CWaE6ktkm02obrLscVHoaVUQmsFy/HNS+47TK3FB53TQg
E4gRk16B90OKtsM1NnVyLM9NTnsKXYcqPtkcDaIcM7C1WMekJrw=
=Rmya
-----END PGP SIGNATURE-----

--FilwpOHBrTVNlmJ3--

