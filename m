Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BCE1C10F03
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 22:22:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01F26217D9
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 22:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bJhaYqUz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01F26217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60306 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJ3oI-0008Qh-9P
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 18:22:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ3nG-00083C-MF
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 18:21:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ3nC-00067h-T0
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 18:21:36 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:33505)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hJ3n6-00062y-B8
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 18:21:31 -0400
Received: by mail-pl1-x641.google.com with SMTP id t16so8215493plo.0
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 15:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=EtvRmIoI89Cz9L/ejMiakY4cehlDnsI1WkEFO4hBSNk=;
	b=bJhaYqUzgCwpb9G3ZmeyFKn2L7ERmAdPhSgY3NB2jt5x/aMRkyzG5gXyw90ATZyaaw
	S0+9UieWap2hKJgHQG/e1yQl+4XcbdmmqtDh6sL0mZGdAO1VypfqL+UTJ8BVCh92Avuw
	o3mWnkasKka3/AP10Q/v/z6AdFlNUN0DSyRdR81l5iccEzge/jXl9DFfNHsEqYDxFrLy
	6rK0lYjdIj1jqjvWOAyoD9w8O+rKtWgR33bwHV7RMKBppCh8BuZcq2ki+H4aaFkgBV9N
	Q9k4j1IkI5313q6kCQpKrWPrMxw73rMo/IBeqIHLLsBEMnQp51l+3TgRonixH9v69ZBK
	PKTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=EtvRmIoI89Cz9L/ejMiakY4cehlDnsI1WkEFO4hBSNk=;
	b=QbA4yu9OputiiB2yxkboYdoLvMWgicUDC9DSQ77A1p3XsbkqnSG6r6kKXDoG+b8mi0
	d5+Dkv5bVQqoAZmGH3gzEpGp9bSI3UFLspWdPbp2kSf5avBiNJzeN8lFLY80HZ/nE8P7
	vNE6XC11zEl3rZv7fb5WsucyP1yaz20hBk2yQGaWin+xaGuy9TmO2Nd2pjBNnYTQCYEz
	9bDPPFwmsEbtKX3xP9ht//XzqcO/9N9XhRY35sA9+iN7ISOmVZpOntzRQPA3teuJjgEZ
	rZjKAZ29aZK3s+EoIGXMTizs1d5TnACOHzz/ToCG2+h39J50Jjvw80l0uuN1vLL7qqDC
	Efzw==
X-Gm-Message-State: APjAAAVQWKlEyKFJN8QCS3h9c49t0LRaF+xW/jlVG6OI4+PBmHCmjrSG
	LcKTysaYMgH5MCQduslUazXlQkWQz58=
X-Google-Smtp-Source: APXvYqyiCHtJ5OSRYfY1jK3jDqjrmLrUp6VbYiUhYcpbUK9vBrV7S6DJV8y73/79WQP4LQ8hjwVI9A==
X-Received: by 2002:a17:902:1105:: with SMTP id
	d5mr29081362pla.311.1556058083830; 
	Tue, 23 Apr 2019 15:21:23 -0700 (PDT)
Received: from [192.168.1.11] (97-113-179-147.tukw.qwest.net. [97.113.179.147])
	by smtp.gmail.com with ESMTPSA id
	t13sm7309407pgj.49.2019.04.23.15.21.22
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 23 Apr 2019 15:21:22 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
References: <20190416125744.27770-1-peter.maydell@linaro.org>
	<20190416125744.27770-11-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <1ef6fe28-b339-c05b-b116-079f1afbe13e@linaro.org>
Date: Tue, 23 Apr 2019 15:21:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190416125744.27770-11-peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: Re: [Qemu-devel] [PATCH 10/26] target/arm: Handle floating point
 registers in exception entry
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
Message-ID: <20190423222120.2nNDvAgOqJVzKYr9ni3HsNaO9W77lBbimFuIwmbVk8k@z>

On 4/16/19 5:57 AM, Peter Maydell wrote:
> Handle floating point registers in exception entry.
> This corresponds to the FP-specific parts of the pseudocode
> functions ActivateException() and PushStack().
> 
> We defer the code corresponding to UpdateFPCCR() to a later patch.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 98 +++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 95 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


