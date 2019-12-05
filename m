Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C377C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 16:02:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66BEC20801
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 16:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g66g+HDP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66BEC20801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ictZf-0005sL-Vb
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 11:01:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44013)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ictQH-0006k0-O9
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 10:52:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ictQG-0002vv-Ln
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 10:52:09 -0500
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:43689)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ictQE-0002sg-MI
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 10:52:06 -0500
Received: by mail-pj1-x1041.google.com with SMTP id g4so1444751pjs.10
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2019 07:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=wqAoXiEjUIMWUPGYNNwe7ZMlbNcCiTvjoJ1uD2nm/4s=;
 b=g66g+HDPY9gb8fGvy1U+sucV7hb/r9LpMvcNqSGo5QpvzNFB/uXvGhtUOz3TRXdHaM
 I531pJd5vlQLmtfJ5BWGVUCB4wlSVrXgByFwccmeoH+QYEK6ZNTyzMpcGQTGM08F0Eoq
 tC9c8XM9kwaweANd6PLOVK33G8iSViW4TmB28Cm/vYxM9FMs9gjGow+1+OQSHx5kowKj
 3q92nk0CCU7q4dDDB8pOJca0dFMk8gzvFSfsTJJVr7vCSkKKRBdNcR+3t+ljFWCPVrth
 7OOHtUfgJY6jqs9c8IN+BRiuxJSK9Sbf5c0415G+S85U9UGZk0JNvwWh5sqjRoOib/Fo
 ehEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wqAoXiEjUIMWUPGYNNwe7ZMlbNcCiTvjoJ1uD2nm/4s=;
 b=iZ2sNPvx83/5Bu4yBMKiO42pXGDifo4fUCxdae/7egpBQ3tYu6Ts+qHhh2Zd5yDZQA
 XVEqcQ30NWcNGQl0QsQggk75lG7dFNlV0wmvqAmGIAjmQOW3os+S4D8PiREVYByWpNXs
 wHTtAX4RwsNUazViXfNSg94XU/tQcAW1xSs9dgwV2ZsE52R66NrwEksZDJrM7Ukuvv1F
 LTADhD+iFQYZwVfKjwAc41F13ROSDiztXAJdnQvLWHR7NJFRW+UbDF+//YHJ8mQzrY4X
 pAlM5yuPEN1NYaSHvanmGkfXffs6lvHJoM5yPY0UEwkY8P3Y4mqPI438HP8v0/tZrOGd
 Ethw==
X-Gm-Message-State: APjAAAXWhRzTe1K1gfxhie9+5QCCSzua6FmEbZpYDHTeJpTFkbmNzC2O
 58FhHxSXKPLK8VMt0/oMa7100w==
X-Google-Smtp-Source: APXvYqwmFKG0cf5VVsU6LppjI30NQN/su/qcEsuPIzgi5vpYmWq9HwI3RYBH89INTfwIpALS+c5tCw==
X-Received: by 2002:a17:902:7c04:: with SMTP id x4mr9769350pll.0.1575561123946; 
 Thu, 05 Dec 2019 07:52:03 -0800 (PST)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id l18sm12355321pff.79.2019.12.05.07.52.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2019 07:52:03 -0800 (PST)
Subject: Re: [PATCH v2 4/6] linux-user: log page table changes under -d page
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191205122518.10010-1-alex.bennee@linaro.org>
 <20191205122518.10010-5-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <da787d4f-fe92-8813-1ba4-3832687bb9a4@linaro.org>
Date: Thu, 5 Dec 2019 07:45:34 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191205122518.10010-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1041
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/5/19 4:25 AM, Alex Bennée wrote:
> The CPU_LOG_PAGE flag is woefully underused and could stand to do
> extra duty tracking page changes. If the user doesn't want to see the
> details as things change they still have the tracepoints available.
> 
> We push the locking into log_page_dump and pass a reason for the
> banner text.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
>   v2
>     - reworded banner text
>     - moved locking into helper
>     - converted stray calls of page_dump
> ---
>  include/exec/log.h | 5 ++++-
>  bsd-user/main.c    | 2 +-
>  linux-user/main.c  | 2 +-
>  linux-user/mmap.c  | 8 ++++----
>  4 files changed, 10 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

