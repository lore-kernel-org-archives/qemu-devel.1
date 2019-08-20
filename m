Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6560AC3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 16:35:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3190322CE3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 16:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dwub0VIJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3190322CE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i076N-00068o-6B
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 12:35:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46158)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i075T-0005cw-CP
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 12:34:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i075S-00088f-8m
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 12:34:23 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:36126)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i075S-00087j-2e
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 12:34:22 -0400
Received: by mail-pl1-x643.google.com with SMTP id f19so2608852plr.3
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 09:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=oEbrwXqTk1zOUa32Or96uUF3IfzXUKK8OjQz21po6lE=;
 b=Dwub0VIJ84REu03BMtkb0NR8KouOzvWR9auwfY2nGh+8bswav1sz6s5BL9PoJtmDyL
 0d75bMsHQ0fFScXo3bQgCo51pFvmQrjgzRGOqjp+quvphraa/0fSb3ieTow6ujxbYm9I
 GALP83fB36J08hTkOCuJQydxtVZbX+f/HY8zMOOQvxxREcARN8Q0hjThTX7NDYFRUWBZ
 O3AVQPbEnZy3l1D8iUo1Ibh29VV7ObECg/2/FVis/CYFYsPwNdMY5CqbCARzs9Ml9nIo
 GKhIVgGVMrVk6361Je+JgpYM1aHOd5R38pdVRvLib6rq6wPZAkWxzRghSFKEwusOPYjt
 VOdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oEbrwXqTk1zOUa32Or96uUF3IfzXUKK8OjQz21po6lE=;
 b=oyLIA9PQVDZ4NWkAEcLFK0b3RQ1RWYA1zrhzJz0rGLu6inTcvWRano+Slg+94HF6KL
 ttx1slzMluNIUQhnabYU+3lmV/b6mAFR3IUqeo4Y4CKPJXvy2LrjQvWiHc9IrddmI18j
 FSAUBJDdqEgiVFbDJeNuumhaY8ctoWlmtv3SCkd7w7sGb8fAN6Co7Jz/FCGYj31fCfz1
 H6N5OLfbgLIpShyRtliIMwT3UCqITZh3kl5OoTJFXS/JsTmwaJRZUdFFayDmuTiYAtHB
 exZOrcJRQM/ObrgO6OlsYIBvnJdHfHYhX2YM9UDOAvaBT5BwI1meVM4hoV3l4x12KP8Z
 d8bQ==
X-Gm-Message-State: APjAAAWHWRJEoi4SaGy6T7zyfepM3MamFxLBcUvxoI+zmLaw4xKF6Alt
 XJJyZUACuBDNfKueEzEJ53Lf7w==
X-Google-Smtp-Source: APXvYqweW6m2wdyS4S8m+EiPY75uAQOcnWZbn80PfKzYm3fvy6F+gRTQ6kxu6iJc0q9rJTmE8AVjOA==
X-Received: by 2002:a17:902:4ac2:: with SMTP id
 q2mr26744888plh.81.1566318860980; 
 Tue, 20 Aug 2019 09:34:20 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id z16sm19417442pgi.8.2019.08.20.09.34.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 20 Aug 2019 09:34:20 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190803210803.5701-1-richard.henderson@linaro.org>
 <20190803210803.5701-7-richard.henderson@linaro.org>
 <CAFEAcA-cFi8BLBhh3vPdT4d=ps_pmP5gNz1W00mskVhhzN175w@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <88c745f9-b923-2303-18fe-4d5b855539ad@linaro.org>
Date: Tue, 20 Aug 2019 09:34:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-cFi8BLBhh3vPdT4d=ps_pmP5gNz1W00mskVhhzN175w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: Re: [Qemu-devel] [PATCH v7 6/6] tests/tcg/aarch64: Add bti smoke
 test
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Dave P Martin <Dave.Martin@arm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/20/19 8:31 AM, Peter Maydell wrote:
> Is there some way to suppress these warnings ? 'make check-tcg'
> output includes
> 
>   BUILD   TCG tests for aarch64-linux-user
>   BUILD   aarch64 guest-tests with aarch64-linux-gnu-gcc
> /usr/lib/gcc-cross/aarch64-linux-gnu/7/../../../../aarch64-linux-gnu/bin/ld:
> warning: /tmp/cccZ8Fk7.o: unsupported GNU_PROPERTY_TYPE (5) type:
> 0xc0000000
> /usr/lib/gcc-cross/aarch64-linux-gnu/7/../../../../aarch64-linux-gnu/bin/ld:
> warning: .note.gnu.build-id section discarded, --build-id ignored.
>   RUN     TCG tests for aarch64-linux-user
> 
> and these are going to come up in the merge-testing search
> for warnings in the build logs...

The only way is to use a newer ld.

Sadly, bfd doesn't really distinguish between warnings and errors when it comes
to printing, so there's no "-w" flag as for gcc.

I suppose we should just disable this test by default for now.  I'll note that
despite the warnings, you got a binary that runs as expected.



r~

