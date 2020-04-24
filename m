Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028CBC2BA19
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 01:47:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C258B20728
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 01:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="fSVigHNd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C258B20728
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRnQx-00050h-Nq
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 21:47:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43526)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jRnPk-00047G-7B
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 21:46:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jRnPh-0005Dc-Uc
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 21:45:59 -0400
Received: from ozlabs.org ([203.11.71.1]:45791)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jRnPf-0004Rz-2M; Thu, 23 Apr 2020 21:45:56 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 497cSj4Hqcz9sSm; Fri, 24 Apr 2020 11:45:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1587692741;
 bh=DwbecEN22V9apyOZL7d/4HzJ0LOORakXWNPtT03M1GA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fSVigHNd3hjKdtXR9ZNHB1rnpfeuXdv7wYpHZJ5sENKQg0xxSwC8VkYR4ST1w8y9g
 4SSvxQ64nHIbr4VBn5V0uP6L1MS2EKZpHgKIkicreu85uvoTaze8RqGRcDdohAwUMZ
 M3EJnJrpW+VNiZOnZCXbq42KUFokRtVINdMVfNbY=
Date: Fri, 24 Apr 2020 11:36:08 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH] spapr_nvdimm.c: make 'label-size' mandatory
Message-ID: <20200424013608.GA121306@umbus.fritz.box>
References: <20200413203628.31636-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
In-Reply-To: <20200413203628.31636-1-danielhb413@gmail.com>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 21:45:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

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

So, I still think it's kind of bogus that the guest side driver falls
over so messily (more on that elswhere in the thread).

However, regardless of that, it does make sense to enforce the PAPR
restriction that all NVDIMMs have labels.  And it fixes the visible
problem with a minimal change.

So, I've applied to ppc-for-5.1.  I am going to update the error
messages a little to make it clearer that these are PAPR specific
restrictions.

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

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl6iQoUACgkQbDjKyiDZ
s5IVPQ//dLKeBkKtgMXNlWXTazmOQSuxQv514dcd99J3SLTbYRvhmSdAJlWCWmLG
S3szrsKNyKZz/G7HLweg8IfucOtPhQROAmLzwqjukPoNA2aTUniwtuD1P3PcvhAs
x8LmSYJViFQU+XEtXBFxb1VArQF76KfsXThuoSsq5xHCoPKn9VEv1skhn7dCzW9j
h8SYAXf9/rjkSxfCCfkz30/QguJJAw4QSZJUTVk9UTTdN21raGsor/ERX/G+pN/Q
/4DIxd/BP0JhEFS+wTMAD4P7cYgUZnK/j2TWM4t9Yq7+eVVLBCI8Zx/RqvQzzBr9
jBy++8sV+mZGigqIujW4MKZ1/+yGTHf8CUtlGp7oubVNE/qH7jKR4FfqqEhrSx1C
ofTfzqC15hY1Fs5hKM61xjqg9uVo36sfGmnHpttiQ9NoGi2LcvQxRswSqn6RPKEm
OniiF5FWt7OX2Mey4jVh+p8j/aFu8TELkADtTb09zBUxWlNmJboF1G+L3n1povtf
d3RtyTKx/LQG5/N/FuIDWKO3thjvOyB446+4ig/PzP1xVmi2p7lmk041SXiEmwzV
QHfo96gl+w4u2X5nM7YWZigmgzEDXG11tGsaPTcOKFyu5+xVPs/S4/OUiaM7zauQ
uGLfrFHTz3wbSjQRA8KSy1YdJ0I86lb2EqRQ2UcmKS6sF7Avjmc=
=GZID
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--

