Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F1EC4CEC4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 15:17:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61220218AE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 15:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aeHzWnA0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61220218AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAbhi-0001zf-6r
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 11:17:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47203)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iAbfX-00017L-NU
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:15:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iAbfW-000725-AJ
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:14:59 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:47084)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iAbfW-00071i-3Z
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:14:58 -0400
Received: by mail-pl1-x644.google.com with SMTP id q24so75719plr.13
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 08:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Di15xSXEP0WmQsLld3RE8DinlTNvuPQEmbqDRqfW5Xs=;
 b=aeHzWnA0JJRn5sNo+yIGoj6PGOMB1ftQqkNpWEZvg0yKDeLgRa0iGK/eXchJol+GDx
 ukLgYJHgs+AsMZEzU4Vd7FpxbpefZHEU0vgmxJnfm92wyl88GAhQ2H/TRrTo+bIkncm+
 1Ja2te7ApDEzvdIZ6LUfAF33TDEQiOkX01WHg0OrWXuqg1KacBJTIv8p39UvJHQe6cYI
 Th2hBNyMaXnR/+4ClhsZbRgOgBCPO3QlB/umc4NXISweGM4qVyjJs5xJIE0DnKpR4/ze
 pAXe9rWX9bFf09HLECiaQqLHDITD7Pc8nFFaq/b7np5iYswpBYMENHm1+0pXk2OUIeQs
 CxJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Di15xSXEP0WmQsLld3RE8DinlTNvuPQEmbqDRqfW5Xs=;
 b=p9FT7Cl9SuHXKn69nVO7bB/BCVrYWFuV2h8BI2GwlgxhUO/K9bXJhWyAOh4PNIP7AU
 FE2M361tqGGfxcQgfwMPiQiRNjaMoUBO+Qcqu0daUV53jG3aJAq759WNuDWrR/W0mc3a
 FiLwFiuvE5qQa8zu6Zghv/fTv2uZY+d4qaWW2c1o3Xk7bNyg87OZPzAjZ0JBQnj4o0U2
 JzjQ3p5RW87Dr21DU8TQqkHLd93ILRwTr3v0x9QsYHdvusOWlyvkV5XQa/DtPwwAZYkZ
 2ahFlZ1Qgx+X74VIUs5QZHvdWCrSG4gL3/VFqqB0k6HoFkW3Skgc1iYGs0ps/YY4YlDH
 spNA==
X-Gm-Message-State: APjAAAXUBgaFOU2e8aoKX1Id4JsX3CIpvp/LsvxXHu3iqRcv3iMrqnIA
 nmyFfJz6v397vY0xk5XnqJnFMVZvycs=
X-Google-Smtp-Source: APXvYqxYSNm5HOy8xa1HnJ1KQcjSRm7CwksxWbiumKLeYrNNFxjtIehL7jA1GI/12+sF1+vCm29DgA==
X-Received: by 2002:a17:902:36a:: with SMTP id 97mr4477110pld.75.1568819696682; 
 Wed, 18 Sep 2019 08:14:56 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id e127sm9928468pfe.37.2019.09.18.08.14.55
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Sep 2019 08:14:55 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20190917184109.12564-1-alex.bennee@linaro.org>
 <20190917184109.12564-8-alex.bennee@linaro.org>
 <afd9bc85-9c79-a456-73c1-fc19e97d1acd@linaro.org> <877e661vur.fsf@linaro.org>
 <93ff7174-77c0-d2eb-eac2-d3eef7e88a14@linaro.org> <87zhj1zvnl.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <376bc2c5-b5c7-b35a-1adb-460b37cd4a6a@linaro.org>
Date: Wed, 18 Sep 2019 08:14:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87zhj1zvnl.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: Re: [Qemu-devel] [PATCH v1 7/9] tests/tcg: add float_madds test to
 multiarch
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/18/19 4:33 AM, Alex Bennée wrote:
>>> Ahh I was going to hardcode the arm madd instruction in as the builtin
>>> wasn't expanding. I tried setting -march in the CFLAGS but that didn't
>>> trigger it either on my buster arm-hf compiler. Any ideas how to get the
>>> compiler to do the right thing?
>>
>> I think you want -mfpu=neon-vfpv4.
> 
> Ahh that worked. I would have hoped that v8 would be enough to spit out
> aarch32 code which has to have VFPv4 for A profile right?

I would have thought so.  I'm not sure why -march=armv8-a wouldn't work.


r~

