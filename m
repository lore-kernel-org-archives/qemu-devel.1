Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 261F5C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 22:59:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5E0820658
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 22:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u/BDTqUV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5E0820658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHbTF-0006jq-Q5
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 18:59:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42082)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jHbSF-00067O-NG
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 18:58:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jHbSC-0007mA-S4
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 18:58:27 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53962)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jHbSC-0007lI-Fl
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 18:58:24 -0400
Received: by mail-wm1-x343.google.com with SMTP id b12so9380228wmj.3
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 15:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Z7KY2GoEi4fosmVAWzMIKZfvFOuyjVZ4gZhMALQODw4=;
 b=u/BDTqUVCo7D+rUFjLet8pHhHQWEvYYapsPnyf28ek+Mm4lpaC+kAT5MaiC5TCuply
 m0j//XdMRnNTuz/8O58JTh9/dprn7Z7NLtV43xr97tL95ldmHgzBJTw4q4YIeQqf0Tvj
 RClRBIw6UEzmZMXsVu8P/k0cH0H3/ZVxz4Y0xA6U3Pp+Cj+HKe14y4RwengD/Fm74akT
 QU7uoIPW0iRdyhtoCdZlD3H9F6ABmpRs5N7NV+87WGuuBj2/fE7otNYbBTit/BekfBE1
 XY+mUBORKMCUDvmElbIhDQrBnjD0waYj7dvUb6h7Q7CH6tarHl2ju2CFrECg1AcwkR/T
 US1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Z7KY2GoEi4fosmVAWzMIKZfvFOuyjVZ4gZhMALQODw4=;
 b=ihRiEytN2rg9eAsnYv/5vhAkCZcZgNb4frIwA0dYWD4RpAjo2M7bTcYh/5LnQ+LJvh
 NFM7GaCwcU2Dgz91+yF1oZcSvGjCZs4c6p4J+Inoy1xTCEi8SHrInFimIk6cDdEFX2oz
 E8TnylHfcK2bNTwamltTHUwOLpvdOjvuo84GWMoGMjtHYDMw6n1zLh3rw6KsTb3fBlYP
 0sGlOH/sYzQVxFavB3lwuTM3PUSSM3fpr73Tb3RlaSkGM1wh9OMkQyx79i8RImOlRapD
 oFB9LESsTt037+Erv9LZ2MDWMu0w8o4LzQoDePfUSXeWp2DW/wD/SOppXzOTMTM5n27/
 0nig==
X-Gm-Message-State: ANhLgQ2jAYutQHK5udxzSPF7buAURMtQxSeYglB60dIAcNaKF+d/qRNG
 wsrKervzc/freR+kWBhU3JspMEacWMcJxLcbqFc=
X-Google-Smtp-Source: ADFU+vsamnlVs8XNKPDgdWeR6X3cAaVFt5YjexGRUl9UpsxR2UDWD9e50fzDlhc63tUvloIWIPXobQCH/UUMKL7TQH4=
X-Received: by 2002:adf:ba48:: with SMTP id t8mr11628710wrg.329.1585263503088; 
 Thu, 26 Mar 2020 15:58:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200326193156.4322-1-robert.foley@linaro.org>
In-Reply-To: <20200326193156.4322-1-robert.foley@linaro.org>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Fri, 27 Mar 2020 00:58:08 +0200
Message-ID: <CAHiYmc476rMd71t5ZSdz-pgVZ-i_3RBY=U3bO0aYEOOt5P3V_w@mail.gmail.com>
Subject: Re: [PATCH v8 00/74] per-CPU locks
To: Robert Foley <robert.foley@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000fa1eb205a1c9eb3b"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: alex.bennee@linaro.org, Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000fa1eb205a1c9eb3b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

21:37 =C4=8Cet, 26.03.2020. Robert Foley <robert.foley@linaro.org> =D1=98=
=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> V7: https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg00786.html
>
> This is a continuation of the series created by Emilio Cota.
> We are picking up this patch set with the goal to apply
> any fixes or updates needed to get this accepted.
>

Thank for this work, Robert.

However, I just hope you don't intend to request integrating the series in
5.0. The right timing for such wide-influencing patch is at the begining of
dev cycle, not really at the end of (5.0) cycle, IMHO.

