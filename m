Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A53B8C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 10:46:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E5DE204FD
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 10:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="UlLZFLCJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E5DE204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6Akv-000234-K6
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 06:46:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k6AjW-00082m-E5; Thu, 13 Aug 2020 06:45:18 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:49771 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k6AjS-0008Jn-Pg; Thu, 13 Aug 2020 06:45:18 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BS39y0WKVz9sTM; Thu, 13 Aug 2020 20:45:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1597315510;
 bh=6PaY7OjYzqapm+BLBgmKmNyCrXorqjuBpZOaECjrOwg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UlLZFLCJf8R6gKSUYV+pgQDZO7imxi1kCzp23otbwwrE56kp3CkksfS96tpO+hhKa
 T93iz520HxJwLrPY4+zQlZirP4/k8BPK8un7dnXydSyiNvjLJahVNAjdXvLwAvoqbi
 YeAF+X0SAli0YAflayfKYPH3Muin41MtIj5++CNo=
Date: Thu, 13 Aug 2020 20:15:15 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 03/14] spapr/xive: Rework error handling of
 kvmppc_xive_source_reset()
Message-ID: <20200813101515.GF181791@yekko.fritz.box>
References: <159707843034.1489912.1082061742626355958.stgit@bahia.lan>
 <159707845245.1489912.9151822670764690034.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="mrJd9p1Ce66CJMxE"
Content-Disposition: inline
In-Reply-To: <159707845245.1489912.9151822670764690034.stgit@bahia.lan>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 06:45:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-ppc@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--mrJd9p1Ce66CJMxE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2020 at 06:54:12PM +0200, Greg Kurz wrote:
> Since kvmppc_xive_source_reset_one() has a return value, convert
> kvmppc_xive_source_reset() to use it for error checking. This
> allows to get rid of the local_err boiler plate.
>=20
> Propagate the return value so that callers may use it as well to check
> failures.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-5.2.

> ---
>  hw/intc/spapr_xive_kvm.c |   13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
> index aa1a2f915363..d801bf5cd11c 100644
> --- a/hw/intc/spapr_xive_kvm.c
> +++ b/hw/intc/spapr_xive_kvm.c
> @@ -248,24 +248,25 @@ int kvmppc_xive_source_reset_one(XiveSource *xsrc, =
int srcno, Error **errp)
>                               true, errp);
>  }
> =20
> -static void kvmppc_xive_source_reset(XiveSource *xsrc, Error **errp)
> +static int kvmppc_xive_source_reset(XiveSource *xsrc, Error **errp)
>  {
>      SpaprXive *xive =3D SPAPR_XIVE(xsrc->xive);
>      int i;
> =20
>      for (i =3D 0; i < xsrc->nr_irqs; i++) {
> -        Error *local_err =3D NULL;
> +        int ret;
> =20
>          if (!xive_eas_is_valid(&xive->eat[i])) {
>              continue;
>          }
> =20
> -        kvmppc_xive_source_reset_one(xsrc, i, &local_err);
> -        if (local_err) {
> -            error_propagate(errp, local_err);
> -            return;
> +        ret =3D kvmppc_xive_source_reset_one(xsrc, i, errp);
> +        if (ret < 0) {
> +            return ret;
>          }
>      }
> +
> +    return 0;
>  }
> =20
>  /*
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--mrJd9p1Ce66CJMxE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl81ErMACgkQbDjKyiDZ
s5JlcA/+MkURW8J2ut4SWPNCj9IQGxxEGSYKJhfUJ6grberhg333KU+NDposqE5n
8/iqEnXZ/mZpHPZfqn4t6kVysA1F60IDTH4vZy/xOy36HEu2G7C8xF0ujmPAREIr
9uphbB8vpaFgRm0wDi54XaHWDGT5WW20IgVWkoH09viLAVhy24JTH7ZOrbe3EbAq
lQ/oSOLzI4opXNjROSViCg2ajTpKy0kN33FE0GDMm4RC9SXD2QVj5haKTuppWFsw
GwsVbNRimK5RbUiyPeDZ+ISUoVnu2N89CsX/wl5yS728bjssO+naw+CP+/I5hfMx
q+XfrtLM4NrTmRbvM5ogM+toUV7WBymJfuKMaO38CekwwrsDv7/cQxtw1P+4UuRj
BlorFYAgy9xzV8LMJMqhO4uZXzT1OXqLMexTsMZh8NW1MQapRU90cd4KlF9OBj0o
c8R4mFrUqpxl84TklEEA1gJVG0UICwPF0991hqF/Xqz906zmXxMKdZx4TI51S0O0
Fvkw8kN3lD3DJKsMLpkbFJFV6PS1po2254M5KgjLZcheloyNAQ+dK+e7iWWC28w1
JrWLjiOCTFVOHKWbxRomaeX3m8OWxBCI8rTV1Lp8or6G5UGo37AEkHYq3I3BtOg9
BsVOP6TCtnT5VTvFl+MsYt1tPvOZKrifvp/PTkkRbp9IJmH7C+o=
=8yGo
-----END PGP SIGNATURE-----

--mrJd9p1Ce66CJMxE--

