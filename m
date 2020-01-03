Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F959C00523
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 22:00:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0647206DB
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 22:00:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZDra7KD6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0647206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inUzK-0001m6-L2
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 17:00:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37253)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1inUyf-0001L5-G5
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 16:59:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1inUye-0004zb-93
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 16:59:29 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:35927)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1inUye-0004tC-1g
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 16:59:28 -0500
Received: by mail-pf1-x441.google.com with SMTP id x184so24085606pfb.3
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2020 13:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=R1RJwsR0594wAciZlR+GLgwikPNEOnOi8LuUc4nRtm0=;
 b=ZDra7KD6VSwkDgZMps/KJnlorziS8P/w3rMlcFlVCRzcAQSCOlG8Uc4ON3ssUQInTl
 9s6eRo+af3VKX0OqPLFt294foCgfRa2qLLKssRUzuEMcQ2Dh8vVfr8nbYmbK4flKnaWg
 w1szd7qaG7GS9I7nXt2raP7smBfoPyyirDgelK7cjQ1nU3AEfsPd2yuWwnQITjM9qbVe
 /+q4dwBm1fKCQaZ7rRg5UYuh62uKEWfuHTLrE0etl9LksXs76Bnk/OXTTWn6qmWYQo/p
 RiVX1rm7FASMEAhp3e4kOG2tvO9ue6hO+bDLCxk9XuVYGXvakXK7/2jpoazwkdROdmaO
 0QEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=R1RJwsR0594wAciZlR+GLgwikPNEOnOi8LuUc4nRtm0=;
 b=n2egLWiW5lSHjHxDtMOoZ6yfsXUwALs3orgUX+8gKQGja466k30oINgUJcVnQppEuE
 pVLorM45mzzjFlPf/Yne7XyY5cIqtruIOwgkQjOEBKM+G7/2CQvGrC/bodvaF3c3Nx0C
 G4VXAvRKF9hcZHhj6wJWrYmEj3pMn1Ew7O63e5QKdYxUuQFDJ9cYS/Rretloqzue+YNs
 DMZd4t2hk0/diRyxjueuP3Bi59ARtpUNScW1QkJTJO72lQy7Y/SCutKWFDizNJ52S8kR
 jo6pX3vGmRGg+BqJR/zfqwQ2rTABzZtOHzHqZ2uQfoWC8JVFtMQszxgX0TcQd0k7VfKL
 Mlpg==
X-Gm-Message-State: APjAAAUnuPDETFUdXFEGJgnnpZlt32a/dg8jlkJrRAoUdQMeuub5CKXN
 IP6e57CyXg3fMaM2K2d+W2BG8g==
X-Google-Smtp-Source: APXvYqxozLIhr39Wg/Z8YavDRHYXm0/7+9xPFsQRiFxwrQRMC30zvqF0X57IYkbz+hCgHuo15etgYQ==
X-Received: by 2002:a63:31cf:: with SMTP id
 x198mr97035010pgx.272.1578088766491; 
 Fri, 03 Jan 2020 13:59:26 -0800 (PST)
Received: from [10.103.5.8] (59-100-211-22.bri.static-ipl.aapt.com.au.
 [59.100.211.22])
 by smtp.gmail.com with ESMTPSA id x65sm71239814pfb.171.2020.01.03.13.59.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jan 2020 13:59:25 -0800 (PST)
Subject: Re: [PATCH v3 09/29] plugins: Include trace/mem.h in api.c
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20191228231124.18307-1-richard.henderson@linaro.org>
 <20191228231124.18307-10-richard.henderson@linaro.org>
 <e93e6b71-60ca-3fb1-7030-a68b3877b8ea@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f684bf22-4b89-897f-7f03-3e6d86e06692@linaro.org>
Date: Sat, 4 Jan 2020 08:59:19 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <e93e6b71-60ca-3fb1-7030-a68b3877b8ea@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Llu=c3=ads_Vilanova?= <vilanova@ac.upc.edu>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/3/20 5:22 PM, Philippe Mathieu-Daudé wrote:
> Hi Richard,
> 
> On 12/29/19 12:11 AM, Richard Henderson wrote:
>> Code movement in an upcoming patch will show that this file
>> was implicitly depending on trace/mem.h being included beforehand.
> 
> Ah, it uses the TRACE_MEM_* macros from "trace/mem-internal.h", which is
> include by "trace/mem.h". OK.
> 
> Which part requires "trace-root.h"? Isn't it "trace/mem-internal.h" that should
> include "trace-root.h"?

I don't know -- perhaps it's not required at all.  I think I did a blind copy
of the trace related includes that were being removed.


r~

