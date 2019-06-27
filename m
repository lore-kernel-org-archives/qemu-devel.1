Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE41EC48BD7
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 10:55:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB40A2085A
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 10:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gjdhUdCe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB40A2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgS4B-0000s9-2b
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 06:55:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54710)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hgS2N-0007QK-Om
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 06:53:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hgS2L-0006RD-R5
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 06:53:55 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:33233)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hgS2L-0006OQ-IE
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 06:53:53 -0400
Received: by mail-wm1-x341.google.com with SMTP id h19so6781250wme.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2019 03:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:from:to:cc:references:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=MtbNoEzyfcsgmc66KoQQv5l3k648ftrVpb9fNoU2N9o=;
 b=gjdhUdCefoJaTA9OyDtJJc6fYszpRjRg2+3EqqaSs51PhKWO2feYg4EQwwwpdzlYhD
 1PgATSs3I8gHOA7uwJUfYZUqeoAbN6LQ6Ih9voAkn4NAHWkDFMACTShgpu+/s8dCiPHp
 Oi9UHz9G4ZLM+4hzgU1NeMGkaMB9SaFNnM4YCe1zEgmgwzl0vQocVQ7rIqJfqhsJr8YV
 nAFjMQokH6SHULNKkz2xo0aq927qo7CpQRvksrg8BM4GzaSG0mUkjW+rlgTuIsY+FyeS
 oQ+FULpu2qLdfvHlVrRVBjR7W1RoiUqCj9R446Hsem5Q+tUTSHFo8IPj0LLkAqxQd6e0
 PYsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MtbNoEzyfcsgmc66KoQQv5l3k648ftrVpb9fNoU2N9o=;
 b=jMKpBZjX7g3nIioSWS7CsNc/96mreMHvdfnJ7p7rR2FULXD+0bM3Onitb2FoqMSlqi
 IpW5eO6Jz4kJFJbrJ+TBPQ++CV23H1PnE56MzPgxO6fI4lj8rhHsYBKP8+xo6AvyTCmZ
 WzEtV9H5exGgvXWKWJRQ5oEEFpZnqM31lCRlr/+9eq632au9KMka/dvugrGhhG4QCMNV
 pmJsWxryuhKEQgkb6+y5FS+J6X/6Zf8NSFTC6ntGR9obtIDDmJ0QaiDYCC6SwSqeX6KH
 OnDDQyAHhD8qokUmrxINs9wgEHNoBY0/t98pHM+dcB1d6t+vyJ9wCsiYtXjcjm6BQGOG
 nAeA==
X-Gm-Message-State: APjAAAV2cykNK6vLzW8DK+P0f4Wt5H0abgGwRtopVkrdTHx167UTA/ld
 DBUYVqX/kSo/1UIfXnyZVioNzQ==
X-Google-Smtp-Source: APXvYqy9EW9tAOKihw3nPVrzW4gm0UqzuA0dXi2jDbWvwbnp2KQeUjFrymNIKCj5cm77bm6jKo8mkQ==
X-Received: by 2002:a7b:cae2:: with SMTP id t2mr2720819wml.157.1561632831699; 
 Thu, 27 Jun 2019 03:53:51 -0700 (PDT)
Received: from [192.168.2.137] (93-34-153-63.ip50.fastwebnet.it.
 [93.34.153.63])
 by smtp.gmail.com with ESMTPSA id y4sm3020881wrn.68.2019.06.27.03.53.50
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 27 Jun 2019 03:53:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: Jan Bobek <jan.bobek@gmail.com>, qemu-devel@nongnu.org
References: <20190619050447.22201-1-jan.bobek@gmail.com>
 <20190619050447.22201-5-jan.bobek@gmail.com>
 <f00e9c29-592e-06b2-04cd-b3c3c28b4cc0@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <22108aa6-4b85-8abf-9331-6f0a1284bee7@linaro.org>
Date: Thu, 27 Jun 2019 12:53:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <f00e9c29-592e-06b2-04cd-b3c3c28b4cc0@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] [RISU RFC PATCH v1 4/7] risugen_x86: add module
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

On 6/27/19 12:29 PM, Richard Henderson wrote:
> On 6/19/19 7:04 AM, Jan Bobek wrote:
>> +    --x86_64     : generate 64-bit (rather than 32-bit) x86 code.
> Better is to use
> 
> 	.mode	x86.64
> vs
> 	.mode	x86.32
> 
> or some such, like we do for aarch64.
> 

Nevermind.  Unlike aarch64, the same input file can be used for both 32-bit and
64-bit mode, more or less.


r~

