Return-Path: <SRS0=Jz4r=ZX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C7EC432C0
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 23:36:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1CF320748
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 23:36:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cl5dRLQW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1CF320748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibYld-0000h4-U0
	for qemu-devel@archiver.kernel.org; Sun, 01 Dec 2019 18:36:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38539)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ibYki-0000DX-UO
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 18:35:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ibYkh-0005CI-QJ
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 18:35:44 -0500
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529]:46851)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ibYkh-0005Ac-I5
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 18:35:43 -0500
Received: by mail-pg1-x529.google.com with SMTP id z124so1703635pgb.13
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2019 15:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=9TQjcPScg4cJrRxtO8VqNXF9g7SYIX4q/WTfV4bjl30=;
 b=cl5dRLQWLJ+mB3WP0hyygWW37745RkwhXOXYXH5X4gFdNCniSpz16z477olkrcR1Iv
 zhiQaZqN6G5qAzTh/hskj7OXzgOEcUhQOnzERsF1SQVzoFp8XcnYTPWOENJyoepRopJ+
 vujrFqcBUCWuzxtkbAgXLjwnAYTFmkQVfEKyjZgDju7dcDMR5VMu47M4jXJ1Wzf5WaOE
 1q+lRu8w5ZQvtD/2gWlvRe8NnbyogOqpFdwXz+Hx5cJtCAlVNBgt1VkS8zts6YwhDtfk
 Hi1G9u6Na3XHdoVcBbudpseURGethASpM1/B7bWV1Y1RFenOZc4B7zjO9h8Qnc4+rsbK
 S4mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9TQjcPScg4cJrRxtO8VqNXF9g7SYIX4q/WTfV4bjl30=;
 b=DPJv4yIqofnGBgdWw1U4y7AbQl7VQRatEm2QTnilSra4QB6JwLhIOFThZONdaaIfqo
 x6HI31RRz4H+RwV69jodzSngsZRZYHdcNGieE0w29eTigRxkc9yyK23k1J2GPuivnTaI
 P/WlteU+phI04BDK9/f8MbPGVEjr3jtLwQ+ouJ6yRjBd2vwFTMcHfqO78ysGZh4oD0cY
 pNYXuFOn/x7QyjnHsQ6EakRcpI+1oEcPTLHy0gI58DJp+KdQ08zr/ptLs3zPZRTnhpk4
 SCMEFIKdqy+VViBJdIREGUh95bjdp+2IWRIwiu7NyhMy5Bv3xJHUdLRRES2IHduNEvaE
 pzFQ==
X-Gm-Message-State: APjAAAWolrqG0GFeEw+pV7LNGPxLhqJD/7dBvf0p0C2K8kzTFR58ek19
 l5L9ymmSfvMhaknbiQct4n86Og==
X-Google-Smtp-Source: APXvYqzs5RiwL6J0gzcXvjXCeu3FPxqObpwsECzLpENY+RxQ0B+PHv/pmYXEOwV/0qaNiRuH1+jKYA==
X-Received: by 2002:a63:181a:: with SMTP id y26mr7733978pgl.423.1575243342240; 
 Sun, 01 Dec 2019 15:35:42 -0800 (PST)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id k66sm30907498pgk.16.2019.12.01.15.35.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Dec 2019 15:35:41 -0800 (PST)
Subject: Re: [RFC] exec: flush CPU TB cache when breakpoint address
 translation fails
To: Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org
References: <20191126222607.25653-1-jcmvbkbc@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ac4808b3-87cb-12ed-b3dc-cf5138f51522@linaro.org>
Date: Sun, 1 Dec 2019 15:35:39 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191126222607.25653-1-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::529
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/26/19 10:26 PM, Max Filippov wrote:
> When a breakpoint is inserted at location for which there's currently no
> virtual to physical translation no action is taken on CPU TB cache. If a
> TB for that virtual address already exists but is not visible ATM the
> breakpoint won't be hit next time an instruction at that address will be
> executed.
> 
> Flush entire CPU TB cache when a breakpoint is set for a virtual address
> that cannot be translated to physical address.
> 
> This change fixes the following workflow:
> - linux user application is running
> - a breakpoint is inserted from QEMU gdbstub for a user address that is
>   not currently present in the target CPU TLB
> - an instruction at that address is executed, but the external debugger
>   doesn't get control.
> 
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>

As a short-term fix this works.  I'm willing to apply this to 5.0 with cc:
stable so that as a bug fix this gets pulled back to 4.2.1.  Paolo's request
for a comment is en pointe, so I'll wait for a version 2.

However, while running in system mode with a decent sized amount of guest ram,
I see 1-2M tbs live at once.  We don't really want to throw all of those away.

I think it would be better to put the tbs into some sort of data structure that
indexes the tbs by their virtual address.  I have no strong feelings about what
sort of data structure would be best, just something better than a linear
search of all of the tbs.  :-)


r~

