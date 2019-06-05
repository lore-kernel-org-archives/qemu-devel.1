Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0258DC28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 23:19:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B94BC2075B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 23:19:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B94BC2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51610 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYfC2-0003g3-PP
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 19:19:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@dabbelt.com>) id 1hYfB8-0003O8-Cz
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 19:18:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@dabbelt.com>) id 1hYfB6-0006nE-Om
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 19:18:46 -0400
Received: from mail-pg1-f170.google.com ([209.85.215.170]:39951)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hYfB4-0006gV-KN
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 19:18:43 -0400
Received: by mail-pg1-f170.google.com with SMTP id d30so183002pgm.7
	for <qemu-devel@nongnu.org>; Wed, 05 Jun 2019 16:18:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
	:mime-version:content-transfer-encoding;
	bh=1hvlKOc9w4Q3jxGo5vC2gxT2yoW3uiDs1SLjD/Ak6y8=;
	b=f9Ximnyw4KIjoA8hENvmlh5PbVpzvZgxPZphHXXrsEXL7tl2hDGk6ts1ca0+QcdrUd
	XxWEbKbDfxie+vA2oCPMBUqspu6ls0Efa4EVrJBnVwYoeWrIVRKlXfRgl7qNy+mCA7D/
	mK5J7X/WaADC0DG7MdTXTFqxfOzLY8GY+gvHwStnYYEZrPInoRjaNUPeh9XqUvwvJ6CD
	5F15MBzpEmOzMF/dKZrPZm4HbixSyn3aBOhje0GKYgCPGONu5vaVXtAO097rMYji4RFY
	BhVFz6jDn8usr76sGf+gOWzl/lf3e1G/CxszQIZXgiF7yfKWxGl9QPTFJe1hUPWJGEft
	9LAg==
X-Gm-Message-State: APjAAAUbSQVq2SAYebPBUvjtl3EKE4GH/yYfZYpd0mLur4200FSf+lR0
	1CJLxqzRoYYKZVO5xchP4pOZfsSGj9A=
X-Google-Smtp-Source: APXvYqwGk2GeNAq0Bdypn3FnInQ7Y6vZE+/jjTOvfuby8cGlHN9m31aLjovLjTvzACqwanm/x88TZw==
X-Received: by 2002:a62:b503:: with SMTP id y3mr47820106pfe.4.1559776717479;
	Wed, 05 Jun 2019 16:18:37 -0700 (PDT)
Received: from localhost ([12.206.222.5])
	by smtp.gmail.com with ESMTPSA id s5sm15678pgj.60.2019.06.05.16.18.36
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Wed, 05 Jun 2019 16:18:36 -0700 (PDT)
Date: Wed, 05 Jun 2019 16:18:36 -0700 (PDT)
X-Google-Original-Date: Wed, 05 Jun 2019 16:18:21 PDT (-0700)
In-Reply-To: <B1A3E8F6-F8C2-4EDB-A31B-EBB4CA636CA3@decred.org>
From: Palmer Dabbelt <palmer@sifive.com>
To: marco@decred.org
Message-ID: <mhng-6493b48f-57c1-47cd-9157-50cb533f91df@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.215.170
Subject: Re: [Qemu-devel] Fwd: [joel@sing.id.au: atomic failures on
 qemu-system-riscv64]
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
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 05 Jun 2019 13:59:53 PDT (-0700), marco@decred.org wrote:
> Joel is on vacation so here it is again.
>
>> Begin forwarded message:
>> 
>> From: Alistair Francis <Alistair.Francis@wdc.com>
>> Subject: Re: [joel@sing.id.au: atomic failures on qemu-system-riscv64]
>> Date: June 5, 2019 at 7:19:53 PM GMT+1
>> To: "joel@sing.id.au" <joel@sing.id.au>, "palmer@sifive.com" <palmer@sifive.com>
>> Cc: "marco@decred.org" <marco@decred.org>, "me@carlosedp.com" <me@carlosedp.com>
>> 
>> On Fri, 2019-05-31 at 03:21 +1000, Joel Sing wrote:
>>> I've just sent this to qemu-riscv@nongnu.org - forwarding for
>>> visibility...
>> 
>> Hello Joel,
>> 
>> Can you please send this to the QEMU mailing list?
>> https://wiki.qemu.org/Contribute/MailingLists
>> 
>>> 
>>> ----- Forwarded message from Joel Sing <joel@sing.id.au> -----
>>> 
>>> Date: Fri, 31 May 2019 03:20:03 +1000
>>> From: Joel Sing <joel@sing.id.au>
>>> To: qemu-riscv@nongnu.org
>>> Subject: atomic failures on qemu-system-riscv64
>>> User-Agent: Mutt/1.10.1 (2018-07-13)
>>> 
>>> While working on a Go (www.golang.org) port for riscv, I've run
>>> into issues with atomics (namely LR/SC) on qemu-system-riscv64.
>>> There are several reproducers for this problem including (using
>>> gcc builtin atomics):
>>> 
>>>  https://gist.github.com/4a6f656c/8433032a3f70893a278259f8108aad90
>>> 
>>> And a version using inline assembly:
>>> 
>>>  https://gist.github.com/4a6f656c/d883091f5ca811822720213be343a75a
>>> 
>>> Depending on the qemu configuration the number of threads may
>>> need increasing (to force context switching) and/or run in a
>>> loop. Go's sync/atomic tests also fail regularly.
>>> 
>>> Having dug into the qemu code, what I believe is happening is
>>> along the lines of the following:
>>> 
>>> 1. Thread 1 runs and executes an LR - this assigns an address
>>>   to load_res and a value to load_val (say 1).
>>> 
>>> 2. A context switch occurs and thread 2 is now run - it runs
>>>   an LR and SC on the same address modifying the stored value.
>>>   Another LR is executed loading load_val with the current
>>>   value (say 3).
>>> 
>>> 3. A context switch occurs and thread 1 is now run again, it
>>>   continues on its LR/SC sequence and now runs the SC instruction.
>>>   This is based on the assumption that it had a reservation
>>>   and the SC will fail if the memory has changed. The underlying
>>>   implementation of SC is a cmpxchg with the value in load_val
>>>   - this no longer has the original value and hence successfully
>>>   compares (as does the tcg_gen_setcond_tl() between the returned
>>>   value and load_val) thus the SC succeeds when it should not.
>>> 
>>> The diff below clears load_res when the mode changes - with this
>>> applied the reproducers work correctly, as do Go's atomic tests.
>>> I'm not sure this "fix" is 100% correct, but it certainly verifies
>>> where the problem lies. It does also fall inline with the RISCV
>>> spec:
>>> 
>>> "The SC must fail if there is an observable memory access from
>>> another hart to the address, or if there is an intervening context
>>> switch on this hart, or if in the meantime the hart executed a
>>> privileged exception-return instruction."

