Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C682DC433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 17:32:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2439025360
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 17:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xg1/ag60"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2439025360
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSO9b-00037d-OF
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 13:32:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40080)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kSO7t-0002ET-J3
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 13:30:17 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:35252)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kSO7r-0002CV-Hn
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 13:30:17 -0400
Received: by mail-pg1-x543.google.com with SMTP id g29so100612pgl.2
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 10:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=XSPSmD3UytWT5FhvCfXTAMKPVPvO6xsiuSDCACMxO6o=;
 b=Xg1/ag60zR8poSs/xhGZh6c3AUzsV1r6H7Wf0PWOvNQO+zSw83ojkUH4XzRGznhxkW
 8ScaRS7Ca9g0FqsNX24ogc0NxxcqAQoJzSJJ3gF/BCY4jp5E2nBgCnjQuV322ZfQAjCH
 ZcEI9b1+aGGP23YMKWY5lxl/hWSJaoKG74Dc8gEPtE75jauo8ZWyHfeARcKyckYigTuL
 9d6Yt2mIdEXFi7yflGAq6ze8VlcAS6N0nFGbAC+FmrNO15AIYbFgYvMLxgH9ol9Kj/RP
 S9NbvBNUVnaag2g1KSNK++beOAMlzELKMNRHHAg9jihZ6jK8DU/qms57G6jo5GOff4fJ
 q+iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XSPSmD3UytWT5FhvCfXTAMKPVPvO6xsiuSDCACMxO6o=;
 b=IMad2Wck2Q+Y3nXAT6bF6S/Fdtfe7D2/Y2ZRDxE6J1N8vv3hc1FFx1VpbAR5vl5g7T
 4kv5EP2jYyxS6reA0PN8obc4os4/eJerUN/0SHSPm8ECdcmKzT8KIzs3sNdMswIQmEyH
 ciDU8SEaATc2Rso8/bFsu/Qkog076pgOBgdGmdCpvqY/ERUFn2RbOKJwKIGlu/+1jpfD
 SybzTvr8YchnxpyaawhnnMhvEICmOznVTQ0xC8zNW/1qeSDaDu2o4dkGsofoWNyWAtpK
 GjfXGqIrIp6o2ZdIvwlEsnEIpwv/QxYiE6AmkXbrptEotBg+SFx3t15qJ/gGv5IDFCK8
 V2SA==
X-Gm-Message-State: AOAM5315pikKoS9pMWe8wTaWpXZ46rxirkmMkiFO8vsLr9gK6N6cdbof
 FGxQQ4IG+sEqMZj9mIE3C3ZhSflcZKiYBA==
X-Google-Smtp-Source: ABdhPJztLGgZ1Yn6oNLQ4ova69fftMTCKdafhNZ25lrt1N7VPFqKFPV4/GrqkRVVqPIWIQyYJCCwaQ==
X-Received: by 2002:a63:5c07:: with SMTP id q7mr536577pgb.222.1602610213410;
 Tue, 13 Oct 2020 10:30:13 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id y4sm266397pgs.0.2020.10.13.10.30.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2020 10:30:12 -0700 (PDT)
Subject: Re: [PATCH 07/10] target/arm: Implement v8.1M low-overhead-loop
 instructions
To: Peter Maydell <peter.maydell@linaro.org>
References: <20201012153746.9996-1-peter.maydell@linaro.org>
 <20201012153746.9996-8-peter.maydell@linaro.org>
 <CAFEAcA_MN4pzkWV65+2VtUgMdayf6pa-RCLXiomCsntF+38hNQ@mail.gmail.com>
 <9a06ae91-68e1-47a7-c6aa-19c1e2c47dda@linaro.org>
 <CAFEAcA_EHAsJTDV3JjriUC4rNj829LWCp9PNWScz+7uWFxxCGA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ceb80cfb-44ff-cca7-aae7-e4a4dbfabf0d@linaro.org>
Date: Tue, 13 Oct 2020 10:30:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_EHAsJTDV3JjriUC4rNj829LWCp9PNWScz+7uWFxxCGA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/13/20 10:12 AM, Peter Maydell wrote:
> On Tue, 13 Oct 2020 at 18:10, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> On 10/12/20 12:56 PM, Peter Maydell wrote:
>>> On Mon, 12 Oct 2020 at 16:37, Peter Maydell <peter.maydell@linaro.org> wrote:
>>> This turns out not to work, because gen_jmp() always generates
>>> a goto-tb for tb exit 0, and we hit the assert() that exit 0
>>> was not used twice. Here's a fixup to fold into this patch:
>>
>> Indeed.  I was going to suggest that here you should use arm_gen_condlabel()
>> like you did for LE.  Which I think would be still cleaner than your fixup patch.
> 
> I thought about that but it doesn't really fit, because
> the condlabel is for "go to the next instruction
> without having done anything". Here we need to do something
> on that codepath (unlike LE).

Ah, right.

Well, the only further comment is that, in the followup, only WLS gains the IT
block check.  While I understand that's required to avoid an abort in QEMU for
this case, all three of the insns have that case as CONSTRAINED UNPREDICTABLE.
 It might be worthwhile checking for IT in all of them, just to continue our
normal "unpredictable raises sigill, when easy" choice.


r~

