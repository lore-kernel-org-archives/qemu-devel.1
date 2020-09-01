Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701AAC433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 10:22:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 146F4206FA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 10:22:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VdGyw1rI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 146F4206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD3Qc-0003MH-5i
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 06:22:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51408)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kD3PX-0002Cs-0D
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 06:21:08 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51437)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kD3PU-0007SA-BB
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 06:21:06 -0400
Received: by mail-wm1-x342.google.com with SMTP id w2so598506wmi.1
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 03:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=eYJ0RXkZvzuWGnDMGsRwvxIJEBCxdxtR+jMX6kcyO7Y=;
 b=VdGyw1rIJ6tWZl7SC4sx4mGwJz0sPlS4W3AkplHW0gPucboLXB6Lo32NmWGwyQw3Et
 z6HBhvQMhWl51TMoiBABENnBpF8d8+posbYF6mP1xz5PMVc/BqcedHg9tS0j4VtNmpyJ
 7IKoH8oDA/ufJbexyjpLMo320X83RvAtRZqhMrShyCIDqGoxnqQkqpu9KdX9p3E+5RbN
 KW9odR22cMBnvNz128/qQqkH/EaNcybgkv+//qTYxFux6av0f26J151BxB8O6mC1HG88
 KnO0VGDOhUICHSem90LusYYRntPWTdC8ShIsu+1Hjv7ZFM2iBhRzZEAIBQkLT8t8RXGq
 ju8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=eYJ0RXkZvzuWGnDMGsRwvxIJEBCxdxtR+jMX6kcyO7Y=;
 b=FMlewxkBFCtXe3PqAfN8gsffg1276BiCGAjbtMne9m+Wg1ozB1AyJzTkUBWAqDDNiz
 kFdqOaDpi74SaQT+J2WlO910iPffnFEdg4VFAVYkErJmNHYQroPuvB1f71eb3SA00GKe
 HNdaLuG/xdH8BsXCP80Mhfpw2nmBWVFOZ4LawLD5dJK27XrEKP1rWmcIDatgIeQ+Yuh6
 zapyggoJrG+fPuEp1efZUNanQnUd7Jkc5OO+IHYMLeDecN8clj5Kz4EW/bnPXKC42xxS
 ReNO8q6+V/h45QYNLSIcLAYvUYk7kf4fbl99MLodbvrc+G87P5e+GJ79R8Kt1TPKJCO8
 SacA==
X-Gm-Message-State: AOAM5339NLCskSKSgl9Vl4COLHB/FHYrV6nrraEApxOXgllBY32KxgPU
 42S8XAqlMnViZpSNkhWw2Y4BEA==
X-Google-Smtp-Source: ABdhPJyGUS5GbEBKXFSrKdzcdcB9IAyTBD5QmxcYe7hiqe30qutYyT91jWCAOCRwJu6E2ZXk8pkutA==
X-Received: by 2002:a1c:a185:: with SMTP id k127mr1129233wme.142.1598955662007; 
 Tue, 01 Sep 2020 03:21:02 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id p16sm1512613wro.71.2020.09.01.03.21.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 03:21:00 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id ECEF11FF7E;
 Tue,  1 Sep 2020 11:20:59 +0100 (BST)
References: <20200901072201.7133-1-cfontana@suse.de>
 <20200901072201.7133-2-cfontana@suse.de>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH v6 01/16] cpu-timers, icount: new modules
In-reply-to: <20200901072201.7133-2-cfontana@suse.de>
Date: Tue, 01 Sep 2020 11:20:59 +0100
Message-ID: <87r1rl6bn8.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Alberto Garcia <berto@igalia.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>, haxm-team@intel.com,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Roman Bolshakov <r.bolshakov@yadro.com>,
 Colin Xu <colin.xu@intel.com>, Wenchao Wang <wenchao.wang@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Sunil Muthuswamy <sunilmut@microsoft.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Claudio Fontana <cfontana@suse.de> writes:

> refactoring of cpus.c continues with cpu timer state extraction.
>
> cpu-timers: responsible for the softmmu cpu timers state,
>             including cpu clocks and ticks.
>
> icount: counts the TCG instructions executed. As such it is specific to
> the TCG accelerator. Therefore, it is built only under CONFIG_TCG.
>
> One complication is due to qtest, which uses an icount field to warp time
> as part of qtest (qtest_clock_warp).
>
> In order to solve this problem, provide a separate counter for qtest.
>
> This requires fixing assumptions scattered in the code that
> qtest_enabled() implies icount_enabled(), checking each specific case.
>
> Signed-off-by: Claudio Fontana <cfontana@suse.de>
> ---
<snip>
> +
> +void qemu_timer_notify_cb(void *opaque, QEMUClockType type)
> +{
> +    if (!icount_enabled() || type !=3D QEMU_CLOCK_VIRTUAL) {
> +        qemu_notify_event();
> +        return;
> +    }
> +
> +    if (qemu_in_vcpu_thread()) {
> +        /*
> +         * A CPU is currently running; kick it back out to the
> +         * tcg_cpu_exec() loop so it will recalculate its
> +         * icount deadline immediately.
> +         */
> +        qemu_cpu_kick(current_cpu);
> +    } else if (first_cpu) {
> +        /*
> +         * qemu_cpu_kick is not enough to kick a halted CPU out of
> +         * qemu_tcg_wait_io_event.  async_run_on_cpu, instead,
> +         * causes cpu_thread_is_idle to return false.  This way,
> +         * handle_icount_deadline can run.
> +         * If we have no CPUs at all for some reason, we don't
> +         * need to do anything.
> +         */
> +        async_run_on_cpu(first_cpu, do_nothing, RUN_ON_CPU_NULL);
> +    }
> +}
> +

See bellow for comments on stub.