Yours,
Aleksandar

> Quoting an earlier patch in the series:
> "For context, the goal of this series is to substitute the BQL for the
> per-CPU locks in many places, notably the execution loop in cpus.c.
> This leads to better scalability for MTTCG, since CPUs don't have
> to acquire a contended global lock (the BQL) every time they
> stop executing code.
> See the last commit for some performance numbers."
>
> Listed below are the changes for this version of the patch,
> aside from the merge related changes.
>
> Changes for V8:
> - Fixed issue where in rr mode we could destroy the BQL twice.
>   Added new function cpu_mutex_destroy().
> - Removed g_assert(qemu_mutex_iothread_locked())
>   from qemu_tcg_rr_all_cpu_threads_idle().  There is an existing
>   case where we call qemu_tcg_rr_all_cpu_threads_idle() without
>   the BQL held, so we cannot assert on the lock here.
> - Found/fixed bug that had been hit in testing previously during
>   the last consideration of this patch.
>   We reproduced the issue hit in the qtest: bios-tables-test.
>   The issue was introduced by dropping the BQL, and found us
>   (very rarely) missing the condition variable wakeup in
>   qemu_tcg_rr_cpu_thread_fn().
> - ppc: convert to cpu_halted
>   - Converted new code for cpu_halted and cpu_halted_set.
> - hw/semihosting: convert to cpu_halted_set
>   -  Added this patch as this code was new and needed converting.
> - ppc/translate_init.inc.c
>   - Translated some new code here to use cpu_has_work_with_iothread_lock.
> - ppc/sapr_hcall.c Translated new code to cpu_halted
> - i386/hax-all.c - converted new code to cpu_interrupt_request and
cpu_halted
> - mips/kvm.c - converted new code to cpu_halted
> - Some changes were related to files that moved, cpu.c and cpu.h
>   moved to hw/core/, and some changes needed to be put
>   there manually during the merge.
>
> Emilio G. Cota (69):
>   cpu: convert queued work to a QSIMPLEQ
>   cpu: rename cpu->work_mutex to cpu->lock
>   cpu: introduce cpu_mutex_lock/unlock
>   cpu: make qemu_work_cond per-cpu
>   cpu: move run_on_cpu to cpus-common
>   cpu: introduce process_queued_cpu_work_locked
>   cpu: make per-CPU locks an alias of the BQL in TCG rr mode
>   tcg-runtime: define helper_cpu_halted_set
>   ppc: convert to helper_cpu_halted_set
>   cris: convert to helper_cpu_halted_set
>   hppa: convert to helper_cpu_halted_set
>   m68k: convert to helper_cpu_halted_set
>   alpha: convert to helper_cpu_halted_set
>   microblaze: convert to helper_cpu_halted_set
>   cpu: define cpu_halted helpers
>   tcg-runtime: convert to cpu_halted_set
>   arm: convert to cpu_halted
>   ppc: convert to cpu_halted
>   sh4: convert to cpu_halted
>   i386: convert to cpu_halted
>   lm32: convert to cpu_halted
>   m68k: convert to cpu_halted
>   mips: convert to cpu_halted
>   riscv: convert to cpu_halted
>   s390x: convert to cpu_halted
>   sparc: convert to cpu_halted
>   xtensa: convert to cpu_halted
>   gdbstub: convert to cpu_halted
>   openrisc: convert to cpu_halted
>   cpu-exec: convert to cpu_halted
>   cpu: convert to cpu_halted
>   cpu: define cpu_interrupt_request helpers
>   exec: use cpu_reset_interrupt
>   arm: convert to cpu_interrupt_request
>   i386: convert to cpu_interrupt_request
>   i386/kvm: convert to cpu_interrupt_request
>   i386/hax-all: convert to cpu_interrupt_request
>   i386/whpx-all: convert to cpu_interrupt_request
>   i386/hvf: convert to cpu_request_interrupt
>   ppc: convert to cpu_interrupt_request
>   sh4: convert to cpu_interrupt_request
>   cris: convert to cpu_interrupt_request
>   hppa: convert to cpu_interrupt_request
>   lm32: convert to cpu_interrupt_request
>   m68k: convert to cpu_interrupt_request
>   mips: convert to cpu_interrupt_request
>   nios: convert to cpu_interrupt_request
>   s390x: convert to cpu_interrupt_request
>   alpha: convert to cpu_interrupt_request
>   moxie: convert to cpu_interrupt_request
>   sparc: convert to cpu_interrupt_request
>   openrisc: convert to cpu_interrupt_request
>   unicore32: convert to cpu_interrupt_request
>   microblaze: convert to cpu_interrupt_request
>   accel/tcg: convert to cpu_interrupt_request
>   cpu: convert to interrupt_request
>   cpu: call .cpu_has_work with the CPU lock held
>   cpu: introduce cpu_has_work_with_iothread_lock
>   ppc: convert to cpu_has_work_with_iothread_lock
>   mips: convert to cpu_has_work_with_iothread_lock
>   s390x: convert to cpu_has_work_with_iothread_lock
>   riscv: convert to cpu_has_work_with_iothread_lock
>   sparc: convert to cpu_has_work_with_iothread_lock
>   xtensa: convert to cpu_has_work_with_iothread_lock
>   cpu: rename all_cpu_threads_idle to qemu_tcg_rr_all_cpu_threads_idle
>   cpu: protect CPU state with cpu->lock instead of the BQL
>   cpus-common: release BQL earlier in run_on_cpu
>   cpu: add async_run_on_cpu_no_bql
>   cputlb: queue async flush jobs without the BQL
>
> Paolo Bonzini (4):
>   ppc: use cpu_reset_interrupt
>   i386: use cpu_reset_interrupt
>   s390x: use cpu_reset_interrupt
>   openrisc: use cpu_reset_interrupt
>
> Robert Foley (1):
>   hw/semihosting: convert to cpu_halted_set
>
>  accel/tcg/cpu-exec.c            |  40 ++-
>  accel/tcg/cputlb.c              |  10 +-
>  accel/tcg/tcg-all.c             |  12 +-
>  accel/tcg/tcg-runtime.c         |   7 +
>  accel/tcg/tcg-runtime.h         |   2 +
>  accel/tcg/translate-all.c       |   2 +-
>  cpus-common.c                   | 129 +++++++---
>  cpus.c                          | 438 ++++++++++++++++++++++++++------
>  exec.c                          |   2 +-
>  gdbstub.c                       |   4 +-
>  hw/arm/omap1.c                  |   4 +-
>  hw/arm/pxa2xx_gpio.c            |   2 +-
>  hw/arm/pxa2xx_pic.c             |   2 +-
>  hw/core/cpu.c                   |  29 +--
>  hw/core/machine-qmp-cmds.c      |   2 +-
>  hw/intc/s390_flic.c             |   4 +-
>  hw/mips/cps.c                   |   2 +-
>  hw/misc/mips_itu.c              |   4 +-
>  hw/openrisc/cputimer.c          |   2 +-
>  hw/ppc/e500.c                   |   4 +-
>  hw/ppc/ppc.c                    |  12 +-
>  hw/ppc/ppce500_spin.c           |   6 +-
>  hw/ppc/spapr_cpu_core.c         |   4 +-
>  hw/ppc/spapr_hcall.c            |  14 +-
>  hw/ppc/spapr_rtas.c             |   8 +-
>  hw/semihosting/console.c        |   4 +-
>  hw/sparc/leon3.c                |   2 +-
>  hw/sparc/sun4m.c                |   8 +-
>  hw/sparc64/sparc64.c            |   8 +-
>  include/hw/core/cpu.h           | 197 ++++++++++++--
>  stubs/Makefile.objs             |   1 +
>  stubs/cpu-lock.c                |  35 +++
>  target/alpha/cpu.c              |   8 +-
>  target/alpha/translate.c        |   6 +-
>  target/arm/arm-powerctl.c       |   6 +-
>  target/arm/cpu.c                |   8 +-
>  target/arm/helper.c             |  16 +-
>  target/arm/machine.c            |   2 +-
>  target/arm/op_helper.c          |   2 +-
>  target/cris/cpu.c               |   2 +-
>  target/cris/helper.c            |   4 +-
>  target/cris/translate.c         |   5 +-
>  target/hppa/cpu.c               |   2 +-
>  target/hppa/translate.c         |   3 +-
>  target/i386/cpu.c               |   4 +-
>  target/i386/cpu.h               |   2 +-
>  target/i386/hax-all.c           |  42 +--
>  target/i386/helper.c            |   8 +-
>  target/i386/hvf/hvf.c           |  12 +-
>  target/i386/hvf/x86hvf.c        |  37 +--
>  target/i386/kvm.c               |  82 +++---
>  target/i386/misc_helper.c       |   2 +-
>  target/i386/seg_helper.c        |  13 +-
>  target/i386/svm_helper.c        |   6 +-
>  target/i386/whpx-all.c          |  57 +++--
>  target/lm32/cpu.c               |   2 +-
>  target/lm32/op_helper.c         |   4 +-
>  target/m68k/cpu.c               |   2 +-
>  target/m68k/op_helper.c         |   2 +-
>  target/m68k/translate.c         |   9 +-
>  target/microblaze/cpu.c         |   2 +-
>  target/microblaze/translate.c   |   4 +-
>  target/mips/cp0_helper.c        |   6 +-
>  target/mips/cpu.c               |  11 +-
>  target/mips/kvm.c               |   4 +-
>  target/mips/op_helper.c         |   2 +-
>  target/mips/translate.c         |   4 +-
>  target/moxie/cpu.c              |   2 +-
>  target/nios2/cpu.c              |   2 +-
>  target/openrisc/cpu.c           |   4 +-
>  target/openrisc/sys_helper.c    |   4 +-
>  target/ppc/excp_helper.c        |   6 +-
>  target/ppc/helper_regs.h        |   2 +-
>  target/ppc/kvm.c                |   6 +-
>  target/ppc/translate.c          |   6 +-
>  target/ppc/translate_init.inc.c |  41 +--
>  target/riscv/cpu.c              |   5 +-
>  target/riscv/op_helper.c        |   2 +-
>  target/s390x/cpu.c              |  28 +-
>  target/s390x/excp_helper.c      |   4 +-
>  target/s390x/kvm.c              |   2 +-
>  target/s390x/sigp.c             |   8 +-
>  target/sh4/cpu.c                |   2 +-
>  target/sh4/helper.c             |   2 +-
>  target/sh4/op_helper.c          |   2 +-
>  target/sparc/cpu.c              |   6 +-
>  target/sparc/helper.c           |   2 +-
>  target/unicore32/cpu.c          |   2 +-
>  target/unicore32/softmmu.c      |   2 +-
>  target/xtensa/cpu.c             |   6 +-
>  target/xtensa/exc_helper.c      |   2 +-
>  target/xtensa/helper.c          |   2 +-
>  92 files changed, 1067 insertions(+), 464 deletions(-)
>  create mode 100644 stubs/cpu-lock.c
>
> --
> 2.17.1
>
>

