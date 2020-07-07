Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C4FC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 01:15:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F464206F6
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 01:15:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FxTuUaZP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F464206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jscCa-0000yd-DK
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 21:15:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47760)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jscC0-0000XQ-C0
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 21:14:40 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:34752)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jscBy-0005yS-Ot
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 21:14:40 -0400
Received: by mail-pg1-x544.google.com with SMTP id t6so19225655pgq.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2020 18:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=m1u8I+LgoFcKYXrY632zaYasJfBZRnY7kEN2W3M75AA=;
 b=FxTuUaZPBLkwk2bi1UVCDYbweEpS7OzfKxQoZb3BHMfReSIpWDhJDyqtfH2J2QjcvV
 9EBfZJHGmbhbv7xWF0KolkInyFDGZILRBS9bLNQ5mj2Sf9yBnZxYWeXg17oTJOuGFXP/
 ZcTCZSDfNpjyvU51eqasbCN+jYkZaN78svhJ8GryJbXTJD+lvgL39p2Snt6EpNKlCrLf
 /HOYiZJo2kUju0eogi+CqYN+jjzICsiODc/7ut5M0cDSlvPuFjbJn5aIHWooDFyc8tbD
 dC5Hn0cnX5GtWc4WRFiEwBjKThKL+kG/JmWrL5JAlJ9aa5nmLAvAwCikoCqfZ0TCVhzp
 loBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=m1u8I+LgoFcKYXrY632zaYasJfBZRnY7kEN2W3M75AA=;
 b=FipzgQC5Mzv/PjzcpgdZFIOavu0dTVDQMiayFnBmAcDw5LGi8VpNZZfUbtbxECDmDl
 cfO3DOQ9HWVF66jwKqYqpm5cDDwjg3dqPMt9uozi82tcO2Vel8gDlnqKD0jSIhDrjZoL
 t8Fztl1La/7ABA21CiAOMLwm70Pu5Di6LUhsZ/F3rNv6BVDxMS0U3o3lxFsOzRQfqIEC
 fduxLvHWqWNFNFYaWYlZ2lgneTmqo9U1u/E9R2F3AXWLTLlHPrvcJdcFkRqSD91ZBHnS
 Y/mJrTp6nwOVacIeop8Z7ObXvkmmgE7deONMuXjxVYYbUazy5+4gDmNofILfO5N5L3sn
 BS4Q==
X-Gm-Message-State: AOAM530klxQuhypjcvynnwnDujhgO9NnH5mw23dumSCqRUczy0KtgcTo
 scVMo0VeRrA6Ic3KBrA/HdLsBw==
X-Google-Smtp-Source: ABdhPJyvEkbMKSdtL/sHKfzIBndwE2Nokq2t1e7E53CgxFso4TqzZ0VO/6l3k+p1eTfoIy0s61QlEQ==
X-Received: by 2002:a62:2b96:: with SMTP id
 r144mr46451703pfr.272.1594084476819; 
 Mon, 06 Jul 2020 18:14:36 -0700 (PDT)
Received: from [192.168.149.206] (097-090-106-114.biz.spectrum.com.
 [97.90.106.114])
 by smtp.gmail.com with ESMTPSA id x9sm19778277pgr.57.2020.07.06.18.14.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2020 18:14:36 -0700 (PDT)
Subject: Re: [PATCH v2] util/qemu-option: Document the get_opt_value() function
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200629070858.19850-1-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1dec6cd5-42f8-8e9f-cc87-108e46a926cc@linaro.org>
Date: Mon, 6 Jul 2020 18:14:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200629070858.19850-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
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
Cc: Damien Hedde <damien.hedde@greensocs.com>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/29/20 12:08 AM, Philippe Mathieu-Daudé wrote:
> Coverity noticed commit 950c4e6c94 introduced a dereference before
> null check in get_opt_value (CID1391003):
> 
>   In get_opt_value: All paths that lead to this null pointer
>   comparison already dereference the pointer earlier (CWE-476)
> 
> We fixed this in commit 6e3ad3f0e31, but relaxed the check in commit
> 0c2f6e7ee99 because "No callers of get_opt_value() pass in a NULL
> for the 'value' parameter".
> 
> Since this function is publicly exposed, it risks new users to do
> the same error again. Avoid that documenting the 'value' argument
> must not be NULL.

I think we should also add some use of __attribute__((nonnull(...))) to enforce
this within the compiler.

I recently did this without a qemu/compiler.h QEMU_FOO wrapper within
target/arm.  But the nonnull option has optional arguments, so it might be
difficult to wrap in macros.


r~

