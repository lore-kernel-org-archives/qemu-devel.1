Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 526C4C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 22:35:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BB8D2332A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 22:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yn/hPySy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BB8D2332A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0ZCb-0001pH-2i
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 18:35:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40730)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i0Z9K-0007XR-CT
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 18:32:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i0Z9I-0002eI-Ic
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 18:32:13 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:40242)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i0Z9G-0002Wh-Kl
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 18:32:12 -0400
Received: by mail-pg1-x541.google.com with SMTP id w10so2184277pgj.7
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 15:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=xNFvN1LOd1eKew9iRuGlighR5KjGBc84HZ+QqdH22lA=;
 b=Yn/hPySyg8etqu3/wYElKd6FZ+dJxKJR9uEd+MpwjQ74/fpNJAndSXLrTfapKSDKvm
 wOuJrpvHbMhzmpHiAZ1loGgt2FE5xVczdkDQmFtcdDNsVD5XIOQn/+rktKQhIRZw8cIK
 NNWYDJlVY+WTJbU2j0WBUT2tDbAlCRHcCGbM1HnjX0+cQI213hPeLG8vQ0EpfTsNkN4T
 aze3cLikhbZ5HgmP+e2W/dl7KKw9jefaRj9nA7bzM2LOsvzwATr4vsNSPH2Z4wdIIgaX
 t+1c2r5NVFqnKFAYrY8eOyCXBzVUcU+CqjCSFsZhs1qofv2fH3lcamJWEKG+14d2TKdP
 63qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xNFvN1LOd1eKew9iRuGlighR5KjGBc84HZ+QqdH22lA=;
 b=dHaA25z9h+pi98tlXiuEx45qbJOsbYAdfr+Oekmgw3yKL2nkd3HWklFQxmgUe1Q4Pq
 +SetTPFMaddcp8nXyTgMuzJQ8+reo9kZ2X9XrR580nQCh3NUbaShkv+GIwejIh6taI1i
 5kPPGxtgN5mwh39yYOoLb9kCuor/k2b2NPem0GHcTyTiuV//BOQvGba1YSNTF+RNHpFf
 5SXx1+hPctuZtrS6Y9bnExz8NRLfdRAof2fejwZSL+D44Qw+ZQomAwgL5ZVlTrEtkAZm
 1QSNce3gsqBJrIyMtVGJrIiKDNzub4dH1n/JAhEoZD9Hthc+AX4U/qu7GUbUj1rLUgzV
 hlbA==
X-Gm-Message-State: APjAAAVBDwcX6MkhPIZ9wE0So3bUzgq5KA2Z6lJ35p+oTGE+fEz5XeP4
 NwLhShJfEBd0Nz2rBpURnj1p2A==
X-Google-Smtp-Source: APXvYqzvjsma7e2aazHhbsk/XqejFKHC/0TtC22/3968A+GNTLmMNQQGOruwhqiRKWiU1tFYZx1REA==
X-Received: by 2002:a17:90a:b014:: with SMTP id
 x20mr2276112pjq.60.1566426721347; 
 Wed, 21 Aug 2019 15:32:01 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id s20sm23733440pfe.169.2019.08.21.15.31.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 21 Aug 2019 15:32:00 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190821092252.26541-1-david@redhat.com>
 <20190821092252.26541-3-david@redhat.com>
 <dc42887a-f991-1fe0-36a7-a7804bc4a939@linaro.org>
 <60d60d82-0407-9549-09b8-ff35218a4e71@redhat.com>
 <8973f904-c171-bcdd-3f6e-5e18cb37035c@linaro.org>
 <1c0c597d-c851-4116-184e-6b35fae08011@redhat.com>
 <d46f1b05-ef1f-cf82-f49c-ef9eb814c10e@linaro.org>
 <5bbdc8de-2526-2091-3d87-4c0945ce9442@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <a8b1436d-a634-d767-8861-460c50acecb2@linaro.org>
Date: Wed, 21 Aug 2019 15:31:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <5bbdc8de-2526-2091-3d87-4c0945ce9442@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: Re: [Qemu-devel] [PATCH v1 2/4] s390x/tcg: Introduce
 probe_read_access()
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
Cc: Florian Weimer <fweimer@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Stefano Brivio <sbrivio@redhat.com>,
 qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/21/19 2:33 PM, David Hildenbrand wrote:
>> NOTDIRTY cannot fault at all.  The associated rcu critical section is ugly
>> enough to make me not want to do anything except continue to go through the
>> regular MMIO path.
>>
>> In any case, so long as we eliminate *access* faults by probing the page table,
>> then falling back to the byte-by-byte loop is, AFAICS, sufficient to implement
>> the instructions correctly.
> 
> "In any case, so long as we eliminate *access* faults by probing the
> page table" - that's what I'm doing in this patch (and even more correct
> in the prototype patch I shared), no? (besides the watchpoint madness below)

Correct.

My main objection to your current patch is that you perform the access checks
within MVC, and then do some more tlb lookups in fast_memmove.

I think that fast_memmove is where the access checks should live.  That allows
incremental improvement to combine access checks + host address lookup, which
cannot currently be done in one step with existing interfaces.

I guess you would still want access checks within MVC for the case in which you
must fall back to byte-by-byte because of destructive overlap.

> "falling back to the byte-by-byte loop is, AFAICS, sufficient"
> 
> I don't think this is sufficient. E.g., LAP protected pages
> (PAGE_WRITE_INV which immediately requires a new MMU walk on the next
> access) will trigger a new MMU walk on every byte access (that's why I
> chose to pre-translate in my prototype).

LAP protected pages is exactly why probe_write should return the host address,
so that we can do the access check + host address lookup in one step.

But in the meantime...

> If another CPU modified the
> page tables in between, we could suddenly get a fault - although we
> checked early. What am I missing?

You're concerned with a bare write to the page table by cpu B, while cpu A is
executing, and before cpu B issues the cross-cpu tlb flush?

The tlb victim cache should prevent having to re-read a tlb entry from memory,
at least for MVC.  The unlimited size we currently support for MVCL and MVCLE
could act weird, but would be fixed by limiting the execution as discussed.

Honestly, the os has to make sure that the page remains valid until after the
flush completes, otherwise it's an os bug.  The cross-cpu tlb flush happens via
async_run_on_cpu, and of course never occurs while we are executing a TB.  Yet
another reason to limit the amount of work any one instruction does.  ;-)


> I see that we use BP_STOP_BEFORE_ACCESS for PER (Program Event
> Recording) on s390x. I don't think that's correct. We want to get
> notified after the values were changed.
> 
> "A storage-alteration event occurs whenever a CPU,
> by using a logical or virtual address, makes a store
> access without an access exception to the storage
> area designated by control registers 10 and 11. ..."
> 
> "For a PER instruction-fetching nullification event, the
> unit of operation is nullified. For other PER events,
> the unit of operation is completed"
> 
> Oh man, why is everything I take a look at broken.

Heh.

>> In the latter case, if the instruction has had any side effects prior to the
>> longjmp, they will be re-done when we re-start the current instruction.
>>
>> To me this seems like a rather large bug in our implementation of watchpoints,
>> as it only really works properly for simple load/store/load-op-store type
>> instructions.  Anything that works on many addresses and doesn't delay side
>> effects until all accesses are complete will Do The Wrong Thing.
>>
>> The fix, AFAICS, is for probe_write to call check_watchpoint(), so that we
>> take the debug exit early.
> 
> Indeed. I see what you mean now. (I was ignoring the "before access"
> because I was assuming we don't need it on s390x)
> 
> probe_write() would have to check for all BP_STOP_BEFORE_ACCESS watchpoints.

!BP_STOP_BEFORE_ACCESS watchpoints exit to the main loop as well, so that it
can restart and then single-step the current instruction.

We need it the check in probe_write for all cases.

> Yes, that's what I mean, TARGET_PAGE_SIZE, but eventually crossing a
> page boundary. The longer I stare at the MVCL code, the more broken it
> is. There are more nice things buried in the PoP. MVCL does not detect
> access exceptions beyond the next 2k. So we have to limit it there
> differently.

That language is indeed odd.

The only reading of that paragraph that makes sense to me is that the hardware
*must* interrupt MVCL after every 2k bytes processed.  The idea that the user
can magically write to a read-only page simply by providing length = 2MB and
page that is initially writable is dumb.  I cannot imagine that is a correct
reading.

Getting clarification from an IBM engineer on that would be good; otherwise I
would just ignore that and proceed as if all access checks are performed.

> So what I understand is that
> 
> - we should handle watchpoints in probe_write()
> - not bypass IO memory (especially NOTDIRTY). We cannot always relay on
>   getting access to a host page.

Correct.


r~

