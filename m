Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DFBBC38A2A
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 01:21:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA72C208CA
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 01:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="U9Jmj3Ob"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA72C208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXx8c-00074t-6c
	for qemu-devel@archiver.kernel.org; Sun, 10 May 2020 21:21:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58020)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jXx56-0004FJ-9z; Sun, 10 May 2020 21:18:08 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:58439)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jXx53-0000Da-RE; Sun, 10 May 2020 21:18:08 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49L32n6MYNz9sRf; Mon, 11 May 2020 11:17:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1589159873;
 bh=IC+DRYVrifSlvzsF0nUJCSElXXUTqsR1mbpFpQcOVyY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=U9Jmj3ObWXVl20bIOghx/B+PvNSXNs8rZPNM1Z/TmMX7LwJPdYVtFVNE/jhRdrzXS
 S1rly64BiliEtzHoE2+KPMdhdVf+NgQfeZK6LGO4YlVf2iMo6gxm0iXdYPcVZXov8r
 vSW8GGeWf01GRhV9tzmHbACeuMBAmSXwi3ma+1tQ=
Date: Mon, 11 May 2020 11:16:34 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [PATCH 09/11] target/cpu: Restrict handlers using hwaddr type to
 system-mode
Message-ID: <20200511011634.GD2183@umbus.fritz.box>
References: <20200509130910.26335-1-f4bug@amsat.org>
 <20200509130910.26335-10-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Qrgsu6vtpU/OV/zm"
Content-Disposition: inline
In-Reply-To: <20200509130910.26335-10-f4bug@amsat.org>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Chris Wulff <crwulff@gmail.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Max Filippov <jcmvbkbc@gmail.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Marek Vasut <marex@denx.de>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, qemu-ppc@nongnu.org,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, Stafford Horne <shorne@gmail.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>, qemu-riscv@nongnu.org,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>, Roman Bolshakov <r.bolshakov@yadro.com>,
 Laurent Vivier <laurent@vivier.eu>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Qrgsu6vtpU/OV/zm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 09, 2020 at 03:09:08PM +0200, Philippe Mathieu-Daud=E9 wrote:
> Restrict the following handlers to system-mode:
> - do_unaligned_access
> - do_transaction_failed
> - get_phys_page_debug
> - get_phys_page_attrs_debug
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>

