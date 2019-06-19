Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 237DAC31E49
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 09:59:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3CBE21479
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 09:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="GfuO00Dg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3CBE21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36406 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdXNA-0007xk-6R
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 05:59:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43345)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hdXDt-0006Dj-TR
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 05:49:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hdXDs-0000ic-0i
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 05:49:45 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:42041)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hdXDr-0000XV-6r; Wed, 19 Jun 2019 05:49:43 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45TKt04tzYz9sN6; Wed, 19 Jun 2019 19:49:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1560937768;
 bh=nK/PBjuD9WusF/TZurkj1Si+KZxJlR4UdJ87a8XgLlE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GfuO00Dg1SZa9SO5KPO6f+aQru54o3YntxhSJ9XLGlBD470kIGHwcf2oVe/f0b8sZ
 x7MHUr+S3d2v1Qg26UiFN0iAEu3fADZkh/wiLW7hHCSHKdnF+OWId0i67DyRdpsE0v
 kz0DqKZ1GSdfyfOPl5/fYLRTPDzEC+XKGfjf6Qww=
Date: Wed, 19 Jun 2019 19:36:17 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Message-ID: <20190619093617.GC22560@umbus.BigPond>
References: <156070574343.343123.16772707632470400458.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="L6iaP+gRLNZHKoI4"
Content-Disposition: inline
In-Reply-To: <156070574343.343123.16772707632470400458.stgit@bahia.lan>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH] spapr/xive: Add proper rollback to
 kvmppc_xive_connect()
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


--L6iaP+gRLNZHKoI4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 16, 2019 at 07:22:23PM +0200, Greg Kurz wrote:
> Make kvmppc_xive_disconnect() able to undo the changes of a partial
> execution of kvmppc_xive_connect() and use it to perform rollback.
>=20
> Based-on: <20190614165920.12670-2-clg@kaod.org>
> Signed-off-by: Greg Kurz <groug@kaod.org>

I'm afraid this doesn't apply clean on my current ppc-for-4.1.

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

--L6iaP+gRLNZHKoI4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0KAggACgkQbDjKyiDZ
s5L9+g//YT+V08tuMdLS7OF+A2xO7WVvvR8SeOw/b5FhkDz8Q+uLN2ZBlU8c7tJd
qvMJoxRDpwdJX7rOPpyZ6AzXSbiUnZEDjRgC2O85HgTxleE413HbsvIYlnGbLnMe
CU/7vY+TSyRYeHzo7aEULoR95gCg6lenQuyNMH12krIWnHv+ebDH3oRs5OXhIkrj
3BBaUqfl/4thLn9rsg2a2cR5HV2L8sA7rlEWcuRuzD8zhUclA3O6gbZ9lT5U7J1j
4RdYOyxIYHQyq58E7ocZyunCgzHGVofVvO3ViN3Z2G/FCG9pCTGjP5EU8Jdnu1/h
sX/dSmGY0QXc4i62WeWb9+VLZnUle8mOJBM4WM6kZVaLJgXFP5aUUJznPipuEaYu
SQY99BivMjkSC0NpLN3sE3K3hsnWfS3Nt2GUEW079mJ1gG3OxOxUnoccP2xyQAfu
UZ6FdWHlV0EhP+/aJARPTTNW+caR6d26gNbWZJF11U02gZkA9f/F0Gaod7u/xeSz
773JAlMXslvZRxJiB/QeCiz1ZDdJDrt9Ok1KeLg4F2oox+JFL6SPFCky2dJA8Q9M
BgtBIql8TlMyag89k2O54mpxZaBaB0sPgbrF5FIqoAffB7cohsj1x8PLUDQZyH1/
gD2UTlrEFngmlJHeonIsgY3ti546KijwcvpruRbhbmqiH5Lb/J8=
=ijaC
-----END PGP SIGNATURE-----

--L6iaP+gRLNZHKoI4--

