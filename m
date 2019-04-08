Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ABC0C282CE
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 04:31:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E373420880
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 04:31:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="gN2DgCs5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E373420880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47149 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDLwR-0005ln-4u
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 00:31:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hDLuP-0004QY-Us
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 00:29:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hDLuO-0007al-0B
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 00:29:25 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:54791 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hDLuK-0007Wf-9c; Mon, 08 Apr 2019 00:29:21 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 44cy9g1MnQz9sRY; Mon,  8 Apr 2019 14:29:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1554697751;
	bh=ZkDISkBl/m6pw5xgjQBM1BcWL26nREcKQpd4bfCh8/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gN2DgCs5WyftHwUj9xuewcHGEx60Yy4Sr6E7G/vNGQ6uhrCPyktEQF8vu/2oUwmnk
	WqW1psN1FRHmPatonoupi6j4YkvYIKTQRQBv9xCyiTv0noWhdM2MiwNm0KS1GnysyG
	fpOxOT7lPB2xi45OjeEW1+TbxmuVfl0LwNhYSqo0=
Date: Mon, 8 Apr 2019 13:45:53 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Message-ID: <20190408034553.GD16627@umbus.fritz.box>
References: <155445151931.302073.18436485925081597460.stgit@bahia.lan>
	<155445152490.302073.17033451726459859333.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AbQceqfdZEv+FvjW"
Content-Disposition: inline
In-Reply-To: <155445152490.302073.17033451726459859333.stgit@bahia.lan>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH 2/2] target/ppc/kvm: Convert DPRINTF to
 traces
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
	Aravinda Prasad <aravinda@linux.vnet.ibm.com>,
	qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408034553.TGJF_CWATt694JUvl-mXxZDAig_pKgma2gyOQCoK-h0@z>


--AbQceqfdZEv+FvjW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 05, 2019 at 10:05:24AM +0200, Greg Kurz wrote:
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-4.1, thanks.

I did have to fix up a small conflict because I've now merged my style
fixups for target/ppc into ppc-for-4.1.