--000000000000fa1eb205a1c9eb3b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">21:37 =C4=8Cet, 26.03.2020. Robert Foley &lt;<a href=3D"mail=
to:robert.foley@linaro.org">robert.foley@linaro.org</a>&gt; =D1=98=D0=B5 =
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br>
&gt;<br>
&gt; V7: <a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2019-03/m=
sg00786.html">https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg0078=
6.html</a><br>
&gt;<br>
&gt; This is a continuation of the series created by Emilio Cota.<br>
&gt; We are picking up this patch set with the goal to apply <br>
&gt; any fixes or updates needed to get this accepted.<br>
&gt;</p>
<p dir=3D"ltr">Thank for this work, Robert.</p>
<p dir=3D"ltr">However, I just hope you don&#39;t intend to request integra=
ting the series in 5.0. The right timing for such wide-influencing patch is=
 at the begining of dev cycle, not really at the end of (5.0) cycle, IMHO.<=
/p>
<p dir=3D"ltr">Yours,<br>
Aleksandar<br></p>
<p dir=3D"ltr">&gt; Quoting an earlier patch in the series:<br>
&gt; &quot;For context, the goal of this series is to substitute the BQL fo=
r the<br>
&gt; per-CPU locks in many places, notably the execution loop in cpus.c.<br=
>
&gt; This leads to better scalability for MTTCG, since CPUs don&#39;t have<=
br>
&gt; to acquire a contended global lock (the BQL) every time they<br>
&gt; stop executing code.<br>
&gt; See the last commit for some performance numbers.&quot;<br>
&gt;<br>
&gt; Listed below are the changes for this version of the patch, <br>
&gt; aside from the merge related changes.<br>
&gt;<br>
&gt; Changes for V8:<br>
&gt; - Fixed issue where in rr mode we could destroy the BQL twice.<br>
&gt; =C2=A0 Added new function cpu_mutex_destroy().<br>
&gt; - Removed g_assert(qemu_mutex_iothread_locked())<br>
&gt; =C2=A0 from qemu_tcg_rr_all_cpu_threads_idle().=C2=A0 There is an exis=
ting<br>
&gt; =C2=A0 case where we call qemu_tcg_rr_all_cpu_threads_idle() without<b=
r>
&gt; =C2=A0 the BQL held, so we cannot assert on the lock here.<br>
&gt; - Found/fixed bug that had been hit in testing previously during <br>
&gt; =C2=A0 the last consideration of this patch.<br>
&gt; =C2=A0 We reproduced the issue hit in the qtest: bios-tables-test.<br>
&gt; =C2=A0 The issue was introduced by dropping the BQL, and found us<br>
&gt; =C2=A0 (very rarely) missing the condition variable wakeup in<br>
&gt; =C2=A0 qemu_tcg_rr_cpu_thread_fn().<br>
&gt; - ppc: convert to cpu_halted<br>
&gt; =C2=A0 - Converted new code for cpu_halted and cpu_halted_set.<br>
&gt; - hw/semihosting: convert to cpu_halted_set<br>
&gt; =C2=A0 - =C2=A0Added this patch as this code was new and needed conver=
ting.<br>
&gt; - ppc/translate_init.inc.c<br>
&gt; =C2=A0 - Translated some new code here to use cpu_has_work_with_iothre=
ad_lock.<br>
&gt; - ppc/sapr_hcall.c Translated new code to cpu_halted<br>
&gt; - i386/hax-all.c - converted new code to cpu_interrupt_request and cpu=
_halted<br>
&gt; - mips/kvm.c - converted new code to cpu_halted<br>
&gt; - Some changes were related to files that moved, cpu.c and cpu.h<br>
&gt; =C2=A0 moved to hw/core/, and some changes needed to be put<br>
&gt; =C2=A0 there manually during the merge.<br>
&gt;<br>
&gt; Emilio G. Cota (69):<br>
&gt; =C2=A0 cpu: convert queued work to a QSIMPLEQ<br>
&gt; =C2=A0 cpu: rename cpu-&gt;work_mutex to cpu-&gt;lock<br>
&gt; =C2=A0 cpu: introduce cpu_mutex_lock/unlock<br>
&gt; =C2=A0 cpu: make qemu_work_cond per-cpu<br>
&gt; =C2=A0 cpu: move run_on_cpu to cpus-common<br>
&gt; =C2=A0 cpu: introduce process_queued_cpu_work_locked<br>
&gt; =C2=A0 cpu: make per-CPU locks an alias of the BQL in TCG rr mode<br>
&gt; =C2=A0 tcg-runtime: define helper_cpu_halted_set<br>
&gt; =C2=A0 ppc: convert to helper_cpu_halted_set<br>
&gt; =C2=A0 cris: convert to helper_cpu_halted_set<br>
&gt; =C2=A0 hppa: convert to helper_cpu_halted_set<br>
&gt; =C2=A0 m68k: convert to helper_cpu_halted_set<br>
&gt; =C2=A0 alpha: convert to helper_cpu_halted_set<br>
&gt; =C2=A0 microblaze: convert to helper_cpu_halted_set<br>
&gt; =C2=A0 cpu: define cpu_halted helpers<br>
&gt; =C2=A0 tcg-runtime: convert to cpu_halted_set<br>
&gt; =C2=A0 arm: convert to cpu_halted<br>
&gt; =C2=A0 ppc: convert to cpu_halted<br>
&gt; =C2=A0 sh4: convert to cpu_halted<br>
&gt; =C2=A0 i386: convert to cpu_halted<br>
&gt; =C2=A0 lm32: convert to cpu_halted<br>
&gt; =C2=A0 m68k: convert to cpu_halted<br>
&gt; =C2=A0 mips: convert to cpu_halted<br>
&gt; =C2=A0 riscv: convert to cpu_halted<br>
&gt; =C2=A0 s390x: convert to cpu_halted<br>
&gt; =C2=A0 sparc: convert to cpu_halted<br>
&gt; =C2=A0 xtensa: convert to cpu_halted<br>
&gt; =C2=A0 gdbstub: convert to cpu_halted<br>
&gt; =C2=A0 openrisc: convert to cpu_halted<br>
&gt; =C2=A0 cpu-exec: convert to cpu_halted<br>
&gt; =C2=A0 cpu: convert to cpu_halted<br>
&gt; =C2=A0 cpu: define cpu_interrupt_request helpers<br>
&gt; =C2=A0 exec: use cpu_reset_interrupt<br>
&gt; =C2=A0 arm: convert to cpu_interrupt_request<br>
&gt; =C2=A0 i386: convert to cpu_interrupt_request<br>
&gt; =C2=A0 i386/kvm: convert to cpu_interrupt_request<br>
&gt; =C2=A0 i386/hax-all: convert to cpu_interrupt_request<br>
&gt; =C2=A0 i386/whpx-all: convert to cpu_interrupt_request<br>
&gt; =C2=A0 i386/hvf: convert to cpu_request_interrupt<br>
&gt; =C2=A0 ppc: convert to cpu_interrupt_request<br>
&gt; =C2=A0 sh4: convert to cpu_interrupt_request<br>
&gt; =C2=A0 cris: convert to cpu_interrupt_request<br>
&gt; =C2=A0 hppa: convert to cpu_interrupt_request<br>
&gt; =C2=A0 lm32: convert to cpu_interrupt_request<br>
&gt; =C2=A0 m68k: convert to cpu_interrupt_request<br>
&gt; =C2=A0 mips: convert to cpu_interrupt_request<br>
&gt; =C2=A0 nios: convert to cpu_interrupt_request<br>
&gt; =C2=A0 s390x: convert to cpu_interrupt_request<br>
&gt; =C2=A0 alpha: convert to cpu_interrupt_request<br>
&gt; =C2=A0 moxie: convert to cpu_interrupt_request<br>
&gt; =C2=A0 sparc: convert to cpu_interrupt_request<br>
&gt; =C2=A0 openrisc: convert to cpu_interrupt_request<br>
&gt; =C2=A0 unicore32: convert to cpu_interrupt_request<br>
&gt; =C2=A0 microblaze: convert to cpu_interrupt_request<br>
&gt; =C2=A0 accel/tcg: convert to cpu_interrupt_request<br>
&gt; =C2=A0 cpu: convert to interrupt_request<br>
&gt; =C2=A0 cpu: call .cpu_has_work with the CPU lock held<br>
&gt; =C2=A0 cpu: introduce cpu_has_work_with_iothread_lock<br>
&gt; =C2=A0 ppc: convert to cpu_has_work_with_iothread_lock<br>
&gt; =C2=A0 mips: convert to cpu_has_work_with_iothread_lock<br>
&gt; =C2=A0 s390x: convert to cpu_has_work_with_iothread_lock<br>
&gt; =C2=A0 riscv: convert to cpu_has_work_with_iothread_lock<br>
&gt; =C2=A0 sparc: convert to cpu_has_work_with_iothread_lock<br>
&gt; =C2=A0 xtensa: convert to cpu_has_work_with_iothread_lock<br>
&gt; =C2=A0 cpu: rename all_cpu_threads_idle to qemu_tcg_rr_all_cpu_threads=
_idle<br>
&gt; =C2=A0 cpu: protect CPU state with cpu-&gt;lock instead of the BQL<br>
&gt; =C2=A0 cpus-common: release BQL earlier in run_on_cpu<br>
&gt; =C2=A0 cpu: add async_run_on_cpu_no_bql<br>
&gt; =C2=A0 cputlb: queue async flush jobs without the BQL<br>
&gt;<br>
&gt; Paolo Bonzini (4):<br>
&gt; =C2=A0 ppc: use cpu_reset_interrupt<br>
&gt; =C2=A0 i386: use cpu_reset_interrupt<br>
&gt; =C2=A0 s390x: use cpu_reset_interrupt<br>
&gt; =C2=A0 openrisc: use cpu_reset_interrupt<br>
&gt;<br>
&gt; Robert Foley (1):<br>
&gt; =C2=A0 hw/semihosting: convert to cpu_halted_set<br>
&gt;<br>
&gt; =C2=A0accel/tcg/cpu-exec.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 40 ++-<br>
&gt; =C2=A0accel/tcg/cputlb.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 10 +-<br>
&gt; =C2=A0accel/tcg/tcg-all.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 12 +-<br>
&gt; =C2=A0accel/tcg/tcg-runtime.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0=
 =C2=A07 +<br>
