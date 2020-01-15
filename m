Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5052FC32771
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 18:12:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CBF92187F
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 18:12:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CBF92187F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irn98-0003Zv-9P
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 13:12:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52254)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1irn8H-0002aT-1d
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 13:11:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1irn8D-0000oz-Cu
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 13:11:08 -0500
Received: from 4.mo69.mail-out.ovh.net ([46.105.42.102]:41692)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1irn8D-0000iT-6S
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 13:11:05 -0500
Received: from player786.ha.ovh.net (unknown [10.108.16.68])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id 01FBA7B57B
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 19:10:55 +0100 (CET)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player786.ha.ovh.net (Postfix) with ESMTPSA id 0749EE6B7930;
 Wed, 15 Jan 2020 18:10:49 +0000 (UTC)
Subject: Re: [PATCH] spapr: Migrate CAS reboot flag
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
References: <157911051688.345768.16136592081655557565.stgit@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <6fb96fed-9590-aa7c-cf00-038ab776ccb5@kaod.org>
Date: Wed, 15 Jan 2020 19:10:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <157911051688.345768.16136592081655557565.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 6174153618378492755
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrtdefgddutdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucffohhmrghinheprhgvughhrghtrdgtohhmnecukfhppedtrddtrddtrddtpdekvddrieegrddvhedtrddujedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejkeeirdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.42.102
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
Cc: Laurent Vivier <lvivier@redhat.com>, Lukas Doktor <ldoktor@redhat.com>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/15/20 6:48 PM, Greg Kurz wrote:
> Migration can potentially race with CAS reboot. If the migration thread
> completes migration after CAS has set spapr->cas_reboot but before the
> mainloop could pick up the reset request and reset the machine, the
> guest is migrated unrebooted and the destination doesn't reboot it
> either because it isn't aware a CAS reboot was needed (eg, because a
> device was added before CAS). This likely result in a broken or hung
> guest.
>=20
> Even if it is small, the window between CAS and CAS reboot is enough to
> re-qualify spapr->cas_reboot as state that we should migrate. Add a new
> subsection for that and always send it when a CAS reboot is pending.
> This may cause migration to older QEMUs to fail but it is still better
> than end up with a broken guest.
>=20
> The destination cannot honour the CAS reboot request from a post load
> handler because this must be done after the guest is fully restored.
> It is thus done from a VM change state handler.
>=20
> Reported-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
> Signed-off-by: Greg Kurz <groug@kaod.org>

C=C3=A9dric Le Goater <clg@kaod.org>

Nice work ! That was quite complex to catch !

Thanks,

C.

> ---
>=20
> This patch is supposed to fix the interrupt controller mode inconsisten=
cy
> between QEMU and the guest reported in this BZ:
>=20
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1781315 (requires auth)
>=20
> Even if interrupt controller selection doesn't involve CAS reboot anymo=
re,
> we still have other conditions that require CAS reboot.
> ---
>  hw/ppc/spapr.c |   43 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 30a5fbd3bea6..bf2763aa16e5 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1959,6 +1959,31 @@ static const VMStateDescription vmstate_spapr_dt=
b =3D {
>      },
>  };
> =20
> +static bool spapr_cas_reboot_needed(void *opaque)
> +{
> +    SpaprMachineState *spapr =3D SPAPR_MACHINE(opaque);
> +
> +    /*
> +     * This causes the "spapr_cas_reboot" subsection to always be
> +     * sent if migration raced with CAS. This causes older QEMUs
> +     * that don't know about the subsection to fail migration but
> +     * it is still better than end up with a broken guest on the
> +     * destination.
> +     */
> +    return spapr->cas_reboot;
> +}
> +
> +static const VMStateDescription vmstate_spapr_cas_reboot =3D {
> +    .name =3D "spapr_cas_reboot",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .needed =3D spapr_cas_reboot_needed,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_BOOL(cas_reboot, SpaprMachineState),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
>  static const VMStateDescription vmstate_spapr =3D {
>      .name =3D "spapr",
>      .version_id =3D 3,
> @@ -1992,6 +2017,7 @@ static const VMStateDescription vmstate_spapr =3D=
 {
>          &vmstate_spapr_dtb,
>          &vmstate_spapr_cap_large_decr,
>          &vmstate_spapr_cap_ccf_assist,
> +        &vmstate_spapr_cas_reboot,
>          NULL
>      }
>  };
> @@ -2577,6 +2603,21 @@ static PCIHostState *spapr_create_default_phb(vo=
id)
>      return PCI_HOST_BRIDGE(dev);
>  }
> =20
> +static void spapr_change_state_handler(void *opaque, int running,
> +                                       RunState state)
> +{
> +    SpaprMachineState *spapr =3D opaque;
> +
> +    if (running && spapr->cas_reboot) {
> +        /*
> +         * This happens when resuming from migration if the source
> +         * processed a CAS but didn't have time to trigger the CAS
> +         * reboot. Do it now.
> +         */
> +        qemu_system_reset_request(SHUTDOWN_CAUSE_SUBSYSTEM_RESET);
> +    }
> +}
> +
>  /* pSeries LPAR / sPAPR hardware init */
>  static void spapr_machine_init(MachineState *machine)
>  {
> @@ -2970,6 +3011,8 @@ static void spapr_machine_init(MachineState *mach=
ine)
> =20
>          kvmppc_spapr_enable_inkernel_multitce();
>      }
> +
> +    qemu_add_vm_change_state_handler(spapr_change_state_handler, spapr=
);
>  }
> =20
>  static int spapr_kvm_type(MachineState *machine, const char *vm_type)
>=20


