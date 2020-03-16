Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C41EC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:06:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C732720658
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x5tdX9m6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C732720658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDv4D-0002fg-Uv
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 15:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40658)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jDuVl-0006Dd-Fv
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:30:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jDuVk-0006aO-Ei
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:30:49 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:41458)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jDuVk-0006R2-6K
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:30:48 -0400
Received: by mail-pg1-x542.google.com with SMTP id b1so10204776pgm.8
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 11:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=MDipWwqnYmUcqme+VkpJ/wmOXt+gFXemmOemdGECmtQ=;
 b=x5tdX9m63QrtbvN7vePywwsPUnlVKafvJoHhQ1TJS4QNNQmuDJvlTr2Gk5DmQcwvx7
 IiVBLEx1vD13wt2Vo5xbU5LTxMk+xKOnS1LQSx0YfhRzghHOajAJdQKk/H4E4gVz/B0c
 E1uYyVFdnLChvw8f5Jn5HAM3dbNdSsL2M2SkbEk65QChproS/GwmsYiIpanrMX+1piP2
 KwqvMK3xR3XeC820cCy1Jk7kd1d8oaehY0W1D51fVCv+K+T6by3YPbivzUUYMNFiTKKD
 B+4F5ZhYGv6IDzvS++6TYmhEt/Hk9V2c5uD73WNSNBmc75pQrWVUP3gzZk7CS/8cii1u
 yn0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MDipWwqnYmUcqme+VkpJ/wmOXt+gFXemmOemdGECmtQ=;
 b=ABKvrHDTPr6pBeF7Y3J+5Q9PJ8Z1gKjvfTp27T4vn/kxn8CaxDwdiqay1s2FyrvUpp
 5Fjt93liohlHmY5d609NGxQ0SUVaM86R1zoBEKlfW6IrINHQ5msxpfgrXZUCOm8vMZAm
 lrGz/YCAXKfzARjpa02HKdd+rW1Nub2+NcPmsFunKlruFxDihvaNbfhPQ+SMSN6nTDPM
 k5fs3lyYyzH82zRtUJn+K5sL9Xfd7Ypjd+WgM83lTWV6MBSlJ3UAg22JpPICPaH2bWwE
 jdukwd5B3/4cUY/j9hItUk4kKLjWJwidE33rwWpbSjp2YqTfxMQqctBkWnecsz1+QvUy
 6FLQ==
X-Gm-Message-State: ANhLgQ1gC2WeLDEORL4FJhMDIxcl39ETmAgZ+ztFWcHiU5uxGNyJBcnQ
 uEJvpvzROHWCpcfOCiZ+yfQPmw==
X-Google-Smtp-Source: ADFU+vsjA8r2JOvvWAlhdKz8RcHFLmNdKvA9g2qv/ynLgQ6O+/HCkuCV/Iv7itjpoO6VaVJBcqn1Ng==
X-Received: by 2002:a62:7d11:: with SMTP id y17mr914395pfc.127.1584383447204; 
 Mon, 16 Mar 2020 11:30:47 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 g19sm580212pfh.141.2020.03.16.11.30.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2020 11:30:46 -0700 (PDT)
Subject: Re: [PATCH 05/11] Makefile: Write MINIKCONF variables as one entry
 per line
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200316120049.11225-1-philmd@redhat.com>
 <20200316120049.11225-6-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <706036c3-6cd4-e5ab-b98c-004e2a58f19b@linaro.org>
Date: Mon, 16 Mar 2020 11:30:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200316120049.11225-6-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/16/20 5:00 AM, Philippe Mathieu-Daudé wrote:
> Having one entry per line helps reviews/refactors. As we are
> going to modify the MINIKCONF variables, split them now to
> ease further review.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  Makefile | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

