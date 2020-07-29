Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1859AC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 16:17:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7EB720FC3
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 16:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="grnUCQaU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7EB720FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0olZ-0000pE-66
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 12:17:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59652)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k0okq-0008OL-AZ
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 12:16:32 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633]:33205)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k0oko-0002wA-DV
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 12:16:32 -0400
Received: by mail-pl1-x633.google.com with SMTP id t1so2835573plq.0
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2020 09:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=4hc3JYlfYRuTekA1+45Qru5wtycQt4iBSasxfWwHmII=;
 b=grnUCQaU+nUvWYTVKpKx/a1Qkmeeq+U8G/LVezL+YBSrBueOoeujcFDO0eHLgAMWpN
 PaLzYoV9q6zRknSer42vyDySxpyA3KcIta2g44KC1HmY7c1b0LwjcTSHM+OgMFQHxU5b
 dsE26Oxne+XDA1SIMovCltveMkrbTmuuLkZtS8M7CFQMa5oZwX0Z/pHy8KPDeMX3xFq0
 4j0GCk8mvipyqe3QLygI4QhNOmCfsEKUMN6gbqO/mOk6OqEYwDCfK9oXZxkgp9sdLq1t
 T/1DYsWSv/4yJ/5b+TXWhWq3CchwF/Ij5Bor7SD9oLJB2uLN1H6TQwq8n8XTYO3ZWCCj
 JeaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4hc3JYlfYRuTekA1+45Qru5wtycQt4iBSasxfWwHmII=;
 b=cZxqW2SlDTR6G2fN8QIRILWGmvJltisDnTMhTrvft0K/xLoAfmWtYbIh/LD9B2qTYq
 PMjIM7/Z18ono1SrceA8akUsgLMDhcPGK8UPC6udjSMnfovxWQBeOLKVE1ePvD4NLzvr
 COGqPOagr9bDmztPC+Ptw3W+LclbMMbLHRlXn8LKfL+Zhc9nygaQv9Ff38KLZeuCQPBT
 m1JFSHAL5o8jCMFl2H7ij+HNqzpxaiAHr0yDoSacmFJvzfog2dEz2eWEdyXNjg8B4Xes
 SZYCbXsfGTibJUtdUF95XZnxtiiPCK4vaFP6WZtYe4ARemzfuv/4tQlQ7PdY8OL6EpIi
 0u2A==
X-Gm-Message-State: AOAM5337tQsqePsCPUnrgueq/9zGTWUfI7q2xQksNTkUqvOme2MzMNzz
 aWv7m+r2zBRAG6E7ggDC/vSymJfzbbg=
X-Google-Smtp-Source: ABdhPJyGt1+PDNfj1N/wB7KEaARgloXXW0Il+b7fhjIsMeooVLBysdRmEHDHUosooz9Jpb1DMFBxvA==
X-Received: by 2002:a17:902:9b82:: with SMTP id
 y2mr21794785plp.314.1596039388208; 
 Wed, 29 Jul 2020 09:16:28 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id ml8sm2600408pjb.47.2020.07.29.09.16.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jul 2020 09:16:27 -0700 (PDT)
Subject: Re: What this mean "dead: 1" and "dead: 0 1" on each tb block start?
To: tugouxp <13824125580@163.com>, qemu-devel@nongnu.org
References: <6807386b.7ba3.1739af8fc12.Coremail.13824125580@163.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a21310ca-b637-5d6e-bfe8-e7834b2498bc@linaro.org>
Date: Wed, 29 Jul 2020 09:16:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <6807386b.7ba3.1739af8fc12.Coremail.13824125580@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/29/20 7:27 AM, tugouxp wrote:
> HI folks:
>   on each tb block start, there are following ir code, and the most confusing
> me is that  the postfix of each line "dead:" flag, what it is represent precisely?
> i guess it may be related to the register or varible liveness for help
> generating tghe target machine code, but i cant get the precisely connection of
> the dead attrribute with qemu  internal varibles.
> for example, why the line 61 use "dead:1" and the line 63 use "dead: 0, 1"? 
> what is the precisely meaning of the number after the "dead:" word?
> 
> thank you!     
> 
> 
>     60 OP after optimization and liveness analysis:
> 
>      61  ld_i32 tmp5,env,$0xffffffffffffffec                 dead: 1
> 
>      62  movi_i32 tmp6,$0x0
> 
>      63  brcond_i32 tmp5,tmp6,lt,$L0                      dead: 0 1

The numbers are the index of the argument that is dead.

E.g. here, both tmp5 and tmp6 are dead.


r~

