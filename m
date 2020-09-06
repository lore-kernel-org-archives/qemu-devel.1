Return-Path: <SRS0=M8gQ=CP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA0BC43461
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2020 04:06:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5577220757
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2020 04:06:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q6FOcskI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5577220757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kElwJ-0006nq-Fg
	for qemu-devel@archiver.kernel.org; Sun, 06 Sep 2020 00:06:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49312)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kElvh-00064r-QV
 for qemu-devel@nongnu.org; Sun, 06 Sep 2020 00:05:25 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:37527)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kElvf-0005cb-LR
 for qemu-devel@nongnu.org; Sun, 06 Sep 2020 00:05:25 -0400
Received: by mail-pl1-x644.google.com with SMTP id c15so2945103plq.4
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2020 21:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=4bOBXnPOHjK+hk6GMPRYVjhEvu4TqfxlUJKnmvGCrc0=;
 b=q6FOcskImTfD6XnY3Tw7SaC+nUT9c9L+6vJUEyFfyR35lJ6SeJMDpJbLs+XVfVdyyH
 ZygKLBD6SkorPOcLhJivhnjb64MkECQs+ZERAcBzgnG39d5+Go37hDxqP/6Ug88j8OoE
 Iq4iDCwuVX6HMAKWtbYGM7eNxe6fGI1mMdXI7YxHCK9eIwTpbLHVw1kUlxc7cjlb/c6I
 tsAmi765uY3qSHvSsUtsiSWY56hiGkT1K+KV+zAI1P1g4TR/hTHQl2L2XEdEhmiZRuLY
 pJTxuQVegQmpMLD+lZJdAdF6NUP3OO+1CoMwiPzFR7SJs/9kA75O9enBy5tHCOAy9hXh
 PBoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4bOBXnPOHjK+hk6GMPRYVjhEvu4TqfxlUJKnmvGCrc0=;
 b=Vpz6mM2OfT89mZskHuOb3KIP33n70rpKHoPhXZg7h2GQLexYOc74d35VSUE09Ajt2B
 Hb1MvYeBo5opgutZcTniMbsXXAQnRC9UgN4Rgvmsa0UijJqjH56jKx2BEN/z4lubmBju
 M04viLdNcW6vJZ9jxW706z2cK5oNpppJoXIoRrnFU0tDPLhoIXbzB95dTy9TMhgP5rcd
 /zVmpK6f/vRUO1Hpvw3Gj50uV0Higv+37V9jREx9qwUVRdWWTj6U+5sY/2mQNYCco0Wk
 VMvEiQPyGz1mPJyIxyRkzFW4c5rKnyY5p1CXkdQh4RfkeCMbOtyy5F8A3qHIckeEsAej
 NrmA==
X-Gm-Message-State: AOAM531fpEd4TeP0KQTwMYNxtKeR8mLtHMa4oFhcgBQTsq/2WVFyM8Aa
 UEQ6MO63z59QcClAPY6EEW051w==
X-Google-Smtp-Source: ABdhPJwiUdyLBjH/Q561xPehmnpXmlT3KD4XdCliYuz0/Uo5FxxjcGzBMWNwRY/OaOVelzgteK9Waw==
X-Received: by 2002:a17:902:a60f:: with SMTP id
 u15mr14637960plq.239.1599365122305; 
 Sat, 05 Sep 2020 21:05:22 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id j12sm9072890pjd.44.2020.09.05.21.05.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Sep 2020 21:05:21 -0700 (PDT)
Subject: Re: [PATCH 13/13] dma: Let dma_memory_map() take MemTxAttrs argument
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20200904154439.643272-1-philmd@redhat.com>
 <20200904154439.643272-14-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <950d8fa6-0514-f305-8934-21b28e9bbbdc@linaro.org>
Date: Sat, 5 Sep 2020 21:05:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200904154439.643272-14-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.107,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Peter Xu <peterx@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-block@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Richard Henderson <rth@twiddle.net>,
 Laszlo Ersek <lersek@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Beniamino Galvani <b.galvani@gmail.com>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm@nongnu.org, Jan Kiszka <jan.kiszka@web.de>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, John Snow <jsnow@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-ppc@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/4/20 8:44 AM, Philippe Mathieu-Daudé wrote:
> Let devices specify transaction attributes when calling
> dma_memory_map().
> 
> Patch created mechanically using spatch with this script:
> 
>   @@
>   expression E1, E2, E3, E4;
>   @@
>   - dma_memory_map(E1, E2, E3, E4)
>   + dma_memory_map(E1, E2, E3, E4, MEMTXATTRS_UNSPECIFIED)
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


