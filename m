Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F6AC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 12:38:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB0DB20714
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 12:38:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB0DB20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k02On-0001Ck-1t
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 08:38:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40172)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1k02Nt-0000Dx-CB
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 08:37:37 -0400
Received: from 4.mo69.mail-out.ovh.net ([46.105.42.102]:46396)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1k02Nr-0008ET-6M
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 08:37:37 -0400
Received: from player690.ha.ovh.net (unknown [10.108.35.232])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id B94C59912B
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 14:37:24 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player690.ha.ovh.net (Postfix) with ESMTPSA id 5444D14989EC8;
 Mon, 27 Jul 2020 12:36:57 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-95G0018439f768-0629-4b97-9cca-d49db8edae8c,B7B50C960922AB26A7D550ED897AF9E452A9EBFF)
 smtp.auth=groug@kaod.org
Date: Mon, 27 Jul 2020 14:36:56 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v3 1/8] target/arm: Move start-powered-off property to
 generic CPUState
Message-ID: <20200727143656.277500f0@bahia.lan>
In-Reply-To: <20200723030609.GL5513@umbus.fritz.box>
References: <20200723025657.644724-1-bauerman@linux.ibm.com>
 <20200723025657.644724-2-bauerman@linux.ibm.com>
 <20200723030609.GL5513@umbus.fritz.box>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/x6A_q+XXF/OnOq118RkT5mq";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Ovh-Tracer-Id: 14592507219021371878
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedriedtgdehhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgesghdtreerredtjeenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepveegffeljeegleehheetiedutefhueehgeetteektddvieevgeeujeevgfelfeejnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheiledtrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=46.105.42.102; envelope-from=groug@kaod.org;
 helo=4.mo69.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 08:37:25
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 Thiago Jung Bauermann <bauerman@linux.ibm.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/x6A_q+XXF/OnOq118RkT5mq
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 23 Jul 2020 13:06:09 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Wed, Jul 22, 2020 at 11:56:50PM -0300, Thiago Jung Bauermann wrote:
> > There are other platforms which also have CPUs that start powered off, =
so
> > generalize the start-powered-off property so that it can be used by the=
m.
> >=20
> > Note that ARMv7MState also has a property of the same name but this pat=
ch
> > doesn't change it because that class isn't a subclass of CPUState so it
> > wouldn't be a trivial change.
> >=20
> > This change should not cause any change in behavior.
> >=20
> > Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
>=20
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
>=20

Reviewed-by: Greg Kurz <groug@kaod.org>

