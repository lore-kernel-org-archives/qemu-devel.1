Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E962FCA9EA9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 19:02:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6E122070B
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 19:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="lQzCcZKS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6E122070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLXWJ-00017Z-Un
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 15:02:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41067)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@sifive.com>) id 1iLXVD-0000S7-7Q
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 15:01:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@sifive.com>) id 1iLXVB-0007UC-Va
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 15:01:31 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:43626)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@sifive.com>) id 1iLXVB-0007T2-O6
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 15:01:29 -0400
Received: by mail-pl1-x644.google.com with SMTP id f21so3275547plj.10
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 12:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
 :content-transfer-encoding;
 bh=encdaYOYfC8XLuPZ4BblADQ3/+oHllRKuIEmB/IctIs=;
 b=lQzCcZKS+YWL53Ij7HA/AGTHwbSUQz39C7pAFfw0MHQ9iTh7gD3Xr1hzSB6ogYBkZh
 k18uT9mYawokUI1kEZfWXlo6W+MJ9vS6uw8Da1pumRnM12z9z9+F14yLBwLDfwYyBf2+
 aqwtfdra2zhQJpficcYP4nFJKPlCZ7xUI76y8rjqnvM/NR7wWQsImS6WGLx1YFUqh5Ag
 oxZQnN1+qsPms1COXFzmhCjsOl7ZCajZH27CTXpxu2/JmKl+rn18YsO50xMGGn6XiY9T
 rjUEtS5J/iuzYVWukP3e5MOSZCgp4qtTSUEZD4pmCeSNR6hVZGydS66fxaQQ8buzzomD
 5zuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=encdaYOYfC8XLuPZ4BblADQ3/+oHllRKuIEmB/IctIs=;
 b=H99utgDsx9FjlsRUK/zLe9AWM5bYw456KvvpSyB20A1xYVo4CONmqr/g7X82Jszgxn
 whNPe7NZYjldGu9wTYb8wvrHzJtWUHPvuyCBN8tEXnUiF0luLn1LO1q/T1g24aLfFJsR
 kHksfxSdV2zPIUmmGdYiiykUleabio47nPMMd4DuYA9Ujd2a/1740mRw4wPsnShWYGRJ
 lXi4anqGWB1NU+ZbqWLGtULDlcQ3IUr1572KELXjQeXEdM+6lYMic0yU2U4EVP8PEGpL
 vii/AVx1juh8M9Y4AOptdMfl4lfLwpsYwV3fZ/P1QOBVOwhvnoeWpMRxbup8L5Kwhsae
 TA3g==
X-Gm-Message-State: APjAAAVo5er6T8nFBjJ3hG3j/8k1yXpInbloEi+PdTikUCx1Gj3nBhPX
 2cGPJofUYtXi3rebv9j5jde5Eg==
X-Google-Smtp-Source: APXvYqwWZyvcelj2PfLWDFJd6mlwU3z3rXr/5jUfqeql3n+ofb3FjtK8i/qT8z8jfeQ0E2TJDTnRSQ==
X-Received: by 2002:a17:902:d689:: with SMTP id
 v9mr6916649ply.198.1571425288392; 
 Fri, 18 Oct 2019 12:01:28 -0700 (PDT)
Received: from localhost ([152.179.112.46])
 by smtp.gmail.com with ESMTPSA id r18sm6401448pgm.31.2019.10.18.12.01.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2019 12:01:27 -0700 (PDT)
Date: Fri, 18 Oct 2019 12:01:27 -0700 (PDT)
X-Google-Original-Date: Fri, 18 Oct 2019 12:01:07 PDT (-0700)
Subject: Re: [PATCH] target/riscv: PMP violation due to wrong size parameter
In-Reply-To: <CACjxMEt-zOt8VktL_Ut-9vA0FdeO5jPf0XVeCzuT2OOnyehMmA@mail.gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: dayeol@berkeley.edu
Message-ID: <mhng-20e0918b-b63e-4054-bae9-b94145e22cbe@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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
Cc: qemu-riscv@nongnu.org, sagark@eecs.berkeley.edu,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 richard.henderson@linaro.org, fintelia@gmail.com, qemu-devel@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>, diodesign@tuta.io
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 15 Oct 2019 10:04:32 PDT (-0700), dayeol@berkeley.edu wrote:
> Hi,
>
> Could this patch go through?
> If not please let me know so that I can fix.
> Thank you!

