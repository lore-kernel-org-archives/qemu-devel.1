Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB34C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 19:35:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD6CE2067D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 19:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xrn+UEq4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD6CE2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv4EQ-0000Nw-1n
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 15:35:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46394)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jv4Dj-00087u-TI
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 15:34:35 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:38188)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jv4Di-0008Mn-E0
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 15:34:35 -0400
Received: by mail-pg1-x544.google.com with SMTP id e8so6468568pgc.5
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 12:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=EU7l4XgAZGABr37hID2GSkhn7UcHzA1mmhKwKI+4gG0=;
 b=Xrn+UEq4ZvYdQrh0AjXbpCO+VY2QQ76fUBrP86Lz77GNZ/G0Uqvr9CjcOUQ0yCCIgm
 pfwOB1wtSzOTWOFfI3ZIq3G9B2xxldm/wgdWslVqQcGP4fm9dFYcCuqqOYH/9PV5X1Cg
 m4ns15iI4Rd5Wtv6gmLRVBMtYUvTB9S6D782F/LXUhu3LD8W94xrt0XbftG0jAs7OZOZ
 HLD1WxSKgj29L3Gh2FZjAlMIkoSrVQHATrZ8EASbmj2a7XYDB/nb51wBKdGKkFEG03cM
 DLjVvKlT4u8Ilo1geSRFaeWGE8TxyDY5A/Uzawfd9kxtbB03w/IjP1HW72men2TiXNPS
 Jrhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EU7l4XgAZGABr37hID2GSkhn7UcHzA1mmhKwKI+4gG0=;
 b=rx7FMGLaEtOVDiLqWH95CgU2x4oE7lTpLj5hDi9Ks/RBCweG1yep8YZFOwaEkNXuth
 di17+CagqG/pPwdfTJoUWS0txAt1cE8e8HtzCDPc4kR1xeNFEdX3N/3veJEs9eEqlwOR
 Q8bjrWvD1LLU6Y/O82y1nC0LJnMSJ5ILECeu0NpUZYQX9S2ukaXCcsfGxEREEMT/xB40
 ZSbz0XQD6GAzl0OxhIZ/DZMmYGHLRiZjrtDJn961kFscBbM+49GFEY+VBgNMBkEzqali
 nUxPRRR/7nc1RWa9gCnPTkg11d1+6i2VN0iZNRX5UrPgz9QpBWhZNFb+kMlyu1xsqRXs
 8QzQ==
X-Gm-Message-State: AOAM532DwnMKCxA86kt4ILS7gF7aon9akaroNZJFuM+sj4OMmM+jCxgn
 1egRCTB6XjX4W2i4GkQzWeuFWpTAw0I=
X-Google-Smtp-Source: ABdhPJzyWT6DqMYDhXRyb/pzsSfoSegvJRX+eLuymRRAdPiYFuuXiVsXxllCd407OmpfEqtk1wqrog==
X-Received: by 2002:a65:60d4:: with SMTP id r20mr577016pgv.436.1594668872936; 
 Mon, 13 Jul 2020 12:34:32 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id 19sm15348116pfy.193.2020.07.13.12.34.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2020 12:34:31 -0700 (PDT)
Subject: Re: [RFC PATCH 7/8] fpu/softfloat: define covert operation for
 bfloat16
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, qemu-devel@nongnu.org
References: <20200712234521.3972-1-zhiwei_liu@c-sky.com>
 <20200712234521.3972-8-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <467ad569-0b58-7c45-6af3-71f0f86bfcd9@linaro.org>
Date: Mon, 13 Jul 2020 12:34:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200712234521.3972-8-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: wenmeng_zhang@c-sky.com, alex.bennee@linaro.org, wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/12/20 4:45 PM, LIU Zhiwei wrote:
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> ---
>  fpu/softfloat.c         | 223 ++++++++++++++++++++++++++++++++++++++++
>  include/fpu/softfloat.h |  48 +++++++++
>  2 files changed, 271 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Some "brain" references in here too.  In these cases, I think just s/brain
floating-point/bfloat16/.


r~

