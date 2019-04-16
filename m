Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA17C10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 08:19:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 940EF20821
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 08:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dWg5v8n4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 940EF20821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:32835 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGJJ4-0007ex-Kb
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 04:19:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hGJHc-00072J-IU
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 04:17:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hGJHb-00056d-MZ
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 04:17:36 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:36227)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hGJHb-000563-6q
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 04:17:35 -0400
Received: by mail-pg1-x542.google.com with SMTP id 85so9959806pgc.3
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 01:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=sFXYm8hYiETaZFZ3Dbn68oJDPpAPXZzjVP4fckqQk8I=;
	b=dWg5v8n4XQPdyfALVjQClrO3gJb0DsqdBRiFIT4xX9v2CjpLGBl9ONbz5hu3xBCXHY
	Y25BdxPKvsNNtLoYbqvfLnE23jSjZjruedy2n7lglfIf/k/yqQaUWBUASvr4EAcb5/su
	jpsB///zEVPwypL/QsEhqqaYbXMu/kao/0a5on+nFscK3JqBtqu+vwuU4wcFBKZfXmVc
	+zqlYxZcAfMbzu7a9O4Yo2zoK5KxHmYoOQ11yvZJn6EuBpANXG/uUdyZBZBomfoMLk76
	2tEpTHl1EKGvOOfSOje3IsR5/kHvP8Q73iGczPl9NvERkJmeXLqCAm/A3yrc+I5gQLpN
	1b1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=sFXYm8hYiETaZFZ3Dbn68oJDPpAPXZzjVP4fckqQk8I=;
	b=cguD2VUSa4lPl9lsk4EftY/Cq2ZkTZQjmzxkx3wFI0R+LeRxjK3fAONxiUKGzVfqru
	G46mWAC5xDQFJ+iP5R4B4olsEaUBS3OKk4D8XzGHeXFuVD/6Jiy4YcwxmilBFZJS/9ak
	1Km+FOFunmVdtIsRQT6RJ3JNPPkZSA6BkoJki6hvKUFtuIKBhUeP/b+0WqgiJx4Cs75m
	aaPuQnsxYOgLE2Xv6Ru5JmHO/jAvZrny8JrXkC+w59T6tW/6AaVkxhrQKgzJ07n5k+2A
	GiNqtOy6w02jgO3l54AvhYEcb+EAIyYPxeeCGwjqUnAR1tVXUdgEnmlvrTYtMRMBgC5n
	wG5g==
X-Gm-Message-State: APjAAAUP/tyvrSDmZaCjM4gAB+OJfHmbO8UIk1A4lwkpzge8KCJJpTQf
	rywZF2FHdDj52oB7uneQUFNzDA==
X-Google-Smtp-Source: APXvYqzESXv7vrADNfAJXNuGud3/AIOXPG6aC6UpX10unWbA881IjEPIfxWlkHr6FRqo3DCGAEEMtA==
X-Received: by 2002:a62:70c6:: with SMTP id
	l189mr82218025pfc.139.1555402653238; 
	Tue, 16 Apr 2019 01:17:33 -0700 (PDT)
Received: from [172.20.101.138] (rrcs-66-91-136-155.west.biz.rr.com.
	[66.91.136.155]) by smtp.gmail.com with ESMTPSA id
	i15sm72339978pfd.162.2019.04.16.01.17.31
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 16 Apr 2019 01:17:32 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-4-david@redhat.com>
	<50db1745-397d-03e0-626a-12d1b2a2a554@linaro.org>
	<0fdae81c-eecb-90cd-26f8-b52964d375a3@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <b0567193-e353-d391-b438-e5b580d699a4@linaro.org>
Date: Mon, 15 Apr 2019 22:17:28 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <0fdae81c-eecb-90cd-26f8-b52964d375a3@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: Re: [Qemu-devel] [PATCH v1 03/41] s390x/tcg: Implement VECTOR ADD
 COMPUTE CARRY
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
	Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190416081728.qWLiFN2m0ApNhKwrYistk7XZPIkQ1mCYyzwhIog5NP4@z>

On 4/15/19 10:01 PM, David Hildenbrand wrote:
> On 12.04.19 23:05, Richard Henderson wrote:
>> On 4/11/19 12:07 AM, David Hildenbrand wrote:
>>> +    static const GVecGen3 g[5] = {
>>> +        { .fni8 = gen_acc8_i64, },
>>> +        { .fni8 = gen_acc16_i64, },
>>> +        { .fni8 = gen_acc32_i64, },
>>> +        { .fni8 = gen_acc_i64, },
>>> +        { .fno = gen_helper_gvec_vacc128, },
>>> +    };
>>
>> Vector versions of the first four are fairly simple too.
>>
>> static void gen_acc_vec(unsigned vece, TCGv_vec d, TCGv_vec a, TCGv_vec b)
>> {
>>     tcgv_vec t = tcg_temp_new_vec_matching(d);
>>
>>     tcg_gen_add_vec(vece, t, a, b);
>>     tcg_gen_cmp_vec(TCG_COND_LTU, vece, d, r, a);  /* produces -1 for carry */
>>     tcg_gen_neg_vec(vece, d, d);                 /* convert to +1 for carry */
>> }
>>
>>   { .fni8 = gen_acc8_i64,
>>     .fniv = gen_acc_vec,
>>     .opc = INDEX_op_cmp_vec,
>>     .vece = MO_8 },
>>   ...
>>
> 
> Indeed, I didn't really explore vector operations yet. This is more
> compact than I expected :)

:-)

That said, in implementing vector variable shifts today,
I've come up with a representational problem here.
You may want to hold off on these until I can address them.


>>   tcg_gen_add2_i64(tl, th, al, zero, bl, zero);
>>   tcg_gen_add2_i64(tl, th, th, zero, ah, zero);
>>   tcg_gen_add2_i64(tl, th, tl, th, bl, zero);
>>   /* carry out in th */
> 
> Nice trick. Just so I get it right, the third line should actually be
> 
> tcg_gen_add2_i64(tl, th, tl, th, bh, zero);
> 
> right? Thanks!

Oops, yes, typo indeed.


r~


