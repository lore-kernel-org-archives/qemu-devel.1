Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 101D1C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 09:38:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC8772078D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 09:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="lHA2NyS5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC8772078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k69hC-0008Fu-4e
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 05:38:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38656)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k69fi-0006WN-1O; Thu, 13 Aug 2020 05:37:18 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:58705 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k69ff-000076-DD; Thu, 13 Aug 2020 05:37:17 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BS1gT1Hzsz9sTH; Thu, 13 Aug 2020 19:37:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1597311429;
 bh=svypqeE3f//Y3EkkbPrMG/E3K/71Jo7VzrLuqxxTaBk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lHA2NyS5ti2qosPwhXW/VXnJpwHRiLhsIyVTzlZk0vWempnTdEzLgwJ3P4+M8Svf4
 OIBvkENsV2+Wkm6wfwwT9ZCGgge8k8SpyN7/aIVnCemA/i1B8oYvBOCVWd5A2/aH/9
 kH5BU8EOqABE4EXC8zFDm/aOxsUTBcn7ZPy0dYyU=
Date: Thu, 13 Aug 2020 17:14:42 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 02/14] spapr/xive: Rework error handling of
 kvmppc_xive_cpu_connect()
Message-ID: <20200813071442.GF17532@yekko.fritz.box>
References: <159707843034.1489912.1082061742626355958.stgit@bahia.lan>
 <159707844549.1489912.4862921680328017645.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="B0nZA57HJSoPbsHY"
Content-Disposition: inline
In-Reply-To: <159707844549.1489912.4862921680328017645.stgit@bahia.lan>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
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


--B0nZA57HJSoPbsHY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2020 at 06:54:05PM +0200, Greg Kurz wrote:
> Use error_setg_errno() instead of error_setg(strerror()). While here,
> use -ret instead of errno since kvm_vcpu_enable_cap() returns a negative
> errno on failure.
>=20
> Use ERRP_GUARD() to ensure that errp can be passed to error_append_hint(),
> and get rid of the local_err boilerplate.
>=20
> Propagate the return value so that callers may use it as well to check
> failures.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-5.2.

