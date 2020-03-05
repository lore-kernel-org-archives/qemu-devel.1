Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B1FDC3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 09:21:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6679D20870
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 09:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AQK8vPDU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6679D20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9mhU-0004Id-LF
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 04:21:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57684)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j9md0-0007BH-Vz
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 04:17:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j9mcz-0006E0-8q
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 04:17:14 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30244
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j9mcz-0006Dn-5j
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 04:17:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583399832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S8dBFiAueIRgg+I3eciWAuVQYiIdrgGLq7Vh5RN5zHI=;
 b=AQK8vPDUm8x0Ss3M3z2nJlWZt5T1PF2On9ESZswOxL+1FPiV1cjbgCtCeGEAsh5185FqrF
 VCdIYdG/GfWUg2RbMUnb+B3hmdn5GJLWjnqQh+ns3MUYatqf+Lcmmtn3anDnwY72CIRKE/
 iluM9RNMTj94ixT67ioRs35Whf3SrIY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-J_DA_aN8Oj6mWY8Xtej6BQ-1; Thu, 05 Mar 2020 04:17:08 -0500
X-MC-Unique: J_DA_aN8Oj6mWY8Xtej6BQ-1
Received: by mail-ed1-f72.google.com with SMTP id y23so3901567edt.2
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 01:17:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1GeNh3pDeMWkP307y0ZOfzMWWNA5A4ck1U/lHK/oiMQ=;
 b=BMzGSpG57JrVtytud2KrPOi1LuqPlGU6/hUbmmFewnu7OLK5/MPGGFJ9/wx2oDTEPf
 Ez7W1ir/ww7KnvfWGfvsD+A/0QbIMpw0fIwgc+XqZLr2kMnva268nToXS9QNOImQby8W
 vLjNkdq4+rlizgRD11ed9kQcinkjWuA8+rKqo+UixEwJZBS7ESElXSy+a8Xqe6eZqpIA
 iVdvbIfNkX5KD8rVVZ53U2I5hOLf/Ii6iBzpGFl26BRAaozktKaGsOIKG8DTVepjRIoE
 FKxYhld5SNgQqOdwZEZ9zg0fPH/TRO72i8l4Zbhtjr5lE0kU4SOWjZXG2cbHm8r2svvJ
 Es4w==
X-Gm-Message-State: ANhLgQ3av5n+DQH0QmmQ5gBxftJ8NNuQJb0S8EoojILAPfMf2NwBMwwr
 KvyVTA1/4L41WjfBkqnGg4Oe0h2Nm20tR0+1vqOyE3oy9Qp2xTt2wiAq5UXNlj43bUwtMtd9y+c
 CLtk8YgtGvjN/eig=
X-Received: by 2002:a50:fb02:: with SMTP id d2mr7229309edq.270.1583399826926; 
 Thu, 05 Mar 2020 01:17:06 -0800 (PST)
X-Google-Smtp-Source: ADFU+vub67LLGU4X08P1iTU19NZMbUc2hyhBo72YJn58wyVtQme/rolifdizy0pMhY2s5W/XoFedBg==
X-Received: by 2002:a50:fb02:: with SMTP id d2mr7229281edq.270.1583399826687; 
 Thu, 05 Mar 2020 01:17:06 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id o17sm20683edz.83.2020.03.05.01.17.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Mar 2020 01:17:05 -0800 (PST)
Subject: Re: [PATCH v7 11/17] target/ppc: Don't store VRMA SLBE persistently
To: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 clg@kaod.org, qemu-devel@nongnu.org, groug@kaod.org
References: <20200303034351.333043-1-david@gibson.dropbear.id.au>
 <20200303034351.333043-12-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <efb1558c-15ab-70f8-0963-357c45da2682@redhat.com>
Date: Thu, 5 Mar 2020 10:17:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200303034351.333043-12-david@gibson.dropbear.id.au>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: lvivier@redhat.com, Thomas Huth <thuth@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, aik@ozlabs.ru, farosas@linux.ibm.com,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Igor Mammedov <imammedo@redhat.com>, paulus@samba.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi David,

