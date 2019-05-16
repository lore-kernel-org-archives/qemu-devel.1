Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6784FC04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 16:32:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 331BF2082E
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 16:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rfXrz+F8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 331BF2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60825 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRJJI-0002iM-Ds
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 12:32:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hRJHm-0001ms-R3
	for qemu-devel@nongnu.org; Thu, 16 May 2019 12:31:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hRJHl-0002sV-Pg
	for qemu-devel@nongnu.org; Thu, 16 May 2019 12:31:14 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39738)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hRJHl-0002pQ-Hk
	for qemu-devel@nongnu.org; Thu, 16 May 2019 12:31:13 -0400
Received: by mail-wm1-x343.google.com with SMTP id n25so3747455wmk.4
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 09:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=87l+4sPqAWK7bomSCB5mtlGmIUFpehR+N/kma7vM1vw=;
	b=rfXrz+F8ssg0HFWD84p2AxhQxL6yKHhx1g3K+/x/qmJKOXkOeCWU4v0UsBqdUy7I0H
	C4+A6Y/KhQvhjrspZyW7f30psSgTqXkMp/AStKYVlc74sfBrfnhlNdg8mFYj49WRIeRB
	14J1BZSaCfhLi/1rxzgj3oz3Evsxt8caD/We/YXcXmduxiOWdP3Qh2t3GDzMratx2MWC
	iCqvAmajIveKC4rjMOkBKPpCmZOjkkSVypJDpa3TaXfrkoPuFATzF5ufk/p2e6mvrWlJ
	BuUNV4TRHAqEjSfFTIxx958ESlX1jkfa1s6lMHVBbfKV3Goc7i6TWd3qJJ0lHAMe1cW8
	m0dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=87l+4sPqAWK7bomSCB5mtlGmIUFpehR+N/kma7vM1vw=;
	b=RQHzoVltsiAhM4b9JtrTxqvQEQGnZ022/8FVt2B8R/AD+5G434l5nSTXdwTxZypDIl
	oaw59hXtN2Z2tsjXFp2jdjXCLw6H6Ay1DsnsgWE4SAzeVKuxIA27LLsEWY7hGhOpou38
	pyyQwWU4sisjVHgx15tgT08KPwrJ3KIBCyD0fcklgMvnWJopAnbJ0DlT6npzv9hU3kcP
	yVLWy/8+PxpXq/1ZJgC+mR2EYr1Uur+aGjKh4mpk4zB7ynYj0phtHXjTpL3I8Y1htBIX
	XIts1ztMeja2GpUUGK8lgnUkUSo8d6oU3HL15Xf/LDlWm4EDApUy6KjugXhqPAAAPp/E
	dhgg==
X-Gm-Message-State: APjAAAUQ1XtmaP6yr4MPK6BkjTx2oVy5mfLAAe1IWErvEkkhCPL4/7lH
	riLkqnW0gOM3Ye8NggF3X1+cvA==
X-Google-Smtp-Source: APXvYqx14zI3TxIkI3Rw4hOJjALoSRLlU7a+NQTrsQbrmUDo8NPW//HqJgc4WsPPJRAGZJui2s7+Dg==
X-Received: by 2002:a1c:a695:: with SMTP id
	p143mr28815160wme.128.1558024271654; 
	Thu, 16 May 2019 09:31:11 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	h11sm7371940wrr.44.2019.05.16.09.31.10
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 16 May 2019 09:31:10 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 7754E1FF87;
	Thu, 16 May 2019 17:31:10 +0100 (BST)
References: <ad91b397f360b2fc7f4087e476f7df5b04d42ddb.1558021877.git.alistair.francis@wdc.com>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Alistair Francis <alistair.francis@wdc.com>
In-reply-to: <ad91b397f360b2fc7f4087e476f7df5b04d42ddb.1558021877.git.alistair.francis@wdc.com>
Date: Thu, 16 May 2019 17:31:10 +0100
Message-ID: <87zhnml5td.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: Re: [Qemu-devel] [PATCH v3 1/1] target/arm: Fix vector operation
 segfault
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
	qemu-devel@nongnu.org, qemu-arm@nongnu.org, alistair23@gmail.com,
	philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Alistair Francis <alistair.francis@wdc.com> writes:

> Commit 89e68b575 "target/arm: Use vector operations for saturation"
> causes this abort() when booting QEMU ARM with a Cortex-A15:
>
> 0  0x00007ffff4c2382f in raise () at /usr/lib/libc.so.6
> 1  0x00007ffff4c0e672 in abort () at /usr/lib/libc.so.6
> 2  0x00005555559c1839 in disas_neon_data_insn (insn=3D<optimized out>, s=
=3D<optimized out>) at ./target/arm/translate.c:6673
> 3  0x00005555559c1839 in disas_neon_data_insn (s=3D<optimized out>, insn=
=3D<optimized out>) at ./target/arm/translate.c:6386
> 4  0x00005555559cd8a4 in disas_arm_insn (insn=3D4081107068, s=3D0x7fffe59=
a9510) at ./target/arm/translate.c:9289
> 5  0x00005555559cd8a4 in arm_tr_translate_insn (dcbase=3D0x7fffe59a9510, =
cpu=3D<optimized out>) at ./target/arm/translate.c:13612
> 6  0x00005555558d1d39 in translator_loop (ops=3D0x5555561cc580 <arm_trans=
lator_ops>, db=3D0x7fffe59a9510, cpu=3D0x55555686a2f0, tb=3D<optimized out>=
, max_insns=3D<optimized out>) at ./accel/tcg/translator.c:96
> 7  0x00005555559d10d4 in gen_intermediate_code (cpu=3Dcpu@entry=3D0x55555=
686a2f0, tb=3Dtb@entry=3D0x7fffd7840080 <code_gen_buffer+126091347>, max_in=
sns=3Dmax_insns@entry=3D512) at ./target/arm/translate.c:13901
> 8  0x00005555558d06b9 in tb_gen_code (cpu=3Dcpu@entry=3D0x55555686a2f0, p=
c=3D3067096216, cs_base=3D0, flags=3D192, cflags=3D-16252928, cflags@entry=
=3D524288) at ./accel/tcg/translate-all.c:1736
> 9  0x00005555558ce467 in tb_find (cf_mask=3D524288, tb_exit=3D1, last_tb=
=3D0x7fffd783e640 <code_gen_buffer+126084627>, cpu=3D0x1) at ./accel/tcg/cp=
u-exec.c:407
> 10 0x00005555558ce467 in cpu_exec (cpu=3Dcpu@entry=3D0x55555686a2f0) at .=
/accel/tcg/cpu-exec.c:728
> 11 0x000055555588b0cf in tcg_cpu_exec (cpu=3D0x55555686a2f0) at ./cpus.c:=
1431
> 12 0x000055555588d223 in qemu_tcg_cpu_thread_fn (arg=3D0x55555686a2f0) at=
 ./cpus.c:1735
> 13 0x000055555588d223 in qemu_tcg_cpu_thread_fn (arg=3Darg@entry=3D0x5555=
5686a2f0) at ./cpus.c:1709
> 14 0x0000555555d2629a in qemu_thread_start (args=3D<optimized out>) at ./=
util/qemu-thread-posix.c:502
> 15 0x00007ffff4db8a92 in start_thread () at /usr/lib/libpthread.
>
> This patch ensures that we don't hit the abort() in the second switch
> case in disas_neon_data_insn() as we will return from the first case.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
> v3:
>  - Resend with hopefully 8bit encoding instead of base64

Applies nicely thanks ;-)

--
Alex Benn=C3=A9e

