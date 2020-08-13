Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE1FDC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 10:46:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98089204FD
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 10:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="nUnB59lW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98089204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6Akc-0001Mb-L9
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 06:46:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52682)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k6AjU-00082V-V0; Thu, 13 Aug 2020 06:45:16 -0400
Received: from ozlabs.org ([203.11.71.1]:33445)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k6AjS-0008Jp-M8; Thu, 13 Aug 2020 06:45:16 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BS39y41rsz9sTR; Thu, 13 Aug 2020 20:45:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1597315510;
 bh=/bXoBlkPuEm94NqSDycJy5YpVdtBp66SCanUyBKWwfE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nUnB59lWXKqAXRE16poKQnzZNcCUDsoEUQDNvQjc2lDy5pEI+LJKPbpQD/Nz17zVo
 MsmBoqB6yvX+pI57Yk3I3PQBm0QfIp4zzROCGqEIxpl/+fzEHDYEyel8viSTyoye8S
 T/NtjnmyGWr/0D5OpFyz4Lbo8JqMT3pPR2+cm/go=
Date: Thu, 13 Aug 2020 20:22:34 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 05/14] spapr/xive: Rework error handling of
 kvmppc_xive_cpu_[gs]et_state()
Message-ID: <20200813102234.GH181791@yekko.fritz.box>
References: <159707843034.1489912.1082061742626355958.stgit@bahia.lan>
 <159707846665.1489912.14267225652103441921.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="oyqLL/JqMvClXZi1"
Content-Disposition: inline
In-Reply-To: <159707846665.1489912.14267225652103441921.stgit@bahia.lan>
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


--oyqLL/JqMvClXZi1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2020 at 06:54:26PM +0200, Greg Kurz wrote:
> kvm_set_one_reg() returns a negative errno on failure, use that instead
> of errno. Also propagate it to callers so they can use it to check
> for failures and hopefully get rid of their local_err boilerplate.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-5.2.

> ---
>  hw/intc/spapr_xive_kvm.c |   15 ++++++++++-----
>  include/hw/ppc/xive.h    |    4 ++--
>  2 files changed, 12 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
> index b2a36fd59dae..5e088ccbf885 100644
> --- a/hw/intc/spapr_xive_kvm.c
> +++ b/hw/intc/spapr_xive_kvm.c
> @@ -73,7 +73,7 @@ static void kvm_cpu_disable_all(void)
>   * XIVE Thread Interrupt Management context (KVM)
>   */
> =20
> -void kvmppc_xive_cpu_set_state(XiveTCTX *tctx, Error **errp)
> +int kvmppc_xive_cpu_set_state(XiveTCTX *tctx, Error **errp)
>  {
>      SpaprXive *xive =3D SPAPR_XIVE(tctx->xptr);
>      uint64_t state[2];
> @@ -86,13 +86,16 @@ void kvmppc_xive_cpu_set_state(XiveTCTX *tctx, Error =
**errp)
> =20
>      ret =3D kvm_set_one_reg(tctx->cs, KVM_REG_PPC_VP_STATE, state);
>      if (ret !=3D 0) {
> -        error_setg_errno(errp, errno,
> +        error_setg_errno(errp, -ret,
>                           "XIVE: could not restore KVM state of CPU %ld",
>                           kvm_arch_vcpu_id(tctx->cs));
> +        return ret;
>      }
> +
> +    return 0;
>  }
> =20
> -void kvmppc_xive_cpu_get_state(XiveTCTX *tctx, Error **errp)
> +int kvmppc_xive_cpu_get_state(XiveTCTX *tctx, Error **errp)
>  {
>      SpaprXive *xive =3D SPAPR_XIVE(tctx->xptr);
>      uint64_t state[2] =3D { 0 };
> @@ -102,14 +105,16 @@ void kvmppc_xive_cpu_get_state(XiveTCTX *tctx, Erro=
r **errp)
> =20
>      ret =3D kvm_get_one_reg(tctx->cs, KVM_REG_PPC_VP_STATE, state);
>      if (ret !=3D 0) {
> -        error_setg_errno(errp, errno,
> +        error_setg_errno(errp, -ret,
>                           "XIVE: could not capture KVM state of CPU %ld",
>                           kvm_arch_vcpu_id(tctx->cs));
> -        return;
> +        return ret;
>      }
> =20
>      /* word0 and word1 of the OS ring. */
>      *((uint64_t *) &tctx->regs[TM_QW1_OS]) =3D state[0];
> +
> +    return 0;
>  }
> =20
>  typedef struct {
> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> index 2d87ed43728a..785c905357dc 100644
> --- a/include/hw/ppc/xive.h
> +++ b/include/hw/ppc/xive.h
> @@ -489,7 +489,7 @@ int kvmppc_xive_source_reset_one(XiveSource *xsrc, in=
t srcno, Error **errp);
>  void kvmppc_xive_source_set_irq(void *opaque, int srcno, int val);
>  int kvmppc_xive_cpu_connect(XiveTCTX *tctx, Error **errp);
>  void kvmppc_xive_cpu_synchronize_state(XiveTCTX *tctx, Error **errp);
> -void kvmppc_xive_cpu_get_state(XiveTCTX *tctx, Error **errp);
> -void kvmppc_xive_cpu_set_state(XiveTCTX *tctx, Error **errp);
> +int kvmppc_xive_cpu_get_state(XiveTCTX *tctx, Error **errp);
> +int kvmppc_xive_cpu_set_state(XiveTCTX *tctx, Error **errp);
> =20
>  #endif /* PPC_XIVE_H */
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--oyqLL/JqMvClXZi1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl81FGoACgkQbDjKyiDZ
s5IivxAAvJ2Bnuqx7DZm39BEb5eD3PlLp5sY0e1FTVwf6qoYK2/FybW30XGaVM6P
IXS2VA5GDWYpWzi0fBLH2CCjns8ku7uipTt2Kyug74uUT5hmCRei1TDdG9LFp7m4
hCFxteYu9XFKeGxbWbd60pVaykRct5Ou/nANojRdqL1Y8PsUjNSt0FA76XAl55WJ
BR1VTUk7H/+dDLBRK46JK3luQiEK/sQQl8fBfrwE9OSquZqgKNnbML4GDE2OX4Zz
cQteSZG5e1kNZRhUbUu3ZqqyFKG2qZAXZIZoIRcREBmS1g8kYPKvnNP1AuZ19c3f
HNNizeDJeTvdtkqHo06gl/luKL+BNdGkcAda2YNawSm08p4cfFNGjPhnHuKZzBxu
w9p3m5i41wOO/B0mXgtq6R14xT32CWa2jFUPiOZTwtDv+7mZwQFtw94le93UguNj
23khOtxiRbu+2kDzRkAXTT35yuZ+Y20gv6/XVxOqtolgGY4ptV2UtUt1mgUGCPLU
ryhXFD2vmhMnOE0QAzNZfK//QapJgrE4W4txIHgoQYTKOjUw1aFw8ttWDL06YcRl
uwMVuNbK3g91qDBSGzkAaCC3kKgiLqVL2aH4r40o+d/tb1hzyxAqYnWIXaf4s6Gj
YP2U/26kOpx2k6dINcQmQ5EpnZjLYc7wjgj3GkXFDOZ+2AK5iD4=
=HzDg
-----END PGP SIGNATURE-----

--oyqLL/JqMvClXZi1--

