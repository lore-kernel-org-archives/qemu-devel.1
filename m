Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F4FC3A59F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 23:48:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1A6F2080C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 23:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IWGGDmTN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1A6F2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2Oik-0004B8-U3
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 19:48:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59615)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i2Ohk-0003Ui-N8
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 19:47:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i2Ohj-0004d7-FI
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 19:47:20 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:33758)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i2Ohj-0004bn-7H
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 19:47:19 -0400
Received: by mail-pf1-x444.google.com with SMTP id g2so12847306pfq.0
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2019 16:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=t5dXr+5eWDk+oOUl/xpSyEk5zCVFGBpHOuDbiv61zLs=;
 b=IWGGDmTNVqZncR+pmdt74BM6clveQUSfDZDBgzCmgBq79Z8bOVA1pzUAfit0tJc0yn
 gSQdUdF5H1moHJ5cEButowrYJtNcU869ubk7n3kATtDsOStfJhOJSI22D2Wz5wzNyH5b
 A9H7VnQGfcPofTr6sDnyjK8hr0kc3F1d0IGe5Ve8/jMQJF6Eseeing9cs9+eZWZwGbUW
 HGWDorEdSZDegrCGR9ZtiVWt3dLuuwhpTzr2plFSY/LoIaQzyUzXG5nWLlwjK5iPU747
 o2+YcUJPeXRHRMZ/K/FcnDR89TLLBLl8DHg0weJxuvnnaYfJpsCX1WMI6nSmY3W5c/EI
 xlgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=t5dXr+5eWDk+oOUl/xpSyEk5zCVFGBpHOuDbiv61zLs=;
 b=idxr+jyWe7BaeUJYqha/kf3uPnpEVKfyymB0lhFwVILFH3SFt6P9nuiMZItfYrHpFg
 BylXfos2arBxy+NCW7xpCDZVymlg/S3N8CaPPG2ALm45wxJxrmgMqf0davvEHIXhDlGb
 UhUhvEKXP6xZxJFdE9YCKnW1QxfaH+kWJaE67VlVBj5ue6HiH+H2dn3SfDO7kCVn6gr2
 u4zLr/bAIHhDJlj14meM+ookQSRtu80HWYn2e8VsRVTo0k2X5qoOmsrpyQDa9nVh1s6l
 deehUaZAeY1PWyRovNBuzirg1IpEAzw+xysUXlfOs3DZhG4CH/HecVwQPk0kqbMm0pDa
 30fA==
X-Gm-Message-State: APjAAAVKs9BXbL4tlnkkrIBMmiTtcnONrW/EpWReuZWCRPuE7xQjzyBq
 f3cfLSkzgouhgI8hviHa96IGtw==
X-Google-Smtp-Source: APXvYqx83BF5aBtomrcJFqqrUqfZwx11b/0bWRGr+FBy1xqgRwW31aNcnZdsDzRCgDfci4gwK8IrXw==
X-Received: by 2002:a62:8343:: with SMTP id h64mr22102853pfe.170.1566863237475; 
 Mon, 26 Aug 2019 16:47:17 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id t6sm10940776pgu.23.2019.08.26.16.47.15
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 26 Aug 2019 16:47:16 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190819213755.26175-1-richard.henderson@linaro.org>
 <20190819213755.26175-63-richard.henderson@linaro.org>
 <CAFEAcA-iBjMbeqC92A69Xn_Y0qnOu93+VhQwqw+hOeBYRXrBjw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <155ee312-cb2e-3fba-6277-c00d35c5ea94@linaro.org>
Date: Mon, 26 Aug 2019 16:47:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-iBjMbeqC92A69Xn_Y0qnOu93+VhQwqw+hOeBYRXrBjw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: Re: [Qemu-devel] [PATCH v2 62/68] target/arm: Convert T16,
 Miscellaneous 16-bit instructions
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

On 8/26/19 1:38 PM, Peter Maydell wrote:
>> +  IT            1011 1111 ... imm:5             &ci cond=%it_cond
> 
> This is correct (same behaviour as the old decoder, but
> it looks a bit odd here because it's not the same as
> the fields defined by the architecture (in particular the
> 'cond' field is not the same set of bits as the 'firstcond'
> field). We could maybe comment it:
> 
>   # Bits 7:0 in IT are architecturally simply the
>   # new PSTATE.IT bits (despite the instruction description
>   # splitting them into 'firstcond' and 'mask' fields).
>   # In QEMU during translation we track the IT bits using
>   # the DisasContext fields condexec_cond and condexec_mask,
>   # so here we massage the bits from the insn into the form
>   # that that optimization requires.
> 
> (Or equivalently we could just pass a single 8 bit immediate
> to the trans_IT function and split it out there, I dunno.)

I think I'll just go with this latter and do everything in trans_IT.

>> +%imm6_9_3       9:1 3:5 !function=times_2
> 
> Would it be worth adding support to the decodetree script
> for letting you specify fixed bits in this kind of field-decode,
> so we could write '9:1 3:5 0' rather than having to specify
> a multiply-by-2 function to put the 0 bit in ? Or is it
> not likely to be common enough to be worth bothering with?
> (Not something for this series, anyway.)

I hadn't thought about that.

Adding 1, 2, or -1 also appears, but that's 3 of the 60 instances currently in
the tree whereas shifts make up 33 of 60.


r~

