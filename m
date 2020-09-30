Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F22DC4727C
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 17:12:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBD912076B
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 17:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CIvD3czZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBD912076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNfeR-0004s6-QB
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 13:12:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45540)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kNfd6-0003Mi-4B; Wed, 30 Sep 2020 13:11:00 -0400
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:39699)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kNfd1-0000lA-OG; Wed, 30 Sep 2020 13:10:59 -0400
Received: by mail-il1-x142.google.com with SMTP id q1so2479167ilt.6;
 Wed, 30 Sep 2020 10:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=LxorGA+RJxSkR8LDrDhoTR09mRuUxTjcGL5cjrEl0E4=;
 b=CIvD3czZlyuJpurDT7OTayYUlF/7NsWxILX/X2llUbjBTE2W8rQnQK1917EC5RFCF1
 5+jD4239c+khc3WYleUwXV5dJCKkbwHituq+cu9rQhCJZ90DaYQGjgDKFH+I9cMy2m+w
 ocjS43rdT9JRz2ddwMdvDdxtAUzAdloyOBSsX36h3Ud2n1Ypyx0FTGhIGXn3L5/8zuIJ
 Nc51TTXssNhQnNWH0bT7QHrMmw3ZCI9C3i4n9LsZvQhUtHm9IHB321eP4l1TsRlMnn1V
 lJ1MakLg/o6Do0Xqp7/+kAQyQb4QBNTdwYMRD6Bylz6sZE3sCenQ/pHmXlJykTa2X0+b
 5OuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=LxorGA+RJxSkR8LDrDhoTR09mRuUxTjcGL5cjrEl0E4=;
 b=teWkQhTPf9fCX61JRlXpXTb42VJBU3dJBb3tD5UQsfqHtkPjWHLS3qfEuPFZPMD2HF
 Yg3ekfBdbes1sXTanmGEw9eTmNUDHP0mMfBSPRGYfZPM+wsSvynMhr9uJhIdfeFf5yf/
 LOC793FIUSPJyt/bjDQO+JfNOB+cxAXr1Y6YLeuydH6dyw0b/HaY1Yl87WP/obWw7v+v
 3n+ivC6e33BkiR3ilYeAaukXY7kJqjhEoKHDL8YEPiIJzdzgDx3vkZ7s4kznICUX+oYh
 GFsuIkwa8q8GnxR1KSObYwRGuGqAVLZyDW20Pk+wL2K0Crf0bIfJJItdmT3pO2WxhXgP
 7h8w==
X-Gm-Message-State: AOAM533fEPM68QWNrHaJVejRbk/CYGRwvb3IWvT3YZFCAc4bbOhWLhjc
 gbabAtJjySMUPzLSD0R/v32l52KtIrjlFrAQy6w=
X-Google-Smtp-Source: ABdhPJwTJ4FlF72er+xZSOfJie8SzUr/XZYwKASF8VW3E2c45N0I5LFMUr7kJZbFgmohh3dgQe28GIlq68QicQ+7FSM=
X-Received: by 2002:a92:c94a:: with SMTP id i10mr3009298ilq.267.1601485851863; 
 Wed, 30 Sep 2020 10:10:51 -0700 (PDT)
MIME-Version: 1.0
References: <20e41bdc81dbde7f9b3fdc1c768510ea99e8f565.1601214416.git.alistair.francis@wdc.com>
 <9ac03d37-b899-c9ae-fa48-4f30e3c3d82f@amsat.org>
In-Reply-To: <9ac03d37-b899-c9ae-fa48-4f30e3c3d82f@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 30 Sep 2020 09:59:29 -0700
Message-ID: <CAKmqyKMN3SZ3S5kbEZWi5qazN_OqUbxk4q+wd9qkjJdZFmp_3Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] riscv: Convert interrupt logs to use
 qemu_log_mask()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::142;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x142.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Sep 27, 2020 at 9:22 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> On 9/27/20 3:47 PM, Alistair Francis wrote:
