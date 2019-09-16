Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D33BDC49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 05:04:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58E0B206C2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 05:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="cLiyzquc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58E0B206C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9jBk-00087Y-92
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 01:04:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36500)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i9j6L-0005F9-6h
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 00:59:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i9j6J-0001Lp-NW
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 00:59:01 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:40351 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1i9j6J-0001Jj-0l; Mon, 16 Sep 2019 00:58:59 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46WvCg5zzbz9sPw; Mon, 16 Sep 2019 14:58:55 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1568609935;
 bh=wqZXuaRNOQTSUSN4N2Os/bpUmQhNVWpLiascj9OevD0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cLiyzqucFnbxZiz1IzshIhHk7u1gIn9EONVCnBE6oG7nOei3UjSNqDDkTjGU6OYzq
 KkzhkTv6km7fBWxFDFJaGultPH2OuQlKmmwMxwzN01snP7i2sYahHS9HpUrw6OXyad
 vFp5475AdKVxH3kyf1vOugdMgv/bK8i5T0GyAt9s=
Date: Mon, 16 Sep 2019 10:44:32 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Message-ID: <20190916004432.GG2104@umbus.fritz.box>
References: <20190911133937.2716-1-clg@kaod.org>
 <20190911133937.2716-3-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="XRI2XbIfl/05pQwm"
Content-Disposition: inline
In-Reply-To: <20190911133937.2716-3-clg@kaod.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH v2 2/2] spapr/irq: Only claim VALID
 interrupts at the KVM level
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
Cc: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--XRI2XbIfl/05pQwm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2019 at 03:39:37PM +0200, C=E9dric Le Goater wrote:
> A typical pseries VM with 16 vCPUs, one disk, one network adapater
> uses less than 100 interrupts but the whole IRQ number space of the
> QEMU machine is allocated at reset time and it is 8K wide. This is
> wasting a considerable amount of interrupt numbers in the global IRQ
> space which has 1M interrupts per socket on a POWER9.
>=20
> To optimise the HW resources, only request at the KVM level interrupts
> which have been claimed by the guest. This will help to increase the
> maximum number of VMs per system and also help supporting nested guests
> using the XIVE interrupt mode.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied to ppc-for-4.2, thanks.

> ---
>  hw/intc/spapr_xive_kvm.c | 29 ++++++++++++++++++++++++++---
>  hw/intc/xics_kvm.c       |  8 ++++++++
>  2 files changed, 34 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
> index 17af4d19f54e..71b88d7797bc 100644
> --- a/hw/intc/spapr_xive_kvm.c
> +++ b/hw/intc/spapr_xive_kvm.c
> @@ -255,11 +255,16 @@ void kvmppc_xive_source_reset_one(XiveSource *xsrc,=
 int srcno, Error **errp)
