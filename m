Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B87C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 17:44:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0BF720708
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 17:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HkWLnePS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0BF720708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb6Hj-0001Qn-64
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 13:44:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37848)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jb6HB-000119-Cr
 for qemu-devel@nongnu.org; Tue, 19 May 2020 13:43:37 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636]:35863)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jb6H9-0001Bk-SS
 for qemu-devel@nongnu.org; Tue, 19 May 2020 13:43:36 -0400
Received: by mail-pl1-x636.google.com with SMTP id f15so198479plr.3
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 10:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=poACR17MVikTs5fpU3p4xsxE+gb3UkqPFepf79AqaaA=;
 b=HkWLnePSygAHmEO/B4SqFr/nof7GwJpjovP8ds/tJh+pF9rkKR/4CCz0Awn4GdnZu/
 CLEuVy23L71V3AwEOriBcLWI4FiMCOP8+22VQvRWzY/QQ1fhZ+uqrBODn8VLq9Z+ocxD
 SY0k9W4NFZLnRZf+jBfnYwlhbXYlZx5dSlwbAX8VI9IMTwp+DQrBtwxeFDxd2LyzOFwE
 34SFzX3dKxUJ1vfIYJQ/00ZQP2SMFPAkYWZxyOZ+htiM34DiBNTIxP5CEbCAHUJL5gXi
 bvE6wPD+aZlPttO5Lqq6PIWi8FqgQs7dMWxgxtah/OdtfaPWzO0RR+0qLPJe0t6m4FNn
 lWDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=poACR17MVikTs5fpU3p4xsxE+gb3UkqPFepf79AqaaA=;
 b=s6ctuH+RiP0WP+qPkSAOr+7uM4dJjVsyE9iqU6DTGoBEFW7pq5znngd7yrPMpxs3dN
 Q6WoJlUInvmzGKvndffpXz8OC0BzMT4dy+UFZP3a311nAtvCBFYppdsYKuyrbHcuHtHP
 gztszVchgBnMRSbGJlftT47AmSupcmdrK/A1R0c3SYzRbwjummHE1jOKCLHXB5Tm394r
 69//m50pTHnWuGe5+UIM50Vu0qxFHNJUC8jtqlhtEd1UfekMWd65DFbnY+Izy25aS4YT
 M7N2EfqE0VU/yWopfaBqwtxJ4HMVDfzSPTcT72EwJdJk/myI38ZKdVG4X2zXrhmy+W45
 zU9Q==
X-Gm-Message-State: AOAM532PNiNSVH34XoMD+dytzoUQU7k1bzVoBg/3SDm1GN5aHWbN7mtN
 /XWvUfdPlQxiFiuf73aHA2W1lQ==
X-Google-Smtp-Source: ABdhPJyV5rzapqlk2KA8oTGAWH5E+YDJuajUtDleTu7Uyixg1Gyk6j2RCHmN35s370UsKpKJ6xhEHA==
X-Received: by 2002:a17:90a:6a0f:: with SMTP id
 t15mr675201pjj.121.1589910213753; 
 Tue, 19 May 2020 10:43:33 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id 27sm181294pjc.41.2020.05.19.10.43.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2020 10:43:32 -0700 (PDT)
Subject: Re: [PATCH 2/2] target/i386: fix IEEE x87 floating-point exception
 raising
To: Joseph Myers <joseph@codesourcery.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com
References: <alpine.DEB.2.21.2005152117400.3469@digraph.polyomino.org.uk>
 <alpine.DEB.2.21.2005152120280.3469@digraph.polyomino.org.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5dd2d81c-cedd-7835-6b3c-7e089254dc95@linaro.org>
Date: Tue, 19 May 2020 10:43:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2005152120280.3469@digraph.polyomino.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

On 5/15/20 2:21 PM, Joseph Myers wrote:
> +    uint8_t new_flags = get_float_exception_flags(&env->fp_status);
> +    float_raise(old_flags, &env->fp_status);
> +    fpu_set_exception(env,
> +                      ((new_flags & float_flag_invalid ? FPUS_IE : 0) |
> +                       (new_flags & float_flag_divbyzero ? FPUS_ZE : 0) |
> +                       (new_flags & float_flag_overflow ? FPUS_OE : 0) |
> +                       (new_flags & float_flag_underflow ? FPUS_UE : 0) |
> +                       (new_flags & float_flag_inexact ? FPUS_PE : 0) |
> +                       (new_flags & float_flag_input_denormal ? FPUS_DE : 0)));
> +}

This is not ideal from the point of view of interacting with softfloat's
deferral to host hard float.

I know you're working toward raising unmasked exceptions, but I think we will
want to handle that in a different way.

To retain the hard float fast path, we need to leave float_flag_invalid set
when the accrued exception bit is set.  To me this suggests keep all of the
FPUS_* bits in fp_status and only convert to FPUS_* when we read the fp status
word.

When it comes to raising unmasked exceptions... I have a couple of thoughts.

(1) Enhance softfloat to record the exceptions raised for the previous
operation, separate from the accrued exceptions.

This gets into trouble vs float_flag_invalid though, because we can't compute
that through the hard-float fast path.  And without knowing that
float_flag_invalid is currently irrelevant, we can't use the fast path at all.

This might still help in some places (though not here), so it might still be
worth exploring.

(2) In save_exception_flags, only zero the bits for which we have unmasked
exceptions.  In the normal case this would be none of them, which solves the
fast-path problem above.

To simplify this at runtime, I would suggest pre-computing a softfloat mask of
unmasked exceptions when we change the fp control word.


r~

