Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D32C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 14:37:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71EAD21655
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 14:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RRSwl4xe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71EAD21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifPbJ-0004xQ-Cv
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 09:37:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37832)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ifPa8-00046J-1y
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 09:36:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ifPa6-0003DA-UM
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 09:36:43 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:35487)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ifPa6-0003Bh-OD
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 09:36:42 -0500
Received: by mail-pl1-x643.google.com with SMTP id s10so680516plp.2
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 06:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=4I97tvfKMitrkdF5Fr4FiNCpy5zuXp19tZu9yklSAnE=;
 b=RRSwl4xerrREgUaHPFRGjdEwLZkWmMs/7lhrhHm9aK3lT3xF97ub4nfb2uRMwGB6Ro
 IBUzG5MPZesDWl7qqgHkQGGifBxYUnGzJjSqQ9dsfmaPAVMN3F37hip/ZExT35+X0JND
 Y5GhaITJjSIAbEixIOgPTLh4KZ5fSOVucxLDX8P1OBB47kGBFUBpr0u4rpgkRa1pwKwP
 AcIiBhPbH9jM+A0VOs4X96j4vz55KJcmuWt5d8UDHZu4+QUs1HcnYHPE4KJ4SsdlSaUO
 RXeJo4kGi8VbbQeAgP2LCGO7nGlMcpkNEywDOLHcsNLWOQfJYUU2zx7b8MW78m+lVjd7
 UDsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4I97tvfKMitrkdF5Fr4FiNCpy5zuXp19tZu9yklSAnE=;
 b=rdL0UEwZuYwBs66FQBJ/rMcaQS8EOepNoQ7LhsFA23l+ulSKjqOtmhRbN+y7+e+4nR
 lS/Jb16cXXLlN3kNMzaN5vieptq0qYMhg8o04AxWygyD8sQVoI0sO1exKOjuQQsV7wI7
 siLR5hgUniV7QB9j1Piysqa1q9XJKGv6ePHmPz3LaIH+vu5YT47por56dmuI3j6sTlbf
 ne9HkSon2xe2JwEfFGdttY7z2EEYhDqTsmQUHXy+NT6KA/pZjb5IWDBoMo1bO+lPgC4i
 NP6xScSuBuLQ5Fe5Eic4FLUesnKBjCRh3Od+7urr6QZc28EK7cJpFwMJ0CbERSxioaZE
 58xQ==
X-Gm-Message-State: APjAAAX1XaqrWcoh5Y4KjORuWJho9n9tPIxPwwo7K7++dgMHIs/dYUqh
 xeWEYBlTsAzWDi+9mhcQscUITA==
X-Google-Smtp-Source: APXvYqxxo1ASiEzsNJ9CH27e7rE/AOGr3L8o63vdY9YD+vKSoO5S2to2ES5hdun0/P2lgx5GjCpGeQ==
X-Received: by 2002:a17:90a:e4f:: with SMTP id
 p15mr10084854pja.90.1576161401735; 
 Thu, 12 Dec 2019 06:36:41 -0800 (PST)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id k6sm7329224pfi.119.2019.12.12.06.36.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2019 06:36:41 -0800 (PST)
Subject: Re: [PATCH v2] target/arm: ensure we use current exception state
 after SCR update
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191212114734.6962-1-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ef020327-44a6-0267-2048-9feef99c1de8@linaro.org>
Date: Thu, 12 Dec 2019 06:36:39 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191212114734.6962-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/12/19 3:47 AM, Alex Bennée wrote:
> A write to the SCR can change the effective EL by droppping the system
> from secure to non-secure mode. However if we use a cached current_el
> from before the change we'll rebuild the flags incorrectly. To fix
> this we introduce the ARM_CP_NEWEL CP flag to indicate the new EL
> should be used when recomputing the flags.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Message-Id: <20191209143723.6368-1-alex.bennee@linaro.org>
> 
> ---
> v2
>   - don't override a ARM_CP_SPECIAL, use a new flag
> ---
>  target/arm/cpu.h       |  8 ++++++--
>  target/arm/helper.h    |  1 +
>  target/arm/helper.c    | 14 +++++++++++++-
>  target/arm/translate.c |  6 +++++-
>  4 files changed, 25 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


>              if (arm_dc_feature(s, ARM_FEATURE_M)) {
>                  gen_helper_rebuild_hflags_m32(cpu_env, tcg_el);
>              } else {
> -                gen_helper_rebuild_hflags_a32(cpu_env, tcg_el);
> +                if (ri->type & ARM_CP_NEWEL) {
> +                    gen_helper_rebuild_hflags_a32_newel(cpu_env);
> +                } else {
> +                    gen_helper_rebuild_hflags_a32(cpu_env, tcg_el);
> +                }
>              }

If you tweak this again, an else if would be appropriate.


r~

