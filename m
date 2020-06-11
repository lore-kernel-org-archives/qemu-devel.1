Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EFFFC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 16:58:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA5A9206DC
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 16:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SfTRBfY8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA5A9206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjQXT-0002mh-6s
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 12:58:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54872)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jjQWn-0001mJ-Ta
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 12:58:09 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:52545)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jjQWm-0005cD-5g
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 12:58:09 -0400
Received: by mail-pj1-x1042.google.com with SMTP id k2so2453604pjs.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 09:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=mghm8GE/lSyL9KLR/2FI+p8pVhqKllj6onED8w5EcDI=;
 b=SfTRBfY8CEQLAHztuJPnqKLGMgBlgBjTofnudxJoYMNPaL/g9tM5O2IiQFJWmhqQku
 +g2ASd3nzv6tRd8G8x1Rup9ZX7N+YmM97Fc3AofESLsjaTo/B+jQ+V4C1lN73+wfiqix
 yEbhes8l8NNmL4XemHwLCKWcrGwSueCY2NEk9aYL1PDnP+o29Rh7LL7alHHbo0QvLpCD
 mujN06un8SxhqR61jxSZjhjjptfIsdVbQXSfrADciLQogJN5xeCIui7etLOj8rXLajiZ
 xQGFkgQZ2hKGIUw24lPk954RU4+2q0SNLB3BUZWAqXGEmXzNSAouQa1Z7GwYMJuxoX6+
 cs8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mghm8GE/lSyL9KLR/2FI+p8pVhqKllj6onED8w5EcDI=;
 b=trhELbltewI7RalronisozSp9w3tt3aB64cDnW8kC7XZNuSyhgjnyUMZxU0VRw7PH+
 CFdHoSBdPxYo8QAW8lUX7yeViTYNsImXi61Y7qyqFemGQEvlkFRFEhHCW0jj+tBHgwW/
 MohuC1Gx2eXfu5JHWva0ZvW34TD9vUDLhAeDZsBSZvmJtFFhxXs5mCzVGCTaPoTqJu5I
 A1CcxhUlMWJsRXieuzjcXWy4XBX8hf3EYImtvQJPiejBh4AFnDNpdaWCO2MD4Zb/JXMg
 zPGhuLm/xw8GYEXRetYpd/VOsJxwltCpW+ZooiSP3OitllUOdg6FnhPEE9FXkAEb8czX
 yLiw==
X-Gm-Message-State: AOAM531+e9XAnOQ/0FrE4mcq57pWo6cX4Mha6RytoT78Mc3+/Si426cT
 ptDlBbZ4pTMqEw3tMBMGmi/JVw==
X-Google-Smtp-Source: ABdhPJynHaYQQ42zu5vD/g0lQtCwvnFwj5Xk2icxWOCAa9L2WD3pUQvTtgzSy9Ywv8wC4Q+4nbUIXw==
X-Received: by 2002:a17:90a:46ce:: with SMTP id
 x14mr8942173pjg.121.1591894678735; 
 Thu, 11 Jun 2020 09:57:58 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id fv7sm3138815pjb.41.2020.06.11.09.57.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jun 2020 09:57:57 -0700 (PDT)
Subject: Re: [PATCH v2 5/5] configure: Add -Wno-psabi
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200610203942.887374-1-richard.henderson@linaro.org>
 <20200610203942.887374-6-richard.henderson@linaro.org>
 <87bllp4kn1.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9d416d2e-593d-61c5-ab20-7b182a7bb757@linaro.org>
Date: Thu, 11 Jun 2020 09:57:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <87bllp4kn1.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/11/20 9:44 AM, Alex Bennée wrote:
> 
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> On aarch64, gcc 9.3 is generating
>>
>> qemu/exec.c: In function ‘address_space_translate_iommu’:
>> qemu/exec.c:431:28: note: parameter passing for argument of type \
>>   ‘MemTxAttrs’ {aka ‘struct MemTxAttrs’} changed in GCC 9.1
>>
>> and many other reptitions.  This structure, and the functions
>> amongst which it is passed, are not part of a QEMU public API.
>> Therefore we do not care how the compiler passes the argument,
>> so long as the compiler is self-consistent.
>>
>> Cc: Alex Bennée <alex.bennee@linaro.org>
>> Cc: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>> TODO: The only portion of QEMU which does have a public api,
>> and so must have a stable abi, is "qemu/plugin.h".  We could
>> test this by forcing -Wpsabi or -Werror=psabi in tests/plugin.
>> I can't seem to make that work -- Alex?
> 
> modified   plugins/Makefile.objs
> @@ -5,6 +5,7 @@
>  obj-y += loader.o
>  obj-y += core.o
>  obj-y += api.o
> +api.o-cflags := -Wpsabi
>  
>  # Abuse -libs suffix to only link with --dynamic-list/-exported_symbols_list
>  # when the final binary includes the plugin object.
> 
> Seems to work for me.

Wrong directory -- that's the part that goes into qemu, which also uses other
qemu internal headers.  As opposed to the tests/, which only use the one
"qemu/plugins.h" header (plus libc).


r~

