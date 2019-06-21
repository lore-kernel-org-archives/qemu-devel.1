Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13CD5C4646C
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 12:17:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9181D21530
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 12:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ZdlmSZUG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9181D21530
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60688 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heIUD-0006VF-Cf
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 08:17:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58788)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1heILU-0008Po-BI
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 08:08:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1heILN-0000uY-Lm
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 08:08:42 -0400
Received: from ozlabs.org ([203.11.71.1]:47521)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1heILK-0000d2-DB; Fri, 21 Jun 2019 08:08:37 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45VcsH52BWz9sND; Fri, 21 Jun 2019 22:08:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1561118899;
 bh=Emh2fk+Y6uIgbEw5A3NZIDX7iBUKLstXiayY+zeLZhU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZdlmSZUGnKJeeF3IglAYl83tXXbmGtfmmFOZ9GmNu5gEx07mrmWvhMkUuFJnnHZke
 vJkqhf+ZC/mz6x5AdMKU8DcPh6NFChLJjUgxedeeek+vK6tix35+SSH03JLKMPxeO2
 kLI1gVipBk/b6V5QXvk/uDyJIKEidicYSkDsxSKw=
Date: Fri, 21 Jun 2019 21:58:15 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Message-ID: <20190621115815.GG8232@umbus.BigPond>
References: <156051052402.224162.13664250996245267046.stgit@bahia.lan>
 <156051055736.224162.11641594431517798715.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="gvF4niNJ+uBMJnEh"
Content-Disposition: inline
In-Reply-To: <156051055736.224162.11641594431517798715.stgit@bahia.lan>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH 6/7] ppc: Introduce
 kvmppc_set_reg_tb_offset() helper
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--gvF4niNJ+uBMJnEh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2019 at 01:09:17PM +0200, Greg Kurz wrote:
> Introduce a KVM helper and its stub instead of guarding the code with
> CONFIG_KVM.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied, thanks.

> ---
>  hw/ppc/ppc.c         |    5 +----
>  target/ppc/kvm.c     |    9 +++++++++
>  target/ppc/kvm_ppc.h |    5 +++++
>  3 files changed, 15 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
> index 288196dfa67a..a9e508c496de 100644
> --- a/hw/ppc/ppc.c
> +++ b/hw/ppc/ppc.c
> @@ -1034,10 +1034,7 @@ static void timebase_load(PPCTimebase *tb)
>      CPU_FOREACH(cpu) {
>          PowerPCCPU *pcpu =3D POWERPC_CPU(cpu);
>          pcpu->env.tb_env->tb_offset =3D tb_off_adj;
> -#if defined(CONFIG_KVM)
> -        kvm_set_one_reg(cpu, KVM_REG_PPC_TB_OFFSET,
> -                        &pcpu->env.tb_env->tb_offset);
> -#endif
> +        kvmppc_set_reg_tb_offset(pcpu, pcpu->env.tb_env->tb_offset);
>      }
>  }
> =20
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index d4107dd70d21..cde39904510a 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -2939,3 +2939,12 @@ void kvmppc_set_reg_ppc_online(PowerPCCPU *cpu, un=
signed int online)
>          kvm_set_one_reg(cs, KVM_REG_PPC_ONLINE, &online);
>      }
>  }
> +
> +void kvmppc_set_reg_tb_offset(PowerPCCPU *cpu, int64_t tb_offset)
> +{
> +    CPUState *cs =3D CPU(cpu);
> +
> +    if (kvm_enabled()) {
> +        kvm_set_one_reg(cs, KVM_REG_PPC_TB_OFFSET, &tb_offset);
> +    }
> +}
> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> index 45776cad79d9..e642aaaf9226 100644
> --- a/target/ppc/kvm_ppc.h
> +++ b/target/ppc/kvm_ppc.h
> @@ -80,6 +80,7 @@ bool kvmppc_pvr_workaround_required(PowerPCCPU *cpu);
>  bool kvmppc_hpt_needs_host_contiguous_pages(void);
>  void kvm_check_mmu(PowerPCCPU *cpu, Error **errp);
>  void kvmppc_set_reg_ppc_online(PowerPCCPU *cpu, unsigned int online);
> +void kvmppc_set_reg_tb_offset(PowerPCCPU *cpu, int64_t tb_offset);
> =20
>  #else
> =20
> @@ -206,6 +207,10 @@ static inline void kvmppc_set_reg_ppc_online(PowerPC=
CPU *cpu,
>      return;
>  }
> =20
> +static inline void kvmppc_set_reg_tb_offset(PowerPCCPU *cpu, int64_t tb_=
offset)
> +{
> +}
> +
>  #ifndef CONFIG_USER_ONLY
>  static inline bool kvmppc_spapr_use_multitce(void)
>  {
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--gvF4niNJ+uBMJnEh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0MxlQACgkQbDjKyiDZ
s5LZFRAA0eaIJ02RDcNEJQhnEwAWIRyqFSERXVR6tl6063P2WJgAcBsU76VZYshX
ZwaH2W5WTJ1MWKlMmbF+6DKZd4BqyP4YOCsgeRvwQFC5mvHdVxXmRFN31VogLUqc
50fgs4teVF4XEbFwmT5WxopzPkCd/GuGjcGXzA+PPFriLc2sl9w898A5979UDPWi
FtveEek9e4rGrO/q1nejDCH6PLMDoIVU6gcsth3lbPfoFyXWUU5Q4sXRWWQzO/EK
rXtbHNDO1m+xSJdE91JVOOaBKTcOpPCmeUPcC3D2ofPR0l2EkJ6s338fMZGZ2P6j
R/bhcMod9UnBBYiP25udF7U6IPosFBsV/QLccPTy8hFptHnvRS/UFXsE7ohYLlZU
vo1fHBx3kiNqj4B9mbniRHECSeStpNnis0lRUEoa8XdC5TlPYhuoY/oU+YP8BGQQ
GX/6APHs8QEy1xHN9hFSmnzXuJZZElLbP2do0wOT5FQOC9jImH+flElnapI1fUqy
isESchXdFyakYHgNw8Lm0LVuPN3XcFQHEBO5gh1A5MGO0GBvW1E+Ng4sPzHkVkv9
sCL5KxM1jw+eWE856XL9eZlviS6fuh8Hr+EsQyx9VQy61Aiy+ghxivHxOcqLJCBs
Gqc/kSkL7Brz85Hjv2I7xr3cTTUg/7MptMGL4kAyjsAj4hN7Ffg=
=Jmy2
-----END PGP SIGNATURE-----

--gvF4niNJ+uBMJnEh--

