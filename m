Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39ECBC04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 17:40:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1064720868
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 17:40:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1064720868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35765 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYwMz-0001Rm-4i
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 13:40:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hYwMC-00015C-R3
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:39:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hYwMA-00034e-Ow
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:39:20 -0400
Received: from 4.mo178.mail-out.ovh.net ([46.105.49.171]:37518)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1hYwM6-0002gx-P2
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:39:18 -0400
Received: from player694.ha.ovh.net (unknown [10.108.42.73])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 136E96B181
	for <qemu-devel@nongnu.org>; Thu,  6 Jun 2019 19:39:01 +0200 (CEST)
Received: from kaod.org (lfbn-1-10649-41.w90-89.abo.wanadoo.fr [90.89.235.41])
	(Authenticated sender: clg@kaod.org)
	by player694.ha.ovh.net (Postfix) with ESMTPSA id 4109868298E1;
	Thu,  6 Jun 2019 17:38:57 +0000 (UTC)
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
References: <155984093894.2803172.8618224129384655510.stgit@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <81bbf4ef-d6ed-1e45-04ce-2531e3061284@kaod.org>
Date: Thu, 6 Jun 2019 19:38:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <155984093894.2803172.8618224129384655510.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 5743496900861463379
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudeggedgudduiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.49.171
Subject: Re: [Qemu-devel] [PATCH] spapr: Don't use the "dual" interrupt
 controller mode with an old hypervisor
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/06/2019 19:08, Greg Kurz wrote:
> If KVM is too old to support XIVE native exploitation mode, we might en=
d
> up using the emulated XIVE after CAS. This is sub-optimal if KVM in-ker=
nel
> XICS is available, which is the case most of the time.
>=20
> Also, an old KVM may not allow to destroy and re-create the KVM XICS, w=
hich
> is precisely what "dual" does during machine reset. This causes QEMU to=
 try
> to switch to emulated XICS and to crash because RTAS call de-registrati=
on
> isn't handled correctly. We could possibly fix that, but again we would
> still end up with an emulated XICS or XIVE.

Yes. I think we should favor a KVM device over an emulated one in any cas=
e.
=20
>=20
> "dual" is definitely not a good choice with older KVMs. Internally forc=
e
> XICS when we detect this.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

we could move the KVM tests done at the beginning of spapr_irq_init()=20
in routine spapr_irq_check() but this is for another patch, and it's=20
only a cleanup.

Thanks,

C.

> ---
>  hw/ppc/spapr_irq.c |   10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 3156daf09381..d788bd662a7a 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -18,6 +18,7 @@
>  #include "hw/ppc/xics_spapr.h"
>  #include "cpu-models.h"
>  #include "sysemu/kvm.h"
> +#include "kvm_ppc.h"
> =20
>  #include "trace.h"
> =20
> @@ -668,6 +669,15 @@ static void spapr_irq_check(SpaprMachineState *spa=
pr, Error **errp)
>              return;
>          }
>      }
> +
> +    /*
> +     * KVM may be too old to support XIVE, in which case we'd rather t=
ry
> +     * to use the in-kernel XICS instead of the emulated XIVE.
> +     */
> +    if (kvm_enabled() && !kvmppc_has_cap_xive() &&
> +        spapr->irq =3D=3D &spapr_irq_dual) {
> +        spapr->irq =3D &spapr_irq_xics;
> +    }
>  }
> =20
>  /*
>=20


