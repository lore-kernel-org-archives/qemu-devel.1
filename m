Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 730FCC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 03:13:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F187D20723
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 03:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="VNvTh/VV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F187D20723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyRgE-0005HA-0i
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 23:13:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39748)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jyRbF-0006ID-55; Wed, 22 Jul 2020 23:08:49 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:43773 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jyRbB-0006TC-Rb; Wed, 22 Jul 2020 23:08:48 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BBy2v2LQDz9sRW; Thu, 23 Jul 2020 13:08:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1595473719;
 bh=XXBf9GvdJtl/hxVFX9jO+2Y4JyS21BIXHuwyM7dd19Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VNvTh/VVboKLCLrPxn2yZhX/WYD8mDM6KlYx9q/FWPf4Ep0UXDtck1gzsd+EX/C5k
 BI2wse9Fgl40ipZOM5HZ2jUJ4S8mwoM4f9DCvlf98vUOf4IfxY5D/Sfd9tsUFozHBu
 q4MZa/4j+BK3JX5mCwoffkSGqoMGIXrDzTTSJbSo=
Date: Thu, 23 Jul 2020 13:06:09 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [PATCH v3 1/8] target/arm: Move start-powered-off property to
 generic CPUState
Message-ID: <20200723030609.GL5513@umbus.fritz.box>
References: <20200723025657.644724-1-bauerman@linux.ibm.com>
 <20200723025657.644724-2-bauerman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="vTUhhhdwRI43FzeR"
