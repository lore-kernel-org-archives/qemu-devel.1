Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 464ABC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 10:48:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1309620781
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 10:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="aEu+OL3t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1309620781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6AmJ-000494-Bb
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 06:48:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52718)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k6AjW-00082l-Bf; Thu, 13 Aug 2020 06:45:18 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:43099 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k6AjT-0008Jq-FG; Thu, 13 Aug 2020 06:45:18 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BS39y4ktCz9sTY; Thu, 13 Aug 2020 20:45:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1597315510;
 bh=aknzG+GCuZMGFKx/m19Qd6/68FNE29h5IhEnSP0qz3w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=aEu+OL3tl414bePGXh+jhu66YfKZMWA4LZ+RCiIJZdtw0bqbYNEoyxwkUYwwz/H/Q
 lp+s+Qd/G4yny+dNW78Ypk6r4mjTudp/LbG/1k0TlYXcqarhB5+CEj/GXxitu7W/9g
 Z4G8mu0JwCYClbFd9C41STHiZCmwq/T9wm/x8gCY=
Date: Thu, 13 Aug 2020 20:23:49 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 06/14] spapr/xive: Rework error handling of
 kvmppc_xive_[gs]et_queue_config()
Message-ID: <20200813102349.GI181791@yekko.fritz.box>
References: <159707843034.1489912.1082061742626355958.stgit@bahia.lan>
 <159707847357.1489912.2032291280645236480.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="TKDEsImF70pdVIl+"
Content-Disposition: inline
In-Reply-To: <159707847357.1489912.2032291280645236480.stgit@bahia.lan>
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


--TKDEsImF70pdVIl+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2020 at 06:54:33PM +0200, Greg Kurz wrote:
> Since kvm_device_access() returns a negative errno on failure, convert
> kvmppc_xive_get_queue_config() and kvmppc_xive_set_queue_config() to
> use it for error checking. This allows to get rid of the local_err
> boilerplate.
>=20
> Propagate the return value so that callers may use it as well to check
> failures.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-5.2.

