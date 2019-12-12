Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73262C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 05:10:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D630214D8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 05:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="gzR2eutH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D630214D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifGkF-0003uH-7y
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 00:10:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58685)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ifGj8-0002Yo-Jd
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 00:09:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ifGj6-0002WX-Se
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 00:09:26 -0500
Received: from ozlabs.org ([203.11.71.1]:35233)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ifGj4-0002Lo-FL; Thu, 12 Dec 2019 00:09:24 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47YMJx2HZDz9sPL; Thu, 12 Dec 2019 16:08:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576127329;
 bh=KX4VOdpptYq9Xm1FlfNcApyIEpomMmeopMI3VancGVU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gzR2eutHJvpCmfHlr9pjf2hYR4TgKwL5wdbFLR0P0/VQlOCHHGIsAZytPG4jmoHQC
 U++KPpmQ6VPyFjvkFpg3U7GP93FgVSLIVeAA+DlKae4Z0Vifr4T8o9/HGevrgUdAlf
 XNOJJw9UK3I05ad2A1NqhbDboUNmGqFcyTMNZrE4=
Date: Thu, 12 Dec 2019 15:50:25 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Fabiano Rosas <farosas@linux.ibm.com>
Subject: Re: [PATCH v5 2/3] kvm-all: Introduce kvm_set_singlestep
Message-ID: <20191212045025.GU207300@umbus.fritz.box>
References: <20191211191013.454125-1-farosas@linux.ibm.com>
 <20191211191013.454125-3-farosas@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="WcQ7DTTOeW3GIUV5"
Content-Disposition: inline
In-Reply-To: <20191211191013.454125-3-farosas@linux.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
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


--WcQ7DTTOeW3GIUV5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2019 at 04:10:12PM -0300, Fabiano Rosas wrote:
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

I think this is fine, but it took me a while to figure out what was
going on.  I wonder if better comments and/or function names might
help.

> ---
>  accel/kvm/kvm-all.c         | 14 ++++++++++++++
>  accel/stubs/kvm-stub.c      |  4 ++++
>  exec.c                      |  2 +-
>  include/sysemu/kvm.h        |  4 ++++
>  stubs/Makefile.objs         |  1 +
>  stubs/kvm-arch-singlestep.c | 14 ++++++++++++++
>  target/ppc/kvm.c            | 14 ++++++++++++++
>  7 files changed, 52 insertions(+), 1 deletion(-)
>  create mode 100644 stubs/kvm-arch-singlestep.c
>=20
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index ca00daa2f5..a61beb0b53 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -2599,6 +2599,11 @@ bool kvm_arm_supports_user_irq(void)
>  }
> =20
>  #ifdef KVM_CAP_SET_GUEST_DEBUG
> +bool kvm_has_guest_debug_singlestep(CPUState *cs)

AIUI, this function is saying if setting the singlestep flag in the
KVM debug regs is sufficient to single step the guest under host
control.  The name doesn't make that terribly obvious to me, though a
better one isn't really obvious to me.

