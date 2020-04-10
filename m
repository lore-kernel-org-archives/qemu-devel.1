Return-Path: <SRS0=FIxb=52=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC2C2C2BA2B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 14:45:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8EC120A8B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 14:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wpOI3nV8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8EC120A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMuue-0005wB-UM
	for qemu-devel@archiver.kernel.org; Fri, 10 Apr 2020 10:45:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53059)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jMutT-0004Vh-BO
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 10:44:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jMutR-0004lN-C9
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 10:44:30 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:55828)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jMutR-0004k1-6q
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 10:44:29 -0400
Received: by mail-pj1-x1042.google.com with SMTP id a32so848643pje.5
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2020 07:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=9iokJ5CCd8GDiPgiQ6G0CP+zEPYyk7zTwssL54FPTUM=;
 b=wpOI3nV8mhVwSvCYQWDvVrHqSzfOnxyVCdAWJRumDXCX9FAbKNk7kKSvJXEES7tzun
 4sxlffqoVrAle6uqRoZ2AqUFGQTkYNgm0PQ7xhXkRmb7SvcycntjhaBcZ8FWOfaF7Q5u
 RoMP9D8P/rPyhjrlZ/qJZ4BLtu4NaUtQHudD36qzRQDARD+zdk32E8dmx4sxjvzQzK5J
 OzqjKA5URi05i7NBnno4+XhiM0NLTeznSTYMgeDuvOaQCHjH03tCHlUh+bWesdTrF/Gn
 utrh6UFpQUUnyiTZxs0fssk1Gu5nGim0BPnb/hJekYYFv87Opu7RMm8K6+ILk5onmWsl
 w+aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9iokJ5CCd8GDiPgiQ6G0CP+zEPYyk7zTwssL54FPTUM=;
 b=CQZ2hOL8Z+oVm9o9AFEaiyrKNnoETkvUpEhH3VrmeFPY24na32THeiQ4woB0gK0Zm6
 zo81wXLaagmKxLkRSJa1ePEJqY3USKUBh0RUr9PVO8f+kDogsigZfH8oDZlGxU5EYloP
 2W0ng/hi2siiONvhQc70E1/d07GdX/Mnd4M/iVcX68lDgJ0Oa2OtpGzl1EX+Tufj5J4L
 7fwwU0vPWuJBiEHOW/soDLwO/wd80HqJ82YY+ZJEVufdvQH8kQ8uuR4C7LyFa9gFBrW2
 g0EynBY/WpjfjJDyKsMuG358Bs4v/cAz+xDB8/swjlf3KF9gInFptcWGu2U7CqkMDfwC
 w3fw==
X-Gm-Message-State: AGi0PuYDRsxxv+M2HBHkmmbSJG0mbXOlTBuPh+WrPnNW0yjGppwj7Aud
 51jJebAtWlH7Mv6Ttx7duCNTGg==
X-Google-Smtp-Source: APiQypJ50IIFeOAxzwzaQO0H50MS+NpirigiPQb1ehvL2GJN5Vcg7a+BgnHvGSnscUTGmJ6/hd7B5w==
X-Received: by 2002:a17:90b:3789:: with SMTP id
 mz9mr5873662pjb.38.1586529868130; 
 Fri, 10 Apr 2020 07:44:28 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id g9sm1752139pgj.89.2020.04.10.07.44.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Apr 2020 07:44:27 -0700 (PDT)
Subject: Re: [PATCH v1 08/11] target/m68k/helper: Fix m68k_fpu_gdb_get_reg()
 use of GByteArray
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200409211529.5269-1-alex.bennee@linaro.org>
 <20200409211529.5269-9-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8aedd9e0-2288-26f4-53ce-468af0413eed@linaro.org>
Date: Fri, 10 Apr 2020 07:44:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200409211529.5269-9-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1042
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Peter Xu <peterx@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/9/20 2:15 PM, Alex Bennée wrote:
> From: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
> Since a010bdbe719 the gdbstub API takes a GByteArray*. Unfortunately
> we forgot to update the gdb_get_reg*() calls. Do it now.
> 
> Fixes: a010bdbe719 ("extend GByteArray to read register helpers")
> Reported-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Message-Id: <20200409172509.4078-1-philmd@redhat.com>
> ---
>  target/m68k/helper.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