&gt; =C2=A0accel/tcg/tcg-runtime.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0=
 =C2=A02 +<br>
&gt; =C2=A0accel/tcg/translate-all.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=
=A02 +-<br>
&gt; =C2=A0cpus-common.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0| 129 +++++++---<br>
&gt; =C2=A0cpus.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 438 ++++++++++++++++++++++++++------<b=
r>
&gt; =C2=A0exec.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
&gt; =C2=A0gdbstub.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A04 +-<br>
&gt; =C2=A0hw/arm/omap1.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A04 +-<br>
&gt; =C2=A0hw/arm/pxa2xx_gpio.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A02 +-<br>
&gt; =C2=A0hw/arm/pxa2xx_pic.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A02 +-<br>
&gt; =C2=A0hw/core/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 29 +--<br>
&gt; =C2=A0hw/core/machine-qmp-cmds.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +=
-<br>
&gt; =C2=A0hw/intc/s390_flic.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A04 +-<br>
&gt; =C2=A0hw/mips/cps.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
&gt; =C2=A0hw/misc/mips_itu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A04 +-<br>
&gt; =C2=A0hw/openrisc/cputimer.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0=
 =C2=A02 +-<br>
&gt; =C2=A0hw/ppc/e500.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A04 +-<br>
&gt; =C2=A0hw/ppc/ppc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 12 +-<br>
&gt; =C2=A0hw/ppc/ppce500_spin.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A06 +-<br>
&gt; =C2=A0hw/ppc/spapr_cpu_core.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0=
 =C2=A04 +-<br>
