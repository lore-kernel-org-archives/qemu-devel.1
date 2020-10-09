Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E42C433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 22:37:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7F22215A4
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 22:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eX2Fr3Dv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7F22215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kR11K-0004z9-2A
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 18:37:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kR10B-0004JQ-UR
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 18:36:39 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:33146)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kR109-0007yP-Vs
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 18:36:39 -0400
Received: by mail-ot1-x343.google.com with SMTP id t15so10462201otk.0
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 15:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=XQLnnSYQgsL2EXTFm7J7JLzUrbT2tCtd8RHoq/78vDM=;
 b=eX2Fr3Dvh5surWfJwIDQ1hH/VtLy6MkTRkH+tE+ivzliz8NcQko07mZfj6m54QeJNB
 bmZ3fbKfT0FFIK/51AmWIZq2tVxIfmFpsv6eE07ESWoX0pqdLNBv5lYXm45ucCC6t69A
 Z1wmNKUMuLFa/yQB1pMz6U/K9CgabsOeNfjg6AqTtigTNvBAOUXquyY1GJ/xFGkNM/NS
 E8asNVf2BrinslXKvnVQotiWElhK9D16OSikLHIt6iUHrebSFP9y+oOCPhW7ZIAD9ozN
 XyI/MeijDV8eo3P2X49Fv6tkgIbTc9dHgSJWgXnFu4eqH9FQ9WzkdjSSLDU9A6eY75+t
 wAmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XQLnnSYQgsL2EXTFm7J7JLzUrbT2tCtd8RHoq/78vDM=;
 b=AhwVUdP0jfrQrIjejn7sx/7hz1MTfpZEV2Ln23Jq5u+zbAeJAMtWCqk8/RUwS1e15n
 O6uJfhZiIxuSvFAUfMkEUCRuItFp+SG6tiLs7DcsKdNWRU1Y0uId5LnG7KYTAMXEbx2R
 bAUqWW2HiXvKC2co4HSqFgwdyPSiaIdOyPryx7ybZ3xOMZh+4R9ET5wvqU08rMkEr6gP
 Lxu7kAw1H/+O5j1znd46KTBPhRyI/f6dc97lffIeOnI7dXFLM0pV6iZEcYKRwxh2IHC4
 4i5llE0O6DZ2W41MW+f79GCxhHdt3Rqpe3MJ8YwDXbJqzSmXlYIO8q8/NNzjp6u9VzNP
 CyEw==
X-Gm-Message-State: AOAM530KBYPjF6Qsth7+kRrcDKG1gEeC+6Bggf3DmSr6j9YKa17bBpNc
 BP5N40mQDlbYGag2nkEGMmDvhOiPxU6uyOe3
X-Google-Smtp-Source: ABdhPJwdPr3IpxQH1hvO2U+YgMeERrjGUAjYwI3GZdBYGQlON4SL4toFb597Fphfwq7tiMql6SwiuA==
X-Received: by 2002:a05:6830:149:: with SMTP id
 j9mr9111919otp.187.1602282996655; 
 Fri, 09 Oct 2020 15:36:36 -0700 (PDT)
Received: from [172.24.51.127] (168.189-204-159.bestelclientes.com.mx.
 [189.204.159.168])
 by smtp.gmail.com with ESMTPSA id 189sm7499055oid.40.2020.10.09.15.36.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Oct 2020 15:36:35 -0700 (PDT)
Subject: Re: [PATCH] target/arm: Fix SMLAD incorrect setting of Q bit
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, 
 QEMU Developers <qemu-devel@nongnu.org>
References: <20201009144712.11187-1-peter.maydell@linaro.org>
 <CAFEAcA8BiQcJJr3hkzTqnFLpYtXf1xbDf+GpgvYnPjJr_FAEUA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <21d142c5-d651-269a-8fbb-d35a743f1945@linaro.org>
Date: Fri, 9 Oct 2020 17:36:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8BiQcJJr3hkzTqnFLpYtXf1xbDf+GpgvYnPjJr_FAEUA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.208,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/9/20 1:48 PM, Peter Maydell wrote:
> On Fri, 9 Oct 2020 at 15:47, Peter Maydell <peter.maydell@linaro.org> wrote:
>> +        tcg_gen_extr_i64_i32(t1, t2, p64);
> 
> Oh, I forgot to mention, but it looks like extr_i64_i32
> isn't documented in tcg/README. Is that because it isn't
> really a TCG IR op, or just an omission?

Because it's not an IR op.  It's the combo of extrl and extrh.


r~

