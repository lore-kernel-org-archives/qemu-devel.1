Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F9D1C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 01:28:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68C3F22244
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 01:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QiVdwyQk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68C3F22244
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUgRU-0006fp-8p
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 21:28:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46872)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kUgQp-0006GC-0G
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 21:27:19 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:53102)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kUgQm-0000Ts-G8
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 21:27:18 -0400
Received: by mail-pj1-x1042.google.com with SMTP id gm14so27865pjb.2
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 18:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=QLJDrFxDj4IHa3Ky07kLPgy3yaagFUrARkpDuqHrbDk=;
 b=QiVdwyQkDY8uXkUFV1GsBsaDSFeC/RRuYVOwhLUtTjxsGzILxdUFe33j9i9M1Ml8ZQ
 wPERq4dftbdoUFpWCUJL3o+/SMohhFhTiJgQAknSo3CaKiz5ruivQhFe3O2aIhPIxl1C
 rbeJPK3ftOPWjBb0zrsrmzNBsI/2AQSC7od8YewF9FIfeeeEJdcLb6g8RrcOYkvcHsOe
 u2wnoOccAJUZO/LWtKopjgs6Y3YkuFrcN8CtvvdxDyLTlvKO6Vw8I+F6K9d05H7+mP6b
 te6PLrdblFYCTQb6cVcbSgXDPCem8jcvT5Y49UpkXXrEPw1cu4cvtalLlc8vMILoqevo
 SkfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QLJDrFxDj4IHa3Ky07kLPgy3yaagFUrARkpDuqHrbDk=;
 b=tzfTo09tczN/fB+A4u54FlhuzqezGflhkisahrf2+FhYqiMVWh84F9+OqwHo/SfJSX
 y2xtyeKWYtAQ/haTBHrDKmDFFALE/jhpwAAXDOeP0PTjxnAqWiDJiVyRLkQ9YujwEiUj
 YlV1rOb67kBg4nkMjbKZWzKvRmBCFE+aFW/VKK7cZuxBcrZM9a5QEVNU0apVMFf6XzMk
 gO6jdcsFXtcaQGvW89u5suV+Kf8qDe5dKt+7vLrTRYw7fbfVolflwLLcidcMw9XHJgmx
 uAD9/voxG3eHWfBkS4x+fZpFUhE6jJFlJ81EBHbMajS+XMX3CS+VswwP5Y/JcK+i3sGe
 IJRw==
X-Gm-Message-State: AOAM530i7asy3sXRtIYwKGJ1q51f9+yulp/6KPp+pfIwdW+wr90oBMXa
 Te3VIPidg9y4IdG6Kxb3aL6YZw==
X-Google-Smtp-Source: ABdhPJzpmgUPDZaKWmKRGPaz/xsyyRbeRyVog1lEumgNSA0g2frtWdmNUdsoWQVJ0mrGJjzzr8czsg==
X-Received: by 2002:a17:902:ee52:b029:d5:dd2d:df92 with SMTP id
 18-20020a170902ee52b02900d5dd2ddf92mr504034plo.37.1603157234697; 
 Mon, 19 Oct 2020 18:27:14 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id nm11sm93064pjb.24.2020.10.19.18.27.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2020 18:27:13 -0700 (PDT)
Subject: Re: [PATCH v2 7/9] tcg: mirror mapping RWX pages for iOS optional
To: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org
References: <20201019013928.72770-1-j@getutm.app>
 <20201019013928.72770-8-j@getutm.app>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b6b0b72f-ce36-a5a9-912e-ce5c23b1dd9d@linaro.org>
Date: Mon, 19 Oct 2020 18:27:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201019013928.72770-8-j@getutm.app>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/18/20 6:39 PM, Joelle van Dyne wrote:
> From: osy <osy86@users.noreply.github.com>
> 
> This allows jailbroken devices with entitlements to switch the option off.
> 
> Signed-off-by: Joelle van Dyne <j@getutm.app>
> ---

I can guess why this performs better: half the page table entries and thus half
the tlb entries required.  Which for any non-trivially sized jit arena is going
to add up. [*]

In line with my comments re patch 6, and making this feature available
everywhere (or at least non-windows), the ifdefs would go away.  I might also
suggest default on for CONFIG_DEBUG_TCG and otherwise default off (when the
host os allows).


r~


* Which makes me wonder how much we should use the "const TranslationBlock *"
version of that structure in the rx mapping, so that we're using a tlb entry
that is more likely to be present, since we've just branched from the code (or
just about to branch to the code) on the same page.

