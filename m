Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5085C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 10:49:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B1F720866
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 10:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="jdric6SD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B1F720866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6Anc-00071g-Ri
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 06:49:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k6Aja-0008CI-Rh; Thu, 13 Aug 2020 06:45:22 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:48365 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k6AjY-0008MC-NS; Thu, 13 Aug 2020 06:45:22 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BS39y6KCyz9sTh; Thu, 13 Aug 2020 20:45:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1597315510;
 bh=vTuhJcwd3n6xHyJID96sVvRGUlCacSW3VOZcuIF6V/k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jdric6SD9LVRi6B6G9Mh6WJEQB7D+HwxyztDXNcXFJYLSt307YRg7lmmzSiRxWpCU
 prIp4X7c9rytIRjLVMaH8fwhLosT3MHjDvvr6jp+HnkuywdT8sfds0i7t7bg+CbAPm
 VHo/0th33A4VnNB9jlB2SaGU37m5Hc1z+oPSC2QE=
Date: Thu, 13 Aug 2020 20:25:14 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 08/14] spapr/xive: Rework error handling of
 kvmppc_xive_set_source_config()
Message-ID: <20200813102514.GK181791@yekko.fritz.box>
References: <159707843034.1489912.1082061742626355958.stgit@bahia.lan>
 <159707848764.1489912.17078842252160674523.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="d6d1KVhp94hk3Jrm"
Content-Disposition: inline
In-Reply-To: <159707848764.1489912.17078842252160674523.stgit@bahia.lan>
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


--d6d1KVhp94hk3Jrm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2020 at 06:54:47PM +0200, Greg Kurz wrote:
> Since kvm_device_access() returns a negative errno on failure, convert
> kvmppc_xive_set_source_config() to use it for error checking. This allows
> to get rid of the local_err boilerplate.
>=20
> Propagate the return value so that callers may use it as well to check
> failures.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-5.2.

> ---
>  hw/intc/spapr_xive_kvm.c    |   13 ++++---------
>  include/hw/ppc/spapr_xive.h |    4 ++--
>  2 files changed, 6 insertions(+), 11 deletions(-)
>=20
> diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
> index 4142aaffff47..f2dda692183b 100644
> --- a/hw/intc/spapr_xive_kvm.c
> +++ b/hw/intc/spapr_xive_kvm.c
> @@ -186,8 +186,8 @@ int kvmppc_xive_cpu_connect(XiveTCTX *tctx, Error **e=
rrp)
>   * XIVE Interrupt Source (KVM)
>   */
> =20
> -void kvmppc_xive_set_source_config(SpaprXive *xive, uint32_t lisn, XiveE=
AS *eas,
> -                                   Error **errp)
> +int kvmppc_xive_set_source_config(SpaprXive *xive, uint32_t lisn, XiveEA=
S *eas,
> +                                  Error **errp)
>  {
>      uint32_t end_idx;
>      uint32_t end_blk;
> @@ -196,7 +196,6 @@ void kvmppc_xive_set_source_config(SpaprXive *xive, u=
int32_t lisn, XiveEAS *eas,
>      bool masked;
>      uint32_t eisn;
>      uint64_t kvm_src;
> -    Error *local_err =3D NULL;
> =20
>      assert(xive_eas_is_valid(eas));
> =20
> @@ -216,12 +215,8 @@ void kvmppc_xive_set_source_config(SpaprXive *xive, =
uint32_t lisn, XiveEAS *eas,
>      kvm_src |=3D ((uint64_t)eisn << KVM_XIVE_SOURCE_EISN_SHIFT) &
>          KVM_XIVE_SOURCE_EISN_MASK;
> =20
> -    kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_SOURCE_CONFIG, lisn,
> -                      &kvm_src, true, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> -        return;
> -    }
> +    return kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_SOURCE_CONFIG, l=
isn,
> +                             &kvm_src, true, errp);
>  }
> =20
>  void kvmppc_xive_sync_source(SpaprXive *xive, uint32_t lisn, Error **err=
p)
> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
> index d0a08b618f79..0ffbe0be0280 100644
> --- a/include/hw/ppc/spapr_xive.h
> +++ b/include/hw/ppc/spapr_xive.h
> @@ -80,8 +80,8 @@ int kvmppc_xive_connect(SpaprInterruptController *intc,=
 uint32_t nr_servers,
>                          Error **errp);
>  void kvmppc_xive_disconnect(SpaprInterruptController *intc);
>  void kvmppc_xive_reset(SpaprXive *xive, Error **errp);
> -void kvmppc_xive_set_source_config(SpaprXive *xive, uint32_t lisn, XiveE=
AS *eas,
> -                                   Error **errp);
> +int kvmppc_xive_set_source_config(SpaprXive *xive, uint32_t lisn, XiveEA=
S *eas,
> +                                  Error **errp);
>  void kvmppc_xive_sync_source(SpaprXive *xive, uint32_t lisn, Error **err=
p);
>  uint64_t kvmppc_xive_esb_rw(XiveSource *xsrc, int srcno, uint32_t offset,
>                              uint64_t data, bool write);
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--d6d1KVhp94hk3Jrm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl81FQoACgkQbDjKyiDZ
s5JLmQ//dp9CQfY93cVr3xa8E9Th8NznAaTdS1EUZou/7Zfa8MMTmSLWkuANPsg7
TnslPZ6iXXiVLbHPjLZ2YksvqOwtV0DvsV5aNk5Yjq6kp1PZUs3Lzv5xruESucsq
wUYuKR5+p59gEp43ku0eXZB3Wk42lUdWdQaVOt/LlQWATS0Odt1SWFOfjtlZYuar
3icQRB+ItuOQqEhnkUme/qr6GwxprfwM9n6gxfA567wtAteeePllR/erMYwwjl9v
UD5rwDCk93mulePCWdJB+wgBxZ4DVEHEQYlckPfFa0nFAOWYvUJlEjTig8b71c9J
q72HC27jFk+gyyGHg9R2iYC4qzGe2ci6XPbUku7O4CpvOpJC1SDH2AEsKB9V+lUg
pMGGIN7SpS/FVkFrsRaFmEJoeFvR++82MXgdZJcURuvPfwNFOXGS0WmGowHBvmb3
ZGZCuCMH7pk+KcCm0aISxAETHnp2YQ4y3LDAQUVg1eKL2pTdDBZgQk9rqzso6XEP
kvgSa2Q0w+KZrlgzRjNsfXzEzQ/mTKadXGdcJ5l0i4oA1HpEqrJ0oeKguzwrjq8z
auNdNcdmDVxBlqFsdkMpO13sNurfNgBafUDFOyJ1GN4cfAJN5vcW2qd+nuniAhlb
xBqKMAhkkMVlYG2Y7zOtcfgL0W+vvsDcIObxtpPQ1ZMhX+XJdPA=
=2I2W
-----END PGP SIGNATURE-----

--d6d1KVhp94hk3Jrm--

