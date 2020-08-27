Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90349C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 21:34:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59B0A20737
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 21:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ldSMZtKr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59B0A20737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBPXm-0002C7-GN
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 17:34:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBPWe-0001Gq-AX
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 17:33:40 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:33402)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBPWb-00007L-Ay
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 17:33:39 -0400
Received: by mail-pg1-x543.google.com with SMTP id o13so4291499pgf.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 14:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=fWeMInRUlekCWlf4XuCp1eaOSBMkAkdpj8tvBshnAkc=;
 b=ldSMZtKrSd0yhVhJ1DkL6oAPH+Y/RUnDkdqZdVszhCve/+2q4lGeO9E2JnuMB9qBzq
 1IlY7lMb41jDH56Z+l8T7X8abQam4KwXc3zWShr+PfyyhctCLf2UDSgzXGGj3WJzUdAx
 +YrJaK7CKSpSFZV8vxJObVcO4JDoHZx17hqYPpt2EHtOrNRRSm3r+iD9f4U7CZlJJVKP
 8YzHjs6RJ3LJ3aTgHZLt0KmhL0jo1nKilm5CeHceUfbSsYq6F8CtK0JBNf7gygznq61B
 tzIgBV2WwKQapT0+i9YxEY1TJKPXJpVBg3n/YKl+McjYoRjKA1PdurzYKEIemkUKBkIB
 StZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fWeMInRUlekCWlf4XuCp1eaOSBMkAkdpj8tvBshnAkc=;
 b=Xk/NRslxRQQaHj82IfuSjpflhvHZ6WzdNAgfCq8MgZJFJeltd0MwFSGgCm33JQ8taC
 dpyBxFR/B/TtBmTi/4DE1eRq4l6lFzwojJEqT9TeKyBIkhgd4EjrBMdybgrKdFkgbkwF
 ULIIilZhEgxIaeD0Dt1rzKXhYVTiQ/IAMv4c1opoNNBlF3eOcFULN/X9R2Il4LEEgILs
 9wC0gzcwG6rEOOJnzgAyJyJHLA3Vkjjeb251G9KnulbmGYNSJpgtaG0ivGYDIcD9w2LL
 /9febGdQvziHZpZbDbDHedv7oKmUDyMtGcR7LjfjzPgIfvkJbzC1Mm1gSnEimvU/elFf
 fYCQ==
X-Gm-Message-State: AOAM5304rF2haHCm750a0Um1rLqeLI+kbTOl+WF/T3EYnUOzTiwZ0eLa
 1AYt+/Z/XuBp3P/3NHMz+lctTrR59ZlB7A==
X-Google-Smtp-Source: ABdhPJwqutCZ3KShlp9Jo9ioz/l5oTflb0uJS47whSTKOZF9M/Dt7jx1MyUulSWL+NI0sgDmhXksCw==
X-Received: by 2002:a63:c551:: with SMTP id g17mr3026773pgd.399.1598564015207; 
 Thu, 27 Aug 2020 14:33:35 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id i15sm3785139pfu.119.2020.08.27.14.33.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2020 14:33:34 -0700 (PDT)
Subject: Re: [PATCH 62/77] target/microblaze: Try to keep imm and delay slot
 together
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20200825205950.730499-1-richard.henderson@linaro.org>
 <20200825205950.730499-63-richard.henderson@linaro.org>
 <20200827191722.GP2954729@toto>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8a4adcc9-b285-cdb7-901e-5348853115a3@linaro.org>
Date: Thu, 27 Aug 2020 14:33:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200827191722.GP2954729@toto>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.782,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/27/20 12:17 PM, Edgar E. Iglesias wrote:
> On Tue, Aug 25, 2020 at 01:59:35PM -0700, Richard Henderson wrote:
>> If the last insn on a page is imm, or a branch with delay slot,
>> then end a tb early if this has not begun the tb.  If it has
>> begun the tb, then we can allow the tb to span two pages as if
>> the imm plus its consumer, or branch plus delay, or imm plus
>> branch plus delay, are a single insn.
>>
>> If the insn in the delay slot faults, then the exception handler
>> will have reset the PC to the beginning of this sequence anyway,
>> via the stored D_FLAG and BIMM_FLAG bits.
>>
>> Disable all of this when single-stepping.
> 
> 
> Hi Richard,
> 
> We've got a Linux boot that fails after applying this patch.
> It goes from always working to only working like 1 out of 3 times.
> It fails deep in user-space so I don't have a good log for it.

Hmm.  Let's just put this off for now.  I'm not 100% happy with it anyway,
since it adjusts the data structures in weird ways.


r~

