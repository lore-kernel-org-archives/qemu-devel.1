Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 092EFC52D3C
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 14:02:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC1A72469D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 14:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vXBxFzml"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC1A72469D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7Jji-0002pW-Tp
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 09:01:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40925)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j7Jhg-0000Wb-Ei
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 08:59:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j7Jhf-0007fs-7t
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 08:59:52 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:42865)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j7Jhf-0007fV-1D
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 08:59:51 -0500
Received: by mail-pg1-x543.google.com with SMTP id h8so1518971pgs.9
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 05:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=h5C0WvXr8hg0/08SJPdhHiKkSRzBm2pJGVeuYU09HO4=;
 b=vXBxFzmlulP4fCyL57ohbVjQ1BtC91JsBvuiSJEQOJ3TJ0uRPsItKXFqRPov2ILCvk
 ULs5s0D6r61530FqpMrv6N9RsE+VMCzdFvksCVlsCtD3BISXVxD1XeuZEp316EsTapNM
 uykeLS5xR5ixlfEfqrLFF+WEXiMEt6XEYFzUVLzbXVmoLA9vMRmH2Jhn9ltsbfZJm5Xe
 x5kHdj9rvRLpoGymKK+5yJOu1ML1AHwTBHzKMKveTDBGct4Hm0B07mfoIc2rlQucZ1af
 XwdZeZPX9KSJQrhA0g8VvmvyOp9J8+llUwPjJRbyWR2YvpySZovoOib1a+Ek58CcAqzh
 9NOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=h5C0WvXr8hg0/08SJPdhHiKkSRzBm2pJGVeuYU09HO4=;
 b=P9VfluHRVTotMx+gPMoYHkLmjxiX5iqVEUxrzTLk/Ec6FZS8Q0yUKOnAtzL8V/ecfG
 ogaKYGYkXdoSDkOzhPshLYvEK/BVCauOL7n+8bgjcOuayy38ksLHnD8KZXZrIO4OOsf8
 46CuSfCYr9/lo89Gs9mnsc0lYoIWzfbm52BL5sznBFH4W84mY7HJDs7Xf3g0ZTbPtTQd
 bjNdsEfPVGzGLvXDeU0nT2CXjY3vJNVz24PgJrDFzOrUrhZMiypVAfA1qAzznM4d/SXc
 lTEagbiPSRAYFOvKccWVdSX7D0DmQxvKHuswzf4NHIJrvbK33jJetXIx43Ppa+j3bEYb
 lHjQ==
X-Gm-Message-State: APjAAAVxRmvLSO5QgiQCCWT1wfikYNio8ib7uDq5e4CbHCI+Bbg3pSLf
 7ACuqM+xlnhYFUSXkUavS9aI4A==
X-Google-Smtp-Source: APXvYqwHtVXQoLv7mMeenNjCHgImGXMA2upQJmqElI0t7Zc28Ff9iYJvhK12FjPcECqBW73O3Ba/Gg==
X-Received: by 2002:aa7:8ad9:: with SMTP id b25mr4193373pfd.70.1582811989807; 
 Thu, 27 Feb 2020 05:59:49 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 h3sm7428313pfo.102.2020.02.27.05.59.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2020 05:59:48 -0800 (PST)
Subject: Re: [PATCH v3 04/12] scripts/qapi: Move doc-comment whitespace
 stripping to doc.py
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20200225140437.20609-1-peter.maydell@linaro.org>
 <20200225140437.20609-5-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <da253a73-104c-d88c-903f-53a6977d1222@linaro.org>
Date: Thu, 27 Feb 2020 05:59:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200225140437.20609-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/25/20 6:04 AM, Peter Maydell wrote:
> As we accumulate lines from doc comments when parsing the JSON, the
> QAPIDoc class generally strips leading and trailing whitespace using
> line.strip() when it calls _append_freeform().  This is fine for
> texinfo, but for rST leading whitespace is significant.  We'd like to
> move to having the text in doc comments be rST format rather than a
> custom syntax, so move the removal of leading whitespace from the
> QAPIDoc class to the texinfo-specific processing code in
> texi_format() in qapi/doc.py.
> 
> (Trailing whitespace will always be stripped by the rstrip() in
> Section::append regardless.)
> 
> In a followup commit we will make the whitespace in the lines of doc
> comment sections more consistently follow the input source.
> 
> There is no change to the generated .texi files before and after this
> commit.
> 
> Because the qapi-schema test checks the exact values of the
> documentation comments against a reference, we need to update that
> reference to match the new whitespace.  In the first four places this
> is now correctly checking that we did put in the amount of whitespace
> to pass a rST-formatted list to the backend; in the last two places
> the extra whitespace is 'wrong' and will go away again in the
> following commit.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> New in v2: update doc-good.out as noted in final para of commit msg
> ---
>  scripts/qapi/doc.py            |  1 +
>  scripts/qapi/parser.py         | 12 ++++--------
>  tests/qapi-schema/doc-good.out | 12 ++++++------
>  3 files changed, 11 insertions(+), 14 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

