Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D4AC31E51
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 07:07:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D292620679
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 07:07:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D292620679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54256 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hd8D7-0006iu-42
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 03:07:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48704)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1hd8Bq-0006Bi-Jt
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 03:05:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hd8Bp-0000Gg-ER
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 03:05:58 -0400
Received: from 19.mo5.mail-out.ovh.net ([46.105.35.78]:46373)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hd8Bp-0000FX-77
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 03:05:57 -0400
Received: from player697.ha.ovh.net (unknown [10.108.57.49])
 by mo5.mail-out.ovh.net (Postfix) with ESMTP id 020A422E4AF
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2019 09:05:53 +0200 (CEST)
Received: from kaod.org (lfbn-1-10649-41.w90-89.abo.wanadoo.fr [90.89.235.41])
 (Authenticated sender: clg@kaod.org)
 by player697.ha.ovh.net (Postfix) with ESMTPSA id A82206F740CC;
 Tue, 18 Jun 2019 07:05:48 +0000 (UTC)
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
References: <156070574343.343123.16772707632470400458.stgit@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <ca207131-028e-ea56-47e2-b79956c5b29a@kaod.org>
Date: Tue, 18 Jun 2019 09:05:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <156070574343.343123.16772707632470400458.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 10182920236149934912
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudeikedgudduiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.35.78
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16/06/2019 19:22, Greg Kurz wrote:
> Make kvmppc_xive_disconnect() able to undo the changes of a partial
> execution of kvmppc_xive_connect() and use it to perform rollback.
>=20
> Based-on: <20190614165920.12670-2-clg@kaod.org>
> Signed-off-by: Greg Kurz <groug@kaod.org>


Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.

> ---
>  hw/intc/spapr_xive_kvm.c |   48 ++++++++++++++++++++++++++++----------=
--------
>  1 file changed, 29 insertions(+), 19 deletions(-)
>=20
> diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
> index 5559f8bce5ef..3bf8e7a20e14 100644
> --- a/hw/intc/spapr_xive_kvm.c
> +++ b/hw/intc/spapr_xive_kvm.c
> @@ -724,8 +724,7 @@ void kvmppc_xive_connect(SpaprXive *xive, Error **e=
rrp)
>      xsrc->esb_mmap =3D kvmppc_xive_mmap(xive, KVM_XIVE_ESB_PAGE_OFFSET=
, esb_len,
>                                        &local_err);
>      if (local_err) {
> -        error_propagate(errp, local_err);
> -        return;
> +        goto fail;
>      }
> =20
>      memory_region_init_ram_device_ptr(&xsrc->esb_mmio_kvm, OBJECT(xsrc=
),
> @@ -743,8 +742,7 @@ void kvmppc_xive_connect(SpaprXive *xive, Error **e=
rrp)
>      xive->tm_mmap =3D kvmppc_xive_mmap(xive, KVM_XIVE_TIMA_PAGE_OFFSET=
, tima_len,
>                                       &local_err);
>      if (local_err) {
> -        error_propagate(errp, local_err);
> -        return;
> +        goto fail;
>      }
>      memory_region_init_ram_device_ptr(&xive->tm_mmio_kvm, OBJECT(xive)=
,
>                                        "xive.tima", tima_len, xive->tm_=
mmap);
> @@ -760,21 +758,24 @@ void kvmppc_xive_connect(SpaprXive *xive, Error *=
*errp)
> =20
>          kvmppc_xive_cpu_connect(spapr_cpu_state(cpu)->tctx, &local_err=
);
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
> @@ -796,23 +797,29 @@ void kvmppc_xive_disconnect(SpaprXive *xive, Erro=
r **errp)
>      xsrc =3D &xive->source;
>      esb_len =3D (1ull << xsrc->esb_shift) * xsrc->nr_irqs;
> =20
> -    memory_region_del_subregion(&xsrc->esb_mmio, &xsrc->esb_mmio_kvm);
> -    object_unparent(OBJECT(&xsrc->esb_mmio_kvm));
> -    munmap(xsrc->esb_mmap, esb_len);
> -    xsrc->esb_mmap =3D NULL;
> +    if (xsrc->esb_mmap) {
> +        memory_region_del_subregion(&xsrc->esb_mmio, &xsrc->esb_mmio_k=
vm);
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
> +        memory_region_del_subregion(&xive->tm_mmio, &xive->tm_mmio_kvm=
);
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
> @@ -822,5 +829,8 @@ void kvmppc_xive_disconnect(SpaprXive *xive, Error =
**errp)
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


