Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5242BC5ACAE
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 13:23:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1861720838
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 13:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fF10owJh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1861720838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i82bB-0001QG-3z
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 09:23:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59164)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i82a4-0000JA-9S
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 09:22:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i82a3-0007Vz-D5
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 09:22:44 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:34810)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i82a3-0007Vp-8v
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 09:22:43 -0400
Received: by mail-qt1-x844.google.com with SMTP id j1so12447432qth.1
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 06:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=jIGvF0CI7Rp5e2phsHIiY96IXF8wmOU+APeY7QYDXEM=;
 b=fF10owJh5TMv0ZZgxHn1zJA+C7XPHjVMPUFo9+RssT8aEVymZIhs19telHf4dOEE0w
 B3VLFLD6soaDC31K4dd7W2tWJmdRicZQ+rKZ3o16uZMQj/0ZISm6SurTU6IIasJXHK9k
 WG+ElORhOm6BA9teUUURFmwLk7FRfLSo0RGwmSH5BfesDixMl9jFFz7HeNj/jR/tMdiS
 Bu9KDuuO0QajIujrA77I3AfR4h/F0hpx8ac5s32+EeN/tC2HfJaXsX0W/v1b389nLVaz
 At7l7/h3ASFJzn+psYhIx3Rlu3po6PdtrsvDd537dR0dGRJEHdPmScXTrzauOunDyt50
 PMBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jIGvF0CI7Rp5e2phsHIiY96IXF8wmOU+APeY7QYDXEM=;
 b=D1RRVXZBQbxfh2mC6eHnIHFGSozjiZqEAG6+G19TCSzcml0L+oSwDtvQ+f4Zsnn9mA
 eqWW+KW707ssA5KpE5XwUvePyFhZlGy7weabagmXvRtUJeYu1FDGGH4FfkAVgQfaZQAV
 Eyk5RPH6VTh2MlKSk3m+8MyLZG5XcNYFD+fKc/rrVVFqU7F3mfQbvXr4D/hlzkQwQzQA
 Y7jMiHcEW+LsVg5dG2L4JeZrFCfL8W8ZjXP9gyiGsm2JwK2I5OvIyDJMUvx7JJAuJ0DT
 MlCAs4gBONQ2hphszY1NbKFbi6ncHlfRGNkJVEQ+yADJk0Xj87dhDAYaE+S3GY/K3eDY
 6Y1Q==
X-Gm-Message-State: APjAAAVpKxVvCtH+hwjJFTp38anYgOrTpCRy58XvTKHn8s/Nv3pMQNzp
 EQLgL7iyX337QZwNFV3+nZ0UPWIYJG2/CQ==
X-Google-Smtp-Source: APXvYqzdb9PQ5lCsr+x4hKfTKgd+rZdzamvs9akaA7ytSdZLp3ken+h1lKY53iBYU/ubbRxczpeWsQ==
X-Received: by 2002:ac8:198b:: with SMTP id u11mr2391070qtj.108.1568208162428; 
 Wed, 11 Sep 2019 06:22:42 -0700 (PDT)
Received: from [192.168.5.185] (otwaon236nw-grc-01-64-229-69-35.dsl.bell.ca.
 [64.229.69.35])
 by smtp.gmail.com with ESMTPSA id k199sm11010074qke.45.2019.09.11.06.22.41
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 11 Sep 2019 06:22:41 -0700 (PDT)
To: Tony Nguyen <tony.nguyen@bt.com>
References: <20190911014353.5926-1-richard.henderson@linaro.org>
 <20190911014353.5926-3-richard.henderson@linaro.org>
 <20190911105509.GA42643@imac.local>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <299a576c-0264-95d2-e2fe-4dee41d87039@linaro.org>
Date: Wed, 11 Sep 2019 09:22:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190911105509.GA42643@imac.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::844
Subject: Re: [Qemu-devel] [PATCH 2/3] cputlb: Replace switches in
 load/store_helper with callback
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
Cc: peter.maydell@linaro.org, mark.cave-ayland@ilande.co.uk,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/11/19 6:55 AM, Tony Nguyen wrote:
>>  typedef uint64_t FullLoadHelper(CPUArchState *env, target_ulong addr,
>>                                  TCGMemOpIdx oi, uintptr_t retaddr);
>> +typedef uint64_t DirectLoadHelper(const void *);
> 
> Would 'Load' instead of 'DirectLoadHelper' have enough clarity?

I suppose so, yes.

> If so, consider also dropping the 'direct_' prefix in the functions below.
> 
>> +
>> +static inline uint64_t direct_ldub(const void *haddr)
>> +{
>> +    return *(uint8_t *)haddr;
>> +}
>> +
>> +static inline uint64_t direct_lduw_be(const void *haddr)
>> +{
>> +    return lduw_be_p(haddr);
>> +}

I would be hesitant to call this just "lduw_be"; I think that's confusing when
it's calling lduw_be_p.  But perhaps "wrap_*" or "wide_*"?


r~

