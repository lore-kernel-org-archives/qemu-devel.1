Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81115C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 18:28:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AA57207CD
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 18:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p/ZHrJg3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AA57207CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr3wK-0000WY-Il
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 14:28:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34070)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jr3uK-00075E-8Z
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 14:26:00 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:34796)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jr3uI-0000f7-LM
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 14:25:59 -0400
Received: by mail-pf1-x442.google.com with SMTP id u185so10846896pfu.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2020 11:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=R0F9AzACDlRgCm8azIawNDqSqrmfBUY9IiDl4PreWso=;
 b=p/ZHrJg3xaIdbA/KTUDwERlXl7Tm12BI6V1es92RYUY7dV+uV7uObyYVeUUAATqIbc
 BOYDyPuQiCDDtmGwQd9MmWxQKAzAfp7GpGkWxV5O4ewYAOFg4k07b0DjIW1kSrtN8CMq
 s1nJAuxv730sKHpMX3MtTbPcVF765B8vmscc0+LJpaka3C/HX+fcipqlxEQ9/zCTqD/o
 5i0dxK3ALYDYY42AEe0Kv2LyiYUDg35fvvA78BZ0didRqmkqqOLZRTTRb6UAQLb61E4F
 Ql0RDfAvnqhDfqorG46PNqmmytwE8Zvq9JvHBa7qlIiHClPFmL+imBC/Xkd4VbTWa+sm
 AOig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=R0F9AzACDlRgCm8azIawNDqSqrmfBUY9IiDl4PreWso=;
 b=KdhkK7i5MdivUu06gGlT/rMGWnm19ehPn5r/1B0B0YSjMgS3HXbMdzi7uWfEHWiLsX
 X9JAWVFuMIUp2reltqabFdbaNB2WQ5cAjxYfNAZOK2V/j1XrhbalYrY0yfgJ9ENuz4GH
 MdAG6QAKuX/V986ZaYZLBoH1hKuO3a8y+5m5PLuB8gcmdwn0rrQFniwa0YmRVFDivpiY
 occgoDIjNjDh8uuLKIvTvrQJNb26/dUiFNAaPRfrsRTc0p+B3aAqEwdBGhvO8O532iZi
 XzqQquahyZNemauy3sirpVA4vvn8lAFZiNXZvI4PfmgD97p6DgzE3slFV4Sjw0BfyCR/
 o0aA==
X-Gm-Message-State: AOAM533fFIec7ZisZe3VA62ba5fRdQlQUmy94rKbDjNs2feJijx+rYiX
 Q21cjpxVuwQ65tvULYgVGUsPMg==
X-Google-Smtp-Source: ABdhPJyfRbm1F5+eKPzCF0Uhf8kDo6gAjkAeqhA1YMcwg33Te+Tt7cLBWTAOiIEbx1W9DVophkT2Hw==
X-Received: by 2002:aa7:90c8:: with SMTP id k8mr12460491pfk.5.1593714356902;
 Thu, 02 Jul 2020 11:25:56 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id b24sm9470229pgn.8.2020.07.02.11.25.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2020 11:25:56 -0700 (PDT)
Subject: Re: [PATCH 2/3] target/nios2: in line the semantics of DISAS_UPDATE
 with other targets
From: Richard Henderson <richard.henderson@linaro.org>
To: Wentong Wu <wentong.wu@intel.com>, qemu-devel@nongnu.org
References: <20200629160535.3910-1-wentong.wu@intel.com>
 <20200629160535.3910-2-wentong.wu@intel.com>
 <5fbd61be-a4bc-a6e3-7b6b-1d542751650d@linaro.org>
Message-ID: <5c828158-86f4-971c-1193-e7f89942338c@linaro.org>
Date: Thu, 2 Jul 2020 11:25:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <5fbd61be-a4bc-a6e3-7b6b-1d542751650d@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, marex@denx.de, crwulff@gmail.com,
 peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/2/20 11:14 AM, Richard Henderson wrote:
> On 6/29/20 9:05 AM, Wentong Wu wrote:
>> In line the semantics of DISAS_UPDATE on nios2 target with other targets
>> which is to explicitly write the PC back into the cpu state before doing
>> a tcg_gen_exit_tb().
>>
>> Signed-off-by: Wentong Wu <wentong.wu@intel.com>
>> ---
>>  target/nios2/translate.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Or simply remove it as unused, now that you've replaced the existing users with
> DISAS_NORETURN.

Nevermind, you're using it in the next patch.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

