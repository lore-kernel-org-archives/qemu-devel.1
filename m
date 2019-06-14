Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 879E1C31E45
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 01:55:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5295720B7C
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 01:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="HcYHUcAx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5295720B7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46658 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbbQm-0000Hk-LW
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 21:55:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56940)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hbbL1-0003Hq-Gx
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 21:49:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hbbKz-0003Pe-Pp
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 21:49:07 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:46495 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hbbKz-0003LL-5L; Thu, 13 Jun 2019 21:49:05 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45Q3Rt1MBrz9s3Z; Fri, 14 Jun 2019 11:48:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1560476938;
 bh=zYhbK8b3FCeEeSqYLwx5NAgSQLGqOOObVPlUfPPBoto=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HcYHUcAxp3qf6sNkfxmHHF40QVeypyiE/fUSWYe4gvWGYN2s134EdugC9clNXuqxI
 5kzw0vPue0nPQkYjub9t6t42i6TVatVtBzWfxekknmxR4nvTKrH5r9u8M5W+Jf+8rq
 7hG/n3KeA9FJMcIRUaO859PheGTwPmZj51VbKbCo=
Date: Fri, 14 Jun 2019 11:38:27 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Message-ID: <20190614013827.GB11158@umbus.fritz.box>
References: <156044428869.125694.13827513253200184549.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
 <156044429963.125694.13710679451927268758.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="UHN/qo2QbUvPLonB"
Content-Disposition: inline
In-Reply-To: <156044429963.125694.13710679451927268758.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH 2/3] xics/spapr: Register RTAS/hypercalls
 once at machine init
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