> +{
> +    return kvm_arch_has_guest_debug_singlestep(cs);

I also don't see a lot of point to this wrapper, rather than just
calling the arch version directly.

> +}
> +
>  struct kvm_sw_breakpoint *kvm_find_sw_breakpoint(CPUState *cpu,
>                                                   target_ulong pc)
>  {
> @@ -2647,6 +2652,15 @@ int kvm_update_guest_debug(CPUState *cpu, unsigned=
 long reinject_trap)
>      return data.err;
>  }
> =20
> +void kvm_set_singlestep(CPUState *cs, int enabled)
> +{
> +    if (kvm_has_guest_debug_singlestep(cs)) {
> +        kvm_update_guest_debug(cs, 0);
> +    } else {
> +        kvm_arch_set_singlestep(cs, enabled);
> +    }
> +}
> +
>  int kvm_insert_breakpoint(CPUState *cpu, target_ulong addr,
>                            target_ulong len, int type)
>  {
> diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
> index 82f118d2df..b4df48b6f1 100644
> --- a/accel/stubs/kvm-stub.c
> +++ b/accel/stubs/kvm-stub.c
> @@ -78,6 +78,10 @@ int kvm_update_guest_debug(CPUState *cpu, unsigned lon=
g reinject_trap)
>      return -ENOSYS;
>  }
> =20
> +void kvm_set_singlestep(CPUState *cs, int enabled)
> +{

AFAICT this should only be called with KVM enabled, so this should
maybe be a g_assert_not_reached() rather than a no-op.

> +}
> +
>  int kvm_insert_breakpoint(CPUState *cpu, target_ulong addr,
>                            target_ulong len, int type)
>  {
> diff --git a/exec.c b/exec.c
> index ffdb518535..ff46ea1846 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -1202,7 +1202,7 @@ void cpu_single_step(CPUState *cpu, int enabled)
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
> index 9fe233b9bf..7a42978b11 100644
> --- a/include/sysemu/kvm.h
> +++ b/include/sysemu/kvm.h
> @@ -215,6 +215,7 @@ int kvm_has_pit_state2(void);
>  int kvm_has_many_ioeventfds(void);
>  int kvm_has_gsi_routing(void);
>  int kvm_has_intx_set_mask(void);
> +bool kvm_has_guest_debug_singlestep(CPUState *cs);
> =20
>  int kvm_init_vcpu(CPUState *cpu);
>  int kvm_cpu_exec(CPUState *cpu);
> @@ -247,6 +248,8 @@ bool kvm_memcrypt_enabled(void);
>   */
>  int kvm_memcrypt_encrypt_data(uint8_t *ptr, uint64_t len);
> =20
> +bool kvm_arch_has_guest_debug_singlestep(CPUState *cs);
> +void kvm_arch_set_singlestep(CPUState *cpu, int enabled);
> =20
>  #ifdef NEED_CPU_H
>  #include "cpu.h"
> @@ -259,6 +262,7 @@ int kvm_remove_breakpoint(CPUState *cpu, target_ulong=
 addr,
>                            target_ulong len, int type);
>  void kvm_remove_all_breakpoints(CPUState *cpu);
>  int kvm_update_guest_debug(CPUState *cpu, unsigned long reinject_trap);
> +void kvm_set_singlestep(CPUState *cs, int enabled);
> =20
>  int kvm_on_sigbus_vcpu(CPUState *cpu, int code, void *addr);
>  int kvm_on_sigbus(int code, void *addr);
> diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
> index 4a50e95ec3..361f4088fa 100644
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
> index 0000000000..18bfba61f6
> --- /dev/null
> +++ b/stubs/kvm-arch-singlestep.c
> @@ -0,0 +1,14 @@
> +#include "qemu/osdep.h"
> +#include "qemu/error-report.h"
> +#include "sysemu/kvm.h"
> +
> +bool kvm_arch_has_guest_debug_singlestep(CPUState *cs)
> +{
> +    /* for backwards compatibility assume the feature is present */
> +    return true;
> +}
> +
> +void kvm_arch_set_singlestep(CPUState *cpu, int enabled)
> +{
> +    warn_report("KVM does not support single stepping");
> +}
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index c77f9848ec..3a2cfe883c 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -85,6 +85,7 @@ static int cap_ppc_safe_indirect_branch;
>  static int cap_ppc_count_cache_flush_assist;
>  static int cap_ppc_nested_kvm_hv;
>  static int cap_large_decr;
> +static int cap_ppc_singlestep;
> =20
>  static uint32_t debug_inst_opcode;
> =20
> @@ -133,6 +134,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>      kvmppc_get_cpu_characteristics(s);
>      cap_ppc_nested_kvm_hv =3D kvm_vm_check_extension(s, KVM_CAP_PPC_NEST=
ED_HV);
>      cap_large_decr =3D kvmppc_get_dec_bits();
> +    cap_ppc_singlestep =3D kvm_vm_check_extension(s, KVM_CAP_PPC_GUEST_D=
EBUG_SSTEP);
>      /*
>       * Note: setting it to false because there is not such capability
>       * in KVM at this moment.
> @@ -1380,6 +1382,18 @@ static int kvmppc_handle_dcr_write(CPUPPCState *en=
v,
>      return 0;
>  }
> =20
> +bool kvm_arch_has_guest_debug_singlestep(CPUState *cs)
> +{
> +    PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> +    CPUPPCState *env =3D &cpu->env;
> +
> +    if (cap_ppc_singlestep) {
> +        return true;
> +    }
> +

Perhaps note explicitly that this is a fallback guess when the cap is
not available to give us a good answer.

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

--WcQ7DTTOeW3GIUV5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3xxw8ACgkQbDjKyiDZ
s5LljRAAtG2xtzei/X1Y7Kwoy3EyVdDpG70CDbdxS1GvGDS0sK/8TQ9sv/80KNDL
7OPy2NWkwk6sjVqzK0JBX9h8OVk+062m58AMvoTOBtr5oCJNw59y9MIJ+GrRs3s1
S+t1YlwaU/WUNP6ERvcAx/4uBpKtb8aVG4K0fIZLNYljZyAYl11gMmFmKe/lCbAc
/i27C0PM80QZPWLm1G92xyOAb8HcV9OU6qXzr4F9BL3kN28+S9SEuFbsrGa4R0Ef
osdWfTUCvchz85RFyLlLbsz8dHX7WId7MVHVkUayoGHd45Nma8tr3MoU/a1P76Ip
b99z2N/PUEZeQBtVrPkYwzClyTRz3MMfmomd6P4O3cKaZM1GIK1+PMBZFIcPl8Fq
/D2mpilcxhKu+X9P5887ouEXL33I1jFtRXlYCHTuEo7SbKLbn6E7D27HnqazJDty
GpvRjvs0QEPtYRGdvH1GpTqoDrfSRSmlrU8yr3EwLdViqxIqh2nZnsJ/5+FL6qMU
nRbKz1cRrBzz/8nRjTLfwm9Byj2E7rOjoqB+Pq4WzYoZ2RaRzruWxsbwSMeX36ic
Gazva9zI0dY6hHmvJjRgpbamFDHCOlUbyidVx5k8gFcSdG3qTiK2fpVqqkuaTUOl
xbE8NRDwu50R2kcgup1Sq4yDieOTaskGg+FLKBHc9RI0iTWeqsA=
=SEr7
-----END PGP SIGNATURE-----

--WcQ7DTTOeW3GIUV5--

