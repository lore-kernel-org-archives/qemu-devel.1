Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB1AC3A59E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 08:38:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86F1020874
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 08:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="iU9Z8xdt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86F1020874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2AVk-000897-OM
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 04:38:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48884)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i2AUM-0007Os-RN
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 04:36:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i2AUL-0007Pn-6t
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 04:36:34 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:52515)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1i2AUJ-0007NT-HL; Mon, 26 Aug 2019 04:36:33 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46H52L0K8Tz9sMr; Mon, 26 Aug 2019 18:36:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1566808586;
 bh=EZFzqS78SMYFZhYWgReqZBj3CBFEPFrQEhUoiE9nye8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=iU9Z8xdtejsrM7gww9kgNx9IiHp+qgLsJulHR7JC7IHR/8h1ES4Fj8O2qBaz4sbTf
 cZvtXwhIHPKKUOYaSU6KKOc0JuFf62xpj9db40AyZhod5TN5eXSGGbGMekuHYH8qr1
 PXLlhgJkwmJ/F3xP3MuIiwyPAsCq5uvYE2eq6gTY=
Date: Mon, 26 Aug 2019 17:47:05 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Laurent Vivier <lvivier@redhat.com>
Message-ID: <20190826074705.GB28081@umbus.fritz.box>
References: <20190813065920.23203-1-david@gibson.dropbear.id.au>
 <20190813065920.23203-2-david@gibson.dropbear.id.au>
 <fe960812-9df2-4c27-8661-633dee3f4a53@redhat.com>
 <20190823053944.GC3027@umbus.fritz.box>
 <ab12dbd1-b925-d384-986f-151f12e3a056@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="IrhDeMKUP4DT/M7F"
Content-Disposition: inline
In-Reply-To: <ab12dbd1-b925-d384-986f-151f12e3a056@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: peter.maydell@linaro.org, groug@kaod.org, qemu-ppc@nongnu.org, clg@kaod.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--IrhDeMKUP4DT/M7F
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2019 at 03:47:52PM +0200, Laurent Vivier wrote:
> On 23/08/2019 07:39, David Gibson wrote:
> > On Thu, Aug 22, 2019 at 10:07:09PM +0200, Laurent Vivier wrote:
> >> On 13/08/2019 08:59, David Gibson wrote:
> >>> This fixes a nasty regression in qemu-4.1 for the 'pseries' machine,
> >>> caused by the new "dual" interrupt controller model.  Specifically,
> >>> qemu can crash when used with KVM if a 'system_reset' is requested
> >>> while there's active I/O in the guest.
> >>>
> >>> The problem is that in spapr_machine_reset() we:
> >>>
> >>> 1. Reset the CAS vector state
> >>> 	spapr_ovec_cleanup(spapr->ov5_cas);
> >>>
> >>> 2. Reset all devices
> >>> 	qemu_devices_reset()
> >>>
> >>> 3. Reset the irq subsystem
> >>> 	spapr_irq_reset();
> >>>
> >>> However (1) implicitly changes the interrupt delivery mode, because
> >>> whether we're using XICS or XIVE depends on the CAS state.  We don't
> >>> properly initialize the new irq mode until (3) though - in particular
> >>> setting up the KVM devices.
> >>>
> >>> During (2), we can temporarily drop the BQL allowing some irqs to be
> >>> delivered which will go to an irq system that's not properly set up.
> >>>
> >>> Specifically, if the previous guest was in (KVM) XIVE mode, the CAS
> >>> reset will put us back in XICS mode.  kvm_kernel_irqchip() still
> >>> returns true, because XIVE was using KVM, however XICs doesn't have
> >>> its KVM components intialized and kernel_xics_fd =3D=3D -1.  When the=
 irq
