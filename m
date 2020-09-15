Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33AAC43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 20:53:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1751220771
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 20:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dF7CHAkz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1751220771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIHwj-0004t4-VE
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 16:53:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kIHvg-00046I-4t
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 16:51:56 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:42996)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kIHve-0006PH-1c
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 16:51:55 -0400
Received: by mail-pg1-x544.google.com with SMTP id k14so2616293pgi.9
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 13:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=54knxFfGr2vNzIjyA68twv7T9N8v2Y6Mav8bQQB0eVM=;
 b=dF7CHAkzfOx3+Zegyno5pwpzNfyKEHcBm5rJQ/4rW6Mjji11RIkHqEJShXte9tWcrc
 dFQnTRMZNZOEOdHhG0Lod69HXWuiqc8AWxM7gKGsmwcoyEMZbxypvlvGoGLpRp5sx3NP
 JPFd7lMfpb0TBAe+MYWwbIxlO5ZIAPVZW73h/2XTk1kT2vpcc1aKmHzLvT2vx0WlFJ4d
 mXNNRwI0N29IU4MoZFo9TUARIwmr2E+6Opcuhft5MyJsnR3hBO1Xy+EzjffR8kZpqrIL
 iRVoSHaFN18rLZBDyb43ImFzokc6UGts39kJQmBizpvviHpzMAHVY8U29VP+sGULq97Z
 wQDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=54knxFfGr2vNzIjyA68twv7T9N8v2Y6Mav8bQQB0eVM=;
 b=Oo6m+jgfEglp7Q5KAq1lY84DxzmsJpQaJQpW4LfCLXy7A/2QqW+MRpLA2YZH3JV2Ab
 WxHp/BJdyCK/cNyrw0wmxqANauv5MdIrIgA4KQfxuyADj2Rw4OpXjvmkig9F4kDIJbKJ
 j3C75K1fYFypLTDlZJl5rzoSNmRo8U//6Ls7hv/XY5tQP7fGgtV0HZagplVy1VmzZYQU
 HioDuJ+pzkFDzuAMVcqApK81XJ4kx9IhfYf0YATfUo3OMm5m6nvRDl7atLuC5hNSRdw1
 pIHd3EDMC2FYmMq3bHG5z0QcrKgyBU8LqixlB+Rby7zLhhwrMAFLHzmpg/CL5z8RSchv
 wJGQ==
X-Gm-Message-State: AOAM532riXNq91I8TgwPyOi0VUr809yi3zGbV7AHzCf2X/oNTwWd51lp
 Uysi8ggNVym1iT6qQ0vKpvaC5g==
X-Google-Smtp-Source: ABdhPJzI9GuhsoApHII13KLDLFWyklxbMiyWK20jjz0E9M1wPKwu+bIsvMhcJPBx/N0lMupaDkxfJw==
X-Received: by 2002:aa7:9850:0:b029:142:2501:34f0 with SMTP id
 n16-20020aa798500000b0290142250134f0mr3488691pfq.73.1600203112584; 
 Tue, 15 Sep 2020 13:51:52 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id s8sm370781pjm.7.2020.09.15.13.51.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Sep 2020 13:51:50 -0700 (PDT)
Subject: Re: [PATCH 1/5] qom: Allow objects to be allocated with increased
 alignment
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20200915174635.2333553-1-richard.henderson@linaro.org>
 <20200915174635.2333553-2-richard.henderson@linaro.org>
 <20200915180736.GB7594@habkost.net>
 <6d6a80bf-a542-6818-1638-0318f4aab336@linaro.org>
 <20200915201901.GD7594@habkost.net>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <74c1e091-63c4-9ea0-c515-ad977ffa1d98@linaro.org>
Date: Tue, 15 Sep 2020 13:51:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200915201901.GD7594@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/15/20 1:19 PM, Eduardo Habkost wrote:
> Once we move to C11, we can just use max_align_t.

Yes.

> While we don't move to C11, why not just use
>   __alignof__(union { long l; void *p; double d; long double ld;})
> ?

For i386, this is 4.


r~

