Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE71C10F03
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 17:42:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ADAD208E4
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 17:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oncAmUps"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ADAD208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57351 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIzRO-0003vJ-Nq
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 13:42:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hIzMw-00084F-7e
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 13:38:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hIzAy-0006z3-Dw
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 13:25:49 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:40106)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hIzAw-0006dU-D7
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 13:25:46 -0400
Received: by mail-pl1-x642.google.com with SMTP id b3so7858328plr.7
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 10:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=pC0154Hk3Y4HACBlKkbl/Ou3KBw61ouOIbGHYbIDtbM=;
	b=oncAmUpsuhqAt2kALODjsq1r1vbkefo4/nXf2bXfsHlAfUmBWMvkWifg6/oeMJYdtU
	yqvzkrUtylXsBaGzj+Yy/gg2gwNPK0kGYYGybDm1SsaXGq5JInxOCKIslYXOSvmOpml0
	kmV6/02trQXTcbDLww4r+223iw9nKWUSlMW0GXX43hn/i+NyvWVXUt6mg1v84cfhV7d/
	nrCw5kGKbQzz11DFdlr0GBFxDLSNAtY85QzfFhtX6tDOv9cxUZsyjQDh8+KQALQdYMTm
	ag8/faJq/9tW4br4A/fYUPZOR92K4ZFdbQuB2bjzUl+2vLhcEV1jc8PxSiFa5RO54ZV1
	gAcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=pC0154Hk3Y4HACBlKkbl/Ou3KBw61ouOIbGHYbIDtbM=;
	b=KnNAxrXJXEHcaghtTvisUPrs4QKnVOcONoGKulZ0tmqD5aBZ6+7neyTs5f06frsSCn
	irvtiZMXg+7KE37XD1qhepiomoAE11pxs3WCEeHZ4PuWZvhFkJsIVOr/qbeeHT5VFtvJ
	X+EY5l6/FFeFJz0j2Kf9Dav6tMyfLZh3+Z+pyenOpgjwrXvc6IP1DS9+AaY7j7tF9gPa
	loO0SU3X+DV7jusSC1cK9Qyu75fMG4wpRYXV7YaM7zDiNMf1UR/m1mfagb5JqrQ42Jt4
	WHlKWuLLrwCib+iGC716Rh6NatQmHmQpWv1tSrqFPZaqEvpN59LnOLmusyNZRl3OT4MX
	9fAg==
X-Gm-Message-State: APjAAAVIlU9d/PPpFWRfoJQYhEbnPnnQewhWYeHlFSe8xqE4I/MCuPjY
	2XBjd464u3Nkj6uYAurPdFuJTe4y4V8=
X-Google-Smtp-Source: APXvYqwMaj+I3VenV3i5aOthljoU2eaZFjaM1sDh2c6Z6KrE0bzgzzHglZPHvkflbf1hct6Zce63Sw==
X-Received: by 2002:a17:902:521:: with SMTP id
	30mr26598823plf.248.1556040330635; 
	Tue, 23 Apr 2019 10:25:30 -0700 (PDT)
Received: from [192.168.1.11] (97-113-179-147.tukw.qwest.net. [97.113.179.147])
	by smtp.gmail.com with ESMTPSA id
	i15sm23114140pfd.162.2019.04.23.10.25.29
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 23 Apr 2019 10:25:29 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
References: <20190416125744.27770-1-peter.maydell@linaro.org>
	<20190416125744.27770-2-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <6b64b6e8-9099-7410-2e20-ce2dba7c0506@linaro.org>
Date: Tue, 23 Apr 2019 10:25:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190416125744.27770-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: Re: [Qemu-devel] [PATCH 01/26] target/arm: Make sure M-profile
 FPSCR RES0 bits are not settable
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423172527.1HM0mM6MTbKlIy18i11w115v_3kcKWb9WJ3bhVxIiZc@z>

On 4/16/19 5:57 AM, Peter Maydell wrote:
> Enforce that for M-profile various FPSCR bits which are RES0 there
> but have defined meanings on A-profile are never settable. This
> ensures that M-profile code can't enable the A-profile behaviour
> (notably vector length/stride handling) by accident.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/vfp_helper.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