> ---
>  target/ppc/kvm.c        |   68 +++++++++++++++++++----------------------=
------
>  target/ppc/trace-events |   25 +++++++++++++++++
>  2 files changed, 52 insertions(+), 41 deletions(-)
>=20
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 2427c8ee13ae..3a11d2e1060c 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -49,16 +49,6 @@
>  #include "elf.h"
>  #include "sysemu/kvm_int.h"
> =20
> -//#define DEBUG_KVM
> -
> -#ifdef DEBUG_KVM
> -#define DPRINTF(fmt, ...) \
> -    do { fprintf(stderr, fmt, ## __VA_ARGS__); } while (0)
> -#else
> -#define DPRINTF(fmt, ...) \
> -    do { } while (0)
> -#endif
> -
>  #define PROC_DEVTREE_CPU      "/proc/device-tree/cpus/"
> =20
>  const KVMCapabilityInfo kvm_arch_required_capabilities[] =3D {
> @@ -626,7 +616,7 @@ static int kvm_put_fp(CPUState *cs)
>          reg.addr =3D (uintptr_t)&fpscr;
>          ret =3D kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
>          if (ret < 0) {
> -            DPRINTF("Unable to set FPSCR to KVM: %s\n", strerror(errno));
> +            trace_kvm_failed_fpscr_set(strerror(errno));
>              return ret;
>          }
> =20
> @@ -647,8 +637,8 @@ static int kvm_put_fp(CPUState *cs)
> =20
>              ret =3D kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
>              if (ret < 0) {
> -                DPRINTF("Unable to set %s%d to KVM: %s\n", vsx ? "VSR" :=
 "FPR",
> -                        i, strerror(errno));
> +                trace_kvm_failed_fp_set(vsx ? "VSR" : "FPR", i,
> +                                        strerror(errno));
>                  return ret;
>              }
>          }
> @@ -659,7 +649,7 @@ static int kvm_put_fp(CPUState *cs)
>          reg.addr =3D (uintptr_t)&env->vscr;
>          ret =3D kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
>          if (ret < 0) {
> -            DPRINTF("Unable to set VSCR to KVM: %s\n", strerror(errno));
> +            trace_kvm_failed_vscr_set(strerror(errno));
>              return ret;
>          }
> =20
> @@ -668,7 +658,7 @@ static int kvm_put_fp(CPUState *cs)
>              reg.addr =3D (uintptr_t)cpu_avr_ptr(env, i);
>              ret =3D kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
>              if (ret < 0) {
> -                DPRINTF("Unable to set VR%d to KVM: %s\n", i, strerror(e=
rrno));
> +                trace_kvm_failed_vr_set(i, strerror(errno));
>                  return ret;
>              }
>          }
> @@ -693,7 +683,7 @@ static int kvm_get_fp(CPUState *cs)
>          reg.addr =3D (uintptr_t)&fpscr;
>          ret =3D kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
>          if (ret < 0) {
> -            DPRINTF("Unable to get FPSCR from KVM: %s\n", strerror(errno=
));
> +            trace_kvm_failed_fpscr_get(strerror(errno));
>              return ret;
>          } else {
>              env->fpscr =3D fpscr;
> @@ -709,8 +699,8 @@ static int kvm_get_fp(CPUState *cs)
> =20
>              ret =3D kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
>              if (ret < 0) {
> -                DPRINTF("Unable to get %s%d from KVM: %s\n",
> -                        vsx ? "VSR" : "FPR", i, strerror(errno));
> +                trace_kvm_failed_fp_get(vsx ? "VSR" : "FPR", i,
> +                                        strerror(errno));
>                  return ret;
>              } else {
>  #ifdef HOST_WORDS_BIGENDIAN
> @@ -733,7 +723,7 @@ static int kvm_get_fp(CPUState *cs)
>          reg.addr =3D (uintptr_t)&env->vscr;
>          ret =3D kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
>          if (ret < 0) {
> -            DPRINTF("Unable to get VSCR from KVM: %s\n", strerror(errno)=
);
> +            trace_kvm_failed_vscr_get(strerror(errno));
>              return ret;
>          }
> =20
> @@ -742,8 +732,7 @@ static int kvm_get_fp(CPUState *cs)
>              reg.addr =3D (uintptr_t)cpu_avr_ptr(env, i);
>              ret =3D kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
>              if (ret < 0) {
> -                DPRINTF("Unable to get VR%d from KVM: %s\n",
> -                        i, strerror(errno));
> +                trace_kvm_failed_vr_get(i, strerror(errno));
>                  return ret;
>              }
>          }
> @@ -764,7 +753,7 @@ static int kvm_get_vpa(CPUState *cs)
>      reg.addr =3D (uintptr_t)&spapr_cpu->vpa_addr;
>      ret =3D kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
>      if (ret < 0) {
> -        DPRINTF("Unable to get VPA address from KVM: %s\n", strerror(err=
no));
> +        trace_kvm_failed_vpa_addr_get(strerror(errno));
>          return ret;
>      }
> =20
> @@ -774,8 +763,7 @@ static int kvm_get_vpa(CPUState *cs)
>      reg.addr =3D (uintptr_t)&spapr_cpu->slb_shadow_addr;
>      ret =3D kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
>      if (ret < 0) {
> -        DPRINTF("Unable to get SLB shadow state from KVM: %s\n",
> -                strerror(errno));
> +        trace_kvm_failed_slb_get(strerror(errno));
>          return ret;
>      }
> =20
> @@ -785,8 +773,7 @@ static int kvm_get_vpa(CPUState *cs)
>      reg.addr =3D (uintptr_t)&spapr_cpu->dtl_addr;
>      ret =3D kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
>      if (ret < 0) {
> -        DPRINTF("Unable to get dispatch trace log state from KVM: %s\n",
> -                strerror(errno));
> +        trace_kvm_failed_dtl_get(strerror(errno));
>          return ret;
>      }
> =20
> @@ -812,7 +799,7 @@ static int kvm_put_vpa(CPUState *cs)
>          reg.addr =3D (uintptr_t)&spapr_cpu->vpa_addr;
>          ret =3D kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
>          if (ret < 0) {
> -            DPRINTF("Unable to set VPA address to KVM: %s\n", strerror(e=
rrno));
> +            trace_kvm_failed_vpa_addr_set(strerror(errno));
>              return ret;
>          }
>      }
> @@ -823,7 +810,7 @@ static int kvm_put_vpa(CPUState *cs)
>      reg.addr =3D (uintptr_t)&spapr_cpu->slb_shadow_addr;
>      ret =3D kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
>      if (ret < 0) {
> -        DPRINTF("Unable to set SLB shadow state to KVM: %s\n", strerror(=
errno));
> +        trace_kvm_failed_slb_set(strerror(errno));
>          return ret;
>      }
> =20
> @@ -833,8 +820,7 @@ static int kvm_put_vpa(CPUState *cs)
>      reg.addr =3D (uintptr_t)&spapr_cpu->dtl_addr;
>      ret =3D kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
>      if (ret < 0) {
> -        DPRINTF("Unable to set dispatch trace log state to KVM: %s\n",
> -                strerror(errno));
> +        trace_kvm_failed_dtl_set(strerror(errno));
>          return ret;
>      }
> =20
> @@ -843,7 +829,7 @@ static int kvm_put_vpa(CPUState *cs)
>          reg.addr =3D (uintptr_t)&spapr_cpu->vpa_addr;
>          ret =3D kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
>          if (ret < 0) {
> -            DPRINTF("Unable to set VPA address to KVM: %s\n", strerror(e=
rrno));
> +            trace_kvm_failed_null_vpa_addr_set(strerror(errno));
>              return ret;
>          }
>      }
> @@ -996,7 +982,7 @@ int kvm_arch_put_registers(CPUState *cs, int level)
> =20
>          if (cap_papr) {
>              if (kvm_put_vpa(cs) < 0) {
> -                DPRINTF("Warning: Unable to set VPA information to KVM\n=
");
> +                trace_kvm_failed_put_vpa();
>              }
>          }
> =20
> @@ -1296,7 +1282,7 @@ int kvm_arch_get_registers(CPUState *cs)
> =20
>          if (cap_papr) {
>              if (kvm_get_vpa(cs) < 0) {
> -                DPRINTF("Warning: Unable to get VPA information from KVM=
\n");
> +                trace_kvm_failed_get_vpa();
>              }
>          }
> =20
> @@ -1352,7 +1338,7 @@ void kvm_arch_pre_run(CPUState *cs, struct kvm_run =
*run)
>           */
>          irq =3D KVM_INTERRUPT_SET;
> =20
> -        DPRINTF("injected interrupt %d\n", irq);
> +        trace_kvm_injected_interrupt(irq);
>          r =3D kvm_vcpu_ioctl(cs, KVM_INTERRUPT, &irq);
>          if (r < 0) {
>              printf("cpu %d fail inject %x\n", cs->cpu_index, irq);
> @@ -1697,20 +1683,20 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm=
_run *run)
>      switch (run->exit_reason) {
>      case KVM_EXIT_DCR:
>          if (run->dcr.is_write) {
> -            DPRINTF("handle dcr write\n");
> +            trace_kvm_handle_dcr_write();
>              ret =3D kvmppc_handle_dcr_write(env, run->dcr.dcrn, run->dcr=
=2Edata);
>          } else {
> -            DPRINTF("handle dcr read\n");
> +            trace_kvm_handle_drc_read();
>              ret =3D kvmppc_handle_dcr_read(env, run->dcr.dcrn, &run->dcr=
=2Edata);
>          }
>          break;
>      case KVM_EXIT_HLT:
> -        DPRINTF("handle halt\n");
> +        trace_kvm_handle_halt();
>          ret =3D kvmppc_handle_halt(cpu);
>          break;
>  #if defined(TARGET_PPC64)
>      case KVM_EXIT_PAPR_HCALL:
> -        DPRINTF("handle PAPR hypercall\n");
> +        trace_kvm_handle_papr_hcall();
>          run->papr_hcall.ret =3D spapr_hypercall(cpu,
>                                                run->papr_hcall.nr,
>                                                run->papr_hcall.args);
> @@ -1718,18 +1704,18 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm=
_run *run)
>          break;
>  #endif
>      case KVM_EXIT_EPR:
> -        DPRINTF("handle epr\n");
> +        trace_kvm_handle_epr();
>          run->epr.epr =3D ldl_phys(cs->as, env->mpic_iack);
>          ret =3D 0;
>          break;
>      case KVM_EXIT_WATCHDOG:
> -        DPRINTF("handle watchdog expiry\n");
> +        trace_kvm_handle_watchdog_expiry();
>          watchdog_perform_action();
>          ret =3D 0;
>          break;
> =20
>      case KVM_EXIT_DEBUG:
> -        DPRINTF("handle debug exception\n");
> +        trace_kvm_handle_debug_exception();
>          if (kvm_handle_debug(cpu, run)) {
>              ret =3D EXCP_DEBUG;
>              break;
> diff --git a/target/ppc/trace-events b/target/ppc/trace-events
> index ed4d57c6d9c1..7b3cfe11fdfe 100644
> --- a/target/ppc/trace-events
> +++ b/target/ppc/trace-events
> @@ -3,3 +3,28 @@
>  # kvm.c
>  kvm_failed_spr_set(int spr, const char *msg) "Warning: Unable to set SPR=
 %d to KVM: %s"
>  kvm_failed_spr_get(int spr, const char *msg) "Warning: Unable to retriev=
e SPR %d from KVM: %s"
> +kvm_failed_fpscr_set(const char *msg) "Unable to set FPSCR to KVM: %s"
> +kvm_failed_fp_set(const char *fpname, int fpnum, const char *msg) "Unabl=
e to set %s%d to KVM: %s"
> +kvm_failed_vscr_set(const char *msg) "Unable to set VSCR to KVM: %s"
> +kvm_failed_vr_set(int vr, const char *msg) "Unable to set VR%d to KVM: %=
s"
> +kvm_failed_fpscr_get(const char *msg) "Unable to get FPSCR from KVM: %s"
> +kvm_failed_fp_get(const char *fpname, int fpnum, const char *msg) "Unabl=
e to get %s%d from KVM: %s"
> +kvm_failed_vscr_get(const char *msg) "Unable to get VSCR from KVM: %s"
> +kvm_failed_vr_get(int vr, const char *msg) "Unable to get VR%d from KVM:=
 %s"
> +kvm_failed_vpa_addr_get(const char *msg) "Unable to get VPA address from=
 KVM: %s"
> +kvm_failed_slb_get(const char *msg) "Unable to get SLB shadow state from=
 KVM: %s"
> +kvm_failed_dtl_get(const char *msg) "Unable to get dispatch trace log st=
ate from KVM: %s"
> +kvm_failed_vpa_addr_set(const char *msg) "Unable to set VPA address to K=
VM: %s"
> +kvm_failed_slb_set(const char *msg) "Unable to set SLB shadow state to K=
VM: %s"
> +kvm_failed_dtl_set(const char *msg) "Unable to set dispatch trace log st=
ate to KVM: %s"
> +kvm_failed_null_vpa_addr_set(const char *msg) "Unable to set VPA address=
 to KVM: %s"
> +kvm_failed_put_vpa(void) "Warning: Unable to set VPA information to KVM"
> +kvm_failed_get_vpa(void) "Warning: Unable to get VPA information from KV=
M"
> +kvm_injected_interrupt(int irq) "injected interrupt %d"
> +kvm_handle_dcr_write(void) "handle dcr write"
> +kvm_handle_drc_read(void) "handle dcr read"
> +kvm_handle_halt(void) "handle halt"
> +kvm_handle_papr_hcall(void) "handle PAPR hypercall"
> +kvm_handle_epr(void) "handle epr"
> +kvm_handle_watchdog_expiry(void) "handle watchdog expiry"
> +kvm_handle_debug_exception(void) "handle debug exception"
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--AbQceqfdZEv+FvjW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyqw/EACgkQbDjKyiDZ
s5KhxA//VILqgIgcF1lPfHsVlIGOaGCCdEOdfwi2FnwIdJJDP6qfe7WyhIwEeNYE
5w0wyjlsBTnbgKcY+GS2hyQRted7JtvQozxcyTYMw2as6lUrjsQtqTdYTjHU7quy
0NukwPRftxAozyKdZawzW/gD+MFGnjuEy/6YkTdlK4Z8Uc4WWeufQPvfDEGTFuKb
VARCdbxn7CFJAuho7Eg36GK1jNfmjgMGJgteG+zXwf5+qJk/1ds5P8S6X1nDfn/U
NDquCLrKcNsqFVC8SKmJMBVMFthBFnnReJLjPwX0G2iwzWFuFZ0MsOirYgoir2rq
hJFwXdo9OwvhZ/ydpBJgKEpg/3vG31zCMArlO8bPcH3PQfayjtRh0UL35llfSYwi
/7Nepq2ISCF4twYmmFOAt9RKIVa+dQZC8v/+E7XShdEHaQyMugBGSO6thMmvXUW+
IYjLWZXg5BqolrXKrFUkmWu3etPPrI17HfQ48dL02aTvpEtfGGOvDvR+aBu9W2Cd
j7I82nQSjzm4sFtUHCg/SwaSTxYK4AAkrygUe5uzWKPPs0mtaAVuEJ6i0634n/JL
JyFL0OEQj4A2nPwUdaG7iZasWiJC639/ZH+3Qyabos29ygkDn6zJh35kWk/slcLu
/T867KPLbj8GZzrjQPnkdwXqpg5l+/+dcGc/F2MfTF2RNQzcYSQ=
=wMX7
-----END PGP SIGNATURE-----

--AbQceqfdZEv+FvjW--

