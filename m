Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87843C47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 18:06:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EF3A206FA
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 18:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ymgn5MZD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EF3A206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jW1xz-00054c-Hm
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 14:06:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47378)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jW1pt-0002UI-8b
 for qemu-devel@nongnu.org; Tue, 05 May 2020 13:58:29 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e]:35726)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jW1ps-0006eu-0t
 for qemu-devel@nongnu.org; Tue, 05 May 2020 13:58:28 -0400
Received: by mail-pl1-x62e.google.com with SMTP id f8so1137798plt.2
 for <qemu-devel@nongnu.org>; Tue, 05 May 2020 10:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=Q3F1AhN2i83NpQKxnya+qdAHaCUAQZDdZQ3sxqa99Nk=;
 b=Ymgn5MZDV+tlmio9ISaCS0fCSKKjd5uwZ5Tj43LU/7Q5VOIYoqIwdheTQMXvbrb1lL
 67v+vBPLYDP1y5GkijGz9g7XQts1zau3OYIaGAT6nkEDH+MU/0K6eCmYxJclT3WkyTOa
 Bud7oKDVlL2ST1CrOiV0Vc/mpLvmDkTCRPhOb7IzHNle8JJBSzR6LFZm7nZ2RRv7o0Eu
 VHpfpzAEFm9Sozo7y5ZdWriksZb4g+lhD3EVxraMnol/dfUcIH/hy13Hm2pTv9k+eo1v
 0uxhYwSMA6CEl74sOi8Ququ3qVn6lzeQFs3qwTFoS1MacUb+SMyxNE8GIpyv4VLQ6ats
 1ITw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Q3F1AhN2i83NpQKxnya+qdAHaCUAQZDdZQ3sxqa99Nk=;
 b=Qgg0i27EPLQmECAlUMpP5Fb68aW0W72EOfdhnpIYW9gfCtH80NyOJGNwv2SzWFZVqN
 1hkMceM8TcDEsdbTQchPpH/+XT3qSeBqFbRxiAmVMCU0ubf/5DNYnepWLmSKgDp3VXpO
 zLMHz5ODXXmjLR5bzhwzNXMVbVF8qwIbi7EUGISYAkOIrltlIInq20Gc5CvWPZwBYQaj
 AhLQkHpVlwhFsyh5vZg7WqfyWGSLM8ixxAWaK7D7Wm4XMqi93Os6Vib6aeuezwk1x15X
 SryyB3XteGbnSw/bzUOK7MTfOw7rgtNKrB96WSUBjs5K7cKtwlAPL1VzuQdeKsDVcvUE
 La+g==
X-Gm-Message-State: AGi0PuZpXsO5MH0wGA/PDla4BF82x5dii5xGaYjrocZiG6iSoyfxcAnK
 K5Fz2qXnAdrNkRrdRJDV8I3X0Q==
X-Google-Smtp-Source: APiQypLeSLuG5FftA50WveYBFtVlxfXdzHN5vIOQ8QYyYH9dgE06CBWkC+OV63xN3/An3qeXbXXvjQ==
X-Received: by 2002:a17:90a:35f0:: with SMTP id
 r103mr4608545pjb.167.1588701506078; 
 Tue, 05 May 2020 10:58:26 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id 135sm2518954pfu.125.2020.05.05.10.58.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2020 10:58:25 -0700 (PDT)
Subject: Re: [PATCH v2 0/4] softfloat: fix floatx80 emulation bugs
To: Joseph Myers <joseph@codesourcery.com>, qemu-devel@nongnu.org,
 aurelien@aurel32.net, peter.maydell@linaro.org, alex.bennee@linaro.org,
 pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com
References: <alpine.DEB.2.21.2005042332380.22972@digraph.polyomino.org.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <eb2941be-5615-7eff-ca83-5da36d0dad55@linaro.org>
Date: Tue, 5 May 2020 10:58:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2005042332380.22972@digraph.polyomino.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 5/4/20 4:36 PM, Joseph Myers wrote:
> Joseph Myers (4):
>   softfloat: silence sNaN for conversions to/from floatx80
>   softfloat: fix floatx80 pseudo-denormal addition / subtraction
>   softfloat: fix floatx80 pseudo-denormal comparisons
>   softfloat: fix floatx80 pseudo-denormal round to integer

Thanks.  Queued to a local branch with some more fpu cleanups.


r~


