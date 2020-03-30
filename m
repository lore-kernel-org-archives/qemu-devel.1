Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C96C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 19:43:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8488320714
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 19:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jtibl0eq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8488320714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJ0JL-0005rJ-KC
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 15:43:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57697)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jJ0IL-0004qi-Fp
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 15:42:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jJ0IJ-0000ww-Oa
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 15:42:01 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:34900)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jJ0IJ-0000vO-6H
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 15:41:59 -0400
Received: by mail-pf1-x444.google.com with SMTP id u68so9108001pfb.2
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2020 12:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=YVbiY7GicWHT3QX2CL0ZaLYnW3hIV9PGbNKqy4yfuX4=;
 b=jtibl0eqJ5Fb5OJAP7gyy6d1F7TQFrpPmDl1/wEHmLi6SCO+gmj4hwoatDeOCruS5t
 a1Q36bq8UmxKLrNQ1xBZ1DgS6bnajkYSH8gt4vr6yCWi4aeLz9i49fMyKp2PO+UFnl+b
 ZajQ3pdxIbS4TpiaxGRqTAv2eKEeKRzpqsbXYmc4GHJYJa8GBXzKcANSaHkmH90RMmXi
 07sQVWckmoToJ1uzHzs18Ilj97IxF91m5b0mdxYSB+znoh0koAnIpri0Mi0PITwkbqlS
 yVcqBP7AN0alzQynrMA/YjksgMCevlBlofGm2WHnFOAR8+XYB1XD00FTARajm8QSbB5+
 h90A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YVbiY7GicWHT3QX2CL0ZaLYnW3hIV9PGbNKqy4yfuX4=;
 b=Zdck8nqK2nQfi3VIJbBQObiT9ZsY48z20DVABKJ2iy07Ag8Rtow1Z6FZvaH5t5Qun0
 t8ppjS7RQJJYCu21Nu+hprQkwovELi5ySG941I7pwZs1prfjtluzQg5s78ow3BOuGdSu
 D3fpoAjyscYPpwhGaqq3Xd+i/Q/aIgDdKofY4TKv8qEyrlpqOVTeYpe7MLMPViVDzXYB
 a16RuHdvAGBJ7PLX4z1JzYF1K5bK/PZ/XJsej5h/dPmEgyicxGWLvx2gqb9K/dtFMJIz
 mZVDVS+qTdP8BzI2ea+sEpluFObr0/gw35NETxxnYAwJJOOWWx63djlQASDMXJOs3ax8
 O/ug==
X-Gm-Message-State: ANhLgQ3aGwIX5kThaIuWRrzxZNdyYNgruo3Jrlahkweg80kdlA8BBiS+
 Ia6D2OGvadKCxkNxMm2lehkubhBJHXU=
X-Google-Smtp-Source: ADFU+vso56x8g1061h0dUh59oWCYjJ+/9QyOGCrm/7hrMaBAQpjpLSPbqM3a/w+mX3CGkWdAQBdlyA==
X-Received: by 2002:a63:7b1a:: with SMTP id w26mr13432725pgc.298.1585597317827; 
 Mon, 30 Mar 2020 12:41:57 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id w15sm10840325pfj.28.2020.03.30.12.41.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Mar 2020 12:41:56 -0700 (PDT)
Subject: Re: [PATCH for-5.0] target/arm: PSTATE.PAN should not clear exec bits
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200330170651.20901-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f24744e9-73a0-5f09-0b41-5ea49f41b8cf@linaro.org>
Date: Mon, 30 Mar 2020 12:41:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200330170651.20901-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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

On 3/30/20 10:06 AM, Peter Maydell wrote:
> Our implementation of the PSTATE.PAN bit incorrectly cleared all
> access permission bits for privileged access to memory which is
> user-accessible.  It should only affect the privileged read and write
> permissions; execute permission is dealt with via XN/PXN instead.
> 
> Fixes: 81636b70c226dc27d7ebc8d
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Compare the pseudocode AArch64.CheckPermission().
> ---
>  target/arm/helper.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Oops,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

