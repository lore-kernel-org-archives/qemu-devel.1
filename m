Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB15C43463
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 20:36:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F27420838
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 20:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mUTJi98X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F27420838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJ0da-0003ud-Mq
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 16:36:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39036)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJ0bz-00035L-Sk
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 16:34:37 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:40411)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJ0bx-0002Ff-1C
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 16:34:35 -0400
Received: by mail-pg1-x543.google.com with SMTP id j34so2036663pgi.7
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 13:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=XAM2m0NwRw3/D5zsuX7OllEMxEmcr4hUDT2maZtMMQc=;
 b=mUTJi98XIIj685fEvBt2+q/EwXuG0NyG5jSbxBEP9q4qpHBcSzAGwe2z57v3dZmW0D
 JTsz03wXRRsWFDkuXEfJra1fjY3vyMrl/XvsmARoMmDuSuZzurLrBCAVtrbm+qtMo1xc
 3l9U4zBG3CtMRXnJ4XAlqkzuPtjNjk6UDzRzy4IKhsR2ADyrHB7MKntlDucf0kwftQ5E
 1JOEacvF5CtpgD5yWCk+5BaHBXerr/e+sRcIcU3/m6tJx4MfRMuQDbCVaABKOJNhrZ3j
 QmmJoF8BrhV/sGTZyR3NtpROAdxRHQd2kjnBudoFERMj14NRNYrENgKa9vh6tNV6V1hy
 e4iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XAM2m0NwRw3/D5zsuX7OllEMxEmcr4hUDT2maZtMMQc=;
 b=a1syp368zD3jWExuJlW0Lidq4Cjw21ADmRjzFrs15Wvowum8S0SATaEjvsGeCI7MLC
 iTvOH0UPLDgtNfYDuiKjNAaNLRD3pUz9vj/mJFesUGqpt1BriOBCw4NQDg1Yw/7QfSM1
 NAKFN+IFk4FURUFlVA+/BmERWiHW9ZF8k3ofCOWqV8J+D5581GRl0Vx1BhBDr3FdC7BV
 9jR1soeNeh2+klgwmDxVmfQAdsbmDXl9sc/ScgdZWC64ZLKZxH1dYyyvsZHffXSlCxRC
 Ee+Ehi/jlr9Dlr9l+Syo4genqCxRDFLGlElKUZv1BUq7spcKbQBvHSGN8u1Qv8ZBmtRe
 M16Q==
X-Gm-Message-State: AOAM5309qwz/CxpAhYc7f+vgQmzCkGXEC+atL3XucrSicx9YGsxiq6oA
 g2uPxY+waf3U59wu5NfBtNUjlw==
X-Google-Smtp-Source: ABdhPJzutv7NidHChLG5o80QXSSjXhS3sWw6Svwob6/n1Ke68sarJPFSqXKbO9InvZsceZC23PopaA==
X-Received: by 2002:a63:6246:: with SMTP id w67mr4832380pgb.344.1600374871434; 
 Thu, 17 Sep 2020 13:34:31 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id w185sm560625pfc.36.2020.09.17.13.34.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Sep 2020 13:34:30 -0700 (PDT)
Subject: Re: [PATCH v2 1/6] util/oslib-win32: Use _aligned_malloc for
 qemu_try_memalign
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20200916004638.2444147-1-richard.henderson@linaro.org>
 <20200916004638.2444147-2-richard.henderson@linaro.org>
 <20200917184335.GW7594@habkost.net>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <45346119-02ca-5e8a-3342-0331f70ddbb3@linaro.org>
Date: Thu, 17 Sep 2020 13:34:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200917184335.GW7594@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
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
Cc: Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/17/20 11:43 AM, Eduardo Habkost wrote:
> On Tue, Sep 15, 2020 at 05:46:33PM -0700, Richard Henderson wrote:
>> We do not need or want to be allocating page sized quanta.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> 
> Would it be safe to keep patches 2-6 applied in case this one
> gets dropped or reverted for any reason?

Yes.

Only objects using QEMU_ALIGNED() should have an __alignof__ larger than
qemu_max_align_t.

Therefore, I believe that the CPUArchState objects to be the only ones that
will go through qemu_memalign.  So we won't end up with all QOM objects being
page allocated on Windows.


r~

