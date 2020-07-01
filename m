Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEBB9C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 20:36:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D69320760
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 20:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R1KN1LQ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D69320760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqjSn-0004NR-Og
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 16:36:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47868)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jqjRw-0003fY-6U
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 16:35:20 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:37972)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jqjRt-0002OW-Jh
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 16:35:19 -0400
Received: by mail-oi1-x241.google.com with SMTP id r8so21748518oij.5
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 13:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=y3cGLXL+oLjgwDn0qa1trwMqOTe9T9HabjmNfVDkYxY=;
 b=R1KN1LQ7K81NccCyQSFwnG8nKNgiWST4BrkCE21nmqr3exQ9dB+k7dqS06k0k+FBld
 BeOR6s6YdGfGKWIZqMpCWbA+sUewaFpaFbciZ7+ssWs/jiOxTw76vt5BOlmOWZqkJ67W
 ecJyPTB4Gj2fnTuXazIMyVHQ6nepFpdWFwsScrN2e/0LptGAelTJH8k8H9MghZ+dMxgF
 g7OYmsa63mfH66l1KbpLXnhj7/1UzI4YQ59KHp0F2vHhB74GaVDSt9yIdVODTSvwv5wx
 GiGFcAViGfwd2qD1WNTJNBz8b7msJeLY7KnADYzbHkNPEYtS4T6t68PBzknoUUSM/R3E
 fa2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=y3cGLXL+oLjgwDn0qa1trwMqOTe9T9HabjmNfVDkYxY=;
 b=PqsNJpOMygAIs+o8iYeXorjXI/5otFYkpLyXYdhGdO2JWPq+NYpebX4uFkf0u6jipU
 sYrdHGFUuG+Xv9WvSpDP8w/I8YjK/emcsfX7z+FLZ00+P7F2bGKHUWFmpVDzt9wFKn6W
 qujoEf2t5L4zNZXesTfYNhu0K5kjolKKAo3sUJVC5A830OUaYijU/wTCUYXafoXGejTt
 23XRqmW0UXD/yocqpHP1qY6uvmlXlzGe+oQiYFUV/a2olQI7nNUZWuxI3hQ9IowUKKg5
 BEhwbPeXxLk/M7YxjJlKnHcRJ2s5Yk8Lsn8HDM/18ETOeHiY29Z2SvqKoc443pnNRCq3
 zA0A==
X-Gm-Message-State: AOAM5332gzDWKb+jUHaYI7TTm8CqZyv36QuSN6eDCZuzJz3/ArE5IamI
 dgT3+s0iW6k0kIgenRkBmCPI0oyWF+RpdeBhnZCrng==
X-Google-Smtp-Source: ABdhPJzcyRWl2qed5Id9yUGEsyjF66UoDTyXkb48ygI1grlFQoidIroGQtKrx08maSf/PJvOlnr3QKjEZ6emcDSC0LI=
X-Received: by 2002:aca:2819:: with SMTP id 25mr15392872oix.48.1593635715971; 
 Wed, 01 Jul 2020 13:35:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200701182100.26930-1-philmd@redhat.com>
In-Reply-To: <20200701182100.26930-1-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 1 Jul 2020 21:35:04 +0100
Message-ID: <CAFEAcA8ZKEVySwDAQ+x9xA9bosOs5q20CZLZjBvkXj_d6ZVBuA@mail.gmail.com>
Subject: Re: [RFC PATCH] cpus: Initialize current_cpu with the first vCPU
 created
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Bug 1878645 <1878645@bugs.launchpad.net>,
 QEMU Developers <qemu-devel@nongnu.org>, Alexander Bulekov <alxndr@bu.edu>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 1 Jul 2020 at 19:21, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
>
> We can run I/O access with the 'i' or 'o' HMP commands in the
> monitor. These commands are expected to run on a vCPU. The
> monitor is not a vCPU thread. To avoid crashing, initialize
> the 'current_cpu' variable with the first vCPU created. The
> command executed on the monitor will end using it.

>
> RFC because I believe the correct fix is to NOT use current_cpu
> out of cpus.c, at least use qemu_get_cpu(0) to get the first vCPU.

Yes, I agree -- I don't think this is the correct fix.
current_cpu is documented as "only valid inside cpu_exec()",
ie if you're actually on a vcpu thread you can use it, but if
you're not on a CPU thread, like the monitor, you need to
say which vCPU you want to affect. For the monitor, that
would be the current "default cpu" as set by the "cpu"
command (cf monitor_set_cpu()). The bug here will be that
somewhere along the line we are probably missing plumbing
sufficient to pass down "which CPU do we want".

https://bugs.launchpad.net/qemu/+bug/1602247 is a bug of
a similar nature -- if the gdbstub does a memory access
we know which CPU we're trying to do that memory access as,
but it doesn't get plumbed through and so in the Arm GIC
register read/write function that looks at current_cpu
we get a segfault.

One way to fix this would be to do something akin to how
real hardware works -- encode into the MemTxAttrs an
indication of what the transaction master was (eg the
CPU number for CPUs); then the handful of devices that
care about which CPU was doing the transaction can use
that, rather than directly looking at current_cpu, and
when gdbstub or monitor perform an access that should
act like it's from a particular CPU they can indicate
that by supplying appropriate transaction attributes.
That would potentially be quite a bit of work though
(but I think it would be a neat design if we want to
try to fix this kind of "segfault if the user prods
a device via the monitor" bug).

+    if (!current_cpu) {
+        current_cpu =3D cpu;
+    }

Some more specific issues with this -- current_cpu is
a thread-local variable, so this will set that for
whatever thread happens to make this call, which
might or might not be the one that ends up handling
the monitor command. Also some code assumes that
current_cpu is non-NULL only if this is a vCPU thread,
eg sigbus_handler().

thanks
-- PMM

