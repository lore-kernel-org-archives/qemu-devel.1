Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLACK,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBADBC76195
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 01:24:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB8DE2184E
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 01:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="vqeyhdo5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB8DE2184E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoHd5-0001mr-V0
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 21:24:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50742)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aik@ozlabs.ru>) id 1hoHcu-0001I9-1F
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 21:24:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>) id 1hoHcs-000674-On
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 21:23:59 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:33320)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1hoHcs-00065L-9J
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 21:23:58 -0400
Received: by mail-pg1-x543.google.com with SMTP id f20so4452964pgj.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2019 18:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=qeox4bKzV5gxE9dMe33nfFYK+aoKO+4Q9N7ATVZrcbc=;
 b=vqeyhdo5zsKS6/JfapfM+Fxz9oyC0bnlUsy1jMn+wMrL4f8ZWr2JRnx0Hn+RqlU85c
 +SEcOHG0p5yQLNQM+EA+xUbnXQnqNqjzvcUsSGFL7PmmnPht5ej4CEq6QUeRM53wX0aT
 Hr/AcAab/JTZocqRWYmNeY3N7cNv0L/zXvynKyM0SA8iND2KisC5h/JoFqT5tlaANeVA
 VO5YgLG80ODTouQVcCoXzRDYeN3vRd4zol+1o3ePHdbmnV+vGXR+Jet2GbLgRzP3OQ0d
 vsU+34ZOX9PqfhkDVqf5NlyCbDi1UURLItGePQ1LPWE0tjbeV2bovr9dP2S5rmVbYFi8
 vlNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qeox4bKzV5gxE9dMe33nfFYK+aoKO+4Q9N7ATVZrcbc=;
 b=HO4530v+EhDKLGwLz4NiY5aJcKV5naICZgEW2Smivdte+24djw34rL7nFfFMEdHYFW
 K0XHjNiFAJQPgBvW70dndCn04omDKPbcxUFHd0wHPJ56g4kUIoxOTf3stZQA+zp0QoAJ
 SF993bjoi/EFT5auVbM+nxzoQFB/Yn3iHH4gwWlrODgUwjukx8kCKyZVHB7zJDptr5iK
 pqxYPNNvmMxVgytb88hcDfndlbju5uXUGiRKxBhxXLd8EIQGPkW6ctq92vimWfWasOiT
 MZ06TpomO7eJaZGMuJnWMSUQpkICCQq4/fcPmAjkD4jDDWEkb634Kt8kQ9wAuVmHgvZ9
 BlCQ==
X-Gm-Message-State: APjAAAVAoCqfv1kcB87iPMi8lcu9WgJLuPf4Fw4TMz5Rpe/9fu/cBEPF
 YxKk8LXtf27fEyz1PdlozNU=
X-Google-Smtp-Source: APXvYqxGUSYXWuQCMY6wd5FgWwrb01V3BlTLTT5e4UGOXDsi/6HGGf8NApBsfqrmk4KAYiN9uAbdMg==
X-Received: by 2002:a65:4841:: with SMTP id i1mr50656317pgs.316.1563499435964; 
 Thu, 18 Jul 2019 18:23:55 -0700 (PDT)
Received: from [10.61.2.175] ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id 143sm45374927pgc.6.2019.07.18.18.23.53
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 18 Jul 2019 18:23:55 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, Greg Kurz <groug@kaod.org>
References: <20190716053522.78813-1-aik@ozlabs.ru>
 <8b727864-1634-0a5d-c557-fcaa52c49434@redhat.com>
 <9587706e-d53c-5490-cb4a-4c89eadfc497@ozlabs.ru>
 <20190718124042.4dd7b132@bahia.lab.toulouse-stg.fr.ibm.com>
 <8ed62115-29a2-c742-f309-0eb92a159803@redhat.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <32ff3964-977e-8023-9a3b-529710ae054b@ozlabs.ru>
Date: Fri, 19 Jul 2019 11:23:51 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <8ed62115-29a2-c742-f309-0eb92a159803@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: Re: [Qemu-devel] [Qemu-ppc] [RFC PATCH qemu] spapr: Stop providing
 RTAS blob
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 18/07/2019 20:49, Thomas Huth wrote:
> On 18/07/2019 12.40, Greg Kurz wrote:
>> On Thu, 18 Jul 2019 17:55:12 +1000
>> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>>
>>>
>>>
>>> On 18/07/2019 17:20, Thomas Huth wrote:
>>>> On 16/07/2019 07.35, Alexey Kardashevskiy wrote:
>>>>> SLOF implements one itself so let's remove it from QEMU. It is one less
>>>>> image and simpler setup as the RTAS blob never stays in its initial place
>>>>> anyway as the guest OS always decides where to put it.
>>>>>
>>>>> This totally depends on https://patchwork.ozlabs.org/patch/1132440/ ,
>>>>> hence RFC.
>>>>
>>>> Patch looks basically fine for me, but I wonder whether we should wait
>>>> for one or two releases until we really remove it from QEMU, so that it
>>>> is still possible to test the latest QEMU with older SLOF releases for a
>>>> while (which is sometimes useful when hunting bugs). Or should this
>>>> maybe even go through the official deprecation process (i.e. with an
>>>> entry in qemu-deprecated.texi)?
>>>
>>> I worry more about slof being distributed as a separate package in RHEL,
>>> easy enough to get qemu/slof out of sync.
>>>
>>
>> Then it seems to call for keeping the code around in QEMU in case RHEL's
>> slof doesn't implement the RTAS blob. Following the official deprecation
>> process looks like a good option IMHO.
> 
> We can of course make the qemu rpm depend on the new SLOF rpm, so that
> you can not install an older SLOF with a newer QEMU.

Cool, let's do that.

> But anyway, to avoid confusion and ease debugging,

There is a little confusion ("why did the guest stop after Device tree 
struct  0x000000000aff0000 -> 0x000000000b000000") and what will make 
the debugging harder if we drop rtas from qemu now? I think I should 
have known the answer by now but I do not :)

> I'd also rather vote
> for the official deprecation process here, and remove the RTAS blob from
> QEMU after the official deprecation period.

We won't be able to enjoy one less binary for another year and we 
already have bugs fixes for which would benefit from not having rtas blob.



-- 
Alexey

