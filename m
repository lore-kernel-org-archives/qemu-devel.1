Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C40C2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 14:09:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D723120661
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 14:09:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="twC51wgP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D723120661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyyt9-0001d6-0P
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 09:09:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40345)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iyysE-0000Uk-OL
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 09:08:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iyysD-0001Fr-GC
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 09:08:18 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44274)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iyysD-000172-84
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 09:08:17 -0500
Received: by mail-wr1-x442.google.com with SMTP id m16so23191754wrx.11
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2020 06:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=sH8OXw0iMZraU96nRoeOREK+oVhrqwmMlqMrQR/1GQs=;
 b=twC51wgPf+rITU4VxxxVfTXypQw7OYv/YTVqD7sc3LKk+4b9sqZLP3g4mSAZoQN6Px
 ds5MjqQHH+6IMOxwYd4ATST2muZw0ShulTYMEyfwJsjoCb3eOHeWJ3zZAmIMbC+uEQzc
 +8Vr33tM5j3i19MoS2i2jZ4t6wwjhf6TT2oEmjGHoOJnH6kG4rk4Cy5ewwM0dfejRzKD
 E5aiOCwOwG9Jl6FuxBBOo7hy7DR9fp0cyFnQXjA3CRQt5NOARt3U3Ijqy8X005ajRd9/
 BJXXoHZvPb6gNG5NPyj7fm8L8Tzy5BKikoK5CWABpqW7afyPtNaPZjKTmqT85KbYC69o
 U0/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sH8OXw0iMZraU96nRoeOREK+oVhrqwmMlqMrQR/1GQs=;
 b=WeQ1SqX9QET7oakG1lipqh5wfdjPm+ovC6o89YxKAWjrv6cisM776t0kE60wsfJ+Hb
 nzd8LzbgaLOZAJQR3ifLJ2TioWWdlKBLtYNaOFj6r1LboLCzcgJpNVnF3Vqb/PuWXlR9
 YMRUWwuYqVitlLe6g20wEXcMWpC7K9pffim83IjnD5yYwKQvV8K5c4Wh5dArqIc6T6M+
 w+JexWcqCSAChg/4tVOoeaVGJ7JeTIGrCAb473Y9HIz16NQDA861BmZWTyubRTbn3Muy
 Gk0Qr47uZ/9IYShAiuSpbY5vnHg13HGZ5jpgBouvbnrctHhDonxAs+X1W+qeNP3MPSZw
 f3KA==
X-Gm-Message-State: APjAAAV+fqa2rudx0RCs6n05yxphBpceJk3dBtHh20FqMpopEm8rWcXr
 uDDZa6yLi8pS50fzkFYosvYENRsjn8GDww==
X-Google-Smtp-Source: APXvYqxqXTjl//xzLkK/oAknTlCJLBZBvH5nR7LqMvsK+619mOI5jBiVUPkYJrxKmLgyaSkBGc+Drg==
X-Received: by 2002:a5d:43c7:: with SMTP id v7mr21569300wrr.32.1580825295721; 
 Tue, 04 Feb 2020 06:08:15 -0800 (PST)
Received: from [172.27.246.116] ([212.187.182.162])
 by smtp.gmail.com with ESMTPSA id h2sm31264694wrt.45.2020.02.04.06.08.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Feb 2020 06:08:15 -0800 (PST)
Subject: Re: [PATCH v6 00/41] target/arm: Implement ARMv8.1-VHE
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200201192916.31796-1-richard.henderson@linaro.org>
 <878slja79n.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0a26ed74-f6dd-c639-9a2b-87a8a555d17e@linaro.org>
Date: Tue, 4 Feb 2020 14:08:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <878slja79n.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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

On 2/3/20 5:51 PM, Alex Bennée wrote:
> 
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> Version 6 moves vhe_reginfo[] to file scope, and one tweak
>> to the vhe register access masking that Peter asked for.
>>
>> All patches now have reviews.
> 
> I was re-testing and I was able to boot my guest Image+buildroot.
> However the busybox crashes after login so I'm unable to do stuff in the
> guests userspace. I seem to recall we saw this last time but I can't
> remember what the problem was.

Hmm.  Mine works.

Are you testing a 32-bit nested guest again?  I've misplaced those images that
you put together in December, so I can't test that in short order.


r~

