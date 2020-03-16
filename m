Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C19C6C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 05:43:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8270E20575
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 05:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D/xuOeXO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8270E20575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDiWv-0003uD-DC
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 01:43:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47690)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jDiRf-0002lY-Vv
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 01:37:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jDiRe-0001u3-Tc
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 01:37:47 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:37304)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jDiRe-0001lS-Hr
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 01:37:46 -0400
Received: by mail-pj1-x1044.google.com with SMTP id ca13so8008179pjb.2
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2020 22:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=wHQbRCcrZooGQjPfZvSuW/YlzcO/8aET315u1MTxBDc=;
 b=D/xuOeXO1ajklzFyOR4shshZnSSvI+DOghB5YKneKN7bjxdgCnail309bRGcTqUn8/
 h5zxKjPy45Lq3OFUBGwEa4iflllTayJ/FZKH/1AmnOCCsHTZCtJyRvZVkEcEC6LR1QpO
 9EX3eDO2S28HqD9PTg0rS+97LB1EFNp+bOjYzRiiwRTQluib235jtHrkFV+3MWvIW/49
 UYf5DAWcE/jERomr3ODCkXHw9WW9NEUbZCNMdxq/L6trGVAzSs94jcZ1kFmjZ+1Lf7Ad
 kVoKW1z+WrwDNh/Ew3gpavEuXOhDs3BmR42GGXOD9aCBlucREWRrSU1AnwRtP4kiBuqN
 WMMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wHQbRCcrZooGQjPfZvSuW/YlzcO/8aET315u1MTxBDc=;
 b=h0GioYCUTV+AxaiKD9HtDIXURdGHHM4pJPJuPfbimTB3aKAXxmOVkiVJAQnHlGSMcf
 Qcl1XlmEBQOVqtwXsETVFtpaYODjmOOUi2HDQPaRTwPDSWuyiAFcwrWwCgssItcJaUbV
 qv49Wk5HlpF/+4qYrp7VoyP1TVe5ry5IHL7JyWO2uwLgV26BmQga7SnApP42O4nt5F6i
 p99NYNOGa/F7mwcCmjl+xT24oJELSt6B+NY+nJLaFoDiV5IABGbDFJDpC6T9etCz8gAe
 KiKvNyij5/+sdcOQgXfOTD/sYo7D8Hq8q2oRib0VFZpR8SbWUHkM3PkI/2t2uuOHWVzH
 PIkw==
X-Gm-Message-State: ANhLgQ06eIVseqV7Y0d/NAPIsKOnk5K3Av0K9AkmhbAEYu/kq8PQhEyX
 mkO7nD++hNo2aZvS5gPdwH/Zgg==
X-Google-Smtp-Source: ADFU+vtQYgdfmGMkYCnurc7CviycWGomp4PCxdMDmHac0nA9jQ1jlR3w6YNvqhj2HTcks5Z3Zu/HLw==
X-Received: by 2002:a17:90a:bd0e:: with SMTP id
 y14mr24085257pjr.11.1584337065399; 
 Sun, 15 Mar 2020 22:37:45 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 o128sm32222890pfg.5.2020.03.15.22.37.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Mar 2020 22:37:44 -0700 (PDT)
Subject: Re: [PATCH v5 40/60] target/riscv: vector floating-point merge
 instructions
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
 <20200312145900.2054-41-zhiwei_liu@c-sky.com>
 <37215373-eead-9185-faf9-f2ebc0cb4193@linaro.org>
 <ef0a9b7e-65c4-93e7-61b6-b288afa1c13a@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9658fd30-c8fb-0ca2-4bd1-75b849269179@linaro.org>
Date: Sun, 15 Mar 2020 22:37:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <ef0a9b7e-65c4-93e7-61b6-b288afa1c13a@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1044
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
Cc: guoren@linux.alibaba.com, wenmeng_zhang@c-sky.com, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/15/20 8:41 PM, LIU Zhiwei wrote:
> 
> 
> On 2020/3/15 6:47, Richard Henderson wrote:
>> On 3/12/20 7:58 AM, LIU Zhiwei wrote:
>>> +
>>> +/* Vector Floating-Point Merge Instruction */
>>> +static bool opfvf_vfmerge_check(DisasContext *s, arg_rmrr *a)
>>> +{
>>> +    return (vext_check_isa_ill(s, RVV) &&
>>> +            vext_check_overlap_mask(s, a->rd, a->vm, false) &&
>>> +            vext_check_reg(s, a->rd, false) &&
>>> +            vext_check_reg(s, a->rs2, false) &&
>>> +            ((a->vm == 0) || (a->rs2 == 0)) &&
>>> +            (s->sew != 0));
>>> +}
>>> +GEN_OPFVF_TRANS(vfmerge_vfm, opfvf_vfmerge_check)
>> Similar comments as for integer merge, using tcg_gen_gvec_dup_i64 for
>> unpredicated merges.
>>
>> In fact, there's no reason at all to define a helper function for this one.  I
>> would expect you do be able to use the exact same helpers as for the integer
>> merges.
> 
> Do you mean that I should expands TCGv to TCGv_i64 for vmv.v.x in translation?
> So that I can reuse it.
> 
> void gen_helper_vmv_v_x(TCG_ptr, TCGv_i64, TCGv_env, TCGv_i32);

Oh, I see, yes currently the integer helper is TCGv.
Yes, it might be easiest to extend to TCGv_i64.


r~

