Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64BA1C0650F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 15:57:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 364B02064A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 15:57:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 364B02064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hufMA-0005Fl-IE
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 11:57:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57426)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hufLo-0004pg-IX
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 11:56:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hufLn-0000YG-Gf
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 11:56:44 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36195)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hufLn-0000Xz-As
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 11:56:43 -0400
Received: by mail-wr1-f65.google.com with SMTP id n4so85018013wrs.3
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2019 08:56:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5WinF8OFMDP9PUxLhBvbJojjB3A9GAK8N79Kas2rsi4=;
 b=Nts7d9Hd99/a7YsgOvugEdDnpV4RU2brSYD+IY5XSOLXqlgQSfigq8HP70iP/SwQ+H
 7KUdZmvUtQjOwHOPl3lrbf2WFmxJwrtXPA6F94ZXBxAi3keUjnuW68wRfgfq+oaCCwtT
 fR5+zz2zrrShvMhj9I/kdcJnu9z3hB8aRFJUeqvYt6vh826PRLu3uhpx3zbdOIomp2qu
 bS/lxYoms1Zf8EovU5IdTlmBk7EcuQswfoVZZpPRVIAK1RA+aZMnB5UBSZHitRXgVuSv
 jwzx55pmwYdIc7s5ttGjI7zfbGnX90g1hAMwh/6bewDEI/jgpNlaJOSFJD4+1UIGaaL4
 wGig==
X-Gm-Message-State: APjAAAWy7fTgC3C7tEKvJJ8pFacI1o/dr2YsijL6jdFixFIA3JoUKd+y
 pEdfVJ4d/VTqunyVRF5gXicI2jyQsl4=
X-Google-Smtp-Source: APXvYqxtgH0rAONloZntufUYNa2tRZLVvAxHei16sTiGWZl9+uxopoO7KapFgF+D8VNLqleKgOH8+Q==
X-Received: by 2002:adf:e84a:: with SMTP id d10mr26136798wrn.316.1565020601944; 
 Mon, 05 Aug 2019 08:56:41 -0700 (PDT)
Received: from [192.168.178.40] ([151.21.165.91])
 by smtp.gmail.com with ESMTPSA id j189sm103403412wmb.48.2019.08.05.08.56.41
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 05 Aug 2019 08:56:41 -0700 (PDT)
To: Roman Kagan <rkagan@virtuozzo.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 "cota@braap.org" <cota@braap.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20190523105440.27045-1-rkagan@virtuozzo.com>
 <87imu11k6z.fsf@zen.linaroharston> <20190527110534.GA13549@rkaganb.sw.ru>
 <20190606132230.GB32258@rkaganb.sw.ru> <20190621124904.GA24164@rkaganb.sw.ru>
 <20190805124744.GC9653@rkaganb.sw.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <17c8bb30-1a22-b438-822a-a6a7f0ba5d36@redhat.com>
Date: Mon, 5 Aug 2019 17:56:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190805124744.GC9653@rkaganb.sw.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [RFC PATCH 0/2] establish nesting rule of BQL vs
 cpu-exclusive
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/08/19 14:47, Roman Kagan wrote:
> On Fri, Jun 21, 2019 at 12:49:07PM +0000, Roman Kagan wrote:
>> On Thu, Jun 06, 2019 at 01:22:33PM +0000, Roman Kagan wrote:
>>> On Mon, May 27, 2019 at 11:05:38AM +0000, Roman Kagan wrote:
>>>> On Thu, May 23, 2019 at 12:31:16PM +0100, Alex Bennée wrote:
>>>>>
>>>>> Roman Kagan <rkagan@virtuozzo.com> writes:
>>>>>
>>>>>> I came across the following AB-BA deadlock:
>>>>>>
>>>>>>     vCPU thread                             main thread
>>>>>>     -----------                             -----------
>>>>>> async_safe_run_on_cpu(self,
>>>>>>                       async_synic_update)
>>>>>> ...                                         [cpu hot-add]
>>>>>> process_queued_cpu_work()
>>>>>>   qemu_mutex_unlock_iothread()
>>>>>>                                             [grab BQL]
>>>>>>   start_exclusive()                         cpu_list_add()
>>>>>>   async_synic_update()                        finish_safe_work()
>>>>>>     qemu_mutex_lock_iothread()                  cpu_exec_start()
>>>>>>
>>>>>> ATM async_synic_update seems to be the only async safe work item that
>>>>>> grabs BQL.  However it isn't quite obvious that it shouldn't; in the
>>>>>> past there were more examples of this (e.g.
>>>>>> memory_region_do_invalidate_mmio_ptr).
>>>>>>
>>>>>> It looks like the problem is generally in the lack of the nesting rule
>>>>>> for cpu-exclusive sections against BQL, so I thought I would try to
>>>>>> address that.  This patchset is my feeble attempt at this; I'm not sure
>>>>>> I fully comprehend all the consequences (rather, I'm sure I don't) hence
>>>>>> RFC.
>>>>>
>>>>> Hmm I think this is an area touched by:
>>>>>
>>>>>   Subject: [PATCH v7 00/73] per-CPU locks
>>>>>   Date: Mon,  4 Mar 2019 13:17:00 -0500
>>>>>   Message-Id: <20190304181813.8075-1-cota@braap.org>
>>>>>
>>>>> which has stalled on it's path into the tree. Last time I checked it
>>>>> explicitly handled the concept of work that needed the BQL and work that
>>>>> didn't.
>>>>
>>>> I'm still trying to get my head around that patchset, but it looks like
>>>> it changes nothing in regards to cpu-exclusive sections and safe work,
>>>> so it doesn't make the problem go.
>>>>
>>>>> How do you trigger your deadlock? Just hot-pluging CPUs?
>>>>
>>>> Yes.  The window is pretty narrow so I only saw it once although this
>>>> test (where the vms are started and stopped and the cpus are plugged in
>>>> and out) is in our test loop for quite a bit (probably 2+ years).
>>>>
>>>> Roman.
>>>
>>> ping?
>>
>> ping?
> 
> ping?
> 

Queued for 4.2.

Paolo

