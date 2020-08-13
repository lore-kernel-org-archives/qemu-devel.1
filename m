Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35BC7C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 11:14:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05A5620885
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 11:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="pOAZH03o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05A5620885
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6BCD-0008DR-9s
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 07:14:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58170)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k6B7Y-0000Zk-2U; Thu, 13 Aug 2020 07:10:08 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:40959)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k6B7U-0002nx-6y; Thu, 13 Aug 2020 07:10:07 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BS3kc11Mkz9sTT; Thu, 13 Aug 2020 21:10:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1597317000;
 bh=TNsVMreUKhxaYoEKfG17BuBNdYVdrMJavPFr69Px0jY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pOAZH03oNlwuoPkwOsm7cVK1ZyhhmrhVL0XmS8LlHu7Ch1BPHMcmunAzMIyEMDa3D
 bogVmslia+TyjJUYYKbXBfOlvXN8aGXyfDkCnAH2gA5YJmCC6BlashtcNHuccUXgDb
 TjiutG6/O0L3Zw4fM8NVVVQ7T4b6Wn4P0p7juwFo=
Date: Thu, 13 Aug 2020 21:07:10 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 12/14] spapr/xive: Simplify error handling in
 kvmppc_xive_connect()
Message-ID: <20200813110710.GC6255@yekko.fritz.box>
References: <159707843034.1489912.1082061742626355958.stgit@bahia.lan>
 <159707851537.1489912.1030839306195472651.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Md/poaVZ8hnGTzuv"
Content-Disposition: inline
In-Reply-To: <159707851537.1489912.1030839306195472651.stgit@bahia.lan>
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


--Md/poaVZ8hnGTzuv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2020 at 06:55:15PM +0200, Greg Kurz wrote:
> Now that all these functions return a negative errno on failure, check
> that and get rid of the local_err boilerplate.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-5.2.

