Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B1C8C2BA2B
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 02:35:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A32F2072A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 02:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="GrTC6qiE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A32F2072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOBQ1-0007df-IW
	for qemu-devel@archiver.kernel.org; Mon, 13 Apr 2020 22:35:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46744)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jOBMc-0002IH-Pg
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 22:31:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jOBMb-0003WK-GU
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 22:31:50 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:34713 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jOBMb-0003AE-58; Mon, 13 Apr 2020 22:31:49 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 491Tx72pvgz9sT0; Tue, 14 Apr 2020 12:17:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1586831435;
 bh=ImiyRVoNQbOcTp6A/fzUejw3ihwjmxwUHNQzgVijvmI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GrTC6qiENynrCDGBq0ymymSo9xYTnR45lcglilIqAZSXYJEjU9bXyLj4GJsJMYrP8
 2n2XAPSH0bmu0Zg+TqMb95w+KuNUfk0Vr2d2Jp/kfoisApGywgTTn2szR5TEa/4dQy
 emgrsoVXQY70cjlr48J8bMZTe31kGFMWuFHqQLLI=
Date: Tue, 14 Apr 2020 12:01:17 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH] spapr_nvdimm.c: make 'label-size' mandatory
Message-ID: <20200414020117.GB48061@umbus.fritz.box>
References: <20200413203628.31636-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Izn7cH1Com+I3R9J"
Content-Disposition: inline
In-Reply-To: <20200413203628.31636-1-danielhb413@gmail.com>
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
Cc: Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Izn7cH1Com+I3R9J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

CCing Xiao, Michael and Igor for generic NVDIMM perspective.

On Mon, Apr 13, 2020 at 05:36:28PM -0300, Daniel Henrique Barboza wrote:
> The pseries machine does not support NVDIMM modules without label.
> Attempting to do so, even if the overall block size is aligned with
> 256MB, will seg fault the guest kernel during NVDIMM probe. This
> can be avoided by forcing 'label-size' to always be present for
> sPAPR NVDIMMs.
>=20
> The verification was put before the alignment check because the
> presence of label-size affects the alignment calculation, so
> it's not optimal to warn the user about an alignment error,
> then about the lack of label-size, then about a new alignment
> error when the user sets a label-size.
>=20
> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>

So, this would get the job done, but it seems a bit inelegant compared
to having the device default to working settings.  I'm looking at how
this interacts with the generic constraints on label-size.

The generic nvdimm code has a MIN_NAMESPACE_LABEL_SIZE of 128 kiB, and
values of label-size less than that are rejected.  Except that if
label-size is not set at all, it is left as 0.

Is that intended behaviour?  Do x86 (or whatever) NVDIMMs have a label
of at least 128kiB, unless they have no label at all?  Or could we
make the default label-size 128kiB generically?

> ---
>  hw/ppc/spapr_nvdimm.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/hw/ppc/spapr_nvdimm.c b/hw/ppc/spapr_nvdimm.c
> index 25be8082d7..9abcdcc26b 100644
> --- a/hw/ppc/spapr_nvdimm.c
> +++ b/hw/ppc/spapr_nvdimm.c
> @@ -37,6 +37,12 @@ void spapr_nvdimm_validate_opts(NVDIMMDevice *nvdimm, =
uint64_t size,
>      QemuUUID uuid;
>      int ret;
> =20
> +    if (object_property_get_int(OBJECT(nvdimm), NVDIMM_LABEL_SIZE_PROP,
> +                                &error_abort) =3D=3D 0) {
> +        error_setg(errp, "NVDIMM device requires label-size to be set");
> +        return;
> +    }
> +
>      if (size % SPAPR_MINIMUM_SCM_BLOCK_SIZE) {
>          error_setg(errp, "NVDIMM memory size excluding the label area"
>                     " must be a multiple of %" PRIu64 "MB",

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Izn7cH1Com+I3R9J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl6VGWoACgkQbDjKyiDZ
s5JiLxAApB/8Pux+iWIQjEXmFDQeJnlr7c9lDe5mB5zlzsP/N5xGvKe2p0liy6aq
4puwTH7RzFiOg7tVVNcqJkAxBN1YMKQCYG5DPLcq5uAvOX3b1GovePObVglCwNxu
fQR/Dg12BaFQfk8scqTU9m8Uq+Yc3fLaQhxVp0r6+LlaXpgBTxyKja983acHRA1S
Bn3tEMJnpK0TARAxRqfhTgu1yj7+uFvnsNSPC11VKh7jH9uXjIm46MYyYA7rEh6p
Ht9PNF/I478GzyKZogcy//a6Qe9p+ouc7DzhwvEEEwTjGI+e/iss0BHS4Rnm0Wd2
XaWjbmR4T3L2SQnCXfU5Ml5e/RfzOP5DExqiLdPK4XOQ5zRjGWlVR/xFHD/bAd3n
kPjHsF0q/L2PVDuJt8z3c39lvpKNUjKRvRK0a6/YWqNzyk4X3FjcvtLnmi8sIeIM
FJyNl+1CvhnhcNUVI1c+rCz6TDdk9GcCRgV2aDJFl/wsUfjpNObgLH5Z4blfwZ8c
AZh/7hY9pCTfF5T+a9zSLBuodqtEimrUuZnMdioQsojXrjXXrwnE4NLdzXtbJUBm
5E44BdEG7D+hVoIeS9PgXEjrgBXV6WyZFihCAX7xN3DstR6P31NDsw1GcH/ESGB3
sktq3qlhg0gIOe7ceG/neQPFh7cTxtv+VZ0KcPMtXQTCLFASSQE=
=GZCk
-----END PGP SIGNATURE-----

--Izn7cH1Com+I3R9J--

