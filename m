Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 737E9C2D0E2
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 13:31:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A6EE23787
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 13:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MmqUVleX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A6EE23787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLRL3-00089v-Vl
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 09:31:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42752)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kLRKI-0007c2-Td
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 09:30:22 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:40750)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kLRKH-0004Ec-4O
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 09:30:22 -0400
Received: by mail-pj1-x1041.google.com with SMTP id mn7so1604062pjb.5
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 06:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=/GK5BSS+7vxlkgLzIgU2TRkJd7Sjie+0TnaOZqNwp38=;
 b=MmqUVleXRKIAZJET48jbWfUsAWNcNbX+FXdOe6FhO/ofKGCd0ALW7pHAq2CGXUDh9B
 +0rP//KjS0IoltNKknuuX844Pj8wbWJNboe+5qGtucFU9KUIW0uoHTudRuQcFq0gvHc7
 MP7Zgmfoj0g9NnSus/QetqcyzdtiK4Z6xVo3Xv4Ic3JXrtcKT8V6TJbYx2NwPPylqSNw
 virWSuLk6wtjL3wuJzjplRUwENYiC8sZquoqROy/GlLcra3GckNW5KhNmxxOFu7ib9b/
 eaGmu9FRblsuSQlpsGD0TnBV2rX0Oq0NXdZyqSY8pcq4ZzRyB0wap9eKXxutVYoG9xK+
 h0uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/GK5BSS+7vxlkgLzIgU2TRkJd7Sjie+0TnaOZqNwp38=;
 b=YDbC4vInilTR5hLJmHlILmcBPm8T5VcNgnjoR3q+FgwwWulS8mr8Hr/QS6rzsF4sZQ
 GyeNe2Y+uvYbqbEUrJygsF64MDl1zKbF34lDIcaM6kLtN72E9xoZ1yohRzevostlWVDY
 aoI3w3e6Lf+op/nTj3SW3WyxMp9pScuQxr6Bf8OcdPvNjgVPQRxydILA0gLV1EcO3aik
 7zUjFWWY5/+2cp30CJYCNCqfNm50JnSdUX0x3Rflv2T21ypzpNCUA3HJ3Dnd/uAR6b1e
 cxKCFnkXRQNw6ZdCa0siCPsF2O1/uKutwlyhboqLHaj2Utq8+D/21XkbADJR5dT73J/1
 dHrQ==
X-Gm-Message-State: AOAM531d/SG6zb3AhZV5TQ1BTWS6NfQq+EahZJVmmVv5otCN8buMipmv
 oanrQMpVvp19nA4uAYVA5AuNlw==
X-Google-Smtp-Source: ABdhPJwI6YRkgui3Hov3GCrTcEAo8zUQvd34N9pKlSKuad9F/oNPGslZ0pf6xY7dd8rTn6QdG29SAg==
X-Received: by 2002:a17:902:8c8b:b029:d2:42fe:370a with SMTP id
 t11-20020a1709028c8bb02900d242fe370amr4465489plo.83.1600954218925; 
 Thu, 24 Sep 2020 06:30:18 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id s16sm3029274pgl.78.2020.09.24.06.30.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Sep 2020 06:30:18 -0700 (PDT)
Subject: Re: [PATCH 6/8] softfloat: Implement float128_muladd
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20200924012453.659757-1-richard.henderson@linaro.org>
 <20200924012453.659757-7-richard.henderson@linaro.org>
 <7045a238-b702-0031-735a-caa6d726e160@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ad092b60-dd41-33f0-9530-75fba4309c3c@linaro.org>
Date: Thu, 24 Sep 2020 06:30:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <7045a238-b702-0031-735a-caa6d726e160@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.214,
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
Cc: alex.bennee@linaro.org, bharata@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/24/20 12:56 AM, David Hildenbrand wrote:
> I do wonder if a type for Int256 would make sense - instead of > manually passing these arrays.

I could do that.  It does name better, I suppose, in passing.  So long as
you're happy having the guts of the type be public, and not wrapping everything
like we do for Int128...

Either is better than the softfloat style, which would pass 12 arguments to
these helpers... ;-)

>> +static void shortShift256Left(uint64_t p[4], unsigned count)
>> +{
>> +    int negcount = -count & 63;
> 
> That's the same as "64 - count", right? (which I find easier to get)

In this case, yes.

Of course, more hosts have a "neg" instruction than they do a
"subtract-from-immediate" instruction.  When the shift instruction only
examines the low N bits, the "& 63" is optimized away, so this can result in 1
fewer instruction in the end.

Which is why I almost always use this form, and it's already all over the code
inherited from upstream.

> Wow, that's a beast :)

But not much worse than muladd_floats(), I'm pleased to say.


r~