On 3/3/20 4:43 AM, David Gibson wrote:
> Currently, we construct the SLBE used for VRMA translations when the LPCR
> is written (which controls some bits in the SLBE), then use it later for
> translations.
>=20
> This is a bit complex and confusing - simplify it by simply constructing
> the SLBE directly from the LPCR when we need it.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>   target/ppc/cpu.h        |  3 --
>   target/ppc/mmu-hash64.c | 92 ++++++++++++++++-------------------------
>   2 files changed, 35 insertions(+), 60 deletions(-)
>=20
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index f9871b1233..5a55fb02bd 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1044,9 +1044,6 @@ struct CPUPPCState {
>       uint32_t flags;
>       uint64_t insns_flags;
>       uint64_t insns_flags2;
> -#if defined(TARGET_PPC64)
> -    ppc_slb_t vrma_slb;
> -#endif

I find it confusing to move this member to the stack, when other slb=20
stay on the CPUState context on the heap.

Consider amending the following (I can also send a patch later if you=20
prefer):

-- >8 --
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 5a55fb02bd..ade71c3592 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -988,6 +988,7 @@ struct CPUPPCState {
      /* MMU context, only relevant for full system emulation */
  #if defined(TARGET_PPC64)
      ppc_slb_t slb[MAX_SLB_ENTRIES]; /* PowerPC 64 SLB area */
+    ppc_slb_t vrma_slbe;
  #endif
      target_ulong sr[32];   /* segment registers */
      uint32_t nb_BATs;      /* number of BATs */
diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index 34f6009b1e..abbdd531c6 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -818,7 +818,6 @@ int ppc_hash64_handle_mmu_fault(PowerPCCPU *cpu,=20
vaddr eaddr,
  {
      CPUState *cs =3D CPU(cpu);
      CPUPPCState *env =3D &cpu->env;
-    ppc_slb_t vrma_slbe;
      ppc_slb_t *slb;
      unsigned apshift;
      hwaddr ptex;
@@ -857,7 +856,7 @@ int ppc_hash64_handle_mmu_fault(PowerPCCPU *cpu,=20
vaddr eaddr,
              }
          } else if (ppc_hash64_use_vrma(env)) {
              /* Emulated VRMA mode */
-            slb =3D &vrma_slbe;
+            slb =3D &env->vrma_slbe;
              if (build_vrma_slbe(cpu, slb) !=3D 0) {
                  /* Invalid VRMA setup, machine check */
                  cs->exception_index =3D POWERPC_EXCP_MCHECK;
@@ -1006,7 +1005,6 @@ skip_slb_search:
  hwaddr ppc_hash64_get_phys_page_debug(PowerPCCPU *cpu, target_ulong addr)
  {
      CPUPPCState *env =3D &cpu->env;
-    ppc_slb_t vrma_slbe;
      ppc_slb_t *slb;
      hwaddr ptex, raddr;
      ppc_hash_pte64_t pte;
@@ -1028,7 +1026,7 @@ hwaddr ppc_hash64_get_phys_page_debug(PowerPCCPU=20
*cpu, target_ulong addr)
              return raddr | env->spr[SPR_HRMOR];
          } else if (ppc_hash64_use_vrma(env)) {
              /* Emulated VRMA mode */
-            slb =3D &vrma_slbe;
+            slb =3D &env->vrma_slbe;
              if (build_vrma_slbe(cpu, slb) !=3D 0) {
                  return -1;
              }
---

With the hunk amended I dare to give:
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

>  =20
>       int error_code;
>       uint32_t pending_interrupts;
> diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> index 4fd7b7ee74..34f6009b1e 100644
> --- a/target/ppc/mmu-hash64.c
> +++ b/target/ppc/mmu-hash64.c
> @@ -784,11 +784,41 @@ static target_ulong rmls_limit(PowerPCCPU *cpu)
>       return rma_sizes[rmls];
>   }
>  =20
> +static int build_vrma_slbe(PowerPCCPU *cpu, ppc_slb_t *slb)
> +{
> +    CPUPPCState *env =3D &cpu->env;
> +    target_ulong lpcr =3D env->spr[SPR_LPCR];
> +    uint32_t vrmasd =3D (lpcr & LPCR_VRMASD) >> LPCR_VRMASD_SHIFT;
> +    target_ulong vsid =3D SLB_VSID_VRMA | ((vrmasd << 4) & SLB_VSID_LLP_=
MASK);
> +    int i;
> +
> +    for (i =3D 0; i < PPC_PAGE_SIZES_MAX_SZ; i++) {
> +        const PPCHash64SegmentPageSizes *sps =3D &cpu->hash64_opts->sps[=
i];
> +
> +        if (!sps->page_shift) {
> +            break;
> +        }
> +
> +        if ((vsid & SLB_VSID_LLP_MASK) =3D=3D sps->slb_enc) {
> +            slb->esid =3D SLB_ESID_V;
> +            slb->vsid =3D vsid;
> +            slb->sps =3D sps;
> +            return 0;
> +        }
> +    }
> +
> +    error_report("Bad page size encoding in LPCR[VRMASD]; LPCR=3D0x"
> +                 TARGET_FMT_lx"\n", lpcr);
> +
> +    return -1;
> +}
> +
>   int ppc_hash64_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr,
>                                   int rwx, int mmu_idx)
>   {
>       CPUState *cs =3D CPU(cpu);
>       CPUPPCState *env =3D &cpu->env;
> +    ppc_slb_t vrma_slbe;
>       ppc_slb_t *slb;
>       unsigned apshift;
>       hwaddr ptex;
> @@ -827,8 +857,8 @@ int ppc_hash64_handle_mmu_fault(PowerPCCPU *cpu, vadd=
r eaddr,
>               }
>           } else if (ppc_hash64_use_vrma(env)) {
>               /* Emulated VRMA mode */
> -            slb =3D &env->vrma_slb;
> -            if (!slb->sps) {
> +            slb =3D &vrma_slbe;
> +            if (build_vrma_slbe(cpu, slb) !=3D 0) {
>                   /* Invalid VRMA setup, machine check */
>                   cs->exception_index =3D POWERPC_EXCP_MCHECK;
>                   env->error_code =3D 0;
> @@ -976,6 +1006,7 @@ skip_slb_search:
>   hwaddr ppc_hash64_get_phys_page_debug(PowerPCCPU *cpu, target_ulong add=
r)
>   {
>       CPUPPCState *env =3D &cpu->env;
> +    ppc_slb_t vrma_slbe;
>       ppc_slb_t *slb;
>       hwaddr ptex, raddr;
>       ppc_hash_pte64_t pte;
> @@ -997,8 +1028,8 @@ hwaddr ppc_hash64_get_phys_page_debug(PowerPCCPU *cp=
u, target_ulong addr)
>               return raddr | env->spr[SPR_HRMOR];
>           } else if (ppc_hash64_use_vrma(env)) {
>               /* Emulated VRMA mode */
> -            slb =3D &env->vrma_slb;
> -            if (!slb->sps) {
> +            slb =3D &vrma_slbe;
> +            if (build_vrma_slbe(cpu, slb) !=3D 0) {
>                   return -1;
>               }
>           } else {
> @@ -1037,65 +1068,12 @@ void ppc_hash64_tlb_flush_hpte(PowerPCCPU *cpu, t=
arget_ulong ptex,
>       cpu->env.tlb_need_flush =3D TLB_NEED_GLOBAL_FLUSH | TLB_NEED_LOCAL_=
FLUSH;
>   }
>  =20
> -static void ppc_hash64_update_vrma(PowerPCCPU *cpu)
> -{
> -    CPUPPCState *env =3D &cpu->env;
> -    const PPCHash64SegmentPageSizes *sps =3D NULL;
> -    target_ulong esid, vsid, lpcr;
> -    ppc_slb_t *slb =3D &env->vrma_slb;
> -    uint32_t vrmasd;
> -    int i;
> -
> -    /* First clear it */
> -    slb->esid =3D slb->vsid =3D 0;
> -    slb->sps =3D NULL;
> -
> -    /* Is VRMA enabled ? */
> -    if (!ppc_hash64_use_vrma(env)) {
> -        return;
> -    }
> -
> -    /*
> -     * Make one up. Mostly ignore the ESID which will not be needed
> -     * for translation
> -     */
> -    lpcr =3D env->spr[SPR_LPCR];
> -    vsid =3D SLB_VSID_VRMA;
> -    vrmasd =3D (lpcr & LPCR_VRMASD) >> LPCR_VRMASD_SHIFT;
> -    vsid |=3D (vrmasd << 4) & (SLB_VSID_L | SLB_VSID_LP);
> -    esid =3D SLB_ESID_V;
> -
> -    for (i =3D 0; i < PPC_PAGE_SIZES_MAX_SZ; i++) {
> -        const PPCHash64SegmentPageSizes *sps1 =3D &cpu->hash64_opts->sps=
[i];
> -
> -        if (!sps1->page_shift) {
> -            break;
> -        }
> -
> -        if ((vsid & SLB_VSID_LLP_MASK) =3D=3D sps1->slb_enc) {
> -            sps =3D sps1;
> -            break;
> -        }
> -    }
> -
> -    if (!sps) {
> -        error_report("Bad page size encoding esid 0x"TARGET_FMT_lx
> -                     " vsid 0x"TARGET_FMT_lx, esid, vsid);
> -        return;
> -    }
> -
> -    slb->vsid =3D vsid;
> -    slb->esid =3D esid;
> -    slb->sps =3D sps;
> -}
> -
>   void ppc_store_lpcr(PowerPCCPU *cpu, target_ulong val)
>   {
>       PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
>       CPUPPCState *env =3D &cpu->env;
>  =20
>       env->spr[SPR_LPCR] =3D val & pcc->lpcr_mask;
> -    ppc_hash64_update_vrma(cpu);
>   }
>  =20
>   void helper_store_lpcr(CPUPPCState *env, target_ulong val)
>=20


