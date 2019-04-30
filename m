Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A65FC43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 17:25:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEBE32147A
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 17:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wG7DauBN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEBE32147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50638 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLWVA-0002tV-V0
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 13:25:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLW2T-0004E1-Se
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:55:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLVpA-0003du-9E
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:41:45 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:40295)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLVpA-0003dI-2F
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:41:44 -0400
Received: by mail-pl1-x644.google.com with SMTP id b3so6985171plr.7
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 09:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=KUfa5TqCx+4F2JQgH2WYJB8zju0Y14R/MZldH9NG4OU=;
	b=wG7DauBNoQSyUE22ZzMvwM7uZG+nl2pXCJQQyC6+xOT3AF+AJxzqxRHJXU589itC7B
	tiTImH5tpoFoHGMNwSdD/hdWwn7sLvXHhXrJNWHrEvaI0AllWZ8DniVtRizWXpj5D+Y8
	hG1FUdwYt1pOS1Qti8AA2oibVEnGR1MWRFNuOd/ka+h+grAyEM3RWXTR7QvNCACeCpxO
	4yO/bwT3sqkv/F9XIMzhXdwZFbQ95ibUv1K0Y8PI4XOHLvgOObR7dZqulaLU4kuoJoed
	hxroIattA6KU4BqpVgivMKosMppn+x+x31Fv3Gs7WKwiUYHLPIR3Z0NswTbH0lkSVQFr
	KF4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=KUfa5TqCx+4F2JQgH2WYJB8zju0Y14R/MZldH9NG4OU=;
	b=EgSLbX2J/n8gHZYXXVuGqkD5PUNtcGhcTIMyxoWACFq5DsAIUYUZlHDGUh/mRwvDSF
	uyqM56VYIgGTClb5EM0iKopEpBjS14Ho4/4xfpXKRPF2u1AVKquIZIiXotNvUX2ylqNP
	V7d+XmU3yqkBv6xmfq5Z3TmBgSW8oNnKDE43HuQqwUUFvejzdRy9STeH5j8IzkP6EtYL
	/z8bVtZLgx/2DsjEZbP5tKCj7imgg0BD4sTl5aTXhVbMCvJ1BMfhrwEM5cvc/VJS0Wkf
	gV4LEmb0HPpkNkr9CEdbMIKQ1vM5WAGzZJhVwa8mqetJXHm2NU/AZjrLZxFdcdA7b0rn
	P7xg==
X-Gm-Message-State: APjAAAXUATT1vEGxCEC7QcsQvu42jiEIswoq1hxDniG2zUhJRFzw5/JE
	lgMr6LgvL99gBMbJhaBptDjRSA==
X-Google-Smtp-Source: APXvYqxJBCgRBuuUIWxpO3xNjScHRCB1wu4NUBLeNgI/JylUQGxzNPrR1Ffirri0C0y7SJy2PorsSA==
X-Received: by 2002:a17:902:b095:: with SMTP id
	p21mr38872045plr.40.1556642502678; 
	Tue, 30 Apr 2019 09:41:42 -0700 (PDT)
Received: from [192.168.1.11] (97-113-18-231.tukw.qwest.net. [97.113.18.231])
	by smtp.gmail.com with ESMTPSA id
	e6sm38803103pfe.158.2019.04.30.09.41.40
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 30 Apr 2019 09:41:41 -0700 (PDT)
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
	qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net,
	gkurz@kaod.org
References: <20190428143845.11810-1-mark.cave-ayland@ilande.co.uk>
	<20190428143845.11810-7-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <5a60992b-d6db-4761-38fa-bb413f69d3ae@linaro.org>
Date: Tue, 30 Apr 2019 09:41:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190428143845.11810-7-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: Re: [Qemu-devel] [PATCH 06/14] target/ppc: introduce
 GEN_VSX_HELPER_X2_AB macro to fpu_helper.c
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
Message-ID: <20190430164137.COmV9BLCmRR5YhRNschSRCogkZFsZUYRW0f0ecA7--Q@z>

On 4/28/19 7:38 AM, Mark Cave-Ayland wrote:
> Rather than perform the VSR register decoding within the helper itself,
> introduce a new GEN_VSX_HELPER_X2_AB macro which performs the decode based
> upon xA and xB at translation time.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  target/ppc/fpu_helper.c             | 15 ++++++---------
>  target/ppc/helper.h                 | 12 ++++++------
>  target/ppc/translate/vsx-impl.inc.c | 30 ++++++++++++++++++++++++------
>  3 files changed, 36 insertions(+), 21 deletions(-)

This time I see VSX_TDIV right away as a place that still
uses opcode.  It can certainly be cleaned up, but that's
a different patch.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