&gt; =C2=A0hw/ppc/spapr_hcall.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 14 +-<br>
&gt; =C2=A0hw/ppc/spapr_rtas.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A08 +-<br>
&gt; =C2=A0hw/semihosting/console.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=
=A04 +-<br>
&gt; =C2=A0hw/sparc/leon3.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 |=C2=A0 =C2=A02 +-<br>
&gt; =C2=A0hw/sparc/sun4m.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 |=C2=A0 =C2=A08 +-<br>
&gt; =C2=A0hw/sparc64/sparc64.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A08 +-<br>
&gt; =C2=A0include/hw/core/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =
197 ++++++++++++--<br>
&gt; =C2=A0stubs/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A01 +<br>
&gt; =C2=A0stubs/cpu-lock.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 |=C2=A0 35 +++<br>
&gt; =C2=A0target/alpha/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A08 +-<br>
&gt; =C2=A0target/alpha/translate.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=
=A06 +-<br>
&gt; =C2=A0target/arm/arm-powerctl.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=
=A06 +-<br>
&gt; =C2=A0target/arm/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 |=C2=A0 =C2=A08 +-<br>
&gt; =C2=A0target/arm/helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 16 +-<br>
&gt; =C2=A0target/arm/machine.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A02 +-<br>
&gt; =C2=A0target/arm/op_helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0=
 =C2=A02 +-<br>
