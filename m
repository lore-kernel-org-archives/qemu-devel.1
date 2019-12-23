Return-Path: <SRS0=AgAn=2N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8007BC2D0D2
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 04:38:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 430DE20709
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 04:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="bmygCael"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 430DE20709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ijFUU-0007Rv-GX
	for qemu-devel@archiver.kernel.org; Sun, 22 Dec 2019 23:38:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55436)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ijFTq-0006v5-OL
 for qemu-devel@nongnu.org; Sun, 22 Dec 2019 23:38:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ijFTp-0008Dn-Ek
 for qemu-devel@nongnu.org; Sun, 22 Dec 2019 23:38:06 -0500
Received: from ozlabs.org ([203.11.71.1]:50997)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ijFTp-00083N-0z; Sun, 22 Dec 2019 23:38:05 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47h66K6vdGz9sPV; Mon, 23 Dec 2019 15:38:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1577075881;
 bh=M952kDt/zb0wKNNnlm/lrAcHnKApdKq3GgYs9CupgEo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bmygCaelKtccGb0dbkH341BYzHZtQPW3FEGx6kOQ1JDuLm75rfqNfsS0vg4P9wdeO
 sYWy46KnkCHRUd15l0aGKwk6oIVfg9CH3BtwvKh26E0dG3VsN4NmsjgZo92vBIGpkI
 yd8n2f6jKZVKKNHlPQp0QW/dLKvb9uLeSiQoXWd0=
Date: Mon, 23 Dec 2019 15:33:39 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Subject: Re: [PATCH v4 2/4] nvdimm: add uuid property to nvdimm
Message-ID: <20191223043339.GB38380@umbus.modem>
References: <157657241446.53829.7078678659499762596.stgit@lep8c.aus.stglabs.ibm.com>
 <157657250781.53829.2713365565241605642.stgit@lep8c.aus.stglabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="2B/JsCI69OhZNC5r"
Content-Disposition: inline
In-Reply-To: <157657250781.53829.2713365565241605642.stgit@lep8c.aus.stglabs.ibm.com>
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


