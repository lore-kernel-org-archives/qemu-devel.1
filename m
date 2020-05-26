Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC36C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 15:03:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4740A206D5
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 15:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XTGpKwMo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4740A206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdb74-0002qp-CN
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 11:03:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jdb53-0000C9-Ij
 for qemu-devel@nongnu.org; Tue, 26 May 2020 11:01:25 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:37888)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jdb51-0007Do-SU
 for qemu-devel@nongnu.org; Tue, 26 May 2020 11:01:24 -0400
Received: by mail-lj1-x242.google.com with SMTP id m18so24892665ljo.5
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 08:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=JLbAW+x6xG3wJveCGaX2SvBQnerCVzanTHd7T7O5c9g=;
 b=XTGpKwMoEj5+dWS835w4y1/6kBgLvQe+KDEtwf3M7dYUjaY6HtIJpMwvvXGtfdHbzy
 /3sZ0Q06NALy5D1in7og2LKEkxNiCoQzKynuqmZ0AEpTvL18u6QoCXxSM0PnQHo35zHv
 2hpHb8lnzrTfgbTj/0QCynlkgv3msloF8LM52rvn3CPJdl/Vcr6XaGDxLiyaYCUb8XRl
 vcGJgKC99T8eiCLMrHWKSi/YHD67hgOYe/6lVqf5lDFUCYk+RaWBwFruxxSk/LRbT5bD
 GLcZ3N3alk7qH/rSvlGPJSkSpxs+WY7PgsQi4f+AYDwkgebypKqKBu6xqRRbhPhqUUcY
 Cu1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=JLbAW+x6xG3wJveCGaX2SvBQnerCVzanTHd7T7O5c9g=;
 b=EKflBw0hWtFD/Mpj7NH2qRWuRmqGBo0sBTUvvw3tL6s2xYR/ZUSu3JVQUSCVVoyVeN
 MwQHe/AQwBAQOci129ALBTrTCrfm4Mjz9z5nYgGAzb3jOKoWeDRLMhWP7PZrfWy7NBER
 toxKQWcA5bl4betXt+piJH0cNPTJbfTOHPGqVGNsCACPnSWY5AL9epdt/01hY3J1g40R
 C0st0dWMzE0GKwaUJ412LdbIHCBbhfPIusDcg8RQbXIe3h4rVc25K/MZVc62fNhOW/Uq
 F/duTh+fYWo83E3pbBvAwXn2op9ub0mehf5hqKp+GXqPb65om8Wy5r03+Vr32ZSkCjX+
 dkAA==
X-Gm-Message-State: AOAM533QqP0yrXXr1ipk0jqvdq3Vi0roKRA1JARqIaIoWB5x7F9V52xe
 mN8nJXiEg3GMOSIvtEaAzjwPyK9vr2bhtkTO9I2FXg==
X-Google-Smtp-Source: ABdhPJwEBNITwvZku8WUgbadaAbyk7uGFvVzQX6oQ7oiprfRc6GnkBSySXfmvSXDVOzvoAFOo6bjBJ4sfSZ3gqVCd7I=
X-Received: by 2002:a2e:9bcc:: with SMTP id w12mr862926ljj.9.1590505278999;
 Tue, 26 May 2020 08:01:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200522160755.886-1-robert.foley@linaro.org>
 <20200522160755.886-3-robert.foley@linaro.org>
 <c9800478-e184-32ad-6cec-3f8ad4e3bed1@redhat.com>
In-Reply-To: <c9800478-e184-32ad-6cec-3f8ad4e3bed1@redhat.com>
From: Robert Foley <robert.foley@linaro.org>
Date: Tue, 26 May 2020 11:01:14 -0400
Message-ID: <CAEyhzFtvUt9wwJNcQ8b5i3UiJjxa-_m3ufZwhu1Frw5FQZJtMw@mail.gmail.com>
Subject: Re: [PATCH 02/19] cpu: convert queued work to a QSIMPLEQ
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::242;
 envelope-from=robert.foley@linaro.org; helo=mail-lj1-x242.google.com
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
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 24 May 2020 at 06:21, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> On 5/22/20 6:07 PM, Robert Foley wrote:
> > From: "Emilio G. Cota" <cota@braap.org>
> >
> > Instead of open-coding it.
>
> Please use a full sentence (repeating the patch subject):
>
> "Convert queued work to a QSIMPLEQ instead of open-coding it."
>
> (Not all email clients display the subject preceding the content).

OK, I will update this commit message.

