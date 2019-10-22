Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8317CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 15:49:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C8A2214B2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 15:49:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C8A2214B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMwPy-0005il-M9
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 11:49:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58252)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iMwG4-00060Y-LH
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 11:39:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iMwG2-0006CK-Dk
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 11:39:40 -0400
Received: from 7.mo6.mail-out.ovh.net ([46.105.59.196]:35630)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iMwG2-0006Aq-4y
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 11:39:38 -0400
Received: from player730.ha.ovh.net (unknown [10.108.35.12])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id E07D71E45B4
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 17:39:35 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player730.ha.ovh.net (Postfix) with ESMTPSA id 093CCB245263;
 Tue, 22 Oct 2019 15:39:29 +0000 (UTC)
Date: Tue, 22 Oct 2019 17:39:27 +0200
From: Greg Kurz <groug@kaod.org>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v4 6/7] ppc/pnv: Fix naming of routines realizing the CPUs
Message-ID: <20191022173927.478a4cc7@bahia.lan>
In-Reply-To: <20191022134632.29098-7-clg@kaod.org>
References: <20191022134632.29098-1-clg@kaod.org>
 <20191022134632.29098-7-clg@kaod.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 2501468119284881803
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrkeejgdeludcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.59.196
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
Cc: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 22 Oct 2019 15:46:31 +0200
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> The 'vcpu' suffix is inherited from the sPAPR machine. Use better
> names for PowerNV.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/pnv_core.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index 127107ab7c63..328ad07c8d06 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c
> @@ -163,7 +163,7 @@ static const MemoryRegionOps pnv_core_power9_xscom_op=
s =3D {
>      .endianness =3D DEVICE_BIG_ENDIAN,
>  };
> =20
> -static void pnv_realize_vcpu(PowerPCCPU *cpu, PnvChip *chip, Error **err=
p)
> +static void pnv_core_cpu_realize(PowerPCCPU *cpu, PnvChip *chip, Error *=
*errp)
>  {
>      CPUPPCState *env =3D &cpu->env;
>      int core_pir;
> @@ -248,7 +248,7 @@ static void pnv_core_realize(DeviceState *dev, Error =
**errp)
>      }
> =20
>      for (j =3D 0; j < cc->nr_threads; j++) {
> -        pnv_realize_vcpu(pc->threads[j], pc->chip, &local_err);
> +        pnv_core_cpu_realize(pc->threads[j], pc->chip, &local_err);
>          if (local_err) {
>              goto err;
>          }
> @@ -270,7 +270,7 @@ err:
>      error_propagate(errp, local_err);
>  }
> =20
> -static void pnv_unrealize_vcpu(PowerPCCPU *cpu)
> +static void pnv_core_cpu_unrealize(PowerPCCPU *cpu)
>  {
>      PnvCPUState *pnv_cpu =3D pnv_cpu_state(cpu);
> =20
> @@ -290,7 +290,7 @@ static void pnv_core_unrealize(DeviceState *dev, Erro=
r **errp)
>      qemu_unregister_reset(pnv_core_reset, pc);
> =20
>      for (i =3D 0; i < cc->nr_threads; i++) {
> -        pnv_unrealize_vcpu(pc->threads[i]);
> +        pnv_core_cpu_unrealize(pc->threads[i]);
>      }
>      g_free(pc->threads);
>  }


