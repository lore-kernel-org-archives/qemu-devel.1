Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A681CC47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 10:25:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72BA82080C
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 10:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CV0lKFMJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72BA82080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY5cx-0007Fe-Mc
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 06:25:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jY5bs-0006Iw-De
 for qemu-devel@nongnu.org; Mon, 11 May 2020 06:24:32 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:37151)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jY5br-0004Ms-Df
 for qemu-devel@nongnu.org; Mon, 11 May 2020 06:24:32 -0400
Received: by mail-wm1-x344.google.com with SMTP id z72so8956277wmc.2
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 03:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=haOvfP2ji+PNqgL85X/pNkkTqp+bgl3jt94a1M3WEt0=;
 b=CV0lKFMJL4iSHOczdA7uiVCTfyQ584DZkhnRMFLzPzXmfSu/om8HRAuV/TG7Y04iri
 /hRCezY3cOoYlCYiRqoE0uAehwe/QnDR/XZkibG1ViGrLCeGrWYb4iXhWwfBSAvlQ080
 pLiUyAHw97jCUeqiThbEN4GlApk6ULSlNIclDPS1gVuD4kw/YxozRooDu9QBiocI+uBw
 bDLks6aqOhyvo1/qIGvvelmAX3xi1JYBg7kKeRQqg/MdF9fyp8U+yFlki9NqKi5X4TbI
 jvvKYddmdgJuIuKX8yCsQCzm3hpuZWJKfIqbETEZ0Ya+qawOoK8Tu1alyS3Iml1Nd/7z
 YSvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=haOvfP2ji+PNqgL85X/pNkkTqp+bgl3jt94a1M3WEt0=;
 b=DvpI5ZOlY9GfYQ/532x7Ii88lkckEYas018JpAvrZxl5rSlzo8jHfzLI7f49ia/0ZV
 2ByYvMZGCCSDGz/S6cttFxv2TAUnS//GwskL0ua09sPZtYmFcuJgkP0KlAT5lduJoBvh
 SLMBblxWQCvbk9SAVHJz6ewIuEd9d0mlIKIxS9Q0rUVcAO8z9Rpwmg1vlPwWrobuuYeD
 Vvu++NgHmuJlAkEcPaWZi03sLE7lX+xJdfoVsmvSY9o4h7F7KUCF1gwheIgJ1QqKRa+2
 mwQu0lFn8MI6PMkmqjdD+lC/snDP2rGP2nyKup0ecC1kf+sotV2xcmwaUoM2wFWdIGEV
 RPww==
X-Gm-Message-State: AGi0PuYN0KkOJZDcsJQVGkvxFB04wQSeVwS7r951VRcc7ali5SieiU96
 U64f9yL6tNEkxfww4OYeL4qvCg==
X-Google-Smtp-Source: APiQypKMjbGZ6nzox2oWkx0tlTrYyfQ+rQ1i0oExf/PPuI2FYTPTnWnlfk9Ni+aSVXf8M1UUqNnwkg==
X-Received: by 2002:a7b:cc69:: with SMTP id n9mr4787879wmj.145.1589192669788; 
 Mon, 11 May 2020 03:24:29 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v20sm18534412wrd.9.2020.05.11.03.24.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 03:24:27 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 24C191FF7E;
 Mon, 11 May 2020 11:24:27 +0100 (BST)
References: <20200326193156.4322-1-robert.foley@linaro.org>
 <20200326193156.4322-4-robert.foley@linaro.org>
User-agent: mu4e 1.4.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH v8 03/74] cpu: introduce cpu_mutex_lock/unlock
In-reply-to: <20200326193156.4322-4-robert.foley@linaro.org>
Date: Mon, 11 May 2020 11:24:26 +0100
Message-ID: <873686hiqt.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.puhov@linaro.org, "Emilio G. Cota" <cota@braap.org>,
 richard.henderson@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Robert Foley <robert.foley@linaro.org> writes:

