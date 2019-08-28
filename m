Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71417C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 23:58:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AB6D204FD
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 23:58:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="nnNq9SEY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AB6D204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i37pZ-0006xZ-Fg
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 19:58:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57828)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i37mj-0004Ik-7L
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 19:55:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i37mg-0004uG-VN
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 19:55:29 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:36717)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1i37md-0004si-UO; Wed, 28 Aug 2019 19:55:25 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46JjKd6kMDz9sN6; Thu, 29 Aug 2019 09:55:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1567036517;
 bh=yHriESBGs4YegJQ89oXi8Yi1S3nsAHrdA75b5OqN+zY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nnNq9SEYM+3XIysV9DFgoYPgGPgdYgucorxd0vZBZjybBxiW8UGWFniXoiSKIFR5B
 K7YZc3QryB1RDUL5tgySDyMQG5u1cK0Q7LZfMi03gEC89+VUK6ZB+dwagySqBnNylc
 kNf2Yx+fiEfIbgLb6YdALrlwvftGPyzUGo9bVKjY=
Date: Thu, 29 Aug 2019 09:42:26 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Message-ID: <20190828234226.GC16342@umbus.fritz.box>
References: <156701285312.499757.7807417667750711711.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="V88s5gaDVPzZ0KCq"
Content-Disposition: inline
In-Reply-To: <156701285312.499757.7807417667750711711.stgit@bahia.lan>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH] spapr: Set compat mode in spapr_core_plug()
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
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--V88s5gaDVPzZ0KCq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2019 at 07:20:53PM +0200, Greg Kurz wrote:
> A recent change in spapr_machine_reset() showed that resetting the compat
> mode in spapr_machine_reset() for the boot vCPU and in spapr_cpu_reset()
> for all other vCPUs was fragile. The fix was thus to reset the compat mode
> for all vCPUs in spapr_machine_reset(), but we still have to propagate
> it to hot-plugged CPUs. This is still performed from spapr_cpu_reset(),
> hence resulting in ppc_set_compat() being called twice for every vCPU at
> machine reset. Apart from wasting cycles, which isn't really an issue
> during machine reset, this seems to indicate that spapr_cpu_reset() isn't
> the best place to set the compat mode.
>=20
> A natural candidate for CPU-hotplug specific code is spapr_core_plug().
> Also, it sits in the same file as spapr_machine_reset() : this makes
> it easier for someone who wants to know when the compat PVR is set.
>=20
> Call ppc_set_compat() from there. This doesn't need to be done for
> initial vCPUs since the compat PVR is 0 and spapr_machine_reset() sets
> the appropriate value later. No need to do this on manually added vCPUS
> on the destination QEMU during migration since the compat PVR is
> part of the migrated vCPU state. Both conditions can be checked with
> spapr_drc_hotplugged().
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied, thanks.