> ---
>  hw/intc/spapr_xive_kvm.c |   21 ++++++++++-----------
>  include/hw/ppc/xive.h    |    2 +-
>  2 files changed, 11 insertions(+), 12 deletions(-)
>=20
> diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
> index 82a6f99f022d..aa1a2f915363 100644
> --- a/hw/intc/spapr_xive_kvm.c
> +++ b/hw/intc/spapr_xive_kvm.c
> @@ -144,8 +144,9 @@ void kvmppc_xive_cpu_synchronize_state(XiveTCTX *tctx=
, Error **errp)
>      }
>  }
> =20
> -void kvmppc_xive_cpu_connect(XiveTCTX *tctx, Error **errp)
> +int kvmppc_xive_cpu_connect(XiveTCTX *tctx, Error **errp)
>  {
> +    ERRP_GUARD();
>      SpaprXive *xive =3D SPAPR_XIVE(tctx->xptr);
>      unsigned long vcpu_id;
>      int ret;
> @@ -154,7 +155,7 @@ void kvmppc_xive_cpu_connect(XiveTCTX *tctx, Error **=
errp)
> =20
>      /* Check if CPU was hot unplugged and replugged. */
>      if (kvm_cpu_is_enabled(tctx->cs)) {
> -        return;
> +        return 0;
>      }
> =20
>      vcpu_id =3D kvm_arch_vcpu_id(tctx->cs);
> @@ -162,20 +163,18 @@ void kvmppc_xive_cpu_connect(XiveTCTX *tctx, Error =
**errp)
>      ret =3D kvm_vcpu_enable_cap(tctx->cs, KVM_CAP_PPC_IRQ_XIVE, 0, xive-=
>fd,
>                                vcpu_id, 0);
>      if (ret < 0) {
> -        Error *local_err =3D NULL;
> -
> -        error_setg(&local_err,
> -                   "XIVE: unable to connect CPU%ld to KVM device: %s",
> -                   vcpu_id, strerror(errno));
> -        if (errno =3D=3D ENOSPC) {
> -            error_append_hint(&local_err, "Try -smp maxcpus=3DN with N <=
 %u\n",
> +        error_setg_errno(errp, -ret,
> +                         "XIVE: unable to connect CPU%ld to KVM device",
> +                         vcpu_id);
> +        if (ret =3D=3D -ENOSPC) {
> +            error_append_hint(errp, "Try -smp maxcpus=3DN with N < %u\n",
>                                MACHINE(qdev_get_machine())->smp.max_cpus);
>          }
> -        error_propagate(errp, local_err);
> -        return;
> +        return ret;
>      }
> =20
>      kvm_cpu_enable(tctx->cs);
> +    return 0;
>  }
> =20
>  /*
> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> index 2f3c5af810bb..2d87ed43728a 100644
> --- a/include/hw/ppc/xive.h
> +++ b/include/hw/ppc/xive.h
> @@ -487,7 +487,7 @@ void xive_tctx_ipb_update(XiveTCTX *tctx, uint8_t rin=
g, uint8_t ipb);
> =20
>  int kvmppc_xive_source_reset_one(XiveSource *xsrc, int srcno, Error **er=
rp);
>  void kvmppc_xive_source_set_irq(void *opaque, int srcno, int val);
> -void kvmppc_xive_cpu_connect(XiveTCTX *tctx, Error **errp);
> +int kvmppc_xive_cpu_connect(XiveTCTX *tctx, Error **errp);
>  void kvmppc_xive_cpu_synchronize_state(XiveTCTX *tctx, Error **errp);
>  void kvmppc_xive_cpu_get_state(XiveTCTX *tctx, Error **errp);
>  void kvmppc_xive_cpu_set_state(XiveTCTX *tctx, Error **errp);
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--B0nZA57HJSoPbsHY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl806GIACgkQbDjKyiDZ
s5Ie4xAAh08SeIbOCRxY3zdByUg4smnWp/bUsKdjsHCIGdHi1j/+XWmaDJbWYzyi
GP0XIKIjx7/oln1QYpWF0j0KJJNT5K9Gqp9yJjrF+SIz4mhJ0YeoV5JfL1DnGSdJ
ybCEm4mb05uaG2DF2p99fdwi1OXiBDD6PjDbJ/wHIf0Tcy08WgRn5lPm/i8YD4WZ
swapPLJolFxcfGoamNVBFFZGBQt0EIg6ATTJvNY6/DTmd6i6odLUdV1o7eyGb6p4
Pxmhooe3Bxc8KiuZJvdvVUZsGCXeLQc6iDCUcSNNgP1rt7Bqj1IOg780T4LO7zlf
uzroTEoPDKd5O/QnWu1pDIF+ehyuH7QUnxawkS/Vu/tGUZe8Pv/9z8FzIiHWE0l3
VB8594EiFvbNhetWN7L/MOy/gT7Nipfbv9T62Arl6lhRsXxlaiRqQDEUc4qUBlpt
PVWAutfsudn5xwgVptyzgb3CvZIrTgUMhEJvBHBGc2RaOy9TXnP6AVLYg2/92UWB
GlGd7U6WVeAg+xIEvz6tQh+7fjwC8bE73tK0rHjUnXE4K6WdnMygkFm7brzVZY+5
Yc18lg34hyxF+W/8PclOzwIKwPNSIpDIXyLbe/nHBL5iCq7jIgWG5C+PA0gBwbRt
zXvtSio5OUJp1offEHn4rQok04w2ScZJVKqjYNbSFQc6m/zUk+M=
=ph/y
-----END PGP SIGNATURE-----

--B0nZA57HJSoPbsHY--

