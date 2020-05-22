Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80034C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 03:01:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F35D207D8
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 03:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kGDo6gfa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F35D207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbxvj-0007d6-FX
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 23:01:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49610)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbxv8-0006vf-2l
 for qemu-devel@nongnu.org; Thu, 21 May 2020 23:00:26 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:55488)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbxv7-0002V4-A8
 for qemu-devel@nongnu.org; Thu, 21 May 2020 23:00:25 -0400
Received: by mail-pj1-x1042.google.com with SMTP id k7so4312743pjs.5
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 20:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=WQErfsTEquluimVlvgbYHaUN2TAtUYIFGaoqisXqxkA=;
 b=kGDo6gfa2gvBRlQhL6aKzKJ/gJ88hU21/DWOl9tkkgpPEH9qwTcvAhwFKd/l2M9ny8
 M74fVU8PforiITGaPXwctRqOgE2FzrlU2klvpMfJfbSrMgR1oo6GzNzEAvvz9SkZXNvP
 KPxky37wB8jrupOz4qC7kmbkRlyu+bSO4nLh9uO+N8TaylM/lu/cDjB1Rj/YQNDryD2n
 Qj9TygFx06gIx95NRXB+i8of4gBpJvMlNEGJsaCzLoiadWitA/YcPAut2xuMknvNAHzv
 psdiCCnIEKlsJO4I4srxb/vbjmXC1oQeEnK9ouvvTdivg9cB/UF7Jff4JAWsKLNBgb8c
 0wpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WQErfsTEquluimVlvgbYHaUN2TAtUYIFGaoqisXqxkA=;
 b=R/PNZ3vf28cWyqXxMsOngVPFkzMOY5C2j1mFwpR3CAHrL0JBdsnS6i25md1oZsZf2+
 4Sg8E2OGYFHcACi1iZaHfD/pIHTXmAgC+R2UAeG0ZkIcK1K7MPHHuQwOkNKrQSlymL/K
 AhTtbibQxhudpSAYYvYgb9W5kFdxhDXYo6tdgnPnoAFeYI/DSyzz9sZMtxnxH11iHZ7D
 aFrSUsjXHMVKBhEOtuZnz4BkhHxvPuMrdjhj63y24Gttf3GWDei8YbbCi6ejML2q2/yM
 3AAIJFPPcH0GTvDg3C4Jl35bVv8h+2xMgwa0Y5jyNo/d1ADBnLHaAk54gqOho8tnLT5q
 PBmw==
X-Gm-Message-State: AOAM532S2i2JIjF49pQ05Aeb++BSe8LkRkh61OGff3k16lNUHyuqwdmh
 X1NQMCCXbqx5RlKRXLrSnwCXYGZ4woQ=
X-Google-Smtp-Source: ABdhPJyYcKsvcG3LXkg9ATNg/6l7rAxXDxDtZsmH2WMXSjo3CZVeOB8grhn6vOmJEb4jI3B4mBVmig==
X-Received: by 2002:a17:902:bc4c:: with SMTP id
 t12mr12773175plz.282.1590116423642; 
 Thu, 21 May 2020 20:00:23 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id d124sm5462530pfa.98.2020.05.21.20.00.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2020 20:00:23 -0700 (PDT)
Subject: Re: [PATCH v1 06/15] tests/fp: split and audit the conversion tests
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200520140541.30256-1-alex.bennee@linaro.org>
 <20200520140541.30256-7-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <44a0578e-61b5-ddc0-250f-fc3b9f12af2e@linaro.org>
Date: Thu, 21 May 2020 20:00:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200520140541.30256-7-alex.bennee@linaro.org>
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/20/20 7:05 AM, Alex Bennée wrote:
> Split the float conversion tests into separate groups and audit the
> tests to check what is still broken. I was able to enable a bunch of
> tests that had been missed before:
> 
>   all the float to float conversions
>   ui32_to_extF80
>   ui64_to_extF80
>   extF80_to_ui32
>   extF80_to_ui32_r_minMag
>   extF80_to_ui64
>   extF80_to_ui64_r_minMag
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/Makefile.include | 37 ++++++++++++++++++++++++++++++++-----
>  1 file changed, 32 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


