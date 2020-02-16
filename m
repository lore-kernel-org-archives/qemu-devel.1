Return-Path: <SRS0=HvqS=4E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF2F5C7114E
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 02:11:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9ACDE2073A
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 02:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xiUqFtGG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ACDE2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j39PE-0001OS-RV
	for qemu-devel@archiver.kernel.org; Sat, 15 Feb 2020 21:11:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43592)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j39Oe-0000xE-Bv
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 21:11:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j39Od-0002Dj-9t
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 21:11:00 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:42882)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j39Od-0002Bw-3o
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 21:10:59 -0500
Received: by mail-pl1-x643.google.com with SMTP id e8so5320794plt.9
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2020 18:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=7haIZfiglQjX1FP1IwV/ny22AQfB6gkoeqeP1wUX2CY=;
 b=xiUqFtGG2pXnjYJs6H993yjbWRYX+QvUrzelVu9MJ+QyigKzDJQGOq2cAwIxYLkllp
 LFRu006nzpTGRjfNIoUywY1Q62+FHAy2FujD68lVh7gwCqxOq0FG64GTFv9/qFVS1Rtn
 va9soqP1dl2BsyzUvcqNjSt20a8mpj8MqlNGuZk9sLRNbUsOXCQzN8B6FDtlJbTQ0aqz
 4J0wTPGUwxIRWaOS6KPlouAYuYkCRqQwgLVEOLPkyeDwzYcQ1xALnJxEtHTTZRNkhpm6
 aImVdpvDJr/qSf9zniPCZ9onKbACwAUonZfKOWnFX+KIjnRGhQfSm0hr6cQ9IjQueqeV
 DDEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7haIZfiglQjX1FP1IwV/ny22AQfB6gkoeqeP1wUX2CY=;
 b=KgYl9vK5cUGw7xo8NRNKt+54yDdx+1rqFvirelrYDwrYU+1bP3GlhreEXKHhXAqPR6
 3gBeeh9UOeJ/tskbEWcnRYD3Lp5LG0da3kcQfg25rilwet7eww48IrrdT5oVdRf0OYN4
 CC4Nm5mA2OdK5Q1QONpOJym6wGWZFUwOC7gU6RVx6WkELgcc/z6YD08YiHd5I8cHkI5u
 Gl1yDP5PRVKXmx8dVFaPoTUgkSJwVEBRxEMTTFnpJKcgnEIPMq2/pyxk33Wnu9iRsO/5
 thtoQlwwWExiFMPuxkaNQ6/nKSqMqTP0SwkonHO73pfYtozMQBAzhIc5m0b+gj7EQBtZ
 KCNQ==
X-Gm-Message-State: APjAAAURD0sTMK20z0uZgjO7DKJ+ckXtH5Iqjm5M+Q6qWce12+/F5cq9
 6wbWCg6PWJKkNRayvMfx99MJDQ==
X-Google-Smtp-Source: APXvYqyN7J9TUq3ipOs7lhoRQWrE497B4AgRfxZmIkWuYh2OXQOe2mt7QbcM/BKOAgjl9vBnj30PcQ==
X-Received: by 2002:a17:90a:5801:: with SMTP id
 h1mr12322313pji.121.1581819057786; 
 Sat, 15 Feb 2020 18:10:57 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 y76sm11959202pfc.87.2020.02.15.18.10.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 15 Feb 2020 18:10:57 -0800 (PST)
Subject: Re: [PATCH 0/2] hw: Delay timer_new() from init to realize to avoid
 memleaks
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200215154706.19837-1-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9841b68f-515e-21e5-3ca4-4025c9161674@linaro.org>
Date: Sat, 15 Feb 2020 18:10:54 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200215154706.19837-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
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
Cc: Pan Nengyuan <pannengyuan@huawei.com>, Corey Minyard <minyard@acm.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/15/20 7:47 AM, Philippe Mathieu-Daudé wrote:
> Philippe Mathieu-Daudé (2):
>   hw/ipmi/bmc: Delay timer_new_ns() from init to realize to avoid
>     memleaks
>   hw/sd/sd: Delay timer_new_ns() from init to realize to avoid memleaks

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

