Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5479EC32771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 03:32:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F8C5207E0
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 03:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Hhg46VNQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F8C5207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iu6lA-0008TY-BN
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 22:32:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49127)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iu6iK-0005WP-C8
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 22:29:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iu6iI-0001bb-UB
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 22:29:56 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:53577 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iu6iE-0001To-NN; Tue, 21 Jan 2020 22:29:51 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 482W9j75b1z9sRs; Wed, 22 Jan 2020 14:29:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1579663786;
 bh=sn7xKkZ6SItaNbo3lEJZZA3KUS2uXO/WN/19CMVZwOE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Hhg46VNQxseDJKZbEu4w2qPWCbV5khGsoXPQ9sCoRvkzqti+FCinPnDVncC+Vgicw
 IuxWYcdaClGCGthT/xv0UGFBTzYEVinzMBsXi8YQBPkmIH/tj6BETd7Pjry4hS5cjC
 C6lgmjDOJ7LKU9okJFXR4l+0KPBtOBQJiL2Ns+cI=
Date: Wed, 22 Jan 2020 14:28:56 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v2 09/10] accel: Replace current_machine->accelerator by
 current_accel() wrapper
Message-ID: <20200122032856.GI2347@umbus.fritz.box>
References: <20200121110349.25842-1-philmd@redhat.com>
 <20200121110349.25842-10-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="X+nYw8KZ/oNxZ8JS"
Content-Disposition: inline
In-Reply-To: <20200121110349.25842-10-philmd@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>, Cornelia Huck <cohuck@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Like Xu <like.xu@linux.intel.com>,
 David Hildenbrand <david@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 "open list:Overall KVM CPUs" <kvm@vger.kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--X+nYw8KZ/oNxZ8JS
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 21, 2020 at 12:03:48PM +0100, Philippe Mathieu-Daud=E9 wrote:
> We actually want to access the accelerator, not the machine, so
> use the current_accel() wrapper instead.
>=20
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

