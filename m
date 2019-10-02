Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6EC2C352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 13:21:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D9C021783
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 13:21:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D9C021783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFeZE-0001iX-Lr
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 09:21:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55030)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iFeYD-0000r9-7n
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 09:20:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iFeYB-0004N8-23
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 09:20:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60722)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iFeYA-0004MA-Pj
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 09:20:14 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 36C26C057E3C
 for <qemu-devel@nongnu.org>; Wed,  2 Oct 2019 13:20:13 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id m6so2097933wmf.2
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2019 06:20:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HiSosKbL2npaAFkVwirGRZPt70/UvUVKM/bGIq2Af24=;
 b=ImZRg4oKEZc891NhhQ11Daqlf5YzZPFNVlLtBIz9ayJi5cgXRl0CqtP0W7YQSOSQ/e
 +U7eapqmhYgNv+oEJWzRlBk7mtWFoEbddRUQK7rAUk1/CbkIih+Z4WU8wa/5Uz+HRvJv
 vX+5tsxVHbyImuStL8v0TBbMXQAyMUxm1EJX+C8MHH5gEoghz10qX/i2VvV1WuKl6XbE
 Q0v5/LOQx/E60lt/0yKtEgMhrD5PBn5jUM1QHwbArj1azfYz3BfkiwcmWqCHsWRjy7jN
 zvCGeHKcDq7rEySgHRmsxAzBpZlu9jBtds8+OC2zo+AfdjrqjeHFwDl3fWuIEeKpi3y4
 jCuw==
X-Gm-Message-State: APjAAAXsGQwrtKUjXkkXDKsSZCHKDAVMgwkmmoy8TF5D1rKC9AnNJSWW
 QnKxxZGyo54jSpPXgAv4JnTkeNR96EZ2Oase07RDeyBl1j8IcIPD8ByFKEzi1OTZesBT4kaetH5
 ob0Gw9enW47phfrs=
X-Received: by 2002:a1c:5454:: with SMTP id p20mr3006519wmi.93.1570022411703; 
 Wed, 02 Oct 2019 06:20:11 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwWxw4gwMPGc1W7Fq9HMx41t703x1zsjl/uXUQthOOgSMo5R2QsqbdD8jPKvPCmCNPBhT9bTQ==
X-Received: by 2002:a1c:5454:: with SMTP id p20mr3006486wmi.93.1570022411275; 
 Wed, 02 Oct 2019 06:20:11 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b903:6d6f:a447:e464?
 ([2001:b07:6468:f312:b903:6d6f:a447:e464])
 by smtp.gmail.com with ESMTPSA id o19sm10496752wmh.27.2019.10.02.06.20.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Oct 2019 06:20:10 -0700 (PDT)
Subject: memory barriers and ATOMIC_SEQ_CST on aarch64 (was Re: [Qemu-devel]
 qemu_futex_wait() lockups in ARM64: 2 possible issues)
To: Jan Glauber <jglauber@marvell.com>
References: <cbe46ad6-ef6c-d155-e79a-672182c725ad@ubuntu.com>
 <d94f18f1-986f-ec19-02c0-e83e5e7af3d0@redhat.com>
 <1864070a-2f84-1d98-341e-f01ddf74ec4b@ubuntu.com>
 <20190924202517.GA21422@xps13.dannf> <20191002092253.GA3857@hc>
 <ed5c4522-9250-e403-c55d-d3dbcda82540@redhat.com> <20191002110550.GA3482@hc>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <96c26e21-5996-0c63-ce8b-99a1b5473453@redhat.com>
Date: Wed, 2 Oct 2019 15:20:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191002110550.GA3482@hc>
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
 QEMU Developers - ARM <qemu-arm@nongnu.org>,
 Torvald Riegel <triegel@redhat.com>, Will Deacon <will@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/10/19 13:05, Jan Glauber wrote:
