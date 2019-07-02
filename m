Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF628C5B578
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 03:04:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA691216C8
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 03:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="bYetACBb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA691216C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi95Q-0001zq-U6
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 23:04:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33922)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hi78a-0002UH-Uq
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 20:59:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hi78Y-0000ie-TJ
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 20:59:12 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:60235)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hi78V-0000h6-GG; Mon, 01 Jul 2019 20:59:09 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45d5Tq6MMSz9s4Y; Tue,  2 Jul 2019 10:58:55 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1562029135;
 bh=pJ2SCeAWY/qqUPzlnpXBCpT9nYH0ePBqfdmY3UTvV3E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bYetACBbFKIiIjaSSnniNyCrrQ8gQqPAz90/8/e+vYwbUax4JLNF3eKvShqPmizg3
 I9z2Wu79fzEOhHO6KX1h4ab5E162h9c57OC9Fcnn1FI9HmOrwnJncZ/5soHHpWwt/4
 4PL9qoqujEuMBH0+DfMUrWX1DW4djYyzQryf2ZMQ=
Date: Tue, 2 Jul 2019 10:11:58 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Message-ID: <20190702001158.GD6779@umbus.fritz.box>
References: <156198735673.293938.7313195993600841641.stgit@bahia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="3Gf/FFewwPeBMqCJ"
Content-Disposition: inline
In-Reply-To: <156198735673.293938.7313195993600841641.stgit@bahia>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [REPOST PATCH for-4.1] spapr/xive: Add proper
 rollback to kvmppc_xive_connect()
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


--3Gf/FFewwPeBMqCJ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 01, 2019 at 03:22:36PM +0200, Greg Kurz wrote:
> Make kvmppc_xive_disconnect() able to undo the changes of a partial
> execution of kvmppc_xive_connect() and use it to perform rollback.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> Reviewed-by: C=E9dric Le Goater <clg@kaod.org>

Applied, thanks.