> diff --git a/softmmu/vl.c b/softmmu/vl.c
> index 0cc86b0766..ff94cf4983 100644
> --- a/softmmu/vl.c
> +++ b/softmmu/vl.c
> @@ -74,6 +74,7 @@
>  #include "hw/audio/soundhw.h"
>  #include "audio/audio.h"
>  #include "sysemu/cpus.h"
> +#include "sysemu/cpu-timers.h"
>  #include "migration/colo.h"
>  #include "migration/postcopy-ram.h"
>  #include "sysemu/kvm.h"
> @@ -2802,7 +2803,7 @@ static void configure_accelerators(const char *prog=
name)
>          error_report("falling back to %s", ac->name);
>      }
>=20=20
> -    if (use_icount && !(tcg_enabled() || qtest_enabled())) {
> +    if (icount_enabled() && !tcg_enabled()) {
>          error_report("-icount is not allowed with hardware virtualizatio=
n");
>          exit(1);
>      }
> @@ -4237,7 +4238,11 @@ void qemu_init(int argc, char **argv, char **envp)
>          semihosting_arg_fallback(kernel_filename, kernel_cmdline);
>      }
>=20=20
> -    cpu_ticks_init();
> +    /* initialize cpu timers and VCPU throttle modules */
> +    cpu_timers_init();
> +
> +    /* spice needs the timers to be initialized by this point */
> +    qemu_spice_init();

This seems to be an additional fix?

<snip>
> diff --git a/stubs/cpu-get-icount.c b/stubs/cpu-get-icount.c
> deleted file mode 100644
> index b35f844638..0000000000
> --- a/stubs/cpu-get-icount.c
> +++ /dev/null
> @@ -1,21 +0,0 @@
> -#include "qemu/osdep.h"
> -#include "qemu/timer.h"
> -#include "sysemu/cpus.h"
> -#include "qemu/main-loop.h"
> -
> -int use_icount;
> -
> -int64_t cpu_get_icount(void)
> -{
> -    abort();
> -}
> -
> -int64_t cpu_get_icount_raw(void)
> -{
> -    abort();
> -}
> -
> -void qemu_timer_notify_cb(void *opaque, QEMUClockType type)
> -{
> -    qemu_notify_event();
> -}

Hmm so this was existing behaviour for stubs - I find it slightly weird
that a stub function actually does something - although of course that
might be stubbed as well :-/

> diff --git a/stubs/icount.c b/stubs/icount.c
> new file mode 100644
> index 0000000000..61e28cbaf9
> --- /dev/null
> +++ b/stubs/icount.c
> @@ -0,0 +1,45 @@
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "sysemu/cpu-timers.h"
> +
> +/* icount - Instruction Counter API */
> +
> +int use_icount;
> +
> +void cpu_update_icount(CPUState *cpu)
> +{
> +    abort();
> +}
> +void configure_icount(QemuOpts *opts, Error **errp)
> +{
> +    /* signal error */
> +    error_setg(errp, "cannot configure icount, TCG support not available=
");
> +}
> +int64_t cpu_get_icount_raw(void)
> +{
> +    abort();
> +    return 0;
> +}
> +int64_t cpu_get_icount(void)
> +{
> +    abort();
> +    return 0;
> +}
> +int64_t cpu_icount_to_ns(int64_t icount)
> +{
> +    abort();
> +    return 0;
> +}
> +int64_t qemu_icount_round(int64_t count)
> +{
> +    abort();
> +    return 0;
> +}
> +void qemu_start_warp_timer(void)
> +{
> +    abort();
> +}
> +void qemu_account_warp_timer(void)
> +{
> +    abort();
> +}
> diff --git a/stubs/meson.build b/stubs/meson.build
> index 019bd79c7a..57fec4f8c8 100644
> --- a/stubs/meson.build
> +++ b/stubs/meson.build
> @@ -3,10 +3,10 @@ stub_ss.add(files('bdrv-next-monitor-owned.c'))
>  stub_ss.add(files('blk-commit-all.c'))
>  stub_ss.add(files('blockdev-close-all-bdrv-states.c'))
>  stub_ss.add(files('change-state-handler.c'))
> -stub_ss.add(files('clock-warp.c'))
>  stub_ss.add(files('cmos.c'))
>  stub_ss.add(files('cpu-get-clock.c'))
> -stub_ss.add(files('cpu-get-icount.c'))
> +stub_ss.add(files('qemu-timer-notify-cb.c'))
> +stub_ss.add(files('icount.c'))
>  stub_ss.add(files('dump.c'))
>  stub_ss.add(files('error-printf.c'))
>  stub_ss.add(files('fd-register.c'))
> diff --git a/stubs/qemu-timer-notify-cb.c b/stubs/qemu-timer-notify-cb.c
> new file mode 100644
> index 0000000000..845e46f8e0
> --- /dev/null
> +++ b/stubs/qemu-timer-notify-cb.c
> @@ -0,0 +1,8 @@
> +#include "qemu/osdep.h"
> +#include "sysemu/cpu-timers.h"
> +#include "qemu/main-loop.h"
> +
> +void qemu_timer_notify_cb(void *opaque, QEMUClockType type)
> +{
> +    qemu_notify_event();
> +}
> diff --git a/stubs/qtest.c b/stubs/qtest.c
> index 891eb954fb..4666a49d7d 100644
> --- a/stubs/qtest.c
> +++ b/stubs/qtest.c
> @@ -18,3 +18,8 @@ bool qtest_driver(void)
>  {
>      return false;
>  }
> +
> +int64_t qtest_get_virtual_clock(void)
> +{
> +    return 0;
> +}
> diff --git a/target/alpha/translate.c b/target/alpha/translate.c
> index 8870284f57..36be602179 100644
> --- a/target/alpha/translate.c
> +++ b/target/alpha/translate.c
> @@ -20,6 +20,7 @@
>  #include "qemu/osdep.h"
>  #include "cpu.h"
>  #include "sysemu/cpus.h"
> +#include "sysemu/cpu-timers.h"
>  #include "disas/disas.h"
>  #include "qemu/host-utils.h"
>  #include "exec/exec-all.h"
> @@ -1329,7 +1330,7 @@ static DisasJumpType gen_mfpr(DisasContext *ctx, TC=
Gv va, int regno)
>      case 249: /* VMTIME */
>          helper =3D gen_helper_get_vmtime;
>      do_helper:
> -        if (use_icount) {
> +        if (icount_enabled()) {
>              gen_io_start();
>              helper(va);
>              return DISAS_PC_STALE;
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 44d666627a..dc2b91084c 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -24,6 +24,7 @@
>  #include "hw/irq.h"
>  #include "hw/semihosting/semihost.h"
>  #include "sysemu/cpus.h"
> +#include "sysemu/cpu-timers.h"
>  #include "sysemu/kvm.h"
>  #include "sysemu/tcg.h"
>  #include "qemu/range.h"
> @@ -1206,7 +1207,7 @@ static int64_t cycles_ns_per(uint64_t cycles)
>=20=20
>  static bool instructions_supported(CPUARMState *env)
>  {
> -    return use_icount =3D=3D 1 /* Precise instruction counting */;
> +    return icount_enabled() =3D=3D 1; /* Precise instruction counting */
>  }
>=20=20
>  static uint64_t instructions_get_count(CPUARMState *env)
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 200001de74..5231404a70 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -299,7 +299,7 @@ static int write_vstart(CPURISCVState *env, int csrno=
, target_ulong val)
>  static int read_instret(CPURISCVState *env, int csrno, target_ulong *val)
>  {
>  #if !defined(CONFIG_USER_ONLY)
> -    if (use_icount) {
> +    if (icount_enabled()) {
>          *val =3D cpu_get_icount();
>      } else {
>          *val =3D cpu_get_host_ticks();
> @@ -314,7 +314,7 @@ static int read_instret(CPURISCVState *env, int csrno=
, target_ulong *val)
>  static int read_instreth(CPURISCVState *env, int csrno, target_ulong *va=
l)
>  {
>  #if !defined(CONFIG_USER_ONLY)
> -    if (use_icount) {
> +    if (icount_enabled()) {
>          *val =3D cpu_get_icount() >> 32;
>      } else {
>          *val =3D cpu_get_host_ticks() >> 32;
> diff --git a/tests/ptimer-test-stubs.c b/tests/ptimer-test-stubs.c
> index ed393d9082..e935a1395e 100644
> --- a/tests/ptimer-test-stubs.c
> +++ b/tests/ptimer-test-stubs.c
> @@ -12,6 +12,7 @@
>  #include "qemu/main-loop.h"
>  #include "sysemu/replay.h"
>  #include "migration/vmstate.h"
> +#include "sysemu/cpu-timers.h"
>=20=20
>  #include "ptimer-test.h"
>=20=20
> @@ -30,8 +31,8 @@ QEMUTimerListGroup main_loop_tlg;
>=20=20
>  int64_t ptimer_test_time_ns;
>=20=20
> -/* Do not artificially limit period - see hw/core/ptimer.c.  */
> -int use_icount =3D 1;
> +/* under qtest_enabled(), will not artificially limit period - see hw/co=
re/ptimer.c. */
> +int use_icount;
>  bool qtest_allowed;
>=20=20
>  void timer_init_full(QEMUTimer *ts,
> diff --git a/tests/test-timed-average.c b/tests/test-timed-average.c
> index e2bcf5fe13..82c92500df 100644
> --- a/tests/test-timed-average.c
> +++ b/tests/test-timed-average.c
> @@ -11,7 +11,7 @@
>   */
>=20=20
>  #include "qemu/osdep.h"
> -
> +#include "sysemu/cpu-timers.h"
>  #include "qemu/timed-average.h"
>=20=20
>  /* This is the clock for QEMU_CLOCK_VIRTUAL */
> diff --git a/util/main-loop.c b/util/main-loop.c
> index f69f055013..4015d58967 100644
> --- a/util/main-loop.c
> +++ b/util/main-loop.c
> @@ -27,7 +27,7 @@
>  #include "qemu/cutils.h"
>  #include "qemu/timer.h"
>  #include "sysemu/qtest.h"
> -#include "sysemu/cpus.h"
> +#include "sysemu/cpu-timers.h"
>  #include "sysemu/replay.h"
>  #include "qemu/main-loop.h"
>  #include "block/aio.h"
> @@ -517,9 +517,13 @@ void main_loop_wait(int nonblocking)
>      mlpoll.state =3D ret < 0 ? MAIN_LOOP_POLL_ERR : MAIN_LOOP_POLL_OK;
>      notifier_list_notify(&main_loop_poll_notifiers, &mlpoll);
>=20=20
> -    /* CPU thread can infinitely wait for event after
> -       missing the warp */
> -    qemu_start_warp_timer();
> +    if (icount_enabled()) {
> +        /*
> +         * CPU thread can infinitely wait for event after
> +         * missing the warp
> +         */
> +        qemu_start_warp_timer();
> +    }
>      qemu_clock_run_all_timers();
>  }
>=20=20
> diff --git a/util/qemu-timer.c b/util/qemu-timer.c
> index f62b4feecd..100a4eba22 100644
> --- a/util/qemu-timer.c
> +++ b/util/qemu-timer.c
> @@ -26,8 +26,10 @@
>  #include "qemu/main-loop.h"
>  #include "qemu/timer.h"
>  #include "qemu/lockable.h"
> +#include "sysemu/cpu-timers.h"
>  #include "sysemu/replay.h"
>  #include "sysemu/cpus.h"
> +#include "sysemu/qtest.h"
>=20=20
>  #ifdef CONFIG_POSIX
>  #include <pthread.h>
> @@ -134,7 +136,7 @@ static void qemu_clock_init(QEMUClockType type, QEMUT=
imerListNotifyCB *notify_cb
>=20=20
>  bool qemu_clock_use_for_deadline(QEMUClockType type)
>  {
> -    return !(use_icount && (type =3D=3D QEMU_CLOCK_VIRTUAL));
> +    return !(icount_enabled() && (type =3D=3D QEMU_CLOCK_VIRTUAL));
>  }
>=20=20
>  void qemu_clock_notify(QEMUClockType type)
> @@ -416,7 +418,7 @@ static bool timer_mod_ns_locked(QEMUTimerList *timer_=
list,
>  static void timerlist_rearm(QEMUTimerList *timer_list)
>  {
>      /* Interrupt execution to force deadline recalculation.  */
> -    if (timer_list->clock->type =3D=3D QEMU_CLOCK_VIRTUAL) {
> +    if (icount_enabled() && timer_list->clock->type =3D=3D QEMU_CLOCK_VI=
RTUAL) {
>          qemu_start_warp_timer();
>      }
>      timerlist_notify(timer_list);
> @@ -633,8 +635,10 @@ int64_t qemu_clock_get_ns(QEMUClockType type)
>          return get_clock();
>      default:
>      case QEMU_CLOCK_VIRTUAL:
> -        if (use_icount) {
> +        if (icount_enabled()) {
>              return cpu_get_icount();
> +        } else if (qtest_enabled()) { /* for qtest_clock_warp */
> +            return qtest_get_virtual_clock();
>          } else {
>              return cpu_get_clock();
>          }

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