> >>> is delivered it goes via ics_kvm_set_irq() which assert()s that
> >>> kernel_xics_fd !=3D -1.
> >>>
> >>> This change addresses the problem by delaying the CAS reset until
> >>> after the devices reset.  The device reset should quiesce all the
> >>> devices so we won't get irqs delivered while we mess around with the
> >>> IRQ.  The CAS reset and irq re-initialize should also now be under the
> >>> same BQL critical section so nothing else should be able to interrupt
> >>> it either.
> >>>
> >>> We also move the spapr_irq_msi_reset() used in one of the legacy irq
> >>> modes, since it logically makes sense at the same point as the
> >>> spapr_irq_reset() (it's essentially an equivalent operation for older
> >>> machine types).  Since we don't need to switch between different
> >>> interrupt controllers for those old machine types it shouldn't
> >>> actually be broken in those cases though.
> >>>
> >>> Cc: C=E9dric Le Goater <clg@kaod.org>
> >>>
> >>> Fixes: b2e22477 "spapr: add a 'reset' method to the sPAPR IRQ backend"
> >>> Fixes: 13db0cd9 "spapr: introduce a new sPAPR IRQ backend supporting
> >>>                  XIVE and XICS"
> >>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> >>> ---
> >>>  hw/ppc/spapr.c | 24 ++++++++++++------------
> >>>  1 file changed, 12 insertions(+), 12 deletions(-)
> >>>
> >>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> >>> index 821f0d4a49..12ed4b065c 100644
> >>> --- a/hw/ppc/spapr.c
> >>> +++ b/hw/ppc/spapr.c
> >>> @@ -1726,6 +1726,18 @@ static void spapr_machine_reset(MachineState *=
machine)
> >>>          spapr_setup_hpt_and_vrma(spapr);
> >>>      }
> >>> =20
> >>> +    /*
> >>> +     * NVLink2-connected GPU RAM needs to be placed on a separate NU=
MA node.
> >>> +     * We assign a new numa ID per GPU in spapr_pci_collect_nvgpu() =
which is
> >>> +     * called from vPHB reset handler so we initialize the counter h=
ere.
> >>> +     * If no NUMA is configured from the QEMU side, we start from 1 =
as GPU RAM
> >>> +     * must be equally distant from any other node.
> >>> +     * The final value of spapr->gpu_numa_id is going to be written =
to
> >>> +     * max-associativity-domains in spapr_build_fdt().
> >>> +     */
> >>> +    spapr->gpu_numa_id =3D MAX(1, nb_numa_nodes);
> >>> +    qemu_devices_reset();
> >>> +
> >>>      /*
> >>>       * If this reset wasn't generated by CAS, we should reset our
> >>>       * negotiated options and start from scratch
> >>> @@ -1741,18 +1753,6 @@ static void spapr_machine_reset(MachineState *=
machine)
> >>>          spapr_irq_msi_reset(spapr);
> >>>      }
> >>> =20
> >>> -    /*
> >>> -     * NVLink2-connected GPU RAM needs to be placed on a separate NU=
MA node.
> >>> -     * We assign a new numa ID per GPU in spapr_pci_collect_nvgpu() =
which is
> >>> -     * called from vPHB reset handler so we initialize the counter h=
ere.
> >>> -     * If no NUMA is configured from the QEMU side, we start from 1 =
as GPU RAM
> >>> -     * must be equally distant from any other node.
> >>> -     * The final value of spapr->gpu_numa_id is going to be written =
to
> >>> -     * max-associativity-domains in spapr_build_fdt().
> >>> -     */
> >>> -    spapr->gpu_numa_id =3D MAX(1, nb_numa_nodes);
> >>> -    qemu_devices_reset();
> >>> -
> >>>      /*
> >>>       * This is fixing some of the default configuration of the XIVE
> >>>       * devices. To be called after the reset of the machine devices.
> >>>
> >>
> >> This commit breaks migration between POWER8 <-> POWER9 hosts:
> >>
> >> qemu-system-ppc64: error while loading state for instance 0x1 of devic=
e 'cpu'
> >> qemu-system-ppc64: load of migration failed: Operation not permitted
> >>
> >> Using a guest with a running 4.18 kernel (RHEL 8) and "-M pseries,max-=
cpu-compat=3Dpower8" on both sides.
> >>
> >> There is no problem if both hosts are of the same kind ( P8 <-> P8 or =
P9 <-> P9).
> >=20
> > Crud, I was afraid there might be some subtle dependency on the
> > reverse order.
>=20
> It seems the side effect of patch in comment 5 is to add a supplementary =
field compat_pvr in CPUs in the migration stream:
>=20
>         {
>             "name": "cpu",
>             "instance_id": 0,
>             "vmsd_name": "cpu",
>             "version": 5,
> ...
>             "subsections": [
> ...
>                 {
>                     "vmsd_name": "cpu/compat",
>                     "version": 1,
>                     "fields": [
>                         {
>                             "name": "compat_pvr",
>                             "type": "uint32",
>                             "size": 4
>                         }
>                     ]
>                 }
>             ]
>         },
> ...
>=20
> What seems to happen is compat_pvr is not propagated correctly to all
>  CPUs.
>=20
> Originally, spapr_machine_reset() calls ppc_set_compat() to set the=20
> value to max_compat_pvr for the first cpu and this was propagated to all=
=20
> CPUs by spapr_cpu_reset().
> Now, as spapr_cpu_reset() is called before that, the value is not=20
> propagated to all CPUs.
>=20
> A simple fix seems to be:
>=20
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1752,7 +1752,7 @@ static void spapr_machine_reset(MachineState *machi=
ne)
>          spapr_ovec_cleanup(spapr->ov5_cas);
>          spapr->ov5_cas =3D spapr_ovec_new();
> =20
> -        ppc_set_compat(first_ppc_cpu, spapr->max_compat_pvr, &error_fata=
l);
> +        ppc_set_compat_all(spapr->max_compat_pvr, &error_fatal);
>      }
> =20
>      /*
>=20

As discussed on our call, I think this is a good fix at least in the
medium term.  If you can add in some explanatory comments and post it
formally ASAP.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--IrhDeMKUP4DT/M7F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1jjnkACgkQbDjKyiDZ
s5KIOxAAvw0J8oZnXxJgFVrBX5aSmC/oLqM2D/1Uxb2NDwD8pHcpt3ZwdiMOH/h6
GV36ZHeZJLk8fqZ2CxE6zMLatDidPGYccPiQBu0D8FQYKsn+0JXb1BIinmZLItiA
AAsCoDeCvkZIVxL52q/b9VWjlYX9pk1p1KTgUdKxW0xlndychXmXe3UDQPfNRDB8
rRn7VTIjIvEc0mIIduYVUyo5+3vfbQaCW/ZegeQURvKUAoan+huiEW23r41mYqIM
dTJTW13Xx7g7Zd6P+Ens3rWlt3jBt+2iH6N+Z94+/pgiOqc9tj8QppYqYwMnS8ZV
rtW/FLbG6+ZcdEgmmMYIgb5JbTw1vbHiwNGKrkUfAOFGRc1IEsztAkGKgPveungO
VCgtF9nPJTASsENyEKVo1n4rBOAdEhtNoS43PftaX3sdqgzngySgCKoOYAJiluYp
6umj/SwO/vGdPyAXExwJCzZJzAMmoYYBnWqrPdElzuWYpb7gNlfTYeWJzlXtU2FN
YYYq3iQr0mx88maQGTdI7EnvttqGBjFGjd3SjGcVBJTnqavPDZUJ80OSb3/TzPx9
Wxh3476zl5vBAimsOMHtgenWGtQP1iZu+CpZR/yKYHtK6LEQJyQmxpREfOvfs1xD
aeNXtJJSJVg+v6MfYhI97ryCKyqeGYL1sGMIzx8C28OUB3No8e0=
=PIgE
-----END PGP SIGNATURE-----

--IrhDeMKUP4DT/M7F--

