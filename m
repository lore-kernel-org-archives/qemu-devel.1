Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B846EC3F2CF
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 06:01:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 810AC246A0
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 06:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="P6UPgeYS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 810AC246A0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7Yi4-00027S-MH
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 01:01:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53089)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1j7YhE-0001UH-GR
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 01:00:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1j7YhD-0002zj-9d
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 01:00:24 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:47799 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1j7YhC-0002vt-D4; Fri, 28 Feb 2020 01:00:23 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48TJmF1Nm3z9sRt; Fri, 28 Feb 2020 17:00:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1582869613;
 bh=Qt022AiCv9RultKsKPb2lerzd07doWoe/poeWUUCtNA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=P6UPgeYSdtrD57kM8g+0gJ6dph9mTk8OuQLm5Y8JhEqcQaJ7w2ag2PFcRKGUe84p2
 ElgS/RHrAdEE6ezGGRHDD1GYdBYNg9Dp61wkGQuASt9cLFEmPt1eTj3zQd8L6B4QPy
 pWmSep+aE/M8h+Jsns8QPAug6DMU7VRJ0R6ZOKws=
Date: Fri, 28 Feb 2020 12:05:38 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Subject: Re: [PATCH v2] spapr: Fix Coverity warning while validating nvdimm
 options
Message-ID: <20200228010538.GB1842@umbus.fritz.box>
References: <158281096564.89540.4507375445765515529.stgit@lep8c.aus.stglabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="98e8jtXdkpgskNou"
Content-Disposition: inline
In-Reply-To: <158281096564.89540.4507375445765515529.stgit@lep8c.aus.stglabs.ibm.com>
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
Cc: peter.maydell@linaro.org, groug@kaod.org, qemu-ppc@nongnu.org,
 f4bug@amsat.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--98e8jtXdkpgskNou
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2020 at 07:42:49AM -0600, Shivaprasad G Bhat wrote:
> Fixes Coverity issue,
>       CID 1419883:  Error handling issues  (CHECKED_RETURN)
>            Calling "qemu_uuid_parse" without checking return value
>=20
> nvdimm_set_uuid() already verifies if the user provided uuid is valid or
> not. So, need to check for the validity during pre-plug validation again.
>=20
> As this a false positive in this case, assert if not valid to be safe.
> Also, error_abort if QOM accessor encounters error while fetching the uuid
> property.
>=20
> Reported-by: Coverity (CID 1419883)
> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>

Applied to ppc-for-5.0, thanks.

> ---
>  hw/ppc/spapr_nvdimm.c |    7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_nvdimm.c b/hw/ppc/spapr_nvdimm.c
> index 74eeb8bb74..25be8082d7 100644
> --- a/hw/ppc/spapr_nvdimm.c
> +++ b/hw/ppc/spapr_nvdimm.c
> @@ -35,6 +35,7 @@ void spapr_nvdimm_validate_opts(NVDIMMDevice *nvdimm, u=
int64_t size,
>  {
>      char *uuidstr =3D NULL;
>      QemuUUID uuid;
> +    int ret;
> =20
>      if (size % SPAPR_MINIMUM_SCM_BLOCK_SIZE) {
>          error_setg(errp, "NVDIMM memory size excluding the label area"
> @@ -43,8 +44,10 @@ void spapr_nvdimm_validate_opts(NVDIMMDevice *nvdimm, =
uint64_t size,
>          return;
>      }
> =20
> -    uuidstr =3D object_property_get_str(OBJECT(nvdimm), NVDIMM_UUID_PROP=
, NULL);
> -    qemu_uuid_parse(uuidstr, &uuid);
> +    uuidstr =3D object_property_get_str(OBJECT(nvdimm), NVDIMM_UUID_PROP,
> +                                      &error_abort);
> +    ret =3D qemu_uuid_parse(uuidstr, &uuid);
> +    g_assert(!ret);
>      g_free(uuidstr);
> =20
>      if (qemu_uuid_is_null(&uuid)) {
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--98e8jtXdkpgskNou
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5YZ18ACgkQbDjKyiDZ
s5KtPRAAwMnb1Nr5Fk9Qtp0UFqBFoMkOBzlOtpkmC3c/E8UUaXErRG5RMrlxPmuL
ksp6U8UNwBd2q7dikEro5Aas4HZtkgPyKbbRPN7WIcTaDiVeiZbwRKCypP8fOhmX
zZYESJ9Da7AkYDqg0cnqXpGn043uUhIbvUDNKXwOR9OVrbUd6Tw5cAtyeBJhg1m4
r61xd4xWKOUndwcpHH06KjCjzxUmSNWB2R9KQYZGLORxBJXKOE/3SMCyPtOF6FQS
W1TcJGmfNryueDAol7XprFa1vv/JdFJ/D+8Ytgdf+DL5todgZoOH0jzlx6AGKAt4
3DnUU4ieElNvzVFGyquusZlMYATyvD1fNN8F6hItaompxPdeSeRdtxKB5nCzN/gh
F8kQ6E0GYL3FNHCmrPyxbBHg8cVFw4nUqJRAuspIb+96CgDYaf1YxZnposFUwppa
m6/W/bST5sC0Hyo7Qb0xHTLahjtMq7+9r8NhZI0kQeSfluJ28KNIswlGLSrTAh3P
EHEYgNkqAMYSeQDDTdcxXk0J9T1YBY7ZAl5gezwLfJolFV6mzseyUbibLUueQnfU
ISSefQ9Xrm/psZ4kXwUkghS8sD0Byr8JFKhch6a3gtEEmksfeQ4cS1+sjV0onCeI
/dbNqdueaIX3QB55ZARuswiDZeqyUmwySf7O45RgFMSGCNaMqR0=
=JQyo
-----END PGP SIGNATURE-----

--98e8jtXdkpgskNou--

