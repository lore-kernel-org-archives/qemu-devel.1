Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA92EC43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 16:57:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 758C920645
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 16:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bDKsGKR2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 758C920645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50184 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLW46-0005g1-Ic
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 12:57:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLW26-00048Z-WE
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:55:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLW0E-00011w-SH
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:53:11 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:34710)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLW0E-00011W-Lx
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:53:10 -0400
Received: by mail-pf1-x441.google.com with SMTP id b3so7361894pfd.1
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 09:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=TC1CCh339jHWyTpGjRd004brUkiO3stT5lq6ZVT1t7s=;
	b=bDKsGKR2cbVkBXVoNh79Ozbh3p/gpUwmvibaR6jm7DMcrf9HBWZgNQ6hxTPfNhQihC
	yPiOljaHCLAKR59O7+GrohBkAmwUZWEzy6MdSyx+mMUurVRtcotifZ1JtYDr5J55gU+G
	ne1E055DW0jWlBR3e5eLOb7aSiY6+eUfrB35YLHSJnWFy5DPhCsZT/m/UWnn6c2Rks7u
	mvEIjv1L/0E8UJ6NLi4yzqsbIEssQQmy0uI5RIC7IhiQl7XkyDqh8yFNPkO66UvjbDLH
	EzUUJNfB0pLzjgU9tpOFfDSwetIgzUqoo86MC/QBsFdue4oVAnZsD/auqDwMXLpDVjec
	iMMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=TC1CCh339jHWyTpGjRd004brUkiO3stT5lq6ZVT1t7s=;
	b=i3joZ7UqPrl+g09T1xXdC1Z8uxDHuBr4O7tFuEGaZtenQ0kLcMxtHqgYwMb+LgPO8q
	YZqikEYJ6vT+dQuqGq/kwhVCga1k7Z/nn+Z/5+1yAg0V1t1aoVXR/5A8LuoG0h3pOUap
	9QgE4UxOkxGbIpNFPVeeo8r0wOgLdtYiPL8azaSD6LrEhbtdPtRxZC7uS7u/gAJ8ip4D
	KbdssHFfGhpb54kDjLmoybJFhj9KR7DcrsrjsiZQIzcanNmJd1v6kCes8OlVER+ftBgO
	YV0wpouCd1Np5I4V/dSxtdRQR1VESgl7BsBm9GBpjL3Qj52MkUF8LoYQEyIGR7PgerUd
	HJOQ==
X-Gm-Message-State: APjAAAWh/Zqy+RkHp8x8EIcq7IFYm9BsyJSxtn4/+/KfvQ6GlBpNnszA
	p4fbHJGbGKnnpI3K6UDOyDR3NQ==
X-Google-Smtp-Source: APXvYqzT4NvPqaSy7jVLczhKBRRdnsubfsm98EOr5S1bxYnvXxJM1GWd2YAenR7bblAB7DS40AoOLw==
X-Received: by 2002:a63:6988:: with SMTP id e130mr5709801pgc.150.1556643189713;
	Tue, 30 Apr 2019 09:53:09 -0700 (PDT)
Received: from [192.168.1.11] (97-113-18-231.tukw.qwest.net. [97.113.18.231])
	by smtp.gmail.com with ESMTPSA id
	j22sm48723345pfn.129.2019.04.30.09.53.04
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 30 Apr 2019 09:53:08 -0700 (PDT)
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
	qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net,
	gkurz@kaod.org
References: <20190428143845.11810-1-mark.cave-ayland@ilande.co.uk>
	<20190428143845.11810-12-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <563644aa-8e79-8b46-61c0-3a10b62fbc28@linaro.org>
Date: Tue, 30 Apr 2019 09:53:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190428143845.11810-12-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: Re: [Qemu-devel] [PATCH 11/14] target/ppc: decode target register
 in VSX_VECTOR_LOAD_STORE_LENGTH at translation time
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
Message-ID: <20190430165301.BDgtnd5ioevKs72-wiQP1O_wDzWQi0fujlQUZjzz5qA@z>

On 4/28/19 7:38 AM, Mark Cave-Ayland wrote:
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  target/ppc/helper.h                 | 8 ++++----
>  target/ppc/mem_helper.c             | 6 ++----
>  target/ppc/translate/vsx-impl.inc.c | 7 ++++---
>  3 files changed, 10 insertions(+), 11 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


