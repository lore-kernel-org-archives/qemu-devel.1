Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36962C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 18:25:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E88920578
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 18:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rv1z+amA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E88920578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb6w5-0004qW-52
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 14:25:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42024)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jb6uv-0003G3-DC
 for qemu-devel@nongnu.org; Tue, 19 May 2020 14:24:41 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:50669)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jb6uo-0000Mr-Uw
 for qemu-devel@nongnu.org; Tue, 19 May 2020 14:24:41 -0400
Received: by mail-pj1-x1042.google.com with SMTP id nu7so56302pjb.0
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 11:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=HyXzx429zRXdub+45prHC1R5bNg0TUEB0xLij2OIMHU=;
 b=Rv1z+amA16vd3R1T/Rz/Cpoic4bSPjTEz2slD7JuE+DZCsvCLQd4EOSrL+qmsMCj71
 ZwyWJCq0gzzTb8S8thyGMEUXc67bRjQ/O7DaiVSRBHPLmbFl8fV/Khgyfdok1e3AWEDB
 6v1ARTSRNqTOi1c0sXwOYrp6ReXTs0mniuGMr1vkWfAtvBnlIRKezdD/Kk7gXfTDooh8
 MuPi4Mq43xHAXQGt0yNUoI4sdi09hchhasbUUzAR7UeKF7nE14p/bY0PwtMJaMP7Tzsq
 /728HsTjjG1spFyRKcjFkhvVf/x8C1/BNQfMAQ91jljQSqHLEeS6FIskmtkJARRCS0bu
 +IOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HyXzx429zRXdub+45prHC1R5bNg0TUEB0xLij2OIMHU=;
 b=l9f0nB+0lhV75pcC9urgBnUl05wacJzKsjFTxG/Uvk4mUDQCWDsqO9ZVciw2a3FmZY
 qv/U3CiTgUlvCrnpDrE6nvtvrMbURbWElXEcV0w1524vcyipaqi9xzbhriUda7RkhLt2
 32pH06d1ExyV0tizm6c2yJrh5H011aJcySbWnVwMaUJSbUgNOieSgcwLslHKbtbJl0SV
 3YnWAyB+u2S4JvS9diP++mAzVUAGUyzYXHcRqU7VWnlToxmeYPOv/DNv6adRVVMRQXKE
 O509ngJ+nsJ7VI0ZqH14wO25DcSvchbmfY8IbXrBVwt5JXPwPkhuTkF7QvnDAMpn26QL
 gBvg==
X-Gm-Message-State: AOAM530EqU3m7Wp0MHfO+nJZIPMyIthpPPETryVXMMTT0EDOTv739Gdk
 l+BaI84F/SLrsegXfhXz/qRjvQ==
X-Google-Smtp-Source: ABdhPJxwEHR7iidWzcyhJJ4Rn3Z/Gd8Ezz6UWhYTiSKNjAmfInFxAVVA0npYYduaM/IWRFNkhefW+Q==
X-Received: by 2002:a17:90b:30cf:: with SMTP id
 hi15mr868198pjb.209.1589912671896; 
 Tue, 19 May 2020 11:24:31 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id i10sm150295pfa.166.2020.05.19.11.24.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2020 11:24:30 -0700 (PDT)
Subject: Re: [PATCH 2/2] target/i386: fix IEEE x87 floating-point exception
 raising
To: Joseph Myers <joseph@codesourcery.com>
References: <alpine.DEB.2.21.2005152117400.3469@digraph.polyomino.org.uk>
 <alpine.DEB.2.21.2005152120280.3469@digraph.polyomino.org.uk>
 <5dd2d81c-cedd-7835-6b3c-7e089254dc95@linaro.org>
 <alpine.DEB.2.21.2005191757210.10766@digraph.polyomino.org.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <76d7fa28-5dd9-3af4-f663-d251bbdbf4f4@linaro.org>
Date: Tue, 19 May 2020 11:24:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2005191757210.10766@digraph.polyomino.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, ehabkost@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/19/20 11:12 AM, Joseph Myers wrote:
> On Tue, 19 May 2020, Richard Henderson wrote:
> 
>> To retain the hard float fast path, we need to leave float_flag_invalid set
>> when the accrued exception bit is set.  To me this suggests keep all of the
>> FPUS_* bits in fp_status and only convert to FPUS_* when we read the fp status
>> word.
> 
> There is no hard float fast path that I can see for floatx80.  The issue 
> of the fast path might be relevant for fixing SSE exception handling 
> (which has some similar issues to x87), but not for floatx80.

Oops, yes.  Wasn't thinking for a moment.

> Note that another bug in the x87 emulation is the lack of setting C1 for 
> most instructions with inexact results based on the direction of rounding 
> (which will require a new feature to be added to the softfloat code to 
> record that information so the x87 emulation can use it).

Wow, I don't believe I ever knew about that detail.

This looks similar to the indication that PPC gives (and qemu does not
implement) in FPSCR.FR ("The last instruction incremented the fraction during
rounding").

I guess it's not quite the same -- ppc indicates the fraction was incremented,
while x87 indicates that the value rounded up.  Which could be computed from
(fraction incremented) ^ sign, I suppose.


r~

