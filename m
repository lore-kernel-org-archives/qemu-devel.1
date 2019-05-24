Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 823B0C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 11:27:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D158217F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 11:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zso0Cjmp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D158217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52708 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hU8Lp-0006Jc-CU
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 07:27:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hU8KF-000517-4N
	for qemu-devel@nongnu.org; Fri, 24 May 2019 07:25:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hU8KD-0000gn-VA
	for qemu-devel@nongnu.org; Fri, 24 May 2019 07:25:27 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39767)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hU8KD-0000UA-Oa
	for qemu-devel@nongnu.org; Fri, 24 May 2019 07:25:25 -0400
Received: by mail-wm1-x344.google.com with SMTP id z23so4768197wma.4
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 04:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=HJ1VHf/UNGVxyXdIqsX7k+x2fUOq6fkyiRjRqRysIr0=;
	b=Zso0CjmpwNvgow6zuZnv0FlPqqIQNOO2TWABclCQaVeaNXDo7q/NfIy4qOdqBVzxzk
	I723ydXtxz6nNn8dB5GiomBEXHj2iRQrM3ClenwraOU+1x0zRjFaqOpIM7TJnJDsHVZG
	Ml5h/AXL5NfugNOZLM0ZvQL/uWwnTPi3uN5SGdusqXH+/s83stJWcO+ME9rpCLy2WPPT
	qOfnz5hsgaDBm83dtMthEy8yYouS1EJbG2EejkDF2x25rt/E+UNKNTLAE1PKQhl+yyM6
	c+NGwTMF2pdvQ/W8UP7LGuNNl+NA/V0L5QLZFFhv+R+zIZoTfxLpCGL5mE6rVtdDVr/0
	EgVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=HJ1VHf/UNGVxyXdIqsX7k+x2fUOq6fkyiRjRqRysIr0=;
	b=eeidVRfRWg6XqszaPRLRY7QuU0IBNcKEqM0n037Gun9GYgDakX2HOQ63umCtJeEfDP
	XK6pJDJJzVNxYvp2Jd8aWPIQ31mjcLAvcnb8tPj+YCFk2cb43N1aiUOTj19UzqJyxNOn
	mHK4VwzVa/o8RlWAou6S/umuwO+Uica9CSZWQydX3MnqlKdC8uUu2MgUhpR5DJd+iHNJ
	FbCBQyBaiNRr6lYakN6iAvNBc7gFaoBIU4IJ26D5WteDkj4Lgv64UYh5djK0l7Ybu7UO
	360eOiVe1PsPV00AmDmeyr4+9VA4N4ftyl7bgUFnhT+Bug4H83Qy32fbiDC5hoWtGJoX
	jRHQ==
X-Gm-Message-State: APjAAAUFJykTR83qSf6HY/FIs6/RZ/PaB2j5wppn88v0pK+Cu0FlyGx0
	cmygh+quZptYTclJQAxSgDzGhg==
X-Google-Smtp-Source: APXvYqyWILuimwPBO2MU1Iw4R1gps4yxuCnCZR2Iw57XNwfr9nP1fv3LX0VwiGghal0xA625sGH6dQ==
X-Received: by 2002:a1c:f102:: with SMTP id p2mr14958540wmh.126.1558697124110; 
	Fri, 24 May 2019 04:25:24 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id u2sm5603656wra.82.2019.05.24.04.25.23
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 24 May 2019 04:25:23 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 366551FF87;
	Fri, 24 May 2019 12:25:23 +0100 (BST)
References: <20190523102532.10486-1-alex.bennee@linaro.org>
	<20190523102532.10486-4-alex.bennee@linaro.org>
	<CAFEAcA_+=7VfvZRc__q9L3vuHO6YgetrjTPAYJx4eo0mAdcPXg@mail.gmail.com>
	<877eag165o.fsf@zen.linaroharston>
	<CAFEAcA_Fu3Ep10NooU5-XcAqQVjJQE5o1L2JTdYTatjcOptPUg@mail.gmail.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
In-reply-to: <CAFEAcA_Fu3Ep10NooU5-XcAqQVjJQE5o1L2JTdYTatjcOptPUg@mail.gmail.com>
Date: Fri, 24 May 2019 12:25:23 +0100
Message-ID: <875zq014d8.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [PATCH v2 03/28] semihosting: implement a
 semihosting console
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 24 May 2019 at 11:46, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>> > On Thu, 23 May 2019 at 11:39, Alex Benn=C3=A9e <alex.bennee@linaro.org=
> wrote:
>> > I'm not sure about the "no callback" part of this API. The operation
>> > here is genuinely asynchronous and providing no mechanism for the
>> > caller to be able to say "ok, now wait til it completes" doesn't
>> > seem like a good plan.
>>
>> Well the caller doesn't really get a choice. At least in system mode
>> gdbstub does a vm_stop(RUN_STATE_DEBUG) and brings everything to a halt
>> anyway. All we've removed is the ability to tack on a callback (which
>> can get run in all sorts of contexts) when we restart.
>
> gdb_do_syscall() is asynchronous -- it arranges for the syscall
> to happen, but makes no guarantee about when it will finish.
> At the moment the gdb_do_syscall() API allows the caller
> to cope with this asynchronousness, because when the callback
> is called the syscall has definitely finished. As it happens
> the callers are buggy in that they don't actually do the
> sync that they need to do, but we could fix that bug (ie post
> a semaphore in the callback function, and wait on it after
> the gdb_do_syscall() call). The API for this new function
> doesn't allow us to do that.

So for the ARM semi side the console writes are treated as always
successful so the return value is correct (it doesn't matter for writec)
and no syncing to the guest is required. However I ran into a problem
because in gdbstub we have:

    /* Is there a GDB syscall waiting to be sent?  */
    if (s->current_syscall_cb) {
        put_packet(s, s->syscall_buf);
        return;
    }

which means it can't accept NULL for the callback. So I've removed the
gdb_console_out and done:

  static void semihosting_cb(CPUState *cs, target_ulong ret, target_ulong e=
rr)
  {
      if (ret =3D=3D (target_ulong) -1) {
          qemu_log("%s: gdb console output failed (%s)", __func__, strerror=
(-err));
      }
  }

  int qemu_semihosting_console_out(CPUArchState *env, target_ulong addr, in=
t len)
  {
      GString *s =3D copy_user_string(env, addr, len);
      int out =3D s->len;

      if (use_gdb_syscalls()) {
          gdb_do_syscall(semihosting_cb, "write,2,%x,%x", addr, s->len);
      } else {
          out =3D qemu_semihosting_log_out(s->str, s->len);
      }

      g_string_free(s, true);
      return out;
  }

for now.

>> I could just drop the API here and allow the semihosting API to call
>> gdb_do_syscallv directly?
>
> I think we should either make the implementation of the function
> properly synchronous (ie do the post-semaphore-in-callback,
> wait-on-it-after-gdb_do_syscallv thing in the implementation,
> or have an API that lets callers do it.
>
> Perhaps we should just make gdb_do_syscall really be
> synchronous (ie have it do the semaphore stuff)? We
> only actually use it in semihosting, and I think all
> those cases require that the operation completes before
> we can resume execution of the guest CPU. So doing the
> synchronization in one place in the gdb code would be
> simpler than doing it separately in all the callers...

Maybe.. this seems like a bigger clean-up to do that properly. Maybe
that would be worth tackling after the gdbstub refactor stuff goes in?

--
Alex Benn=C3=A9e

