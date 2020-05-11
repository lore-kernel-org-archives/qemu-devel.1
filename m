Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05278C38A2A
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 01:50:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9D98207FF
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 01:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Kt+UapPH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9D98207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXxa7-00020x-T0
	for qemu-devel@archiver.kernel.org; Sun, 10 May 2020 21:50:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60664)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jXxUx-00013F-OL; Sun, 10 May 2020 21:44:51 -0400
Received: from ozlabs.org ([203.11.71.1]:45045)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jXxUw-0000lz-FP; Sun, 10 May 2020 21:44:51 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49L3dh3qR8z9sTH; Mon, 11 May 2020 11:44:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1589161480;
 bh=+oObCguYBouRQdHyv9/oUGRBmsEpMGj1T2qMCe/oX1Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Kt+UapPHXGSBuAxGQyF8Ov1EjWozQ9iwsJpF4F20Zoi/giquXiDAzMwxTSbLNbSHQ
 v7tqLXGTd6xmBzTMFO15MDCRnoE3bAq64b8pNaorNeJN+/eQxQ1torang0nDyIP++6
 Toa/hTW8So0eKOURBml9bFbo5W37P2o7N/Wlahkk=
Date: Mon, 11 May 2020 11:43:48 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 6/6] target/ppc: Don't update radix PTE R/C bits with
 gdbstub
Message-ID: <20200511014348.GN2183@umbus.fritz.box>
References: <158887239173.1564424.16721638327458334129.stgit@bahia.lan>
 <158887243487.1564424.7276382177976503972.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="tpyx7gKuSYt+mjHM"
Content-Disposition: inline
In-Reply-To: <158887243487.1564424.7276382177976503972.stgit@bahia.lan>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/10 21:17:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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


--tpyx7gKuSYt+mjHM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 07, 2020 at 07:27:15PM +0200, Greg Kurz wrote:
> gdbstub shouldn't silently change guest visible state when doing address
> translation. While here drop a not very useful comment.
>=20
> This was found while reading the code. I could verify that this affects
> both powernv and pseries, but I failed to observe any actual bug.
>=20
> Fixes: d04ea940c597 "target/ppc: Add support for Radix partition-scoped t=
ranslation"
> Signed-off-by: Greg Kurz <groug@kaod.org>

It's a real fix.  But AFAICT we'll always have cause_excp =3D=3D
cause_rc_update, and I can't see any reason we'd ever them different.
So I'd prefer to just rename the flag and use it for both tests.

Maybe just 'guest_visible' ?

