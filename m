Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC46FC54E8E
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 16:10:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9F9C20722
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 16:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n8w9vOZb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9F9C20722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYB0R-00021e-Q6
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 12:10:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48166)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jYAzd-0001Vn-FO
 for qemu-devel@nongnu.org; Mon, 11 May 2020 12:09:25 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:44793)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jYAzc-0000u3-9N
 for qemu-devel@nongnu.org; Mon, 11 May 2020 12:09:25 -0400
Received: by mail-lf1-x142.google.com with SMTP id d22so1939866lfm.11
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 09:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=+j/m/C25PvcZndCgjiMvsb8/dz+Ni/Lb7T3G4r/YIB0=;
 b=n8w9vOZb43qfCawoO8y5ElIY9JB0alZIYfJDpaBcmckQi6O83KECUf7J9Bw6ShlWau
 ong+nteATcd8hYfi7kYjdc/QvEy8qbYF+igHd05pm032dU90lb3obVF6FtWsU9tlVeW+
 XXlNW2w6meSLkofMCyOF48oJPkAKquGl7vTUgsF520B8ONG7BnACfM8vQTLOBAtgw9JK
 TUrA6VeJFPDm3/udtHDuQcSUQ9VIC+cR8UbZrvWoaEVfd5BGZ4bf4ExwbiHqBm/POYxQ
 RIeLIksKSTLoJ7IB9sd/eKCzTOloEnMMYmzRV5K8yIgM9OTEx6dNZ0iYI8wqjXayGktM
 /85A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=+j/m/C25PvcZndCgjiMvsb8/dz+Ni/Lb7T3G4r/YIB0=;
 b=iXCsoxba8HkIvvAhBf75s+efK+86s75CTXWfl8jFlSSpcv1TC0gB9qOYhxjnrqP7Aa
 dhRNbqPNl4po5vIF25b3l/GpWwbZgeGlCEks1s5/l5MXKl0T9gdXQMmk10d4GOq1tQgd
 57D7/kQUWKq0Cx829TnwbJrM/ZfKDyKrxFo3dGbBzDzr3Sam7OMbXgL9vYa/GSHLX0jH
 8Mp4ua0HrQNxHmF/VTFJ4LAK6lYIH2fVs3dXz4XBF/c9XSkofH9fn1/msFZul/1ui5pg
 4vRLLbw5w1OEQlIZjoFcgB2sW6sH9ypl4G3zT5fIxoFAB0iFmvvyWWAxbtbUCPHwDfbI
 tO+g==
X-Gm-Message-State: AOAM531DCXYsFlMiS7+xnQHIjHQlAhF7U+3uXeuk7hyOco9tdYmF5fs1
 t5xUwYaPbCKF86gj5qBNdOE8Hri57cxWZLMFQqhjZQ==
X-Google-Smtp-Source: ABdhPJztiQc0Hqd1ANeryLLTwX9PfbWENpaAhhGsEpuRHgllFdzp9ISqxDEkdQmwB+SdI2j8bDyuKJUjPQSlYQkXcxg=
X-Received: by 2002:a19:4f1b:: with SMTP id d27mr11602018lfb.81.1589213362313; 
 Mon, 11 May 2020 09:09:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200326193156.4322-1-robert.foley@linaro.org>
 <20200326193156.4322-4-robert.foley@linaro.org> <873686hiqt.fsf@linaro.org>
In-Reply-To: <873686hiqt.fsf@linaro.org>
From: Robert Foley <robert.foley@linaro.org>
Date: Mon, 11 May 2020 12:09:15 -0400
Message-ID: <CAEyhzFur3_81T2pkt-8p4zx-Sh8zFHazPaZfJ_nDpfndZBtR6g@mail.gmail.com>
Subject: Re: [PATCH v8 03/74] cpu: introduce cpu_mutex_lock/unlock
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::142;
 envelope-from=robert.foley@linaro.org; helo=mail-lf1-x142.google.com
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
Cc: Peter Puhov <peter.puhov@linaro.org>, "Emilio G. Cota" <cota@braap.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 11 May 2020 at 06:24, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
> Robert Foley <robert.foley@linaro.org> writes:
snip
> > +/* XXX: is this really the max number of CPUs? */
> > +#define CPU_LOCK_BITMAP_SIZE 2048
>
> I wonder if we should be asserting this somewhere? Given it's an init
> time constant we can probably do it somewhere in the machine realise
> stage. I think the value is set in  MachineState *ms->smp.max_cpus;

Sure, I suppose we can relocate the define to something like hw/core/cpu.h,
and then assert on it in smp_parse() from hw/core/machine.c?

> <snip>
> > diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
> > index 45be5dc0ed..d2dd6c94cc 100644
> > --- a/stubs/Makefile.objs
> > +++ b/stubs/Makefile.objs
> > @@ -5,6 +5,7 @@ stub-obj-y +=3D blockdev-close-all-bdrv-states.o
> >  stub-obj-y +=3D clock-warp.o
> >  stub-obj-y +=3D cpu-get-clock.o
> >  stub-obj-y +=3D cpu-get-icount.o
> > +stub-obj-y +=3D cpu-lock.o
> >  stub-obj-y +=3D dump.o
> >  stub-obj-y +=3D error-printf.o
> >  stub-obj-y +=3D fdset.o
> > diff --git a/stubs/cpu-lock.c b/stubs/cpu-lock.c
> > new file mode 100644
> > index 0000000000..ca2ea8a9c2
> > --- /dev/null
> > +++ b/stubs/cpu-lock.c
> > @@ -0,0 +1,28 @@
> > +#include "qemu/osdep.h"
> > +#include "hw/core/cpu.h"
> > +
> > +void cpu_mutex_lock_impl(CPUState *cpu, const char *file, int line)
> > +{
> > +/* coverity gets confused by the indirect function call */
> > +#ifdef __COVERITY__
> > +    qemu_mutex_lock_impl(&cpu->lock, file, line);
> > +#else
> > +    QemuMutexLockFunc f =3D atomic_read(&qemu_mutex_lock_func);
> > +    f(&cpu->lock, file, line);
> > +#endif
> > +}
> > +
> > +void cpu_mutex_unlock_impl(CPUState *cpu, const char *file, int line)
> > +{
> > +    qemu_mutex_unlock_impl(&cpu->lock, file, line);
> > +}
>
> I find this a little confusing because we clearly aren't stubbing
> something out here - we are indeed doing a lock. What we seem to have is
> effectively the linux-user implementation of cpu locking which currently
> doesn't support qsp profiling.

I agree, it seems like cpu_mutex_lock/unlock can follow the model of
stubs/iothread-lock.c,
which does not use a lock.  Will change this.

>
> > +bool cpu_mutex_locked(const CPUState *cpu)
> > +{
> > +    return true;
> > +}
> > +
> > +bool no_cpu_mutex_locked(void)
> > +{
> > +    return true;
> > +}
>
> What functions care about these checks. I assume it's only system
> emulation checks that are in common code. Maybe that indicates we could
> achieve better separation of emulation and linux-user code. My worry is
> by adding an assert in linux-user code we wouldn't actually be asserting
> anything.

There is code that runs during linux-user, which calls
cpu_mutex_locked().  I found a few cases at least where
cpu_interrupt_request_set, cpu_halted, cpu_halted_set from
include/hw/core/cpu.h are called in linux-user.  Also
cpu_handle_halt_locked from accel/tcg/cpu-exec.c

no_cpu_mutex_locked() is also linked into linux user for
run_on_cpu()in cpus-common.c.

Thanks,
-Rob