> The arm64 code generated for the
> atomic_[add|sub] accesses of ctx->notify_me doesn't contain any
> memory barriers. It is just plain ldaxr/stlxr.
> 
> From my understanding this is not sufficient for SMP sync.
> 
>>> If I read this comment correct:
>>> 
>>>     void aio_notify(AioContext *ctx)
>>>     {
>>>         /* Write e.g. bh->scheduled before reading ctx->notify_me.  Pairs
>>>          * with atomic_or in aio_ctx_prepare or atomic_add in aio_poll.
>>>          */
>>>         smp_mb();
>>>         if (ctx->notify_me) {
>>>
>>> it points out that the smp_mb() should be paired. But as
>>> I said the used atomics don't generate any barriers at all.
>>
>> Awesome!  That would be a compiler bug though, as atomic_add and atomic_sub
>> are defined as sequentially consistent:
>>
>> #define atomic_add(ptr, n) ((void) __atomic_fetch_add(ptr, n, __ATOMIC_SEQ_CST))
>> #define atomic_sub(ptr, n) ((void) __atomic_fetch_sub(ptr, n, __ATOMIC_SEQ_CST))
>
> Compiler bug sounds kind of unlikely...
Indeed the assembly produced by the compiler matches for example the
mappings at https://www.cl.cam.ac.uk/~pes20/cpp/cpp0xmappings.html.  A
small testcase is as follows:

  int ctx_notify_me;
  int bh_scheduled;

  int x()
  {
      int one = 1;
      int ret;
      __atomic_store(&bh_scheduled, &one, __ATOMIC_RELEASE);     // x1
      __atomic_thread_fence(__ATOMIC_SEQ_CST);                   // x2
      __atomic_load(&ctx_notify_me, &ret, __ATOMIC_RELAXED);     // x3
      return ret;
  }

  int y()
  {
      int ret;
      __atomic_fetch_add(&ctx_notify_me, 2, __ATOMIC_SEQ_CST);  // y1
      __atomic_load(&bh_scheduled, &ret, __ATOMIC_RELAXED);     // y2
      return ret;
  }

Here y (which is aio_poll) wants to order the write to ctx->notify_me
before reads of bh->scheduled.  However, the processor can speculate the
load of bh->scheduled between the load-acquire and store-release of
ctx->notify_me.  So you can have something like:

 thread 0 (y)                          thread 1 (x)
 -----------------------------------   -----------------------------
 y1: load-acq ctx->notify_me
 y2: load-rlx bh->scheduled
                                       x1: store-rel bh->scheduled <-- 1
                                       x2: memory barrier
                                       x3: load-rlx ctx->notify_me
 y1: store-rel ctx->notify_me <-- 2

Being very puzzled, I tried to put this into cppmem:

  int main() {
    atomic_int ctx_notify_me = 0;
    atomic_int bh_scheduled = 0;
    {{{ {
          bh_scheduled.store(1, mo_release);
          atomic_thread_fence(mo_seq_cst);
          // must be zero since the bug report shows no notification
          ctx_notify_me.load(mo_relaxed).readsvalue(0);
        }
    ||| {
          ctx_notify_me.store(2, mo_seq_cst);
          r2=bh_scheduled.load(mo_relaxed);
        }
    }}};
    return 0;
  }

and much to my surprise, the tool said r2 *can* be 0.  Same if I put a
CAS like

        cas_strong_explicit(ctx_notify_me.readsvalue(0), 0, 2,
                            mo_seq_cst, mo_seq_cst);

which resembles the code in the test case a bit more.

I then found a discussion about using the C11 memory model in Linux
(https://gcc.gnu.org/ml/gcc/2014-02/msg00058.html) which contains the
following statement, which is a bit disheartening even though it is
about a different test:

   My first gut feeling was that the assertion should never fire, but
   that was wrong because (as I seem to usually forget) the seq-cst
   total order is just a constraint but doesn't itself contribute
   to synchronizes-with -- but this is different for seq-cst fences.

and later in the thread:

   Use of C11 atomics to implement Linux kernel atomic operations
   requires knowledge of the underlying architecture and the compiler's
   implementation, as was noted earlier in this thread.

Indeed if I add an atomic_thread_fence I get only one valid execution,
where r2 must be 1.  This is similar to GCC's bug
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=65697, and we can fix it in
QEMU by using __sync_fetch_and_add; in fact cppmem also shows one valid
execution if the store is replaced with something like GCC's assembly
for __sync_fetch_and_add (or Linux's assembly for atomic_add_return):

        cas_strong_explicit(ctx_notify_me.readsvalue(0), 0, 2,
                            mo_release, mo_release);
        atomic_thread_fence(mo_seq_cst);

So we should:

1) understand why ATOMIC_SEQ_CST is not enough in this case.  QEMU code
seems to be making the same assumptions as Linux about the memory model,
and this is wrong because QEMU uses C11 atomics if available.
Fortunately, this kind of synchronization in QEMU is relatively rare and
only this particular bit seems affected.  If there is a fix which stays
within the C11 memory model, and does not pessimize code on x86, we can
use it[1] and document the pitfall.

2) if there's no way to fix the bug, qemu/atomic.h needs to switch to
__sync_fetch_and_add and friends.  And again, in this case the
difference between the C11 and Linux/QEMU memory models must be documented.

Torvald, Will, help me please... :((

Paolo

[1] as would be the case if fetch_add was implemented as
fetch_add(RELEASE)+thread_fence(SEQ_CST).

