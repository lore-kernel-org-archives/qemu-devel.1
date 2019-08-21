Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31AFFC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 20:39:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7B782332A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 20:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RGufuJx7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7B782332A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0XOV-0005F8-3V
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 16:39:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35164)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i0XNJ-0003s9-O9
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 16:38:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i0XNI-0005xS-64
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 16:38:33 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:46467)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i0XNH-0005w2-SP
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 16:38:32 -0400
Received: by mail-pg1-x544.google.com with SMTP id m3so1990360pgv.13
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 13:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=EB27c3pMn0UInpU2AIvspJmspehoVyhRIMTlLogIUx8=;
 b=RGufuJx7RB3AiWExBAFXRPJPynmIxp8s+sURdYqw27yuu4YSQAyEFJNxB1t8fujanD
 BQrEf+ZT+mRb4sjG+yLEH+SpcOJEpgqjjt6DQAJa/0iyz1TY0BX0qMveSoOWvO6rd1rX
 bO5SUm1Cl5WtfbgQufcti/pxEULP29CuLwDAgJ0+YqjEoTQpxUWXAiiFjZSE+W+eVJvS
 FD1Cee2riQL1CDvNMY5l9iiUy61Pwwg7GryyMGfeRydls0OAoC4Ru/3t570qBIJIvEjU
 rOwqPfCMQW53tGoMeRYsSDgmZvHA4I/xansRnBOawtFCJmwECLXNPRmT/CghsjE4yENt
 BysQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EB27c3pMn0UInpU2AIvspJmspehoVyhRIMTlLogIUx8=;
 b=hpu3qvX0OnNzKgxECDwbyToklGjwXanrNJC0ZXlOW7MWszchUsaopCecE1EJbGt90S
 FcrrKa+ie02T/hrxruIO3wi4SdcGZNpXZWSVJ3hivTZLhhdlfErj5F6NsdliXX5A8Hwf
 ozijNO/8RCogTn7/d0VEpjlOuqRqF92h2svMEAC26gHyslq4igBpOQ+/0MQ9PxQTKeQt
 Z5751QR2VkCNBgkq+JDlpLf9/xlPkfwJXuDyLZU744/BbKf05IMzOqbjpPlNVpn43DSG
 QmJzWORuCJccqB+rPsFkJ2KlHgCJ7oycU4mQzKJETE5aKrCkchKphAYDUCedTDM5rNYG
 dTBA==
X-Gm-Message-State: APjAAAX8QjNM9P/yevzHYuHFMuf/rjYFxE5rs2KzpONKP2wcmWkhoAUj
 3/YzFscS21+oBtKuyKN5vYGdEA==
X-Google-Smtp-Source: APXvYqxOIifgvVCHUrAtM9U0zHvD9cA9jmsPcnQjDnhFqmwClmNvs602T4KOmw/TMJZOkG2jppr9tA==
X-Received: by 2002:aa7:8201:: with SMTP id k1mr36749566pfi.97.1566419910493; 
 Wed, 21 Aug 2019 13:38:30 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id b5sm23659343pfo.149.2019.08.21.13.38.28
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 21 Aug 2019 13:38:29 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190821092252.26541-1-david@redhat.com>
 <20190821092252.26541-3-david@redhat.com>
 <dc42887a-f991-1fe0-36a7-a7804bc4a939@linaro.org>
 <60d60d82-0407-9549-09b8-ff35218a4e71@redhat.com>
 <8973f904-c171-bcdd-3f6e-5e18cb37035c@linaro.org>
 <1c0c597d-c851-4116-184e-6b35fae08011@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <d46f1b05-ef1f-cf82-f49c-ef9eb814c10e@linaro.org>
Date: Wed, 21 Aug 2019 13:38:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1c0c597d-c851-4116-184e-6b35fae08011@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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

On 8/21/19 12:36 PM, David Hildenbrand wrote:
>>> There are certain cases where we can't get access to the raw host
>>> page. Namely, cpu watchpoints, LAP, NODIRTY. In summary: this won't
>>> as you describe. (my first approach did exactly this)
>>
>> NODIRTY and LAP are automatically handled via probe_write
>> faulting instead of returning the address.  I think there
>> may be a bug in probe_write at present not checking
> 
> For LAP pages we immediately set TLB_INVALID_MASK again, to trigger a
> new fault on the next write access (only). The could be handled in
> tlb_vaddr_to_host(), simply returning the address to the page after
> trying to fill the tlb and succeeding (I implemented that, that's the
> easy part).

Yes.

> TLB_NOTDIRTY and TLB_MMIO are the real issue. We don't want to refault,
> we want to treat that memory like IO memory and route it via
> MemoryRegionOps() - e.g., watch_mem_ops() in qemu/exec.c. So it's not a
> fault but IO memory.

Watchpoints are not *really* i/o memory (unless of course it's a watchpoint on
a device, which is a different matter), that's merely how we've chosen to
implement it to force the memory operation through the slow path.  We can, and
probably should, implement this differently wrt probe_write.

Real MMIO can only fault via cc->transaction_failed(), for some sort of bus
error.  Which s390x does not currently implement.  In the meantime, a
probe_write proves that the page is at least mapped correctly, so we have
eliminated the normal access fault.

NOTDIRTY cannot fault at all.  The associated rcu critical section is ugly
enough to make me not want to do anything except continue to go through the
regular MMIO path.

In any case, so long as we eliminate *access* faults by probing the page table,
then falling back to the byte-by-byte loop is, AFAICS, sufficient to implement
the instructions correctly.

> probe_write() performs the MMU translation. If that succeeds, there is
> no fault. If there are watchpoints, the memory is treated like IO and
> memory access is rerouted. I think this works as designed.

Well, if BP_STOP_BEFORE_ACCESS, then we want to raise a debug exception before
any changes are made.  If !BP_STOP_BEFORE_ACCESS, then we longjmp back to the
main cpu loop and single-step the current instruction.

In the latter case, if the instruction has had any side effects prior to the
longjmp, they will be re-done when we re-start the current instruction.

To me this seems like a rather large bug in our implementation of watchpoints,
as it only really works properly for simple load/store/load-op-store type
instructions.  Anything that works on many addresses and doesn't delay side
effects until all accesses are complete will Do The Wrong Thing.

The fix, AFAICS, is for probe_write to call check_watchpoint(), so that we
take the debug exit early.

> You mean two pages I assume. Yeah, I could certainly simplify the
> prototype patch I have here quite a lot. 2 pages should be enough for
> everybody ;)

Heh.  But, seriously, TARGET_PAGE_SIZE bytes is enough at one go, without
releasing control so that interrupts etc may be recognized.


r~