ppc parts

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  include/hw/core/cpu.h           |  8 +++++---
>  target/alpha/cpu.h              |  4 +++-
>  target/arm/cpu.h                |  6 +++---
>  target/arm/internals.h          |  4 ++++
>  target/cris/cpu.h               |  2 ++
>  target/hppa/cpu.h               |  2 +-
>  target/i386/cpu.h               |  2 ++
>  target/m68k/cpu.h               |  7 ++++++-
>  target/microblaze/cpu.h         |  5 ++++-
>  target/mips/internal.h          |  2 +-
>  target/nios2/cpu.h              |  5 ++++-
>  target/openrisc/cpu.h           |  3 ++-
>  target/ppc/cpu.h                |  2 +-
>  target/riscv/cpu.h              | 20 ++++++++++----------
>  target/sh4/cpu.h                |  2 +-
>  target/sparc/cpu.h              |  2 ++
>  target/xtensa/cpu.h             | 12 +++++++-----
>  target/hppa/cpu.c               |  4 +++-
>  target/ppc/translate_init.inc.c |  2 +-
>  19 files changed, 62 insertions(+), 32 deletions(-)
>=20
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 5bf94d28cf..ed09d056d1 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -167,6 +167,7 @@ typedef struct CPUClass {
>      int reset_dump_flags;
>      bool (*has_work)(CPUState *cpu);
>      void (*do_interrupt)(CPUState *cpu);
> +#ifndef CONFIG_USER_ONLY
>      void (*do_unaligned_access)(CPUState *cpu, vaddr addr,
>                                  MMUAccessType access_type,
>                                  int mmu_idx, uintptr_t retaddr);
> @@ -174,6 +175,10 @@ typedef struct CPUClass {
>                                    unsigned size, MMUAccessType access_ty=
pe,
>                                    int mmu_idx, MemTxAttrs attrs,
>                                    MemTxResult response, uintptr_t retadd=
r);
> +    hwaddr (*get_phys_page_debug)(CPUState *cpu, vaddr addr);
> +    hwaddr (*get_phys_page_attrs_debug)(CPUState *cpu, vaddr addr,
> +                                        MemTxAttrs *attrs);
> +#endif /* CONFIG_USER_ONLY */
>      bool (*virtio_is_big_endian)(CPUState *cpu);
>      int (*memory_rw_debug)(CPUState *cpu, vaddr addr,
>                             uint8_t *buf, int len, bool is_write);
> @@ -189,9 +194,6 @@ typedef struct CPUClass {
>      bool (*tlb_fill)(CPUState *cpu, vaddr address, int size,
>                       MMUAccessType access_type, int mmu_idx,
>                       bool probe, uintptr_t retaddr);
> -    hwaddr (*get_phys_page_debug)(CPUState *cpu, vaddr addr);
> -    hwaddr (*get_phys_page_attrs_debug)(CPUState *cpu, vaddr addr,
> -                                        MemTxAttrs *attrs);
>      int (*asidx_from_attrs)(CPUState *cpu, MemTxAttrs attrs);
>      int (*gdb_read_register)(CPUState *cpu, GByteArray *buf, int reg);
>      int (*gdb_write_register)(CPUState *cpu, uint8_t *buf, int reg);
> diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
> index be29bdd530..b12021803e 100644
> --- a/target/alpha/cpu.h
> +++ b/target/alpha/cpu.h
> @@ -279,12 +279,14 @@ extern const VMStateDescription vmstate_alpha_cpu;
>  void alpha_cpu_do_interrupt(CPUState *cpu);
>  bool alpha_cpu_exec_interrupt(CPUState *cpu, int int_req);
>  void alpha_cpu_dump_state(CPUState *cs, FILE *f, int flags);
> -hwaddr alpha_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
>  int alpha_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
>  int alpha_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
> +#ifndef CONFIG_USER_ONLY
> +hwaddr alpha_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
>  void alpha_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
>                                     MMUAccessType access_type,
>                                     int mmu_idx, uintptr_t retaddr);
> +#endif
> =20
>  #define cpu_list alpha_cpu_list
>  #define cpu_signal_handler cpu_alpha_signal_handler
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 8608da6b6f..d333036bb4 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -966,15 +966,15 @@ uint64_t arm_cpu_mp_affinity(int idx, uint8_t clust=
ersz);
> =20
>  #ifndef CONFIG_USER_ONLY
>  extern const VMStateDescription vmstate_arm_cpu;
> +
> +hwaddr arm_cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr addr,
> +                                         MemTxAttrs *attrs);
>  #endif
> =20
>  void arm_cpu_do_interrupt(CPUState *cpu);
>  void arm_v7m_cpu_do_interrupt(CPUState *cpu);
>  bool arm_cpu_exec_interrupt(CPUState *cpu, int int_req);
> =20
> -hwaddr arm_cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr addr,
> -                                         MemTxAttrs *attrs);
> -
>  int arm_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
>  int arm_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
> =20
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index e633aff36e..c0a2a5df71 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -812,6 +812,8 @@ ARMMMUIdx arm_v7m_mmu_idx_for_secstate(CPUARMState *e=
nv, bool secstate);
>   * tables */
>  bool arm_s1_regime_using_lpae_format(CPUARMState *env, ARMMMUIdx mmu_idx=
);
> =20
> +#ifndef CONFIG_USER_ONLY
> +
>  /* Raise a data fault alignment exception for the specified virtual addr=
ess */
>  void arm_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
>                                   MMUAccessType access_type,
> @@ -827,6 +829,8 @@ void arm_cpu_do_transaction_failed(CPUState *cs, hwad=
dr physaddr,
>                                     int mmu_idx, MemTxAttrs attrs,
>                                     MemTxResult response, uintptr_t retad=
dr);
> =20
> +#endif /* !CONFIG_USER_ONLY */
> +
>  /* Call any registered EL change hooks */
>  static inline void arm_call_pre_el_change_hook(ARMCPU *cpu)
>  {
> diff --git a/target/cris/cpu.h b/target/cris/cpu.h
> index 8f08d7628b..e9c858ada7 100644
> --- a/target/cris/cpu.h
> +++ b/target/cris/cpu.h
> @@ -193,7 +193,9 @@ bool cris_cpu_exec_interrupt(CPUState *cpu, int int_r=
eq);
> =20
>  void cris_cpu_dump_state(CPUState *cs, FILE *f, int flags);
> =20
> +#ifndef CONFIG_USER_ONLY
>  hwaddr cris_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
> +#endif
> =20
>  int crisv10_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int re=
g);
>  int cris_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
> diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
> index 801a4fb1ba..7848425f6a 100644
> --- a/target/hppa/cpu.h
> +++ b/target/hppa/cpu.h
> @@ -320,7 +320,6 @@ void cpu_hppa_change_prot_id(CPUHPPAState *env);
>  #define cpu_signal_handler cpu_hppa_signal_handler
> =20
>  int cpu_hppa_signal_handler(int host_signum, void *pinfo, void *puc);
> -hwaddr hppa_cpu_get_phys_page_debug(CPUState *cs, vaddr addr);
>  int hppa_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
>  int hppa_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
>  void hppa_cpu_do_interrupt(CPUState *cpu);
> @@ -330,6 +329,7 @@ bool hppa_cpu_tlb_fill(CPUState *cs, vaddr address, i=
nt size,
>                         MMUAccessType access_type, int mmu_idx,
>                         bool probe, uintptr_t retaddr);
>  #ifndef CONFIG_USER_ONLY
> +hwaddr hppa_cpu_get_phys_page_debug(CPUState *cs, vaddr addr);
>  int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
>                                int type, hwaddr *pphys, int *pprot);
>  extern const MemoryRegionOps hppa_io_eir_ops;
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index e818fc712a..00e0cc0828 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1767,8 +1767,10 @@ void x86_cpu_get_memory_mapping(CPUState *cpu, Mem=
oryMappingList *list,
> =20
>  void x86_cpu_dump_state(CPUState *cs, FILE *f, int flags);
> =20
> +#ifndef CONFIG_USER_ONLY
>  hwaddr x86_cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr addr,
>                                           MemTxAttrs *attrs);
> +#endif
> =20
>  int x86_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
>  int x86_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
> diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
> index 521ac67cdd..efc940e7ec 100644
> --- a/target/m68k/cpu.h
> +++ b/target/m68k/cpu.h
> @@ -167,10 +167,13 @@ struct M68kCPU {
>  void m68k_cpu_do_interrupt(CPUState *cpu);
>  bool m68k_cpu_exec_interrupt(CPUState *cpu, int int_req);
>  void m68k_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
> -hwaddr m68k_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
>  int m68k_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
>  int m68k_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
> =20
> +#ifndef CONFIG_USER_ONLY
> +hwaddr m68k_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
> +#endif
> +
>  void m68k_tcg_init(void);
>  void m68k_cpu_init_gdb(M68kCPU *cpu);
>  /*
> @@ -529,10 +532,12 @@ static inline int cpu_mmu_index (CPUM68KState *env,=
 bool ifetch)
>  bool m68k_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>                         MMUAccessType access_type, int mmu_idx,
>                         bool probe, uintptr_t retaddr);
> +#ifndef CONFIG_USER_ONLY
>  void m68k_cpu_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr ad=
dr,
>                                   unsigned size, MMUAccessType access_typ=
e,
>                                   int mmu_idx, MemTxAttrs attrs,
>                                   MemTxResult response, uintptr_t retaddr=
);
> +#endif
> =20
>  typedef CPUM68KState CPUArchState;
>  typedef M68kCPU ArchCPU;
> diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
> index a31134b65c..eb57f04d3f 100644
> --- a/target/microblaze/cpu.h
> +++ b/target/microblaze/cpu.h
> @@ -318,10 +318,13 @@ struct MicroBlazeCPU {
>  void mb_cpu_do_interrupt(CPUState *cs);
>  bool mb_cpu_exec_interrupt(CPUState *cs, int int_req);
>  void mb_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
> -hwaddr mb_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
>  int mb_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
>  int mb_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
> =20
> +#ifndef CONFIG_USER_ONLY
> +hwaddr mb_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
> +#endif
> +
>  void mb_tcg_init(void);
>  /* you can call this signal handler from your SIGBUS and SIGSEGV
>     signal handlers to inform the virtual CPU of exceptions. non zero
> diff --git a/target/mips/internal.h b/target/mips/internal.h
> index 1bf274b3ef..c38666c6f5 100644
> --- a/target/mips/internal.h
> +++ b/target/mips/internal.h
> @@ -81,7 +81,6 @@ enum CPUMIPSMSADataFormat {
>  void mips_cpu_do_interrupt(CPUState *cpu);
>  bool mips_cpu_exec_interrupt(CPUState *cpu, int int_req);
>  void mips_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
> -hwaddr mips_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
>  int mips_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
>  int mips_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
>  void mips_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
> @@ -150,6 +149,7 @@ void mips_cpu_do_transaction_failed(CPUState *cs, hwa=
ddr physaddr,
>                                      MemTxResult response, uintptr_t reta=
ddr);
>  hwaddr cpu_mips_translate_address(CPUMIPSState *env, target_ulong addres=
s,
>                                    int rw);
> +hwaddr mips_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
>  #endif
> =20
>  #define cpu_signal_handler cpu_mips_signal_handler
> diff --git a/target/nios2/cpu.h b/target/nios2/cpu.h
> index 4dddf9c3a1..0703295133 100644
> --- a/target/nios2/cpu.h
> +++ b/target/nios2/cpu.h
> @@ -199,11 +199,14 @@ void nios2_cpu_do_interrupt(CPUState *cs);
>  int cpu_nios2_signal_handler(int host_signum, void *pinfo, void *puc);
>  void dump_mmu(CPUNios2State *env);
>  void nios2_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
> -hwaddr nios2_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
>  void nios2_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
>                                     MMUAccessType access_type,
>                                     int mmu_idx, uintptr_t retaddr);
> =20
> +#ifndef CONFIG_USER_ONLY
> +hwaddr nios2_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
> +#endif
> +
>  qemu_irq *nios2_cpu_pic_init(Nios2CPU *cpu);
>  void nios2_check_interrupts(CPUNios2State *env);
> =20
> diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
> index f37a52e153..60de8ed787 100644
> --- a/target/openrisc/cpu.h
> +++ b/target/openrisc/cpu.h
> @@ -319,7 +319,6 @@ void cpu_openrisc_list(void);
>  void openrisc_cpu_do_interrupt(CPUState *cpu);
>  bool openrisc_cpu_exec_interrupt(CPUState *cpu, int int_req);
>  void openrisc_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
> -hwaddr openrisc_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
>  int openrisc_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int r=
eg);
>  int openrisc_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg=
);
>  void openrisc_translate_init(void);
> @@ -335,6 +334,8 @@ int print_insn_or1k(bfd_vma addr, disassemble_info *i=
nfo);
>  #ifndef CONFIG_USER_ONLY
>  extern const VMStateDescription vmstate_openrisc_cpu;
> =20
> +hwaddr openrisc_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
> +
>  /* hw/openrisc_pic.c */
>  void cpu_openrisc_pic_init(OpenRISCCPU *cpu);
> =20
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 73920a9cac..f7b27aefed 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1209,12 +1209,12 @@ void ppc_cpu_do_interrupt(CPUState *cpu);
>  bool ppc_cpu_exec_interrupt(CPUState *cpu, int int_req);
>  void ppc_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
>  void ppc_cpu_dump_statistics(CPUState *cpu, int flags);
> -hwaddr ppc_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
>  int ppc_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
>  int ppc_cpu_gdb_read_register_apple(CPUState *cpu, GByteArray *buf, int =
reg);
>  int ppc_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
>  int ppc_cpu_gdb_write_register_apple(CPUState *cpu, uint8_t *buf, int re=
g);
>  #ifndef CONFIG_USER_ONLY
> +hwaddr ppc_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
>  void ppc_gdb_gen_spr_xml(PowerPCCPU *cpu);
>  const char *ppc_gdb_get_dynamic_xml(CPUState *cs, const char *xml_name);
>  #endif
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index d0e7f5b9c5..69edee6484 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -303,18 +303,9 @@ void riscv_cpu_set_virt_enabled(CPURISCVState *env, =
bool enable);
>  bool riscv_cpu_force_hs_excep_enabled(CPURISCVState *env);
>  void riscv_cpu_set_force_hs_excep(CPURISCVState *env, bool enable);
>  int riscv_cpu_mmu_index(CPURISCVState *env, bool ifetch);
> -hwaddr riscv_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
> -void  riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
> -                                    MMUAccessType access_type, int mmu_i=
dx,
> -                                    uintptr_t retaddr);
>  bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>                          MMUAccessType access_type, int mmu_idx,
>                          bool probe, uintptr_t retaddr);
> -void riscv_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
> -                                     vaddr addr, unsigned size,
> -                                     MMUAccessType access_type,
> -                                     int mmu_idx, MemTxAttrs attrs,
> -                                     MemTxResult response, uintptr_t ret=
addr);
>  char *riscv_isa_string(RISCVCPU *cpu);
>  void riscv_cpu_list(void);
> =20
> @@ -323,12 +314,21 @@ void riscv_cpu_list(void);
>  #define cpu_mmu_index riscv_cpu_mmu_index
> =20
>  #ifndef CONFIG_USER_ONLY
> +hwaddr riscv_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
> +void  riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
> +                                    MMUAccessType access_type, int mmu_i=
dx,
> +                                    uintptr_t retaddr);
> +void riscv_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
> +                                     vaddr addr, unsigned size,
> +                                     MMUAccessType access_type,
> +                                     int mmu_idx, MemTxAttrs attrs,
> +                                     MemTxResult response, uintptr_t ret=
addr);
>  void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env);
>  int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint32_t interrupts);
>  uint32_t riscv_cpu_update_mip(RISCVCPU *cpu, uint32_t mask, uint32_t val=
ue);
>  #define BOOL_TO_MASK(x) (-!!(x)) /* helper for riscv_cpu_update_mip valu=
e */
>  void riscv_cpu_set_rdtime_fn(CPURISCVState *env, uint64_t (*fn)(void));
> -#endif
> +#endif /* !CONFIG_USER_ONLY */
>  void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv);
> =20
>  void riscv_translate_init(void);
> diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
> index dbe58c7888..40d92413b8 100644
> --- a/target/sh4/cpu.h
> +++ b/target/sh4/cpu.h
> @@ -207,7 +207,6 @@ struct SuperHCPU {
>  void superh_cpu_do_interrupt(CPUState *cpu);
>  bool superh_cpu_exec_interrupt(CPUState *cpu, int int_req);
>  void superh_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
> -hwaddr superh_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
>  int superh_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg=
);
>  int superh_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
>  void superh_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
> @@ -223,6 +222,7 @@ bool superh_cpu_tlb_fill(CPUState *cs, vaddr address,=
 int size,
> =20
>  void sh4_cpu_list(void);
>  #if !defined(CONFIG_USER_ONLY)
> +hwaddr superh_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
>  void cpu_sh4_invalidate_tlb(CPUSH4State *s);
>  uint32_t cpu_sh4_read_mmaped_itlb_addr(CPUSH4State *s,
>                                         hwaddr addr);
> diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
> index b9369398f2..31887a811a 100644
> --- a/target/sparc/cpu.h
> +++ b/target/sparc/cpu.h
> @@ -570,7 +570,9 @@ extern const VMStateDescription vmstate_sparc_cpu;
> =20
>  void sparc_cpu_do_interrupt(CPUState *cpu);
>  void sparc_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
> +#ifndef CONFIG_USER_ONLY
>  hwaddr sparc_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
> +#endif
>  int sparc_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
>  int sparc_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
>  void QEMU_NORETURN sparc_cpu_do_unaligned_access(CPUState *cpu, vaddr ad=
dr,
> diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
> index 7a46dccbe1..47fe57df87 100644
> --- a/target/xtensa/cpu.h
> +++ b/target/xtensa/cpu.h
> @@ -564,19 +564,21 @@ bool xtensa_cpu_tlb_fill(CPUState *cs, vaddr addres=
s, int size,
>                           bool probe, uintptr_t retaddr);
>  void xtensa_cpu_do_interrupt(CPUState *cpu);
>  bool xtensa_cpu_exec_interrupt(CPUState *cpu, int interrupt_request);
> -void xtensa_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr, vad=
dr addr,
> -                                      unsigned size, MMUAccessType acces=
s_type,
> -                                      int mmu_idx, MemTxAttrs attrs,
> -                                      MemTxResult response, uintptr_t re=
taddr);
>  void xtensa_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
> -hwaddr xtensa_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
>  void xtensa_count_regs(const XtensaConfig *config,
>                         unsigned *n_regs, unsigned *n_core_regs);
>  int xtensa_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg=
);
>  int xtensa_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
> +#ifndef CONFIG_USER_ONLY
> +hwaddr xtensa_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
> +void xtensa_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr, vad=
dr addr,
> +                                      unsigned size, MMUAccessType acces=
s_type,
> +                                      int mmu_idx, MemTxAttrs attrs,
> +                                      MemTxResult response, uintptr_t re=
taddr);
>  void xtensa_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
>                                      MMUAccessType access_type,
>                                      int mmu_idx, uintptr_t retaddr);
> +#endif /* !CONFIG_USER_ONLY */
> =20
>  #define cpu_signal_handler cpu_xtensa_signal_handler
>  #define cpu_list xtensa_cpu_list
> diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
> index 71b6aca45d..6d33288d2a 100644
> --- a/target/hppa/cpu.c
> +++ b/target/hppa/cpu.c
> @@ -70,6 +70,7 @@ static void hppa_cpu_disas_set_info(CPUState *cs, disas=
semble_info *info)
>      info->print_insn =3D print_insn_hppa;
>  }
> =20
> +#ifndef CONFIG_USER_ONLY
>  static void hppa_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
>                                           MMUAccessType access_type,
>                                           int mmu_idx, uintptr_t retaddr)
> @@ -86,6 +87,7 @@ static void hppa_cpu_do_unaligned_access(CPUState *cs, =
vaddr addr,
> =20
>      cpu_loop_exit_restore(cs, retaddr);
>  }
> +#endif /* !CONFIG_USER_ONLY */
> =20
>  static void hppa_cpu_realizefn(DeviceState *dev, Error **errp)
>  {
> @@ -150,8 +152,8 @@ static void hppa_cpu_class_init(ObjectClass *oc, void=
 *data)
>  #ifndef CONFIG_USER_ONLY
>      cc->get_phys_page_debug =3D hppa_cpu_get_phys_page_debug;
>      dc->vmsd =3D &vmstate_hppa_cpu;
> -#endif
>      cc->do_unaligned_access =3D hppa_cpu_do_unaligned_access;
> +#endif
>      cc->disas_set_info =3D hppa_cpu_disas_set_info;
>      cc->tcg_initialize =3D hppa_translate_init;
> =20
> diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
> index 4ea0cc501b..8c428e2009 100644
> --- a/target/ppc/translate_init.inc.c
> +++ b/target/ppc/translate_init.inc.c
> @@ -10892,8 +10892,8 @@ static void ppc_cpu_class_init(ObjectClass *oc, v=
oid *data)
>      cc->set_pc =3D ppc_cpu_set_pc;
>      cc->gdb_read_register =3D ppc_cpu_gdb_read_register;
>      cc->gdb_write_register =3D ppc_cpu_gdb_write_register;
> -    cc->do_unaligned_access =3D ppc_cpu_do_unaligned_access;
>  #ifndef CONFIG_USER_ONLY
> +    cc->do_unaligned_access =3D ppc_cpu_do_unaligned_access;
>      cc->get_phys_page_debug =3D ppc_cpu_get_phys_page_debug;
>      cc->vmsd =3D &vmstate_ppc_cpu;
>  #endif

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Qrgsu6vtpU/OV/zm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl64p3IACgkQbDjKyiDZ
s5IeuBAAmTQsnMgzeOQtAdSatGBcoZgmEkFdesZ53PV2hfHhIAUne0WZKpaa1iaH
aOUOVRZN/6MRGOO4kvAdhbIjYlq+1mifAcCc/hZjv88TZoimLREvidmMZbVZP/rO
BVaW/i5/QzbaHbmp+hMvEC3vBSznsA5EXjZjBXXXl080BrHCz3BJWOyE5JiqlRhp
LAtPyCrFi9OhnsEqu9LMzU7GydY2USjCbGAq7GhYM3iMMFTBSRojNPsILKR7+Dsw
pS0VERWRZlt21qLAJSsCj8/VaRnh1e0aBVWEBizaAUuk1mJGi23egBqGRpz6V8hN
V7MMNnk8MlDp/A13Ums0PGMO/hqZr3RWnoOBT51758qASCURtXExsGpQZYjCU4UR
8V2RuNEAQJli8zop7Yo4RiR5XW+G+g36KUlKJ+o3kHbHTaG475VKFu/RXXx8OdQ3
uBYYjvIjf+AgRLUHOmMQJVNWpPikOP+k15OQyee5NcrBlay5/Q6X+1Wqi5vGS6vT
V312WlLpvxLZEnM484CKziG/X6i5zFsUi6dDqUiLbs4picELJV1uv7O63Jl4AjoB
RmkcSgrzynEqK7rxRm7N2/hTeu8hJGnazhNTh6aa5HjyQwI4J+hWwakYsNhuDSwR
cAxhR+chMb41yBVqu78eapmqZ1oDl+cyqZI2dbdMI7BThuqqK+Q=
=k9bI
-----END PGP SIGNATURE-----

--Qrgsu6vtpU/OV/zm--

