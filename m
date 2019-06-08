Return-Path: <SRS0=KvPE=UH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABD1C28CC5
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2019 19:37:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CCC0214AE
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2019 19:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LvUQIXiY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CCC0214AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60080 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZh9a-0004tL-M1
	for qemu-devel@archiver.kernel.org; Sat, 08 Jun 2019 15:37:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37761)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hZh1f-0007EU-RV
 for qemu-devel@nongnu.org; Sat, 08 Jun 2019 15:29:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hZh1d-0007PA-4l
 for qemu-devel@nongnu.org; Sat, 08 Jun 2019 15:29:15 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:33711)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hZh1b-0007MN-N7
 for qemu-devel@nongnu.org; Sat, 08 Jun 2019 15:29:13 -0400
Received: by mail-ot1-x343.google.com with SMTP id p4so1706864oti.0
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2019 12:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Few9RiiSn+AxclU4x0nFNZNZgohCO1oJMVZm1YA3n1A=;
 b=LvUQIXiYC8rBSAI7WjxHJWhocXjIsPb0I1AWyadmJeP1Zls7s8pTPAlz0vczWeGlQA
 0ZW9Bb4HsWKk2a26xlsMJe/IhgaEww3mJVQ93c+zek+Q+0LwtoTbaITBLKmx4bcdV18x
 ol/PpRczv2aWlxlDeRfq86WWSsge9GErztJUWczUaU2L6NlG0py2nR7Nrh3X86ZOZ+kX
 rR1T6Y8oKbAX5rY6wZsX331mk7Eq7nds9Sy6GSLW2H3DhmYQGRBPhga+C4s7/Yga0EvP
 M+84KapK/WAB1q/j4K3D8cmJmoMsDE6k78qhNyZHL92BRQAeB+5+B3V2wCO1PlFSBul6
 KVOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Few9RiiSn+AxclU4x0nFNZNZgohCO1oJMVZm1YA3n1A=;
 b=mXq4gXmTQx8Fq6zHj+Wob34xu/jNT/GvxmDOZa7voShUOnI4YR9e9UCdNgUSn5llqZ
 i6zP0cktzPEcjdOelxV1pH1DUoSr0vjAHrWPMwV/p9uZClaFmCYFGc4B2Nae14is1ZWU
 Ye/hmduj/Niwgg4yn7kiA71e3yd2/JD04aWgedOpFkGuwOml0nXfcHWhunAIQydz3YSc
 Ou5DrILWbGMWzORQ0TYQgH0PfWtzvLxPv9MmOCH50TyVhKEbg84AarBr+lnD5czOUn0i
 cefyZUvLxyQiUolrs4Ia/UU/e8L1tO2OXCvxvdZLYUmlGivxHzkcKq7CwB8Z6+fatuw6
 R0mw==
X-Gm-Message-State: APjAAAURr0r8mBCWHgKj6D1wpOOzA18zEWEMSiL87Pgh1bygiVaiq5Nh
 VtmV5dc5inNOK5syPkRJdPgUdhUHj0AQZQ==
X-Google-Smtp-Source: APXvYqzMF10CnOO748BzH95qQkHMW8vkwm0HC6EFYrvb+6iILN5dDX+4TfXYhkFJFuOMprpP0BVFhw==
X-Received: by 2002:a9d:4b88:: with SMTP id k8mr25441128otf.285.1560022149047; 
 Sat, 08 Jun 2019 12:29:09 -0700 (PDT)
Received: from [10.219.49.199] ([187.217.230.84])
 by smtp.gmail.com with ESMTPSA id 198sm2187526oic.16.2019.06.08.12.29.06
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 08 Jun 2019 12:29:08 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20190606174609.20487-1-peter.maydell@linaro.org>
 <20190606174609.20487-30-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <e4fab1b3-6376-a896-be55-9297f778ceb8@linaro.org>
Date: Sat, 8 Jun 2019 13:57:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190606174609.20487-30-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH 29/42] target/arm: Convert VABS to
 decodetree
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
> Convert the VFP VABS instruction to decodetree.
> 
> Unlike the 3-op versions, we don't pass fpst to the VFPGen2OpSPFn or
> VFPGen2OpDPFn because none of the operations which use this format
> and support short vectors will need it.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate-vfp.inc.c | 167 +++++++++++++++++++++++++++++++++
>  target/arm/translate.c         |  12 ++-
>  target/arm/vfp.decode          |   5 +
>  3 files changed, 180 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

