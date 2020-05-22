Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15EF0C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 03:02:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5E2F207D8
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 03:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vcORK9uw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5E2F207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbxwj-0001sH-2K
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 23:02:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49680)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbxvq-0008Fi-Az
 for qemu-devel@nongnu.org; Thu, 21 May 2020 23:01:10 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:36063)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbxvp-0002lx-Ax
 for qemu-devel@nongnu.org; Thu, 21 May 2020 23:01:09 -0400
Received: by mail-pl1-x644.google.com with SMTP id f15so3844282plr.3
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 20:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=1CASl+nN2OWJRcOUaa2Nj64rFuSWjt52Q8lXHCnRiZk=;
 b=vcORK9uwSHK9rHiZiNbWr3H2dmwSm98kz9xOWpC7yusO3d/JR4wbYU2GFfTrLv7/sO
 M6UpbRZ98W4G7z0Db7hLehQZ+6phJMwymhaAzEIvFn6S4FTw7oi03MdaUUnoV7xFBtjJ
 yxFmx4Gxry90P78cV8rTen9EQkMTaqzq4ujVWwXx/FZLpecF1JRppqp0ZOCI1TiktaRZ
 wfwKTH5sC+TX/HfdehbDdVBhU3T7YG/pBie4Fq0twjoG1YIL70xnEVeLVG20uxm98OCK
 BpB2R27eUxTPlqYNZwQcSFmo7/UjBKzRCrsMQI4LD1FrTRwiDrfS18Lv7YTpVUJJdN3L
 ludw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1CASl+nN2OWJRcOUaa2Nj64rFuSWjt52Q8lXHCnRiZk=;
 b=DAP3290Z3BoOoDgMgn1GOoBB6TKW6caoPoR3e59RheNUKmD49nGsfb4+5Gd4gOD4cf
 jM7SzWxvhEafKR6JEBldyAUMlmPBuC0nuSm0qD1tm/FN0juZjYPj4R5eJg+tCO8pvA7B
 YaEuYb5bX/UNGVQGDov+BhxIub0WHuAa8cN6FHSiylMrOYFMxt2XzgClQf6zNICKJyM3
 udRsLRau3EBSVzGYMO/YkbmJjhbVpOYOKb0BwcGkWLcTjPzzNB7abpFt9g4vKQn5owsr
 K7iRImwAD0hJaWt64Y/lR9mvgajUavk+9EM2HMjHQHp1TaOoK4H4ffc0Y/tLyVLdaT8W
 zS7w==
X-Gm-Message-State: AOAM532Fijf4utEw4jscbuY/v5H8FM8W5PjyULz/B/uu+MxkLtGN4Zld
 Gzf/dctepmJf/bjhL1g2tlcBPg==
X-Google-Smtp-Source: ABdhPJwfpW+YbsNPwFJIFTxMOLTesm5TVuAi/ZBwdztY+ZOnj+iGYhaZE6Zim+OQOjEwEbqyqZZc+w==
X-Received: by 2002:a17:90a:3563:: with SMTP id
 q90mr2007560pjb.0.1590116467916; 
 Thu, 21 May 2020 20:01:07 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id f66sm5605234pfg.174.2020.05.21.20.01.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2020 20:01:07 -0700 (PDT)
Subject: Re: [PATCH v1 07/15] tests/tcg: better detect confused gdb which
 can't connect
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200520140541.30256-1-alex.bennee@linaro.org>
 <20200520140541.30256-8-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0c8711f8-cd2c-05fe-2b89-700bbf69a8d7@linaro.org>
Date: Thu, 21 May 2020 20:01:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200520140541.30256-8-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x644.google.com
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
Cc: Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/20/20 7:05 AM, Alex Bennée wrote:
> While we may gamely give the right information it can still confuse
> the wide range of GDBs out there. For example ppc64abi32-linux-user
> reports:
> 
>   warning: Selected architecture powerpc:common is not compatible with reported target architecture powerpc:common64
>   warning: Architecture rejected target-supplied description
> 
> but still connects. Add a test for a 0 pc and exit early if that is
> the case. This may actually be a bug we need to fix?
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: Richard Henderson <rth@twiddle.net>
> ---
>  tests/tcg/multiarch/gdbstub/sha1.py | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