&gt; =C2=A0target/cris/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
&gt; =C2=A0target/cris/helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A04 +-<br>
&gt; =C2=A0target/cris/translate.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0=
 =C2=A05 +-<br>
&gt; =C2=A0target/hppa/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
&gt; =C2=A0target/hppa/translate.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0=
 =C2=A03 +-<br>
&gt; =C2=A0target/i386/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A04 +-<br>
&gt; =C2=A0target/i386/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
&gt; =C2=A0target/i386/hax-all.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 42 +--<br>
&gt; =C2=A0target/i386/helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A08 +-<br>
&gt; =C2=A0target/i386/hvf/hvf.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 12 +-<br>
&gt; =C2=A0target/i386/hvf/x86hvf.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 37 +=
--<br>
&gt; =C2=A0target/i386/kvm.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 82 +++---<br>
&gt; =C2=A0target/i386/misc_helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=
=A02 +-<br>
&gt; =C2=A0target/i386/seg_helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 13 +=
-<br>
&gt; =C2=A0target/i386/svm_helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=
=A06 +-<br>
&gt; =C2=A0target/i386/whpx-all.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0=
 57 +++--<br>
&gt; =C2=A0target/lm32/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
&gt; =C2=A0target/lm32/op_helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0=
 =C2=A04 +-<br>
