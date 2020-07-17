Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 980D3C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 15:43:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DF4E208C7
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 15:43:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LzT+xMbl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DF4E208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwSVy-00033h-Jt
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 11:43:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43676)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jwSV9-0002Ia-U8
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 11:42:19 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:43084)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jwSV8-0001Jw-Bu
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 11:42:19 -0400
Received: by mail-pf1-x441.google.com with SMTP id a24so5556795pfc.10
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2020 08:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=mmys1wgP8zQtwKg3ohH46cLkzeGHR+W0DVMwoqEUbuw=;
 b=LzT+xMblJo3QKsyaM/YkDMW0RM3ljNhvVgskfRaQgh0WhU2Anf8pf7QoD16I+lH/7+
 NFbN5Sk5F5Mo+Q0WmjypTdmctmtL0hfhphiKJ7/Kq8W7iblP1zeFkVfn/Q71+UztdNDZ
 fgp8OBqqJedf33QPQ0nGTcoIWAVn8NEijKLTPN7dVue/vRbjqoogVQVnfG4S4iLRh7y2
 vlvWk76oYTkIUlbsNcVffBg/mr3DWqBwahqkX/3FKIHVu5BeZ/UvD4xQSPJvRVS6dT7l
 nj2SDU+limOKuMCqUn5P7PKqyCANT9GQ/RdcjlsIqgeyt+9b203oVcm7ACT4soG9LfDB
 mX2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mmys1wgP8zQtwKg3ohH46cLkzeGHR+W0DVMwoqEUbuw=;
 b=kEDon/GmnGSnV9/87NYJJhOra0FfUsTdZ3HQvhxW4TIrBCuxDbCZo/JZpa3KKJiM/+
 30mMS/ka+e8WlQGbWR4oN+MWN2r4T4Fr+ROBSCAX1sOP0yTIua7DqKj5llvyH6jk//mh
 sCB5Rin6H/74pJLW3otm6U/2GvSthANp6K6vrS5xtaCtoYH/bkVkKAUhLavQOOqcqPaq
 rupCYW4ylqE3o0ug7ZH+/2hjTBm0Y47GOl0aW7TkgO8am6BB562NcOarnM6ewCxuHiZH
 lW92gON6E5PkA+R61l2NH3jIuqNpC0GULYU95ebGQfYXs1f8AlGyNqlQYkBSLktXRbRk
 on/Q==
X-Gm-Message-State: AOAM533Oe8fBujBksOXBNKlvV3+hOE3K+MB4CROdkZnwlNtTjCWFVdEA
 IsqEs7g8QZ7FGTAnB0sW+dHwow==
X-Google-Smtp-Source: ABdhPJzPE4LFgOUXpqpNM8hc5FDhsMqqC9ksZXqS6iJZt2Ua3Wih/VzciGzJx/pHTNcUCpvc5v60fQ==
X-Received: by 2002:a63:182:: with SMTP id 124mr8617776pgb.288.1595000536658; 
 Fri, 17 Jul 2020 08:42:16 -0700 (PDT)
Received: from [192.168.1.11] (174-21-148-13.tukw.qwest.net. [174.21.148.13])
 by smtp.gmail.com with ESMTPSA id
 b11sm8078101pfr.179.2020.07.17.08.42.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jul 2020 08:42:15 -0700 (PDT)
Subject: Re: [RFC PATCH] tcg/cpu-exec: precise single-stepping after an
 exception
To: Luc Michel <luc.michel@greensocs.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200716100445.3748740-1-luc.michel@greensocs.com>
 <CAFEAcA_fGQoPXGg_t0jsXk7R+aSbWp9S+mpVJbAVZRr9FyUSpw@mail.gmail.com>
 <8e78c1c1-dd3f-fe07-5bd2-a0d8b0bc48ac@linaro.org>
 <5802fcc2-a6ca-2aee-55be-7e19126874e1@greensocs.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <43400b6c-7714-799b-4758-aff381e5acdc@linaro.org>
Date: Fri, 17 Jul 2020 08:42:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <5802fcc2-a6ca-2aee-55be-7e19126874e1@greensocs.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x441.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/17/20 4:01 AM, Luc Michel wrote:
> I wrote a small test case for the interrupt side that can be run on the
> virt board:
...
> This is with your fix. Without it, the second stepi stops on 0x284.

Awesome, thanks.

> Do you want me to send it? If yes, how should I give credit to you?
> Should I put your Signed-off-by: in it?

I'll put it together.  You can then add your Reviewed/Tested-by.


r~