Thanks & Regards,
-Rob
>
> Otherwise:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>
> >
> > While at it, make sure that all accesses to the list are
> > performed while holding the list's lock.
> >
> > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> > Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > Signed-off-by: Emilio G. Cota <cota@braap.org>
> > Signed-off-by: Robert Foley <robert.foley@linaro.org>
> > ---
> >  cpus-common.c         | 25 ++++++++-----------------
> >  cpus.c                | 14 ++++++++++++--
> >  hw/core/cpu.c         |  1 +
> >  include/hw/core/cpu.h |  6 +++---
> >  4 files changed, 24 insertions(+), 22 deletions(-)
> >
> > diff --git a/cpus-common.c b/cpus-common.c
> > index 55d5df8923..210fc7fc39 100644
> > --- a/cpus-common.c
> > +++ b/cpus-common.c
> > @@ -97,7 +97,7 @@ void cpu_list_remove(CPUState *cpu)
> >  }
> >
> >  struct qemu_work_item {
> > -    struct qemu_work_item *next;
> > +    QSIMPLEQ_ENTRY(qemu_work_item) node;
> >      run_on_cpu_func func;
> >      run_on_cpu_data data;
> >      bool free, exclusive, done;
> > @@ -106,13 +106,7 @@ struct qemu_work_item {
> >  static void queue_work_on_cpu(CPUState *cpu, struct qemu_work_item *wi=
)
> >  {
> >      qemu_mutex_lock(&cpu->work_mutex);
> > -    if (cpu->queued_work_first =3D=3D NULL) {
> > -        cpu->queued_work_first =3D wi;
> > -    } else {
> > -        cpu->queued_work_last->next =3D wi;
> > -    }
> > -    cpu->queued_work_last =3D wi;
> > -    wi->next =3D NULL;
> > +    QSIMPLEQ_INSERT_TAIL(&cpu->work_list, wi, node);
> >      wi->done =3D false;
> >      qemu_mutex_unlock(&cpu->work_mutex);
> >
> > @@ -306,17 +300,14 @@ void process_queued_cpu_work(CPUState *cpu)
> >  {
> >      struct qemu_work_item *wi;
> >
> > -    if (cpu->queued_work_first =3D=3D NULL) {
> > +    qemu_mutex_lock(&cpu->work_mutex);
> > +    if (QSIMPLEQ_EMPTY(&cpu->work_list)) {
> > +        qemu_mutex_unlock(&cpu->work_mutex);
> >          return;
> >      }
> > -
> > -    qemu_mutex_lock(&cpu->work_mutex);
> > -    while (cpu->queued_work_first !=3D NULL) {
> > -        wi =3D cpu->queued_work_first;
> > -        cpu->queued_work_first =3D wi->next;
> > -        if (!cpu->queued_work_first) {
> > -            cpu->queued_work_last =3D NULL;
> > -        }
> > +    while (!QSIMPLEQ_EMPTY(&cpu->work_list)) {
> > +        wi =3D QSIMPLEQ_FIRST(&cpu->work_list);
> > +        QSIMPLEQ_REMOVE_HEAD(&cpu->work_list, node);
> >          qemu_mutex_unlock(&cpu->work_mutex);
> >          if (wi->exclusive) {
> >              /* Running work items outside the BQL avoids the following=
 deadlock:
> > diff --git a/cpus.c b/cpus.c
> > index 5670c96bcf..af44027549 100644
> > --- a/cpus.c
> > +++ b/cpus.c
> > @@ -97,9 +97,19 @@ bool cpu_is_stopped(CPUState *cpu)
> >      return cpu->stopped || !runstate_is_running();
> >  }
> >
> > +static inline bool cpu_work_list_empty(CPUState *cpu)
> > +{
> > +    bool ret;
> > +
> > +    qemu_mutex_lock(&cpu->work_mutex);
> > +    ret =3D QSIMPLEQ_EMPTY(&cpu->work_list);
> > +    qemu_mutex_unlock(&cpu->work_mutex);
> > +    return ret;
> > +}
> > +
> >  static bool cpu_thread_is_idle(CPUState *cpu)
> >  {
> > -    if (cpu->stop || cpu->queued_work_first) {
> > +    if (cpu->stop || !cpu_work_list_empty(cpu)) {
> >          return false;
> >      }
> >      if (cpu_is_stopped(cpu)) {
> > @@ -1498,7 +1508,7 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
> >              cpu =3D first_cpu;
> >          }
> >
> > -        while (cpu && !cpu->queued_work_first && !cpu->exit_request) {
> > +        while (cpu && cpu_work_list_empty(cpu) && !cpu->exit_request) =
{
> >
> >              atomic_mb_set(&tcg_current_rr_cpu, cpu);
> >              current_cpu =3D cpu;
> > diff --git a/hw/core/cpu.c b/hw/core/cpu.c
> > index 5284d384fb..77703d62b7 100644
> > --- a/hw/core/cpu.c
> > +++ b/hw/core/cpu.c
> > @@ -368,6 +368,7 @@ static void cpu_common_initfn(Object *obj)
> >      cpu->nr_threads =3D 1;
> >
> >      qemu_mutex_init(&cpu->work_mutex);
> > +    QSIMPLEQ_INIT(&cpu->work_list);
> >      QTAILQ_INIT(&cpu->breakpoints);
> >      QTAILQ_INIT(&cpu->watchpoints);
> >
> > diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> > index 07f7698155..d78ff1d165 100644
> > --- a/include/hw/core/cpu.h
> > +++ b/include/hw/core/cpu.h
> > @@ -331,8 +331,8 @@ struct qemu_work_item;
> >   * @opaque: User data.
> >   * @mem_io_pc: Host Program Counter at which the memory was accessed.
> >   * @kvm_fd: vCPU file descriptor for KVM.
> > - * @work_mutex: Lock to prevent multiple access to queued_work_*.
> > - * @queued_work_first: First asynchronous work pending.
> > + * @work_mutex: Lock to prevent multiple access to @work_list.
> > + * @work_list: List of pending asynchronous work.
> >   * @trace_dstate_delayed: Delayed changes to trace_dstate (includes al=
l changes
> >   *                        to @trace_dstate).
> >   * @trace_dstate: Dynamic tracing state of events for this vCPU (bitma=
sk).
> > @@ -376,7 +376,7 @@ struct CPUState {
> >      sigjmp_buf jmp_env;
> >
> >      QemuMutex work_mutex;
> > -    struct qemu_work_item *queued_work_first, *queued_work_last;
> > +    QSIMPLEQ_HEAD(, qemu_work_item) work_list;
> >
> >      CPUAddressSpace *cpu_ases;
> >      int num_ases;
> >
>

