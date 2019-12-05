Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A51C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 15:54:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D82C206DB
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 15:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fI/+wfKe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D82C206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ictSC-00083r-JI
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 10:54:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44064)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ictQI-0006kw-DA
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 10:52:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ictQG-0002xS-Tl
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 10:52:10 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:37654)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ictQG-0002vV-MV
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 10:52:08 -0500
Received: by mail-pf1-x442.google.com with SMTP id s18so1805485pfm.4
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2019 07:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=I6c6diq1Ql6j3x9Q9NkvoQDbig3gkxBNjDyu+kHu+e8=;
 b=fI/+wfKeNeOS/l1FlaWd45FUMaCAJ1oqn56HOnO+DdM9xWRmtnLoe184F9DwP9GtZK
 4YGh2tUxTzR2tyLVS4jWR4MXFSdKz0I0xlwKcsVvVWXVkCnefisaoOQyIDQYL6cBJYu5
 AYpuy4V4Q013F8WumnshA6ih8mXg91kN/97oUqVKRWEivwuNaSa7IsPfRBlmy2FKaExF
 1xunY3eSW3dWMnYWwudeyE9o3DLLqfkaqePpfwB7JSGbfOannRmwRS3FBW64emYMgzaO
 rOkQmUweV13m8x5QFd++spVgMZtyZHhoCSCScV2DAtwcOS9GvbvvjjyspeuYrH0vwNzt
 U/3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=I6c6diq1Ql6j3x9Q9NkvoQDbig3gkxBNjDyu+kHu+e8=;
 b=ePssZU7hltEL9ekOVvxJ2SxXIIHpq8QubViojJsNib0dgzHJAYoo68tVvf2hAGrRgG
 Kgp3QgWbLCGdKJMN9dAHRHuNIgZPzAOG6wGuRI5VqKGmnmE0Y34bLPb/ecgXQpEvQkcf
 SnSCxYeQHCuWclTViD2hhK7sErydYK9JjnerJSmUwsxOmDdKYwudcJL5J91fBd3fjYRQ
 Gu0YT42y1NQcVm0rl9O5gK6NgvZCUpRRUNxobKqBo1BR2JgtdYMalyi9cjdtWIswXx8k
 szIGytL5R89Ksex/0pshqxluWycuNc1VihWXf4J+AG0B6W7KZA3KHD9sHsUtZtyoyIbT
 d0Zw==
X-Gm-Message-State: APjAAAW/xjI5TMkeTed5hh3aOYjsfYu+1swWMBp1jlT7RskXq/3/IJST
 t6sCs/AkWFRixP48IJqHcpVYhw==
X-Google-Smtp-Source: APXvYqxiJqok6lcj6bHtIS85j/Wmh7zsV/EQSWYwNBV3n5ONz8gfrozoSXARnK2EZdR6aiP6/oUTgw==
X-Received: by 2002:a63:1953:: with SMTP id 19mr9851022pgz.157.1575561126968; 
 Thu, 05 Dec 2019 07:52:06 -0800 (PST)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id z7sm12954058pfk.41.2019.12.05.07.52.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2019 07:52:06 -0800 (PST)
Subject: Re: [PATCH v2 6/6] trace: replace hand-crafted pattern_glob with
 g_pattern_match_simple
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191205122518.10010-1-alex.bennee@linaro.org>
 <20191205122518.10010-7-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a6017413-0794-e5fe-e4c9-c9b61669d075@linaro.org>
Date: Thu, 5 Dec 2019 07:51:54 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191205122518.10010-7-alex.bennee@linaro.org>
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/5/19 4:25 AM, Alex Bennée wrote:
> We already use g_pattern_match elsewhere so remove the duplication.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  trace/control.c | 35 +----------------------------------
>  1 file changed, 1 insertion(+), 34 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

