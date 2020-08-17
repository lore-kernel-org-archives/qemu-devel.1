Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D0A0C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 12:31:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26440204EA
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 12:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OYaUihDj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26440204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7eI1-0006dK-79
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 08:31:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37982)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k7eGy-00063k-LO
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 08:29:56 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37748)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k7eGx-0006jW-7C
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 08:29:56 -0400
Received: by mail-wr1-x443.google.com with SMTP id y3so14814124wrl.4
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 05:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=uIV7CxntYhYgdn6JQwo1h9fdpOtPzvirhuRJtzg5liY=;
 b=OYaUihDjc0/vHKBga2ryDyxIyQhhYwhp6JdjLYaBWDtVTMdAwltcWTvv4LFzYpF9mQ
 9YHprutOE8jJ2+zmEbPpDyuTHlSOewSZCBDtMO2XF4qILdzU1IEjdeSvbMlbyv68sqrq
 4HzOLuj5evvZGs+b3Zfwuj70RjveaCfUiti1QH4bre7bkXxupqB/BCBOxcyFjoKBAgYE
 /JutEXMkLBPlLlF91kDjP/HS/m0XiKNFPp2nlT4kcscLu3GhuOvRc1CqjiN4C61EafNm
 DipQbeGXa53/ooHGZjKlFSIAArZUk9P07aQjUmYCBaodahKSDrR1IdJjMF/E6uFPjcqk
 tQ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uIV7CxntYhYgdn6JQwo1h9fdpOtPzvirhuRJtzg5liY=;
 b=TiLNFjby//V1icpNwHsEM1VdQLLP/avL4UHzBltU2pKf0JUG8aEmDRzleC/kpxAt+e
 8IqYNR/EhMkgAUkWL4jBIiJVdL6t3l9bHP3uTfyYdfmfYt9hX2RGnfPHxsIJVHo9xykQ
 u01XerbkxEnYM5s1NY7LRAsQ339ljfFv3+X+IiDyozf1vMMSt7axNt4STZzJ6FYPm+kG
 bLStX6rVu+tf06ggXghAIGDoPcsgU2oFTMLLFTNWWMPwiYHP/q/xOk26VRlfpk1XprAI
 mM7JiVfgUXxh0nBiPhg8EzTa0S8ZWn2Ihgp02LrdlElU+zG4YzmOddkfXjmhq6kuk7wv
 9HgQ==
X-Gm-Message-State: AOAM530URuFuqIhEcd8BI5k7Jz1hySvPaCOnNDtYAHe+vTUiSO1BhdS7
 ixX1f7jFvhp3VV3F6Z8D3Jk=
X-Google-Smtp-Source: ABdhPJxvVM0a6UYeIt7fnjpg0aHIzMCqhzWtHlywFAPMTRLl1ApdFvlo3czUfQzUnGZ9y1BpSOTBEg==
X-Received: by 2002:a5d:5682:: with SMTP id f2mr14965252wrv.248.1597667393568; 
 Mon, 17 Aug 2020 05:29:53 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id j5sm30534870wmb.12.2020.08.17.05.29.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Aug 2020 05:29:52 -0700 (PDT)
Subject: Re: [PATCH] memory: Initialize MemoryRegionOps for RAM memory regions
To: P J P <ppandit@redhat.com>
References: <20200816182602.352-1-f4bug@amsat.org>
 <8e562b3d-ead5-b277-4791-66baecdebacb@amsat.org>
 <nycvar.YSQ.7.78.906.2008171643040.306228@xnncv>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c65970d7-9578-c1f9-eb6a-62c3765ef937@amsat.org>
Date: Mon, 17 Aug 2020 14:29:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <nycvar.YSQ.7.78.906.2008171643040.306228@xnncv>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/17/20 1:25 PM, P J P wrote:
> +-- On Mon, 17 Aug 2020, Philippe Mathieu-Daudé wrote --+
> | On 8/16/20 8:26 PM, Philippe Mathieu-Daudé wrote:
> | > There is an issue when using memory_region_dispatch_read() or
> | > memory_region_dispatch_write() on RAM memory regions.
> | > 
> | > RAM memory regions are initialized as:
> | > 
> | >   memory_region_init_ram()
> | >   -> memory_region_init_ram_nomigrate()
> | >      -> memory_region_init_ram_shared_nomigrate()
> | >         -> memory_region_init()
> | >            -> object_initialize(TYPE_MEMORY_REGION)
> | >               -> memory_region_initfn()
> | >                  -> mr->ops = &unassigned_mem_ops;
> | > 
> | > Later when accessing the alias, the memory_region_dispatch_read()
> | > flow is:
> | > 
> | >   memory_region_dispatch_read()
> | >   -> memory_region_dispatch_read1()
> | >      -> if (mr->ops->read) { ... }
> | >                    ^^^^^^
> | >                    NULL deref as unassigned_mem_ops.read is NULL.

[*]

> | > 
> | >   memory_region_dispatch_write()
> | >   -> if (mr->ops->write) { ... }
> | >                 ^^^^^^^
> | >                 NULL deref as unassigned_mem_ops.read is NULL.
> 
> * This check should pass/fail as normal I think. NULL dereference would happen 
>   on invoking mr->ops->read/write() call.
> 
> * When mr->ops->read/write==NULL, the dispatch_read/write function would go to 
>   the else section to call read/write_with_attrs()

Yes, this is where it crashes. The patch description (code flow)
is incorrect here and in [*].

I'll respin, thanks!

> 
>     const MemoryRegionOps unassigned_mem_ops = {                                    
>       .valid.accepts = unassigned_mem_accepts,                                    
>       .endianness = DEVICE_NATIVE_ENDIAN,                                         
>     };
> 
>   Maybe we define read/write_with_attrs in 'unassigned_mem_ops' above?
> 
> 
> | > Fix by initializing the MemoryRegionOps to ram_device_mem_ops,
> | > this way the memory accesses are properly dispatched using
> | > memory_region_ram_device_read() / memory_region_ram_device_write().
> | > 
> | > Fixes: 4a2e242bbb ("memory: Don't use memcpy for ram_device regions")
> 
> Yes, this should be fine too.
> 
> 
> Thank you.
> --
> Prasad J Pandit / Red Hat Product Security Team
> 8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D
> 