--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2019 at 02:48:49AM -0600, Shivaprasad G Bhat wrote:
> For ppc64, PAPR requires the nvdimm device to have UUID property
> set in the device tree. Add an option to get it from the user.
>=20
> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/mem/nvdimm.c         |   40 ++++++++++++++++++++++++++++++++++++++++
>  include/hw/mem/nvdimm.h |    7 +++++++
>  2 files changed, 47 insertions(+)
>=20
> diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
> index 375f9a588a..e1238b5bed 100644
> --- a/hw/mem/nvdimm.c
> +++ b/hw/mem/nvdimm.c
> @@ -69,11 +69,51 @@ out:
>      error_propagate(errp, local_err);
>  }
> =20
> +static void nvdimm_get_uuid(Object *obj, Visitor *v, const char *name,
> +                                  void *opaque, Error **errp)
> +{
> +    NVDIMMDevice *nvdimm =3D NVDIMM(obj);
> +    char *value =3D NULL;
> +
> +    value =3D qemu_uuid_unparse_strdup(&nvdimm->uuid);
> +
> +    visit_type_str(v, name, &value, errp);
> +    g_free(value);
> +}
> +
> +
> +static void nvdimm_set_uuid(Object *obj, Visitor *v, const char *name,
> +                                  void *opaque, Error **errp)
> +{
> +    NVDIMMDevice *nvdimm =3D NVDIMM(obj);
> +    Error *local_err =3D NULL;
> +    char *value;
> +
> +    visit_type_str(v, name, &value, &local_err);
> +    if (local_err) {
> +        goto out;
> +    }
> +
> +    if (qemu_uuid_parse(value, &nvdimm->uuid) !=3D 0) {
> +        error_setg(errp, "Property '%s.%s' has invalid value",
> +                   object_get_typename(obj), name);
> +        goto out;
> +    }
> +    g_free(value);
> +
> +out:
> +    error_propagate(errp, local_err);
> +}
> +
> +
>  static void nvdimm_init(Object *obj)
>  {
>      object_property_add(obj, NVDIMM_LABEL_SIZE_PROP, "int",
>                          nvdimm_get_label_size, nvdimm_set_label_size, NU=
LL,
>                          NULL, NULL);
> +
> +    object_property_add(obj, NVDIMM_UUID_PROP, "QemuUUID", nvdimm_get_uu=
id,
> +                        nvdimm_set_uuid, NULL, NULL, NULL);
>  }
> =20
>  static void nvdimm_finalize(Object *obj)
> diff --git a/include/hw/mem/nvdimm.h b/include/hw/mem/nvdimm.h
> index 523a9b3d4a..4807ca615b 100644
> --- a/include/hw/mem/nvdimm.h
> +++ b/include/hw/mem/nvdimm.h
> @@ -25,6 +25,7 @@
> =20
>  #include "hw/mem/pc-dimm.h"
>  #include "hw/acpi/bios-linker-loader.h"
> +#include "qemu/uuid.h"
> =20
>  #define NVDIMM_DEBUG 0
>  #define nvdimm_debug(fmt, ...)                                \
> @@ -49,6 +50,7 @@
>                                                 TYPE_NVDIMM)
> =20
>  #define NVDIMM_LABEL_SIZE_PROP "label-size"
> +#define NVDIMM_UUID_PROP       "uuid"
>  #define NVDIMM_UNARMED_PROP    "unarmed"
> =20
>  struct NVDIMMDevice {
> @@ -83,6 +85,11 @@ struct NVDIMMDevice {
>       * the guest write persistence.
>       */
>      bool unarmed;
> +
> +    /*
> +     * The PPC64 - spapr requires each nvdimm device have a uuid.
> +     */
> +    QemuUUID uuid;
>  };
>  typedef struct NVDIMMDevice NVDIMMDevice;
> =20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--2B/JsCI69OhZNC5r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4AQ6MACgkQbDjKyiDZ
s5K57g//Wi88/k4aBTdHD2ElF3JS+JODUPOpkfk1noX+KgEmdgWFb7dSdC6AApTt
C1keFbstAht+ZLmf3wbow7bSQ4eV1pfTOtDoL2b8W0vT/uw4bF50V5rcjf2rRyTn
OYYn4rFzhXUrNib+0VnRindx6MTgIBFFlOSYwcJ9sRXmxMRpp3bInxj/veT4aPfG
e7/1U8jc4v8T/j9C9DMLyd582vRUFbGtmW1Q4EwXsoN4hd2PH4mxqkb20K4m/9Ra
KV2aP8r6TyWvk6yOVrdJ3HOjFz23sv5mE8GWog3qukq8CY483HJ2aMKj0InT1+hp
C2/+ZrxlAAs2Os8pug3TpQ5ZmE6yLjm/4hoeelNnJaRc7r/Cy/sSAt6vHBr3/JBt
quP/9Ld2JiKKGppVK9JHzuY7EDPX2Hiyyx3w4iVvomNtvtXxzjvrzpL2/megFX/X
k6Vm7KTinGL/FjHmzcl7PQYQ6yB3374LUBQh0HZnLv02oOdzZRekZncEuia9KTmX
2XCQTaPGFuoyi3dlZLtDcXvnnTpwwKS2oGH9b26jzNZKlhIlIlrj2vdr1URL/6vM
B+ZNDKrIAs8K4QWKnLpXnrSOU+xh0oWoDje0Jd4Bc2F+GgCthm7ty6becpGu41BQ
pzck3X0jiz3j0Ddon2fl5chbXBX9Y/8d1zxE391mQ92ab5PgXIM=
=sVBF
-----END PGP SIGNATURE-----

--2B/JsCI69OhZNC5r--

