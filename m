Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC62BC2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 16:59:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00FAC20BED
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 16:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOsPqxjq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00FAC20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL871-0005uP-3q
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 12:59:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33378)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kL85K-0004UQ-Lr; Wed, 23 Sep 2020 12:57:38 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:34367)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kL85J-000650-7m; Wed, 23 Sep 2020 12:57:38 -0400
Received: by mail-wm1-x341.google.com with SMTP id l15so4951196wmh.1;
 Wed, 23 Sep 2020 09:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=eTOwXgcDvf0qJPusx8+dn0NqJdcIT1vyPwxo//UMpeU=;
 b=iOsPqxjq6yhExkvFp0zLC0Pp5DvwnvJPxdvOdXm1QTB17AT5WrEDLc6jdFIavEPQ8P
 q8BtHC7SyhqjHo536L/v/WZbrR1FbUdpjv2rs4A5b9pWPorNdNZ7JUX4agHQdGCjTdyN
 +1TZazAu7hjt5dKVAl3N3ZG8doNpOz0Ng/liRjl9exUMBVjJnaSLwbh9+w2cKUmZVXYt
 89jRpabnC4o7IPULuoeYYunaLONKw8L4GklZ2x1svtGfDodRzoVDzOGHa5EcMPaUsd44
 pRGmRBtmmIB0mNJf6bP/jVmOjijR9AF8flKEiSfjdqef0ebjob8He4f6pfUiEeWjJRx3
 zDIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eTOwXgcDvf0qJPusx8+dn0NqJdcIT1vyPwxo//UMpeU=;
 b=P3XVMcW+uATzMUX/smCxHOhd/D1YpEIFRHtb4oWjTM+uBsODvoYh9gocrQn7yZe+Eg
 MuLQ6Ufmd+EY7qJrqBppiVxcITdQfnFOyCneMT7rdc3nBVk5ZErIjp7gX8yLD/2xUf5Q
 7AT2Dg6GphnL/ouwwUneu3hJG5QFzcW5ZGQ2EBX4StJuozAPiBaHXaKI1YZaQdW9DNkx
 itRdeprAwlhnTpDZHPm6b/Uf5+ZtP6WB62Tke4MHM9hLjD72IJepa2Q5Lp4B3p0yCquI
 vKj5qSvi3i0oimejTFujEys8hmmGFeYAevAKGug+O9+jxLiPp8VurO+vewX46mT/ctLC
 qNkQ==
X-Gm-Message-State: AOAM532kQLf283nxHBbr12gfPvqP5/TPR372PVe10akjMkwai9S4lDHN
 KRDV+M40dkVP4TTUj1tYRNc=
X-Google-Smtp-Source: ABdhPJwMTR0YKsbCfqrf891xH0g+aAIN6MbgCzqHCBBkAje4TdSNsaI7Vw1bsdpXCcINjLrcQBH4lg==
X-Received: by 2002:a1c:e904:: with SMTP id q4mr480668wmc.151.1600880254818;
 Wed, 23 Sep 2020 09:57:34 -0700 (PDT)
Received: from [192.168.1.34] (234.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.234])
 by smtp.gmail.com with ESMTPSA id a81sm416099wmf.32.2020.09.23.09.57.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2020 09:57:33 -0700 (PDT)
Subject: Re: [PATCH 3/7] hw/ide/core: Replace magic '512' value by
 BDRV_SECTOR_SIZE
To: John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>
References: <20200814082841.27000-1-f4bug@amsat.org>
 <20200814082841.27000-4-f4bug@amsat.org>
 <20200817111745.GG11402@linux.fritz.box>
 <2347d8f7-5632-f7a4-6b81-bee179241da4@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c5669c37-6727-89fd-a68f-518e56f39884@amsat.org>
Date: Wed, 23 Sep 2020 18:57:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <2347d8f7-5632-f7a4-6b81-bee179241da4@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/23/20 4:53 PM, John Snow wrote:
> On 8/17/20 7:17 AM, Kevin Wolf wrote:
>> Am 14.08.2020 um 10:28 hat Philippe Mathieu-Daudé geschrieben:
>>> Use self-explicit definitions instead of magic '512' value.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>
>> BDRV_SECTOR_SIZE is the arbitrary unit in which some block layer
>> functions and variables work (such as bs->total_sectors). It happens to
>> be 512.
>>
>> IDE disks have a sector size, too. Actually, two of them, a physical and
>> a logical one. The more important one is the logical one. We happen to
>> emulate only IDE devices for which the logical block size is 512 bytes
>> (ide_dev_initfn() errors out otherwise).
>>
>> But just because two constants both happen to be 512 in practice, they
>> are not the same thing.
>>
>> So if we want to replace all magic 512 values, we should probably
>> introduce a new IDE_SECTOR_SIZE and then decide case by case whether
>> IDE_SECTOR_SIZE or BDRV_SECTOR_SIZE is meant. I think most (if not all)
>> of the places you converted in this patch need to be IDE_SECTOR_SIZE.
>>
>> Kevin
>>
> 
> I didn't audit the other patches, but be mindful of the distinction that
> Kevin is pointing out.
> 
> Luckily, I think we're low risk for deciding to change the
> BDRV_SECTOR_SIZE default any time soon, so it probably won't matter in
> the near future ...

TBO my only concern was code readability while reviewing
(improve code readability).

I'll address Kevin's review comment at some point, but this is
a low priority.

Thanks both for having a look,

Phil.

> 
> --js
> 
> 

