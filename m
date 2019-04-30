Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1055EC43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 12:07:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA316205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 12:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="quzOgku0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA316205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46040 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLRXg-0001OQ-UI
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 08:07:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLRWV-0000pO-JQ
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 08:06:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLRWU-0001p9-CM
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 08:06:11 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:41620)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hLRWU-0001os-7B
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 08:06:10 -0400
Received: by mail-ot1-x342.google.com with SMTP id g8so10637220otl.8
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 05:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=ctw1PmSs/FscVIAd8xMc+XKKLMdL9xM/Hxw+Ecx6PVY=;
	b=quzOgku0i5Ak/XgMVl7+bhROh2NnYsiXsVvKFospcObCqGr+4ih8WflYbEMYAQyc9F
	8owXy4Qt7jl1uiE1WLSGIF5UbN0SCxjWqczXdoKqgoJ/wcNXafRe/A0nUueCvfmm0xXN
	1BdaoGYF8bJCzr2ZNJQsgU0PcmtOlxCYV5ZeKiTPYhrlbHzrloNGfuYkz+05E8DWx5rI
	4hprpDm8cmqoGDlILmahK1lXpzlQ5nNhObdB07sLZnug5g8il4fyn+Ey24bZhtLEprFE
	yX8toTWl1MRAT+FzWvyffI2Prez7sf4ylMIYe1MFmkfN0tLlAlUSliBg2FGLYKZvAodm
	0NOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=ctw1PmSs/FscVIAd8xMc+XKKLMdL9xM/Hxw+Ecx6PVY=;
	b=Dqm7URbYrmlip3GcRPyW6+rj1P5MoGf+N6FvqwTxn+ZTFcKDWpRr4y7D3tAFeejCos
	GJMvTrDcmGPlBTpyJRyjuQGpO0004gW/Nz+nhbJPN/aBMvmTDnaQT7hridDb8XpgBn30
	nxX0QKnheAYw/hZI4sga5tg088ePAuql7H00Bnv+yE1j9JslxypkarN/DA/7e2+Z2nMx
	F6Rd9zMPF5d4zVub2Wmqbg0H05A+/KefgvUUlGB7sFvWwxKcvYcmofyQpTqAi6+7noly
	VQ8JjzCD9a9H17f4BrvPoKiFZ91Dmtsj1LOS2u8joTgV5Fmb2qvv4xJDC2S+uiKFkIJf
	jlMw==
X-Gm-Message-State: APjAAAXIGYcrBO8cfFBxnYuye06HKvOL0M2CcS3Bdu+IPA63+P9rtx81
	aE1/KDrk8PvXSQVEmusOjTuuamyyvc5WSsQct7m1hw==
X-Google-Smtp-Source: APXvYqy+UuUTLwpIUo6zBBmx2kt5ghFlftUB17CgnWjhMHe1WueaDKz55LsP9FnY98fLAO2gCJRFE44ymKYF56pMjFM=
X-Received: by 2002:a9d:6156:: with SMTP id c22mr12058752otk.363.1556625969476;
	Tue, 30 Apr 2019 05:06:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190430031238.40499-1-yangchuanlong@huawei.com>
In-Reply-To: <20190430031238.40499-1-yangchuanlong@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Apr 2019 13:05:58 +0100
Message-ID:
 <CAFEAcA-HkovdX3XayW22=wJ2i0cECV_Jm3OjTv3zsHLMhgsKDQ@mail.gmail.com>
To: Yang Chuanlong <yangchuanlong@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v1] target/arm/arm-powerctl: mask the cpuid
 with affinity bits when get cpu
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
	gengdongjiu <gengdongjiu@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430120558.JunCvAhUXmAC9qNM3G0orzJMiyFczzKxhHpU7BxtDVE@z>

On Tue, 30 Apr 2019 at 04:22, Yang Chuanlong <yangchuanlong@huawei.com> wrote:
>
> Currently, the cpuid passed from the device tree may still contain
> non-affinity fields, which will cause arm_set_cpu_on failure.
> Therefore, we mask the cpuid with affinity fields here to
> improve qemu compatibility.
>
> Signed-off-by: Yang Chuanlong <yangchuanlong@huawei.com>
> ---
>  target/arm/arm-powerctl.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/target/arm/arm-powerctl.c b/target/arm/arm-powerctl.c
> index f77a950db6..ef9fec0b4d 100644
> --- a/target/arm/arm-powerctl.c
> +++ b/target/arm/arm-powerctl.c
> @@ -31,7 +31,13 @@ CPUState *arm_get_cpu_by_id(uint64_t id)
>  {
>      CPUState *cpu;
>
> -    DPRINTF("cpu %" PRId64 "\n", id);
> +#ifdef TARGET_AARCH64
> +    id &= ARM64_AFFINITY_MASK;
> +#else
> +    id &= ARM32_AFFINITY_MASK;
> +#endif
> +
> +    DPRINTF("cpu %" PRId64 " after mask affinity\n", id);
>
>      CPU_FOREACH(cpu) {
>          ARMCPU *armcpu = ARM_CPU(cpu);

Hi -- could you explain what the code path is where we
end up passing a wrong value into this function? I'm
wondering if this is the best place to fix it, or if maybe
the calling function is at fault.

Also, you can't use #ifdef TARGET_AARCH64 here to distinguish
a 64-bit from a 32-bit CPU, because the qemu-system-aarch64
binary (which is built with TARGET_AARCH64) also supports all
the 32-bit CPUs.

thanks
-- PMM