> =20
>  static void kvmppc_xive_source_reset(XiveSource *xsrc, Error **errp)
>  {
> +    SpaprXive *xive =3D SPAPR_XIVE(xsrc->xive);
>      int i;
> =20
>      for (i =3D 0; i < xsrc->nr_irqs; i++) {
>          Error *local_err =3D NULL;
> =20
> +        if (!xive_eas_is_valid(&xive->eat[i])) {
> +            continue;
> +        }
> +
>          kvmppc_xive_source_reset_one(xsrc, i, &local_err);
>          if (local_err) {
>              error_propagate(errp, local_err);
> @@ -328,11 +333,18 @@ uint64_t kvmppc_xive_esb_rw(XiveSource *xsrc, int s=
rcno, uint32_t offset,
> =20
>  static void kvmppc_xive_source_get_state(XiveSource *xsrc)
>  {
> +    SpaprXive *xive =3D SPAPR_XIVE(xsrc->xive);
>      int i;
> =20
>      for (i =3D 0; i < xsrc->nr_irqs; i++) {
> +        uint8_t pq;
> +
> +        if (!xive_eas_is_valid(&xive->eat[i])) {
> +            continue;
> +        }
> +
>          /* Perform a load without side effect to retrieve the PQ bits */
> -        uint8_t pq =3D xive_esb_read(xsrc, i, XIVE_ESB_GET);
> +        pq =3D xive_esb_read(xsrc, i, XIVE_ESB_GET);
> =20
>          /* and save PQ locally */
>          xive_source_esb_set(xsrc, i, pq);
> @@ -521,9 +533,14 @@ static void kvmppc_xive_change_state_handler(void *o=
paque, int running,
>       */
>      if (running) {
>          for (i =3D 0; i < xsrc->nr_irqs; i++) {
> -            uint8_t pq =3D xive_source_esb_get(xsrc, i);
> +            uint8_t pq;
>              uint8_t old_pq;
> =20
> +            if (!xive_eas_is_valid(&xive->eat[i])) {
> +                continue;
> +            }
> +
> +            pq =3D xive_source_esb_get(xsrc, i);
>              old_pq =3D xive_esb_read(xsrc, i, XIVE_ESB_SET_PQ_00 + (pq <=
< 8));
> =20
>              /*
> @@ -545,7 +562,13 @@ static void kvmppc_xive_change_state_handler(void *o=
paque, int running,
>       * migration is in progress.
>       */
>      for (i =3D 0; i < xsrc->nr_irqs; i++) {
> -        uint8_t pq =3D xive_esb_read(xsrc, i, XIVE_ESB_GET);
> +        uint8_t pq;
> +
> +        if (!xive_eas_is_valid(&xive->eat[i])) {
> +            continue;
> +        }
> +
> +        pq =3D xive_esb_read(xsrc, i, XIVE_ESB_GET);
> =20
>          /*
>           * PQ is set to PENDING to possibly catch a triggered
> diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
> index a4d2e876cc5f..ba90d6dc966c 100644
> --- a/hw/intc/xics_kvm.c
> +++ b/hw/intc/xics_kvm.c
> @@ -190,6 +190,10 @@ void ics_get_kvm_state(ICSState *ics)
>      for (i =3D 0; i < ics->nr_irqs; i++) {
>          ICSIRQState *irq =3D &ics->irqs[i];
> =20
> +        if (ics_irq_free(ics, i)) {
> +            continue;
> +        }
> +
>          kvm_device_access(kernel_xics_fd, KVM_DEV_XICS_GRP_SOURCES,
>                            i + ics->offset, &state, false, &error_fatal);
> =20
> @@ -301,6 +305,10 @@ int ics_set_kvm_state(ICSState *ics, Error **errp)
>          Error *local_err =3D NULL;
>          int ret;
> =20
> +        if (ics_irq_free(ics, i)) {
> +            continue;
> +        }
> +
>          ret =3D ics_set_kvm_state_one(ics, i, &local_err);
>          if (ret < 0) {
>              error_propagate(errp, local_err);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--XRI2XbIfl/05pQwm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1+2vAACgkQbDjKyiDZ
s5LJUA//QRWbEMFIO+RUChvyUCe02yhZkMIvruVhKuxsMFZWPC5R5KYSCkwnx/94
M1UIthiWAmF43+eDJddU04n48GZN51Z5JWZ6M67GMZuc3rwu0nJ6Ai/mHrmPhsQ/
Ec8If9rr+WynqWuIQxIYxEIiFASdajW+ukuoXX1raTWOFoVSyLOgdDE7PGs1Z6F9
+2c3qHxoFLFoS23IuxPB/GAYpqT/BizNHU7GDoulKKXgcA22F8lmqkgbqpzxNfHe
dktJPFuUTyef+0LwJ7M7z8wuzCdYzmwwy5OGFC3w9pzziFeYOr8Dk9h0ffLwdJJp
wQVe7YFdBMQpmBw0Hqtn8StstufHBlHj03KFbnQ2KOYYzfIx220vDwTEYCwZsDrh
tC1yRqRa5nnQhxdS+4Zdbw3mWl2Yer3ztGWLfpivbgJqVCR3VawovmzIUTLVWTfY
QJaBlTr//5lyQJgWz4qg30IVHPJTXDKL23f2IJ8WAkldzx1QUgJaq0U87a1Eytca
QSH7tfZMxo/TB0BgLS+gJ8CaAoybeMhpQVu5laL5L3BN2wds9N8VbOQSNn0g7xnL
eK1dQegVrdkolWcmJbXT6U4r7SxlOjcp5rUGnN/bZ15VV06tPPLWqnscmIkN/Vhj
rMJg5f8vSc8pK2mjz+qx3CbWLwTAOS2Kx4iASK8gic5JqY55DiQ=
=2zof
-----END PGP SIGNATURE-----

--XRI2XbIfl/05pQwm--

