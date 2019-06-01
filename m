Return-Path: <SRS0=gcBw=UA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC31C28CC4
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Jun 2019 21:26:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0035527693
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Jun 2019 21:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fV+NCGM8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0035527693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41549 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXBWO-0004KF-3o
	for qemu-devel@archiver.kernel.org; Sat, 01 Jun 2019 17:26:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mrolnik@gmail.com>) id 1hXBV9-0003EZ-HK
	for qemu-devel@nongnu.org; Sat, 01 Jun 2019 17:25:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mrolnik@gmail.com>) id 1hXBJV-0004fv-CX
	for qemu-devel@nongnu.org; Sat, 01 Jun 2019 17:13:19 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:45260)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1hXBJU-0004ei-0l
	for qemu-devel@nongnu.org; Sat, 01 Jun 2019 17:13:17 -0400
Received: by mail-qk1-x742.google.com with SMTP id s22so6669140qkj.12
	for <qemu-devel@nongnu.org>; Sat, 01 Jun 2019 14:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=xCEwyG1H6SjPPPCaR3odTETW7y6CMD02b4EcdL7cIyo=;
	b=fV+NCGM8xWryAe+uRdd0kLfGxav6st6u5NXalTkniBQqIZtZHHUlTjui9Mlv9k2lLp
	Zaw9gr8bOYJwfT2DEPDabnvPZyeal+Wrya7k8aOJ4KPtKfrCFtbfLck5xAwGwvRXuUHs
	dXJcndiuJKDX+nfcrXCVhwyitjmTdGqWr/p71ZpCiDV5ZmuZ+S/I0wbanAvEwEBWpwxP
	q9CCwZYZQ7463GTKpl11U3oTqed81ce6d4kG5T39T3ustzQLWTKIi4DmQYcCc39O8KY9
	eH8W2TycKT9+DqnUaQpk/bXRec7fzGbnysD06AReuI9ky1CQUPBW1D/iqQs9Qc8b1mXg
	Gczw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=xCEwyG1H6SjPPPCaR3odTETW7y6CMD02b4EcdL7cIyo=;
	b=tKgvUs5v2ro4xASrV+5LFa/QC8LLfw4CvlfeHwNilzXpXOdTm4PyfN0ZEJHUaaFmwA
	eFy9vY8gKP0YXyoGwDuz4Tja7mVi1yuFhSWPMcEqB/EN0RNzLMp9STAXtb+EOrw5WxJj
	Pr1qN1vLmg/zBLhMNmu8Hig0K9WtDCluNW6m3b3p+TYE5LSJilRHqVy4P6VKq1/B76Fu
	KblXFdm0rT397uhZZArRvuu7x7ER6fr3olNL53nsx0gEisFlFt08pb3qjkNV3D2A3SrV
	8m1mTqHIts08AYJB3fRvEOBrYfgZKHFszLmOPPH4fVDaE3R8LkWpm0Z+qmyrwOz97GPn
	cbFw==
X-Gm-Message-State: APjAAAXAFdRFgbsLSjTpQAvlAoQL2dLSwhKAxBnoysvbHh9QNC82Iojd
	TfHk3xViAMycNDSGl/n5xzIO+69ln2p1K80TPwM=
X-Google-Smtp-Source: APXvYqwPtPCoNX3PWSqI782CzFDvfYFM+lt+RY7zv7oxS65EzEg4Ph53xzlgdW8zy3u3okkmCMFD3zclssD7WILZsiU=
X-Received: by 2002:a37:4152:: with SMTP id o79mr15180184qka.276.1559423594412;
	Sat, 01 Jun 2019 14:13:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190530190738.22713-1-mrolnik@gmail.com>
	<20190530190738.22713-4-mrolnik@gmail.com>
	<402ba0b2-e2e0-6b7a-1862-4588e5f83357@linaro.org>
In-Reply-To: <402ba0b2-e2e0-6b7a-1862-4588e5f83357@linaro.org>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Sun, 2 Jun 2019 00:12:38 +0300
Message-ID: <CAK4993iXV9oRr_VfabJHg4fCYEppW49i_PE9R0X_TBqk7TDkrQ@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::742
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH RFC v20 3/8] target/avr: Add mechanism to
 check for active debugger connection
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Richard.

If I implement it this way

```
 static bool trans_BREAK(DisasContext *ctx, arg_BREAK *a)
 {
     if (avr_feature(ctx->env, AVR_FEATURE_BREAK) == false) {
         gen_helper_unsupported(cpu_env);
     } else {
         tcg_gen_movi_tl(cpu_pc, ctx->inst[0].npc);
         gen_helper_debug(cpu_env);
     }

     ctx->bstate = BS_EXCP;

     return true;
 }
```

qemu (without -s -S flags) crashes when debugger is not connected @
gdb_set_stop_cpu, after having fixed it as follows it stops right after the
BREAK and does not advance, however when gdb is connected it works fine.
```
 void gdb_set_stop_cpu(CPUState *cpu)
 {






*     GDBProcess *p;     if (!gdbserver_state) {         return;     }
 p = gdb_get_cpu_process(gdbserver_state, cpu);*

     if (!p->attached) {
         /*
          * Having a stop CPU corresponding to a process that is not
attached
          * confuses GDB. So we ignore the request.
          */
         return;
     }

     gdbserver_state->c_cpu = cpu;
     gdbserver_state->g_cpu = cpu;
 }
```



On Fri, May 31, 2019 at 4:54 PM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 5/30/19 2:07 PM, Michael Rolnik wrote:
> > From: Sarah Harris <S.E.Harris@kent.ac.uk>
> >
> > AVR CPUs have a BREAK instruction which behaves differently depending on
> whether debugging is enabled.
> > Since the hardware fuses that normally control this are difficult to
> emulate, and the BREAK instruction is useful for testing, the BREAK
> instruction is instead enabled/disabled depending on whether a GDB session
> is attached.
>
> I don't think that this is the right way to model this.
>
> I think that BREAK should always raise an exception and return to the main
> loop.  If there we find that the debugger is not attached, the main loop
> will
> simply continue.  Which becomes a nop, as documented.
>
>
> r~
>


-- 
Best Regards,
Michael Rolnik
