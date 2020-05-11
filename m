Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C138AC47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 14:51:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9104120720
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 14:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MUIScS4z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9104120720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY9lo-0000lH-Li
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 10:51:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33712)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jY9je-0006sK-7T
 for qemu-devel@nongnu.org; Mon, 11 May 2020 10:48:50 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:52650)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jY9jc-0008J9-Cq
 for qemu-devel@nongnu.org; Mon, 11 May 2020 10:48:49 -0400
Received: by mail-wm1-x343.google.com with SMTP id m24so8725829wml.2
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 07:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=q1wvdbtBIFU8rxUIS5Q3G/CxjdcAgeS+8fKk+BKc294=;
 b=MUIScS4ze/RgBaoDURDmVDsVyelITqy3WD+JhxAYSuqAqrMK7O0dh5SjmAu9nHzzco
 tMww6p/npayYumKvqVYG2wXL4T6R+rwafI+qV1CyvGczjQcofYkdNXMCExxtFJAhXKET
 +AWy2zLuxVYrEfh0Ux90de0hNM2owy3Sgg02N8qjEFkP45f4nKv+NvoqWDDVFn1/vJJh
 mPLzdHGMlPQnuW2c9VXHN8PAeoZkOpMU7GBtdS7u0w5ViEdsBj6Hm3fHFSMUa8lm5cX8
 q1My6KfgrEbGidsRbQAgoYazyRFnSf25KQtL46rhNEovgfKwzbnF023rFsRaoE8aiAvo
 0b/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=q1wvdbtBIFU8rxUIS5Q3G/CxjdcAgeS+8fKk+BKc294=;
 b=J4ThDU0AIsa+hqHZLoBQTu51jsA/X6DYzd52IQQ981y3RiDtJHWzJq0wSJGg66EeT4
 UYRIXRiLLL8Vrf8DFzxktIXU7N8SwkVcBkelxefxNUi5lxU5KhahWeS0hnrKW1Kr4SOy
 3+yHGgh7NmzN5xQtMCfjFichK+S5Wu72jhX4g7L9Uxk0/Mfa9VyxquJBEoetrQcjvnsz
 6PNeJ6wcAaxGRLd3+rjH7rvZFJztNHoWvsTn3miFOcHgjpBxUrguKhn5jH9vRA2sbKzd
 Nr3sN+A39g3FWWtYWZYEfdVfpZv6nPpuZKTC0e2Q/nCwlPcR2yD1kWY+9PU4lsnMtp7j
 c2xw==
X-Gm-Message-State: AGi0PuYvs61mjex0QtwU3cP2nK1oiFXcJGunFVjfHGboy1ftpAfIlbOQ
 HKEIszXtRGqWJbgystTtZ/xm4Q==
X-Google-Smtp-Source: APiQypItTxssSzt7cIrBL/ZnoFP+HZqbNrM9+r2XXNEyUuH9/RPqADTOs5I/krqTGuG1NQ7O+8Wi9Q==
X-Received: by 2002:a7b:cf1a:: with SMTP id l26mr34144913wmg.114.1589208526330; 
 Mon, 11 May 2020 07:48:46 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n17sm4271655wrr.42.2020.05.11.07.48.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 07:48:45 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8BEFA1FF7E;
 Mon, 11 May 2020 15:48:44 +0100 (BST)
References: <20200326193156.4322-1-robert.foley@linaro.org>
 <20200326193156.4322-3-robert.foley@linaro.org>
User-agent: mu4e 1.4.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH v8 02/74] cpu: rename cpu->work_mutex to cpu->lock
In-reply-to: <20200326193156.4322-3-robert.foley@linaro.org>
Date: Mon, 11 May 2020 15:48:44 +0100
Message-ID: <87r1vqfrxv.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x343.google.com
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
> This lock will soon protect more fields of the struct. Give
> it a more appropriate name.

Hmm while bisecting to find another problem I found this commit:

  /home/alex/lsrc/qemu.git/hw/core/cpu.c: In function =E2=80=98cpu_common_f=
inalize=E2=80=99:
  /home/alex/lsrc/qemu.git/hw/core/cpu.c:383:27: error: incompatible type f=
or argument 1 of =E2=80=98qemu_mutex_destroy=E2=80=99
       qemu_mutex_destroy(cpu->lock);
                          ~~~^~~~~~
  In file included from /home/alex/lsrc/qemu.git/include/hw/core/cpu.h:31,
                   from /home/alex/lsrc/qemu.git/hw/core/cpu.c:23:
  /home/alex/lsrc/qemu.git/include/qemu/thread.h:26:36: note: expected =E2=
=80=98QemuMutex *=E2=80=99 {aka =E2=80=98struct QemuMutex *=E2=80=99} but a=
rgument is of type =E2=80=98QemuMutex=E2=80=99 {aka =E2=80=98struct QemuMut=
ex=E2=80=99}
   void qemu_mutex_destroy(QemuMutex *mutex);
                           ~~~~~~~~~~~^~~~~
  make: *** [/home/alex/lsrc/qemu.git/rules.mak:69: hw/core/cpu.o] Error 1

which works fine in the final product so I suspect something has slipped
between commits somewhere.

