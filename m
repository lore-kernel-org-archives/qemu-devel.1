Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59CC7C433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 11:13:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 276B520791
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 11:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="jEJsHuUA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 276B520791
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6BAv-0005yg-Dt
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 07:13:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58168)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k6B7Y-0000Zh-0O; Thu, 13 Aug 2020 07:10:08 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:37975 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k6B7U-0002o0-8v; Thu, 13 Aug 2020 07:10:07 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BS3kc0H1jz9sTR; Thu, 13 Aug 2020 21:09:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1597317000;
 bh=8DosUNzCJ8A8FTcoLKSqc7mdoPXCurP/3wzGCUzGp5s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jEJsHuUAJFFtwHn74H2zKApGhAX3g4h0I56U5vbF63ZVi9IxBNfVrUN4wJF4N0U08
 lTjFFEJ/n58vddmxJZD5QEk1EXx0Vr2fCE/HoG8EnSsEQGRvAY5u63C0km7OQ0H1TK
 /wponKiK7S/pdUOtxuRfjPeQVTC0Cuke46p95IE0=
Date: Thu, 13 Aug 2020 21:05:41 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 11/14] ppc/xive: Fix error handling in
 vmstate_xive_tctx_*() callbacks
Message-ID: <20200813110541.GB6255@yekko.fritz.box>
References: <159707843034.1489912.1082061742626355958.stgit@bahia.lan>
 <159707850840.1489912.14912810818646455474.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="U+BazGySraz5kW0T"
Content-Disposition: inline
In-Reply-To: <159707850840.1489912.14912810818646455474.stgit@bahia.lan>
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


--U+BazGySraz5kW0T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2020 at 06:55:08PM +0200, Greg Kurz wrote:
> Now that kvmppc_xive_cpu_get_state() and kvmppc_xive_cpu_set_state()
> return negative errnos on failures, use that instead local_err because
> it is the recommended practice. Also return that instead of -1 since
> vmstate expects negative errnos.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-5.2

> ---
>  hw/intc/xive.c |   14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index a453e8f4dcbe..17ca5a1916b4 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -695,12 +695,13 @@ static int vmstate_xive_tctx_pre_save(void *opaque)
>  {
>      XiveTCTX *tctx =3D XIVE_TCTX(opaque);
>      Error *local_err =3D NULL;
> +    int ret;
> =20
>      if (xive_in_kernel(tctx->xptr)) {
> -        kvmppc_xive_cpu_get_state(tctx, &local_err);
> -        if (local_err) {
> +        ret =3D kvmppc_xive_cpu_get_state(tctx, &local_err);
> +        if (ret < 0) {
>              error_report_err(local_err);
> -            return -1;
> +            return ret;
>          }
>      }
> =20
> @@ -711,16 +712,17 @@ static int vmstate_xive_tctx_post_load(void *opaque=
, int version_id)
>  {
>      XiveTCTX *tctx =3D XIVE_TCTX(opaque);
>      Error *local_err =3D NULL;
> +    int ret;
> =20
>      if (xive_in_kernel(tctx->xptr)) {
>          /*
>           * Required for hotplugged CPU, for which the state comes
>           * after all states of the machine.
>           */
> -        kvmppc_xive_cpu_set_state(tctx, &local_err);
> -        if (local_err) {
> +        ret =3D kvmppc_xive_cpu_set_state(tctx, &local_err);
> +        if (ret < 0) {
>              error_report_err(local_err);
> -            return -1;
> +            return ret;
>          }
>      }
> =20
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--U+BazGySraz5kW0T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl81HoUACgkQbDjKyiDZ
s5IBxA/9GcAK/ACnQtF3zR7fvdPxHINUHU5N+oTyuG3zl1M496f7DGONp3D1yWmn
sJUpe15aKxiXRl1/AMMyElyHkKKigPKpbZME4kX4PG1fnuMtPnBhohqf5AAc0Cq3
8kPE/TLXCacAZOkib7O98kguzUvno4u+zFeCsc9uRfdBuH/ITcjYzqNvEWJ7Vz7R
2MRQYvxtJZ+mLu5qwbdQPX3/DjvEnjlWmVKuWdy6zRAVfZU9/RBh5arDKN9QntUu
MR4BvDZpx4WTxnH5a22ype+NL0ATX3Emv8FHjEYM8FSeqJEpXIm/wJwgPXjz7E/+
YjqX+vkOacw0RU0jZpHnxA7vzDFHWipkj5eaATknuXLhxtWcJ03Zw6+JhBjYlg+E
n0siDdgMBVcaGvdNfui3Pw448X9xCIRPnPkRa+l+zwnsf+RRzLNdKLLSGDDnuRgZ
CpIERbud9pXOSRai4NPjf1vexgPn7711rHCCbfRnG4xL8CySVltn6L7gdUG6VCkH
XEw/Ng06qAuLuwc9FK4NKjbSLaH9OKny9JgLz1tODaLm/K5WGmf57gpkTPNbzByX
EbZb7nQe4I3DgjVJMplk+7LEi6gWWccshEMAeBNYmS7KeOxmsLOBbaGid+cZ5SMe
0TfqsKp+MWHHOwKS7eYA8NEn871i5g5W8v15c0FzsDkPBdSaTB4=
=ohq4
-----END PGP SIGNATURE-----

--U+BazGySraz5kW0T--

