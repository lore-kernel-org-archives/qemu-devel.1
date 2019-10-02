Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B1FC35280
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 16:31:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC92C21848
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 16:31:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC92C21848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFhX4-0005ub-3w
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 12:31:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60221)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iFhVv-00053j-Qb
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:30:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iFhVt-0001YU-O0
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:30:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45358)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iFhVt-0001Xy-Ez
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:30:05 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1EB35356C9
 for <qemu-devel@nongnu.org>; Wed,  2 Oct 2019 16:30:04 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id t11so7701451wro.10
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2019 09:30:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=T7c8flhUbZ1C0bOSjeNuKv8I8JH+Ct/uuLyyQ9szNh8=;
 b=Z1dMugrfubuvQvA6zksWoQnAUAbTDEYM2TEkdFFLhlEtL4HjsElE3BcMRS1a3p8pgM
 GrDtQEC8cLLFFcJqXli/UgSC+4aAkcmMfZE9ANCv9Q62Y+U3/hGl4V/fR5PLk/c7CqCo
 unTWs5o/wHs0MT2Hmv9GHF7zKyo4je9I4BqwhDrLoisaJQbt3yPbtUNzNwFMANZ6RKDG
 M5/C3Ks9NGCAFnggkT+yA2LuQVQSmH872KP71KTC5hB4MH6J5KuwFyu/bCbEn8zcGxnU
 JcJhjTmFDeTR1aJSMcy7+x/t/4FVK46qbp3ab7+6IG3azhH5oXhmirCAWQw5Y+h/YnXX
 JlAg==
X-Gm-Message-State: APjAAAXxayAXSRLrPsVHaNY5Hqv2mVW5riXg6+KwqoXTQR4QL1okAkzd
 FzLoo8el+bko2O2thHbvazvcslpMqea9ryQWrn0TNxXPJfJUGxuEHabMt9mNxyDikQLS8WW6QfO
 QHQ3l4OuRqGqkmZc=
X-Received: by 2002:a1c:7fcc:: with SMTP id a195mr3666546wmd.27.1570033802764; 
 Wed, 02 Oct 2019 09:30:02 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyoYsFCLOxTQM2mKh55a9IQpDCY7RO2/RuUKg8te/RCk5JxzZNGqDJ9yywSfGBsJc3SiZw8qw==
X-Received: by 2002:a1c:7fcc:: with SMTP id a195mr3666518wmd.27.1570033802430; 
 Wed, 02 Oct 2019 09:30:02 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id f8sm4435998wmb.37.2019.10.02.09.30.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Oct 2019 09:30:01 -0700 (PDT)
Subject: Re: memory barriers and ATOMIC_SEQ_CST on aarch64 (was Re:
 [Qemu-devel] qemu_futex_wait() lockups in ARM64: 2 possible issues)
To: Torvald Riegel <triegel@redhat.com>, Jan Glauber <jglauber@marvell.com>
References: <cbe46ad6-ef6c-d155-e79a-672182c725ad@ubuntu.com>
 <d94f18f1-986f-ec19-02c0-e83e5e7af3d0@redhat.com>
 <1864070a-2f84-1d98-341e-f01ddf74ec4b@ubuntu.com>
 <20190924202517.GA21422@xps13.dannf> <20191002092253.GA3857@hc>
 <ed5c4522-9250-e403-c55d-d3dbcda82540@redhat.com> <20191002110550.GA3482@hc>
 <96c26e21-5996-0c63-ce8b-99a1b5473453@redhat.com>
 <12dc4ab638bf8b5af941b24ac989ea45aa8c09b6.camel@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <746238b0-ba75-a752-1402-5f7754a74775@redhat.com>
Date: Wed, 2 Oct 2019 18:30:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <12dc4ab638bf8b5af941b24ac989ea45aa8c09b6.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Rafael David Tinoco <rafaeldtinoco@ubuntu.com>,
 lizhengui <lizhengui@huawei.com>, dann frazier <dann.frazier@canonical.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Bug 1805256 <1805256@bugs.launchpad.net>,
 QEMU Developers - ARM <qemu-arm@nongnu.org>, Will Deacon <will@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/10/19 16:58, Torvald Riegel wrote:
> This example looks like Dekker synchronization (if I get the intent right).

It is the same pattern.  However, one of the two synchronized variables
is a counter rather than just a flag.

> Two possible implementations of this are either (1) with all memory
> accesses having seq-cst MO, or (2) with relaxed-MO accesses and seq-cst
> fences on between the store and load on both ends.  It's possible to mix
> both, but that get's trickier I think.  I'd prefer the one with just
> fences, just because it's easiest, conceptually.

Got it.

I'd also prefer the one with just fences, because we only really control
one side of the synchronization primitive (ctx_notify_me in my litmus
test) and I don't like the idea of forcing seq-cst MO on the other side
(bh_scheduled).  The performance issue that I mentioned is that x86
doesn't have relaxed fetch and add, so you'd have a redundant fence like
this:

	lock	xaddl $2, mem1
	mfence
	...
	movl	mem1, %r8

(Gory QEMU details however allow us to use relaxed load and store here,
because there's only one writer).

> It works if you use (1) or (2) consistently.  cppmem and the Batty et al.
> tech report should give you the gory details.
>
>> 1) understand why ATOMIC_SEQ_CST is not enough in this case.  QEMU code
>> seems to be making the same assumptions as Linux about the memory model,
>> and this is wrong because QEMU uses C11 atomics if available.
>> Fortunately, this kind of synchronization in QEMU is relatively rare and
>> only this particular bit seems affected.  If there is a fix which stays
>> within the C11 memory model, and does not pessimize code on x86, we can
>> use it[1] and document the pitfall.
>
> Using the fences between the store/load pairs in Dekker-like
> synchronization should do that, right?  It's also relatively easy to deal
> with.
> 
>> 2) if there's no way to fix the bug, qemu/atomic.h needs to switch to
>> __sync_fetch_and_add and friends.  And again, in this case the
>> difference between the C11 and Linux/QEMU memory models must be documented.
>
> I surely not aware of all the constraints here, but I'd be surprised if the
> C11 memory model isn't good enough for portable synchronization code (with
> the exception of the consume MO minefield, perhaps). 

This helps a lot already; I'll work on a documentation and code patch.
Thanks very much.

Paolo

>>   int main() {
>>     atomic_int ctx_notify_me = 0;
>>     atomic_int bh_scheduled = 0;
>>     {{{ {
>>           bh_scheduled.store(1, mo_release);
>>           atomic_thread_fence(mo_seq_cst);
>>           // must be zero since the bug report shows no notification
>>           ctx_notify_me.load(mo_relaxed).readsvalue(0);
>>         }
>>     ||| {
>>           ctx_notify_me.store(2, mo_seq_cst);
>>           r2=bh_scheduled.load(mo_relaxed);
>>         }
>>     }}};
>>     return 0;
>>   }