> ---
>  hw/intc/spapr_xive_kvm.c |   24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)
>=20
> diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
> index 005729ebffed..e9a36115bed6 100644
> --- a/hw/intc/spapr_xive_kvm.c
> +++ b/hw/intc/spapr_xive_kvm.c
> @@ -723,12 +723,12 @@ int kvmppc_xive_connect(SpaprInterruptController *i=
ntc, uint32_t nr_servers,
>  {
>      SpaprXive *xive =3D SPAPR_XIVE(intc);
>      XiveSource *xsrc =3D &xive->source;
> -    Error *local_err =3D NULL;
>      size_t esb_len =3D xive_source_esb_len(xsrc);
>      size_t tima_len =3D 4ull << TM_SHIFT;
>      CPUState *cs;
>      int fd;
>      void *addr;
> +    int ret;
> =20
>      /*
>       * The KVM XIVE device already in use. This is the case when
> @@ -754,9 +754,10 @@ int kvmppc_xive_connect(SpaprInterruptController *in=
tc, uint32_t nr_servers,
>      /* Tell KVM about the # of VCPUs we may have */
>      if (kvm_device_check_attr(xive->fd, KVM_DEV_XIVE_GRP_CTRL,
>                                KVM_DEV_XIVE_NR_SERVERS)) {
> -        if (kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_CTRL,
> -                              KVM_DEV_XIVE_NR_SERVERS, &nr_servers, true,
> -                              &local_err)) {
> +        ret =3D kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_CTRL,
> +                                KVM_DEV_XIVE_NR_SERVERS, &nr_servers, tr=
ue,
> +                                errp);
> +        if (ret < 0) {
>              goto fail;
>          }
>      }
> @@ -764,8 +765,7 @@ int kvmppc_xive_connect(SpaprInterruptController *int=
c, uint32_t nr_servers,
>      /*
>       * 1. Source ESB pages - KVM mapping
>       */
> -    addr =3D kvmppc_xive_mmap(xive, KVM_XIVE_ESB_PAGE_OFFSET, esb_len,
> -                            &local_err);
> +    addr =3D kvmppc_xive_mmap(xive, KVM_XIVE_ESB_PAGE_OFFSET, esb_len, e=
rrp);
>      if (addr =3D=3D MAP_FAILED) {
>          goto fail;
>      }
> @@ -783,8 +783,7 @@ int kvmppc_xive_connect(SpaprInterruptController *int=
c, uint32_t nr_servers,
>      /*
>       * 3. TIMA pages - KVM mapping
>       */
> -    addr =3D kvmppc_xive_mmap(xive, KVM_XIVE_TIMA_PAGE_OFFSET, tima_len,
> -                            &local_err);
> +    addr =3D kvmppc_xive_mmap(xive, KVM_XIVE_TIMA_PAGE_OFFSET, tima_len,=
 errp);
>      if (addr =3D=3D MAP_FAILED) {
>          goto fail;
>      }
> @@ -802,15 +801,15 @@ int kvmppc_xive_connect(SpaprInterruptController *i=
ntc, uint32_t nr_servers,
>      CPU_FOREACH(cs) {
>          PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> =20
> -        kvmppc_xive_cpu_connect(spapr_cpu_state(cpu)->tctx, &local_err);
> -        if (local_err) {
> +        ret =3D kvmppc_xive_cpu_connect(spapr_cpu_state(cpu)->tctx, errp=
);
> +        if (ret < 0) {
>              goto fail;
>          }
>      }
> =20
>      /* Update the KVM sources */
> -    kvmppc_xive_source_reset(xsrc, &local_err);
> -    if (local_err) {
> +    ret =3D kvmppc_xive_source_reset(xsrc, errp);
> +    if (ret < 0) {
>          goto fail;
>      }
> =20
> @@ -820,7 +819,6 @@ int kvmppc_xive_connect(SpaprInterruptController *int=
c, uint32_t nr_servers,
>      return 0;
> =20
>  fail:
> -    error_propagate(errp, local_err);
>      kvmppc_xive_disconnect(intc);
>      return -1;
>  }
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Md/poaVZ8hnGTzuv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl81Ht4ACgkQbDjKyiDZ
s5Itsw/7B1caYLQBqVDfipT7Hw1ZttKIas6UzjuALJ6keexuaSwoA8bgHVcjb1Zj
ddLHGOrvUF7liA2/GnwKydMm+U8i2Sq6m3Fw9kK6VTRc91bJHb4IFBofGWLq6lRV
jLXue6RFWFxHiH+UMggY7LgmulDF19qYrjWQJqNo29RkwDYT58eO0KR4sYpKW/kW
oZq6YZo9VLRuu0yNOkcw/T60ylki/BT1+iTIe3jkgn77+yCvDsuGeoUw2eYLoEpw
mdPgJLjhmOlTshz94ID1uROY+xIObKVFNzd+8+CIa7jbRxGB+qUeEsCBkyGM2l+0
1HwVNE5azeYtvUDtyijRy0AQb1gsV+AVhYJLbOWmlGJc6N8F7whoe8yIjcWZbDqJ
lnKKKaW7iJehC1525nMBms274fcl71WC3PqAYDwJFTN6L7mr9WYpYme6MhPIVPru
B/jHl1SWCpP6tPJeMCia2UJ1QjsPVbHoy2lSRvd9eLn6fCYRz8kUn6REmL0YBScu
TwICIShRRKG7mGydQnq7ZHgfQRv9PV3u98ukxgSWbkCgyDEBo04FEmd0DqgjFKxc
PgmoY6P7IX6BXDHHy+d1wQOikoSkO7HIn1UXx8NQ1wuSs7zyl6VgJ0qzziJkhkL2
UrVKgN0erjU8T4FbMn6JW+PkYaMS7g+Ecwp2Z+nQejIQFPyUNEQ=
=4HAL
-----END PGP SIGNATURE-----

--Md/poaVZ8hnGTzuv--