> > Currently we log interrupts and exceptions using the trace backed in
>
> s/backed/backend/
>
> > riscv_cpu_do_interrupt(). We also log execptions using the interrupt lo=
g
>
> Typo "exceptions".
>
> > mask (-d int) in riscv_raise_exception().
> >
> > This PR converts riscv_cpu_do_interrupt() to log both interrupts and
>
> s/PR/patch/

Fixed!

>
> > exceptions with the interrupt log mask, so that both are printed when a
> > user runs QEMU with -d int.
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >  target/riscv/cpu_helper.c | 7 +++++--
> >  target/riscv/op_helper.c  | 1 -
> >  target/riscv/trace-events | 3 ---
> >  3 files changed, 5 insertions(+), 6 deletions(-)
> >
> > diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> > index 904899054d..9df3238213 100644
> > --- a/target/riscv/cpu_helper.c
> > +++ b/target/riscv/cpu_helper.c
> > @@ -894,8 +894,11 @@ void riscv_cpu_do_interrupt(CPUState *cs)
> >          }
> >      }
> >
> > -    trace_riscv_trap(env->mhartid, async, cause, env->pc, tval,
> > -        riscv_cpu_get_trap_name(cause, async));
> > +    qemu_log_mask(CPU_LOG_INT,
> > +                  "%s: hart:"TARGET_FMT_ld", async:%d, cause:"TARGET_F=
MT_lx", "
> > +                  "epc:0x"TARGET_FMT_lx", tval:0x"TARGET_FMT_lx", desc=
=3D%s\n",
> > +                  __func__, env->mhartid, async, cause, env->pc, tval,
> > +                  riscv_cpu_get_trap_name(cause, async));
>
> Maybe you want to keep the trace event, as the trace framework allow you
> to select traced events at runtime, events come with timestamp and for
> some backends the events are machine-parsable.

Good point, I have kept this in.

>
> Regardless:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Thanks!

Alistair

>
> >
> >      if (env->priv <=3D PRV_S &&
> >              cause < TARGET_LONG_BITS && ((deleg >> cause) & 1)) {
> > diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> > index 9b9ada45a9..e987bd262f 100644
> > --- a/target/riscv/op_helper.c
> > +++ b/target/riscv/op_helper.c
> > @@ -29,7 +29,6 @@ void QEMU_NORETURN riscv_raise_exception(CPURISCVStat=
e *env,
> >                                            uint32_t exception, uintptr_=
t pc)
> >  {
> >      CPUState *cs =3D env_cpu(env);
> > -    qemu_log_mask(CPU_LOG_INT, "%s: %d\n", __func__, exception);
> >      cs->exception_index =3D exception;
> >      cpu_loop_exit_restore(cs, pc);
> >  }
> > diff --git a/target/riscv/trace-events b/target/riscv/trace-events
> > index b7e371ee97..6be2147c8f 100644
> > --- a/target/riscv/trace-events
> > +++ b/target/riscv/trace-events
> > @@ -1,6 +1,3 @@
> > -# cpu_helper.c
> > -riscv_trap(uint64_t hartid, bool async, uint64_t cause, uint64_t epc, =
uint64_t tval, const char *desc) "hart:%"PRId64", async:%d, cause:%"PRId64"=
, epc:0x%"PRIx64", tval:0x%"PRIx64", desc=3D%s"
> > -
> >  # pmp.c
> >  pmpcfg_csr_read(uint64_t mhartid, uint32_t reg_index, uint64_t val) "h=
art %" PRIu64 ": read reg%" PRIu32", val: 0x%" PRIx64
> >  pmpcfg_csr_write(uint64_t mhartid, uint32_t reg_index, uint64_t val) "=
hart %" PRIu64 ": write reg%" PRIu32", val: 0x%" PRIx64
> >
>