&gt; =C2=A0target/m68k/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
&gt; =C2=A0target/m68k/op_helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0=
 =C2=A02 +-<br>
&gt; =C2=A0target/m68k/translate.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0=
 =C2=A09 +-<br>
&gt; =C2=A0target/microblaze/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0=
 =C2=A02 +-<br>
&gt; =C2=A0target/microblaze/translate.c=C2=A0 =C2=A0|=C2=A0 =C2=A04 +-<br>
&gt; =C2=A0target/mips/cp0_helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=
=A06 +-<br>
&gt; =C2=A0target/mips/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 11 +-<br>
&gt; =C2=A0target/mips/kvm.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A04 +-<br>
&gt; =C2=A0target/mips/op_helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0=
 =C2=A02 +-<br>
&gt; =C2=A0target/mips/translate.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0=
 =C2=A04 +-<br>
&gt; =C2=A0target/moxie/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A02 +-<br>
&gt; =C2=A0target/nios2/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A02 +-<br>
&gt; =C2=A0target/openrisc/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A04 +-<br>
&gt; =C2=A0target/openrisc/sys_helper.c=C2=A0 =C2=A0 |=C2=A0 =C2=A04 +-<br>
&gt; =C2=A0target/ppc/excp_helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=
=A06 +-<br>
&gt; =C2=A0target/ppc/helper_regs.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=
=A02 +-<br>
&gt; =C2=A0target/ppc/kvm.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 |=C2=A0 =C2=A06 +-<br>
&gt; =C2=A0target/ppc/translate.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0=
 =C2=A06 +-<br>