> From: "Emilio G. Cota" <cota@braap.org>
>
> The few direct users of &cpu->lock will be converted soon.
>
> The per-thread bitmap introduced here might seem unnecessary,
> since a bool could just do. However, once we complete the
> conversion to per-vCPU locks, we will need to cover the use
> case where all vCPUs are locked by the same thread, which
> explains why the bitmap is introduced here.
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> Signed-off-by: Robert Foley <robert.foley@linaro.org>
> ---
>  cpus.c                | 48 +++++++++++++++++++++++++++++++++++++++++--
>  include/hw/core/cpu.h | 33 +++++++++++++++++++++++++++++
>  stubs/Makefile.objs   |  1 +
>  stubs/cpu-lock.c      | 28 +++++++++++++++++++++++++
>  4 files changed, 108 insertions(+), 2 deletions(-)
>  create mode 100644 stubs/cpu-lock.c
>
> diff --git a/cpus.c b/cpus.c
> index 71bd2f5d55..633734fb5c 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -91,6 +91,47 @@ static unsigned int throttle_percentage;
>  #define CPU_THROTTLE_PCT_MAX 99
>  #define CPU_THROTTLE_TIMESLICE_NS 10000000
>=20=20
> +/* XXX: is this really the max number of CPUs? */
> +#define CPU_LOCK_BITMAP_SIZE 2048

I wonder if we should be asserting this somewhere? Given it's an init
time constant we can probably do it somewhere in the machine realise
stage. I think the value is set in  MachineState *ms->smp.max_cpus;

<snip>
> diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
> index 45be5dc0ed..d2dd6c94cc 100644
> --- a/stubs/Makefile.objs
> +++ b/stubs/Makefile.objs
> @@ -5,6 +5,7 @@ stub-obj-y +=3D blockdev-close-all-bdrv-states.o
>  stub-obj-y +=3D clock-warp.o
>  stub-obj-y +=3D cpu-get-clock.o
>  stub-obj-y +=3D cpu-get-icount.o
> +stub-obj-y +=3D cpu-lock.o
>  stub-obj-y +=3D dump.o
>  stub-obj-y +=3D error-printf.o
>  stub-obj-y +=3D fdset.o
> diff --git a/stubs/cpu-lock.c b/stubs/cpu-lock.c
> new file mode 100644
> index 0000000000..ca2ea8a9c2
> --- /dev/null
> +++ b/stubs/cpu-lock.c
> @@ -0,0 +1,28 @@
> +#include "qemu/osdep.h"
> +#include "hw/core/cpu.h"
> +
> +void cpu_mutex_lock_impl(CPUState *cpu, const char *file, int line)
> +{
> +/* coverity gets confused by the indirect function call */
> +#ifdef __COVERITY__
> +    qemu_mutex_lock_impl(&cpu->lock, file, line);
> +#else
> +    QemuMutexLockFunc f =3D atomic_read(&qemu_mutex_lock_func);
> +    f(&cpu->lock, file, line);
> +#endif
> +}
> +
> +void cpu_mutex_unlock_impl(CPUState *cpu, const char *file, int line)
> +{
> +    qemu_mutex_unlock_impl(&cpu->lock, file, line);
> +}

I find this a little confusing because we clearly aren't stubbing
something out here - we are indeed doing a lock. What we seem to have is
effectively the linux-user implementation of cpu locking which currently
doesn't support qsp profiling.

> +bool cpu_mutex_locked(const CPUState *cpu)
> +{
> +    return true;
> +}
> +
> +bool no_cpu_mutex_locked(void)
> +{
> +    return true;
> +}

What functions care about these checks. I assume it's only system
emulation checks that are in common code. Maybe that indicates we could
achieve better separation of emulation and linux-user code. My worry is
by adding an assert in linux-user code we wouldn't actually be asserting
anything.

--=20
Alex Benn=C3=A9e

