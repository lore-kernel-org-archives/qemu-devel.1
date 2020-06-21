Return-Path: <SRS0=M+f9=AC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EAEBC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2020 20:51:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8D0924728
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2020 20:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MEfq5GJ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8D0924728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jn6w2-0004Ju-6N
	for qemu-devel@archiver.kernel.org; Sun, 21 Jun 2020 16:51:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36808)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jn6vJ-0003iG-AX
 for qemu-devel@nongnu.org; Sun, 21 Jun 2020 16:50:41 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:43712)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jn6vG-0003ft-7g
 for qemu-devel@nongnu.org; Sun, 21 Jun 2020 16:50:41 -0400
Received: by mail-pl1-x641.google.com with SMTP id g12so6604540pll.10
 for <qemu-devel@nongnu.org>; Sun, 21 Jun 2020 13:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=brCHUk63udbsRIT1D97INe01gFK0/4E9rOQ0E707l+0=;
 b=MEfq5GJ3YupQremSCFQF9xA9ktJsVcIlQWt3m7GFHWWUAVGhOSFYEHmjuJL/tLFLu/
 DUZXO+wU97HaVWD4aIkiCHDQnl2LZYQk+oUYm4cG4iIMh/A4j+3jZaMIVzW506+VaKgF
 Jr5BPL4rFk+bHk7uk3aGvhRS8lXTJFBk/LgPygdZKuxau1tKt4vv7HS8k9UQwRkwUtF9
 WSIPmF+lYygOB9UJ7Xs/tyZdoxjHuCnPdG1f6ltwX+decYQ4T9kZ6Bntx+m+6VThJ+8l
 539M9DTm8l2I7hNAFl2+gdjrNJPRdN3AFS/w9VjvmM97T9daIYaHcw7IPmi+havvFaun
 kHBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=brCHUk63udbsRIT1D97INe01gFK0/4E9rOQ0E707l+0=;
 b=kFOdfhji1mqqJrdDZ/yNLBpmQJoIt0a65g5TosvPQu1zBozmDbSfiY6YkahRdxWyOK
 KoYPpV2Xf9bVPOy4EIkbMIvUWi6Iwtu3HF+SV9udgRDR+hFTy5BG8Wx2Mh9mD0Xi9qW3
 Fzm0skuJIFirzWL9SvHwGq9IQgLAsNgx0PlarJpSd0pFjHdNEJQBFphiFRmHxY0Ijjql
 w8iGSwxhPte11WSXrmVL1ab9GgGWuiDSlmR7nPcaa9js56S8yk+DTFPiFPKAnwALxB6z
 IFJ7ENmELCahiXga0HIf43469KXCK5d0gGrG2RqpNvZ8ZbQ6ynl15HTRYZKv54dMiaTJ
 B7+A==
X-Gm-Message-State: AOAM533F49P92DhcQSi5Mqm/msP13tLrHlqbkIiXc1IqtDLGZM16cs6k
 knF93C47ae4YMDnl2d2nP6iL3g==
X-Google-Smtp-Source: ABdhPJysEf1LvtEmp2BxnLeevJBQPTNQLFphS/qqZb4qaunt/4baBw+Kqff2k/P8I2ATalyAXTrKrA==
X-Received: by 2002:a17:902:599a:: with SMTP id
 p26mr17578066pli.322.1592772636497; 
 Sun, 21 Jun 2020 13:50:36 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id h9sm11918736pfe.32.2020.06.21.13.50.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 21 Jun 2020 13:50:35 -0700 (PDT)
Subject: Re: [PATCH v3 1/7] hw/misc: Add a LED device
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200620230719.32139-1-f4bug@amsat.org>
 <20200620230719.32139-2-f4bug@amsat.org>
 <f2cc97dc-87c8-5cc8-e0fb-026cf80c25fa@linaro.org>
 <dfe79efa-0f77-6e86-c7e4-42fed7756071@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <134beb01-c080-1d37-a127-83d02a390cd4@linaro.org>
Date: Sun, 21 Jun 2020 13:50:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <dfe79efa-0f77-6e86-c7e4-42fed7756071@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/21/20 1:35 PM, Philippe Mathieu-Daudé wrote:
>> Is color especially interesting, given that we only actually "display" the
>> color via tracing?
> 
> The idea of this device is to easily visualize events. Currently
> via tracing, but eventually an external UI could introspect the
> board for devices able to represent visual changes such LEDs, and
> automatically display them.
> To limit the list of representable object the visualizer has to
> support, I prefer to restrict this device to the existing LED
> physical colors.

Ok.  This does suggest that we do use then enum in the structure.

>> Indeed, why not insist that description is set?  If a board is forced to say
>> that the led is red, should it not also be forced to label it?
> 
> Because when we don't have access to the hardware schematics,
> we can not specify the label. I'll add a comment about this.

Well, if we don't have a hardware schematic label, then we must have the i/o
pin; we could insist that the board label the led in some way that makes some
sense.


r~