Content-Disposition: inline
In-Reply-To: <20200723025657.644724-2-bauerman@linux.ibm.com>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 23:08:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--vTUhhhdwRI43FzeR
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2020 at 11:56:50PM -0300, Thiago Jung Bauermann wrote:
> There are other platforms which also have CPUs that start powered off, so
> generalize the start-powered-off property so that it can be used by them.
>=20
> Note that ARMv7MState also has a property of the same name but this patch
> doesn't change it because that class isn't a subclass of CPUState so it
> wouldn't be a trivial change.
>=20
> This change should not cause any change in behavior.
>=20
> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  exec.c                | 1 +
>  include/hw/core/cpu.h | 4 ++++
>  target/arm/cpu.c      | 5 ++---
>  target/arm/cpu.h      | 3 ---
>  target/arm/kvm32.c    | 2 +-
>  target/arm/kvm64.c    | 2 +-
>  6 files changed, 9 insertions(+), 8 deletions(-)
>=20
> NB: I was only able to test that this patch builds. I wasn't able to
> run it.
>=20
> diff --git a/exec.c b/exec.c
> index 6f381f98e2..82e82fab09 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -899,6 +899,7 @@ Property cpu_common_props[] =3D {
>      DEFINE_PROP_LINK("memory", CPUState, memory, TYPE_MEMORY_REGION,
>                       MemoryRegion *),
>  #endif
> +    DEFINE_PROP_BOOL("start-powered-off", CPUState, start_powered_off, f=
alse),
>      DEFINE_PROP_END_OF_LIST(),
>  };
> =20
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 8f145733ce..9fc2696db5 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -374,6 +374,10 @@ struct CPUState {
>      bool created;
>      bool stop;
>      bool stopped;
> +
> +    /* Should CPU start in powered-off state? */
> +    bool start_powered_off;
> +
>      bool unplug;
>      bool crash_occurred;
>      bool exit_request;
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 111579554f..ec65c7653f 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -174,8 +174,8 @@ static void arm_cpu_reset(DeviceState *dev)
>      env->vfp.xregs[ARM_VFP_MVFR1] =3D cpu->isar.mvfr1;
>      env->vfp.xregs[ARM_VFP_MVFR2] =3D cpu->isar.mvfr2;
> =20
> -    cpu->power_state =3D cpu->start_powered_off ? PSCI_OFF : PSCI_ON;
> -    s->halted =3D cpu->start_powered_off;
> +    cpu->power_state =3D s->start_powered_off ? PSCI_OFF : PSCI_ON;
> +    s->halted =3D s->start_powered_off;
> =20
>      if (arm_feature(env, ARM_FEATURE_IWMMXT)) {
>          env->iwmmxt.cregs[ARM_IWMMXT_wCID] =3D 0x69051000 | 'Q';
> @@ -2182,7 +2182,6 @@ static const ARMCPUInfo arm_cpus[] =3D {
>  };
> =20
>  static Property arm_cpu_properties[] =3D {
> -    DEFINE_PROP_BOOL("start-powered-off", ARMCPU, start_powered_off, fal=
se),
>      DEFINE_PROP_UINT32("psci-conduit", ARMCPU, psci_conduit, 0),
>      DEFINE_PROP_UINT64("midr", ARMCPU, midr, 0),
>      DEFINE_PROP_UINT64("mp-affinity", ARMCPU,
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 9e8ed423ea..a925d26996 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -810,9 +810,6 @@ struct ARMCPU {
>       */
>      uint32_t psci_version;
> =20
> -    /* Should CPU start in PSCI powered-off state? */
> -    bool start_powered_off;
> -
>      /* Current power state, access guarded by BQL */
>      ARMPSCIState power_state;
> =20
> diff --git a/target/arm/kvm32.c b/target/arm/kvm32.c
> index 0af46b41c8..1f2b8f8b7a 100644
> --- a/target/arm/kvm32.c
> +++ b/target/arm/kvm32.c
> @@ -218,7 +218,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
> =20
>      /* Determine init features for this CPU */
>      memset(cpu->kvm_init_features, 0, sizeof(cpu->kvm_init_features));
> -    if (cpu->start_powered_off) {
> +    if (cs->start_powered_off) {
>          cpu->kvm_init_features[0] |=3D 1 << KVM_ARM_VCPU_POWER_OFF;
>      }
>      if (kvm_check_extension(cs->kvm_state, KVM_CAP_ARM_PSCI_0_2)) {
> diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
> index 1169237905..f8a6d905fb 100644
> --- a/target/arm/kvm64.c
> +++ b/target/arm/kvm64.c
> @@ -775,7 +775,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
> =20
>      /* Determine init features for this CPU */
>      memset(cpu->kvm_init_features, 0, sizeof(cpu->kvm_init_features));
> -    if (cpu->start_powered_off) {
> +    if (cs->start_powered_off) {
>          cpu->kvm_init_features[0] |=3D 1 << KVM_ARM_VCPU_POWER_OFF;
>      }
>      if (kvm_check_extension(cs->kvm_state, KVM_CAP_ARM_PSCI_0_2)) {
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--vTUhhhdwRI43FzeR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl8Y/p4ACgkQbDjKyiDZ
s5L65A//XhsDBZQC78Yse+Qdy8bJ5h86KbaxbOBf+A9kvORdxYRt8JIoy1mhh4y3
NNjzrq5HDKx6YVwW9zLISGtrAT5JzqC4rO8XMsUnxW43FoG1nCErtH6Ml9cW9niw
5Q/REX6DeDHNOdAMEO3ZMMzc2VOHHD2+GwUg7E1hEjkl8D5HqaLpKUBV5UVCwhgR
/ZhNgqreHF7YU7fa+HgX/EXoRQ3vVubxmD/zR4mlaegJU+JxFtqGzHqa4BfmQyMJ
Gx2U4BQvzAK2rNPmOFOQpuEE8X0Nyq4w/5W/V4ZPEhmptJVA9wwpDgNrjGJVp7y+
6zHmpaoBNDUk2sBpXzUbr05keXxg7H3m6WruWcobyTIW7fyDE8zTy3kxXXQltS8K
NJSZVGA0yRjwSDy4vMOcfys7hdTvrtD3osbOQh5+pkRHFGYwDsGW8ukSdiRzgHxC
KQ9PQ4DZqPpa0pWA91sCY54E9LCKEWHxBsafoLsQ4ngXmaIASUj6x0pbYk16ushz
IXXPEBsvE1pE04lDwaCX3SP3VZvenbYVtu/44CNgBT1EjO8OVnUlx9zU4A0BOqGu
Tk0O1goMr3Ip7m5xY/HMT75dffpS0gH846+LqisoyA7xWAfmI7p/eoF/BRE/vpeN
jPFzmznA5N8t2vWAhEXRBv32TMZqkHai6Ag5oUe8uEy62T250fk=
=QrMU
-----END PGP SIGNATURE-----

--vTUhhhdwRI43FzeR--