--UHN/qo2QbUvPLonB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2019 at 06:44:59PM +0200, Greg Kurz wrote:
> QEMU may crash when running a spapr machine in 'dual' interrupt controller
> mode on some older (but not that old, eg. ubuntu 18.04.2) KVMs with parti=
al
> XIVE support:
>=20
> qemu-system-ppc64: hw/ppc/spapr_rtas.c:411: spapr_rtas_register:
>  Assertion `!name || !rtas_table[token].name' failed.
>=20
> XICS is controlled by the guest thanks to a set of RTAS calls. Depending
> on whether KVM XICS is used or not, the RTAS calls are handled by KVM or
> QEMU. In both cases, QEMU needs to expose the RTAS calls to the guest
> through the "rtas" node of the device tree.
>=20
> The spapr_rtas_register() helper takes care of all of that: it adds the
> RTAS call token to the "rtas" node and registers a QEMU callback to be
> invoked when the guest issues the RTAS call. In the KVM XICS case, QEMU
> registers a dummy callback that just prints an error since it isn't
> supposed to be invoked, ever.
>=20
> Historically, the XICS controller was setup during machine init and
> released during final teardown. This changed when the 'dual' interrupt
> controller mode was added to the spapr machine: in this case we need
> to tear the XICS down and set it up again during machine reset. The
> crash happens because we indeed have an incompatibility with older
> KVMs that forces QEMU to fallback on emulated XICS, which tries to
> re-registers the same RTAS calls.
>=20
> This could be fixed by adding proper rollback that would unregister
> RTAS calls on error. But since the emulated RTAS calls in QEMU can
> now detect when they are mistakenly called while KVM XICS is in
> use, it seems simpler to register them once and for all at machine
> init. This fixes the crash and allows to remove some now useless
> lines of code.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied, thanks.

> ---
>  hw/intc/xics_kvm.c          |   19 -------------------
>  hw/intc/xics_spapr.c        |    8 --------
>  hw/ppc/spapr_irq.c          |    3 ++-
>  include/hw/ppc/spapr.h      |    4 ----
>  include/hw/ppc/xics.h       |    1 -
>  include/hw/ppc/xics_spapr.h |    1 +
>  6 files changed, 3 insertions(+), 33 deletions(-)
>=20
> diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
> index 5ba5b775615e..5c4208f43008 100644
> --- a/hw/intc/xics_kvm.c
> +++ b/hw/intc/xics_kvm.c
> @@ -331,15 +331,6 @@ void ics_kvm_set_irq(ICSState *ics, int srcno, int v=
al)
>      }
>  }
> =20
> -static void rtas_dummy(PowerPCCPU *cpu, SpaprMachineState *spapr,
> -                       uint32_t token,
> -                       uint32_t nargs, target_ulong args,
> -                       uint32_t nret, target_ulong rets)
> -{
> -    error_report("pseries: %s must never be called for in-kernel XICS",
> -                 __func__);
> -}
> -
>  int xics_kvm_init(SpaprMachineState *spapr, Error **errp)
>  {
>      int rc;
> @@ -360,11 +351,6 @@ int xics_kvm_init(SpaprMachineState *spapr, Error **=
errp)
>          goto fail;
>      }
> =20
> -    spapr_rtas_register(RTAS_IBM_SET_XIVE, "ibm,set-xive", rtas_dummy);
> -    spapr_rtas_register(RTAS_IBM_GET_XIVE, "ibm,get-xive", rtas_dummy);
> -    spapr_rtas_register(RTAS_IBM_INT_OFF, "ibm,int-off", rtas_dummy);
> -    spapr_rtas_register(RTAS_IBM_INT_ON, "ibm,int-on", rtas_dummy);
> -
>      rc =3D kvmppc_define_rtas_kernel_token(RTAS_IBM_SET_XIVE, "ibm,set-x=
ive");
>      if (rc < 0) {
>          error_setg(errp, "kvmppc_define_rtas_kernel_token: ibm,set-xive"=
);
> @@ -454,11 +440,6 @@ void xics_kvm_disconnect(SpaprMachineState *spapr, E=
rror **errp)
>      close(kernel_xics_fd);
>      kernel_xics_fd =3D -1;
> =20
> -    spapr_rtas_unregister(RTAS_IBM_SET_XIVE);
> -    spapr_rtas_unregister(RTAS_IBM_GET_XIVE);
> -    spapr_rtas_unregister(RTAS_IBM_INT_OFF);
> -    spapr_rtas_unregister(RTAS_IBM_INT_ON);
> -
>      kvmppc_define_rtas_kernel_token(0, "ibm,set-xive");
>      kvmppc_define_rtas_kernel_token(0, "ibm,get-xive");
>      kvmppc_define_rtas_kernel_token(0, "ibm,int-on");
> diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
> index d470ab5f7a2a..8d605b68a7a0 100644
> --- a/hw/intc/xics_spapr.c
> +++ b/hw/intc/xics_spapr.c
> @@ -285,14 +285,6 @@ static void rtas_int_on(PowerPCCPU *cpu, SpaprMachin=
eState *spapr,
> =20
>  void xics_spapr_init(SpaprMachineState *spapr)
>  {
> -    /* Emulated mode can only be initialized once. */
> -    if (spapr->ics->init) {
> -        return;
> -    }
> -
> -    spapr->ics->init =3D true;
> -
> -    /* Registration of global state belongs into realize */
>      spapr_rtas_register(RTAS_IBM_SET_XIVE, "ibm,set-xive", rtas_set_xive=
);
>      spapr_rtas_register(RTAS_IBM_GET_XIVE, "ibm,get-xive", rtas_get_xive=
);
>      spapr_rtas_register(RTAS_IBM_INT_OFF, "ibm,int-off", rtas_int_off);
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 3156daf09381..dfb99f35ea00 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -114,6 +114,8 @@ static void spapr_irq_init_xics(SpaprMachineState *sp=
apr, int nr_irqs,
>      }
> =20
>      spapr->ics =3D ICS_BASE(obj);
> +
> +    xics_spapr_init(spapr);
>  }
> =20
>  #define ICS_IRQ_FREE(ics, srcno)   \
> @@ -236,7 +238,6 @@ static const char *spapr_irq_get_nodename_xics(SpaprM=
achineState *spapr)
> =20
>  static void spapr_irq_init_emu_xics(SpaprMachineState *spapr, Error **er=
rp)
>  {
> -    xics_spapr_init(spapr);
>  }
> =20
>  static void spapr_irq_init_kvm_xics(SpaprMachineState *spapr, Error **er=
rp)
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 4f5becf1f3cc..60553d32c4fa 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -676,10 +676,6 @@ typedef void (*spapr_rtas_fn)(PowerPCCPU *cpu, Spapr=
MachineState *sm,
>                                uint32_t nargs, target_ulong args,
>                                uint32_t nret, target_ulong rets);
>  void spapr_rtas_register(int token, const char *name, spapr_rtas_fn fn);
> -static inline void spapr_rtas_unregister(int token)
> -{
> -    spapr_rtas_register(token, NULL, NULL);
> -}
>  target_ulong spapr_rtas_call(PowerPCCPU *cpu, SpaprMachineState *sm,
>                               uint32_t token, uint32_t nargs, target_ulon=
g args,
>                               uint32_t nret, target_ulong rets);
> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> index d6f8e4c4c282..eb65ad7e43b7 100644
> --- a/include/hw/ppc/xics.h
> +++ b/include/hw/ppc/xics.h
> @@ -119,7 +119,6 @@ struct ICSState {
>      uint32_t offset;
>      ICSIRQState *irqs;
>      XICSFabric *xics;
> -    bool init; /* sPAPR ICS device initialized */
>  };
> =20
>  #define ICS_PROP_XICS "xics"
> diff --git a/include/hw/ppc/xics_spapr.h b/include/hw/ppc/xics_spapr.h
> index 2476b540edfa..6c1d9ee55945 100644
> --- a/include/hw/ppc/xics_spapr.h
> +++ b/include/hw/ppc/xics_spapr.h
> @@ -36,5 +36,6 @@ void spapr_dt_xics(SpaprMachineState *spapr, uint32_t n=
r_servers, void *fdt,
>  int xics_kvm_init(SpaprMachineState *spapr, Error **errp);
>  void xics_kvm_disconnect(SpaprMachineState *spapr, Error **errp);
>  void xics_spapr_init(SpaprMachineState *spapr);
> +void xics_spapr_connect(SpaprMachineState *spapr);
> =20
>  #endif /* XICS_SPAPR_H */
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--UHN/qo2QbUvPLonB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0C+pMACgkQbDjKyiDZ
s5Kpkw/+IMBaE0QG9ereZqp5y1VleNQrwQmZVofZjeBf6sMyzDcUP47FyZW0PiMc
BY7gV91B3/ez2AsnrTwIkbyjsYeaL4JC2CPtwScwVL9UuJ8zeGwTMiwSGWrpp9pv
eR/8IqhIv0zOwXugHQc1pYkqf2fBPzS8lxzd9C5+b45CAnhroWNY3nI+mDUQmK8g
Zchfsaxq9gLqOGxmQV2ZCIS9YZQ2zIAciiZ7BDN/i3gIZxK7rxOGV5pOM3+oxYQS
+sfJ/qTrlCuLH9S51pO1v0TNW9ATGIxi6jIBYS/HdwlqJfaDKDAqWDktx+jbMsFt
Y7yyGZLU36o1Zc1LFqhNMBUr0iejlEvnfuE9ugaG9xXKUFVL4cyQ3wW6WKR9ucCx
V93usyAEZB1p9IupDMTP2r+YSLGGlUy97jAjz2trEPrDiWQbSl3adCBtTtoe3YbY
okbnZE4AOITLQSlpAOZ+15lgtFIpOj3D+zmQ9GAnoOMgWIu++r/6AhvF2vhNr5yD
8yzPd2N3i3SZu7CQFZjjZDu4LZKZEpSD8CLKmmXc2mdsl61dblZpYElTqX0gi5BV
hehzu4zr+87RDlofNDWjPF3hRxt9f/Owz7bCC9UsjdOKhFTYQySyhRsPRRcARkOp
ZdRzLxEq8/mXx/cBb26sPq2Rav//ZoSrGm2DXg6kHig4aRIPkDk=
=pZnG
-----END PGP SIGNATURE-----

--UHN/qo2QbUvPLonB--

