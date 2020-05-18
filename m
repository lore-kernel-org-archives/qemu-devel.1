Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DCB2C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 10:22:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCE2C20657
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 10:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DJLtG0XK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCE2C20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jacv3-0004bX-TO
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 06:22:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59318)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jacuK-0004AJ-QK
 for qemu-devel@nongnu.org; Mon, 18 May 2020 06:22:04 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b]:39545)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jacuJ-0008CK-Da
 for qemu-devel@nongnu.org; Mon, 18 May 2020 06:22:04 -0400
Received: by mail-oi1-x22b.google.com with SMTP id s198so8539815oie.6
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 03:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=aPryGPByiMttvtOCwvZ6iKIXuRXD8el9vgPBtdhRL3k=;
 b=DJLtG0XK5YhhtC6qa3hh5a1JKM3+G2AzRxYUZ/hEqkKNlWS+w3bs7by/CWBKDYkC6i
 wRRLLCPuMSoh0TcrGFFXhDxBHLzrQ7OzvevPFXU2E8zAlULDBmQBJLCXzTRya7Z4nB3k
 CMwymudyki36n72QkMQIMRITU1JXlrT6wxrhs1opsW6tkRTTDnHu8HhV4Efvp1BSau2D
 gU2iXJZdQTdSpKKx5/r+PUlTkoHcFP9RWO2FGuXIuzxcSkkpsbg/voWAbOhiBhhT8tp8
 DMDvNBGNGjGXH90mYEMkZiLBqQ0bkMUl7uBUTeKZqOB56/csZ39ee8iyXElmSQRIzxWS
 zzgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aPryGPByiMttvtOCwvZ6iKIXuRXD8el9vgPBtdhRL3k=;
 b=l01I61tNoIewl6D0GWzH0iUlQc1iy2wzj0YqggY62xgD6YjbfaqeHutr6SnmKCU4pe
 6YhvGCUuYD1PJJDrS89vLq0tA7LM5IURwxHgCYgUpo69XAeswPuE+yzYq8LLfPxjrpYq
 R76U3RUDdvc0rjPl/A/FmPjiDC9Fw6xoJi9y8MGHds/ZfaZ9Y4IPmc1/NRAed8oisx7s
 2lcS19yzw9BSELee8RBpHrnwVcreSkAuzLmcZzzSEGdPEo6m58ITTAt14RR6LPu61Vid
 OhCptEeZC2iDBvPMgQKqaBhjfu9zQMEt7wRN2D5lDAyd68/qAAeQFsaKSdUDxdh34YgW
 gcIw==
X-Gm-Message-State: AOAM530puRIbQSaAGRUrbXXAUnaPRab+NYD7epRyNVXlFQy6UwKeU4i3
 oiy4IkjDiLLHdTS5Cvmv+uBSZKD1cCnD0qFZAYB22w==
X-Google-Smtp-Source: ABdhPJwoGF7+oGdQNH3m2Exhg0gdB7chpenzC7dj7J5RJ1ovt+Q7lH5+f3t6ajR2eEMge2bR+d/dmBRL7rZw/piMqn8=
X-Received: by 2002:aca:eb96:: with SMTP id j144mr9621457oih.48.1589797321914; 
 Mon, 18 May 2020 03:22:01 -0700 (PDT)
MIME-Version: 1.0
References: <9d75f1f6-3440-8dec-9266-4841362844d0@gmail.com>
In-Reply-To: <9d75f1f6-3440-8dec-9266-4841362844d0@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 May 2020 11:21:51 +0100
Message-ID: <CAFEAcA-yTm7h_EGZ4_iKVGJ0GMFinWOyQXyKsYgs8s933Bnn1Q@mail.gmail.com>
Subject: Re: [RFC] Various questions about TCG implementation, DRM patches
 dealing with pointers over guest-host barrier.
To: "Catherine A. Frederick" <agrecascino123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x22b.google.com
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 18 May 2020 at 00:23, Catherine A. Frederick
<agrecascino123@gmail.com> wrote:
> Hi, I've been patching TCG for my own purposes recently and I was
> wondering a few things. That being:
>
> - Is the TCG backend expected to handle bad cases for instructions? I
> was wondering as I found a situation where a very large shift constant
> reaches the backend and causes an illegal instruction to be generated.
> Is the frontend expected to clean this up, or is the backend supposed to
> be able to deal with these? I currently patched the bug via clipping the
> shift constant between 0 and 64.

