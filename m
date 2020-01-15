Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAEFAC32771
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 22:25:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0BD4222C3
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 22:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ViCuQIlj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0BD4222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irr6H-00038t-Su
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 17:25:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36276)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1irr5d-0002cY-QX
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 17:24:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1irr5c-0000M2-Rv
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 17:24:41 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:38668)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1irr5c-0000LX-Ih
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 17:24:40 -0500
Received: by mail-pf1-x442.google.com with SMTP id x185so9183908pfc.5
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 14:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=QUKf1kPErSPimYJHJpJWj0jRHEEjFnIDWMQB6HDFR9g=;
 b=ViCuQIljQ+l7xJ7bgELOrFqs7fOvokDVJuc1VgJ2XXhWhvE+YIE8l6c/1EdKDHENDX
 Yp86vSHty3Ff+bTiRWhGxKyY/G9UGig8gES5LFgyNpy/sGnDkhuMfGoZD+K51vACwyXk
 PqVdtNgl34G9DiFEs479if7ohx4iSzvNxDT2M2lWchqpvEKBck+ytaLJgae02BktB4YQ
 VUTuVKdnaINUl13wo1MgNQXS+WRSomnukRxBrmE/1HbaEpqDU0Vl3gjY7vEG/un17/wZ
 sacp9dxxRw7+EWttfxzXl8ufcq2LWXvSIcjFufUz0oxJILf25jIoQCCdYdjre8KJ0WeX
 114g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QUKf1kPErSPimYJHJpJWj0jRHEEjFnIDWMQB6HDFR9g=;
 b=iUOZ2rY6MHkWlRqg+NWZJeiM77QuRfoLjxrK2Q9ewc1EmyaD5VRpJLL1hViEXiD7Q0
 fVfyw8QeYQuqiGy3uQloz1AihghG5GOnNYLdn8I0suAg/l7wRudSaBBAF9pIBgy3a0uE
 MMHFK6jG6GhjfWE2fbrGO/vea5DwwUh8iwXGmogz17iJMGYCdlqKuTFqJCc+di9QrBR2
 CtwgAXl1cTTB40HyRpTh/wnxHTBeTwS88fJKAlF9c5/EP9ZNqO3CjyK2gvp0RDstYOIu
 Bd/A83jO91vDSMuRmQEYcmMuazdJWqYRW+IFBsiGxkIeJjjcdywSkJdgNCz5bifVfe2T
 P2uw==
X-Gm-Message-State: APjAAAVQMmr9G+kOofXraEm8n6tsPGYTZPG4ZDwtO/784IWIwLvaUxFv
 F+V1DAAqtQAPiKxKon4oDEJbdVu6LpA=
X-Google-Smtp-Source: APXvYqwH5LxK/NWbp6OewBfKdso0mXPoOfbF3Okv5sG1R0Zvo96ZOS8r3J3PKp8wm5RQjaIzTSVN3A==
X-Received: by 2002:a65:42c2:: with SMTP id l2mr34722007pgp.172.1579127079384; 
 Wed, 15 Jan 2020 14:24:39 -0800 (PST)
Received: from [192.168.3.43] (rrcs-66-91-136-155.west.biz.rr.com.
 [66.91.136.155])
 by smtp.gmail.com with ESMTPSA id c14sm22779881pfn.8.2020.01.15.14.24.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2020 14:24:38 -0800 (PST)
Subject: Re: [PATCH v5 13/22] tests/tcg: add a configure compiler check for
 ARMv8.1 and SVE
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200114150953.27659-1-alex.bennee@linaro.org>
 <20200114150953.27659-14-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <bc27ea7e-2ea0-fc2b-5dd1-88155eb8d7a4@linaro.org>
Date: Wed, 15 Jan 2020 12:24:35 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200114150953.27659-14-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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
Cc: qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/14/20 5:09 AM, Alex Bennée wrote:
> +
> +    # Test for compiler features for optional tests. We only do this
> +    # for cross compilers because ensuring the docker containers based
> +    # compilers is a requirememt for adding a new test that needs a
> +    # compiler feature.
> +    case $target in
> +        aarch64-*)
> +            if do_compiler "$target_compiler" $target_compiler_cflags \
> +               -march=armv8.1-a+sve -o $TMPE $TMPC; then
> +                echo "CROSS_CC_HAS_SVE=y" >> $config_target_mak
> +            fi
> +        ;;
> +    esac

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

What's the status of the docker containers wrt the BTI and MTE extensions?  ;-)
 We already have tests for those, disabled.  I currently edit the makefile when
I want to test them explicitly.


r~