> ---
>  hw/intc/spapr_xive_kvm.c    |   35 ++++++++++++++++-------------------
>  include/hw/ppc/spapr_xive.h |    4 ++--
>  2 files changed, 18 insertions(+), 21 deletions(-)
>=20
> diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
> index 5e088ccbf885..696623f717b7 100644
> --- a/hw/intc/spapr_xive_kvm.c
> +++ b/hw/intc/spapr_xive_kvm.c
> @@ -374,15 +374,15 @@ void kvmppc_xive_source_set_irq(void *opaque, int s=
rcno, int val)
>  /*
>   * sPAPR XIVE interrupt controller (KVM)
>   */
> -void kvmppc_xive_get_queue_config(SpaprXive *xive, uint8_t end_blk,
> -                                  uint32_t end_idx, XiveEND *end,
> -                                  Error **errp)
> +int kvmppc_xive_get_queue_config(SpaprXive *xive, uint8_t end_blk,
> +                                 uint32_t end_idx, XiveEND *end,
> +                                 Error **errp)
>  {
>      struct kvm_ppc_xive_eq kvm_eq =3D { 0 };
>      uint64_t kvm_eq_idx;
>      uint8_t priority;
>      uint32_t server;
> -    Error *local_err =3D NULL;
> +    int ret;
> =20
>      assert(xive_end_is_valid(end));
> =20
> @@ -394,11 +394,10 @@ void kvmppc_xive_get_queue_config(SpaprXive *xive, =
uint8_t end_blk,
>      kvm_eq_idx |=3D server << KVM_XIVE_EQ_SERVER_SHIFT &
>          KVM_XIVE_EQ_SERVER_MASK;
> =20
> -    kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_EQ_CONFIG, kvm_eq_idx,
> -                      &kvm_eq, false, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> -        return;
> +    ret =3D kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_EQ_CONFIG, kvm_=
eq_idx,
> +                            &kvm_eq, false, errp);
> +    if (ret < 0) {
> +        return ret;
>      }
> =20
>      /*
> @@ -408,17 +407,18 @@ void kvmppc_xive_get_queue_config(SpaprXive *xive, =
uint8_t end_blk,
>       */
>      end->w1 =3D xive_set_field32(END_W1_GENERATION, 0ul, kvm_eq.qtoggle)=
 |
>          xive_set_field32(END_W1_PAGE_OFF, 0ul, kvm_eq.qindex);
> +
> +    return 0;
>  }
> =20
> -void kvmppc_xive_set_queue_config(SpaprXive *xive, uint8_t end_blk,
> -                                  uint32_t end_idx, XiveEND *end,
> -                                  Error **errp)
> +int kvmppc_xive_set_queue_config(SpaprXive *xive, uint8_t end_blk,
> +                                 uint32_t end_idx, XiveEND *end,
> +                                 Error **errp)
>  {
>      struct kvm_ppc_xive_eq kvm_eq =3D { 0 };
>      uint64_t kvm_eq_idx;
>      uint8_t priority;
>      uint32_t server;
> -    Error *local_err =3D NULL;
> =20
>      /*
>       * Build the KVM state from the local END structure.
> @@ -456,12 +456,9 @@ void kvmppc_xive_set_queue_config(SpaprXive *xive, u=
int8_t end_blk,
>      kvm_eq_idx |=3D server << KVM_XIVE_EQ_SERVER_SHIFT &
>          KVM_XIVE_EQ_SERVER_MASK;
> =20
> -    kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_EQ_CONFIG, kvm_eq_idx,
> -                      &kvm_eq, true, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> -        return;
> -    }
> +    return
> +        kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_EQ_CONFIG, kvm_eq_i=
dx,
> +                          &kvm_eq, true, errp);
>  }
> =20
>  void kvmppc_xive_reset(SpaprXive *xive, Error **errp)
> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
> index 93d09d68deb7..d0a08b618f79 100644
> --- a/include/hw/ppc/spapr_xive.h
> +++ b/include/hw/ppc/spapr_xive.h
> @@ -85,10 +85,10 @@ void kvmppc_xive_set_source_config(SpaprXive *xive, u=
int32_t lisn, XiveEAS *eas,
>  void kvmppc_xive_sync_source(SpaprXive *xive, uint32_t lisn, Error **err=
p);
>  uint64_t kvmppc_xive_esb_rw(XiveSource *xsrc, int srcno, uint32_t offset,
>                              uint64_t data, bool write);
> -void kvmppc_xive_set_queue_config(SpaprXive *xive, uint8_t end_blk,
> +int kvmppc_xive_set_queue_config(SpaprXive *xive, uint8_t end_blk,
>                                   uint32_t end_idx, XiveEND *end,
>                                   Error **errp);
> -void kvmppc_xive_get_queue_config(SpaprXive *xive, uint8_t end_blk,
> +int kvmppc_xive_get_queue_config(SpaprXive *xive, uint8_t end_blk,
>                                   uint32_t end_idx, XiveEND *end,
>                                   Error **errp);
>  void kvmppc_xive_synchronize_state(SpaprXive *xive, Error **errp);
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--TKDEsImF70pdVIl+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl81FLUACgkQbDjKyiDZ
s5IL2hAAnyodAsPnhaQ5VVl0zApDpX+qss3HbSW1W5YtHGYC8GyOhOUrA9Ucnu76
9VqsDm7L822fTs3t7RipLGdsXFknE7x8q2/f/Dfba9ihgzJoSpXe8YO6pgsEsQib
z6PltbO6aSiGPNAHU6N3mV01l/9puWH5K5/jBwStdjVnYGGrTP4LQBIZHZhsekQO
nT0CnhXMgYnWCUX54GvLZLxom/dWA+WV8hkG4AP4IvbANj/hP3D+SYpeGZJrnjI3
8JNYwmYkJuX2571hpg6NHPQtj7PxQCv7JPMMIv+GMBvgm0UVbUpQ9KQSXIi59sTc
/PTRVylvfhOn3F4IiR/KlSsSglhtVCB1L1ALtHzFWrSlMJZyzv6cKJWAWoajzFUg
eEay0rtcazw90s20BJCANakMDDsIX4IA8Av1LM2BS32HIXpLE2tkMe7XfzpHq7la
YJZyuqvGpErPEV5zk6/1QJ14xl0EIWMUi1k10ldOWUatG1VNGeueIVcikhG4Wvjh
1nYokzzhhmK7z04cDCobYRY1voKTrkVOvQ8HhDza6IUOJ3fe/hIYBK7jqcI5kQkJ
pGXWGRR9jH/kZEUekyMdGwmkdyUmTwVyZQGt6M9Dy7EpEXv66/+Jk3cT382+uZ+l
AQXVKCnXJmJb/uTBW0OYgor7X1SNA98dz8DYeHMEszp0sFxhOlo=
=MYzy
-----END PGP SIGNATURE-----

--TKDEsImF70pdVIl+--