> > ---
> >  exec.c                | 1 +
> >  include/hw/core/cpu.h | 4 ++++
> >  target/arm/cpu.c      | 5 ++---
> >  target/arm/cpu.h      | 3 ---
> >  target/arm/kvm32.c    | 2 +-
> >  target/arm/kvm64.c    | 2 +-
> >  6 files changed, 9 insertions(+), 8 deletions(-)
> >=20
> > NB: I was only able to test that this patch builds. I wasn't able to
> > run it.
> >=20
> > diff --git a/exec.c b/exec.c
> > index 6f381f98e2..82e82fab09 100644
> > --- a/exec.c
> > +++ b/exec.c
> > @@ -899,6 +899,7 @@ Property cpu_common_props[] =3D {
> >      DEFINE_PROP_LINK("memory", CPUState, memory, TYPE_MEMORY_REGION,
> >                       MemoryRegion *),
> >  #endif
> > +    DEFINE_PROP_BOOL("start-powered-off", CPUState, start_powered_off,=
 false),
> >      DEFINE_PROP_END_OF_LIST(),
> >  };
> > =20
> > diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> > index 8f145733ce..9fc2696db5 100644
> > --- a/include/hw/core/cpu.h
> > +++ b/include/hw/core/cpu.h
> > @@ -374,6 +374,10 @@ struct CPUState {
> >      bool created;
> >      bool stop;
> >      bool stopped;
> > +
> > +    /* Should CPU start in powered-off state? */
> > +    bool start_powered_off;
> > +
> >      bool unplug;
> >      bool crash_occurred;
> >      bool exit_request;
> > diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> > index 111579554f..ec65c7653f 100644
> > --- a/target/arm/cpu.c
> > +++ b/target/arm/cpu.c
> > @@ -174,8 +174,8 @@ static void arm_cpu_reset(DeviceState *dev)
> >      env->vfp.xregs[ARM_VFP_MVFR1] =3D cpu->isar.mvfr1;
> >      env->vfp.xregs[ARM_VFP_MVFR2] =3D cpu->isar.mvfr2;
> > =20
> > -    cpu->power_state =3D cpu->start_powered_off ? PSCI_OFF : PSCI_ON;
> > -    s->halted =3D cpu->start_powered_off;
> > +    cpu->power_state =3D s->start_powered_off ? PSCI_OFF : PSCI_ON;
> > +    s->halted =3D s->start_powered_off;
> > =20
> >      if (arm_feature(env, ARM_FEATURE_IWMMXT)) {
> >          env->iwmmxt.cregs[ARM_IWMMXT_wCID] =3D 0x69051000 | 'Q';
> > @@ -2182,7 +2182,6 @@ static const ARMCPUInfo arm_cpus[] =3D {
> >  };
> > =20
> >  static Property arm_cpu_properties[] =3D {
> > -    DEFINE_PROP_BOOL("start-powered-off", ARMCPU, start_powered_off, f=
alse),
> >      DEFINE_PROP_UINT32("psci-conduit", ARMCPU, psci_conduit, 0),
> >      DEFINE_PROP_UINT64("midr", ARMCPU, midr, 0),
> >      DEFINE_PROP_UINT64("mp-affinity", ARMCPU,
> > diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> > index 9e8ed423ea..a925d26996 100644
> > --- a/target/arm/cpu.h
> > +++ b/target/arm/cpu.h
> > @@ -810,9 +810,6 @@ struct ARMCPU {
> >       */
> >      uint32_t psci_version;
> > =20
> > -    /* Should CPU start in PSCI powered-off state? */
> > -    bool start_powered_off;
> > -
> >      /* Current power state, access guarded by BQL */
> >      ARMPSCIState power_state;
> > =20
> > diff --git a/target/arm/kvm32.c b/target/arm/kvm32.c
> > index 0af46b41c8..1f2b8f8b7a 100644
> > --- a/target/arm/kvm32.c
> > +++ b/target/arm/kvm32.c
> > @@ -218,7 +218,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
> > =20
> >      /* Determine init features for this CPU */
> >      memset(cpu->kvm_init_features, 0, sizeof(cpu->kvm_init_features));
> > -    if (cpu->start_powered_off) {
> > +    if (cs->start_powered_off) {
> >          cpu->kvm_init_features[0] |=3D 1 << KVM_ARM_VCPU_POWER_OFF;
> >      }
> >      if (kvm_check_extension(cs->kvm_state, KVM_CAP_ARM_PSCI_0_2)) {
> > diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
> > index 1169237905..f8a6d905fb 100644
> > --- a/target/arm/kvm64.c
> > +++ b/target/arm/kvm64.c
> > @@ -775,7 +775,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
> > =20
> >      /* Determine init features for this CPU */
> >      memset(cpu->kvm_init_features, 0, sizeof(cpu->kvm_init_features));
> > -    if (cpu->start_powered_off) {
> > +    if (cs->start_powered_off) {
> >          cpu->kvm_init_features[0] |=3D 1 << KVM_ARM_VCPU_POWER_OFF;
> >      }
> >      if (kvm_check_extension(cs->kvm_state, KVM_CAP_ARM_PSCI_0_2)) {
> >=20
>=20


--Sig_/x6A_q+XXF/OnOq118RkT5mq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAl8eymgACgkQcdTV5YIv
c9Y5cA//fI3S70yYaqp/nGvaYTyqKR0BdlFHwouXRg1VROwRvgb5kzZy+HBv0UE9
Ol+K1kJJw3gw0qCTrKyNkV4bQEBEmIjIRz/X51OyZ3+oaXArlpd1dW6phxyo0frF
sNKo/CBS2vS+g3W523fXdCbBil0RErkTim5Db3TmJD301yUNLv4jy4Ej7hFSvUT5
EGDOwR0IR/H2HivOoO5r6+cKTUl0rHo95Q/yrgTrjIq5/QZMwCrrMnoiPOfOS+r8
xTlol5FS8dmfPTDaDtwF+9jkLjXGQozrXMKpgITY71OLR06CcmiNpnLWqqXNCak8
vIrp8UDjksfssmQ7ikA8FvVsX8I987sfySU5QA6Pt0YdahChhQkc2GFkI/Vhl2HI
c8Lz53Jg7snLUw/OAtXtWugWN6NEGSaMGMvn0IPtNkV+GQmZQpbCFwoh5WxnVrmP
ErFsc9dISP9VW8Jr5U5IMd7J50AarPbp5oAJEJaObFi3hkjTMhpSK/vl7q+zoePo
ByHt2MusgEBDF771iyCHxU1LDByb0lSDjrDbTNzUN+i/qjjvR5udOFBEnwkMmf+M
0yDKzncIMgZMgXgY16m8bXXqTE52rBhJxAU2IijfVGid1y3SBkXrFzaHsiO0cVJR
ev7a7b3qU7K5Uy1W8BJTHSU60Dz4hzWieZqKxIo0zACURTK0Ekc=
=QmXv
-----END PGP SIGNATURE-----

--Sig_/x6A_q+XXF/OnOq118RkT5mq--

