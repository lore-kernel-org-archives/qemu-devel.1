Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47842C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 17:00:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11296206F6
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 17:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SlNE/HIS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11296206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK3Cm-000486-3e
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 13:00:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41478)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jK3Bt-0003b2-6X
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 12:59:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jK3Bs-0006Au-BA
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 12:59:41 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:37727)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jK3Bs-00069A-5w
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 12:59:40 -0400
Received: by mail-pj1-x1044.google.com with SMTP id k3so1739476pjj.2
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2020 09:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ma2lk1nc9GnY51/C7hKzf1Ts2VhmpUMwz2k6NkX+ayM=;
 b=SlNE/HIScBH7KRybhxL/TW6Pxi7TmYbaYH4QemxC3VmqoxwAQSxEKeBCRMm41sKC51
 cOmhX4Br/93QZzHzwwGLTnqkG97CZeod0UbwI+nJDeruEfdUAO3RaFC2NKAbkAY2qAd6
 W/wKUOo3UdXCb9/8SmuYPkiGxlWn3NIlf7r3jan5b9a4730d8B8ROO0y6v9JjMHpgEqR
 3mu22mJ40niSqpkje2CEVzEoIJm5ZtQLVok+Y3hhcxEeEtL2sJhnbTqBADBYTa7rQjzw
 LeOH3fpKcaB1XWnpacdUyOLnPNvR/tpL+mWcjy0PcfSUVhNc01PgAezqNrXiddlZ0XPI
 L7wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ma2lk1nc9GnY51/C7hKzf1Ts2VhmpUMwz2k6NkX+ayM=;
 b=G8FyuJg6u0EhdqxfOF0nYYoqX5eDX5lU+f0be2NyroymH3ldqeiWpT/4SqrDP++9AX
 xg364RujeTbbLoCY4GrKbz5pL3EUhGNGAjqJK0KS2qxFi9iVfK0E5PaoTF2BuZJKo1Ea
 /Y9QEyeDY96W50cUPnMpRp50IWDXejJm82RmE1vrQc3RgK9hgS7iMO9z2kBqQzQuGV3n
 QO5n5kjSRVJ4ma2oeWB5PFh/M4atZfKMPSes4Bwivto9xbe8A4vdHB+Ipki0tgzsjmHD
 PiK9enQlxCGXS2L1J+Q3gbM/XGUB1aO594M+ISIlG/cOPWfzz/8zyjFCt3U1MXOzMBko
 lGJQ==
X-Gm-Message-State: AGi0PuZuClOpyPGDO89nciuEn9x7iROPNYaXlhcZjg2dc3biJ1VuhPIU
 sJlcYknwHSUtsfc5v7K3bFxCsg==
X-Google-Smtp-Source: APiQypKTi9RiQJMOshlfRkp4+lkr8eMi9YMfK6OZJi7FRgI3F0w7Xd1wqq1f+tVTkZLT3pLLxorUrw==
X-Received: by 2002:a17:90a:ab0a:: with SMTP id
 m10mr4588515pjq.173.1585846779182; 
 Thu, 02 Apr 2020 09:59:39 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id g2sm4122786pfh.193.2020.04.02.09.59.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Apr 2020 09:59:38 -0700 (PDT)
Subject: Re: [PATCH v2 09/10] linux-user: clean-up padding on /proc/self/maps
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200401094759.5835-1-alex.bennee@linaro.org>
 <20200401094759.5835-10-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <17d65b63-1182-bf75-a5e3-a92c97e1328d@linaro.org>
Date: Thu, 2 Apr 2020 09:59:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200401094759.5835-10-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1044
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

On 4/1/20 2:47 AM, Alex Bennée wrote:
> Don't use magic spaces, calculate the justification for the file
> field like the kernel does with seq_pad.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  linux-user/syscall.c | 32 +++++++++++++++++++-------------
>  1 file changed, 19 insertions(+), 13 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


