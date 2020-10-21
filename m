Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D32F0C388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 15:52:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 030FF2224E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 15:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AEjIlITK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 030FF2224E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVGPD-0002tB-W3
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 11:52:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48166)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kVGOK-0001y8-BC
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 11:51:08 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:42908)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kVGOI-00082a-K1
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 11:51:07 -0400
Received: by mail-pf1-x442.google.com with SMTP id x13so1711259pfa.9
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 08:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=MFZ2BRAJ+JZt3u/XgEqHbAUYMa2hJkfY79iRhscGrns=;
 b=AEjIlITKopPKmMtnpIoeAj6+XxUm9jntqoM45cXnvNjghUVdL1AkeOGR+7qZ9B2Ne/
 xPos3C7kx4Ki8o6SZ1b4W62e1Z1Z6IpMSGTFXxKbdOQ0clEBzlelrdwFQCJL6+VqxtBQ
 PgokSxkeXDdeFKIxd2/GOFcchMPg1BMnWbqLKtgsp70aN58RY4OCwit5erPDu4Mg42wa
 Ku1UD43Smxkq4ldPpsxKNtFfsZK4bsQa2Xk6f72uxN4fS71rzL03fEKzBJ60TPHaSvUS
 Mg+6x++ZRZVKRNFwtDlp+YOwk9hTUvrMUUB6IDm/o4LJhRdSRjv4fyvYks3XAkCrew+C
 maKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MFZ2BRAJ+JZt3u/XgEqHbAUYMa2hJkfY79iRhscGrns=;
 b=X9PkeONkBDrBNKlsGkDXYRDm5O2689/+cVa573J9RTz6Zd+SpyKmf2nrXQ8VsmG59U
 ITQVIuS/KXDbejQZfCYU4Cct18ZBh4u5bR5ED+O5S5RjBsW1q/bSgZPY8q2UprL8UvxF
 DYKiCtb5KGjdnJcYeXOA9R0wLTdw8Yfb/niRHVpORMtnhZaQSaT/s3Dy2rjWTV4TddbU
 XcK8r9yfkPlJ/ktgUUOdPx1jG5S7R+ywROyzLR9y0eNc7kWPjWN/PkdRO0cgFQpSr/zZ
 /qFC5bpliheGTQlJhmOe57MEkl2xW4LP1WJQDSjXHTGTwCyK+68kv9x+GEAmt0Z99iHp
 airQ==
X-Gm-Message-State: AOAM533jGisoApG8O2DwgARSXu+jn8JbkWrA4kyKCB6P2OO8m05DVL+m
 Qjfi37hmvbCg4/KFhEbGvYNYTmhsYpPmyw==
X-Google-Smtp-Source: ABdhPJwvbXuWAokGlHhc029V09627S8S00ZZ6S4y3iIu6oU/xy1x+wzGEOdbbMB+ma9fPQjQ6zDK3g==
X-Received: by 2002:a63:fd08:: with SMTP id d8mr4072840pgh.406.1603295464567; 
 Wed, 21 Oct 2020 08:51:04 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id e20sm2669262pfi.30.2020.10.21.08.51.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2020 08:51:03 -0700 (PDT)
Subject: Re: [PATCH 2/2] tcg/optimize: Flush data at labels not TCG_OPF_BB_END
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20201013222330.173525-1-richard.henderson@linaro.org>
 <20201013222330.173525-3-richard.henderson@linaro.org>
 <878sbzwrrg.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <46f2f32b-28bd-5164-edce-00c18d93b692@linaro.org>
Date: Wed, 21 Oct 2020 08:51:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <878sbzwrrg.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/21/20 7:57 AM, Alex Bennée wrote:
> The optimize function has a lot of goto's in it and I find generally
> hard to follow. Anyway:

Yes.  We'll call it inherited code that could use a re-factor.


r~


