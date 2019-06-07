Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC71C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 15:55:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C59B208C3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 15:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y4rMynFD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C59B208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49042 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZHD4-00044c-HK
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 11:55:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40944)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hZGGV-0005UA-24
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 10:54:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hZGGT-0005wL-45
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 10:54:46 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:34293)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hZGGS-0005rF-L2
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 10:54:44 -0400
Received: by mail-oi1-x244.google.com with SMTP id u64so1649252oib.1
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 07:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=oykOW0xqyylNU0yTsRwlj2mvGIda9u2XvA7uDPz5l6c=;
 b=Y4rMynFDdfYdnlnzn0l7h70xr1sTgPniuJf18HzklbToK7D8uj6tGJuOonlqPtDFL0
 0xgqiq3CETzX7Eh3QlufQB50Izm60jKLn0wWNimHYbhgzqJFkGLm3NEzBo73/hX3apwp
 OXFB/x/egd6CT9X302haWBlTLyM8tHDkHKfowyKygpm/GX/EyQ3MWTpKl8nKQ5sFBLNf
 aEzft9fahjvLPOgs2tafP4XRhlxw6+1eSGJQjYBjZQmDYVaVz56slPzHxyhxf9Gc65bU
 gvGk/ZEDOrMxBKU8vI7ke/VJA7nzTgclMF7peQEMhc8vVFa5EgKRW+p6h95nuO8BXQ9y
 MK7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oykOW0xqyylNU0yTsRwlj2mvGIda9u2XvA7uDPz5l6c=;
 b=ZnHN4FPhmAXi3r8kTApKAlmlru6Ate8mCVDQJI6ioiKZ50AVC0zJ19wamxFAL1rsuD
 9pv8q6AqEAmiCUrvpvDsORTyh4XvCVE0sBeHB42x5QMeI8Mdm5DW/myKEDmROJ64f91m
 ZEKWkqhmHxG+XgThuI51wG7zdeQrdqqstc7XSNPSMjvmDTyU9jAP//NpZuG7F+VOlnzA
 0gsNHchXsssV4zdlQ+Tdc3P4lXqiIlAmdamQIgaDTc1zGE+A6+mHuRtLE0CijupxQNFF
 wSi/3ZftpF+iiMnBtc1MJ6zsVtFJAGgExtbE9d9NsYkFQuLFUMMF2YIwNFi2/G2YK4Xt
 i2Zg==
X-Gm-Message-State: APjAAAWBwvjejqNMizi4vVTui2TUbdXGV1n3d7Nyfo5JK2RxXMh0v/Q9
 kfoewRuyD6cPlVSA3gm72K5W6VazwyvhYA==
X-Google-Smtp-Source: APXvYqyghk4iGZeaRwO0di8EVqUA9LoUsgIhJyr1mTtDSmxHFaSBDecbq/B0P07GXybpWIa2qw3MGg==
X-Received: by 2002:aca:3c1:: with SMTP id 184mr4067486oid.170.1559919283199; 
 Fri, 07 Jun 2019 07:54:43 -0700 (PDT)
Received: from [192.168.3.43] (200-56-192-86-cable.cybercable.net.mx.
 [200.56.192.86])
 by smtp.gmail.com with ESMTPSA id m129sm847753oif.13.2019.06.07.07.54.42
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Jun 2019 07:54:42 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20190606174609.20487-1-peter.maydell@linaro.org>
 <20190606174609.20487-7-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <56c34573-4a78-aea5-83f3-e00d89b9e33b@linaro.org>
Date: Fri, 7 Jun 2019 09:54:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190606174609.20487-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
Subject: Re: [Qemu-devel] [PATCH 06/42] target/arm: Convert the VSEL
 instructions to decodetree
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

On 6/6/19 12:45 PM, Peter Maydell wrote:
> Convert the VSEL instructions to decodetree.
> We leave trans_VSEL() in translate.c for now as this allows
> the patch to show just the changes from the old handle_vsel().
> 
> In the old code the check for "do D16-D31 exist" was hidden in
> the VFP_DREG macro, and assumed that VFPv3 always implied that
> D16-D31 exist. In the new code we do the correct ID register test.
> This gives identical behaviour for most of our CPUs, and fixes
> previously incorrect handling for  Cortex-R5F, Cortex-M4 and
> Cortex-M33, which all implement VFPv3 or better with only 16
> double-precision registers.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.h               |  6 ++++++
>  target/arm/translate-vfp.inc.c |  9 +++++++++
>  target/arm/translate.c         | 35 ++++++++++++++++++++++++----------
>  target/arm/vfp-uncond.decode   | 19 ++++++++++++++++++
>  4 files changed, 59 insertions(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


