Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C381C31E45
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 01:53:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06AA620B7C
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 01:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="bNxkA9RT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06AA620B7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46648 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbbPD-00073M-CQ
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 21:53:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56912)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hbbKz-0003Hj-UX
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 21:49:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hbbKy-0003OC-Im
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 21:49:05 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:57351 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hbbKx-0003F1-Eu; Thu, 13 Jun 2019 21:49:04 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45Q3Rt2F0zz9sND; Fri, 14 Jun 2019 11:48:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1560476938;
 bh=LwHnaeIH8uBSmV+oCImOoA2xeM9HHDqHPMim3dUvHAE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bNxkA9RTPR539q40P9PoMmpPDQA/z2cAHm9J0E0gdMVOr4myNKONDpuRQSRXWFYO0
 QEXkKQV2ZBCn2fuN3dBKYmSV1AFvWGGyszuHtoMFsN1PnYLzA0I0AnN7SekIYJQ3rm
 dPB3BvrwlXUyxHrCwGc+tw1n9is79MzQxhH9Ofcw=
Date: Fri, 14 Jun 2019 11:40:00 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Message-ID: <20190614014000.GC11158@umbus.fritz.box>
References: <156044428869.125694.13827513253200184549.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
 <156044430517.125694.6207865998817342638.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="sHrvAb52M6C8blB9"
Content-Disposition: inline
In-Reply-To: <156044430517.125694.6207865998817342638.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH 3/3] xics/spapr: Detect old KVM XICS on
 POWER9 hosts
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


--sHrvAb52M6C8blB9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2019 at 06:45:05PM +0200, Greg Kurz wrote:
> Older KVMs on POWER9 don't support destroying/recreating a KVM XICS
> device, which is required by 'dual' interrupt controller mode. This
> causes QEMU to emit a warning when the guest is rebooted and to fall
> back on XICS emulation:
>=20
> qemu-system-ppc64: warning: kernel_irqchip allowed but unavailable:
>  Error on KVM_CREATE_DEVICE for XICS: File exists
>=20
> If kernel irqchip is required, QEMU will thus exit when the guest is
> first rebooted. Failing QEMU this late may be a painful experience
> for the user.
>=20
> Detect that and exit at machine init instead.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied, thanks.