> ---
>=20
> David,
>=20
> This is the only pending fix for XIVE, rebased on ppc-for-4.1.
>=20
> SHA1 d6923ffa0748af614e7d2c82d6cb76b8078dfaf5
> ---
>  hw/intc/spapr_xive_kvm.c |   48 ++++++++++++++++++++++++++++------------=
------
>  1 file changed, 29 insertions(+), 19 deletions(-)
>=20
> diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
> index 5559f8bce5ef..3bf8e7a20e14 100644
> --- a/hw/intc/spapr_xive_kvm.c
> +++ b/hw/intc/spapr_xive_kvm.c
> @@ -724,8 +724,7 @@ void kvmppc_xive_connect(SpaprXive *xive, Error **err=
p)
>      xsrc->esb_mmap =3D kvmppc_xive_mmap(xive, KVM_XIVE_ESB_PAGE_OFFSET, =
esb_len,
>                                        &local_err);
>      if (local_err) {
> -        error_propagate(errp, local_err);
> -        return;
> +        goto fail;
>      }
> =20
>      memory_region_init_ram_device_ptr(&xsrc->esb_mmio_kvm, OBJECT(xsrc),
> @@ -743,8 +742,7 @@ void kvmppc_xive_connect(SpaprXive *xive, Error **err=
p)
>      xive->tm_mmap =3D kvmppc_xive_mmap(xive, KVM_XIVE_TIMA_PAGE_OFFSET, =
tima_len,
>                                       &local_err);
>      if (local_err) {
> -        error_propagate(errp, local_err);
> -        return;
> +        goto fail;
>      }
>      memory_region_init_ram_device_ptr(&xive->tm_mmio_kvm, OBJECT(xive),
>                                        "xive.tima", tima_len, xive->tm_mm=
ap);
> @@ -760,21 +758,24 @@ void kvmppc_xive_connect(SpaprXive *xive, Error **e=
rrp)
> =20
>          kvmppc_xive_cpu_connect(spapr_cpu_state(cpu)->tctx, &local_err);
>          if (local_err) {
> -            error_propagate(errp, local_err);
> -            return;
> +            goto fail;
>          }
>      }
> =20
>      /* Update the KVM sources */
>      kvmppc_xive_source_reset(xsrc, &local_err);
>      if (local_err) {
> -            error_propagate(errp, local_err);
> -            return;
> +        goto fail;
>      }
> =20
>      kvm_kernel_irqchip =3D true;
>      kvm_msi_via_irqfd_allowed =3D true;
>      kvm_gsi_direct_mapping =3D true;
> +    return;
> +
> +fail:
> +    error_propagate(errp, local_err);
> +    kvmppc_xive_disconnect(xive, NULL);
>  }
> =20
>  void kvmppc_xive_disconnect(SpaprXive *xive, Error **errp)
> @@ -796,23 +797,29 @@ void kvmppc_xive_disconnect(SpaprXive *xive, Error =
**errp)
>      xsrc =3D &xive->source;
>      esb_len =3D (1ull << xsrc->esb_shift) * xsrc->nr_irqs;
> =20
> -    memory_region_del_subregion(&xsrc->esb_mmio, &xsrc->esb_mmio_kvm);
> -    object_unparent(OBJECT(&xsrc->esb_mmio_kvm));
> -    munmap(xsrc->esb_mmap, esb_len);
> -    xsrc->esb_mmap =3D NULL;
> +    if (xsrc->esb_mmap) {
> +        memory_region_del_subregion(&xsrc->esb_mmio, &xsrc->esb_mmio_kvm=
);
> +        object_unparent(OBJECT(&xsrc->esb_mmio_kvm));
> +        munmap(xsrc->esb_mmap, esb_len);
> +        xsrc->esb_mmap =3D NULL;
> +    }
> =20
> -    memory_region_del_subregion(&xive->tm_mmio, &xive->tm_mmio_kvm);
> -    object_unparent(OBJECT(&xive->tm_mmio_kvm));
> -    munmap(xive->tm_mmap, 4ull << TM_SHIFT);
> -    xive->tm_mmap =3D NULL;
> +    if (xive->tm_mmap) {
> +        memory_region_del_subregion(&xive->tm_mmio, &xive->tm_mmio_kvm);
> +        object_unparent(OBJECT(&xive->tm_mmio_kvm));
> +        munmap(xive->tm_mmap, 4ull << TM_SHIFT);
> +        xive->tm_mmap =3D NULL;
> +    }
> =20
>      /*
>       * When the KVM device fd is closed, the KVM device is destroyed
>       * and removed from the list of devices of the VM. The VCPU
>       * presenters are also detached from the device.
>       */
> -    close(xive->fd);
> -    xive->fd =3D -1;
> +    if (xive->fd !=3D -1) {
> +        close(xive->fd);
> +        xive->fd =3D -1;
> +    }
> =20
>      kvm_kernel_irqchip =3D false;
>      kvm_msi_via_irqfd_allowed =3D false;
> @@ -822,5 +829,8 @@ void kvmppc_xive_disconnect(SpaprXive *xive, Error **=
errp)
>      kvm_cpu_disable_all();
> =20
>      /* VM Change state handler is not needed anymore */
> -    qemu_del_vm_change_state_handler(xive->change);
> +    if (xive->change) {
> +        qemu_del_vm_change_state_handler(xive->change);
> +        xive->change =3D NULL;
> +    }
>  }
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--3Gf/FFewwPeBMqCJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0aoU4ACgkQbDjKyiDZ
s5LGeA/9ETGiiIShlgGABbfxrJjnx6TKe5i+7uPrSp8Uv2gmSywq7PByexm4p/u2
+quMJ7J9PXyycPiuqHJNLnlaaVyWOEX/7BqMrrd0LvvadEnwGhEmN2vBU/Fpi8X2
Bse+eEDp8zsHgI/05FLE6pccShrq6cCAXT4UZakATBvbZLP3++znNZAuXsSGyuq2
D26eEFmslkt15VMEINXF2xtb4CmR/ATH3xHb6lzmcz5T27wieVGrkF0F8xGTAdBs
f7g2KorlYe+INAZ/jL0GPPRS3srPrPrOM517PLeby3vdwC47SsO6BQRJdZR46e9Z
SiXTYcueflPBALTQHRkKgg6lFu45xHRmMZUPmr5gVKl6R0mefFksrutisxXa/Rvl
rUYeUahSpkr35G7nlJQDCVhvoU0FqCRiPspr9+GjPO9JsNTx/D1wF+MwyzagvfVV
AvCxQq/jfUaKtET4lOgiyzA9YrzU3mYTSYHnj1glAvuHAV5lF6jcChCZvld0Pdjw
zC96TAPjG8G24AW4Mr7Te23By7FGMish4fFaQCtK3geE0q/ULrbiWq2he0ksDDzk
8+zOzxRj0/9VJ7KvlT+gRERhclTVEnVDS11OsEVbIqb9DtM5Ia3xWzk8u7Y0+bEp
4NdLeYyi34v7VJzsrCsZcspO5EfJV1P0ut1rbYHFSkO3V5MRPFg=
=utKB
-----END PGP SIGNATURE-----

--3Gf/FFewwPeBMqCJ--

