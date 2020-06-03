Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C356C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 16:26:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4709C20659
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 16:26:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IpsGYu4L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4709C20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgWDa-0004ws-FN
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 12:26:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46864)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgW9C-00070Q-2I
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 12:21:46 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d]:35001)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgW9B-0005qc-4Z
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 12:21:45 -0400
Received: by mail-pg1-x52d.google.com with SMTP id o6so2108322pgh.2
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2020 09:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=msmLFa3O+w7t96a3nOWC8TF3c0RLdvg1TLuU9z9XynE=;
 b=IpsGYu4LkRRbavjuxO/67eEiW2+2+UQR2hFFSw58LWF8lLK3WLCekuZcLY7XzrdLqi
 V7PaGZRoXhKqbBcU9iCIVgNY89acIyRYvSTAp0QLl0rqzJ7bAEhAakhOFjjp/7vMgOgH
 6uJ8MSAnLvMe1v2BXODkG+UpCu4AvJ/mpvegwaVeIKEWAAGWbSWpVdX5HyKEcvw1q4Gm
 HGJ6DP9e3OPvNV0bm4CuhrVPPiLgvR2e42Sh97uQCiA+6cbb+11GGCQelIIRewuQJ9co
 BVAhQ7XJtoA56cSmrCoSeo460PGzFFAKwtXy8cqnNHe+rLaoVbZZSJpGpYlGQxw6FK+A
 uByw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=msmLFa3O+w7t96a3nOWC8TF3c0RLdvg1TLuU9z9XynE=;
 b=V2ou/C5EHV4pwGg75ZG4Swk96Cv93kW9HIjKFx3VBiQj/xFFk2hRO6gmJ2o2GI/gdp
 gh25UGkclL9m+2ve6KppUygn2Pmo7yNOLU4Ai3QMGVc6gkXJ/pbM/lYJRDGIb/1YzNb0
 9tXyFFt/s3hSAcCU0kkT8EKMXMeavc15ec/CH3lo8Oh6RE/099iNPr61hGFvEytfb8Nn
 18C1NpFs2Olk8G6PVv75SE1mx8ae9KCr+zYooi9KxgeQXgBjOyiFWtsbkBUN2ZYwJ+VJ
 N34KK6AQiiGqOecCPmliJ6X+TB++C6ZAyDsrEaR5hX20slb72FJe9brK++dyEpiLfQLW
 yfdw==
X-Gm-Message-State: AOAM532Yt2x95I+1FWuIvxahAWdADg8stRGwhQNo80W3D0ttA/cFq5y8
 vBxFDIy8xQzQ0DygN/5tg3+bfA==
X-Google-Smtp-Source: ABdhPJwtWTpa8k+i0dZgo2J2WXhpr57ql4qPrALHfIfnaf4NgAJb9BDAaUrJm7GCcQoHO0W6bwoSGQ==
X-Received: by 2002:a62:b402:: with SMTP id h2mr32230980pfn.221.1591201303590; 
 Wed, 03 Jun 2020 09:21:43 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id d5sm259555pju.4.2020.06.03.09.21.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jun 2020 09:21:42 -0700 (PDT)
Subject: Re: another tst-arm-mte bug: qemu-system segfaults
To: Szabolcs Nagy <szabolcs.nagy@arm.com>
References: <20200529120427.GB18623@arm.com>
 <9aa721e6-e72f-20bc-73b4-19fc3f493241@linaro.org>
 <20200603135053.GD21536@arm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7ca0e091-7797-12cd-0c6f-41e453580e0a@linaro.org>
Date: Wed, 3 Jun 2020 09:21:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200603135053.GD21536@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: nd@arm.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/3/20 6:50 AM, Szabolcs Nagy wrote:
> thanks my tests now get further but later i run into
> the previous assert failure:
> 
> target/arm/mte_helper.c:97:allocation_tag_mem: assertion failed: (tag_size <= in_page)
> 
> i might be able to reduce it to a small reproducer
> this time. i assume that will help.

Dang, I had hoped that the one fix would cover both -- it's definitely in the
same area.  Yes, a small reproducer will help, but I will also try again with
your larger reproducer.


r~

