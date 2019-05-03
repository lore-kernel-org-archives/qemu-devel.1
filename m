Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 257F7C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 17:30:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5F462075C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 17:30:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yOQlBFvu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5F462075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45088 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMc0l-00086M-Se
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 13:30:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMbzq-0007ea-Ju
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:29:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMbzp-0008Lu-HY
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:29:18 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:33254)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hMbzp-0008Kw-CM
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:29:17 -0400
Received: by mail-pg1-x544.google.com with SMTP id k19so3043817pgh.0
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 10:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=ikes8mF0FhZpHpSmoC8srS/5Qg8CHdYfjIF4dDnGaKQ=;
	b=yOQlBFvu3tUcXVi2th81lIMPvyzlJQawRLk0FDtPGbzO6qQp/u2hRQquFWbmlLljYJ
	EDJweLhbLosF7d63inUJRU6EV4SByvwMXgaMtvARoQfYSx5NkaYchkSmRBjqIz8usuKW
	76laoZ01mjqa2aE6rfeJAYk30wl+VOx/s08vwgbDNIjcDvtQHNCjKm787FxH2s8hhmeD
	WjF0Idsn8vCJbaIFkQP7b+YjgKqJGYVIBLZ8paFa4hqAiu8o7+tQuIBBbOK5196gwI0h
	naaArEarwmeL3QlJ8yH+EFEDolQYY5NMbv+y7iq7idnGDtWz0Sw5UscH7uWLaJH1SpfG
	edYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=ikes8mF0FhZpHpSmoC8srS/5Qg8CHdYfjIF4dDnGaKQ=;
	b=X+dyMPOHgLQujmlX1hMqXGqXVnT3U5Dx/6RWnXtoAv7QfrTgEOsSAE7s+xnRHM1wwb
	/rIpwzONs6uUI0x5PITT/ljALb0Mo9iJRhJH2QRG7ubRhXw6lKf6WejHkT8QGgES4jOi
	PFL1WoHOZLLhfAfNftFoKgOhc0/JmuGpHUWOrpog46p8Veyj9nhCwu37emnuULDckuim
	dmLat9Ofq0iDjbs+jGe7jAaQGVNXG2l/z9kmDY1wGPbJmaOhrFrqFEYCyFwKUebbjg04
	FNQFFlpqojRBEQxuiLnkc86AJUHrMoYCXiGO9nUgalWbTxlVKLly4cg/ynghmaSY7LsS
	wC+A==
X-Gm-Message-State: APjAAAXwOKKggbPEMBa9yM7Xb9sUpctB5CWgp6tqHlOI5mkED5C8ROWw
	lLKd4w1Bq9pqj7ClaKpmvhLhdHdrqfA=
X-Google-Smtp-Source: APXvYqwHXm5b/dmPwNEULOeHRfeuQsPUtyAuBYyXmb6FXf0I6PopeN3+3C/0CiKTS/zmCtL6t4VA6w==
X-Received: by 2002:aa7:9089:: with SMTP id i9mr12488571pfa.115.1556904555643; 
	Fri, 03 May 2019 10:29:15 -0700 (PDT)
Received: from [192.168.1.11] (97-113-189-189.tukw.qwest.net. [97.113.189.189])
	by smtp.gmail.com with ESMTPSA id
	s6sm3559036pfb.128.2019.05.03.10.29.14
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 03 May 2019 10:29:14 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190411153942.4533-1-peter.maydell@linaro.org>
	<53930e87-3bb1-fdd5-a8fe-8603c0adecc2@linaro.org>
	<CAFEAcA_GZPJj7OQ-jK1TX4wKS4hO6OR43OG0Y3eCuxVdiUtsnQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <b798a938-f26a-65df-c718-7a174dff7fb4@linaro.org>
Date: Fri, 3 May 2019 10:29:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_GZPJj7OQ-jK1TX4wKS4hO6OR43OG0Y3eCuxVdiUtsnQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: Re: [Qemu-devel] [PATCH] target/arm: Implement NSACR gating of
 floating point
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503172912.pVDwflF1ej8Hgd9WrroC2l7aZQsiaRWPuy2cYpKgrpE@z>

On 5/3/19 6:13 AM, Peter Maydell wrote:
> On Sat, 13 Apr 2019 at 08:07, Richard Henderson
>> This one does do the right thing, but better to clear the bits on write to
>> NSACR.  This lets you avoid the change to fp_exception_el, and the missing
>> change to sve_exception_el.
> 
> Hi Richard -- I was just going through the review comments on this
> patchset, and I saw this bit. Could you clarify what you mean by
> "the missing change to sve_exception_el" ? Since SVE is AArch64 only,
> there can't be any configs where we have SVE and EL3 is AArch32,
> so I don't think these two features should be able to interact.

You're right.  I'm going to assume I had been insufficiently caffeinated at the
time.


r~

