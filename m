Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 633BFC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 07:14:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41448218AF
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 07:14:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41448218AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i68RY-0003Df-9S
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 03:14:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57393)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i68QC-0002HS-Ns
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 03:12:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i68QA-0002Gk-GG
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 03:12:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42482)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i68Q9-0002Ew-PX
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 03:12:37 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2B057C0546FE
 for <qemu-devel@nongnu.org>; Fri,  6 Sep 2019 07:12:36 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id f11so2125870wrt.18
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2019 00:12:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mhXslH6Gl7tShrdPUShkvmnSfBFhj7bvIKzrVxJAIIE=;
 b=QgErTxF0eMMi0G9vO8xGgoO4lJ8DuFqe8swSjUwGYn4kZt7szqBoC7tHMG/h8ukxvz
 SL9uFUokeBrLzGxSzcQVkWogZlVdpwCseqxhGMhbeLOisd/EkiMHE4Ju0kFhLHyuBHLx
 slcDl/qfR27wXPdM02DFPM5bWcHYwiy6/l9SNCEUPCeAvHPFRNPJlwXNdSUUwh7aY/xH
 mcwqsRjr5OyU/Y31R/AP7TU+kfBv0UyS5cITonL6awWTQB5dk98MJTjX5xIojsxmbuFL
 ayDnxFDYuqDKfOPgMhj/EsuJxiiECmiFSte5STSFYpnZjeHt3jMnZStUAl1dijr+C0hp
 Hj+A==
X-Gm-Message-State: APjAAAUzhjyUd5PDjTivzW5VRPqEJDZHEofY3qSMcDnsj8qKdzGQNt7u
 OrtfZThVw7rMOfWoFPC8O/76QnPt8KZFNqOqnc+Mn51GT3iUOi9pI4/scZqalrK3frEbLFyYA+M
 XtKvL8ZJccy0OLkw=
X-Received: by 2002:a1c:7f86:: with SMTP id a128mr6198596wmd.104.1567753954982; 
 Fri, 06 Sep 2019 00:12:34 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyQsRcSmj9mMHAw9TwHglCmUiq0Xbnaj3KEA1Mqv9+dn0KaAcQpfOTDkEwuAVkPd3eCLyxMgg==
X-Received: by 2002:a1c:7f86:: with SMTP id a128mr6198587wmd.104.1567753954786; 
 Fri, 06 Sep 2019 00:12:34 -0700 (PDT)
Received: from [192.168.1.48] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id b144sm4735801wmb.3.2019.09.06.00.12.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Sep 2019 00:12:34 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190820210720.18976-1-richard.henderson@linaro.org>
 <20190820210720.18976-14-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <9c3d3506-ca1a-2bc9-174e-d981d3e067b5@redhat.com>
Date: Fri, 6 Sep 2019 09:12:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190820210720.18976-14-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v5 13/17] target/arm: Split out
 arm_mmu_idx_el
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/20/19 11:07 PM, Richard Henderson wrote:
> Avoid calling arm_current_el() twice.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>  target/arm/internals.h |  9 +++++++++
>  target/arm/helper.c    | 12 +++++++-----
>  2 files changed, 16 insertions(+), 5 deletions(-)
>=20
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index 232d963875..f5313dd3d4 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -949,6 +949,15 @@ void arm_cpu_update_virq(ARMCPU *cpu);
>   */
>  void arm_cpu_update_vfiq(ARMCPU *cpu);
> =20
> +/**
> + * arm_mmu_idx_el:
> + * @env: The cpu environment
> + * @el: The EL to use.
> + *
> + * Return the full ARMMMUIdx for the translation regime for EL.
> + */
> +ARMMMUIdx arm_mmu_idx_el(CPUARMState *env, int el);
> +
>  /**
>   * arm_mmu_idx:
>   * @env: The cpu environment
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 83ae33dae5..19bdb9b9d6 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -10988,15 +10988,12 @@ ARMMMUIdx arm_v7m_mmu_idx_for_secstate(CPUARM=
State *env, bool secstate)
>  }
>  #endif
> =20
> -ARMMMUIdx arm_mmu_idx(CPUARMState *env)
> +ARMMMUIdx arm_mmu_idx_el(CPUARMState *env, int el)
>  {
> -    int el;
> -
>      if (arm_feature(env, ARM_FEATURE_M)) {
>          return arm_v7m_mmu_idx_for_secstate(env, env->v7m.secure);
>      }
> =20
> -    el =3D arm_current_el(env);
>      if (el < 2 && arm_is_secure_below_el3(env)) {
>          return ARMMMUIdx_S1SE0 + el;
>      } else {
> @@ -11004,6 +11001,11 @@ ARMMMUIdx arm_mmu_idx(CPUARMState *env)
>      }
>  }
> =20
> +ARMMMUIdx arm_mmu_idx(CPUARMState *env)
> +{
> +    return arm_mmu_idx_el(env, arm_current_el(env));
> +}
> +
>  int cpu_mmu_index(CPUARMState *env, bool ifetch)
>  {
>      return arm_to_core_mmu_idx(arm_mmu_idx(env));
> @@ -11164,7 +11166,7 @@ static uint32_t rebuild_hflags_internal(CPUARMS=
tate *env)
>  {
>      int el =3D arm_current_el(env);
>      int fp_el =3D fp_exception_el(env, el);
> -    ARMMMUIdx mmu_idx =3D arm_mmu_idx(env);
> +    ARMMMUIdx mmu_idx =3D arm_mmu_idx_el(env, el);
> =20
>      if (is_a64(env)) {
>          return rebuild_hflags_a64(env, el, fp_el, mmu_idx);
>=20