&gt; =C2=A0target/ppc/translate_init.inc.c |=C2=A0 41 +--<br>
&gt; =C2=A0target/riscv/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A05 +-<br>
&gt; =C2=A0target/riscv/op_helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=
=A02 +-<br>
&gt; =C2=A0target/s390x/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 28 +-<br>
&gt; =C2=A0target/s390x/excp_helper.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A04 +=
-<br>
&gt; =C2=A0target/s390x/kvm.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A02 +-<br>
&gt; =C2=A0target/s390x/sigp.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A08 +-<br>
&gt; =C2=A0target/sh4/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 |=C2=A0 =C2=A02 +-<br>
&gt; =C2=A0target/sh4/helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A02 +-<br>
&gt; =C2=A0target/sh4/op_helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0=
 =C2=A02 +-<br>
&gt; =C2=A0target/sparc/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A06 +-<br>
&gt; =C2=A0target/sparc/helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A02 +-<br>
&gt; =C2=A0target/unicore32/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0=
 =C2=A02 +-<br>
&gt; =C2=A0target/unicore32/softmmu.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +=
-<br>
&gt; =C2=A0target/xtensa/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A06 +-<br>
&gt; =C2=A0target/xtensa/exc_helper.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +=
-<br>
&gt; =C2=A0target/xtensa/helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0=
 =C2=A02 +-<br>
&gt; =C2=A092 files changed, 1067 insertions(+), 464 deletions(-)<br>
&gt; =C2=A0create mode 100644 stubs/cpu-lock.c<br>
&gt;<br>
&gt; -- <br>
&gt; 2.17.1<br>
&gt;<br>
&gt;<br>
</p>

--000000000000fa1eb205a1c9eb3b--

