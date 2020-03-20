Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95261C4332D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 17:19:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 195DA20709
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 17:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q3CicDva"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 195DA20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFLJM-000061-1A
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 13:19:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59044)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jFLIR-0007fQ-T3
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 13:19:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jFLIR-00078e-01
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 13:18:59 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:34099)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jFLIQ-00078B-Q7
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 13:18:58 -0400
Received: by mail-pl1-x644.google.com with SMTP id a23so2794945plm.1
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 10:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=+z0ssscRi9I9JPRGHYRIAGsPUqdYaMCW9J3o/mvDgKg=;
 b=q3CicDva5QPI3EoNLD/dcUNmXE+UYkWZAv6oktfLlwW/k0R7pzwyeS/mHnfXwXu5hP
 poFmXpiY5qGqAHJOEe87q3dqQFp8meEaBHOG9PPkyzjq1ujPO5TNLcnpTbFmd2LC6AW0
 Iyrh5ScX1lUzQL5u8p9ds8V4u6Yw5z0mzUOsFYYwqtlYjTpF0qtRA10WWKg4ZV4cy77J
 Cwwoz7Egczf02HetOp2ntVN966bG6PZL8rXY71ap2BGp31L46LhDjc1zJ+5ZHx93tSzS
 FiQ4niwyeOVrLBoNmk6jxTD7jtzLWFXwci9C+iT40Kjn54R55FeBdjCWZsv+nDDvdbUo
 aDJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+z0ssscRi9I9JPRGHYRIAGsPUqdYaMCW9J3o/mvDgKg=;
 b=j675q4JcfukdWco/6qk51WZEuaEPckxSW7jXfYygTsZxvdf3QQVe38Bx7f0/ud5YZT
 24qp/h4tJwyyxnWRPpvUzOmtKhoeCRYZmt2y4RBWl3e1oK6XaVXvz9cGxF1zAUiaMD5b
 0beSEUwllL4+uQTjggxo88km2u8NKtAxIEcRDoXpiswW8vBCtSqFElqhfcF59+kgfCTH
 SvTvqVf9XmYpFIdyAhgYWQQyj0myoabE6ldl9Di5V+tbthGRscuB8m0HtWw5q6jLaYYs
 CJ38Ugsl2BIeV9KF7P+8edKmbuii/LUNa4OmPbSO/GGHkVB35JkLSbaNZqeUJ0byXFqg
 paLg==
X-Gm-Message-State: ANhLgQ3ttl5aq0fcwwC8LS92inoGT4gE0lF5YMR3sLII5MKOOjLRlH0f
 NIUG7a+m5Q3Ltn3hGl4yqMCVK1xVYxQ=
X-Google-Smtp-Source: ADFU+vsJx8HdgYsQkt7OgYlNVUMz+YYptEQ2peBHrhBBilvuE8vZXzbWlizUJE8NIwDMB1B9Hsz0HQ==
X-Received: by 2002:a17:90a:9481:: with SMTP id
 s1mr10409860pjo.114.1584724736122; 
 Fri, 20 Mar 2020 10:18:56 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 q15sm5815567pgn.68.2020.03.20.10.18.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Mar 2020 10:18:55 -0700 (PDT)
Subject: Re: [PATCH v2 3/6] thread.h: Remove trailing semicolons from Coverity
 qemu_mutex_lock() etc
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20200319193323.2038-1-peter.maydell@linaro.org>
 <20200319193323.2038-4-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9a520f2f-a7f3-1426-bf6e-c3950ac334aa@linaro.org>
Date: Fri, 20 Mar 2020 10:18:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200319193323.2038-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/19/20 12:33 PM, Peter Maydell wrote:
> All the Coverity-specific definitions of qemu_mutex_lock() and friends
> have a trailing semicolon. This works fine almost everywhere because
> of QEMU's mandatory-braces coding style and because most callsites are
> simple, but target/s390x/sigp.c has a use of qemu_mutex_trylock() as
> an if() statement, which makes the ';' a syntax error:
> "../target/s390x/sigp.c", line 461: warning #18: expected a ")"
>       if (qemu_mutex_trylock(&qemu_sigp_mutex)) {
>           ^
> 
> Remove the bogus semicolons from the macro definitions.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/qemu/thread.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