> ---
>  docs/specs/ppc-spapr-xive.rst |    4 ++--
>  hw/intc/xics_kvm.c            |   30 ++++++++++++++++++++++++++++++
>  hw/ppc/spapr_irq.c            |   13 +++++++++++++
>  include/hw/ppc/xics_spapr.h   |    1 +
>  4 files changed, 46 insertions(+), 2 deletions(-)
>=20
> diff --git a/docs/specs/ppc-spapr-xive.rst b/docs/specs/ppc-spapr-xive.rst
> index 7a64c9d04951..6159bc6eed62 100644
> --- a/docs/specs/ppc-spapr-xive.rst
> +++ b/docs/specs/ppc-spapr-xive.rst
> @@ -142,8 +142,8 @@ xics            XICS KVM       XICS emul.     XICS KVM
>  (3) QEMU fails at CAS with ``Guest requested unavailable interrupt
>      mode (XICS), either don't set the ic-mode machine property or try
>      ic-mode=3Dxics or ic-mode=3Ddual``
> -(4) QEMU/KVM incompatibility due to device destruction in reset. This
> -    needs to be addressed more cleanly with an error.
> +(4) QEMU/KVM incompatibility due to device destruction in reset. QEMU fa=
ils
> +    with ``KVM is too old to support ic-mode=3Ddual,kernel-irqchip=3Don``
> =20
> =20
>  XIVE Device tree properties
> diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
> index 5c4208f43008..c7f8f5edd257 100644
> --- a/hw/intc/xics_kvm.c
> +++ b/hw/intc/xics_kvm.c
> @@ -452,3 +452,33 @@ void xics_kvm_disconnect(SpaprMachineState *spapr, E=
rror **errp)
>      /* Clear the presenter from the VCPUs */
>      kvm_disable_icps();
>  }
> +
> +/*
> + * This is a heuristic to detect older KVMs on POWER9 hosts that don't
> + * support destruction of a KVM XICS device while the VM is running.
> + * Required to start a spapr machine with ic-mode=3Ddual,kernel-irqchip=
=3Don.
> + */
> +bool xics_kvm_has_broken_disconnect(SpaprMachineState *spapr)
> +{
> +    int rc;
> +
> +    rc =3D kvm_create_device(kvm_state, KVM_DEV_TYPE_XICS, false);
> +    if (rc < 0) {
> +        /*
> +         * The error is ignored on purpose. The KVM XICS setup code
> +         * will catch it again anyway. The goal here is to see if
> +         * close() actually destroys the device or not.
> +         */
> +        return false;
> +    }
> +
> +    close(rc);
> +
> +    rc =3D kvm_create_device(kvm_state, KVM_DEV_TYPE_XICS, false);
> +    if (rc >=3D 0) {
> +        close(rc);
> +        return false;
> +    }
> +
> +    return errno =3D=3D EEXIST;
> +}
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index dfb99f35ea00..75654fc67aba 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -669,6 +669,19 @@ static void spapr_irq_check(SpaprMachineState *spapr=
, Error **errp)
>              return;
>          }
>      }
> +
> +    /*
> +     * On a POWER9 host, some older KVM XICS devices cannot be destroyed=
 and
> +     * re-created. Detect that early to avoid QEMU to exit later when the
> +     * guest reboots.
> +     */
> +    if (kvm_enabled() &&
> +        spapr->irq =3D=3D &spapr_irq_dual &&
> +        machine_kernel_irqchip_required(machine) &&
> +        xics_kvm_has_broken_disconnect(spapr)) {
> +        error_setg(errp, "KVM is too old to support ic-mode=3Ddual,kerne=
l-irqchip=3Don");
> +        return;
> +    }
>  }
> =20
>  /*
> diff --git a/include/hw/ppc/xics_spapr.h b/include/hw/ppc/xics_spapr.h
> index 6c1d9ee55945..d968f2499ca7 100644
> --- a/include/hw/ppc/xics_spapr.h
> +++ b/include/hw/ppc/xics_spapr.h
> @@ -35,6 +35,7 @@ void spapr_dt_xics(SpaprMachineState *spapr, uint32_t n=
r_servers, void *fdt,
>                     uint32_t phandle);
>  int xics_kvm_init(SpaprMachineState *spapr, Error **errp);
>  void xics_kvm_disconnect(SpaprMachineState *spapr, Error **errp);
> +bool xics_kvm_has_broken_disconnect(SpaprMachineState *spapr);
>  void xics_spapr_init(SpaprMachineState *spapr);
>  void xics_spapr_connect(SpaprMachineState *spapr);
> =20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--sHrvAb52M6C8blB9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0C+vAACgkQbDjKyiDZ
s5JxMQ/4/dr3ZM3h3p5AIhnM3lm8YS6/6h+wtDdtmjPnqErzlFi5vJk0OdoIb8pP
sX7m9qUt9aJ7x+e8RUmKxH03i7wCcQ6WIC4OfAjBYjYcBR1LdqZcTdA7LIoFMauX
jVMrpBWJFCFjtkLKFdE4vycnfBDQTwSrP437vp937oBOugzpvztAkmlhiUjzmrvq
uIK3ab7x6l1V5nOzkM7wRy0lpWkn72W1Jieok8aVjvR9VjDqmtbpxNVRkhC9hSGp
2cG7UbEvysc8Y4EBYQsUyBau2em4XPqT3s7b9oBWQKWjMslIeolFSwmdgYipqJja
AYt48vijZY8nrNb8Anrkdz9VT6H05vV3B30GByrVeuCcFFZRNdGh8NMoRxDyaftd
KGRZPXiLkkUmmJPKI2G3XXESAkBbc/lwgBkT+gMDOeV5VAfj5mzvG2uincfiwmux
TTzjMZ+WDyOWH/KnHmUzgArgV4eL+auTTA0Um9Ww269rObAiCSbN1YEksUN8Nyx2
K7I+bxHHt+62qh8glAi/fwU+jZ7KUtlbPyStbxL7OyFD1OsSy5imM1+aWa/TgVjk
2d6sKtqAiaKDJe5/7Kr5D7YEFVTbLuQ26wj/HYLCKHgDZc5uEfU1s3e99cOhWqpu
EfO4vAR9HXoWRcNOdUnLG3LchlLGVCgR+AhRgffF9f+YbbPi9A==
=fWAj
-----END PGP SIGNATURE-----

--sHrvAb52M6C8blB9--

