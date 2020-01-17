Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C19EC33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 12:28:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 680542072B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 12:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="LMCGgfsG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 680542072B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isQk7-00019j-2y
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 07:28:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41434)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1isQiJ-0007n5-LL
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 07:27:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1isQiG-0005p9-4X
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 07:26:59 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:45371 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1isQiF-0005ht-9c; Fri, 17 Jan 2020 07:26:56 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47zgKg5PjVz9sRl; Fri, 17 Jan 2020 23:26:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1579264007;
 bh=3rCnu11KGDL6LnWuXnpn4brKmEK4L1uCNnlzvX/jBQk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=LMCGgfsG2bKHtY2yrhuyo9W0Atv3zNpX2EMinazuif+UP0eZrNv97wGWN8DdVckYa
 7szJ2LSaPc8lcvdcs0TBJHiFS0TeN9eB4qO1oMDXZypg1ViDVa+CwHj3HRt6xEGjQH
 7o+7JVQEdBVGCBEeHkkvHSLhTgLTNggdWToGXq6E=
Date: Fri, 17 Jan 2020 19:27:48 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Fabiano Rosas <farosas@linux.ibm.com>
Subject: Re: [PATCH v6 2/3] kvm-all: Introduce kvm_set_singlestep
Message-ID: <20200117092748.GY54439@umbus>
References: <20200110151344.278471-1-farosas@linux.ibm.com>
 <20200110151344.278471-3-farosas@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="HSHpc5A+GJc9BHcd"
Content-Disposition: inline
In-Reply-To: <20200110151344.278471-3-farosas@linux.ibm.com>
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--HSHpc5A+GJc9BHcd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 10, 2020 at 12:13:43PM -0300, Fabiano Rosas wrote:
> For single stepping (via KVM) of a guest vcpu to work, KVM needs not
> only to support the SET_GUEST_DEBUG ioctl but to also recognize the
> KVM_GUESTDBG_SINGLESTEP bit in the control field of the
> kvm_guest_debug struct.
>=20
> This patch adds support for querying the single step capability so
> that QEMU can decide what to do for the platforms that do not have
> such support.
>=20
> This will allow architecture-specific implementations of a fallback
> mechanism for single stepping in cases where KVM does not support it.
>=20
> Signed-off-by: Fabiano Rosas <farosas@linux.ibm.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

and ppc parts

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  accel/kvm/kvm-all.c         |  9 +++++++++
>  accel/stubs/kvm-stub.c      |  5 +++++
>  exec.c                      |  2 +-
>  include/sysemu/kvm.h        |  3 +++
>  stubs/Makefile.objs         |  1 +
>  stubs/kvm-arch-singlestep.c | 14 ++++++++++++++
>  target/ppc/kvm.c            | 15 +++++++++++++++
>  7 files changed, 48 insertions(+), 1 deletion(-)
>  create mode 100644 stubs/kvm-arch-singlestep.c
>=20
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index b2f1a5bcb5..a1ea8f9641 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -2668,6 +2668,15 @@ int kvm_update_guest_debug(CPUState *cpu, unsigned=
 long reinject_trap)
