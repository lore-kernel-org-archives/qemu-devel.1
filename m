Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A0BC32754
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 23:17:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF326214C6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 23:17:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF326214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1humEO-00065Z-5H
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 19:17:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56102)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1humDR-0005eX-FE
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 19:16:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1humDQ-0006zr-Ay
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 19:16:33 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33022)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1humDQ-0006zi-4N
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 19:16:32 -0400
Received: by mail-wm1-f65.google.com with SMTP id h19so7658085wme.0
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2019 16:16:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/GHMZNw79RqHUWUeUfcIWKrCAYgbf5iY8gvi2GeC5Fk=;
 b=EM9bX2VkinA/da66Yo4Q6yh9d3uv1PIubayoWlct1B1nurhTLWXrryY1/18TZlGoOZ
 Zuf4Ei4ZdMtZ6UfoDwgKMQRkBjwKibiaHn1bEzyiU0FKCg9cB1OLtlvoYjYeWPSnUIhB
 QD4iNcah2NUt4VcFidJ5YnQBCI5PtPQy7nq78NDZL10KY9EcJ89E0fnw8o1d311lu97t
 Vz3VJXmtpyhx69H+U+KU0LKdwQzHz5URjTMAFmxCowFp0pjjYshnYgIOxUHvduVbPW17
 ZsdaaScGoJZndAAOdKO3Va4ZnwgqMBnKClKW00TVZNE6O/aqtFp3KbHpMXvdxFnJkQcs
 tRXw==
X-Gm-Message-State: APjAAAUaO32Y1G/fmDps9vBITP1DmMJBqEd5+r2chuaYUXsMypXCZUk7
 YHal+46oZzYWPnlA/bnjsxm25A==
X-Google-Smtp-Source: APXvYqyC7d7zUHFdxpfPfdZzJAjoU9oyW3QG4DwSM1knwlDUMSn9m8SrslHHzVfl76624GhZO45elQ==
X-Received: by 2002:a1c:4803:: with SMTP id v3mr477417wma.49.1565046991000;
 Mon, 05 Aug 2019 16:16:31 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:dc26:ed70:9e4c:3810?
 ([2001:b07:6468:f312:dc26:ed70:9e4c:3810])
 by smtp.gmail.com with ESMTPSA id x185sm86353265wmg.46.2019.08.05.16.16.29
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 05 Aug 2019 16:16:30 -0700 (PDT)
To: Richard Henderson <rth@twiddle.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20190805180332.10185-1-peter.maydell@linaro.org>
 <d788f3ff-6814-117d-942d-7870b6201f30@twiddle.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <56162c59-9da9-d15a-a216-530c673b4592@redhat.com>
Date: Tue, 6 Aug 2019 01:16:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <d788f3ff-6814-117d-942d-7870b6201f30@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH] target/i386: Return 'indefinite integer
 value' for invalid SSE fp->int conversions
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/08/19 23:13, Richard Henderson wrote:
> On 8/5/19 11:03 AM, Peter Maydell wrote:
>> The x86 architecture requires that all conversions from floating
>> point to integer which raise the 'invalid' exception (infinities of
>> both signs, NaN, and all values which don't fit in the destination
>> integer) return what the x86 spec calls the "indefinite integer
>> value", which is 0x8000_0000 for 32-bits or 0x8000_0000_0000_0000 for
>> 64-bits.  The softfloat functions return the more usual behaviour of
>> positive overflows returning the maximum value that fits in the
>> destination integer format and negative overflows returning the
>> minimum value that fits.
>>
>> Wrap the softfloat functions in x86-specific versions which
>> detect the 'invalid' condition and return the indefinite integer.
>>
>> Note that we don't use these wrappers for the 3DNow! pf2id and pf2iw
>> instructions, which do return the minimum value that fits in
>> an int32 if the input float is a large negative number.
>>
>> Fixes: https://bugs.launchpad.net/qemu/+bug/1815423
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>> I've tested that this fixes the LP:1815423 test case. If anybody
>> has an x86 VM image to hand that has node.js installed it would
>> also be useful to test the operations in
>> https://bugs.launchpad.net/qemu/+bug/1832281
>> (I don't have such a VM.)
>>
>> The other approach here would be to make the softfloat functions be
>> flexible enough to allow this behaviour -- from my reading of IEEE754
>> I think the exact returned result for 'invalid' inputs for float to
>> int conversions is not specified.
>>
>>  target/i386/ops_sse.h | 88 +++++++++++++++++++++++++++++--------------
>>  1 file changed, 60 insertions(+), 28 deletions(-)
> 
> I guess this is exactly what we already do in fpu_helper.c.
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> 
> r~
> 

Queued, thanks.

Paolo

