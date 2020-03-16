Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94CC9C2BB1D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 23:11:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F08120674
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 23:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Ptj9XdI5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F08120674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDytN-0006O0-Gy
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 19:11:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55220)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jDys6-0004c2-6Q
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 19:10:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jDys4-0003yw-RB
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 19:10:09 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:45957 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jDys3-0003Uf-PZ; Mon, 16 Mar 2020 19:10:08 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48hBph6DyLz9sNg; Tue, 17 Mar 2020 10:10:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1584400204;
 bh=vAP45sgI9C/g4tnLRPulY+K3cuMB2zIRn3BvjR1SQRw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Ptj9XdI5zFA54d/orAiu+Pe1ipUCVJh53GhFTRc91WwqeGHlVaRwA5kacsjkMzEuk
 WDVm/d3evsj5hQoWCYmsBDnqnu83qze5u9tQXD1sdhH+KNBTaLPWjie4sVlktKWdKB
 oWoPciEW2b5VLz6bbulKDAEsoe+aN9OvTzSCXLjA=
Date: Tue, 17 Mar 2020 09:46:08 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 1/8] ppc/spapr: Fix FWNMI machine check failure handling
Message-ID: <20200316224608.GA20264@umbus.fritz.box>
References: <20200316142613.121089-1-npiggin@gmail.com>
 <20200316142613.121089-2-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
In-Reply-To: <20200316142613.121089-2-npiggin@gmail.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: Aravinda Prasad <arawinda.p@gmail.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, Ganesh Goudar <ganeshgr@linux.ibm.com>,
 qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2020 at 12:26:06AM +1000, Nicholas Piggin wrote:
> ppc_cpu_do_system_reset delivers a system rreset interrupt to the guest,
> which is certainly not what is intended here. Panic the guest like other
> failure cases here do.
>=20
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to ppc-for-5.0, thanks.

> ---
>  hw/ppc/spapr_events.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> index 2afd1844e4..11303258d4 100644
> --- a/hw/ppc/spapr_events.c
> +++ b/hw/ppc/spapr_events.c
> @@ -785,7 +785,6 @@ static uint32_t spapr_mce_get_elog_type(PowerPCCPU *c=
pu, bool recovered,
>  static void spapr_mce_dispatch_elog(PowerPCCPU *cpu, bool recovered)
>  {
>      SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> -    CPUState *cs =3D CPU(cpu);
>      uint64_t rtas_addr;
>      CPUPPCState *env =3D &cpu->env;
>      PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
> @@ -823,8 +822,7 @@ static void spapr_mce_dispatch_elog(PowerPCCPU *cpu, =
bool recovered)
>      /* get rtas addr from fdt */
>      rtas_addr =3D spapr_get_rtas_addr();
>      if (!rtas_addr) {
> -        /* Unable to fetch rtas_addr. Hence reset the guest */
> -        ppc_cpu_do_system_reset(cs);
> +        qemu_system_guest_panicked(NULL);
>          g_free(ext_elog);
>          return;
>      }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5wAbAACgkQbDjKyiDZ
s5LNdw//a1xLPY2OuraH06moWhNpZy/FwfbfXuhEyRL2EKCpDiEVDx+GdLJp/4yL
BUeFQJ1o0l6xzWuSfYA3eq5GLhOnA5PKWlmYkGe49YLXCefuYNq9Xn9CyeeWioOC
Gp2/zAb26ii44OhBG+9Yes4FRdeq75LOKqTXikbfcS4hWhWewSUX373P+RfRhpQR
Dld1/JzDGcNoiAWNaDy0EYxLnIeZa29DGj3WDhAw+PkJxBiLAbXCXSkQZdWat9SO
vDCuTh9nf6dI/pOvJx5I95ptxEVxu0i4ca4Na0xRik6F5EijKhzmO3Ae1lbiWMk1
H/mX0PGKHs5nBtZdiUFOxCAbcks6UN07xG22zemzPtZSUKRz0+BK/w3cvwUl2pIp
fETsuVNfxT98DUIXudae4dthT48azsTtzxJ27i6TtHwDdqarmEhjPNfYlYldAmvC
/dxLfEjTlI2rlrN805/QlS+/owdYDA7AM3/r45pXh0lY9m3mJsvorBBNR14/HM6B
2/jCVBT4xsHTEWL3Pbi51U/0WsSrHcRJT5ykRuhYoa8Qbe67HK8cCMNwN4TXNUtY
QqEmSZ8bd40t4KsrK5YZ+dKZCKzsc1bjvs35LCtjDuY0ieFX0qjNxwrASg/Yn2xW
KSnnig/DDkQjP18QZtE4kUbnSCzACicDQ8QGJvSqqPwdBXdBkwk=
=rtK7
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--

