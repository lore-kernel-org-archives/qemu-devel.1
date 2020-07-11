Return-Path: <SRS0=vx8y=AW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 571F2C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 19:37:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CBFD20748
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 19:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IeFf5Q7M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CBFD20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juLJg-0001LP-Cr
	for qemu-devel@archiver.kernel.org; Sat, 11 Jul 2020 15:37:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57402)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1juLJ8-0000pi-H9
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 15:37:10 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:55524)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1juLJ6-0006M3-67
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 15:37:10 -0400
Received: by mail-pj1-x1043.google.com with SMTP id ch3so4025047pjb.5
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2020 12:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Z3R1VQZdSXlkeFkzd/p5ikGikrtCov/0TjMgvUm1x8o=;
 b=IeFf5Q7MRLknhmumBM/wNuNYzcDNijrZFIONtY9SEp+z6FmL9bgEo0Fc3q+ltvAsyU
 rOU+g4vatLvpri7erdhVZjcvKiAC9iIgM8h+pNZG9lAXvCuZD1Rgmv9IVu/BDD/wpw5G
 LJd/Za7thKIzYPeAyj7O/h9kvBffWI97AsH65I6BMW3czEmvSTnOGIWVK4XJY+a5YcE6
 et+J868lRFcCYeETOT2o7g7S0iWY/33ZeoRT+4nwACIQudaZi0EYqg0Pz9KDlydd031S
 npJ1Qs9pDh4Uc9i6N0fxDA+kFYds4twCqGdOJpc78FVRyg1AdfH4GhdAKheP5/AGJmuk
 kQGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Z3R1VQZdSXlkeFkzd/p5ikGikrtCov/0TjMgvUm1x8o=;
 b=SDcFJnLRHFUEbJS2jnnln6ZS6Xo56LvhT4AHx6lDqTBGmSj1UAtSMc5Dg1dpA67T85
 f6EUfcxWhG7zc48LBTazTCOsJw1Q5SqrUdzH3XDM6qlLGjeC/W1IFAAQLnZDgXUCuWFm
 mRSRIa+PlCZdtN5tC80N2RJmw25gTJoZd7xV4n2rZVeYPQvbWx/vXgdSE7Ysux00722d
 xBVuNaNydQDj7zmNOGJfQb8nvQgSofcKYDL468m/RBdQjGJfzgLLQl/lcyh7eav9c8Gj
 UFo2cSlBQQb5YrKS3XqHMV0lNgVZGiqGtZVQ1rXPlgIPWjIoMTQQGd36WEt0f7cNM5LS
 0vYQ==
X-Gm-Message-State: AOAM531zF9EleROUpGVYdofCFwGJLfyVI+y9kp6hbsNvMGNIsD16Ezpt
 ikjQ02Lz7x01ZdGL7JXkJIKSMg==
X-Google-Smtp-Source: ABdhPJyG4imiZbGX0mbRyTCAHEdMY9E+OkmxUGX8/vXe4NXw4XTjk0oobS23q5NA9aL/nv4D0+fN3A==
X-Received: by 2002:a17:90b:46d7:: with SMTP id
 jx23mr12751736pjb.191.1594496226539; 
 Sat, 11 Jul 2020 12:37:06 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id b8sm9631736pjm.31.2020.07.11.12.37.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 11 Jul 2020 12:37:05 -0700 (PDT)
Subject: Re: [PATCH v2 06/17] linux-user: Do not use guest_addr_valid for
 h2g_valid
From: Richard Henderson <richard.henderson@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200605041733.415188-1-richard.henderson@linaro.org>
 <20200605041733.415188-7-richard.henderson@linaro.org>
 <CAFEAcA_ca4vAxB-2qfsXVUNPUdyFTJQtcBdkegn4ub8SOiR2TA@mail.gmail.com>
 <d6c82116-8b33-716f-e76b-ecad2f24267d@linaro.org>
Message-ID: <70dca59c-927b-3fbb-9625-146594c6c245@linaro.org>
Date: Sat, 11 Jul 2020 12:37:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <d6c82116-8b33-716f-e76b-ecad2f24267d@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1043.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Stephen Long <steplong@quicinc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/11/20 12:30 PM, Richard Henderson wrote:
>> The old implementation returns true for
>> HOST_LONG_BITS <= TARGET_VIRT_ADDR_SPACE_BITS
>> (because there's a different definition of guest_addr_valid() there)
>> but this one does a range check even in that case.
> 
> It's part and parcel with patch 1, wherein we are in fact attempting to limit
> the guest address space to GUEST_ADDR_MAX.
> 
> That's why I put patch 1 first, so the behaviour change happens there.

Ho hum.  I've just realized the messages are sorted oddly in the mbox here, and
that the behaviour change is actually coming later in patch 7.

So, to summarize, I am intending a change here, it's just a matter of sorting
things so that one thing happens at a time.


r~