The semantics of TCG IR ops are described in tcg/README. If the
behaviour described there isn't what the guest requires then
the frontend needs to emit code to handle special cases the way
the guest architecture says they're handled. If a backend doesn't
behave as the IR op spec requires then the backend is buggy. For shifts
in particular (shl/shr/sar/rotl/rotr) the IR op has "unspecified
behaviour" for out of range shift values: this is required to
not crash, but the result value is not specified and could be
anything. (The IR spec uses "undefined behaviour" to mean "could
do anything, including crashing. The reason shifts are made to
be only unspecified-behaviour is that it allows a frontend to
emit code that unconditionally does a shift and then uses movcond
or similar to only use the result in the case where the shift is
in range.)

> - I've been implementing an instruction scheduler(list scheduler, with
> priority given to most successors) for TCG and currently if I replace
> instructions in s->ops(the TCG context) I get a crash later in
> tcg_reg_alloc_op, even if the instruction stream is identical. Is there
> anything else I need to move when I do this?

This one's out of my field of knowledge; Richard might know.

> - Is insn_start necessary to have in order(and what does it do?)? These
> currently are serializing instructions in my scheduler and significantly
> limit my reordering as they create lots of dependencies every few
> instructions.

The primary purpose of insn_start is to save information about the
current instruction in a metadata area associated with the generated
TB, so that if the guest takes an unexpected exception (typically,
because a guest load or store faults) then we can restore the CPU
state to what it should be at the point of the fault. This is more
efficient than if we had to emit a "write new PC value to CPU state"
operation at the end of every guest insn. At runtime, at the point
when we determine that we need to generate a guest exception, we know
the host PC (inside the generated code) where the fault occurred.
We look up that PC value in the metadata to determine which guest
PC value that corresponds to [in accel/tcg/translate-all.c
cpu_restore_state_from_tb()], and use that to correctly set the
guest PC value and sometimes other state [by calling the frontend's
restore_state_to_opc() function, passing it the data that the
frontend handed to the insn_start opcode. (Eg on 32-bit arm we use
this mechanism to fix up the condexec bits, and to provide correct
values for the exception syndrome register.) If you wanted to be
able to reorder TCG ops across guest insn boundaries you'd need to
make the "guest-PC-to-insn-start-data" lookup handle that. You'd
also need to ensure that you don't reorder anything that updates
information visible to the guest (a visible effect of the insn)
before anything that could generate an exception in a preceding insn.

insn_start is also handy simply for debugging purposes -- in debug
disassembly output we indicate where instruction boundaries are in
the host generated code and in the TCG IR opcode dump, which makes
it easier to figure out what the generated code was trying to do.

Finally, I haven't checked, but I suspect the new TCG plugin APIs
implicitly assume that code for each insn is generated serially,
ie that a plugin can do "for each instruction" type work on a
callback that hangs off the insn_start op.

> - Is it "okay" to use g2h and h2g directly in code in syscall.c?
> Currently it seems like TYPE_PTRVOID doesn't do this conversion, and as
> such, most of the calls made over the guest-host barrier made by DRM
> seem to fail spectacularly across bittedness lines. I think a more ideal
> solution would be implementing types that do this automatically, so I
> don't have to deal with the difference in struct size using macros, but
> in the short term I don't really have another option.

Usually syscall.c code wants to use lock_user/lock_user_string/
lock_user_struct rather than directly using g2h/h2g. This is
important because the lock_user functions will check whether the
guest can actually access the memory, so that you can return a
suitable error (usually TARGET_EFAULT). Otherwise if the guest
hands you a buffer it doesn't have access to then your g2h-then-access
will probably make QEMU crash.

I think that the reason TYPE_PTRVOID is not converted within a struct
is that almost always the syscall.c wrapper for the ioctl will
need to actively do something to convert the data being pointed
to, which means it will need to call lock_user() on it, which means
it wants the guest address, not the host address. So an IOCTL
definition that uses TYPE_PTRVOID will be an IOCTL_SPECIAL()
which provides a C function to handle that conversion.
If the buffer being pointed to is literally just a byte buffer
of data that needs no conversion, I think you can specify that
with MK_PTR(TYPE_CHAR). If it's anything more complicated then
it's going to need an IOCTL_SPECIAL and a conversion function.

thanks
-- PMM

