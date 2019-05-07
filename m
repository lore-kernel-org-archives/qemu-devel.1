Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21ABDC004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 22:50:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCD6F20825
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 22:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FxZeH44c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCD6F20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55778 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hO8uO-00071g-3E
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 18:50:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hO8tS-0006ir-1Y
	for qemu-devel@nongnu.org; Tue, 07 May 2019 18:49:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hO8tQ-0006xD-VR
	for qemu-devel@nongnu.org; Tue, 07 May 2019 18:49:01 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436]:45883)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hO8tQ-0006tY-Oc
	for qemu-devel@nongnu.org; Tue, 07 May 2019 18:49:00 -0400
Received: by mail-pf1-x436.google.com with SMTP id e24so9386547pfi.12
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 15:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=OrURhHNYwVjkV+BsN1MHQot0G783dfFTcrGDZlk1NaU=;
	b=FxZeH44ca2Ckt8iZGcr6NPgj9wpRxhTiR4JkNFY8e2el/0yhc4hByebEA2QH5dTpJe
	8XHvRs8oPH70wono7uBRTe1C/AgIlE9jbgu3HDEkZsrIDc3QuRrnILWvRjSszBdsGpMi
	zM+nczsK2/A+fpXrqHR3DHz7tq0y1dTwE3qwUKEzYqbhKdUff/v5iOxwg0528yq0XzYe
	HfldBJMblucsypBKV7XvXolkm6sht9WS6vliUt2C4vIwEEafVAizhzS1m6k/VDNXMInG
	OhtGRAWL61w4uXcHb2UjONJcL4lhLHvsoKibVbt1Vkxozfl48++tTIpGcw/3yL+3l/Uy
	QdHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=OrURhHNYwVjkV+BsN1MHQot0G783dfFTcrGDZlk1NaU=;
	b=lRWoYME7fCP/7FYgYC4ReytGw69dvTcgKJ3x/InP2vXCLm+7mzEDfCe0EVFZYM1rdX
	HM4jvPQ10zzWEpFJIEQLnmBfQJi+Ve4MlSRW+oNCDuq68d3pnaccBLSAcLCE98lynS0Y
	SX7PrK80mTrw2QbU2gqNDJBZay0uLTXJbC6VgVIHlWfDmN8I6XmkWBzMZA9u0a8iZiV/
	bHEPuMk2xAJV2/QXKmyBHvwbWtueIS18psZL7a6ZHQ3VblPnsS7XxUoi2acyIDUAZkD2
	N1Hry5F8Wi4ll1mH15UXdwHPPvkJy2tC4Mu2fVYdCKB0bS0HLA5gPxuGcXW07k7lnbci
	T5PQ==
X-Gm-Message-State: APjAAAWEw2h6+OL4tSsPiYyAzI/Gs5smhkmPRTh/EMgW10mp0bo368th
	OEnAa0dhOqXovYpvaZooeyEyCQ==
X-Google-Smtp-Source: APXvYqzv7XcmkShxKCfBP0Q7Z+JxINgLofQzzsNuL0JDVDjQSSM7fbEKIDXH3ef4Rnbr4y+iXRF4rQ==
X-Received: by 2002:a62:e718:: with SMTP id s24mr21768749pfh.247.1557269338419;
	Tue, 07 May 2019 15:48:58 -0700 (PDT)
Received: from [192.168.1.11] (97-113-189-189.tukw.qwest.net. [97.113.189.189])
	by smtp.gmail.com with ESMTPSA id
	s79sm31527464pfa.31.2019.05.07.15.48.57
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 07 May 2019 15:48:57 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>,
	QEMU Developers <qemu-devel@nongnu.org>
References: <CAFEAcA9nd6Xta8CGSRp605i9bcpeKsj+h4r5gbpot4_iNKXyRg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <6d1e0ff7-1da8-59a9-a77b-adadfe1154d4@linaro.org>
Date: Tue, 7 May 2019 15:48:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9nd6Xta8CGSRp605i9bcpeKsj+h4r5gbpot4_iNKXyRg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::436
Subject: Re: [Qemu-devel] qapi-scheme/unicode-str test failure due to
 mismatch between e-acute and \xe9
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/7/19 3:37 PM, Peter Maydell wrote:
> I just ran into this test failure:
> 
> PYTHONPATH=/home/linux1/qemu/scripts python3 -B
> /home/linux1/qemu/tests/qapi-schema/test-qapi.py
> /home/linux1/qemu/tests/qapi-schema/unicode-str.json
>> tests/qapi-schema/unicode-str.test.out
> 2>tests/qapi-schema/unicode-str.test.err; echo $?
>> tests/qapi-schema/unicode-str.test.exit
> --- /home/linux1/qemu/tests/qapi-schema/unicode-str.err    2017-07-06
> 10:23:13.601812330 -0400
> +++ -    2019-05-07 18:32:31.533125931 -0400
> @@ -1 +1 @@
> -tests/qapi-schema/unicode-str.json:2: 'command' uses invalid name 'é'
> +tests/qapi-schema/unicode-str.json:2: 'command' uses invalid name '\xe9'
> /home/linux1/qemu/tests/Makefile.include:1105: recipe for target
> 'check-tests/qapi-schema/unicode-str.json' failed
> make: *** [check-tests/qapi-schema/unicode-str.json] Error 1
> make: Leaving directory '/home/linux1/qemu/build/all'
> 
> but oddly only when I ran 'make check' by logging directly
> into this machine (usually I run the tests automatically
> via ssh and scripting), which suggests it may depend
> on the locale settings. Does anybody recognize this ?
> I think LANG=C fails, but LANG=C.UTF-8 passes.
> 
> Ideally our test suite should not depend on the locale
> or environment settings of the user running it.

Yes, there's an active thread about this:

https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg01247.html


r~