ppc parts
Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
> v2:
> - Reworded description
> - Remove unused include in arm/kvm64
> ---
>  accel/kvm/kvm-all.c | 4 ++--
>  accel/tcg/tcg-all.c | 2 +-
>  memory.c            | 2 +-
>  target/arm/kvm64.c  | 5 ++---
>  target/i386/kvm.c   | 2 +-
>  target/ppc/kvm.c    | 2 +-
>  vl.c                | 2 +-
>  7 files changed, 9 insertions(+), 10 deletions(-)
>=20
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 1ada2f4ecb..c111312dfd 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -164,7 +164,7 @@ static NotifierList kvm_irqchip_change_notifiers =3D
> =20
>  int kvm_get_max_memslots(void)
>  {
> -    KVMState *s =3D KVM_STATE(current_machine->accelerator);
> +    KVMState *s =3D KVM_STATE(current_accel());
> =20
>      return s->nr_slots;
>  }
> @@ -1848,7 +1848,7 @@ static int kvm_max_vcpu_id(KVMState *s)
> =20
>  bool kvm_vcpu_id_is_valid(int vcpu_id)
>  {
> -    KVMState *s =3D KVM_STATE(current_machine->accelerator);
> +    KVMState *s =3D KVM_STATE(current_accel());
>      return vcpu_id >=3D 0 && vcpu_id < kvm_max_vcpu_id(s);
>  }
> =20
> diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
> index 1dc384c8d2..1802ce02f6 100644
> --- a/accel/tcg/tcg-all.c
> +++ b/accel/tcg/tcg-all.c
> @@ -124,7 +124,7 @@ static void tcg_accel_instance_init(Object *obj)
> =20
>  static int tcg_init(MachineState *ms)
>  {
> -    TCGState *s =3D TCG_STATE(current_machine->accelerator);
> +    TCGState *s =3D TCG_STATE(current_accel());
> =20
>      tcg_exec_init(s->tb_size * 1024 * 1024);
>      cpu_interrupt_handler =3D tcg_handle_interrupt;
> diff --git a/memory.c b/memory.c
> index d7b9bb6951..854798791e 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -3104,7 +3104,7 @@ void mtree_info(bool flatview, bool dispatch_tree, =
bool owner)
>          };
>          GArray *fv_address_spaces;
>          GHashTable *views =3D g_hash_table_new(g_direct_hash, g_direct_e=
qual);
> -        AccelClass *ac =3D ACCEL_GET_CLASS(current_machine->accelerator);
> +        AccelClass *ac =3D ACCEL_GET_CLASS(current_accel());
> =20
>          if (ac->has_memory) {
>              fvi.ac =3D ac;
> diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
> index 876184b8fe..e3c580e749 100644
> --- a/target/arm/kvm64.c
> +++ b/target/arm/kvm64.c
> @@ -26,7 +26,6 @@
>  #include "sysemu/kvm.h"
>  #include "sysemu/kvm_int.h"
>  #include "kvm_arm.h"
> -#include "hw/boards.h"
>  #include "internals.h"
> =20
>  static bool have_guest_debug;
> @@ -613,14 +612,14 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatur=
es *ahcf)
> =20
>  bool kvm_arm_aarch32_supported(CPUState *cpu)
>  {
> -    KVMState *s =3D KVM_STATE(current_machine->accelerator);
> +    KVMState *s =3D KVM_STATE(current_accel());
> =20
>      return kvm_check_extension(s, KVM_CAP_ARM_EL1_32BIT);
>  }
> =20
>  bool kvm_arm_sve_supported(CPUState *cpu)
>  {
> -    KVMState *s =3D KVM_STATE(current_machine->accelerator);
> +    KVMState *s =3D KVM_STATE(current_accel());
> =20
>      return kvm_check_extension(s, KVM_CAP_ARM_SVE);
>  }
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 7ee3202634..eddb930065 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -147,7 +147,7 @@ bool kvm_allows_irq0_override(void)
> =20
>  static bool kvm_x2apic_api_set_flags(uint64_t flags)
>  {
> -    KVMState *s =3D KVM_STATE(current_machine->accelerator);
> +    KVMState *s =3D KVM_STATE(current_accel());
> =20
>      return !kvm_vm_enable_cap(s, KVM_CAP_X2APIC_API, 0, flags);
>  }
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index b5799e62b4..45ede6b6d9 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -258,7 +258,7 @@ static void kvm_get_smmu_info(struct kvm_ppc_smmu_inf=
o *info, Error **errp)
> =20
>  struct ppc_radix_page_info *kvm_get_radix_page_info(void)
>  {
> -    KVMState *s =3D KVM_STATE(current_machine->accelerator);
> +    KVMState *s =3D KVM_STATE(current_accel());
>      struct ppc_radix_page_info *radix_page_info;
>      struct kvm_ppc_rmmu_info rmmu_info;
>      int i;
> diff --git a/vl.c b/vl.c
> index 71d3e7eefb..a8ea36f4f8 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2812,7 +2812,7 @@ static void configure_accelerators(const char *prog=
name)
>      }
> =20
>      if (init_failed) {
> -        AccelClass *ac =3D ACCEL_GET_CLASS(current_machine->accelerator);
> +        AccelClass *ac =3D ACCEL_GET_CLASS(current_accel());
>          error_report("falling back to %s", ac->name);
>      }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--X+nYw8KZ/oNxZ8JS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4nwXgACgkQbDjKyiDZ
s5KQjA/5AWHyv4v6rfJAATtSyWrFZBMM6JSp8t5nXhPeVMbRZJElTj+aZQlJnojH
S+d5VMUyzr1uv31BqsV69lL0mLlh9P/JDtmqFxA0sxQ+c3vSjQFcMTa9tpgaZtP7
CcgB2B3xU/FGn3D7Z+NeUvqhSON6Gz3Gf1+pHZVQNAC6CgGGIZl1BGaGZO8mh+HT
og9me7Latm/gyadx1C2t7XiqnI54aKFiA67H6ACROcmOJmXrUXfBE01hCoutAY64
xMJq250XMXj0Ug9rDRH29JfIAOMbHKPwBi8kOJu/21xtz0M2GqJRQ1AVWW0UuJ7U
t88m11vBAP/mjbtbcc00VOKuIvPNuodRYenraiIsBrdO05Pv32ug+NSNFK6kyhAv
CG7Z4pIQsLaqoLt16HbxCbrOPSZZY1i5e+MiLPs3kC+kcR9JVMxtAMybKbYQpnGE
lXp5pYiAx2ZRjgpPpCMmJ/RRDxHworeUu+8r95bBmYJiDsl+gFjCb2EyYIrU43NP
OVzla3QhyRF0I8m8SQFf6/QEN2OP3QQhNUscP4qXT7UOqttsRzPeKqhTqxM9RVUz
UQ/R+COp+4wvNuVWsPzF7ZpCeFNDzaXoYy3FYGNJqqGXlZUUectKrUiMx678D4f/
WgNH6A7V1i7Pf77T480gOkYCFz2sQoQTuOVqesfEFqisLEimELY=
=F7CM
-----END PGP SIGNATURE-----

--X+nYw8KZ/oNxZ8JS--