Sorry about this, but that wording is actually a bug in the ISA manual.  The
current version says

    An SC must fail if there is
    another SC (to any address) between the LR and the SC in program
    order.  The precise statement of the atomicity requirements for
    successful LR/SC sequences is defined by the Atomicity Axiom in
    Section~\ref{sec:rvwmo}.
    
    \begin{commentary}
    A store-conditional instruction to a scratch word of memory should be used
    during a preemptive context switch to forcibly yield any existing load
    reservation.
    \end{commentary}

The text in version 2.2 was changed because it doesn't really have meaning:
harts are a hardware construct, but context switches are a software context.
There were a few of these bugs floating around the ISA manual and we cleaned
them up more than a year ago, but the version on the RISC-V website hasn't
changed.  The ratified ISA manual will have the correct wording.

That said, the Linux user ABI allows programs to rely on reservations being
shot down on context switches -- if that wasn't the case then LR/SC would be
useless.  That's how the ambiguous wording snuck into the user ISA manual: we
confused the ISA behavior (ie, what the hardware does) with the user ABI
behavior (ie, what programs can rely on).

The reason you're only seeing this in QEMU is because the hardware has a
timeout on load reservations of something like 1000 cycles, and the Linux
context switching code takes longer than that timeout.  For some reason I
remember having fixed this bug in Linux, but I must have forgotten to actually
send out the patch.

Also, unless I'm misunderstanding something our implementation of LR/SC is
pretty broken.  We're just using a CAS to check if the value changed, which
suffers from the ABA problem that LR/SC is there to fix in the first place.  I
might be missing something here, though, as it looks like MIPS is doing
essentially the same thing.

>>> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
>>> index b17f169681..9875b8e5d3 100644
>>> --- a/target/riscv/cpu_helper.c
>>> +++ b/target/riscv/cpu_helper.c
>>> @@ -113,6 +113,8 @@ void riscv_cpu_set_mode(CPURISCVState *env,
>>> target_ulong newpriv)
>>>     }
>>>     /* tlb_flush is unnecessary as mode is contained in mmu_idx */
>>>     env->priv = newpriv;
>>> +
>>> +    env->load_res = 0;
>> 
>> This looks ok to me, I'll read the spec to double check though. Do you
>> mind adding a comment in the code as to why this is required?
>> 
>> Alistair
>> 
>>> }
>>> 
>>> /* get_physical_address - get the physical address for this virtual
>>> address
>>> 
>>> ----- End forwarded message -----

