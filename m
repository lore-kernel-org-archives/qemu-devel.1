Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3185C31E44
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 21:08:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EE202080A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 21:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xGPpZrN0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EE202080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55420 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hao0j-0006ar-N8
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 17:08:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57890)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hanw5-0004Dr-On
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 17:04:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hant3-0005lC-I1
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 17:00:58 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:36206)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hant3-0005kE-7M
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 17:00:57 -0400
Received: by mail-pg1-x543.google.com with SMTP id f21so1614782pgi.3
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2019 14:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=3ol6qNxle7QepLG4kb8iG1QEL4SZZBXJEPBIqBTEFnc=;
 b=xGPpZrN0FlL6fq5nVpqngFAp2EihGmRAfjqosYs/ztz3xwSIgc8fiE7W8nm8QTVOwH
 VIY8VwaF/Jg4amq+ahsqIPVWDlNCSt3zCeqBfuLQJkGQBUjJ6rCREgBIEC8KrWTiSFV1
 fu9nK1tiE0SYRUI/ZZ4Gu0ryHDoM3wrPvMOq/HpTCkFOsO+XkIzTe55BCTXXqJ5gDzvH
 x02DXJybmY8d8dYmffXfgwJjj1V6e5eInawJrD08hw2tMSf80Qibz5H/XrNAY5FzuAEk
 mahOv7pyaolFoJ3Kx5MoQvnJxI4goN/0o6+jPMaUU01KGmLqqsV/upVgyVRLJOVsupsh
 zXnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3ol6qNxle7QepLG4kb8iG1QEL4SZZBXJEPBIqBTEFnc=;
 b=Q0QrGVGOgy+E8KW8U9VgLj6rVeY/XRvao7HoRTXiG1/QMIMZRaLkNyGWQ9O7PwHg9V
 xuiUl9mVsy8RQ1Exj1dw4gVGnHQS1R2Fh5vpm4sllJFM1V9k5PNuU0tW9kg6+axe4kED
 a7I4ZWZJoxiEs5ThYuK+KUgEw6JRUGjbF2q7OJZONdfRPByGQ5+7fFv/Tfkak23C17gu
 R8phtLN12DF/bQP9LlqFpWs8rfl4WUototpLb2kKulw57OJbswhViL5cFp+hBnqN1YdJ
 HDkU9SOnbDYFuLoVwcOxxzgIjHjySK/6yZoiBH4vlxbUuOw+sFOEmoHOOZH2NtLkZlbA
 BYtA==
X-Gm-Message-State: APjAAAW4RH0XyEWiuIqs1k3VNpclUVdu67mrO/iUJfeSd2utyFq2Bimt
 ETWgucHpxKC4IAiXZZcKTHqifg==
X-Google-Smtp-Source: APXvYqwIz5CtdGhs9ij2tVM/Igx1aCzvAhXDg657UOpuSr+eS79nazdaNMQ1CW8yZsG4HUW+492GaA==
X-Received: by 2002:a65:6541:: with SMTP id a1mr13192674pgw.409.1560286855572; 
 Tue, 11 Jun 2019 14:00:55 -0700 (PDT)
Received: from [192.168.1.11] (97-113-13-231.tukw.qwest.net. [97.113.13.231])
 by smtp.gmail.com with ESMTPSA id
 f16sm6623543pja.18.2019.06.11.14.00.54
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 11 Jun 2019 14:00:54 -0700 (PDT)
To: John Arbuckle <programmingkidx@gmail.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.orgd, david@gibson.dropbear.id.au,
 mark.cave-ayland@ilande.co.uk
References: <20190525022008.24788-1-programmingkidx@gmail.com>
 <20190525022008.24788-2-programmingkidx@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <808906c8-fa73-26f5-cead-3fa35ddb4497@linaro.org>
Date: Tue, 11 Jun 2019 14:00:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190525022008.24788-2-programmingkidx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: Re: [Qemu-devel] [PATCH 1/2] Implement Floating Point flag Fraction
 Rounded
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/24/19 7:20 PM, John Arbuckle wrote:
> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
> ---
>  fpu/softfloat.c               | 15 ++++++++++++---
>  include/fpu/softfloat-types.h |  1 +
>  2 files changed, 13 insertions(+), 3 deletions(-)

There are additional places that need changing within this file, even if we
consider only float32 and float64 and ignore floatx80 and float128.

That said, merely renaming this patch to

  "softfloat: Implement float_flag_rounded in round_canonical

  Add a new flag to indicate that, when inexact, the result has
  been rounded.  That is, when the LSB of the rounded result
  differs from the same bit of the infinite precision result."

is enough to get

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

For your usage within PowerPC, you will additionally need to modify round_to_int.


r~

