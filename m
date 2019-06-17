Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39510C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 22:38:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01C92208C0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 22:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ji5Emqo8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01C92208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52332 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hd0GP-0003gm-6i
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 18:38:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35537)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hd0EK-0001sM-7V
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 18:36:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hd0EJ-0001Sr-BP
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 18:36:00 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:41145)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hd0EJ-0001SB-66
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 18:35:59 -0400
Received: by mail-pf1-x441.google.com with SMTP id m30so6421266pff.8
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 15:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=NwhWYIaXOuHsrBNqeF78u/3EvMKpu7Ee+yVipT9jIHQ=;
 b=ji5Emqo8dfl+Q7p4I70MViFQvY6V5Gy0/B+F9O6xxX10UVPH4TPe5vVZ1UBs76IUMd
 +iVUYX1h1d1LJAxPOSfJO88wHGJuQ5VleM3zb+GVocqL+xuFrYb+IjTU11wP/ba0iOv6
 /SKK667GWwqR1lCNaY1M5thwXEu+SVD8aLF79z8uoC8eF1QYcDT/Kz4Dch1BunldFTDQ
 ZAghUF4rLc50qUF2t/48i36xjjG7QazWqar8y7pz+/P5QIFKuGoOaYXHhVZVkaHiJsPP
 XDxdOuf55cOPCkA6TzvxPu+N67RI8mBO/y2LCIHxbQ2WrfDhA1zkNyh+ap09K7ZxGvS5
 4Peg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NwhWYIaXOuHsrBNqeF78u/3EvMKpu7Ee+yVipT9jIHQ=;
 b=jE1xQR0DM9Pj6PYy5VCMJBzHhryYCGrfncj2C7SDEaM805QN6gV9nSPOM4n6ABzL3p
 Ry0mnhucy7s/gq12WJqtMhSL1NndisZmfWnZqnHoAeTQcsN/itm+4PJPPLUE32r7MyMn
 pL+ohRu2sBGfhZjEvOpQ8TuoCsKolwpYCpv7p7eVqR9plcxrxS2/ZYtsDR7FvlITR1NZ
 ccHhuDjfa9p1s0JyWdr6T1LYs37ycWV2uMzZ7TLeaEQgBKlMiEhY0Iclm3qOs8V0qZoX
 NWlsiYZO1VNWXrAZ3x7oDtpp6eI4HB5B8TG25v+9FCNKb+KxfKHw8oUFho8SdJx2KmXl
 P2Ng==
X-Gm-Message-State: APjAAAVV0jA+8Za/XzNNO+w/Zh7gsPsE3u8GYw8hkPZKbv899j27N7Z3
 oDm5g2xD6ND8yT89klWByVr8jg==
X-Google-Smtp-Source: APXvYqwAcUjU0BHSNJtxP84rMv64h71sBPE0e+ed+wvryaI7FLFC7JnF1LZoM3Fcqcgli3XlI9jhqg==
X-Received: by 2002:a17:90a:360b:: with SMTP id
 s11mr1482973pjb.51.1560810958138; 
 Mon, 17 Jun 2019 15:35:58 -0700 (PDT)
Received: from [192.168.1.11] (97-113-2-33.tukw.qwest.net. [97.113.2.33])
 by smtp.gmail.com with ESMTPSA id z186sm12631187pfz.7.2019.06.17.15.35.53
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Jun 2019 15:35:57 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190614171200.21078-1-alex.bennee@linaro.org>
 <20190614171200.21078-32-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <9b460333-b207-c873-a571-2671ee7333cd@linaro.org>
Date: Mon, 17 Jun 2019 15:35:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190614171200.21078-32-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: Re: [Qemu-devel] [PATCH v3 31/50] target/m68k: fetch code with
 translator_ld
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
Cc: "Emilio G. Cota" <cota@braap.org>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/14/19 10:11 AM, Alex Bennée wrote:
> From: "Emilio G. Cota" <cota@braap.org>
> 
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/m68k/translate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


