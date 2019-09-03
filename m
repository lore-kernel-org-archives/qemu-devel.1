Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 046A2C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 12:11:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC10E208E4
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 12:11:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC10E208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i57f2-0001Kg-PR
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 08:11:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59445)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1i57eL-0000jO-K9
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 08:11:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1i57eK-0000MN-Cd
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 08:11:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48154)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>)
 id 1i57eH-0000If-9v; Tue, 03 Sep 2019 08:11:01 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 25280308213F;
 Tue,  3 Sep 2019 12:11:00 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-117-51.ams2.redhat.com [10.36.117.51])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 41EA35C1B5;
 Tue,  3 Sep 2019 12:10:56 +0000 (UTC)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20190903114729.3400-1-philmd@redhat.com>
 <20190903114729.3400-3-philmd@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thuth@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat
Message-ID: <a035e876-6f38-b80f-9a8f-1f88472fc7d7@redhat.com>
Date: Tue, 3 Sep 2019 14:10:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190903114729.3400-3-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Tue, 03 Sep 2019 12:11:00 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 2/5] target/arm: Restrict pre-ARMv7 cpus
 to TCG
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/09/2019 13.47, Philippe Mathieu-Daud=C3=A9 wrote:
> KVM requires a cpu based on (at least) the ARMv7 architecture.
>=20
> The following CPUs are disabled:
>=20
> * ARMv4
>=20
>   - StrongARM (SA1100/1110)
>   - OMAP1510 (TI925T)
>=20
> * ARMv5
>=20
>   - ARM926
>   - ARM946
>   - ARM1026
>   - XScale (PXA250/255/260/261/262/270)
>=20
> * ARMv6
>=20
>   - ARM1136
>   - ARM1176
>   - ARM11MPCore
>   - Cortex-M0
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> v2: fixed misplaced #endif (rth), list cpus
> ---
>  target/arm/cpu.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 2399c14471..f69780147c 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1678,6 +1678,8 @@ static ObjectClass *arm_cpu_class_by_name(const c=
har *cpu_model)
>  /* CPU models. These are not needed for the AArch64 linux-user build. =
*/
>  #if !defined(CONFIG_USER_ONLY) || !defined(TARGET_AARCH64)
> =20
> +#ifdef CONFIG_TCG
> +
>  static void arm926_initfn(Object *obj)
>  {
>      ARMCPU *cpu =3D ARM_CPU(obj);
> @@ -1900,6 +1902,8 @@ static void cortex_m0_initfn(Object *obj)
>      cpu->midr =3D 0x410cc200;
>  }
> =20
> +#endif
> +
>  static void cortex_m3_initfn(Object *obj)
>  {
>      ARMCPU *cpu =3D ARM_CPU(obj);
> @@ -2283,6 +2287,8 @@ static void cortex_a15_initfn(Object *obj)
>      define_arm_cp_regs(cpu, cortexa15_cp_reginfo);
>  }
> =20
> +#ifdef CONFIG_TCG
> +
>  static void ti925t_initfn(Object *obj)
>  {
>      ARMCPU *cpu =3D ARM_CPU(obj);
> @@ -2451,6 +2457,8 @@ static void pxa270c5_initfn(Object *obj)
>      cpu->reset_sctlr =3D 0x00000078;
>  }
> =20
> +#endif
> +
>  #ifndef TARGET_AARCH64
>  /* -cpu max: if KVM is enabled, like -cpu host (best possible with thi=
s host);
>   * otherwise, a CPU with as many features enabled as our emulation sup=
ports.
> @@ -2523,6 +2531,7 @@ struct ARMCPUInfo {
> =20
>  static const ARMCPUInfo arm_cpus[] =3D {
>  #if !defined(CONFIG_USER_ONLY) || !defined(TARGET_AARCH64)
> +#ifdef CONFIG_TCG
>      { .name =3D "arm926",      .initfn =3D arm926_initfn },
>      { .name =3D "arm946",      .initfn =3D arm946_initfn },
>      { .name =3D "arm1026",     .initfn =3D arm1026_initfn },
> @@ -2536,6 +2545,7 @@ static const ARMCPUInfo arm_cpus[] =3D {
>      { .name =3D "arm11mpcore", .initfn =3D arm11mpcore_initfn },
>      { .name =3D "cortex-m0",   .initfn =3D cortex_m0_initfn,
>                               .class_init =3D arm_v7m_class_init },
> +#endif
>      { .name =3D "cortex-m3",   .initfn =3D cortex_m3_initfn,
>                               .class_init =3D arm_v7m_class_init },
>      { .name =3D "cortex-m4",   .initfn =3D cortex_m4_initfn,
> @@ -2548,6 +2558,7 @@ static const ARMCPUInfo arm_cpus[] =3D {
>      { .name =3D "cortex-a8",   .initfn =3D cortex_a8_initfn },
>      { .name =3D "cortex-a9",   .initfn =3D cortex_a9_initfn },
>      { .name =3D "cortex-a15",  .initfn =3D cortex_a15_initfn },
> +#ifdef CONFIG_TCG
>      { .name =3D "ti925t",      .initfn =3D ti925t_initfn },
>      { .name =3D "sa1100",      .initfn =3D sa1100_initfn },
>      { .name =3D "sa1110",      .initfn =3D sa1110_initfn },
> @@ -2564,6 +2575,7 @@ static const ARMCPUInfo arm_cpus[] =3D {
>      { .name =3D "pxa270-b1",   .initfn =3D pxa270b1_initfn },
>      { .name =3D "pxa270-c0",   .initfn =3D pxa270c0_initfn },
>      { .name =3D "pxa270-c5",   .initfn =3D pxa270c5_initfn },
> +#endif
>  #ifndef TARGET_AARCH64
>      { .name =3D "max",         .initfn =3D arm_max_initfn },
>  #endif
>=20

All that #ifdeffery is a little bit ugly. I wonder whether we could
solve this by moving the CPU registrations to separate files which then
only get compiled if the corresponding CONFIG_ARM_Vx switch is set.

That reminds me of a patch series of mine where I tried to make the code
compilable without CONFIG_ARM_V7M ... unfortunately, I never found
enough spare time to finish and publish it... I'll have a try to see
whether I can rebase it and send it as an RFC or so.

 Thomas

