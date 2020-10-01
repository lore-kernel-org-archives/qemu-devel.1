Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73ADFC4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 16:22:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFC4620848
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 16:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NGVxXLQA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFC4620848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO1LX-0007S9-0Y
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 12:22:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37454)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kO18N-0007lj-JK
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 12:08:43 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c]:41535)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kO18K-00009c-OE
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 12:08:43 -0400
Received: by mail-oi1-x22c.google.com with SMTP id x69so6140596oia.8
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 09:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=5VrcTxMJrpEzBPpAzXMKniJyxh9455HBlvrczkdQT6U=;
 b=NGVxXLQA8f2dqLoY8wZuw7oPkHbAfBklKdDUnCyPmbV8cXgaWwq69tylWLgW8X5ySN
 RzFPyJL2flMD56s81O5LpkdzqWpq+5ykrdQWZ+ckNuO0XcPx98OFni7zEQT7P7xOtnie
 +mANleJtJD2YGc8I0BSz5Nw6BfDA05rJ6qZ2KFREoosLsexA0ErslqAbBXQNwkBPFNMk
 vLIU+K9w2VoH5+sW64M8wscwszK+92B4ptfoPHnrLccNfK3jwnX5kz+NQ76ICwxEkGIU
 1M6xWXeUUVQvWVycGwa8PKnbLf46IxQE+2k9bOm3SmmJXkXk7G1QFw/jssfwd6TGY9Vf
 KnZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5VrcTxMJrpEzBPpAzXMKniJyxh9455HBlvrczkdQT6U=;
 b=b967k7xNe+eMat4XckrGiw/+bcUIO6pV3wop0iUj2P0lPdKWbKQoTtD4U9sDLprRUY
 kAELN50/kB2pSG1x22R3x5nB6GVaTTDmFBNO7jFstDlA/R8VEu2WF1aGk4AwKDlkDwex
 54pJnYqB+lzNVbaXVVL6xJiNsYUTOu7VKAYbuVHn6txaxjNm2KHZmRZdKNg7ogqEV7DI
 ev6q7YCchgjoGWg07TZ5iVbHVDuuI15EiiMw7jhSPvt04JSr9hv+cMZFlJpUNYcl7SLI
 Om3CzO/VDHZHFn/rPeJcAkez3FXpFFHTqM7GlVro1rLIDPBxpWGvTR/Lc67jK9TctHva
 RbOg==
X-Gm-Message-State: AOAM531Mqiy4u/kOSGRBamV4kuAqav2nvqkufuuit5fvFZd/6gHxBDAT
 A0BYJ38sbY5jn4OTrKXrVqNkjg==
X-Google-Smtp-Source: ABdhPJxnWCO9e0T/QxUpbXEaz4P/xDerJ1M69LvFLLYSx3qGnWezgOw8wwp1qdBjv9gFMqEPc6pxxg==
X-Received: by 2002:aca:5c5:: with SMTP id 188mr440508oif.1.1601568519309;
 Thu, 01 Oct 2020 09:08:39 -0700 (PDT)
Received: from [10.10.73.179] (fixed-187-189-51-144.totalplay.net.
 [187.189.51.144])
 by smtp.gmail.com with ESMTPSA id d63sm1127969oig.53.2020.10.01.09.08.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2020 09:08:37 -0700 (PDT)
Subject: Re: [PATCH v1 04/20] s390x/tcg: Implement 32/128 bit for VECTOR FP ADD
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20200930145523.71087-1-david@redhat.com>
 <20200930145523.71087-5-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <19ecdb4f-7d86-39ff-2f8c-883d327e2646@linaro.org>
Date: Thu, 1 Oct 2020 11:08:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200930145523.71087-5-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.26,
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/30/20 9:55 AM, David Hildenbrand wrote:
> +        case FPF_LONG:
> +            fn = se ? gen_helper_gvec_vfa64s : gen_helper_gvec_vfa64;
> +            break;

BTW, any reason not to pass SE as data, like you do later for SQ?  Or
potentially the entire M field as is?

Just wondering if it would help tidy up here...


r~

