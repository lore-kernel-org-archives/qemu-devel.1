Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC51FC10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 06:59:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B1B820693
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 06:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OOTJx6RC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B1B820693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36491 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDkiq-0003gn-SC
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 02:59:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hDki2-0003J9-3T
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 02:58:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hDki1-0008Fx-6O
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 02:58:18 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434]:42424)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hDki0-0008FZ-My
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 02:58:17 -0400
Received: by mail-pf1-x434.google.com with SMTP id w25so7677209pfi.9
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 23:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=xLIW+9yrr4b5bnsgGOL/nvK8hLj+LD4cpg6r32kRl1I=;
	b=OOTJx6RCIcgRfgk83g0DPxrS4vD5cXPnR72JO1knX4hAaZxPFls/pMhyLjmqB+F/N2
	v5EZrO26AvTtdXE9QPCp2LBaO3B/FTR2ph+NMLwmHsLnTnoe8s4s2KNs7ROzmtkv2WVb
	GmKdl99OtI7CUjRX+hJkp70Nr28BJbefDniIieWs+NGW57TpbsjmGObEHZJ6+9FeqstC
	VUmtSqeG0THL56byboqMmHqsH0ZGG8aEblKzKFoiBaxS6dUeusiPNmMLXsVMdgBN2fO+
	fCaluR8ldZJ6xmStfUtFJkxsVIOYIo+HcJQ6MfFZaBsAzjJoGq0sfQzhMlP/CgPPaAes
	3mgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=xLIW+9yrr4b5bnsgGOL/nvK8hLj+LD4cpg6r32kRl1I=;
	b=HzVflkdqM33gX9asKjueq54vGbtTdBrKkdhzsRBT/Or2EaZ+1r9tPPpIknwoxfXoSD
	qTgzp5GqBdFaqtnuliOqNzQPv9L+mDm/NTrDsHPZP3ZzyVMBd9p3CZYEgMZ42dXslnw3
	rOwc7dyLqpp5BET1t8Tcr2ulY9R0JnXxK3qvOQ0FZMJOpIw/AdIMPOPNgYwDest9YTYA
	8H6DB4PER+W6XYJ26byrfXfEg1MnsmKZnwClSSTT10nGkyol6nRWIdSf9KcnBOpfTvWW
	/9vp6nvInyLroVl95vmUHSR57YEOM/m8Uf2o7eXztdU7syEk2SIIQnTXe6NGoAa571fc
	E/eA==
X-Gm-Message-State: APjAAAXy9s5H6ZigCQ51lTpZPZFyTuEAVvPf55X0zC9t2nX5Ql5CWabn
	L8aSg6OpXzNyCSU9apg0q03I2/5W7ns=
X-Google-Smtp-Source: APXvYqzkpfu1Qqz/i/rQwwX8pMYKu03/O5qFVQ0hxNdYfvzl51amVYHLiCo93nuQ6pTIBzQ1Uh1hFg==
X-Received: by 2002:a63:61d7:: with SMTP id
	v206mr33504445pgb.349.1554793095245; 
	Mon, 08 Apr 2019 23:58:15 -0700 (PDT)
Received: from [192.168.3.43] (rrcs-173-198-79-114.west.biz.rr.com.
	[173.198.79.114]) by smtp.gmail.com with ESMTPSA id
	j5sm25503944pfe.15.2019.04.08.23.58.13
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 08 Apr 2019 23:58:14 -0700 (PDT)
To: Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org,
	qemu-trivial@nongnu.org
References: <20190409060435.22801-1-sw@weilnetz.de>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <4a16a810-9806-3a76-7d17-1b6282296502@linaro.org>
Date: Mon, 8 Apr 2019 20:58:10 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190409060435.22801-1-sw@weilnetz.de>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::434
Subject: Re: [Qemu-devel] [PATCH] tci: Fix some unaligned memory accesses
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
Cc: Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409065810.qIRDyQD0nfwrEnkllATdj4SusONW2pfFbXnFpZ1MIsA@z>

On 4/8/19 8:04 PM, Stefan Weil wrote:
>  static tcg_target_ulong tci_read_i(uint8_t **tb_ptr)
>  {
> -    tcg_target_ulong value = *(tcg_target_ulong *)(*tb_ptr);
> +    tcg_target_ulong value;

Ideally these would use the helpers from "qemu/bswap.h", ldl_he_p(), etc.


r~

