Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61180C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 12:35:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9D1120868
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 12:35:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9D1120868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53985 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hU9Q8-0002QQ-Np
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 08:35:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hU9Ob-0001fN-Au
	for qemu-devel@nongnu.org; Fri, 24 May 2019 08:34:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hU9Oa-0007o0-1B
	for qemu-devel@nongnu.org; Fri, 24 May 2019 08:34:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42304)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hU9OZ-0007nB-Q5
	for qemu-devel@nongnu.org; Fri, 24 May 2019 08:33:59 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 031603086236;
	Fri, 24 May 2019 12:33:53 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-120-245.rdu2.redhat.com
	[10.10.120.245])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 806C817D1D;
	Fri, 24 May 2019 12:33:49 +0000 (UTC)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
	=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20181102171638.24069-1-peter.maydell@linaro.org>
	<20181102171638.24069-9-peter.maydell@linaro.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <3e3d2018-3993-f651-8e94-5bea612bd776@redhat.com>
Date: Fri, 24 May 2019 14:33:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181102171638.24069-9-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Fri, 24 May 2019 12:33:53 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 08/10] target/arm: Conditionalize some
 asserts on aarch32 support
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

On 11/02/18 18:16, Peter Maydell wrote:
> From: Richard Henderson <richard.henderson@linaro.org>
>=20
> When populating id registers from kvm, on a host that doesn't support
> aarch32 mode at all, neither arm_div nor jazelle will be supported eith=
er.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Message-id: 20181102102025.3546-1-richard.henderson@linaro.org
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.h |  5 +++++
>  target/arm/cpu.c | 15 +++++++++++++--
>  2 files changed, 18 insertions(+), 2 deletions(-)
>=20
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 8e6779936eb..b5eff79f73b 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -3296,6 +3296,11 @@ static inline bool isar_feature_aa64_fp16(const =
ARMISARegisters *id)
>      return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, FP) =3D=3D 1;
>  }
> =20
> +static inline bool isar_feature_aa64_aa32(const ARMISARegisters *id)
> +{
> +    return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, EL0) >=3D 2;
> +}
> +
>  static inline bool isar_feature_aa64_sve(const ARMISARegisters *id)
>  {
>      return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, SVE) !=3D 0;
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 8f16e96b6c8..784a4c2dfcc 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -774,6 +774,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Err=
or **errp)
>      CPUARMState *env =3D &cpu->env;
>      int pagebits;
>      Error *local_err =3D NULL;
> +    bool no_aa32 =3D false;
> =20
>      /* If we needed to query the host kernel for the CPU features
>       * then it's possible that might have failed in the initfn, but
> @@ -820,6 +821,16 @@ static void arm_cpu_realizefn(DeviceState *dev, Er=
ror **errp)
>              set_feature(env, ARM_FEATURE_V7VE);
>          }
>      }
> +
> +    /*
> +     * There exist AArch64 cpus without AArch32 support.  When KVM
> +     * queries ID_ISAR0_EL1 on such a host, the value is UNKNOWN.
> +     * Similarly, we cannot check ID_AA64PFR0 without AArch64 support.
> +     */
> +    if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
> +        no_aa32 =3D !cpu_isar_feature(aa64_aa32, cpu);
> +    }
> +
>      if (arm_feature(env, ARM_FEATURE_V7VE)) {
>          /* v7 Virtualization Extensions. In real hardware this implies
>           * EL2 and also the presence of the Security Extensions.
> @@ -829,7 +840,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Err=
or **errp)
>           * Presence of EL2 itself is ARM_FEATURE_EL2, and of the
>           * Security Extensions is ARM_FEATURE_EL3.
>           */
> -        assert(cpu_isar_feature(arm_div, cpu));
> +        assert(no_aa32 || cpu_isar_feature(arm_div, cpu));

The assertion above fails on my AArch64 host (APM Mustang A3). Meaning
that my host CPU supports AArch32, but lacks "arm_div".

(My understanding is that this commit, i.e., 0f8d06f16c9d, relaxed the
assert originally added in commit 7e0cf8b47f0e ("target/arm: Convert
division from feature bits to isar0 tests", 2018-10-24). Can we relax it
even further?

Better yet: can we rework the code to emit a warning, rather than
aborting QEMU? Assertions are not the best tool IMHO for catching
unusual (or slightly non-conformant / early) hardware.)

Thanks,
Laszlo

>          set_feature(env, ARM_FEATURE_LPAE);
>          set_feature(env, ARM_FEATURE_V7);
>      }
> @@ -855,7 +866,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Err=
or **errp)
>      if (arm_feature(env, ARM_FEATURE_V6)) {
>          set_feature(env, ARM_FEATURE_V5);
>          if (!arm_feature(env, ARM_FEATURE_M)) {
> -            assert(cpu_isar_feature(jazelle, cpu));
> +            assert(no_aa32 || cpu_isar_feature(jazelle, cpu));
>              set_feature(env, ARM_FEATURE_AUXCR);
>          }
>      }
>=20


