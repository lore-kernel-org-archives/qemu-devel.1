Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41BA1C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 01:45:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B78A206B6
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 01:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m/bJhMVz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B78A206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1junXE-0005NP-BC
	for qemu-devel@archiver.kernel.org; Sun, 12 Jul 2020 21:45:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59118)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1junWV-0004pe-4Q
 for qemu-devel@nongnu.org; Sun, 12 Jul 2020 21:44:51 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:39012)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1junWS-0004kM-P7
 for qemu-devel@nongnu.org; Sun, 12 Jul 2020 21:44:50 -0400
Received: by mail-pj1-x1043.google.com with SMTP id b92so5408646pjc.4
 for <qemu-devel@nongnu.org>; Sun, 12 Jul 2020 18:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=0LpMcHYGe3bGLl/q8DNXv2WZvgyqHk5ZJvsjH53l/P0=;
 b=m/bJhMVz/rCb1obA3PRSsjZjY3yuTRy4eAnWI7sAHA3T94IPv9AXtcJh9EoEGMfYna
 wJu4DPM17boMXVeHY61oM1Pm39TqapCWgVrAWsadZxxH4Nta8W34+OGLceKiODBr0vG4
 Pxgci77HgNImuyTXrRJXd0YlF5bjGFmtiQB9M1ojmqZK32fKMKocbu9XWIi7Mi/iVCg8
 fc+vdtTUGnv3RP2o2T1LGdg7Unf4fd9u4LD/eN1yUd5TT6ejr+OLHiU/FDovhO66hX9X
 Z9YrdqK+Nxuyku8vUSmxjBs0CrWzlSvKlYtHk7xFjNYvtBtcUGt51jSRXGVs63CDoigc
 4uwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0LpMcHYGe3bGLl/q8DNXv2WZvgyqHk5ZJvsjH53l/P0=;
 b=THeVfrB0lJxV5AWEV9A8CLF6mJ02E4T3luroJbCad25kLJoPeiA7geBxky/rA0UjVd
 1lPvagW6nyFkFhmByFsmBUcfrSXCXXJ2gsN9RqUqavNSStPE2iA9FO6/ZEdshL9hs/8O
 Q1YmGPgir51kfZSbSq1uvf03M2JdGbaSkAn6D/vHAIipTpbAxr7LTAkNCKAoglxNSGod
 4sME4jlRq/tqLdUuFXGn/qlJZHaA7l226z7nIVy66+MGOq3NQSawFBjlVgBC0MBQQcwF
 r2dsL2iirZasL7YDgcaffjIA8t//HnFau8DmYYAm2+zdrAaMhkSd9nhthtrn2jIo/jOk
 71wQ==
X-Gm-Message-State: AOAM533CN1FvyNwgdPTU4owJjv3di7T/tzoULNvMTE8d14mF1TMdbMA1
 UvPELMt+s+RnDDFBSZMKZLfXAw==
X-Google-Smtp-Source: ABdhPJza/YWVRxfqrXLOD2ZekFbU4LiXMhiOkrWkNBeopLkB9Wnl0nwHNYVr42Fj1pQQ2jRswd5zHg==
X-Received: by 2002:a17:90a:ff03:: with SMTP id
 ce3mr18748386pjb.174.1594604687048; 
 Sun, 12 Jul 2020 18:44:47 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id o18sm14034098pfu.138.2020.07.12.18.44.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Jul 2020 18:44:45 -0700 (PDT)
Subject: Re: [PATCH v2 01/17] tcg: Introduce target-specific page data for
 user-only
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200605041733.415188-1-richard.henderson@linaro.org>
 <20200605041733.415188-2-richard.henderson@linaro.org>
 <CAFEAcA-qybDD6GWYPFB6tMfTb9Kj+_bCKCxPyDYMZBr8EwbDmQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2b7b64a7-2aaf-7886-bbf4-1d228a7199e1@linaro.org>
Date: Sun, 12 Jul 2020 18:44:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-qybDD6GWYPFB6tMfTb9Kj+_bCKCxPyDYMZBr8EwbDmQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1043.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Stephen Long <steplong@quicinc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/25/20 9:20 AM, Peter Maydell wrote:
> On Fri, 5 Jun 2020 at 05:17, Richard Henderson
>> @@ -787,9 +788,11 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
>>          new_addr = -1;
>>      } else {
>>          new_addr = h2g(host_addr);
>> +        /* FIXME: Move page flags and target_data for each page.  */
> 
> Is this something we're going to address later in the patchset?

I've removed the comment.

The mremap system call is not as general as I think it should be.  It only
applies to MAP_SHARED vmas and returns EINVAL on MAP_PRIVATE.  Therefore, at
least for the MTE usage of target_data, there cannot be any.


r~