> ---
>  hw/ppc/spapr.c          |   24 ++++++++++++++++--------
>  hw/ppc/spapr_cpu_core.c |    7 -------
>  2 files changed, 16 insertions(+), 15 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 447fb5c4eaaf..ea56499b4b3e 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1758,12 +1758,6 @@ static void spapr_machine_reset(MachineState *mach=
ine)
>          spapr_ovec_cleanup(spapr->ov5_cas);
>          spapr->ov5_cas =3D spapr_ovec_new();
> =20
> -        /*
> -         * reset compat_pvr for all CPUs
> -         * as qemu_devices_reset() is called before this,
> -         * it can't be propagated by spapr_cpu_reset()
> -         * from the first CPU to all the others
> -         */
>          ppc_set_compat_all(spapr->max_compat_pvr, &error_fatal);
>      }
> =20
> @@ -3841,6 +3835,7 @@ static void spapr_core_plug(HotplugHandler *hotplug=
_dev, DeviceState *dev,
>      CPUArchId *core_slot;
>      int index;
>      bool hotplugged =3D spapr_drc_hotplugged(dev);
> +    int i;
> =20
>      core_slot =3D spapr_find_cpu_slot(MACHINE(hotplug_dev), cc->core_id,=
 &index);
>      if (!core_slot) {
> @@ -3874,13 +3869,26 @@ static void spapr_core_plug(HotplugHandler *hotpl=
ug_dev, DeviceState *dev,
>      core_slot->cpu =3D OBJECT(dev);
> =20
>      if (smc->pre_2_10_has_unused_icps) {
> -        int i;
> -
>          for (i =3D 0; i < cc->nr_threads; i++) {
>              cs =3D CPU(core->threads[i]);
>              pre_2_10_vmstate_unregister_dummy_icp(cs->cpu_index);
>          }
>      }
> +
> +    /*
> +     * Set compatibility mode to match the boot CPU, which was either set
> +     * by the machine reset code or by CAS.
> +     */
> +    if (hotplugged) {
> +        for (i =3D 0; i < cc->nr_threads; i++) {
> +            ppc_set_compat(core->threads[i], POWERPC_CPU(first_cpu)->com=
pat_pvr,
> +                           &local_err);
> +            if (local_err) {
> +                error_propagate(errp, local_err);
> +                return;
> +            }
> +        }
> +    }
>  }
> =20
>  static void spapr_core_pre_plug(HotplugHandler *hotplug_dev, DeviceState=
 *dev,
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index 45e2f2747ffc..1d93de8161f3 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -41,13 +41,6 @@ static void spapr_cpu_reset(void *opaque)
>       * using an RTAS call */
>      cs->halted =3D 1;
> =20
> -    /* Set compatibility mode to match the boot CPU, which was either set
> -     * by the machine reset code or by CAS. This should never fail.
> -     * At startup the value is already set for all the CPUs
> -     * but we need this when we hotplug a new CPU
> -     */
> -    ppc_set_compat(cpu, POWERPC_CPU(first_cpu)->compat_pvr, &error_abort=
);
> -
>      env->spr[SPR_HIOR] =3D 0;
> =20
>      lpcr =3D env->spr[SPR_LPCR];
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--V88s5gaDVPzZ0KCq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1nEVwACgkQbDjKyiDZ
s5LAvg/6AlgOt0e93z+igWCwOHH9L3K0MRl10g5Y6O2r4sm8C8er88ku5kdJbfc3
olwv51gdOrGod3S7k9z66hBQW6mUf94ToWTojbNC3fBT4dt+/aaAFfNntMn9cMFA
2ZI+B9Lonev7JOZx2+c3FI0WZgjF02UU4elTfMEA0F0c22GBhISyBbXn0TpP9+9k
pgndoq0c+hsb3qO+oECt1O50e3gxEoMKPspy02Vik3xkGfmEmnjVxFiJrviSEuyQ
CxYYGOVNZsHFSlagJCanbOrR6zJd8dR4sA8f0L0hyAFwCQb/46KCtdGfta8+AwJn
DB9rLxm5qb3gXjm3LhgfzaZPuMsrjofqxqp5h2FyCKL6s2ksPd6TFEr31SVeoPs8
wJ8vGySOZb/gvPMgtTvvW2Uvl0VAFgTHzuS2jlgKrZni5nLxeJf3CmIMUB08izoY
jJQ7sq1BjUcgatzs9x18e2wEdoiFpU3/drGaQGfWGZk2XUKSoGIYlMBLPOkZF3EE
qqeBjHpo50T0V9evgKkyACtoKXjBcw8whIGc7CLrDpOc72voyGevh9K8v94FxEFz
/YOCBCE4vQasIH0keGg76d3hNE43zCTZSlghGcRat7IkPk0lNMCTX1+8U4p7i70Q
43hw/oLks/Nsdkac2kIUs+0w0IROqVDOkAdArDmRla24VfUYuG4=
=SpYR
-----END PGP SIGNATURE-----

--V88s5gaDVPzZ0KCq--

