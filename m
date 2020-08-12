Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6628FC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 17:35:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E918920781
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 17:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dDgZhkSJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E918920781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5uf2-0004da-U9
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 13:35:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59896)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k5ue9-0004BL-FM
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 13:34:41 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636]:43610)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k5ue7-0002ya-TL
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 13:34:41 -0400
Received: by mail-pl1-x636.google.com with SMTP id t10so1415913plz.10
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 10:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=twzjaH8ZZBP8WkXK08piCUynzBhiLTSX6zjKSk8QjFI=;
 b=dDgZhkSJbH6VGrLkkw0Wn1a+SaoI4PCDkuzHij6ooErCkfaRPG9gAv/GN/gfGUNvnN
 w1tHrHm7GcUVOWfvVgaFJVNkeIvs//q7BPdDHiisQDklEG7JZzNVwJJv9SOF3vqz848U
 s/+sL7XLOnhZ9jV72AU8UPFnC53g9A59gSDmPGNnasQg2EpXtoicAjkHWW9rilZA/Ouc
 pEddmJpdPkL8Bx2iZLbrnt1/8ZI5BZdIc4fyl0fnptpc3VL6yWu/qwVJtLVi02nA/Vor
 I9slqmAWShK1xKG7ANaWrNNEpZHzm18pWNAX2Vn761QNicpjVUDBTh+v5pIM4iyUlJvb
 Zahw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=twzjaH8ZZBP8WkXK08piCUynzBhiLTSX6zjKSk8QjFI=;
 b=nNfm6rmuzBmPsb2e1UcDWukw+EUzoqEUKTjNQUR5Eizkeo/CTDGHijr+ya8ESoJtsl
 gaLsa0fr3M4iTspqSRrMWPaENBRP2RTgDbTk7DR8tBKrd8qGrhW5Ui2UIu0RZfGWETSa
 1qhlp7e5GO4nog4TxD66ZqmYRQTrUiQ7/xabhR2cEeY595Wn9mBPYxFr1iuFFlfIE9bp
 BQNWS5DhFjGPk4desveQnvOxucOqt3qh5ZDWcm+quvl9x5kNKJlN6C3SDfcv57urOio4
 iuqem4exFwIt5QYK0ZsNT2i3kKSfoKgCkTc1Y6sn5BCafwVtibfVnji01gM30Z1KeM/m
 3Y+w==
X-Gm-Message-State: AOAM532qnvZia21LDOsIXZPxQ+Vl2iiuh88fJrcgtv/GId/24HVzZs2U
 pp0fKlElhJh62eG4+2mFHdfBEQ==
X-Google-Smtp-Source: ABdhPJwJjjlibEOaFBUXT04u2DrHgK3XhMG5s/cvqanbFxEsP1z07QOX0A7aHuLMOb/QD9Dp78bOGw==
X-Received: by 2002:a17:90a:19c2:: with SMTP id 2mr1133307pjj.6.1597253678566; 
 Wed, 12 Aug 2020 10:34:38 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id x6sm3063948pfd.53.2020.08.12.10.34.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Aug 2020 10:34:37 -0700 (PDT)
Subject: Re: [PATCH-for-5.2 3/3] hw/misc/unimp: Display the offset with width
 of the region size
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200807143705.30066-1-f4bug@amsat.org>
 <20200807143705.30066-4-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d95b2acb-c8e8-91cc-40fd-ed7f4890e4ab@linaro.org>
Date: Wed, 12 Aug 2020 10:34:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200807143705.30066-4-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/7/20 7:37 AM, Philippe Mathieu-Daudé wrote:
> +    s->offset_fmt_width = ROUND_UP(64 - clz64(s->size - 1), 4) >> 2;

Better with DIV_ROUND_UP, I think.  Otherwise,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