>      return data.err;
>  }
> =20
> +void kvm_set_singlestep(CPUState *cs, int enabled)
> +{
> +    if (kvm_arch_can_singlestep(cs)) {
> +        kvm_update_guest_debug(cs, 0);
> +    } else {
> +        kvm_arch_emulate_singlestep(cs, enabled);
> +    }
> +}
> +
>  int kvm_insert_breakpoint(CPUState *cpu, target_ulong addr,
>                            target_ulong len, int type)
>  {
> diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
> index 82f118d2df..8773c15713 100644
> --- a/accel/stubs/kvm-stub.c
> +++ b/accel/stubs/kvm-stub.c
> @@ -78,6 +78,11 @@ int kvm_update_guest_debug(CPUState *cpu, unsigned lon=
g reinject_trap)
>      return -ENOSYS;
>  }
> =20
> +void kvm_set_singlestep(CPUState *cs, int enabled)
> +{
> +    g_assert_not_reached();
> +}
> +
>  int kvm_insert_breakpoint(CPUState *cpu, target_ulong addr,
>                            target_ulong len, int type)
>  {
> diff --git a/exec.c b/exec.c
> index d4b769d0d4..10b61fccb8 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -1204,7 +1204,7 @@ void cpu_single_step(CPUState *cpu, int enabled)
>      if (cpu->singlestep_enabled !=3D enabled) {
>          cpu->singlestep_enabled =3D enabled;
>          if (kvm_enabled()) {
> -            kvm_update_guest_debug(cpu, 0);
> +            kvm_set_singlestep(cpu, enabled);
>          } else {
>              /* must flush all the translated code to avoid inconsistenci=
es */
>              /* XXX: only flush what is necessary */
> diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
> index 141342de98..43abdb8430 100644
> --- a/include/sysemu/kvm.h
> +++ b/include/sysemu/kvm.h
> @@ -247,6 +247,8 @@ bool kvm_memcrypt_enabled(void);
>   */
>  int kvm_memcrypt_encrypt_data(uint8_t *ptr, uint64_t len);
> =20
> +bool kvm_arch_can_singlestep(CPUState *cs);
> +void kvm_arch_emulate_singlestep(CPUState *cpu, int enabled);
> =20
>  #ifdef NEED_CPU_H
>  #include "cpu.h"
> @@ -259,6 +261,7 @@ int kvm_remove_breakpoint(CPUState *cpu, target_ulong=
 addr,
>                            target_ulong len, int type);
>  void kvm_remove_all_breakpoints(CPUState *cpu);
>  int kvm_update_guest_debug(CPUState *cpu, unsigned long reinject_trap);
> +void kvm_set_singlestep(CPUState *cs, int enabled);
> =20
>  int kvm_on_sigbus_vcpu(CPUState *cpu, int code, void *addr);
>  int kvm_on_sigbus(int code, void *addr);
> diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
> index 8b0ff25508..e6310b878c 100644
> --- a/stubs/Makefile.objs
> +++ b/stubs/Makefile.objs
> @@ -12,6 +12,7 @@ stub-obj-y +=3D get-vm-name.o
>  stub-obj-y +=3D iothread.o
>  stub-obj-y +=3D iothread-lock.o
>  stub-obj-y +=3D is-daemonized.o
> +stub-obj-y +=3D kvm-arch-singlestep.o
>  stub-obj-$(CONFIG_LINUX_AIO) +=3D linux-aio.o
>  stub-obj-y +=3D machine-init-done.o
>  stub-obj-y +=3D migr-blocker.o
> diff --git a/stubs/kvm-arch-singlestep.c b/stubs/kvm-arch-singlestep.c
> new file mode 100644
> index 0000000000..30ee278ba4
> --- /dev/null
> +++ b/stubs/kvm-arch-singlestep.c
> @@ -0,0 +1,14 @@
> +#include "qemu/osdep.h"
> +#include "qemu/error-report.h"
> +#include "sysemu/kvm.h"
> +
> +bool kvm_arch_can_singlestep(CPUState *cs)
> +{
> +    /* for backwards compatibility assume the feature is present */
> +    return true;
> +}
> +
> +void kvm_arch_emulate_singlestep(CPUState *cpu, int enabled)
> +{
> +    warn_report("KVM does not support single stepping");
> +}
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 0bd4a8d399..6fb8687126 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -88,6 +88,7 @@ static int cap_ppc_safe_indirect_branch;
>  static int cap_ppc_count_cache_flush_assist;
>  static int cap_ppc_nested_kvm_hv;
>  static int cap_large_decr;
> +static int cap_ppc_singlestep;
> =20
>  static uint32_t debug_inst_opcode;
> =20
> @@ -136,6 +137,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>      kvmppc_get_cpu_characteristics(s);
>      cap_ppc_nested_kvm_hv =3D kvm_vm_check_extension(s, KVM_CAP_PPC_NEST=
ED_HV);
>      cap_large_decr =3D kvmppc_get_dec_bits();
> +    cap_ppc_singlestep =3D kvm_vm_check_extension(s, KVM_CAP_PPC_GUEST_D=
EBUG_SSTEP);
>      /*
>       * Note: setting it to false because there is not such capability
>       * in KVM at this moment.
> @@ -1383,6 +1385,19 @@ static int kvmppc_handle_dcr_write(CPUPPCState *en=
v,
>      return 0;
>  }
> =20
> +bool kvm_arch_can_singlestep(CPUState *cs)
> +{
> +    PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> +    CPUPPCState *env =3D &cpu->env;
> +
> +    if (cap_ppc_singlestep) {
> +        return true;
> +    }
> +
> +    /* Fallback for when the capability is not available */
> +    return env->excp_model =3D=3D POWERPC_EXCP_BOOKE || kvmppc_is_pr(kvm=
_state);
> +}
> +
>  int kvm_arch_insert_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint=
 *bp)
>  {
>      /* Mixed endian case is not handled */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--HSHpc5A+GJc9BHcd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4hfhMACgkQbDjKyiDZ
s5IA2A/+LHXUG/sGCzbkuBV6hQKV/6E4dRC3amN7mA83HF1T3czwBHgVcz6zs3bp
rFhaeZ1Mi5K9t04QQSJR5qn7YVWiBVEZOWl0z6gw32sfzlmKS2H1ZY+cDmGAPII8
S1qTSMY3VJE4X0s2fclJcMApEPry8aBpwPCTbuxiysnKcAcqKu/owLok/zwU85QT
dGzt8Us/um5DRZiMgT4PD4HnxL9EKBUXzumqzEDmIwk4IPLLsL5h/gpkfCyskA0b
M9sBRr0E0Elwg1GUbAjtvCar2RfXEC2j6LTuWV8eaHbbq+8VnW+HmJMF6nuuHNqt
jByLrWYghE8HXB5upbao3OnbDjmWk7GetAmWHiob/645saPBPWZSyIhzEZeExHYs
E4Af2Am5Kw0fLPeNKwxqSMjjsCsA/KU7X18/PsmfYIgBPohwUH+nPg4nHYAP1QS1
nH2ajL3CAsihSynY3moqqdT8fUATSRUBQ9Rzb8icf/LerTYAhi9o/sX/hzToEt0w
DcbNjPuWvMF26gdEJw85/LlQeah3EL9ev6X/IF1mYxccIKO1I6d/alHfr2BXeaaz
H9dOf7lGtM29yHoKZoHRHt8iJ35zecI/qQjCmcvu7/S1yFkTNG8WyVu4D5OwVZYF
fdpHXlCRkInz5XnSPXKpMPb6Zm1KdCQ2DcfalZW32rEw3XI7p3s=
=gGCs
-----END PGP SIGNATURE-----

--HSHpc5A+GJc9BHcd--

