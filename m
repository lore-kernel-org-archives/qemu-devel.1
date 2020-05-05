Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F58C47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 14:05:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED23A20735
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 14:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zgtxTCrm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED23A20735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVyCV-0005hS-1S
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 10:05:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jVyBg-0004ew-LR
 for qemu-devel@nongnu.org; Tue, 05 May 2020 10:04:44 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:45829)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jVyBf-0002w4-Ej
 for qemu-devel@nongnu.org; Tue, 05 May 2020 10:04:44 -0400
Received: by mail-pg1-x542.google.com with SMTP id s18so1052860pgl.12
 for <qemu-devel@nongnu.org>; Tue, 05 May 2020 07:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=GhlkG4VMX/x4KVCtRCMgN/lvPiq6CAjJbiul2wsOASw=;
 b=zgtxTCrmtj/ww+IDlMdxQ7c5Uf+Dcw/GyxnaxeEQr/32bme9fzIIdGAf2x3yhwN5zf
 HXzacErVDvfT8pM7ejq+SCu7wxagWfXcI3PpRKH3vA3VtppNKbHrCPDmuzyR1M5/HTho
 Fc6etHGV9o9EkFCbH49s0XEtzOD4e7egTV1UzSYtrLQWnXItbHX3mNEtK+s1DeZc4IgX
 bEZIc9dW2jyuDWCERRUTcKp1yFQJDmejqWUt71+j1uFoCn9f/eyaqHXKCa941pq4q+M9
 a2gsev2xr8vzUreFoY2KYaCUTP0qn/yaicSD4Pw/12X/ABjv6JjKCPEPiZHRRsMztNAP
 mBtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GhlkG4VMX/x4KVCtRCMgN/lvPiq6CAjJbiul2wsOASw=;
 b=WcuRGINMk+PhbMU5Q5u25y3iHw1iKWcfqF4TuoYkj6NSli3uqPIH+pcn13Gz3Nqk0N
 D3UYaHSgnlezqXBlaoaOkd/7xYtF88qJseBBMbUfHIN/WrnQNCL2PbNhnlGBmjaNL4fc
 MQNjWC/iAU7aW4iU2LyOwKCkXYFF0XLTqxQl0q+TUQm0lLpY6GZ/Q6zwCM78z/QNVBgE
 pqtBJ3qmGvJIfebVsZ57VMn1KlFcNYbDFRLY0knOUlpjRgAlSXV5yz4GPxfvJ4We5PuH
 2vZs/A3ZU3I+C9H0aHb5SurRFZUjOKqRdqAXjP0ftQCM+lCx50hDdbFAqonCqBZOWDjS
 5MHg==
X-Gm-Message-State: AGi0PubSYMgxnbWOpvUGgfZnme1mWIi18hUa9g+2JZiqFoITRcbA5SF9
 UOd7eQFpGtQHnbki+xxb0iVRfA==
X-Google-Smtp-Source: APiQypJRgptyg0AqOJw+L89SWqN3r3omavTuKvzES2hYIFtkCoF7MrwltS6c2sGgVqhOgGcMDyUyLQ==
X-Received: by 2002:aa7:9491:: with SMTP id z17mr3308647pfk.264.1588687481640; 
 Tue, 05 May 2020 07:04:41 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id a196sm2176116pfd.184.2020.05.05.07.04.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2020 07:04:40 -0700 (PDT)
Subject: Re: [PATCH v4 00/18] target/arm: sve load/store improvements
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200430162813.17671-1-richard.henderson@linaro.org>
 <CAFEAcA8m33s7e2T0GrZJxb4EyczcEmtW6-tRPoUsiVLO9g8dVw@mail.gmail.com>
 <20e6093b-edcb-c0e4-f4d5-b6ff4d51783c@linaro.org>
 <CAFEAcA-uupuSni8yqs6evWbjZDZyToit6Hhn8nQ=oSWjRuJjgQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a55cb2a3-9018-2288-bfe9-2fa3c2bf0050@linaro.org>
Date: Tue, 5 May 2020 07:04:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-uupuSni8yqs6evWbjZDZyToit6Hhn8nQ=oSWjRuJjgQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/5/20 2:49 AM, Peter Maydell wrote:
> On Mon, 4 May 2020 at 17:03, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> On 5/4/20 2:43 AM, Peter Maydell wrote:
>>> I've reviewed patch 13, but I still don't understand why you've
>>> made the size-related changes in patch 4, so I've continued
>>> our conversation in the thread on the v3 version of that patch.
>>
>> I've changed that here in v4.  Please have another look at this one.
> 
> The page_check_range() call still seems to be passing a fixed
> size of '1' ?

We only need to validate one page, so validating one byte on the page is
sufficient.  The size argument to page_check_range is so that it can validate
multiple pages at a time.

The target exception is raised by cc->tlb_fill, and there we pass either the
actual access size (probe_access) or 0 to indicate unknown access size
(probe_access_flags, or probe_access passed down from the caller).


r~

