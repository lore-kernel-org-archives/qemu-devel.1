Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F1CC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 19:51:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E863A20720
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 19:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E1KHiP8v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E863A20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqilk-0000uD-7U
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 15:51:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54162)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jqikl-0008RS-AU
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 15:50:43 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:34086)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jqikj-0008Me-Bn
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 15:50:42 -0400
Received: by mail-pl1-x641.google.com with SMTP id o1so3740151plk.1
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 12:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=poUjJvC8sC6sOlWwuge3FMTzROoREPqJqLAKobWLZQw=;
 b=E1KHiP8v06ZbKdflOvATDTCxoAB4L7KJ8+rQ47ohG3PQc1sN2V5/KJqpUE1Y2V/Hro
 d4qs4Dk2W+27HLeD1sZ9k2LJmUbCOD3hN/0vlqIPHSB5/2NWjIiEx83LVBk0rbO1rTVU
 lhgQyNiwIxtZT3wsIOGjLMQ4X6KLzjn2wOF5XuTlEi9KntQHlETWy4C/jnwFyHM7hJBE
 sEmoeP5RpdwCM399Hsc4IjMt+TpXBL0S/rjT4I0P/aAvDr+jVJF8xgw/MH/KYOPDMZTf
 GoJv692AWjip8vHn1uMc5GyPZ1rK3d8+ztiBXcIZtltAXnIEOOktffD6Itrlz6Lpi7th
 sIow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=poUjJvC8sC6sOlWwuge3FMTzROoREPqJqLAKobWLZQw=;
 b=SIaAxhYX8z6C3cz/DWX/ND64NMBdQbLjI34zpNcy+raXeTqssfnDVwy702n3KUXYV9
 2VPupAAdIiRlK2XF19xrykr02oD5Zcfr3usUTni2IePi4N7Rm38HF6lnv/cm1EIgUZwG
 KBdyslrplby9dZhchGjqxX9/n3g4LWx+m5oDCoVbXmt166Qe/nUuyN0UBh5cPOaKzXRj
 +pJsPi6IGI/mTRYxeosY8pyuDfeyhnpXcPiwRVGFHFQP++MS1WdmdLPqB1NQoitIEvl/
 g1hySwgIRtE5X5kmQOMWokqn5mHERe2BouD2G+1sC6khyUzhM6b/2gD5leL8el2EB3TG
 FJVg==
X-Gm-Message-State: AOAM530L8tSpsA2K5Zs4rM8TUR6K2pzKpZ4gbxfeY5tgxcDeU+9TZGy0
 rfkwcJeg7HD4rugv2RBLh69poqVac/Y=
X-Google-Smtp-Source: ABdhPJzCy7PPlcj6O4eOag5HrfS8XhZdv2PWpY8lJ/bz5/VvQfNU0/Bb8BsN5eVdlHdWI0kPVzVhsw==
X-Received: by 2002:a17:90a:2367:: with SMTP id
 f94mr30362705pje.20.1593633039510; 
 Wed, 01 Jul 2020 12:50:39 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id h6sm6819791pfg.25.2020.07.01.12.50.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jul 2020 12:50:38 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] docs/devel: convert and update MTTCG design
 document
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200701161153.30988-1-alex.bennee@linaro.org>
 <20200701161153.30988-3-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1d5b8360-ea5e-cb5d-6a65-dc88f3acafb6@linaro.org>
Date: Wed, 1 Jul 2020 12:50:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200701161153.30988-3-alex.bennee@linaro.org>
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/1/20 9:11 AM, Alex Bennée wrote:
> -This document outlines the design for multi-threaded TCG system-mode
> -emulation. The current user-mode emulation mirrors the thread
> -structure of the translated executable. Some of the work will be
> -applicable to both system and linux-user emulation.
> +This document outlines the design for multi-threaded TCG (a.k.a MTTCG)
> +system-mode emulation. user-mode emulation has always mirrored the

Full stop wants capitalization for the next sentence.  Though perhaps em-dash
or semicolon would work as well to connect these clauses.


> +guest (TCG_GUEST_DEFAULT_MO & ~TCG_TARGET_DEFAULT_MO is zero) and the

Isn't there some markup for code?  `...` perhaps?


Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

