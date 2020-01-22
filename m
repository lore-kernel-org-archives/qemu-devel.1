Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7149C2D0CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 01:27:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EC632253D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 01:27:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ILxg713a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EC632253D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iu4oH-0000o8-KJ
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 20:27:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38864)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iu4nI-0000Fq-Kb
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 20:26:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iu4nH-00043f-9t
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 20:26:56 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:34920)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iu4nH-00043Q-3b
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 20:26:55 -0500
Received: by mail-pf1-x443.google.com with SMTP id i23so2463782pfo.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 17:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Pp16kqLpiEIyAGHOLDB5F5XDcQRr9/fLT5GRMKH+yXw=;
 b=ILxg713aGeQ9egQymNxSuXStlT2t0GFABSc4CbfRZRht+coExjcQeM0JWc5uIAz5I0
 ohnnXAsVueVr1NZx1pEIApH1JdQDWZmnyrrTkTDUqgDK50iCXPpDgvgjt7pxII0rSqvu
 n4pTuk3HMCPTyQ31PGXyeZGJ57M63fyvaIBrgtQ7/diaZY5Qfe7ArF+q6Im+3WYNRPQp
 2WlzbQpeTABa0j2j1srD7QBdUAux0ygDOAWHo5fMWxPZE6p7aDqEUrGZk+PaPqBy0nWC
 d09H3cQ74Z25rAZVkMwT7D4H3lq/W/VBZZyu443/Kgrv+8fEZ9N5svzTEttvUad74NOM
 R7GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Pp16kqLpiEIyAGHOLDB5F5XDcQRr9/fLT5GRMKH+yXw=;
 b=ofC35uA8AdW0kOt9u2OB6e900IvAD2/3A513J78fOcGHoJRHxrUl2KcmWTm5WEk+rR
 yiONiVhxdMytltOIR8Gb3kWKiPoZT38uzEFeW6CVVUw1T+5kaX3/mfbfQm2RyMIvI5YE
 janrqMMwhqn4AVAhF77mlI70GofL00+Kh9JiBaLmWtQI9N7VzW18LE4zGJBybGi6xljt
 E98P1glCCvm2c65q2jO4E/Rw4f3ZbHdfYitaIOjnS7PcySxYWe/clLijai3Lfr3KE7bE
 nS4ZzgtUJGTkC39CuYqlvG6yqZdpcFKy9MT/udPxoFlyhnXnBi8XgVuFvzUcgRBS3S1A
 rQ1A==
X-Gm-Message-State: APjAAAVysXN+hCjsMocodglpDQxBaHkFJwmLxSAt3iSqWBMuA2o5UCRU
 61PPNnJ6Hscu6auMf+GQhFWCcg==
X-Google-Smtp-Source: APXvYqxQHZFHoqWoh/O4jd1powqUGPfcr+QqKjgiXNsCW39l4cU8zwA6SYVXdVi+SLLMiYWDaFLz2g==
X-Received: by 2002:a63:5b0a:: with SMTP id p10mr8370478pgb.228.1579656413790; 
 Tue, 21 Jan 2020 17:26:53 -0800 (PST)
Received: from [10.5.50.117] (rrcs-173-198-77-92.west.biz.rr.com.
 [173.198.77.92])
 by smtp.gmail.com with ESMTPSA id u3sm43802068pga.72.2020.01.21.17.26.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2020 17:26:52 -0800 (PST)
Subject: Re: [PATCH] scripts/git.orderfile: Display decodetree before C source
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20191230082856.30556-1-philmd@redhat.com>
 <4bf7c585-fe7f-c574-d706-2317e6bcbceb@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <404a7378-5ad4-1a5a-e280-551293cf970b@linaro.org>
Date: Tue, 21 Jan 2020 15:26:48 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <4bf7c585-fe7f-c574-d706-2317e6bcbceb@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
Cc: David Hildenbrand <david@redhat.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Stafford Horne <shorne@gmail.com>, Sven Schnelle <svens@stackframe.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/18/20 12:09 AM, Philippe Mathieu-Daudé wrote:
> Cc'ing qemu-trivial@
> 
> On 12/30/19 9:28 AM, Philippe Mathieu-Daudé wrote:
>> To avoid scrolling each instruction when reviewing tcg
>> helpers written for the decodetree script, display the
>> .decode files (similar to header declarations) before
>> the C source (implementation of previous declarations).
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Queued to tcg-next, since no one else has picked this up.


r~

