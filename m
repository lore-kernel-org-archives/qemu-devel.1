Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A63BC4646D
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 15:26:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 097D2218A6
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 15:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ewJtjr9W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 097D2218A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hih99-0000Nk-5z
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 11:26:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39210)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hih6d-0005yW-1W
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 11:23:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hih6b-0006LR-MC
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 11:23:34 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:33858)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hih6b-000698-9B
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 11:23:33 -0400
Received: by mail-wm1-x343.google.com with SMTP id w9so3176559wmd.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2019 08:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=EOZgi02Wum0KCa8+L/d68Sd4QzvsgI777S87nkuIcy8=;
 b=ewJtjr9WW9ghpoQiNnIYInXuR8yLNET/6aXGFU1bcqP3iquBGV1kBSE1pQmKDnLlAW
 aPy1tv5XIAJgd7VAYDXEF2kCI7e5T3VoRRMZRxLAu1g+MXuJe8WCSymjb3ZNtIK8SN4O
 48wtlXC+34pU28bMD3iEll9wc0y0xJEKmdmNok7OTNbzNZLTijRg2XE4vJ7Pn9rm9kvk
 8t8/pP+qQLGhyR3tkB9CVdIcQjN4x0j/6bvkem4+Cr2P5SqQwkAP/FIff22YfQedmgrK
 0VwVOQH86jXvNTRh7a8DwlUXCwqs6u80tHFMJIJxnOoaUyOUzCpTRulqzIGV+R2lqf0R
 u2QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EOZgi02Wum0KCa8+L/d68Sd4QzvsgI777S87nkuIcy8=;
 b=IFm5/FLZBusMByrCNfptpDV5ZO2lfuapoWeEhmHvaLke9VeKb+/pciL8Mpt+v7PavV
 kDq8xtg6NijIcIShBzuE/xcJ1pGc+ICiCygmJi1+K8HyWQf3IZ/eBwrgBzH82ogF4Iz0
 Ma0J4/jBiHbjazUoHtur9vrg1qdCMVgFuzMlAWV2sHddgRGyVF6ZBNKici5QVm8jLIPK
 QdZbNFzQYCKMy5EfILt4iwTl2xqvVmczJ6RWMJqLhuqLM/oWAZGj099y3F+KbGV87FjS
 lPmmGW1nWT9IchayTFz8+pIC7SzJkWuhn2zdsG6G4hGJFJg16WvfwiJbknye70vgL0oj
 mS8A==
X-Gm-Message-State: APjAAAV/hfpy0VNurHsPyRUfTX1K/4OowRnLz3BQ1368bLtVbG4RIyx7
 byLJVb1JDqnuQqL1aV6HYmZhzg==
X-Google-Smtp-Source: APXvYqwJAz7uiNGZmf33qLJ71sLkKOi6kfWTwyrfzyCF5dWy0ksCHrt25luNjyCt1gSWIrfZymkhCA==
X-Received: by 2002:a1c:7d56:: with SMTP id y83mr8803547wmc.77.1562167381759; 
 Wed, 03 Jul 2019 08:23:01 -0700 (PDT)
Received: from [192.168.3.43] (93-34-153-63.ip50.fastwebnet.it. [93.34.153.63])
 by smtp.gmail.com with ESMTPSA id y133sm3494254wmg.5.2019.07.03.08.23.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 03 Jul 2019 08:23:01 -0700 (PDT)
To: Jan Bobek <jan.bobek@gmail.com>, qemu-devel@nongnu.org
References: <20190701043536.26019-1-jan.bobek@gmail.com>
 <20190701043536.26019-2-jan.bobek@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <8e5e96dd-ed35-895c-1fd3-d6b60ccba44b@linaro.org>
Date: Wed, 3 Jul 2019 17:22:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190701043536.26019-2-jan.bobek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: Re: [Qemu-devel] [RISU RFC PATCH v2 01/14] risugen_common: add
 insnv, randint_constr, rand_fill
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/1/19 6:35 AM, Jan Bobek wrote:
> +    while ($bitcur < $bitend) {
> +        my $format;
> +        my $bitlen;
> +
> +        if ($bitcur + 64 <= $bitend) {
> +            $format = "Q";
> +            $bitlen = 64;
> +        } elsif ($bitcur + 32 <= $bitend) {
> +            $format = "L";
> +            $bitlen = 32;
> +        } elsif ($bitcur + 16 <= $bitend) {
> +            $format = "S";
> +            $bitlen = 16;
> +        } else {
> +            $format = "C";
> +            $bitlen = 8;
> +        }
> +
> +        $format .= ($args{bigendian} ? ">" : "<") if $bitlen > 8;

It now occurs to me to wonder if it's worth simplifying this function to always
emit bytes, and thus take care of all of the endianness ourselves, since we're
doing it anyway for larger/odd-sized hunks.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

