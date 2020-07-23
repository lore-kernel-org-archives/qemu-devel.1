Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4CCC433E5
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 01:02:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB14120888
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 01:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="COxYNQYX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB14120888
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyPdI-00030M-5o
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 21:02:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38406)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jyPaw-0008QZ-A3; Wed, 22 Jul 2020 21:00:22 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:51885)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jyPat-0007HG-IE; Wed, 22 Jul 2020 21:00:21 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BBvBk3vcHz9sRW; Thu, 23 Jul 2020 11:00:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1595466014;
 bh=zuHmYIrYBOFbbEdGZavubGZBe9b7544HmjAR9Vay8nE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=COxYNQYXizt7d/ghFohWDTEMAtZFbercQGaF1uC11VXRPuOSGTWZ5jA14FFZOP0ul
 bVy+AqxGb8KSAxsApdfplVMXn2UX79tPC8Ao23nNayAmXcUqTg5Ss4Mlmkoeqibe1A
 HbNzEDbGkuAb6YQwP2bDd46st+7SfnxTihjffhBw=
Date: Thu, 23 Jul 2020 10:55:30 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [PATCH v2 1/9] target/arm: Move start-powered-off property to
 generic CPUState
Message-ID: <20200723005530.GG5513@umbus.fritz.box>
References: <20200722035016.469075-1-bauerman@linux.ibm.com>
 <20200722035016.469075-2-bauerman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="MrRUTeZlqqNo1jQ9"
Content-Disposition: inline
In-Reply-To: <20200722035016.469075-2-bauerman@linux.ibm.com>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
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
 Cornelia Huck <cohuck@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--MrRUTeZlqqNo1jQ9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2020 at 12:50:08AM -0300, Thiago Jung Bauermann wrote:
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

--MrRUTeZlqqNo1jQ9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl8Y4AIACgkQbDjKyiDZ
s5KG/xAAheuxIOm/147keYG58h1DJMAKRtgfLlgArGcPgMoxiCc3pyUwgiCzwZJJ
Vb+M5t9WYdTed/X7ptevwriWMqOCwyzDk/uBj2two3fXiDt8TLcprYBs21YY0HAS
1Jwk/Vnk9uq89tIdlZ7JRjSJk9DxUakY/gBOKsnTPSX7trVaQu89yy4uliX3AXun
gCL2ugoGechlQhXfV8KcvQ+haCuMZ+tpIcYitPkHH2QnkRP3zP+Ttg5cG1aYkLIF
NKRWxxr4KANeyVAC9gkniPyOzWiKhUeuxUPkEdeWk3oJAakGVBD+nVOD3DH/t9jp
L8dOH2Aw6eweBIIoCe90Utq8FVLQG3CjvMN33xUSWtoo1rtLEY1GM9KMZSKTQ758
VPkGyiONjzunGUbT0L9dl8wD3Fwg0Y/7yGmbSDTVZdJsg7/DsQ8AnZ6Ho+v+Drgz
gh7vm1em3bKMeVXLBIWuWh3AxYGKCd3JPqRhYefHzSQ86brwbuBVUpLIQdHrQo32
lPJCGi3inUWelVvhZOJXRWyKgifzr6QD1mYjIpKbp2HvTalbZIokMgFAJSa9uLlB
aMD2lIcnxcGvsfFGAthbm8rUMG1WAFVhBXvtXJpV+NvSN5ndFZd1yp9O46ES3Ef2
0DYn8kuw3JEtpA/ykCv6MMcMqTped01hTUn7Xv04xiTk/w8F+Xo=
=9IsF
-----END PGP SIGNATURE-----

--MrRUTeZlqqNo1jQ9--

