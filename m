Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B52C43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 14:29:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4C5E20675
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 14:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PH+y15jK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4C5E20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icVel-0008CV-TK
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 09:29:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43559)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1icVdF-0007Fq-EX
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 09:27:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1icVdE-0008Ck-6O
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 09:27:57 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a]:39142)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1icVdD-0008CB-Td
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 09:27:56 -0500
Received: by mail-pf1-x42a.google.com with SMTP id 2so224543pfx.6
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2019 06:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=c+wIFIjlqHG4p7JVBy4Y8PWazzAGhVa8/SzBiB5nu5c=;
 b=PH+y15jKqBeQHR/2iA7cpfm/UTVKrGGKGaRJH491jpWZXO3B23srM/RES8TRynmit8
 kXusorqA3Zpm4csjjRPter0xpNNjWcvpvW8CjqTLJXlvLZ4Rzj5T8l92PeQGHKn0vOqr
 gaxDmrXtHaO4hyyb9eHPlpTfxKZCiG2S1HPiQzNjLognPeCMuO3Iswfu+6WhOdYfJlYW
 Brv5ugPuXE3RMLxnZ9cLNHjD9cRwRv/8L3elNNF4dhZq+yFoV7Xj5IILAVWLWtAFacdJ
 UReky7ktM5s8ZUtkcG3o/YvhI/45kSD9sT4QybMzSqB8y9CNNIzfi+A20NdzupkIWlUG
 1Neg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=c+wIFIjlqHG4p7JVBy4Y8PWazzAGhVa8/SzBiB5nu5c=;
 b=dH/NtXlWI7vuhar9bc667LLBb1cbrl2U02IUadTVSeHj3watSvgM/U2WW9i7VUV6Qo
 C/s1ttGyi5OeZBVDbtSJegqhIdxxMdv+gub41jOApmzn5gCdxd7kVrhwp6QzHS0gaW3A
 gD56mmUCd0lsOYwDwCljMm2Sxr6/5JWTiSQhN9tDKXUBEVomxVWAztWAuIamH36xxBRx
 wY9tldhRTswijQL1k9BWNfvEXnOGWcCGPwOiwnGA4ZSmViz4I1AeXdVSBjBjCebQF6aZ
 zbs0TYFrleOeAc5XRB0O96ZALQ0SxF+Y2lYUYZH5wsCzDXk2QqHSYyXVRnupDOqR8VfD
 CnkQ==
X-Gm-Message-State: APjAAAWWvIRC62bcpXNksH7m0RHtAJcXGZvUxVlMyTdC784An8sYcb4E
 0u872LHv70RI8ionx+Gsv+5r9Q==
X-Google-Smtp-Source: APXvYqzyO4lP7JICsYrr9B1NTgR8tX4AqvFj87W3wVzY9ITfh6v/17Cr0BFz3G2r9cpP3THfsje3Sw==
X-Received: by 2002:aa7:8397:: with SMTP id u23mr3766495pfm.125.1575469674553; 
 Wed, 04 Dec 2019 06:27:54 -0800 (PST)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id e11sm4639pjj.26.2019.12.04.06.27.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Dec 2019 06:27:53 -0800 (PST)
Subject: Re: [PATCH v4 14/40] target/arm: Recover 4 bits from TBFLAGs
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20191203022937.1474-1-richard.henderson@linaro.org>
 <20191203022937.1474-15-richard.henderson@linaro.org>
 <87y2vs8gf1.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <dd46a349-cbe2-d114-90f4-5d9b8c7d6d84@linaro.org>
Date: Wed, 4 Dec 2019 06:27:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <87y2vs8gf1.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::42a
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/4/19 3:43 AM, Alex Bennée wrote:
> I'm not sure if this visual aid helps but here you go:
> 
>  *  31                  20 19    16 15         10 9            0
>  * +----------------------+--------+-------------+--------------+
>  * |                      |        |       TBFLAG_A64           |
>  * |                      |     +--+-------------+--------------+
>  * |     TBFLAG_ANY       |     |   TBFLAG_A32   |              |
>  * |                      |     +-----+----------+  TBFLAG_AM32 |
>  * |                      |           |TBFLAG_M32|              |
>  * +----------------------+-----------+----------+--------------+

Oooh ahh.  Pretty.  Sure, that's helpful.  We'll see how irritating it is to
keep up-to-date as time goes on.  ;-)


>>  void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb, int max_insns)
>>  {
>> -    DisasContext dc;
>> +    DisasContext dc = { };
> 
> We seemed to have dropped an initialise here which seems unrelated.

Added, not dropped.


r~

