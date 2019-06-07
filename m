Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A9ACC2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 16:40:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 433082067C
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 16:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fsiY5JX9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 433082067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49496 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZHv2-0006eo-Fp
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 12:40:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53530)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hZGzX-0003br-MX
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 11:41:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hZGzQ-0005b5-22
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 11:41:17 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:37210)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hZGzP-000589-5m
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 11:41:11 -0400
Received: by mail-ot1-x344.google.com with SMTP id r10so2263367otd.4
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 08:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=2RsYTjikDIBllqjsxDpwLY3KS0OnVC5h3YmgliOmuto=;
 b=fsiY5JX9Ut9XKy4cclv4LIwIj932JLx85nSXOjwcM1UPbvMNT0SsozRq+dLGNW3pJj
 Il4B0vk0LCe7APLRZtfgWVcTuMTPh1MfdBpnKggvhtbwyBXKHYG8KVXQSFaBWgnOEk2n
 hw8Xa3alwCZRB5FEqHFyFctgo+EWW8uzoCM0C6z2/lotn7hNWqt1VIvZb3B5U4HVKV8j
 wrW9eCevaWgKdpbFRq8DKUGzYr5ogeiff7ZP6rYZcft+2c9lqvFPr+hBolaoAwC0mQto
 M8UAoD/ezvQ+/9JxzPpKYPACY1a+BLmM4Fo5V1ZFwI5Q7bh34x+f8RlYFoasWm0l5/4A
 spoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2RsYTjikDIBllqjsxDpwLY3KS0OnVC5h3YmgliOmuto=;
 b=EqTcXn4Uv/Vq1LTAF/JpWYuEqyxKkjN0SfqxBsbtC/j+Gp3ygvNxUATvGPPw1sjs2R
 4qPViR9bd+23+6ws9maGleq/vtbKLqXAgz5tJGclTQsaiB2Mr81Vr67r4ercBv+S/w38
 T8oXNB1MCUEFLWVFNjf7x0XZgIDTNkxpAfEtAmINQE0B7WY7SUCwuBy+9BnsDGaDbwvz
 UAj43hGLxb8qJFEz86ipEh1NssMw42KKc8GcBfLiFTwLBay3nBQnwemPQhicdAWEU8uv
 4ZGkHs5oocTAH7MePd8Ep4wEm1m+4s3rWMi38LMMA6VbbAkcjuGn9DUUK0caWnUgDLMn
 f2UQ==
X-Gm-Message-State: APjAAAXZD91ZmtUAe3+D2FSHGmd2GSKy2Rd+RoUsuJfdTaudmCxNPPo9
 b9jzHJo6SqZWgPmcsvdRcStf4QMVgBX2MA==
X-Google-Smtp-Source: APXvYqw0KfC54mJ0dJXUMGc4Fj7mMQ+Qewsq753+LUs4leK+7WqafK1wgE0YKYPVRqDzTJSDOomBMg==
X-Received: by 2002:a05:6830:1542:: with SMTP id
 l2mr19018062otp.241.1559922051276; 
 Fri, 07 Jun 2019 08:40:51 -0700 (PDT)
Received: from [192.168.3.43] (200-56-192-86-cable.cybercable.net.mx.
 [200.56.192.86])
 by smtp.gmail.com with ESMTPSA id r65sm835026oif.31.2019.06.07.08.40.50
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Jun 2019 08:40:50 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190603232209.20704-1-richard.henderson@linaro.org>
 <CAFEAcA-KZM8tzD6XLhbtxB=OrnvgmtjcknvxrYoVmooBb7grMw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <0a55f185-fb9f-335f-2342-9c214706a4d1@linaro.org>
Date: Fri, 7 Jun 2019 10:40:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-KZM8tzD6XLhbtxB=OrnvgmtjcknvxrYoVmooBb7grMw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH v2] target/arm: Vectorize USHL and SSHL
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/7/19 9:54 AM, Peter Maydell wrote:
> On Tue, 4 Jun 2019 at 00:22, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> These instructions shift left or right depending on the sign
>> of the input, and 7 bits are significant to the shift.  This
>> requires several masks and selects in addition to the actual
>> shifts to form the complete answer.
>>
>> That said, the operation is still a small improvement even for
>> two 64-bit elements -- 13 vector operations instead of 2 * 7
>> integer operations.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
> 
> Applied to target-arm.next, thanks.
> 
> NB: in v1 this series had a second patch. I'm assuming you
> dropped it deliberately -- if not, let me know.

Oops, no.  Can you please grab it with your r-b from v1?


r~

