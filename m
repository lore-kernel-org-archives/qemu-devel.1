Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419BBC433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 14:25:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CA2F21E70
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 14:25:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CA2F21E70
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvMsH-0002sS-BM
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 10:25:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39450)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hvMrs-0002Sf-P4
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 10:24:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hvMrr-0001B8-Pg
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 10:24:44 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53496)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hvMrr-0001Av-Jb
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 10:24:43 -0400
Received: by mail-wm1-f67.google.com with SMTP id 10so250171wmp.3
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 07:24:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=iPK78WhUW7TbgbE0qVF5B4DyVagI1LChDonVI6DoGys=;
 b=DWqIggdrn8jaLzmdTquMitXFF3v/8T66xI3Zqv+WZEdG1vH+ef/g/TL9wzdxDoy9Nr
 aeeZ7Tu3/Gu6EUnlELU3JkOWLhc6BvX3hn3n4SmH9MtcDy+oMZq5FSwLBe6mnCOaxIg/
 xjBtPW5uVS8vsrrFdkj4nbf0eTarjN/gWKEALDpXspOL6t+gfGIDo619U1/l8rbZt1qi
 5jfZsUwdHNc3iDIys+BpUElcULRKpJTtrVMErZiluaXUAQM/lHsExffOfcTJbXOOnjwk
 4SuoySaPXPv1rQh42BfcxLtHlK1OLVvhXXqL7HuoFApuKHhY07PHCQo5fIpluIC4Bw3t
 CPHQ==
X-Gm-Message-State: APjAAAV9S3zD65A241hcW6O9+gi61V1z2enNClcGp9WcA+2M936i7XoC
 K1eNAH8y1BAEE9uPD9z1//JhKg==
X-Google-Smtp-Source: APXvYqysx3zQyCMhgW47bS/8aah0PGHpmNO7e4aJVJS/0MQ1Ifgy4gMTMszBjbn/WHD/Yc00rSBsVw==
X-Received: by 2002:a1c:407:: with SMTP id 7mr227789wme.113.1565187882409;
 Wed, 07 Aug 2019 07:24:42 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:dc26:ed70:9e4c:3810?
 ([2001:b07:6468:f312:dc26:ed70:9e4c:3810])
 by smtp.gmail.com with ESMTPSA id 15sm145127wmk.34.2019.08.07.07.24.41
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 07 Aug 2019 07:24:41 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190729214717.6616-1-pbonzini@redhat.com>
 <CAFEAcA-gtfK1AwSFKo9XatJ_E9345Cd9+MS+1uu2WYG0i32sVA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <680dc43c-328f-ea59-553c-6e277c388d7c@redhat.com>
Date: Wed, 7 Aug 2019 16:24:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-gtfK1AwSFKo9XatJ_E9345Cd9+MS+1uu2WYG0i32sVA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH untested for-4.2] memory: fix race between
 TCG and accesses to dirty bitmap
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/08/19 16:23, Peter Maydell wrote:
> On Mon, 29 Jul 2019 at 22:47, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> The race is as follows:
>>
>>       vCPU thread                  reader thread
>>       -----------------------      -----------------------
>>       TLB check -> slow path
>>         notdirty_mem_write
>>           write to RAM
>>           set dirty flag
>>                                    clear dirty flag
>>       TLB check -> fast path
>>                                    read memory
>>         write to RAM
>>
>> and the second write is missed by the reader.
>>
>> Fortunately, in order to fix it, no change is required to the
>> vCPU thread.  However, the reader thread must delay the read after
>> the vCPU thread has finished the write.  This can be approximated
>> conservatively by run_on_cpu, which waits for the end of the current
>> translation block.
>>
>> A similar technique is used by KVM, which has to do a synchronous TLB
>> flush after doing a test-and-clear of the dirty-page flags.
>>
>> Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>         I tested this some time ago, and enough has changed that I don't
>>         really trust those old results.  Nevertheless, I am throwing out
>>         the patch so that it is not forgotten.
> 
> This patch looks almost the same (maybe identical except for the
> commit message title?) as the patch "memory: introduce
> memory_global_after_dirty_log_sync" which you sent out at almost
> the same time as this one. Which patch should we be reviewing?

Yes, it's the same except for the commit message title.  I forgot a "-1"
after editing the .patch file.

Paolo


