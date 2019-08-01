Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48207C433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 17:14:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06B81204EC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 17:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DuBu0IHk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06B81204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htEeb-00027F-A9
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 13:14:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40110)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1htEat-00005S-Ev
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 13:10:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1htEas-0006oC-Gr
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 13:10:23 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:36036)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1htEaq-0006nV-LO
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 13:10:21 -0400
Received: by mail-pf1-x441.google.com with SMTP id r7so34433540pfl.3
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2019 10:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Qj7ocepZO6/QCyo06+teBm0RTl3v7/Ul1/dGf+j/QOc=;
 b=DuBu0IHkfTyu0cQ1m3E5yQ78o4Mynnibq0NnqHEL2bDFwbWFWJoDcehvhXAEIYVMi9
 blAljkyNhIhBkx4thhjMvS9mgqqgrOF9BYLvkNG2sOsIqm2tjIw7jsdEakGd7kzIZtMU
 /cYvYHiDZnrUcbVZg3amxyvWXrklUc0gS1a8PmPVevSPD5Fc8FVtuPcWfCkix+nglKR3
 /pLLwj7hNufLVZ1xPiGYYCPrHQjicWT5a2E2cFaA4SgzgYeWNos92XuSWzZd8mtgoUwX
 r/oykRzn1c908M4dAXjsq0ONU6OO6zI+xI1dDc6KCJHqLq/JwrdlI+WwUAJGxS134Yhx
 qBAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Qj7ocepZO6/QCyo06+teBm0RTl3v7/Ul1/dGf+j/QOc=;
 b=P5Hqn38ouZHmFO4lDDIAf7WbKQQF8pXJ7zKXkOEYzfGpI+50SZ1jd776NudDLdProA
 x/Wa6FindRnKM5a088ylsj/aFouzxCSMXhOvwEDwk63SU3MNsLLfGZiGjfx9RxZ8U/Kr
 NiUZednsZYNOzaY1K+MmpjiB7kh1D0Fb5+ra0lYHZVjaYWJlXLDDTdaKDHlpfigDIrAf
 vr7UqX9pNhsppbCke47bXJYfz1n65IQ3NCfwU/ceNSkIsU6pfDXY3lSmRvq+BX9aFr5D
 vxq5dAEfbw4q5YHhff1dDXNcCbbgTRgzRjq0t+oTUjXIAkN9U8Q/8mv7/WExqOcNQlpL
 rHGg==
X-Gm-Message-State: APjAAAVik0kqQDajCYe4UmMgbvbDOfX7+C/AR/tvjmwPfeXVoLJtE79F
 0UF0d80v9JJGyRmp7KdmoLX1Gg==
X-Google-Smtp-Source: APXvYqzIjzbiZRlWIp6nh1B0ZRcU+WwebDwqMrLID7ndFItbIMteRvlw+S28XW0pEKb6JcI07LZbzQ==
X-Received: by 2002:a63:3009:: with SMTP id w9mr46988696pgw.260.1564679418198; 
 Thu, 01 Aug 2019 10:10:18 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id p15sm5738859pjf.27.2019.08.01.10.10.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 01 Aug 2019 10:10:17 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190731160719.11396-1-alex.bennee@linaro.org>
 <20190731160719.11396-19-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <21c02eae-66bb-3d82-cad8-34b1d87ba104@linaro.org>
Date: Thu, 1 Aug 2019 10:10:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190731160719.11396-19-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: Re: [Qemu-devel] [PATCH v4 18/54] cputlb: introduce
 get_page_addr_code_hostp
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, aaron@os.amperecomputing.com,
 cota@braap.org, bobby.prani@gmail.com, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/31/19 9:06 AM, Alex Bennée wrote:
> From: "Emilio G. Cota" <cota@braap.org>
> 
> This will be used by plugins to get the host address
> of instructions.
> 
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  accel/tcg/cputlb.c      | 14 +++++++++++++-
>  include/exec/exec-all.h | 38 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 51 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

