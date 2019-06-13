Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24550C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 21:24:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1ECF2133D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 21:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VQyk9Asa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1ECF2133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45678 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbXDH-000879-5L
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 17:24:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47209)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hbXBL-0006Wg-16
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 17:22:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hbXBJ-0005nV-LE
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 17:22:50 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:41907)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hbXBJ-0005fY-Dz
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 17:22:49 -0400
Received: by mail-pg1-x542.google.com with SMTP id 83so217624pgg.8
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 14:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=OAP/upUtegrxqAywk24FWAl1YAXKXMifpg7i+kWaL5A=;
 b=VQyk9AsakF59WpTEM2iNIS+Zxmyf2WxC2h0aBiG7+xbT+1l+lDn6QxYq9G1Lslm6Du
 ndAAdx1P8ks3Qudmve6nEU+ycKt4I1B5sVW3iGjwjIHmGPvXDnXFVn74qHTjL0HeXaqS
 yblHsyehFoxyws9nktNbUCfCwhFTMmbkNxR2ng7tOWqjNDV/gfJY8+1gdFN59m/5aL21
 +mvwQxAtknQ2fHv1DS2LzRzSFJc+M6D2nM0SDH09RTc3Uc7fdolhDMxPw5HECWW8oTey
 gIykI/LrsnfEkNhtBmkRYomZFtBI5fAMqkLReQYmThQlVhLMMTtY3ztMtkZb7U+Zmz4M
 3j3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OAP/upUtegrxqAywk24FWAl1YAXKXMifpg7i+kWaL5A=;
 b=EpqJBJFvMfHADd1n+6oPGM3km3hkzg1osaaY+Y/iYYvFpXSFfe6K52IqPuxyTzymVX
 3ykDrlQc38dV5bLzSDgndIYIJtbSzKZ3TW0q3CwT48H3I2KzWl92wpXwYV4J9qFkI5WW
 5GvZPZata627NAmEs4uNFxXsl9Ug22OCnu176MijjKA92trilHcaoWiDoSEPX0aqD7qg
 uSkhHlNadGMAPSLjjx8ArCfJX+M8qywFjGbvgu8CH6kZJ7H/LWMfTO2zIHIh1Mxlikeh
 bB1mmsKlfqIc/wmJ0rskiNbTkaFJDT6Y9rUjA8Mt7eirgqCHoiA5mAaVdkQ/ohi0xA0K
 Ut5A==
X-Gm-Message-State: APjAAAV/zIetb/1FPAkd3cvU4xm6dtNpZrAA5TSRGm2vG4v31LNsZwOb
 xSwaDkHnxUqWucHIXPAQv0hwq5KRJB4=
X-Google-Smtp-Source: APXvYqzuELeCOSSLbc0i6pHjCLL9vYsoh3sINQx8j9id5ZTaWDPLK2XXAoAbPxjbN7xzL7MBYhLtVQ==
X-Received: by 2002:a63:161b:: with SMTP id w27mr32053658pgl.338.1560460952862; 
 Thu, 13 Jun 2019 14:22:32 -0700 (PDT)
Received: from [10.10.150.239] ([149.199.65.200])
 by smtp.gmail.com with ESMTPSA id z32sm699239pgk.25.2019.06.13.14.22.31
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Jun 2019 14:22:32 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20190613163917.28589-1-peter.maydell@linaro.org>
 <20190613163917.28589-2-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <774598e5-f859-5da2-0702-723ff0654931@linaro.org>
Date: Thu, 13 Jun 2019 14:22:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190613163917.28589-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: Re: [Qemu-devel] [PATCH 01/12] target/arm: Move vfp_expand_imm() to
 translate.[ch]
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

On 6/13/19 9:39 AM, Peter Maydell wrote:
> We want to use vfp_expand_imm() in the AArch32 VFP decode;
> move it from the a64-only header/source file to the
> AArch32 one (which is always compiled even for AArch64).
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate-a64.h     |  1 -
>  target/arm/translate.h         |  7 +++++++
>  target/arm/translate-a64.c     | 32 --------------------------------
>  target/arm/translate-vfp.inc.c | 33 +++++++++++++++++++++++++++++++++
>  4 files changed, 40 insertions(+), 33 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


