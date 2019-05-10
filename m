Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A097CC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 06:53:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52A2E2175B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 06:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="n2eIEY5F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52A2E2175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37899 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOzPY-0005Qr-GK
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 02:53:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hOzNz-0004GQ-Jd
	for qemu-devel@nongnu.org; Fri, 10 May 2019 02:52:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hOzNx-0005ai-37
	for qemu-devel@nongnu.org; Fri, 10 May 2019 02:52:02 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:60151 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hOzNw-0005Zx-Dc; Fri, 10 May 2019 02:52:01 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 450gqY6Gvvz9sMM; Fri, 10 May 2019 16:51:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1557471113;
	bh=yrF/2PsA7qhR6pp+ry5x8aqC0PCzrS1QbFawARHTp8w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n2eIEY5FsKdEoftI2A1+de9DSw9t66z4f+y7sjzVYp7RzNMe8kG7+tqK3IsVnFKkK
	3rqWETJ/4iNq9cmi1/KlXUCuW2xopcsOHaRapGCWRN/E9/JvQUx85+rV5JgYvzlBw9
	RceSrgazvbHSyBwyXlW60V+js3m+aCrH50F6+gJE=
Date: Fri, 10 May 2019 16:51:44 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Message-ID: <20190510065144.GM20559@umbus.fritz.box>
References: <155591636364.20338.844048953355207313.stgit@aravinda>
	<155591662496.20338.3862565585716109724.stgit@aravinda>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2YJj5f1P6Th4nBRw"
Content-Disposition: inline
In-Reply-To: <155591662496.20338.3862565585716109724.stgit@aravinda>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH v8 6/6] migration: Block migration while
 handling machine check
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
Cc: paulus@ozlabs.org, qemu-ppc@nongnu.org, aik@au1.ibm.com,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--2YJj5f1P6Th4nBRw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2019 at 12:33:45PM +0530, Aravinda Prasad wrote:
> Block VM migration requests until the machine check
> error handling is complete as (i) these errors are
> specific to the source hardware and is irrelevant on
> the target hardware, (ii) these errors cause data
> corruption and should be handled before migration.
>=20
> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
> ---
>  hw/ppc/spapr_events.c  |   17 +++++++++++++++++
>  hw/ppc/spapr_rtas.c    |    4 ++++
>  include/hw/ppc/spapr.h |    3 +++
>  3 files changed, 24 insertions(+)
>=20
> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> index 4032db0..45b990c 100644
> --- a/hw/ppc/spapr_events.c
> +++ b/hw/ppc/spapr_events.c
> @@ -41,6 +41,7 @@
>  #include "qemu/bcd.h"
>  #include "hw/ppc/spapr_ovec.h"
>  #include <libfdt.h>
> +#include "migration/blocker.h"
> =20
>  #define RTAS_LOG_VERSION_MASK                   0xff000000
>  #define   RTAS_LOG_VERSION_6                    0x06000000
> @@ -864,6 +865,22 @@ static void spapr_mce_dispatch_elog(PowerPCCPU *cpu,=
 bool recovered)
>  void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered)
>  {
>      SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> +    int ret;
> +    Error *local_err =3D NULL;
> +
> +    error_setg(&spapr->migration_blocker,
> +            "Live migration not supported during machine check handling"=
);
> +    ret =3D migrate_add_blocker(spapr->migration_blocker, &local_err);
> +    if (ret < 0) {
> +        /*
> +         * We don't want to abort and let the migration to continue. In a
> +         * rare case, the machine check handler will run on the target
> +         * hardware. Though this is not preferable, it is better than ab=
orting
> +         * the migration or killing the VM.
> +         */
> +        error_free(spapr->migration_blocker);
> +        fprintf(stderr, "Warning: Machine check during VM migration\n");

Use report_err() instead of a raw fprintf().

> +    }
> =20
>      while (spapr->mc_status !=3D -1) {
>          /*
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index 997cf19..1229a0e 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -50,6 +50,7 @@
>  #include "target/ppc/mmu-hash64.h"
>  #include "target/ppc/mmu-book3s-v3.h"
>  #include "kvm_ppc.h"
> +#include "migration/blocker.h"
> =20
>  static void rtas_display_character(PowerPCCPU *cpu, SpaprMachineState *s=
papr,
>                                     uint32_t token, uint32_t nargs,
> @@ -396,6 +397,9 @@ static void rtas_ibm_nmi_interlock(PowerPCCPU *cpu,
>          spapr->mc_status =3D -1;
>          qemu_cond_signal(&spapr->mc_delivery_cond);
>          rtas_st(rets, 0, RTAS_OUT_SUCCESS);
> +        migrate_del_blocker(spapr->migration_blocker);
> +        error_free(spapr->migration_blocker);
> +        spapr->migration_blocker =3D NULL;
>      }
>  }
> =20
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 9d16ad1..dda5fd2 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -10,6 +10,7 @@
>  #include "hw/ppc/spapr_irq.h"
>  #include "hw/ppc/spapr_xive.h"  /* For SpaprXive */
>  #include "hw/ppc/xics.h"        /* For ICSState */
> +#include "qapi/error.h"
> =20
>  struct SpaprVioBus;
>  struct SpaprPhbState;
> @@ -213,6 +214,8 @@ struct SpaprMachineState {
>      SpaprCapabilities def, eff, mig;
> =20
>      unsigned gpu_numa_id;
> +
> +    Error *migration_blocker;

This name doesn't seem good - it's specific to fwnmi, not any other
migration blockers we might have in future.  It also always contains
the same string - could you just initialize that in a global and just
do the migrate_add_blocker() / migrate_del_blocker() instead?

>  };
> =20
>  #define H_SUCCESS         0
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--2YJj5f1P6Th4nBRw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzVH4AACgkQbDjKyiDZ
s5IYOg/8DGmFNmMsZeTK2r4V4ORgh9i0oFZFbu4iN4I0W8a0CJ764NmcqjSwLIZ4
ZmUaSGTIDpQdBWAwKLgZtUx6EqLHco1mmpFqwwAhQIkfrElPM15XpqUAFf3puLt4
frAS3ROJA81lZRO6FTeqlfX+yDUEtnv1BxxGZWJQJfRmN/638kSxhJyGSYKkmPTs
U2Twd0hv0CG+LThaOtbKdFiybOI3Qc0xjTE2njVSZ+NUfcPqZQvMyR0abhWADO6j
2JF+p/4iHQqwedyIx/UTrqQXnPbtIpbed+PoKFlDZewV6F+adm/MsVvbj3mD/6mZ
hrskRhcfYqeVCwAWZxgpKNdKelNbe19XylFqrRiGYBXYjkWLslTs3MSdGHJPwLk/
ryYSf1wWgz4wGwTxQJDHwkYknRx3tKISgJyR6Kx+tivhiJh0WmUzQ3dW3URZ07J7
v7SQmLOSbqy6JcKbrAiZb4+gcJ32ZMnrMFCzvfJJVsQJHHJNyw/blzxmcMAoz9iW
k0c9hE0zoEuJ2oTpDSv862wdkzzOEYC4pKh1ngNI6fSwhXrbWOQjWPd6hmTbkMDS
/1MWH3RUVlCUotRFYE2ONYmtquRJYm+hJ0ksqyOrdrT0p8IOp9J0o1+ACSVzaIQb
ggqapU8S9DZNdia0/Jrj2W+AOVGlrZvU+lAu04oEph16QksCsRM=
=AZD+
-----END PGP SIGNATURE-----

--2YJj5f1P6Th4nBRw--