> ---
>  target/ppc/mmu-radix64.c |   36 ++++++++++++++++++++++++------------
>  1 file changed, 24 insertions(+), 12 deletions(-)
>=20
> diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
> index ceeb3dfe2d49..bc51cd89a079 100644
> --- a/target/ppc/mmu-radix64.c
> +++ b/target/ppc/mmu-radix64.c
> @@ -270,7 +270,8 @@ static int ppc_radix64_partition_scoped_xlate(PowerPC=
CPU *cpu, int rwx,
>                                                ppc_v3_pate_t pate,
>                                                hwaddr *h_raddr, int *h_pr=
ot,
>                                                int *h_page_size, bool pde=
_addr,
> -                                              bool cause_excp)
> +                                              bool cause_excp,
> +                                              bool cause_rc_update)
>  {
>      int fault_cause =3D 0;
>      hwaddr pte_addr;
> @@ -291,8 +292,9 @@ static int ppc_radix64_partition_scoped_xlate(PowerPC=
CPU *cpu, int rwx,
>          return 1;
>      }
> =20
> -    /* Update Reference and Change Bits */
> -    ppc_radix64_set_rc(cpu, rwx, pte, pte_addr, h_prot);
> +    if (cause_rc_update) {
> +        ppc_radix64_set_rc(cpu, rwx, pte, pte_addr, h_prot);
> +    }
> =20
>      return 0;
>  }
> @@ -301,7 +303,8 @@ static int ppc_radix64_process_scoped_xlate(PowerPCCP=
U *cpu, int rwx,
>                                              vaddr eaddr, uint64_t pid,
>                                              ppc_v3_pate_t pate, hwaddr *=
g_raddr,
>                                              int *g_prot, int *g_page_siz=
e,
> -                                            bool cause_excp)
> +                                            bool cause_excp,
> +                                            bool cause_rc_update)
>  {
>      CPUState *cs =3D CPU(cpu);
>      CPUPPCState *env =3D &cpu->env;
> @@ -336,7 +339,8 @@ static int ppc_radix64_process_scoped_xlate(PowerPCCP=
U *cpu, int rwx,
>          ret =3D ppc_radix64_partition_scoped_xlate(cpu, 0, eaddr, prtbe_=
addr,
>                                                   pate, &h_raddr, &h_prot,
>                                                   &h_page_size, true,
> -                                                 cause_excp);
> +                                                 cause_excp,
> +                                                 cause_rc_update);
>          if (ret) {
>              return ret;
>          }
> @@ -376,7 +380,8 @@ static int ppc_radix64_process_scoped_xlate(PowerPCCP=
U *cpu, int rwx,
>              ret =3D ppc_radix64_partition_scoped_xlate(cpu, 0, eaddr, pt=
e_addr,
>                                                       pate, &h_raddr, &h_=
prot,
>                                                       &h_page_size, true,
> -                                                     cause_excp);
> +                                                     cause_excp,
> +                                                     cause_rc_update);
>              if (ret) {
>                  return ret;
>              }
> @@ -408,7 +413,9 @@ static int ppc_radix64_process_scoped_xlate(PowerPCCP=
U *cpu, int rwx,
>          return 1;
>      }
> =20
> -    ppc_radix64_set_rc(cpu, rwx, pte, pte_addr, g_prot);
> +    if (cause_rc_update) {
> +        ppc_radix64_set_rc(cpu, rwx, pte, pte_addr, g_prot);
> +    }
> =20
>      return 0;
>  }
> @@ -433,7 +440,8 @@ static int ppc_radix64_process_scoped_xlate(PowerPCCP=
U *cpu, int rwx,
>  static int ppc_radix64_xlate(PowerPCCPU *cpu, vaddr eaddr, int rwx,
>                               bool relocation,
>                               hwaddr *raddr, int *psizep, int *protp,
> -                             bool cause_excp)
> +                             bool cause_excp,
> +                             bool cause_rc_update)
>  {
>      CPUPPCState *env =3D &cpu->env;
>      uint64_t lpid, pid;
> @@ -483,7 +491,9 @@ static int ppc_radix64_xlate(PowerPCCPU *cpu, vaddr e=
addr, int rwx,
>      if (relocation) {
>          int ret =3D ppc_radix64_process_scoped_xlate(cpu, rwx, eaddr, pi=
d,
>                                                     pate, &g_raddr, &prot,
> -                                                   &psize, cause_excp);
> +                                                   &psize,
> +                                                   cause_excp,
> +                                                   cause_rc_update);
>          if (ret) {
>              return ret;
>          }
> @@ -506,7 +516,9 @@ static int ppc_radix64_xlate(PowerPCCPU *cpu, vaddr e=
addr, int rwx,
> =20
>              ret =3D ppc_radix64_partition_scoped_xlate(cpu, rwx, eaddr, =
g_raddr,
>                                                       pate, raddr, &prot,=
 &psize,
> -                                                     0, cause_excp);
> +                                                     0,
> +                                                     cause_excp,
> +                                                     cause_rc_update);
>              if (ret) {
>                  return ret;
>              }
> @@ -562,7 +574,7 @@ int ppc_radix64_handle_mmu_fault(PowerPCCPU *cpu, vad=
dr eaddr, int rwx,
> =20
>      /* Translate eaddr to raddr (where raddr is addr qemu needs for acce=
ss) */
>      if (ppc_radix64_xlate(cpu, eaddr, rwx, relocation, &raddr,
> -                          &page_size, &prot, true)) {
> +                          &page_size, &prot, true, true)) {
>          return 1;
>      }
> =20
> @@ -584,7 +596,7 @@ hwaddr ppc_radix64_get_phys_page_debug(PowerPCCPU *cp=
u, target_ulong eaddr)
>      }
> =20
>      if (ppc_radix64_xlate(cpu, eaddr, 0, msr_dr, &raddr, &psize,
> -                          &prot, false)) {
> +                          &prot, false, false)) {
>          return -1;
>      }
> =20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--tpyx7gKuSYt+mjHM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl64rdQACgkQbDjKyiDZ
s5Kc4Q//ZHs+t+DSztlUdhbO+khQ/fojmQZ2fZH1ezpgjMIINIe1DMgDcnhZgX5F
h3CVn7Slj94eFPT0MncRCNLvz+N8+pmM/HefcMKPpSiKza7cHyVf7zhzbkyqMnpx
BTDVoypzcncPPfbiWnrX+hk6cagO13eGFTq76+4J/e7VdaxGW0NYwl7XxmgqQiNh
rWzX4nAo/TCRcfennmezu37HwYogUOrLPvA3KMSjUDh9CQ4TPJSJQU8a4OEX8Aqu
x9CWy1SMVS71lYZO0KcdbiAFXbLaN7B55BjI9td6wsXGo0f3FfYhc8tyy9IouT3u
SxVEpvnjoviQZ5/JqYx9KChLk/t98z8m/avuqRRMQGSxzUfwgzD9vSzjjtoAS2iB
O+VhDn5F/RC63oGw4Xlv6Top+DRcgXGa20gxj3c3CehwgMoETe8uIck0dQdNNG2w
GF3OmwfW8GtbFq2xDVDoQdghY/1pykjKX4YypsNqK2TAf/a4+pZ5/sRAqcWVJs3T
YrHT2KN+0POsE6pRk2JV62NU+3dfjmVwC7YPjQRPXb2ogxj24dYjfRsTe0mLzUy8
1bs5b87TgXRfXhICE8e1axzpKwMiLQfMLTFOS2FcbRd9kUV7F+FQyU0DD+dgZorv
3h0fXrGYHbD1MJ9yKdUj6SDuDsx+4w7cM05Jk4rmsHGfZfOi4uU=
=xohv
-----END PGP SIGNATURE-----

--tpyx7gKuSYt+mjHM--