>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> Signed-off-by: Robert Foley <robert.foley@linaro.org>
> ---
>  cpus-common.c         | 14 +++++++-------
>  cpus.c                |  4 ++--
>  hw/core/cpu.c         |  4 ++--
>  include/hw/core/cpu.h |  6 ++++--
>  4 files changed, 15 insertions(+), 13 deletions(-)
>
> diff --git a/cpus-common.c b/cpus-common.c
> index 3d659df464..f75cae23d9 100644
> --- a/cpus-common.c
> +++ b/cpus-common.c
> @@ -107,10 +107,10 @@ struct qemu_work_item {
>=20=20
>  static void queue_work_on_cpu(CPUState *cpu, struct qemu_work_item *wi)
>  {
> -    qemu_mutex_lock(&cpu->work_mutex);
> +    qemu_mutex_lock(&cpu->lock);
>      QSIMPLEQ_INSERT_TAIL(&cpu->work_list, wi, node);
>      wi->done =3D false;
> -    qemu_mutex_unlock(&cpu->work_mutex);
> +    qemu_mutex_unlock(&cpu->lock);
>=20=20
>      qemu_cpu_kick(cpu);
>  }
> @@ -304,15 +304,15 @@ void process_queued_cpu_work(CPUState *cpu)
>  {
>      struct qemu_work_item *wi;
>=20=20
> -    qemu_mutex_lock(&cpu->work_mutex);
> +    qemu_mutex_lock(&cpu->lock);
>      if (QSIMPLEQ_EMPTY(&cpu->work_list)) {
> -        qemu_mutex_unlock(&cpu->work_mutex);
> +        qemu_mutex_unlock(&cpu->lock);
>          return;
>      }
>      while (!QSIMPLEQ_EMPTY(&cpu->work_list)) {
>          wi =3D QSIMPLEQ_FIRST(&cpu->work_list);
>          QSIMPLEQ_REMOVE_HEAD(&cpu->work_list, node);
> -        qemu_mutex_unlock(&cpu->work_mutex);
> +        qemu_mutex_unlock(&cpu->lock);
>          if (wi->exclusive) {
>              /* Running work items outside the BQL avoids the following d=
eadlock:
>               * 1) start_exclusive() is called with the BQL taken while a=
nother
> @@ -328,13 +328,13 @@ void process_queued_cpu_work(CPUState *cpu)
>          } else {
>              wi->func(cpu, wi->data);
>          }
> -        qemu_mutex_lock(&cpu->work_mutex);
> +        qemu_mutex_lock(&cpu->lock);
>          if (wi->free) {
>              g_free(wi);
>          } else {
>              atomic_mb_set(&wi->done, true);
>          }
>      }
> -    qemu_mutex_unlock(&cpu->work_mutex);
> +    qemu_mutex_unlock(&cpu->lock);
>      qemu_cond_broadcast(&qemu_work_cond);
>  }
> diff --git a/cpus.c b/cpus.c
> index 151abbc04c..71bd2f5d55 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -100,9 +100,9 @@ static inline bool cpu_work_list_empty(CPUState *cpu)
>  {
>      bool ret;
>=20=20
> -    qemu_mutex_lock(&cpu->work_mutex);
> +    qemu_mutex_lock(&cpu->lock);
>      ret =3D QSIMPLEQ_EMPTY(&cpu->work_list);
> -    qemu_mutex_unlock(&cpu->work_mutex);
> +    qemu_mutex_unlock(&cpu->lock);
>      return ret;
>  }
>=20=20
> diff --git a/hw/core/cpu.c b/hw/core/cpu.c
> index 2fc6aa2159..bc0416829a 100644
> --- a/hw/core/cpu.c
> +++ b/hw/core/cpu.c
> @@ -367,7 +367,7 @@ static void cpu_common_initfn(Object *obj)
>      cpu->nr_cores =3D 1;
>      cpu->nr_threads =3D 1;
>=20=20
> -    qemu_mutex_init(&cpu->work_mutex);
> +    qemu_mutex_init(&cpu->lock);
>      QSIMPLEQ_INIT(&cpu->work_list);
>      QTAILQ_INIT(&cpu->breakpoints);
>      QTAILQ_INIT(&cpu->watchpoints);
> @@ -379,7 +379,7 @@ static void cpu_common_finalize(Object *obj)
>  {
>      CPUState *cpu =3D CPU(obj);
>=20=20
> -    qemu_mutex_destroy(&cpu->work_mutex);
> +    qemu_mutex_destroy(cpu->lock);
>  }
>=20=20
>  static int64_t cpu_common_get_arch_id(CPUState *cpu)
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 398b65159e..0b75fdb093 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -331,7 +331,8 @@ struct qemu_work_item;
>   * @opaque: User data.
>   * @mem_io_pc: Host Program Counter at which the memory was accessed.
>   * @kvm_fd: vCPU file descriptor for KVM.
> - * @work_mutex: Lock to prevent multiple access to @work_list.
> + * @lock: Lock to prevent multiple access to per-CPU fields. Must be acq=
uired
> + *        after the BQL.
>   * @work_list: List of pending asynchronous work.
>   * @trace_dstate_delayed: Delayed changes to trace_dstate (includes all =
changes
>   *                        to @trace_dstate).
> @@ -375,7 +376,8 @@ struct CPUState {
>      uint64_t random_seed;
>      sigjmp_buf jmp_env;
>=20=20
> -    QemuMutex work_mutex;
> +    QemuMutex lock;
> +    /* fields below protected by @lock */
>      QSIMPLEQ_HEAD(, qemu_work_item) work_list;
>=20=20
>      CPUAddressSpace *cpu_ases;


--=20
Alex Benn=C3=A9e

