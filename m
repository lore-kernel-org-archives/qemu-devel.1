Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50953C3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 20:09:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 273D621848
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 20:09:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 273D621848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0tOT-0005xe-AN
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 16:09:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53811)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lvivier@redhat.com>) id 1i0tMa-0003rT-U8
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 16:07:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lvivier@redhat.com>) id 1i0tMZ-0006se-1T
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 16:07:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44152)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lvivier@redhat.com>)
 id 1i0tMY-0006rG-QG; Thu, 22 Aug 2019 16:07:14 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DB26A3175283;
 Thu, 22 Aug 2019 20:07:12 +0000 (UTC)
Received: from [10.36.116.91] (ovpn-116-91.ams2.redhat.com [10.36.116.91])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D3A5E60CDA;
 Thu, 22 Aug 2019 20:07:10 +0000 (UTC)
To: David Gibson <david@gibson.dropbear.id.au>, peter.maydell@linaro.org
References: <20190813065920.23203-1-david@gibson.dropbear.id.au>
 <20190813065920.23203-2-david@gibson.dropbear.id.au>
From: Laurent Vivier <lvivier@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=lvivier@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <fe960812-9df2-4c27-8661-633dee3f4a53@redhat.com>
Date: Thu, 22 Aug 2019 22:07:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190813065920.23203-2-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Thu, 22 Aug 2019 20:07:12 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-ppc] [PULL 1/2] spapr: Reset CAS & IRQ
 subsystem after devices
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
Cc: groug@kaod.org, qemu-ppc@nongnu.org, clg@kaod.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/08/2019 08:59, David Gibson wrote:
> This fixes a nasty regression in qemu-4.1 for the 'pseries' machine,
> caused by the new "dual" interrupt controller model.  Specifically,
> qemu can crash when used with KVM if a 'system_reset' is requested
> while there's active I/O in the guest.
>=20
> The problem is that in spapr_machine_reset() we:
>=20
> 1. Reset the CAS vector state
> 	spapr_ovec_cleanup(spapr->ov5_cas);
>=20
> 2. Reset all devices
> 	qemu_devices_reset()
>=20
> 3. Reset the irq subsystem
> 	spapr_irq_reset();
>=20
> However (1) implicitly changes the interrupt delivery mode, because
> whether we're using XICS or XIVE depends on the CAS state.  We don't
> properly initialize the new irq mode until (3) though - in particular
> setting up the KVM devices.
>=20
> During (2), we can temporarily drop the BQL allowing some irqs to be
> delivered which will go to an irq system that's not properly set up.
>=20
> Specifically, if the previous guest was in (KVM) XIVE mode, the CAS
> reset will put us back in XICS mode.  kvm_kernel_irqchip() still
> returns true, because XIVE was using KVM, however XICs doesn't have
> its KVM components intialized and kernel_xics_fd =3D=3D -1.  When the i=
rq
> is delivered it goes via ics_kvm_set_irq() which assert()s that
> kernel_xics_fd !=3D -1.
>=20
> This change addresses the problem by delaying the CAS reset until
> after the devices reset.  The device reset should quiesce all the
> devices so we won't get irqs delivered while we mess around with the
> IRQ.  The CAS reset and irq re-initialize should also now be under the
> same BQL critical section so nothing else should be able to interrupt
> it either.
>=20
> We also move the spapr_irq_msi_reset() used in one of the legacy irq
> modes, since it logically makes sense at the same point as the
> spapr_irq_reset() (it's essentially an equivalent operation for older
> machine types).  Since we don't need to switch between different
> interrupt controllers for those old machine types it shouldn't
> actually be broken in those cases though.
>=20
> Cc: C=C3=A9dric Le Goater <clg@kaod.org>
>=20
> Fixes: b2e22477 "spapr: add a 'reset' method to the sPAPR IRQ backend"
> Fixes: 13db0cd9 "spapr: introduce a new sPAPR IRQ backend supporting
>                  XIVE and XICS"
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/ppc/spapr.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 821f0d4a49..12ed4b065c 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1726,6 +1726,18 @@ static void spapr_machine_reset(MachineState *ma=
chine)
>          spapr_setup_hpt_and_vrma(spapr);
>      }
> =20
> +    /*
> +     * NVLink2-connected GPU RAM needs to be placed on a separate NUMA=
 node.
> +     * We assign a new numa ID per GPU in spapr_pci_collect_nvgpu() wh=
ich is
> +     * called from vPHB reset handler so we initialize the counter her=
e.
> +     * If no NUMA is configured from the QEMU side, we start from 1 as=
 GPU RAM
> +     * must be equally distant from any other node.
> +     * The final value of spapr->gpu_numa_id is going to be written to
> +     * max-associativity-domains in spapr_build_fdt().
> +     */
> +    spapr->gpu_numa_id =3D MAX(1, nb_numa_nodes);
> +    qemu_devices_reset();
> +
>      /*
>       * If this reset wasn't generated by CAS, we should reset our
>       * negotiated options and start from scratch
> @@ -1741,18 +1753,6 @@ static void spapr_machine_reset(MachineState *ma=
chine)
>          spapr_irq_msi_reset(spapr);
>      }
> =20
> -    /*
> -     * NVLink2-connected GPU RAM needs to be placed on a separate NUMA=
 node.
> -     * We assign a new numa ID per GPU in spapr_pci_collect_nvgpu() wh=
ich is
> -     * called from vPHB reset handler so we initialize the counter her=
e.
> -     * If no NUMA is configured from the QEMU side, we start from 1 as=
 GPU RAM
> -     * must be equally distant from any other node.
> -     * The final value of spapr->gpu_numa_id is going to be written to
> -     * max-associativity-domains in spapr_build_fdt().
> -     */
> -    spapr->gpu_numa_id =3D MAX(1, nb_numa_nodes);
> -    qemu_devices_reset();
> -
>      /*
>       * This is fixing some of the default configuration of the XIVE
>       * devices. To be called after the reset of the machine devices.
>=20

This commit breaks migration between POWER8 <-> POWER9 hosts:

qemu-system-ppc64: error while loading state for instance 0x1 of device '=
cpu'
qemu-system-ppc64: load of migration failed: Operation not permitted

Using a guest with a running 4.18 kernel (RHEL 8) and "-M pseries,max-cpu=
-compat=3Dpower8" on both sides.

There is no problem if both hosts are of the same kind ( P8 <-> P8 or P9 =
<-> P9).

Thanks,
Laurent

