Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F51DCA9EB7
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 16:49:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D25D2086D
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 16:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="COeYZGKN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D25D2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMary-0006Vb-8u
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 12:49:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40116)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iMar3-00062T-TN
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 12:48:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iMar2-0007FP-MX
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 12:48:25 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433]:40479)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iMar2-0007F8-CO
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 12:48:24 -0400
Received: by mail-pf1-x433.google.com with SMTP id x127so8772585pfb.7
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 09:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=hChpe92yFUSRhR4TSPMa1WqNlNxdWSe1ftr/f1yGM/4=;
 b=COeYZGKN3o+Lk9s01HAjTNd7EC2/EbyTV53CNr0/mHhfcdXZWCtYH3eXKVCQvLkvQs
 Ct3ZYrwj0KAn6h1WATSdCLXks3X3ieSrDhTlfWEjCEfjnDSn2wjmyRU0xhfZmf69a1s/
 SXWcu4yNYoc66kTCSF+vJiqiZT/TlsyiZ5Be3BxId18guWIuk3ZtWi+ebxCspvsOgvMW
 R6izXdvszfZ1a9L3Zz2h2Vf0gLx7JXxWioyzDnNfswu8Apv3nlncr8fxTFi7u7mefl3C
 ohEoxBmiiCP0rnBu3HTKCTsuxtXMeAEwwEuFbu28Qa91kzNKfZnk4UFGyrLMZMaOWQ2Y
 XfLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hChpe92yFUSRhR4TSPMa1WqNlNxdWSe1ftr/f1yGM/4=;
 b=YC//dJOWMuG7w8By1UBZ0ShUBk6Vm/TQ+0hkNaTZA5F941gegC4ftCxmla1Q1mRkwn
 2eVf1NEVs56tcu7ffL1mhQpaVWJesArE9cwPqZ6eh8u/UOkiw1CF4o4z+2oNsWFhMOL6
 UIRUciWEGTSz411/a612QKk5Hf1b6/XTHWkFdZOlvTsY/FzQoBck82MBqpBAKVH/VSPK
 rcS3C2v3YS/jME5PICpUYA8EFCmTdkdTpbu2+6XWVQU3U4P97Uc+M9CelUGRaT1Zt7CV
 1J9DEeD4lnL7Y6EgIpOLfmH7UhOsRsvmpkcHXctr3WRkKBMekJCGrIfjt0f4MMvVQbRT
 bjJg==
X-Gm-Message-State: APjAAAVCi1eQamejXL4hZBdccYYzsI721BgjeD6qQVULiB/6ID3Wn7OQ
 8XIDyecqmPtPAtNal104tk8R0Q==
X-Google-Smtp-Source: APXvYqyQK0K/U7ubckkZUYk37uuEG1rRiDCFO0oMAoo1Y63UhGoHssaxkfoFUmhlEJnjx86VBpvnNg==
X-Received: by 2002:aa7:8ece:: with SMTP id b14mr24218173pfr.113.1571676503050; 
 Mon, 21 Oct 2019 09:48:23 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id u11sm19811972pgo.65.2019.10.21.09.48.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 21 Oct 2019 09:48:22 -0700 (PDT)
Subject: Re: s390x/qemu-user: TODO /home/dhildenb/git/qemu/tcg/tci.c:859:
 tcg_qemu_tb_exec()
To: Peter Maydell <peter.maydell@linaro.org>
References: <60a0d510-b693-0ed7-560f-e70904d9574d@redhat.com>
 <9925b761-6d9b-2361-1697-a8a726b2ef21@redhat.com>
 <2848d03e-4aa6-d74e-14fe-afa9fd107171@linaro.org>
 <CAFEAcA9g3W23krU8yiuYrfVp7CVGEoBDuQofoLYcoo=Cqi48KQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <581b8e0a-2e3e-4e55-044c-ff59acf87a1e@linaro.org>
Date: Mon, 21 Oct 2019 09:48:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9g3W23krU8yiuYrfVp7CVGEoBDuQofoLYcoo=Cqi48KQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::433
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
Cc: qemu-s390x <qemu-s390x@nongnu.org>, Stefan Weil <sw@weilnetz.de>,
 Thomas Huth <thuth@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/21/19 9:40 AM, Peter Maydell wrote:
>>> That's likely the issue which might be fixed by Stefan's patch here:
>>>
>>> https://patchwork.ozlabs.org/patch/1083601/
>>>
>>> ... unfortunately, this has never been merged into master. Stefan, any
>>> chance that you could finally get this upstream?
>>
>> Oops.  Sorry about that.  Queued.
> 
> Er, you had review comments on it the first time round.
> Doesn't it need a v2 to be posted with those fixed ?

The patch does follow existing practice within the file,
although that itself could be cleaned up.  I think that
could just be done in a separate patch.


r~