Sorry, I dropped this one.  It's in the patch queue now.  We should also check 
for size==0 in pmp_hart_has_privs(), as that won't work.  LMK if you want to 
send a patch for that.

>
> Dayeol
>
>
> On Sat, Oct 12, 2019, 11:30 AM Dayeol Lee <dayeol@berkeley.edu> wrote:
>
>> No it doesn't mean that.
>> But the following code will make the size TARGET_PAGE_SIZE - (page offset)
>> if the address is not aligned.
>>
>> pmp_size = -(address | TARGET_PAGE_MASK)
>>
>>
>> On Fri, Oct 11, 2019, 7:37 PM Jonathan Behrens <fintelia@gmail.com> wrote:
>>
>>> How do you know that the access won't straddle a page boundary? Is there
>>> a guarantee somewhere that size=0 means that the access is naturally
>>> aligned?
>>>
>>> Jonathan
>>>
>>>
>>> On Fri, Oct 11, 2019 at 7:14 PM Dayeol Lee <dayeol@berkeley.edu> wrote:
>>>
>>>> riscv_cpu_tlb_fill() uses the `size` parameter to check PMP violation
>>>> using pmp_hart_has_privs().
>>>> However, if the size is unknown (=0), the ending address will be
>>>> `addr - 1` as it is `addr + size - 1` in `pmp_hart_has_privs()`.
>>>> This always causes a false PMP violation on the starting address of the
>>>> range, as `addr - 1` is not in the range.
>>>>
>>>> In order to fix, we just assume that all bytes from addr to the end of
>>>> the page will be accessed if the size is unknown.
>>>>
>>>> Signed-off-by: Dayeol Lee <dayeol@berkeley.edu>
>>>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>>> ---
>>>>  target/riscv/cpu_helper.c | 13 ++++++++++++-
>>>>  1 file changed, 12 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
>>>> index e32b6126af..7d9a22b601 100644
>>>> --- a/target/riscv/cpu_helper.c
>>>> +++ b/target/riscv/cpu_helper.c
>>>> @@ -441,6 +441,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address,
>>>> int size,
>>>>      CPURISCVState *env = &cpu->env;
>>>>      hwaddr pa = 0;
>>>>      int prot;
>>>> +    int pmp_size = 0;
>>>>      bool pmp_violation = false;
>>>>      int ret = TRANSLATE_FAIL;
>>>>      int mode = mmu_idx;
>>>> @@ -460,9 +461,19 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr
>>>> address, int size,
>>>>                    "%s address=%" VADDR_PRIx " ret %d physical "
>>>> TARGET_FMT_plx
>>>>                    " prot %d\n", __func__, address, ret, pa, prot);
>>>>
>>>> +    /*
>>>> +     * if size is unknown (0), assume that all bytes
>>>> +     * from addr to the end of the page will be accessed.
>>>> +     */
>>>> +    if (size == 0) {
>>>> +        pmp_size = -(address | TARGET_PAGE_MASK);
>>>> +    } else {
>>>> +        pmp_size = size;
>>>> +    }
>>>> +
>>>>      if (riscv_feature(env, RISCV_FEATURE_PMP) &&
>>>>          (ret == TRANSLATE_SUCCESS) &&
>>>> -        !pmp_hart_has_privs(env, pa, size, 1 << access_type, mode)) {
>>>> +        !pmp_hart_has_privs(env, pa, pmp_size, 1 << access_type, mode))
>>>> {
>>>>          ret = TRANSLATE_PMP_FAIL;
>>>>      }
>>>>      if (ret == TRANSLATE_PMP_FAIL) {
>>>> --
>>>> 2.20.1
>>>>
>>>>
>>>>

