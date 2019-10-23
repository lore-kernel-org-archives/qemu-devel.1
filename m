Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DEF3CA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 16:37:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA2CD21872
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 16:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H6kM1rbh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA2CD21872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNJdq-0005Xf-Dg
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 12:37:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46971)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iNJGD-0007F5-0w
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 12:13:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iNJGB-0005oZ-Ml
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 12:13:20 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:41700)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iNJGB-0005oK-I8
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 12:13:19 -0400
Received: by mail-qt1-x844.google.com with SMTP id c17so30084401qtn.8
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 09:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=nrvAJTS/jezBLWvO+M8F8gQv267wMLuwRBhFnSGEFeM=;
 b=H6kM1rbhivP4l30+902GgNfOQQV06aLx3rfEcQUrn8aEcH0hmVUgMEPS8e9V+pipyg
 j/3aAddl/1EyoYMEJNfSBwXbuLgPI131z2nFXc8lolP4gHEFKNynJsJCg723iAi+GKPX
 o+3s5fT9PrJ+hyD6sS5ODt2IFxARWkaqluWGZniURp3tBMhY+HzuxrioSX6BpaOxrWn3
 T1JDHv26QH0FQg2tGnYvJVP/SEGDYQMC4dOkISUjDRZqy+/0FdiCWvyZzr3h3VcngkZo
 3kXu5Jq299aUm94grA6mcO/REahpsNudQKhKTdRkE/ThW9LlN1h2PlFqa9jpd2lgWFrk
 NuZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nrvAJTS/jezBLWvO+M8F8gQv267wMLuwRBhFnSGEFeM=;
 b=JziwqvdGNS6Q4fhPY039VaFxyHI+LAon/3eGW9JSlxOdbdDzXn8OkdoAggKIE+Mkit
 rU+fEUoghXUNT0EHLvtkqm+bRP5uW/83L1GhnQAXcU6g94rsT25uu2MifxLOMI4QIU6d
 sq2kJw+tkGqv4EmyTd0eLa8Heb3kvtZtE0F7ZFwYiUR2SLAfLTizWx65SPq7WjLID0yI
 4U/zKst8+qwxp3+eTwkz2ywjIHGGjjkyoX9K2krhQcX6HWJLVhxHn1FseJQfItD84hDX
 e/CXzi511nnmaLF2wZ2GTy6YHXpiAXlaVYKuk/w9E3KPVhRScdVN16VU7ZeWNL7IyFbD
 iIGA==
X-Gm-Message-State: APjAAAXT/CReONS4cSpnIKAY5yx56otbrlohQx5zNbjnYPKTdXqgQJxW
 jbB1oxBdLvmBQiNdPKRbW7lHBLlevJA=
X-Google-Smtp-Source: APXvYqy394SF9xkkWaG3lftyOqPnhFJh4yEDe9NZamGJd+2yUihx/Yt7DUAVisMG1ApRAR7mLgjMwA==
X-Received: by 2002:ac8:1408:: with SMTP id k8mr9854763qtj.327.1571847198500; 
 Wed, 23 Oct 2019 09:13:18 -0700 (PDT)
Received: from [172.20.87.163] (rrcs-172-254-253-50.nyc.biz.rr.com.
 [172.254.253.50])
 by smtp.gmail.com with ESMTPSA id c126sm12954799qkd.13.2019.10.23.09.13.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 23 Oct 2019 09:13:17 -0700 (PDT)
Subject: Re: [PATCH v8 00/22] target/arm: Reduce overhead of
 cpu_get_tb_cpu_state
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-arm@nongnu.org
References: <20191018174431.1784-1-richard.henderson@linaro.org>
 <CAFEAcA-MyKoA63UF6DYQ6J-dKihYn9iyG09eFCgWT8j4OqsQnw@mail.gmail.com>
 <CAFEAcA-Xj-6CdVzgfcVONipApD5b5PZ84nPnvbbOQjQkqQLnqA@mail.gmail.com>
 <6e06dede-2470-92e1-eba9-40646ed56af0@linaro.org> <87zhhrmqyh.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <3e366a5d-0de6-ff1d-7a0c-a40ef8a2bf98@linaro.org>
Date: Wed, 23 Oct 2019 12:13:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <87zhhrmqyh.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::844
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/23/19 11:17 AM, Alex Bennée wrote:
>>> Dropping this series again for the moment.
>> Argh!  I had forgotten that we have no testing of armeb in check-tcg.
> 
> Does it need it's own toolchain or can it be done with flags?

I think the compiler only needs flags, so we might be able to gin something up
for {aarch64_eb,armeb}-linux-user from __start.


r~

