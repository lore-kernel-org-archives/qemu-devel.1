Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 887F8C4CEC4
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 18:23:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5175620B7C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 18:23:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gvnpYdbi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5175620B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCSzO-0002dz-Ih
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 14:23:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48460)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iCSua-0007S1-2j
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 14:18:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iCSuY-0004QN-0B
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 14:18:11 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:43091)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iCSuX-0004Q4-HK
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 14:18:09 -0400
Received: by mail-pg1-x541.google.com with SMTP id v27so2340092pgk.10
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 11:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:from:to:cc:references:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=gIzOB2YQYDCq+Vjy/1zAmq0hQMiqchl7ExMoC1Y0Svk=;
 b=gvnpYdbiXyOWS4x6hvA5ePx8rj5qbXcIymyWaQz0zKi90HJP1C/pX6OCmhxOX6OM+X
 JKR1OgRO4wLg2rndOJ8WWRJduHJjW27uKETwu8alybjAiBuPFw6+U50KUGAIuGq4DWkA
 BgV1HjOaiqfC+1KsyggzglWc+SKGZ2xFWhINjN82ghHS5fyg1xSr9Acb4oFaYPLP8wSv
 K/FGMUC+Jh3N7EcyaTdWnoCR7zXkbnOl2EmTLhUqI+xFnc47f9PkCdTOXazE+73qH/av
 TQa18lExxFQzdCZE/Sl7D5IJ065QfYKaKuzXlUN46SRkvYccMihonTc7NicVkOpFxWYe
 9ctA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gIzOB2YQYDCq+Vjy/1zAmq0hQMiqchl7ExMoC1Y0Svk=;
 b=OBLmZ7+o0o+wKkvvKhM5jhqaigLXHJKZRcBHg0r886U7eXuPhRhX6ITGpEeaGl03F1
 f9xtNddrX+uG8hHGz9nFIpMX4S39UQzxunNI8fl2GxGKpk1MGfaPAcq8pBSOjrLDCaV8
 PYVyNFs3BeP24MUOVZBmytr6D+Je3O7rEHHxuqQEZhv0gGg4fPdLqdLLfjmSXGt6MYK6
 jTOnYlAA1xKKFXDrH6K5bhPl3YL7R/cPev9ZNbFkQeYqrasKpTblDOEEch3w+IzfAY3V
 1M22dsikyhY1/DvAcl8oN/UsfJQdWJMI45y0uaaM7cLEafSAwQYdh3el7YtgCG96/3oG
 w76w==
X-Gm-Message-State: APjAAAXHDAlVDjfDmqZ7RIgTNjyURE5+p8lokxwhIEUvGm+koQefYsvB
 xWYL94cfEUbKpa9fwpdg+GywXQ==
X-Google-Smtp-Source: APXvYqyIKqxr3byOiP48/sCtycMKlMo1tY8omZe9UOEBm1ewy6vGvczoyE/J1EU2KCJIt9caMY0TCA==
X-Received: by 2002:a62:d45a:: with SMTP id u26mr971595pfl.137.1569262688125; 
 Mon, 23 Sep 2019 11:18:08 -0700 (PDT)
Received: from [172.20.32.216] ([12.206.46.59])
 by smtp.gmail.com with ESMTPSA id w21sm10577066pgj.36.2019.09.23.11.18.06
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 23 Sep 2019 11:18:07 -0700 (PDT)
Subject: Re: [PATCH v3 09/20] cputlb: Replace switches in load/store_helper
 with callback
From: Richard Henderson <richard.henderson@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand
 <david@redhat.com>, qemu-devel@nongnu.org
References: <20190922035458.14879-1-richard.henderson@linaro.org>
 <20190922035458.14879-10-richard.henderson@linaro.org>
 <f67383ec-9dc8-c040-8fd9-fb659b8cd2d4@redhat.com>
 <b9e498eb-6d63-11a6-01d8-1a32f5b14236@redhat.com>
 <9c254159-9b63-b66e-dca7-af3d30167f49@redhat.com>
 <222d55d5-9378-e475-28f4-d527722d3dd6@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <d74b6bf1-edd7-42ac-8242-3f4705fde634@linaro.org>
Date: Mon, 23 Sep 2019 11:18:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <222d55d5-9378-e475-28f4-d527722d3dd6@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
Cc: alex.bennee@linaro.org, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/23/19 8:52 AM, Richard Henderson wrote:
> On 9/23/19 3:02 AM, Paolo Bonzini wrote:
>> On 23/09/19 11:54, David Hildenbrand wrote:
>>> On 23.09.19 11:51, Paolo Bonzini wrote:
>>>> that includes the switches?  Everything should be inlined just the same
>>>> if you do
>>>>
>>>>         if (unlikely(tlb_addr & TLB_BSWAP)) {
>>>>             st_memop(haddr, op ^ MO_BSWAP, val);
>>>>         } else {
>>>>             st_memop(haddr, op, val);
>>>>         }
>>>
>>> I asked the same question on v2 and Richard explained that - for
>>> whatever reason -  the compiler will not properly propagate the constant
>>> in the "op ^ MO_BSWAP" case.
>>
>> Even if ld_memop and st_memop are __always_inline__?
> 
> I'm not sure I tried __always_inline__.  I can, if you like.

FWIW, that works.

Since two of you have now asked about this, I'll change the patch.


r~

